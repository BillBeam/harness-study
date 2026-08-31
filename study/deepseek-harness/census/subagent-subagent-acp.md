---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/subagent-acp
---

# packages/subagent/subagent-acp

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、59 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/subagent-acp/README.md

该包的说明文档，面向选择委派后端、配置子进程命令或排查远程子运行的读者。

- 无运行期机制

### packages/subagent/subagent-acp/package.json

该包的 npm 清单，决定它被解析、发布与依赖钉版的方式。

- 声明 ESM 包并把默认入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/subagent/subagent-acp/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/subagent/subagent-acp/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/package.json#L16-L27)）
- `files` 把发布内容限定为两个运行时产物与类型声明（[packages/subagent/subagent-acp/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/package.json#L28-L32)）
- 运行时依赖把 ACP SDK 钉在 `1.4.0`（[packages/subagent/subagent-acp/package.json:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/package.json#L44-L47)）

### packages/subagent/subagent-acp/src/index.ts

插件入口：声明配置模式、在加载期校验它，并把 ACP 提供者注册到子代理注册表上。

- 插件以具名导出发布 `name` 与 `inject`，注入 `subagents` 与 `subprocess` 两个服务（[packages/subagent/subagent-acp/src/index.ts:23-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L23-L24)）
- 配置模式给出默认值：注册名 `acp`、`command` 必填、`args` 为空数组、`permission` 为 `reject`、`env` 为空字典，以及两个宽限期默认值（[packages/subagent/subagent-acp/src/index.ts:66-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L66-L75)）
- 宽限期必须是正有限数且不超过定时器最大延迟，否则抛出（[packages/subagent/subagent-acp/src/index.ts:78-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L78-L82)）
- 目录判定同时要求 `isDirectory()` 与 `X_OK` 搜索权限（[packages/subagent/subagent-acp/src/index.ts:92-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L92-L103)）
- cwd 必须是绝对路径且是可进入目录，否则在 spawn 之前抛出带来源标签的错误（[packages/subagent/subagent-acp/src/index.ts:114-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L114-L122)）
- 子进程工作目录取配置覆盖，缺省时取 `request.parent.session.header.cwd` 并当场校验，两者都无则抛出（[packages/subagent/subagent-acp/src/index.ts:132-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L132-L139)）
- 提供者广告的五项启动能力全为 `false`（[packages/subagent/subagent-acp/src/index.ts:147-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L147-L153)）
- `inheritsParentContext` 固定为 `false`，父会话内容不跨进程边界（[packages/subagent/subagent-acp/src/index.ts:155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L155)）
- `start` 在信号已中止时直接抛出固定文案，不进入任何启动流程（[packages/subagent/subagent-acp/src/index.ts:160-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L160-L162)）
- cwd 解析失败时把原因收进 Host 日志，对外只抛出固定安全事实的配置失败（[packages/subagent/subagent-acp/src/index.ts:163-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L163-L170)）
- 运行规格把 spawn 绑定到 `ctx.subprocess.spawn`，并把失败回调接到 Host 日志的 warn（[packages/subagent/subagent-acp/src/index.ts:171-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L171-L186)）
- 加载期依次校验两个宽限期、拒绝空字符串 cwd、把相对 cwd 按启动目录 `resolve` 并校验，最后注册提供者（[packages/subagent/subagent-acp/src/index.ts:190-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/index.ts#L190-L205)）

### packages/subagent/subagent-acp/src/invariant.ts

该包的不变量伴生插件，向不变量注册表登记包名。

- 声明伴生插件名并注入 `invariants` 服务（[packages/subagent/subagent-acp/src/invariant.ts:13-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/invariant.ts#L13-L16)）
- 用一个空安装器把包名注册进不变量注册表并返回其 disposer（[packages/subagent/subagent-acp/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/invariant.ts#L21-L29)）

### packages/subagent/subagent-acp/src/run.ts

驱动一个 ACP 子进程完成单次委派的运行实现：spawn、握手、提示、结算、取消与拆除。

- EOF 宽限默认 6000 毫秒（[packages/subagent/subagent-acp/src/run.ts:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L82)）
- 信号升级宽限默认 3000 毫秒（[packages/subagent/subagent-acp/src/run.ts:85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L85)）
- 允许出现在诊断里的工具种类被限制为十个固定字符串的集合（[packages/subagent/subagent-acp/src/run.ts:111-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L111-L114)）
- 失败诊断只由固定字段拼装：provider、stage、category，以及仅在存在时追加的 stop reason、exit code、signal（[packages/subagent/subagent-acp/src/run.ts:117-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L117-L132)）
- 权限诊断只写策略、请求种类与决定三项（[packages/subagent/subagent-acp/src/run.ts:135-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L135-L137)）
- 组合诊断时操作失败行在前、权限行在后，用换行分隔（[packages/subagent/subagent-acp/src/run.ts:140-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L140-L143)）
- 失败错误的 message 只含固定诊断行，原始错误挂在 `cause` 链上（[packages/subagent/subagent-acp/src/run.ts:145-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L145-L153)）
- 配置失败对外统一呈现为 `initialize` / `configuration` 两项事实（[packages/subagent/subagent-acp/src/run.ts:160-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L160-L162)）
- 不在闭集内的工具种类一律折成 `unknown` 再进诊断（[packages/subagent/subagent-acp/src/run.ts:165-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L165-L170)）
- 有界等待整棵进程树退出：起一个定时器 abort 控制器，超时即放弃（[packages/subagent/subagent-acp/src/run.ts:173-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L173-L181)）
- 拆除阶梯：`pid <= 0` 时只吞掉 `done` 的拒绝；否则关 stdin、等 EOF 宽限，未退出再 `terminate()` 并无界等待整棵树退出（[packages/subagent/subagent-acp/src/run.ts:192-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L192-L205)）
- ACP 终止原因映射：`end_turn`→`completed`、`max_tokens`→`max-tokens`、`refusal`→`refusal`、`cancelled`→`aborted`、`max_turn_requests` 与任何未知值→`error`（[packages/subagent/subagent-acp/src/run.ts:213-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L213-L235)）
- 流式内容块只取 `text` 类型的文本，其他块贡献空串（[packages/subagent/subagent-acp/src/run.ts:242-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L242-L244)）
- 送往子进程的提示只保留 `text` 块并保持顺序，非文本块被丢弃（[packages/subagent/subagent-acp/src/run.ts:251-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L251-L257)）
- 向 Host 报告失败时包裹 try，回调自身抛出被吞掉（[packages/subagent/subagent-acp/src/run.ts:269-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L269-L275)）
- 未发布阶段的失败按 `pid <= 0`、有无进程退出事实分成 `process-start`、`transport`、`process-exit` 三类（[packages/subagent/subagent-acp/src/run.ts:278-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L278-L294)）
- 终止原因决定是否附加安全失败行：`end_turn` 不附加，`max_turn_requests` 记 `remote-limit`，三种正常非成功原因只在有权限决定时附权限行，未知原因记 `unknown`（[packages/subagent/subagent-acp/src/run.ts:299-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L299-L319)）
- 启动前信号已中止直接抛出固定文案（[packages/subagent/subagent-acp/src/run.ts:334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L334)）
- 运行 id 在父命名空间用 `randomUUID()` 现铸，不复用远端会话 id（[packages/subagent/subagent-acp/src/run.ts:338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L338)）
- spawn 规格固定为命令加参数、解析后的 cwd、stdin/stdout 管道且 stderr 继承父流、宽限期与显式 env 覆盖层，失败时报告并抛 `process-start`（[packages/subagent/subagent-acp/src/run.ts:344-355](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L344-L355)）
- 缺少任一协议流时直接抛出（[packages/subagent/subagent-acp/src/run.ts:356-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L356-L360)）
- 进程结束事实被记入闭包变量供后续分类使用（[packages/subagent/subagent-acp/src/run.ts:361-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L361-L365)）
- 参与启动竞速的 spawn 失败分支只在拒绝时落定，正常退出臂返回一个永不落定的 Promise（[packages/subagent/subagent-acp/src/run.ts:371-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L371-L376)）
- 观察进程退出事实的等待被 `disposeGraceMs` 超时信号与调用方信号共同封顶，超时则返回当前已知事实（[packages/subagent/subagent-acp/src/run.ts:378-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L378-L397)）
- 启动回滚与发布后的 teardown 共用同一个记忆化的进程拆除（[packages/subagent/subagent-acp/src/run.ts:400-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L400-L401)）
- 用共享的助手输出折叠累积流式文本作为最终输出来源（[packages/subagent/subagent-acp/src/run.ts:405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L405)）
- `session/update` 通知只有 `agent_message_chunk` 被推入输出折叠，思考、工具调用、计划等更新被消费但不外露（[packages/subagent/subagent-acp/src/run.ts:411-419](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L411-L419)）
- 权限请求按配置自动作答：`allow` 时选中第一个 `allow_once` 或 `allow_always` 选项，否则一律回 `cancelled`，并把决定记入最新权限事实（[packages/subagent/subagent-acp/src/run.ts:420-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L420-L441)）
- ACP 客户端通过 ndJSON 流绑定到子进程的 stdin/stdout（[packages/subagent/subagent-acp/src/run.ts:443-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L443-L447)）
- 本地取消置标志并落定取消 Promise，同时尽力向远端发一次 `session/cancel` 通知，其失败被忽略（[packages/subagent/subagent-acp/src/run.ts:454-463](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L454-L463)）
- 请求信号上注册一次性 abort 监听触发本地取消（[packages/subagent/subagent-acp/src/run.ts:464-465](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L464-L465)）
- 启动阶段三方竞速：握手序列、spawn 失败、取消落定；握手先 `initialize` 且客户端能力广告为空对象，再以 cwd 与空 MCP 列表建会话，返回的 sessionId 非字符串时抛 `protocol` 失败（[packages/subagent/subagent-acp/src/run.ts:472-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L472-L496)）
- 启动失败路径摘除 abort 监听、区分「已本地取消」与「失败」、非取消时上报原始错误、随后执行进程拆除（[packages/subagent/subagent-acp/src/run.ts:497-520](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L497-L520)）
- 拆除本身失败时抛 `AggregateError`：取消场景只含清理失败，其他场景含启动失败与清理失败两条（[packages/subagent/subagent-acp/src/run.ts:521-535](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L521-L535)）
- 清理成功后，取消场景抛固定的中止文案，其他场景抛启动失败（[packages/subagent/subagent-acp/src/run.ts:536-540](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L536-L540)）
- 提示阶段与取消 Promise 竞速；成功则映射停止原因并按终止原因生成可选诊断（[packages/subagent/subagent-acp/src/run.ts:548-564](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L548-L564)）
- 提示阶段抛出且未本地取消时，先观察进程退出事实再生成 `transport` 或 `process-exit` 诊断，然后重新抛出（[packages/subagent/subagent-acp/src/run.ts:565-575](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L565-L575)）
- 结算把输出收集、诊断收集、取消判定、错误回调与信号连线交给共享的结算函数（[packages/subagent/subagent-acp/src/run.ts:576-583](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L576-L583)）
- 发布的句柄的 `teardown` 走同一记忆化拆除，失败时上报并抛出带 `teardown` 事实的错误（[packages/subagent/subagent-acp/src/run.ts:585-605](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-acp/src/run.ts#L585-L605)）

### packages/subagent/subagent-acp/tsconfig.json

该包的 TypeScript 编译配置与工作区项目引用清单。

- 无运行期机制
