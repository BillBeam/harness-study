---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/core/session
---

# packages/core/session

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、138 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/core/session/README.md

会话包的说明文档，描述事件日志、派生消息、请求头快照与崩溃修复的对外契约，供包的使用者与维护者阅读。

- 无运行期机制

### packages/core/session/package.json

会话包的 npm 清单，声明入口、子路径导出与发布文件集。

- `"type": "module"` 使包内文件按 ESM 解析（[packages/core/session/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/package.json#L13)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/core/session/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./types`、`./chunk-rows`、`./surface`、`./src/*` 与 `./package.json` 六类子路径，其余路径不可导入（[packages/core/session/package.json:16-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/package.json#L16-L39)）
- `files` 只发布 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`（[packages/core/session/package.json:40-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/package.json#L40-L45)）

### packages/core/session/src/chunk-rows.ts

`assistant/chunk` 增量事件的行打包编解码器，被持久化后端与有界历史传输用来把连续同块增量压成一行并原样还原。

- `isChunkRow` 以 `type` 三个裸标签判定一条记录是打包行而非会话事件（[packages/core/session/src/chunk-rows.ts:78-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L78-L82)）
- `chunkRowLength` 按 `args`/`texts` 数组长度给出一行代表的逻辑事件数（[packages/core/session/src/chunk-rows.ts:89-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L89-L91)）
- `MIN_RUN = 3` 设定成行的最小连续成员数（[packages/core/session/src/chunk-rows.ts:98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L98)）
- `hasExactKeys` 要求对象键集与给定键列表完全相同，多一个键即不通过（[packages/core/session/src/chunk-rows.ts:105-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L105-L107)）
- `classify` 逐层白名单校验事件类型、信封键集、`seq`/`time` 安全整数、`data` 键集、`chunk.index`，并只接受 `text-delta`/`reasoning-delta` 的三键形状与 `tool-call-delta` 的两种键集，其余一律返回 `undefined` 走逐行原样存储（[packages/core/session/src/chunk-rows.ts:117-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L117-L144)）
- `continues` 要求 `seq` 连号、时间差仍是安全整数、`turn`/`step`/块 `index` 相同，工具调用行还要求 `id` 相同且 `name` 存在性与取值一致，否则断行（[packages/core/session/src/chunk-rows.ts:157-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L157-L172)）
- `buildRow` 以首成员的 `seq0`/`time0` 为锚，把成员时间戳存成相邻差值数组 `dt`，并按类别产出 `text-chunks`/`reasoning-chunks`/`tool-call-chunks` 行（[packages/core/session/src/chunk-rows.ts:175-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L175-L201)）
- `packChunkRuns` 顺序扫描批次，达到 `MIN_RUN` 的同类连续段落成一行，其余事件按原顺序原样输出（[packages/core/session/src/chunk-rows.ts:213-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L213-L242)）
- `malformed` 以统一文案抛出畸形行错误（[packages/core/session/src/chunk-rows.ts:245-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L245-L247)）
- `validateRunData` 校验 `turn`/`step`/`index` 为数字、载荷是非空字符串数组、`dt` 全为安全整数且长度恰为成员数减一（[packages/core/session/src/chunk-rows.ts:250-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L250-L266)）
- `validateRow` 要求信封恰为 `{type, seq0, time0, data}`、`seq0` 非负安全整数、`time0` 安全整数（[packages/core/session/src/chunk-rows.ts:270-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L270-L281)）
- 工具调用行的 `data` 只接受带或不带 `name` 的两种精确键集且 `id`/`name` 必须为字符串（[packages/core/session/src/chunk-rows.ts:282-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L282-L290)）
- 文本与推理行的 `data` 只接受 `{turn, step, index, dt, texts}` 精确键集（[packages/core/session/src/chunk-rows.ts:291-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L291-L296)）
- 解码前先算出末成员 `seq` 会否越出安全整数范围，越界即抛（[packages/core/session/src/chunk-rows.ts:302-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L302-L304)）
- 逐个累加 `dt` 检查每个成员时间仍是安全整数，首次越界即抛（[packages/core/session/src/chunk-rows.ts:305-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L305-L309)）
- `expandRow` 按 `seq0 + k` 与累加时间还原每个成员事件，并按行类型重建 `text-delta`/`reasoning-delta`/`tool-call-delta` 块（`name` 仅在原行带它时重建）（[packages/core/session/src/chunk-rows.ts:314-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L314-L351)）
- `decodeStorageRecord` 对非对象与非行标签值直接当成单个事件放行不校验，只有三种行标签走校验并展开（[packages/core/session/src/chunk-rows.ts:362-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/chunk-rows.ts#L362-L369)）

### packages/core/session/src/index.ts

包主入口：定义 `Session` 追加日志类与 `SessionStore` 服务（`ctx.sessions`），承载事件追加、观察者派发、派生消息缓存、存储进出与 fork。

- `validateSessionHeader` 拒绝非普通 JSON 记录、版本不等于 `SESSION_FORMAT_VERSION`、id 不匹配、`createdAt` 非非负安全整数、`cwd` 非绝对路径、`parentSession`/`agentPreset` 非字符串、`seedLength`/`delegationDepth` 非非负安全整数、`origin` 非 `'subagent'`，通过后深冻结（[packages/core/session/src/index.ts:96-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L96-L136)）
- `validateRestoredSessionHeader` 对恢复路径额外检查原型必须是 `Object.prototype` 或 `null`（[packages/core/session/src/index.ts:139-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L139-L147)）
- `snapshotSessionHeader` 在无来源时合成 `{version, id, createdAt: Date.now()}`，并要求头部可无损 JSON 快照（[packages/core/session/src/index.ts:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L150-L157)）
- `adoptSessionEvent` 校验消息形状后按类型深冻结 `user/message` 的 `data` 或另两类的 `data.message`，插件自有事件不处理（[packages/core/session/src/index.ts:167-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L167-L185)）
- `snapshotSessionEvent` 先 `structuredClone` 再走 adopt，得到脱离调用方的事件副本（[packages/core/session/src/index.ts:192-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L192-L194)）
- `freezeRestoredObject` 用显式栈迭代深冻结恢复出的对象树，不消耗调用栈（[packages/core/session/src/index.ts:197-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L197-L210)）
- `assertSessionEventEnvelope` 拒绝 `request/header-delta` 种子事件，限定信封键只能是 `type`/`seq`/`time`/`data`/`surfaceOp`/`sourceEventSeqs`，校验类型与 `seq`/`time` 为安全整数且 `data` 存在，并对四类事件转入 LLM 形状检查（[packages/core/session/src/index.ts:213-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L213-L248)）
- `assertCurrentLlmShape` 要求种子 `request/header` 的 `config` 带非空 provider/model、`reasoningEffort` 若存在必须是非空字符串，并检查 `adapterDefaults`（[packages/core/session/src/index.ts:251-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L251-L275)）
- `assertAdapterDefaults` 只允许 `reasoningEffort`/`maxTokens` 两个键、取值必须为 `true`，且被标记的字段必须在 `config` 中确实存在（[packages/core/session/src/index.ts:277-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L277-L296)）
- `assertMessageEventShape` 要求消息带非空 `id`、角色与事件类型匹配、`source.kind` 非空、`content` 为数组；`assistant/message` 必须是带 provider/model 的 `model` 来源；`tool/result` 必须是带 `callId` 的 `tool` 来源、内容恰为一个 `tool-result` 块且 `toolCallId` 与来源一致（[packages/core/session/src/index.ts:299-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L299-L350)）
- `assertSupportedRequestHeader` 在追加与种子两处拒绝 `request/header-delta` 类型以及 `reason` 为 `'fallback'` 的 `request/header`（[packages/core/session/src/index.ts:361-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L361-L370)）
- `collectSessionCallbacks` 通过 `ctx.events.dispatch('emit', …)` 先解析出监听器快照（含内部派发校验）再实际调用（[packages/core/session/src/index.ts:375-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L375-L377)）
- `invokeContainedSessionObservers` 逐监听器 try/catch，同步抛出与返回 Promise 的拒绝都只记 warn，不影响其他监听器（[packages/core/session/src/index.ts:380-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L380-L397)）
- 模块私有 `attachments` WeakMap 把 `Session` 与其存储条目关联，追加路径据此判断是否发布事件（[packages/core/session/src/index.ts:413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L413)）
- `Session` 以私有 `log` 数组与绑定其上的 `SurfaceManager` 作为唯一状态，`surface` 只读暴露该管理器（[packages/core/session/src/index.ts:424-431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L424-L431)）
- 构造函数逐条处理种子事件：恢复模式直接取用、否则做无损 JSON 快照，随后校验信封、拒绝旧版请求头、要求 `seq` 从 0 连续、经 `surfaceManager.validateNext` 接受，再冻结入日志（[packages/core/session/src/index.ts:506-536](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L506-L536)）
- `firstLiveSeq` 记为种子长度，`header` 取恢复头或新建快照头（[packages/core/session/src/index.ts:537-538](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L537-L538)）
- 有种子且末条不是 `session/end-seed` 时在构造期追加一条该标记事件，已带标记的日志不再追加（[packages/core/session/src/index.ts:543-545](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L543-L545)）
- `events` 返回缓存的冻结快照数组，追加时置空缓存，已发出的数组不会再增长（[packages/core/session/src/index.ts:557-560](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L557-L560)）
- `seq` 取日志长度，即下一条事件的序号（[packages/core/session/src/index.ts:563-565](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L563-L565)）
- `append` 先把 `surfaceOp`/`sourceEventSeqs` 归并成一份表面元数据，并对 `data` 与该元数据分别做无损 JSON 快照，任一不通过即抛（[packages/core/session/src/index.ts:607-620](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L607-L620)）
- `append` 在另一次追加的发布尚未结束时拒绝重入（[packages/core/session/src/index.ts:621-624](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L621-L624)）
- `append` 用 `seq = log.length`、`time = Date.now()` 组装并深冻结事件，再交 `surfaceManager.validateNext` 在入日志前校验表面转移（[packages/core/session/src/index.ts:625-632](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L625-L632)）
- `append` 先解析 `session/event` 监听器快照，再推入日志并清空事件快照缓存，最后逐个调用监听器；`finally` 复位重入标志并执行被推迟的 detach（[packages/core/session/src/index.ts:634-652](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L634-L652)）
- `requestHeader()` 只折叠自上次位置以来的新事件并深冻结结果，缓存推进到当前日志长度（[packages/core/session/src/index.ts:668-678](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L668-L678)）
- `requestContext()` 增量扫描新事件，取最后一条 `request/context` 的浅拷贝并冻结（[packages/core/session/src/index.ts:689-697](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L689-L697)）
- `deriveMessages()` 在 `replaceGeneration` 变化时清空派生缓存重建，否则只投影新增表面节点，投影为 null 的节点不入历史，并每次返回缓存数组的新副本（[packages/core/session/src/index.ts:724-745](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L724-L745)）
- `SessionStore` 构造时在 `typert` 就绪后注册 `session` 查找项，把线上 `sessionId` 解析成活的 `Session`（[packages/core/session/src/index.ts:794-805](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L794-L805)）
- `create()` 把 `prepare` 出的会话放进调用方 fiber 的一个 `ctx.effect`：先 yield `enter` 的 detach 再 `announce`，使创建监听器抛出时回滚已注册的存储条目（[packages/core/session/src/index.ts:828-839](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L828-L839)）
- `prepare()` 在缺省 id 时循环递增计数器直到不撞库，已存在同 id 则抛，`seedSource: 'persistence'` 走 `Session.fromRestore` 的所有权转移路径，否则按 meta 组装头部走 `Session.create`（[packages/core/session/src/index.ts:861-887](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L861-L887)）
- `enter()` 用 `scopeTarget(session, scopeOf(this.ctx))` 生成作用域载体，再次检查 id 冲突与重复挂载，写入 store 与 attachments，并返回一次性 detach（[packages/core/session/src/index.ts:911-945](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L911-L945)）
- detach 在创建公告或追加发布进行中时改记 `detachRequested`，等该同步过程展开后再真正摘除（[packages/core/session/src/index.ts:932-943](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L932-L943)）
- `detachEntered` 先确认 store 中仍是本条目，再删除条目与 attachments，且只有已公告过的会话才发 `session/disposed`（[packages/core/session/src/index.ts:948-957](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L948-L957)）
- `announce` 拒绝重复或重入公告，先置 `announced = true` 再派发 `session/created`；监听器同步抛出向外传播以否决发布，返回的 Promise 拒绝只记 warn（[packages/core/session/src/index.ts:966-994](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L966-L994)）
- `emitDisposed` 以受控方式派发 `session/disposed`，派发本身抛出也只记 warn（[packages/core/session/src/index.ts:997-1005](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L997-L1005)）
- `flush` 以存储持有的载体派发 `session/flush`，对全部监听器 `Promise.allSettled` 后抛出首个失败原因，并返回是否有监听器参与（[packages/core/session/src/index.ts:1020-1037](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L1020-L1037)）
- `liveEntryFor` 要求传入对象正是 store 中当前同 id 的实例，否则抛（[packages/core/session/src/index.ts:1040-1046](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L1040-L1046)）
- `get`/`list` 按 id 取活会话、按创建顺序返回全部活会话的新数组（[packages/core/session/src/index.ts:1053-1063](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L1053-L1063)）
- `fork` 先拒绝已占用的子 id，再解析源会话、取前缀种子，并以 `cwd`/`parentSession`/`seedLength` 作为子会话头部元数据创建活的子会话（[packages/core/session/src/index.ts:1079-1093](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L1079-L1093)）
- `_forkSeed` 缺省取末条事件序号（空日志返回空种子），校验边界是非负安全整数、在日志范围内、且与该位置事件的 `seq` 一致（[packages/core/session/src/index.ts:1095-1125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L1095-L1125)）
- `_forkSeed` 反查前缀内最后一个 `turn/start`/`turn/end`，若是 `turn/start` 则以 `OPEN_TURN` 拒绝，否则返回含边界在内的前缀切片（[packages/core/session/src/index.ts:1126-1135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L1126-L1135)）
- `_resolveForkSource` 对 id 找不到抛 `SESSION_NOT_FOUND`，对传入对象不是 store 当前实例抛 `SESSION_NOT_LIVE`（[packages/core/session/src/index.ts:1138-1151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L1138-L1151)）
- 默认导出 `SessionStore`，使其作为服务插件被加载（[packages/core/session/src/index.ts:1156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/index.ts#L1156)）

### packages/core/session/src/invariant.ts

会话包的运行期不变量伴生插件，挂在 `invariants` 服务上，对每个会话的事件流做回合/步骤闭合与工具调用配对检查。

- 以 `name`/`inject` 声明为需要 `invariants` 服务的 Cordis 插件（[packages/core/session/src/invariant.ts:18-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L18-L20)）
- `requireOpenStep` 要求步骤级事件所报的 `turn`/`step` 与当前打开的回合、步骤一致，否则报失败（[packages/core/session/src/invariant.ts:42-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L42-L52)）
- `validateEvent` 要求 `seq` 相对已提交轨迹严格递增（[packages/core/session/src/invariant.ts:60-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L60-L62)）
- `turn/start` 要求当前无开放回合且回合号等于期望值，随后置开放回合并把下一步骤重置为 1（[packages/core/session/src/invariant.ts:72-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L72-L82)）
- `turn/end` 要求回合号与开放回合一致且没有未闭合步骤，随后关闭回合并推进期望回合号（[packages/core/session/src/invariant.ts:83-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L83-L93)）
- `step/start` 要求回合匹配、无未闭合步骤且步骤号等于期望值（[packages/core/session/src/invariant.ts:94-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L94-L106)）
- `step/end` 清空该步骤的待决工具调用集合并推进步骤号（[packages/core/session/src/invariant.ts:107-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L107-L113)）
- `assistant/chunk` 与 `assistant/message` 都必须落在当前开放的回合与步骤内（[packages/core/session/src/invariant.ts:114-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L114-L121)）
- `tool/call` 校验步骤后把 `callId` 记入待决集合（[packages/core/session/src/invariant.ts:122-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L122-L126)）
- `tool/result` 若是表面替换只要求处在某个开放回合内；若是追加则要求步骤匹配且该 `callId` 在待决集合中，例外是携带 `TOOL_NOT_STARTED` 错误码的合成结果，处理后从待决集合移除（[packages/core/session/src/invariant.ts:127-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L127-L144)）
- `user/message` 与 `session/end-seed` 不受约束，`session/end-seed` 允许落在开放回合内（[packages/core/session/src/invariant.ts:145-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L145-L149)）
- `request/header` 与 `request/context` 必须出现在开放回合内，否则报失败；其他（插件合并的）事件类型走 default 放行（[packages/core/session/src/invariant.ts:150-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L150-L160)）
- `applyTransition` 在事件提交后才写回标量状态并按 `add`/`delete`/`clear` 更新待决调用集合（[packages/core/session/src/invariant.ts:168-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L168-L186)）
- `seedSession` 用一条新轨迹重放会话现有事件，把它们全部走一遍校验与应用（[packages/core/session/src/invariant.ts:206-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L206-L213)）
- 安装时先为 `ctx.sessions.list()` 的每个现存会话建轨迹，并订阅 `session/created` 为新会话建轨迹（[packages/core/session/src/invariant.ts:218-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L218-L220)）
- `session/event` 监听器只应用与该事件配对暂存的转移，缺失配对即判定"未经预提交校验就发布"失败（[packages/core/session/src/invariant.ts:222-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L222-L230)）
- `internal/dispatch` 监听器在 `session/event` 真正发布前做纯校验并把转移弱引用暂存，后续监听器否决时该转移自然作废（[packages/core/session/src/invariant.ts:232-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L232-L240)）
- `apply` 以包名向 `ctx.invariants` 注册该安装器并返回其 disposer（[packages/core/session/src/invariant.ts:248-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/invariant.ts#L248-L249)）

### packages/core/session/src/json.ts

无损 JSON 校验与脱离式快照工具，被会话事件追加、头部快照等持久化入口用作准入判据。

- `hasIntrinsicConstructor` 通过构造器名、`prototype` 自反与原生 `toString` 文本判断原型是否为本征内建（[packages/core/session/src/json.ts:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L16-L27)）
- `hasPlainArrayPrototype` 要求数组的原型链是本征 `Array.prototype` 上接本征 `Object.prototype`，排除子类与伪造原型（[packages/core/session/src/json.ts:35-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L35-L42)）
- `hasPlainObjectPrototype` 只接受 `null` 原型或任一 realm 的本征 `Object.prototype`（[packages/core/session/src/json.ts:45-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L45-L49)）
- `enumerableStringKeys` 一旦发现符号键或不可枚举自有键就整体拒绝（[packages/core/session/src/json.ts:52-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L52-L56)）
- `assign` 按 `detach` 开关把校验通过的值就地写入父容器，根、数组位、对象键三种落点分别处理（[packages/core/session/src/json.ts:73-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L73-L87)）
- 遍历用显式任务栈迭代推进，每个属性只读取一次，深度只受内存限制而非调用栈（[packages/core/session/src/json.ts:89-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L89-L98)）
- 数组元素若不是自有下标（稀疏洞）直接拒绝（[packages/core/session/src/json.ts:99-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L99-L106)）
- 数字必须有限且不是负零，其余类型（函数、symbol、bigint 等）一律拒绝（[packages/core/session/src/json.ts:126-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L126-L131)）
- 以 `ancestors` 集合检出环，命中即拒绝（[packages/core/session/src/json.ts:132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L132)）
- 数组还要求自有键数恰为 `length + 1`，堵住附加在数组上的额外属性（[packages/core/session/src/json.ts:134-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L134-L145)）
- `snapshotJsonValue` 返回脱离原对象的快照，或在不可无损序列化时返回 `undefined`（[packages/core/session/src/json.ts:177-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L177-L179)）
- `isJsonValue` 走同一遍历但不物化副本，只回答是否可无损往返（[packages/core/session/src/json.ts:188-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/json.ts#L188-L190)）

### packages/core/session/src/known-event-types.ts

由脚本生成的事件类型清单模块，被持久化读路径用来判定一份日志中的事件类型本构建是否认识。

- 导出 `KNOWN_SESSION_EVENT_TYPES` 集合，列出本仓库声明的全部会话事件类型；集合之外的类型使读路径拒绝解释该日志（[packages/core/session/src/known-event-types.ts:18-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/known-event-types.ts#L18-L70)）

### packages/core/session/src/preparation.ts

包装一个尚未发布到存储的 `Session` 及其提供方状态的生命周期对象，供先构造后发布的调用方使用。

- `SessionPreparation.create` 把未发布的 Session 与可选 `release` 回调包成一次准备生命周期（[packages/core/session/src/preparation.ts:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/preparation.ts#L39-L41)）
- `[Symbol.dispose]` 以 `released` 标志保证 `release` 只被同步调用一次，重复释放为空操作（[packages/core/session/src/preparation.ts:44-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/preparation.ts#L44-L48)）

### packages/core/session/src/repair.ts

崩溃恢复用的日志修复模块，扫描加载出的日志并生成关闭尾部未闭合回合所需的合成事件。

- 导出 `TOOL_NOT_STARTED` 与 `TOOL_OUTCOME_UNKNOWN` 两个恢复错误码，合成结果与不变量检查都据此识别（[packages/core/session/src/repair.ts:13-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L13-L16)）
- 扫描时 `turn/start`/`turn/end` 重置开放回合、步骤与待决调用表，`step/start`/`step/end` 维护开放步骤并在步骤结束时清表（[packages/core/session/src/repair.ts:34-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L34-L51)）
- `assistant/message` 的 `tool-call` 块登记为待决调用，`tool/call` 补记其 `seq`，`tool/result` 将对应调用移出待决表（[packages/core/session/src/repair.ts:52-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L52-L70)）
- 无开放回合（或日志为空）时返回空数组，不产生任何合成事件（[packages/core/session/src/repair.ts:79-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L79-L80)）
- 合成事件的序号自最后一条真实事件递增，时间戳复用最后一条真实事件的 `time`（[packages/core/session/src/repair.ts:85-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L85-L87)）
- 为每个待决调用按 Map 插入顺序合成一条 `isError` 的 `tool/result`：已记录启动的用"结果未知、按工具语义决定是否重试"文案，未记录启动的用"记录启动前被打断、需要就重试"文案（[packages/core/session/src/repair.ts:91-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L91-L108)）
- 合成结果带 `surfaceOp: 'append'`，错误对象按是否已启动取两种 `name`/`code`，已启动的还引用其 `tool/call` 的 seq 作为 `sourceEventSeqs`（[packages/core/session/src/repair.ts:109-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L109-L124)）
- 先补 `step/end` 再补 `reason: { kind: 'interrupted' }` 的 `turn/end`，保证步骤边界先于回合边界（[packages/core/session/src/repair.ts:128-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/repair.ts#L128-L132)）

### packages/core/session/src/request-header.ts

`request/header` 事件的规范化、比较与折叠函数，被会话的增量头部缓存与离线重建路径共用。

- `canonicalHeader` 把空系统提示与空工具列表规范成缺省字段，`adapterDefaults` 仅在有 `true` 标记时保留（[packages/core/session/src/request-header.ts:21-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/request-header.ts#L21-L31)）
- `sameSchema` 以 `JSON.stringify` 文本相等比较工具 schema（[packages/core/session/src/request-header.ts:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/request-header.ts#L34-L36)）
- `headerEquals` 逐字段比较调用配置、两个 adapter 默认标记、系统提示文本与按序比较的工具列表（[packages/core/session/src/request-header.ts:44-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/request-header.ts#L44-L54)）
- `foldRequestHeader` 顺序扫描事件，只取最后一条 `request/header` 的规范化快照作为结果，可从上次折叠状态续算（[packages/core/session/src/request-header.ts:65-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/request-header.ts#L65-L71)）

### packages/core/session/src/seq-ranges.ts

`sourceEventSeqs` 数组在 JSONL 存储中的区间编解码工具，从包主入口导出。

- `isStrictlyIncreasing` 判定序列是否严格递增（[packages/core/session/src/seq-ranges.ts:6-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/seq-ranges.ts#L6-L8)）
- `encodeSeqRanges` 对非严格递增输入直接原样拷贝，否则把长度不小于 3 的连续段替换为 `[start, end]` 闭区间对（[packages/core/session/src/seq-ranges.ts:15-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/seq-ranges.ts#L15-L26)）
- `decodeSeqRanges` 拒绝非数组输入，数字项逐个校验并受 `maxEntries` 上限约束（[packages/core/session/src/seq-ranges.ts:34-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/seq-ranges.ts#L34-L43)）
- 区间项必须是长度为 2 的数组、两端都是合法序号、`start <= end`，且展开长度不得超出剩余配额（[packages/core/session/src/seq-ranges.ts:45-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/seq-ranges.ts#L45-L58)）
- 出现过区间项时还要求展开后的整体严格递增，否则抛（[packages/core/session/src/seq-ranges.ts:60-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/seq-ranges.ts#L60-L62)）
- `assertSeq` 要求每个序号是非负安全整数（[packages/core/session/src/seq-ranges.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/seq-ranges.ts#L66-L70)）

### packages/core/session/src/surface.ts

事件日志之上的有序表面层：判定哪些事件产生模型消息、校验表面追加与替换、并把单个事件投影成一条消息；浏览器端也消费该子路径。

- `SURFACE_EVENT_TYPES` 把可上表面的事件类型固定为 `user/message`、`assistant/message`、`tool/result` 三类，`isSurfaceEligibleType` 据此判定（[packages/core/session/src/surface.ts:15-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L15-L28)）
- `isSurfaceEvent` 同时要求类型可上表面且带 `surfaceOp` 标记（[packages/core/session/src/surface.ts:35-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L35-L38)）
- `isAppendSurfaceEvent` 只认 `surfaceOp === 'append'` 的原位入表事件，替换副本被排除在外（[packages/core/session/src/surface.ts:51-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L51-L55)）
- `isReplacementSurfaceEvent` 认出遮蔽既有区间的替换节点（[packages/core/session/src/surface.ts:64-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L64-L68)）
- `deriveEventMessage` 把 `user/message` 的 `data` 原样作为消息、`tool/result` 取其 `message`，内容为空的 `assistant/message` 投影为 null，其他类型一律 null（[packages/core/session/src/surface.ts:83-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L83-L114)）
- `isEventSeq` 与 `isReplaceOp` 要求替换标记恰为 `{op:'replace', start, end}` 三键且两端是非负安全整数（[packages/core/session/src/surface.ts:168-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L168-L182)）
- `surfaceOpOf` 对不可上表面的类型禁止携带 `surfaceOp` 或 `sourceEventSeqs`，对可上表面的类型强制要求 `surfaceOp`，并校验替换标记形状（[packages/core/session/src/surface.ts:185-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L185-L208)）
- `assertProvenance` 要求 `sourceEventSeqs` 是数组、除 `assistant/message` 外不得为空、元素为合法序号、不得重复、必须严格早于本事件序号（[packages/core/session/src/surface.ts:211-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L211-L238)）
- `assertProvenance` 还要求被遮蔽的每个表面节点都出现在 `sourceEventSeqs` 中，缺一即抛（[packages/core/session/src/surface.ts:239-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L239-L242)）
- `replacementRange` 要求 `start`/`end` 都能在当前表面中找到且 `start` 不在 `end` 之后，并切出被遮蔽的节点序列（[packages/core/session/src/surface.ts:246-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L246-L266)）
- `isDeepEqualJson` 在不依赖 `node:util` 的前提下对 JSON 值域做深比较（[packages/core/session/src/surface.ts:273-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L273-L284)）
- `assertToolResultRewrite` 要求 `tool/result` 替换恰好覆盖一个当前节点、目标必须也是 `tool/result`，且把两侧结果内容置空后必须完全相等——即只允许改内容（[packages/core/session/src/surface.ts:287-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L287-L318)）
- `planSurfaceEvent` 先要求事件 `seq` 与期望序号连续，再据标记产出 append 或 replace 的待提交计划，校验期间不改状态（[packages/core/session/src/surface.ts:321-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L321-L347)）
- `applySurfacePlan` 对 append 推入尾部，对 replace 用 `splice` 用新节点整体换掉区间并把 `replaceGeneration` 加一（[packages/core/session/src/surface.ts:362-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L362-L379)）
- `foldSurface` 从空状态整段重放日志，返回当前节点序列与全部替换记录（[packages/core/session/src/surface.ts:387-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L387-L395)）
- `SurfaceManager` 以 `baseSeq` 支持从窗口首事件的绝对序号起算，只保留状态不保留替换历史（[packages/core/session/src/surface.ts:398-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L398-L415)）
- `validateNext` 先补折已入日志的增量，再按下一个期望序号为候选事件生成待提交计划，不改已提交状态（[packages/core/session/src/surface.ts:421-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L421-L429)）
- `replaceGeneration` 与 `nodes` 读取前都惰性补折日志增量（[packages/core/session/src/surface.ts:431-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L431-L441)）
- `_processDelta` 逐条推进：与暂存计划同一对象且序号相符时直接提交该计划，否则就地重新校验并应用，并清除已消费的暂存计划（[packages/core/session/src/surface.ts:444-459](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L444-L459)）

### packages/core/session/src/types.ts

会话事件词表与相关数据结构的类型声明文件，同时是客户端可用的类型子路径导出。

- `SESSION_FORMAT_VERSION` 常量取值 `0`，被新建头部盖章、被头部校验与持久化后端加载检查读取（[packages/core/session/src/types.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/types.ts#L56)）

### packages/core/session/tsconfig.json

包的 TypeScript 编译配置，声明源码根、类型输出目录与工作区引用。

- 无运行期机制

### packages/core/session/tsdown.config.ts

包的打包配置，决定发布产物中存在哪些运行期入口文件。

- 声明两个独立的 ESM bundle：`lib/types/index.js` 与 `lib/types/invariant.js` 分别打到 `lib/` 下，平台为 node、目标 es2024，不清理已有输出（[packages/core/session/tsdown.config.ts:4-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/tsdown.config.ts#L4-L25)）
