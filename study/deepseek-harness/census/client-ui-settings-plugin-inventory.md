---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-settings-plugin-inventory
---

# packages/client/ui-settings-plugin-inventory

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、37 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-settings-plugin-inventory/README.md

该包的英文说明文档，介绍插件清单标签页的读取时机、卡片内容与失败重试。

- 无运行期机制

### packages/client/ui-settings-plugin-inventory/package.json

该包的 npm 清单，声明入口映射、客户端注入依赖与发布文件集。

- `main`/`types` 与 `exports` 把 `.`、`./invariant`、`./client` 三个入口指向 `lib/` 下的具体产物，并额外放开 `./src/*` 与 `./package.json`（[packages/client/ui-settings-plugin-inventory/package.json:14-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/package.json#L14-L31)）
- `dsh.client.inject` 列出该客户端插件加载前必须存在的三个包，`platform` 限定为 `web`（[packages/client/ui-settings-plugin-inventory/package.json:32-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/package.json#L32-L41)）
- `files` 只发布 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与类型声明（[packages/client/ui-settings-plugin-inventory/package.json:70-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/package.json#L70-L75)）

### packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.module.css

插件清单标签页的 CSS Module，定义分栏卡片、搜索框、状态点与展开细节的样式。

- 无运行期机制

### packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx

插件清单标签页的 React 组件，挂载后拉取一次 Host 插件清单快照并渲染可搜索的卡片目录。

- `PHASE_KEYS` 把每个根 fiber 阶段映射到一个词条键，`phaseLabel` 对 `null` 阶段改用 `unobserved` 词条（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:31-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L31-L45)）
- `moduleShortName` 去掉 npm scope 前缀，再依次剥掉 `cordis:`、`cordis-plugin-`、`dsh-`（含 `host-`/`client-`）前缀作为卡片标题（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:48-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L48-L54)）
- `matches` 在查询为空时放行全部，否则以本地化小写子串同时匹配 `moduleName` 与 `entryId`（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L57-L61)）
- 组件以 `loading` 视图状态、空查询、无展开项初始化，并申请一个 `useId` 作为细节区 id 前缀（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:65-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L65-L69)）
- 挂载后把 `list()` 推迟到一个微任务再调用，成功写 `ready` 快照、失败写 `error`；effect 依赖 `[list, request]`，清理函数置位标志丢弃过期响应（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:71-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L71-L78)）
- 查询先 trim 再本地化小写，过滤结果按 `[normalizedQuery, state]` 记忆化，非 ready 状态下为空数组（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:80-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L80-L86)）
- 已展开项被过滤掉时自动收起（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:88-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L88-L92)）
- `retry` 把状态复位为 `loading` 并递增 `request`，从而重跑取数 effect（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:94-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L94-L97)）
- 容器的 `aria-busy` 跟随加载状态（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L100)）
- 加载中渲染加载文案；失败渲染 `role="alert"` 的通用失败文案与重试按钮，不暴露传输细节（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:101-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L101-L107)）
- 受控搜索框在 `onChange` 时写入查询状态，并带 `aria-label` 与视觉隐藏的标签文本（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:110-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L110-L120)）
- 标题行输出过滤后条目数，并写入 `data-plugin-count` 属性（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:121-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L121-L124)）
- 快照本身为空时渲染 `empty` 文案，快照非空但过滤为空时渲染 `emptySearch` 文案（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:125-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L125-L128)）
- 每张卡片以 `entryId` 作为 React key 与 `data-plugin-entry`，展开态写入 `data-open`（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:131-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L131-L143)）
- 每张卡片先算出状态文本、短名标题、启用/停用标签文案与是否处于展开态（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:132-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L132-L135)）
- 细节区 id 由 `useId` 前缀加 `encodeURIComponent(entryId)` 拼成，供 `aria-controls` 引用（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L136)）
- 卡片按钮点击在展开与收起之间切换，同一时刻至多一项展开；`aria-label` 按是否启用决定是否含运行状态（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:144-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L144-L153)）
- 卡片标题的 `title` 属性给出完整模块名（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L154)）
- 状态点只在启用条目上渲染，`data-phase` 取阶段或 `unobserved`，并带同文本的 `aria-label` 与 `title`（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:156-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L156-L164)）
- 启用标签渲染 `enabledTag`/`disabledTag` 文案并写入 `data-enabled` 属性（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:165-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L165-L167)）
- 展开后的细节区渲染原样 `entryId`、配置状态，并只在启用时追加 Cordis 状态一栏（[packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx:171-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/PluginInventorySettingsTab.tsx#L171-L187)）

### packages/client/ui-settings-plugin-inventory/src/client/index.ts

该包的浏览器插件体，注册词条字典并把清单标签页挂进设置的插件分区。

- 声明 `inject` 需要 `slots`、`locale`、`remote` 以及生成的 `remote.pluginInventory` 面（[packages/client/ui-settings-plugin-inventory/src/client/index.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/index.ts#L24)）
- 通过 `ctx.effect` 注册 `zh`/`en` 字典，使其随插件卸载一并撤销（[packages/client/ui-settings-plugin-inventory/src/client/index.ts:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/index.ts#L28)）
- `list` 调用 `ctx.remote.pluginInventory.list()`，返回 `ok: false` 时抛出带错误码与消息的 Error，否则交出 `value`（[packages/client/ui-settings-plugin-inventory/src/client/index.ts:31-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/index.ts#L31-L37)）
- 用 `ctx.slots.inject` 跟随 `settings.plugins.tab` 槽的声明与撤销，在其中以 id `all`、order `10`、动态 `label` 与 `locale` 注册该组件（[packages/client/ui-settings-plugin-inventory/src/client/index.ts:40-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/client/index.ts#L40-L47)）

### packages/client/ui-settings-plugin-inventory/src/client/locales.ts

该标签页的中英文词条字典，中文字典同时作为键集来源。

- 无运行期机制

### packages/client/ui-settings-plugin-inventory/src/css-modules.d.ts

给 `*.module.css` 与 `*.css` 导入声明类型的环境声明文件。

- 无运行期机制

### packages/client/ui-settings-plugin-inventory/src/index.ts

该包的 Host 侧加载入口，浏览器实现由 `./client` 导出。

- 无运行期机制

### packages/client/ui-settings-plugin-inventory/src/invariant.ts

该包的不变量伴生插件模块，向不变量服务登记包名。

- 声明 `inject = ['invariants']`，使该伴生插件在不变量服务就绪后才执行（[packages/client/ui-settings-plugin-inventory/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/invariant.ts#L10-L12)）
- `apply` 用空安装器登记包名并返回该注册的 disposer（[packages/client/ui-settings-plugin-inventory/src/invariant.ts:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/src/invariant.ts#L15-L19)）

### packages/client/ui-settings-plugin-inventory/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、声明输出目录与工程引用。

- 无运行期机制

### packages/client/ui-settings-plugin-inventory/tsdown.config.ts

该包的打包配置，决定发布产物里存在哪些运行时入口。

- 以包名与 `lib/types/index.js`、`lib/types/invariant.js` 两个入口调用共享的客户端打包配置，产出对应的运行时 bundle（[packages/client/ui-settings-plugin-inventory/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-settings-plugin-inventory/tsdown.config.ts#L1-L3)）
