# points/

> 中文：[README.zh-CN.md](README.zh-CN.md)

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

## Two things learned writing these

**A point is not a point until it compares.** A file covering one repository is
a reading note. The value starts compounding at the second and third column --
so the empty cells in `matrix.md` are not decoration on a todo list, they are
the shape of the work.

**Write claims that can be refuted.** An anchor proves you pointed at the right
place; it cannot prove you said the right thing. Every anchor in the first draft
of `points/001` resolved, while its central claim described the semantics that
the very commit it cited had *removed*. Ground a claim in specific behaviour --
a branch, the value of a role field, the difference either side of a commit --
rather than stopping at a restatement of the code's structure.

## Chinese and English

A translation sits beside its original with a `.zh-CN` suffix, carries
`lang: zh-CN` in its front matter, and is scanned by `make check` like any other
artifact.
