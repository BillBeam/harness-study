---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/sdk/client
---

# packages/sdk/client

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 10 个文件、78 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/sdk/client/README.md

该客户端包的说明文档，介绍高层 run API、底层协议客户端、错误类型与拆卸阶梯，供调用方与维护者阅读。

- 无运行期机制

### packages/sdk/client/package.json

本包的 npm 清单，声明入口、子路径导出、发布内容与运行时依赖。

- `"type": "module"` 与 `main`/`types` 指向 `lib/index.js` 及其类型声明（[packages/sdk/client/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/package.json#L13-L15)）
- `exports` 把包根映射到 `lib/index.js`、`./invariant` 映射到 `lib/invariant.js`，并开放 `./package.json`（[packages/sdk/client/package.json:16-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/package.json#L16-L26)）
- `files` 把发布内容限定为两个运行时 bundle 与 `lib/types` 下的类型声明（[packages/sdk/client/package.json:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/package.json#L27-L31)）
- 把运行时 CLI 包列为普通 `dependencies`，`launch.ts` 在启动时正是靠它解析同版本可执行文件（[packages/sdk/client/package.json:33-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/package.json#L33-L35)）

### packages/sdk/client/src/api.ts

高层运行 API：拥有一个运行时子进程、做一次握手，并把一次 prompt 收敛为"从入队回执到整体 idle"的一段活动。

- 构造时把 `cwd` 解析成绝对路径，避免子进程内再次相对解析导致路径重复拼接（[packages/sdk/client/src/api.ts:38-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L38-L41)）
- provider 与 model 在缺省时取固定默认路由，effort 与 maxTokens 保持原样透传（[packages/sdk/client/src/api.ts:42-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L42-L45)）
- `start()` 记忆化握手，只在首次调用时启动子进程并发 `initialize`，可选字段缺省时不出现在参数里（[packages/sdk/client/src/api.ts:69-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L69-L79)）
- 握手失败时清除记忆并关闭客户端；清理也失败则抛出保序的 `AggregateError` 并保留失败客户端，清理成功且未 `close()` 才换上新客户端以便重试（[packages/sdk/client/src/api.ts:80-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L80-L92)）
- `session()` 不产生任何线上流量，仅在缺省时用 UUID 铸造一个新的会话 id（[packages/sdk/client/src/api.ts:103-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L103-L105)）
- `close()` 置终态标志并关闭当前客户端，此后不再重试握手（[packages/sdk/client/src/api.ts:122-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L122-L125)）
- 实现 `Symbol.asyncDispose`，使 `await using` 退出作用域时自动收割子进程（[packages/sdk/client/src/api.ts:131-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L131-L133)）
- `createProcessDeepSeekHarness` 用通用进程描述替换默认客户端工厂，绕开可执行文件解析（[packages/sdk/client/src/api.ts:137-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L137-L149)）
- `run()` 先确保握手完成，再对该会话树建立订阅，之后才发 prompt（[packages/sdk/client/src/api.ts:176-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L176-L183)）
- 收集函数只把本会话的 `session.event` 校验后计入 `events`，其余通知只计入 `notifications`，两者都按线序回调观察者（[packages/sdk/client/src/api.ts:184-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L184-L197)）
- 收集在见到该 messageId 的持久入队回执之前丢弃一切通知，之后一直收到本会话状态变为 `idle` 才结束（[packages/sdk/client/src/api.ts:199-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L199-L213)）
- 无论正常结束还是抛错都关闭订阅，避免遗留投递（[packages/sdk/client/src/api.ts:214-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L214-L216)）
- 返回值由会话 id、派生的 `finalResponse`、事件序列与通知序列构成（[packages/sdk/client/src/api.ts:218-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L218-L223)）
- `normalizeInput` 把字符串包成单个 text 块，块数组原样透传（[packages/sdk/client/src/api.ts:232-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L232-L234)）
- `validatedTurnEndReason` 只放行五种已知中止原因，`hook` 还要求 `reason` 是字符串，其余抛协议错误（[packages/sdk/client/src/api.ts:237-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L237-L261)）
- `validatedSessionEvent` 在线上边界校验事件信封，并对 `assistant/message` 的内容块与 `turn/end` 的数据额外校验（[packages/sdk/client/src/api.ts:264-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L264-L286)）
- `isInboxReceipt` 以 `agent/inbox/spliced` 事件的 `inserted` 中是否含该 messageId 判定入队回执（[packages/sdk/client/src/api.ts:289-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L289-L293)）
- `finalResponse` 从后向前找最后一条助手消息，拼接其全部 text 块，没有则返回空串（[packages/sdk/client/src/api.ts:300-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/api.ts#L300-L310)）

### packages/sdk/client/src/client.ts

底层 JSON-RPC 客户端：拉起运行时子进程、收发协议帧、把通知扇出给订阅、并在关闭时走拆卸阶梯。

- 保留最近 400 行 stderr 与 100 毫秒的流沉降宽限，作为诊断与关闭判定的界限（[packages/sdk/client/src/client.ts:29-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L29-L32)）
- 导出三个失败类型，分别对应运行时消失、请求超时与响应越出协议（[packages/sdk/client/src/client.ts:39-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L39-L66)）
- 订阅的 `next()` 优先取队列，队列空且已终结则立即拒绝，否则挂起等待者（[packages/sdk/client/src/client.ts:108-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L108-L115)）
- `tryNext()` 只弹出已投递项，不等待（[packages/sdk/client/src/client.ts:121-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L121-L123)）
- `close()` 先摘除订阅，再清空队列并让全部等待者失败；这与运行时死亡时保留队列的处理不同（[packages/sdk/client/src/client.ts:126-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L126-L132)）
- `fail()` 以首个失败为准并一次性拒绝全部挂起等待者（[packages/sdk/client/src/client.ts:139-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L139-L142)）
- `push()` 先跑过滤器，过滤器抛错只让本订阅摘除并终结，不影响兄弟订阅与读循环；命中后优先交给等待者否则入队（[packages/sdk/client/src/client.ts:151-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L151-L164)）
- 订阅实现异步迭代器，终结拒绝会从迭代中抛出（[packages/sdk/client/src/client.ts:171-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L171-L173)）
- 构造时若未注入进程描述，就用公开选项解析出一份启动规格（[packages/sdk/client/src/client.ts:202-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L202-L205)）
- `start()` 在已关闭后拒绝复用，进程已在则幂等返回，否则按解析出的 command/args/cwd/env 以三管道方式 spawn（[packages/sdk/client/src/client.ts:211-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L211-L219)）
- spawn 失败时记录错误、关闭传输并让全部订阅失败，因为不会再有 end 边沿（[packages/sdk/client/src/client.ts:220-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L220-L226)）
- stdin 上的错误被静默吞掉，以退出边沿为准（[packages/sdk/client/src/client.ts:230-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L230-L231)）
- stderr 按整行切分累积进尾巴缓冲，关闭时把残余不完整行也补进去（[packages/sdk/client/src/client.ts:233-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L233-L252)）
- `exit` 记录退出码并立即让全部订阅以带进程上下文的错误失败（[packages/sdk/client/src/client.ts:253-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L253-L258)）
- `close` 边沿才关闭传输，确保 stdout 的尾部帧已排空后再让未答请求失败（[packages/sdk/client/src/client.ts:259-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L259-L264)）
- 在子进程 stdout/stdin 上建行式 JSON-RPC 传输，并把服务端通知接入扇出（[packages/sdk/client/src/client.ts:265-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L265-L268)）
- `initialize` 用握手专用超时发请求，并要求返回体含字符串 name 与 version，否则抛协议错误（[packages/sdk/client/src/client.ts:276-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L276-L283)）
- `prompt` 发 `session/prompt` 并要求返回字符串 messageId，只代表入队而不等待任何 agent 活动（[packages/sdk/client/src/client.ts:291-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L291-L298)）
- `request` 先确保已启动，若进程已退出或从未启动成功则等流沉降后直接抛带退出码与 stderr 尾巴的错误（[packages/sdk/client/src/client.ts:309-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L309-L319)）
- 有超时配置时用 AbortController 把超时实现为放弃：传输丢弃待答条目，超时错误文案带方法名、时长与 stderr 尾巴（[packages/sdk/client/src/client.ts:320-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L320-L335)）
- 协议错误响应与超时原样抛出，其余传输级失败统一补上进程上下文（[packages/sdk/client/src/client.ts:336-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L336-L341)）
- `subscribe` 用自增序号登记订阅；若客户端已关闭或进程已死，返回的订阅出生即为失败态（[packages/sdk/client/src/client.ts:351-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L351-L361)）
- `subscribeSessionTree` 在客户端侧过滤：子 agent 起止通知按父会话或子会话 id 判定，其余通知按 `sessionId` 是否属于该树判定（[packages/sdk/client/src/client.ts:370-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L370-L381)）
- `close()` 记忆化整个拆卸过程，重复调用返回同一个 promise（[packages/sdk/client/src/client.ts:389-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L389-L392)）
- 拆卸先尽力发一次受限时的协议 `shutdown`（失败仅记入 stderr 尾巴），再走进程拆卸阶梯，最后关传输并让全部订阅失败（[packages/sdk/client/src/client.ts:394-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L394-L410)）
- 每条通知先更新血缘再扇出给所有订阅，保证过滤时父子关系已就绪（[packages/sdk/client/src/client.ts:412-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L412-L415)）
- 只从 `subagent.started` 记录父子边，且拒绝空串与自环（[packages/sdk/client/src/client.ts:417-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L417-L424)）
- `isDescendantOf` 沿父指针上溯并用 visited 集合防止死循环（[packages/sdk/client/src/client.ts:426-439](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L426-L439)）
- stderr 尾巴丢弃空行并始终裁剪到最近 400 行（[packages/sdk/client/src/client.ts:445-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L445-L451)）
- `settleStreams` 把"等待流沉降"与 100 毫秒定时器竞速，避免报错前无限等待（[packages/sdk/client/src/client.ts:453-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L453-L458)）
- `closedError` 把启动描述、spawn 错误、退出码与 stderr 尾巴拼进同一条错误消息（[packages/sdk/client/src/client.ts:460-466](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L460-L466)）
- `createProcessHarnessClient` 直接注入通用进程描述构造客户端（[packages/sdk/client/src/client.ts:470-476](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L470-L476)）
- 导出的 `isRecord` 是线上边界统一的对象形状探测（[packages/sdk/client/src/client.ts:483-485](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/client.ts#L483-L485)）

### packages/sdk/client/src/dispose.ts

私有的子进程拆卸阶梯，被客户端 `close()` 调用，只在进程真正退出后才结算。

- `exitsWithin` 把退出边沿与计时器竞速，两条路径都清理各自的监听器或定时器，且定时器 `unref` 以免拖住父进程事件循环（[packages/sdk/client/src/dispose.ts:18-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/dispose.ts#L18-L32)）
- `forceTerminateWithin` 发 SIGKILL 后只结算一次，超时错误里区分信号被接受还是被拒绝，kill 抛错则包成带 cause 的错误（[packages/sdk/client/src/dispose.ts:35-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/dispose.ts#L35-L68)）
- 阶梯先判断进程是否已退出，再关 stdin 让对端合作性收尾并等 EOF 宽限（[packages/sdk/client/src/dispose.ts:87-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/dispose.ts#L87-L91)）
- 非 win32 平台先发一次可捕获的 SIGTERM 并等宽限，win32 直接跳到强制终止（[packages/sdk/client/src/dispose.ts:92-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/dispose.ts#L92-L96)）
- 最后一级强制终止并要求在宽限内看到退出边沿，否则抛错（[packages/sdk/client/src/dispose.ts:97-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/dispose.ts#L97-L98)）

### packages/sdk/client/src/index.ts

包的公开出口，重导出两层客户端、四个错误类型与调用方类型。

- 无运行期机制

### packages/sdk/client/src/invariant.ts

本包的 invariant 伴生插件，带包内注明理由的空安装器。

- 声明 `inject = ['invariants']`，注册前必须先有该服务（[packages/sdk/client/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/invariant.ts#L15)）
- 安装器为空实现，理由是该库运行在任何 harness 上下文之外、其对端是独立进程（[packages/sdk/client/src/invariant.ts:17-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/invariant.ts#L17-L22)）
- `apply` 以固定包名向 invariant 注册表登记并返回其 disposer（[packages/sdk/client/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/invariant.ts#L29-L30)）

### packages/sdk/client/src/launch.ts

把公开的启动选项解析成一份具体子进程规格：可执行文件、argv、环境与各段超时。

- 握手默认超时固定为 10 秒（[packages/sdk/client/src/launch.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L12)）
- 进程规格用 `environment()` 闭包表示环境，推迟到真正 spawn 时才物化（[packages/sdk/client/src/launch.ts:15-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L15-L27)）
- `resolveDshBinFromManifests` 要求运行时包与本包版本字符串完全相等，否则直接抛错；再从 `bin` 字段取出可执行文件并解析成绝对路径（[packages/sdk/client/src/launch.ts:55-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L55-L66)）
- `installedDshBin` 用 `import.meta.resolve` 定位运行时包清单与本包清单来做上述解析（[packages/sdk/client/src/launch.ts:72-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L72-L77)）
- 构建产物存在时直接以它为 Node 入口；不存在则回退到源码入口，并要求源入口、兼容 patch 与 tsconfig 三者齐备，否则抛出列明缺失路径的错误（[packages/sdk/client/src/launch.ts:86-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L86-L102)）
- 源码回退时把 `--import <loader>` 加在入口前，并通过 `TSX_TSCONFIG_PATH` 环境变量指定 tsconfig（[packages/sdk/client/src/launch.ts:103-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L103-L108)）
- `resolveDshLaunch` 缺省用 `sdk` profile，给定 `dshBin` 时按调用方 cwd 解析该路径并跳过版本检查路径（[packages/sdk/client/src/launch.ts:132-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L132-L135)）
- 内部 patch 排在调用方 patch 之前，调用方 patch 逐个按 cwd 解析为绝对路径（[packages/sdk/client/src/launch.ts:136-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L136-L139)）
- argv 组装为"Node 入口 + `--profile <profile>` + 每个 patch 一对 `--patch <path>`"（[packages/sdk/client/src/launch.ts:142-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L142-L143)）
- 子进程环境以 `options.env`（缺省则父进程环境）为底，再叠加入口模式所需变量与可选的 home 目录（[packages/sdk/client/src/launch.ts:145-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L145-L149)）
- 描述串带上 profile 名供错误消息使用，四个可选超时字段只在给定时才出现在规格里（[packages/sdk/client/src/launch.ts:150-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sdk/client/src/launch.ts#L150-L156)）

### packages/sdk/client/src/types.ts

启动与超时选项、通知形状与运行结果的类型声明文件。

- 无运行期机制

### packages/sdk/client/tsconfig.json

本包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区项目引用。

- 无运行期机制
