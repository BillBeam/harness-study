---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/schedule/schedule
---

# packages/schedule/schedule

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、103 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/schedule/schedule/README.md

会话内定时提醒包的说明文档，描述三个提醒工具、投递方式、时间校验与模型可见框架文本，供使用者和维护者阅读。

- 无运行期机制

### packages/schedule/schedule/package.json

本包的 npm 清单，声明入口、子路径导出与发布内容。

- `"type": "module"` 与 `main`/`types` 指向 `lib/index.js` 及其类型声明（[packages/schedule/schedule/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/package.json#L13-L15)）
- `exports` 把包根映射到 `lib/index.js`、`./invariant` 映射到 `lib/invariant.js`，并额外开放 `./src/*` 与 `./package.json`（[packages/schedule/schedule/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/package.json#L16-L27)）
- `files` 把发布内容限定为两个运行时 bundle 与 `lib/types` 下的类型声明（[packages/schedule/schedule/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/package.json#L28-L32)）

### packages/schedule/schedule/src/domain.ts

纯函数模块：持久事件的严格解码与折叠、时间校验、周期occurrence 运算，以及投递时的模型可见文本渲染；被 index、tools、runtime、invariant 共同引用。

- 固定持久协议版本常量 `SCHEDULE_CHANGE_VERSION = 1`，解码时据此拒绝其他版本（[packages/schedule/schedule/src/domain.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L21)）
- 固定周期提醒的最小间隔为 300 秒（[packages/schedule/schedule/src/domain.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L24)）
- 用四位年份的最小/最大毫秒边界与规范 UTC 瞬时正则界定一切可接受的时间取值（[packages/schedule/schedule/src/domain.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L26-L28)）
- `ScheduleLogError` 携带固定码 `corrupt_schedule_log`，作为持久流失败的统一类型（[packages/schedule/schedule/src/domain.ts:41-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L41-L53)）
- `ScheduleInputError` 只允许六个固定输入错误码，作为对模型暴露的失败取值集合（[packages/schedule/schedule/src/domain.ts:56-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L56-L87)）
- `hasExactKeys` 要求持久对象的键集合与期望完全相等，多一个字段即拒绝（[packages/schedule/schedule/src/domain.ts:120-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L120-L124)）
- `decodeId` 拒绝空串与首尾带空白的 id（[packages/schedule/schedule/src/domain.ts:127-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L127-L132)）
- `decodeInstant` 先按正则校验，再用 `toISOString()` 回环比较，拒绝形似但不存在的日历时刻（[packages/schedule/schedule/src/domain.ts:135-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L135-L144)）
- `calendarEpoch` 逐字段回读 UTC 分量，拒绝被 Date 归一化的日期（如 2 月 30 日）（[packages/schedule/schedule/src/domain.ts:165-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L165-L182)）
- `futureInstant` 要求目标为安全整数、落在四位年份区间内且严格晚于采样的当前时间，否则抛 `time_out_of_range` 或 `not_future`（[packages/schedule/schedule/src/domain.ts:190-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L190-L210)）
- `parseOffsetInstant` 只接受带 `Z` 或数值偏移的严格 RFC 3339 串，拒绝越界的时分与 `-00:00`，并按偏移换算 UTC（[packages/schedule/schedule/src/domain.ts:213-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L213-L244)）
- `canonicalizeTimeZone` 用 `Intl.DateTimeFormat` 解析并规范化时区名，失败或非 IANA 结果抛 `invalid_time_zone`（[packages/schedule/schedule/src/domain.ts:251-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L251-L270)）
- `parseLocalAt` 按固定日期与时间正则解析本地日历字段，允许一到三位毫秒（[packages/schedule/schedule/src/domain.ts:273-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L273-L298)）
- `localProjection` 从 `longOffset` 时区名反解出偏移秒数，并把某一时刻投影回本地日历分量（[packages/schedule/schedule/src/domain.ts:301-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L301-L330)）
- `resolveLocalInstant` 采样前后两天内出现过的偏移集合，逐个反算并回投影校验，重叠时取最早候选、空候选按越界或"该本地时间不存在"分别报错（[packages/schedule/schedule/src/domain.ts:333-382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L333-L382)）
- `decodeAfterRecord` 要求恰好五个字段、prompt 非空且已 trim、`afterSeconds` 为正安全整数，并冻结结果（[packages/schedule/schedule/src/domain.ts:385-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L385-L404)）
- `decodeAtRecord` 要求恰好四个字段且 prompt 已 trim（[packages/schedule/schedule/src/domain.ts:407-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L407-L421)）
- `decodeEveryRecord` 要求 `everySeconds` 为不小于 300 的安全整数且换算成毫秒后仍是安全整数（[packages/schedule/schedule/src/domain.ts:424-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L424-L447)）
- `decodeScheduleRecord` 按 `kind` 分派到三种解码，未知 kind 抛持久流错误（[packages/schedule/schedule/src/domain.ts:450-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L450-L458)）
- `decodeScheduleChange` 先校验 `version === 1`，再按 create/delete/dispatch 分别要求精确键集合（[packages/schedule/schedule/src/domain.ts:465-489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L465-L489)）
- dispatch 只接受"仅 id"或"id 加 acceptedAt"两种形状，其余一律拒绝（[packages/schedule/schedule/src/domain.ts:490-507](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L490-L507)）
- `resolveEveryOccurrence` 用整数除法直接取"决定时刻前最后一次对齐 occurrence"，并给出下一次目标，越出四位年份上界时不再给下一次（[packages/schedule/schedule/src/domain.ts:519-551](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L519-L551)）
- `dispatchedRecord` 规定一次性记录的 dispatch 不得带 `acceptedAt` 且投递后终结，周期记录必须带 `acceptedAt` 并推进到下一次目标（[packages/schedule/schedule/src/domain.ts:556-567](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L556-L567)）
- `foldScheduleEvents` 先校验 `seedLength` 在事件数组范围内，再只折叠 `events.slice(seedLength)`，使派生会话不继承父会话的记录（[packages/schedule/schedule/src/domain.ts:575-586](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L575-L586)）
- 折叠时 create 拒绝复用已出现过的 id，delete 与 dispatch 命中非活跃 id 一律抛错（[packages/schedule/schedule/src/domain.ts:588-609](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L588-L609)）
- 折叠结果冻结返回"按创建顺序的活跃记录"与"出现过的全部 id"（[packages/schedule/schedule/src/domain.ts:617-620](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L617-L620)）
- `allocateScheduleId` 从已用 id 数量起递增生成 `schedule-N`，跳过任何已出现过的 id（[packages/schedule/schedule/src/domain.ts:628-637](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L628-L637)）
- `createAfterScheduleRecord` 对 prompt 做 trim 与非空检查、要求正安全整数延迟，并以单次采样的 now 加延迟得到目标（[packages/schedule/schedule/src/domain.ts:647-669](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L647-L669)）
- `createAtScheduleRecord` 按字符串走偏移解析、按对象要求恰好 `date`/`time`/`time_zone` 三键并走本地时区解析，其它形状报 `invalid_rule`；记录里不保存原始偏移或本地字段（[packages/schedule/schedule/src/domain.ts:679-720](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L679-L720)）
- `createEveryScheduleRecord` 对低于 300 秒的间隔返回 `frequency_too_high`，并把首个目标定在 now 加一个间隔（[packages/schedule/schedule/src/domain.ts:730-758](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L730-L758)）
- `scheduleView` 在记录之上按 now 与目标比较派生 `scheduled`/`overdue` 状态，并固定 `deliveryMode: 'session-local'`（[packages/schedule/schedule/src/domain.ts:766-772](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L766-L772)）
- `renderReminderFraming` 生成到期一次性提醒的固定五行文本，id 与 prompt 经 `JSON.stringify` 转义并注明按不可信内容对待（[packages/schedule/schedule/src/domain.ts:779-787](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L779-L787)）
- `renderEveryReminderBatchFraming` 把整批周期提醒渲染为一条文本，`reminders_json` 为含 `schedule_id`/`occurrence_at`/`reminder_prompt` 的 JSON 数组（[packages/schedule/schedule/src/domain.ts:794-807](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/domain.ts#L794-L807)）

### packages/schedule/schedule/src/index.ts

插件入口：声明注入、监听 agent 创建事件，为根 agent 装配运行时与三个工具，并在卸载时收尾。

- `inject` 声明四个必需服务，缺任一则组合失败（[packages/schedule/schedule/src/index.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/index.ts#L35)）
- 只处理插件加载后发布的 `agent/created`，且跳过正在停机、已装配以及非根 agent（[packages/schedule/schedule/src/index.ts:45-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/index.ts#L45-L46)）
- 为该 agent 新建运行时，并在 `agent.ctx` 上注册三个工具，工具的持久变更回调转成 `requestDrive()`（[packages/schedule/schedule/src/index.ts:47-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/index.ts#L47-L49)）
- 监听 `agent/status`，在状态转为 `idle` 且会话日志出现过 `schedule/change` 时触发一次重新计算（[packages/schedule/schedule/src/index.ts:50-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/index.ts#L50-L54)）
- 立即启动运行时，进入首次持久校验与定时器推导（[packages/schedule/schedule/src/index.ts:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/index.ts#L55)）
- agent 侧 effect 释放时依次摘除状态监听、注销工具、等待运行时 dispose，并把自己从表中删除（[packages/schedule/schedule/src/index.ts:56-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/index.ts#L56-L64)）
- 插件卸载时置停机标志、摘除创建监听并 `allSettled` 等待全部 agent 清理完成（[packages/schedule/schedule/src/index.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/index.ts#L69-L75)）

### packages/schedule/schedule/src/invariant.ts

本包的 invariant 伴生插件，把折叠规则同时用于既有会话日志与待追加的候选事件。

- 声明 `inject = ['invariants']`，注册前必须先有该服务（[packages/schedule/schedule/src/invariant.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/invariant.ts#L16)）
- `validate` 调用折叠函数，捕获 `ScheduleLogError` 后以其 message 调用 `fail`，其它异常继续抛出（[packages/schedule/schedule/src/invariant.ts:19-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/invariant.ts#L19-L27)）
- 安装时先校验全部现存会话，再监听 `session/created` 校验新会话（[packages/schedule/schedule/src/invariant.ts:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/invariant.ts#L32-L37)）
- 拦截 `internal/dispatch` 上的 `session/event`，对 `schedule/change` 事件用"现有事件加候选事件"预先折叠一次（[packages/schedule/schedule/src/invariant.ts:38-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/invariant.ts#L38-L43)）
- `apply` 以固定包名向 invariant 注册表登记安装器并返回其 disposer（[packages/schedule/schedule/src/invariant.ts:52-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/invariant.ts#L52-L53)）

### packages/schedule/schedule/src/persistence.ts

对共享会话持久化屏障的本包封装，被工具与运行时在读、决定与追加后调用。

- `SchedulePersistenceError` 把任何屏障失败收敛为一种类型并保留 cause（[packages/schedule/schedule/src/persistence.ts:7-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/persistence.ts#L7-L16)）
- `flushSchedulePersistence` 要求 `ctx.sessions.flush(session)` 返回真值，返回假或抛出都转成持久化失败（[packages/schedule/schedule/src/persistence.ts:24-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/persistence.ts#L24-L31)）

### packages/schedule/schedule/src/runtime.ts

单个根 agent 的活动定时器投影：决定何时到期、抢占空闲维护相位、排入后续消息并追加 dispatch 事件。

- `MAX_TIMER_DELAY_MS` 把单次定时器长度截到 Node 不会溢出的上限（[packages/schedule/schedule/src/runtime.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L22)）
- `dueDecision` 先挑到期的一次性记录，按目标时间再按创建顺序排序取第一条（[packages/schedule/schedule/src/runtime.ts:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L43-L47)）
- 无一次性到期时，把全部到期的周期记录合成一批，共用一次 `acceptedAt` 采样并各取其最新 occurrence（[packages/schedule/schedule/src/runtime.ts:49-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L49-L62)）
- 都未到期时返回最近的未来目标作为下一次唤醒时间（[packages/schedule/schedule/src/runtime.ts:64-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L64-L68)）
- `requestDrive` 在停机或已故障时直接返回，否则清定时器、置请求标志，并在已有运行中的驱动时合并为一次（[packages/schedule/schedule/src/runtime.ts:103-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L103-L107)）
- 驱动在 `withoutInitiator` 下运行，失败时记录警告并把运行时置为故障，不再接受新驱动（[packages/schedule/schedule/src/runtime.ts:108-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L108-L128)）
- `dispose` 只执行一次：置停机、清请求、清定时器、解析停止信号，并等待未完成的驱动与空闲等待（[packages/schedule/schedule/src/runtime.ts:131-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L131-L140)）
- `runRequested` 串行地把合并后的触发逐次交给 agent 级事务执行（[packages/schedule/schedule/src/runtime.ts:143-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L143-L148)）
- `retire` 在一次驱动结束后，若结算微任务间隙里又来了触发就再驱动一次（[packages/schedule/schedule/src/runtime.ts:151-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L151-L157)）
- `isLive` 以"注册表里该 id 仍是同一对象且仍在根列表中"作为继续工作的前提（[packages/schedule/schedule/src/runtime.ts:160-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L160-L168)）
- `arm` 只武装 `min(距目标, 上限)` 的一段定时，唤醒后重新读时钟（[packages/schedule/schedule/src/runtime.ts:178-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L178-L184)）
- `waitForIdle` 把 `agent.whenIdle()` 与停止信号竞速，成功后重新驱动，不额外起重试定时器（[packages/schedule/schedule/src/runtime.ts:187-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L187-L203)）
- `readFolded` 折叠失败时把运行时永久置为故障并记录日志，返回 undefined（[packages/schedule/schedule/src/runtime.ts:206-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L206-L218)）
- `decide` 把时钟决定的异常仅记录为警告并放弃本次，不置故障（[packages/schedule/schedule/src/runtime.ts:221-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L221-L228)）
- `driveOnce` 先清定时器并要求一次持久化屏障通过，失败即返回、不做任何投递（[packages/schedule/schedule/src/runtime.ts:231-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L231-L242)）
- 屏障后重新折叠、采样时钟并决定；判为等待则武装定时器后返回（[packages/schedule/schedule/src/runtime.ts:244-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L244-L252)）
- 到期工作通过 `agent.runMaintenance` 抢占空闲维护相位，并在相位内再折叠、再采样、再决定一次（[packages/schedule/schedule/src/runtime.ts:256-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L256-L266)）
- 相位内按一次性或批量渲染框架文本，构造来源标记为 `plugin: 'schedule'` 的 user 消息并同步 `followup()` 入队；渲染或入队失败则不写 dispatch（[packages/schedule/schedule/src/runtime.ts:267-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L267-L281)）
- 入队成功后才追加 dispatch 事件：一次性只写 id，批量对每条记录写 id 加共享的 `acceptedAt`（[packages/schedule/schedule/src/runtime.ts:282-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L282-L298)）
- 追加失败把运行时置为故障并清定时器，因为消息可能已经入队（[packages/schedule/schedule/src/runtime.ts:299-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L299-L304)）
- 维护相位被其他活动占用时抢占同步失败，改为等待下一个空闲边界，记录保持活跃（[packages/schedule/schedule/src/runtime.ts:307-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L307-L311)）
- 投递成功后再要求一次持久化屏障，失败则本次结束，dispatch 留待后续预检恢复（[packages/schedule/schedule/src/runtime.ts:312-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L312-L321)）
- 屏障通过后立刻再触发一次驱动，以便连续处理仍然到期的记录（[packages/schedule/schedule/src/runtime.ts:322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/runtime.ts#L322)）

### packages/schedule/schedule/src/tools.ts

三个管理工具的定义与执行体：模型可见的参数与输出 schema、预检、串行事务、追加事件与固定错误取值。

- 三种记录各自的输出 schema 共享 id/prompt/scheduledAt/state/deliveryMode 字段，`state` 限定为 `scheduled`/`overdue`，`deliveryMode` 固定为 `session-local`（[packages/schedule/schedule/src/tools.ts:38-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L38-L75)）
- 错误 schema 集合固定为九个两字段错误加一个带 `operation`/可选 `id` 的 `persistence_uncertain`（[packages/schedule/schedule/src/tools.ts:89-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L89-L115)）
- 三个工具的输出 schema 分别是"视图或错误""视图数组或错误""删除结果或错误"，删除成功与 `schedule_not_found` 是两种不同形状（[packages/schedule/schedule/src/tools.ts:117-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L117-L145)）
- 三段工具描述文本直接进入模型可见的工具目录，说明"恰好一个选择器""跳过错过的周期""会话内投递"等约束（[packages/schedule/schedule/src/tools.ts:147-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L147-L162)）
- `renderValue` 把已通过 schema 校验的值 `JSON.stringify` 成单个文本块作为工具结果内容（[packages/schedule/schedule/src/tools.ts:165-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L165-L169)）
- `present` 生成通用卡片视图，读操作标 `read`、其余标 `other`（[packages/schedule/schedule/src/tools.ts:172-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L172-L174)）
- `internalError` 与 `cancellationPlaceholder` 把不宜暴露的失败与"排队期间已取消"统一收敛为 `internal_error`（[packages/schedule/schedule/src/tools.ts:177-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L177-L184)）
- `runCancellableScheduleTransaction` 在拿到 FIFO 执行权后先看取消信号，已取消则不再执行主体（[packages/schedule/schedule/src/tools.ts:187-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L187-L196)）
- `persistenceError` 返回带操作名与可选 id 的固定文案，并提示先用 `schedule_list` 重查（[packages/schedule/schedule/src/tools.ts:204-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L204-L214)）
- `inputError` 把域层输入异常的 code 与 message 原样映射进工具错误联合（[packages/schedule/schedule/src/tools.ts:217-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L217-L219)）
- `foldForTool` 把折叠失败区分为 `corrupt_schedule_log` 与 `internal_error` 两种返回值而非抛出（[packages/schedule/schedule/src/tools.ts:222-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L222-L228)）
- `preflight` 用一次持久化屏障作为任何读或决定的前置条件，失败返回 `persistence_uncertain` 且不泄露后端错误（[packages/schedule/schedule/src/tools.ts:238-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L238-L250)）
- `validateCreateArgs` 在进入事务前拒绝未知键、拒绝选择器数量不等于一，并检查 prompt 非空与两种数值区间（[packages/schedule/schedule/src/tools.ts:253-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L253-L289)）
- `notifyDurableChange` 把回调异常降级为警告，不让投影观察者反转已完成的屏障（[packages/schedule/schedule/src/tools.ts:308-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L308-L314)）
- `schedule_create` 的参数暴露必填 `prompt` 与三个可选选择器，`at` 用 oneOf 同时接受字符串与恰好三键的本地对象（[packages/schedule/schedule/src/tools.ts:317-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L317-L350)）
- 创建执行体先核对执行者就是注册时那个 agent，再做形状校验，然后进入可取消的串行事务并做首次预检与通知（[packages/schedule/schedule/src/tools.ts:351-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L351-L358)）
- 预检通过后折叠、分配不复用的 id，并按选择器调用对应的记录构造函数，输入异常映射为固定 code（[packages/schedule/schedule/src/tools.ts:359-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L359-L378)）
- 追加前再查一次取消信号；追加 create 事件后必须再过一次持久化屏障才返回视图，否则返回 `persistence_uncertain`（[packages/schedule/schedule/src/tools.ts:379-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L379-L393)）
- `schedule_list` 无参数，预检通过后按创建顺序把活跃记录映射为共享同一 now 的视图（[packages/schedule/schedule/src/tools.ts:399-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L399-L414)）
- `schedule_delete` 先拒绝空串与带空白的 id，再核对执行者身份（[packages/schedule/schedule/src/tools.ts:426-431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L426-L431)）
- 删除在折叠后找不到活跃记录时返回 `deleted: false` 与 `schedule_not_found`，不追加任何事件（[packages/schedule/schedule/src/tools.ts:432-440](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L432-L440)）
- 真正删除时追加 delete 事件并同样要求追加后的第二次屏障才确认成功（[packages/schedule/schedule/src/tools.ts:441-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L441-L451)）
- 三个注册中任一失败时逆序回滚已完成的注册并继续抛出（[packages/schedule/schedule/src/tools.ts:456-459](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L456-L459)）
- 返回的聚合 disposer 幂等且逆序注销三个工具（[packages/schedule/schedule/src/tools.ts:461-466](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/tools.ts#L461-L466)）

### packages/schedule/schedule/src/transaction.ts

按 agent 串行化本包全部读与持久变更的小工具，被工具执行体和运行时共用。

- 用 `WeakMap<Agent, Promise>` 维护每个 agent 的队尾，新事务接在前一个之后执行（[packages/schedule/schedule/src/transaction.ts:5-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/transaction.ts#L5-L15)）
- 队尾用吞掉结果与异常的派生 promise 记录，失败的事务不会阻断后续排队者（[packages/schedule/schedule/src/transaction.ts:16-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/src/transaction.ts#L16-L22)）

### packages/schedule/schedule/src/types.ts

本包的持久记录、变更、视图与错误的类型声明文件，并对会话事件表做声明合并。

- 无运行期机制

### packages/schedule/schedule/tsconfig.json

本包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区项目引用。

- 无运行期机制

### packages/schedule/schedule/tsdown.config.ts

打包配置，决定 package.json 的 exports 所指向的两个运行时文件如何生成。

- 分别以 `lib/types/index.js` 与 `lib/types/invariant.js` 为入口打出 `lib/index.js` 与 `lib/invariant.js` 两个独立 ESM bundle（[packages/schedule/schedule/tsdown.config.ts:4-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/schedule/tsdown.config.ts#L4-L25)）
