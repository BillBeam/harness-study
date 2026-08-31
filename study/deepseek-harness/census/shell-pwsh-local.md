---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/pwsh-local
---

# packages/shell/pwsh-local

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、43 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/pwsh-local/README.md

这个包的说明文档，介绍本地 PowerShell 执行器的配置字段、运行方式与已知限制。

- 无运行期机制

### packages/shell/pwsh-local/package.json

这个包的清单，声明入口映射、发布内容与依赖，被 Node 解析和打包时读取。

- `exports` 把包名映射到 `lib/index.js`，另外开放 `./invariant`、`./src/*` 和 `./package.json` 三个子路径（[packages/shell/pwsh-local/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/package.json#L16-L27)）
- `files` 限定发布物只包含 `lib/index.js`、`lib/invariant.js` 和 `lib/types` 下的声明文件（[packages/shell/pwsh-local/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/package.json#L28-L32)）
- `dependencies` 把校验库列为运行期真实依赖，与仅作对等声明的其余包区分（[packages/shell/pwsh-local/package.json:42-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/package.json#L42-L44)）

### packages/shell/pwsh-local/src/index.ts

包入口，定义本地 PowerShell 执行器类，注册为 `ctx.shell` 并被 pwsh 工具调用。

- 三个终端环境覆写常量禁用颜色与分页器（[packages/shell/pwsh-local/src/index.ts:34-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L34-L38)）
- 编码前缀把控制台输出编码与 `$OutputEncoding` 都设成无 BOM 的 UTF-8，并用 `; ` 拼在同一行（[packages/shell/pwsh-local/src/index.ts:48-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L48-L49)）
- 默认宽限期 3000 毫秒、默认单流溢写上限 64 MiB（[packages/shell/pwsh-local/src/index.ts:52-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L52-L55)）
- `finalOutput` 从偏移 0 读出全量，投影成带 `truncated` 和可选 `spillPath` 的收集结果（[packages/shell/pwsh-local/src/index.ts:88-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L88-L95)）
- `assertPositiveFinite` 对非有限或非正数抛错（[packages/shell/pwsh-local/src/index.ts:97-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L97-L101)）
- `assertServiceablePwshConfig` 逐字段校验五个数值预算，并要求 `graceMs` 不超过定时器上限，否则在写入处就拒绝（[packages/shell/pwsh-local/src/index.ts:111-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L111-L121)）
- `inject` 声明只依赖 `subprocess` 服务（[packages/shell/pwsh-local/src/index.ts:129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L129)）
- 配置模式给出默认值：前台超时 120000、超时上限 600000、单流内存上限 64000 字节、溢写上限与宽限期（[packages/shell/pwsh-local/src/index.ts:131-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L131-L139)）
- `config` getter 每次都通过当前 source 读取，使配置换源后下一条命令立即生效（[packages/shell/pwsh-local/src/index.ts:151-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L151-L153)）
- 构造时先校验组合条目，再把 source 固定为该条目，并解析出可执行文件路径（[packages/shell/pwsh-local/src/index.ts:163-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L163-L167)）
- 安装共享的 `shell` 设置分区：写入时用同一校验函数把关，`setSource` 切换权威配置，`onChange` 只在声明的可执行路径变化时重新探测文件系统（[packages/shell/pwsh-local/src/index.ts:168-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L168-L181)）
- `resolve` 用配置的默认超时与上限夹住请求的 `timeoutMs`（[packages/shell/pwsh-local/src/index.ts:190-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L190-L195)）
- `stdoutMaxBytes` 缺省取 `maxOutputBytes`，并当场断言为正有限数（[packages/shell/pwsh-local/src/index.ts:196-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L196-L197)）
- 工作目录按「请求 → 配置 cwd → `process.cwd()`」取值，`signal`/`stdin`/`env`/`dshEnv` 只在存在时才写入 spec，`sandboxPolicy` 原样透传（[packages/shell/pwsh-local/src/index.ts:198-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L198-L208)）
- `argv` 组装 `pwsh -NoLogo -NoProfile -NonInteractive -Command <编码前缀+命令>`，命令文本作为单个 argv 元素（[packages/shell/pwsh-local/src/index.ts:217-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L217-L219)）
- `spawnSpec` 给 stdout 用传入预算、stderr 用 `maxOutputBytes`，两者共用溢写上限；stdin 有数据就写入否则忽略；并传入 `graceMs` 与 signal（[packages/shell/pwsh-local/src/index.ts:228-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L228-L239)）
- 环境按固定次序叠加：终端覆写、调用方 `env`、受管 `dshEnv` 最后（[packages/shell/pwsh-local/src/index.ts:240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L240)）
- `collected` 在子进程实现漏掉任一被请求的收集流时抛错（[packages/shell/pwsh-local/src/index.ts:245-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L245-L253)）
- `runArgv` 把超时与调用方 signal 融成一个 deadline，用 `using` 在退出时清定时器（[packages/shell/pwsh-local/src/index.ts:262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L262)）
- 只有本执行器自己的超时原因才记为 `timedOut`，其余中止记为 `aborted`，两者互斥（[packages/shell/pwsh-local/src/index.ts:266-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L266-L268)）
- 前台结果带上生效的 `timeoutMs` 与两条最终收集输出（[packages/shell/pwsh-local/src/index.ts:269-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L269-L276)）
- `startArgv` 后台启动忽略 `timeoutMs`，stdout 预算改用 `maxOutputBytes`，只受 `spec.signal` 与 `kill()` 控制（[packages/shell/pwsh-local/src/index.ts:285-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L285-L286)）
- spawn 失败的提示文本只投递一次，读走即清空（[packages/shell/pwsh-local/src/index.ts:291-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L291-L296)）
- 进程关闭时：仍在 running 才改状态，中止过或收到信号记为 killed 否则 completed，随后写入退出码与信号并调用结算钩子（[packages/shell/pwsh-local/src/index.ts:304-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L304-L311)）
- spawn 被拒时句柄结算为 killed，把错误文本存成一次性提示并以 `spawnFailed` 调用结算钩子，`done` 本身不 reject（[packages/shell/pwsh-local/src/index.ts:312-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L312-L317)）
- `readOutput` 用两个独立偏移做增量消费读，读后推进偏移（[packages/shell/pwsh-local/src/index.ts:318-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L318-L322)）
- stderr 为空时才补投 spawn 失败提示，非空 stderr 以 `[stderr]` 段拼在 stdout 之后，缺换行才补一个（[packages/shell/pwsh-local/src/index.ts:326-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L326-L331)）
- 任一流丢数据就置 `lossy`，并分别附上 stdout/stderr 的溢写文件路径（[packages/shell/pwsh-local/src/index.ts:332-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L332-L337)）
- `kill` 只在 running 时生效：先置 killed 再终止进程树，否则返回 false（[packages/shell/pwsh-local/src/index.ts:339-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L339-L344)）
- `onProcessDone` 是空的结算钩子，供受限子类挂载执行事实（[packages/shell/pwsh-local/src/index.ts:359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/index.ts#L359)）

### packages/shell/pwsh-local/src/invariant.ts

这个包的不变量伴随插件，由不变量服务在装载时调用。

- `inject` 要求 `invariants` 服务先就位，插件才会应用（[packages/shell/pwsh-local/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/invariant.ts#L15)）
- `apply` 以包名向 `ctx.invariants` 注册一个空安装器，并返回其卸载器（[packages/shell/pwsh-local/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/invariant.ts#L28-L29)）

### packages/shell/pwsh-local/src/resolve.ts

无依赖的可执行文件解析模块，被执行器构造与配置变更时调用，也被仓库的覆盖率探针共用。

- 候选列表首项是 `ProgramFiles` 下的 PowerShell 7 安装路径，环境变量缺失时回退到固定的英文默认路径（[packages/shell/pwsh-local/src/resolve.ts:22-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/resolve.ts#L22-L26)）
- PATH 按分号切分，逐项去空白并剥掉首尾引号，空项跳过，其余拼上 `pwsh.exe` 加入候选（[packages/shell/pwsh-local/src/resolve.ts:29-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/resolve.ts#L29-L33)）
- 最后追加 `SystemRoot` 下的 5.1 版可执行文件作为兜底候选（[packages/shell/pwsh-local/src/resolve.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/resolve.ts#L35)）
- `candidateExists` 用 `lstatSync` 不跟随重解析点，接受普通文件或符号链接，任何异常都判为不存在（[packages/shell/pwsh-local/src/resolve.ts:46-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/resolve.ts#L46-L55)）
- 显式配置的非空路径原样采用，不做任何探测（[packages/shell/pwsh-local/src/resolve.ts:72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/resolve.ts#L72)）
- 仅在 win32 平台按序探测候选并取第一个存在者，其他平台一律返回裸 `pwsh` 交给 PATH 解析（[packages/shell/pwsh-local/src/resolve.ts:73-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-local/src/resolve.ts#L73-L78)）

### packages/shell/pwsh-local/tsconfig.json

这个包的 TypeScript 编译配置，声明源码根、输出目录与工程引用。

- 无运行期机制
