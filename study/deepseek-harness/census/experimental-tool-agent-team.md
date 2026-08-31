---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/experimental/tool-agent-team
---

# packages/experimental/tool-agent-team

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、45 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/experimental/tool-agent-team/README.md

包 README，说明这套团队工具的挂载方式、两个配置字段、十个工具的分组，以及模型可见文本与缓存效果的描述。

- 无运行期机制

### packages/experimental/tool-agent-team/package.json

包清单，声明该插件包的入口、导出子路径、随包分发的文件与依赖关系。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/experimental/tool-agent-team/package.json:12-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/package.json#L12-L13)）
- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，并额外开放 `./src/*` 与 `./package.json` 的原样子路径（[packages/experimental/tool-agent-team/package.json:14-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/package.json#L14-L25)）
- `files` 把分发内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/experimental/tool-agent-team/package.json:26-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/package.json#L26-L30)）
- `private: true` 使该包不进入正式发布（[packages/experimental/tool-agent-team/package.json:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/package.json#L5)）

### packages/experimental/tool-agent-team/src/index.ts

插件主体：在每个属于团队的 Agent 作用域内注册一段策略提示词与十个工具，全部委托给 `ctx.agentTeams` 域服务。

- `inject` 声明该插件必须等到 `agents`、`agentTeams`、`tools`、`systemPrompt` 四个服务就绪才装载（[packages/experimental/tool-agent-team/src/index.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L15)）
- 配置模式给 `freshProvider` 与 `forkProvider` 分别设默认值 `spawn` 与 `fork`（[packages/experimental/tool-agent-team/src/index.ts:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L26-L29)）
- `POLICY` 常量是注入到每个成员提示词里的固定协作文本，包含仅在被显式要求时才创建队友、共享工作目录与写作用域拆分、`FS_STALE_VERSION` 后重读重做、静默送信与唤醒送信的区分、送达即持久不得重发、任务领取与完成顺序、等待前先确认有活跃成员等条款（[packages/experimental/tool-agent-team/src/index.ts:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L32-L38)）
- `ACTIVE_WAIT_STATUSES` 把 `running` 与 `provisioning` 定义为可产生变化的成员状态（[packages/experimental/tool-agent-team/src/index.ts:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L40)）
- `NO_ACTIVE_PEER_MESSAGE` 是无活跃同伴时直接返回给模型的固定指引文本（[packages/experimental/tool-agent-team/src/index.ts:41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L41)）
- 成员行输出模式声明 id、name、role、status、diagnostics 为必填，并把 role 限定为 lead/teammate、status 限定为五种取值（[packages/experimental/tool-agent-team/src/index.ts:48-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L48-L62)）
- 任务行输出模式声明 id、revision、subject、description、status、blockedBy、writeScopes、ready、writeScopeWarnings 的取值与必填性（[packages/experimental/tool-agent-team/src/index.ts:65-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L65-L80)）
- 创建、列表、送信三类结果的输出模式分别固定为 `{member}`、成员数组、`{messageId,status}` 且 status 只能是 accepted 或 queued（[packages/experimental/tool-agent-team/src/index.ts:82-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L82-L99)）
- 等待结果模式包含必填 `timedOut` 与可选 `noProgress`，后者的 reason 被固定为常量 `no-active-peer`（[packages/experimental/tool-agent-team/src/index.ts:102-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L102-L116)）
- 中断结果模式把 `previousStatus` 限定为 running/idle/inactive；任务列表结果模式含 tasks 与可选 nextCursor（[packages/experimental/tool-agent-team/src/index.ts:118-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L118-L133)）
- `jsonOutput` 让每个工具的结果都以 `JSON.stringify` 的紧凑 JSON 作为单条文本内容渲染给模型（[packages/experimental/tool-agent-team/src/index.ts:142-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L142-L150)）
- `callingAgent` 在执行上下文缺少调用方 Agent 时抛错终止工具执行（[packages/experimental/tool-agent-team/src/index.ts:153-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L153-L157)）
- 在成员自己的 Agent 作用域上注册名为 `team:policy` 的提示词分节，顺序取自一等分节顺序表，文本在每次生成时追加该成员的团队角色、名字与团队 id（[packages/experimental/tool-agent-team/src/index.ts:165-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L165-L172)）
- 注册 `spawn_teammate`：参数含 name/description/prompt 必填与 context 可选枚举，描述里写明仅主导者可调用（[packages/experimental/tool-agent-team/src/index.ts:174-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L174-L187)）
- `spawn_teammate` 执行时 context 缺省为 `fresh`，并据此在配置的 forkProvider 与 freshProvider 之间选择提供方，把 prompt 包成文本内容块连同中止信号交给域服务（[packages/experimental/tool-agent-team/src/index.ts:188-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L188-L199)）
- 一个工厂用同一份参数与结果模式注册两个送信工具，仅 delivery 不同，并据此给出不同的工具描述（[packages/experimental/tool-agent-team/src/index.ts:202-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L202-L222)）
- `send_message` 以 quiet 投递、`followup_task` 以 wakeup 投递（[packages/experimental/tool-agent-team/src/index.ts:223-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L223-L224)）
- 注册无参数的 `list_agents`，返回域服务给出的成员名册（[packages/experimental/tool-agent-team/src/index.ts:226-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L226-L234)）
- 注册 `wait_agent`，其描述向模型声明该工具不唤醒成员、无活跃同伴时立即返回、唤醒或超时后应重新列举而非轮询（[packages/experimental/tool-agent-team/src/index.ts:236-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L236-L245)）
- `wait_agent` 的 timeout 缺省为 30000 毫秒，超出 10000–3600000 或非安全整数时直接交给域服务去做权威校验（[packages/experimental/tool-agent-team/src/index.ts:248-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L248-L252)）
- `wait_agent` 在一个同步段内扫描名册，若除自己外没有处于活跃状态的成员则不进入等待，直接返回 `timedOut:false` 加固定的 noProgress 说明（[packages/experimental/tool-agent-team/src/index.ts:255-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L255-L267)）
- 注册 `interrupt_agent`，把目标名字交给域服务中断其当前轮次（[packages/experimental/tool-agent-team/src/index.ts:271-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L271-L284)）
- 注册 `team_task_create`，参数含 subject/description 必填与 blocked_by、write_scopes 可选数组，执行时把阻塞 id 逐个转成任务 id 品牌类型，未给出的字段不出现在请求里（[packages/experimental/tool-agent-team/src/index.ts:286-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L286-L308)）
- 注册 `team_task_list`，声明 status/owner/ready/cursor/limit 五个可选过滤参数（[packages/experimental/tool-agent-team/src/index.ts:310-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L310-L324)）
- `team_task_list` 在本地按状态、按属主（`unowned` 表示无属主）、按就绪过滤域服务返回的任务（[packages/experimental/tool-agent-team/src/index.ts:326-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L326-L330)）
- `team_task_list` 的 cursor 缺省 0、limit 缺省 50，非法 cursor 或超出 1–100 的 limit 直接抛错（[packages/experimental/tool-agent-team/src/index.ts:331-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L331-L334)）
- `team_task_list` 按 cursor/limit 切片，且只有还有剩余行时才带出 `nextCursor`（[packages/experimental/tool-agent-team/src/index.ts:335-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L335-L338)）
- 注册 `team_task_get`，把字符串 id 转成任务 id 品牌类型后读取单个任务（[packages/experimental/tool-agent-team/src/index.ts:342-355](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L342-L355)）
- 注册 `team_task_update`，要求必填 `expected_revision` 作为比较并设置的前置条件，action 限定为 claim/release/edit/set_dependencies/complete/reopen/reassign/delete 八种（[packages/experimental/tool-agent-team/src/index.ts:357-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L357-L374)）
- `team_task_update` 执行时只把实际给出的 subject/description/blocked_by/write_scopes/owner 放进更新请求（[packages/experimental/tool-agent-team/src/index.ts:376-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L376-L387)）
- 安装过程中任一注册抛错时，按注册的逆序回滚已完成的注册再把错误抛出（[packages/experimental/tool-agent-team/src/index.ts:389-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L389-L392)）
- 安装成功后返回的注销函数同样按逆序拆除全部注册（[packages/experimental/tool-agent-team/src/index.ts:393-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L393-L395)）
- `apply` 在插件装载时把两个提供方配置解析成完整值（[packages/experimental/tool-agent-team/src/index.ts:399-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L399-L403)）
- `maybeInstall` 跳过已安装的 Agent，也跳过查不到团队成员身份的 Agent，因而非团队子代理不会拿到这批工具与提示词（[packages/experimental/tool-agent-team/src/index.ts:405-408](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L405-L408)）
- 装载时先遍历所有已存在的 Agent 安装一遍，再订阅 `agent/created` 为后续新建的 Agent 安装（[packages/experimental/tool-agent-team/src/index.ts:409-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L409-L410)）
- 订阅 `agent/disposed`，在 Agent 销毁时运行对应的注销函数并从表中移除（[packages/experimental/tool-agent-team/src/index.ts:411-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L411-L414)）
- 用一个具名 effect 在插件自身被卸载时拆除所有已安装作用域并清空登记表（[packages/experimental/tool-agent-team/src/index.ts:415-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/index.ts#L415-L418)）

### packages/experimental/tool-agent-team/src/invariant.ts

包自带的不变量伴生插件，向不变量注册表登记本包的归属。

- 安装器为空函数，不注册任何运行期检查（[packages/experimental/tool-agent-team/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/invariant.ts#L14)）
- `apply` 把包名连同空安装器注册进 `ctx.invariants` 并返回注销函数（[packages/experimental/tool-agent-team/src/invariant.ts:17-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/tool-agent-team/src/invariant.ts#L17-L18)）

### packages/experimental/tool-agent-team/tsconfig.json

包级编译配置，声明源码目录、类型输出目录与工程引用。

- 无运行期机制
