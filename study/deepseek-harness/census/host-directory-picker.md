---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/host/directory-picker
---

# packages/host/directory-picker

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、12 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/host/directory-picker/README.md

该目录选择接缝包的说明文档，描述能力契约、错误码与两个后端的差异，供阅读者使用。

- 无运行期机制

### packages/host/directory-picker/package.json

该包的 npm 清单，声明入口、导出子路径与发布文件集。

- `main`/`types` 指定包的默认运行时入口为 `lib/index.js`、类型入口为 `lib/types/index.d.ts`（[packages/host/directory-picker/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./types` 三个子路径分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/types/types.js`，并额外开放 `./src/*` 与 `./package.json`（[packages/host/directory-picker/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker/package.json#L16-L31)）
- `files` 限定发布进包的文件为 `lib/index.js`、`lib/invariant.js` 以及 `lib/types` 下的 js 与 d.ts（[packages/host/directory-picker/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker/package.json#L32-L37)）
- `peerDependencies` 把 invariants 与 cordis 声明为宿主提供的对等依赖（[packages/host/directory-picker/package.json:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker/package.json#L39-L42)）

### packages/host/directory-picker/src/index.ts

该接缝的服务定义模块，声明目录选择能力的判别联合、错误类型与抽象服务类，供两个后端继承、供消费方分支。

- `DirectoryPickerError` 构造函数把业务码与主体路径存为只读字段，并把 `name` 覆写为 `'DirectoryPickerError'`，抛出的异常对象因此对外携带这两项（[packages/host/directory-picker/src/index.ts:78-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker/src/index.ts#L78-L88)）
- `DirectoryPicker` 继承 `Service` 并在构造时以 `'directoryPicker'` 之名注册，子类加载即占用该服务槽位，同时要求子类实现 `capability()` 作为消费方的分支入口（[packages/host/directory-picker/src/index.ts:103-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker/src/index.ts#L103-L113)）

### packages/host/directory-picker/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名归属。

- `inject` 声明该伴生插件依赖 `invariants` 服务，未就绪则不执行 `apply`（[packages/host/directory-picker/src/invariant.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker/src/invariant.ts#L11)）
- installer 为空函数，注册后不安装任何运行期检查（[packages/host/directory-picker/src/invariant.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker/src/invariant.ts#L17)）
- `apply` 调用 `ctx.invariants.register` 以包名注册该 installer 并返回其 disposer（[packages/host/directory-picker/src/invariant.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker/src/invariant.ts#L24-L25)）

### packages/host/directory-picker/src/types.ts

该接缝面向客户端的类型声明文件，定义一条目录行与一层目录列表的字段。

- 无运行期机制

### packages/host/directory-picker/tsconfig.json

该包的 TypeScript 编译配置，设定源目录、产物目录与项目引用。

- 无运行期机制
