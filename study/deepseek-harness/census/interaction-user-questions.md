---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/interaction/user-questions
---

# packages/interaction/user-questions

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、21 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/interaction/user-questions/README.md

该包的英文说明文档，描述 `ctx.userQuestions` 的公开方法、关键类型、呈现意图与已知限制。

- 无运行期机制

### packages/interaction/user-questions/package.json

该包的 npm 清单，声明入口、子路径导出与发布文件白名单。

- `main` / `types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定包被直接 import 时解析到的运行期文件（[packages/interaction/user-questions/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./types`、`./src/*` 与 `./package.json`，其余子路径无法被解析（[packages/interaction/user-questions/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/package.json#L16-L31)）
- `files` 白名单只打包 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`（[packages/interaction/user-questions/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/package.json#L32-L37)）

### packages/interaction/user-questions/src/index.ts

向人提问能力的服务定义：持有 `ctx.userQuestions`，做请求校验、调用方身份判定与答复者瀑布派发。

- 定义 `UserQuestionError`（`HarnessError` 子类），携带 `code` 并把 `name` 固定为 `UserQuestionError`（[packages/interaction/user-questions/src/index.ts:34-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L34-L39)）
- `abortedQuestion` 构造码为 `ASK_ABORTED` 的错误，并在有原因时挂上 `cause`（[packages/interaction/user-questions/src/index.ts:41-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L41-L47)）
- `restoreUserQuestionError` 把跨边界后退化成普通对象、但带有该 `name`/`message`/`code` 的拒绝原因重建成 `UserQuestionError`，其余原样返回（[packages/interaction/user-questions/src/index.ts:53-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L53-L62)）
- `ask` 在信号已中止时先抛 `ASK_ABORTED`，不做任何派发（[packages/interaction/user-questions/src/index.ts:87-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L87-L89)）
- 问题数组为空时抛 `EMPTY_QUESTIONS`（[packages/interaction/user-questions/src/index.ts:90-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L90-L92)）
- 携带 agent 时到 `agents` 注册表按 id 取实例并要求与传入者同一，否则抛 `CALLER_NOT_LIVE`（[packages/interaction/user-questions/src/index.ts:93-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L93-L100)）
- 该 agent 不在运行时根列表中时抛 `DELEGATED_CALLER`，并在消息中要求把未解决的问题写进子 agent 的最终结果（[packages/interaction/user-questions/src/index.ts:101-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L101-L106)）
- 逐题校验呈现意图：`approve` 标签未出现在该题自己的选项中、或声明了意图却没有 `detail`，都抛 `BAD_INTENT`（[packages/interaction/user-questions/src/index.ts:115-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L115-L129)）
- 瀑布链尾兜底返回一个码为 `NO_PROVIDER` 的拒绝，表示没有答复者接下请求（[packages/interaction/user-questions/src/index.ts:130-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L130-L133)）
- 无 agent 时按未定向方式派发 `user-questions/request`，有 agent 时以该 agent 作用域定向派发并把 agent 一并放入载荷（[packages/interaction/user-questions/src/index.ts:134-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L134-L142)）
- 捕获派发异常后先做错误还原：已是该错误类型则原样抛出，否则若信号此时已中止则改抛带 `cause` 的 `ASK_ABORTED`，再否则抛还原后的原因（[packages/interaction/user-questions/src/index.ts:143-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L143-L150)）
- 默认导出服务类，使该包可作为插件行被装载（[packages/interaction/user-questions/src/index.ts:154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/index.ts#L154)）

### packages/interaction/user-questions/src/invariant.ts

该包的不变量伴生插件，登记包归属但不安装任何检查。

- 声明伴生插件名与 `invariants` 注入需求（[packages/interaction/user-questions/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/invariant.ts#L13-L15)）
- 安装器为空实现，并以注释写明该能力不发布独立的请求/回答审计流（[packages/interaction/user-questions/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/invariant.ts#L17-L21)）
- `apply` 以包名向不变量服务登记该空安装器并返回其卸载器（[packages/interaction/user-questions/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-questions/src/invariant.ts#L28-L29)）

### packages/interaction/user-questions/src/types.ts

纯类型模块：问题项、选项、呈现意图、回答与答复者瀑布事件的声明。

- 无运行期机制

### packages/interaction/user-questions/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工程引用。

- 无运行期机制
