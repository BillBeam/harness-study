---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/tool-subagent-control
---

# packages/subagent/tool-subagent-control

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、28 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/tool-subagent-control/README.md

该包的说明文档，描述 `send_message`、`interrupt_agent`、`list_agents` 三个控制工具的行为与限制。

- 无运行期机制

### packages/subagent/tool-subagent-control/package.json

该包的 npm 清单，声明入口、可独立加载的子路径与发布文件集。

- `main`/`types` 把默认加载入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/subagent/tool-subagent-control/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/package.json#L14-L15)）
- `exports` 把 `./list-agents` 暴露为可单独加载的插件子路径，运行入口指向 `./lib/types/list-agents.js`（[packages/subagent/tool-subagent-control/package.json:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/package.json#L25-L28)）
- `files` 把发布产物限定为两个 `lib/*.js` 入口以及 `lib/types` 下的 `.js` 与 `.d.ts`（[packages/subagent/tool-subagent-control/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/package.json#L32-L37)）

### packages/subagent/tool-subagent-control/src/index.ts

全局 `send_message` 与 `interrupt_agent` 两个工具的注册入口，直接转调 `ctx.subagents` 的续接与中断方法。

- 声明 `inject = ['tools', 'subagents']`，使注册只在两个服务齐备后发生（[packages/subagent/tool-subagent-control/src/index.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L19)）
- `send_message` 的描述声明消息成为子代理的下一轮、当前轮进行中时排队等待、本调用不返回子代理答复、失败即未送达（[packages/subagent/tool-subagent-control/src/index.ts:28-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L28-L33)）
- `send_message` 声明必填参数 `subagent_id` 与 `message`（[packages/subagent/tool-subagent-control/src/index.ts:34-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L34-L45)）
- `send_message` 的输出只含 `messageId`，渲染成一行"已排队为下一轮"的确认文本（[packages/subagent/tool-subagent-control/src/index.ts:46-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L46-L58)）
- `send_message` 执行时缺少调用方 Agent 直接抛错（[packages/subagent/tool-subagent-control/src/index.ts:59-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L59-L64)）
- `send_message` 把文本包成内容块交给 `subagents.followup`，附带 `coordinator`/`relay` 来源与发送方会话 id，并透传执行信号（[packages/subagent/tool-subagent-control/src/index.ts:65-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L65-L75)）
- `interrupt_agent` 的描述声明只停当前一轮、已排队消息保留、其派生代理继续运行、接受后即返回、对已结束目标是可接受的空操作（[packages/subagent/tool-subagent-control/src/index.ts:81-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L81-L87)）
- `interrupt_agent` 声明必填参数 `agent_id`，输出只含 `accepted` 并渲染成一行请求确认（[packages/subagent/tool-subagent-control/src/index.ts:88-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L88-L107)）
- `interrupt_agent` 执行时缺少调用方 Agent 直接抛错（[packages/subagent/tool-subagent-control/src/index.ts:108-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L108-L113)）
- `interrupt_agent` 把精确的活调用方作为 `ancestor` 权限传给 `subagents.interrupt`，工具自身不追加任何授权（[packages/subagent/tool-subagent-control/src/index.ts:114-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/index.ts#L114-L117)）

### packages/subagent/tool-subagent-control/src/list-agents.ts

可单独加载的 `list_agents` 工具，把 `ctx.subagents` 的子代理与后代目录投影成模型可读的列表。

- 声明 `inject = ['tools', 'subagents', 'agents']`，多要求一个活 Agent 注册表用于状态细化（[packages/subagent/tool-subagent-control/src/list-agents.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L18)）
- `resolveListAgentsRequest` 把省略的 `scope` 解析成 `children`（[packages/subagent/tool-subagent-control/src/list-agents.ts:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L48-L50)）
- `statusOf` 用活 Agent 注册表把候选映射为 `running`/`idle`/`ready` 三态（[packages/subagent/tool-subagent-control/src/list-agents.ts:59-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L59-L63)）
- `project` 原样保留诊断行、丢弃非 `continuable` 的一次性子代理、并在后代作用域下附上父 id 与深度（[packages/subagent/tool-subagent-control/src/list-agents.ts:66-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L66-L85)）
- 工具描述声明该列表用于回忆而非轮询、三态含义、快照不等于送达承诺、只有深度 1 的条目可用 `send_message`（[packages/subagent/tool-subagent-control/src/list-agents.ts:94-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L94-L105)）
- 声明可选参数 `scope`，取值限定为 `children` 与 `descendants`（[packages/subagent/tool-subagent-control/src/list-agents.ts:106-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L106-L112)）
- 输出模式把每行限定为 `child` 或 `diagnostic` 两种对象，并禁止额外字段（[packages/subagent/tool-subagent-control/src/list-agents.ts:113-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L113-L143)）
- 渲染把空列表写成 `(no subagents)`，把每行写成 id、状态或诊断原因、可选的 `parent=`/`depth=` 与标签（[packages/subagent/tool-subagent-control/src/list-agents.ts:144-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L144-L162)）
- 执行时缺少调用方 Agent 直接抛错（[packages/subagent/tool-subagent-control/src/list-agents.ts:164-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L164-L169)）
- `children` 分支以调用方 id 调 `listChildren` 并透传执行信号，再逐行投影并过滤（[packages/subagent/tool-subagent-control/src/list-agents.ts:174-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L174-L179)）
- `descendants` 分支调 `listDescendants` 并把每行自身的父 id 与深度带入投影（[packages/subagent/tool-subagent-control/src/list-agents.ts:180-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L180-L185)）
- 闭合联合的默认分支走 `assertNever`（[packages/subagent/tool-subagent-control/src/list-agents.ts:186-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/list-agents.ts#L186-L188)）

### packages/subagent/tool-subagent-control/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包归属。

- 以空安装器向 `ctx.invariants` 注册包名并返回其 disposer，即运行期不安装任何检查（[packages/subagent/tool-subagent-control/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent-control/src/invariant.ts#L21-L29)）

### packages/subagent/tool-subagent-control/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
