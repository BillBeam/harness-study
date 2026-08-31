---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-telemetry-otel
---

# packages/session/session-telemetry-otel

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、30 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-telemetry-otel/README.md

该后端包的说明文档，面向选择模式、配置导出端点或追踪外发内容的部署方。

- 无运行期机制

### packages/session/session-telemetry-otel/package.json

包清单，声明模块类型、入口、导出子路径、发布文件集与所依赖的 OTel SDK 包。

- 声明 `"type": "module"`，`main` 指向 `lib/index.js`、`types` 指向 `lib/types/index.d.ts`（[packages/session/session-telemetry-otel/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/package.json#L13-L15)）
- `exports` 暴露 `.`、`./invariant`、`./src/*` 与 `./package.json`（[packages/session/session-telemetry-otel/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.d.ts`（[packages/session/session-telemetry-otel/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/package.json#L28-L32)）
- `dependencies` 固定 OTel API、api-logs、OTLP/HTTP 日志导出器、resources 与 sdk-logs 的版本范围，这些包构成运行期导出管道（[packages/session/session-telemetry-otel/package.json:34-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/package.json#L34-L42)）

### packages/session/session-telemetry-otel/src/index.ts

该包唯一的插件入口，实现遥测服务定义的后端，做模式解析与配置校验、搭建 OTel 日志管道并组合采集协调器。

- 用 `createRequire` 读取本包 `package.json` 的 `version`，作为 instrumentation scope 版本（[packages/session/session-telemetry-otel/src/index.ts:41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L41)）
- 定义 `SessionTelemetryMode` 三值枚举，并把默认模式定为 `DISABLED`（[packages/session/session-telemetry-otel/src/index.ts:44-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L44-L51)）
- `resolveMode` 补默认值并对未知运行期值走 `assertNever` 抛错，在读取传输配置之前失败（[packages/session/session-telemetry-otel/src/index.ts:58-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L58-L73)）
- `sharingStatusFor` 把模式映射成服务定义的 `full`/`feedback-only`/`disabled` 共享披露值（[packages/session/session-telemetry-otel/src/index.ts:76-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L76-L84)）
- `Config` 校验器只校验顶层字段，`exporter`/`processor` 以 `z.any()` 原样透传给 SDK（[packages/session/session-telemetry-otel/src/index.ts:120-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L120-L125)）
- 默认关闭超时为 3000 毫秒，且定时器延迟上限固定为 2147483647（[packages/session/session-telemetry-otel/src/index.ts:128-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L128-L132)）
- `SEVERITY` 表把 info/warn/error 三级映射到 OTel 的 `severityNumber` 与 `severityText`（[packages/session/session-telemetry-otel/src/index.ts:135-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L135-L139)）
- 类声明 `static inject = ['sessions']` 与 `static Config`，决定插件启动前需要的服务与配置校验（[packages/session/session-telemetry-otel/src/index.ts:148-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L148-L149)）
- `DISABLED` 分支不构造任何 SDK 对象，把直接 emit 换成丢弃函数，只监听 `session/event` 并在 `feedback/record` 时打 warn 后返回（[packages/session/session-telemetry-otel/src/index.ts:160-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L160-L168)）
- 上传模式下 `exporter.url` 缺失或为空串时在插件加载期抛错（[packages/session/session-telemetry-otel/src/index.ts:170-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L170-L173)）
- URL 解析失败被重新包装为配置错误抛出（[packages/session/session-telemetry-otel/src/index.ts:174-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L174-L180)）
- 端点协议必须是 `http:` 或 `https:`，否则抛错（[packages/session/session-telemetry-otel/src/index.ts:181-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L181-L183)）
- `processor.maxExportBatchSize` 若给出则必须是正整数，否则在加载期抛错（[packages/session/session-telemetry-otel/src/index.ts:188-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L188-L191)）
- `shutdownTimeoutMillis` 取配置值或默认值，并要求是不超过定时器上限的有限正数（[packages/session/session-telemetry-otel/src/index.ts:192-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L192-L196)）
- 构造 `LoggerProvider`，Resource 携带 `service.name`/`service.version` 与匿名 `user.id`，处理器为 `BatchLogRecordProcessor` 并把校验过的 `exporter` 配置整体交给 `OTLPLogExporter`（[packages/session/session-telemetry-otel/src/index.ts:197-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L197-L218)）
- 取两个 instrumentation scope 的 logger，把 ledger 与 ops 两个通道分开（[packages/session/session-telemetry-otel/src/index.ts:219-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L219-L220)）
- `enqueue` 按 `record.channel` 选 logger，并把 `time` 映射成 timestamp/observedTimestamp、severity 映射成 SDK 字段、`body` 与 `attributes` 原样透传（[packages/session/session-telemetry-otel/src/index.ts:221-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L221-L232)）
- `FULL` 模式把直接 emit 接到 `enqueue`，并以 `live` 模式组合采集协调器（[packages/session/session-telemetry-otel/src/index.ts:237-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L237-L241)）
- `FEEDBACK_ONLY` 模式把直接 emit 换成丢弃函数、以 `on-demand` 组合协调器，并在 `feedback/record` 事件与规范日志中同一对象相等时才调用 `captureSession(session, event.seq)`，否则打 warn 返回（[packages/session/session-telemetry-otel/src/index.ts:242-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L242-L252)）
- 服务方法 `emit` 一律转交内部 `directEmit`，因此非 `FULL` 模式下的直接调用是空操作（[packages/session/session-telemetry-otel/src/index.ts:261-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L261-L263)）
- `shutdown` 在无 provider 时立即 resolve，否则用 `Promise.race` 让 provider 关闭与超时拒绝竞争，并在 finally 清定时器（[packages/session/session-telemetry-otel/src/index.ts:283-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L283-L298)）
- 以默认导出暴露后端类，供 Loader 按服务插件形式加载（[packages/session/session-telemetry-otel/src/index.ts:301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/index.ts#L301)）

### packages/session/session-telemetry-otel/src/invariant.ts

包自带的不变量伴生插件，向不变量服务登记包名。

- `inject = ['invariants']` 要求不变量服务先就绪，伴生插件才能启动（[packages/session/session-telemetry-otel/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/invariant.ts#L15)）
- `apply` 以空安装器向 `ctx.invariants` 注册包名并返回注册的 disposer，运行期不做任何检查（[packages/session/session-telemetry-otel/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/invariant.ts#L22)、[packages/session/session-telemetry-otel/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-telemetry-otel/src/invariant.ts#L29-L30)）

### packages/session/session-telemetry-otel/tsconfig.json

包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制
