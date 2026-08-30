---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/api/session-controller
---

# packages/api/session-controller

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 36 个文件、409 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/api/session-controller/README.md

会话控制器包的说明文档，讲述 Host 侧 `ctx.sessionController` 服务与 Client 侧 `session`/`skills`/`fileReferences` 远程命名空间的用途、各端点的激活策略、事件流与配置字段。

- 无运行期机制

### packages/api/session-controller/package.json

包清单，声明该包的模块类型、入口解析、Client 打包参数、发布文件集与依赖关系。

- 声明 ESM 模块类型并把默认运行入口指向 `lib/index.js`、类型入口指向 `lib/types/index.d.ts`（[packages/api/session-controller/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./types`、`./remote-events`、`./client`、`./typert`、`./remote`、`./src/*`、`./package.json` 各自映射到具体产物，未列出的子路径无法被导入（[packages/api/session-controller/package.json:16-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/package.json#L16-L47)）
- `dsh.client` 声明 Client 侧打包把网关 client 视为 external、注入网关包、平台为 web（[packages/api/session-controller/package.json:48-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/package.json#L48-L58)）
- `files` 限定发布产物只含指定的 `lib/` 运行时与类型文件（[packages/api/session-controller/package.json:63-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/package.json#L63-L73)）
- `peerDependenciesMeta` 把 jobs、session-persistence、session-projection-cache 三个 peer 标为可选，缺席时不阻断安装（[packages/api/session-controller/package.json:107-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/package.json#L107-L111)）

### packages/api/session-controller/src/agent.ts

Host 侧的 Agent 激活、组合与模型选择实现，被会话控制器的各个端点用来把一个 Session 标识解析成活跃 Agent，或创建、恢复、配置一个 Agent。

- `ApiSessionSubagentOwnership` 用固定文案构造"该会话属于子 Agent 路由"的错误（[packages/api/session-controller/src/agent.ts:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L22-L27)）
- `ApiSessionCwdConflict` 按既存 cwd 是否存在给出两种不同的冲突文案（[packages/api/session-controller/src/agent.ts:30-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L30-L42)）
- `ApiSessionPresetConflict` 按既存 preset 是否存在给出两种不同的冲突文案（[packages/api/session-controller/src/agent.ts:45-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L45-L57)）
- `hasApiSessionSubagentOwner` 以 `header.origin === 'subagent'` 或"父会话存在且注册表判定该 Agent 归父所有"判定该标识归子 Agent 路由（[packages/api/session-controller/src/agent.ts:82-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L82-L92)）
- `apiSessionSubagentOwnershipError` 把归属冲突固定折叠成 `agent-busy` 码并附带 `reason` 细节（[packages/api/session-controller/src/agent.ts:99-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L99-L105)）
- `inspectApiSession` 以 `projectionMode: 'none'` 观察一个冷会话，只返回头与完整事件前缀，不做修复或恢复（[packages/api/session-controller/src/agent.ts:119-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L119-L127)）
- `inspectApiSession` 把 header 缺 cwd 与持久层的 `SESSION_QUERY_SESSION_NOT_FOUND` 都转成 `ApiSessionNotFound`（[packages/api/session-controller/src/agent.ts:124-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L124-L134)）
- 控制器构造时把 `agent`、`session` 两个 Typert 查找与 `agent` 的 Host 上下文解析都接到 `resolveAgent`，失败时抛 `TypertLookupFailure`（[packages/api/session-controller/src/agent.ts:146-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L146-L160)）
- `resolve` 先取活跃 Agent，再对已附着但归子 Agent 路由的会话直接返回归属错误（[packages/api/session-controller/src/agent.ts:185-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L185-L190)）
- `resolve` 用 `resumes` 表按会话 id 去重并发恢复，并在结算后删除表项（[packages/api/session-controller/src/agent.ts:192-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L192-L198)）
- `resolve` 把恢复失败按 `ApiSessionNotFound`、归属异常、竞态后重查、其余归为 `internal` 四路折叠成稳定错误（[packages/api/session-controller/src/agent.ts:199-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L199-L225)）
- `ensureSession` 用 `creations` 表去重创建，并在创建失败时回退到已经出现的活跃 Agent（[packages/api/session-controller/src/agent.ts:242-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L242-L261)）
- `ensureSession` 在拿到 Agent 后依次校验子 Agent 归属、preset 未变、cwd 一致，任一不符即抛出（[packages/api/session-controller/src/agent.ts:262-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L262-L272)）
- `selectionFor` 在 `modelSelection` 投影未注册时抛错，否则用投影的 pending 值作为初始选择（[packages/api/session-controller/src/agent.ts:283-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L283-L289)）
- 选择对象的 `current` getter 在无待用选择时回落到日志中的请求头，并丢弃适配器默认的 reasoningEffort（[packages/api/session-controller/src/agent.ts:292-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L292-L307)）
- 选择对象的 `consume` 只在 provider、model、reasoningEffort 三者全等时清空缓存的待用选择（[packages/api/session-controller/src/agent.ts:311-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L311-L317)）
- `installModelSelection` 把该选择装进 Agent 上下文，并按 Agent 缓存（[packages/api/session-controller/src/agent.ts:320-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L320-L322)）
- `selectForNextRequest` 先向会话日志追加 `model/selection` 事件，再更新执行期选择（[packages/api/session-controller/src/agent.ts:330-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L330-L333)）
- `consumeSelection` 让一条匹配的持久请求头退掉执行期缓存（[packages/api/session-controller/src/agent.ts:343-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L343-L350)）
- `presetForSession` 从 `agentPreset` 投影读取当前 preset（[packages/api/session-controller/src/agent.ts:357-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L357-L359)）
- `serializeImageAdmission` 按 Agent 维护一条 Promise 链，把图片准入与模型选择串行化，且失败不中断后续（[packages/api/session-controller/src/agent.ts:367-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L367-L371)）
- `composeAgent` 在无 preset 服务时只装选择；有服务时解析 preset id 并在 setup 中挂载该 preset（[packages/api/session-controller/src/agent.ts:382-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L382-L392)）
- `liveAgent` 对活跃但归子 Agent 路由的会话返回归属错误而非该 Agent（[packages/api/session-controller/src/agent.ts:394-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L394-L400)）
- `resume` 在没有外部观察时自行 `observeSession`，并把持久层未找到映射成 `ApiSessionNotFound`（[packages/api/session-controller/src/agent.ts:402-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L402-L414)）
- `resumeObserved` 校验观察的 id 与 cwd、再查归属，然后按记录的 preset 组合并调用 `agents.resume`（[packages/api/session-controller/src/agent.ts:420-436](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L420-L436)）
- `createOrAdopt` 先查已附着会话的归属，再对已活跃的直接复用（[packages/api/session-controller/src/agent.ts:445-450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L445-L450)）
- 显式 id 创建在开启持久身份检查时观察冷会话，逐项校验归属、cwd、preset 后走恢复；仅"未找到"才继续新建（[packages/api/session-controller/src/agent.ts:452-473](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L452-L473)）
- 新建前递归创建工作目录，失败时包成带 cause 的错误（[packages/api/session-controller/src/agent.ts:475-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L475-L479)）
- 新建时把 cwd 与解析出的 agentPreset 写进 Agent 元数据（[packages/api/session-controller/src/agent.ts:480-489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L480-L489)）
- `agentOptions` 用部署默认模型选择填充新建与恢复的 provider/model（[packages/api/session-controller/src/agent.ts:492-495](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L492-L495)）
- `installSelection` 在 Agent setup 上下文缺少 Agent 时抛错（[packages/api/session-controller/src/agent.ts:497-501](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L497-L501)）
- `presetForObservation` 要求观察带投影快照，否则抛错（[packages/api/session-controller/src/agent.ts:508-513](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L508-L513)）
- `assertPresetUnchanged` 只在请求 preset 存在且与既存不同时抛冲突（[packages/api/session-controller/src/agent.ts:515-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L515-L522)）
- `agentModelSelection` 把线上选择转成 Agent 选择，并只在存在时用 `ReasoningEffortId` 包装 effort（[packages/api/session-controller/src/agent.ts:525-533](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/agent.ts#L525-L533)）

### packages/api/session-controller/src/catalog.ts

把 Host 上活跃的 LLM 注册表投影成浏览器可读模型目录的纯函数，被模型目录端点在不需要 Session 的情况下调用。

- 默认选择参数缺省时取部署默认模型的当前选择（[packages/api/session-controller/src/catalog.ts:16-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/catalog.ts#L16-L19)）
- 并发遍历每个 provider 的模型列表并逐个解析模型信息，组装 id/name/description 与 reasoning 的 efforts、defaultEffort（[packages/api/session-controller/src/catalog.ts:20-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/catalog.ts#L20-L48)）
- 单个 provider 抛错时被隔离成一条 failure 记录而不使整份目录失败（[packages/api/session-controller/src/catalog.ts:49-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/catalog.ts#L49-L58)）
- 返回值给出默认选择副本、全部可路由 provider id、过滤掉空模型集的分组，以及失败列表（[packages/api/session-controller/src/catalog.ts:60-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/catalog.ts#L60-L66)）

### packages/api/session-controller/src/client/contract/events.ts

Client 侧连续事件窗口的可观察源，被会话对象层写入、被会话绑定暴露给会话内容组装方读取。

- 用 leaf/concat 绳状结构表示窗口，拼接只记录长度而不复制数组（[packages/api/session-controller/src/client/contract/events.ts:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/events.ts#L32-L38)）
- `materialize` 用显式栈按左右序展平绳结构成一维条目数组（[packages/api/session-controller/src/client/contract/events.ts:40-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/events.ts#L40-L57)）
- 快照的 `entries` 是惰性 getter，只有被读取时才展平并缓存（[packages/api/session-controller/src/client/contract/events.ts:59-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/events.ts#L59-L75)）
- 源以空窗口、revision 0、`replace` 空增量初始化（[packages/api/session-controller/src/client/contract/events.ts:97-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/events.ts#L97-L103)）
- `subscribe` 登记监听器并返回退订函数（[packages/api/session-controller/src/client/contract/events.ts:113-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/events.ts#L113-L116)）
- `replace` 整窗替换并发布 `replace` 增量与新的 hasMore（[packages/api/session-controller/src/client/contract/events.ts:123-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/events.ts#L123-L126)）
- `prepend` 把旧页拼到窗口左侧并发布 `prepend` 增量（[packages/api/session-controller/src/client/contract/events.ts:133-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/events.ts#L133-L136)）
- `append` 把一条实时条目拼到右侧，沿用当前 hasMore 并发布 `append` 增量（[packages/api/session-controller/src/client/contract/events.ts:142-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/events.ts#L142-L149)）
- `publish` 每次自增 revision 并同步通知全部订阅者（[packages/api/session-controller/src/client/contract/events.ts:151-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/events.ts#L151-L157)）

### packages/api/session-controller/src/client/contract/result.ts

Client 会话操作的结果类型与传输失败折叠函数，被会话对象层和管理器的每个远程调用出口使用。

- `transportResult` 把任意载体层拒绝折叠成 `ok:false` 且 code 为 `internal` 的失败，message 取 Error 的 message 否则字符串化（[packages/api/session-controller/src/client/contract/result.ts:20-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/contract/result.ts#L20-L29)）

### packages/api/session-controller/src/client/contract/session.ts

Client 会话对外接口的类型声明，规定功能包能对一个会话调用哪些动词以及提交回声的结算语义。

- 无运行期机制

### packages/api/session-controller/src/client/contract/sessions.ts

`ctx.sessions` 会话服务对外接口的类型声明，规定功能包能对会话域做哪些操作。

- 无运行期机制

### packages/api/session-controller/src/client/contract/snapshot.ts

会话生命周期与控制快照的类型声明，包含队列行、本地提交回声、打开状态与提示错误等字段。

- 无运行期机制

### packages/api/session-controller/src/client/index.ts

Client 插件入口，导出会话对象层的公共符号并在 `apply` 中装配会话服务、远程事件监听与控制流。

- `inject` 声明该插件必须拿到 connection、typert、remote 及 commands/session/subagents 三个远程命名空间才装载（[packages/api/session-controller/src/client/index.ts:79-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/index.ts#L79-L86)）
- `apply` 用根上下文和远程命名空间构造 `ClientSessions`（[packages/api/session-controller/src/client/index.ts:93-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/index.ts#L93-L95)）
- 把 `api-session/added`、`removed`、`status`、`activity`、`error` 五类远程事件接到会话服务的对应处理入口（[packages/api/session-controller/src/client/index.ts:96-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/index.ts#L96-L106)）
- 创建控制流：每帧转交给 `handleControlFrame`，失败只写控制台错误，随后立即 `start()`（[packages/api/session-controller/src/client/index.ts:108-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/index.ts#L108-L112)）
- 连接重置事件触发重建，且装载时若已有连接代次则立即执行一次（[packages/api/session-controller/src/client/index.ts:113-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/index.ts#L113-L114)）
- 向 Typert 注册 Client 侧 `agent` 上下文的识别与解析函数（[packages/api/session-controller/src/client/index.ts:115-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/index.ts#L115-L118)）
- 注册卸载效果，在插件销毁时等待控制流关闭（[packages/api/session-controller/src/client/index.ts:119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/index.ts#L119)）

### packages/api/session-controller/src/client/ordered-baseline.ts

把权威基线行合并进已建立的客户端顺序的纯函数，被会话列表刷新用于避免已可见条目跳位。

- 用键索引基线，按现有顺序取基线值并丢弃基线中不存在的条目（[packages/api/session-controller/src/client/ordered-baseline.ts:16-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/ordered-baseline.ts#L16-L22)）
- 基线独有条目插到"最近的后继已知条目"之前，找不到则追加到末尾（[packages/api/session-controller/src/client/ordered-baseline.ts:24-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/ordered-baseline.ts#L24-L41)）

### packages/api/session-controller/src/client/scope.ts

Client 侧 Agent 作用域原语，被会话服务用来为每个会话铸造带标签的 Cordis 上下文。

- `createScope` 挂一个空插件 fiber，并在其上下文扩展出作用域标签与分发过滤器（[packages/api/session-controller/src/client/scope.ts:56-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/scope.ts#L56-L69)）
- 过滤器让未打标签的监听器全局接收，打了标签的只在标签等于本作用域 key 时接收（[packages/api/session-controller/src/client/scope.ts:60-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/scope.ts#L60-L63)）
- `scopeOf` 沿上下文继承链读取私有 Symbol 标签，根上下文得到 undefined（[packages/api/session-controller/src/client/scope.ts:76-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/scope.ts#L76-L78)）

### packages/api/session-controller/src/client/sessions/history-records.ts

历史记录的范围访问与类型收窄小工具，被会话对象层在处理历史页与续接判定时调用。

- `historyEntries` 把校验过的线上记录数组原样当作 Client 条目数组返回，不做逐条转换或复制（[packages/api/session-controller/src/client/sessions/history-records.ts:13-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/history-records.ts#L13-L17)）
- `historyRecordFirstSeq` 取记录内层事件的 seq 作为首序号（[packages/api/session-controller/src/client/sessions/history-records.ts:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/history-records.ts#L24-L26)）
- `historyRecordLastSeq` 对打包记录按 args 或 texts 的长度推出末序号，对标量记录返回同一 seq（[packages/api/session-controller/src/client/sessions/history-records.ts:33-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/history-records.ts#L33-L39)）

### packages/api/session-controller/src/client/sessions/lineage.ts

把会话摘要摊平成带缩进深度的列表行的纯函数，被会话管理器在构建列表快照时调用。

- 按 `parentSessionId` 建父子索引，父不在摘要集里的条目退化为根而不是丢弃（[packages/api/session-controller/src/client/sessions/lineage.ts:48-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/lineage.ts#L48-L61)）
- 深度优先遍历为每行写入 depth 与 completed 标志，子行紧邻父行输出（[packages/api/session-controller/src/client/sessions/lineage.ts:65-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/lineage.ts#L65-L80)）
- 遇到已访问节点时打印一条 warn 并停止该分支，避免环导致无限递归（[packages/api/session-controller/src/client/sessions/lineage.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/lineage.ts#L66-L70)）
- 遍历结束后把仍未访问到的条目按根级补出，保证没有行被丢掉（[packages/api/session-controller/src/client/sessions/lineage.ts:81-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/lineage.ts#L81-L85)）

### packages/api/session-controller/src/client/sessions/manager.ts

Client 会话实例集群、控制帧分发入口与会话列表状态的持有者，由根会话服务构造并投影成列表存储。

- `select` 对既不在列表、又无可用地址的 id 直接抛错（[packages/api/session-controller/src/client/sessions/manager.ts:165-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L165-L169)）
- `select` 保留地址、把地址与父可用性推给已实例化的会话，置为当前、清掉完成提醒、拉取子目录并同步通知（[packages/api/session-controller/src/client/sessions/manager.ts:170-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L170-L181)）
- `selectSubagent` 只接受目录中 kind、mode 都匹配的健康子行，否则抛错（[packages/api/session-controller/src/client/sessions/manager.ts:188-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L188-L193)）
- `clearSelection` 清空当前选择并同步通知（[packages/api/session-controller/src/client/sessions/manager.ts:203-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L203-L206)）
- `navigationAddress` 先查已保留地址，否则遍历所有已载入目录反查一个直接父地址（[packages/api/session-controller/src/client/sessions/manager.ts:222-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L222-L232)）
- `drop` 把实例移出集群并开始异步销毁（[packages/api/session-controller/src/client/sessions/manager.ts:242-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L242-L246)）
- `dispose` 清掉全部防抖定时器与目录标记，销毁全部会话实例并等待静默（[packages/api/session-controller/src/client/sessions/manager.ts:252-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L252-L261)）
- 在途销毁集合让 `dispose` 能反复 `allSettled` 直到全部结算（[packages/api/session-controller/src/client/sessions/manager.ts:263-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L263-L277)）
- `get` 惰性建实例，并先用保留的队列快照做一次控制替换（[packages/api/session-controller/src/client/sessions/manager.ts:285-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L285-L294)）
- `get` 用列表摘要同步 blank/running；无摘要时退回目录子行，按其 activity 定 running 且 blank 记为 false（[packages/api/session-controller/src/client/sessions/manager.ts:295-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L295-L313)）
- `createSession` 给新实例带上地址、父可用性、投影存储，并注册 `onEngaged` 回调把首发翻转写成列表变更（[packages/api/session-controller/src/client/sessions/manager.ts:316-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L316-L333)）
- 每个会话的投影存储按需创建、独立于实例存活，并把任意键变更接进管理器的批量重建通道（[packages/api/session-controller/src/client/sessions/manager.ts:336-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L336-L346)）
- `refreshSubagents` 复用在途请求，并在发起前把目录置为 loading 且保留旧条目（[packages/api/session-controller/src/client/sessions/manager.ts:352-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L352-L366)）
- 成功分支把请求期累积的行变更折进结果、用覆盖值决定 parentAvailable，并把该值推给所有该父下的子会话实例（[packages/api/session-controller/src/client/sessions/manager.ts:368-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L368-L383)）
- 业务失败与抛出分支都保留旧条目、折进行变更并落成 error 状态（[packages/api/session-controller/src/client/sessions/manager.ts:384-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L384-L409)）
- 结算时删除在途标记，并在有 stale 标记时先补发一次尾随刷新再标脏（[packages/api/session-controller/src/client/sessions/manager.ts:410-417](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L410-L417)）
- `setSubagentCatalogOpen` 开启时登记并立即刷新，关闭时注销并清掉未触发的防抖定时器（[packages/api/session-controller/src/client/sessions/manager.ts:433-445](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L433-L445)）
- `refreshList` 单飞：已有在途拉取直接复用，并在发起时开一个变更缓冲区（[packages/api/session-controller/src/client/sessions/manager.ts:450-457](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L450-L457)）
- 首次拉取直接采用返回项，之后的拉取用有序基线合并保持既有顺序（[packages/api/session-controller/src/client/sessions/manager.ts:460-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L460-L464)）
- 先用基线播种首次 running 观测，再逐条重放缓冲变更并在每条之后重算完成提醒（[packages/api/session-controller/src/client/sessions/manager.ts:465-483](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L465-L483)）
- 拉取成功后把每行的 blank/running 推给已实例化的会话（[packages/api/session-controller/src/client/sessions/manager.ts:484-490](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L484-L490)）
- 列表返回的投影块按键逐个 `apply`（而非整块 seed），缺席键不清空、低 seq 不覆盖（[packages/api/session-controller/src/client/sessions/manager.ts:491-503](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L491-L503)）
- 业务失败与抛出都把列表置为 error 并记录错误，finally 清缓冲、清在途并标脏（[packages/api/session-controller/src/client/sessions/manager.ts:504-517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L504-L517)）
- `search` 把远程结果复制成请求局部值返回，不写入列表快照（[packages/api/session-controller/src/client/sessions/manager.ts:529-546](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L529-L546)）
- `create` 按有无 workspaceId 组装两种请求载荷并可带调用方预分配的 id（[packages/api/session-controller/src/client/sessions/manager.ts:563-567](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L563-L567)）
- `create` 成功即本地合入一条 blank 的摘要，不等下次刷新（[packages/api/session-controller/src/client/sessions/manager.ts:568-572](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L568-L572)）
- 工作区附着失败时仍把错误里携带的已发布会话 id 合入列表（[packages/api/session-controller/src/client/sessions/manager.ts:573-586](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L573-L586)）
- `fork` 把子会话按 `blank:false` 与 `parentSessionId` 合入列表，并继承源会话的 cwd；附着失败时同样合入（[packages/api/session-controller/src/client/sessions/manager.ts:602-624](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L602-L624)）
- `recordMutation` 立即应用一条变更、写入重放缓冲、重算完成提醒并标脏（[packages/api/session-controller/src/client/sessions/manager.ts:638-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L638-L644)）
- `getListSnapshot` 读前先 `ensureFresh`，脏时同步重建缓存快照（[packages/api/session-controller/src/client/sessions/manager.ts:661-664](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L661-L664)）
- `handleControlFrame` 按 baseline / projection / jobs / 队列四类分派：投影帧按 seq 落库，jobs 空集删键非空写键，队列帧写入并转发给对应实例（[packages/api/session-controller/src/client/sessions/manager.ts:672-690](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L672-L690)）
- `replaceControlBaseline` 清空并重填队列与 jobs、对每个会话投影先 `truncate` 再 `seed`，最后把队列推给全部实例（[packages/api/session-controller/src/client/sessions/manager.ts:692-712](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L692-L712)）
- `handleSessionAdded` 合入摘要、同步 blank、把随附投影按键落库（[packages/api/session-controller/src/client/sessions/manager.ts:718-727](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L718-L727)）
- 新增的子 Agent 会话把父行标为可展开，并在父被选中或其目录打开时安排一次防抖刷新（[packages/api/session-controller/src/client/sessions/manager.ts:728-734](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L728-L734)）
- `handleSessionRemoved` 对持久子 Agent 只置 running=false，对普通会话才真正移除行与实例（[packages/api/session-controller/src/client/sessions/manager.ts:741-749](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L741-L749)）
- 移除时清掉队列与 jobs，且只有非持久子 Agent 才丢弃其投影存储（[packages/api/session-controller/src/client/sessions/manager.ts:750-752](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L750-L752)）
- 被移除者若正有在途目录请求，则记下 parentAvailable=false 覆盖并标记 stale，让结果与后续刷新都反映失效（[packages/api/session-controller/src/client/sessions/manager.ts:753-757](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L753-L757)）
- 被移除者已载入的目录改写为 parentAvailable=false，并把该事实推给所有以它为父的子会话实例（[packages/api/session-controller/src/client/sessions/manager.ts:758-766](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L758-L766)）
- `handleSessionStatus` 同时更新列表行、实例 running 位与目录中的 activity（[packages/api/session-controller/src/client/sessions/manager.ts:774-778](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L774-L778)）
- `handleSessionActivity` 把一条持久用户消息的时间戳写进列表活动时间（[packages/api/session-controller/src/client/sessions/manager.ts:785-787](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L785-L787)）
- `handleSessionError` 只把失败文案送到已实例化的会话（[packages/api/session-controller/src/client/sessions/manager.ts:794-796](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L794-L796)）
- `handleConnected` 在连接重建后重拉列表，并刷新当前会话、其父地址以及所有打开的目录（[packages/api/session-controller/src/client/sessions/manager.ts:802-808](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L802-L808)）
- `scheduleCatalogRefresh` 以 50ms 防抖合并成员变化；回调时若仍有在途请求，只打 stale 标记而不发新请求（[packages/api/session-controller/src/client/sessions/manager.ts:811-825](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L811-L825)）
- `updateCatalogActivity` 把一次运行态迁移同时写进所有在途请求的行变更表与所有已载入目录（[packages/api/session-controller/src/client/sessions/manager.ts:828-845](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L828-L845)）
- 可展开提示同样双写在途请求表与已载入目录，且只单向置 true（[packages/api/session-controller/src/client/sessions/manager.ts:848-867](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L848-L867)）
- `withCatalogMutations` 在目录发布前把请求期累积的 hasChildren 与 activity 覆盖折进条目（[packages/api/session-controller/src/client/sessions/manager.ts:870-885](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L870-L885)）
- `syncCompletedNotifications` 以 running 的真→假边沿为非选中会话置提醒、running 为真则撤销、首次观测只记录，并清掉已消失会话的记录（[packages/api/session-controller/src/client/sessions/manager.ts:895-917](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L895-L917)）
- `buildListSnapshot` 从各会话投影存储读 `title` 键与全部投影值，非空字符串才作为标题挂到行上（[packages/api/session-controller/src/client/sessions/manager.ts:919-931](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L919-L931)）
- 行对象按逐字段比较复用上一次的引用，并清掉不再出现的缓存条目（[packages/api/session-controller/src/client/sessions/manager.ts:932-948](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L932-L948)）
- 顺序与引用全同时保留旧数组引用；当前选择只有仍在列表或仍持有地址时才作为 `current` 暴露（[packages/api/session-controller/src/client/sessions/manager.ts:949-965](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L949-L965)）
- `upsert` 变更对新 id 前插，对既有行只补齐缺失的 cwd/parentSessionId/origin，且 blank 只能被拉低（[packages/api/session-controller/src/client/sessions/manager.ts:972-990](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L972-L990)）
- `status` 变更把 running=true 同时当作跨端 blank 翻转的证据（[packages/api/session-controller/src/client/sessions/manager.ts:993-999](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L993-L999)）
- `activity` 变更只在新时间戳更大时前推，`engaged` 变更只把 blank 置为 false（[packages/api/session-controller/src/client/sessions/manager.ts:1000-1008](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L1000-L1008)）
- `workspaceAttachSessionId` 只从 `workspace-attach-failed` 这一码里取出已发布会话 id（[packages/api/session-controller/src/client/sessions/manager.ts:1013-1015](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L1013-L1015)）
- `toSessionResult` 把生成的远程失败原样收窄为会话域错误词表（[packages/api/session-controller/src/client/sessions/manager.ts:1018-1022](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/manager.ts#L1018-L1022)）

### packages/api/session-controller/src/client/sessions/notifier.ts

订阅通知的批处理器，被会话管理器与每个投影通道用来决定快照何时重建、订阅者何时被唤醒。

- `subscribe` 登记回调并返回退订函数（[packages/api/session-controller/src/client/sessions/notifier.ts:23-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/notifier.ts#L23-L28)）
- `markDirty` 置脏并在微任务里通知，已排微任务时不重复排程（[packages/api/session-controller/src/client/sessions/notifier.ts:31-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/notifier.ts#L31-L36)）
- `markFrameDirty` 每帧最多发布一次累计状态，没有 rAF 时降级为微任务（[packages/api/session-controller/src/client/sessions/notifier.ts:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/notifier.ts#L39-L44)）
- `notifyNow` 作废已排程的发布并在同一 tick 内同步冲刷（[packages/api/session-controller/src/client/sessions/notifier.ts:50-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/notifier.ts#L50-L55)）
- `ensureFresh` 在脏时同步重建快照但不消耗待发通知（[packages/api/session-controller/src/client/sessions/notifier.ts:61-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/notifier.ts#L61-L65)）
- 排程带代次号，代次不符的回调直接丢弃（[packages/api/session-controller/src/client/sessions/notifier.ts:67-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/notifier.ts#L67-L85)）
- `flush` 在无订阅者时直接返回并保留脏位，交由下次读取重建；有订阅者时先重建再统一通知（[packages/api/session-controller/src/client/sessions/notifier.ts:87-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/notifier.ts#L87-L96)）

### packages/api/session-controller/src/client/sessions/projection-store.ts

每个会话的投影值存储，被管理器按会话创建，接收控制流的投影帧与历史基线，并向按键订阅者暴露只读面。

- `faceOf` 返回按键身份稳定的可观察面，键从未出现时快照读到 undefined（[packages/api/session-controller/src/client/sessions/projection-store.ts:90-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/projection-store.ts#L90-L92)）
- `values()` 把全部行冻结成一份引用稳定的值表并缓存（[packages/api/session-controller/src/client/sessions/projection-store.ts:108-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/projection-store.ts#L108-L115)）
- `subscribeAny` 提供任意键变更的粗粒度通道（[packages/api/session-controller/src/client/sessions/projection-store.ts:123-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/projection-store.ts#L123-L125)）
- `apply` 遵循"高 seq 胜"：小于等于现有 seq 的帧被丢弃（[packages/api/session-controller/src/client/sessions/projection-store.ts:133-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/projection-store.ts#L133-L138)）
- `seed` 按同一 seq 规则写入基线携带的每个键，并清掉基线未携带且 seq 不高于切点的行（[packages/api/session-controller/src/client/sessions/projection-store.ts:148-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/projection-store.ts#L148-L159)）
- `truncate` 丢弃 seq 高于新基线的行，避免它们永久压过重算出的低 seq 值（[packages/api/session-controller/src/client/sessions/projection-store.ts:168-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/projection-store.ts#L168-L174)）
- `changed` 使值表缓存失效，并同时标脏该键通道与任意键通道（[packages/api/session-controller/src/client/sessions/projection-store.ts:176-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/projection-store.ts#L176-L180)）
- 按键通道按需创建并缓存，其面直接读行、订阅走该键自己的批处理器（[packages/api/session-controller/src/client/sessions/projection-store.ts:182-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/projection-store.ts#L182-L197)）

### packages/api/session-controller/src/client/sessions/queue-mirror.ts

会话瞬时队列的客户端镜像，被会话对象层用控制帧替换、并在持久事件到达时退掉转向行。

- 预览文本把非文本块渲染成 `[类型]`、压缩空白，并按 200 个码点截断加省略号（[packages/api/session-controller/src/client/sessions/queue-mirror.ts:6-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/queue-mirror.ts#L6-L14)）
- 只有全部块都是文本时才给出可编辑文本，否则为 null（[packages/api/session-controller/src/client/sessions/queue-mirror.ts:16-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/queue-mirror.ts#L16-L19)）
- `replace` 用一帧权威队列整体重建行，保留 id、messageId、placement 与用于回声关联的 rpcId（[packages/api/session-controller/src/client/sessions/queue-mirror.ts:39-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/queue-mirror.ts#L39-L52)）
- `acceptDurable` 只在事件为 `user/message` 且存在同 messageId 的 steering 行时移除该行并报告变化（[packages/api/session-controller/src/client/sessions/queue-mirror.ts:59-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/queue-mirror.ts#L59-L67)）

### packages/api/session-controller/src/client/sessions/remotes.ts

会话集群所调用的远程命名空间的接口声明，规定 Session 与其管理器可触达的 commands、session、subagents 方法。

- 无运行期机制

### packages/api/session-controller/src/client/sessions/service.ts

Client 根会话服务：持有列表快照存储、持久选择、Agent 作用域树与会话绑定缓存，由 Client 插件入口构造并注册为 `ctx.sessions`。

- `SessionCreateError` / `SessionForkError` 把业务或传输错误的 code 与 message 拼进抛出的异常文案（[packages/api/session-controller/src/client/sessions/service.ts:96-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L96-L125)）
- `displayTitleOf` 按持久标题、工作目录基名、原始 id 三级回落（[packages/api/session-controller/src/client/sessions/service.ts:146-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L146-L153)）
- `increasedForkTitle` 用 BigInt 递增半角或全角括号内的尾号，无编号时追加 ` (1)`（[packages/api/session-controller/src/client/sessions/service.ts:161-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L161-L171)）
- 构造时建持久化选择存储（键 `dsh.sessions.current`），并用恢复出的会话 id 与地址初始化管理器（[packages/api/session-controller/src/client/sessions/service.ts:225-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L225-L233)）
- 列表存储以空 ids、pending 阶段初始化（[packages/api/session-controller/src/client/sessions/service.ts:234-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L234-L237)）
- 订阅管理器变化投影成列表存储，再订阅列表存储驱动舞台跟随（[packages/api/session-controller/src/client/sessions/service.ts:240-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L240-L251)）
- 注册卸载效果：退订两条通道、清空作用域与延迟移除集合、逐个投放作用域销毁并等待静默，最后销毁管理器（[packages/api/session-controller/src/client/sessions/service.ts:252-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L252-L262)）
- 把自身以 `sessions` 名注册进上下文反射（[packages/api/session-controller/src/client/sessions/service.ts:263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L263)）
- 选择、子目录、清空、刷新、搜索等对外动词直接转交给管理器（[packages/api/session-controller/src/client/sessions/service.ts:270-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L270-L340)）
- 控制帧与五类远程会话事件的处理入口逐一转交给管理器（[packages/api/session-controller/src/client/sessions/service.ts:346-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L346-L393)）
- `create` 失败抛 `SessionCreateError`，成功时在 resolve 前同步投影列表，使新会话立刻可被绑定寻址（[packages/api/session-controller/src/client/sessions/service.ts:406-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L406-L411)）
- `fork` 把小数 seq 向下取整后再上送，失败抛 `SessionForkError`，成功后同步投影列表（[packages/api/session-controller/src/client/sessions/service.ts:433-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L433-L444)）
- 请求继承标题时，`fork` 在返回前对子会话执行一次递增标题的重命名，子不可寻址或重命名失败都抛错（[packages/api/session-controller/src/client/sessions/service.ts:445-452](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L445-L452)）
- `resolveAgentScope` 对远程事件点名的身份无条件铸造作用域，不受列表资格限制（[packages/api/session-controller/src/client/sessions/service.ts:472-474](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L472-L474)）
- `sessionOf` 从上下文标签取 id 再回查作用域记录里的会话面，标签缺失或作用域已裁掉时返回 undefined（[packages/api/session-controller/src/client/sessions/service.ts:497-501](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L497-L501)）
- `followCurrent` 对 current 为空、行缺失或与舞台相同的情形直接返回，保住被遮蔽期间的冻结作用域（[packages/api/session-controller/src/client/sessions/service.ts:520-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L520-L527)）
- 舞台移动时先清算延迟销毁，再解析新占位者并触发其历史窗口打开与子目录刷新（[packages/api/session-controller/src/client/sessions/service.ts:528-536](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L528-L536)）
- `resolve` 只对已有作用域或通过资格判定的 id 铸造作用域（[packages/api/session-controller/src/client/sessions/service.ts:545-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L545-L550)）
- `materializeScope` 铸造作用域、取会话实例、把作用域绑到实例上，并组装出绑定对象（[packages/api/session-controller/src/client/sessions/service.ts:553-568](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L553-L568)）
- `eligible` 以"是当前选择或在列表 ids 中"作为铸造与裁剪共用的存活判据（[packages/api/session-controller/src/client/sessions/service.ts:571-574](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L571-L574)）
- `projectList` 把管理器行投影成带 displayTitle 及可选字段的摘要表与 id 顺序（[packages/api/session-controller/src/client/sessions/service.ts:577-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L577-L600)）
- 当前会话带地址时沿父地址向上走一遍，为面包屑补出目录里的子行摘要，遇环、遇非子 Agent 父或找不到子行即停（[packages/api/session-controller/src/client/sessions/service.ts:601-629](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L601-L629)）
- 无 current 时清空持久选择；有 current 且行存在时，只在 id 或地址三字段任一不同时才写回持久单元（[packages/api/session-controller/src/client/sessions/service.ts:630-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L630-L644)）
- 写入列表存储后立即执行作用域裁剪（[packages/api/session-controller/src/client/sessions/service.ts:645-646](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L645-L646)）
- `pruneScopes` 在列表仍为 pending 阶段时不裁剪；对失去资格者，舞台上的推入延迟集合，其余立即销毁（[packages/api/session-controller/src/client/sessions/service.ts:650-662](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L650-L662)）
- 在途销毁集合让根销毁能反复 `allSettled` 直到全部作用域结算（[packages/api/session-controller/src/client/sessions/service.ts:664-677](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L664-L677)）
- `dropScope` 先解绑会话的分发点，再并行销毁作用域 fiber 与丢弃会话实例（[packages/api/session-controller/src/client/sessions/service.ts:686-694](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L686-L694)）
- `sweepDeferred` 对重新获得资格的延迟项取消销毁，其余从作用域表移除并投放销毁（[packages/api/session-controller/src/client/sessions/service.ts:697-718](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/service.ts#L697-L718)）

### packages/api/session-controller/src/client/sessions/session.ts

浏览器侧单个会话的数据层对象，持有事件窗口、待发回显、队列镜像与快照，被会话管理器构造并由 React 绑定通过 subscribe/getSnapshot 读取。

- 常量 `PAGE_MESSAGES = 50` 决定每次历史请求拉取的消息条数（[packages/api/session-controller/src/client/sessions/session.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L44)）
- 构造时采用外部传入的投影值存储，否则自建私有存储，并把地址与父可用性写入实例（[packages/api/session-controller/src/client/sessions/session.ts:152-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L152-L154)）
- 通知器的脏标记回调重建快照缓存，构造末尾先行生成一次快照（[packages/api/session-controller/src/client/sessions/session.ts:155-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L155-L158)）
- `bindScope` 只允许绑定一次作用域上下文，重复绑定抛错（[packages/api/session-controller/src/client/sessions/session.ts:169-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L169-L172)）
- `unbindScope` 清空作用域，使依赖派发的行为跳过而不报错（[packages/api/session-controller/src/client/sessions/session.ts:175-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L175-L177)）
- `beginSubmission` 生成 requestId、把本地回显追加进 pendingSubmissions、登记结算回调、置 promptAttempted 并同步标脏，返回带 abandon 的句柄（[packages/api/session-controller/src/client/sessions/session.ts:188-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L188-L202)）
- `prompt` 首个 await 之前清空 promptError/lastAgentError、置 promptAttempted、空会话置 firstPromptPendingTurn 并标脏（[packages/api/session-controller/src/client/sessions/session.ts:218-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L218-L225)）
- 无子代理地址时采样浏览器时区并调用 `session.prompt` 远端方法，带上 requestId、模式与内容（[packages/api/session-controller/src/client/sessions/session.ts:228-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L228-L236)）
- one-shot 子代理地址不发起任何请求，直接返回 `subagent-not-resumable` 失败（[packages/api/session-controller/src/client/sessions/session.ts:237-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L237-L245)）
- 子代理续写含图片内容时本地拒绝为 `attachment-error`，不发出请求（[packages/api/session-controller/src/client/sessions/session.ts:247-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L247-L255)）
- 可续写子代理地址改走 `subagents.prompt`，只把 text 分片透传并另铸 requestId（[packages/api/session-controller/src/client/sessions/session.ts:257-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L257-L268)）
- 传输抛错折叠为 transportResult 失败（[packages/api/session-controller/src/client/sessions/session.ts:270-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L270-L272)）
- 失败路径退回对应回显、把错误写入 snapshot 的 promptError 并标脏（[packages/api/session-controller/src/client/sessions/session.ts:273-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L273-L278)）
- 只有被接受的提示才把 blankBit 降为 false 并触发 onEngaged 回调（[packages/api/session-controller/src/client/sessions/session.ts:287-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L287-L291)）
- `readAttachment` 调用远端附件方法并把 base64 解成 Uint8Array 返回（[packages/api/session-controller/src/client/sessions/session.ts:300-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L300-L315)）
- `updateQueue` 把条目 id 与动作直传远端队列更新方法（[packages/api/session-controller/src/client/sessions/session.ts:318-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L318-L324)）
- `cancel` 对 one-shot 地址直接产出 `subagent-delivery-unavailable` 并写入 promptError（[packages/api/session-controller/src/client/sessions/session.ts:336-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L336-L349)）
- 其余情况按有无子代理地址分别走 `subagents.interruptByParent` 或 `session.cancel`（[packages/api/session-controller/src/client/sessions/session.ts:350-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L350-L361)）
- 取消失败写入 op 为 stop 的 promptError 并标脏（[packages/api/session-controller/src/client/sessions/session.ts:362-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L362-L366)）
- `rename` 成功后按响应的 `{title, seq}` 立即写入 title 投影单元（[packages/api/session-controller/src/client/sessions/session.ts:378-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L378-L386)）
- `command` 调用远端命令执行并把返回值是否存在折成 matched 布尔（[packages/api/session-controller/src/client/sessions/session.ts:395-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L395-L399)）
- `open` 对已打开返回已决 Promise、对在途返回同一 Promise，并以身份判等清空 openPromise（[packages/api/session-controller/src/client/sessions/session.ts:402-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L402-L411)）
- `loadOlder` 仅在已打开、还有更多且无在途加载时以窗口首 seq 作为 beforeSeq 向前翻页，并在前后翻转 loadingOlder（[packages/api/session-controller/src/client/sessions/session.ts:414-430](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L414-L430)）
- `resync` 递增 openGeneration 使在途 open 作废，销毁旧流并把状态复位回 cold 后重新打开（[packages/api/session-controller/src/client/sessions/session.ts:435-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L435-L447)）
- `subscribe` 把监听器交给通知器并返回退订函数（[packages/api/session-controller/src/client/sessions/session.ts:456-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L456-L458)）
- `getSnapshot` 先让通知器刷新脏状态再返回缓存引用（[packages/api/session-controller/src/client/sessions/session.ts:464-467](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L464-L467)）
- `replaceControl` 用基线队列整体替换队列镜像并据此结算回显（[packages/api/session-controller/src/client/sessions/session.ts:475-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L475-L479)）
- `handleControlFrame` 用队列帧条目替换镜像并结算回显（[packages/api/session-controller/src/client/sessions/session.ts:485-489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L485-L489)）
- `handleRunning` 在 running 为真时降下 blankBit、清 firstPromptPendingTurn，并仅在取值变化时更新 running（[packages/api/session-controller/src/client/sessions/session.ts:495-506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L495-L506)）
- `configureSubagent` 比较三元组地址，变化且非 cold 时触发 resync 重建窗口（[packages/api/session-controller/src/client/sessions/session.ts:514-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L514-L522)）
- `handleSubagentParentAvailable` 仅在父可用性变化时更新并标脏（[packages/api/session-controller/src/client/sessions/session.ts:528-532](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L528-L532)）
- `handleBlank` 在已尝试发送或正在运行时拒绝把 blank 重新抬回 true（[packages/api/session-controller/src/client/sessions/session.ts:541-546](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L541-L546)）
- `handleRemoved` 置 removed 标志但保留常驻实例（[packages/api/session-controller/src/client/sessions/session.ts:549-552](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L549-L552)）
- `handleAgentError` 把错误串写入 lastAgentError 并标脏（[packages/api/session-controller/src/client/sessions/session.ts:558-561](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L558-L561)）
- `dispose` 把所有未结算回显按失败退回、递增 generation 并销毁事件流（[packages/api/session-controller/src/client/sessions/session.ts:567-578](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L567-L578)）
- `doOpen` 先置 loading，再建 SessionEventStream，其 publish/failed 回调均按 generation 与流身份双重判定后才写入（[packages/api/session-controller/src/client/sessions/session.ts:583-596](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L583-L596)）
- 打开成功置 open，失败清流并置 error 与 openError，finally 仅在 generation 未变时标脏（[packages/api/session-controller/src/client/sessions/session.ts:597-608](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L597-L608)）
- `acceptEventChange` 按 replace/prepend/append 三类分发到不同的窗口写入路径（[packages/api/session-controller/src/client/sessions/session.ts:612-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L612-L623)）
- `installWindow` 重置 baseSeq/hasMore、遇 turn/start 清等待首轮位、以页内投影块播种投影存储、整体替换事件源并逐条结算回显（[packages/api/session-controller/src/client/sessions/session.ts:626-634](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L626-L634)）
- `prependWindow` 用新页首 seq 更新 baseSeq 并把页前置进事件源（[packages/api/session-controller/src/client/sessions/session.ts:637-641](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L637-L641)）
- `appendLive` 在追加实时事件时清等待首轮位、把持久事件喂给队列镜像、追加到事件源后再结算回显，并返回是否需要标脏（[packages/api/session-controller/src/client/sessions/session.ts:644-655](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L644-L655)）
- `observeSubmissionEvent` 只在 `user/message` 且来源 kind 为 user、rpcId 为字符串时按结构化读取安排回显退场（[packages/api/session-controller/src/client/sessions/session.ts:658-667](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L658-L667)）
- `observeSubmissionQueue` 遍历队列条目，凡带 rpcId 者安排对应回显退场（[packages/api/session-controller/src/client/sessions/session.ts:670-677](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L670-L677)）
- `scheduleObservedRetirement` 用 retiring 位闩锁首次观测，并把移除推迟到下一帧（[packages/api/session-controller/src/client/sessions/session.ts:685-693](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L685-L693)）
- `retireFailedSubmission` 对未闩锁的回显立即以 failed 原因结算（[packages/api/session-controller/src/client/sessions/session.ts:696-701](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L696-L701)）
- `finishSubmission` 删除结算记录、从 pendingSubmissions 过滤掉该回显、标脏后再回调 onRetire（[packages/api/session-controller/src/client/sessions/session.ts:704-712](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L704-L712)）
- `failEventStream` 在流仍属当前实例时置 error 状态、递增 generation、清 openPromise 并销毁流（[packages/api/session-controller/src/client/sessions/session.ts:715-724](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L715-L724)）
- `buildSnapshot` 组装对外唯一可读的快照字段集合，包含队列、回显、running、子代理块、removed、打开状态、翻页与错误位（[packages/api/session-controller/src/client/sessions/session.ts:726-749](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L726-L749)）
- `sessionAddress` 按有无子代理地址产出 session 或 subagent 两种历史路由地址（[packages/api/session-controller/src/client/sessions/session.ts:751-755](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L751-L755)）
- `scheduleFrame` 有帧时钟走 requestAnimationFrame，否则退化为 setTimeout 宏任务（[packages/api/session-controller/src/client/sessions/session.ts:759-762](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L759-L762)）
- `imageRefsIn` 结构化扫描内容块列表，按顺序收集 image 块的附件引用（[packages/api/session-controller/src/client/sessions/session.ts:765-776](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L765-L776)）
- `openFailure` 优先取流终态失败，否则折叠为传输错误（[packages/api/session-controller/src/client/sessions/session.ts:779-786](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L779-L786)）
- `toSessionResult` 把远端失败窄化为会话域错误词表（[packages/api/session-controller/src/client/sessions/session.ts:788-790](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/sessions/session.ts#L788-L790)）

### packages/api/session-controller/src/client/time-zone.ts

浏览器时区采样工具，供会话对象在发起提示 RPC 时附带时区来源。

- 从 `Intl.DateTimeFormat().resolvedOptions().timeZone` 取当前时区，取不到非空字符串时抛错（[packages/api/session-controller/src/client/time-zone.ts:8-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/time-zone.ts#L8-L14)）

### packages/api/session-controller/src/client/transport.ts

会话专用的远端流适配层，把网关通用的快照流与日志流配置成会话控制流和会话事件流，被客户端会话对象与会话管理器使用。

- `toSessionJournalChange` 对 replace/prepend 把记录解包成事件条目，对 append 遇到打包历史记录直接抛错（[packages/api/session-controller/src/client/transport.ts:55-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/transport.ts#L55-L72)）
- `createSessionControlStream` 以 `session.control` 为载体建流，并定义流结束时按是否已收到基线产出可重连错误或终态错误（[packages/api/session-controller/src/client/transport.ts:115-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/transport.ts#L115-L122)）
- 快照流以 `type === 'baseline'` 判定基线帧，基线与增量都路由到同一个 accept 回调（[packages/api/session-controller/src/client/transport.ts:123-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/transport.ts#L123-L129)）
- `SessionEventStream` 构造时配置空游标 -1、页条目与 hasMore 提取、首末 seq 计算、seq 比较与「右 = 左 + 1」的连续性判据（[packages/api/session-controller/src/client/transport.ts:149-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/transport.ts#L149-L163)）
- `follow` 迭代 `session.follow`，把 snapshot 帧转成携带 cursor、记录、hasMore 与投影块的 opened 帧，其余帧转成 entry（[packages/api/session-controller/src/client/transport.ts:167-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/transport.ts#L167-L189)）
- `readPage` 调用 `session.page` 并把业务失败转抛为 RemoteStreamError（[packages/api/session-controller/src/client/transport.ts:192-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/transport.ts#L192-L209)）
- `repairRequest` 重连修复时只保留 maxMessages，丢弃其余分页字段（[packages/api/session-controller/src/client/transport.ts:212-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/transport.ts#L212-L216)）
- `sessionStreamFailure` 只从 RemoteStreamError 还原出主机失败，其余返回 undefined（[packages/api/session-controller/src/client/transport.ts:224-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/client/transport.ts#L224-L227)）

### packages/api/session-controller/src/commands.ts

主机侧会话业务命令实现，被 Session Controller 远端服务委派，负责创建、选模型、改名、分叉、提示准入、附件读取、队列变更与取消。

- `create` 拒绝同时给出 workspaceId 与 cwd（[packages/api/session-controller/src/commands.ts:73-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L73-L75)）
- 未给 sessionId 时铸造 `session-<uuid>` 身份（[packages/api/session-controller/src/commands.ts:76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L76)）
- 指定的工作区不存在时以 `workspace-not-found` 拒绝（[packages/api/session-controller/src/commands.ts:78-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L78-L85)）
- cwd 按工作区路径、请求 cwd、默认 cwd 依次取值，再交给 `ensureSession` 创建或幂等接管（[packages/api/session-controller/src/commands.ts:86-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L86-L97)）
- 创建后把会话挂到工作区，挂载失败以 `workspace-attach-failed` 拒绝（[packages/api/session-controller/src/commands.ts:98-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L98-L108)）
- `selectModel` 先解析出代理，并把整段选择过程串行在图片准入互斥中（[packages/api/session-controller/src/commands.ts:119-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L119-L120)）
- 通过 `llm.resolveCallConfig` 归一化 provider/model/reasoningEffort 后装入会话的下一次请求选择（[packages/api/session-controller/src/commands.ts:122-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L122-L136)）
- 同步保存为默认选择，保存失败只记 warn 不影响本次选择（[packages/api/session-controller/src/commands.ts:137-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L137-L144)）
- 解析失败转成 `model-unavailable` 拒绝，远端失败原样上抛（[packages/api/session-controller/src/commands.ts:145-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L145-L152)）
- `rename` 在未挂载标题服务时以 `internal` 拒绝（[packages/api/session-controller/src/commands.ts:162-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L162-L166)）
- 标题服务归一化后返回接受标题与事件 seq，非法标题转成 `title-invalid`（[packages/api/session-controller/src/commands.ts:167-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L167-L179)）
- `fork` 校验 atSeq 为非负整数（[packages/api/session-controller/src/commands.ts:188-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L188-L190)）
- 通过 `sessionQuery.observeSession` 读源会话，未找到转 `session-not-found`（[packages/api/session-controller/src/commands.ts:191-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L191-L208)）
- 分叉锚点取 seq 不小于 atSeq 的首个 `turn/end`，缺省或越界时退回最后一个 `turn/end`，都不存在则以 `fork-unavailable` 拒绝（[packages/api/session-controller/src/commands.ts:209-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L209-L226)）
- 切点从边界后一位继续前移，直到遇到下一个 `turn/start`（[packages/api/session-controller/src/commands.ts:227-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L227-L228)）
- 以源会话前缀事件作为 seed 创建子会话，meta 记录 cwd、父会话、seedLength 与预设，模型取当前默认选择（[packages/api/session-controller/src/commands.ts:239-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L239-L263)）
- 分叉出的会话再挂到解析出的工作区，失败以 `workspace-attach-failed` 拒绝（[packages/api/session-controller/src/commands.ts:264-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L264-L275)）
- `prompt` 先规范化客户端时区，非法值以 `invalid-time-zone` 拒绝（[packages/api/session-controller/src/commands.ts:284-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L284-L293)）
- 当前选择的 provider 无适配器承载时以 `model-unavailable` 拒绝提示（[packages/api/session-controller/src/commands.ts:294-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L294-L302)）
- 消息来源写入 kind、rpcId 与已验证时区，成为持久化在用户消息上的来源元数据（[packages/api/session-controller/src/commands.ts:303-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L303-L307)）
- 含图片时查询模型输入模态，不支持图片则以 `attachment-error` 拒绝（[packages/api/session-controller/src/commands.ts:310-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L310-L321)）
- 内容转为持久块后建用户消息，按 mode 走 `agent.steer` 或 `agent.followup`（[packages/api/session-controller/src/commands.ts:322-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L322-L325)）
- 附件错误转 `attachment-error`，其余异常统一转 `agent-busy`（[packages/api/session-controller/src/commands.ts:326-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L326-L332)）
- 含图片的提示整体串行在图片准入互斥内，纯文本直接执行（[packages/api/session-controller/src/commands.ts:335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L335)）
- `attachment` 先读会话状态，未找到转 `session-not-found`（[packages/api/session-controller/src/commands.ts:344-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L344-L356)）
- 附件必须在该会话日志中被引用，否则以 `ATTACHMENT_NOT_REFERENCED` 拒绝（[packages/api/session-controller/src/commands.ts:357-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L357-L364)）
- 读到的图片以 base64 编码随持久引用一并返回（[packages/api/session-controller/src/commands.ts:365-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L365-L376)）
- `updateQueue` 拒绝含非文本块的编辑动作（[packages/api/session-controller/src/commands.ts:385-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L385-L392)）
- 属于子代理所有权的会话被拒绝队列变更；代理不存在按 `queue-item-not-found` 拒绝（[packages/api/session-controller/src/commands.ts:393-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L393-L399)）
- 条目在 nextTurn 与 nextStep 两个收件箱中定位，找不到即拒绝（[packages/api/session-controller/src/commands.ts:400-407](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L400-L407)）
- steer 动作要求条目位于 nextTurn 且代理正在运行，否则以 `steer-unavailable` 拒绝（[packages/api/session-controller/src/commands.ts:409-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L409-L411)）
- edit 用冻结的新内容替换收件箱条目，remove/steer 先移除再按需转为插话（[packages/api/session-controller/src/commands.ts:412-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L412-L421)）
- `cancel` 要求代理已附着且非子代理所有，随后以 `keepInbox` 取消当前轮（[packages/api/session-controller/src/commands.ts:430-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L430-L442)）
- `rejectCreation` 把预设冲突、未知预设、预设挂载失败、cwd 冲突与子代理所有权分别映射为独立错误码（[packages/api/session-controller/src/commands.ts:451-482](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L451-L482)）
- `readSessionState` 优先读已附着会话，否则走冷读检视（[packages/api/session-controller/src/commands.ts:484-491](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L484-L491)）
- `forkWorkspace` 先按直接归属找工作区，源为子代理时沿血缘祖先继续查找（[packages/api/session-controller/src/commands.ts:493-503](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L493-L503)）
- `reject`/`rejectFailure` 统一以 TypertRemoteFailure 抛出业务失败（[packages/api/session-controller/src/commands.ts:506-512](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L506-L512)）
- `durablePromptContent` 纯文本直通，含图片时批量准入编码图片并按顺序回填持久引用（[packages/api/session-controller/src/commands.ts:514-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L514-L527)）
- `imageBlockIn` 结构化扫描内容块，并递归进入 tool-result 的嵌套内容（[packages/api/session-controller/src/commands.ts:529-547](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L529-L547)）
- `imageInEvent` 在事件的 content、message.content、inserted 列表与 `assistant/chunk` 的 block-end 块中查找图片（[packages/api/session-controller/src/commands.ts:549-570](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L549-L570)）
- `referencedImage` 遍历全部事件按 attachmentId 命中首个引用（[packages/api/session-controller/src/commands.ts:572-581](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L572-L581)）
- `canonicalClientTimeZone` 用正则限定 IANA 形态并放行 UTC，再交由 Intl 归一化，异常时返回 undefined（[packages/api/session-controller/src/commands.ts:583-593](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L583-L593)）
- `routeServed` 按 `llm.listProviders` 判定 provider 是否可路由（[packages/api/session-controller/src/commands.ts:595-597](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/commands.ts#L595-L597)）

### packages/api/session-controller/src/control.ts

主机侧全局实时控制流的拥有者，把队列、后台作业与投影变化推送给客户端，被 Session Controller 的 control 远端流方法调用。

- 构造时订阅 `session/event` 以驱动队列帧（[packages/api/session-controller/src/control.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L24)）
- 注入投影服务后订阅其变更并广播携带 key、value、seq 的 projection 帧（[packages/api/session-controller/src/control.ts:25-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L25-L35)）
- 注入作业服务后订阅作业变化（[packages/api/session-controller/src/control.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L36-L38)）
- 会话创建时若已有作业则立即广播一次 jobs 帧（[packages/api/session-controller/src/control.ts:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L39-L42)）
- 注册拆卸副作用，在插件卸载时结束并清空所有在途控制流（[packages/api/session-controller/src/control.ts:43-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L43-L46)）
- `control` 先检查中止，注册队列，先产出一个完整基线再迭代增量帧，finally 中注销并结束队列（[packages/api/session-controller/src/control.ts:54-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L54-L65)）
- `baseline` 为每个已附着会话收集队列（仅当代理确实持有该会话对象）与作业列表（[packages/api/session-controller/src/control.ts:67-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L67-L81)）
- `projectionBaseline` 无投影快照时退化为 `asOfSeq = session.seq - 1` 的空值块（[packages/api/session-controller/src/control.ts:83-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L83-L99)）
- `onSessionEvent` 只对 `agent/inbox/spliced` 事件、且代理持有该会话时广播替换式队列帧（[packages/api/session-controller/src/control.ts:101-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L101-L110)）
- `onJobsChanged` 有属主时只播该会话，无属主时对所有已附着会话逐个广播（[packages/api/session-controller/src/control.ts:112-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L112-L124)）
- `jobsFor` 在未挂载作业服务时返回空列表（[packages/api/session-controller/src/control.ts:126-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L126-L129)）
- `broadcast` 把一帧推给当前所有在途控制流（[packages/api/session-controller/src/control.ts:131-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L131-L133)）
- `ControlQueue.push` 在已结束时丢弃帧，否则入缓冲并唤醒等待者（[packages/api/session-controller/src/control.ts:141-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L141-L147)）
- `end` 幂等地置终止位并唤醒等待者（[packages/api/session-controller/src/control.ts:149-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L149-L155)）
- `iterate` 监听 abort 以结束队列，缓冲空时挂起等待唤醒，终止后再排空剩余缓冲，finally 中摘除监听并结束（[packages/api/session-controller/src/control.ts:157-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L157-L174)）
- `queueItems` 在收到 splice 事件时对对应收件箱做 `toSpliced` 预演，使帧反映拼接后的队列（[packages/api/session-controller/src/control.ts:177-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L177-L186)）
- nextTurn 条目标记 placement 为 queued，nextStep 条目按来源是否为 user 标记 steering 或 context，内容作为 JSON 值随帧下发（[packages/api/session-controller/src/control.ts:187-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L187-L201)）
- `promptRpcId` 仅在用户来源带 rpcId 时把它放进队列条目（[packages/api/session-controller/src/control.ts:204-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L204-L207)）
- `jobView` 把作业快照裁成 id、kind、label、status、可选 detail 与起止时间的浏览器安全行（[packages/api/session-controller/src/control.ts:209-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/control.ts#L209-L219)）

### packages/api/session-controller/src/file-references.ts

主机侧 `fileReferences` 远端命名空间的适配服务，把请求转发给已组合的文件引用提供方，由 Session Controller 在构造时挂载。

- 以 `fileReferences` 命名空间注册远端服务，并声明对文件引用与 typert 服务的注入（[packages/api/session-controller/src/file-references.ts:18-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/file-references.ts#L18-L23)）
- `@Remote list` 把代理、查询文本与取消信号转交给提供方并返回候选路径（[packages/api/session-controller/src/file-references.ts:32-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/file-references.ts#L32-L39)）
- 默认导出该服务类，使其可作为插件被挂载（[packages/api/session-controller/src/file-references.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/file-references.ts#L42)）

### packages/api/session-controller/src/history.ts

主机侧冷读历史分页与实时事件跟随的实现，被 Session Controller 的 page 与 follow 远端方法委派。

- 默认单页 50 条消息，且分页只按 `user/message` 与 `assistant/message` 计数（[packages/api/session-controller/src/history.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L24-L25)）
- 注册拆卸副作用，卸载时关闭全部在途跟随者（[packages/api/session-controller/src/history.ts:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L39-L42)）
- `page` 请求的 throughSeq 超过源游标时以 `bad-request` 拒绝（[packages/api/session-controller/src/history.ts:55-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L55-L63)）
- throughSeq 对应位置的事件 seq 不匹配时以 `internal` 拒绝（[packages/api/session-controller/src/history.ts:65-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L65-L67)）
- 分页结果经 `pageRecords` 打包后连同 hasMore 返回（[packages/api/session-controller/src/history.ts:68-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L68-L78)）
- `follow` 用缓冲数组与唤醒回调把 `session/event` 中该会话的事件排入待发队列（[packages/api/session-controller/src/history.ts:91-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L91-L109)）
- 监听 `session/created`，把构造种子事件的后缀（按 firstLiveSeq 或快照游标之后）前插进缓冲以补齐无通知的事件（[packages/api/session-controller/src/history.ts:110-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L110-L120)）
- 首帧产出携带 header、cursor、分页记录、hasMore 与投影基线的 snapshot；无投影时给出空值块（[packages/api/session-controller/src/history.ts:129-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L129-L139)）
- 普通会话且观测来自 prepared 源时，快照发出后触发后台激活，激活登记失败则释放该观测（[packages/api/session-controller/src/history.ts:140-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L140-L148)）
- 跟随循环丢弃早于游标的事件，遇到 seq 跳号以 `internal` 拒绝，其余按序产出（[packages/api/session-controller/src/history.ts:149-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L149-L162)）
- finally 中注销跟随者、摘除中止监听并释放两个事件订阅（[packages/api/session-controller/src/history.ts:163-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L163-L168)）
- `sourceFor` 按是否需要投影与地址类型决定 projectionMode 为 all 或 none（[packages/api/session-controller/src/history.ts:176-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L176-L181)）
- header 无 cwd 视作不存在，释放观测后按地址类型拒绝（[packages/api/session-controller/src/history.ts:182-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L182-L185)）
- 地址校验失败时先释放观测再上抛（[packages/api/session-controller/src/history.ts:186-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L186-L191)）
- 会话查询的未找到错误统一转成地址相关的未找到失败（[packages/api/session-controller/src/history.ts:193-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L193-L197)）
- `validatePageRequest` 校验 throughSeq ≥ -1、beforeSeq 非负、maxMessages 为正整数（[packages/api/session-controller/src/history.ts:212-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L212-L224)）
- `validateFollowRequest` 校验 maxMessages 为正整数（[packages/api/session-controller/src/history.ts:226-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L226-L231)）
- `validateAddress` 拒绝用普通会话地址读取 origin 为 subagent 的会话（[packages/api/session-controller/src/history.ts:242-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L242-L249)）
- 子代理地址要求 header 的 origin 与 parentSession 匹配，否则以 `subagent-unauthorized` 拒绝（[packages/api/session-controller/src/history.ts:250-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L250-L254)）
- 子代理描述符为 null、缺失或 seq 早于 seedLength 时分别以 corrupt/unsupported 诊断拒绝（[packages/api/session-controller/src/history.ts:255-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L255-L269)）
- 描述符 mode 与地址 mode 不一致时以 `subagent-unauthorized` 拒绝（[packages/api/session-controller/src/history.ts:270-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L270-L274)）
- `paginate` 从窗口末端反向计消息数，遇到带 sourceEventSeqs 的事件把切点前移到组内最小 seq，凑够 maxMessages 即截断并给出 hasMore（[packages/api/session-controller/src/history.ts:291-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L291-L315)）
- `chunkEntryFor` 把三类打包增量行转成 `chunkrow/*` 事件形态，seq 与 time 取该行首个元素（[packages/api/session-controller/src/history.ts:325-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L325-L343)）
- `pageRecords` 在不改变分页切点的前提下把连续增量事件打包成运行块（[packages/api/session-controller/src/history.ts:346-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/history.ts#L346-L350)）

### packages/api/session-controller/src/index.ts

包的主机入口：`session` 远端命名空间的服务类，装配命令、控制流、历史、列表四个子控制器并暴露全部远端方法。

- `Config` 声明冷会话空白探测字节上限与原生打开能力开关两个部署可调项（[packages/api/session-controller/src/index.ts:96-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L96-L99)）
- 构造时以 `session` 命名空间注册远端服务并安装模型选择投影（[packages/api/session-controller/src/index.ts:115-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L115-L116)）
- 依次构造代理控制器、命令控制器（默认 cwd 取 `process.cwd()`）与控制流控制器（[packages/api/session-controller/src/index.ts:117-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L117-L119)）
- 在历史控制器之前注册拆卸副作用，使反序拆卸时先关跟随者再等待已受理的后台激活完成（[packages/api/session-controller/src/index.ts:122-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L122-L125)）
- 原生打开能力按 internals 覆盖、配置项、探测函数三级取值（[packages/api/session-controller/src/index.ts:130-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L130-L132)）
- 挂载文件引用与技能目录两个附属远端服务（[packages/api/session-controller/src/index.ts:133-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L133-L134)）
- 会话创建与销毁分别转发为 `api-session/added`（携带列表摘要）与 `api-session/removed`（[packages/api/session-controller/src/index.ts:136-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L136-L141)）
- 代理状态与代理错误分别转发为 `api-session/status` 与 `api-session/error`（[packages/api/session-controller/src/index.ts:142-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L142-L147)）
- `request/header` 事件把请求实际使用的 provider/model/reasoningEffort 回销给会话的选择状态（[packages/api/session-controller/src/index.ts:148-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L148-L157)）
- 用户来源的 `user/message` 事件转发为 `api-session/activity` 并携带事件时间（[packages/api/session-controller/src/index.ts:158-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L158-L160)）
- `promote` 在后台以 using 持有观测激活代理，失败发 `api-session/error`，任务登记进 promotions 集合并在结束后移除（[packages/api/session-controller/src/index.ts:163-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L163-L174)）
- `resolveAgent` 对外暴露解析或恢复代理的入口（[packages/api/session-controller/src/index.ts:181-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L181-L183)）
- `inspect` 优先返回已附着会话的 header 与事件副本，否则走冷读检视（[packages/api/session-controller/src/index.ts:191-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L191-L200)）
- `@Remote('list')` 暴露不唤醒代理的会话列表（[packages/api/session-controller/src/index.ts:208-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L208-L211)）
- `@Remote('search')` 暴露会话内容搜索（[packages/api/session-controller/src/index.ts:219-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L219-L222)）
- `@Remote('create')` 暴露会话创建或幂等接管（[packages/api/session-controller/src/index.ts:229-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L229-L232)）
- `@Remote('selectModel')` 暴露会话级模型选择（[packages/api/session-controller/src/index.ts:239-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L239-L242)）
- `@Remote('modelCatalog')` 暴露可路由模型目录（[packages/api/session-controller/src/index.ts:248-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L248-L251)）
- `canOpenWorkspacePath` 把原生打开能力探测结果暴露给客户端（[packages/api/session-controller/src/index.ts:257-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L257-L260)）
- `openWorkspacePath` 拒绝空路径、先检查中止，调用原生打开器并把中止与失败分别映射为 `cancelled` 与 `internal`（[packages/api/session-controller/src/index.ts:270-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L270-L297)）
- `@Remote('rename')` 暴露会话改名（[packages/api/session-controller/src/index.ts:304-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L304-L307)）
- `@Remote('fork')` 暴露按完成轮前缀分叉（[packages/api/session-controller/src/index.ts:314-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L314-L317)）
- `@Remote('prompt')` 在委派前先检查调用方中止信号（[packages/api/session-controller/src/index.ts:325-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L325-L329)）
- `@Remote('attachment')` 暴露经授权的图片读取（[packages/api/session-controller/src/index.ts:336-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L336-L339)）
- `@Remote('updateQueue')` 暴露待发队列变更（[packages/api/session-controller/src/index.ts:346-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L346-L349)）
- `@Remote('cancel')` 暴露保留收件箱的当前轮取消（[packages/api/session-controller/src/index.ts:356-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L356-L359)）
- `@Remote('page')` 暴露冷读历史分页（[packages/api/session-controller/src/index.ts:367-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L367-L370)）
- `follow` 以 stream 模式暴露会话日志跟随（[packages/api/session-controller/src/index.ts:378-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L378-L381)）
- `control` 以 stream 模式暴露全局实时控制基线与增量帧（[packages/api/session-controller/src/index.ts:388-391](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L388-L391)）
- 默认导出服务类，使其可作为插件被加载器挂载（[packages/api/session-controller/src/index.ts:396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/index.ts#L396)）

### packages/api/session-controller/src/invariant.ts

包自有的不变量伴生插件，向不变量注册表登记本包名并给出空安装器。

- 安装器为空，并以注释声明本包不设运行期不变量检查（[packages/api/session-controller/src/invariant.ts:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/invariant.ts#L14-L15)）
- `apply` 向 `invariants` 注册本包名并返回注销函数（[packages/api/session-controller/src/invariant.ts:18-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/invariant.ts#L18-L19)）

### packages/api/session-controller/src/list.ts

主机侧冷安全的会话列表与搜索投影，注册列表元数据与图片限额两个投影，被 Session Controller 的 list/search 方法与会话新增事件使用。

- 冷会话空白探测默认上限 1024 字节（[packages/api/session-controller/src/list.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L23)）
- 冷摘要批量为 16、搜索提供方调用预算 100 次、查询串上限 500 字符、只认两类消息事件（[packages/api/session-controller/src/list.ts:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L25-L28)）
- `applySessionListMetadata` 逐事件推进：遇 `turn/start` 降下 blank，遇用户来源的 `user/message` 更新 lastPromptAt，无变化时返回原对象（[packages/api/session-controller/src/list.ts:50-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L50-L61)）
- `truncateUnicodeCodePoints` 按码点而非码元截断文本（[packages/api/session-controller/src/list.ts:69-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L69-L78)）
- 注入投影服务后注册 `sessionListMetadata` 投影，声明状态 schema、初值、推进函数、线上视图与 stateVersion（[packages/api/session-controller/src/list.ts:90-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L90-L99)）
- 注册 `imageLimits` 投影，状态恒为 null 而线上视图直接取附件服务的当前图片限额（[packages/api/session-controller/src/list.ts:100-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L100-L112)）
- `summaryFor` 组装行：updatedAt、running 由代理状态决定、blank 缺投影时回落到 `session.seq === 0`（[packages/api/session-controller/src/list.ts:120-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L120-L131)）
- `list` 对已附着会话直接摘要，冷会话中 header 无 cwd 者跳过不展示（[packages/api/session-controller/src/list.ts:138-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L138-L152)）
- 冷摘要按批并发执行，任一失败即上抛，最后按 updatedAt 倒序排序（[packages/api/session-controller/src/list.ts:153-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L153-L162)）
- `summarizeCold` 缓存已判定非空白则直接用缓存，否则尝试小体积冷探测；期间会话被附着则改走活会话摘要；仍未知时 blank 记为 false 以保持可见（[packages/api/session-controller/src/list.ts:165-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L165-L185)）
- `probeSmallCold` 在上限为 0、无持久化定位或文件超过上限时放弃探测（[packages/api/session-controller/src/list.ts:191-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L191-L201)）
- 探测走完整投影观测，失败时记 warn 并把该行按可见处理（[packages/api/session-controller/src/list.ts:202-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L202-L217)）
- `search` 先归一化查询串，未挂载会话查询服务时以 `internal` 拒绝（[packages/api/session-controller/src/list.ts:227-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L227-L236)）
- 先取可见会话 id 集合，为空直接返回空结果（[packages/api/session-controller/src/list.ts:238-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L238-L243)）
- 翻页循环受 100 次提供方调用预算硬限制，超出即抛错（[packages/api/session-controller/src/list.ts:250-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L250-L255)）
- 搜索请求固定带上事件类型过滤与 `current` 表面过滤（[packages/api/session-controller/src/list.ts:260-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L260-L268)）
- 首页遇 `SESSION_QUERY_INVALID_LIMIT` 时把页大小折半重试（[packages/api/session-controller/src/list.ts:271-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L271-L278)）
- 续页遇 `SESSION_QUERY_STALE_CURSOR` 时清空已收结果与游标从头重来（[packages/api/session-controller/src/list.ts:279-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L279-L287)）
- 提供方返回条数超过请求上限时抛错（[packages/api/session-controller/src/list.ts:290-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L290-L292)）
- 命中需同时满足会话可见、bestMatch 属同一会话、表面为 current、类型在两类消息内且该会话未收录过，摘要按码点上限截断（[packages/api/session-controller/src/list.ts:293-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L293-L305)）
- 续页游标重复出现时抛错（[packages/api/session-controller/src/list.ts:306-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L306-L311)）
- 结果按上限切片，多出的那一条只用来置 hasMore（[packages/api/session-controller/src/list.ts:312-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L312-L318)）
- 搜索异常按中止转 `cancelled`、其余转 `internal`（[packages/api/session-controller/src/list.ts:319-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L319-L325)）
- `projectionsFor` 按冷热分别读投影缓存或活会话缓存，空值块视为无，读取抛错时记 warn 并返回不带投影的行（[packages/api/session-controller/src/list.ts:328-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L328-L350)）
- `normalizeSearchQuery` 去空白后拒绝空串、超长串与含 NUL 的串（[packages/api/session-controller/src/list.ts:353-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L353-L369)）
- `updatedAt` 取创建时间与最后提示时间的较大者（[packages/api/session-controller/src/list.ts:375-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L375-L377)）
- `listFields` 仅在 header 存在对应字段时才把 parentSessionId、origin、cwd 放入行（[packages/api/session-controller/src/list.ts:379-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/list.ts#L379-L389)）

### packages/api/session-controller/src/model-selection-projection.ts

模型选择的持久投影定义与注册，被 Session Controller 构造时安装。

- `applyModelSelectionProjection` 遇 `model/selection` 事件把选择写入 pending，相同则不产生新状态（[packages/api/session-controller/src/model-selection-projection.ts:39-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/model-selection-projection.ts#L39-L43)）
- 遇 `request/header` 事件把请求实际配置记为 lastUsed，并在与 pending 相同时清空 pending；其余事件不改变状态（[packages/api/session-controller/src/model-selection-projection.ts:44-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/model-selection-projection.ts#L44-L56)）
- 投影定义给出 key、状态 schema、初值、推进函数与 stateVersion 2（[packages/api/session-controller/src/model-selection-projection.ts:58-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/model-selection-projection.ts#L58-L68)）
- 线上视图把 next 定义为「pending 优先，否则回落 lastUsed」（[packages/api/session-controller/src/model-selection-projection.ts:63-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/model-selection-projection.ts#L63-L66)）
- `sameSelection` 按 provider、model、reasoningEffort 三字段判等（[packages/api/session-controller/src/model-selection-projection.ts:70-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/model-selection-projection.ts#L70-L75)）
- `installModelSelectionProjection` 把该定义注册进会话投影注册表（[packages/api/session-controller/src/model-selection-projection.ts:81-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/model-selection-projection.ts#L81-L83)）

### packages/api/session-controller/src/remote-events.ts

声明本包哪些主机事件经远端事件载体原样转发给客户端。

- 列出被转发的五个事件名：活动、新增、错误、移除、状态（[packages/api/session-controller/src/remote-events.ts:2-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/remote-events.ts#L2-L8)）

### packages/api/session-controller/src/skill-catalog.ts

主机侧 `skills` 远端命名空间的服务，在不唤醒冷代理的前提下列出某会话可见的人类可调用技能，由 Session Controller 挂载。

- 以 `skills` 命名空间注册远端服务并声明对 agents、sessionQuery、typert 的注入（[packages/api/session-controller/src/skill-catalog.ts:21-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/skill-catalog.ts#L21-L26)）
- `list` 通过会话观测取 cwd 与已记录的 agentPreset，观测缺投影时抛错（[packages/api/session-controller/src/skill-catalog.ts:41-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/skill-catalog.ts#L41-L47)）
- 会话未找到转 `session-not-found`，其余检视失败转 `internal`（[packages/api/session-controller/src/skill-catalog.ts:48-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/skill-catalog.ts#L48-L61)）
- 无 cwd 的会话以 `internal` 拒绝（[packages/api/session-controller/src/skill-catalog.ts:62-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/skill-catalog.ts#L62-L64)）
- 会话有活代理时优先取预设作用域内的技能注册表，否则回落全局注册表；两者都无则以 `internal` 拒绝（[packages/api/session-controller/src/skill-catalog.ts:66-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/skill-catalog.ts#L66-L75)）
- 按 cwd 与作用域列出技能后只保留人类可调用者，并映射为 name、description、可选 whenToUse 与 modelInvocable（[packages/api/session-controller/src/skill-catalog.ts:77-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/skill-catalog.ts#L77-L90)）
- `scopeFor` 有活代理时用代理本身作作用域，否则用记录的预设求常驻作用域键，失败则回落全局（[packages/api/session-controller/src/skill-catalog.ts:94-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/skill-catalog.ts#L94-L108)）
- `failure` 统一构造带 code、message 与可选 sessionId 细节的远端失败（[packages/api/session-controller/src/skill-catalog.ts:112-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/skill-catalog.ts#L112-L118)）
- 默认导出该服务类，使其可作为插件被挂载（[packages/api/session-controller/src/skill-catalog.ts:120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/skill-catalog.ts#L120)）

### packages/api/session-controller/src/types.ts

会话远端服务的浏览器安全请求/结果/生命周期类型声明，包含投影映射、事件映射与错误词表的声明合并，被主机与客户端两侧共用。

- 常量 `SESSION_SEARCH_RESULT_LIMIT = 20` 限定一次搜索返回的会话条数（[packages/api/session-controller/src/types.ts:172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/types.ts#L172)）
- 常量 `SESSION_SEARCH_SNIPPET_MAX_CODE_POINTS = 240` 限定搜索摘要的码点长度（[packages/api/session-controller/src/types.ts:175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/src/types.ts#L175)）

### packages/api/session-controller/tsconfig.json

本包的仅引用式 TypeScript 根配置，指向主机与客户端两个编译面。

- 无运行期机制

### packages/api/session-controller/tsdown.config.ts

本包的打包配置，声明产物入口与是否包含主机阶段。

- 以 `lib/types/index.js` 与 `lib/types/invariant.js` 为打包入口并开启主机阶段，决定本包对外可加载的运行时入口（[packages/api/session-controller/tsdown.config.ts:3-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/session-controller/tsdown.config.ts#L3-L7)）
