---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/core/agent-default-model
---

# packages/core/agent-default-model

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、23 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/core/agent-default-model/README.md

该包的说明文档，介绍进程级默认模型选择服务的配置字段与读写方法。

- 无运行期机制

### packages/core/agent-default-model/package.json

该包的 npm 清单，决定包名、入口与可被外部 import 的子路径。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/core/agent-default-model/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/package.json#L14-L15)）
- `exports` 开放根、`./invariant`、`./src/*` 与 `./package.json` 四类子路径（[packages/core/agent-default-model/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/package.json#L16-L27)）
- `files` 限定随包发布的运行期文件为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 d.ts（[packages/core/agent-default-model/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/package.json#L28-L32)）
- `type: module` 使所有产物按 ESM 加载（[packages/core/agent-default-model/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/package.json#L13)）

### packages/core/agent-default-model/src/index.ts

包入口：`ctx.agentDefaultModel` 服务，把组合期配置与设置层叠成一份供新建 Agent 使用的默认模型选择。

- 用 `settingsNamespace('agent-default-model')` 固定该服务占用的设置命名空间（[packages/core/agent-default-model/src/index.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L21)）
- 设置节的 schema 要求 `provider`、`model` 必填，`reasoningEffort` 可选（[packages/core/agent-default-model/src/index.ts:34-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L34-L38)）
- `selection()` 把存储的设置投影成 `ModelSelection`，缺省时省略 `reasoningEffort`，存在时经 `ReasoningEffortId` 转换（[packages/core/agent-default-model/src/index.ts:49-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L49-L57)）
- 插件 `Config` schema 只接受必填的 `provider` 与 `model`，不接受 `reasoningEffort`（[packages/core/agent-default-model/src/index.ts:65-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L65-L68)）
- 构造函数以 `agentDefaultModel` 名注册 Cordis 服务（[packages/core/agent-default-model/src/index.ts:72-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L72-L73)）
- 把组合期配置固化成一个条目对象并作为初始来源，使无设置提供方时也可用（[packages/core/agent-default-model/src/index.ts:74-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L74-L75)）
- `installSettingsSection` 注册设置节并通过 `setSource` 把 `this.source` 换成设置层的实时读取函数（[packages/core/agent-default-model/src/index.ts:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L76-L81)）
- `onChange` 为空函数：设置文档变化不触发任何重建（[packages/core/agent-default-model/src/index.ts:78-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L78-L80)）
- `currentSelection()` 每次现读当前来源并返回一份新对象（[packages/core/agent-default-model/src/index.ts:88-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L88-L90)）
- `saveSelection()` 经 `ctx.get('settings')?.replace` 整体写回选择，未挂设置服务时为空操作（[packages/core/agent-default-model/src/index.ts:98-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L98-L104)）
- 写回时 `reasoningEffort` 缺席则不写该字段，存在则转成字符串（[packages/core/agent-default-model/src/index.ts:102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L102)）
- 默认导出 `AgentDefaultModelConfig`，使其可作为 Cordis 服务插件被挂载（[packages/core/agent-default-model/src/index.ts:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/index.ts#L107)）

### packages/core/agent-default-model/src/invariant.ts

本包的不变量伴随插件，向 `invariants` 服务登记一个刻意为空的安装器。

- 声明 Cordis 插件名 `agent-default-model-invariant` 与 `invariants` 注入依赖（[packages/core/agent-default-model/src/invariant.ts:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/invariant.ts#L17-L19)）
- 安装器为空函数，不注册任何检查（[packages/core/agent-default-model/src/invariant.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/invariant.ts#L21-L22)）
- `apply` 以包名把该空安装器注册进 `ctx.invariants` 并返回其 disposer（[packages/core/agent-default-model/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/src/invariant.ts#L29-L30)）

### packages/core/agent-default-model/tsconfig.json

TypeScript 编译配置，声明 `rootDir`/`outDir` 与对工作区依赖包的项目引用。

- 无运行期机制

### packages/core/agent-default-model/tsdown.config.ts

打包配置，决定该包发布出的运行期 JS 文件由哪些入口生成。

- 声明两个互相独立的打包目标：`lib/types/index.js` 与 `lib/types/invariant.js` 各自打进 `lib`（[packages/core/agent-default-model/tsdown.config.ts:4-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/tsdown.config.ts#L4-L24)）
- 产物固定为 Node 平台、es2024 目标的 ESM，且不清理输出目录（[packages/core/agent-default-model/tsdown.config.ts:7-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-default-model/tsdown.config.ts#L7-L13)）
