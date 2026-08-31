---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-settings
---

# packages/client/ui-settings

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 13 个文件、65 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-settings/README.md

设置域基础包的英文说明文档，讲述命名空间作用域、描述镜像与它声明的槽位类型，供阅读者查阅。

- 无运行期机制

### packages/client/ui-settings/package.json

该包的 npm 清单，决定它以什么入口被加载、客户端加载时先等谁、以及带哪些运行期依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-settings/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./client` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，另放开 `./src/*` 与 `./package.json`（[packages/client/ui-settings/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/package.json#L16-L31)）
- `dsh.client` 声明客户端注入 `@deepseek-ai/dsh-client-connection` 与 `@deepseek-ai/dsh-api-remotes`，平台限定为 `web`（[packages/client/ui-settings/package.json:32-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/package.json#L32-L40)）
- 唯一运行期依赖是 `@deepseek-ai/schemastery`（[packages/client/ui-settings/package.json:46-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/package.json#L46-L48)）
- `files` 只发布 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与 `lib/types/**/*.d.ts`（[packages/client/ui-settings/package.json:68-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/package.json#L68-L73)）

### packages/client/ui-settings/src/client/contract/slots.ts

设置域的槽位类型声明文件，用 `declare module` 往 `SlotMap` 里合并八个设置类槽位及其 owner props 接口。

- 无运行期机制

### packages/client/ui-settings/src/client/index.ts

该包的浏览器插件入口：提供 `ctx.settingsScope`、`ctx.settingsSchema`，并持有浏览器里唯一的 `settings.describe` 读取者。

- 插件声明注入 `connection`、`remote`、`remote.settings`（[packages/client/ui-settings/src/client/index.ts:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/index.ts#L43)）
- `apply` 在本插件 fiber 内构造 `SettingsSchemaService`（服务名 `settingsSchema`）（[packages/client/ui-settings/src/client/index.ts:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/index.ts#L55)）
- `apply` 在这里一次性捕获 `ctx.remote.settings` 作为 wire 面，使后续每个绑定的作用域不必各自声明该注入（[packages/client/ui-settings/src/client/index.ts:56-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/index.ts#L56-L59)）
- 镜像的持久化模式由 `connection.isLoopback` 决定：环回连接为 `host`，否则为 `memory`（[packages/client/ui-settings/src/client/index.ts:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/index.ts#L60)）
- `apply` 用 `ctx.effect` 订阅两条失效信号——转发来的 `settings/document-updated` 与 `connection/reset`——两者都触发 `mirror.load()`（[packages/client/ui-settings/src/client/index.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/index.ts#L61-L66)）
- 同一个 effect 里立即发一次 `mirror.ensure()`，并在拆卸时逐个退订（[packages/client/ui-settings/src/client/index.ts:70-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/index.ts#L70-L71)）
- `apply` 最后构造 `SettingsScopeBinder`，把镜像、schema 服务与 wire 面交给它（[packages/client/ui-settings/src/client/index.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/index.ts#L73)）

### packages/client/ui-settings/src/client/schema.ts

`ctx.settingsSchema` 服务：同步的 schema 复水、校验与不可变路径编辑，被 settings-scope.ts 与各设置页使用。

- `cloneContainer` 按容器类型浅拷贝；容器缺失时按下一段路径键是否为纯数字决定造数组还是造对象（[packages/client/ui-settings/src/client/schema.ts:9-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L9-L13)）
- `cloneSpine` 沿路径逐层复制出一条新脊，返回新根、叶的父容器与叶键，原对象不被改动（[packages/client/ui-settings/src/client/schema.ts:15-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L15-L33)）
- 构造函数以服务名 `settingsSchema` 注册（[packages/client/ui-settings/src/client/schema.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L41-L43)）
- `rehydrate` 把序列化的 schema 信封 `new Schema(...)` 成活节点（[packages/client/ui-settings/src/client/schema.ts:50-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L50-L52)）
- `validate` 把 schema 当函数调用，通过返回 `undefined`，抛错则返回错误文本（[packages/client/ui-settings/src/client/schema.ts:60-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L60-L67)）
- `nodeAtPath` 逐段下钻：`object` 取 `dict[key]`，`dict`/`array` 取 `inner`，其他类型直接返回 `undefined`（[packages/client/ui-settings/src/client/schema.ts:75-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L75-L84)）
- `getPath` 按字符串键或数组下标逐段读值，遇到非对象即返回 `undefined`（[packages/client/ui-settings/src/client/schema.ts:92-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L92-L103)）
- `hasPath` 只看末段键是否存在而不看值：数组比长度，对象用 `in`（[packages/client/ui-settings/src/client/schema.ts:111-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L111-L118)）
- `setPath` 空路径抛错，否则在复制出的脊上写入新值并返回新根（[packages/client/ui-settings/src/client/schema.ts:128-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L128-L134)）
- `deletePath` 空路径抛错；路径不存在时原样返回旧根；存在时数组用 `splice`、对象用 `Reflect.deleteProperty`（[packages/client/ui-settings/src/client/schema.ts:143-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/schema.ts#L143-L150)）

### packages/client/ui-settings/src/client/settings-contract.ts

设置命名空间作用域的类型契约文件，只含快照、规格与作用域三个接口声明。

- 无运行期机制

### packages/client/ui-settings/src/client/settings-mirror.ts

浏览器侧设置文档镜像，是全浏览器唯一的 `settings.describe` 读取者，所有设置界面都从它派生。

- 构造时按持久化模式决定初始状态：`host` 起于 `idle`（`ensure` 会去读），`memory` 直接是终态 `unavailable`（[packages/client/ui-settings/src/client/settings-mirror.ts:98-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L98-L107)）
- `getSnapshot`/`subscribe` 把内部快照 store 暴露给派生面（[packages/client/ui-settings/src/client/settings-mirror.ts:110-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L110-L121)）
- `load` 在 `memory` 模式下直接 resolve、不上线；已有在飞读取时只置 `rerun` 并复用同一个 promise，不并发第二次线上读（[packages/client/ui-settings/src/client/settings-mirror.ts:128-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L128-L134)）
- `load` 先把 in-flight 槽位占住再进入 `run`，避免 loading 发布同步重入时丢读（[packages/client/ui-settings/src/client/settings-mirror.ts:135-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L135-L137)）
- `ensure` 只在 `idle` 状态发起读取，已有在飞读取则挂上去，`memory` 模式直接 resolve（[packages/client/ui-settings/src/client/settings-mirror.ts:146-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L146-L151)）
- `acceptView` 递增代号使任何在飞读取作废，并在有在飞读取时置 `rerun`（[packages/client/ui-settings/src/client/settings-mirror.ts:161-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L161-L163)）
- `acceptView` 在尚无已持文档时不发布这条答案（不把写回答当成半个文档），有文档时按命名空间原地替换或追加后写回 store，全程不走线（[packages/client/ui-settings/src/client/settings-mirror.ts:164-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L164-L168)）
- `namespace` 在已持视图里按 `ns` 查一行（[packages/client/ui-settings/src/client/settings-mirror.ts:176-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L176-L178)）
- `run` 以 do-while 循环执行读取，每轮开头把 `idle` 抬成 `loading`，并在发线上请求之前清掉 `rerun`（[packages/client/ui-settings/src/client/settings-mirror.ts:186-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L186-L193)）
- `run` 把 `describe()` 的失败结果与抛出的异常都归一成 `{ failure }`（[packages/client/ui-settings/src/client/settings-mirror.ts:194-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L194-L203)）
- 读取回来时代号已变（期间有写回答落地）则丢弃这次结果并进入下一轮（[packages/client/ui-settings/src/client/settings-mirror.ts:204-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L204-L205)）
- 读取成功发布 `ready` 并清空 error；失败时若还没有任何已持视图则退回 `idle`（让 `ensure` 再试），已有视图则保持 `ready` 继续供服务、只把失败写进 `error` 字段（[packages/client/ui-settings/src/client/settings-mirror.ts:206-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L206-L217)）
- `run` 的 `finally` 在同一同步段里清空 in-flight 槽位（[packages/client/ui-settings/src/client/settings-mirror.ts:219-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-mirror.ts#L219-L221)）

### packages/client/ui-settings/src/client/settings-scope.ts

单命名空间作用域的派生与串行写入路径，以及提供 `ctx.settingsScope` 的绑定服务。

- 控制器构造时按持久化模式给出初始快照：`host` 起于 `loading`，`memory` 起于 `unavailable` 且 `writable` 为 false（[packages/client/ui-settings/src/client/settings-scope.ts:70-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L70-L78)）
- 只有 `host` 模式才订阅镜像并立刻派生一次；`memory` 模式全程不订阅（[packages/client/ui-settings/src/client/settings-scope.ts:79-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L79-L82)）
- `set` 与 `unset` 都折成单操作的 `mutate`（[packages/client/ui-settings/src/client/settings-scope.ts:106-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L106-L118)）
- `mutate` 入队前 `structuredClone` 操作数组，调用方之后改动不影响已排队的写（[packages/client/ui-settings/src/client/settings-scope.ts:127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L127)）
- 写入的修订栅栏取 `expectedRevision ?? pendingRevision ?? 当前快照 revision`（[packages/client/ui-settings/src/client/settings-scope.ts:130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L130)）
- 线上写抛异常或返回非 ok，都走 `recover`（[packages/client/ui-settings/src/client/settings-scope.ts:131-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L131-L141)）
- 写成功后：本代是最新代则清空 `pendingRevision` 并把答案折进镜像；已被后来的写取代则只把答案里的 revision 记进 `pendingRevision` 供后继当栅栏（[packages/client/ui-settings/src/client/settings-scope.ts:142-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L142-L148)）
- `recover` 只为最新一代失败写触发一次 `mirror.load()`，被取代的失败交给它的后继（[packages/client/ui-settings/src/client/settings-scope.ts:153-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L153-L157)）
- `dispose` 置停、递增写代号使在飞写作废、退订镜像，并等待队尾结算（[packages/client/ui-settings/src/client/settings-scope.ts:164-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L164-L169)）
- `enqueue` 在 `memory` 模式或已销毁时直接 resolve、不排队；否则把操作接在队尾串行执行，并在执行前再查一次销毁标志（[packages/client/ui-settings/src/client/settings-scope.ts:171-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L171-L177)）
- 队尾保存的是被 `catch` 吞掉异常的 promise，一次失败不会卡死后续操作，而调用方拿到的仍是带异常的那个（[packages/client/ui-settings/src/client/settings-scope.ts:178-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L178-L180)）
- `derive` 在镜像尚无视图时不动快照（[packages/client/ui-settings/src/client/settings-scope.ts:183-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L183-L186)）
- `derive` 在文档里找不到本命名空间时把状态置 `unavailable` 并同步文档级 `writable`（[packages/client/ui-settings/src/client/settings-scope.ts:188-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L188-L195)）
- `derive` 无条件更新 `revision`/`base`/`user`/`writable`，但只有解码成功才把状态推到 `ready` 并替换 `value`（[packages/client/ui-settings/src/client/settings-scope.ts:196-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L196-L205)）
- `decode` 有自定义 `decode` 则用它；否则先拒绝 null、数组与非对象，再用命名空间自带的序列化 schema 复水后校验（[packages/client/ui-settings/src/client/settings-scope.ts:208-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L208-L221)）
- schema 信封复水失败被当作校验不通过，整段不发布值（[packages/client/ui-settings/src/client/settings-scope.ts:216-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L216-L220)）
- `SettingsScopeBinder` 构造时以服务名 `settingsScope` 注册，并把镜像、schema、wire 面存在提供方 fiber 上（[packages/client/ui-settings/src/client/settings-scope.ts:252-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L252-L261)）
- `describe()` 把同一个镜像作为跨命名空间读/折面交出去，与 `bind` 派生自同一份快照（[packages/client/ui-settings/src/client/settings-scope.ts:270-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L270-L272)）
- `bind` 从调用方上下文读 `connection`，按 `isLoopback` 选 `host`/`memory` 模式建控制器（[packages/client/ui-settings/src/client/settings-scope.ts:284-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L284-L293)）
- `bind` 用调用方 `ctx.effect` 发一次 `mirror.ensure()`，并把 `controller.dispose()` 挂成调用方 fiber 的异步拆卸（[packages/client/ui-settings/src/client/settings-scope.ts:294-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/client/settings-scope.ts#L294-L300)）

### packages/client/ui-settings/src/css-modules.d.ts

给 `*.module.css` 与 `*.css` 导入补的 TypeScript 环境声明。

- 无运行期机制

### packages/client/ui-settings/src/index.ts

该包的 Host 侧加载入口。

- 无运行期机制

### packages/client/ui-settings/src/invariant.ts

该包自带的运行期不变式伴生插件。

- 声明插件名 `client-ui-settings-invariant` 并注入 `invariants` 服务（[packages/client/ui-settings/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/invariant.ts#L13-L15)）
- 安装器为空并写明理由：本包不发 cordis 事件、不持跨插件可变关系，槽位冲突已在槽位核加载期失败（[packages/client/ui-settings/src/invariant.ts:17-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/invariant.ts#L17-L23)）
- `apply` 以包名 `@deepseek-ai/dsh-client-ui-settings` 向 `ctx.invariants` 注册并返回 disposer（[packages/client/ui-settings/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/src/invariant.ts#L30-L31)）

### packages/client/ui-settings/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制

### packages/client/ui-settings/tsdown.config.ts

该包的打包配置，决定发布到 `lib/` 的运行期产物。

- 以插件 id `@deepseek-ai/dsh-client-ui-settings` 调用 `clientBundle`，Node 半边打出 `lib/index.js` 与 `lib/invariant.js`，浏览器半边另打出 `lib/client.js`（[packages/client/ui-settings/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings/tsdown.config.ts#L1-L3)）
