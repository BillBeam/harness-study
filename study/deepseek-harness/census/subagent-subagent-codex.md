---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/subagent-codex
---

# packages/subagent/subagent-codex

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、79 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/subagent-codex/README.md

包 README，用带 front matter 的说明文档描述该 provider 的安装、配置字段、权限模式映射与失败语义，供文档站与读者使用。

- 无运行期机制

### packages/subagent/subagent-codex/cordis.patch.yml

该包作为 Profile Bundle 安装时使用的补丁层文件，被 package.json 的 `dsh.bundle.patch` 指向。

- 向目标 Profile 插入一条 id 为 `subagent-codex`、name 为本包的插件条目，使该 provider 在 Profile 启动时被加载并注册（[packages/subagent/subagent-codex/cordis.patch.yml:3-5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/cordis.patch.yml#L3-L5)）

### packages/subagent/subagent-codex/package.json

包清单，声明该包的入口、发布文件集合、Bundle 补丁位置与依赖。

- `main`/`types` 与 `exports` 决定 `.`、`./invariant`、`./src/*`、`./package.json` 四个子路径分别解析到哪个文件（[packages/subagent/subagent-codex/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/package.json#L14-L27)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js`、`cordis.patch.yml` 与类型声明（[packages/subagent/subagent-codex/package.json:28-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/package.json#L28-L33)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，安装该包时按此路径取补丁层（[packages/subagent/subagent-codex/package.json:35-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/package.json#L35-L39)）
- 运行时依赖把 `@openai/codex` 钉在 `0.149.1`，`src/run.ts` 在模块加载时解析的就是这个版本的包装脚本（[packages/subagent/subagent-codex/package.json:49-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/package.json#L49-L53)）

### packages/subagent/subagent-codex/src/index.ts

插件入口：声明配置模式，并在 `ctx.subagents` 上注册一个按 Profile 命名的 Codex provider。

- 导出 `name` 与 `inject = ['subagents', 'subprocess']`，插件只在这两个服务就绪后 apply（[packages/subagent/subagent-codex/src/index.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L30-L31)）
- `Config` schema 规定 `providerName` 默认 `codex`、`model` 至少一字符且无默认、`env` 默认 `{}`、`permissionMode` 取三个枚举值之一并默认 `never`、`disposeGraceMs` 默认 3000（[packages/subagent/subagent-codex/src/index.ts:52-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L52-L59)）
- provider 声明 `capabilities = NO_START_CAPABILITIES`，共享服务据此拒绝 `agentOptions`、输出模式、工具过滤、人格、深度等启动能力（[packages/subagent/subagent-codex/src/index.ts:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L64)）
- provider 声明 `inheritsParentContext = false`，子进程不带父会话上下文（[packages/subagent/subagent-codex/src/index.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L65)）
- `start` 从父会话 header 取 cwd，缺失时直接抛错终止本次委派（[packages/subagent/subagent-codex/src/index.ts:73-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L73-L79)）
- 子 cwd 由 `resolveChildCwd` 解析，解析失败时先按 `request.signal.aborted` 换成中止错误，否则包成只含固定安全事实的启动失败（[packages/subagent/subagent-codex/src/index.ts:80-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L80-L94)）
- 组装 run spec：cwd、可选 model（未配置则整字段省略）、permissionMode、env、disposeGraceMs，spawn 委托给 `ctx.subprocess.spawn`（[packages/subagent/subagent-codex/src/index.ts:95-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L95-L101)）
- `onError` 把已发布运行的失败以 warn 级别写进 Host 日志，带 provider 名与 stop reason（[packages/subagent/subagent-codex/src/index.ts:102-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L102-L107)）
- `start` 返回 `startCodexRun(request, spec)` 的结果作为本次运行（[packages/subagent/subagent-codex/src/index.ts:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L108)）
- `apply` 用 `??` 补齐 providerName、permissionMode，并按 model 是否存在决定是否带该字段（[packages/subagent/subagent-codex/src/index.ts:118-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L118-L124)）
- `apply` 断言 `disposeGraceMs` 为正有限数且不超过 `MAX_TIMER_DELAY_MS`，否则加载即抛错（[packages/subagent/subagent-codex/src/index.ts:125-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L125-L134)）
- `apply` 把 provider 以解析后的名字注册到 `ctx.subagents`（[packages/subagent/subagent-codex/src/index.ts:135-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/index.ts#L135-L139)）

### packages/subagent/subagent-codex/src/invariant.ts

本包的不变量伴生插件，被包级不变量注册表加载。

- 以包名在 `ctx.invariants` 上登记本包并安装一个空检查器，返回该注册的 disposer（[packages/subagent/subagent-codex/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/invariant.ts#L21-L29)）

### packages/subagent/subagent-codex/src/run.ts

一次性 Codex 子进程的生命周期实现：拉起 app-server、发布运行、结果结算与整树释放，被 `src/index.ts` 的 provider 调用。

- 导出默认释放宽限 `DEFAULT_DISPOSE_GRACE_MS = 3000`，作为配置默认值（[packages/subagent/subagent-codex/src/run.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L35)）
- 模块加载时同步读取依赖包 manifest，并由其 `bin.codex` 计算出绝对包装脚本路径，绕开宿主 `PATH`（[packages/subagent/subagent-codex/src/run.ts:43-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L43-L52)）
- 固定三个可选权限模式常量，并把默认模式定为 `never`（[packages/subagent/subagent-codex/src/run.ts:61-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L61-L68)）
- `failureDiagnostic` 只由结构化事实拼出可外传文本：产品名、stage、category，以及存在时的 HTTP 状态、退出码、信号（[packages/subagent/subagent-codex/src/run.ts:86-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L86-L103)）
- `CodexRunFailure` 把事实随错误一起携带，消息即上面的安全诊断行，原始错误只进 `cause`（[packages/subagent/subagent-codex/src/run.ts:105-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L105-L116)）
- `codexStartupFailure` 把未发布阶段的任意宿主错误统一压成 `stage: initialize` / `category: unknown`（[packages/subagent/subagent-codex/src/run.ts:123-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L123-L128)）
- `codexAppServerArgv` 固定命令行为当前 Node 可执行文件 + 包内包装脚本 + `app-server --stdio`（[packages/subagent/subagent-codex/src/run.ts:134-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L134-L136)）
- `textTask` 拒绝空 prompt、拒绝任何非 text 块、拒绝全空白文本，只有通过后原文本序列才跨进程传递（[packages/subagent/subagent-codex/src/run.ts:166-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L166-L181)）
- `disposeCodexChild` 依次关闭 wire、结束 stdin、`terminate()` 进程树、`waitForExit()` 等待退出，等待失败时抛出 `stage: teardown` 失败，成功后再 await `child.done`（[packages/subagent/subagent-codex/src/run.ts:189-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L189-L221)）
- `startCodexRun` 先校验任务文本，再检查 `request.signal.aborted`，两者任一不通过就不 spawn（[packages/subagent/subagent-codex/src/run.ts:233-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L233-L236)）
- 以固定 argv、解析出的 cwd、三路 pipe、`graceMs` 与显式 env 调用 spawn；spawn 抛错时转成 `initialize`/`unknown` 失败（[packages/subagent/subagent-codex/src/run.ts:238-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L238-L252)）
- 用子进程 stdout/stdin 构造私有协议连接，并把权限模式与可选 model 交给它（[packages/subagent/subagent-codex/src/run.ts:254-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L254-L259)）
- 子进程 stderr 数据被同步写入宿主 stderr 的 fd，写失败与流自身错误都被吞掉，不改变本次运行结果（[packages/subagent/subagent-codex/src/run.ts:260-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L260-L275)）
- `disposeProcess` 在整树释放后再让出一个 `setImmediate` 轮次，随后才摘除 stderr 监听（[packages/subagent/subagent-codex/src/run.ts:276-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L276-L286)）
- `child.done` 被转成一个必定 reject 的 `processFailure`：正常退出记 `stage: process`/`category: process` 并带 outcome，异常记 `category: unknown`，并预先挂空 catch 保持被观察（[packages/subagent/subagent-codex/src/run.ts:288-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L288-L308)）
- 本地 `runAbort` 控制器：取消时只触发一次，abort 本地信号并向子进程发出 `turn/interrupt`；父请求信号的 abort 事件绑定到它（[packages/subagent/subagent-codex/src/run.ts:310-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L310-L317)）
- 发布前依次执行 `wire.start()`、initialize 握手、`thread/start`，每步都与进程失败竞速，任一先到即结束启动（[packages/subagent/subagent-codex/src/run.ts:319-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L319-L324)）
- 启动失败路径：摘监听、必要时让出一轮让退出事实先落地、构造带 stage 与 outcome 的失败、释放进程；释放也失败时抛 `AggregateError`；若期间已取消则改抛"发布前被中止"（[packages/subagent/subagent-codex/src/run.ts:325-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L325-L358)）
- 发布后的诊断由失败事实文本与 wire 侧的无人值守权限诊断拼接而成，作为结果里的 `diagnostic`（[packages/subagent/subagent-codex/src/run.ts:360-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L360-L369)）
- `withProcessOutcome` 在已观察到进程 outcome 时把它并进失败事实（[packages/subagent/subagent-codex/src/run.ts:370-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L370-L375)）
- `publishedProcessFailure` 在进程失败重新抛出前插入一个 I/O 轮次，让已排队的协议帧先结算（[packages/subagent/subagent-codex/src/run.ts:376-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L376-L383)）
- 已发布运行执行一次 turn，与进程失败竞速；`completed` 直接返回，非 `completed` 让出一轮后附加安全诊断再返回（[packages/subagent/subagent-codex/src/run.ts:384-396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L384-L396)）
- 异常路径：让出一轮，若协议流在终止通知前结束且尚无进程事实且未取消，则在 `disposeGraceMs` 内等待进程退出以取得 outcome，再择优选取事实并统一抛成 `CodexRunFailure`（[packages/subagent/subagent-codex/src/run.ts:397-425](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L397-L425)）
- 结算交给共享的 `settleRunResult`，并传入输出收集、诊断收集、取消判定、错误回调与父信号（[packages/subagent/subagent-codex/src/run.ts:427-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L427-L432)）
- 最终返回共享的子进程运行句柄：随机 SessionId、结果 promise、取消入口与整树释放的 teardown（[packages/subagent/subagent-codex/src/run.ts:435-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/run.ts#L435-L442)）

### packages/subagent/subagent-codex/src/wire.ts

app-server JSON-RPC 协议适配层：拥有产品方法、线程/回合归属校验、无人值守应答与终局答案选取，被 `src/run.ts` 独占使用。

- `THREAD_PERMISSION_PARAMS` 把三种权限模式映射为 `thread/start` 的 `approvalPolicy`、`approvalsReviewer`、`sandbox` 字段（[packages/subagent/subagent-codex/src/wire.ts:32-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L32-L43)）
- `object`/`string` 对响应字段做类型与非空校验，不合规即抛错终止该次操作（[packages/subagent/subagent-codex/src/wire.ts:45-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L45-L57)）
- `unattendedDecision` 从 `availableDecisions` 选 `cancel` 或 `decline`，两者都不可用时抛错（[packages/subagent/subagent-codex/src/wire.ts:59-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L59-L67)）
- `numericHttpStatus` 只接受 0..65535 的整数，其余一律丢弃（[packages/subagent/subagent-codex/src/wire.ts:69-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L69-L76)）
- `objectFailureInfo` 把连接/流类错误键归为 `transport` 并保留数字 HTTP 状态，`activeTurnNotSteerable` 归为 `product-error`，其余归 `unknown`（[packages/subagent/subagent-codex/src/wire.ts:85-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L85-L112)）
- `failureInfo` 把字符串错误码映射为 `limit`（并对上下文超限置 `maxTokens`）、`service`、`access-policy`（沙箱失败另置标记）、`product-error` 或 `unknown`（[packages/subagent/subagent-codex/src/wire.ts:114-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L114-L148)）
- `unattendedDiagnostic` 固定诊断文本格式为模式、请求类别与决定加原因（[packages/subagent/subagent-codex/src/wire.ts:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L150-L157)）
- `raceAbort` 让每个受控操作与信号中止竞速，已中止时立刻抛并吞掉挂起 promise 的后续拒绝（[packages/subagent/subagent-codex/src/wire.ts:164-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L164-L184)）
- 构造函数建立行式 JSON-RPC 传输、注册服务端请求与通知处理器、并对输入流 error/end 与输出流 error 挂上会话级致命失败通道（[packages/subagent/subagent-codex/src/wire.ts:223-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L223-L248)）
- `start()` 才开始读取帧，此前的写入不会被解析（[packages/subagent/subagent-codex/src/wire.ts:251-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L251-L253)）
- `endedBeforeTerminal()` 报告协议流是否在终止回合通知之前就结束，供上层选择失败事实（[packages/subagent/subagent-codex/src/wire.ts:259-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L259-L261)）
- `initialize` 发送固定的 clientInfo 与 `experimentalApi: false`、`requestAttestation: false` 能力位，随后发 `initialized` 通知并 flush（[packages/subagent/subagent-codex/src/wire.ts:267-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L267-L281)）
- `startThread` 以 `{ cwd, ephemeral: true }` 加可选 model 与权限字段创建线程，校验返回的线程 id 且 `ephemeral` 必须为 true，否则抛错（[packages/subagent/subagent-codex/src/wire.ts:288-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L288-L301)）
- `runTurn` 用 `turn/start` 提交文本块序列并提交回合 id，失败时记 `stage: turn-start`（[packages/subagent/subagent-codex/src/wire.ts:310-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L310-L330)）
- `runTurn` 等待本回合的权威 `turn/completed`，等待或解析失败记 `stage: turn`/`unknown` 并抛出（[packages/subagent/subagent-codex/src/wire.ts:332-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L332-L343)）
- 非 `completed` 终局：记录分类与可选 HTTP 状态，沙箱失败额外记诊断，上下文超限直接返回 `max-tokens` 结果，其余抛带分类的错误（[packages/subagent/subagent-codex/src/wire.ts:344-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L344-L367)）
- `completed` 但选不出任何非空答案时记 `invalid-result` 并抛错，否则返回 `completed` 结果（[packages/subagent/subagent-codex/src/wire.ts:368-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L368-L373)）
- `interrupt()` 仅在线程与回合都已知且未关闭时发出 `turn/interrupt`，其响应被忽略（[packages/subagent/subagent-codex/src/wire.ts:380-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L380-L386)）
- `collectOutput` 优先取最后一条 `final_answer` 文本，缺失时退回最后一条 `phase: null` 文本，全空白则返回空数组（[packages/subagent/subagent-codex/src/wire.ts:392-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L392-L397)）
- `collectDiagnostic`/`collectFailure` 把本次运行观察到的无人值守诊断与结构化失败事实交给上层（[packages/subagent/subagent-codex/src/wire.ts:403-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L403-L414)）
- `close()` 幂等地摘掉 end 监听并关闭传输，令未决请求被拒绝（[packages/subagent/subagent-codex/src/wire.ts:417-422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L417-L422)）
- `guarded` 让每个协议操作同时与共享致命失败和外部信号竞速（[packages/subagent/subagent-codex/src/wire.ts:424-427](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L424-L427)）
- 输入流 `end` 置 `inputEnded` 并以"协议流关闭"拒绝共享致命通道，输入/输出流错误同样进入该通道（[packages/subagent/subagent-codex/src/wire.ts:429-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L429-L444)）
- `observePendingTurnId` 在 `turn/start` 之前收到回合引用时记暂定 id，冲突或过早引用都抛错（[packages/subagent/subagent-codex/src/wire.ts:446-454](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L446-L454)）
- `commitTurnId` 校验响应回合与暂定 id 一致后落定，并回放此前挂起的诊断与提前到达的通知（[packages/subagent/subagent-codex/src/wire.ts:456-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L456-L479)）
- `validateRunIds` 拒绝引用其他线程或其他回合的服务端请求，并区分回合仍为暂定的情形（[packages/subagent/subagent-codex/src/wire.ts:486-503](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L486-L503)）
- 诊断按观察序号记录，序号更小的记录被丢弃，暂定回合的诊断先挂起到落定时补记（[packages/subagent/subagent-codex/src/wire.ts:505-538](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L505-L538)）
- `recordDeclinedItem` 把被拒的命令执行与文件改动项转成对应诊断（[packages/subagent/subagent-codex/src/wire.ts:549-569](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L549-L569)）
- 五类服务端请求被无人值守直接应答：命令审批与文件审批回 `cancel`/`decline`，权限申请回空权限、`scope: turn`，用户输入回空答案，MCP 征询回 `decline`（[packages/subagent/subagent-codex/src/wire.ts:571-621](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L571-L621)）
- 未知服务端请求方法抛错，且该错误进入共享致命通道并作为 JSON-RPC 拒绝返回（[packages/subagent/subagent-codex/src/wire.ts:622-629](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L622-L629)）
- `turn/started` 只在线程匹配且回合未落定时登记暂定回合 id（[packages/subagent/subagent-codex/src/wire.ts:637-645](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L637-L645)）
- `item/completed` 过滤非本线程/非本回合的项，回合未落定时先入早期队列，被拒项转诊断（[packages/subagent/subagent-codex/src/wire.ts:646-663](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L646-L663)）
- 只有 `agentMessage` 项参与答案选取：`final_answer` 覆盖最终答案，`phase: null` 覆盖兼容答案，`commentary` 丢弃，其他 phase 与非字符串文本抛错（[packages/subagent/subagent-codex/src/wire.ts:664-675](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L664-L675)）
- `turn/completed` 只认本线程本回合，置 `terminalObserved`，状态必须是 `completed`/`interrupted`/`failed` 之一，否则抛错；通过后带观察序号唤醒等待方（[packages/subagent/subagent-codex/src/wire.ts:677-702](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-codex/src/wire.ts#L677-L702)）

### packages/subagent/subagent-codex/tsconfig.json

包级 TypeScript 编译配置，声明源码根目录、类型输出目录与工作区引用。

- 无运行期机制
