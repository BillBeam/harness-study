---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/util/launch-environment
---

# packages/util/launch-environment

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、15 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/util/launch-environment/README.md

该包的英文 README，说明启动环境快照的层级、信任顺序与取用方式，供阅读者与文档站使用。

- 无运行期机制

### packages/util/launch-environment/package.json

该包的 npm 清单，决定这个工具库以什么入口、什么子路径被其他包导入。

- `type: module` 与 `main`/`types` 把包按 ESM 从 `lib/index.js` 加载（[packages/util/launch-environment/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/package.json#L13-L15)）
- `exports` 把根入口映射到 `lib/index.js`、`./invariant` 映射到 `lib/invariant.js`，并额外开放 `./src/*` 与 `./package.json` 两个子路径（[packages/util/launch-environment/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/util/launch-environment/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/package.json#L28-L32)）

### packages/util/launch-environment/src/index.ts

该包唯一的实现文件，构造并读取本次启动的环境快照，被凭证、提供方配置等需要区分变量来源的包直接导入。

- `SOURCE_ORDER` 常量把层级信任顺序固定为进程环境、项目 `.env`、home `.env`（[packages/util/launch-environment/src/index.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/index.ts#L19)）
- `lookupKey` 在 `win32` 上把变量名折成大写、其它平台保持原样，决定存取时的键（[packages/util/launch-environment/src/index.ts:60-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/index.ts#L60-L63)）
- `createLaunchEnvironmentSnapshot` 在构造时把每层的键值对拷进以 `lookupKey` 归一化的 Map，并按层记录来源文件路径，之后对源对象的修改不再影响快照（[packages/util/launch-environment/src/index.ts:78-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/index.ts#L78-L87)）
- `getFrom` 始终按 `SOURCE_ORDER` 遍历、跳过不在允许列表中的层，返回首个命中的值并附带其 `source` 与 `path`，都未命中返回 `undefined`（[packages/util/launch-environment/src/index.ts:88-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/index.ts#L88-L98)）
- `get` 以全部层为允许列表委托给 `getFrom`（[packages/util/launch-environment/src/index.ts:100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/index.ts#L100)）
- 常量把上下文槽位名固定为 `launchEnvironment`（[packages/util/launch-environment/src/index.ts:106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/index.ts#L106)）
- `launchEnvironmentOf` 从 `ctx.get` 取启动器写入的快照，取不到时以 `process.env` 为唯一层现场构造一个快照（[packages/util/launch-environment/src/index.ts:114-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/index.ts#L114-L117)）

### packages/util/launch-environment/src/invariant.ts

该包的 invariant 伴生插件，被 invariants 服务加载以登记包所有权。

- 导出 `name` 与 `inject`，把伴生插件命名为 `launch-environment-invariant` 并声明依赖 `invariants` 服务（[packages/util/launch-environment/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/invariant.ts#L13-L15)）
- 安装函数为空体，不注册任何运行期检查（[packages/util/launch-environment/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该安装函数并返回其 disposer（[packages/util/launch-environment/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/launch-environment/src/invariant.ts#L28-L29)）

### packages/util/launch-environment/tsconfig.json

该包的 TypeScript 编译配置，规定源目录、声明输出目录与工程引用。

- 无运行期机制
