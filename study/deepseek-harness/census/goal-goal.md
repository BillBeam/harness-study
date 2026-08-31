---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/goal/goal
---

# packages/goal/goal

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、69 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/goal/goal/README.md

包 README，介绍目标服务的配置项、生命周期动词、持久化与观察方式。

- 无运行期机制

### packages/goal/goal/package.json

npm 清单，声明该包的入口与发布内容。

- `type: module` 与 `main`/`types` 指向 `lib/index.js`，决定运行期加载的模块（[packages/goal/goal/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./types`、`./client`、`./typert`、`./remote`、`./src/*`、`./package.json` 映射到具体文件，其余子路径不可被导入（[packages/goal/goal/package.json:16-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/package.json#L16-L43)）
- `files` 白名单限定发布制品的文件集合（[packages/goal/goal/package.json:44-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/package.json#L44-L53)）

### packages/goal/goal/src/client.ts

客户端命名空间出口，纯转发 `./types.ts` 的类型。

- 无运行期机制

### packages/goal/goal/src/domain.ts

宿主侧目标域词汇：持久变更载荷、消息归属、折叠结果、错误码与 `goal/changed` 事件的类型声明。

- 无运行期机制

### packages/goal/goal/src/types.ts

纯类型出口：目标 id/ref/快照/视图，以及 `goal` 投影键的声明合并。

- 无运行期机制

### packages/goal/goal/src/runtime.ts

目标域的运行期构造器与协议常量，被 fold 与服务共同引用。

- `GOAL_CHANGE_VERSION` 固定为 1，是解码器接受的持久变更版本（[packages/goal/goal/src/runtime.ts:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/runtime.ts#L8)）
- `GoalError` 继承 `HarnessError`，把稳定的机器可路由代码带到调用方与工具结果里（[packages/goal/goal/src/runtime.ts:20-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/runtime.ts#L20-L30)）

### packages/goal/goal/src/fold.ts

对持久 `goal/change` 事件与目标来源用户消息的严格解码与重放折叠，被服务缓存、投影和不变量伴生插件共用。

- `SNAPSHOT_OPERATIONS` 与 `PHASES` 两个集合限定可被接受的操作名与阶段名（[packages/goal/goal/src/fold.ts:16-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L16-L24)）
- `emptyGoalFoldState` 生成无当前目标、轮次为 0、已见 id 集合为空的重放累加器（[packages/goal/goal/src/fold.ts:40-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L40-L49)）
- `positiveInteger` 与 `nonNegativeInteger` 对数值字段抛错，重放在非安全整数或越界时失败（[packages/goal/goal/src/fold.ts:57-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L57-L70)）
- `decodeBlockReason` 要求恰好 `code,message` 两个字段、code 匹配小写连字符正则、message 非空且已 trim（[packages/goal/goal/src/fold.ts:73-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L73-L85)）
- `decodeSnapshot` 校验 id 非空、objective 非空且已 trim、phase 在集合内，并按阶段要求精确的字段名集合（blocked 才允许 `blockedReason`）（[packages/goal/goal/src/fold.ts:88-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L88-L115)）
- `decodeRef` 要求墓碑恰好携带 `id,revision` 且 revision 为正整数（[packages/goal/goal/src/fold.ts:118-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L118-L126)）
- `decodeGoalChange` 对非 `goal/change` 值返回 undefined，对版本不符抛错，并按 clear 与快照两支各自要求精确字段集合（[packages/goal/goal/src/fold.ts:134-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L134-L159)）
- 快照变更要求 `updatedAt` 不早于 `createdAt`（[packages/goal/goal/src/fold.ts:160-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L160-L162)）
- `goalSource` 只放行 `kind === 'goal'` 的消息来源，并要求 goalId 非空、revision 与 round 均为不小于 1 的安全整数（[packages/goal/goal/src/fold.ts:175-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L175-L183)）
- `requireSameDefinition` 禁止 edit 以外的操作改动 objective 或 maxGoalRounds（[packages/goal/goal/src/fold.ts:186-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L186-L190)）
- `requireNextRevision` 要求变更的 id 不变且 revision 恰好加一（[packages/goal/goal/src/fold.ts:193-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L193-L197)）
- `validateSnapshotTransition` 要求 createdAt 不变、updatedAt 非回退、roundsStarted 不变（[packages/goal/goal/src/fold.ts:200-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L200-L213)）
- 按操作分支限定阶段迁移：edit 不得改阶段或 blockedReason，pause 只能 active→paused，resume 只能从 active/paused/blocked 到 active 且轮次未耗尽，complete 不得从 complete 再来，block 只能 active→blocked（[packages/goal/goal/src/fold.ts:214-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L214-L252)）
- `goalChangeRef` 从快照或墓碑取出用于对账的 `{id, revision}`（[packages/goal/goal/src/fold.ts:260-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L260-L264)）
- `applyGoalChange` 的 clear 支要求存在当前目标、墓碑为下一 revision、时间戳不早于当前 updatedAt，随后把目标、轮次与时间戳全部清空并只保留 lastRef（[packages/goal/goal/src/fold.ts:273-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L273-L288)）
- create 支要求 revision 为 1、阶段为 active、轮次为 0、前一目标必须已 complete，且 goal id 从未出现过，并把 id 记入已见集合（[packages/goal/goal/src/fold.ts:289-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L289-L295)）
- 非 create 支要求存在当前目标并走迁移校验，通过后整体替换目标、轮次、时间戳与 lastRef（[packages/goal/goal/src/fold.ts:296-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L296-L306)）
- `applyGoalEvent` 对 `goal/change` 事件解码后应用，解码失败即让重放失败（[packages/goal/goal/src/fold.ts:313-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L313-L320)）
- `user/message` 携带目标来源时，必须是当前 active 目标同一 id/revision 的下一轮且不超过轮次上限，否则抛错；通过后推进 `roundsStarted`（[packages/goal/goal/src/fold.ts:321-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L321-L331)）
- `foldGoal` 顺序重放整段事件并返回脱离内部状态的拷贝，不含 activation（[packages/goal/goal/src/fold.ts:339-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/fold.ts#L339-L349)）

### packages/goal/goal/src/index.ts

插件入口：`GoalService`（`ctx.goals`）、配置模式、比较并置换的变更方法、进程内 activation 缓存与 `goal` 投影单元。

- `goalProjectionSchema` 定义 `goal` 投影的状态/线上载荷校验（[packages/goal/goal/src/index.ts:66-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L66-L81)）
- `applyGoalProjection` 对非 `goal/change` 或解码失败的事件返回同一引用，clear 折成 `null`，其余以整值覆盖（[packages/goal/goal/src/index.ts:96-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L96-L113)）
- `resolveMaxGoalRounds` 拒绝非正安全整数的轮次上限并带 `GOAL_INVALID_MAX_ROUNDS` 码（[packages/goal/goal/src/index.ts:142-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L142-L147)）
- `resolveObjective` 拒绝空白目标文本并对入库文本做 trim（[packages/goal/goal/src/index.ts:150-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L150-L155)）
- `resolveCreateGoal` 在提交前把部署默认轮次上限物化进创建请求（[packages/goal/goal/src/index.ts:158-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L158-L163)）
- `resolveBlockReason` 要求小写连字符 code 与非空 message，并返回 trim 后的脱离拷贝（[packages/goal/goal/src/index.ts:166-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L166-L180)）
- 服务注入 `agents`，并以 `defaultMaxGoalRounds` 默认 256 的 schemastery 配置暴露给 cordis.yml（[packages/goal/goal/src/index.ts:184-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L184-L188)）
- 构造时校验并固化默认轮次上限（[packages/goal/goal/src/index.ts:195-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L195-L197)）
- 监听 `agent/session-start`，把该会话缓存的 activation 置为 `disarmed`（[packages/goal/goal/src/index.ts:198-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L198-L200)）
- 在注入到 `sessionProjections` 时注册 key 为 `goal`、`init` 为 null、`stateVersion` 为 4 的投影单元（[packages/goal/goal/src/index.ts:204-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L204-L213)）
- `get()` 校验 agent 存活、增量同步缓存后返回脱离视图或 undefined（[packages/goal/goal/src/index.ts:222-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L222-L227)）
- `disarm()` 只把进程内 activation 改为 disarmed，不写 revision、不发事件（[packages/goal/goal/src/index.ts:236-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L236-L242)）
- `create()` 在当前目标存在且非 complete 时以 `GOAL_ALREADY_EXISTS` 拒绝，否则以 `goal-<uuid>` 新建 revision 1 的 active 目标并提交为 armed（[packages/goal/goal/src/index.ts:251-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L251-L267)）
- 带 `@Remote('edit')` 的 `edit()` 要求至少一个替换字段，递增 revision 并保持当前 activation 提交（[packages/goal/goal/src/index.ts:276-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L276-L290)）
- 带 `@Remote('pause')` 的 `pause()` 只接受 active，写入 paused 并置 disarmed（[packages/goal/goal/src/index.ts:298-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L298-L301)）
- 带 `@Remote('resume')` 的 `resume()` 只接受 active/paused/blocked，拒绝已 armed 的 active，拒绝轮次已耗尽，通过后写入 active 并置 armed（[packages/goal/goal/src/index.ts:310-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L310-L328)）
- `complete()` 接受 active/paused/blocked，写入 complete 并置 disarmed（[packages/goal/goal/src/index.ts:336-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L336-L346)）
- `block()` 只接受 active，写入 blocked 与校验过的 blockedReason 并置 disarmed（[packages/goal/goal/src/index.ts:355-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L355-L368)）
- 带 `@Remote('clear')` 的 `clear()` 追加 revision 加一的 clear 墓碑事件、置 disarmed，并把墓碑 ref 返回给调用方（[packages/goal/goal/src/index.ts:376-390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L376-L390)）
- `expectCurrent()` 在无当前目标时报 `GOAL_NOT_FOUND`，在 id 或 revision 不匹配时报 `GOAL_STALE_REVISION`（[packages/goal/goal/src/index.ts:401-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L401-L411)）
- `assertLive()` 要求注册表中同 id 的实例与传入对象严格相同，否则报 `GOAL_AGENT_NOT_LIVE`（[packages/goal/goal/src/index.ts:414-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L414-L418)）
- `cache()` 首次访问某会话时重放整段事件建立折叠状态，并把 activation 初始化为 disarmed（[packages/goal/goal/src/index.ts:421-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L421-L434)）
- `sync()` 增量消费新事件；每遇一条 `goal/change`，只有 seq 与本次提交登记的 pendingActivation 相符才采用其 activation，否则一律回落为 disarmed（[packages/goal/goal/src/index.ts:437-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L437-L447)）
- `transition()` 把允许阶段集合、目标阶段与目标 activation 组合成一次受校验的提交（[packages/goal/goal/src/index.ts:461-473](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L461-L473)）
- `transitionError()` 生成固定措辞、带 `GOAL_INVALID_TRANSITION` 码的拒绝（[packages/goal/goal/src/index.ts:476-481](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L476-L481)）
- `commitCurrent()` 让非 create 变更沿用当前 createdAt 与 roundsStarted（[packages/goal/goal/src/index.ts:484-504](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L484-L504)）
- `nextMutationTime()` 取 `Math.max(Date.now(), updatedAt)`，墙钟回退时把时间戳钳到不回退（[packages/goal/goal/src/index.ts:507-512](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L507-L512)）
- `commitSnapshot()` 组装 `kind: 'goal/change'`、version 1 的完整快照载荷后提交并回读视图（[packages/goal/goal/src/index.ts:515-539](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L515-L539)）
- `commit()` 先登记 pendingActivation，再向会话日志追加 `goal/change` 事件并同步缓存，最后按 agent 作用域 emit `goal/changed` 通知（[packages/goal/goal/src/index.ts:542-558](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L542-L558)）
- `view()` 把快照、roundsStarted、两个时间戳与进程内 activation 合成一份脱离的 `GoalView`（[packages/goal/goal/src/index.ts:561-577](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L561-L577)）
- `remoteExportCreate` 以 `@Remote('create')` 暴露远端创建入口，只回传 `{id, revision}` 而非完整视图（[packages/goal/goal/src/index.ts:585-589](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L585-L589)）
- 默认导出 `GoalService` 供 Loader 作为服务插件挂载（[packages/goal/goal/src/index.ts:592](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/index.ts#L592)）

### packages/goal/goal/src/invariant.ts

包自有的不变量伴生插件，对每个附着会话独立做一遍严格目标折叠。

- 声明插件名与对 `invariants` 服务的注入（[packages/goal/goal/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/invariant.ts#L12-L15)）
- `applyChecked` 捕获严格折叠抛出的错误并转成带事件 seq 的 `fail` 报告（[packages/goal/goal/src/invariant.ts:29-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/invariant.ts#L29-L37)）
- 安装时对 `ctx.sessions.list()` 里已有会话逐条重放建立种子状态，并在 `session/created` 时为新会话再建（[packages/goal/goal/src/invariant.ts:44-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/invariant.ts#L44-L54)）
- 在 `internal/dispatch` 上先于 `session/event` 发布，用克隆状态校验候选事件并暂存结果（[packages/goal/goal/src/invariant.ts:55-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/invariant.ts#L55-L61)）
- `session/event` 时要求存在匹配的暂存校验，否则报失败；匹配则把校验后的状态提交为该会话的新状态（[packages/goal/goal/src/invariant.ts:62-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/invariant.ts#L62-L70)）
- `apply` 以包名向 `invariants` 注册该安装器并返回其 disposer（[packages/goal/goal/src/invariant.ts:78-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/src/invariant.ts#L78-L79)）

### packages/goal/goal/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制

### packages/goal/goal/tsdown.config.ts

打包配置，产出该包发布时被 `exports` 指向的运行期文件。

- 把 `lib/types/index.js` 与 `lib/types/invariant.js` 分别打成 `lib/index.js`、`lib/invariant.js` 两个独立 ESM node 包，即 `.` 与 `./invariant` 实际加载的产物（[packages/goal/goal/tsdown.config.ts:4-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/goal/tsdown.config.ts#L4-L25)）
