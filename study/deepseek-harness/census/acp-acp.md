---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/acp/acp
---

# packages/acp/acp

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、175 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/acp/acp/README.md

该包的英文说明文档，描述这个 ACP 服务器包的用途、配置字段、协议调用表与实现分工，供阅读者使用。

- 无运行期机制

### packages/acp/acp/package.json

该包的 npm 清单，声明包名、模块类型、入口映射、发布文件与依赖关系。

- 声明 `"type": "module"` 并把 `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定运行期加载的入口文件（[packages/acp/acp/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant`、`./src/*` 与 `package.json` 四个子路径，其余子路径无法被外部 import（[packages/acp/acp/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/acp/acp/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/package.json#L28-L32)）
- `peerDependenciesMeta` 把 token-meter 标为可选依赖，允许运行期缺席（[packages/acp/acp/package.json:50-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/package.json#L50-L54)）

### packages/acp/acp/src/codec.ts

把内部回合结束原因翻译成 ACP 协议终止原因的纯函数模块，被 session.ts 的结算路径调用。

- `completed` 映射为 `end_turn`、`max-tokens` 映射为 `max_tokens`（[packages/acp/acp/src/codec.ts:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/codec.ts#L15-L19)）
- `aborted` 映射为 `end_turn`，不占用 `cancelled`（[packages/acp/acp/src/codec.ts:23-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/codec.ts#L23-L24)）
- `interrupted` 映射为 `cancelled`（[packages/acp/acp/src/codec.ts:25-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/codec.ts#L25-L26)）
- `blocked` 与 `error` 都映射为 `end_turn`，未知取值兜底同样为 `end_turn`（[packages/acp/acp/src/codec.ts:27-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/codec.ts#L27-L32)）

### packages/acp/acp/src/content.ts

ACP 线上内容的准入与投射模块：把客户端 prompt 块转成内部内容块，把已提交的助手块转回 ACP 内容，被 index.ts、session.ts 和 updates.ts 使用。

- 用固定的四种栅格 MIME 常量限定可接受的图片类型（[packages/acp/acp/src/content.ts:11-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L11-L16)）
- 用不含空白与 URL-safe 别名的正则定义规范 base64（[packages/acp/acp/src/content.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L19)）
- `AcpContentError` 携带 `invalid`/`internal` 两类失败类别，决定上层回给客户端的错误种类（[packages/acp/acp/src/content.ts:22-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L22-L39)）
- `decodeImage` 对不在白名单的 mimeType 直接拒绝（[packages/acp/acp/src/content.ts:47-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L47-L51)）
- 先用正则、再用解码后重新编码比对，两道检查拒绝非规范 base64（[packages/acp/acp/src/content.ts:52-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L52-L59)）
- `assertImageRoute` 在 provider、model 或 llm 服务缺失时拒绝图片输入（[packages/acp/acp/src/content.ts:63-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L63-L69)）
- 解析模型信息抛错时转成 `internal` 类失败并保留 cause（[packages/acp/acp/src/content.ts:70-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L70-L75)）
- 模型未声明 image 输入模态时拒绝图片（[packages/acp/acp/src/content.ts:76-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L76-L78)）
- `supportsAcpImagePrompts` 在附件服务、llm 服务、provider、model 任一缺失时返回 false（[packages/acp/acp/src/content.ts:94-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L94-L96)）
- 附件存储支持的媒体类型与栅格白名单无交集时返回 false（[packages/acp/acp/src/content.ts:97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L97)）
- 按配置路由解析模型信息决定是否宣告图片能力，解析抛错一律按 false 处理（[packages/acp/acp/src/content.ts:98-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L98-L103)）
- `resource_link` 块被渲染成前后带换行的 `[resource_link name=… uri=…]` 文本进入模型可见内容（[packages/acp/acp/src/content.ts:106-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L106-L109)）
- 准入先对整批 prompt 做一遍校验：未宣告图片能力时拒绝 image 块（[packages/acp/acp/src/content.ts:131-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L131-L138)）
- audio、embedded resource 与未知块类型一律拒绝（[packages/acp/acp/src/content.ts:140-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L140-L147)）
- 有图片时要求已挂载附件存储，并在写入前做路由校验（[packages/acp/acp/src/content.ts:150-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L150-L154)）
- 图片批量落盘前后各检查一次取消信号（[packages/acp/acp/src/content.ts:155-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L155-L165)）
- 落盘失败按是否为图片准入错误分别转成 `invalid` 或 `internal`（[packages/acp/acp/src/content.ts:158-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L158-L163)）
- 重建阶段把相邻文本累积成一个文本块，遇到图片先冲刷文本再按线序插入持久附件引用（[packages/acp/acp/src/content.ts:167-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L167-L198)）
- 既无图片也无非空白文本时拒绝整条 prompt（[packages/acp/acp/src/content.ts:200-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L200-L202)）
- `assistantBlockToAcp` 丢弃空文本块与非文本非图片块，使其不进入线上更新（[packages/acp/acp/src/content.ts:218-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L218-L221)）
- 投射助手图片时要求附件存储存在，缺失即报 `internal`（[packages/acp/acp/src/content.ts:222-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L222-L225)）
- 重新读取附件，读取失败转成 `internal` 失败而非发出占位内容（[packages/acp/acp/src/content.ts:226-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L226-L231)）
- 读回的字节以 base64 内联，MIME 取自存储记录（[packages/acp/acp/src/content.ts:232-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/content.ts#L232-L236)）

### packages/acp/acp/src/index.ts

插件入口：定义配置 schema、接线 JSON-RPC 连接与方法表、维护每会话记录、路由运行期事件、并负责整体拆除。

- 导出插件名与 `inject` 依赖列表，决定该插件在哪些服务就绪后才挂载（[packages/acp/acp/src/index.ts:59-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L59-L61)）
- 两个包装器把详情写进 `invalid params` 与 `internal error` 的线上错误消息（[packages/acp/acp/src/index.ts:63-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L63-L71)）
- `Config` 校验 provider/model 为字符串、`sessionListPageSize` 为不小于 1 的自然数并默认 100（[packages/acp/acp/src/index.ts:85-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L85-L89)）
- 在 apply 阶段就取出持久化服务，避免处理器在注入作用域外惰性读取（[packages/acp/acp/src/index.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L96-L101)）
- 用会话表、激活中集合、closed 标志与图片能力标志承载连接级状态（[packages/acp/acp/src/index.ts:102-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L102-L105)）
- `ownedRecord` 以对象身份比对拒绝同 id 的冒名 Agent（[packages/acp/acp/src/index.ts:107-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L107-L111)）
- 桥已拆除后所有请求直接抛内部错误（[packages/acp/acp/src/index.ts:113-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L113-L115)）
- 未知会话 id 以 `invalid params` 拒绝（[packages/acp/acp/src/index.ts:117-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L117-L121)）
- `notify` 发出 `session/update` 通知，传输失败只记日志不外抛（[packages/acp/acp/src/index.ts:123-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L123-L132)）
- 监听 `session/event`，只把归属本连接的会话事件交给对应记录（[packages/acp/acp/src/index.ts:134-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L134-L137)）
- 监听 `agent/inbox/claimed`，把消息与回合号交给拥有该 Agent 的记录（[packages/acp/acp/src/index.ts:139-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L139-L141)）
- 监听 `agent/error`，把回合失败交给对应记录（[packages/acp/acp/src/index.ts:143-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L143-L145)）
- 监听 `llm/adapters-updated`，触发所有活跃会话重新发布配置选项（[packages/acp/acp/src/index.ts:147-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L147-L149)）
- 审批瀑布监听器对非本桥 Agent 或无 callId 的请求调用 `next()` 放行给后续处理者（[packages/acp/acp/src/index.ts:154-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L154-L157)）
- 审批请求先排空已排队更新，再向客户端发出只含一次性允许/拒绝两个选项的权限请求（[packages/acp/acp/src/index.ts:158-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L158-L167)）
- 客户端应答被映射为 `cancelled`、`allowed-once` 或 `rejected` 三种结果（[packages/acp/acp/src/index.ts:168-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L168-L171)）
- `initialize` 在握手时计算并缓存本连接的图片准入能力（[packages/acp/acp/src/index.ts:175-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L175-L178)）
- `initialize` 回报协议版本、服务端标识，并宣告 http MCP、图片按实测开关、audio 与 embeddedContext 为假、close/list/resume 会话能力、空鉴权方法表（[packages/acp/acp/src/index.ts:179-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L179-L188)）
- `authenticate` 无条件立即成功（[packages/acp/acp/src/index.ts:191-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L191-L193)）
- `session/new` 先校验工作区参数，再生成随机 UUID 作为会话 id（[packages/acp/acp/src/index.ts:195-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L195-L198)）
- 组装会话时把 MCP 声明错误转成 `invalid params`，其余错误原样抛出（[packages/acp/acp/src/index.ts:204-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L204-L217)）
- 组装期间连接已关闭则关掉刚建的会话并报错，不写入会话表（[packages/acp/acp/src/index.ts:218-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L218-L222)）
- 登记会话后取配置选项并让持久化物化会话，任一步失败即回滚删除并关闭（[packages/acp/acp/src/index.ts:223-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L223-L234)）
- `session/resume` 拒绝已在本桥登记、正在激活或已在运行的会话 id（[packages/acp/acp/src/index.ts:240-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L240-L243)）
- 用 `activating` 集合在整个恢复过程中占位，并在结束时清除（[packages/acp/acp/src/index.ts:244-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L244-L245)）
- 只允许恢复持久化里存在、非子代理来源、且无父会话的会话（[packages/acp/acp/src/index.ts:246-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L246-L249)）
- 恢复前比对持久化 cwd 与请求 cwd，不一致即拒绝（[packages/acp/acp/src/index.ts:250-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L250-L252)）
- 恢复完成后再次比对实际会话头的 cwd，不一致就关闭并拒绝（[packages/acp/acp/src/index.ts:268-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L268-L273)）
- 恢复过程遇到连接关闭或选项发现失败时关闭会话并回滚登记（[packages/acp/acp/src/index.ts:274-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L274-L287)）
- `session/list` 要求过滤用 cwd 为绝对路径（[packages/acp/acp/src/index.ts:290-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L290-L294)）
- 游标解码失败转成 `invalid params`（[packages/acp/acp/src/index.ts:295-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L295-L300)）
- 列表过滤掉本桥活跃、正在激活、进程内已存在、子代理来源、有父会话、以及 cwd 缺失或非绝对的条目（[packages/acp/acp/src/index.ts:301-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L301-L314)）
- 结果按创建时间倒序、同刻按会话 id 字节序排序（[packages/acp/acp/src/index.ts:317-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L317-L319)）
- 按游标裁掉已返回部分、按配置页大小切片，并只在仍有剩余时给出 `nextCursor`（[packages/acp/acp/src/index.ts:320-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L320-L328)）
- `session/set_config_option` 把模型配置错误转成 `invalid params` 并回全量选项状态（[packages/acp/acp/src/index.ts:331-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L331-L343)）
- `session/close` 失败时抛内部错误，且无论成败都把该记录从会话表移除（[packages/acp/acp/src/index.ts:345-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L345-L357)）
- `session/prompt` 把连接级图片能力标志与请求取消信号一并交给会话模块（[packages/acp/acp/src/index.ts:359-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L359-L363)）
- 取消通知对未知会话 id 是无操作（[packages/acp/acp/src/index.ts:365-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L365-L368)）
- 传输默认走 stdout/stdin 的 ND-JSON 流，可被配置里的 stream 覆盖（[packages/acp/acp/src/index.ts:371-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L371-L375)）
- 方法表把 initialize、authenticate、session 的 new/list/resume/close/setConfigOption/prompt 请求与 cancel 通知逐一绑定到实现（[packages/acp/acp/src/index.ts:376-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L376-L388)）
- 连接建立后取客户端句柄，供通知与权限请求反向调用（[packages/acp/acp/src/index.ts:389-390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L389-L390)）
- `quiesce` 记忆化：先置 closed 阻断新请求，再并行关闭全部会话记录（[packages/acp/acp/src/index.ts:392-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L392-L401)）
- 拆除后逐一从会话表移除记录，并把各会话失败合成一个带完整错误链文本的 AggregateError（[packages/acp/acp/src/index.ts:402-419](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L402-L419)）
- 连接关闭（含异常关闭）会触发同一套拆除流程（[packages/acp/acp/src/index.ts:423-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L423-L432)）
- 通过 `ctx.effect` 把拆除挂到插件卸载上（[packages/acp/acp/src/index.ts:434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L434)）
- `agentOptions` 只透传实际配置了的 provider/model 字段，不写入缺省键（[packages/acp/acp/src/index.ts:442-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L442-L447)）
- 只有 provider 与 model 同时存在时才形成初始路由选择（[packages/acp/acp/src/index.ts:450-454](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L450-L454)）
- 页大小取配置值或默认 100，非正安全整数直接抛错（[packages/acp/acp/src/index.ts:461-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L461-L470)）
- 游标解码校验字符集、base64url 解出的二元组类型与取值范围，并要求重新编码后与原串逐字相等（[packages/acp/acp/src/index.ts:472-495](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L472-L495)）
- 游标编码把 `[createdAt, sessionId]` 序列化成 base64url 串（[packages/acp/acp/src/index.ts:497-500](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L497-L500)）
- 游标比较按创建时间更早、或同刻且 id 字节序更大来判定「在游标之后」（[packages/acp/acp/src/index.ts:502-506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L502-L506)）
- 会话 id 用 UTF-8 字节比较，排序结果不随进程 locale 变化（[packages/acp/acp/src/index.ts:508-511](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L508-L511)）
- 工作区校验要求 cwd 为绝对路径，并拒绝任何非空 `additionalDirectories`（[packages/acp/acp/src/index.ts:513-523](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L513-L523)）
- 目录比较优先用 `realpath` 物理身份，解析失败时退化为 `resolve` 后的字面比较（[packages/acp/acp/src/index.ts:525-534](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/index.ts#L525-L534)）

### packages/acp/acp/src/invariant.ts

该包的不变量伴生插件，向不变量服务登记本包并声明它不安装任何运行期检查。

- 声明伴生插件名与对 `invariants` 服务的注入依赖（[packages/acp/acp/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/invariant.ts#L12-L15)）
- installer 为空函数，运行期不注册任何检查（[packages/acp/acp/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/invariant.ts#L21)）
- apply 用包名注册该 installer 并把注册返回的 disposer 交给宿主（[packages/acp/acp/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/invariant.ts#L28-L29)）

### packages/acp/acp/src/mcp.ts

把 ACP 协议里的 MCP 服务器声明校验并翻译成 Agent 作用域内的 MCP 客户端插件配置，被 session.ts 在 Agent 发布前调用。

- 用 `^[A-Za-z0-9_-]{1,32}$` 定义可直接使用的服务器名（[packages/acp/acp/src/mcp.ts:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L10)）
- `AcpMcpConfigError` 标记可由调用方纠正的声明错误，供上层转成 `invalid params`（[packages/acp/acp/src/mcp.ts:12-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L12-L18)）
- 先把整份服务器列表解析成配置，再逐个挂载 MCP 客户端插件到未发布的 Agent 作用域（[packages/acp/acp/src/mcp.ts:26-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L26-L33)）
- 归一化后重名的服务器被拒绝（[packages/acp/acp/src/mcp.ts:37-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L37-L43)）
- stdio 声明要求 command 是绝对路径（[packages/acp/acp/src/mcp.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L44-L47)）
- stdio 客户端以会话 cwd 为工作目录、启用 `failOnStartupError`，并把环境变量原样写回配置（[packages/acp/acp/src/mcp.ts:48-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L48-L59)）
- http 声明走 streamable-http 传输，校验 URL 与请求头并同样启用 `failOnStartupError`（[packages/acp/acp/src/mcp.ts:60-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L60-L70)）
- 其余传输类型一律拒绝（[packages/acp/acp/src/mcp.ts:72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L72)）
- 名值对转记录时使用 null 原型对象，使 `__proto__` 这类键落为数据（[packages/acp/acp/src/mcp.ts:82-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L82-L84)）
- 请求头逐条走标准的头名与头值校验，不合法即拒绝（[packages/acp/acp/src/mcp.ts:86-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L86-L93)）
- 环境变量名不得为空、不得含 `=` 或 NUL，值不得含 NUL（[packages/acp/acp/src/mcp.ts:94-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L94-L101)）
- 请求头按小写、环境变量按原名去重，重复即拒绝（[packages/acp/acp/src/mcp.ts:102-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L102-L106)）
- 服务器名为空白或含控制字符时拒绝（[packages/acp/acp/src/mcp.ts:111-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L111-L114)）
- 不合规名字经 NFKD 归一、非法字符替换、截断 20 字符后拼接 sha256 前 8 位，整体截到 32 字符作为工具命名空间（[packages/acp/acp/src/mcp.ts:115-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L115-L121)）
- HTTP URL 必须能解析且协议为 http 或 https（[packages/acp/acp/src/mcp.ts:124-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L124-L132)）
- MCP 客户端 schema 校验错误被包成带下标与详情的声明错误（[packages/acp/acp/src/mcp.ts:134-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/mcp.ts#L134-L143)）

### packages/acp/acp/src/model-control.ts

把一个 Agent 的 provider/model/推理强度选择投射成 ACP 配置选项，并处理选项变更与回合内路由固定，被 session.ts 持有。

- 固定 `model` 与 `reasoning_effort` 两个选项 id，并用空串表示「provider 默认」推理强度（[packages/acp/acp/src/model-control.ts:8-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L8-L11)）
- `AcpModelConfigError` 标记可由调用方纠正的配置失败（[packages/acp/acp/src/model-control.ts:23-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L23-L29)）
- 暴露给请求装配的选择引用在读取时优先返回回合固定值，写入只改会话级选择（[packages/acp/acp/src/model-control.ts:41-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L41-L52)）
- `install` 把该选择引用装进未发布的 Agent 作用域，使模型请求走此路由（[packages/acp/acp/src/model-control.ts:54-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L54-L60)）
- `snapshot` 返回当前选择的浅拷贝，与后续变更脱钩（[packages/acp/acp/src/model-control.ts:62-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L62-L68)）
- `pinTurn` 把某一回合的路由钉死为准入时的快照（[packages/acp/acp/src/model-control.ts:70-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L70-L77)）
- `releaseTurn` 只在回合号完全匹配时解除钉死（[packages/acp/acp/src/model-control.ts:79-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L79-L85)）
- 读取选项与设置选项都进同一条串行队列（[packages/acp/acp/src/model-control.ts:87-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L87-L94)）
- `set` 拒绝非字符串取值，并在会话没有任何模型选择时拒绝（[packages/acp/acp/src/model-control.ts:104-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L104-L107)）
- 设置 `model` 时只接受当前选项状态里出现过的值，并先解析校验路由再落定（[packages/acp/acp/src/model-control.ts:108-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L108-L113)）
- 设置 `reasoning_effort` 时按精确模型的声明校验：模型不支持推理、或取值既不是合法 effort 也不是可用的 provider 默认，则拒绝（[packages/acp/acp/src/model-control.ts:114-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L114-L123)）
- provider 默认取值落定为不带 `reasoningEffort` 字段的选择，否则带上该 id（[packages/acp/acp/src/model-control.ts:124-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L124-L128)）
- 未知选项 id 被拒绝，成功后返回变更后的全量选项状态（[packages/acp/acp/src/model-control.ts:129-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L129-L133)）
- 串行队列在某次操作被拒后用双吞噬处理器续接，不会卡死后续操作（[packages/acp/acp/src/model-control.ts:136-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L136-L141)）
- 没有任何选择时返回空选项集（[packages/acp/acp/src/model-control.ts:144-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L144-L147)）
- 路由解析失败时：若从未成功解析过就外抛，否则沿用已选路由并标记路由不可用（[packages/acp/acp/src/model-control.ts:148-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L148-L156)）
- 遍历所有 provider 列模型构成分组选项，单个 provider 目录不可用时该组退化为空（[packages/acp/acp/src/model-control.ts:157-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L157-L177)）
- 当前路由若不在目录中，就补进选择表并插到对应分组首位，必要时新建该分组（[packages/acp/acp/src/model-control.ts:178-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L178-L187)）
- 模型选项以当前路由为 `currentValue`，且只列出非空分组（[packages/acp/acp/src/model-control.ts:188-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L188-L195)）
- 只有路由可用且该精确模型声明了推理能力时才追加推理强度选项（[packages/acp/acp/src/model-control.ts:196-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L196-L199)）
- 推理选项的当前值在未选时取空串，且仅当 provider 未给默认强度时才提供「Provider default」条目（[packages/acp/acp/src/model-control.ts:200-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L200-L219)）
- 路由解析结果只保留 provider、model 与存在的 reasoningEffort 三个字段（[packages/acp/acp/src/model-control.ts:223-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L223-L231)）
- 选项值用 `[provider, model]` 的 JSON 串作为不透明标识（[packages/acp/acp/src/model-control.ts:234-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/model-control.ts#L234-L237)）

### packages/acp/acp/src/session.ts

单个 ACP 会话的模块：拥有 Agent 组装、路由选择、单个在飞 prompt 槽位、有序更新链与一次性拆除，由 index.ts 每会话创建一个。

- 恢复时优先用会话日志里记录的路由，且当该强度来自适配器默认时不还原 `reasoningEffort`，无日志则回落到部署配置（[packages/acp/acp/src/session.ts:74-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L74-L91)）
- 以 `outputTail` 串行链、单个 `inflight` 槽、`closing` 记忆化与待钉路由表承载会话状态（[packages/acp/acp/src/session.ts:99-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L99-L118)）
- `create` 在 Agent 发布前的 setup 里装入模型选择并挂载全部 MCP 服务器，任一失败都使 Agent 不被发布（[packages/acp/acp/src/session.ts:126-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L126-L139)）
- `resume` 在 setup 里读取恢复出的会话请求头来构造模型选择，并同样在发布前挂载 MCP（[packages/acp/acp/src/session.ts:147-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L147-L164)）
- 恢复后若模型选择未组装成功则释放 Agent 句柄并报内部错误（[packages/acp/acp/src/session.ts:165-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L165-L171)）
- `owns` 与 `ownsSession` 用对象身份判定事件归属（[packages/acp/acp/src/session.ts:174-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L174-L190)）
- 读取与设置配置选项前都断言会话未进入关闭流程（[packages/acp/acp/src/session.ts:192-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L192-L212)）
- 拓扑变化时先在链外解析选项，再把 `config_option_update` 通知串到输出链尾，且关闭中直接跳过（[packages/acp/acp/src/session.ts:214-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L214-L237)）
- 同一会话已有在飞 prompt 时新 prompt 被 `invalid params` 拒绝（[packages/acp/acp/src/session.ts:251-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L251-L252)）
- 建立在飞记录，含完成/准入两组 promise、准入取消控制器与各类失败槽（[packages/acp/acp/src/session.ts:253-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L253-L271)）
- 把 JSON-RPC 请求的取消信号接到 prompt 取消上，且对已中止的信号立即触发（[packages/acp/acp/src/session.ts:272-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L272-L275)）
- 准入开始前先快照当前路由选择（[packages/acp/acp/src/session.ts:278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L278)）
- 在内容准入前后各校验一次 Agent 身份是否仍是本模块拥有的那个（[packages/acp/acp/src/session.ts:280-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L280-L293)）
- 准入完成后再检查一次取消信号，然后才用准入内容构造用户消息（[packages/acp/acp/src/session.ts:290-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L290-L298)）
- 先按消息 id 登记待钉路由再投递 followup，投递抛错时回滚登记与已排队标记（[packages/acp/acp/src/session.ts:300-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L300-L307)）
- 无论准入成败都在 finally 里结束准入阶段，解除等待准入的一方（[packages/acp/acp/src/session.ts:308-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L308-L312)）
- 若取消先于准入完成生效，则走结算路径返回停止原因而不抛错（[packages/acp/acp/src/session.ts:314-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L314-L317)）
- 准入失败时清空在飞槽，并按内容错误类别、既有协议错误、其他错误三种情况分别抛出（[packages/acp/acp/src/session.ts:318-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L318-L327)）
- 正常路径在 Agent 静默后结算并返回停止原因，最后摘除取消监听（[packages/acp/acp/src/session.ts:329-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L329-L333)）
- `cancel` 在没有在飞 prompt 时改为取消 Agent 的自主工作（[packages/acp/acp/src/session.ts:336-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L336-L341)）
- 助手消息事件按顺序串进输出链逐条投递，投递失败记入该 prompt 的输出错误槽并写日志（[packages/acp/acp/src/session.ts:350-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L350-L362)）
- 工具调用事件串进同一条输出链，投递失败只记日志（[packages/acp/acp/src/session.ts:363-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L363-L371)）
- 工具结果事件同样串行投递，转换或投递失败被吞并记日志，不影响 Agent 工作（[packages/acp/acp/src/session.ts:372-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L372-L384)）
- 回合结束事件把结束原因记到匹配回合的在飞 prompt 上（[packages/acp/acp/src/session.ts:385-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L385-L389)）
- 任何回合结束都解除该回合的路由钉死（[packages/acp/acp/src/session.ts:390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L390)）
- 收件箱认领事件把消息 id 对应到回合号，并把待钉路由钉到该回合（[packages/acp/acp/src/session.ts:394-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L394-L404)）
- Agent 失败事件在没有已排队消息时忽略，与在飞回合同号时也忽略（交由该回合的结束原因结算）（[packages/acp/acp/src/session.ts:411-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L411-L416)）
- 回合区间外的 Agent 失败被记入失败槽并立即触发结算（[packages/acp/acp/src/session.ts:417-419](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L417-L419)）
- `drainUpdates` 返回当前输出链尾，供审批前排空已排队更新（[packages/acp/acp/src/session.ts:421-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L421-L424)）
- `close` 记忆化为一次拆除：先取消在飞 prompt，未排队消息时直接取消 Agent（[packages/acp/acp/src/session.ts:426-437](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L426-L437)）
- 依次等待准入结束、Agent 静默、输出链排空，失败并入失败列表（[packages/acp/acp/src/session.ts:438-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L438-L444)）
- 通过可选的子代理服务自下而上拆除可继续的后代，失败记日志并计入失败列表（[packages/acp/acp/src/session.ts:445-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L445-L451)）
- 拆除中把会话持久化刷盘（[packages/acp/acp/src/session.ts:452-456](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L452-L456)）
- 最后释放 Agent 作用域、清空待钉路由表，并按失败个数抛单个错误或 AggregateError（[packages/acp/acp/src/session.ts:457-468](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L457-L468)）
- 关闭中会话对新请求以 `invalid params` 拒绝（[packages/acp/acp/src/session.ts:473-475](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L473-L475)）
- 取消 prompt 时置取消标记、中止准入控制器、触发结算，并在消息已排队时取消 Agent（[packages/acp/acp/src/session.ts:477-484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L477-L484)）
- 结算只跑一次，且在消息已排队时先等 Agent 静默与输出链排空（[packages/acp/acp/src/session.ts:486-494](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L486-L494)）
- 结算优先级依次为：显式取消返回 `cancelled`、输出投递失败拒绝、回合区间失败拒绝、无结束原因返回 `cancelled`、结束原因为 error 时拒绝、其余按停止原因映射返回（[packages/acp/acp/src/session.ts:495-517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L495-L517)）
- 结算流程自身抛错时清空槽位并以内部错误拒绝该 prompt（[packages/acp/acp/src/session.ts:519-525](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/session.ts#L519-L525)）

### packages/acp/acp/src/updates.ts

把已提交的会话事件投射成标准 ACP 会话更新的模块，被 session.ts 的输出链调用。

- 推理块投射为 `agent_thought_chunk`，空文本的推理块被跳过（[packages/acp/acp/src/updates.ts:22-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/updates.ts#L22-L32)）
- 其余块经内容转换后按块序投射为 `agent_message_chunk`，转换返回空的块不进入线上（[packages/acp/acp/src/updates.ts:33-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/updates.ts#L33-L41)）
- 助手消息的更新序列末尾追加上下文占用更新（存在时）（[packages/acp/acp/src/updates.ts:42-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/updates.ts#L42-L44)）
- 工具调用事件投射成 `tool_call`：标题取工具名、kind 固定为 `other`、状态为 `in_progress`、rawInput 为解析后的参数（[packages/acp/acp/src/updates.ts:52-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/updates.ts#L52-L61)）
- 工具结果事件投射成 `tool_call_update`，按 `isError` 决定状态为 failed 或 completed，并逐块转换补充内容（[packages/acp/acp/src/updates.ts:69-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/updates.ts#L69-L85)）
- 仅当事件带 usage、会话有上下文窗口且已挂载计量服务时才发出 `usage_update`（[packages/acp/acp/src/updates.ts:87-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/updates.ts#L87-L102)）
- 工具参数 JSON 解析失败时保留原始字符串，而不是丢弃这条调用更新（[packages/acp/acp/src/updates.ts:104-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/acp/acp/src/updates.ts#L104-L111)）

### packages/acp/acp/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、类型输出目录与工作区项目引用。

- 无运行期机制
