---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/hmr
---

# packages/client/hmr

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、42 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/hmr/README.md

本包的说明文档，讲述开发期热重载链路的用法、内部顺序与失败策略。

- 无运行期机制

### packages/client/hmr/package.json

本包的清单，声明入口映射、客户端装载元数据与发布文件列表。

- `exports` 暴露 `.`、`./invariant`、`./client`、`./src/*` 与 `./package.json` 五个入口，决定运行期可被解析到哪些模块（[packages/client/hmr/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/package.json#L16-L31)）
- `dsh.client` 声明该行在 web 平台上无注入依赖且 `immediately: true`，决定它在客户端启动图里的挂载方式（[packages/client/hmr/package.json:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/package.json#L32-L38)）
- `files` 限定发布产物为三个 `lib` 入口与类型声明（[packages/client/hmr/package.json:57-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/package.json#L57-L62)）

### packages/client/hmr/src/client/index.ts

浏览器一侧的重载驱动：订阅 SSE 通道，收到 rebuilt 帧后原地换掉对应插件的 cordis fiber。

- 声明 `inject = ['loader', 'modules']`，Loader 与客户端模块系统就绪后才激活（[packages/client/hmr/src/client/index.ts:76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L76)）
- `findEntry` 遍历 loader 条目，按 `options.name` 匹配模块标识（[packages/client/hmr/src/client/index.ts:79-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L79-L84)）
- `removeOwnedStyles` 按 `data-plugin` 属性逐字比较，移除该插件注入的 `<style>` 标签（[packages/client/hmr/src/client/index.ts:87-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L87-L91)）
- 帧指向的条目不在 loader 树里时记 warn 并放弃本次重载（[packages/client/hmr/src/client/index.ts:105-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L105-L109)）
- 先 `invalidate(id, rev)` 丢弃旧工厂与已实例化记录，再 `await prefetch(id)` 载入新工厂，旧 fiber 期间仍在服务（[packages/client/hmr/src/client/index.ts:115-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L115-L116)）
- 拆除前先 `entry.ctx.registry.delete(runtime.callback)`，让 Loader 的 `internal/plugin` 分支不把条目标记为 disabled（[packages/client/hmr/src/client/index.ts:118-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L118-L124)）
- 循环 `await oldFiber.inertia` 直到旧 fiber 的卸载排空，然后 `delete entry.fiber`（[packages/client/hmr/src/client/index.ts:127-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L127-L129)）
- 在重新实例化之前移除该插件旧的样式标签（[packages/client/hmr/src/client/index.ts:132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L132)）
- `await entry.refresh()` 经 Loader 自身的初始化路径重新导入并重新挂载插件（[packages/client/hmr/src/client/index.ts:137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L137)）
- `await entry.fiber?.await()` 把新插件的启动失败重新抛出（[packages/client/hmr/src/client/index.ts:139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L139)）
- 用一条 Promise 链把重载串行化，单次失败在 `catch` 里记两条 error 且不阻断后续帧（[packages/client/hmr/src/client/index.ts:144-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L144-L151)）
- `graph` 帧被忽略，启动图保持初次加载时的记录（[packages/client/hmr/src/client/index.ts:153-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L153-L157)）
- 未知帧类型走 default 分支被丢弃（[packages/client/hmr/src/client/index.ts:158-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L158-L162)）
- `ctx.effect` 打开到 `EVENTS_ENDPOINT` 的 `EventSource`，JSON 解析失败与校验失败各记一条 warn，合法帧交给 `handle`，disposer 关闭连接（[packages/client/hmr/src/client/index.ts:165-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/client/index.ts#L165-L184)）

### packages/client/hmr/src/events.ts

`/plugins/events` 开发通道的帧类型、校验函数与端点常量，两侧共用。

- `parsePluginsEventFrame` 拒绝非对象载荷（[packages/client/hmr/src/events.ts:27-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/events.ts#L27-L28)）
- `rebuilt` 帧要求 `id` 与 `rev` 都是字符串，否则判为 invalid（[packages/client/hmr/src/events.ts:30-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/events.ts#L30-L33)）
- `graph` 帧要求 `graph` 是非空对象，否则判为 invalid（[packages/client/hmr/src/events.ts:34-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/events.ts#L34-L37)）
- 其他字符串 `type` 归为 `unknown`（向前兼容），非字符串 `type` 归为 `invalid`（[packages/client/hmr/src/events.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/events.ts#L38-L40)）
- `EVENTS_ENDPOINT` 固定为 `/plugins/events`（[packages/client/hmr/src/events.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/events.ts#L44)）

### packages/client/hmr/src/index.ts

node 一侧：按间隔 stat 轮询各行客户端产物，检测到变化就上报 rebuilt，并提供 `/plugins/events` SSE 通道。

- 声明 `inject = ['clientModules', 'webServer']`（[packages/client/hmr/src/index.ts:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L28)）
- `Config` 把 `pollIntervalMs` 限定为不小于 1 的整数，默认 500（[packages/client/hmr/src/index.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L36-L38)）
- `sseData` 把帧序列化为 `data: …\n\n` 的 SSE 行（[packages/client/hmr/src/index.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L41-L43)）
- `bundleStat` 用 `statSync` 取 `mtimeMs` 与 `size` 作为变化判据（[packages/client/hmr/src/index.ts:52-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L52-L55)）
- `sameBundleStat` 以 `mtimeMs` 与 `size` 双相等判定未变（[packages/client/hmr/src/index.ts:58-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L58-L61)）
- `rehash` 调用 `ctx.clientModules.rebuilt(id)` 上报变化，`ENOENT` 置 dirty 并保留旧基线，其他错误记 warn，成功后写回 stat 基线并清 dirty（[packages/client/hmr/src/index.ts:75-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L75-L91)）
- `watchRow` 用模块宿主的读前基线建表，首次 stat 失败置 dirty，与基线不符才进入内容哈希路径（[packages/client/hmr/src/index.ts:93-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L93-L107)）
- `pollWatches` 逐行 stat：失败置 dirty 并跳过，未 dirty 且 stat 未变则跳过，否则 rehash（[packages/client/hmr/src/index.ts:109-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L109-L124)）
- `syncWatches` 把监视集与当前图行求差：路径变化或行消失就删监视，新行补建监视（[packages/client/hmr/src/index.ts:128-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L128-L141)）
- `ctx.effect` 先做一次同步、订阅 `onGraphChanged`、开 `setInterval` 并 `unref`，disposer 退订、清定时器并清空监视表（[packages/client/hmr/src/index.ts:143-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L143-L156)）
- `connect` 写 200 与 event-stream/no-cache/keep-alive 头，先发一行注释再发一帧当前 graph，加入连接集并在 close 时移除（[packages/client/hmr/src/index.ts:161-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L161-L173)）
- `ctx.effect` 注册 `EVENTS_ENDPOINT` 精确路由，非 GET/HEAD 回 405（[packages/client/hmr/src/index.ts:175-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L175-L189)）
- 订阅 `onRebuilt`，把 `{type:'rebuilt', id, rev}` 广播给所有在线连接（[packages/client/hmr/src/index.ts:190-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L190-L193)）
- 该 effect 的 disposer 退订、撤路由、`destroy` 每个连接并清空连接集（[packages/client/hmr/src/index.ts:194-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/index.ts#L194-L199)）

### packages/client/hmr/src/invariant.ts

本包的 invariant 伴随插件，检查 node 侧 stat 轮询器随 fiber 一起消亡。

- `statWatchers` 用 `process.getActiveResourcesInfo()` 统计存活的 `StatWatcher` 数量（[packages/client/hmr/src/invariant.ts:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/invariant.ts#L17-L19)）
- 全局监听 `internal/plugin`，只对名为 `client-hmr` 的 fiber 生效：创建时记基线，销毁时在微任务跳与 `fiber.await()` 之后比较，残留轮询器则 `fail`（[packages/client/hmr/src/invariant.ts:31-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/invariant.ts#L31-L51)）
- 向 invariants 服务登记该安装器并返回其 disposer（[packages/client/hmr/src/invariant.ts:58-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/src/invariant.ts#L58-L59)）

### packages/client/hmr/tsconfig.json

本包的编译配置，声明根/输出目录、lib 集合与工作区引用。

- 无运行期机制

### packages/client/hmr/tsdown.config.ts

本包的打包配置，交给共享的 `clientBundle` 工厂。

- 指定该包以 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口产出打包产物（[packages/client/hmr/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/hmr/tsdown.config.ts#L3)）
