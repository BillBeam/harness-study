---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/e2b/subprocess-e2b
---

# packages/e2b/subprocess-e2b

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 10 个文件、153 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/e2b/subprocess-e2b/README.md

包 README，描述该远程子进程适配器的配置字段、命令与终端行为、环境清洗与终止阶梯，供部署者与维护者阅读。

- 无运行期机制

### packages/e2b/subprocess-e2b/package.json

包清单，声明该适配器作为 ESM 包的入口、导出路径与发布内容。

- 声明 `"type": "module"` 与 `main`/`types` 入口指向 `lib/index.js` 与类型声明（[packages/e2b/subprocess-e2b/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/package.json#L13-L15)）
- `exports` 只暴露根入口、`./invariant` companion、`./src/*` 源码与 `./package.json` 四个解析路径（[packages/e2b/subprocess-e2b/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明文件（[packages/e2b/subprocess-e2b/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/package.json#L28-L32)）

### packages/e2b/subprocess-e2b/src/environment.ts

远程环境读取、清洗与序列化的共享模块，被同包的进程启动与终端启动路径调用。

- `remoteEnvironmentEntries` 按 NUL 切分远程环境，丢弃空条目与首字符即为 `=` 的条目（[packages/e2b/subprocess-e2b/src/environment.ts:11-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L11-L20)）
- `readRemoteEnvironment` 在沙箱里跑一条控制命令，从 passwd 取登录 home 并把它与 `env -0` 的结果各自 base64 后分两行输出（[packages/e2b/subprocess-e2b/src/environment.ts:31-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L31-L34)）
- 输出必须恰好两行且都匹配 base64 正则，否则抛错（[packages/e2b/subprocess-e2b/src/environment.ts:35-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L35-L38)）
- 用 `fatal: true` 的 UTF-8 解码器解码两段内容，解码失败抛出带 cause 的错误（[packages/e2b/subprocess-e2b/src/environment.ts:42-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L42-L48)）
- home 必须是不含 NUL 的绝对 POSIX 路径，否则抛错（[packages/e2b/subprocess-e2b/src/environment.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L49-L51)）
- 把 `HOME` 覆盖为 passwd 里的登录 home，再以 NUL 结尾格式重新序列化整份环境（[packages/e2b/subprocess-e2b/src/environment.ts:52-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L52-L54)）
- `scrubRemoteEnvironment` 丢弃所有 `DSH_` 前缀名与命中 `SENSITIVE_ENV_PATTERN` 的名字（[packages/e2b/subprocess-e2b/src/environment.ts:62-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L62-L69)）
- `bootstrapEnvironment` 产出 `TERM=dumb`，并为每个被清洗掉的名字追加空字符串覆盖项（[packages/e2b/subprocess-e2b/src/environment.ts:76-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L76-L82)）
- `serializeRemoteEnvironment` 拒绝空名、含 `=` 或 NUL 的名、含 NUL 的值（[packages/e2b/subprocess-e2b/src/environment.ts:95-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L95-L98)）
- 显式项里值为 `undefined` 时删除对应环境条目，否则覆盖写入，最后序列化成 `env -i` 接受的 NUL 分隔串（[packages/e2b/subprocess-e2b/src/environment.ts:99-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/environment.ts#L99-L103)）

### packages/e2b/subprocess-e2b/src/index.ts

插件入口，把 `E2BSubprocessRuntime` 注册为 `ctx.subprocess` 服务，提供可执行文件解析、命令与终端启动、以及服务级拆卸。

- `requireRepresentableGrace` 拒绝非有限、非正、或超过 `MAX_TIMER_DELAY_MS` 的 `graceMs`（[packages/e2b/subprocess-e2b/src/index.ts:45-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L45-L49)）
- 服务类声明 `inject = ['e2b']`，等到沙箱服务就绪后才装载（[packages/e2b/subprocess-e2b/src/index.ts:52-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L52-L53)）
- `Config` 模式声明 `pollMs` 并默认 `20`（[packages/e2b/subprocess-e2b/src/index.ts:55-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L55-L57)）
- 构造时再校验 `pollMs` 必须是正的安全整数，否则抛错（[packages/e2b/subprocess-e2b/src/index.ts:69-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L69-L72)）
- 注册拆卸 effect：置 `disposing`、中止所有进行中的终端 setup 并等待它们结束（[packages/e2b/subprocess-e2b/src/index.ts:74-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L74-L79)）
- 拆卸时对每个存活 handle 调 `terminate()` 并等其退出与 `done` 结算，对每个终端调 `terminate()`，再从集合中移除（[packages/e2b/subprocess-e2b/src/index.ts:80-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L80-L92)）
- 拆卸失败按数量抛单个错误或 `AggregateError`（[packages/e2b/subprocess-e2b/src/index.ts:93-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L93-L99)）
- `resolveExecutable` 拒绝空命令名并在开头检查取消信号（[packages/e2b/subprocess-e2b/src/index.ts:108-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L108-L109)）
- 绝对路径命令在沙箱里用 `test -f -a -x` 验证存在且可执行后原样返回（[packages/e2b/subprocess-e2b/src/index.ts:111-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L111-L118)）
- 含 `/` 的相对路径命令直接拒绝（[packages/e2b/subprocess-e2b/src/index.ts:119-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L119-L123)）
- 裸名命令在共享 cwd 下用 `command -v` 查找，可带调用方 `PATH` 前缀（[packages/e2b/subprocess-e2b/src/index.ts:124-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L124-L129)）
- 查找结果必须是单行且能构成路径，否则抛错；相对结果按共享 cwd 解析成绝对路径（[packages/e2b/subprocess-e2b/src/index.ts:131-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L131-L136)）
- `spawn` 在服务拆卸中、`argv[0]` 缺失、grace 不合法、或 spec 信号已中止时同步抛错（[packages/e2b/subprocess-e2b/src/index.ts:141-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L141-L149)）
- `spawn` 为每个命令在 `runtimeRoot/processes/<uuid>` 下分配私有状态目录并同步返回 handle（[packages/e2b/subprocess-e2b/src/index.ts:150-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L150-L151)）
- handle 加入存活集合，`done` 结算后等待退出再移除；释放失败时保留 handle 交给服务拆卸重试（[packages/e2b/subprocess-e2b/src/index.ts:152-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L152-L160)）
- `spawnTerminal` 同样拒绝拆卸中、空 argv、非法 grace 与已中止信号（[packages/e2b/subprocess-e2b/src/index.ts:165-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L165-L171)）
- 终端在 `runtimeRoot/terminals/<uuid>` 下分配状态目录，并把调用方信号与 setup 控制器信号合并成一个取消源（[packages/e2b/subprocess-e2b/src/index.ts:172-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L172-L178)）
- 分配完成后若服务已进入拆卸，则终止刚建好的终端并抛错（[packages/e2b/subprocess-e2b/src/index.ts:186-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L186-L192)）
- 终端 `done` 结算后自动 `terminate()` 并移出集合；释放失败时保留给服务拆卸重试（[packages/e2b/subprocess-e2b/src/index.ts:193-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L193-L199)）
- `finally` 中把 setup 从跟踪集合移除并结算其 `done`，使拆卸不再等待它（[packages/e2b/subprocess-e2b/src/index.ts:201-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L201-L204)）
- 默认导出服务类，供 Loader 按服务插件形式装载（[packages/e2b/subprocess-e2b/src/index.ts:208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/index.ts#L208)）

### packages/e2b/subprocess-e2b/src/invariant.ts

本包的 invariant companion 插件，向 invariants 注册表登记包名。

- `apply` 用包名与空安装器调用 `ctx.invariants.register`，并返回该注册的 disposer（[packages/e2b/subprocess-e2b/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/invariant.ts#L28-L29)）

### packages/e2b/subprocess-e2b/src/output.ts

远程输出传输的解码器与有界收集读取器，被进程 handle 用来把沙箱里的 base64 帧还原成原始字节并对外投影。

- 定义保留完成帧常量 `!dsh-e2b-output-complete!`，作为远程编码器干净 EOF 的标记（[packages/e2b/subprocess-e2b/src/output.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L9)）
- `push` 把任意切分的回调文本累积后按换行切出完整帧，跨回调边界还原字节（[packages/e2b/subprocess-e2b/src/output.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L21-L29)）
- 遇到完成帧置位 `complete`，重复完成帧抛错（[packages/e2b/subprocess-e2b/src/output.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L30-L34)）
- 完成后再出现数据帧抛错（[packages/e2b/subprocess-e2b/src/output.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L35)）
- 每帧既过 base64 正则又做回环编码比对，不一致即抛错（[packages/e2b/subprocess-e2b/src/output.ts:36-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L36-L43)）
- `finish(false)` 丢弃残留半帧；`finish(true)` 在残留非空或未见完成帧时抛错（[packages/e2b/subprocess-e2b/src/output.ts:52-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L52-L61)）
- `size` 报告从 SDK 流观测到的总字节数（[packages/e2b/subprocess-e2b/src/output.ts:84-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L84-L86)）
- `invalidateSpill` 使后续读取不再对外给出远程溢出文件路径（[packages/e2b/subprocess-e2b/src/output.ts:88-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L88-L90)）
- `push` 累加总字节并把保留区从头部裁剪到 `maxBytes` 以内（[packages/e2b/subprocess-e2b/src/output.ts:97-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L97-L114)）
- `readFrom` 按偏移返回文本、下一偏移和 `lossy` 标记，起点早于保留区时从保留区头部开始（[packages/e2b/subprocess-e2b/src/output.ts:117-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L117-L125)）
- 仅当读取有损、溢出仍有效且总字节不超过 `maxSpillBytes` 时才附带 `spillPath`（[packages/e2b/subprocess-e2b/src/output.ts:126-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/output.ts#L126-L129)）

### packages/e2b/subprocess-e2b/src/process.ts

`E2BSubprocessHandle` 的实现：构造远程 wrapper 脚本、异步启动命令、投影输出与退出事实、并执行终止阶梯。

- `OUTPUT_ENCODER_SOURCE` 是注入沙箱的 Node 程序，把 stdin 每块按 base64 加换行写出，末尾写保留完成帧，并在写满时等 `drain`（[packages/e2b/subprocess-e2b/src/process.ts:26-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L26-L37)）
- `isValidProcessId` 要求进程号为正的安全整数（[packages/e2b/subprocess-e2b/src/process.ts:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L47-L49)）
- `DeferredStdin` 把每次写入推迟到远程 handle 就绪后经 `sendStdin` 发送，`_final` 时 `closeStdin`（[packages/e2b/subprocess-e2b/src/process.ts:51-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L51-L69)）
- `withinMs` 给结算加一个超时窗口，超时返回 `undefined`（[packages/e2b/subprocess-e2b/src/process.ts:83-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L83-L91)）
- 有溢出配置时 stdout/stderr 先经 `tee` 分流到 `head -c <maxBytes>` 限长的文件，再进 base64 编码器（[packages/e2b/subprocess-e2b/src/process.ts:95-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L95-L100)）
- 内层脚本用 `ps -o pgid=` 取自身进程组号并写入私有 pid 文件（[packages/e2b/subprocess-e2b/src/process.ts:111-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L111-L112)）
- 内层脚本读入私有 environment 文件后立即删除它，再用 `env -i` 带这份环境执行 argv（[packages/e2b/subprocess-e2b/src/process.ts:113-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L113-L115)）
- 内层脚本把命令退出码写入私有 status 文件，`wait` 等待所有重定向子进程后以同一退出码退出（[packages/e2b/subprocess-e2b/src/process.ts:116-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L116-L119)）
- bootstrap 用 `command -v` 从沙箱 PATH 解析 env/setsid/bash/node/ps/tr/tee/head/rm，任一不是绝对路径或不可执行就以 125 退出（[packages/e2b/subprocess-e2b/src/process.ts:124-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L124-L135)）
- bootstrap 以 `env -i` 携清洗后的环境 `exec` 到 `setsid --wait bash -c <inner>`，使命令自成进程组（[packages/e2b/subprocess-e2b/src/process.ts:136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L136)）
- `waitWithSignal` 让等待在信号中止时立即以 `WAIT_ABORTED` 返回（[packages/e2b/subprocess-e2b/src/process.ts:143-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L143-L156)）
- 构造函数把 pid、exit-code、environment、stdout.log、stderr.log 五个私有路径固定在状态目录下（[packages/e2b/subprocess-e2b/src/process.ts:199-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L199-L205)）
- 按 stdio 模式决定建立 `PassThrough` 管道还是有界收集读取器，并组装 `collected` 视图（[packages/e2b/subprocess-e2b/src/process.ts:206-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L206-L219)）
- stdin 为 `pipe` 时暴露 `DeferredStdin`，并监听 spec 信号触发 `terminate`；构造时若信号已中止立即终止（[packages/e2b/subprocess-e2b/src/process.ts:220-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L220-L226)）
- `pid` 在远程发布并校验通过前一直返回 `-1`（[packages/e2b/subprocess-e2b/src/process.ts:229-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L229-L231)）
- `terminate` 在已证明静默或已有终止尝试时直接返回，否则中止终止控制器、销毁两条输出流并启动远程终止（[packages/e2b/subprocess-e2b/src/process.ts:234-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L234-L248)）
- `waitForExit` 在已证明静默时直接返回 true（[packages/e2b/subprocess-e2b/src/process.ts:252-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L252-L253)）
- 已请求终止且进程组号尚未发布时，等待终止尝试结束并按其失败抛出，否则视为已静默（[packages/e2b/subprocess-e2b/src/process.ts:255-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L255-L271)）
- 未请求终止时等待就绪 handle，就绪失败则退回命令状态；命令从未成立即记为静默（[packages/e2b/subprocess-e2b/src/process.ts:272-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L272-L283)）
- 取沙箱时遇到 `SandboxNotFoundError` 即判定进程已静默并返回 true（[packages/e2b/subprocess-e2b/src/process.ts:285-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L285-L295)）
- 以已发布进程组号（否则退回 SDK pid）循环探活，每轮按 `pollMs` 等待，信号中止即返回 false（[packages/e2b/subprocess-e2b/src/process.ts:296-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L296-L304)）
- `run` 依次取沙箱、准备私有状态，随后以 `background: true`、`timeoutMs: 0`、指定 cwd 与控制环境启动 wrapper，并挂上 stdout/stderr 回调（[packages/e2b/subprocess-e2b/src/process.ts:318-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L318-L332)）
- SDK 返回非法 pid 时先 `handle.kill()` 回滚并标记静默，回滚失败则抛聚合错误（[packages/e2b/subprocess-e2b/src/process.ts:335-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L335-L349)）
- 进程组号发布失败时先回滚未发布的进程组，再抛出原错误或聚合错误（[packages/e2b/subprocess-e2b/src/process.ts:352-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L352-L363)）
- 发布成功后解析 `readyState`，写入批量 stdin，再等待命令结局（[packages/e2b/subprocess-e2b/src/process.ts:364-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L364-L366)）
- 输出传输错误优先于结局抛出；仅在未请求信号且未超排空宽限时才要求解码器见到完成帧（[packages/e2b/subprocess-e2b/src/process.ts:367-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L367-L371)）
- 失败路径先做已发布进程组回滚，再清理已创建的私有状态目录，清理失败合并成聚合错误（[packages/e2b/subprocess-e2b/src/process.ts:373-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L373-L385)）
- 失败时把 `commandState` 解析为 `undefined` 并拒绝 `readyState`，让等待方不再挂起（[packages/e2b/subprocess-e2b/src/process.ts:386-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L386-L387)）
- 在准备阶段被取消时把结局报成 `{ exitCode: null, signal: 'SIGTERM' }` 而不是抛错（[packages/e2b/subprocess-e2b/src/process.ts:388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L388)）
- `finally` 摘除 spec 信号监听并结束两条管道流（[packages/e2b/subprocess-e2b/src/process.ts:390-394](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L390-L394)）
- `prepareState` 先读远程环境并算出控制环境覆盖项（[packages/e2b/subprocess-e2b/src/process.ts:398-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L398-L400)）
- 在发出建目录请求前就标记目录已创建，使取消与创建竞争时仍会进入清理（[packages/e2b/subprocess-e2b/src/process.ts:401-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L401-L404)）
- 状态目录 `chmod 700`，写入 pid/status/environment 与按需的溢出文件后 `chmod 600`，最后再查一次取消信号（[packages/e2b/subprocess-e2b/src/process.ts:405-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L405-L421)）
- 批量 stdin 采用尽力而为语义，发送或关闭失败被吞掉，退出与输出仍是权威（[packages/e2b/subprocess-e2b/src/process.ts:424-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L424-L432)）
- `dispatchOutput` 解码失败时记录首个传输错误并以该错误销毁对应输出流（[packages/e2b/subprocess-e2b/src/process.ts:434-443](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L434-L443)）
- 解码出的字节先入收集读取器，再按模式写进管道或宿主进程的 stdout/stderr（[packages/e2b/subprocess-e2b/src/process.ts:444-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L444-L455)）
- `writeOutput` 在终止信号已置或无目标时直接丢弃数据，目标已销毁则抛错（[packages/e2b/subprocess-e2b/src/process.ts:458-461](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L458-L461)）
- 写满时等待 `drain`/`close`，或被终止信号与输出释放信号解除等待，保留背压（[packages/e2b/subprocess-e2b/src/process.ts:462-481](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L462-L481)）
- `waitForProcessGroupId` 轮询读取私有 pid 文件直到非空（[packages/e2b/subprocess-e2b/src/process.ts:489-495](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L489-L495)）
- 发布值必须是纯十进制安全整数，且拒绝 `<= 1` 的进程组号（[packages/e2b/subprocess-e2b/src/process.ts:496-504](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L496-L504)）
- 命令在发布进程组号前就结算则抛错（[packages/e2b/subprocess-e2b/src/process.ts:506-507](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L506-L507)）
- 有 pipe 输出时先等 SDK 结算，其余模式改为轮询控制面（[packages/e2b/subprocess-e2b/src/process.ts:520-521](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L520-L521)）
- 私有 status 文件里的退出码必须是十进制且不超过 255，否则抛错（[packages/e2b/subprocess-e2b/src/process.ts:523-528](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L523-L528)）
- 已见退出码但 SDK 流未在 `graceMs` 内排空时，标记排空超时、作废两侧溢出、释放输出等待并 `disconnect`，直接以该退出码返回（[packages/e2b/subprocess-e2b/src/process.ts:530-539](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L530-L539)）
- 未见退出码时按 `pollMs` 与 SDK 结算竞速继续轮询（[packages/e2b/subprocess-e2b/src/process.ts:541-544](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L541-L544)）
- `commandOutcome` 让 wrapper 发布的退出码优先于 SDK 结果，`CommandExitError` 在已请求信号时报成信号结局（[packages/e2b/subprocess-e2b/src/process.ts:548-559](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L548-L559)）
- `rollbackPublishedFailure` 在进程组已发布且尚未静默时触发终止并等待退出，回滚失败合并成聚合错误（[packages/e2b/subprocess-e2b/src/process.ts:561-573](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L561-L573)）
- `rollbackUnpublishedGroup` 以 SDK 命令 pid 当作临时进程组强杀并在成功后标记静默（[packages/e2b/subprocess-e2b/src/process.ts:575-582](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L575-L582)）
- `terminateRemote` 把 `SandboxNotFoundError` 当作已静默处理（[packages/e2b/subprocess-e2b/src/process.ts:584-594](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L584-L594)）
- 命令从未成立时直接标记静默；SDK pid 非法且尚无发布组号时退回 `handle.kill()`（[packages/e2b/subprocess-e2b/src/process.ts:597-606](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L597-L606)）
- `terminateGroup` 先记 `SIGTERM` 并发 TERM，宽限内证明退出即静默，否则升级为 `SIGKILL` 强杀（[packages/e2b/subprocess-e2b/src/process.ts:612-626](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L612-L626)）
- `forceKillGroup` 先发组 KILL、再调 SDK kill，两者失败都吞掉，最终以探活结果判定，仍存活则抛错（[packages/e2b/subprocess-e2b/src/process.ts:628-641](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L628-L641)）
- `waitForGroupExit` 以 `graceMs` 为截止时间按 `pollMs` 轮询探活（[packages/e2b/subprocess-e2b/src/process.ts:643-650](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L643-L650)）
- `groupAlive` 用 `ps -eo pgid=,stat=` 配 awk 判定组内是否有非僵尸成员，沙箱消失时按不存活处理（[packages/e2b/subprocess-e2b/src/process.ts:656-666](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L656-L666)）
- `finalizeSpills` 在排空超时、输出未超内存上限、或超过溢出上限三种情况下删除远程溢出文件（[packages/e2b/subprocess-e2b/src/process.ts:668-683](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L668-L683)）
- `removeFailedState` 删除私有 environment 文件与状态目录，容忍 `FileNotFoundError`，其余失败聚合抛出（[packages/e2b/subprocess-e2b/src/process.ts:685-697](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/process.ts#L685-L697)）

### packages/e2b/subprocess-e2b/src/remote.ts

共享的远程控制辅助函数，被同包的进程与终端两条路径共同使用。

- `asError` 把任意抛出值规范化成 `Error`（[packages/e2b/subprocess-e2b/src/remote.ts:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/remote.ts#L15-L17)）
- `signalOpts` 在信号缺省时省略该字段而不是传 `undefined`（[packages/e2b/subprocess-e2b/src/remote.ts:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/remote.ts#L24-L26)）
- `commandOpts` 把控制环境经 `e2bControlEnvs` 包装后作为每次控制命令的环境（[packages/e2b/subprocess-e2b/src/remote.ts:34-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/remote.ts#L34-L39)）
- `delay` 提供一次定时等待（[packages/e2b/subprocess-e2b/src/remote.ts:46-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/remote.ts#L46-L48)）
- `waitTick` 等满一个轮询周期返回 true，被信号中止则清掉定时器并返回 false（[packages/e2b/subprocess-e2b/src/remote.ts:56-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/remote.ts#L56-L69)）
- `signalRemoteGroups` 用一条 `kill -<SIG> -- -<pgid>...` 向多个远程进程组发信号，并容忍 `CommandExitError` 与 `SandboxNotFoundError`（[packages/e2b/subprocess-e2b/src/remote.ts:89-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/remote.ts#L89-L96)）

### packages/e2b/subprocess-e2b/src/terminal.ts

远程 PTY 的分配、启动握手与会话级拆卸实现，`E2BTerminalHandle` 与 `spawnE2BTerminal` 供插件入口的 `spawnTerminal` 调用。

- 终端 runner 脚本读入私有 environment/argv/marker 文件后立即删除这四个文件（含自身）（[packages/e2b/subprocess-e2b/src/terminal.ts:33-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L33-L37)）
- runner 在 argv 为空时以 125 退出，否则先打印 marker 再 `exec env -i` 带清洗后的环境执行 argv（[packages/e2b/subprocess-e2b/src/terminal.ts:38-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L38-L43)）
- `BootstrapOutputFilter` 在 marker 出现前扣住所有 PTY 输出，只保留不超过 marker 长度减一的尾部用于跨块匹配（[packages/e2b/subprocess-e2b/src/terminal.ts:68-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L68-L79)）
- 匹配到 marker 后解析 `ready` 并只把 marker 之后的数据写入对外输出流（[packages/e2b/subprocess-e2b/src/terminal.ts:80-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L80-L88)）
- `waitForBootstrapOutput` 在 marker 出现前若命令先结算则拒绝，信号中止则以中止原因拒绝（[packages/e2b/subprocess-e2b/src/terminal.ts:96-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L96-L118)）
- `parsePositiveId` 要求纯十进制正整数且为安全整数，否则抛出调用方给定的错误（[packages/e2b/subprocess-e2b/src/terminal.ts:121-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L121-L126)）
- `serializeValues` 拒绝含 NUL 的 argv 值并按 NUL 结尾序列化（[packages/e2b/subprocess-e2b/src/terminal.ts:128-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L128-L133)）
- `terminalSessionId` 用 `ps -o sid= -p <pid>` 解析 PTY 的 POSIX 会话号（[packages/e2b/subprocess-e2b/src/terminal.ts:135-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L135-L144)）
- `sessionProcessGroups` 用 `ps -eo sid=,pgid=,stat=` 配 awk 列出该会话内所有非僵尸进程组，沙箱消失时返回空列表（[packages/e2b/subprocess-e2b/src/terminal.ts:151-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L151-L160)）
- 会话内出现非法或 `<= 1` 的进程组号时抛错，其余去重返回（[packages/e2b/subprocess-e2b/src/terminal.ts:161-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L161-L173)）
- `awaitSessionEmpty` 在 `graceMs` 截止前轮询会话进程组，`kill` 模式下每轮向剩余组发 KILL（[packages/e2b/subprocess-e2b/src/terminal.ts:184-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L184-L195)）
- `rollbackUnpublishedTerminal` 在会话号查询失败时退回用 PTY leader 的 pid 当作临时会话号（[packages/e2b/subprocess-e2b/src/terminal.ts:211-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L211-L222)）
- 回滚先对会话内各组发 TERM 并等空，未空则进入 KILL 轮次（[packages/e2b/subprocess-e2b/src/terminal.ts:223-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L223-L233)）
- 顶层进程未退出时调 SDK `kill()` 并在 `graceMs` 内等其结算（[packages/e2b/subprocess-e2b/src/terminal.ts:237-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L237-L245)）
- 回滚以最后一次会话探测和顶层退出事实作为静默证明，任一未达成即抛聚合错误（[packages/e2b/subprocess-e2b/src/terminal.ts:246-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L246-L269)）
- 证明静默后 `disconnect` SDK 流，沙箱消失被容忍（[packages/e2b/subprocess-e2b/src/terminal.ts:270-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L270-L274)）
- 终端 handle 以 SDK 命令 pid 作为对外 `pid`，并在构造时启动结局等待（[packages/e2b/subprocess-e2b/src/terminal.ts:299-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L299-L300)）
- `write` 在顶层已退出时抛错，否则把 UTF-8 字节经 `pty.sendInput` 送入远程终端（[packages/e2b/subprocess-e2b/src/terminal.ts:306-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L306-L311)）
- `signalForeground` 先解析前台进程组，无法解析即抛错（[packages/e2b/subprocess-e2b/src/terminal.ts:319-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L319-L324)）
- 拒绝对终端外壳自身的进程组发 `SIGKILL`（[packages/e2b/subprocess-e2b/src/terminal.ts:325-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L325-L327)）
- 其余信号以 `kill -<SIG> -- -<pgid>` 发给前台组并返回该组号（[packages/e2b/subprocess-e2b/src/terminal.ts:328-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L328-L332)）
- `terminate` 复用同一个 cleanup promise，先中止所有在途操作，失败后清空以便重试（[packages/e2b/subprocess-e2b/src/terminal.ts:337-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L337-L346)）
- `inspectForegroundOnce` 用 `ps -o tpgid=` 取前台组，并固定报告 `inputWaiting: false`（[packages/e2b/subprocess-e2b/src/terminal.ts:351-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L351-L364)）
- `ps` 以退出码 1 结束或顶层已退出时前台查询返回 `undefined` 而不是抛错（[packages/e2b/subprocess-e2b/src/terminal.ts:365-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L365-L368)）
- `trackOperation` 在终止后拒绝新操作，并把在途操作登记到集合供拆卸等待（[packages/e2b/subprocess-e2b/src/terminal.ts:371-382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L371-L382)）
- `closeAfterOperations` 先等所有在途操作结算再执行一次关闭（[packages/e2b/subprocess-e2b/src/terminal.ts:384-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L384-L387)）
- `waitForCommand` 把 `CommandExitError` 在已请求信号时报成信号结局，否则报退出码；其他错误销毁输出流并抛出（[packages/e2b/subprocess-e2b/src/terminal.ts:389-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L389-L400)）
- 无论结局如何都置位顶层已退出并结束对外输出流（[packages/e2b/subprocess-e2b/src/terminal.ts:401-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L401-L404)）
- `closeOnce` 先向会话内各组发 TERM 并等会话清空（[packages/e2b/subprocess-e2b/src/terminal.ts:408-413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L408-L413)）
- 会话已空但顶层未退出时，在 `graceMs` 内等待结局（[packages/e2b/subprocess-e2b/src/terminal.ts:414-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L414-L416)）
- 仍有存活组或顶层未退出时升级为 `SIGKILL`，调 SDK `kill()` 并做 KILL 轮次的清空等待（[packages/e2b/subprocess-e2b/src/terminal.ts:417-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L417-L429)）
- 仍有存活组或顶层仍未退出时抛出带幸存组号/pid 的错误（[packages/e2b/subprocess-e2b/src/terminal.ts:430-435](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L430-L435)）
- 静默后 `disconnect` 并删除私有状态目录，删除失败被吞掉（[packages/e2b/subprocess-e2b/src/terminal.ts:436-445](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L436-L445)）
- `spawnE2BTerminal` 为每次启动生成随机 marker，并把 runner/environment/argv/marker 四个私有文件路径固定在状态目录下（[packages/e2b/subprocess-e2b/src/terminal.ts:466-474](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L466-L474)）
- 启动前读远程环境、算控制环境覆盖项、序列化显式环境与 argv（[packages/e2b/subprocess-e2b/src/terminal.ts:480-483](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L480-L483)）
- 状态目录建好后 `chmod 700`，四个私有文件写入后 `chmod 600`（[packages/e2b/subprocess-e2b/src/terminal.ts:484-499](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L484-L499)）
- 以请求的行列数、cwd、控制环境与 `timeoutMs: 0` 创建 PTY，并把数据回调接到 marker 过滤器（[packages/e2b/subprocess-e2b/src/terminal.ts:500-507](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L500-L507)）
- PTY 返回非法 pid 时抛错（[packages/e2b/subprocess-e2b/src/terminal.ts:511-513](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L511-L513)）
- 向 PTY 送入一行 `exec /bin/bash <runner> <stateDir>`，把 E2B 的引导壳替换成请求的 argv（[packages/e2b/subprocess-e2b/src/terminal.ts:514-515](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L514-L515)）
- 只有在 marker 到达并解析出会话号后才返回终端 handle（[packages/e2b/subprocess-e2b/src/terminal.ts:516-528](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L516-L528)）
- 启动失败时销毁输出流，并按是否已拿到 SDK handle 选择 `kill()` 或完整会话回滚（[packages/e2b/subprocess-e2b/src/terminal.ts:529-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L529-L543)）
- 清理阶段删除私有状态目录，`FileNotFoundError` 与 `SandboxNotFoundError` 视为已删除（[packages/e2b/subprocess-e2b/src/terminal.ts:545-553](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L545-L553)）
- 清理本身失败时抛出以原错误消息为标题的聚合错误，否则原样抛出启动错误（[packages/e2b/subprocess-e2b/src/terminal.ts:554-565](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/subprocess-e2b/src/terminal.ts#L554-L565)）

### packages/e2b/subprocess-e2b/tsconfig.json

包级 TypeScript 编译配置，声明源码根、类型输出目录与工作区引用。

- 无运行期机制
