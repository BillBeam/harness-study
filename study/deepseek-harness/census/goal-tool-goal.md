---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/goal/tool-goal
---

# packages/goal/tool-goal

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、41 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/goal/tool-goal/README.md

包 README，说明三个目标工具的用途、配置项、执行期权限规则与输出形状。

- 无运行期机制

### packages/goal/tool-goal/package.json

npm 清单，声明该工具包的入口与发布内容。

- `type: module` 与 `main`/`types` 指向 `lib/index.js`，决定运行期加载的模块（[packages/goal/tool-goal/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/package.json#L13-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个入口（[packages/goal/tool-goal/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/package.json#L16-L27)）
- `files` 白名单限定发布制品的文件集合（[packages/goal/tool-goal/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/package.json#L28-L32)）

### packages/goal/tool-goal/src/authority.ts

工具执行期的权限判定：定位当前回合窗口、认证调用代理，并区分"直接人类"与"目标轮次"两种授权。

- `reject` 把权限失败统一抛成带默认码 `GOAL_TOOL_AUTHORITY_REQUIRED` 的 `HarnessError`（[packages/goal/tool-goal/src/authority.ts:25-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/authority.ts#L25-L27)）
- `openTurn` 从会话日志末尾往回扫，先遇到 `turn/end` 即以 `GOAL_TOOL_DRIVER_REQUIRED` 拒绝，遇到 `turn/start` 则返回其后的事件窗口（[packages/goal/tool-goal/src/authority.ts:30-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/authority.ts#L30-L42)）
- `goalToolExecution` 要求存在调用代理，且注册表实例严格相同、状态为 running、当前 initiator 就是它，否则拒绝执行（[packages/goal/tool-goal/src/authority.ts:50-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/authority.ts#L50-L63)）
- `hasDirectHumanInput` 要求代理是运行时根代理，且当前回合窗口内存在 `source.kind === 'user'` 的用户消息（[packages/goal/tool-goal/src/authority.ts:70-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/authority.ts#L70-L74)）
- `isMatchingGoalRound` 要求回合窗口里有一条目标来源消息，其 goalId、revision 与 round 与当前目标的 `roundsStarted` 完全一致（[packages/goal/tool-goal/src/authority.ts:77-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/authority.ts#L77-L83)）
- `requireDirectHuman` 无直接人类输入时抛出权限拒绝（[packages/goal/tool-goal/src/authority.ts:90-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/authority.ts#L90-L93)）
- `completionAuthority` 优先返回 direct-human，否则读当前目标并在回合匹配时返回 goal-round 授权，两者都不成立则拒绝（[packages/goal/tool-goal/src/authority.ts:101-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/authority.ts#L101-L108)）

### packages/goal/tool-goal/src/index.ts

插件入口：注册 `get_goal`/`create_goal`/`update_goal` 三个模型工具、它们的输出模式，以及一段带阈值插值的系统提示段落。

- 导出插件名并注入 `agents`、`goals`、`tools`、`systemPrompt`（[packages/goal/tool-goal/src/index.ts:22-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L22-L23)）
- `Config` 模式声明 `blockedAfterConsecutiveRounds`，整数、下限 1、默认 3（[packages/goal/tool-goal/src/index.ts:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L32-L34)）
- `UPDATE_ACTIONS` 限定 update_goal 参数枚举为 edit/pause/resume/complete/blocked（[packages/goal/tool-goal/src/index.ts:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L43)）
- `CREATE_DESCRIPTION` 与 `GET_DESCRIPTION` 是模型看到的工具描述文本，并声明创建会拒绝非人类与子代理授权（[packages/goal/tool-goal/src/index.ts:45-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L45-L54)）
- `GOAL_VALUE_SCHEMA` 以 oneOf 固定工具输出为 `{goal:null}` 或含 id/revision/objective/phase/roundsStarted/maxGoalRounds/可选 blockedReason 加 activation 的对象（[packages/goal/tool-goal/src/index.ts:72-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L72-L110)）
- `guidance` 生成模型可见的目标策略文本，并把配置阈值插进"至少连续多少轮才可自报 blocked"这句（[packages/goal/tool-goal/src/index.ts:113-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L113-L123)）
- `resolveConfig` 在 apply 里再校验一次阈值，非正安全整数直接抛 TypeError（[packages/goal/tool-goal/src/index.ts:126-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L126-L132)）
- `hasText`/`hasRoundCap` 把空字符串与 0 当作未提供，使严格模式下的填充值等同省略（[packages/goal/tool-goal/src/index.ts:135-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L135-L142)）
- `goalRef` 校验模型给出的 goal_id 非空且已 trim、revision 为正安全整数，否则抛 `GOAL_TOOL_INVALID_UPDATE`（[packages/goal/tool-goal/src/index.ts:145-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L145-L154)）
- `goalValue` 把服务视图裁剪成固定字段的紧凑结果，无目标时为 `{goal:null}`（[packages/goal/tool-goal/src/index.ts:157-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L157-L173)）
- `GOAL_OUTPUT` 把结果渲染成单个 `JSON.stringify` 文本块交给模型（[packages/goal/tool-goal/src/index.ts:176-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L176-L179)）
- `present` 为三个工具生成 generic 卡片视图，读操作与变更操作分别用 read/other 类别（[packages/goal/tool-goal/src/index.ts:182-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L182-L184)）
- apply 注册名为 `tool:goal`、按 `FIRST_PARTY_SECTION_ORDER.TOOL_GOAL` 排序的系统提示段落（[packages/goal/tool-goal/src/index.ts:189-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L189-L193)）
- `get_goal` 无参数，执行时先过权限认证再返回当前目标的紧凑视图（[packages/goal/tool-goal/src/index.ts:195-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L195-L205)）
- `create_goal` 声明 objective 必填、max_goal_rounds 可选，执行时要求直接人类授权后调用 `ctx.goals.create`（[packages/goal/tool-goal/src/index.ts:207-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L207-L232)）
- `update_goal` 的描述与参数模式规定 goal_id/revision/action 必填，并说明哪些动作需要直接人类请求（[packages/goal/tool-goal/src/index.ts:236-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L236-L255)）
- action 为 edit 时要求直接人类授权、拒绝携带 blocked_reason，并把替换字段交给 `ctx.goals.edit`（[packages/goal/tool-goal/src/index.ts:264-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L264-L271)）
- action 为 pause/resume 时要求直接人类授权，并拒绝 objective、max_goal_rounds、blocked_reason 任一非空（[packages/goal/tool-goal/src/index.ts:272-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L272-L284)）
- complete/blocked 走 `completionAuthority`，接受直接人类或当前目标轮次两种授权（[packages/goal/tool-goal/src/index.ts:285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L285)）
- complete/blocked 拒绝携带 objective 或 max_goal_rounds；complete 拒绝 blocked_reason；blocked 缺少非空 blocked_reason 时拒绝（[packages/goal/tool-goal/src/index.ts:286-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L286-L298)）
- 目标轮次授权下的 blocked 在 `roundsStarted` 小于配置阈值时以 `GOAL_TOOL_BLOCK_THRESHOLD` 拒绝（[packages/goal/tool-goal/src/index.ts:299-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L299-L306)）
- 通过后调用 `ctx.goals.complete` 或以固定代码 `model-reported` 加模型给出的说明调用 `ctx.goals.block`（[packages/goal/tool-goal/src/index.ts:307-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L307-L312)）
- 仅在目标轮次授权下 `exec.deferContext` 注入一条收尾指令用户消息，来源标为 `{kind:'plugin', plugin:'tool-goal', form:'notice'}` 并带受限摘要（[packages/goal/tool-goal/src/index.ts:313-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L313-L325)）
- `presentCall` 按 action 生成卡片标题，并按 blocked_reason、objective、max_goal_rounds、goal_id 的优先级选一项作为原始输入展示（[packages/goal/tool-goal/src/index.ts:328-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/index.ts#L328-L336)）

### packages/goal/tool-goal/src/wrapup.ts

纯渲染函数，生成自动轮次终局更新后注入模型的收尾指令。

- `GROUNDING` 是两个分支共用的文本段，要求只报告本会话既有轮次与工具结果能支撑的内容（[packages/goal/tool-goal/src/wrapup.ts:5-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/wrapup.ts#L5-L7)）
- `renderWrapupContext` 无 blockedReason 时输出 `<goal_complete>` 块，要求模型立即写面向用户的收尾消息、说明结果与验证方式、并不再调用工具（[packages/goal/tool-goal/src/wrapup.ts:17-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/wrapup.ts#L17-L28)）
- 有 blockedReason 时输出 `<goal_blocked>` 块，回显 JSON 引号化的阻塞说明并要求模型讲清已完成部分与所需输入（[packages/goal/tool-goal/src/wrapup.ts:29-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/wrapup.ts#L29-L40)）

### packages/goal/tool-goal/src/invariant.ts

包自有的不变量伴生插件，安装器为空并写明原因。

- 安装器为空函数，不注册任何运行期检查（[packages/goal/tool-goal/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/invariant.ts#L17-L21)）
- `apply` 仍以包名向 `invariants` 注册该空安装器，占住包的不变量所有权并返回 disposer（[packages/goal/tool-goal/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/goal/tool-goal/src/invariant.ts#L28-L29)）

### packages/goal/tool-goal/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制
