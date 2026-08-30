---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-title-first-prompt-llm
---

# packages/session/session-title-first-prompt-llm

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、12 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-title-first-prompt-llm/README.md

该包的英文 README，说明这个标题提供者何时自动生成、接受哪些配置字段、失败后如何处理。

- 记载自动生成的触发条件：无父会话、只有一条合格人类消息、尚无标题时才起一次修订，且在主请求路由被记录之后才发起调用（[packages/session/session-title-first-prompt-llm/README.md:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/README.md#L32)）
- 记载配置字段集合与 `provider`/`model` 成对省略时继承当前已记录主请求路由的规则（[packages/session/session-title-first-prompt-llm/README.md:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/README.md#L36)）
- 记载失败处理：缺路由、超 `maxInputBytes`、超时、取消或输出非法时告警并保留当前标题，仅 `refresh()` 重试（[packages/session/session-title-first-prompt-llm/README.md:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/README.md#L40)）
- 记载模型可见输入为共享标题指令加仅含第一条合格人类消息的 JSON 数组，主请求不增加 token（[packages/session/session-title-first-prompt-llm/README.md:89-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/README.md#L89-L93)）

### packages/session/session-title-first-prompt-llm/package.json

该包的 npm 清单，声明入口、导出子路径与依赖关系。

- `main`/`types`/`exports` 把包根解析到 `lib/index.js`，并单独暴露 `./invariant` 子路径入口（[packages/session/session-title-first-prompt-llm/package.json:14-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/package.json#L14-L26)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/session/session-title-first-prompt-llm/package.json:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/package.json#L27)）

### packages/session/session-title-first-prompt-llm/src/index.ts

插件入口：把「取第一条人类消息」的选择器注册成 `ctx.sessionTitle` 的 `first-prompt` 提供者。

- `inject` 声明该插件挂载前必须存在 `sessionTitle`、`llm`、`sessions` 三个服务（[packages/session/session-title-first-prompt-llm/src/index.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/src/index.ts#L12)）
- 导出可被 Loader 静态遍历的 `Config` schema，逐字段复用共享校验器，无本地默认值（[packages/session/session-title-first-prompt-llm/src/index.ts:18-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/src/index.ts#L18-L26)）
- `apply` 以 `first-prompt` 节奏调用共享注册函数，把提供者装到标题服务上（[packages/session/session-title-first-prompt-llm/src/index.ts:34-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/src/index.ts#L34-L39)）
- 选择器只取消息数组第 0 项作为送模型的输入；数组为空时抛错终止本次生成（[packages/session/session-title-first-prompt-llm/src/index.ts:35-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/src/index.ts#L35-L38)）

### packages/session/session-title-first-prompt-llm/src/invariant.ts

该包的不变式伴随插件，向 `invariants` 服务登记包名。

- `apply` 向 `ctx.invariants` 注册包名与一个空安装器，并返回其 disposer（[packages/session/session-title-first-prompt-llm/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-first-prompt-llm/src/invariant.ts#L21-L29)）

### packages/session/session-title-first-prompt-llm/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制
