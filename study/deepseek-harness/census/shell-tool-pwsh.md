---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/tool-pwsh
---

# packages/shell/tool-pwsh

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、44 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/tool-pwsh/README.md

该包的说明文档，描述 `pwsh` 工具的选型、配置字段、Windows 沙箱行为、模型可见文本与已知限制。

- 无运行期机制

### packages/shell/tool-pwsh/package.json

该包的 npm 清单，声明模块类型、入口解析与发布内容。

- 声明 ESM 模块类型，并把默认入口与类型入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/shell/tool-pwsh/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/package.json#L13-L15)）
- `exports` 暴露四个子路径：主入口、`./invariant` 伴随插件、把 `./src/*` 原样映射到源码目录、以及 `./package.json`（[packages/shell/tool-pwsh/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/shell/tool-pwsh/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/package.json#L28-L32)）

### packages/shell/tool-pwsh/src/background.ts

把已结束的后台 pwsh 进程句柄映射成通用任务结果词汇，由 `src/index.ts` 在注册后台作业时调用。

- 进程状态为 `killed` 时返回 `killed`，detail 是已知信号名或 `killed before exit`（[packages/shell/tool-pwsh/src/background.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/background.ts#L26-L28)）
- 其余情况一律返回 `completed`，detail 是 `exit code: <码>`，退出码缺失时按 0 计（[packages/shell/tool-pwsh/src/background.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/background.ts#L29)）

### packages/shell/tool-pwsh/src/index.ts

插件入口，向 `ctx.tools` 注册模型可见的 `pwsh` 工具，走同一个 shell 执行器接缝，并负责请求组装、沙箱策略解析与后台作业登记。

- `inject` 声明插件在 `tools`、`shell`、`systemPrompt`、`shellEnv` 四个服务齐备前保持挂起（[packages/shell/tool-pwsh/src/index.ts:49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L49)）
- 配置模式给 `enableRunInBackground` 默认值 `true`（[packages/shell/tool-pwsh/src/index.ts:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L58-L60)）
- `validatePwshArgs` 对空 command、空 description、非正数 timeoutMs 抛错，并调用共享的升级参数配对校验（[packages/shell/tool-pwsh/src/index.ts:87-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L87-L100)）
- `pwshDescription` 拼出模型可见的工具描述：`pwsh -Command`、一次性进程、原生 Windows 路径与 `$env:` 变量、退出码与沙箱拒绝标记、以及 Windows 强杀落为 `[exit code: 1]` 的读法，后台段落随开关切换（[packages/shell/tool-pwsh/src/index.ts:103-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L103-L115)）
- 仅当存在升级目标时，描述追加受限语言模式（只读模式下 .NET 静态调用、`Add-Type`、COM 与反射失败）与命名管道禁用（管道式 stdio 抓取输出报 EPERM）两段约定，以及同回合升级指令段（[packages/shell/tool-pwsh/src/index.ts:116-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L116-L143)）
- `resolveWorkdir` 直接取会话 header 的 cwd 为基准（不做规范化），并把模型给的相对 workdir 解析到该基准之上（[packages/shell/tool-pwsh/src/index.ts:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L150-L157)）
- `canonicalPwshResult` 把执行器结果投影成纯 JSON：退出码、信号、超时、中止、超时值、两路流文本与截断标志（含可选 spillPath），以及可选的 sandbox 字段（[packages/shell/tool-pwsh/src/index.ts:160-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L160-L185)）
- `apply` 只有在 `ctx.shell.sandboxMode` 存在时才把升级目标设为 `ESCALATION_TARGETS` 并取 `sandboxPolicy` 服务（[packages/shell/tool-pwsh/src/index.ts:196-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L196-L199)）
- 执行器声明限制但缺少 `ctx.sandboxPolicy` 时在插件加载处抛错（[packages/shell/tool-pwsh/src/index.ts:200-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L200-L202)）
- `resolveSandboxPolicy` 按调用所属会话逐次解析当前生效的沙箱策略（[packages/shell/tool-pwsh/src/index.ts:205-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L205-L206)）
- 无升级目标时 `approvePwshEscalation` 直接抛出「本组合不可用」的错误（[packages/shell/tool-pwsh/src/index.ts:227-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L227-L229)）
- 升级请求带上生效模式、`command` 主体、审批服务、Agent、callId、工具名 `pwsh` 与信号交给共享的 `approveEscalation`（[packages/shell/tool-pwsh/src/index.ts:230-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L230-L240)）
- 注册 `tool:pwsh` 系统提示段落，按第一方顺序常量插入固定文本，要求检查退出码标记并把中断后的裸 exit 1 读作终止（[packages/shell/tool-pwsh/src/index.ts:244-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L244-L249)）
- 注册名为 `pwsh` 的工具，参数含必填 command/description 与可选 timeoutMs/workdir 及其模型可见说明（[packages/shell/tool-pwsh/src/index.ts:251-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L251-L265)）
- `run_in_background` 仅在开关打开时进入参数表，`sandbox_permissions`（枚举为升级目标）与 `justification` 仅在存在升级目标时进入（[packages/shell/tool-pwsh/src/index.ts:266-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L266-L279)）
- 输出模式声明后台句柄与前台结果两支 `oneOf`，前台支固定字段集合并禁止额外属性（[packages/shell/tool-pwsh/src/index.ts:287-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L287-L337)）
- 渲染器把后台结果渲染成 `started background job <id>`，前台结果交给 `renderPwshResult` 并带上升级目标（[packages/shell/tool-pwsh/src/index.ts:339-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L339-L344)）
- `execute` 先做参数校验，再解析当前策略（[packages/shell/tool-pwsh/src/index.ts:348-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L348-L350)）
- 同时给出 `sandbox_permissions` 与 `justification` 时先走审批，批准后的模式覆盖生效策略的 mode，任何执行都发生在审批之后（[packages/shell/tool-pwsh/src/index.ts:351-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L351-L356)）
- 请求只由 command、解析后的 workdir、可选 timeoutMs、注册表收集的 `dshEnv` 与可选沙箱策略拼成（[packages/shell/tool-pwsh/src/index.ts:357-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L357-L364)）
- 后台开关关闭时拒绝强行传入的 `run_in_background`，缺少 `jobs` 服务时抛出加载提示（[packages/shell/tool-pwsh/src/index.ts:365-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L365-L373)）
- 在移交作业所有权前检查调用信号，已中止则抛出 `TOOL_ABORTED` 的 `AbortError`（[packages/shell/tool-pwsh/src/index.ts:374-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L374-L379)）
- `jobs.start` 以 `pwsh` 种类、命令为标签、Agent 为归属登记作业，run 内启动进程并提供 kill 取消、`processOutcome` 结算与经 `renderPwshProcessRead` 的增量读取，返回作业 id（[packages/shell/tool-pwsh/src/index.ts:381-394](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L381-L394)）
- 前台路径把调用信号并入请求交给 `ctx.shell.run`，结果标记为 aborted 时抛出 `TOOL_ABORTED` 的 `AbortError`，否则返回前台规范结果（[packages/shell/tool-pwsh/src/index.ts:396-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L396-L405)）
- `presentCall` 把后台调用呈现为 generic 卡片、前台调用呈现为带 description 与可选 cwd 的 terminal 卡片（[packages/shell/tool-pwsh/src/index.ts:409-427](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L409-L427)）
- `presentResult` 对后台确认与错误结果输出 console 围栏的 generic 卡片，对前台结果用 `parseExitStatus` 把退出标记从正文剥离成 terminal 卡片的退出态（[packages/shell/tool-pwsh/src/index.ts:430-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/index.ts#L430-L442)）

### packages/shell/tool-pwsh/src/invariant.ts

本包的不变量伴随插件，由 `./invariant` 子路径导出、在运行期诊断组合中挂载。

- 安装器为空函数，不注册任何运行期检查（[packages/shell/tool-pwsh/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/invariant.ts#L21)）
- `apply` 把包名与安装器登记进 `ctx.invariants` 并返回注销函数（[packages/shell/tool-pwsh/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/invariant.ts#L28-L29)）

### packages/shell/tool-pwsh/src/render.ts

把执行器结果与后台进程增量读取渲染成模型可见文本，由 `src/index.ts` 的输出渲染器与作业读取回调调用。

- `streamText` 在流被截断时追加 `[output truncated; full output: <路径或 (unavailable)>]`（[packages/shell/tool-pwsh/src/render.ts:20-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/render.ts#L20-L23)）
- `renderPwshResult` 先拼 stdout，非空 stderr 前插入 `[stderr]` 分节，两者皆空时正文写作 `(no output)`（[packages/shell/tool-pwsh/src/render.ts:50-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/render.ts#L50-L59)）
- 沙箱判定为拒绝时压入拒绝标记，且仅当组合暴露升级目标时再压入同回合升级提示（[packages/shell/tool-pwsh/src/render.ts:63-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/render.ts#L63-L69)）
- 超时时追加 `[timed out after <毫秒>ms]`（[packages/shell/tool-pwsh/src/render.ts:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/render.ts#L71)）
- 有信号时追加 `[killed by signal: <信号>]`，否则退出码非 0 才追加 `[exit code: <码>]`（[packages/shell/tool-pwsh/src/render.ts:72-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/render.ts#L72-L76)）
- 无任何标记时直接返回正文，否则补足换行后按行拼接所有标记，退出标记留在最后（[packages/shell/tool-pwsh/src/render.ts:77-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/render.ts#L77-L80)）
- `renderPwshProcessRead` 在读取有丢失时追加丢字节通知并列出两路溢出文件路径（[packages/shell/tool-pwsh/src/render.ts:98-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/render.ts#L98-L101)）
- 沙箱运行器自身失败时给出「命令未运行」的通知，否则被拒时给出拒绝标记与条件性升级提示（[packages/shell/tool-pwsh/src/render.ts:102-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/render.ts#L102-L109)）
- 无通知时原样返回增量，否则在增量后补换行并拼接通知（[packages/shell/tool-pwsh/src/render.ts:110-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-pwsh/src/render.ts#L110-L111)）

### packages/shell/tool-pwsh/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、类型输出目录与工作区项目引用。

- 无运行期机制
