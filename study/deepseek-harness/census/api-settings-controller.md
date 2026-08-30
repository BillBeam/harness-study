---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/api/settings-controller
---

# packages/api/settings-controller

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、52 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/api/settings-controller/README.md

该包的说明性 README，描述 settings 与 credentials 两个 Remote 命名空间的用法、配置字段与限制。

- 无运行期机制

### packages/api/settings-controller/package.json

该包的 npm 清单，声明模块类型、入口映射与发布文件集。

- 声明 `"type": "module"` 并把默认入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/api/settings-controller/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./types`、`./typert`、`./remote`、`./src/*` 与 `./package.json` 映射到具体产物，未列出的子路径不可被导入（[packages/api/settings-controller/package.json:16-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/package.json#L16-L39)）
- `files` 白名单限定发布物只含 `lib/` 下的运行时与类型产物（[packages/api/settings-controller/package.json:40-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/package.json#L40-L49)）
- 把 cordis、agent-presets、credentials、invariants、native-command、session、settings、typert-protocol 列为 peerDependencies，由宿主提供（[packages/api/settings-controller/package.json:55-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/package.json#L55-L64)）

### packages/api/settings-controller/src/credentials.ts

Host 侧 `credentials` Remote 命名空间的服务实现，被同包 index.ts 以子插件方式挂载，供浏览器配置页读写凭据引用。

- 把一次 `describe` 批量的引用数上限固定为 64（[packages/api/settings-controller/src/credentials.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L20)）
- 用 zod 规定引用名必须匹配 `^[A-Za-z_][A-Za-z0-9_]*$`、`describe` 数组不超过上限、`set` 的值长度至少为 1（[packages/api/settings-controller/src/credentials.ts:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L22-L27)）
- 校验不通过时抛出 code 为 `bad-request` 的 `TypertRemoteFailure`，details 携带 zod issues（[packages/api/settings-controller/src/credentials.ts:30-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L30-L40)）
- 逐字段复制 `configured`、可选的 `source`、`writable`，provider 返回的其余可枚举属性不会被序列化出去（[packages/api/settings-controller/src/credentials.ts:49-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L49-L55)）
- 构造时以服务名 `credentialsController`、命名空间 `credentials` 注册到 Typert Remote 注册表（[packages/api/settings-controller/src/credentials.ts:73-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L73-L75)）
- `describe` 校验后把每个名字品牌化，并发调用 provider 的 `describe`，投影后以原始名字为键组装成一个对象返回（[packages/api/settings-controller/src/credentials.ts:86-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L86-L93)）
- `set` 校验并品牌化后调用 provider 的 `set` 写入值，返回 void 而不回传值（[packages/api/settings-controller/src/credentials.ts:103-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L103-L108)）
- `unset` 校验并品牌化后调用 provider 的 `unset` 删除引用（[packages/api/settings-controller/src/credentials.ts:116-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L116-L121)）
- provider 未挂载时抛出 code 为 `internal` 的失败，消息里写明需要在组合中挂载凭据 provider（[packages/api/settings-controller/src/credentials.ts:124-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L124-L134)）
- 写操作的任何异常被统一转成 code 为 `credential-rejected` 的失败，message 取 provider 原文，details 只含引用名（[packages/api/settings-controller/src/credentials.ts:144-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L144-L154)）
- 默认导出服务类，使其可直接作为 Cordis 插件被 `ctx.plugin` 装载（[packages/api/settings-controller/src/credentials.ts:157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/credentials.ts#L157)）

### packages/api/settings-controller/src/index.ts

该包的主入口与 `settings` Remote 命名空间的 Host 服务，同时把 credentials 控制器作为子插件挂载。

- 用 zod 要求写操作的命名空间名非空字符串（[packages/api/settings-controller/src/index.ts:38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L38)）
- `Config` 暴露 `nativeOpen` 字段以覆盖平台的桌面打开能力探测（[packages/api/settings-controller/src/index.ts:41-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L41-L44)）
- 在每次 await provider 或 opener 之后重新读取 abort 状态（[packages/api/settings-controller/src/index.ts:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L47-L49)）
- `namespaceView` 逐字段复制 ns、schema、value、可选的 base/user、applies、secrets（path 数组复制、set 标记）、revision，其余属性不出网（[packages/api/settings-controller/src/index.ts:66-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L66-L77)）
- 以 Schemastery 声明 `Config`，使 `nativeOpen` 成为 cordis.yml 可配置字段（[packages/api/settings-controller/src/index.ts:94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L94)）
- 构造时以服务名 `settingsController`、命名空间 `settings` 注册（[packages/api/settings-controller/src/index.ts:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L107)）
- 打开路径、打开文本文件、能否本地打开三个动作按 internals 覆盖优先、否则用原生实现，能力判定取配置的 `nativeOpen`，未配置时看是否注入了 openPath 或平台探测结果（[packages/api/settings-controller/src/index.ts:108-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L108-L111)）
- 构造时挂载 `CredentialsController` 子插件，使两个命名空间随本包一起注册（[packages/api/settings-controller/src/index.ts:112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L112)）
- `describe` 以 `redactSecrets: true` 读取全部命名空间描述符并投影，同时返回 provider 可写性与是否存在本地文档（[packages/api/settings-controller/src/index.ts:121-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L121-L129)）
- `canOpenAgentPresetDirectory` 把本地打开能力判定结果作为布尔值返回给调用方（[packages/api/settings-controller/src/index.ts:135-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L135-L138)）
- `update` 把补丁合并进用户段，带上调用方读到的 revision（[packages/api/settings-controller/src/index.ts:148-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L148-L155)）
- `replace` 整体替换命名空间的用户段（[packages/api/settings-controller/src/index.ts:165-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L165-L172)）
- `mutate` 按顺序应用路径寻址的编辑操作（[packages/api/settings-controller/src/index.ts:184-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L184-L191)）
- `openSettingsDocument` 先取 provider，进入前若已 abort 就抛 `cancelled`（[packages/api/settings-controller/src/index.ts:201-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L201-L202)）
- 文档准备失败时按 abort 与否分别抛 `cancelled` 或 `internal`（[packages/api/settings-controller/src/index.ts:204-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L204-L209)）
- provider 没有本地文档路径时抛 `internal`（[packages/api/settings-controller/src/index.ts:210-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L210-L212)）
- 交给原生文本编辑器打开，成功返回 `{ opened: true }`，失败按 abort 与否抛 `cancelled` 或 `internal`（[packages/api/settings-controller/src/index.ts:213-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L213-L220)）
- `openAgentPresetDirectory` 对空 preset id 抛 `bad-request`（[packages/api/settings-controller/src/index.ts:235-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L235-L239)）
- 未组合 agentPresets 服务时抛 `agent-preset-not-found` 并给出空的候选列表（[packages/api/settings-controller/src/index.ts:240-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L240-L247)）
- 解析 preset 后，`trust` 不是 `user` 的按只读处理，目录取 preset 文件所在目录；解析阶段的异常统一交给 `presetFailure` 分类（[packages/api/settings-controller/src/index.ts:248-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L248-L257)）
- 没有本地打开能力时返回 `{ opened: false, path }` 而不是报错（[packages/api/settings-controller/src/index.ts:258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L258)）
- 调用原生打开，成功返回 `{ opened: true }`，失败按 abort 与否抛 `cancelled` 或 `internal`（[packages/api/settings-controller/src/index.ts:259-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L259-L265)）
- 写入路径先校验命名空间名，失败抛 `bad-request` 并带上 zod issues（[packages/api/settings-controller/src/index.ts:274-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L274-L281)）
- 命名空间名品牌化失败时按普通拒绝处理，走与未注册命名空间相同的失败路径（[packages/api/settings-controller/src/index.ts:283-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L283-L290)）
- 按 mode 分派到 settings 服务的 update/replace/mutate，任何异常交给分类函数（[packages/api/settings-controller/src/index.ts:291-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L291-L297)）
- 写入成功后重新以 `redactSecrets: true` 读取该命名空间；若已消失则抛 `internal`（[packages/api/settings-controller/src/index.ts:298-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L298-L307)）
- 写入成功后返回该命名空间的新脱敏视图（[packages/api/settings-controller/src/index.ts:308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L308)）
- settings provider 未挂载时抛 `internal`，消息写明需要挂载哪类 provider（[packages/api/settings-controller/src/index.ts:312-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L312-L322)）
- `presetFailure` 把未知 preset、只读 preset、非法 id 与已存在分别映射成 `agent-preset-not-found`、`agent-preset-read-only`、`agent-preset-invalid`，已是 Remote 失败的原样透传，其余归为 `internal`（[packages/api/settings-controller/src/index.ts:337-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L337-L361)）
- `rejected` 把版本冲突映射成 `settings-conflict` 并带上 expected/actual，其余映射成 `settings-rejected` 并带上命名空间名（[packages/api/settings-controller/src/index.ts:371-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L371-L384)）
- 默认导出 `SettingsController`，使其可作为 Loader 条目装载（[packages/api/settings-controller/src/index.ts:386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/index.ts#L386)）

### packages/api/settings-controller/src/invariant.ts

该包的 invariant 伴随插件，向 invariants 注册表登记包名。

- 声明插件名与 `inject = ['invariants']`，使其在 invariants 服务就绪后才装载（[packages/api/settings-controller/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/invariant.ts#L10-L12)）
- 安装函数为空，本包不注册任何运行期不变量检查（[packages/api/settings-controller/src/invariant.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/invariant.ts#L18)）
- `apply` 向 invariants 注册包名并把注册返回的 disposer 交回 Cordis（[packages/api/settings-controller/src/invariant.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/settings-controller/src/invariant.ts#L21-L22)）

### packages/api/settings-controller/src/types.ts

该包的浏览器侧类型文件，声明 settings 与 credentials 两个命名空间的失败码与返回值类型。

- 无运行期机制

### packages/api/settings-controller/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工作区项目引用。

- 无运行期机制
