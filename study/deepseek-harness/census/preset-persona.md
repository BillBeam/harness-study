---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/preset/persona
---

# packages/preset/persona

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、14 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/preset/persona/README.md

包参考文档，说明这一行如何在预设组合里注册人格段、complete 模式与运行期上下文抑制的含义，供使用者与维护者阅读。

- 无运行期机制

### packages/preset/persona/package.json

包清单，声明该行的入口、导出与发布内容。

- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，并把 `./src/*` 与 `./package.json` 原样暴露，决定加载器实际载入哪些模块（[packages/preset/persona/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/package.json#L16-L27)）
- `files` 把发布内容限制为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的声明文件（[packages/preset/persona/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/package.json#L28-L32)）
- `peerDependencies` 要求宿主提供 `dsh-invariants`、`dsh-system-prompt` 与 cordis，使该行运行时与提示词注册表共用同一实例（[packages/preset/persona/package.json:34-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/package.json#L34-L38)）

### packages/preset/persona/src/index.ts

插件入口，在挂载它的作用域内注册 `deployment:persona` 提示词段，并可关闭该作用域的运行期上下文快照。

- 从 `dsh-system-prompt` 导入 `PERSONA_ORDER` 与 `PERSONA_SECTION` 并再导出，使该行注册的段名与序号与注册表自身的人格槽位一致（[packages/preset/persona/src/index.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/src/index.ts#L23-L25)）
- `inject = ['systemPrompt']` 使该插件在提示词注册表可用之后才执行 `apply`（[packages/preset/persona/src/index.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/src/index.ts#L31)）
- 运行期 schema 要求 `text` 必填，并给 `complete` 默认 `false`、`includeRuntimeContext` 默认 `true`（[packages/preset/persona/src/index.ts:48-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/src/index.ts#L48-L52)）
- `apply` 通过 `ctx.effect` 注册一个名为 `PERSONA_SECTION`、序号为 `PERSONA_ORDER`、正文为 `config.text` 的提示词段，并把注销挂在该 effect 上（[packages/preset/persona/src/index.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/src/index.ts#L61-L66)）
- `complete` 为真时在段注册参数上附加 `complete: true`（[packages/preset/persona/src/index.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/src/index.ts#L65)）
- `includeRuntimeContext` 为假时调用 `ctx.systemPrompt.suppressRuntimeContext()`（[packages/preset/persona/src/index.ts:67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/src/index.ts#L67)）

### packages/preset/persona/src/invariant.ts

该包的不变量伴生插件，向不变量注册表登记包名。

- `inject = ['invariants']` 使伴生插件在不变量注册表可用之后才执行（[packages/preset/persona/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/src/invariant.ts#L15)）
- 安装器为空函数，登记后不注册任何监听或检查（[packages/preset/persona/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/src/invariant.ts#L22)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 占用该包名并返回注销函数（[packages/preset/persona/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/persona/src/invariant.ts#L29-L30)）

### packages/preset/persona/tsconfig.json

该包的 TypeScript 编译配置与工程引用。

- 无运行期机制
