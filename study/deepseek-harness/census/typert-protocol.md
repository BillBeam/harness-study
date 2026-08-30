---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/typert/protocol
---

# packages/typert/protocol

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、26 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/typert/protocol/README.md

包 README，介绍该包提供的 Remote 装饰器、线路描述符、编解码器与 provider 契约，以及业务包、生成产物、Gateway 与 Client API 如何共用它们。

- 无运行期机制

### packages/typert/protocol/package.json

包清单，声明该包的 ESM 入口、子路径导出与发布内容。

- `type: module` 与 `main`/`types` 把包入口指向 `lib/index.js` 及其声明文件（[packages/typert/protocol/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./types` 解析到 `lib` 产物，并把 `./src/*` 直通源码目录、`./package.json` 直通清单（[packages/typert/protocol/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/package.json#L16-L31)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 js 与 d.ts（[packages/typert/protocol/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/package.json#L32-L37)）

### packages/typert/protocol/src/index.ts

包入口的运行期部分：Remote 方法装饰器、Gateway 绑定、装饰器标记的私有存取，以及两个失败载体类。

- `isTypertRemoteSegment` 用正则限定字符集并单独排除 `.` 与 `..`，决定一个生成名能否原样穿过 RPC 载体（[packages/typert/protocol/src/index.ts:10-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L10-L19)）
- `TypertLookupFailure` 把适配器自有的 failure 挂在实例上，Error message 用固定文本而不带被拒绝的身份（[packages/typert/protocol/src/index.ts:25-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L25-L38)）
- `TypertRemoteFailure` 以 `failure.message` 作为 Error 消息并原样保留业务 failure（[packages/typert/protocol/src/index.ts:41-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L41-L54)）
- `bindTypertRemote` 校验 service key，namespace 缺省取 service key 后再校验，返回冻结的 `{service, serviceKey, namespace}`（[packages/typert/protocol/src/index.ts:164-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L164-L173)）
- `TypertRemoteService` 构造函数先以 `serviceKey` 注册 Cordis 服务，再用 `this.name` 生成 `typertRemote` 绑定字段（[packages/typert/protocol/src/index.ts:186-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L186-L189)）
- `Remote` 收到字符串时校验导出名并返回一个记录该导出名的 direct 装饰器（[packages/typert/protocol/src/index.ts:211-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L211-L214)）
- `Remote` 收到对象时要求它恰好只有 `mode: "stream"` 一个键，否则抛 TypeError；通过则返回 stream 模式的 direct 装饰器（[packages/typert/protocol/src/index.ts:215-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L215-L221)）
- `Remote` 直接作装饰器使用时，缺少装饰器 context 就抛 TypeError，否则登记一个 direct 标记（[packages/typert/protocol/src/index.ts:222-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L222-L224)）
- `RemoteScope` 校验 scope key 与可选导出名，返回记录 `{kind:'context', context:key}` 的装饰器（[packages/typert/protocol/src/index.ts:249-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L249-L256)）
- `remoteMethods` 取实例原型上的标记表，返回按声明序展开的快照数组；无原型时返回空数组（[packages/typert/protocol/src/index.ts:264-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L264-L268)）
- `addMarkerInitializer` 拒绝 private、static 或名字不是字符串的方法（[packages/typert/protocol/src/index.ts:276-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L276-L278)）
- 装饰器登记的 initializer 在实例化时取原型；原型为 null 抛 TypeError，否则把标记写到该原型上（[packages/typert/protocol/src/index.ts:280-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L280-L286)）
- 标记存放在模块私有的 `WeakMap`，按原型建 `Map`，导出名与方法名相同或 mode 缺省时对应字段被省略，`invocation` 与整条标记都被冻结（[packages/typert/protocol/src/index.ts:155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L155)）
- `mark` 组装标记并写入原型对应的表（[packages/typert/protocol/src/index.ts:296-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L296-L305)）
- 同一方法已有标记时，导出名、mode 与 invocation 完全相同则静默返回，否则抛冲突错误（[packages/typert/protocol/src/index.ts:306-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L306-L313)）
- `sameInvocation` 按 kind 比较，context 模式再比 context 键（[packages/typert/protocol/src/index.ts:316-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L316-L319)）
- `validateName` 在名字不满足 segment 语法时抛 TypeError，带上被校验的主体名（[packages/typert/protocol/src/index.ts:321-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/index.ts#L321-L325)）

### packages/typert/protocol/src/invariant.ts

包自有的 invariant 伴生插件，被 `./invariant` 子路径导出。

- 导出 `name` 与 `inject`，声明插件名并要求先有 `invariants` 服务（[packages/typert/protocol/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/invariant.ts#L12-L15)）
- `install` 为空函数，注册后不安装任何检查（[packages/typert/protocol/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该 installer，并把注册返回的 disposer 包成 Promise 返回（[packages/typert/protocol/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/protocol/src/invariant.ts#L28-L29)）

### packages/typert/protocol/src/types.ts

只含类型声明的模块：协议映射表、`InvocationDescriptor`、编解码器、provider 契约、注册表接口与 `TypertClientRemote`，并对 Cordis `Context` 做声明合并。

- 无运行期机制

### packages/typert/protocol/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
