---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/test-support/agent-loop-testkit
---

# packages/test-support/agent-loop-testkit

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、12 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/test-support/agent-loop-testkit/README.md

该测试支持包的说明文档，描述如何在挂载具体 agent loop 之前先把前置服务装好。

- 无运行期机制

### packages/test-support/agent-loop-testkit/package.json

该包的 npm 清单，声明入口、导出映射、发布文件与依赖。

- `main` / `types` 把包入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/test-support/agent-loop-testkit/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/test-support/agent-loop-testkit/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/test-support/agent-loop-testkit/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/package.json#L28-L32)）
- `type: module` 使产物按 ESM 解析（[packages/test-support/agent-loop-testkit/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/package.json#L13)）
- 五个被挂载的服务包与 cordis、invariants 全部声明为 peerDependencies，由宿主提供实例（[packages/test-support/agent-loop-testkit/package.json:34-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/package.json#L34-L42)）

### packages/test-support/agent-loop-testkit/src/index.ts

导出 `mountAgentLoopTestDependencies`，在测试上下文上按固定顺序挂载 agent loop 的前置服务。

- 按 LLM 运行时、会话存储、系统提示词、工具注册表、Agent 注册表的固定顺序逐个 `await ctx.plugin`（[packages/test-support/agent-loop-testkit/src/index.ts:37-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/src/index.ts#L37-L46)）
- 系统提示词与工具注册表的配置从 `options` 原样转发，未提供时传入空对象（[packages/test-support/agent-loop-testkit/src/index.ts:43-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/src/index.ts#L43-L44)）
- 函数停在 AgentLoop 之前，不挂载循环本身也不注册适配器（[packages/test-support/agent-loop-testkit/src/index.ts:41-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/src/index.ts#L41-L45)）

### packages/test-support/agent-loop-testkit/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包所有权。

- installer 为空函数，不安装任何运行期检查（[packages/test-support/agent-loop-testkit/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/src/invariant.ts#L17-L21)）
- `apply` 以包名向 `ctx.invariants` 注册并返回注册的 disposer（[packages/test-support/agent-loop-testkit/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/agent-loop-testkit/src/invariant.ts#L28-L29)）

### packages/test-support/agent-loop-testkit/tsconfig.json

该包的 TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
