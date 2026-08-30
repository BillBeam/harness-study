---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/subagent-fork-in-process
---

# packages/subagent/subagent-fork-in-process

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、14 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/subagent-fork-in-process/README.md

包 README，用带 front matter 的说明文档描述该后端的选型、种子边界、最小组合与限制。

- 无运行期机制

### packages/subagent/subagent-fork-in-process/package.json

包清单，声明入口、发布文件集合与依赖关系。

- `main`/`types` 与 `exports` 决定 `.`、`./invariant`、`./src/*`、`./package.json` 四个子路径各自解析到哪个文件（[packages/subagent/subagent-fork-in-process/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/package.json#L14-L27)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/subagent/subagent-fork-in-process/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/package.json#L28-L32)）
- `peerDependencies` 要求宿主提供 agent、session、subagent 与共享的进程内驱动，运行期由宿主解析这些实现（[packages/subagent/subagent-fork-in-process/package.json:34-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/package.json#L34-L41)）

### packages/subagent/subagent-fork-in-process/src/index.ts

插件入口：计算父会话日志的已完成回合前缀作为子会话种子，并把 fork provider 注册到 `ctx.subagents`。

- 导出 `name` 与 `inject = ['subagents']`，刻意不注入 `tools`，使该后端的 apply 时机与委派工具在工具列表中的位置不受结构化输出影响（[packages/subagent/subagent-fork-in-process/src/index.ts:23-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/src/index.ts#L23-L28)）
- `Config` schema 只有 `providerName`，默认 `fork`（[packages/subagent/subagent-fork-in-process/src/index.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/src/index.ts#L36-L38)）
- `completedTurnPrefix` 取父会话事件里最后一个 `turn/end`，按 `seq + 1` 切片得到从序号 0 起连续的种子；没有已完成回合时返回空数组，进行中的回合永远不进种子（[packages/subagent/subagent-fork-in-process/src/index.ts:48-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/src/index.ts#L48-L54)）
- provider 声明 `agentOptions`、`outputSchema`、`depthLimit`、`toolFilter`、`persona` 五项能力全开，共享服务据此接受这些启动参数（[packages/subagent/subagent-fork-in-process/src/index.ts:63-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/src/index.ts#L63-L69)）
- provider 声明 `inheritsParentContext = true`，标明子会话被父的已完成回合前缀播种（[packages/subagent/subagent-fork-in-process/src/index.ts:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/src/index.ts#L71)）
- `start` 计算前缀后调用共享进程内驱动，前缀为空时整个 `seed` 字段省略，使子会话保持未播种（[packages/subagent/subagent-fork-in-process/src/index.ts:75-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/src/index.ts#L75-L82)）
- `prepareContinuable` 在创建时刻一次性捕获同一前缀作为可续子代的创建规格，之后的冷恢复重放该前缀而不重新 fork 父的新历史（[packages/subagent/subagent-fork-in-process/src/index.ts:90-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/src/index.ts#L90-L96)）
- `apply` 把 provider 以配置名注册到 `ctx.subagents`（[packages/subagent/subagent-fork-in-process/src/index.ts:99-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/src/index.ts#L99-L101)）

### packages/subagent/subagent-fork-in-process/src/invariant.ts

本包的不变量伴生插件，被包级不变量注册表加载。

- 以包名在 `ctx.invariants` 上登记本包并安装一个空检查器，返回该注册的 disposer（[packages/subagent/subagent-fork-in-process/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-fork-in-process/src/invariant.ts#L21-L29)）

### packages/subagent/subagent-fork-in-process/tsconfig.json

包级 TypeScript 编译配置，声明源码根目录、类型输出目录与工作区引用。

- 无运行期机制
