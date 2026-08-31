---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/host/plugin-inventory
---

# packages/host/plugin-inventory

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、20 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/host/plugin-inventory/README.md

该包的说明文档，描述 `pluginInventory/list` 返回的加载器条目投影。

- 无运行期机制

### packages/host/plugin-inventory/package.json

该包的 npm 清单，声明入口、Typert 产物导出与发布内容。

- `type: module` 与 `main`/`types` 指定包按 ESM 加载、运行时入口为 `lib/index.js`（[packages/host/plugin-inventory/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./types` 分别解析到实现、伴生与类型模块，并把 `./typert` 与 `./remote` 指向生成的宿主端与客户端 Remote 产物（[packages/host/plugin-inventory/package.json:16-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/package.json#L16-L39)）
- `files` 限定发布物包含实现、伴生、类型目录与两份 Typert 产物（[packages/host/plugin-inventory/package.json:40-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/package.json#L40-L49)）
- `dependencies` 携带 `zod`，Typert 生成的产物在运行时导入它（[packages/host/plugin-inventory/package.json:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/package.json#L51-L53)）

### packages/host/plugin-inventory/src/index.ts

`PluginInventoryGateway` 服务实现，把 Cordis 加载器的当前条目投影成一份 Remote 可读的快照。

- `pluginEntryId` 在包边界把加载器条目 id 打上品牌，不做校验（[packages/host/plugin-inventory/src/index.ts:18-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L18-L20)）
- `FIBER_STATE` 在运行时镜像跨包 const enum 的数值，供下面的映射表取键（[packages/host/plugin-inventory/src/index.ts:23-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L23-L30)）
- `FIBER_PHASE` 把六种 fiber 状态映射到对外的阶段词表，`DISPOSED` 折成 `null`（[packages/host/plugin-inventory/src/index.ts:33-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L33-L40)）
- `static inject = ['loader']` 使服务在 loader 就绪前不激活（[packages/host/plugin-inventory/src/index.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L44)）
- 构造函数以 `pluginInventory` 名字挂载为 Typert Remote 服务（[packages/host/plugin-inventory/src/index.ts:46-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L46-L48)）
- `@Remote('list')` 把 `list` 暴露为远程方法名 `list`（[packages/host/plugin-inventory/src/index.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L56)）
- 每次调用都现读 `ctx.loader.entries()`，不做任何缓存（[packages/host/plugin-inventory/src/index.ts:59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L59)）
- 带 `options.group` 的结构性分组条目被跳过，不出现在快照里（[packages/host/plugin-inventory/src/index.ts:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L60)）
- 每行输出条目 id、模块标识符、`enabled = !entry.disabled`，并在 `entry.fiber` 缺席时给出 `null`、否则查 `FIBER_PHASE`（[packages/host/plugin-inventory/src/index.ts:61-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L61-L67)）
- 默认导出该服务类，供加载器按服务插件形式挂载（[packages/host/plugin-inventory/src/index.ts:72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/index.ts#L72)）

### packages/host/plugin-inventory/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包名。

- `inject` 声明 `invariants`，服务缺席时伴生插件不激活（[packages/host/plugin-inventory/src/invariant.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/invariant.ts#L12)）
- 安装器为空函数，不注册任何运行期检查（[packages/host/plugin-inventory/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/invariant.ts#L15)）
- `apply` 以包名把该安装器登记进 `ctx.invariants` 并返回其 disposer（[packages/host/plugin-inventory/src/invariant.ts:18-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/plugin-inventory/src/invariant.ts#L18-L19)）

### packages/host/plugin-inventory/src/types.ts

该包对外载荷的类型声明文件，被实现与客户端共同引用。

- 无运行期机制

### packages/host/plugin-inventory/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制
