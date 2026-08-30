---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-commands
---

# packages/client/ui-commands

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、92 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-commands/README.md

包 README，说明 `/` 命令的三种分发方式、client 贡献与 host 命令装饰的关系，供该包的使用者与维护者阅读。

- 无运行期机制

### packages/client/ui-commands/package.json

包清单，声明该包的入口、客户端注入声明与发布文件集。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-commands/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/package.json#L14-L15)）
- `exports` 暴露根入口、`./invariant`、`./client` 三个运行期入口，另放通 `./src/*` 与 `./package.json`（[packages/client/ui-commands/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/package.json#L16-L31)）
- `dsh.client` 声明浏览器半边需注入的四个包并把平台标为 `web`（[packages/client/ui-commands/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/package.json#L32-L42)）
- `files` 把发布内容限定为三个 bundle 与类型声明（[packages/client/ui-commands/package.json:84-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/package.json#L84-L89)）

### packages/client/ui-commands/src/client/PopupSelectView.module.css

popupSelect 卡片的 CSS Module 样式表，被 `PopupSelectView.tsx` 以类名映射导入。

- 无运行期机制

### packages/client/ui-commands/src/client/PopupSelectView.tsx

popupSelect 的 React 外壳组件，由 `client/index.ts` 注册进 `conversation.input.overlay` 槽位，渲染某个会话的 `PopupSelectController` 状态。

- 用 `useSyncExternalStore` 订阅控制器状态存储，快照变化即重渲染（[packages/client/ui-commands/src/client/PopupSelectView.tsx:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L39-L42)）
- 以常量 320 为上限、按输入框上方可用空间夹取卡片最大高度，并在每次状态更新时重新测量（[packages/client/ui-commands/src/client/PopupSelectView.tsx:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L47)）
- 高亮索引变化时把 `aria-selected="true"` 的行滚动进视野（[packages/client/ui-commands/src/client/PopupSelectView.tsx:52-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L52-L55)）
- 打开且无确认框时在 document 捕获阶段监听 pointerdown，落点不在卡片内即调用 `popup.dismiss()`，卸载时移除监听（[packages/client/ui-commands/src/client/PopupSelectView.tsx:62-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L62-L70)）
- 打开且无确认框时把焦点交给内部搜索框（[packages/client/ui-commands/src/client/PopupSelectView.tsx:73-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L73-L75)）
- 关闭态直接渲染 `null`（[packages/client/ui-commands/src/client/PopupSelectView.tsx:77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L77)）
- 渲染前用 `filterOptions` 按当前搜索文本过滤已加载选项（[packages/client/ui-commands/src/client/PopupSelectView.tsx:79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L79)）
- 键盘处理：ArrowDown/ArrowUp 阻止默认并调 `move(±1)`，Enter 调 `select(active)`，Escape 调 `dismiss({focusComposer:true})`，左右方向键不拦截（[packages/client/ui-commands/src/client/PopupSelectView.tsx:82-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L82-L104)）
- 确认框存在时不渲染选择卡片（[packages/client/ui-commands/src/client/PopupSelectView.tsx:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L108)）
- 搜索输入框在提交中变为只读，输入变化调用 `popup.setSearch`（[packages/client/ui-commands/src/client/PopupSelectView.tsx:116-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L116-L125)）
- 有错误文本时渲染 `role="alert"` 条，状态为 `failed` 时额外渲染调用 `popup.retry()` 的按钮（[packages/client/ui-commands/src/client/PopupSelectView.tsx:126-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L126-L133)）
- 分别为加载中、提交中、就绪但过滤结果为空三种情况渲染状态行（[packages/client/ui-commands/src/client/PopupSelectView.tsx:134-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L134-L136)）
- 就绪时渲染 listbox：每行点击调 `popup.select(index)`，鼠标进入调 `popup.highlight(index)`，`option.active` 为真时渲染勾选图标（[packages/client/ui-commands/src/client/PopupSelectView.tsx:137-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L137-L157)）
- 待确认选项存在时渲染风险确认弹层，勾选调 `acknowledge`、取消调 `cancelConfirmation`、确认调 `confirm`（[packages/client/ui-commands/src/client/PopupSelectView.tsx:160-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/PopupSelectView.tsx#L160-L174)）

### packages/client/ui-commands/src/client/contract.ts

命令 UI 面向业务包的类型声明文件，定义选项、确认文案、popupSelect 规格、贡献/装饰记录与 `ctx.commandUi` 的方法签名。

- 无运行期机制

### packages/client/ui-commands/src/client/directory.ts

按会话键缓存 host 命令目录的类，由 `service.ts` 注入拉取函数并接线事件与 RPC。

- `Entry` 每个会话键保存状态、命令快照、epoch、最后错误与等待者队列（[packages/client/ui-commands/src/client/directory.ts:24-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L24-L31)）
- `status()` 返回该键的缓存状态，未建过条目时返回 `cold`（[packages/client/ui-commands/src/client/directory.ts:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L44-L46)）
- `resolve()` 仅在条目为 `ready` 时按名同步精确查找描述符，否则返回 undefined（[packages/client/ui-commands/src/client/directory.ts:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L54-L58)）
- `invalidateAll()` 对所有已建键触发后台重拉，不清空既有快照（[packages/client/ui-commands/src/client/directory.ts:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L61-L63)）
- `resetSession()` 把单个键置回 `cold`、清空命令与错误，并立即预热（[packages/client/ui-commands/src/client/directory.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L69-L75)）
- `resetConnected()` 把所有键置回 `cold`、清空命令并逐个预热（[packages/client/ui-commands/src/client/directory.ts:81-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L81-L87)）
- `warm()` 只在状态为 `cold` 或 `failed` 时发起一次拉取（[packages/client/ui-commands/src/client/directory.ts:94-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L94-L97)）
- `refresh()` 自增 epoch、非 ready 时置 pending，拉取返回后只有 epoch 未被超越才写入快照/错误，`finally` 中唤醒等待者（[packages/client/ui-commands/src/client/directory.ts:106-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L106-L124)）
- `ensureReady()` 循环强等：ready 立即返回快照，非 pending 则发起新拉取，等待一次结算；结算后为 failed 抛出带原因的错误，仍为 pending 则继续等下一轮（[packages/client/ui-commands/src/client/directory.ts:135-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L135-L146)）
- `entry()` 惰性创建并登记会话键的缓存条目（[packages/client/ui-commands/src/client/directory.ts:148-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L148-L155)）
- `settled()` 在信号已中止时直接 reject，否则挂一个等待者并在 abort 时把自己从队列摘除后 reject（[packages/client/ui-commands/src/client/directory.ts:159-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L159-L173)）
- `notifyWaiters()` 先清空队列再逐个唤醒（[packages/client/ui-commands/src/client/directory.ts:175-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L175-L179)）
- `abortReason()` 把非 Error 的中止原因归一成 Error（[packages/client/ui-commands/src/client/directory.ts:182-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/directory.ts#L182-L184)）

### packages/client/ui-commands/src/client/index.ts

命令 UI 插件的浏览器半边入口：挂载运行时服务、注册文案字典并把 popupSelect 外壳接进输入区覆盖层槽位。

- 声明 `inject` 要求输入触发源注册表、会话服务、remote 及其 commands 面、locale 服务（[packages/client/ui-commands/src/client/index.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/index.ts#L51)）
- `apply` 以 effect 把 `command` 命名空间的中英字典注册进 locale 服务（[packages/client/ui-commands/src/client/index.ts:59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/index.ts#L59)）
- 挂载 `CommandUiRuntime` 插件（[packages/client/ui-commands/src/client/index.ts:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/index.ts#L60)）
- 在 slots/commandUi/sessions 就位后，向 `conversation.input.overlay` 注册 id 为 `command-popup`、order 为 1、locale 为 `command` 的条目，其 inject 按 sessionId 解析会话 scope 并返回该会话的 popup 控制器，解析不到 scope 时抛错（[packages/client/ui-commands/src/client/index.ts:61-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/index.ts#L61-L75)）

### packages/client/ui-commands/src/client/locales.ts

`command` 命名空间的中英文案字典，由 `client/index.ts` 注册进 locale 服务后供外壳组件与运行时服务取用。

- 导出中文字典，含搜索占位、加载/应用/空态提示、两个 aria 模板，以及带 `{command}` 插值的图片附件拒绝文案（[packages/client/ui-commands/src/client/locales.ts:4-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/locales.ts#L4-L13)）
- 导出与中文键集同构的英文字典（[packages/client/ui-commands/src/client/locales.ts:19-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/locales.ts#L19-L28)）

### packages/client/ui-commands/src/client/popup.ts

popupSelect 的无界面控制器与本地过滤函数，每个会话一个实例，由 `CommandUiRuntime` 持有、外壳组件订阅。

- `CLOSED` 常量定义关闭态的完整状态快照（[packages/client/ui-commands/src/client/popup.ts:78-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L78-L81)）
- `filterOptions` 对 label 与 detail 做大小写不敏感子串匹配，空查询返回全部行（[packages/client/ui-commands/src/client/popup.ts:90-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L90-L94)）
- `errorText` 把非 Error 的失败值转成字符串用于错误条（[packages/client/ui-commands/src/client/popup.ts:106-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L106-L108)）
- 控制器以 `CLOSED` 初始化一个快照存储供组件订阅（[packages/client/ui-commands/src/client/popup.ts:118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L118)）
- `open()` 中止上一次绑定的取数、建立新绑定（命令名、规格、开启时上下文、token 片段、AbortController），置为打开+pending 并发起一次选项加载（[packages/client/ui-commands/src/client/popup.ts:135-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L135-L141)）
- `load()` 调用业务 `options`，绑定已被替换则丢弃结果；成功写入选项并把状态置 ready、高亮归零、清错；失败在控制台记一条并置 failed、清空选项、写入错误文本（[packages/client/ui-commands/src/client/popup.ts:144-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L144-L156)）
- `retry()` 仅在打开且状态为 failed 时把状态改回 pending 并重跑加载，保留搜索文本（[packages/client/ui-commands/src/client/popup.ts:159-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L159-L165)）
- `setSearch()` 在关闭、提交中、确认中或文本未变时不动，否则写入新文本并把高亮归零（[packages/client/ui-commands/src/client/popup.ts:172-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L172-L176)）
- `move()` 只在就绪且空闲时在过滤后的行上环绕移动高亮，空列表不动（[packages/client/ui-commands/src/client/popup.ts:183-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L183-L190)）
- `highlight()` 直接设置高亮，越界或与当前相同时不动（[packages/client/ui-commands/src/client/popup.ts:197-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L197-L202)）
- `select()` 取过滤后指定下标的选项：带确认文案的先进入待确认态并返回，其余交给结算；提交中或确认中不受理（[packages/client/ui-commands/src/client/popup.ts:214-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L214-L225)）
- `acknowledge()` 写入待确认项的勾选状态（[packages/client/ui-commands/src/client/popup.ts:231-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L231-L235)）
- `cancelConfirmation()` 只撤掉确认态并清勾选，弹层仍保持打开（[packages/client/ui-commands/src/client/popup.ts:238-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L238-L242)）
- `confirm()` 仅在已勾选确认时才对待确认项发起结算（[packages/client/ui-commands/src/client/popup.ts:245-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L245-L250)）
- `settle()` 置提交中并 await 业务 `onSelect`；失败时记控制台、绑定未变则回到非提交态并写入错误；成功且绑定未变则调用注入的 consume 消费开启时的 token 片段、清空绑定、置回关闭态并调用 focusComposer；绑定已变则既不写状态也不消费（[packages/client/ui-commands/src/client/popup.ts:253-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L253-L270)）
- `dismiss()` 中止在飞的取数、清空绑定、置回关闭态，并按参数决定是否把焦点还给输入框（[packages/client/ui-commands/src/client/popup.ts:278-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L278-L284)）
- `dispose()` 中止取数、清空绑定并置回关闭态，不触碰焦点（[packages/client/ui-commands/src/client/popup.ts:286-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/popup.ts#L286-L291)）

### packages/client/ui-commands/src/client/service.ts

`CommandUiRuntime` 服务：注册 `/` 触发源、持有按会话键的目录缓存与贡献/装饰注册表、按会话建 popup 控制器，并通过 remote 发起命令列举与执行。

- `submittedCommandName()` 从已执行的行首切出首个空白前的片段并去掉前导斜杠（[packages/client/ui-commands/src/client/service.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L46-L50)）
- `boundaryBonus()` 对命令名开头及 `-`/`_` 之后的位置加 8 分（[packages/client/ui-commands/src/client/service.ts:68-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L68-L70)）
- `fuzzyScore()` 用逐字符动态规划算有序子序列的最强对齐分：空查询返回 0，查询比名字长返回 undefined，相邻匹配额外加 4，跳字与靠后起点扣分，无对齐返回 undefined（[packages/client/ui-commands/src/client/service.ts:77-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L77-L105)）
- `fuzzyCandidates()` 大小写不敏感地过滤候选，并按「前缀匹配优先、分数次之、原始下标最后」排序（[packages/client/ui-commands/src/client/service.ts:108-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L108-L120)）
- 构造时以 `commandUi` 名注册服务，取不到 locale 服务即抛错，并绑定 `command` 命名空间的翻译函数（[packages/client/ui-commands/src/client/service.ts:136-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L136-L139)）
- 目录缓存的拉取函数：会话有 subagent 地址时直接返回空表，否则调 `remote.commands.list`，返回非 ok 时抛出带错误码的异常（[packages/client/ui-commands/src/client/service.ts:140-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L140-L145)）
- 取不到 inputTriggers 服务即抛错（[packages/client/ui-commands/src/client/service.ts:146-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L146-L147)）
- 以 effect 注册 `/` 触发源，挂上 candidates、onPick、matchSpace、matchEnter 与 warm 五个回调（[packages/client/ui-commands/src/client/service.ts:148-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L148-L156)）
- 监听转发的 `commands/change` 事件并软失效全部目录条目（[packages/client/ui-commands/src/client/service.ts:157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L157)）
- 监听 `agent-preset/selected` 事件并只重置该会话键的目录条目（[packages/client/ui-commands/src/client/service.ts:161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L161)）
- 监听 `connection/reset` 并硬重置全部目录条目（[packages/client/ui-commands/src/client/service.ts:162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L162)）
- `register()` 以 effect 把贡献写入表，重名抛错，返回删除该项的 disposer（[packages/client/ui-commands/src/client/service.ts:171-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L171-L181)）
- `decorate()` 以 effect 把装饰写入表，重名抛错，返回删除该项的 disposer（[packages/client/ui-commands/src/client/service.ts:189-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L189-L199)）
- `popupFor()` 按会话 id 复用或新建控制器：consume 回调把 token 片段转成 span 或 bare-token 守卫并以 `slash/input-consume-token` 冒泡回该会话，focusComposer 走该会话登记的焦点钩子；并在会话 scope 销毁时 dispose 控制器、从两张表中删除；无会话 scope 时抛错（[packages/client/ui-commands/src/client/service.ts:209-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L209-L231)）
- `bindComposerFocus()` 按会话 id 登记输入框聚焦回调，返回只在仍是同一回调时才删除的解绑器（[packages/client/ui-commands/src/client/service.ts:234-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L234-L247)）
- `candidates()` 先强等目录就绪，把 host 命令铺成候选行（有 input 的带 hint），再按 `available` 追加客户端贡献，贡献与 host 命令重名时抛错；随后按 position 非 leading 过滤掉带 hint 的行，最后交给模糊排序（[packages/client/ui-commands/src/client/service.ts:250-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L250-L269)）
- `dispatch()` 菜单选中分流：可用贡献开 popup 返回 handled；目录里解析不到描述符返回 undefined；可用装饰开 popup 返回 handled；描述符带 input 返回带认领 token 的 claim；否则先消费菜单 span 再脱钩执行并返回 handled（[packages/client/ui-commands/src/client/service.ts:272-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L272-L295)）
- `matchSpace()` 空格分流：非斜杠开头不认领，命中客户端贡献不认领，只有目录中已就绪且带 input 的 host 命令才返回 claim（[packages/client/ui-commands/src/client/service.ts:298-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L298-L305)）
- `matchEnter()` 回车分流：切出首 token 与「是否裸调用」标记，空名不认领；可用贡献只吃裸行、带图片则抛本地化拒绝文案后开 popup；随后强等目录就绪，解析不到描述符返回 undefined；裸行命中可用装饰时同样先拒图片再开 popup；带 input 的描述符在有图片且未声明 `input.images` 时抛拒绝、否则返回 claim；非裸行不认领；裸行带图片抛拒绝，否则消费 token 后脱钩执行（[packages/client/ui-commands/src/client/service.ts:319-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L319-L364)）
- `openPopup()` 解析会话 scope，取不到则静默返回，否则用该会话控制器打开指定命令的 popup 并带上 token 片段（[packages/client/ui-commands/src/client/service.ts:367-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L367-L376)）
- `leadingClaim()` 构造 `/name ` 认领 token，透传 hint 与 images 声明，并把 submit 绑到拼接后整行的执行（[packages/client/ui-commands/src/client/service.ts:379-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L379-L387)）
- `execute()` 调 `remote.commands.execute`：传输失败抛错；未匹配返回带原行文本的 error 结果；匹配后发出本地已执行通知；带图片且处理器结果为 error 时把该错误文本作为 error 结果返回，其余返回 success（[packages/client/ui-commands/src/client/service.ts:400-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L400-L415)）
- `notifyExecuted()` 手动取出 `command/executed` 的 emit 监听器逐个调用，并把同步抛出与 Promise 拒绝都吞掉转为告警（[packages/client/ui-commands/src/client/service.ts:418-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L418-L432)）
- `warnExecutedListenerFailure()` 用 logger 打两条 warn（命令名一条、错误对象一条）（[packages/client/ui-commands/src/client/service.ts:435-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L435-L438)）
- `runDetached()` 不等待执行结果，只在得到 error 结果或 Promise 拒绝时把文本送进该会话的输入区通知通道（[packages/client/ui-commands/src/client/service.ts:448-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L448-L458)）
- `consumeVia()` 解析会话 scope 后以 `slash/input-consume-token` 冒泡 span 或 bare-token 守卫，scope 不存在则静默返回（[packages/client/ui-commands/src/client/service.ts:461-469](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L461-L469)）
- `noticeFor()` 在会话 scope 或 conversation 服务缺失时静默返回，否则调该会话输入区的 `notify` 发出一条带级别的提示（[packages/client/ui-commands/src/client/service.ts:472-478](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L472-L478)）
- `scopeFor()` 与 `sessions()` 把 id 换成会话 scope，sessions 服务缺失时抛错（[packages/client/ui-commands/src/client/service.ts:481-489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/client/service.ts#L481-L489)）

### packages/client/ui-commands/src/css-modules.d.ts

为 `*.module.css` 与 `*.css` 导入声明模块类型的环境声明文件。

- 无运行期机制

### packages/client/ui-commands/src/index.ts

命令 UI 插件的宿主半边入口，让插件能出现在宿主 cordis.yml / Loader 中。

- 导出空的 `apply`，插件在宿主侧挂载后不产生任何宿主行为（[packages/client/ui-commands/src/index.ts:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/index.ts#L10)）

### packages/client/ui-commands/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包名与安装器。

- 导出伴生插件名与 `inject: ['invariants']`（[packages/client/ui-commands/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/invariant.ts#L13-L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/client/ui-commands/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/invariant.ts#L22)）
- `apply` 向 invariants 服务注册包名与该空安装器，并以 Promise 返回其 disposer（[packages/client/ui-commands/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/src/invariant.ts#L29-L30)）

### packages/client/ui-commands/tsconfig.json

该包的 TypeScript 编译配置，继承客户端基线并列出工作区项目引用。

- 无运行期机制

### packages/client/ui-commands/tsdown.config.ts

该包的打包配置，调用共享的客户端打包预设。

- 以包名和 `lib/types/index.js`、`lib/types/invariant.js` 两个入口调用共享客户端打包预设，决定发布的运行期 bundle 入口（[packages/client/ui-commands/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-commands/tsdown.config.ts#L3)）
