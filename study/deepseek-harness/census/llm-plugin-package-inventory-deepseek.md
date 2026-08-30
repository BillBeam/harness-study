---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/llm/plugin-package-inventory-deepseek
---

# packages/llm/plugin-package-inventory-deepseek

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、28 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/llm/plugin-package-inventory-deepseek/README.md

包的英文说明文档，描述该插件的配置项、清点范围与已知限制。

- 无运行期机制

### packages/llm/plugin-package-inventory-deepseek/package.json

npm 包清单，声明包名、模块入口、导出子路径与依赖关系。

- `"type": "module"` 与 `main` / `types` 指定该包以 ESM 方式加载，运行期入口为 `lib/index.js`（[packages/llm/plugin-package-inventory-deepseek/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/package.json#L13-L15)）
- `exports` 开放 `.`、`./invariant`、`./types` 三个入口，另放行 `./src/*` 源码路径与 `./package.json`（[packages/llm/plugin-package-inventory-deepseek/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/package.json#L16-L31)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`（[packages/llm/plugin-package-inventory-deepseek/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/package.json#L32-L37)）
- `peerDependencies` 要求宿主提供 loader、agent、agent-presets、deepseek-llm-api-extensions、invariants、session 与 cordis（[packages/llm/plugin-package-inventory-deepseek/package.json:42-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/package.json#L42-L50)）
- `peerDependenciesMeta` 把 `dsh-agent-presets` 标为可选，使不装该包的部署仍能安装并运行本插件（对应源码里的按需动态 import）（[packages/llm/plugin-package-inventory-deepseek/package.json:51-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/package.json#L51-L55)）

### packages/llm/plugin-package-inventory-deepseek/src/index.ts

包的主体：一个函数插件，在每次官方 DeepSeek 请求准备阶段读取 Loader 树的活跃条目，解析出插件包的 name/version 清单，作为 `dsh_plugin_packages` 请求字段贡献出去。

- 插件以 `plugin-package-inventory-deepseek` 为名注册，声明注入 `agents`、`deepseekLlmApiExtensions`、`loader` 三个服务（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:25-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L25-L27)）
- `Config` 只有一个 `enabled` 布尔项，默认为 `true`（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L36-L38)）
- `barePackageName` 把以 `.` 开头、含 `:`、或绝对路径的说明符判为非裸包返回 undefined；裸包名取第一段，作用域包取前两段（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:52-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L52-L57)）
- `identityFromManifest` 读取并解析 package.json：允许匿名且 `name` 缺失时视为松散模块返回 undefined；否则 name 与 version 必须都是非空字符串，不满足即抛错让请求准备失败（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:60-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L60-L68)）
- `barePackageManifest` 依次用每个锚点建 `createRequire` 取 Node 包搜索路径，逐一探测 `<searchPath>/<pkg>/package.json` 是否存在，从而绕开包自身是否导出 `./package.json`（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:71-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L71-L82)）
- `nearestManifest` 从模块所在目录逐级向上找 package.json，直到文件系统根仍未找到则返回 undefined（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:85-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L85-L94)）
- `PackageIdentityResolver` 以进程级 Map 缓存解析结果，缓存键由锚点列表与条目名拼成，命中即直接返回（含缓存下来的 undefined）（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:97-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L97-L109)）
- 解析锚点顺序为「该条目的裸包基址、所属树基址、宿主基址、本模块 URL」并去重（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:106-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L106-L108)）
- 裸包说明符解析不出清单时直接抛错，使请求准备失败而非静默漏记（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L113-L117)）
- 非裸包条目中，以 `cordis:` 开头的结构性行被跳过；绝对路径转 file URL、相对路径按所属树基址解析，且仅 `file:` 协议才继续找最近清单（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:118-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L118-L123)）
- `activeEntries` 只取非 group、未 disabled、且根 fiber 状态为 `ACTIVE` 的条目；属于该树自身的条目再附上根裸包基址（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:131-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L131-L142)）
- `compareWireText` 用纯码点比较代替本地化比较，使排序结果不受宿主 ICU 与 locale 影响（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:145-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L145-L147)）
- 请求带 `sessionId` 且 `agentPresets` 服务存在时，按会话 id 取活跃 Agent，动态 import 该可选包拿到其常驻 preset Loader 树，把该树的活跃条目也并入清点，且其根条目一律以宿主基址为裸包锚点（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:156-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L156-L168)）
- 解析不出包身份的条目被跳过，其余按 `name\0version` 去重，最后按名再按版本排序输出（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:169-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L169-L178)）
- `config.enabled === false` 时 `apply` 直接返回，不做任何注册，请求也就不带该字段（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L186)）
- 宿主基址取 `ctx.baseUrl`，缺省回落到本模块的 `import.meta.url`（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L187)）
- 向 `ctx.deepseekLlmApiExtensions` 注册 `dsh_plugin_packages` 扩展，其 `prepare` 在每次请求时重新清点并返回 `{ version: 1, packages }`（[packages/llm/plugin-package-inventory-deepseek/src/index.ts:189-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/index.ts#L189-L197)）

### packages/llm/plugin-package-inventory-deepseek/src/invariant.ts

包自带的不变量伴生插件，向不变量服务登记本包的所有权，但不安装任何运行期检查。

- 声明伴生插件名 `plugin-package-inventory-deepseek-invariant` 并注入 `invariants` 服务（[packages/llm/plugin-package-inventory-deepseek/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/invariant.ts#L10-L12)）
- 安装器为空实现，注释说明每次请求都直接读 Loader fiber 状态与包清单、插件不持有可独立变更的清点状态（[packages/llm/plugin-package-inventory-deepseek/src/invariant.ts:14-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/invariant.ts#L14-L18)）
- `apply` 用包名向 `ctx.invariants` 注册该空安装器并返回其卸载器（[packages/llm/plugin-package-inventory-deepseek/src/invariant.ts:25-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/plugin-package-inventory-deepseek/src/invariant.ts#L25-L26)）

### packages/llm/plugin-package-inventory-deepseek/src/types.ts

线上传输类型模块，定义包身份与版本化清单结构，并通过声明合并把 `dsh_plugin_packages` 并入 DeepSeek 请求扩展映射。

- 无运行期机制

### packages/llm/plugin-package-inventory-deepseek/tsconfig.json

包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 并引用工作区依赖工程。

- 无运行期机制
