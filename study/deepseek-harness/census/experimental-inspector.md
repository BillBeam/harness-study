---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/experimental/inspector
---

# packages/experimental/inspector

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 155 个文件、1069 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/experimental/inspector/README.md

这个包的说明文档，描述 Host/Client 两侧调试桥的运行布局、配置字段表与已知限制，供阅读者查阅。

- 无运行期机制

### packages/experimental/inspector/cordis.patch.yml

CLI 用 `--patch` 加载的构建产物组合覆盖文件。

- 向所选 profile 插入 id 为 `experimental-inspector`、入口为相对本文件的 `./lib/index.js` 的插件条目（[packages/experimental/inspector/cordis.patch.yml:6-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/cordis.patch.yml#L6-L8)）

### packages/experimental/inspector/cordis.source.patch.yml

源码启动时使用的组合覆盖文件，走 CLI 的 tsx 加载器。

- 向所选 profile 插入 id 为 `experimental-inspector`、入口为相对本文件的 `./src/index.ts` 的插件条目（[packages/experimental/inspector/cordis.source.patch.yml:4-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/cordis.source.patch.yml#L4-L6)）

### packages/experimental/inspector/package.json

包清单，声明模块入口、客户端装载元数据与随包发布的文件。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，模块类型为 ESM（[packages/experimental/inspector/package.json:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/package.json#L11-L13)）
- `exports` 暴露根入口、`./client`、`./invariant` 三个运行期入口，另开放 `./src/*` 与 `./package.json` 直读（[packages/experimental/inspector/package.json:14-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/package.json#L14-L29)）
- `dsh.client` 声明浏览器面：无注入依赖、platform 为 `web`、`immediately: true`（[packages/experimental/inspector/package.json:30-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/package.json#L30-L36)）
- `files` 把随包内容限定为三个 js 入口与类型声明（[packages/experimental/inspector/package.json:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/package.json#L37-L42)）

### packages/experimental/inspector/src/client/bridge/controller.ts

浏览器插件入口调用的构造函数，负责按 Host 注入的引导参数启动 Client 源传输。

- 用 `document.title` 作为源标签，取不到时用 `'Client'`（[packages/experimental/inspector/src/client/bridge/controller.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/controller.ts#L13)）
- 先等待 `ClientRealmSource.claim` 认领页面身份，再构造传输连接（[packages/experimental/inspector/src/client/bridge/controller.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/controller.ts#L14-L16)）
- 构造抛错时先关闭已认领的身份再向外抛（[packages/experimental/inspector/src/client/bridge/controller.ts:17-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/controller.ts#L17-L20)）

### packages/experimental/inspector/src/client/bridge/dispatcher.ts

Client 传输层收到已校验的 Worker 帧后调用的分发函数。

- 按 `frame.t` 把帧分派到接受、确认、重快照、拒绝、Runtime 请求/取消/确认/会话关闭、Console 启停、Sources 请求/会话关闭共十二类处理器（[packages/experimental/inspector/src/client/bridge/dispatcher.ts:42-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/dispatcher.ts#L42-L78)）
- 未列入的帧类型走 `assertNever` 抛出带原帧 JSON 的错误（[packages/experimental/inspector/src/client/bridge/dispatcher.ts:79-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/dispatcher.ts#L79-L86)）

### packages/experimental/inspector/src/client/bridge/lifecycle.ts

Client 传输的重连计时器，被 transport 的 socket 关闭路径调用。

- Worker 接受某代后把退避次数清零（[packages/experimental/inspector/src/client/bridge/lifecycle.ts:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/lifecycle.ts#L15-L17)）
- 已有待触发定时器或已关闭时不再排程新的重连（[packages/experimental/inspector/src/client/bridge/lifecycle.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/lifecycle.ts#L24)）
- 上界取 `min(maxDelayMs, baseDelayMs * 2 ** attempt)`，实际延时在该上界的一半到一倍之间随机（[packages/experimental/inspector/src/client/bridge/lifecycle.ts:25-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/lifecycle.ts#L25-L31)）
- `close()` 清掉待触发定时器并使后续重连请求全部被忽略（[packages/experimental/inspector/src/client/bridge/lifecycle.ts:34-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/lifecycle.ts#L34-L39)）

### packages/experimental/inspector/src/client/bridge/publisher.ts

Client 侧的观察记录发布器，跨重连保留缓冲并按 socket 背压分批发送。

- 关闭后 `publish` 静默丢弃记录（[packages/experimental/inspector/src/client/bridge/publisher.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L29)）
- `publish` 写入缓冲后立即尝试冲刷（[packages/experimental/inspector/src/client/bridge/publisher.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L30-L31)）
- 关闭后 `setState` 抛错而非丢弃（[packages/experimental/inspector/src/client/bridge/publisher.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L35)）
- `connect` 记录一代尚未被接受的 socket 与源描述符（[packages/experimental/inspector/src/client/bridge/publisher.ts:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L45-L47)）
- `accept` 只对当前代生效，标记已接受后先重放保留状态再冲刷队列（[packages/experimental/inspector/src/client/bridge/publisher.ts:53-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L53-L59)）
- `replace` 仅在 socket 是当前代且处于 OPEN 时发送整份状态替换帧（[packages/experimental/inspector/src/client/bridge/publisher.ts:65-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L65-L69)）
- `disconnect` 只清除活动传输，缓冲内容留给下一代重连（[packages/experimental/inspector/src/client/bridge/publisher.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L75-L77)）
- `close` 清空活动传输与延迟冲刷定时器（[packages/experimental/inspector/src/client/bridge/publisher.ts:80-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L80-L86)）
- 冲刷在未被接受或 socket 非 OPEN 时直接返回，`bufferedAmount` 超过上限时改为延迟重试（[packages/experimental/inspector/src/client/bridge/publisher.ts:88-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L88-L94)）
- 冲刷循环在 `bufferedAmount` 不超上限时逐批取出并发送，仍有剩余则再排程（[packages/experimental/inspector/src/client/bridge/publisher.ts:95-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L95-L101)）
- 延迟冲刷固定 25 毫秒且同时只保留一个定时器（[packages/experimental/inspector/src/client/bridge/publisher.ts:103-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/publisher.ts#L103-L109)）

### packages/experimental/inspector/src/client/bridge/rpc.ts

Client 侧非 CDP 查询通道，继承共享的查询关联实现。

- 把查询写入绑定到某一代 socket，socket 非 OPEN 时抛错而不是静默丢弃（[packages/experimental/inspector/src/client/bridge/rpc.ts:13-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/rpc.ts#L13-L20)）

### packages/experimental/inspector/src/client/bridge/transport.ts

浏览器端源连接，持有 WebSocket、Runtime 执行器、Console 观察器与查询通道，是 Client 面所有 Worker 交互的汇聚点。

- 源目录默认由 `discoverInspectorClientSourceCatalog()` 发现，标签默认取 `document.title`（[packages/experimental/inspector/src/client/bridge/transport.ts:50-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L50-L54)）
- 重连退避上下界取自 Host 注入的引导参数（[packages/experimental/inspector/src/client/bridge/transport.ts:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L57)）
- 发布器订阅 `'*'` 并用引导参数的队列条数、队列字节、单帧记录数与单帧字节做上限（[packages/experimental/inspector/src/client/bridge/transport.ts:58-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L58-L64)）
- Runtime 执行器的每会话对象上限、单结果属性上限与响应字节上限来自引导参数，脚本键解析走源目录（[packages/experimental/inspector/src/client/bridge/transport.ts:65-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L65-L69)）
- Console 事件只在未关闭、已被接受、socket OPEN 且存在当前代时发送，且帧必须是合法 JSON 且不超过单帧字节上限（[packages/experimental/inspector/src/client/bridge/transport.ts:70-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L70-L91)）
- 构造末尾立即发起第一次连接（[packages/experimental/inspector/src/client/bridge/transport.ts:96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L96)）
- `close()` 依次关闭 Console、取消全部在途 Runtime 请求、重置执行器、终止查询、停止重连、关闭发布器（[packages/experimental/inspector/src/client/bridge/transport.ts:100-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L100-L108)）
- 关闭时若 socket 仍 OPEN 则先发 `source/close` 再以 1000 码关闭，最后释放页面身份（[packages/experimental/inspector/src/client/bridge/transport.ts:109-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L109-L127)）
- 每次连接前重置 Console、取消在途请求、重置 Runtime 与查询通道，并从身份对象取一代新描述符（[packages/experimental/inspector/src/client/bridge/transport.ts:131-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L131-L137)）
- WebSocket 以引导参数中的端点与随机子协议令牌建立（[packages/experimental/inspector/src/client/bridge/transport.ts:138-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L138-L142)）
- 连接打开后发送 `source/open`，订阅 `'*'` 加上网络 topic 列表（[packages/experimental/inspector/src/client/bridge/transport.ts:143-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L143-L152)）
- 入站消息先按字节数校验单帧上限，超出即抛错（[packages/experimental/inspector/src/client/bridge/transport.ts:153-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L153-L158)）
- 入站消息先交给查询通道消费，未被消费才解析为 Worker 源帧（[packages/experimental/inspector/src/client/bridge/transport.ts:159-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L159-L161)）
- 除 `source/rejected` 外，源 id 或代号不匹配的帧被丢弃（[packages/experimental/inspector/src/client/bridge/transport.ts:162-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L162-L163)）
- 收到接受帧后置为已接受、重置退避、连接查询写入并放行发布器（[packages/experimental/inspector/src/client/bridge/transport.ts:165-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L165-L170)）
- 收到重快照帧后重发保留状态（[packages/experimental/inspector/src/client/bridge/transport.ts:172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L172)）
- 收到拒绝帧后打印错误并以 1008 码关闭连接（[packages/experimental/inspector/src/client/bridge/transport.ts:173-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L173-L176)）
- Runtime 请求异步执行，传输层失败时以 1011 码关闭连接（[packages/experimental/inspector/src/client/bridge/transport.ts:177-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L177-L182)）
- 取消帧中止对应请求，确认帧提交其对象句柄，会话关闭帧取消该会话全部请求并停用 Console、释放会话对象（[packages/experimental/inspector/src/client/bridge/transport.ts:183-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L183-L191)）
- Console 启停帧按会话开启或关闭事件产出（[packages/experimental/inspector/src/client/bridge/transport.ts:192-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L192-L193)）
- Sources 请求异步执行，传输层失败时以 1011 码关闭连接（[packages/experimental/inspector/src/client/bridge/transport.ts:194-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L194-L199)）
- 解析或分发抛错时打印并以 1008 码关闭连接（[packages/experimental/inspector/src/client/bridge/transport.ts:202-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L202-L205)）
- socket 关闭事件清空当前代状态、断开发布器与查询通道，并交给退避计时器安排下一次连接（[packages/experimental/inspector/src/client/bridge/transport.ts:207-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L207-L217)）
- error 事件不触发重连，重连只由 close 事件驱动（[packages/experimental/inspector/src/client/bridge/transport.ts:218-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L218-L220)）
- Runtime 执行为每个请求登记一个 `AbortController`，执行完成后若该请求已被替换则丢弃结果（[packages/experimental/inspector/src/client/bridge/transport.ts:228-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L228-L232)）
- 执行完成时若已关闭、socket 已换代或非 OPEN，则取消该请求而不发送响应（[packages/experimental/inspector/src/client/bridge/transport.ts:233-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L233-L237)）
- 确认操作校验会话归属后从在途表移除并提交执行器中的对象分配（[packages/experimental/inspector/src/client/bridge/transport.ts:240-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L240-L245)）
- 取消操作中止 `AbortController` 并回滚执行器中的对象分配（[packages/experimental/inspector/src/client/bridge/transport.ts:247-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L247-L253)）
- 按会话批量取消与全量取消分别遍历在途表中止并回滚（[packages/experimental/inspector/src/client/bridge/transport.ts:255-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L255-L270)）
- 源目录缺失时 Sources 请求返回 `invalid-request` 结果（[packages/experimental/inspector/src/client/bridge/transport.ts:279-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L279-L281)）
- Sources 失败结果携带原错误码（非目录错误记为 `internal-error`）并把消息截断到 2048 字符（[packages/experimental/inspector/src/client/bridge/transport.ts:283-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L283-L291)）
- Sources 响应若非合法 JSON 或超过单帧字节上限，整体替换为 `result-too-large` 结果（[packages/experimental/inspector/src/client/bridge/transport.ts:301-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L301-L309)）
- Sources 响应发送前再次校验连接与代号，不匹配则丢弃（[packages/experimental/inspector/src/client/bridge/transport.ts:310-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/bridge/transport.ts#L310-L311)）

### packages/experimental/inspector/src/client/cdp/console.ts

浏览器 Console 观察器，替换页面的 console 方法与全局错误监听，把事件分发给各个调试会话。

- 声明 `client-console` 能力，供握手时上报（[packages/experimental/inspector/src/client/cdp/console.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L13-L15)）
- 固定的方法映射表决定被包装的 18 个 console 方法及其对应的事件类型（[packages/experimental/inspector/src/client/cdp/console.ts:23-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L23-L42)）
- `enable` 加入会话集合，首个会话触发安装（[packages/experimental/inspector/src/client/cdp/console.ts:69-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L69-L73)）
- `disable` 移除会话、释放该会话的 `console` 对象组，会话清空后卸载（[packages/experimental/inspector/src/client/cdp/console.ts:79-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L79-L83)）
- `close` 置终态并复用重置路径，`reset` 清空会话并卸载（[packages/experimental/inspector/src/client/cdp/console.ts:86-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L86-L96)）
- 安装时替换 console 方法：替换函数先转发原方法再捕获参数，`assert` 只在断言为假时捕获且丢弃首个参数（[packages/experimental/inspector/src/client/cdp/console.ts:98-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L98-L112)）
- 安装时注册全局 `error` 与 `unhandledrejection` 监听（[packages/experimental/inspector/src/client/cdp/console.ts:113-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L113-L114)）
- 卸载时摘除全局监听并按逆序还原仍等于替换函数的 console 方法（[packages/experimental/inspector/src/client/cdp/console.ts:117-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L117-L125)）
- 全局错误事件优先取 `error`，缺失时用 `message` 构造 Error（[packages/experimental/inspector/src/client/cdp/console.ts:127-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L127-L131)）
- 未处理 Promise 拒绝取 `reason` 作为异常值（[packages/experimental/inspector/src/client/cdp/console.ts:133-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L133-L135)）
- Console 捕获先同步取时间戳与调用栈，再在微任务中向每个会话分发，分发异常被吞掉（[packages/experimental/inspector/src/client/cdp/console.ts:137-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L137-L150)）
- 异常捕获同样先取时间戳与栈再在微任务中分发，分发异常被吞掉（[packages/experimental/inspector/src/client/cdp/console.ts:152-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L152-L165)）
- 全局监听的挂载与摘除通过 `Reflect` 取全局函数，缺失时静默跳过（[packages/experimental/inspector/src/client/cdp/console.ts:168-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/console.ts#L168-L176)）

### packages/experimental/inspector/src/client/cdp/debugger.ts

Client 面的调试能力声明，被能力汇总函数调用。

- 返回 `undefined`，使 Client 握手不声明调试能力（[packages/experimental/inspector/src/client/cdp/debugger.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/debugger.ts#L9-L11)）

### packages/experimental/inspector/src/client/cdp/errors.ts

Client Runtime 内部使用的错误类型，被执行器与对象表抛出。

- 错误对象携带 `code` 字段，决定回给 Worker 的 Runtime 错误码（[packages/experimental/inspector/src/client/cdp/errors.ts:6-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/errors.ts#L6-L10)）

### packages/experimental/inspector/src/client/cdp/heap-profiler.ts

Client 面的堆分析能力声明，被能力汇总函数调用。

- 返回 `undefined`，使 Client 握手不声明堆分析能力（[packages/experimental/inspector/src/client/cdp/heap-profiler.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/heap-profiler.ts#L9-L11)）

### packages/experimental/inspector/src/client/cdp/index.ts

汇总 Client 源在握手时上报的能力集合，由页面身份对象在建代时调用。

- 依次收集 Runtime、Console、Sources、Debugger、Profiler、HeapProfiler 六项声明并滤掉返回 `undefined` 的项（[packages/experimental/inspector/src/client/cdp/index.ts:17-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/index.ts#L17-L26)）

### packages/experimental/inspector/src/client/cdp/objects.ts

Client 侧对象表与 RemoteObject 序列化实现，被 Runtime 执行器与属性枚举复用。

- 原型链遍历深度上限固定为 32（[packages/experimental/inspector/src/client/cdp/objects.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L18)）
- `beginAllocation` 为一次操作开一个符号并记录其新增句柄集合（[packages/experimental/inspector/src/client/cdp/objects.ts:48-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L48-L52)）
- `commitAllocation` 只删除记账、保留已注册句柄（[packages/experimental/inspector/src/client/cdp/objects.ts:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L58-L60)）
- 取值与取组在句柄未知时抛 `object-not-found`（[packages/experimental/inspector/src/client/cdp/objects.ts:67-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L67-L82)）
- 序列化优先走原始值路径，不占用句柄（[packages/experimental/inspector/src/client/cdp/objects.ts:96-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L96-L97)）
- `returnByValue` 时走 JSON 往返并返回内联值而非句柄（[packages/experimental/inspector/src/client/cdp/objects.ts:98-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L98-L105)）
- 对象路径产出类型、子类型、类名、描述文本，按需附预览，注册句柄并在可识别时附语义引用（[packages/experimental/inspector/src/client/cdp/objects.ts:107-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L107-L121)）
- `release` 对未知句柄幂等，并同步维护对象组索引（[packages/experimental/inspector/src/client/cdp/objects.ts:127-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L127-L135)）
- `releaseGroup` 一次释放某组全部句柄（[packages/experimental/inspector/src/client/cdp/objects.ts:141-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L141-L146)）
- `rollback` 只释放该次分配新增的句柄（[packages/experimental/inspector/src/client/cdp/objects.ts:152-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L152-L157)）
- `clear` 清空整个会话的对象、组与分配记账（[packages/experimental/inspector/src/client/cdp/objects.ts:160-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L160-L164)）
- 注册句柄时超过 `maxObjects` 抛 `result-too-large`，句柄按自增序号生成（[packages/experimental/inspector/src/client/cdp/objects.ts:166-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L166-L187)）
- 原始值序列化区分 undefined/null/string/boolean/bigint/number，`-0` 与非有限数走不可序列化文本（[packages/experimental/inspector/src/client/cdp/objects.ts:190-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L190-L205)）
- 按值返回时 JSON 往返失败或结果不在 JSON 值域内抛 `unsupported`（[packages/experimental/inspector/src/client/cdp/objects.ts:207-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L207-L218)）
- 预览最多列 5 个自有属性，超出置 `overflow`；访问器只记类型不取值；读键或读描述符失败时跳过（[packages/experimental/inspector/src/client/cdp/objects.ts:220-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L220-L267)）
- 子类型判定依次走 null、数组、ArrayBuffer 视图，再按原型表匹配（[packages/experimental/inspector/src/client/cdp/objects.ts:274-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L274-L283)）
- 类名沿原型链找首个 `constructor` 的函数名，受访问深度与环检测限制（[packages/experimental/inspector/src/client/cdp/objects.ts:285-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L285-L301)）
- 描述文本对函数用源码、数组用长度、错误优先用 stack、日期与正则用各自的 toString（[packages/experimental/inspector/src/client/cdp/objects.ts:303-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L303-L339)）
- 预览文本对字符串与对象描述截断到 100 字符（[packages/experimental/inspector/src/client/cdp/objects.ts:341-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L341-L349)）
- 原型读取与自有属性读取包在 try 中，失败分别退化为 `null`、`'Function'` 或 `undefined`（[packages/experimental/inspector/src/client/cdp/objects.ts:351-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L351-L389)）
- 固定的原型到子类型映射表覆盖 RegExp、Date、Map、Set、WeakMap、WeakSet、Error、Promise、ArrayBuffer、DataView（[packages/experimental/inspector/src/client/cdp/objects.ts:395-406](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/objects.ts#L395-L406)）

### packages/experimental/inspector/src/client/cdp/profiler.ts

Client 面的 CPU 分析能力声明，被能力汇总函数调用。

- 返回 `undefined`，使 Client 握手不声明 CPU 分析能力（[packages/experimental/inspector/src/client/cdp/profiler.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/profiler.ts#L9-L11)）

### packages/experimental/inspector/src/client/cdp/properties.ts

`Runtime.getProperties` 的 Client 实现，被 Runtime 会话在处理属性请求时调用。

- 非对象、非函数、非符号的值直接返回空属性列表（[packages/experimental/inspector/src/client/cdp/properties.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L28-L29)）
- 符号值改用 `Symbol.prototype` 作为枚举载体（[packages/experimental/inspector/src/client/cdp/properties.ts:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L30)）
- 新产生的子对象继承被查询句柄所在的对象组（[packages/experimental/inspector/src/client/cdp/properties.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L31)）
- 原型链出现重复节点或层数达到属性上限时抛 `result-too-large`（[packages/experimental/inspector/src/client/cdp/properties.ts:38-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L38-L41)）
- 同名键只取最先遇到的一层，`nonIndexedPropertiesOnly` 跳过数组索引键（[packages/experimental/inspector/src/client/cdp/properties.ts:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L45-L47)）
- `accessorPropertiesOnly` 跳过数据属性（[packages/experimental/inspector/src/client/cdp/properties.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L50)）
- 结果属性数达到上限时抛 `result-too-large`（[packages/experimental/inspector/src/client/cdp/properties.ts:51-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L51-L56)）
- `ownProperties` 为真时不向原型链上层继续（[packages/experimental/inspector/src/client/cdp/properties.ts:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L67-L69)）
- `accessorPropertiesOnly` 为真时不附带内部属性，否则附上 `[[Prototype]]`（[packages/experimental/inspector/src/client/cdp/properties.ts:72-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L72-L80)）
- 描述符转换不调用 getter，而是把 get/set 函数本身序列化为句柄（[packages/experimental/inspector/src/client/cdp/properties.ts:99-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L99-L112)）
- 读键、读描述符、读原型失败时统一抛 `internal-error` 并带上原因（[packages/experimental/inspector/src/client/cdp/properties.ts:115-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L115-L137)）
- 数组索引键按非负整数且往返字符串相等判定，上界为 4294967295（[packages/experimental/inspector/src/client/cdp/properties.ts:143-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/properties.ts#L143-L146)）

### packages/experimental/inspector/src/client/cdp/runtime.ts

浏览器实境的 Runtime 命令执行器，把 Worker 下发的求值、属性、调用、等待与释放命令落到页面 JavaScript 上。

- Runtime 错误消息长度上限固定为 2048（[packages/experimental/inspector/src/client/cdp/runtime.ts:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L28)）
- 声明 `client-runtime` 能力并带上合成执行上下文的 origin（[packages/experimental/inspector/src/client/cdp/runtime.ts:35-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L35-L37)）
- 每次执行开一个对象分配，执行后若信号已中止则按 `timeout` 失败（[packages/experimental/inspector/src/client/cdp/runtime.ts:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L74-L78)）
- 响应非 JSON 或超过响应字节上限时回滚分配并改回 `result-too-large`（[packages/experimental/inspector/src/client/cdp/runtime.ts:79-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L79-L86)）
- 延迟提交模式下重复的 requestId 被拒绝为 `invalid-request` 并回滚（[packages/experimental/inspector/src/client/cdp/runtime.ts:87-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L87-L95)）
- 非延迟模式立即提交分配（[packages/experimental/inspector/src/client/cdp/runtime.ts:96-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L96-L98)）
- 执行抛错时回滚分配并返回带错误码的失败响应（[packages/experimental/inspector/src/client/cdp/runtime.ts:100-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L100-L103)）
- 确认按会话归属校验后提交挂起的对象分配（[packages/experimental/inspector/src/client/cdp/runtime.ts:111-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L111-L116)）
- 取消按会话归属校验后回滚挂起的对象分配（[packages/experimental/inspector/src/client/cdp/runtime.ts:123-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L123-L128)）
- 关闭会话时清掉该会话的挂起分配并释放整张对象表（[packages/experimental/inspector/src/client/cdp/runtime.ts:134-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L134-L140)）
- Console 事件把参数序列化到 `console` 组，编码后加 4096 字节仍超过响应上限时整条丢弃并回滚（[packages/experimental/inspector/src/client/cdp/runtime.ts:160-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L160-L189)）
- 异常事件按同样的字节判据丢弃或提交（[packages/experimental/inspector/src/client/cdp/runtime.ts:199-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L199-L225)）
- `reset` 清空挂起分配并关闭全部会话（[packages/experimental/inspector/src/client/cdp/runtime.ts:228-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L228-L232)）
- 会话按需惰性创建并继承注入的对象与属性上限（[packages/experimental/inspector/src/client/cdp/runtime.ts:234-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L234-L245)）
- 会话按 op 分派求值、属性枚举、函数调用、Promise 等待、释放对象、释放对象组与词法名列表七种操作（[packages/experimental/inspector/src/client/cdp/runtime.ts:276-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L276-L297)）
- 全局词法名列表固定返回空数组（[packages/experimental/inspector/src/client/cdp/runtime.ts:293-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L293-L294)）
- 异常描述取栈首帧的行列与 URL，无栈时退回页面 `location.href` 与 0 行 0 列（[packages/experimental/inspector/src/client/cdp/runtime.ts:316-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L316-L333)）
- 求值直接调用 `globalThis.eval` 执行表达式，`awaitPromise` 时带超时与取消地等待（[packages/experimental/inspector/src/client/cdp/runtime.ts:340-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L340-L343)）
- 求值中的用户异常转成 exceptionDetails 结果，传输类错误继续上抛（[packages/experimental/inspector/src/client/cdp/runtime.ts:344-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L344-L347)）
- 函数调用的接收者缺省为 `globalThis`，否则取句柄对应对象并继承其对象组（[packages/experimental/inspector/src/client/cdp/runtime.ts:362-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L362-L364)）
- 函数声明经 `eval` 求值，结果不是函数时抛 TypeError，随后用 `Reflect.apply` 调用（[packages/experimental/inspector/src/client/cdp/runtime.ts:367-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L367-L371)）
- Promise 等待从句柄取值并继承其对象组（[packages/experimental/inspector/src/client/cdp/runtime.ts:379-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L379-L392)）
- 调用参数按 value/object/undefined/unserializable 四种形式还原（[packages/experimental/inspector/src/client/cdp/runtime.ts:395-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L395-L403)）
- 响应帧原样带回源 id、代号、会话 id 与请求 id（[packages/experimental/inspector/src/client/cdp/runtime.ts:432-445](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L432-L445)）
- 非本包错误码统一记为 `internal-error`，消息按上限截断（[packages/experimental/inspector/src/client/cdp/runtime.ts:447-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L447-L451)）
- 不可序列化参数只接受 NaN、±Infinity、-0 与 bigint 字面量，其余抛 `invalid-request`（[packages/experimental/inspector/src/client/cdp/runtime.ts:453-460](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L453-L460)）
- 可取消等待在信号已中止时立即失败，并用 race 同时挂超时与中止两条失败路径，finally 清定时器与监听（[packages/experimental/inspector/src/client/cdp/runtime.ts:469-497](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/runtime.ts#L469-L497)）

### packages/experimental/inspector/src/client/cdp/sources.ts

浏览器端脚本目录，向 Worker 提供本包 bundle 与 source map 的只读分块读取。

- 目录只登记一个固定脚本键，包 id 用于在启动图中定位本包条目（[packages/experimental/inspector/src/client/cdp/sources.ts:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L14-L15)）
- 是否声明 `client-sources` 能力取决于 bundle 是否被发现（[packages/experimental/inspector/src/client/cdp/sources.ts:22-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L22-L24)）
- 构造目录时重复的脚本键直接抛错（[packages/experimental/inspector/src/client/cdp/sources.ts:55-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L55-L62)）
- 栈帧 URL 归一化后与目录内资源 URL 比对，命中才返回脚本键（[packages/experimental/inspector/src/client/cdp/sources.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L69-L75)）
- `list-scripts` 并发描述全部资源（[packages/experimental/inspector/src/client/cdp/sources.ts:84-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L84-L89)）
- 未登记的脚本键抛 `script-not-found`（[packages/experimental/inspector/src/client/cdp/sources.ts:90-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L90-L91)）
- 内容不可用时返回 `available: false` 而非报错（[packages/experimental/inspector/src/client/cdp/sources.ts:92-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L92-L102)）
- 起始偏移超过内容长度抛 `invalid-request`（[packages/experimental/inspector/src/client/cdp/sources.ts:103-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L103-L105)）
- 单次读取按请求的 `maxBytes` 截取并以 base64 返回，同时给出下一偏移与是否读完（[packages/experimental/inspector/src/client/cdp/sources.ts:106-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L106-L116)）
- 脚本描述符给出行列范围、长度、哈希与 source map URL（[packages/experimental/inspector/src/client/cdp/sources.ts:119-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L119-L135)）
- 源文本惰性加载并缓存，加载失败抛 `load-failed`，超过内容上限抛 `result-too-large`（[packages/experimental/inspector/src/client/cdp/sources.ts:137-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L137-L147)）
- 源字节与 source map 字节各自缓存，source map 同样受内容上限约束（[packages/experimental/inspector/src/client/cdp/sources.ts:149-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L149-L167)）
- 目录发现从全局 `__DSH_BOOT__` 的 entries 中按包 id 找行，取 url 与 rev，并在其后缀补 `.map` 得到 source map 地址（[packages/experimental/inspector/src/client/cdp/sources.ts:174-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L174-L198)）
- 资源内容通过页面 `fetch` 拉取，非 2xx 抛出状态错误（[packages/experimental/inspector/src/client/cdp/sources.ts:200-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/sources.ts#L200-L204)）

### packages/experimental/inspector/src/client/cdp/stack.ts

浏览器栈文本解析，供 Console 观察器与异常描述生成统一的调用帧模型。

- Console 捕获用一个新建 Error 的栈并跳过最前面 3 个观察器自身的帧（[packages/experimental/inspector/src/client/cdp/stack.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/stack.ts#L14-L16)）
- 读取被抛值的 `stack` 时若访问器抛错则返回无栈（[packages/experimental/inspector/src/client/cdp/stack.ts:28-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/stack.ts#L28-L37)）
- 逐行解析后按 `skipFrames` 截去开头若干帧，结果为空则返回 `undefined`（[packages/experimental/inspector/src/client/cdp/stack.ts:51-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/stack.ts#L51-L58)）
- 单帧同时支持 V8 与 Firefox 两种文本格式，行列各减一，非安全整数的帧被丢弃，并尝试解析出本地脚本键（[packages/experimental/inspector/src/client/cdp/stack.ts:61-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/cdp/stack.ts#L61-L78)）

### packages/experimental/inspector/src/client/index.ts

浏览器面的包入口文件。

- 无运行期机制

### packages/experimental/inspector/src/client/inspection/cordis.ts

Client 面对共享 Cordis 快照发布函数的入口文件。

- 无运行期机制

### packages/experimental/inspector/src/client/inspection/network.ts

Client 面的网络观察 topic 列表，被传输层在发送 `source/open` 时展开。

- 导出空的网络 topic 列表，使 Client 的订阅只剩通配项（[packages/experimental/inspector/src/client/inspection/network.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/inspection/network.ts#L4)）

### packages/experimental/inspector/src/client/inspection/realm.ts

浏览器页面的源身份对象，决定重连与刷新后沿用哪个逻辑源 id 以及每代描述符的内容。

- 源 id 与锁名分别使用固定的 `sessionStorage` 键与锁前缀（[packages/experimental/inspector/src/client/inspection/realm.ts:8-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/inspection/realm.ts#L8-L9)）
- 无 Web Locks 时直接使用会话存储中的 id，不做占用仲裁（[packages/experimental/inspector/src/client/inspection/realm.ts:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/inspection/realm.ts#L32-L34)）
- 有 Web Locks 时循环尝试认领，锁被占用就换一个新生成的 id 重试，认领成功后写回存储（[packages/experimental/inspector/src/client/inspection/realm.ts:35-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/inspection/realm.ts#L35-L42)）
- 每次建代生成新的随机代号，并带上 `kind: 'client'`、标签、`performance.timeOrigin` 与按是否有源目录计算的能力集（[packages/experimental/inspector/src/client/inspection/realm.ts:50-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/inspection/realm.ts#L50-L59)）
- 关闭时释放持有的 Web Lock（[packages/experimental/inspector/src/client/inspection/realm.ts:61-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/inspection/realm.ts#L61-L65)）
- 读取会话存储中的 id：格式非法时改用新生成的 id，存储不可用时身份只存活于本页生命周期（[packages/experimental/inspector/src/client/inspection/realm.ts:68-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/inspection/realm.ts#L68-L84)）
- 锁以 `ifAvailable` 请求，拿不到即返回未认领，拿到则持有到显式释放（[packages/experimental/inspector/src/client/inspection/realm.ts:103-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/inspection/realm.ts#L103-L119)）
- 合成上下文的 origin 取 `location.origin`，缺失时为空串（[packages/experimental/inspector/src/client/inspection/realm.ts:121-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/inspection/realm.ts#L121-L126)）

### packages/experimental/inspector/src/client/plugin.ts

浏览器面的 Cordis 插件，读取 Host 注入的引导参数并挂载 Client 源与 `ctx.inspector` 服务。

- 以 `experimental-inspector` 作为插件名，与 Host 面共用（[packages/experimental/inspector/src/client/plugin.ts:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/plugin.ts#L36)）
- 声明空注入列表，不依赖其他 Client 服务（[packages/experimental/inspector/src/client/plugin.ts:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/plugin.ts#L39)）
- 全局 `__DSH_INSPECTOR__` 缺失时直接抛错，不做降级（[packages/experimental/inspector/src/client/plugin.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/plugin.ts#L46-L49)）
- 注入值经引导解析函数校验后才被使用（[packages/experimental/inspector/src/client/plugin.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/plugin.ts#L50)）
- 在 `ctx.effect` 内启动源、注册 Cordis 树发布（节点上限来自引导参数，字节上限为单帧上限减 4096），并提供 `inspector` 服务（[packages/experimental/inspector/src/client/plugin.ts:51-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/plugin.ts#L51-L59)）
- 初始化中途失败时先回滚已注册项，回滚再失败则记日志，原错误继续上抛（[packages/experimental/inspector/src/client/plugin.ts:60-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/plugin.ts#L60-L67)）
- 释放器按注册逆序执行、随后关闭源，失败项汇总为 `AggregateError` 抛出（[packages/experimental/inspector/src/client/plugin.ts:72-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/client/plugin.ts#L72-L90)）

### packages/experimental/inspector/src/host/bridge/controller.ts

Host 侧总控：解析配置、拉起 Worker 线程、组装端点与浏览器引导参数、安装 fetch 观察器并负责关停。

- 一组默认常量给出 body、日志、队列、超时、重连与对象数的缺省取值（[packages/experimental/inspector/src/host/bridge/controller.ts:13-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L13-L32)）
- 配置解析对每个数值字段做安全整数校验，`port` 与 `maxDisconnectedCordisTrees` 允许 0（[packages/experimental/inspector/src/host/bridge/controller.ts:136-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L136-L165)）
- 端口上限校验为 65535（[packages/experimental/inspector/src/host/bridge/controller.ts:166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L166)）
- 校验单帧字节上限必须能装下一个 base64 编码后的 body 分块加 4096 字节头部余量（[packages/experimental/inspector/src/host/bridge/controller.ts:167-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L167-L170)）
- 校验重连上界不得小于下界（[packages/experimental/inspector/src/host/bridge/controller.ts:171-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L171-L173)）
- 校验额外放行的浏览器 origin 必须是规范 origin 形式（[packages/experimental/inspector/src/host/bridge/controller.ts:174-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L174-L176)）
- 启动时生成随机 32 字节的 WebSocket 子协议令牌与随机 targetId（[packages/experimental/inspector/src/host/bridge/controller.ts:187-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L187-L188)）
- Worker 配置携带绑定地址、起始端口、令牌、放行 origin 与各项保留上限（[packages/experimental/inspector/src/host/bridge/controller.ts:189-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L189-L203)）
- 一条 `MessageChannel` 的一端随 workerData 转移给 Worker，另一端留给 Host 源（[packages/experimental/inspector/src/host/bridge/controller.ts:204-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L204-L217)）
- Host 源构造失败时关闭端口并终止 Worker 后再抛（[packages/experimental/inspector/src/host/bridge/controller.ts:218-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L218-L222)）
- 等待就绪失败时关闭源并终止 Worker 后再抛（[packages/experimental/inspector/src/host/bridge/controller.ts:224-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L224-L228)）
- 就绪后按实际绑定地址拼出 HTTP 地址、CDP WebSocket 地址与 `devtools://` 前端地址（默认打开 elements 面板并关闭 JS 补全）（[packages/experimental/inspector/src/host/bridge/controller.ts:229-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L229-L233)）
- 浏览器引导参数打包 `/ingest` 端点、子协议令牌、队列与帧上限、重连区间、查询超时与 Client 侧各项对象/属性/源字节/节点上限（[packages/experimental/inspector/src/host/bridge/controller.ts:234-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L234-L248)）
- `captureFetch` 为真时安装 fetch 观察器，安装失败关闭源并终止 Worker（[packages/experimental/inspector/src/host/bridge/controller.ts:250-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L250-L263)）
- 标记运行后注册意外退出回调：关闭源、停止 fetch 观察器并打印错误（[packages/experimental/inspector/src/host/bridge/controller.ts:265-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L265-L275)）
- `close()` 用缓存的 Promise 保证只关停一次（[packages/experimental/inspector/src/host/bridge/controller.ts:277-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L277-L285)）
- 构建产物运行时直接加载同目录 `worker.js`，源码运行时改用 data: URL 先注册 tsx 的 ESM 钩子再动态导入 Worker 入口（[packages/experimental/inspector/src/host/bridge/controller.ts:288-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L288-L308)）
- 源码模式的 Worker 环境变量只保留 Windows 临时目录与 `TSX_TSCONFIG_PATH`（[packages/experimental/inspector/src/host/bridge/controller.ts:310-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L310-L318)）
- 关停顺序固定为停 fetch 观察器、关源、停 Worker，任一失败都收集进 `AggregateError`（[packages/experimental/inspector/src/host/bridge/controller.ts:320-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/controller.ts#L320-L343)）

### packages/experimental/inspector/src/host/bridge/dispatcher.ts

Host MessagePort 收到 Worker 帧后的分发函数。

- 接受、确认、重快照、拒绝四类生命周期帧交给对应处理器（[packages/experimental/inspector/src/host/bridge/dispatcher.ts:28-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/dispatcher.ts#L28-L40)）
- 误投到 Host 载体的 Client Runtime 请求帧抛错拒绝（[packages/experimental/inspector/src/host/bridge/dispatcher.ts:41-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/dispatcher.ts#L41-L42)）
- Runtime 取消与响应确认帧被静默忽略（[packages/experimental/inspector/src/host/bridge/dispatcher.ts:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/dispatcher.ts#L43-L45)）
- Console 启停帧与 Sources 请求帧抛错拒绝（[packages/experimental/inspector/src/host/bridge/dispatcher.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/dispatcher.ts#L46-L50)）
- Runtime 与 Sources 的会话关闭帧被静默忽略（[packages/experimental/inspector/src/host/bridge/dispatcher.ts:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/dispatcher.ts#L51-L53)）
- 未列入的帧类型抛出带原帧 JSON 的错误（[packages/experimental/inspector/src/host/bridge/dispatcher.ts:54-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/dispatcher.ts#L54-L60)）

### packages/experimental/inspector/src/host/bridge/lifecycle.ts

Worker 线程的就绪等待、异常兜底与关停协调。

- 构造即挂上 `error` 与 `exit` 监听，记录首个错误与退出码（[packages/experimental/inspector/src/host/bridge/lifecycle.ts:23-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/lifecycle.ts#L23-L34)）
- 就绪等待解析控制消息：`ready` 决议、`failure` 拒绝、解析失败直接拒绝（[packages/experimental/inspector/src/host/bridge/lifecycle.ts:44-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/lifecycle.ts#L44-L55)）
- 就绪等待同时与超时、Worker 错误、Worker 提前退出三条失败路径竞速（[packages/experimental/inspector/src/host/bridge/lifecycle.ts:56-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/lifecycle.ts#L56-L68)）
- 无论成败都清除超时定时器并摘掉临时 message 监听（[packages/experimental/inspector/src/host/bridge/lifecycle.ts:69-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/lifecycle.ts#L69-L72)）
- 标记运行时安装意外退出回调，并立即补报此前已发生的退出（[packages/experimental/inspector/src/host/bridge/lifecycle.ts:79-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/lifecycle.ts#L79-L83)）
- `expectExit` 之后的退出不再被当作意外（[packages/experimental/inspector/src/host/bridge/lifecycle.ts:86-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/lifecycle.ts#L86-L88)）
- `terminate` 标记预期退出并在尚未退出时强制终止线程（[packages/experimental/inspector/src/host/bridge/lifecycle.ts:91-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/lifecycle.ts#L91-L94)）
- `stop` 先发 `shutdown` 控制消息，超过宽限期未退出则强制终止并抛错（[packages/experimental/inspector/src/host/bridge/lifecycle.ts:100-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/lifecycle.ts#L100-L116)）
- 意外退出只在已运行、非预期、未通知且已拿到退出码时上报一次（[packages/experimental/inspector/src/host/bridge/lifecycle.ts:118-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/lifecycle.ts#L118-L124)）

### packages/experimental/inspector/src/host/bridge/publisher.ts

Host 侧观察记录发布器，通过 MessagePort 向 Worker 逐批送出并按确认推进。

- 关闭后 `publish` 静默丢弃（[packages/experimental/inspector/src/host/bridge/publisher.ts:24-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/publisher.ts#L24-L28)）
- 关闭后 `setState` 抛错（[packages/experimental/inspector/src/host/bridge/publisher.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/publisher.ts#L30-L34)）
- `replace` 清空在途序号并发送整份状态替换（[packages/experimental/inspector/src/host/bridge/publisher.ts:37-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/publisher.ts#L37-L41)）
- 同时只允许一批在途，未收到确认前不再发新批（[packages/experimental/inspector/src/host/bridge/publisher.ts:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/publisher.ts#L44-L50)）
- 确认序号与在途批次不符时抛错（[packages/experimental/inspector/src/host/bridge/publisher.ts:56-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/publisher.ts#L56-L63)）
- `close` 先尝试送出最后一批，再置终态并丢弃剩余队列（[packages/experimental/inspector/src/host/bridge/publisher.ts:66-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/publisher.ts#L66-L71)）
- 冲刷用微任务合并，同时只排一个（[packages/experimental/inspector/src/host/bridge/publisher.ts:73-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/publisher.ts#L73-L80)）

### packages/experimental/inspector/src/host/bridge/rpc.ts

Host 侧非 CDP 查询通道，继承共享的查询关联实现。

- 把查询写入绑定为向 Worker 的 MessagePort 投递（[packages/experimental/inspector/src/host/bridge/rpc.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/rpc.ts#L17-L21)）

### packages/experimental/inspector/src/host/bridge/transport.ts

Host 侧源连接，持有 MessagePort、发布器与查询通道，由总控在启动时构造。

- 构造时建立 Host 源描述符、发布器与带查询超时和帧上限的查询通道（[packages/experimental/inspector/src/host/bridge/transport.ts:36-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/transport.ts#L36-L42)）
- 入站消息先交查询通道消费，未被消费才解析为源帧，解析或处理抛错即关闭整个源（[packages/experimental/inspector/src/host/bridge/transport.ts:43-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/transport.ts#L43-L50)）
- 端口关闭时断开查询通道（[packages/experimental/inspector/src/host/bridge/transport.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/transport.ts#L51)）
- 构造末尾启动端口、发送 `source/open` 并立即推送一份完整状态（[packages/experimental/inspector/src/host/bridge/transport.ts:52-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/transport.ts#L52-L60)）
- 关闭时先冲刷发布器与终止查询，再发 `source/close` 并关闭端口（[packages/experimental/inspector/src/host/bridge/transport.ts:64-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/transport.ts#L64-L77)）
- 除 `source/rejected` 外，源 id 或代号不匹配的帧被丢弃（[packages/experimental/inspector/src/host/bridge/transport.ts:79-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/transport.ts#L79-L81)）
- 接受帧连通查询写入，确认帧推进发布器，重快照帧重发状态，拒绝帧断开查询并带上原因（[packages/experimental/inspector/src/host/bridge/transport.ts:82-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/bridge/transport.ts#L82-L87)）

### packages/experimental/inspector/src/host/cdp/console.ts

Host 面的 Console 能力声明与误投帧拒绝。

- 返回 `undefined`，使 Host 源不声明主线程 Console 桥能力（[packages/experimental/inspector/src/host/cdp/console.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/console.ts#L9-L11)）
- 对误投到 Host 源的 Console 控制帧抛错并带上帧类型（[packages/experimental/inspector/src/host/cdp/console.ts:18-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/console.ts#L18-L20)）

### packages/experimental/inspector/src/host/cdp/debugger.ts

Host 面的调试能力声明。

- 返回 `undefined`，使 Host 源不声明主线程 Debugger 桥能力（[packages/experimental/inspector/src/host/cdp/debugger.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/debugger.ts#L9-L11)）

### packages/experimental/inspector/src/host/cdp/errors.ts

Host 侧 CDP 桥的专用错误类型，被同目录的 objects.ts、runtime.ts 抛出。

- `HostCdpBridgeUnavailableError` 构造时把误路由的操作名与固定原因串成错误消息（[packages/experimental/inspector/src/host/cdp/errors.ts:6-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/errors.ts#L6-L10)）

### packages/experimental/inspector/src/host/cdp/heap-profiler.ts

Host 侧堆分析能力声明，被 host/cdp/index.ts 汇总。

- `heapProfilerBridgeCapability()` 返回 `undefined`，使 HeapProfiler 不出现在 Host 能力表里（[packages/experimental/inspector/src/host/cdp/heap-profiler.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/heap-profiler.ts#L9-L11)）

### packages/experimental/inspector/src/host/cdp/index.ts

汇总 Host 源侧 CDP 能力声明，被 host/inspection/realm.ts 用于构造源描述符。

- 模块加载时以固定实参调用六个能力构造函数，并过滤掉返回 `undefined` 的项，得到 Host 能力常量（[packages/experimental/inspector/src/host/cdp/index.ts:11-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/index.ts#L11-L18)）
- `bridgeCapabilities()` 忽略传入的 origin 与 hasSources，恒返回该常量（[packages/experimental/inspector/src/host/cdp/index.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/index.ts#L26-L28)）

### packages/experimental/inspector/src/host/cdp/objects.ts

Host 侧对象操作的拒绝入口，被 properties.ts 与 runtime.ts 调用。

- `rejectObjectBridgeOperation()` 抛出 `HostCdpBridgeUnavailableError` 且永不返回（[packages/experimental/inspector/src/host/cdp/objects.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/objects.ts#L10-L12)）

### packages/experimental/inspector/src/host/cdp/profiler.ts

Host 侧 CPU 分析能力声明，被 host/cdp/index.ts 汇总。

- `profilerBridgeCapability()` 返回 `undefined`，使 Profiler 不出现在 Host 能力表里（[packages/experimental/inspector/src/host/cdp/profiler.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/profiler.ts#L9-L11)）

### packages/experimental/inspector/src/host/cdp/properties.ts

Host 侧属性枚举请求的拒绝入口，被 runtime.ts 调用。

- `rejectPropertyBridgeOperation()` 以固定操作名 `client-runtime/get-properties` 转交对象拒绝（[packages/experimental/inspector/src/host/cdp/properties.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/properties.ts#L9-L11)）

### packages/experimental/inspector/src/host/cdp/runtime.ts

Host 侧 Runtime 能力声明与误路由命令的拒绝分派。

- `runtimeBridgeCapability()` 恒返回 `undefined`，Host 不声明 Runtime 桥能力（[packages/experimental/inspector/src/host/cdp/runtime.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/runtime.ts#L14-L16)）
- `get-properties` 命令转交属性拒绝路径（[packages/experimental/inspector/src/host/cdp/runtime.ts:25-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/runtime.ts#L25-L26)）
- `release-object` 与 `release-object-group` 把 op 拼进操作名后转交对象拒绝（[packages/experimental/inspector/src/host/cdp/runtime.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/runtime.ts#L27-L29)）
- `evaluate`、`call-function`、`await-promise`、`global-lexical-scope-names` 直接抛出桥不可用错误（[packages/experimental/inspector/src/host/cdp/runtime.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/runtime.ts#L30-L34)）
- 未覆盖的 op 落到 `assertNever`，把整条命令 JSON 化后抛错（[packages/experimental/inspector/src/host/cdp/runtime.ts:35-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/runtime.ts#L35-L42)）

### packages/experimental/inspector/src/host/cdp/sources.ts

Host 侧 Sources 能力声明与请求拒绝入口。

- `sourcesBridgeCapability()` 恒返回 `undefined`，Sources 不出现在 Host 能力表里（[packages/experimental/inspector/src/host/cdp/sources.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/sources.ts#L10-L12)）
- `rejectSourcesBridgeCommand()` 抛出固定文本的错误（[packages/experimental/inspector/src/host/cdp/sources.ts:18-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/sources.ts#L18-L20)）

### packages/experimental/inspector/src/host/cdp/stack.ts

Host 桥拒绝理由的常量来源，被 errors.ts 引用。

- 导出常量 `HOST_CDP_BRIDGE_REASON`，其字符串被拼进 Host 桥拒绝时抛出的错误消息（[packages/experimental/inspector/src/host/cdp/stack.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/cdp/stack.ts#L4)）

### packages/experimental/inspector/src/host/index.ts

Host 面的入口文件，转发 plugin.ts 的导出。

- 无运行期机制

### packages/experimental/inspector/src/host/inspection/cordis.ts

Host 面对共享 Cordis 快照发布器的入口，被 host/plugin.ts 引用。

- 无运行期机制

### packages/experimental/inspector/src/host/inspection/network.ts

包裹 `globalThis.fetch` 并把请求/响应生命周期与正文分块发布到 Host 观测源，由 Inspector Host 侧启用。

- `NETWORK_TOPICS` 由 `FETCH_TOPICS` 定义为 Host 网络适配器可发布的主题集合（[packages/experimental/inspector/src/host/inspection/network.ts:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L8)）
- 安装前读取 `globalThis.fetch` 的属性描述符；不是函数、或是访问器属性时抛错拒绝安装（[packages/experimental/inspector/src/host/inspection/network.ts:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L39-L44)）
- 建立 `AbortController`、未结算捕获集合与自增请求序号（[packages/experimental/inspector/src/host/inspection/network.ts:46-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L46-L48)）
- `track()` 把每个正文捕获 Promise 登记进 pending，成功或失败后都移除（[packages/experimental/inspector/src/host/inspection/network.ts:50-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L50-L56)）
- 包装后的 fetch 先把入参归一为 `Request`、分配 `fetch-<n>` 请求 id，并发布 `fetch/start`（url、method、headers、hasBody、wallTimeMs）（[packages/experimental/inspector/src/host/inspection/network.ts:58-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L58-L68)）
- 请求克隆失败时立即发布带 `captureError` 的 `fetch/request-body-end`（[packages/experimental/inspector/src/host/inspection/network.ts:70-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L70-L80)）
- 克隆成功时后台读取请求正文，逐块发布 `fetch/request-body-chunk`，读完再发布 `fetch/request-body-end`（[packages/experimental/inspector/src/host/inspection/network.ts:81-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L81-L91)）
- 以归一后的 `Request` 调用原始 fetch；抛错时发布 `fetch/error`（含由 `signal.aborted` 或 AbortError 判定的 canceled）后把错误继续抛给调用方（[packages/experimental/inspector/src/host/inspection/network.ts:93-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L93-L103)）
- 拿到响应后发布 `fetch/response`，其中 mimeType 由 content-type 首段裁剪并小写化（[packages/experimental/inspector/src/host/inspection/network.ts:105-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L105-L112)）
- 克隆响应后台读取正文，逐块发布 `fetch/response-body-chunk`，结束时发布带 `capturedBytes` 与截断标志的 `fetch/end`（[packages/experimental/inspector/src/host/inspection/network.ts:114-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L114-L129)）
- 响应克隆失败时发布带 `responseCaptureError` 的 `fetch/end`（[packages/experimental/inspector/src/host/inspection/network.ts:130-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L130-L137)）
- 不等待正文捕获完成即把原响应返回给调用方（[packages/experimental/inspector/src/host/inspection/network.ts:138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L138)）
- 把原函数的 `name` 与 `length` 复制到包装体，并按原描述符形态改写 `globalThis.fetch`（[packages/experimental/inspector/src/host/inspection/network.ts:141-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L141-L145)）
- `stop()` 只结算一次：仅当当前 fetch 仍是包装体时还原（原先没有描述符则删除该属性），随后 abort 并等待所有 pending 捕获结算（[packages/experimental/inspector/src/host/inspection/network.ts:147-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L147-L161)）
- `captureBody` 对空 body 直接返回零字节结果，否则取 reader 并把 abort 信号转成 `reader.cancel`（[packages/experimental/inspector/src/host/inspection/network.ts:172-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L172-L175)）
- 按剩余额度与 `chunkLimit` 切分每个读到的块，达到字节上限时置 `truncated`、取消读取并提前返回（[packages/experimental/inspector/src/host/inspection/network.ts:179-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L179-L195)）
- 每个切片以 base64 文本交给发布回调（[packages/experimental/inspector/src/host/inspection/network.ts:192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L192)）
- 捕获过程中被 abort 时取消读取并带固定 `captureError` 文本返回（[packages/experimental/inspector/src/host/inspection/network.ts:197-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L197-L200)）
- 读取抛错时返回 `truncated: true` 与渲染后的错误文本（[packages/experimental/inspector/src/host/inspection/network.ts:202-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L202-L203)）
- finally 中移除 abort 监听并释放 reader 锁（[packages/experimental/inspector/src/host/inspection/network.ts:204-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L204-L207)）
- `compactOutcome` 仅在存在错误时才在负载中带上 `captureError` 字段（[packages/experimental/inspector/src/host/inspection/network.ts:210-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L210-L217)）
- `renderError` 把 Error 渲染为 `name: message`，其余走 `String`，再失败返回固定文本（[packages/experimental/inspector/src/host/inspection/network.ts:227-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/network.ts#L227-L234)）

### packages/experimental/inspector/src/host/inspection/realm.ts

构造一代 Host 观测源的描述符，供 Host 与 Worker 之间的 MessagePort 握手使用。

- 每次调用生成新的 `host-<uuid>` 源 id 与另一枚 uuid 作为连接代次（[packages/experimental/inspector/src/host/inspection/realm.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/realm.ts#L14-L16)）
- 描述符固定 `kind: 'host'`，带入调用方给的 label 与 `performance.timeOrigin`（[packages/experimental/inspector/src/host/inspection/realm.ts:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/realm.ts#L17-L19)）
- 能力字段取 `bridgeCapabilities('', false)` 的结果（[packages/experimental/inspector/src/host/inspection/realm.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/inspection/realm.ts#L20)）

### packages/experimental/inspector/src/host/plugin.ts

Host 侧 Cordis 插件实现：启动 Inspector Worker、提供 `ctx.inspector` 服务、注入 Client 引导值，并负责回滚与拆卸。

- `apply` 在 `ctx.effect` 内解析配置并启动 Worker，取得句柄后才继续注册（[packages/experimental/inspector/src/host/plugin.ts:38-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/plugin.ts#L38-L41)）
- 注册 Cordis 树发布，节点上限取自配置、字节上限为 `maxSourceFrameBytes - 4096`（[packages/experimental/inspector/src/host/plugin.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/plugin.ts#L44-L47)）
- 通过 `ctx.provide('inspector', ...)` 把基于该源的服务挂进上下文（[packages/experimental/inspector/src/host/plugin.ts:48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/plugin.ts#L48)）
- 监听 `webserver/index-inject`，向注入表追加全局变量 `__DSH_INSPECTOR__`，值为 Worker 的客户端端点（[packages/experimental/inspector/src/host/plugin.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/plugin.ts#L49-L51)）
- 直接用 `console.log` 打印 DevTools 前端 URL（[packages/experimental/inspector/src/host/plugin.ts:52-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/plugin.ts#L52-L53)）
- 任一注册步骤抛错时回滚已注册项并关闭句柄，回滚本身失败只记 error 日志，原错误继续向外抛（[packages/experimental/inspector/src/host/plugin.ts:54-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/plugin.ts#L54-L59)）
- effect 返回的拆卸函数执行同一套 dispose 流程（[packages/experimental/inspector/src/host/plugin.ts:60-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/plugin.ts#L60-L61)）
- `disposeInspector` 逆序调用每个 disposer 并关闭句柄，收集全部失败后以 `AggregateError` 抛出（[packages/experimental/inspector/src/host/plugin.ts:64-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/host/plugin.ts#L64-L82)）

### packages/experimental/inspector/src/index.ts

包的标准入口：声明插件名与注入、定义配置校验模式，并把 apply 转交 Host 实现。

- 通过声明合并把 `inspector` 服务挂到 `Context` 类型上（[packages/experimental/inspector/src/index.ts:52-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/index.ts#L52-L57)）
- 导出插件名 `experimental-inspector`（[packages/experimental/inspector/src/index.ts:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/index.ts#L60)）
- 声明 `inject = ['webServer']`，加载顺序依赖该服务（[packages/experimental/inspector/src/index.ts:63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/index.ts#L63)）
- 模块加载时求值 `resolveInspectorOptions()`，作为各字段默认值的来源（[packages/experimental/inspector/src/index.ts:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/index.ts#L71)）
- 配置模式把 host 固定为 `127.0.0.1`、port 默认 9230 且不超过 65535、clientOrigins 默认空数组、captureFetch 默认开启（[packages/experimental/inspector/src/index.ts:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/index.ts#L74-L78)）
- 其余字节上限、条数上限与超时字段以库默认值兜底并要求至少为 1，仅 `maxDisconnectedCordisTrees` 允许 0（[packages/experimental/inspector/src/index.ts:79-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/index.ts#L79-L98)）
- `apply` 把校验后的配置转交 Host 实现（[packages/experimental/inspector/src/index.ts:106-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/index.ts#L106-L108)）

### packages/experimental/inspector/src/invariant.ts

本包的不变式伴生插件，向 `invariants` 服务登记包名。

- 声明伴生插件名与对 `invariants` 服务的注入（[packages/experimental/inspector/src/invariant.ts:9-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/invariant.ts#L9-L12)）
- 安装器为空函数，不注册任何运行期检查（[packages/experimental/inspector/src/invariant.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/invariant.ts#L18)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并把返回的 disposer 交回加载器（[packages/experimental/inspector/src/invariant.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/invariant.ts#L21-L22)）

### packages/experimental/inspector/src/shared/bridge/buffer.ts

与传输方式无关的观测缓冲区：保存保留态、排队待发观测、分配源内序号并按上限切帧，Host 与 Client 两侧源共用。

- 固定的每帧开销常量 4096 字节参与所有帧预算计算（[packages/experimental/inspector/src/shared/bridge/buffer.ts:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L8)）
- 实例内维护待发队列、按主题保留的状态表、已排队字节数、下一序号与期望序号（[packages/experimental/inspector/src/shared/bridge/buffer.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L30-L34)）
- `hasPending` 以队列非空表示还有观测等待传输（[packages/experimental/inspector/src/shared/bridge/buffer.ts:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L39-L41)）
- `publish()` 校验后把一条观测入队（[packages/experimental/inspector/src/shared/bridge/buffer.ts:50-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L50-L52)）
- `setState()` 先替换该主题的保留态，若保留态总体积超过帧上限则回滚为旧值（原先不存在则删除）并抛错，否则再入队同一条记录（[packages/experimental/inspector/src/shared/bridge/buffer.ts:60-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L60-L70)）
- `replacement()` 以队首序号（队空时用下一序号）作为 `nextSequence` 并同步期望序号，把全部保留态装入替换帧（[packages/experimental/inspector/src/shared/bridge/buffer.ts:78-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L78-L89)）
- `takeBatch()` 只取序号连续的前缀，受每帧最大条数限制，且除首条外累计字节不得超过帧上限（[packages/experimental/inspector/src/shared/bridge/buffer.ts:97-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L97-L109)）
- 追加帧携带 `droppedBefore = firstSequence - expectedSequence`，出帧后把期望序号推进到批尾（[packages/experimental/inspector/src/shared/bridge/buffer.ts:110-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L110-L122)）
- `discardPending()` 清空尚未进入传输帧的观测与其字节计数（[packages/experimental/inspector/src/shared/bridge/buffer.ts:126-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L126-L129)）
- 记录构造时要求 topic 长度在 1 到 128 之间（[packages/experimental/inspector/src/shared/bridge/buffer.ts:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L132-L134)）
- 未在声明主题表中（且未声明通配 `*`）的 topic 被拒绝（[packages/experimental/inspector/src/shared/bridge/buffer.ts:135-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L135-L137)）
- 载荷必须是无损 JSON 数据，`monotonicMs` 必须有限（[packages/experimental/inspector/src/shared/bridge/buffer.ts:138-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L138-L139)）
- 入队先分配序号，单条记录加固定开销超过帧上限时被丢弃（序号已被消耗，从而在下游表现为丢失）（[packages/experimental/inspector/src/shared/bridge/buffer.ts:143-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L143-L149)）
- 队列超过条数或字节上限时循环丢弃最旧记录（[packages/experimental/inspector/src/shared/bridge/buffer.ts:151-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L151-L154)）
- `stateFits()` 用全部保留态的 JSON 字节数加固定开销与帧上限比较（[packages/experimental/inspector/src/shared/bridge/buffer.ts:157-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/buffer.ts#L157-L160)）

### packages/experimental/inspector/src/shared/bridge/codec.ts

桥接层对 JSON 与通用线上校验工具的转发入口。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/control-codec.ts

Host、Worker 与注入到浏览器的引导值三类生命周期消息的精确解码器。

- Worker 配置按精确键集解码，多余或缺失键都被拒（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:18-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L18-L22)）
- Worker 监听地址必须是 `127.0.0.1`（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L23)）
- `targetId` 与 `clientToken` 必须是非空字符串（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L24-L29)）
- `clientOrigins` 必须是字符串数组（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L30-L32)）
- `startPort` 允许 0 并且不得超过 65535（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L33-L34)）
- 其余上限与超时字段按正安全整数解码，仅 `maxDisconnectedCordisTrees` 允许 0（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:35-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L35-L49)）
- Host 到 Worker 的控制消息只接受 `shutdown`（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L57-L61)）
- Worker 到 Host 的事件按 `type` 分派，`ready` 校验键集与 host/targetId 类型且允许端口 0（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:70-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L70-L81)）
- `failure` 要求字符串 message，`stopped` 只允许 type 一个键，其余 type 抛错（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:82-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L82-L91)）
- 浏览器引导值按精确键集解码（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:100-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L100-L104)）
- endpoint 必须能构造成绝对 URL（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:108-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L108-L113)）
- endpoint 协议必须是 `ws:` 且主机名必须是 `127.0.0.1`（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:114-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L114-L116)）
- 子协议名长度必须在 1 到 256 之间（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:117-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L117-L119)）
- 引导值里的队列上限、重连间隔、超时与对象/属性上限逐项按正安全整数解码（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:120-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L120-L134)）
- `reconnectMaxMs` 必须不小于 `reconnectBaseMs`（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:135-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L135-L137)）
- `natural()` 按 zero 参数在 0 与 1 之间切换下界并要求安全整数（[packages/experimental/inspector/src/shared/bridge/control-codec.ts:148-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/control-codec.ts#L148-L153)）

### packages/experimental/inspector/src/shared/bridge/ids.ts

桥接协议中各类不透明标识的品牌类型别名与 `inspectorId` 的转发出口。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/messages/control.ts

Host 与 Worker 生命周期消息以及浏览器引导值的类型声明。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/messages/cordis.ts

Cordis 运行时树快照在桥上使用的主题名。

- 导出常量 `CORDIS_TREE_TOPIC`，决定树快照发布所用的观测主题（[packages/experimental/inspector/src/shared/bridge/messages/cordis.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/cordis.ts#L4)）

### packages/experimental/inspector/src/shared/bridge/messages/network.ts

fetch 捕获所用观测主题名的集合，被 Host 网络适配器引用。

- `FETCH_TOPICS` 固定列出七个 fetch 生命周期主题，构成源可声明与发布的主题全集（[packages/experimental/inspector/src/shared/bridge/messages/network.ts:4-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/network.ts#L4-L12)）

### packages/experimental/inspector/src/shared/bridge/messages/observation.ts

源与 Worker 之间全部帧的类型定义与两个方向的边界解码器，MessagePort 与 WebSocket 两种载体共用。

- Worker 到源的帧必须是无损 JSON 对象、版本号匹配且 `t` 为字符串（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:168-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L168-L174)）
- `source/rejected` 校验键集，`code` 必须是三个枚举值之一且 message 必须是字符串（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:175-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L175-L182)）
- 按 `t` 把 Client Runtime、Client Sources、Client Console 控制帧分派给各自解码器（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:183-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L183-L193)）
- `source/accepted` 校验精确键集后重建（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:199-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L199-L202)）
- `source/append-acknowledged` 要求 `nextSequence` 为非负安全整数（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:203-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L203-L210)）
- `source/resnapshot` 要求字符串 reason 与非负 `expectedSequence`，否则落到未知帧抛错（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:211-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L211-L221)）
- 源到 Worker 的帧先要求无损 JSON 对象，再要求协议版本完全一致（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:230-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L230-L236)）
- 按 `t` 分派 open/replace/append/close 与三类扩展响应帧，未知标签抛错（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:237-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L237-L260)）
- 握手帧要求精确键集且 source 为对象、topics 为数组（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:264-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L264-L269)）
- 源 kind 必须是 `host` 或 `client`（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:270-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L270-L271)）
- 源 label 长度必须在 1 到 256 之间，`timeOriginMs` 必须是有限数（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:272-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L272-L277)）
- capabilities 必须是数组并逐项解码（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:278-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L278-L281)）
- 同一类能力重复声明时抛错（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:282-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L282-L288)）
- 非 client 源声明任何能力都被拒绝（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:289-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L289-L291)）
- 声明的每个 topic 长度必须在 1 到 128 之间（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:292-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L292-L297)）
- 能力按 type 分派到三个解码器，未知能力类型抛错（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:313-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L313-L323)）
- 记录帧按替换或追加选用不同的精确键集（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:330-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L330-L336)）
- records 必须是数组且条数不得超过调用方给出的上限（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:337-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L337-L339)）
- 替换帧重建 `nextSequence`，追加帧重建 `firstSequence` 与 `droppedBefore`（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:347-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L347-L359)）
- 单条观测记录要求有限 `monotonicMs`、长度 1 到 128 的 topic、无损 JSON 载荷与精确键集（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:362-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L362-L373)）
- sourceId 与 generation 必须是字符串并被重新打上品牌（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:376-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L376-L384)）
- 帧中的序号字段一律要求非负安全整数（[packages/experimental/inspector/src/shared/bridge/messages/observation.ts:386-390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/observation.ts#L386-L390)）

### packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts

非 CDP 查询请求与响应帧的精确解码器与归属判定。

- `isInspectorQueryRequestEnvelope` 依据 `t === 'query/request'` 判定载体值是否归本协议（[packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts#L27-L29)）
- `isInspectorQueryResponseEnvelope` 依据 `t === 'query/response'` 判定归属（[packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts#L36-L38)）
- 请求帧按精确键集解码，版本与标签不符即抛错，并重建三个品牌 id 与查询体（[packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts:45-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts#L45-L58)）
- 另有一条只取相关字段的解码路径，用于在请求体非法时仍能回信而不让调用方超时（[packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts:65-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts#L65-L74)）
- 响应帧按精确键集解码并解出 outcome（[packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts:81-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts#L81-L94)）
- 查询体只接受 `op = 'cordis-tree/get'`，其余抛错（[packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts:96-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts#L96-L102)）
- 查询结果按 op 分派，`cordis-tree/get` 的 tree 字段交给树模型解码器（[packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts:104-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts#L104-L115)）
- outcome 按布尔 `ok` 分成结果分支与错误分支，错误码必须落在四个允许值内（[packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts:117-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/query/codec.ts#L117-L138)）

### packages/experimental/inspector/src/shared/bridge/messages/query/commands.ts

非 CDP 查询命令、结果与错误的闭合类型定义，以及请求方接口。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/messages/query/frames.ts

查询请求与响应帧的版本化类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/messages/query/index.ts

查询协议子目录的导出汇总。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts

Client Runtime 命令进入客户端领域前的精确线上解码器。

- 命令必须是对象且带字符串 `op`（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L13-L15)）
- `evaluate` 按精确键集校验，`expression` 必须是字符串，其余可选布尔、字符串与非负数字字段仅在存在时重建（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:17-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L17-L39)）
- `get-properties` 校验键集并把 handle 转成品牌 id（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:40-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L40-L51)）
- `await-promise` 校验键集并把 promise 转成品牌 id（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:54-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L54-L61)）
- `release-object` 只允许 op 与 handle 两个键（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:62-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L62-L67)）
- `release-object-group` 要求 `objectGroup` 是字符串（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:68-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L68-L71)）
- `global-lexical-scope-names` 只允许 op 一个键，未知 op 抛错（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:72-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L72-L77)）
- `call-function` 校验键集，`functionDeclaration` 必须是字符串，`arguments` 存在时必须是数组并逐项解码（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:81-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L81-L92)）
- receiver 与 arguments 仅在原值存在时才出现在重建结果中（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:96-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L96-L99)）
- 调用实参按 kind 分为 value（必须是 JSON）、unserializable（必须是字符串）、object（取 handle）与 undefined，未知 kind 抛错（[packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts:109-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/command-codec.ts#L109-L134)）

### packages/experimental/inspector/src/shared/bridge/messages/runtime/commands.ts

Client Runtime 命令、结果与错误码的闭合类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts

Client Console 能力、会话开关帧与事件帧的类型定义与解码器。

- Console 能力只接受 `type === 'client-console'` 的单键对象（[packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts:52-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts#L52-L56)）
- 开关帧校验精确键集与版本，标签必须是 enable 或 disable，并重建源、代次与会话三个品牌 id（[packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts:63-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts#L63-L78)）
- 事件帧校验键集与版本、标签后重建各 id 并解码事件体（[packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts:85-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts#L85-L98)）
- 事件体只接受 `console-api` 与 `exception` 两种 type（[packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts:100-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts#L100-L103)）
- console-api 事件要求 type 在允许集合内、arguments 为数组、timestamp 有限，逐个解出 RemoteObject，并只在存在时带上 contextId 与调用栈（[packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts:104-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts#L104-L123)）
- exception 事件校验键集与有限 timestamp，并把 details 交给异常详情解码器（[packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts:124-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts#L124-L136)）
- contextId 必须是安全整数（[packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts:139-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts#L139-L142)）
- `CONSOLE_TYPES` 固定枚举被接受的 Console 事件类型集合（[packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts:144-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/console-frames.ts#L144-L147)）

### packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts

Worker 与 Client 之间 Runtime 操作各类帧的类型定义与解码器。

- Runtime 能力要求 `type === 'client-runtime'`，origin 必须是长度不超过 2048 的字符串（[packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts:80-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts#L80-L86)）
- 请求帧校验精确键集、版本与标签，并重建四个品牌 id 与命令体（[packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts:93-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts#L93-L107)）
- 取消帧校验键集、版本与标签后重建四个品牌 id（[packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts:114-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts#L114-L127)）
- 响应确认帧同样逐字校验自己的键集与标签（[packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts:137-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts#L137-L152)）
- 响应帧校验键集与标签后重建各 id 并解出 outcome（[packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts:160-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts#L160-L174)）
- 会话关闭帧校验键集与标签后重建源、代次与会话 id（[packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts:181-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts#L181-L193)）
- outcome 按布尔 `ok` 分成结果与错误两支，错误码必须落在六个允许值内（[packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts:195-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/frames.ts#L195-L213)）

### packages/experimental/inspector/src/shared/bridge/messages/runtime/index.ts

Client Runtime 线上协议子目录的导出汇总。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts

Client Runtime 结果与 RemoteObject 数据的精确线上解码器与表示形式校验。

- 结果必须是对象且带字符串 `op`（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L30-L32)）
- `evaluate`、`call-function`、`await-promise` 三种结果共用键集并解出 completion（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:34-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L34-L38)）
- `get-properties` 结果要求 properties 是数组，internalProperties 若存在也必须是数组，异常详情按需解码（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:39-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L39-L54)）
- 两个释放操作的结果只允许 op 一个键（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L55-L58)）
- `global-lexical-scope-names` 结果的 names 必须是字符串数组，未知 op 抛错（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:59-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L59-L66)）
- completion 按精确键集解出结果对象与可选异常详情（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:70-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L70-L78)）
- RemoteObject 解码后必须通过表示形式校验才返回（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:85-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L85-L102)）
- 对象描述符要求 type 落在允许集合内、subtype 若存在也在允许集合内、value 必须是 JSON（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:104-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L104-L126)）
- 对象预览要求 type/subtype 合法、overflow 为布尔、properties 为数组并逐项解码（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:128-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L128-L143)）
- 属性预览要求 name 为字符串、type 为 accessor 或允许的对象类型（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:145-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L145-L159)）
- 属性描述符要求 name/configurable/enumerable 齐备，且拒绝同时带数据字段与访问器字段（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:161-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L161-L185)）
- 内部属性描述符要求字符串 name，value 按需解码（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:187-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L187-L194)）
- 异常详情要求字符串 text 与非负安全整数的行列号（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:201-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L201-L220)）
- 调用栈要求 callFrames 为数组，并对 parent 递归解码（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:227-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L227-L235)）
- 单个调用帧要求字符串 functionName 与 url、安全整数行列号，scriptKey 存在时转成品牌 id（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:237-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L237-L252)）
- 两个固定集合限定被接受的 RemoteObject 类型与子类型（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:254-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L254-L261)）
- 带语义引用的对象必须同时带保留句柄（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:263-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L263-L266)）
- 只有 type 为 object 的值才允许带 subtype 或 preview（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:267-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L267-L273)）
- undefined、string、boolean 三类各自要求固定的值/不可序列化值/后端对象存在组合（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:277-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L277-L286)）
- number 必须在有限数值与四种特殊不可序列化文本之间恰好取其一，且不得带后端对象（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:287-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L287-L297)）
- bigint 的不可序列化文本必须匹配整数加 `n` 的正则，且不得带 value 或后端对象（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:298-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L298-L302)）
- symbol 与 function 必须只有后端对象、没有值（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:303-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L303-L306)）
- null 子类型要求 value 恰为 null 且没有后端对象与不可序列化值（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:307-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L307-L313)）
- 其余 object 必须在内联值与后端对象之间恰好有一个，且不得带不可序列化值（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:314-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L314-L316)）
- `requireRepresentations` 统一比对三种表示的存在性并在不符时按类型名抛错（[packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts:320-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/runtime/value-codec.ts#L320-L333)）

### packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts

Client 源码目录协议的命令与结果解码器，被同目录 frames.ts 在解析请求／响应帧时调用。

- `parseClientSourceCommand` 要求值是普通对象且带字符串 `op`，否则抛错（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:19-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L19-L21)）
- `list-scripts` 命令要求键集恰为 `['op']`，返回重建的命令对象（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:22-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L22-L25)）
- 除两个已知 `op` 外的命令一律抛错（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L26-L28)）
- `get-content-chunk` 命令校验键集，并把 `scriptKey` 打标、`content` 限定枚举、`offset` 要求非负整数、`maxBytes` 要求正整数（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:29-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L29-L36)）
- `parseClientSourceResult` 同样要求普通对象与字符串 `op`（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L45-L47)）
- `list-scripts` 结果要求 `scripts` 为数组并逐项过 `parseScript`（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:48-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L48-L52)）
- 未知结果 `op` 抛错（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L53-L55)）
- `available === false` 的分块结果走另一套键集校验并返回不带数据的结果（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:56-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L56-L64)）
- 有数据的分块结果校验完整键集并要求 `available` 为 `true`、`data` 为字符串、`eof` 为布尔（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L65-L72)）
- 要求 `nextOffset` 不小于 `offset` 且 `data` 匹配 base64 正则，否则抛错（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:73-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L73-L77)）
- 校验通过后返回逐字段重建的脱离原对象的结果（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:78-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L78-L87)）
- `parseScript` 固定脚本描述符键集，并限制 `url` 长度不超过 8192、`hash` 为字符串（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:90-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L90-L97)）
- `parseScript` 把起止行列都要求为非负整数，`buildId`／`sourceMapUrl`／`isModule`／`length` 缺省时不写入结果（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:98-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L98-L111)）
- `contentKind` 只接受 `'source'` 与 `'source-map'`（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:113-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L113-L118)）
- `natural` 按 `zero` 参数分别要求非负或正的安全整数（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:120-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L120-L125)）
- 模块级 base64 正则决定哪些分块数据被接受（[packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts:127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/codec.ts#L127)）

### packages/experimental/inspector/src/shared/bridge/messages/sources/commands.ts

Client 源码目录的命令、结果与错误的类型声明，被 codec.ts 与 frames.ts 引用。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts

Client 源码目录协议的带版本信封类型与帧解码器，被桥接层在收发请求／响应／会话关闭通知时使用。

- `parseClientSourcesCapability` 固定键集并要求 `type` 恰为 `'client-sources'`（[packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts:58-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts#L58-L62)）
- `parseClientSourceRequestFrame` 校验信封键集、协议版本与帧标签，并把四个 id 打标、命令交给 `parseClientSourceCommand`（[packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts:69-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts#L69-L83)）
- `parseClientSourceResponseFrame` 同样校验键集、版本与标签，并解析 `outcome`（[packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts:90-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts#L90-L104)）
- `parseClientSourceSessionClosedFrame` 校验会话关闭通知的键集、版本与标签并重建三个 id（[packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts:111-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts#L111-L123)）
- `parseOutcome` 按布尔 `ok` 分派：成功分支解析结果，失败分支要求错误码在允许集合内且 `message` 为字符串（[packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts:125-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts#L125-L139)）
- 模块级错误码集合枚举五个被接受的失败码（[packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts:141-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/messages/sources/frames.ts#L141-L143)）

### packages/experimental/inspector/src/shared/bridge/messages/sources/index.ts

Client 源码目录协议子目录的重导出入口。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/publisher.ts

桥接层发布与查询能力的接口声明，以及 Host／Client 两种传输共用的抽象基类。

- `publish` 把观测转交给具体发布器，未传时间戳时以 `performance.now()` 填入（[packages/experimental/inspector/src/shared/bridge/publisher.ts:31-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/publisher.ts#L31-L34)）
- `setState` 把状态转交给具体发布器保留并发布，同样默认 `performance.now()`（[packages/experimental/inspector/src/shared/bridge/publisher.ts:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/publisher.ts#L36-L39)）
- `request` 把查询转交给当前查询请求器（[packages/experimental/inspector/src/shared/bridge/publisher.ts:41-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/publisher.ts#L41-L44)）

### packages/experimental/inspector/src/shared/bridge/query-reader.ts

把 Cordis 树读取接口接到查询协议上的适配器工厂。

- 生成的读取器每次 `getTree()` 都发一条 `cordis-tree/get` 查询并返回结果里的 `tree`（[packages/experimental/inspector/src/shared/bridge/query-reader.ts:11-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/query-reader.ts#L11-L18)）

### packages/experimental/inspector/src/shared/bridge/rpc.ts

Host 与 Client 共用的非 CDP 查询请求相关器，负责请求编号、超时、代际匹配与响应分发。

- `InspectorQueryRemoteError` 把远端返回的错误码随异常一起带出（[packages/experimental/inspector/src/shared/bridge/rpc.ts:45-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L45-L49)）
- 连接持有待决请求表、当前代际、自增请求号与已关闭标志（[packages/experimental/inspector/src/shared/bridge/rpc.ts:53-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L53-L56)）
- `connect` 在已关闭时抛错，否则先以"代际被替换"拒绝全部待决请求再装入新代际（[packages/experimental/inspector/src/shared/bridge/rpc.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L66-L70)）
- `request` 在已关闭或无活动代际时直接返回被拒绝的 Promise（[packages/experimental/inspector/src/shared/bridge/rpc.ts:78-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L78-L81)）
- 每次请求自增计数生成 `query-<n>` 请求号（[packages/experimental/inspector/src/shared/bridge/rpc.ts:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L82)）
- 请求帧带上协议版本、`query/request` 标签以及当前代际的 sourceId 与 generation（[packages/experimental/inspector/src/shared/bridge/rpc.ts:83-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L83-L90)）
- 请求帧的 JSON 字节数超过 `maxFrameBytes` 时不发送，直接拒绝（[packages/experimental/inspector/src/shared/bridge/rpc.ts:91-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L91-L93)）
- 每条请求装一个 `timeoutMs` 定时器，到期删除待决项并以超时错误拒绝（[packages/experimental/inspector/src/shared/bridge/rpc.ts:94-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L94-L99)）
- 载体写入抛错时立即拒绝对应的待决请求（[packages/experimental/inspector/src/shared/bridge/rpc.ts:100-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L100-L104)）
- `receive` 对非查询响应信封返回 `false`，把该值让给其他协议处理（[packages/experimental/inspector/src/shared/bridge/rpc.ts:114-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L114-L115)）
- 响应解析失败或超出 `maxFrameBytes` 时先断开连接再把异常抛给调用方（[packages/experimental/inspector/src/shared/bridge/rpc.ts:116-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L116-L125)）
- 请求号不在待决表中的响应被吞掉并报告为已消费（[packages/experimental/inspector/src/shared/bridge/rpc.ts:126-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L126-L127)）
- 响应的 sourceId 或 generation 与当前代际不符时拒绝该请求（[packages/experimental/inspector/src/shared/bridge/rpc.ts:128-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L128-L132)）
- 失败 outcome 以携带远端错误码的 `InspectorQueryRemoteError` 拒绝（[packages/experimental/inspector/src/shared/bridge/rpc.ts:133-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L133-L139)）
- 结果 `op` 与请求 `op` 不一致时拒绝该请求（[packages/experimental/inspector/src/shared/bridge/rpc.ts:140-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L140-L145)）
- 成功路径清除定时器、删除待决项并用结果兑现 Promise（[packages/experimental/inspector/src/shared/bridge/rpc.ts:146-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L146-L149)）
- `disconnect` 清空活动代际并以给定原因拒绝全部待决请求，仍允许后续重连（[packages/experimental/inspector/src/shared/bridge/rpc.ts:156-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L156-L159)）
- `close` 置位已关闭标志并断开，后续 `connect` 与 `request` 一律失败（[packages/experimental/inspector/src/shared/bridge/rpc.ts:165-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L165-L169)）
- `rejectPending` 在拒绝前清除该请求的超时定时器并从表中删除（[packages/experimental/inspector/src/shared/bridge/rpc.ts:171-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L171-L177)）
- `renderError` 把非 `Error` 抛出物包成 `Error` 再向外传（[packages/experimental/inspector/src/shared/bridge/rpc.ts:180-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/rpc.ts#L180-L182)）

### packages/experimental/inspector/src/shared/bridge/validation.ts

把上层校验原语转发到 bridge 目录下的重导出文件。

- 无运行期机制

### packages/experimental/inspector/src/shared/bridge/version.ts

Inspector 线协议版本常量所在文件，被各帧解码器用于版本比对。

- 协议版本固定为 `0`，各解码器据此拒绝其他版本的帧（[packages/experimental/inspector/src/shared/bridge/version.ts:2](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/bridge/version.ts#L2)）

### packages/experimental/inspector/src/shared/cdp/capabilities.ts

各 realm 后端所声明支持的 Runtime／Console／Source／Debugger 操作的类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/console.ts

Runtime 后端发出的 Console 事件与未捕获异常事件的类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/debugger.ts

调试器后端使用的位置、作用域、调用帧与生命周期事件的类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/errors.ts

与引擎无关的 JavaScript 异常与调用栈信息的类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/ids.ts

realm 后端所拥有的三种不透明标识符的品牌化类型别名。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/index.ts

cdp 子目录内各协议类型模块的重导出入口。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/operations.ts

Runtime 求值、取属性、调用函数、等待 Promise 等请求与结果的类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/property.ts

Runtime 后端返回的普通、内部与私有属性描述符的类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/realm.ts

被检查 JavaScript realm 的 Runtime／Console／Source／Debugger／原生域后端接口声明。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/remote-object.ts

与引擎无关的 JavaScript 值描述、预览与后端对象引用的类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/cdp/sources.ts

realm 源码目录里单个脚本元数据的类型定义。

- 无运行期机制

### packages/experimental/inspector/src/shared/cordis/collector.ts

从活的 Cordis Context／Fiber 图采集有界语义快照的采集器，被 observer.ts 驱动。

- 用 `Symbol.for('cordis.shadow')` 标记需要穿透的影子对象（[packages/experimental/inspector/src/shared/cordis/collector.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L14)）
- 采集器持有一张随每次快照原子替换的活对象表与自增的 revision（[packages/experimental/inspector/src/shared/cordis/collector.ts:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L39-L44)）
- `snapshot()` 先遍历 Context 图，再开启一代待提交的对象表（[packages/experimental/inspector/src/shared/cordis/collector.ts:50-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L50-L55)）
- 节点数达到 `maxNodes` 时不再投影该节点并置 `truncated`（[packages/experimental/inspector/src/shared/cordis/collector.ts:57-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L57-L62)）
- 每个 Context 节点把活对象登记进待提交表并只写出其不透明句柄（[packages/experimental/inspector/src/shared/cordis/collector.ts:63-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L63-L67)）
- 子 Context 若正是某 Fiber 自己的 ctx 则投影成 Fiber 节点，否则投影成普通 Context 节点（[packages/experimental/inspector/src/shared/cordis/collector.ts:68-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L68-L76)）
- `uid` 为 `null` 的 Fiber 不进入快照（[packages/experimental/inspector/src/shared/cordis/collector.ts:79-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L79-L80)）
- Fiber 节点按"自身加所属 Context"两个名额预检 `maxNodes`，不够则整体丢弃并置 `truncated`（[packages/experimental/inspector/src/shared/cordis/collector.ts:81-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L81-L84)）
- Fiber 节点登记 Fiber 对象、写出 `uid`，并把所属 Context 作为其唯一子节点（[packages/experimental/inspector/src/shared/cordis/collector.ts:85-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L85-L93)）
- 根 Context 都放不下时抛错（[packages/experimental/inspector/src/shared/cordis/collector.ts:95-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L95-L96)）
- 快照带上模型版本、递增的 revision、注册表 id 与截断标志（[packages/experimental/inspector/src/shared/cordis/collector.ts:97-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L97-L103)）
- 编码字节数超 `maxBytes` 时循环剪掉最后一个叶节点、释放其句柄并置 `truncated`（[packages/experimental/inspector/src/shared/cordis/collector.ts:104-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L104-L109)）
- 剪无可剪仍超字节上限时抛错（[packages/experimental/inspector/src/shared/cordis/collector.ts:110-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L110-L112)）
- 只有在快照定稿后才提交对象表，替换上一代强引用（[packages/experimental/inspector/src/shared/cordis/collector.ts:113-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L113-L114)）
- `close()` 关闭注册表，释放全部保留对象（[packages/experimental/inspector/src/shared/cordis/collector.ts:117-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L117-L120)）
- 原型链回溯深度超过 100 时放弃该分支并置 `truncated`（[packages/experimental/inspector/src/shared/cordis/collector.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L126-L130)）
- 候选值先穿透影子包装再用 `Context.is` 过滤，非 Context 直接丢弃（[packages/experimental/inspector/src/shared/cordis/collector.ts:131-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L131-L133)）
- 同一 Context 只登记一次，重复访问复用已有节点（[packages/experimental/inspector/src/shared/cordis/collector.ts:134-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L134-L135)）
- 非根 Context 通过其原型解析出父节点并挂到父节点的子列表上，父不可达则整支丢弃（[packages/experimental/inspector/src/shared/cordis/collector.ts:136-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L136-L147)）
- 遍历根注册表里每个 runtime 的 fibers，跳过 `uid` 为 `null` 者，登记其 parent 与 ctx（[packages/experimental/inspector/src/shared/cordis/collector.ts:149-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L149-L156)）
- 再遍历根事件系统的全部钩子，登记每个钩子所属的 ctx（[packages/experimental/inspector/src/shared/cordis/collector.ts:157-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L157-L159)）
- 每个节点的子列表按 Fiber `uid` 升序排列，无 Fiber 的排在最后（[packages/experimental/inspector/src/shared/cordis/collector.ts:160-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L160-L163)）
- `describeContext` 只读取 Context 自有的 `fiber` 属性描述符，不走原型链（[packages/experimental/inspector/src/shared/cordis/collector.ts:167-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L167-L174)）
- `unwrapContext` 沿原型链剥掉所有带影子标记的包装层（[packages/experimental/inspector/src/shared/cordis/collector.ts:176-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L176-L182)）
- `pruneLast` 递归到最深的最后一个子节点再摘除，返回被摘除节点的句柄以供释放（[packages/experimental/inspector/src/shared/cordis/collector.ts:184-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/collector.ts#L184-L198)）

### packages/experimental/inspector/src/shared/cordis/ids.ts

realm 本地对象注册表 id 与对象句柄的品牌化类型别名。

- 无运行期机制

### packages/experimental/inspector/src/shared/cordis/model.ts

面向消费方的 Cordis 运行时树类型与其解码器，被非 CDP 读取方使用。

- 消费方可见的树模型版本固定为 `0`（[packages/experimental/inspector/src/shared/cordis/model.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L9)）
- `parseCordisRuntimeTree` 固定顶层键集，并要求版本相符、`clients` 为数组（[packages/experimental/inspector/src/shared/cordis/model.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L66-L70)）
- host 允许为 `null`，其余 realm 按 `host`／`client` 两种 kind 分别解析（[packages/experimental/inspector/src/shared/cordis/model.ts:71-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L71-L72)）
- 全树内 sourceId 重复即抛错（[packages/experimental/inspector/src/shared/cordis/model.ts:73-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L73-L79)）
- `parseRealm` 固定 realm 与 source 的键集，要求 kind 与调用位置一致、label 长度在 1 到 256 之间（[packages/experimental/inspector/src/shared/cordis/model.ts:88-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L88-L92)）
- realm 的 `revision` 必须是不小于 1 的安全整数、`truncated` 必须是布尔（[packages/experimental/inspector/src/shared/cordis/model.ts:93-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L93-L95)）
- realm 的根节点必须是 Context（[packages/experimental/inspector/src/shared/cordis/model.ts:96-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L96-L97)）
- `cordisRuntimeSourceId` 把源 id 打成消费方可见的品牌类型（[packages/experimental/inspector/src/shared/cordis/model.ts:116-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L116-L118)）
- `parseConnection` 只接受不带额外键的 `connected` 与带字符串 `reason` 的 `disconnected`（[packages/experimental/inspector/src/shared/cordis/model.ts:120-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L120-L131)）
- 节点递归深度超过 `CORDIS_TREE_MAX_DEPTH` 时抛错（[packages/experimental/inspector/src/shared/cordis/model.ts:137-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L137-L138)）
- 节点 kind 只允许 `context` 与 `fiber`，两种 kind 各自固定不同键集、`children` 必须是数组（[packages/experimental/inspector/src/shared/cordis/model.ts:139-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L139-L145)）
- Fiber 的 `uid` 必须是不小于 1 的安全整数且恰有一个子节点（[packages/experimental/inspector/src/shared/cordis/model.ts:149-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L149-L153)）
- 同一棵树内 Fiber `uid` 重复即抛错（[packages/experimental/inspector/src/shared/cordis/model.ts:154-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L154-L156)）
- Fiber 的唯一子节点必须是 Context（[packages/experimental/inspector/src/shared/cordis/model.ts:157-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/model.ts#L157-L159)）

### packages/experimental/inspector/src/shared/cordis/object-reference.ts

跨线路传输的活对象引用类型及其解码器。

- `parseInspectorObjectReference` 固定 `registryId`／`handle` 两个键并把二者打成品牌 id（[packages/experimental/inspector/src/shared/cordis/object-reference.ts:17-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-reference.ts#L17-L23)）

### packages/experimental/inspector/src/shared/cordis/object-registry.ts

realm 内保留活对象、分配不透明句柄并支持反查的注册表，被采集器与 CDP 求值路径使用。

- 全局注册表挂载所用的符号键名与 Fiber 包装层最大穿透深度都在模块级固定（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:11-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L11-L12)）
- 导出一段自包含函数源码，被送进被检查 realm 执行，遍历该 realm 的全部注册表来识别自己的 `this`（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:15-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L15-L23)）
- 注册表以随机 UUID 作为 realm 内唯一 id（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L28)）
- 对象到句柄的映射用 WeakMap，被保留对象的强引用表与句柄自增计数分开持有（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:29-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L29-L31)）
- 构造时把自身登记进 realm 全局注册表表（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L34-L36)）
- `begin()` 在已销毁时抛错，否则开启一代待提交对象集合（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:42-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L42-L45)）
- `resolve()` 只在句柄仍被最新一代保留时返回活对象（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:52-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L52-L54)）
- `identify()` 只接受对象与函数，其余值直接返回未识别（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:62-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L62-L63)）
- `identify()` 命中要求句柄存在且当前保留的正是同一个对象（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:65-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L65-L67)）
- 未命中时只在候选对象自有键恰为单个 `then` 时沿原型链上溯，最多穿透 8 层（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:68-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L68-L71)）
- 读取候选对象自有键抛异常时吞掉并返回未识别，让后续注册表继续尝试原值（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:72-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L72-L75)）
- `close()` 置销毁标志、从 realm 全局表中摘除自身并清空全部强引用（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:81-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L81-L86)）
- `retain()` 为同一对象复用已分配的 `object-<n>` 句柄，并把它写进待提交表（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:94-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L94-L102)）
- `commit()` 用完成的一代整表替换当前强引用集合（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:108-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L108-L110)）
- 代际对象在提交后再调用 `retain()` 抛错（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:125-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L125-L128)）
- `release()` 把被裁掉的句柄从待提交表移除，提交后再调用同样抛错（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:134-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L134-L137)）
- 代际 `commit()` 只生效一次，重复调用直接返回（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:140-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L140-L144)）
- `realmObjectExpression` 拼出一条在被检查 realm 内按注册表 id 与句柄取回活对象的表达式（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:152-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L152-L154)）
- `identifyRealmObject` 依次询问本 realm 所有注册表，返回第一个命中的引用（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:161-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L161-L167)）
- `registries()` 惰性在 `globalThis` 的符号键上装一张注册表 Map，已存在则复用（[packages/experimental/inspector/src/shared/cordis/object-registry.ts:169-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/object-registry.ts#L169-L176)）

### packages/experimental/inspector/src/shared/cordis/observer.ts

把 Cordis 生命周期事件转成合并后的整树快照发布的观察器，被 publisher.ts 调用。

- 以 `ctx.root` 与给定上限构造采集器（[packages/experimental/inspector/src/shared/cordis/observer.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/observer.ts#L22)）
- `publish` 在已关闭时不再采集，否则把一次完整快照交给监听者（[packages/experimental/inspector/src/shared/cordis/observer.ts:25-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/observer.ts#L25-L29)）
- `schedule` 用一个待发标志把同一微任务内的多次变更合并为一次 `queueMicrotask` 发布（[packages/experimental/inspector/src/shared/cordis/observer.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/observer.ts#L30-L34)）
- 以全局方式订阅 `internal/plugin` 与 `internal/status` 两个事件触发重采（[packages/experimental/inspector/src/shared/cordis/observer.ts:35-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/observer.ts#L35-L38)）
- 注册完成即同步发布一次初始快照（[packages/experimental/inspector/src/shared/cordis/observer.ts:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/observer.ts#L39)）
- 返回的处置函数只生效一次，置关闭标志、退订全部监听并关闭采集器（[packages/experimental/inspector/src/shared/cordis/observer.ts:40-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/observer.ts#L40-L45)）

### packages/experimental/inspector/src/shared/cordis/projector.ts

把带路由与活对象句柄的快照投影成消费方可见语义树的纯函数。

- `projectCordisRuntimeTree` 写入消费方模型版本，host 允许为 `null`，clients 逐个投影（[packages/experimental/inspector/src/shared/cordis/projector.ts:43-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/projector.ts#L43-L49)）
- `projectRealm` 只保留 sourceId／kind／label、连接状态、revision、截断标志与根节点（[packages/experimental/inspector/src/shared/cordis/projector.ts:51-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/projector.ts#L51-L65)）
- 节点投影丢弃 `objectHandle`，Context 只留子节点、Fiber 只留 `uid` 与其唯一 Context（[packages/experimental/inspector/src/shared/cordis/projector.ts:67-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/projector.ts#L67-L78)）

### packages/experimental/inspector/src/shared/cordis/publisher.ts

把观察到的 Cordis 快照写成一条有保留状态的观测的薄封装，Host 与 Client 两侧共用。

- 每次快照都以 `CORDIS_TREE_TOPIC` 为主题调 `setState`，覆盖该主题的保留状态（[packages/experimental/inspector/src/shared/cordis/publisher.ts:17-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/publisher.ts#L17-L25)）

### packages/experimental/inspector/src/shared/cordis/reader.ts

Cordis 运行时树读取接口及其本地投影版工厂。

- `createCordisRuntimeTreeReader` 把同步或异步的取树函数包成统一的异步读取器（[packages/experimental/inspector/src/shared/cordis/reader.ts:20-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/reader.ts#L20-L24)）

### packages/experimental/inspector/src/shared/cordis/snapshot.ts

realm Cordis 树快照的序列化模型与解码器，被观测接收方在收到整树替换时调用。

- 序列化模型版本固定为 `0`（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L11)）
- 单个 realm 快照的最大嵌套深度固定为 256（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L14)）
- `parseCordisTreeSnapshot` 固定顶层键集，并要求版本相符、`revision` 为不小于 1 的安全整数、`truncated` 为布尔（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:51-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L51-L59)）
- 解析过程带节点计数、已见句柄集与已见 Fiber uid 集，且根节点必须是 Context（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:60-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L60-L62)）
- 校验通过后返回逐字段重建、注册表 id 已打标的脱离原对象的快照（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:63-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L63-L69)）
- 节点深度超过 256 时抛错（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:78-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L78-L79)）
- 节点总数超过调用方给的 `maxNodes` 时抛错（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L80)）
- 节点必须是普通对象且 kind 为 `context` 或 `fiber`（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:81-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L81-L83)）
- 对象句柄逐个打标，同一快照内重复句柄即抛错（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:84-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L84-L86)）
- `children` 必须是数组（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L87)）
- Context 节点固定三个键并递归解析全部子节点（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:88-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L88-L94)）
- Fiber 节点固定四个键，`uid` 必须是不小于 1 的安全整数（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:96-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L96-L99)）
- 同一快照内 Fiber `uid` 重复即抛错（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:100-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L100-L101)）
- Fiber 必须恰好拥有一个子节点且该子节点是 Context（[packages/experimental/inspector/src/shared/cordis/snapshot.ts:102-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/cordis/snapshot.ts#L102-L104)）

### packages/experimental/inspector/src/shared/identity.ts

Inspector 各类不透明标识符的品牌化构造函数所在文件。

- `inspectorId` 要求标识符长度在 1 到 256 之间，否则抛错，通过后打上角色品牌（[packages/experimental/inspector/src/shared/identity.ts:14-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/identity.ts#L14-L19)）

### packages/experimental/inspector/src/shared/index.ts

shared 目录对外的模型与桥接协议重导出入口。

- 无运行期机制

### packages/experimental/inspector/src/shared/json.ts

Inspector 跨 realm 消息所允许的 JSON 值类型与相应的判定、校验、字节计量函数。

- `isJsonValue` 带一个祖先集合进入递归判定，用于检出环（[packages/experimental/inspector/src/shared/json.ts:22-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/json.ts#L22-L24)）
- `requireJsonObject` 同时要求是普通对象且整体是合法 JSON 值，否则抛错（[packages/experimental/inspector/src/shared/json.ts:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/json.ts#L32-L37)）
- `jsonByteLength` 以 `JSON.stringify` 后的 UTF-8 编码长度作为字节数，各处上限判定都基于它（[packages/experimental/inspector/src/shared/json.ts:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/json.ts#L44-L46)）
- `isPlainObject` 只承认原型为 `Object.prototype` 或 `null` 的非数组对象（[packages/experimental/inspector/src/shared/json.ts:53-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/json.ts#L53-L57)）
- 数值必须有限且不是 `-0` 才算合法 JSON 值（[packages/experimental/inspector/src/shared/json.ts:60-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/json.ts#L60-L61)）
- 递归中遇到已在祖先集合里的对象即判定不合法，遍历后从集合中移除（[packages/experimental/inspector/src/shared/json.ts:62-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/json.ts#L62-L64)）
- 数组必须以 `Array.prototype` 为原型且自有键恰为下标加 `length`，排除稀疏与额外属性（[packages/experimental/inspector/src/shared/json.ts:65-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/json.ts#L65-L68)）
- 对象的自有键必须全为字符串，且每个都是可枚举的数据属性并逐个递归判定（[packages/experimental/inspector/src/shared/json.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/json.ts#L69-L75)）

### packages/experimental/inspector/src/shared/network/event-source.ts

把被捕获响应体的字节流增量解析成 Server-Sent Events 消息的解析器。

- 解析器持有跨块的 UTF-8 解码器、半行缓冲、事件名、事件 id、数据缓冲与回车续接标志（[packages/experimental/inspector/src/shared/network/event-source.ts:6-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/network/event-source.ts#L6-L13)）
- `push` 以流式模式解码字节块，保证多字节字符跨块不被截断（[packages/experimental/inspector/src/shared/network/event-source.ts:19-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/network/event-source.ts#L19-L21)）
- `consume` 按 `\r`、`\n` 切行，并把跨块的 `\r\n` 当作单个换行处理（[packages/experimental/inspector/src/shared/network/event-source.ts:23-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/network/event-source.ts#L23-L43)）
- 每块结尾的残余文本留在半行缓冲里等下一块（[packages/experimental/inspector/src/shared/network/event-source.ts:41-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/network/event-source.ts#L41-L42)）
- 空行结束一条事件：清空数据与事件名，数据为空时不产出，事件名缺省为 `message`，并去掉数据末尾的换行（[packages/experimental/inspector/src/shared/network/event-source.ts:45-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/network/event-source.ts#L45-L57)）
- 以冒号开头的注释行被忽略（[packages/experimental/inspector/src/shared/network/event-source.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/network/event-source.ts#L58)）
- 行按首个冒号切成字段名与值，无冒号时值为空串，值前的单个空格被去掉（[packages/experimental/inspector/src/shared/network/event-source.ts:59-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/network/event-source.ts#L59-L62)）
- `event` 覆盖事件名、`data` 追加一行并补换行、`id` 在不含 NUL 时更新事件 id、其余字段一律忽略（[packages/experimental/inspector/src/shared/network/event-source.ts:63-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/network/event-source.ts#L63-L75)）

### packages/experimental/inspector/src/shared/network/observation.ts

声明 fetch 全量捕获观测载荷的接口与类型别名，被 Worker 侧网络存储和 CDP Network 投影引用。

- 无运行期机制

### packages/experimental/inspector/src/shared/service.ts

在 realm 本地连接之上组装 Host 与 Client 两侧共用的服务门面。

- `publish` 把 topic、JSON 载荷和源时钟毫秒转交给连接，不等待 Worker 投递结果（[packages/experimental/inspector/src/shared/service.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/service.ts#L29)）
- `cordis` 字段由同一个连接构造出只读拓扑查询读取器（[packages/experimental/inspector/src/shared/service.ts:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/service.ts#L30)）

### packages/experimental/inspector/src/shared/validation.ts

带版本的 Inspector 线协议对象读取器，被各 CDP 域参数解析与桥接帧解析复用。

- `exactObject` 先要求值是普通对象，否则抛出带标签的协议错误（[packages/experimental/inspector/src/shared/validation.ts:13-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/validation.ts#L13-L17)）
- `exactKeys` 用 `Reflect.ownKeys` 遍历全部自有键（含 symbol），任一不在允许集合内即抛错（[packages/experimental/inspector/src/shared/validation.ts:25-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/validation.ts#L25-L32)）
- `wireId` 要求字符串并交由 `inspectorId` 打上角色品牌（[packages/experimental/inspector/src/shared/validation.ts:40-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/validation.ts#L40-L43)）
- `optionalString` 对 undefined 返回空对象，对非字符串抛错（[packages/experimental/inspector/src/shared/validation.ts:51-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/validation.ts#L51-L59)）
- `optionalBoolean` 对 undefined 返回空对象，对非布尔抛错（[packages/experimental/inspector/src/shared/validation.ts:67-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/validation.ts#L67-L75)）
- `optionalNonNegativeNumber` 拒绝非数字、非有限值与负数（[packages/experimental/inspector/src/shared/validation.ts:83-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/shared/validation.ts#L83-L93)）

### packages/experimental/inspector/src/worker/bridge/endpoint.ts

Worker 进程持有的 HTTP 发现端点、DevTools CDP 升级端点与 Client 观测上报端点。

- 两个 WebSocketServer 均以 `noServer` 建立，并把单帧最大载荷限定为 `config.maxSourceFrameBytes`（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:42-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L42-L43)）
- `start` 从 `config.startPort` 起循环尝试绑定，遇 `EADDRINUSE` 端口加一继续，`startPort` 为 0 时不重试，到 65535 仍失败则抛错（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:50-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L50-L73)）
- 绑定成功后给服务器挂一个空的 `error` 监听，令已建立服务器的错误不再冒泡（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:57-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L57-L60)）
- `close` 逐个关闭 CDP 会话并 `terminate` 套接字，对每个上报连接调用 `sources.disconnect`，再并行等待两个 WebSocketServer 与 HTTP 服务器关闭并强制断开存量连接（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:76-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L76-L96)）
- `/json` 与 `/json/list` 返回目标列表，`/json/version` 返回浏览器标识、协议版本 1.3 与调试 WebSocket 地址，其余路径回 404 文本（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:98-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L98-L114)）
- 升级请求按路径分流：`/devtools/page/<targetId>` 走 CDP，`/ingest` 先过授权检查、不通过则直接写回 403 并关闭，其它路径直接销毁套接字（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:116-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L116-L137)）
- CDP 连接构造只在 `OPEN` 状态下发送 JSON 的传输层，并以 1008 关闭码作为无效请求出口（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:140-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L140-L145)）
- 每个 CDP 套接字创建一个 `CdpSession` 并登记，收到的报文按 JSON 解析后交给会话，解析失败以 1008 关闭连接，关闭事件删除登记并关闭会话（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:146-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L146-L169)）
- 上报连接先开一个查询对端，其发送函数在发出 `source/accepted` 帧后把 sourceId 与 generation 交给查询对端记录（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:173-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L173-L185)）
- 上报连接关闭时把关闭原因截断到 123 字节（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L186)）
- 上报报文先交查询对端消费，未被消费才转给源注册表，JSON 解析失败以 1008 关闭（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:189-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L189-L196)）
- 上报套接字关闭时移除登记、关闭查询对端并通知源注册表断开（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:197-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L197-L201)）
- 上报授权要求 `sec-websocket-protocol` 中含 `clientToken`；带 Origin 时必须命中配置的来源列表或解析出 loopback 主机名，解析失败判为不通过（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:207-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L207-L221)）
- 发现响应中的目标描述固定 `type: 'page'`、`url: dsh://host`，并给出带 `panel=elements&noJavaScriptCompletion=true` 的前端地址（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:223-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L223-L237)）
- 未绑定 TCP 端口或未启动时读取端口/服务器均抛错（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:239-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L239-L256)）
- `listen` 以一次性 `error`/`listening` 监听互相摘除的方式落定绑定结果，地址非 TCP 形态时拒绝（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:264-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L264-L287)）
- `rawText` 把 ArrayBuffer、Buffer 数组与 Buffer 统一拼成 UTF-8 文本（[packages/experimental/inspector/src/worker/bridge/endpoint.ts:293-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/endpoint.ts#L293-L298)）

### packages/experimental/inspector/src/worker/bridge/hub.ts

Worker 侧串行持有全部 Host 与 Client 源代次、观测记录派发与扩展帧转发的注册表。

- `receive` 先按每帧最大记录数解析帧，再按 `maxFrameBytes` 校验 JSON 字节长度，任一失败都回一个 `source/rejected` 帧并以 1008 关闭该源传输（[packages/experimental/inspector/src/worker/bridge/hub.ts:94-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L94-L106)）
- `disconnect` 删除该连接承载的全部代次，逐个通知消费者关闭并广播 `closed` 事件（[packages/experimental/inspector/src/worker/bridge/hub.ts:113-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L113-L121)）
- `describe` 输出每个活跃源的 id、代次、种类、标签、能力名、期望序号、丢弃计数与逐 topic 计数（[packages/experimental/inspector/src/worker/bridge/hub.ts:127-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L127-L138)）
- `subscribeStatus` 与 `subscribeEvents` 登记监听器并返回移除自身的处置器（[packages/experimental/inspector/src/worker/bridge/hub.ts:145-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L145-L158)）
- `send` 仅在 sourceId 与代次都匹配当前活跃状态时投递，且帧体超过 `maxFrameBytes` 时抛错（[packages/experimental/inspector/src/worker/bridge/hub.ts:166-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L166-L174)）
- `close` 以 `inspector worker stopped` 为由关闭全部源并清空状态（[packages/experimental/inspector/src/worker/bridge/hub.ts:177-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L177-L184)）
- 非 `source/open` 的帧必须来自同一连接且代次一致，否则抛出协议错误（[packages/experimental/inspector/src/worker/bridge/hub.ts:186-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L186-L194)）
- `source/close` 删除状态、通知消费者并广播关闭（[packages/experimental/inspector/src/worker/bridge/hub.ts:195-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L195-L201)）
- `client-runtime/response` 要求源种类为 client 且声明了 `client-runtime` 能力，否则抛错（[packages/experimental/inspector/src/worker/bridge/hub.ts:202-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L202-L209)）
- `client-console/event` 要求声明 `client-console` 能力，否则抛错（[packages/experimental/inspector/src/worker/bridge/hub.ts:210-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L210-L217)）
- `client-sources/response` 要求声明 `client-sources` 能力，否则抛错（[packages/experimental/inspector/src/worker/bridge/hub.ts:218-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L218-L225)）
- `source/replace` 把期望序号重置为帧中的 `nextSequence`，按下标编号记录后调用消费者的 `replace`（[packages/experimental/inspector/src/worker/bridge/hub.ts:227-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L227-L236)）
- 追加帧的序号缺口与声明的 `droppedBefore` 不符或为负时，回一个 `source/resnapshot` 帧且不投递任何记录（[packages/experimental/inspector/src/worker/bridge/hub.ts:237-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L237-L248)）
- 正常追加时累加丢弃计数、按 `firstSequence` 逐条编号、推进期望序号、调用消费者 `append`，并回 `source/append-acknowledged` 帧（[packages/experimental/inspector/src/worker/bridge/hub.ts:249-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L249-L261)）
- `open` 要求源声明的种类与承载连接的种类一致，否则抛错（[packages/experimental/inspector/src/worker/bridge/hub.ts:264-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L264-L265)）
- 同一 sourceId 已有代次时先以 `source generation replaced` 关闭旧代次，再写入新状态、回 `source/accepted` 并广播 `opened`，期望序号从 1 起（[packages/experimental/inspector/src/worker/bridge/hub.ts:266-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L266-L288)）
- 记录的 topic 不在源声明集合内且未声明通配 `*` 时抛出协议错误（[packages/experimental/inspector/src/worker/bridge/hub.ts:290-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L290-L296)）
- `count` 逐条累加每 topic 的计数（[packages/experimental/inspector/src/worker/bridge/hub.ts:298-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L298-L302)）
- 状态与事件广播都对监听器快照迭代并吞掉其抛出的异常（[packages/experimental/inspector/src/worker/bridge/hub.ts:304-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/hub.ts#L304-L322)）

### packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts

把 Client realm 投影成合成 CDP 执行上下文，并在 Worker 与源代次之间做请求相关与超时管理。

- 构造时订阅源事件，把源生命周期与 Client 扩展帧接入路由（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:68-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L68-L70)）
- `bySource` 只在代次一致时返回目标（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:85-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L85-L88)）
- `subscribe` 登记上下文生命周期监听并返回处置器（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:95-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L95-L98)）
- `subscribeConsole` 先向源发 `client-console/enable`，发送不成功即抛错；返回的处置器发 `client-console/disable` 且吞掉发送异常（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:107-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L107-L137)）
- `request` 在路由已关闭或目标已非当前时直接拒绝（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:151-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L151-L153)）
- 每次请求用 `randomUUID` 生成请求 id，并挂一个 `timeoutMs` 定时器，到期先向 Client 发取消帧再拒绝，且定时器 `unref`（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:154-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L154-L163)）
- 请求帧发送返回 false 或抛异常时立即拒绝该 pending（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:164-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L164-L178)）
- `closeTargetSession` 拒绝该目标该会话的全部 pending、删除其 Console 订阅，并发出 `client-runtime/session-closed`（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:186-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L186-L203)）
- `close` 取消源订阅、拒绝全部未决请求并清空目标、订阅与监听器（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:206-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L206-L216)）
- 源事件按类型分发，`client-source-response` 被忽略，未知类型走 `assertNever` 抛错（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:218-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L218-L237)）
- 只有声明 `client-runtime` 能力的源才建立目标，contextId 从 -1 递减分配，`uniqueContextId` 由 `dsh-client:` 前缀加 sourceId 与代次拼成（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:239-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L239-L252)）
- 源关闭时按代次匹配移除目标、拒绝其全部 pending、清掉 Console 订阅并广播 `closed`（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:254-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L254-L266)）
- Console 事件只投递给目标与 sessionId 都匹配的订阅，监听器抛出的异常被吞掉（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:268-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L268-L279)）
- 无对应 pending 的响应会向源回一个取消帧（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:281-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L281-L286)）
- 响应的 sourceId、代次或 sessionId 与 pending 不符时向两端各发一次取消帧并拒绝（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:287-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L287-L294)）
- 失败结果先发确认帧再以 `ClientRuntimeRemoteError` 携带远端错误码拒绝（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:295-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L295-L299)）
- 结果的 op 与请求 op 不符时发取消帧并拒绝（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:300-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L300-L306)）
- 只有确认帧成功送达才清定时器、删 pending 并兑现结果，否则拒绝（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:307-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L307-L313)）
- 确认帧发送异常按未送达处理并返回 false，取消帧发送异常被吞掉（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:316-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L316-L353)）
- `rejectPending` 清定时器、删表项再拒绝，重复调用无效（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:355-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L355-L361)）
- 目标事件广播吞掉单个监听器的异常（[packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts:363-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/runtime-rpc.ts#L363-L371)）

### packages/experimental/inspector/src/worker/bridge/session.ts

Worker 侧向 Client 代次投递会话清理帧的共用函数，被 Runtime 与源目录两个路由复用。

- 尝试把清理帧发给指定代次，发送抛出的异常被吞掉（[packages/experimental/inspector/src/worker/bridge/session.ts:16-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/session.ts#L16-L26)）

### packages/experimental/inspector/src/worker/bridge/source-rpc.ts

Worker 侧对 Client 只读脚本目录请求做相关、超时与结果校验的路由。

- 构造时把单次内容响应的解码字节数算成 `(maxFrameBytes - 4096) * 3 / 4` 并向下取整、至少为 1，并订阅源事件（[packages/experimental/inspector/src/worker/bridge/source-rpc.ts:49-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/source-rpc.ts#L49-L50)）
- 路由已关闭时请求直接被拒绝（[packages/experimental/inspector/src/worker/bridge/source-rpc.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/source-rpc.ts#L65)）
- 每次请求用 `randomUUID` 生成请求 id，超时定时器到期删 pending 并拒绝且 `unref`，发送失败或抛异常立即拒绝（[packages/experimental/inspector/src/worker/bridge/source-rpc.ts:66-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/source-rpc.ts#L66-L88)）
- `closeSession` 拒绝匹配 source、代次与 sessionId 的全部 pending，并发出 `client-sources/session-closed`（[packages/experimental/inspector/src/worker/bridge/source-rpc.ts:96-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/source-rpc.ts#L96-L110)）
- `close` 取消源订阅并拒绝全部未决请求（[packages/experimental/inspector/src/worker/bridge/source-rpc.ts:113-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/source-rpc.ts#L113-L120)）
- 源关闭事件拒绝该代次的全部 pending，其余源事件被忽略，未知类型走 `assertNever`（[packages/experimental/inspector/src/worker/bridge/source-rpc.ts:122-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/source-rpc.ts#L122-L142)）
- 结算时 sourceId、代次或 sessionId 不符即拒绝；失败结果以 `ClientSourceRemoteError` 拒绝；结果与请求不匹配也拒绝，全部通过才兑现（[packages/experimental/inspector/src/worker/bridge/source-rpc.ts:144-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/source-rpc.ts#L144-L167)）
- 匹配规则比较 op，非 `list-scripts` 时还比较 scriptKey 与 content，且在结果标记可用时比较 offset（[packages/experimental/inspector/src/worker/bridge/source-rpc.ts:178-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/bridge/source-rpc.ts#L178-L184)）

### packages/experimental/inspector/src/worker/cdp/domains/debugger/cdp-params.ts

Debugger 域请求参数的校验与归一化，被 Debugger 会话调用。

- `Debugger.evaluateOnCallFrame` 参数走精确键白名单，未列出的字段直接拒绝（[packages/experimental/inspector/src/worker/cdp/domains/debugger/cdp-params.ts:14-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/cdp-params.ts#L14-L17)）
- `callFrameId` 与 `expression` 必须是字符串，`timeout` 必须是非负有限数（[packages/experimental/inspector/src/worker/cdp/domains/debugger/cdp-params.ts:18-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/cdp-params.ts#L18-L24)）
- 输出把 CDP 的 `timeout` 改名为内部的 `timeoutMs`，其余可选字段仅在存在时带上（[packages/experimental/inspector/src/worker/cdp/domains/debugger/cdp-params.ts:25-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/cdp-params.ts#L25-L35)）
- `requestScriptId` 先看顶层 `scriptId`，再依次从 `location`、`start`、`end` 三个位置对象中取（[packages/experimental/inspector/src/worker/cdp/domains/debugger/cdp-params.ts:43-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/cdp-params.ts#L43-L52)）

### packages/experimental/inspector/src/worker/cdp/domains/debugger/index.ts

Debugger 域四个模块的聚合再导出。

- 无运行期机制

### packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts

把 realm 中立的脚本描述与调试事件投影成 CDP 通知。

- `scriptParsedEvent` 生成 `Debugger.scriptParsed`，脚本键原样作为 CDP ScriptId（[packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts:16-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts#L16-L21)）
- 脚本缺少 `executionContextId` 时，合成上下文的 realm 用其上下文 id，其余用 0；`buildId` 缺省为空串；sourceMapURL、isModule、length 仅在存在时带上（[packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts:26-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts#L26-L33)）
- `paused` 事件把每个调用帧的作用域对象、`this` 与返回值经 Runtime 会话投影到 `backtrace` 对象组（[packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts:50-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts#L50-L71)）
- `paused` 的 data、hitBreakpoints、asyncStackTrace 仅在存在时带上（[packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts:72-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts#L72-L76)）
- `resumed` 与 `breakpoint-resolved` 分别映射为 `Debugger.resumed` 与 `Debugger.breakpointResolved`（[packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts:78-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts#L78-L84)）
- 未知事件类型经 `assertNever` 抛出带事件内容的错误（[packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts:85-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts#L85-L87)）
- 位置投影把脚本键转成 ScriptId，`columnNumber` 仅在存在时带上（[packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts:90-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts#L90-L96)）
- 栈轨迹投影对无脚本键的帧填 `'0'`，并递归投影父栈（[packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts:98-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/projector.ts#L98-L110)）

### packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts

单个 DevTools 连接内 CDP ScriptId 到 realm 源后端的路由表。

- `register` 在同一 ScriptId 被不同 realm 注册时抛错，并返回该脚本是否首次登记（[packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts:26-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts#L26-L34)）
- `resolve` 按 ScriptId 查活跃路由（[packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts#L41-L43)）
- `byUrl` 与 `byHash` 分别按脚本 URL、内容哈希做精确匹配并返回首个命中（[packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts:50-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts#L50-L67)）
- `byUrlPattern` 用 `u` 标志把断点请求中的正则源编译后匹配脚本 URL，返回首个命中（[packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts:74-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts#L74-L80)）
- `removeRealm` 删除该 realm 的全部脚本路由，若该 realm 的 debugger 状态为 unsupported，则把 ScriptId 留在退休集合中（[packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts:87-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts#L87-L101)）
- `clear` 同时清空活跃路由与退休集合（[packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts:104-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts#L104-L107)）
- `cdpScriptId` 把 realm 内脚本键原样当作 CDP 线上标识（[packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts:115-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/script-registry.ts#L115-L117)）

### packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts

单个 DevTools 连接的 Debugger 域会话，跨 Host 与 Client realm 分发脚本、断点与求值请求。

- 构造时必须找到一个 `supported` 的原生域后端，否则抛错，并订阅 realm 集合变化（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:40-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L40-L45)）
- `handle` 只接管 `Debugger.` 前缀的方法，七个方法本地处理，其余一律转发给原生后端（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:53-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L53-L83)）
- `close` 取消 realm 订阅、解绑全部能力订阅、清空调用帧与脚本表，并释放 `backtrace` 对象组（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:86-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L86-L94)）
- `Debugger.enable` 走参数白名单，`maxScriptsCacheSize` 必须是非负有限数，重复启用直接返回空结果（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:97-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L97-L104)）
- 启用时对所有 realm 绑定能力订阅、并发调用各自后端的 enable，再并发发布脚本目录，结果合并返回（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:105-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L105-L112)）
- 启用过程出错时回滚启用标志与请求参数、解绑能力、清脚本表，并对所有支持的 realm 调用 disable 后重新抛出（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:113-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L113-L122)）
- `Debugger.disable` 清空全部连接本地状态、释放 `backtrace` 组并对所有支持的 realm 调用 disable（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:125-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L125-L135)）
- `Debugger.getScriptSource` 有路由时从源后端取源码；曾属于 unsupported realm 或 id 以 `client:` 开头时抛错；否则转发原生后端（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:137-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L137-L146)）
- `Debugger.searchInContent` 校验 scriptId、query、caseSensitive、isRegex，无路由时按同样规则拒绝或转发原生，有路由时在取回的源码上逐行匹配（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:148-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L148-L175)）
- `Debugger.evaluateOnCallFrame` 对 `client:` 开头的调用帧直接拒绝，按调用帧找 realm、找不到时退回首个支持的 realm，对象组缺省为 `backtrace`，结果经 Runtime 会话投影（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:177-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L177-L184)）
- `Debugger.pause` 与 `Debugger.resume` 在无任何支持 realm 时抛错，否则对全部支持 realm 并发调用并合并结果（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:186-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L186-L200)）
- 转发原生前先做 unsupported 路由检查，再由 Runtime 会话改写参数中的对象 id，任一步骤失败即回 CDP 错误响应（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:202-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L202-L213)）
- unsupported 检查依次按 scriptId、url、urlRegex、scriptHash、objectId 找路由，命中 unsupported realm 时返回其原因文本；已退休的 scriptId 返回脚本不可用（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:215-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L215-L239)）
- 新 realm 在已启用状态下被异步启用，失败时打印到 `console.error`；realm 关闭时释放两类订阅、清掉其调用帧映射并移除其脚本（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:241-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L241-L256)）
- 能力绑定为每个 realm 各订阅一次源脚本与调试事件，回调内再次检查启用标志后才发布（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:264-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L264-L276)）
- 目录发布在未启用或源能力不支持时直接返回，否则列出全部脚本逐个发布（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:278-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L278-L282)）
- 只有首次注册的脚本才向连接发送 `Debugger.scriptParsed`（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:284-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L284-L287)）
- `paused` 事件把每个调用帧 id 记到所属 realm；`resumed` 事件清掉该 realm 的调用帧映射并释放 `backtrace` 组，随后发送投影通知（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:289-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L289-L302)）
- 取后端时若 realm 为 unsupported 则抛出其记录的原因（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:322-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L322-L325)）
- 多 realm 结果用 `Object.assign` 依次覆盖合并成一个结果对象（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:327-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L327-L330)）
- 行搜索按 isRegex 编译正则（大小写不敏感时加 `i`）或做小写包含匹配，输出行号与整行内容（[packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts:333-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/debugger/session.ts#L333-L350)）

### packages/experimental/inspector/src/worker/cdp/domains/dom/index.ts

语义 DOM 域两个模块的再导出。

- 无运行期机制

### packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts

把 Cordis 树快照投影成与连接无关的语义文档，并算出两版之间的增量变更。

- 构造时立即构建一份文档，并订阅树存储：每次事件重建文档，源断开时先广播 `source-disconnected`，再把差分出的变更作为 `tree-mutated` 广播（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:79-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L79-L88)）
- `subscribe` 登记监听并返回移除自身的处置器，`close` 取消树订阅并清空监听（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:103-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L103-L112)）
- `nodeForObject` 按 sourceId、代次、注册表 id 与句柄拼成的复合键查当前节点（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:120-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L120-L122)）
- `nodeForRealm` 对 host realm 按种类解析，对 client realm 按 sourceId 与代次解析对象身份后再查节点（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:130-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L130-L145)）
- 文档构建固定为 `#document` 下挂 `host` 与 `clients` 两层，每个 client 源各成一个子节点（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:151-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L151-L161)）
- 冻结遍历同时建立 backendNodeId 索引与父子索引，且只有连接状态为 `connected` 的对象才进入对象反查表（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:162-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L162-L173)）
- 本轮未保留的 key 从 backendNodeId 分配表中删除，修订号自增后随文档返回（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:175-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L175-L178)）
- 实体节点的 key 由 `entity:` 前缀加对象复合键构成，`fiber` 节点带 `uid` 属性，并递归投影子节点（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:181-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L181-L194)）
- 节点按 key 稳定复用已分配的 backendNodeId，未见过的 key 分配自增新 id（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:196-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L196-L209)）
- 变更广播对监听器快照迭代并吞掉单个监听器的异常（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:211-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L211-L219)）
- 节点描述渲染成 `<name key="value">` 形式，空值属性只写键名（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:226-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L226-L229)）
- 对象复合键用 `\0` 连接 sourceId、代次、注册表 id 与句柄（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:231-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L231-L233)）
- 根节点差分失败时整篇退化成一条 `document-updated`（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:235-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L235-L240)）
- 节点差分在 backendNodeId 或名称变化时返回失败，属性新增/变更发 `attribute-modified`、消失发 `attribute-removed`（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:242-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L242-L256)）
- 保留下来的子节点相对顺序变化时发一条 `children-replaced` 并停止继续下钻（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:258-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L258-L271)）
- 顺序不变时对消失的子节点发 `child-removed`，对新增的发带前兄 id 的 `child-inserted`，再对同 id 子节点递归差分（[packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts:272-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/model.ts#L272-L292)）

### packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts

单个 DevTools 连接的只读 DOM 域会话，负责 NodeId 分配、增量投递、搜索与 RemoteObject 绑定。

- 一组写入类 DOM 方法被列入拒绝集合，文档默认下发深度为 3 层子节点（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:19-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L19-L28)）
- 构造时订阅后端文档变更（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:53-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L53-L59)）
- `handle` 只接管 `DOM.` 前缀的方法（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L66-L70)）
- `releaseObject` 删除该 objectId 的节点绑定并从所有对象组中摘除（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L76-L81)）
- `bindObject` 只有在当前树中找得到对应节点时才建立绑定并返回节点呈现字段（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:91-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L91-L101)）
- `releaseObjectGroup` 删除该组下全部 objectId 的绑定与组本身（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:107-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L107-L111)）
- `close` 取消订阅、重置全部连接本地映射并清空搜索结果（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:114-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L114-L118)）
- 命中写入类方法时直接抛出只读错误（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:120-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L120-L121)）
- `DOM.enable`/`DOM.disable` 切换事件投递开关，禁用时重置文档状态（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:123-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L123-L129)）
- `DOM.getDocument` 顺带打开事件投递，并按请求深度（缺省 3）序列化根节点（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:130-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L130-L132)）
- `DOM.requestChildNodes` 记录该父节点已下发子节点，并主动推送一条 `DOM.setChildNodes`（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:133-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L133-L145)）
- `DOM.describeNode` 以非投递模式序列化，因此不登记子节点下发记录（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:146-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L146-L149)）
- `DOM.getAttributes` 与 `DOM.getOuterHTML` 分别返回展平的属性对与递归渲染的自定义 HTML 文本（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:150-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L150-L153)）
- `DOM.pushNodesByBackendIdsToFrontend` 对非法或已消失的 id 返回 0，命中的先补发祖先链再返回 NodeId（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:154-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L154-L165)）
- `DOM.requestNode` 在对象未绑定或节点已消失时抛错，否则补发祖先链并返回 NodeId（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:168-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L168-L176)）
- `DOM.performSearch` 在名称、描述与属性拼成的小写串上做包含匹配、排除 `#document`，并登记自增 searchId（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:177-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L177-L185)）
- `DOM.getSearchResults` 按区间切片，并为每个仍存在的结果补发祖先链（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:186-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L186-L195)）
- `DOM.getBoxModel` 与 `DOM.getNodeForLocation` 固定抛出无布局几何的错误，未识别方法抛 `Method not found`（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:202-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L202-L207)）
- `DOM.resolveNode` 对结构节点与已断开 realm 抛错，用 realm 对象表达式在源中求值，缺 objectId 时抛错，绑定后把节点呈现字段覆盖到返回的 RemoteObject 上（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:210-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L210-L227)）
- 对象绑定同时记录 backendNodeId、sourceId 与代次，并按对象组归集 objectId（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:229-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L229-L241)）
- 节点选择依次尝试 nodeId、backendNodeId、objectId，全部落空才抛错（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:243-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L243-L258)）
- 序列化把 `#document` 输出成 nodeType 9 并带 `dsh://cordis` 的文档地址，其余节点 nodeType 1 且节点名大写、本地名保留原样（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:267-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L267-L287)）
- 祖先补发沿父索引逆推链条，对尚未下发过子节点的祖先各推一条深度 0 的 `DOM.setChildNodes`（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:289-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L289-L309)）
- NodeId 按 backendNodeId 稳定复用，未见过的分配自增新值并建立双向索引（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:316-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L316-L324)）
- 文档重置清掉 NodeId 双向索引、对象绑定、对象组、搜索结果与子节点下发记录（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:333-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L333-L340)）
- 后端变更事件里源断开只释放该源对象，其余变更在启用时逐条投递，随后无条件做一次状态裁剪（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:342-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L342-L349)）
- `document-updated` 先重置连接状态再发 `DOM.documentUpdated`（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:353-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L353-L356)）
- 子节点插入在父或前兄的 NodeId 未知时静默丢弃，投递前先清掉该子树的下发记录，并以深度 0 载荷发 `DOM.childNodeInserted`（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:357-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L357-L375)）
- 子节点移除先清子树下发记录，父或自身 NodeId 未知则不发通知（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:376-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L376-L383)）
- 子节点整体替换先清所有新子树的下发记录、把父标记为已下发，再发一条深度 0 的 `DOM.setChildNodes`（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:384-398](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L384-L398)）
- 属性变更与删除只在该节点 NodeId 已下发过时才发通知，未知变更类型走 `assertNever`（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:399-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L399-L418)）
- 状态裁剪丢弃文档中已不存在的 NodeId 与下发记录，对象绑定还要求 sourceId 与代次仍一致，并过滤掉搜索结果里失效的 NodeId（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:421-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L421-L447)）
- 源断开时按 sourceId 与代次删除对象绑定，并清掉变空的对象组（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:449-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L449-L458)）
- `outerHtml` 按缩进递归渲染，无子节点渲染成自闭合标签（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:465-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L465-L470)）
- 参数校验要求整数、非负整数或字符串，深度 `-1` 被换成正无穷、其余必须是正整数（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:476-505](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L476-L505)）
- 节点呈现固定 `subtype: 'node'`，类名按 fiber 与否取 `Fiber` 或 `Context`（[packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts:512-518](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/dom/session.ts#L512-L518)）

### packages/experimental/inspector/src/worker/cdp/domains/native.ts

把若干 Host 原生 CDP 域原样转发给 DevTools 连接的适配器。

- 构造时订阅原生后端消息，只转发本适配器拥有的域，并明确过滤掉 `Runtime.consoleAPICalled` 与 `Runtime.exceptionThrown`（[packages/experimental/inspector/src/worker/cdp/domains/native.ts:14-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/native.ts#L14-L20)）
- `handle` 对本适配器拥有的域把请求原样交给原生后端并回相关结果（[packages/experimental/inspector/src/worker/cdp/domains/native.ts:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/native.ts#L27-L31)）
- 归属判断取方法名第一个点之前的域名并查集合（[packages/experimental/inspector/src/worker/cdp/domains/native.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/native.ts#L38-L40)）
- `close` 停止向该连接转发原生通知（[packages/experimental/inspector/src/worker/cdp/domains/native.ts:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/native.ts#L43-L45)）
- 转发范围固定为 Runtime、Profiler、HeapProfiler、Schema 四个域（[packages/experimental/inspector/src/worker/cdp/domains/native.ts:49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/native.ts#L49)）

### packages/experimental/inspector/src/worker/cdp/domains/network/session.ts

把 Worker 侧归一化的网络观测投影成各 DevTools 连接本地的 CDP Network 事件与结果。

- 构造时订阅网络存储事件（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L23-L25)）
- `enable` 为该连接建立三张本地表，并把存储中保留的历史事件重放给它（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:31-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L31-L37)）
- `disable` 与 `detach` 把该连接移出启用集合并清掉其流式、待发与资源类型记录（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:43-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L43-L56)）
- `close` 取消存储订阅并清空全部连接状态（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:59-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L59-L65)）
- `Network.getResponseBody` 返回 base64 正文，并额外带 `dshInspectorTruncated` 与可选的 `dshInspectorCaptureError`（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:82-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L82-L90)）
- `Network.getRequestPostData` 以 UTF-8 返回请求体，并同样带截断与捕获错误标记（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:91-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L91-L98)）
- `Network.streamResourceContent` 在响应尚未完成时把该 requestId 记入该连接的流式集合，并返回已缓冲的 base64 数据（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:99-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L99-L108)）
- 缓存、Service Worker、额外头与清理类的五个方法一律返回空结果，其余 Network 方法抛出不支持错误（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:109-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L109-L117)）
- 请求被逐出时从三张连接本地表中删除该 requestKey，其余事件广播给所有已启用连接（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:120-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L120-L131)）
- 事件时间戳换算成 `(timestampMs - performance.timeOrigin) / 1000` 秒（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:133-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L133-L134)）
- 请求开始事件只暂存不立刻发出，等到响应或终结时才补发（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:136-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L136-L138)）
- 响应事件按 `text/event-stream` 判定资源类型为 EventSource，先补发开始事件再发 `Network.responseReceived`，EventSource 的编码长度填 -1（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:139-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L139-L161)）
- SSE 消息投影成 `Network.eventSourceMessageReceived`（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:162-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L162-L170)）
- 响应数据块发 `Network.dataReceived`，只有该连接请求过流式的 requestKey 才附带实际数据（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:171-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L171-L179)）
- 请求完成时补发开始事件、发带 `dshInspectorTruncated` 的 `Network.loadingFinished`，并停止跟踪该请求（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:180-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L180-L189)）
- 请求失败时补发开始事件、按记录的资源类型发 `Network.loadingFailed`（带取消标记），并停止跟踪（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:190-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L190-L202)）
- 未知事件类型经 `assertNever` 抛错（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:248-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L248-L250)）
- 补发开始事件只发一次并记下资源类型，发出的 `Network.requestWillBeSent` 用固定 loaderId 与 `dsh://host` 文档地址，wallTime 取毫秒除以 1000（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:208-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L208-L229)）
- 请求终结时从流式、待发与资源类型三张表中清除，并回收空集合（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:231-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L231-L237)）
- 头部投影用无原型对象承载，同名头以换行拼接成一个值（[packages/experimental/inspector/src/worker/cdp/domains/network/session.ts:240-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/network/session.ts#L240-L246)）

### packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts

CDP Runtime 参数的校验与归一化，被 Runtime 域会话在路由到具体 realm 前调用。

- `Runtime.evaluate` 走精确键白名单，`expression` 必须是字符串（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:45-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L45-L51)）
- `Runtime.evaluate` 的 `timeout` 必须是非负有限数，并在输出中改名为 `timeoutMs`（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:52-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L52-L72)）
- `Runtime.getProperties` 走白名单且 `objectId` 必须是字符串，其余四个开关按可选布尔读取（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:82-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L82-L101)）
- `Runtime.callFunctionOn` 走白名单且 `functionDeclaration` 必须是字符串（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:109-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L109-L115)）
- `objectId` 与执行上下文必须恰好给一个：两者都缺或都给都抛错（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:116-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L116-L125)）
- `arguments` 缺省为空数组，给出时必须是数组并逐项解析（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L126-L130)）
- `Runtime.awaitPromise` 走白名单且 `promiseObjectId` 必须是字符串（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:154-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L154-L167)）
- `Runtime.releaseObject` 与 `Runtime.releaseObjectGroup` 各自只允许一个字符串字段（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:174-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L174-L189)）
- `Runtime.globalLexicalScopeNames` 只允许 `executionContextId` 并复用上下文选择器校验（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:196-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L196-L199)）
- 调用参数必须是普通对象，`value`/`unserializableValue`/`objectId` 三者互斥，都不给时归一为 `undefined`，`value` 必须是 JSON 值（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:201-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L201-L219)）
- 上下文选择器要求数值是安全整数、`uniqueContextId` 是字符串，且两者互斥（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:221-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L221-L240)）
- `serializationOptions` 之类的可选对象字段必须同时是普通对象与 JSON 值（[packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts:248-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/cdp-params.ts#L248-L256)）

### packages/experimental/inspector/src/worker/cdp/domains/runtime/index.ts

Runtime 域会话类的再导出。

- 无运行期机制

### packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts

单个 CDP 连接内所有 realm 后端句柄与外部 RemoteObjectId 的映射与投影表。

- `setObserver` 在 Runtime 与 DOM 会话装配完成后装入语义对象识别回调（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L74-L76)）
- `resolve` 按连接本地 objectId 查回 realm 与后端句柄（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:83-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L83-L85)）
- `completion` 把结果与可选异常详情分别投影成 CDP 字段（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:94-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L94-L105)）
- `properties` 把普通、内部、私有三类属性与异常详情分别投影，缺失的分类不出现在结果中（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:114-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L114-L131)）
- Console 调用事件投影成 `Runtime.consoleAPICalled`，参数一律挂到 `console` 对象组，缺失的上下文 id 用合成 realm 的 id 补（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:143-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L143-L156)）
- 异常事件投影成 `Runtime.exceptionThrown`，同样把合成 realm 的上下文 id 补进异常详情（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:157-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L157-L168)）
- `realmsInGroup` 列出在某对象组下仍持有对象的去重 realm 集合（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:176-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L176-L182)）
- `release`、`releaseGroup`、`releaseRealm`、`clear` 分别按 objectId、对象组、realm 和整表丢弃映射（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:188-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L188-L215)）
- `remote` 只有值携带后端对象时才分配 objectId，只有同时具备 objectId 与语义引用时才询问观察者（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:229-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L229-L234)）
- 观察者返回的呈现字段覆盖原描述符的 subtype、className 与 description，objectId 存在时附加到结果上（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:235-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L235-L242)）
- 属性投影对 value、get、set、symbol 逐个递归调用远程对象投影，内部属性只投影 value，私有属性投影 value、get、set（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:245-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L245-L281)）
- 异常投影分配自增 `exceptionId`，合成 realm 附上执行上下文 id，并递归投影栈轨迹与异常对象（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:283-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L283-L295)）
- 暴露句柄时生成形如 `runtime:<连接 id>:<自增序号>` 的 objectId 并记录 realm、句柄与对象组（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:297-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L297-L308)）
- 栈轨迹投影对无脚本键的帧填 `'0'`，并递归投影父栈（[packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts:311-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/object-table.ts#L311-L323)）

### packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts

单个 DevTools 连接上的 Runtime 域路由器，把 CDP Runtime 方法分派到 Host 与 Client 两类 realm 会话，并维护连接局部的对象表，被 `cdp/session.ts` 构造并转发请求。

- 构造时按连接 id 建立对象表，并订阅 realm 会话集合的开合事件（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:34-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L34-L40)）
- `handle` 按方法名把 `Runtime.enable/disable/evaluate/getProperties/callFunctionOn/awaitPromise/releaseObject/releaseObjectGroup/globalLexicalScopeNames/discardConsoleEntries` 认领为本域处理，其余返回未认领（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:47-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L47-L85)）
- 未认领的 `Runtime.` 方法若其参数指向不支持原生域的 realm，则直接回送错误而不再向下游转发（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:75-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L75-L83)）
- `close` 取消 realm 订阅、释放全部 console 订阅、清空对象表与已宣告的上下文集合（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:88-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L88-L96)）
- `setObjectObserver` 把对象识别回调装入对象表，供 DOM 适配器绑定语义对象（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:102-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L102-L104)）
- `objectRoute` 将连接局部对象 id 解析为 realm 与后端句柄（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:111-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L111-L113)）
- `projectCompletion` 把别的域产生的完成结果经本连接对象表投影为 CDP 结果字段（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:122-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L122-L128)）
- `projectRemoteObject` 把单个 Runtime 值投影为 RemoteObject 字段并分配对象组（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:137-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L137-L143)）
- `releaseProjectedGroup` 丢弃某对象组下为其他域保留的连接局部 id（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:149-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L149-L151)）
- `nativeParameters` 递归遍历参数，将 `objectId` 及以 `ObjectId` 结尾的字段替换为原生后端句柄，遇到不支持原生域的 realm 抛出其理由（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:158-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L158-L171)）
- `resolveObject` 在指定源代对应的 realm 上求值表达式，源不在线或求值抛异常时报错，否则返回投影后的 RemoteObject（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:180-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L180-L195)）
- `enable` 并发启用全部 realm 的 Runtime 后端并逐个挂接 console、宣告上下文；任一失败则回滚已挂接的订阅、清空宣告集合并禁用全部后端后抛出（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:197-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L197-L214)）
- `disable` 先释放全部 console 订阅再禁用各 realm 后端，无论成败都清空对象表与宣告集合（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:216-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L216-L227)）
- `evaluate` 由 `contextId` 选出 realm，注入后端执行上下文后求值并投影完成结果（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:229-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L229-L237)）
- `getProperties` 仅在 `objectId` 是字符串且能解析出路由时认领请求，并把结果投影回该对象所属的对象组（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:239-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L239-L250)）
- `callFunction` 在接收者与显式执行上下文分属不同 realm 时回送错误；两者都缺省时落到 Host realm（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:252-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L252-L274)）
- `awaitPromise` 仅在 promise 对象 id 可解析时认领，并在该对象所属 realm 上等待（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:276-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L276-L287)）
- `releaseObject` 在后端释放句柄后同步从连接对象表删除该 id（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:289-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L289-L301)）
- `releaseObjectGroup` 向该组涉及的每个 realm 发出释放，并在 finally 中清除本地组记录（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:303-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L303-L312)）
- `globalLexicalScopeNames` 选出 realm 并带上后端上下文取回名字列表（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:314-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L314-L319)）
- `discardConsoleEntries` 清空各 realm 的 console 后端并释放名为 `console` 的对象组（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:321-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L321-L328)）
- `realmFromOptionalSelector` 用数字上下文 id 或 uniqueContextId 查找 realm；查不到时负数 id 或 `dsh-client:` 前缀抛"Client 上下文已不可用"，其余回退到 Host（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:337-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L337-L356)）
- `backendContext` 只对原生上下文的 realm 生成后端执行上下文字段，合成上下文一律不传（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:358-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L358-L369)）
- `routeArgument` 在对象参数不属于目标 realm 时抛错，禁止跨 realm 传对象（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:371-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L371-L381)）
- `unsupportedNativeRoute` 扫描上下文 id、uniqueContextId 与全部对象 id 字段，命中不支持原生域的 realm 时返回其理由文本（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:383-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L383-L405)）
- `receiveRealm` 在已 enable 时为新开 realm 启用后端并挂接 console、宣告上下文，启用失败则关闭该会话；realm 关闭时释放其 console 订阅与对象并发送销毁事件（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:407-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L407-L424)）
- `attachConsole` 为支持 console 的 realm 建立一次性订阅，把事件投影后推送到 transport，未 enable 时丢弃（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:426-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L426-L432)）
- `announce` 对合成上下文发送 `Runtime.executionContextCreated`，其名称为 `Client — <label>`、auxData 带 `type: 'dsh-client'` 与 sourceId（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:434-449](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L434-L449)）
- `destroy` 仅对曾宣告过的合成上下文发送 `Runtime.executionContextDestroyed`（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:451-460](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L451-L460)）
- `runtimeBackend` 在 realm 的 Runtime 能力为 unsupported 时抛出其理由（[packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts:471-474](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/domains/runtime/session.ts#L471-L474)）

### packages/experimental/inspector/src/worker/cdp/ids.ts

Worker 端 CDP 连接内各类标识的品牌类型与校验函数，被对象表、脚本表等 CDP 适配器使用。

- `cdpStringId` 拒绝空串与超过 16384 字符的字符串 id，并在错误消息中带上字段名（[packages/experimental/inspector/src/worker/cdp/ids.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/ids.ts#L37-L42)）
- `cdpNumericId` 要求安全整数且不小于 1，否则抛错（[packages/experimental/inspector/src/worker/cdp/ids.ts:50-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/ids.ts#L50-L53)）

### packages/experimental/inspector/src/worker/cdp/protocol.ts

Worker 侧最小 CDP 请求解析与响应发送工具，被 `cdp/session.ts` 和各域会话共用。

- `parseCdpRequest` 校验 id 为非负安全整数、method 为非空字符串、params 为对象，不合法即抛错；params 缺省补为空对象（[packages/experimental/inspector/src/worker/cdp/protocol.ts:29-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/protocol.ts#L29-L43)）
- `cdpError` 构造 `{id, error:{code, message}}` 形状的错误响应（[packages/experimental/inspector/src/worker/cdp/protocol.ts:52-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/protocol.ts#L52-L54)）
- `sendCdpFailure` 把任意抛出物渲染成消息并以 -32000 发回（[packages/experimental/inspector/src/worker/cdp/protocol.ts:62-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/protocol.ts#L62-L65)）
- `respondToCdpRequest` 把异步操作的兑现结果作为 `{id, result}` 发出，拒绝则转为错误响应（[packages/experimental/inspector/src/worker/cdp/protocol.ts:73-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/protocol.ts#L73-L82)）

### packages/experimental/inspector/src/worker/cdp/realm-sessions.ts

为单个 DevTools 连接维护"每个活跃 realm 恰好一个后端会话"的集合，由 `cdp/session.ts` 构造、被 Runtime/Debugger 等域订阅。

- 构造时为连接分配随机 `connectionId`，供各域与对象表共用（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L19)）
- 构造时为注册表中已存在的每个 realm 开一个会话，并订阅注册表后续变化（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L25-L28)）
- `all` 按注册表顺序（Host 在前、Client 在后）返回当前会话并过滤缺失项（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:34-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L34-L38)）
- `host` 在 Host 会话缺失时抛错而不是返回空（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:44-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L44-L48)）
- `byContextId` 经注册表把数字执行上下文 id 解析为本连接会话（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L55-L58)）
- `byUniqueContextId` 经注册表把唯一上下文 id 解析为本连接会话（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:65-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L65-L68)）
- `bySource` 把源代描述解析为本连接会话（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:75-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L75-L78)）
- `subscribe` 注册会话生命周期观察者并返回移除该观察者的 disposer（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:85-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L85-L88)）
- `close` 幂等地取消注册表订阅、关闭全部会话并清空监听者（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:91-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L91-L98)）
- `receiveRealm` 在 realm 开启时新建会话并广播 opened，在关闭时删除并关闭会话后广播 closed（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:100-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L100-L111)）
- `emit` 对监听者副本逐个派发并吞掉单个监听者的抛出，使兄弟域仍能收到事件（[packages/experimental/inspector/src/worker/cdp/realm-sessions.ts:119-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/realm-sessions.ts#L119-L127)）

### packages/experimental/inspector/src/worker/cdp/session.ts

一个 DevTools 连接的总分派器，按固定顺序把 CDP 请求交给 DOM、Runtime、Debugger、原生域、Network 与脚手架处理，由端点在每次 WebSocket 接入时创建。

- 构造时新建本连接的 realm 会话集合，Host realm 不支持原生域即抛错阻止连接建立（[packages/experimental/inspector/src/worker/cdp/session.ts:34-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L34-L37)）
- 构造时依次装配原生域、Runtime、Debugger、DOM 会话，并把 Runtime 的对象观察回调接到 DOM 的对象绑定（[packages/experimental/inspector/src/worker/cdp/session.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L37-L42)）
- 订阅源注册表状态变化，在诊断域已 enable 时推送 `DSHInspector.sourcesChanged`（[packages/experimental/inspector/src/worker/cdp/session.ts:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L43-L45)）
- `receive` 在请求无法解析时直接关闭该客户端连接（[packages/experimental/inspector/src/worker/cdp/session.ts:52-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L52-L59)）
- 对 `Runtime.releaseObject` 与 `Runtime.releaseObjectGroup` 先通知 DOM 会话释放其投影 id，再进入常规分派（[packages/experimental/inspector/src/worker/cdp/session.ts:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L61-L63)）
- 按 DOM、Runtime、Debugger 的顺序尝试认领请求，先认领者处理并终止分派（[packages/experimental/inspector/src/worker/cdp/session.ts:63-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L63-L65)）
- 原生域拥有的方法在转发前把参数中的连接局部对象 id 换成原生句柄（[packages/experimental/inspector/src/worker/cdp/session.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L66-L69)）
- `Network.` 前缀方法交给 Network 域并以本会话为事件汇（[packages/experimental/inspector/src/worker/cdp/session.ts:71-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L71-L72)）
- `DSHInspector.enable/disable` 切换本连接的诊断推送开关，`enable` 与 `getSources` 同时回送当前源清单（[packages/experimental/inspector/src/worker/cdp/session.ts:73-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L73-L81)）
- `DSHInspector.getCordisTree` 异步取树后单独回送 `{tree}`，失败时以 -32000 回送错误（[packages/experimental/inspector/src/worker/cdp/session.ts:81-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L81-L88)）
- 其余方法交给页面脚手架，返回未认领哨兵时以 -32601 回送 `Method not found`（[packages/experimental/inspector/src/worker/cdp/session.ts:89-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L89-L95)）
- 分派过程中的同步抛出统一转成 -32000 错误响应，不断开连接（[packages/experimental/inspector/src/worker/cdp/session.ts:97-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L97-L99)）
- `sendEvent` 以 `{method, params}` 形状推送 CDP 事件（[packages/experimental/inspector/src/worker/cdp/session.ts:103-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L103-L105)）
- `close` 按取消源订阅、脱离 Network、关闭 DOM/Runtime/Debugger/原生域、关闭 realm 会话集合的顺序释放资源（[packages/experimental/inspector/src/worker/cdp/session.ts:108-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/session.ts#L108-L116)）

### packages/experimental/inspector/src/worker/cdp/target.ts

合成页面目标的最小 CDP 脚手架，供 `cdp/session.ts` 在其他域都未认领时回答 Page/Target/Log/Console/Browser 类方法。

- `CDP_METHOD_NOT_HANDLED` 哨兵把"未认领"与"认领但返回空对象"区分开（[packages/experimental/inspector/src/worker/cdp/target.ts:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/target.ts#L6)）
- 构造一个固定的合成 frame，url 与 securityOrigin 均为 `dsh://host`（[packages/experimental/inspector/src/worker/cdp/target.ts:24-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/target.ts#L24-L34)）
- Page/Target/Log/Console 的若干 enable/disable 类方法一律回空对象成功（[packages/experimental/inspector/src/worker/cdp/target.ts:36-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/target.ts#L36-L45)）
- `Page.getFrameTree` 与 `Page.getResourceTree` 返回只含该合成 frame、无子 frame 与资源的树（[packages/experimental/inspector/src/worker/cdp/target.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/target.ts#L46-L49)）
- `Page.getNavigationHistory` 返回单条 `transitionType: 'typed'` 的历史记录（[packages/experimental/inspector/src/worker/cdp/target.ts:50-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/target.ts#L50-L54)）
- `Target.getTargetInfo` 用传入的目标描述回报 `type: 'page'`、已附着、不可访问 opener（[packages/experimental/inspector/src/worker/cdp/target.ts:55-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/target.ts#L55-L65)）
- `Browser.getVersion` 报告协议版本 1.3、固定产品/UA 串以及当前进程的 V8 版本（[packages/experimental/inspector/src/worker/cdp/target.ts:66-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/target.ts#L66-L73)）
- 其余方法返回未认领哨兵，交由调用方回 `Method not found`（[packages/experimental/inspector/src/worker/cdp/target.ts:74-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/cdp/target.ts#L74-L75)）

### packages/experimental/inspector/src/worker/entry.ts

Inspector Worker 线程的启动脚本，校验 workerData、启动 Worker 运行时，并通过 parentPort 与 Host 交换 ready/failure/stopped 控制消息。

- 在主线程被加载时直接抛错，拒绝在非 Worker 环境运行（[packages/experimental/inspector/src/worker/entry.ts:9-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/entry.ts#L9-L10)）
- 校验 workerData 为对象且 `hostSourcePort` 是 MessagePort，并解析 Worker 配置，不合法即抛错（[packages/experimental/inspector/src/worker/entry.ts:12-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/entry.ts#L12-L20)）
- `stop` 用一个共享 Promise 保证只关闭一次运行时，随后发出 `stopped` 并关闭控制端口（[packages/experimental/inspector/src/worker/entry.ts:25-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/entry.ts#L25-L32)）
- 控制端口收到消息时先校验协议，合法则触发停止，不合法则回送 `failure` 而不停机（[packages/experimental/inspector/src/worker/entry.ts:34-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/entry.ts#L34-L44)）
- 顶层等待运行时启动，成功时发出带端点信息的 `ready`，失败时发出 `failure` 并立即停机（[packages/experimental/inspector/src/worker/entry.ts:46-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/entry.ts#L46-L55)）

### packages/experimental/inspector/src/worker/inspection/cordis-query.ts

把已校验的 Inspector 查询命令在共享语义读取器上执行的单函数模块，被查询路由器调用。

- `executeInspectorQuery` 从读取器取树并以 `{op, tree}` 形状作为查询结果返回（[packages/experimental/inspector/src/worker/inspection/cordis-query.ts:12-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-query.ts#L12-L17)）

### packages/experimental/inspector/src/worker/inspection/cordis-store.ts

Worker 侧保存各源最新 Cordis 树快照的仓库，实现记录消费者接口，供 DOM 适配器与查询读取器读取。

- 声明只消费 `CORDIS_TREE_TOPIC` 主题的记录（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L50)）
- `replace` 用批次中的最新快照整体替换该源状态，批次无快照则移除该源，变更时广播 `snapshot-changed`（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:58-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L58-L64)）
- `append` 只在批次含更新快照且安装成功时广播变更，忽略无关主题（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:67-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L67-L70)）
- `close` 把该源代最后一棵树标记为 disconnected 并带上原因，把它移到断开队列尾部，超过 `maxDisconnectedTrees` 时按最早顺序删除，再广播 `source-disconnected`（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:73-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L73-L88)）
- `snapshots` 按源准入顺序返回去掉内部索引的快照列表（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:94-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L94-L96)）
- `tree` 把快照分成单个 host 槽与 clients 列表（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:102-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L102-L108)）
- `readTree` 用投影函数产出不带对象路由与 CDP 标识的语义树（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:114-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L114-L116)）
- `resolveObject` 只在源代匹配且连接未断开时按对象键查节点（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:124-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L124-L131)）
- `resolveObjectIdentity` 用 sourceId 与 generation 做同样的代与连接检查后解析对象（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:140-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L140-L151)）
- `resolveObjectInKind` 在同一 kind 的所有已连接源中查找首个命中的节点（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:159-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L159-L166)）
- `subscribe` 注册仓库观察者并返回移除它的 disposer（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:173-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L173-L176)）
- `latest` 按 `maxNodes` 校验并解析每条快照，取 revision 最大者，且当已存快照 revision 不低于候选时保留已存快照（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:178-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L178-L194)）
- `install` 在同代同快照且已连接时不做变更，否则写入新树并重建 `registryId\0handle` 到节点的索引（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:196-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L196-L212)）
- `remove` 同时从断开队列和树表中删除一个源（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:214-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L214-L217)）
- `emit` 逐个通知监听者副本并吞掉单个监听者的抛出（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:223-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L223-L231)）
- `objectKey` 以 NUL 分隔注册表 id 与句柄组成索引键（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:234-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L234-L236)）
- `treeNodes` 用显式栈按前序展开整棵树，避免递归（[packages/experimental/inspector/src/worker/inspection/cordis-store.ts:238-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/cordis-store.ts#L238-L248)）

### packages/experimental/inspector/src/worker/inspection/network-store.ts

Worker 侧的网络观察仓库，把各源上报的 fetch 记录规范化为请求生命周期事件与捕获的报文体，并按条数与字节数做有界保留，供 Network 域读取与订阅。

- 声明消费全部 `FETCH_TOPICS` 主题（[packages/experimental/inspector/src/worker/inspection/network-store.ts:94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L94)）
- `replace` 先以"source state replaced"关闭该源的在途请求，再按追加方式摄入新记录（[packages/experimental/inspector/src/worker/inspection/network-store.ts:103-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L103-L106)）
- `append` 逐条摄入并吞掉单条记录的解析失败，使后续记录继续被接受（[packages/experimental/inspector/src/worker/inspection/network-store.ts:108-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L108-L117)）
- `close` 把该源所有未完成请求标记为完成并发布带原因的 `request-failed`（canceled 为真），随后执行保留策略（[packages/experimental/inspector/src/worker/inspection/network-store.ts:119-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L119-L134)）
- `replay` 返回按观察顺序保留的请求生命周期事件日志，供新连接重放（[packages/experimental/inspector/src/worker/inspection/network-store.ts:140-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L140-L142)）
- `subscribe` 注册实时变更消费者并返回移除它的 disposer（[packages/experimental/inspector/src/worker/inspection/network-store.ts:149-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L149-L152)）
- `requestBody` 按公开 requestId 返回拼接后的请求体字节及截断与捕获错误元数据（[packages/experimental/inspector/src/worker/inspection/network-store.ts:159-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L159-L162)）
- `responseBody` 在响应头尚未到达时抛错，否则返回响应体与其元数据（[packages/experimental/inspector/src/worker/inspection/network-store.ts:169-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L169-L173)）
- `dispose` 清空监听者、请求表、日志与已用字节计数（[packages/experimental/inspector/src/worker/inspection/network-store.ts:176-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L176-L182)）
- 摄入时以 `sourceId:generation:localId` 组成请求键，并把源时间原点与记录单调时间相加为绝对时间戳（[packages/experimental/inspector/src/worker/inspection/network-store.ts:184-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L184-L188)）
- `fetch/start` 在请求键已存在时抛错，否则建条目并发布 `request-started`（含 url、method、headers、hasBody）后执行保留策略（[packages/experimental/inspector/src/worker/inspection/network-store.ts:189-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L189-L220)）
- 后续记录若找不到对应请求（已被逐出或未开始）则静默丢弃（[packages/experimental/inspector/src/worker/inspection/network-store.ts:221-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L221-L222)）
- `fetch/request-body-end` 合并请求体截断标记与捕获错误（[packages/experimental/inspector/src/worker/inspection/network-store.ts:227-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L227-L232)）
- `fetch/response` 标记响应已见，按小写 mimeType 是否为 `text/event-stream` 决定是否建立 SSE 解析器，并发布 `response-received`（[packages/experimental/inspector/src/worker/inspection/network-store.ts:233-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L233-L250)）
- `fetch/response-body-chunk` 追加响应体，把 SSE 解析器产出的每条消息以递增 eventId 发布为 `event-source-message`，再发出不入日志的 `response-data`（[packages/experimental/inspector/src/worker/inspection/network-store.ts:251-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L251-L267)）
- `fetch/end` 合并响应截断与捕获错误后完成请求，`encodedDataLength` 取实际保留字节数（[packages/experimental/inspector/src/worker/inspection/network-store.ts:268-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L268-L281)）
- `fetch/error` 对未完成请求发布 `request-failed`，且在响应头已到达时把响应体标记为截断并记下错误文本（[packages/experimental/inspector/src/worker/inspection/network-store.ts:282-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L282-L298)）
- `appendBody` 解码 base64、先逐出已完成请求腾出预算，再按剩余 `maxJournalBytes` 截断保留，并累加截断标记与已用字节（[packages/experimental/inspector/src/worker/inspection/network-store.ts:302-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L302-L318)）
- `complete` 保证每个请求只发布一次终态事件并把它推入已完成队列（[packages/experimental/inspector/src/worker/inspection/network-store.ts:320-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L320-L326)）
- `publish` 把事件写入可重放日志后再广播，`emit` 只广播（[packages/experimental/inspector/src/worker/inspection/network-store.ts:328-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L328-L331)）
- `emit` 逐个通知监听者副本并吞掉单个监听者的抛出（[packages/experimental/inspector/src/worker/inspection/network-store.ts:333-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L333-L341)）
- `enforceRetention` 在超出请求条数或日志字节上限时优先逐出最早完成的请求，必要时逐出最早的在途请求并先发布"retained-request limit exceeded"的取消事件（[packages/experimental/inspector/src/worker/inspection/network-store.ts:343-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L343-L360)）
- `evictCompletedFor` 为新到字节腾空间时跳过当前受保护的请求键，无可逐出者则直接返回（[packages/experimental/inspector/src/worker/inspection/network-store.ts:362-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L362-L369)）
- `evict` 归还字节额度、删除请求条目、从日志中抹掉该请求的全部事件并广播 `request-evicted`（[packages/experimental/inspector/src/worker/inspection/network-store.ts:371-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L371-L378)）
- `requestById` 对非字符串 id 与找不到的 id 分别抛出不同错误文本（[packages/experimental/inspector/src/worker/inspection/network-store.ts:380-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L380-L385)）
- `decodeBase64` 用长度、字符集正则和回编码比对三重检查拒绝非规范 base64（[packages/experimental/inspector/src/worker/inspection/network-store.ts:402-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L402-L409)）
- 字段取值函数对非对象载荷、非字符串、非有限数、非布尔、非二元字符串数组的 header 分别抛出具名错误（[packages/experimental/inspector/src/worker/inspection/network-store.ts:411-449](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/network-store.ts#L411-L449)）

### packages/experimental/inspector/src/worker/inspection/query-router.ts

Worker 侧非 CDP 查询协议的准入、执行与有界回送，为 Host MessagePort 与 Client WebSocket 各建一个隔离的查询 peer。

- `open` 建立 peer 并在注册回调中先摘掉该 peer 名下的旧源，再把该源代独占绑定到它（[packages/experimental/inspector/src/worker/inspection/query-router.ts:52-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L52-L74)）
- 注册校验回调要求 peer 与 generation 同时匹配，才认为该源仍归此 peer（[packages/experimental/inspector/src/worker/inspection/query-router.ts:63-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L63-L64)）
- `disconnect` 只在世代匹配时撤销该源的查询访问权（[packages/experimental/inspector/src/worker/inspection/query-router.ts:80-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L80-L85)）
- `close` 关闭全部 peer 并清空源到 peer 的映射（[packages/experimental/inspector/src/worker/inspection/query-router.ts:88-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L88-L91)）
- `accept` 记录被准入的源代、清空在途请求并向路由器注册（[packages/experimental/inspector/src/worker/inspection/query-router.ts:114-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L114-L119)）
- `revoke` 只在 sourceId 与 generation 都匹配时清掉准入状态与在途请求，载体本身保留待后续重新准入（[packages/experimental/inspector/src/worker/inspection/query-router.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L126-L130)）
- `receive` 先判定是否查询协议信封，不是则交回调用方（[packages/experimental/inspector/src/worker/inspection/query-router.ts:137-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L137-L139)）
- 请求帧解析失败或 JSON 字节数超过 `maxFrameBytes` 时走 malformed 拒绝路径（[packages/experimental/inspector/src/worker/inspection/query-router.ts:140-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L140-L148)）
- 未准入、已关闭、注册失效或源代与帧不符时回 `stale-source` 错误（[packages/experimental/inspector/src/worker/inspection/query-router.ts:149-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L149-L155)）
- requestId 已在途时回 `invalid-request`，否则登记在途并异步执行（[packages/experimental/inspector/src/worker/inspection/query-router.ts:156-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L156-L162)）
- `close` 幂等地清空准入与在途状态并从路由器注销（[packages/experimental/inspector/src/worker/inspection/query-router.ts:166-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L166-L172)）
- `execute` 执行查询后先过 `canReply` 门，成功响应超过帧上限时改回 `result-too-large`，抛错时回 `internal-error`，finally 中清理在途登记（[packages/experimental/inspector/src/worker/inspection/query-router.ts:174-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L174-L196)）
- `rejectMalformed` 先尝试从原值抽出帧身份以定向回错，抽不出则以 1008 关闭载体（[packages/experimental/inspector/src/worker/inspection/query-router.ts:198-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L198-L205)）
- `sendFailure` 构造带协议版本的错误响应帧，连错误帧都超限时以 1009 关闭载体（[packages/experimental/inspector/src/worker/inspection/query-router.ts:207-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L207-L226)）
- `canReply` 要求未关闭、准入对象未换、注册仍有效且该 requestId 仍绑定同一准入，才允许回送（[packages/experimental/inspector/src/worker/inspection/query-router.ts:228-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L228-L233)）
- `deliver` 在发送抛错时以 1011 关闭载体（[packages/experimental/inspector/src/worker/inspection/query-router.ts:235-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L235-L241)）
- `rejectTransport` 先关闭 peer 再关载体，并把关闭原因截断到 123 字节（[packages/experimental/inspector/src/worker/inspection/query-router.ts:243-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/query-router.ts#L243-L250)）

### packages/experimental/inspector/src/worker/inspection/realm-store.ts

Worker 侧 Host 与 Client realm 的权威注册表，随 Client 目标的接入与断开增删 realm，并广播给每个 DevTools 连接。

- 构造时为已有的每个 Client 目标建 realm，并订阅目标路由器的后续变化（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:20-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L20-L27)）
- `realms` 固定以 Host 在前、Client 按插入顺序在后的次序返回（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:33-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L33-L35)）
- `byContextId` 只在 Client realm 的合成上下文中按数字 id 查找（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:42-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L42-L47)）
- `byUniqueContextId` 只在 Client realm 的合成上下文中按唯一 id 查找（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:54-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L54-L59)）
- `bySource` 对 host 源直接返回 Host realm，对 client 源要求 generation 一致才返回（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L66-L70)）
- `subscribe` 注册 realm 增删观察者并返回移除它的 disposer（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:77-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L77-L80)）
- `close` 取消目标订阅并清空 Client realm 表与监听者（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:83-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L83-L87)）
- `receiveClient` 在关闭事件里要求 realm 仍绑定同一 target 才删除并广播，避免误删重连后的新 realm（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:89-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L89-L99)）
- `openClient` 用目标、Runtime 路由器与源路由器构造 Client realm 并按 sourceId 入表（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:101-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L101-L105)）
- `emit` 逐个通知监听者副本并吞掉单个连接的抛出（[packages/experimental/inspector/src/worker/inspection/realm-store.ts:107-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/inspection/realm-store.ts#L107-L115)）

### packages/experimental/inspector/src/worker/inspection/realm.ts

realm 描述、执行上下文归属、能力槽与会话接口的类型定义文件，被 Host/Client realm 实现与注册表引用。

- 无运行期机制

### packages/experimental/inspector/src/worker/realms/client/bridge.ts

把一个 Client 源代与能寻址它的 Worker 桥接服务打包成不可变记录的小工具，被 Client realm 构造函数使用。

- 无运行期机制

### packages/experimental/inspector/src/worker/realms/client/console.ts

Client realm 的 ConsoleBackend 实现，把会话局部的 Client Console 事件转换成 realm 中立的 Runtime 值。

- `subscribe` 经路由器建立会话级 Console 订阅，并在回调中把 Client 事件与脚本键映射成通用 Console 事件（[packages/experimental/inspector/src/worker/realms/client/console.ts:22-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/console.ts#L22-L31)）
- 返回的 disposer 先从集合中摘除自身、摘除失败即不重复调用底层 disposer（[packages/experimental/inspector/src/worker/realms/client/console.ts:27-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/console.ts#L27-L30)）
- `clear` 为空实现，Client 侧不清空控制台条目（[packages/experimental/inspector/src/worker/realms/client/console.ts:33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/console.ts#L33)）
- `close` 释放本连接的全部 Console 订阅（[packages/experimental/inspector/src/worker/realms/client/console.ts:35-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/console.ts#L35-L39)）

### packages/experimental/inspector/src/worker/realms/client/debugger.ts

声明 Client realm 不提供调试后端的单函数模块，被 Client realm 的每个会话使用。

- 返回 state 为 `unsupported`、理由为"Client native debugging is unavailable"的能力槽，使 Debugger 操作在 Client realm 上以该文本失败（[packages/experimental/inspector/src/worker/realms/client/debugger.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/debugger.ts#L9-L11)）

### packages/experimental/inspector/src/worker/realms/client/index.ts

Client realm 定义，按目标声明的能力装配 Runtime、Console、Sources 后端，并为每个 DevTools 连接开一套隔离会话。

- 固定列出 Client realm 支持的七个 Runtime 操作名（[packages/experimental/inspector/src/worker/realms/client/index.ts:15-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/index.ts#L15-L23)）
- 构造时分配随机 realmId，并从目标源继承 sourceId、generation 与 label（[packages/experimental/inspector/src/worker/realms/client/index.ts:38-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/index.ts#L38-L45)）
- 上下文固定为合成类型，其 id、uniqueId、origin 取自目标（[packages/experimental/inspector/src/worker/realms/client/index.ts:46-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/index.ts#L46-L51)）
- 按目标是否声明 `client-console` / `client-sources` 能力决定对外公布的 console 与 sources 操作集，debugger 一律为空（[packages/experimental/inspector/src/worker/realms/client/index.ts:53-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/index.ts#L53-L58)）
- `openSession` 为每个连接分配新的 Runtime 会话 id 与 Source 会话 id，并按能力条件构造对应后端（[packages/experimental/inspector/src/worker/realms/client/index.ts:67-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/index.ts#L67-L80)）
- 缺失能力时以带具体理由的 unsupported 槽返回，原生域一律标为"Client realm has no native CDP transport"（[packages/experimental/inspector/src/worker/realms/client/index.ts:85-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/index.ts#L85-L92)）
- 会话 `close` 按 console、sources、runtime 的顺序释放后端（[packages/experimental/inspector/src/worker/realms/client/index.ts:93-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/index.ts#L93-L97)）
- `supports` 在源能力列表中按 type 判定某项能力是否存在（[packages/experimental/inspector/src/worker/realms/client/index.ts:102-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/index.ts#L102-L104)）

### packages/experimental/inspector/src/worker/realms/client/runtime.ts

Client realm 的 RuntimeBackend 实现，把通用 Runtime 请求翻译成 Client 线路命令并把结果转回中立值。

- `enable` 为空操作，`disable` 关闭该连接在目标上的 Runtime 会话（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:33-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L33-L40)）
- `evaluate` 先做选项断言，再剔除 context、throwOnSideEffect、serializationOptions 三个字段后发出 `evaluate` 命令（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:42-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L42-L54)）
- `getProperties` 把句柄改写成 Client 线路句柄，并把属性、内部属性与异常详情逐一转成中立值（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:56-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L56-L76)）
- `callFunction` 断言选项后剔除不支持字段，并把接收者与每个对象实参改写成 Client 句柄（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:78-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L78-L98)）
- `awaitPromise` 把 promise 句柄改写为 Client 句柄后发出命令并转换完成结果（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:100-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L100-L109)）
- `globalLexicalScopeNames` 在传入原生执行上下文时抛错（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:111-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L111-L114)）
- `releaseObject` 与 `releaseObjectGroup` 分别发出对应的 Client 释放命令（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:116-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L116-L122)）
- `close` 幂等地置关闭标志并关闭目标会话（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:125-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L125-L129)）
- `request` 在已关闭时直接以"Client realm session is closed"拒绝，不再发出线路请求（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:131-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L131-L134)）
- `expectResult` 在返回的 op 与请求 op 不符时抛错（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:141-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L141-L147)）
- `assertClientEvaluationOptions` 逐项拒绝原生上下文、throwOnSideEffect、serializationOptions、disableBreaks、绕过 CSP，并要求 timeout 仅在 awaitPromise 时可用（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:149-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L149-L160)）
- `assertClientCallOptions` 拒绝原生上下文、throwOnSideEffect、serializationOptions 与 userGesture（[packages/experimental/inspector/src/worker/realms/client/runtime.ts:162-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/runtime.ts#L162-L167)）

### packages/experimental/inspector/src/worker/realms/client/scripts.ts

在一个 Client realm 内为脚本分配稳定公开键的映射表，被该 realm 的 Runtime、Console、Sources 后端共用。

- `toRuntime` 对首次见到的 Client 本地键分配形如 `client:<上下文绝对值>:<序号>` 的公开脚本键并缓存，重复查询返回同一键（[packages/experimental/inspector/src/worker/realms/client/scripts.ts:17-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/scripts.ts#L17-L26)）

### packages/experimental/inspector/src/worker/realms/client/sources.ts

Client realm 的只读源码后端，通过分块传输协议取回脚本目录、源码与 source map。

- `listScripts` 在会话已关闭时抛错，否则把目录加载 Promise 记忆化，只请求一次（[packages/experimental/inspector/src/worker/realms/client/sources.ts:29-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L29-L33)）
- `getScriptSource` 在内容不可用时抛"Client script source is unavailable"（[packages/experimental/inspector/src/worker/realms/client/sources.ts:35-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L35-L40)）
- `getSourceMap` 在内容不可用时返回 undefined 而非抛错（[packages/experimental/inspector/src/worker/realms/client/sources.ts:42-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L42-L45)）
- `subscribe` 返回空 disposer，不推送新发现的脚本（[packages/experimental/inspector/src/worker/realms/client/sources.ts:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L47-L49)）
- `close` 幂等地关闭源会话并清空脚本路由表（[packages/experimental/inspector/src/worker/realms/client/sources.ts:52-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L52-L57)）
- `register` 把 Client 本地脚本键换成 realm 公开键，并给描述符补上该目标的 executionContextId（[packages/experimental/inspector/src/worker/realms/client/sources.ts:68-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L68-L77)）
- `route` 先确保目录已加载，再对未知脚本键抛"Client script is no longer available"（[packages/experimental/inspector/src/worker/realms/client/sources.ts:79-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L79-L84)）
- `read` 按 `chunkBytes` 循环拉取内容块，并对超块长、nextOffset 不连续、非 eof 却零推进、超过 `maxContentBytes` 四种情况抛错终止（[packages/experimental/inspector/src/worker/realms/client/sources.ts:86-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L86-L111)）
- 拼接后的字节用 fatal 模式的 UTF-8 解码，非法编码即抛错（[packages/experimental/inspector/src/worker/realms/client/sources.ts:112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L112)）
- `expectResult` 在返回的 op 与请求 op 不符时抛错（[packages/experimental/inspector/src/worker/realms/client/sources.ts:116-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/sources.ts#L116-L122)）

### packages/experimental/inspector/src/worker/realms/client/values.ts

把 Client 线路上的 Runtime 值、属性、异常、Console 事件与栈帧转换成 realm 中立表示的纯函数集合，被 Client 的 Runtime 与 Console 后端调用。

- `clientCompletion` 转换结果对象并在存在时附上转换后的异常详情（[packages/experimental/inspector/src/worker/realms/client/values.ts:33-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/values.ts#L33-L43)）
- `clientProperty` 分别转换 value、get、set、symbol 四个可选对象槽，缺省者不出现在结果中（[packages/experimental/inspector/src/worker/realms/client/values.ts:50-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/values.ts#L50-L61)）
- `clientInternalProperty` 只保留 name 与可选 value（[packages/experimental/inspector/src/worker/realms/client/values.ts:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/values.ts#L68-L75)）
- `clientException` 转换栈轨迹与异常对象后并入其余字段（[packages/experimental/inspector/src/worker/realms/client/values.ts:83-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/values.ts#L83-L93)）
- `clientConsoleEvent` 对 `console-api` 事件逐个转换实参与栈轨迹，对异常事件转换其详情（[packages/experimental/inspector/src/worker/realms/client/values.ts:101-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/values.ts#L101-L121)）
- `clientRemoteObject` 保留描述符，把 Client 句柄改写为后端句柄槽，并透传可选的语义引用（[packages/experimental/inspector/src/worker/realms/client/values.ts:128-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/values.ts#L128-L138)）
- `clientHandle` 与 `backendHandle` 把同一段文本在两种句柄角色间改换品牌并经 `inspectorId` 校验（[packages/experimental/inspector/src/worker/realms/client/values.ts:145-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/values.ts#L145-L151)）
- `clientStackTrace` 对每个调用帧映射脚本键，并递归转换 parent 链（[packages/experimental/inspector/src/worker/realms/client/values.ts:153-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/client/values.ts#L153-L162)）

### packages/experimental/inspector/src/worker/realms/host/bridge.ts

每个 DevTools 连接到主线程真实 V8 inspector 目标的载体，另含把原生通知串行投影给多个消费者的通道类。

- 构造时挂上 `inspectorNotification` 监听，先改写上下文名再逐个派发给订阅者，并吞掉单个订阅者的抛出（[packages/experimental/inspector/src/worker/realms/host/bridge.ts:28-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/bridge.ts#L28-L38)）
- `subscribe` 注册原生通知消费者并返回移除它的 disposer（[packages/experimental/inspector/src/worker/realms/host/bridge.ts:45-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/bridge.ts#L45-L48)）
- `request` 在首次调用时才连接主线程，连接失败则以缓存的失败理由拒绝，并把 post 的同步抛出也转成拒绝（[packages/experimental/inspector/src/worker/realms/host/bridge.ts:56-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/bridge.ts#L56-L69)）
- `close` 清空订阅者，仅在已连接且无失败时断开底层会话并吞掉重复断开的抛出（[packages/experimental/inspector/src/worker/realms/host/bridge.ts:72-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/bridge.ts#L72-L81)）
- `connect` 只尝试一次 `connectToMainThread`，失败时把理由记为"Host V8 inspector is unavailable: …"（[packages/experimental/inspector/src/worker/realms/host/bridge.ts:83-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/bridge.ts#L83-L92)）
- `rewriteContextName` 只对 `isDefault` 为真的 `Runtime.executionContextCreated` 通知把上下文 name 换成构造时传入的标签（[packages/experimental/inspector/src/worker/realms/host/bridge.ts:94-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/bridge.ts#L94-L111)）
- `HostNotificationChannel` 构造时按 accept 谓词过滤原生通知（[packages/experimental/inspector/src/worker/realms/host/bridge.ts:120-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/bridge.ts#L120-L126)）
- 通道的 `close` 取消原生订阅并清空自身消费者（[packages/experimental/inspector/src/worker/realms/host/bridge.ts:139-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/bridge.ts#L139-L142)）
- 通道的 `receive` 把投影串在一条 Promise 链上以保序，投影返回 undefined 则丢弃，投影抛出被 catch 吞掉不影响请求处理（[packages/experimental/inspector/src/worker/realms/host/bridge.ts:144-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/bridge.ts#L144-L159)）

### packages/experimental/inspector/src/worker/realms/host/console.ts

Host realm 的 ConsoleBackend，把原生 `Runtime.consoleAPICalled` 与 `Runtime.exceptionThrown` 通知转成 realm 中立 Console 事件。

- 用固定的 18 项类型集合限定被接受的 console 调用类型（[packages/experimental/inspector/src/worker/realms/host/console.ts:14-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/console.ts#L14-L17)）
- 构造时建立只接受 `Runtime.consoleAPICalled` 与 `Runtime.exceptionThrown` 的通知通道并分别投影（[packages/experimental/inspector/src/worker/realms/host/console.ts:27-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/console.ts#L27-L33)）
- `clear` 向原生会话发出 `Runtime.discardConsoleEntries`（[packages/experimental/inspector/src/worker/realms/host/console.ts:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/console.ts#L45-L47)）
- `close` 关闭通知通道（[packages/experimental/inspector/src/worker/realms/host/console.ts:50-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/console.ts#L50-L52)）
- `consoleEvent` 在类型不在集合内、args 非数组或 timestamp 非数字时返回 undefined 丢弃该通知（[packages/experimental/inspector/src/worker/realms/host/console.ts:54-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/console.ts#L54-L61)）
- `consoleEvent` 并发把每个实参转成 RemoteObject，并按存在与否补上 contextId 与转换后的栈轨迹（[packages/experimental/inspector/src/worker/realms/host/console.ts:62-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/console.ts#L62-L71)）
- `exceptionEvent` 在 timestamp 非数字或缺 exceptionDetails 时丢弃，否则转换异常详情并附上可选 contextId（[packages/experimental/inspector/src/worker/realms/host/console.ts:74-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/console.ts#L74-L89)）

### packages/experimental/inspector/src/worker/realms/host/debugger.ts

Host realm 的 DebuggerBackend，把通用调试命令转发到原生 inspector 会话，并把 paused/resumed/breakpointResolved 通知转成中立事件。

- 构造时建立只接受 `Debugger.resumed`、`Debugger.breakpointResolved`、`Debugger.paused` 三种通知的通道并分别投影（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:26-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L26-L36)）
- `enable` 只在给定时传 `maxScriptsCacheSize`（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:39-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L39-L43)）
- `disable` 与 `pause` 直接转发对应原生方法（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:45-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L45-L51)）
- `resume` 只在给定时传 `terminateOnResume`（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:53-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L53-L57)）
- `evaluateOnCallFrame` 逐项映射可选选项、把 `timeoutMs` 改名为原生 `timeout`，并把结果经 Runtime 后端转成中立完成结果（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:59-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L59-L73)）
- `close` 关闭通知通道（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:80-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L80-L82)）
- `paused` 在 callFrames 非数组或 reason 非字符串时丢弃该通知，否则并发转换全部调用帧并按需带上 data、hitBreakpoints、asyncStackTrace（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:84-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L84-L103)）
- `callFrame` 校验 callFrameId、functionName、url 与 scopeChain 后转换作用域链、this 与返回值（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:105-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L105-L123)）
- `scope` 校验 type 后转换其对象并按需带上 name 与起止位置（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:125-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L125-L135)）
- `breakpointResolved` 在缺 breakpointId 或 location 时丢弃该通知（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:139-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L139-L148)）
- `location` 要求 scriptId 为字符串、lineNumber 为安全整数、columnNumber 若存在也须为安全整数，并把 scriptId 转为脚本键（[packages/experimental/inspector/src/worker/realms/host/debugger.ts:150-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/debugger.ts#L150-L163)）

### packages/experimental/inspector/src/worker/realms/host/index.ts

Host realm 定义，为每个 DevTools 连接开一条独立的原生 V8 inspector 会话并装配四类后端。

- 固定公布 Host realm 的 Runtime、console、sources、debugger 四组能力清单（[packages/experimental/inspector/src/worker/realms/host/index.ts:12-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/index.ts#L12-L31)）
- 上下文固定为原生类型（[packages/experimental/inspector/src/worker/realms/host/index.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/index.ts#L25)）
- 构造时把 sourceId 固定为 `host-runtime`，realmId 与 generation 各取一个随机 UUID（[packages/experimental/inspector/src/worker/realms/host/index.ts:33-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/index.ts#L33-L41)）
- `openSession` 新建原生会话并在其上装配 Runtime、Console、Sources、Debugger 后端，原生域后端即该会话本身（[packages/experimental/inspector/src/worker/realms/host/index.ts:44-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/index.ts#L44-L57)）
- 会话 `close` 按 sources、debugger、console、runtime、原生会话的顺序释放（[packages/experimental/inspector/src/worker/realms/host/index.ts:58-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/index.ts#L58-L64)）

### packages/experimental/inspector/src/worker/realms/host/runtime.ts

Host realm 的 RuntimeBackend，把通用 Runtime 请求转成原生 CDP 调用，并把原生返回值校验、规范化为中立模型，同时为对象附加 Cordis 语义引用。

- 构造时订阅原生通知以跟踪默认执行上下文（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:31-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L31-L33)）
- `enable` 与 `disable` 转发原生方法，`disable` 后清掉缓存的默认上下文 id（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:35-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L35-L42)）
- `evaluate` 逐项映射十余个可选选项并把 `timeoutMs` 改名为原生 `timeout`（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:44-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L44-L62)）
- `getProperties` 把通用 handle 映射到原生 objectId 并转换返回的属性集合（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:64-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L64-L73)）
- `callFunction` 无接收者时回落到缓存的默认执行上下文，仍取不到则抛"Host Runtime default execution context is unavailable"（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:75-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L75-L85)）
- `awaitPromise` 把通用 promise 句柄映射为原生 `promiseObjectId`（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:98-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L98-L104)）
- `globalLexicalScopeNames` 在返回值不是全字符串数组时抛错（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:106-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L106-L114)）
- `releaseObject` 与 `releaseObjectGroup` 转发对应原生释放方法（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:116-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L116-L122)）
- `close` 取消原生上下文观察订阅（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:125-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L125-L127)）
- `completion` 转换结果对象并按需附上异常详情（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:134-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L134-L141)）
- `properties` 在 result 非数组时抛错，并按需转换 internal/private 属性与异常详情（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:143-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L143-L157)）
- `property` 要求 name 为字符串、configurable 与 enumerable 为布尔，并转换 value/get/set/symbol 四个对象槽（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:159-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L159-L176)）
- `internalProperties` 与 `privateProperties` 各自校验数组与 name 字段并转换其对象槽（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:178-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L178-L202)）
- `exceptionDetails` 要求 text 为字符串、行列号为安全整数，并转换栈轨迹与异常对象（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:209-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L209-L224)）
- `remoteObject` 从描述符中删掉 `objectId`、要求剩余部分是 JSON 值，并对有句柄的对象追加语义引用（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:231-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L231-L244)）
- `stackTrace` 逐帧校验 functionName、url 与行列号，把 scriptId 转成脚本键，并递归处理 parent（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:251-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L251-L276)）
- `observeContext` 在 `isDefault` 的上下文创建通知里记住默认上下文 id，在其销毁通知里清除（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:278-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L278-L289)）
- `identifyObject` 以 silent、returnByValue 的方式在目标对象上调用固定的识别函数取回语义引用，抛异常或有 exceptionDetails 时返回 undefined 而不影响原值（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:291-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L291-L307)）
- `nativeContext` 按上下文种类生成数字上下文字段或 `uniqueContextId` 字段（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:314-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L314-L320)）
- `toNativeArgument` 把四种调用实参分别映射为 value、unserializableValue、objectId 或空对象，未知种类走 `assertNever` 抛错（[packages/experimental/inspector/src/worker/realms/host/runtime.ts:322-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/runtime.ts#L322-L338)）

### packages/experimental/inspector/src/worker/realms/host/scripts.ts

把 Node 原生 inspector 脚本 id 转成 realm 后端脚本键的单函数模块，被 Host 的 sources、debugger、runtime 共用。

- `hostScriptKey` 经 `inspectorId` 校验后把原生 scriptId 直接品牌为脚本键（[packages/experimental/inspector/src/worker/realms/host/scripts.ts:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/scripts.ts#L11-L13)）

### packages/experimental/inspector/src/worker/realms/host/sources.ts

Host realm 的 SourceBackend，从原生 `Debugger.scriptParsed` 通知维护连接局部脚本目录，并按需取回源码。

- 构造时订阅原生通知以接收脚本解析事件（[packages/experimental/inspector/src/worker/realms/host/sources.ts:20-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L20-L24)）
- `listScripts` 返回当前已缓存目录的描述符快照（[packages/experimental/inspector/src/worker/realms/host/sources.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L26-L28)）
- `getScriptSource` 对未知脚本键抛错，并在原生返回值缺 `scriptSource` 时抛错（[packages/experimental/inspector/src/worker/realms/host/sources.ts:30-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L30-L36)）
- `getSourceMap` 一律返回 undefined（[packages/experimental/inspector/src/worker/realms/host/sources.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L38-L40)）
- `subscribe` 注册新脚本消费者并返回移除它的 disposer（[packages/experimental/inspector/src/worker/realms/host/sources.ts:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L47-L50)）
- `close` 取消原生订阅并清空目录与消费者（[packages/experimental/inspector/src/worker/realms/host/sources.ts:53-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L53-L57)）
- `receive` 只处理 `Debugger.scriptParsed`，且在 scriptId、url 与四个起止行列号任一不合法时整条丢弃（[packages/experimental/inspector/src/worker/realms/host/sources.ts:59-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L59-L68)）
- 构造脚本描述符时把缺失的 hash 补为空串，并按存在与否带上 buildId、非空 sourceMapURL、executionContextId、isModule、length（[packages/experimental/inspector/src/worker/realms/host/sources.ts:69-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L69-L86)）
- 入表后逐个通知消费者并吞掉单个消费者的抛出（[packages/experimental/inspector/src/worker/realms/host/sources.ts:87-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L87-L93)）
- `isInteger` 要求安全整数且非负（[packages/experimental/inspector/src/worker/realms/host/sources.ts:97-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/sources.ts#L97-L99)）

### packages/experimental/inspector/src/worker/realms/host/values.ts

针对 Node 原生 Inspector 协议返回值的小型校验与字段拼装工具，被 Host 的 runtime、console、debugger 后端共用。

- `isNativeRecord` 判定值为非数组的对象记录（[packages/experimental/inspector/src/worker/realms/host/values.ts:8-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/values.ts#L8-L10)）
- `requireNativeRecord` 在不是对象记录时以带标签的消息抛错（[packages/experimental/inspector/src/worker/realms/host/values.ts:18-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/values.ts#L18-L21)）
- `optionalNativeField` 在值为 undefined 时产出空记录，从而让该字段完全不出现在原生请求里（[packages/experimental/inspector/src/worker/realms/host/values.ts:29-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/realms/host/values.ts#L29-L34)）

### packages/experimental/inspector/src/worker/server.ts

Inspector Worker 的整体装配点：按配置构造各仓库、路由器、realm 注册表与端点，接上 Host 源端口，并提供一次性关停。

- 用配置中的 `maxRetainedRequests` 与 `maxJournalBytes` 构造网络仓库（[packages/experimental/inspector/src/worker/server.ts:31-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L31-L35)）
- 用 `maxCordisNodes` 与 `maxDisconnectedCordisTrees` 构造 Cordis 树仓库（[packages/experimental/inspector/src/worker/server.ts:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L36-L39)）
- 源注册表以这两个仓库为记录消费者，并带上单帧字节上限与单帧记录数上限（[packages/experimental/inspector/src/worker/server.ts:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L40-L44)）
- Client Runtime 与 Source 路由器各自带上请求超时、Client 源码字节上限与帧字节上限（[packages/experimental/inspector/src/worker/server.ts:45-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L45-L51)）
- realm 注册表以标签为 `Host` 的 Host realm 为固定成员，Client realm 由路由器动态提供（[packages/experimental/inspector/src/worker/server.ts:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L52)）
- 语义读取器每次读取都从 Cordis 仓库现取树，查询路由器以帧字节上限为界（[packages/experimental/inspector/src/worker/server.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L53-L55)）
- 订阅源注册表事件，在源关闭时撤销该源代的查询访问权（[packages/experimental/inspector/src/worker/server.ts:56-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L56-L58)）
- Host 查询 peer 的发送与关闭都直接作用在 Host 源 MessagePort 上（[packages/experimental/inspector/src/worker/server.ts:59-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L59-L62)）
- Host 源连接在发出 `source/accepted` 帧的同时把该源代准入给 Host 查询 peer（[packages/experimental/inspector/src/worker/server.ts:63-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L63-L70)）
- Host 端口上的每条消息先给查询 peer 认领，未被认领才交源注册表摄入（[packages/experimental/inspector/src/worker/server.ts:71-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L71-L73)）
- Host 端口关闭时关掉查询 peer 并以"Host source disconnected"断开该源（[packages/experimental/inspector/src/worker/server.ts:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L74-L78)）
- 端点持有配置、源注册表、Network 域、realm 注册表、DOM 后端、读取器与查询路由器，启动后返回监听信息（[packages/experimental/inspector/src/worker/server.ts:80-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L80-L89)）
- `close` 用共享 Promise 保证只执行一次，并按端点、网络、Cordis DOM、realm、两个 Client 路由器、Host 查询 peer、源注册表、事件订阅、查询路由器、Host 端口的固定顺序拆解（[packages/experimental/inspector/src/worker/server.ts:90-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/src/worker/server.ts#L90-L110)）

### packages/experimental/inspector/tsconfig.json

该包的 TypeScript 求解方案根配置，仅引用 Host 与 Client 两个面向的叶子配置。

- 无运行期机制

### packages/experimental/inspector/tsdown.config.ts

该包的打包配置，决定发布产物中存在哪些入口以及哪些依赖保持外置。

- Worker 产物以 `lib/types/worker/entry.js` 为入口打成 `lib/worker`，格式 esm、平台 node、目标 es2024，并内联动态导入（[packages/experimental/inspector/tsdown.config.ts:4-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/tsdown.config.ts#L4-L13)）
- `ws` 被排除在打包之外，运行期从外部解析（[packages/experimental/inspector/tsdown.config.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/tsdown.config.ts#L14)）
- 默认导出在 Host 阶段构建插件入口与 invariant 入口并附带 Worker 产物，在 Client 阶段构建动态 Client 插件（[packages/experimental/inspector/tsdown.config.ts:18-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/inspector/tsdown.config.ts#L18-L22)）
