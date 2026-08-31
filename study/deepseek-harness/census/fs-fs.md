---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/fs/fs
---

# packages/fs/fs

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、18 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/fs/fs/README.md

包说明文档，介绍 `ctx.fs` 契约、后端选择与 `fs/*` 策略事件。

- 无运行期机制

### packages/fs/fs/package.json

包清单，声明该契约包的入口、导出子路径与依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/fs/fs/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./src/*` 与 `./package.json`（[packages/fs/fs/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/package.json#L16-L27)）
- `files` 仅发布 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/fs/fs/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/package.json#L28-L32)）
- `peerDependencies` 要求宿主提供 brand、invariants、llm、sandbox 与 cordis（[packages/fs/fs/package.json:34-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/package.json#L34-L40)）

### packages/fs/fs/src/index.ts

文件系统服务定义：抽象 `FileSystem` 类、`ctx.fs` 声明与 `fs/*` 事件词汇表。

- 通过声明合并把 `fs` 挂到 Context 上，并声明 `fs/write-intent`、`fs/edit-intent` 两个 waterfall 决策事件与 `fs/observed` 的 emit 记录事件及其参数（[packages/fs/fs/src/index.ts:44-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/index.ts#L44-L78)）
- 抽象类继承 `Service`，构造时以服务名 `fs` 注册，任何后端挂载即填充 `ctx.fs`（[packages/fs/fs/src/index.ts:86-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/index.ts#L86-L89)）
- `sandboxMode` 取值器默认返回 `undefined`，即基类与不做限制的后端对外声明自己不设沙箱默认模式（[packages/fs/fs/src/index.ts:103-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/index.ts#L103-L105)）
- `processPathFromHostPath` 的基类实现丢弃入参并返回 `undefined`，即默认不提供宿主路径到本执行世界的映射（[packages/fs/fs/src/index.ts:136-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/index.ts#L136-L139)）
- 默认导出 `FileSystem`，作为后端继承与 Loader 解析的入口（[packages/fs/fs/src/index.ts:265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/index.ts#L265)）

### packages/fs/fs/src/invariant.ts

包自带的不变量伴生插件，对 `fs/*` 事件流做数据校验。

- `validateTarget` 在 `targetKey` 或 `displayPath` 为空串时判定失败（[packages/fs/fs/src/invariant.ts:15-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/invariant.ts#L15-L18)）
- 安装器挂全局 `internal/dispatch` 监听，只放行三个 `fs/*` 事件名并校验其首参目标（[packages/fs/fs/src/invariant.ts:21-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/invariant.ts#L21-L27)）
- 对 `fs/observed` 额外要求 `present` 观察带非空版本，且 `kind` 只能是 `present` 或 `absent`（[packages/fs/fs/src/invariant.ts:27-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/invariant.ts#L27-L38)）
- `apply` 用包名注册安装器并返回 disposer（[packages/fs/fs/src/invariant.ts:47-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/invariant.ts#L47-L48)）

### packages/fs/fs/src/types.ts

文件系统词汇表：不透明标识、元数据、写入意图/结果与错误码分类。

- `FsTargetKey()` 把后端提供的原始字符串直接打品牌，不做任何校验（[packages/fs/fs/src/types.ts:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/types.ts#L24-L26)）
- `FsVersion()` 同样只打品牌、不校验（[packages/fs/fs/src/types.ts:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/types.ts#L43-L45)）
- `FsError` 继承 `HarnessError`，把稳定的 `FsErrorCode` 同时传给基类并覆写为只读字段，供调用方按码分支（[packages/fs/fs/src/types.ts:196-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs/src/types.ts#L196-L203)）

### packages/fs/fs/tsconfig.json

TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
