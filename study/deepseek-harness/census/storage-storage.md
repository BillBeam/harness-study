---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/storage/storage
---

# packages/storage/storage

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、22 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/storage/storage/README.md

这个包的英文说明页，描述存储中枢的用法、组合示例、后端契约要点与失败码含义。

- 无运行期机制

### packages/storage/storage/package.json

包清单，声明存储中枢如何被解析加载、发布哪些文件，以及依赖哪些同仓库包。

- `type: module` 与 `main`/`types` 让该包按 ESM 加载，主入口解析到 `lib/index.js`（[packages/storage/storage/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant` 子路径、`./src/*` 源码直通与 `./package.json`（[packages/storage/storage/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/storage/storage/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/package.json#L28-L32)）

### packages/storage/storage/src/backend.ts

后端面向的词汇文件：以接口写出后端、KV 面、单元与记录操作的契约，并给出名字的合法形状。

- `UNIT_NAME_RE` 规定单元名与表名必须是小写字母开头、其后为小写字母数字或下划线，这个正则被用作文件名与 SQL 标识符段的合法性判据（[packages/storage/storage/src/backend.ts:9-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/backend.ts#L9-L10)）

### packages/storage/storage/src/error.ts

存储中枢与各后端共用的错误类型，携带可供调用方分支的稳定错误码。

- `StorageErrorCode` 枚举出 backend-not-found、form-not-mounted、duplicate-backend、duplicate-mount、version-mismatch、malformed-medium、closed 七个判别码（[packages/storage/storage/src/error.ts:6-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/error.ts#L6-L14)）
- `StorageError` 把 `name` 固定为 `'StorageError'`，并把 code 作为只读字段挂在实例上，同时透传标准 `cause`（[packages/storage/storage/src/error.ts:20-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/error.ts#L20-L34)）

### packages/storage/storage/src/index.ts

包入口，定义 `Storage` 服务：一张命名后端表加一组挂载的数据形态设施，供宿主侧包读写持久数据。

- `storageBackendServiceKey(name)` 把后端名派生成 `storage.backend.<name>` 这个只用于生命周期的服务键，使数据形态提供方可以注入它以等待后端注册（[packages/storage/storage/src/index.ts:18-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/index.ts#L18-L28)）
- `Storage` 继承 `Service`，构造时以服务名 `storage` 注册，成为 `ctx.storage`（[packages/storage/storage/src/index.ts:47-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/index.ts#L47-L55)）
- 实例上持有一个 `BackendRegistry` 作为命名后端表，多个后端可并存（[packages/storage/storage/src/index.ts:48-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/index.ts#L48-L49)）
- `mount` 在同名形态已挂载时抛 `duplicate-mount`，否则写入映射并返回只在当前设施仍在位时才删除的 disposer（[packages/storage/storage/src/index.ts:57-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/index.ts#L57-L75)）
- `form` 在形态未挂载时抛 `form-not-mounted`，而不是返回空值（[packages/storage/storage/src/index.ts:77-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/index.ts#L77-L87)）
- `domain` 取值器把 `ctx.storage.domain` 转成对 `form('domain')` 的解析（[packages/storage/storage/src/index.ts:89-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/index.ts#L89-L92)）
- 默认导出 `Storage` 且不再导出函数插件形状，使加载器取到的就是该服务类（[packages/storage/storage/src/index.ts:95-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/index.ts#L95-L98)）

### packages/storage/storage/src/invariant.ts

该包的不变量伴生插件，向不变量服务登记包名。

- 导出 `name` 与 `inject = ['invariants']`，使其成为需要 `invariants` 服务的 cordis 插件（[packages/storage/storage/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/invariant.ts#L13-L15)）
- `install` 是空安装器，不注册任何检查（[packages/storage/storage/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/invariant.ts#L23)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其注销函数（[packages/storage/storage/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/invariant.ts#L30-L31)）

### packages/storage/storage/src/registry.ts

命名后端表的实现，被 `Storage` 服务持有，负责后端的注册、解析与注销。

- `register` 在同名已注册时抛 `duplicate-backend`（[packages/storage/storage/src/registry.ts:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/registry.ts#L25-L28)）
- 注册后返回的 disposer 只在表中当前实例仍是本次注册的实例时才删除该名字，因此过期 disposer 不会移除后继者；注销不关闭后端（[packages/storage/storage/src/registry.ts:29-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/registry.ts#L29-L37)）
- `get` 在名字未注册时抛 `backend-not-found`，错误消息里带上当前已注册的名字列表（没有则为 `none`）（[packages/storage/storage/src/registry.ts:39-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/registry.ts#L39-L53)）
- `names` 返回已注册名字的快照数组供诊断使用（[packages/storage/storage/src/registry.ts:55-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage/src/registry.ts#L55-L61)）

### packages/storage/storage/tsconfig.json

该包的 TypeScript 编译配置，设定源码根、输出目录与工程引用。

- 无运行期机制
