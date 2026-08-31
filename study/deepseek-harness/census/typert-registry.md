---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/typert/registry
---

# packages/typert/registry

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、67 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/typert/registry/README.md

包 README，说明该运行期注册表存放什么、如何查询与注册，以及 lookup 与 Context provider 的用法。

- 无运行期机制

### packages/typert/registry/package.json

包清单，声明入口、子路径导出、Client 面装载元数据与发布内容。

- `type: module` 与 `main`/`types` 把包入口指向 `lib/index.js` 及其声明文件（[packages/typert/registry/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./client`、`./types` 解析到对应 `lib` 产物，并把 `./src/*` 直通源码目录（[packages/typert/registry/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/package.json#L16-L35)）
- `dsh.client` 声明 Client 面的注入为空、平台为 `web`、`immediately: true`（[packages/typert/registry/package.json:36-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/package.json#L36-L42)）
- `scripts` 定义 `bundle` 与 `watch` 走 tsdown（[packages/typert/registry/package.json:43-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/package.json#L43-L46)）
- `files` 把发布内容限定为三个 `lib` 入口与 `lib/types` 下的 js 与 d.ts（[packages/typert/registry/package.json:47-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/package.json#L47-L53)）
- `dependencies` 把 `zod` 与协议包列为运行期依赖（[packages/typert/registry/package.json:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/package.json#L55-L58)）

### packages/typert/registry/src/client/index.ts

浏览器面的插件入口，被 `./client` 导出，装载与 Host 面相同的注册表实现。

- 导出空的 `inject` 数组，声明该插件不依赖任何服务（[packages/typert/registry/src/client/index.ts:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/client/index.ts#L7)）
- `apply` 在传入的 Client 根 Context 上实例化 `TypertRegistry`，从而在该 Context 上提供 `typert` 服务（[packages/typert/registry/src/client/index.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/client/index.ts#L13-L15)）

### packages/typert/registry/src/index.ts

Host 面包入口，把服务实现重导出为包的默认导出与具名导出，并对协议包的 `TypertRegistryContract` 做声明合并。

- 把 `service.ts` 的默认导出、`TypertRegistry` 以及 `typertEndpoint`/`typertKey`/`typertPackageKey` 作为包入口的值导出（[packages/typert/registry/src/index.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/index.ts#L14)）

### packages/typert/registry/src/invariant.ts

包自有的 invariant 伴生插件，被 `./invariant` 子路径导出。

- 导出 `name` 与 `inject`，声明插件名并要求先有 `invariants` 服务（[packages/typert/registry/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/invariant.ts#L12-L15)）
- `install` 为空函数，注册后不安装任何检查（[packages/typert/registry/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/invariant.ts#L22)）
- `apply` 用包名向 `ctx.invariants` 注册该 installer，并把注册返回的 disposer 包成 Promise 返回（[packages/typert/registry/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/invariant.ts#L29-L30)）

### packages/typert/registry/src/service.ts

`TypertRegistry` 服务的实现：键的拼装、四个子注册表（本地调用、Remote 贡献、lookup provider、Context 适配器）的存储与变更广播，以及注册前的整批校验。

- `typertKey` 把包名与 schema 名拼成 `<package>#<name>`（[packages/typert/registry/src/service.ts:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L48-L50)）
- `typertPackageKey` 把包名与 face 拼成 `<package>#<face>`（[packages/typert/registry/src/service.ts:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L58-L60)）
- `typertEndpoint` 把 namespace 与 method 拼成 `<namespace>/<method>`（[packages/typert/registry/src/service.ts:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L67-L69)）
- `ChangeSource.subscribe` 用 `ctx.effect` 把监听器加入集合，effect 的 disposer 把它移除（[packages/typert/registry/src/service.ts:88-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L88-L94)）
- `ChangeSource.emit` 遍历监听器集合的快照逐个调用，单个监听器抛出时交给 report 记录并继续下一个（[packages/typert/registry/src/service.ts:96-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L96-L104)）
- `DescriptorStore.validate` 逐条校验描述符，并在批内与已注册条目中同时检测 endpoint 与 invocation id 重复，任一重复即抛错（[packages/typert/registry/src/service.ts:120-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L120-L135)）
- `DescriptorStore.commit` 先把全部描述符写入 endpoint 表、id 表与 history 集合，再逐条广播变更（[packages/typert/registry/src/service.ts:137-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L137-L148)）
- `DescriptorStore.withdraw` 只删除 owner 匹配的条目，同步清 id 表，收集后统一广播移除变更（[packages/typert/registry/src/service.ts:150-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L150-L163)）
- `hasSeen` 读 history 集合，因此一个 endpoint 被撤回后仍返回 true（[packages/typert/registry/src/service.ts:169-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L169-L171)）
- `list` 按 Map 插入序返回描述符快照数组（[packages/typert/registry/src/service.ts:173-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L173-L175)）
- `RemoteStore.view` 把 register/get/list/subscribe 绑定到调用方的 Context（[packages/typert/registry/src/service.ts:187-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L187-L194)）
- `RemoteStore.register` 先校验包名、拒绝重复包、校验全部描述符，再在一个 `ctx.effect` 内写包表并提交描述符，disposer 同时删包与撤回描述符（[packages/typert/registry/src/service.ts:196-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L196-L213)）
- `LookupStore.view` 暴露 register/configure/get/definitions/keys/subscribe，全部绑定到调用方 Context（[packages/typert/registry/src/service.ts:226-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L226-L247)）
- `LookupStore.get` 在无 provider 时返回 undefined；有 configure 覆盖时返回一个保留原 provider 线路声明、但 `resolve` 改走覆盖 resolver 的复合对象（[packages/typert/registry/src/service.ts:249-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L249-L261)）
- `configure` 校验 key、拒绝同 key 重复配置，把 resolver 包成 async 后在 effect 内写入并广播 `lookup` 变更，disposer 删除并再次广播（[packages/typert/registry/src/service.ts:263-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L263-L288)）
- `LookupStore.register` 校验 key、parameter、wire 字段与两个 type symbol，并拒绝同 key 重复注册（[packages/typert/registry/src/service.ts:290-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L290-L296)）
- 注册时把本次的线路声明与本生命期内已记录的声明比对，四个字段有任何不同就抛错（[packages/typert/registry/src/service.ts:297-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L297-L307)）
- 注册的 effect 写入 definitions 与 providers 并广播；disposer 只删除 provider 并再次广播，definitions 保留（[packages/typert/registry/src/service.ts:311-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L311-L321)）
- `lookupDefinitionEquals` 按 parameter、wire 与两个 type symbol 四字段判等（[packages/typert/registry/src/service.ts:329-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L329-L334)）
- `ContextStore.view` 暴露 registerHost/configureHost/registerClient/identifyHost/getHost/getClient/subscribe（[packages/typert/registry/src/service.ts:346-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L346-L365)）
- `getHost` 在存在 configureHost 覆盖时返回保留原 wire 声明与 identity、但 `resolve` 改走覆盖 resolver 的复合适配器（[packages/typert/registry/src/service.ts:367-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L367-L378)）
- `identifyHost` 遍历所有 Host 适配器求身份，出现第二个识别成功的 kind 时抛歧义错误，否则返回唯一的 kind 与 identity（[packages/typert/registry/src/service.ts:380-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L380-L393)）
- `configureHost` 校验 Context key、拒绝重复配置，在 effect 内写入 resolver 并广播 `host-context` 变更，disposer 删除并再次广播（[packages/typert/registry/src/service.ts:395-417](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L395-L417)）
- `registerHost` 额外校验适配器的 wire 字段与 wire type symbol 后再走通用注册（[packages/typert/registry/src/service.ts:419-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L419-L424)）
- `registerClient` 只校验 Context key 后走通用注册（[packages/typert/registry/src/service.ts:426-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L426-L429)）
- `registerProvider` 拒绝同 key 重复，在 effect 内写表并广播对应 kind 的变更，disposer 校验 owner 后删表并再次广播（[packages/typert/registry/src/service.ts:431-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L431-L451)）
- `TypertRegistry` 构造函数以 `typert` 为键注册 Cordis 服务，定义把监听器失败写成两条 `ctx.logger.warn` 的 report，并建立四个 store（[packages/typert/registry/src/service.ts:471-481](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L471-L481)）
- `local` getter 返回绑定服务自身 Context 的 get/hasSeen/list/subscribe 视图（[packages/typert/registry/src/service.ts:483-492](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L483-L492)）
- `remotes`、`lookups`、`contexts` 三个 getter 每次以服务自身 Context 生成对应子注册表视图（[packages/typert/registry/src/service.ts:494-507](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L494-L507)）
- `register` 先完成 package-face、schemas 与 invocations 三步校验，再在单个 `ctx.effect` 内一次性写入包记录、schema 记录与本地描述符（[packages/typert/registry/src/service.ts:516-526](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L516-L526)）
- `register` 的 disposer 按身份比对逐项删除包记录与 schema 记录，并撤回本次提交的描述符（[packages/typert/registry/src/service.ts:527-537](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L527-L537)）
- `get(key)` 直接读 schema 表，缺失返回 undefined（[packages/typert/registry/src/service.ts:544-546](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L544-L546)）
- `resolve(key)` 未命中时按 `#` 位置区分三种失败并抛出各自的错误：键格式非法、包已注册但未贡献该 schema、包无任何注册贡献（[packages/typert/registry/src/service.ts:554-568](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L554-L568)）
- `list` 按可选的 package 与 face 过滤 schema 记录（[packages/typert/registry/src/service.ts:575-577](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L575-L577)）
- `getPackage` 的 face 参数缺省为 `host`，按合成键查包记录（[packages/typert/registry/src/service.ts:585-587](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L585-L587)）
- `listPackages` 按可选的 package 与 face 过滤包记录（[packages/typert/registry/src/service.ts:594-596](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L594-L596)）
- `toJSONSchema` 每次调用都对 `resolve(key)` 得到的 Zod schema 现算一份 JSON Schema，不缓存（[packages/typert/registry/src/service.ts:604-606](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L604-L606)）
- `validatePackage` 校验包名、要求 face 为 `host` 或 `client`、拒绝重复的 package-face 键，并组装包记录（[packages/typert/registry/src/service.ts:608-624](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L608-L624)）
- `validateSchemas` 逐个校验 schema 名，批内与已注册表中重复的键都抛错，并给每条记录补上 package、face 与合成键（[packages/typert/registry/src/service.ts:626-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L626-L644)）
- `matches` 对 package 与 face 做「未给定即通过」的过滤（[packages/typert/registry/src/service.ts:647-653](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L647-L653)）
- `validateInvocation` 校验 id 非空、service 键、namespace 与 method 的线路名、可选的 implementation 名，以及结果编解码器（[packages/typert/registry/src/service.ts:655-663](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L655-L663)）
- 参数循环校验每个参数的名字与 wire 字段，并在同一调用内重复的 wire 字段上抛错（[packages/typert/registry/src/service.ts:664-671](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L664-L671)）
- lookup 参数不得声明 `acceptsUndefined`、必须带一个合法的 lookup key；JSON 参数则不得声明 lookup key；每个参数的编解码器都被校验（[packages/typert/registry/src/service.ts:672-684](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L672-L684)）
- 声明了 cancellation 时其参数名必须是 `signal`（[packages/typert/registry/src/service.ts:685-688](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L685-L688)）
- 声明 scope 投影时要求 receiver 为 direct，校验 Context 键与 wire 字段，并要求它恰好命中唯一一个 lookup 参数且 wire 与 lookup key 都对上（[packages/typert/registry/src/service.ts:689-703](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L689-L703)）
- Context receiver 校验 Context 键与 wire 字段，与业务参数的 wire 冲突时抛错，并校验其编解码器（[packages/typert/registry/src/service.ts:704-711](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L704-L711)）
- `validateCodec` 对 `src-json` 直接放行，对 strict 要求 type symbol 非空且 `schema.parse` 是函数（[packages/typert/registry/src/service.ts:714-720](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L714-L720)）
- `validateWireName` 排除 `.` 与 `..` 并用正则限定 RPC 段字符集（[packages/typert/registry/src/service.ts:722-726](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L722-L726)）
- `validateSegment` 要求非空且不含 `#`（[packages/typert/registry/src/service.ts:728-732](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L728-L732)）
- `validateNonempty` 要求字符串非空（[packages/typert/registry/src/service.ts:734-736](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L734-L736)）
- 模块默认导出 `TypertRegistry`，供 Loader 按包名装载（[packages/typert/registry/src/service.ts:738](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/src/service.ts#L738)）

### packages/typert/registry/src/types.ts

只含类型声明的模块：生成产物的贡献、反射模型、记录与过滤条件类型。

- 无运行期机制

### packages/typert/registry/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制

### packages/typert/registry/tsdown.config.ts

tsdown 打包配置，决定该包 Client 侧产物如何生成。

- 用共享的 `clientBundle` 以包名和 `lib/types/index.js`、`lib/types/invariant.js` 两个入口生成打包配置（[packages/typert/registry/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/registry/tsdown.config.ts#L1-L3)）
