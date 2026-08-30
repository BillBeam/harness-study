# Log

> 中文：[LOG.zh-CN.md](LOG.zh-CN.md)

Newest first. One entry per session: what was pinned or read, and what came out
of it.

## 2026-08-29 — card 00, scaffold

Built the repository skeleton and the mechanism the rest of it depends on.

- Directory conventions: `repos/` for pinned targets, `study/<repo>/` for
  per-repository artifacts, `points/` for technical points, `scripts/` for
  tooling, plus `matrix.md` and this log.
- Anchor checking: `scripts/check_anchors.py` reads `path:line` references and
  commit hashes out of the artifacts and proves each one resolves at the commit
  its target repository is pinned to. `make check` is the one command.
- Pinning: `repos/pins.tsv` plus `scripts/pin.sh`. Full clones, `HEAD` detached
  at the pinned commit, history retained on purpose — see `repos/README.md`.
- Demonstrated the pin with mini-swe-agent at
  `mini-swe-agent@25941c89cfbc91eb40b3f8756348c91d9977d57e` — 1020 commits
  reachable from the pin, 1489 across all refs in the clone. Confirmed that
  `git log -S`, `git log -L` and `git blame` all answer offline against the
  clone, including across the `microsweagent` → `minisweagent` rename.
- Seeded `study/mini-swe-agent/00-pin-demo.md` (15 verified anchors) and
  `points/001-control-flow-via-exceptions.md` so the conventions have a worked
  example rather than only a specification.

Then ran an adversarial review over the scaffold — six dimensions, each finding
independently re-derived by a skeptic told to refute it. 18 findings survived.
The two that mattered:

- **The checker could fail open.** Fence tracking normalised every opening fence
  to three characters, so a longer fence quoting a shorter one — the ordinary
  way to write about fence syntax, and unavoidable when the subject is a harness
  whose action protocol *is* a fenced block — desynced the scanner and swallowed
  the rest of the file. A deliberately wrong anchor after that point exited 0.
  Fixed by tracking the opener verbatim, plus a backstop: an unclosed fence is
  now reported rather than silently skipping to EOF.
- **The prose was wrong while every anchor resolved.** `points/001` claimed a
  raise site decides that a run stops. It does not: it decides only what the
  transcript records, and 6 of 15 control-flow raise sites carry `role: "user"`
  and do not stop anything. Worse, the note asserted the semantics that
  `mini-swe-agent@10dfc4ea` — the commit it cites as the reversal — removed.
  Rewritten, and the limitation is now stated in the README: an anchor proves a
  location, never a claim.

Also fixed: `pin.sh` recorded an annotated tag's tag object instead of its
commit (permanent phantom "drifted"), and silently pinned the remote's HEAD when
a ref failed to resolve — both silent wrong-pin bugs in a tool whose only job is
pinning. The selftest grew from 15 assertions to 31 and now asserts *how much*
was scanned, not just the codes; 10 of 10 deliberate mutations of the checker
are caught, where the count-blind version missed one.

Carried forward: points 002–005 in `matrix.md` are unread.
