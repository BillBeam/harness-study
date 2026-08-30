---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/group
---

# vendor/group

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 4 个文件、6 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/group/README.md

嵌套条目组插件的包说明，介绍在 YAML 条目表中声明 `group: true` 的用法与嵌套 id 的 `:` 分隔约定。

- 无运行期机制

### vendor/group/package.json

该包的 npm 清单，声明入口、导出映射与发布文件集合。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定按包名导入时实际加载的运行期文件（[vendor/group/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/group/package.json#L14-L15)）
- `exports` 把 `.` 解析到 `lib/index.js`，并额外开放 `./src/*` 与 `./package.json` 两个子路径（[vendor/group/package.json:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/group/package.json#L16-L23)）
- `files` 限定发布产物为 `lib/index.js`、类型声明与 `src` 目录（[vendor/group/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/group/package.json#L24-L29)）

### vendor/group/src/index.ts

该包的唯一源码入口，被条目表中以本包名声明的条目导入。

- 默认导出绑定 loader 包的 `Group` 类，使以本包名声明的条目挂载为嵌套条目组，其 `config` 按子条目表处理（[vendor/group/src/index.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/group/src/index.ts#L1-L3)）

### vendor/group/tsconfig.json

该包的 TypeScript 编译配置，供仓库构建与类型检查使用。

- 无运行期机制
