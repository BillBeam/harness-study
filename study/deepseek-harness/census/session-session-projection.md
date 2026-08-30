---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-projection
---

# packages/session/session-projection

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、34 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-projection/README.md

本包的说明文档，介绍投影单元契约、注册与读取方式以及持久化检查点的配合关系。

- 无运行期机制

### packages/session/session-projection/package.json

本包的 npm 清单，决定包名、入口与可被外部解析的子路径。

- `main`/`types` 指定默认运行入口与类型入口（[packages/session/session-projection/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/package.json#L14-L15)）
- `exports` 只开放根、`./invariant`、`./types`、`./src/*` 与 `./package.json` 五个子路径，其余路径无法从外部导入（[packages/session/session-projection/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/package.json#L16-L31)）
- `files` 限定发布产物仅含 lib 下的入口、伴生插件与类型文件（[packages/session/session-projection/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/package.json#L32-L37)）
- 依赖声明把 zod 作为运行时依赖、cordis 与 session 等作为 peer 依赖（[packages/session/session-projection/package.json:39-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/package.json#L39-L51)）

### packages/session/session-projection/src/index.ts

投影注册表服务的实现与默认导出，向 cordis 上下文安装 `ctx.sessionProjections`，被各领域插件注册单元、被客户端载体读取快照。

- 通过声明合并把 `sessionProjections` 挂到 `Context` 类型上（[packages/session/session-projection/src/index.ts:24-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L24-L28)）
- `ProjectionDefinition` 规定单元必须提供 key、状态 schema、`init`、同步 `apply`、可选 `wire`（含 `viewSchema` 与 `view`）与 `stateVersion`（[packages/session/session-projection/src/index.ts:42-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L42-L83)）
- 构造函数监听 `session/created`，对 `seq === 0` 的新会话为每个已注册单元预建初始 cell，水位标为 -1（[packages/session/session-projection/src/index.ts:189-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L189-L200)）
- 构造函数监听 `session/event`，每条已提交事件都触发一次全量驱动（[packages/session/session-projection/src/index.ts:201-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L201-L203)）
- `register` 把定义擦除成统一内部形态，并在注册前拒绝非非负安全整数的 `stateVersion`（[packages/session/session-projection/src/index.ts:234-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L234-L253)）
- `register` 以 `ctx.effect` 登记：同 key 首次注册建表项，重复注册时 `stateVersion` 不一致直接抛错、一致则引用计数加一（[packages/session/session-projection/src/index.ts:254-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L254-L264)）
- disposer 递减引用计数，归零才从表中删除该 key（连同其 cells）（[packages/session/session-projection/src/index.ts:265-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L265-L273)）
- `onChanged` 以 `ctx.effect` 把监听器加入集合并返回对应的移除 disposer（[packages/session/session-projection/src/index.ts:282-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L282-L290)）
- `stateOf` 先物化全部单元 cell，再返回指定 key 的宿主状态（未注册返回 undefined，不产出 wire 视图）（[packages/session/session-projection/src/index.ts:300-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L300-L308)）
- `snapshot` 物化所有 cell 后只输出带 wire 的（可按 keys 过滤）单元视图，并以 `session.seq - 1` 作统一水位（[packages/session/session-projection/src/index.ts:319-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L319-L333)）
- `cachedSnapshot` 不折叠历史，只读已存在的 cell，水位取各已服务 cell 观测水位的最小值；无任何 wire cell 时返回 undefined（[packages/session/session-projection/src/index.ts:343-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L343-L361)）
- `checkpoint` 对每个已注册单元产出 `{ver, seq, val}` 行，`val` 用 `structuredClone` 与活 cell 脱钩（[packages/session/session-projection/src/index.ts:377-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L377-L388)）
- `restoreFloor` 对版本匹配的行取 `seq + 1`、缺失或版本不符的取 0，然后在全体最小值上再减一作为尾读起点（下限 0）（[packages/session/session-projection/src/index.ts:406-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L406-L416)）
- `viewCheckpoint` 零 I/O 地只服务版本匹配的行；`stateSchema.parse` 失败的行被跳过，其 key 缺席（[packages/session/session-projection/src/index.ts:429-450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L429-L450)）
- `restore` 判定行可用需同时满足版本相符、`seq >= baseSeq - 1` 且 `seq <= endSeq`；不可用且 `baseSeq > 0` 时抛错要求调用方从 seq 0 重读（[packages/session/session-projection/src/index.ts:485-497](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L485-L497)）
- `restore` 从可用行的状态（经 schema 解析）或 `init` 起，按 seq 逐条前滚，遇到缺口即抛错，最后产出视图快照与刷新后的检查点行（[packages/session/session-projection/src/index.ts:498-515](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L498-L515)）
- `hydrate` 先检查是否所有单元 cell 都已在目标水位，是则直接出视图、不重折叠（[packages/session/session-projection/src/index.ts:528-551](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L528-L551)）
- `hydrate` 否则调用 `restore`，并把结果装回各单元 cell，但不覆盖水位更高的现有 cell（[packages/session/session-projection/src/index.ts:552-563](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L552-L563)）
- `buildCell` 从 `init` 起折叠给定事件，水位取最后事件 seq（空则 -1）（[packages/session/session-projection/src/index.ts:571-580](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L571-L580)）
- `cellFor` 缺 cell 时按会话内存日志惰性全折叠建立，已有则推进到 `session.seq - 1`（[packages/session/session-projection/src/index.ts:582-592](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L582-L592)）
- `advanceCell` 逐 seq 前滚，事件缺失或 seq 不匹配即抛错（[packages/session/session-projection/src/index.ts:594-611](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L594-L611)）
- `drive` 跳过水位已达该事件的单元，中途新建的 cell 先折叠该事件之前的日志前缀，再统一走一次 `apply`（[packages/session/session-projection/src/index.ts:613-629](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L613-L629)）
- `drive` 用 `Object.is` 判定状态引用是否变化，仅在变化、单元有 wire 且存在监听器时才产出视图并逐个通知（带 key、值与致因 seq）（[packages/session/session-projection/src/index.ts:630-636](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L630-L636)）
- `viewCell` 对无 wire 的单元抛错，否则把 `view` 输出交给 `viewSchema.parse` 后返回（[packages/session/session-projection/src/index.ts:639-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L639-L644)）
- 默认导出注册表服务类，供 Loader 作为服务插件装载（[packages/session/session-projection/src/index.ts:647](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/index.ts#L647)）

### packages/session/session-projection/src/invariant.ts

本包的不变量伴生插件模块，由不变量注册表在装载时调用。

- 以空安装器登记包名，占位说明本包无可观测的连续不变量关系（[packages/session/session-projection/src/invariant.ts:17-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/invariant.ts#L17-L29)）
- `apply` 向 `ctx.invariants` 注册该包并返回其 disposer（[packages/session/session-projection/src/invariant.ts:36-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection/src/invariant.ts#L36-L37)）

### packages/session/session-projection/src/types.ts

纯类型出口，声明两张可合并扩展的投影类型表供各领域包做声明合并。

- 无运行期机制

### packages/session/session-projection/tsconfig.json

本包的 TypeScript 编译配置，声明源目录、输出目录与工作区项目引用。

- 无运行期机制
