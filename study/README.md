# study/

One directory per pinned target repository: `study/<repo>/`, matching the `name`
column of `repos/pins.tsv`.

Inside, one Markdown file per topic, numbered so the reading order is obvious:

```
study/mini-swe-agent/00-pin-demo.md
study/mini-swe-agent/01-control-flow.md
```

Every file starts with front matter naming the pin it was read against:

```markdown
---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
title: how a run terminates
---
```

`repo` and `commit` are checked by `make check`; anything else is free.

Write anchors as you read, so a later reader can jump straight to the code
instead of re-deriving where it lives:

```markdown
The retry loop is `src/minisweagent/models/litellm_model.py:82`.
```

The full anchor syntax is documented in the root `README.md`.
