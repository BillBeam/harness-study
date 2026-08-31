---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/compaction/compaction-basic
---

# packages/compaction/compaction-basic

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、114 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/compaction/compaction-basic/README.md

包的说明文档，描述该压缩后端的配置项、触发方式与模型可见文本，供使用者阅读。

- 无运行期机制

### packages/compaction/compaction-basic/package.json

npm 包清单，声明该压缩后端的入口、发布产物与依赖关系。

- `main`/`types`/`exports."."` 把包名解析到 `lib/index.js` 与其类型声明（[packages/compaction/compaction-basic/package.json:14-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/package.json#L14-L20)）
- `exports."./invariant"` 暴露 invariant 伴生插件子路径，`exports."./src/*"` 暴露源码路径（[packages/compaction/compaction-basic/package.json:21-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/package.json#L21-L26)）
- `files` 限定发布内容为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/compaction/compaction-basic/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/package.json#L28-L32)）
- `peerDependenciesMeta` 把工具结果裁剪包标为可选，使其缺席时依旧可装载（[packages/compaction/compaction-basic/package.json:45-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/package.json#L45-L49)）

### packages/compaction/compaction-basic/src/config.ts

压缩后端的配置校验与按路由模型解析策略的模块，被 `src/index.ts` 在构造与每次压缩决策时调用。

- 默认压力比 `0.8`、默认保留比 `0.16` 两个常量（[packages/compaction/compaction-basic/src/config.ts:19-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L19-L23)）
- `TargetPressureConfigError` 携带 provider/model 组成的 targetKey，供上层按目标去重告警（[packages/compaction/compaction-basic/src/config.ts:52-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L52-L60)）
- `resolveConfig` 先按白名单拒绝未知顶层键，再校验策略字段，并要求 `auto` 为布尔（[packages/compaction/compaction-basic/src/config.ts:67-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L67-L72)）
- 解析顶层保留形式后校验比例型保留必须小于阈值比（[packages/compaction/compaction-basic/src/config.ts:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L74-L76)）
- 对每条按模型覆盖项，用合并后的阈值比与保留形式重复做同一校验（[packages/compaction/compaction-basic/src/config.ts:77-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L77-L84)）
- 返回 `deepFreeze` 的配置，并补齐 `summarizationProvider`/`summarizationModel` 为空串、`maxTokens` 为 8192、`compactionRetries` 与 `maxOverflowRetries` 为 1、`auto` 为 true（[packages/compaction/compaction-basic/src/config.ts:86-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L86-L96)）
- `resolveTargetPolicy` 按 provider 与 model 精确匹配找覆盖项，逐字段以覆盖优先于默认合并（[packages/compaction/compaction-basic/src/config.ts:105-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L105-L125)）
- 继承保留形式时按顶层是否给出 `retainTokens` 二选一传下去（[packages/compaction/compaction-basic/src/config.ts:112-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L112-L114)）
- `resolveCompactSpec` 对非正整数上下文容量抛出目标相关的配置错误（[packages/compaction/compaction-basic/src/config.ts:137-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L137-L143)）
- 阈值 token 数取 `floor(contextWindow × thresholdRatio)`，保留 token 数取绝对值或 `floor(contextWindow × retainRatio)`（[packages/compaction/compaction-basic/src/config.ts:144-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L144-L147)）
- 保留 token 数不小于阈值 token 数时抛出目标相关的配置错误（[packages/compaction/compaction-basic/src/config.ts:148-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L148-L154)）
- 返回冻结的规格，携带容量、阈值、保留额、摘要目标、`maxTokens` 与两个重试次数（[packages/compaction/compaction-basic/src/config.ts:155-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L155-L166)）
- `resolveRetention` 的优先级为 `retainTokens` 高于 `retainRatio`，都缺省则继承回退值（[packages/compaction/compaction-basic/src/config.ts:170-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L170-L177)）
- `validateRatioRetention` 在装载期拒绝保留比不小于阈值比（[packages/compaction/compaction-basic/src/config.ts:180-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L180-L191)）
- `resolveModelPolicies` 要求数组、逐项校验、以 provider+model 为键拒绝重复目标并逐项浅拷贝（[packages/compaction/compaction-basic/src/config.ts:194-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L194-L212)）
- `assertModelPolicy` 要求覆盖项是对象、键在白名单内、provider 与 model 为非空字符串（[packages/compaction/compaction-basic/src/config.ts:215-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L215-L224)）
- `validatePolicy` 校验两个比例、保留 token、`maxTokens` 与两个重试次数，并拒绝 `retainRatio` 与 `retainTokens` 同时出现（[packages/compaction/compaction-basic/src/config.ts:227-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L227-L252)）
- `validateSummarizationPair` 要求摘要 provider 与 model 成对出现且同为空或同为非空（[packages/compaction/compaction-basic/src/config.ts:255-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L255-L275)）
- `validateKeys` 遍历实际键并对不在白名单的键抛错（[packages/compaction/compaction-basic/src/config.ts:278-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L278-L282)）
- `assertRatio` 把比例限制在开区间左端、闭区间右端的 (0, 1]（[packages/compaction/compaction-basic/src/config.ts:306-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/config.ts#L306-L310)）

### packages/compaction/compaction-basic/src/index.ts

插件入口，定义 `BasicCompactionEngine` 服务类、自动压缩监听器与三条压缩入口的分派。

- `routedTarget` 从会话最新请求头读取 provider/model，任一为空则返回 undefined（[packages/compaction/compaction-basic/src/index.ts:52-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L52-L60)）
- `conversationTarget` 在无已路由目标时回退到 `agent.options` 上的 provider/model（[packages/compaction/compaction-basic/src/index.ts:62-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L62-L71)）
- `modelPolicy` 与 `Config` 的 schemastery 声明决定 Loader 接受的配置字段与数值约束（[packages/compaction/compaction-basic/src/index.ts:73-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L73-L117)）
- `static inject` 声明需要 `llm`、`tokenMeter`、`sessions` 三个服务后才装载（[packages/compaction/compaction-basic/src/index.ts:104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L104)）
- 构造函数解析配置，仅当 `auto` 为真时注册自动压缩监听（[packages/compaction/compaction-basic/src/index.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L126-L130)）
- `logResult` 把被遮蔽节点数、seq 区间与估算 token 数写入日志（[packages/compaction/compaction-basic/src/index.ts:139-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L139-L145)）
- `agent/pre-step` 监听器在未取消时以 `pressure` 触发调用 `compactIfNeeded`，异常只告警并总是 `next()` 放行本步（[packages/compaction/compaction-basic/src/index.ts:147-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L147-L165)）
- 同一 targetKey 的目标压力配置错误只告警一次，之后直接放行（[packages/compaction/compaction-basic/src/index.ts:156-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L156-L159)）
- `agent/status` 转为 idle 时清除该 agent 的溢出重试计数（[packages/compaction/compaction-basic/src/index.ts:167-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L167-L169)）
- 会话上出现 `assistant/message` 事件时清除该 agent 的溢出重试计数（[packages/compaction/compaction-basic/src/index.ts:173-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L173-L177)）
- `agent/request-error` 仅对 `CONTEXT_WINDOW_EXCEEDED` 且未取消的失败介入，其余放行（[packages/compaction/compaction-basic/src/index.ts:179-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L179-L184)）
- 无已路由目标，或重试次数已达该目标的 `maxOverflowRetries` 时放行（[packages/compaction/compaction-basic/src/index.ts:185-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L185-L189)）
- 恢复前记录 `surface.replaceGeneration`，以之判定是否发生了持久的表面替换（[packages/compaction/compaction-basic/src/index.ts:191-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L191-L194)）
- 恢复过程抛错但未取消且替换代数已推进时，计数加一并返回 `{ kind: 'retry' }`（[packages/compaction/compaction-basic/src/index.ts:195-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L195-L208)）
- 恢复抛错且无表面推进时告警并放行，保留原始请求错误（[packages/compaction/compaction-basic/src/index.ts:209-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L209-L216)）
- 恢复成功后仍要求未取消且替换代数推进，才计数加一并授权重试（[packages/compaction/compaction-basic/src/index.ts:217-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L217-L222)）
- `summarize` 按对话目标解析策略后调用 `summarizeWithLlm`，是唯一的子类替换点（[packages/compaction/compaction-basic/src/index.ts:236-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L236-L246)）
- `compactIfNeeded` 在无已路由目标时直接返回 null（[packages/compaction/compaction-basic/src/index.ts:263-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L263-L264)）
- 通过 `ctx.tokenMeter.measure(session)` 取得压力与逐节点计价（[packages/compaction/compaction-basic/src/index.ts:265-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L265-L267)）
- 触发类型走封闭联合分支，未知值落到 `assertNever`（[packages/compaction/compaction-basic/src/index.ts:268-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L268-L276)）
- 用 `ctx.get('toolResultPruner')` 读取可选的裁剪服务，缺席时跳过裁剪（[packages/compaction/compaction-basic/src/index.ts:281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L281)）
- 溢出触发路径先裁剪并重新计量，再以保留额 0 选区并直接压缩，选不出区间时返回 null（[packages/compaction/compaction-basic/src/index.ts:283-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L283-L291)）
- 压力路径向 `ctx.llm.resolveModelInfo` 取上下文容量，并复检压缩锁未被占用（[packages/compaction/compaction-basic/src/index.ts:293-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L293-L294)）
- 适配器未给出容量时抛出携带 targetKey 的配置错误（[packages/compaction/compaction-basic/src/index.ts:295-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L295-L302)）
- 总 token 低于阈值 token 数时不压缩，返回 null（[packages/compaction/compaction-basic/src/index.ts:303-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L303-L304)）
- 越过阈值后先执行无模型裁剪并重新计量，若已降到阈值以下则不再摘要（[packages/compaction/compaction-basic/src/index.ts:306-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L306-L312)）
- 按 `compactionRetries + 1` 次循环选区并压缩，每次压缩后重新计量，降到阈值以下即返回结果（[packages/compaction/compaction-basic/src/index.ts:314-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L314-L326)）
- 用尽全部尝试仍高于阈值时抛出带尝试次数与 token 数的错误（[packages/compaction/compaction-basic/src/index.ts:328-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L328-L331)）
- `compactRegion` 以 `owner: 'current-turn'`、`stability: 'whole-surface'` 进入共享区间事务（[packages/compaction/compaction-basic/src/index.ts:343-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L343-L358)）
- `compactNow` 先检查取消，再通过 `agent.runMaintenance` 预约空闲准入（[packages/compaction/compaction-basic/src/index.ts:373-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L373-L375)）
- 手动压缩把维护信号与调用方信号用 `AbortSignal.any` 合并，并以保留额 0 选区（[packages/compaction/compaction-basic/src/index.ts:376-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L376-L384)）
- 手动压缩以 `owner: null`、`stability: 'selected-span'` 进入事务，带上来源命令 id 并在关闭后经 `ctx.sessions.flush` 落盘（[packages/compaction/compaction-basic/src/index.ts:385-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L385-L400)）
- 维护信号取消导致的失败被归类为 `cancelled` 的手动压缩错误，其他错误保持原样上抛（[packages/compaction/compaction-basic/src/index.ts:401-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L401-L411)）
- 无法取得空闲准入时抛出 `busy` 的手动压缩错误（[packages/compaction/compaction-basic/src/index.ts:413-419](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L413-L419)）
- `regionDependencies` 绑定当前 token 计量器与动态派发的 `summarize`，使子类覆盖在事务内生效（[packages/compaction/compaction-basic/src/index.ts:423-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L423-L428)）
- 默认导出服务类，供 Loader 按包名装载（[packages/compaction/compaction-basic/src/index.ts:431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L431)）

### packages/compaction/compaction-basic/src/invariant.ts

包自带的 invariant 伴生插件，由 `./invariant` 子路径导出。

- 声明插件名与对 `invariants` 服务的注入需求（[packages/compaction/compaction-basic/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/invariant.ts#L13-L15)）
- `apply` 向 invariants 注册本包名与一个空安装器，并返回注册的 disposer（[packages/compaction/compaction-basic/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/invariant.ts#L21-L29)）

### packages/compaction/compaction-basic/src/region.ts

选区与压缩事务模块，被 `src/index.ts` 的三条入口共用，负责在会话日志上写下压缩括号并替换表面区间。

- `selectCompactableRange` 在计价节点为空时返回 null（[packages/compaction/compaction-basic/src/region.ts:105-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L105-L106)）
- 计量器节点与会话当前表面不一致时抛错，拒绝在陈旧计量上选区（[packages/compaction/compaction-basic/src/region.ts:108-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L108-L112)）
- 从尾部向前累加节点 token，直到累计不少于保留额，确定保留起点（[packages/compaction/compaction-basic/src/region.ts:114-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L114-L121)）
- 保留起点落到 0 时返回 null，不压缩任何内容（[packages/compaction/compaction-basic/src/region.ts:122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L122)）
- 保留起点向前回退到工具调用/结果配对平衡的边界，回退到 0 则返回 null（[packages/compaction/compaction-basic/src/region.ts:124-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L124-L129)）
- 返回从表面首节点到保留起点前一个节点的闭区间（[packages/compaction/compaction-basic/src/region.ts:131-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L131-L135)）
- `compactSurfaceRegion` 对手动调用在入口先检查取消信号（[packages/compaction/compaction-basic/src/region.ts:163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L163)）
- 事务开始前校验区间并检查日志中的压缩锁未激活（[packages/compaction/compaction-basic/src/region.ts:164-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L164-L170)）
- `owner` 为 null 时要求会话没有开启中的轮次，否则抛 `busy`（[packages/compaction/compaction-basic/src/region.ts:172-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L172-L177)）
- `owner` 为 `current-turn` 时要求存在开启中的轮次并取其编号作为括号归属（[packages/compaction/compaction-basic/src/region.ts:178-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L178-L183)）
- 生成 `CompactionId` 并同步追加 `compaction/start` 事件，作为持久压缩锁（[packages/compaction/compaction-basic/src/region.ts:185-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L185-L191)）
- 按 `stability` 选择整表面不变或仅选中区间不变的复检函数（[packages/compaction/compaction-basic/src/region.ts:192-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L192-L194)）
- 主体流程为：准备计价与替换输入、等待摘要、手动路径再查取消、复检稳定性、提交替换体、追加 `compaction/end`（[packages/compaction/compaction-basic/src/region.ts:202-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L202-L219)）
- 任何失败都记录阶段并只做一次带错误链的 `compaction/end` 追加，关闭失败则留下未匹配的起始标记（[packages/compaction/compaction-basic/src/region.ts:220-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L220-L231)）
- 括号成功关闭且给了 flush 回调时执行落盘，并单独记录落盘失败（[packages/compaction/compaction-basic/src/region.ts:233-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L233-L239)）
- 清理与落盘之后手动路径再次检查取消，使取消优先于失败分类（[packages/compaction/compaction-basic/src/region.ts:241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L241)）
- 手动路径的失败经 `throwManualFailure` 分类，自动路径原样上抛（[packages/compaction/compaction-basic/src/region.ts:242-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L242-L245)）
- 落盘失败抛出 `persistence` 类别的手动压缩错误（[packages/compaction/compaction-basic/src/region.ts:246-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L246-L252)）
- `throwManualFailure` 把提交阶段失败、表面变更、摘要失败分别映射为 `commit`/`changed`/`summary` 三类手动压缩错误（[packages/compaction/compaction-basic/src/region.ts:259-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L259-L279)）
- `assertCompactionInactive` 在存在未匹配起始标记且其后没有更新的 `session/end-seed` 时抛 `busy`（[packages/compaction/compaction-basic/src/region.ts:288-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L288-L300)）
- 导出的 `assertNoActiveCompaction` 供异步策略决定后重查压缩锁（[packages/compaction/compaction-basic/src/region.ts:307-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L307-L314)）
- `validateSurfaceRegion` 要求起止 seq 都在当前表面上、起不晚于止，并且两端都是工具配对平衡边界（[packages/compaction/compaction-basic/src/region.ts:317-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L317-L338)）
- `prepareCompaction` 重新计量并切出选中节点，节点序列与选区不符时抛表面变更错误（[packages/compaction/compaction-basic/src/region.ts:341-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L341-L351)）
- 同时算出用于日志影子计价的启发式 token 总数与用于收缩比较的路由计价 token 总数（[packages/compaction/compaction-basic/src/region.ts:352-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L352-L363)）
- `summarizeCompaction` 调用摘要钩子并把结果框成带 `compactCheckpointSource` 来源的用户消息（[packages/compaction/compaction-basic/src/region.ts:367-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L367-L379)）
- 框好的检查点若不小于被遮蔽区间的路由计价则抛错，拒绝不收缩的替换（[packages/compaction/compaction-basic/src/region.ts:380-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L380-L388)）
- `assertWholeSurfaceUnchanged` 在摘要后深比较整张表面的计价节点，变化即拒绝（[packages/compaction/compaction-basic/src/region.ts:397-406](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L397-L406)）
- `assertSelectedSpanStable` 只要求选中区间仍是合法、同序、同计价的替换目标，区间外的追加不影响（[packages/compaction/compaction-basic/src/region.ts:413-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L413-L434)）
- `commitCompactionBody` 按是否经本上下文 `ctx.llm.stream()` 决定记录 `rawOutput` 与 `llmStreamCall` 的形式（[packages/compaction/compaction-basic/src/region.ts:454-456](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L454-L456)）
- 追加 `compaction/summary` 事件，携带原始摘要、被遮蔽区间与 seq 列表、影子 token 数、provider/model 与用量（[packages/compaction/compaction-basic/src/region.ts:457-471](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L457-L471)）
- 追加检查点 `user/message`，以 `surfaceOp: replace` 替换选中区间并引用起始、摘要与被遮蔽事件 seq（[packages/compaction/compaction-basic/src/region.ts:472-475](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L472-L475)）
- 返回的结果中带上压缩 id、来源命令 id、起始与摘要事件 seq、被遮蔽区间与 token 数（[packages/compaction/compaction-basic/src/region.ts:476-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L476-L487)）
- `completeCompaction` 把成功追加的关闭事件 seq 补进结果（[packages/compaction/compaction-basic/src/region.ts:491-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L491-L496)）
- `buildSummarizationInput` 取最近请求头的 system 与 tools，并按表面顺序把被遮蔽事件投影成消息、过滤掉空投影（[packages/compaction/compaction-basic/src/region.ts:508-524](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L508-L524)）
- `inspectCompactionEntryState` 从日志尾部反向扫描，分别定位开启轮次、未匹配压缩起始标记与最新 `session/end-seed`，三者都确定即提前退出（[packages/compaction/compaction-basic/src/region.ts:527-560](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/region.ts#L527-L560)）

### packages/compaction/compaction-basic/src/summarizer.ts

默认摘要实现与检查点框装模块，被 `src/index.ts` 的 `summarize` 与 `src/region.ts` 的框装步骤使用。

- 定义包住摘要正文的 `<compacted-summary>` 起止标签（[packages/compaction/compaction-basic/src/summarizer.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L20-L22)）
- `COMPACTION_INSTRUCTION` 逐字规定摘要模型必须输出的八个小节、写法规则、不得调用工具、以及遇到既有检查点时的合并方式（[packages/compaction/compaction-basic/src/summarizer.ts:31-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L31-L66)）
- `CHECKPOINT_PREAMBLE` 逐字规定落到会话里的检查点前言，要求模型把其中内容当既定背景继续任务且不作确认（[packages/compaction/compaction-basic/src/summarizer.ts:68-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L68-L70)）
- 摘要目标按「配置对 → 最近请求头 → `agent.options` 对」的顺序选取（[packages/compaction/compaction-basic/src/summarizer.ts:128-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L128-L138)）
- 三处都取不到目标时抛出指明三种补救方式的错误（[packages/compaction/compaction-basic/src/summarizer.ts:139-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L139-L143)）
- 请求消息为「重放的区间消息 + 一条来源标为本插件的指令用户消息」（[packages/compaction/compaction-basic/src/summarizer.ts:145-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L145-L152)）
- 生成参数逐字复用对话的 system 与 tools，带上 `maxTokens`、会话 id、`purpose: 'compaction'` 与可选取消信号（[packages/compaction/compaction-basic/src/summarizer.ts:153-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L153-L163)）
- 直接消费 `ctx.llm.stream()` 的分片并由 `BlockAssembler` 组装（[packages/compaction/compaction-basic/src/summarizer.ts:164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L164)）
- 终止原因映射出的错误直接上抛，不落任何替换（[packages/compaction/compaction-basic/src/summarizer.ts:165-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L165-L166)）
- 摘要文本全为空白时抛错，拒绝空检查点（[packages/compaction/compaction-basic/src/summarizer.ts:168-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L168-L172)）
- 返回值同时带上文本摘要、完整原始输出、`llmStreamCall` 标记、provider/model、`maxTokens` 与用量（[packages/compaction/compaction-basic/src/summarizer.ts:173-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L173-L181)）
- `frameSummary` 把前言与开标签、摘要块、闭标签拼成替换用户消息的内容（[packages/compaction/compaction-basic/src/summarizer.ts:189-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L189-L195)）
- `finishError` 把 `error`/`aborted` 终止转成带原 code 的错误，把 `max-tokens` 转成 code 为 `MAX_TOKENS` 的截断错误（[packages/compaction/compaction-basic/src/summarizer.ts:198-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L198-L214)）
- `summaryText` 对含图输出抛 `UNSUPPORTED_CONTENT`，并只保留文本块（[packages/compaction/compaction-basic/src/summarizer.ts:216-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/summarizer.ts#L216-L224)）

### packages/compaction/compaction-basic/src/types.ts

该包的配置与已解析策略的类型声明文件，只含 interface 与 type。

- 无运行期机制

### packages/compaction/compaction-basic/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工程引用。

- 无运行期机制
