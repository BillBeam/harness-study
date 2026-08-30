---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-title-all-prompts-llm
---

# packages/session/session-title-all-prompts-llm

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、10 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-title-all-prompts-llm/README.md

该 provider 包的说明文档，面向选择标题策略或排查自动标题生成的使用者与维护者。

- 无运行期机制

### packages/session/session-title-all-prompts-llm/package.json

包清单，声明模块类型、入口、导出子路径与发布文件集。

- 声明 `"type": "module"`，`main` 指向 `lib/index.js`、`types` 指向 `lib/types/index.d.ts`（[packages/session/session-title-all-prompts-llm/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-all-prompts-llm/package.json#L13-L15)）
- `exports` 暴露 `.`、`./invariant` 与 `./package.json`（[packages/session/session-title-all-prompts-llm/package.json:16-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-all-prompts-llm/package.json#L16-L26)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.d.ts`（[packages/session/session-title-all-prompts-llm/package.json:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-all-prompts-llm/package.json#L27)）

### packages/session/session-title-all-prompts-llm/src/index.ts

函数插件入口，把共享 LLM 标题策略以 all-prompts 节奏注册为 `ctx.sessionTitle` 的 provider。

- 导出 `name` 与 `inject = ['sessionTitle', 'llm', 'sessions']`，三个服务齐备前该插件不启动（[packages/session/session-title-all-prompts-llm/src/index.ts:11-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-all-prompts-llm/src/index.ts#L11-L12)）
- 导出自己的静态可走查配置 schema，字段校验器直接取自共享的 `SessionTitleLlmConfigFields`，无本地默认值（[packages/session/session-title-all-prompts-llm/src/index.ts:18-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-all-prompts-llm/src/index.ts#L18-L26)）
- `apply` 调用 `registerSessionTitleLlmProvider`，以插件名为 provider id、`'all-prompts'` 为自动节奏、恒等函数为消息选择器（全部合格消息都进入生成输入）（[packages/session/session-title-all-prompts-llm/src/index.ts:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-all-prompts-llm/src/index.ts#L34-L36)）

### packages/session/session-title-all-prompts-llm/src/invariant.ts

包自带的不变量伴生插件，向不变量服务登记包名。

- `inject = ['invariants']` 要求不变量服务先就绪，伴生插件才能启动（[packages/session/session-title-all-prompts-llm/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-all-prompts-llm/src/invariant.ts#L15)）
- `apply` 以空安装器向 `ctx.invariants` 注册包名并返回注册的 disposer，运行期不做任何检查（[packages/session/session-title-all-prompts-llm/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-all-prompts-llm/src/invariant.ts#L21)、[packages/session/session-title-all-prompts-llm/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-title-all-prompts-llm/src/invariant.ts#L28-L29)）

### packages/session/session-title-all-prompts-llm/tsconfig.json

包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制
