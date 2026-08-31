---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/workflow/tool-ralph
---

# packages/workflow/tool-ralph

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、39 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/workflow/tool-ralph/README.md

包 README，说明 `ralph` 工具的固定前台循环、每轮全新子代与有界交接报告，面向使用者与配置者。

- 记载调用参数 `{ objective, maxRounds? }`、调用阻塞直至整轮运行结算，以及三种终态 `complete`/`blocked`/`budget-limited` 与其携带内容（[packages/workflow/tool-ralph/README.md:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/README.md#L30-L32)）
- 记载每个子代只看到不变目标、当前轮次与上限、共享工作区为权威的指令、以及上一轮结构化交接，父对话与此前子会话都不注入（[packages/workflow/tool-ralph/README.md:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/README.md#L34-L36)）
- 记载四项配置字段及其默认值 `spawn`/`256`/`16384`/`16384`，以及所配 provider 必须支持结构化输出且不继承父上下文（[packages/workflow/tool-ralph/README.md:38-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/README.md#L38-L47)）
- 记载工具向系统提示注册的固定引导原文（[packages/workflow/tool-ralph/README.md:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/README.md#L113-L117)）
- 记载父只看到原始调用与一条终态结果，中间子代消息与报告不进入父对话；失败子代改为带轮号与上次交接的错误（[packages/workflow/tool-ralph/README.md:143-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/README.md#L143-L145)）
- 记载 `maxHandoffChars` 界定跨轮状态、`maxResultChars` 独立界定父侧完整成功文本，子代工作不占父上下文（[packages/workflow/tool-ralph/README.md:147-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/README.md#L147-L153)）

### packages/workflow/tool-ralph/package.json

npm 清单，声明入口、导出、发布文件集与对 workflow、subagent、tools 等包的 peer 依赖。

- `main`/`types`/`exports` 把 `.`、`./invariant`、`./src/*` 映射到具体产物文件（[packages/workflow/tool-ralph/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/package.json#L14-L27)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 d.ts（[packages/workflow/tool-ralph/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/package.json#L28-L32)）

### packages/workflow/tool-ralph/src/index.ts

插件入口：固定编排脚本、provider 校验、报告解码与 `ralph` 工具及其系统提示段的注册。

- Schemastery 配置给出 `subagentProvider`、`maxRounds`、`maxHandoffChars`、`maxResultChars` 的默认值与取值范围（[packages/workflow/tool-ralph/src/index.ts:34-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L34-L39)）
- `RALPH_META` 固定工作流名称、描述与单一阶段声明，供引擎与观察者使用（[packages/workflow/tool-ralph/src/index.ts:79-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L79-L83)）
- 固定脚本内嵌子代结构化输出的 JSON Schema：五个必填字段、status 三值枚举、禁止额外属性（[packages/workflow/tool-ralph/src/index.ts:90-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L90-L101)）
- 脚本内 `validateReport` 要求 summary 非空归一化、evidence/nextSteps 全为归一化字符串、blocker 为归一化字符串，否则抛错终止工作流（[packages/workflow/tool-ralph/src/index.ts:111-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L111-L123)）
- 脚本内按 status 施加分支语义：continue 需 nextSteps 且 blocker 为空、complete 需 evidence 且无 nextSteps、blocked 需具体 blocker，未知 status 抛错（[packages/workflow/tool-ralph/src/index.ts:124-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L124-L142)）
- 脚本内以序列化长度对 `maxHandoffChars` 设限，超限抛错而非截断（[packages/workflow/tool-ralph/src/index.ts:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L143-L147)）
- 脚本主循环从 1 到 `args.maxRounds`，每轮构造子代提示并调 `agent(prompt, { label, phase, schema })`（[packages/workflow/tool-ralph/src/index.ts:150-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L150-L166)）
- 子代提示原文规定：无父对话与前序子会话、禁止再调 ralph、不变目标、轮次与上限、工作区为长期记忆与真相来源、上一轮交接、以及三种 status 的使用条件（[packages/workflow/tool-ralph/src/index.ts:154-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L154-L161)）
- 子代返回 null 时脚本以 `round-failed` 终止并带上最近一次交接（[packages/workflow/tool-ralph/src/index.ts:167-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L167-L169)）
- `complete`/`blocked` 立即返回终态并停止循环，`continue` 把本轮报告作为下一轮唯一跨轮状态；走完上限返回 `budget-limited`（[packages/workflow/tool-ralph/src/index.ts:170-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L170-L175)）
- `DESCRIPTION` 是模型看到的工具描述文本，规定仅在人类明确要求时使用及每轮全新子代、工作区为长期记忆（[packages/workflow/tool-ralph/src/index.ts:178-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L178-L183)）
- `resolveConfig` 在未经 Loader 归一化时补默认值并拒绝非归一化 provider、非正安全整数的三个上限（[packages/workflow/tool-ralph/src/index.ts:186-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L186-L204)）
- `resolveMaxRounds` 把模型给的轮上限限制在部署上限内，超出即抛错（[packages/workflow/tool-ralph/src/index.ts:207-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L207-L216)）
- `requireFreshProvider` 在任何一轮开始前要求 provider 已注册、支持 outputSchema、且不继承父上下文（[packages/workflow/tool-ralph/src/index.ts:219-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L219-L231)）
- `readReport` 在消费端二次校验报告：键集合精确匹配、status 与预期一致、各字段归一化、分支语义与字符上限（[packages/workflow/tool-ralph/src/index.ts:246-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L246-L279)）
- `readRunResult` 校验 `roundsStarted` 在 1 到 maxRounds 之间，并按四种 status 校验键集合、`budget-limited` 必须发生在轮上限、`round-failed` 首轮必须无上次交接（[packages/workflow/tool-ralph/src/index.ts:282-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L282-L332)）
- `stopReasonError` 把非 `completed` 的工作流终止原因映射为错误文本，而非部分成功（[packages/workflow/tool-ralph/src/index.ts:335-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L335-L348)）
- `boundResult` 对包含截断标记在内的完整父侧文本施加 `maxResultChars` 上限（[packages/workflow/tool-ralph/src/index.ts:350-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L350-L357)）
- `renderResult` 决定模型看到的终态文本：三种状态各自的措辞、轮数与美化打印的最终报告（[packages/workflow/tool-ralph/src/index.ts:360-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L360-L375)）
- `renderRoundFailure` 决定子代失败时模型看到的错误文本，含失败轮号与最近一次成功交接（[packages/workflow/tool-ralph/src/index.ts:385-391](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L385-L391)）
- `presentCall`/`presentResult` 决定外部界面呈现：generic 卡片、标题 `ralph`、以 objective 作为 rawInput（[packages/workflow/tool-ralph/src/index.ts:393-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L393-L401)）
- `apply` 注册 `tool:ralph` 系统提示段，固定顺序与固定引导文本，进入每个父请求（[packages/workflow/tool-ralph/src/index.ts:406-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L406-L410)）
- 工具参数模式只暴露必填 `objective` 与可选 `maxRounds`，provider、交接上限、报告模式均不在调用模式中（[packages/workflow/tool-ralph/src/index.ts:414-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L414-L424)）
- 输出模式固定为 `{ runId, agentsStarted, result }`，`render` 把 result 交给 `renderResult` 生成模型可见文本（[packages/workflow/tool-ralph/src/index.ts:425-435](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L425-L435)）
- `execute` 缺少 `exec.agent` 时抛错，并要求 objective trim 后非空（[packages/workflow/tool-ralph/src/index.ts:436-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L436-L442)）
- `execute` 以固定脚本调用 `ctx.workflowEngine.start`，把 provider 作为 `subagentProvider`、轮上限作为 `maxTotalAgents`、调用方 Agent 作为 parent、`exec.signal` 作为取消信号（[packages/workflow/tool-ralph/src/index.ts:446-454](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L446-L454)）
- 把父步骤的 abort 桥接到 `run.cancel()`，并处理开始前就已 abort 的情形（[packages/workflow/tool-ralph/src/index.ts:455-457](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L455-L457)）
- await `run.result` 后先判终止原因、再解码终态值，`round-failed` 抛出渲染后的错误（[packages/workflow/tool-ralph/src/index.ts:459-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L459-L464)）
- `finally` 中移除 abort 监听并 `await run.dispose()`，使工具返回前等待脚本与子代静默（[packages/workflow/tool-ralph/src/index.ts:470-473](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/index.ts#L470-L473)）

### packages/workflow/tool-ralph/src/invariant.ts

该包的不变式伴生插件，占位注册包名并说明为何没有运行期不变式。

- `apply` 以包名注册一个空安装器并返回其 disposer（[packages/workflow/tool-ralph/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/tool-ralph/src/invariant.ts#L28-L29)）

### packages/workflow/tool-ralph/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、输出目录与工作区项目引用。

- 无运行期机制
