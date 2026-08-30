---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/tool-subagent-report
---

# packages/subagent/tool-subagent-report

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、17 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/tool-subagent-report/README.md

该包的说明文档，描述子代理向上回报通道的安装位置、投递调度与父侧可见内容。

- 无运行期机制

### packages/subagent/tool-subagent-report/package.json

该包的 npm 清单，声明入口、导出子路径与发布文件集。

- `main`/`types` 把默认加载入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/subagent/tool-subagent-report/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/package.json#L14-L15)）
- `exports` 只暴露根入口、`./invariant`、`./src/*` 与 `./package.json` 四个可解析子路径（[packages/subagent/tool-subagent-report/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的声明文件（[packages/subagent/tool-subagent-report/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/package.json#L28-L32)）

### packages/subagent/tool-subagent-report/src/index.ts

把 `report` 工具与其提示段落装进每个可续进程内子代理未发布作用域的插件入口。

- 声明 `inject = ['subagents', 'tools', 'systemPrompt']`，使加载顺序问题在加载期而非子代理物化时暴露（[packages/subagent/tool-subagent-report/src/index.ts:18-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L18-L21)）
- 取 `FIRST_PARTY_SECTION_ORDER.TOOL_REPORT` 作为回报指引段落的排序位置（[packages/subagent/tool-subagent-report/src/index.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L24)）
- `Config` 把 `reportDelivery` 限定为 `quiet` 与 `next-step` 二选一并默认 `next-step`（[packages/subagent/tool-subagent-report/src/index.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L36-L38)）
- `installReportTool` 先在子作用域注册名为 `tool:report` 的提示段落，其文本要求子代理结束前用 report 交付自包含答案、部分发现也要早报、回报不结束当前轮（[packages/subagent/tool-subagent-report/src/index.ts:54-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L54-L62)）
- 在同一子作用域注册 `report` 工具，其描述声明只到直接父代理、不自动传递转录与工具输出、失败调用也可能已送达（[packages/subagent/tool-subagent-report/src/index.ts:65-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L65-L73)）
- `report` 只接受一个必填 `output` 字符串参数，不带收件人或投递模式参数（[packages/subagent/tool-subagent-report/src/index.ts:74-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L74-L80)）
- `report` 的输出只含 `messageId`，渲染成一行受理确认（[packages/subagent/tool-subagent-report/src/index.ts:81-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L81-L93)）
- 执行时把文本包成内容块交给 `subagents.reportFrom`，附上部署侧解析出的投递策略与执行信号（[packages/subagent/tool-subagent-report/src/index.ts:94-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L94-L103)）
- 工具注册失败时回滚已注册的提示段落，回滚再失败则抛出合并两者的 `AggregateError`（[packages/subagent/tool-subagent-report/src/index.ts:105-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L105-L115)）
- 返回的 disposer 逐个尝试撤销工具与提示段落，收集全部失败后再一次性抛出（[packages/subagent/tool-subagent-report/src/index.ts:116-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L116-L128)）
- `apply` 用 `Config()` 在运行期落实默认投递策略，并以 `registerContinuableSetup` 把安装函数挂成每个可续子代理的建立步骤（[packages/subagent/tool-subagent-report/src/index.ts:136-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/index.ts#L136-L141)）

### packages/subagent/tool-subagent-report/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包归属。

- 以空安装器向 `ctx.invariants` 注册包名并返回其 disposer，即运行期不安装任何检查（[packages/subagent/tool-subagent-report/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-report/src/invariant.ts#L21-L29)）

### packages/subagent/tool-subagent-report/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
