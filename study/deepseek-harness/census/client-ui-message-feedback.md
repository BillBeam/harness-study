---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-message-feedback
---

# packages/client/ui-message-feedback

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 13 个文件、59 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-message-feedback/README.md

包的英文说明页，描述逐条消息反馈控件的位置、失败呈现与已知限制，供该包的使用者与维护者阅读。

- 无运行期机制

### packages/client/ui-message-feedback/package.json

包清单，声明该包的入口解析、客户端半侧的注入声明与发布文件集。

- `exports` 声明三个入口（`.`、`./invariant`、`./client`）分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，并额外放开 `./src/*` 与 `./package.json`（[packages/client/ui-message-feedback/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/package.json#L16-L31)）
- `dsh.client` 声明该包的浏览器半侧需要注入的四个包并把平台标为 `web`（[packages/client/ui-message-feedback/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/package.json#L32-L42)）
- `files` 把发布内容限定为三个运行时产物与类型声明（[packages/client/ui-message-feedback/package.json:84-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/package.json#L84-L89)）

### packages/client/ui-message-feedback/src/client/MessageFeedbackActions.module.css

反馈按钮、笔记触发器与浮层面板的 CSS Module 样式表，被 `MessageFeedbackActions.tsx` 引入。

- 无运行期机制

### packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx

单条消息的反馈控件组件：点赞／点踩两个按钮加一个笔记触发器，笔记编辑器以 portal 面板形式挂在触发器下方。

- `MEASURE_STYLE` 以 `visibility: hidden` 加显式 `left/top` 渲染尚未定位的面板，使测量时 `offsetWidth` 有真实值（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:31-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L31-L37)）
- 组件从共享视图里取出本 `messageId` 的条目，并单独取一个 `status === 'error'` 的加载失败标志（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L47-L49)）
- `seed` 用 `seeded` ref 保证整个组件生命周期只调用一次 `ensure()`，读取推迟到首次悬停或聚焦而不在挂载时发起（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:64-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L64-L69)）
- `alive` ref 在卸载时置 false，之后到达的结果回调直接返回、不再写状态（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:71-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L71-L72)）
- `noteGeneration` ref 标识一次编辑会话，`closeNote` 自增它并关闭面板，使在途保存变为过期（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:74-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L74-L95)）
- `noteOpenRef` 通过 effect 镜像 `noteOpen`，供过期闭包读取当前的面板开合状态（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:77-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L77-L79)）
- `errorCopy` 把 `version-conflict` 映射到冲突文案，其余映射到通用失败文案（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:81-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L81-L83)）
- `settleRating` 在存活时清 `pending` 并按结果写入或清空行内失败文案（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:85-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L85-L89)）
- `onRate` 置 `pending`、清行内失败、关闭笔记面板，再调用 `toggle(messageId, next)` 并交给 `settleRating` 结算（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:97-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L97-L105)）
- `onSaveNote` 把草稿 trim 后为空的情况走 `clearNote(messageId)`，非空走 `rate(messageId, current, trimmed)`（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:109-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L109-L125)）
- 保存回调无条件清 `pending`；成功且代次未变则清失败并关闭面板，代次已变则仅当草稿仍等于旧种子值时用刚提交的文本回填（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:126-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L126-L149)）
- 保存失败时，只有代次未变或当前没有面板打开才写入 `noteFailure`（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:159-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L159-L161)）
- `toggleNote` 在已开时关闭；在关闭时用已记录的 note 作为草稿种子、清空 `noteFailure` 再打开（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:169-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L169-L183)）
- `useAnchoredPosition` 按触发器矩形、4px 间距与 12px 边距在绘制前定位面板，并随滚动与尺寸变化跟随（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:188-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L188-L194)）
- 面板打开时聚焦文本域，并在 document 上挂 `pointerdown` 与 `keydown`：点在触发器和面板之外或按下 Escape 都关闭；清理函数移除两个监听（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:197-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L197-L215)）
- `wasOpen` ref 使焦点只在面板真正从打开转为关闭时回到触发器，挂载时不夺取焦点（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:220-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L220-L225)）
- 两个按钮的可读标签按当前 rating 在「标记」与「取消标记」两套文案间切换（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:227-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L227-L228)）
- 点赞／点踩按钮把 `aria-pressed` 与 `data-active` 绑到当前 rating、用 `pending` 禁用、在 focus 与 pointerenter 上触发 `seed`、点击调用 `onRate`（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:232-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L232-L261)）
- 笔记触发器只在已有 rating 时渲染，按钮文字为已存 note 或「添加说明」的占位文案（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:262-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L262-L273)）
- 行内失败区：没有评分失败时显示列表加载失败文案，有评分失败时显示该文案（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:274-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L274-L277)）
- 面板不在屏上时，笔记保存失败改由行内区域呈现（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:285-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L285-L287)）
- 面板通过 `createPortal` 挂到 `document.body`，以 `role="dialog"` 呈现，样式取已算出的位置或测量样式，内含受控文本域、按 `pending` 禁用的保存按钮、调用 `closeNote` 的取消按钮以及面板内失败文案（[packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx:288-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/MessageFeedbackActions.tsx#L288-L321)）

### packages/client/ui-message-feedback/src/client/controller.ts

每个会话一个的浏览器侧反馈对象层，被 `client/index.ts` 按 sessionId 创建，供该会话内所有消息控件共享。

- 冻结的初始视图把状态定为 `cold`、条目为空 Map、错误为 null；另有两个冻结的常量结果 `OK` 与 `DISPOSED`（[packages/client/ui-message-feedback/src/client/controller.ts:65-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L65-L78)）
- `describe` 把五个业务失败码映射成可读文本，未知码原样返回（[packages/client/ui-message-feedback/src/client/controller.ts:81-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L81-L90)）
- `fail` 与 `carrierFailure` 分别构造业务失败与载体失败的结果分支（[packages/client/ui-message-feedback/src/client/controller.ts:93-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L93-L100)）
- `getSnapshot` 返回缓存视图，`subscribe` 把监听器加入集合并返回移除函数（[packages/client/ui-message-feedback/src/client/controller.ts:122-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L122-L129)）
- `ensure` 在状态已 ready 时直接返回成功，否则走 `refresh`（[packages/client/ui-message-feedback/src/client/controller.ts:135-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L135-L138)）
- `refresh` 把并发调用者合并到同一个在途读取上，先发布 `loading` 视图并保留旧条目，结束后清空在途引用（[packages/client/ui-message-feedback/src/client/controller.ts:150-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L150-L156)）
- `resync` 把重新读取放进 `mutate` 队列并关掉预置读取，使其排在已排队的写操作之后（[packages/client/ui-message-feedback/src/client/controller.ts:163-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L163-L167)）
- `rate` 在序列化的操作体内读已提交条目，`note` 省略时沿用已存 note 再提交 put（[packages/client/ui-message-feedback/src/client/controller.ts:183-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L183-L192)）
- `toggle` 在已提交 rating 与请求一致时改为删除，否则以已存 note 提交 put（[packages/client/ui-message-feedback/src/client/controller.ts:204-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L204-L210)）
- `clearNote` 在无条目或本就无 note 时直接返回成功，否则以不带 note 的 put 覆盖（[packages/client/ui-message-feedback/src/client/controller.ts:217-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L217-L223)）
- `clear` 在无条目时直接返回成功，否则提交删除（[packages/client/ui-message-feedback/src/client/controller.ts:231-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L231-L237)）
- `putCommitted` 带上最后观察到的 `version`（无条目时为 null）发出 put；载体失败直接返回，成功时提交返回值，`version-conflict` 时先用回复里的权威条目提交再返回失败（[packages/client/ui-message-feedback/src/client/controller.ts:240-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L240-L261)）
- `deleteCommitted` 带 `ifVersion` 发出删除，成功时把该条目提交为 null，`version-conflict` 时用回复里的条目提交（[packages/client/ui-message-feedback/src/client/controller.ts:264-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L264-L281)）
- `dispose` 置位 disposed 并清空监听器集合（[packages/client/ui-message-feedback/src/client/controller.ts:284-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L284-L287)）
- `load` 拉取整个会话的反馈：已 disposed 则不再发布；载体失败与业务失败分别发布带原因的 `error` 视图并保留旧条目；成功时按 `messageId` 建 Map 发布 `ready`；抛出的异常发布为 `transport` 失败（[packages/client/ui-message-feedback/src/client/controller.ts:290-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L290-L313)）
- `mutate` 在 disposed 时返回 `DISPOSED`；默认先 `ensure` 预置读取，读取失败即返回、读取后再查一次 disposed；操作抛出被转成 `transport` 结果；并用 `operationTail` 把每次操作串行接在上一次之后（成功失败都继续）（[packages/client/ui-message-feedback/src/client/controller.ts:320-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L320-L352)）
- `commit` 复制条目 Map 后按传入值删除或写入一项，再发布 `ready` 视图（[packages/client/ui-message-feedback/src/client/controller.ts:360-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L360-L365)）
- `publish` 冻结新视图后逐个通知监听器，并把监听器抛出的异常捕获后打到 `console.error`（[packages/client/ui-message-feedback/src/client/controller.ts:368-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/controller.ts#L368-L377)）

### packages/client/ui-message-feedback/src/client/index.ts

该包浏览器半侧的插件体，把反馈条目注册进助手消息动作条并管理每会话的控制器。

- `inject` 声明该插件需要槽注册表、Remote 根与 `remote.messageFeedback` 命名空间以及 locale 服务（[packages/client/ui-message-feedback/src/client/index.ts:37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/index.ts#L37)）
- `apply` 通过 `ctx.effect` 把 `feedback` 命名空间的中英文字典注册进 locale 服务（[packages/client/ui-message-feedback/src/client/index.ts:45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/index.ts#L45)）
- `controllerFor` 以 sessionId 为键在 Map 中懒建并复用 `MessageFeedbackController`（[packages/client/ui-message-feedback/src/client/index.ts:47-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/index.ts#L47-L55)）
- 监听 `connection/reset`，对所有状态不为 `cold` 的控制器调用 `resync`（[packages/client/ui-message-feedback/src/client/index.ts:59-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/index.ts#L59-L63)）
- 向 `conversation.chat.assistant-actions` 槽注册 id 为 `feedback`、order 为 10、locale 为 `feedback` 的条目，其 inject 按 sessionId 取控制器并交出 `hooks.feedback` 与 ensure/rate/toggle/clearNote/clear 五个动词（[packages/client/ui-message-feedback/src/client/index.ts:65-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/index.ts#L65-L82)）
- 卸载函数撤销槽注册、逐个 dispose 控制器并清空 Map（[packages/client/ui-message-feedback/src/client/index.ts:83-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/client/index.ts#L83-L87)）

### packages/client/ui-message-feedback/src/client/locales.ts

`feedback` 命名空间的中英文文案字典与其键联合类型，由 `client/index.ts` 注册。

- 无运行期机制

### packages/client/ui-message-feedback/src/client/slots.ts

反馈条目注入面与完整 props 的类型声明文件，被组件与插件体作为类型引用。

- 无运行期机制

### packages/client/ui-message-feedback/src/css-modules.d.ts

给 `*.module.css` 与 `*.css` 导入提供类型的声明文件。

- 无运行期机制

### packages/client/ui-message-feedback/src/index.ts

该包宿主半侧的插件入口。

- 导出空的 `apply`，使该插件能出现在宿主 cordis.yml／Loader 中而不产生任何宿主侧行为（[packages/client/ui-message-feedback/src/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/index.ts#L9)）

### packages/client/ui-message-feedback/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包名。

- 导出插件名与 `inject: ['invariants']`，声明登记前必须先有 invariants 服务（[packages/client/ui-message-feedback/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/invariant.ts#L12-L15)）
- 安装器为空函数，`apply` 把包名连同该空安装器注册进 invariants 服务并返回其 disposer（[packages/client/ui-message-feedback/src/invariant.ts:24-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/src/invariant.ts#L24-L32)）

### packages/client/ui-message-feedback/tsconfig.json

该包的 TypeScript 编译配置，声明客户端基配置、输出目录与工程引用。

- 无运行期机制

### packages/client/ui-message-feedback/tsdown.config.ts

该包的打包配置。

- 以包名与 `lib/types/index.js`、`lib/types/invariant.js` 两个入口调用共享的客户端打包配置工厂，决定产出的运行时包入口（[packages/client/ui-message-feedback/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-message-feedback/tsdown.config.ts#L1-L3)）
