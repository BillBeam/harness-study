---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-workspace
---

# packages/client/ui-workspace

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 20 个文件、182 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-workspace/README.md

该包的说明文档，叙述工作区浏览区与选取流程的用法、实现内情与已知限制。

- 无运行期机制

### packages/client/ui-workspace/package.json

包清单，声明入口、客户端注入元数据与发布内容。

- `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-workspace/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./client` 三个子路径映射到各自的 lib 产物，并放开 `./src/*` 与 `./package.json` 的直接引用（[packages/client/ui-workspace/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/package.json#L16-L31)）
- `dsh.client.inject` 列出该客户端插件的依赖包，`platform` 限定为 `web`（[packages/client/ui-workspace/package.json:32-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/package.json#L32-L47)）
- `files` 把发布内容限定为三个 bundle 与类型声明（[packages/client/ui-workspace/package.json:94-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/package.json#L94-L99)）

### packages/client/ui-workspace/src/client/WorkspacePicker.module.css

选取流程的错误对话框脚注与状态文字的样式表，被 WorkspacePicker.tsx 引用。

- 无运行期机制

### packages/client/ui-workspace/src/client/WorkspacePicker.tsx

工作区选取／添加流程的核心组件，被同包的 WorkspaceBrowser 直接组合，也被包成 WorkspacePicker 注册进会话空态槽位。

- 以 `::add-workspace` 作为添加项的菜单 id，`handleSelect` 用它区分"打开目录流"与"选中已有工作区"（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L23)、[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:175-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L175-L181)）
- 通过 `useWorkspaces` 订阅整份工作区快照，`items` 直接成为菜单条目源（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:72-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L72-L73)）
- `getAnchorRect` 从锚点元素读取矩形供弹层定位（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:74-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L74-L77)）
- `flowBusy` 由"流程已打开"或"正在采纳路径"合成，置位时禁用全部菜单条目（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:80-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L80-L86)）
- `useDirectoryFlow` 读取本界面目录流孔位的占用状态，未占用时不产出"添加工作区"条目（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L92)、[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:101-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L101-L103)）
- 副作用在流程打开而孔位为空时把 `flowOpen` 复位（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:98-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L98-L100)）
- 有工作区可列时列出工作区并把添加项放进菜单 footer，否则添加项就是全部条目（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:106-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L106-L114)）
- 条目为空时 `menuIsEmpty` 让菜单完全不打开（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L118)、[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L186)）
- `adoptDirectory` 调 `createWorkspace({ path })`，成功后关闭流程并回调 `onPick(workspaceId)`，失败把错误消息写入弹窗状态并打开错误对话框（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:126-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L126-L134)）
- `openDirectoryFlow` 先关闭菜单、清空错误状态，再置 `flowOpen`（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:136-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L136-L141)）
- 仅在快照 `phase === 'ready'`（或 `addOnly`）且只剩添加一项时，把打开菜单的请求直接转成打开目录流（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:151-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L151-L157)）
- `flowOwner` 构成与孔位占位者的会话：`onPicked` 置采纳中标志并在结束后复位，`onCancel` 关闭流程，`onError` 关闭流程并弹错误框（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:159-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L159-L173)）
- 菜单展开且快照仍为 `pending` 时渲染一行 `role="status"` 的加载提示（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L197)）
- 用 `renderDirectoryFlow(flowOwner)` 渲染目录流孔位（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L198)）
- 错误对话框展示消息，重试按钮在孔位为空时禁用、点击后重新打开目录流（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:199-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L199-L214)）
- 外层 `WorkspacePicker` 把 `renderSlot` 绑定到 `conversation.hero.workspace.directoryFlow` 孔位（[packages/client/ui-workspace/src/client/WorkspacePicker.tsx:245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/WorkspacePicker.tsx#L245)）

### packages/client/ui-workspace/src/client/contract/slots.ts

该包两处槽位注册的契约模块：目录流孔位的属主属性、槽位映射的声明合并，以及浏览区与选取器的注入属性类型。

- 无运行期机制

### packages/client/ui-workspace/src/client/index.ts

浏览器侧插件入口，负责服务实例化、字典注册与两处槽位注册。

- `inject` 数组声明该 fiber 所需的服务（含 `remote.directoryPicker`）（[packages/client/ui-workspace/src/client/index.ts:62-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L62-L64)）
- `apply` 用 `ctx.get` 取出连接、会话与工作区三个服务句柄（[packages/client/ui-workspace/src/client/index.ts:73-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L73-L76)）
- 构造 `UiWorkspaceService` 从而在上下文上装载 `uiWorkspace` 服务（[packages/client/ui-workspace/src/client/index.ts:77-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L77-L78)）
- `ctx.slots.provideRoot` 把工作区列表可观察量作为全局 `workspaces` 钩子源提供出去（[packages/client/ui-workspace/src/client/index.ts:79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L79)）
- `ctx.effect` 注册 `workspace` 命名空间的中英字典，随 fiber 生命周期撤销（[packages/client/ui-workspace/src/client/index.ts:80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L80)）
- `searchSessions` 把会话搜索的失败结果转成抛出的 `Error`（[packages/client/ui-workspace/src/client/index.ts:82-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L82-L86)）
- `flowSource` 以 `ctx.slots.entries(hole).length > 0` 为快照、`ctx.slots.subscribe(hole)` 为订阅，构造每个界面各自稳定的孔位占用可观察量（[packages/client/ui-workspace/src/client/index.ts:90-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L90-L95)）
- 注入的 `startSession` 转调 `uiWorkspace.startSession`，`open` 转调 `sessions.open`，并把 `searchResultLimit` 透传给浏览区（[packages/client/ui-workspace/src/client/index.ts:99-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L99-L102)）
- `renameSession` 先经 `sessions.binding(sessionId)?.session` 换到会话面，未知 id 抛错，重命名结果非 ok 亦抛错（[packages/client/ui-workspace/src/client/index.ts:103-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L103-L110)）
- `forkSession` 以 `increaseTitle: true` 分叉后打开子会话，失败时保持当前选择并吞掉异常（[packages/client/ui-workspace/src/client/index.ts:111-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L111-L117)）
- 重命名／删除／工作区排序／归档／会话排序／创建工作区六个动作分别转调工作区控制器与 `uiWorkspace`（[packages/client/ui-workspace/src/client/index.ts:118-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L118-L127)）
- 浏览区的 `hooks` 携带该界面的孔位占用源与连接代次描述（[packages/client/ui-workspace/src/client/index.ts:128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L128)）
- 选取器的注入只含创建工作区回调与其自身的孔位占用源（[packages/client/ui-workspace/src/client/index.ts:130-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L130-L133)）
- `ctx.slots.inject('sidebar.workspaces', …)` 在该槽位声明存在期间注册浏览区，并同时声明 `single` 子孔、视图 store、注入工厂与 locale 命名空间（[packages/client/ui-workspace/src/client/index.ts:136-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L136-L145)）
- `ctx.slots.inject('conversation.hero.workspace', …)` 同法注册选取器与其 `single` 子孔（[packages/client/ui-workspace/src/client/index.ts:146-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/index.ts#L146-L154)）

### packages/client/ui-workspace/src/client/locales.ts

`workspace` 命名空间的中英文案表，由 index.ts 注册进 locale 服务。

- 无运行期机制

### packages/client/ui-workspace/src/client/navigation.ts

`uiWorkspace` 服务实现：工作区连接、新建会话导航、归档与目录 RPC 包装，由 index.ts 在 apply 里构造。

- `DirectoryBrowseError` 把远端失败包成带 code 与 message 的错误类（[packages/client/ui-workspace/src/client/navigation.ts:62-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L62-L69)）
- 构造函数以 `uiWorkspace` 名登记服务，并用 `ctx.effect` 挂上导航监听（[packages/client/ui-workspace/src/client/navigation.ts:81-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L81-L89)）
- `connectWorkspace` 在快照中找不到该工作区时抛错（[packages/client/ui-workspace/src/client/navigation.ts:91-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L91-L96)）
- `connecting` 映射把同一工作区的并发连接请求归并到同一个 Promise，并在完成后清除（[packages/client/ui-workspace/src/client/navigation.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L73)、[packages/client/ui-workspace/src/client/navigation.ts:97-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L97-L98)、[packages/client/ui-workspace/src/client/navigation.ts:109-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L109-L112)）
- 复用条件为：会话空白、cwd 等于工作区路径、属于该工作区的会话账本、且不在归档集合内（[packages/client/ui-workspace/src/client/navigation.ts:100-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L100-L106)）
- 无可复用者则调 `sessions.create({ workspaceId })` 新建（[packages/client/ui-workspace/src/client/navigation.ts:109-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L109-L113)）
- `startSession` 的目标解析顺序为：显式参数 → 当前会话所属工作区 → 最近工作区；三者皆无则 `sessions.clear()` 落到新会话视图（[packages/client/ui-workspace/src/client/navigation.ts:115-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L115-L127)）
- 解析到目标后连接并打开会话，失败只写 `console.warn`（[packages/client/ui-workspace/src/client/navigation.ts:130-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L130-L133)）
- `archiveSession` 转调工作区控制器的归档（[packages/client/ui-workspace/src/client/navigation.ts:136-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L136-L138)）
- `pickDirectory` 把远端失败转为抛错，取消时返回 `null`（[packages/client/ui-workspace/src/client/navigation.ts:140-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L140-L144)）
- `listDirectory` 透传 `AbortSignal`，失败抛 `DirectoryBrowseError`（[packages/client/ui-workspace/src/client/navigation.ts:146-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L146-L150)）
- `createDirectory` 在父目录下建子目录，失败同样抛 `DirectoryBrowseError`（[packages/client/ui-workspace/src/client/navigation.ts:152-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L152-L156)）
- `watchNavigation` 订阅工作区与会话两条列表，每次变化都跑一次 `reconcile`，并在装载时立即跑一次（[packages/client/ui-workspace/src/client/navigation.ts:193-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L193-L195)）
- `reconcile` 先处理归档掉的当前选择，随后只在 `initial === 'waiting'` 时做一次初始工作区选择，两条列表未 ready 前直接返回（[packages/client/ui-workspace/src/client/navigation.ts:161-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L161-L177)）
- 初始连接成功后只在当前仍无选择时打开该会话；失败把状态退回 `waiting` 以便下次重试（[packages/client/ui-workspace/src/client/navigation.ts:178-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L178-L191)）
- 返回的清理函数置 `disposed` 并退订两条列表，使异步回调不再生效（[packages/client/ui-workspace/src/client/navigation.ts:196-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L196-L200)）
- `clearArchivedCurrent` 在当前选择落入归档集合时调用 `sessions.clear()`（[packages/client/ui-workspace/src/client/navigation.ts:203-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L203-L210)）
- `recentWorkspace` 取每个工作区内会话的最大 `updatedAt`，无会话时改用工作区 `createdAt`，且只在严格更大时替换选中项（[packages/client/ui-workspace/src/client/navigation.ts:215-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/navigation.ts#L215-L234)）

### packages/client/ui-workspace/src/client/rows/Rows.module.css

树行、搜索结果行、悬浮卡与拖拽插入标记的样式表，被 Rows.tsx 引用。

- 无运行期机制

### packages/client/ui-workspace/src/client/rows/Rows.tsx

浏览区的展示型行组件（工作区行、会话行、搜索结果行），数据与回调全部由 WorkspaceBrowser.tsx 传入。

- 空白会话行的标题取字典里的"新会话"文案而非节点标题（[packages/client/ui-workspace/src/client/rows/Rows.tsx:25-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L25-L27)）
- `timeLabel` 与 `hoverTimeLabel` 用 `relativeTime` 分桶，`now` 桶不套用"…前"模板（[packages/client/ui-workspace/src/client/rows/Rows.tsx:29-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L29-L39)）
- `createdLabel` 走字典日期模板并自行补零，而非 `toLocaleString`（[packages/client/ui-workspace/src/client/rows/Rows.tsx:46-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L46-L51)）
- `rowHalf` 用指针 `clientY` 与行中线比较，判定插入位在行上半还是下半（[packages/client/ui-workspace/src/client/rows/Rows.tsx:93-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L93-L96)）
- 工作区行的标签在无 `workspaceId` 时取"未分组"字典文案，`active` 由展开且包含当前会话合成（[packages/client/ui-workspace/src/client/rows/Rows.tsx:125-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L125-L126)）
- 工作区行以 `role="treeitem"` 输出 `aria-expanded`，整行点击触发展开／收起（[packages/client/ui-workspace/src/client/rows/Rows.tsx:135-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L135-L137)）
- 仅在传入 drag 时置 `draggable`，拖起时写 `effectAllowed = 'move'` 与 `text/plain` 载荷并通知属主（[packages/client/ui-workspace/src/client/rows/Rows.tsx:138-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L138-L146)）
- 工作区行菜单只含重命名与删除两项，选中未知 id 时提前返回不落入删除分支（[packages/client/ui-workspace/src/client/rows/Rows.tsx:128-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L128-L131)、[packages/client/ui-workspace/src/client/rows/Rows.tsx:163-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L163-L171)）
- 新建会话按钮阻止冒泡后调 `onCreate`，避免同时触发整行的展开切换（[packages/client/ui-workspace/src/client/rows/Rows.tsx:186-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L186-L193)）
- 没有 `createdAt` 的分组（未分组桶）直接返回裸行，不包悬浮卡（[packages/client/ui-workspace/src/client/rows/Rows.tsx:197-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L197-L198)）
- 工作区悬浮卡的复制内容为完整 `cwd`，显示路径按 `home` 缩写，菜单打开时禁用悬浮卡（[packages/client/ui-workspace/src/client/rows/Rows.tsx:199-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L199-L213)）
- `assertNever` 在待处理交互取到未知取值时抛错（[packages/client/ui-workspace/src/client/rows/Rows.tsx:216-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L216-L219)）
- `sessionStatuses` 把三种待处理交互映射成 warning 状态并排在最前，其次是自身运行中，再次是子代理运行计数，最后才是已完成或空闲（[packages/client/ui-workspace/src/client/rows/Rows.tsx:230-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L230-L268)）
- 子代理计数按 1 与多数选用不同的复数文案键（[packages/client/ui-workspace/src/client/rows/Rows.tsx:234-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L234-L244)）
- `SessionStatusDots` 只绘制首个状态的圆点，全部状态文案以视觉隐藏元素输出给屏读（[packages/client/ui-workspace/src/client/rows/Rows.tsx:271-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L271-L280)）
- 会话悬浮卡对空白会话不渲染时间行，并逐条列出全部状态（[packages/client/ui-workspace/src/client/rows/Rows.tsx:283-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L283-L299)）
- 搜索结果行仅在首状态非 done 或该会话已完成时显示状态点，工作区名为空时回落到"未分组"文案，点击调 `onOpen`（[packages/client/ui-workspace/src/client/rows/Rows.tsx:318-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L318-L342)）
- 会话行的 `showStatus` 同样按"首状态非 done 或已完成"计算，并决定扁平列表里是否省掉状态槽（[packages/client/ui-workspace/src/client/rows/Rows.tsx:383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L383)、[packages/client/ui-workspace/src/client/rows/Rows.tsx:433-437](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L433-L437)）
- 会话行类名合成选中态、菜单打开态与拖拽插入标记的上／下位置（[packages/client/ui-workspace/src/client/rows/Rows.tsx:396-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L396-L401)）
- 会话行菜单含重命名／分叉／归档三项，选中后分别回调属主（[packages/client/ui-workspace/src/client/rows/Rows.tsx:388-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L388-L393)、[packages/client/ui-workspace/src/client/rows/Rows.tsx:450-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L450-L455)）
- 拖拽经过与释放时先检查 `drag.active`，再阻止默认、设置 `dropEffect` 并把行的上下半报回属主（[packages/client/ui-workspace/src/client/rows/Rows.tsx:414-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L414-L428)）
- 空白会话行既不渲染相对时间也不渲染行操作菜单（[packages/client/ui-workspace/src/client/rows/Rows.tsx:443-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L443-L470)）
- 会话悬浮卡在菜单打开或拖拽进行中被禁用，复制内容对空白行为 `undefined`（[packages/client/ui-workspace/src/client/rows/Rows.tsx:473-481](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/Rows.tsx#L473-L481)）

### packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.module.css

浏览区根、区段头、搜索控件、滚动列表与拖拽标记的样式表，被 WorkspaceBrowser.tsx 引用。

- 无运行期机制

### packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx

填充侧栏 `sidebar.workspaces` 孔位的浏览区组件，包含区段头、搜索、分组树／扁平列表与各类对话框。

- 四个常量固定列展开等待时长、搜索防抖间隔、查询长度上限与折叠时每组可见会话数（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:35-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L35-L41)）
- `collapsedSessionRows` 折叠一组时空白会话不计入普通行上限，并回报被隐藏的行数（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:44-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L44-L56)）
- `sanitizeSearchQuery` 去掉 NUL 字符并截到 500 个 UTF-16 码元，截断点落在代理对中间时再退一位（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:59-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L59-L67)）
- `useNativeDragAcceptance` 在拖拽进行时给 document 挂 `dragover`/`drop` 监听并阻止默认（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:79-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L79-L94)）
- `reconciledSessionOrder` 按已存顺序排列，剔除不存在与重复项，账本中未记录的会话追加在后（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:97-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L97-L113)）
- `compareSessionRecency` 以 `updatedAt` 降序排序、以会话 id 做稳定次序（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:116-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L116-L121)）
- `nextSessionOrderAccount` 在 `sortByRecency` 时整体按时间重排，否则在"最近更新"模式下把时间戳变新的会话一次性提到最前（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:134-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L134-L149)）
- 同一函数记录本轮各会话的 `updatedAt` 并比较顺序与时间戳，只有真正变化时才回报 `changed`（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:150-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L150-L160)）
- 视图选项菜单把分组与排序两组选项合在一张菜单里，选中后分别写入 store（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:172-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L172-L208)）
- `workspaceGroupHalf` 以整个分组区块的中线判定工作区插入位（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:228-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L228-L231)）
- 当前会话所在分组若尚无显式展开记录，副作用把它置为展开（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:287-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L287-L294)）
- `ungroupedSessionIds` 取不属于任何工作区账本、且在会话表里存在的会话（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:299-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L299-L302)）
- 会话列表 ready 后逐个账本（各工作区加未分组桶）计算下一份顺序，刚切到"最近更新"或账本尚不存在时做整体重排，变化时写回 store（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:303-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L303-L329)）
- 渲染前把每个工作区的 `sessionIds` 与未分组集合按存储顺序重排（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:330-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L330-L340)）
- `deriveGroups` 以会话列表、重排后的工作区、归档集合、待处理交互与展开集合合成分组节点（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:341-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L341-L349)）
- `commitSessionDrag` 用 ref 保证一次拖拽只提交一次，并在源与目标位置等价时直接放弃（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:351-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L351-L367)）
- 折叠状态下按已渲染行解析锚点，把源放到可见边界之前，并在结果会把源藏起时放弃这次拖拽（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:374-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L374-L397)）
- 顺序先写入浏览器本地账本；仅当排序模式为手动且账本不是未分组桶时才再调 `insertSessionBefore` 写主机，失败只 `console.warn`（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:398-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L398-L403)）
- `commitWorkspaceDrag` 解析工作区锚点，源与锚相邻或同一位置时不动，否则调 `insertWorkspaceBefore`（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:404-423](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L404-L423)）
- 拖到首个分组上半时改用列表外的顶部插入标记（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:424-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L424-L432)）
- 分组区块在工作区拖拽进行时接管 `dragover`/`drop`，按区块中线更新与提交标记（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:484-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L484-L496)）
- 收起一个分组时同时清掉它的"展开其余会话"状态（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:502-507](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L502-L507)）
- 分组头的新建按钮先把该组置为展开再 `startSession(workspaceId)`（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:508-513](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L508-L513)）
- 只有真实工作区分组才拿到重命名／删除动作对象，未分组桶不显示菜单（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:515-526](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L515-L526)）
- 按 `sessionsExpanded` 在完整会话集与折叠行集之间选择实际渲染的行（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:528-531](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L528-L531)）
- 每行的拖拽接线把 `active` 限定为同一账本内的拖拽，标记只落在被悬停的那一行（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:534-556](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L534-L556)）
- 有隐藏行时渲染"展开其余 N 个会话"按钮，切换本组的展开集合（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:572-583](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L572-L583)）
- 扁平列表用 `deriveFlat` 产出行，并对 `__flat_session_order__` 账本执行同一套顺序同步与提升策略（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:616-639](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L616-L639)）
- 扁平列表按该账本重排行，并丢弃账本里已不存在的 id（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:640-647](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L640-L647)）
- 扁平列表的拖拽提交只写浏览器本地顺序，不发起主机排序调用（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:651-666](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L651-L666)）
- 搜索结果在远端结果的 query 与当前查询不一致时按 loading 处理（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:743-745](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L743-L745)）
- `deriveSearchResults` 把本地元数据匹配与远端结果合并，并受 `resultLimit` 约束（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:746-757](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L746-L757)）
- 搜索区分别渲染进行中提示、失败告警、无匹配文案与"结果超限"提示（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:775-790](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L775-L790)）
- 根组件从连接代次读主机 home，从工作区快照读列表、阶段与归档集合（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:827-830](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L827-L830)）
- `directoryFlowAvailable` 读取本界面目录流孔位占用状态（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:833](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L833)）
- 从视图 store 取分组模式、排序模式、展开记录与两张顺序账本（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:834-838](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L834-L838)）
- 当前选中的空白会话被提到其所属账本与扁平账本的首位，并用 ref 保证同一对（会话、账本）只提升一次（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:839-864](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L839-L864)）
- 工作区列表 ready 后调 `retainAccountKeys`，把持久化记录裁剪到当前工作区加未分组与扁平两个账本（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:865-872](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L865-L872)）
- 查询串在组件根上保存并经 `sanitizeSearchQuery` 与 `trim` 归一化后驱动界面（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:875-877](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L875-L877)）
- 从窄栏发起的搜索先置标志再请求展开，等列宽动画时长过后再聚焦输入框（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:895-903](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L895-L903)）
- 宽态下搜索展开即聚焦输入框（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:905-908](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L905-L908)）
- 文档级点击监听在点到搜索区外时失焦；查询非空则保留展开状态，仅空查询才收起（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:915-925](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L915-L925)）
- 查询为空时清空远端搜索状态；非空时先置 loading，再经 250 ms 定时器发起带 `AbortSignal` 的请求（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:927-957](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L927-L957)）
- 请求回来后先检查是否已中止，成功写入结果与 `hasMore`，失败写入 error 状态（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:940-956](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L940-L956)）
- 清理函数清掉定时器并 abort 控制器，使每次查询变更都取消上一次请求（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:958-962](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L958-L962)）
- 工作区重命名的确认按钮在空名、与原名相同、与其他工作区重名或提交中时禁用（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:969-973](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L969-L973)）
- 提交中禁止关闭重命名对话框；提交成功关闭，失败把消息写入错误行（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:974-990](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L974-L990)）
- 会话重命名只在空名或提交中时禁用确认，不阻止提交与当前标题相同的名字（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1000-1018](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1000-L1018)）
- 归档不弹确认，直接提交，失败只写 `console.warn`（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1029-1033](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1029-L1033)）
- 删除成功后先记住已提交的 id，等到渲染出的工作区列表不再包含它才收起对话框（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1041-1068](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1041-L1068)）
- 区段标题按分组模式在"会话"与"工作区"两个文案间切换（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1073-1077](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1073-L1077)）
- 点击搜索区先关掉添加菜单再展开搜索并聚焦（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1080-1102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1080-L1102)）
- 搜索输入框带 `maxLength` 上限、输入即归一化，按 Escape 清空查询并收起（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1103-1117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1103-L1117)）
- 清除按钮阻止冒泡后清空查询并收起搜索（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1118-1131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1118-L1131)）
- 添加工作区按钮仅在目录流孔位被占用时渲染（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1148-1162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1148-L1162)）
- 区段头直接组合 `WorkspacePickFlow`，以 `addOnly` 渲染，采纳成功后关闭菜单并在新工作区中开一个会话（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1165-1180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1165-L1180)）
- 窄栏态另渲染一个搜索按钮，点击时置展开标志并请求侧栏展开（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1184-1199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1184-L1199)）
- 列表区在宽态下按"有查询→搜索结果、扁平模式→扁平列表、否则→分组树"三选一渲染（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1203-1266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1203-L1266)）
- 两个重命名输入框在输入法组合期间吞掉 Enter，仅在组合结束后才提交（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1288-1295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1288-L1295)、[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1323-1330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1323-L1330)）
- 重名时以 `role="alert"` 渲染冲突提示（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1297-1300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1297-L1300)）
- 删除对话框把工作区名注入说明文案，并在提交中渲染 `role="status"` 的进行提示（[packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx:1334-1358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/rows/WorkspaceBrowser.tsx#L1334-L1358)）

### packages/client/ui-workspace/src/client/stores.ts

浏览区的视图 store 工厂，由 index.ts 在注册槽位时传入，浏览区通过 `useStore`／`actions` 读写。

- 导出 `__flat_session_order__` 作为扁平列表的浏览器本地顺序账本键（[packages/client/ui-workspace/src/client/stores.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/stores.ts#L11)）
- `init` 把默认分组设为按工作区、默认排序设为最近更新，三张记录表初始为空（[packages/client/ui-workspace/src/client/stores.ts:54-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/stores.ts#L54-L60)）
- `persist` 键 `dsh.workspace.view.v5` 决定这份视图状态跨刷新留存及其版本（[packages/client/ui-workspace/src/client/stores.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/stores.ts#L61)）
- `setGroupBy`／`setOrderBy`／`setGroupExpanded` 分别写入分组模式、排序模式与单个分组的展开位（[packages/client/ui-workspace/src/client/stores.ts:63-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/stores.ts#L63-L65)）
- `retainAccountKeys` 用给定键集合同时过滤展开记录、顺序账本与时间戳账本三张表（[packages/client/ui-workspace/src/client/stores.ts:66-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/stores.ts#L66-L77)）
- `syncSessionOrderAccount` 一次替换某账本的顺序与观察到的时间戳，`setSessionOrder` 只替换顺序（[packages/client/ui-workspace/src/client/stores.ts:78-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/stores.ts#L78-L84)）

### packages/client/ui-workspace/src/client/subagent-lineage.ts

从会话摘要投影出子代理后代计数的工具模块，供该包的行视图使用。

- `indexSubagentDescendants` 只从 `origin === 'subagent'` 的会话起算，沿 `parentId` 逐层向上归并计数（[packages/client/ui-workspace/src/client/subagent-lineage.ts:24-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/subagent-lineage.ts#L24-L43)）
- 向上遍历在祖先不再是 subagent 出身、无 `parentId`、或 `seen` 集合命中成环时停止（[packages/client/ui-workspace/src/client/subagent-lineage.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/subagent-lineage.ts#L32)）
- 每个祖先同时累加后代总数与其中运行中的数量（[packages/client/ui-workspace/src/client/subagent-lineage.ts:34-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/subagent-lineage.ts#L34-L40)）

### packages/client/ui-workspace/src/client/tree.ts

浏览器侧工作区浏览器的树形派生模块，把会话列表快照、工作区列表、归档集合与待处理交互映射成分组行、平铺行与搜索结果行，由该包的客户端组件消费。

- 定义空字符串作为「未归组」桶的分组键，后续分组与当前组判定都用它（[packages/client/ui-workspace/src/client/tree.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L20)）
- `workspaceLabel` 取路径基名作为显示标签，基名为空时回退到原始路径，路径缺失时返回空串（[packages/client/ui-workspace/src/client/tree.ts:108-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L108-L112)）
- `byRecency` 按 `updatedAt` 降序排序，相等时用 id 字典序作为确定性次序（[packages/client/ui-workspace/src/client/tree.ts:115-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L115-L118)）
- `sessionVisible` 过滤掉 origin 为 subagent 的会话、归档集合中的会话，以及非当前选中的空白会话（[packages/client/ui-workspace/src/client/tree.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L126-L130)）
- `sessionTitle` 对空白会话返回空标题，其余返回 `displayTitle`（[packages/client/ui-workspace/src/client/tree.ts:137-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L137-L139)）
- `buildGroup` 复制成员数组，仅当次序参数为 `recency` 时按最近更新排序，否则保留传入次序（[packages/client/ui-workspace/src/client/tree.ts:142-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L142-L156)）
- `orderedUngrouped` 先按存储的 id 序列去重排列，未命中存储序的成员再按最近更新追加在后（[packages/client/ui-workspace/src/client/tree.ts:159-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L159-L174)）
- `groupByWorkspace` 逐个工作区按 `sessionIds` 顺序取成员，列表中缺失的 summary 直接跳过，命中的 id 记入已归属集合（[packages/client/ui-workspace/src/client/tree.ts:190-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L190-L198)）
- 工作区分组的 `createdAt` 由 `Date.parse(workspace.createdAt)` 得到，标签取工作区标题（[packages/client/ui-workspace/src/client/tree.ts:199-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L199-L202)）
- 未被任何工作区认领且可见的会话组成散列集合，非空时追加一个未归组桶，其内部次序取决于是否提供了本地存储序（[packages/client/ui-workspace/src/client/tree.ts:204-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L204-L218)）
- `visiblePendingKind` 只放行 `approval`、`plan-review`、`question` 三种待处理交互类型，其余一律返回 undefined（[packages/client/ui-workspace/src/client/tree.ts:223-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L223-L232)）
- `sessionNode` 组装单行：标题、blank、running、从子代索引取运行中子代计数（缺失记 0）、`completed === true` 严格判定，并仅在存在时附带 `pendingInteraction` 字段（[packages/client/ui-workspace/src/client/tree.ts:234-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L234-L250)）
- `deriveGroups` 先建归档集合与展开集合，并调用 `indexSubagentDescendants` 建立子代索引（[packages/client/ui-workspace/src/client/tree.ts:274-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L274-L276)）
- `deriveGroups` 通过查找包含当前会话 id 的工作区确定当前分组键，找不到时归入未归组桶（[packages/client/ui-workspace/src/client/tree.ts:277-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L277-L280)）
- `deriveGroups` 输出的分组行始终携带完整会话计数，但只有展开的分组才把会话映射成行，折叠分组给出空数组（[packages/client/ui-workspace/src/client/tree.ts:282-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L282-L297)）
- `deriveFlat` 遍历列表 id，滤掉不可见会话后统一按最近更新排序，输出无分组的平铺行（[packages/client/ui-workspace/src/client/tree.ts:311-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L311-L326)）
- `deriveSearchResults` 对查询串去首尾空白并转小写，空查询直接返回空结果与 `hasMore: false`（[packages/client/ui-workspace/src/client/tree.ts:350-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L350-L351)）
- 建立会话到工作区标题的映射，同一会话被多个工作区收录时保留首个；工作区外的会话回退到 cwd 基名标签（[packages/client/ui-workspace/src/client/tree.ts:355-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L355-L362)）
- 后端内容匹配项按会话 id 建索引，同一会话的重复条目只保留首个（[packages/client/ui-workspace/src/client/tree.ts:363-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L363-L366)）
- 本地匹配跳过空白会话与不可见会话，对标题与工作区标签做小写子串匹配，命中集合按最近更新排序（[packages/client/ui-workspace/src/client/tree.ts:368-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L368-L381)）
- 合并次序为本地命中在前、后端内容命中在后，按会话 id 去重，后端项还需通过非空白与可见性检查（[packages/client/ui-workspace/src/client/tree.ts:383-394](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L383-L394)）
- 合并结果按 `limit` 截断，逐行补上工作区标签、运行中子代计数、待处理交互与后端片段（[packages/client/ui-workspace/src/client/tree.ts:397-412](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L397-L412)）
- `hasMore` 为后端 `hasMore` 与「合并行数超过 limit」的或（[packages/client/ui-workspace/src/client/tree.ts:413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/client/tree.ts#L413)）

### packages/client/ui-workspace/src/css-modules.d.ts

CSS Modules 与普通 CSS 导入的 TypeScript 环境声明文件。

- 无运行期机制

### packages/client/ui-workspace/src/index.ts

该包的宿主侧插件入口，浏览器半边通过 package.json 的客户端声明另行分发。

- 导出空的 `apply` 函数体，使该包能作为函数插件被宿主 cordis.yml 与 Loader 载入且宿主侧不产生任何行为（[packages/client/ui-workspace/src/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/index.ts#L9)）

### packages/client/ui-workspace/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属。

- 导出插件名与 `inject = ['invariants']`，声明该伴生插件在 invariants 服务就绪后才激活（[packages/client/ui-workspace/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/invariant.ts#L13-L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/client/ui-workspace/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/invariant.ts#L23)）
- `apply` 以包名调用 `ctx.invariants.register` 并返回其 disposer（[packages/client/ui-workspace/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/src/invariant.ts#L30-L31)）

### packages/client/ui-workspace/tsconfig.json

该包客户端面的 TypeScript 编译配置，声明源码根、类型输出目录与工程引用。

- 无运行期机制

### packages/client/ui-workspace/tsdown.config.ts

该包的打包配置，复用客户端通用打包工厂。

- 以包名与两个入口（index 与 invariant）调用客户端打包工厂，决定该包在运行期可被加载的产物文件（[packages/client/ui-workspace/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-workspace/tsdown.config.ts#L3)）
