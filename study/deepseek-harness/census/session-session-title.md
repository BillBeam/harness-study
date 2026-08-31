---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-title
---

# packages/session/session-title

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、61 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-title/README.md

session-title 包的说明文档，面向选择标题来源、配置服务或排查标题状态的使用者与维护者。

- 无运行期机制

### packages/session/session-title/package.json

包清单，声明模块类型、入口、导出子路径与发布文件集。

- 声明 `"type": "module"`，`main` 指向 `lib/index.js`、`types` 指向 `lib/types/index.d.ts`（[packages/session/session-title/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/package.json#L13-L15)）
- `exports` 暴露 `.`、`./invariant`、`./types`、`./client` 四个入口，外加 `./src/*` 源码直读与 `./package.json`（[packages/session/session-title/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/package.json#L16-L35)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`（[packages/session/session-title/package.json:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/package.json#L36-L41)）

### packages/session/session-title/src/client.ts

客户端命名空间入口，把 `./types.ts` 的类型原样再导出给客户端代码。

- 无运行期机制

### packages/session/session-title/src/index.ts

标题服务本体，被组合到会话存储旁边，负责标题折叠、回退调度、provider 注册与并发管理，并注册 `title` 投影单元。

- `SessionTitleInvalidError` 作为运行期错误类，供调用方对"标题规范化后为空"这一种失败做窄化判断（[packages/session/session-title/src/index.ts:110-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L110-L112)）
- `collectSessionTitleMessages` 只收 `source.kind === 'user'` 的 `user/message`，拼接其 text 块、按 `throughSeq` 截断，并跳过规范化后为空的消息（[packages/session/session-title/src/index.ts:167-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L167-L184)）
- `foldSessionTitle` 用 `findLast` 取最后一条 `session/title` 事件，产出带 `eventSeq`/`updatedAt` 的深冻结快照（[packages/session/session-title/src/index.ts:191-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L191-L201)）
- `copySessionTitleSource` 对日志里的 source 做防御性拷贝，快照不与日志对象共享引用（[packages/session/session-title/src/index.ts:204-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L204-L216)）
- 服务声明 `static inject = ['sessions']` 与三项必填正整数上限的配置 schema（[packages/session/session-title/src/index.ts:262-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L262-L267)）
- 构造函数校验配置对象存在、三项限额为正整数、`fallbackMaxBytes` 不超过 `maxTitleBytes`，然后深冻结配置副本（[packages/session/session-title/src/index.ts:279-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L279-L290)）
- 注册生命周期 effect：卸载时中止 lifetime 信号、把注册置为 closing、删除所有 pending、中止所有 active、await 排空在途任务再清空工作表（[packages/session/session-title/src/index.ts:292-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L292-L302)）
- 通过 `ctx.inject(['sessionProjections'])` 注册 `title` 投影单元：last-wins 折叠 `session/title` 的标题串，初值为 null，视图即状态（[packages/session/session-title/src/index.ts:308-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L308-L318)）
- 监听 `session/event`，把 `user/message` 交给 `onUserMessage`、`request/header` 交给 `onRequestHeader`，其余事件不处理（[packages/session/session-title/src/index.ts:320-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L320-L331)）
- 以 `{ global: true, prepend: true }` 前插监听 `llm/stream`，观察主请求后调用 `next()` 继续瀑布（[packages/session/session-title/src/index.ts:332-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L332-L335)）
- 监听 `session/disposed`：中止该会话的 active 工作并删除其工作状态（[packages/session/session-title/src/index.ts:336-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L336-L341)）
- `get` 直接对 `session.events` 做折叠，标题读取以日志为准（[packages/session/session-title/src/index.ts:349-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L349-L351)）
- `rename` 断言服务在活、要求会话在存储中在线、规范化后为空则抛 `SessionTitleInvalidError`，随后 supersede 旧工作并追加 `source.kind === 'user'`、`messageSeqs` 为空的 `session/title` 事件（[packages/session/session-title/src/index.ts:364-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L364-L384)）
- `refresh` 先检查调用方 signal 与服务活性、要求会话在线，并收集当前全部合格消息（[packages/session/session-title/src/index.ts:393-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L393-L401)）
- 无 provider（或已 closing、无合格消息）时：当前标题为 user 源且存在首条消息则同步重新追加回退标题以解除固定，否则走 `ensureFallback`（[packages/session/session-title/src/index.ts:402-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L402-L416)）
- 有 provider 时：supersede 抢占新 revision、以调用方 signal 组合出 active 工作，路由取自会话当前 `requestHeader()?.config`，再启动 provider（[packages/session/session-title/src/index.ts:417-426](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L417-L426)）
- `register` 校验 provider 形状、已有注册时抛错，用 effect 发布注册，其 disposer 置 closing、清掉属于该注册的 pending、中止其 active、排空在途调用后清空注册槽（[packages/session/session-title/src/index.ts:435-460](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L435-L460)）
- `onUserMessage` 在服务不活、消息非 user 源、消息规范化后为空、或当前标题为 user 源时直接返回（[packages/session/session-title/src/index.ts:463-467](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L463-L467)）
- `onUserMessage` 的调度判定：`all-prompts` 每条新消息都排一次，`first-prompt` 只在非分叉会话、消息数为 1 且尚无标题时排；命中则 supersede 并写入 pending（[packages/session/session-title/src/index.ts:468-478](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L468-L478)）
- `onUserMessage` 随后以 defer 异步跑 `ensureFallback`，失败时在服务仍活的前提下打 warn（[packages/session/session-title/src/index.ts:479-486](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L479-L486)）
- `onRequestHeader` 只在存在 pending 且 `pending.throughSeq < event.seq` 时，以 header 里的 provider/model 路由启动 pending（[packages/session/session-title/src/index.ts:490-500](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L490-L500)）
- `onMainRequest` 只处理带 sessionId 且被标记为 agent-loop 的请求，并要求最后一个 step 边界是 `step/start`、其 seq 大于 pending 的 `throughSeq`，且已折叠路由与本次请求的 provider/model 完全一致才启动（[packages/session/session-title/src/index.ts:503-516](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L503-L516)）
- `startPending` 先删除 pending，再在 defer 的异步任务里重新校验注册、closing、工作状态与 revision，然后激活并启动 provider，失败且未被中止时打 warn（[packages/session/session-title/src/index.ts:519-539](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L519-L539)）
- `startProvider` 把 provider 调用包进微任务并交给 `track` 跟踪，使其被服务与注册的排空逻辑持有（[packages/session/session-title/src/index.ts:542-549](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L542-L549)）
- `runProvider` 在生成前后各做一次现时性断言、先落回退标题、按 `throughSeq` 收集消息、调用 `provider.generate` 并传入 signal（[packages/session/session-title/src/index.ts:557-568](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L557-L568)）
- `runProvider` 校验结果后追加 `source.kind === 'provider'` 的 `session/title` 事件（带 provider id 与可选 model 溯源），并在 finally 清掉自己的 active 槽（[packages/session/session-title/src/index.ts:569-583](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L569-L583)）
- `validateResult` 要求结果是对象、`title` 为字符串且规范化后非空、`messageSeqs` 为非空数组（[packages/session/session-title/src/index.ts:591-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L591-L600)）
- `validateResult` 要求每个 seq 都是请求内消息的安全非负整数且按请求顺序严格递增，否则抛错（[packages/session/session-title/src/index.ts:601-614](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L601-L614)）
- `validateResult` 对可选 `model` 要求 provider 与 model 都是非空字符串，并只保留这两个字段（[packages/session/session-title/src/index.ts:615-632](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L615-L632)）
- `assertCurrent` 依次检查服务活性、signal 未中止、注册未换、active 仍是自己、revision 未变、会话仍在存储中，任一不符即抛错阻止追加（[packages/session/session-title/src/index.ts:636-648](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L636-L648)）
- `activate` 用 `AbortSignal.any` 把本次 controller、服务 lifetime 与可选上游 signal 合成一个取消源，并把工作发布为该会话的 active（[packages/session/session-title/src/index.ts:651-663](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L651-L663)）
- `supersede` 以给定原因中止旧 active、删除 pending 并把会话内 revision 加一（[packages/session/session-title/src/index.ts:666-671](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L666-L671)）
- `stateFor` 按会话惰性建立 revision 从 0 起的可变工作状态（[packages/session/session-title/src/index.ts:674-681](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L674-L681)）
- `defer` 把任务排到微任务并在执行前再查一次服务活性，然后交给 `track` 持有（[packages/session/session-title/src/index.ts:684-690](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L684-L690)）
- `track` 把 promise 同时登记进服务在途集合与可选注册的 active 集合，结算后两处都移除（[packages/session/session-title/src/index.ts:693-702](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L693-L702)）
- `drain` 反复 `Promise.allSettled` 直到集合为空，从而等到忽略取消的调用也结算（[packages/session/session-title/src/index.ts:705-707](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L705-L707)）
- `serviceActive` 以 lifetime 未中止、拥有者 fiber 的 uid 非空且状态为 ACTIVE 三条判定服务是否还能开工或提交（[packages/session/session-title/src/index.ts:710-714](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L710-L714)）
- `assertServiceActive` 在服务已开始卸载时抛错（[packages/session/session-title/src/index.ts:717-719](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L717-L719)）
- `validateProvider` 要求 provider 是对象、id 为非空字符串、automatic 只能是两种取值之一、`generate` 必须是函数（[packages/session/session-title/src/index.ts:722-736](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L722-L736)）
- `appendFallback` 同步派生并追加 `fallback` 源的 `session/title` 事件，覆盖已有标题；派生结果为空则不追加（[packages/session/session-title/src/index.ts:745-753](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L745-L753)）
- `ensureFallback` 在已有标题、没有合格消息或派生结果为空时都不追加（[packages/session/session-title/src/index.ts:756-767](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L756-L767)）
- `ensureFallback` 用会话内的在途 promise 去重并发请求，追加前再查服务活性、会话在线与是否已被别的写入抢先，结束后清掉在途槽（[packages/session/session-title/src/index.ts:768-789](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L768-L789)）
- 以默认导出暴露服务类，供 Loader 按服务插件形式加载（[packages/session/session-title/src/index.ts:793](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/index.ts#L793)）

### packages/session/session-title/src/invariant.ts

包自带的不变量伴生插件，在事件发布前拦截并检查 `session/title` 的来源与引用关系。

- `inject = ['invariants']` 要求不变量服务先就绪，伴生插件才能启动（[packages/session/session-title/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/invariant.ts#L15)）
- 安装器以 `internal/dispatch` 全局监听拦截 `session/event`，只挑出 `session/title` 事件（[packages/session/session-title/src/invariant.ts:29-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/invariant.ts#L29-L33)）
- 检查 `messageSeqs` 为空当且仅当 `source.kind === 'user'`，不满足即调用 `fail` 并给出所需引用条件（[packages/session/session-title/src/invariant.ts:34-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/invariant.ts#L34-L37)）
- 安装器自身带 `inject: ['sessions']`，安装前需要会话服务就绪（[packages/session/session-title/src/invariant.ts:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/invariant.ts#L39)）
- `apply` 向 `ctx.invariants` 注册包名与该安装器并返回其 disposer（[packages/session/session-title/src/invariant.ts:46-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/invariant.ts#L46-L47)）

### packages/session/session-title/src/normalize.ts

标题文本的清洗、UTF-8 安全截断与确定性回退派生，被服务在接受任何标题前调用。

- 五组正则分别匹配 OSC 转义（含未终止尾部）、CSI 转义、两字节 ESC 转义、非空白 C0/C1 控制符，以及方向性与不可见控制符（[packages/session/session-title/src/normalize.ts:4-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/normalize.ts#L4-L12)）
- `assertPositiveInteger` 对公开的文本上限参数要求正整数，否则抛错（[packages/session/session-title/src/normalize.ts:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/normalize.ts#L15-L19)）
- `cleanTitleText` 依次剔除五类控制序列，再把连续空白折成单空格并 trim（[packages/session/session-title/src/normalize.ts:22-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/normalize.ts#L22-L31)）
- `truncateTitleUtf8` 按 UTF-8 字节预算逐码点累加，超预算即停，不会切开码点（[packages/session/session-title/src/normalize.ts:39-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/normalize.ts#L39-L51)）
- `normalizeSessionTitle` 组合清洗、按字节截断与尾部去空白，可能返回空串（[packages/session/session-title/src/normalize.ts:59-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/normalize.ts#L59-L61)）
- `fallbackSessionTitle` 取清洗后前 `maxWords` 个非空词，再按字节上限截断并去尾空白（[packages/session/session-title/src/normalize.ts:70-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title/src/normalize.ts#L70-L74)）

### packages/session/session-title/src/types.ts

纯类型文件，把 `title` 键并入投影状态表与投影映射表。

- 无运行期机制

### packages/session/session-title/tsconfig.json

包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制
