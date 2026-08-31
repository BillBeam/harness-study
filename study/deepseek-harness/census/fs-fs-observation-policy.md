---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/fs/fs-observation-policy
---

# packages/fs/fs-observation-policy

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、22 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/fs/fs-observation-policy/README.md

该包的说明文档，描述读后写策略插件的组合方式、拒绝码与模型可见文案。

- 无运行期机制

### packages/fs/fs-observation-policy/package.json

该包的 npm 清单，声明入口与发布内容。

- `exports` 把 `.` 映射到 `./lib/index.js`、`./invariant` 映射到 `./lib/invariant.js`，并开放 `./src/*` 与 `./package.json` 子路径，决定加载器解析到哪个模块（[packages/fs/fs-observation-policy/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/fs/fs-observation-policy/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/package.json#L28-L32)）
- `main`/`types` 为不识别 `exports` 的解析器指定 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/fs/fs-observation-policy/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/package.json#L14-L15)）

### packages/fs/fs-observation-policy/src/index.ts

插件主入口，注册三个 `fs/*` 监听器，用一张弱引用表记录会话已观察的文件状态，并据此给写入与编辑派发守卫。

- 观察状态存在一张以 owner 对象为弱键、以 `targetKey` 为内层键的两级映射中，owner 被回收时其状态一并释放（[packages/fs/fs-observation-policy/src/index.ts:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L28)）
- owner 由事件携带的不透明 actor 上的 `agent?.session` 派生，取不到时返回 `undefined`（[packages/fs/fs-observation-policy/src/index.ts:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L36-L41)）
- `set` 在 owner 首次记录时惰性建立内层 Map 再写入观察结果（[packages/fs/fs-observation-policy/src/index.ts:47-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L47-L54)）
- `clear()` 用新的 WeakMap 整体替换已记录状态（[packages/fs/fs-observation-policy/src/index.ts:57-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L57-L59)）
- `writeIntent` 在已记录 `present` 时返回 `{ kind: 'replaceIfVersion', version }`，未见过或已确认缺失时返回 `{ kind: 'createIfAbsent' }`（[packages/fs/fs-observation-policy/src/index.ts:65-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L65-L71)）
- `editIntent` 在无 owner 或无先前观察时抛出 `FS_NOT_OBSERVED`，文案为 `edit requires reading "<path>" first`（[packages/fs/fs-observation-policy/src/index.ts:78-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L78-L83)）
- `editIntent` 对已记录为 `absent` 的目标抛出 `FS_NOT_FOUND`，否则以已观察版本作为比较交换基准返回（[packages/fs/fs-observation-policy/src/index.ts:84-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L84-L87)）
- `observe` 仅在能派生出 owner 时写入观察记录，否则丢弃（[packages/fs/fs-observation-policy/src/index.ts:91-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L91-L94)）
- 导出 `name = 'fs-observation-policy'` 作为加载器诊断使用的插件名（[packages/fs/fs-observation-policy/src/index.ts:98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L98)）
- `apply` 每次调用新建一个门控实例，并注册一个在释放时清空全部记录状态的 effect（[packages/fs/fs-observation-policy/src/index.ts:107-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L107-L114)）
- 监听 `fs/write-intent` 并直接返回决策、不调用 `next()`，抛出经 `Promise.resolve().then` 转为拒绝而不同步逃逸（[packages/fs/fs-observation-policy/src/index.ts:119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L119)）
- 监听 `fs/edit-intent` 并同样独占该决策槽位、不调用 `next()`（[packages/fs/fs-observation-policy/src/index.ts:122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L122)）
- 监听 `fs/observed`，以同步、无返回值的方式把 present/absent 观察写入门控（[packages/fs/fs-observation-policy/src/index.ts:127-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L127-L129)）

### packages/fs/fs-observation-policy/src/invariant.ts

该包的不变量伴生插件，向 `ctx.invariants` 登记包名。

- 声明 `inject = ['invariants']`，在注册前要求该服务就位（[packages/fs/fs-observation-policy/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/invariant.ts#L15)）
- 安装器为空函数，即不注册任何运行期检查（[packages/fs/fs-observation-policy/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其 disposer（[packages/fs/fs-observation-policy/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/invariant.ts#L28-L29)）

### packages/fs/fs-observation-policy/src/types.ts

只含类型声明的文件，定义从不透明 actor 中窄化出观察状态归属者所需的结构。

- 无运行期机制

### packages/fs/fs-observation-policy/tsconfig.json

该包的 TypeScript 编译配置，指定 rootDir/outDir 与工程引用。

- 无运行期机制
