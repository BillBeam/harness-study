---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
---

A longer fence quoting a shorter one used to desync the scanner and swallow
the rest of the file, so a wrong anchor after it exited 0.

````
A fence starts with three backticks:
```
````

Broken on purpose: `src/minisweagent/agents/default.py:888888`.
