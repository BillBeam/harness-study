---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/jobs/tool-jobs
---

# packages/jobs/tool-jobs

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、47 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/jobs/tool-jobs/README.md

面向模型的后台任务控制工具包的说明文档，介绍三个工具、完成通知投递与配置项。

- 无运行期机制

### packages/jobs/tool-jobs/package.json

该包的 npm 清单，声明 ESM 类型、入口与发布文件集。

- 声明 `"type": "module"` 并把默认入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/jobs/tool-jobs/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/package.json#L13-L15)）
- `exports` 只放行 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个入口（[packages/jobs/tool-jobs/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/package.json#L16-L27)）
- `files` 限定发布内容为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/jobs/tool-jobs/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/package.json#L28-L32)）
- 把 agent、invariants、llm、output-retention、system-prompt、jobs、tools、cordis 列为 peerDependencies，由宿主组合提供（[packages/jobs/tool-jobs/package.json:37-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/package.json#L37-L46)）

### packages/jobs/tool-jobs/src/index.ts

以函数插件形式注册 `job_output`／`job_list`／`job_kill` 三个模型可见工具、挂上任务控制器、投递完成通知的入口模块。

- 导出插件名 `tool-jobs` 与 `inject = ['tools', 'jobs', 'systemPrompt']`，三个服务齐备后才会应用（[packages/jobs/tool-jobs/src/index.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L21-L22)）
- `Config` 校验模式给出 `waitTimeoutMs` 30000、`maxWaitTimeoutMs` 600000、`completionDelivery` `wakeup`、`maxConsecutiveWakes` 3 的默认值与下界（[packages/jobs/tool-jobs/src/index.ts:48-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L48-L53)）
- `PUBLIC_TASK_SCHEMA` 定义模型可见的任务对象结构：`additionalProperties: false`、必填 id/kind/label/status/startedAt、status 取五个枚举值（[packages/jobs/tool-jobs/src/index.ts:67-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L67-L83)）
- `publicJob()` 从登记表快照中剥掉 `ownerSession`、`reported`、`outputLimitBytes` 等字段，只留公开字段（[packages/jobs/tool-jobs/src/index.ts:86-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L86-L96)）
- `statusLine()` 把状态渲染为 `[status: <状态>]`，有 detail 时渲染为 `[status: <状态>, <detail>]`（[packages/jobs/tool-jobs/src/index.ts:103-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L103-L107)）
- `retainTail`／`retainHead` 用 `TextRetainer` 按字节上限保留文本尾部或头部（[packages/jobs/tool-jobs/src/index.ts:111-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L111-L121)）
- `fitWithSuffix()` 在超出字节上限时保留后缀与截断标记、只裁正文尾部，且正文已带同一标记时不重复添加；固定部分本身超限时整体按尾部裁剪（[packages/jobs/tool-jobs/src/index.ts:123-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L123-L135)）
- `completionSummary()` 把 kind、label、状态行拼成一行并过 `boundContextSummary` 定界，作为通知的折叠行摘要（[packages/jobs/tool-jobs/src/index.ts:142-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L142-L144)）
- `fitCompletionNotice()` 在 `outputLimitBytes` 内逐级降级通知文本：完整句 → 保留 `background job <id>` 前缀加裁剪后的 kind/label/状态加截断标记与 `job_output` 指示 → 只留前缀与指示 → 裁前缀 → 裁指示（[packages/jobs/tool-jobs/src/index.ts:146-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L146-L167)）
- `rawSingleText()` 只对恰好一个 text 块的结果返回其文本，其余结构返回 undefined（[packages/jobs/tool-jobs/src/index.ts:169-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L169-L174)）
- `boundSingleText()` 把单文本结果整体按上限裁剪并追加 `\n[result truncated]`（[packages/jobs/tool-jobs/src/index.ts:176-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L176-L183)）
- `visibleOutputLimit()` 只对 `job_output` 与 `job_kill` 生效，从调用方可见的任务列表里按 `job_id` 找出生产者声明的 `outputLimitBytes`（[packages/jobs/tool-jobs/src/index.ts:185-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L185-L190)）
- `validateJobId()` 拒绝空字符串 job_id 并抛出带回显值的错误（[packages/jobs/tool-jobs/src/index.ts:193-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L193-L198)）
- `presentTaskCall()` 为三个工具的调用生成 `generic` 卡片视图，带标题与 `read`／`execute` 类型（[packages/jobs/tool-jobs/src/index.ts:201-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L201-L203)）
- `apply` 内对四个配置项各自兜一层默认值（[packages/jobs/tool-jobs/src/index.ts:206-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L206-L209)）
- 以 `WeakMap<Agent, number>` 按确切 agent 实例记录已花费的唤醒次数，同会话的替换实例从满额度开始（[packages/jobs/tool-jobs/src/index.ts:214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L214)）
- `waitTimeoutMs` 大于 `maxWaitTimeoutMs` 时在加载期抛错（[packages/jobs/tool-jobs/src/index.ts:215-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L215-L217)）
- `maxConsecutiveWakes` 非安全整数时在加载期抛错（[packages/jobs/tool-jobs/src/index.ts:220-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L220-L222)）
- 仅在 `wakeup` 投递下监听 `agent/inbox/claimed`，且只有 `source.kind === 'user'` 的消息被认领时才清空该 owner 的唤醒计数（[packages/jobs/tool-jobs/src/index.ts:224-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L224-L230)）
- 以 `prepend: true` 在 `tools/pre-execute` 链首捕获该次执行的输出字节上限，存入按执行对象索引的 WeakMap 后调用 `next()` 继续链（[packages/jobs/tool-jobs/src/index.ts:232-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L232-L237)）
- `finalizeTaskContent` 取回（或重算）上限并清掉缓存条目，无上限时返回 undefined 不改结果（[packages/jobs/tool-jobs/src/index.ts:238-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L238-L242)）
- 对未出错的 `job_output`，仅当渲染文本仍与默认「正文 + 换行 + 状态行」一致时，按上限只裁正文并保留状态行后缀（[packages/jobs/tool-jobs/src/index.ts:243-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L243-L255)）
- 其余情况把单文本结果整体定界；多块结构结果保持原样（[packages/jobs/tool-jobs/src/index.ts:256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L256)）
- 调用 `ctx.jobs.attachController('tool-jobs')` 挂上控制器，生产者才被允许启动后台任务（[packages/jobs/tool-jobs/src/index.ts:259-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L259-L260)）
- 注册名为 `tool:jobs` 的系统提示段，按 `FIRST_PARTY_SECTION_ORDER.TOOL_JOBS` 排序，写入「记录 job id、不要轮询或睡等、收尾前用 job_output 收集、用 job_kill 清理」的固定文本（[packages/jobs/tool-jobs/src/index.ts:262-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L262-L267)）
- `onJobDone` 监听器对已上报或无主的结算直接跳过，不产生任何通知（[packages/jobs/tool-jobs/src/index.ts:279-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L279-L280)）
- 用 `createUserMessage` 造一条 user 角色消息，正文是裁剪后的完成通知，来源标为 `plugin`／`tool-jobs`／`notice` 并附摘要（[packages/jobs/tool-jobs/src/index.ts:281-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L281-L292)）
- 投递为 `wakeup`、owner 处于 `idle` 且唤醒额度未用尽时，计数加一并用 `owner.followup(message)` 开一个新回合（[packages/jobs/tool-jobs/src/index.ts:293-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L293-L298)）
- 其余情况（owner 忙、额度用尽或 `quiet` 投递）用 `owner.inject(message)` 塞进下一步的收件箱（[packages/jobs/tool-jobs/src/index.ts:299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L299)）
- 注册 `job_output`：描述与 `job_id`／`wait`／`timeout_ms` 参数模式构成模型看到的工具定义（[packages/jobs/tool-jobs/src/index.ts:302-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L302-L313)）
- `job_output` 的输出模式要求 `{ text, job }`，渲染时空文本替换为 `(no new output)`，并在必要处补换行后附状态行（[packages/jobs/tool-jobs/src/index.ts:314-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L314-L329)）
- `job_output` 执行时 `wait: true` 才等待，等待时长取 `min(模型给的 timeout_ms 或默认值, 上限)`，并把执行的 signal 传给登记表（[packages/jobs/tool-jobs/src/index.ts:330-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L330-L335)）
- `job_output` 随后以调用方 agent 读取任务输出，并把快照过 `publicJob` 后返回（[packages/jobs/tool-jobs/src/index.ts:336-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L336-L339)）
- 注册 `job_list`：无参数，输出为公开快照数组，渲染成每行 `<id> [<kind>] <status> — <label>`，空表渲染为 `(no background jobs)`（[packages/jobs/tool-jobs/src/index.ts:342-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L342-L354)）
- `job_list` 执行时以调用方 agent 取列表，因而只返回该会话可见的任务（[packages/jobs/tool-jobs/src/index.ts:355-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L355-L359)）
- 注册 `job_kill`：描述与 `job_id`／可选 `reason` 参数模式构成模型看到的工具定义（[packages/jobs/tool-jobs/src/index.ts:362-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L362-L368)）
- `job_kill` 的输出模式限定 `outcome` 为两个枚举值，渲染为 `requested cancellation of job <id>` 或 `job <id> had already finished [status: ...]`（[packages/jobs/tool-jobs/src/index.ts:369-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L369-L389)）
- `job_kill` 执行时把 reason 传给登记表发起取消，再用 `get` 取一份不消费待读输出的快照一并返回（[packages/jobs/tool-jobs/src/index.ts:390-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/index.ts#L390-L399)）

### packages/jobs/tool-jobs/src/invariant.ts

该包的不变量伴生插件入口，被不变量服务加载以登记包归属。

- 声明 `inject = ['invariants']`，插件只在不变量服务就绪后应用（[packages/jobs/tool-jobs/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/invariant.ts#L15)）
- 安装器为空函数，本包不注册任何运行期检查（[packages/jobs/tool-jobs/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/invariant.ts#L21)）
- `apply` 把包名与空安装器注册进 `ctx.invariants` 并返回其 disposer（[packages/jobs/tool-jobs/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/tool-jobs/src/invariant.ts#L28-L29)）

### packages/jobs/tool-jobs/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、类型产物目录与工作区项目引用。

- 无运行期机制
