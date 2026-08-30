---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/llm/token-meter
---

# packages/llm/token-meter

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、104 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/llm/token-meter/README.md

包的英文说明文档，描述测量服务的用法、三个会话投影的语义与已知限制。

- 无运行期机制

### packages/llm/token-meter/package.json

npm 包清单，声明包名、模块入口、导出子路径与依赖关系。

- `"type": "module"` 与 `main` / `types` 指定该包以 ESM 方式加载，运行期入口为 `lib/index.js`（[packages/llm/token-meter/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/package.json#L13-L15)）
- `exports` 开放 `.`、`./invariant`、`./client` 三个入口，另放行 `./src/*` 与 `./package.json`；`./client` 指向未经打包的 `lib/types/client.js`（[packages/llm/token-meter/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/package.json#L16-L31)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`/`.d.ts`（[packages/llm/token-meter/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/package.json#L32-L37)）
- `peerDependencies` 要求宿主提供 compaction、invariants、llm、llm-retry、session、session-projection 与 cordis（[packages/llm/token-meter/package.json:39-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/package.json#L39-L47)）
- `dependencies` 自带 schemastery 与 `zod@^4.4.3`，后者是投影状态与线上视图 schema 的运行期实现（[packages/llm/token-meter/package.json:48-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/package.json#L48-L51)）

### packages/llm/token-meter/src/breakdown-projection.ts

定义 `contextBreakdown` 会话投影单元：把最新请求信封的系统提示词与工具 schema、以及当前会话表面折算成启发式 token 组成，由主服务在投影注册表存在时挂载。

- 状态 schema 严格限定为三个非负整数 token 计数加一个可选的阴影价格 claim，多余键会被 strict 拒绝（[packages/llm/token-meter/src/breakdown-projection.ts:23-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/breakdown-projection.ts#L23-L36)）
- 线上视图 schema 只含 `systemTokens`/`toolsTokens`/`messageTokens` 三项（[packages/llm/token-meter/src/breakdown-projection.ts:38-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/breakdown-projection.ts#L38-L42)）
- 投影单元键为 `contextBreakdown`、状态版本为 2，初始状态三项全零（[packages/llm/token-meter/src/breakdown-projection.ts:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/breakdown-projection.ts#L57-L61)）
- 每个事件都先过一遍 `foldSurfaceProjection` 得到表面 token 增量与新的 claim（[packages/llm/token-meter/src/breakdown-projection.ts:62-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/breakdown-projection.ts#L62-L63)）
- 遇到 `request/header` 时先规范化信封，再用共享估算器重算系统与工具 token，语义是「后来者覆盖」（[packages/llm/token-meter/src/breakdown-projection.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/breakdown-projection.ts#L66-L70)）
- 三项数值与 claim 都没变化时原样返回旧状态对象，不产生新状态（[packages/llm/token-meter/src/breakdown-projection.ts:71-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/breakdown-projection.ts#L71-L75)）
- 否则 `messageTokens` 累加表面增量，并只在新 claim 存在时把它带进新状态（[packages/llm/token-meter/src/breakdown-projection.ts:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/breakdown-projection.ts#L76-L81)）
- `wire.view` 只投出三项 token 计数，内部 claim 不进入外部可见视图（[packages/llm/token-meter/src/breakdown-projection.ts:83-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/breakdown-projection.ts#L83-L86)）

### packages/llm/token-meter/src/client.ts

`./client` 子路径入口，把浏览器可用的投影类型与 `deriveTurnTokenUsage` 折叠函数重新导出。

- 无运行期机制

### packages/llm/token-meter/src/estimate.ts

固定密度启发式定价的实现，被测量服务与各投影单元共用，保证同样内容在两处折算出同样的数字。

- 三个常量定死定价：每 4 个字符算 1 token、每个内容块附加 4 token 结构开销、每条消息附加 4 token 角色开销（[packages/llm/token-meter/src/estimate.ts:12-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/estimate.ts#L12-L19)）
- `estimateStructuralBlock` 以块的 JSON 序列化长度除以 4 向上取整再加块开销计价（[packages/llm/token-meter/src/estimate.ts:28-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/estimate.ts#L28-L30)）
- `estimateContent` 对 text/reasoning 按文本长度计价、对 tool-call 按名称与参数字符串长度计价、对 tool-result 递归其内容再加块开销（[packages/llm/token-meter/src/estimate.ts:37-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/estimate.ts#L37-L52)）
- 未知块类型与 image 块走 default 分支，一律按结构 JSON 价计（image 的请求价另由路由定价接管）（[packages/llm/token-meter/src/estimate.ts:53-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/estimate.ts#L53-L58)）
- `estimateMessage` 为内容价加上角色框架开销（[packages/llm/token-meter/src/estimate.ts:68-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/estimate.ts#L68-L70)）
- `estimateSystemTokens` 在信封无 system 时返回 0，否则按系统提示词字符长度计价再加角色开销（[packages/llm/token-meter/src/estimate.ts:77-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/estimate.ts#L77-L80)）
- `estimateToolsTokens` 在无工具或工具为空数组时返回 0，否则按整个工具数组的 JSON 长度计价再加块开销（[packages/llm/token-meter/src/estimate.ts:87-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/estimate.ts#L87-L90)）
- `estimateHeader` 把系统与工具两部分相加，作为非表面请求信封的总价（[packages/llm/token-meter/src/estimate.ts:97-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/estimate.ts#L97-L99)）

### packages/llm/token-meter/src/index.ts

包的主体：`TokenMeter` 服务类，为每个会话维护一份从持久日志回放出来的独立折叠状态，对外提供 `measure()` 与 `estimateMessage()`，并在投影注册表存在时挂载三个投影单元。

- `usageTokens` 把 provider 上报的输入、缓存读、缓存写、输出四个不相交桶相加作为该次调用的总量（[packages/llm/token-meter/src/index.ts:53-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L53-L58)）
- `optionalHeaderEquals` 在两侧都有信封时按 `headerEquals` 比较，任一侧缺失时只有两侧都缺失才算相等（[packages/llm/token-meter/src/index.ts:61-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L61-L67)）
- `validateConfigKeys` 对配置里出现的任意键抛错，使拼错或过期的配置在装载时就失败（[packages/llm/token-meter/src/index.ts:70-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L70-L74)）
- 服务以 `tokenMeter` 名注册到上下文，静态 `Config` 为空对象 schema，构造时立即执行键校验（[packages/llm/token-meter/src/index.ts:86-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L86-L92)）
- 通过 `ctx.inject(['sessionProjections'])` 作为可选子上下文注册 `tokenUsage`、`contextPressure`、`contextBreakdown` 三个投影定义；没有该服务的组合仍可用独立读取形态（[packages/llm/token-meter/src/index.ts:96-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L96-L100)）
- 监听 `session/event`，但只对已建立折叠状态的会话即时推进，不为无人读过的会话建状态（[packages/llm/token-meter/src/index.ts:104-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L104-L106)）
- `measure()` 先把折叠推进到日志末尾；传入的 `requestHeader` 经规范化后取代日志中最新信封用于定价，节点集合仍描述当前会话（[packages/llm/token-meter/src/index.ts:129-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L129-L135)）
- 锚点信封与当前信封相同时，把锚点快照用同一路由定价重算，再加上该次调用的助手输出价，得到锚点全量启发式价（[packages/llm/token-meter/src/index.ts:140-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L140-L146)）
- 只有当 provider 上报总量不低于该锚点全量启发式价时才以 usage 作为基线，否则退回估算基线；表面差值取当前表面价减锚点表面价，可为负（[packages/llm/token-meter/src/index.ts:147-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L147-L153)）
- 既无信封又无表面内容时基线为 `none`、总量 0；其余情况以「信封价 + 当前表面价」作估算基线且差值为 0（[packages/llm/token-meter/src/index.ts:154-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L154-L163)）
- 返回值经 `structuredClone` 脱离内部状态并 `deepFreeze` 冻结，携带已消费事件数作为日志修订号，`totalTokens` 取基线加差值并夹到非负（[packages/llm/token-meter/src/index.ts:165-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L165-L172)）
- `_routeImagePricing` 用可选的 `llm` 服务按信封里的 provider/model 取路由声明的图像定价，缺信封或缺服务时返回 undefined（[packages/llm/token-meter/src/index.ts:176-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L176-L180)）
- 实例方法 `estimateMessage` 直接转调纯函数版本，对外暴露同一套固定启发式（[packages/llm/token-meter/src/index.ts:188-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L188-L190)）
- `_sync` 用 WeakMap 按会话惰性建状态，然后从 `consumedEvents` 处逐条折叠到当前日志长度（[packages/llm/token-meter/src/index.ts:193-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L193-L213)）
- `request/header` 事件把规范化后的信封记入下一状态（[packages/llm/token-meter/src/index.ts:226-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L226-L228)）
- 上一个步未闭合就出现 `step/start` 时抛错；`step/end` 与已打开步的 turn/step 不匹配也抛错（[packages/llm/token-meter/src/index.ts:229-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L229-L244)）
- `step/start` 会把当时的表面快照连同 turn/step 一起存下，作为后续锚点的表面基准（[packages/llm/token-meter/src/index.ts:235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L235)）
- 表面事件先跑只读的 `planSurfaceTokens` 得到计划，不立刻改动表面（[packages/llm/token-meter/src/index.ts:249-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L249-L251)）
- `assistant/message` 找不到匹配的已打开步时抛错（[packages/llm/token-meter/src/index.ts:253-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L253-L259)）
- 助手消息带 usage 且信封已知时建立带 usage 的测量锚点，助手输出价按引用的 chunk 重算；否则锚点不带 usage 且直接用持久事件本身的价（[packages/llm/token-meter/src/index.ts:264-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L264-L278)）
- 所有会抛错的步骤跑完之后才写回信封、步边界、提交表面变更与锚点，使畸形事件不会留下半应用状态（[packages/llm/token-meter/src/index.ts:281-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L281-L286)）
- `_estimateProviderAssistant` 在助手消息没有 `sourceEventSeqs` 时保守地把持久输出当作 provider 输出计价（[packages/llm/token-meter/src/index.ts:299-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L299-L300)）
- 引用的每个 seq 必须早于本事件、不得重复、必须是 `assistant/chunk`、且属于同一 turn/step，四条中任一不满足即抛错（[packages/llm/token-meter/src/index.ts:304-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L304-L322)）
- 用 `BlockAssembler` 把引用的 chunk 重新拼成块序列，空列表计为 0，否则按内容价加角色开销计（[packages/llm/token-meter/src/index.ts:323-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L323-L326)）
- 以 `TokenMeter` 类作为默认导出，供 Loader 按服务包形态装载（[packages/llm/token-meter/src/index.ts:330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/index.ts#L330)）

### packages/llm/token-meter/src/invariant.ts

包自带的不变量伴生插件，向不变量服务登记本包的所有权，但不安装任何运行期检查。

- 声明伴生插件名 `token-meter-invariant` 并注入 `invariants` 服务（[packages/llm/token-meter/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/invariant.ts#L12-L15)）
- 安装器为空实现，注释说明估算是每次调用的输出、私有会话缓存在事件变更处失效、三个投影的负载已由 schema 固定（[packages/llm/token-meter/src/invariant.ts:17-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/invariant.ts#L17-L31)）
- `apply` 用包名向 `ctx.invariants` 注册该空安装器并返回其卸载器（[packages/llm/token-meter/src/invariant.ts:38-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/invariant.ts#L38-L39)）

### packages/llm/token-meter/src/projection.ts

浏览器可用的投影词汇类型模块，定义三个投影的对外视图字段，并通过声明合并把它们并入会话投影映射。

- 无运行期机制

### packages/llm/token-meter/src/route-pricing.ts

把折叠出的固定启发式节点按路由声明的图像定价重算，供 `measure()` 得到路由定价后的表面总量与逐节点价。

- 没有路由定价、或表面上没有图像出现时，每个节点原样使用其固定启发式价，`tokens` 与 `heuristicTokens` 相等（[packages/llm/token-meter/src/route-pricing.ts:36-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/route-pricing.ts#L36-L44)）
- 把所有节点的图像出现拍平后一次性交给 `pricing.priceImages`，返回条数与请求条数不一致时抛错而不是错位定价（[packages/llm/token-meter/src/route-pricing.ts:45-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/route-pricing.ts#L45-L50)）
- 含图像的节点改以「去图价」为底，按游标顺序逐个加上该图的视觉 token 与其模型可见文本的启发式价，累计成路由表面总量（[packages/llm/token-meter/src/route-pricing.ts:51-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/route-pricing.ts#L51-L67)）

### packages/llm/token-meter/src/surface-fold.ts

测量服务的位置化表面折叠：把每个表面事件折算成一个带价格与图像出现的节点，并以 plan/commit 两段式插入或替换到表面序列。

- 节点同时携带固定启发式价、去掉图像结构价后的「去图价」、以及按消息顺序排列的图像出现（[packages/llm/token-meter/src/surface-fold.ts:26-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-fold.ts#L26-L35)）
- `collectImages` 递归收集 image 块的附件引用并累加它们的结构价，且会深入 tool-result 的内容（[packages/llm/token-meter/src/surface-fold.ts:50-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-fold.ts#L50-L61)）
- `analyzeNode` 对派生不出消息的事件产出全零节点，否则以消息启发式价减去图像结构价得到去图价（[packages/llm/token-meter/src/surface-fold.ts:64-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-fold.ts#L64-L75)）
- `planSurfaceTokens` 对 `append` 操作产出「增量等于本身价」的追加计划（[packages/llm/token-meter/src/surface-fold.ts:86-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-fold.ts#L86-L94)）
- 替换操作按 seq 在现有表面里找起止下标，任一端找不到或起大于止即抛错（[packages/llm/token-meter/src/surface-fold.ts:96-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-fold.ts#L96-L102)）
- 替换的签名增量为新节点价减去被替换区间内所有节点的启发式价之和（[packages/llm/token-meter/src/surface-fold.ts:103-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-fold.ts#L103-L106)）
- `commitSurfaceTokens` 原地生效：追加走 push，替换走 splice 覆盖整个闭区间；该步不会抛错（[packages/llm/token-meter/src/surface-fold.ts:115-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-fold.ts#L115-L121)）

### packages/llm/token-meter/src/surface-projection.ts

投影单元共用的 O(1) 表面 token 折叠：以「紧邻替换之前的计量事件声明被替换区间价格」的阴影价格协议代替保留逐节点价格。

- `compaction/summary` 与 `compaction/prune` 事件本身增量为 0，但会以其 `shadowedRange` 与 `shadowedTokenCount` 装载一个待用 claim（[packages/llm/token-meter/src/surface-projection.ts:70-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-projection.ts#L70-L76)）
- 非表面事件增量为 0，并让已装载的 claim 失效（[packages/llm/token-meter/src/surface-projection.ts:77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-projection.ts#L77)）
- 表面事件以 `deriveEventMessage` 派生消息再用共享估算器计价，派生不出消息时计 0（[packages/llm/token-meter/src/surface-projection.ts:78-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-projection.ts#L78-L79)）
- `append` 增量为该消息价，并清空 claim（[packages/llm/token-meter/src/surface-projection.ts:80-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-projection.ts#L80-L81)）
- 替换到来时没有已装载 claim 的，按 0 增量中性折叠，让旧日志退化为漂移而不是失败（[packages/llm/token-meter/src/surface-projection.ts:82-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-projection.ts#L82-L86)）
- 已装载的 claim 区间与替换区间不一致时抛错，不让总量静默漂移（[packages/llm/token-meter/src/surface-projection.ts:87-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-projection.ts#L87-L92)）
- 区间匹配时增量为新消息价减去 claim 声明的被替换区间价，并消耗掉该 claim（[packages/llm/token-meter/src/surface-projection.ts:93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/surface-projection.ts#L93)）

### packages/llm/token-meter/src/turn-usage.ts

纯折叠函数 `deriveTurnTokenUsage`：把一个完整轮次内的持久事件折成逐次尝试与整轮的精确 token 用量，供浏览器端消费者使用。

- `isCount` 只接受非负安全整数，`safeSum` 一旦累加越出安全整数范围即返回 undefined（[packages/llm/token-meter/src/turn-usage.ts:58-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L58-L69)）
- `messageRoute` 只在 provider 与 model 都非空时给出路由归属（[packages/llm/token-meter/src/turn-usage.ts:71-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L71-L74)）
- `normalizeUsage` 拒绝输入/输出非计数、缓存桶非计数、以及推理 token 超过输出 token 的样本（[packages/llm/token-meter/src/turn-usage.ts:76-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L76-L85)）
- 有 `totalTokens` 时，反推的提示词量必须是计数且不小于已知提示词量；两个缓存桶都在场时二者还必须严格相等，否则整条样本作废（[packages/llm/token-meter/src/turn-usage.ts:94-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L94-L102)）
- 没有 `totalTokens` 时，必须两个缓存桶都在场才能自行推出精确总量，否则作废（[packages/llm/token-meter/src/turn-usage.ts:103-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L103-L108)）
- `aggregateAttempts` 在无尝试或三项必需和越界时返回 undefined（[packages/llm/token-meter/src/turn-usage.ts:121-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L121-L126)）
- 缓存读、缓存写、推理三个可选聚合只在每一次尝试都上报了该桶时才出现在结果里（[packages/llm/token-meter/src/turn-usage.ts:128-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L128-L133)）
- `routes` 只在每一次计费尝试都有归属时给出，并按 `provider\0model` 去重（[packages/llm/token-meter/src/turn-usage.ts:137-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L137-L143)）
- `turn/start` 只允许出现一次且必须在 idle 状态；出现在 `turn/start` 之前的任何其它事件直接判整体作废（[packages/llm/token-meter/src/turn-usage.ts:190-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L190-L198)）
- `turn/end` 必须轮号匹配、处于 idle、且只出现一次；其后再出现事件即作废（[packages/llm/token-meter/src/turn-usage.ts:199-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L199-L207)）
- `step/start` 只能从 idle 打开一次新尝试（[packages/llm/token-meter/src/turn-usage.ts:208-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L208-L212)）
- `llm/retry-started` 只能把「因重试而结算」的同一 turn/step 重新打开为一次新尝试，从而让重试算作另一次计费（[packages/llm/token-meter/src/turn-usage.ts:213-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L213-L220)）
- `assistant/chunk` 的 usage 类型记为当前尝试的样本；finish 且原因为 error 或 aborted 时用该样本关闭这次尝试（[packages/llm/token-meter/src/turn-usage.ts:221-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L221-L236)）
- `assistant/message` 带 usage 时以其取代同一尝试的早期样本，再带路由归属关闭该尝试并转入「由消息结算」（[packages/llm/token-meter/src/turn-usage.ts:237-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L237-L248)）
- `llm/retry` 只能作用于同一 turn/step 的非 idle 状态：已结算态直接作废，打开态则先结算再转入「由重试结算」（[packages/llm/token-meter/src/turn-usage.ts:249-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L249-L258)）
- `step/end` 关闭仍打开的尝试并回到 idle，turn/step 不匹配或处于 idle 时作废（[packages/llm/token-meter/src/turn-usage.ts:259-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L259-L267)）
- 只要中途作废、没看到 `turn/end`、或结束时状态不是 idle，整个披露一律返回 undefined（[packages/llm/token-meter/src/turn-usage.ts:270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/turn-usage.ts#L270)）

### packages/llm/token-meter/src/types.ts

公开的配置与测量词汇类型模块，定义 `TokenMeterConfig`、测量基线联合类型、测量快照与表面节点结构。

- 无运行期机制

### packages/llm/token-meter/src/usage-projection.ts

定义 `tokenUsage` 与 `contextPressure` 两个会话投影单元：前者累计 provider 上报的用量桶，后者把最新用量样本与最新路由容量配成占用度读数。

- `bucketsFrom` 把缺失的缓存读/写桶折成 0，使四个桶总是齐备（[packages/llm/token-meter/src/usage-projection.ts:20-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L20-L25)）
- `addReplacing` 在累计时先减去同一次尝试的旧值再加新值，实现「替换而非重复计数」（[packages/llm/token-meter/src/usage-projection.ts:33-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L33-L42)）
- 用量视图与状态 schema 都是 strict 的非负整数对象，`last` 槽位可为 null（[packages/llm/token-meter/src/usage-projection.ts:44-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L44-L62)）
- 压力视图 schema 用 transform 把值为 undefined 的三个可选字段整个从对外对象里删掉（[packages/llm/token-meter/src/usage-projection.ts:66-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L66-L74)）
- `pressureFrom` 只算提示词一侧（输入加缓存读写），不含输出，使该数值在本轮流式输出期间保持不动（[packages/llm/token-meter/src/usage-projection.ts:76-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L76-L78)）
- `usageOf` 只从 usage 类型的助手 chunk 或带 usage 的助手消息里取用量，其余事件无用量（[packages/llm/token-meter/src/usage-projection.ts:80-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L80-L86)）
- `tokenUsage` 单元键与状态版本 2，初始为四桶全零加空 `last` 槽（[packages/llm/token-meter/src/usage-projection.ts:120-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L120-L124)）
- `llm/retry-started` 在 turn/step 匹配时清空 `last` 槽，使重试后的同一步用量作为新的一次计费累加而非替换（[packages/llm/token-meter/src/usage-projection.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L126-L130)）
- 非用量事件原样返回状态；同一 turn/step 的重复样本与旧值相等时也原样返回，不产生新状态（[packages/llm/token-meter/src/usage-projection.ts:131-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L131-L149)）
- 新样本以替换方式更新总量并写入 `last` 槽；对外视图只投出 `totals` 四桶（[packages/llm/token-meter/src/usage-projection.ts:151-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L151-L156)）
- `contextPressure` 单元键与状态版本 4，初始只有 `surfaceTokens: 0`（[packages/llm/token-meter/src/usage-projection.ts:180-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L180-L184)）
- `request/context` 事件后来者覆盖地更新 `contextWindow`，该字段变为 undefined 时把它整个从状态里删掉（[packages/llm/token-meter/src/usage-projection.ts:188-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L188-L198)）
- 出现用量样本时记下提示词压力，并把当时的表面总量一并快照为 `sampledSurfaceTokens`；该记录发生在同一事件并入表面之前（[packages/llm/token-meter/src/usage-projection.ts:199-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L199-L205)）
- 表面折叠的非零增量累加进运行中的 `surfaceTokens`，使压缩造成的收缩也能被记入（[packages/llm/token-meter/src/usage-projection.ts:206-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L206-L208)）
- claim 记账：前后都无 claim 时直接返回，否则先剥掉旧 claim，再按需要装上新 claim（[packages/llm/token-meter/src/usage-projection.ts:209-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L209-L213)）
- 对外视图按需省略缺失字段，并在有样本时计算 `projectedTokens = max(0, 压力 + 当前表面 − 采样时表面)`（[packages/llm/token-meter/src/usage-projection.ts:215-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/token-meter/src/usage-projection.ts#L215-L224)）

### packages/llm/token-meter/tsconfig.json

包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 并引用工作区依赖工程。

- 无运行期机制
