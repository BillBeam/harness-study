---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-renderer
---

# packages/client/ui-renderer

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 13 个文件、107 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-renderer/README.md

浏览器 UI 渲染包的英文说明文档，讲述挂载时机、槽位绑定与已知限制，供阅读者查阅。

- 无运行期机制

### packages/client/ui-renderer/package.json

该包的 npm 清单，决定它以什么入口被 Host Loader 与浏览器加载。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-renderer/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./client` 三个子路径分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，另放开 `./src/*` 与 `./package.json`（[packages/client/ui-renderer/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/package.json#L16-L31)）
- `dsh.client` 声明 `platform: web` 且 `immediately: true`，且不声明任何客户端注入（[packages/client/ui-renderer/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/package.json#L32-L37)）
- 运行期依赖只有 `use-sync-external-store@1.2.0`，cordis 与 invariants 走 peerDependencies（[packages/client/ui-renderer/package.json:43-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/package.json#L43-L49)）
- `files` 只发布 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与 `lib/types/**/*.d.ts`（[packages/client/ui-renderer/package.json:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/package.json#L61-L66)）

### packages/client/ui-renderer/src/client/app.tsx

组装应用树的闭包工厂，被同包 client/index.ts 的 `mount` 使用。

- `buildRenderApp` 返回的工厂每次调用 `ctx.slots.renderSlot('root', {})`，整棵界面树只从 `root` 槽位长出（[packages/client/ui-renderer/src/client/app.tsx:19-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/app.tsx#L19-L22)）

### packages/client/ui-renderer/src/client/bind.ts

把裸观察源转成 React 选择器 Hook 的唯一构造函数，被 bindings.tsx 使用。

- `bindSnapshotSelector` 为每个源只捕获一次 `subscribe`/`getSnapshot` 闭包（并重新绑定 `this`），返回的 Hook 在组件重渲染时不再重新订阅（[packages/client/ui-renderer/src/client/bind.ts:21-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bind.ts#L21-L27)）
- 返回的 Hook 走 `useSyncExternalStoreWithSelector`，服务端快照传 `undefined`，相等性默认 `Object.is`（[packages/client/ui-renderer/src/client/bind.ts:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bind.ts#L24-L26)）

### packages/client/ui-renderer/src/client/bindings.tsx

渲染器内部的 React Context 与观察源绑定工具，被 scoped-slots.tsx 使用。

- `useHost` 在 `HostContext` 为空时抛 `SlotAssemblyError`，槽位机制在渲染器树外渲染即失败（[packages/client/ui-renderer/src/client/bindings.tsx:23-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bindings.tsx#L23-L27)）
- `useRootBinding` 在无根标准源 Provider 时抛错（[packages/client/ui-renderer/src/client/bindings.tsx:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bindings.tsx#L36-L40)）
- `useScopeBinding` 在无作用域 Provider 时抛错（[packages/client/ui-renderer/src/client/bindings.tsx:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bindings.tsx#L46-L50)）
- `observableHook` 用 WeakMap 按源对象缓存 Hook，同一个源在多处绑定得到同一个 Hook 引用（[packages/client/ui-renderer/src/client/bindings.tsx:57-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bindings.tsx#L57-L66)）
- `absentSource` 是一个快照恒为 `undefined`、订阅返回空函数的常量源（[packages/client/ui-renderer/src/client/bindings.tsx:67-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bindings.tsx#L67-L70)）
- `maybeObservableHook` 在源缺席时返回 `useAbsentSnapshot`，后者仍调用一次 uSES，使 Hook 调用顺序在有无源之间保持一致（[packages/client/ui-renderer/src/client/bindings.tsx:77-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bindings.tsx#L77-L90)）
- `keyedObservableHook` 把按键解析器缓存成一个开放键 Hook，每次以 `source(key) ?? absentSource` 取源再绑定；解析器缺席时走 `absentKeyedHook`（[packages/client/ui-renderer/src/client/bindings.tsx:104-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bindings.tsx#L104-L120)）
- `RootStandardProvider` 订阅 `host.root` 并把当前根绑定放进 Context，根源名册变化即向下重渲染（[packages/client/ui-renderer/src/client/bindings.tsx:123-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bindings.tsx#L123-L127)）
- `ScopeProvider` 先订阅 `host.scopeRevision`，再解析该作用域适配器，缺适配器时抛 `SlotAssemblyError`，否则订阅 `adapter.current` 并下发绑定（[packages/client/ui-renderer/src/client/bindings.tsx:130-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/bindings.tsx#L130-L143)）

### packages/client/ui-renderer/src/client/index.ts

该包的浏览器插件入口，安装槽位渲染器并向引导内核提供 `ctx.uiRenderer.mount`。

- 插件 `inject` 为空数组（[packages/client/ui-renderer/src/client/index.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/index.ts#L51)）
- `BootHandoff` 首帧原样渲染引导内核留下的 DOM（`className` + `dangerouslySetInnerHTML`），在 `useLayoutEffect` 里置 `ready` 后才换成应用树（[packages/client/ui-renderer/src/client/index.ts:59-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/index.ts#L59-L68)）
- `mountApp` 查找容器直接子元素 `[data-dsh-boot]`：存在则用 `hydrateRoot` 接管引导 DOM，不存在则 `createRoot` 并用 `flushSync` 同步渲染首帧（[packages/client/ui-renderer/src/client/index.ts:71-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/index.ts#L71-L82)）
- `apply` 新建 `SlotRegistry` 并把 `createSlotRenderer()` 装进去（[packages/client/ui-renderer/src/client/index.ts:89-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/index.ts#L89-L90)）
- `apply` 通过 `ctx.reflect.provide('uiRenderer', …)` 暴露 `mount(container)`，返回的 disposer 调用 `root.unmount()`（[packages/client/ui-renderer/src/client/index.ts:91-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/index.ts#L91-L96)）

### packages/client/ui-renderer/src/client/registry.ts

`ctx.slots` 服务本体，在纯核 SlotCore 之上加事件桥、fiber 归属的注册/声明效果、渲染器安装契约与 Store 实例轴。

- 构造时以服务名 `slots` 注册，并把核的每次变更转成 `ctx.emit('slots/changed', key)`（[packages/client/ui-renderer/src/client/registry.ts:133-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L133-L136)）
- `register` 以原型方法而非实例箭头函数存在，使服务代理把 `this.ctx` 绑到调用方上下文，注册效果与卸载级联落在调用方 fiber（[packages/client/ui-renderer/src/client/registry.ts:155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L155)）
- 原型上的 `register` 实现把每次注册包进 `this.ctx.effect(…, 'slots.register()')`，直接返回 effect 的 disposer（[packages/client/ui-renderer/src/client/registry.ts:606-613](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L606-L613)）
- `inject(key, callback)` 订阅某个槽位声明，声明存在时同步运行回调，声明纪元变化时先销毁旧效果再重跑（[packages/client/ui-renderer/src/client/registry.ts:192-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L192-L208)）
- `inject` 的回调本身跑在嵌套的 `ctx.effect` 里，因而获得事务化安装与逆序拆卸（[packages/client/ui-renderer/src/client/registry.ts:205-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L205-L207)）
- `inject` 的变更回调捕获异常：`INACTIVE_EFFECT` 直接停止，其他错误停止后用 `queueMicrotask` 重新抛到宏观栈；一次失败即永久退休该注入（[packages/client/ui-renderer/src/client/registry.ts:210-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L210-L222)）
- `install(renderer)` 第二次调用抛错，安装本身走 `ctx.effect`，安装方 fiber 卸载即摘掉渲染器（[packages/client/ui-renderer/src/client/registry.ts:242-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L242-L250)）
- `installLocale(face)` 同样是一次性安装并随安装方 fiber 卸载（[packages/client/ui-renderer/src/client/registry.ts:259-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L259-L267)）
- `provideRoot` 把贡献推入名册并重建根绑定，重建抛错则回滚该贡献；disposer 摘除贡献后再次重建（[packages/client/ui-renderer/src/client/registry.ts:275-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L275-L292)）
- `installScope` 每个严格作用域只接受一个适配器，重复安装抛错；装卸都推进一次作用域版本号（[packages/client/ui-renderer/src/client/registry.ts:300-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L300-L315)）
- `bindStoreScope` 把某个作用域键的清理挂到当前拥有它的 Context 上，重复绑定同键会把清理归属转给最新一代 Context（[packages/client/ui-renderer/src/client/registry.ts:326-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L326-L335)）
- `renderSlot` 三道硬检查：键不是 `'root'` 抛错、渲染器未安装抛错、`'root'` 无注册抛错，全部通过才调 `renderer.renderRoot(hostFace(), owner)`（[packages/client/ui-renderer/src/client/registry.ts:345-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L345-L359)）
- `entries`/`entriesOfSlot`/`snapshot` 把核的条目视图、逐格胜出者视图与 JSON 声明树暴露出去（[packages/client/ui-renderer/src/client/registry.ts:366-390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L366-L390)）
- `onEntryError` 把核的条目崩溃报告转出去，回调带上是否退位的信息（[packages/client/ui-renderer/src/client/registry.ts:403-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L403-L405)）
- `spec` 把某个键的已声明规格读出来（[packages/client/ui-renderer/src/client/registry.ts:412-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L412-L414)）
- `subscribe`/`getVersion` 提供按键的微任务批处理订阅与版本计数，供 uSES 配对（[packages/client/ui-renderer/src/client/registry.ts:422-433](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L422-L433)）
- `_register` 把 `store` 为函数的情况当独占工厂当场铸成一个 per-entry 句柄（[packages/client/ui-renderer/src/client/registry.ts:440](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L440)）
- `_register` 在没有显式 `registrant` 时用调用方 fiber 的 `name` 盖戳（[packages/client/ui-renderer/src/client/registry.ts:441-446](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L441-L446)）
- `_register` 先写核（所有加载期校验在那里抛），成功后才在实例轴上 `_acquire`，返回的 disposer 幂等并释放句柄（[packages/client/ui-renderer/src/client/registry.ts:450-461](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L450-L461)）
- `hostFace` 只构造一次并缓存，`locale` 做成实时 getter，使语言面在自身 fiber 上装卸而不冻结在旧引用（[packages/client/ui-renderer/src/client/registry.ts:465-491](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L465-L491)）
- host 面的 `storeOf` 在条目声明了 store 时把句柄按作用域绑定解析成实例，未声明则给 `undefined`（[packages/client/ui-renderer/src/client/registry.ts:481-484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L481-L484)）
- host 面把 `'session-maybe'` 的作用域查询别名到已安装的 `'session'` 适配器（[packages/client/ui-renderer/src/client/registry.ts:487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L487)）
- `rebuildRootBinding` 遍历全部根贡献合并 hooks/keyedHooks/props，整体替换为一个新的根绑定对象，然后逐个通知监听者并吞掉单个监听者的异常（打到 console.error）（[packages/client/ui-renderer/src/client/registry.ts:494-512](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L494-L512)）
- `publishScopeRevision` 递增版本号后逐个通知作用域监听者，同样吞掉单个监听者异常（[packages/client/ui-renderer/src/client/registry.ts:515-524](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L515-L524)）
- `resolveStore` 对未注册句柄抛错；root 作用域用固定键 `'root'`，非 root 作用域缺会话键抛错并顺带 `bindStoreScope`（[packages/client/ui-renderer/src/client/registry.ts:527-540](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L527-L540)）
- `resolveStore` 首次解析时创建实例并缓存，root 实例不带键、会话实例带作用域键创建（[packages/client/ui-renderer/src/client/registry.ts:542-548](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L542-L548)）
- `clearStoreScope` 在作用域死亡时遍历所有非 root 句柄，必要时先造出实例再 `clearPersisted()` 并删除（[packages/client/ui-renderer/src/client/registry.ts:552-559](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L552-L559)）
- `_acquire`/`_release` 按句柄计数，最后一个持有者卸载时删除整条记录，实例随之丢弃（[packages/client/ui-renderer/src/client/registry.ts:562-581](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L562-L581)）
- `copyUnique` 在两个根贡献落到同一个 prop 名时抛错，阻止重复的标准 hook/prop 进入绑定（[packages/client/ui-renderer/src/client/registry.ts:584-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/registry.ts#L584-L600)）

### packages/client/ui-renderer/src/client/scoped-slots.tsx

声明式槽位的 React 渲染器实现，由 client/index.ts 在启动时装入 `ctx.slots`。

- `boundRenderSlot` 按条目缓存出一个身份稳定的 `renderSlot` 闭包；条目已销毁时抛 `StaleAuthorizationError`，目标键不在该条目 `children` 里抛 `SlotOwnershipError`，`chain` 类槽位也拒绝（[packages/client/ui-renderer/src/client/scoped-slots.tsx:41-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L41-L61)）
- `boundRenderSlotChain` 是同一条轴上的链式派发闭包，非 `chain` 类槽位反向拒绝（[packages/client/ui-renderer/src/client/scoped-slots.tsx:71-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L71-L90)）
- `runInject` 按声明推导位置参数：会话作用域传 `binding.key`，声明了 store 时再传 `actions`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:104-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L104-L113)）
- `bindInjectHooks` 把 inject 结果里的 `hooks` 隔间逐个绑成 `use<Name>` prop，原 `hooks` 键被摘掉（[packages/client/ui-renderer/src/client/scoped-slots.tsx:119-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L119-L129)）
- `cachedSlotInject` 按 inject 面对象身份缓存，把函数型定义留作延迟工厂、观察源型定义当场绑成 Hook prop（[packages/client/ui-renderer/src/client/scoped-slots.tsx:135-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L135-L162)）
- `bindSlotHookFactories` 在渲染点用标准 props 与 `hookContext` 调用每个工厂，产出 `use<Name>` prop（[packages/client/ui-renderer/src/client/scoped-slots.tsx:165-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L165-L176)）
- 三个 inject 缓存分别按条目、按（条目 × 作用域绑定）记忆化，使 inject 工厂在同一会话内只跑一次（[packages/client/ui-renderer/src/client/scoped-slots.tsx:178-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L178-L217)）
- `localeSeat` 按（语言面, 命名空间, 修订号）缓存 `t`，每换一个修订号铸出新函数引用，从而让 `React.memo` 组件靠浅比较重渲染（[packages/client/ui-renderer/src/client/scoped-slots.tsx:229-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L229-L243)）
- `localeSubscription` 按语言面身份缓存 subscribe/getSnapshot 闭包对，避免每次渲染都退订重订（[packages/client/ui-renderer/src/client/scoped-slots.tsx:259-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L259-L269)）
- `useLocaleRevision` 无论语言面是否安装都恰好调用一次 uSES（未装时快照恒为 0），保持 Hook 顺序稳定（[packages/client/ui-renderer/src/client/scoped-slots.tsx:279-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L279-L285)）
- `entryKeyOf` 给每个条目分配一个自增数字并 WeakMap 缓存，作为错误边界的 React key，胜出者更换时边界整体重挂（[packages/client/ui-renderer/src/client/scoped-slots.tsx:297-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L297-L307)）
- `SlotErrorBoundary` 在 `getDerivedStateFromError` 里对 `SlotAssemblyError` 原样重抛，其余错误转入失败态（[packages/client/ui-renderer/src/client/scoped-slots.tsx:323-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L323-L326)）
- `SlotErrorBoundary` 捕获后打 `console.error` 并调 `onEntryError`，失败态渲染成 `<div data-slot-error="<key>">`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:327-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L327-L334)）
- `materializeStandardBinding` 把绑定里的 hooks/keyedHooks 落成 `use<Name>` prop；严格作用域下缺源直接抛 `SlotAssemblyError`，可选作用域下退化成"恒为 undefined"的 Hook（[packages/client/ui-renderer/src/client/scoped-slots.tsx:342-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L342-L359)）
- `standardProps` 缓存根标准 props，并按（根绑定 × 作用域绑定）缓存"根覆盖作用域"的合并结果；作用域绑定缺席时抛错（[packages/client/ui-renderer/src/client/scoped-slots.tsx:362-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L362-L388)）
- `scopeAreaProvider` 把适配器的 `renderArea` 绑成一个稳定组件；适配器没有该方法时抛错（[packages/client/ui-renderer/src/client/scoped-slots.tsx:393-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L393-L405)）
- `standardKit` 在条目声明了 `locale` 而没有已安装语言面时抛 `SlotAssemblyError`，否则塞入 `t` 座位（[packages/client/ui-renderer/src/client/scoped-slots.tsx:432-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L432-L441)）
- `standardKit` 解析到 store 实例时把实例本身当观察源绑成 `useStore`，并把 `store.actions` 放进 `actions` prop（[packages/client/ui-renderer/src/client/scoped-slots.tsx:442-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L442-L451)）
- `standardKit` 只在条目声明了 children 时发 `renderSlot` 座位；children 中含 chain 类才另发 `renderSlotChain`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:452-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L452-L458)）
- `standardKit` 在 children 含 session 作用域槽位时发 `SessionProvider` 座位，缺 session 适配器则抛错（[packages/client/ui-renderer/src/client/scoped-slots.tsx:461-467](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L461-L467)）
- `ContextualEntry` 用 `useMemo` 按 `[hasHookContext, hookContext, factories, slotKey, standard]` 绑定上下文 Hook；缺 `hookContext` 时抛 `SlotAssemblyError`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:490-498](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L490-L498)）
- 条目组件的 props 合并次序固定为 kit → 条目 inject → 槽位 inject → 上下文 Hook → owner props，owner 覆盖其余（[packages/client/ui-renderer/src/client/scoped-slots.tsx:499](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L499)）
- `renderEntry` 在没有延迟工厂时直接渲染组件、不引入额外一层，有工厂时才走 `ContextualEntry`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:502-529](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L502-L529)）
- `SessionEntry` 以 `'session'` 作用域合成 kit 并取按会话缓存的 inject 结果（[packages/client/ui-renderer/src/client/scoped-slots.tsx:531-546](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L531-L546)）
- `SessionMaybeEntryBody` 以 `'session-maybe'` 作用域合成 kit 与 inject 结果（[packages/client/ui-renderer/src/client/scoped-slots.tsx:548-563](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L548-L563)）
- `SessionMaybeEntry` 用渲染期 `setState` 维护"化身"状态：无会话时诞生的化身收养第一个到来的会话且不重挂；收养后换会话或退回无会话都把 `epoch` 加一，从而以 `key={epoch}` 重挂子树（[packages/client/ui-renderer/src/client/scoped-slots.tsx:593-621](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L593-L621)）
- `RootEntry` 以 `'root'` 作用域合成 kit 并取按条目缓存的 inject 结果（[packages/client/ui-renderer/src/client/scoped-slots.tsx:634-648](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L634-L648)）
- `StrictSessionEntry` 在作用域绑定无会话键时抛 `SlotAssemblyError`，并把错误边界的 key 设为会话 id，使换会话即重挂（[packages/client/ui-renderer/src/client/scoped-slots.tsx:659-677](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L659-L677)）
- `ANCHOR_STYLE` 是模块级常量 `{ display: 'contents' }`，让每个出口包装层不参与布局且引用稳定（[packages/client/ui-renderer/src/client/scoped-slots.tsx:686](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L686)）
- `SlotOutlet` 用 uSES 订阅该键的注册版本号，注册变化即重渲染（[packages/client/ui-renderer/src/client/scoped-slots.tsx:695-698](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L695-L698)）
- `SlotOutlet` 无论派发结果如何都渲染一层 `<div data-slot="<key>">` 锚点，回退、崩溃面与未声明空态都在锚点内（[packages/client/ui-renderer/src/client/scoped-slots.tsx:709-713](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L709-L713)）
- `renderOutletContent` 对未声明（或已不再声明）的键渲染 `null`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:724-728](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L724-L728)）
- `renderOutletContent` 对 chain 键的 `fallbackOnly` 选项直接走"无当选"分支（[packages/client/ui-renderer/src/client/scoped-slots.tsx:729-731](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L729-L731)）
- `renderOutletContent` 对 session 作用域槽位在无会话绑定时抛 `SlotAssemblyError`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:732-734](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L732-L734)）
- `guarded` 把错误边界包在条目元素外层，使 inject 工厂与 kit 合成的崩溃也落进该条目的回退面（[packages/client/ui-renderer/src/client/scoped-slots.tsx:741-789](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L741-L789)）
- 崩溃上报时 `abdicate` 取 `spec.kind !== 'chain'`：遮蔽类槽位崩溃即退位换下一位幸存者，chain 只上报不退位（[packages/client/ui-renderer/src/client/scoped-slots.tsx:748-750](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L748-L750)）
- `single` 键取胜出者的第一个；无胜出者但有注册时渲染崩溃面 `deadCell()`，完全无注册时渲染 `opts.fallback`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:793-799](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L793-L799)）
- `keyed` 键按 `opts.entryKey` 在胜出者里找；找不到但该键有注册渲染崩溃面，否则渲染回退（[packages/client/ui-renderer/src/client/scoped-slots.tsx:800-807](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L800-L807)）
- `chain` 键按优先序逐个跑纯选择器，第一个返回非 null 的当选并把 `matched` 并入 owner props 后渲染，其余不挂载（[packages/client/ui-renderer/src/client/scoped-slots.tsx:814-836](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L814-L836)）
- chain 选择器抛异常时被降级为"弃权"：打 `console.error` 并 `continue`，链与回退保持完整（[packages/client/ui-renderer/src/client/scoped-slots.tsx:820-830](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L820-L830)）
- `list` 键先取每格胜出者成行，再为全员退位的干涸格补一行占位；行序按 `order` 升序排序，`opts.only` 再按 id 过滤（[packages/client/ui-renderer/src/client/scoped-slots.tsx:842-857](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L842-L857)）
- list 的胜出行以 `e<entryKey>` 为 key、干涸行以 `x<id>` 为 key，两套前缀不相撞（[packages/client/ui-renderer/src/client/scoped-slots.tsx:860-866](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L860-L866)）
- `renderChainResult` 在非 overlay 模式下当选为空即渲染回退；overlay 模式下回退始终挂在树上，靠 `display` 在 `contents`/`none` 之间切换（[packages/client/ui-renderer/src/client/scoped-slots.tsx:870-887](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L870-L887)）
- `RootOutlet` 订阅 `'root'` 的版本号与语言修订号；无胜出者但有注册时渲染 `<div data-slot-error="root">`，一条注册都没有则抛 `SlotAssemblyError`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:890-904](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L890-L904)）
- `RootOutlet` 的根条目崩溃固定以 `abdicate: true` 上报（[packages/client/ui-renderer/src/client/scoped-slots.tsx:909-913](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L909-L913)）
- `createSlotRenderer` 返回的 `renderRoot` 固定嵌套 `HostContext.Provider` → `RootStandardProvider` → `ScopeProvider scope="session-maybe"` → `RootOutlet`（[packages/client/ui-renderer/src/client/scoped-slots.tsx:933-946](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/client/scoped-slots.tsx#L933-L946)）

### packages/client/ui-renderer/src/client/use-sync-external-store.d.ts

为 `use-sync-external-store/shim/with-selector.js` 补的本地类型声明文件。

- 无运行期机制

### packages/client/ui-renderer/src/index.ts

该包的 Host 侧加载入口。

- 无运行期机制

### packages/client/ui-renderer/src/invariant.ts

该包自带的运行期不变式伴生插件。

- 声明插件名 `client-ui-renderer-invariant` 并注入 `invariants` 服务（[packages/client/ui-renderer/src/invariant.ts:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/invariant.ts#L17-L19)）
- 安装器以 `{ global: true }` 监听 `internal/dispatch`，只处理 `slots/changed` 事件（[packages/client/ui-renderer/src/invariant.ts:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/invariant.ts#L25-L28)）
- 事件参数不是非空字符串时报失败（[packages/client/ui-renderer/src/invariant.ts:29-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/invariant.ts#L29-L33)）
- 该键在 `ctx.get('slots')` 上的版本号仍为 0 时报失败，即事件必须在变更落地之后才发（[packages/client/ui-renderer/src/invariant.ts:34-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/invariant.ts#L34-L37)）
- `apply` 以包名 `@deepseek-ai/dsh-client-ui-renderer` 向 `ctx.invariants` 注册安装器并返回 disposer（[packages/client/ui-renderer/src/invariant.ts:45-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/src/invariant.ts#L45-L46)）

### packages/client/ui-renderer/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制

### packages/client/ui-renderer/tsdown.config.ts

该包的打包配置，决定发布到 `lib/` 的运行期产物。

- 以插件 id `@deepseek-ai/dsh-client-ui-renderer` 调用 `clientBundle`，Node 半边打出 `lib/index.js` 与 `lib/invariant.js`，浏览器半边另打出包在 `window.__ModuleLoader__.load` 里的 `lib/client.js`（[packages/client/ui-renderer/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-renderer/tsdown.config.ts#L1-L3)）
