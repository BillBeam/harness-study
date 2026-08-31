---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/bash-local
---

# packages/shell/bash-local

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、37 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/bash-local/README.md

该包的英文 README，说明本地 Bash 执行器的配置字段、前台/后台运行语义与运行期预算调整。

- 记载配置字段与默认值：`cwd`、`timeoutMs` 12 万毫秒、`maxTimeoutMs` 60 万毫秒、`maxOutputBytes` 64000、`maxSpillBytes` 67108864、`graceMs` 3000（[packages/shell/bash-local/README.md:42-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/README.md#L42-L49)）
- 记载前台运行语义：非零退出、超时与取消都以结果返回而非拒绝；每次调用的 `timeoutMs` 覆盖受配置上限约束；默认环境为 `NO_COLOR=1 TERM=dumb PAGER=cat GIT_PAGER=cat` 且调用方显式条目更优先（[packages/shell/bash-local/README.md:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/README.md#L55)）
- 记载后台运行语义：`start` 立即返回句柄且不套用超时，`readOutput()` 为消耗式读取并把 stderr 标在 `[stderr]` 段下，`done` 永不拒绝（[packages/shell/bash-local/README.md:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/README.md#L64)）
- 记载运行期预算调整：以组合入口为 base 注册共享 `shell` 设置命名空间，用户段落层叠后下一条命令即用新预算，schema 无法判定的值在写入处被拒（[packages/shell/bash-local/README.md:69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/README.md#L69)）
- 记载环境层叠固定顺序为终端覆盖、调用方 `env`、可信 `dshEnv`，且后台进程归属 subprocess 服务、执行器单独重载时仍存活（[packages/shell/bash-local/README.md:100-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/README.md#L100-L102)）
- 记载后台 spawn 失败提示只投递一次，读取方丢弃该 delta 后无法找回（[packages/shell/bash-local/README.md:140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/README.md#L140)）

### packages/shell/bash-local/package.json

该包的 npm 清单，声明入口、导出子路径与依赖关系。

- `exports` 暴露包根、`./invariant` 与 `./src/*` 三类解析入口，`files` 限定发布产物（[packages/shell/bash-local/package.json:16-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/package.json#L16-L32)）

### packages/shell/bash-local/src/index.ts

`ctx.shell` seam 的本地服务提供者：把命令经 `ctx.subprocess` 以 `bash -c` 派生，负责默认值填充、期限与原因分类、终端环境与后台读取合并。

- 导出 `ENV_OVERRIDES` 固定四条终端环境覆盖 `NO_COLOR`/`TERM`/`PAGER`/`GIT_PAGER`（[packages/shell/bash-local/src/index.ts:27-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L27-L32)）
- `finalOutput` 从偏移 0 读取整段已收集输出，投影出 `text`、`truncated` 与可选的溢写文件路径（[packages/shell/bash-local/src/index.ts:60-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L60-L67)）
- `assertServiceableBashConfig` 逐项要求五个预算为正有限数，并要求 `graceMs` 不超过 `MAX_TIMER_DELAY_MS`（[packages/shell/bash-local/src/index.ts:83-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L83-L93)）
- `static inject = ['subprocess']` 使该执行器必须在 subprocess 服务存在时才挂载（[packages/shell/bash-local/src/index.ts:103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L103)）
- `static Config` 定义 Loader schema 与五项预算的默认值（[packages/shell/bash-local/src/index.ts:105-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L105-L112)）
- `config` getter 每次经 `source()` 读取当前权威配置，使设置段变更立即对下一条命令生效（[packages/shell/bash-local/src/index.ts:115-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L115-L120)）
- 构造时先校验组合入口配置，再把它注册进共享 `shell` 设置命名空间并接上 `validate`/`setSource` 钩子（[packages/shell/bash-local/src/index.ts:122-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L122-L137)）
- `resolve` 用 `clampTimeout` 把请求超时按配置默认值与上限夹取（[packages/shell/bash-local/src/index.ts:147-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L147-L152)）
- `stdoutMaxBytes` 缺省取 `maxOutputBytes` 并断言为正有限数（[packages/shell/bash-local/src/index.ts:153-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L153-L154)）
- `workdir` 依次回退到 `config.cwd` 与 `process.cwd()`，`stdin`/`env`/`dshEnv`/`signal` 原样透传，`sandboxPolicy` 亦原样携带（[packages/shell/bash-local/src/index.ts:155-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L155-L170)）
- `spawnSpec` 为 stdout/stderr 各配一个带 `maxSpillBytes` 溢写上限的收集器，stderr 固定用 `maxOutputBytes`（[packages/shell/bash-local/src/index.ts:181-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L181-L190)）
- 无 stdin 时把子进程 stdin 设为 `ignore`，并把 `graceMs` 与取消信号交给 subprocess 派生规格（[packages/shell/bash-local/src/index.ts:186-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L186-L192)）
- 环境按终端覆盖、调用方 `env`、可信 `dshEnv` 的顺序层叠成一张显式表（[packages/shell/bash-local/src/index.ts:196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L196)）
- `collected` 在 subprocess 实现漏掉已请求的收集流时抛错（[packages/shell/bash-local/src/index.ts:201-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L201-L209)）
- `run` 把命令固定包成 `['bash', '-c', spec.command]` 派生（[packages/shell/bash-local/src/index.ts:211-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L211-L213)）
- `runArgv` 用 `deadline` 把调用方信号与超时合成一个带 `BASH_TIMEOUT` 原因码的期限，`using` 在退出时清定时器（[packages/shell/bash-local/src/index.ts:225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L225)）
- 只有本执行器自己的 `BASH_TIMEOUT` 记为 `timedOut`，其余中止记为 `aborted`（[packages/shell/bash-local/src/index.ts:230-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L230-L231)）
- 前台结果把 subprocess 结局与超时/中止分类、超时值、两条收集输出一起投影出去（[packages/shell/bash-local/src/index.ts:232-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L232-L239)）
- `start` 同样固定包成 `bash -c` 派生后台进程（[packages/shell/bash-local/src/index.ts:242-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L242-L244)）
- `startArgv` 后台派生不套用 `timeoutMs`，stdout 上限用 `maxOutputBytes`，只挂 `spec.signal`（[packages/shell/bash-local/src/index.ts:256-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L256-L258)）
- spawn 失败提示由 `consumeSpawnFailure` 一次性取走，之后清空（[packages/shell/bash-local/src/index.ts:262-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L262-L267)）
- 进程结束时按信号或调用方中止把状态定为 `killed`，否则为 `completed`，并写入退出码与信号（[packages/shell/bash-local/src/index.ts:275-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L275-L282)）
- 后台 spawn 拒绝时状态定为 `killed`，并生成 `spawn failed: …` 提示走读取路径（[packages/shell/bash-local/src/index.ts:283-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L283-L288)）
- `readOutput` 各自从上次偏移消耗式读取 stdout/stderr 并推进偏移（[packages/shell/bash-local/src/index.ts:289-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L289-L294)）
- 模型可见的 delta 把 stderr 追加为 `[stderr]` 段，并在 stdout 未以换行结尾时补一个分隔换行（[packages/shell/bash-local/src/index.ts:296-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L296-L302)）
- 读取结果合并两流的 `lossy` 标志，并分别带出 stdout/stderr 溢写文件路径（[packages/shell/bash-local/src/index.ts:303-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L303-L308)）
- `kill` 只对运行中的进程生效，置状态为 `killed` 并终止进程组（[packages/shell/bash-local/src/index.ts:310-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L310-L315)）
- `onProcessDone` 是子类的结算钩子，在退出事实或 spawn 失败输出写好之后、`done` 兑现之前被调用，基类实现为空（[packages/shell/bash-local/src/index.ts:330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/index.ts#L330)）

### packages/shell/bash-local/src/invariant.ts

该包的不变式伴随插件，向 `invariants` 服务登记包名。

- `apply` 向 `ctx.invariants` 注册包名与一个空安装器，并返回其 disposer（[packages/shell/bash-local/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-local/src/invariant.ts#L21-L29)）

### packages/shell/bash-local/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制
