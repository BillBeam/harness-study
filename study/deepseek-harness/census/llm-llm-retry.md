---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/llm/llm-retry
---

# packages/llm/llm-retry

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、52 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/llm/llm-retry/README.md

包的英文说明文档，描述该重试执行器挂载方式、可观察到的事件与已知限制，供使用者和维护者阅读。

- 无运行期机制

### packages/llm/llm-retry/package.json

npm 包清单，声明包名、模块入口、导出子路径与依赖关系。

- `"type": "module"` 与 `main` / `types` 指定该包以 ESM 方式加载，运行期入口为 `lib/index.js`（[packages/llm/llm-retry/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/package.json#L13-L15)）
- `exports` 开放三个可解析子路径：`.` 指向 `lib/index.js`、`./invariant` 指向 `lib/invariant.js`、`./types` 指向 `lib/types/types.js`，另放行 `./package.json`（[packages/llm/llm-retry/package.json:16-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/package.json#L16-L30)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`（[packages/llm/llm-retry/package.json:31-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/package.json#L31-L36)）
- `peerDependencies` 要求宿主提供 brand、agent、invariants、llm、session、timeout 与 cordis，运行期由宿主解析（[packages/llm/llm-retry/package.json:38-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/package.json#L38-L46)）
- `dependencies` 只自带 schemastery，作为 Config 运行期校验的实现（[packages/llm/llm-retry/package.json:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/package.json#L47-L49)）

### packages/llm/llm-retry/src/brand.ts

声明重试链标识 `RetryId` 的品牌类型和同名转换函数，被事件负载类型和插件主体引用。

- 无运行期机制

### packages/llm/llm-retry/src/history.ts

从会话事件流里回溯某个仍处于打开状态的模型请求步所用的 provider，被插件的不变量伴生模块使用。

- 倒序定位与给定 turn/step 匹配的最后一个 `step/start`；找不到，或其后已出现 `step/end`/`turn/end`（即该步已闭合）时返回 undefined（[packages/llm/llm-retry/src/history.ts:19-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/history.ts#L19-L25)）
- 从事件序列末尾向前扫描，取最近一条 `request/header` 的 `header.config.provider` 作为该步生效的 provider，都没有则返回 undefined（[packages/llm/llm-retry/src/history.ts:26-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/history.ts#L26-L32)）

### packages/llm/llm-retry/src/index.ts

包的主体：一个函数插件，在 agent 循环的 `agent/request-error` 瀑布式扩展点上按 provider 解析出的重试策略调度重试，并在等待前先把重试写入会话日志。

- 插件以 `llm-retry` 为名注册，并声明注入 `agents` 服务（[packages/llm/llm-retry/src/index.ts:20-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L20-L21)）
- `Config` 是空对象 schema，本插件自身不接受任何配置项（[packages/llm/llm-retry/src/index.ts:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L24-L27)）
- `validateConfig` 在装载时对任何多余键抛错，键名为 `retryPolicy` 时给出「策略属于各 provider 配置」的专门错误（[packages/llm/llm-retry/src/index.ts:29-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L29-L36)）
- `settleDownstream` 把下游 `next()` 的抛错捕获成 `{ type: 'error' }` 结果，使下游失败不会中断本监听器（[packages/llm/llm-retry/src/index.ts:48-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L48-L56)）
- `localDelay` 按 `initialDelayMs * 2^(retry-1)` 计算退避、指数上限截到 1024、先夹到 `maxDelayMs`，再乘以以 `jitterRatio` 为半宽的对称抖动因子并再次夹到 `maxDelayMs`（[packages/llm/llm-retry/src/index.ts:58-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L58-L63)）
- `retryPolicyKey` 把策略序列化成字符串键：always 模式只含模式与三项退避参数，normal 模式另含 `maxRetries` 与排序后的 `retryableCodes`（[packages/llm/llm-retry/src/index.ts:65-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L65-L76)）
- `cancellableDelay` 在信号已中止时立即返回 false；否则起定时器，正常到点返回 true，中止时清除定时器并返回 false（[packages/llm/llm-retry/src/index.ts:78-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L78-L91)）
- `apply` 用 `internals.random ?? Math.random` 取抖动随机源，建立插件生命周期的 AbortController 与在途恢复任务集合（[packages/llm/llm-retry/src/index.ts:100-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L100-L109)）
- `backoff` 把调用方信号与插件生命周期信号融合，已中止则直接返回 undefined 不调度（[packages/llm/llm-retry/src/index.ts:124-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L124-L125)）
- 按模式构造 `llm/retry` 负载：normal 携带 `maxRetries`，always 省略该字段，两者都带 retryId、turn、step、provider、policyKey、retry、delayMs 与 failure（[packages/llm/llm-retry/src/index.ts:126-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L126-L149)）
- 先向会话追加 `llm/retry` 事件再进入可取消等待，等待被中止则返回 undefined 不重试（[packages/llm/llm-retry/src/index.ts:150-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L150-L151)）
- 等待完成后追加 `llm/retry-started` 事件，并向瀑布返回 `{ kind: 'retry' }` 让循环在同一开放轮次内重跑该步（[packages/llm/llm-retry/src/index.ts:152-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L152-L153)）
- 未解析出 provider 策略时直接 `next()` 委派下游（[packages/llm/llm-retry/src/index.ts:160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L160)）
- always 模式先等下游恢复结算，结算后若信号已中止则放弃；下游抛错只记 warn 日志并继续（[packages/llm/llm-retry/src/index.ts:161-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L161-L173)）
- always 模式下游若返回 `retry` 决策则直接采用该决策，不再走本地调度（[packages/llm/llm-retry/src/index.ts:174-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L174-L176)）
- normal 模式下失败码不在 `retryableCodes` 中时委派下游（[packages/llm/llm-retry/src/index.ts:177-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L177-L179)）
- 从会话事件中按 turn、step、provider、policyKey 四元组回溯上一条 `llm/retry`，据此得到已用次数（[packages/llm/llm-retry/src/index.ts:181-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L181-L189)）
- normal 模式在已用次数达到 `maxRetries` 时委派下游，不再重试（[packages/llm/llm-retry/src/index.ts:190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L190)）
- 本次重试号为上一次加一；retryId 沿用同一条链上的既有值，链首则用 `randomUUID()` 新铸（[packages/llm/llm-retry/src/index.ts:191-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L191-L192)）
- provider 给出的 `providerRetryAfterMs` 为有限正数时优先采用；超过 `maxDelayMs` 时 normal 模式委派下游、always 模式改用本地退避；其余情况一律用本地退避（[packages/llm/llm-retry/src/index.ts:193-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L193-L205)）
- 以 `ctx.on('agent/request-error', ...)` 注册瀑布监听器，并把每次恢复登记进在途集合（[packages/llm/llm-retry/src/index.ts:210-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L210-L219)）
- 生命周期已中止时监听器立即返回 undefined，使被瀑布提前捕获的旧回调在插件卸载后不再进入下游策略（[packages/llm/llm-retry/src/index.ts:217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L217)）
- 注册的卸载效果依次移除监听器、中止生命周期信号（打断进行中的退避等待）、并等待所有在途恢复结算（[packages/llm/llm-retry/src/index.ts:221-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/index.ts#L221-L225)）

### packages/llm/llm-retry/src/invariant.ts

包自带的不变量伴生插件，把已加载会话与新追加事件中的 `llm/retry`、`llm/retry-started` 记录逐条对着会话日志校验。

- 声明伴生插件名 `llm-retry-invariant` 并注入 `invariants` 服务（[packages/llm/llm-retry/src/invariant.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L14-L16)）
- `validateFailure` 要求 failure 为对象、`message` 与 `code` 为非空字符串（[packages/llm/llm-retry/src/invariant.ts:19-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L19-L29)）
- `status` 出现时必须是 100 到 599 的整数，`providerRetryAfterMs` 出现时必须是有限正数，`requestId` 出现时必须是非空字符串（[packages/llm/llm-retry/src/invariant.ts:30-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L30-L41)）
- `validateRetry` 要求 `retryId` 非空、`retry` 为不小于 1 的安全整数、`provider` 与 `policyKey` 非空（[packages/llm/llm-retry/src/invariant.ts:50-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L50-L64)）
- 按模式分支：normal 要求 `maxRetries` 为正安全整数且 `retry` 不超过它，always 要求负载不带 `maxRetries`，其它模式值直接判失败（[packages/llm/llm-retry/src/invariant.ts:65-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L65-L78)）
- `delayMs` 必须是落在 0 到 `MAX_TIMER_DELAY_MS` 之间的有限数（[packages/llm/llm-retry/src/invariant.ts:79-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L79-L82)）
- 事件必须落在打开的轮次里，且负载 `turn` 等于该打开轮次号（[packages/llm/llm-retry/src/invariant.ts:84-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L84-L91)）
- 事件必须落在打开的步里，且负载的 turn/step 等于该打开步（[packages/llm/llm-retry/src/invariant.ts:93-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L93-L100)）
- 负载 `provider` 必须等于 `providerForOpenStep` 由请求头推出的该步实际 provider（[packages/llm/llm-retry/src/invariant.ts:101-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L101-L104)）
- 同一 turn/step/provider/policyKey 链上的 `retry` 必须恰为上一条加一（[packages/llm/llm-retry/src/invariant.ts:106-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L106-L115)）
- 同一条链必须保持同一个 `retryId`；而新开的链所用的 `retryId` 不得已被别的链占用（[packages/llm/llm-retry/src/invariant.ts:116-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L116-L123)）
- `validateStarted` 要求 `retryId` 非空，且历史中存在同 retryId、同 retry 号的已调度 `llm/retry`（[packages/llm/llm-retry/src/invariant.ts:132-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L132-L138)）
- `llm/retry-started` 的 turn/step 必须与其对应的调度记录一致，且同一次调度不得重复出现启动记录（[packages/llm/llm-retry/src/invariant.ts:139-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L139-L145)）
- `validateSession` 逐条遍历会话事件，对每条重试记录只用其之前的事件前缀作为历史来校验（[packages/llm/llm-retry/src/invariant.ts:149-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L149-L154)）
- 安装器先校验所有已存在会话，再挂 `session/created` 与 `internal/dispatch` 的 `session/event` 全局监听，对新追加的两类事件即时校验（[packages/llm/llm-retry/src/invariant.ts:157-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L157-L166)）
- `apply` 用包名向 `ctx.invariants` 注册安装器并返回其卸载器（[packages/llm/llm-retry/src/invariant.ts:173-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/src/invariant.ts#L173-L174)）

### packages/llm/llm-retry/src/types.ts

浏览器可用的类型模块，声明 `llm/retry` 与 `llm/retry-started` 两个会话事件的负载类型，并通过声明合并把它们并入 `SessionEventMap`。

- 无运行期机制

### packages/llm/llm-retry/tsconfig.json

包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 并引用工作区依赖工程。

- 无运行期机制

### packages/llm/llm-retry/tsdown.config.ts

tsdown 打包配置，决定该包发布出的两个运行期产物文件。

- 第一个构建条目把 `lib/types/index.js` 打成 `lib/index.js`（即 package.json `.` 导出所指），格式 esm、平台 node、目标 es2024，关闭固定扩展名与 dts 生成，且不清空输出目录（[packages/llm/llm-retry/tsdown.config.ts:5-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/tsdown.config.ts#L5-L14)）
- 第二个构建条目以同样的设置把 `lib/types/invariant.js` 单独打成 `lib/invariant.js`，使不变量伴生插件成为与主插件互不牵连的独立产物（[packages/llm/llm-retry/tsdown.config.ts:15-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-retry/tsdown.config.ts#L15-L24)）
