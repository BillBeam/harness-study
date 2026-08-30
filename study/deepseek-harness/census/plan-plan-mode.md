---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/plan/plan-mode
---

# packages/plan/plan-mode

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、72 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/plan/plan-mode/README.md

这是 plan-mode 包的说明文档，向使用者与维护者介绍计划模式的配置字段、命令、退出工具与投影单元。

- 无运行期机制

### packages/plan/plan-mode/package.json

这是 plan-mode 包的 npm 清单，声明入口、子路径导出、发布文件与依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定裸包名导入解析到的运行时模块（[packages/plan/plan-mode/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./types`、`./client`、`./src/*`、`./package.json` 六个子路径，其余路径不可被导入（[packages/plan/plan-mode/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/package.json#L16-L35)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 以及 `lib/types` 下的 `.js` 与 `.d.ts`（[packages/plan/plan-mode/package.json:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/package.json#L36-L41)）
- `peerDependenciesMeta` 把 `dsh-commands` 标为可选，因此缺少命令注册表时该 peer 依赖不报缺失（[packages/plan/plan-mode/package.json:55-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/package.json#L55-L59)）
- `dependencies` 引入 `zod`，运行期用于投影状态与视图的 schema 校验（[packages/plan/plan-mode/package.json:60-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/package.json#L60-L62)）

### packages/plan/plan-mode/src/client.ts

这是客户端命名空间入口，纯粹再导出 `./types.ts` 的类型。

- 无运行期机制

### packages/plan/plan-mode/src/index.ts

这是包主入口，定义 `plan/mode` 会话事件、`ctx.planMode` 服务、`plan:policy` 提示段、`plan` 投影单元、`/plan` 命令与 `exit_plan_mode` 工具。

- 通过声明合并向 `SessionEventMap` 加入 `plan/mode` 事件，载荷为 `{ active: boolean }`，仅写日志、整值替换（[packages/plan/plan-mode/src/index.ts:46-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L46-L55)）
- 向 `Context` 合并 `planMode` 服务属性（[packages/plan/plan-mode/src/index.ts:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L57-L61)）
- 常量把退出工具的模型可见名固定为 `exit_plan_mode`（[packages/plan/plan-mode/src/index.ts:67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L67)）
- 常量固定评审问题的 id 与两个选项标签 `Approve`／`Keep planning`，答案按这些标签比对（[packages/plan/plan-mode/src/index.ts:76-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L76-L82)）
- 拼出模型可见的退出工具描述文本，要求以 `#` 标题开头的完整 markdown 计划并说明两种用户回应（[packages/plan/plan-mode/src/index.ts:84-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L84-L88)）
- `firstHeading` 逐行匹配一到六级 markdown 标题取出首个标题文本（[packages/plan/plan-mode/src/index.ts:91-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L91-L97)）
- `resolveConfig` 在 `section` 非字符串、去空后为空、或存在未知字段时抛错，并返回只含 `section` 的新对象（[packages/plan/plan-mode/src/index.ts:106-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L106-L119)）
- `foldPlanMode` 在事件前缀 `[0, end)` 上折叠，最后一个 `plan/mode` 决定结果，无该事件时为 `false`（[packages/plan/plan-mode/src/index.ts:129-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L129-L138)）
- 向 `SessionProjectionStateMap` 合并 `plan` 单元状态类型（[packages/plan/plan-mode/src/index.ts:154-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L154-L158)）
- `planUnitStateSchema` 以 strict 对象校验持久化单元状态 `{active, wanted, running}`，多余字段不通过（[packages/plan/plan-mode/src/index.ts:160-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L160-L167)）
- `planProjectionSchema` 定义下发给客户端的 `{active, pending}` 线上载荷校验（[packages/plan/plan-mode/src/index.ts:170-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L170-L173)）
- `hasOpenTurn` 折叠 `turn/start`／`turn/end` 判断日志里是否有未闭合的回合（[packages/plan/plan-mode/src/index.ts:176-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L176-L183)）
- `planModeAtLastHeader` 定位最后一个 `request/header` 并折叠到该位置，得出上一次请求所处的模式（[packages/plan/plan-mode/src/index.ts:186-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L186-L195)）
- 服务声明 `static inject = ['tools', 'systemPrompt']`，缺少这两个服务时服务不启动（[packages/plan/plan-mode/src/index.ts:203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L203)）
- 以 `WeakMap<Session, {active, narrate}>` 保存每个会话待生效的一次模式选择（[packages/plan/plan-mode/src/index.ts:213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L213)）
- 构造时以 `resolveConfig` 校验并留存部署提供的指导文本，配置非法则加载即失败（[packages/plan/plan-mode/src/index.ts:216-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L216-L217)）
- 注册 `agent/pre-step` 瀑布监听并先 `await next()` 取得下游决策，再在其之上处理待生效选择（[packages/plan/plan-mode/src/index.ts:223-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L223-L227)）
- 决策为 `reject`、信号已中止或无待生效选择时，原样返回决策不做追加（[packages/plan/plan-mode/src/index.ts:229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L229)）
- 在步骤被接受时调用 `onBoundary` 把待生效模式写入日志；写入抛错则记 warn 并返回未改动的决策，选择保留待下次重试（[packages/plan/plan-mode/src/index.ts:230-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L230-L236)）
- 需要旁白且旁白存在时，把该用户消息追加到决策的 `messages` 尾部，进入本步请求（[packages/plan/plan-mode/src/index.ts:237-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L237-L239)）
- 以 `ctx.effect` 注册释放回调，把 `disposed` 置为真，供评审期间的重载检测使用（[packages/plan/plan-mode/src/index.ts:241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L241)）
- 注册名为 `plan:policy`、序号取自 `FIRST_PARTY_SECTION_ORDER.PLAN_POLICY` 的系统提示段（[packages/plan/plan-mode/src/index.ts:243-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L243-L245)）
- 该段文本在无 agent 上下文时为空串；否则以待生效选择优先、其次日志折叠值决定输出配置的指导文本还是空串（[packages/plan/plan-mode/src/index.ts:246-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L246-L250)）
- 仅当 `sessionProjections` 存在时才注入子上下文并注册 `plan` 投影单元，附带状态 schema 与 `init` 初值（[packages/plan/plan-mode/src/index.ts:261-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L261-L266)）
- 单元 `apply` 在 `command/run` 且命令名为 `plan` 时记录 `running`，参数缺省则不改状态，参数去空后不等于 `off` 即目标为激活（[packages/plan/plan-mode/src/index.ts:267-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L267-L271)）
- 单元 `apply` 在配对的 `command/done` 上清空 `running`，仅当结果为 success 且目标不同于当前 `active` 时把目标留作 `wanted`（[packages/plan/plan-mode/src/index.ts:272-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L272-L277)）
- 单元 `apply` 在 `plan/mode` 上把 `active` 置为事件值并清空 `wanted`（[packages/plan/plan-mode/src/index.ts:278-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L278-L280)）
- 单元 `wire.view` 用 `running?.wanted ?? wanted` 推出 `pending`，仅当其非空且不同于 `active` 时为真（[packages/plan/plan-mode/src/index.ts:283-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L283-L289)）
- 单元声明 `stateVersion: 2`，决定持久化缓存的重放版本（[packages/plan/plan-mode/src/index.ts:290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L290)）
- 仅当 `commands` 存在时注入子上下文并注册 `/plan` 命令，声明提示 `[off|message]` 且接受图片附件（[packages/plan/plan-mode/src/index.ts:295-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L295-L300)）
- `/plan off` 携带图片附件时直接返回错误，不触发任何模式变更（[packages/plan/plan-mode/src/index.ts:301-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L301-L304)）
- `/plan off` 调用 `set(agent, false)` 并按 committed／queued／cancelled 三种结果返回不同的用户可见文本（[packages/plan/plan-mode/src/index.ts:305-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L305-L312)）
- `noop` 分支再折叠一次日志：仍处于激活态时复用"下一步生效"的措辞，否则回"已经不在计划模式"（[packages/plan/plan-mode/src/index.ts:313-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L313-L320)）
- 非 `off` 分支先 `set(agent, true)`，再在有文本或有附件时用 `agent.steer` 投入一条用户消息，附件在前、去空文本块在后（[packages/plan/plan-mode/src/index.ts:322-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L322-L331)）
- 进入分支按 `committed` 与否返回"已开启"或"下一步生效"的用户可见文本（[packages/plan/plan-mode/src/index.ts:332-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L332-L337)）
- 向 `ctx.tools` 注册退出工具，参数为必填字符串 `plan`，注册与计划模式是否激活无关（[packages/plan/plan-mode/src/index.ts:342-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L342-L347)）
- 工具输出 schema 限定为 `additionalProperties: false` 的 `{approved: true}`，并把渲染文本固定为一句确认（[packages/plan/plan-mode/src/index.ts:348-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L348-L357)）
- 执行时无调用 agent 则抛错（[packages/plan/plan-mode/src/index.ts:359-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L359-L360)）
- 执行时折叠日志，未处于计划模式则抛错拒绝调用（[packages/plan/plan-mode/src/index.ts:361-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L361-L363)）
- 以正则要求计划文本去空后以一级 `#` 标题加非空内容开头，否则抛错（[packages/plan/plan-mode/src/index.ts:364-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L364-L366)）
- 以 `ctx.get('userQuestions')` 取交互通道，缺失时抛错并提示改用切换会话模式（[packages/plan/plan-mode/src/index.ts:367-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L367-L370)）
- 向用户发起一道带 header、问题、把计划全文作为 detail、两个带描述选项以及 `plan-review` 呈现意图的提问，并透传执行信号（[packages/plan/plan-mode/src/index.ts:371-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L371-L387)）
- 捕获 `ASK_CANCELLED` 的 `UserQuestionError`，换成"用户已关闭评审改为发言，停在这里等消息"的错误；其他原因原样抛出（[packages/plan/plan-mode/src/index.ts:388-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L388-L399)）
- 评审返回后若服务已被释放则抛错要求重新提交计划（[packages/plan/plan-mode/src/index.ts:400-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L400-L404)）
- 按 id 过滤答案，要求恰好一条、恰好选中 `Approve` 且无自由文本，否则以"继续规划"抛错并回传用户反馈（[packages/plan/plan-mode/src/index.ts:405-412](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L405-L412)）
- 批准后不立即写日志，而是把 `{active: false, narrate: false}` 存入待生效选择并返回 `{approved: true}`（[packages/plan/plan-mode/src/index.ts:413-417](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L413-L417)）
- `presentCall` 用计划首个标题（缺省为 `Plan`）作卡片标题并把计划全文作为内容（[packages/plan/plan-mode/src/index.ts:419-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L419-L424)）
- `presentResult` 以 `Plan review` 为标题回显结果内容（[packages/plan/plan-mode/src/index.ts:425-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L425-L429)）
- `get` 返回日志折叠得到的 `active`，并在存在待生效选择时附带 `pending`（[packages/plan/plan-mode/src/index.ts:440-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L440-L444)）
- `set` 以"待生效选择优先、否则日志折叠值"为目标，目标一致时返回 `noop` 不做任何事（[packages/plan/plan-mode/src/index.ts:462-466](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L462-L466)）
- 有未闭合回合时只写入待生效选择并标记需要旁白，按是否与日志态相同返回 `cancelled` 或 `queued`（[packages/plan/plan-mode/src/index.ts:467-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L467-L470)）
- 无未闭合回合且目标已等于日志态时，仅清掉待生效选择并返回 `cancelled`（[packages/plan/plan-mode/src/index.ts:473-476](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L473-L476)）
- 否则立即 `session.append('plan/mode', {active})`，成功后才删除待生效选择，并在旁白存在时用 `agent.inject` 注入，返回 `committed`（[packages/plan/plan-mode/src/index.ts:477-481](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L477-L481)）
- `onBoundary` 在目标已与日志态相同时只清选择不写日志，否则追加 `plan/mode` 并在写成功后才删除选择（[packages/plan/plan-mode/src/index.ts:485-497](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L485-L497)）
- `narration` 只在存在过请求头且该请求头所处模式与目标不同时才生成一条用户消息，文本按方向二选一，来源标为插件通知并自带 summary（[packages/plan/plan-mode/src/index.ts:500-511](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L500-L511)）
- 默认导出服务类，供 Loader 以服务插件形式装载（[packages/plan/plan-mode/src/index.ts:514](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/index.ts#L514)）

### packages/plan/plan-mode/src/invariant.ts

这是本包的不变量伴生插件，向不变量服务注册对 `plan/mode` 事件载荷的校验。

- 以函数插件形式导出 `name` 与 `inject = ['invariants']`，缺少不变量服务时伴生插件不启动（[packages/plan/plan-mode/src/invariant.ts:9-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/invariant.ts#L9-L12)）
- `validateEvent` 跳过非 `plan/mode` 事件，`active` 不是布尔值时调用 `fail` 并给出含实际值的说明（[packages/plan/plan-mode/src/invariant.ts:20-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/invariant.ts#L20-L26)）
- 安装时先遍历 `ctx.sessions.list()` 中每个会话的全部既有事件做一次校验（[packages/plan/plan-mode/src/invariant.ts:29-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/invariant.ts#L29-L33)）
- 监听全局 `session/created`，对新会话的已有事件再做一次全量校验（[packages/plan/plan-mode/src/invariant.ts:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/invariant.ts#L34)）
- 监听全局 `internal/dispatch`，只对 `session/event` 取出事件参数逐条校验新追加的事件（[packages/plan/plan-mode/src/invariant.ts:35-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/invariant.ts#L35-L39)）
- 安装器附带 `inject: ['sessions']`，缺少会话服务时不安装（[packages/plan/plan-mode/src/invariant.ts:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/invariant.ts#L40)）
- `apply` 用包名向 `ctx.invariants` 注册安装器并返回其 disposer（[packages/plan/plan-mode/src/invariant.ts:47-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/plan/plan-mode/src/invariant.ts#L47-L48)）

### packages/plan/plan-mode/src/types.ts

这是本包唯一的纯类型文件，声明 `PlanProjection` 线上值并把 `plan` 键合并进会话投影映射。

- 无运行期机制

### packages/plan/plan-mode/tsconfig.json

这是本包的 TypeScript 编译配置，声明源码根、输出目录与工作区引用。

- 无运行期机制
