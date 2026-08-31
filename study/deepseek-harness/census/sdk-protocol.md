---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/sdk/protocol
---

# packages/sdk/protocol

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、33 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/sdk/protocol/README.md

该包的英文 README，描述换行分隔 JSON-RPC 传输与 SDK 方法／通知类型，供实现或调试线路两端的人阅读。

- 无运行期机制

### packages/sdk/protocol/package.json

该包的 npm 清单，声明包名、模块解析入口与随包发布的文件。

- `type: module`、`main: lib/index.js`、`types: lib/types/index.d.ts` 决定运行期从该包解析到的入口文件（[packages/sdk/protocol/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant` 与 `./package.json` 三个子路径，其余深层导入不可解析（[packages/sdk/protocol/package.json:16-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/package.json#L16-L26)）
- `files` 把随包发布的内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/sdk/protocol/package.json:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/package.json#L27-L31)）

### packages/sdk/protocol/src/index.ts

包根入口模块，把传输实现与线路类型汇总为对外导入面。

- 仅把 `JsonRpcLineTransport` 与 `JsonRpcResponseError` 作为运行期值导出，`types.ts` 全部成员以 `export type` 导出、编译后不在运行期存在（[packages/sdk/protocol/src/index.ts:11-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/index.ts#L11-L27)）

### packages/sdk/protocol/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包名。

- 声明插件名 `sdk-protocol-invariant` 并要求注入 `invariants` 服务，未就绪时插件不会应用（[packages/sdk/protocol/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/invariant.ts#L13-L15)）
- 安装函数为空体，登记后不注册任何运行期检查（[packages/sdk/protocol/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/invariant.ts#L22)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并把注册返回的 disposer 作为插件卸载句柄（[packages/sdk/protocol/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/invariant.ts#L29-L30)）

### packages/sdk/protocol/src/transport.ts

换行分隔 JSON-RPC 2.0 传输实现，被服务端插件与各语言 SDK 客户端共用于收发帧。

- `JsonRpcResponseError` 保留线路上的 `code`、`message` 与可选 `data`，并把 `name` 固定为 `JsonRpcResponseError`（[packages/sdk/protocol/src/transport.ts:18-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L18-L28)）
- 传输实例持有行缓冲、UTF-8 `StringDecoder`、启动标记、两个可替换处理器与按 id 索引的待答请求表（[packages/sdk/protocol/src/transport.ts:63-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L63-L68)）
- `start()` 幂等地挂上输入流的 `data`／`error`／`end` 监听，重复调用不再挂第二次（[packages/sdk/protocol/src/transport.ts:76-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L76-L82)）
- `close()` 摘除三个监听并以 `JSON-RPC transport closed` 拒绝全部待答请求，不销毁调用方持有的流（[packages/sdk/protocol/src/transport.ts:87-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L87-L92)）
- `onRequest` 与 `onNotification` 各自安装单个处理器并覆盖先前的处理器（[packages/sdk/protocol/src/transport.ts:99-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L99-L110)）
- `request` 以 `req_` 加去横线 UUID 生成请求 id，并写出带 `jsonrpc`／`id`／`method`／`params` 的帧（[packages/sdk/protocol/src/transport.ts:121-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L121-L123)）
- 传入的 `signal` 若已中止则直接拒绝，中止时从待答表删除该 id 并以 reason 拒绝，settle 时移除 abort 监听（[packages/sdk/protocol/src/transport.ts:126-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L126-L147)）
- 写帧抛错时删除待答条目、摘除 abort 监听并以该错误拒绝（[packages/sdk/protocol/src/transport.ts:148-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L148-L154)）
- `notify` 在 `params` 为 `undefined` 时写出不含 `params` 成员的帧（[packages/sdk/protocol/src/transport.ts:158-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L158-L160)）
- `flush` 向输出流写空串并等待写回调，以此等齐先前帧的写入（[packages/sdk/protocol/src/transport.ts:166-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L166-L173)）
- `onData` 把 Buffer 经 `StringDecoder` 解码后追加到缓冲再排空行（[packages/sdk/protocol/src/transport.ts:175-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L175-L178)）
- `drainLines` 按 `\n` 逐行切出、`trim` 后跳过空行，并对每行发起处理（[packages/sdk/protocol/src/transport.ts:180-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L180-L189)）
- 输入流 `error` 事件以该错误拒绝全部待答请求（[packages/sdk/protocol/src/transport.ts:191-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L191-L193)）
- 输入流 `end` 事件先把解码器残留并入缓冲并排空，再以 `JSON-RPC input closed` 拒绝全部待答请求（[packages/sdk/protocol/src/transport.ts:195-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L195-L199)）
- JSON 解析失败的行被静默丢弃，非对象帧同样丢弃（[packages/sdk/protocol/src/transport.ts:201-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L201-L210)）
- 帧同时带 `id` 与 `method` 走请求路径，只有 `id` 走响应路径，只有 `method` 交给通知处理器（无处理器则丢弃）（[packages/sdk/protocol/src/transport.ts:211-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L211-L224)）
- 未安装请求处理器时对入站请求回 `-32601` 与 `method not found: <method>`（[packages/sdk/protocol/src/transport.ts:226-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L226-L231)）
- 处理器成功时写出 `result` 帧，抛错时写出 `-32603` 并带该错误的 message（[packages/sdk/protocol/src/transport.ts:232-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L232-L237)）
- 入站响应只在待答表命中时处理：先删除条目，`error` 帧以 `JsonRpcResponseError` 拒绝（`code` 非数字取 `undefined`，`message` 非字符串取 `JSON-RPC error`），否则以 `frame.result` 兑现（[packages/sdk/protocol/src/transport.ts:240-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L240-L254)）
- 所有出站帧统一经 `JSON.stringify` 后追加 `\n` 写入输出流（[packages/sdk/protocol/src/transport.ts:260-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L260-L262)）
- `failPending` 先快照并清空待答表再逐个拒绝，避免拒绝回调期间重入（[packages/sdk/protocol/src/transport.ts:264-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L264-L268)）
- `objectParams` 把数组与标量形式的 `params` 归一为空对象后再交给处理器（[packages/sdk/protocol/src/transport.ts:272-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L272-L274)）
- `abortError` 把非 Error 的中止 reason 字符串化成 `JSON-RPC request aborted: <reason>`（[packages/sdk/protocol/src/transport.ts:277-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/protocol/src/transport.ts#L277-L279)）

### packages/sdk/protocol/src/types.ts

线路方法的请求／结果与通知载荷类型声明，被服务端与客户端共用。

- 无运行期机制

### packages/sdk/protocol/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、声明输出目录与工程引用。

- 无运行期机制
