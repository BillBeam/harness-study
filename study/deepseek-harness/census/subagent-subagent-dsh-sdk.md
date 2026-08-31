---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/subagent-dsh-sdk
---

# packages/subagent/subagent-dsh-sdk

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、40 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/subagent-dsh-sdk/README.md

包 README，用带 front matter 的说明文档描述该后端的选型、配置字段、运行流程与失败语义。

- 无运行期机制

### packages/subagent/subagent-dsh-sdk/package.json

包清单，声明入口、发布文件集合与依赖关系。

- `main`/`types` 与 `exports` 决定 `.`、`./invariant`、`./src/*`、`./package.json` 四个子路径各自解析到哪个文件（[packages/subagent/subagent-dsh-sdk/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/package.json#L14-L27)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/subagent/subagent-dsh-sdk/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/package.json#L28-L32)）
- `peerDependencies` 要求宿主提供 SDK 客户端、subagent 与 subprocess 等包，运行期由宿主解析这些实现（[packages/subagent/subagent-dsh-sdk/package.json:34-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/package.json#L34-L43)）

### packages/subagent/subagent-dsh-sdk/src/index.ts

插件入口：定义配置模式、在加载期校验并解析路径，然后在 `ctx.subagents` 上注册子进程 SDK provider。

- 导出 `name` 与 `inject = ['subagents']`，仅依赖 subagent 服务（[packages/subagent/subagent-dsh-sdk/src/index.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L30-L31)）
- `Config` schema 定下各字段默认值：providerName `dsh-sdk`、profile `sdk`、patches `[]`、provider `deepseek-official`、model `deepseek-v4-flash`、env `{}`、三个超时默认值，且 `dshHome` 必填、`maxTokens` 限制为 ≥1 的整数（[packages/subagent/subagent-dsh-sdk/src/index.ts:79-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L79-L93)）
- `resolveConfiguredFile` 把配置里的文件路径按启动目录解析，并要求它是已存在的普通文件，否则抛 TypeError（[packages/subagent/subagent-dsh-sdk/src/index.ts:99-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L99-L107)）
- 能力集在 `NO_START_CAPABILITIES` 基础上只把 `agentOptions` 打开并冻结，其余启动能力仍被共享服务拒绝（[packages/subagent/subagent-dsh-sdk/src/index.ts:110-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L110-L113)）
- `resolveSdkRoute` 用请求里的 provider/model/reasoningEffort/maxTokens 覆盖实例默认值，未给出的 reasoningEffort 整字段省略（[packages/subagent/subagent-dsh-sdk/src/index.ts:116-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L116-L127)）
- provider 暴露冻结的 `agentRouteDefaults`（配置的 provider 与 model），供委派工具在模型覆盖与路由预检前读取（[packages/subagent/subagent-dsh-sdk/src/index.ts:136-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L136-L141)）
- provider 声明 `inheritsParentContext = false`，子进程不带父会话上下文（[packages/subagent/subagent-dsh-sdk/src/index.ts:138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L138)）
- `start` 先检查请求信号是否已中止，是则直接抛错不进入路径解析与 spawn（[packages/subagent/subagent-dsh-sdk/src/index.ts:144-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L144-L147)）
- 子 cwd 由配置覆盖或父会话 header 解析，失败时对外抛只含固定安全事实的错误、对内以 warn 记录原始错误（[packages/subagent/subagent-dsh-sdk/src/index.ts:148-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L148-L155)）
- 组装 run spec：可选 dshBin、profile、patches、dshHome、cwd、解析后的路由、env 与三个超时（[packages/subagent/subagent-dsh-sdk/src/index.ts:156-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L156-L167)）
- `onError` 把已发布运行被压平成 stop reason 的失败以 warn 写入 Host 日志（[packages/subagent/subagent-dsh-sdk/src/index.ts:168-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L168-L172)）
- `start` 返回 `startSdkRun(request, spec)` 的结果作为本次运行（[packages/subagent/subagent-dsh-sdk/src/index.ts:174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L174)）
- `apply` 在加载期断言三个超时为正有限数、`maxTokens` 为正安全整数、`dshHome` 为绝对路径，任一不满足即抛错（[packages/subagent/subagent-dsh-sdk/src/index.ts:178-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L178-L187)）
- `apply` 在加载期一次性解析并校验全部 patch 文件与可选 dshBin 路径（[packages/subagent/subagent-dsh-sdk/src/index.ts:188-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L188-L192)）
- 配置的相对 cwd 只在加载期按启动目录解析一次并校验，之后每次 start 复用该结果（[packages/subagent/subagent-dsh-sdk/src/index.ts:193-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L193-L198)）
- `apply` 把 provider 以解析后的名字注册到 `ctx.subagents`（[packages/subagent/subagent-dsh-sdk/src/index.ts:199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/index.ts#L199)）

### packages/subagent/subagent-dsh-sdk/src/invariant.ts

本包的不变量伴生插件，被包级不变量注册表加载。

- 以包名在 `ctx.invariants` 上登记本包并安装一个空检查器，返回该注册的 disposer（[packages/subagent/subagent-dsh-sdk/src/invariant.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/invariant.ts#L22-L30)）

### packages/subagent/subagent-dsh-sdk/src/run.ts

子进程运行时的驱动实现：通过 SDK 客户端拉起一个完整的子运行时、完成握手后发布运行、提取答案并按阶梯释放，被 `src/index.ts` 的 provider 调用。

- 三个默认超时常量：EOF 静默宽限 6000、终止宽限 3000、协议 shutdown 上限 1000（[packages/subagent/subagent-dsh-sdk/src/run.ts:74-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L74-L80)）
- `failureDiagnostic` 只由 provider 名、stage、category 三项结构化事实拼出可外传文本（[packages/subagent/subagent-dsh-sdk/src/run.ts:100-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L100-L107)）
- `SdkRunFailure` 以该安全文本为消息，把原始错误只放进 `cause`（[packages/subagent/subagent-dsh-sdk/src/run.ts:109-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L109-L114)）
- `internals.createHarness` 是运行时构造缝，测试可替换为假运行时（[packages/subagent/subagent-dsh-sdk/src/run.ts:117-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L117-L119)）
- `sdkConfigurationFailure` 把 spawn 前的工作目录/配置失败压成 `initialize`/`configuration`（[packages/subagent/subagent-dsh-sdk/src/run.ts:126-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L126-L128)）
- `sdkFailure` 只按错误类型分类为 `transport`、`protocol` 或 `unknown`，不读取消息或 stderr（[packages/subagent/subagent-dsh-sdk/src/run.ts:131-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L131-L138)）
- `sdkChildOutcome` 把子运行时最后一个 `turn/end` 原因映射为共享停止原因：completed/max-tokens 直通、aborted 保持 aborted（`disposed` 另加诊断）、blocked 变 refusal、error 与 interrupted 变 error、缺失终局变 error 加 `missing-terminal` 诊断、其余变 error 加 `child-unknown`（[packages/subagent/subagent-dsh-sdk/src/run.ts:146-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L146-L181)）
- `reportFailure` 把原始错误交给宿主观察回调，并吞掉回调自身的抛出（[packages/subagent/subagent-dsh-sdk/src/run.ts:193-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L193-L199)）
- `sdkStartupFailure` 把 SDK 的失败启动聚合错误拆成 initialize 与 shutdown 两条安全行并重新聚合，非聚合错误只产出一条 initialize 行（[packages/subagent/subagent-dsh-sdk/src/run.ts:202-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L202-L217)）
- `startSdkRun` 先检查已中止信号并铸出父命名空间下的运行 id（[packages/subagent/subagent-dsh-sdk/src/run.ts:232-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L232-L236)）
- 构造子运行时时传入 profile、patches、dshHome、进程与会话 cwd、路由与可选推理强度/输出上限，并把子环境设为凭据擦洗后的父环境再叠加显式 env（[packages/subagent/subagent-dsh-sdk/src/run.ts:238-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L238-L253)）
- 取消通道用一个只触发一次的标志加 promise 表示，并绑定到父请求信号的 abort（[packages/subagent/subagent-dsh-sdk/src/run.ts:255-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L255-L266)）
- 握手与取消竞速：非取消失败经 `sdkStartupFailure` 抛出；取消则先 `harness.close()` 回收进程，清理失败抛 AggregateError，清理成功抛"发布前被中止"（[packages/subagent/subagent-dsh-sdk/src/run.ts:270-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L270-L295)）
- 铸一个私有子会话 id，只把该会话的 `session.event` 通知喂给共享的助手输出折叠器，作为输出来源（[packages/subagent/subagent-dsh-sdk/src/run.ts:297-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L297-L305)）
- `teardown` 调用 `harness.close()`，失败时上报原始错误并抛出 `shutdown`/`unknown` 安全失败（[packages/subagent/subagent-dsh-sdk/src/run.ts:306-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L306-L313)）
- 已发布运行把子会话的一次 run 与本地取消竞速：取消胜出返回已折叠输出加 `aborted`，否则取最后一个 `turn/end` 走停止原因映射（[packages/subagent/subagent-dsh-sdk/src/run.ts:318-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L318-L334)）
- 运行异常时把诊断置为 `session-run` 阶段的安全文本再重新抛出，交给共享结算压平（[packages/subagent/subagent-dsh-sdk/src/run.ts:335-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L335-L346)）
- 返回共享子进程运行句柄：运行 id、结果 promise、取消入口与关闭子运行时的 teardown（[packages/subagent/subagent-dsh-sdk/src/run.ts:350-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-dsh-sdk/src/run.ts#L350-L357)）

### packages/subagent/subagent-dsh-sdk/tsconfig.json

包级 TypeScript 编译配置，声明源码根目录、类型输出目录与工作区引用。

- 无运行期机制
