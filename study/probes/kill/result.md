# kill 探针：工具执行到一半把进程 kill -9

任务模板 `study/probes/tasks/kill/`：先跑一次二十几秒的 `slow_check.sh` 采基线，再修 `stats.py` 让四条 unittest 全绿。脚本开跑时在工作副本里放下一个标记文件，wrapper 看见标记再等 4 秒，确认工具执行确实进行中，然后对 harness 进程本身发 `kill -9`。两家的任务文本、模型（xai / grok-4.3）、工作副本、环境变量白名单完全相同。

wrapper 的兜底是墙钟 480 秒或 40 步；这个探针里两次都没轮到它，停下进程的是 wrapper 的 kill 本身。

---

## mini-swe-agent

记录：[终端全文](mini-swe-agent/terminal.txt) ｜ [会话记录 mini.traj.json](mini-swe-agent/mini.traj.json)

**发生了什么。** 第 1 步 `ls -la`；第 2 步一条消息里发了三个动作（`cat stats.py`、`cat test_stats.py`、`cat README.md`）；第 3 步发出 `bash slow_check.sh`。脚本跑起来后 wrapper 记下 harness 的 pid 3374 和它当时唯一的子进程 3481，对 3374 发 `kill -9`，进程以 137 退出。终端全文里第 3 步的命令印出来了，因为它是模型刚发出时就打到屏幕上的。

**步数。** 会话记录里 `api_calls` 是 2。屏幕上到过第 3 步。整轮墙钟 18 秒。

**记录文件的最终状态。** `mini.traj.json` 共 8 条消息：system、user、以及第 1、2 步的 assistant 与它们的 observation。`exit_status` 是空字符串。**第 3 步整步不在文件里**——发出 `bash slow_check.sh` 的那条 assistant 消息没有，它的 observation 也没有。上游把落盘放在每一步的 `finally` 里（[agents/default.py:120-121](https://github.com/SWE-agent/mini-swe-agent/blob/25941c89cfbc91eb40b3f8756348c91d9977d57e/src/minisweagent/agents/default.py#L120-L121)），一步跑完才写一次，且每次整份重写；`kill -9` 落在这一步的动作执行途中，`finally` 没轮到。

**续跑入口。** 没有。`--help` 的输出里没有任何一行含 resume（终端全文第 3 节记着这次实测），上游 `src/minisweagent` 整棵树里 resume、restore、continue_from 三个词的出现次数是 0。所以没有第二次运行，也没有可续的入口。

**模型看到的历史与死前是否一致。** 死的那一刻进程内存里的 `messages` 已经含第 3 步那条 assistant 消息——它是在模型调用返回时就加进去的，早于动作执行；落盘的文件里没有它。文件与死前内存差一条 assistant 消息。由于没有续跑入口，这份文件不会再被任何东西读回去。

---

## deepseek-harness（默认组合）

记录：[被杀那次的终端全文](deepseek-harness/terminal.txt) ｜ [续跑那次的终端全文](deepseek-harness/terminal-resume.txt) ｜ [死前的会话日志](deepseek-harness/sessions-at-kill/--home-user-harness-study-.dsh-run-probe-kill-workspace--/session-54f2edac-8d54-45e5-9c8d-df1309264729/session.jsonl) ｜ [续跑后的同一份会话日志](deepseek-harness/sessions/--home-user-harness-study-.dsh-run-probe-kill-workspace--/session-54f2edac-8d54-45e5-9c8d-df1309264729/session.jsonl) ｜ [续跑那次新开的会话日志](deepseek-harness/sessions/--home-user-harness-study-.dsh-run-probe-kill-workspace--/session-f8a441ec-3b51-4a6c-b41f-02292caff1db/session.jsonl)

**发生了什么。** 第 1 步 glob 列文件；第 2 步一个调用，`bash` 跑 `bash slow_check.sh`，调用参数里模型自己带了 `timeoutMs`。脚本跑起来后 wrapper 记下 pid 3643 与子进程 3687，对 3643 发 `kill -9`，进程以 137 退出。

**步数。** 会话日志里 `step/end` 事件 1 条。整轮墙钟 13 秒。

**记录文件的最终状态（死的那一刻）。** 会话日志 40 行、45958 字节。**发出 `bash slow_check.sh` 的那条 `tool/call` 在日志里**（seq 110）——事件在发出时就写，不等结果。缺的只是它的 `tool/result`。日志最后一行是 seq 111 的 `session/title`，由 session-title 侧调用写入。

**续跑是否成功。** headless 这一侧没有续跑入口：它的命令只声明一个任务位置参数（[startup.ts:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/startup.ts#L36)），且每次运行都用 `randomUUID` 现开一个新会话（[headless/src/index.ts:178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L178)）。dsh 自己的续跑口子在 agent-loop 的配置里（[agent-loop/src/index.ts:270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L270)），可以从 patch 覆盖层给到，本次就是这么试的：把被杀那个会话的 id 填进 `resumeSessionId`，其余组合一字不动。

结果分两半。**日志这一半成了**：那个会话被读回来，前 40 行逐字节相同，尾部追加了 4 条事件——一条 id 以 `interrupted-tool-result-` 开头的 `tool/result`，`isError` 为真，错误名 `ToolOutcomeUnknownError`、code `TOOL_OUTCOME_UNKNOWN`，正文是"工具调用被记录之后中断，结果没有持久化，结局未知；只有只读或幂等的操作才可重试"（[repair.ts:94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L94)、[repair.ts:104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L104)）；然后 `step/end`；然后 `turn/end`，reason 是 `{"kind":"interrupted"}`（[repair.ts:131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L131)）；最后 `session/end-seed`。**任务这一半没接上**：这个被读回来的会话没有发出任何新的模型请求。被打断的那件事是由同一次运行里新开的另一个会话从头做完的——它跳过了 `slow_check.sh`，两步就把 `stats.py` 改对，四条测试全绿。

**续跑时 request 有没有标为 resume。** 没有。`RequestHeaderReason` 这个类型里确实有 `'resume'` 这一档（[types.ts:213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/types.ts#L213)），语义是"一个循环实例在已有 header 事件的日志上发出的第一次请求"。被读回来那个会话里 `request/header` 只有一条，reason 仍是 `initial`，就是死前那一条；续跑没有追加新的 header，因为它没有发请求。新开那个会话自己的 `request/header` reason 也是 `initial`。整个探针里没有出现过一条 reason 为 `resume` 的事件。

**模型看到的历史与死前是否一致。** 前 40 行逐字节一致，续跑只追加不改写。追加的 4 条会改变"下一次请求会带什么"：被中断的那次调用从悬空变成一条显式的"结局未知"结果，那一轮也被显式收成 interrupted。但这一次没有下一次请求发生在这个会话上，所以模型实际没有再看到这段历史。

---

## 卡外发现

- **两家都在"工具已发出、结果未落盘"这个窗口里死了，留下的东西不是同一类。** mini 的记录停在上一步末尾，发出命令的那条模型消息随进程一起没了；dsh 的日志里调用在、结果不在。差别来自落盘时机：一个按步整份重写，一个按事件追加。
- **dsh 的崩溃修复是往日志里写字，不是在内存里跳过。** 被中断的调用不是被删掉或忽略，而是补上一条 `isError` 的结果事件，正文直接对模型讲清"结局未知、别盲目重试"。这条是给模型看的，和日志里那些只给界面看的 `meta` 不同。
- **dsh 的 `'resume'` 这一档存在，但在 headless 这条路上够不着。** 类型里有、语义写得很清楚，可 headless 每次现开随机会话，而配置里的 `resumeSessionId` 只把会话读回来、不给它输入。要看见一条 reason 为 `resume` 的 header，得有别的东西驱动那个被读回来的会话发请求。
- **wrapper 靠任务脚本自己放的标记文件判断"工具正在执行中"。** 两家都没有对外暴露"我现在正卡在某个工具里"的实时信号可供外部进程读取，所以这个时机只能由任务模板自己制造。
