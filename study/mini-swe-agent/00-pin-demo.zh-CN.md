---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
title: 钉住演示 —— 这个 harness 的骨架
lang: zh-CN
---

> 英文版：[00-pin-demo.md](00-pin-demo.md)

# mini-swe-agent，已钉住

这篇笔记的存在是为了证明脚手架端到端可用：一个钉住的目标仓库、一批由 `make check` 对着钉住提交校验的锚点，以及深到足以追问"每块东西是什么时候来的"的历史。正式研读从 `01-*` 开始；下面是对几处接缝的第一遍扫描——之所以挑这几处，是因为每一处都是别的 harness 会做出明显不同选择的地方。

钉在 `25941c89cfbc91eb40b3f8756348c91d9977d57e`——从这个 pin 可达 1020 个提交，所以下面每条 `git log -S` 都是离线跑的。

## 四处接缝

**运行循环。** `src/minisweagent/agents/default.py:96-124` 就是全部控制循环：一个无界的 `while True`，调用 `step()`，把 `FormatError` 和 `InterruptAgentFlow` 转成追加的消息，在 `finally` 里保存轨迹，然后停在一个值得注意的条件上——不是返回值，而是**最后一条消息的 role 是 `exit`**。循环随后把那条消息的 `extra` 字典作为运行结果返回。终止是关于**对话**的事实，不是关于调用栈的。循环里有一处例外：`src/minisweagent/agents/default.py:100-112` 统计连续的 `FormatError`，到上限时自己写下那条 `exit` 消息。

**终止由抛出承载，但不由抛出者决定。** `src/minisweagent/exceptions.py:4-6` 的异常层次给每个控制流异常一个存放对话消息的构造函数。因此栈里任何位置的抛出点选择的是**对话记录里写什么**——仅此而已。运行是否停止由循环稍后依据最后一条消息的 role 决定，在 `src/minisweagent/agents/default.py:122`。这个 pin 上的 15 个控制流抛出点里，9 个带 `role: "exit"` 会停止运行，6 个带 `role: "user"` 刻意不停。`src/minisweagent/agents/default.py:132-147` 的预算守卫属于会终止的那类：步数、成本、墙钟三种限额都在任何模型调用**之前**检查，各自抛出一个携带现成 `exit` 消息的异常。那里的 `0 < limit <= current` 写法，就是三种预算共用的"0 表示不限"约定的编码方式。

**任务什么时候算完，由环境说了算**，而不是 agent：`src/minisweagent/environments/local.py:48-56` 检查所执行命令自身 stdout 的第一行是否为哨兵字符串，是则抛出 `Submitted`，并把剩余输出当作提交内容。agent 循环从不检测"完成"，它只是接住环境扔过来的东西。执行本身在 `src/minisweagent/environments/local.py:74-85`——一个 `subprocess.Popen`，`shell=True`，stderr 折进 stdout，子进程放进自己的进程组，这样超时能杀掉整组而不是留下孤儿进程。

**配置先合并，再接线。** `src/minisweagent/run/mini.py:92` 把所有 `-c` 规格连同 CLI 参数递归合并成一个嵌套字典，`src/minisweagent/run/mini.py:99-102` 再把这个字典拆成 `model` / `environment` / `agent` 三个子字典，各自交给按类名解析的工厂。换后端是改配置，不是走另一条代码路径。单条规格的解析在 `src/minisweagent/config/__init__.py:56-61`。

## 保留历史是为了什么

pin 让上面的锚点保持稳定。pin 背后的**历史**回答的是失效笔记回答不了的问题：这件事是从什么时候开始成立的？

```console
$ git log --oneline -S 'MSWEA_GLOBAL_COST_LIMIT' --reverse --format='%h %ad %s' --date=short | head -1
af906e86 2025-07-09 Feat: add global cost tracking (#88)

$ git log -L 88,124:src/minisweagent/agents/default.py --format='%h %ad %s' --date=short -s 25941c89 | head -3
40fa3652 2026-07-22 fix(agents): count billed calls that fail to parse against cost_limit (#915)
6e0413ca 2026-06-10 Enh: Cap consecutive format errors (#863)
d17fd292 2026-01-09 Agent must pass all messages through Model.format_message
```

从中落出三个答案，每一个都对应一个本仓库现在仍能到达的提交：

- 进程级成本追踪（`src/minisweagent/models/__init__.py:30-31`，全局预算耗尽时它是**抛出**而不是返回）来自 `af906e86`。
- 本地环境所依赖的退出哨兵协议来自 `22d33edf`。
- 运行循环从"围绕异常组织"改为"围绕消息组织"是在 `10dfc4ea`——一次破坏性变更，也是今天循环的停止条件长成这样的原因。

最后这条才是回报所在。冷读 `src/minisweagent/agents/default.py:96-124`，那个按消息 role 判定终止的检查看起来很随意；把它和 `10dfc4ea` 并排读，它就是一次刻意的反转，而该带进下一个 harness 的问题也随之变成：**这一个是靠值、靠异常、还是靠消息来终止的？**

## 锚点是刻意的

上面每一处反引号引用都会被校验。弄坏一个——改个行号、挪一下 pin——`make check` 就会带着这篇笔记自己的 `文件:行号` 失败。这正是脚手架的全部意义：一篇已经失效的笔记会自己说出来。

但要清楚它**没有**校验什么：锚点证明的是**位置**，不是论断。这篇笔记的第一版里，15 条锚点全部解析通过，而"终止由抛出点决定"这句核心论断是错的——它描述的恰恰是 `10dfc4ea` 移除掉的那套语义。锚点让笔记对"指向哪里"保持诚实，仅此而已；论断仍然需要一个读者。
