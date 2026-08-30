---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/feedback/command-feedback
---

# packages/feedback/command-feedback

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、18 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/feedback/command-feedback/README.md

包说明文档，介绍 `/feedback` 命令的输入、回执文案与分享披露语句。

- 无运行期机制

### packages/feedback/command-feedback/package.json

包清单，声明该插件包的入口、导出子路径与依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定 `import '@deepseek-ai/dsh-command-feedback'` 解析到的运行期模块（[packages/feedback/command-feedback/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./src/*`、`./package.json` 四个子路径，其余路径不可被外部解析（[packages/feedback/command-feedback/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/package.json#L16-L27)）
- `files` 只把 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts` 纳入发布产物（[packages/feedback/command-feedback/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/package.json#L28-L32)）
- `peerDependencies` 要求宿主提供 commands、invariants、session、session-telemetry、anonymous-user-id 与 cordis（[packages/feedback/command-feedback/package.json:34-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/package.json#L34-L41)）

### packages/feedback/command-feedback/src/index.ts

插件入口：声明 `feedback/record` 会话事件、导出 `recordFeedback` 生产者，并注册 `/feedback` 命令。

- 以 `name = 'command-feedback'` 命名插件，并用 `inject = ['commands']` 要求 commands 服务就绪后才 apply（[packages/feedback/command-feedback/src/index.ts:15-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L15-L16)）
- `assertNever` 对未列举的分享状态抛出带 JSON 值的错误（[packages/feedback/command-feedback/src/index.ts:22-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L22-L24)）
- `sharingSentence` 把 `full`/`feedback-only`/`disabled` 三种状态映射为三句固定文案，default 分支走 `assertNever`（[packages/feedback/command-feedback/src/index.ts:27-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L27-L39)）
- `sharingDisclosure` 在 telemetry 服务缺席时返回 `Session sharing is not configured.`，否则返回状态对应句（[packages/feedback/command-feedback/src/index.ts:49-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L49-L54)）
- 通过声明合并向 `SessionEventMap` 增加 `feedback/record` 事件，载荷为 `{ text: string }`（[packages/feedback/command-feedback/src/index.ts:56-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L56-L64)）
- `recordFeedback` 先 `trim`，空文本抛 `TypeError`，否则向会话日志追加一条 `feedback/record`（[packages/feedback/command-feedback/src/index.ts:72-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L72-L76)）
- 命令处理在 `rawInput` 去空白为空时直接返回 `kind: 'error'` 的用法提示，不写入任何事件（[packages/feedback/command-feedback/src/index.ts:88-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L88-L90)）
- 命令处理把原始输入交给 `recordFeedback` 写入调用方 agent 的会话（[packages/feedback/command-feedback/src/index.ts:91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L91)）
- 用 `ctx.get('sessionTelemetry')` 读取可选服务，服务缺席时命令仍可完成（[packages/feedback/command-feedback/src/index.ts:92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L92)）
- 成功回执文本拼接会话 id、`getOrCreateAnonymousUserId()` 取得（必要时新建）的匿名用户 id 与分享披露句（[packages/feedback/command-feedback/src/index.ts:93-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L93-L96)）
- `apply` 向命令注册表注册全局命令 `feedback`，带描述、输入提示 `<text>`，并以 `recordInput: false` 声明不记录原始输入（[packages/feedback/command-feedback/src/index.ts:100-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/index.ts#L100-L108)）

### packages/feedback/command-feedback/src/invariant.ts

包自带的不变量伴生插件，向 invariants 服务登记本包的所有权。

- 以 `inject = ['invariants']` 等待 invariants 服务，`apply` 用包名注册一个空安装器并返回其 disposer（[packages/feedback/command-feedback/src/invariant.ts:15-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/command-feedback/src/invariant.ts#L15-L29)）

### packages/feedback/command-feedback/tsconfig.json

TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
