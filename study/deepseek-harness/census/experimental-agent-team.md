---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/experimental/agent-team
---

# packages/experimental/agent-team

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 19 个文件、166 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/experimental/agent-team/README.md

包 README，介绍 Agent Teams 服务的名册、耐久信箱、共享任务板，以及配置项默认值与源码分布。

- 无运行期机制

### packages/experimental/agent-team/package.json

包清单，声明该包的入口映射、发布内容与依赖关系。

- `private: true` 把该包排除在发布产物之外（[packages/experimental/agent-team/package.json:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/package.json#L5)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/experimental/agent-team/package.json:12-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/package.json#L12-L13)）
- `exports` 把 `.`、`./invariant`、`./client`、`./types`、`./typert`、`./remote`、`./src/*` 与 `./package.json` 分别映射到具体产物路径，`./client` 与 `./types` 直接指向 `lib/types/` 下的产物（[packages/experimental/agent-team/package.json:14-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/package.json#L14-L41)）
- `files` 限定随包分发的文件为两个运行期 bundle、Typert Host/Remote 产物与 `lib/types` 下的 js/d.ts（[packages/experimental/agent-team/package.json:42-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/package.json#L42-L51)）
- `dependencies` 只含 schemastery 与 zod，其余 harness 包与 cordis 都放在 `peerDependencies`（[packages/experimental/agent-team/package.json:53-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/package.json#L53-L67)）

### packages/experimental/agent-team/src/activity.ts

维护按 Team 分组的一次性变更等待者，被服务的 `waitForChange` 与提交/状态通知使用。

- `wait` 要求 `timeoutMs` 是 10000 至 3600000 的安全整数，否则抛 `TEAM_INVALID_TIMEOUT`（[packages/experimental/agent-team/src/activity.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L23-L25)）
- 进入等待前先检查调用方 signal，已中止直接抛出（[packages/experimental/agent-team/src/activity.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L26)）
- 已关闭时立即返回 `timedOut: false` 而不挂起（[packages/experimental/agent-team/src/activity.ts:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L27)）
- 按 `TeamId` 建立等待者集合，并用 `setTimeout` 在超时后以 `false` 结算（[packages/experimental/agent-team/src/activity.ts:28-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L28-L59)）
- `finish` 保证每个等待者只结算一次，并清除定时器、移除 abort 监听、从集合中删除自身，集合空时删除该 Team 条目（[packages/experimental/agent-team/src/activity.ts:35-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L35-L44)）
- 中止时若 `signal.reason` 是 Error 则原样 reject，否则包成 `TEAM_WAIT_ABORTED`（[packages/experimental/agent-team/src/activity.ts:45-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L45-L52)）
- 注册监听后再补查一次 `signal.aborted`，覆盖预检查与注册之间的同步中止（[packages/experimental/agent-team/src/activity.ts:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L61-L63)）
- 返回值只有 `timedOut`，取自是否被通知唤醒（[packages/experimental/agent-team/src/activity.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L65)）
- `notify` 一次性取走并删除该 Team 的整组等待者后逐个唤醒（[packages/experimental/agent-team/src/activity.ts:72-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L72-L77)）
- `close` 关闭后续准入并唤醒、清空全部等待者（[packages/experimental/agent-team/src/activity.ts:80-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/activity.ts#L80-L86)）

### packages/experimental/agent-team/src/client.ts

浏览器编译面可用的类型重导出入口，对应 `./client` 导出条目。

- 无运行期机制

### packages/experimental/agent-team/src/error.ts

Team 域的错误类型与任意抛出值的文本化，被本包各处的失败路径使用。

- `TeamError` 继承 `HarnessError` 并带稳定 `code`，`name` 固定为 `TeamError`（[packages/experimental/agent-team/src/error.ts:7-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/error.ts#L7-L12)）
- `errorMessage` 对 Error 取 `message`、对字符串原样返回、其余用 `inspect` 以单行且 depth 4 渲染（[packages/experimental/agent-team/src/error.ts:19-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/error.ts#L19-L23)）

### packages/experimental/agent-team/src/fold.ts

Team 域四类会话事件的严格解码与重放折叠，被 journal 的状态读取、服务导出的 `foldTeam` 与 invariant companion 使用。

- 任务 id 的 `task-<n>` 后缀必须是安全整数，否则 schema 拒绝（[packages/experimental/agent-team/src/fold.ts:26-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L26-L30)）
- 内容块 schema 对 text/reasoning/image/tool-call/tool-result 五种核心类型逐字段严格校验，未知类型走 loose 且不得复用核心类型名（[packages/experimental/agent-team/src/fold.ts:33-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L33-L65)）
- 成员、任务、消息三种快照各自用 `.strict()` schema 限定字段集合与枚举取值（[packages/experimental/agent-team/src/fold.ts:67-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L67-L95)）
- 选择器 schema 用 loose 只取 `version` 与 `teamId`，四个事件 schema 则把 `version` 钉死为字面量 1（[packages/experimental/agent-team/src/fold.ts:97-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L97-L125)）
- `emptyTeamFoldState` 用 root Session id 作为 Team id 构造空态，`nextTaskNumber` 从 1 起（[packages/experimental/agent-team/src/fold.ts:143-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L143-L153)）
- `isTeamEvent` 按四个事件类型名判定归属（[packages/experimental/agent-team/src/fold.ts:170-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L170-L175)）
- 解码失败被包成 `persisted Agent Teams <type> payload is invalid` 并保留原始校验错误作为 cause（[packages/experimental/agent-team/src/fold.ts:178-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L178-L184)）
- `parseCurrentTeamEvent` 按事件类型选择对应 schema 解码 payload（[packages/experimental/agent-team/src/fold.ts:187-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L187-L201)）
- 非 Team 事件在折叠中被直接跳过（[packages/experimental/agent-team/src/fold.ts:209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L209)）
- 版本不为 1 时：teamId 不属于本 fold 就忽略，属于本 fold 则抛不支持的版本（[packages/experimental/agent-team/src/fold.ts:210-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L210-L214)）
- 解码后 `teamId` 不等于本 fold 的 id 时丢弃该记录（[packages/experimental/agent-team/src/fold.ts:216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L216)）
- `team/member`：同名被另一个 id 占用时抛错；首条记录必须是 `provisioning` 并登记名字占用（[packages/experimental/agent-team/src/fold.ts:219-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L219-L228)）
- `team/member`：后续记录不得改动 name/provider/context，且只接受由 `provisioning` 出发到非 `provisioning` 的迁移（[packages/experimental/agent-team/src/fold.ts:229-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L229-L237)）
- `team/task`：首条必须 revision 为 1，后续必须与上一条严格连续（[packages/experimental/agent-team/src/fold.ts:243-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L243-L248)）
- `team/task`：用候选快照跑一遍共享任务图校验（[packages/experimental/agent-team/src/fold.ts:249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L249)）
- `team/task`：从数字 id 推进 `nextTaskNumber`，取到 `MAX_SAFE_INTEGER` 时不再加一（[packages/experimental/agent-team/src/fold.ts:250-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L250-L257)）
- `team/message/queued`：同一消息 id 二次入队抛错（[packages/experimental/agent-team/src/fold.ts:261-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L261-L265)）
- `team/message/delivered`：未入队、目标与入队记录不符、重复投递分别抛错，通过后加入 delivered 集合（[packages/experimental/agent-team/src/fold.ts:267-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L267-L273)）
- `foldTeam` 从空态起按顺序逐条应用整条会话日志（[packages/experimental/agent-team/src/fold.ts:287-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/fold.ts#L287-L291)）

### packages/experimental/agent-team/src/index.ts

包的插件入口与 `ctx.agentTeams` 服务门面，组装名册、信箱、任务板、日志与生命周期各所有者，并挂 Remote 方法。

- 定义五项默认限值常量（[packages/experimental/agent-team/src/index.ts:44-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L44-L48)）
- `positiveLimit` 对非正安全整数抛 `TEAM_INVALID_CONFIG`（[packages/experimental/agent-team/src/index.ts:51-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L51-L56)）
- `static inject` 声明依赖 agents、sessions、sessionPersistence、subagents 四个服务（[packages/experimental/agent-team/src/index.ts:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L60)）
- `static Config` 用 schemastery 定义五个整数字段及其默认值与下界（[packages/experimental/agent-team/src/index.ts:62-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L62-L68)）
- 构造时把每项配置经 `positiveLimit` 再次校验后固化为运行期限值（[packages/experimental/agent-team/src/index.ts:82-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L82-L94)）
- 按 activity、lifecycle、journal、roster、mailbox、tasks 顺序装配，journal 的提交回调把 root id 转成 TeamId 并唤醒等待者（[packages/experimental/agent-team/src/index.ts:96-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L96-L108)）
- 监听 `session/event` 把每条会话事件送进信箱的送达观察（[packages/experimental/agent-team/src/index.ts:110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L110)）
- 监听 `agent/session-start` 为新起的 Agent 排一次恢复（[packages/experimental/agent-team/src/index.ts:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L111)）
- 监听 `agent/status`，若该 Agent 属于某个 Team 则唤醒该 Team 的等待者（[packages/experimental/agent-team/src/index.ts:112-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L112-L115)）
- 用 `ctx.effect` 注册运行期释放回调 `disposeRuntime`（[packages/experimental/agent-team/src/index.ts:116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L116)）
- 构造时对注册表中已存在的每个 Agent 各排一次恢复（[packages/experimental/agent-team/src/index.ts:117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L117)）
- `listMembers`、`createTask`、`getTask`、`listTasks` 都先用调用方 Agent 解析出 membership 再执行（[packages/experimental/agent-team/src/index.ts:134-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L134-L185)）
- `waitForChange` 先解析 membership，再按该 Team id 等待一次变更（[packages/experimental/agent-team/src/index.ts:204-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L204-L207)）
- `@Remote('view')` 对外暴露名册加非删除任务的组合投影（[packages/experimental/agent-team/src/index.ts:233-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L233-L239)）
- `@Remote('createTask')` 与 `@Remote('updateTask')` 把任务变更暴露为远端方法（[packages/experimental/agent-team/src/index.ts:247-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L247-L261)）
- `taskMutationResult` 把 `TeamError` 转成成功传输里的业务失败，`TEAM_TASK_STALE_REVISION` 映射为 `team-task-conflict`、其余为 `team-rejected`，非 `TeamError` 继续抛出（[packages/experimental/agent-team/src/index.ts:264-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L264-L277)）
- `scheduleRecovery` 用 `queueMicrotask` 延到事件发布退栈后执行，已释放则跳过，失败只记 warn（[packages/experimental/agent-team/src/index.ts:280-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L280-L288)）
- 恢复顺序固定为先名册后信箱，共用运行期取消 signal（[packages/experimental/agent-team/src/index.ts:291-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L291-L294)）
- `disposeRuntime` 先关闭准入与等待者，再结算在途创建与投递，然后按 root 逐组停掉在线的名册子代，任何失败汇总成 `AggregateError` 抛出（[packages/experimental/agent-team/src/index.ts:297-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L297-L312)）
- 默认导出服务类，供 Loader 以服务插件形式装载（[packages/experimental/agent-team/src/index.ts:315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/index.ts#L315)）

### packages/experimental/agent-team/src/invariant.ts

包自带的不变量 companion，对应 `./invariant` 导出条目。

- 声明 companion 插件名与它所需的 invariants 服务（[packages/experimental/agent-team/src/invariant.ts:11-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/invariant.ts#L11-L14)）
- 用全局 `internal/dispatch` 监听拦截 `session/event`，只对 Team 域事件继续（[packages/experimental/agent-team/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/invariant.ts#L17-L21)）
- 先折叠该会话已提交的事件前缀，再把候选事件应用上去，抛错时用事件 `seq` 报告违规（[packages/experimental/agent-team/src/invariant.ts:22-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/invariant.ts#L22-L28)）
- 在安装函数对象上附加 `inject: ['sessions']`，使安装体在会话服务就绪后才运行（[packages/experimental/agent-team/src/invariant.ts:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/invariant.ts#L30)）
- `apply` 把安装器注册进 invariants 注册表并返回其 disposer（[packages/experimental/agent-team/src/invariant.ts:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/invariant.ts#L33-L34)）

### packages/experimental/agent-team/src/journal.ts

在 Lead 会话日志上串行化 Team 事务并发布提交通知，被名册、信箱、任务板共用。

- `state` 每次读取都从 `root.session.events` 现场重放出当前 Team 状态，不缓存（[packages/experimental/agent-team/src/journal.ts:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/journal.ts#L30-L32)）
- `transact` 按 root Session id 维护队尾 Promise，前一个事务无论成败都接着跑下一个（[packages/experimental/agent-team/src/journal.ts:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/journal.ts#L40-L44)）
- 事务结束时只在队尾仍是自己时才删除该 root 的队列条目（[packages/experimental/agent-team/src/journal.ts:45-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/journal.ts#L45-L49)）
- `appendAndFlush` 把 `session.append` 收窄成不带会话表面参数的局部能力，使 Team 事件只进日志（[packages/experimental/agent-team/src/journal.ts:63-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/journal.ts#L63-L67)）
- 追加后先 flush 会话再同步触发提交回调，通知晚于耐久化（[packages/experimental/agent-team/src/journal.ts:68-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/journal.ts#L68-L69)）

### packages/experimental/agent-team/src/lifecycle.ts

Team 运行期的单一取消事实与有界结算，被服务门面、名册、信箱共用。

- 以单个 `AbortController` 提供 `signal`、`disposed`、`reason` 三个读法（[packages/experimental/agent-team/src/lifecycle.ts:15-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/lifecycle.ts#L15-L28)）
- `isCancellation` 沿 Error 的 cause 链判断拒因是否为运行期取消或 `TEAM_DISPOSED`，并用 seen 集合防止环（[packages/experimental/agent-team/src/lifecycle.ts:31-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/lifecycle.ts#L31-L42)）
- `close` 用带 `TEAM_DISPOSED` 码的 `TeamError` 作为 abort 原因（[packages/experimental/agent-team/src/lifecycle.ts:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/lifecycle.ts#L45-L47)）
- `settle` 对空列表直接返回，否则在超时约束下 `allSettled`，把非取消的拒因与自身抛出一并收进 failures（[packages/experimental/agent-team/src/lifecycle.ts:54-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/lifecycle.ts#L54-L64)）
- `withTimeout` 用 `Promise.race` 给结算加 `disposalTimeoutMs` 上限并抛 `TEAM_DISPOSAL_TIMEOUT`，finally 清定时器（[packages/experimental/agent-team/src/lifecycle.ts:71-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/lifecycle.ts#L71-L86)）

### packages/experimental/agent-team/src/mailbox.ts

耐久 Team 信箱的入队准入、按目标串行投递、送达确认与恢复重投，被服务门面的 `sendMessage` 与会话事件监听驱动。

- 维护按目标的投递队尾、当前活跃投递、在途消息 id 与在途操作四张进程内表（[packages/experimental/agent-team/src/mailbox.ts:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L25-L28)）
- `send` 在已释放时直接抛 `TEAM_DISPOSED`，否则把调用方 signal 与运行期 signal 合并后进入准入路径（[packages/experimental/agent-team/src/mailbox.ts:53-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L53-L60)）
- `observeSessionEvent` 只对 `user/message` 且来源为 `team-message` 的事件反应，据 teamId 找到 Lead 后补记送达，失败只记 warn（[packages/experimental/agent-team/src/mailbox.ts:67-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L67-L77)）
- `recoverFor` 取未送达消息：Lead 取全部，队友只取发给自己的（[packages/experimental/agent-team/src/mailbox.ts:84-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L84-L91)）
- Lead 侧恢复跳过目标不在线的 quiet 消息，其余按日志顺序逐条重投（[packages/experimental/agent-team/src/mailbox.ts:92-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L92-L97)）
- `sendAdmitted` 先对发送内容做 `structuredClone`，再在 root 事务内解析目标成员（[packages/experimental/agent-team/src/mailbox.ts:116-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L116-L120)）
- 目标等于发送者本人时抛 `TEAM_SELF_MESSAGE`（[packages/experimental/agent-team/src/mailbox.ts:121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L121)）
- 统计该目标的未送达消息数，达到 `maxPendingMessagesPerMember` 抛 `TEAM_MAILBOX_FULL`（[packages/experimental/agent-team/src/mailbox.ts:122-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L122-L129)）
- 生成 `team-message-<uuid>` 的消息 id 并记录发送者 id、发送者名、目标、投递模式与内容（[packages/experimental/agent-team/src/mailbox.ts:130-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L130-L137)）
- 用完整投递内容（含发送者前缀块）的 UTF-8 字节数对比 `maxMessageBytes`，超限抛 `TEAM_MESSAGE_TOO_LARGE`（[packages/experimental/agent-team/src/mailbox.ts:138-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L138-L140)）
- 先写入并 flush `team/message/queued`，再在释放 root 事务前登记投递，使并发发送方按日志顺序进入目标队列（[packages/experimental/agent-team/src/mailbox.ts:141-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L141-L148)）
- 发送结果按本次是否被接受返回 `accepted` 或 `queued`（[packages/experimental/agent-team/src/mailbox.ts:150-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L150-L151)）
- `tryDispatch` 在已释放或该消息已在途时返回 false，否则登记在途 id 并在结束时无论成败都清除（[packages/experimental/agent-team/src/mailbox.ts:155-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L155-L171)）
- `trackDispatch` 把每个投递与确认操作登记进在途集合供释放时结算（[packages/experimental/agent-team/src/mailbox.ts:174-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L174-L182)）
- 目标已有活跃投递、目标在线、本消息是 quiet 且在日志中排在活跃消息之前时，绕过串行队列直接投递（[packages/experimental/agent-team/src/mailbox.ts:190-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L190-L196)）
- `serializeDispatch` 把同一目标的投递接到该目标队尾之后，运行期间登记 activeDispatches，结束后按身份比对清理队尾（[packages/experimental/agent-team/src/mailbox.ts:200-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L200-L224)）
- 投递前若目标会话后缀已记录该消息 id，则只补记送达（[packages/experimental/agent-team/src/mailbox.ts:229-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L229-L231)）
- 构造 `team-message` 来源（含 teamId、messageId、发送者 id 与名）随消息一同写入目标会话（[packages/experimental/agent-team/src/mailbox.ts:233-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L233-L240)）
- 目标是 Lead 自身时：wakeup 走 `root.followup` 成为下一轮，quiet 走 `root.inject`，随后各自补记送达（[packages/experimental/agent-team/src/mailbox.ts:241-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L241-L249)）
- 目标是队友且模式为 quiet 时：不在线就保持排队，在线则 `inject` 而不唤起（[packages/experimental/agent-team/src/mailbox.ts:250-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L250-L254)）
- 目标不在线的唤起投递先查持久化会话：已记录则只写送达边，查不到结论则返回 false 保持排队（[packages/experimental/agent-team/src/mailbox.ts:255-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L255-L262)）
- 其余情形通过 `ctx.subagents.followup` 把内容交给目标（含冷启动路径），目标不在线时直接算作已接受（[packages/experimental/agent-team/src/mailbox.ts:263-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L263-L266)）
- 投递过程中任何异常都被吞成一条 warn，消息保持排队等待后续重投（[packages/experimental/agent-team/src/mailbox.ts:267-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L267-L270)）
- `messagePrecedes` 用 Lead 日志里 messages 键的插入顺序比较两条消息的先后（[packages/experimental/agent-team/src/mailbox.ts:274-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L274-L277)）
- `checkpointDelivered` 先 flush 目标会话，确认后缀里确有该消息才写送达边（[packages/experimental/agent-team/src/mailbox.ts:280-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L280-L289)）
- `markDelivered` 在 root 事务内幂等：已送达、消息不存在或目标不符时都不追加事件（[packages/experimental/agent-team/src/mailbox.ts:292-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L292-L305)）
- `targetRecorded` 只检查目标会话 `seedLength` 之后的自有后缀（[packages/experimental/agent-team/src/mailbox.ts:308-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L308-L312)）
- `deliveryContent` 在克隆内容前插入一段 `Team message <id> from <name>:` 文本块（[packages/experimental/agent-team/src/mailbox.ts:315-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L315-L320)）
- `persistedTargetRecorded` 在读取持久化失败时返回 undefined 并记 warn，使消息保持排队（[packages/experimental/agent-team/src/mailbox.ts:323-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/mailbox.ts#L323-L337)）

### packages/experimental/agent-team/src/roster.ts

Team 身份判定、可续接子代的开通与终态和解、以及名册侧的中断与拆除，被服务门面、信箱与任务板使用。

- 队友名必须匹配小写 kebab 正则（[packages/experimental/agent-team/src/roster.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L24)）
- `resolveActiveMember` 把 `lead` 解析为 root 会话 id，其余名字必须对应 `active` 成员，否则抛 `TEAM_MEMBER_NOT_FOUND`（[packages/experimental/agent-team/src/roster.ts:41-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L41-L54)）
- `membership` 解析不到时抛 `TEAM_NOT_MEMBER`（[packages/experimental/agent-team/src/roster.ts:78-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L78-L84)）
- `tryMembership` 要求传入对象与注册表中的 Agent 是同一个实例，否则视为过期身份（[packages/experimental/agent-team/src/roster.ts:92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L92)）
- 有在线父会话且自身在父的名册中处于 active 或 provisioning 时判定为 teammate（[packages/experimental/agent-team/src/roster.ts:94-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L94-L101)）
- 名册外的直接子代按自身后缀里是否有 subagent descriptor 分流：有则不给 Team 身份，无则自身成为新的 lead（[packages/experimental/agent-team/src/roster.ts:102-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L102-L106)）
- 父会话不在线时同样按 descriptor 决定返回 undefined 还是把自身当作 lead（[packages/experimental/agent-team/src/roster.ts:109-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L109-L114)）
- 整个探测包在 try/catch 里，日志损坏时返回 undefined 而不否决其他 Agent 生命周期（[packages/experimental/agent-team/src/roster.ts:115-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L115-L120)）
- `list` 先输出 lead 行（含实时 status 与 model），再按 fold 顺序输出成员行（[packages/experimental/agent-team/src/roster.ts:128-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L128-L142)）
- 成员行的 status 由 phase 与在线状态推出（failed/provisioning 直出，其余取在线状态或 inactive），model 缺省回落到 Lead 的 model，error 进 diagnostics（[packages/experimental/agent-team/src/roster.ts:143-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L143-L157)）
- `spawn` 在已释放时抛 `TEAM_DISPOSED`，并把创建操作登记进在途集合、结束后移除（[packages/experimental/agent-team/src/roster.ts:167-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L167-L176)）
- `recoverFor` 只在该 Agent 判定为 lead 时触发 provisioning 和解（[packages/experimental/agent-team/src/roster.ts:191-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L191-L195)）
- `interrupt` 仅 Lead 可用，不可打断自身，目标不在线时返回 `inactive`，否则先取样旧状态再以 ancestor 身份调用 subagent 中断（[packages/experimental/agent-team/src/roster.ts:203-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L203-L214)）
- `liveChildrenByRoot` 扫描在线 Agent，按父会话在线且自身在其名册中的条件分组（[packages/experimental/agent-team/src/roster.ts:220-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L220-L232)）
- `stopTeammates` 在生命周期超时约束下调用 `drainContinuableChildren` 释放选定子代（[packages/experimental/agent-team/src/roster.ts:239-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L239-L241)）
- 创建仅限 Lead，非 Lead 抛 `TEAM_LEAD_REQUIRED`（[packages/experimental/agent-team/src/roster.ts:248-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L248-L251)）
- 创建把请求 signal 与运行期 signal 合并后立即检查一次（[packages/experimental/agent-team/src/roster.ts:252-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L252-L253)）
- 校验队友名、description 与 provider（各限 200 字符），并预先生成子会话 id 后组成 provisioning 快照（[packages/experimental/agent-team/src/roster.ts:254-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L254-L265)）
- 在 root 事务内检查重名与 `maxMembers`，再写入并 flush `provisioning` 成员事件（[packages/experimental/agent-team/src/roster.ts:267-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L267-L276)）
- 用预留的 childId 通过 `startContinuable` 创建子代（provider、label、初始 prompt、父为 root），随后等待初始 prompt 落盘（[packages/experimental/agent-team/src/roster.ts:278-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L278-L290)）
- 创建失败时写入 failed 成员并停掉子代；若和解已把它置为 active 则抛 `TEAM_PROVISIONING_CONFLICT`；连失败记录也失败则抛 `AggregateError`（[packages/experimental/agent-team/src/roster.ts:291-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L291-L311)）
- 成功后提交 active 终态；若和解已抢先置为 failed，则停掉子代并抛冲突（[packages/experimental/agent-team/src/roster.ts:312-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L312-L334)）
- `checkpointInitialPrompt` 在子会话不在线时读持久化后缀判断该消息是否已被接受，未接受则抛 `TEAM_PROVISIONING_CONFLICT`（[packages/experimental/agent-team/src/roster.ts:343-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L343-L354)）
- 子会话在线时订阅 `session/event` 与 `session/disposed` 作为推进信号，flush 后检查后缀；会话对象被换掉则重新循环（[packages/experimental/agent-team/src/roster.ts:356-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L356-L385)）
- 和解跳过仍然在线的子代，把终态交给它的创建方（[packages/experimental/agent-team/src/roster.ts:390-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L390-L395)）
- 和解读取子会话持久化，要求父会话匹配、descriptor 为 continuable、provider 一致且已接受初始 user 消息才判 active，否则记录具体失败原因判 failed（[packages/experimental/agent-team/src/roster.ts:396-413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L396-L413)）
- 和解在 root 事务内复查该成员仍是 provisioning 才写入终态事件（[packages/experimental/agent-team/src/roster.ts:414-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L414-L429)）
- `memberName` 拒绝非 kebab、超过 64 字符或等于 `lead` 的名字（[packages/experimental/agent-team/src/roster.ts:450-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L450-L458)）
- `settleProvisioning` 在事务内幂等：成员消失抛冲突，已非 provisioning 则直接返回既有 phase 而不追加事件（[packages/experimental/agent-team/src/roster.ts:461-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L461-L479)）
- `subagentDescriptor` 只在会话 `seedLength` 之后的自有后缀里查找 descriptor（[packages/experimental/agent-team/src/roster.ts:482-484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/roster.ts#L482-L484)）

### packages/experimental/agent-team/src/session-message.ts

判断一条消息是否已被目标会话耐久接受，被队友开通检查点与信箱去重共用。

- 重放 `agent/inbox/spliced` 事件，对 `next-turn` 与 `next-step` 两条队列按 start/removedCount/inserted 做 splice 得到当前待领取项（[packages/experimental/agent-team/src/session-message.ts:9-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/session-message.ts#L9-L17)）
- `messageAccepted` 认定条件为已进入历史的 `user/message` 或仍在待领取收件箱中命中谓词（[packages/experimental/agent-team/src/session-message.ts:25-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/session-message.ts#L25-L31)）

### packages/experimental/agent-team/src/task-board.ts

共享任务板的限额、授权、比较置换式状态迁移与派生视图，被服务门面的任务方法调用。

- `scopesOverlap` 以路径分量前缀判定两个写作用域是否重叠（[packages/experimental/agent-team/src/task-board.ts:21-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L21-L23)）
- 把任务图三类违规映射到 `TEAM_TASK_NOT_FOUND`、`TEAM_INVALID_ARGUMENT`、`TEAM_TASK_DEPENDENCY_CYCLE`（[packages/experimental/agent-team/src/task-board.ts:25-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L25-L29)）
- 创建在事务内统计非 deleted 任务数，达到 `maxTasks` 抛 `TEAM_TASK_LIMIT`（[packages/experimental/agent-team/src/task-board.ts:50-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L50-L55)）
- 新任务 id 取 `task-<nextTaskNumber>`，若该 id 已存在则报 id 空间耗尽（[packages/experimental/agent-team/src/task-board.ts:56-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L56-L59)）
- 新任务固定为 revision 1、status pending、无 owner，subject 限 200 字符、description 限 16384 字符（[packages/experimental/agent-team/src/task-board.ts:60-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L60-L68)）
- 创建先校验依赖与写作用域和整图，再写入并 flush `team/task` 事件（[packages/experimental/agent-team/src/task-board.ts:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L69-L71)）
- `get` 允许读到 deleted 墓碑，不存在则抛 `TEAM_TASK_NOT_FOUND`（[packages/experimental/agent-team/src/task-board.ts:81-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L81-L87)）
- `list` 过滤掉 deleted 任务后按 fold 顺序输出（[packages/experimental/agent-team/src/task-board.ts:94-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L94-L100)）
- 更新在事务内比对 `expectedRevision`，不符抛 `TEAM_TASK_STALE_REVISION` 并带上当前 revision（[packages/experimental/agent-team/src/task-board.ts:115-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L115-L124)）
- 已删除的任务拒绝任何更新（[packages/experimental/agent-team/src/task-board.ts:125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L125)）
- `authorizeOwner` 要求调用方是 Lead 或该任务当前 owner，否则抛 `TEAM_TASK_UNAUTHORIZED`（[packages/experimental/agent-team/src/task-board.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L126-L130)）
- `claim`：他人已占抛 `TEAM_TASK_ALREADY_CLAIMED`，非 pending 或未就绪抛 `TEAM_TASK_BLOCKED`，通过后置 in_progress 并记 owner（[packages/experimental/agent-team/src/task-board.ts:133-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L133-L141)）
- `release`：仅 in_progress 可释放，回到 pending 并去掉 owner（[packages/experimental/agent-team/src/task-board.ts:142-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L142-L146)）
- `edit`：三个可编辑字段全缺时抛 `TEAM_INVALID_ARGUMENT`，给出的字段各自重新归一化（[packages/experimental/agent-team/src/task-board.ts:147-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L147-L160)）
- `set_dependencies`：必须给 `blocked_by`，并以自身 id 作为自指排除项重新校验依赖（[packages/experimental/agent-team/src/task-board.ts:161-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L161-L165)）
- `complete` 只允许从 in_progress 迁移，`reopen` 只允许从 completed 回到 pending 并去掉 owner（[packages/experimental/agent-team/src/task-board.ts:166-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L166-L175)）
- `reassign` 仅 Lead 可用，仅接受 pending 或 in_progress；owner 为空则回到无主 pending，否则要求任务就绪并解析为活跃成员后置 in_progress（[packages/experimental/agent-team/src/task-board.ts:176-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L176-L192)）
- `delete` 在仍有未删除任务依赖它时抛 `TEAM_TASK_HAS_DEPENDENTS`，否则置 deleted 墓碑（[packages/experimental/agent-team/src/task-board.ts:193-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L193-L202)）
- 提交前把 revision 加一，再校验整图并写入并 flush `team/task` 事件（[packages/experimental/agent-team/src/task-board.ts:207-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L207-L213)）
- `dependencies` 拒绝自指、重复以及缺失或已删除的阻塞任务（[packages/experimental/agent-team/src/task-board.ts:218-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L218-L236)）
- 写作用域逐个归一化后去重（[packages/experimental/agent-team/src/task-board.ts:239-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L239-L241)）
- `taskReady` 要求所有阻塞任务均为 completed（[packages/experimental/agent-team/src/task-board.ts:255-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L255-L257)）
- `taskView` 把 ownerId 翻成 `lead` 或成员名，与其它 in_progress 任务的写作用域重叠生成警告条目，并输出 `ready` 标记与克隆后的依赖、作用域数组（[packages/experimental/agent-team/src/task-board.ts:271-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-board.ts#L271-L296)）

### packages/experimental/agent-team/src/task-graph.ts

任务依赖关系的共享校验器，被任务板命令与重放折叠共用。

- `TeamTaskGraphError` 携带 missing/duplicate/cycle 三类违规分类供命令层映射错误码（[packages/experimental/agent-team/src/task-graph.ts:9-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-graph.ts#L9-L18)）
- 校验先用候选快照替换当前值再遍历全部非 deleted 任务，自指判 cycle、重复阻塞判 duplicate、阻塞项缺失或已删判 missing（[packages/experimental/agent-team/src/task-graph.ts:30-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-graph.ts#L30-L52)）
- 用带 visiting/visited 的深度优先遍历检测环，deleted 与不存在的节点直接返回（[packages/experimental/agent-team/src/task-graph.ts:54-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/task-graph.ts#L54-L68)）

### packages/experimental/agent-team/src/types.ts

包的公共类型文件：Team 身份 brand、耐久记录与请求结果类型，以及对会话事件表和消息来源表的声明合并。

- 无运行期机制

### packages/experimental/agent-team/src/validation.ts

名册与任务命令共用的输入归一化。

- `requiredText` 先 trim，空串抛 `TEAM_INVALID_ARGUMENT`，超过给定长度也抛同一码（[packages/experimental/agent-team/src/validation.ts:12-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/validation.ts#L12-L19)）
- `writeScope` 把反斜杠换成斜杠、去掉 `./` 前缀与尾部斜杠，并对空串、绝对路径、盘符前缀、空段、`.`、`..` 抛 `TEAM_INVALID_WRITE_SCOPE`（[packages/experimental/agent-team/src/validation.ts:26-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/src/validation.ts#L26-L34)）

### packages/experimental/agent-team/tsconfig.json

包的 TypeScript 编译配置，设定 rootDir/outDir 并列出工作区项目引用。

- 无运行期机制

### packages/experimental/agent-team/tsdown.config.ts

打包配置，决定该包发布出的两个运行期 bundle。

- 定义两个互不相干的打包任务，分别以 `lib/types/index.js` 与 `lib/types/invariant.js` 为入口输出到 `lib/`，使共享的折叠代码在两个 bundle 内各自包含一份（[packages/experimental/agent-team/tsdown.config.ts:4-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/tsdown.config.ts#L4-L25)）
- 两个任务都输出 esm、平台 node、目标 es2024，且不改扩展名、不生成 d.ts、不清理输出目录（[packages/experimental/agent-team/tsdown.config.ts:6-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team/tsdown.config.ts#L6-L13)）
