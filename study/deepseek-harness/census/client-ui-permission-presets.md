---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-permission-presets
---

# packages/client/ui-permission-presets

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 13 个文件、57 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-permission-presets/README.md

本包的说明文档，介绍权限预设的两个界面（通用设置里的新会话默认行与当前会话的 `/permission` 选择器）及其内部实现，供阅读者使用。

- 无运行期机制

### packages/client/ui-permission-presets/package.json

本包的 npm 清单，声明入口、客户端半边的加载声明与发布产物。

- `main`/`types`/`exports` 把 `.`、`./invariant`、`./client` 分别指向 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，并放开 `./src/*` 与 `./package.json` 的直取（[packages/client/ui-permission-presets/package.json:14-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/package.json#L14-L31)）
- `dsh.client` 声明浏览器半边需要注入的五个包并把 `platform` 限定为 `web`，决定这个半边在哪种客户端被发现与加载（[packages/client/ui-permission-presets/package.json:32-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/package.json#L32-L43)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与 `lib/types/**/*.d.ts`（[packages/client/ui-permission-presets/package.json:81-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/package.json#L81-L86)）

### packages/client/ui-permission-presets/src/client/PermissionRow.module.css

设置行的 CSS Module 样式表，被 `PermissionRow.tsx` 引入。

- 无运行期机制

### packages/client/ui-permission-presets/src/client/PermissionRow.tsx

通用设置里的「权限」行组件，渲染新会话默认预设的下拉选择与完全访问的风险确认弹层。

- 通过 `usePermission(snapshot => snapshot)` 订阅控制器快照，快照变化驱动重渲染（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L42)）
- 挂载后调用 `load()` 拉取描述符（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L47-L49)）
- 当快照变为不可写或不可用时，强制关闭菜单、清掉已确认标记与确认弹层（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:51-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L51-L56)）
- `status === 'unavailable'` 时返回 null，整行不出现在设置页（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L58)）
- 按 `currentValue` 在选项里找当前项，`loading`/`saving`/确认中三态合成 `busy`，标签在无选中项时退回「加载中」或「不可用」文案（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:59-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L59-L62)）
- 描述位在有错误时改显错误文本，并把该节点的 `role` 切成 `alert`（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L63)、[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L70)）
- 菜单条目由 `state.options` 映射而来，选中项由 `state.currentValue` 标记（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:75-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L75-L76)）
- 选中同一值时直接返回不写入；选中 `FULL_ACCESS_PRESET` 时改为打开风险确认并复位已确认标记，其余值直接调用 `select(id)`（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:77-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L77-L86)）
- 触发按钮在 `busy`、不可写或选项为空时禁用（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L95)）
- 风险确认弹层在不可写或保存中时禁用，取消时复位状态而不写入，确认时关闭弹层并调用 `select(FULL_ACCESS_PRESET)`（[packages/client/ui-permission-presets/src/client/PermissionRow.tsx:104-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/PermissionRow.tsx#L104-L124)）

### packages/client/ui-permission-presets/src/client/index.ts

浏览器半边的插件体：注册通用设置行、注册两套文案字典，并在宿主 `/permission` 命令上挂一个弹出选择装饰。

- `inject` 声明这个 fiber 依赖的服务，缺一则插件不生效（[packages/client/ui-permission-presets/src/client/index.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L46-L49)）
- `selectOf` 从会话投影里取 `permissions` 面的快照，取不到即视为宿主没有该能力（[packages/client/ui-permission-presets/src/client/index.ts:54-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L54-L56)）
- `optionsOf` 把投影里的 `custom` 过滤掉，其余映射成弹窗行：标签走展示函数，`description` 存在时挂 `detail`，等于 `currentValue` 的行打 `active`，`danger-full-access` 行额外带上 `confirmation` 五段文案（[packages/client/ui-permission-presets/src/client/index.ts:59-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L59-L79)）
- 以 effect 注册 `permission.access` 命名空间的中英确认文案，并返回逐个注销的 disposer（[packages/client/ui-permission-presets/src/client/index.ts:92-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L92-L110)）
- 绑定该命名空间的 `t`，并用 `sessions.binding(sessionId)` 把槽位给的会话上下文换成活的会话面（[packages/client/ui-permission-presets/src/client/index.ts:112-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L112-L114)）
- 以 effect 注册 `settings.permission` 命名空间的中英字典（[packages/client/ui-permission-presets/src/client/index.ts:116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L116)）
- 用共享的 describe 镜像、`remote.settings` 与 `settingsSchema` 构造设置控制器，并把 `load`/`select` 与其快照包成注入面交给行组件（[packages/client/ui-permission-presets/src/client/index.ts:119-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L119-L127)）
- 以 effect 在卸载时调用 `controller.dispose()`（[packages/client/ui-permission-presets/src/client/index.ts:129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L129)）
- 向 `settings.general.item` 槽位注册 id 为 `permission`、`order: -20` 的行，绑定 `settings.permission` 文案与注入面（[packages/client/ui-permission-presets/src/client/index.ts:131-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L131-L137)）
- 以 effect 在 `permission` 命令上注册 `popupSelect` 装饰，`available` 判据是该会话的 `permissions` 投影存在（[packages/client/ui-permission-presets/src/client/index.ts:139-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L139-L146)）
- `options` 在投影缺失时抛出「该宿主没有权限预设」，否则返回扁平选项列表（[packages/client/ui-permission-presets/src/client/index.ts:147-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L147-L151)）
- `onSelect` 在会话未落地时抛错，否则提交 `/permission <preset>` 命令行，并对返回的 `!ok` 与 `matched === false` 分别抛出带错误码与「宿主没有该命令」的异常（[packages/client/ui-permission-presets/src/client/index.ts:152-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/index.ts#L152-L158)）

### packages/client/ui-permission-presets/src/client/locales.ts

`settings.permission` 与当前会话确认弹层两套命名空间的中英文案表，由客户端插件体注册。

- 无运行期机制

### packages/client/ui-permission-presets/src/client/presentation.ts

预设名的展示折算与需要风险确认的预设机器值，被行组件与弹窗选项共用。

- 导出 `FULL_ACCESS_PRESET = 'danger-full-access'`，两个界面都用它判定是否走风险确认（[packages/client/ui-permission-presets/src/client/presentation.ts:2](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/presentation.ts#L2)）
- `displayPresetName` 用正则判定是否为 kebab-case，不是就原样返回，是就按 `-` 切分逐词首字母大写再用空格连接（[packages/client/ui-permission-presets/src/client/presentation.ts:9-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/presentation.ts#L9-L12)）
- `displayPermissionPreset` 对完全访问预设返回固定字面量 `Full access`，其余走通用展示折算（[packages/client/ui-permission-presets/src/client/presentation.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/presentation.ts#L20-L22)）

### packages/client/ui-permission-presets/src/client/settings-store.ts

设置行的控制器与解析函数：从共享 describe 镜像里读出 `defaultPreset` 的动态枚举，写回时只改这一个路径。

- `PERMISSION_SETTINGS_NS = 'permission'` 固定读写的设置命名空间（[packages/client/ui-permission-presets/src/client/settings-store.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L19)）
- `permissionDefaultOf` 在 `defaultPreset` 值不是字符串时抛错（[packages/client/ui-permission-presets/src/client/settings-store.ts:55-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L55-L56)）
- 先 `rehydrate` 描述符里的 schema 再取 `['defaultPreset']` 节点，节点缺失时抛错（[packages/client/ui-permission-presets/src/client/settings-store.ts:57-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L57-L58)）
- 节点为 `union` 时取其 `list` 作候选，否则把节点本身当作唯一候选（[packages/client/ui-permission-presets/src/client/settings-store.ts:59-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L59-L61)）
- 候选里只保留 `type === 'const'` 且值为字符串的项，标签优先用 `meta.description`（非空字符串时），否则用机器值，二者都过展示折算（[packages/client/ui-permission-presets/src/client/settings-store.ts:62-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L62-L72)）
- 选项为空或选项里没有当前值时抛错（[packages/client/ui-permission-presets/src/client/settings-store.ts:73-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L73-L75)）
- 控制器持有一个初始为 `idle`、不可写、空选项的快照仓库，行组件通过它订阅（[packages/client/ui-permission-presets/src/client/settings-store.ts:82-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L82-L89)）
- `load()` 在已释放时直接返回，用 `??=` 保证只订阅镜像一次，把状态置 `loading` 并清错，`await ensure()` 后走一次 `derive()`（[packages/client/ui-permission-presets/src/client/settings-store.ts:110-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L110-L119)）
- `select()` 在镜像里找不到该命名空间、不可写或正在保存时直接返回，不发出写入（[packages/client/ui-permission-presets/src/client/settings-store.ts:130-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L130-L133)）
- 写入是一次 `settings.mutate`，只带 `{ op: 'set', path: ['defaultPreset'], value: preset }` 与描述符的 `revision`，响应 `!ok` 转成异常（[packages/client/ui-permission-presets/src/client/settings-store.ts:140-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L140-L145)）
- 写入成功后把返回的视图 `acceptView` 折回共享镜像，由镜像的发布回流到本行；已释放则不再触碰快照（[packages/client/ui-permission-presets/src/client/settings-store.ts:146-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L146-L150)）
- 写入抛错时清 `saving` 并在未释放的前提下把错误落进快照（[packages/client/ui-permission-presets/src/client/settings-store.ts:151-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L151-L155)）
- `dispose()` 置 `disposed` 并退订镜像，之后的发布不再改快照（[packages/client/ui-permission-presets/src/client/settings-store.ts:159-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L159-L163)）
- `derive()` 在已释放或保存中时不改快照（[packages/client/ui-permission-presets/src/client/settings-store.ts:166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L166)）
- 镜像为 `unavailable` 时把状态置 `unavailable`、清空可写位、当前值与选项，行随即隐藏（[packages/client/ui-permission-presets/src/client/settings-store.ts:167-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L167-L178)）
- 镜像还没有视图时：带错误则落成失败态，不带错误则保持 loading 不动（[packages/client/ui-permission-presets/src/client/settings-store.ts:179-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L179-L184)）
- 视图里没有 `permission` 命名空间时同样落成 `unavailable`（[packages/client/ui-permission-presets/src/client/settings-store.ts:185-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L185-L194)）
- 解析成功时把状态置 `ready` 并写入镜像的 `writable`、当前值、选项与该命名空间的 `revision`，解析抛错则落成失败态（[packages/client/ui-permission-presets/src/client/settings-store.ts:195-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L195-L208)）
- `fail()` 把状态置 `error` 并把 `Error` 的 message 或值的字符串形式写进快照，供行的描述位展示（[packages/client/ui-permission-presets/src/client/settings-store.ts:211-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/client/settings-store.ts#L211-L216)）

### packages/client/ui-permission-presets/src/css-modules.d.ts

给 `*.module.css` 导入声明类型的环境声明文件。

- 无运行期机制

### packages/client/ui-permission-presets/src/index.ts

本包的宿主半边入口。

- 导出空的 `apply`，使该插件能出现在宿主的插件表里被挂载，浏览器半边则由清单的客户端声明另行发现（[packages/client/ui-permission-presets/src/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/index.ts#L9)）

### packages/client/ui-permission-presets/src/invariant.ts

本包的不变量伴随插件，向不变量服务登记包归属。

- 导出插件名与 `inject: ['invariants']`，登记前先等到不变量服务（[packages/client/ui-permission-presets/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/invariant.ts#L13-L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/client/ui-permission-presets/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/invariant.ts#L22)）
- `apply` 以包名调用 `ctx.invariants.register` 并把注销函数作为 Promise 结果返回（[packages/client/ui-permission-presets/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/src/invariant.ts#L29-L30)）

### packages/client/ui-permission-presets/tsconfig.json

本包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制

### packages/client/ui-permission-presets/tsdown.config.ts

本包的打包配置，调用共享的客户端打包预设。

- 以包名与 `['lib/types/index.js', 'lib/types/invariant.js']` 两个 node 半边入口调用共享预设，据此产出宿主半边与浏览器半边两类产物（[packages/client/ui-permission-presets/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-permission-presets/tsdown.config.ts#L3)）
