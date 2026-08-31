---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/subagent
---

# packages/subagent/subagent

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 23 个文件、221 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/subagent/README.md

子代理委派包的英文说明文档，描述服务契约、两种子代理形态、组合方式与模型可见文本，供使用者与维护者阅读。

- 无运行期机制

### packages/subagent/subagent/package.json

该包的 npm 清单，声明模块类型、入口映射、发布文件与对等依赖。

- `"type": "module"` 使该包所有文件按 ESM 解析（[packages/subagent/subagent/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/package.json#L13)）
- `main` / `types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/subagent/subagent/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./client`、`./typert`、`./remote`、`./src/*`、`./package.json` 映射到具体产物，决定外部可导入的子路径（[packages/subagent/subagent/package.json:16-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/package.json#L16-L39)）
- `files` 白名单限定发布产物只含列出的运行时与类型文件（[packages/subagent/subagent/package.json:40-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/package.json#L40-L49)）
- 运行时依赖只有 `zod`，其余能力全部走对等依赖（[packages/subagent/subagent/package.json:51-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/package.json#L51-L73)）
- `peerDependenciesMeta` 把预设、沙箱、持久化、投影、查询、jobs、审批标为可选，允许部署缺席这些包（[packages/subagent/subagent/package.json:75-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/package.json#L75-L103)）

### packages/subagent/subagent/src/activation-setup-registry.ts

可续子代理创建窗口内的部署级能力注册表，被 `SubagentRuntime` 持有、由续行管理器在每次物化子代理时调用。

- `register()` 把贡献登记进注册表，返回的撤销器先置 `removed` 再删除登记，最后释放该贡献的全部已装配实例（[packages/subagent/subagent/src/activation-setup-registry.ts:72-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/activation-setup-registry.ts#L72-L83)）
- `apply()` 遍历当前存活贡献，逐个在子代理未发布的作用域上下文中调用并记录返回的 disposer，同时按贡献与按子上下文双向索引（[packages/subagent/subagent/src/activation-setup-registry.ts:90-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/activation-setup-registry.ts#L90-L111)）
- 安装器在自身记录建立前自撤销时，立即释放这条逃逸记录（[packages/subagent/subagent/src/activation-setup-registry.ts:112-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/activation-setup-registry.ts#L112-L114)）
- 任一安装器抛出时回滚本批全部安装并原样抛出安装失败（[packages/subagent/subagent/src/activation-setup-registry.ts:116-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/activation-setup-registry.ts#L116-L125)）
- 在子上下文上注册 effect，使子作用域销毁时释放它名下的全部安装（[packages/subagent/subagent/src/activation-setup-registry.ts:126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/activation-setup-registry.ts#L126)）
- 返回的 `commit` 在本批被作废时抛出 `ACTIVATION_SETUP_REVOKED`，否则清掉每条安装的事务引用（[packages/subagent/subagent/src/activation-setup-registry.ts:128-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/activation-setup-registry.ts#L128-L138)）
- `releaseAll()` 先释放整批再汇总 disposer 失败，抛出 `ACTIVATION_SETUP_RELEASE_FAILED` 并拼接每条错误链（[packages/subagent/subagent/src/activation-setup-registry.ts:152-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/activation-setup-registry.ts#L152-L167)）
- `release()` 保证一条安装只销毁一次，从两个索引中摘除，并把仍在事务中的批次标记为作废（[packages/subagent/subagent/src/activation-setup-registry.ts:170-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/activation-setup-registry.ts#L170-L182)）

### packages/subagent/subagent/src/assistant-output.ts

子代理最终助手输出的统一选取规则，被各后端运行结果与生命周期终止边共用。

- `push()` 把内容非空的 `assistant/message` 记为候选终答，把 `assistant/chunk` 的 `text-delta` 追加进流式兜底（[packages/subagent/subagent/src/assistant-output.ts:32-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/assistant-output.ts#L32-L39)）
- `pushText()` 只在文本非空时累积，供没有会话事件的传输使用（[packages/subagent/subagent/src/assistant-output.ts:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/assistant-output.ts#L45-L47)）
- `collect()` 优先返回最后一条非空助手消息，否则返回拼接的流式文本，都没有则返回 `undefined`（[packages/subagent/subagent/src/assistant-output.ts:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/assistant-output.ts#L54-L58)）
- `finalAssistantOutput()` 对一段完整的子代理事件后缀跑一遍同一折叠并返回选取结果（[packages/subagent/subagent/src/assistant-output.ts:66-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/assistant-output.ts#L66-L74)）

### packages/subagent/subagent/src/child-agent.ts

进程内子代理组合的共用构件：深度预算、持久化元数据、子代理选项解析、委派策略种子与作用域内组合，被一次性提供方驱动与续行管理器共同调用。

- `resolveChildDepth()` 把子深度定为父深度加一，越出安全整数抛 `RangeError`，超过 `maxDepth` 抛 `SubagentDepthError`（[packages/subagent/subagent/src/child-agent.ts:49-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L49-L58)）
- `SubagentDepthError` 携带尝试深度与上限并固定 `name`（[packages/subagent/subagent/src/child-agent.ts:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L32-L37)）
- `parentAgentOptionsForDelegation()` 用父代理最近一次请求头里的 provider/model/reasoningEffort 覆盖创建期的同名字段，无请求头时原样返回创建选项（[packages/subagent/subagent/src/child-agent.ts:68-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L68-L85)）
- `resolveChildAgentOptions()` 以父路由与 `maxTokens` 打底、请求覆盖在上，并强制写入子代理自己的 `subagentDepth`（[packages/subagent/subagent/src/child-agent.ts:98-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L98-L115)）
- 路由发生变化且请求未显式给出 effort 时删除继承来的 `reasoningEffort`（[packages/subagent/subagent/src/child-agent.ts:116-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L116-L117)）
- `childSessionMeta()` 写入父工作目录、从父存活作用域取到的组合预设、`parentSession` 血缘、`origin: 'subagent'`、持久化的 `delegationDepth` 与非零 `seedLength`（[packages/subagent/subagent/src/child-agent.ts:138-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L138-L156)）
- `SUBAGENT_DELEGATION_CONTEXT` 固定了每个进程内子代理都会看到的委派范围声明文本（[packages/subagent/subagent/src/child-agent.ts:171-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L171-L175)）
- `applyChildComposition()` 先把子上下文并入父代理的预设组合，再以 order 120 注册委派声明的运行时上下文条目（[packages/subagent/subagent/src/child-agent.ts:204-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L204-L206)）
- 该函数随后按需注册遮蔽部署人设的 `deployment:persona` 段并施加子代理专属的工具限制（[packages/subagent/subagent/src/child-agent.ts:207-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L207-L210)）
- `captureDelegatedPolicyOverrides()` 取父会话的显式沙箱覆盖，并在审批能力存在时把审批策略钉为 `'never'`（[packages/subagent/subagent/src/child-agent.ts:235-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L235-L240)）
- `appendDelegatedPolicyOverrides()` 把捕获到的策略以 `source: 'delegation'` 追加成子会话自己的 `sandbox/mode` 与 `approval/policy` 事件（[packages/subagent/subagent/src/child-agent.ts:251-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/child-agent.ts#L251-L261)）

### packages/subagent/subagent/src/client.ts

浏览器侧可用的子代理投影与控制词汇入口，只做类型再导出。

- 无运行期机制

### packages/subagent/subagent/src/continuation.ts

可续子代理的内部管理器：稳定子 id、描述符持久化、驻留准入、存活所有权图、冷恢复、子先销毁与向父代理投递结算通知，位于 `ctx.subagents` 之后。

- `settlementSummary()` 按停止原因给出父代理会看到的结算首句，未知原因归入异常结束（[packages/subagent/subagent/src/continuation.ts:298-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L298-L319)）
- `ChildLock.run()` 按子代理 id 串行化投递、释放与销毁，并吞掉链尾异常以免波及后来者（[packages/subagent/subagent/src/continuation.ts:336-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L336-L347)）
- 构造器建立私有的 activationOwner 插件作用域，监听 `agent/disposed` 清理关停记录，并先注册作用域销毁再注册 drain，使反序回卷时 drain 先于作用域释放（[packages/subagent/subagent/src/continuation.ts:384-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L384-L392)）
- `startContinuable()` 先检查准入、要求持久化服务、校验 `maxDepth`、分配或采用调用方给的子 id 并确认该 id 未被占用（[packages/subagent/subagent/src/continuation.ts:411-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L411-L418)）
- 该方法在首个 await 前快照描述符，把解析出的子 provider/model/effort、人设与工具过滤一起写入（[packages/subagent/subagent/src/continuation.ts:421-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L421-L434)）
- 同样在首个 await 前捕获父会话的委派策略（[packages/subagent/subagent/src/continuation.ts:436-437](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L436-L437)）
- 向宿主要来 provider 的可续创建规格后再次检查中止与准入（[packages/subagent/subagent/src/continuation.ts:439-445](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L439-L445)）
- 用 provider 提供的种子加描述符事件拼出子会话初始日志（[packages/subagent/subagent/src/continuation.ts:447-448](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L447-L448)）
- 调用方自带子 id 时在锁内扫描已持久化快照，命中则以 `DUPLICATE_CHILD` 拒绝（[packages/subagent/subagent/src/continuation.ts:453-461](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L453-L461)）
- 锁内物化子代理并提交初始提示，成功后返回稳定子 id 与被接收消息 id（[packages/subagent/subagent/src/continuation.ts:462-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L462-L479)）
- `assertChildIdAvailable()` 在存活 Agent 或会话存储已占用该 id 时抛 `DUPLICATE_CHILD`（[packages/subagent/subagent/src/continuation.ts:483-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L483-L487)）
- `followup()` 在锁内按驻留状态分流：无驻留则冷恢复，销毁事务已开则等待释放后重试，否则直接进入已准入提交（[packages/subagent/subagent/src/continuation.ts:512-535](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L512-L535)）
- `interrupt()` 在祖先授权下要求调用方是注册表中的同一对象且不能中断自己，否则抛 `UNAUTHORIZED`（[packages/subagent/subagent/src/continuation.ts:559-575](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L559-L575)）
- 目标不驻留时直接按已接受的空操作返回（[packages/subagent/subagent/src/continuation.ts:576-577](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L576-L577)）
- 用户授权要求持久化头里的父会话与所报地址一致，祖先授权要求目标的存活血缘含调用方，否则抛 `UNAUTHORIZED`（[packages/subagent/subagent/src/continuation.ts:578-590](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L578-L590)）
- 通过授权后对目标发出 `cancel(..., { keepInbox: true })`，已在销毁中的目标不再重复取消（[packages/subagent/subagent/src/continuation.ts:591-597](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L591-L597)）
- `reportFrom()` 在同一无 await 段内完成中止检查、准入检查、发送方授权、父代理解析与投递（[packages/subagent/subagent/src/continuation.ts:613-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L613-L623)）
- `authorizeReporter()` 只承认某个驻留 Activation 的同一 Agent 对象，且拒绝已开始销毁的 Activation（[packages/subagent/subagent/src/continuation.ts:626-643](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L626-L643)）
- `resolveReportParent()` 从子会话头的 `parentSession` 找存活父代理，找不到抛 `PARENT_UNAVAILABLE`（[packages/subagent/subagent/src/continuation.ts:646-657](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L646-L657)）
- `deliverReport()` 把子内容包进以“Background subagent <id> reported:”开头、`subagent-report` 归属的用户消息，`next-step` 走唤醒记账后 steer，否则直接 inject（[packages/subagent/subagent/src/continuation.ts:660-683](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L660-L683)）
- `sendWaking()` 在父代理自身也有 Activation 时，把这次唤醒消息计入父 Activation 的待清账（[packages/subagent/subagent/src/continuation.ts:694-705](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L694-L705)）
- `sendReport()` 按投递策略选择 `steer` 或 `inject`，并把父代理侧的拒绝翻译成 `PARENT_UNAVAILABLE`（[packages/subagent/subagent/src/continuation.ts:708-723](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L708-L723)）
- `drain()` 先同步关闭准入，等待所有在途物化落定，再按“无人拥有”筛出森林根并逐根销毁（[packages/subagent/subagent/src/continuation.ts:734-748](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L734-L748)）
- `drainDescendants()` 只对给定存活根发布局部准入截断，并把根、目标 Agent 及其存活血缘登记进关停成员集（[packages/subagent/subagent/src/continuation.ts:759-792](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L759-L792)）
- 该方法在等待物化屏障之前就同步打开所有选中 Activation 的销毁事务，使取消自上而下传播而释放仍自下而上（[packages/subagent/subagent/src/continuation.ts:794-809](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L794-L809)）
- `drainChildren()` 要求调用方是注册表中的同一父对象，且每个驻留目标必须是其直接子，否则抛 `UNAUTHORIZED`（[packages/subagent/subagent/src/continuation.ts:822-837](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L822-L837)）
- `disposeRoots()` 并行销毁各根、收集全部失败，最后抛出 `ACTIVATION_TEARDOWN_FAILED` 汇总（[packages/subagent/subagent/src/continuation.ts:849-869](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L849-L869)）
- `liveLineage()` 沿持久化头的 `parentSession` 向上收集注册表当前存活的祖先并防环（[packages/subagent/subagent/src/continuation.ts:885-897](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L885-L897)）
- `closingTeardownFor()` 与 `assertAdmitting()` 把整体 drain 或所在树的关停翻译成 `DRAINING` 拒绝（[packages/subagent/subagent/src/continuation.ts:906-925](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L906-L925)）
- `stateOf()` 从 Agent 状态、已接收未出队消息与在册子代理集合推出 `running`/`waiting`/`settled`（[packages/subagent/subagent/src/continuation.ts:936-940](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L936-L940)）
- `coldResume()` 通过会话查询观测持久化子会话，读取失败一律折成 `NOT_RESUMABLE`（[packages/subagent/subagent/src/continuation.ts:955-964](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L955-L964)）
- 冷恢复在折叠前先用持久化头的父会话做血缘授权，并只折叠 `seedLength` 之后的自有后缀（[packages/subagent/subagent/src/continuation.ts:965-975](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L965-L975)）
- 描述符缺失或不是 `continuable` 时抛出带“不要再用这个 id 重试”的 `NOT_RESUMABLE`（[packages/subagent/subagent/src/continuation.ts:976-982](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L976-L982)）
- 冷恢复只用描述符里的 provider/model/effort、人设与工具过滤重建子代理选项与组合（[packages/subagent/subagent/src/continuation.ts:983-1004](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L983-L1004)）
- `submitMaterialized()` 在提交失败时销毁刚物化的 Activation 再抛出原错误（[packages/subagent/subagent/src/continuation.ts:1016-1031](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1016-L1031)）
- `materialize()` 在物化前登记一条带父血缘的物化记录作为 drain 屏障，结束时无论成败都注销（[packages/subagent/subagent/src/continuation.ts:1039-1052](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1039-L1052)）
- 物化的 setup 闭包只在全新创建时向子日志追加委派策略事件，再施加子组合并叠加注册表贡献（[packages/subagent/subagent/src/continuation.ts:1069-1078](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1069-L1078)）
- 按有无创建输入分别走 `agents.resume()` 或 `agents.create()`，句柄由私有 owner 作用域持有（[packages/subagent/subagent/src/continuation.ts:1082-1096](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1082-L1096)）
- 新建的 Activation 记录持久父会话、provider、句柄、以弱集合保存的存活血缘、在册子集合、待清账消息集与唤醒信号（[packages/subagent/subagent/src/continuation.ts:1098-1116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1098-L1116)）
- 句柄转移后重新校验中止与准入，并把子代理登记进父 Activation 的在册集合（[packages/subagent/subagent/src/continuation.ts:1117-1120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1117-L1120)）
- 在子代理自己的作用域上监听 `agent/inbox/claimed` 与 `agent/inbox/discarded`，出队即销账并唤醒结算观察者（[packages/subagent/subagent/src/continuation.ts:1126-1133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1126-L1133)）
- 在任何一轮开始前发布生命周期起始边；这段发生异常则回滚未发布的 Activation 并抛出（[packages/subagent/subagent/src/continuation.ts:1134-1146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1134-L1146)）
- 物化成功后启动结算观察循环（[packages/subagent/subagent/src/continuation.ts:1147-1148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1147-L1148)）
- `rollbackUnpublished()` 以同一记忆化事务销毁句柄，并在其落定后才从存活表移除并释放父所有权（[packages/subagent/subagent/src/continuation.ts:1156-1165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1156-L1165)）
- `acquireOwnership()` 把子 id 加进父 Activation 的在册集合，父已进入销毁时抛 `ACTIVATION_CLOSING`（[packages/subagent/subagent/src/continuation.ts:1173-1183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1173-L1183)）
- `releaseOwnership()` 从持有者集合中摘除子 id 并唤醒该持有者重新判定结算（[packages/subagent/subagent/src/continuation.ts:1186-1190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1186-L1190)）
- `submit()` 先建立父所有权再把内容作为用户消息送入子代理收件箱，接收成功后置 `announced`（[packages/subagent/subagent/src/continuation.ts:1203-1220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1203-L1220)）
- `admitWaking()` 在同步发送之前先登记消息 id，发送抛出则回滚登记，成功则唤醒结算观察者（[packages/subagent/subagent/src/continuation.ts:1229-1247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1229-L1247)）
- `submitAdmitted()` 在无 await 的最后一段依次检查中止、准入、销毁事务与父血缘授权，然后才提交（[packages/subagent/subagent/src/continuation.ts:1254-1277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1254-L1277)）
- `authorizeLineage()` 要求调用方是注册表当前的同一父对象，且子代理持久父会话恰是它（[packages/subagent/subagent/src/continuation.ts:1284-1298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1284-L1298)）
- `watchSettlement()` 循环竞速 `whenIdle()` 与唤醒信号，在子锁内复核 `settled` 并在同一临界区开启销毁，失败只记日志（[packages/subagent/subagent/src/continuation.ts:1306-1341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1306-L1341)）
- `dispose()` 同步安装记忆化的销毁事务，使准入截断先于任何异步动作生效（[packages/subagent/subagent/src/continuation.ts:1354-1363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1354-L1363)）
- `finishDisposal()` 在首个 await 前自上而下取消目标 Agent，并对其在册子代理递归开启销毁（[packages/subagent/subagent/src/continuation.ts:1370-1380](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1370-L1380)）
- 释放顺序保持子先父后：先等全部子销毁、再等静默、再尽力刷盘、再在子仍注册时抓取终止事实（[packages/subagent/subagent/src/continuation.ts:1382-1414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1382-L1414)）
- 句柄销毁失败与前述失败合并成一条或聚合的 `ACTIVATION_TEARDOWN_FAILED`（[packages/subagent/subagent/src/continuation.ts:1415-1435](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1415-L1435)）
- 直到销毁落定才从存活表移除该 Activation，随后在释放父所有权之前投递结算通知（[packages/subagent/subagent/src/continuation.ts:1436-1448](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1436-L1448)）
- 已知销毁结果后才发布终止边，失败时最终抛出（[packages/subagent/subagent/src/continuation.ts:1449-1452](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1449-L1452)）
- `notifySettlement()` 只对曾被接收过消息的子代理发通知，父代理不存活时静默返回（[packages/subagent/subagent/src/continuation.ts:1473-1477](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1473-L1477)）
- 通知消息由结算首句加“Its closing message:”与终止输出组成，无输出时改为“It left no closing message.”，并带 `subagent-settled` 归属与截断摘要（[packages/subagent/subagent/src/continuation.ts:1478-1492](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1478-L1492)）
- 父代理自身已在关停中时只 `inject` 不唤醒；否则空闲父走 `followup` 起一轮、繁忙父走 `steer` 并入下一步（[packages/subagent/subagent/src/continuation.ts:1493-1515](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1493-L1515)）
- 通知投递失败只记警告，不阻塞销毁（[packages/subagent/subagent/src/continuation.ts:1516-1521](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1516-L1521)）
- `flushFinalState()` 请求子会话的尽力刷盘，失败只记警告说明恢复时可能读到陈旧状态（[packages/subagent/subagent/src/continuation.ts:1530-1540](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1530-L1540)）
- 缺少会话持久化或会话查询服务时分别抛 `PERSISTENCE_UNAVAILABLE` 与 `CONTINUATION_UNAVAILABLE`（[packages/subagent/subagent/src/continuation.ts:1543-1564](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/continuation.ts#L1543-L1564)）

### packages/subagent/subagent/src/control-types.ts

浏览器可用的子代理目录行、控制请求、回执与失败码的类型声明，被控制装配与客户端共用。

- 无运行期机制

### packages/subagent/subagent/src/control.ts

浏览器控制面的装配：目录视图采样、浏览器时区校验与远端失败码翻译，被 `SubagentRuntime` 的远端方法调用。

- 时区正则与三个控制方法的 zod 载荷模式定义了线上边界接受的字段（[packages/subagent/subagent/src/control.ts:19-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/control.ts#L19-L34)）
- `canonicalClientTimeZone()` 拒绝空串、带空白或非 IANA 形状的值，再用 `Intl` 规范化，异常时返回 `undefined`（[packages/subagent/subagent/src/control.ts:41-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/control.ts#L41-L54)）
- `rejectControl()` 以稳定 code、消息与详情抛出 `TypertRemoteFailure`（[packages/subagent/subagent/src/control.ts:64-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/control.ts#L64-L70)）
- `validateControlRequest()` 校验失败时以 `bad-request` 连同原始 zod issues 拒绝（[packages/subagent/subagent/src/control.ts:79-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/control.ts#L79-L89)）
- `catalogView()` 用存活 Agent 驱动的状态覆盖每行的 `activity`，并报出父代理是否存活（[packages/subagent/subagent/src/control.ts:101-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/control.ts#L101-L113)）
- `rejectCatalogRead()` 把取消、缺投影注册表与其他失败分别映射为 `cancelled`、`subagent-projections-unavailable`、`internal`（[packages/subagent/subagent/src/control.ts:123-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/control.ts#L123-L135)）
- `rejectPrompt()` 只把 `NOT_RESUMABLE`、`UNAUTHORIZED` 与四个准入类错误码翻译成对应的调用方可见码，其余归 `internal`（[packages/subagent/subagent/src/control.ts:147-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/control.ts#L147-L176)）
- `isCancellation()` 以信号已中止或 `CANCELLED` 码判定取消（[packages/subagent/subagent/src/control.ts:178-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/control.ts#L178-L180)）

### packages/subagent/subagent/src/depth.ts

委派深度的核算工具，被子代理组合与服务入口共用。

- `delegationDepthOf()` 校验运行期 `subagentDepth` 必须是非负安全整数，否则抛 `TypeError`（[packages/subagent/subagent/src/depth.ts:29-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/depth.ts#L29-L32)）
- 该函数取持久化头深度与运行期深度的较大值，使恢复后的子代理不会退回顶层（[packages/subagent/subagent/src/depth.ts:33-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/depth.ts#L33-L36)）
- `assertSubagentMaxDepth()` 拒绝非数字、非安全整数、负数与 `-0` 的递归上限（[packages/subagent/subagent/src/depth.ts:42-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/depth.ts#L42-L51)）

### packages/subagent/subagent/src/descriptor-seed.ts

可续子代理创建种子的构造函数，被续行管理器在启动前调用。

- `seedDescriptorTurn()` 以子 id 与继承前缀暂存一个会话，追加 `subagent/descriptor` 事件后导出完整的从零号序连续的种子事件（[packages/subagent/subagent/src/descriptor-seed.ts:23-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor-seed.ts#L23-L31)）

### packages/subagent/subagent/src/descriptor.ts

持久化的子代理描述符：版本化、模型不可见的 `subagent/descriptor` 会话事件的快照与折叠实现，被各 provider 与冷恢复路径使用。

- `SUBAGENT_DESCRIPTOR_VERSION` 固定为 3，写入每条描述符事件并在折叠时逐字要求（[packages/subagent/subagent/src/descriptor.ts:48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor.ts#L48)）
- 两组字段白名单与工具过滤白名单限定了每种模式允许出现的键（[packages/subagent/subagent/src/descriptor.ts:130-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor.ts#L130-L145)）
- `assertKnownKeys()` 在持久化记录出现声明外字段时抛错（[packages/subagent/subagent/src/descriptor.ts:153-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor.ts#L153-L158)）
- `optionalString()` 与 `optionalStringArray()` 对可选字段做类型校验并在不符时抛错（[packages/subagent/subagent/src/descriptor.ts:161-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor.ts#L161-L182)）
- `parseToolFilter()` 要求工具过滤是对象、键在白名单内且至少声明 `allow` 或 `deny` 之一（[packages/subagent/subagent/src/descriptor.ts:185-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor.ts#L185-L199)）
- `parseSubagentDescriptor()` 对版本号不等于当前版本的载荷返回 `undefined`，使该子代理无法被本运行时分类（[packages/subagent/subagent/src/descriptor.ts:202-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor.ts#L202-L210)）
- 该函数校验 `mode` 取值、按模式套用对应键白名单、校验 `provider`，并分别重建一次性与可续两种载荷（[packages/subagent/subagent/src/descriptor.ts:212-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor.ts#L212-L256)）
- `snapshotSubagentDescriptor()` 按模式装配版本化载荷，并要求它能无损 JSON 化，否则抛错（[packages/subagent/subagent/src/descriptor.ts:279-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor.ts#L279-L303)）
- `foldSubagentDescriptor()` 取日志中第一条 `subagent/descriptor` 事件为准，后续同类事件无法改写已声明的组合（[packages/subagent/subagent/src/descriptor.ts:317-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/descriptor.ts#L317-L323)）

### packages/subagent/subagent/src/error.ts

子代理服务与 provider 共用的类型化失败类。

- `SubagentError` 把 code 交给基类并把 `name` 固定为 `'SubagentError'`，成为各调用方按码分流的依据（[packages/subagent/subagent/src/error.ts:10-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/error.ts#L10-L15)）

### packages/subagent/subagent/src/index.ts

子代理能力接缝的服务定义（`ctx.subagents`）：命名 provider 注册表、一次性启动 API、可续子代理操作与浏览器远端方法。

- `SubagentRuntime` 继承远端服务基类并以 `'subagents'` 名注册进上下文（[packages/subagent/subagent/src/index.ts:196-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L196-L209)）
- 构造器建立以本服务实例为作用域载体的生命周期发射器（[packages/subagent/subagent/src/index.ts:210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L210)）
- 注入 `agents` 后才建立续行管理器，并在该注入纤程销毁时清空槽位（[packages/subagent/subagent/src/index.ts:211-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L211-L221)）
- 注入 `sessionProjections` 后注册计时与身份两个会话投影定义（[packages/subagent/subagent/src/index.ts:222-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L222-L225)）
- `startContinuable()`、`followup()`、`reportFrom()` 转发到续行管理器，缺管理器时先失败（[packages/subagent/subagent/src/index.ts:237-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L237-L301)）
- `interrupt()` 在没有续行管理器的组合下是被接受的空操作（[packages/subagent/subagent/src/index.ts:280-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L280-L282)）
- `registerContinuableSetup()` 以 Cordis effect 登记子作用域安装器并返回其 disposer（[packages/subagent/subagent/src/index.ts:311-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L311-L317)）
- `drainContinuableDescendants()` 与 `drainContinuableChildren()` 在无管理器时直接返回，否则委派给对应的作用域化清理（[packages/subagent/subagent/src/index.ts:329-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L329-L350)）
- `listChildren()` 与 `listDescendants()` 在不加载或恢复任何 Agent 的前提下枚举直接子与整棵后代树（[packages/subagent/subagent/src/index.ts:369-390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L369-L390)）
- 远端 `list` 先校验载荷，再把持久化列表叠上存活状态形成目录视图，失败走目录读取拒绝映射（[packages/subagent/subagent/src/index.ts:405-413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L405-L413)）
- 远端 `prompt` 校验载荷、规范化浏览器时区（不合法则 `invalid-time-zone`）、要求父会话存活（否则 `subagent-parent-unavailable`）（[packages/subagent/subagent/src/index.ts:430-450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L430-L450)）
- 该方法把调用方铸造的 `rpcId` 与规范时区作为消息归属随投递写入，并把失败翻译成控制码（[packages/subagent/subagent/src/index.ts:451-461](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L451-L461)）
- 远端 `interruptByParent` 只走核心中断原语，`UNAUTHORIZED` 映射为 `subagent-unauthorized`，其余为 `internal`，成功返回已受理回执（[packages/subagent/subagent/src/index.ts:479-498](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L479-L498)）
- `registerProvider()` 以 effect 注册，重名抛 `DUPLICATE_PROVIDER`，回卷时删除并发 `subagent/provider-removed`，注册成功后发 `subagent/provider-added`（[packages/subagent/subagent/src/index.ts:507-523](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L507-L523)）
- `getProvider()` 与 `list()` 分别按名查找与按插入序列出已注册 provider（[packages/subagent/subagent/src/index.ts:530-540](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L530-L540)）
- `start()` 依次做 provider 解析、能力校验、`maxDepth` 校验与 `outputSchema` 的对象 JSON Schema 断言（[packages/subagent/subagent/src/index.ts:552-556](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L552-L556)）
- 该方法快照一次性描述符并随请求下发，再用生命周期观察包住 provider 返回的运行（[packages/subagent/subagent/src/index.ts:557-563](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L557-L563)）
- `prepareContinuable()` 以 provider 是否实现该方法作为可续能力判据，缺失则抛 `UNSUPPORTED_CAPABILITY`（[packages/subagent/subagent/src/index.ts:571-584](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L571-L584)）
- `expectProvider()` 与 `requireContinuations()` 分别以 `NO_PROVIDER` 与 `CONTINUATION_UNAVAILABLE` 显式失败（[packages/subagent/subagent/src/index.ts:587-604](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L587-L604)）
- `observeActivation()` 为一次驻留纪元构造生命周期观察者（[packages/subagent/subagent/src/index.ts:610-616](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L610-L616)）
- `assertCapabilities()` 对 `agentOptions`、`outputSchema`、`depthLimit`、`toolFilter`、`persona` 五项逐一比对 provider 声明，缺一即拒（[packages/subagent/subagent/src/index.ts:619-635](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/index.ts#L619-L635)）

### packages/subagent/subagent/src/invariant.ts

该包自有的运行期不变量伴生插件，注册到不变量服务后监听子代理注册与生命周期事件。

- 导出 `name` 与 `inject`，使该伴生插件在 `invariants` 服务就绪后才装配（[packages/subagent/subagent/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/invariant.ts#L10-L12)）
- `validateRunEnd()` 在终止载荷的 provider、子 id 或 local 与起始边不一致时报失败（[packages/subagent/subagent/src/invariant.ts:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/invariant.ts#L15-L19)）
- 安装器以当前已注册 provider 名单为初始状态（[packages/subagent/subagent/src/invariant.ts:23-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/invariant.ts#L23-L24)）
- 全局 `internal/dispatch` 监听在派发前校验 provider 名非空、不重复注册、不移除未知 provider（[packages/subagent/subagent/src/invariant.ts:30-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/invariant.ts#L30-L43)）
- 同一监听校验 `subagent/start` 的 provider、runId、子 id 非空且 runId 不重复（[packages/subagent/subagent/src/invariant.ts:44-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/invariant.ts#L44-L55)）
- 同一监听要求每个 `subagent/end` 都有配对的起始边并校验身份一致（[packages/subagent/subagent/src/invariant.ts:56-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/invariant.ts#L56-L62)）
- 四个正式事件监听只在暂存命中时提交状态变更，使 provider 名单与在跑 run 表随事件推进（[packages/subagent/subagent/src/invariant.ts:64-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/invariant.ts#L64-L83)）
- `apply()` 以包名把该安装器注册进不变量服务并返回其 disposer（[packages/subagent/subagent/src/invariant.ts:91-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/invariant.ts#L91-L92)）

### packages/subagent/subagent/src/lifecycle.ts

两种子代理形态的生命周期边发布实现：受控发射器、一次性运行观察与可续驻留纪元观察，被服务入口与续行管理器使用。

- `createLifecycleEmitter()` 在有父代理时把作用域载体放在派发参数首位，从而做作用域过滤分发（[packages/subagent/subagent/src/lifecycle.ts:104-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L104-L112)）
- 该发射器对每个监听器单独兜底：同步抛出与返回的 promise 拒绝都只记警告，不影响其他监听器（[packages/subagent/subagent/src/lifecycle.ts:112-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L112-L122)）
- `observeRun()` 铸造 runId 并记录 provider、子 id 与是否本地（[packages/subagent/subagent/src/lifecycle.ts:139-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L139-L144)）
- 该函数先挂上结果回调再同步发起始边，成功时带停止原因、输出为空则省略 `lastAssistantMessage`，拒绝时按 `error` 收尾（[packages/subagent/subagent/src/lifecycle.ts:145-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L145-L161)）
- `createActivationObserver()` 把可续纪元也标为 `local: true` 的一次运行身份（[packages/subagent/subagent/src/lifecycle.ts:181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L181)）
- `start()` 以当前子会话事件数作为本纪元边界并发出起始边，使冷恢复后的遥测只覆盖本纪元后缀（[packages/subagent/subagent/src/lifecycle.ts:195-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L195-L198)）
- `capture()` 在子代理尚存活时切出本纪元后缀，算出终答输出与停止原因（[packages/subagent/subagent/src/lifecycle.ts:199-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L199-L206)）
- `terminal()` 在有拆卸失败时以 `error` 覆盖本纪元结果并扣下输出（[packages/subagent/subagent/src/lifecycle.ts:191-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L191-L193)）
- `settle()` 用同一份终止事实发出终止边，无输出时省略 `lastAssistantMessage`（[packages/subagent/subagent/src/lifecycle.ts:208-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L208-L215)）
- `epochStopReason()` 折叠已消费工作，把轮次结束原因映射为 `max-tokens`／`aborted`／`error`／`refusal`，未知变体归 `error`（[packages/subagent/subagent/src/lifecycle.ts:235-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L235-L259)）
- 干净结束或根本没有记账轮次时，若存在被丢弃的未跑工作则报 `aborted`，否则报 `completed`（[packages/subagent/subagent/src/lifecycle.ts:251-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L251-L253)）
- `renderThrown()` 在字符串化本身抛出时退回固定占位文本（[packages/subagent/subagent/src/lifecycle.ts:263-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/lifecycle.ts#L263-L269)）

### packages/subagent/subagent/src/list-children.ts

子代理包内枚举一个父会话的直接子会话与整棵后代树的只读模块，由 `SubagentRuntime.listChildren` / `listDescendants` 对外暴露。

- 冷读并发上限固定为 4，限制一次列举中同时进行的持久化观察数（[packages/subagent/subagent/src/list-children.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L35)）
- `listChildren` 从语料中筛出 `parentSession` 等于入参且 `origin === 'subagent'` 的记录，排序后解析，再丢掉解析为 `undefined` 的项（[packages/subagent/subagent/src/list-children.ts:81-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L81-L93)）
- `listDescendants` 对定位后的后代逐个取行，并把 `parentId` 与 `depth` 附加到每条结果上（[packages/subagent/subagent/src/list-children.ts:108-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L108-L128)）
- 投影注册表缺失时以 `SUBAGENT_CONTROL_PROJECTIONS_UNAVAILABLE` 抛出，在任何读取之前（[packages/subagent/subagent/src/list-children.ts:135-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L135-L144)）
- 会话存储用 `ctx.get('sessions')` 严格全局读取，缺失时以 `SUBAGENT_CONTROL_SESSION_STORE_UNAVAILABLE` 抛出（[packages/subagent/subagent/src/list-children.ts:148-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L148-L154)）
- 查询服务缺失时以 `SUBAGENT_CONTROL_QUERY_UNAVAILABLE` 抛出（[packages/subagent/subagent/src/list-children.ts:156-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L156-L162)）
- 投影缓存服务用可选读取，缺失不报错也不阻断列举（[packages/subagent/subagent/src/list-children.ts:166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L166)）
- `query.listSessions` 的调用被包在 try 中，抛出前后各做一次取消检查（[packages/subagent/subagent/src/list-children.ts:167-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L167-L174)）
- 语料按 id 合并：同 id 有活会话时用活会话的 header，否则用查询返回的 header（[packages/subagent/subagent/src/list-children.ts:177-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L177-L184)）
- 扫一遍语料收集所有作为子代理父节点出现过的 id，供 `hasChildren` 使用（[packages/subagent/subagent/src/list-children.ts:185-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L185-L190)）
- 活着的候选只快照 `subagent` 一个投影单元；快照抛出时把该行替换为 `reason: 'corrupt'` 的诊断行而不中断整次列举（[packages/subagent/subagent/src/list-children.ts:203-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L203-L219)）
- 身份为 `undefined`/`null` 或 `seq` 小于 `seedLength` 时该行留空，最终被过滤出结果（[packages/subagent/subagent/src/list-children.ts:222-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L222-L224)）
- 冷候选放进共享队列，由至多 4 个并发工作协程逐个取出解析（[packages/subagent/subagent/src/list-children.ts:228-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L228-L241)）
- 全部行解析完后再做一次取消检查（[packages/subagent/subagent/src/list-children.ts:242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L242)）
- 后代定位用父到子的索引加显式栈做前序遍历，`visited` 集合阻断重复与环，只有 `origin === 'subagent'` 的节点进入结果而非子代理节点仍继续下探（[packages/subagent/subagent/src/list-children.ts:247-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L247-L280)）
- 同级排序先按 `createdAt`，相同再按 id 字典序（[packages/subagent/subagent/src/list-children.ts:283-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L283-L285)）
- 冷读先查投影缓存，缓存读取抛出时吞掉并按未命中继续（[packages/subagent/subagent/src/list-children.ts:304-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L304-L313)）
- 缓存值非空且 `seq >= seedLength` 时直接产出 `activity: 'inactive'` 的行，否则落到权威重折叠（[packages/subagent/subagent/src/list-children.ts:322-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L322-L324)）
- 进入观察前再检查一次取消（[packages/subagent/subagent/src/list-children.ts:326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L326)）
- `observeSession` 抛出时按错误码分流：`SESSION_QUERY_CORRUPT_SESSION` / `SESSION_QUERY_SOURCE_CONFLICT` 记 `corrupt`，其余记 `unavailable`，列举本身仍成功（[packages/subagent/subagent/src/list-children.ts:329-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L329-L344)）
- 观察结果用 `using` 绑定，函数返回时释放（[packages/subagent/subagent/src/list-children.ts:345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L345)）
- 读到的 header 与枚举时的 header 生命周期不一致时记 `corrupt`，不进入列表（[packages/subagent/subagent/src/list-children.ts:350-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L350-L352)）
- 重折叠后身份缺失或 `seq` 低于 `seedLength` 时记 `corrupt`（[packages/subagent/subagent/src/list-children.ts:353-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L353-L357)）
- 行构造按模式分叉：`one-shot` 的 `label` 仅在存在时写入，`continuable` 必带 `label`，两者都带 `activity` 与 `hasChildren`（[packages/subagent/subagent/src/list-children.ts:362-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L362-L385)）
- 生命周期比对固定为 9 个 header 字段的全等（[packages/subagent/subagent/src/list-children.ts:388-396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L388-L396)）
- 取消检查点统一抛 `CANCELLED` 码的错误（[packages/subagent/subagent/src/list-children.ts:399-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/list-children.ts#L399-L403)）

### packages/subagent/subagent/src/out-of-process.ts

供跨进程子代理后端复用的公共件：能力广告、配置校验、子进程工作目录解析、结果结算与运行句柄发布。

- 诊断文本的字节上限固定为 4096 UTF-8 字节（[packages/subagent/subagent/src/out-of-process.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L20)）
- 超限诊断按字节截断并回退到 UTF-8 字符边界，再追加固定的截断标记（[packages/subagent/subagent/src/out-of-process.ts:31-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L31-L42)）
- 结果中带 `diagnostic` 时替换为限长后的文本（[packages/subagent/subagent/src/out-of-process.ts:45-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L45-L49)）
- 导出一个五项全为 `false` 且被冻结的能力广告，服务据此在 `start` 前拒绝需要这些特性的请求（[packages/subagent/subagent/src/out-of-process.ts:57-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L57-L63)）
- 计时配置必须是正有限数，否则抛出带插件前缀的错误（[packages/subagent/subagent/src/out-of-process.ts:72-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L72-L76)）
- 目录可用性同时检查 `isDirectory()` 与 `X_OK` 搜索权限，任何文件系统异常都判为不可用（[packages/subagent/subagent/src/out-of-process.ts:83-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L83-L94)）
- 子进程 cwd 必须是绝对路径且是可进入目录，否则在跨进程边界之前抛出（[packages/subagent/subagent/src/out-of-process.ts:106-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L106-L114)）
- 配置的 cwd 覆盖在加载期校验一次：空串直接拒绝，相对路径按启动目录 `resolve` 后再校验（[packages/subagent/subagent/src/out-of-process.ts:126-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L126-L132)）
- 子进程工作目录解析顺序为配置覆盖优先、否则父会话 cwd，两者都无则抛出而不回落到进程 cwd（[packages/subagent/subagent/src/out-of-process.ts:147-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L147-L153)）
- 结算时若本地取消已先行落定，正常完成的尝试也被改写为 `stopReason: 'aborted'` 并带上当前输出快照（[packages/subagent/subagent/src/out-of-process.ts:192-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L192-L197)）
- 尝试抛出且已取消时同样返回 `aborted`（[packages/subagent/subagent/src/out-of-process.ts:200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L200)）
- 诊断回调的抛出被吞掉，不能让结果 Promise 变成拒绝（[packages/subagent/subagent/src/out-of-process.ts:202-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L202-L206)）
- 其余失败被压平成 `stopReason: 'error'`，附带限长后的收集诊断与输出快照（[packages/subagent/subagent/src/out-of-process.ts:207-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L207-L215)）
- 无论走哪条路径，`finally` 都摘除请求信号上的 abort 监听器（[packages/subagent/subagent/src/out-of-process.ts:216-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L216-L218)）
- 发布的运行句柄 `localAgent` 恒为 `undefined`，`dispose()` 记忆化：摘监听、置本地取消、再等后端 teardown（[packages/subagent/subagent/src/out-of-process.ts:245-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/out-of-process.ts#L245-L258)）

### packages/subagent/subagent/src/projection-types.ts

子代理身份与计时两个会话投影的纯类型词汇表，供客户端与投影注册表共用。

- 无运行期机制

### packages/subagent/subagent/src/projection.ts

注册在会话投影注册表上的两个纯折叠定义：子代理身份（模式与标签）与活动轮次计时。

- 计时视图与折叠状态各有一套 zod 严格模式，限定为非负整数与布尔（[packages/subagent/subagent/src/projection.ts:27-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L27-L45)）
- 计时折叠初始态为 `descriptorSeen: false` 与 `settledMs: 0`（[packages/subagent/subagent/src/projection.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L65)）
- `turn/start` 在见到描述符之前只记 `pendingTurnStart`，之后才开启 `active` 区间（[packages/subagent/subagent/src/projection.ts:66-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L66-L71)）
- 每个 `subagent/descriptor` 事件把 `settledMs` 清零并置 `descriptorSeen`，同时把先前的起点接续为当前开放区间（[packages/subagent/subagent/src/projection.ts:72-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L72-L81)）
- `turn/end` 在描述符之前只丢弃 `pendingTurnStart`，在其之后按 `event.time - active.since` 且下限为 0 累加到 `settledMs`（[packages/subagent/subagent/src/projection.ts:82-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L82-L94)）
- 其余任意事件把开放区间的 `through` 推进到该事件时间（[packages/subagent/subagent/src/projection.ts:95-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L95-L96)）
- 计时投影对外只发出 `settledMs` 与可选的 `active`（[packages/subagent/subagent/src/projection.ts:98-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L98-L104)）
- 计时投影的 `stateVersion` 为 2，旧检查点行需重折叠（[packages/subagent/subagent/src/projection.ts:105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L105)）
- 身份值用按 `mode` 判别的联合模式校验：`one-shot` 的 `label` 可选、`continuable` 的必填，两者都要求非负整数 `seq`（[packages/subagent/subagent/src/projection.ts:118-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L118-L129)）
- 对外身份模式是可空的，`null` 是无值哨兵（[packages/subagent/subagent/src/projection.ts:131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L131)）
- 单事件描述符解析被 try 包住，抛出时折叠为无值而不让投影抛出（[packages/subagent/subagent/src/projection.ts:138-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L138-L147)）
- 身份值携带产生它的那个描述符事件的 `seq`（[packages/subagent/subagent/src/projection.ts:148-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L148-L154)）
- 身份折叠只对 `subagent/descriptor` 反应：有效则整体覆盖，无效则重置为空状态（[packages/subagent/subagent/src/projection.ts:172-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L172-L176)）
- 身份投影对外视图为 `state.identity ?? null`，空状态发出可序列化的 `null`（[packages/subagent/subagent/src/projection.ts:177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L177)）
- 身份投影的 `stateVersion` 为 2（[packages/subagent/subagent/src/projection.ts:180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/projection.ts#L180)）

### packages/subagent/subagent/src/run-settlement.ts

把一次一次性子代理运行的终态映射成后台任务结果并释放运行资源。

- 最终文本只取输出块里的 `text` 类型并直接拼接，其他块类型不贡献内容（[packages/subagent/subagent/src/run-settlement.ts:14-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/run-settlement.ts#L14-L19)）
- 失败详情固定为 `stopReason`，存在 `diagnostic` 时追加 `; diagnostic: <文本>`（[packages/subagent/subagent/src/run-settlement.ts:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/run-settlement.ts#L22-L27)）
- 结果映射：`completed` 携带最终文本；`aborted` 无诊断时记 `killed`、有诊断时记 `failed`；`error`/`max-tokens`/`refusal` 与任何未知原因都记 `failed` 且不带部分输出（[packages/subagent/subagent/src/run-settlement.ts:37-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/run-settlement.ts#L37-L53)）
- 结算先等结果（拒绝则记为 `failed` 并把错误字符串化），再无条件 `dispose()`，释放失败时把两段详情拼在一起返回（[packages/subagent/subagent/src/run-settlement.ts:61-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent/src/run-settlement.ts#L61-L75)）

### packages/subagent/subagent/src/types.ts

子代理能力接缝对外发布的请求、结果、能力与提供者接口类型，以及生命周期事件载荷类型。

- 无运行期机制

### packages/subagent/subagent/tsconfig.json

该包的 TypeScript 编译配置与工作区项目引用清单。

- 无运行期机制
