---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/terminal/terminal-bash
---

# packages/terminal/terminal-bash

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、116 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/terminal/terminal-bash/README.md

持久 shell PTY 后端包的说明文档，描述挂载方式、配置字段、就绪判定与失败情形，供阅读者使用。

- 无运行期机制

### packages/terminal/terminal-bash/package.json

该包的 npm 清单，声明入口、导出映射、发布文件与依赖。

- `main` / `types` 把包入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/terminal/terminal-bash/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/terminal/terminal-bash/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/terminal/terminal-bash/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/package.json#L28-L32)）
- `type: module` 使产物按 ESM 解析（[packages/terminal/terminal-bash/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/package.json#L13)）
- `dependencies` 把 pwsh 路径解析包、schemastery 与 `@xterm/headless` 列为运行期真实依赖（[packages/terminal/terminal-bash/package.json:44-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/package.json#L44-L48)）

### packages/terminal/terminal-bash/src/config.ts

后端的配置类型、Schemastery 默认值、按方言的 argv 解析与数值校验，被 `src/index.ts` 的 `apply` 调用。

- 定义 bash 方言默认可执行文件 `/bin/bash` 与默认参数 `--noprofile --norc -i`，以及 pwsh 默认参数 `-NoLogo -NoProfile`（[packages/terminal/terminal-bash/src/config.ts:53-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L53-L58)）
- `resolveConfig` 把未设置的 `shellDialect` 定为 `bash`（[packages/terminal/terminal-bash/src/config.ts:69-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L69-L70)）
- `shellPath` 为空或未设时按方言取 `resolvePwshPath()` 或 `/bin/bash`，非空显式值优先（[packages/terminal/terminal-bash/src/config.ts:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L74-L76)）
- `shellArgs` 为空数组或未设时按方言取默认参数（[packages/terminal/terminal-bash/src/config.ts:77-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L77-L79)）
- Schemastery 给出 `backendType=shell`、`rows=40`、`cols=160`、`scrollbackLines=10000`、`scrollbackMaxBytes=4MiB`、`maxReadBytes=256KiB` 的默认值（[packages/terminal/terminal-bash/src/config.ts:84-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L84-L93)）
- Schemastery 给出就绪时序默认值 `pollIntervalMs=50`、`exactProbeAfterMs=150`、`idleSilenceMs=3000`、`handoffGraceMs=500`、`timeoutMs=30000`、`disposeGraceMs=3000`（[packages/terminal/terminal-bash/src/config.ts:94-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L94-L99)）
- `validateConfig` 在 `backendType` 或 `shellPath` 为空串时抛错（[packages/terminal/terminal-bash/src/config.ts:109-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L109-L110)）
- `validateConfig` 遍历所有数值字段，非正安全整数即抛错（[packages/terminal/terminal-bash/src/config.ts:111-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L111-L115)）
- `validateConfig` 拒绝 `maxReadBytes` 超过 `scrollbackMaxBytes` 的组合（[packages/terminal/terminal-bash/src/config.ts:116-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L116-L118)）
- `validateConfig` 拒绝 `handoffGraceMs` 小于 `pollIntervalMs` 的组合（[packages/terminal/terminal-bash/src/config.ts:119-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/config.ts#L119-L121)）

### packages/terminal/terminal-bash/src/index.ts

插件入口：注册后端类型、装设沙箱模式栅栏、拼装 argv 与环境变量、执行启动序列，`apply` 由 Cordis 加载器调用。

- 插件声明依赖 `terminals`、`sandboxPolicy`、`subprocess` 三个服务（[packages/terminal/terminal-bash/src/index.ts:23-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L23-L26)）
- 已存在的栅栏只刷新其持有的 `terminals` 与 `sandboxPolicy` 引用，不重复注册监听（[packages/terminal/terminal-bash/src/index.ts:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L36-L41)）
- 在 owner 的上下文上注册 global `internal/dispatch` 监听，拦截该会话的 `sandbox/mode` 事件（[packages/terminal/terminal-bash/src/index.ts:42-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L42-L47)）
- 当目标模式与当前生效模式不同且该 owner 仍有终端活动时抛错，阻止事件提交（[packages/terminal/terminal-bash/src/index.ts:48-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L48-L53)）
- `childEnvironment` 为子进程注入 `TERM=dumb`、`PAGER=cat`、`GIT_PAGER=cat`、`DSH_SHELL`、`DSH_SESSION_ID`、`DSH_PTY_SESSION_ID`（[packages/terminal/terminal-bash/src/index.ts:59-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L59-L66)）
- pwsh 方言额外注入 `NO_COLOR=1`（[packages/terminal/terminal-bash/src/index.ts:67-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L67-L70)）
- bash 方言注入 `PS1` 为受控提示符，并用 `PROMPT_COMMAND` 在每次提示前打印 `\033]133;D;$?\007` 并重置 `PS1`，同时设 `BASH_SILENCE_DEPRECATION_WARNING`（[packages/terminal/terminal-bash/src/index.ts:72-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L72-L80)）
- `PWSH_PROMPT_SETUP` 定义 pwsh 的 prompt 函数，用 `[char]27`/`[char]7` 在每次提示前写出同一 OSC 标记并输出受控提示符（[packages/terminal/terminal-bash/src/index.ts:89-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L89-L90)）
- `spawnArgv` 在 `danger-full-access` 模式下直接返回 shell argv（[packages/terminal/terminal-bash/src/index.ts:92-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L92-L94)）
- 受限模式下缺少同世界 `ctx.sandbox` 提供者即抛错，否则用 `sandbox.confine` 包裹 argv（[packages/terminal/terminal-bash/src/index.ts:95-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L95-L100)）
- bash 方言的启动直接走 `session.initialize(signal)`（[packages/terminal/terminal-bash/src/index.ts:113-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L113-L116)）
- pwsh 首轮通过会话写入 `ENCODING_PREAMBLE + PWSH_PROMPT_SETUP` 并提交，其后各轮发送空文本且不提交（[packages/terminal/terminal-bash/src/index.ts:124-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L124-L131)）
- pwsh 启动循环遇 `session_exit` 或 `timeout` 抛错，仅在 `stdin_read` 时退出并把 viewport 写入 `session.motd`（[packages/terminal/terminal-bash/src/index.ts:132-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L132-L137)）
- 调用方 `signal` 中止时以 `signal.reason` reject 启动竞速（[packages/terminal/terminal-bash/src/index.ts:141-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L141-L146)）
- pwsh 启动另加一个覆盖整个循环的 `timeoutMs` 绝对截止定时器，触发时取消在途发送并 reject（[packages/terminal/terminal-bash/src/index.ts:147-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L147-L155)）
- 启动前先 `throwIfAborted`，随后竞速执行；`finally` 清定时器并摘除 abort 监听（[packages/terminal/terminal-bash/src/index.ts:156-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L156-L162)）
- 后端对外类型取自 `config.backendType`，并可注入自定义的 `spawnTerminal` 与 `createSession`（[packages/terminal/terminal-bash/src/index.ts:166-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L166-L181)）
- `spawn` 先 `throwIfAborted`、装设沙箱栅栏、按 owner 会话解析策略并构建 argv，空 argv 抛错（[packages/terminal/terminal-bash/src/index.ts:183-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L183-L188)）
- `spawnTerminal` 以请求 cwd 或策略工作区根为工作目录，并传入环境、`rows`/`cols`、`disposeGraceMs` 与取消信号（[packages/terminal/terminal-bash/src/index.ts:189-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L189-L197)）
- 启动失败时关闭会话；若关闭也失败则抛出 `TerminalBackendCleanupError` 携带两个错误，否则抛出原错误（[packages/terminal/terminal-bash/src/index.ts:199-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L199-L209)）
- `apply` 先解析并校验配置，再把后端注册到 `ctx.terminals`（[packages/terminal/terminal-bash/src/index.ts:214-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/index.ts#L214-L218)）

### packages/terminal/terminal-bash/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包所有权。

- installer 为空函数，不安装任何运行期检查（[packages/terminal/terminal-bash/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/invariant.ts#L17-L21)）
- `apply` 以包名向 `ctx.invariants` 注册并返回注册的 disposer（[packages/terminal/terminal-bash/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/invariant.ts#L28-L29)）

### packages/terminal/terminal-bash/src/sanitize.ts

流式终端控制序列清洗器与行归一化函数，被 `session.ts` 用来把 PTY 原始数据投影成返回给上层的文本。

- 定义提示符 OSC 标记前缀 `133;D;` 与受控提示符 `dsh> `（[packages/terminal/terminal-bash/src/sanitize.ts:5-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L5-L9)）
- `push` 先把新 chunk 交给丢弃模式处理再追加到 pending（[packages/terminal/terminal-bash/src/sanitize.ts:38-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L38-L39)）
- 扫描到 ESC 之前的文本直接作为可打印输出累加，并在跟踪状态下同时累加到 promptTail（[packages/terminal/terminal-bash/src/sanitize.ts:45-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L45-L56)）
- OSC 序列按 BEL 或 ESC-反斜杠取较早的终止位置并整段丢弃（[packages/terminal/terminal-bash/src/sanitize.ts:62-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L62-L74)）
- OSC 内容以 `133;D;` 开头时置 `prompt=true` 并重置 promptTail 跟踪（[packages/terminal/terminal-bash/src/sanitize.ts:75-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L75-L82)）
- CSI 序列扫描到 0x40–0x7e 的终止字节并整段丢弃（[packages/terminal/terminal-bash/src/sanitize.ts:84-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L84-L96)）
- 其余两字节转义直接跳过两个字符（[packages/terminal/terminal-bash/src/sanitize.ts:98-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L98-L99)）
- 未终止的序列保留在 pending 中等待下一 chunk（[packages/terminal/terminal-bash/src/sanitize.ts:57-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L57-L60)）
- `push` 返回归一化文本、prompt 标志与可选 promptTail（[packages/terminal/terminal-bash/src/sanitize.ts:101-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L101-L107)）
- `flush` 在 pending 以 ESC 开头时整体丢弃，重置全部状态，并为悬挂的回车补一个换行（[packages/terminal/terminal-bash/src/sanitize.ts:114-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L114-L124)）
- `normalizeText` 把跨 chunk 的尾随回车前置回下一段文本，并把新的尾随回车挂起（[packages/terminal/terminal-bash/src/sanitize.ts:126-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L126-L134)）
- pending 超过 `maxPendingBytes` 时清空缓冲并进入 osc 或 csi 丢弃模式（[packages/terminal/terminal-bash/src/sanitize.ts:136-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L136-L140)）
- csi 丢弃模式扫到终止字节后恢复并返回其后的剩余数据（[packages/terminal/terminal-bash/src/sanitize.ts:142-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L142-L153)）
- osc 丢弃模式扫到 BEL 或 ESC-反斜杠后恢复，并用 `discardOscEscape` 记住跨 chunk 断开的 ESC（[packages/terminal/terminal-bash/src/sanitize.ts:155-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L155-L177)）
- `normalizeTerminalText` 把 CRLF 与独立 CR 一律换成 `\n` 并删除 BEL（[packages/terminal/terminal-bash/src/sanitize.ts:186-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/sanitize.ts#L186-L188)）

### packages/terminal/terminal-bash/src/session.ts

`LocalPtySession`：一个持久 PTY 会话的发送生命周期、就绪轮询、有界回滚缓冲、信号与关闭，由 `src/index.ts` 的后端创建。

- 通过 `createRequire` 以命名导出方式加载 `@xterm/headless` 的 `Terminal`（[packages/terminal/terminal-bash/src/session.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L28-L29)）
- `utf8Tail` 按 UTF-8 字节从尾部保留不超过上限的字符并标记是否截断（[packages/terminal/terminal-bash/src/session.ts:31-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L31-L43)）
- `BoundedTextBuffer.append` 超过行数上限时丢弃最旧行、再按字节上限截尾，两者都置 `dropped`（[packages/terminal/terminal-bash/src/session.ts:54-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L54-L67)）
- `consume` 取走全部增量并清空缓冲与截断标记（[packages/terminal/terminal-bash/src/session.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L69-L75)）
- 发送操作只在未结算时累积输出（[packages/terminal/terminal-bash/src/session.ts:112-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L112-L114)）
- `settle` 只生效一次，用缓冲快照作 viewport，并把继承的截断标记并入结果（[packages/terminal/terminal-bash/src/session.ts:116-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L116-L126)）
- `fail` 只生效一次并 reject 发送 promise（[packages/terminal/terminal-bash/src/session.ts:128-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L128-L132)）
- `setInitialForeground` 记录写入前的前台进程组与其是否已在等待 stdin（[packages/terminal/terminal-bash/src/session.ts:138-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L138-L141)）
- `acceptsStdinWait` 对同一进程组要求先观察到离开等待、再回到等待才承认为写后证据（[packages/terminal/terminal-bash/src/session.ts:143-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L143-L150)）
- `cancel` 在未结算时置取消标记并触发会话的中断回调（[packages/terminal/terminal-bash/src/session.ts:152-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L152-L157)）
- 构造时以 `scrollback: 0` 建立 headless 终端，仅用于协议状态（[packages/terminal/terminal-bash/src/session.ts:206-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L206-L207)）
- headless 终端产生的协议回复被串行写回 provider，写失败且非关闭中时转为传输失败（[packages/terminal/terminal-bash/src/session.ts:208-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L208-L218)）
- 按配置建立清洗器与回滚缓冲，并订阅 provider 输出的 data/end/error 及进程结束（[packages/terminal/terminal-bash/src/session.ts:219-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L219-L227)）
- `initialize` 用一次空发送走同一就绪合同，`session_exit`/`timeout` 抛错，成功时把 viewport 存为 motd（[packages/terminal/terminal-bash/src/session.ts:235-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L235-L249)）
- `startSend` 在关闭中、已退出、已有活动发送（`SEND_ACTIVE`）或信号已中止时抛错（[packages/terminal/terminal-bash/src/session.ts:251-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L251-L262)）
- 建立发送操作后立即重置就绪证据并占据活动槽（[packages/terminal/terminal-bash/src/session.ts:264-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L264-L270)）
- 请求信号的 abort 被接成 `operation.cancel()`（[packages/terminal/terminal-bash/src/session.ts:272-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L272-L276)）
- `timeoutMs` 到期以 `timeout` 结算，并在写入在途、中断在途或协议未静默时保留槽位所有权（[packages/terminal/terminal-bash/src/session.ts:277-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L277-L283)）
- `beginSend` 写入前先排空终端协议、采样前台状态，协议状态变化则重新采样（[packages/terminal/terminal-bash/src/session.ts:288-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L288-L297)）
- 写入前采样失败时，只有槽位仍属该未结算发送且非关闭中、非中断中才让发送失败（[packages/terminal/terminal-bash/src/session.ts:298-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L298-L310)）
- 实际写入 `text` 加可选回车，写前再次重置就绪证据并登记在途写入（[packages/terminal/terminal-bash/src/session.ts:312-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L312-L324)）
- 已请求取消时交由取消路径接管；已结算则释放槽位；否则开始就绪轮询（[packages/terminal/terminal-bash/src/session.ts:325-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L325-L336)）
- `resetReadinessEvidence` 清空提示符标记、提示符尾串并把静默计时归零（[packages/terminal/terminal-bash/src/session.ts:345-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L345-L350)）
- `read` 校验 offset 为非负安全整数、count 为正安全整数，否则抛错（[packages/terminal/terminal-bash/src/session.ts:356-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L356-L359)）
- `read` 以最新行为基准做倒序分页，超出总行数时返回空页（[packages/terminal/terminal-bash/src/session.ts:360-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L360-L365)）
- `read` 结果再按 `maxReadBytes` 截尾，并返回总行数、行区间与合并后的截断标记（[packages/terminal/terminal-bash/src/session.ts:366-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L366-L374)）
- `signal` 在关闭中抛错，否则把信号投递到前台进程组并回传目标 pgid（[packages/terminal/terminal-bash/src/session.ts:377-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L377-L381)）
- `close` 立即置 closing、复用同一 close promise，失败时清除缓存并让活动发送以该错误失败（[packages/terminal/terminal-bash/src/session.ts:387-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L387-L397)）
- PTY data 回调以流式解码 UTF-8，同一份数据同时喂给 headless 终端与清洗器（[packages/terminal/terminal-bash/src/session.ts:399-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L399-L404)）
- 输出 end 时冲刷解码器与清洗器残留、关闭 headless 终端并解析输出结束（[packages/terminal/terminal-bash/src/session.ts:406-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L406-L411)）
- 输出 error 时关闭终端、转入传输失败并解析输出结束（[packages/terminal/terminal-bash/src/session.ts:413-417](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L413-L417)）
- 观察到提示符标记时置 `promptSeen`、清空尾串并刷新静默计时（[packages/terminal/terminal-bash/src/session.ts:419-431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L419-L431)）
- 标记后累计的可打印尾串与受控提示符逐字比对置 `promptTextSeen`，多出内容则用哨兵串使其失配（[packages/terminal/terminal-bash/src/session.ts:432-437](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L432-L437)）
- 进程退出时先等输出结束，无传输失败则记录退出码/信号并把活动发送结算为 `session_exit`（[packages/terminal/terminal-bash/src/session.ts:440-445](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L440-L445)）
- 传输失败保留首个错误、把状态置为 exited、关闭终端、让活动发送失败并终止进程树（[packages/terminal/terminal-bash/src/session.ts:447-454](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L447-L454)）
- `appendOutput` 刷新静默计时并把文本同时写入回滚缓冲与活动发送缓冲（[packages/terminal/terminal-bash/src/session.ts:456-461](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L456-L461)）
- `schedulePoll` 在槽位不匹配、正在中断或已在轮询时不排程，否则按间隔重排定时器（[packages/terminal/terminal-bash/src/session.ts:463-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L463-L470)）
- 轮询首先在会话已退出时结算为 `session_exit`（[packages/terminal/terminal-bash/src/session.ts:476-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L476-L479)）
- 轮询在采样前排空协议回复，采样期间协议状态变化则重新采样（[packages/terminal/terminal-bash/src/session.ts:480-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L480-L487)）
- 首次见到提示符时把当时的前台进程组记为 shell 自身的 pgid（[packages/terminal/terminal-bash/src/session.ts:489-491](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L489-L491)）
- 提示符标记加精确尾串、静默达一个轮询间隔且前台已回到 shell 时结算为 `stdin_read`（[packages/terminal/terminal-bash/src/session.ts:492-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L492-L496)）
- 超过 `exactProbeAfterMs` 且前台被判定为写后 stdin 等待时结算为 `stdin_read`；启动期还要求已有输出（[packages/terminal/terminal-bash/src/session.ts:497-504](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L497-L504)）
- 静默达 `idleSilenceMs`（见过提示符时再加 `handoffGraceMs`）结算为 `inferred_idle`（[packages/terminal/terminal-bash/src/session.ts:509-512](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L509-L512)）
- 轮询抛错时先排空协议，再在槽位仍属该发送且非关闭、非中断时让其失败（[packages/terminal/terminal-bash/src/session.ts:513-515](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L513-L515)）
- 轮询收尾清标志，并在轮询目标仍是当前活动发送时排下一轮（[packages/terminal/terminal-bash/src/session.ts:516-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L516-L522)）
- `drainTerminalProtocol` 反复等待终端写入与回复写入，直到两者引用未变且无待处理协议工作（[packages/terminal/terminal-bash/src/session.ts:526-535](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L526-L535)）
- `inspectForegroundAfterProtocol` 只接受整个采样期间协议保持安静的前台样本（[packages/terminal/terminal-bash/src/session.ts:538-546](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L538-L546)）
- `protocolStateChanged` / `protocolWorkPending` 以写入 promise 引用与待写回复计数判断协议是否活跃（[packages/terminal/terminal-bash/src/session.ts:548-555](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L548-L555)）
- `queueEmulatorData` 在终端未关闭时缓冲数据，并为这批写入建立一个可解析的空闲 promise（[packages/terminal/terminal-bash/src/session.ts:557-566](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L557-L566)）
- `pumpEmulator` 串行写入 headless 终端；缓冲排空后解析空闲 promise 并尝试释放已结算槽位（[packages/terminal/terminal-bash/src/session.ts:568-584](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L568-L584)）
- 终端写入抛错时清空缓冲、解析空闲 promise，并在非关闭中转为传输失败（[packages/terminal/terminal-bash/src/session.ts:585-593](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L585-L593)）
- `releaseSettledActive` 仅在无在途写入、无中断、协议已静默时才清空已结算的活动槽（[packages/terminal/terminal-bash/src/session.ts:601-606](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L601-L606)）
- `closeEmulator` 幂等地清缓冲、解析空闲 promise 并释放 headless 终端与其数据订阅（[packages/terminal/terminal-bash/src/session.ts:608-618](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L608-L618)）
- `settleActive` 在保留所有权时只停轮询与摘 abort 监听，否则清空槽位，并把回滚截断标记并入结果（[packages/terminal/terminal-bash/src/session.ts:620-632](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L620-L632)）
- `stopPolling`/`stopReadinessPolling`/`clearActive` 清理轮询定时器、绝对超时定时器、abort 监听、中断标记与活动槽（[packages/terminal/terminal-bash/src/session.ts:634-654](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L634-L654)）
- `failActive` 先清空槽位再让操作以该错误 reject（[packages/terminal/terminal-bash/src/session.ts:656-661](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L656-L661)）
- `interrupt` 标记中断中、停止就绪轮询并启动一次中断流程（[packages/terminal/terminal-bash/src/session.ts:663-668](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L663-L668)）
- `interruptOnce` 先等在途 provider 写入落地，写入失败则不发信号；否则向前台进程组投递真实 `SIGINT`（[packages/terminal/terminal-bash/src/session.ts:670-677](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L670-L677)）
- 中断结束后按结算状态释放槽位，或以 0 延迟立刻恢复就绪轮询（[packages/terminal/terminal-bash/src/session.ts:678-687](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L678-L687)）
- `closeOnce` 停轮询但保留活动发送，关终端，`terminate` 失败时抛出携带原因的 `PTY cleanup failed`（[packages/terminal/terminal-bash/src/session.ts:689-699](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L689-L699)）
- 终止成功后把活动发送结算为 `session_exit`、等待完成、摘除全部输出监听，并把记录的传输失败重新抛出（[packages/terminal/terminal-bash/src/session.ts:700-707](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/terminal-bash/src/session.ts#L700-L707)）

### packages/terminal/terminal-bash/tsconfig.json

该包的 TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
