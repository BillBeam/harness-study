---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/cordis
---

# vendor/cordis

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 13 个文件、167 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/cordis/README.md

被 vendor 化的插件框架包的说明文档，介绍安装、快速上手示例与包清单。

- 无运行期机制

### vendor/cordis/bin.js

该包 package.json 的 `bin` 入口脚本，以当前工作目录为基准启动一个由配置文件驱动的插件树。

- shebang 声明用 node 解释执行此文件（[vendor/cordis/bin.js:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/bin.js#L1)）
- 新建根 Context 并把 `baseUrl` 设为进程当前工作目录的 file URL 加尾斜杠，后续相对模块说明符按它解析（[vendor/cordis/bin.js:7-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/bin.js#L7-L8)）
- 先 await 加载 loader 插件，再通过 `ctx.loader.create` 挂载 include 插件、并把 `path` 配成 `./cordis.yml`（[vendor/cordis/bin.js:10-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/bin.js#L10-L16)）

### vendor/cordis/package.json

被 vendor 化的框架核心包清单，声明入口、可执行文件与依赖。

- `"type": "module"` 使包内 `.js` 按 ESM 解析（[vendor/cordis/package.json:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/package.json#L14)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[vendor/cordis/package.json:15-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/package.json#L15-L16)）
- `bin` 把 `bin.js` 注册为该包的可执行入口（[vendor/cordis/package.json:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/package.json#L17)）
- `exports` 只放行根导出、`./src/*` 源码子路径与 `./package.json`，其余路径不可导入（[vendor/cordis/package.json:18-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/package.json#L18-L25)）
- `files` 限定发布内容为 `lib/index.js`、类型声明与 map、`bin.js` 与 `src`（[vendor/cordis/package.json:26-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/package.json#L26-L32)）
- loader 与 include 两个插件声明为可选 peerDependency，缺失时不阻断安装（[vendor/cordis/package.json:35-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/package.json#L35-L46)）
- 运行期依赖为 standard-schema 规范包与工作区内的 cosmokit（[vendor/cordis/package.json:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/package.json#L47-L50)）

### vendor/cordis/src/context.ts

定义 Context 类与其公开接口，是插件拿到的那个 `ctx` 对象的实现与派生入口。

- `Context.is` 用全局注册表符号做品牌判定，跨 realm、跨多份框架副本都能识别上下文（[vendor/cordis/src/context.ts:61-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/context.ts#L61-L68)）
- 构造函数先建空原型的隔离表与拦截表，再用 `ReflectService.handler` 把自身包成 Proxy 并把该代理作为构造结果返回，之后所有属性读写都经过反射层（[vendor/cordis/src/context.ts:71-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/context.ts#L71-L84)）
- 构造函数按 fiber、reflect、registry、events、logger 的固定顺序装配内建服务，并在装配完成后清空根 fiber 已收集的 disposable（[vendor/cordis/src/context.ts:77-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/context.ts#L77-L82)）
- 定义 Node inspect 钩子，使打印上下文时输出 `Context <fiber 名>`（[vendor/cordis/src/context.ts:86-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/context.ts#L86-L88)）
- `extend()` 以当前上下文的 traceable 形态为原型建子对象、把 meta 的自有键（含符号键）连描述符定义上去，父对象不变；若当前带 shadow 则再包一层并保留该 shadow（[vendor/cordis/src/context.ts:99-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/context.ts#L99-L107)）
- `isolate()` 在隔离表原型链上为该服务名写入新的（或传入的）标签符号，使子树的该服务解析到独立作用域（[vendor/cordis/src/context.ts:121-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/context.ts#L121-L125)）
- `intercept()` 在拦截表原型链上追加该服务名的配置项，供其下加载的插件解析服务配置时合并（[vendor/cordis/src/context.ts:141-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/context.ts#L141-L145)）

### vendor/cordis/src/events.ts

事件总线服务，装为 `ctx.events` 并把 on/emit/serial/bail/waterfall 等方法混入每个上下文。

- `isBailed` 规定只有 `null`、`false`、`undefined` 不算 bail 值，决定 serial/bail 何时提前停下（[vendor/cordis/src/events.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L13-L15)）
- 构造时注册 `internal/listener` 监听：非 global 的 `internal/update` 监听被改存进该 fiber 自己的 `_hooks` 链表，并按 `prepend` 决定插入端（[vendor/cordis/src/events.ts:140-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L140-L146)）
- 构造时注册一个 global 且前置的 `internal/update` 监听，把 fiber 私有的 update 钩子逐个串成链，最后落到外部传入的 `next`（[vendor/cordis/src/events.ts:148-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L148-L155)）
- `dispatch` 从参数头部抽取可选 `thisArg` 与事件名，对非 `internal/` 前缀的事件先同步 emit 一条 `internal/dispatch`（[vendor/cordis/src/events.ts:165-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L165-L170)）
- `dispatch` 用 `thisArg[Context.filter]` 逐个过滤监听器（global 监听不受过滤），再把回调绑定到 `thisArg`（[vendor/cordis/src/events.ts:171-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L171-L175)）
- `parallel` 用 `Promise.allSettled` 并发跑全部监听器，把所有被拒绝的原因聚成 `AggregateError` 抛出（[vendor/cordis/src/events.ts:183-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L183-L187)）
- `emit` 同步依次调用监听器且不等待返回的 promise（[vendor/cordis/src/events.ts:194-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L194-L196)）
- `serial` 顺序 await 每个监听器，命中 bail 值即返回并不再调用后续监听器（[vendor/cordis/src/events.ts:204-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L204-L209)）
- `bail` 同步顺序调用，命中 bail 值即返回并不再调用后续监听器（[vendor/cordis/src/events.ts:217-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L217-L222)）
- `waterfall` 把末位参数取作最内层 `next`，把监听器由外向内组成链并回填新的 `next` 参数，监听器不调用 `next` 就截断其后所有监听器与内层行为（[vendor/cordis/src/events.ts:234-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L234-L243)）
- `register` 把监听记录登记成当前 fiber 的一个 effect，effect 的 disposer 即移除该监听（[vendor/cordis/src/events.ts:254-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L254-L260)）
- `unregister` 按回调身份在监听列表中查找并 splice 掉，找到时返回 true（[vendor/cordis/src/events.ts:269-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L269-L275)）
- `on` 先 `assertActive` 拒绝已释放 fiber 的注册，再用 `ctx.reflect.bind` 把监听器包成会 trace `this` 与参数的代理（[vendor/cordis/src/events.ts:288-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L288-L295)）
- `on` 在真正入表前先 bail 一次 `internal/listener`，返回非空即以该返回值代替本次注册（[vendor/cordis/src/events.ts:296-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L296-L301)）
- `once` 用一个先自我 dispose 再转发的包装监听器实现单次触发（[vendor/cordis/src/events.ts:312-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L312-L318)）

### vendor/cordis/src/fiber.ts

插件运行实例（fiber）的实现，管配置校验、依赖 epoch、effect 收集与加载/卸载状态机；`ctx.plugin()` 返回的就是它。

- `ValidationError` 把 standard-schema 的 issue 列表逐条拼成带路径的多行消息（[vendor/cordis/src/fiber.ts:27-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L27-L35)）
- 在 `ValidationError.prototype` 上打一个全局符号标记，供跨副本识别该错误类型（[vendor/cordis/src/fiber.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L38-L40)）
- `resolveConfig` 无 schema 时原样返回；校验返回 thenable 时抛 TypeError 拒绝异步校验；有 issues 时抛 `ValidationError`，否则返回校验后的值（[vendor/cordis/src/fiber.ts:50-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L50-L62)）
- `effectInertia` 弱表记录每个 wrapper 对应的在途清理，`runDisposable` 在调用 disposer 后改用该在途 promise 作为结果，使另一方已开始的清理可以被加入等待（[vendor/cordis/src/fiber.ts:112-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L112-L117)）
- `emitPluginDisposed` 分发 `internal/plugin` 时把取回调、逐个同步调用、异步返回值三处都各自 try/catch 并把错误交给 logger，任一观察者出错不影响其余清理（[vendor/cordis/src/fiber.ts:120-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L120-L137)）
- `CordisError` 带稳定错误码，码表默认消息即码含义（[vendor/cordis/src/fiber.ts:157-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L157-L174)）
- 非根 fiber 从 registry 的自增计数取 uid，并以 `parent.extend({ fiber: this })` 建立插件自己的上下文（[vendor/cordis/src/fiber.ts:235-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L235-L236)）
- 声明了 inject 配置时，在子上下文的拦截表上按服务名写入非空配置（[vendor/cordis/src/fiber.ts:238-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L238-L245)）
- runner 的 `execute` 判断插件回调是否为构造器：是则 `new` 之、跑完实例的 initHooks、再调用 `[symbols.init]`；否则直接以 `(ctx, config)` 调用（[vendor/cordis/src/fiber.ts:247-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L247-L263)）
- fiber 的 dispose 本身注册为父 fiber 的一个 effect，effect 体把自己 push 进 runtime.fibers，因此父卸载会连带卸载子（[vendor/cordis/src/fiber.ts:265-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L265-L267)）
- 该 disposer 先清 uid、广播 `internal/plugin`，再从 runtime.fibers 摘除；摘完若无剩余 fiber 就把插件从 registry 删除（[vendor/cordis/src/fiber.ts:267-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L267-L275)）
- 该 disposer 把 epoch 置 INACTIVE；若此时没有在途转换，则显式转入 UNLOADING 并跑 `_unload`，以清掉 PENDING 期间被观察者注册的 effect（[vendor/cordis/src/fiber.ts:276-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L276-L286)）
- 该 disposer 循环 await `inertia` 直到没有在途转换才算完成（[vendor/cordis/src/fiber.ts:293-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L293-L295)）
- 在 disposer 装配完成之后才广播 `internal/plugin`；该广播同步抛错时立刻调用自己的 dispose（错误交给 logger）并把原错误重抛（[vendor/cordis/src/fiber.ts:299-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L299-L308)）
- 只有广播后 uid 未被清空、且父 fiber 不处于 UNLOADING 时，才逐个 `_checkImpl` 依赖并 `_refresh`；否则把 PENDING 期的清理交给 disposer（[vendor/cordis/src/fiber.ts:314-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L314-L319)）
- 根 fiber 分支把 uid 置 0、上下文直接取 parent、状态直接置 ACTIVE、store 置空对象、execute 为空函数，且 `dispose` 被定义成 `restart()`（[vendor/cordis/src/fiber.ts:320-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L320-L332)）
- `name` 沿父 fiber 链取第一个带 `runtime.name` 的名字，到顶仍无则为 `'root'`（[vendor/cordis/src/fiber.ts:336-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L336-L343)）
- `assertActive` 在 uid 已被清空时抛 `INACTIVE_EFFECT`（[vendor/cordis/src/fiber.ts:351-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L351-L354)）
- `_execute` 校验 effect 体的返回形状：函数直接收集，nullable 忽略，非对象或未知形状抛 `TypeError`（[vendor/cordis/src/fiber.ts:359-372](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L359-L372)）
- `_execute` 对 thenable 返回 `then(safeCollect)`，对同步迭代器逐个 `next()` 收集直到 done（[vendor/cordis/src/fiber.ts:373-382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L373-L382)）
- `_execute` 对异步迭代器在每轮 `next()` 前比对 epoch，epoch 变了就停止继续取值（[vendor/cordis/src/fiber.ts:383-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L383-L395)）
- `_execute` 整体包在 `composeError` 内，并用 runner 的 `getOuterStack` 把外层调用栈拼进抛出的错误（[vendor/cordis/src/fiber.ts:356-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L356-L399)）
- `effect()` 在 fiber 已释放或正处于 UNLOADING 时抛 `INACTIVE_EFFECT`（[vendor/cordis/src/fiber.ts:419-422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L419-L422)）
- effect 内部的 `dispose` 逆序运行已收集的 disposer，遇到异步结果后把其余 disposer 串接到该 promise 之后，且重复调用直接返回同一个 disposalTask（[vendor/cordis/src/fiber.ts:427-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L427-L442)）
- runner 的 `collect` 把 disposer 收进本 effect 的私有列表并从 fiber 的公共列表中删除，同时把嵌套 effect 的 meta 挂进本 effect 的 children（[vendor/cordis/src/fiber.ts:444-456](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L444-L456)）
- `waitForSetup` 建立一次性 setup 屏障，`disposeAfter` 保证 setup 结算（成功或失败）后才跑 dispose 并在失败时重抛（[vendor/cordis/src/fiber.ts:467-483](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L467-L483)）
- `finalizeDisposal` 记录异步清理为 `inFlight`，并在同步抛错或异步结算后都把 wrapper 从 fiber 列表里摘掉（[vendor/cordis/src/fiber.ts:485-502](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L485-L502)）
- 返回的 wrapper 用 `runner.epoch` 做单次触发；已触发时若 setup 失败则返回在途清理，否则返回 undefined；仍在 execute 中则先等 setup 屏障再 dispose（[vendor/cordis/src/fiber.ts:504-514](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L504-L514)）
- wrapper 上挂 `symbols.effect` 的 meta，使 `getEffects()` 与父 effect 能读到标签树（[vendor/cordis/src/fiber.ts:504-514](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L504-L514)）
- 把 wrapper 登记进 `effectInertia`，使外层 effect 能加入本 effect 已开始的异步清理（[vendor/cordis/src/fiber.ts:515](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L515)）
- 在跑任何插件代码之前先把 wrapper push 进 fiber 的 disposable 列表，使重入的 owner 卸载能看见这个尚未完成的 effect（[vendor/cordis/src/fiber.ts:520](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L520)）
- effect 体同步抛错时：标记 setup 失败并关闭 epoch、回滚已收集的 disposer、reject setup 屏障、异步回滚失败交给 logger，最后重抛原错误（[vendor/cordis/src/fiber.ts:521-537](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L521-L537)）
- 异步 setup 结算后回填 setup 屏障；并给 task 挂兜底 catch，失败时按 epoch 决定直接 dispose 还是走 finalizeDisposal，最终错误交给 logger 以避免未处理拒绝（[vendor/cordis/src/fiber.ts:538-548](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L538-L548)）
- 给 wrapper 装 `then`，使 `await ctx.effect(...)` 先等 setup 完成再拿到一个异步 disposer（[vendor/cordis/src/fiber.ts:550-560](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L550-L560)）
- `getEffects()` 从活着的 disposable 中取出带标签的 meta 树（[vendor/cordis/src/fiber.ts:568-572](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L568-L572)）
- `_getState` 按 uid 为 null → DISPOSED、有 `_error` → FAILED、epoch 非 INACTIVE → ACTIVE、否则 PENDING 推导状态（[vendor/cordis/src/fiber.ts:574-579](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L574-L579)）
- `_updateState` 在状态确有变化时 emit `internal/status` 并带上旧状态（[vendor/cordis/src/fiber.ts:581-586](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L581-L586)）
- `_updateState` 只在跨越 ACTIVE 边界时，才对本 fiber 提供的每个服务调用 `reflect.notify`，唤醒依赖方（[vendor/cordis/src/fiber.ts:588-594](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L588-L594)）
- `_checkImpl` 取严格模式的实现记录，无记录、`check()` 返回假、或 `check()` 抛错（错误交给提供方 logger）三种情况都从依赖快照里删除该名字（[vendor/cordis/src/fiber.ts:597-609](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L597-L609)）
- `_refresh` 把每个依赖实现的提供者 uid 拼成 epoch 字符串，任一依赖缺失即置 INACTIVE，从而使提供者换人也会触发重载（[vendor/cordis/src/fiber.ts:611-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L611-L623)）
- `_setEpoch` epoch 未变则不动；已有在途转换则只更新 epoch 交由该转换收尾；否则由 INACTIVE 转有值走 `_reload`/LOADING，其余方向走 `_unload`/UNLOADING（[vendor/cordis/src/fiber.ts:625-639](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L625-L639)）
- `_resolveConfig` 先跑 `internal/config` 瀑布让监听者改写原始配置，再交给 runtime 的 schema 校验（[vendor/cordis/src/fiber.ts:641-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L641-L644)）
- `_reload` 先把依赖快照冻结到 `store`，再 await 一个微任务，然后比对 epoch，epoch 已失效就不跑插件代码（[vendor/cordis/src/fiber.ts:646-658](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L646-L658)）
- `_reload` 捕获配置解析或插件启动的错误：交给 logger、存入 `_error`、把 epoch 置回 INACTIVE（[vendor/cordis/src/fiber.ts:659-664](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L659-L664)）
- `_reload` 结束时若 epoch 仍是启动时那个就清空 inertia，否则立刻转入 `_unload`/UNLOADING（[vendor/cordis/src/fiber.ts:665-672](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L665-L672)）
- `_unload` 一次性取出全部 disposable（clear 返回逆序）并发运行，每个都包 `composeError` 且失败只交给 logger 不中断其余清理（[vendor/cordis/src/fiber.ts:675-686](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L675-L686)）
- `_unload` 完成后清空依赖快照；epoch 仍为 INACTIVE 就收尾，否则立刻转回 `_reload`/LOADING（[vendor/cordis/src/fiber.ts:687-695](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L687-L695)）
- `await()` 循环等待在途转换直至稳定，若记录了启动错误则重新抛出（[vendor/cordis/src/fiber.ts:704-710](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L704-L710)）
- `restart()` 先把 epoch 置 INACTIVE 再 `_refresh` 重算，从而强制一次卸载再加载（[vendor/cordis/src/fiber.ts:718-723](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L718-L723)）
- `update()` 存下新原始配置；若 fiber 非 ACTIVE，则清错并只做 epoch 重置与刷新，把配置解析推迟到能激活时（[vendor/cordis/src/fiber.ts:736-746](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L736-L746)）
- `update()` 在 ACTIVE 时先解析校验配置，再走 `internal/update` 瀑布，监听者可否决或替换默认的"写入配置并 restart"（[vendor/cordis/src/fiber.ts:747-752](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/fiber.ts#L747-L752)）

### vendor/cordis/src/index.ts

包的根入口，把各源码模块整体再导出。

- 无运行期机制

### vendor/cordis/src/logger.ts

日志门面与日志服务，装为 `ctx.logger`，供框架内部与插件输出诊断信息。

- `defaultFormatters` 定义 `%s/%d/%i/%f/%o/%O/%c/%C` 的取值方式，其中 `%C` 按 logger 名着色（[vendor/cordis/src/logger.ts:50-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L50-L61)）
- `Logger.color` 在 exporter 未开颜色时原样返回，开了则包 ANSI 转义（超过 8 号色走 256 色序列）（[vendor/cordis/src/logger.ts:84-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L84-L87)）
- `Logger.code` 由 logger 名做哈希，在 16 色或 256 色表里取一个稳定色号（[vendor/cordis/src/logger.ts:89-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L89-L97)）
- `Logger.format` 首参是 Error 时改用其 stack 并补 `%s`，首参非字符串时补 `%o`（[vendor/cordis/src/logger.ts:99-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L99-L107)）
- `Logger.format` 逐个替换 `%x` 占位符（exporter 自定义 formatter 优先于默认表），未知占位符原样保留（[vendor/cordis/src/logger.ts:108-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L108-L117)）
- `Logger.format` 把多余参数附在末尾（对象走 `o` formatter），并按 `maxLength`（默认 10240）逐行截断加省略号（[vendor/cordis/src/logger.ts:119-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L119-L130)）
- 构造时按 error/info/warn/debug 四档生成方法并绑定各自的数值等级（[vendor/cordis/src/logger.ts:133-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L133-L139)）
- 单参数且为 Error 时，有 cause 则改记 cause，AggregateError 则逐个记录其 errors 后直接返回（[vendor/cordis/src/logger.ts:142-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L142-L150)）
- 每条消息分配自增序号与时间戳，并对每个 exporter 按 `levels[name] ?? levels.default ?? logger.level ?? INFO` 与本条等级比较后决定是否投递（[vendor/cordis/src/logger.ts:152-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L152-L159)）
- `LoggerService` 构造出一个可调用对象并把它作为构造结果返回，使 `ctx.logger()` 与 `ctx.logger.info()` 两种用法同时成立（[vendor/cordis/src/logger.ts:203-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L203-L211)）
- 构造时注册一个默认 exporter，把消息压入内存缓冲并在超过 `bufferSize`（1000）时只保留最后一段（[vendor/cordis/src/logger.ts:213-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L213-L221)）
- `exporter()` 把 exporter 登记为当前 fiber 的 effect，序号自增写入 map，disposer 删除条目（[vendor/cordis/src/logger.ts:232-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L232-L237)）
- `_resolveConfig` 沿上下文拦截表的原型链收集 `logger` 配置项，靠近根的先合并（[vendor/cordis/src/logger.ts:239-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L239-L249)）
- 调用体按显式参数 → 拦截配置的 name → fiber 名的连字符化 依次取名，并把来源 fiber 的 WeakRef 放进每条消息的 meta（[vendor/cordis/src/logger.ts:251-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L251-L261)）
- 静态初始化块在原型上装 error/info/warn/debug，转发给"调用自身取得的 Logger"的同名方法（[vendor/cordis/src/logger.ts:263-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/logger.ts#L263-L269)）

### vendor/cordis/src/reflect.ts

反射与服务解析层，装为 `ctx.reflect`，同时提供上下文代理的 get/set/has 陷阱、服务注册与依赖唤醒。

- `enhanceError` 砍掉错误栈的前两帧并改写首行，使抛出的属性访问错误指向调用点（[vendor/cordis/src/reflect.ts:73-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L73-L78)）
- `isSpecialProperty` 把符号键、`prototype`/`then`、纯数字串、以及下划线开头的键排除在服务解析之外，走原生反射（[vendor/cordis/src/reflect.ts:80-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L80-L91)）
- get 陷阱：特殊属性直通，已存在的属性经 `getTraceable` 包装后返回（[vendor/cordis/src/reflect.ts:136-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L136-L142)）
- get 陷阱：声明为 accessor 的属性调用其 `get` 钩子，并把携带调用栈的 error 传进去（[vendor/cordis/src/reflect.ts:147-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L147-L150)）
- get 陷阱：根上下文（无 runtime）直接非严格读取 store，插件上下文则走 `internal/get` 瀑布（[vendor/cordis/src/reflect.ts:152-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L152-L153)）
- get 陷阱的默认解析沿 fiber 链向上找依赖快照中的实现；命中 inject 但快照没有时报"inactive context"；到根或隔离标签不一致即抛未 inject 错误（[vendor/cordis/src/reflect.ts:153-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L153-L167)）
- set 陷阱：未声明的属性在根上下文直接写，在插件上下文抛"without provide"（[vendor/cordis/src/reflect.ts:178-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L178-L183)）
- set 陷阱：accessor 无 set 钩子时返回 false 拒绝写入，否则调用其 set；服务属性走 `internal/set` 瀑布，默认落到 `reflect.set`（[vendor/cordis/src/reflect.ts:185-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L185-L196)）
- has 陷阱把已声明的服务/accessor 名也算作上下文自有属性（[vendor/cordis/src/reflect.ts:199-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L199-L205)）
- 构造时把 reflect、fiber、registry、events 的指定方法混入上下文，`ctx.on`、`ctx.plugin`、`ctx.effect`、`ctx.provide` 等由此可直接调用（[vendor/cordis/src/reflect.ts:219-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L219-L222)）
- `_getImpl` 按当前上下文的隔离标签取实现，strict 时要求提供者 fiber 处于 ACTIVE 才返回（[vendor/cordis/src/reflect.ts:237-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L237-L243)）
- `set` 对未 provide 的名字抛错，对非本 fiber 提供的名字抛"multiple fibers"错，否则改写实现记录的值（[vendor/cordis/src/reflect.ts:254-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L254-L265)）
- `provide` 整体是一个 effect：名字已被声明为 accessor 时抛错，否则登记为 service 类型属性（[vendor/cordis/src/reflect.ts:277-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L277-L284)）
- `provide` 在根上下文为该名分配隔离标签符号，同一作用域已有实现时抛出带占用者 fiber 名的错误（[vendor/cordis/src/reflect.ts:286-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L286-L291)）
- `provide` 把实现写入全局 store 与本 fiber 的依赖快照，若 fiber 已 ACTIVE 则立即 notify 唤醒依赖方（[vendor/cordis/src/reflect.ts:292-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L292-L296)）
- `provide` 的 disposer 先删 store 再 notify，等待所有受影响 fiber 结算完毕后，才从自身快照删除该名（保证清理期间自身仍可访问）（[vendor/cordis/src/reflect.ts:297-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L297-L303)）
- `notify` 遍历 registry 里所有 runtime 的所有 fiber，对声明了该依赖且隔离标签匹配的重算 `_checkImpl` 并 `_refresh`，返回被刷新的 fiber（[vendor/cordis/src/reflect.ts:314-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L314-L329)）
- `notify` 随后以一个带 `Context.filter` 的临时上下文 emit `internal/service`，把当前实现值广播给同作用域监听者（[vendor/cordis/src/reflect.ts:330-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L330-L335)）
- `accessor` 作为 effect 注册计算属性，重名时抛错，disposer 删除该声明（[vendor/cordis/src/reflect.ts:345-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L345-L353)）
- `mixin` 用生成器 effect 逐个 yield 出 accessor，把源服务的键映射到上下文键上（[vendor/cordis/src/reflect.ts:364-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L364-L373)）
- mixin 的 get 在源服务为 nullish 时透传，取到函数则绑定到 receiver 叠加而成的对象上，使 `ctx.on` 这类转发保持正确的 `this`（[vendor/cordis/src/reflect.ts:374-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L374-L381)）
- mixin 的 set 把写入反射回源服务（[vendor/cordis/src/reflect.ts:382-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L382-L386)）
- `bind` 用 Proxy 包住回调，apply 时把 `this` 与每个参数都 trace 到本上下文，construct 时同样 trace 参数（[vendor/cordis/src/reflect.ts:408-417](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/reflect.ts#L408-L417)）

### vendor/cordis/src/registry.ts

插件注册表，装为 `ctx.registry` 并把 `ctx.plugin`/`ctx.inject` 混入上下文；同时提供 `@Inject` 装饰器与依赖声明归一化。

- `isApplicable` 判定一个对象是否带可调用的 `apply`，据此识别对象式插件（[vendor/cordis/src/registry.ts:8-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L8-L10)）
- `@Inject` 用在类上时，为该类建一条继承父类 inject 的自有 inject 对象、打上 `checkProto` 标记并写入这一项（[vendor/cordis/src/registry.ts:38-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L38-L44)）
- `@Inject` 用在方法上时，把依赖记入方法 metadata，并通过 initializer 往实例的 initHooks 推一个钩子，使该方法被 `ctx.inject(...)` 包住、依赖齐备时才调用（[vendor/cordis/src/registry.ts:45-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L45-L55)）
- `@Inject` 用在其它位置直接抛错（[vendor/cordis/src/registry.ts:56-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L56-L58)）
- `Inject.resolve` 把数组形式转成各项配置为 null 的映射；带 `checkProto` 的先递归并入原型链上的声明再覆盖自有项；普通对象直接取自有键（[vendor/cordis/src/registry.ts:71-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L71-L88)）
- `counter` 每次读取自增，为新 fiber 分配唯一 uid（[vendor/cordis/src/registry.ts:207-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L207-L209)）
- `resolve` 把函数插件取自身、对象插件取其 `apply` 作为注册表身份键，读取 `apply` 抛错时吞掉并返回 undefined（[vendor/cordis/src/registry.ts:222-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L222-L228)）
- `get`/`has` 按解析出的回调身份查 runtime 记录（[vendor/cordis/src/registry.ts:236-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L236-L250)）
- `delete` 先摘掉 runtime 记录，再逐个 dispose 该插件的全部 fiber（[vendor/cordis/src/registry.ts:258-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L258-L267)）
- `keys`/`values`/`entries`/`forEach` 把内部 map 的遍历暴露出去，`reflect.notify` 借此扫描全部 fiber（[vendor/cordis/src/registry.ts:270-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L270-L291)）
- `inject` 把回调包成 `{ inject, apply, name }` 的对象插件后走 `plugin`（[vendor/cordis/src/registry.ts:300-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L300-L302)）
- `plugin` 对无法解析的插件抛出带实际类型的错误，并 `assertActive` 拒绝在已释放 fiber 上加载（[vendor/cordis/src/registry.ts:316-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L316-L320)）
- `plugin` 首次遇到某回调时建 runtime 记录并保存名字（名字恰为 `'apply'` 时置空）与 `Config` schema，后续同一回调复用该记录（[vendor/cordis/src/registry.ts:322-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L322-L328)）
- `plugin` 以归一化后的 inject 新建 Fiber，并返回一个以该 fiber 为原型、带 `then` 的包装对象，使 `await ctx.plugin(...)` 等到加载结算（[vendor/cordis/src/registry.ts:330-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/registry.ts#L330-L335)）

### vendor/cordis/src/service.ts

服务基类，子类在构造时把自身注册为 `ctx` 上的具名服务。

- 构造函数在 name 缺省时取构造器上的静态 `provide` 字段（[vendor/cordis/src/service.ts:42-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/service.ts#L42-L43)）
- 实例带 `[symbols.invoke]` 时把 this 替换成可调用对象，并把该对象作为构造结果返回，服务因此可以被直接调用（[vendor/cordis/src/service.ts:45-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/service.ts#L45-L58)）
- 构造函数装上 tracker 元数据（关联名 + `ctx` 属性），使该服务被访问时能重绑到调用方上下文（[vendor/cordis/src/service.ts:46-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/service.ts#L46-L55)）
- 构造函数调用 `ctx.reflect.provide(name, self, this[symbols.check])` 完成注册，服务随所属 fiber 卸载而注销（[vendor/cordis/src/service.ts:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/service.ts#L57)）
- `[symbols.filter]` 使以该服务为 `this` 分发的事件只投递给与其同隔离标签的上下文（[vendor/cordis/src/service.ts:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/service.ts#L61-L63)）
- `[symbols.extend]` 派生实例：可调用服务重新造 callable，否则以原实例为原型建对象，再合并附加属性（[vendor/cordis/src/service.ts:65-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/service.ts#L65-L73)）
- `[symbols.resolveConfig]` 沿拦截表原型链按"靠近根的先生效"收集配置，`base` 前置、`head` 后置，服务声明了 `Config.merge` 就用它、否则浅合并（[vendor/cordis/src/service.ts:86-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/service.ts#L86-L102)）
- 自定义 `Symbol.hasInstance` 沿 `prototype.constructor` 链判定，使被代理包装过的服务实例仍能通过 `instanceof`（[vendor/cordis/src/service.ts:104-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/service.ts#L104-L114)）

### vendor/cordis/src/utils.ts

框架内部共用工具：可释放列表、共享符号表、traceable 代理与错误栈拼接，被上下文、服务与 fiber 使用。

- `DisposableList.push` 按自增序号存值并返回只删这一项的删除器，`delete` 借弱表按值 O(1) 删除（[vendor/cordis/src/utils.ts:14-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L14-L25)）
- `DisposableList.clear` 一次性取空并返回逆序快照，卸载据此按注册的反序清理（[vendor/cordis/src/utils.ts:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L27-L31)）
- `DisposableList` 提供迭代器与 Node inspect 钩子，使其可展开遍历与打印（[vendor/cordis/src/utils.ts:33-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L33-L39)）
- 全部内部符号取自 `Symbol.for` 全局注册表，使多份框架副本共享同一套键（[vendor/cordis/src/utils.ts:50-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L50-L73)）
- `isConstructor` 把无 prototype 的（箭头/异步）函数与生成器函数排除在 `new` 调用之外（[vendor/cordis/src/utils.ts:79-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L79-L89)）
- `joinPrototype` 递归地把一条原型链连描述符复制到另一条之上，用于给可调用服务同时保留类原型与 `Function.prototype`（[vendor/cordis/src/utils.ts:92-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L92-L99)）
- `getPropertyDescriptor` 沿原型链查找属性描述符，供 traceable 区分数据属性与取值器（[vendor/cordis/src/utils.ts:107-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L107-L114)）
- `getTraceable` 对自有 shadow 的值返回其原型，对无 tracker 的值原样返回，其余包成 traceable 代理（[vendor/cordis/src/utils.ts:117-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L117-L125)）
- `withProps` 返回把额外属性叠加到目标上的代理，读写命中叠加键时改走叠加对象，但 `constructor` 除外（[vendor/cordis/src/utils.ts:128-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L128-L140)）
- `createShadow` 把服务的原始 `ctx` 包成带 `symbols.shadow` 的扩展上下文并叠加到 receiver 上，`createShadowMethod` 在方法被以外层身份调用时换成该 shadow，并对返回值再 trace（[vendor/cordis/src/utils.ts:149-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L149-L163)）
- `createTraceable` 对非 noShadow 的 tracker 剥掉 shadow 上下文，使其副作用绑定到调用方而非来源（[vendor/cordis/src/utils.ts:165-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L165-L172)）
- traceable 的 get：`symbols.original` 取回原对象、tracker 的 property 键返回当前上下文、符号键走原生反射（[vendor/cordis/src/utils.ts:174-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L174-L183)）
- traceable 的 get：当 `associate.prop` 在上下文中已声明时，改从上下文读取该关联属性（[vendor/cordis/src/utils.ts:180-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L180-L182)）
- traceable 的 get：取值器经 shadow 求值，取到的内层值若自带 tracker 则递归包代理，否则函数值包成 shadow 方法（[vendor/cordis/src/utils.ts:184-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L184-L199)）
- traceable 的 set：拒绝写 `symbols.original` 与 tracker 的 property 键，关联属性改写上下文，其余经 shadow 反射写回（[vendor/cordis/src/utils.ts:201-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L201-L212)）
- `applyTraceable` 在目标带 `[symbols.invoke]` 时把调用转给 invoke 体、并以代理作为其 `this`（[vendor/cordis/src/utils.ts:220-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L220-L223)）
- `createCallable` 造一个函数对象，调用时先按当前 `ctx` 造 traceable 再走 invoke 派发，并设定它的 `name` 与原型（[vendor/cordis/src/utils.ts:226-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L226-L233)）
- `handleError` 对没有字符串 stack 的原因新建 Error 并直接拼上外层栈（[vendor/cordis/src/utils.ts:240-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L240-L250)）
- `handleError` 在原栈中定位内层锚点帧，找不到就原样重抛；找到则回退偏移、跳过 `(<anonymous>)` 帧后截断并接上外层栈，形成长栈（[vendor/cordis/src/utils.ts:252-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L252-L265)）
- `composeError` 对同步抛出与 thenable 拒绝两条路径都接管，交给 `handleError` 重写栈（[vendor/cordis/src/utils.ts:268-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L268-L281)）
- `buildOuterStack` 在调用点先建一个 Error，返回一个惰性切掉前 `3 + offset` 帧的取栈函数（[vendor/cordis/src/utils.ts:284-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/utils.ts#L284-L287)）

### vendor/cordis/tsconfig.json

该包的 TypeScript 编译配置，指定源码目录、声明输出目录与放宽的检查项。

- 无运行期机制
