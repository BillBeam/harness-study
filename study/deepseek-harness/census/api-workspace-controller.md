---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/api/workspace-controller
---

# packages/api/workspace-controller

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 13 个文件、92 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/api/workspace-controller/README.md

该包的说明性 README，描述 Host 侧 Workspace 命令与 follow 流、Client 侧模型与竞态裁决规则。

- 无运行期机制

### packages/api/workspace-controller/package.json

该包的 npm 清单，声明入口映射、客户端打包元数据与发布文件集。

- 声明 `"type": "module"` 并把默认入口指向 `lib/index.js`（[packages/api/workspace-controller/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./types`、`./client`、`./typert`、`./remote`、`./src/*` 映射到具体产物，`./client` 单独指向 `lib/client.js`（[packages/api/workspace-controller/package.json:16-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/package.json#L16-L43)）
- `dsh.client` 声明客户端产物的 external 依赖、需要注入的 gateway 与连接包，并把平台标为 `web`（[packages/api/workspace-controller/package.json:44-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/package.json#L44-L55)）
- `scripts` 用 tsdown 产出 bundle 与 watch 构建（[packages/api/workspace-controller/package.json:56-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/package.json#L56-L59)）
- `files` 白名单限定发布物只含 `lib/` 下的运行时与类型产物（[packages/api/workspace-controller/package.json:60-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/package.json#L60-L70)）

### packages/api/workspace-controller/src/client/index.ts

Client 侧入口插件，把 Workspace 模型、命令服务与可重连的状态流装配到浏览器 Context 上。

- 声明 `inject = ['remote', 'remote.workspace']`，缺少任一服务时本插件不装载（[packages/api/workspace-controller/src/client/index.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/index.ts#L42)）
- `apply` 用生成的 `remote.workspace` 构造模型，再构造 `WorkspaceController` 服务把 `ctx.workspaces` 挂上（[packages/api/workspace-controller/src/client/index.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/index.ts#L49-L51)）
- 建流时把模型接为增量接收方，把载体丢失与终态失败分别接到模型的两个处理方法上，并立即 `start()`（[packages/api/workspace-controller/src/client/index.ts:52-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/index.ts#L52-L57)）
- 用 `ctx.effect` 注册流的异步 dispose，使插件卸载时关闭连接（[packages/api/workspace-controller/src/client/index.ts:58-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/index.ts#L58-L61)）
- `createWorkspaceStateStream` 用 Gateway 的 `$stream` 打开 `workspace.follow(signal)`，并把流提前结束区分成可重试的载体错误与「未收到开场快照」的普通错误（[packages/api/workspace-controller/src/client/index.ts:84-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/index.ts#L84-L91)）
- 用 `RemoteSnapshotStream` 把 `type === 'baseline'` 的帧识别为快照并整体替换状态，其余帧走增量分派（[packages/api/workspace-controller/src/client/index.ts:92-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/index.ts#L92-L98)）
- `acceptIncrement` 把 `upsert`/`remove`/`order`/`archived` 四种增量分派到模型对应方法（[packages/api/workspace-controller/src/client/index.ts:101-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/index.ts#L101-L119)）
- 未知增量类型抛出带 JSON 内容的错误作为闭合联合的兜底（[packages/api/workspace-controller/src/client/index.ts:122-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/index.ts#L122-L124)）

### packages/api/workspace-controller/src/client/model.ts

Client 侧 Workspace 状态模型，既是 Remote 命令的发起方，也是 follow 流增量的接收方，被同目录的 index.ts 与 service.ts 使用。

- 用请求代际、帧代际、已提交顺序与已删除 id 集合四个字段共同裁决 unary 回声与流增量的先后（[packages/api/workspace-controller/src/client/model.ts:59-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L59-L66)）
- 构造时先建一份快照缓存，使首次读取无需重建（[packages/api/workspace-controller/src/client/model.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L75-L77)）
- `create` 把抛出的异常折成 `internal` 失败结果，成功时立刻把返回行并入本地投影（[packages/api/workspace-controller/src/client/model.ts:84-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L84-L93)）
- `rename` 成功后把返回行并入投影（[packages/api/workspace-controller/src/client/model.ts:101-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L101-L105)）
- `delete` 成功后以 immediate 方式移除本地行，使删除在操作 resolve 前即刻通知订阅者（[packages/api/workspace-controller/src/client/model.ts:112-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L112-L116)）
- `insertBefore` 先记下请求代际与帧代际，立即安装本地乐观顺序（[packages/api/workspace-controller/src/client/model.ts:128-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L128-L131)）
- 请求抛出时，仅当两个代际都未变才回滚到已提交顺序，然后继续抛出（[packages/api/workspace-controller/src/client/model.ts:137-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L137-L144)）
- 请求返回时，仅当两个代际都未变才安装服务端返回的完整顺序（成功）或回退到已提交顺序（失败）（[packages/api/workspace-controller/src/client/model.ts:145-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L145-L148)）
- `insertSessionBefore` 省略未给的锚点字段后发起请求，成功时并入返回行（[packages/api/workspace-controller/src/client/model.ts:164-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L164-L170)）
- `archiveSession` 成功后用返回的完整归档集合覆盖本地集合（[packages/api/workspace-controller/src/client/model.ts:181-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L181-L183)）
- `replaceBaseline` 递增帧代际，用基线整体替换行与归档集合，并把状态置为 idle/ready、清空错误（[packages/api/workspace-controller/src/client/model.ts:190-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L190-L198)）
- `replaceOrder` 递增帧代际并把流下发的顺序作为已提交顺序安装，使之压过更早的 unary 回声（[packages/api/workspace-controller/src/client/model.ts:211-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L211-L214)）
- `handleCarrierFailure` 把状态置为 loading 并清错，保留最后一份完整投影不清空（[packages/api/workspace-controller/src/client/model.ts:225-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L225-L229)）
- `handleStreamFailure` 把状态置为 error 并把失败折成 `RemoteFailure` 暴露给订阅者（[packages/api/workspace-controller/src/client/model.ts:235-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L235-L239)）
- `subscribe` 把监听器加入集合并返回取消订阅函数（[packages/api/workspace-controller/src/client/model.ts:246-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L246-L249)）
- `getSnapshot` 在返回前按脏标记重建缓存，使快照引用在无变化时保持稳定（[packages/api/workspace-controller/src/client/model.ts:255-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L255-L258)）
- `installArchived` 在新旧集合逐项相等时直接返回，不触发通知（[packages/api/workspace-controller/src/client/model.ts:270-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L270-L275)）
- `installOrder` 按给定 id 顺序排序本地行，顺序里没有的 id 排到末尾，排序结果与原数组逐项同引用时不通知（[packages/api/workspace-controller/src/client/model.ts:277-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L277-L286)）
- `upsert` 对已删除 id 直接丢弃，对 `updatedAt` 早于本地行的数据也丢弃（[packages/api/workspace-controller/src/client/model.ts:288-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L288-L294)）
- 新行会被插到已提交顺序与行列表的最前面，已有行按位置原地替换（[packages/api/workspace-controller/src/client/model.ts:295-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L295-L301)）
- `remove` 把 id 记入已删除集合、从已提交顺序里剔除；本地本来就没有该行时，immediate 调用仍会立刻发一次通知（[packages/api/workspace-controller/src/client/model.ts:304-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L304-L316)）
- `installViews` 过滤掉已删除 id 并按 Map 去重，同时把已提交顺序设为基线给出的顺序（[packages/api/workspace-controller/src/client/model.ts:318-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L318-L325)）
- `invalidate` 默认用 microtask 合并同一轮内的多次变更，immediate 时递增代际并同步 flush，使已排队的延迟通知作废（[packages/api/workspace-controller/src/client/model.ts:327-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L327-L344)）
- `flush` 在无待发通知或无监听者时直接返回，否则先刷新快照再通知全部订阅者（[packages/api/workspace-controller/src/client/model.ts:346-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L346-L351)）
- `insertIdBefore` 在 id 不存在、锚点不存在或锚点等于自身时原样返回，否则移除后按锚点位置插入、无锚点时追加到末尾（[packages/api/workspace-controller/src/client/model.ts:360-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L360-L371)）
- 抛出的异常被折成 code 为 `internal`、details 为空的 `RemoteFailure`（[packages/api/workspace-controller/src/client/model.ts:373-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/model.ts#L373-L383)）

### packages/api/workspace-controller/src/client/service.ts

Client 侧的 Cordis 服务与命令门面，把模型的结果型返回转成抛异常的调用方式。

- `WorkspaceCreateError` 携带原始 `RemoteFailure` 并把 code 与 message 拼进错误消息（[packages/api/workspace-controller/src/client/service.ts:11-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/service.ts#L11-L18)）
- 构造时以服务名 `workspaces` 注册到 Context，并把模型直接作为可订阅的快照源暴露（[packages/api/workspace-controller/src/client/service.ts:87-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/service.ts#L87-L90)）
- `create` 失败时抛 `WorkspaceCreateError`，成功返回创建或幂等解析出的 Workspace（[packages/api/workspace-controller/src/client/service.ts:92-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/service.ts#L92-L96)）
- rename/delete/insertBefore/archiveSession/insertSessionBefore 在失败时按各自的操作名抛出普通 Error（[packages/api/workspace-controller/src/client/service.ts:98-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/service.ts#L98-L127)）
- `commandError` 把操作名、失败码与失败消息拼成错误文本（[packages/api/workspace-controller/src/client/service.ts:130-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/client/service.ts#L130-L132)）

### packages/api/workspace-controller/src/commands.ts

Host 侧 Workspace 变更命令的实现，被同包 index.ts 的 Remote 方法直接调用。

- 用一条 `operationTail` Promise 链把需要读当前注册表状态的操作串行化，前一个操作失败也不会中断链（[packages/api/workspace-controller/src/commands.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L29)）
- `create` 先按路径解析已有 Workspace，命中则返回 `created: false`，否则新建并返回 `created: true`（[packages/api/workspace-controller/src/commands.ts:40-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L40-L47)）
- `create` 中已是 Remote 失败的原样透传，其余异常映射成 `workspace-invalid-path` 并带上路径（[packages/api/workspace-controller/src/commands.ts:48-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L48-L55)）
- `rename` 先 trim 标题，为空时不入队直接以 `bad-request` 拒绝（[packages/api/workspace-controller/src/commands.ts:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L65-L72)）
- `rename` 在串行队列中检查同名冲突，命中抛 `workspace-name-conflict`，标题未变则跳过写入（[packages/api/workspace-controller/src/commands.ts:73-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L73-L87)）
- `delete` 在注册表返回 false 时抛 `workspace-not-found`，成功返回 `{ deleted: true }`（[packages/api/workspace-controller/src/commands.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L96-L101)）
- `insertBefore` 调用注册表重排并返回完整顺序，顺序非法错误被映射成 `workspace-not-found`，其余异常原样抛出（[packages/api/workspace-controller/src/commands.ts:110-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L110-L121)）
- `insertSessionBefore` 先要求 Workspace 存在，移动非法错误被映射成 `workspace-move-invalid` 并带上三个 id（[packages/api/workspace-controller/src/commands.ts:130-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L130-L147)）
- `archiveSession` 把未知 Session 错误映射成 `session-not-found`，并返回注册表当前的完整归档集合（[packages/api/workspace-controller/src/commands.ts:156-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L156-L162)）
- `requireWorkspace` 在注册表查不到时抛 `workspace-not-found`（[packages/api/workspace-controller/src/commands.ts:165-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L165-L169)）
- `enqueue` 把操作接到队尾，并把队尾 Promise 的成功与失败都吞成 undefined，使后续操作照常执行（[packages/api/workspace-controller/src/commands.ts:171-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L171-L175)）
- 统一的失败构造函数把 code、message、details 包成 `TypertRemoteFailure`（[packages/api/workspace-controller/src/commands.ts:178-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/commands.ts#L178-L192)）

### packages/api/workspace-controller/src/directory-picker.ts

Host 侧 `directoryPicker` Remote 命名空间的服务，由同包 index.ts 作为子插件挂载，覆盖目录选择与浏览三个 wire 动作。

- 用 zod 要求新建目录的名字非空、不是 `.` 或 `..`、且不含路径分隔符（[packages/api/workspace-controller/src/directory-picker.ts:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/directory-picker.ts#L16-L23)）
- 声明 `static inject = ['directoryPicker']`，未组合选择后端时本服务不装载，也就不注册该命名空间（[packages/api/workspace-controller/src/directory-picker.ts:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/directory-picker.ts#L40)）
- 构造时以服务名 `directoryPickerController`、命名空间 `directoryPicker` 注册（[packages/api/workspace-controller/src/directory-picker.ts:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/directory-picker.ts#L43-L45)）
- `pick` 要求 native 能力后调用系统选择器，取消返回 null，异常按 abort 与否分类（[packages/api/workspace-controller/src/directory-picker.ts:52-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/directory-picker.ts#L52-L60)）
- `list` 要求 browse 能力后列一层目录，路径缺省时列 home，signal 中止会终止后端扫描（[packages/api/workspace-controller/src/directory-picker.ts:69-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/directory-picker.ts#L69-L77)）
- `createDirectory` 先做 schema 校验，失败抛 `bad-request` 并带 zod issues，通过后要求 browse 能力再创建（[packages/api/workspace-controller/src/directory-picker.ts:86-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/directory-picker.ts#L86-L100)）
- `requireCapability` 在组合的后端能力种类不匹配时抛 `directory-picker-unavailable`，并在 details 里写明后端实际提供的种类（[packages/api/workspace-controller/src/directory-picker.ts:104-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/directory-picker.ts#L104-L117)）
- `browseFailure` 把 seam 自带的闭合错误码连同路径透传，其余归为 `internal`（[packages/api/workspace-controller/src/directory-picker.ts:141-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/directory-picker.ts#L141-L146)）
- `cancellableFailure` 先看 signal 是否已 abort，是则统一答 `cancelled`，否则再走业务分类（[packages/api/workspace-controller/src/directory-picker.ts:158-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/directory-picker.ts#L158-L167)）

### packages/api/workspace-controller/src/feed.ts

Host 侧 Workspace 投影与增量的生产者，被同包 index.ts 的 `follow` 流方法与 commands.ts 的视图投影共用。

- `workspaceView` 把注册表实体逐字段投影成分离的 Remote 值，sessionIds 做数组复制（[packages/api/workspace-controller/src/feed.ts:22-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L22-L31)）
- `changedWorkspaceView` 用 `workspaceRecord.parse` 解析变更事件里的持久化值再投影（[packages/api/workspace-controller/src/feed.ts:33-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L33-L43)）
- 构造时同步抓取当前的已知 id 集合、顺序与归档集合作为增量比较的起点（[packages/api/workspace-controller/src/feed.ts:54-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L54-L57)）
- 构造时订阅 `domain/changed` 事件，并用 `ctx.effect` 在卸载时关闭并清空全部 follower（[packages/api/workspace-controller/src/feed.ts:58-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L58-L62)）
- `baseline` 同步读注册表列表与归档集合，组成一份完整投影（[packages/api/workspace-controller/src/feed.ts:69-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L69-L74)）
- `follow` 进入即检查 abort，先注册 follower 再产出 baseline，然后转产增量；finally 里注销并关闭该 follower（[packages/api/workspace-controller/src/feed.ts:81-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L81-L92)）
- 变更处理只认 `workspace` 域，其余域直接返回（[packages/api/workspace-controller/src/feed.ts:94-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L94-L96)）
- 注册表状态记录的 put 变更里，出现的新 id 先查注册表取实体并发 `upsert` 帧；注册表查不到实体时抛错（[packages/api/workspace-controller/src/feed.ts:97-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L97-L109)）
- 顺序与上一次不同时发一帧 `order`，归档集合与上一次不同时发一帧 `archived`（[packages/api/workspace-controller/src/feed.ts:110-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L110-L117)）
- `workspaces` 表的删除变更只对已知 id 发 `remove` 帧，非已知 id 的写入变更被忽略，其余写入发 `upsert` 帧（[packages/api/workspace-controller/src/feed.ts:119-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L119-L129)）
- `publish` 把一帧增量推给当前全部 follower（[packages/api/workspace-controller/src/feed.ts:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L132-L134)）
- follower 用内部队列缓存帧并在有等待者时唤醒，已关闭的 follower 丢弃新帧（[packages/api/workspace-controller/src/feed.ts:146-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L146-L157)）
- follower 的读循环在未关闭且未 abort 时先排空队列再等待，abort 或关闭时结束迭代（[packages/api/workspace-controller/src/feed.ts:159-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L159-L168)）
- 等待时注册一次性 abort 监听并在结束时移除，若安装瞬间已 abort、已关闭或队列非空则立刻结束等待（[packages/api/workspace-controller/src/feed.ts:170-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/feed.ts#L170-L183)）

### packages/api/workspace-controller/src/index.ts

该包 Host 侧主入口，`workspace` Remote 命名空间的服务类，并作为目录选择控制器的 Loader 承载点。

- 声明 `static inject = ['typert', 'workspaceRegistry']`，两者就绪前不装载（[packages/api/workspace-controller/src/index.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/index.ts#L35)）
- 构造时以服务名 `workspaceController`、命名空间 `workspace` 注册，并建立命令实现与 feed（[packages/api/workspace-controller/src/index.ts:42-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/index.ts#L42-L44)）
- 构造时挂载 `DirectoryPickerController` 子插件，子插件在没有选择后端时保持 pending，因而不注册选择命名空间（[packages/api/workspace-controller/src/index.ts:45-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/index.ts#L45-L49)）
- 把 create、rename、delete、insertBefore、insertSessionBefore、archiveSession 六个动作以 `@Remote` 显式命名注册为 wire 方法并转发给命令实现（[packages/api/workspace-controller/src/index.ts:57-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/index.ts#L57-L110)）
- `follow` 以 `mode: 'stream'` 注册，把 feed 的异步迭代器作为流返回（[packages/api/workspace-controller/src/index.ts:117-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/index.ts#L117-L120)）
- 默认导出 `WorkspaceController`，使其可作为 Loader 条目装载（[packages/api/workspace-controller/src/index.ts:123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/index.ts#L123)）

### packages/api/workspace-controller/src/invariant.ts

该包的 invariant 伴随插件，向 invariants 注册表登记包名。

- 声明插件名与 `inject = ['invariants']`，使其在 invariants 服务就绪后才装载（[packages/api/workspace-controller/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/invariant.ts#L10-L12)）
- 安装函数为空，本包不注册任何运行期不变量检查（[packages/api/workspace-controller/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/invariant.ts#L15)）
- `apply` 向 invariants 注册包名并把注册返回的 disposer 交回 Cordis（[packages/api/workspace-controller/src/invariant.ts:18-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/src/invariant.ts#L18-L19)）

### packages/api/workspace-controller/src/types.ts

该包的浏览器侧类型文件，声明 Workspace 与目录选择两个命名空间的请求、返回值、失败码与流帧类型。

- 无运行期机制

### packages/api/workspace-controller/tsconfig.json

该包的 TypeScript 方案根配置，只引用 Host 与 Client 两个编译面的叶子配置。

- 无运行期机制

### packages/api/workspace-controller/tsdown.config.ts

该包的 tsdown 打包配置，决定客户端 bundle 的入口与构建阶段。

- 以 `lib/types/index.js` 与 `lib/types/invariant.js` 为入口产出客户端 bundle，并开启 hostPhase（[packages/api/workspace-controller/tsdown.config.ts:3-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/api/workspace-controller/tsdown.config.ts#L3-L7)）
