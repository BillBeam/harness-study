# points/

One file per **technical point**: an idea worth understanding on its own, which
usually shows up in more than one harness. `study/` is organised by repository;
`points/` is organised by idea, and the two cross-reference each other through
`matrix.md`.

```
points/001-control-flow-via-exceptions.md
points/002-<next idea>.md
```

A point file compares how different repositories solve the same problem, so it
generally has no single pinned repository in front matter. Use the explicit
anchor form, which names its own repository and commit:

```markdown
`mini-swe-agent@25941c89cfbc91eb40b3f8756348c91d9977d57e:src/minisweagent/exceptions.py:4`
```

A point should say what the problem is, how each repository answers it, and what
the trade-off is — not just where the code lives.
