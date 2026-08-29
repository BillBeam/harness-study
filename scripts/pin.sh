#!/usr/bin/env bash
# Pin, materialize and inspect target repositories.
#
# A "pin" is a (name, url, commit) record in repos/pins.tsv. `sync` materializes
# each pin as a FULL clone under repos/<name>/ with HEAD detached at the pinned
# commit. Full history is the point: study notes need `git log -S`, `git log -L`
# and `git blame` to answer "which commit introduced this logic?" offline.
#
# Usage:
#   scripts/pin.sh sync [name ...]        materialize pins (default: all)
#   scripts/pin.sh status [name ...]      show pinned vs. on-disk state
#   scripts/pin.sh add <name> <url> [ref] add a pin, resolving ref (default HEAD) to a SHA
#   scripts/pin.sh update <name> <ref>    move an existing pin to a new commit
#   scripts/pin.sh path <name>            print the checkout path
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PINS="$ROOT/repos/pins.tsv"

die() { printf 'pin: %s\n' "$*" >&2; exit 1; }
info() { printf '%s\n' "$*" >&2; }

[ -f "$PINS" ] || die "missing $PINS"

# Emit "name<TAB>url<TAB>commit<TAB>note" for each pin, optionally filtered by name.
read_pins() {
  local want=("$@")
  awk -v FS='\t' -v OFS='\t' '
    /^[[:space:]]*(#|$)/ { next }
    {
      if (NF < 3) { printf("pin: malformed record on line %d of %s\n", NR, FILENAME) > "/dev/stderr"; bad=1; next }
      if ($3 !~ /^[0-9a-f]{40}$/) { printf("pin: line %d: commit %s is not a full 40-hex SHA\n", NR, $3) > "/dev/stderr"; bad=1; next }
      print $1, $2, $3, ($4 == "" ? "-" : $4)
    }
    END { if (bad) exit 1 }
  ' "$PINS" | {
    if [ ${#want[@]} -eq 0 ]; then cat; else
      local re; re="^($(IFS='|'; echo "${want[*]}"))	"
      grep -E "$re" || true
    fi
  }
}

pin_field() { # pin_field <name> <1|2|3|4>
  read_pins "$1" | cut -f"$2" | head -1
}

cmd_path() {
  [ $# -eq 1 ] || die "usage: pin.sh path <name>"
  read_pins "$1" | grep -q . || die "no such pin: $1"
  printf '%s\n' "$ROOT/repos/$1"
}

cmd_sync() {
  local any=0 rc=0
  while IFS=$'\t' read -r name url commit note; do
    [ -n "${name:-}" ] || continue
    any=1
    local dir="$ROOT/repos/$name"
    if [ ! -d "$dir/.git" ]; then
      info "==> $name: cloning $url (full history)"
      rm -rf "$dir"
      # No --depth and no --filter: a shallow or blob-less clone cannot answer
      # `git log -S` offline, which is the whole reason we keep the history.
      if ! git clone --no-checkout "$url" "$dir"; then
        info "!!! $name: clone failed"; rc=1; continue
      fi
    fi
    if ! git -C "$dir" cat-file -e "${commit}^{commit}" 2>/dev/null; then
      info "==> $name: fetching (pinned commit $commit not present)"
      git -C "$dir" fetch --tags origin || { info "!!! $name: fetch failed"; rc=1; continue; }
    fi
    if ! git -C "$dir" cat-file -e "${commit}^{commit}" 2>/dev/null; then
      info "!!! $name: pinned commit $commit not found after fetch"; rc=1; continue
    fi
    git -C "$dir" checkout -q --detach "$commit" || { info "!!! $name: checkout failed"; rc=1; continue; }
    info "==> $name: at $commit ($(git -C "$dir" rev-list --count "$commit") commits of history)"
  done < <(read_pins "$@")
  [ "$any" -eq 1 ] || info "pin: no pins matched"
  return $rc
}

cmd_status() {
  printf '%-20s %-12s %-10s %s\n' NAME PINNED STATE NOTE
  local rc=0 seen=0
  while IFS=$'\t' read -r name url commit note; do
    [ -n "${name:-}" ] || continue
    local dir="$ROOT/repos/$name" state
    if [ ! -d "$dir/.git" ]; then
      state="absent"; rc=1
    elif ! git -C "$dir" cat-file -e "${commit}^{commit}" 2>/dev/null; then
      state="missing"; rc=1
    elif [ "$(git -C "$dir" rev-parse HEAD)" != "$commit" ]; then
      state="drifted"; rc=1
    else
      state="ok"
    fi
    printf '%-20s %-12s %-10s %s\n' "$name" "${commit:0:12}" "$state" "$note"
    seen=1
  done < <(read_pins "$@")
  if [ "$seen" -eq 0 ]; then info "pin: no pins matched${*:+: $*}"; rc=1; fi
  return $rc
}

cmd_add() {
  [ $# -ge 2 ] || die "usage: pin.sh add <name> <url> [ref]"
  local name="$1" url="$2" ref="${3:-HEAD}"
  case "$name" in *[!A-Za-z0-9._-]*) die "name must match [A-Za-z0-9._-]+" ;; esac
  read_pins "$name" | grep -q . && die "pin already exists: $name (use 'update')"
  local sha
  sha="$(git ls-remote "$url" "$ref" | awk 'NR==1{print $1}')"
  [ -n "$sha" ] || sha="$(git ls-remote "$url" | awk -v r="$ref" '$2=="HEAD"||$2=="refs/heads/"r{print $1; exit}')"
  [ -n "$sha" ] || die "could not resolve ref '$ref' at $url"
  printf '%s\t%s\t%s\t%s\n' "$name" "$url" "$sha" "pinned from $ref" >> "$PINS"
  info "==> pinned $name at $sha"
  cmd_sync "$name"
}

cmd_update() {
  [ $# -eq 2 ] || die "usage: pin.sh update <name> <ref>"
  local name="$1" ref="$2" url old sha
  url="$(pin_field "$name" 2)"; old="$(pin_field "$name" 3)"
  [ -n "$url" ] || die "no such pin: $name"
  sha="$(git ls-remote "$url" "$ref" | awk 'NR==1{print $1}')"
  [ -n "$sha" ] || die "could not resolve ref '$ref' at $url"
  [ "$sha" = "$old" ] && { info "==> $name already at $sha"; return 0; }
  # Rewrite only the commit column of this record.
  awk -v FS='\t' -v OFS='\t' -v n="$name" -v s="$sha" \
    '$1==n && $0 !~ /^[[:space:]]*#/ { $3=s } { print }' "$PINS" > "$PINS.tmp"
  mv "$PINS.tmp" "$PINS"
  info "==> $name: $old -> $sha"
  info "    re-run 'make check' — anchors pinned to the old commit will now fail"
  cmd_sync "$name"
}

case "${1:-}" in
  sync)   shift; cmd_sync "$@" ;;
  status) shift; cmd_status "$@" ;;
  add)    shift; cmd_add "$@" ;;
  update) shift; cmd_update "$@" ;;
  path)   shift; cmd_path "$@" ;;
  ""|-h|--help|help) awk 'NR>1 && /^#/ { sub(/^# ?/, ""); print; next } NR>1 { exit }' "${BASH_SOURCE[0]}" ;;
  *) die "unknown command: $1 (try --help)" ;;
esac
