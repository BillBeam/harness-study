---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-checkpoint-policy
---

# packages/session/session-checkpoint-policy

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、18 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-checkpoint-policy/README.md

该包的说明文档，描述这个检查点插件挂载方式、三个屏障位置与失败语义，供使用者与维护者阅读。

- 无运行期机制

### packages/session/session-checkpoint-policy/package.json

该包的 npm 清单，声明入口、发布文件与对等依赖。

- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，并放开 `./src/*` 与 `./package.json` 的直接引用（[packages/session/session-checkpoint-policy/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/package.json#L16-L27)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/session/session-checkpoint-policy/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/package.json#L14-L15)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/session/session-checkpoint-policy/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/package.json#L28-L32)）
- `type: "module"` 使所有产物按 ESM 解析（[packages/session/session-checkpoint-policy/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/package.json#L13)）

### packages/session/session-checkpoint-policy/src/index.ts

插件主入口，在 `llm/stream`、`tools/execute`、`agent/pre-step` 三个瀑布上挂监听，把会话事件刷入持久化后端。

- `inject` 声明依赖 `llm`、`sessionPersistence`、`sessions`、`tools` 四个服务，插件在它们就绪前不会 apply（[packages/session/session-checkpoint-policy/src/index.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/index.ts#L18)）
- `afterCheckpoint` 返回一个异步生成器，先 `await ctx.sessions.flush(session)` 再 `yield* next()`，把下游模型流的构造推迟到刷盘之后（[packages/session/session-checkpoint-policy/src/index.ts:29-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/index.ts#L29-L38)）
- `abortedBeforeDispatchResult` 构造 `isError: true`、正文为 `Error: tool call aborted before dispatch` 的工具结果，错误信息带 `name: 'AbortError'` 与 `code: TOOL_ABORTED_BEFORE_DISPATCH`（[packages/session/session-checkpoint-policy/src/index.ts:41-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/index.ts#L41-L50)）
- `llm/stream` 监听在 `options.sessionId` 为 `undefined` 或该 id 查不到活跃会话时直接 `next()`，不做任何刷盘（[packages/session/session-checkpoint-policy/src/index.ts:64-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/index.ts#L64-L67)）
- 命中活跃会话时，`llm/stream` 监听改为返回 `afterCheckpoint` 包裹的流，刷盘失败即抛出、下游适配器不被调用（[packages/session/session-checkpoint-policy/src/index.ts:67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/index.ts#L67)）
- `tools/execute` 监听在 `exec.agent === undefined` 或 `exec.parent !== undefined`（嵌套调用）时直接 `next()`，不额外刷盘（[packages/session/session-checkpoint-policy/src/index.ts:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/index.ts#L71)）
- 顶层工具调用先 `await ctx.sessions.flush(exec.agent.session)` 再进工具体，刷盘 reject 时工具体不执行（[packages/session/session-checkpoint-policy/src/index.ts:72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/index.ts#L72)）
- 刷盘完成后若 `exec.signal.aborted` 为真，直接返回中止结果，不调用 `next()`、不进入工具体（[packages/session/session-checkpoint-policy/src/index.ts:73-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/index.ts#L73-L74)）
- `agent/pre-step` 监听在每次派生下一个请求前 `await ctx.sessions.flush(agent.session)`，再 `next()` 返回步进决定（[packages/session/session-checkpoint-policy/src/index.ts:79-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/index.ts#L79-L82)）

### packages/session/session-checkpoint-policy/src/invariant.ts

该包的不变量伴随插件，向 `invariants` 服务登记包名。

- `inject` 声明依赖 `invariants` 服务（[packages/session/session-checkpoint-policy/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/invariant.ts#L15)）
- `install` 是空实现，不注册任何运行期检查（[packages/session/session-checkpoint-policy/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)`，占用该包名并返回其 disposer（[packages/session/session-checkpoint-policy/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-checkpoint-policy/src/invariant.ts#L28-L29)）

### packages/session/session-checkpoint-policy/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工程引用。

- 无运行期机制
