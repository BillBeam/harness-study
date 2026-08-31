---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/todo/tool-todo
---

# packages/todo/tool-todo

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、34 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/todo/tool-todo/README.md

该包的英文参考文档，介绍 `todo_write` 工具的配置项、调用语义、投影与不变量，面向使用者与维护者。

- 无运行期机制

### packages/todo/tool-todo/package.json

该包的 npm 清单，声明入口、导出子路径、发布文件与依赖关系。

- `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/todo/tool-todo/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/package.json#L14-L15)）
- `exports` 开放根入口、`./invariant`、`./client`（其 default 指向 `lib/types/client.js`）、`./src/*` 与 `./package.json` 五个子路径（[packages/todo/tool-todo/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/package.json#L16-L31)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 js/d.ts（[packages/todo/tool-todo/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/package.json#L32-L37)）

### packages/todo/tool-todo/src/client.ts

客户端命名空间入口，转发该包的纯类型出口。

- 无运行期机制

### packages/todo/tool-todo/src/index.ts

该包的插件入口，注册模型可见的 `todo_write` 工具，并在组合了会话投影注册表时注册 `todos` 投影单元。

- 以具名导出 `name` 与 `inject = ['tools']` 的函数插件形式声明，插件仅在 `tools` 服务就绪后装载（[packages/todo/tool-todo/src/index.ts:22-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L22-L23)）
- 以运行期常量集合固定三个合法状态，同时用于 schema 枚举（[packages/todo/tool-todo/src/index.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L26)）
- 配置 schema 把 `allowParallelInProgress` 声明为必填布尔，缺失或类型不符在装载时被拒（[packages/todo/tool-todo/src/index.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L41-L43)）
- 四段常量文本构成模型可见的工具描述：整表替换要求、并行活跃条款、单一活跃条款、完成与状态说明（[packages/todo/tool-todo/src/index.ts:45-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L45-L66)）
- `describe` 依据并行开关在两段活跃条款之间二选一拼出最终描述（[packages/todo/tool-todo/src/index.ts:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L74-L78)）
- `toTodoList` 对每项 trim 后为空即抛错（[packages/todo/tool-todo/src/index.ts:95-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L95-L99)）
- 同一次调用内内容重复即抛错，并把 trim 后的内容写入规范列表（[packages/todo/tool-todo/src/index.ts:100-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L100-L106)）
- 未开启并行且 `in_progress` 多于一项时抛错并报出实际数量（[packages/todo/tool-todo/src/index.ts:107-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L107-L109)）
- 用 zod 定义 `todos` 投影的传输载荷 schema，为整表数组或 null（[packages/todo/tool-todo/src/index.ts:114-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L114-L120)）
- 通过 `ctx.inject(['sessionProjections'])` 的子上下文注册 `todos` 投影，未组合该注册表的装配不受影响（[packages/todo/tool-todo/src/index.ts:135-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L135-L137)）
- 投影初值为 null，遇 `todo/write` 取整表、遇 `turn/start` 清空、其余事件返回原状态引用，并声明 wire 视图与 `stateVersion: 2`（[packages/todo/tool-todo/src/index.ts:138-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L138-L147)）
- 向 `ctx.tools` 注册名为 `todo_write` 的工具并挂上组合出的描述（[packages/todo/tool-todo/src/index.ts:149-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L149-L151)）
- 入参 schema 要求必填 `todos` 数组，条目为 `additionalProperties: false` 的对象且 `content` 必填、`status` 必填并限定枚举（[packages/todo/tool-todo/src/index.ts:152-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L152-L171)）
- 输出 schema 固定为 `todos` 列表加 `pending`/`inProgress`/`completed` 三个整数计数（[packages/todo/tool-todo/src/index.ts:172-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L172-L200)）
- `render` 把结果渲染成模型可见的一行计数文本（[packages/todo/tool-todo/src/index.ts:201-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L201-L204)）
- `execute` 先做值域校验，再在无归属 agent 会话时抛错而非静默无操作（[packages/todo/tool-todo/src/index.ts:206-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L206-L212)）
- 校验通过后向该 agent 的会话追加 `todo/write` 事件，并返回整表与三项计数（[packages/todo/tool-todo/src/index.ts:213-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L213-L222)）
- `presentCall` 给出调用卡片的类型、标题与原始入参（[packages/todo/tool-todo/src/index.ts:224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/index.ts#L224)）

### packages/todo/tool-todo/src/invariant.ts

该包的不变量伴生插件，校验落入耐久会话日志的整表 `todo/write` 快照。

- 以 `name` 与 `inject = ['invariants']` 声明伴生插件，须在不变量服务就绪后装载（[packages/todo/tool-todo/src/invariant.ts:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/invariant.ts#L11-L13)）
- `validateTodos` 拒绝非数组载荷、非对象条目、空或未 trim 的内容、重复内容与未知状态，且不检查活跃项数量（[packages/todo/tool-todo/src/invariant.ts:24-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/invariant.ts#L24-L39)）
- `advanceTrace` 按 `turn/start`/`turn/end` 翻转每会话的回合开合状态（[packages/todo/tool-todo/src/invariant.ts:48-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/invariant.ts#L48-L51)）
- `validateEvent` 只处理 `todo/write`，除内容校验外还拒绝落在任何已开回合之外的写入（[packages/todo/tool-todo/src/invariant.ts:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/invariant.ts#L54-L58)）
- `seedTrace` 单趟重放既有会话事件、逐条校验并返回尾部回合状态（[packages/todo/tool-todo/src/invariant.ts:61-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/invariant.ts#L61-L68)）
- 安装时对当前已有会话逐个播种，并在 `session/created` 上为新会话播种（[packages/todo/tool-todo/src/invariant.ts:84-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/invariant.ts#L84-L85)）
- 在 `internal/dispatch` 上拦截 `session/event` 派发，事件提交前先做校验（[packages/todo/tool-todo/src/invariant.ts:86-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/invariant.ts#L86-L90)）
- 在 `session/event` 上推进该会话的回合状态，并把安装器的注入声明为 `sessions`（[packages/todo/tool-todo/src/invariant.ts:91-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/invariant.ts#L91-L94)）
- `apply` 以包名向 `ctx.invariants` 注册安装器并返回其 disposer（[packages/todo/tool-todo/src/invariant.ts:102-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/todo/tool-todo/src/invariant.ts#L102-L103)）

### packages/todo/tool-todo/src/types.ts

该包的纯类型出口，声明 `TodoItem` 并通过声明合并把 `todo/write` 事件与 `todos` 投影键并入全局映射。

- 无运行期机制

### packages/todo/tool-todo/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、输出目录与工程引用。

- 无运行期机制
