---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/credentials/authorization
---

# packages/credentials/authorization

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、40 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/credentials/authorization/README.md

该包的说明文档，介绍授权流注册与一次尝试的运行方式。

- 无运行期机制

### packages/credentials/authorization/package.json

该包的 npm 清单，声明入口、子路径导出与依赖。

- `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/credentials/authorization/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/package.json#L14-L15)）
- `exports` 开放根、`./invariant`、`./types`、`./src/*` 与 `./package.json` 五个入口，决定外部能解析到哪些模块（[packages/credentials/authorization/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/package.json#L16-L31)）
- `files` 限定发布进包的文件集合（[packages/credentials/authorization/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/package.json#L32-L37)）

### packages/credentials/authorization/src/index.ts

授权能力接缝的服务定义，实现 `ctx.authorization` 的流注册表与单次尝试生命周期。

- `AuthorizationError` 给授权失败提供带 code 的错误类型（[packages/credentials/authorization/src/index.ts:62-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L62-L67)）
- `AuthorizationDeclinedError` 以 `DECLINED` 码专门表示人拒绝作答（[packages/credentials/authorization/src/index.ts:79-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L79-L84)）
- 服务声明 `static inject = ['credentials']`，凭据存储缺席时该服务不装载（[packages/credentials/authorization/src/index.ts:182-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L182-L184)）
- 构造函数把服务注册到 `ctx` 的 `authorization` 名下（[packages/credentials/authorization/src/index.ts:189-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L189-L191)）
- `registerFlow` 走 `ctx.effect`，同一 key 重复注册抛 `DUPLICATE_FLOW`（[packages/credentials/authorization/src/index.ts:202-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L202-L208)）
- 注册返回的处置器删除流并 abort 该 key 上正在进行的尝试（[packages/credentials/authorization/src/index.ts:209-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L209-L217)）
- `list` 按注册顺序返回所有流的公开视图（[packages/credentials/authorization/src/index.ts:224-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L224-L226)）
- `describe` 对未被认领的 key 返回 `undefined`（[packages/credentials/authorization/src/index.ts:233-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L233-L236)）
- `entry` 把 `running` 表里的存在性投影成对外的 `inFlight` 字段（[packages/credentials/authorization/src/index.ts:239-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L239-L246)）
- `cancel` 从第二次调用撤回某 key 上运行中的尝试（[packages/credentials/authorization/src/index.ts:254-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L254-L256)）
- `begin` 对无流的 key 抛 `NO_FLOW`（[packages/credentials/authorization/src/index.ts:276-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L276-L280)）
- 未指定 method 时取流声明的第一个方法，指定了但流不提供则抛 `UNKNOWN_METHOD`（[packages/credentials/authorization/src/index.ts:281-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L281-L285)）
- 同一 key 已有尝试在跑时抛 `ALREADY_IN_FLIGHT`，不与之合流（[packages/credentials/authorization/src/index.ts:286-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L286-L289)）
- 请求信号在开始前已 abort 时直接返回 `cancelled`，既不占位也不运行流（[packages/credentials/authorization/src/index.ts:290-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L290-L295)）
- 内部建 `AbortController` 并把请求信号的 abort 与 reason 桥接进来，占住 `running` 槽位（[packages/credentials/authorization/src/index.ts:296-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L296-L299)）
- `settlement` 默认取 `failed`，只有 `attempt` 正常返回才被改写为其状态（[packages/credentials/authorization/src/index.ts:300-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L300-L304)）
- `finally` 先摘监听、再释放 key 槽位、最后才发结算事件（[packages/credentials/authorization/src/index.ts:305-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L305-L311)）
- `settle` 逐个调用 `authorization/settled` 监听器，同步抛出与异步拒绝都只记日志（[packages/credentials/authorization/src/index.ts:327-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L327-L345)）
- `INVARIANT` 码的监听器失败被留存，待所有监听器跑完后重抛（[packages/credentials/authorization/src/index.ts:339-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L339-L346)）
- `warnSettledListenerFailure` 把失败的 key 与错误对象写进警告日志（[packages/credentials/authorization/src/index.ts:351-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L351-L354)）
- `attempt` 建一个在 abort 时兑现的 `withdrawn` Promise，用于与流赛跑（[packages/credentials/authorization/src/index.ts:363-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L363-L373)）
- 尝试期间监听 `credentials/record-updated`，只在 key 相符时置位 `observed.committed`（[packages/credentials/authorization/src/index.ts:381-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L381-L384)）
- 传给流的 `notify` 包了 try/catch：交互面渲染失败只丢通知并记日志，不影响尝试（[packages/credentials/authorization/src/index.ts:389-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L389-L399)）
- 传给流的 `prompt` 在拒绝错误是 `AuthorizationDeclinedError` 时置位 `observed.declined` 后原样重抛（[packages/credentials/authorization/src/index.ts:400-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L400-L403)）
- 流与撤回信号赛跑，撤回胜出时立即返回 `cancelled` 并把孤儿运行的后续失败标记为已处理（[packages/credentials/authorization/src/index.ts:405-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L405-L411)）
- 流抛错时，若信号已 abort 或曾观察到拒绝则收敛为 `cancelled`，否则原样上抛（[packages/credentials/authorization/src/index.ts:412-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L412-L418)）
- `finally` 里摘掉记录更新监听（[packages/credentials/authorization/src/index.ts:419-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L419-L421)）
- 本次尝试内没观察到提交就抛 `NOT_COMMITTED`（[packages/credentials/authorization/src/index.ts:422-426](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L422-L426)）
- 再读 `describeRecord` 复核，`configured` 为假时同样抛 `NOT_COMMITTED`，通过才返回 `authorized`（[packages/credentials/authorization/src/index.ts:427-433](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L427-L433)）
- 服务类作为默认导出，供加载器按服务包约定装载（[packages/credentials/authorization/src/index.ts:437](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/index.ts#L437)）

### packages/credentials/authorization/src/invariant.ts

该包的运行期检查伴生插件，注册在 `invariants` 服务上。

- 导出插件名与 `inject = ['invariants']`，决定该伴生何时可装载（[packages/credentials/authorization/src/invariant.ts:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/invariant.ts#L12-L14)）
- 安装器监听 `authorization/settled`，服务不在时报失败（[packages/credentials/authorization/src/invariant.ts:24-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/invariant.ts#L24-L31)）
- 结算时若该 key 仍报 `inFlight` 则报失败（[packages/credentials/authorization/src/invariant.ts:32-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/invariant.ts#L32-L36)）
- `apply` 用包名向 `ctx.invariants` 注册安装器并返回其处置器（[packages/credentials/authorization/src/invariant.ts:44-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/authorization/src/invariant.ts#L44-L45)）

### packages/credentials/authorization/src/types.ts

只含类型的模块，定义方法、通知、提问、结算与条目的词汇表。

- 无运行期机制

### packages/credentials/authorization/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工作区项目引用。

- 无运行期机制
