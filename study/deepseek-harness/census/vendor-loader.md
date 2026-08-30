---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/loader
---

# vendor/loader

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、99 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/loader/README.md

插件加载器的包说明，给出挂载用法、条目字段表与对外 API 表。

- 无运行期机制

### vendor/loader/package.json

该包的 npm 清单，声明入口、导出映射、发布文件集合与可选对等依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定按包名导入时加载的运行期文件（[vendor/loader/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/package.json#L14-L15)）
- `exports` 把 `.` 解析到 `lib/index.js`，并开放 `./src/*` 与 `./package.json`（[vendor/loader/package.json:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/package.json#L16-L23)）
- `files` 限定发布产物为 `lib/index.js`、类型声明与 `src`（[vendor/loader/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/package.json#L24-L29)）
- 把取内部模块加载器用的原生扩展声明为可选对等依赖，缺失时安装不失败（[vendor/loader/package.json:32-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/package.json#L32-L40)）

### vendor/loader/src/config/entry.ts

条目树里单个已配置插件节点的实现，负责导入插件、应用配置差异、重启与回滚。

- `updateError` 把失败按 `import`/`dispose`/`apply`/`rollback` 阶段连同条目 id 与名字包装成新错误并保留 cause（[vendor/loader/src/config/entry.ts:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L24-L27)）
- `sortKeys` 把条目字段重排为 `id`、`name` 在前、`config` 在后、其余按字典序，决定写回配置文件时的键顺序（[vendor/loader/src/config/entry.ts:29-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L29-L44)）
- `replaceKeys` 就地清空并重填目标对象，使配置文件里持有的那个对象引用保持不变（[vendor/loader/src/config/entry.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L46-L49)）
- 构造时以 `Entry.key` 符号把自身挂进扩展出的上下文，并发出 `loader/entry-init`（[vendor/loader/src/config/entry.ts:53-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L53-L69)）
- `id` 取值时在父树条目 id 前缀后拼 `:` 分隔符，形成嵌套 id（[vendor/loader/src/config/entry.ts:75-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L75-L81)）
- 禁用判定沿父条目链上溯，任一祖先禁用即视为禁用，而组条目本身恒为启用（[vendor/loader/src/config/entry.ts:86-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L86-L98)）
- `disabled` 字段若是 `!!js` 表达式节点则对条目上下文求值，原始节点仍留在选项里以便原样写回（[vendor/loader/src/config/entry.ts:100-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L100-L112)）
- `_patchContext` 走 `loader/patch-context` 瀑布链，在链尾把条目上下文原型接回父组上下文，并在 config 变化或是组条目时更新已运行的 fiber（[vendor/loader/src/config/entry.ts:114-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L114-L122)）
- `refresh` 只在条目未运行且未被禁用时才初始化（[vendor/loader/src/config/entry.ts:124-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L124-L128)）
- `_dispose` 先摘掉 fiber 引用再计数 `_disposing` 地卸载，使卸载期间的自我卸载检测可识别是加载器主动所为（[vendor/loader/src/config/entry.ts:130-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L130-L139)）
- `update` 在非 create 模式下把传入字段合进旧选项，值为 null/undefined 的键被删除，然后重排键序（[vendor/loader/src/config/entry.ts:142-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L142-L155)）
- 以深比较算出变化字段集合，无变化且非 force 时直接返回，不触碰运行中的插件（[vendor/loader/src/config/entry.ts:157-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L157-L160)）
- 条目原本未运行时直接换上新选项并按需初始化，失败则把选项恢复为旧值再抛（[vendor/loader/src/config/entry.ts:166-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L166-L179)）
- 新选项判定为禁用时卸载 fiber 并提交，卸载失败恢复旧选项并抛 `dispose` 错误，成功后发出 `loader/partial-dispose`（[vendor/loader/src/config/entry.ts:181-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L181-L192)）
- 只有 `name`、`inject`、`group` 变化才走替换路径；其余变化只重打上下文补丁，失败时恢复旧选项并再打一次补丁回滚，回滚也失败则聚合抛出（[vendor/loader/src/config/entry.ts:194-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L194-L212)）
- 替换路径下 `name` 变化才重新导入模块，否则复用旧 runtime 的回调；导入失败抛 `import` 错误（[vendor/loader/src/config/entry.ts:214-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L214-L221)）
- 替换时先卸载旧 fiber，卸载失败恢复旧选项并抛 `dispose` 错误（[vendor/loader/src/config/entry.ts:223-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L223-L230)）
- 新插件启动失败时用旧插件重启回原状态，回滚也失败则抛聚合错误，否则抛 `apply` 错误（[vendor/loader/src/config/entry.ts:232-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L232-L245)）
- `getOuterStack` 沿条目链拼出 `baseUrl#id` 形式的伪调用栈，作为插件注册时的外层栈（[vendor/loader/src/config/entry.ts:248-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L248-L256)）
- `init` 用 `_initTask` 去重并发初始化，结束后若整棵树已无任务则通知 `loader` 服务可用，然后等待 fiber 结算（[vendor/loader/src/config/entry.ts:258-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L258-L267)）
- `_await` 把 fiber 的结算失败包装成 `apply` 错误（[vendor/loader/src/config/entry.ts:269-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L269-L275)）
- `_init` 分别把导入失败与启动失败标注成 `import` 与 `apply` 两个阶段（[vendor/loader/src/config/entry.ts:277-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L277-L289)）
- `_start` 依次打上下文补丁、打 apply 日志、以条目 config 注册插件并等待其结算，任一步失败即卸载刚建的 fiber 后抛出（[vendor/loader/src/config/entry.ts:291-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L291-L302)）

### vendor/loader/src/config/group.ts

子条目表的运行期宿主，以及把嵌套条目表挂成插件的 `Group` 类，被 group 包默认导出复用。

- 构造时把自身登记为所属条目的 `subgroup`（[vendor/loader/src/config/group.ts:6-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L6-L14)）
- `create` 保证 id 存在，复用同 id 的既有条目或新建，改写父组引用后以 create+force 应用选项；失败时恢复父组引用或删掉新建的条目再抛（[vendor/loader/src/config/group.ts:20-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L20-L40)）
- `unlink` 按对象引用把条目选项从本组的数据表里摘掉（[vendor/loader/src/config/group.ts:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L42-L46)）
- `remove` 卸载条目、非整体卸载时从数据表摘掉、从树的 store 删除，并发出 `loader/partial-dispose`（[vendor/loader/src/config/group.ts:48-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L48-L57)）
- `update` 先补齐并检查 id，发现重复 id 直接抛 `TypeError`（[vendor/loader/src/config/group.ts:59-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L59-L65)）
- 新表里所有条目并发创建并全部结算；若本组的 fiber 已被卸载则直接返回，不再回滚（[vendor/loader/src/config/group.ts:70-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L70-L75)）
- 单个失败原样抛出、多个失败聚合抛出（[vendor/loader/src/config/group.ts:76-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L76-L80)）
- 全部成功后卸载新表中不再出现的旧 id，并把生效数据换成新表（[vendor/loader/src/config/group.ts:81-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L81-L84)）
- 失败时逆序卸载本次新增的条目、按旧表重建全部条目并把数据回退，回滚过程中的错误与原错误一起聚合抛出（[vendor/loader/src/config/group.ts:85-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L85-L105)）
- `stop` 按当前数据表逐个卸载子条目（[vendor/loader/src/config/group.ts:108-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L108-L112)）
- `Group` 带组标记符号并挂到所属条目的父树上，构造时监听 `internal/update` 把新 config 当子条目表整体更新（[vendor/loader/src/config/group.ts:115-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L115-L123)）
- `Group` 初始化先 yield 停止函数再按 config 建立子条目（[vendor/loader/src/config/group.ts:125-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L125-L128)）

### vendor/loader/src/config/isolate.ts

按条目的 `isolate`/`intercept` 选项改写服务符号与拦截配置的加载器钩子，在 Loader 构造时被挂载。

- `swap` 用属性描述符整体替换目标对象的自有键，保持对象引用不变（[vendor/loader/src/config/isolate.ts:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L16-L23)）
- `Realm.access` 在 create 模式下缓存符号、否则每次返回一个新的一次性符号（[vendor/loader/src/config/isolate.ts:26-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L26-L46)）
- 条目本地域以 `#条目id` 作符号后缀（[vendor/loader/src/config/isolate.ts:48-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L48-L57)）
- 具名域以 `@标签` 作符号后缀，使同标签的条目共享同一实现（[vendor/loader/src/config/isolate.ts:59-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L59-L68)）
- `access` 依 `isolate[name]` 的取值选条目本地域或具名域，未配置时返回空（[vendor/loader/src/config/isolate.ts:75-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L75-L89)）
- 条目初始化时给其上下文的 intercept 与 isolate 两张表各套一层原型，使条目改写不污染父级（[vendor/loader/src/config/isolate.ts:91-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L91-L94)）
- 打上下文补丁时先按 `isolate` 配置生成以父级表为原型的新符号映射（[vendor/loader/src/config/isolate.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L96-L101)）
- 逐个服务比较新旧符号，给变化的服务打一个 delimiter 标记并记录新旧符号与两侧标记；服务符号有实现但无 fiber 时 warn（[vendor/loader/src/config/isolate.ts:103-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L103-L120)）
- 把两张表的原型重接到父组、并整体换成新映射与条目声明的 intercept（[vendor/loader/src/config/isolate.ts:122-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L122-L126)）
- 在这些改写之后才调用 `next()` 让 fiber 重载（[vendor/loader/src/config/isolate.ts:128-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L128-L129)）
- 重载后把旧符号下的服务实现搬到新符号并删除旧键（仅在两侧标记一致且新符号尚未有实现时）（[vendor/loader/src/config/isolate.ts:131-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L131-L137)）
- 对变化的服务名做定向通知，只唤醒符号与标记匹配上的上下文（[vendor/loader/src/config/isolate.ts:139-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L139-L145)）
- 清除新映射中已不存在的服务名对应的 delimiter 标记（[vendor/loader/src/config/isolate.ts:147-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L147-L152)）
- 条目部分卸载时对具名域做回收：仍有条目引用该标签就保留，否则删掉该服务名并在域空时删掉整个域（[vendor/loader/src/config/isolate.ts:155-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L155-L172)）

### vendor/loader/src/config/tree.ts

条目树的抽象基类，提供遍历、等待、id 解析、增删改与模块导入，持久化交由子类实现。

- 嵌套 id 的分隔符固定为 `:`（[vendor/loader/src/config/tree.ts:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L8)）
- 构造时扩展出带 `baseUrl` 的上下文、建立根组，并把自身登记为所属条目的 `subtree`（[vendor/loader/src/config/tree.ts:15-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L15-L20)）
- `entries()` 递归产出本树与所有子树的条目（[vendor/loader/src/config/tree.ts:26-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L26-L33)）
- `getTasks()` 汇总所有条目的初始化任务或 fiber 的进行中任务（[vendor/loader/src/config/tree.ts:35-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L35-L40)）
- `await()` 循环等待任务清空，再逐条结算并把单个失败原样抛出、多个失败聚合抛出，随后通知 `loader` 服务并在仍有新任务时继续循环（[vendor/loader/src/config/tree.ts:42-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L42-L64)）
- `ensureId` 为无 id 的条目随机生成 8 位十六进制 id 并保证不与 store 冲突（[vendor/loader/src/config/tree.ts:66-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L66-L73)）
- `resolve` 按 `:` 逐级下钻子树，任一层缺失即抛「无法解析条目」（[vendor/loader/src/config/tree.ts:75-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L75-L87)）
- `resolveGroup` 空 id 返回根组，条目不是组时抛错（[vendor/loader/src/config/tree.ts:89-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L89-L94)）
- `create` 在指定组建立条目后按位置插入数据表并触发持久化（[vendor/loader/src/config/tree.ts:96-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L96-L104)）
- `remove` 从条目所属组卸载后触发该组所在树的持久化（[vendor/loader/src/config/tree.ts:106-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L106-L111)）
- `update` 在指定 parent 时先把条目移到目标组的指定位置，再应用选项（[vendor/loader/src/config/tree.ts:113-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L113-L124)）
- 应用失败且发生过移动时把条目挪回原组原位置并重新应用一次，回滚失败则聚合抛出（[vendor/loader/src/config/tree.ts:125-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L125-L139)）
- 成功后对源树持久化，跨树移动时目标树也持久化（[vendor/loader/src/config/tree.ts:140-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L140-L141)）
- `import` 对 `cordis:` 前缀的名字直接取内建插件表，不走模块解析（[vendor/loader/src/config/tree.ts:144-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L144-L148)）
- 其余名字在 `composeError` 内导入并把栈偏移加 3 以跳过加载器内部帧，有内部加载器时走它、否则相对 `baseUrl` 或按裸名字动态 import（[vendor/loader/src/config/tree.ts:149-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L149-L162)）
- `write()` 声明为抽象方法，由子类决定条目变更是否落盘（[vendor/loader/src/config/tree.ts:164-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L164-L165)）

### vendor/loader/src/config/utils.ts

条目配置里 `!!js` 表达式节点的求值与递归替换工具，被条目、Loader 与 include 包使用。

- `evaluate` 用 `new Function` 构造出带 `with (ctx)` 的求值器，使表达式直接读到上下文上的服务与属性（[vendor/loader/src/config/utils.ts:3-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/utils.ts#L3-L9)）
- `interpolate` 递归遍历数组与对象，把每个表达式节点替换成求值结果，其余值原样返回（[vendor/loader/src/config/utils.ts:11-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/utils.ts#L11-L22)）
- `isJsExpr` 以「对象且含 `__jsExpr` 键」判定表达式节点，YAML 方言与禁用判定都以此为准（[vendor/loader/src/config/utils.ts:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/utils.ts#L24-L27)）

### vendor/loader/src/index.ts

加载器服务本体：持有根条目树、注册全局配置与生命周期钩子、导入插件并归一其导出。

- `envData` 优先解析环境变量 `CORDIS_SHARED`，否则以当前时刻作为启动时间（[vendor/loader/src/index.ts:68-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L68-L70)）
- 构造时探测并持有 Node 内部模块加载器，供导入与热替换使用（[vendor/loader/src/index.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L73)）
- 维护 `builtins` 字典，供 `cordis:` 前缀的条目名直接取用（[vendor/loader/src/index.ts:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L75)）
- 配置里给了 `baseUrl` 就覆盖树上下文的 baseUrl，决定相对插件名的解析基准（[vendor/loader/src/index.ts:77-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L77-L81)）
- 定义服务追踪描述并把自身以 `loader` 名注册到反射表，附带可用性检查函数（[vendor/loader/src/index.ts:84-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L84-L90)）
- 全局 `internal/config` 钩子对条目根 fiber 的 config 做表达式插值；带组标记的插件（Group、Include）配置保持字面（[vendor/loader/src/index.ts:92-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L92-L101)）
- 全局前置的 `internal/update` 钩子在更新完成后把新 config（若插件 Config 提供 `simplify` 则先简化）写回条目选项并触发持久化，`noSave` 时跳过（[vendor/loader/src/index.ts:103-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L103-L109)）
- 另一个 `internal/update` 钩子在条目根 fiber 上打 reload 日志后继续链（[vendor/loader/src/index.ts:111-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L111-L115)）
- `internal/plugin` 钩子把父上下文携带的条目挂到新 fiber 上，并把条目声明的 `inject` 并入 fiber 的注入需求（[vendor/loader/src/index.ts:117-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L117-L123)）
- 自我卸载检测逐条排除：fiber 仍在创建、不受加载器跟踪、是条目下的子插件三种情形直接返回（[vendor/loader/src/index.ts:125-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L125-L135)）
- 插件已从注册表删除（热替换路径）时不视作自我卸载（[vendor/loader/src/index.ts:137-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L137-L140)）
- 条目所在树正在卸载时不视作自我卸载（[vendor/loader/src/index.ts:142-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L142-L144)）
- 加载器自身正在替换或移除该 fiber 时不视作自我卸载（[vendor/loader/src/index.ts:146-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L146-L147)）
- 走到这里即打 unload 日志；若条目已判定为禁用则到此为止（[vendor/loader/src/index.ts:149-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L149-L152)）
- 其余情况把条目选项标记为 `disabled: true` 并触发持久化，使插件自行卸载被写回配置（[vendor/loader/src/index.ts:154-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L154-L156)）
- 构造末尾挂上 isolate 钩子插件（[vendor/loader/src/index.ts:159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L159)）
- 根树的 `write()` 实现为空操作，根条目表只存在于内存（[vendor/loader/src/index.ts:162-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L162-L164)）
- 服务可用性检查在拦截配置声明 `await` 且树上仍有任务时返回 false，使依赖方保持挂起（[vendor/loader/src/index.ts:166-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L166-L170)）
- `showLog` 对组条目或未开日志的树不输出，否则以 loader 日志器打出类型与插件名（[vendor/loader/src/index.ts:172-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L172-L175)）
- `locate` 沿 fiber 的父链上溯，返回第一个带条目的 fiber 的条目 id（[vendor/loader/src/index.ts:177-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L177-L185)）
- `exit()` 为空实现，由能重启进程的宿主覆盖（[vendor/loader/src/index.ts:187-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L187-L189)）
- `unwrapExports` 依次剥 `default`，并对带 `__esModule` 标记的对象再剥一层，归一 ESM/CJS 导出形状（[vendor/loader/src/index.ts:191-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L191-L199)）

### vendor/loader/src/internal.ts

Node 内部 ESM 加载器的类型描述与获取入口，Loader 与热替换据此跨 Node 版本操作模块缓存。

- `requireInternal` 在带 `--expose-internals` 时先直接 require 内部模块，失败则退回原生扩展的 `requireBuiltin`，两条路径都失败时返回 undefined（[vendor/loader/src/internal.ts:108-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/internal.ts#L108-L118)）
- `fromInternal` 缓存已取到的加载器，按 Node 主版本号给它打上 `v2`（≥24）或 `v1`（≥22）标记，低版本返回 undefined（[vendor/loader/src/internal.ts:120-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/internal.ts#L120-L131)）

### vendor/loader/tsconfig.json

该包的 TypeScript 编译配置，供仓库构建与类型检查使用。

- 无运行期机制

### vendor/loader/tsdown.config.ts

该包的打包配置，决定发布到 `lib/` 的运行期产物形状。

- 以 `lib/types/index.js` 为唯一入口输出到 `lib`，格式 esm、目标 es2024、关闭代码分割与 dts，且不清理输出目录（[vendor/loader/tsdown.config.ts:3-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/tsdown.config.ts#L3-L16)）
