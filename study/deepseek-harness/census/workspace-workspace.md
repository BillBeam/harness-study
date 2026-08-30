---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/workspace/workspace
---

# packages/workspace/workspace

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、84 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/workspace/workspace/README.md

工作区注册表包的说明文档，描述项目记录、会话归属、顺序与删除语义，供宿主使用者与维护者阅读。

- 无运行期机制

### packages/workspace/workspace/package.json

该包的 npm 清单，声明模块类型、入口映射与发布内容。

- `"type": "module"` 与 `main` 把包按 ESM 解析，默认入口指向 `lib/index.js`（[packages/workspace/workspace/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/package.json#L13-L15)）
- `exports` 暴露根入口、`./invariant` 与 `./types` 三个运行期子路径（[packages/workspace/workspace/package.json:16-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/package.json#L16-L28)）
- `./src/*` 把源码目录整体透出，未构建的消费方可直接加载 `.ts` 文件（[packages/workspace/workspace/package.json:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/package.json#L29)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/` 下的 js 与声明文件（[packages/workspace/workspace/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/package.json#L32-L37)）

### packages/workspace/workspace/src/entity.ts

包内私有的工作区实体实现：持有一份记录快照，所有写入都汇入一个 `mutate` 路径，由 `src/index.ts` 的注册表构造。

- `WorkspaceMoveInvalidError` 单独区分"移动请求点名了未记账的会话或锚"这一类失败（[packages/workspace/workspace/src/entity.ts:19-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L19-L27)）
- 用一个模块级哨兵错误表示"记录无需变更"，只被 `mutate` 识别（[packages/workspace/workspace/src/entity.ts:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L66)）
- `sessionIds` 读取时按"索引里的规范目录等于记录路径"过滤持久化候选，不做任何持久化读（[packages/workspace/workspace/src/entity.ts:101-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L101-L103)）
- `setTitle` 走同一条写路径替换标题（[packages/workspace/workspace/src/entity.ts:105-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L105-L107)）
- 已在快照中记账的会话跳过全部校验，只有新 id 才读 header 验证（[packages/workspace/workspace/src/entity.ts:114-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L114-L115)）
- header 没有 cwd 时拒绝挂接并指出无可校验的目录（[packages/workspace/workspace/src/entity.ts:116-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L116-L121)）
- cwd 的 `realpath` 解析失败时拒绝并保留原异常为 cause（[packages/workspace/workspace/src/entity.ts:122-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L122-L131)）
- 规范化后不是目录、或与工作区路径不相等，均拒绝挂接（[packages/workspace/workspace/src/entity.ts:132-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L132-L143)）
- 校验通过后把该会话的规范目录写回注册表索引（[packages/workspace/workspace/src/entity.ts:144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L144)）
- 挂接在写链槽位上把会话前插到 `sessionIds`，若届时已存在则不改（[packages/workspace/workspace/src/entity.ts:146-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L146-L148)）
- 移动会话时，被移动 id 或锚 id 未记账则抛 `WorkspaceMoveInvalidError`（[packages/workspace/workspace/src/entity.ts:152-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L152-L163)）
- 锚等于自身、或重排后序列与原序列逐位相同，都返回原记录从而不写（[packages/workspace/workspace/src/entity.ts:164-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L164-L170)）
- 无锚时移动到队尾，有锚时插到锚之前（[packages/workspace/workspace/src/entity.ts:165-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L165-L167)）
- `detachSession` 只在记账中包含该 id 时才移除，否则返回原记录（[packages/workspace/workspace/src/entity.ts:174-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L174-L178)）
- `status()` 每次实时 `stat` 记录路径，任何失败都返回 `missing-dir` 且不改记录（[packages/workspace/workspace/src/entity.ts:180-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L180-L188)）
- 唯一写路径经 `table.update` 在域写链槽位上运行变更函数，并对候选会话按当前索引剪枝（[packages/workspace/workspace/src/entity.ts:205-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L205-L209)）
- 变更函数返回原值且剪枝也无变化时抛哨兵中止该槽位，既不写介质也不发变更事件（[packages/workspace/workspace/src/entity.ts:210-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L210-L217)）
- 真正写入时统一盖上 ISO 格式的 `updatedAt`，并用返回值替换实体快照（[packages/workspace/workspace/src/entity.ts:213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L213)、[packages/workspace/workspace/src/entity.ts:219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/entity.ts#L219)）

### packages/workspace/workspace/src/index.ts

插件入口：`WorkspaceRegistry` 服务，负责打开持久化域、启动期恢复与校验、按会话 header 建规范目录索引，并串行化所有注册表写操作。

- `WorkspaceId` 工厂把裸字符串标记为品牌类型（[packages/workspace/workspace/src/index.ts:37-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L37-L39)）
- `WorkspaceUnknownSessionError` 固定归档失败文案，只用于"确实不存在该会话"（[packages/workspace/workspace/src/index.ts:45-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L45-L53)）
- `WorkspaceOrderInvalidError` 固定重排失败文案（[packages/workspace/workspace/src/index.ts:56-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L56-L64)）
- header 排序规则：`createdAt` 降序，同时间按 id 字典序（[packages/workspace/workspace/src/index.ts:82-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L82-L83)）
- 服务声明注入 `storageDomain` 与 `sessionPersistence`，持久化对等件缺失时服务无法启动（[packages/workspace/workspace/src/index.ts:93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L93)）
- 交给实体的宿主对象只暴露"取表 / 读会话规范目录 / 读会话 header / 记住规范目录"四件事（[packages/workspace/workspace/src/index.ts:104-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L104-L112)）
- 服务以 `workspaceRegistry` 之名注册到上下文（[packages/workspace/workspace/src/index.ts:114-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L114-L116)）
- 初始化打开 workspace 域，并用 `ctx.effect` 注册卸载时关闭域（[packages/workspace/workspace/src/index.ts:120-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L120-L124)）
- 初始化顺序为：先补完待决变更、再校验存储状态（[packages/workspace/workspace/src/index.ts:126-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L126-L127)）
- 尚未初始化过时，列出全部持久化 header、重建索引并跑一次性历史引导（[packages/workspace/workspace/src/index.ts:128-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L128-L131)）
- 已初始化且表非空时，仍重建一次 header 索引（[packages/workspace/workspace/src/index.ts:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L132-L134)）
- 随后索引活跃会话、再校验一次状态、重建实体缓存并把被过滤掉的候选会话逐条告警（[packages/workspace/workspace/src/index.ts:136-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L136-L139)）
- `create()` 先经 `realpath` 规范化，非目录直接拒绝，然后把创建动作入队串行执行（[packages/workspace/workspace/src/index.ts:158-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L158-L164)）
- `list()` 严格按持久化顺序投影实体，顺序中出现缺失实体即抛错（[packages/workspace/workspace/src/index.ts:181-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L181-L189)）
- `insertBefore()` 对未知的源或锚抛 `WorkspaceOrderInvalidError`，同位或重排后顺序不变则不写（[packages/workspace/workspace/src/index.ts:210-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L210-L224)）
- `archiveSession()` 在串行槽位上先查是否已归档（已归档直接返回不写），再确认会话确实存在，最后追加写入归档集合（[packages/workspace/workspace/src/index.ts:244-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L244-L255)）
- 会话存在性依次查活跃会话服务、header 索引、重新列出的持久化清单；列表失败向上抛而不当作"不存在"（[packages/workspace/workspace/src/index.ts:263-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L263-L268)）
- `resolveByPath()` 规范化后按路径在实体缓存里线性查找，不创建也不改动记录（[packages/workspace/workspace/src/index.ts:277-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L277-L283)）
- 同一规范路径已有实体时直接复用，不改其标题（[packages/workspace/workspace/src/index.ts:286-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L286-L288)）
- 新记录标题缺省取路径 basename，id 为 `randomUUID`，创建与更新时间同为当前 ISO 时刻（[packages/workspace/workspace/src/index.ts:290-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L290-L301)）
- 创建先入缓存，再写 `pendingMutation: create` 标记；标记写失败则回撤缓存并抛出（[packages/workspace/workspace/src/index.ts:302-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L302-L313)）
- 记录写失败时回撤缓存并回滚标记，回滚也失败则抛 `AggregateError`（[packages/workspace/workspace/src/index.ts:314-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L314-L327)）
- 第三次写把新 id 前插进显示顺序、置 `initialized: true` 并清掉标记（[packages/workspace/workspace/src/index.ts:329-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L329-L334)）
- 顺序写失败时删记录并回滚状态，任一回滚失败均抛带两个原因的 `AggregateError`（[packages/workspace/workspace/src/index.ts:335-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L335-L354)）
- 删除未知 id 时返回 false，不做任何写（[packages/workspace/workspace/src/index.ts:359-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L359-L360)）
- 删除先把"去掉该 id 的顺序 + `pendingMutation: delete` 标记"写入，再从缓存移除实体（[packages/workspace/workspace/src/index.ts:361-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L361-L371)）
- 记录删除失败时恢复缓存并回滚顺序；回滚也失败则保持缓存删除以与持久标记方向一致并抛 `AggregateError`（[packages/workspace/workspace/src/index.ts:372-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L372-L389)）
- 已提交的删除若清标记失败，只打 warn 并仍返回 true（[packages/workspace/workspace/src/index.ts:390-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L390-L400)）
- 待决恢复：标记里的 id 若仍在显示顺序中则抛不一致错误；否则删掉该表记录并清标记（[packages/workspace/workspace/src/index.ts:408-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L408-L424)）
- 历史引导按会话的规范目录把 header 分组，无法解析目录的 header 跳过（[packages/workspace/workspace/src/index.ts:429-436](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L429-L436)）
- 组内按 header 规则排序、组间按组内最新时间降序再按路径字典序（[packages/workspace/workspace/src/index.ts:437-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L437-L442)）
- 先从现有表建立"路径→id"与"会话→归属 id"两张索引，保证一个会话只被一个工作区记账（[packages/workspace/workspace/src/index.ts:444-449](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L444-L449)）
- 路径尚无记录且该组存在未被记账的会话时才新建记录，`createdAt` 取组内最新 header 的时间（[packages/workspace/workspace/src/index.ts:451-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L451-L470)）
- 路径已有记录时把历史会话并到前面、保留原有其余会话，序列不变则跳过写（[packages/workspace/workspace/src/index.ts:473-488](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L473-L488)）
- 引导后的显示顺序按"组最新时间（无组则记录创建时间）降序 → 原有顺序 → id 字典序"计算（[packages/workspace/workspace/src/index.ts:491-502](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L491-L502)）
- 顺序有变化时先以 `initialized: false` 落盘顺序，最后再单独写 `initialized: true`，使中断的引导可以安全重跑（[packages/workspace/workspace/src/index.ts:504-507](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L504-L507)）
- 状态校验拒绝顺序中重复 id 与指向缺失记录的 id（[packages/workspace/workspace/src/index.ts:512-521](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L512-L521)）
- 已初始化状态下顺序长度与表大小不等时，点名孤儿记录并抛错（[packages/workspace/workspace/src/index.ts:522-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L522-L527)）
- 两条记录声明同一路径、或同一会话被两个工作区记账，均抛出不一致错误（[packages/workspace/workspace/src/index.ts:529-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L529-L550)）
- 实体缓存按持久化顺序整体重建，每个 id 用表中记录构造新实体（[packages/workspace/workspace/src/index.ts:553-559](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L553-L559)）
- 重建索引时清空 header、规范目录与失效原因三张表再重新索引（[packages/workspace/workspace/src/index.ts:561-566](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L561-L566)）
- 单条 header 索引：无 cwd、`realpath` 失败、解析结果非目录，都记入失效原因表且不产生规范目录（[packages/workspace/workspace/src/index.ts:572-589](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L572-L589)）
- 活跃会话索引在 `sessions` 服务缺席时静默跳过（[packages/workspace/workspace/src/index.ts:592-596](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L592-L596)）
- 对每个被过滤出成员资格的候选会话打一条 warn，原因区分失效 cwd、规范目录不符与 header 缺失（[packages/workspace/workspace/src/index.ts:598-613](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L598-L613)）
- 读 header 依次走活跃会话（顺带回填缓存）、header 缓存、重新列出的持久化清单，仍无则抛错（[packages/workspace/workspace/src/index.ts:615-631](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L615-L631)）
- 服务未启动时取表或取状态直接抛错（[packages/workspace/workspace/src/index.ts:633-641](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L633-L641)）
- `setState` 先写持久化全局态、成功后才更新内存快照（[packages/workspace/workspace/src/index.ts:643-646](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L643-L646)）
- 所有注册表操作挂在一条串行链上，每次操作前先重试待决恢复；失败被吞掉以免阻塞后续操作（[packages/workspace/workspace/src/index.ts:648-657](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/index.ts#L648-L657)）

### packages/workspace/workspace/src/invariant.ts

该包的不变量伴生插件，把"实体缓存与持久化表一致"这条关系装成运行期检查。

- 订阅 `domain/changed`，只处理 workspace 域的 `workspaces` 表变更（[packages/workspace/workspace/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/invariant.ts#L29-L30)）
- 删除事件到达时缓存里仍能查到该实体，则判定有写路径绕过了注册表并 fail（[packages/workspace/workspace/src/invariant.ts:31-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/invariant.ts#L31-L39)）
- 非删除变更到达时缓存里没有对应实体，则判定缓存与表已分叉并 fail（[packages/workspace/workspace/src/invariant.ts:40-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/invariant.ts#L40-L46)）
- 安装函数声明注入 `workspaceRegistry`，注册表就绪后才装监听（[packages/workspace/workspace/src/invariant.ts:48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/invariant.ts#L48)）
- `apply` 把包名与安装函数注册进 `ctx.invariants` 并返回注销器（[packages/workspace/workspace/src/invariant.ts:56-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/invariant.ts#L56-L57)）

### packages/workspace/workspace/src/paths.ts

工作区身份的路径规范化函数，被注册表与实体在建库、解析与挂接校验时共用。

- 用 `fs.realpath` 解析尾斜杠、`..` 段与符号链接作为唯一的唯一性基准；路径不存在时以原始 `ENOENT` 拒绝（[packages/workspace/workspace/src/paths.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/paths.ts#L20-L22)）

### packages/workspace/workspace/src/spec.ts

工作区持久化域的声明：记录与全局状态的 zod 模式，以及注册表打开的域规格。

- 记录模式固定为 path/title/sessionIds/createdAt/updatedAt 五个字段，在持久化边界上校验（[packages/workspace/workspace/src/spec.ts:21-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/spec.ts#L21-L27)）
- 待决变更标记是以 `operation` 判别的联合，只允许 `create` 与 `delete` 两种（[packages/workspace/workspace/src/spec.ts:37-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/spec.ts#L37-L40)）
- 全局状态含 `initialized`、`workspaceIds`、`archivedSessionIds` 与可选的待决标记（[packages/workspace/workspace/src/spec.ts:51-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/spec.ts#L51-L56)）
- `archivedSessionIds` 带空数组默认值，使该字段出现之前写下的记录仍能解析（[packages/workspace/workspace/src/spec.ts:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/spec.ts#L54)）
- 域规格固定名为 `workspace`、版本 2，含一个 `workspaces` 表与初始全局状态（[packages/workspace/workspace/src/spec.ts:67-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/workspace/workspace/src/spec.ts#L67-L75)）

### packages/workspace/workspace/src/types.ts

工作区的公开类型词汇：`WorkspaceId` 品牌与 `Workspace` 消费接口。

- 无运行期机制

### packages/workspace/workspace/tsconfig.json

该包的 TypeScript 编译配置与工程引用列表。

- 无运行期机制
