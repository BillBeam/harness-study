---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/core/agent
---

# packages/core/agent

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、101 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/core/agent/README.md

该包的说明文档，描述 Agent 句柄、注册表、发起者作用域与 `agent/*` 事件词汇的用法，供阅读者参考。

- 无运行期机制

### packages/core/agent/package.json

该包的 npm 清单，决定包名、入口与可被外部 import 的子路径。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/core/agent/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/package.json#L14-L15)）
- `exports` 开放四个子路径：根、`./invariant`、`./types`、`./src/*` 与 `./package.json`（[packages/core/agent/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/package.json#L16-L31)）
- `files` 限定随包发布的运行期文件为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 js/d.ts（[packages/core/agent/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/package.json#L32-L37)）
- `type: module` 使所有产物按 ESM 加载（[packages/core/agent/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/package.json#L13)）

### packages/core/agent/src/consumed-work.ts

把一段会话日志折叠成"消耗掉的工作如何被交代"的结论，被需要判断轮次是否真正吃掉输入的调用方使用。

- `accountsForClaim` 对 `completed` 返回 false，对 `blocked`/`aborted`/`interrupted`/`error` 返回 true（[packages/core/agent/src/consumed-work.ts:42-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/consumed-work.ts#L42-L50)）
- 对未列举的结束原因走 default 分支返回 true（[packages/core/agent/src/consumed-work.ts:55-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/consumed-work.ts#L55-L56)）
- `foldConsumedWork` 单趟遍历事件，用 `stepped`/`claimed` 两个集合与 `open` 变量维护状态（[packages/core/agent/src/consumed-work.ts:68-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/consumed-work.ts#L68-L74)）
- `turn/start` 记下当前打开的轮次号，`step/start` 把该轮标记为已进入模型步（[packages/core/agent/src/consumed-work.ts:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/consumed-work.ts#L76-L81)）
- `agent/inbox/spliced` 中 `removedCount` 缺失时直接跳过（[packages/core/agent/src/consumed-work.ts:83-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/consumed-work.ts#L83-L84)）
- `outcome === 'canceled'` 且没有插入替代消息时置 `droppedUnrun`；否则把该次删除记为当前打开轮次的认领（[packages/core/agent/src/consumed-work.ts:85-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/consumed-work.ts#L85-L90)）
- `turn/end` 清空 `open`，当该轮已进入步、或认领过输入且结束原因交代了该输入时把该事件记为 `end` 并把 `droppedUnrun` 复位（[packages/core/agent/src/consumed-work.ts:92-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/consumed-work.ts#L92-L101)）
- 返回值在没有交代轮次时省略 `end` 字段，只带 `droppedUnrun`（[packages/core/agent/src/consumed-work.ts:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/consumed-work.ts#L107)）

### packages/core/agent/src/dispatch.ts

以 Agent 为主体的事件派发器与提示装配上下文构造器，被循环驱动与其他需要按 Agent 作用域发事件的代码调用。

- `agentCarrier` 用 `scopeTarget(agent, agent)` 造出以该 Agent 为作用域键的承载对象（[packages/core/agent/src/dispatch.ts:94-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/dispatch.ts#L94-L96)）
- `agentEvents` 的 `carrier` 参数默认现造，允许调用方传入构造期造好的承载对象复用（[packages/core/agent/src/dispatch.ts:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/dispatch.ts#L107)）
- `fused` 把调用方 payload 展开后再写入 `agent` 字段，使外部传入的同名字段无法覆盖注入的主体（[packages/core/agent/src/dispatch.ts:113-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/dispatch.ts#L113-L118)）
- `emit` 自行取出 `ctx.events.dispatch('emit', args)` 过滤后的回调集合逐个调用（[packages/core/agent/src/dispatch.ts:125-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/dispatch.ts#L125-L127)）
- `emit` 对每个监听器的同步抛出与返回 Promise 的拒绝分别捕获并写 `ctx.logger.warn`，后续监听器继续执行（[packages/core/agent/src/dispatch.ts:128-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/dispatch.ts#L128-L136)）
- `serial` 以承载对象为 `thisArg` 走 Cordis 串行派发并返回其结果（[packages/core/agent/src/dispatch.ts:138-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/dispatch.ts#L138-L142)）
- `waterfall` 以承载对象为 `thisArg` 派发，并把 payload 之后的参数（`next` 回调）原样透传（[packages/core/agent/src/dispatch.ts:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/dispatch.ts#L143-L147)）
- `emitAgentEvent` 现建一次性派发器发出一条被包容的通知（[packages/core/agent/src/dispatch.ts:158-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/dispatch.ts#L158-L165)）
- `assembleContextFor` 把 `agent` 与 `scope` 同时置为该 Agent，并在给出信号时带上 `signal`（[packages/core/agent/src/dispatch.ts:174-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/dispatch.ts#L174-L176)）

### packages/core/agent/src/inbox.ts

Agent 待处理消息队列的投影：把持久 `agent/inbox/spliced` 事件重放成两条内存列表，并把每次改动写回会话日志。

- 构造时从 `session.header.seedLength` 之后重放全部 `agent/inbox/spliced` 事件重建投影（[packages/core/agent/src/inbox.ts:32-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L32-L35)）
- 重放中任一条 splice 非法即抛出带 `session seq` 的错误，构造失败（[packages/core/agent/src/inbox.ts:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L36-L39)）
- `hasPending` 由两条列表长度共同决定（[packages/core/agent/src/inbox.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L53-L55)）
- `clear()` 先清 `next-step` 再清 `next-turn`，两次都走持久 splice（[packages/core/agent/src/inbox.ts:58-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L58-L61)）
- `claim()` 取走全部 `next-step`，当目标为 `next-turn` 时再多取一条队首轮次消息（[packages/core/agent/src/inbox.ts:71-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L71-L75)）
- `claim()` 对取走的每条消息发 `claimed` 通知并带上归属轮次号（[packages/core/agent/src/inbox.ts:76-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L76-L77)）
- `append` 与 `prepend` 分别在列表尾部和头部插入一条消息（[packages/core/agent/src/inbox.ts:86-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L86-L98)）
- `replace` 按消息 id 定位后原地替换一条待处理消息，未找到返回 false（[packages/core/agent/src/inbox.ts:109-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L109-L114)）
- `remove` 按 id 定位并删除一条待处理消息，未找到返回 false（[packages/core/agent/src/inbox.ts:121-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L121-L126)）
- `locate` 按 `next-turn`、`next-step` 的顺序跨两条列表查找 id（[packages/core/agent/src/inbox.ts:149-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L149-L155)）
- `mutate` 把 `start` 截断取整、负值折算成从尾部计、并夹到 `[0, 长度]`（[packages/core/agent/src/inbox.ts:166-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L166-L170)）
- `mutate` 把 `deleteCount` 截断取整、下限 0、上限为剩余长度（[packages/core/agent/src/inbox.ts:171-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L171-L175)）
- 既不删也不插的空改动直接返回空数组，不写事件（[packages/core/agent/src/inbox.ts:176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L176)）
- 主动丢弃且确有删除时给事件打上 `outcome: 'canceled'`；`claim` 走的路径不打（[packages/core/agent/src/inbox.ts:177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L177)）
- 归一化后的 splice 记录省略为 0 的 `removedCount` 与缺席的 `outcome`（[packages/core/agent/src/inbox.ts:178-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L178-L184)）
- 先 `session.append` 写入持久事件，再按事件里的 `inserted` 修改内存列表，使同步观察者读到改动前的列表（[packages/core/agent/src/inbox.ts:185-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L185-L187)）
- 丢弃路径对每条被删消息发 `discarded`，随后对每条插入消息发 `inserted` 通知（[packages/core/agent/src/inbox.ts:188-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L188-L191)）
- `validate` 对非安全整数、负数、越界的 `start`/`removedCount` 抛 `invalid inbox splice`（[packages/core/agent/src/inbox.ts:204-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L204-L210)）
- `validate` 在被改列表的候选结果与另一条列表合起来查重，重复 id 抛错（[packages/core/agent/src/inbox.ts:211-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/inbox.ts#L211-L218)）

### packages/core/agent/src/index.ts

包入口：`ctx.agents` 服务本体，管理活跃 Agent 注册表、创建工厂槽位与进程内发起者作用域，同时重导出本包其余模块。

- 重导出运行期类型、类型模块、收件箱、消耗折叠、模型选择与派发助手（[packages/core/agent/src/index.ts:18-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L18-L24)）
- 构造函数以 `agents` 名注册 Cordis 服务（[packages/core/agent/src/index.ts:256-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L256-L257)）
- 注入 `typert` 后注册 `agent` 查找项，把线上的 `agentId` 解析为活跃 Agent（[packages/core/agent/src/index.ts:258-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L258-L265)）
- 注册 `agent` Host 上下文，用 `candidate.agent?.id` 作身份、把 id 解析为 `agent.ctx`（[packages/core/agent/src/index.ts:266-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L266-L271)）
- 注册根级 `ctx.agent` 访问器默认返回 `undefined`，使普通上下文读该属性不抛错（[packages/core/agent/src/index.ts:279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L279)）
- 监听 `internal/status`，当本服务生命周期祖先纤程进入 UNLOADING 时关闭发起者作用域（[packages/core/agent/src/index.ts:280-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L280-L284)）
- 以复合 effect 安排拆卸顺序：先等待发起者边界排干并禁用存储，再关闭新边界（[packages/core/agent/src/index.ts:285-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L285-L288)）
- `currentInitiator()` 先断言可读再读 AsyncLocalStorage 中继承的 Agent（[packages/core/agent/src/index.ts:300-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L300-L303)）
- `requireInitiator()` 在无活跃发起者时抛 `no initiating agent is active`（[packages/core/agent/src/index.ts:313-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L313-L317)）
- `withInitiator` 以给定 Agent 建立边界，`withoutInitiator` 以 `undefined` 建立清除边界（[packages/core/agent/src/index.ts:332-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L332-L349)）
- `setFactory` 在已有工厂时抛错，把 `symbols.original` 解包后写入槽位，并在 effect 释放时清空（[packages/core/agent/src/index.ts:363-372](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L363-L372)）
- `setFactory` 原样返回 Cordis effect 的 disposer 本体以保留其身份（[packages/core/agent/src/index.ts:373-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L373-L378)）
- `requireFactory` 在未注册工厂时抛 `no agent factory registered (load an agent-loop plugin)`（[packages/core/agent/src/index.ts:382-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L382-L385)）
- `create()` 用 `getTraceable(ownerCtx, target)` 重新追踪工厂，并以 `Reflect.apply` 传入 `ownerCtx` 调 `createAgent`（[packages/core/agent/src/index.ts:396-406](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L396-L406)）
- `resume()` 走同样的重追踪路径调工厂的 `resume`（[packages/core/agent/src/index.ts:415-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L415-L421)）
- `register()` 用生成器 effect 先 yield `enter()` 返回的分离闭包再 `announce()`，使注销嵌在该 yield 位置（[packages/core/agent/src/index.ts:441-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L441-L447)）
- `enter()` 在 Agent id 与其 session id 不一致时抛错（[packages/core/agent/src/index.ts:466-469](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L466-L469)）
- `enter()` 在 id 已存在时抛错，构成唯一的登记冲突边界（[packages/core/agent/src/index.ts:470-473](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L470-L473)）
- `enter()` 写入条目并记录创建者 Agent、承载对象与 `announced`/`announcing`/`detachRequested` 状态（[packages/core/agent/src/index.ts:474-483](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L474-L483)）
- 返回的 detach 闭包幂等，且在创建通告派发进行中时改为置 `detachRequested` 延后执行（[packages/core/agent/src/index.ts:484-499](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L484-L499)）
- `detachEntered` 只在存储中仍是同一条目对象时删除，避免旧能力删掉同 id 的后继（[packages/core/agent/src/index.ts:503-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L503-L510)）
- 未通告过的条目回滚时不发 `agent/disposed`（[packages/core/agent/src/index.ts:511-515](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L511-L515)）
- `emitDisposed` 用条目固定的承载对象发 `agent/disposed`，逐个监听器捕获同步抛出与 Promise 拒绝并记警告（[packages/core/agent/src/index.ts:519-531](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L519-L531)）
- `announce()` 在给定 Agent 不是当前活跃条目时抛错（[packages/core/agent/src/index.ts:540-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L540-L543)）
- `announce()` 对已通告或正在通告的条目抛错，堵住监听器内的重入通告（[packages/core/agent/src/index.ts:545-547](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L545-L547)）
- 在派发前就置 `announcing`/`announced`（[packages/core/agent/src/index.ts:550-551](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L550-L551)）
- `agent/created` 监听器的同步抛出直接向外传播（否决发布），返回 Promise 的拒绝只记警告（[packages/core/agent/src/index.ts:552-562](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L552-L562)）
- `finally` 中清 `announcing`，并执行派发期间被推迟的分离（[packages/core/agent/src/index.ts:563-566](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L563-L566)）
- `get(id)` 按 id 返回活跃 Agent 本体而非句柄（[packages/core/agent/src/index.ts:574-576](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L574-L576)）
- `isOwnedBy` 比较条目记录的运行期创建者是否为给定 Agent（[packages/core/agent/src/index.ts:586-588](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L586-L588)）
- `list()` 按登记顺序返回一份新数组（[packages/core/agent/src/index.ts:594-596](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L594-L596)）
- `roots()` 只保留没有创建者 Agent 的条目（[packages/core/agent/src/index.ts:604-608](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L604-L608)）
- `closeInitiators` 把状态从 `active` 推进到 `closing`，拒绝新的发起者边界（[packages/core/agent/src/index.ts:611-613](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L611-L613)）
- `disposeInitiators` 记忆化一次：关闭、释放重入链、等待剩余边界排干、置 `disposed` 并禁用两个 AsyncLocalStorage（[packages/core/agent/src/index.ts:616-628](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L616-L628)）
- `runWithInitiator` 在状态非 `active` 时抛 `agent initiator scope is disposed`（[packages/core/agent/src/index.ts:631-632](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L631-L632)）
- 每次边界建立一条带父链的 run 记录并递增活跃计数，再嵌套两层 AsyncLocalStorage 执行操作（[packages/core/agent/src/index.ts:633-640](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L633-L640)）
- 操作同步抛出时先释放该 run 再重抛（[packages/core/agent/src/index.ts:641-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L641-L644)）
- 返回 Promise 时用 `Promise.prototype.then.call` 挂观察者在结算后释放 run，并原样返回调用方拿到的那个 Promise（[packages/core/agent/src/index.ts:645-660](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L645-L660)）
- 挂观察者本身失败时立即释放 run，避免边界泄漏（[packages/core/agent/src/index.ts:652-656](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L652-L656)）
- `hasLifecycleAncestor` 沿本服务纤程向上走父链判断候选纤程是否为祖先（[packages/core/agent/src/index.ts:664-672](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L664-L672)）
- `assertInitiatorsReadable` 在已 `disposed` 时抛错（[packages/core/agent/src/index.ts:674-676](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L674-L676)）
- `releaseReentrantInitiatorRuns` 把发起本次拆卸的整条嵌套链提前释放，使其不等自己排干（[packages/core/agent/src/index.ts:679-685](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L679-L685)）
- `releaseInitiatorRun` 幂等地减计数，计数归零时兑现排干 Promise（[packages/core/agent/src/index.ts:687-694](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L687-L694)）
- 默认导出 `AgentRegistry`，使其可作为 Cordis 服务插件被挂载（[packages/core/agent/src/index.ts:697](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/index.ts#L697)）

### packages/core/agent/src/invariant.ts

本包的不变量伴随插件，挂到 `invariants` 服务上检查 Agent 状态事件序列。

- 声明 Cordis 插件名 `agent-invariant` 与 `invariants` 注入依赖（[packages/core/agent/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/invariant.ts#L10-L12)）
- 用 WeakMap 按 Agent 记住上一次状态，并以 `global: true` 监听 `agent/status`（[packages/core/agent/src/invariant.ts:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/invariant.ts#L16-L23)）
- 同一 Agent 连续两次同一状态时调用 `fail` 报告空转迁移（[packages/core/agent/src/invariant.ts:18-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/invariant.ts#L18-L21)）
- `apply` 以包名把安装器注册进 `ctx.invariants` 并返回其 disposer（[packages/core/agent/src/invariant.ts:31-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/invariant.ts#L31-L32)）

### packages/core/agent/src/model-selection.ts

把一份可变的模型选择挂进 Agent 作用域的提示装配与请求配置两条瀑布链，被创建 Agent 的入口点调用。

- `system-prompt/assemble` 监听器在调用 `next()` 之前抓取 `selection.current` 快照（[packages/core/agent/src/model-selection.ts:40-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/model-selection.ts#L40-L41)）
- 装配返回后把该快照写入 `selection.assembled`，供同一步的请求阶段读取（[packages/core/agent/src/model-selection.ts:42-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/model-selection.ts#L42-L43)）
- 有选择时把 `provider` 与 `model` 写进装配结果的模板变量，无选择时原样返回（[packages/core/agent/src/model-selection.ts:44-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/model-selection.ts#L44-L52)）
- `agent/request` 监听器先 `await next()` 拿到下游解析出的调用配置（[packages/core/agent/src/model-selection.ts:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/model-selection.ts#L54-L58)）
- 请求阶段以 `selection.assembled`（而非 `current`）为准，使并发切换落到后一步（[packages/core/agent/src/model-selection.ts:59-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/model-selection.ts#L59-L61)）
- 覆盖 `provider`/`model` 前先剥掉继承来的 `reasoningEffort`，仅当所选包含 effort 时再加回（[packages/core/agent/src/model-selection.ts:60-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/model-selection.ts#L60-L68)）
- 返回的 disposer 同时摘掉两个作用域监听器（[packages/core/agent/src/model-selection.ts:71-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/src/model-selection.ts#L71-L74)）

### packages/core/agent/src/runtime-types.ts

只含 `import type` 与 `declare module` 的声明文件：把 Agent 的运行期方法面、`AgentOptions`、`PreStepDecision` 等类型和 `agent/*` 事件词汇合并进 Cordis 的 `Events`。

- 无运行期机制

### packages/core/agent/src/types.ts

只含类型与 `declare module` 的文件：声明 `Agent` 身份、`InboxTarget`，并把 `agent/inbox/spliced` 合并进会话事件映射表。

- 无运行期机制

### packages/core/agent/tsconfig.json

TypeScript 编译配置，声明 `rootDir`/`outDir` 与对工作区依赖包的项目引用。

- 无运行期机制

### packages/core/agent/tsdown.config.ts

打包配置，决定该包发布出的运行期 JS 文件由哪些入口生成。

- 声明两个互相独立的打包目标：`lib/types/index.js` 与 `lib/types/invariant.js` 各自打进 `lib`（[packages/core/agent/tsdown.config.ts:4-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/tsdown.config.ts#L4-L24)）
- 产物固定为 Node 平台、es2024 目标的 ESM，且不清理输出目录（[packages/core/agent/tsdown.config.ts:7-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent/tsdown.config.ts#L7-L13)）
