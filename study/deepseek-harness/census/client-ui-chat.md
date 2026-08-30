---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-chat
---

# packages/client/ui-chat

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 89 个文件、520 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-chat/README.md

包的英文说明页，讲这个浏览器端 Chat 目标渲染哪些会话节点、系统提示行与 Turn 用量行何时出现、折叠规则是什么，供使用者与维护者阅读。

- 无运行期机制

### packages/client/ui-chat/package.json

包清单，声明入口、浏览器半边的注入清单和发布内容。

- `exports` 把 `.`、`./invariant`、`./client`、`./src/*` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与源码目录（[packages/client/ui-chat/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/package.json#L16-L31)）
- `dsh.client.inject` 列出浏览器半边加载前必须先就位的九个包，并把平台标为 `web`（[packages/client/ui-chat/package.json:32-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/package.json#L32-L47)）
- `files` 把发布内容限定为三个 bundle 与类型声明（[packages/client/ui-chat/package.json:115-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/package.json#L115-L120)）

### packages/client/ui-chat/src/chat-settings.ts

Chat 目标写进宿主用户设置文档的那一小节的命名空间、字段与 schema，宿主与浏览器两侧共用。

- 设置命名空间固定为 `ui-chat`，字段名固定为 `transcriptView`（[packages/client/ui-chat/src/chat-settings.ts:6-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/chat-settings.ts#L6-L9)）
- 取值只接受 `normal` 与 `compact` 两个（[packages/client/ui-chat/src/chat-settings.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/chat-settings.ts#L12)）
- 缺省值为 `compact`（[packages/client/ui-chat/src/chat-settings.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/chat-settings.ts#L18)）
- schema 既做持久化校验也做浏览器侧收到的线路信封校验，非法或缺失字段回落到缺省值（[packages/client/ui-chat/src/chat-settings.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/chat-settings.ts#L27-L29)）

### packages/client/ui-chat/src/client/apply.ts

浏览器半边的插件入口，把 Chat 的会话节点定义、渲染器、视图槽位、设置行、统计行、审批详情与详情面板全部挂上去。

- 给每个 Chat 节点注入 `turnData` hook：按 key 从快照里该节点所属 Turn 的 `data` 上取值，节点不在 turn/step 位置时取到 `undefined`（[packages/client/ui-chat/src/client/apply.ts:35-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L35-L46)）
- `inject` 声明本插件加载前必须存在的服务：槽位、会话、会话 UI、会话装配、布局、语言、设置作用域与两个远端句柄（[packages/client/ui-chat/src/client/apply.ts:49-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L49-L52)）
- 每个会话绑定缓存一份 `chat` 目标的快照订阅源，目标尚无快照时给出 `EMPTY_CHAT_SNAPSHOT`（[packages/client/ui-chat/src/client/apply.ts:59-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L59-L71)）
- 注册会话节点定义与 Chat 节点渲染器（[packages/client/ui-chat/src/client/apply.ts:72-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L72-L73)）
- 向会话 UI 提供名为 `chat` 的 hook，供渲染树以 `useChat` 读同一份快照（[packages/client/ui-chat/src/client/apply.ts:74-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L74-L77)）
- 注册中英两份词典并绑定本命名空间的 `t`（[packages/client/ui-chat/src/client/apply.ts:79-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L79-L80)）
- 建立 Chat 自己的 store，并用一张按会话 id 索引的表保存滚动位置（[packages/client/ui-chat/src/client/apply.ts:81-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L81-L82)）
- 把 `ui-chat` 设置命名空间绑成 `TranscriptViewPolicy`，作为折叠模式的读写口（[packages/client/ui-chat/src/client/apply.ts:83-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L83-L85)）
- 在通用设置里注册 order 12 的 `transcript-view` 行，读当前模式并把新模式写回设置（[packages/client/ui-chat/src/client/apply.ts:87-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L87-L96)）
- 注册 order 0 的 `chat` 会话视图，声明会话级的 keyed 节点子槽位与单例图片子槽位，并挂上 Chat store（[packages/client/ui-chat/src/client/apply.ts:98-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L98-L110)）
- 注入时查不到该会话绑定就抛错（[packages/client/ui-chat/src/client/apply.ts:111-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L111-L112)）
- `openDetails` 先在 store 里选中目标再让布局打开详情面板（[packages/client/ui-chat/src/client/apply.ts:116-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L116-L118)）
- `fileMentions` 走可选服务 `chatFileMentions`，服务缺席时得到 `undefined`（[packages/client/ui-chat/src/client/apply.ts:119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L119)）
- `openFile` 用会话列表行上的 cwd 解析工作区路径后发 `openWorkspacePath` RPC，宿主拒绝则抛出带原因的错误（[packages/client/ui-chat/src/client/apply.ts:120-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L120-L126)）
- `loadOlder` 直接触发该会话加载更早的一页事件（[packages/client/ui-chat/src/client/apply.ts:127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L127)）
- `loadImage` 走会话装配层的按会话图片 URL 缓存，并附带同源的 `peek` 同步读（[packages/client/ui-chat/src/client/apply.ts:128-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L128-L131)）
- `chatScroll` 的 save 传 null 时删除该会话的记录，否则写入；read 取不到时返回 null（[packages/client/ui-chat/src/client/apply.ts:132-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L132-L138)）
- `forkAt` 按 seq 分叉会话并递增标题，成功后打开子会话，失败被吞掉、源视图不变（[packages/client/ui-chat/src/client/apply.ts:139-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L139-L145)）
- 在输入区停靠槽位注册 order 0 的统计行（[packages/client/ui-chat/src/client/apply.ts:152-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L152-L155)）
- 在审批详情槽位注册 `ApprovalCommand`（[packages/client/ui-chat/src/client/apply.ts:157-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L157-L158)）
- 注册详情面板，声明会话级单例工具详情子槽位，并提供关闭详情的回调（[packages/client/ui-chat/src/client/apply.ts:160-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/apply.ts#L160-L166)）

### packages/client/ui-chat/src/client/chat/ApprovalCommand.tsx

审批面板的详情槽位实现，从 Chat 快照里找出与该审批相关联的工具调用并显示其命令。

- 解析工具调用的原始参数 JSON，只有 `command` 字段是字符串时返回它，解析失败或类型不符返回 `undefined`（[packages/client/ui-chat/src/client/chat/ApprovalCommand.tsx:16-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ApprovalCommand.tsx#L16-L24)）
- 遍历快照全部节点，取 `tool-call` 节点的 root，要求 `callId` 相等且 root 上没有 `kind` 字段（[packages/client/ui-chat/src/client/chat/ApprovalCommand.tsx:31-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ApprovalCommand.tsx#L31-L38)）
- 找不到命令时渲染 null，不占位（[packages/client/ui-chat/src/client/chat/ApprovalCommand.tsx:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ApprovalCommand.tsx#L39)）

### packages/client/ui-chat/src/client/chat/AssistantMarkdown.module.css

助手正文的样式表，含宽表格越界、隐藏推理框的间距抵消与中断标记。

- `.md-table-wide` 用 `100cqw` 与消息列宽算出越界宽度，并把 `--dsh-table-spare` 在窄视口下夹到 0，从而在窄屏保持列内滚动、宽屏才横向撑开（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.module.css:33-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.module.css#L33-L43)）
- 被折叠的推理框带 `hidden` 时保留零高盒子，用 −16px 下边距抵消它本会留下的那一个间隙（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.module.css:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.module.css#L48-L50)）

### packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx

助手消息正文渲染器，把一个 Assistant 步骤的块序列渲染成文本、推理行、图片组与未知块。

- 词典对象按 `t` 的身份记忆化，语言不变时不重建 markdown 组件表（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx#L36)）
- 非流式、非中断且只剩工具调用头的节点整体渲染 null，不留空壳（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx:41-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx#L41-L44)）
- 文本块交给 markdown 渲染，并把流式标志与已解析的文件提及一并传下（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx:51-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx#L51-L59)）
- 推理块包一层可隐藏容器后渲染推理行，只有流式且是最后一块时标为运行中（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx:61-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx#L61-L70)）
- 连续的图片块合并成一个图廊，key 取该组第一块的下标，流式追加只让组变长而不重挂（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx:72-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx#L72-L95)）
- 工具调用块在这里跳过，由 ChatView 的分组渲染成工具行（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx:96-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx#L96-L98)）
- 本版本不认识的块渲染成带截断提示的 JSON 块而不是丢弃（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx:99-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx#L99-L107)）
- 根节点带 `data-streaming` 属性，中断状态额外渲染一个 stopped 标记（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx:111-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx#L111-L114)）
- 推理容器用 `useSearchableHidden` 接入浏览器查找唤起，并打上 `data-turn-process-inline` 标记（[packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx:120-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantMarkdown.tsx#L120-L127)）

### packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx

`assistant-step` 节点的 keyed 渲染器，把节点数据翻成助手正文的输入，并接上 Turn 折叠状态。

- 从节点位置取出所属 Turn，非 turn/step 位置时为 `undefined`（[packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx#L9-L11)）
- 只有 Turn 已关闭、本步骤有终节点、且 Turn 尾部记录的收尾节点 seq 与之相等时，才认领 Turn 尾部所有者身份（[packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx:13-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx#L13-L18)）
- 只有认领到所有者身份才去解析文件提及（[packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx:19-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx#L19-L22)）
- 本步骤是折叠规格里的答案步骤、规格声明推理内联、且折叠未展开时，隐藏本节点内的推理（[packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx:23-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx#L23-L27)）
- 提供揭示回调，把所属 Turn 的折叠置为展开（[packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx#L28)）
- 节点状态 `running` 映射为流式、`interrupted` 映射为中断，两种状态与已结算共用同一个 keyed 实例（[packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx:31-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/AssistantNodeView.tsx#L31-L33)）

### packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx

每个 Chat 节点在流里的座位组件，订阅单个节点、算出该节点在 Turn 过程折叠里的角色，再派发到 keyed 渲染器。

- 扫出该 Turn 内位于控制锚点之前、seq 最小的那个用户或转向节点，作为“开场人类输入”的锚（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:36-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L36-L50)）
- 遍历该 Turn 的全部节点得出两件事：开场输入之后、答案之前若还有人类输入则答案不算紧贴；过程窗口内存在非答案步骤的非独立节点则判定有外部过程行（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:52-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L52-L77)）
- 座位只按稳定的 node key 订阅一个节点（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L85)）
- 从所属 Turn 的 `turn-process` 数据取签名并解码成折叠规格（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:86-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L86-L96)）
- 只有紧凑模式、历史已完整、Turn 已关闭且本节点是控制器或答案步骤时，才去取整个 Turn 的 key 列表算版面，否则用空数组（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:98-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L98-L109)）
- 由折叠规格算出“代次”，store 里记录的展开条目只有代次相同才生效，代次变了即回到收起（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:116-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L116-L124)）
- 展开／收起写回 store 时带上 Turn 号与代次（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:125-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L125-L129)）
- 折叠窗口就绪的条件是：有规格、紧凑模式、答案锚点已定、本节点所属 Turn 已关闭且历史完整（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:130-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L130-L141)）
- 过程成员的判据是 seq 大于等于 `processStartSeq` 且小于 `answerAnchorSeq`，并且节点种类不在独立种类集合里（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:142-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L142-L146)）
- 可折叠的判据：成员节点直接可折叠；控制器或答案节点还要求存在外部过程行或规格声明了内联推理（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:147-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L147-L154)）
- 把规格、是否可折叠、是否展开与切换函数打包成 `turnProcess` 交给下游渲染器（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:155-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L155-L164)）
- 控制器节点在不可折叠时自我隐藏；成员节点在可折叠且未展开时隐藏；答案节点在满足紧凑条件时打上紧贴标记（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:165-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L165-L171)）
- 隐藏包裹层接入 `useSearchableHidden`，浏览器查找命中隐藏成员时把折叠展开（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:172-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L172-L175)）
- 节点不存在时整座位渲染 null（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L191)）
- 包裹 div 上写出锚点 key、流 key、节点种类、Turn 号以及成员／隐藏／答案三个折叠标记，供滚动定位与样式使用（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:200-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L200-L211)）
- 以节点种类为 entryKey、node key 为 hook 上下文派发到 keyed 子槽位，没有对应渲染器时回落到带截断提示的 JSON 块（[packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx:212-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatNodeSeat.tsx#L212-L222)）

### packages/client/ui-chat/src/client/chat/ChatView.module.css

Chat 视图的样式表，含滚动容器、流间距规则、折叠答案间距与回到底部控件。

- 滚动容器声明 `container-type: inline-size`，成为宽表格越界所测量的那个内联尺寸容器（[packages/client/ui-chat/src/client/chat/ChatView.module.css:9-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.module.css#L9-L21)）
- 外层存在 `[data-conversation-scroll]` 时本视图交出滚动权，自身改为随内容高度（[packages/client/ui-chat/src/client/chat/ChatView.module.css:23-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.module.css#L23-L33)）
- 流间距只加在相邻的“非 hidden 且非空”座位之间，隐藏成员与空座位不产生间距（[packages/client/ui-chat/src/client/chat/ChatView.module.css:49-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.module.css#L49-L52)）
- 带折叠答案标记的座位把流间距变量改成 8px（[packages/client/ui-chat/src/client/chat/ChatView.module.css:62-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.module.css#L62-L64)）
- 渲染后自行放弃出图的空座位设为 `display: none`（[packages/client/ui-chat/src/client/chat/ChatView.module.css:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.module.css#L69-L71)）
- 回到底部控件放在零高度 sticky 槽里，不增加 scrollHeight，并在会话宿主下按输入区实测高度抬高（[packages/client/ui-chat/src/client/chat/ChatView.module.css:171-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.module.css#L171-L193)）
- `prefers-reduced-motion: reduce` 下取消 Turn 活动条的扫光动画（[packages/client/ui-chat/src/client/chat/ChatView.module.css:131-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.module.css#L131-L137)）

### packages/client/ui-chat/src/client/chat/ChatView.tsx

Chat 视图槽位的组件，负责按顺序摆放节点座位、渲染待发回声与 Turn 活动条，并全权处理滚动跟随、翻页锚定与打开文件失败对话框。

- 跟随判定的底部阈值固定为 24px（[packages/client/ui-chat/src/client/chat/ChatView.tsx:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L17)）
- 滚动容器解析为最近的 `[data-conversation-scroll]` 祖先，没有则用视图自身（[packages/client/ui-chat/src/client/chat/ChatView.tsx:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L20-L22)）
- 按锚点 key 查找已渲染的行时跳过 `[hidden]` 的行（[packages/client/ui-chat/src/client/chat/ChatView.tsx:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L32-L37)）
- 阅读线所在 Turn 先用 `elementsFromPoint` 命中，布局答不出来时退化为一次按序扫描（[packages/client/ui-chat/src/client/chat/ChatView.tsx:47-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L47-L63)）
- 翻页锚点先用视口顶部一像素处的命中测试，失败则在有序行上二分查找第一个底边越过视口顶的行，并以输入区顶边作为可见下界（[packages/client/ui-chat/src/client/chat/ChatView.tsx:72-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L72-L102)）
- 保存的阅读位置由锚点 key、锚点相对滚动口的顶距与 scrollTop 三者组成（[packages/client/ui-chat/src/client/chat/ChatView.tsx:107-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L107-L116)）
- 打开失败的提示文本取错误自身的 message，空串时回落到本地化文案（[packages/client/ui-chat/src/client/chat/ChatView.tsx:119-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L119-L122)）
- 收集已被持久材料覆盖的提交 rpcId：来自用户／转向节点的 `source.rpcId` 与队列条目的 `rpcId`（[packages/client/ui-chat/src/client/chat/ChatView.tsx:136-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L136-L154)）
- 运行中 Turn 的起始时刻取时间线里最后一个 `open` 状态 Turn 的 `turn/start` 时间（[packages/client/ui-chat/src/client/chat/ChatView.tsx:156-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L156-L162)）
- Turn 活动条以 `turn/start` 时间（缺失则挂载时刻）为锚每秒刷新，超过 15 秒才显示计时（[packages/client/ui-chat/src/client/chat/ChatView.tsx:165-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L165-L198)）
- 检视某次调用即切到 `trajectory` 视图并带上 callId（[packages/client/ui-chat/src/client/chat/ChatView.tsx:225-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L225-L227)）
- 打开文件请求带自增序号，结算时序号不匹配就整段丢弃，避免被取消的旧请求重新弹出对话框（[packages/client/ui-chat/src/client/chat/ChatView.tsx:234-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L234-L255)）
- 关闭对话框时把序号推进一格并清空错误与忙碌态（[packages/client/ui-chat/src/client/chat/ChatView.tsx:257-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L257-L261)）
- 待处理队列里只取 `placement === 'steering'` 的条目渲染成转向气泡（[packages/client/ui-chat/src/client/chat/ChatView.tsx:263-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L263-L266)）
- 本地提交回声按 rpcId 过滤：一旦其 id 出现在持久材料或队列里就在同一帧隐藏，实现回声到持久节点的原子替换（[packages/client/ui-chat/src/client/chat/ChatView.tsx:271-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L271-L275)）
- 消息图片渲染统一走 `conversation.message.images` 子槽位并注入 `loadImage`（[packages/client/ui-chat/src/client/chat/ChatView.tsx:276-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L276-L279)）
- 跟随信号由打开状态、首 seq、末 key、节点数、运行标志与最后一条转向／提交 id 拼成，只有它变化才算流尖端移动（[packages/client/ui-chat/src/client/chat/ChatView.tsx:312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L312)）
- 当前 Turn 标记按滚动口顶部下方 min(96, 20% 高度) 的阅读线判定，取不超过该行 Turn 的最新可选 Turn；贴底时直接取最后一个（[packages/client/ui-chat/src/client/chat/ChatView.tsx:314-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L314-L338)）
- 标记同步按帧合并，无 `requestAnimationFrame` 时同步执行，卸载时取消挂起的帧（[packages/client/ui-chat/src/client/chat/ChatView.tsx:342-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L342-L358)）
- 跳到底部会清空翻页锚点、写 scrollTop、同步观察台账、置为跟随、清除保存位置并把标记移到最后一个 Turn（[packages/client/ui-chat/src/client/chat/ChatView.tsx:366-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L366-L374)）
- 会话打开完成时只处理一次：无保存位置就跳到底，有则按 scrollTop 加锚点补偿恢复，并把贴底的恢复结果归一化为跟随（[packages/client/ui-chat/src/client/chat/ChatView.tsx:376-407](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L376-L407)）
- 检测到首 seq 变小（前插了一页）时，用记下的锚点把同一行拉回原位置（[packages/client/ui-chat/src/client/chat/ChatView.tsx:411-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L411-L424)）
- 新增尾部用户节点、新转向条目或新提交回声一律强制滚到底；其余情况只有流尖端变化且当前处于跟随态才跟随（[packages/client/ui-chat/src/client/chat/ChatView.tsx:426-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L426-L438)）
- 滚动处理器用“观察台账”区分读者滚动与程序写入：偏离台账超过 0.5px 才重算跟随归属，否则沿用旧状态；非读者引起且判为贴底时直接跳底（[packages/client/ui-chat/src/client/chat/ChatView.tsx:441-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L441-L464)）
- 每次滚动都持续保存位置（贴底时保存 null），并在有挂起翻页请求时把锚点更新到新位置，最后重排 Turn 标记（[packages/client/ui-chat/src/client/chat/ChatView.tsx:465-477](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L465-L477)）
- 滚动监听在挂载时绑一次到解析出的滚动口，以 passive 注册并在卸载时解绑（[packages/client/ui-chat/src/client/chat/ChatView.tsx:482-492](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L482-L492)）
- `ResizeObserver` 同时观察消息列与输入区座位：尺寸变化时在跟随态下补滚到底，并重排 Turn 标记（[packages/client/ui-chat/src/client/chat/ChatView.tsx:496-524](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L496-L524)）
- 翻页请求离开忙碌态即丢弃锚点，空页或失败页不会留下永久待补偿的锚（[packages/client/ui-chat/src/client/chat/ChatView.tsx:528-530](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L528-L530)）
- 点击“加载更早”先记下当前锚点行与其位置，再触发加载（[packages/client/ui-chat/src/client/chat/ChatView.tsx:532-546](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L532-L546)）
- Turn 导航跳转把目标行滚到距顶 24px，随后重算贴底态、若仍有挂起翻页则把锚点改挂到落点行，并保存新位置（[packages/client/ui-chat/src/client/chat/ChatView.tsx:549-570](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L549-L570)）
- 打开状态为 loading／error 时分别渲染提示与带 code 的错误行（[packages/client/ui-chat/src/client/chat/ChatView.tsx:582-587](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L582-L587)）
- 还有更早历史时渲染加载按钮，加载中禁用并换文案（[packages/client/ui-chat/src/client/chat/ChatView.tsx:588-594](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L588-L594)）
- 按快照的 `order` 逐个渲染节点座位，并把历史是否完整、是否紧凑模式等一并下传（[packages/client/ui-chat/src/client/chat/ChatView.tsx:595-614](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L595-L614)）
- 会话处于运行态时渲染一条贯穿整个 Turn 的活动条（[packages/client/ui-chat/src/client/chat/ChatView.tsx:620](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L620)）
- 流尾依次渲染待入列的转向气泡与本地提交回声气泡（[packages/client/ui-chat/src/client/chat/ChatView.tsx:621-636](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L621-L636)）
- 非跟随态才渲染回到底部按钮，点击即跳底（[packages/client/ui-chat/src/client/chat/ChatView.tsx:638-653](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L638-L653)）
- 打开路径被宿主拒绝时弹出对话框，显示线路给出的原因并提供对同一路径的重试，忙碌时禁用重试（[packages/client/ui-chat/src/client/chat/ChatView.tsx:655-664](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L655-L664)）
- 对话框标题按路径是否为 `.`（打开工作区目录）选用不同文案（[packages/client/ui-chat/src/client/chat/ChatView.tsx:125-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ChatView.tsx#L125-L127)）

### packages/client/ui-chat/src/client/chat/CommandNodeView.tsx

`command` 与 `manual-compaction` 两种节点的 keyed 渲染器。

- 命令行按命令名派发到 `conversation.chat.commandview` 子槽位，名字缺失时用空串，无匹配渲染器时回落到通用命令卡（[packages/client/ui-chat/src/client/chat/CommandNodeView.tsx:13-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/CommandNodeView.tsx#L13-L24)）
- 手动压缩节点把命令与压缩事务合成一张卡，压缩为 null 时不传该属性（[packages/client/ui-chat/src/client/chat/CommandNodeView.tsx:27-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/CommandNodeView.tsx#L27-L40)）

### packages/client/ui-chat/src/client/chat/CompactionCommandCard.tsx

手动压缩命令的卡片，决定同一次压缩用压缩标记还是普通命令卡呈现。

- 有结构化压缩结果时渲染压缩标记，标题换成命令标题，并把命令的结算文本作为计数不可用时的兜底摘要（[packages/client/ui-chat/src/client/chat/CompactionCommandCard.tsx:14-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/CompactionCommandCard.tsx#L14-L23)）
- 命令已结算但没有压缩结果时渲染普通命令卡（[packages/client/ui-chat/src/client/chat/CompactionCommandCard.tsx:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/CompactionCommandCard.tsx#L24)）
- 命令尚未结算时渲染普通命令卡并换上压缩专用的运行中文案（[packages/client/ui-chat/src/client/chat/CompactionCommandCard.tsx:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/CompactionCommandCard.tsx#L25)）

### packages/client/ui-chat/src/client/chat/CompactionItem.tsx

模型历史压缩标记行，显示被遮蔽的条目／token 计数并可展开摘要。

- 只有节点带摘要才可展开，否则按钮禁用且不给 `aria-expanded`（[packages/client/ui-chat/src/client/chat/CompactionItem.tsx:39-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/CompactionItem.tsx#L39-L40)）
- 摘要文本优先用被遮蔽条目数与 token 数拼出的完成文案，两者任一缺失则退到外部兜底文本，再退到“可展开”或“不可用”文案（[packages/client/ui-chat/src/client/chat/CompactionItem.tsx:41-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/CompactionItem.tsx#L41-L47)）
- 点击行切换展开态，展开图标随之切换（[packages/client/ui-chat/src/client/chat/CompactionItem.tsx:50-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/CompactionItem.tsx#L50-L66)）
- 展开后把摘要按 markdown 渲染（[packages/client/ui-chat/src/client/chat/CompactionItem.tsx:72-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/CompactionItem.tsx#L72-L73)）

### packages/client/ui-chat/src/client/chat/ContextBody.module.css

上下文注入行展开体的样式表，为各种形态提供统一的代码块表面。

- 无运行期机制

### packages/client/ui-chat/src/client/chat/ContextBody.tsx

上下文注入节点的展开体：按生产者声明的形态选一种呈现，读不动就退回不透明体。

- 展示文本上限 20000 字符，列表型体最多物化 200 行（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:15-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L15-L18)）
- 内容块按模型收到的顺序切成 run：相邻文本块无分隔地拼接，未知块自成一段而不被提前或丢弃（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:42-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L42-L54)）
- 超长文本按上限截断并在末尾追加带总长度的截断说明（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:62-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L62-L66)）
- 来源字段值按类型转成字符串（对象走 JSON）后同样受上限约束（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:73-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L73-L78)）
- 来源字段列表恒隐藏 `kind`；已有专用体渲染时连 `form` 一并隐藏，不透明体则保留 `form`（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:88-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L88-L108)）
- 模型可见内容渲染为保留换行的 `pre`，未知块渲染为带截断提示的 JSON 块（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:139-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L139-L159)）
- 不透明体 = 模型可见内容 + 其余来源字段，是所有未识别形态的落点（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:168-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L168-L179)）
- 指令变更列表全有或全无地解析：任一条目不是对象、路径非法或动作不在 set/replace/remove 之内即整体判为不可读；路径按首次出现去重（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:197-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L197-L218)）
- 每个文件显示的动词由动作与是否基线共同决定：remove 恒为移除，基线恒为载入，否则 set 为新增、replace 为更新（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:228-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L228-L236)）
- 指令体先列出被调和的文件（digest 挂在 `title` 上），再原样给出含 `<system-reminder>` 框架的模型可见文本；变更不可读时整体退回不透明体（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:247-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L247-L270)）
- 目录条目同样全有或全无地解析，但空数组是合法目录（表示替换后不留任何名字）（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:284-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L284-L300)）
- 目录体在 `update` 为真时加一条替换通告，只渲染前 200 条并对余量给出计数提示，同时保留内容里的未知块（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:312-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L312-L347)）
- 快照分节要求每节的 name 非空、text 为字符串，空列表判为不可读（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:356-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L356-L370)）
- 快照体用一句“取代先前快照”的说明加逐节名／文本，不再重复拼接后的整段散文（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:388-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L388-L411)）
- 通告体只渲染模型可见内容（其一句话摘要由收起行承担）（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:421-427](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L421-L427)）
- 转发体先给出发送方会话 id 一行，再给内容；发送方读不出时退回不透明体（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:437-459](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L437-L459)）
- 召回引用要求 label、保留条数、省略条数、是否截断四项齐全，任一缺失即整体不可读（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:470-491](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L470-L491)）
- 召回体逐条列出来源会话与保留／省略计数，被截断的额外标注，再给出材料本身（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:503-531](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L503-L531)）
- 收起行的一句话摘要只有 `notice` 形态记录，取来源上的非空 `summary`（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:534-537](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L534-L537)）
- 选体函数对每种形态先做一次可读性解析再决定：解析不出就返回不透明体并把“实际渲染形态”报成 null，`null` 形态直接不透明，新增未处理形态在 default 分支抛错（[packages/client/ui-chat/src/client/chat/ContextBody.tsx:551-592](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextBody.tsx#L551-L592)）

### packages/client/ui-chat/src/client/chat/ContextInjectionRow.module.css

上下文注入行的样式表，与系统提示行共用同一套披露体几何。

- 无运行期机制

### packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx

被记录的非用户消息的收起行，头部显示角色与生产者，展开后按形态给出体。

- 展开／收起是行内本地状态，点击整行切换（[packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx:32-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx#L32-L64)）
- 体、实际渲染形态与收起行摘要都由 `contextBody` 一次解析给出（[packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx#L35)）
- 角色为 `recall` 时换用会话引用图标与召回标题，否则用注入图标与注入标题（[packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx#L39-L44)）
- 来源没有生产者名时整段收起内容（含分隔点）都不渲染；有摘要时再追加一段（[packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx:45-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx#L45-L59)）
- 展开体的 DOM 上写出实际渲染的形态（不透明时不写），可被外部观察（[packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx:66-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ContextInjectionRow.tsx#L66-L68)）

### packages/client/ui-chat/src/client/chat/GenericCommandCard.module.css

通用命令卡的样式表，含运行中扫光动画。

- `prefers-reduced-motion: reduce` 下取消运行中行的扫光动画（[packages/client/ui-chat/src/client/chat/GenericCommandCard.module.css:82-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/GenericCommandCard.module.css#L82-L86)）

### packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx

任何命令生命周期的默认卡片，也是命令名无专用渲染器时的回落。

- 行状态由结算结果决定：未结算为运行中，结算 kind 为 error 则错误，否则正常（[packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx:10-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx#L10-L13)）
- 错误状态换成状态点图标，其余用 API 图标（[packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx#L15-L17)）
- 摘要优先用结算文本，未结算时用调用方给的运行中文案或通用运行中文案，结算但无文本时按 error／ok 选失败或完成文案（[packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx:29-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx#L29-L31)）
- 标题取命令名，缺失时用通用命令标题（[packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx#L34)）
- 只有结算文本含换行才产生可展开的体，否则行不可展开（[packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx:36-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx#L36-L37)）
- 运行中与错误各额外渲染一段仅读屏可见的状态文本（[packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx:40-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/GenericCommandCard.tsx#L40-L41)）

### packages/client/ui-chat/src/client/chat/MessageIconActions.module.css

用户与助手消息共用的图标操作行样式表，含时间标签的悬停显隐。

- 在支持 hover 的设备上，`[data-time-hover-root]` 作用域内的时间标签默认不透明度为 0，只在容器 hover 或内部获得焦点时显现；不支持 hover 的设备始终可见（[packages/client/ui-chat/src/client/chat/MessageIconActions.module.css:37-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageIconActions.module.css#L37-L47)）
- 标记为不可用的操作按钮保持可聚焦可悬停，仅降低不透明度并取消 hover 反馈（[packages/client/ui-chat/src/client/chat/MessageIconActions.module.css:75-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageIconActions.module.css#L75-L84)）

### packages/client/ui-chat/src/client/chat/MessageIconActions.tsx

消息下方的复制／分叉／时钟操作行，用户与助手消息共用。

- 复制带 pending 与已复制两重闸门，重复点击既不重复写剪贴板也不叠加定时器；成功后切成对勾 1 秒（[packages/client/ui-chat/src/client/chat/MessageIconActions.tsx:54-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageIconActions.tsx#L54-L77)）
- 卸载时推进 epoch 并清定时器，落在卸载后的剪贴板结算被整段忽略（[packages/client/ui-chat/src/client/chat/MessageIconActions.tsx:58-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageIconActions.tsx#L58-L62)）
- 没有时间戳就完全不渲染时钟；有则依次追加运行时长、TTFT 与 tok/s 三段，各段只在对应数值存在时出现（[packages/client/ui-chat/src/client/chat/MessageIconActions.tsx:81-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageIconActions.tsx#L81-L109)）
- 时钟按 `clock` 属性放在图标之前或之后（[packages/client/ui-chat/src/client/chat/MessageIconActions.tsx:112-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageIconActions.tsx#L112-L138)）
- 分叉按钮只在给了回调时出现；标记为不可用时用 `aria-disabled` 而非原生 disabled，并撤掉 onClick、挂上说明原因的隐藏文本（[packages/client/ui-chat/src/client/chat/MessageIconActions.tsx:119-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageIconActions.tsx#L119-L137)）
- 插槽式的 `extraActions` 插在复制与分叉之间（[packages/client/ui-chat/src/client/chat/MessageIconActions.tsx:118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageIconActions.tsx#L118)）

### packages/client/ui-chat/src/client/chat/MessageItem.module.css

用户气泡、压缩标记、重试行与 Turn 错误行的样式表。

- 压缩行的上下文图标与展开图标叠在同一网格位，靠 hover 与 `:focus-visible` 互换不透明度（[packages/client/ui-chat/src/client/chat/MessageItem.module.css:99-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.module.css#L99-L119)）
- `prefers-reduced-motion: reduce` 下取消重试行的闪烁动画并恢复实色（[packages/client/ui-chat/src/client/chat/MessageItem.module.css:288-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.module.css#L288-L294)）

### packages/client/ui-chat/src/client/chat/MessageItem.tsx

用户／转向气泡、待发回声、上下文行、压缩、重试、Turn 错误与未知节点这一批 keyed 渲染器的所在。

- 内容块被拆成文本、图片与其余三堆：文本无分隔地拼接，其余原样保留（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:15-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L15-L32)）
- 重试秒数向上取整且不小于 1（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L34-L36)）
- 失败原因为 `AUTH` 时替换成固定文案，其余原样显示宿主给的 message（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:43-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L43-L49)）
- 重试倒计时的截止点锚在浏览器首次渲染该节点的时刻加延迟，不用宿主事件时间（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:57-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L57-L58)）
- 只有处于活动重试时才起 250ms 定时器刷新倒计时，读到 1 秒即停表（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:69-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L69-L85)）
- 重试标签按活动／已取消／已开始／已排期四态取文案，秒数在活动时用倒计时、否则用原始排期值（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:87-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L87-L94)）
- 重试行展开后给出延迟毫秒数与失败原因两项（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:103-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L103-L112)）
- Turn 终止失败行以 `role="status"` 常驻显示标题、消息与错误码（有码时）（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:118-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L118-L132)）
- 触到输出 token 上限的 Turn 用警告色状态点与专用提示行（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:135-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L135-L147)）
- 用户气泡在给了预览图时用预览图替换从内容推出的图片组；文本为空且没有额外块时不渲染气泡本体（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:166-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L166-L180)）
- 用户文本经 `projectUserText` 按会话提及标签投影，其余未知块渲染成带截断提示的 JSON 块，提及标签另起一行汇总（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:180-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L180-L188)）
- 气泡容器写出 `data-pending-steering`、`data-submission-echo` 与 `data-time-hover-root` 三个标记（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:171-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L171-L177)）
- 待入列转向气泡用与其最终持久节点相同的视觉，且不带时间戳（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:201-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L201-L222)）
- 本地提交回声把草稿文本包成一个文本块（空串则无块），图片改用本地 object URL 预览并带上名称与宽高（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:232-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L232-L270)）
- 用户与已入列转向节点共用一个渲染器，`referenceLabels` 存在时才下传（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:273-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L273-L294)）
- 上下文节点把内容、来源、出处与形态四项转交注入行（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:297-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L297-L308)）
- 自动压缩节点渲染成压缩标记（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:311-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L311-L313)）
- 重试链节点只渲染当前一环，`retryState === 'scheduled'` 时判为活动（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:316-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L316-L319)）
- 未知节点显式渲染成带类型名与原始负载的 JSON 块，而不是丢弃（[packages/client/ui-chat/src/client/chat/MessageItem.tsx:332-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/MessageItem.tsx#L332-L343)）

### packages/client/ui-chat/src/client/chat/ReasoningRow.module.css

推理披露行的样式表，含运行中扫光与摘要跟随末尾时的截断方式。

- 摘要带 `data-follow-end` 时把 `text-overflow` 改成 `clip`，使跟随末尾的滚动不被省略号占位（[packages/client/ui-chat/src/client/chat/ReasoningRow.module.css:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ReasoningRow.module.css#L67-L69)）
- `prefers-reduced-motion: reduce` 下取消运行中行的扫光动画（[packages/client/ui-chat/src/client/chat/ReasoningRow.module.css:81-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ReasoningRow.module.css#L81-L85)）

### packages/client/ui-chat/src/client/chat/ReasoningRow.tsx

单个助手推理块的披露行，收起时给一行摘要，展开给全文。

- 运行中摘要取文本末行（先去尾空白），已结束取首行（[packages/client/ui-chat/src/client/chat/ReasoningRow.tsx:9-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ReasoningRow.tsx#L9-L30)）
- 摘要横向滚动经节流调度：运行中滚到最右，结束后归零，随运行标志与摘要变化触发（[packages/client/ui-chat/src/client/chat/ReasoningRow.tsx:31-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ReasoningRow.tsx#L31-L38)）
- 运行中额外渲染一段仅读屏可见的状态文本，并在根上写出 `data-state`（[packages/client/ui-chat/src/client/chat/ReasoningRow.tsx:41-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ReasoningRow.tsx#L41-L42)）
- 行恒可展开，点击整行切换，展开体是保留换行的完整推理文本（[packages/client/ui-chat/src/client/chat/ReasoningRow.tsx:43-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/ReasoningRow.tsx#L43-L62)）

### packages/client/ui-chat/src/client/chat/StatsLine.module.css

输入区下方会话统计行的样式表。

- 无运行期机制

### packages/client/ui-chat/src/client/chat/StatsLine.tsx

会话统计行组件，挂在 composer dock 上，读取快照节点与投影值后拼出一行统计文本。

- `deriveStats` 遍历快照节点：`tool-result` 节点在 `callTime` 非空时把 `time - callTime` 累加进 `toolMs`（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L57-L61)）
- 非 `assistant` 节点被跳过，`assistant` 节点把 turn 计入集合、steps 加一，并在 `timing.stepStartTime` 非空时累加 `completedTime - stepStartTime`（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:62-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L62-L67)）
- 用 `assistantStepReading` 读出的 ttft 累加并计数，decode 时长与输出 token 仅在两者都存在时同时累加（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:68-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L68-L78)）
- `formatDuration` 在不足 60 秒时用一位小数的秒模板，否则拆成分钟加取整的余秒（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:86-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L86-L94)）
- `billedInputTokens` 把未命中输入、缓存读、缓存写三个桶相加作为命中率分母（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:103-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L103-L115)）
- 组件读取 `tokenUsage` 与 `sessionStats` 两个投影，`sessionStats` 缺失时才回落到窗口内的 `deriveStats` 折叠（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:126-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L126-L133)）
- 计数、时长、速度三组文本各自在对应统计量大于零时才入组，空组整组丢弃（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:136-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L136-L152)）
- 计费组仅在计费输入或输出 token 之一大于零时出现，缓存命中率为 null 时不加该段（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:159-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L159-L167)）
- 布局副作用用 `ResizeObserver` 测量 `scrollWidth > clientWidth` 决定截断标志，只有截断时才启用整行 tooltip（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:171-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L171-L185)）
- 无任何分组时组件直接返回 null（[packages/client/ui-chat/src/client/chat/StatsLine.tsx:183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/StatsLine.tsx#L183)）

### packages/client/ui-chat/src/client/chat/SystemPromptRow.tsx

系统提示词的折叠行组件，以及注册在 `system-prompt` 键上的 Chat 节点渲染器。

- 行内维护展开状态，点击整行切换开合（[packages/client/ui-chat/src/client/chat/SystemPromptRow.tsx:23-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/SystemPromptRow.tsx#L23-L34)）
- 展开体把完整提示词文本包成单个 text 块交给 `OpaqueBody` 渲染，并挂 `data-system-prompt-body` 标记（[packages/client/ui-chat/src/client/chat/SystemPromptRow.tsx:35-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/SystemPromptRow.tsx#L35-L38)）
- `SystemPromptNodeView` 用 memo 包装，把节点的 `data.text` 传给该行（[packages/client/ui-chat/src/client/chat/SystemPromptRow.tsx:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/SystemPromptRow.tsx#L43-L47)）

### packages/client/ui-chat/src/client/chat/TurnNavigator.module.css

轮次导航轨的样式模块，被 `TurnNavigator.tsx` 引用。

- 轨道高度由滚动视口高度与 composer 高度两个外部发布的自定义属性算出可视带，并在自然高度、带高减 64px、420px 三者间取最小（[packages/client/ui-chat/src/client/chat/TurnNavigator.module.css:11-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.module.css#L11-L39)）
- 单个刻度按钮设 `pointer-events: none`，指针命中全部由轨道容器承担（[packages/client/ui-chat/src/client/chat/TurnNavigator.module.css:59-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.module.css#L59-L71)）
- 容器宽度不超过 900px 时整个插槽 `display: none`（[packages/client/ui-chat/src/client/chat/TurnNavigator.module.css:166-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.module.css#L166-L170)）
- 在减弱动效偏好下关闭轨道、刻度与预览的过渡和入场动画（[packages/client/ui-chat/src/client/chat/TurnNavigator.module.css:172-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.module.css#L172-L180)）

### packages/client/ui-chat/src/client/chat/TurnNavigator.tsx

已加载轮次的紧凑导航轨组件，把轮次列表映射成刻度并处理跳转与预览。

- 刻度位置同时给出按固定间距的自然位置和按序号比例的百分比位置（[packages/client/ui-chat/src/client/chat/TurnNavigator.tsx:30-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.tsx#L30-L36)）
- 轨道自然高度按刻度数乘间距再加两端内衬算出，并把内衬值发布为自定义属性（[packages/client/ui-chat/src/client/chat/TurnNavigator.tsx:38-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.tsx#L38-L43)）
- `itemAtPointer` 用轨道的实际矩形把指针 Y 坐标夹到 0..1 比例再四舍五入成条目下标（[packages/client/ui-chat/src/client/chat/TurnNavigator.tsx:45-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.tsx#L45-L54)）
- 少于两个条目时整个轨道不渲染（[packages/client/ui-chat/src/client/chat/TurnNavigator.tsx:59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.tsx#L59)）
- 轨道上的点击调用 `onNavigate` 跳到指针处条目，指针移动更新预览、离开清空预览（[packages/client/ui-chat/src/client/chat/TurnNavigator.tsx:63-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.tsx#L63-L78)）
- 每个刻度按钮的点击阻止冒泡后自行跳转，聚焦与失焦分别设置和清空预览轮次（[packages/client/ui-chat/src/client/chat/TurnNavigator.tsx:89-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.tsx#L89-L101)）
- 预览气泡在 prompt 为空时退回轮次编号文本，response 为空串时不渲染第二行（[packages/client/ui-chat/src/client/chat/TurnNavigator.tsx:106-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.tsx#L106-L113)）
- 导出件用 `memo` 包装，props 引用不变时跳过重渲染（[packages/client/ui-chat/src/client/chat/TurnNavigator.tsx:128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnNavigator.tsx#L128)）

### packages/client/ui-chat/src/client/chat/TurnProcessNodeView.module.css

轮次过程折叠按钮的样式模块，被 `TurnProcessNodeView.tsx` 引用。

- 无运行期机制

### packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx

注册在 `turn-process` 键上的渲染器，把轮次过程折叠控件画成一个按钮。

- 缺少 `turnProcess` 所有者状态时直接抛错（[packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx#L10)）
- `foldable` 为假时返回 null，不渲染任何行（[packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx#L11)）
- 标签按工具调用数、消息数、子代理数依次拼接，各自按单复数选键，三者全为零时用固定的兜底文案（[packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx:13-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx#L13-L40)）
- 按钮上挂 `data-turn-process` 及三个计数的 data 属性和 `aria-expanded`（[packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx#L44-L50)）
- 点击先把焦点移到按钮自身再调用 `setOpen` 取反（[packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx:51-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnProcessNodeView.tsx#L51-L54)）

### packages/client/ui-chat/src/client/chat/TurnTailNodeView.module.css

轮次尾行的样式模块，被 `TurnTailNodeView.tsx` 引用。

- 无运行期机制

### packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx

注册在 `turn-tail` 键上的渲染器，负责轮次尾部的扩展插槽、用量披露与消息操作行。

- 通过快照选择器判断本节点是否已不是该轮次位置索引的最后一个（[packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx:17-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx#L17-L18)）
- 节点位置不是 turn 或 step 时返回 null（[packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx:19-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx#L19-L22)）
- 传给尾部插槽链的所有者 seq 优先取收尾助手节点的 seq，否则用节点自身 seq（[packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx#L24-L25)）
- 没有收尾助手时只渲染插槽链结果，链为空则整行不渲染（[packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx#L26)）
- 运行时长由轮次的起止时间相减得到，任一端缺失则不给（[packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx#L27-L29)）
- 收尾节点没有 `messageId` 时不渲染 assistant-actions 列表插槽（[packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx:30-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx#L30-L35)）
- 仅当节点带 `tokenUsage` 时才渲染每轮用量披露（[packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx#L40)）
- 操作行的复制文本取自收尾助手的可见文本块，分支按钮调用 `forkAt(closing.finalNode.seq)`，并在 `branchUnavailable` 或存在更晚节点时禁用（[packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx:41-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnTailNodeView.tsx#L41-L53)）

### packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.module.css

每轮 token 用量披露的样式模块，被 `TurnUsageDisclosure.tsx` 引用。

- 无运行期机制

### packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx

单轮 token 用量的折叠披露组件，被轮次尾行使用。

- 缓存命中率只在 `cacheReadTokens` 存在时计算，分母取 `totalTokens - outputTokens`，精度为一位小数（[packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx#L24-L26)）
- 折叠态摘要在有命中率时用带百分比的模板，否则只显示总量（[packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx:27-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx#L27-L30)）
- 路由文本把每个 `provider/model` 用逗号拼接，缺失时为空串（[packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx#L31)）
- 组件内部维护展开状态并由整行点击切换（[packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx:23-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx#L23-L49)）
- 明细表按存在性分别渲染路由行、缓存读行、缓存写行与推理 token 后缀，输入/输出/总计始终用精确分组数字（[packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx:51-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/TurnUsageDisclosure.tsx#L51-L83)）

### packages/client/ui-chat/src/client/chat/accessibility.module.css

只含一个视觉隐藏类的样式模块。

- `visuallyHidden` 用 1px 尺寸加 clip 把元素移出视觉呈现但保留在文档与可访问性树中（[packages/client/ui-chat/src/client/chat/accessibility.module.css:1-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/accessibility.module.css#L1-L8)）

### packages/client/ui-chat/src/client/chat/message-chrome.ts

消息操作行共用的时间与速率格式化函数集合。

- `startOfLocalDay` 把时刻归到本地零点毫秒（[packages/client/ui-chat/src/client/chat/message-chrome.ts:19-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/message-chrome.ts#L19-L23)）
- `msUntilNextLocalMidnight` 给出到下一个本地零点的毫秒数并至少为 1（[packages/client/ui-chat/src/client/chat/message-chrome.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/message-chrome.ts#L30-L34)）
- `formatRunDuration` 把负值夹到零并向下取整到秒，超过一分钟改用分钟加两位补零的秒（[packages/client/ui-chat/src/client/chat/message-chrome.ts:42-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/message-chrome.ts#L42-L49)）
- `formatLatencySeconds` 不足十秒保留一位小数，十秒及以上取整（[packages/client/ui-chat/src/client/chat/message-chrome.ts:57-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/message-chrome.ts#L57-L60)）
- `formatTokensPerSecond` 把负值夹到零，十以上取整、以下保留一位小数（[packages/client/ui-chat/src/client/chat/message-chrome.ts:67-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/message-chrome.ts#L67-L70)）
- `formatMessageClock` 同一本地日只输出 24 小时制时钟，同年跨日加 `clock.md` 日期模板，跨年加 `clock.ymd` 模板（[packages/client/ui-chat/src/client/chat/message-chrome.ts:82-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/message-chrome.ts#L82-L96)）

### packages/client/ui-chat/src/client/chat/register-node-renderers.ts

把本包的各个 Chat 节点渲染器按 kind 注册到 `conversation.chat.node` 键控插槽上。

- 每个注册都包在 `ctx.slots.inject` 里，注册调用的返回值作为该贡献的处置器（[packages/client/ui-chat/src/client/chat/register-node-renderers.ts:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/register-node-renderers.ts#L17-L19)）
- `user` 与 `steering` 两个键指向同一个 `UserMessageNodeView`（[packages/client/ui-chat/src/client/chat/register-node-renderers.ts:18-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/register-node-renderers.ts#L18-L21)）
- `context`、`system-prompt`、`assistant-step` 分别绑定到对应的渲染组件（[packages/client/ui-chat/src/client/chat/register-node-renderers.ts:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/register-node-renderers.ts#L22-L27)）
- `command` 键的注册声明了一个会话作用域的键控子插槽 `conversation.chat.commandview`（[packages/client/ui-chat/src/client/chat/register-node-renderers.ts:28-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/register-node-renderers.ts#L28-L33)）
- `manual-compaction`、`compaction`、`model-retry`、`turn-error`、`turn-max-tokens`、`turn-process` 各绑定一个渲染器（[packages/client/ui-chat/src/client/chat/register-node-renderers.ts:34-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/register-node-renderers.ts#L34-L45)）
- `turn-tail` 键的注册同时声明 chain 类型的 `conversation.chat.turnTail` 与 list 类型的 `conversation.chat.assistant-actions` 子插槽（[packages/client/ui-chat/src/client/chat/register-node-renderers.ts:46-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/register-node-renderers.ts#L46-L54)）
- `unknown` 键绑定通用兜底渲染器（[packages/client/ui-chat/src/client/chat/register-node-renderers.ts:55-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/register-node-renderers.ts#L55-L56)）

### packages/client/ui-chat/src/client/chat/searchable-hidden.ts

一个把子树置为可被浏览器查找命中的隐藏态的 React Hook。

- 布局副作用中若子树内含当前焦点元素，则改为调用 `reveal` 而不隐藏（[packages/client/ui-chat/src/client/chat/searchable-hidden.ts:14-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/searchable-hidden.ts#L14-L20)）
- 隐藏时设置 `hidden="until-found"` 属性，取消隐藏时移除该属性（[packages/client/ui-chat/src/client/chat/searchable-hidden.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/searchable-hidden.ts#L21-L22)）
- 监听 `beforematch` 事件在浏览器查找命中时调用 `reveal`，卸载时移除监听（[packages/client/ui-chat/src/client/chat/searchable-hidden.ts:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/searchable-hidden.ts#L24-L29)）

### packages/client/ui-chat/src/client/chat/token-format.ts

token 数字与缓存命中率的格式化函数，被统计行和每轮用量披露共用。

- `formatTokens` 千以下直出，千与百万区间套用对应模板，且百以上取整、百以下保留一位小数（[packages/client/ui-chat/src/client/chat/token-format.ts:9-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/token-format.ts#L9-L15)）
- `formatExactTokens` 从右往左每三位切段，用本地化的分组分隔符连接（[packages/client/ui-chat/src/client/chat/token-format.ts:23-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/token-format.ts#L23-L30)）
- `roundedPercentUnits` 用整数二分查找定位百分比单位，全程避免浮点并让正向平局进位（[packages/client/ui-chat/src/client/chat/token-format.ts:33-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/token-format.ts#L33-L50)）
- `formatCacheHitPercent` 在分母为零时返回 null，在完全命中时返回 `100`（[packages/client/ui-chat/src/client/chat/token-format.ts:67-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/token-format.ts#L67-L74)）
- 部分命中若按给定精度会舍入到 100，则自动追加小数位直到能与满命中区分，并输出 `99.9…x` 形式（[packages/client/ui-chat/src/client/chat/token-format.ts:76-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/token-format.ts#L76-L97)）

### packages/client/ui-chat/src/client/chat/turn-assistant.ts

从助手内容块里取可见正文的小工具，被轮次尾行的复制动作使用。

- 只挑出 `text` 类型块并拼接，其余块丢弃（[packages/client/ui-chat/src/client/chat/turn-assistant.ts:8-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/turn-assistant.ts#L8-L10)）

### packages/client/ui-chat/src/client/chat/use-calendar-day.ts

组件本地的日历日 Hook，让被 memo 的消息行在跨越本地午夜后仍能更新时钟。

- 初始值取当前时刻的本地零点（[packages/client/ui-chat/src/client/chat/use-calendar-day.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/use-calendar-day.ts#L13)）
- 定时器在每个本地午夜触发后写入新的日值并重新排下一次，卸载时清除定时器（[packages/client/ui-chat/src/client/chat/use-calendar-day.ts:14-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/use-calendar-day.ts#L14-L23)）

### packages/client/ui-chat/src/client/chat/use-throttled-visual-update.ts

按帧节流的视觉对齐调度 Hook。

- 每次渲染都把最新的 update 回调写进 ref，调度器执行时用的是最新版本（[packages/client/ui-chat/src/client/chat/use-throttled-visual-update.ts:16-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/use-throttled-visual-update.ts#L16-L17)）
- 卸载时取消尚未触发的动画帧（[packages/client/ui-chat/src/client/chat/use-throttled-visual-update.ts:20-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/use-throttled-visual-update.ts#L20-L24)）
- 已有待触发帧时新的调度请求被直接忽略，否则连续跨过指定帧数后才执行一次更新（[packages/client/ui-chat/src/client/chat/use-throttled-visual-update.ts:26-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/chat/use-throttled-visual-update.ts#L26-L39)）

### packages/client/ui-chat/src/client/contract/assistant-content.ts

判断助手内容块里是否存在面向用户的回复内容的谓词。

- 推理块与工具调用块一律不算回复内容，文本块须去空白后非空，其余块一律算（[packages/client/ui-chat/src/client/contract/assistant-content.ts:9-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/assistant-content.ts#L9-L15)）

### packages/client/ui-chat/src/client/contract/chat-nodes.ts

Chat 最终渲染节点的类型契约文件，含可合并扩展的 kind→载荷映射，另有两个运行期谓词。

- `isSettledTool` 以 `kind` 字段是否存在把工具根块窄化为已结束结果（[packages/client/ui-chat/src/client/contract/chat-nodes.ts:118-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/chat-nodes.ts#L118-L120)）
- `isRunningTool` 取其反面，把工具根块窄化为仍在运行（[packages/client/ui-chat/src/client/contract/chat-nodes.ts:127-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/chat-nodes.ts#L127-L129)）

### packages/client/ui-chat/src/client/contract/slots.ts

Chat 自有的插槽声明与组合式组件 props 类型，全部为类型与 `declare module` 合并。

- 无运行期机制

### packages/client/ui-chat/src/client/contract/snapshot.ts

Chat 快照的类型契约，并给出视图构建器注册前使用的空快照常量。

- `EMPTY_CHAT_SNAPSHOT` 提供全部读取接口的空实现：节点按 key 查恒为 undefined、各索引返回共享空数组、legacy 分片为空（[packages/client/ui-chat/src/client/contract/snapshot.ts:76-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/snapshot.ts#L76-L101)）

### packages/client/ui-chat/src/client/contract/store.ts

Chat 视图与详情面板共享的选择态类型声明。

- 无运行期机制

### packages/client/ui-chat/src/client/contract/turn-metrics.ts

轮次延迟与吞吐的折叠函数，被轮次尾行与统计行共用。

- `usageOutputTokens` 只接受对象里有限且非负的数字 `outputTokens`，否则给 null（[packages/client/ui-chat/src/client/contract/turn-metrics.ts:29-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/turn-metrics.ts#L29-L33)）
- `assistantStepReading` 分别用首 token 时刻减步起始时刻得 ttft、用完成时刻减首 token 时刻得解码时长，缺失记录时为 null（[packages/client/ui-chat/src/client/contract/turn-metrics.ts:40-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/turn-metrics.ts#L40-L49)）
- `deriveTurnMetrics` 按轮聚合，遇到更小 step 号时用它的 ttft 覆盖，解码时长与输出 token 只在同时存在时累加（[packages/client/ui-chat/src/client/contract/turn-metrics.ts:70-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/turn-metrics.ts#L70-L88)）
- 折叠结果里吞吐仅在采样过且解码时长为正时给出，两项皆无的轮次不写进结果表（[packages/client/ui-chat/src/client/contract/turn-metrics.ts:89-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/turn-metrics.ts#L89-L96)）

### packages/client/ui-chat/src/client/contract/turn-process.ts

轮次过程窗口的规格编解码与判定函数。

- 一份固定的 kind 列表被转成集合，标记哪些 Chat 节点不受轮次过程折叠影响（[packages/client/ui-chat/src/client/contract/turn-process.ts:26-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/turn-process.ts#L26-L39)）
- `turnProcessGeneration` 只用轮号与最终答复 step 拼出代际标识，不含排序锚点（[packages/client/ui-chat/src/client/contract/turn-process.ts:46-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/turn-process.ts#L46-L48)）
- `encodeTurnProcess` 把九个字段用竖线连成字符串，null 编码为空段、布尔编码为 1/0（[packages/client/ui-chat/src/client/contract/turn-process.ts:55-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/turn-process.ts#L55-L67)）
- `decodeTurnProcess` 按同一顺序切分还原，空段还原为 null、`'1'` 还原为真（[packages/client/ui-chat/src/client/contract/turn-process.ts:74-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/turn-process.ts#L74-L90)）
- `isSubagentDelegationTool` 把名为 `subagent` 或以 `subagent_` 开头的工具调用判为子代理委派（[packages/client/ui-chat/src/client/contract/turn-process.ts:98-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/contract/turn-process.ts#L98-L100)）

### packages/client/ui-chat/src/client/conversation-nodes/assistant.ts

每个 step 的助手节点定义：把流式分片、最终消息与中断证据折叠成一条助手行，并注册到会话节点注册表。

- `blockIsVisible` 规定工具调用块永不可见、文本与推理块去空白后非空才可见，其余块默认可见（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:67-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L67-L71)）
- `hasInterruptionEvidence` 用比可见性更宽的判据决定中断态是否值得留下一条合成节点（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:83-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L83-L88)）
- `resetForRetry` 在遇到重试时清空块与可见计数，只保留首 token 时刻，并把该步标记为隐藏（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:90-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L90-L96)）
- `updateChunk` 按 chunk 类型分派：block-start 建空块、文本/推理 delta 追加文本、工具调用 delta 累积 id/name/参数原文、block-end 用完整块覆盖、usage 只更新用量（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:98-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L98-L148)）
- 每次分片更新用变更前后可见性做增量维护可见块计数，可见数转正即解除隐藏，并首次记下首个可见事件的 seq/time 与首 token 时刻（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:149-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L149-L164)）
- `chunkRunBoundaries` 在一整行压缩分片内按 `dt` 逐段推进时间，定位首 token 时刻与首个可见片段的 seq（起始 seq 加片段下标）（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:172-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L172-L199)）
- `updateChunkRun` 把整行的文本/推理/工具参数一次性合并进目标块，并同样增量维护可见计数与隐藏标志（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:201-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L201-L247)）
- `closedBoundary` 优先取已关闭 step 的结束点，否则取已关闭 turn 的结束点（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:249-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L249-L258)）
- 有 `assistant/message` 时最终节点直接取其 seq、messageId、内容与用量，并写入由步起始/首 token/完成三时刻构成的 timing，事件带 `interrupted` 则透传（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:260-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L260-L283)）
- 无最终消息但边界已关闭且有中断证据时，合成一条 seq 为边界 seq 加固定负偏移的中断助手节点（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:284-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L284-L297)）
- `fallbackState` 在没有增量状态时按顺序重放全部匹配事件重建状态，包括重试导致的重置（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:300-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L300-L331)）
- `projectAssistant` 定出 running/settled/interrupted 三态，锚点 seq 依次回落到最终节点 seq、首个可见 seq、首个匹配事件 seq、0（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:340-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L340-L365)）
- `match` 把 `step/start` 认作 start，把 `assistant/chunk`、追加面的 `assistant/message`、整行分片事件与 `llm/retry` 认作同一 `turn:step` 标识的 update（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:371-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L371-L384)）
- `start` 在事件不是 `step/start` 时抛错（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:385-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L385-L388)）
- `assistant/message` 到达时用最终内容整体替换块列表、重算可见计数、解除隐藏并记下用量与最终匹配（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:394-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L394-L404)）
- `publication` 决定发布节奏：`step/start` 不发布，整行分片与普通 delta 按动画帧发布，`usage`/`finish` 分片不发布，其余立即发布（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:410-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L410-L416)）
- `buildLocationData` 只在 step 作用域下把投影结果挂到 `assistant-step` 键上（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:417-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L417-L428)）
- `buildViewNode` 对未结束且不可见的步：仅当状态被标记隐藏且当前 chat 目标已有该节点时才保留，否则返回 null；中断或可见时节点可见，其余标记 hidden（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:429-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L429-L441)）
- `registerAssistantConversationNode` 把该定义注册进会话事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/assistant.ts:448-450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/assistant.ts#L448-L450)）

### packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts

Chat 目标的增量快照构建器：维护键控节点仓、位置索引、轮次导航索引、引用标签投影与兼容用的 legacy 分片，并注册为 `chat` 视图定义。

- `MutableChatNodeStore` 用脏标记缓存 `values()` 结果，`upsert` 时同引用节点被跳过、有变更才置脏（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:25-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L25-L58)）
- 位置索引按渲染顺序把节点 key 归到轮与步两级桶里，缺位置或缺轮号的节点被跳过（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:72-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L72-L91)）
- `touch` 在成员内容变化但位置未动时，用复制数组的方式换掉受影响轮与步的数组引用（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:93-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L93-L113)）
- `updateIndex` 在逐元素引用相同时沿用旧数组以保持引用稳定，并丢掉变空的键（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:116-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L116-L129)）
- 导航索引的 `rebuild` 按时间线轮序重算全部条目，逐项等值时复用旧对象，整体等值时连数组引用一起保留（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:146-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L146-L166)）
- 导航索引的 `touch` 只重算被指定轮次集合命中的条目，且集合为空时直接返回（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:168-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L168-L183)）
- `turnProcessPresentations` 先收集各轮的过程控制节点，再取该轮控制锚点之前的最早 user/steering 锚点，以及最早的非独立类节点锚点（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:202-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L202-L232)）
- `presentationPosition` 把排在开场人类输入之前的非独立类节点重定位到该锚点并给 rank 2，把过程控制节点放到 rank 1 或（无开场输入时）最早过程锚点上的 rank -1（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:240-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L240-L269)）
- `orderedVisibleChatNodes` 先滤掉非 visible 节点，再按锚点、rank、原锚点、key 四级比较排序（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:278-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L278-L291)）
- 跨会话召回的标签被归到 `seq - 1` 的那条直接消息上（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:300-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L300-L310)）
- `withReferenceLabels` 在标签集合未变时原样返回旧节点，否则复制 data 并按标签数决定写入还是删除 `referenceLabels` 字段（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:312-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L312-L325)）
- `ReferenceLabelProjector.apply` 只重算受本批 upsert 影响的消息 seq，缺席节点从仓里取回后再补标签（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:351-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L351-L383)）
- `legacyContribution` 对非 visible 节点一律不贡献，唯独 `assistant-step` 例外以保住已结束但无内容的步计数（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:400-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L400-L405)）
- 各 kind 分别贡献：普通消息类贡献自身 data，running 助手贡献 partial、settled 贡献最终节点，工具根按运行/结束分别进 running 与 nodes，手动压缩贡献命令加压缩两条，重试贡献全部尝试（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:406-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L406-L455)）
- `turn-tail` 与 `system-prompt` 明确不贡献任何 legacy 时间线内容，未知 kind 也走同一空贡献（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:456-462](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L456-L462)）
- `LegacySliceBuilder.apply` 逐节点比较贡献，只有真正变化的类别才触发对应的重建，三个索引分别按有无 nodes/running/partial 增删（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:508-536](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L508-L536)）
- 已结束节点按 seq 排序、运行中调用与 partial 按锚点排序且 partial 取最后一个，结果引用相同时不替换（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:538-559](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L538-L559)）
- `updateTimeline` 在时间线对象引用未变时直接返回，否则从中重建轮次起止时间表与轮末 seq 表（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:561-577](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L561-L577)）
- `replace` 全量重建：先补引用标签，替换节点仓，重排可见顺序，重建位置与导航索引，并记下时间线（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:645-656](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L645-L656)）
- `apply` 按 kind、锚点、可见性、位置身份四项判断某个 upsert 是否属于结构性变化，只有结构性变化才重排顺序并重建位置索引，其余走 `touch`（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:658-689](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L658-L689)）
- 导航索引只在结构变化或时间线对象换了引用时全量重建，否则只重算内容变更节点所属的轮次（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:682-686](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L682-L686)）
- 视图定义的 `isActive` 规定：顺序里只要存在一个非 `command` 的节点，该 Chat 目标即视为活跃（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:722-726](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L722-L726)）
- `registerChatConversationView` 把该视图定义注册进会话视图注册表（[packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts:732-734](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/chat-snapshot-builder.ts#L732-L734)）

### packages/client/ui-chat/src/client/conversation-nodes/command.ts

斜杠命令生命周期的节点定义，同时承担手动压缩命令与压缩事务的关联，并对外导出压缩检查点识别函数。

- `commandFromRun` 从 `command/run` 取出命令标识、名称与参数，结果先置空（[packages/client/ui-chat/src/client/conversation-nodes/command.ts:37-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/command.ts#L37-L49)）
- `commandFromDone` 仅在成功且 `sourceEventSeq` 是非负安全整数时保留该字段，seq/time/name/args 优先沿用先前节点（[packages/client/ui-chat/src/client/conversation-nodes/command.ts:51-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/command.ts#L51-L72)）
- `compactSource` 只认替换面的 `user/message`，且其 source 须是 plugin 类、插件名为 `compact`、`compactionId` 为字符串（[packages/client/ui-chat/src/client/conversation-nodes/command.ts:79-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/command.ts#L79-L95)）
- `compactSummary` 把摘要块的文本拼接后去空白判空，并对 `shadowedSeqs` 与 `shadowedTokenCount` 做安全整数校验，节点的 seq/time 取自检查点事件（[packages/client/ui-chat/src/client/conversation-nodes/command.ts:103-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/command.ts#L103-L133)）
- `fallbackState` 在没有 `command/run` 时用检查点事件的 seq/time 与来源命令 id 造一条名为 `compact` 的命令（[packages/client/ui-chat/src/client/conversation-nodes/command.ts:135-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/command.ts#L135-L158)）
- `updateCompactionState` 把摘要与检查点两类证据折进状态，其他匹配不改变状态引用（[packages/client/ui-chat/src/client/conversation-nodes/command.ts:166-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/command.ts#L166-L173)）
- `match` 用 commandId 归并：`command/run` 为 start，`command/done`、带来源命令的压缩检查点、以及带 `sourceCommandId` 的压缩生命周期事件为 update（[packages/client/ui-chat/src/client/conversation-nodes/command.ts:179-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/command.ts#L179-L198)）
- `buildViewNode` 对非 `compact` 命令产出 `command` 节点，对 `compact` 产出 `manual-compaction` 节点且锚点优先取压缩标记的 seq（[packages/client/ui-chat/src/client/conversation-nodes/command.ts:206-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/command.ts#L206-L217)）
- `registerCommandConversationNode` 把该定义注册进会话事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/command.ts:224-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/command.ts#L224-L226)）

### packages/client/ui-chat/src/client/conversation-nodes/common.ts

各 Chat 节点定义共用的合成 seq 偏移量、位置解析与节点构造函数。

- 五个合成 seq 偏移量把中断助手、其后续、过程控制、超长提示与最终后续排到同一个 seq 邻域内的固定相对位置（[packages/client/ui-chat/src/client/conversation-nodes/common.ts:14-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/common.ts#L14-L20)）
- `contextLocation` 依次回落到 start 匹配的位置、首个匹配的位置、`unresolved`（[packages/client/ui-chat/src/client/conversation-nodes/common.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/common.ts#L27-L29)）
- `chatNode` 用上下文的 key 与 id 构造 chat 目标节点，位置与可见性可被选项覆盖、默认可见（[packages/client/ui-chat/src/client/conversation-nodes/common.ts:40-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/common.ts#L40-L60)）
- `coordinate` 只接受非负安全整数，否则返回 undefined（[packages/client/ui-chat/src/client/conversation-nodes/common.ts:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/common.ts#L67-L69)）

### packages/client/ui-chat/src/client/conversation-nodes/compaction.ts

自动压缩生命周期与落地检查点的节点定义，复用命令文件里的检查点识别与摘要构造。

- `fallbackState` 从匹配列表里各找一条摘要与一条检查点重建状态（[packages/client/ui-chat/src/client/conversation-nodes/compaction.ts:22-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/compaction.ts#L22-L29)）
- `match` 只接手没有 `sourceCommandId` 的检查点，并把带 `sourceCommandId` 的压缩事件让给命令定义（[packages/client/ui-chat/src/client/conversation-nodes/compaction.ts:35-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/compaction.ts#L35-L43)）
- 压缩事件的 `compactionId` 必须是非空字符串才被匹配，`compaction/start` 记为 start、其余记为 update（[packages/client/ui-chat/src/client/conversation-nodes/compaction.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/compaction.ts#L44-L47)）
- 没有落地检查点时不产出任何视图节点，有则以标记的 seq 为锚点产出 `compaction` 节点（[packages/client/ui-chat/src/client/conversation-nodes/compaction.ts:52-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/compaction.ts#L52-L57)）
- `registerCompactionConversationNode` 把该定义注册进会话事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/compaction.ts:64-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/compaction.ts#L64-L66)）

### packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts

把持久化会话事件投影成 Chat 视图数据的转换函数集合。

- `collect` 从数组成员里按字段抽字符串并按首次出现顺序去重（[packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts:21-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts#L21-L31)）
- `contextForm` 只承认六个已知形态字符串，其余一律返回 null 走不透明呈现（[packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts:38-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts#L38-L53)）
- `contextProvenance` 按 source 的 kind 分派角色与标签：会话引用为 recall 并取引用 label，代理指令取变更路径，插件取插件名，技能调用取技能名，未知 kind 保留其字面值（[packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts:60-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts#L60-L78)）
- `sessionRecallLabels` 仅对 `session-reference` 类来源返回引用标签，其余返回空数组（[packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts:85-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts#L85-L89)）
- `toAssistantBlock` 把 text/reasoning/image/tool-call 四类内容块映射为对应 Chat 块，其余包成 `other` 保留原块（[packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts:105-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts#L105-L113)）
- `emptyAssistantBlock` 为流式块类型建立初始空块，未知类型建成 `other` 且内容为 null（[packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts:120-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts#L120-L127)）
- `displayFailure` 在错误码为 `AUTH` 时把消息置空只留错误码，其余情况保留字符串消息或对整个失败对象做 JSON 序列化（[packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts:140-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts#L140-L151)）
- `isTokenDelta` 规定文本与推理 delta 须非空、工具调用 delta 须有参数增量或名称，才算一次可见输出（[packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts:158-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/event-projection.ts#L158-L168)）

### packages/client/ui-chat/src/client/conversation-nodes/fallback.ts

未被任何定义认领的追加面事件的兜底节点定义。

- `match` 显式排除三类整行分片事件，其余追加面事件按自身 seq 各起一条（[packages/client/ui-chat/src/client/conversation-nodes/fallback.ts:18-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/fallback.ts#L18-L23)）
- `start` 原样保留事件的 type 与 data 作为节点内容（[packages/client/ui-chat/src/client/conversation-nodes/fallback.ts:24-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/fallback.ts#L24-L30)）
- `buildViewNode` 在无状态时返回 null，否则以事件 seq 为锚点产出 `unknown` 节点（[packages/client/ui-chat/src/client/conversation-nodes/fallback.ts:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/fallback.ts#L32-L34)）
- 该定义走 `registerFallback` 注册，只在没有其他定义认领时生效（[packages/client/ui-chat/src/client/conversation-nodes/fallback.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/fallback.ts#L41-L43)）

### packages/client/ui-chat/src/client/conversation-nodes/inbox.ts

两个收件箱拼接事件的累积状态定义，供消息定义判定一条用户消息是否属于引导。

- `applySplice` 在上一份状态基础上做数组 splice，插入项从 claimed 集合中移除（[packages/client/ui-chat/src/client/conversation-nodes/inbox.ts:25-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/inbox.ts#L25-L32)）
- 只有目标为 `next-step` 且结果不是 canceled 时，被移除的条目才被记入 claimed 集合（[packages/client/ui-chat/src/client/conversation-nodes/inbox.ts:33-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/inbox.ts#L33-L36)）
- 定义按 target 过滤 `agent/inbox/spliced` 事件，每条事件用自身 seq 作为独立标识（[packages/client/ui-chat/src/client/conversation-nodes/inbox.ts:43-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/inbox.ts#L43-L46)）
- `start` 通过 reader 读取同 kind 的上一份状态作为累积基点，事件类型不符时抛错（[packages/client/ui-chat/src/client/conversation-nodes/inbox.ts:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/inbox.ts#L47-L50)）
- `publication` 恒为 `none`，该状态不触发任何视图发布（[packages/client/ui-chat/src/client/conversation-nodes/inbox.ts:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/inbox.ts#L52)）
- 注册函数把 next-turn 与 next-step 两个定义都注册进会话事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/inbox.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/inbox.ts#L66-L69)）

### packages/client/ui-chat/src/client/conversation-nodes/message.ts

用户消息、引导消息与注入上下文三类节点的分类定义。

- `isCompactionCheckpoint` 把替换面上来自 `compact` 插件的 `user/message` 识别为压缩检查点（[packages/client/ui-chat/src/client/conversation-nodes/message.ts:32-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/message.ts#L32-L36)）
- `match` 只接手追加面且非压缩检查点的 `user/message`，标识取消息 id（[packages/client/ui-chat/src/client/conversation-nodes/message.ts:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/message.ts#L42-L46)）
- 来源不是 `user` 的消息成为 `context` 节点，并附带由来源投影出的产出方与呈现形态（[packages/client/ui-chat/src/client/conversation-nodes/message.ts:50-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/message.ts#L50-L60)）
- 用户来源的消息按 `inbox-next-step` 状态的 claimed 集合里是否含该消息 id，分成 `steering` 与 `user` 两类，前者额外带 messageId（[packages/client/ui-chat/src/client/conversation-nodes/message.ts:61-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/message.ts#L61-L78)）
- `buildViewNode` 以状态自身的 kind 作为渲染键、以事件 seq 为锚点产出节点（[packages/client/ui-chat/src/client/conversation-nodes/message.ts:80-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/message.ts#L80-L83)）
- `registerMessageConversationNode` 把该定义注册进会话事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/message.ts:90-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/message.ts#L90-L92)）

### packages/client/ui-chat/src/client/conversation-nodes/partial.ts

浏览器 Chat 目标里把模型流式 chunk 折叠成部分助手投影的累加器，被 Chat 快照构建路径消费。

- `isVisibleAssistantChunk` 只把 block-start、text-delta、reasoning-delta、tool-call-delta、block-end 五类 chunk 判为会改变可见投影（[packages/client/ui-chat/src/client/conversation-nodes/partial.ts:10-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/partial.ts#L10-L16)）
- 构造函数以历史重放得到的已物化块前缀初始化块数组与初始快照（[packages/client/ui-chat/src/client/conversation-nodes/partial.ts:30-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/partial.ts#L30-L37)）
- `block-start` 在 chunk 自带的 index 位置写入一个空块（[packages/client/ui-chat/src/client/conversation-nodes/partial.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/partial.ts#L46-L50)）
- `text-delta` 把增量文本拼到同 index 的文本块尾部，前块类型不符时从空串起算（[packages/client/ui-chat/src/client/conversation-nodes/partial.ts:51-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/partial.ts#L51-L56)）
- `reasoning-delta` 以同样方式累加推理文本（[packages/client/ui-chat/src/client/conversation-nodes/partial.ts:57-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/partial.ts#L57-L62)）
- `tool-call-delta` 累加原始参数串，并在 callId 为空时用 chunk 的 id 补齐、name 缺省沿用已有值（[packages/client/ui-chat/src/client/conversation-nodes/partial.ts:63-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/partial.ts#L63-L74)）
- `block-end` 用完整块覆盖该 index 上累加出的块（[packages/client/ui-chat/src/client/conversation-nodes/partial.ts:75-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/partial.ts#L75-L79)）
- 其余 chunk 类型返回 false，不触发订阅者通知（[packages/client/ui-chat/src/client/conversation-nodes/partial.ts:80-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/partial.ts#L80-L84)）
- `toPartial` 仅在有变更时重建快照，并把乱序 block-start 留下的空洞过滤掉压实成渲染顺序，否则返回同一引用（[packages/client/ui-chat/src/client/conversation-nodes/partial.ts:91-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/partial.ts#L91-L98)）

### packages/client/ui-chat/src/client/conversation-nodes/register.ts

Chat 目标的节点注册汇总入口，被浏览器端插件 apply 调用。

- 按固定先后顺序把 inbox、message、request-prompt、assistant、turn-process、tool、command、compaction、retry、turn-error、turn-max-tokens、turn-tail、未知回退这些 Definition 与 Chat 视图构建器注册进 UI Conversation 上下文（[packages/client/ui-chat/src/client/conversation-nodes/register.ts:21-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/register.ts#L21-L36)）

### packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts

把每次模型请求头里的系统提示词投影成 Chat 里一行 `system-prompt` 节点的 Definition。

- `requestPromptAnchor` 按 location 种类与前一次状态选取锚点 seq：非 step 位置或与上次同 turn/step 时用事件自身 seq，step 为 1 时优先用 turn 起点 seq，否则用 step 起点 seq（[packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts:23-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts#L23-L35)）
- 已渲染过的 system-prompt 节点复用其已有 anchorSeq，不随重算漂移（[packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts:38-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts#L38-L48)）
- `match` 只认 `request/header` 事件，并以事件 seq 为关联 id、角色恒为 start（[packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts:60-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts#L60-L62)）
- `start` 收到非 request/header 事件时抛错（[packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts:63-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts#L63-L66)）
- `start` 读取上一个 request-prompt 状态里的 prompt，交给注入的 inspect 得到本次请求的提示词解释与变化种类（[packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts:67-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts#L67-L72)）
- `showsPrompt` 只在无前序、reason 非 change、显式 startsSeries、或变化种类为 system / system-and-tools 时为真（[packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts:80-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts#L80-L84)）
- `buildViewNode` 在 showsPrompt 为假或 system 文本为空时返回 null，否则在锚点 seq 上产出携带完整 system 文本的 `system-prompt` 节点（[packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts:90-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts#L90-L94)）
- 注册时把 Definition 需要的 inspect 绑定成对 `ctx.uiConversation.inspectRequestPrompt` 的调用（[packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts:102-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/request-prompt.ts#L102-L106)）

### packages/client/ui-chat/src/client/conversation-nodes/retry.ts

把同一 RetryId 下的多次模型重试事件聚成一条重试链节点的 Definition。

- `scheduledNode` 从 `llm/retry` 事件构造 retryState 为 scheduled 的重试节点，并摊入事件数据（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:24-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L24-L33)）
- `isClosed` 以 step 或 turn 的 status 为 closed 判定所属边界已关闭（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L36-L39)）
- `match` 用事件里的 retryId 做关联 id，非字符串或空串一律不匹配；`llm/retry` 的第一次为 start、其余为 update（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:45-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L45-L50)）
- `llm/retry-started` 以同一 retryId 作为 update 匹配（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:51-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L51-L54)）
- `start` 在无法构造有效重试节点时抛错（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L57-L61)）
- `update` 对新的 `llm/retry` 追加一次 attempt（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:62-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L62-L66)）
- `update` 对 `llm/retry-started` 把 retry 序号相同的那次 attempt 状态改为 started（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:67-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L67-L74)）
- `buildViewNode` 在最后一次 attempt 仍为 scheduled 且所属 step/turn 已关闭时把它改判为 cancelled（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:75-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L75-L84)）
- 以首次 attempt 的 seq 作锚点产出携带全部 attempts 与 current 的 `model-retry` 节点（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:85-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L85-L88)）
- `registerRetryConversationNode` 把该 Definition 注册进 UI Conversation 事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/retry.ts:96-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/retry.ts#L96-L98)）

### packages/client/ui-chat/src/client/conversation-nodes/tool.ts

把根工具调用与其嵌套 Code Dispatch 子调用折成一棵递归树节点的 Definition。

- `MAX_DEPTH` 固定为 256，作为下面所有深度判定的上限（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L18)）
- 用 WeakMap 按块引用缓存投影结果，供后面按引用短路（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L33)）
- `rootCall` 从 `tool/call` 事件取 callId、name、原始参数串、turn/step、时间构造运行中的根调用，非该事件类型抛错（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:39-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L39-L50)）
- `rootResult` 从 `tool/result` 取第一个内容块作为结果内容，带上 isError、可选 error、meta，并把先前调用的 name/参数与发起时间挂回结果（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:52-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L52-L68)）
- `childCall` 与 `childResult` 从 dispatch 数据构造子调用与子结果，参数用 `JSON.stringify` 序列化（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:79-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L79-L105)）
- 子调用的 turn/step 从 match 的 location 取，location 无法定位时落到 0（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:107-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L107-L113)）
- `acceptsEdge` 拒绝自环、已有父的子节点、会构成祖先环的边，并在父深度加子树深度超过 MAX_DEPTH 时拒绝（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:115-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L115-L138)）
- `tool/code-dispatch-start` 在子调用尚未存在且边被接受时追加子调用并记下父指针，否则整个事件被丢弃（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:148-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L148-L155)）
- `tool/code-dispatch` 用结算结果替换同 id 的子调用，未见过 start 时直接追加并补记父指针（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:156-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L156-L165)）
- `projectBlock` 在重复访问同一 callId 或深度超过 MAX_DEPTH 时把该块的子调用清空后返回（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L175)）
- 投影缓存在中断 seq/时间与子数组引用都不变时直接返回上次的同一对象（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:182-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L182-L188)）
- 仍在运行的调用遇到已关闭的边界时被合成为一条 `interrupted` 错误结果，seq 用中断点 seq 加上固定合成偏移（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:189-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L189-L205)）
- `interruption` 取已关闭 step 的 end，否则取已关闭 turn 的 end，都未关闭则无中断点（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:212-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L212-L219)）
- 没有累积状态时 `fallbackState` 从匹配到的 `tool/result` 重建根，再重放全部 dispatch 匹配（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:221-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L221-L228)）
- `match` 用 `tool/call` 的 callId 开链，只接受通过 append surface 判定的 `tool/result`，dispatch 事件按 rootCallId 归到根链且空 id 不匹配（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:234-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L234-L246)）
- `update` 遇到 `tool/result` 时用结算结果替换根块，其余事件走 dispatch 折叠（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:248-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L248-L255)）
- `buildViewNode` 依次用 start 事件 seq、结算根的 seq、首个匹配事件 seq、0 作锚点，产出携带投影后根块的 `tool-call` 节点（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:256-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L256-L263)）
- `registerToolConversationNode` 把该 Definition 注册进 UI Conversation 事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/tool.ts:270-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/tool.ts#L270-L272)）

### packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts

把以错误收尾的一轮投影成一行终止失败节点的 Definition。

- `lastStep` 从 location 取该轮最后一个 step 号，location 不是 turn/step 时用 0（[packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts:26-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts#L26-L30)）
- `failureFrom` 只接受 reason.kind 为 error 的 `turn/end`，经 `displayFailure` 得到展示用 message 与可选 code（[packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts#L32-L42)）
- 无累积状态时 `fallbackState` 从匹配列表里找出失败的 `turn/end` 重建状态（[packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts#L44-L50)）
- `match` 用 `turn/start` 的轮号开链，只有 reason 为 error 的 `turn/end` 作为 update 进入（[packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts:60-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts#L60-L66)）
- `start` 在起始事件不是 `turn/start` 时抛错（[packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts:67-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts#L67-L70)）
- `update` 只在解析出 failure 时改写状态，否则保持原状态对象（[packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts:71-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts#L71-L74)）
- `buildViewNode` 无 failure 时返回 null，否则以失败事件 seq 为锚产出带 turn、step、message 与可选 code 的 `turn-error` 节点（[packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts:75-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts#L75-L89)）
- `registerTurnErrorConversationNode` 把该 Definition 注册进 UI Conversation 事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts:96-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-error.ts#L96-L98)）

### packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts

把因输出 token 上限而结束的一轮投影成一条提示节点的 Definition。

- `lastStep` 从 location 取该轮最后一个 step 号，无法定位时用 0（[packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts:21-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts#L21-L25)）
- `noticeAnchor` 在该轮 turn-tail 数据里存在 closing 助手时，把提示锚到 closing 最终节点 seq 加固定偏移，否则用 `turn/end` 的 seq（[packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts:33-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts#L33-L40)）
- `stateFrom` 只接受 reason.kind 为 max-tokens 的 `turn/end`（[packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts:42-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts#L42-L45)）
- `match` 只对 max-tokens 的 `turn/end` 以轮号开链，其余事件一律不匹配（[packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts:51-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts#L51-L56)）
- `start` 在事件不满足条件时抛错（[packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts#L57-L61)）
- `buildViewNode` 产出带 turn 与最后 step 的 `turn-max-tokens` 节点，并放在 `noticeAnchor` 计算出的位置（[packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts:63-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts#L63-L74)）
- `registerTurnMaxTokensConversationNode` 把该 Definition 注册进 UI Conversation 事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts:81-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-max-tokens.ts#L81-L83)）

### packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts

把一轮里已载入的 Chat 节点投影成轮次导航条目的纯函数模块。

- `PREVIEW_LIMIT` 固定为 160 字符，作为导航预览的字段预算（[packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts#L9)）
- `preview` 边拼接边检查预算，够长即停止继续读取，再折叠空白并截到上限（[packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts:12-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts#L12-L19)）
- `promptText` 只从 user 节点的 text 块取预览文本（[packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts:21-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts#L21-L24)）
- `responseText` 只从 assistant-step 节点的 text 块取预览文本（[packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts#L26-L29)）
- `sameTurnNavigationItem` 按 turn、anchorKey、prompt、response 四项判等，使读者在无变化时保留原数组（[packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts:37-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts#L37-L44)）
- `turnNavigationItem` 只收 visibility 为 visible 的已载入节点，优先以 user 节点作跳转锚点、否则用首个节点，无可见节点时返回 undefined，响应取最后一个有文本的节点（[packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts:53-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-navigation.ts#L53-L71)）

### packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts

按轮计算"过程内容"区间与最终答案边界，并把它写成 turn 级数据与一个折叠控制节点的 Definition。

- `isChunkRunEvent` 把三类 chunkrow 事件识别为流式行事件（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L43-L47)）
- `eventTurn` 从事件 data 上按运行期类型读 turn 号（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:49-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L49-L52)）
- `visibleAssistantEvent` 把纯空白的文本/推理增量、tool-call 块以及 usage/finish 一类 chunk 排除在"可见助手输出"之外（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:54-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L54-L76)）
- `processEvidence` 对 chunkrow 忽略 tool-call 行，并把首个非空文本的下标加到行事件 seq 上作为该 step 的助手起点（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:82-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L82-L89)）
- `processEvidence` 把 `tool/call`、通过 append surface 判定的 `tool/result`、`llm/retry` 记为非助手类过程证据（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:94-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L94-L97)）
- 无累积状态时 `fallbackState` 从匹配事件里取出 turn 号并逐条重放重建状态（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:105-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L105-L117)）
- `latestAnswer` 只把该轮最后一个 step 上已终结、有回复内容且不含 tool-call 块的助手数据算作最终答案（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:125-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L125-L130)）
- `processSpec` 以非助手起点与各 step 助手起点的最小 seq 作控制锚点，取不到有限值时整体返回 null（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:132-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L132-L137)）
- 消息计数在有答案时只累计 step 小于答案 step 的部分，无答案时累计全部（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:139-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L139-L147)）
- 无最终答案时 processStartSeq 等于控制锚点，答案锚点与答案 step 置空、inlineReasoning 为 false（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:148-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L148-L158)）
- 有答案时按答案块里是否含非空 reasoning 决定 inlineReasoning，并把过程起点定为 turn 起点 seq、否则更早的外部过程 seq、否则答案节点 seq（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:159-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L159-L178)）
- `updateProcessState` 对有回复内容的 append 型 `assistant/message` 按 step 累加消息计数（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:181-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L181-L189)）
- `tool/call` 按是否为 subagent 委派工具分别计入 subagentCount 或 toolCallCount（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:190-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L190-L197)）
- 非助手起点与每个 step 的助手起点都只记录首次出现的 seq，后续同类证据被忽略（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:198-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L198-L206)）
- `match` 用 `turn/start` 开链，并把助手、chunkrow、工具、重试、step 与 turn 结束事件按轮号收进同一条链（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:213-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L213-L229)）
- `start` 在起始事件不是 `turn/start` 时抛错（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:230-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L230-L239)）
- `publication` 把 chunkrow 与助手 chunk 的发布压到动画帧节流，usage/finish 类 chunk 完全不发布，其余立即发布（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:241-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L241-L248)）
- `buildLocationData` 只在 turn 作用域下把编码后的过程签名写到该轮的 `turn-process` 键上（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:249-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L249-L262)）
- `buildViewNode` 从 turn 数据解码签名，并把控制节点放在控制锚点加固定偏移的位置（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:263-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L263-L274)）
- `registerTurnProcess` 把该 Definition 注册进 UI Conversation 事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts:281-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-process.ts#L281-L283)）

### packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts

为已结束的一轮生成尾部数据（收尾助手、分支可用性、耗时与 token 用量）并投影成尾行节点的 Definition。

- `isSessionEvent` 把三类 chunkrow 事件从会话事件里排除，只有真正的会话事件进入 token 用量推导（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L40-L44)）
- `hasTextAssistant` 只认 append surface 且含非空 text 块的 `assistant/message`（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:46-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L46-L51)）
- `chunkHasText` 只把非空的文本行、text-delta 与 text 类型 block-end 判为有文本，推理与工具调用行一律为假（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:53-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L53-L65)）
- `turnCoordinates` 从助手、chunkrow、step 与重试事件读出 turn/step 坐标，其余事件无坐标（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:67-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L67-L84)）
- `closingAnchor` 默认取 `turn/end` 的 seq，退化时依次用起始事件与首个匹配事件的 seq，最后落到 0（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:86-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L86-L90)）
- 逐 step 记录"是否流过文本""是否已终结"，遇到含文本的 `assistant/message` 就把锚点移到该事件 seq 加终结后继偏移，遇到 `llm/retry` 则把该 step 的证据清零（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:91-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L91-L118)）
- 某 step 只流过文本却没有终结消息就 `step/end` 时，锚点改用该 seq 加中断后继偏移（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:119-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L119-L123)）
- `tailData` 在缺少 `turn/end` 或缺少 turn location 时返回 null，不产出尾部数据（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:136-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L136-L141)）
- 收集各 step 已终结的助手数据，按最终节点 seq 排序，取最后一个含非空文本者为收尾助手（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:142-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L142-L148)）
- 用 `tool/call`、append 型 `tool/result`、error 型 `turn/end`、`llm/retry` 的 seq 抬高"最新记录 seq"（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:149-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L149-L161)）
- 由已终结节点推导本轮 ttft 与 tokens/s，并在链自 `turn/start` 起时从会话事件推导 token 用量（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:162-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L162-L165)）
- 没有收尾助手、或最新记录 seq 不等于收尾助手最终节点 seq 时，把分支动作标为不可用（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:166-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L166-L175)）
- `match` 用 `turn/start` 开链，把 `turn/end`、工具事件以及一切带 turn 坐标的事件按轮号收进同一条链（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:182-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L182-L191)）
- `start` 在起始事件不是 `turn/start` 时抛错（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:192-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L192-L195)）
- `update` 只在 `turn/end` 时把该匹配记入状态，其余事件不改状态（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:196-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L196-L198)）
- `publication` 只让 `turn/end` 立即发布，其余匹配完全不触发发布（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L199)）
- `buildLocationData` 只在 turn 作用域下把尾部数据写到该轮的 `turn-tail` 键上（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:200-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L200-L209)）
- `buildViewNode` 从 turn 数据取尾部数据，并把尾行放在 `closingAnchor` 算出的位置（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:210-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L210-L214)）
- `registerTurnTailConversationNode` 把该 Definition 注册进 UI Conversation 事件注册表（[packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts:221-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/conversation-nodes/turn-tail.ts#L221-L223)）

### packages/client/ui-chat/src/client/details/DetailsPanel.module.css

详情面板的 CSS Module 样式表。

- 无运行期机制

### packages/client/ui-chat/src/client/details/DetailsPanel.tsx

第三栏详情面板组件，按当前选中的工具调用渲染输入与输出。

- `settledMaterial` 与 `runningMaterial` 把结算结果与运行中调用统一成同一份展示材料，结算结果缺 call 信息时用 callId 顶替名字（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:18-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L18-L30)）
- `pretty` 尝试把原始参数串按 JSON 重排缩进，解析失败时原样返回（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L32-L38)）
- `rawResultText` 把结算内容展平成文本，非 text 项转 JSON，内容为空且有 error 时输出 `name: code`（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:41-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L41-L46)）
- 从会话列表按 sessionId 读工作区根目录，随后传给工具卡片用于解析相对路径（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:49-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L49-L52)）
- 以浅比较订阅快照里选中 callId 对应的材料，未选中时订阅 null（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:53-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L53-L58)）
- 标题按"材料名 → 选中项自带工具名 → 默认标题"的顺序回退（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:61-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L61-L64)）
- 关闭按钮调用 `closeDetails` 收起面板（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L65-L72)）
- 未选中时显示空态，选中但调用不在已载入窗口内时显示不在窗口的提示（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L74-L78)）
- 只有存在原始参数串时才渲染输入区，并以 json 语言的代码块呈现（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:81-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L81-L86)）
- 输出区把块与工作区根交给 `conversation.details.tool` 插槽渲染，无卡片时结算结果落到纯文本 `pre`（带错误态标记）、运行中落到"运行中"提示（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:93-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L93-L103)）
- 输出区外层以 callId 作 React key，使切换选中调用时卡片内部的展开/复制等视图状态被重置（[packages/client/ui-chat/src/client/details/DetailsPanel.tsx:93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/DetailsPanel.tsx#L93)）

### packages/client/ui-chat/src/client/details/tool-node-reader.ts

从 Chat 快照的节点仓库里按 callId 找出根或嵌套工具调用的查找函数，供详情面板使用。

- `toolNode` 只把 kind 为 `tool-call` 的节点收作候选（[packages/client/ui-chat/src/client/details/tool-node-reader.ts:4-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/tool-node-reader.ts#L4-L6)）
- `findToolCall` 遍历快照全部节点，对每棵工具树深度优先递归匹配 callId，找不到时返回 undefined（[packages/client/ui-chat/src/client/details/tool-node-reader.ts:14-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/details/tool-node-reader.ts#L14-L30)）

### packages/client/ui-chat/src/client/index.ts

浏览器 Chat 目标插件的客户端入口模块，其余为类型与常量重导出。

- 重导出 `apply` 与 `inject`，构成该包被 Cordis 加载时执行的插件入口与依赖注入声明（[packages/client/ui-chat/src/client/index.ts:2](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/index.ts#L2)）

### packages/client/ui-chat/src/client/locale.ts

Chat 命名空间的中英双语文案词典，中文键集为准、英文按同键集校验。

- 无运行期机制

### packages/client/ui-chat/src/client/markdown-labels.ts

把 Chat 的 locale 取词函数适配成 Markdown 原语所需标签的小模块。

- `markdownLabels` 解析 copy / copied / footnotes 三个键，组成传给 Markdown 原语的完整标签对象（[packages/client/ui-chat/src/client/markdown-labels.ts:11-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/markdown-labels.ts#L11-L16)）

### packages/client/ui-chat/src/client/model/conversation-context.ts

模型上下文代际的类型声明文件。

- 无运行期机制

### packages/client/ui-chat/src/client/model/steering-history.ts

从事件化的 agent inbox 里重建"哪些 user/message 来自下一步插队"的重放器。

- 维护 next-turn 与 next-step 两条待处理队列以及一个"已从 next-step 认领"的 id 集合（[packages/client/ui-chat/src/client/model/steering-history.ts:26-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/steering-history.ts#L26-L32)）
- `reset` 在重建历史窗口前清空两条队列与认领集合（[packages/client/ui-chat/src/client/model/steering-history.ts:34-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/steering-history.ts#L34-L39)）
- `apply` 对 `agent/inbox/spliced` 只更新内部队列并返回 false（[packages/client/ui-chat/src/client/model/steering-history.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/steering-history.ts#L46-L50)）
- 只有既被认领过（并同时从集合中消费掉）又是 user 来源的 `user/message` 才被判为人工插队消息（[packages/client/ui-chat/src/client/model/steering-history.ts:51-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/steering-history.ts#L51-L55)）
- `applySplice` 按 start 与 removedCount 拼接队列，插入项一律从认领集合移除；只有 next-step 且 outcome 非 canceled 时才把被移除项记为已认领（[packages/client/ui-chat/src/client/model/steering-history.ts:57-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/steering-history.ts#L57-L63)）

### packages/client/ui-chat/src/client/model/tool-call-tree.ts

按会话事件配对 Code Dispatch 父子调用、并把私有父索引投影成递归工具树的类。

- `MAX_TOOL_CALL_TREE_DEPTH` 固定为 256，作为所有递归消费者的深度上限（[packages/client/ui-chat/src/client/model/tool-call-tree.ts:13-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/tool-call-tree.ts#L13-L14)）
- `reset` 清空父子索引、深度表与投影缓存并递增 revision，使所有缓存失效（[packages/client/ui-chat/src/client/model/tool-call-tree.ts:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/tool-call-tree.ts#L44-L50)）
- `tool/code-dispatch-start` 构造运行中的子调用；边被 `acceptEdge` 拒绝时事件仍算消费但不挂树（[packages/client/ui-chat/src/client/model/tool-call-tree.ts:57-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/tool-call-tree.ts#L57-L75)）
- `tool/code-dispatch` 构造结算结果，已有同 id 子调用则原位替换，否则追加；非这两类事件返回 false 交回调用方（[packages/client/ui-chat/src/client/model/tool-call-tree.ts:76-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/tool-call-tree.ts#L76-L102)）
- `projectNodes` 在源数组与 revision 都未变时直接返回缓存值，并在无根变化时返回原数组以保持引用（[packages/client/ui-chat/src/client/model/tool-call-tree.ts:109-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/tool-call-tree.ts#L109-L120)）
- `projectRunningCalls` 对运行中根调用做同样的缓存与结构共享（[packages/client/ui-chat/src/client/model/tool-call-tree.ts:127-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/tool-call-tree.ts#L127-L135)）
- `projectBlock` 递归把索引里的子调用挂到块上，并按块引用与子数组引用缓存，未变时返回原块（[packages/client/ui-chat/src/client/model/tool-call-tree.ts:137-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/tool-call-tree.ts#L137-L156)）
- `acceptEdge` 先拒环，再把新深度沿子树传播，任一节点深度超过上限即整条边被拒（[packages/client/ui-chat/src/client/model/tool-call-tree.ts:163-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/tool-call-tree.ts#L163-L183)）
- `wouldCreateCycle` 以自环判定加子树广度遍历检查父节点是否已在子孙中（[packages/client/ui-chat/src/client/model/tool-call-tree.ts:185-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/model/tool-call-tree.ts#L185-L198)）

### packages/client/ui-chat/src/client/settings/TranscriptViewRow.module.css

设置行的 CSS Module 样式表。

- 无运行期机制

### packages/client/ui-chat/src/client/settings/TranscriptViewRow.tsx

通用设置里控制已完成轮次过程内容呈现方式的一行选择器组件。

- 可选模式固定为 normal 与 compact 两项（[packages/client/ui-chat/src/client/settings/TranscriptViewRow.tsx:27-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/settings/TranscriptViewRow.tsx#L27-L30)）
- 组件从注入的偏好 store 读取当前模式（[packages/client/ui-chat/src/client/settings/TranscriptViewRow.tsx:37-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/settings/TranscriptViewRow.tsx#L37-L38)）
- 选中一项时先关闭菜单再调用 `setTranscriptView` 提交新模式（[packages/client/ui-chat/src/client/settings/TranscriptViewRow.tsx:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/settings/TranscriptViewRow.tsx#L43-L47)）
- 按钮点击切换菜单开合，菜单以当前模式为选中项并通过 portal 对齐渲染（[packages/client/ui-chat/src/client/settings/TranscriptViewRow.tsx:48-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/settings/TranscriptViewRow.tsx#L48-L76)）

### packages/client/ui-chat/src/client/stores.ts

每个会话作用域一份的 Chat 选中态与轮次过程展开态 store。

- `storedTurnProcessEntry` 按轮号查出已存的展开条目（[packages/client/ui-chat/src/client/stores.ts:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/stores.ts#L22-L27)）
- store 初始态为无选中、无展开轮次（[packages/client/ui-chat/src/client/stores.ts:34-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/stores.ts#L34-L35)）
- `select` 动作把选中目标写入草稿状态（[packages/client/ui-chat/src/client/stores.ts:37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/stores.ts#L37)）
- `setTurnProcessOpen` 在关闭时删除该轮条目，在打开时按轮号插入或整体替换成新的代际条目（[packages/client/ui-chat/src/client/stores.ts:38-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/stores.ts#L38-L47)）

### packages/client/ui-chat/src/client/transcript-view.ts

把 Host 侧持久化的转录呈现偏好桥接成客户端可订阅快照的策略类。

- 快照 store 以 `DEFAULT_TRANSCRIPT_VIEW_MODE` 为初值，在 Host 设置到达前就有确定取值（[packages/client/ui-chat/src/client/transcript-view.ts:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/transcript-view.ts#L11-L13)）
- 构造时订阅 Host 设置变化并立即执行一次采纳（[packages/client/ui-chat/src/client/transcript-view.ts:18-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/transcript-view.ts#L18-L21)）
- `setMode` 在值未变时直接返回，否则先发布到本地快照再异步写回 Host 的转录字段（[packages/client/ui-chat/src/client/transcript-view.ts:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/transcript-view.ts#L27-L31)）
- `adopt` 在 Host 段缺失或与当前值相同时不动，否则采纳 Host 值且不回写（[packages/client/ui-chat/src/client/transcript-view.ts:33-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/client/transcript-view.ts#L33-L38)）

### packages/client/ui-chat/src/css-modules.d.ts

CSS Module 导入的 TypeScript 环境声明。

- 无运行期机制

### packages/client/ui-chat/src/index.ts

包的 Host 侧入口，注册浏览器 Chat 偏好的持久化设置段。

- `apply` 在 `settings` 服务存在时才把 Chat 设置命名空间与其 schema 注册进设置服务（[packages/client/ui-chat/src/index.ts:12-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/index.ts#L12-L20)）

### packages/client/ui-chat/src/invariant.ts

本包的不变量伴生插件，声明包名归属并给出空安装器。

- 声明伴生插件名与所需注入的 `invariants` 服务，决定它何时被装配（[packages/client/ui-chat/src/invariant.ts:7-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/invariant.ts#L7-L10)）
- 安装器为空实现，并在注释里给出无运行期不变量的理由（[packages/client/ui-chat/src/invariant.ts:12-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/invariant.ts#L12-L13)）
- `apply` 以包名注册该安装器并返回注册的 disposer（[packages/client/ui-chat/src/invariant.ts:20-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/src/invariant.ts#L20-L21)）

### packages/client/ui-chat/tsconfig.json

包的 TypeScript 编译配置与工程引用清单。

- 无运行期机制

### packages/client/ui-chat/tsdown.config.ts

包的客户端打包配置。

- 声明客户端 bundle 的两个入口为 `lib/types/index.js` 与 `lib/types/invariant.js`，决定该包对外可加载的产物（[packages/client/ui-chat/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-chat/tsdown.config.ts#L3)）
