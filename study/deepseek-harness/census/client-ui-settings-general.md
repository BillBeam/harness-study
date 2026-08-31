---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-settings-general
---

# packages/client/ui-settings-general

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 19 个文件、75 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-settings-general/README.md

包的说明文档，介绍设置外壳、General 分区、本地配置文件动作与 onboarding 台阶的组成方式，供阅读者了解该包。

- 无运行期机制

### packages/client/ui-settings-general/package.json

包清单，声明该包的入口解析、注入依赖与发布内容。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定默认导入解析到的产物（[packages/client/ui-settings-general/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./client`、`./src/*` 与 `./package.json` 五个入口，`./client` 解析到 `lib/client.js`（[packages/client/ui-settings-general/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/package.json#L16-L31)）
- `dsh.client.inject` 列出该客户端插件加载前必须存在的五个包，`platform` 标为 `web`（[packages/client/ui-settings-general/package.json:32-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/package.json#L32-L43)）
- `files` 把发布内容限制为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与类型声明（[packages/client/ui-settings-general/package.json:83-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/package.json#L83-L88)）

### packages/client/ui-settings-general/src/client/GeneralSection.module.css

General 分区的样式模块，被 GeneralSection.tsx 引用。

- 无运行期机制

### packages/client/ui-settings-general/src/client/GeneralSection.tsx

General 分区组件，被 client/index.ts 注册到 `settings.section` 槽。

- 组件体把 `settings.general.item` 槽的全部登记内容渲染成一列（[packages/client/ui-settings-general/src/client/GeneralSection.tsx:14-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/GeneralSection.tsx#L14-L19)）

### packages/client/ui-settings-general/src/client/SettingsDocumentAction.module.css

打开配置文件动作的样式模块，被 SettingsDocumentAction.tsx 引用。

- 无运行期机制

### packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx

设置面板头部的“打开配置文件”动作组件，由 client/index.ts 在 loopback 条件下注册到 `settings.action` 槽。

- 通过 `useSnapshot` 订阅注入的控制器快照，快照变动触发重渲染（[packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx#L30)）
- 挂载时（以及 controller 变化时）调用 `controller.load()` 发起可用性读取（[packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx#L32-L34)）
- 状态不是 `ready` 时返回 null，不渲染任何节点（[packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx#L36)）
- `state.error` 非空时渲染一个 `role="alert"` 的本地化错误文本（[packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx#L40)）
- 按钮在 `state.opening` 期间置为 disabled，点击调用 `controller.open()`（[packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx:41-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsDocumentAction.tsx#L41-L48)）

### packages/client/ui-settings-general/src/client/SettingsRoot.module.css

设置外壳（触发行、遮罩、面板、导航、内容区）的样式模块，被 SettingsRoot.tsx 引用。

- 无运行期机制

### packages/client/ui-settings-general/src/client/SettingsRoot.tsx

设置外壳根组件，注册在 `sidebar.settings` 槽上，渲染侧栏底部触发行、模态面板与 onboarding 台阶。

- `navIcon` 按分区 id 分派导航图标，未知 id 落到齿轮图标（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:23-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L23-L28)）
- 面板按 `activeId` 查找当前行，找不到时回落到第一行的 id（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L46)）
- 面板挂载期间在 document 上监听 keydown，Escape 触发关闭，卸载时移除监听（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:49-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L49-L55)）
- 面板挂载后把焦点移到关闭按钮（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:58-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L58-L59)）
- 遮罩层点击触发关闭（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L63)）
- 面板容器带 `role="dialog"`、`aria-modal` 与指向标题节点的 `aria-labelledby`（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L64)）
- 导航标题节点渲染 `settings.header` 槽内容，并承担 dialog 的可访问名（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L66)）
- 每个导航行渲染成按钮，带 `aria-current`，点击调用 `onSelect(row.id)` 切换分区（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:68-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L68-L79)）
- 头部区渲染 `settings.action` 槽的全部登记项（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L84)）
- 关闭按钮点击触发关闭，其可访问名来自 `settings.close` 槽内容（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:85-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L85-L88)）
- 内容区只渲染 id 等于当前 active 的那个 `settings.section` 登记项，并把 `close` 回调传给它（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L91)）
- 模态开合与当前分区 id 存为组件本地 state（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:106-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L106-L107)）
- 已完成的 onboarding 台阶 id 存为组件本地集合（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L108)）
- `close` 同时关闭面板并清空当前分区 id（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:109-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L109-L112)）
- `openSection(id)` 设定分区 id 并打开面板，作为回调交给 onboarding 台阶（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:113-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L113-L116)）
- 导航行与 onboarding 台阶列表通过注入的 hooks 订阅读取（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:121-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L121-L122)）
- onboarding 是否激活由会话状态派生：phase 为 ready 且当前会话不存在或标记为 blank（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:123-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L123-L125)）
- 激活时取有序台阶中第一个未完成的作为当前台阶，未激活时为 undefined（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:126-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L126-L128)）
- onboarding 转为未激活时清空已完成集合（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:130-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L130-L133)）
- `completeOnboardingStep` 把 id 加入已完成集合，重复调用返回原集合（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:135-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L135-L140)）
- 触发按钮带 `aria-haspopup="dialog"` 与随开合更新的 `aria-expanded`，点击打开面板，内容来自 `settings.trigger` 槽并接收 `wide`（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:144-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L144-L152)）
- 面板仅在 open 为真时挂载（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:153-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L153-L161)）
- 只渲染当前台阶那一个 `settings.onboarding` 登记项，传入 `stepId`、`complete()` 与 `openSection`（[packages/client/ui-settings-general/src/client/SettingsRoot.tsx:165-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/SettingsRoot.tsx#L165-L169)）

### packages/client/ui-settings-general/src/client/chrome.module.css

触发行标签的样式模块，被 chrome.tsx 引用。

- 无运行期机制

### packages/client/ui-settings-general/src/client/chrome.tsx

外壳 chrome 内容组件，被 client/index.ts 注册到 `settings.trigger`、`settings.header`、`settings.close` 三个槽。

- `TriggerContent` 按 `wide` 选择不同尺寸的图标，且仅在 wide 时额外渲染本地化标签（[packages/client/ui-settings-general/src/client/chrome.tsx:22-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/chrome.tsx#L22-L29)）
- `HeaderContent` 渲染 `t('title')` 作为面板标题文本（[packages/client/ui-settings-general/src/client/chrome.tsx:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/chrome.tsx#L36-L38)）
- `CloseLabel` 渲染 `t('close')` 作为关闭按钮的隐藏标签文本（[packages/client/ui-settings-general/src/client/chrome.tsx:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/chrome.tsx#L48-L50)）

### packages/client/ui-settings-general/src/client/index.ts

该包的浏览器侧插件入口，声明注入、注册字典与各个槽的内容，并组装外壳注入面。

- 导出 `inject` 列出该插件激活前需要的服务：slots、locale、connection、remote、remote.settings、settingsScope（[packages/client/ui-settings-general/src/client/index.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L58)）
- 以 effect 注册 `settings` 命名空间的中英字典，卸载时随 effect 撤销（[packages/client/ui-settings-general/src/client/index.ts:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L66)）
- 绑定该命名空间的 `t`，供分区导航标签 thunk 使用（[packages/client/ui-settings-general/src/client/index.ts:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L71)）
- 仅当连接为 loopback 时构造 `SettingsDocumentStore`，否则不构造（[packages/client/ui-settings-general/src/client/index.ts:72-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L72-L76)）
- 把控制器与其快照源打包成动作组件的注入面，控制器不存在时注入面也不存在（[packages/client/ui-settings-general/src/client/index.ts:77-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L77-L82)）
- 以 effect 登记卸载动作，插件销毁时调用控制器的 `dispose()`（[packages/client/ui-settings-general/src/client/index.ts:83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L83)）
- 用模块级变量缓存导航行投影及其账本版本号与 locale 修订号（[packages/client/ui-settings-general/src/client/index.ts:89-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L89-L93)）
- `sections.getSnapshot` 在账本版本或 locale 修订变化时重算：取 `settings.section` 条目，映射出 id/order/label（label 经 `resolveSlotLabel` 解析）并按 order 升序排序，否则返回缓存（[packages/client/ui-settings-general/src/client/index.ts:97-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L97-L113)）
- `sections.subscribe` 同时订阅分区账本与 locale，返回同时取消两者的函数（[packages/client/ui-settings-general/src/client/index.ts:114-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L114-L121)）
- `onboardingSteps.getSnapshot` 在 `settings.onboarding` 账本版本变化时重算 id/order 并按 order 升序排序，否则返回缓存（[packages/client/ui-settings-general/src/client/index.ts:124-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L124-L137)）
- `onboardingSteps.subscribe` 订阅 onboarding 账本（[packages/client/ui-settings-general/src/client/index.ts:138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L138)）
- 在 `sidebar.settings` 槽声明可用后注册 `SettingsRoot`，并同时声明 trigger/header/action/close/section/onboarding 六个子槽及其 kind 与 scope（[packages/client/ui-settings-general/src/client/index.ts:142-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L142-L153)）
- 分别在 `settings.trigger` 与 `settings.header` 槽可用后注册对应 chrome 内容组件（[packages/client/ui-settings-general/src/client/index.ts:155-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L155-L158)）
- 仅当文档注入面存在时才把 `open-document` 动作注册进 `settings.action` 槽（order 为 0）（[packages/client/ui-settings-general/src/client/index.ts:159-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L159-L167)）
- 在 `settings.close` 槽可用后注册关闭标签组件（[packages/client/ui-settings-general/src/client/index.ts:168-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L168-L169)）
- 注册 id 为 `general`、order 为 0 的分区，标签为随 locale 解析的 thunk，并声明子槽 `settings.general.item`（[packages/client/ui-settings-general/src/client/index.ts:170-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/index.ts#L170-L177)）

### packages/client/ui-settings-general/src/client/locales.ts

外壳 chrome 与 General 导航的文案字典，被 client/index.ts 注册进 locale 服务。

- 导出 zh 与 en 两份键值一致的字典对象，注册后决定触发行、面板标题、关闭标签、打开配置文件按钮及其错误文本、General 导航标签的显示文本（[packages/client/ui-settings-general/src/client/locales.ts:4-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/locales.ts#L4-L24)）

### packages/client/ui-settings-general/src/client/settings-document-store.ts

本地设置文档动作的状态持有者，由 client/index.ts 在 loopback 下构造并注入给动作组件。

- `messageOf` 把任意抛出值转成字符串错误文本（[packages/client/ui-settings-general/src/client/settings-document-store.ts:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/settings-document-store.ts#L17-L19)）
- 构造一个初值为 `idle`/未打开/无错误的快照 store，作为组件订阅源（[packages/client/ui-settings-general/src/client/settings-document-store.ts:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/settings-document-store.ts#L24-L26)）
- `load()` 幂等地订阅共享镜像（变动时重新派生），置状态为 loading 并清错误，等待 `ensure()` 后派生一次（[packages/client/ui-settings-general/src/client/settings-document-store.ts:44-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/settings-document-store.ts#L44-L52)）
- `open()` 在状态非 ready 或已有请求在飞时直接返回，否则置 opening 并清错误，调用远端 `settings.openSettingsDocument()`，结果非 ok 时抛错，捕获后写入错误文本，finally 清除 opening（[packages/client/ui-settings-general/src/client/settings-document-store.ts:58-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/settings-document-store.ts#L58-L73)）
- `dispose()` 取消镜像订阅并清空订阅句柄（[packages/client/ui-settings-general/src/client/settings-document-store.ts:76-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/settings-document-store.ts#L76-L79)）
- `derive()` 在镜像无视图时：有错误则置 unavailable 并带上错误，无错误则保持当前状态不动（[packages/client/ui-settings-general/src/client/settings-document-store.ts:81-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/settings-document-store.ts#L81-L93)）
- `derive()` 在镜像有视图时按 `hasDocument` 置 ready 或 unavailable 并清空错误（[packages/client/ui-settings-general/src/client/settings-document-store.ts:94-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/client/settings-document-store.ts#L94-L98)）

### packages/client/ui-settings-general/src/client/shell-contract.ts

设置外壳的类型声明文件，定义导航行、onboarding 台阶与外壳组件的注入面与 props 类型。

- 无运行期机制

### packages/client/ui-settings-general/src/css-modules.d.ts

CSS Module 的 TypeScript 模块声明。

- 无运行期机制

### packages/client/ui-settings-general/src/index.ts

该包的 Host 侧加载入口，注册产品级 GUI onboarding 的持久化设置命名空间。

- 定义持久化设置命名空间名 `ui-onboarding`（[packages/client/ui-settings-general/src/index.ts:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/index.ts#L8)）
- 定义该命名空间的校验 schema，含可选的 `welcomeNoticeVersion` 字符串字段（[packages/client/ui-settings-general/src/index.ts:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/index.ts#L15-L17)）
- `apply` 在 `settings` 服务可用时把该命名空间与 schema 注册进设置服务（[packages/client/ui-settings-general/src/index.ts:20-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/index.ts#L20-L27)）

### packages/client/ui-settings-general/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包归属。

- 导出插件名与 `inject = ['invariants']`，决定该伴生插件的注册名与激活前置条件（[packages/client/ui-settings-general/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/invariant.ts#L13-L15)）
- 安装器为空实现，不注册任何运行期检查（[packages/client/ui-settings-general/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/invariant.ts#L23)）
- `apply` 以包名向 invariants 服务注册该空安装器并返回其 disposer（[packages/client/ui-settings-general/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/src/invariant.ts#L30-L31)）

### packages/client/ui-settings-general/tsconfig.json

该包的 TypeScript 编译配置，声明客户端基配置、输出目录与工程引用。

- 无运行期机制

### packages/client/ui-settings-general/tsdown.config.ts

该包的打包配置，被 `pnpm bundle` 使用。

- 以客户端打包预设声明该包的两个打包入口 `lib/types/index.js` 与 `lib/types/invariant.js`，决定生成哪些运行时产物（[packages/client/ui-settings-general/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-general/tsdown.config.ts#L3)）
