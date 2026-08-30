---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/workflow/workflow
---

# packages/workflow/workflow

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、31 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/workflow/workflow/README.md

包 README，说明工作流能力接缝的运行、结果与事件词汇，以及它不自带执行引擎这一点。

- 记载脚本体的形态与可用钩子 `agent`/`parallel`/`pipeline`/`phase`/`log`，脚本无返回时结果为 `null`（[packages/workflow/workflow/README.md:34-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/README.md#L34-L47)）
- 记载 `start({ script, meta, args?, parent, signal? })` 的语义：parent 归属所有子代、signal 取消运行、meta 与脚本在运行存在前就被校验（[packages/workflow/workflow/README.md:49-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/README.md#L49-L53)）
- 记载 result 永不 reject、失败与取消各自映射到 stopReason，且调用方必须在每条路径上 `dispose()`（[packages/workflow/workflow/README.md:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/README.md#L53)）
- 记载失败纪律：钩子误用致命终止脚本，普通子代失败让 `agent()` 解析为 `null` 交脚本处置（[packages/workflow/workflow/README.md:55-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/README.md#L55-L57)）
- 记载一个上下文同时只能有一个引擎、加载第二个会失败，且 `workflow/*` 事件只带运行身份快照、监听者拿不到取消或释放权（[packages/workflow/workflow/README.md:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/README.md#L69-L71)）
- 记载事件配对关系与监听者独立容错、各自收到载荷克隆（[packages/workflow/workflow/README.md:84-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/README.md#L84-L86)）

### packages/workflow/workflow/package.json

npm 清单，声明该能力接缝包的入口、导出、发布文件集与 peer 依赖。

- `main`/`types`/`exports` 把 `.`、`./invariant`、`./types`、`./src/*` 映射到具体产物文件（[packages/workflow/workflow/package.json:14-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/package.json#L14-L31)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 js/d.ts（[packages/workflow/workflow/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/package.json#L32-L37)）

### packages/workflow/workflow/src/index.ts

工作流能力的 Service Definition：`ctx.workflowEngine` 抽象类、`workflow/*` 事件声明、`WorkflowError` 与致命判定。

- 声明合并把 `workflowEngine` 挂到 Cordis `Context` 上（[packages/workflow/workflow/src/index.ts:31-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/index.ts#L31-L34)）
- 声明六个 `workflow/*` 事件及其载荷与配对关系，使外部可观察运行开始、阶段、日志、子代起止与运行结束（[packages/workflow/workflow/src/index.ts:36-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/index.ts#L36-L90)）
- `workflow/end` 载荷刻意不含结果值，只带终止原因、错误与子代计数（[packages/workflow/workflow/src/index.ts:80-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/index.ts#L80-L89)）
- `WorkflowErrorCode` 枚举十一种可路由的致命失败码（[packages/workflow/workflow/src/index.ts:108-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/index.ts#L108-L119)）
- `WorkflowError` 带 `fatal` 标志（默认 true），决定组合子是重抛还是把项置 `null`（[packages/workflow/workflow/src/index.ts:130-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/index.ts#L130-L139)）
- `isFatalWorkflowError` 以宿主 `instanceof` 判定致命性，脚本领域无法伪造（[packages/workflow/workflow/src/index.ts:146-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/index.ts#L146-L148)）
- `WorkflowEngine` 以 `workflowEngine` 名注册为 Cordis 服务，并把 `start(request)` 定为抽象契约（[packages/workflow/workflow/src/index.ts:157-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/index.ts#L157-L168)）
- `emitWorkflowEvent` 逐个调用监听者并分别捕获同步抛出与异步 reject，只记 warn，不中断其他监听者也不改变执行（[packages/workflow/workflow/src/index.ts:175-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/index.ts#L175-L186)）
- `renderListenerError` 在 `String(error)` 自身抛出时退回固定文本，保证容错不被破坏（[packages/workflow/workflow/src/index.ts:194-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/index.ts#L194-L201)）

### packages/workflow/workflow/src/invariant.ts

该包的不变式伴生插件，在 `workflow/*` 事件流上做运行配对与身份一致性校验。

- `traceFor` 要求每个事件都能找到匹配的 `workflow/start`，且其 meta 与开始时序列化一致（[packages/workflow/workflow/src/invariant.ts:26-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/invariant.ts#L26-L37)）
- `validateAgentEnd` 要求 end 与 start 的 label、phase、childId 完全一致，且 outcome 为三值之一（[packages/workflow/workflow/src/invariant.ts:40-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/invariant.ts#L40-L48)）
- `validateWorkflowEnd` 拒绝仍有未结束子代调用的收尾，要求 `agentsStarted` 覆盖已观察到的起始数，且 error 恰在非 completed 时存在（[packages/workflow/workflow/src/invariant.ts:51-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/invariant.ts#L51-L59)）
- 在 `internal/dispatch` 上校验 `workflow/start` 的 id、meta.name、meta.description 非空并拒绝重复 run id（[packages/workflow/workflow/src/invariant.ts:69-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/invariant.ts#L69-L78)）
- 在 `internal/dispatch` 上校验 `workflow/agent-start` 的 seq 为正、childId 非空并拒绝重复 seq（[packages/workflow/workflow/src/invariant.ts:82-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/invariant.ts#L82-L90)）
- 在 `internal/dispatch` 上要求 `workflow/agent-end` 有匹配的 start 并做身份校验（[packages/workflow/workflow/src/invariant.ts:91-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/invariant.ts#L91-L98)）
- 校验通过的载荷被暂存进 WeakSet，只有在对应事件真正发布时才提交到轨迹表（start 建轨迹、agent-start 计数、agent-end 消除配对、end 删除轨迹）（[packages/workflow/workflow/src/invariant.ts:106-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/invariant.ts#L106-L127)）

### packages/workflow/workflow/src/runtime-types.ts

宿主侧的启动请求与活运行句柄类型，被引擎与消费者共用。

- `WorkflowStartRequest` 规定 script、meta、可选 args、可选 `subagentProvider` 与 `maxTotalAgents`、必填 parent 与可选 signal 这组入参（[packages/workflow/workflow/src/runtime-types.ts:19-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/runtime-types.ts#L19-L34)）
- `WorkflowRun` 规定活运行对外暴露 id、meta、永不 reject 的 result、`cancel()` 与幂等 `dispose()`（[packages/workflow/workflow/src/runtime-types.ts:40-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/runtime-types.ts#L40-L49)）

### packages/workflow/workflow/src/types.ts

浏览器安全的工作流词汇：run id 品牌、meta、结果与各事件载荷类型。

- `WorkflowRunId` 品牌化函数在运行期原样返回入参字符串（[packages/workflow/workflow/src/types.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/types.ts#L20-L22)）
- `WorkflowStopReason` 定为 `completed`/`cancelled`/`error` 的封闭三值，供消费者穷举（[packages/workflow/workflow/src/types.ts:57-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/types.ts#L57-L63)）
- `WorkflowResult.agentsStarted` 规定优雅结算时用脚本侧计数、终止路径退化为宿主观察计数（[packages/workflow/workflow/src/types.ts:79-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/types.ts#L79-L86)）
- `WorkflowResultInfo` 规定 `workflow/end` 载荷是去掉 `value` 的结果，使监听者拿不到调用方结果值的可变别名（[packages/workflow/workflow/src/types.ts:118-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow/src/types.ts#L118-L131)）

### packages/workflow/workflow/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、输出目录与工作区项目引用。

- 无运行期机制
