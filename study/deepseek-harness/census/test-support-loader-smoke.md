---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/test-support/loader-smoke
---

# packages/test-support/loader-smoke

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、35 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/test-support/loader-smoke/README.md

该包的说明文档，描述子进程冒烟入口、单轮驱动器与 src/lib 启动模式，供测试作者阅读。

- 无运行期机制

### packages/test-support/loader-smoke/package.json

该包的 npm 清单，声明包名、模块类型、入口、发布文件集与运行期依赖。

- 声明 `"type": "module"` 与 `main`/`types` 入口（[packages/test-support/loader-smoke/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/package.json#L13-L15)）
- `exports` 暴露根入口、`./invariant` 子路径、`./src/*` 源码直读与 `./package.json`（[packages/test-support/loader-smoke/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/package.json#L16-L27)）
- `files` 只打包 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/test-support/loader-smoke/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/package.json#L28-L32)）
- 把 `execa` 与 `tsx` 列为运行期依赖，冒烟进程的派生与源码模式加载钩子据此解析（[packages/test-support/loader-smoke/package.json:34-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/package.json#L34-L37)）

### packages/test-support/loader-smoke/src/agent-turn.ts

进程内的单轮驱动器：在已装配好的 Loader 上下文中找到唯一根代理，投递一条用户消息并等待整体空闲，返回最终助手文本与累计用量。

- `addUsage` 逐项累加 `inputTokens`/`outputTokens`，并在任一侧出现时累加缓存读写与推理 token（[packages/test-support/loader-smoke/src/agent-turn.ts:25-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L25-L34)）
- `assistantText` 只取消息中的 text 块并拼接，全无 text 块时返回 undefined（[packages/test-support/loader-smoke/src/agent-turn.ts:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L36-L39)）
- `onlyRootAgent` 要求根代理恰好一个，否则抛出带实际数量的错误（[packages/test-support/loader-smoke/src/agent-turn.ts:41-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L41-L48)）
- 投递前先 `await agent.whenIdle()`，等待组合装配后的静默态（[packages/test-support/loader-smoke/src/agent-turn.ts:57-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L57-L58)）
- 以 `createUserMessage` 构造来源为 `user` 的文本任务消息（[packages/test-support/loader-smoke/src/agent-turn.ts:60-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L60-L63)）
- `session/event` 监听只处理该根代理自身 session 的事件（[packages/test-support/loader-smoke/src/agent-turn.ts:67-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L67-L68)）
- 在观察到本条消息进入持久收件箱（`agent/inbox/spliced` 含其 id）之前，不向观察者转发任何事件（[packages/test-support/loader-smoke/src/agent-turn.ts:69-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L69-L73)）
- `usage` 类型的 assistant chunk 按 `turn/step` 记入用量表（[packages/test-support/loader-smoke/src/agent-turn.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L75-L77)）
- 每条 `assistant/message` 覆盖最终输出文本，并以同一 `turn/step` 键覆写该步用量（[packages/test-support/loader-smoke/src/agent-turn.ts:78-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L78-L83)）
- 通过 `agent.followup` 投递消息并等待整体空闲，随后在 `finally` 中解除事件监听（[packages/test-support/loader-smoke/src/agent-turn.ts:86-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L86-L91)）
- 返回前刷写会话，并把各步用量归并为一个总量随结果一起返回（[packages/test-support/loader-smoke/src/agent-turn.ts:92-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/agent-turn.ts#L92-L99)）

### packages/test-support/loader-smoke/src/index.ts

冒烟包的主入口：解析 src/lib 启动模式与命令行，在隔离临时目录里派生真实应用 bin 与 `cordis.yml`，捕获输出并在各种结局下清理。

- 默认进程期限 30 秒，并导出比它多 15 秒的测试超时常量（[packages/test-support/loader-smoke/src/index.ts:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L25-L28)）
- 启动模式取自环境变量 `DSH_EXAMPLE_MODE`（[packages/test-support/loader-smoke/src/index.ts:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L34)）
- `resolveExampleMode` 把未设置与空串归为 `src`，接受 `lib`，其余值抛错（[packages/test-support/loader-smoke/src/index.ts:43-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L43-L54)）
- `toLibBin` 按 `/src/`（或 Windows 反斜杠形式）切分推导出 `lib/*.js` 入口，找不到该段则抛错（[packages/test-support/loader-smoke/src/index.ts:85-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L85-L94)）
- `src` 模式缺少 `tsconfigPath` 时抛错（[packages/test-support/loader-smoke/src/index.ts:114-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L114-L117)）
- `src` 模式按 `sourceImport` 选择 `tsx/esm` 或通用 `tsx` 钩子，设置 `TSX_TSCONFIG_PATH`，并以 `node --import <钩子> <srcBin> <configArgs>` 启动（[packages/test-support/loader-smoke/src/index.ts:118-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L118-L122)）
- `lib` 模式以纯 Node 启动显式或推导出的 lib 入口，不加载 tsx、不注入 paths（[packages/test-support/loader-smoke/src/index.ts:125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L125)）
- `runLoaderSmoke` 先在临时父目录下创建隔离 cwd，并取用期限覆盖值（[packages/test-support/loader-smoke/src/index.ts:181-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L181-L182)）
- 进程启动前执行 `prepare` 钩子在该 cwd 里准备世界状态（[packages/test-support/loader-smoke/src/index.ts:184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L184)）
- bin 参数默认为 `[configPath]`，可由 `binArgs` 整体覆盖（[packages/test-support/loader-smoke/src/index.ts:188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L188)）
- 子进程环境里把 `DSH_HOME`/`DSH_AGENTS_HOME` 指向临时 cwd 下的目录，再叠加调用方的 env（[packages/test-support/loader-smoke/src/index.ts:191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L191)）
- 以 `input: ''` 立即关闭子进程 stdin，设置超时与 `SIGKILL`，`reject: false` 让派生错误、超时与非零退出都落到结果字段上，且不剥除末尾换行（[packages/test-support/loader-smoke/src/index.ts:197-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L197-L205)）
- 超时时抛出带标签、秒数与两路输出的错误（[packages/test-support/loader-smoke/src/index.ts:206-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L206-L208)）
- 退出码不等于 `expectedExitCode`（默认 0）时抛出带两路输出的错误（[packages/test-support/loader-smoke/src/index.ts:209-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L209-L212)）
- 清理前执行 `inspect` 钩子检查 cwd 里的世界状态，然后返回捕获的 stdout 与 stderr（[packages/test-support/loader-smoke/src/index.ts:213-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L213-L214)）
- `finally` 中递归强制删除临时 cwd，无论成功或抛错（[packages/test-support/loader-smoke/src/index.ts:215-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/index.ts#L215-L217)）

### packages/test-support/loader-smoke/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属，安装器为空。

- 导出插件名 `loader-smoke-invariant` 与 `inject: ['invariants']`（[packages/test-support/loader-smoke/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/invariant.ts#L13-L15)）
- `apply` 以包名注册空安装器并返回其 disposer（[packages/test-support/loader-smoke/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/loader-smoke/src/invariant.ts#L21-L29)）

### packages/test-support/loader-smoke/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、类型输出目录与工作区引用。

- 无运行期机制
