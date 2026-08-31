---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-slots
---

# packages/client/ui-slots

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、48 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-slots/README.md

槽注册核心包的说明文档，带 description/kind 前置元数据，描述 SlotMap 声明合并、单一 register 组合 API、四份 props 份额与渲染器安装契约。

- 无运行期机制

### packages/client/ui-slots/package.json

包清单，声明入口产物与发布文件白名单；没有 `./client` 子路径，也没有 `dsh.client` 声明。

- `exports` 只映射 `.` 与 `./invariant` 两个入口及各自的类型文件，并开放 `./src/*` 原样路径（[packages/client/ui-slots/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/package.json#L16-L27)）
- `files` 把发布内容限定为两个 js 产物加 `lib/types` 下的声明文件（[packages/client/ui-slots/package.json:35-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/package.json#L35-L39)）
- `peerDependencies` 只列 `dsh-invariants` 与 `cordis`，构成打包预设判定"保持为 import"的生产依赖集合（[packages/client/ui-slots/package.json:40-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/package.json#L40-L43)）

### packages/client/ui-slots/src/index.ts

槽系统的纯核心：声明合并用的 SlotMap 与本地化命名空间表、四份 props 份额的类型推导，以及运行期的 `SlotCore` 注册表类；ui-renderer 在其上安装 React 渲染机制。

- `resolveSlotLabel` 在读取时调用函数型 label，字符串型原样返回（[packages/client/ui-slots/src/index.ts:579-581](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L579-L581)）
- `NO_ENTRIES` 是被冻结的共享空数组，作为未声明键的稳定快照返回值（[packages/client/ui-slots/src/index.ts:626](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L626)）
- `SlotCore` 持有键记录表、变更监听集合、共享 store 句柄的作用域账本、脏记录集合与调度标志，以及用 WeakSet 记录的已让位条目和崩溃监听集合（[packages/client/ui-slots/src/index.ts:677-694](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L677-L694)）
- 构造函数种下唯一先验的 `root` 槽（single/root，声明者标为内建，声明纪元置 1），且不触发脏标记（[packages/client/ui-slots/src/index.ts:696-702](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L696-L702)）
- `register` 在目标槽未被声明时抛错（[packages/client/ui-slots/src/index.ts:785-789](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L785-L789)）
- 未给 `priority` 时按 0 处理，同一格位的冲突判定以精确优先级为准（[packages/client/ui-slots/src/index.ts:794-796](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L794-L796)）
- single 槽在同优先级已有占位者时抛错并指名占位者（[packages/client/ui-slots/src/index.ts:798-802](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L798-L802)）
- keyed 槽缺 `key` 抛错，同 key 同优先级已有条目时抛错（[packages/client/ui-slots/src/index.ts:803-810](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L803-L810)）
- list 槽缺 `id` 抛错，同 id 同优先级已有条目时抛错（[packages/client/ui-slots/src/index.ts:811-818](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L811-L818)）
- chain 槽缺 `select` 抛错（[packages/client/ui-slots/src/index.ts:819-821](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L819-L821)）
- 子槽声明表里任一键已被别处声明时抛错并指名先声明者（[packages/client/ui-slots/src/index.ts:823-830](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L823-L830)）
- 非函数型 store 句柄首次挂载时把作用域钉住并记引用计数，再以不同作用域挂载时抛错（[packages/client/ui-slots/src/index.ts:832-841](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L832-L841)）
- 只把实际给出的 key/id/order/label/priority 以及 select/inject/children/store/locale/registrant 写进条目，未给的字段不落键（[packages/client/ui-slots/src/index.ts:843-858](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L843-L858)）
- 条目按优先级升序稳定排序，list 额外以 `order` 细分同优先级，其余种类只按优先级排（[packages/client/ui-slots/src/index.ts:859-867](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L859-L867)）
- 注册后立即对目标键打脏标记（[packages/client/ui-slots/src/index.ts:868](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L868)）
- 子槽声明为每个子键写入 spec、声明者、父键并把声明纪元加一，先给全部子键打脏标记、再统一发出声明通知（[packages/client/ui-slots/src/index.ts:869-887](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L869-L887)）
- 返回的 disposer 先检查条目是否还在账本上（重复调用即空操作），移除后打脏标记并走释放级联（[packages/client/ui-slots/src/index.ts:888-893](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L888-L893)）
- `isLive` 线性遍历全部记录判断条目是否仍在账本上（[packages/client/ui-slots/src/index.ts:903-908](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L903-L908)）
- `entries` 返回缓存数组引用，未声明或未触及的键返回冻结空数组（[packages/client/ui-slots/src/index.ts:918-920](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L918-L920)）
- `entriesOfSlot` 对 chain 键原样返回全部条目，其余种类跳过已让位条目并按格位（keyed 取 key、list 取 id、single 共用一个格位）只保留每格第一条（[packages/client/ui-slots/src/index.ts:934-950](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L934-L950)）
- `spec` 与 `specDynamic` 分别以静态键与动态字符串键读取已声明的运行期规格（[packages/client/ui-slots/src/index.ts:957-970](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L957-L970)）
- `snapshot` 递归导出声明拓扑：用 seen 集合防环，占位者带 registrant/key/id/order/priority 与是否被当前选中的 `active` 标记；不传根时返回所有父声明已不存在的活根（[packages/client/ui-slots/src/index.ts:977-1017](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L977-L1017)）
- `declarationEpoch` 读取声明生命期计数，未触及的键返回 0（[packages/client/ui-slots/src/index.ts:1025-1027](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1025-L1027)）
- `subscribe` 允许在键被声明之前就订阅（记录惰性创建），返回退订函数（[packages/client/ui-slots/src/index.ts:1036-1040](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1036-L1040)）
- `subscribeDeclaration` 单独维护声明生命期监听集合，与普通条目变更分开（[packages/client/ui-slots/src/index.ts:1052-1056](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1052-L1056)）
- `getVersion` 返回该键的单调版本号，未触及键为 0（[packages/client/ui-slots/src/index.ts:1064-1066](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1064-L1066)）
- `onMutate` 登记每次变更的同步回调，返回退订函数（[packages/client/ui-slots/src/index.ts:1075-1078](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1075-L1078)）
- `reportEntryError` 在 `abdicate` 为真时把条目一次性加入让位集合并对该键打脏标记（重复上报直接返回），随后无论是否让位都同步通知全部崩溃监听器（[packages/client/ui-slots/src/index.ts:1096-1104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1096-L1104)）
- `onEntryError` 登记崩溃监听器，回调收到槽键、条目、原始错误与是否已让位，返回退订函数（[packages/client/ui-slots/src/index.ts:1116-1119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1116-L1119)）
- `releaseEntry` 先递减并在归零时删除共享 store 句柄的作用域账本项，再对该条目声明过的每个子槽清空 spec/声明者/父键、把声明纪元加一、清空条目、打脏标记、发声明通知，并对被清掉的子条目递归执行同一过程（[packages/client/ui-slots/src/index.ts:1127-1147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1127-L1147)）
- `record` 在首次触及某键时创建记录（spec 为空、纪元 0、条目为冻结空数组、两套监听集合），记录此后不再删除（[packages/client/ui-slots/src/index.ts:1149-1165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1149-L1165)）
- `markDirty` 把版本号加一、同步通知变更监听器副本、把记录加入脏集合，并在未调度时用 `queueMicrotask` 排一次 flush（[packages/client/ui-slots/src/index.ts:1167-1175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1167-L1175)）
- `notifyDeclaration` 同步遍历声明监听器副本逐个调用（[packages/client/ui-slots/src/index.ts:1177-1179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1177-L1179)）
- `flush` 先复位调度标志再遍历脏记录，使监听器内部触发的变更能重新排一次微任务（[packages/client/ui-slots/src/index.ts:1181-1189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/index.ts#L1181-L1189)）

### packages/client/ui-slots/src/invariant.ts

本包的 invariant companion 插件，向 invariants 服务登记包归属。

- `inject` 声明必须先有 `invariants` 服务，companion 才能加载（[packages/client/ui-slots/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/invariant.ts#L15)）
- installer 为空实现，附带说明该包不注册任何运行期不变量（[packages/client/ui-slots/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/invariant.ts#L23)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并以 Promise 返回其 disposer（[packages/client/ui-slots/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/invariant.ts#L30-L31)）

### packages/client/ui-slots/src/renderer.ts

槽宿主与被安装渲染器之间的契约模块，绝大部分是接口类型，另含一个名称转换函数与两个错误类。

- `standardHookPropName` 把源名首字母大写后拼成 `use<Name>`，即标准源暴露给槽组件的 prop 名（[packages/client/ui-slots/src/renderer.ts:42-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/renderer.ts#L42-L44)）
- `StaleAuthorizationError` 类用于在被保留的 renderSlot 绑定于其声明条目销毁后仍被调用时抛出（[packages/client/ui-slots/src/renderer.ts:219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/renderer.ts#L219)）
- `SlotOwnershipError` 类用于在 renderSlot 被以其条目子槽声明之外的键调用时抛出（[packages/client/ui-slots/src/renderer.ts:226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/src/renderer.ts#L226)）

### packages/client/ui-slots/src/store.ts

面向槽系统的类型再导出文件，把 store 包的 React 无关契约类型原样转出。

- 无运行期机制

### packages/client/ui-slots/tsconfig.json

本包的编译配置，继承客户端基线配置。

- `rootDir` 设为 `src`、`outDir` 设为 `lib/types`，决定了 package.json 与打包配置引用的产物路径（[packages/client/ui-slots/tsconfig.json:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/tsconfig.json#L3-L6)）
- `references` 只列 store 与 invariants 两个工作区项目（[packages/client/ui-slots/tsconfig.json:10-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/tsconfig.json#L10-L17)）

### packages/client/ui-slots/tsdown.config.ts

本包的打包配置，套用静态链接预设而非动态插件预设。

- 调用 `staticLinked` 并给出 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口，由此把本包放进编译外壳静态链接的名册，而不是浏览器模块表的一行（[packages/client/ui-slots/tsdown.config.ts:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-slots/tsdown.config.ts#L3-L6)）
