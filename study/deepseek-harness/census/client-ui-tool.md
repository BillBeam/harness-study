---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-tool
---

# packages/client/ui-tool

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 38 个文件、152 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-tool/README.md

该包的说明文档，介绍工具调用树的渲染、按工具名分发的视图插槽以及内置卡片。

- 无运行期机制

### packages/client/ui-tool/package.json

该包的清单，声明入口、客户端装载信息与发布产物。

- `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-tool/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./client` 三个入口，并把 `./src/*` 与 `./package.json` 原样透出（[packages/client/ui-tool/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/package.json#L16-L31)）
- `dsh.client.inject` 列出客户端装载时必须注入的四个包，`platform` 限定为 `web`（[packages/client/ui-tool/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/package.json#L32-L42)）
- `files` 把发布内容限定为三个 bundle 与类型声明（[packages/client/ui-tool/package.json:84-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/package.json#L84-L89)）

### packages/client/ui-tool/src/client/apply.ts

浏览器端插件入口，注册工具调用树、详情渲染器与七个内置原子工具视图。

- 声明注入 `slots` 与 `connection` 两个服务（[packages/client/ui-tool/src/client/apply.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/apply.ts#L19)）
- 取出 connection 并构造 `toolInject`，把 `connection.generation` 作为 hooks 交给插槽注册（[packages/client/ui-tool/src/client/apply.ts:26-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/apply.ts#L26-L27)）
- 把 `ToolCallTree` 注册到 `conversation.chat.node` 的 `tool-call` 键，并声明子插槽 `tool.call.toolview` 为 keyed/session（[packages/client/ui-tool/src/client/apply.ts:28-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/apply.ts#L28-L36)）
- 把 `ToolDetails` 注册到 `conversation.details.tool`（[packages/client/ui-tool/src/client/apply.ts:38-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/apply.ts#L38-L42)）
- 依次挂载 bash、read、文件改写、search、web、todo、提问七个视图插件（[packages/client/ui-tool/src/client/apply.ts:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/apply.ts#L44-L50)）

### packages/client/ui-tool/src/client/contract/slots.ts

声明 `tool.call.toolview` 插槽及各渲染器的 props 类型，供本包与业务包共同引用。

- 无运行期机制

### packages/client/ui-tool/src/client/index.ts

客户端入口，重导出 `apply`/`inject` 与插槽相关类型。

- 无运行期机制

### packages/client/ui-tool/src/client/locale.ts

导出本包所有插槽注册使用的文案命名空间常量。

- 常量 `CONVERSATION_NS` 固定为 `'conversation'`，决定各注册项绑定的词典命名空间（[packages/client/ui-tool/src/client/locale.ts:2](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/locale.ts#L2)）

### packages/client/ui-tool/src/client/tool/ToolCallTree.module.css

调用行与子调用容器的样式表。

- 无运行期机制

### packages/client/ui-tool/src/client/tool/ToolCallTree.tsx

工具调用树渲染器，注册为 `tool-call` 会话节点，把根调用与递归子调用送进同一条按工具名分发的路径。

- `callName` 从运行中与已结算两种形态里取出 wire 工具名，取不到时为空串（[packages/client/ui-tool/src/client/tool/ToolCallTree.tsx:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolCallTree.tsx#L9-L11)）
- `useMemo` 组装 owner 载荷，并把 `inspect` 绑定为对该 callId 的 `inspectCall` 调用（[packages/client/ui-tool/src/client/tool/ToolCallTree.tsx:24-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolCallTree.tsx#L24-L32)）
- 每个调用外层 div 输出 `data-chat-anchor-key="call:<id>"`、`data-chat-call-id` 与 `data-selected`（[packages/client/ui-tool/src/client/tool/ToolCallTree.tsx:34-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolCallTree.tsx#L34-L39)）
- 以工具名为 `entryKey` 通过 `renderSlot` 分发 `tool.call.toolview`，未命中时回落到 `GenericToolCard`（[packages/client/ui-tool/src/client/tool/ToolCallTree.tsx:40-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolCallTree.tsx#L40-L43)）
- `subCalls` 非空时递归渲染每个子调用，以 callId 作 key（[packages/client/ui-tool/src/client/tool/ToolCallTree.tsx:68-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolCallTree.tsx#L68-L84)）
- 顶层从连接世代读取 `host.home`，从 `node.data.root` 取根调用块（[packages/client/ui-tool/src/client/tool/ToolCallTree.tsx:98-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolCallTree.tsx#L98-L99)）

### packages/client/ui-tool/src/client/tool/ToolDetails.module.css

详情面板中描述行、卡片、恢复行与代码块的样式表。

- 无运行期机制

### packages/client/ui-tool/src/client/tool/ToolDetails.tsx

详情面板里被选中调用的输出渲染器，注册在 `conversation.details.tool`。

- 从连接世代读取 `host.home` 供路径显示（[packages/client/ui-tool/src/client/tool/ToolDetails.tsx:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolDetails.tsx#L26)）
- 终端卡最优先：本地化后渲染描述行与 `TerminalBlock`（[packages/client/ui-tool/src/client/tool/ToolDetails.tsx:27-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolDetails.tsx#L27-L38)）
- 其次尝试读取卡，命中则渲染 `ReadBlock`（[packages/client/ui-tool/src/client/tool/ToolDetails.tsx:39-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolDetails.tsx#L39-L40)）
- 其次尝试 diff 卡，命中则渲染 `DiffBlock`（[packages/client/ui-tool/src/client/tool/ToolDetails.tsx:41-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolDetails.tsx#L41-L42)）
- 其次尝试搜索卡，命中时在卡片下方额外渲染 recovery 文本（[packages/client/ui-tool/src/client/tool/ToolDetails.tsx:43-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolDetails.tsx#L43-L51)）
- 其次尝试 web 卡，命中时在卡片下方附上扁平化结果文本（非空才渲染）（[packages/client/ui-tool/src/client/tool/ToolDetails.tsx:52-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolDetails.tsx#L52-L61)）
- 未结算的调用显示 `details.running` 文案（[packages/client/ui-tool/src/client/tool/ToolDetails.tsx:62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolDetails.tsx#L62)）
- 兜底以 `pre` 输出扁平化结果文本，并按 `isError` 打 `data-error`（[packages/client/ui-tool/src/client/tool/ToolDetails.tsx:63-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/ToolDetails.tsx#L63-L67)）

### packages/client/ui-tool/src/client/tool/components/AskQuestionCard.module.css

提问卡片的样式表。

- 无运行期机制

### packages/client/ui-tool/src/client/tool/components/AskQuestionCard.tsx

提问工具的问答记录卡片，由 `ToolRow` 在展开体中渲染。

- `unanswered` 形态渲染裁决文本与问题列表（[packages/client/ui-tool/src/client/tool/components/AskQuestionCard.tsx:12-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/AskQuestionCard.tsx#L12-L23)）
- `answered` 形态逐问渲染答案行，答案为空时改显 `skippedLabel`（[packages/client/ui-tool/src/client/tool/components/AskQuestionCard.tsx:24-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/AskQuestionCard.tsx#L24-L39)）

### packages/client/ui-tool/src/client/tool/components/ToolRow.module.css

工具行的样式表，含运行态扫光动画与展开体各卡片的容器样式。

- 无运行期机制

### packages/client/ui-tool/src/client/tool/components/ToolRow.tsx

所有工具行共用的展示组件，负责折叠摘要、展开体卡片选择与路径/巡查交互。

- `leadingFor` 按状态把前导图标替换为 error/warning 状态点（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:67-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L67-L73)）
- `stateStatus` 为 running/error/stopped 产出视觉隐藏的状态文本，其余状态返回 null（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:79-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L79-L86)）
- 组件内 `expanded` 状态控制展开（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L110)）
- 卡片按 askQuestion、terminal、diff、read、search、web 的固定优先级取第一个非空（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L125)）
- 只有存在 body、output 或卡片时行才可展开（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:126-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L126-L127)）
- error 状态用 `errorSummary` 取代摘要，同时丢弃 `summarySuffix`（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:130-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L130-L132)）
- 只有同时具备 filePath、onOpenFile 且不是失败行时，摘要才渲染成可点链接（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L133)）
- 点击路径链接时阻止冒泡并调用 `onOpenFile`（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:137-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L137-L140)）
- 链接上的 Enter/Space 阻止冒泡，避免被行的展开处理吞掉（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:145-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L145-L147)）
- `code` 变体的 body 不进入 IN/OUT 卡（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L150)）
- 根元素输出 `data-variant`、`data-tool`、`data-state` 三个属性（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L152)）
- 以 `DisclosureRow` 装配行，开启整行点击展开与打开时保留内容（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:154-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L154-L165)）
- 摘要为空串时连分隔点一并不渲染（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:166-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L166-L189)）
- 展开体按卡片种类分支渲染，终端卡不限行数、diff/read/search 各自套用本包的行数上限（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:192-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L192-L224)）
- 无卡片时，`code` 变体用 `CodeBlock` 渲染程序，其余把输入与输出装进 IN/OUT 卡并按状态给输出打 `data-error`（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:226-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L226-L253)）
- 提供 `inspect` 时在展开体底部渲染跳转按钮（[packages/client/ui-tool/src/client/tool/components/ToolRow.tsx:255-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/components/ToolRow.tsx#L255-L264)）

### packages/client/ui-tool/src/client/tool/models/ask-question-card-model.ts

提问卡片的数据类型定义，被卡片组件与提问行共用。

- 无运行期机制

### packages/client/ui-tool/src/client/tool/models/diff-card-model.ts

从原始文件改写调用参数与结算元数据派生 diff 卡数据。

- `CHAT_DIFF_MAX_LINES` 固定为 8，作为聊天行 diff 体的折叠行数（[packages/client/ui-tool/src/client/tool/models/diff-card-model.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/diff-card-model.ts#L15)）
- `narrowDiffs` 逐项校验元数据里的 hunk（path 必须是串、oldText 允许 null、newText 必须是串），任一不合即整体作废（[packages/client/ui-tool/src/client/tool/models/diff-card-model.ts:36-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/diff-card-model.ts#L36-L48)）
- `intendedDiff` 按工具名派生意图 diff：`str_replace_editor` 只接受 `create`/`str_replace` 两个命令，`write` 取 content，`edit` 取 old_string/new_string 并校验 replace_all，且要求提权字段成对合法（[packages/client/ui-tool/src/client/tool/models/diff-card-model.ts:52-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/diff-card-model.ts#L52-L89)）
- `appliedDiffs` 从结果元数据取 `diffs`，空数组返回 `'empty'` 标记（[packages/client/ui-tool/src/client/tool/models/diff-card-model.ts:91-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/diff-card-model.ts#L91-L97)）
- `diffCardModel` 拒绝带 `parentCallId` 的子调用；运行中直接用意图 diff；已结算时 `str_replace_editor` 与出错调用返回 null；元数据无效或为空时 write 回落到参数 diff、edit 返回 null（[packages/client/ui-tool/src/client/tool/models/diff-card-model.ts:108-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/diff-card-model.ts#L108-L120)）

### packages/client/ui-tool/src/client/tool/models/primitive-labels.ts

把会话词典映射成各无 Cordis 依赖的展示原语所需的文案字段。

- `markdownLabels` 组装复制/已复制与脚注文案（[packages/client/ui-tool/src/client/tool/models/primitive-labels.ts:19-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/primitive-labels.ts#L19-L24)）
- `diffBlockLabels` 组装 diff 卡文案，`files` 按 count 是否为 1 选单复数键（[packages/client/ui-tool/src/client/tool/models/primitive-labels.ts:31-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/primitive-labels.ts#L31-L41)）
- `readBlockLabels` 组装读取卡文案，含按 shown/total 生成的窗口说明（[packages/client/ui-tool/src/client/tool/models/primitive-labels.ts:48-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/primitive-labels.ts#L48-L58)）
- `searchBlockLabels` 组装搜索卡文案，路径与匹配摘要按 `truncated` 切换到截断版键（[packages/client/ui-tool/src/client/tool/models/primitive-labels.ts:65-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/primitive-labels.ts#L65-L83)）
- `webBlockLabels` 组装 web 卡文案并内嵌 markdown 文案集（[packages/client/ui-tool/src/client/tool/models/primitive-labels.ts:90-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/primitive-labels.ts#L90-L98)）

### packages/client/ui-tool/src/client/tool/models/raw-tool-call.ts

各卡片模型共用的原始调用/结果字段解析与校验。

- 用 `WeakMap` 以调用块为键缓存解析结果（[packages/client/ui-tool/src/client/tool/models/raw-tool-call.ts:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/raw-tool-call.ts#L10)）
- `parsedToolCall` 先查缓存，再 `JSON.parse` 调用头的 `argsRaw`；解析异常、非对象或数组一律记为 null 并写回缓存（[packages/client/ui-tool/src/client/tool/models/raw-tool-call.ts:17-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/raw-tool-call.ts#L17-L39)）
- `singleResultText` 只在结果内容恰好为一个 text 块时返回其文本（[packages/client/ui-tool/src/client/tool/models/raw-tool-call.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/raw-tool-call.ts#L46-L50)）
- `validEscalationFields` 要求提权字段要么都缺省，要么权限取 `workspace-write`/`danger-full-access` 且理由为非空串（[packages/client/ui-tool/src/client/tool/models/raw-tool-call.ts:58-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/raw-tool-call.ts#L58-L64)）

### packages/client/ui-tool/src/client/tool/models/read-card-model.ts

从读取调用参数、结果文本与持久化元数据派生读取卡数据。

- `CHAT_READ_MAX_LINES` 固定为 8，作为聊天行读取体的折叠行数（[packages/client/ui-tool/src/client/tool/models/read-card-model.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/read-card-model.ts#L17)）
- `validReadCall` 要求工具名为 `read`、路径为非空串，offset/limit 若给出必须是 ≥1 的整数（[packages/client/ui-tool/src/client/tool/models/read-card-model.ts:34-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/read-card-model.ts#L34-L42)）
- `readMeta` 校验元数据的 path/offset/totalLines/lang，并要求每行行号为整数、严格递增且不超过 totalLines（[packages/client/ui-tool/src/client/tool/models/read-card-model.ts:44-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/read-card-model.ts#L44-L67)）
- `readCardModel` 排除子调用、运行中与出错调用，再用正则要求结果文本形如 `<path>…<type>file</type><content>…</content>`，标签经工作区相对化与家目录缩写后输出（[packages/client/ui-tool/src/client/tool/models/read-card-model.ts:78-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/read-card-model.ts#L78-L97)）

### packages/client/ui-tool/src/client/tool/models/search-card-model.ts

从 grep/glob 调用参数与结果元数据派生搜索卡数据。

- `CHAT_SEARCH_MAX_LINES` 固定为 8，作为聊天行搜索结果的保留行数（[packages/client/ui-tool/src/client/tool/models/search-card-model.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/search-card-model.ts#L12)）
- `validSearchCall` 要求 pattern 为串（grep 不许空串、glob 不许全空白）、工具名只能是 grep/glob、path 若给出须为非空串，grep 的 include 另走校验（[packages/client/ui-tool/src/client/tool/models/search-card-model.ts:22-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/search-card-model.ts#L22-L36)）
- `validInclude` 拒绝空白、以 `!` 开头以及花括号外含逗号的模式（[packages/client/ui-tool/src/client/tool/models/search-card-model.ts:38-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/search-card-model.ts#L38-L47)）
- `searchFiles` 逐文件逐匹配校验 path、lineNumber（≥1 整数）与 line（[packages/client/ui-tool/src/client/tool/models/search-card-model.ts:49-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/search-card-model.ts#L49-L67)）
- `flattenContent` 只取 text 块并以换行拼接，全空时返回 undefined（[packages/client/ui-tool/src/client/tool/models/search-card-model.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/search-card-model.ts#L69-L75)）
- `searchCardModel` 排除子调用、运行中与出错调用，要求元数据带布尔 `truncated` 与非负整数 `total`；截断时把结果原文作为 recovery 带出；grep 需 `shape==='matches'`，glob 需 `shape==='paths'` 且路径全为串（[packages/client/ui-tool/src/client/tool/models/search-card-model.ts:82-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/search-card-model.ts#L82-L100)）

### packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts

从 shell 与终端发送调用的原始参数、结果文本派生终端卡数据，并提供其文案与失败判定。

- `terminalBlockLabels` 把会话词典映射成终端原语的全部文案字段（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L16-L31)）
- `localizeTerminalCardModel` 对 shell 原样保留命令与描述，对 `terminal_send` 在文本为空时改用本地化占位并生成带 sessionId 的描述（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:65-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L65-L82)）
- `terminalFailed` 在非运行态且退出码非零或存在信号时判为失败（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:93-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L93-L96)）
- `resolveTerminalCwd` 缺省 workdir 用会话工作区，相对路径与工作区拼接，无会话工作区时原样保留（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:107-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L107-L111)）
- `normalizeSegments` 折叠 `.`/`..`，单独识别 UNC 根并保留原有分隔符与盘符（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:125-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L125-L149)）
- `collapse` 在有根时丢弃顶层 `..`，无根时保留（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:160-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L160-L172)）
- `shellCall` 只接受 bash/pwsh，校验 command、timeoutMs、workdir、后台标志与提权字段；description 缺省时判定为持久 shell 并强制清空 workdir 与后台标志（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:183-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L183-L206)）
- `isSettledPersistentShellCall` 判定已结算的根级持久 shell 调用（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:215-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L215-L220)）
- `terminalSendCall` 校验 `terminal_send` 的 sessionId、text、submit 与后台标志（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:229-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L229-L241)）
- `parseExitStatus` 从结果尾部剥出 `[killed by signal: …]` 或 `[exit code: N]` 标记，都没有时按退出码 0 处理（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:249-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L249-L255)）
- `terminalCardModel` 排除子调用与后台调用；运行中返回 running 卡；已结算的出错调用与持久 shell 返回 null；结果非单 text 块返回 null；`terminal_send` 不解析退出状态（[packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts:267-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/terminal-card-model.ts#L267-L307)）

### packages/client/ui-tool/src/client/tool/models/tool-call-model.ts

从冻结的调用切片派生工具行模型：变体分类、单行摘要、展开体输入与扁平化结果输出。

- `VARIANT_TITLE_KEYS` 给每个行变体绑定一个标题文案键（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:26-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L26-L30)）
- `TOOL_VARIANTS` 把已知 wire 工具名映射到行变体，pwsh 归入 bash 族、web_fetch 归入 read、web_search/grep/glob 归入 search、run_code 归入 code（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:41-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L41-L63)）
- `TOOL_TITLE_KEYS` 为若干工具名提供覆盖变体默认值的标题键（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:66-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L66-L73)）
- `classifyTool` 未登记的工具名一律归入 `others`（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:80-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L80-L82)）
- `resultText` 把结果内容块拍平：text 块取原文，其它块按缩进 JSON 序列化；内容为空且带 error 时改用 `name: code` 行（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:111-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L111-L121)）
- `parseArgs` 吞掉 JSON 解析异常并返回 undefined，交由调用方回落原始串（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:123-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L123-L130)）
- `firstLine` 截到首个换行，`pickString` 按键顺序取第一个非空串（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:132-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L132-L143)）
- `SUMMARY_KEYS` 为每个变体规定摘要取值的参数键优先级（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:146-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L146-L154)）
- `relativizeToCwd` 剥掉工作区根前缀（含尾部分隔符归一），不在根下时原样返回（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:162-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L162-L167)）
- `deriveSummary` 依次尝试：search 变体的 `queries` 数组逗号拼接、变体优先键、参数中任意非空串、原始参数串首行（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:169-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L169-L183)）
- `FILE_PATH_KEYS` 与 `FILE_PATH_VARIANTS` 把可打开路径限定在 read/write/edit 变体与 `path`/`file_path` 两个键（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:186-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L186-L189)）
- `deriveFilePath` 只在文件类变体上从参数取路径（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:191-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L191-L197)）
- `deriveBody` 参数串为空返回 null，非 JSON 返回原串，`code` 变体取 `code` 字段，其余输出缩进 JSON（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:199-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L199-L210)）
- `toolRowModel` 由是否结算与 `error.code === 'interrupted'`/`isError` 定出 running/stopped/error/ok 四态；参数串为空时摘要退化成 callId；`others` 变体且无专属标题时把工具名以 `·` 拼进摘要；空结果文本归一为 null；error 态取输出首行作失败摘要（[packages/client/ui-tool/src/client/tool/models/tool-call-model.ts:220-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/tool-call-model.ts#L220-L251)）

### packages/client/ui-tool/src/client/tool/models/web-card-model.ts

从 web 搜索/抓取调用参数与结果元数据派生 web 卡数据。

- `validWebCall` 要求 `web_search` 的 queries 为非空数组且每项为非空串，`web_fetch` 的 url 为非空串（[packages/client/ui-tool/src/client/tool/models/web-card-model.ts:11-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/web-card-model.ts#L11-L24)）
- `webSources` 逐条校验来源的 url/title/snippet/publishedAt，任一不合即整体作废（[packages/client/ui-tool/src/client/tool/models/web-card-model.ts:33-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/web-card-model.ts#L33-L51)）
- `webCardModel` 排除子调用、运行中与出错调用，要求元数据带布尔 `truncated`；搜索分支输出 answer 与来源列表，抓取分支要求 url 为串且 statusCode 为整数（[packages/client/ui-tool/src/client/tool/models/web-card-model.ts:58-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/models/web-card-model.ts#L58-L82)）

### packages/client/ui-tool/src/client/tool/toolviews/GenericToolCard.tsx

按工具名分发未命中时的兜底卡片，由 `ToolCallTree` 作为 fallback 渲染。

- `VARIANT_ICONS` 为每个行变体绑定前导图标（[packages/client/ui-tool/src/client/tool/toolviews/GenericToolCard.tsx:15-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/GenericToolCard.tsx#L15-L23)）
- 对同一个块同时求行模型与终端、读取、diff、搜索、web 五种卡模型（[packages/client/ui-tool/src/client/tool/toolviews/GenericToolCard.tsx:31-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/GenericToolCard.tsx#L31-L36)）
- 终端卡报失败退出时把 ok 状态提升为 error（[packages/client/ui-tool/src/client/tool/toolviews/GenericToolCard.tsx:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/GenericToolCard.tsx#L39-L41)）
- 单文件工具不给参数 body，且只有单文件工具才把 `openFile` 传下去（[packages/client/ui-tool/src/client/tool/toolviews/GenericToolCard.tsx:42-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/GenericToolCard.tsx#L42-L64)）

### packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx

提问工具的行视图与注册插件，按 id 把问题与答案配对成问答记录。

- `answerEntries` 校验结果 JSON 的 `answers` 数组及每项的 id/selected/custom（[packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx:49-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx#L49-L67)）
- `questionEntries` 校验调用 JSON 的 `questions`，id 重复即整体作废（[packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx:70-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx#L70-L84)）
- `pairAnswers` 按 id 配对，数量不等、答案 id 重复或缺失对应答案时返回 null；非空 custom 追加到答案行末（[packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx:87-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx#L87-L108)）
- `answeredPresentation` 统计有选择或有自定义答案的条数并生成摘要（[packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx:111-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx#L111-L123)）
- `answeredSummary` 在严格配对失败时提供宽松的计数摘要（[packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx:126-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx#L126-L135)）
- 行按结算错误码分支：`ASK_CANCELLED` 改写摘要并把状态压回 ok、`ASK_ABORTED` 置为 stopped，两者都在能取到问题时渲染未答记录卡；运行中显示等待文案；正常结算走配对生成已答记录卡（[packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx:140-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx#L140-L180)）
- 有记录卡时抑制通用的 body 与 output 段（[packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx:189-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx#L189-L190)）
- 插件把该行注册到 `tool.call.toolview` 的 `ask_user_question` 键（[packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx:199-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/ask-question-row.tsx#L199-L207)）

### packages/client/ui-tool/src/client/tool/toolviews/bash-sample.module.css

bash 行视图的样式表，含运行态扫光动画与图标到 chevron 的悬停切换。

- 无运行期机制

### packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx

bash 工具的独立行视图与注册插件，自行装配折叠头、终端卡与 IN/OUT 兜底体。

- `leadingFor` 与 `stateStatus` 按状态给出前导图标与视觉隐藏的状态文本（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:22-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L22-L39)）
- 从会话列表按 sessionId 取出 cwd 供 workdir 解析（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L46)）
- 终端卡报失败退出时把 ok 状态提升为 error（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L51-L53)）
- 组件内 `expanded` 状态控制展开（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L55)）
- 无终端卡时，只有出错调用或已结算的持久 shell 且带 body/output 才允许展开（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:59-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L59-L62)）
- 键盘 Enter/Space 在可展开时 `preventDefault` 并切换展开（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:68-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L68-L72)）
- 前导区按展开/可展开/不可展开三种情形分别渲染 chevron、图标叠加 chevron、纯图标（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:73-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L73-L82)）
- 只有可展开时才挂 `role`、`tabIndex`、`aria-expanded`、点击与键盘处理（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:90-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L90-L95)）
- 折叠摘要按失败首行、终端卡描述、通用摘要的顺序取值（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:101-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L101-L103)）
- 展开体在有终端卡时以不限行数渲染终端原语，否则渲染 IN/OUT 卡并按状态给输出打 `data-error`（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:105-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L105-L136)）
- 提供 `inspect` 时在展开体底部渲染跳转按钮（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:137-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L137-L142)）
- 插件把该行注册到 `tool.call.toolview` 的 `bash` 键（[packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/bash-sample.tsx#L150-L157)）

### packages/client/ui-tool/src/client/tool/toolviews/file-mutation-row.tsx

write/edit 两个工具的行视图与注册插件。

- 组合行模型与 diff 卡，恒不渲染参数 body，并把 `openFile` 直接传给行（[packages/client/ui-tool/src/client/tool/toolviews/file-mutation-row.tsx:15-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/file-mutation-row.tsx#L15-L36)）
- 用生成器一次注册 `edit` 与 `write` 两个键，逐个 yield 出可释放的注册项（[packages/client/ui-tool/src/client/tool/toolviews/file-mutation-row.tsx:43-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/file-mutation-row.tsx#L43-L46)）

### packages/client/ui-tool/src/client/tool/toolviews/plan-summary.ts

从计划列表快照派生 todo 行的单行摘要数据。

- `planSummary` 统计 completed 数与总数，取第一个 `in_progress` 项的 content（缺失、类型不符或去空白后为空则记为 null），并把其余活动项数记入 `activeExtra`（[packages/client/ui-tool/src/client/tool/toolviews/plan-summary.ts:50-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/plan-summary.ts#L50-L59)）

### packages/client/ui-tool/src/client/tool/toolviews/read-row.tsx

read 工具的行视图与注册插件。

- 组合行模型与读取卡，恒不渲染参数 body，并把 `openFile` 传给行（[packages/client/ui-tool/src/client/tool/toolviews/read-row.tsx:15-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/read-row.tsx#L15-L36)）
- 插件把该行注册到 `tool.call.toolview` 的 `read` 键（[packages/client/ui-tool/src/client/tool/toolviews/read-row.tsx:43-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/read-row.tsx#L43-L44)）

### packages/client/ui-tool/src/client/tool/toolviews/search-row.tsx

grep/glob 两个工具的行视图与注册插件。

- `SEARCH_TITLE_KEYS` 给 grep 与 glob 各绑定一个标题键（[packages/client/ui-tool/src/client/tool/toolviews/search-row.tsx:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/search-row.tsx#L12-L15)）
- 组合行模型与搜索卡，按工具名选标题、恒不渲染参数 body、仍传出通用 output 作兜底（[packages/client/ui-tool/src/client/tool/toolviews/search-row.tsx:18-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/search-row.tsx#L18-L41)）
- 用生成器一次注册 `grep` 与 `glob` 两个键（[packages/client/ui-tool/src/client/tool/toolviews/search-row.tsx:48-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/search-row.tsx#L48-L51)）

### packages/client/ui-tool/src/client/tool/toolviews/todo-row.tsx

todo_write 工具的行视图与注册插件。

- `isItem` 只要求列表项是非 null 对象（[packages/client/ui-tool/src/client/tool/toolviews/todo-row.tsx:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/todo-row.tsx#L12-L14)）
- `summarize` 解析参数 JSON，解析失败或 `todos` 非数组/含非对象项时返回 null 由行回落通用摘要；否则把完成计数与第一个活动项以 `·` 拼成摘要文本（[packages/client/ui-tool/src/client/tool/toolviews/todo-row.tsx:26-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/todo-row.tsx#L26-L45)）
- 行在多个活动项时把 `+n` 作为不参与省略的摘要后缀传出（[packages/client/ui-tool/src/client/tool/toolviews/todo-row.tsx:48-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/todo-row.tsx#L48-L67)）
- 插件把该行注册到 `tool.call.toolview` 的 `todo_write` 键（[packages/client/ui-tool/src/client/tool/toolviews/todo-row.tsx:75-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/todo-row.tsx#L75-L76)）

### packages/client/ui-tool/src/client/tool/toolviews/web-row.tsx

web_search/web_fetch 两个工具的行视图与注册插件。

- `WEB_TITLE_KEYS` 给两个工具各绑定一个标题键（[packages/client/ui-tool/src/client/tool/toolviews/web-row.tsx:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/web-row.tsx#L12-L15)）
- 组合行模型与 web 卡，按工具名选图标与标题，恒不渲染参数 body（[packages/client/ui-tool/src/client/tool/toolviews/web-row.tsx:18-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/web-row.tsx#L18-L39)）
- 用生成器一次注册 `web_search` 与 `web_fetch` 两个键（[packages/client/ui-tool/src/client/tool/toolviews/web-row.tsx:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/client/tool/toolviews/web-row.tsx#L47-L50)）

### packages/client/ui-tool/src/css-modules.d.ts

为 `*.module.css` 导入声明类型的环境声明文件。

- 无运行期机制

### packages/client/ui-tool/src/index.ts

Tool UI 插件的宿主侧加载入口，被宿主 Loader 导入该包的 node 半边时调用。

- 导出的 `apply()` 为空函数体，宿主侧加载这个包不注册任何行为（[packages/client/ui-tool/src/index.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/index.ts#L4)）

### packages/client/ui-tool/src/invariant.ts

该包自有的 invariant 伴生插件，由 `./invariant` 子路径导出、被 invariants 服务加载。

- 导出 `name` 固定为 `client-ui-tool-invariant`，作为该伴生插件在 Loader 中的名字（[packages/client/ui-tool/src/invariant.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/invariant.ts#L13)）
- 导出 `inject = ['invariants']`，要求 invariants 服务先就绪才装载本插件（[packages/client/ui-tool/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/invariant.ts#L15)）
- `install` 是空实现，注册后不执行任何检查（[packages/client/ui-tool/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/invariant.ts#L21)）
- `apply` 以常量包名调用 `ctx.invariants.register(PACKAGE_NAME, install)`，并把返回的 disposer 包成 Promise 交回（[packages/client/ui-tool/src/invariant.ts:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/invariant.ts#L10)，[packages/client/ui-tool/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/src/invariant.ts#L28-L29)）

### packages/client/ui-tool/tsconfig.json

该包的 TypeScript 工程配置，供仓库构建与类型检查使用。

- `rootDir: src` 与 `outDir: lib/types` 把 tsc 产物写到 `lib/types`，正是 tsdown 入口与包清单 types 指向的位置（[packages/client/ui-tool/tsconfig.json:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/tsconfig.json#L3-L6)）
- `include` 只收 `src` 目录（[packages/client/ui-tool/tsconfig.json:7-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/tsconfig.json#L7-L9)）
- `references` 列出必须先行构建的十四个工程，决定本包产物生成前的构建顺序（[packages/client/ui-tool/tsconfig.json:10-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/tsconfig.json#L10-L53)）

### packages/client/ui-tool/tsdown.config.ts

该包的打包配置，被仓库 tsdown 工作区构建调用。

- 调用共享预设 `clientBundle`，把包名作为浏览器包的模块 id、并以 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口产出 node 半边产物及浏览器 client 包（[packages/client/ui-tool/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-tool/tsdown.config.ts#L1-L3)）
