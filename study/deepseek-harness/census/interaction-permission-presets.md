---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/interaction/permission-presets
---

# packages/interaction/permission-presets

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、43 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/interaction/permission-presets/README.md

该包的英文说明文档，描述预设表、切换路径、会话默认值与两个可选子插件的行为。

- 无运行期机制

### packages/interaction/permission-presets/package.json

该包的 npm 清单，声明入口、子路径导出与发布文件白名单。

- `main` / `types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定包被直接 import 时解析到的运行期文件（[packages/interaction/permission-presets/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./types`、`./client`、`./src/*` 与 `./package.json` 五类子路径，其余子路径无法被解析（[packages/interaction/permission-presets/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/package.json#L16-L35)）
- `files` 白名单只打包 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`，其余产物不进入发布包（[packages/interaction/permission-presets/package.json:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/package.json#L36-L41)）

### packages/interaction/permission-presets/src/client.ts

浏览器侧命名空间入口，把 `./types` 的类型面原样投影出去。

- 无运行期机制

### packages/interaction/permission-presets/src/index.ts

服务主体：定义 `ctx.permissionPresets`，持有预设表、写入路径、设置节、会话初始化以及投影与命令两个可选子注册。

- 导出保留名 `custom`，作为“不匹配任何表项”的派生值（[packages/interaction/permission-presets/src/index.ts:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L70)）
- 用 `settingsNamespace('permission')` 计算并导出该服务占用的设置命名空间（[packages/interaction/permission-presets/src/index.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L73)）
- `effectivePermissionPreset` 从后向前扫描事件日志，返回最后一条 `permission/preset` 的 `preset`，没有则返回 undefined（[packages/interaction/permission-presets/src/index.ts:81-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L81-L87)）
- 用 zod 定义投影状态的校验模式，三个字段各自可为 null 且拒绝多余键（[packages/interaction/permission-presets/src/index.ts:109-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L109-L117)）
- `applyKnobEvent` 对 `permission/preset`、`sandbox/mode`、`approval/policy` 三类事件各返回一个新状态对象，其他事件返回同一引用（[packages/interaction/permission-presets/src/index.ts:129-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L129-L140)）
- `foldKnobs` 从空状态起把整条日志逐事件折叠成一个旋钮状态（[packages/interaction/permission-presets/src/index.ts:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L143-L147)）
- `static Config` 校验预设表并默认写入两个条目：`workspace-write`（workspace-write + ask）与 `danger-full-access`（danger-full-access + never），各带展示名与一句说明（[packages/interaction/permission-presets/src/index.ts:177-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L177-L194)）
- `static inject` 声明服务必须在 `shell`、`approval`、`sessions` 三者就绪后才装载（[packages/interaction/permission-presets/src/index.ts:196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L196)）
- 构造时若预设表包含保留名 `custom` 就抛错终止装载（[packages/interaction/permission-presets/src/index.ts:205-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L205-L207)）
- 构造时若挂载的执行器不报告 `sandboxMode` 就抛错终止装载（[packages/interaction/permission-presets/src/index.ts:208-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L208-L210)）
- 未配置 `defaultPreset` 时用空旋钮状态推导，推导结果为 `custom` 则抛错，否则再经 `resolve` 确认该名在表内（[packages/interaction/permission-presets/src/index.ts:211-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L211-L216)）
- 用预设名逐个构造枚举选项（有展示名时附为描述）并组成设置节的校验模式（[packages/interaction/permission-presets/src/index.ts:219-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L219-L226)）
- 安装 `permission` 设置节，并在设置源变更时替换读取默认值的 thunk（[packages/interaction/permission-presets/src/index.ts:227-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L227-L234)）
- 监听 `session/created` 并遍历已存在会话，对每个会话执行初始权限落盘（[packages/interaction/permission-presets/src/index.ts:236-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L236-L241)）
- 定义客户端选择器载荷的 zod 模式：选项数组的 `value`/`name` 非空、`description` 可选，`currentValue` 非空（[packages/interaction/permission-presets/src/index.ts:251-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L251-L258)）
- 仅在存在 `sessionProjections` 时注册 `permissions` 投影单元，带状态模式、初值、逐事件 apply、视图函数与 `stateVersion: 1`（[packages/interaction/permission-presets/src/index.ts:259-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L259-L268)）
- 仅在存在 `commands` 时注册 `/permission` 命令，声明输入提示 `<preset>`（[packages/interaction/permission-presets/src/index.ts:273-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L273-L280)）
- 命令处理器：空输入回报当前预设与可选清单，未知名字返回 error 文本，合法名字走 `apply` 并以 `ctx.approval.setPolicy` 作为审批写入器，返回 success 文本（[packages/interaction/permission-presets/src/index.ts:281-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L281-L291)）
- `names` 按预设表声明顺序返回可切换的名字（[packages/interaction/permission-presets/src/index.ts:300-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L300-L302)）
- `defaultPreset` 每次读取都调用当前设置源 thunk 取值（[packages/interaction/permission-presets/src/index.ts:309-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L309-L311)）
- `current` 先折叠整条日志再推导当前预设名（[packages/interaction/permission-presets/src/index.ts:320-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L320-L322)）
- `derive` 用 `ctx.shell.sandboxMode` 与审批配置（缺省 `ask`）补齐未覆写的旋钮，先让仍匹配的上次选择胜出，否则取表中第一个匹配项，都不匹配则返回 `custom`（[packages/interaction/permission-presets/src/index.ts:325-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L325-L337)）
- `selectFor` 输出按表序排列的全部选项，并且仅当当前值是 `custom` 时把 `custom` 追加进选项列表（[packages/interaction/permission-presets/src/index.ts:345-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L345-L354)）
- `resolve` 对表外名字抛出带已知名单的错误（[packages/interaction/permission-presets/src/index.ts:362-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L362-L368)）
- `optionOf` 为 `custom` 返回固定标签与说明，为表项返回展示名（缺省回落到表键）并仅在配置了说明时带上 `description`（[packages/interaction/permission-presets/src/index.ts:377-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L377-L383)）
- `set` 以 `setApprovalPolicy` 直写会话日志的方式套用一个预设（[packages/interaction/permission-presets/src/index.ts:391-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L391-L393)）
- `apply` 仅在当前预设与目标不同时追加 `permission/preset`，随后各自比较有效值，只对确有变化的沙箱旋钮调用 `setSandboxMode`、对确有变化的审批旋钮调用传入的写入器（[packages/interaction/permission-presets/src/index.ts:396-408](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L396-L408)）
- `pinInitialPermission` 在预设、沙箱、审批三项都缺失且日志无 `session/end-seed` 时，按当前默认预设追加选择事件并写入两个旋钮后返回（[packages/interaction/permission-presets/src/index.ts:416-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L416-L429)）
- 其余情况下按已有事实推导有效预设：缺选择且推导不是 `custom` 时补一条选择事件，缺沙箱时按执行器当前模式补写，缺审批时按审批配置（缺省 `ask`）补写（[packages/interaction/permission-presets/src/index.ts:431-445](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L431-L445)）
- 默认导出服务类，使该包可作为插件行被装载（[packages/interaction/permission-presets/src/index.ts:449](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/index.ts#L449)）

### packages/interaction/permission-presets/src/invariant.ts

该包的不变量伴生插件，校验日志中的预设事件仍能解析到表项。

- 声明伴生插件名与 `invariants` 注入需求（[packages/interaction/permission-presets/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/invariant.ts#L10-L12)）
- `validateEvent` 对 `permission/preset` 事件检查其 `preset` 是否在当前预设名单内，不在则报失败；其他事件放过（[packages/interaction/permission-presets/src/invariant.ts:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/invariant.ts#L15-L19)）
- 安装时遍历已装载会话的全部事件做一次校验（[packages/interaction/permission-presets/src/invariant.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/invariant.ts#L23-L25)）
- 通过全局 `internal/dispatch` 钩住 `session/event` 派发，在事件公布前校验新追加的事件（[packages/interaction/permission-presets/src/invariant.ts:26-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/invariant.ts#L26-L30)）
- 安装器额外声明 `permissionPresets`、`sessions` 注入，缺任一即不运行（[packages/interaction/permission-presets/src/invariant.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/invariant.ts#L31)）
- `apply` 以包名向不变量服务登记该安装器并返回其卸载器（[packages/interaction/permission-presets/src/invariant.ts:38-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/permission-presets/src/invariant.ts#L38-L39)）

### packages/interaction/permission-presets/src/types.ts

纯类型模块：选项与选择器载荷的接口，以及 `permissions` 投影键的声明合并。

- 无运行期机制

### packages/interaction/permission-presets/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工程引用。

- 无运行期机制
