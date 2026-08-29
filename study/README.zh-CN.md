# study/

> English: [README.md](README.md)

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

完整的锚点语法见根目录 [`README.zh-CN.md`](../README.zh-CN.md)。

## 中文与英文

中文版与英文版并列存放，文件名加 `.zh-CN` 后缀：

```
study/mini-swe-agent/00-pin-demo.md
study/mini-swe-agent/00-pin-demo.zh-CN.md
```

两者都会被 `make check` 扫描，锚点一视同仁。**这意味着中文版不是英文版的附属品**——它自己的锚点必须自己站得住，翻译时挪动了行号或写错了提交哈希，校验会直接失败。

中文版在 front matter 里加 `lang: zh-CN`，并在正文最前面放一行指向英文版的链接（英文版同样指回来）。
