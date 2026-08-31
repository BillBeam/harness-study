---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-stats
---

# packages/session/session-stats

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、26 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-stats/README.md

session-stats 包的说明文档，面向挂载该投影单元的组合方与维护者，描述字段含义、组合方式与折叠规则。

- 无运行期机制

### packages/session/session-stats/package.json

包清单，声明该 npm 包的模块类型、入口、导出子路径与发布文件集。

- 声明 `"type": "module"`，`main` 指向 `lib/index.js`、`types` 指向 `lib/types/index.d.ts`（[packages/session/session-stats/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/package.json#L13-L15)）
- `exports` 暴露 `.`、`./invariant`、`./types`、`./client` 四个入口，外加 `./src/*` 源码直读与 `./package.json`（[packages/session/session-stats/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/package.json#L16-L35)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`（[packages/session/session-stats/package.json:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/package.json#L36-L41)）

### packages/session/session-stats/src/client.ts

客户端命名空间入口，把 `./types.ts` 的类型原样再导出给客户端代码。

- 无运行期机制

### packages/session/session-stats/src/index.ts

包的插件入口，被组合到挂载了投影注册表的装配中，负责注册 `sessionStats` 单元。

- `inject = ['sessionProjections']` 使该插件在没有投影注册表时保持 fiber 挂起，不注册任何键（[packages/session/session-stats/src/index.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/index.ts#L20)）
- `apply` 把 `sessionStatsProjectionDefinition` 注册进 `ctx.sessionProjections`，注册作为本 fiber 上的 effect，卸载插件即移除该键（[packages/session/session-stats/src/index.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/index.ts#L27-L29)）

### packages/session/session-stats/src/invariant.ts

包自带的不变量伴生插件，向不变量服务登记包名。

- `inject = ['invariants']` 要求不变量服务先就绪，伴生插件才能启动（[packages/session/session-stats/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/invariant.ts#L15)）
- `apply` 以空安装器向 `ctx.invariants` 注册包名并返回注册的 disposer，运行期不做任何检查（[packages/session/session-stats/src/invariant.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/invariant.ts#L26)、[packages/session/session-stats/src/invariant.ts:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/invariant.ts#L33-L34)）

### packages/session/session-stats/src/projection.ts

`sessionStats` 投影单元的定义体，由 index.ts 注册进投影注册表，对会话事件做纯折叠并产出对外视图。

- `isTokenDelta` 判定一个流式分片是否算作非空首 token：文本/推理增量看 `text` 非空，工具调用增量看 `argumentsDelta` 非空或带 `name`，其余类型一律为否（[packages/session/session-stats/src/projection.ts:33-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L33-L43)）
- `sessionStatsSchema` 以 `.strict()` 限定对外视图的八个总量字段及其非负整数/非负数约束（[packages/session/session-stats/src/projection.ts:88-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L88-L97)）
- `sessionStatsStateSchema` 在视图 schema 上扩展 `lastTurn`、`openStep`、`pendingCalls`，作为持久化缓存行的校验入口（[packages/session/session-stats/src/projection.ts:105-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L105-L114)）
- `usageOutputTokens` 只接受对象上有限且非负的 `outputTokens` 数值，其余情况返回 null（[packages/session/session-stats/src/projection.ts:122-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L122-L126)）
- 单元以 `key: 'sessionStats'`、`stateVersion: 1` 注册，`init` 把八个总量置 0、`lastTurn` 置 null、`openStep` 置 null、`pendingCalls` 置空对象（[packages/session/session-stats/src/projection.ts:129-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L129-L145)）
- `step/start` 记录当前 step 的 turn、step、起始时间，并把 `firstTokenTime` 置空（[packages/session/session-stats/src/projection.ts:149-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L149-L153)）
- `assistant/chunk` 只在 turn/step 与打开的 step 一致、尚无首 token 且分片算作 token 增量时，记录首 token 时间（[packages/session/session-stats/src/projection.ts:154-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L154-L159)）
- `assistant/message` 累加 `llmMs`（事件时间减 step 起始时间，下限 0）并关闭 `openStep`（[packages/session/session-stats/src/projection.ts:160-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L160-L169)）
- 同一分支在存在首 token 时累加 `ttftMs`/`ttftSteps`，并且仅当用量报出有效 `outputTokens` 时才累加 `decodeMs`/`decodeTokens`（[packages/session/session-stats/src/projection.ts:170-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L170-L179)）
- `tool/call` 以 callId 为键把派发时间写入 `pendingCalls`（[packages/session/session-stats/src/projection.ts:181-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L181-L182)）
- `tool/result` 用 `Object.hasOwn` 取派发时间，未匹配则原样返回状态；匹配则累加 `toolMs` 并从 `pendingCalls` 中剔除该 callId（[packages/session/session-stats/src/projection.ts:183-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L183-L195)）
- `step/end` 使 `steps` 加一，`turns` 仅在本事件 turn 与 `lastTurn` 不同时加一，同时更新 `lastTurn` 并清空 `openStep`（[packages/session/session-stats/src/projection.ts:196-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L196-L203)）
- `turn/end` 在 `pendingCalls` 非空时清空它，为空时返回同一状态引用（[packages/session/session-stats/src/projection.ts:204-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L204-L208)）
- 其余事件类型走 default 返回同一状态引用，注册表的 `Object.is` 比较据此不发变更（[packages/session/session-stats/src/projection.ts:209-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L209-L210)）
- `wire.view` 从状态中挑出八个总量作为对外视图，边界字段不出现在 wire 上（[packages/session/session-stats/src/projection.ts:213-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-stats/src/projection.ts#L213-L225)）

### packages/session/session-stats/src/types.ts

纯类型文件，声明 `SessionStatsProjection` 字段并把 `sessionStats` 键并入投影映射表。

- 无运行期机制

### packages/session/session-stats/tsconfig.json

包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制
