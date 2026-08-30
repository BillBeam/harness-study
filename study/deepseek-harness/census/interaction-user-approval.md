---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/interaction/user-approval
---

# packages/interaction/user-approval

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、38 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/interaction/user-approval/README.md

该包的英文说明文档，描述审批请求、策略、审计事件与失败即拒的组合方式。

- 无运行期机制

### packages/interaction/user-approval/package.json

该包的 npm 清单，声明入口、子路径导出与发布文件白名单。

- `main` / `types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定包被直接 import 时解析到的运行期文件（[packages/interaction/user-approval/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./types`、`./src/*` 与 `./package.json`，其余子路径无法被解析（[packages/interaction/user-approval/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/package.json#L16-L31)）
- `files` 白名单只打包 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`（[packages/interaction/user-approval/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/package.json#L32-L37)）

### packages/interaction/user-approval/src/index.ts

审批能力的服务定义：持有 `ctx.approval`，负责策略折叠与写入、答复者瀑布派发、审计事件追加与提示词贡献。

- 定义结果词表常量，用于把答复者返回值规范化到闭合取值（[packages/interaction/user-approval/src/index.ts:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L47)）
- 导出策略取值清单 `['ask', 'never']`，同时用于选项广告与运行期字符串校验（[packages/interaction/user-approval/src/index.ts:62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L62)）
- 定义 `never` 策略下写给模型的整句：审批提示被禁用、需审批的操作自动拒绝、不要请求沙箱升级（[packages/interaction/user-approval/src/index.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L65)）
- 定义 `ask` 策略下写给模型的整句：可经已组合的答复者询问，无可用答复者时失败即拒（[packages/interaction/user-approval/src/index.ts:67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L67)）
- `effectiveApprovalPolicy` 从后向前扫描日志取最后一条 `approval/policy` 的策略，没有则返回 undefined（[packages/interaction/user-approval/src/index.ts:77-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L77-L83)）
- `hasOpenTurn` 反向扫描日志：先遇到 `turn/start` 判为处于开启中的轮次，先遇到 `turn/end` 或扫完都判为否（[packages/interaction/user-approval/src/index.ts:92-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L92-L99)）
- `setApprovalPolicy` 对不在词表内的策略先抛 `TypeError`，合法时向会话追加 `approval/policy` 事件（[packages/interaction/user-approval/src/index.ts:107-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L107-L112)）
- `static Config` 校验 `policy` 字段并把缺省值定为 `ask`（[packages/interaction/user-approval/src/index.ts:158-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L158-L160)）
- 构造时在 `systemPrompt` 存在的作用域里注册名为 `approval:policy`、`order: 115` 的上下文贡献，按当前有效策略输出对应整句；无 agent 的裸组装返回空串（[packages/interaction/user-approval/src/index.ts:169-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L169-L181)）
- `setPolicy` 在新旧策略相同时直接返回；不同则写入策略事件，并向该 agent 注入一条署名为插件来源的用户消息，说明策略由用户从旧值改为新值（[packages/interaction/user-approval/src/index.ts:191-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L191-L202)）
- `request` 在没有开启中的轮次时抛错，且抛错发生在任何审计追加之前（[packages/interaction/user-approval/src/index.ts:223-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L223-L230)）
- `request` 生成随机 UUID 作为请求 id，追加 `approval/asked`（含工具名，`callId`、`reason` 仅在存在时带上），等待裁决后追加同 id 的 `approval/decided` 并返回结果（[packages/interaction/user-approval/src/index.ts:231-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L231-L240)）
- `effectivePolicy` 用会话覆写优先、否则取配置值、再否则取 `ask` 的顺序求当前策略（[packages/interaction/user-approval/src/index.ts:250-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L250-L252)）
- `overrideOf` 只读会话覆写而不套用配置缺省值（[packages/interaction/user-approval/src/index.ts:259-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L259-L261)）
- `decide` 在信号已中止时直接返回 `cancelled`，不做任何派发（[packages/interaction/user-approval/src/index.ts:270-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L270-L271)）
- `never` 策略在服务内部、瀑布派发之前直接返回 `rejected`（[packages/interaction/user-approval/src/index.ts:277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L277)）
- 先进入 promise 链再派发 `approval/request` 瀑布（以请求 agent 作用域定向，链尾兜底返回 `unavailable`），使同步抛出的监听器也落入同一拒绝路径（[packages/interaction/user-approval/src/index.ts:282-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L282-L287)）
- 把不在词表内的返回值规范化为 `unavailable`，并把答复者抛出的异常也收敛为 `unavailable`（[packages/interaction/user-approval/src/index.ts:288-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L288-L294)）
- 有信号时把答复与中止事件竞速：中止先到则结算 `cancelled` 并摘除监听，答复先到则结算结果，迟到的答复因 promise 已结算而被丢弃（[packages/interaction/user-approval/src/index.ts:295-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L295-L308)）
- 默认导出服务类，使该包可作为插件行被装载（[packages/interaction/user-approval/src/index.ts:312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L312)）

### packages/interaction/user-approval/src/invariant.ts

该包的不变量伴生插件，校验审计事件对的配对、所处轮次与取值词表。

- 声明伴生插件名与 `invariants` 注入需求（[packages/interaction/user-approval/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L13-L15)）
- `approval/asked` 校验：不在开启中的轮次、工具名为空、id 与已挂起的问题重复，三者各报一条失败，并产出 `asked` 转移（[packages/interaction/user-approval/src/invariant.ts:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L32-L37)）
- `approval/decided` 校验：不在开启中的轮次、没有对应的 `approval/asked`、结果不在闭合词表内，各报一条失败，并产出 `decided` 转移（[packages/interaction/user-approval/src/invariant.ts:38-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L38-L45)）
- `approval/policy` 携带词表外策略时报失败（[packages/interaction/user-approval/src/invariant.ts:46-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L46-L48)）
- `applyApprovalTransition` 按转移类型把 id 加入或移出挂起集合（[packages/interaction/user-approval/src/invariant.ts:53-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L53-L56)）
- `seed` 为一个会话重放整条日志，跟踪 `turn/start`/`turn/end` 维护当前轮次并逐事件校验、应用转移（[packages/interaction/user-approval/src/invariant.ts:62-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L62-L75)）
- 对已装载会话逐个 seed，并全局监听 `session/created` 为新会话 seed（[packages/interaction/user-approval/src/invariant.ts:77-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L77-L78)）
- 全局监听 `session/event`：轮次事件更新当前轮次；审批事件必须能在暂存表中找到同会话的预校验记录，否则报“未经预提交校验即公布”，找到则消费暂存并应用转移（[packages/interaction/user-approval/src/invariant.ts:79-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L79-L95)）
- 全局监听 `internal/dispatch`，在 `session/event` 公布前先做校验并把转移暂存到以事件对象为键的弱表（[packages/interaction/user-approval/src/invariant.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L96-L101)）
- `apply` 以包名向不变量服务登记该安装器并返回其卸载器（[packages/interaction/user-approval/src/invariant.ts:110-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/invariant.ts#L110-L111)）

### packages/interaction/user-approval/src/types.ts

浏览器可用的类型出口：审批 id、结果词表、两条审计事件与答复者瀑布事件的声明。

- 导出 `ApprovalRequestId(id)` 运行期函数，原样返回传入字符串并附加品牌类型，请求路径用它铸造审计对的 id（[packages/interaction/user-approval/src/types.ts:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/types.ts#L24-L26)）

### packages/interaction/user-approval/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工程引用。

- 无运行期机制

### packages/interaction/user-approval/tsdown.config.ts

该包的打包配置，供构建阶段把编译产物打成运行期入口。

- 把 `index` 与 `invariant` 拆成两次单入口构建，各自输出到 `lib`，从而不产生被 `files` 白名单排除的共享 chunk（[packages/interaction/user-approval/tsdown.config.ts:9-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/tsdown.config.ts#L9-L30)）
- 两个入口均以 esm 格式、node 平台、es2024 目标输出，且关闭扩展名固定、类型产出与清理（[packages/interaction/user-approval/tsdown.config.ts:11-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/tsdown.config.ts#L11-L19)）
