---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/group
---

# vendor/group

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 4 个文件、5 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/group/README.md

该包的说明文档，描述用 group 条目嵌套子条目列表的写法与嵌套 id 的 `:` 分隔约定。

- 无运行期机制

### vendor/group/package.json

该包的发布清单，供包管理器与运行期模块解析读取。

- `exports` 把包名解析到 `lib/index.js`，`main`/`types` 给出同一入口（[vendor/group/package.json:14-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/group/package.json#L14-L23)）
- `files` 限定发布进包的内容为 `lib/index.js`、类型声明与 `src`（[vendor/group/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/group/package.json#L24-L29)）

### vendor/group/src/index.ts

该包的唯一源码文件，是加载器按条目 `name` 导入该包时拿到的插件本体。

- 把加载器包里的 `Group` 作为默认导出，使以该包名声明的条目在运行期成为嵌套条目组（[vendor/group/src/index.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/group/src/index.ts#L1-L3)）

### vendor/group/tsconfig.json

该包的 TypeScript 编译配置，只在构建与类型检查时使用。

- 无运行期机制
