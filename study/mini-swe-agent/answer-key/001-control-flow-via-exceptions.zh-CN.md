---
title: harness 如何判定一次运行结束
status: seeded
lang: zh-CN
---

执行位示范，先写自己的走查再打开对照，不作论断依据

> 英文版：[001-control-flow-via-exceptions.md](001-control-flow-via-exceptions.md)

# 控制流：一次运行怎么结束

每个 agent harness 都要回答"现在这次运行结束了"。这个回答是承重的——它决定了**停止的理由**允许从哪里来，以及 harness 里有多少部分必须对此达成一致。

常见的有三种形态：

1. **返回一个值。** step 函数返回完成标志或结果对象，循环去判断它。简单，但只有持有循环的那段代码能结束运行，栈里更深的地方想停就得把信号一层层传回来。
2. **抛出异常。** 任意深度都能停止运行。代价是**理由**寄生在异常类型里，于是循环得为每种理由准备一个处理分支。
3. **追加一条消息。** 循环的停止条件去读对话记录。理由和 agent 说过的其他一切落在同一个地方，序列化时白捡一份持久化。

## mini-swe-agent

钉在 `mini-swe-agent@25941c89`。它用（2）当**传输方式**、用（3）当**判定条件**——这两者的切分就是它的全部设计。

异常基类携带的是消息而不是状态码：`mini-swe-agent@25941c89:src/minisweagent/exceptions.py:4`。所有控制流异常都继承这个构造函数。留意一个抛出点因此选择了什么：**只选择对话记录里写下什么**，而不是运行是否结束。是否终止是之后由循环决定的，依据是最后一条消息的 role：`mini-swe-agent@25941c89:src/minisweagent/agents/default.py:122`。

这个区分不是咬文嚼字。在这个 pin 上一共有 15 个控制流抛出点：**9 个带 `role: "exit"`，会结束运行；6 个带 `role: "user"`，不会**。所有 `FormatError` 都属于后一组（`mini-swe-agent@25941c89:src/minisweagent/models/utils/actions_text.py:27`），`UserInterruption` 也是（`mini-swe-agent@25941c89:src/minisweagent/agents/interactive.py:41`）。抛出它们，是 harness 在说"这段输出格式不对，重来一次"——异常在这里纯粹被当作**消息注入通道**用，完全没有控制流含义。

由此带来的好处是，"这次运行为什么结束"单看保存下来的轨迹就能回答，不需要另立一个 exit-code 字段再想办法保持同步。它也意味着环境可以在 agent 根本不知道"这事儿还能发生"的情况下结束一次运行：`mini-swe-agent@25941c89:src/minisweagent/environments/local.py:48` 就是在命令输出里发现哨兵字符串后抛出的。

有一处仍然破例，而且值得知道为什么。循环里有一个专门的 `except FormatError` 分支，它统计连续失败次数，到上限时**自己**合成那条 `role: "exit"` 消息：`mini-swe-agent@25941c89:src/minisweagent/agents/default.py:100-112`。这里是循环结束了运行，而它能这么做的唯一途径就是按异常类型分支。

这层历史在提交里看得很清楚。`mini-swe-agent@10dfc4ea` 移除了基于类型的终止——在那之前循环写的是 `isinstance(e, TerminatingException): return`，异常类型确实说了算。五个月后 `mini-swe-agent@6e0413ca` 加上了连续格式错误上限，又放回来了恰好一个类型分支。一个纯粹的设计撑了五个月，然后为一个真实的运维需求买了一个例外：模型在畸形输出上打转的话，否则永远停不下来。

## 带给下一个 harness 的问题

- 停止条件读的是**一个值、一个异常、还是对话记录**？
- agent 之外的组件能结束一次运行吗？环境可以吗？模型可以吗？
- 退出理由能从保存的轨迹里还原，还是只能翻日志？
