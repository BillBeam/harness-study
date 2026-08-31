---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/core/agent-tool-presentation
---

# packages/core/agent-tool-presentation

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、10 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/core/agent-tool-presentation/README.md

包的英文说明文档，描述该行如何选择模型看到的工具呈现形式、PTC 模式对代码运行时的要求，以及一个组合里只允许一份声明。

- 无运行期机制

### packages/core/agent-tool-presentation/package.json

包清单，声明模块类型、入口、子路径导出与随包发布的文件。

- `"type": "module"` 与 `main`/`types` 指向 `lib/index.js` 及其类型声明（[packages/core/agent-tool-presentation/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-tool-presentation/package.json#L13-L15)）
- `exports` 开放根入口、`./invariant`、`./src/*` 源码直读与 `./package.json` 四类解析入口（[packages/core/agent-tool-presentation/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-tool-presentation/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 和 `lib/types/**/*.d.ts`（[packages/core/agent-tool-presentation/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-tool-presentation/package.json#L28-L32)）

### packages/core/agent-tool-presentation/src/index.ts

函数式插件入口：读一个 `mode` 配置，向挂载作用域声明这一批 agent 的模型看到的工具形式。

- 只注入 `tools`，不注入 `codeRuntime`，因此 `native` 行在没有代码运行时的部署里也能挂上（[packages/core/agent-tool-presentation/src/index.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-tool-presentation/src/index.ts#L35)）
- 配置 schema 把 `mode` 限定为 `native`/`ptc`/`both` 三选一且必填（[packages/core/agent-tool-presentation/src/index.ts:50-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-tool-presentation/src/index.ts#L50-L52)）
- `native` 模式立即对挂载上下文调用 `ctx.tools.presentAs('native')`，该调用本身即效果、随本行卸载而撤销（[packages/core/agent-tool-presentation/src/index.ts:63-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-tool-presentation/src/index.ts#L63-L66)）
- `ptc` 与 `both` 模式把声明放进一个等待 `codeRuntime` 的注入里，运行时缺席时这一行始终挂起（[packages/core/agent-tool-presentation/src/index.ts:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-tool-presentation/src/index.ts#L69-L71)）

### packages/core/agent-tool-presentation/src/invariant.ts

包自带的不变量伴随插件，向 `invariants` 服务登记本包的所有权，但安装器为空。

- 以包名向 `ctx.invariants` 注册一个不挂任何检查的安装器并返回其 disposer（[packages/core/agent-tool-presentation/src/invariant.ts:23-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-tool-presentation/src/invariant.ts#L23-L31)）

### packages/core/agent-tool-presentation/tsconfig.json

包的 TypeScript 编译配置，声明源目录、类型输出目录与项目引用。

- 无运行期机制
