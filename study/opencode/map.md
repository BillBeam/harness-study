---
repo: opencode
commit: 774cc7c1914e4329eefde5a669f938b0cf566661
title: opencode 定位地图
---

# opencode 定位地图

这份地图钉在提交 774cc7c1914e4329eefde5a669f938b0cf566661（tag `v1.18.26`）上，只回答「四个问题的对应代码在哪个文件的哪几行」。行号按该提交的文件内容给出，链接一律指向该提交，不指向分支。链接只证明「这个位置存在、内容如所述」；要判断机制是否成立，请打开链接读原文。

比较的两种模式：**run 模式**（`opencode run "<消息>"`，非交互，本仓库 `scripts/run_opencode.sh` 与 `study/probes/wrapper.sh` 跑的就是它）和 **TUI / serve 模式**（不带子命令的 `opencode` 起终端界面；`opencode serve` 起一个只有 HTTP 的服务）。三种入口最终都调用同一个进程内 HTTP 服务上的同一条 `session.prompt` 路由，循环、工具、落盘都在路由之后，所以大量位置标为「共用」；差异集中在「谁发起 prompt、谁回答权限、谁决定进程何时退出」。凡是某种模式里没有的机制，写「没有」。

另外说明一件事：这棵树里有**两套**循环与工具栈。`packages/opencode/src/session/*` 这一套（下称 v1）是 run、TUI、serve 三种入口实际走的；`packages/core/src/session/runner/*` 与 `packages/core/src/tool/*` 是另一套（下称 v2），只从 `packages/core/src/location-services.ts` 挂进 `@opencode-ai/server` 的处理器，`session.prompt` 路由不经过它。本文以 v1 为主，v2 只在每问末尾单列一小节作对照。

---

## 一、主循环入口在哪

### 共用

- 进程入口：yargs 实例 · [packages/opencode/src/index.ts:45](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/index.ts#L45) — `const cli = yargs(args)`
- 注册默认命令（不带子命令即 TUI）· [packages/opencode/src/index.ts:83](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/index.ts#L83) — `.command(TuiThreadCommand)`
- 注册 `run` · [packages/opencode/src/index.ts:85](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/index.ts#L85) — `.command(RunCommand)`
- 注册 `serve` · [packages/opencode/src/index.ts:93](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/index.ts#L93) — `.command(ServeCommand)`
- 解析并分发 · [packages/opencode/src/index.ts:126](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/index.ts#L126) — `await cli.parse()`
- HTTP 路由路径：`prompt` 是 `POST /session/:sessionID/message` · [packages/opencode/src/server/routes/instance/httpapi/groups/session.ts:95](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/server/routes/instance/httpapi/groups/session.ts#L95)；`prompt_async` · [packages/opencode/src/server/routes/instance/httpapi/groups/session.ts:96](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/server/routes/instance/httpapi/groups/session.ts#L96)；`abort` · [packages/opencode/src/server/routes/instance/httpapi/groups/session.ts:91](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/server/routes/instance/httpapi/groups/session.ts#L91)
- 端点定义 · [packages/opencode/src/server/routes/instance/httpapi/groups/session.ts:316](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/server/routes/instance/httpapi/groups/session.ts#L316) — `HttpApiEndpoint.post("prompt", SessionPaths.prompt, {`
- 路由处理器（阻塞到循环结束，把最后一条 assistant 消息返回）· [packages/opencode/src/server/routes/instance/httpapi/handlers/session.ts:295-300](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/server/routes/instance/httpapi/handlers/session.ts#L295-L300)
- 异步变体（把循环 fork 到服务作用域后立即返回）· [packages/opencode/src/server/routes/instance/httpapi/handlers/session.ts:311-316](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/server/routes/instance/httpapi/handlers/session.ts#L311-L316)
- 处理器挂到端点 · [packages/opencode/src/server/routes/instance/httpapi/handlers/session.ts:431](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/server/routes/instance/httpapi/handlers/session.ts#L431) — `.handle("prompt", prompt)`
- `SessionPrompt.prompt`：先落 user 消息，再进循环 · [packages/opencode/src/session/prompt.ts:1052-1070](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1052-L1070)；进循环那一行 · [packages/opencode/src/session/prompt.ts:1070](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1070) — `return yield* loop({ sessionID: input.sessionID })`
- `loop` 包装：按会话串行化，交给 run-state · [packages/opencode/src/session/prompt.ts:1343-1346](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1343-L1346)
- 串行化实现 · [packages/opencode/src/session/run-state.ts:88-93](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/run-state.ts#L88-L93) — `ensureRunning`
- **循环所有者** `runLoop` · [packages/opencode/src/session/prompt.ts:1081](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1081)
- **主循环语句** · [packages/opencode/src/session/prompt.ts:1088](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1088) — `while (true) {`
- 每圈开头写一行日志 `loop step=N` · [packages/opencode/src/session/prompt.ts:1090](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1090)
- 步数计数 · [packages/opencode/src/session/prompt.ts:1132](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1132) — `step++`
- 本步新建 assistant 消息 · [packages/opencode/src/session/prompt.ts:1186-1201](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1186-L1201)
- 本步取处理器句柄 · [packages/opencode/src/session/prompt.ts:1213](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1213)
- 本步解析工具集 · [packages/opencode/src/session/prompt.ts:1226](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1226) — `const tools = yield* SessionTools.resolve({`
- 本步调用模型 · [packages/opencode/src/session/prompt.ts:1272](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1272) — `const result = yield* handle.process({`
- 处理器里真正消费模型流 · [packages/opencode/src/session/processor.ts:641-654](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L641-L654) — `SessionProcessor.process` / `llm.stream(streamInput)`

### run 模式

- 命令声明 · [packages/opencode/src/cli/cmd/run.ts:127](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L127) — `command: "run [message..]",`
- 处理器 · [packages/opencode/src/cli/cmd/run.ts:263](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L263) — `handler: Effect.fn("Cli.run")(function* (args) {`
- 进程内服务：一个直接调 Hono/Effect 应用的 `fetch`，不开端口 · [packages/opencode/src/cli/cmd/run.ts:948](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L948)
- SDK 客户端绑到这个 `fetch` · [packages/opencode/src/cli/cmd/run.ts:956-961](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L956-L961)
- `execute()`：解析会话、订阅事件、发 prompt · [packages/opencode/src/cli/cmd/run.ts:670](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L670)
- 先订阅事件流 · [packages/opencode/src/cli/cmd/run.ts:834](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L834) — `const events = await client.event.subscribe()`
- **发起 prompt 的那一行**（服务端循环由此开始）· [packages/opencode/src/cli/cmd/run.ts:864](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L864) — `const result = await client.session.prompt({`
- 命令行侧另有一个「事件循环」（渲染、回答权限），不是 agent 循环 · [packages/opencode/src/cli/cmd/run.ts:697-702](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L697-L702) — `async function loop(...)` / `for await (const event of events.stream)`
- `--continue` / `--session` 续跑选项 · [packages/opencode/src/cli/cmd/run.ts:147-156](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L147-L156)

### TUI 模式

- 默认命令 `$0` · [packages/opencode/src/cli/cmd/tui.ts:73](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/tui.ts#L73) — `command: "$0 [project]",`
- 起一个 Worker 线程承载进程内服务 · [packages/opencode/src/cli/cmd/tui.ts:210](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/tui.ts#L210) — `const worker = new Worker(file, {`
- Worker 里的 RPC `fetch` 直接调服务应用（默认不开端口）· [packages/opencode/src/cli/tui/worker.ts:42](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/tui/worker.ts#L42)
- 只有传了 `--port` / `--hostname` / `--mdns` 才真正监听 · [packages/opencode/src/cli/tui/worker.ts:56](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/tui/worker.ts#L56) — `server = await Server.listen(input)`
- Worker 的 RPC 循环 · [packages/opencode/src/cli/tui/worker.ts:80](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/tui/worker.ts#L80) — `Rpc.listen(rpc)`
- 启动 TUI · [packages/opencode/src/cli/cmd/tui.ts:273](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/tui.ts#L273) → [packages/opencode/src/cli/tui/layer.ts:6](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/tui/layer.ts#L6) → [packages/tui/src/app.tsx:186](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/tui/src/app.tsx#L186) — `Tui.run`
- TUI 发起 prompt（阻塞形式）· [packages/tui/src/component/prompt/index.tsx:1095](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/tui/src/component/prompt/index.tsx#L1095) — `.prompt(`
- 「移动到分支」对话框走异步形式 · [packages/tui/src/component/prompt/move.tsx:140](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/tui/src/component/prompt/move.tsx#L140) — `.promptAsync({`

### serve 模式

- 监听 · [packages/opencode/src/cli/cmd/serve.ts:19](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/serve.ts#L19) — `Server.listen(opts)`；实现 · [packages/opencode/src/server/server.ts:73](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/server/server.ts#L73)
- 发起 prompt 的一方：没有。serve 自己不发 prompt，循环由任何外部客户端打上面那条共用路由启动。

### v2 对照

- 第二套循环 `SessionRunner.run` · [packages/core/src/session/runner/llm.ts:390](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/runner/llm.ts#L390)；外圈 · [packages/core/src/session/runner/llm.ts:400](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/runner/llm.ts#L400) — `while (shouldRun) {`；内圈 · [packages/core/src/session/runner/llm.ts:403](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/runner/llm.ts#L403) — `while (needsContinuation) {`
- 它的串行化原语 · [packages/core/src/session/run-coordinator.ts:24](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/run-coordinator.ts#L24)
- 从 `packages/opencode/src` 引用它的位置：没有（`SessionRunner` 在 `packages/opencode/src` 下 0 处出现；只在 [packages/core/src/location-services.ts:27-28](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/location-services.ts#L27-L28) 被挂载）。

---

## 二、工具调用在哪里被校验和分发

### 共用

- 内置工具清单 · [packages/opencode/src/tool/registry.ts:231](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/registry.ts#L231) — `builtin: [`
- 按模型、agent、权限过滤出本次暴露的工具 · [packages/opencode/src/tool/registry.ts:291](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/registry.ts#L291) — `ToolRegistry.tools`
- 把注册表工具转成 AI SDK 工具的适配层 · [packages/opencode/src/session/tools.ts:41](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/tools.ts#L41) — `SessionTools.resolve`
- 逐个取注册表工具 · [packages/opencode/src/session/tools.ts:92](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/tools.ts#L92)
- 交给 provider 的 JSON schema · [packages/opencode/src/session/tools.ts:98](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/tools.ts#L98)
- AI SDK 回调的 `execute` · [packages/opencode/src/session/tools.ts:102](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/tools.ts#L102)；**分发到具体工具**的那一行 · [packages/opencode/src/session/tools.ts:111](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/tools.ts#L111) — `const result = yield* item.execute(args, ctx)`
- 注入每个工具上下文的 `ask` 闭包（权限入口）· [packages/opencode/src/session/tools.ts:81](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/tools.ts#L81)
- 工具执行中回写进度（`metadata` 回调 → 把 part 改成 `running` 并带部分输出）· [packages/opencode/src/session/tools.ts:67-80](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/tools.ts#L67-L80)
- **参数校验**：每个工具初始化时包一层 Effect Schema 解码 · [packages/opencode/src/tool/tool.ts:111](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/tool.ts#L111) — `const decode = Schema.decodeUnknownEffect(toolInfo.parameters)`；解码调用 · [packages/opencode/src/tool/tool.ts:121](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/tool.ts#L121)
- 校验失败回给模型的错误类型 · [packages/opencode/src/tool/tool.ts:24](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/tool.ts#L24) — `InvalidArgumentsError`
- 模型流里工具调用 part 的生命周期：`tool-input-start` · [packages/opencode/src/session/processor.ts:315](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L315)；`tool-call` · [packages/opencode/src/session/processor.ts:331](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L331)；`tool-result` · [packages/opencode/src/session/processor.ts:383](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L383)；`tool-error` · [packages/opencode/src/session/processor.ts:416](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L416)
- 死循环阈值（连续三次一模一样的调用就发一次权限询问）· [packages/opencode/src/session/processor.ts:29](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L29) — `const DOOM_LOOP_THRESHOLD = 3`；询问 · [packages/opencode/src/session/processor.ts:372](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L372)
- 权限判定 · [packages/opencode/src/permission/index.ts:67](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/permission/index.ts#L67) — `Permission.ask`；`deny` 规则直接短路 · [packages/opencode/src/permission/index.ts:75](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/permission/index.ts#L75)；否则发 `permission.asked` 事件等回复 · [packages/opencode/src/permission/index.ts:100](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/permission/index.ts#L100)
- 权限回复 · [packages/opencode/src/permission/index.ts:109](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/permission/index.ts#L109)；reject 分支 · [packages/opencode/src/permission/index.ts:121](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/permission/index.ts#L121)
- bash 工具的权限询问 · [packages/opencode/src/tool/shell.ts:263-283](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/shell.ts#L263-L283) — `ShellTool.ask` / `ctx.ask({`
- **bash 工具真正起子进程** · [packages/opencode/src/tool/shell.ts:484](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/shell.ts#L484) — `spawner.spawn(cmd(input.shell, input.command, input.cwd, input.env))`
- bash 工具输出上限（默认 2000 行、50 KiB，超出时截尾并把全文另存到文件）· [packages/opencode/src/tool/truncate.ts:14-15](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/truncate.ts#L14-L15)；截尾 · [packages/opencode/src/tool/shell.ts:569-579](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/shell.ts#L569-L579)
- 编辑工具对 `oldString` 的唯一性校验（0 处或多处匹配都失败）· [packages/core/src/tool/edit.ts:165-176](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/tool/edit.ts#L165-L176)

### run 模式

- `--auto` 选项 · [packages/opencode/src/cli/cmd/run.ts:242](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L242)
- 非交互时会话创建即带三条 deny 规则：`question`、`plan_enter`、`plan_exit` · [packages/opencode/src/cli/cmd/run.ts:430](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L430)
- 命令行侧事件循环里处理 `permission.asked` · [packages/opencode/src/cli/cmd/run.ts:801](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L801)；`--auto` 时回 `once` 放行 · [packages/opencode/src/cli/cmd/run.ts:805](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L805)；否则打印一行警告后回 `reject` · [packages/opencode/src/cli/cmd/run.ts:816](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L816)
- 「问人」这一档：没有。

### TUI 模式

- 权限对话框的回复 · [packages/tui/src/routes/session/permission.tsx:168](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/tui/src/routes/session/permission.tsx#L168)；自动放行路径 · [packages/tui/src/context/sync.tsx:199](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/tui/src/context/sync.tsx#L199)
- 命令行 `--auto` 的对应物：没有（TUI 的放行由对话框或配置规则决定）。

### serve 模式

- 权限的回答者：没有。serve 只发 `permission.asked` 事件，由连上来的客户端调 `permission.reply`。

### v2 对照

- 注册表与分发 · [packages/core/src/tool/registry.ts:50-62](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/tool/registry.ts#L50-L62)；校验 · [packages/core/src/tool/tool.ts:92](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/tool/tool.ts#L92)；bash 工具的执行、权限断言与起进程 · [packages/core/src/tool/bash.ts:122](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/tool/bash.ts#L122)、[packages/core/src/tool/bash.ts:132](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/tool/bash.ts#L132)、[packages/core/src/tool/bash.ts:158](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/tool/bash.ts#L158)

---

## 三、会话或轨迹被写到哪

只列写入调用点；三张表各记什么、何时写、追加还是就地改，见 [storage-map.md](storage-map.md)。

### 共用

- 会话服务只发事件、不直接写库：`updateMessage` · [packages/opencode/src/session/session.ts:629](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/session.ts#L629)；`updatePart` · [packages/opencode/src/session/session.ts:635](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/session.ts#L635)
- 事件的持久化与投影在同一事务里 · [packages/core/src/event.ts:320-336](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/event.ts#L320-L336)
- 真正的 SQL：`session` 行插入 · [packages/core/src/session/projector.ts:217](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/projector.ts#L217)；`message` 行 upsert · [packages/core/src/session/projector.ts:260-269](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/projector.ts#L260-L269)；`part` 行 upsert · [packages/core/src/session/projector.ts:310-320](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/projector.ts#L310-L320)
- 库文件路径 · [packages/core/src/database/database.ts:43](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/database/database.ts#L43) — `~/.local/share/opencode/opencode.db`
- 日志文件 · [packages/core/src/observability/logging.ts:49](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/observability/logging.ts#L49) — `~/.local/share/opencode/log/opencode.log`
- 快照 git 目录的读写 API：`track` · [packages/opencode/src/snapshot/index.ts:318](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/snapshot/index.ts#L318)；`patch` · [packages/opencode/src/snapshot/index.ts:349](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/snapshot/index.ts#L349)；`restore` · [packages/opencode/src/snapshot/index.ts:382](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/snapshot/index.ts#L382)；`revert` · [packages/opencode/src/snapshot/index.ts:408](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/snapshot/index.ts#L408)
- 快照在处理器里的调用点（因此三种模式共用）· [packages/opencode/src/session/processor.ts:102](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L102)、[packages/opencode/src/session/processor.ts:425](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L425)、[packages/opencode/src/session/processor.ts:436](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L436)、[packages/opencode/src/session/processor.ts:472](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L472)、[packages/opencode/src/session/processor.ts:555](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L555)
- 读回快照的地方 · [packages/opencode/src/session/revert.ts:71](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/revert.ts#L71)、[packages/opencode/src/session/revert.ts:96](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/revert.ts#L96)

### run 模式

- 只在 `OPENCODE_DIRECT_TRACE=1` 时另写一份 JSONL 事件轨迹到 `log/direct/<时间戳>-<pid>.jsonl` · [packages/opencode/src/cli/cmd/run/trace.ts:32](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run/trace.ts#L32)；本仓库的运行没有设这个变量，没有这份文件。
- run 模式专属的会话落盘：没有，与其余模式同一个库。

### TUI 模式

- 专属落盘：没有。

### serve 模式

- 专属落盘：没有。

---

## 四、循环在哪里判定停止

### 共用

- 上一条 assistant 消息的 `finish` 不是 `tool-calls` / `unknown`，且其 parts 里没有工具调用，且它属于本轮 user 消息 → 退出 · [packages/opencode/src/session/prompt.ts:1106-1129](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1106-L1129)；`hasToolCalls` · [packages/opencode/src/session/prompt.ts:1106](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1106)；判断 · [packages/opencode/src/session/prompt.ts:1111](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1111)；`break` · [packages/opencode/src/session/prompt.ts:1129](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1129)
- 处理器给出的裁决：需要压缩 → `compact`；被权限拒绝或消息带 error → `stop` · [packages/opencode/src/session/processor.ts:693-694](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L693-L694)；`stop` 映射为 `break` · [packages/opencode/src/session/prompt.ts:1319](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1319)；应用 · [packages/opencode/src/session/prompt.ts:1334](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1334)
- 权限被拒时把 `ctx.blocked` 置位 · [packages/opencode/src/session/processor.ts:200](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L200)
- 步数上限：按 agent 配置 `steps`，默认无穷 · [packages/opencode/src/session/prompt.ts:1178-1179](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1178-L1179)；配置字段 · [packages/core/src/v1/config/agent.ts:79](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/v1/config/agent.ts#L79)
- 到最后一步时只往消息里加一段「不许再调工具」的提示，工具仍然全部下发，循环不因此 break · [packages/opencode/src/session/prompt.ts:1281](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1281)；提示原文 · [packages/core/src/session/runner/max-steps.ts:1](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/runner/max-steps.ts#L1)
- 中止入口 · [packages/opencode/src/session/prompt.ts:152](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L152) — `SessionPrompt.cancel`；run-state 侧 · [packages/opencode/src/session/run-state.ts:77](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/run-state.ts#L77)；HTTP 路由 · [packages/opencode/src/server/routes/instance/httpapi/handlers/session.ts:232](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/server/routes/instance/httpapi/handlers/session.ts#L232)
- 中止/异常后的清理（把悬着的工具 part 标成 error）· [packages/opencode/src/session/processor.ts:553](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L553)、[packages/opencode/src/session/processor.ts:596-602](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/processor.ts#L596-L602)
- 单次工具的超时（只有每次调用的 `timeout`，没有会话级墙钟）· [packages/opencode/src/tool/shell.ts:540](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/shell.ts#L540)、[packages/opencode/src/tool/shell.ts:618](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/tool/shell.ts#L618)
- 花费上限：没有。会话级墙钟上限：没有。（`packages/opencode/src` 与 `packages/core/src` 下 `budget`、`stepLimit`、`max_steps` 只命中 provider 的 thinking token 预算与配置别名 `maxSteps`。）

### run 模式

- 命令行侧事件循环在收到本会话 `session.status` 为 `idle` 时跳出 · [packages/opencode/src/cli/cmd/run.ts:793-798](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L793-L798)
- prompt 返回后 `finish()` 等事件循环结束并设退出码 · [packages/opencode/src/cli/cmd/run.ts:839](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L839)、[packages/opencode/src/cli/cmd/run.ts:876](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L876)
- 进程无条件退出（`finally`）· [packages/opencode/src/index.ts:141](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/index.ts#L141) — `process.exit()`

### TUI 模式

- 靠渲染 promise 活着，只有应用自己调 `exit()` 才返回 · [packages/tui/src/app.tsx:245](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/tui/src/app.tsx#L245)；随后 · [packages/opencode/src/cli/cmd/tui.ts:306](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/tui.ts#L306) — `process.exit(0)`
- 用户中止（提示框里按 Esc）· [packages/tui/src/component/prompt/index.tsx:415](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/tui/src/component/prompt/index.tsx#L415)；离开会话路由时 · [packages/tui/src/routes/session/index.tsx:619](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/tui/src/routes/session/index.tsx#L619)
- 循环停止判定本身：没有 TUI 专属的，与共用相同。

### serve 模式

- 进程永不返回 · [packages/opencode/src/cli/cmd/serve.ts:22](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/serve.ts#L22) — `yield* Effect.never`
- 循环停止判定本身：没有 serve 专属的，与共用相同。

### v2 对照

- 最后一步 v2 不下发工具（`toolMaterialization` 为 undefined）· [packages/core/src/session/runner/llm.ts:203](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/runner/llm.ts#L203)；v1 只加提示（见上）。

---

## 卡外发现

这一卡没要求找的，都在钉住提交上复核过。只记不评。

- **两套循环与工具栈并存。** v1（`packages/opencode/src/session/*`，AI SDK 的 `tool()`）是 run / TUI / serve 三种入口实际走的；v2（`packages/core/src/session/runner/llm.ts`、`packages/core/src/tool/*`、`run-coordinator.ts`、`message-updater.ts`）只从 [packages/core/src/location-services.ts:27-28](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/location-services.ts#L27-L28) 挂进 `@opencode-ai/server` 的处理器，`packages/opencode/src` 里没有任何地方引用 `SessionRunner`。两套对「最后一步」的处理不同：v2 不下发工具（[packages/core/src/session/runner/llm.ts:203](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/runner/llm.ts#L203)），v1 只加一段提示、工具照发（[packages/opencode/src/session/prompt.ts:1281](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1281)）。
- **v1 的 `steps` 上限不是硬上限。** [packages/opencode/src/session/prompt.ts:1179](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/prompt.ts#L1179) 算出 `isLastStep` 后，没有任何一处据此 break `while (true)`；模型若无视那段提示继续调工具，循环继续。
- **不带 `--auto` 的 `opencode run` 把每个权限请求自动 reject**（[packages/opencode/src/cli/cmd/run.ts:816](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L816)），先打一行 `auto-rejecting` 警告；此外非交互会话创建时就带 `question` / `plan_enter` / `plan_exit` 三条 deny（[packages/opencode/src/cli/cmd/run.ts:430](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L430)）。
- **`Session.updateMessage` / `updatePart` 不碰库**，只发事件（[packages/opencode/src/session/session.ts:629-635](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/session/session.ts#L629-L635)）；行写入是投影器做的（[packages/core/src/session/projector.ts:455](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/core/src/session/projector.ts#L455)）。
- **`packages/opencode/src/server/projectors.ts` 是一个空函数** `export function initProjectors() {}`，被 `init-projectors.ts` 以副作用方式引入到 `server.ts`；实际投影器在 `packages/core/src/session/projector.ts`。
- **`--mini` 有两条入口**：`opencode --mini` 经 `runMini` 用一份合成的 argv 重新进入 `RunCommand.handler`（[packages/opencode/src/cli/cmd/run.ts:982](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/run.ts#L982)）。
- **TUI 的提示框走阻塞的 `session.prompt`**（[packages/tui/src/component/prompt/index.tsx:1095](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/tui/src/component/prompt/index.tsx#L1095)），「移动到分支」与 `--mini` 走 `promptAsync`；异步一侧的错误只以 `session.error` 事件到达客户端。
- **`packages/opencode/src/cli/cmd/tui.ts` 最后一行是一条 `// scratch` 注释**（[packages/opencode/src/cli/cmd/tui.ts:309](https://github.com/anomalyco/opencode/blob/774cc7c1914e4329eefde5a669f938b0cf566661/packages/opencode/src/cli/cmd/tui.ts#L309)）。
- **本仓库 `scripts/census_coverage.py` 的六类里没有 `.mdx`。** 本卡把 `packages/web/src/content/docs`（opencode.ai/docs 的原文）声明进了 opencode 的 `roots` 与 `doc_roots`，但那 36 个 `.mdx` 页面在现有规则下落在「不属于普查的六类」里，计 0 个文件；规则没改，声明留着记范围。
