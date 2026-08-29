# Log

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

Carried forward: points 002–005 in `matrix.md` are unread.
