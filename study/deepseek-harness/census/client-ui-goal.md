---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-goal
---

# packages/client/ui-goal

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、43 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-goal/README.md

该包的说明文档，描述目标条在编辑器上方的呈现、四个变更动词以及命令输入气泡的来源。

- 无运行期机制

### packages/client/ui-goal/package.json

该包的清单，声明入口映射、浏览器半的加载声明与发布内容。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-goal/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./client` 三个子路径分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，并额外开放 `./src/*` 与 `./package.json`（[packages/client/ui-goal/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/package.json#L16-L31)）
- `dsh.client` 声明浏览器半所需注入的七个包并把 platform 定为 `web`，装载方据此发现并加载 `./client`（[packages/client/ui-goal/package.json:32-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/package.json#L32-L45)）
- `files` 把发布内容限定为三个 js 入口与 `lib/types` 下的声明文件（[packages/client/ui-goal/package.json:88-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/package.json#L88-L93)）

### packages/client/ui-goal/src/client/GoalBar.module.css

GoalBar 的 CSS Module，定义停靠列宽、条内排布、内联编辑输入框与图标按钮的外观。

- 无运行期机制

### packages/client/ui-goal/src/client/GoalBar.tsx

目标条组件及其停靠适配器，从 `goal` 投影读取当前目标并把编辑、暂停、恢复、清除四个动作发出去。

- `PHASE_LABELS` 只为 active、paused、blocked 三个阶段给出标签键，complete 不在表内（[packages/client/ui-goal/src/client/GoalBar.tsx:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L28-L32)）
- 目标 id 变化时重置编辑态、错误文案与已清除记号（[packages/client/ui-goal/src/client/GoalBar.tsx:44-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L44-L49)）
- `runAction` 用 ref 在同一帧内挡掉重复提交，并在失败时把 `message (code)` 写入内联错误（[packages/client/ui-goal/src/client/GoalBar.tsx:53-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L53-L63)）
- 编辑提交前先 trim，空串直接放弃；成功后退出编辑态（[packages/client/ui-goal/src/client/GoalBar.tsx:65-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L65-L70)）
- 清除成功后记下被清除的目标 id（[packages/client/ui-goal/src/client/GoalBar.tsx:72-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L72-L75)）
- 目标为 undefined、null、complete 阶段或 id 等于已清除记号时整条不渲染（[packages/client/ui-goal/src/client/GoalBar.tsx:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L78)）
- 编辑态输入框上 Enter 提交、Escape 退出（[packages/client/ui-goal/src/client/GoalBar.tsx:90-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L90-L93)）
- 保存按钮在有未决动作或草稿 trim 后为空时禁用（[packages/client/ui-goal/src/client/GoalBar.tsx:103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L103)）
- blocked 阶段把 `blockedReason.message` 挂成条的 title（[packages/client/ui-goal/src/client/GoalBar.tsx:126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L126)）
- active 阶段渲染暂停按钮、paused 阶段渲染恢复按钮，各自把点击接到对应动词（[packages/client/ui-goal/src/client/GoalBar.tsx:135-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L135-L148)）
- 编辑按钮把当前 objective 灌进草稿并切入编辑态（[packages/client/ui-goal/src/client/GoalBar.tsx:154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L154)）
- 清除按钮把当前目标 id 一并传给 `handleClear`（[packages/client/ui-goal/src/client/GoalBar.tsx:161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L161)）
- `GoalDock` 调 `useProjection('goal')`，把 undefined 与 null 原样下传，其余取投影里的 `goal` 字段（[packages/client/ui-goal/src/client/GoalBar.tsx:175-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalBar.tsx#L175-L186)）

### packages/client/ui-goal/src/client/GoalCommandInputView.module.css

命令输入气泡的 CSS Module，定义右对齐堆叠、气泡宽度上限与字号跟随。

- 无运行期机制

### packages/client/ui-goal/src/client/GoalCommandInputView.tsx

渲染 `command-input` 聊天节点的组件，把节点数据里的命令文本铺成一个右对齐气泡。

- 从 `node.data` 取 `text` 交给 `MessageText` 渲染，外层带 `data-command-input` 与 group 语义（[packages/client/ui-goal/src/client/GoalCommandInputView.tsx:15-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/GoalCommandInputView.tsx#L15-L27)）

### packages/client/ui-goal/src/client/goal-command-input.ts

把 `/goal` 命令运行事件投影成聊天节点的 Conversation Definition，以及它用到的命令文本还原函数。

- `goalCommandText` 由事件的 `name` 与 `args` 拼出 `/name args`，并把 args 的尾部空白去掉（[packages/client/ui-goal/src/client/goal-command-input.ts:31-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/goal-command-input.ts#L31-L33)）
- `match` 只接受 `command/run` 且名字为 `goal` 的事件，以 `commandId` 为节点 id、角色为 `start`（[packages/client/ui-goal/src/client/goal-command-input.ts:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/goal-command-input.ts#L39-L41)）
- `start` 在事件类型不是 `command/run` 时抛错，否则记下 commandId、seq、time 与还原出的命令文本（[packages/client/ui-goal/src/client/goal-command-input.ts:42-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/goal-command-input.ts#L42-L52)）
- `update` 原样返回既有状态，后续事件不改动该节点（[packages/client/ui-goal/src/client/goal-command-input.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/goal-command-input.ts#L53)）
- `buildViewNode` 在无状态时返回 null，否则产出 kind 为 `command-input` 的可见节点，并把 `anchorSeq` 定为 `seq - 0.1` 使其排在同一命令的结果行之前（[packages/client/ui-goal/src/client/goal-command-input.ts:54-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/goal-command-input.ts#L54-L70)）

### packages/client/ui-goal/src/client/index.ts

该包浏览器半的插件体，注册命令输入投影、词典、聊天节点视图与目标条停靠项，并接出四个变更动词。

- `inject` 声明插件启动所需的 slots、sessions、remote、remote.goals、locale、uiConversation（[packages/client/ui-goal/src/client/index.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/index.ts#L50)）
- 向 `uiConversation.events` 注册 `/goal` 命令输入的节点 Definition（[packages/client/ui-goal/src/client/index.ts:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/index.ts#L57)）
- 以 effect 注册 `goal` 命名空间的中英词典（[packages/client/ui-goal/src/client/index.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/index.ts#L58)）
- 把 `GoalCommandInputView` 注册到 `conversation.chat.node` 槽的 `command-input` 键上（[packages/client/ui-goal/src/client/index.ts:60-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/index.ts#L60-L64)）
- `refOf` 在动词调用当刻从会话的 `goal` 投影面取快照，取出 `id` 与 `revision` 作为比较置换用的 ref；投影缺失时返回 undefined（[packages/client/ui-goal/src/client/index.ts:69-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/index.ts#L69-L74)）
- 预置 `no-current-goal` 失败结果，在没有可变更目标时直接返回给条（[packages/client/ui-goal/src/client/index.ts:76-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/index.ts#L76-L79)）
- 把 `GoalDock` 注册进 `conversation.input.dock` 槽，id 为 `goal`、order 为 10（[packages/client/ui-goal/src/client/index.ts:81-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/index.ts#L81-L85)）
- 四个动词各自先取 ref，缺失则返回预置失败，否则分别调用 `ctx.remote.goals` 的 edit、pause、resume、clear（[packages/client/ui-goal/src/client/index.ts:86-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/client/index.ts#L86-L107)）

### packages/client/ui-goal/src/client/locales.ts

`goal` 命名空间的中英词典与由中文键集导出的键联合类型。

- 无运行期机制

### packages/client/ui-goal/src/client/slots.ts

目标条注入面的类型声明：一次变更的结果类型与四个动词的接口。

- 无运行期机制

### packages/client/ui-goal/src/css-modules.d.ts

CSS Module 的环境类型声明。

- 无运行期机制

### packages/client/ui-goal/src/index.ts

该包 host 半的插件体。

- 导出空的 `apply`，使该插件能出现在 host 侧的装载清单中而不注册任何 host 行为（[packages/client/ui-goal/src/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/index.ts#L9)）

### packages/client/ui-goal/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名。

- 导出 `name` 与 `inject`，声明伴生插件名及其依赖的 invariants 服务（[packages/client/ui-goal/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/invariant.ts#L13-L15)）
- `install` 为空安装器，不挂任何运行期检查（[packages/client/ui-goal/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/invariant.ts#L23)）
- `apply` 向 `ctx.invariants` 注册包名与空安装器，并把注册返回的 disposer 以 Promise 交回（[packages/client/ui-goal/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/src/invariant.ts#L30-L31)）

### packages/client/ui-goal/tsconfig.json

该包的 TypeScript 编译配置与工作区引用清单。

- 无运行期机制

### packages/client/ui-goal/tsdown.config.ts

该包的打包配置。

- 以 `clientBundle` 声明打包入口为 `lib/types/index.js` 与 `lib/types/invariant.js`，决定产出哪些可加载的运行期文件（[packages/client/ui-goal/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-goal/tsdown.config.ts#L3)）
