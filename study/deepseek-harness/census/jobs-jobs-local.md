---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/jobs/jobs-local
---

# packages/jobs/jobs-local

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、66 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/jobs/jobs-local/README.md

进程内后台任务登记表包的说明文档，介绍配额、生命周期与实现要点，供阅读者理解该包契约。

- 无运行期机制

### packages/jobs/jobs-local/package.json

该包的 npm 清单，声明 ESM 类型、入口与发布文件集。

- 声明 `"type": "module"` 并把默认入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/jobs/jobs-local/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/package.json#L13-L15)）
- `exports` 只放行 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个入口，外部只能从这些路径导入（[packages/jobs/jobs-local/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/package.json#L16-L27)）
- `files` 限定发布内容为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/jobs/jobs-local/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/package.json#L28-L32)）
- 把 agent、invariants、scope、jobs、timeout、cordis 列为 peerDependencies，由宿主组合提供（[packages/jobs/jobs-local/package.json:34-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/package.json#L34-L41)）

### packages/jobs/jobs-local/src/index.ts

`ctx.jobs` 后台任务登记表的进程内实现，默认导出服务类 `LocalJobRegistry`，被加载它的组合用来启动、查询、等待、终止后台任务。

- 导出超时码常量 `TASK_WAIT_TIMEOUT`，`wait()` 用它把定时到期与调用方取消区分开（[packages/jobs/jobs-local/src/index.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L25)）
- 每个 owner 的默认并发上限常量为 10（[packages/jobs/jobs-local/src/index.ts:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L28)）
- `isTerminal` 把 `completed`／`killed`／`failed` 三个状态判为终态，后续读取、终止、结算都以它分支（[packages/jobs/jobs-local/src/index.ts:66-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L66-L68)）
- `JobLayer` 把控制器令牌、完成监听器、变更监听器三张匿名表按注册作用域分层存放（[packages/jobs/jobs-local/src/index.ts:76-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L76-L84)）
- `Config` 校验模式把 `maxConcurrentJobsPerOwner` 限制为 ≥1 的整数并填入默认值 10（[packages/jobs/jobs-local/src/index.ts:92-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L92-L98)）
- 构造时用 `ctx.effect` 注册拆卸回调，服务被销毁时执行 `disposeAll()`（[packages/jobs/jobs-local/src/index.ts:123-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L123-L129)）
- `start()` 先检查有无服务该 owner 的控制器，没有就抛错并在错误文本里点名要加载的插件（[packages/jobs/jobs-local/src/index.ts:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L132-L134)）
- 拒绝空的 `kind` 与空的 `label`（[packages/jobs/jobs-local/src/index.ts:135-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L135-L136)）
- 校验 `outputLimitBytes` 必须是正的安全整数，否则抛错并回显收到的值（[packages/jobs/jobs-local/src/index.ts:137-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L137-L140)）
- 有 owner 时先挂上该 owner 的清理效果，再继续准入（[packages/jobs/jobs-local/src/index.ts:141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L141)）
- 活动数达到上限时在调用生产者之前抛错，错误文本给出上限并指示用 `job_kill` 停掉一个再重试（[packages/jobs/jobs-local/src/index.ts:143-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L143-L148)）
- 全部前置检查通过后才调用 `spec.run()` 启动生产者（[packages/jobs/jobs-local/src/index.ts:150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L150)）
- 按 kind 维护自增计数器，任务 id 生成为 `<kind>-<序号>`（[packages/jobs/jobs-local/src/index.ts:151-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L151-L153)）
- 建立 `settled` 承诺与可变记录（初始 `running`、记录 `startedAt`、绑定 `cancel`／`readOutput`）并写入 store（[packages/jobs/jobs-local/src/index.ts:155-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L155-L176)）
- 订阅生产者的 `done`：兑现走 `settle`，拒绝则记一条 warn 日志并以 `failed` 结算，等待者不会挂住（[packages/jobs/jobs-local/src/index.ts:178-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L178-L185)）
- 登记完成后广播该 owner 的可见集合变更，并返回任务 id（[packages/jobs/jobs-local/src/index.ts:186-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L186-L189)）
- `list()` 只返回无主任务与 `owner.id` 等于调用方会话 id 的任务，且逐条投影为新快照（[packages/jobs/jobs-local/src/index.ts:192-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L192-L197)）
- `get()` 查表、过所有权围栏、返回快照（[packages/jobs/jobs-local/src/index.ts:199-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L199-L203)）
- `read()` 有 `readOutput` 就调用它取增量文本，否则终态返回已记录的 output、非终态返回空串（[packages/jobs/jobs-local/src/index.ts:205-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L205-L212)）
- 终态读取会把记录标记为已上报，从而压掉后续的完成通知（[packages/jobs/jobs-local/src/index.ts:211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L211)）
- `kill()` 对已终态任务只标记已上报并返回 `already-finished`（[packages/jobs/jobs-local/src/index.ts:218-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L218-L221)）
- `kill()` 先调用生产者的 `cancel(reason)`，成功后才置 `stopping`、标记已上报、广播变更并返回 `requested`（[packages/jobs/jobs-local/src/index.ts:222-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L222-L228)）
- `wait()` 拒绝非有限或非正的超时值（[packages/jobs/jobs-local/src/index.ts:233-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L233-L235)）
- 已被取消的 signal 直接抛 `wait aborted`，不进入等待（[packages/jobs/jobs-local/src/index.ts:237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L237)）
- 等待期间对 `waiters` 计数加一，并用一次性 `uncount` 保证任何出口都只减一次（[packages/jobs/jobs-local/src/index.ts:240-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L240-L246)）
- 用 `deadline(signal, timeoutMs, TASK_WAIT_TIMEOUT)` 建带作用域的截止信号，退出时清定时器（[packages/jobs/jobs-local/src/index.ts:250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L250)）
- 把 `onSettled` 注册进 `waitResolvers`、`onAbort` 挂到截止信号上，两者互相摘除对方（[packages/jobs/jobs-local/src/index.ts:251-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L251-L272)）
- 中止时用 `timeoutOf` 判断来源：超时则正常返回，调用方取消则减计数并抛 `wait aborted`（[packages/jobs/jobs-local/src/index.ts:263-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L263-L268)）
- 等待结束若任务已终态则标记已上报，并返回当时的快照（超时返回的是仍 `running` 的快照）（[packages/jobs/jobs-local/src/index.ts:277-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L277-L278)）
- `onJobDone()` 把完成监听器登记进调用上下文所属的作用域层，并返回该注册的 disposer（[packages/jobs/jobs-local/src/index.ts:281-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L281-L287)）
- `onJobsChanged()` 以同样方式登记可见集合变更监听器（[packages/jobs/jobs-local/src/index.ts:289-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L289-L295)）
- `attachController()` 每次调用生成一个独立 symbol 令牌入层，重名注册各自可独立释放（[packages/jobs/jobs-local/src/index.ts:297-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L297-L305)）
- `servesOwner()` 先看全局层是否有控制器，否则沿 owner 上下文的作用域链逐层查找（[packages/jobs/jobs-local/src/index.ts:315-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L315-L319)）
- `activeTaskCount()` 只按 owner 引用相等统计 `running` 与 `stopping` 记录，终态历史不占额度（[packages/jobs/jobs-local/src/index.ts:322-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L322-L328)）
- `listenersFor()` 先产出全局层监听器，再沿 owner 作用域链逐层产出，链外监听器收不到该结算（[packages/jobs/jobs-local/src/index.ts:338-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L338-L342)）
- `expect()` 对未知 id 抛 `unknown job <id>`（[packages/jobs/jobs-local/src/index.ts:345-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L345-L349)）
- `assertAccess()` 在任务有 owner 且 `owner.id !== caller?.id` 时抛「属于另一会话」，无 agent 的调用方永远匹配不上有主任务（[packages/jobs/jobs-local/src/index.ts:356-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L356-L360)）
- `snapshot()` 每次生成新对象，只在字段存在时带上 `outputLimitBytes`／`ownerSession`／`detail`／`finishedAt`，从不外泄可变记录（[packages/jobs/jobs-local/src/index.ts:363-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L363-L377)）
- `changedFor()` 与 `listenersFor()` 同样按全局层加 owner 作用域链解析变更观察者（[packages/jobs/jobs-local/src/index.ts:388-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L388-L392)）
- `notifyChanged()` 逐个调用变更观察者并 try/catch 兜住抛出，只记 warn 日志（[packages/jobs/jobs-local/src/index.ts:398-406](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L398-L406)）
- `settle()` 对已终态记录直接返回，首个终态结果胜出（[packages/jobs/jobs-local/src/index.ts:417](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L417)）
- 写入终态 status／detail／output 与 `finishedAt` 时间戳（[packages/jobs/jobs-local/src/index.ts:418-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L418-L421)）
- 有待等待者时在通知监听器之前先标记已上报，使完成通知不与等待结果重复（[packages/jobs/jobs-local/src/index.ts:422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L422)）
- 先取快照、清空并逐个释放等待者、兑现 `settled`、再广播变更，最后才通知完成监听器（[packages/jobs/jobs-local/src/index.ts:423-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L423-L428)）
- `listenersClosed` 为真时跳过完成通知（[packages/jobs/jobs-local/src/index.ts:429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L429)）
- 逐个调用完成监听器，同步抛出与异步拒绝都被捕获成 warn 日志，不影响其他监听器（[packages/jobs/jobs-local/src/index.ts:430-439](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L430-L439)）
- `ensureOwnerCleanup()` 缺少 `agents` 服务时抛错拒绝启动有主任务（[packages/jobs/jobs-local/src/index.ts:449-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L449-L453)）
- 校验传入 owner 就是注册表当前登记的那个 agent 实例，否则抛错（[packages/jobs/jobs-local/src/index.ts:454-456](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L454-L456)）
- 在 owner 自己的上下文上挂一次可等待的清理效果（销毁时执行 `disposeOwned`），并保存 detach 句柄；已挂过则跳过（[packages/jobs/jobs-local/src/index.ts:457-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L457-L464)）
- `disposeOwned()` 取该 owner 的全部任务、发拆卸取消、等它们结算、从 store 删除，并在确有删除时广播一次变更（[packages/jobs/jobs-local/src/index.ts:467-475](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L467-L475)）
- `disposeAll()` 先置 `listenersClosed` 关闭完成通知，再对全部任务发拆卸取消并等待结算（[packages/jobs/jobs-local/src/index.ts:481-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L481-L487)）
- 清空 store 后，对刚被清空的每个不同 owner 各广播一次变更（[packages/jobs/jobs-local/src/index.ts:488-495](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L488-L495)）
- 最后清空并等待所有跨 fiber 的 owner 清理效果 detach 完成（[packages/jobs/jobs-local/src/index.ts:496-499](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L496-L499)）
- `cancelForTeardown()` 跳过已终态记录，并在调用 cancel 之前就把记录标记为已上报，使拆卸不产生完成通知（[packages/jobs/jobs-local/src/index.ts:508-517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L508-L517)）
- 取消成功即置 `stopping` 并立刻广播变更，观察者不会在等待生产者释放的整段窗口里仍看到 `running`（[packages/jobs/jobs-local/src/index.ts:518-524](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L518-L524)）
- 取消抛出时记 warn 日志并把记录强制结算为 `failed`（detail 说明工作可能被遗留），拆卸不会因此卡住（[packages/jobs/jobs-local/src/index.ts:525-529](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L525-L529)）
- 默认导出 `LocalJobRegistry`，使其可作为服务插件被 Loader 装载（[packages/jobs/jobs-local/src/index.ts:534](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/index.ts#L534)）

### packages/jobs/jobs-local/src/invariant.ts

该包的不变量伴生插件入口，被不变量服务加载以登记包归属。

- 声明 `inject = ['invariants']`，插件只在不变量服务就绪后应用（[packages/jobs/jobs-local/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/invariant.ts#L15)）
- 安装器为空函数，本包不注册任何运行期检查（[packages/jobs/jobs-local/src/invariant.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/invariant.ts#L24)）
- `apply` 把包名与空安装器注册进 `ctx.invariants` 并返回其 disposer（[packages/jobs/jobs-local/src/invariant.ts:31-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/jobs/jobs-local/src/invariant.ts#L31-L32)）

### packages/jobs/jobs-local/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、类型产物目录与工作区项目引用。

- 无运行期机制
