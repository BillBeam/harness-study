---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
---

# Fixture: a deliberately wrong anchor

`scripts/selftest.sh` asserts that checking this file FAILS. It is the negative
control for the anchor checker: if this file ever passes, the checker is broken.

The file below really exists at the pinned commit, but it has 190 lines, so
line 9999 cannot resolve: `src/minisweagent/agents/default.py:9999`.
