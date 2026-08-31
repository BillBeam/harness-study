---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/webhook/webhook
---

# packages/webhook/webhook

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、36 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/webhook/webhook/README.md

包 README，说明该包提供的 `ctx.webhookRuntime` 规则注册表与它唯一的内建动作（在 Workspace 中创建根 Session），供维护者与规则作者阅读。

- 记载规则回调返回的 `WebhookSessionRequest.prompt` 原文即为新 Session 中模型看到的全部文本，运行时不追加任何私有包装（[packages/webhook/webhook/README.md:53-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/README.md#L53-L57)）
- 记载该初始提示以一条 user 角色消息留在新 Session 中并持续占用 token，直到压缩替换或移除它（[packages/webhook/webhook/README.md:59-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/README.md#L59-L65)）
- 记载 `model` 省略时快照当前完整部署选择（含 reasoning effort）直到首个请求写下持久 header，以及成功的 `Agent.followup()` 是该操作的提交点（[packages/webhook/webhook/README.md:37-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/README.md#L37-L41)）
- 记载注册即 effect，其 disposer 先隐藏规则再中止并排空活动回调；重复投递会重复运行规则、不做去重（[packages/webhook/webhook/README.md:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/README.md#L30-L32)）

### packages/webhook/webhook/package.json

npm 清单，声明该包的入口、导出与对 Cordis 及各 harness 服务包的 peer 依赖。

- `main`/`types`/`exports` 把 `.`、`./types`、`./invariant`、`./src/*` 映射到具体产物文件，决定运行期可被 import 的入口（[packages/webhook/webhook/package.json:14-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/package.json#L14-L31)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 js/d.ts（[packages/webhook/webhook/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/package.json#L32-L37)）

### packages/webhook/webhook/src/brand.ts

为规则 id、适配器源 id、投递 id 提供品牌类型与品牌化函数，被 types.ts、session.ts 与各适配器使用。

- 三个品牌化函数在运行期原样返回入参字符串，仅附加编译期品牌（[packages/webhook/webhook/src/brand.ts:19-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/brand.ts#L19-L39)）

### packages/webhook/webhook/src/index.ts

`WebhookRuntime` 服务的实现：规则注册表、投递分发与失败日志，是该包的插件入口。

- 声明合并把 `webhookRuntime` 挂到 Cordis `Context` 上（[packages/webhook/webhook/src/index.ts:13-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L13-L17)）
- `snapshotDelivery` 校验 kind/source/deliveryId 为非空字符串、`receivedAt` 为非负安全整数，否则抛 TypeError（[packages/webhook/webhook/src/index.ts:39-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L39-L51)）
- `snapshotDelivery` 对投递做无损 JSON 快照并 `deepFreeze`，非无损 JSON 直接抛错（[packages/webhook/webhook/src/index.ts:52-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L52-L55)）
- `static inject` 要求 agents、agentDefaultModel、agentPresets、permissionPresets、sessionTitle、workspaceRegistry 先就绪（[packages/webhook/webhook/src/index.ts:59-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L59-L66)）
- 构造函数注册生命周期 effect：卸载时置 `closing` 并并行拆除所有仍在册的注册（[packages/webhook/webhook/src/index.ts:75-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L75-L81)）
- `register` 在运行时关闭时抛错，并校验 rule 的 id、kind 为非空字符串、`run` 为函数（[packages/webhook/webhook/src/index.ts:89-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L89-L99)）
- `register` 以 `ctx.effect` 建立注册项，拒绝重复 id，并返回 await 后完成拆除的 disposer（[packages/webhook/webhook/src/index.ts:103-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L103-L118)）
- `dispatch` 关闭时抛错、先快照投递，再对每个未关闭且 kind 匹配的注册启动一次调用后同步返回（[packages/webhook/webhook/src/index.ts:126-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L126-L133)）
- `startInvocation` 在调用前后各检查一次 abort 信号，规则返回非 null 时调用 `createWebhookSession`（[packages/webhook/webhook/src/index.ts:137-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L137-L149)）
- 调用失败按是否已 abort 分别记 debug 或 warn 日志，日志文本含 provider/source/delivery/rule 四项（[packages/webhook/webhook/src/index.ts:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L150-L157)）
- 每个调用的 promise 被登记进 `registration.active` 并在 finally 中移除（[packages/webhook/webhook/src/index.ts:158-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L158-L161)）
- `disposeRegistration` 记忆化拆除：置 closing、从表中删除、abort 控制器，然后循环 `allSettled` 直到活动集为空（[packages/webhook/webhook/src/index.ts:165-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/index.ts#L165-L175)）

### packages/webhook/webhook/src/invariant.ts

该包的不变式伴生插件，在 Session 事件流上核对 webhook 来源消息与其 Workspace 归属。

- 监听 `internal/dispatch` 上的 `session/event`，只处理 `agent/inbox/spliced` 中 `source.kind === 'webhook'` 的插入消息（[packages/webhook/webhook/src/invariant.ts:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/invariant.ts#L22-L27)）
- 在提示准入时校验该 Session 有 cwd、恰好属于一个 Workspace、且该 Workspace 路径等于 cwd，否则报告失败（[packages/webhook/webhook/src/invariant.ts:28-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/invariant.ts#L28-L36)）
- `apply` 以包名向 `ctx.invariants` 注册该安装器并返回其 disposer（[packages/webhook/webhook/src/invariant.ts:47-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/invariant.ts#L47-L48)）

### packages/webhook/webhook/src/session.ts

把一条规则结果落成一个 Workspace 支撑的根 Session：校验请求、创建 Workspace 与 Agent、挂载预设、投入初始提示，由 index.ts 调用。

- `requiredString` 对未类型化的规则结果字段要求非空字符串，否则抛 TypeError（[packages/webhook/webhook/src/session.ts:33-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L33-L39)）
- `resolveRequest` 要求结果是非数组对象，并要求 `workspacePath` 为绝对路径（[packages/webhook/webhook/src/session.ts:43-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L43-L51)）
- `resolveRequest` 强制 title、prompt、agentPreset、permissionPreset 四项非空（[packages/webhook/webhook/src/session.ts:52-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L52-L55)）
- 未给 `model` 时取 `ctx.agentDefaultModel.currentSelection()` 的完整快照（含 reasoningEffort）作为本次选择（[packages/webhook/webhook/src/session.ts:62-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L62-L65)）
- 给了 `model` 时要求 provider 与 model 非空、`maxTokens` 为正安全整数，并只把这三项作为 agentOptions（[packages/webhook/webhook/src/session.ts:66-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L66-L81)）
- `installInitialModelSelection` 在该 Agent 的 `agent/request` 波流上，于尚无持久 requestHeader 且路由与快照一致时用快照的 reasoningEffort 覆盖继承值（[packages/webhook/webhook/src/session.ts:91-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L91-L106)）
- 创建前先解析权限预设与 agent 预设、取其 standing key，并在其后检查 abort（[packages/webhook/webhook/src/session.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L126-L130)）
- 解析或创建 Workspace，并以 `webhook-<uuid>` 生成 SessionId（[packages/webhook/webhook/src/session.ts:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L132-L134)）
- `ctx.agents.create` 以 Workspace 路径作为 `cwd`、在 setup 中先挂载 agent 预设再安装初始模型选择（[packages/webhook/webhook/src/session.ts:135-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L135-L144)）
- 依次 attach Workspace、设置权限预设、重命名标题，然后以规则给的 prompt 调用 `followup()`（[packages/webhook/webhook/src/session.ts:147-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L147-L165)）
- 投入的用户消息带 `source.kind: 'webhook'` 及 provider/source/deliveryId/ruleId/form/summary 出处字段（[packages/webhook/webhook/src/session.ts:156-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L156-L164)）
- 失败时按已 attach 与否回滚 Workspace detach 并 dispose Agent，回滚自身失败只记 warn、原错误继续抛出（[packages/webhook/webhook/src/session.ts:166-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/session.ts#L166-L180)）

### packages/webhook/webhook/src/types.ts

该包的类型词汇：投递、规则、Session 请求，以及向 `MessageSourceMap` 的声明合并。

- 向 `@deepseek-ai/dsh-llm` 的 `MessageSourceMap` 合并 `webhook` 消息来源，规定该来源携带的字段与 `form: 'notice'`（[packages/webhook/webhook/src/types.ts:71-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook/src/types.ts#L71-L84)）

### packages/webhook/webhook/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、输出目录与工作区项目引用。

- 无运行期机制
