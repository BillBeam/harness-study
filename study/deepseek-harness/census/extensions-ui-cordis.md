---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/extensions/ui-cordis
---

# packages/extensions/ui-cordis

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 23 个文件、128 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/extensions/ui-cordis/README.md

本包的说明文档，叙述面板、工具卡片、`@pluginId` 输入源的用户可见行为与已知限制。

- 无运行期机制

### packages/extensions/ui-cordis/package.json

本包的清单，声明入口、发布产物与浏览器半侧的装配信息。

- `main` 与 `types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/extensions/ui-cordis/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/package.json#L14-L15)）
- `exports` 暴露 `.`、`./invariant`、`./client` 三个入口以及 `./src/*` 与 `./package.json`（[packages/extensions/ui-cordis/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/package.json#L16-L31)）
- `dsh.client` 声明浏览器半侧的九项 inject 依赖与 `platform: "web"`（[packages/extensions/ui-cordis/package.json:32-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/package.json#L32-L47)）
- `files` 把发布产物限定为三个 bundle 与类型声明（[packages/extensions/ui-cordis/package.json:84-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/package.json#L84-L89)）

### packages/extensions/ui-cordis/src/client/CordisActionRow.tsx

`cordis_stop` 与 `cordis_undefine` 两个工具调用的卡片组件，由 `src/client/index.ts` 注册进 keyed toolview 槽位。

- 由 `cordisActionCard(block)` 从调用块派生卡片数据（[packages/extensions/ui-cordis/src/client/CordisActionRow.tsx:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisActionRow.tsx#L16)）
- 按 `toolName` 是否为 `cordis_undefine` 切换标题文案与尾部图标（[packages/extensions/ui-cordis/src/client/CordisActionRow.tsx:17-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisActionRow.tsx#L17-L30)）
- 摘要依次回落 errorSummary → pluginId → callId（[packages/extensions/ui-cordis/src/client/CordisActionRow.tsx:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisActionRow.tsx#L18)）
- 把 toolName 与状态写进 `data-tool`／`data-state` 属性（[packages/extensions/ui-cordis/src/client/CordisActionRow.tsx:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisActionRow.tsx#L21)）
- state 为 error 或 stopped 时以 StateDot 取代常规图标（[packages/extensions/ui-cordis/src/client/CordisActionRow.tsx:24-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisActionRow.tsx#L24-L28)）
- `inspect` 存在时渲染查看按钮并绑定该回调（[packages/extensions/ui-cordis/src/client/CordisActionRow.tsx:33-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisActionRow.tsx#L33-L37)）
- 输出非空时追加输出块（[packages/extensions/ui-cordis/src/client/CordisActionRow.tsx:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisActionRow.tsx#L39)）

### packages/extensions/ui-cordis/src/client/CordisDefineRow.module.css

定义卡片的 CSS Module 样式表。

- 无运行期机制

### packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx

`cordis_define` 调用的只读卡片，展示名称、用途、Host/Client 源码与当前状态。

- `stateStatus` 把调用状态映射成屏幕阅读器文案键，无对应状态时返回 null（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:28-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L28-L35)）
- `leadingFor` 按调用状态选择前导图标（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:37-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L37-L43)）
- 组件订阅注入的 inventory 与 loaded 两个观察量（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L49-L51)）
- 源码标签页初值在有 client 源码时取 client，否则取 host（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L53)）
- 在清单中按 pluginId 找行；被记为 removed 时读作 removed，找到行且有 packageId 时用 `cordisVisibleStatus` 求值，否则 idle（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:56-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L56-L63)）
- 名称缺失时回落到 callId（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L64)）
- 是否可展开由是否存在 host 源码、client 源码或输出决定（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:65-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L65-L66)）
- 当前标签页在所选源码不可用时回落到另一侧（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:69-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L69-L74)）
- 把 pluginId、packageId、状态与 removed 标记写进 `data-cordis-*` 与 `data-terminal` 属性（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:77-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L77-L85)）
- 折叠行渲染错误摘要或名称、用途（缺失时用占位文案）与状态标签（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:98-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L98-L113)）
- 展开体渲染 client/host 两个标签按钮（不可用者禁用）与对应的 CodeBlock（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:116-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L116-L153)）
- 展开体在有输出时渲染输出段并按 error 状态标注，有 pluginId 时渲染指向面板的提示，`inspect` 存在时渲染查看按钮（[packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx:154-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisDefineRow.tsx#L154-L166)）

### packages/extensions/ui-cordis/src/client/CordisPanel.module.css

面板与其侧栏底部触发按钮的 CSS Module 样式表。

- 无运行期机制

### packages/extensions/ui-cordis/src/client/CordisPanel.tsx

侧栏底部的全局动态插件面板，列出所有会话的定义并提供审批、运行、停止、移除、版本切换等操作。

- `selectedPackageIdOf` 依次取用户所选（且仍在包列表内）、next、current、最后一个包、活动运行的包（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:48-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L48-L59)）
- `visiblePanelStatus` 以待审批最优先，其次是 latestRun 失败且包与所选一致，再次是无活动运行判 idle，否则委托 `cordisVisibleStatus`（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:61-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L61-L74)）
- `blockingFirst` 把处于待审批阶段的行排到列表前部（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L76-L81)）
- 面板订阅 inventory、activeRuns、runErrors、loaded、renderFailures 五个观察量与当前会话（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:111-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L111-L116)）
- 打开时以 `getBoundingClientRect` 测量触发按钮位置并监听 resize 重新定位（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:127-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L127-L138)）
- 点击面板外部时关闭面板（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L140)）
- 发现此前未见过的待审批 requestId 时自动打开面板（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:142-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L142-L150)）
- 挂载时以及每次打开时触发 `onRefresh()`（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:152-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L152-L153)）
- 把清单行与活动运行按 pluginId 合并；仅存在于活动运行中的插件也建出一行（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:155-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L155-L168)）
- 按 agentId 是否等于当前会话把行拆成"当前会话"与"其他会话"两组（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:170-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L170-L171)）
- 统计待审批数与运行中数（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:172-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L172-L177)）
- 无任何行时整个组件返回 null（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L179)）
- `runAction` 对同一 pluginId 已在进行时直接返回，执行前清掉旧错误，失败或抛异常时记录错误文本，finally 中解除 pending 并触发 `onRefresh()`（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:181-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L181-L207)）
- 行的名称与用途优先取所选包，缺失时取待审批活动携带的名称与用途，再缺失时用 pluginId（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:218-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L218-L221)）
- 待审批的 requestId 优先取活动，其次取 latestRun 的 approvalRequestId（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:223-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L223-L225)）
- busy 由本地 pending 或活动处于 orchestrating 决定，并用于禁用行内所有控件（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L227)）
- 运行模式在 current 存在且与所选包不同时取 update，否则取 run（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:235-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L235-L236)）
- 行的状态与是否待审批写进 `data-cordis-status`／`data-cordis-awaiting` 属性（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:239-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L239-L245)）
- 包数大于 1 时渲染版本下拉，选择结果写入本地 selected 映射（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:251-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L251-L269)）
- 待审批时渲染"仅此版本"、"后续版本"、"拒绝"三个按钮，动作完成后关闭面板（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:273-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L273-L308)）
- 无活动运行时渲染运行按钮，携带 agentId、所选包、run/update 模式与 hasClientHalf（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:310-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L310-L326)）
- 已有活动运行且所选包与之不同时渲染切换运行按钮（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:327-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L327-L343)）
- 状态为 client-pending 且所选即活动包时渲染重载按钮，固定以 mode `run` 与 `hasClientHalf: true` 发起（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:344-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L344-L360)）
- 有活动运行时渲染停止按钮，有清单行时渲染移除按钮（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:361-380](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L361-L380)）
- next 与 current 不同时渲染重试与回退两个按钮，重试模式按 current 是否存在取 run/update（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:383-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L383-L414)）
- 依次渲染运行失败、Host 失败、动作错误、客户端渲染失败四类错误行，前两者互斥（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:415-433](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L415-L433)）
- 渲染失败行按 abdicated 与否选择文案，并把 slot 与 abdicated 写进 data 属性（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:422-433](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L422-L433)）
- 活动包与所选包不同时补一行标出实际运行的包（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:434-436](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L434-L436)）
- 面板体在读失败、尚未读到、读到但为空三种情形下分别显示不同提示（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:449-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L449-L453)）
- 底部按钮把总数与待审批数写进 `data-cordis-badge`／`data-cordis-approval-badge`，有待审批时置 `data-active`，点击切换面板开合（[packages/extensions/ui-cordis/src/client/CordisPanel.tsx:470-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisPanel.tsx#L470-L487)）

### packages/extensions/ui-cordis/src/client/CordisRunRow.module.css

运行卡片与动作卡片共用的 CSS Module 样式表。

- 无运行期机制

### packages/extensions/ui-cordis/src/client/CordisRunRow.tsx

`cordis_run` 调用的卡片，并在符合条件时为动态包自有的业务视图提供宿主槽位。

- 只有调用成功且 pluginId、packageId、pluginRunId、seq 齐全时才计算业务视图 key（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L44-L50)）
- 以 `useEffect` 把本次成功结果作为指针发布进会话级卡片索引（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:51-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L51-L54)）
- superseded 判定为同 key 下存在 callId 不同且 seq 不小于本卡的指针（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:59-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L59-L60)）
- 只有 latestRun 的 pluginRunId 与本卡一致时才把它当作本次尝试（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:62-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L62-L64)）
- 待审批判定为本次尝试状态为 awaiting-approval，或活动运行的包与 mode 与本卡一致（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:65-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L65-L68)）
- 读数优先级依次为 removed、superseded、awaiting-approval、failed、`cordisVisibleStatus`、idle（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:69-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L69-L79)）
- 摘要依次回落 errorSummary → `pluginId · packageId` → callId（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:81-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L81-L82)）
- 只有读数为 running 且 key 非空时才展示业务视图（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L83)）
- 把 pluginId、packageId、pluginRunId 与读数写进 `data-cordis-*` 属性（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:86-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L86-L94)）
- 状态文案由读数经 `READING_LABELS` 映射（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L80)）
- 标题按 mode 是否为 update 在两套文案间切换（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L103)）
- removed、superseded、failed 三种读数分别渲染对应文案或尝试的错误信息（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L113-L117)）
- 通过 `renderSlot('tool.view.cordis', …)` 把 pluginId/packageId/pluginRunId 作为 owner props 注入，并以 entryKey 定位、输出块作 fallback（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:118-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L118-L129)）
- 未展示业务视图且读数不是 removed/superseded 时直接渲染输出块（[packages/extensions/ui-cordis/src/client/CordisRunRow.tsx:130-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/CordisRunRow.tsx#L130-L132)）

### packages/extensions/ui-cordis/src/client/card-model.ts

从已记录的调用与结果切片派生出三种卡片视图数据的纯函数，被三个卡片组件调用。

- `firstLine` 截取文本首行（[packages/extensions/ui-cordis/src/client/card-model.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L46-L49)）
- `stringAt` 只接受非空字符串字段，其余一律为 null（[packages/extensions/ui-cordis/src/client/card-model.ts:51-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L51-L54)）
- `parseArgs` 对进行中调用可能出现的截断 JSON 前缀吞掉异常并返回 null（[packages/extensions/ui-cordis/src/client/card-model.ts:61-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L61-L69)）
- `resultText` 拼接文本块与 JSON 化的非文本块，全空时回落到 `error.name: error.code`（[packages/extensions/ui-cordis/src/client/card-model.ts:71-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L71-L77)）
- `stateOf` 依据是否已结算、`error.code === 'interrupted'`、`isError` 判出 running/stopped/error/ok 四态（[packages/extensions/ui-cordis/src/client/card-model.ts:79-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L79-L83)）
- `metaObject` 仅在已结算且非错误时读取结果元数据（[packages/extensions/ui-cordis/src/client/card-model.ts:85-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L85-L88)）
- `cordisDefineCard` 从 meta 取 pluginId/packageId，从参数取 name/purpose 与 host/client 源码，name 缺失时回落到 argsRaw 首行（[packages/extensions/ui-cordis/src/client/card-model.ts:95-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L95-L115)）
- `cordisRunCard` 以 meta 优先、调用参数兜底解析 pluginId/packageId，mode 只接受 run 与 update，seq 取自已结算块（[packages/extensions/ui-cordis/src/client/card-model.ts:122-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L122-L142)）
- `cordisActionCard` 从调用参数取 `pluginId`，缺失时取 `id`（[packages/extensions/ui-cordis/src/client/card-model.ts:149-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L149-L161)）
- 三种卡片在状态为 error 且有输出时把输出首行作为 errorSummary（[packages/extensions/ui-cordis/src/client/card-model.ts:112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/card-model.ts#L112)）

### packages/extensions/ui-cordis/src/client/dynamic-port.ts

面板所用 RPC 接口与结果类型的声明文件。

- 无运行期机制

### packages/extensions/ui-cordis/src/client/events.ts

把 Remote 装配处的动态 Cordis 词汇按类型重新导出给本包客户端程序。

- 无运行期机制

### packages/extensions/ui-cordis/src/client/index.ts

本包浏览器半侧的插件入口：注册词典、清单源、面板槽位、四个工具卡片槽位与 `@` 输入触发源。

- `inject` 列出六项必需服务（[packages/extensions/ui-cordis/src/client/index.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L38-L40)）
- 以 `ctx.effect` 向 locale 注册 zh/en 两套词典（[packages/extensions/ui-cordis/src/client/index.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L44)）
- `port.stop` 把远端结果折算成 ok/message，并把 `not-running` 视为成功（[packages/extensions/ui-cordis/src/client/index.ts:47-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L47-L52)）
- `port.remove` 与 `port.inventory` 分别折算移除结果与在读取失败时抛出带错误码的异常（[packages/extensions/ui-cordis/src/client/index.ts:53-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L53-L62)）
- 创建清单源，读失败经 `console.error` 上报（[packages/extensions/ui-cordis/src/client/index.ts:64-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L64-L66)）
- 把浏览器运行器的快照与订阅包成 loaded 观察量，并新建运行卡片注册表（[packages/extensions/ui-cordis/src/client/index.ts:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L67-L69)）
- 订阅清单，每次读到结果后用行去调 `runner.reconcileApprovals`（[packages/extensions/ui-cordis/src/client/index.ts:71-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L71-L74)）
- `cordis/dynamic-package`、`cordis/dynamic-retract`、`cordis/request-run-resolved` 三个远端事件直接触发清单刷新（[packages/extensions/ui-cordis/src/client/index.ts:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L76-L81)）
- `cordis/request-run` 仅在当前清单不含该 pluginId 时才触发刷新（[packages/extensions/ui-cordis/src/client/index.ts:78-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L78-L80)）
- `connection/reset` 先 reset 清单再重新刷新（[packages/extensions/ui-cordis/src/client/index.ts:82-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L82-L85)）
- 向 `sidebar.footer.action` 槽位注册面板，注入五个观察量与审批/拒绝/运行/停止/移除/刷新六个回调（[packages/extensions/ui-cordis/src/client/index.ts:87-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L87-L115)）
- `onStop` 与 `onRemove` 在远端返回后刷新清单，`onRemove` 成功时先把该插件 retire 出清单（[packages/extensions/ui-cordis/src/client/index.ts:102-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L102-L112)）
- 向 `tool.call.toolview` 注册 `cordis_define` 卡片并注入清单与 loaded（[packages/extensions/ui-cordis/src/client/index.ts:117-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L117-L123)）
- 注册 `cordis_run` 卡片，声明 `tool.view.cordis` 子槽位为 keyed／session，并按 sessionId 取该会话的运行卡片 store 与观察回调（[packages/extensions/ui-cordis/src/client/index.ts:125-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L125-L137)）
- 以生成器一次注册 `cordis_stop` 与 `cordis_undefine` 两个 keyed 卡片（[packages/extensions/ui-cordis/src/client/index.ts:139-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L139-L146)）
- `rowsOf` 只取 agentId 等于当前会话且 pluginId 含查询串的清单行（[packages/extensions/ui-cordis/src/client/index.ts:148-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L148-L149)）
- `@` 触发源的候选取 next→current→最后一个包的 purpose 作描述，选中后向输入框写入 `@pluginId `（[packages/extensions/ui-cordis/src/client/index.ts:150-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L150-L169)）
- 触发源的 `warm` 刷新清单，`subscribeLexicon` 把清单订阅作为词库变化源（[packages/extensions/ui-cordis/src/client/index.ts:165-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L165-L167)）
- 以 `ctx.effect` 注册该输入触发源（[packages/extensions/ui-cordis/src/client/index.ts:170-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L170-L171)）
- apply 末尾立即触发一次清单读取（[packages/extensions/ui-cordis/src/client/index.ts:173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/index.ts#L173)）

### packages/extensions/ui-cordis/src/client/inventory.ts

本页最近一次读到的宿主定义清单，作为可订阅快照供面板与卡片使用。

- 初始快照为空行、空 removed、read 为 false（[packages/extensions/ui-cordis/src/client/inventory.ts:59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/inventory.ts#L59)）
- `publish` 用监听器集合的副本逐个通知（[packages/extensions/ui-cordis/src/client/inventory.ts:64-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/inventory.ts#L64-L67)）
- `subscribe` 返回移除该监听器的函数（[packages/extensions/ui-cordis/src/client/inventory.ts:71-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/inventory.ts#L71-L74)）
- `refresh` 单飞：已有读在途时直接返回（[packages/extensions/ui-cordis/src/client/inventory.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/inventory.ts#L75-L77)）
- 每次读记录发起时的 generation，世代不符的成功、失败与收尾都不写入任何状态（[packages/extensions/ui-cordis/src/client/inventory.ts:77-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/inventory.ts#L77-L100)）
- 读成功时把上次有、这次没有的 pluginId 累加进 removed 集合再发布（[packages/extensions/ui-cordis/src/client/inventory.ts:80-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/inventory.ts#L80-L86)）
- 读失败时保留原有 rows 与 read 标记，只附上错误文本（[packages/extensions/ui-cordis/src/client/inventory.ts:88-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/inventory.ts#L88-L99)）
- `retire` 立即把该 pluginId 从 rows 移出并记进 removed（[packages/extensions/ui-cordis/src/client/inventory.ts:102-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/inventory.ts#L102-L106)）
- `reset` 递增 generation、清空在途读、发布空 rows 与 read 为 false（[packages/extensions/ui-cordis/src/client/inventory.ts:107-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/inventory.ts#L107-L111)）

### packages/extensions/ui-cordis/src/client/locales.ts

本包 UI 的中英文文案词典与命名空间常量。

- 无运行期机制

### packages/extensions/ui-cordis/src/client/run-card-index.ts

按会话记录哪张 `cordis_run` 卡片当前拥有某个业务视图的索引。

- `getSnapshot` 惰性缓存快照副本，`observe` 变更时清空缓存（[packages/extensions/ui-cordis/src/client/run-card-index.ts:29-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/run-card-index.ts#L29-L42)）
- `observe` 只在新指针的 seq 大于现存指针时替换并通知监听器（[packages/extensions/ui-cordis/src/client/run-card-index.ts:36-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/run-card-index.ts#L36-L42)）
- `forSession` 按 sessionId 惰性创建并在页面生命周期内保留同一个 store（[packages/extensions/ui-cordis/src/client/run-card-index.ts:55-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/run-card-index.ts#L55-L62)）
- `cordisToolViewKey` 用 `pluginId.packageId` 拼出注册与卡片共用的键（[packages/extensions/ui-cordis/src/client/run-card-index.ts:71-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/run-card-index.ts#L71-L76)）

### packages/extensions/ui-cordis/src/client/slots.ts

声明注入到各组件的面数据类型，并向 `SlotMap` 合并 `tool.view.cordis` 槽位声明。

- 无运行期机制

### packages/extensions/ui-cordis/src/client/status.ts

由宿主清单与本页已加载集合推导单个包可见状态的纯函数，被面板与两张卡片共用。

- `packageOf` 在行的包列表中按 packageId 定位（[packages/extensions/ui-cordis/src/client/status.ts:17-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/status.ts#L17-L22)）
- `cordisVisibleStatus` 在无活动运行或活动包不匹配时判 idle（[packages/extensions/ui-cordis/src/client/status.ts:36-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/status.ts#L36-L37)）
- 包无 client 半时直接判 running（[packages/extensions/ui-cordis/src/client/status.ts:38-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/status.ts#L38-L39)）
- 有 client 半时按本页 loaded 集合中是否存在同 pluginId／packageId／pluginRunId 的记录区分 running 与 client-pending（[packages/extensions/ui-cordis/src/client/status.ts:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/client/status.ts#L40-L44)）

### packages/extensions/ui-cordis/src/css-modules.d.ts

为 `*.module.css` 与 `*.css` 导入提供类型声明。

- 无运行期机制

### packages/extensions/ui-cordis/src/index.ts

本包 node 半侧的插件体，浏览器半侧经 `exports["./client"]` 单独装载。

- 无运行期机制

### packages/extensions/ui-cordis/src/invariant.ts

本包的不变量伴生插件，向 `invariants` 服务登记包名。

- 声明伴生插件名与 `inject = ['invariants']`，使其在该服务就绪后才激活（[packages/extensions/ui-cordis/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/invariant.ts#L13-L15)）
- `apply` 以空 installer 向 `invariants` 注册包名并返回其 disposer（[packages/extensions/ui-cordis/src/invariant.ts:24-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/src/invariant.ts#L24-L32)）

### packages/extensions/ui-cordis/tsconfig.json

本包的 TypeScript 编译配置，继承客户端基配置并声明工作区引用。

- 无运行期机制

### packages/extensions/ui-cordis/tsdown.config.ts

本包的打包配置。

- 以 `clientBundle` 把该包的打包入口声明为 `lib/types/index.js` 与 `lib/types/invariant.js`（[packages/extensions/ui-cordis/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/ui-cordis/tsdown.config.ts#L3)）
