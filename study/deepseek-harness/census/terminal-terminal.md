---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/terminal/terminal
---

# packages/terminal/terminal

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、50 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/terminal/terminal/README.md

持久终端会话服务的包说明页，描述组合方式、会话能力、归属隔离与可观察的失败码。

- 无运行期机制

### packages/terminal/terminal/package.json

包清单，声明入口、导出映射与发布文件集合。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/terminal/terminal/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/package.json#L14-L15)）
- `exports` 只暴露根入口、`./invariant`、`./src/*` 与 `./package.json`（[packages/terminal/terminal/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/package.json#L16-L27)）
- `files` 限定发布产物为两个 lib 入口与类型声明（[packages/terminal/terminal/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/package.json#L28-L32)）

### packages/terminal/terminal/src/index.ts

包主入口，实现 `TerminalSessionService`：后端注册表、会话 id 铸造与发布、按 Agent 的归属围栏、独占发送、读取、信号、关闭，以及归属者与服务两级的等待式清理。

- `TerminalError` 携带一个稳定的 `TerminalErrorCode`，使失败可被调用方按码路由（[packages/terminal/terminal/src/index.ts:66-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L66-L71)）
- 服务持有后端表、会话表、按归属者的名字预留集、未发布 spawn 集、归属者清理器表、已释放归属者弱集，以及自增 id 与 `disposing` 标志（[packages/terminal/terminal/src/index.ts:106-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L106-L113)）
- 构造时以服务名 `terminals` 挂载，并用 `ctx.effect` 注册释放时调用 `disposeAll()` 的清理（[packages/terminal/terminal/src/index.ts:116-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L116-L117)）
- `registerBackend()` 拒绝空类型名，并对已存在的同名类型抛出 `DUPLICATE_BACKEND`（[packages/terminal/terminal/src/index.ts:126-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L126-L129)）
- 后端注册走 `ctx.effect`，其 disposer 只在表里仍是同一个对象时才删除该条目（[packages/terminal/terminal/src/index.ts:130-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L130-L136)）
- `listBackends()` 按注册顺序返回后端类型名（[packages/terminal/terminal/src/index.ts:143-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L143-L145)）
- `spawn()` 先校验服务未在释放、调用方信号未中止、归属者存活并已挂上清理器（[packages/terminal/terminal/src/index.ts:155-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L155-L157)）
- 请求的后端类型未注册时抛出 `NO_BACKEND`（[packages/terminal/terminal/src/index.ts:158-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L158-L159)）
- 显式给出的空字符串会话名被拒绝（[packages/terminal/terminal/src/index.ts:160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L160)）
- 预留会话名与 spawn 槽位，把调用方信号与服务自有的取消信号用 `AbortSignal.any` 合成后交给后端（[packages/terminal/terminal/src/index.ts:161-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L161-L165)）
- 会话 id 由服务铸造为自增的 `pty-<n>`（[packages/terminal/terminal/src/index.ts:166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L166)）
- 交给后端的 spec 带上已铸造的 id、归属 Agent、类型，以及仅在提供时才出现的 name 与 cwd（[packages/terminal/terminal/src/index.ts:170-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L170-L177)）
- 后端返回后再次检查取消、服务是否正在释放（`SERVICE_DISPOSING`）与归属者是否仍存活（`OWNER_NOT_LIVE`）（[packages/terminal/terminal/src/index.ts:178-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L178-L184)）
- 只有全部检查通过才把记录写入会话表并返回带 motd 的快照，即"后端建立成功后才发布"（[packages/terminal/terminal/src/index.ts:185-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L185-L195)）
- 后端抛出 `TerminalBackendCleanupError` 时，其 `cleanupError` 被记为该 spawn 的清理失败（[packages/terminal/terminal/src/index.ts:197-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L197-L199)）
- 已建立但未发布的后端会话在失败路径上被回滚关闭，关闭失败也记为清理失败（[packages/terminal/terminal/src/index.ts:200-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L200-L208)）
- 若调用方信号或服务信号已中止，抛出的是原始取消原因而非后端错误（[packages/terminal/terminal/src/index.ts:209-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L209-L215)）
- 回滚也失败且不是调用方主动取消时，抛出合并两者的 `AggregateError`（[packages/terminal/terminal/src/index.ts:216-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L216-L219)）
- finally 里释放 spawn 槽位（携带清理失败）与会话名预留（[packages/terminal/terminal/src/index.ts:220-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L220-L223)）
- `hasOwnerActivity()` 同时看未发布 spawn 与已发布会话，使"建立中到关闭完"这段区间没有空档（[packages/terminal/terminal/src/index.ts:231-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L231-L234)）
- `startSend()` 先做归属校验，对正在关闭的会话抛错，对已有活动发送抛出 `SEND_ACTIVE`（[packages/terminal/terminal/src/index.ts:244-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L244-L246)）
- 发送槽位在返回操作句柄之前同步占住，并在 `done` 的成功与失败分支上都清空（[packages/terminal/terminal/src/index.ts:247-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L247-L253)）
- `read()` 归属校验后直接转发给后端会话（[packages/terminal/terminal/src/index.ts:263-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L263-L265)）
- `signal()` 归属校验后把信号转发给后端会话（[packages/terminal/terminal/src/index.ts:274-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L274-L276)）
- `kill()` 对已在进行的同一次关闭直接等待并返回 false，避免重复关闭（[packages/terminal/terminal/src/index.ts:286-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L286-L290)）
- 关闭 promise 存为记录上的围栏，成功后才从会话表删除；失败则清空围栏并把错误抛给调用方（[packages/terminal/terminal/src/index.ts:291-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L291-L300)）
- `list()` 只返回归属者本人的会话快照，按发布顺序（[packages/terminal/terminal/src/index.ts:308-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L308-L312)）
- `assertActive()` 在服务释放中把任何新操作挡在 `SERVICE_DISPOSING` 上（[packages/terminal/terminal/src/index.ts:314-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L314-L316)）
- `isLiveOwner()` 要求归属者未被记入已释放弱集，且 `agents` 注册表按 id 查回的仍是同一个 Agent 对象（[packages/terminal/terminal/src/index.ts:318-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L318-L320)）
- `ensureOwnerCleanup()` 对非存活归属者抛 `OWNER_NOT_LIVE`，并在归属者自己的上下文上注册一次性 effect：释放时标记归属者已释放、摘掉清理器并关闭其全部会话（[packages/terminal/terminal/src/index.ts:322-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L322-L333)）
- `reserveName()` 分别对"该归属者已发布同名会话"和"该名字正在被另一次 spawn 占用"抛出 `DUPLICATE_NAME`，并返回释放函数（[packages/terminal/terminal/src/index.ts:335-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L335-L348)）
- `reserveSpawn()` 为每次未发布 spawn 建一个 `AbortController` 与结算 promise；释放时若带清理失败则保留该条目不移除，只解决结算（[packages/terminal/terminal/src/index.ts:350-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L350-L365)）
- `abortPendingSpawns()` 用给定的 `TerminalError` 作为中止原因逐个中止、等待全部结算，收集清理失败后统一移除条目，有失败则抛 `AggregateError`（[packages/terminal/terminal/src/index.ts:374-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L374-L385)）
- `expectOwned()` 对未知 id 抛 `NO_SESSION`，对非本人会话抛 `FOREIGN_SESSION`，归属比较用的是 Agent 对象本身（[packages/terminal/terminal/src/index.ts:387-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L387-L392)）
- `snapshot()` 组装对外可见字段：id、可选 name、类型、后端有 pid 时的 pid、当前 status，以及仅在发布时附带的 motd（[packages/terminal/terminal/src/index.ts:396-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L396-L405)）
- `abortAndClose()` 先中止未发布 spawn 再关闭已发布会话，两段失败分别收集并合并为一个 `AggregateError`（[packages/terminal/terminal/src/index.ts:407-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L407-L421)）
- `disposeOwned()` 以 `OWNER_NOT_LIVE` 为中止原因、`PTY owner disposed` 为关闭原因清理该归属者，并在 finally 删掉其名字预留（[packages/terminal/terminal/src/index.ts:423-433](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L423-L433)）
- `disposeAll()` 先置 `disposing` 挡住新操作，再以 `SERVICE_DISPOSING` 中止并关闭全部会话（[packages/terminal/terminal/src/index.ts:436-445](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L436-L445)）
- 无论关闭是否失败，finally 都清空后端表、名字预留、未发布 spawn 集，并等待全部归属者清理器执行完，错误随后才向上传播（[packages/terminal/terminal/src/index.ts:446-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L446-L453)）
- `closeRecords()` 对每条记录复用已有的关闭围栏或新建一个，成功后删除会话；失败时只在围栏仍是自己那次时才清空，最后把全部拒绝合并为 `AggregateError`（[packages/terminal/terminal/src/index.ts:456-473](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L456-L473)）
- 服务类同时作为默认导出提供给 Loader（[packages/terminal/terminal/src/index.ts:476](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/index.ts#L476)）

### packages/terminal/terminal/src/invariant.ts

包自有的 invariant 伴生插件，向 `invariants` 服务登记包名并安装一个空的检查器。

- 声明插件名 `terminal-invariant` 与注入 `invariants`（[packages/terminal/terminal/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/invariant.ts#L13-L15)）
- `install` 为空实现，不注册任何运行期检查（[packages/terminal/terminal/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其 disposer（[packages/terminal/terminal/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/invariant.ts#L28-L29)）

### packages/terminal/terminal/src/types.ts

后端、注册表与工具消费方共享的类型声明文件，其中只含一个运行期类。

- `TerminalBackendCleanupError` 继承 `AggregateError`，把未发布建立失败与其清理失败一并携带（`spawnError`／`cleanupError` 两个只读字段），并固定名称与消息文本，供服务据此判定清理失败（[packages/terminal/terminal/src/types.ts:18-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal/src/types.ts#L18-L26)）

### packages/terminal/terminal/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工作区依赖的项目引用。

- 无运行期机制
