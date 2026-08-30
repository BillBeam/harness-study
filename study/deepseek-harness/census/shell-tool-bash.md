---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/tool-bash
---

# packages/shell/tool-bash

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、46 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/tool-bash/README.md

包的说明文档，描述 `bash` 工具的挂载方式、配置字段、沙箱升权路径与模型可见文本，供使用者和维护者阅读。

- 无运行期机制

### packages/shell/tool-bash/package.json

包清单，声明入口、发布文件与依赖关系。

- `exports` 把 `.` 映射到 `lib/index.js`、`./invariant` 映射到 `lib/invariant.js`，并放开 `./src/*` 与 `./package.json` 的直接引用，决定运行期可被加载的模块入口（[packages/shell/tool-bash/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/package.json#L16-L27)）
- `files` 只把 `lib/index.js`、`lib/invariant.js` 与类型声明纳入发布产物（[packages/shell/tool-bash/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/package.json#L28-L32)）

### packages/shell/tool-bash/src/background.ts

把后台 bash 进程的终结状态翻译成通用任务结局词汇的小模块，被 `src/index.ts` 在 `jobs.start` 的 `done` 回调里调用。

- `processOutcome` 把 `killed` 状态映射为 `killed` 并以信号名（或 `killed before exit`）作为 detail，其余一律映射为 `completed` 并以 `exit code: N` 作为 detail，使非零退出码不被记为失败（[packages/shell/tool-bash/src/background.ts:17-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/background.ts#L17-L27)）

### packages/shell/tool-bash/src/index.ts

插件入口：注册模型可见的 `bash` 工具、贡献系统提示片段、校验参数、解析沙箱策略与升权、组装执行请求并分派前台/后台两条路径。

- 声明插件名与注入的 `tools`、`shell`、`systemPrompt`、`shellEnv` 四个服务，四者齐备前插件不激活、工具不注册（[packages/shell/tool-bash/src/index.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L30-L31)）
- `Config` 模式把 `enableRunInBackground` 默认设为 `true`（[packages/shell/tool-bash/src/index.ts:40-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L40-L42)）
- `validateBashArgs` 在执行前拒绝空 `command`、空 `description` 与非正数 `timeoutMs`，抛出固定文案的错误（[packages/shell/tool-bash/src/index.ts:56-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L56-L64)）
- 同一处调用 `validateEscalationArgs` 校验 `sandbox_permissions` 与 `justification` 的成对出现（[packages/shell/tool-bash/src/index.ts:67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L67)）
- `bashDescription` 按 `backgroundEnabled` 在描述里二选一地写入"可用 `run_in_background`"或"后台执行不可用"（[packages/shell/tool-bash/src/index.ts:71-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L71-L73)）
- 描述基文告知每次调用是全新 shell、用 `workdir` 而非 `cd`、非零退出以 `[exit code: N]` 呈现、`$DSH_*` 变量存在、沙箱拒绝的标记形态与长输出截断到尾部（[packages/shell/tool-bash/src/index.ts:74-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L74-L80)）
- 仅当存在升权目标时，描述追加同轮一次性升权段落：先跑再读标记、被拒后同轮以最窄更宽模式加一句理由重试、审批提示即用户同意、被拒的升权对该命令终局（[packages/shell/tool-bash/src/index.ts:81-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L81-L92)）
- `presentBashCall` 把后台调用呈现为 generic 卡片（标题为命令、内容为 description），前台调用呈现为 terminal 卡片并透传 `workdir` 作为 cwd（[packages/shell/tool-bash/src/index.ts:102-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L102-L118)）
- `presentBashResult` 对后台确认与错误结果包成 ```console 围栏的 generic 卡片，对前台结果用 `parseExitStatus` 把退出标记从正文中取出改挂为卡片的退出状态（[packages/shell/tool-bash/src/index.ts:124-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L124-L136)）
- `resolveWorkdir` 用沙箱策略的 workspaceRoot 优先、否则用会话头 cwd 的规范化路径作为基准，把模型给的相对 `workdir` 解析成绝对路径（[packages/shell/tool-bash/src/index.ts:144-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L144-L156)）
- `canonicalBashResult` 把执行器返回值投影成纯 JSON：退出码、信号、超时/中断标志、超时值、两路流的 text/truncated/spillPath，以及可选的 sandbox 模式与拒绝标志（[packages/shell/tool-bash/src/index.ts:159-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L159-L182)）
- `apply` 读取 `ctx.shell.sandboxMode` 决定是否存在升权目标集合（[packages/shell/tool-bash/src/index.ts:191-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L191-L193)）
- 执行器声明约束但 `ctx.sandboxPolicy` 缺失时在插件加载处直接抛错（[packages/shell/tool-bash/src/index.ts:194-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L194-L197)）
- `resolveSandboxPolicy` 每次调用按调用方 session 解析当前生效策略（[packages/shell/tool-bash/src/index.ts:199-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L199-L200)）
- 组合中没有约束执行器时，`sandbox_permissions` 到达 execute 也被显式拒绝（[packages/shell/tool-bash/src/index.ts:219-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L219-L221)）
- 升权在任何执行之前经 `approveEscalation` 交给 `ctx.approval`，带上请求模式、理由、当前生效模式、callId、工具名与取消信号（[packages/shell/tool-bash/src/index.ts:222-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L222-L232)）
- 向 `ctx.systemPrompt` 注册 `tool:bash` 片段，按第一方顺序 `TOOL_BASH` 把"检查每条 bash 结果的 [exit code: N] 标记"写进每次请求（[packages/shell/tool-bash/src/index.ts:236-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L236-L240)）
- 向 `ctx.tools` 注册名为 `bash` 的工具及其动态描述（[packages/shell/tool-bash/src/index.ts:242-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L242-L244)）
- 参数表声明必填 `command`、必填 `description`（含 5-10 词的写法示例）、可选 `timeoutMs` 与 `workdir`（[packages/shell/tool-bash/src/index.ts:246-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L246-L255)）
- `run_in_background` 只在配置启用时出现在模型可见的参数表里（[packages/shell/tool-bash/src/index.ts:256-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L256-L258)）
- `sandbox_permissions`（枚举限定为升权目标）与 `justification` 只在存在升权目标时出现在参数表里（[packages/shell/tool-bash/src/index.ts:259-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L259-L269)）
- 输出模式声明为 background/foreground 两支的 `oneOf`，前台分支逐字段约束退出码、信号、超时、两路流与 sandbox 字段（[packages/shell/tool-bash/src/index.ts:271-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L271-L322)）
- `render` 把后台结果渲染成 `started background job <id>`，前台结果交给 `renderResult` 并带上升权目标集合（[packages/shell/tool-bash/src/index.ts:323-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L323-L328)）
- execute 先跑参数校验，再解析本次调用的标准策略（[packages/shell/tool-bash/src/index.ts:331-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L331-L333)）
- 仅当 `sandbox_permissions` 与 `justification` 同时给出时才走审批，审批通过后用批准模式覆盖策略的 mode（[packages/shell/tool-bash/src/index.ts:334-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L334-L339)）
- 通过 `ctx.shellEnv.collect(exec)` 收集本次调用的受管环境变量（[packages/shell/tool-bash/src/index.ts:341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L341)）
- 请求只由命令、workdir、timeoutMs、收集到的 dshEnv 与沙箱策略组成，模型无法注入 stdin/env 等其他键（[packages/shell/tool-bash/src/index.ts:342-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L342-L348)）
- 配置关闭后台时，模型强行传入 `run_in_background` 仍在执行处被拒（[packages/shell/tool-bash/src/index.ts:350-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L350-L353)）
- 后台调用时缺少 `jobs` 服务则抛出指明需加载哪两个包的错误（[packages/shell/tool-bash/src/index.ts:354-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L354-L357)）
- 在把所有权移交 `ctx.jobs` 之前若调用已中断，抛出 `TOOL_ABORTED` 的 `AbortError`（[packages/shell/tool-bash/src/index.ts:358-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L358-L363)）
- `jobs.start` 以 `kind: 'bash'`、命令作为 label、执行方 agent 作为 owner 注册任务，`run` 里启动进程并给出 cancel（kill）、done（`processOutcome`）与 readOutput（`renderProcessRead`）三个钩子，随后立即返回 jobId（[packages/shell/tool-bash/src/index.ts:365-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L365-L378)）
- 前台路径把 `exec.signal` 并入请求后交给 `ctx.shell.run`，使工具调用的取消能中断命令（[packages/shell/tool-bash/src/index.ts:380-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L380-L383)）
- 执行器报告 aborted 时抛出 `TOOL_ABORTED` 的 `AbortError` 而非返回结果（[packages/shell/tool-bash/src/index.ts:384-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L384-L388)）
- 正常前台返回打上 `kind: 'foreground'` 标签的规范化结果（[packages/shell/tool-bash/src/index.ts:389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/index.ts#L389)）

### packages/shell/tool-bash/src/invariant.ts

包自带的不变量伴生插件，由不变量注册表在组合加载时挂载。

- 以空安装器向 `ctx.invariants` 注册本包名并返回其 disposer，不做任何运行期关系检查（[packages/shell/tool-bash/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/invariant.ts#L21-L29)）

### packages/shell/tool-bash/src/render.ts

面向模型的结果文本渲染模块，被 `src/index.ts` 的 output.render 与后台 readOutput 调用。

- `streamText` 在流被截断时追加 `[output truncated; full output: <path>]`，无溢出路径时写 `(unavailable)`（[packages/shell/tool-bash/src/render.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L12-L15)）
- `renderResult` 先放 stdout，stderr 非空时以 `[stderr]` 分节追加，两者皆空时正文写成 `(no output)`（[packages/shell/tool-bash/src/render.ts:32-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L32-L41)）
- 沙箱拒绝时追加拒绝标记，并且仅在组合暴露升权时再追加同轮升权提示标记（[packages/shell/tool-bash/src/render.ts:45-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L45-L51)）
- 超时追加 `[timed out after Nms]`；有信号则追加 `[killed by signal: S]`，否则非零退出码追加 `[exit code: N]`，退出标记永远排在最后一行（[packages/shell/tool-bash/src/render.ts:52-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L52-L62)）
- `renderProcessRead` 在内存截断丢字节时追加 `[some output was dropped from memory; full output: …]` 并列出两路溢出文件路径（[packages/shell/tool-bash/src/render.ts:80-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L80-L84)）
- 后台读在沙箱运行器自身失败时追加"命令没有运行、这是沙箱问题"的提示，否则在被拒时追加拒绝标记与（有升权目标时的）升权提示，最终拼在增量文本之后（[packages/shell/tool-bash/src/render.ts:85-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash/src/render.ts#L85-L94)）

### packages/shell/tool-bash/tsconfig.json

包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制
