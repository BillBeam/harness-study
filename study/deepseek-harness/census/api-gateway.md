---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/api/gateway
---

# packages/api/gateway

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、20 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/api/gateway/src/stream-server.ts

网关侧的 WebSocket 复用服务端，把一条物理 socket 上的多条逻辑流握手、分发、取消与关闭全部拥有；由网关的连接适配层在 HTTP upgrade 时调用。

- `RemoteStreamMuxServer` 持有一个 `noServer` 模式的 `WebSocketServer`、一组未完成连接的 Promise 与一个心跳定时器句柄（[packages/api/gateway/src/stream-server.ts:23-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L23-L26)）
- 构造函数把流分发器 `open`、错误到线上失败值的映射器 `failure`、心跳间隔毫秒数存为实例私有字段（[packages/api/gateway/src/stream-server.ts:33-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L33-L37)）
- `handleUpgrade` 把已通过鉴权的 upgrade 请求、socket 与残留字节交给 ws 完成握手，握手回调里启动心跳、为该 socket 建一个连接对象并运行，把它的完成 Promise 加入集合、结束后移除（[packages/api/gateway/src/stream-server.ts:45-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L45-L53)）
- `close` 先清掉心跳定时器，再对所有客户端 socket 调 `terminate()`，等 `server.close` 回调，最后等所有连接的完成 Promise（[packages/api/gateway/src/stream-server.ts:56-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L56-L67)）
- `startHeartbeat` 只建一个定时器，周期性对处于 `OPEN` 的 socket 发 Ping 控制帧，并对定时器调 `unref()`（[packages/api/gateway/src/stream-server.ts:70-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L70-L78)）
- 连接对象用一个 Map 记录 streamId 到活动流，用 `writes` 串起所有待写 Promise（[packages/api/gateway/src/stream-server.ts:87-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L87-L88)）
- `run` 监听 `close` 解决关闭 Promise、监听 `error` 时直接 `terminate()`、收到二进制消息用状态码 1003 关闭、消息解析抛错时用状态码 1008 关闭（[packages/api/gateway/src/stream-server.ts:96-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L96-L111)）
- socket 关闭后对全部仍在册的流调 `abort` 并带上 socket 已关闭的错误，再等它们各自的 `done`（[packages/api/gateway/src/stream-server.ts:112-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L112-L116)）
- `receive` 解析出的 `cancel` 消息对应地 abort 该 streamId 的控制器并返回（[packages/api/gateway/src/stream-server.ts:118-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L118-L123)）
- 重复的 streamId 抛错，从而由消息回调把连接以 1008 关闭（[packages/api/gateway/src/stream-server.ts:124-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L124-L126)）
- 新的 open 请求建一个 `AbortController`、把活动流登记进 Map、启动 `pump`、并在 pump 无论成败结束后把该 streamId 从 Map 删除（[packages/api/gateway/src/stream-server.ts:127-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L127-L137)）
- `pump` 用 endpoint、payload 与该流的 abort 信号调 `open` 取到异步可迭代对象，对每个值发一帧 `item`，迭代自然结束且未被 abort 时补发一帧 `end`（[packages/api/gateway/src/stream-server.ts:145-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L145-L150)）
- `pump` 捕获到异常时，若未被 abort 且 socket 仍 `OPEN`，用 `failure` 映射后发一帧 `error`；该终结帧本身发不出去就用状态码 1011 关闭整条连接（[packages/api/gateway/src/stream-server.ts:151-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L151-L161)）
- `send` 先 `JSON.stringify`，序列化失败直接返回 rejected Promise 并附 cause（[packages/api/gateway/src/stream-server.ts:164-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L164-L170)）
- `send` 把每次写挂在 `this.writes` 之后形成串行写队列，写前检查 socket 是否 `OPEN` 否则 reject，并按 `socket.send` 回调的 error 决定 resolve 还是 reject，同时把吞掉错误的版本存回 `writes`（[packages/api/gateway/src/stream-server.ts:171-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L171-L182)）
- `rawText` 把 ws 的三种 `RawData` 形态（Buffer 数组、ArrayBuffer、Buffer）统一解成 utf8 字符串（[packages/api/gateway/src/stream-server.ts:186-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L186-L190)）
- `rejectRemoteStreamUpgrade` 不把 socket 交给 ws，直接手写一段 401 或 403 的 HTTP 响应（含 `Connection: close`、Content-Type、Content-Length 与小写 body）并 `end`（[packages/api/gateway/src/stream-server.ts:197-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/src/stream-server.ts#L197-L208)）

### packages/api/gateway/src/types.ts

网关的请求、服务、错误码与事件源契约的类型模块，被网关实现与各连接适配器引用。

- 无运行期机制

### packages/api/gateway/tsconfig.json

包根的 solution-only TypeScript 配置，`files` 为空，只引用 Host 与 Client 两个 face 的叶子配置。

- 无运行期机制

### packages/api/gateway/tsdown.config.ts

包的 tsdown 打包配置，默认导出交给 `packages/client/tsdown.client.ts` 的共享预设生成。

- 默认导出把包名与两个 Node 半边入口 `lib/types/index.js`、`lib/types/invariant.js` 交给 `clientBundle`，由它按 `DSH_BUILD_FACE` 选出该轮要产出的 Node 库配置与浏览器 bundle 配置（[packages/api/gateway/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/gateway/tsdown.config.ts#L1-L3)）
