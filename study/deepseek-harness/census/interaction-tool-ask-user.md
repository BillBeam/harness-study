---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/interaction/tool-ask-user
---

# packages/interaction/tool-ask-user

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、16 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/interaction/tool-ask-user/README.md

该包的英文说明文档，描述 `ask_user_question` 的调用时机、返回形状与失败情形。

- 无运行期机制

### packages/interaction/tool-ask-user/package.json

该包的 npm 清单，声明入口、子路径导出与发布文件白名单。

- `main` / `types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定包被直接 import 时解析到的运行期文件（[packages/interaction/tool-ask-user/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json`，其余子路径无法被解析（[packages/interaction/tool-ask-user/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/package.json#L16-L27)）
- `files` 白名单只打包 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.d.ts`（[packages/interaction/tool-ask-user/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/package.json#L28-L32)）

### packages/interaction/tool-ask-user/src/index.ts

函数式插件：把 `ctx.userQuestions` 能力包成一个面向模型的工具注册到 `ctx.tools`。

- 导出插件名 `tool-ask-user` 并声明 `tools`、`userQuestions` 两个注入，缺任一则插件不装载（[packages/interaction/tool-ask-user/src/index.ts:13-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/index.ts#L13-L14)）
- 定义模型可见的工具描述文本：说明何时提问以及每题需带可回显的稳定 id（[packages/interaction/tool-ask-user/src/index.ts:16-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/index.ts#L16-L17)）
- 以 `ctx.tools.register` 注册名为 `ask_user_question` 的工具（[packages/interaction/tool-ask-user/src/index.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/index.ts#L20-L22)）
- 声明模型可见的入参模式：必填 `questions` 数组，每项含必填 `id`、`question` 与可选 `header`、`options`（含 `label`/`description`，并提示把推荐项放首位并追加 “(Recommended)”）、`multi_select`（[packages/interaction/tool-ask-user/src/index.ts:23-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/index.ts#L23-L57)）
- 声明输出模式：`answers` 数组，每项必含 `id` 与 `selected` 字符串数组、可选 `custom`，且禁止多余属性（[packages/interaction/tool-ask-user/src/index.ts:58-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/index.ts#L58-L77)）
- `render` 把结构化结果 `JSON.stringify` 成单个文本块，决定模型在结果里看到的形态（[packages/interaction/tool-ask-user/src/index.ts:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/index.ts#L78)）
- `execute` 把模型参数逐题映射为请求项，`multi_select` 改名为 `multiSelect`，可选字段仅在存在时带上，并把执行上下文的 agent 与 `signal` 一并转交后 await 该调用（[packages/interaction/tool-ask-user/src/index.ts:80-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/index.ts#L80-L91)）
- 把返回的回答逐项映射回 `{ id, selected, custom? }`，`selected` 复制为新数组、`custom` 仅在存在时保留（[packages/interaction/tool-ask-user/src/index.ts:92-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/index.ts#L92-L98)）

### packages/interaction/tool-ask-user/src/invariant.ts

该包的不变量伴生插件，登记包归属但不安装任何检查。

- 声明伴生插件名与 `invariants` 注入需求（[packages/interaction/tool-ask-user/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/invariant.ts#L13-L15)）
- 安装器为空实现，并以注释写明该包无独立生命周期流可校验（[packages/interaction/tool-ask-user/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/invariant.ts#L17-L21)）
- `apply` 以包名向不变量服务登记该空安装器并返回其卸载器（[packages/interaction/tool-ask-user/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/tool-ask-user/src/invariant.ts#L28-L29)）

### packages/interaction/tool-ask-user/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工程引用。

- 无运行期机制
