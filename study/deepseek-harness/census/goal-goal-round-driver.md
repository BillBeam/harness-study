---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/goal/goal-round-driver
---

# packages/goal/goal-round-driver

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、49 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/goal/goal-round-driver/README.md

包 README，说明该驱动如何在同一会话里自动续跑目标轮次、何时停止以及与目标服务和目标工具的分工。

- 无运行期机制

### packages/goal/goal-round-driver/package.json

npm 清单，声明该驱动包的入口与发布内容。

- `type: module` 与 `main`/`types` 指向 `lib/index.js`，决定运行期加载的模块（[packages/goal/goal-round-driver/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/package.json#L13-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个入口（[packages/goal/goal-round-driver/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/package.json#L16-L27)）
- `files` 白名单限定发布制品的文件集合（[packages/goal/goal-round-driver/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/package.json#L28-L32)）

### packages/goal/goal-round-driver/src/index.ts

插件入口：按代理状态机在空闲点预约并投递下一轮目标提示，同时安装一整套竞态围栏与拆卸逻辑。

- 导出插件名并注入 `agents`、`goals`、`sessions` 三个服务（[packages/goal/goal-round-driver/src/index.ts:18-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L18-L19)）
- `isGoalRoundSource` 只把 `kind === 'goal'` 且 round 为正的来源认作自动轮次（[packages/goal/goal-round-driver/src/index.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L49-L51)）
- `sameQueued` 用 goalId/revision/round 三元组加内容深比较来判定排队消息是否就是本驱动的预约（[packages/goal/goal-round-driver/src/index.ts:54-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L54-L63)）
- `currentGoal` 只在注册表里同 id 的实例仍是这个对象时才读目标状态（[packages/goal/goal-round-driver/src/index.ts:97-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L97-L100)）
- `readyToDrive` 要求 fiber 处于 ACTIVE、未在停机、代理仍存活且状态为 idle、且没有竞争排队消息（[packages/goal/goal-round-driver/src/index.ts:103-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L103-L109)）
- `disarm` 在目标仍为 armed 时调用 `ctx.goals.disarm` 撤掉自动续跑权限，失败只打 warn（[packages/goal/goal-round-driver/src/index.ts:117-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L117-L124)）
- `restoreOtherClaimed` 在丢弃本驱动自己的消息时，把其余已认领消息按逆序重新 prepend 回 next-step 收件箱（[packages/goal/goal-round-driver/src/index.ts:127-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L127-L135)）
- `drive` 在有待办检查点时先 `await ctx.sessions.flush(agent.session)`，落盘失败即 disarm 并放弃本轮（[packages/goal/goal-round-driver/src/index.ts:142-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L142-L151)）
- flush 之后重新复核全部条件，条件变化则本轮不再预约（[packages/goal/goal-round-driver/src/index.ts:152-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L152-L154)）
- 已存在一次尝试时清空它、置回检查点待办并重排一次驱动，而不是叠加第二次预约（[packages/goal/goal-round-driver/src/index.ts:156-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L156-L162)）
- 目标不存在、非 active 或非 armed 时不产生任何轮次（[packages/goal/goal-round-driver/src/index.ts:164-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L164-L165)）
- 已达轮次上限时用稳定代码 `round-limit` 把目标置为 blocked 并停止续跑（[packages/goal/goal-round-driver/src/index.ts:166-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L166-L172)）
- 预约 `roundsStarted + 1`，渲染目标轮次提示并以 `{kind:'goal', goalId, revision, round}` 来源构造用户消息，再经 `agent.followup` 入队（[packages/goal/goal-round-driver/src/index.ts:174-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L174-L192)）
- 入队抛错时撤销预约，并在目标仍是同一 armed revision 时用代码 `queue-failed` 置 blocked（[packages/goal/goal-round-driver/src/index.ts:193-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L193-L204)）
- `requestDrive` 把所有触发合并到每个代理一条串行任务上，在 `ctx.agents.withoutInitiator()` 里循环消费 requested 标志（[packages/goal/goal-round-driver/src/index.ts:208-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L208-L231)）
- 驱动任务结束后 retire 会在仍有待办且未停机时再起一轮；任务本身 reject 则先 disarm 再 retire（[packages/goal/goal-round-driver/src/index.ts:232-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L232-L240)）
- 整套监听器装在一个 `ctx.effect` 复合效果里，使步骤围栏在自身调度任务结算前不被摘除（[packages/goal/goal-round-driver/src/index.ts:245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L245)）
- `agent/error` 直接 disarm 该代理的目标（[packages/goal/goal-round-driver/src/index.ts:246-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L246-L249)）
- `agent/disposed` 删除该代理的驱动状态（[packages/goal/goal-round-driver/src/index.ts:251-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L251-L252)）
- `agent/session-start` 清空进行中的预约、竞争标志与检查点待办（[packages/goal/goal-round-driver/src/index.ts:253-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L253-L258)）
- `agent/status` 变为 idle 时清竞争标志；若尚有排队/已认领/已取消的预约而目标仍是 active+armed，则把目标 pause，然后请求一次驱动（[packages/goal/goal-round-driver/src/index.ts:259-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L259-L277)）
- `goal/changed` 置检查点待办并请求一次驱动（[packages/goal/goal-round-driver/src/index.ts:278-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L278-L282)）
- `agent/inbox/inserted` 里出现非本驱动的下一轮消息时置竞争标志，并把排队中的预约标记为 stale（[packages/goal/goal-round-driver/src/index.ts:284-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L284-L291)）
- `agent/inbox/claimed` 把匹配的预约推进为 claimed，`agent/inbox/discarded` 把它标为 cancelled（[packages/goal/goal-round-driver/src/index.ts:292-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L292-L305)）
- `session/event` 上 `user/message` 的 id 与预约相同即推进为 admitted（[packages/goal/goal-round-driver/src/index.ts:307-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L307-L316)）
- `turn/end` 原因为 max-tokens 时直接 disarm；原因为 aborted 时，若预约已 claimed/admitted 则标为 cancelled，否则 disarm（[packages/goal/goal-round-driver/src/index.ts:317-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L317-L330)）
- `validReservation` 以 fiber 状态、非停机、预约处于 claimed 且未 stale、内容与来源全等、目标 id/revision/阶段/armed 一致、round 恰为下一轮为通过条件（[packages/goal/goal-round-driver/src/index.ts:333-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L333-L347)）
- `agent/pre-step` 对不含目标来源消息的步骤直接 `next()` 放行（[packages/goal/goal-round-driver/src/index.ts:349-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L349-L353)）
- 下游前校验不通过时把预约作废、恢复其余已认领消息、请求重排，并返回 `{kind:'reject'}` 使该步骤不进入（[packages/goal/goal-round-driver/src/index.ts:362-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L362-L371)）
- 下游监听器抛错且未被中止时，先清空预约并请求重排再把错误抛出（[packages/goal/goal-round-driver/src/index.ts:373-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L373-L383)）
- 信号已中止时按下游决定返回，并在 enter 分支恢复其余已认领消息（[packages/goal/goal-round-driver/src/index.ts:384-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L384-L387)）
- 下游返回 reject 时清空预约，并在目标仍是同一 armed revision 时用代码 `prompt-rejected` 置 blocked（[packages/goal/goal-round-driver/src/index.ts:388-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L388-L399)）
- 下游返回 enter 后再校验一次，仍有效才放行，且给决定打上 `startsRequestSeries: true`（[packages/goal/goal-round-driver/src/index.ts:400-413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L400-L413)）
- 安装时遍历已存在代理逐个 disarm，插件挂载不继承此前的自动续跑权限（[packages/goal/goal-round-driver/src/index.ts:418-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L418-L421)）
- 拆卸时对每个状态置 stopping、disarm、把预约标 stale，对运行中的代理以 `{kind:'parent'}` 取消并等待其空闲，再等所有驱动任务结算后清空状态表（[packages/goal/goal-round-driver/src/index.ts:425-443](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/index.ts#L425-L443)）

### packages/goal/goal-round-driver/src/prompt.ts

被驱动与不变量伴生插件共用的纯函数，生成进入会话历史的目标轮次提示。

- `renderGoalRoundPrompt` 返回单个 text 块，内含 `<goal_round>` 标签、JSON 引号化的 objective 与 `round/maxGoalRounds`（[packages/goal/goal-round-driver/src/prompt.ts:12-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/prompt.ts#L12-L17)）
- 提示正文要求模型以当前工作区、工具结果与持久会话状态为准，做出可验证的进展，并在声称完成前先读目标再标记完成（[packages/goal/goal-round-driver/src/prompt.ts:18-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/prompt.ts#L18-L25)）

### packages/goal/goal-round-driver/src/invariant.ts

包自有的不变量伴生插件，检查每条目标来源用户消息的内容是否与本包提示渲染结果一致。

- 声明插件名与对 `invariants` 服务的注入（[packages/goal/goal-round-driver/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/invariant.ts#L13-L15)）
- `foldChecked` 把严格目标折叠的异常转成 `fail` 报告（[packages/goal/goal-round-driver/src/invariant.ts:18-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/invariant.ts#L18-L26)）
- `goalView` 由前缀折叠重建视图，并要求目标存在、为 active、id/revision 匹配、round 恰为下一轮且不超上限，否则失败（[packages/goal/goal-round-driver/src/invariant.ts:29-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/invariant.ts#L29-L43)）
- `validateEvent` 只挑目标来源且 round 为正的 `user/message`，把重渲染结果与事件内容做深比较，不等即失败（[packages/goal/goal-round-driver/src/invariant.ts:46-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/invariant.ts#L46-L58)）
- 安装时先遍历已有会话逐条累积前缀校验，再在 `internal/dispatch` 上于 `session/event` 发布前校验候选事件（[packages/goal/goal-round-driver/src/invariant.ts:61-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/invariant.ts#L61-L75)）
- `apply` 以包名向 `invariants` 注册该安装器并返回其 disposer（[packages/goal/goal-round-driver/src/invariant.ts:82-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/src/invariant.ts#L82-L84)）

### packages/goal/goal-round-driver/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制

### packages/goal/goal-round-driver/tsdown.config.ts

打包配置，产出该包发布时被 `exports` 指向的运行期文件。

- 把 `lib/types/index.js` 与 `lib/types/invariant.js` 分别打成 `lib/index.js`、`lib/invariant.js` 两个独立 ESM node 包，即 `.` 与 `./invariant` 实际加载的产物（[packages/goal/goal-round-driver/tsdown.config.ts:4-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal-round-driver/tsdown.config.ts#L4-L25)）
