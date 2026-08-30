# harness-study

> English: [README.md](README.md)

一个用来细读别人 agent harness 的学习仓库。

它解决的问题是：**关于代码的笔记会悄悄失效**。你写下"重试循环在 `models/litellm_model.py:82`"，上游继续演进，一年后那个行号指向的是一条 import。这个仓库让这种失效变得**响亮**——每一条代码引用都对着目标仓库的一个钉住提交校验，而校验只需一条命令。

```
make check
```

这就是那一条命令。`study/` 和 `points/` 里每条锚点都解析成功时退 0，否则退非 0，并给出**笔记自己的 `文件:行号`**。（全新 clone 上先跑一次 `make sync` materialize 被钉住的仓库；忘了的话 `make check` 会提醒你。）

**它不校验什么。** 锚点证明的是一个**位置**仍然存在，对它周围那段散文是否为真只字未提。这不是假设：本仓库第一篇笔记经审查发现，关于 mini-swe-agent 的核心论断是错的，而它的十五条锚点全部解析通过。锚点让笔记对"指向哪里"保持诚实，仅此而已。论断仍然需要一个读者。

## 目录

| 路径 | 放什么 |
| --- | --- |
| `repos/` | 钉住的目标仓库。`repos/pins.tsv` 入库，其下的克隆不入库 |
| `study/<repo>/` | 单个目标仓库的产物——笔记、追踪记录、阅读顺序 |
| `points/` | 技术点：一个想法一个文件，横切多个仓库 |
| `scripts/` | `pin.sh`（钉住并 materialize 目标）、`check_anchors.py`（校验）、`selftest.sh` |
| `matrix.md` | 哪个仓库 × 哪个技术点，以及笔记在哪 |
| `LOG.md` | 按日期记录读了什么、读出了什么 |
| `tests/` | 校验器自己的夹具。**不在** `make check` 扫描范围内 |

中文文档与英文文档并列存放，文件名加 `.zh-CN` 后缀（本文件即 `README.zh-CN.md`）。中文笔记与英文笔记走同一套校验——`study/` 和 `points/` 下的中文版锚点一样会被 `make check` 检查，并且**译文引用的位置必须与原文完全一致**（否则报 `translation-drift`），这样一对文档不会悄悄变得不再说同一件事。

## 锚点

**锚点**是一条指向目标仓库、且校验器能证明其仍然解析成功的引用。锚点写在普通行文中的反引号里。

给笔记加上 front matter，写明它对着哪个仓库、哪个提交写成，之后就可以用短形式：

```markdown
---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
---

agent 的控制循环是 `src/minisweagent/agents/default.py:96`，
结束一次运行的预算守卫在 `src/minisweagent/agents/default.py:132-147`。
```

识别三种形态：

| 形态 | 例子 | 校验什么 |
| --- | --- | --- |
| 代码锚点，短形式 | `path/to/file.py:97` 或 `path/to/file.py:97-120` | blob 在钉住提交上存在，行号在范围内 |
| 代码锚点，显式 | `repo@25941c89:path/to/file.py:97` | 同上，在指定提交上 |
| 提交引用 | `af906e86`（8 位以上十六进制）或 `repo@af906e86`（7 位以上） | 提交在克隆里，且是 pin 的祖先 |
| 翻译对 | `X.md` 与 `X.zh-CN.md` | 两者引用上述内容的集合必须相同 |

值得知道的规则：

- **front matter 的 `commit:` 必须等于当前的 pin。** 它是一句断言——"这篇笔记是对着今天这个快照写的"，而不是另一个解析目标。pin 一移动，所有写在旧提交上的笔记全部失败，这正是"该重读了"的提示。
- **短形式锚点永远在 pin 上解析。** 要刻意指向历史就用显式形式；该提交必须是 pin 的祖先，所以笔记不可能悄悄引用钉住历史之外的代码。
- **围栏代码块不会被扫描**，包括列表项下缩进的围栏、引用块里的围栏，以及长围栏包短围栏——所以一篇**讲**围栏语法的笔记是安全的。始终未闭合的围栏会被报出来（`unclosed-fence`），而不是静默吞掉文件剩余部分：静默跳过是这个校验器唯一可能"眼瞎却宣称成功"的途径。
- **短形式路径需要含 `/` 或以 `.ext` 结尾。** 这样 `localhost:8080` 就不会被卷进来。真实路径若两种形状都不满足，用显式形式。
- **长得像锚点但解析不了的 token 是错误，不是跳过。** 行文中的反引号内容被误判成锚点时，去掉反引号即可。最容易踩到的形状是 `example.com:443`。
- **裸提交引用需要 8 位以上小写十六进制**，以挡住英文单词。有一个例外躲不掉：全数字 token 天然歧义（约 2% 的缩写 SHA 是纯十进制），因此它会向克隆求证——真 SHA 照常校验，普通数字忽略。代价是**打错的**全数字 SHA 也会被忽略。想让全数字哈希无条件被校验，写成 `repo@12345678`。

跑 `python3 scripts/check_anchors.py -v` 可以看到校验器找到的每一条锚点，`--json` 输出机器可读报告。

## 钉住一个目标仓库

一个 pin 就是 `repos/pins.tsv` 里的一条制表符分隔记录：

```
name<TAB>url<TAB>40位十六进制提交<TAB>备注
```

```sh
scripts/pin.sh add <name> <url> [ref]   # 把 ref 解析成 SHA、记录、克隆
scripts/pin.sh sync                     # materialize 每个 pin 到其提交
scripts/pin.sh status                   # 钉住的 vs. 磁盘上的
scripts/pin.sh update <name> <ref>      # 移动 pin（之后重跑 make check）
```

`sync` 做**全量克隆**，并把 `HEAD` detach 在钉住提交上。保留完整历史是刻意的，不是顺手：一篇研读笔记在几个月后需要回答"这段逻辑是哪次提交引入的"，这意味着 `git log -S`、`git log -L` 和 `git blame` 必须能**离线**对着克隆工作。浅克隆（`--depth`）或无 blob 克隆（`--filter=blob:none`）都答不了，除非回网络。网络策略的推理和一段实做的考古示例见 [`repos/README.zh-CN.md`](repos/README.zh-CN.md)。

克隆被 gitignore。这里不 vendor 任何目标仓库的内容，也从不修改目标仓库——`repos/pins.tsv` 加 `scripts/pin.sh` 就足以精确重建每一个 checkout。

## 新增一份研读

0. `make sync` —— 每个 clone 做一次，materialize 已钉住的仓库。
1. `scripts/pin.sh add <name> <url>` —— 钉住仓库（这一步会顺带同步）。
2. 建 `study/<name>/NN-topic.md`，front matter 写明 pin 与其提交。
3. 边读边写锚点。
4. `make check` —— 直到退 0。
5. 往 `matrix.md` 加一行，往 `LOG.md` 加一条。

## 校验这个校验器

```
make selftest
```

对着 `tests/` 跑校验器——空产物集、一篇已知良好的笔记、一条故意写错的锚点、以及每种失败模式各一个用例——断言精确的退出码、错误码，以及在重要的地方**实际看了多少**。最后这点是"查过了而且没问题"和"根本没看"之间的区别：没有计数断言，一次"退化为静默"的回归会被当成成功。

`tests/` 在 `make check` 的扫描范围之外，所以它里面那些故意写坏的文件永远不会影响真实运行。每条断言都是**失败**而不是跳过——一个悄悄拒绝运行的检查，和这个校验器要防的是同一种缺陷。
