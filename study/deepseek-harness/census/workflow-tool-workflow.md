---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/workflow/tool-workflow
---

# packages/workflow/tool-workflow

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、39 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/workflow/tool-workflow/README.md

包 README，说明模型可见的 `workflow` 工具：调用模式、结果封套、运行生命周期与耐久 Session 记录。

- 记载三个调用参数 `meta`/`script`/`args` 的要求，包括脚本必须是纯 JS 体、不含 `export const meta`、args 必须是对象（[packages/workflow/tool-workflow/README.md:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/README.md#L30-L32)）
- 记载成功封套 `{ runId, agentsStarted, result }` 及其渲染文本，以及取消与执行失败的错误文本、绝不把部分输出当成功（[packages/workflow/tool-workflow/README.md:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/README.md#L34)）
- 记载父回合在脚本运行期间阻塞、工具总会 dispose 运行、取消由父步骤 abort 桥接，模型只见一个最终结果（[packages/workflow/tool-workflow/README.md:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/README.md#L36-L38)）
- 记载两项配置 `toolName`（默认 `workflow`）与 `maxResultChars`（默认 50000）的作用（[packages/workflow/tool-workflow/README.md:40-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/README.md#L40-L47)）
- 记载耐久记录规则：仅根传输执行写四类日志事件，嵌套调用不记录，首次追加失败即停记并保留合法前缀（[packages/workflow/tool-workflow/README.md:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/README.md#L67-L69)）
- 记载注册进系统提示的引导原文与其随 `toolName` 变化（[packages/workflow/tool-workflow/README.md:110-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/README.md#L110-L114)）
- 记载模型可见的成功与失败文本逐字形状，包括截断标记与无 agent 时的错误（[packages/workflow/tool-workflow/README.md:140-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/README.md#L140-L142)）

### packages/workflow/tool-workflow/package.json

npm 清单，声明入口、导出、发布文件集与对 workflow、tools、session 等包的 peer 依赖。

- `main`/`types`/`exports` 把 `.`、`./invariant`、`./types`、`./src/*` 映射到具体产物文件（[packages/workflow/tool-workflow/package.json:14-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/package.json#L14-L31)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 js/d.ts（[packages/workflow/tool-workflow/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/package.json#L32-L37)）

### packages/workflow/tool-workflow/src/index.ts

插件入口：`workflow` 工具的模式与描述、运行生命周期、结果渲染，以及把运行投影进父 Session 的记录器。

- Schemastery 配置给出 `toolName` 默认 `workflow`、`maxResultChars` 默认 50000 且不小于 1（[packages/workflow/tool-workflow/src/index.ts:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L39-L42)）
- 记录器的 `append` 捕获追加失败，记 warn 并返回 false，不让记录失败影响工具执行（[packages/workflow/tool-workflow/src/index.ts:74-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L74-L92)）
- 监听 `workflow/agent-start`，按 runId 过滤后向对应 Session 追加 `tool-workflow/agent-start` 事件，失败即从活动表移除该运行（[packages/workflow/tool-workflow/src/index.ts:94-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L94-L105)）
- 监听 `workflow/agent-end`，同样过滤并追加 `tool-workflow/agent-end` 事件（[packages/workflow/tool-workflow/src/index.ts:106-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L106-L115)）
- `start` 只在 run-start 追加成功后才把该运行登记为活动，`finish` 追加 run-end 后删除，`abandon` 直接删除（[packages/workflow/tool-workflow/src/index.ts:117-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L117-L129)）
- `DESCRIPTION` 是模型看到的脚本编写契约全文：meta 字段、脚本体要求、`agent`/`pipeline`/`parallel`/`phase`/`log`/`args` 各钩子语义、schema 子集限制、错误必致命、无文件系统/网络/定时器、前台执行（[packages/workflow/tool-workflow/src/index.ts:137-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L137-L149)）
- `presentWorkflowCall`/`presentWorkflowResult` 决定外部界面呈现：generic 卡片、标题取 `meta.name`、脚本文本作为 rawInput（[packages/workflow/tool-workflow/src/index.ts:163-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L163-L176)）
- `stopReasonError` 把 `cancelled`/`error`/未知终止原因映射为具体错误文本（[packages/workflow/tool-workflow/src/index.ts:179-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L179-L192)）
- `renderResult` 生成模型可见结果文本，并对超出 `maxResultChars` 的 JSON 截断并追加省略字符数（[packages/workflow/tool-workflow/src/index.ts:195-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L195-L202)）
- `apply` 注册 `tool:<toolName>` 系统提示段，文本随 toolName 变化并进入该作用域的每个父请求（[packages/workflow/tool-workflow/src/index.ts:211-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L211-L215)）
- 工具参数模式定义 `script`（必填）、`meta`（必填，含 name/description/whenToUse/phases）与可选 `args`（[packages/workflow/tool-workflow/src/index.ts:219-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L219-L255)）
- 输出模式固定为 `{ runId, agentsStarted, result }` 且禁止额外属性，`render` 用 `meta.name` 与结果生成文本（[packages/workflow/tool-workflow/src/index.ts:256-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L256-L270)）
- `execute` 在 `exec.agent` 缺失时抛错，不猜测子代归属（[packages/workflow/tool-workflow/src/index.ts:272-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L272-L278)）
- `execute` 用模型给的 script/meta/args 调 `ctx.workflowEngine.start`，meta 与脚本解析失败在此同步抛出并成为模型可纠正的 isError（[packages/workflow/tool-workflow/src/index.ts:280-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L280-L289)）
- 仅当 `exec.parent === undefined`（根传输执行）时才开启该运行的耐久记录（[packages/workflow/tool-workflow/src/index.ts:290-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L290-L293)）
- 把父步骤 abort 桥接到 `run.cancel('parent step aborted')`（[packages/workflow/tool-workflow/src/index.ts:295-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L295-L299)）
- await `run.result` 后非 `completed` 即抛错报告原因而非部分输出，成功则返回三字段封套（[packages/workflow/tool-workflow/src/index.ts:302-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L302-L314)）
- `finally` 中移除 abort 监听、`await run.dispose()` 达到静默后才写 run-end，并在内层 finally 中无条件放弃该运行的记录（[packages/workflow/tool-workflow/src/index.ts:315-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/index.ts#L315-L328)）

### packages/workflow/tool-workflow/src/invariant.ts

该包的不变式伴生插件，对 Session 日志中的四类工作流记录事件做增量折叠校验。

- `isWorkflowRecordEvent` 按 `tool-workflow/` 前缀界定本包拥有的事件（[packages/workflow/tool-workflow/src/invariant.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L23-L25)）
- `cloneTraceForEvent` 只复制候选事件会改动的那个运行，其余已提交状态共享（[packages/workflow/tool-workflow/src/invariant.ts:51-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L51-L65)）
- `openRun` 要求事件命名的运行已存在且未结束（[packages/workflow/tool-workflow/src/invariant.ts:68-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L68-L73)）
- `run-start` 要求 name 非空且拒绝重复的 runId（[packages/workflow/tool-workflow/src/invariant.ts:81-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L81-L88)）
- `agent-start` 校验 seq 为正安全整数、label 为字符串、phase 存在时为字符串、childId 非空，并拒绝重复 seq（[packages/workflow/tool-workflow/src/invariant.ts:89-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L89-L100)）
- `agent-end` 校验 outcome 三值之一，并要求存在未配对的同 seq 成员（[packages/workflow/tool-workflow/src/invariant.ts:101-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L101-L112)）
- `run-end` 校验 stopReason 三值之一，并拒绝仍有未结束成员的收尾（[packages/workflow/tool-workflow/src/invariant.ts:113-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L113-L125)）
- 未知的 `tool-workflow/*` 事件类型直接判失败（[packages/workflow/tool-workflow/src/invariant.ts:126-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L126-L127)）
- 安装时对已有 Session 冷载重放全部记录事件，并对 `session/created` 的新 Session 同样播种（[packages/workflow/tool-workflow/src/invariant.ts:136-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L136-L143)）
- 在 `internal/dispatch` 上对候选事件预演折叠并暂存结果，在 `session/event` 发布时才提交，未经预演的发布判失败（[packages/workflow/tool-workflow/src/invariant.ts:144-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/invariant.ts#L144-L162)）

### packages/workflow/tool-workflow/src/types.ts

四类耐久工作流记录事件的载荷类型，并把它们声明合并进 `SessionEventMap`。

- 向 `@deepseek-ai/dsh-session/types` 的 `SessionEventMap` 合并 `tool-workflow/run-start`、`agent-start`、`agent-end`、`run-end` 四个事件键，使 Session 日志能承载并回读这些记录（[packages/workflow/tool-workflow/src/types.ts:41-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-workflow/src/types.ts#L41-L64)）

### packages/workflow/tool-workflow/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、输出目录与工作区项目引用。

- 无运行期机制
