---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-conversation
---

# packages/client/ui-conversation

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 69 个文件、573 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-conversation/README.md

该包的说明文档，描述会话装配、外壳与标准 props、临时 composer 接管的约定，供维护者阅读。

- 无运行期机制

### packages/client/ui-conversation/package.json

该包的清单，声明入口映射、客户端插件注入、依赖与发布文件集。

- `main`/`types` 指定运行时入口与类型入口（[packages/client/ui-conversation/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./client`、`./src/*`、`./package.json` 映射到具体产物，未列出的子路径不可解析（[packages/client/ui-conversation/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/package.json#L16-L31)）
- `dsh.client.inject` 列出该客户端插件加载时必须先就绪的七个包，`platform` 限定为 `web`（[packages/client/ui-conversation/package.json:32-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/package.json#L32-L45)）
- `files` 限定发布内容为三个 bundle 与类型声明（[packages/client/ui-conversation/package.json:126-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/package.json#L126-L131)）

### packages/client/ui-conversation/src/client/apply.ts

该包的插件入口，把会话装配服务、外壳槽位、输入区与两个 dock 注册到客户端上下文。

- `inject` 声明本插件依赖的六个服务，缺失即不加载（[packages/client/ui-conversation/src/client/apply.ts:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L44-L46)）
- 无会话时用一组常量空数据源（通知、composer 阻断、词典、菜单启动器）替代真实源，保持订阅与 hook 顺序不变（[packages/client/ui-conversation/src/client/apply.ts:50-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L50-L66)）
- `scopedConversation` 在会话 scope 或其 `conversation` 服务缺失时抛错（[packages/client/ui-conversation/src/client/apply.ts:75-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L75-L83)）
- `concreteConversation` 从全局服务表取 `conversation` 实现，缺失时抛错（[packages/client/ui-conversation/src/client/apply.ts:86-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L86-L90)）
- 以 effect 注册中英文词条字典，并绑定翻译函数（[packages/client/ui-conversation/src/client/apply.ts:102-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L102-L103)）
- 提交策略绑定到指定设置命名空间，Enter 行为从该命名空间读写（[packages/client/ui-conversation/src/client/apply.ts:105-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L105-L107)）
- 向设置页注册 Enter 行为条目，暴露读取 hook 与写入回调（[packages/client/ui-conversation/src/client/apply.ts:109-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L109-L118)）
- `viewTabs` 把 `conversation.view` 槽位条目投影成标签，跳过无 id 者，label 缺省回退为 id（[packages/client/ui-conversation/src/client/apply.ts:120-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L120-L131)）
- `refreshViews` 逐项比对 id 与 label，完全相同则不写入 store（[packages/client/ui-conversation/src/client/apply.ts:133-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L133-L142)）
- 订阅槽位名册变化与语言变化，两者任一变动都重算视图标签（[packages/client/ui-conversation/src/client/apply.ts:143-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L143-L150)）
- 通过 `uiSession.provide` 把 `conversation`/`input` 两个 hook 和 `inputActions` 标准 prop 从同一会话绑定解析出来（[packages/client/ui-conversation/src/client/apply.ts:157-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L157-L170)）
- 根槽位声明十二个子槽位及其 kind 与 scope（single/list/chain、session/session-maybe/root）（[packages/client/ui-conversation/src/client/apply.ts:172-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L172-L188)）
- 无会话时 composer 阻断源用常量空源，有会话时用按会话 id 取的 store（[packages/client/ui-conversation/src/client/apply.ts:189-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L189-L192)）
- `selectWorkspace` 连接工作区拿到新会话 id 后，在新旧会话间迁移草稿文本与图片 id：图片先加入新会话成功才清空旧会话，最后打开新会话（[packages/client/ui-conversation/src/client/apply.ts:192-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L192-L211)）
- 会话体槽位声明 `conversation.view` 子列表、挂载会话存储，并把草稿镜像写入回调绑定到该会话的输入外壳（[packages/client/ui-conversation/src/client/apply.ts:215-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L215-L225)）
- 会话头槽位声明三个子槽位，并暴露切换会话的 `open`（[packages/client/ui-conversation/src/client/apply.ts:227-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L227-L240)）
- composer bar 在无会话时返回全部动作为 undefined、仅保留提交模式解析与常量空 hook 的惰性面（[packages/client/ui-conversation/src/client/apply.ts:250-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L250-L268)）
- `addImages` 先创建草稿图片，外壳拒绝则回收，非受支持媒体类型错误换成本地化文案，其余错误取 message（[packages/client/ui-conversation/src/client/apply.ts:274-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L274-L285)）
- `removeImage` 先释放服务侧图片再从输入状态移除 id（[packages/client/ui-conversation/src/client/apply.ts:286-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L286-L289)）
- `toggleCommandMenu` 先关闭弹层，再按选区前缀是否全空白判定 leading/inline，用当前 `draftRev` 作为 span 守卫打开命令源（[packages/client/ui-conversation/src/client/apply.ts:293-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L293-L305)）
- `stop` 通过会话 scope 的 conversation 发起取消，失败被吞掉（[packages/client/ui-conversation/src/client/apply.ts:306-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L306-L310)）
- `command` 在会话绑定缺失时直接返回 false，否则把整行交给会话命令入口并返回是否匹配（[packages/client/ui-conversation/src/client/apply.ts:311-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L311-L316)）
- 触发器控制器缺失时菜单启动器回落到常量空源（[packages/client/ui-conversation/src/client/apply.ts:317-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L317-L321)）
- 四个槽位注册统一挂在 `conversation` 的 inject 生成器下，随其一起装卸（[packages/client/ui-conversation/src/client/apply.ts:326-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L326-L331)）
- 装载 conversation 服务（注入输入枢纽与阻断注册表）以及待办、队列两个 dock 插件（[packages/client/ui-conversation/src/client/apply.ts:333-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/apply.ts#L333-L335)）

### packages/client/ui-conversation/src/client/context-occupancy.ts

把 token 计量投影换算成上下文占用比例，供会话与状态条展示。

- 分子优先取 `projectedTokens`，缺失时退回 `pressureTokens`（[packages/client/ui-conversation/src/client/context-occupancy.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/context-occupancy.ts#L18)）
- 分子或上下文窗口任一未知时返回 null，不显示占用（[packages/client/ui-conversation/src/client/context-occupancy.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/context-occupancy.ts#L19)）
- 百分比四舍五入并封顶在 100（[packages/client/ui-conversation/src/client/context-occupancy.ts:20-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/context-occupancy.ts#L20-L24)）

### packages/client/ui-conversation/src/client/contract/composer-blocks.ts

声明 composer 阻断项与其注册表接口，供其他插件通过 conversation 服务使用。

- 无运行期机制

### packages/client/ui-conversation/src/client/contract/composer-submission.ts

声明提交模式与键盘手势的类型别名，被输入与设置两个域共用。

- 无运行期机制

### packages/client/ui-conversation/src/client/contract/context-provenance.ts

声明日志中非用户消息的角色、来源标签与已知上下文形态的类型。

- 无运行期机制

### packages/client/ui-conversation/src/client/contract/conversation.ts

声明事件 Definition、Location、视图 Node 与视图构建器的完整接口，并提供上下文键的构造函数。

- `conversationContextKey` 用 kind 长度前缀拼接 kind 与业务 id，得到不会互相碰撞的上下文键（[packages/client/ui-conversation/src/client/contract/conversation.ts:275-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/contract/conversation.ts#L275-L277)）

### packages/client/ui-conversation/src/client/contract/input.ts

输入机的类型契约文件：提交面状态、事件与效果、触发器控制器接口，以及四个 scoped 事件的声明合并。

- 无运行期机制

### packages/client/ui-conversation/src/client/contract/queue.ts

从会话控制器的队列动词上派生队列地址、动作与行类型。

- 无运行期机制

### packages/client/ui-conversation/src/client/contract/records.ts

声明会话记录节点联合（用户、助手、steering、上下文注入、重试、错误、工具结果、压缩、命令等）的字段。

- 无运行期机制

### packages/client/ui-conversation/src/client/contract/request-inspection.ts

把一条请求头事件规范化成提示词快照，并判定它相对上一条头部引入了什么模型可见变化。

- 从请求头取配置、系统提示词（缺失记为空串）和工具清单（非数组时记为空数组）（[packages/client/ui-conversation/src/client/contract/request-inspection.ts:61-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/contract/request-inspection.ts#L61-L67)）
- 没有上一条快照且本条 reason 不是 `initial` 时只返回快照、不报变化（[packages/client/ui-conversation/src/client/contract/request-inspection.ts:68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/contract/request-inspection.ts#L68)）
- 系统提示词按字符串比较、工具清单按 JSON 序列化比较判定是否变化，两者都未变则不报变化（[packages/client/ui-conversation/src/client/contract/request-inspection.ts:69-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/contract/request-inspection.ts#L69-L72)）
- 变化记录携带事件 seq 与时间，并按无前值/两者都变/仅系统/仅工具分成 `initial`、`system-and-tools`、`system`、`tools` 四类，仅在有前值时附带前一份快照（[packages/client/ui-conversation/src/client/contract/request-inspection.ts:73-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/contract/request-inspection.ts#L73-L85)）

### packages/client/ui-conversation/src/client/contract/slots.ts

声明本包全部槽位名及其 kind/scope/owner props，并把三组标准 props 合并进槽位类型表。

- 无运行期机制

### packages/client/ui-conversation/src/client/contract/snapshot.ts

定义目标中立的会话快照与外壳阶段，并给出无绑定时的空值。

- 导出空快照常量：视图读取恒为 undefined、活跃目标集为空，供尚无会话绑定时使用（[packages/client/ui-conversation/src/client/contract/snapshot.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/contract/snapshot.ts#L12-L15)）
- `conversationPhase` 在有活跃目标、或会话既非空白又非等待首轮、或会话正在运行时判为 `active`，否则按是否尝试过提交在 `engaging` 与 `blank` 间取值（[packages/client/ui-conversation/src/client/contract/snapshot.ts:26-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/contract/snapshot.ts#L26-L34)）

### packages/client/ui-conversation/src/client/contract/views.ts

声明视图标签、一次性聚焦请求与会话级外壳存储状态的类型。

- 无运行期机制

### packages/client/ui-conversation/src/client/conversation/assembler.ts

按会话持有的增量装配引擎：把事件窗口喂给注册的 Definition，维护上下文状态与依赖，并推进各视图目标的快照构建。

- 发布节奏按 none < animation-frame < immediate 排序，多条请求取最高者（[packages/client/ui-conversation/src/client/conversation/assembler.ts:52-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L52-L69)）
- Location 数据的物化相位固定为先 step 后 turn（[packages/client/ui-conversation/src/client/conversation/assembler.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L58)）
- `insertionIndex` 用二分在按起始 seq 排序的上下文数组里定位插入点（[packages/client/ui-conversation/src/client/conversation/assembler.ts:75-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L75-L85)）
- `mergeMatches` 按 seq 归并新旧 Match，遇到重复 seq 抛错（[packages/client/ui-conversation/src/client/conversation/assembler.ts:99-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L99-L122)）
- 打包（`chunks`）条目不允许作为 start Match，直接抛错（[packages/client/ui-conversation/src/client/conversation/assembler.ts:124-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L124-L137)）
- `replaceWindow` 清空全部上下文与索引、按 seq 排序重建输入表与 Location 索引、重跑全部匹配与依赖重放，把所有上下文标脏并请求 immediate（[packages/client/ui-conversation/src/client/conversation/assembler.ts:188-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L188-L207)）
- `append` 对已存在的 seq 直接返回 none（[packages/client/ui-conversation/src/client/conversation/assembler.ts:215-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L215-L216)）
- 追加的 turn/step 边界事件走 `appendBoundary`，时间线对象换新或有 seq 位置变化都升到 immediate 并重放受影响上下文；非边界事件只做轻量索引（[packages/client/ui-conversation/src/client/conversation/assembler.ts:220-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L220-L231)）
- 追加后若有依赖者被重放则升到 immediate，并清空本次的 revised 集（[packages/client/ui-conversation/src/client/conversation/assembler.ts:232-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L232-L235)）
- `prepend` 过滤掉已知 seq，按全量输入重建 Location 索引，收集并合并旧页 Match，再重放受影响上下文；revised 非空或 hasMore 翻转时重跑依赖检查（[packages/client/ui-conversation/src/client/conversation/assembler.ts:244-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L244-L269)）
- `rebuildRegistry` 重建视图构建器后按当前输入整窗重放（[packages/client/ui-conversation/src/client/conversation/assembler.ts:275-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L275-L278)）
- `flush` 在无待替换、无脏上下文、时间线未变时直接返回 false，不产生新快照（[packages/client/ui-conversation/src/client/conversation/assembler.ts:285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L285)）
- 全量路径先整体替换 Location 数据，再为每个注册目标物化全部 Node 并调用构建器的 `replace`（[packages/client/ui-conversation/src/client/conversation/assembler.ts:286-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L286-L306)）
- 增量路径只重建脏上下文的 Node；已物化过的 Node 再返回 null 时抛错（[packages/client/ui-conversation/src/client/conversation/assembler.ts:309-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L309-L324)）
- 增量路径下无 upsert 且时间线未变的目标跳过 `apply`，其余目标带当前时间线推进快照（[packages/client/ui-conversation/src/client/conversation/assembler.ts:325-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L325-L336)）
- `snapshot`/`get` 读取某目标的最新快照，未注册构建器时返回 undefined（[packages/client/ui-conversation/src/client/conversation/assembler.ts:344-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L344-L352)）
- `activeTargets` 只收录自报 `isActive` 为 true 的目标（[packages/client/ui-conversation/src/client/conversation/assembler.ts:358-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L358-L364)）
- `dispatchInput` 让每个注册 Definition 对同一事件各自 match，记录被命中的目标；只有当兜底 Definition 的目标未被命中时才让兜底参与匹配（[packages/client/ui-conversation/src/client/conversation/assembler.ts:394-420](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L394-L420)）
- `acceptMatch` 对同一上下文的第二个 start、逆序或重复 seq、start 之前先到的 update 分别抛错（[packages/client/ui-conversation/src/client/conversation/assembler.ts:430-462](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L430-L462)）
- start Match 记录起始 seq 并把上下文插入按 kind 的有序前驱索引；每条 Match 都把上下文登记进 seq→上下文的反查表（[packages/client/ui-conversation/src/client/conversation/assembler.ts:463-471](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L463-L471)）
- start 到达时整段重放，update 只在已有 State 时调用 `update` 并推进修订号、记入 revised；最后标脏并返回 Definition 请求的节奏（缺省 immediate）（[packages/client/ui-conversation/src/client/conversation/assembler.ts:473-482](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L473-L482)）
- `applyPendingMatches` 校验同键 Match 的 Definition 与 id 一致、拒绝第二个 start，按 seq 归并进已有 Match 序列，并检查首条仍是 start（[packages/client/ui-conversation/src/client/conversation/assembler.ts:485-544](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L485-L544)）
- `replayContexts` 按起始 seq 升序重放，无 start 的上下文 State 置空并标脏（[packages/client/ui-conversation/src/client/conversation/assembler.ts:546-557](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L546-L557)）
- `replayContext` 先清空 State 再用记录依赖的 reader 跑 `start`，随后按顺序重跑全部 update，推进修订号并记入 revised 与脏集（[packages/client/ui-conversation/src/client/conversation/assembler.ts:559-590](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L559-L590)）
- `replaceDependencies` 维护键→依赖者的反向索引，旧依赖被摘除、空集被删除（[packages/client/ui-conversation/src/client/conversation/assembler.ts:592-606](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L592-L606)）
- `replayRevisedDependents` 沿反向索引做传递闭包，把所有间接依赖者一并重放（[packages/client/ui-conversation/src/client/conversation/assembler.ts:608-622](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L608-L622)）
- `readerFor` 每次 `previous(kind)` 都记录前驱键、修订号，以及"窗口外仍有历史"的缺失标记；前驱 State 或起始 seq 缺失时返回 undefined（[packages/client/ui-conversation/src/client/conversation/assembler.ts:624-650](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L624-L650)）
- `previousContext` 只向前找起始 seq 严格更小、且已有 State 的最近同 kind 上下文（[packages/client/ui-conversation/src/client/conversation/assembler.ts:652-660](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L652-L660)）
- 新发现的 start 按起始 seq 插入有序索引，尾部追加走快路径；批量插入用归并保持有序（[packages/client/ui-conversation/src/client/conversation/assembler.ts:662-693](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L662-L693)）
- `replayDependencies` 按起始 seq 升序检查每个上下文记录的依赖，前驱键、修订号或窗口缺口标记任一变化就整段重放（[packages/client/ui-conversation/src/client/conversation/assembler.ts:695-721](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L695-L721)）
- `refreshMatchLocations` 对 Location 变过的 seq 重写对应 Match 的 location 字段（含 start 引用同步），并返回受影响上下文集（[packages/client/ui-conversation/src/client/conversation/assembler.ts:723-747](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L723-L747)）
- `buildNode` 校验 Definition 返回的 Node 键与上下文键一致、target 与正在构建的目标一致，否则抛错（[packages/client/ui-conversation/src/client/conversation/assembler.ts:749-760](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L749-L760)）
- `buildLocationData` 校验发布相位与数据 kind 相符、数据 key 等于 Definition 的 kind、turn/step 为非负安全整数（[packages/client/ui-conversation/src/client/conversation/assembler.ts:762-786](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L762-L786)）
- `replaceLocationData` 逐相位累积安装，使 turn 相位的发布者能读到同一次 flush 中的 step 数据（[packages/client/ui-conversation/src/client/conversation/assembler.ts:788-800](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L788-L800)）
- `applyDirtyLocationData` 只对脏上下文按相位比较前后值并提交增量变更（[packages/client/ui-conversation/src/client/conversation/assembler.ts:802-815](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L802-L815)）
- `resetViewBuilders` 为每个注册目标新建构建器、以其 `empty` 作为初值，并置位待全量替换（[packages/client/ui-conversation/src/client/conversation/assembler.ts:817-831](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L817-L831)）
- `isLocationBoundary` 把四种 turn/step 起止事件识别为边界（[packages/client/ui-conversation/src/client/conversation/assembler.ts:834-836](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L834-L836)）
- `requireState` 在 Definition 的 start/update 返回 undefined 时抛错（[packages/client/ui-conversation/src/client/conversation/assembler.ts:838-847](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembler.ts#L838-L847)）

### packages/client/ui-conversation/src/client/conversation/assembly.ts

会话装配的根服务：持有事件与视图两个注册表、按会话的绑定，以及图片 URL 缓存与请求头解释入口。

- 绑定构造时先建快照 store，再用事件源当前窗口做一次全量替换，然后订阅事件源后续变化（[packages/client/ui-conversation/src/client/conversation/assembly.ts:44-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L44-L54)）
- `target()` 为每个目标缓存一个身份稳定的可观察源，读走装配器的视图 store、订阅走会话快照 store（[packages/client/ui-conversation/src/client/conversation/assembly.ts:56-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L56-L69)）
- `dispose` 取消挂起的动画帧并退订事件源（[packages/client/ui-conversation/src/client/conversation/assembly.ts:73-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L73-L79)）
- `accept` 对修订号相同的窗口直接忽略；修订号不连续或变更种类为 replace 时退回全量替换（[packages/client/ui-conversation/src/client/conversation/assembly.ts:86-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L86-L92)）
- prepend 整批交给装配器；append 逐条喂入并把各条请求的节奏折叠成一次发布（[packages/client/ui-conversation/src/client/conversation/assembly.ts:93-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L93-L106)）
- `publish` 对 none 不做事；animation-frame 用单个 rAF 合并多次请求；其余立即 flush（[packages/client/ui-conversation/src/client/conversation/assembly.ts:108-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L108-L119)）
- 只有装配器 flush 报告有变化时才写入新的会话快照（[packages/client/ui-conversation/src/client/conversation/assembly.ts:121-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L121-L123)）
- 会话快照由视图读取面与活跃目标集两部分构成（[packages/client/ui-conversation/src/client/conversation/assembly.ts:125-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L125-L130)）
- 两个注册表的变化都触发一次微任务合并后的全绑定重建；服务 effect 释放时丢弃全部绑定（[packages/client/ui-conversation/src/client/conversation/assembly.ts:157-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L157-L177)）
- `binding` 接受会话绑定或会话 id，未知会话抛错；同一来源绑定复用既有实例，来源换新则丢弃旧记录后重建（[packages/client/ui-conversation/src/client/conversation/assembly.ts:185-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L185-L195)）
- 每个绑定在会话自身的上下文上注册 effect，会话 scope 释放时自动丢弃该绑定（[packages/client/ui-conversation/src/client/conversation/assembly.ts:196-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L196-L203)）
- `imageUrl`/`peekImageUrl`/`seedImageUrl` 把按会话授权的图片 URL 解析、同步读取与预览接管转交给缓存（[packages/client/ui-conversation/src/client/conversation/assembly.ts:213-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L213-L238)）
- 请求头解释以服务方法形式暴露，供无法跨插件做值导入的目标包调用（[packages/client/ui-conversation/src/client/conversation/assembly.ts:250-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L250-L255)）
- `drop` 先核对表中记录仍是自己再删除并释放，避免误删已被替换的绑定（[packages/client/ui-conversation/src/client/conversation/assembly.ts:257-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/assembly.ts#L257-L262)）

### packages/client/ui-conversation/src/client/conversation/definition-registry.ts

事件与视图两个注册表共用的基类，负责唯一键校验、稳定条目缓存与订阅通知。

- 用 `Service.tracker` 把注册表实例的追踪属性指向其 ctx（[packages/client/ui-conversation/src/client/conversation/definition-registry.ts:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/definition-registry.ts#L12-L14)）
- `entries()` 返回缓存数组，注册顺序保持不变且引用稳定（[packages/client/ui-conversation/src/client/conversation/definition-registry.ts:21-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/definition-registry.ts#L21-L23)）
- `subscribe` 登记同步失效回调并返回退订函数（[packages/client/ui-conversation/src/client/conversation/definition-registry.ts:30-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/definition-registry.ts#L30-L33)）
- `registerDefinition` 对重复键抛错，注册走 ctx.effect，卸载时只在表中仍是同一实例时才移除，返回幂等 disposer（[packages/client/ui-conversation/src/client/conversation/definition-registry.ts:43-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/definition-registry.ts#L43-L61)）
- `refresh` 重建缓存数组并同步通知全部订阅者（[packages/client/ui-conversation/src/client/conversation/definition-registry.ts:64-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/definition-registry.ts#L64-L67)）

### packages/client/ui-conversation/src/client/conversation/event-registry.ts

事件 Definition 的运行期注册表，另外持有唯一的未匹配兜底 Definition。

- `register` 以 Definition 的 kind 为唯一键注册，重复时抛出带 kind 的错误（[packages/client/ui-conversation/src/client/conversation/event-registry.ts:13-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/event-registry.ts#L13-L21)）
- `registerFallback` 要求兜底必须声明 target，且全局只允许一个，安装与移除均走 effect 并刷新缓存（[packages/client/ui-conversation/src/client/conversation/event-registry.ts:28-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/event-registry.ts#L28-L43)）
- `fallbackEntry` 向装配器暴露当前兜底（[packages/client/ui-conversation/src/client/conversation/event-registry.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/event-registry.ts#L49-L51)）
- `assertDefinitionTarget` 强制 target 与 buildViewNode 必须同时出现或同时缺席（[packages/client/ui-conversation/src/client/conversation/event-registry.ts:54-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/event-registry.ts#L54-L60)）

### packages/client/ui-conversation/src/client/conversation/historical-images.ts

按会话缓存持久图片的浏览器 URL，供各会话目标共享一次读取，并随会话 scope 释放。

- 构造时注册释放 effect，插件卸载即整体销毁缓存（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L27-L29)）
- `resolve` 已销毁时直接拒绝、命中缓存时复用同一 promise、会话未知时拒绝（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:37-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L37-L45)）
- 新条目记录当前会话代号并绑定会话 scope，随后启动持久读取（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:46-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L46-L55)）
- `peek` 只同步读取已就绪的 URL，不发起任何读取（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:63-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L63-L65)）
- `seed` 在已销毁、键已存在或会话未知时拒绝接管（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:76-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L76-L82)）
- 接管的预览 URL 立即作为当前值可读，同时后台拉取持久字节；失败且当前仍是该预览时删除条目并回收 URL（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:83-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L83-L97)）
- 对 seed 启动的读取额外挂一个空 catch，避免无消费者时变成未处理拒绝（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:98-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L98-L102)）
- 缓存键由会话 id 与附件 id 拼成，跨会话不共享（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:105-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L105-L107)）
- `loadCanonical` 通过会话绑定读附件，结果非 ok 时抛出带错误码的异常（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:109-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L109-L119)）
- 环境没有 `URL.createObjectURL` 时生成 base64 的 data URL，否则用 Blob 生成对象 URL（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:120-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L120-L126)）
- 新 URL 就位后替换当前值并回收被替换的旧 URL；读取失败且没有可显示值时删除条目（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:127-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L127-L137)）
- `assertLive` 在缓存已销毁、条目被替换或会话代号已推进时中止本次读取（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:140-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L140-L146)）
- `bindScope` 对每个会话只挂一个 effect，会话 scope 释放时触发该会话的整体回收（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:148-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L148-L155)）
- `release` 推进该会话代号并删除其全部条目、回收对应 URL（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:157-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L157-L164)）
- URL 回收只执行一次，且只对 `blob:` 前缀的 URL 调用撤销（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:166-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L166-L169)）
- `dispose` 置位销毁标记、释放全部会话 scope、撤销所有已发出的 URL 并清空条目（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:171-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L171-L179)）
- `revokeUrl` 只撤销 blob URL，data URL 不做处理（[packages/client/ui-conversation/src/client/conversation/historical-images.ts:182-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/historical-images.ts#L182-L184)）

### packages/client/ui-conversation/src/client/conversation/location-index.ts

按会话维护 Turn/Step 时间线与事件到 Location 的索引，并托管各 Definition 发布的 Location 数据。

- Location 数据 store 的 `remove` 只允许原发布者移除自己的键（[packages/client/ui-conversation/src/client/conversation/location-index.ts:30-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L30-L35)）
- `set` 在同一键已被别的发布者占用时抛错，值未变时不写入也不报变化（[packages/client/ui-conversation/src/client/conversation/location-index.ts:37-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L37-L45)）
- `replace` 先按大小与逐键的发布者、值比对，完全一致就保留原 Map 引用（[packages/client/ui-conversation/src/client/conversation/location-index.ts:47-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L47-L60)）
- `payloadCoordinates` 把 payload 的 `turn === null` 解释为会话级，其余只接受非负安全整数的 turn/step（[packages/client/ui-conversation/src/client/conversation/location-index.ts:88-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L88-L98)）
- `sameStep`/`sameTurn` 用起止事件、状态、数据 store 与子步骤引用判定是否可复用旧对象（[packages/client/ui-conversation/src/client/conversation/location-index.ts:104-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L104-L114)）
- `sameLocation` 按 kind 与 turn/step 编号比较两个 Location 是否等价（[packages/client/ui-conversation/src/client/conversation/location-index.ts:116-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L116-L124)）
- `replaceData` 按 turn/step 分组重建全部数据，跨发布者的同键冲突抛错，并对所有已有与新出现的 store 都执行替换（[packages/client/ui-conversation/src/client/conversation/location-index.ts:150-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L150-L173)）
- `applyData` 先统一执行所有移除、再统一执行所有写入，避免同键搬迁时被自己的移除抹掉（[packages/client/ui-conversation/src/client/conversation/location-index.ts:180-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L180-L193)）
- `locationOf` 对未索引的事件回落到会话级 Location（[packages/client/ui-conversation/src/client/conversation/location-index.ts:200-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L200-L202)）
- `rebuild` 顺序扫描窗口：turn/start 与 step/start 推进"当前"游标，payload 显式坐标覆盖游标并在换 turn 时清空当前 step（[packages/client/ui-conversation/src/client/conversation/location-index.ts:238-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L238-L252)）
- turn/start 与 turn/end 一律不带 step；会话级事件不继承任何 turn（[packages/client/ui-conversation/src/client/conversation/location-index.ts:253-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L253-L262)）
- 四种边界事件分别写入对应 Turn/Step 草稿的起止字段（[packages/client/ui-conversation/src/client/conversation/location-index.ts:264-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L264-L272)）
- step/end 与 turn/end 在匹配当前游标时把游标清空，后续事件不再挂到已结束的 step/turn 上（[packages/client/ui-conversation/src/client/conversation/location-index.ts:274-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L274-L280)）
- Turn 与 Step 均按首次出现的 seq 排序，状态由起止事件是否存在推出 closed/open/unknown（[packages/client/ui-conversation/src/client/conversation/location-index.ts:285-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L285-L312)）
- 内容未变的 Step、Turn、turnOrder 与整个时间线对象都复用旧引用（[packages/client/ui-conversation/src/client/conversation/location-index.ts:302-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L302-L332)）
- 重建后重算坐标表、Location 表与 turn→seq 反查表，并返回 Location 发生变化的 seq 集合（[packages/client/ui-conversation/src/client/conversation/location-index.ts:333-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L333-L350)）
- `appendBoundary` 拒绝非四种边界类型的事件（[packages/client/ui-conversation/src/client/conversation/location-index.ts:358-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L358-L362)）
- 追加边界时推进当前 turn/step 游标，解析不出 turn 就抛错（[packages/client/ui-conversation/src/client/conversation/location-index.ts:364-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L364-L385)）
- 只改写所属 Turn 的 Step 列表与 Turn 对象，新 turn 才追加进 turnOrder（[packages/client/ui-conversation/src/client/conversation/location-index.ts:388-423](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L388-L423)）
- 只重算该 turn 名下的 seq 的 Location，并返回其中真正变化的（[packages/client/ui-conversation/src/client/conversation/location-index.ts:425-431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L425-L431)）
- `appendNonBoundary` 对会话级事件直接记为会话 Location，其余继承当前 turn/step 游标后索引并解析（[packages/client/ui-conversation/src/client/conversation/location-index.ts:447-467](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L447-L467)）
- Turn/Step 的数据 store 按需惰性创建并长期持有，使读取者拿到的引用保持稳定（[packages/client/ui-conversation/src/client/conversation/location-index.ts:475-493](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L475-L493)）
- `resolve` 无 turn 时给会话级，turn 不在时间线里给 unresolved，step 缺失或找不到时降级为 turn 级（[packages/client/ui-conversation/src/client/conversation/location-index.ts:501-509](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L501-L509)）
- `requireStep` 对声称 step 级却没有 step 编号的数据抛错（[packages/client/ui-conversation/src/client/conversation/location-index.ts:516-518](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/location-index.ts#L516-L518)）

### packages/client/ui-conversation/src/client/conversation/view-registry.ts

视图目标快照构建器的运行期注册表。

- `register` 以 target 为唯一键注册构建器工厂，重复注册同一 target 时抛错（[packages/client/ui-conversation/src/client/conversation/view-registry.ts:12-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/conversation/view-registry.ts#L12-L19)）

### packages/client/ui-conversation/src/client/image-labels.ts

会话输入流程自有的附件错误与限额文案模块，把宿主返回的 `attachment-error` 原因码翻成给用户看的文字。

- `imageSizeText` 把字节数除以 1024×1024，整数直出、否则保留一位小数并拼上 `MB`（[packages/client/ui-conversation/src/client/image-labels.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/image-labels.ts#L12-L15)）
- `attachmentErrorText` 按 `reason` 分支选择文案键（[packages/client/ui-conversation/src/client/image-labels.ts:32-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/image-labels.ts#L32-L53)）
- `IMAGE_DIMENSION_TOO_LARGE`、`TOO_MANY_IMAGES`、`IMAGE_TOO_LARGE`、`IMAGES_TOO_LARGE` 只有在 `limits` 存在时才返回带数值的文案，否则 `break` 落到兜底（[packages/client/ui-conversation/src/client/image-labels.ts:36-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/image-labels.ts#L36-L52)）
- `INVALID_IMAGE` 与 `IMAGE_TYPE_MISMATCH` 合并成同一条格式不支持文案（[packages/client/ui-conversation/src/client/image-labels.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/image-labels.ts#L41-L43)）
- 未命中或缺少 `limits` 的分支统一返回带 `reason` 码的 `image.sendFailed`（[packages/client/ui-conversation/src/client/image-labels.ts:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/image-labels.ts#L55)）

### packages/client/ui-conversation/src/client/index.ts

本包浏览器侧的导出入口，把装配核心、React 适配、外壳与输入插件的符号与类型重新导出，并对 cordis 的 `Context` 做声明合并。

- 无运行期机制

### packages/client/ui-conversation/src/client/input/blocks.ts

按会话维护「composer 被哪个插件挡住」的注册表，实现 `ComposerBlocks` 面，供输入栏读取自己会话的阻断状态。

- `set` 在新旧 `reason` 相同时直接返回，不写 store、不触发订阅（[packages/client/ui-conversation/src/client/input/blocks.ts:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/blocks.ts#L24-L29)）
- `storeFor` 按 `sessionId` 惰性创建初值为 `undefined` 的快照 store 并缓存（[packages/client/ui-conversation/src/client/input/blocks.ts:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/blocks.ts#L32-L38)）
- `forget` 删除该会话的 store 条目（[packages/client/ui-conversation/src/client/input/blocks.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/blocks.ts#L41-L43)）

### packages/client/ui-conversation/src/client/input/decorations.ts

草稿文本里纯文本引用 token 的扫描函数，被编辑器的 text-ref 实体变换消费。

- `TEXT_REF_RE` 要求触发字符位于行首或空白之后，后跟词形名字，且不跨换行（[packages/client/ui-conversation/src/client/input/decorations.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/decorations.ts#L24)）
- `FOLDER_REF_RE` 单独匹配以 `/` 结尾的 `@` 目录 token（含引号形式）（[packages/client/ui-conversation/src/client/input/decorations.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/decorations.ts#L25)）
- 空草稿直接返回空数组（[packages/client/ui-conversation/src/client/input/decorations.ts:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/decorations.ts#L39)）
- 只有名字精确出现在该触发字符的名单里才产出 range，且 range 起点跳过前导空白（[packages/client/ui-conversation/src/client/input/decorations.ts:41-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/decorations.ts#L41-L52)）
- 目录 token 与已有 range 重叠时被丢弃（[packages/client/ui-conversation/src/client/input/decorations.ts:59-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/decorations.ts#L59-L61)）
- 结果按起点升序排序后返回（[packages/client/ui-conversation/src/client/input/decorations.ts:63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/decorations.ts#L63)）

### packages/client/ui-conversation/src/client/input/editor/ComposerContentEditable.tsx

composer 的 contenteditable 宿主组件，把外壳持有的 Lexical 编辑器绑到一个常驻 div 上。

- 布局副作用把 `editor.setRootElement(el)` 绑上，清理时置回 `null`（[packages/client/ui-conversation/src/client/input/editor/ComposerContentEditable.tsx:28-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/ComposerContentEditable.tsx#L28-L33)）
- 另一处布局副作用把 `editable` 属性反射进 `editor.setEditable`（[packages/client/ui-conversation/src/client/input/editor/ComposerContentEditable.tsx:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/ComposerContentEditable.tsx#L34-L36)）
- DOM 上的 `contentEditable` 由 editor 非空且 `editable` 共同决定（[packages/client/ui-conversation/src/client/input/editor/ComposerContentEditable.tsx:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/ComposerContentEditable.tsx#L42)）
- 固定输出 `role="textbox"`、`aria-multiline` 与 `data-composer-input` 属性（[packages/client/ui-conversation/src/client/input/editor/ComposerContentEditable.tsx:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/ComposerContentEditable.tsx#L44-L46)）

### packages/client/ui-conversation/src/client/input/editor/DecoratorPortals.tsx

装饰器渲染循环组件，把每个装饰节点的 React 面 portal 进它自己的宿主元素。

- 初始状态直接取 `editor.getDecorators()`（[packages/client/ui-conversation/src/client/input/editor/DecoratorPortals.tsx:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/DecoratorPortals.tsx#L24-L26)）
- 布局副作用重读一次装饰集合并注册 `registerDecoratorListener`，editor 变化时重订阅（[packages/client/ui-conversation/src/client/input/editor/DecoratorPortals.tsx:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/DecoratorPortals.tsx#L27-L31)）
- editor 为 null 时整体渲染 null（[packages/client/ui-conversation/src/client/input/editor/DecoratorPortals.tsx:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/DecoratorPortals.tsx#L32)）
- 按 NodeKey 取宿主元素并以该 key 作为 portal key 建 `createPortal`，元素缺失则跳过（[packages/client/ui-conversation/src/client/input/editor/DecoratorPortals.tsx:35-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/DecoratorPortals.tsx#L35-L38)）

### packages/client/ui-conversation/src/client/input/editor/ReferenceChip.module.css

行内引用胶囊的样式表，定义 chip 的尺寸、背景、截断与失效态外观。

- 无运行期机制

### packages/client/ui-conversation/src/client/input/editor/ReferenceChip.tsx

一个行内引用胶囊的可视主体，即装饰节点的 React 面。

- `appearance` 缺省时渲染 `@` 标记字符，否则渲染 14px 的 `ReferenceIcon`（[packages/client/ui-conversation/src/client/input/editor/ReferenceChip.tsx:29-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/ReferenceChip.tsx#L29-L31)）
- `invalid` 为真时叠加失效类名，并把 `label` 写进 `title`（[packages/client/ui-conversation/src/client/input/editor/ReferenceChip.tsx:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/ReferenceChip.tsx#L28)）

### packages/client/ui-conversation/src/client/input/editor/chip-node.tsx

把一次行内引用表示成原子 Lexical 装饰节点的类，节点本身承载引用身份与插入时的展示投影。

- `getType` 注册类型标签 `reference-chip`（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L44-L46)）
- `clone` 复制全部字段并沿用原 NodeKey（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:53-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L53-L65)）
- `importJSON` 从序列化形态重建节点（新 key）（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:72-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L72-L83)）
- 构造函数把 source/ref/label/appearance/clipboardText 与 invalid 位存进实例字段（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:90-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L90-L98)）
- `exportJSON` 写出 `type`/`version` 与各字段，`appearance` 为 undefined 时省略该键（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:101-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L101-L113)）
- `createDOM` 生成 span 并写 `data-composer-chip=<source>` 与 `contenteditable="false"`（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:119-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L119-L124)）
- `updateDOM` 恒返回 false（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:127-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L127-L129)）
- `isInline` 返回 true，节点排在文本行内（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L132-L134)）
- `isKeyboardSelectable` 返回 false，方向键一步跨过、退格整体删除（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:143-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L143-L145)）
- `getTextContent` 返回 `clipboardText`，原生复制与持久化读到的是这一投影（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:148-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L148-L150)）
- `setInvalid` 经 `getWritable()` 翻转失效位，`isInvalid` 经 `getLatest()` 读取（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:156-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L156-L164)）
- `decorate` 返回带 label/appearance/invalid 的 `ReferenceChip`（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:187-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L187-L195)）
- `$createReferenceChipNode` 与 `$isReferenceChipNode` 提供铸造与类型判定（[packages/client/ui-conversation/src/client/input/editor/chip-node.tsx:203-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/chip-node.tsx#L203-L214)）

### packages/client/ui-conversation/src/client/input/editor/claim-decor.ts

命令占用期间给草稿首个 token 上色的 Lexical 变换及其手动刷新入口。

- `TOKEN_STYLE` 固定为一条内联 color 声明（[packages/client/ui-conversation/src/client/input/editor/claim-decor.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/claim-decor.ts#L12)）
- `firstTextLeaf` 取根下第一个块元素的首个文本叶，否则 null（[packages/client/ui-conversation/src/client/input/editor/claim-decor.ts:15-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/claim-decor.ts#L15-L20)）
- 变换里非首叶的节点若残留 token 样式则清空（[packages/client/ui-conversation/src/client/input/editor/claim-decor.ts:30-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/claim-decor.ts#L30-L36)）
- token 为 null 或文本不以 token 开头时同样清空样式（[packages/client/ui-conversation/src/client/input/editor/claim-decor.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/claim-decor.ts#L37-L42)）
- 文本长于 token 时用 `splitText` 把多出的部分拆出去，只给 token 节点上色（[packages/client/ui-conversation/src/client/input/editor/claim-decor.ts:43-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/claim-decor.ts#L43-L49)）
- 长度恰好相等时整节点上色（[packages/client/ui-conversation/src/client/input/editor/claim-decor.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/claim-decor.ts#L50)）
- `refreshClaimDecoration` 用非 discrete 的 `editor.update` 把首叶 `markDirty`，让变换在下一次 flush 重跑（[packages/client/ui-conversation/src/client/input/editor/claim-decor.ts:60-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/claim-decor.ts#L60-L67)）

### packages/client/ui-conversation/src/client/input/editor/composer-editor.module.css

编辑器内部装饰的样式表，目前只定义纯文本引用 token 的着色。

- 无运行期机制

### packages/client/ui-conversation/src/client/input/editor/keymap.ts

在 Lexical 命令层上注册 composer 键盘映射的模块，覆盖菜单仲裁、空格裁决、Enter 提交手势与粘贴路由。

- `isComposingEvent` 用 `isComposing`、`keyCode === 229` 与近期组合窗口三个信号共同判定输入法组合态（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L42-L46)）
- `compositionend` 之后再保持 10ms 的组合窗口（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:60-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L60-L67)）
- `registerRootListener` 在根元素换绑时摘掉旧的、挂上新的 composition 监听（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:79-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L79-L84)）
- 上/下箭头与 Tab 走 `arbitrate`，返回 `consumed` 时 `preventDefault` 并吞掉按键（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:69-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L69-L89)）
- Escape 先无条件 `dismissPopup()`，再交给 `arbitrate`（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:90-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L90-L99)）
- 空格键在组合态直接放行；`handlers.space()` 为真时 `preventDefault` 并消费（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:100-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L100-L108)）
- Shift+Enter 在 IME 判定之前就无条件放行给原生换行（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L112)）
- 组合态的 Enter 返回 true 但不 `preventDefault`，既不提交也不换行（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L113-L117)）
- 菜单仲裁对 Enter 返回非 `pass` 时消费该键（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:120-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L120-L123)）
- 其余 Enter 一律 `preventDefault`；`event.repeat` 直接吞掉，`canSubmit()` 为假也吞掉，否则以 Ctrl/Cmd 状态调 `submit`（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:124-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L124-L127)）
- 粘贴处理从 `clipboardData.items` 里挑出 file 项交 `intakeFiles`（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:133-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L133-L139)）
- 粘贴的纯文本非空时 `preventDefault` 并走 `pasteText`；文本为空且无文件则返回 false 交回默认路径（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:140-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L140-L148)）
- 全部命令都注册在 `COMMAND_PRIORITY_CRITICAL`，先于 plain-text 插件的默认行为（[packages/client/ui-conversation/src/client/input/editor/keymap.ts:85-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/keymap.ts#L85-L149)）

### packages/client/ui-conversation/src/client/input/editor/projection.ts

把一份 EditorState 走成三套纯文本视图的投影模块，供触发检测坐标、剪贴板/持久化文本与 occurrence 列表使用。

- `ATOMIC_CHAR` 固定为 U+FFFC，作为检测投影里 chip 的占位（[packages/client/ui-conversation/src/client/input/editor/projection.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/projection.ts#L18)）
- `$composerLayout` 一次遍历同时累积 detect 与 clipboard 两条文本、segments、按 key 的索引、子节点表与元素边界（[packages/client/ui-conversation/src/client/input/editor/projection.ts:54-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/projection.ts#L54-L131)）
- chip 在 detect 投影里贡献一个 U+FFFC，在 clipboard 投影里展开成 `getTextContent()`（[packages/client/ui-conversation/src/client/input/editor/projection.ts:82-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/projection.ts#L82-L84)）
- 文本节点两投影相同，换行节点两投影都贡献 `\n`（[packages/client/ui-conversation/src/client/input/editor/projection.ts:85-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/projection.ts#L85-L88)）
- 相邻块元素之间插入一个 `kind: 'gap'` 的单换行段（[packages/client/ui-conversation/src/client/input/editor/projection.ts:103-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/projection.ts#L103-L119)）
- `detectOffsetOfClipboardOffset` 把 clipboard 偏移折回 detect 偏移，落在 chip 展开内部时吸到该 chip 的尾边（[packages/client/ui-conversation/src/client/input/editor/projection.ts:142-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/projection.ts#L142-L151)）
- `$detectOffsetOfPoint` 分别处理 text 点（段内偏移截断）与 element 点（越界落元素末尾、否则取子段起点），未知节点返回 null（[packages/client/ui-conversation/src/client/input/editor/projection.ts:173-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/projection.ts#L173-L188)）
- `$projectComposer` 为每个 chip 段产出一条 Occurrence，携带外部分配的稳定 occurrenceId、clipboard 坐标偏移与长度，`appearance`/`invalid` 缺省时省略（[packages/client/ui-conversation/src/client/input/editor/projection.ts:199-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/projection.ts#L199-L213)）
- 选区折算成有序 range，`start === end` 时同时给出 caret，非 range 选区则两者皆 null（[packages/client/ui-conversation/src/client/input/editor/projection.ts:214-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/projection.ts#L214-L229)）

### packages/client/ui-conversation/src/client/input/editor/span-map.ts

把检测坐标下的数值区间映射回 Lexical 选区点并在那里施加编辑的模块，所有 slash/input-* 事件的编辑都经过它。

- `resolvePoint` 按半开区间归属逐段解析偏移，越界返回 null（[packages/client/ui-conversation/src/client/input/editor/span-map.ts:37-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/span-map.ts#L37-L41)）
- gap 段的偏移解析成它前一个块元素的末尾（[packages/client/ui-conversation/src/client/input/editor/span-map.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/span-map.ts#L44-L47)）
- chip 与换行这类原子段解析成其父元素上的 element 点，使得区间只能整体寻址一个 chip（[packages/client/ui-conversation/src/client/input/editor/span-map.ts:48-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/span-map.ts#L48-L54)）
- 偏移等于总长时落到最后一个块的末尾，空文档落到根（[packages/client/ui-conversation/src/client/input/editor/span-map.ts:56-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/span-map.ts#L56-L60)）
- `selectSpan` 先校验 `start <= end` 且不越界，再建 `RangeSelection` 并 `$setSelection`（[packages/client/ui-conversation/src/client/input/editor/span-map.ts:69-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/span-map.ts#L69-L80)）
- `$replaceDetectSpanWithText` 在文本为空且选区非折叠时 `removeText`，否则 `insertText`（[packages/client/ui-conversation/src/client/input/editor/span-map.ts:99-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/span-map.ts#L99-L105)）
- `$replaceDetectSpanWithNodes` 用 `insertNodes` 把节点列表插入该区间（[packages/client/ui-conversation/src/client/input/editor/span-map.ts:114-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/span-map.ts#L114-L119)）

### packages/client/ui-conversation/src/client/input/editor/text-ref.ts

纯文本引用装饰所用的 Lexical 文本实体节点及其变换注册与全量重扫入口。

- `TextRefNode.getType` 注册类型标签 `composer-text-ref`（[packages/client/ui-conversation/src/client/input/editor/text-ref.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/text-ref.ts#L26-L28)）
- `clone` 保留 NodeKey，`importJSON` 还原 format/detail/mode/style（[packages/client/ui-conversation/src/client/input/editor/text-ref.ts:35-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/text-ref.ts#L35-L51)）
- `createDOM` 在基类 span 上加装饰类名与 `data-composer-text-ref` 属性（[packages/client/ui-conversation/src/client/input/editor/text-ref.ts:62-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/text-ref.ts#L62-L67)）
- `isTextEntity` 返回 true，实体节点不与普通兄弟文本合并（[packages/client/ui-conversation/src/client/input/editor/text-ref.ts:70-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/text-ref.ts#L70-L72)）
- `getMatch` 遍历扫描结果时跳过与当前 claim token 完全相同的起始 range，把首 token 座位让给 claim 变换（[packages/client/ui-conversation/src/client/input/editor/text-ref.ts:96-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/text-ref.ts#L96-L103)）
- `registerLexicalTextEntity` 把匹配文本转成 `TextRefNode`，失配时转回普通文本（[packages/client/ui-conversation/src/client/input/editor/text-ref.ts:104-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/text-ref.ts#L104-L111)）
- `rescanTextRefs` 用队列式 update 把全部文本节点 `markDirty`，强制整篇重扫（[packages/client/ui-conversation/src/client/input/editor/text-ref.ts:120-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/editor/text-ref.ts#L120-L124)）

### packages/client/ui-conversation/src/client/input/facade.ts

每个会话一份的输入外壳，持有该会话的 Lexical 编辑器与提交状态机，负责投影发布、事件应用动词、提交事务与草稿持久化镜像。

- `guardOf` 把状态机相位映射成 plain / claimed / frozen 三档守卫（[packages/client/ui-conversation/src/client/input/facade.ts:82-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L82-L88)）
- `projectionContentChanged` 只比较两份文本与 occurrence 的身份/失效位，忽略选区与光标（[packages/client/ui-conversation/src/client/input/facade.ts:91-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L91-L98)）
- `REFERENCE_PLACEHOLDER_RE` 把 U+E100–U+E11D 与 U+FFFC 从一切外部进入文档的文本里剔除（[packages/client/ui-conversation/src/client/input/facade.ts:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L111)）
- 撤销合并窗口固定为 1000ms（[packages/client/ui-conversation/src/client/input/facade.ts:114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L114)）
- `actions` 面把 setDraft/addImages/removeImage/pruneImages 暴露出去，`submit` 固定以 `'queue'` 模式发起（[packages/client/ui-conversation/src/client/input/facade.ts:136-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L136-L142)）
- 构造时以 `dsh-composer` 命名空间建编辑器，注册 chip 与 text-ref 两种节点，`onError` 直接抛出（[packages/client/ui-conversation/src/client/input/facade.ts:174-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L174-L178)）
- 一次性挂上 plain-text 绑定、历史、update 监听、claim 装饰、text-ref 装饰与 lexicon 退订（[packages/client/ui-conversation/src/client/input/facade.ts:179-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L179-L186)）
- 订阅队列读面，队列变化即重新 publish（[packages/client/ui-conversation/src/client/input/facade.ts:188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L188)）
- `applyEdit` 在编辑器已处于 update 中时直接执行函数体并把 tag 挂到外层更新，否则起一个 discrete update（[packages/client/ui-conversation/src/client/input/facade.ts:202-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L202-L211)）
- `ensureLexiconSubscription` 在控制器可解析后订阅其 lexicon，变化时触发全量 `rescanTextRefs`（[packages/client/ui-conversation/src/client/input/facade.ts:220-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L220-L225)）
- 每次编辑器提交后重新投影，仅在内容变化时 `rev += 1` 并派发 `draft-changed`（选区变化不推进版本、不发布）（[packages/client/ui-conversation/src/client/input/facade.ts:228-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L228-L244)）
- 非恢复态下的内容变化会清空待恢复的失败发送记录（[packages/client/ui-conversation/src/client/input/facade.ts:239-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L239-L242)）
- 光标存在时把 detect 文本、光标位置、守卫档与版本号喂给触发控制器的 `track`（[packages/client/ui-conversation/src/client/input/facade.ts:245-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L245-L250)）
- `occurrenceIdOf` 给每个 chip NodeKey 分配并缓存自增 id，使 id 跨投影稳定（[packages/client/ui-conversation/src/client/input/facade.ts:253-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L253-L259)）
- `setDraft` 清洗占位符、与现值相同则不动，否则清根并按 `\n` 重建段落、光标落尾、以历史合并 tag 提交（[packages/client/ui-conversation/src/client/input/facade.ts:269-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L269-L282)）
- `addImages` 在 adjudicating/submitting 相位拒绝追加（[packages/client/ui-conversation/src/client/input/facade.ts:285-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L285-L291)）
- `removeImage` 同样在忙碌相位拒绝，且只在确实移除了一项时才发布（[packages/client/ui-conversation/src/client/input/facade.ts:298-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L298-L304)）
- `pruneImages` 只保留仍在浏览器附件注册表里的 id（[packages/client/ui-conversation/src/client/input/facade.ts:310-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L310-L316)）
- `commitSend` 从草稿图片里剔除已提交的 id 并派发 `send-committed`（[packages/client/ui-conversation/src/client/input/facade.ts:324-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L324-L328)）
- `paste` 清洗后插入当前选区，无选区时在文档末尾落点（必要时先补一个段落），并用 `PASTE_TAG` 单独成一个撤销边界（[packages/client/ui-conversation/src/client/input/facade.ts:337-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L337-L352)）
- 草稿为空但有图片时走独立的纯图片发送路径：建 AbortController、登记 flight、先 `commitSend` 再调默认 sink（[packages/client/ui-conversation/src/client/input/facade.ts:361-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L361-L369)）
- 纯图片发送失败或抛错时把图片放回草稿并弹一条 error notice（[packages/client/ui-conversation/src/client/input/facade.ts:369-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L369-L378)）
- claimed 相位下 claim 未声明接受图片却带着图片时不提交，只弹一条 notice（[packages/client/ui-conversation/src/client/input/facade.ts:386-390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L386-L390)）
- 派发 `enter` 后若进入 adjudicating/submitting，立即关闭弹层并以 frozen 档重新 track（[packages/client/ui-conversation/src/client/input/facade.ts:391-396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L391-L396)）
- `arbitrate` 转发给触发控制器，控制器缺失时返回 `'pass'`（[packages/client/ui-conversation/src/client/input/facade.ts:405-407](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L405-L407)）
- `space` 把裁决交给控制器的 `onSpace`，控制器缺失返回 false（[packages/client/ui-conversation/src/client/input/facade.ts:423-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L423-L429)）
- `caretSpan` 在没有选区时返回文档末尾的折叠区间（[packages/client/ui-conversation/src/client/input/facade.ts:442-446](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L442-L446)）
- `lexicon` 面转发控制器的聚合 store，缺席时快照为空 Map、订阅为空函数（[packages/client/ui-conversation/src/client/input/facade.ts:454-457](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L454-L457)）
- `beginCommand` 校验相位、`draftRev` 一致、span 之前只有空白，然后把 `[0, span.end)` 整体替换成 claim token 并派发 `claim`（[packages/client/ui-conversation/src/client/input/facade.ts:469-483](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L469-L483)）
- `insertReference` 校验相位与版本后把 span 替换成 chip 节点，尾随字符不是空格时补一个空格节点（[packages/client/ui-conversation/src/client/input/facade.ts:493-506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L493-L506)）
- `consumeToken` 的 span 守卫做版本比对与非空区间检查后置空替换；bare-token 守卫比对去空白草稿全等后整篇清空（[packages/client/ui-conversation/src/client/input/facade.ts:515-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L515-L527)）
- `insertText` 在版本 CAS 通过后把 span 替换成普通文本（[packages/client/ui-conversation/src/client/input/facade.ts:542-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L542-L550)）
- `notify` 递增序号并写入 notices store（[packages/client/ui-conversation/src/client/input/facade.ts:557-560](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L557-L560)）
- `dispose` 汇总草稿与未结算发送仍持有的图片 id、abort 全部图片 flight、派发 `release`、注销监听并解绑根元素，返回待释放 id（[packages/client/ui-conversation/src/client/input/facade.ts:569-587](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L569-L587)）
- `bindMirror` 绑定草稿持久化写出口并返回只在身份匹配时才解绑的 disposer（[packages/client/ui-conversation/src/client/input/facade.ts:602-607](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L602-L607)）
- `activeClaimToken` 只在 claimed 或 submitting 且存在 claim 时给出 token（[packages/client/ui-conversation/src/client/input/facade.ts:612-617](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L612-L617)）
- `dispatchRun` 在派发前后比较 token，变化时调 `refreshClaimDecoration`（[packages/client/ui-conversation/src/client/input/facade.ts:620-624](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L620-L624)）
- `run` 按顺序执行状态机返回的 effect 后统一 publish（[packages/client/ui-conversation/src/client/input/facade.ts:626-629](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L626-L629)）
- `execute` 把 notice / adjudicate / begin-submit / default-sink / commit-draft 五类 effect 分派到各自实现（[packages/client/ui-conversation/src/client/input/facade.ts:631-655](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L631-L655)）
- `commitDraft` 在当前文本以提交快照为前缀且更长时只删掉前缀（保留飞行中新输入），否则清空全文，随后派发 `CLEAR_HISTORY_COMMAND`（[packages/client/ui-conversation/src/client/input/facade.ts:662-677](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L662-L677)）
- `sinkSerialized` 取走并清空草稿图片、按 attempt 序号登记 detached 快照，无 chip 时直接调默认 sink（[packages/client/ui-conversation/src/client/input/facade.ts:685-702](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L685-L702)）
- 含 chip 时并发调 `serializeReference` 取每个引用的模型形态，再按 clipboard 偏移逐段拼接覆盖回草稿并 trim 后送入 sink（[packages/client/ui-conversation/src/client/input/facade.ts:703-725](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L703-L725)）
- 序列化过程中控制器缺席或抛错时走失败结算路径（[packages/client/ui-conversation/src/client/input/facade.ts:704-731](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L704-L731)）
- `settleSink` 按 attempt 独立结算：成功删除 detached 记录并派发 `sink-settled` ok，非成功转失败结算（[packages/client/ui-conversation/src/client/input/facade.ts:735-754](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L735-L754)）
- `settleDetachedFailure` 把图片放回、把快照移入 failed 表，并在草稿为空或正处于上次恢复版本时触发重建（[packages/client/ui-conversation/src/client/input/facade.ts:757-767](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L757-L767)）
- `restoreFailedDrafts` 按提交序号排序、用 `\n\n` 拼接，逐段重建段落与 chip 节点并平移 occurrence 偏移，随后清历史并记录恢复版本（[packages/client/ui-conversation/src/client/input/facade.ts:770-822](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L770-L822)）
- `restoreImages` 把失败发送的图片插回列表头部，且跳过已存在的 id（[packages/client/ui-conversation/src/client/input/facade.ts:825-832](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L825-L832)）
- `adjudicate` 在无控制器时以 `undefined` 结果直接结算（该行按普通消息发送），否则带上当前图片数量调控制器（[packages/client/ui-conversation/src/client/input/facade.ts:835-853](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L835-L853)）
- `beginSubmit` 只在 `claim.images === true` 时带图，序列化完成后若 attempt 已死就不再进入 `claim.submit`（[packages/client/ui-conversation/src/client/input/facade.ts:862-871](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L862-L871)）
- 命令提交成功且带图时才从草稿剔除并释放这些图片（[packages/client/ui-conversation/src/client/input/facade.ts:874-879](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L874-L879)）
- `submit-settled` 事件携带当前草稿与 outcome，error 且无文案时补一条默认文案（[packages/client/ui-conversation/src/client/input/facade.ts:880-893](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L880-L893)）
- `dead` 把已释放外壳与已 abort 的 attempt 一并判为过期，晚到的结算被丢弃（[packages/client/ui-conversation/src/client/input/facade.ts:898-900](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L898-L900)）
- `compose` 组装 InputState：草稿文本、图片 id、版本号、相位、可选 claim、occurrences 与队列覆盖（[packages/client/ui-conversation/src/client/input/facade.ts:902-913](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L902-L913)）
- `publish` 写入 state store，并在草稿文本变化时调用持久化镜像（[packages/client/ui-conversation/src/client/input/facade.ts:915-922](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/facade.ts#L915-L922)）

### packages/client/ui-conversation/src/client/input/hub.ts

会话到输入外壳的注册表实现，负责创建外壳、挂作用域事件监听、提供默认发送与队列插话编排。

- `for(actx)` 用 sessions 服务把调用者上下文解析成会话 id，解析不出就抛错（[packages/client/ui-conversation/src/client/input/hub.ts:67-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L67-L72)）
- `shellFor` 按 sessionId 复用已有外壳，否则新建并注入触发控制器、弹层、队列读面、默认 sink、队列插话与命令图片三件套（[packages/client/ui-conversation/src/client/input/hub.ts:82-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L82-L107)）
- 图片释放走 `rootCtx.get('conversation')` 的可选读取，服务已卸载时静默跳过（[packages/client/ui-conversation/src/client/input/hub.ts:99-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L99-L102)）
- 不支持图片的命令提示文案由 `t` 生成，并把 token 前导的 `/` 去掉（[packages/client/ui-conversation/src/client/input/hub.ts:103-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L103-L105)）
- 在会话作用域上注册 begin-command / insert-reference / consume-token / insert-text 四个事件监听，外壳应用成功时返回 true 终止瀑布（[packages/client/ui-conversation/src/client/input/hub.ts:111-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L111-L121)）
- 作用域释放时注销监听、dispose 外壳、删除注册表条目并逐个释放外壳交回的草稿图片（[packages/client/ui-conversation/src/client/input/hub.ts:122-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L122-L128)）
- `shell(id)` 在缺失时经 `sessions().binding(id)` 现场创建，无 binding 抛错（[packages/client/ui-conversation/src/client/input/hub.ts:139-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L139-L145)）
- `keyboard(id)` 直接把外壳当作键盘命令面返回（[packages/client/ui-conversation/src/client/input/hub.ts:154-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L154-L156)）
- `inputTriggers(id)` 经会话作用域解析可选触发控制器（[packages/client/ui-conversation/src/client/input/hub.ts:164-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L164-L167)）
- 默认 sink 在文本与图片皆空时直接返回 success，否则调 `sendSession`（[packages/client/ui-conversation/src/client/input/hub.ts:175-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L175-L184)）
- `steerQueue` 只取 `placement === 'queued'` 的行，按 FIFO 逐条严格插话（[packages/client/ui-conversation/src/client/input/hub.ts:198-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L198-L203)）
- 插话失败码为 `steer-unavailable` 或 `queue-item-not-found` 时静默停止，其他失败弹一条 notice 后停止（[packages/client/ui-conversation/src/client/input/hub.ts:204-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L204-L207)）
- 触发控制器与弹层都通过 `rootCtx.get` 惰性解析，缺席返回 undefined（[packages/client/ui-conversation/src/client/input/hub.ts:210-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L210-L218)）
- `sessions()` 与 `conversation()` 在服务缺席时抛错（[packages/client/ui-conversation/src/client/input/hub.ts:220-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/hub.ts#L220-L230)）

### packages/client/ui-conversation/src/client/input/machine.ts

每个会话一份的纯提交状态机，吃事件、吐 effect，管理相位、claim 与 attempt 生命周期。

- `unreachable` 对未知事件抛出（[packages/client/ui-conversation/src/client/input/machine.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L14-L16)）
- `argsAfter` 从提交时草稿里剥掉 claim token，token 去掉尾随空白后匹配时还会吞掉紧随的一个空白字符（[packages/client/ui-conversation/src/client/input/machine.ts:19-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L19-L28)）
- `state` getter 只对外暴露 token、可选 hint 与 `images: true`（[packages/client/ui-conversation/src/client/input/machine.ts:49-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L49-L63)）
- `dispatch` 按事件标签分派到九个处理器（[packages/client/ui-conversation/src/client/input/machine.ts:70-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L70-L83)）
- claimed 相位下草稿不再以 token 开头就释放 claim 回到 plain（[packages/client/ui-conversation/src/client/input/machine.ts:86-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L86-L92)）
- `onClaim` 只在 plain/claimed 相位接受新 claim（[packages/client/ui-conversation/src/client/input/machine.ts:95-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L95-L100)）
- `mintAttempt` 自增序号并配一个 AbortController，attempt 携带草稿快照与提交模式（[packages/client/ui-conversation/src/client/input/machine.ts:103-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L103-L113)）
- `beginAttempt` 占用唯一的 inflight 槽；`beginDetached` 登记到 detached 表并把相位拉回 plain、清掉 claim（[packages/client/ui-conversation/src/client/input/machine.ts:116-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L116-L129)）
- 普通发送的 effect 序列固定为先 `default-sink` 再 `commit-draft`，后者带提交时快照作为可保留后缀（[packages/client/ui-conversation/src/client/input/machine.ts:132-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L132-L137)）
- `onEnter`：忙碌相位无响应；claimed 直接进 submitting；去空白后为空不动；以 `/` 开头进 adjudicating；其余走脱离编辑器的普通发送（[packages/client/ui-conversation/src/client/input/machine.ts:139-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L139-L154)）
- `onAdjudicated` 丢弃相位不符或序号不匹配的结果；带 claim 的结果转 submitting，`undefined` 结果降级为普通发送（[packages/client/ui-conversation/src/client/input/machine.ts:156-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L156-L177)）
- `onAdjudicationFailed` 回到 plain 并产出一条 error notice，草稿保留（[packages/client/ui-conversation/src/client/input/machine.ts:179-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L179-L184)）
- 命令提交成功时回 plain、清 claim，并产出 `commit-draft` 加可选 notice（级别由 outcome.kind 决定）（[packages/client/ui-conversation/src/client/input/machine.ts:191-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L191-L199)）
- 命令提交失败时，草稿与提交快照相同且仍以 token 开头则退回 claimed，否则回 plain 并清 claim（[packages/client/ui-conversation/src/client/input/machine.ts:200-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L200-L208)）
- `onSinkSettled` 只结算登记过的序号，并按 ok 与 outcome.kind 决定 notice 级别（[packages/client/ui-conversation/src/client/input/machine.ts:212-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L212-L217)）
- `onSendCommitted` 只在 plain 相位产出 `retainSuffixOf: null` 的 `commit-draft`（[packages/client/ui-conversation/src/client/input/machine.ts:220-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L220-L224)）
- `onRelease` abort inflight 与全部 detached 的 controller 并复位相位与 claim（[packages/client/ui-conversation/src/client/input/machine.ts:226-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/machine.ts#L226-L236)）

### packages/client/ui-conversation/src/client/input/queue-store.ts

把一个会话的待发队列行投影成可订阅快照的小工具，供 InputState 的 queue 字段覆盖使用。

- `queueReadFaceOf` 的 `getSnapshot` 直接返回会话快照里的 queue 数组，`subscribe` 转发会话订阅（[packages/client/ui-conversation/src/client/input/queue-store.ts:20-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/queue-store.ts#L20-L25)）

### packages/client/ui-conversation/src/client/input/submission-policy.ts

composer 的提交策略对象，持有繁忙态 Enter 偏好并把键盘手势解析成 queue/steer 投递模式。

- 重导出默认繁忙态 Enter 行为常量（[packages/client/ui-conversation/src/client/input/submission-policy.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/submission-policy.ts#L16)）
- 构造时若给了持久化 scope，就订阅它并立即执行一次采纳（[packages/client/ui-conversation/src/client/input/submission-policy.ts:34-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/submission-policy.ts#L34-L40)）
- `resolve` 在非运行中或不支持插话时一律返回 `queue`；普通 Enter 用偏好值，加速键取相反值（[packages/client/ui-conversation/src/client/input/submission-policy.ts:49-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/submission-policy.ts#L49-L58)）
- `setBusyEnter` 与现值相同时直接返回，否则先发布本地值再异步写持久化字段（[packages/client/ui-conversation/src/client/input/submission-policy.ts:65-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/submission-policy.ts#L65-L69)）
- `adopt` 从 scope 快照读取 busyEnter，仅在与当前值不同时写回本地 store（不反向写持久化）（[packages/client/ui-conversation/src/client/input/submission-policy.ts:75-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/input/submission-policy.ts#L75-L79)）

### packages/client/ui-conversation/src/client/locales.ts

`conversation` 命名空间的中英文文案字典，中文字典同时充当键集来源。

- 无运行期机制

### packages/client/ui-conversation/src/client/queue/QueueDock.module.css

队列停靠条的样式表，定义面板、行、编辑框与操作按钮的外观与尺寸。

- 无运行期机制

### packages/client/ui-conversation/src/client/queue/QueueDock.tsx

输入区上方的队列停靠条组件及其槽位注册，展示并操作会话待发队列。

- 只渲染 `placement === 'queued'` 的行，过滤后为空时整体返回 null（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:28-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L28-L41)）
- 队列清空时自动折回收起态；编辑目标行消失或队列不可变时退出编辑态（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L36-L39)）
- 队列是否可变由 `subagent === null` 决定，并据此决定是否渲染整组操作按钮（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L30)）
- 编辑中或有请求在飞时强制展开并禁用折叠头部（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L43-L45)）
- 只有一行时不渲染计数头部、列表始终可见，并由该行自己带队列图标（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:76-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L76-L96)）
- `applyAction` 置 busy、调 `updateQueue`，抛错时以 error 级 notify 出去，最后按 id 复位 busy（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:47-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L47-L62)）
- `saveEdit` 拒绝全空白文本，成功后清空编辑态；提交内容包成单个 text 块（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:64-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L64-L71)）
- 编辑输入框上 Escape 取消编辑，非组合态的 Enter 阻止默认并保存（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:105-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L105-L114)）
- 行预览文本经 `projectUserText` 投影后渲染（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L117)）
- 编辑按钮在 `row.text === null` 时禁用并以原生 title 给出不支持提示（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:148-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L148-L159)）
- 删除按钮触发 `remove` 操作、插话按钮触发 `steer` 且仅在 running 时可用（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:164-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L164-L198)）
- `queueDockEntry` 以 `order: 20`、locale 为本命名空间注册进 `conversation.input.dock` 槽（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:211-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L211-L231)）
- 槽位 inject 用 `sessions.scope(sessionId)` 解析会话上下文，作用域或 conversation 服务缺失时抛错，并把 notify 接到该会话输入外壳（[packages/client/ui-conversation/src/client/queue/QueueDock.tsx:220-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/queue/QueueDock.tsx#L220-L229)）

### packages/client/ui-conversation/src/client/service.ts

按作用域寻址的会话服务，提供发送、取消、历史加载、队列操作与浏览器侧草稿图片的注册与生命周期管理。

- `browserDraftAttachment` 用 `randomUUID` 生成草稿 id 并为文件建 objectURL 预览（[packages/client/ui-conversation/src/client/service.ts:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L68-L75)）
- `probeDimensions` 用 `Image` 读原始宽高写回描述符，非浏览器环境或失败时留空（[packages/client/ui-conversation/src/client/service.ts:85-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L85-L93)）
- `nextPaint` 在页面隐藏时退化成 `setTimeout`，否则用 `requestAnimationFrame` 并挂 100ms 兜底定时器（[packages/client/ui-conversation/src/client/service.ts:96-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L96-L116)）
- `base64Of` 用 FileReader 的 data URL 编码并截掉逗号前的前缀（[packages/client/ui-conversation/src/client/service.ts:119-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L119-L131)）
- 构造时注册释放副作用：卸载时 revoke 全部预览 URL 并清空草稿表（[packages/client/ui-conversation/src/client/service.ts:165-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L165-L170)）
- `send` 把文本作为单个 text 块以 `queue` 模式发出，业务失败抛错（[packages/client/ui-conversation/src/client/service.ts:179-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L179-L183)）
- `sendSession` 先按 id 解析草稿图片，数量对不上直接抛（[packages/client/ui-conversation/src/client/service.ts:206-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L206-L209)）
- 子智能体会话走不带本地回显的直接 prompt 路径（[packages/client/ui-conversation/src/client/service.ts:210-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L210-L215)）
- 其余情况先 `beginSubmission` 放入本地回显（携带预览 URL、名称与已探测的宽高）并挂退休回调（[packages/client/ui-conversation/src/client/service.ts:216-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L216-L232)）
- 序列化在 `nextPaint` 之后才开始，失败时 `abandon` 回显并向上抛（[packages/client/ui-conversation/src/client/service.ts:233-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L233-L241)）
- 图片内容排在文本之前组成 prompt 内容，文本为空时不加 text 块（[packages/client/ui-conversation/src/client/service.ts:236-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L236-L237)）
- prompt 带上回显的 requestId；prompt 失败或退休原因不是 `observed` 都记为 error（[packages/client/ui-conversation/src/client/service.ts:242-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L242-L245)）
- `createDraftImages` 先对每个文件做 MIME 校验（不通过抛错），再注册描述符并触发尺寸探测（[packages/client/ui-conversation/src/client/service.ts:253-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L253-L261)）
- `draftImages` 按请求顺序只返回仍然存活的描述符（[packages/client/ui-conversation/src/client/service.ts:268-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L268-L275)）
- `serializeDraftImages` 在数量不符时抛错，成功时只编码不发送也不释放（[packages/client/ui-conversation/src/client/service.ts:284-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L284-L290)）
- `releaseDraftImage` 从表里删除并 revoke 预览 URL（[packages/client/ui-conversation/src/client/service.ts:296-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L296-L301)）
- `updateQueue` 对 steer 操作的 `steer-unavailable` 与 `queue-item-not-found` 静默收敛，其他失败抛错（[packages/client/ui-conversation/src/client/service.ts:312-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L312-L322)）
- `cancel` 取消在飞轮次并在失败时抛错，`loadOlder` 拉一页更旧历史（[packages/client/ui-conversation/src/client/service.ts:325-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L325-L334)）
- `scopeId` 通过 sessions 服务读取调用者上下文上的会话标签，根上下文抛错（[packages/client/ui-conversation/src/client/service.ts:345-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L345-L351)）
- `requireSessions` 用严格 `ctx.get` 而非注入代理读服务（[packages/client/ui-conversation/src/client/service.ts:353-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L353-L359)）
- `settleSubmittedImages` 只在退休原因为 `observed` 时动作：逐张出表，能种进图片缓存就交出预览 URL，否则 revoke（[packages/client/ui-conversation/src/client/service.ts:369-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L369-L384)）
- `encodeImage` 产出 `mediaType` + base64 数据（文件名非空时附带）（[packages/client/ui-conversation/src/client/service.ts:392-398](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L392-L398)）
- `imageMediaType` 白名单只放行 png/jpeg/webp/gif，其余抛 `UnsupportedImageMediaTypeError`（[packages/client/ui-conversation/src/client/service.ts:401-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L401-L411)）
- `revokePreview` 只对 `blob:` 开头的 URL 调 revoke（[packages/client/ui-conversation/src/client/service.ts:413-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/service.ts#L413-L415)）

### packages/client/ui-conversation/src/client/settings/EnterBehaviorRow.module.css

设置项行的样式表，定义标题、描述与选择器胶囊的布局与配色。

- 无运行期机制

### packages/client/ui-conversation/src/client/settings/EnterBehaviorRow.tsx

通用设置里的 composer 繁忙态 Enter 偏好行组件。

- `OPTIONS` 把可选值固定为 `queue` 与 `steer` 两项（[packages/client/ui-conversation/src/client/settings/EnterBehaviorRow.tsx:26-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/settings/EnterBehaviorRow.tsx#L26-L32)）
- 通过 `useBusyEnter` 订阅当前偏好并据此决定选中项与按钮文字（[packages/client/ui-conversation/src/client/settings/EnterBehaviorRow.tsx:40-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/settings/EnterBehaviorRow.tsx#L40-L42)）
- 菜单选择时关闭菜单并调用 `setBusyEnter` 写入新偏好（[packages/client/ui-conversation/src/client/settings/EnterBehaviorRow.tsx:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/settings/EnterBehaviorRow.tsx#L55-L58)）

### packages/client/ui-conversation/src/client/skeleton/ContextMeter.module.css

上下文占用环及其点击展开面板的样式表，由同目录 ContextMeter.tsx 以 CSS Module 方式导入。

- 面板以绝对定位挂在触发器上方 8px、z-index 100，构成浮层而非行内内容（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.module.css:40-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.module.css#L40-L56)）
- `.headline:empty` 让空的一侧文案整体从 flex 行中消失，不占间距（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.module.css:82-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.module.css#L82-L84)）
- `.segment` 设 2px 最小宽度，使任何被渲染的分段都至少可见（组件据此过滤掉零宽分段）（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.module.css:96-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.module.css#L96-L102)）
- 三个 color 类各自定义 `--meter-tint`，同一个变量同时驱动条形分段与图例色块（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.module.css:104-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.module.css#L104-L125)）

### packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx

输入条右侧的上下文占用环组件，读取 `contextPressure` / `contextBreakdown` 两个投影，由 InputBar 挂载。

- 环几何常量 RADIUS / CIRCUMFERENCE 决定后面 strokeDasharray 的计算基数（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:17-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L17-L18)）
- 用 ` ` 作为占位标记，把本地化整句切成读数前后两段（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L25)）
- ROWS 固定三项（system/tools/messages）的键、文案键与配色，同时决定条形分段顺序与图例顺序（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L28-L32)）
- formatTokens 按 1000／1000000 阈值转成 K／M 文案，且大于等于 100 时取整、否则保留一位小数（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:40-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L40-L47)）
- 订阅 `contextPressure` 与 `contextBreakdown` 两个投影键（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:56-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L56-L57)）
- 由 contextOccupancy(pressure) 派生占用读数，为 null 即视为不可用（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:60-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L60-L61)）
- 占用信息消失时强制关闭已打开的面板（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:65-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L65-L67)）
- 面板打开期间在 document 上挂 pointerdown 与 keydown：点击根节点之外关闭、Escape 关闭，卸载时移除监听（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:70-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L70-L85)）
- 无占用读数时整个组件返回 null，不渲染任何 DOM（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L87)）
- 把带占位符的本地化句子按标记切分并 trim，得到标题左右两段（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:90-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L90-L92)）
- 条形总长取自 pressure 的百分比；breakdown 缺失或合计为 0 时退化为单段，否则按三项 token 比例切分，并丢弃宽度为 0 的分段（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:98-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L98-L104)）
- 面板打开时禁用触发器的 Tooltip（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L108)）
- 触发按钮携带 aria-label／aria-haspopup="dialog"／aria-expanded，点击翻转面板开合（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:109-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L109-L116)）
- 圆环用 `strokeDasharray` 按百分比切分周长、并旋转 -90 度从顶部起画（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:117-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L117-L127)）
- 面板容器声明 role="dialog" 并带本地化 aria-label（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L131)）
- 右侧数字栏输出 `~已用 / 窗口` 两个经压缩格式化的 token 数（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:138-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L138-L140)）
- 每个分段按计算出的百分比写行内 width，并按需附加配色类（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:142-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L142-L150)）
- 仅在 breakdown 存在时渲染三行图例，每行输出该项的压缩 token 数（[packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx:151-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ContextMeter.tsx#L151-L163)）

### packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css

会话骨架的样式表，被 ConversationRoot.tsx 与 ConversationSession.tsx 共同导入，并对外声明整列共享的宽度变量。

- 根节点定义 `--dsh-chat-content-width`（用户拖拽值优先，否则按列宽 64% 在 680–920px 间夹取）以及派生的卡片最大宽度、侧向留白、dock 内缩量，供本包与下游卡片共用（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:28-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L28-L34)）
- `.headerHidden` 用 display:none 让空白态的会话头保持挂载但不占列空间（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L61-L63)）
- 宽度手柄为绝对定位条，宽度取 `min(40px, (100% - 内容宽)/2 - 48px)`，空间不足时算出负值收敛为 0，从而不留错位热区（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:214-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L214-L224)）
- 左右手柄各自按内容宽度的一半加 24px 偏移定位（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:226-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L226-L232)）
- 手柄光带用渐变读取 `--dsh-width-handle-pointer-y`（由 pointermove 写入）定位，默认 opacity 0 且不接收指针事件（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:243-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L243-L259)）
- 悬停或 `data-dragging` 时光带显现（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:269-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L269-L272)）
- 子树中出现 `[data-conversation-composer-overlay]` 时整体隐藏宽度手柄，交回点击权（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:276-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L276-L278)）
- 输入座位上声明 `--dsh-composer-text-max-height: 336px`，统一约束座位内所有可滚动文本区的高度上限（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:293-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L293-L305)）
- active 阶段根节点 overflow:hidden、头部不参与伸缩（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:310-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L310-L316)）
- 滚动体纵向 auto、横向 hidden，并无条件保留滚动条槽位 `scrollbar-gutter: stable`（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:318-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L318-L337)）
- active 阶段 viewArea 采用 `flex: 1 0 auto`，让内容撑开滚动体（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:339-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L339-L342)）
- active 阶段输入座位 sticky 贴底、z-index 7，并用固定 36px 的渐变带遮住其下方转录内容（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:344-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L344-L361)）
- 一旦滚动体内含 composer overlay 标记，改为定位上下文且 `scrollbar-gutter: auto`（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:365-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L365-L379)）
- overlay 情形下会话槽内的 viewArea 改为 `flex: 1 1 0` 且自身裁剪溢出（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:381-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L381-L385)）
- overlay 情形下输入座位改为绝对定位贴底，并按 `--dsh-scrollbar-width` 右移补偿（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:387-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L387-L400)）
- hero 形态用 flex 居中（明确避免 transform，以免成为 position:fixed 后代的包含块），宽度取卡片上限加两侧留白（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:406-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L406-L418)）
- 背景光晕绝对定位、z-index -1 且 pointer-events:none，尺寸按卡片宽度比例缩放（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:425-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L425-L434)）
- hero 阶段滚动体改为纵向居中（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:449-452](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L449-L452)）
- settling 阶段输入座位 `visibility: hidden`，保持挂载但不可见（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css:456-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.module.css#L456-L458)）

### packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx

常驻会话骨架组件：负责 hero／docked 形态判定、输入条槽位组装、列宽拖拽与若干 CSS 变量的发布。

- localStorage 键 `dsh.conversation.contentWidth`、内容宽下限 640 与两侧 176px 预算常量（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:17-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L17-L24)）
- readWidthPreference 从 localStorage 读宽度偏好，非有限数或非正数一律当作未设置（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:29-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L29-L34)）
- resolveContentWidth 复刻 CSS 的夹取：有偏好则在 640 与 `列宽-176` 间夹取，无偏好则按列宽 64% 在 680–920 间取（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L40-L44)）
- WidthHandle 在 pointerdown 时捕获指针、记录起点并向上取当前宽度作为基准（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:74-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L74-L81)）
- 拖动位移按侧别取向后乘 2 叠加到基准宽度，实现两侧对称加宽（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L66-L70)）
- pointermove 把指针的 Y 写成 `--dsh-width-handle-pointer-y`，并用 requestAnimationFrame 节流地回调 onDrag（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:82-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L82-L91)）
- pointerup 释放捕获、取消待执行帧，且只有真正发生位移的手势才调用 onCommit 持久化（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:92-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L92-L103)）
- pointercancel 与 lostpointercapture 走同一条清理路径，取消帧、清掉拖拽态并回调 onEnd（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:110-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L110-L127)）
- 组件从多个 store 选取会话、待处理交互、会话列表中的 cwd／blank、工作区列表与外部发出的发送阻断（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:136-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L136-L151)）
- shellPhase 由 conversationPhase(session, conversation) 派生，缺任一者即为 blank（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:140-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L140-L142)）
- 回调式 ref 上的 ResizeObserver 把输入座位高度写成 `--dsh-composer-height`、把滚动口高度写成 `--dsh-conversation-viewport-height`，并在重挂时先断开旧观察者（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:163-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L163-L178)）
- publishWidths 发布列宽变量 `--dsh-conversation-column-width`，并在有偏好时写入按当前列宽重夹取的 `--dsh-chat-user-width`、无偏好时移除该变量（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:187-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L187-L196)）
- 根节点的 ResizeObserver 在挂载时立刻发布一次并持续跟随列宽变化（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:197-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L197-L205)）
- 四个拖拽回调分工：onStart 取当前解析宽度、onDrag 只写行内样式、onCommit 才写 localStorage、onEnd 从存储重新发布（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:213-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L213-L235)）
- 当会话已落入所选工作区、或所选工作区在就绪列表中消失时，清空待定工作区选择（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:246-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L246-L252)）
- settling 判定：会话仍在加载且列表未证明其为空白，或可续接子会话的父可用性未知（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:266-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L266-L271)）
- hero 判定：无会话，或空白阶段且会话已打开／列表摘要已证明空白（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:272-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L272-L273)）
- 仅当会话与输入状态同时存在才组出传给左右槽位的 zone（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:274-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L274-L275)）
- 工作区标签按五级优先序解析：待定选择 → 无会话占位 → 会话所属工作区标题 → 列表加载中用 cwd 目录名兜底 → 列表就绪但无归属则回到占位（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:285-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L285-L291)）
- 工作区行渲染 chip 与 `conversation.hero.workspace` 槽位，选中即关菜单、置待定并调用 selectWorkspace，失败时回滚待定值（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:293-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L293-L316)）
- inert（无会话或 hero 下无工作区）与 blocked（外部阻断）两态互斥，前者优先（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:324-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L324-L328)）
- 无条件渲染唯一的 `conversation.composer.bar` 槽位，按 inert／blocked／hero 分别传入 disabled、占位文案、阻断对象与工作区触发回调，并挂上 overlay／左右／footer 子槽位（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:329-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L329-L349)）
- hero 时额外渲染光晕、hero 外壳与工作区行，并始终渲染 `conversation.input.dock`（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:351-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L351-L359)）
- phase 三值（settling／hero／active）写到根节点 data-phase；composer 走 renderSlotChain，带 fallback、无会话时只用 fallback、overlay 模式（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:361-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L361-L366)）
- 整条 composer 链外包一个带 `data-composer-seat` 的座位并接上尺寸观察 ref（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:372-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L372-L376)）
- 根渲染：无会话时不渲染头部与会话槽位，滚动体带 `data-conversation-scroll` 标记，宽度手柄仅在 active 阶段成对渲染（[packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx:378-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationRoot.tsx#L378-L397)）

### packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx

严格按会话渲染的头部与主体两个组件，插入 ConversationRoot 让出的常驻布局中。

- 默认视图 id 为 `chat`；resolveActiveView 先认持久化选择，落空才回退到 chat，不另选其它视图（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:26-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L26-L32)）
- deriveAncestry 沿 parentId 逆向走出面包屑链，带 seen 集合防环，遇非子代理或摘要缺失即停（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:34-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L34-L52)）
- equalBreadcrumbs 作为选择器的相等判定，按 id 与显示标题逐项比较以抑制重渲染（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:54-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L54-L60)）
- 头部在会话标记 blank 且阶段为 blank 时整体隐藏并置 aria-hidden，仅保留挂载（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:77-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L77-L84)）
- 面包屑逐项渲染按钮，末项禁用，其余点击调用 open(id) 切换会话（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:89-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L89-L104)）
- 末项或子代理项额外渲染 `conversation.session.header.lineage` 槽位：子代理项以槽位替换标题（fallback 为标题本身），非子代理项在标题后追加（fallback 为 null）（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:105-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L105-L134)）
- 面包屑为空时直接显示原始 sessionId（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L135)）
- 头部另开 actions 与 utilities 两个槽位（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:137-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L137-L143)）
- 视图页签仅在注册数量大于 1 时渲染，点击调用 actions.setView 改写持久化选择（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:145-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L145-L160)）
- 主体挂载时把持久化草稿灌回输入状态（仅当输入为空且存储非空），并绑定草稿镜像、卸载时解绑；依赖数组钉死为 inputActions 使其只在挂载时跑（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:186-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L186-L192)）
- 会话仍是空白态时主体返回 null（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L194)）
- 用 `only: active.id` 只渲染当前视图槽位，并向其传入 viewRequest 与 openView／completeViewRequest 两个动作（[packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx:196-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/ConversationSession.tsx#L196-L202)）

### packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx

新会话 hero 的三个零件：工作区 chip、背景光晕 SVG、hero 外壳，由 ConversationRoot 组合渲染。

- workspaceLabel 取路径基名作为 chip 文案，基名为空时回落到原始 cwd（[packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx:22-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx#L22-L25)）
- WorkspaceChip 按 label 是否存在切换开／合文件夹图标，并在无 label 时显示"选择工作区"占位文案（[packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx#L55-L58)）
- chip 按钮始终可交互，带 aria-haspopup="menu" 与 aria-expanded 回显菜单开合，点击回调由调用方给出（[packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx:46-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx#L46-L54)）
- HeroGlow 用 useId 去掉冒号后生成滤镜 id，避免多个 hero 实例的 SVG filter id 冲突（[packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx#L73)）
- 光晕本体为一个经高斯模糊滤镜处理的椭圆，定位类名完全由拥有者传入（[packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx:75-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx#L75-L95)）
- HeroShell 把品牌标渲染为 `conversation.hero.brand.mark` 槽位并以内置 FishLogo 作为 fallback，标题与预览徽章文案走 t（[packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx:118-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx#L118-L126)）
- 外壳留出 children 出口用于叠加内容（[packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx:131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/EmptyHero.tsx#L131)）

### packages/client/ui-conversation/src/client/skeleton/HeroShell.module.css

hero 外壳与工作区 chip 的样式表，被 EmptyHero.tsx 导入。

- 外壳栈的 max-width 绑定共享变量 `--dsh-composer-card-max-width`，使 hero 内容宽度与输入卡片一致（[packages/client/ui-conversation/src/client/skeleton/HeroShell.module.css:15-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/HeroShell.module.css#L15-L24)）
- 品牌标动画被 `hover: hover` 与 `prefers-reduced-motion: no-preference` 双重媒体查询限制，不满足时不播放（[packages/client/ui-conversation/src/client/skeleton/HeroShell.module.css:93-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/HeroShell.module.css#L93-L97)）
- 工作区行提到 z-index 10，使展开的菜单及其子菜单绘制在输入卡片之上（[packages/client/ui-conversation/src/client/skeleton/HeroShell.module.css:116-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/HeroShell.module.css#L116-L125)）
- chip 禁用态取消指针手型，只保留静态回显（[packages/client/ui-conversation/src/client/skeleton/HeroShell.module.css:150-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/HeroShell.module.css#L150-L154)）

### packages/client/ui-conversation/src/client/skeleton/InputBar.module.css

输入条卡片的样式表，被 InputBar.tsx 导入，并向内部子盒子传递若干尺寸与滚动条变量。

- 外框与通知条的横向留白、卡片最大宽度都绑定根节点发布的共享宽度变量（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:2-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L2-L30)）
- 卡片自身的字号取 `--dsh-content-font-size`、行高按 `--dsh-content-font-delta` 偏移，并重绑滚动条拇指颜色变量供内部滚动盒继承（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:32-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L32-L63)）
- 工作区触发态用 ::after 叠加一层 SVG 遮罩的虚线描边替代原生 dashed，并把边框设为透明、光标改为 pointer（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:71-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L71-L86)）
- 触发态下所有禁用控件 `pointer-events: none`，点击穿透到卡片自身的处理函数，整卡成为一个点击目标（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:88-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L88-L93)）
- 浮层锚点是一个高度为 0 的绝对定位盒，供菜单／弹出选择器相对卡片定位（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:106-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L106-L112)）
- `.scroll` 是卡片内唯一滚动盒，高度上限取座位下发的 `--dsh-composer-text-max-height`（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:114-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L114-L120)）
- `.grow` 作为相对定位锚，让占位层可绝对覆盖在可编辑区之上（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:122-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L122-L126)）
- 草稿区强制换行策略（pre-wrap、break-word、overflow-wrap anywhere）与去掉焦点轮廓（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:142-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L142-L157)）
- 编辑器段落清零 UA 外边距，保持行节奏（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:161-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L161-L163)）
- 末段 ::after 以 `content: var(--dsh-composer-hint)` 渲染命令提示；变量缺失时该声明无效、什么都不显示（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:165-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L165-L171)）
- 占位层绝对定位且 pointer-events／user-select 均关闭，不拦截点击与选择（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:173-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L173-L180)）
- 禁用态草稿区显示 not-allowed 光标；带 `aria-haspopup="menu"` 的草稿区显示 pointer 光标（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:182-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L182-L189)）
- hero 形态下草稿区保留 52px 两行下限（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:191-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L191-L196)）
- 工具行声明 `container-type: inline-size`，为 PermissionSelect 的容器查询提供匿名容器；并允许换行（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:197-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L197-L215)）
- 右侧控件组用 `margin-left: auto` 在换行后仍右对齐（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:236-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L236-L245)）
- 附件按钮与下拉选择在禁用态降透明度并取消手型（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:265-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L265-L300)）
- 主按钮用 transform 上移 2px 抵消工具行下移，并在禁用态降到 0.4 透明度（[packages/client/ui-conversation/src/client/skeleton/InputBar.module.css:302-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.module.css#L302-L332)）

### packages/client/ui-conversation/src/client/skeleton/InputBar.tsx

`conversation.composer.bar` 槽位的默认实现：编辑器绑定、键位注册、图片入口预检、发送／停止／排队与各类占位文案的仲裁。

- 从菜单启动器读取命令菜单是否处于打开态（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L53)）
- 自选会话事实：promptError、running、subagent、removed，缺失时各有默认值（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:54-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L54-L57)）
- planActive 从 `plan` 投影折算：pending 时取反、否则取 active（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L60)）
- hasGoal 把 `goal` 投影的 undefined 与 null 一并视为无目标（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L62)）
- live 要求 input／keyboard／inputActions 三者同时存在，否则同一份 DOM 以惰性态渲染（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L65)）
- attachments 由 draftImages(imageIds) 记忆化解析，empty 同时要求草稿去空白为空且无附件（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:68-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L68-L72)）
- toast 带自增 seq 作为 key，使重复的同一条消息重新开始展示周期（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:76-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L76-L82)）
- 读取 `imageLimits` 投影作为部署侧图片限额（缺失即完全交由宿主判定）（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L85)）
- promptError 出现即弹 toast：附件错误映射为产品文案，其它错误码原样带 message 与 code（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:93-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L93-L98)）
- error 级别的机器通知同样走 toast（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:99-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L99-L101)）
- 读取 `permissions` 投影驱动权限 chip（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L107)）
- parentOffline：可续接子会话且父不可用（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:111-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L111-L112)）
- disabled 由 removed／inert／非 live／存在阻断／父离线五者取或（运行中本身不禁用输入）（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:117-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L117-L118)）
- 模型选择位单独用 modelSeatLocked（不含阻断），使阻断态下仍可换模型（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L123)）
- machineBusy 取 adjudicating／submitting 两个阶段（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L124)）
- workspaceTrigger／editorDisabled／editable 三态决定同一个 DOM 是可编辑、只读还是充当工作区选择触发器（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:129-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L129-L131)）
- canSteerQueue 需同时满足未锁定、机器空闲、命令菜单未开、草稿空、正在运行、非子代理且队列中仍有 queued 项（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:132-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L132-L133)）
- 解析后的附件数与状态里的 imageIds 数不一致时调用 pruneImages 修剪（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:135-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L135-L140)）
- revealSelection 用实时 DOM Selection 的矩形（零矩形时退回锚节点元素框）把光标滚入草稿滚动口的最小可见范围（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:147-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L147-L165)）
- 解锁（挂载／会话切换）时以 preventScroll 聚焦根元素并在编辑器聚焦回调中执行一次 reveal（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:172-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L172-L178)）
- 草稿由空变为非空时只做 reveal 不抢焦点（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:186-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L186-L189)）
- 草稿滚动口的非被动 wheel 监听实现滚动链：本盒尚可滚动时放行原生行为，抵达边界才 preventDefault 并把 deltaY 转给最近的 `[data-conversation-scroll]` 宿主（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:197-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L197-L211)）
- intakeImages 在入口按顺序预检：先由 addImages 裁定媒体类型，再查张数上限、单文件字节上限、本条消息总字节上限，任一不过整批拒绝并弹提示（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:218-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L218-L243)）
- canAcceptDrop 要求未锁定、机器空闲且 addImages 存在（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L245)）
- 用一个每次渲染刷新的 ref 承载键位处理所需的实时状态，使编辑器注册不必逐次重装（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:249-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L249-L252)）
- 向编辑器注册组合键位表：仲裁、空格、关闭弹层、可否提交、提交、文件投放、纯文本粘贴，并返回注销函数（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:254-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L254-L285)）
- 提交分支：空草稿的加速 Enter 改为把全部排队消息推入当前回合，否则按 resolveSubmitMode(running, 加速与否, 是否非子代理) 决定投递方式（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:266-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L266-L278)）
- 空格与粘贴在机器忙或锁定时直接吞掉不下发（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:258-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L258-L262)）
- keepFocus 在 mousedown 阶段 preventDefault 并把焦点还给编辑器根元素，避免按钮夺焦（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:291-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L291-L294)）
- 命令菜单开关把当前光标跨度 caretSpan() 传给 toggleCommandMenu（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:296-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L296-L298)）
- 工作区触发态下 Enter／空格在该 div 上触发工作区选择（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:302-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L302-L308)）
- primaryStops 决定主按钮语义：运行中且非子代理且（草稿空或被阻断）时主按钮是停止；可续接子会话则另开独立停止按钮（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:313-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L313-L315)）
- onPrimary 按语义分流到 stop() 或 inputActions.submit()（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:316-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L316-L324)）
- 权限 chip 以 sessionId 为 key 挂载，命令面缺失时整体不渲染（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:329-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L329-L331)）
- 命令提示只在已认领且草稿以该 token 开头、且 token 之后为空白时生效（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:336-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L336-L341)）
- 提示文案按 `hint.<命令名>` 动态查词典（goal 命令在已有目标时改查 `hint.goal.active`），未命中则保留机器自带提示（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:342-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L342-L351)）
- 占位文案优先序：拥有者传入 → 父离线 → 不可用 → 可推队列 → 计划模式 → 默认（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:353-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L353-L362)）
- Toast 以 seq 为 key、锚定卡片元素并在结束时清空（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:366-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L366-L374)）
- info 级通知渲染为 role="status" 的常驻条（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:375-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L375-L379)）
- 触发态下整张卡片接管 click，并在 pointerdown 阻止冒泡以避免菜单的外部关闭与重新打开相互竞争（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:385-391](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L385-L391)）
- 附件槽位接到 canAcceptDrop、入口函数、移除回调与从投影换算出的投放限额提示（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:394-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L394-L403)）
- 可编辑区在触发态下把 editor 置 null，并改挂 aria-haspopup／aria-expanded／tabIndex／键盘处理；提示文案通过行内 `--dsh-composer-hint`（JSON 字符串）下发（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:409-426](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L409-L426)）
- 仅在草稿为空且无认领时渲染占位层；装饰器传送门同样在触发态下拿到 null editor（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:427-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L427-L432)）
- 命令按钮在锁定或无 toggleCommandMenu 时禁用，并以 aria-expanded 回显菜单状态（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:437-450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L437-L450)）
- 左区渲染权限 chip 与 `conversation.input.plan` 槽位（无会话时后者不渲染），右区渲染模型槽位与上下文环（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:451-460](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L451-L460)）
- interruptible 时额外渲染一个独立停止按钮（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:461-476](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L461-L476)）
- 主按钮的禁用条件按语义切换（停止语义看 stop 是否存在，发送语义看空草稿／禁用／机器忙），图标随之在方块与箭头之间切换（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:477-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L477-L496)）
- footer 内容原样渲染在卡片之后（[packages/client/ui-conversation/src/client/skeleton/InputBar.tsx:500](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/InputBar.tsx#L500)）

### packages/client/ui-conversation/src/client/skeleton/PermissionSelect.module.css

权限 chip 的样式表，被 PermissionSelect.tsx 导入。

- 容器查询在工具行宽度不足 460px 时隐藏带图标 chip 的文字标签，仅保留图标与箭头（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.module.css:62-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.module.css#L62-L72)）
- 禁用态取消手型与聚焦环，只保留静态外观（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.module.css:25-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.module.css#L25-L32)）
- 展开态把箭头旋转 180 度作为开合回显（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.module.css:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.module.css#L74-L76)）

### packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx

输入条上的权限模式选择 chip，由 InputBar 挂载，通过下发 `/permission <id>` 命令改变会话权限。

- FULL_ACCESS 常量固定为 `danger-full-access`，后续多处以它为分支判据（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L10)）
- 三个内置权限值各配一个盾形图标；表外的宿主自定义名取不到图标（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:18-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L18-L46)）
- displayName 只对符合 kebab-case 的机器名做首字母大写拼接，其它名字原样透出（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L55-L58)）
- 完全访问项的标签改用本地化文案，覆盖机器名转换（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:60-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L60-L65)）
- 一旦锁定或投影值消失，强制收起菜单、清空确认框与勾选状态（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:81-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L81-L86)）
- 投影值缺失时整个 chip 返回 null（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L88)）
- 显示值优先取本地乐观选择 pick，其次才是投影的 currentValue；pick 或确认框存在即视为 busy（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:90-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L90-L92)）
- 菜单项从选项表里滤掉 `custom`，并按值取图标（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:94-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L94-L99)）
- submit 置乐观值后下发 `/permission <id>` 命令，无论成败都在结束时清掉乐观值（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:101-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L101-L106)）
- choose 关菜单后：与当前值相同则什么都不做，选中完全访问则先开风险确认框，其余直接提交（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:108-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L108-L117)）
- 完全访问的确认必须同时满足未锁定、已勾选确认、确认框仍在，才关闭并提交（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:124-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L124-L129)）
- 触发按钮以当前值名生成 aria-label、以选项描述作 title，锁定或 busy 时禁用，点击翻转菜单（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:141-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L141-L157)）
- 风险确认组件的开合、各按钮文案、勾选状态与取消／确认回调全部由本组件驱动，且在锁定时置 disabled（[packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx:159-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/PermissionSelect.tsx#L159-L172)）

### packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css

待办卡片的样式表，被 TodoPanel.tsx 导入。

- 卡片宽度与最大宽度都由共享的 `--dsh-composer-side-clearance` 与 `--dsh-composer-dock-inset`、卡片上限变量算出，与输入卡片共用一条宽度轴（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css:1-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css#L1-L24)）
- 卡片上重绑滚动条拇指颜色变量，供内部列表继承（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css:25-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css#L25-L32)）
- 列表高度上限 180px 且纵向可滚（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css:87-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css#L87-L96)）
- 进行中图标以无限循环关键帧旋转（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css:124-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css#L124-L133)）
- 条目文字单行省略，不做行内展开（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css:135-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.module.css#L135-L141)）

### packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx

待办面板组件及其 dock 适配器与插件入口，读取 `todos` 投影并注册到 `conversation.input.dock` 槽位。

- assertNever 对未知状态抛错（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:22-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L22-L24)）
- 进行中图标用 useId 生成渐变 id，避免多实例的 SVG 定义冲突（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:40-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L40-L52)）
- StatusGlyph 按 completed／in_progress／pending 三分支选图标，默认分支走 assertNever（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:64-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L64-L72)）
- progressLabel 统计三类计数、省略计数为 0 的分段，并用 en space 加中点连接（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:75-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L75-L86)）
- 面板默认折叠，且待办为空时整体返回 null（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:89-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L89-L90)）
- 根节点带 `data-testid="todo-panel"` 与本地化 aria-label（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L93)）
- 头部按钮点击翻转折叠态并用 aria-expanded 回显，箭头图标随之切换（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:95-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L95-L107)）
- 展开时才渲染列表，条目以 content 为 key、状态写到 data-status（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:108-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L108-L117)）
- TodoDock 读取 `todos` 投影，缺失时以空数组传入（面板据此不渲染）（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:127-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L127-L130)）
- todoDockEntry 声明 inject `slots`，并在 `conversation.input.dock` 上以 id `todo`、order 0、locale NS 注册该 dock（[packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx:133-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/TodoPanel.tsx#L133-L140)）

### packages/client/ui-conversation/src/client/skeleton/safari.ts

Safari 下文本域布局的识别与修复两个导出函数，当前在包内由 `tests/safari.client.spec.ts` 引用。

- ALTERNATE_IOS_BROWSER 正则列出需要排除的 iOS 第三方浏览器标记（[packages/client/ui-conversation/src/client/skeleton/safari.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/safari.ts#L9)）
- isSafariBrowser 同时要求 vendor 精确匹配、UA 含 `Version/... Safari/...` 形态、且不含上述排除标记（[packages/client/ui-conversation/src/client/skeleton/safari.ts:16-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/safari.ts#L16-L20)）
- repairSafariTextareaLayout 在文本域没有溢出或找不到 `[data-input-scroll]` 滚动口时直接返回（[packages/client/ui-conversation/src/client/skeleton/safari.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/safari.ts#L27-L29)）
- 修复手法是对文本域与滚动口各做一次"高度 +1px、读 offsetHeight 强制回流、再还原并再次回流"（[packages/client/ui-conversation/src/client/skeleton/safari.ts:31-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/skeleton/safari.ts#L31-L41)）

### packages/client/ui-conversation/src/client/stores.ts

会话外壳与会话头共享的按会话存储定义，由 client/apply.ts 创建。

- 初始状态为空草稿、未选视图、无视图请求（[packages/client/ui-conversation/src/client/stores.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/stores.ts#L19)）
- 以 `dsh.conversation` 为持久化键，使草稿与视图选择跨刷新存活（[packages/client/ui-conversation/src/client/stores.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/stores.ts#L20)）
- 声明四个写动作：setDraft、setView、openView（同时改视图并置视图请求）、completeViewRequest（清空请求）（[packages/client/ui-conversation/src/client/stores.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/client/stores.ts#L21-L29)）

### packages/client/ui-conversation/src/css-modules.d.ts

为 `*.module.css` 与 `*.css` 导入声明模块类型的 TypeScript 声明文件。

- 无运行期机制

### packages/client/ui-conversation/src/index.ts

包的宿主侧入口：注册会话相关的持久化设置分区，并转出 submission-settings 的公开符号。

- apply 通过 `ctx.inject(['settings'])` 延迟到设置服务存在时才注册，缺失设置提供方时不注册也不报错（[packages/client/ui-conversation/src/index.ts:16-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/index.ts#L16-L22)）
- 注册的分区名由 `settingsNamespace(CONVERSATION_SETTINGS_NAMESPACE)` 生成，模式取 ConversationSettingsSchema（[packages/client/ui-conversation/src/index.ts:18-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/index.ts#L18-L21)）

### packages/client/ui-conversation/src/invariant.ts

本包的不变量伴生插件，向 invariants 服务登记包名。

- 插件声明 name 与 `inject: ['invariants']`，决定其加载与依赖顺序（[packages/client/ui-conversation/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/invariant.ts#L13-L15)）
- 安装器为空函数，即本包不注册任何运行期不变量检查（[packages/client/ui-conversation/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/invariant.ts#L21)）
- apply 以包名向 invariants 注册并返回注销函数（[packages/client/ui-conversation/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/invariant.ts#L28-L29)）

### packages/client/ui-conversation/src/submission-settings.ts

忙碌状态下 Enter 键行为的设置常量与模式定义，被宿主入口与浏览器侧共用。

- 设置分区名固定为 `ui-conversation`、字段名固定为 `busyEnter`（[packages/client/ui-conversation/src/submission-settings.ts:6-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/submission-settings.ts#L6-L9)）
- 取值集合限定为 `queue` 与 `steer` 两种（[packages/client/ui-conversation/src/submission-settings.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/submission-settings.ts#L12)）
- 默认值为 `queue`（[packages/client/ui-conversation/src/submission-settings.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/submission-settings.ts#L18)）
- Schema 以联合类型加默认值校验该字段，既用于持久化设置也用于浏览器侧的传输校验（[packages/client/ui-conversation/src/submission-settings.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/src/submission-settings.ts#L27-L29)）

### packages/client/ui-conversation/tsconfig.json

本包的 TypeScript 编译配置，声明客户端基座、源／输出目录与工程引用。

- 无运行期机制

### packages/client/ui-conversation/tsdown.config.ts

本包的打包配置，决定发布产物包含哪些运行期入口。

- 以 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口调用共享的 clientBundle，确定被打包的运行期入口（[packages/client/ui-conversation/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-conversation/tsdown.config.ts#L3)）
