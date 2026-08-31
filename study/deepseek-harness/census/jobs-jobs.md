---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/jobs/jobs
---

# packages/jobs/jobs

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、17 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/jobs/jobs/README.md

该包的英文说明文档，描述后台作业的 id、归属、生命周期、控制器要求与最小组合。

- 无运行期机制

### packages/jobs/jobs/package.json

该包的 npm 清单，声明入口、子路径导出与发布文件白名单。

- `main` / `types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定包被直接 import 时解析到的运行期文件（[packages/jobs/jobs/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./brand`、`./src/*` 与 `./package.json`，其余子路径无法被解析（[packages/jobs/jobs/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/package.json#L16-L31)）
- `files` 白名单只打包 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`（[packages/jobs/jobs/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/package.json#L32-L37)）

### packages/jobs/jobs/src/brand.ts

作业 id 的独立叶子模块，供不能解析 agent 依赖的消费方单独引入。

- 导出 `JobId(id)` 运行期函数，原样返回传入字符串并附加品牌类型，不做任何校验（[packages/jobs/jobs/src/brand.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/brand.ts#L26-L28)）

### packages/jobs/jobs/src/index.ts

后台作业能力的服务定义：抽象类 `JobRegistry` 声明 `ctx.jobs` 的方法集与语义，具体注册表由别的包实现。

- 构造时若被直接实例化（`new.target` 等于抽象类本身）就抛错，要求改装具体实现，从而在装载期而不是调用期失败（[packages/jobs/jobs/src/index.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/index.ts#L66-L69)）
- 以服务名 `jobs` 调用父类构造，使子类装载后即占据 `ctx.jobs`（重复装载按 cordis 的重名服务行为抛错）（[packages/jobs/jobs/src/index.ts:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/index.ts#L70)）
- 默认导出该抽象类，使实现包与组合行以它为装载入口（[packages/jobs/jobs/src/index.ts:179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/index.ts#L179)）

### packages/jobs/jobs/src/invariant.ts

该包的不变量伴生插件，校验注册表交出的作业快照内部字段关系。

- 声明伴生插件名与 `invariants` 注入需求（[packages/jobs/jobs/src/invariant.ts:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/invariant.ts#L12-L14)）
- 校验 id 必须是 `<kind>-` 前缀加正整数序号，且 kind 非空（[packages/jobs/jobs/src/invariant.ts:18-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/invariant.ts#L18-L24)）
- 校验 `label` 非空、`startedAt` 是非负安全整数（[packages/jobs/jobs/src/invariant.ts:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/invariant.ts#L25-L28)）
- 校验 `finishedAt` 当且仅当状态为终态时存在，且其值为不早于 `startedAt` 的安全整数（[packages/jobs/jobs/src/invariant.ts:30-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/invariant.ts#L30-L37)）
- 校验快照的 `ownerSession` 与完成回调带回的属主 id 一致（[packages/jobs/jobs/src/invariant.ts:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/invariant.ts#L39-L42)）
- 安装时先对当前无属主的记录逐个校验，再注册完成监听器对每个终态快照校验，并声明 `jobs` 注入（[packages/jobs/jobs/src/invariant.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/invariant.ts#L46-L49)）
- `apply` 以包名向不变量服务登记该安装器并返回其卸载器（[packages/jobs/jobs/src/invariant.ts:56-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs/src/invariant.ts#L56-L57)）

### packages/jobs/jobs/src/types.ts

纯类型模块：作业状态、可扩展的种类映射、启动声明、生产者钩子、快照与两类监听器签名。

- 无运行期机制

### packages/jobs/jobs/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工程引用。

- 无运行期机制
