---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/core/tools
---

# packages/core/tools

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 13 个文件、250 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/core/tools/README.md

工具注册表与执行管线包的说明文档，介绍注册、限制、呈现模式与管线事件，并抄录了 PTC 模式下模型会看到的提示词文本。

- 无运行期机制

### packages/core/tools/package.json

该包的 npm 清单，声明入口、子路径导出与发布内容。

- `type: module` 与 `main`/`types` 决定包按 ESM 解析并指向构建产物 `lib/index.js`（[packages/core/tools/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./types`、`./presentation`、`./src/*`、`./package.json` 映射到具体文件，其余子路径不可导入（[packages/core/tools/package.json:16-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/package.json#L16-L35)）
- `files` 限定发布进 npm 包的文件集合为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 js/d.ts（[packages/core/tools/package.json:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/package.json#L36-L41)）

### packages/core/tools/src/index.ts

包主入口：定义 `ToolRuntime` 服务、配置、作用域分层注册表、模型呈现模式与 pre/guard/around/post/result 执行管线，被智能体循环与所有工具插件使用。

- `COLLAPSE_SECTION_ORDER` 取 `FIRST_PARTY_SECTION_ORDER.PTC_ONLY`，决定 ptc 规则段在提示词中的位置（[packages/core/tools/src/index.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L51)）
- `PTC_ONLY_INSTRUCTION` 是模型可见的整段文本，声明只有 `run_code` 可直接调用、其余工具须在程序内调用（[packages/core/tools/src/index.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L58)）
- `SDK_RENDERERS` 把运行时语言 `typescript`/`python` 映射到各自的 SDK 段渲染函数（[packages/core/tools/src/index.ts:60-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L60-L63)）
- `ToolNotFoundError` 以 `UNKNOWN_TOOL` 码构造消息，可附带"改从何处调用"的说明拼进模型可见文本（[packages/core/tools/src/index.ts:495-511](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L495-L511)）
- `ToolOutputError` 以 `INVALID_TOOL_OUTPUT` 码把违规列表拼成消息（[packages/core/tools/src/index.ts:514-523](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L514-L523)）
- `snapshotProjection` 对 `render`/`presentationMeta` 的产物做无损 JSON 快照，失败即转成 `ToolOutputError`（[packages/core/tools/src/index.ts:526-542](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L526-L542)）
- `snapshotToolValue` 对工具返回值做无损 JSON 快照，非无损则报 `value is not lossless JSON`（[packages/core/tools/src/index.ts:545-554](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L545-L554)）
- `errorMessage` 把任意抛出值归一为字符串，连字符串化都失败时返回 `<unprintable thrown value>`（[packages/core/tools/src/index.ts:609-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L609-L623)）
- `failureMessageFromContent` 把 block 拼成失败消息，非文本块记为 `[<type> content]`，全空时用固定兜底句（[packages/core/tools/src/index.ts:626-631](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L626-L631)）
- `materializePresentation` 对结果投影做快照并 `deepFreeze`，非无损 JSON 抛 `TypeError`（[packages/core/tools/src/index.ts:634-640](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L634-L640)）
- `errorInfo` 只为 `HarnessError` 产出 `{name, code}` 结构化元数据（[packages/core/tools/src/index.ts:643-649](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L643-L649)）
- `ToolLayer` 的 `NamedEntries` 在同层重名注册时抛错，全局层与作用域层给出不同措辞（[packages/core/tools/src/index.ts:726-730](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L726-L730)）
- `ToolLayer.admits` 让本层所有 allow/deny 过滤器同时生效，任一不通过即视为不可见（[packages/core/tools/src/index.ts:739-745](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L739-L745)）
- `ToolLayer.guardReason` 顺序执行本层守卫，返回第一个拒绝理由（[packages/core/tools/src/index.ts:748-754](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L748-L754)）
- `resolveMaxParallelSubCalls` 缺省为 10，非正整数直接抛错（[packages/core/tools/src/index.ts:776-782](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L776-L782)）
- `ToolRuntime` 注入 `systemPrompt`，并以 schemastery 定义配置：`mode` 默认 `native`、`maxParallelSubCalls` 为 ≥1 的自然数默认 10（[packages/core/tools/src/index.ts:789-794](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L789-L794)）
- 符号键 `TOOL_RUNTIME_SCHEDULER` 暴露 prepare/dispatch/finalize/finish 四段调度视图给循环的并行调度器（[packages/core/tools/src/index.ts:797-802](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L797-L802)）
- 四个弱表分别保存执行期延迟上下文、声明结束轮次的执行、调用方取消状态与快照下来的内容终结回调（[packages/core/tools/src/index.ts:804-811](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L804-L811)）
- 分层容器在任何层变更时发出 `tools/change` 事件（[packages/core/tools/src/index.ts:812-815](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L812-L815)）
- 构造时向 `systemPrompt` 注册按作用域生成工具 schema 的提供者；默认模式非 `native` 时再注册 collapse 段与 SDK 段（[packages/core/tools/src/index.ts:827-838](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L827-L838)）
- `collapseSection` 只在该作用域有效模式为 `ptc` 时渲染出 `PTC_ONLY_INSTRUCTION`，否则渲染空串（[packages/core/tools/src/index.ts:855-863](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L855-L863)）
- `sdkSection` 对 `native` 作用域渲染空串，否则要求代码运行时、按其语言取渲染器并渲染该作用域可见工具的 SDK 文本（[packages/core/tools/src/index.ts:875-892](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L875-L892)）
- `modeFor` 沿作用域链自近及远取第一个声明的模式，都没有则用部署默认值（[packages/core/tools/src/index.ts:900-911](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L900-L911)）
- `requireCodeTransport` 首次需要时构造 `run_code` 传输工具，并把运行时解析、并发上限与日志整形能力以闭包传入（[packages/core/tools/src/index.ts:922-933](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L922-L933)）
- `presentAs` 要求作用域上下文，拒绝同一作用域重复声明，写入该层的 `mode` 并按需注册 collapse/SDK 段，返回恢复默认的 disposer（[packages/core/tools/src/index.ts:946-974](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L946-L974)）
- `wireSchemas` 决定进入提示词的 schema 集合：`native` 给全部可见工具；非 native 先校验运行时；`ptc` 只留 `run_code` 且 knownNames 也只有它；`both` 给全部并加上 `run_code`（[packages/core/tools/src/index.ts:980-1001](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L980-L1001)）
- `requireCodeRuntime` 在无 `ctx.codeRuntime` 或其语言无 SDK 渲染器时抛出带修复指引的错误（[packages/core/tools/src/index.ts:1018-1028](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1018-L1028)）
- `register` 校验 `output` 结构与 `output.schema` 属于受支持子集、校验 `timeoutMs` 为正有限数、拒绝保留名 `run_code`，然后按上下文作用域插入并返回 disposer（[packages/core/tools/src/index.ts:1036-1061](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1036-L1061)）
- `restrict` 要求作用域上下文、拒绝空过滤器、拒绝点名保留传输、拒绝未知全局工具名，通过后把编译好的掩码追加进该层（[packages/core/tools/src/index.ts:1070-1097](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1070-L1097)）
- `guard` 把同步守卫追加进当前层，且注册时不触发 `tools/change` 通知（[packages/core/tools/src/index.ts:1109-1115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1109-L1115)）
- 私有 `guardReason` 先查全局层，再沿调用方智能体的作用域链自远及近取第一个拒绝理由（[packages/core/tools/src/index.ts:1117-1127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1117-L1127)）
- `view` 一次遍历得出该作用域的可见集：继承层按由远及近覆盖同名工具，链上任一层的限制都要放行才可见，本层自有注册不受限制并覆盖继承项（[packages/core/tools/src/index.ts:1151-1182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1151-L1182)）
- 该作用域模式非 `native` 时，`run_code` 在能力过滤之后被追加进可见集（[packages/core/tools/src/index.ts:1188-1190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1188-L1190)）
- `get` 按作用域视图解析工具名，被限制掉的全局工具读作不存在（[packages/core/tools/src/index.ts:1203-1205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1203-L1205)）
- `resolveExecution` 在可见性之上再叠加模式坍缩判断，坍缩即返回 undefined（[packages/core/tools/src/index.ts:1220-1225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1220-L1225)）
- `schemas` 把可见定义投影成模型可见的 schema 列表并深拷贝参数（[packages/core/tools/src/index.ts:1233-1235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1233-L1235)）
- `sdkSchemas` 排除 `run_code` 自身，并在每项 schema 上附带工具的 `output.schema` 供 SDK 渲染（[packages/core/tools/src/index.ts:1238-1252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1238-L1252)）
- `schemaOf` 只投影 `name`/`description`/`parameters` 三个字段，其余定义字段不上线（[packages/core/tools/src/index.ts:1255-1266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1255-L1266)）
- `executionMode` 只在分类器精确返回 `true` 时判为可并行，未知、未声明或抛异常一律 `exclusive`（[packages/core/tools/src/index.ts:1275-1284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1275-L1284)）
- `shapeDispatchLog` 跑 `tools/ptc-dispatch-log` 瀑布决定落盘内容，监听器抛错时打 warn 并回退为原始内容（[packages/core/tools/src/index.ts:1295-1305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1295-L1305)）
- `collapses` 定义坍缩判据：非嵌套、作用域模式为 `ptc`、且工具名不是 `run_code`（[packages/core/tools/src/index.ts:1323-1325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1323-L1325)）
- `execute` 走一次 prepare 再由 `completeScheduledExecution` 按阶段串起 dispatch/finalize/finish（[packages/core/tools/src/index.ts:1341-1361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1341-L1361)）
- `createExecution` 生成不透明 token、把缺省 `rootCallId` 补成自身 callId，并挂上 `deferContext`/`concludeTurn` 两个闭包（[packages/core/tools/src/index.ts:1363-1396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1363-L1396)）
- 内容终结回调在参数物化之前抓取；未取消的坍缩调用与非法参数失败会丢弃它，其余路径保留（[packages/core/tools/src/index.ts:1397-1409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1397-L1409)）
- 参数经无损 JSON 快照并 `deepFreeze` 后写入执行对象，同时登记延迟上下文表、终结回调与取消状态（[packages/core/tools/src/index.ts:1410-1421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1410-L1421)）
- 坍缩调用在策略管线之前终结：已取消则给 `ABORTED_BEFORE_DISPATCH`，否则给带"改在 run_code 程序里调用"路由说明的 `UNKNOWN_TOOL` 错误（[packages/core/tools/src/index.ts:1422-1443](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1422-L1443)）
- 参数物化抛错时构造 `arguments: undefined` 的执行对象并直接产出错误结果（[packages/core/tools/src/index.ts:1445-1449](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1445-L1449)）
- `prepareExecution` 入口先查调用方取消，已取消直接给 `ABORTED_BEFORE_DISPATCH`（[packages/core/tools/src/index.ts:1469-1471](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1469-L1471)）
- `tools/pre-execute` 瀑布以 `allow` 收尾；`ask` 转交审批；审批取消且调用方已取消则落到中止结果（[packages/core/tools/src/index.ts:1472-1484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1472-L1484)）
- 允许后再跑单调守卫；任一拒绝理由被渲染成 `Error: <reason>` 的错误结果，随后再查一次取消才进入 dispatch（[packages/core/tools/src/index.ts:1485-1505](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1485-L1505)）
- `cancellationResult` 依据工具体是否已被调用，在 `ABORTED` 与 `ABORTED_BEFORE_DISPATCH` 之间选择（[packages/core/tools/src/index.ts:1517-1524](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1517-L1524)）
- `dispatchToolBody` 把调用方信号与包装器替换信号熔合后再交给工具体，运行结束在 finally 里解绑并还原包装器信号（[packages/core/tools/src/index.ts:1531-1543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1531-L1543)）
- 熔合信号已中止则不调用工具体；否则解析可执行定义（不可解析抛 `ToolNotFoundError`）、置 `bodyInvoked`、执行并在事后中止时把成功结果换成 `ABORTED`（[packages/core/tools/src/index.ts:1539-1558](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1539-L1558)）
- `dispatchScheduledExecution` 以 `tools/execute` 瀑布包住工具体，归一化结果后把工具体延迟的上下文前置拼进 `additionalContexts`（[packages/core/tools/src/index.ts:1568-1588](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1568-L1588)）
- 派发段结束时若调用方已取消且结果不是错误，就用取消结果替换；段内抛错则直接进入 `final-result`（[packages/core/tools/src/index.ts:1589-1597](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1589-L1597)）
- `finalizeScheduledExecution` 跑 post-execute，再按取消状态替换成功结果，异常一律转错误结果进入收尾（[packages/core/tools/src/index.ts:1608-1620](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1608-L1620)）
- `finishScheduledExecution` 先物化一次，再应用定义自有的内容终结并二次物化，任一步抛错都换成错误结果，最后通知观察者（[packages/core/tools/src/index.ts:1630-1645](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1630-L1645)）
- `applyFinalContent` 只允许终结回调替换 `content`，返回 `undefined` 则保持原样（[packages/core/tools/src/index.ts:1648-1653](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1648-L1653)）
- `notifyResult` 先冻结执行对象再按作用域派发 `tools/result`，同步与异步的监听器失败都只记 warn（[packages/core/tools/src/index.ts:1656-1675](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1656-L1675)）
- `serviceAsk` 用 `ctx.get('approval')` 可选消费审批服务：无服务、无智能体分别以不同措辞拒绝（[packages/core/tools/src/index.ts:1688-1704](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1688-L1704)）
- 审批结果一一映射：`allowed-once` 放行，`rejected`/`cancelled`/`unavailable` 各自给出不同拒绝理由，其中 `cancelled` 另置取消标记（[packages/core/tools/src/index.ts:1705-1727](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1705-L1727)）
- `postExecute` 的 `block` 决定把结果转为 `isError`，内容取纠正反馈，只携带该决定自带的上下文（[packages/core/tools/src/index.ts:1741-1755](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1741-L1755)）
- `accept` 同时给 `content` 与 `value` 抛 `TypeError`；对失败结果替换 `value` 也抛 `TypeError`（[packages/core/tools/src/index.ts:1756-1766](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1756-L1766)）
- 替换 `value` 时重走工具的输出校验与渲染，替换 `content` 时直接覆盖，两条路径都把结果自带与决定自带的上下文按序合并（[packages/core/tools/src/index.ts:1767-1779](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1767-L1779)）
- `canonicalResults`/`markCanonical` 用执行 token 标记"本次派发已归一"的结果对象（[packages/core/tools/src/index.ts:1783-1789](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1783-L1789)）
- `createSuccessResult` 依次做值快照、按 `output.schema` 校验、`deepFreeze`、调用 `render` 生成模型可见内容并快照（[packages/core/tools/src/index.ts:1792-1803](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1792-L1803)）
- `presentationMeta` 只对无 `parent` 的顶层调用计算，抛错转成无效输出失败；`concludeTurn` 标记落成结果上的 `concludesTurn`（[packages/core/tools/src/index.ts:1804-1821](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1804-L1821)）
- `normalizeDispatchResult` 对非本次派发产出的结果重新归一：错误按字段重建，成功则重新走一遍输出校验与渲染（[packages/core/tools/src/index.ts:1825-1843](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1825-L1843)）
- `materializeFinalResult` 只把 `content`/`meta`/`additionalContexts`（成功时另加 `concludesTurn`）纳入可持久化快照，`value` 在冻结时另行挂回（[packages/core/tools/src/index.ts:1846-1861](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1846-L1861)）
- `createExecutionToken` 以 Symbol 铸造同进程唯一的关联 token（[packages/core/tools/src/index.ts:1865-1867](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1865-L1867)）
- `toolErrorResult` 把任意错误渲染成模型可见的 `Error: <message>` 文本并附结构化 info（[packages/core/tools/src/index.ts:1869-1877](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1869-L1877)）
- `fuseToolSignals` 在两信号相同时直接复用，否则新建控制器转发先到的中止原因并在结算时移除监听（[packages/core/tools/src/index.ts:1888-1915](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1888-L1915)）
- 两个取消结果构造器分别产出 `tool call aborted`（码 `ABORTED`）与 `tool call aborted before dispatch`（码 `ABORTED_BEFORE_DISPATCH`），并保留前序结果的 `additionalContexts`（[packages/core/tools/src/index.ts:1918-1943](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1918-L1943)）
- 默认导出 `ToolRuntime` 服务类，供加载器按插件挂载（[packages/core/tools/src/index.ts:1945](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L1945)）

### packages/core/tools/src/invariant.ts

该包的运行期不变量伴生插件，向 `invariants` 服务注册工具管线阶段序、最终快照与代码派发事件的检查。

- 声明伴生插件名 `tools-invariant` 并注入 `invariants` 服务（[packages/core/tools/src/invariant.ts:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L11-L13)）
- `validateResult` 要求 `tools/result` 发布前执行对象、结果与内容均已冻结，且 `name`/`callId` 非空（[packages/core/tools/src/invariant.ts:18-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L18-L30)）
- `validateDispatch` 检查代码派发事件的三个 id 非空、同一 subCallId 的 rootCallId 不得改变、parentCallId 必须归属同一 root（[packages/core/tools/src/invariant.ts:37-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L37-L52)）
- `commitDispatch` 把 subCallId→rootCallId 记入该会话的映射表供后续校验（[packages/core/tools/src/invariant.ts:53-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L53-L57)）
- `seed` 重放会话已有事件，跟踪 `turn/start`/`turn/end` 得出当前开启的轮次，并对轮次外的代码派发事件报失败（[packages/core/tools/src/invariant.ts:58-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L58-L74)）
- 安装时为现存会话播种，并订阅 `session/created` 与 `session/event` 持续更新轮次状态与派发映射（[packages/core/tools/src/invariant.ts:76-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L76-L83)）
- 通过 `internal/dispatch` 在事件真正派发前校验会话事件，并对开启轮次外的代码派发事件报失败（[packages/core/tools/src/invariant.ts:84-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L84-L93)）
- 用弱表记录每个执行的阶段，强制 pre-execute 不重复、execute 必跟在 pre 之后、post-execute 必跟在 pre 或 execute 之后（[packages/core/tools/src/invariant.ts:94-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L94-L114)）
- `tools/result` 时校验最终快照并清除该执行的阶段记录（[packages/core/tools/src/invariant.ts:115-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L115-L119)）
- 安装器声明注入 `sessions`，`apply` 以包名向 `ctx.invariants` 注册并返回 disposer（[packages/core/tools/src/invariant.ts:120-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/invariant.ts#L120-L128)）

### packages/core/tools/src/json-schema.ts

受支持 JSON Schema 子集的定义、断言与取值校验，被工具输出声明、生成的 SDK 类型、子智能体与工作流共用。

- `JsonSchemaError` 以 `UNSUPPORTED_SCHEMA` 码携带全部违规项而非只报第一处（[packages/core/tools/src/json-schema.ts:65-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L65-L74)）
- 三张常量表界定允许的约束关键字、注解关键字与类型取值（[packages/core/tools/src/json-schema.ts:76-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L76-L87)）
- `hasIntrinsicConstructor` 用构造器名、prototype 回指与原生代码字符串判定内建原型（[packages/core/tools/src/json-schema.ts:91-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L91-L102)）
- `isPlainJsonRecord` 跨 realm 判定普通对象，排除数组与异常原型链（[packages/core/tools/src/json-schema.ts:105-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L105-L124)）
- `hasOnlyEnumerableStringKeys` 与 `isJsonSchemaRecord` 要求 schema 记录只有自有可枚举字符串键（[packages/core/tools/src/json-schema.ts:138-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L138-L154)）
- `isPlainJsonArray` 要求数组为内建原型、稠密、且没有多余自有键（[packages/core/tools/src/json-schema.ts:161-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L161-L172)）
- `isJsonNumber` 排除非有限数与负零（[packages/core/tools/src/json-schema.ts:175-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L175-L177)）
- `scalarMatches` 按声明类型判定标量取值，其中 `integer` 额外要求整数（[packages/core/tools/src/json-schema.ts:180-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L180-L190)）
- `checkObjectSchemaTail` 校验 `required` 为字符串数组且每项都在 `properties` 中、`additionalProperties` 为布尔（[packages/core/tools/src/json-schema.ts:203-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L203-L224)）
- `checkSchemaNode` 用显式任务栈遍历而不用调用栈，遇非记录、遇环各报一条违规（[packages/core/tools/src/json-schema.ts:227-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L227-L255)）
- `one-of-tail` 任务在分支遍历完后检查 `properties`/`required`/`additionalProperties`/`items`/`enum`/`const` 不得与 `oneOf` 同现（[packages/core/tools/src/json-schema.ts:234-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L234-L238)）
- 未列入约束/注解白名单的键一律报"不支持的关键字"，注解值必须是无损 JSON，`description`/`title` 必须是字符串（[packages/core/tools/src/json-schema.ts:257-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L257-L274)）
- 同时声明 `type` 与 `oneOf` 报错；两者都无时任何约束关键字都报"需要 type 或 oneOf"（[packages/core/tools/src/json-schema.ts:276-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L276-L287)）
- `oneOf` 必须是至少两个分支的数组，分支逆序压栈以保证按声明顺序产出违规路径（[packages/core/tools/src/json-schema.ts:289-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L289-L300)）
- `type` 必须是单个受支持字符串，数组形式的 type 给出专门的错误措辞（[packages/core/tools/src/json-schema.ts:302-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L302-L308)）
- `allowedFor` 表限定各关键字只能出现在哪些类型上（[packages/core/tools/src/json-schema.ts:310-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L310-L322)）
- 对象类型下 `properties` 必须是 schema 记录并逐个入栈；数组类型下 `items` 入栈（[packages/core/tools/src/json-schema.ts:324-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L324-L345)）
- 标量类型下 `enum` 必须是非空且元素类型匹配的数组、`const` 必须类型匹配，两者同现时 `const` 须属于 `enum`（[packages/core/tools/src/json-schema.ts:347-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L347-L371)）
- `assertSupportedJsonSchema` 收集全部违规后一次性抛 `JsonSchemaError`（[packages/core/tools/src/json-schema.ts:385-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L385-L389)）
- `assertObjectJsonSchema` 在子集之外再要求根节点 `type` 为 `object`（[packages/core/tools/src/json-schema.ts:397-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L397-L405)）
- `diagnosticPath`/`propertyPath` 决定违规文本里的路径写法，空根路径显示为 `arguments`（[packages/core/tools/src/json-schema.ts:416-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L416-L424)）
- `checkScalarValue` 对取值执行 `enum` 成员检查与 `const` 相等检查，并把期望值 JSON 化进消息（[packages/core/tools/src/json-schema.ts:475-484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L475-L484)）
- `checkValue` 用显式帧栈遍历取值，`oneOf` 帧只统计匹配分支数并要求恰好一个（[packages/core/tools/src/json-schema.ts:487-547](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L487-L547)）
- 无 `type` 且无 `oneOf` 的节点退化为"必须是无损 JSON 值"的检查（[packages/core/tools/src/json-schema.ts:548-551](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L548-L551)）
- 对象取值检查缺失的 `required` 属性、逐个下推已存在的属性、并在 `additionalProperties: false` 时报未声明键（[packages/core/tools/src/json-schema.ts:554-587](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L554-L587)）
- 数组取值在有 `items` 时逐元素下推，无 `items` 时不检查元素（[packages/core/tools/src/json-schema.ts:588-603](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L588-L603)）
- 五种标量各自给出类型错误措辞，`number` 另区分"非数字"与"非有限 JSON 数"（[packages/core/tools/src/json-schema.ts:604-630](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L604-L630)）
- 遍历中抛出的异常沿帧栈上溯到最近可承接的帧，转成"必须是无损 JSON 值"违规；无可承接帧则原样抛出（[packages/core/tools/src/json-schema.ts:634-639](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L634-L639)）
- `validateJsonSchemaValue` 以默认根标签 `value` 返回按遍历顺序排列的全部违规（[packages/core/tools/src/json-schema.ts:654-656](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/json-schema.ts#L654-L656)）

### packages/core/tools/src/presentation.ts

工具通过 `presentCall`/`presentResult` 声明的界面渲染意图词表，只有 `card` 标签联合的接口与类型别名。

- 无运行期机制

### packages/core/tools/src/ptc.ts

PTC 模式的 `run_code` 传输工具：生成模型可见的 schema 文案、把程序内的绑定调用桥回注册表管线、按并发合约调度并落日志。

- `RUN_CODE_NAME` 固定模型可见的工具名 `run_code`，`SDK_SECTION_ORDER` 固定 SDK 段在提示词中的位置（[packages/core/tools/src/ptc.ts:20-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L20-L24)）
- TypeScript 风味给出模型可见的 `run_code` 描述与 `code` 参数描述（[packages/core/tools/src/ptc.ts:47-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L47-L56)）
- Python 风味给出对应语言的描述文本（[packages/core/tools/src/ptc.ts:63-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L63-L72)）
- `RUN_CODE_FLAVORS` 按运行时语言索引这两套文案（[packages/core/tools/src/ptc.ts:86-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L86-L89)）
- `description` 参数的模型可见描述固定给出字数要求与三个示例（[packages/core/tools/src/ptc.ts:97-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L97-L100)）
- `resolveFlavor` 在无运行时挂载时退回 TypeScript 文案，运行时语言无对应条目则抛出带已知语言列表的错误（[packages/core/tools/src/ptc.ts:116-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L116-L133)）
- `CodeRunFailedError` 以 `CODE_RUN_FAILED` 码表示程序运行本身失败（[packages/core/tools/src/ptc.ts:142-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L142-L147)）
- `jsonNormalizeArgs` 对绑定调用参数做两次快照，得到派发用与落日志用的两个独立副本，非无损 JSON 直接抛出带提示的错误（[packages/core/tools/src/ptc.ts:154-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L154-L170)）
- `renderJsonValue` 用显式任务栈渲染返回值，缩进总量超过 10 个字符后子树改为紧凑输出（[packages/core/tools/src/ptc.ts:172-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L172-L255)）
- `renderValue` 让字符串返回值原样输出、其余走 JSON 渲染（[packages/core/tools/src/ptc.ts:258-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L258-L260)）
- `createRunCodeTool` 定义 `code` 与 `description` 两个必填字符串参数，参数校验始终基于这份静态规格（[packages/core/tools/src/ptc.ts:299-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L299-L315)）
- 输出声明为 `{ logs: string[], result?: json }`，渲染时把日志与返回值拼接，二者皆空时输出 `(run_code completed with no output)`（[packages/core/tools/src/ptc.ts:316-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L316-L330)）
- 执行开头拒绝空白 `description`，随后要求代码运行时存在（[packages/core/tools/src/ptc.ts:331-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L331-L335)）
- 建立运行级 AbortController 并把外层信号的中止原因转发进来（[packages/core/tools/src/ptc.ts:341-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L341-L343)）
- 单车道驱动器每轮先提交队首已结算的派发，独占调用的屏障持续到其提交完成才释放（[packages/core/tools/src/ptc.ts:396-413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L396-L413)）
- 运行已中止时队首未启动的派发被丢弃并以拒绝告知程序（[packages/core/tools/src/ptc.ts:414-420](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L414-L420)）
- 启动前用 `executionMode()` 重新分类：独占需在飞行集为空时独跑，并行受 `maxParallel` 上限约束（[packages/core/tools/src/ptc.ts:421-439](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L421-L439)）
- 待启动队列、提交队列与飞行集同时为空时驱动器返回，即一次运行的静默点（[packages/core/tools/src/ptc.ts:441-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L441-L442)）
- `drainDispatches` 先跑完驱动器，再等待所有落日志的副作用任务结束（[packages/core/tools/src/ptc.ts:452-460](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L452-L460)）
- 绑定函数在运行已结束时直接抛错，不再派发（[packages/core/tools/src/ptc.ts:467-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L467-L470)）
- 子调用 id 按 `<外层 callId>:code:<序号>` 生成，入参带上 `rootCallId`、外层 token 作为 `parent`、以及运行级信号（[packages/core/tools/src/ptc.ts:471-482](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L471-L482)）
- `settle` 先把值或错误消息交给程序，再把经 `shapeDispatchLog` 整形后的内容与日志用参数副本追加成 `tool/code-dispatch` 事件（[packages/core/tools/src/ptc.ts:490-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L490-L527)）
- 队列项的 `classify` 每轮重读分类，`abandon` 以"运行已结束"拒绝该绑定调用（[packages/core/tools/src/ptc.ts:528-536](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L528-L536)）
- `start` 先追加 `tool/code-dispatch-start` 事件，再在车道内跑 `scheduler.prepare`，只有派发/工具体阶段被放出去并发（[packages/core/tools/src/ptc.ts:537-558](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L537-L558)）
- `commit` 按提交顺序跑 finalize 或 finish，成功且内容含图片时把该内容作为插件来源的用户消息延迟给外层结果（[packages/core/tools/src/ptc.ts:559-570](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L559-L570)）
- 子结果的 `additionalContexts` 与 `concludesTurn` 被转发到外层执行上（[packages/core/tools/src/ptc.ts:571-580](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L571-L580)）
- 待写日志任务数超过并发上限时，有序车道等待其中一项完成，形成反压（[packages/core/tools/src/ptc.ts:581-587](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L581-L587)）
- 派发结算后若运行已结束则丢弃结果并抛错；子调用失败只把消息抛给程序，不透出内部错误元数据（[packages/core/tools/src/ptc.ts:592-602](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L592-L602)）
- 绑定命名空间以空原型对象加 `defineProperty` 构建，按调用方智能体的可见工具集枚举并排除 `run_code` 自身（[packages/core/tools/src/ptc.ts:605-618](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L605-L618)）
- 以全局名 `tools`、错误类 `ToolCallError`（成员名属性 `toolName`）和运行级信号调用运行时执行程序（[packages/core/tools/src/ptc.ts:620-631](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L620-L631)）
- 无论成败都在 finally 中止运行级信号并排空派发，再关闭本轮（[packages/core/tools/src/ptc.ts:632-638](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L632-L638)）
- 程序失败时抛出 `code run failed (<kind>): <message>` 并按需附上 `Captured output:` 与捕获日志；成功则返回日志与可选返回值（[packages/core/tools/src/ptc.ts:640-650](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L640-L650)）
- `presentCall` 把模型写的 `description` 作为卡片标题、`code` 作为原始输入、类别为 `execute`（[packages/core/tools/src/ptc.ts:654-659](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L654-L659)）
- 定义上的 `description` 与 `parameters` 改成 getter，在注册表投影 schema 的那一刻按当前运行时语言重新解析文案与参数 schema（[packages/core/tools/src/ptc.ts:664-681](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ptc.ts#L664-L681)）

### packages/core/tools/src/py-types.ts

工具注册表到 Python SDK 文本的投影模块，在代码运行时语言为 python 时被 `tools:sdk` 提示段渲染调用。

- `IDENTIFIER` 用 `\p{XID_Start}/\p{XID_Continue}` 界定可裸发的名字集合（[packages/core/tools/src/py-types.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L26)）
- `isBareIdentifier` 同时要求正则通过与 NFKC 自稳定，否则名字被路由到下标/`dict[str, Any]` 路径（[packages/core/tools/src/py-types.ts:99-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L99-L101)）
- `RESERVED` 列出硬关键字加 `__debug__`，命中的工具名与字段名不走属性/类体字段路径（[packages/core/tools/src/py-types.ts:121-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L121-L130)）
- `TYPING_ORDER` 固定 `typing` 导入符号的输出顺序（[packages/core/tools/src/py-types.ts:133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L133)）
- `pad` 按每级四空格生成行前缀（[packages/core/tools/src/py-types.ts:136-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L136-L138)）
- `UNPRINTABLE` 匹配 C0/DEL/C1 控制字符，供描述文本转义（[packages/core/tools/src/py-types.ts:188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L188)）
- `LONE_SURROGATE` 在 `u` 标志下匹配未配对代理码点（[packages/core/tools/src/py-types.ts:203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L203)）
- `describe` 把 description 的空白折叠成单行、把控制字符转成 `\xNN`、把孤代理转成 `\uNNNN`，折叠后为空则返回 `undefined`（[packages/core/tools/src/py-types.ts:223-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L223-L232)）
- `docLines` 先加倍反斜杠再转义双引号，输出单行三引号 docstring（[packages/core/tools/src/py-types.ts:241-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L241-L246)）
- `camelCase` 按非 `XID_Continue` 与 `_` 切词、首字母大写、拼接后 NFKC 归一化，头字符不能起始标识符时加 `Tool` 前缀并再次归一化（[packages/core/tools/src/py-types.ts:277-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L277-L285)）
- `MAX_CLASS_NAME_BASE` 把类名基名上限定为 120（[packages/core/tools/src/py-types.ts:288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L288)）
- `MAX_LIST_NESTING` 把单条注解里的 `list[` 嵌套上限定为 180（[packages/core/tools/src/py-types.ts:329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L329)）
- `capClassNameBase` 截断超长基名，并在截断落在高位代理上时再退一个码元（[packages/core/tools/src/py-types.ts:338-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L338-L342)）
- `allocateClassName` 用 `usedClassNames` 判重、按 `nextClassCounter` 追加数字后缀并登记（[packages/core/tools/src/py-types.ts:355-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L355-L366)）
- `childClassName` 把父基名与子段拼接后 NFKC 归一化再截断（[packages/core/tools/src/py-types.ts:386-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L386-L388)）
- `pyScalar` 把布尔渲染为 `True`/`False`、字符串走 `JSON.stringify`、超出安全整数范围的整数走 `BigInt` 取精确十进制位（[packages/core/tools/src/py-types.ts:436-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L436-L444)）
- `renderConstrainedScalar` 把 `const`/`enum` 渲染成 `Literal[...]` 并登记 `Literal` 导入，否则回落到宽类型（[packages/core/tools/src/py-types.ts:457-467](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L457-L467)）
- `renderType` 入口先对整棵 schema 调用 `assertSupportedJsonSchema`，之后的遍历不再逐节点复检（[packages/core/tools/src/py-types.ts:508](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L508)）
- `oneOf` 节点把每个分支排成子帧，分支继承父帧的 `listDepth`，类名段用序号派生（[packages/core/tools/src/py-types.ts:598-615](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L598-L615)）
- `oneOf` 子类型用模板字面量逐个拼成 `A | B` 而非 `Array.join`（[packages/core/tools/src/py-types.ts:534-547](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L534-L547)）
- 数组帧把唯一子类型包成 `list[...]`（[packages/core/tools/src/py-types.ts:549-555](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L549-L555)）
- `array` 节点缺 `items` 时输出 `list[Any]`，`listDepth` 达到上限时整条链降级为 `Any`，否则子帧深度加一（[packages/core/tools/src/py-types.ts:628-647](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L628-L647)）
- `TypedDict` 帧在子类型全部就绪后组装类体，字段前按需插入 `# 描述` 注释行（[packages/core/tools/src/py-types.ts:558-573](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L558-L573)）
- 非 `required` 字段包成 `NotRequired[...]` 并登记该导入（[packages/core/tools/src/py-types.ts:574-579](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L574-L579)）
- `additionalProperties` 不为 `false` 时在类体追加一行"允许额外键"的注释（[packages/core/tools/src/py-types.ts:585-587](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L585-L587)）
- 空类体补 `pass`，随后把类声明推入 `state.classes` 并以类名作为该节点的类型（[packages/core/tools/src/py-types.ts:588-592](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L588-L592)）
- 无 `type` 的节点直接输出 `Any` 并登记该导入（[packages/core/tools/src/py-types.ts:617-621](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L617-L621)）
- 标量分支把 `string`/`number`/`integer`/`boolean` 映到 `str`/`float`/`int`/`bool`，`null` 映到 `None`（[packages/core/tools/src/py-types.ts:622-627](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L622-L627)）
- 对象节点在 `className` 为空、或存在非裸标识符/保留字/非 dunder 双下划线字段名时整体降级为 `dict[str, Any]`（[packages/core/tools/src/py-types.ts:670-674](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L670-L674)）
- 无属性且开放的对象降级为 `dict[str, Any]`，封闭的空对象仍声明空 `TypedDict`（[packages/core/tools/src/py-types.ts:677-681](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L677-L681)）
- 对象帧分配类名、登记 `TypedDict` 导入，并把每个字段子帧的 `listDepth` 重置为 1（[packages/core/tools/src/py-types.ts:682-693](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L682-L693)）
- 校验失败或内部断言触发时整个节点降级为 `Any` 而不抛出（[packages/core/tools/src/py-types.ts:704-711](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L704-L711)）
- `jsonSchemaToPy` 用一次性丢弃的 state 和空 `className` 调用渲染，使带属性的对象必然降级（[packages/core/tools/src/py-types.ts:726-731](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L726-L731)）
- `SDK_INSTRUCTIONS` 是渲染在声明之上的固定模型可见使用说明文本（[packages/core/tools/src/py-types.ts:734-743](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L734-L743)）
- `renderToolsSdkPy` 先按名字字典序复制排序，保证同一工具集产出逐字节相同的文本（[packages/core/tools/src/py-types.ts:763-765](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L763-L765)）
- 每个工具分别渲染参数类型与输出类型，类名基分别以 `Args`/`Output` 结尾（[packages/core/tools/src/py-types.ts:773-775](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L773-L775)）
- 名字为裸标识符、非保留字且不以下划线开头的工具发成 `async def` 方法，docstring 紧跟在 `def` 行之后，无描述时改用 `...` 桩（[packages/core/tools/src/py-types.ts:776-789](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L776-L789)）
- 其余工具发成 `# tools["name"](args: X) -> Y` 注释行，并在有描述时追加一行注释（[packages/core/tools/src/py-types.ts:790-806](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L790-L806)）
- 一条方法都没有发出时在类体首行补 `pass`（[packages/core/tools/src/py-types.ts:808-812](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L808-L812)）
- 末尾按 `TYPING_ORDER` 过滤出实际用到的导入符号，拼出 `ToolCallError` 声明、类块、`Tools` 协议与 `tools` 单例，包进标注 python 的围栏代码块（[packages/core/tools/src/py-types.ts:813-817](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/py-types.ts#L813-L817)）

### packages/core/tools/src/schema.ts

作者向 JSON 值 schema DSL 的编译器与 `defineTool` 帮助器，被第一方工具定义与参数校验路径使用。

- `ANNOTATION_KEYS` 界定每个节点允许的注解键集合（[packages/core/tools/src/schema.ts:177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L177)）
- `authorError` 把作者向违规统一抛成 `JsonSchemaError`（[packages/core/tools/src/schema.ts:180-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L180-L182)）
- `copyAnnotations` 只按 `Object.hasOwn` 拷贝 description/title/default/examples 四个字段（[packages/core/tools/src/schema.ts:185-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L185-L190)）
- `assertAuthorKeys` 对不在白名单里的键抛错（[packages/core/tools/src/schema.ts:193-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L193-L197)）
- `assignCompiledNode` 对属性目标用 `Object.defineProperty` 写入，避开 `__proto__` 的赋值语义（[packages/core/tools/src/schema.ts:243-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L243-L263)）
- `assignCompiledPropertyMap` 把编译好的属性表安装到根 holder 或父对象节点的 `properties`（[packages/core/tools/src/schema.ts:266-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L266-L272)）
- `runSchemaCompiler` 用显式任务栈代替递归下降来编译整棵作者 schema（[packages/core/tools/src/schema.ts:275-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L275-L278)）
- `leave` 任务把节点从 `seen` 中移除，使同一对象在兄弟位置复用不算环（[packages/core/tools/src/schema.ts:279-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L279-L282)）
- `property-map-tail` 在所有属性处理完后才把非空 `required` 数组写入编译结果与父对象节点（[packages/core/tools/src/schema.ts:283-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L283-L289)）
- `property` 任务要求 `required` 出现时必须为 `true`，并把命中的键收集进 `required` 列表（[packages/core/tools/src/schema.ts:290-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L290-L304)）
- `property-map` 任务检测环、按逆序压栈以保持属性的声明顺序（[packages/core/tools/src/schema.ts:305-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L305-L329)）
- 值任务先要求输入是 schema 记录、检测环、按 `allowRequired` 决定是否放行 `required` 键（[packages/core/tools/src/schema.ts:331-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L331-L338)）
- `oneOf` 节点拒绝与 `type` 并存、要求分支是纯 JSON 数组，并按逆序压栈分支任务（[packages/core/tools/src/schema.ts:340-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L340-L357)）
- `json` 类型编译成只有注解的节点，不写 `type`（[packages/core/tools/src/schema.ts:361-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L361-L364)）
- `object` 节点要求 `additionalProperties` 必须显式为布尔，并把 `properties` 排成后续任务（[packages/core/tools/src/schema.ts:365-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L365-L381)）
- `array` 节点只在存在 `items` 时排一个子任务，且子任务不允许 `required`（[packages/core/tools/src/schema.ts:382-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L382-L395)）
- 标量节点把 `enum` 复制成新数组、把 `const` 原样写入（[packages/core/tools/src/schema.ts:396-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L396-L409)）
- 未识别的 `type` 抛出列举合法取值的作者错误（[packages/core/tools/src/schema.ts:410-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L410-L411)）
- `compilePropertyMap` 与 `compileValueSchema` 各自建一个根 holder 驱动编译并取回结果（[packages/core/tools/src/schema.ts:417-430](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L417-L430)）
- `valueSchemaSpecToJsonSchema` 编译后再过一遍 `assertSupportedJsonSchema`（[packages/core/tools/src/schema.ts:438-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L438-L442)）
- `parameterSchemaSpecToJsonSchema` 把属性表包成 `type: 'object'` 根、只在有必填项时带上 `required`，并断言结果（[packages/core/tools/src/schema.ts:449-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L449-L458)）
- `ToolArgsError` 以 `INVALID_ARGS` 码携带按 schema 遍历顺序排列的违规列表（[packages/core/tools/src/schema.ts:461-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L461-L470)）
- `validateArgs` 每次调用都重新编译参数 schema 再校验候选值（[packages/core/tools/src/schema.ts:478-480](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L478-L480)）
- `defineTool` 在定义时拒绝非正有限的 `timeoutMs`（[packages/core/tools/src/schema.ts:563-565](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L563-L565)）
- 参数 schema 与输出 schema 在定义时编译一次，校验闭包复用该编译结果（[packages/core/tools/src/schema.ts:566-568](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L566-L568)）
- 生成的定义把编译后的 parameters 与 output.schema 挂上，并只在作者提供 `presentationMeta` 时才带该成员（[packages/core/tools/src/schema.ts:569-583](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L569-L583)）
- `execute` 在调用作者函数前先校验参数，有违规就抛 `ToolArgsError`（[packages/core/tools/src/schema.ts:585-589](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L585-L589)）
- `finalizeContent` 仅在作者提供时挂载，并接收未经类型收窄的执行结果（[packages/core/tools/src/schema.ts:591-593](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L591-L593)）
- `presentCall`/`presentResult` 走软校验：参数不合法时返回 `undefined` 回落到通用卡片而不抛错（[packages/core/tools/src/schema.ts:598-609](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L598-L609)）
- `isConcurrencySafe` 在参数不合法时直接返回 `false`（[packages/core/tools/src/schema.ts:610-615](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/schema.ts#L610-L615)）

### packages/core/tools/src/testing.ts

给仓库测试用的工具定义夹具工厂，导出 `defineContentToolFixture`。

- `CONTENT_VALUE_SCHEMA` 固定为 `items` 为 `json` 的数组 schema（[packages/core/tools/src/testing.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/testing.ts#L9)）
- `defineContentToolFixture` 把作者的 `execute` 结果直接当作规范 JSON 值，并用恒等 `render` 把该值当回内容块数组（[packages/core/tools/src/testing.ts:27-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/testing.ts#L27-L42)）

### packages/core/tools/src/ts-types.ts

工具注册表到 TypeScript SDK 文本的投影模块，渲染 `tools:sdk` 提示段的 TypeScript 版本。

- `IDENTIFIER` 与 `renderKey` 决定对象键是裸发还是被 `JSON.stringify` 引号包裹（[packages/core/tools/src/ts-types.ts:19-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L19-L24)）
- `pad` 按每级两空格生成行前缀（[packages/core/tools/src/ts-types.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L27-L29)）
- `docLines` 折叠描述里的空白成单行，并把 `*/` 转义成 `*\/` 以免终止生成的 JSDoc（[packages/core/tools/src/ts-types.ts:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L32-L38)）
- `renderScalar` 用 `JSON.stringify` 输出标量字面量（[packages/core/tools/src/ts-types.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L41-L43)）
- `renderConstrainedScalar` 把 `integer` 折成 `number`，并把 `const`/`enum` 渲染成字面量或字面量并集（[packages/core/tools/src/ts-types.ts:46-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L46-L53)）
- `typeDocumentFrom` 在构造时计算 `containsUnionOrIntersection`，供数组项决定是否加括号（[packages/core/tools/src/ts-types.ts:62-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L62-L69)）
- `flattenTypeDocument` 用显式工作栈把嵌套文档摊平成字符串（[packages/core/tools/src/ts-types.ts:77-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L77-L92)）
- `oneOf` 帧把子文档用 ` | ` 串起来（[packages/core/tools/src/ts-types.ts:135-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L135-L144)）
- 数组帧在项类型含并集或交集时补括号再加 `[]`（[packages/core/tools/src/ts-types.ts:146-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L146-L154)）
- 对象帧逐字段发出 JSDoc 行与 `key?: T;` 成员行，非必填字段带 `?`（[packages/core/tools/src/ts-types.ts:156-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L156-L167)）
- 开放对象在声明后追加 `& Record<string, JsonValue>`（[packages/core/tools/src/ts-types.ts:168-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L168-L172)）
- 遇到 `oneOf` 时切换到并集帧并重置聚合状态（[packages/core/tools/src/ts-types.ts:176-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L176-L183)）
- 无 `type` 的节点输出 `JsonValue`（[packages/core/tools/src/ts-types.ts:184-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L184-L187)）
- 标量分支统一走 `renderConstrainedScalar`（[packages/core/tools/src/ts-types.ts:188-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L188-L195)）
- `array` 缺 `items` 时输出 `JsonValue[]`，否则排一个同缩进的子帧（[packages/core/tools/src/ts-types.ts:196-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L196-L206)）
- 无属性的对象按开放与否输出 `Record<string, JsonValue>` 或 `Record<string, never>`（[packages/core/tools/src/ts-types.ts:207-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L207-L221)）
- `jsonSchemaToTs` 先断言 schema 再摊平，任何抛出都降级为 `unknown`（[packages/core/tools/src/ts-types.ts:240-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L240-L247)）
- `SDK_INSTRUCTIONS` 是渲染在声明之上的固定模型可见使用说明文本（[packages/core/tools/src/ts-types.ts:250-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L250-L252)）
- `SDK_PROGRAM_INSTRUCTIONS` 是紧接在示例之后的固定程序内调用规则文本（[packages/core/tools/src/ts-types.ts:254-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L254-L261)）
- `acceptsExampleString` 检查某字符串 schema 是否接受示例里用到的字面量（[packages/core/tools/src/ts-types.ts:264-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L264-L268)）
- `renderBashExample` 只在存在 `bash` 工具、其必填项不超出 `command`/`description` 且字面量被现行 schema 接受时才把示例文本拼进提示（[packages/core/tools/src/ts-types.ts:271-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L271-L283)）
- `renderToolsSdk` 按名字字典序复制排序，保证同一工具集产出逐字节相同的文本（[packages/core/tools/src/ts-types.ts:297-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L297-L298)）
- 每个工具往 `ToolArgsMap` 写入带 JSDoc 的参数成员、往 `ToolOutputMap` 写入输出成员（[packages/core/tools/src/ts-types.ts:299-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L299-L307)）
- 最终声明块拼出 `ToolName`、`ToolCallError` 类与 `declare const tools` 映射，并前置 `JsonValue` 定义后包进标注 ts 的围栏代码块（[packages/core/tools/src/ts-types.ts:308-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/ts-types.ts#L308-L316)）

### packages/core/tools/src/types.ts

只含类型的模块，向会话事件表声明合并两个嵌套调度事件的载荷接口。

- 无运行期机制

### packages/core/tools/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工作区项目引用。

- 无运行期机制
