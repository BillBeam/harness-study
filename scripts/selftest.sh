#!/usr/bin/env bash
# Prove the anchor checker itself works.
#
# Two of these assertions are the acceptance criteria for the scaffold:
#   - an empty set of artifacts exits 0
#   - a deliberately wrong anchor exits non-zero
# The rest pin down one error code per failure mode, so a future change to the
# checker cannot quietly stop detecting one of them.
#
# Every assertion is written to FAIL LOUDLY rather than skip. A skipped check
# that reports nothing is the same defect the checker itself exists to prevent.
#
# Requires repos/ to be materialised: run `make sync` first.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHECK="$ROOT/scripts/check_anchors.py"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

pass=0; fail=0
ok()  { pass=$((pass+1)); printf '  ok   %s\n' "$1"; }
bad() { fail=$((fail+1)); printf '  FAIL %s\n     %s\n' "$1" "$2"; }

# ---------------------------------------------------------------------------
# Preconditions. Without a materialised pin every case fails for the same
# uninteresting reason, which would drown the real signal and, worse, report a
# passing acceptance criterion as a failure.
# ---------------------------------------------------------------------------
missing=""
while IFS=$'\t' read -r name url commit note; do
  case "$name" in ''|\#*) continue ;; esac
  dir="$ROOT/repos/$name"
  if [ ! -d "$dir/.git" ]; then
    missing="$missing\n  repos/$name is not materialised"
  elif ! git -C "$dir" cat-file -e "${commit}^{commit}" 2>/dev/null; then
    missing="$missing\n  repos/$name does not contain its pinned commit ${commit:0:12}"
  fi
done < "$ROOT/repos/pins.tsv"
if [ -n "$missing" ]; then
  printf 'selftest: cannot run —%b\n\nRun `make sync` first.\n' "$missing" >&2
  exit 2
fi

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

# run_case <label> <want-exit> <want-codes> <want-counts|-> <target...>
#   want-codes  : space-separated problem codes in order, or "-" for none
#   want-counts : e.g. "files=2 anchors=2" or "files>=5 anchors>=20", or "-"
run_case() {
  local label="$1" want_exit="$2" want_codes="$3" want_counts="$4"; shift 4
  local out rc got
  out="$(python3 "$CHECK" --root "$ROOT" --json "$@" 2>/dev/null)"; rc=$?
  if [ "$rc" != "$want_exit" ]; then
    bad "$label" "exit $rc, wanted $want_exit"; return
  fi
  got="$(printf '%s' "$out" | WANT="$want_counts" python3 -c '
import json, os, sys
try:
    d = json.load(sys.stdin)
except Exception as e:
    print("BADJSON " + str(e)); raise SystemExit
codes = " ".join(p["code"] for p in d["problems"]) or "-"
want = os.environ["WANT"]
if want != "-":
    for term in want.split():
        key, op, val = (term.partition(">=") if ">=" in term else term.partition("="))
        actual, val = d[key], int(val)
        if (actual < val) if op == ">=" else (actual != val):
            print("COUNTS %s is %d, wanted %s%s" % (key, actual, op, val)); raise SystemExit
print(codes)
' 2>/dev/null)"
  case "$got" in
    BADJSON*|COUNTS*) bad "$label" "${got:-no JSON on stdout}" ;;
    "$want_codes")    ok "$label" ;;
    "")               bad "$label" "no JSON on stdout (checker crashed?)" ;;
    *)                bad "$label" "codes [$got], wanted [$want_codes]" ;;
  esac
}

# run_raw <label> <want-exit> <target...> -- the plain command a human runs.
# run_case goes through --json; without this the ordinary exit-code path and its
# human-readable report would never be executed by the tests at all.
run_raw() {
  local label="$1" want_exit="$2"; shift 2
  python3 "$CHECK" --root "$ROOT" "$@" >/dev/null 2>&1
  local rc=$?
  [ "$rc" = "$want_exit" ] && ok "$label" || bad "$label" "exit $rc, wanted $want_exit"
}

# ---------------------------------------------------------------------------
echo "== acceptance (the criteria this scaffold is measured against) =="
run_raw  "empty artifacts exit 0"        0 "$ROOT/tests/fixtures/empty"
run_raw  "wrong anchor exits non-zero"   1 "$ROOT/tests/fixtures/bad"
run_case "empty artifacts, no problems"  0 "-"                 "files=0 anchors=0" "$ROOT/tests/fixtures/empty"
run_case "wrong anchor is out of range"  1 "line-out-of-range" "-"                 "$ROOT/tests/fixtures/bad"
run_case "valid anchors exit 0"          0 "-"                 "-"                 "$ROOT/tests/fixtures/good"

echo "== the real default run =="
# Pins DEFAULT_TARGETS: emptying it, or narrowing the scan, drops these counts.
run_case "default targets are scanned"   0 "-" "files>=5 anchors>=20"
run_raw  "make check path exits 0"       0

# A default target that does not exist yet is deliberately not an error -- study/
# and points/ may not exist on a fresh checkout. That tolerance also means a
# *dead* entry (a file that was renamed or deleted) sits in the list forever,
# scanning nothing and reporting nothing. So lint the list itself: every
# root-level file named in DEFAULT_TARGETS has to be a file that exists.
# Directories stay exempt, since those are the ones allowed to appear later.
dead="$(python3 -c '
import sys
from pathlib import Path
sys.path.insert(0, "'"$ROOT"'/scripts")
import check_anchors
root = Path("'"$ROOT"'")
print(" ".join(t for t in check_anchors.DEFAULT_TARGETS
                if not (root / t).is_dir() and not (root / t).is_file()))
' 2>/dev/null)"
if [ -z "$dead" ]; then ok "DEFAULT_TARGETS has no dead entries"
else bad "DEFAULT_TARGETS has no dead entries" "these are named but do not exist: $dead"; fi

echo "== recursion and aggregation =="
run_case "nested dirs, counts aggregate" 0 "-" "files=2 anchors=2" "$ROOT/tests/fixtures/tree"

echo "== failure-mode matrix =="
# `|| [ -n "$file" ]` keeps the last record when the file has no trailing
# newline -- otherwise a dropped row would silently remove a failure mode.
declare -a listed=()
while IFS=$'\t' read -r file want_exit want_codes want_counts || [ -n "$file" ]; do
  case "$file" in ''|\#*) continue ;; esac
  listed+=("$file")
  # A row may name a directory when the case is about how two files relate.
  if [ ! -e "$ROOT/tests/cases/$file" ]; then
    bad "$file" "listed in EXPECTED.tsv but the case file is missing"; continue
  fi
  run_case "$file" "$want_exit" "$want_codes" "${want_counts:--}" "$ROOT/tests/cases/$file"
done < "$ROOT/tests/cases/EXPECTED.tsv"

# Close the loop the other way: a case file nobody asserts is dead weight, and
# an unasserted case is how a failure mode quietly stops being covered.
for f in "$ROOT"/tests/cases/*.md; do
  base="$(basename "$f")"
  found=0
  for l in ${listed+"${listed[@]}"}; do [ "$l" = "$base" ] && found=1 && break; done
  [ "$found" = 1 ] || bad "$base" "case file exists but no row in EXPECTED.tsv asserts it"
done
[ ${#listed[@]} -gt 0 ] && ok "EXPECTED.tsv and tests/cases/ agree (${#listed[@]} rows)"

echo "== generated cases =="

# not-ancestor: a commit that exists but is unreachable from the pin.
# Built deterministically rather than discovered among remote refs -- a
# discovered input can vanish upstream and turn this assertion into a silent
# skip. --shared makes the throwaway clone nearly free, and the new commit is
# written there, never into the pinned target repository.
PIN="$(awk -F'\t' '$1=="mini-swe-agent"{print $3}' "$ROOT/repos/pins.tsv")"
mkdir -p "$TMP/na/repos"
cp "$ROOT/repos/pins.tsv" "$TMP/na/repos/pins.tsv"
if git clone -q --shared --no-checkout "$ROOT/repos/mini-swe-agent" \
       "$TMP/na/repos/mini-swe-agent" 2>/dev/null; then
  OUTSIDE="$(GIT_AUTHOR_NAME=t GIT_AUTHOR_EMAIL=t@t \
             GIT_COMMITTER_NAME=t GIT_COMMITTER_EMAIL=t@t \
             git -C "$TMP/na/repos/mini-swe-agent" commit-tree "${PIN}^{tree}" -m outside)"
  printf '# outside the pinned history\n\n`mini-swe-agent@%s:README.md:1`\n' "$OUTSIDE" \
    > "$TMP/na/case.md"
  out="$(python3 "$CHECK" --root "$TMP/na" --json "$TMP/na/case.md" 2>/dev/null)"; rc=$?
  codes="$(printf '%s' "$out" | python3 -c \
    'import json,sys; print(" ".join(p["code"] for p in json.load(sys.stdin)["problems"]) or "-")' 2>/dev/null)"
  if [ "$rc" = 1 ] && [ "$codes" = "not-ancestor" ]; then ok "not-ancestor"
  else bad "not-ancestor" "exit $rc codes [$codes], wanted exit 1 codes [not-ancestor]"; fi

  # The same commit, written as a clickable link. The ancestry rule has to hold
  # whichever form the anchor is in; if only the `repo@sha:` form were checked,
  # a link could quietly point outside the pinned history.
  printf '# outside the pinned history, as a link\n\n[README.md:1](https://github.com/SWE-agent/mini-swe-agent/blob/%s/README.md#L1)\n' \
    "$OUTSIDE" > "$TMP/na/link.md"
  out="$(python3 "$CHECK" --root "$TMP/na" --json "$TMP/na/link.md" 2>/dev/null)"; rc=$?
  codes="$(printf '%s' "$out" | python3 -c \
    'import json,sys; print(" ".join(p["code"] for p in json.load(sys.stdin)["problems"]) or "-")' 2>/dev/null)"
  if [ "$rc" = 1 ] && [ "$codes" = "not-ancestor" ]; then ok "link form: not-ancestor"
  else bad "link form: not-ancestor" "exit $rc codes [$codes], wanted exit 1 codes [not-ancestor]"; fi
else
  bad "not-ancestor" "could not create the throwaway clone"
  bad "link form: not-ancestor" "could not create the throwaway clone"
fi

# ambiguous-repo: a link names `owner/repo`, not a pin, so two pins tracking the
# same upstream leave it undecidable. Needs a second pin, hence a generated case.
printf 'a\thttps://github.com/SWE-agent/mini-swe-agent\t%s\tfirst\nb\thttps://github.com/SWE-agent/mini-swe-agent.git\t%s\tsecond\n' \
  "$PIN" "$PIN" > "$TMP/ambig-pins.tsv"
printf '# two pins, one upstream\n\n[README.md:1](https://github.com/SWE-agent/mini-swe-agent/blob/%s/README.md#L1)\n' \
  "$PIN" > "$TMP/ambiguous.md"
out="$(python3 "$CHECK" --root "$ROOT" --pins "$TMP/ambig-pins.tsv" --json "$TMP/ambiguous.md" 2>/dev/null)"; rc=$?
codes="$(printf '%s' "$out" | python3 -c \
  'import json,sys; print(" ".join(p["code"] for p in json.load(sys.stdin)["problems"]) or "-")' 2>/dev/null)"
if [ "$rc" = 1 ] && [ "$codes" = "ambiguous-repo" ]; then ok "link form: ambiguous-repo"
else bad "link form: ambiguous-repo" "exit $rc codes [$codes], wanted exit 1 codes [ambiguous-repo]"; fi

# The upstream url is matched by which repository it names, not by how it is
# spelled: ssh, git+https and a trailing .git all have to reach the same pin, or
# a link would fail for a reason that has nothing to do with the code it cites.
for spelling in 'git@github.com:SWE-agent/mini-swe-agent.git' \
                'ssh://git@github.com/SWE-agent/mini-swe-agent' \
                'https://github.com/swe-agent/MINI-SWE-AGENT/'; do
  printf 'mini-swe-agent\t%s\t%s\tspelling fixture\n' "$spelling" "$PIN" > "$TMP/spell-pins.tsv"
  out="$(python3 "$CHECK" --root "$ROOT" --pins "$TMP/spell-pins.tsv" --json \
         "$ROOT/tests/cases/link-ok.md" 2>/dev/null)"; rc=$?
  if [ "$rc" = 0 ]; then ok "link form: upstream url spelled as $spelling"
  else bad "link form: upstream url spelled as $spelling" "exit $rc, wanted 0"; fi
done

# repo-absent: a pin that has never been synced.
printf 'zz-absent\thttps://example.invalid/zz\t%040d\tnot materialised\n' 0 > "$TMP/pins.tsv"
printf '# absent\n\n`zz-absent@%040d:README.md:1`\n' 0 > "$TMP/repo-absent.md"
out="$(python3 "$CHECK" --root "$ROOT" --pins "$TMP/pins.tsv" --json "$TMP/repo-absent.md" 2>/dev/null)"; rc=$?
codes="$(printf '%s' "$out" | python3 -c \
  'import json,sys; print(" ".join(p["code"] for p in json.load(sys.stdin)["problems"]) or "-")' 2>/dev/null)"
if [ "$rc" = 1 ] && [ "$codes" = "repo-absent" ]; then ok "repo-absent"
else bad "repo-absent" "exit $rc codes [$codes], wanted exit 1 codes [repo-absent]"; fi

echo "== configuration errors exit 2, not 1 =="
run_raw "missing pins file exits 2" 2 --pins "$TMP/does-not-exist.tsv"
printf 'broken-row-without-tabs\n' > "$TMP/bad-pins.tsv"
run_raw "malformed pin exits 2"    2 --pins "$TMP/bad-pins.tsv"
run_raw "no such target exits 2"   2 "$TMP/nope-not-here.md"

echo "== pins =="
if "$ROOT/scripts/pin.sh" status >/dev/null 2>&1; then ok "pin.sh status clean"
else bad "pin.sh status clean" "run 'make sync'"; fi

# A pin name may legally contain '.', which is a regex metacharacter, so
# filtering by name has to be a literal comparison. Both directions are asserted
# here: the filter used to join the wanted names into an alternation regex, which
# answered `a.b` with the pin `a-b`, and a filter that matched nothing at all
# would sail through a one-directional test.
mkdir -p "$TMP/lit/scripts" "$TMP/lit/repos"
cp "$ROOT/scripts/pin.sh" "$TMP/lit/scripts/pin.sh"
printf 'a-b\thttps://example.invalid/a-b\t%040d\tliteral-match fixture\n' 0 > "$TMP/lit/repos/pins.tsv"
miss="$(bash "$TMP/lit/scripts/pin.sh" status 'a.b' 2>&1)"
hit="$(bash "$TMP/lit/scripts/pin.sh" status 'a-b' 2>&1)"
if printf '%s' "$miss" | grep -q 'a-b'; then
  bad "pin.sh matches pin names literally" "status 'a.b' matched the pin 'a-b'"
elif ! printf '%s' "$hit" | grep -q 'a-b'; then
  bad "pin.sh matches pin names literally" "status 'a-b' did not match the pin 'a-b'"
else
  ok "pin.sh matches pin names literally"
fi

echo
printf 'selftest: %d passed, %d failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]
