---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/api/remotes
---

# packages/api/remotes

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、34 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/api/remotes/README.md

该包的英文说明文档，介绍两侧入口的职责、转发事件清单的位置以及 Host/Client 两个编译 face 的划分。

- 无运行期机制

### packages/api/remotes/package.json

该包的清单，声明模块类型、子路径导出、Client 插件元数据、发布文件集与依赖。

- `"type": "module"` 与 `main`/`types` 决定该包按 ESM 解析、默认入口指向 `lib/index.js`（[packages/api/remotes/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./client`、`./types`、`./src/*` 与 `./package.json` 分别映射到具体的运行期文件，决定各消费者能从哪些子路径加载到什么（[packages/api/remotes/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/package.json#L16-L35)）
- `dsh.client` 声明该 Client 插件注入 `@deepseek-ai/dsh-api-gateway`、平台为 `web`、`immediately: true`，决定加载器何时以何种依赖挂载它（[packages/api/remotes/package.json:36-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/package.json#L36-L44)）
- `files` 限定进入发布产物的文件为三个 bundle 入口与 `lib/types` 下的 js/d.ts（[packages/api/remotes/package.json:50-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/package.json#L50-L56)）

### packages/api/remotes/src/client/index.ts

Client 侧装配入口，值导入各业务包生成的 `/remote` 产物并逐个挂到 `ctx.remote` 上，同时把 Client 需要的类型词表集中再导出。

- 以值导入方式固定引入 12 个生成的 `/remote` 贡献，构建期就决定了 Client 能拿到哪些 Host 能力（[packages/api/remotes/src/client/index.ts:4-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/client/index.ts#L4-L15)）
- `inject = ['remote']` 声明该插件必须等 `remote` 服务就绪才装配（[packages/api/remotes/src/client/index.ts:147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/client/index.ts#L147)）
- `apply` 按数组给定顺序逐个 `await ctx.remote.$mount(contribution)`，并把每次返回的 disposer 收进列表（[packages/api/remotes/src/client/index.ts:154-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/client/index.ts#L154-L163)）
- 挂载中途抛错时反序逐个 dispose 已挂载的贡献再把错误抛出（[packages/api/remotes/src/client/index.ts:164-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/client/index.ts#L164-L167)）
- 返回的卸载函数按挂载的反序依次 dispose（[packages/api/remotes/src/client/index.ts:170-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/client/index.ts#L170-L172)）

### packages/api/remotes/src/index.ts

Host 侧入口，把允许转发的 Cordis 事件按清单接到一条队列上，注册为网关的事件源。

- `inject = ['typertGateway']` 声明该 Host 插件依赖网关服务（[packages/api/remotes/src/index.ts:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L34)）
- `apply` 用 `ctx.effect` 把事件源注册进网关，并把 `homedir()` 作为 Host home 一起传入注册信息（[packages/api/remotes/src/index.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L37-L42)）
- 事件源工厂每次被调用都新建一条独立队列，并按转发清单逐条 `ctx.on` 注册监听器（[packages/api/remotes/src/index.ts:45-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L45-L48)）
- `emit` 模式的监听器把参数经 JSON 校验后连同事件名压入队列（[packages/api/remotes/src/index.ts:49-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L49-L53)）
- `waterfall` 模式的监听器从 `this` 上取 carrier key 作为 subject，取不到就直接 `next()` 把该轮交回 Host 链（[packages/api/remotes/src/index.ts:54-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L54-L61)）
- subject 上的 `ctx` 不是对象时抛 `TypeError`（[packages/api/remotes/src/index.ts:61-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L61-L64)）
- 取到活的 Context 后调 `forwardWaterfall`，把事件名、请求对象、Context 与 subject、以及 `next` 一并投进队列（[packages/api/remotes/src/index.ts:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L65-L72)）
- 工厂返回 `queue.iterate(signal, cleanup)`，cleanup 逐个 dispose 本次注册的所有监听器（[packages/api/remotes/src/index.ts:74-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L74-L77)）
- `RemoteEventQueue.push` 在队列已结束时返回 false，否则入缓冲并唤醒等待中的消费者（[packages/api/remotes/src/index.ts:86-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L86-L91)）
- `end` 置结束标记、清空缓冲，并对其中每个待决的 waterfall 调用 `reject`，再唤醒消费者（[packages/api/remotes/src/index.ts:93-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L93-L101)）
- `iterate` 挂上一次性 abort 监听，循环中已结束或已取消即返回，先排空缓冲逐个 yield，缓冲空则挂起等待下一次 push（[packages/api/remotes/src/index.ts:103-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L103-L112)）
- `iterate` 的 finally 摘掉 abort 监听、结束队列并执行 cleanup，使消费方提前退出也会撤掉监听器（[packages/api/remotes/src/index.ts:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L113-L117)）
- `remoteEventSourceEndReason` 在已取消时用 signal 的 reason，否则造一个 `forwarded Remote event source ended` 错误作为待决 waterfall 的失败原因（[packages/api/remotes/src/index.ts:126-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L126-L129)）
- `forwardWaterfall` 建一个 `Promise.withResolvers`，`resolve` 收到 `result` 时直接以该值结束本轮，收到 `next` 时在微任务里调用 Host 的 `next()` 并把其结果或失败转交（[packages/api/remotes/src/index.ts:139-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L139-L152)）
- 队列已关闭导致 push 失败时，该轮 waterfall 立即走 Host 的 `next()`（[packages/api/remotes/src/index.ts:153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L153)）
- `assertJsonArgs` 逐个检查参数是否为无损 JSON 值，任一不符即带事件名和下标抛错，从而阻止该事件入队（[packages/api/remotes/src/index.ts:158-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/index.ts#L158-L165)）

### packages/api/remotes/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包名并给出空安装器。

- 声明伴生插件名与所需注入服务 `invariants`（[packages/api/remotes/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/invariant.ts#L10-L12)）
- 安装器为空实现，并在注释中写明本包不注册运行期不变量的原因（[packages/api/remotes/src/invariant.ts:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/invariant.ts#L14-L15)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 占下包名归属并返回其 disposer（[packages/api/remotes/src/invariant.ts:22-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/invariant.ts#L22-L23)）

### packages/api/remotes/src/remote-events.ts

转发事件白名单的唯一存放处，被 Host 转发循环和 Client 的按键类型投影共同读取。

- 常量数组逐条列出被转发的 Host 事件名及其投递模式，决定 Host 监听哪些事件、以及每条走普通发射还是 Agent 作用域瀑布（[packages/api/remotes/src/remote-events.ts:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/remote-events.ts#L16-L31)）
- 展开 session controller 包导出的事件名清单并把其中每条都标为 `emit`（[packages/api/remotes/src/remote-events.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/src/remote-events.ts#L19)）

### packages/api/remotes/src/types.ts

只含类型的模块，从白名单常量推出事件名联合并把它并入 Typert 协议的事件选择表。

- 无运行期机制

### packages/api/remotes/tsconfig.json

包根 tsconfig，只作为引用 Host 与 Client 两个 leaf 配置的 solution。

- 无运行期机制

### packages/api/remotes/tsdown.config.ts

该包的打包配置，调用共享的 `clientBundle` 预设并打开 host 阶段开关。

- 以包名、`lib/types/index.js` 与 `lib/types/invariant.js` 入口以及 `hostPhase: true` 调用 `clientBundle`，使 Host 构建阶段产出 Node 侧库、Client 构建阶段只产出浏览器入口（[packages/api/remotes/tsdown.config.ts:1-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/remotes/tsdown.config.ts#L1-L7)）
