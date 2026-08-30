---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-user-questions
---

# packages/client/ui-user-questions

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、70 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-user-questions/README.md

本包的说明文档：描述问题接管组合器、计划评审卡片、草稿存储与本地化约定。

- 无运行期机制

### packages/client/ui-user-questions/package.json

本包的 npm 清单：入口映射、客户端插件元数据与发布产物清单。

- `exports` 映射四个入口：包根、`./invariant`、`./client`，以及 `./src/*` 源码直读与 `./package.json`（[packages/client/ui-user-questions/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/package.json#L16-L31)）
- `dsh.client` 声明客户端半所需注入的六个包并把 platform 限定为 `web`（[packages/client/ui-user-questions/package.json:32-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/package.json#L32-L44)）
- `files` 把发布内容限定为三个 bundle 与类型声明（[packages/client/ui-user-questions/package.json:88-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/package.json#L88-L93)）

### packages/client/ui-user-questions/src/client/PlanReviewPanel.module.css

计划评审卡片的 CSS 模块。

- 无运行期机制

### packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx

计划评审接管卡片组件，由问题组合器在请求被窄化为计划评审时渲染。

- `tooltip` 在描述缺失时不传 `title`，避免显式 undefined 落到 DOM props（[packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx#L17-L19)）
- `settle` 先置忙并清错，发送失败时恢复可点并把错误消息文本显示出来（[packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx:34-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx#L34-L43)）
- `decide` 用被评审问题的 id 与提问方原始选项标签提交单条答案（[packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx#L44-L46)）
- 卡片以问题文本作为无障碍名称，正文用 MarkdownText 渲染计划全文并挂上滚动标记属性（[packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx:50-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx#L50-L58)）
- 讨论按钮调用 `pending.cancel()` 结束等待并把组合器交还给用户（[packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx:62-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx#L62-L67)）
- 只有存在拒绝选项时才渲染拒绝按钮，点击提交该选项的原始标签（[packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx#L68-L75)）
- 批准按钮提交批准选项的原始标签（[packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/PlanReviewPanel.tsx#L76-L81)）

### packages/client/ui-user-questions/src/client/QuestionComposer.module.css

问题接管卡片的 CSS 模块。

- 无运行期机制

### packages/client/ui-user-questions/src/client/QuestionComposer.tsx

问题接管组合器：在计划评审卡片与通用问题流之间路由，并实现通用流的作答、导航与提交。

- `parseRecommendedLabel` 用正则剥离标签末尾的 `(recommended)` / `（推荐）` 后缀作为显示文本，答案仍使用原标签（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:30-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L30-L35)）
- `isComposing` 把 `nativeEvent.isComposing` 或 keyCode 229 都判为输入法组合中（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:38-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L38-L42)）
- `AnswerField` 用隐藏镜像层渲染草稿加尾换行来撑高度，textarea 以 `rows={1}` 与镜像共用同一网格单元并拉伸到它（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:80-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L80-L97)）
- 组合器用 `planReviewOf` 判定：命中则渲染计划评审卡片，否则渲染通用问题流，两者都以请求 key 作为 React key（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:113-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L113-L127)）
- 初始进度为每道问题一份空草稿、索引为 0（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:138-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L138-L141)）
- 只有存储中的 requestKey 与当前请求一致且草稿数与问题数相同时才复用已存进度，否则用初始进度（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:142-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L142-L147)）
- 用 ref 记录已聚焦过的题号，使自动聚焦每题只发生一次（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L156)）
- `replaceProgress` 把新索引与草稿数组写回会话作用域的草稿存储（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:164-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L164-L166)）
- `cancelFlow` 调用 `pending.cancel()`，成功后清除该请求的草稿，失败则解除忙态并显示错误（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:168-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L168-L177)）
- `choose` 在多选时切换标签的选中状态，单选时替换选中集合并清空自定义文本，且在非末题时自动前进一题（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:188-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L188-L198)）
- 「已作答」定义为有选中项或自定义文本去空白后非空，「已完成」再并入显式跳过（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:200-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L200-L203)）
- 提交前若存在未完成项，则跳转到该题并给出 `error.incomplete` 反馈而不发送（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:205-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L205-L211)）
- 组装答案批：跳过项发送空 selected；自定义文本非空且非多选时清空 selected 只发自定义；自定义为空时不带 custom 字段（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:212-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L212-L223)）
- 提交期间置忙，成功后清除草稿，失败解除忙态并把错误文本原样显示（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:224-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L224-L232)）
- `continueFlow` 未作答时给 `error.unanswered`，非末题前进一题，末题触发提交（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:234-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L234-L245)）
- 编辑自定义答案时：多选保留已选标签，单选清空已选，并解除跳过标记（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:250-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L250-L258)）
- 文本域上的 Enter 在非 Shift 且非输入法组合中时阻止默认换行并推进流程（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:260-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L260-L264)）
- `skipQuestion` 把本题草稿清空并标为 skipped，非末题前进，末题直接用新草稿提交（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:266-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L266-L276)）
- 收起状态下只渲染 header，正文与页脚整体不挂载（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:312-437](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L312-L437)）
- header 的收起/展开按钮切换 minimized 并同步 aria-expanded，关闭按钮触发整组取消，提交进行中两者都禁用（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:291-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L291-L309)）
- 问题详情存在时用 MarkdownText 渲染，选项容器的 role 按是否多选在 group 与 radiogroup 间切换（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:314-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L314-L318)）
- 选项按钮的 role 与 aria-checked 随多选/单选切换，点击调用 choose，Enter 在全部题目已完成时直接提交（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:319-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L319-L336)）
- 多选渲染复选框、单选渲染序号，标签后按解析结果显示推荐徽标与可选描述（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:337-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L337-L354)）
- 有选项时渲染内联自定义答案行，无选项时渲染整块文本域并在该题首次呈现时自动聚焦（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:359-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L359-L397)）
- 分页按钮在首题/末题或忙态时禁用，点击写回相邻索引并清除反馈（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:402-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L402-L418)）
- 反馈区对校验类反馈按词条 key 翻译，对来自 wire 的失败消息原样输出（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:419-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L419-L421)）
- 主按钮文案在提交中/末题/非末题三态间切换，且在忙态或本题未作答时禁用（[packages/client/ui-user-questions/src/client/QuestionComposer.tsx:426-433](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/QuestionComposer.tsx#L426-L433)）

### packages/client/ui-user-questions/src/client/contract/slots.ts

问题组合器的 props 契约、计划评审窄化函数，以及一次待答远端瀑布请求的客户端表示类。

- `settlePendingComposer` 把同步结算中抛出的异常转成 rejected Promise，非 Error 值再包一层带 cause 的 Error（[packages/client/ui-user-questions/src/client/contract/slots.ts:27-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L27-L36)）
- `planReviewOf` 仅在单题、intent 为 `plan-review`、detail 存在、非多选、选项不超过两个、且能找到与 `intent.approve` 同名的选项时返回窄化结果，其余一律交给通用流（[packages/client/ui-user-questions/src/client/contract/slots.ts:77-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L77-L88)）
- 窄化结果带出问题 id、问题文本、作为计划正文的 detail、批准选项，以及存在时的另一个选项作为拒绝项（[packages/client/ui-user-questions/src/client/contract/slots.ts:89-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L89-L96)）
- 模块级自增计数器为每个待答请求生成 `question:N` 形式的渲染标识与草稿存储键（[packages/client/ui-user-questions/src/client/contract/slots.ts:98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L98)）
- `questionError` 构造 name 为 `UserQuestionError` 且带 `ASK_ABORTED` / `ASK_CANCELLED` code 的错误（[packages/client/ui-user-questions/src/client/contract/slots.ts:101-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L101-L106)）
- 构造时按 `planReviewOf` 结果把 kind 定为 `question` 或 `plan-review`，供会话待办交互消费者区分呈现（[packages/client/ui-user-questions/src/client/contract/slots.ts:136-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L136-L139)）
- 用 `Promise.withResolvers` 暴露 result promise；传入 signal 时注册一次性 abort 监听，且 signal 已中止时立即触发以 `ASK_ABORTED` 结算（[packages/client/ui-user-questions/src/client/contract/slots.ts:140-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L140-L155)）
- `answer` 用整批答案 resolve 宿主瀑布（[packages/client/ui-user-questions/src/client/contract/slots.ts:161-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L161-L165)）
- `delegate` 以私有 Symbol reject，`isDelegation` 据此判定该次拒绝是否为委派下一个监听器（[packages/client/ui-user-questions/src/client/contract/slots.ts:168-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L168-L180)）
- `cancel` 以 `ASK_CANCELLED` 错误拒绝宿主瀑布（[packages/client/ui-user-questions/src/client/contract/slots.ts:183-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L183-L189)）
- `abort` 在已结算时静默返回，未结算时以给定原因拒绝（[packages/client/ui-user-questions/src/client/contract/slots.ts:195-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L195-L198)）
- `finish` 对重复结算抛错，并在结算前摘除 abort 监听（[packages/client/ui-user-questions/src/client/contract/slots.ts:200-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/contract/slots.ts#L200-L207)）

### packages/client/ui-user-questions/src/client/draft-store.ts

通用问题流的会话作用域草稿存储工厂，实例由插槽注册表持有。

- `defineStore` 声明一个初始为空进度的非持久化存储（[packages/client/ui-user-questions/src/client/draft-store.ts:42-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/draft-store.ts#L42-L45)）
- `replace` 动作把请求键与整份进度写入草稿状态，替换先前值（[packages/client/ui-user-questions/src/client/draft-store.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/draft-store.ts#L46-L49)）
- `clear` 动作仅在请求键匹配时删除该键并把进度重置为空（[packages/client/ui-user-questions/src/client/draft-store.ts:50-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/draft-store.ts#L50-L53)）

### packages/client/ui-user-questions/src/client/index.ts

Web 问题插件的浏览器半：注册字典、组合器链条目，并接管远端问题请求事件。

- 声明本插件所需注入的服务：会话作用域、远端事件、会话 UI、插槽注册表与本地化（[packages/client/ui-user-questions/src/client/index.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/index.ts#L51)）
- 处理一次请求时先用 `sessions.scopeOf(owner)` 解析会话身份，解析不出就直接 `next()` 交给下一个监听器（[packages/client/ui-user-questions/src/client/index.ts:61-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/index.ts#L61-L62)）
- 用会话 id、问题批与请求 signal 构造待答对象，并注册为会话待办交互；移除回调触发 delegate 后等待本次处理完成（[packages/client/ui-user-questions/src/client/index.ts:63-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/index.ts#L63-L68)）
- 等待用户结算：委派型拒绝转为调用 `next()` 继续瀑布，其他拒绝原样抛给远端监听器（[packages/client/ui-user-questions/src/client/index.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/index.ts#L69-L75)）
- 无论结果如何都在 finally 中摘除待办登记并放行等待中的移除回调（[packages/client/ui-user-questions/src/client/index.ts:76-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/index.ts#L76-L79)）
- 以 effect 形式注册 `question` 命名空间的中英字典（[packages/client/ui-user-questions/src/client/index.ts:89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/index.ts#L89)）
- 待办交互注册器按 kind 给出优先级：`plan-review` 为 2，其余为 1（[packages/client/ui-user-questions/src/client/index.ts:91-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/index.ts#L91-L93)）
- 向 `conversation.composer` 链注册问题组合器，选择器只认 `PendingQuestion` 实例并挂上 locale 命名空间与草稿存储（[packages/client/ui-user-questions/src/client/index.ts:94-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/index.ts#L94-L103)）
- 在远端事件 `user-questions/request` 上挂监听器，把请求与 next 交给上面的处理流程（[packages/client/ui-user-questions/src/client/index.ts:104-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/client/index.ts#L104-L106)）

### packages/client/ui-user-questions/src/client/locales.ts

`question` 命名空间的中英文案字典与键集合类型。

- 无运行期机制

### packages/client/ui-user-questions/src/css-modules.d.ts

对 `*.module.css` 导入的 TypeScript 模块声明。

- 无运行期机制

### packages/client/ui-user-questions/src/index.ts

Web 问题插件的 Host 半，插件体刻意留空。

- 无运行期机制

### packages/client/ui-user-questions/src/invariant.ts

本包的不变量伴生插件，向不变量服务登记包名。

- 以包名与空安装器向 `invariants` 服务注册，并把注册返回的 disposer 作为插件 apply 的结果（[packages/client/ui-user-questions/src/invariant.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/src/invariant.ts#L22-L30)）

### packages/client/ui-user-questions/tsconfig.json

本包的 TypeScript 编译配置与工作区项目引用。

- 无运行期机制

### packages/client/ui-user-questions/tsdown.config.ts

本包的打包配置。

- 以 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口生成客户端包产物（[packages/client/ui-user-questions/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-user-questions/tsdown.config.ts#L3)）
