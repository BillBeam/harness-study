---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/test-support/client-runtime
---

# packages/test-support/client-runtime

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、122 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/test-support/client-runtime/README.md

包说明文档，讲这个 jsdom 测试运行时怎么装配、怎么声明槽位、怎么快照与销毁，供该包的使用者阅读。

- 无运行期机制

### packages/test-support/client-runtime/package.json

包清单，声明该包的入口、导出映射与发布文件白名单。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/test-support/client-runtime/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/package.json#L14-L15)）
- `exports` 只开放根入口、`./invariant`、`./src/*` 原文路径与 `./package.json` 四条解析路径（[packages/test-support/client-runtime/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/test-support/client-runtime/package.json:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/package.json#L74-L78)）

### packages/test-support/client-runtime/src/fixtures.ts

固定值构造模块，给测试运行时提供 Session/Conversation/Chat/Workspace 各自的初始快照值，被 `sessions.ts`、`workspaces.ts` 与 `index.ts` 引用。

- `sessionSnapshot` 返回一份字段齐全的静默态 Session 快照（队列空、未运行、`openState: 'open'`、各错误位为 null）（[packages/test-support/client-runtime/src/fixtures.ts:65-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/fixtures.ts#L65-L83)）
- `conversationSnapshot` 在 `EMPTY_CONVERSATION_SNAPSHOT` 上覆盖调用方给的字段（[packages/test-support/client-runtime/src/fixtures.ts:90-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/fixtures.ts#L90-L94)）
- `chatSnapshot` 在 `EMPTY_CHAT_SNAPSHOT` 上覆盖调用方给的字段（[packages/test-support/client-runtime/src/fixtures.ts:101-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/fixtures.ts#L101-L103)）
- `workspaceSnapshot` 返回空列表、`state: 'idle'`、`phase: 'ready'` 的 Workspace 初始快照（[packages/test-support/client-runtime/src/fixtures.ts:109-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/fixtures.ts#L109-L117)）

### packages/test-support/client-runtime/src/index.ts

包的根入口：装配 Cordis 上下文、槽位注册表、渲染器与会话/工作区替身，并对外给出 `SlotTestRuntime`、`TestRoot` 与若干再导出。

- `bindSnapshotSelector` 把可观察源交给渲染器自己的选择器绑定函数（[packages/test-support/client-runtime/src/index.ts:63-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L63-L65)）
- `createSlotRenderer` 直接返回生产渲染器实例（[packages/test-support/client-runtime/src/index.ts:71-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L71-L73)）
- `OwnerPropsCell.getVersion` 暴露一个随写入递增的版本号，供 `useSyncExternalStore` 配对（[packages/test-support/client-runtime/src/index.ts:124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L124)）
- `OwnerPropsCell.subscribe` 登记回调并返回取消登记的函数（[packages/test-support/client-runtime/src/index.ts:131-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L131-L134)）
- `OwnerPropsCell.set` 写入某 key 的 owner props、版本加一并同步通知全部监听者（[packages/test-support/client-runtime/src/index.ts:142-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L142-L146)）
- `OwnerPropsCell.entries` 按首次写入顺序给出全部 key 与 owner props（[packages/test-support/client-runtime/src/index.ts:149-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L149-L151)）
- `TestRoot.declare` 在 act 包裹内调用真实 `slots.register` 注册名为 `root` 的条目并声明子槽表，保存其 disposer（[packages/test-support/client-runtime/src/index.ts:176-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L176-L185)）
- `TestRoot.release` 调用并清空该 disposer，撤掉 root 注册（[packages/test-support/client-runtime/src/index.ts:187-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L187-L191)）
- `stabilizer` 把每次变更放进 `act(async () => …)` 内执行（[packages/test-support/client-runtime/src/index.ts:212-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L212-L214)）
- 构造函数把会话与工作区替身以 `sessions`/`workspaces` 之名 provide 到上下文（[packages/test-support/client-runtime/src/index.ts:232-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L232-L233)）
- 构造函数用 `slots.provideRoot` 注册 workspaces 钩子源并留下其 disposer（[packages/test-support/client-runtime/src/index.ts:234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L234)）
- 构造函数以包装过的 `renderRoot` 安装渲染器，在转发给真实渲染器的同时截获 host 面（[packages/test-support/client-runtime/src/index.ts:238-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L238-L243)）
- `create` 先注册 DOM 快照序列化器，再新建 Context、挂载 `SlotRegistry` 并等待其就绪（[packages/test-support/client-runtime/src/index.ts:251-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L251-L256)）
- `create` 随后以 ui-session 的 `inject`/`apply` 挂一个插件并等待其完成（[packages/test-support/client-runtime/src/index.ts:257-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L257-L258)）
- `mount` 先解析插件的 `inject`、逐个查 `ctx.get`，缺服务时抛错并列出缺失名字（[packages/test-support/client-runtime/src/index.ts:269-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L269-L273)）
- `mount` 在 act 内挂载插件并等待 fiber 就绪（[packages/test-support/client-runtime/src/index.ts:274-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L274-L277)）
- `mount` 返回的句柄带一次性 `dispose`：重复调用直接返回，首次在 act 内 dispose fiber，并把句柄记入运行时（[packages/test-support/client-runtime/src/index.ts:278-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L278-L288)）
- `releaseWorkspaceSource` 调用构造期留下的 disposer，撤掉默认 workspaces 钩子源（[packages/test-support/client-runtime/src/index.ts:292-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L292-L294)）
- `renderRoot` 用 Testing Library 渲染 `slots.renderSlot('root', {})` 的结果并把视图记入待卸载列表（[packages/test-support/client-runtime/src/index.ts:301-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L301-L305)）
- `declare` 把每个子槽 key 记入 `autoDeclared` 集合（[packages/test-support/client-runtime/src/index.ts:318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L318)）
- `declare` 生成的 AutoFrame 通过 `useSyncExternalStore` 订阅 owner cell，并按 cell 里的条目逐个调用 `props.renderSlot(key, owner)`，外层只包 keyed Fragment（[packages/test-support/client-runtime/src/index.ts:320-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L320-L328)）
- `renderSlot` 对未经 `declare` 的 key 抛错（[packages/test-support/client-runtime/src/index.ts:342-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L342-L344)）
- `renderSlot` 的 `install` 在同步 `act` 内写 owner cell，触发帧重渲染（[packages/test-support/client-runtime/src/index.ts:345-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L345-L351)）
- `renderSlot` 首次调用时才渲染 root 树，之后复用同一视图（[packages/test-support/client-runtime/src/index.ts:352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L352)）
- `renderSlot` 在 root 容器里查 `[data-slot="<key>"]`，找不到 HTMLElement 就抛错，找到则返回该容器、`within` 作用域查询与 `update` 三件（[packages/test-support/client-runtime/src/index.ts:353-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L353-L357)）
- `storeOf` 在 `renderRoot` 之前调用时抛错（host 面尚不存在）（[packages/test-support/client-runtime/src/index.ts:369-372](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L369-L372)）
- `storeOf` 取该 key 账本上的第一条注册，无注册则抛错（[packages/test-support/client-runtime/src/index.ts:373-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L373-L374)）
- `storeOf` 给了 `scopeKey` 时经 `host.scope('session').resolve` 解析绑定，解析不到就抛错（[packages/test-support/client-runtime/src/index.ts:375-380](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L375-L380)）
- `storeOf` 经 `host.storeOf` 取实例，条目未声明 store 时抛错（[packages/test-support/client-runtime/src/index.ts:381-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L381-L383)）
- `flush` 走一次空的 act 过程，冲掉挂起的账本/store 通知（[packages/test-support/client-runtime/src/index.ts:391-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L391-L393)）
- `dispose` 用 `disposed` 标志做幂等，然后依次卸载 React 视图、dispose 特性 fiber、释放 root 注册、dispose 已铸造的会话作用域、清空 `localStorage`（[packages/test-support/client-runtime/src/index.ts:401-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/index.ts#L401-L410)）

### packages/test-support/client-runtime/src/invariant.ts

该包的 invariant 伴生插件，向 `invariants` 服务登记包名。

- 导出插件名与 `inject: ['invariants']`，决定该伴生插件在何服务就绪后才加载（[packages/test-support/client-runtime/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/invariant.ts#L13-L15)）
- 安装器为空实现，登记后不注册任何检查（[packages/test-support/client-runtime/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/invariant.ts#L23)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并把其 disposer 作为结果返回（[packages/test-support/client-runtime/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/invariant.ts#L30-L31)）

### packages/test-support/client-runtime/src/locale-env.ts

浏览器语言钉住助手，供断言本地化文案的测试文件在套件层调用。

- `beforeEach` 用 `Object.defineProperty` 把 `navigator.languages` 与 `navigator.language` 改成调用方给的标签（[packages/test-support/client-runtime/src/locale-env.ts:18-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/locale-env.ts#L18-L21)）
- `afterEach` 删除这两个自有属性，让环境原本的访问器重新露出（[packages/test-support/client-runtime/src/locale-env.ts:22-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/locale-env.ts#L22-L28)）

### packages/test-support/client-runtime/src/remote.ts

Remote 服务替身，让注入 `remote` 的插件能起来并让测试直接投递转发事件。

- 构造函数拒绝会遮蔽自身成员或 `subscriptions` 字段的脚本化命名空间名（[packages/test-support/client-runtime/src/remote.ts:31-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/remote.ts#L31-L37)）
- 构造函数把命名空间面 `Object.assign` 到自身，并以 `remote` 及 `remote.<name>` 之名逐个 provide 到上下文（[packages/test-support/client-runtime/src/remote.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/remote.ts#L38-L40)）
- `emit` 把一条事件的参数原样派发给该事件的当前监听者副本，无监听者时直接返回（[packages/test-support/client-runtime/src/remote.ts:49-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/remote.ts#L49-L53)）
- `$on` 按事件名登记监听者并返回移除它的 disposer（[packages/test-support/client-runtime/src/remote.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/remote.ts#L61-L66)）
- `$mount` 一律返回被拒绝的 Promise（[packages/test-support/client-runtime/src/remote.ts:72-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/remote.ts#L72-L74)）

### packages/test-support/client-runtime/src/sessions.ts

会话侧替身：`FixtureSession` 实现单个会话面，`TestSessions` 实现 `ISessions`，被运行时以 `sessions` 服务提供给被测特性。

- `FixtureSession` 自带一个 `MutableSessionEventSource`，供 Conversation 装配消费（[packages/test-support/client-runtime/src/sessions.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L31)）
- `projections.faceOf` 按 key 缓存一个稳定的可观察面，其 `getSnapshot` 读值表、`subscribe` 登记并返回移除函数（[packages/test-support/client-runtime/src/sessions.ts:51-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L51-L67)）
- `projections.set` 写值并同步通知该 key 的监听者（[packages/test-support/client-runtime/src/sessions.ts:68-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L68-L71)）
- 构造末尾 `Object.assign(this, overrides)` 把 fixture 声明的行为方法覆盖到实例上（[packages/test-support/client-runtime/src/sessions.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L73)）
- `getSnapshot` 与 `subscribe` 转交给 fixture 的快照 store（[packages/test-support/client-runtime/src/sessions.ts:77-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L77-L88)）
- `prompt` 未被 fixture 覆盖时抛错并点名自己（[packages/test-support/client-runtime/src/sessions.ts:94-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L94-L96)）
- `beginSubmission` 递增序号并返回 `test-submission-<n>` 的 requestId 与空的 `abandon`，不动快照（[packages/test-support/client-runtime/src/sessions.ts:104-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L104-L112)）
- `readAttachment`、`updateQueue`、`cancel`、`command`、`loadOlder`、`rename` 未被覆盖时各自抛出点名错误（[packages/test-support/client-runtime/src/sessions.ts:119-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L119-L161)）
- `TestSessions.searchResultLimit` 取自会话控制器的搜索结果上限常量（[packages/test-support/client-runtime/src/sessions.ts:198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L198)）
- 构造函数建立列表 store，初值为空 ids/byId、无 current、`phase: 'ready'`（[packages/test-support/client-runtime/src/sessions.ts:209-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L209-L212)）
- `add` 对重复 id 抛错（[packages/test-support/client-runtime/src/sessions.ts:222-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L222-L223)）
- `add` 用 id 派生列表行默认值（标题取 id、`updatedAt` 取当前记录数加一），再覆盖 fixture 的 summary（[packages/test-support/client-runtime/src/sessions.ts:224-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L224-L231)）
- `add` 以 `sessionSnapshot(id)` 叠加 fixture 覆盖建快照 store，并据此构造 `FixtureSession`（[packages/test-support/client-runtime/src/sessions.ts:232-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L232-L236)）
- `add` 在 fixture 给了 `events` 或 `hasMore` 时用它们 replace 事件源的初始窗口（[packages/test-support/client-runtime/src/sessions.ts:237-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L237-L239)）
- `add` 在 act 内把 id 推入列表、写入行，并在未显式 `current: false` 时把它设为当前（[packages/test-support/client-runtime/src/sessions.ts:248-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L248-L255)）
- `updateSessionSnapshot` 在 act 内以 draft 方式改某会话的生命周期快照（[packages/test-support/client-runtime/src/sessions.ts:263-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L263-L269)）
- `replaceEvents` 在 act 内整体替换某会话的连续事件窗口与 `hasMore`（[packages/test-support/client-runtime/src/sessions.ts:277-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L277-L283)）
- `prependEvents` 在 act 内向窗口前端补一页更旧的事件（[packages/test-support/client-runtime/src/sessions.ts:291-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L291-L297)）
- `appendEvent` 在 act 内向窗口尾部追加一条实时事件（[packages/test-support/client-runtime/src/sessions.ts:304-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L304-L306)）
- `updateSummary` 合并列表行补丁并在 act 内写回列表 store（[packages/test-support/client-runtime/src/sessions.ts:314-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L314-L320)）
- `setCurrent` 校验目标存在（`undefined` 除外）后在 act 内改当前选择（[packages/test-support/client-runtime/src/sessions.ts:326-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L326-L331)）
- `remove` 删记录，并在 act 内从 ids/byId 摘除、必要时清空 current，最后 dispose 该会话已铸造的作用域 fiber（[packages/test-support/client-runtime/src/sessions.ts:339-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L339-L351)）
- `scope` 对已知会话在首次访问时用生产 `createScope` 铸造作用域并缓存 ctx 与 fiber，未知会话返回 undefined（[packages/test-support/client-runtime/src/sessions.ts:360-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L360-L369)）
- `binding` 惰性生成并缓存该会话的绑定（[packages/test-support/client-runtime/src/sessions.ts:376-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L376-L381)）
- `scopeOf` 直接转交生产的 `scopeOf` 读上下文上的会话标记（[packages/test-support/client-runtime/src/sessions.ts:388-390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L388-L390)）
- `sessionOf` 先读上下文的会话标记，再返回对应记录的会话面（[packages/test-support/client-runtime/src/sessions.ts:398-402](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L398-L402)）
- `stubCreate` 安装 create 的替换实现（[packages/test-support/client-runtime/src/sessions.ts:408-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L408-L410)）
- `create` 记录调用；未装 stub 时抛错，装了则调用它并要求返回的 id 已在记录里（[packages/test-support/client-runtime/src/sessions.ts:413-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L413-L421)）
- `open` 记录调用、校验存在，并同步把列表 store 的 current 改成该 id、清掉 currentAddress（[packages/test-support/client-runtime/src/sessions.ts:429-436](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L429-L436)）
- `openSubagent` 记录调用、校验子会话存在，并把 current 与 currentAddress 一并写成该地址（[packages/test-support/client-runtime/src/sessions.ts:439-446](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L439-L446)）
- `subagentAddress` 仅在保留地址的子会话 id 与查询 id 相同时返回该地址（[packages/test-support/client-runtime/src/sessions.ts:449-452](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L449-L452)）
- `setSubagentCatalogOpen` 与 `refreshSubagents` 只把调用记入 `calls`，后者返回已决议的 Promise（[packages/test-support/client-runtime/src/sessions.ts:455-463](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L455-L463)）
- `clear` 记录调用并把 current 与 currentAddress 同时清空（[packages/test-support/client-runtime/src/sessions.ts:466-472](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L466-L472)）
- `refresh` 只记录调用并返回已决议的 Promise（[packages/test-support/client-runtime/src/sessions.ts:475-478](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L475-L478)）
- `stubSearch` 安装搜索结果的替换实现（[packages/test-support/client-runtime/src/sessions.ts:484-486](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L484-L486)）
- `search` 记录 query 与 signal，并返回 stub 的结果或空页（[packages/test-support/client-runtime/src/sessions.ts:496-499](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L496-L499)）
- `fork` 记录调用并原样返回源会话 id，不生成子记录（[packages/test-support/client-runtime/src/sessions.ts:507-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L507-L510)）
- `behavior` 返回该会话的 `FixtureSession` 实例（[packages/test-support/client-runtime/src/sessions.ts:518-520](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L518-L520)）
- `disposeScopes` 逐条 dispose 已铸造的作用域 fiber 并清掉 scope/fiber/binding 缓存（[packages/test-support/client-runtime/src/sessions.ts:523-532](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L523-L532)）
- `bindingOf` 组装 `sessionId` + 会话面 + 事件源 + 作用域 ctx 的绑定，作用域解析不到就抛错（[packages/test-support/client-runtime/src/sessions.ts:534-545](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L534-L545)）
- `require` 对未添加的会话 id 抛错（[packages/test-support/client-runtime/src/sessions.ts:547-551](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/sessions.ts#L547-L551)）

### packages/test-support/client-runtime/src/settings-remote.ts

`settings` Remote 命名空间的脚本化替身，交给 `TestRemote` 作为 `settings` 面使用。

- `answer` 在已发布的命名空间里按 `ns` 查找，命中返回 `ok: true` 与该视图，未命中返回带 `settings-rejected` 码与 `ns` 详情的失败结果（[packages/test-support/client-runtime/src/settings-remote.ts:61-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-remote.ts#L61-L69)）
- `update`/`replace`/`mutate` 是三个 `vi.fn` 间谍，各自把调用转成同一个 `answer`（[packages/test-support/client-runtime/src/settings-remote.ts:70-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-remote.ts#L70-L72)）
- `writable` 缺省为 true、`hasDocument` 缺省为 false（[packages/test-support/client-runtime/src/settings-remote.ts:59-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-remote.ts#L59-L60)）
- `settings.describe` 返回 `ok: true` 与当前 `writable`、`hasDocument` 及已发布命名空间列表（[packages/test-support/client-runtime/src/settings-remote.ts:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-remote.ts#L75)）
- `settings` 面把三个写方法的实参原样转给对应间谍（[packages/test-support/client-runtime/src/settings-remote.ts:74-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-remote.ts#L74-L79)）
- `publish` 替换之后 describe 与写操作看到的命名空间集合（[packages/test-support/client-runtime/src/settings-remote.ts:83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-remote.ts#L83)）

### packages/test-support/client-runtime/src/settings-scope.ts

客户端设置作用域的内存替身，供服务级用例注入。

- 初始快照固定为 `status: 'loading'`、值/base/user/revision 均 undefined、`writable: false`、`mode: 'host'`（[packages/test-support/client-runtime/src/settings-scope.ts:33-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-scope.ts#L33-L36)）
- `set`/`mutate`/`unset` 是三个立即决议的 `vi.fn` 间谍，被同时装进 scope 面与返回句柄（[packages/test-support/client-runtime/src/settings-scope.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-scope.ts#L38-L40)）
- `scope.getSnapshot` 读当前快照，`scope.subscribe` 登记监听者并返回移除函数（[packages/test-support/client-runtime/src/settings-scope.ts:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-scope.ts#L43-L47)）
- `listenerCount` 报出当前订阅数（[packages/test-support/client-runtime/src/settings-scope.ts:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-scope.ts#L55)）
- `publish` 把补丁合并进快照并通知全部监听者副本（[packages/test-support/client-runtime/src/settings-scope.ts:56-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/settings-scope.ts#L56-L59)）

### packages/test-support/client-runtime/src/snapshot.ts

vitest DOM 快照序列化器，由运行时 `create()` 注册，也可被独立用例自行注册。

- `SCOPED_CLASS` 正则识别 `_<local>_<hash>` 形态的作用域类名（[packages/test-support/client-runtime/src/snapshot.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/snapshot.ts#L16)）
- `normalizeClassValue` 拆分 class 值、丢弃空 token、把作用域 token 折回语义局部名后重新拼接（[packages/test-support/client-runtime/src/snapshot.ts:20-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/snapshot.ts#L20-L26)）
- `fingerprint` 对 svg 标记做 FNV-1a 32 位散列并输出 8 位十六进制（[packages/test-support/client-runtime/src/snapshot.ts:29-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/snapshot.ts#L29-L36)）
- `svgsOf` 收集子树里的 svg，根自身是 svg 时也算上（[packages/test-support/client-runtime/src/snapshot.ts:39-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/snapshot.ts#L39-L43)）
- `needsNormalization` 判定子树是否带作用域类名或非空 svg，决定序列化器是否接管（[packages/test-support/client-runtime/src/snapshot.ts:46-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/snapshot.ts#L46-L52)）
- 序列化器的 `test` 仅在有 `Element` 且该元素需要规范化时匹配（[packages/test-support/client-runtime/src/snapshot.ts:60-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/snapshot.ts#L60-L62)）
- `serialize` 先深拷贝元素，改写克隆体上所有 class 值，把非空 svg 折成 `data-content` 指纹并清空其子节点，再交给内建打印器（[packages/test-support/client-runtime/src/snapshot.ts:63-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/snapshot.ts#L63-L75)）
- `registerDomSnapshotSerializer` 用模块级标志保证只向 vitest 的 expect 注册一次（[packages/test-support/client-runtime/src/snapshot.ts:78-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/snapshot.ts#L78-L89)）

### packages/test-support/client-runtime/src/translate.ts

翻译函数替身，让用例把框架注入的 `t` 座位替换成对若干字典的查找。

- `makeTranslate` 返回的函数按字典传入顺序查 key，首个命中的字典胜出，全部落空时保留 key 本身作为模板（[packages/test-support/client-runtime/src/translate.ts:19-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/translate.ts#L19-L27)）
- 给了 params 时把模板里的 `{name}` 替换为对应值，params 里没有的占位符原样保留（[packages/test-support/client-runtime/src/translate.ts:28-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/translate.ts#L28-L31)）

### packages/test-support/client-runtime/src/workspaces.ts

工作区侧替身，实现 `IWorkspaces` 并被运行时以 `workspaces` 服务提供，同时充当渲染器的标准可观察源。

- 构造函数以 `workspaceSnapshot()` 建立列表 store（[packages/test-support/client-runtime/src/workspaces.ts:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/workspaces.ts#L44-L46)）
- `update` 在 act 内以 draft 方式改列表状态（[packages/test-support/client-runtime/src/workspaces.ts:52-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/workspaces.ts#L52-L54)）
- `stub` 按动作名登记替换实现（[packages/test-support/client-runtime/src/workspaces.ts:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/workspaces.ts#L61-L63)）
- `create` 先记录调用，有 stub 走 stub，否则回一份由入参 path 派生的视图（[packages/test-support/client-runtime/src/workspaces.ts:71-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/workspaces.ts#L71-L81)）
- `rename` 先记录调用，有 stub 走 stub，否则回一份带新标题的最小视图（[packages/test-support/client-runtime/src/workspaces.ts:89-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/workspaces.ts#L89-L94)）
- `delete` 记录调用并只在有 stub 时等待其完成（[packages/test-support/client-runtime/src/workspaces.ts:100-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/workspaces.ts#L100-L103)）
- `insertBefore` 记录调用并只在有 stub 时等待其完成（[packages/test-support/client-runtime/src/workspaces.ts:110-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/workspaces.ts#L110-L113)）
- `insertSessionBefore` 记录调用，有 stub 走 stub，否则回一份只含该 session id 的最小视图（[packages/test-support/client-runtime/src/workspaces.ts:122-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/workspaces.ts#L122-L127)）
- `archiveSession` 记录调用，有 stub 走 stub，否则把该 session id 追加进列表状态的归档集合（[packages/test-support/client-runtime/src/workspaces.ts:134-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/src/workspaces.ts#L134-L144)）

### packages/test-support/client-runtime/tsconfig.json

该包的 TypeScript 编译配置，声明基配置、源码/输出目录与工作区项目引用。

- 无运行期机制

### packages/test-support/client-runtime/tsdown.config.ts

该包的打包配置，决定发布产物里存在哪些运行文件。

- 以客户端库预设把 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口打成包清单允许的运行文件（[packages/test-support/client-runtime/tsdown.config.ts:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/client-runtime/tsdown.config.ts#L3-L6)）
