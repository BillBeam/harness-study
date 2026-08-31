---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/compaction/compaction-tool-result-pruner
---

# packages/compaction/compaction-tool-result-pruner

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、33 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/compaction/compaction-tool-result-pruner/README.md

包的说明文档，描述工具结果裁剪的字符预算、触发时机与模型可见效果，供使用者阅读。

- 无运行期机制

### packages/compaction/compaction-tool-result-pruner/package.json

npm 包清单，声明裁剪服务的入口、发布产物与依赖关系。

- `main`/`types`/`exports."."` 把包名解析到 `lib/index.js` 与其类型声明（[packages/compaction/compaction-tool-result-pruner/package.json:14-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/package.json#L14-L20)）
- `exports."./invariant"` 暴露 invariant 伴生插件子路径，`exports."./src/*"` 暴露源码路径（[packages/compaction/compaction-tool-result-pruner/package.json:21-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/package.json#L21-L26)）
- `files` 限定发布内容为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/compaction/compaction-tool-result-pruner/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/package.json#L28-L32)）

### packages/compaction/compaction-tool-result-pruner/src/config.ts

裁剪预算的常量与校验模块，被 `src/index.ts` 在构造与裁剪时调用。

- `PRUNE_MARKER` 固定为 `\n\n[... tool result middle pruned ...]\n\n`，替换掉每一段被删除的中段（[packages/compaction/compaction-tool-result-pruner/src/config.ts:6-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/config.ts#L6-L7)）
- 默认阈值 8192、头部 4096、尾部 1024 个码点，且被 `deepFreeze` 冻结（[packages/compaction/compaction-tool-result-pruner/src/config.ts:9-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/config.ts#L9-L14)）
- `codePointLength` 按 Unicode 码点而非 UTF-16 码元计数（[packages/compaction/compaction-tool-result-pruner/src/config.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/config.ts#L27-L29)）
- `resolveConfig` 对不在三键白名单内的配置键抛错（[packages/compaction/compaction-tool-result-pruner/src/config.ts:37-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/config.ts#L37-L44)）
- 缺省字段回落到默认值，并要求阈值为正整数、头尾为非负整数（[packages/compaction/compaction-tool-result-pruner/src/config.ts:46-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/config.ts#L46-L53)）
- 要求「头部 + 标记 + 尾部」的码点数不超过阈值，否则拒绝配置（[packages/compaction/compaction-tool-result-pruner/src/config.ts:55-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/config.ts#L55-L63)）
- 返回 `structuredClone` 后再冻结的配置，与调用方入参脱钩（[packages/compaction/compaction-tool-result-pruner/src/config.ts:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/config.ts#L64)）
- `assertPositiveInteger` 与 `assertNonNegativeInteger` 给出带字段名与实际值的拒绝信息（[packages/compaction/compaction-tool-result-pruner/src/config.ts:67-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/config.ts#L67-L77)）

### packages/compaction/compaction-tool-result-pruner/src/index.ts

插件入口，注册 `toolResultPruner` 服务并实现按码点预算改写超额工具结果的会话遍历。

- 通过 `declare module` 把 `toolResultPruner` 挂到 Context 上，使其可被 `ctx.get()` 读取（[packages/compaction/compaction-tool-result-pruner/src/index.ts:32-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L32-L36)）
- `static inject` 声明需要 `tokenMeter` 服务后才装载（[packages/compaction/compaction-tool-result-pruner/src/index.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L44-L47)）
- `Config` 的 schemastery 声明决定 Loader 接受的三个字段、步长与下界及其默认值（[packages/compaction/compaction-tool-result-pruner/src/index.ts:49-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L49-L53)）
- 构造时以服务名 `toolResultPruner` 注册并解析冻结配置（[packages/compaction/compaction-tool-result-pruner/src/index.ts:58-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L58-L61)）
- `measureContent` 只对文本块按码点计数，非文本块计零（[packages/compaction/compaction-tool-result-pruner/src/index.ts:68-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L68-L74)）
- `pruneContent` 在文本码点数不超过阈值时返回 null，表示不改写（[packages/compaction/compaction-tool-result-pruner/src/index.ts:83-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L83-L85)）
- 以全局码点偏移算出被删除区间的起点为 `headChars`、终点为总码点数减 `tailChars`（[packages/compaction/compaction-tool-result-pruner/src/index.ts:87-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L87-L88)）
- 遍历时非文本块原样保留并保持相对顺序（[packages/compaction/compaction-tool-result-pruner/src/index.ts:93-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L93-L97)）
- 每个文本块按码点数组切出与删除区间相交前后的两段，中间只在首个相交块插入一次标记（[packages/compaction/compaction-tool-result-pruner/src/index.ts:99-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L99-L112)）
- 切完后要求确实插入过标记，且结果既在阈值内又严格小于原文，否则抛错（[packages/compaction/compaction-tool-result-pruner/src/index.ts:114-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L114-L121)）
- `pruneSession` 先对当前表面拍一份快照，只取 `tool/result` 类型的节点作为候选（[packages/compaction/compaction-tool-result-pruner/src/index.ts:136-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L136-L142)）
- 逐个候选调用 `pruneContent`，返回 null 的候选被跳过（[packages/compaction/compaction-tool-result-pruner/src/index.ts:144-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L144-L149)）
- 替换消息复用原事件消息的全部字段，只替换首个结果项的 `content`，并冻结（[packages/compaction/compaction-tool-result-pruner/src/index.ts:150-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L150-L158)）
- 先追加 `compaction/prune` 影子计价事件，其 token 数由 `ctx.tokenMeter.estimateMessage` 对原消息估出（[packages/compaction/compaction-tool-result-pruner/src/index.ts:159-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L159-L166)）
- 紧接着追加新的 `tool/result` 事件，以 `surfaceOp: replace` 就地替换原节点并通过 `sourceEventSeqs` 引用原事件（[packages/compaction/compaction-tool-result-pruner/src/index.ts:167-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L167-L173)）
- 每次替换记录原 seq、替换 seq、callId 与前后码点数，并累计总删除量返回（[packages/compaction/compaction-tool-result-pruner/src/index.ts:174-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L174-L183)）
- 默认导出服务类，供 Loader 按包名装载（[packages/compaction/compaction-tool-result-pruner/src/index.ts:187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L187)）

### packages/compaction/compaction-tool-result-pruner/src/invariant.ts

包自带的 invariant 伴生插件，由 `./invariant` 子路径导出。

- 声明插件名与对 `invariants` 服务的注入需求（[packages/compaction/compaction-tool-result-pruner/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/invariant.ts#L12-L15)）
- `apply` 向 invariants 注册本包名与一个空安装器，并返回注册的 disposer（[packages/compaction/compaction-tool-result-pruner/src/invariant.ts:18-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/invariant.ts#L18-L26)）

### packages/compaction/compaction-tool-result-pruner/src/types.ts

该包的配置、单条替换记录与裁剪结果的类型声明文件，只含 interface。

- 无运行期机制

### packages/compaction/compaction-tool-result-pruner/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工程引用。

- 无运行期机制
