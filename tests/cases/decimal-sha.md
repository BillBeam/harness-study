---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
---

About 2% of abbreviated SHAs are all decimal, so an all-digit token cannot be
excluded by shape without silently dropping real commit references. It is
resolved against the clone instead: a plain number is ignored, a real SHA is
verified like any other.

Ignored, not commits: `1735689600` (a unix timestamp), `128000` (too short anyway).

A genuine all-digit abbreviated SHA in this repo's history, fully checked: `96546112`.
