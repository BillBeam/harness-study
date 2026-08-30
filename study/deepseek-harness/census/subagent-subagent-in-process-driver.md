---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/subagent-in-process-driver
---

# packages/subagent/subagent-in-process-driver

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、32 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/subagent-in-process-driver/README.md

包 README，用带 front matter 的说明文档描述该共享驱动的启动契约、取消与释放、结构化输出运行时。

- 无运行期机制

### packages/subagent/subagent-in-process-driver/package.json

包清单，声明入口、发布文件集合与依赖关系。

- `main`/`types` 与 `exports` 决定 `.`、`./invariant`、`./src/*`、`./package.json` 四个子路径各自解析到哪个文件（[packages/subagent/subagent-in-process-driver/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/package.json#L14-L27)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/subagent/subagent-in-process-driver/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/package.json#L28-L32)）
- `peerDependencies` 要求宿主提供 agent、session、subagent、system-prompt 与 tools，结构化输出运行时在运行期依赖这些实现（[packages/subagent/subagent-in-process-driver/package.json:34-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/package.json#L34-L43)）

### packages/subagent/subagent-in-process-driver/src/index.ts

共享的进程内一次性子代运行驱动：创建子 agent、驱动一个回合、读取结果并释放，被 spawn 与 fork 两个后端调用。

- `toStopReason` 把子会话回合终局映射为共享停止原因：completed 与 max-tokens 直通、aborted 保持、blocked 变 refusal、error/interrupted 与其余情形一律变 error（[packages/subagent/subagent-in-process-driver/src/index.ts:48-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L48-L65)）
- `prePublicationAbort` 固定发布前中止的错误文本（[packages/subagent/subagent-in-process-driver/src/index.ts:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L74-L76)）
- `attachDescriptorAppend` 在子上下文挂 `agent/pre-step` 瀑布监听，先 `next()` 再在首次进入决策时向子会话追加一条 `subagent/descriptor` 事件，且只追加一次（[packages/subagent/subagent-in-process-driver/src/index.ts:79-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L79-L89)）
- `startInProcessRun` 先断言 `maxDepth` 合法、再检查已中止信号、再由父深度推出子深度（[packages/subagent/subagent-in-process-driver/src/index.ts:106-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L106-L109)）
- 铸随机子会话 id，并把种子长度记为激活边界，供结果读取时跳过被播种的父消息（[packages/subagent/subagent-in-process-driver/src/index.ts:111-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L111-L113)）
- 在第一个 await 之前捕获父的委派策略覆盖（沙箱与审批），之后父端的切换不影响本次子代（[packages/subagent/subagent-in-process-driver/src/index.ts:117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L117)）
- 创建事务的未发布窗口内依次：把捕获的策略覆盖写进子会话、按请求安装人格与工具过滤、按 `outputSchema` 安装结构化输出运行时、挂上描述符追加（[packages/subagent/subagent-in-process-driver/src/index.ts:119-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L119-L130)）
- 通过宿主 agent 工厂创建子代，传入子会话 id、含深度与激活边界的元数据、可选种子、解析后的 agent 选项与请求信号（[packages/subagent/subagent-in-process-driver/src/index.ts:132-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L132-L139)）
- 创建成功后交给 `drivePublishedRun` 驱动，把句柄、信号、任务内容、子 id、边界与结构化附件一并传入（[packages/subagent/subagent-in-process-driver/src/index.ts:140-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L140-L147)）
- 已发布运行绑定 abort 监听：置取消标志并对子 agent 发出 `{ kind: 'parent' }` 取消；随后再检查一次信号以闭合创建与发布之间的交接竞态（[packages/subagent/subagent-in-process-driver/src/index.ts:163-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L163-L172)）
- 未取消时把任务内容作为一条用户消息 `followup` 进子会话并等待其空闲，然后读取结果，无论成败都摘掉 abort 监听（[packages/subagent/subagent-in-process-driver/src/index.ts:174-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L174-L189)）
- 返回的运行暴露子 id、活的子 agent 与结果 promise；`dispose()` 摘监听、置取消标志、并行等待句柄释放与结果结算，只在句柄释放失败时抛出（[packages/subagent/subagent-in-process-driver/src/index.ts:191-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L191-L204)）
- `readResult` 只在激活边界之后的事件里折叠已消费工作与最终助手输出，被播种的父消息不会成为结果（[packages/subagent/subagent-in-process-driver/src/index.ts:208-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L208-L221)）
- 取消标志在记录的停止原因不是 `completed` 时把结果改判为 `aborted`（[packages/subagent/subagent-in-process-driver/src/index.ts:225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L225)）
- 结构化运行：已捕获值随结果返回；未捕获却是 `completed` 时改判为 `aborted` 或 `error`，驱动不做重问（[packages/subagent/subagent-in-process-driver/src/index.ts:226-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/index.ts#L226-L232)）

### packages/subagent/subagent-in-process-driver/src/invariant.ts

本包的不变量伴生插件，被包级不变量注册表加载。

- 以包名在 `ctx.invariants` 上登记本包并安装一个空检查器，返回该注册的 disposer（[packages/subagent/subagent-in-process-driver/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/invariant.ts#L21-L29)）

### packages/subagent/subagent-in-process-driver/src/structured.ts

结构化输出运行时：在子 agent 自己的作用域上装捕获工具、提示段、终局守卫与结果提交，被 `src/index.ts` 在创建窗口内调用。

- 固定模型可见的捕获工具名 `structured_output`（[packages/subagent/subagent-in-process-driver/src/structured.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L20)）
- 固定注入子代提示的指令文本：必须以调用该工具的方式给出最终答案，纯文本收尾不算结果（[packages/subagent/subagent-in-process-driver/src/structured.ts:27-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L27-L30)）
- 用以执行对象为键的 WeakMap 暂存待提交值，另设 PTC 模式下等待外层提交的 `pending` 与最终 `captured`（[packages/subagent/subagent-in-process-driver/src/structured.ts:60-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L60-L63)）
- 工具的模型可见描述固定为"只调用一次、参数必须完全匹配参数模式"，参数模式直接采用请求的 schema（[packages/subagent/subagent-in-process-driver/src/structured.ts:65-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L65-L73)）
- 在子上下文注册该工具，输出模式固定为 `{ recorded: true }`，渲染文本固定为 `Structured output recorded.`（[packages/subagent/subagent-in-process-driver/src/structured.ts:75-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L75-L85)）
- 工具体先按 schema 校验参数，不合规抛 `ToolArgsError` 让模型在同一回合内重试；合规则把值按本次执行暂存、调用 `concludeTurn()` 并返回 `{ recorded: true }`（[packages/subagent/subagent-in-process-driver/src/structured.ts:86-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L86-L97)）
- 以第一方结构化输出段序在子作用域注册提示段，把上述指令写进子代的系统提示（[packages/subagent/subagent-in-process-driver/src/structured.ts:100-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L100-L104)）
- 注册工具守卫：一旦已捕获或已挂起，之后任何工具调用都被拒绝执行并返回固定的"结构化输出已记录"错误文本（[packages/subagent/subagent-in-process-driver/src/structured.ts:110-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L110-L112)）
- `tools/result` 观察者只在权威结果非错误时提交：无父执行直接落 `captured`，有父执行先落 `pending`，并在本次通知里删除对应暂存（[packages/subagent/subagent-in-process-driver/src/structured.ts:117-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L117-L132)）
- 外层执行的结果到达时，若它正是挂起项的父执行且未出错，则把挂起值提交为 `captured`（[packages/subagent/subagent-in-process-driver/src/structured.ts:134-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L134-L140)）
- 返回只读的 `captured()` 访问器，供驱动在子代结算后读取（[packages/subagent/subagent-in-process-driver/src/structured.ts:142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-in-process-driver/src/structured.ts#L142)）

### packages/subagent/subagent-in-process-driver/tsconfig.json

包级 TypeScript 编译配置，声明源码根目录、类型输出目录与工作区引用。

- 无运行期机制
