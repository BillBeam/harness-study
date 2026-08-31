---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/util/brand
---

# packages/util/brand

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、9 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/util/brand/README.md

包 README，介绍 `Branded<B>` 名义类型原语、如何为跨包 id 加品牌，以及何时不该加。

- 无运行期机制

### packages/util/brand/package.json

包清单，声明入口、子路径导出与发布内容。

- `type: module` 与 `main`/`types` 把包入口指向 `lib/index.js` 及其声明文件（[packages/util/brand/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/brand/package.json#L13-L15)）
- `exports` 把 `.` 与 `./invariant` 解析到 `lib` 产物，并把 `./src/*` 直通源码目录（[packages/util/brand/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/brand/package.json#L16-L27)）
- `files` 把发布内容限定为两个 `lib` 入口与 `lib/types` 下的 d.ts（[packages/util/brand/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/brand/package.json#L28-L32)）

### packages/util/brand/src/index.ts

包的全部内容：一个模块私有的 `unique symbol` 与建立在其上的 `Branded<B>` 类型别名，编译后完全擦除。

- 无运行期机制

### packages/util/brand/src/invariant.ts

包自有的 invariant 伴生插件，被 `./invariant` 子路径导出。

- 导出 `name` 与 `inject`，声明插件名并要求先有 `invariants` 服务（[packages/util/brand/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/brand/src/invariant.ts#L12-L15)）
- `install` 为空函数，注册后不安装任何检查（[packages/util/brand/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/brand/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该 installer，并把注册返回的 disposer 包成 Promise 返回（[packages/util/brand/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/brand/src/invariant.ts#L28-L29)）

### packages/util/brand/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
