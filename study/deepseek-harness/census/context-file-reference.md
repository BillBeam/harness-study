---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/context/file-reference
---

# packages/context/file-reference

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、12 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/context/file-reference/README.md

这是文件引用发现服务包的英文说明文档，介绍 `@file` 补全的用法、语法与提供者配对方式。

- 无运行期机制

### packages/context/file-reference/package.json

这是该服务包的 npm 清单，声明入口、子路径导出与发布产物。

- `main`/`types` 把裸包名导入解析到 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/context/file-reference/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference/package.json#L14-L15)）
- `exports` 开放 `.`、`./grammar`、`./invariant`、`./types`、`./src/*`、`./package.json`，其中 `./grammar` 与 `./types` 指向 `lib/types` 下的运行时 `.js`，供浏览器侧单独导入（[packages/context/file-reference/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference/package.json#L16-L35)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 以及 `lib/types` 下的 `.js` 与 `.d.ts`（[packages/context/file-reference/package.json:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference/package.json#L36-L41)）

### packages/context/file-reference/src/grammar.ts

这是浏览器可用的 `@file` 词法模块，被终端与网页客户端用来识别补全触发点并生成插入到提示词里的写法。

- `activeAtToken` 先匹配引号形式 `@"...`、再匹配裸形式 `@...`，且两者都要求 `@` 位于行首或空白之后，因此邮箱之类 token 内部的 `@` 不触发补全（[packages/context/file-reference/src/grammar.ts:26-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference/src/grammar.ts#L26-L35)）
- `formatFileMention` 给目录候选补尾部 `/`，对含控制字符或引号的路径直接返回 undefined（拒绝插入），含空白或显式保持引号时走 `@"..."`，其中目录保持引号不闭合以便继续下钻（[packages/context/file-reference/src/grammar.ts:45-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference/src/grammar.ts#L45-L55)）

### packages/context/file-reference/src/index.ts

这是包主入口，定义模型可见的引用提示常量与抽象的 `ctx.fileReferences` 服务。

- `FILE_REFERENCE_PROMPT` 固定一段模型可见文本，说明 `@` 前缀是工作区路径、尾斜杠代表目录、需要内容时必须调用 read 且不得未读先声称已看过（[packages/context/file-reference/src/index.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference/src/index.ts#L17)）
- 抽象服务类在构造时以 `fileReferences` 名注册到 Context，使挂载的提供者出现在全局服务表上（[packages/context/file-reference/src/index.ts:26-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference/src/index.ts#L26-L30)）
- 默认导出服务类，决定 Loader 以服务插件形式装载本包（[packages/context/file-reference/src/index.ts:45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference/src/index.ts#L45)）

### packages/context/file-reference/src/types.ts

这是候选记录的纯类型模块，供生成的远端客户端在不引入宿主运行时代码的情况下复用。

- 无运行期机制

### packages/context/file-reference/src/invariant.ts

这是本包的不变式伴生插件，注入 `invariants` 服务后以包名占位。

- `apply` 以包名向不变式注册表登记一个空安装器并返回其 disposer（[packages/context/file-reference/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference/src/invariant.ts#L28-L29)）

### packages/context/file-reference/tsconfig.json

这是本包的 TypeScript 编译配置，声明 rootDir、outDir 与工作区项目引用。

- 无运行期机制
