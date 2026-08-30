---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-subagent
---

# packages/client/ui-subagent

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 14 个文件、76 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-subagent/README.md

该包的英文说明文档，描述子代理目录树、续写路由与 `@` 引用来源的行为，供阅读者与文档校验流程使用。

- 无运行期机制

### packages/client/ui-subagent/package.json

该包的 npm 清单，声明入口、子路径导出、客户端注入依赖与发布文件集。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-subagent/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./client`、`./src/*` 与 `./package.json` 五个子路径，各自绑定类型与默认实现（[packages/client/ui-subagent/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/package.json#L16-L31)）
- `dsh.client.inject` 列出浏览器半边装载所需的五个包，`platform` 标为 `web`（[packages/client/ui-subagent/package.json:32-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/package.json#L32-L43)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与 `lib/types/**/*.d.ts`（[packages/client/ui-subagent/package.json:84-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/package.json#L84-L89)）

### packages/client/ui-subagent/src/client/SubagentHeaderLineage.module.css

目录树下拉与其行、连接线、指标列的 CSS Module 样式表，被 `SubagentHeaderLineage.tsx` 以 `css.*` 引用。

- 无运行期机制

### packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx

会话头部的子代理血缘渲染器：把目录快照与会话摘要渲染成可展开的树形下拉，并把选中行转成子会话地址。

- `diagnosticReason` 把诊断条目的 `corrupt`/`unsupported`/`unavailable` 三种原因映射成本地化文本（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:50-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L50-L59)）
- `treeItems` 只收集未被 `aria-disabled="true"` 标记的 `role="treeitem"` 节点，决定键盘可聚焦的行集合（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:61-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L61-L65)）
- `formatTokens` 以 1000 与 1000000 为界切换原值、千位、百万位三种写法，并按是否达到 100 决定保留一位小数还是取整（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L68-L75)）
- `tokenTotal` 把未缓存输入、输出、缓存读、缓存写四个桶相加得到总量，`usage` 缺失时返回 undefined（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:78-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L78-L85)）
- `activityDuration` 在没有进行中回合时返回 `settledMs`，有进行中回合时按行的活动状态取 `now` 或 `active.through` 作为终点并叠加到 `settledMs`（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:88-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L88-L102)）
- `splitDuration` 把毫秒切成秒、分、时、天与总分钟、总小时六个分量（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:113-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L113-L125)）
- `formatDuration` 按 365 天、30 天、1 天、1 小时、1 分钟五道阈值逐级降低显示精度并选用不同字典键（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:128-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L128-L163)）
- `formatExactDuration` 在跨天时改用补零的天时分秒写法，否则回落到 `formatDuration`（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:166-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L166-L176)）
- `CatalogLoadingRows` 从会话摘要里筛出 `origin === 'subagent'` 且 `parentId` 匹配的条目，为每个已知直接子代理渲染一行 `aria-disabled` 的占位行，一个都没有时只渲染一条加载提示（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:204-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L204-L236)）
- 占位行的状态点按摘要的 `running` 取 `ongoing` 或 `done`（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L229)）
- `CatalogRows` 在 `state === 'loading'` 且条目为空时插入占位行，并在本层存在任一 `hasChildren` 的子条目时才保留展开列（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:243-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L243-L256)）
- `state === 'error'` 时渲染错误文案与重试按钮，点击调用 `refresh(parentSessionId)`（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:257-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L257-L269)）
- `kind === 'diagnostic'` 的条目渲染为 `aria-disabled` 的错误状态行，标题与 `aria-label` 带上条目 id 与原因（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:271-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L271-L291)）
- 子条目行取 `entry.label ?? entry.id` 作标题，把摘要标题、模式、活动状态用 ` · ` 拼成副行（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:294-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L294-L306)）
- 行的指标列由 token 总量与精确时长拼成，两者各自缺失时被过滤掉（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:307-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L307-L324)）
- 点击行调用 `openChild({ parentSessionId, childSessionId, mode })` 后关闭下拉（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:326-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L326-L329)）
- 行的键盘处理把 Enter 与空格转成打开，ArrowRight 在非叶且未展开时展开、ArrowLeft 在已展开时收起，并阻止默认与冒泡（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:330-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L330-L343)）
- 展开箭头按钮的点击阻止冒泡到整行的打开动作，只切换分支（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:344-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L344-L348)）
- 行的 `aria-label` 由标题、副行、指标拼接，`aria-current` 只在等于当前会话时出现，`aria-expanded` 只在非叶行出现（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:352-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L352-L362)）
- 叶子行按本层是否保留展开列决定补占位方块，非叶行渲染 `tabIndex={-1}` 的展开按钮（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:363-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L363-L375)）
- 行状态点按 `entry.activity === 'running'` 取 `ongoing` 或 `done`，时长带 `title` 悬浮显示精确值（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:377-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L377-L392)）
- 已展开的非叶行渲染 `role="group"` 子层：子目录未到时给 `aria-busy` 并放占位行，到了则以 `level + 1` 递归渲染（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:397-430](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L397-L430)）
- `catalogMenuPosition` 把菜单宽度取 336 与视口宽减两侧 16 边距的较小值，顶部置于触发器下方 5px，左侧在边距与视口右界之间钳制（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:467-480](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L467-L480)）
- `CatalogDropdown` 通过 `useSessions` 分别订阅 `subagentsByParent` 与 `byId`（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:488-490](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L488-L490)）
- 切换器标题优先取目录里当前子条目的 `label ?? id`，取不到才用传入的 `displayTitle`（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:503-508](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L503-L508)）
- 后代计数用 `indexSubagentDescendants(summaries)` 按根会话 id 取值，缺省为零计数（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:509-513](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L509-L513)）
- 显示计数取目录健康行数与摘要后代数的较大值，并按是否有运行中后代在总数键与运行中键之间选择单复数键（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:516-518](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L516-L518)）
- 当摘要已知有后代（或处于切换器形态）而目录缺失或就绪却为空时，合成一个 `state: 'loading'` 的目录快照顶上（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:521-530](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L521-L530)）
- `observeCatalog` 在本地集合登记/注销被观察的父会话，同时调用 `setCatalogOpen` 通知运行时（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:532-536](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L532-L536)）
- `closeAllCatalogs` 对集合里每个父会话发出 `setCatalogOpen(false)`、清空集合并清掉展开态（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:538-544](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L538-L544)）
- `changeOpen` 打开时重算菜单位置、把 `now` 重置为当前时刻并观察根目录，关闭时清位置并关闭所有已观察目录，`restoreFocus` 用微任务把焦点还给触发器（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:558-576](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L558-L576)）
- 悬停打开延迟 150ms、悬停关闭延迟 120ms，两个定时器互相取消（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:578-595](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L578-L595)）
- `closeBranch` 沿目录递归收集该分支下所有已展开的父会话，逐个注销观察并从展开集合里移除（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:597-610](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L597-L610)）
- `toggleBranch` 已展开则走整枝收起，未展开则加入展开集合并对该子会话发起目录观察（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:612-619](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L612-L619)）
- 打开期间在 document 上监听 `pointerdown`，落点既不在根也不在菜单内时关闭（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:621-634](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L621-L634)）
- 打开期间监听窗口 `resize` 与捕获阶段的 `scroll` 重新定位菜单（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:636-650](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L636-L650)）
- 仅当菜单打开且存在运行中后代时，以 1 秒为周期推进 `now`，条件不再成立即清除定时器（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:652-656](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L652-L656)）
- 卸载时取消两个悬停定时器，并对所有已观察父会话补发 `setCatalogOpen(false)`（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:658-665](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L658-L665)）
- 可见性要求切换器形态、错误态、非空条目或后代计数大于零之一成立，否则整个控件返回 null，并在转为不可见时取消悬停定时器与关闭已开菜单（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:671-685](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L671-L685)）
- `focusAt` 按可聚焦行数取模，实现首尾环绕聚焦（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:687-691](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L687-L691)）
- `navigate` 把 Escape 转成关闭并回焦触发器，Home/End 跳首尾，ArrowDown/ArrowUp 前后移动，无焦点时 ArrowUp 跳到末行（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:693-712](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L693-L712)）
- 根容器绑定 `onKeyDown` 导航与鼠标进入/离开的悬停开关（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:714-721](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L714-L721)）
- 触发器声明 `aria-haspopup="tree"` 与 `aria-expanded`，其 `aria-label` 在切换器文案与运行中/总数计数键之间取值（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:723-736](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L723-L736)）
- 传入 `openTitle` 时触发器点击改为取消悬停、关闭已开菜单并调用 `openTitle()`，未传入时点击不绑定处理（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:737-743](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L737-L743)）
- 触发器上的 ArrowDown 打开菜单并用微任务把焦点落到第一行（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:744-749](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L744-L749)）
- 计数形态在有运行中后代时额外渲染一个 `ongoing` 状态点，并按打开与否给下拉箭头加旋转类（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:751-765](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L751-L765)）
- 打开时用 `createPortal` 把 `role="tree"` 菜单挂到 `document.body`，并把根目录、全量目录表、摘要、展开集合与 `now` 传给第 1 层行渲染（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:767-793](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L767-L793)）
- 顶层组件从会话摘要读出 `origin === 'subagent'` 时的 `parentId`，据此决定后续形态（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:807-810](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L807-L810)）
- 无父会话时只渲染一个带 `/` 分隔符、以当前会话为根的计数下拉（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:812-822](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L812-L822)）
- 有父会话时渲染以父会话为根、当前会话为选中项的切换器，并仅在未传 `openTitle` 时再追加一个以当前会话为根的计数下拉（[packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx:823-843](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentHeaderLineage.tsx#L823-L843)）

### packages/client/ui-subagent/src/client/SubagentReadOnlyComposer.module.css

只读输入区替代块的 CSS Module 样式表，被 `SubagentReadOnlyComposer.tsx` 引用。

- 无运行期机制

### packages/client/ui-subagent/src/client/SubagentReadOnlyComposer.tsx

被 `conversation.composer` 插槽选中后顶替普通输入区的只读说明组件。

- 组件按 `matched.reason` 是否为 `one-shot` 在两组标题/正文字典键之间取值，渲染成 `role="status"` 的容器（[packages/client/ui-subagent/src/client/SubagentReadOnlyComposer.tsx:19-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/SubagentReadOnlyComposer.tsx#L19-L31)）

### packages/client/ui-subagent/src/client/index.ts

浏览器半边的插件体：注册字典、把目录动作接到会话服务上，并把两个组件挂到会话头部与输入区插槽。

- `inject` 声明依赖 `sessions`、`slots`、`locale` 三个服务（[packages/client/ui-subagent/src/client/index.ts:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/index.ts#L30)）
- `selectReadOnlySubagent` 在会话没有子代理信息时放行，`one-shot` 一律接管，`parentAvailable` 未确定为 false 时放行，父不可用且会话仍在运行时也放行，只有父不可用且已停止才以 `parent-unavailable` 接管（[packages/client/ui-subagent/src/client/index.ts:33-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/index.ts#L33-L45)）
- `apply` 用 `ctx.effect` 注册 `zh`/`en` 两份字典到 `subagent` 命名空间（[packages/client/ui-subagent/src/client/index.ts:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/index.ts#L52)）
- `catalogActions` 把 `openChild`/`refresh`/`setCatalogOpen` 分别接到 `sessions.openSubagent`、`sessions.refreshSubagents`、`sessions.setSubagentCatalogOpen`（[packages/client/ui-subagent/src/client/index.ts:54-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/index.ts#L54-L64)）
- 通过 `ctx.slots.inject` 把 `SubagentHeaderLineage` 注册到 `conversation.session.header.lineage` 插槽，并带上目录动作与 locale 命名空间（[packages/client/ui-subagent/src/client/index.ts:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/index.ts#L65-L72)）
- 把 `SubagentReadOnlyComposer` 以 `priority: -10` 注册到 `conversation.composer` 插槽，用 `selectReadOnlySubagent` 决定是否接管（[packages/client/ui-subagent/src/client/index.ts:73-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/index.ts#L73-L81)）

### packages/client/ui-subagent/src/client/locales.ts

`subagent` 命名空间的中英文字典，被客户端插件体注册、被两个组件通过 `t` 查询。

- `NS` 常量固定为 `'subagent'`，作为字典注册与插槽 locale 声明使用的命名空间键（[packages/client/ui-subagent/src/client/locales.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/locales.ts#L4)）
- `zh` 与 `en` 两份等键字典给出运行期 `t` 能解析的全部键，并以 `{seconds}`、`{count}`、`{label}` 等占位符接收参数（[packages/client/ui-subagent/src/client/locales.ts:7-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/locales.ts#L7-L86)）

### packages/client/ui-subagent/src/client/subagent-lineage.ts

从会话摘要里推算每个祖先会话下的子代理后代计数，被目录下拉用于显示计数与运行中标记。

- 只有 `origin === 'subagent'` 的摘要参与计数，其余直接跳过（[packages/client/ui-subagent/src/client/subagent-lineage.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/subagent-lineage.ts#L28-L29)）
- 沿 `parentId` 逐级上溯，遇到非子代理来源、缺失 `parentId` 或 `seen` 里已出现过的 id 就停止（[packages/client/ui-subagent/src/client/subagent-lineage.ts:30-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/subagent-lineage.ts#L30-L33)）
- 对路径上每个祖先累加 `count`，并在该后代 `running` 时同步累加 `runningCount`（[packages/client/ui-subagent/src/client/subagent-lineage.ts:34-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/client/subagent-lineage.ts#L34-L42)）

### packages/client/ui-subagent/src/css-modules.d.ts

给 `*.module.css` 与 `*.css` 导入声明类型的环境声明文件。

- 无运行期机制

### packages/client/ui-subagent/src/index.ts

该包的宿主半边入口，供宿主 cordis.yml / Loader 装载。

- 导出空的 `apply`，使插件可被宿主装载而不产生宿主侧行为（[packages/client/ui-subagent/src/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/index.ts#L9)）

### packages/client/ui-subagent/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属。

- 声明伴生插件名 `client-ui-subagent-invariant` 与依赖服务 `invariants`（[packages/client/ui-subagent/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/invariant.ts#L13-L15)）
- `install` 为空实现，不安装任何运行期检查（[packages/client/ui-subagent/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/invariant.ts#L22)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并把返回的注销函数以 Promise 交回（[packages/client/ui-subagent/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/src/invariant.ts#L29-L30)）

### packages/client/ui-subagent/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、输出目录与工作区项目引用。

- 无运行期机制

### packages/client/ui-subagent/tsdown.config.ts

该包的打包配置，被 `pnpm run bundle` 使用。

- 以 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口调用共享的客户端打包配置，产出 package.json 导出所指向的运行期文件（[packages/client/ui-subagent/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-subagent/tsdown.config.ts#L1-L3)）
