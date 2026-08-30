# study/

每个钉住的目标仓库一个目录：`study/<repo>/`，名字与 `repos/pins.tsv` 的 `name` 列一致。

目录里一个主题一个 Markdown 文件，编号让阅读顺序一目了然：

```
study/mini-swe-agent/00-pin-demo.md
study/mini-swe-agent/01-control-flow.md
```

每个文件以 front matter 开头，写明它是对着哪个 pin 读的：

```markdown
---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
title: how a run terminates
---
```

`repo` 和 `commit` 会被 `make check` 校验；其余字段随意。

边读边写锚点，好让后来的读者能直接跳到代码，而不必重新推导它在哪：

```markdown
重试循环是 `src/minisweagent/models/litellm_model.py:82`。
```

完整的锚点语法见根目录 [`README.md`](../README.md)。
