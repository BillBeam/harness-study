---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-settings-plugins
---

# packages/client/ui-settings-plugins

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 28 个文件、153 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-settings-plugins/README.md

该包的说明文档，描述插件设置区、可配置卡片与保存路径，供阅读者了解本目录。

- 无运行期机制

### packages/client/ui-settings-plugins/package.json

该包的 npm 清单，声明模块入口、浏览器半的注入需求与发布产物。

- `exports` 把包根、`./invariant`、`./client` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，并开放 `./src/*` 与 `./package.json`（[packages/client/ui-settings-plugins/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/package.json#L16-L31)）
- `dsh.client` 声明浏览器半需要注入 connection、locale、ui-settings、api-remotes 四个包，且 `platform` 为 `web`（[packages/client/ui-settings-plugins/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/package.json#L32-L42)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与 `lib/types/**/*.d.ts`（[packages/client/ui-settings-plugins/package.json:72-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/package.json#L72-L77)）

### packages/client/ui-settings-plugins/src/client/AgentLoopCard.tsx

`agent-loop` 命名空间卡片的渲染组件，由 `settings.plugin.item` 槽以该命名空间为键分派。

- 通过注入的 `useAgentLoopCard` 选择器读取整份卡片快照作为渲染依据（[packages/client/ui-settings-plugins/src/client/AgentLoopCard.tsx:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/AgentLoopCard.tsx#L22)）
- 把快照与注入的 `save` / `discard` 交给 `PluginCard` 外壳，由外壳决定可用性与保存按钮状态（[packages/client/ui-settings-plugins/src/client/AgentLoopCard.tsx:24-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/AgentLoopCard.tsx#L24-L31)）
- 渲染 `maxParallelToolCalls` 数值控件，展开快照中该字段的文本／覆盖／非法三态，并在 `writable` 为假时禁用（[packages/client/ui-settings-plugins/src/client/AgentLoopCard.tsx:32-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/AgentLoopCard.tsx#L32-L44)）
- 控件的编辑与重置分别调用注入的 `edit('maxParallelToolCalls', text)` 与 `resetField('maxParallelToolCalls')`，只暂存不写入（[packages/client/ui-settings-plugins/src/client/AgentLoopCard.tsx:42-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/AgentLoopCard.tsx#L42-L43)）

### packages/client/ui-settings-plugins/src/client/BashCard.tsx

shell 命名空间卡片的渲染组件，由 `settings.plugin.item` 槽分派。

- 通过 `useBashCard` 选择器读取卡片快照，并由 `writable` 推出统一的禁用标志（[packages/client/ui-settings-plugins/src/client/BashCard.tsx:22-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/BashCard.tsx#L22-L23)）
- 把快照与 `save` / `discard` 交给 `PluginCard` 外壳（[packages/client/ui-settings-plugins/src/client/BashCard.tsx:29-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/BashCard.tsx#L29-L32)）
- 渲染 `timeoutMs` 数值控件，编辑与重置调用 `edit('timeoutMs', text)` 与 `resetField('timeoutMs')`（[packages/client/ui-settings-plugins/src/client/BashCard.tsx:33-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/BashCard.tsx#L33-L45)）
- 渲染 `maxOutputBytes` 数值控件，编辑与重置调用 `edit('maxOutputBytes', text)` 与 `resetField('maxOutputBytes')`（[packages/client/ui-settings-plugins/src/client/BashCard.tsx:46-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/BashCard.tsx#L46-L58)）

### packages/client/ui-settings-plugins/src/client/ConfigurablePluginsTab.tsx

可配置插件页的渲染组件，注册在 `settings.plugins.tab` 上并声明嵌套的 `settings.plugin.item` 槽。

- 通过 `useConfigurablePlugins` 读取 `loaded` 与 `namespaces` 两项快照字段（[packages/client/ui-settings-plugins/src/client/ConfigurablePluginsTab.tsx:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/ConfigurablePluginsTab.tsx#L30)）
- 对每个命名空间调用一次 `renderSlot('settings.plugin.item', {}, { entryKey: ns })`，并以命名空间本身作为列表 key（[packages/client/ui-settings-plugins/src/client/ConfigurablePluginsTab.tsx:31-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/ConfigurablePluginsTab.tsx#L31-L41)）
- 命名空间为空时，仅在 `loaded` 为真时渲染空态文案，否则渲染 `null`（[packages/client/ui-settings-plugins/src/client/ConfigurablePluginsTab.tsx:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/ConfigurablePluginsTab.tsx#L42)）

### packages/client/ui-settings-plugins/src/client/PluginCard.module.css

插件卡片外壳的 CSS Module 样式表，被 `PluginCard.tsx` 引用。

- 无运行期机制

### packages/client/ui-settings-plugins/src/client/PluginCard.tsx

所有插件卡片共用的外壳组件，负责展开／收起、未保存标记以及保存与放弃两个按钮。

- 以组件内 `useState` 保存展开状态，展开与否不上报任何外部存储（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L48)）
- 用 `saveStarted` ref 记录保存已开始，保存结束后仅在 `dirty` 与 `failed` 均为假时把卡片收起（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:49-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L49-L61)）
- `available` 为假时整张卡片渲染 `null`（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L62)）
- 保存按钮的禁用条件由「不脏、有非法草稿、正在保存」三者取或算出（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L64)）
- 头部按钮把展开状态写进 `aria-expanded` 与无障碍标签，点击切换展开（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:67-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L67-L80)）
- `dirty` 为真时在收起状态下的头部也渲染未保存标记（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L78)）
- 卡片主体仅在展开时挂载，`writable` 为假时先渲染只读提示（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:81-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L81-L84)）
- `failed` 为真时以 `role="status"` 渲染保存失败提示（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L87)）
- 放弃按钮在不脏或正在保存时禁用，点击调用 `onDiscard`（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:88-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L88-L95)）
- 保存按钮按 `blocked` 禁用，点击调用 `onSave`，并在保存中改用保存中文案（[packages/client/ui-settings-plugins/src/client/PluginCard.tsx:96-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginCard.tsx#L96-L103)）

### packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.module.css

插件设置区与标签条的 CSS Module 样式表，被 `PluginsSettingsSection.tsx` 与 `ConfigurablePluginsTab.tsx` 引用。

- 无运行期机制

### packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx

设置区顶层组件，注册在 `settings.section` 上，把 `settings.plugins.tab` 的注册项投影成标签页。

- 通过注入的 `useTabs` 读取排序后的标签行（[packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx#L36)）
- 当前标签取自本地选中态，选中项不在行内时回落到第一行（[packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx#L39)）
- 用 effect 把每个被选中过的标签 id 累积进 `visitedIds` 集合（[packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx#L44-L50)）
- 标签行为空时只渲染空态文案，不渲染标签条与面板（[packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx#L56)）
- 每个标签按钮写入 `role="tab"`、`aria-selected`、`aria-controls` 与仅选中项为 0 的 `tabIndex`，点击切换选中（[packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx:62-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx#L62-L73)）
- 方向键、Home、End 按环绕规则算出下一索引，阻止默认行为后切换选中并把焦点移到该按钮（[packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx:74-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx#L74-L88)）
- 只为当前选中或曾访问过的标签渲染面板，未选中的面板以 `hidden` 保持挂载（[packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx:95-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx#L95-L107)）
- 面板内容以 `renderSlot('settings.plugins.tab', {}, { only: row.id })` 只分派该行对应的注册项（[packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/PluginsSettingsSection.tsx#L108)）

### packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.module.css

子代理模型选择卡片的 CSS Module 样式表，被 `SubagentModelSelectionCard.tsx` 引用。

- 无运行期机制

### packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx

子代理模型允许列表卡片的渲染组件，由 `settings.plugin.item` 槽以 `subagent-model-selection` 为键分派。

- 通过 `useSubagentModelSelectionCard` 读取卡片快照（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L26)）
- 把候选项按 `available` 拆成按 provider 分组的可用组与一条不可用列表（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:27-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L27-L46)）
- 每个候选项渲染一个复选框，勾选态取自 `selected`，在不可写或保存中时禁用，变更调用 `toggleModel(candidate.key)`（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:47-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L47-L63)）
- 权限开关以 `role="switch"` 渲染，`aria-checked` 取自 `enabled`，在不可写或保存中时禁用，点击调用 `toggleEnabled`（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:76-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L76-L86)）
- 整个模型选择区仅在 `enabled` 为真时渲染（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:92-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L92-L94)）
- `catalogStatus` 为 `loading` 时渲染加载提示，为 `error` 时以 `role="alert"` 渲染失败提示并给出调用 `retryCatalog` 的重试按钮（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:95-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L95-L107)）
- `catalogPartial` 为真时额外渲染部分提供方未加载的提示（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:108-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L108-L110)）
- 有候选项时按 provider 分组渲染，并把不可用项归入单独一组置于末尾；无候选项且状态为 `ready` 时渲染空态（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:111-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L111-L133)）
- `invalid` 为真时渲染「至少选一个」的提示（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L134)）
- `conflicted` 为真时以 `role="status"` 渲染修订冲突提示（[packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx:138-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/SubagentModelSelectionCard.tsx#L138-L140)）

### packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx

网页搜索提供方卡片的渲染组件，由 `settings.plugin.item` 槽以 `web-search-deepseek` 为键分派。

- 通过 `useWebSearchCard` 读取卡片快照，并由 `writable` 推出数值控件的禁用标志（[packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx:26-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx#L26-L27)）
- 密钥控件的禁用由 `apiKeyWritable` 单独决定，与设置文档的可写性分开（[packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx:41-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx#L41-L45)）
- 密钥控件只渲染暂存文本与 `apiKeyConfigured` 推出的状态文案，编辑调用 `edit('apiKey', text)`（[packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx#L46-L50)）
- 渲染 `baseURL` 文本控件（无 `numeric`），编辑与重置调用 `edit('baseURL', text)` 与 `resetField('baseURL')`（[packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx:51-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx#L51-L62)）
- 渲染 `maxUses` 数值控件，编辑与重置调用 `edit('maxUses', text)` 与 `resetField('maxUses')`（[packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx:63-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/WebSearchCard.tsx#L63-L75)）

### packages/client/ui-settings-plugins/src/client/agent-loop-card-controller.ts

agent-loop 卡片的控制器，把该命名空间的设置作用域接到共享的暂存表单上。

- 以字面量常量固定该卡片编辑的命名空间为 `agent-loop`（[packages/client/ui-settings-plugins/src/client/agent-loop-card-controller.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/agent-loop-card-controller.ts#L11)）
- 构造时用一个 `numberField('maxParallelToolCalls')` 建立 `CardForm`，并绑定一个随作用域与草稿变化重算的快照存储（[packages/client/ui-settings-plugins/src/client/agent-loop-card-controller.ts:42-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/agent-loop-card-controller.ts#L42-L45)）
- 投影把表单的公共外壳状态与该字段状态合成一个对象（[packages/client/ui-settings-plugins/src/client/agent-loop-card-controller.ts:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/agent-loop-card-controller.ts#L47-L49)）
- `inject()` 把快照存储与表单的 edit/resetField/save/discard 动作一并交给槽注册（[packages/client/ui-settings-plugins/src/client/agent-loop-card-controller.ts:55-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/agent-loop-card-controller.ts#L55-L57)）

### packages/client/ui-settings-plugins/src/client/bash-card-controller.ts

shell 卡片的控制器，把该命名空间的设置作用域接到共享的暂存表单上。

- 以字面量常量固定该卡片编辑的命名空间为 `shell`（[packages/client/ui-settings-plugins/src/client/bash-card-controller.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/bash-card-controller.ts#L12)）
- 构造时以 `timeoutMs` 与 `maxOutputBytes` 两个数值字段建立 `CardForm` 并绑定快照存储，只取服务端 schema 的这两项（[packages/client/ui-settings-plugins/src/client/bash-card-controller.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/bash-card-controller.ts#L44-L47)）
- 投影把外壳状态与两个字段状态合成卡片快照（[packages/client/ui-settings-plugins/src/client/bash-card-controller.ts:49-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/bash-card-controller.ts#L49-L55)）
- `inject()` 把快照存储与表单动作交给槽注册（[packages/client/ui-settings-plugins/src/client/bash-card-controller.ts:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/bash-card-controller.ts#L61-L63)）

### packages/client/ui-settings-plugins/src/client/card-form.ts

所有插件卡片共用的暂存表单模型，负责把草稿文本转成设置写入并在保存时回读结果。

- `numberField` 的 `format` 只把 `number` 渲染成文本，其余一律渲染为空串（[packages/client/ui-settings-plugins/src/client/card-form.ts:121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L121)）
- `numberField` 的 `parse` 把去空白后为空的草稿转成清除，非有限数返回 `undefined`（据此阻断保存），其余转成设置写入（[packages/client/ui-settings-plugins/src/client/card-form.ts:122-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L122-L127)）
- `textField` 的 `parse` 把去空白后为空的草稿转成清除，否则以去空白后的文本作为写入值（[packages/client/ui-settings-plugins/src/client/card-form.ts:137-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L137-L146)）
- 构造函数把字段规格与密文规格建成两张按字段名索引的表，并订阅设置作用域，作用域一变就重新发布投影（[packages/client/ui-settings-plugins/src/client/card-form.ts:168-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L168-L176)）
- `bind` 创建快照存储并把重算函数登记为监听器，之后每次发布都刷新该存储（[packages/client/ui-settings-plugins/src/client/card-form.ts:183-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L183-L187)）
- `shell()` 由作用域快照与写入计划算出 available（status 为 ready）、writable、dirty（计划非空）、invalid（存在无写入项）、saving、failed 六项（[packages/client/ui-settings-plugins/src/client/card-form.ts:193-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L193-L204)）
- `field()` 对密文字段只回暂存文本，永不报告覆盖或非法（[packages/client/ui-settings-plugins/src/client/card-form.ts:212-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L212-L215)）
- `field()` 无草稿时用生效值渲染文本，并以「用户层是否存在该键」判定覆盖标记（[packages/client/ui-settings-plugins/src/client/card-form.ts:217-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L217-L219)）
- `field()` 有草稿时按草稿解析结果预告覆盖态，解析失败即标为非法（[packages/client/ui-settings-plugins/src/client/card-form.ts:220-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L220-L225)）
- `resetField` 不立即写入，而是暂存一条带 `clear` 标记、文本取自基线层值的草稿（[packages/client/ui-settings-plugins/src/client/card-form.ts:235-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L235-L237)）
- `discard` 在既无草稿又未失败时直接返回，否则清空全部草稿与失败标记并发布（[packages/client/ui-settings-plugins/src/client/card-form.ts:239-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L239-L244)）
- `save()` 在计划为空、正在保存、或计划中存在无写入项时直接返回，不做任何写入（[packages/client/ui-settings-plugins/src/client/card-form.ts:258-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L258-L260)）
- `save()` 逐条串行执行写入并把每条的落地结果与总结果取与，全部落地才清空草稿，否则保留草稿并置失败（[packages/client/ui-settings-plugins/src/client/card-form.ts:261-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L261-L271)）
- `plan()` 对密文字段仅在去空白后非空时生成一条走密文写入函数的计划项（[packages/client/ui-settings-plugins/src/client/card-form.ts:283-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L283-L287)）
- `plan()` 对带 `clear` 标记的草稿，仅在用户层确实存有该字段时才生成清除项（[packages/client/ui-settings-plugins/src/client/card-form.ts:288-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L288-L292)）
- `plan()` 跳过与生效值渲染文本相同的草稿；解析失败的草稿生成 `run` 为 `undefined` 的计划项，使表单保持脏且保存被拒（[packages/client/ui-settings-plugins/src/client/card-form.ts:294-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L294-L298)）
- `clear` 调用作用域的 `unset` 后回读用户层，以「该字段已不存在」作为落地判据（[packages/client/ui-settings-plugins/src/client/card-form.ts:303-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L303-L306)）
- `store` 调用作用域的 `set` 后回读用户层，以「用户层该字段等于所写值」作为落地判据（[packages/client/ui-settings-plugins/src/client/card-form.ts:308-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L308-L311)）
- `stage` 每次暂存都清掉失败标记并发布（[packages/client/ui-settings-plugins/src/client/card-form.ts:313-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L313-L317)）
- `spec` 遇到未声明的字段名直接抛错，而不是退化成静默失效的控件（[packages/client/ui-settings-plugins/src/client/card-form.ts:319-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L319-L325)）
- 生效值、基线值、用户层分别读自作用域快照的 `value` / `base` / `user` 三层，覆盖判定用 `Object.hasOwn`（[packages/client/ui-settings-plugins/src/client/card-form.ts:331-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L331-L346)）
- `publish` 逐个调用已登记的监听器，把新投影推给所有绑定的快照存储（[packages/client/ui-settings-plugins/src/client/card-form.ts:348-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/card-form.ts#L348-L350)）

### packages/client/ui-settings-plugins/src/client/fields.module.css

字段控件的 CSS Module 样式表，被 `fields.tsx` 引用。

- 无运行期机制

### packages/client/ui-settings-plugins/src/client/fields.tsx

插件配置表单的两个手写控件，被各卡片组件用来渲染单个字段。

- `ValueField` 仅在 `overridden` 为真时渲染覆盖标记与重置按钮，重置按钮按 `disabled` 禁用并调用 `onReset`（[packages/client/ui-settings-plugins/src/client/fields.tsx:56-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/fields.tsx#L56-L70)）
- `numeric` 只追加 `inputMode: 'numeric'`，输入类型仍为 `text`，控件不改写用户键入的内容（[packages/client/ui-settings-plugins/src/client/fields.tsx:72-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/fields.tsx#L72-L76)）
- `invalid` 为真时给输入框加上 `aria-invalid` 并把下方说明换成非法提示文案（[packages/client/ui-settings-plugins/src/client/fields.tsx:77-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/fields.tsx#L77-L85)）
- 输入框值受控于传入的暂存文本，每次 `onChange` 把原始输入值交给 `onEdit`（[packages/client/ui-settings-plugins/src/client/fields.tsx:78-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/fields.tsx#L78-L81)）
- `SecretField` 只按 `configured` 切换状态标记的样式并渲染传入的状态文案，不渲染任何已存值（[packages/client/ui-settings-plugins/src/client/fields.tsx:107-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/fields.tsx#L107-L109)）
- `SecretField` 的输入框为 `type="password"` 且关闭自动填充，值受控于暂存文本，变更交给 `onEdit`（[packages/client/ui-settings-plugins/src/client/fields.tsx:111-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/fields.tsx#L111-L119)）

### packages/client/ui-settings-plugins/src/client/index.ts

浏览器半的插件体，挂载设置区、可配置页与本包自带的四张卡片，并接线各类失效信号。

- 声明该浏览器插件所需注入的服务列表，含 slots、locale、connection、remote 及其 credentials/session 子面与 settingsScope（[packages/client/ui-settings-plugins/src/client/index.ts:56-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L56-L58)）
- 绑定 `settings.plugins` 字典命名空间，并以 effect 注册 zh/en 两份词条（[packages/client/ui-settings-plugins/src/client/index.ts:65-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L65-L66)）
- 为四张卡片各绑定一个按命名空间取出的设置作用域，并把 credentials / session 两个 Remote 面分别交给 web-search 与 subagent 控制器（[packages/client/ui-settings-plugins/src/client/index.ts:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L68-L75)）
- 转发的 `credentials/reference-updated` 事件触发 web-search 卡片按引用重读凭据状态（[packages/client/ui-settings-plugins/src/client/index.ts:80-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L80-L83)）
- 转发的 `llm/adapters-updated` 事件触发 subagent 卡片重载模型目录（[packages/client/ui-settings-plugins/src/client/index.ts:84-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L84-L87)）
- 转发的 `settings/document-updated` 事件同样触发 subagent 卡片重载模型目录（[packages/client/ui-settings-plugins/src/client/index.ts:88-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L88-L91)）
- 本地 `connection/reset` 事件触发 subagent 卡片丢弃草稿与目录并推进代次（[packages/client/ui-settings-plugins/src/client/index.ts:92-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L92-L95)）
- 以 effect 登记 subagent 控制器与页控制器的 dispose，插件卸载时停止订阅（[packages/client/ui-settings-plugins/src/client/index.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L96-L101)）
- 页控制器同时接入设置的 describe 镜像与 `settings.plugin.item` 槽的当前注册项读取函数（[packages/client/ui-settings-plugins/src/client/index.ts:99-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L99-L100)）
- 订阅 `settings.plugin.item` 槽账本，晚注册的卡片无需任何网络调用即可加入列表（[packages/client/ui-settings-plugins/src/client/index.ts:103-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L103-L106)）
- 标签投影用槽版本号与 locale 修订号做缓存键，两者都未变时复用同一数组引用（[packages/client/ui-settings-plugins/src/client/index.ts:108-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L108-L130)）
- 标签行由槽注册项的 `id`、`order` 与解析后的 `label` 组成，并按 `order` 升序排序（[packages/client/ui-settings-plugins/src/client/index.ts:120-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L120-L127)）
- 标签可观察源同时订阅槽账本与 locale，退订时两者一并解除（[packages/client/ui-settings-plugins/src/client/index.ts:131-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L131-L138)）
- 注册 `settings.section` 条目 `plugins`，`order` 为 15，并声明 root 作用域的 list 型子槽 `settings.plugins.tab`（[packages/client/ui-settings-plugins/src/client/index.ts:145-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L145-L153)）
- 注册 `settings.plugins.tab` 条目 `configurable`，`order` 为 0，并声明 root 作用域的 keyed 型子槽 `settings.plugin.item`（[packages/client/ui-settings-plugins/src/client/index.ts:157-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L157-L165)）
- 以生成器逐条注册四张卡片到 `settings.plugin.item`，键依次为 shell、agent-loop、subagent-model-selection、web-search-deepseek，注册顺序即列表顺序（[packages/client/ui-settings-plugins/src/client/index.ts:167-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/index.ts#L167-L192)）

### packages/client/ui-settings-plugins/src/client/locales.ts

设置区与各卡片的中英文词条字典，由 `index.ts` 注册到 locale 服务。

- 无运行期机制

### packages/client/ui-settings-plugins/src/client/slot-contract.ts

`settings.plugin.item` 槽的类型声明文件，被各卡片组件以纯类型方式引入。

- 无运行期机制

### packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts

子代理模型允许列表卡片的控制器，把设置作用域与实时模型目录合成一份暂存卡片状态。

- 以字面量常量固定该卡片编辑的命名空间为 `subagent-model-selection`（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L12)）
- `subagentModelKey` 用 `\0` 连接 provider 与 model 生成查表用的不透明键（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:79-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L79-L81)）
- `subagentModelCandidates` 遍历目录生成 `available: true` 的候选并从已存表中删去命中项，剩余已存路由以 provider/model 原文作显示名、`available: false` 追加到末尾（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:90-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L90-L121)）
- `sameRoutes` 按长度与键集合比较两组路由，不看顺序（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:123-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L123-L127)）
- 作用域订阅回调中，若非保存中且存在草稿而修订号已变：内容一致则丢弃草稿，否则置 `conflicted`（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:155-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L155-L161)）
- 订阅回调与构造末尾都会在「已启用且目录仍为 idle」时触发一次目录加载（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:162-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L162-L165)）
- `dispose` 置终止标记、同时推进保存代次与目录代次以丢弃迟到的结算，并退订作用域（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:170-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L170-L174)）
- `inject()` 交出快照存储与 toggleEnabled / toggleModel / retryCatalog / save / discard 五个动作（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:180-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L180-L189)）
- 选中集合与启用态都优先取草稿、无草稿时回落到作用域生效值（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:199-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L199-L205)）
- `beginDraft` 首次建草稿时同时拍下启用态、路由表副本与当时的修订号，后续保存以该修订号设栅栏（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:207-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L207-L217)）
- `toggleEnabled` 在已终止、状态非 ready、不可写或保存中时直接返回，否则翻转草稿启用态、清失败标记，并在转为启用且目录 idle 时加载目录（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:219-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L219-L227)）
- `toggleModel` 在未启用、保存中或不可写时返回，且只接受当前候选列表中存在的键，命中即在草稿路由表中增删（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:229-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L229-L238)）
- `discard` 在保存中时不生效，否则清空草稿启用态、路由、修订号、失败与冲突标记（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:240-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L240-L252)）
- `candidates` 把生效路由与草稿路由合并后再与目录连接，使已保存但目录不再公布的路由仍可显示并移除（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:254-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L254-L258)）
- `save` 在已终止、非 ready、不可写、保存中、与生效值无差异、或启用却一条路由都没选时直接返回（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:264-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L264-L270)）
- `save` 发现当前修订号与草稿起始修订号不同即置 `conflicted` 并放弃写入（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:271-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L271-L275)）
- `save` 把 `enabled` 与 `allowedModels` 作为一次 `mutate` 提交，并以草稿起始修订号作为写入栅栏（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:281-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L281-L288)）
- `save` 结算时先比较保存代次，代次已变即整段放弃；否则以回读的生效值判断是否落地，落地才清草稿（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:289-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L289-L294)）
- `refreshCatalog` 推进目录代次、把状态复位为 idle 并清部分失败标记，已启用时立即重载、未启用时只发布（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:298-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L298-L305)）
- `resetConnection` 推进保存代次、清保存中标记与草稿、清空目录分组后再走一次目录刷新（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:308-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L308-L315)）
- `loadCatalog` 对已终止或正在加载直接返回，请求前后比对目录代次以丢弃过期响应，`ok` 为假时按错误处理（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:317-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L317-L333)）
- `loadCatalog` 成功时保存分组，并以响应中 `failures` 非空置 `catalogPartial`（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:327-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L327-L329)）
- `projection` 由启用态与路由差异算 `dirty`、由「启用且选中为空」算 `invalid`，并附上候选、目录状态、部分失败与冲突四项（[packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts:337-355](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/subagent-model-selection-card-controller.ts#L337-L355)）

### packages/client/ui-settings-plugins/src/client/tab-store.ts

可配置插件页的控制器，把服务端公布的设置命名空间与已注册的卡片求交后发布成页面快照。

- 构造时订阅 describe 镜像、调用一次 `ensure()` 触发首读，并立即发布一次（[packages/client/ui-settings-plugins/src/client/tab-store.ts:56-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/tab-store.ts#L56-L63)）
- `refresh()` 在未终止时重新发布，用于槽账本变化后让晚注册的卡片进入列表（[packages/client/ui-settings-plugins/src/client/tab-store.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/tab-store.ts#L66-L69)）
- `dispose()` 置终止标记并退订镜像，之后 `publish` 一律短路（[packages/client/ui-settings-plugins/src/client/tab-store.ts:72-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/tab-store.ts#L72-L75)）
- `publish` 以镜像的 `view` 是否存在作为 `loaded`，未答复时不出空态（[packages/client/ui-settings-plugins/src/client/tab-store.ts:87-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/tab-store.ts#L87-L88)）
- `publish` 按卡片注册顺序遍历槽条目，只保留其 `key` 出现在服务端命名空间集合中的那些（[packages/client/ui-settings-plugins/src/client/tab-store.ts:89-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/tab-store.ts#L89-L91)）
- `publish` 在 `loaded` 与命名空间序列都未变时直接返回，保持快照引用不变（[packages/client/ui-settings-plugins/src/client/tab-store.ts:92-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/tab-store.ts#L92-L100)）

### packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts

网页搜索卡片的控制器，把该命名空间的设置作用域与凭据域合成一份卡片状态。

- 以字面量常量固定命名空间 `web-search-deepseek`、默认凭据引用 `DEEPSEEK_API_KEY` 与密钥暂存字段名（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:24-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L24-L30)）
- 构造时用 `baseURL` 文本字段与 `maxUses` 数值字段建表单，并把密钥登记为写入函数走凭据域的密文字段（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:91-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L91-L95)）
- 构造时订阅作用域并立即发起一次凭据读取，之后每次设置变动都重读凭据（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:96-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L96-L98)）
- 投影把表单外壳、两个字段、密钥暂存文本与凭据的 configured / writable 合成卡片快照（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:101-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L101-L110)）
- `readCredential` 发现引用已变时先把本地凭据状态重置为「未配置、可写」并立即发布（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:121-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L121-L127)）
- `readCredential` 吞掉 describe 抛出的异常并直接返回，保留上一次已知状态（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:128-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L128-L135)）
- `readCredential` 在响应非 ok 或引用已被换掉时丢弃该响应，防止乱序结算覆盖当前状态（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L136)）
- 响应中未知引用的 `writable` 缺省按可写处理，把拒绝权交给服务端（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:137-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L137-L144)）
- 只有 configured 或 writable 真的变化时才写入快照存储（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:145-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L145-L147)）
- `refreshCredential` 只对与当前所盯引用一致的通知触发重读，其余忽略（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:158-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L158-L161)）
- `writeKey` 把密钥写往凭据域、吞掉写入异常，再重读一次并以「服务端报告已配置」作为该条写入的落地判据（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:176-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L176-L185)）
- `refOf` 取设置中非空的 `apiKeyEnv` 作为凭据引用，否则回落到默认引用（[packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts:193-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/client/web-search-card-controller.ts#L193-L196)）

### packages/client/ui-settings-plugins/src/css-modules.d.ts

CSS Module 导入的环境类型声明。

- 无运行期机制

### packages/client/ui-settings-plugins/src/index.ts

该包的 node 半插件体，本身不注册任何设置命名空间。

- 无运行期机制

### packages/client/ui-settings-plugins/src/invariant.ts

该包的 invariant companion 插件，向 invariants 服务登记本包的所有权。

- 导出 companion 插件名与所需注入的 `invariants` 服务（[packages/client/ui-settings-plugins/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/invariant.ts#L13-L15)）
- `apply` 以包名注册一个空的 installer，并把注册返回的 disposer 作为解析值交回（[packages/client/ui-settings-plugins/src/invariant.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/src/invariant.ts#L22-L30)）

### packages/client/ui-settings-plugins/tsconfig.json

该包的 TypeScript 编译配置与工程引用清单。

- 无运行期机制

### packages/client/ui-settings-plugins/tsdown.config.ts

该包的打包配置，决定浏览器半的产物入口。

- 用共享的 `clientBundle` 预设，以包名与 `lib/types/index.js`、`lib/types/invariant.js` 两个入口生成打包配置（[packages/client/ui-settings-plugins/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugins/tsdown.config.ts#L1-L3)）
