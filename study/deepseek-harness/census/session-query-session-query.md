---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session-query/session-query
---

# packages/session-query/session-query

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、111 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session-query/session-query/README.md

该包的英文 README，介绍会话历史查询服务的调用面、过滤器语义、两个配置项与失败码取值，并链接到实现文件与后端包。

- 无运行期机制

### packages/session-query/session-query/package.json

该包的 npm 清单，声明模块类型、入口、导出子路径、发布文件集与对等依赖。

- 声明 `type: module` 并把包入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/session-query/session-query/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant`、`./src/*` 与 `./package.json` 四个可被外部 import 的子路径（[packages/session-query/session-query/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的声明文件（[packages/session-query/session-query/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/package.json#L28-L32)）
- `peerDependenciesMeta` 把持久化、投影与投影缓存三个对等依赖标为可选，允许安装后这些服务缺席（[packages/session-query/session-query/package.json:46-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/package.json#L46-L56)）

### packages/session-query/session-query/src/config.ts

定义该服务的两个默认常量、配置字段与封闭的失败码类型，并导出带窄化 `code` 的错误类。

- 导出读取窗口上限默认值 `50`（[packages/session-query/session-query/src/config.ts:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/config.ts#L6)）
- 导出批量读取时并发检视持久化日志的默认上限 `4`（[packages/session-query/session-query/src/config.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/config.ts#L9)）
- `SessionQueryError` 继承基础错误类并把构造参数中的 `code` 原样传给基类，使抛出的失败带上稳定机器可读码（[packages/session-query/session-query/src/config.ts:40-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/config.ts#L40-L48)）

### packages/session-query/session-query/src/corpus.ts

实现"活动会话优先、持久化补齐"的逻辑语料解析，为服务的各类精确读取提供已脱离的头部与事件日志。

- 构造时用 `ctx.inject(['sessionPersistence'])` 建立子纤程，把当前挂载的持久化服务记入字段，并在该纤程释放时清空它（[packages/session-query/session-query/src/corpus.ts:40-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L40-L47)）
- 在父上下文上注册效应，父级释放时连带释放可选持久化纤程（[packages/session-query/session-query/src/corpus.ts:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L48-L50)）
- `listSessions` 在开始与持久化列举后各做一次取消检查（[packages/session-query/session-query/src/corpus.ts:59-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L59-L62)）
- `listSessions` 先按持久化头部建记录（`live:false, persisted:true`），再用活动会话覆盖同 id 记录并置 `live:true`，覆盖前断言两侧头部相容（[packages/session-query/session-query/src/corpus.ts:63-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L63-L75)）
- `listSessions` 按 `createdAt` 倒序、同值再按 id 字典序输出（[packages/session-query/session-query/src/corpus.ts:76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L76)、[packages/session-query/session-query/src/corpus.ts:299-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L299-L301)）
- `load` 命中活动会话时直接返回其克隆快照，完全不访问持久化（[packages/session-query/session-query/src/corpus.ts:89-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L89-L95)）
- `load` 在无持久化服务、或列举结果中找不到该 id 时抛 `SESSION_QUERY_SESSION_NOT_FOUND`（[packages/session-query/session-query/src/corpus.ts:96-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L96-L100)）
- `load` 在检视持久化日志后重新查一次活动会话，若期间已挂载则改用活动快照（[packages/session-query/session-query/src/corpus.ts:101-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L101-L108)）
- `load` 对"列举得到的头部"与"检视加载的头部"断言相容，然后逐事件深克隆返回（[packages/session-query/session-query/src/corpus.ts:109-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L109-L115)）
- `projectMany` 先按 `Set` 去重请求 id，命中活动会话的立即用同步投影函数出结果，其余进入待解析队列（[packages/session-query/session-query/src/corpus.ts:133-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L133-L145)）
- `projectMany` 在无持久化服务时把每个未解析 id 单独标为 rejected 且原因为未找到（[packages/session-query/session-query/src/corpus.ts:147-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L147-L153)）
- `projectMany` 的持久化列举失败被逐 id 记为 rejected 而不中断整批，但若信号已取消则整批抛出（[packages/session-query/session-query/src/corpus.ts:155-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L155-L165)）
- 单 id 解析在列举结果里缺席时，回查活动会话，仍无则记未找到（[packages/session-query/session-query/src/corpus.ts:167-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L167-L175)）
- 单 id 解析在检视后重查活动会话优先使用活动源，否则断言头部相容并把借用的头部与事件交给同步投影函数（[packages/session-query/session-query/src/corpus.ts:176-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L176-L189)）
- 单 id 解析的异常被隔离为该 id 的 rejected 结果，取消信号则改为整体抛出（[packages/session-query/session-query/src/corpus.ts:190-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L190-L193)）
- 用共享游标与不超过配置并发数（且不超过待解析条数）的 worker 循环推进持久化检视，每轮循环先检查取消（[packages/session-query/session-query/src/corpus.ts:195-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L195-L208)）
- 全部 worker 结算后再检查一次取消，并把 worker 自身的拒绝原样抛出（[packages/session-query/session-query/src/corpus.ts:209-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L209-L218)）
- 结果按去重后的首次出现顺序输出（[packages/session-query/session-query/src/corpus.ts:219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L219)、[packages/session-query/session-query/src/corpus.ts:245-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L245-L250)）
- `projectSource` 在调用投影函数前后各查一次取消，并把投影抛出的异常转成该 id 的 rejected 结果（[packages/session-query/session-query/src/corpus.ts:223-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L223-L239)）
- 活动源以未克隆的头部与事件数组直接借出，仅供同步投影期间使用（[packages/session-query/session-query/src/corpus.ts:241-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L241-L243)）
- 持久化列举失败被包装为 `SESSION_QUERY_PERSISTENCE_FAILED` 并挂 `cause`，取消优先（[packages/session-query/session-query/src/corpus.ts:252-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L252-L266)）
- 持久化检视失败按错误 `name` 区分：损坏记录转 `SESSION_QUERY_CORRUPT_SESSION`，其余转 `SESSION_QUERY_PERSISTENCE_FAILED`（[packages/session-query/session-query/src/corpus.ts:268-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L268-L290)）
- 活动快照对头部与每条事件都做 `structuredClone`，返回值不指向活动状态（[packages/session-query/session-query/src/corpus.ts:292-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/corpus.ts#L292-L297)）

### packages/session-query/session-query/src/cursor.ts

声明搜索分页游标的品牌类型，并提供一个把字符串标记为该类型的函数。

- 无运行期机制

### packages/session-query/session-query/src/documents.ts

把一条完整原始事件日志投影成带表面归类的轻量事件记录与可检索语义文档。

- `buildSessionEventRecords` 逐事件产出 `sessionId/seq/type/time/surface`，未被折叠覆盖的事件归为 `log-only`（[packages/session-query/session-query/src/documents.ts:15-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/documents.ts#L15-L27)）
- `buildSessionEventSearchDocuments` 对每条事件抽取语义文本，文本为空的事件被整条丢弃，其余带上表面归类进入文档（[packages/session-query/session-query/src/documents.ts:35-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/documents.ts#L35-L54)）
- `classifySurface` 调用共享的表面折叠，折叠抛错时转成 `SESSION_QUERY_INVALID_SURFACE` 并挂 `cause`（[packages/session-query/session-query/src/documents.ts:56-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/documents.ts#L56-L67)）
- `classifySurface` 把折叠出的节点标为 `current`，把每次替换的被遮蔽 seq 标为 `shadowed`（[packages/session-query/session-query/src/documents.ts:68-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/documents.ts#L68-L73)）

### packages/session-query/session-query/src/extraction.ts

按事件类型抽取用于文本过滤与索引的语义文本，决定哪些事件内容能被检索到。

- 按事件判别标签分派：用户消息与助手消息取内容文本，工具调用取名称与参数，工具结果取内容与错误的 `name`/`code`，待办写入取每项状态与内容，轮次结束取其结束原因文本（[packages/session-query/session-query/src/extraction.ts:15-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/extraction.ts#L15-L31)）
- 轮次开始、步骤起止、助手流式分片、请求头部这五类事件返回空串，因而不产生文档（[packages/session-query/session-query/src/extraction.ts:33-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/extraction.ts#L33-L38)）
- 未知（声明合并扩展出的）事件类型走默认分支返回空串（[packages/session-query/session-query/src/extraction.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/extraction.ts#L41-L43)）
- 轮次结束原因按种类映射：错误取 `error` 与错误消息，中止取 `aborted`，达到最大 token 与被打断取其种类名，正常完成与未知种类返回空串（[packages/session-query/session-query/src/extraction.ts:46-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/extraction.ts#L46-L62)）
- 内容块按类型抽取：文本块取文本，推理块被丢弃，工具调用块取名称与参数，工具结果块递归展开，未知块返回空数组（[packages/session-query/session-query/src/extraction.ts:70-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/extraction.ts#L70-L85)）
- 文本片段先各自 `trim`、去掉空串，再以换行连接（[packages/session-query/session-query/src/extraction.ts:87-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/extraction.ts#L87-L89)）

### packages/session-query/session-query/src/filters.ts

提供与后端无关的会话记录与事件文档谓词，以及跨异步边界前的过滤器复制与校验。

- `filterSessionResults` 把所有子句取合取，逐记录过滤并保持输入顺序（[packages/session-query/session-query/src/filters.ts:18-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L18-L24)）
- `filterSessionEventDocuments` 同样取合取，逐文档过滤并保持输入顺序（[packages/session-query/session-query/src/filters.ts:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L32-L38)）
- 会话过滤器复制校验：要求整体为数组，按 `id`/`cwd`/`created-at`/`parent`/`availability` 分支复制值，`availability` 只接受 `live` 与 `persisted`，未知 kind 抛错（[packages/session-query/session-query/src/filters.ts:45-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L45-L68)）
- 事件过滤器复制校验：`seq`/`time` 走区间校验，`surface` 只接受 `current`/`shadowed`/`log-only`，`text` 必须是字符串，未知 kind 抛错（[packages/session-query/session-query/src/filters.ts:75-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L75-L98)）
- `compileSessionTextFilter` 对全空白输入抛 `SESSION_QUERY_INVALID_FILTER`，否则按空白切词、逐词转义正则元字符、以 `\s+` 连接，并以 `iu` 标志编译（[packages/session-query/session-query/src/filters.ts:105-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L105-L118)）
- 会话谓词：`id` 按头部 id 匹配，`cwd` 与 `parent` 把缺省值折成 `null` 后匹配，`created-at` 走区间，`availability` 对 `live`/`persisted` 标志取析取（[packages/session-query/session-query/src/filters.ts:120-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L120-L138)）
- 事件谓词：`seq`/`time` 走区间，`type` 与 `surface` 按值集合匹配，`text` 用编译出的正则对文档语义文本做 `test`（[packages/session-query/session-query/src/filters.ts:140-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L140-L162)）
- 值数组校验：非数组或含非字符串项抛 `SESSION_QUERY_INVALID_FILTER`，通过后返回浅拷贝（[packages/session-query/session-query/src/filters.ts:164-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L164-L180)）
- 区间复制只保留已定义的 `from`/`to` 字段，并在复制后立即校验（[packages/session-query/session-query/src/filters.ts:182-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L182-L193)）
- 未知 kind 与不在允许集合内的取值都抛 `SESSION_QUERY_INVALID_FILTER`（[packages/session-query/session-query/src/filters.ts:195-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L195-L213)）
- 区间校验要求端点有限、且 `from` 不大于 `to`，匹配按闭区间判定（[packages/session-query/session-query/src/filters.ts:215-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/filters.ts#L215-L231)）

### packages/session-query/session-query/src/index.ts

服务定义模块：声明抽象的查询服务类、把具体读取/过滤/追踪实现挂在同一服务上，并做配置校验。

- 服务类继承服务基类、声明 `static inject = ['sessions']`，并以 `sessionQuery` 名注册到上下文（[packages/session-query/session-query/src/index.ts:87-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L87-L95)）
- 构造时取 `readWindowMax`（缺省 50），非非负整数即抛 `SESSION_QUERY_INVALID_CONFIG`（[packages/session-query/session-query/src/index.ts:96-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L96-L102)）
- 构造时取 `persistedInspectConcurrency`（缺省 4），非正安全整数即抛 `SESSION_QUERY_INVALID_CONFIG`（[packages/session-query/session-query/src/index.ts:103-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L103-L110)）
- 构造出语料解析器与观察读取器，并把并发上限传给语料解析器（[packages/session-query/session-query/src/index.ts:111-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L111-L112)）
- `observeSession` 把单点观察委托给观察读取器（[packages/session-query/session-query/src/index.ts:121-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L121-L126)）
- `listSessions` 直接返回语料解析器的活动优先列举（[packages/session-query/session-query/src/index.ts:155-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L155-L157)）
- `readSession` 先用 `Session.create` 重放整份日志做校验，再返回克隆头部与逐条快照事件（[packages/session-query/session-query/src/index.ts:165-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L165-L172)）
- `filterSessions` 先把调用方过滤器复制校验成自有副本，再对语料列举结果套谓词（[packages/session-query/session-query/src/index.ts:180-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L180-L186)、[packages/session-query/session-query/src/index.ts:262-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L262-L267)）
- `readTitle` 只取批量结果里的标题字段（[packages/session-query/session-query/src/index.ts:194-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L194-L199)）
- `readTitleSnapshot` 取批量结果第一项，状态为 rejected 时把原始失败原样抛出（[packages/session-query/session-query/src/index.ts:207-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L207-L214)）
- `readTitleSnapshots` 用一次批量语料投影对每份日志折叠标题，克隆头部，无标题时省略该字段（[packages/session-query/session-query/src/index.ts:225-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L225-L236)）
- `listEvents` 加载整份日志并交给追踪模块产出轻量事件记录（[packages/session-query/session-query/src/index.ts:243-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L243-L246)）
- `filterEvents` 先复制校验过滤器，再加载日志、构建语义文档并套谓词（[packages/session-query/session-query/src/index.ts:254-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L254-L260)、[packages/session-query/session-query/src/index.ts:269-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L269-L276)）
- `readSurface` 返回克隆头部、日志最后一条 seq（空日志为 `null`）与折叠出的当前表面事件（[packages/session-query/session-query/src/index.ts:284-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L284-L291)）
- `traceSession` 用一次语料列举做血缘追踪，列举后再查一次取消（[packages/session-query/session-query/src/index.ts:300-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L300-L304)）
- `traceEvent` 加载同一份日志并把追踪结果与该次观察的头部绑在一起返回（[packages/session-query/session-query/src/index.ts:313-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L313-L320)）
- `readEvent` 先校验 `before`/`after` 窗口再执行读取（[packages/session-query/session-query/src/index.ts:328-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L328-L334)）
- 读取实现按下标取目标事件并校验其 `seq` 一致，不一致或缺失抛 `SESSION_QUERY_EVENT_NOT_FOUND`（[packages/session-query/session-query/src/index.ts:343-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L343-L351)）
- 读取实现把窗口夹在 `[0, 末条]` 之内，逐条快照返回并让窗口内的目标与 `target` 指向同一快照对象（[packages/session-query/session-query/src/index.ts:352-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L352-L365)）
- 窗口校验：未给值按 0 处理，非整数、负数或超过配置上限抛 `SESSION_QUERY_INVALID_WINDOW`（[packages/session-query/session-query/src/index.ts:368-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L368-L377)）
- 服务类作为默认导出，供加载器按服务包约定装载（[packages/session-query/session-query/src/index.ts:380](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/index.ts#L380)）

### packages/session-query/session-query/src/invariant.ts

该包的不变量伴生插件，向不变量服务登记包名并安装一个空的检查器。

- 以函数插件形式导出插件名与 `inject = ['invariants']`，声明装载前必须先有不变量服务（[packages/session-query/session-query/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/invariant.ts#L13-L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/session-query/session-query/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/invariant.ts#L21)）
- `apply` 用包名向不变量服务注册该安装器，并把注册返回的释放函数交回加载器（[packages/session-query/session-query/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/invariant.ts#L28-L29)）

### packages/session-query/session-query/src/observation.ts

构建单个会话的不可变观察切片（活动会话或从持久化借出的冷准备），带引用计数租约与可选投影计算。

- `read` 以 `for(;;)` 循环开始，每轮先检查取消，命中活动会话即返回活动观察（[packages/session-query/session-query/src/observation.ts:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L57-L61)）
- 用 `ctx.get('sessionPersistence')` 读可选持久化服务，缺席则抛未找到（[packages/session-query/session-query/src/observation.ts:62-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L62-L63)）
- 借出会话失败按错误 `name` 分流为未找到、`SESSION_QUERY_CORRUPT_SESSION` 或 `SESSION_QUERY_PERSISTENCE_FAILED`，取消优先（[packages/session-query/session-query/src/observation.ts:65-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L65-L83)）
- 借出结果的头部 id 与请求 id 不符时抛 `SESSION_QUERY_SOURCE_CONFLICT`（[packages/session-query/session-query/src/observation.ts:86-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L86-L92)）
- 借出后重查活动会话，若已挂载则释放借出并改返回活动观察（[packages/session-query/session-query/src/observation.ts:93-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L93-L98)）
- 借出源标记为 live 时释放借出并 `continue` 重试整轮解析（[packages/session-query/session-query/src/observation.ts:99-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L99-L104)）
- 投影模式为 `none` 时跳过投影，否则计算冷准备的投影；投影失败转 `SESSION_QUERY_CORRUPT_SESSION`（[packages/session-query/session-query/src/observation.ts:105-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L105-L118)）
- 冷准备观察用引用计数租约：`retain` 计数加一并派生新租约，`dispose` 幂等减一，减到 0 才释放底层借出，已释放后 `retain` 抛错（[packages/session-query/session-query/src/observation.ts:119-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L119-L142)）
- 观察的 `cursor` 取最后一条事件 seq，空日志为 `-1`，并带上冷源的持久化修订号（[packages/session-query/session-query/src/observation.ts:123-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L123-L128)）
- 借出之后的任何异常都先释放借出再向外抛（[packages/session-query/session-query/src/observation.ts:143-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L143-L146)）
- 活动观察冻结一份事件数组副本，投影模式非 `none` 且投影注册表已挂载时取其快照（[packages/session-query/session-query/src/observation.ts:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L150-L157)）
- 活动观察的租约只标记自身是否已释放，不做引用计数，已释放后 `retain` 抛错（[packages/session-query/session-query/src/observation.ts:158-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L158-L173)）
- 冷准备投影按挂载情况分流：无投影注册表返回 undefined，无投影缓存走注册表 `hydrate`，有缓存走缓存的 `hydratePrepared`（[packages/session-query/session-query/src/observation.ts:176-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L176-L187)）
- 取消检查抛 `SESSION_QUERY_ABORTED` 并把信号原因挂为 `cause`（[packages/session-query/session-query/src/observation.ts:190-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L190-L197)）
- 未找到失败带 `SESSION_QUERY_SESSION_NOT_FOUND` 码，有底层原因时挂 `cause`（[packages/session-query/session-query/src/observation.ts:199-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/observation.ts#L199-L205)）

### packages/session-query/session-query/src/sources.ts

对同一逻辑会话的两次头部观察做不可变字段一致性检查，被语料解析路径调用。

- 逐字段比较 `version`、`id`、`createdAt`、`cwd`、`parentSession`、`seedLength`，并把 `delegationDepth` 缺省折成 0 再比，任一不等即抛 `SESSION_QUERY_SOURCE_CONFLICT`（[packages/session-query/session-query/src/sources.ts:11-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/sources.ts#L11-L26)）

### packages/session-query/session-query/src/tracing.ts

一次性的会话血缘与事件关系追踪，并共享同一次表面折叠来产出事件记录与当前表面。

- `eventRecords` 复用整份日志分析结果返回按日志顺序排列的轻量记录（[packages/session-query/session-query/src/tracing.ts:27-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L27-L32)）
- `currentSurfaceEvents` 按折叠出的当前 seq 逐个取回事件，校验其 seq 一致且确为表面事件，否则抛 `SESSION_QUERY_INVALID_SURFACE`，通过后逐条快照（[packages/session-query/session-query/src/tracing.ts:40-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L40-L56)）
- `traceEvent` 先按下标取目标并校验 seq，缺失或不符抛 `SESSION_QUERY_EVENT_NOT_FOUND`（[packages/session-query/session-query/src/tracing.ts:70-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L70-L76)）
- `traceEvent` 沿"被谁替换"关系一路走到最终替换者，得到替换链（[packages/session-query/session-query/src/tracing.ts:80-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L80-L85)）
- `traceEvent` 只扫描 seq 大于目标的事件，收集直接把目标列为来源的后继事件（[packages/session-query/session-query/src/tracing.ts:87-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L87-L91)）
- `traceEvent` 返回目标记录、可选的直接替换者、替换链、目标自身替换掉的 seq、目标引用的来源 seq 与派生事件 seq（[packages/session-query/session-query/src/tracing.ts:95-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L95-L104)）
- `traceSession` 按 id 建索引，目标不在语料中抛 `SESSION_QUERY_SESSION_NOT_FOUND`（[packages/session-query/session-query/src/tracing.ts:117-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L117-L124)）
- 祖先链沿 `parentSession` 上行，重复 id 判为环并抛 `SESSION_QUERY_INVALID_LINEAGE`，遇到语料中缺席的父级则记录该 id 并停止（[packages/session-query/session-query/src/tracing.ts:126-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L126-L145)）
- 按父 id 分组建子表，并对每组按 `createdAt` 升序、同值按 id 字典序排序（[packages/session-query/session-query/src/tracing.ts:147-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L147-L157)）
- 血缘结果分两形：父链缺口时给出 `complete:false` 与首个未解析父 id，否则给出 `complete:true` 与根记录（无祖先时根即目标）（[packages/session-query/session-query/src/tracing.ts:159-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L159-L173)）
- 日志分析统一调用表面折叠，折叠抛错转 `SESSION_QUERY_INVALID_SURFACE` 并挂 `cause`（[packages/session-query/session-query/src/tracing.ts:179-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L179-L189)）
- 日志分析建立"替换者→被遮蔽 seq 列表"与"被遮蔽 seq→替换者"两张表（[packages/session-query/session-query/src/tracing.ts:190-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L190-L199)）
- 日志分析把每条事件归为 `current`、`shadowed` 或 `log-only`，并附带当前 seq 序列（[packages/session-query/session-query/src/tracing.ts:200-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L200-L213)）
- 事件来源取其 `sourceEventSeqs`，缺失时按空数组处理（[packages/session-query/session-query/src/tracing.ts:216-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L216-L218)）
- 后代树用显式栈迭代展开，子节点逆序入栈以保持输出顺序与子表排序一致（[packages/session-query/session-query/src/tracing.ts:220-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L220-L244)）
- 血缘中的每条记录都复制一份并深克隆其头部（[packages/session-query/session-query/src/tracing.ts:246-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-query/src/tracing.ts#L246-L248)）

### packages/session-query/session-query/src/types.ts

该包对外公开的记录、过滤器、请求与分页类型声明文件，只含类型。

- 无运行期机制

### packages/session-query/session-query/tsconfig.json

该包的 TypeScript 编译配置，设置源码与声明输出目录并列出工作区引用。

- 无运行期机制
