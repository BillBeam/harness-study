---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-title-llm
---

# packages/session/session-title-llm

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、29 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-title-llm/README.md

该包的英文 README，说明模型生成标题的共享路由、预算、失败与配置规则。

- 记载路由规则：`provider`/`model` 必须成对给出，否则使用当前会话已记录 `request/header` 的路由（[packages/session/session-title-llm/README.md:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/README.md#L36)）
- 记载在记录与派发前按 `maxInputBytes` 度量最终 JSON 框定提示词，不截断；流消费中与完成后复查超时与取消（[packages/session/session-title-llm/README.md:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/README.md#L36)）
- 记载配置字段表：除成对路由外全部必填，无库级默认值（[packages/session/session-title-llm/README.md:44-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/README.md#L44-L51)）
- 记载请求流程：先追加 log-only 的 `session/title-llm-request` 事件，再在合成的超时/取消期限下经 `ctx.llm` 流式调用；派发信封带 `purpose: 'session-title'` 且不带主循环的进程内请求标识（[packages/session/session-title-llm/README.md:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/README.md#L75)）
- 记载模型可见内容：固定系统指令加一条含所选人类消息及其 seq 的 JSON 数组用户消息（[packages/session/session-title-llm/README.md:101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/README.md#L101)）

### packages/session/session-title-llm/package.json

该包的 npm 清单，声明入口、导出子路径与依赖关系。

- `exports` 暴露包根、`./invariant` 以及 `./src/*` 源码直读子路径（[packages/session/session-title-llm/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/package.json#L16-L27)）
- `files` 限定发布产物只含两个运行时入口与类型声明（[packages/session/session-title-llm/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/package.json#L28-L32)）

### packages/session/session-title-llm/src/index.ts

模型标题生成的共享库：配置校验、提供者注册助手、请求框定、派发与输出校验，被两个提供者插件调用。

- 通过声明合并把 `session/title-llm-request` 加入 `SessionEventMap`，使这条派发前记录成为会话日志中的合法事件（[packages/session/session-title-llm/src/index.ts:40-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L40-L45)）
- 导出共享 Loader 字段 schema：五个数值字段均为必填正整数，`timeoutMs` 上限为 `MAX_TIMER_DELAY_MS`（[packages/session/session-title-llm/src/index.ts:72-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L72-L83)）
- `resolveSessionTitleLlmConfig` 拒绝未知配置键（[packages/session/session-title-llm/src/index.ts:116-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L116-L118)）
- 逐项断言五个预算为正整数，并单独复查 `timeoutMs` 不超过定时器上限（[packages/session/session-title-llm/src/index.ts:119-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L119-L126)）
- 要求 `provider` 与 `model` 同时存在或同时缺席，且存在时必须是非空字符串，然后深冻结配置副本（[packages/session/session-title-llm/src/index.ts:127-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L127-L137)）
- `registerSessionTitleLlmProvider` 在注册时一次性校验配置，并把带有 id、自动节奏与 `generate` 的提供者装到 `ctx.sessionTitle` 上（[packages/session/session-title-llm/src/index.ts:160-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L160-L168)）
- `resolveRoute` 优先取显式成对路由，否则取请求携带的已记录路由；两者皆无时抛错（[packages/session/session-title-llm/src/index.ts:172-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L172-L183)）
- `systemPrompt` 拼出模型可见的四行系统指令，含只输出一行纯文本、跟随消息语言、以及配置的词数/CJK 字数目标（[packages/session/session-title-llm/src/index.ts:186-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L186-L193)）
- `frameMessages` 把所选消息 JSON 序列化后嵌进一句固定指令，作为模型可见的用户消息文本（[packages/session/session-title-llm/src/index.ts:196-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L196-L198)）
- `finishError` 把 `error`/`aborted`/`max-tokens`/`tool-calls` 及未知结束原因映射为抛出的错误，仅 `stop` 放行（[packages/session/session-title-llm/src/index.ts:201-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L201-L218)）
- 生成入口先检查调用方取消信号，并在所选消息为空时抛错（[packages/session/session-title-llm/src/index.ts:236-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L236-L239)）
- 按 UTF-8 字节度量框定后的输入，超过 `maxInputBytes` 即抛错，不做截断（[packages/session/session-title-llm/src/index.ts:240-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L240-L244)）
- 构造标注来源为 `plugin: 'dsh-session-title-llm'` 的用户消息（[packages/session/session-title-llm/src/index.ts:246-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L246-L249)）
- 用 `deadline` 把调用方信号与 `timeoutMs` 合成一个带 `SESSION_TITLE_TIMEOUT` 原因码的期限信号，`using` 在退出时清理定时器（[packages/session/session-title-llm/src/index.ts:251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L251)）
- 组装并深冻结派发选项，带上路由、系统提示、消息、`maxTokens`、会话 id、`purpose: 'session-title'` 与期限信号（[packages/session/session-title-llm/src/index.ts:252-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L252-L261)）
- 在派发前向会话日志追加 `session/title-llm-request`，记录提供者 id、消息 seq 列表、路由、系统提示、消息与 token 上限（[packages/session/session-title-llm/src/index.ts:262-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L262-L269)）
- 流式消费 `ctx.llm.stream`，在派发前、每个分片以及流结束后都复查期限信号（[packages/session/session-title-llm/src/index.ts:270-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L270-L276)）
- 结束原因非 `stop` 时抛出对应错误，输出含工具调用块时拒绝（[packages/session/session-title-llm/src/index.ts:277-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L277-L282)）
- 只取文本块拼接后做标题归一化，归一化结果为空则抛错（[packages/session/session-title-llm/src/index.ts:283-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L283-L288)）
- 返回标题、被引用的消息 seq 列表与实际使用的模型路由（[packages/session/session-title-llm/src/index.ts:289-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/index.ts#L289-L293)）

### packages/session/session-title-llm/src/invariant.ts

该包的不变式伴随插件，向 `invariants` 服务登记包名。

- `apply` 向 `ctx.invariants` 注册包名与一个空安装器，并返回其 disposer（[packages/session/session-title-llm/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-llm/src/invariant.ts#L21-L29)）

### packages/session/session-title-llm/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制
