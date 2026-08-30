---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-model-selection
---

# packages/client/ui-model-selection

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、78 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-model-selection/README.md

包的英文说明页，描述 `/model` 弹窗与输入区模型座位这两个入口、共享目录的加载与阻断行为及已知限制。

- 无运行期机制

### packages/client/ui-model-selection/package.json

包清单，声明该包的入口解析、客户端半侧注入声明、发布文件集与运行时依赖。

- `exports` 声明三个入口（`.`、`./invariant`、`./client`）分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，并额外放开 `./src/*` 与 `./package.json`（[packages/client/ui-model-selection/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/package.json#L16-L31)）
- `dsh.client` 声明浏览器半侧需要注入的四个包并把平台标为 `web`（[packages/client/ui-model-selection/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/package.json#L32-L42)）
- `files` 把发布内容限定为三个运行时产物与类型声明（[packages/client/ui-model-selection/package.json:82-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/package.json#L82-L87)）
- `dependencies` 声明运行时依赖 `clsx`，即组件里拼类名所用的库（[packages/client/ui-model-selection/package.json:88-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/package.json#L88-L90)）

### packages/client/ui-model-selection/src/client/ModelSelect.module.css

输入区模型座位触发器与两级下拉菜单的 CSS Module 样式表，被 `ModelSelect.tsx` 引入。

- 无运行期机制

### packages/client/ui-model-selection/src/client/ModelSelect.tsx

输入区 `conversation.input.model` 座位的组件：一个显示当前模型与推理等级的触发器，展开为「模型／等级」两级菜单。

- 用 `useSyncExternalStore` 订阅注入进来的每会话目录 store，取其快照作为渲染状态（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:48-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L48-L51)）
- `lastActionRef` 记录最近一次可能失败的动作是加载还是选择，决定错误走菜单内错误条还是走浮层提示（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L58)）
- `choices` 把目录里的分组扁平成候选列表，并为每个模型预置带其默认推理等级的完整选择对象（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:66-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L66-L77)）
- 由当前选择在候选中的匹配项取出精确模型的 reasoning 元数据，生效等级取当前选择的等级、否则取模型默认；等级显示名在 `efforts` 里按 id 查，查不到回落到 id 本身（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:78-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L78-L88)）
- `effortChoices` 在模型没有默认等级时前置一行「提供方默认」，其余行来自适配器公布的等级列表；无 reasoning 元数据时为空（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:89-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L89-L100)）
- `busy` 由状态 `selecting` 得出，用于禁用所有可选行（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L101)）
- `reload` 把最近动作标记为加载后调用注入的 `load`（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:103-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L103-L106)）
- 菜单打开期间在 document 上挂 `mousedown`，点击根节点之外即关闭，卸载时移除监听（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:108-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L108-L115)）
- 注入面报告该会话不可用时整个座位渲染为 null（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L117)）
- `show` 把面板重置到根级、打开菜单并触发一次重新加载（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:119-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L119-L123)）
- `close` 关闭菜单并回到根级面板，可选地在微任务里把焦点还给触发器（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:125-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L125-L129)）
- `moveFocus` 在本次渲染收集到的行引用中按偏移量环形移动焦点（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:131-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L131-L137)）
- 根节点键盘处理：Escape 先从下钻面板退回根级、已在根级则关闭并还焦点；上下方向键阻止默认行为并移动焦点（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:139-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L139-L152)）
- `onBlur` 只在焦点移出根节点时关闭菜单（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:154-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L154-L157)）
- `settleSelection` 在被接受时关闭菜单并还焦点；被拒绝时读 store 上的错误文本并以自增序号推出一条浮层提示（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:159-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L159-L169)）
- `choose` 在点中的 provider/model 与当前一致时只关闭菜单不提交，否则标记为选择动作并提交（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:171-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L171-L178)）
- `chooseEffort` 在没有当前选择时直接返回、等级未变时只关闭，否则用当前 provider/model 加新等级组成完整选择提交（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:180-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L180-L193)）
- 触发器文案与可读名：首次加载中显示加载文案，有目录行时用模型显示名，无匹配行时回落到 `provider/model` 或未选提示；有等级时拼接等级并切换到带等级的可读名（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:195-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L195-L207)）
- 每次渲染重置行引用数组，并按渲染先后顺序为每个可聚焦行分配下标（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:208-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L208-L213)）
- 触发器按钮以 `locked` 禁用，绑定 `aria-expanded` 与仅在展开时给出的 `aria-controls`，点击在开与关之间切换（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:217-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L217-L238)）
- 菜单容器的 `aria-busy` 由加载中或提交中共同决定（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:240-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L240-L247)）
- 根级面板渲染「模型」行，只有在精确模型带 reasoning 元数据时才额外渲染「等级」行，两行分别下钻到对应子面板（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:248-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L248-L263)）
- 模型面板：加载中显示状态行；错误条仅在最近动作是加载时渲染并带重试按钮；每个 provider 局部失败渲染一条带重试的警告行（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:265-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L265-L281)）
- 模型行按 provider 分组渲染，选中项标 `aria-checked` 与勾选图标，提交中时禁用，点击调用 `choose`（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:282-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L282-L314)）
- 状态为 ready 且候选为空时渲染空列表文案（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:315-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L315-L317)）
- 等级面板：同样只在最近动作是加载时渲染带重新加载按钮的错误条；等级列表为空时渲染空提示，否则逐级渲染并把生效等级标为选中，提交中时禁用（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:321-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L321-L351)）
- 浮层提示以序号为 key 渲染，锚点取最近的 `[data-composer-card]` 祖先，结束回调清空提示状态（[packages/client/ui-model-selection/src/client/ModelSelect.tsx:354-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/ModelSelect.tsx#L354-L362)）

### packages/client/ui-model-selection/src/client/catalog.ts

按宿主代次共享的模型目录加载器，被 `ModelDirectoryResolver` 建一份供所有会话目录读取。

- store 初始值为空目录、状态 `idle`、无错误（[packages/client/ui-model-selection/src/client/catalog.ts:16-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/catalog.ts#L16-L20)）
- `load` 在已 ready 且有值时直接返回缓存，有在途请求时复用该请求，否则捕获当前代次、置 `loading` 后发起一次 `session.modelCatalog`（[packages/client/ui-model-selection/src/client/catalog.ts:32-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/catalog.ts#L32-L41)）
- 响应非 ok 时抛出带码与消息的错误；只有代次未变才把值写成 `ready`；catch 分支同样只在代次未变时写 `error` 并继续抛出；finally 仅在代次未变且在途仍是本次请求时清空在途引用（[packages/client/ui-model-selection/src/client/catalog.ts:41-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/catalog.ts#L41-L62)）
- `invalidate` 递增代次作废在途响应、清空在途引用，并按 `clear` 决定保留还是清空已加载值，状态回到 `idle`（[packages/client/ui-model-selection/src/client/catalog.ts:68-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/catalog.ts#L68-L73)）
- `refresh` 保留旧值地作废后立刻重新加载，错误被吞下交由 store 暴露（[packages/client/ui-model-selection/src/client/catalog.ts:76-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/catalog.ts#L76-L79)）
- `resetGeneration` 连同旧值一起清空后重新加载（[packages/client/ui-model-selection/src/client/catalog.ts:82-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/catalog.ts#L82-L85)）

### packages/client/ui-model-selection/src/client/directory.ts

每会话一份的模型目录控制器，把共享目录与该会话的持久化选择投影合成一个快照，并承担提交选择的调用。

- store 初始快照：当前选择为 null、可路由为 null、分组与失败为空、状态 `idle`（[packages/client/ui-model-selection/src/client/directory.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L41-L43)）
- 构造时订阅共享目录 store 与会话选择投影，任一变化都重算合成，并立即先算一次（[packages/client/ui-model-selection/src/client/directory.ts:66-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L66-L68)）
- `load` 先校验会话可用，再加载共享目录、重算合成并返回最新快照（[packages/client/ui-model-selection/src/client/directory.ts:75-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L75-L80)）
- `select` 递增代次、置 `selecting`，把 provider/model 与可选的推理等级一起提交给 `session.selectModel`（[packages/client/ui-model-selection/src/client/directory.ts:88-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L88-L99)）
- 若返回时已 dispose 或代次已变，则不写 store，只在失败时抛出；正常失败写入 `error` 状态与文本并抛出；成功置 `ready` 并重算合成（[packages/client/ui-model-selection/src/client/directory.ts:100-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L100-L110)）
- `resetConnected` 递增代次作废上一代次的在途响应，把 `selecting` 状态退回 `idle` 并清错，再重算合成（[packages/client/ui-model-selection/src/client/directory.ts:115-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L115-L123)）
- `dispose` 置位 disposed 并退订投影与目录两个订阅（[packages/client/ui-model-selection/src/client/directory.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L126-L130)）
- `assertAvailable` 在会话不可用时抛出，挡住 `load` 与 `select`（[packages/client/ui-model-selection/src/client/directory.ts:132-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L132-L136)）
- `syncInputs` 在已 dispose 时直接返回；目录未 ready、值为空或投影缺失时，若曾解析成功则仅在目录报错时写错误，否则整体重置为 loading 或 error 快照（[packages/client/ui-model-selection/src/client/directory.ts:138-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L138-L161)）
- 输入齐备时，当前选择取投影的 next、缺省回落到目录默认；可路由由目录的 `routableProviders` 是否包含该 provider 决定；分组与失败原样带出；正在提交时保留 `selecting` 状态（[packages/client/ui-model-selection/src/client/directory.ts:162-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L162-L173)）
- `modelSelectionProjection` 把 undefined 原样传出、其余断言为选择投影（[packages/client/ui-model-selection/src/client/directory.ts:177-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/directory.ts#L177-L179)）

### packages/client/ui-model-selection/src/client/service.ts

`ctx.modelDirectories` 服务，持有共享目录并按会话解析、缓存与释放 `ModelDirectory`。

- `static inject` 声明该服务依赖 sessions、Remote 根与 `remote.session`（[packages/client/ui-model-selection/src/client/service.ts:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/service.ts#L36)）
- 构造时建立共享目录并立刻发起一次加载，错误被吞下交由 store 暴露（[packages/client/ui-model-selection/src/client/service.ts:51-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/service.ts#L51-L52)）
- 监听 `connection/reset`：重置共享目录代次并对每个常驻会话目录调用 `resetConnected`（[packages/client/ui-model-selection/src/client/service.ts:53-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/service.ts#L53-L56)）
- 订阅三个转发的宿主事件（适配器更新、设置文档更新、凭据引用更新），每个都触发共享目录重新加载（[packages/client/ui-model-selection/src/client/service.ts:57-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/service.ts#L57-L59)）
- `directoryFor` 命中缓存即返回；解析不到会话 scope 或 binding 时抛出带 sessionId 的错误（[packages/client/ui-model-selection/src/client/service.ts:68-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/service.ts#L68-L76)）
- 新建目录时把 `session` Remote、sessionId、以「是否为被寻址子代理会话」判定的可用性闭包、共享目录以及 `modelSelection` 投影面交进去，并存入每会话 Map（[packages/client/ui-model-selection/src/client/service.ts:77-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/service.ts#L77-L84)）
- 存在 conversation 服务时，按快照的 `routable === false` 设置或清除该会话的输入区阻断（阻断文案在设置时才读取），先发布一次再订阅 store 持续发布（[packages/client/ui-model-selection/src/client/service.ts:90-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/service.ts#L90-L100)）
- 该 effect 的清理函数退订 store 并把该会话的阻断清空（[packages/client/ui-model-selection/src/client/service.ts:100-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/service.ts#L100-L104)）
- 在会话 scope 上注册清理 effect：作用域销毁时 dispose 目录并从 Map 中删除该条目（[packages/client/ui-model-selection/src/client/service.ts:106-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/service.ts#L106-L109)）

### packages/client/ui-model-selection/src/client/index.ts

该包浏览器半侧的插件体，挂载目录服务并在同一份每会话目录上注册 `/model` 命令与输入区模型座位两个入口。

- `rowId` 用 `provider/model` 拼出弹窗行的不透明行标识（[packages/client/ui-model-selection/src/client/index.ts:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L45-L47)）
- `optionsOf` 遍历分组生成可选行，副标题在有描述时拼上描述，与当前选择的 provider/model 完全一致的行标记为 active（[packages/client/ui-model-selection/src/client/index.ts:50-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L50-L64)）
- 每个加载失败的 provider 追加一行 `failure/` 前缀的行，只带失败文案（[packages/client/ui-model-selection/src/client/index.ts:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L65-L72)）
- `selectionOf` 在已加载分组里按行标识反查选择：命中同一路由时沿用当前推理等级，否则用该模型的默认等级；无匹配返回 undefined（[packages/client/ui-model-selection/src/client/index.ts:82-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L82-L98)）
- `inject` 声明该插件需要 commandUi、locale、sessions、slots、Remote 根与 `remote.session`（[packages/client/ui-model-selection/src/client/index.ts:104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L104)）
- `apply` 通过 `ctx.effect` 注册 `model` 命名空间的中英文字典，并绑定该命名空间的翻译函数（[packages/client/ui-model-selection/src/client/index.ts:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L113-L117)）
- 以「在触发时才读取的阻断文案」为配置挂载 `ModelDirectoryResolver` 插件（[packages/client/ui-model-selection/src/client/index.ts:121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L121)）
- 在 commandUi 与 modelDirectories 就绪的作用域内注册 `/model` 命令，描述文本在注册时取一次，`available` 用「不是被寻址的子代理会话」作为可见条件（[packages/client/ui-model-selection/src/client/index.ts:126-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L126-L135)）
- 弹窗的 `options` 对被寻址子代理会话抛错，否则加载该会话的目录并扁平成行（[packages/client/ui-model-selection/src/client/index.ts:136-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L136-L141)）
- 弹窗的 `onSelect` 同样先挡住子代理会话，再从目录快照反查选择；反查不到（失败行或过期行）时抛出提示，否则通过同一个目录提交（[packages/client/ui-model-selection/src/client/index.ts:142-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L142-L154)）
- 在 slots 与 modelDirectories 就绪的作用域内向 `conversation.input.model` 座位注册组件，注入面交出可用性标志、同一个目录 store、吞掉错误的 `load`，以及把成功／失败折成布尔值的 `select`（不可用时直接返回 false）（[packages/client/ui-model-selection/src/client/index.ts:158-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/client/index.ts#L158-L179)）

### packages/client/ui-model-selection/src/client/locales.ts

`model` 命名空间的中英文文案字典与其键联合类型，由 `client/index.ts` 注册。

- 无运行期机制

### packages/client/ui-model-selection/src/client/slots.ts

模型座位注入面的类型声明文件，被组件与插件体作为类型引用。

- 无运行期机制

### packages/client/ui-model-selection/src/css-modules.d.ts

给 `*.module.css` 与 `*.css` 导入提供类型的声明文件。

- 无运行期机制

### packages/client/ui-model-selection/src/index.ts

该包宿主半侧的插件入口。

- 导出空的 `apply`，使该插件能出现在宿主 cordis.yml／Loader 中而不产生任何宿主侧行为（[packages/client/ui-model-selection/src/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/index.ts#L9)）

### packages/client/ui-model-selection/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包名。

- 导出插件名与 `inject: ['invariants']`，声明登记前必须先有 invariants 服务（[packages/client/ui-model-selection/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/invariant.ts#L12-L15)）
- 安装器为空函数，`apply` 把包名连同该空安装器注册进 invariants 服务并返回其 disposer（[packages/client/ui-model-selection/src/invariant.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/src/invariant.ts#L22-L30)）

### packages/client/ui-model-selection/tsconfig.json

该包的 TypeScript 编译配置，声明客户端基配置、输出目录与工程引用。

- 无运行期机制

### packages/client/ui-model-selection/tsdown.config.ts

该包的打包配置。

- 以包名与 `lib/types/index.js`、`lib/types/invariant.js` 两个入口调用共享的客户端打包配置工厂，决定产出的运行时包入口（[packages/client/ui-model-selection/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-model-selection/tsdown.config.ts#L1-L3)）
