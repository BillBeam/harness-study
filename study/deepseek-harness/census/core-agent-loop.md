---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/core/agent-loop
---

# packages/core/agent-loop

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 10 个文件、127 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/core/agent-loop/README.md

包的英文说明文档，描述该插件的配置字段、回合与步骤流程、失败与取消行为，以及 Model Experience 小节。

- 无运行期机制

### packages/core/agent-loop/package.json

包清单，声明该包的模块类型、入口与随包发布的文件。

- `"type": "module"` 与 `main`/`types` 指向 `lib/index.js` 及其类型声明（[packages/core/agent-loop/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant` 子路径与 `./package.json` 三个解析入口（[packages/core/agent-loop/package.json:16-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/package.json#L16-L26)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 和 `lib/types/**/*.d.ts`（[packages/core/agent-loop/package.json:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/package.json#L27-L31)）

### packages/core/agent-loop/src/agent.ts

`ReactLoopAgent` 驱动类：实现 `Agent` 接口，维护 idle/maintenance/running 三态，跑回合与步骤，向会话日志追加事件并发起模型请求，由 `src/index.ts` 的工厂构造。

- `requestProposal` 在折叠上一次请求头时删除被标记为适配器默认值的 `reasoningEffort` 与 `maxTokens`（[packages/core/agent-loop/src/agent.ts:60-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L60-L66)）
- 构造时用 `agentEvents(loopCtx, this)` 建一次融合派发器，后续热路径派发不再分配（[packages/core/agent-loop/src/agent.ts:93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L93)）
- 收件箱的插入、丢弃、认领三个回调分别派发 `agent/inbox/inserted`、`agent/inbox/discarded`、`agent/inbox/claimed`（[packages/core/agent-loop/src/agent.ts:94-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L94-L98)）
- 起始回合号取自会话日志中最后一个 `turn/start` 事件，缺失时为 0（[packages/core/agent-loop/src/agent.ts:99-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L99-L100)）
- 构造 agent 作用域并把 `agent` 挂到派生上下文上，注册都经由这个上下文（[packages/core/agent-loop/src/agent.ts:101-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L101-L103)）
- `status` 把 idle 与 maintenance 两个阶段都映射为 `'idle'`，running 映射为 `'running'`（[packages/core/agent-loop/src/agent.ts:106-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L106-L108)）
- `setPhase` 只在对外状态真的翻转时派发 `agent/status`（[packages/core/agent-loop/src/agent.ts:111-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L111-L118)）
- `send` 在插入前先判定：唤醒型输入若落在已中止的活动上，目标被改写为 `next-turn`（[packages/core/agent-loop/src/agent.ts:120-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L120-L127)）
- `followup` 投 `next-turn` 并唤醒，`steer` 投 `next-step` 并唤醒，`inject` 投 `next-step` 但不唤醒（[packages/core/agent-loop/src/agent.ts:129-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L129-L139)）
- `cancel` 默认清空收件箱并清掉唤醒锁存，再用取消原因中止当前阶段的 AbortController（[packages/core/agent-loop/src/agent.ts:141-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L141-L147)）
- `runMaintenance` 要求当前空闲，否则抛错；期间置 maintenance 阶段，结束后回到 idle 并在有锁存唤醒且收件箱非空时重新起驱动（[packages/core/agent-loop/src/agent.ts:149-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L149-L169)）
- `wakeDriver` 在非空闲时把唤醒锁存起来，取消原因为 `disposed` 时不锁存（[packages/core/agent-loop/src/agent.ts:180-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L180-L189)）
- 空闲时 `wakeDriver` 新建 running 阶段与 AbortController，并在 `ctx.agents.withInitiator(this, …)` 内启动 `kick()`（[packages/core/agent-loop/src/agent.ts:190-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L190-L199)）
- `whenIdle` 反复等待 `activityDone`，直到等待前后是同一个 promise（[packages/core/agent-loop/src/agent.ts:202-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L202-L207)）
- `throwError` 先带当前 turn/step 派发 `agent/error` 再把错误抛出（[packages/core/agent-loop/src/agent.ts:210-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L210-L215)）
- `kick` 循环调用 `turn()` 直到返回 false，吞掉错误，最后回到 idle 并按锁存唤醒重新起驱动（[packages/core/agent-loop/src/agent.ts:217-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L217-L230)）
- `preStep` 按目标从收件箱认领消息，再用当前信号装配系统提示词（[packages/core/agent-loop/src/agent.ts:236-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L236-L238)）
- `preStep` 渲染动态上下文分节并交给 `RuntimeContextProjection.project` 产出候选快照消息（[packages/core/agent-loop/src/agent.ts:239-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L239-L240)）
- `agent/pre-step` 瀑布决定本步进入哪些消息，默认实现是认领的消息加上运行时上下文快照（[packages/core/agent-loop/src/agent.ts:241-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L241-L249)）
- `turn` 先追加 `turn/start` 并把阶段回合号推进一格（[packages/core/agent-loop/src/agent.ts:260-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L260-L266)）
- `pre-step` 返回 `reject` 时本回合以 `blocked` 结束并停止驱动（[packages/core/agent-loop/src/agent.ts:273-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L273-L277)）
- 首步决策为空消息时回合以 `completed` 结束，不花一次模型调用（[packages/core/agent-loop/src/agent.ts:278-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L278-L284)）
- 每步追加 `step/start`，把决策里的每条消息作为 `user/message` 以 `surfaceOp: 'append'` 入日志（[packages/core/agent-loop/src/agent.ts:285-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L285-L291)）
- 一旦某步得到 `max-tokens`，后续正常完成的步骤不再改写回合结束原因（[packages/core/agent-loop/src/agent.ts:292-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L292-L297)）
- `step/end` 在 finally 中追加，异常路径也会写（[packages/core/agent-loop/src/agent.ts:298-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L298-L300)）
- 回合准备结束且 `next-step` 队列为空时串行派发 `agent/turn-stopping`，之后再查一次队列决定是否继续（[packages/core/agent-loop/src/agent.ts:301-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L301-L307)）
- 中止时回合结束原因记为 `aborted` 并带取消原因，其他异常记为 `error` 并把 `LlmError` 的 failure 或 `errorChain` 文本加 `UNKNOWN` 码写进去（[packages/core/agent-loop/src/agent.ts:309-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L309-L322)）
- `turn/end` 在 finally 中追加，追加失败本身也走 `throwError`（[packages/core/agent-loop/src/agent.ts:323-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L323-L330)）
- 回合结束后收件箱仍有待办则换新 AbortController、清掉锁存唤醒、步号归零并返回 true 继续下一回合（[packages/core/agent-loop/src/agent.ts:331-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L331-L336)）
- `step` 把装配结果渲染成系统提示词文本（[packages/core/agent-loop/src/agent.ts:344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L344)）
- 每次请求前读取会话表面的 `replaceGeneration`，并把它传给 `buildRequest`（[packages/core/agent-loop/src/agent.ts:346-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L346-L357)）
- 有 `preparedCall` 时用它发流，否则退回 `ctx.llm.stream(request)`（[packages/core/agent-loop/src/agent.ts:362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L362)）
- 每个流块都追加一条 `assistant/chunk` 并记录其 seq，同时喂给块装配器，每块前后都检查中止（[packages/core/agent-loop/src/agent.ts:363-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L363-L369)）
- 流在中止下抛错时，若已有内容就追加一条 `interrupted: true` 的 `assistant/message`，引用已记录的块 seq（[packages/core/agent-loop/src/agent.ts:370-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L370-L387)）
- 装配结果为 error 或 aborted 时走 `agent/request-error` 瀑布，返回 `{ kind: 'retry' }` 则重发同一步，否则抛 `LlmError`（[packages/core/agent-loop/src/agent.ts:388-406](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L388-L406)）
- 正常结束时用装配块建助手消息，带 provider/model/replayState 来源与用量，作为 `assistant/message` 追加并引用全部块 seq（[packages/core/agent-loop/src/agent.ts:408-425](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L408-L425)）
- 结束原因为 `max-tokens` 时直接返回该步结束原因，不再执行工具（[packages/core/agent-loop/src/agent.ts:426](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L426)）
- 助手消息中无 tool-call 块时该步以 `completed` 结束（[packages/core/agent-loop/src/agent.ts:428-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L428-L429)）
- 有 tool-call 时调用 `executeToolCalls`，其产出的结果上下文被塞进 `next-step` 收件箱队尾；`concluded` 决定该步是结束还是继续（[packages/core/agent-loop/src/agent.ts:430-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L430-L434)）
- `buildRequest` 只在持久化头的 provider/model 与本实例声明的路由一致、且该值不是适配器默认时，才恢复其中的 `reasoningEffort`（[packages/core/agent-loop/src/agent.ts:456-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L456-L464)）
- 首次请求的种子配置来自 AgentOptions 的路由与显式设置，之后各步用 `requestProposal` 折叠上次头；种子被深冻结（[packages/core/agent-loop/src/agent.ts:466-475](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L466-L475)）
- `agent/request` 瀑布可以改写这份请求配置（[packages/core/agent-loop/src/agent.ts:476-480](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L476-L480)）
- 瀑布后 provider 或 model 仍为空时抛错，错误文本指出应设置 AgentOptions 或经瀑布补齐（[packages/core/agent-loop/src/agent.ts:481-483](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L481-L483)）
- `ctx.llm.prepareCall` 解析适配器默认值；只有 `NO_ADAPTER` 这一种 `LlmError` 被吞掉并退回未解析的提议配置（[packages/core/agent-loop/src/agent.ts:484-493](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L484-L493)）
- 用配置、适配器默认标记、非空系统提示词与非空工具表构造规范化请求头（[packages/core/agent-loop/src/agent.ts:496-501](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L496-L501)）
- 本实例首次请求追加 reason 为 `initial` 或 `resume` 的 `request/header`，之后头变化追加 `change`（必要时带 `startsSeries`），头不变但开新消息序列时追加 `series`（[packages/core/agent-loop/src/agent.ts:502-517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L502-L517)）
- 表面替换代次与上次不同也会把该请求标记为新序列起点（[packages/core/agent-loop/src/agent.ts:503-504](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L503-L504)）
- provider、model 或上下文窗口任一与上次不同时追加一条 `request/context`（[packages/core/agent-loop/src/agent.ts:519-530](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L519-L530)）
- 最终请求由头里的配置、派生消息、system、tools、sessionId 与信号组成，深冻结并打上 agent-loop 来源标记（[packages/core/agent-loop/src/agent.ts:533-541](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L533-L541)）

### packages/core/agent-loop/src/constants.ts

只放一个调度默认值的模块，被插件入口的配置 schema 与解析函数引用。

- 导出默认并行安全工具调用上限 `10`（[packages/core/agent-loop/src/constants.ts:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/constants.ts#L6)）

### packages/core/agent-loop/src/index.ts

插件入口：`AgentLoop` 服务把自己注册成 agent 工厂，管理创建/恢复事务与拆解，按配置在启动时拉起声明式 agent。

- `INACTIVE_STATES` 把 UNLOADING/DISPOSED/FAILED 三个 fiber 状态列为不能承载新生命周期（[packages/core/agent-loop/src/index.ts:33-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L33-L37)）
- `FactoryOwnership.signal` 暴露一个在工厂拆解时以 `agent loop is not active` 错误中止的信号（[packages/core/agent-loop/src/index.ts:49-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L49-L52)）
- `isActive()` 同时要求仍在接单且 fiber 不处于失活状态（[packages/core/agent-loop/src/index.ts:54-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L54-L56)）
- `track`/`trackStartup`/`trackWrapper` 把每个活 agent 的拆解、配置启动任务和公开 create/resume 续体登记进工厂（[packages/core/agent-loop/src/index.ts:58-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L58-L74)）
- `waitWhileActive` 让等待在工厂拆解开始时立即结束（[packages/core/agent-loop/src/index.ts:76-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L76-L79)）
- `dispose()` 停止接单、中止信号、并等待所有活 agent 拆解与启动任务结算（[packages/core/agent-loop/src/index.ts:81-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L81-L89)）
- `raceAbort` 把一个操作与信号中止竞速，并把非 Error 的中止原因包装成带 cause 的 Error（[packages/core/agent-loop/src/index.ts:93-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L93-L106)）
- `raceAbortCall` 在中止后仍把迟到的返回值交给 `releaseAbandoned` 释放（[packages/core/agent-loop/src/index.ts:109-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L109-L130)）
- `resolveMaxParallelToolCalls` 补默认值并拒绝非正整数（[packages/core/agent-loop/src/index.ts:133-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L133-L139)）
- `assertAgentOptions` 拒绝非正的、或不能精确表示的 `maxTokens`（[packages/core/agent-loop/src/index.ts:142-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L142-L147)）
- 声明 `agent-loop/config-start-failed` 事件，携带失败的 sessionId 与错误（[packages/core/agent-loop/src/index.ts:173-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L173-L184)）
- `applyLauncherIdentities` 对启动器点名的每个配置 agent 同时清掉 `sessionId` 与 `resumeSessionId`，再按 `resume` 标记写回其中一个（[packages/core/agent-loop/src/index.ts:221-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L221-L234)）
- `CONFIGURED_AGENT_IDENTITIES_KEY` 定义启动器在任何 Loader 条目挂载前用 `ctx.provide` 写入身份的上下文键（[packages/core/agent-loop/src/index.ts:211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L211)）
- 设置节 schema 只暴露 `maxParallelToolCalls` 一个字段，最小值 1，默认取常量（[packages/core/agent-loop/src/index.ts:250-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L250-L252)）
- `validateConfiguredAgents` 拒绝同时给出 `sessionId` 与 `resumeSessionId`，并拒绝两个条目使用同一精确会话身份（[packages/core/agent-loop/src/index.ts:278-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L278-L293)）
- 服务声明注入 `agents`、`sessions`、`llm`、`tools`、`systemPrompt`（[packages/core/agent-loop/src/index.ts:297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L297)）
- 运行期配置 schema 规定 `agents[].id` 必填、`sessionId` 非空、`maxTokens` 为不超过安全整数上限的正整数，`agents` 默认空数组（[packages/core/agent-loop/src/index.ts:300-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L300-L312)）
- `maxParallelToolCalls` 做成 getter，每次读都走当前设置源，改动只影响下一组工具调用（[packages/core/agent-loop/src/index.ts:326-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L326-L335)）
- 安装设置节时用 `resolveMaxParallelToolCalls` 做校验，非法值被拒后调度器留在上一个好值上（[packages/core/agent-loop/src/index.ts:336-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L336-L346)）
- 用 `ctx.effect` 把工厂拆解登记为可回滚效果，并把自己设为 `ctx.agents` 的工厂（[packages/core/agent-loop/src/index.ts:350-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L350-L351)）
- 注册 `provider`、`model`、`cwd` 三个系统提示词变量，取值来自当前 agent 的选项与会话头（[packages/core/agent-loop/src/index.ts:352-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L352-L354)）
- 未给 `sessionId` 的配置条目每次启动都铸造 `${id}-session-<uuid>` 这样一个全新身份（[packages/core/agent-loop/src/index.ts:356-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L356-L360)）
- 给了 `sessionId` 且存在持久化服务时走 restore-or-create，否则直接创建（[packages/core/agent-loop/src/index.ts:360-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L360-L369)）
- 给了 `resumeSessionId` 的条目注册成一个等待 `sessionPersistence` 的注入效果，服务到位后才发起恢复（[packages/core/agent-loop/src/index.ts:371-382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L371-L382)）
- `reportConfiguredStartupFailure` 在工厂仍活跃时打一条 warn 并向所有监听者派发 `agent-loop/config-start-failed`，监听者的同步抛出与异步拒绝都各自被记录且不外溢（[packages/core/agent-loop/src/index.ts:386-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L386-L405)）
- `restoreOrCreateConfigured` 先等同 id 的旧生命周期排空，再尝试恢复；恢复失败时只有在持久化列表里确实查不到该 id 才退化为新建，否则原错误上抛（[packages/core/agent-loop/src/index.ts:408-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L408-L429)）
- `waitForDrainingConfiguredIdentity` 只在 id 仍占着 agent 或 session 注册表时等待，并通过 `agent/disposed` 与 `session/disposed` 事件判定释放（[packages/core/agent-loop/src/index.ts:432-452](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L432-L452)）
- `prepare` 在建任何资源前就融合调用方信号、owner fiber 卸载与工厂拆解三个中止源（[packages/core/agent-loop/src/index.ts:480-488](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L480-L488)）
- `dispose` 被记忆化为一次逆序拆解：中止信号、取消并等待机器空闲、卸下作用域、退出两个注册表、解除登记（[packages/core/agent-loop/src/index.ts:494-521](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L494-L521)）
- 拆解在发布前就同时登记到工厂和 owner fiber 上，setup 期间卸载会整体回滚（[packages/core/agent-loop/src/index.ts:522-538](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L522-L538)）
- `publish` 依次进入 session 与 agent 注册表、announce 会话、announce agent、发 `agent/session-start`，每一步之间重查存活（[packages/core/agent-loop/src/index.ts:557-572](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L557-L572)）
- `create` 用 `SessionPreparation` 准备会话并以 `startup` 来源发布，发布失败即拆解（[packages/core/agent-loop/src/index.ts:590-599](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L590-L599)）
- `createAgent` 把 seed 与 meta 透传给会话准备，并把整个续体登记给工厂（[packages/core/agent-loop/src/index.ts:607-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L607-L623)）
- `setupAndPublish` 在融合信号下等待 setup、提交其结果，再发布；任何失败先拆解再上抛（[packages/core/agent-loop/src/index.ts:626-646](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L626-L646)）
- `resume` 在没有 `sessionPersistence` 时直接抛出带补救提示的错误（[packages/core/agent-loop/src/index.ts:654-660](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L654-L660)）
- `resumeWith` 把持久化加载与调用方取消、owner 卸载、工厂拆解融合成一个信号竞速，并在加载后重查 fiber 与工厂活性（[packages/core/agent-loop/src/index.ts:669-704](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L669-L704)）
- 被放弃的会话准备在 finally 与 `releaseAbandoned` 两处都会被释放（[packages/core/agent-loop/src/index.ts:685-707](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L685-L707)）

### packages/core/agent-loop/src/invariant.ts

包自带的不变量伴随插件，向 `invariants` 服务注册一个检查：每个由本循环构建的 LLM 请求都必须能从会话日志重建。

- 声明伴随插件名与它所需的 `invariants` 服务（[packages/core/agent-loop/src/invariant.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L14-L16)）
- 以 `global` 且 `prepend` 的方式挂在 `llm/stream` 上，非 agent-loop 请求直接 `next()` 放行（[packages/core/agent-loop/src/invariant.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L21-L22)）
- 检查请求对象与其 messages 数组已冻结、带 sessionId、且该 id 对应一个活会话（[packages/core/agent-loop/src/invariant.ts:23-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L23-L29)）
- 会话日志里没有 `step/start` 或没有 `request/header` 时直接判失败并不再往下检查（[packages/core/agent-loop/src/invariant.ts:31-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L31-L38)）
- 把请求 messages 与 `session.deriveMessages()` 做 JSON 比对，不一致即判为日志重建失步（[packages/core/agent-loop/src/invariant.ts:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L39-L42)）
- 逐项比对 model、system、temperature、maxTokens、stop 与 tools 是否与折叠出的请求头一致（[packages/core/agent-loop/src/invariant.ts:44-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L44-L51)）
- 检查完毕调用 `next()` 把请求继续交给后续监听者（[packages/core/agent-loop/src/invariant.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L53)）
- `apply` 以包名向 `ctx.invariants` 注册该安装器并返回其 disposer（[packages/core/agent-loop/src/invariant.ts:62-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L62-L63)）

### packages/core/agent-loop/src/runtime-context.ts

`RuntimeContextProjection` 类：跟踪会话里最后一条被保留的运行时上下文快照，并在每步开始时决定是否产出新的快照消息，由 `agent.ts` 的 `preStep` 使用。

- 定义快照消息的插件来源标识与"当前无运行时上下文"的固定文本（[packages/core/agent-loop/src/runtime-context.ts:12-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/runtime-context.ts#L12-L13)）
- `isOwned` 只认来源为该插件的用户消息，`textOf` 只取单个 text 块的文本（[packages/core/agent-loop/src/runtime-context.ts:15-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/runtime-context.ts#L15-L22)）
- 构造时倒序扫描会话事件，找到第一条仍在表面上的自有快照作为保留值；见过但都不在表面则置为"无保留"（[packages/core/agent-loop/src/runtime-context.ts:35-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/runtime-context.ts#L35-L44)）
- 监听 `session/event`：本会话新增自有快照时更新保留值，遇到引用该 seq 的表面替换事件时清空保留值（[packages/core/agent-loop/src/runtime-context.ts:46-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/runtime-context.ts#L46-L55)）
- `project` 在从未有过快照且当前渲染为空时不产出消息（[packages/core/agent-loop/src/runtime-context.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/runtime-context.ts#L65)）
- 当前渲染为空但曾有快照时，用固定的清除文本代替空串（[packages/core/agent-loop/src/runtime-context.ts:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/runtime-context.ts#L66)）
- 与保留文本相同时不产出新消息（[packages/core/agent-loop/src/runtime-context.ts:67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/runtime-context.ts#L67)）
- 产出的用户消息带插件来源；有贡献分节时额外带 `form: 'snapshot'` 与分节列表（[packages/core/agent-loop/src/runtime-context.ts:68-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/runtime-context.ts#L68-L74)）

### packages/core/agent-loop/src/tool-calls.ts

一个模块级函数 `executeToolCalls` 及其分组调度实现：按并发模式排一步里的所有工具调用，把调用与结果按模型顺序写进会话日志，供 `agent.ts` 的 `step` 调用。

- 从上下文取发起方 Agent 并由它派生会话，工具执行输入里显式带上该 agent 与步级信号（[packages/core/agent-loop/src/tool-calls.ts:67-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L67-L80)）
- 每组开始前重新查询首个待办调用的执行模式：`parallel` 取剩下全部，其他模式只取这一个，形成屏障（[packages/core/agent-loop/src/tool-calls.ts:84-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L84-L93)）
- 任一组报告中止后，剩余全部调用都补写 call/result 事件对并结束（[packages/core/agent-loop/src/tool-calls.ts:94-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L94-L99)）
- `parseArguments` 把空串映射为 `{}`，把无法解析的 JSON 原样保留为文本（[packages/core/agent-loop/src/tool-calls.ts:104-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L104-L110)）
- 每组开始时从 `ctx.agentLoop.config` 读一次 `maxParallelToolCalls`，在飞的一组不受随后改动影响（[packages/core/agent-loop/src/tool-calls.ts:130-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L130-L131)）
- `commitReady` 只沿模型顺序的连续槽位推进提交，按需调 finalize 或 finish（[packages/core/agent-loop/src/tool-calls.ts:146-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L146-L153)）
- 提交时写结果事件、把 `additionalContexts` 逐条交给接收器，并累积 `concludesTurn`（[packages/core/agent-loop/src/tool-calls.ts:154-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L154-L159)）
- `startCall` 先追加 `tool/call` 并记住其 seq，再走调度器 prepare（[packages/core/agent-loop/src/tool-calls.ts:164-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L164-L170)）
- prepare 的三种结果分流：`dispatch` 真派发并把失败记为调度器故障，`post-result` 与 `final-result` 直接填槽并区分是否还要 finalize（[packages/core/agent-loop/src/tool-calls.ts:171-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L171-L195)）
- `fillPool` 在未中止、还有待办且在飞数小于上限时继续起新调用（[packages/core/agent-loop/src/tool-calls.ts:198-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L198-L200)）
- 并行组里对后续调用重新分类，一旦不再是 `parallel` 就停止补位，把它留给下一次屏障（[packages/core/agent-loop/src/tool-calls.ts:201-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L201-L205)）
- 每起一个调用后立刻提交就绪槽位，并检查等待期间是否已中止（[packages/core/agent-loop/src/tool-calls.ts:206-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L206-L212)）
- 主循环用 `Promise.race` 取最先结算的在飞调用，提交、复查中止、再补位（[packages/core/agent-loop/src/tool-calls.ts:218-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L218-L230)）
- 调度器故障停止新派发，等所有已派发调用结算后抛出第一个故障，不伪造任何工具结果（[packages/core/agent-loop/src/tool-calls.ts:231-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L231-L235)）
- 中止时把本组里尚未启动的调用逐个补上合成结果，并声明整组已消费（[packages/core/agent-loop/src/tool-calls.ts:237-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L237-L242)）
- 未派发调用的合成结果固定为文本 `Error: tool call aborted before dispatch`，错误码为 `TOOL_ABORTED_BEFORE_DISPATCH`、name 为 `AbortError`（[packages/core/agent-loop/src/tool-calls.ts:249-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L249-L259)）
- `appendToolCall` 写入 turn、step、callId、name 与原始参数字符串，并返回事件 seq（[packages/core/agent-loop/src/tool-calls.ts:262-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L262-L265)）
- `appendToolResult` 以 `surfaceOp: 'append'` 写 `tool/result`，引用对应 call 的 seq，并按需带上错误信息与工具私有的展示 meta（[packages/core/agent-loop/src/tool-calls.ts:268-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L268-L289)）

### packages/core/agent-loop/tsconfig.json

包的 TypeScript 编译配置，声明源目录、类型输出目录与对工作区依赖的项目引用。

- 无运行期机制

### packages/core/agent-loop/tsdown.config.ts

tsdown 打包配置，决定该包发布产物里有哪些可加载的 JS 文件。

- 把根入口与 invariant 伴随分别打成 `lib/index.js` 和 `lib/invariant.js` 两个互相独立的 ESM 包，目标 es2024、平台 node（[packages/core/agent-loop/tsdown.config.ts:4-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/tsdown.config.ts#L4-L25)）
