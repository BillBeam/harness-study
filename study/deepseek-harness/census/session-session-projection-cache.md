---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-projection-cache
---

# packages/session/session-projection-cache

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、34 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-projection-cache/README.md

本包的说明文档，介绍持久化检查点的配置字段、写入时机与读取语义。

- 无运行期机制

### packages/session/session-projection-cache/package.json

本包的 npm 清单，决定包名、入口与可被外部解析的子路径。

- `main`/`types` 指定默认运行入口与类型入口（[packages/session/session-projection-cache/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/package.json#L14-L15)）
- `exports` 只开放根、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/session/session-projection-cache/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/package.json#L16-L27)）
- `files` 限定发布产物仅含 lib 下的入口、伴生插件与类型声明（[packages/session/session-projection-cache/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/package.json#L28-L32)）
- 依赖声明把 schemastery 与 zod 作为运行时依赖，投影注册表、会话、存储域等作为 peer 依赖（[packages/session/session-projection-cache/package.json:34-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/package.json#L34-L44)）

### packages/session/session-projection-cache/src/index.ts

持久化投影缓存服务的实现与默认导出，向上下文安装 `ctx.sessionProjectionCache`，写侧订阅会话事件、读侧为列表与冷读提供缓存值。

- 通过声明合并把 `sessionProjectionCache` 挂到 `Context` 类型上（[packages/session/session-projection-cache/src/index.ts:35-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L35-L39)）
- 配置模式要求 `writeEveryEvents` 与 `writeIntervalMs` 均为不小于 1 的自然数且必填，无默认值（[packages/session/session-projection-cache/src/index.ts:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L55-L58)）
- 声明注入 `storageDomain`、`sessionProjections`、`sessions`（[packages/session/session-projection-cache/src/index.ts:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L78)）
- `Service.init` 打开 `session_projcache` 域、把域关闭登记为 effect、取出 `sessions` 表并安装写路径监听（[packages/session/session-projection-cache/src/index.ts:89-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L89-L95)）
- `recordFor` 从域内存表同步取记录，并只接受身份字段与调用方持有的会话头相符的记录（[packages/session/session-projection-cache/src/index.ts:109-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L109-L113)）
- `cachedSnapshot` 把记录行交给注册表的 `viewCheckpoint` 产出值，无可用键时返回 undefined（[packages/session/session-projection-cache/src/index.ts:128-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L128-L137)）
- `cachedSnapshot` 以所有已服务行水位的最小值作为该次读取的统一 `asOfSeq`（[packages/session/session-projection-cache/src/index.ts:138-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L138-L141)）
- `hydratePrepared` 无匹配记录时以空检查点走 `hydrate`；有记录但 `hydrate` 抛错时回退到空检查点重试，不写检查点（[packages/session/session-projection-cache/src/index.ts:154-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L154-L170)）
- `write` 先取注册表检查点、清空脏计数与定时器，再在会话仍在存储中时先 `flush` 会话日志、最后落缓存记录（[packages/session/session-projection-cache/src/index.ts:181-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L181-L193)）
- `coldSnapshot` 以身份校验后的行为种子调用 `restore` 折叠完整日志（[packages/session/session-projection-cache/src/index.ts:207-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L207-L208)）
- `coldSnapshot` 以“发后不理”的方式回写刷新后的检查点，失败只记 warn 日志（[packages/session/session-projection-cache/src/index.ts:209-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L209-L214)）
- 监听 `session/event`：`turn/end` 立即触发一次容错写（[packages/session/session-projection-cache/src/index.ts:224-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L224-L228)）
- 其余事件累加每会话脏计数，达到 `writeEveryEvents` 即写，否则在首个脏事件处按 `writeIntervalMs` 装一次定时器（[packages/session/session-projection-cache/src/index.ts:229-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L229-L239)）
- 监听 `session/created`，会话创建即触发一次容错写（[packages/session/session-projection-cache/src/index.ts:241-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L241-L248)）
- 监听 `session/disposed`，先触发最终写，再清干净该会话的脏状态并从表中删除（[packages/session/session-projection-cache/src/index.ts:250-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L250-L258)）
- 以 `ctx.effect` 登记卸载动作：清除所有待触发定时器并清空脏表（[packages/session/session-projection-cache/src/index.ts:260-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L260-L270)）
- `flushSoft` 捕获写入异常并只记 warn 日志，不向调用方抛出（[packages/session/session-projection-cache/src/index.ts:278-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L278-L284)）
- `markClean` 归零脏计数并取消已装的定时器（[packages/session/session-projection-cache/src/index.ts:286-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L286-L295)）
- `put` 先用 `snapshotJsonValue` 做无损 JSON 脱钩，不可无损序列化即抛 TypeError，然后整条替换该会话记录（[packages/session/session-projection-cache/src/index.ts:297-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L297-L304)）
- `requireTable` 在表尚未装配时抛出未初始化错误（[packages/session/session-projection-cache/src/index.ts:306-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L306-L310)）
- `identityOf` 把会话头投影为 `createdAt` 加可选 `cwd` 的身份，`identityMatches` 要求两者都相等（[packages/session/session-projection-cache/src/index.ts:313-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L313-L321)）
- 默认导出缓存服务类，供 Loader 作为服务插件装载（[packages/session/session-projection-cache/src/index.ts:323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/index.ts#L323)）

### packages/session/session-projection-cache/src/spec.ts

存储域声明与记录 schema 模块，被 `index.ts` 用来打开域、约束落盘记录形态。

- `checkpointRow` 要求 `ver` 为非负整数、`seq` 不小于 -1、`val` 为无损 JSON，在持久化边界上做校验（[packages/session/session-projection-cache/src/spec.ts:25-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/spec.ts#L25-L29)）
- `checkpointIdentity` 把记录绑定到 `createdAt` 与可选 `cwd` 两个不可变头字段（[packages/session/session-projection-cache/src/spec.ts:40-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/spec.ts#L40-L43)）
- `checkpointRecord` 规定一条记录由身份加按投影键索引的行组成（[packages/session/session-projection-cache/src/spec.ts:54-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/spec.ts#L54-L57)）
- `projectionCacheDomainSpec` 固定域名 `session_projcache`、版本 4、`per-record` 布局与以 SessionId 为键的 `sessions` 表（[packages/session/session-projection-cache/src/spec.ts:69-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/spec.ts#L69-L74)）

### packages/session/session-projection-cache/src/invariant.ts

本包的不变量伴生插件模块，由不变量注册表在装载时调用。

- 以空安装器登记包名，占位说明本包无可观测的连续不变量关系（[packages/session/session-projection-cache/src/invariant.ts:17-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/invariant.ts#L17-L26)）
- `apply` 向 `ctx.invariants` 注册该包并返回其 disposer（[packages/session/session-projection-cache/src/invariant.ts:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-projection-cache/src/invariant.ts#L33-L34)）

### packages/session/session-projection-cache/tsconfig.json

本包的 TypeScript 编译配置，声明源目录、输出目录与工作区项目引用。

- 无运行期机制
