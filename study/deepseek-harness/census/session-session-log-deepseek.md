---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-log-deepseek
---

# packages/session/session-log-deepseek

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、32 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-log-deepseek/README.md

该包的说明文档，描述 `dsh_session_log` 请求字段、接受水位与重传语义。

- 无运行期机制

### packages/session/session-log-deepseek/package.json

该包的 npm 清单，声明入口、发布文件与依赖。

- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`、`./types` 解析到 `lib/types/types.js`，并放开 `./src/*` 与 `./package.json`（[packages/session/session-log-deepseek/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/package.json#L16-L31)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/session/session-log-deepseek/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/package.json#L14-L15)）
- `files` 把发布产物限定为两个入口 JS 加 `lib/types/**` 下的 `.js` 与 `.d.ts`（[packages/session/session-log-deepseek/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/package.json#L32-L37)）
- `dependencies` 声明运行期依赖 `@deepseek-ai/schemastery`，配置校验由它提供（[packages/session/session-log-deepseek/package.json:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/package.json#L39-L41)）

### packages/session/session-log-deepseek/src/index.ts

插件主入口，向 DeepSeek 请求扩展注册表登记 `dsh_session_log` 字段，并从会话日志折叠已接受水位。

- `inject` 声明依赖 `deepseekLlmApiExtensions` 与 `sessions` 两个服务（[packages/session/session-log-deepseek/src/index.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L19)）
- `Config` 校验模式把 `enabled` 默认置为 `false`（[packages/session/session-log-deepseek/src/index.ts:28-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L28-L30)）
- 进程内 `WeakMap<Session, AcceptanceFold>` 记录已扫描事件数与水位，使折叠随会话对象生命周期回收（[packages/session/session-log-deepseek/src/index.ts:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L32-L37)）
- `acceptedThrough` 从上次扫描位置继续增量扫描，未扫过任何接受事件时返回 `-1`（[packages/session/session-log-deepseek/src/index.ts:44-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L44-L49)）
- 扫描中遇到 `sessionId` 非法字符串、`throughSeq` 非安全非负整数或 `throughSeq >= event.seq` 的接受事件时抛出错误（[packages/session/session-log-deepseek/src/index.ts:52-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L52-L56)）
- 只有 `event.data.sessionId` 等于当前会话 id 的接受事件参与折叠，分叉继承来的父会话水位被跳过（[packages/session/session-log-deepseek/src/index.ts:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L57)）
- 水位取匹配事件 `throughSeq` 的最大值，乱序接受不会让游标回退（[packages/session/session-log-deepseek/src/index.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L58)）
- 扫描结束后把新的 `scannedEvents`/`throughSeq` 写回折叠表，后续调用只扫新增事件（[packages/session/session-log-deepseek/src/index.ts:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L60)）
- `apply` 在 `config.enabled !== true` 时直接返回，不注册任何请求字段（[packages/session/session-log-deepseek/src/index.ts:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L70)）
- 启用后向 `ctx.deepseekLlmApiExtensions` 登记 `dsh_session_log` 的 `prepare` 回调，把该字段挂到官方 API 请求上（[packages/session/session-log-deepseek/src/index.ts:71-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L71-L72)）
- 请求无 `sessionId`、或该 id 查不到活跃会话时 `prepare` 返回 `undefined`，请求不带该字段（[packages/session/session-log-deepseek/src/index.ts:74-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L74-L77)）
- 快照 `session.events` 并以 `snapshot.length - 1` 作为 `throughSeq`，空日志（`throughSeq < 0`）同样返回 `undefined`（[packages/session/session-log-deepseek/src/index.ts:79-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L79-L81)）
- 上传内容取水位之后的连续后缀 `snapshot.slice(afterSeq + 1)`（[packages/session/session-log-deepseek/src/index.ts:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L82)）
- 字段值固定为 `version: 1`，携带 `session.header`、`afterSeq`、`throughSeq` 与后缀事件数组（[packages/session/session-log-deepseek/src/index.ts:83-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L83-L89)）
- `accept()` 回调向会话日志追加 `session-log-deepseek/delivery-accepted`，记录本次会话 id 与 `throughSeq`；未被调用时不产生任何水位记录（[packages/session/session-log-deepseek/src/index.ts:92-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L92-L93)）

### packages/session/session-log-deepseek/src/invariant.ts

该包的不变量伴随插件，对已恢复、新建与新追加的接受水位事件做运行期校验。

- `inject` 声明依赖 `invariants` 服务（[packages/session/session-log-deepseek/src/invariant.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L13)）
- `validateDeliveryAccepted` 用 `parentSession`、`seedLength` 与 `event.seq < seedLength` 判定该事件是否为分叉继承而来（[packages/session/session-log-deepseek/src/invariant.ts:18-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L18-L20)）
- 非继承事件的 `sessionId` 与所在会话 id 不一致时报告失败（[packages/session/session-log-deepseek/src/invariant.ts:21-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L21-L23)）
- `throughSeq` 非安全整数、为负或不小于自身 `seq` 时报告失败并带上实际值（[packages/session/session-log-deepseek/src/invariant.ts:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L24-L26)）
- `validateSession` 遍历一个会话的全部事件，只对 `session-log-deepseek/delivery-accepted` 类型做校验（[packages/session/session-log-deepseek/src/invariant.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L30-L34)）
- `install` 先对 `ctx.sessions.list()` 里已存在的会话逐个校验（[packages/session/session-log-deepseek/src/invariant.ts:44-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L44-L45)）
- 以 `global: true` 监听 `session/created`，对每个新建会话再跑一次全量校验（[packages/session/session-log-deepseek/src/invariant.ts:46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L46)）
- 以 `global: true` 监听 `internal/dispatch`，筛出 `session/event` 派发并对新追加事件即时校验（[packages/session/session-log-deepseek/src/invariant.ts:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L47-L49)）
- `install` 上附加 `inject: ['sessions']`，安装器在会话服务就绪后才运行（[packages/session/session-log-deepseek/src/invariant.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L50)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其 disposer（[packages/session/session-log-deepseek/src/invariant.ts:57-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/invariant.ts#L57-L58)）

### packages/session/session-log-deepseek/src/types.ts

只含类型的文件：声明 `dsh_session_log` 字段的线上结构，并通过声明合并把该字段与 `session-log-deepseek/delivery-accepted` 事件加入两张可扩展映射表。

- 无运行期机制

### packages/session/session-log-deepseek/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工程引用。

- 无运行期机制
