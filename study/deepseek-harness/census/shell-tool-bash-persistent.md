---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/tool-bash-persistent
---

# packages/shell/tool-bash-persistent

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、45 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/tool-bash-persistent/README.md

该包的说明文档，描述持久 bash 工具的选型、配置字段、结果文本与已知限制。

- 无运行期机制

### packages/shell/tool-bash-persistent/package.json

该包的 npm 清单，声明模块类型、入口解析与发布内容。

- 声明 ESM 模块类型，并把默认入口与类型入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/shell/tool-bash-persistent/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/package.json#L13-L15)）
- `exports` 暴露主入口、`./invariant` 伴随插件与 `./package.json` 三个子路径，不暴露源码目录（[packages/shell/tool-bash-persistent/package.json:16-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/package.json#L16-L26)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/shell/tool-bash-persistent/package.json:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/package.json#L27-L31)）

### packages/shell/tool-bash-persistent/src/index.ts

插件入口，在按调用方 Agent 隔离的 PTY 会话上注册一个跨调用保留状态的 `bash` 工具，并负责命令包裹、回滚缓冲轮询、抽取与渲染。

- 定义三段模型可见的固定文本：输出被裁剪的提示、回滚缓冲丢头的提示、以及 shell 被重置后下次调用从工作区重新开始的提示（[packages/shell/tool-bash-persistent/src/index.ts:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L15-L17)）
- 固定回滚缓冲分页为 1000 行、轮询间隔为 25 毫秒（[packages/shell/tool-bash-persistent/src/index.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L21-L22)）
- 默认工具描述声明状态（当前目录与导出的环境变量）在本 Agent 的多次调用间保留（[packages/shell/tool-bash-persistent/src/index.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L24)）
- `maybeTruncate` 超过上限时按字符截断并追加裁剪提示，未超限但标记为不完整时也追加该提示（[packages/shell/tool-bash-persistent/src/index.ts:54-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L54-L59)）
- 每条命令生成一对带随机 nonce 的起止标记（[packages/shell/tool-bash-persistent/src/index.ts:61-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L61-L67)）
- `quoteForBash` 把反斜杠、单引号、回车与换行转义进 `$'…'` 字面量（[packages/shell/tool-bash-persistent/src/index.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L69-L75)）
- `wrapCommand` 在一条物理行内打印起标记、用 `eval --` 执行命令体、捕获 `$?` 并打印结束标记加状态码（[packages/shell/tool-bash-persistent/src/index.ts:77-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L77-L82)）
- `commandOutput` 以最后一个结束标记为锚，只有紧随其后是数字状态码才认定命令完成，并截取起止标记之间的正文（[packages/shell/tool-bash-persistent/src/index.ts:88-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L88-L102)）
- 起标记已滚出缓冲时从文本开头截取并把结果标为不完整（[packages/shell/tool-bash-persistent/src/index.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L96-L101)）
- `partialOutput` 优先从回滚缓冲的起标记之后取正文，取不到时退回增量缓冲并在其中定位起止标记，据此决定是否标记不完整（[packages/shell/tool-bash-persistent/src/index.ts:105-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L105-L128)）
- `retainedScrollback` 按 1000 行一页反向翻页读取整个回滚缓冲并前插拼接，任一页截断即整体标记为截断（[packages/shell/tool-bash-persistent/src/index.ts:139-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L139-L158)）
- `renderCaptured` 先裁剪，再对非空且不完整的输出前置丢头提示，最后对非零退出码追加 `[exit code: N]`（[packages/shell/tool-bash-persistent/src/index.ts:160-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L160-L169)）
- `renderShellExitStatus` 按信号、退出码、皆无三种情况追加 `[shell killed by signal: …]`、`[shell exited: code N]` 或 `[shell exited]`（[packages/shell/tool-bash-persistent/src/index.ts:176-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L176-L187)）
- `respondToSessionExit` 取快照、重置该 Agent 的 shell，并把部分输出、shell 退出标记与重置提示拼成最终结果（[packages/shell/tool-bash-persistent/src/index.ts:196-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L196-L217)）
- shell 注册表按 Agent 键缓存待建与在册会话，`close` 先在列表里确认会话仍在才发 kill（[packages/shell/tool-bash-persistent/src/index.ts:219-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L219-L229)）
- 插件释放时中止生命周期信号、等待所有在建会话结算，并关闭全部在册 shell（[packages/shell/tool-bash-persistent/src/index.ts:231-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L231-L237)）
- `reset` 清掉该 Agent 的缓存并按给定原因关闭其 shell（[packages/shell/tool-bash-persistent/src/index.ts:239-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L239-L244)）
- `get` 命中缓存即复用同一会话，否则把调用信号与插件生命周期信号合并后新建（[packages/shell/tool-bash-persistent/src/index.ts:246-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L246-L249)）
- 新建时按配置的后端类型与会话 header 的 cwd 调 `ctx.terminals.spawn`，并给该 Agent 装一次性的缓存清理副作用（[packages/shell/tool-bash-persistent/src/index.ts:251-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L251-L264)）
- 初始化发送 `stty -echo` 关闭回显，会话已退出或该发送超时则判定初始化失败（[packages/shell/tool-bash-persistent/src/index.ts:265-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L265-L276)）
- 建立过程抛错时先重置该 Agent 的 shell 再向上抛（[packages/shell/tool-bash-persistent/src/index.ts:277-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L277-L280)）
- `executeCommand` 以上游信号和配置超时建立本次命令的 deadline，并据此取得会话（[packages/shell/tool-bash-persistent/src/index.ts:301-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L301-L302)）
- 每轮循环先重新观察会话状态，已退出则走退出应答路径（[packages/shell/tool-bash-persistent/src/index.ts:309-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L309-L318)）
- 首轮提交包裹后的命令、后续轮次发送空文本且不提交，发送抛错时重置 shell 并向上抛（[packages/shell/tool-bash-persistent/src/index.ts:319-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L319-L332)）
- 每轮把增量输出累加进回退缓冲（增量为空时改用视口快照），并合并截断标志（[packages/shell/tool-bash-persistent/src/index.ts:333-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L333-L336)）
- 命中超时则渲染部分输出、重置 shell，并返回超时说明、部分输出与重置提示三段拼接的结果（[packages/shell/tool-bash-persistent/src/index.ts:337-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L337-L351)）
- 信号被中止则重置 shell 后抛出中止错误，不返回任何已捕获输出（[packages/shell/tool-bash-persistent/src/index.ts:352-355](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L352-L355)）
- 最新一页里出现结束标记且能解析出状态码时，返回完整命令输出并结束循环（[packages/shell/tool-bash-persistent/src/index.ts:356-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L356-L359)）
- 本轮发送结果显示会话已退出时走退出应答路径（[packages/shell/tool-bash-persistent/src/index.ts:360-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L360-L364)）
- 后端报告等待原因为重新读 stdin 时提前返回已捕获的部分输出，不再轮询到超时（[packages/shell/tool-bash-persistent/src/index.ts:369-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L369-L375)）
- 以上都不成立时等待轮询间隔再进入下一轮（[packages/shell/tool-bash-persistent/src/index.ts:376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L376)）
- `serialized` 用按 Agent 的 promise 队列把同一 Agent 的命令串行化，并在队尾未被顶替时清理队列条目（[packages/shell/tool-bash-persistent/src/index.ts:389-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L389-L399)）
- 注册名为 `bash` 的工具，描述取自配置，参数只有必填 `command`，输出模式为字符串并直接渲染成一段文本（[packages/shell/tool-bash-persistent/src/index.ts:401-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L401-L414)）
- `execute` 拒绝空命令、拒绝没有归属 Agent 的调用，并在串行队列内先检查中止再执行（[packages/shell/tool-bash-persistent/src/index.ts:415-423](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L415-L423)）
- 调用以命令为标题呈现为 terminal 卡片（[packages/shell/tool-bash-persistent/src/index.ts:424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L424)）
- `inject` 声明插件在 `tools` 与 `terminals` 服务齐备前保持挂起（[packages/shell/tool-bash-persistent/src/index.ts:429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L429)）
- 配置模式给出后端类型 `shell`、超时 300000 毫秒、输出上限 16000 字符与默认描述（[packages/shell/tool-bash-persistent/src/index.ts:444-449](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L444-L449)）
- `apply` 在注册前逐项校验配置：后端类型非空、超时与输出上限为正的安全整数、描述非空，任一不满足即在加载处抛错（[packages/shell/tool-bash-persistent/src/index.ts:452-471](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/index.ts#L452-L471)）

### packages/shell/tool-bash-persistent/src/invariant.ts

本包的不变量伴随插件，由 `./invariant` 子路径导出、在运行期诊断组合中挂载。

- 安装器为空函数，不注册任何运行期检查（[packages/shell/tool-bash-persistent/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/invariant.ts#L22)）
- `apply` 把包名与安装器登记进 `ctx.invariants` 并返回注销函数（[packages/shell/tool-bash-persistent/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/tool-bash-persistent/src/invariant.ts#L29-L30)）

### packages/shell/tool-bash-persistent/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、类型输出目录与工作区项目引用。

- 无运行期机制
