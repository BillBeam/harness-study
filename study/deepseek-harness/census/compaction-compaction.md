---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/compaction/compaction
---

# packages/compaction/compaction

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 10 个文件、39 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/compaction/compaction/README.md

包 README，说明压缩契约做什么、后端如何实现、以及事件与替换如何被记录，供后端实现者与部署者阅读。

- 无运行期机制

### packages/compaction/compaction/package.json

包清单，声明这个服务定义包的入口与两个无 cordis 依赖的叶子子路径导出。

- `exports` 除根入口与 `./invariant` 外，另外导出 `./types` 与 `./checkpoint` 两个叶子，供客户端与线协议程序不加载宿主插件即可引用（[packages/compaction/compaction/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/package.json#L16-L35)）
- `files` 白名单发布 `lib/index.js`、`lib/invariant.js` 以及 `lib/types` 下的 js 与 d.ts（[packages/compaction/compaction/package.json:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/package.json#L36-L41)）

### packages/compaction/compaction/src/brand.ts

压缩事务标识的品牌类型与同名构造函数。

- 无运行期机制

### packages/compaction/compaction/src/checkpoint.ts

无 cordis 依赖的检查点出处模块：构造替换消息的来源标记，并提供识别它的谓词。

- 检查点标记被冻结为固定的 `{ kind: 'plugin', plugin: 'compact' }`（[packages/compaction/compaction/src/checkpoint.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/checkpoint.ts#L19)）
- `compactCheckpointSource` 在标记上附加 `compactionId` 与可选 `sourceCommandId` 并冻结返回（[packages/compaction/compaction/src/checkpoint.ts:33-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/checkpoint.ts#L33-L42)）
- `isCompactCheckpointSource` 只按 `kind` 与 `plugin` 两个字段判定一条持久化消息来源是否为压缩检查点（[packages/compaction/compaction/src/checkpoint.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/checkpoint.ts#L49-L51)）

### packages/compaction/compaction/src/index.ts

服务定义入口：声明抽象 `CompactionEngine`、手动压缩的失败类型，并把这些契约挂到 `ctx.compaction`。

- `ManualCompactionError` 携带闭合失败码与诊断消息，`name` 固定为 `ManualCompactionError`（[packages/compaction/compaction/src/index.ts:41-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/index.ts#L41-L57)）
- 抽象服务基类以服务名 `compaction` 注册到上下文（[packages/compaction/compaction/src/index.ts:96-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/index.ts#L96-L99)）

### packages/compaction/compaction/src/invariant.ts

包自有的 invariant 伴生插件，在事件发布前后校验 `compaction/start`→`summary`→`end` 括号、其归属回合与检查点相关性。

- 声明伴生插件名并注入 `invariants` 服务（[packages/compaction/compaction/src/invariant.ts:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L15-L17)）
- `validateId` 要求每个持久化不透明标识是非空字符串（[packages/compaction/compaction/src/invariant.ts:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L39-L41)）
- `validateSourceCommandId` 要求一次事务内的发起命令标识始终与 `compaction/start` 一致（[packages/compaction/compaction/src/invariant.ts:44-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L44-L54)）
- `validateCheckpoint` 要求替换检查点存在对应的未闭合 start，且 id 与命令标识都匹配（[packages/compaction/compaction/src/invariant.ts:57-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L57-L73)）
- `inheritedOrphanStartSeqs` 扫描日志，把被后来的 `session/end-seed` 越过的未闭合 start 记为陈旧（[packages/compaction/compaction/src/invariant.ts:76-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L76-L92)）
- `validateTurnBoundary` 禁止 `turn/start` 或 `turn/end` 跨越一个未闭合的压缩括号（[packages/compaction/compaction/src/invariant.ts:95-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L95-L108)）
- `applyTurnBoundary` 在回合边界被接受后推进已提交的回合游标（[packages/compaction/compaction/src/invariant.ts:111-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L111-L121)）
- `validateOwner` 要求编号括号严格落在同编号的开启回合内，`null` 归属则必须在回合之间（[packages/compaction/compaction/src/invariant.ts:124-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L124-L136)）
- `compaction/start` 在已有未闭合括号时报错，并校验 id、可选命令标识与归属回合（[packages/compaction/compaction/src/invariant.ts:155-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L155-L172)）
- `compaction/summary` 要求存在匹配的 start、id 一致、同一括号内只出现一次（[packages/compaction/compaction/src/invariant.ts:173-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L173-L184)）
- `compaction/summary` 的 `shadowedSeqs` 必须非空、其首尾与 `shadowedRange` 一致，`shadowedTokenCount` 必须是非负安全整数（[packages/compaction/compaction/src/invariant.ts:185-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L185-L192)）
- `compaction/end` 要求存在匹配 start、id 与命令标识一致、归属回合一致，且无 `error` 的成功闭合必须先有过一条 summary（[packages/compaction/compaction/src/invariant.ts:201-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L201-L217)）
- `applyCompactionTransition` 把 start/summary 落成新的括号状态，end 与 end-seed 清空它（[packages/compaction/compaction/src/invariant.ts:221-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L221-L243)）
- 安装器声明注入 `sessions`，并对每个会话在 WeakMap 中维护一份追踪状态（[packages/compaction/compaction/src/invariant.ts:248-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L248-L250)）
- 播种时重放整条已有日志；对被判定陈旧的继承孤儿括号跳过回合边界检查，使其修复不被否决（[packages/compaction/compaction/src/invariant.ts:251-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L251-L271)）
- 对已存在的会话与之后每个 `session/created` 事件都播种一次（[packages/compaction/compaction/src/invariant.ts:273-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L273-L274)）
- `session/event` 上再次校验回合边界，并要求每个 compaction 事件此前已在预提交阶段暂存，否则报错（[packages/compaction/compaction/src/invariant.ts:275-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L275-L288)）
- `internal/dispatch` 上在事件发布前先做完整校验并把转移暂存到事件对象上（[packages/compaction/compaction/src/invariant.ts:289-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L289-L296)）
- `apply` 把这套安装器注册到 `ctx.invariants` 并返回 disposer（[packages/compaction/compaction/src/invariant.ts:305-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/invariant.ts#L305-L306)）

### packages/compaction/compaction/src/tool-pairing.ts

按当前 surface 顺序计算工具调用配对余额的缓存，供压缩后端与调用者判断切点是否安全。

- 每个会话的余额缓存挂在 WeakMap 上（[packages/compaction/compaction/src/tool-pairing.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/tool-pairing.ts#L26)）
- `eventDelta` 按助手消息中 `tool-call` 块的数量加计、`tool/result` 减一，其余事件不改变余额（[packages/compaction/compaction/src/tool-pairing.ts:29-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/tool-pairing.ts#L29-L38)）
- `eventForSeq` 在 seq 对应事件缺失或 seq 不自洽时抛出「surface 损坏」（[packages/compaction/compaction/src/tool-pairing.ts:41-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/tool-pairing.ts#L41-L47)）
- `extendCache` 先在临时变量上折叠未处理的尾部并校验，通过后才改写活缓存（[packages/compaction/compaction/src/tool-pairing.ts:50-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/tool-pairing.ts#L50-L73)）
- 余额变为负数时抛出「无匹配 tool-call 的 tool/result」（[packages/compaction/compaction/src/tool-pairing.ts:64-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/tool-pairing.ts#L64-L66)）
- 缓存缺失、替换代数变化或 surface 变短时整体重建，仅变长时增量追加，否则直接复用（[packages/compaction/compaction/src/tool-pairing.ts:77-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/tool-pairing.ts#L77-L97)）
- `cutBalance` 在 seq 不在当前 surface 时抛出，而不是返回默认值（[packages/compaction/compaction/src/tool-pairing.ts:100-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/tool-pairing.ts#L100-L107)）
- `toolPairingBalancedBefore` 与 `toolPairingBalancedAfter` 分别读该 seq 位置前后两个切口的余额（[packages/compaction/compaction/src/tool-pairing.ts:117-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/src/tool-pairing.ts#L117-L131)）

### packages/compaction/compaction/src/types.ts

压缩词汇的纯类型文件：结果类型与通过声明合并加入会话事件表的 `compaction/*` 事件。

- 无运行期机制

### packages/compaction/compaction/tsconfig.json

包的 TypeScript 编译配置与工作区引用。

- 无运行期机制

### packages/compaction/compaction/tsdown.config.ts

打包配置，决定发布产物的文件与模块格式。

- index 与 invariant 各自打成关闭代码分割的自包含 ESM 产物，与包白名单允许的文件一一对应（[packages/compaction/compaction/tsdown.config.ts:4-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction/tsdown.config.ts#L4-L13)）
