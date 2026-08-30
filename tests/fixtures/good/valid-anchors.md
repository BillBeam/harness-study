---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
---

# Fixture: anchors that must resolve

Every reference below is real. `scripts/selftest.sh` asserts this file passes,
so it doubles as a worked example of the anchor syntax.

Short form, single line — the agent's outer loop is `src/minisweagent/agents/default.py:88`.

Short form, line range — the step/query/act cycle is
`src/minisweagent/agents/default.py:126-160`.

A top-level file resolves too: `pyproject.toml:1`.

Explicit form (repo and commit spelled out, so it works with no front matter):
`mini-swe-agent@25941c89cfbc91eb40b3f8756348c91d9977d57e:src/minisweagent/exceptions.py:9`.

Commit reference, short form — the pin itself is `25941c89cfbc91eb40b3f8756348c91d9977d57e`.

Commit reference, explicit form — cost tracking arrived in
`mini-swe-agent@af906e86`.

Things inside a fenced block are NOT anchors, so syntax examples are safe:

```
src/does/not/exist.py:99999
deadbeefdeadbeef
```

Prose in backticks that is not anchor-shaped is ignored: `run()`, `--help`,
`https://example.com/x`, `Submitted`.
