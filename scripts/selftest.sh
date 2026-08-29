#!/usr/bin/env bash
# Prove the anchor checker itself works.
#
# Two of these assertions are the acceptance criteria for the scaffold:
#   - an empty set of artifacts exits 0
#   - a deliberately wrong anchor exits non-zero
# The rest pin down one error code per failure mode, so a future change to the
# checker cannot quietly stop detecting one of them.
#
# Requires repos/ to be materialised: run `scripts/pin.sh sync` first.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CHECK=("python3" "$ROOT/scripts/check_anchors.py" "--root" "$ROOT")
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

pass=0; fail=0
ok()   { pass=$((pass+1)); printf '  ok   %s\n' "$1"; }
bad()  { fail=$((fail+1)); printf '  FAIL %s\n     %s\n' "$1" "$2"; }

# codes_of <exit-var-name> <args...> -> prints space-separated problem codes
run_case() { # run_case <label> <expected-exit> <expected-codes> <target...>
  local label="$1" want_exit="$2" want_codes="$3"; shift 3
  local out rc codes
  out="$("${CHECK[@]}" --json "$@" 2>/dev/null)"; rc=$?
  codes="$(printf '%s' "$out" | python3 -c \
    'import json,sys; d=json.load(sys.stdin); print(" ".join(p["code"] for p in d["problems"]) or "-")' 2>/dev/null)"
  if [ "$rc" != "$want_exit" ]; then
    bad "$label" "exit $rc, wanted $want_exit"
  elif [ "$codes" != "$want_codes" ]; then
    bad "$label" "codes [$codes], wanted [$want_codes]"
  else
    ok "$label"
  fi
}

echo "== acceptance =="
run_case "empty artifacts exit 0"          0 "-" "$ROOT/tests/fixtures/empty"
run_case "wrong anchor exits non-zero"     1 "line-out-of-range" "$ROOT/tests/fixtures/bad"
run_case "valid anchors exit 0"            0 "-" "$ROOT/tests/fixtures/good"

echo "== failure-mode matrix =="
while IFS=$'\t' read -r file want_exit want_codes; do
  case "$file" in ''|\#*) continue ;; esac
  [ -f "$ROOT/tests/cases/$file" ] || { bad "$file" "case file missing"; continue; }
  [ "$want_codes" = "-" ] || true
  run_case "$file" "$want_exit" "$want_codes" "$ROOT/tests/cases/$file"
done < "$ROOT/tests/cases/EXPECTED.tsv"

echo "== generated cases =="

# not-ancestor: a commit that is in the clone but unreachable from the pin.
CLONE="$ROOT/repos/mini-swe-agent"
PIN="$(awk -F'\t' '$1=="mini-swe-agent"{print $3}' "$ROOT/repos/pins.tsv")"
if [ -d "$CLONE/.git" ] && [ -n "$PIN" ]; then
  OUTSIDE="$(git -C "$CLONE" for-each-ref --format='%(objectname)' refs/remotes/ \
    | while read -r s; do
        git -C "$CLONE" merge-base --is-ancestor "$s" "$PIN" 2>/dev/null || { echo "$s"; break; }
      done)"
  if [ -n "$OUTSIDE" ]; then
    printf '# outside the pinned history\n\n`mini-swe-agent@%s:README.md:1`\n' "$OUTSIDE" \
      > "$TMP/not-ancestor.md"
    run_case "not-ancestor" 1 "not-ancestor" "$TMP/not-ancestor.md"
  else
    printf '  skip not-ancestor (no ref outside the pinned history in this clone)\n'
  fi
else
  printf '  skip not-ancestor (repos/mini-swe-agent not materialised)\n'
fi

# repo-absent: a pin that has never been synced.
printf 'zz-absent\thttps://example.invalid/zz\t%040d\tnot materialised\n' 0 > "$TMP/pins.tsv"
printf '# absent\n\n`zz-absent@%040d:README.md:1`\n' 0 > "$TMP/repo-absent.md"
out="$(python3 "$ROOT/scripts/check_anchors.py" --root "$ROOT" --pins "$TMP/pins.tsv" \
        --json "$TMP/repo-absent.md" 2>/dev/null)"; rc=$?
codes="$(printf '%s' "$out" | python3 -c \
  'import json,sys; print(" ".join(p["code"] for p in json.load(sys.stdin)["problems"]) or "-")' 2>/dev/null)"
if [ "$rc" = 1 ] && [ "$codes" = "repo-absent" ]; then ok "repo-absent"
else bad "repo-absent" "exit $rc codes [$codes], wanted exit 1 codes [repo-absent]"; fi

echo "== pins =="
if "$ROOT/scripts/pin.sh" status >/dev/null 2>&1; then ok "pin.sh status clean"
else bad "pin.sh status clean" "run 'scripts/pin.sh sync'"; fi

echo
printf 'selftest: %d passed, %d failed\n' "$pass" "$fail"
[ "$fail" -eq 0 ]
