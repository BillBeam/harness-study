---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/hooks/hook-protocol
---

# packages/hooks/hook-protocol

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、62 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/hooks/hook-protocol/README.md

包的说明文档，介绍两个 hook 桥接共享的匹配、执行、解码、合并与事件记录规则以及已知限制。

- 无运行期机制

### packages/hooks/hook-protocol/package.json

包清单，声明该共享库的入口、发布内容与依赖关系。

- `main` / `types` 把默认入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/hooks/hook-protocol/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 和 `./package.json` 四个可解析入口（[packages/hooks/hook-protocol/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 和类型声明（[packages/hooks/hook-protocol/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/package.json#L28-L32)）

### packages/hooks/hook-protocol/src/codec.ts

把 hook 进程的退出码、stdout、stderr 解码成方言中立的结果对象，供两个桥接使用。

- 常量 `BLOCKING_EXIT_CODE = 2` 定义阻塞退出码（[packages/hooks/hook-protocol/src/codec.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L11)）
- `str` / `bool` 读取字段时类型不符即当作缺失，错误类型的字段不会进入结果（[packages/hooks/hook-protocol/src/codec.ts:14-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L14-L23)）
- `obj` 只接受非 null、非数组的普通对象，数组与 null 被拒（[packages/hooks/hook-protocol/src/codec.ts:26-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L26-L30)）
- 顶层 `decision` 只接受 `approve` / `block`，其余值（含 `deny`）被丢弃（[packages/hooks/hook-protocol/src/codec.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L38-L40)）
- `permissionDecision` 只接受 `allow` / `deny` / `ask`（[packages/hooks/hook-protocol/src/codec.ts:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L43-L45)）
- `parseHookOutput` 先 trim stdout/stderr，并把退出码、两条流原样放进结果（[packages/hooks/hook-protocol/src/codec.ts:60-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L60-L63)）
- 退出码为 2 时置 `decision = 'block'`，非空 stderr 成为 `reason`（[packages/hooks/hook-protocol/src/codec.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L66-L69)）
- 仅在退出码为 0 且 stdout 以 `{` 开头时尝试 JSON 解析，解析失败则不产生结构化字段、保留纯文本 stdout（[packages/hooks/hook-protocol/src/codec.ts:72-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L72-L86)）
- `applyStructured` 把 `continue` / `stopReason` / `systemMessage` 折进结果（[packages/hooks/hook-protocol/src/codec.ts:98-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L98-L103)）
- 顶层 `decision` 与 `reason` 折进结果（[packages/hooks/hook-protocol/src/codec.ts:107-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L107-L110)）
- `hookSpecificOutput.hookEventName` 无论是否匹配都记入结果（[packages/hooks/hook-protocol/src/codec.ts:117-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L117-L120)）
- 传入 `expectedEventName` 且事件名缺失或不符时提前返回，丢弃该块内所有事件范围字段（[packages/hooks/hook-protocol/src/codec.ts:122-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L122-L124)）
- `permissionDecision` 覆盖此前的顶层 `decision`，`permissionDecisionReason` 覆盖 `reason`（[packages/hooks/hook-protocol/src/codec.ts:125-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L125-L128)）
- `additionalContext` 与对象形状的 `updatedInput` 折进结果（[packages/hooks/hook-protocol/src/codec.ts:129-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/codec.ts#L129-L132)）

### packages/hooks/hook-protocol/src/detached.ts

为没有扩展点等待的 hook 运行提供在途登记与排空，被两个桥接的 `apply` 各创建一份。

- `createDetachedRuns` 建立在途 Promise 集合与一个 `AbortController`（[packages/hooks/hook-protocol/src/detached.ts:44-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/detached.ts#L44-L45)）
- 对外暴露 `signal`，交给 `runHook` 后可在排空时终止仍在跑的 hook 进程（[packages/hooks/hook-protocol/src/detached.ts:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/detached.ts#L47)）
- `track` 登记整条链并在其 settle 后从集合移除，成功与失败都吸收（[packages/hooks/hook-protocol/src/detached.ts:48-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/detached.ts#L48-L52)）
- `drain` 先以 `Error('hook bridge disposed')` 触发中止，再循环 `Promise.allSettled` 直到集合为空，把排空过程中新登记的链也等到（[packages/hooks/hook-protocol/src/detached.ts:53-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/detached.ts#L53-L60)）

### packages/hooks/hook-protocol/src/events.ts

向会话日志追加 `hook/invoked` 与 `hook/result` 这对记录的辅助函数，两个桥接共用。

- 常量 `DEFAULT_STDERR_SUMMARY_MAX_CHARS = 500` 作为 stderr 摘要的参考默认上限（[packages/hooks/hook-protocol/src/events.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/events.ts#L53)）
- `summarizeStderr` 先 trim，空串返回 `undefined`，超长时截到 `maxChars` 并接一个省略号（[packages/hooks/hook-protocol/src/events.ts:64-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/events.ts#L64-L68)）
- `appendHookInvoked` 向会话追加 `hook/invoked`，携带 turn、hook 点、方言与 handlerId，缺失的 `matcher` 从载荷中省略（[packages/hooks/hook-protocol/src/events.ts:75-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/events.ts#L75-L83)）
- `appendHookResult` 追加 `hook/result`，其 `decision` 取解析出的决定，否则 `continue === false` 记为 `stop`，再否则记为 `pass`（[packages/hooks/hook-protocol/src/events.ts:92-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/events.ts#L92-L99)）
- 结果事件按上限写入 stderr 摘要，缺失的退出码与空摘要从载荷中省略，并记录 `durationMs`（[packages/hooks/hook-protocol/src/events.ts:100-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/events.ts#L100-L103)）

### packages/hooks/hook-protocol/src/index.ts

包的公共导出面，把匹配、执行、解码、合并、事件与排空原语汇总给两个桥接。

- 无运行期机制

### packages/hooks/hook-protocol/src/invariant.ts

包自带的不变量伴生插件，校验会话日志里 `hook/invoked` 与 `hook/result` 的配对与取值。

- 声明 `inject = ['invariants']`（[packages/hooks/hook-protocol/src/invariant.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L13)）
- `hookKey` 以 turn、hook 点、handlerId 三元组作为配对键（[packages/hooks/hook-protocol/src/invariant.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L26-L28)）
- `validateHookEvent` 对非 hook 事件不处理，对 hook 事件要求处在已开启的 turn 内且事件所述 turn 与当前一致，否则报失败（[packages/hooks/hook-protocol/src/invariant.ts:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L36-L40)）
- `hook/invoked` 要求 point 与 handlerId 非空、dialect 只能是 `claude-code` 或 `codex`，并把该键的待配对计数加一（[packages/hooks/hook-protocol/src/invariant.ts:41-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L41-L49)）
- `hook/result` 要求存在未配对的同键 invoked、`durationMs` 为有限非负数，并把计数减一（[packages/hooks/hook-protocol/src/invariant.ts:51-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L51-L58)）
- `applyHookTransition` 维护待配对计数表，归零即删除条目（[packages/hooks/hook-protocol/src/invariant.ts:62-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L62-L66)）
- `seed` 回放会话已有事件重建当前开启的 turn 与待配对表，并在回放中同样执行校验（[packages/hooks/hook-protocol/src/invariant.ts:75-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L75-L84)）
- 安装时为已存在的所有会话建表，并在 `session/created` 上为新会话建表（[packages/hooks/hook-protocol/src/invariant.ts:87-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L87-L88)）
- `session/event` 监听器按 `turn/start` / `turn/end` 更新开启中的 turn，对 hook 事件要求已有预提交暂存否则报失败，再提交状态迁移（[packages/hooks/hook-protocol/src/invariant.ts:89-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L89-L105)）
- `internal/dispatch` 监听器在 `session/event` 派发前先做校验并把迁移暂存到该事件对象上（[packages/hooks/hook-protocol/src/invariant.ts:106-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L106-L111)）
- 安装器声明 `inject: ['sessions']`（[packages/hooks/hook-protocol/src/invariant.ts:112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L112)）
- `apply` 用包名向 `ctx.invariants` 注册安装器并返回 disposer（[packages/hooks/hook-protocol/src/invariant.ts:120-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/invariant.ts#L120-L121)）

### packages/hooks/hook-protocol/src/matcher.ts

匹配器引擎，决定一个配置的 matcher 模式是否选中某个查询值，两种方言以 `mode` 参数区分。

- `isMatchAll` 把缺失、空串和 `'*'` 视为全匹配哨兵（[packages/hooks/hook-protocol/src/matcher.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/matcher.ts#L13-L15)）
- 常量 `CLAUDE_LITERAL` 判定纯字母数字下划线与竖线的模式走字面量分支（[packages/hooks/hook-protocol/src/matcher.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/matcher.ts#L18)）
- `compileRegex` 用 try 包住 `new RegExp`，非法模式返回 `undefined` 而不抛出（[packages/hooks/hook-protocol/src/matcher.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/matcher.ts#L21-L29)）
- `matcherDiagnostic` 对非法正则返回带模式文本的诊断串，供配置解析拒绝整份配置（[packages/hooks/hook-protocol/src/matcher.ts:37-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/matcher.ts#L37-L44)）
- `matchesMatcher` 对全匹配哨兵返回 true，claude-code 字面量模式按 `|` 切分做精确匹配，其余走无锚定正则，非法正则返回 false（[packages/hooks/hook-protocol/src/matcher.ts:57-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/matcher.ts#L57-L65)）

### packages/hooks/hook-protocol/src/merge.ts

把同一 hook 点上所有命中 hook 的结果折叠为一个最严格结果，供桥接映射到扩展点决定。

- `rank` 把 `deny`/`block` 记为 3、`ask` 记为 2、`approve`/`allow` 记为 1、无决定记为 0（[packages/hooks/hook-protocol/src/merge.ts:35-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/merge.ts#L35-L42)）
- `decisionForRank` 把最高等级折回 `deny`/`ask`/`allow`/`none`（[packages/hooks/hook-protocol/src/merge.ts:45-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/merge.ts#L45-L52)）
- 遍历中取各 hook 决定的最高等级，并只把等级 3 与 2 的非空 reason 按等级分桶保留（[packages/hooks/hook-protocol/src/merge.ts:71-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/merge.ts#L71-L78)）
- 第一个 `continue === false` 置粘性 `stop` 并记下其 `stopReason`，后续 hook 不再覆盖（[packages/hooks/hook-protocol/src/merge.ts:79-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/merge.ts#L79-L82)）
- 非空 `additionalContext` 与 `systemMessage` 按 hook 顺序累积成数组（[packages/hooks/hook-protocol/src/merge.ts:83-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/merge.ts#L83-L88)）
- 最终只取胜出等级那一桶的 reason，用 `\n\n` 连接，空则整个字段省略（[packages/hooks/hook-protocol/src/merge.ts:91-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/merge.ts#L91-L99)）

### packages/hooks/hook-protocol/src/runner.ts

通过 shell 执行器运行单个命令 hook 并解码其结果，桥接负责提供载荷、环境与信号。

- 常量 `DEFAULT_HOOK_TIMEOUT_MS = 600_000` 作为参考默认的单 hook 超时（[packages/hooks/hook-protocol/src/runner.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/runner.ts#L20)）
- `runHook` 起始处取时钟读数，用于回报运行时长（[packages/hooks/hook-protocol/src/runner.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/runner.ts#L73)）
- hook 自带的 `timeoutSec` 乘一千后覆盖调用方传入的默认超时（[packages/hooks/hook-protocol/src/runner.ts:74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/runner.ts#L74)）
- stdin 为载荷的 JSON 序列化，是否追加换行由 `trailingNewline` 决定（[packages/hooks/hook-protocol/src/runner.ts:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/runner.ts#L75)）
- 组装执行请求，携带命令行、超时、stdin、取消信号，并按需带上 workdir 与 env（[packages/hooks/hook-protocol/src/runner.ts:77-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/runner.ts#L77-L84)）
- 经 `bash.resolve` 定型后由 `bash.run` 真正启动 hook 进程（[packages/hooks/hook-protocol/src/runner.ts:87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/runner.ts#L87)）
- 被信号杀死时执行器返回的 `null` 退出码映射为 `undefined`（[packages/hooks/hook-protocol/src/runner.ts:91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/runner.ts#L91)）
- 把退出码与两条流交给 `parseHookOutput`（带上期望事件名），并回报本次运行的墙钟时长（[packages/hooks/hook-protocol/src/runner.ts:92-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/runner.ts#L92-L95)）
- 执行器抛出的基础设施故障被捕获，转成无退出码、错误信息置于 stderr 的结果，不向调用中的 turn 抛出（[packages/hooks/hook-protocol/src/runner.ts:96-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/runner.ts#L96-L105)）

### packages/hooks/hook-protocol/src/types.ts

方言中立的类型声明文件，声明合并出 `hook/invoked` / `hook/result` 两个日志事件的载荷类型以及 hook 配置与结果的类型。

- 无运行期机制

### packages/hooks/hook-protocol/tsconfig.json

包的 TypeScript 编译配置，声明源码根、输出目录与工作区引用。

- 无运行期机制
