---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/sdk/server
---

# packages/sdk/server

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、47 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/sdk/server/README.md

该包的英文 README，说明这个 stdio JSON-RPC 服务插件的挂载方式、配置项、握手与关停约定。

- 无运行期机制

### packages/sdk/server/package.json

该包的 npm 清单，声明入口、导出子路径、发布文件与依赖。

- `type: module`、`main: lib/index.js`、`types: lib/types/index.d.ts` 决定运行期从该包解析到的入口文件（[packages/sdk/server/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/package.json#L13-L15)）
- `exports` 开放根入口、`./invariant`、通配的 `./src/*` 源码路径与 `./package.json`（[packages/sdk/server/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/package.json#L16-L27)）
- `files` 把随包发布的内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/sdk/server/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/package.json#L28-L32)）
- `dependencies` 只列 schemastery，其余（agent、attachment、llm、llm-deepseek、sdk-protocol、session、subagent 等）为 peerDependencies，由宿主组合树提供（[packages/sdk/server/package.json:34-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/package.json#L34-L48)）

### packages/sdk/server/src/index.ts

插件入口模块，负责配置模式、stdio 接线、请求派发与关停退出任务。

- 导出插件名 `sdk-jsonrpc-server` 并只注入 `agents` 服务，LLM 服务在 initialize 时以 `ctx.get` 可选读取（[packages/sdk/server/src/index.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L20-L22)）
- `Config` 只暴露 `maxTokensAsSuccess` 一个布尔字段，默认 `false`；`input`／`output`／`exit` 是不进 schema 的运行期钩子（[packages/sdk/server/src/index.ts:24-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L24-L38)）
- `apply` 捕获 `ctx.root.fiber`，供协议 `shutdown` 处置整个根运行时（[packages/sdk/server/src/index.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L51)）
- 未注入钩子时 input／output／exit 分别退回 `process.stdin`、`process.stdout` 与 `process.exit`（[packages/sdk/server/src/index.ts:52-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L52-L57)）
- 在这对流上构造 `JsonRpcLineTransport`，并把 `maxTokensAsSuccess` 传给 `HarnessSdkJsonRpcServer`（[packages/sdk/server/src/index.ts:59-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L59-L62)）
- 共享一个 `exitTask`：先 `transport.flush()`，再 `rootFiber.dispose()`，最后 `exit(0)`；两步都用 `allSettled` 包住，并发的 shutdown 请求只触发一次处置与退出（[packages/sdk/server/src/index.ts:66-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L66-L74)）
- 收到 `initialize` 时先 `await ctx.get('loader')?.await()`，等当前插件树结算后才交给服务器处理（[packages/sdk/server/src/index.ts:76-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L76-L86)）
- 所有入站请求转交 `server.handleRequest(method, params)`，其返回值作为 JSON-RPC 响应（[packages/sdk/server/src/index.ts:87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L87)）
- `shutdown` 的结果先返回，再由 `setImmediate` 排入处置退出任务（[packages/sdk/server/src/index.ts:88-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L88-L92)）
- `ctx.effect` 在挂载时启动传输，卸载时先 `server.shutdown()` 再 `transport.close()`，只卸载本插件不退出进程（[packages/sdk/server/src/index.ts:95-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/index.ts#L95-L101)）

### packages/sdk/server/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包名。

- 声明插件名 `sdk-jsonrpc-server-invariant` 并要求注入 `invariants` 服务（[packages/sdk/server/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/invariant.ts#L13-L15)）
- 安装函数为空体，登记后不注册任何运行期检查（[packages/sdk/server/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并把 disposer 作为插件卸载句柄（[packages/sdk/server/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/invariant.ts#L28-L29)）

### packages/sdk/server/src/server.ts

`HarnessSdkJsonRpcServer` 类，实现三个协议方法、四类出站通知与自有状态的拆卸，被插件入口的请求派发调用。

- `encodedImage` 以 `type === 'image'` 且带 `data` 字段判定内联图像块（[packages/sdk/server/src/server.ts:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L34-L36)）
- `durablePromptContent` 在没有内联图像时原样返回内容块；有图像但未挂载 `attachments` 服务时抛错；否则经 `admitEncodedImages` 入库并按原顺序把每个内联图像替换为附件引用（[packages/sdk/server/src/server.ts:38-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L38-L51)）
- `subagentParentOf` 从服务持有的 scoped carrier 上取回委派方 Agent（[packages/sdk/server/src/server.ts:53-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L53-L56)）
- `successStatus` 把 `completed` 映射为 `ok`，把 `max-tokens` 仅在 `maxTokensAsSuccess` 为真时映射为 `ok`，其余一律 `error`（[packages/sdk/server/src/server.ts:64-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L64-L67)）
- 实例字段把 cwd 初始化为 `process.cwd()`、provider 与 model 初始化为 `deepseek-official`，并持有会话表、在建会话表、订阅 disposer 列表与 `initialized`／`shuttingDown` 标记（[packages/sdk/server/src/server.ts:75-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L75-L86)）
- 构造时订阅 `session/event`，把运行时中每个会话的每条会话日志事件按 `{ sessionId, event }` 作为 `session.event` 通知推给客户端（[packages/sdk/server/src/server.ts:94-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L94-L97)）
- 订阅 `agent/status`，把整体 agent 的 idle／running 转换作为 `session.status` 通知推出（[packages/sdk/server/src/server.ts:98-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L98-L100)）
- 订阅 `session/created`，仅当会话头带 `parentSession` 时才发 `subagent.started` 通知（[packages/sdk/server/src/server.ts:101-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L101-L109)）
- 订阅 `subagent/end`，`info.local` 为假时直接返回不通知；为真时组装 provider、agentId、父子会话 id、映射后的 status 与 stopReason 发出 `subagent.finished`，`lastAssistantMessage` 仅在存在时才作为字段出现（[packages/sdk/server/src/server.ts:110-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L110-L126)）
- `initialize` 先校验 `reasoningEffort` 必须是非空字符串，否则抛 `TypeError`（[packages/sdk/server/src/server.ts:135-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L135-L138)）
- 校验 `maxTokens` 必须是正的安全整数，否则抛 `TypeError`（[packages/sdk/server/src/server.ts:139-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L139-L142)）
- 把入参 `cwd` 经 `resolve` 归一为绝对路径（[packages/sdk/server/src/server.ts:143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L143)）
- 当没有该 provider 的已注册适配器时，非 `deepseek-official` 直接抛错，`deepseek-official` 则就地 `ctx.plugin` 挂载 DeepSeek 适配器并记住其 fiber（[packages/sdk/server/src/server.ts:149-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L149-L152)）
- 调用 `llm.resolveCallConfig` 用 provider／model／可选 effort／可选 maxTokens 解析确切路由，解析失败即握手失败（[packages/sdk/server/src/server.ts:154-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L154-L160)）
- 只有解析成功后才写入 cwd／provider／model／effort／maxTokens 并置 `initialized`，随后返回固定的 `deepseek-harness-sdk-runtime` 与版本 `0.0.1`（[packages/sdk/server/src/server.ts:161-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L161-L167)）
- `prompt` 在未完成 initialize 时抛 `SDK server is not initialized`（[packages/sdk/server/src/server.ts:176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L176)）
- 取到或创建会话记录后先校验 agent 仍在注册表中，图像入库跨越异步边界后再校验一次（[packages/sdk/server/src/server.ts:177-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L177-L185)）
- 以 `source: { kind: 'user' }` 构造用户消息、经 `agent.followup` 入队，并把该消息 id 作为 `messageId` 立即返回（[packages/sdk/server/src/server.ts:186-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L186-L191)）
- `assertLiveAgent` 用 `ctx.agents.get(id)` 与持有的 agent 做同一实例比对，不一致则抛 `session agent was disposed outside the server`（[packages/sdk/server/src/server.ts:194-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L194-L198)）
- `shutdown` 用 `shutdownTask ??=` 缓存，重复调用共享同一次拆卸（[packages/sdk/server/src/server.ts:205-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L205-L208)）
- `performShutdown` 先置 `shuttingDown`、等待所有在建会话结算并清表，再清空会话表（[packages/sdk/server/src/server.ts:210-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L210-L216)）
- 逐个 `pop` 并调用订阅 disposer，单个抛错被收集而不中断其余（[packages/sdk/server/src/server.ts:217-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L217-L224)）
- 并行处置全部 agent handle 与自挂的 LLM fiber，把被拒绝的原因并入失败列表（[packages/sdk/server/src/server.ts:225-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L225-L232)）
- 单个失败原样抛出，多个失败包成 `AggregateError`，全部成功时返回空对象（[packages/sdk/server/src/server.ts:233-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L233-L235)）
- `handleRequest` 按 `initialize`／`session/prompt`／`shutdown` 三个方法名派发，未知方法抛错（转成 JSON-RPC 错误响应）（[packages/sdk/server/src/server.ts:245-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L245-L256)）
- `getOrCreateSession` 在关停中抛错，命中已有记录直接返回，命中在建 Promise 则复用，否则登记新建并在结算后从在建表移除（[packages/sdk/server/src/server.ts:258-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L258-L271)）
- `createSession` 用握手存下的 cwd 与 provider／model／条件性 effort／条件性 maxTokens 调 `ctx.agents.create`，并把 handle 存入会话表（[packages/sdk/server/src/server.ts:273-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L273-L291)）
- `hasAdapterFor` 用 `ctx.get('llm')?.listProviders()` 按 id 匹配，服务缺席时返回 false（[packages/sdk/server/src/server.ts:293-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/server/src/server.ts#L293-L295)）

### packages/sdk/server/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、声明输出目录与工程引用。

- 无运行期机制
