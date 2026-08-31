---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/experimental/client-ui-agent-team
---

# packages/experimental/client-ui-agent-team

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、76 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/experimental/client-ui-agent-team/README.md

该包的说明文档，描述这个 Web 端 Team 面板包的安装位置、面板能做什么以及实现文件分工。

- 无运行期机制

### packages/experimental/client-ui-agent-team/package.json

该包的 npm 清单，声明入口、导出、客户端加载元数据与依赖。

- `private: true` 使该包不进入发布流程（[packages/experimental/client-ui-agent-team/package.json:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/package.json#L5)）
- `type: module`、`main`、`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定默认加载的运行期文件（[packages/experimental/client-ui-agent-team/package.json:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/package.json#L11-L13)）
- `exports` 开放四个入口：根 `.` 映射到 `lib/index.js`，`./invariant` 映射到 `lib/invariant.js`，`./client` 映射到 `lib/client.js`，另有 `./src/*` 直通源码与 `./package.json`（[packages/experimental/client-ui-agent-team/package.json:14-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/package.json#L14-L29)）
- `dsh.client.inject` 列出客户端侧需要注入的五个包，`dsh.client.platform` 固定为 `web`，决定该插件在何种客户端平台被装载（[packages/experimental/client-ui-agent-team/package.json:30-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/package.json#L30-L41)）
- `files` 限定随包携带的文件为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与 `lib/types/**/*.d.ts`（[packages/experimental/client-ui-agent-team/package.json:84-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/package.json#L84-L89)）

### packages/experimental/client-ui-agent-team/src/client/TeamAction.module.css

面板组件使用的 CSS Module 样式表，被 `TeamAction.tsx` 以 `css` 默认导入。

- 无运行期机制

### packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx

会话头部 Team 面板的 React 组件，接收外部注入的 load/createTask/updateTask/openTeammate 四个动作，渲染成员列表与任务板。

- `items` 把逗号分隔字符串切分、去首尾空白、丢弃空项并去重，得到提交给服务端的字符串数组（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:62-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L62-L64)）
- `taskIds` 在 `items` 结果上转成任务 id 数组（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:66-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L66-L68)）
- `failureText` 把失败的 message 与 code 拼成 `message (code)` 形式的展示文本（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:70-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L70-L72)）
- `statusKey` 把任务状态映射到文案键，其中 `deleted` 也映射到 `status.completed`（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:74-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L74-L82)）
- `memberStatusKey` 把成员的五种状态映射到对应文案键（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:84-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L84-L92)）
- `sessionRef` 保存最新 sessionId，`refreshGeneration` 保存刷新代次，二者用于判定异步结果是否仍然有效（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:107-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L107-L109)）
- sessionId 变化时递增刷新代次，并把面板开合、加载态、视图、错误、创建态、两份草稿与 pending 集合全部复位（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:111-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L111-L122)）
- `refresh` 记录发起时的 sessionId 与新代次后调用 `load`，返回时若 sessionId 已变或代次已被推进则直接返回 false 且不写任何状态（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:124-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L124-L130)）
- `refresh` 成功时写入视图并清空错误返回 true，失败时写入格式化错误文本返回 false（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:131-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L131-L139)）
- `invalidateRefresh` 递增代次使在途刷新结果作废，并清掉加载态（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:141-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L141-L144)）
- `settleTask` 在发起变更前先作废在途刷新，并把该 taskId 加入 pending 集合（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:150-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L150-L152)）
- `settleTask` 在结果回来后先比对 sessionId，变更过则丢弃结果；传输层失败写入格式化错误并返回 undefined（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:154-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L154-L159)）
- 业务错误码为 `team-task-conflict` 时先重新加载整个视图，只有在重载成功后才把 `conflict` 文案写进错误位；其它业务错误直接展示（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:160-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L160-L169)）
- 变更成功后清空错误并重新加载完整视图，再返回本次变更得到的任务（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:170-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L170-L174)）
- `finally` 分支仅在 sessionId 未变时把该 taskId 从 pending 集合移除（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:175-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L175-L183)）
- `submitCreate` 对标题与描述做 trim，任一为空则不发请求；用固定键 `create` 走 `settleTask` 提交，成功后清空草稿并收起创建表单（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:186-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L186-L200)）
- `startEdit` 用任务当前字段填充编辑草稿，依赖与写入范围以 `, ` 连接成文本（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:202-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L202-L210)）
- `submitEdit` 第一次提交带 `expectedRevision: task.revision` 与 `action: 'edit'`，只发标题、描述与写入范围（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:212-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L212-L222)）
- 若草稿解析出的依赖与首次提交返回的依赖逐项相同则结束编辑，否则用返回值的新 revision 再发一次 `set_dependencies` 提交（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:223-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L223-L237)）
- 从视图成员中筛出角色为 teammate 的成员用于计数，另筛出非 failed、非 provisioning 的成员作为可指派 owner 候选（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:239-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L239-L240)）
- 触发按钮切换面板开合，并且只在由关变开时发起一次刷新（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:244-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L244-L252)）
- 触发按钮在 teammate 数大于 0 时显示数量角标（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L256)）
- 工具条上的刷新按钮再次发起 `refresh`，关闭按钮把面板置为收起（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:263-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L263-L268)）
- 错误非空时渲染 `role="alert"` 的提示块；加载中且尚无视图时渲染加载文案（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:270-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L270-L271)）
- 成员行按钮在角色为 lead 或状态为 failed / provisioning 时禁用（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L282)）
- 点击成员行调用注入的 `openTeammate`，其 reject 原因被转成字符串写进错误位（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:284-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L284-L286)）
- 成员行的状态点按 running / failed / 其它映射为 ongoing / error / done 三种呈现（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L288)）
- 成员行渲染名称、状态文案，model 存在时追加模型名，并逐条渲染 diagnostics（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:289-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L289-L293)）
- 新建按钮把创建表单展开（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:301-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L301-L303)）
- 创建表单绑定创建草稿，其 pending 取自 pending 集合中的 `create` 键（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:305-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L305-L314)）
- 任务为空且未在创建时渲染空态文案（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L315)）
- 处于编辑态的任务改渲染成表单，其 pending 取自 pending 集合中的该任务 id（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:317-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L317-L328)）
- 任务卡片渲染标题、状态文案、描述、任务 id，pending 状态额外显示 ready 或 blocked（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:330-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L330-L338)）
- 任务卡片在非空时展示依赖列表、写入范围列表，并逐条渲染写入范围重叠告警（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:339-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L339-L341)）
- owner 下拉以 `ownerName ?? ''` 为值，在该任务 pending 或已完成时禁用（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:346-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L346-L348)）
- owner 下拉变更时以当前 revision 发 `reassign`，选中空值时整个 `owner` 字段被省略（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:349-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L349-L357)）
- owner 下拉的候选项由未分配项加上可指派成员名构成（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:359-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L359-L360)）
- 编辑按钮进入该任务的编辑态，任务 pending 时禁用（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:363-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L363-L365)）
- 仅 in_progress 任务显示完成按钮，点击以当前 revision 发 `complete`（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:366-372](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L366-L372)）
- 仅 completed 任务显示重开按钮，点击以当前 revision 发 `reopen`（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:373-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L373-L379)）
- 删除按钮以当前 revision 发 `delete`，任务 pending 时禁用（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:380-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L380-L384)）
- `TaskForm` 的 `field` 以浅拷贝方式改写草稿的单个字段（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:408](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L408)）
- `TaskForm` 渲染标题、描述、依赖、写入范围四个受控输入并各自回写草稿（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:411-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L411-L414)）
- 保存按钮在 pending 或标题、描述 trim 后为空时禁用，取消按钮在 pending 时禁用（[packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx:415-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/TeamAction.tsx#L415-L418)）

### packages/experimental/client-ui-agent-team/src/client/index.ts

浏览器侧插件入口，被客户端加载器作为该包的 `./client` 导出装载。

- 导入 Team 服务包生成的 Remote 制品作为待挂载的 contribution（[packages/experimental/client-ui-agent-team/src/client/index.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/index.ts#L3)）
- 从 `mount.ts` 重导出 `inject`，使加载器按其中列出的服务名解析依赖（[packages/experimental/client-ui-agent-team/src/client/index.ts:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/index.ts#L7)）
- `apply` 把 Context 与生成的 contribution 交给 `mountAgentTeamUi`，并把它返回的 disposer 作为插件卸载函数（[packages/experimental/client-ui-agent-team/src/client/index.ts:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/index.ts#L12-L14)）

### packages/experimental/client-ui-agent-team/src/client/locales.ts

该面板的中英文文案字典与命名空间常量，被 `mount.ts` 注册、被 `TeamAction.tsx` 通过 `t` 读取。

- `NS` 定义该面板注册与查询文案所用的命名空间键 `agent-team`（[packages/experimental/client-ui-agent-team/src/client/locales.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/locales.ts#L4)）

### packages/experimental/client-ui-agent-team/src/client/mount.ts

浏览器侧的挂载实现，负责挂 Remote 命名空间、注册字典与会话头部槽位，并把 RPC 与导航动作注入组件。

- `inject` 声明该 UI 注册需要的四个浏览器服务：sessions、remote、slots、locale（[packages/experimental/client-ui-agent-team/src/client/mount.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L29)）
- 通过 `ctx.effect` 把中英文字典注册进 `NS` 命名空间，effect 返回的 disposer 在 fiber 卸载时撤销注册（[packages/experimental/client-ui-agent-team/src/client/mount.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L32)）
- `leadSessionId` 从会话绑定的快照里读 subagent 地址的 parentSessionId，读不到时退回传入的 sessionId（[packages/experimental/client-ui-agent-team/src/client/mount.ts:34-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L34-L37)）
- `load` 把解析出的 lead 会话 id 传给生成 Remote 的 `agentTeams.view` 调用（[packages/experimental/client-ui-agent-team/src/client/mount.ts:40-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L40-L42)）
- `createTask` 同样以 lead 会话 id 调用 `agentTeams.createTask` 并原样传入表单输入（[packages/experimental/client-ui-agent-team/src/client/mount.ts:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L43-L45)）
- `updateTask` 把 `owner` 从输入里拆出，仅在其不为 undefined 时才放回请求体（[packages/experimental/client-ui-agent-team/src/client/mount.ts:46-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L46-L52)）
- `openTeammate` 对非 teammate 角色直接返回，不做任何导航（[packages/experimental/client-ui-agent-team/src/client/mount.ts:53-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L53-L54)）
- `openTeammate` 先刷新父会话的子会话目录，若刷新期间当前会话已切走则放弃导航（[packages/experimental/client-ui-agent-team/src/client/mount.ts:55-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L55-L57)）
- `openTeammate` 以 `{ parentSessionId, childSessionId: member.id, mode: 'continuable' }` 打开子会话（[packages/experimental/client-ui-agent-team/src/client/mount.ts:58-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L58-L62)）
- 通过 `ctx.slots.inject` 在会话头部动作槽位可用时注册组件，id 为 `agent-team`、order 为 20、locale 为 `NS`，并以 `inject` 回调把上述动作对象交给组件（[packages/experimental/client-ui-agent-team/src/client/mount.ts:66-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L66-L75)）
- `mountAgentTeamUi` 先 `await ctx.remote.$mount(contribution)` 挂上生成的 Team Remote 命名空间（[packages/experimental/client-ui-agent-team/src/client/mount.ts:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L88)）
- 随后以 `ctx.inject` 在 sessions、`remote.agentTeams`、slots、locale 四者就绪后才执行 UI 注册（[packages/experimental/client-ui-agent-team/src/client/mount.ts:89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L89)）
- UI 注册抛错时先卸载 UI fiber 再卸载 Remote，然后把原错误重新抛出（[packages/experimental/client-ui-agent-team/src/client/mount.ts:90-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L90-L96)）
- 返回的 disposer 依次卸载 UI fiber 与 Remote 命名空间（[packages/experimental/client-ui-agent-team/src/client/mount.ts:97-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/client/mount.ts#L97-L100)）

### packages/experimental/client-ui-agent-team/src/css-modules.d.ts

给 `*.module.css` 与 `*.css` 导入声明类型的环境声明文件，供 TypeScript 编译使用。

- 无运行期机制

### packages/experimental/client-ui-agent-team/src/index.ts

该包的根（Host 侧）导出，作为函数插件被装载。

- 无运行期机制

### packages/experimental/client-ui-agent-team/src/invariant.ts

该包的 invariant 伴随插件，被 `./invariant` 导出装载。

- `inject` 声明依赖 `invariants` 注册表服务（[packages/experimental/client-ui-agent-team/src/invariant.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/invariant.ts#L11)）
- `install` 为空实现，注释给出该包不安装运行期 invariant 的理由（[packages/experimental/client-ui-agent-team/src/invariant.ts:13-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/invariant.ts#L13-L14)）
- `apply` 把包名与空 installer 注册进 invariants 注册表，并把注册返回的 disposer 作为卸载函数（[packages/experimental/client-ui-agent-team/src/invariant.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/src/invariant.ts#L21-L22)）

### packages/experimental/client-ui-agent-team/tsconfig.json

该包的 TypeScript 编译配置，声明编译面、输出目录与工程引用。

- 无运行期机制

### packages/experimental/client-ui-agent-team/tsdown.config.ts

该包的打包配置，供 `bundle` / `watch` 脚本使用。

- 以 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口调用共享的客户端打包配置，决定产出的运行期 bundle 文件集合（[packages/experimental/client-ui-agent-team/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/client-ui-agent-team/tsdown.config.ts#L1-L3)）
