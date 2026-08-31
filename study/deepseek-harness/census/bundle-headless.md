---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/bundle/headless
---

# packages/bundle/headless

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、42 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/bundle/headless/README.md

该 bundle 的英文说明文档，介绍一次性任务模式的调用方式、stderr 推理输出、退出码映射与运行流程。

- 无运行期机制

### packages/bundle/headless/cordis.patch.yml

该 bundle 的补丁文档，叠在 dsh-base 之上，改写两行既有行并插入三行新行，不挂任何 Host、HTTP 或浏览器插件。

- 把 `system-prompt` 行的 persona 改写为带 `{{model}}` 与 `{{cwd}}` 占位的编码代理人设（[packages/bundle/headless/cordis.patch.yml:7-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/cordis.patch.yml#L7-L10)）
- 把 `tools` 行的 `mode` 接到 `process.env.DSH_TOOLS_MODE`，由进程环境决定工具呈现模式（[packages/bundle/headless/cordis.patch.yml:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/cordis.patch.yml#L12-L15)）
- 插入 `code-runtime` 工作线程行，把 PTC 执行能力带进这一 profile（[packages/bundle/headless/cordis.patch.yml:19-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/cordis.patch.yml#L19-L20)）
- 插入 `headless-startup` 行，挂载解析任务位置参数的命令行提供者（[packages/bundle/headless/cordis.patch.yml:22-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/cordis.patch.yml#L22-L23)）
- 插入 `headless-runner` 行，声明 `inject: [headlessStartup]` 并以 `!!js ctx.headlessStartup.task` 惰性取得任务文本（[packages/bundle/headless/cordis.patch.yml:26-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/cordis.patch.yml#L26-L30)）

### packages/bundle/headless/package.json

该 bundle 的 npm 清单，声明入口、三个可解析子路径与补丁文件位置。

- 声明 `"type": "module"` 并把入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/bundle/headless/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/package.json#L13-L15)）
- `exports` 单独开放 `./startup` 子路径，使补丁行能以 `@deepseek-ai/dsh-headless/startup` 解析到启动提供者（[packages/bundle/headless/package.json:16-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/package.json#L16-L32)）
- `files` 把 `lib/startup.js` 与补丁文件一并纳入发布产物（[packages/bundle/headless/package.json:33-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/package.json#L33-L39)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，profile 组合器据此字段找到该 bundle 的补丁层（[packages/bundle/headless/package.json:41-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/package.json#L41-L45)）

### packages/bundle/headless/src/index.ts

一次性任务的直驱插件：创建一个 Agent、把任务作为用户消息投进去、把推理流打到 stderr、冲刷会话后把最终文本打到 stdout 并请求退出。

- `inject` 声明 `agentDefaultModel`、`agents`、`sessions` 三个服务作为激活前置（[packages/bundle/headless/src/index.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L29)）
- `Config` schema 要求 `task` 为必填字符串，配置不合法即在加载时失败（[packages/bundle/headless/src/index.ts:37-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L37-L39)）
- `internals` 把 stdout/stderr 收成可替换对象，默认指向 `process` 的两个流（[packages/bundle/headless/src/index.ts:56-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L56-L59)）
- `summarize` 跳过 `seq` 小于 `firstSeq` 的事件、以 `turn/start` 起算、把每条 `assistant/message` 的 text 块拼接后覆盖式保留最后一个非空结果，并记录最后的 `turn/end` 原因（[packages/bundle/headless/src/index.ts:62-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L62-L83)）
- `close` 在推理段落未以换行结尾时补写一个换行再关段（[packages/bundle/headless/src/index.ts:101-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L101-L106)）
- `streamReasoning` 通过 `ctx.on('session/event')` 订阅并丢弃不属于本 Agent 会话的事件（[packages/bundle/headless/src/index.ts:107-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L107-L108)）
- `turn/start` 关闭当前段落并把 `started` 置真，在此之前的 chunk 一律不输出（[packages/bundle/headless/src/index.ts:109-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L109-L114)）
- 非空 `reasoning-delta` 首次出现时先写 `dsh: reasoning:\n` 标题，再写正文并记下是否以换行结尾（[packages/bundle/headless/src/index.ts:116-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L116-L125)）
- 非 reasoning 的 `block-start` / `block-end` 关闭推理段落（[packages/bundle/headless/src/index.ts:126-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L126-L131)）
- `text-delta`、`tool-call-delta`、`finish` 关闭推理段落，`usage` 不动，未知 chunk 走 `assertNever`（[packages/bundle/headless/src/index.ts:132-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L132-L141)）
- 返回的处置器摘掉事件监听并关闭尚未闭合的推理段落（[packages/bundle/headless/src/index.ts:144-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L144-L147)）
- `fail` 把错误消息以 `dsh: <message>` 写入 stderr 并请求退出码 1（[packages/bundle/headless/src/index.ts:151-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L151-L154)）
- `run` 先 `await ctx.get('loader')?.await()` 等整棵树落定，再取三个服务，任一缺失就静默返回（[packages/bundle/headless/src/index.ts:164-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L164-L170)）
- 用随机 UUID 作会话 id、`process.cwd()` 作 meta、默认选择的 provider/model 创建 Agent，并在 setup 中安装模型选择（[packages/bundle/headless/src/index.ts:172-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L172-L185)）
- 先等一次静默、记下 `agent.session.seq` 作为本次归属区间起点，再开推理流（[packages/bundle/headless/src/index.ts:186-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L186-L188)）
- 以 `agent.followup` 投入一条 `source: { kind: 'user' }` 的用户消息并等待静默，`finally` 中停止推理流（[packages/bundle/headless/src/index.ts:190-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L190-L197)）
- 冲刷会话后再从持久事件归纳结果，把最终文本加换行写入 stdout（[packages/bundle/headless/src/index.ts:198-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L198-L200)）
- `turn/end` 原因为 error 时向 stderr 写 `dsh: <code>: <message>`（[packages/bundle/headless/src/index.ts:201-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L201-L203)）
- 退出码只在 `turn/end` 原因为 `completed` 时为 0，其余一律为 1（[packages/bundle/headless/src/index.ts:204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L204)）
- `apply` 通过 `ctx.get('appExit')` 读全局服务存储，缺失即抛错阻止挂载（[packages/bundle/headless/src/index.ts:215-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L215-L218)）
- `apply` 组装 IO 后以浮动 Promise 启动 `run`，并把未捕获的拒绝接到 `fail`（[packages/bundle/headless/src/index.ts:219-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/index.ts#L219-L220)）

### packages/bundle/headless/src/invariant.ts

该包的不变量伴生插件，注册到 `invariants` 服务上但不安装任何检查。

- `inject = ['invariants']` 把该伴生插件的激活时机拴在 `invariants` 服务可用之后（[packages/bundle/headless/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/invariant.ts#L14)）
- 安装器体为空，运行期不做任何检查（[packages/bundle/headless/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/invariant.ts#L22)）
- `apply` 以包名注册该安装器并返回注册的处置器（[packages/bundle/headless/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/invariant.ts#L29-L30)）

### packages/bundle/headless/src/startup.ts

一次性任务模式的命令行提供者插件：解析任务位置参数与 `--help`，成功后发布 `headlessStartup` 服务供直驱行读取。

- `inject = ['cmdlineArgs']` 使该插件必须等到启动器提供命令行后才激活（[packages/bundle/headless/src/startup.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/startup.ts#L16)）
- 导出服务名常量 `headlessStartup`，作为直驱行注入并读取任务的服务标识（[packages/bundle/headless/src/startup.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/startup.ts#L19)）
- `headlessCommand` 构造带 `[task...]` 变长位置参数、描述、`-h, --help` 与尾部示例的 commander 程序（[packages/bundle/headless/src/startup.ts:31-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/startup.ts#L31-L41)）
- action 把 `program.args` 用空格连接成任务文本（[packages/bundle/headless/src/startup.ts:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/startup.ts#L52)）
- 任务去空白后为空即调 `program.error` 拒绝本次调用，服务不被发布（[packages/bundle/headless/src/startup.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/startup.ts#L53)）
- 校验通过后以 `ctx.provide` 发布 `{ task }`（[packages/bundle/headless/src/startup.ts:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/startup.ts#L54)）
- `parseCmdline(ctx, program)` 在插件挂载时对启动器参数解析，`--help` 与拒绝路径都不会走到发布（[packages/bundle/headless/src/startup.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/headless/src/startup.ts#L56)）

### packages/bundle/headless/tsconfig.json

该包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 并引用 vendor、agent、llm、session、不变量与 cmdline 工程。

- 无运行期机制
