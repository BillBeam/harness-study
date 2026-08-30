---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-approval
---

# packages/client/ui-approval

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、37 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-approval/README.md

包的英文说明页，讲这个浏览器审批界面如何接住主机侧的权限请求并把决定回传。

- 无运行期机制

### packages/client/ui-approval/package.json

包清单，声明入口、浏览器半边的注入清单和发布内容。

- `exports` 把 `.`、`./invariant`、`./client`、`./src/*` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与源码目录（[packages/client/ui-approval/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/package.json#L16-L31)）
- `dsh.client` 列出浏览器半边加载前必须先注入的包，并把平台标为 `web`（[packages/client/ui-approval/package.json:32-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/package.json#L32-L44)）
- `files` 把发布内容限定为三个 bundle 与类型声明（[packages/client/ui-approval/package.json:80-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/package.json#L80-L85)）

### packages/client/ui-approval/src/client/ApprovalPanel.module.css

审批面板的样式表。

- 无运行期机制

### packages/client/ui-approval/src/client/ApprovalPanel.tsx

接管对话输入区的审批面板组件，渲染一条待决请求及其可选的工具详情，并把用户的决定交回等待中的请求。

- 只有当请求带 `callId` 时才渲染 `conversation.approval.detail` 子槽位，并把 `callId` 作为属性传下去（[packages/client/ui-approval/src/client/ApprovalPanel.tsx:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/ApprovalPanel.tsx#L14-L16)）
- 以待决项的 `key` 作为 React key，使换一条请求时整棵内部状态重挂（[packages/client/ui-approval/src/client/ApprovalPanel.tsx:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/ApprovalPanel.tsx#L17)）
- 点击后先置「已作答」再调用 `pending.answer(outcome)`，该调用被拒时把「已作答」回滚（[packages/client/ui-approval/src/client/ApprovalPanel.tsx:25-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/ApprovalPanel.tsx#L25-L29)）
- 根节点带 `data-approval-key` 属性，值为该待决项的 key（[packages/client/ui-approval/src/client/ApprovalPanel.tsx:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/ApprovalPanel.tsx#L31)）
- 内容区带 `data-approval-scroll` 标记、`tabIndex=0`、`role="group"` 与本地化的 `aria-label`，使其可聚焦滚动（[packages/client/ui-approval/src/client/ApprovalPanel.tsx:34-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/ApprovalPanel.tsx#L34-L40)）
- 标题优先用请求自带的 `reason`，缺失时用带工具名的越权文案（[packages/client/ui-approval/src/client/ApprovalPanel.tsx:41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/ApprovalPanel.tsx#L41)）
- 两个按钮分别提交 `rejected` 与 `allowed-once`，作答后同时禁用（[packages/client/ui-approval/src/client/ApprovalPanel.tsx:44-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/ApprovalPanel.tsx#L44-L51)）

### packages/client/ui-approval/src/client/contract/slots.ts

审批的待决对象与槽位声明：`PendingApproval` 是浏览器侧对一条主机 waterfall 请求的可作答表示。

- `settlePendingComposer` 把同步的结算调用包成 Promise，抛出的非 Error 值被包成带 `cause` 的 Error 后拒绝（[packages/client/ui-approval/src/client/contract/slots.ts:10-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/contract/slots.ts#L10-L19)）
- 模块级自增计数器为每个待决项生成 `approval:<n>` 形式的渲染标识（[packages/client/ui-approval/src/client/contract/slots.ts:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/contract/slots.ts#L66)）
- 构造时用 `Promise.withResolvers` 建出交回主机的结果 Promise 并留存其 resolve/reject（[packages/client/ui-approval/src/client/contract/slots.ts:94-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/contract/slots.ts#L94-L104)）
- 请求带取消信号时以 `{ once: true }` 挂 abort 监听，信号已处于 aborted 状态则立即触发一次（[packages/client/ui-approval/src/client/contract/slots.ts:105-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/contract/slots.ts#L105-L115)）
- `answer()` 用用户的决定 resolve 那个结果 Promise（[packages/client/ui-approval/src/client/contract/slots.ts:121-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/contract/slots.ts#L121-L125)）
- `delegate()` 用一个私有 Symbol 拒绝结果 Promise，把未作答的请求让给 waterfall 的下一个监听者；已结算时直接返回（[packages/client/ui-approval/src/client/contract/slots.ts:128-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/contract/slots.ts#L128-L131)）
- `isDelegation()` 以身份比较判断一个拒绝值是否就是该 Symbol（[packages/client/ui-approval/src/client/contract/slots.ts:138-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/contract/slots.ts#L138-L140)）
- `abort()` 用给定原因拒绝未作答的请求，已结算时直接返回（[packages/client/ui-approval/src/client/contract/slots.ts:146-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/contract/slots.ts#L146-L149)）
- `finish()` 对重复结算直接抛错，置位后先摘掉 abort 监听再执行结算（[packages/client/ui-approval/src/client/contract/slots.ts:151-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/contract/slots.ts#L151-L158)）

### packages/client/ui-approval/src/client/index.ts

浏览器半边的插件入口：注册审批文案、把面板挂到对话输入区槽位，并监听 `approval/request` 这条 Remote 事件 waterfall。

- 声明必须注入的服务：`sessions`、`remote`、`uiSession`、`slots`、`locale`（[packages/client/ui-approval/src/client/index.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L24)）
- 监听触发的上下文若解析不出会话作用域，立刻调用 `next()` 交给下一个监听者（[packages/client/ui-approval/src/client/index.ts:42-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L42-L43)）
- 由请求构造 `PendingApproval`，`callId`、`reason`、`signal` 三个字段只在有值时才带上（[packages/client/ui-approval/src/client/index.ts:44-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L44-L51)）
- 把待决项发布给会话 UI，并给出一个移除回调：被移除时先 `delegate()`，再等本次处理彻底结束（[packages/client/ui-approval/src/client/index.ts:52-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L52-L56)）
- 等待用户作答的结果；若拒绝值是让渡标记就转调 `next()`，其他拒绝原样上抛（[packages/client/ui-approval/src/client/index.ts:57-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L57-L63)）
- 无论走哪条路径，`finally` 都撤下待决项并放行等待中的移除回调（[packages/client/ui-approval/src/client/index.ts:64-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L64-L67)）
- 以 effect 注册 `approval` 命名空间的中英词典（[packages/client/ui-approval/src/client/index.ts:76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L76)）
- 向会话 UI 申请一个待决交互发布器，其排序权重恒为 0（[packages/client/ui-approval/src/client/index.ts:77-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L77-L79)）
- 在 `conversation.composer` 槽位注册面板，优先级为 1，`select` 只在当前待决交互是 `PendingApproval` 实例时匹配，并声明 `conversation.approval.detail` 为会话作用域的单值子槽位（[packages/client/ui-approval/src/client/index.ts:80-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L80-L89)）
- 用非箭头函数注册 `approval/request` 监听，以便把 `this`（触发请求的作用域上下文）传给处理函数（[packages/client/ui-approval/src/client/index.ts:90-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/client/index.ts#L90-L92)）

### packages/client/ui-approval/src/client/locales.ts

`approval` 命名空间的中英词典与键集类型。

- 无运行期机制

### packages/client/ui-approval/src/css-modules.d.ts

给 `*.module.css` 导入声明类型的环境声明文件。

- 无运行期机制

### packages/client/ui-approval/src/index.ts

包的主机半边入口，主机能力另行组装。

- 无运行期机制

### packages/client/ui-approval/src/invariant.ts

本包的 invariant 伴生插件。

- 向 `invariants` 服务注册包名与一个空安装器，并返回该注册的 disposer（[packages/client/ui-approval/src/invariant.ts:14-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/src/invariant.ts#L14-L22)）

### packages/client/ui-approval/tsconfig.json

本包的 TypeScript 编译配置。

- 无运行期机制

### packages/client/ui-approval/tsdown.config.ts

本包的打包配置。

- 指定该客户端包的打包入口为 `lib/types/index.js` 与 `lib/types/invariant.js`（[packages/client/ui-approval/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-approval/tsdown.config.ts#L3)）
