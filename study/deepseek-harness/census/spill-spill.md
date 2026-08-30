---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/spill/spill
---

# packages/spill/spill

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、12 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/spill/spill/README.md

这个包的英文说明页，描述溢出存储服务的用法、`SpillRef` 三个字段、所有权边界与失败行为，供阅读者参考。

- 无运行期机制

### packages/spill/spill/package.json

包清单，声明该包如何被 Node 解析、发布哪些文件，以及它依赖哪些同仓库包。

- `type: module` 与 `main`/`types` 让该包按 ESM 加载，主入口解析到 `lib/index.js`（[packages/spill/spill/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant` 子路径、`./src/*` 源码直通与 `./package.json` 四条路径（[packages/spill/spill/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/spill/spill/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/package.json#L28-L32)）

### packages/spill/spill/src/index.ts

包入口，定义溢出存储能力的抽象服务类 `SpillStore`，由具体后端子类化后作为插件加载。

- `SpillStore` 继承 `Service`，构造时以服务名 `spillStore` 注册，使子类实例成为 `ctx.spillStore`，同一 context 第二次加载会抛错（[packages/spill/spill/src/index.ts:45-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/src/index.ts#L45-L48)）
- 声明抽象方法 `saveText(input)`，要求实现原样持久化全文并返回定位符、字节数与检索提示，且在真实存储失败时 reject（[packages/spill/spill/src/index.ts:50-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/src/index.ts#L50-L55)）
- 默认导出 `SpillStore`，使该类成为包被当作插件加载时取到的对象（[packages/spill/spill/src/index.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/src/index.ts#L58)）

### packages/spill/spill/src/invariant.ts

该包的不变量伴生插件，向不变量服务登记包名。

- 导出 `name` 与 `inject = ['invariants']`，使其成为需要 `invariants` 服务就绪后才激活的 cordis 插件（[packages/spill/spill/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/src/invariant.ts#L13-L15)）
- `install` 是空安装器，不注册任何检查（[packages/spill/spill/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其注销函数（[packages/spill/spill/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/src/invariant.ts#L28-L29)）

### packages/spill/spill/src/types.ts

溢出存储服务的词汇文件，声明请求与结果的接口，并提供定位符的品牌构造函数。

- `SpillLocator(locator)` 在运行期直接返回传入字符串，把后端产出的定位符标记为品牌类型（[packages/spill/spill/src/types.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill/src/types.ts#L26-L28)）

### packages/spill/spill/tsconfig.json

该包的 TypeScript 编译配置，设定源码根、输出目录与工程引用。

- 无运行期机制
