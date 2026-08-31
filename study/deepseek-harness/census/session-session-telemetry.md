---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-telemetry
---

# packages/session/session-telemetry

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、33 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-telemetry/README.md

session-telemetry 包的说明文档，面向选择后端的部署方与实现后端契约的作者，描述采集模式、记录词汇与脱敏扩展点。

- 无运行期机制

### packages/session/session-telemetry/package.json

包清单，声明模块类型、入口、导出子路径与发布文件集。

- 声明 `"type": "module"`，`main` 指向 `lib/index.js`、`types` 指向 `lib/types/index.d.ts`（[packages/session/session-telemetry/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/package.json#L13-L15)）
- `exports` 暴露 `.`、`./invariant`、`./src/*` 与 `./package.json`（[packages/session/session-telemetry/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.d.ts`（[packages/session/session-telemetry/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/package.json#L28-L32)）

### packages/session/session-telemetry/src/coordinator.ts

采集协调器，由具体后端在自己的构造函数里组合，负责订阅会话事件、做记录投影与脱敏，并把记录交给后端。

- 模块级 `handoffCursor` 以 `WeakMap<Session, number>` 记录每个会话已交付的最高 seq，条目随会话消亡（[packages/session/session-telemetry/src/coordinator.ts:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L43)）
- 协调器持有本 fiber 已收养会话集合与每会话的首分片键集合，后者用弱引用表保存（[packages/session/session-telemetry/src/coordinator.ts:66-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L66-L68)）
- `live` 模式下监听 `session/created` 收养新会话（[packages/session/session-telemetry/src/coordinator.ts:80-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L80-L82)）
- 监听 `session/disposed`：若该会话仍在收养集合内则移除并交付一条 `shutdown` 运维记录（[packages/session/session-telemetry/src/coordinator.ts:85-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L85-L90)）
- 监听 `session/event`，在容错包裹内对每条追加事件做采集（[packages/session/session-telemetry/src/coordinator.ts:91-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L91-L95)）
- 监听 `session/flush` 并返回 void，不把后端 flush 的 promise 交回被 await 的并行监听（[packages/session/session-telemetry/src/coordinator.ts:98-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L98-L102)）
- 监听 `agent/error` 总线事件并转成运维记录（[packages/session/session-telemetry/src/coordinator.ts:103-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L103-L107)）
- 构造时遍历 `ctx.sessions.list()` 收养已存在的会话，热重载后不依赖 `session/created` 重放（[packages/session/session-telemetry/src/coordinator.ts:108-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L108-L110)）
- 注册 dispose effect：先为仍被收养的会话交付 `shutdown` 记录，再 await 后端 `shutdown()`，失败只记 warn 不抛出（[packages/session/session-telemetry/src/coordinator.ts:112-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L112-L125)）
- `captureSession` 从交付游标（缺失时取 `session.firstLiveSeq - 1`）开始遍历规范日志，`throughSeq` 之后的事件停止，游标内事件只喂投影、游标外事件才采集，且逐事件容错（[packages/session/session-telemetry/src/coordinator.ts:138-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L138-L149)）
- `adopt` 对已收养会话直接返回，否则加入集合并重放其日志（[packages/session/session-telemetry/src/coordinator.ts:166-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L166-L170)）
- `track` 只把 `assistant/chunk` 的 `turn:step` 键写入已见集合而不交付记录（[packages/session/session-telemetry/src/coordinator.ts:173-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L173-L177)）
- `captureEvent` 对 `assistant/chunk` 做固定投影：每个 `(turn, step)` 只放行首个分片，其余直接丢弃且不推进游标（[packages/session/session-telemetry/src/coordinator.ts:180-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L180-L190)）
- `captureEvent` 组装 ledger 记录：事件时间、映射后的 severity、身份属性，以及对 `event.data` 的 `structuredClone` 深拷贝，并带上 `event.seq`（[packages/session/session-telemetry/src/coordinator.ts:191-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L191-L202)）
- `redact` 对每条外发记录跑 `session-telemetry/record` 瀑布，最内层 `next` 原样返回记录（[packages/session/session-telemetry/src/coordinator.ts:213-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L213-L215)）
- `deliver` 先调用后端 `emit`，成功返回后才把该记录的 seq 写入交付游标（[packages/session/session-telemetry/src/coordinator.ts:218-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L218-L221)）
- `hintFlush` 仅对已收养的会话调用后端可选的 `flush?.()`（[packages/session/session-telemetry/src/coordinator.ts:224-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L224-L226)）
- `relayAgentError` 把一次 `agent/error` 转为 `ops` 通道、`error` 级别的记录，属性含 `telemetry.op`、会话与 agent id、错误名与 turn/step，body 为归一化错误明细，且不带 seq（[packages/session/session-telemetry/src/coordinator.ts:229-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L229-L247)）
- `seen` 按会话惰性创建首分片键集合（[packages/session/session-telemetry/src/coordinator.ts:250-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L250-L254)）
- `contain` 捕获采集步骤抛出的异常并转为 warn 日志，异常不会外溢到其他监听者（[packages/session/session-telemetry/src/coordinator.ts:261-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L261-L267)）
- `shutdownRecord` 构造 `ops` 通道、`info` 级别、body 为 `{ op: 'shutdown' }` 的会话退出标记（[packages/session/session-telemetry/src/coordinator.ts:274-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L274-L282)）
- `severityOf` 把 `tool/result` 内容块的 `isError` 与 `turn/end` 的 `reason.kind === 'error'` 映射为 `error`，其余事件类型走 default 返回 `info`（[packages/session/session-telemetry/src/coordinator.ts:285-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L285-L297)）
- `errorDetail` 把任意抛出值归一为 `{ name, message }`，非 Error 值先包成 Error（[packages/session/session-telemetry/src/coordinator.ts:300-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L300-L303)）
- `identityOf` 组装 `session.id`/`event.type`/`event.seq`，并在会话头存在时补上 `session.cwd`、`session.parent_id`、`session.seed_length`（[packages/session/session-telemetry/src/coordinator.ts:306-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/coordinator.ts#L306-L319)）

### packages/session/session-telemetry/src/index.ts

遥测能力的服务定义入口，声明后端契约、记录词汇与脱敏瀑布事件，并再导出采集协调器。

- 抽象基类 `SessionTelemetryBackend` 在构造时以 `super(ctx, 'sessionTelemetry')` 把实现注册到该服务键上，重复注册按 cordis 行为抛错（[packages/session/session-telemetry/src/index.ts:147-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/index.ts#L147-L150)）
- 基类把 `flush` 声明为可选方法而 `emit`/`shutdown`/`sharing` 为抽象成员，决定协调器可调用与不可调用的后端面（[packages/session/session-telemetry/src/index.ts:159-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/index.ts#L159-L174)）

### packages/session/session-telemetry/src/invariant.ts

包自带的不变量伴生插件，向不变量服务登记包名。

- `inject = ['invariants']` 要求不变量服务先就绪，伴生插件才能启动（[packages/session/session-telemetry/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/invariant.ts#L15)）
- `apply` 以空安装器向 `ctx.invariants` 注册包名并返回注册的 disposer，运行期不做任何检查（[packages/session/session-telemetry/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/invariant.ts#L23)、[packages/session/session-telemetry/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry/src/invariant.ts#L30-L31)）

### packages/session/session-telemetry/tsconfig.json

包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制
