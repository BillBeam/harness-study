---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-workflow-run
---

# packages/client/ui-workflow-run

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、74 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-workflow-run/README.md

该包的说明文档，描述这个浏览器插件如何把持久化的 workflow 运行记录重建成会话中的独立节点。

- 无运行期机制

### packages/client/ui-workflow-run/package.json

该包的 npm 清单，声明入口、导出映射与客户端插件装配元数据。

- `main` 与 `types` 把包的默认入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-workflow-run/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./client` 三个运行期子路径，并额外放开 `./src/*` 与 `./package.json`（[packages/client/ui-workflow-run/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/package.json#L16-L31)）
- `dsh.client.inject` 列出该客户端插件加载时需要的六个服务包，`platform` 限定为 `web`（[packages/client/ui-workflow-run/package.json:32-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/package.json#L32-L44)）
- `files` 限定发布产物只含三个 js 入口与类型声明（[packages/client/ui-workflow-run/package.json:49-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/package.json#L49-L54)）

### packages/client/ui-workflow-run/src/client/WorkflowRunPanel.module.css

面板组件使用的 CSS Module 样式表，被 `WorkflowRunPanel.tsx` 以 `css.*` 类名引用。

- 无运行期机制

### packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx

workflow 运行节点的 React 渲染组件，被 `client/index.ts` 注册进 `conversation.chat.node` 槽位的 `workflow-run` 键。

- `STATUS_KEYS` 把五种运行状态映射到词典键（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:30-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L30-L36)）
- `dotState` 把状态映射到状态点的四种视觉状态，`cancelled` 与 `interrupted` 合并为 `warning`（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:38-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L38-L48)）
- `readablePhase` 把 `null` 阶段渲染为 `phase.unassigned`、空串阶段渲染为 `phase.empty`，其余原样显示（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:50-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L50-L53)）
- `readableMember` 把空成员名替换为 `member.empty` 文案（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:55-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L55-L57)）
- `memberCount` 按 `count === 1` 在 `run.members.one` 与 `run.members.other` 之间选键（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L67-L69)）
- `abnormal` 把 `failed`/`cancelled`/`interrupted` 归为异常（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:94-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L94-L96)）
- `phaseDisclosureFacts` 由成员状态推出阶段的 `abnormal`/`running`/`clean` 模式，并以成员数作为活动计数（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:98-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L98-L103)）
- `runDisclosureFacts` 由运行状态与所有阶段模式推出外层模式，并把各阶段活动计数求和（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:105-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L105-L116)）
- `initialDisclosureState` 把非 `clean` 模式初始化为展开、`clean` 初始化为折叠（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:118-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L118-L120)）
- `advanceDisclosureState` 在事实未变时保持当前值，只有待折叠且焦点不在内部时才执行折叠（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:127-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L127-L131)）
- 事实转为 `clean` 时，若当前展开且焦点在内部则保持展开并置 `pendingCleanCollapse`，否则立即折叠（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:132-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L132-L135)）
- 从 `clean` 转出、或首次进入 `abnormal` 时强制展开，其余情况沿用当前展开值（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:136-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L136-L139)）
- `focusIsWithin` 用 `element.contains(ownerDocument.activeElement)` 判断焦点归属，元素缺失时返回 false（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:142-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L142-L145)）
- `collapsePending` 把待折叠状态一次性落为折叠并清标记（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:147-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L147-L150)）
- `existingPhaseState` 在阶段状态缺失时抛错（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:152-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L152-L160)）
- `preventPendingHeaderFocus` 在 mousedown 落在 `[data-disclosure-row]` 内时调用 `preventDefault`，头部缺失时抛错（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:162-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L162-L167)）
- `phaseStatusSummary` 统计各状态计数：无活动状态时只输出 completed 计数；含 interrupted 且 completed 大于 0 时把 completed 排到最前；结果以 ` · ` 连接（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:169-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L169-L180)）
- `navigableMembers` 只在成员 running、childId 在普通会话 id 集合内、摘要 `origin === 'subagent'`、`parentId` 等于当前会话、且摘要仍 running 时才把该 childId 列为可导航（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:182-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L182-L202)）
- `RunHeader` 以 `expandOnRowClick`、`previewChevron={false}`、`keepContentWhenOpen` 配置整行可点的披露行（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:214-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L214-L224)）
- 折叠态尾部渲染成员数、状态点与状态文案，并把状态写入 `data-status`（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:225-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L225-L234)）
- `MemberRow` 用本地 `focused` 状态决定：不可导航且未获焦时渲染 `div`，否则渲染 `button`（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:248-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L248-L260)）
- 成员按钮在不可导航时设 `aria-disabled`、`tabIndex={-1}` 且不挂 `onClick`，可导航时以 `member.open` 作 aria 标签并在点击时调用 `openSession(member.childId)`（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:261-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L261-L275)）
- 成员行把状态写入 `data-member-status`，并给标签、状态文本挂上 `data-member-label`、`data-member-status-text` 属性（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:251-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L251-L259)）
- `PhaseSection` 仅在该阶段处于待折叠时挂上 `onMouseDownCapture` 拦截（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:292-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L292-L296)）
- 阶段折叠态尾部渲染成员数与 `phaseStatusSummary` 汇总文本（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:308-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L308-L314)）
- 阶段内容区以 `member.seq` 为 key 渲染成员，并用 `navigable.includes(member.childId)` 决定每行是否可点（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:316-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L316-L326)）
- 组件用 `useMemo` 从 `node.data.phases` 与 `node.data.status` 派生阶段事实与运行事实（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:334-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L334-L341)）
- 披露状态由 `useState` 惰性初始化一次，运行与每个阶段各自持有初始开合（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:342-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L342-L345)）
- `useSessions` 以 `navigableMembers` 为选择器、`shallowEqual` 为比较器订阅会话列表（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:348-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L348-L351)）
- `useLayoutEffect` 逐阶段推进披露状态，新出现的阶段用初始状态、已存在的阶段按当前焦点推进（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:354-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L354-L370)）
- 当某阶段从 `clean` 起了新周期且运行事实非 `clean` 而外层仍折叠时，强制展开外层运行行（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:371-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L371-L378)）
- 状态无变化时返回原对象，避免重复 setState；effect 依赖包含 `disclosures.run.open`（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:379-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L379-L381)）
- `toggleRun` 翻转运行行开合并清除待折叠标记（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:383-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L383-L392)）
- `togglePhase` 复制阶段状态表、翻转指定阶段开合并清除待折叠标记（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:393-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L393-L404)）
- `settleRunBlur` 在 `relatedTarget` 仍在容器内时不动，否则结算运行行的待折叠（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:405-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L405-L411)）
- `settlePhaseBlur` 以同样规则结算单个阶段的待折叠（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:412-422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L412-L422)）
- 根 `section` 输出 `data-workflow-run` 与 `data-run-status`，并在运行行待折叠时挂 mousedown 拦截（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:425-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L425-L432)）
- 阶段列表为空时渲染 `run.empty` 文案，否则逐阶段渲染 `PhaseSection`（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:441-446](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L441-L446)）
- 阶段内容的 ref 回调按元素挂载与卸载往 `phaseContentRefs` 写入或删除条目（[packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx:450-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/WorkflowRunPanel.tsx#L450-L453)）

### packages/client/ui-workflow-run/src/client/index.ts

浏览器侧插件入口，把节点定义、词典与键控渲染器注册进客户端 Context。

- `inject` 声明该插件所需的四个服务（[packages/client/ui-workflow-run/src/client/index.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/index.ts#L22)）
- `apply` 向会话事件注册表登记 `workflowRunDefinition`（[packages/client/ui-workflow-run/src/client/index.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/index.ts#L26)）
- 以 `ctx.effect` 注册 `zh`/`en` 词典，效果被撤销时一并撤回（[packages/client/ui-workflow-run/src/client/index.ts:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/index.ts#L27)）
- 通过 `ctx.slots.inject`/`register` 把 `WorkflowRunPanel` 挂到 `conversation.chat.node` 槽位的 `workflow-run` 键并绑定 `workflowRun` 词典命名空间（[packages/client/ui-workflow-run/src/client/index.ts:28-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/index.ts#L28-L35)）
- 槽位的 `inject` 向组件注入 `openSession`，其实现调用 `ctx.sessions.open(id)`（[packages/client/ui-workflow-run/src/client/index.ts:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/index.ts#L32-L34)）

### packages/client/ui-workflow-run/src/client/locales.ts

该插件自有的中英文词典模块，被 `client/index.ts` 注册、被面板通过 `t` 读取。

- `NS` 常量定义注册与槽位使用的词典命名空间名（[packages/client/ui-workflow-run/src/client/locales.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/locales.ts#L4)）
- `zh` 与 `en` 两份同键集词条含 `{name}`、`{count}` 占位符，由 `t` 插值后成为面板可见文本（[packages/client/ui-workflow-run/src/client/locales.ts:7-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/locales.ts#L7-L48)）

### packages/client/ui-workflow-run/src/client/workflow-definition.ts

把四类 `tool-workflow/*` 会话事件折叠成一个键控 Chat 节点的定义模块，被 `client/index.ts` 注册。

- `workflowPhaseKey` 把 `null` 阶段编码为 `missing`、其余编码为带长度前缀的 `value:<len>:<phase>`（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:59-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L59-L61)）
- `statusFromStopReason` 把运行停止原因映射为展示状态，`error` 映射为 `failed`（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:63-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L63-L71)）
- `statusFromOutcome` 把成员结局映射为展示状态（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:73-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L73-L81)）
- `locationClosed` 在 step 位置下同时看 step 与 turn 的关闭状态，在 turn 位置下只看 turn（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:83-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L83-L88)）
- `projectWorkflow` 在缺少 `stopReason` 且所在位置已关闭时判定为 interrupted（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:94-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L94-L96)）
- 成员按阶段键分组，`phase` 字段缺失被规约为 `null`，分组顺序为首次出现顺序（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:97-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L97-L105)）
- 无结局的成员按 interrupted 判定取 `interrupted` 或 `running`，有结局的按结局映射（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:106-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L106-L113)）
- 运行整体状态同样在无 `stopReason` 时取 `interrupted` 或 `running`，否则由停止原因映射（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:115-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L115-L126)）
- `updateAgentStart` 把新成员追加到成员列表末尾，`phase` 未定义时不写入该字段（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:129-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L129-L137)）
- `updateAgentEnd` 按 `seq` 匹配写入成员结局，不改动成员顺序（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:139-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L139-L146)）
- 定义声明 `kind: 'workflow-run'` 与 `target: 'chat'`（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:149-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L149-L151)）
- `match` 把 `run-start` 认作 `start` 角色、其余三类 `tool-workflow/*` 认作 `update`，均以 `runId` 字符串为 Context 标识，其它事件返回 `null`（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:152-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L152-L160)）
- `start` 在事件不是 `run-start` 时抛错，否则以事件中的 `name` 与空成员列表建初始状态（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:161-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L161-L166)）
- `update` 按事件类型分派到成员追加、成员结局写入、或写入运行 `stopReason`，其余原样返回状态（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:167-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L167-L178)）
- `buildViewNode` 在尚未收到起始事件时返回 `null`，使只含更新的历史尾部不产生节点（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:179-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L179-L181)）
- 视图节点以起始事件的 `seq` 作 `anchorSeq`、沿用起始位置，并固定 `visibility: 'visible'`（[packages/client/ui-workflow-run/src/client/workflow-definition.ts:182-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/client/workflow-definition.ts#L182-L191)）

### packages/client/ui-workflow-run/src/css-modules.d.ts

为 `*.module.css` 与 `*.css` 导入提供 TypeScript 环境声明。

- 无运行期机制

### packages/client/ui-workflow-run/src/index.ts

该包的 Host 侧插件入口。

- 无运行期机制

### packages/client/ui-workflow-run/src/invariant.ts

该包的不变量伴生插件，向不变量注册表登记包名。

- 导出插件名与 `invariants` 服务注入声明（[packages/client/ui-workflow-run/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/invariant.ts#L10-L12)）
- `apply` 以空的 installer 向 `ctx.invariants` 注册该包名并返回其 disposer（[packages/client/ui-workflow-run/src/invariant.ts:19-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/src/invariant.ts#L19-L23)）

### packages/client/ui-workflow-run/tsconfig.json

该包的 TypeScript 编译配置，声明客户端基配置、输出目录与工程引用。

- 无运行期机制

### packages/client/ui-workflow-run/tsdown.config.ts

该包的打包配置，被 `pnpm run bundle`/`watch` 使用。

- 以 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口生成客户端产物（[packages/client/ui-workflow-run/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workflow-run/tsdown.config.ts#L3)）
