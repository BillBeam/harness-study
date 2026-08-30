---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/workflow/workflow-worker-thread
---

# packages/workflow/workflow-worker-thread

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 14 个文件、152 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/workflow/workflow-worker-thread/README.md

worker-thread 工作流引擎包的说明文档，描述配置字段、运行时序、取消与处置语义，供使用者与维护者阅读。

- 无运行期机制

### packages/workflow/workflow-worker-thread/package.json

该包的 npm 清单，声明模块类型、入口映射与发布内容。

- `"type": "module"` 与 `main` 把包按 ESM 解析，默认入口指向 `lib/index.js`（[packages/workflow/workflow-worker-thread/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/package.json#L13-L15)）
- `exports` 暴露三个运行期入口：根入口、`./invariant`、`./worker`，其中 `./worker` 解析到 CommonJS 的 `lib/worker.cjs`（[packages/workflow/workflow-worker-thread/package.json:16-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/package.json#L16-L28)）
- `./src/*` 把源码目录整体透出，未构建的消费方可直接加载 `.ts` 文件（[packages/workflow/workflow-worker-thread/package.json:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/package.json#L29)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js`、`lib/worker.cjs` 与类型声明（[packages/workflow/workflow-worker-thread/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/package.json#L32-L37)）

### packages/workflow/workflow-worker-thread/src/host.ts

一次工作流运行的宿主侧实现 `WorkerRun`：创建 worker、代理子代理启动、决定终局结果并负责处置，被 `src/index.ts` 的 `start()` 构造。

- `workerSpawnEnv` 只在 win32 下注入 `TMP`/`TEMP`（取 `os.tmpdir()`），其余宿主环境变量一律不传给 worker（[packages/workflow/workflow-worker-thread/src/host.ts:45-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L45-L54)）
- 传入 tsconfig 路径时额外注入 `TSX_TSCONFIG_PATH`（[packages/workflow/workflow-worker-thread/src/host.ts:55-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L55-L56)）
- 以 `import.meta.url` 是否以 `.ts` 结尾区分构建态：构建态直接用同目录 `worker.cjs` 作为 worker 入口（[packages/workflow/workflow-worker-thread/src/host.ts:69-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L69-L70)）
- 源码态生成一段 data-URL 引导脚本，先注册 tsx 的 cjs/esm 转换再动态 import `worker.ts`（[packages/workflow/workflow-worker-thread/src/host.ts:72-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L72-L85)）
- 两种入口都以 `init` 作 `workerData`、用清空的 `execArgv` 和上面的洗净环境启动（[packages/workflow/workflow-worker-thread/src/host.ts:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L70)、[packages/workflow/workflow-worker-thread/src/host.ts:86-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L86-L89)）
- 构造时建立永不 reject 的 `result` promise，并保存其 resolve（[packages/workflow/workflow-worker-thread/src/host.ts:144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L144)）
- 立即 `new Worker(entry, options)`，`workerData` 经结构化克隆传入（[packages/workflow/workflow-worker-thread/src/host.ts:148-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L148-L149)）
- 订阅 `message`/`error`/`messageerror`，后两者转成 worker 死亡处理（[packages/workflow/workflow-worker-thread/src/host.ts:150-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L150-L153)）
- `exit` 置 `workerGone` 并以退出码组装错误消息走死亡路径（[packages/workflow/workflow-worker-thread/src/host.ts:154-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L154-L157)）
- 传入的信号若已 abort 则构造期立刻取消；否则挂一次性 abort 监听触发取消（[packages/workflow/workflow-worker-thread/src/host.ts:158-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L158-L168)）
- `cancel()` 在已落定、终局已认领或已有取消原因时直接返回（[packages/workflow/workflow-worker-thread/src/host.ts:187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L187)）
- 首个取消原因被记录，向 worker 发 `Cancel` 消息，并 abort 所有子代共享的控制器（[packages/workflow/workflow-worker-thread/src/host.ts:188-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L188-L190)）
- 取消同时装载 `disposeGraceMs` 定时器：到期认领终局、补齐悬空 agent-end、以 `cancelled` 强制落定并 `worker.terminate()`（[packages/workflow/workflow-worker-thread/src/host.ts:191-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L191-L201)）
- 宽限定时器 `unref()`，不会撑住进程（[packages/workflow/workflow-worker-thread/src/host.ts:203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L203)）
- `dispose()` 以一个已认领的 promise 做幂等，重入者 join 同一次处置（[packages/workflow/workflow-worker-thread/src/host.ts:221-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L221-L227)）
- 处置先摘掉外部信号监听、取消运行、并立即开始清理所有已注册子代（[packages/workflow/workflow-worker-thread/src/host.ts:229-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L229-L236)）
- 用 `Promise.race` 让"结果 + 子代静默"与 `disposeGraceMs` 睡眠竞争，超时即放弃等待（[packages/workflow/workflow-worker-thread/src/host.ts:237-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L237-L243)）
- 无条件 `worker.terminate()` 之后再做一次幸存子代清扫（[packages/workflow/workflow-worker-thread/src/host.ts:244-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L244-L245)）
- `post()` 在线程已退出或已观察到死亡时丢弃消息，`postMessage` 抛错只记 warn（[packages/workflow/workflow-worker-thread/src/host.ts:255-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L255-L266)）
- 观察到 worker 死亡后，所有后到消息一律丢弃（[packages/workflow/workflow-worker-thread/src/host.ts:273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L273)）
- 收到 `Ready` 立即回 `Go`，构成启动握手（[packages/workflow/workflow-worker-thread/src/host.ts:275-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L275-L277)）
- `phase`/`log` 叙述只在尚未取消时转发给观察者（[packages/workflow/workflow-worker-thread/src/host.ts:278-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L278-L288)）
- `agent-start` 写入按 seq 的存活账本并转发观察者（[packages/workflow/workflow-worker-thread/src/host.ts:289-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L289-L292)）
- `agent-end` 不受取消抑制，统一走配对闸门（[packages/workflow/workflow-worker-thread/src/host.ts:293-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L293-L299)）
- `child-start`/`child-dispose`/`result` 分派到对应处理，未知标签走 `assertNever`（[packages/workflow/workflow-worker-thread/src/host.ts:300-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L300-L312)）
- `childAdmissionFailure()` 按"已取消 / worker 已亡 / 终局已认领"三种状态给出拒绝理由文本（[packages/workflow/workflow-worker-thread/src/host.ts:316-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L316-L327)）
- 子代启动请求先过准入检查，不通过则回 `ChildStartError` 且不启动任何子代（[packages/workflow/workflow-worker-thread/src/host.ts:330-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L330-L337)）
- 每个被接受的 `child-start` 让 `hostStarted` 自增，该计数是强制终止路径上报的 `agentsStarted`（[packages/workflow/workflow-worker-thread/src/host.ts:338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L338)）
- 启动任务登记进 `pendingStarts`，成功失败都在结束时退出该集合（[packages/workflow/workflow-worker-thread/src/host.ts:339-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L339-L345)）
- `startChild` 通过 `subagents.start(provider, …)` 启动子代，携带 prompt 文本块、运行的父 agent、共享 abort 信号，并按需带上 `outputSchema` 与 provider/model 覆盖（[packages/workflow/workflow-worker-thread/src/host.ts:352-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L352-L365)）
- provider 启动抛错时回 `ChildStartError`，文本优先用准入失败理由、否则用渲染后的异常（[packages/workflow/workflow-worker-thread/src/host.ts:366-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L366-L373)）
- 启动成功后再查一次准入，若期间已关闭则回错误并把刚起的子代 dispose 掉（[packages/workflow/workflow-worker-thread/src/host.ts:374-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L374-L383)）
- 子代登记进 `children` 映射，后续处置以 callId 为键（[packages/workflow/workflow-worker-thread/src/host.ts:385-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L385-L386)）
- 子代结果经 `snapshotJsonValue` 投影成 output/structured/stopReason 的 JSON 快照后发 `ChildSettled`，投影失败或结果 reject 则发 `ChildFailed`（[packages/workflow/workflow-worker-thread/src/host.ts:390-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L390-L409)）
- 先发 `ChildStarted` 再投递结果消息，保证启动答复排在结果之前（[packages/workflow/workflow-worker-thread/src/host.ts:410-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L410-L411)）
- 对未登记的 callId 的 dispose 请求也回 `ChildDisposed` 应答，避免 worker 侧永久等待（[packages/workflow/workflow-worker-thread/src/host.ts:414-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L414-L421)）
- 已登记子代的处置完成后再发 `ChildDisposed`（[packages/workflow/workflow-worker-thread/src/host.ts:422-423](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L422-L423)）
- `disposeChild` 按 callId 记忆化：子代 `dispose()` 只执行一次，异常被吞并记 warn，最后把记录移出注册表（[packages/workflow/workflow-worker-thread/src/host.ts:438-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L438-L447)）
- 只有在已发布子代和待启动任务都清空时才释放静默等待者（[packages/workflow/workflow-worker-thread/src/host.ts:450-471](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L450-L471)）
- `reapChildren` 先 abort 共享信号，再对当前快照里的每个子代启动处置（不等待）（[packages/workflow/workflow-worker-thread/src/host.ts:474-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L474-L479)）
- `abortChildren` 只在未 abort 时 abort 那一个共享控制器（[packages/workflow/workflow-worker-thread/src/host.ts:482-484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L482-L484)）
- 终局已认领时，后到的 `Result` 消息完全无副作用地丢弃（[packages/workflow/workflow-worker-thread/src/host.ts:489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L489)）
- 收到结果时先快照"是否已请求取消"，再认领终局并清理子代（[packages/workflow/workflow-worker-thread/src/host.ts:495-502](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L495-L502)）
- 未请求过取消则原样落定 worker 结果（[packages/workflow/workflow-worker-thread/src/host.ts:503-506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L503-L506)）
- 已请求取消但 worker 报的不是 `cancelled` 时，改写为 cancelled 结果并保留其 `agentsStarted`（[packages/workflow/workflow-worker-thread/src/host.ts:507-515](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L507-L515)）
- 首个死亡信号先关闭消息准入，再做清理回调（[packages/workflow/workflow-worker-thread/src/host.ts:522-525](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L522-L525)）
- 死亡时若终局尚未被认领则先认领，再清理子代并补齐悬空 agent-end（[packages/workflow/workflow-worker-thread/src/host.ts:526-535](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L526-L535)）
- 未认领时按是否已请求取消，落定为 `cancelled` 或 `error`（错误文本为死亡消息、`value` 为 null、`agentsStarted` 取宿主计数）（[packages/workflow/workflow-worker-thread/src/host.ts:536-542](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L536-L542)）
- `exit` 事件额外做最终清扫：对注册表幸存者启动处置并再补一次悬空 agent-end（[packages/workflow/workflow-worker-thread/src/host.ts:544-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L544-L550)）
- `endAgent` 只在账本中仍存在未配对的 start 时才转发 end，保证每个 start 恰好配一个 end（[packages/workflow/workflow-worker-thread/src/host.ts:560-564](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L560-L564)）
- `endStrandedAgents` 把所有未配对的 start 以 `outcome: 'cancelled'` 合成 end（[packages/workflow/workflow-worker-thread/src/host.ts:578-582](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L578-L582)）
- 取消结果固定为 `value: null`、`stopReason: 'cancelled'`、错误文本 `workflow run cancelled: <reason>`（[packages/workflow/workflow-worker-thread/src/host.ts:584-590](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L584-L590)）
- `detachInputSignal` 摘掉当初装在调用方信号上的那个具体回调（[packages/workflow/workflow-worker-thread/src/host.ts:593-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L593-L600)）
- `settleResult` 首次生效：置认领与落定标志、摘信号、清宽限定时器并 resolve `result`（[packages/workflow/workflow-worker-thread/src/host.ts:603-613](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L603-L613)）
- 处置用的 `sleep` 定时器 `unref()`，不会撑住进程（[packages/workflow/workflow-worker-thread/src/host.ts:617-622](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/host.ts#L617-L622)）

### packages/workflow/workflow-worker-thread/src/index.ts

插件入口：定义引擎配置模式，在创建 worker 前做同步校验，并把 `WorkerRun` 的观察回调接到 `workflow/*` 事件上。

- 正文以 `export const meta` 开头时，抛出 `SCRIPT_PARSE` 并给出"meta 走请求字段而非脚本"的定向文案（[packages/workflow/workflow-worker-thread/src/index.ts:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L54)、[packages/workflow/workflow-worker-thread/src/index.ts:65-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L65-L67)）
- 宿主侧用与 worker 完全相同的 `(async () => {…})()` 包装做一次 `vm.Script` 解析检查，只解析不执行，失败抛 `SCRIPT_PARSE`（[packages/workflow/workflow-worker-thread/src/index.ts:68-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L68-L73)）
- provider 解析：请求覆盖优先于配置值，空串或带首尾空白抛 `INVALID_ARGUMENT`（[packages/workflow/workflow-worker-thread/src/index.ts:77-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L77-L84)）
- `ctx.subagents.getProvider()` 查不到该 provider 时抛 `AGENT_START`（[packages/workflow/workflow-worker-thread/src/index.ts:85-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L85-L87)）
- 单次运行的子代总量上限：未指定取配置上限，非正安全整数或超过上限均抛 `INVALID_ARGUMENT`（[packages/workflow/workflow-worker-thread/src/index.ts:92-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L92-L104)）
- 服务声明注入 `subagents`（[packages/workflow/workflow-worker-thread/src/index.ts:113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L113)）
- 配置模式给出 provider=spawn、maxConcurrentAgents=0、maxTotalAgents=1000、maxItemsPerCall=4096、syncTimeoutMs=5000、disposeGraceMs=5000 的默认值与下限（[packages/workflow/workflow-worker-thread/src/index.ts:115-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L115-L122)）
- `start()` 依次做 meta 校验、正文解析、provider 解析、总量上限解析，全部在创建 worker 之前（[packages/workflow/workflow-worker-thread/src/index.ts:144-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L144-L147)）
- 每次运行分配一个 `randomUUID` 作 `WorkflowRunId`（[packages/workflow/workflow-worker-thread/src/index.ts:148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L148)）
- `maxConcurrentAgents` 为 0 时解析为 `min(16, max(1, availableParallelism() - 2))`（[packages/workflow/workflow-worker-thread/src/index.ts:150-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L150-L154)）
- 组装 worker 初始化载荷：归一化 meta、脚本正文、可选 `args`、四项限额（[packages/workflow/workflow-worker-thread/src/index.ts:158-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L158-L163)）
- 在 `start()` 内先捕获 `ctx` 与 `ctx.subagents` 句柄交给运行，使引擎卸载后已返回的运行仍能启动与清理子代（[packages/workflow/workflow-worker-thread/src/index.ts:170-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L170-L171)）
- 把 `phase`/`log`/`agentStart`/`agentEnd` 四个观察回调分别转成 `workflow/phase`、`workflow/log`、`workflow/agent-start`、`workflow/agent-end` 事件（[packages/workflow/workflow-worker-thread/src/index.ts:181-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L181-L186)）
- 构造完成后立刻发 `workflow/start`（[packages/workflow/workflow-worker-thread/src/index.ts:190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L190)）
- 结果落定后发 `workflow/end`，只带 `stopReason`、可选 `error` 与 `agentsStarted`，不带返回值本体（[packages/workflow/workflow-worker-thread/src/index.ts:193-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/index.ts#L193-L199)）

### packages/workflow/workflow-worker-thread/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包名。

- `apply` 把包名与安装函数注册进 `ctx.invariants` 并返回注销器，其安装函数为空、不订阅任何事件（[packages/workflow/workflow-worker-thread/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/invariant.ts#L21)、[packages/workflow/workflow-worker-thread/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/invariant.ts#L28-L29)）

### packages/workflow/workflow-worker-thread/src/meta.ts

对启动请求里的 `meta` 数据做形状校验与归一化，被 `src/index.ts` 的 `start()` 在建 worker 之前调用。

- 非对象、null 或数组直接判为 `meta must be an object`（[packages/workflow/workflow-worker-thread/src/meta.ts:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/meta.ts#L15-L17)）
- 顶层字段白名单为 name/description/whenToUse/phases，多余字段逐个记违规（[packages/workflow/workflow-worker-thread/src/meta.ts:19-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/meta.ts#L19-L22)）
- `name`、`description` 必须为非空字符串，`whenToUse` 若存在必须为字符串（[packages/workflow/workflow-worker-thread/src/meta.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/meta.ts#L23-L25)）
- `phases` 若存在必须是数组，逐项必须是对象、字段限于 title/detail/provider/model，且 `title` 非空字符串、其余为字符串（[packages/workflow/workflow-worker-thread/src/meta.ts:27-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/meta.ts#L27-L43)）
- 校验通过时逐字段重建 phases 与 meta 的归一化副本，不复用调用方对象（[packages/workflow/workflow-worker-thread/src/meta.ts:44-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/meta.ts#L44-L51)、[packages/workflow/workflow-worker-thread/src/meta.ts:56-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/meta.ts#L56-L64)）
- 存在任一违规即抛 `META_INVALID`，消息用 `; ` 拼接全部违规项（[packages/workflow/workflow-worker-thread/src/meta.ts:76-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/meta.ts#L76-L82)）

### packages/workflow/workflow-worker-thread/src/protocol.ts

宿主与 worker 之间的消息标签枚举与载荷类型映射，被 `host.ts` 与 `session.ts` 双向使用。

- 定义 worker→host 的 8 个消息标签及其字符串线值：`ready`、`phase`、`log`、`agent-start`、`agent-end`、`child-start`、`child-dispose`、`result`（[packages/workflow/workflow-worker-thread/src/protocol.ts:14-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/protocol.ts#L14-L31)）
- 定义 host→worker 的 7 个消息标签及其字符串线值：`go`、`cancel`、`child-started`、`child-start-error`、`child-settled`、`child-failed`、`child-disposed`（[packages/workflow/workflow-worker-thread/src/protocol.ts:54-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/protocol.ts#L54-L69)）

### packages/workflow/workflow-worker-thread/src/realm.ts

把离开脚本 vm 的值物化成纯 JSON，并把抛出值渲染成文本，被 `runtime.ts`、`session.ts` 与 `host.ts` 使用。

- `MaterializeError` 把路径与原因拼进 message 并固定 `name`（[packages/workflow/workflow-worker-thread/src/realm.ts:12-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L12-L17)）
- `renderThrown` 依次尝试 `stack`、`message`、`String()`，读取过程本身抛错时返回固定文本 `[unrenderable thrown value]`（[packages/workflow/workflow-worker-thread/src/realm.ts:28-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L28-L40)）
- 以"原型为 null 或其原型的原型为 null"判定纯数据对象，从而跨 realm 拒绝 Date/Map/类实例（[packages/workflow/workflow-worker-thread/src/realm.ts:48-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L48-L52)）
- 根层 `undefined` 原样返回；物化过程中的非 `MaterializeError` 异常被包成带路径的 `MaterializeError`（[packages/workflow/workflow-worker-thread/src/realm.ts:66-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L66-L76)）
- 非有限数、bigint、function、symbol、嵌套 `undefined` 各自以专属原因被拒（[packages/workflow/workflow-worker-thread/src/realm.ts:83-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L83-L94)）
- 以 `seen` 集合检测并拒绝循环引用，退栈时移除（[packages/workflow/workflow-worker-thread/src/realm.ts:100-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L100-L107)）
- 数组物化拒绝稀疏空洞（[packages/workflow/workflow-worker-thread/src/realm.ts:112-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L112-L114)）
- 数组上超出索引范围的自有可枚举属性被拒绝而不是静默丢弃（[packages/workflow/workflow-worker-thread/src/realm.ts:118-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L118-L123)）
- 数组与对象上的 symbol 键属性一律拒绝（[packages/workflow/workflow-worker-thread/src/realm.ts:124-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L124-L126)、[packages/workflow/workflow-worker-thread/src/realm.ts:134-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L134-L136)）
- 异质原型的对象被拒绝（[packages/workflow/workflow-worker-thread/src/realm.ts:131-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L131-L133)）
- 对象只复制自有可枚举字符串键，且用 `Object.defineProperty` 写入，使 `"__proto__"` 成为副本的自有数据属性而非原型改写（[packages/workflow/workflow-worker-thread/src/realm.ts:140-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/realm.ts#L140-L149)）

### packages/workflow/workflow-worker-thread/src/runtime.ts

worker 内一次脚本执行的核心：编译脚本、注入钩子、管并发与限额、处理取消并产出终局结果，被 `session.ts` 驱动。

- `agent()` 选项白名单为 label/phase/schema/provider/model，另有一组被点名拒绝的选项 effort/isolation/agentType（[packages/workflow/workflow-worker-thread/src/runtime.ts:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L39-L41)）
- 子代输出只取 `text` 块并拼接成字符串（[packages/workflow/workflow-worker-thread/src/runtime.ts:44-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L44-L49)）
- 未给 label 时取 prompt 首行，超过 48 字符截到 47 并加省略号（[packages/workflow/workflow-worker-thread/src/runtime.ts:52-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L52-L56)）
- 构造期先把正文包进 `(async () => {\n…\n})()` 编译，filename 为 `workflow:<name>`、`lineOffset: -1`，语法错误抛 `SCRIPT_PARSE`（[packages/workflow/workflow-worker-thread/src/runtime.ts:89-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L89-L96)）
- 以空对象创建 vm 上下文，脚本全局不含定时器、文件系统或 Node 内建（[packages/workflow/workflow-worker-thread/src/runtime.ts:98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L98)）
- 向上下文注入 `agent`/`parallel`/`pipeline`/`phase`/`log` 五个钩子与 `args` 数据，函数被 `Object.freeze`（[packages/workflow/workflow-worker-thread/src/runtime.ts:100-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L100-L113)）
- 取消状态用方法读取而非内联属性读，避免 await 后的控制流窄化（[packages/workflow/workflow-worker-thread/src/runtime.ts:122-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L122-L124)）
- 统一的钩子入口守卫：取消后每个钩子调用都抛 `CANCELLED`（[packages/workflow/workflow-worker-thread/src/runtime.ts:133-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L133-L135)）
- `cancel()` 首个原因生效，构造 `CANCELLED` 错误并拒绝所有排队中的并发槽等待者（[packages/workflow/workflow-worker-thread/src/runtime.ts:146-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L146-L151)）
- `drive()` 在正文执行前先查取消，已取消则脚本一行都不跑（[packages/workflow/workflow-worker-thread/src/runtime.ts:167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L167)）
- 脚本以 `runInContext` 执行，初始同步片段受 `syncTimeoutMs` 超时约束（[packages/workflow/workflow-worker-thread/src/runtime.ts:168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L168)）
- 脚本正常返回后再查一次取消：已取消则改报 `cancelled` 而非 `completed`（[packages/workflow/workflow-worker-thread/src/runtime.ts:173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L173)）
- 返回 `undefined` 归一为 `null`，其余走物化后作为 `completed` 结果的 `value`，并带上已启动子代数（[packages/workflow/workflow-worker-thread/src/runtime.ts:174-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L174-L175)）
- 抛错路径：已取消报 `cancelled` 并用规范原因文本，否则报 `error` 并用 `renderThrown` 文本；`drive()` 因此从不 reject（[packages/workflow/workflow-worker-thread/src/runtime.ts:176-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L176-L186)）
- 每个钩子返回的 promise 都挂一个空 catch 消费者，脚本丢弃它也不会因未处理拒绝杀掉 worker（[packages/workflow/workflow-worker-thread/src/runtime.ts:195-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L195-L198)）
- 返回值物化失败被转成 `RESULT_UNSERIALIZABLE` 并附带路径与"只返回 JSON 可序列化值"的指引（[packages/workflow/workflow-worker-thread/src/runtime.ts:208-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L208-L220)）
- 并发槽按 `maxConcurrentAgents` 计数，超额者进 FIFO 等待队列，释放时唤醒队首（[packages/workflow/workflow-worker-thread/src/runtime.ts:227-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L227-L247)）
- `agent()` 要求 prompt 为非空字符串，否则抛 `INVALID_ARGUMENT`（[packages/workflow/workflow-worker-thread/src/runtime.ts:252-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L252-L254)）
- 已启动数达到 `maxTotalAgents` 时抛 `AGENT_CAP` 并在文案中给出上限值（[packages/workflow/workflow-worker-thread/src/runtime.ts:256-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L256-L261)）
- 每次调用递增 `started` 并以其为 seq；label 缺省取首行摘要，phase 缺省取当前 `phase()` 设定值（[packages/workflow/workflow-worker-thread/src/runtime.ts:262-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L262-L265)）
- 拿到并发槽后再查一次取消，避免取消落在等待窗口时被当成启动失败（[packages/workflow/workflow-worker-thread/src/runtime.ts:267-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L267-L274)）
- 通过 `ChildPort` 发起子代启动，只带 prompt 与已校验的 schema/provider/model（[packages/workflow/workflow-worker-thread/src/runtime.ts:277-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L277-L282)）
- 启动失败时：处于取消态抛 `CANCELLED`，否则抛 `AGENT_START` 并附原异常（[packages/workflow/workflow-worker-thread/src/runtime.ts:283-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L283-L289)）
- 启动往返期间落入取消时，先 dispose 刚起的子代再抛 `CANCELLED`（[packages/workflow/workflow-worker-thread/src/runtime.ts:294-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L294-L297)）
- 发出 agent-start 观察事件，携带 seq、label、可选 phase 与子代会话 id（[packages/workflow/workflow-worker-thread/src/runtime.ts:298-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L298-L299)）
- 子代结果 reject（宿主报的基础设施故障）时先配对 agent-end，再按取消/未取消抛 `CANCELLED` 或致命的 `AGENT_RESULT`（[packages/workflow/workflow-worker-thread/src/runtime.ts:303-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L303-L316)）
- 带 schema 且子代 completed 时：无 structured 值记 failed 并返回 null，有则记 completed 并返回该结构化值（[packages/workflow/workflow-worker-thread/src/runtime.ts:317-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L317-L327)）
- 不带 schema 且 completed 时返回拼接后的文本输出（[packages/workflow/workflow-worker-thread/src/runtime.ts:328-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L328-L329)）
- 子代非 completed 时：运行已取消则抛 `CANCELLED`，否则记 failed 并把该次调用解析为 `null`（[packages/workflow/workflow-worker-thread/src/runtime.ts:332-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L332-L338)）
- 无论走哪条分支，`finally` 都会 dispose 子代并释放并发槽（[packages/workflow/workflow-worker-thread/src/runtime.ts:339-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L339-L344)）
- 选项包先经 realm 物化，失败转 `INVALID_ARGUMENT`；非对象同样拒绝（[packages/workflow/workflow-worker-thread/src/runtime.ts:355-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L355-L366)）
- 未识别键抛 `UNSUPPORTED_OPTION`，其中 effort/isolation/agentType 走"已延后"的专门文案（[packages/workflow/workflow-worker-thread/src/runtime.ts:368-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L368-L374)）
- label/phase/provider/model 若存在必须是字符串（[packages/workflow/workflow-worker-thread/src/runtime.ts:375-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L375-L379)）
- `schema` 走 `assertObjectJsonSchema` 子集校验，越界抛 `UNSUPPORTED_SCHEMA`（[packages/workflow/workflow-worker-thread/src/runtime.ts:380-390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L380-L390)）
- `parallel()` 要求数组、受每次调用条目上限约束、每项必须是函数（[packages/workflow/workflow-worker-thread/src/runtime.ts:402-412](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L402-L412)）
- `parallel()` 并发跑所有 thunk：普通异常降级为该项 `null`，致命 `WorkflowError` 继续上抛（[packages/workflow/workflow-worker-thread/src/runtime.ts:413-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L413-L424)）
- `pipeline()` 要求 items 数组、至少一个 stage、每个 stage 是函数，并同样受条目上限约束（[packages/workflow/workflow-worker-thread/src/runtime.ts:430-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L430-L442)）
- `pipeline()` 按条目独立串联各 stage、条目之间无阶段屏障；普通抛错让该条目变 `null` 并跳过其余 stage，致命错误终止整个脚本（[packages/workflow/workflow-worker-thread/src/runtime.ts:443-457](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L443-L457)）
- 条目数超过 `maxItemsPerCall` 抛 `ITEM_CAP` 并在文案中给出上限（[packages/workflow/workflow-worker-thread/src/runtime.ts:460-467](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L460-L467)）
- `phase()` 要求非空字符串，写入当前阶段标签并通知观察者（[packages/workflow/workflow-worker-thread/src/runtime.ts:470-477](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L470-L477)）
- `log()` 要求字符串并把消息转给观察者（[packages/workflow/workflow-worker-thread/src/runtime.ts:480-486](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/runtime.ts#L480-L486)）

### packages/workflow/workflow-worker-thread/src/session.ts

worker 侧会话：把一个 MessagePort 接到一次 `WorkflowExecution`，实现子代 RPC 桥并恰好投递一次终局结果，被 `worker.ts` 与单元测试驱动。

- 子代句柄的 `result` 直接绑定该次 RPC 的 settled promise；`dispose()` 发 `ChildDispose` 并等待宿主 ack（[packages/workflow/workflow-worker-thread/src/session.ts:44-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L44-L60)）
- RPC 桥按自增 callId 分配调用标识（[packages/workflow/workflow-worker-thread/src/session.ts:69-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L69-L80)）
- 为 settled promise 预挂空 catch，使启动失败后无人消费的拒绝不会杀掉 worker（[packages/workflow/workflow-worker-thread/src/session.ts:82-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L82-L85)）
- 发出 `ChildStart` 后等待 started promise，得到宿主给的 childId 才返回句柄（[packages/workflow/workflow-worker-thread/src/session.ts:86-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L86-L89)）
- 启动错误 reject started 并把待处理项移出表；settled/failed 分别 resolve 与 reject 结果；disposed 应答 resolve 并清表（[packages/workflow/workflow-worker-thread/src/session.ts:92-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L92-L119)）
- 在主线程加载 worker 入口时 `requireParentPort` 抛错（[packages/workflow/workflow-worker-thread/src/session.ts:128-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L128-L131)）
- 观察者把 `phase`/`log`/`agentStart`/`agentEnd` 逐一转成对应的 worker→host 消息（[packages/workflow/workflow-worker-thread/src/session.ts:149-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L149-L154)）
- `WorkflowExecution` 构造失败（编译错误）直接发一条 `stopReason: 'error'`、`agentsStarted: 0` 的结果并返回（[packages/workflow/workflow-worker-thread/src/session.ts:156-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L156-L162)）
- 消息处理：`Go` 放开启动闸门；`Cancel` 先取消执行再放闸，使脚本正文根本不执行（[packages/workflow/workflow-worker-thread/src/session.ts:164-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L164-L175)）
- 五类 child 消息按 callId 分派回 RPC 桥，未知标签走 `assertNever`（[packages/workflow/workflow-worker-thread/src/session.ts:176-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L176-L194)）
- 先发 `Ready`、等闸门放行，再 `drive()`，最后恰好发一次 `Result`（[packages/workflow/workflow-worker-thread/src/session.ts:197-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/session.ts#L197-L200)）

### packages/workflow/workflow-worker-thread/src/types.ts

worker 初始化载荷与子代端口的接口声明，被 `host.ts`、`session.ts`、`runtime.ts` 共用。

- 无运行期机制

### packages/workflow/workflow-worker-thread/src/worker.ts

真实 worker 线程的入口文件，由 `host.ts` 以路径或 data-URL 引导加载。

- 用 `parentPort` 与 `workerData` 启动 worker 会话，`parentPort` 为 null 时抛错（[packages/workflow/workflow-worker-thread/src/worker.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/src/worker.ts#L14)）

### packages/workflow/workflow-worker-thread/tsconfig.json

该包的 TypeScript 编译配置与工程引用列表。

- 无运行期机制

### packages/workflow/workflow-worker-thread/tsdown.config.ts

该包的打包配置，决定发布产物的入口与模块格式。

- 引擎入口与不变量伴生打成 ESM 输出到 `lib/`（[packages/workflow/workflow-worker-thread/tsdown.config.ts:9-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/tsdown.config.ts#L9-L18)）
- worker 入口单独打成 CommonJS，即 `host.ts` 构建态加载的 `lib/worker.cjs`（[packages/workflow/workflow-worker-thread/tsdown.config.ts:19-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workflow/workflow-worker-thread/tsdown.config.ts#L19-L28)）
