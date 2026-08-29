---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
---

A closing fence carries no info string, so the ```python line below must not
close the block. The wrong anchor after it has to be caught.

```
```python
```

Broken on purpose: `src/minisweagent/agents/default.py:888888`.
