---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/util/workspace-path
---

# packages/util/workspace-path

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、17 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/util/workspace-path/README.md

该包的英文 README，说明这组浏览器安全的路径辅助函数只做词法处理、home 缩写只覆盖 POSIX，供阅读者与文档站使用。

- 无运行期机制

### packages/util/workspace-path/package.json

该包的 npm 清单，决定这个工具库以什么入口、什么子路径被其他包导入。

- `type: module` 与 `main`/`types` 把包按 ESM 从 `lib/index.js` 加载（[packages/util/workspace-path/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/package.json#L13-L15)）
- `exports` 把根入口映射到 `lib/index.js`、`./invariant` 映射到 `lib/invariant.js`，并额外开放 `./src/*` 与 `./package.json` 两个子路径（[packages/util/workspace-path/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/util/workspace-path/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/package.json#L28-L32)）

### packages/util/workspace-path/src/index.ts

该包唯一的实现文件，提供工作区相对路径拼接、POSIX home 缩写与标题取段，被面向工作区的客户端和控制器包共用。

- `isWindowsStylePath` 用正则识别盘符前缀与 UNC 双反斜杠前缀（[packages/util/workspace-path/src/index.ts:7-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/index.ts#L7-L9)）
- `resolveWorkspacePath` 对以 `/` 开头或 Windows 风格的路径原样返回，不再拼接（[packages/util/workspace-path/src/index.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/index.ts#L18)）
- 工作区根缺省或为空串时同样原样返回入参路径（[packages/util/workspace-path/src/index.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/index.ts#L19)）
- 否则剥掉根的尾部分隔符与相对路径的前导分隔符，以 `/` 连接成绝对路径（[packages/util/workspace-path/src/index.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/index.ts#L20-L22)）
- `abbreviateHomePath` 在 home 缺省或为空串时跳过缩写（[packages/util/workspace-path/src/index.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/index.ts#L32)）
- 路径或 home 任一为 Windows 风格时跳过缩写（[packages/util/workspace-path/src/index.ts:33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/index.ts#L33)）
- 去掉 home 尾部斜杠后若结果为空或为根 `/` 则跳过缩写（[packages/util/workspace-path/src/index.ts:34-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/index.ts#L34-L35)）
- 路径去尾斜杠后等于 home 则显示为 `~`，是 home 的后代则把 home 前缀换成 `~`，其余原样返回（[packages/util/workspace-path/src/index.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/index.ts#L36-L38)）
- `workspaceTitleOf` 去掉尾部的 `/` 或 `\` 后，取最后一个分隔符之后的片段作为显示标题，纯分隔符路径得到空串（[packages/util/workspace-path/src/index.ts:47-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/index.ts#L47-L51)）

### packages/util/workspace-path/src/invariant.ts

该包的 invariant 伴生插件，被 invariants 服务加载以登记包所有权。

- 导出 `name` 与 `inject`，把伴生插件命名为 `workspace-path-invariant` 并声明依赖 `invariants` 服务（[packages/util/workspace-path/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/invariant.ts#L13-L15)）
- 安装函数为空体，不注册任何运行期检查（[packages/util/workspace-path/src/invariant.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/invariant.ts#L18)）
- `apply` 用包名向 `ctx.invariants` 注册该安装函数并返回其 disposer（[packages/util/workspace-path/src/invariant.ts:25-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/workspace-path/src/invariant.ts#L25-L26)）

### packages/util/workspace-path/tsconfig.json

该包的 TypeScript 编译配置，规定源目录、声明输出目录与工程引用。

- 无运行期机制
