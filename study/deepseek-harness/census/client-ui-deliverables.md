---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-deliverables
---

# packages/client/ui-deliverables

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、66 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-deliverables/README.md

包说明文档，描述产物行、行内代码提及链接与该包注册的系统提示词段落。

- 无运行期机制

### packages/client/ui-deliverables/package.json

包清单，声明入口导出、客户端半边发现信息与发布文件列表。

- `exports` 暴露 `.`、`./invariant`、`./client`、`./src/*` 四个入口，`./client` 指向 `lib/client.js`（[packages/client/ui-deliverables/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/package.json#L16-L31)）
- `dsh.client` 声明浏览器半边需注入的六个包与 `platform: "web"`，供加载器发现客户端半边（[packages/client/ui-deliverables/package.json:32-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/package.json#L32-L44)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与类型声明（[packages/client/ui-deliverables/package.json:80-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/package.json#L80-L85)）

### packages/client/ui-deliverables/src/client/ProducedFiles.module.css

产物行组件的 CSS Module，被 `ProducedFiles.tsx` 以 `css` 引入。

- `.row` 设 `flex-wrap: nowrap` 与 `overflow: hidden`，使 chip 行不换行也不横向滚动（[packages/client/ui-deliverables/src/client/ProducedFiles.module.css:22-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.module.css#L22-L31)）
- `.file` 限定 `max-width: 320px` 并以省略号截断超长文本（[packages/client/ui-deliverables/src/client/ProducedFiles.module.css:35-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.module.css#L35-L49)）
- `.measure` 以零宽高、`visibility: hidden`、`contain: strict` 承载测量探针，使其不进入布局与滚动宽度（[packages/client/ui-deliverables/src/client/ProducedFiles.module.css:89-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.module.css#L89-L99)）
- `.probe` 用绝对定位加 `width: max-content` 让每个探针按自然宽度被量取（[packages/client/ui-deliverables/src/client/ProducedFiles.module.css:101-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.module.css#L101-L105)）

### packages/client/ui-deliverables/src/client/ProducedFiles.tsx

产物行 React 组件与其宽度拟合函数，由客户端插件注册进对话视图的 `conversation.chat.turnTail` 槽位。

- `SHOWN_LIMIT` 固定为 6，最多参与展示的 chip 数（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L9)）
- `fitProducedFiles` 在可用宽度非正时直接返回全部 chip 数（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L25)）
- `fitProducedFiles` 先累加出每个前缀长度的 chip 宽度和（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:26-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L26-L31)）
- `fitProducedFiles` 对每个候选前缀按 chip 宽度加余量宽度加间隙求所需宽度，取仍能容纳的最大前缀（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:32-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L32-L39)）
- `moreLabel` 按剩余数为 1 与否选用两个不同的本地化键（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:59-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L59-L61)）
- 组件挂载时调用 `ensureWorkspacePathOpen()` 触发宿主打开能力查询（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L71)）
- 仅当页面是回环连接且宿主能力查询为 `true` 时 `canOpenPath` 成立（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:72-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L72-L73)）
- `limit` 取路径数与 `SHOWN_LIMIT` 的较小值，并作为 `shownCount` 初值（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:74-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L74-L75)）
- 布局副作用从行元素的 computed style 取 `columnGap` 或 `gap` 作为间隙，解析失败取 0（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:86-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L86-L87)）
- 用 `getBoundingClientRect().width` 量取每个候选 chip 探针的宽度（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:89-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L89-L90)）
- 对每个候选展示数写入对应的本地化余量文案再量宽，展示数等于总数时记为 `undefined`（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:91-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L91-L95)）
- 用行的 `clientWidth` 与量到的宽度调用 `fitProducedFiles` 并写回 `shownCount`（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L96)）
- 环境无 `ResizeObserver` 时只测量一次；否则观察行与全部探针，尺寸变化即重测，卸载时断开（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:98-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L98-L106)）
- 实际展示数再与 `limit` 取小，剩余数为总数减去已展示数（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:108-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L108-L110)）
- 每个 chip 显示 basename、`title` 挂完整路径、`aria-label` 用本地化打开文案，点击调用 `openFile(path)`（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:115-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L115-L128)）
- 有剩余时在行尾渲染余量文案（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L129)）
- 有剩余且 `canOpenPath` 成立时渲染在文件夹中显示按钮，点击调用 `openFile('.')`（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:131-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L131-L135)）
- 渲染 `aria-hidden` 的测量区：`limit` 个 chip 探针加一个余量探针，并把 chip 节点写入 ref 数组（[packages/client/ui-deliverables/src/client/ProducedFiles.tsx:136-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/ProducedFiles.tsx#L136-L149)）

### packages/client/ui-deliverables/src/client/index.ts

浏览器半边插件入口，注册产物行槽位、字典、Turn 数据定义与 `chatFileMentions` 服务。

- `inject` 声明该插件所需的服务名列表（[packages/client/ui-deliverables/src/client/index.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L35)）
- 建立初值为 `undefined` 的宿主打开能力快照存储（[packages/client/ui-deliverables/src/client/index.ts:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L43)）
- `loadWorkspacePathOpen` 在已有在飞请求时直接返回，避免重复发起（[packages/client/ui-deliverables/src/client/index.ts:47-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L47-L48)）
- 远端 `canOpenWorkspacePath()` 成功后按 revision 校验再写入 `result.ok && result.value`（[packages/client/ui-deliverables/src/client/index.ts:50-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L50-L53)）
- 查询失败时按同一 revision 校验后写入 `false`（[packages/client/ui-deliverables/src/client/index.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L53-L55)）
- `finally` 中仅在仍是同一 Promise 时清空在飞标记（[packages/client/ui-deliverables/src/client/index.ts:56-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L56-L58)）
- `ensureWorkspacePathOpen` 记录已被请求过，且仅在快照仍为 `undefined` 时发起查询（[packages/client/ui-deliverables/src/client/index.ts:61-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L61-L64)）
- 监听 `connection/reset`：递增 revision、丢弃在飞请求、把快照重置为 `undefined`，若此前被请求过则重新查询（[packages/client/ui-deliverables/src/client/index.ts:65-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L65-L70)）
- 向对话事件注册 `deliverablesDefinition`（[packages/client/ui-deliverables/src/client/index.ts:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L71)）
- 以 `ctx.effect` 注册中英双语字典（[packages/client/ui-deliverables/src/client/index.ts:72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L72)）
- 通过 `slots.inject` 把 `ProducedFiles` 注册进 `conversation.chat.turnTail`，`select` 为 `selectProducedFiles`，并注入 `isLoopback`、`ensureWorkspacePathOpen` 与能力快照（[packages/client/ui-deliverables/src/client/index.ts:73-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L73-L85)）
- `chatFileMentions.forClosing` 用同一个 `selectProducedFiles` 判定，无产物返回 `undefined`，否则返回由产物路径构成的提及解析器（[packages/client/ui-deliverables/src/client/index.ts:88-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L88-L97)）
- 以 `ctx.provide` 对外提供 `chatFileMentions` 服务（[packages/client/ui-deliverables/src/client/index.ts:98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/index.ts#L98)）

### packages/client/ui-deliverables/src/client/locales.ts

`deliverables` 命名空间的中英文案字典与键类型，被客户端插件注册、被组件通过 `t` 读取。

- 无运行期机制

### packages/client/ui-deliverables/src/client/turn-deliverables.ts

Turn 级产物路径的累积定义与读取函数，供槽位选择器和行内提及解析共用。

- `mutationPath` 对参数 JSON 解析失败时返回 `null`（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L42-L46)）
- 解析结果不是对象时返回 `null`（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L48)）
- 按工具名分派：`write` 要求 `content` 为字符串，`edit` 要求参数合法，`str_replace_editor` 走编辑器分支，其余工具一律返回 `null`（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:49-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L49-L58)）
- `validEditArgs` 要求 `old_string` 非空字符串、`new_string` 为字符串且两者不相等，`replace_all` 缺省或为布尔（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:62-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L62-L68)）
- `editorMutationPath` 按 `command` 分派：`create` 要求 `file_text` 为字符串，`str_replace` 要求 `old_str` 非空且 `new_str` 缺省或为字符串，`insert` 要求 `insert_line` 为非负整数且 `new_str` 为字符串，其余命令返回 `null`（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:71-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L71-L93)）
- `pathValue` 只接受去空白后非空的字符串，并保留原始拼写（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:96-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L96-L98)）
- `producedForClosing` 在数据缺失时返回空数组（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L126)）
- `producedForClosing` 跳过 seq 大于收尾 seq 的记录并按首次出现顺序去重（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:127-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L127-L134)）
- `selectProducedFiles` 读取该 Turn 的 `deliverables` 数据，路径为空则返回 `null` 从而不挂载组件（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:142-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L142-L145)）
- 定义的 `match` 把 `turn/start` 归为 start、`tool/call` 与通过 `isAppendSurfaceEvent` 的 `tool/result` 归为 update，其余事件不参与（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L150-L157)）
- `start` 在事件不是 `turn/start` 时抛错，否则建立空的调用表与产物表（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:158-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L158-L161)）
- `tool/call` 时把 `callId` 映射到解析出的变更路径写入调用表（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:162-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L162-L170)）
- `tool/result` 的首条内容标记为错误时不记入产物（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:172-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L172-L173)）
- 成功结果按 `callId` 取回路径，无路径则不变，否则追加 `{ seq, path }`（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:174-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L174-L178)）
- `buildLocationData` 仅在 `turn` 作用域且状态存在时发布 `deliverables` 键的产物数据，否则返回 `null`（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:180-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L180-L187)）
- `basename` 取最后一个正斜杠或反斜杠之后的片段，无分隔符时返回整串（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:195-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L195-L198)）
- `producedFileMentions.resolve` 先按完整路径精确匹配，否则按唯一 basename 匹配，命中则返回带 `open`、`label`、`title` 的记录（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:212-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L212-L224)）
- `onlyPathWithBasename` 仅在恰好一条路径的 basename 相等时返回该路径，多条命中返回 `undefined`（[packages/client/ui-deliverables/src/client/turn-deliverables.ts:227-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/client/turn-deliverables.ts#L227-L230)）

### packages/client/ui-deliverables/src/css-modules.d.ts

CSS Module 的 TypeScript 环境声明。

- 无运行期机制

### packages/client/ui-deliverables/src/index.ts

宿主半边插件入口，注册面向模型的最终回复文件引用格式段落。

- `inject` 声明依赖 `systemPrompt` 服务（[packages/client/ui-deliverables/src/index.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/index.ts#L12)）
- 定义一段固定文本，要求模型在最终回复中提及创建或修改的主要文件，并以精确路径或唯一 basename 的 Markdown 行内代码书写（[packages/client/ui-deliverables/src/index.ts:15-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/index.ts#L15-L16)）
- 以 `ui:deliverable-file-references` 为名、按第一方顺序常量注册该系统提示词段落（[packages/client/ui-deliverables/src/index.ts:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/index.ts#L22-L27)）

### packages/client/ui-deliverables/src/invariant.ts

包级不变量伴生插件，向不变量服务登记包名。

- `apply` 调用 `ctx.invariants.register` 登记包名与安装器并返回其 disposer（[packages/client/ui-deliverables/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/invariant.ts#L29-L30)）
- 安装器为空函数，不注册任何运行期检查（[packages/client/ui-deliverables/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/src/invariant.ts#L22)）

### packages/client/ui-deliverables/tsconfig.json

包的 TypeScript 编译配置与工程引用。

- 无运行期机制

### packages/client/ui-deliverables/tsdown.config.ts

打包配置，被 `pnpm bundle` 使用。

- 声明该包的打包入口为 `lib/types/index.js` 与 `lib/types/invariant.js`（[packages/client/ui-deliverables/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-deliverables/tsdown.config.ts#L3)）
