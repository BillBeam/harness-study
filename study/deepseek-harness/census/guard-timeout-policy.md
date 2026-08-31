---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/guard/timeout-policy
---

# packages/guard/timeout-policy

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、18 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/guard/timeout-policy/README.md

包的说明文档，介绍该插件如何为声明了超时预算的工具调用装配截止时间，并列出配置方式、模型可见文本与已知限制。

- 无运行期机制

### packages/guard/timeout-policy/package.json

包清单，声明该包的入口、发布内容与依赖关系。

- `main` / `types` 把包的默认入口指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/guard/timeout-policy/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 和 `./package.json` 四个可解析入口，其余路径不可被导入（[packages/guard/timeout-policy/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 和 `lib/types/**/*.d.ts`（[packages/guard/timeout-policy/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/package.json#L28-L32)）

### packages/guard/timeout-policy/src/index.ts

插件主入口，在 `tools/execute` 瀑布上包一层工具调用超时，被基础 bundle 装载。

- 导出常量 `TOOL_TIMEOUT`，同时用作内部 deadline 的分类码和替换结果里的结构化错误 `code`（[packages/guard/timeout-policy/src/index.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L25)）
- 声明 `inject = ['tools']`，插件在 `tools` 服务可用之前不会 apply（[packages/guard/timeout-policy/src/index.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L31)）
- `toolTimeoutResult` 构造模型可见的替换结果：文本 `Error: tool call timed out after <ms>ms`、`isError: true`、错误信息 `{ name: 'ToolTimeoutError', code: TOOL_TIMEOUT }`（[packages/guard/timeout-policy/src/index.ts:41-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L41-L48)）
- `apply` 注册 `tools/execute` 瀑布监听器，包住每一次工具派发（[packages/guard/timeout-policy/src/index.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L56)）
- 从工具注册表按 `exec.name` 与 `exec.agent` 读取 `timeoutMs` 作为本次调用的预算（[packages/guard/timeout-policy/src/index.ts:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L57)）
- 未声明预算的工具直接 `next()` 透传，不装配任何截止时间（[packages/guard/timeout-policy/src/index.ts:59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L59)）
- 用 `deadline(exec.signal, timeoutMs, TOOL_TIMEOUT)` 派生带定时器的信号，并以 `using` 绑定其释放（[packages/guard/timeout-policy/src/index.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L61)）
- 派发前把派生信号写回 `exec.signal`，`finally` 中恢复上游信号，使后续监听器看不到本插件的信号（[packages/guard/timeout-policy/src/index.ts:65-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L65-L66)）
- `await next()` 返回后用 `timeoutOf(d.signal, TOOL_TIMEOUT)` 按分类码判定是否本插件的定时器触发，是则丢弃下游结果换成超时结果（[packages/guard/timeout-policy/src/index.ts:73-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L73-L76)）
- `finally` 无条件把 `exec.signal` 还原为调用方原信号（[packages/guard/timeout-policy/src/index.ts:77-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/index.ts#L77-L79)）

### packages/guard/timeout-policy/src/invariant.ts

包自带的不变量伴生插件，向 `invariants` 服务登记本包的所有权。

- 声明 `inject = ['invariants']`，伴生插件在该服务可用前不会 apply（[packages/guard/timeout-policy/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/invariant.ts#L15)）
- 安装器为空实现，运行期不注册任何检查（[packages/guard/timeout-policy/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该安装器并返回其 disposer（[packages/guard/timeout-policy/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/timeout-policy/src/invariant.ts#L28-L29)）

### packages/guard/timeout-policy/tsconfig.json

包的 TypeScript 编译配置，声明源码根、输出目录与工作区引用。

- 无运行期机制
