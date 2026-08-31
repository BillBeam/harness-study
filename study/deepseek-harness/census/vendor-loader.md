---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/loader
---

# vendor/loader

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、88 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/loader/README.md

该包的说明文档，列出条目字段表与加载器对外 API 表。

- 无运行期机制

### vendor/loader/package.json

该包的发布清单，供包管理器与运行期模块解析读取。

- `exports` 把包名解析到 `lib/index.js`，`main`/`types` 给出同一入口（[vendor/loader/package.json:14-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/package.json#L14-L23)）
- `files` 限定发布进包的内容为 `lib/index.js`、类型声明与 `src`（[vendor/loader/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/package.json#L24-L29)）
- 把取内部模块的原生插件声明为可选 peer 依赖，其缺席不阻断安装（[vendor/loader/package.json:32-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/package.json#L32-L40)）

### vendor/loader/src/config/entry.ts

单个已配置插件节点：合并配置、决定启停、导入并注册插件，失败时回滚。

- `updateError` 按 import/dispose/apply/rollback 阶段统一包装失败原因（[vendor/loader/src/config/entry.ts:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L24-L27)）
- `sortKeys` 把 `id`/`name` 提前、`config` 置后、其余按字母序排，决定写回配置文件的键序（[vendor/loader/src/config/entry.ts:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L39-L44)）
- 构造时从加载器上下文扩展出带条目标记的上下文，并发出 `loader/entry-init`（[vendor/loader/src/config/entry.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L66-L69)）
- 条目 id 在有父条目时用分隔符逐级拼接（[vendor/loader/src/config/entry.ts:75-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L75-L81)）
- 禁用判定：group 恒为启用；自身或祖先链上任一条目禁用即视为禁用（[vendor/loader/src/config/entry.ts:88-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L88-L98)）
- `disabled` 为表达式节点时在条目上下文求值，原始节点留在选项里以便原样写回（[vendor/loader/src/config/entry.ts:100-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L100-L108)）
- `_patchContext` 走 `loader/patch-context` 瀑布，把条目上下文原型重挂到父组，并在 config 变化或是 group 时以不写回的方式更新 fiber（[vendor/loader/src/config/entry.ts:114-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L114-L122)）
- `refresh` 只在没有 fiber 且未被禁用时才初始化（[vendor/loader/src/config/entry.ts:124-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L124-L128)）
- `_dispose` 在销毁期间维持计数，供加载器区分自我销毁与加载器主动替换（[vendor/loader/src/config/entry.ts:130-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L130-L139)）
- 更新时把空值键删除、非空值键覆盖，得到候选选项（[vendor/loader/src/config/entry.ts:142-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L142-L154)）
- 按深比较算出变更键集合，无变更且非强制时直接返回（[vendor/loader/src/config/entry.ts:157-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L157-L160)）
- 没有活跃 fiber 时直接初始化，失败则把选项恢复成更新前的值再抛出（[vendor/loader/src/config/entry.ts:166-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L166-L179)）
- 候选选项判为禁用时销毁现有 fiber 并发出 `loader/partial-dispose`（[vendor/loader/src/config/entry.ts:181-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L181-L192)）
- `name`/`inject`/`group` 都没变时只重打上下文；失败则回滚选项并再打一次，回滚也失败时抛聚合错误（[vendor/loader/src/config/entry.ts:194-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L194-L212)）
- `name` 变化时重新导入模块，未变则复用旧运行时的回调；导入失败抛 import 阶段错误（[vendor/loader/src/config/entry.ts:214-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L214-L221)）
- 先销毁旧 fiber 再启动新插件；启动失败则用旧插件重启，重启也失败抛聚合错误（[vendor/loader/src/config/entry.ts:223-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L223-L245)）
- `getOuterStack` 逐级拼出 `baseUrl#id` 形式的外层调用栈行（[vendor/loader/src/config/entry.ts:248-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L248-L256)）
- `init` 对并发调用做单飞，结束后若全树无待办任务则通知 `loader` 服务变化，再等待 fiber 就绪（[vendor/loader/src/config/entry.ts:258-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L258-L267)）
- `_await` 把 fiber 就绪失败包成 apply 阶段错误（[vendor/loader/src/config/entry.ts:269-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L269-L275)）
- 初始化按 import、apply 两阶段分别包错（[vendor/loader/src/config/entry.ts:277-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L277-L289)）
- 启动顺序为打上下文 → 打 apply 日志 → 向注册表注册插件 → 等 fiber 就绪，任一步失败即销毁刚建的 fiber 后抛出（[vendor/loader/src/config/entry.ts:291-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/entry.ts#L291-L302)）

### vendor/loader/src/config/group.ts

一组子条目的运行期宿主，负责按条目列表建/删/改子条目并在失败时整体回滚；同文件的 Group 插件把它挂成嵌套组。

- 构造时把自身挂到所属条目的 `subgroup` 上（[vendor/loader/src/config/group.ts:11-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L11-L14)）
- `create` 确保 id、复用或新建条目对象、改写父组引用，并以强制创建方式更新；失败时把父组引用还原或从 store 删除新建项（[vendor/loader/src/config/group.ts:20-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L20-L40)）
- `unlink` 从本组数据列表里摘掉一份条目选项（[vendor/loader/src/config/group.ts:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L42-L46)）
- `remove` 销毁条目、按需摘链、删 store 并发出 `loader/partial-dispose`（[vendor/loader/src/config/group.ts:48-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L48-L57)）
- 更新前校验新列表中的 id 不重复，重复即抛错（[vendor/loader/src/config/group.ts:62-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L62-L65)）
- 并发创建全部新条目并收集结果，不因首个失败提前中断（[vendor/loader/src/config/group.ts:70-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L70-L71)）
- 本组所在 fiber 已被卸载时直接返回，不再回滚（[vendor/loader/src/config/group.ts:72-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L72-L75)）
- 单个失败原样抛出，多个失败合成聚合错误（[vendor/loader/src/config/group.ts:76-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L76-L80)）
- 全部成功后移除新列表中不再出现的旧条目，并把数据列表切到新配置（[vendor/loader/src/config/group.ts:81-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L81-L84)）
- 失败时按逆序移除本次新增的条目、按旧配置重建全部条目、把数据列表还原；回滚过程中的失败并入聚合错误一起抛出（[vendor/loader/src/config/group.ts:85-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L85-L105)）
- `stop` 逐个移除数据列表中的全部子条目（[vendor/loader/src/config/group.ts:108-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L108-L112)）
- Group 插件带组标记符号，使加载器对它的配置保持字面而不做表达式插值（[vendor/loader/src/config/group.ts:116-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L116-L118)）
- Group 挂到所属条目的父树上，并监听自身配置更新以重算子条目列表（[vendor/loader/src/config/group.ts:120-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L120-L123)）
- Group 初始化先让出停机 disposer，再按初始配置建立子条目（[vendor/loader/src/config/group.ts:125-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/group.ts#L125-L128)）

### vendor/loader/src/config/isolate.ts

按条目的 `isolate`/`intercept` 选项把服务实现隔离到不同符号域的插件，由加载器构造时自动挂载。

- `swap` 清空目标对象的自有键后按源对象的属性描述符逐个重新定义（[vendor/loader/src/config/isolate.ts:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L16-L23)）
- 域的 `access` 在 create 时缓存并复用符号，非 create 时返回一次性的新符号（[vendor/loader/src/config/isolate.ts:31-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L31-L37)）
- 条目局部域的符号后缀取 `#条目id`（[vendor/loader/src/config/isolate.ts:48-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L48-L57)）
- 具名共享域的符号后缀取 `@标签`，同标签的条目共用一个域（[vendor/loader/src/config/isolate.ts:59-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L59-L68)）
- `isolate` 值为 `true` 走条目局部域，为字符串标签则走同名共享域（非 create 时不新建域）（[vendor/loader/src/config/isolate.ts:75-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L75-L89)）
- 条目初始化时给其上下文的 intercept 与 isolate 映射各建一层原型（[vendor/loader/src/config/isolate.ts:91-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L91-L94)）
- 打上下文时先以父组映射为原型生成新的 isolate 映射（[vendor/loader/src/config/isolate.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L96-L101)）
- 对新旧符号不同的服务名生成 delim 标记并算出四元组差异，实现缺失 fiber 时告警（[vendor/loader/src/config/isolate.ts:103-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L103-L120)）
- 重挂原型并把 isolate 与 intercept 映射原地换成新值（[vendor/loader/src/config/isolate.ts:122-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L122-L126)）
- 在符号切换与实现搬迁之间调用 `next()` 完成 fiber 重载（[vendor/loader/src/config/isolate.ts:128-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L128-L129)）
- 同源且新符号尚无实现时，把服务实现从旧符号迁到新符号并删除旧槽（[vendor/loader/src/config/isolate.ts:131-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L131-L137)）
- 按谓词向受影响的上下文广播服务变化通知（[vendor/loader/src/config/isolate.ts:139-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L139-L145)）
- 清理新映射中已不存在的服务名对应的 delim 标记（[vendor/loader/src/config/isolate.ts:147-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L147-L152)）
- 条目部分销毁时回收共享域：仍有条目引用该标签则保留，否则删除该服务名，域清空后连域一起删除（[vendor/loader/src/config/isolate.ts:155-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/isolate.ts#L155-L172)）

### vendor/loader/src/config/tree.ts

条目树的抽象基类：持有根条目组、解析嵌套 id、等待树内任务、导入插件模块，持久化由子类实现。

- 构造时扩展出带 `baseUrl` 的树上下文、建立根条目组，并把自身挂到所属条目的 `subtree`（[vendor/loader/src/config/tree.ts:15-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L15-L20)）
- `entries()` 深度遍历本树条目并递归进入嵌套子树（[vendor/loader/src/config/tree.ts:26-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L26-L33)）
- `getTasks()` 汇总各条目的初始化任务与 fiber 惯性任务（[vendor/loader/src/config/tree.ts:35-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L35-L40)）
- `await()` 循环等待任务清空，再收集各条目的就绪失败，单个原样抛出、多个合成聚合错误，并通知 `loader` 服务；期间新产生任务则重来（[vendor/loader/src/config/tree.ts:42-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L42-L64)）
- `ensureId` 为无 id 的条目随机生成不与现有 store 冲突的 id（[vendor/loader/src/config/tree.ts:66-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L66-L73)）
- `resolve` 按分隔符逐级下潜到子树，任一级缺失即抛错（[vendor/loader/src/config/tree.ts:75-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L75-L87)）
- `resolveGroup` 空 id 返回根组，目标条目不是组时抛错（[vendor/loader/src/config/tree.ts:89-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L89-L94)）
- `create` 在目标组建条目、把条目选项插入指定位置，并触发该树持久化（[vendor/loader/src/config/tree.ts:96-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L96-L104)）
- `remove` 从父组移除条目后触发父树持久化（[vendor/loader/src/config/tree.ts:106-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L106-L111)）
- `update` 支持跨组移动：先摘链并插入目标组再更新；失败时把条目按原索引放回源组并重打一次，回滚失败抛聚合错误；成功后对源树与目标树各触发一次持久化（[vendor/loader/src/config/tree.ts:113-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L113-L142)）
- `import` 对 `cordis:` 前缀的名字直接取加载器内建表；否则在错误栈补偿下优先走内部模块加载器，无内部加载器时按相对或裸说明符走动态 import（[vendor/loader/src/config/tree.ts:144-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/tree.ts#L144-L162)）

### vendor/loader/src/config/utils.ts

配置里 `!!js` 表达式节点的求值与递归替换工具，被条目与加载器的插值钩子调用。

- 用 `new Function` 生成带 `with (ctx)` 的求值器，在给定上下文作用域内 `eval` 表达式字符串（[vendor/loader/src/config/utils.ts:3-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/utils.ts#L3-L9)）
- `interpolate` 递归遍历数组与对象，把表达式节点就地替换成求值结果（[vendor/loader/src/config/utils.ts:11-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/utils.ts#L11-L22)）
- `isJsExpr` 以对象上是否有表达式字段判定表达式节点（[vendor/loader/src/config/utils.ts:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/config/utils.ts#L24-L27)）

### vendor/loader/src/index.ts

加载器服务本体：持有内存根条目树，挂上配置插值、写回、日志与自我销毁处理的全局钩子。

- 共享环境数据从 `CORDIS_SHARED` 环境变量解析，缺席时记录启动时刻（[vendor/loader/src/index.ts:68-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L68-L70)）
- 构造时探测并持有 Node 内部模块加载器（[vendor/loader/src/index.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L73)）
- 配置里给出 `baseUrl` 时覆盖上下文的基准 URL，决定后续相对说明符的解析基点（[vendor/loader/src/index.ts:78-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L78-L81)）
- 把 `loader` 服务注册到反射表，并挂上可用性检查（[vendor/loader/src/index.ts:83-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L83-L90)）
- 全局 `internal/config` 钩子对条目根 fiber 的配置做表达式插值，带组标记的插件（Group、Include）配置保持字面（[vendor/loader/src/index.ts:92-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L92-L101)）
- 前置的全局 `internal/update` 钩子在更新完成后把（必要时经 schema 简化的）配置写回条目选项并触发所属树持久化，`noSave` 时跳过（[vendor/loader/src/index.ts:103-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L103-L109)）
- 另一个全局 `internal/update` 钩子在条目更新时打 reload 日志（[vendor/loader/src/index.ts:111-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L111-L115)）
- `internal/plugin` 钩子把父上下文携带的条目挂到新 fiber 上并解析其 `inject`（[vendor/loader/src/index.ts:117-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L117-L123)）
- 同一钩子按七种情形排除非自我销毁：fiber 是新建、不受加载器跟踪、是条目下的子插件、插件已被从注册表删除、所属树正在卸载、条目正被加载器替换、条目已是禁用态（[vendor/loader/src/index.ts:125-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L125-L152)）
- 真正的自我销毁把条目选项写成禁用并触发所属树持久化（[vendor/loader/src/index.ts:154-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L154-L156)）
- 构造末尾挂载隔离插件（[vendor/loader/src/index.ts:159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L159)）
- 根树的 `write()` 是空实现，根条目只存在于内存（[vendor/loader/src/index.ts:162-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L162-L164)）
- 服务可用性检查：拦截配置要求 `await` 且树内仍有任务时判为不可用，依赖它的插件保持挂起（[vendor/loader/src/index.ts:166-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L166-L170)）
- `showLog` 对 group 条目与未开日志的树不输出（[vendor/loader/src/index.ts:172-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L172-L175)）
- `locate` 沿 fiber 父链上溯，返回拥有该 fiber 的条目 id（[vendor/loader/src/index.ts:177-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L177-L185)）
- `exit()` 为空实现，供能重启进程的宿主覆写（[vendor/loader/src/index.ts:187-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L187-L189)）
- `unwrapExports` 依次剥掉 `default`，并对带 `__esModule` 标记的导出再剥一层（[vendor/loader/src/index.ts:191-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/index.ts#L191-L199)）

### vendor/loader/src/internal.ts

Node 内部 ESM 加载器的版本兼容层：声明两代内部加载器的方法形状，并给出获取实例的入口。

- `requireInternal` 只在进程带 `--expose-internals` 时尝试直接 require 内部模块，失败则改用原生插件的内建模块加载函数，两条路都失败时返回 undefined（[vendor/loader/src/internal.ts:108-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/internal.ts#L108-L118)）
- `fromInternal` 缓存结果，按 Node 主版本取级联加载器并打上 v2（>=24）或 v1（>=22）版本标记，更低版本返回 undefined（[vendor/loader/src/internal.ts:120-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/src/internal.ts#L120-L131)）

### vendor/loader/tsconfig.json

该包的 TypeScript 编译配置，只在构建与类型检查时使用。

- 无运行期机制

### vendor/loader/tsdown.config.ts

该包的打包配置，决定 `lib/index.js` 这个运行期入口的产出形态。

- 以 tsc 产出的 `lib/types/index.js` 为唯一入口，按 ESM/node/es2024 打包到 `lib`，关闭代码分割、类型产出与清理（[vendor/loader/tsdown.config.ts:3-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/loader/tsdown.config.ts#L3-L16)）
