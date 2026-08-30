---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/tool-bash
---

# packages/shell/tool-bash

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、45 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/tool-bash/README.md

该包的说明文档，描述 `bash` 工具的配置字段、模型可见文本、渲染标记与已知限制，供使用者与维护者阅读。

- 无运行期机制

### packages/shell/tool-bash/package.json

该包的 npm 清单，声明模块类型、入口解析与发布内容。

- 声明 ESM 模块类型，并把默认入口与类型入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/shell/tool-bash/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/package.json#L13-L15)）
- `exports` 暴露四个子路径：主入口、`./invariant` 伴随插件、把 `./src/*` 原样映射到源码目录、以及 `./package.json`（[packages/shell/tool-bash/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/shell/tool-bash/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/package.json#L28-L32)）

### packages/shell/tool-bash/src/background.ts

把已结束的后台 shell 进程句柄映射成通用任务结果词汇，由 `src/index.ts` 在注册后台作业时调用。

- 进程状态为 `killed` 时返回 `killed`，detail 是已知信号名或 `killed before exit`（[packages/shell/tool-bash/src/background.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/background.ts#L23-L25)）
- 其余情况一律返回 `completed`，detail 是 `exit code: <码>`，退出码缺失时按 0 计（[packages/shell/tool-bash/src/background.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/background.ts#L26)）

### packages/shell/tool-bash/src/index.ts

插件入口，向 `ctx.tools` 注册模型可见的 `bash` 工具，并组装请求、解析沙箱策略、登记后台作业。

- `inject` 声明插件在 `tools`、`shell`、`systemPrompt`、`shellEnv` 四个服务齐备前保持挂起（[packages/shell/tool-bash/src/index.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L31)）
- 配置模式给 `enableRunInBackground` 默认值 `true`（[packages/shell/tool-bash/src/index.ts:40-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L40-L42)）
- `validateBashArgs` 对空 command、空 description、非正数 timeoutMs 抛错，并调用共享的升级参数配对校验（[packages/shell/tool-bash/src/index.ts:55-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L55-L68)）
- `bashDescription` 拼出模型可见的工具描述：固定的一次性 shell、`workdir`、退出码标记、`DSH_*` 变量与沙箱拒绝标记说明，后台段落随开关切换（[packages/shell/tool-bash/src/index.ts:70-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L70-L80)）
- 仅当存在升级目标时，描述追加同回合升级指令段（被拒后原样重试一次、禁用审批时拒绝为终局、不得投机升级）（[packages/shell/tool-bash/src/index.ts:81-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L81-L92)）
- `presentBashCall` 把后台调用呈现为 generic 卡片、前台调用呈现为带 description 与可选 cwd 的 terminal 卡片（[packages/shell/tool-bash/src/index.ts:102-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L102-L118)）
- `presentBashResult` 对后台确认与错误结果输出 console 围栏的 generic 卡片，对前台结果用 `parseExitStatus` 把退出标记从正文剥离成 terminal 卡片的退出态（[packages/shell/tool-bash/src/index.ts:124-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L124-L136)）
- `resolveWorkdir` 以沙箱策略的 workspaceRoot 优先、否则取会话 header cwd 的规范化路径，并把模型给的相对 workdir 解析到该基准之上（[packages/shell/tool-bash/src/index.ts:144-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L144-L156)）
- `canonicalBashResult` 把执行器结果投影成纯 JSON：退出码、信号、超时、中止、超时值、两路流文本与截断标志（含可选 spillPath），以及可选的 sandbox 字段（[packages/shell/tool-bash/src/index.ts:159-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L159-L182)）
- `apply` 只有在 `ctx.shell.sandboxMode` 存在时才把升级目标设为 `ESCALATION_TARGETS` 并取 `sandboxPolicy` 服务（[packages/shell/tool-bash/src/index.ts:191-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L191-L194)）
- 执行器声明限制但缺少 `ctx.sandboxPolicy` 时在插件加载处抛错（[packages/shell/tool-bash/src/index.ts:195-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L195-L197)）
- `resolveSandboxPolicy` 按调用所属会话逐次解析当前生效的沙箱策略（[packages/shell/tool-bash/src/index.ts:199-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L199-L200)）
- 无升级目标时 `approveBashEscalation` 直接抛出「本组合不可用」的错误（[packages/shell/tool-bash/src/index.ts:219-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L219-L221)）
- 升级请求带上生效模式、`command` 主体、审批服务、Agent、callId、工具名 `bash` 与信号交给共享的 `approveEscalation`（[packages/shell/tool-bash/src/index.ts:222-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L222-L232)）
- 注册 `tool:bash` 系统提示段落，按第一方顺序常量插入固定文本，要求检查每次结果的退出码标记（[packages/shell/tool-bash/src/index.ts:236-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L236-L240)）
- 注册名为 `bash` 的工具，参数含必填 command/description 与可选 timeoutMs/workdir 及其模型可见说明（[packages/shell/tool-bash/src/index.ts:242-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L242-L255)）
- `run_in_background` 仅在开关打开时进入参数表，`sandbox_permissions`（枚举为升级目标）与 `justification` 仅在存在升级目标时进入（[packages/shell/tool-bash/src/index.ts:256-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L256-L269)）
- 输出模式声明后台句柄与前台结果两支 `oneOf`，前台支固定字段集合并禁止额外属性（[packages/shell/tool-bash/src/index.ts:271-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L271-L322)）
- 渲染器把后台结果渲染成 `started background job <id>`，前台结果交给 `renderResult` 并带上升级目标（[packages/shell/tool-bash/src/index.ts:323-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L323-L328)）
- `execute` 先做参数校验，再解析当前策略（[packages/shell/tool-bash/src/index.ts:331-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L331-L333)）
- 同时给出 `sandbox_permissions` 与 `justification` 时先走审批，批准后的模式覆盖生效策略的 mode，任何执行都发生在审批之后（[packages/shell/tool-bash/src/index.ts:334-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L334-L339)）
- 请求只由 command、解析后的 workdir、可选 timeoutMs、注册表收集的 `dshEnv` 与可选沙箱策略拼成（[packages/shell/tool-bash/src/index.ts:340-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L340-L348)）
- 后台开关关闭时拒绝强行传入的 `run_in_background`，缺少 `jobs` 服务时抛出加载提示（[packages/shell/tool-bash/src/index.ts:349-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L349-L357)）
- 在移交作业所有权前检查调用信号，已中止则抛出 `TOOL_ABORTED` 的 `AbortError`（[packages/shell/tool-bash/src/index.ts:359-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L359-L363)）
- `jobs.start` 以 `bash` 种类、命令为标签、Agent 为归属登记作业，run 内启动进程并提供 kill 取消、`processOutcome` 结算与经 `renderProcessRead` 的增量读取，返回作业 id（[packages/shell/tool-bash/src/index.ts:365-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L365-L378)）
- 前台路径把调用信号并入请求交给 `ctx.shell.run`，结果标记为 aborted 时抛出 `TOOL_ABORTED` 的 `AbortError`，否则返回前台规范结果（[packages/shell/tool-bash/src/index.ts:380-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L380-L389)）
- 把两个呈现函数挂到工具定义上，决定调用与结果在界面上的卡片形态（[packages/shell/tool-bash/src/index.ts:391-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L391-L392)）

### packages/shell/tool-bash/src/invariant.ts

本包的不变量伴随插件，由 `./invariant` 子路径导出、在运行期诊断组合中挂载。

- 安装器为空函数，不注册任何运行期检查（[packages/shell/tool-bash/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/invariant.ts#L21)）
- `apply` 把包名与安装器登记进 `ctx.invariants` 并返回注销函数（[packages/shell/tool-bash/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/invariant.ts#L28-L29)）

### packages/shell/tool-bash/src/render.ts

把执行器结果与后台进程增量读取渲染成模型可见文本，由 `src/index.ts` 的输出渲染器与作业读取回调调用。

- `streamText` 在流被截断时追加 `[output truncated; full output: <路径或 (unavailable)>]`（[packages/shell/tool-bash/src/render.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L12-L15)）
- `renderResult` 先拼 stdout，非空 stderr 前插入 `[stderr]` 分节，两者皆空时正文写作 `(no output)`（[packages/shell/tool-bash/src/render.ts:32-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L32-L41)）
- 沙箱判定为拒绝时压入拒绝标记，且仅当组合暴露升级目标时再压入同回合升级提示（[packages/shell/tool-bash/src/render.ts:45-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L45-L51)）
- 超时时追加 `[timed out after <毫秒>ms]`，即使命令自行以 0 退出（[packages/shell/tool-bash/src/render.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L53)）
- 有信号时追加 `[killed by signal: <信号>]`，否则退出码非 0 才追加 `[exit code: <码>]`（[packages/shell/tool-bash/src/render.ts:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L54-L58)）
- 无任何标记时直接返回正文，否则补足换行后按行拼接所有标记，退出标记留在最后（[packages/shell/tool-bash/src/render.ts:59-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L59-L62)）
- `renderProcessRead` 在读取有丢失时追加丢字节通知并列出两路溢出文件路径（[packages/shell/tool-bash/src/render.ts:81-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L81-L84)）
- 沙箱运行器自身失败时给出「命令未运行」的通知，否则被拒时给出拒绝标记与条件性升级提示（[packages/shell/tool-bash/src/render.ts:85-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L85-L92)）
- 无通知时原样返回增量，否则在增量后补换行并拼接通知（[packages/shell/tool-bash/src/render.ts:93-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L93-L94)）

### packages/shell/tool-bash/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、类型输出目录与工作区项目引用。

- 无运行期机制
