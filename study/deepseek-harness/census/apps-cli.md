---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · apps/cli
---

# apps/cli

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 19 个文件、112 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### apps/cli/README.md

`@deepseek-ai/dsh` 包的英文说明文档，描述启动器的命令模式、profile 目录结构与补丁层叠加顺序，供阅读者查阅。

- 无运行期机制

### apps/cli/config/examples/cordis/cordis.yml

一份可选的补丁叠加文件，通过 `dsh web --patch` 施加在 web profile 的 bundle 层之上。

- 把 `webserver` 行的整个 `config` 替换为 host `127.0.0.1`、port `3081`（[apps/cli/config/examples/cordis/cordis.yml:10-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/cordis/cordis.yml#L10-L13)）
- 插入 `cordis-host-runner` 与 `tool-cordis` 两行插件（[apps/cli/config/examples/cordis/cordis.yml:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/cordis/cordis.yml#L15-L19)）

### apps/cli/config/examples/github-review/cordis.yml

一份可选的补丁叠加文件，在已有 web 组合之上再挂一套 webhook 接入与一条评审规则。

- 插入 `webhook-runtime` 行（[apps/cli/config/examples/github-review/cordis.yml:4-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/cordis.yml#L4-L6)）
- 插入相对路径模块 `./github-ready-review-rule.mjs` 行，并给它 `source`、`repository`、`agentPreset: standard`、`permissionPreset: read-only` 配置（[apps/cli/config/examples/github-review/cordis.yml:8-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/cordis.yml#L8-L15)）
- 该规则行的 `workspacePath` 由 `!!js` 表达式在加载时取环境变量 `DSH_GITHUB_REVIEW_WORKSPACE`，缺省回落到 `process.cwd()`（[apps/cli/config/examples/github-review/cordis.yml:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/cordis.yml#L13)）
- 插入一个 `cordis:group` 分组行，`isolate.webServer: true` 使组内的 webServer 与外层分离（[apps/cli/config/examples/github-review/cordis.yml:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/cordis.yml#L17-L21)）
- 组内第二个 web 服务器绑定 `127.0.0.1`，端口由 `!!js` 读 `DSH_GITHUB_WEBHOOK_PORT` 并回落 3081（[apps/cli/config/examples/github-review/cordis.yml:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/cordis.yml#L22-L27)）
- 组内 webhook 适配器把入口路径固定为 `/github`，签名密钥取自环境变量名 `DSH_GITHUB_WEBHOOK_SECRET`，请求体上限 1048576 字节（[apps/cli/config/examples/github-review/cordis.yml:29-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/cordis.yml#L29-L35)）

### apps/cli/config/examples/github-review/github-ready-review-rule.mjs

上一份叠加配置引用的规则插件模块，把一类进来的 webhook 投递转成一次带提示词的会话请求。

- 声明注入 `webhookRuntime`（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L5)）
- `Config` 把五个字段全部声明为必填，缺一项在配置校验时失败（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:7-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L7-L13)）
- `apply` 里以 `ctx.effect` 注册规则，注册返回的清理器随插件卸载生效（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:16-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L16-L18)）
- 投递来源与配置的 `source` 不同则返回 `null`，不触发任何会话（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L21)）
- 事件名非 `pull_request`、`action` 非 `ready_for_review`、仓库全名不匹配三项各自返回 `null`（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:23-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L23-L26)）
- 在构造结果前检查取消信号并抛出（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L28)）
- 载荷中 `pull_request` 不是对象时抛出错误而非静默跳过（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:29-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L29-L32)）
- 从载荷抽出仓库、编号、URL、标题、作者、base/head 分支与 SHA、投递 id 组成元数据对象（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:34-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L34-L45)）
- 返回值把配置里的 `workspacePath`、`agentPreset`、`permissionPreset` 与生成的标题一并交给运行时（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:47-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L47-L51)）
- 拼出模型可见的提示词：指定 head SHA、要求刷新实时元数据、限定只读检查、禁止修改文件与仓库状态、声明 `event_metadata_json` 为不可信元数据，并把序列化后的元数据作为最后一行附上（[apps/cli/config/examples/github-review/github-ready-review-rule.mjs:52-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/github-review/github-ready-review-rule.mjs#L52-L61)）

### apps/cli/config/examples/mcp-memory/engram.cordis.yml

一份可选补丁文件，向组合中插入一个以 stdio 方式启动外部记忆服务器的客户端行。

- 插入 `@deepseek-ai/dsh-mcp-client` 行，serverName 为 `engram`、transport 为 `stdio`、命令 `engram` 带参数 `mcp`（[apps/cli/config/examples/mcp-memory/engram.cordis.yml:3-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/mcp-memory/engram.cordis.yml#L3-L10)）
- 子进程工作目录由 `!!js process.cwd()` 在加载时求值（[apps/cli/config/examples/mcp-memory/engram.cordis.yml:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/mcp-memory/engram.cordis.yml#L11)）

### apps/cli/config/examples/mcp-memory/mcp-reference-memory.cordis.yml

一份可选补丁文件，插入以 stdio 启动参考实现记忆服务器的客户端行。

- 插入 `@deepseek-ai/dsh-mcp-client` 行，serverName 为 `reference_memory`，命令 `mcp-server-memory`，cwd 取 `process.cwd()`（[apps/cli/config/examples/mcp-memory/mcp-reference-memory.cordis.yml:3-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/mcp-memory/mcp-reference-memory.cordis.yml#L3-L10)）
- 子进程环境变量 `MEMORY_FILE_PATH` 由表达式求值：优先取同名环境变量去空白后的非空值，否则拼成用户主目录下的 `.dsh-mcp-reference-memory.jsonl`（[apps/cli/config/examples/mcp-memory/mcp-reference-memory.cordis.yml:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/mcp-memory/mcp-reference-memory.cordis.yml#L11-L13)）

### apps/cli/config/examples/mcp-memory/memorix.cordis.yml

一份可选补丁文件，插入以 stdio 启动另一个记忆服务器的客户端行。

- 插入 `@deepseek-ai/dsh-mcp-client` 行，serverName 为 `memorix`、命令 `memorix` 带参数 `serve`（[apps/cli/config/examples/mcp-memory/memorix.cordis.yml:3-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/mcp-memory/memorix.cordis.yml#L3-L10)）
- 子进程工作目录由 `!!js process.cwd()` 在加载时求值（[apps/cli/config/examples/mcp-memory/memorix.cordis.yml:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/mcp-memory/memorix.cordis.yml#L11)）

### apps/cli/config/examples/schedule/cordis.yml

一份可选补丁文件，在 web 组合上追加时间上下文与定时能力两行。

- 插入 `@deepseek-ai/dsh-time-context` 行（[apps/cli/config/examples/schedule/cordis.yml:5-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/schedule/cordis.yml#L5-L6)）
- 插入 `@deepseek-ai/dsh-schedule` 行（[apps/cli/config/examples/schedule/cordis.yml:8-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/config/examples/schedule/cordis.yml#L8-L9)）

### apps/cli/package.json

CLI 包的清单，声明可执行入口、发布内容、内置配置树挂载点和整份依赖闭包。

- `type: module` 让包内所有 `.js` 以 ESM 解析（[apps/cli/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/package.json#L13)）
- `bin` 把命令名 `dsh` 指向 `lib/bin.js`（[apps/cli/package.json:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/package.json#L14-L16)）
- `files` 只发布 `lib/*.js`（[apps/cli/package.json:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/package.json#L17-L19)）
- `dsh.configTrees` 把预设目录挂到 `config/agent-presets`，并置 `scanRoster: true`（[apps/cli/package.json:20-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/package.json#L20-L24)）
- `dependencies` 决定哪些 bundle 与插件包能从本安装位置解析到，包括各内置 bundle、工具插件、MCP 客户端与 pnpm 之外的加载器插件（[apps/cli/package.json:26-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/package.json#L26-L97)）

### apps/cli/reference/README.md

`dsh` 命令行的行为参考文档，逐条描述 profile 组合、插件管理、web 别名、关停、部署默认值与源码执行。

- 无运行期机制

### apps/cli/src/args.ts

基于 commander 的命令行解析模块，把 argv 解析成 profile 启动、配置转储或插件管理三种调用之一，并决定哪一段参数交给被启动的应用。

- `collect` 以非可变参数方式累积重复的 `--patch`（[apps/cli/src/args.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L61)）
- `--patch` 收到空串时报错退出（[apps/cli/src/args.ts:84-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L84-L85)）
- 两个转储标志都未给出时返回 `profile` 模式，并带上补丁列表与剩余参数（[apps/cli/src/args.ts:86-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L86-L88)）
- `--dump-config` 与 `--dump-default-config` 同时出现时报错退出（[apps/cli/src/args.ts:89-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L89-L91)）
- 转储调用携带任何应用参数时报错并回显这些参数（[apps/cli/src/args.ts:95-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L95-L97)）
- `--dump-default-config` 与 `--patch` 同时出现时报错退出（[apps/cli/src/args.ts:98-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L98-L101)）
- 其余情况返回 `dump-config` 模式并带上 `defaultOnly` 标志（[apps/cli/src/args.ts:102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L102)）
- `-V, --version` 打印传入的版本号（[apps/cli/src/args.ts:119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L119)）
- `exitOverride` 把 commander 的退出改成抛错，交给下方的 catch 决定退出码（[apps/cli/src/args.ts:122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L122)）
- 关闭内建 `-h`、允许未知选项、开启透传与位置选项，使第一个不认识的 token 起的全部参数归被启动的应用（[apps/cli/src/args.ts:126-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L126-L129)）
- 定义 `--profile`、可重复 `--patch`、`--dump-config`、`--dump-default-config` 四个启动器自有选项（[apps/cli/src/args.ts:131-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L131-L134)）
- 未给 `--profile` 且参数里含 `-h`/`--help` 时打印启动器自身帮助，否则报缺少 `--profile`（[apps/cli/src/args.ts:138-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L138-L141)）
- `--profile` 为空串时报错退出（[apps/cli/src/args.ts:143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L143)）
- `rejectParentOptions` 在子命令前出现父级选项时报错退出（[apps/cli/src/args.ts:148-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L148-L154)）
- `web` 子命令同样关闭 `-h`、允许未知选项并透传，其动作把 profile 硬编码为 `web`（[apps/cli/src/args.ts:156-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L156-L169)）
- `plugin` 子命令把 `--profile` 设为必填选项（[apps/cli/src/args.ts:171-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L171-L173)）
- `plugin` 的 profile 为空串或没有待转发参数时报错退出，否则返回 `plugin` 模式与原样参数（[apps/cli/src/args.ts:176-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L176-L181)）
- 解析抛出时按 `CommanderError.exitCode` 退出，非该类型错误退出码为 1（[apps/cli/src/args.ts:183-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L183-L187)）
- 解析结束仍无解析结果时抛出错误（[apps/cli/src/args.ts:189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/args.ts#L189)）

### apps/cli/src/bin.ts

`dsh` 命令的可执行入口，读版本、解析 argv，然后按模式动态载入唯一需要的运行器。

- 从相对 `../package.json` 读 `version`，不是字符串则用 `0.0.0`（[apps/cli/src/bin.ts:17-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/bin.ts#L17-L22)）
- 取 `process.argv.slice(2)` 交给解析器得到调用描述（[apps/cli/src/bin.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/bin.ts#L24)）
- `profile` 模式动态导入启动模块，并把分层环境快照、profile 名、补丁文件与内层参数一起传入（[apps/cli/src/bin.ts:27-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/bin.ts#L27-L36)）
- `plugin` 模式以转发结果的返回码直接结束进程（[apps/cli/src/bin.ts:37-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/bin.ts#L37-L41)）
- `dump-config` 模式动态导入转储模块并执行（[apps/cli/src/bin.ts:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/bin.ts#L42-L46)）
- 未覆盖的模式在编译期由 `satisfies never` 收口，运行期抛出错误（[apps/cli/src/bin.ts:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/bin.ts#L47-L49)）

### apps/cli/src/dump-config.ts

配置转储运行器，按与启动相同的顺序把各层补丁堆起来渲染到标准输出，全程不挂载插件也不求值表达式。

- 调用 `prepareProfile` 准备 profile，`defaultOnly` 时不解析用户层（[apps/cli/src/dump-config.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/dump-config.ts#L31)）
- 每个 bundle 层映射成一层，标签取包名（[apps/cli/src/dump-config.ts:32-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/dump-config.ts#L32-L35)）
- 非 `defaultOnly` 时，profile 自身补丁文件存在才作为一层追加（[apps/cli/src/dump-config.ts:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/dump-config.ts#L36-L39)）
- 随后追加主目录级补丁层，读不到就不加（[apps/cli/src/dump-config.ts:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/dump-config.ts#L40-L44)）
- 按 argv 顺序把每个 `--patch` 解析成绝对路径后追加为独立一层（[apps/cli/src/dump-config.ts:45-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/dump-config.ts#L45-L48)）
- 以 profile 目录里的空根文件为锚渲染结果并写入标准输出（[apps/cli/src/dump-config.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/dump-config.ts#L51)）

### apps/cli/src/plugin.ts

`dsh plugin` 的实现：必要时初始化 profile，把参数转发给 pnpm，然后按安装后的实际状态改写 profile 清单里的 bundle 列表。

- `exportsPatch` 解析包目录失败时按普通依赖处理而不抛出（[apps/cli/src/plugin.ts:36-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L36-L45)）
- 依据包清单里是否声明 `dsh.bundle.patch` 判定它是否贡献补丁层（[apps/cli/src/plugin.ts:43-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L43-L44)）
- 按依赖顺序把新识别出的 bundle 追加进 `dsh.profile.bundles`（[apps/cli/src/plugin.ts:59-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L59-L69)）
- 新增但不声明 bundle 的依赖在 stderr 上打印一次警告（[apps/cli/src/plugin.ts:70-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L70-L76)）
- 曾是依赖但已不再解析为 bundle 的条目从层列表中删除，模板自带的内置 bundle 因不是依赖而不受影响（[apps/cli/src/plugin.ts:77-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L77-L87)）
- 只有列表实际变化才回写 profile 清单（[apps/cli/src/plugin.ts:88-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L88-L91)）
- `anchorPathSpec` 用正则识别 `.`/`..` 开头的路径规格（含 `file:`/`link:` 前缀），把它们改写成相对调用目录的绝对路径并保留原前缀（[apps/cli/src/plugin.ts:104-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L104-L112)）
- profile 目录缺少 `package.json` 时按模板 bundle 列表与 patchReload 初始化，找不到模板则用默认列表，并在 stderr 报告初始化位置（[apps/cli/src/plugin.ts:121-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L121-L130)）
- 同步启动 pnpm，工作目录设为 profile 目录、标准流直连、Windows 上走 shell（[apps/cli/src/plugin.ts:134-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L134-L138)）
- 启动错误为 `ENOENT` 时提示并返回 127，其余启动错误原样抛出（[apps/cli/src/plugin.ts:139-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L139-L146)）
- pnpm 退出码缺失时按 1 处理，为 0 才执行清单对账（[apps/cli/src/plugin.ts:147-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L147-L149)）
- pnpm 失败时在 stderr 指出出错的 profile 目录；参数里出现 git 规格时再打印一条关于构建脚本放行键写入位置的提示（[apps/cli/src/plugin.ts:150-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L150-L161)）
- 把 pnpm 的退出码作为本次调用的返回值（[apps/cli/src/plugin.ts:162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/plugin.ts#L162)）

### apps/cli/src/process-shutdown.ts

进程退出控制器，把插件树的释放、超时强退与信号升级合并成一个对象，供长驻与一次性两类调用共用。

- 释放宽限固定为 5000 毫秒（[apps/cli/src/process-shutdown.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/process-shutdown.ts#L4)）
- 强制退出只执行一次，执行前清掉超时定时器（[apps/cli/src/process-shutdown.ts:38-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/process-shutdown.ts#L38-L43)）
- 自然完成路径只记录退出码，且在已强退或已完成时不再动作（[apps/cli/src/process-shutdown.ts:45-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/process-shutdown.ts#L45-L50)）
- 重复调用合并到同一个 pending Promise，只有第一次真正启动释放（[apps/cli/src/process-shutdown.ts:52-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/process-shutdown.ts#L52-L54)）
- 启动同时装超时定时器，到期直接强制退出（[apps/cli/src/process-shutdown.ts:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/process-shutdown.ts#L54)）
- 释放成功后按标志决定强制退出还是仅记录退出码，释放失败一律强制退出（[apps/cli/src/process-shutdown.ts:55-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/process-shutdown.ts#L55-L62)）
- `interrupt` 在已有释放在跑时立即强制退出，否则启动一次带强退收尾的释放（[apps/cli/src/process-shutdown.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/process-shutdown.ts#L69-L75)）

### apps/cli/src/profile-boot.ts

profile 启动模块：解析 profile、堆叠补丁层、挂载树、按生命周期设置补丁热重载，并接上信号与退出控制。

- `createAppReady` 维护一个只提交一次的就绪信号，晚到的监听器立即回调，提交后清空监听表（[apps/cli/src/profile-boot.ts:40-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L40-L61)）
- 主目录补丁路径每次调用现算，不在模块加载时固化（[apps/cli/src/profile-boot.ts:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L69-L71)）
- 以本模块 URL 上一级的 `package.json` 作为本安装的解析锚点（[apps/cli/src/profile-boot.ts:74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L74)）
- `resolveTelemetryPatch` 在环境变量为任意非空值且组合中确实存在该行时，生成一条把该行置 `disabled` 的补丁，否则返回 undefined（[apps/cli/src/profile-boot.ts:100-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L100-L103)）
- `prepareProfile` 每次都把 profile 根配置重写成空列表，覆盖加载器可能写回的组合行（[apps/cli/src/profile-boot.ts:118-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L118-L122)）
- `allPatches` 固定层序：bundle 层、profile 用户层、主目录用户层、叠加层（[apps/cli/src/profile-boot.ts:136-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L136-L143)）
- 启动前修复 profile 级模块解析回落目录（[apps/cli/src/profile-boot.ts:161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L161)）
- `--patch` 文件按 argv 顺序解析成绝对路径并展开成叠加层（[apps/cli/src/profile-boot.ts:163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L163)）
- 先用四层补丁合成一份行表，据此判断遥测行是否存在，再把可能生成的遥测补丁追加到叠加层末尾（[apps/cli/src/profile-boot.ts:165-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L165-L172)）
- `suppressShutdownError` 在信号已中止、fiber 非活动或 loader 已消失时吞掉监听器安装失败，否则重新抛出（[apps/cli/src/profile-boot.ts:197-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L197-L201)）
- 以「释放当前应用树」为动作创建退出控制器（[apps/cli/src/profile-boot.ts:213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L213)）
- 中断动作同时置位信号 AbortController 并触发控制器的 interrupt（[apps/cli/src/profile-boot.ts:214-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L214-L218)）
- 在挂载开始前就注册信号处理：SIGTERM 以退出码 0 中断，SIGINT 以 130 中断（[apps/cli/src/profile-boot.ts:224-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L224-L225)）
- 安装未捕获异常的失败即停处理，其回调释放应用树（[apps/cli/src/profile-boot.ts:226-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L226-L228)）
- `composeLive` 每代都重新读两个用户补丁文件，并把整栈 `structuredClone` 后再应用（[apps/cli/src/profile-boot.ts:243-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L243-L248)）
- 首次启动同样传入克隆后的补丁栈（[apps/cli/src/profile-boot.ts:251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L251)）
- 在任何配置树条目挂载之前把本次运行的环境快照提供到根上下文（[apps/cli/src/profile-boot.ts:253-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L253-L255)）
- 把内层参数、退出请求函数与就绪信号一起作为命令行服务提供给树（[apps/cli/src/profile-boot.ts:256-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L256-L262)）
- 仅当 patchReload 为 `live`、未收到信号、fiber 仍活动且 loader 仍在时才安装补丁监听（[apps/cli/src/profile-boot.ts:270-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L270-L273)）
- 树上没有热重载服务时先按需创建定时器插件，再创建模块根为空的热重载实例，使重载只涉及配置而不替换源模块（[apps/cli/src/profile-boot.ts:281-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L281-L286)）
- 分别监听 profile 与主目录两个补丁文件，任一变化都用同一个重组函数重算整栈（[apps/cli/src/profile-boot.ts:287-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L287-L296)）
- 监听安装失败交由抑制函数决定吞掉还是抛出（[apps/cli/src/profile-boot.ts:297-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L297-L299)）
- 只有在未中止、fiber 活动且 loader 存在时才提交就绪信号（[apps/cli/src/profile-boot.ts:301-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/profile-boot.ts#L301-L305)）

### apps/cli/src/sdk-source.cordis.patch.yml

随 CLI 源码一起放置的补丁文件，用于源码形态下的 SDK 组合。

- 把 `typert-loader` 行置为 `disabled: true`，使该行不再挂载（[apps/cli/src/sdk-source.cordis.patch.yml:4-5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/src/sdk-source.cordis.patch.yml#L4-L5)）

### apps/cli/tsconfig.json

CLI 包的 TypeScript 项目配置，声明源码根、输出目录与对其他工作区项目的引用。

- 无运行期机制

### apps/cli/tsdown.config.ts

CLI 包的打包配置，决定 `bin` 所指向的那个文件是怎么产出的。

- 以 `lib/types/bin.js` 为唯一入口打包到 `lib`，产出的即是清单 `bin` 指向的 `lib/bin.js`（[apps/cli/tsdown.config.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/tsdown.config.ts#L9-L11)）
- 输出格式固定 esm、平台 node、目标 es2024，且不改扩展名（[apps/cli/tsdown.config.ts:11-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/tsdown.config.ts#L11-L14)）
- 关闭声明产出并关闭清理，保留同目录下已有的产物（[apps/cli/tsdown.config.ts:15-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/cli/tsdown.config.ts#L15-L16)）
