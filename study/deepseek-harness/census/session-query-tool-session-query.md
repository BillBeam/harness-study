---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session-query/tool-session-query
---

# packages/session-query/tool-session-query

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 10 个文件、85 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session-query/tool-session-query/README.md

包说明文档，描述这五个模型可见的会话历史工具、工作区授权规则与失败码，供部署与维护者阅读。

- 无运行期机制

### packages/session-query/tool-session-query/package.json

包清单，声明这个工具包的入口、发布内容与依赖关系。

- `"type": "module"` 使包内文件按 ESM 解析（[packages/session-query/tool-session-query/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/package.json#L13)）
- `main`/`types` 把包主入口指向构建产物 `lib/index.js` 与其类型声明（[packages/session-query/tool-session-query/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/package.json#L14-L15)）
- `exports` 只放行 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/session-query/tool-session-query/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/package.json#L16-L27)）
- `files` 限定发布进 npm 包的运行期文件为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/session-query/tool-session-query/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/package.json#L28-L32)）
- `peerDependencies` 要求宿主提供工具、系统提示词、会话查询、超时等服务包（[packages/session-query/tool-session-query/package.json:34-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/package.json#L34-L43)）

### packages/session-query/tool-session-query/src/index.ts

插件入口，解析配置、注册一段系统提示词小节，并注册五个模型可见的只读工具。

- 导出插件名与 `inject`，要求 `tools`、`systemPrompt`、`sessionQuery` 三个服务就绪后才装载（[packages/session-query/tool-session-query/src/index.ts:16-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L16-L20)）
- 默认最大检索结果数 100、默认检索超时 30000 毫秒（[packages/session-query/tool-session-query/src/index.ts:22-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L22-L26)）
- Schemastery 配置模式给两个字段设定整数步长、下界与默认值，超时上界取自定时器最大延迟（[packages/session-query/tool-session-query/src/index.ts:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L36-L40)）
- 五个工具共用同一个输出定义：结果类型为字符串，渲染成单个 text 块回灌给模型（[packages/session-query/tool-session-query/src/index.ts:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L47-L50)）
- 固定的提示词文本告知模型用哪两个工具检索、结果无游标且按工作区限定、以及可用哪三个工具跟进（[packages/session-query/tool-session-query/src/index.ts:52-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L52-L55)）
- `apply` 把该文本注册为一个具名系统提示词小节，排序位取自一方小节顺序表（[packages/session-query/tool-session-query/src/index.ts:57-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L57-L64)）
- 注册 `session_search`：带跨会话检索参数模式、配置的超时、把最大结果数传给执行体，并给出调用卡片（[packages/session-query/tool-session-query/src/index.ts:66-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L66-L74)）
- 注册 `session_event_search`：会话内检索参数模式，同样受配置超时约束（[packages/session-query/tool-session-query/src/index.ts:76-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L76-L84)）
- 注册 `session_trace`，并用 `isConcurrencySafe: () => true` 允许它与同批工具调用并行执行（[packages/session-query/tool-session-query/src/index.ts:86-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L86-L94)）
- 注册 `session_event_trace`，参数在目标会话之上追加必填整数 `seq`，同样标为可并行（[packages/session-query/tool-session-query/src/index.ts:96-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L96-L107)）
- 注册 `session_event_read`，参数追加必填 `seq` 与可选 `before`/`after` 邻域条数，标为可并行（[packages/session-query/tool-session-query/src/index.ts:109-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L109-L122)）
- `resolveConfig` 填默认值并校验最大结果数为正安全整数、超时为不超过定时器上限的正整数，违反即在装载时抛 `TypeError`（[packages/session-query/tool-session-query/src/index.ts:125-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/index.ts#L125-L137)）

### packages/session-query/tool-session-query/src/input.ts

模型参数模式与参数归一化模块，定义模型看到的字段并把它们转成服务侧过滤器。

- `session_search` 的参数模式定义模型可见字段：查询串、会话 id 集合、创建时间上下界、父会话 id、是否含根会话、可用性枚举，以及事件序号／时间／类型／面过滤（[packages/session-query/tool-session-query/src/input.ts:45-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L45-L67)）
- `session_event_search` 的参数模式：可选目标会话 id、查询串、序号与时间区间、事件类型与面枚举（[packages/session-query/tool-session-query/src/input.ts:69-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L69-L82)）
- 三个跟进工具共用的目标会话参数只有一个可选 `session_id`，省略即当前会话（[packages/session-query/tool-session-query/src/input.ts:84-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L84-L86)）
- 会话过滤器由 id 集合、创建时间区间与可用性集合构成，且提供了的数组必须非空（[packages/session-query/tool-session-query/src/input.ts:88-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L88-L101)）
- 父会话 id 在授权前先去重（[packages/session-query/tool-session-query/src/input.ts:103-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L103-L107)）
- 事件过滤器由序号区间、时间区间、类型集合与面集合构成，空数组一律拒绝（[packages/session-query/tool-session-query/src/input.ts:109-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L109-L124)）
- 模型给的查询串去首尾空白并把连续空白折叠为单空格，空串与含 NUL 的串抛 `SESSION_QUERY_INVALID_QUERY`（[packages/session-query/tool-session-query/src/input.ts:126-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L126-L141)）
- 序号区间要求两端都是非负安全整数且下界不大于上界（[packages/session-query/tool-session-query/src/input.ts:143-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L143-L156)）
- 时间区间解析两端 ISO 时间戳、比较先后，并把它们转成闭区间的毫秒边界（[packages/session-query/tool-session-query/src/input.ts:158-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L158-L177)）
- ISO 时间戳必须匹配固定正则，即必须带 `Z` 或数字时区偏移（[packages/session-query/tool-session-query/src/input.ts:179-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L179-L180)）
- 时间戳解析逐项校验月、日（含闰年）、时、分、秒与时区偏移范围，取前三位小数为毫秒、其余数字作为亚毫秒余数保留（[packages/session-query/tool-session-query/src/input.ts:188-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L188-L221)）
- 两个时间戳先比毫秒再逐位比亚毫秒余数（[packages/session-query/tool-session-query/src/input.ts:223-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L223-L234)）
- 带亚毫秒余数时，下界取毫秒的下一个可表示浮点值、上界取「毫秒加一」的前一个可表示浮点值，使闭区间不吞掉不该含的事件（[packages/session-query/tool-session-query/src/input.ts:236-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L236-L264)）
- 月份天数按公历闰年规则计算（[packages/session-query/tool-session-query/src/input.ts:266-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L266-L269)）
- 区间与数组校验失败统一抛出带 `SESSION_QUERY_INVALID_FILTER` 码的错误（[packages/session-query/tool-session-query/src/input.ts:271-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L271-L294)）
- 以 `toolInput` 对象导出三套参数模式与全部归一化函数，供插件入口与操作模块使用（[packages/session-query/tool-session-query/src/input.ts:296-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/input.ts#L296-L307)）

### packages/session-query/tool-session-query/src/invariant.ts

包自带的不变量伴生插件，向不变量服务登记本包名。

- 声明伴生插件名并要求先有 `invariants` 服务（[packages/session-query/tool-session-query/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/invariant.ts#L12-L15)）
- 安装器为空，本包不注册任何运行期不变量检查（[packages/session-query/tool-session-query/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/invariant.ts#L17-L21)）
- `apply` 用包名向 `ctx.invariants` 注册并返回该注册的弃置函数（[packages/session-query/tool-session-query/src/invariant.ts:23-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/invariant.ts#L23-L29)）

### packages/session-query/tool-session-query/src/operations.ts

五个工具的执行体，把模型参数变成受工作区授权约束的服务调用并汇总成文本结果。

- 跨会话检索先取调用方会话，调用方没有 `cwd` 时直接抛 `SESSION_QUERY_TOOL_UNAUTHORIZED`（[packages/session-query/tool-session-query/src/operations.ts:54-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L54-L67)）
- 把模型的查询串、会话过滤字段与事件过滤字段分别归一化成服务侧过滤器（[packages/session-query/tool-session-query/src/operations.ts:68-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L68-L77)）
- 请求的父会话 id 先逐个做工作区授权，未授权的被剔除；若最终父值集合为空则直接返回空结果文本而不发起检索（[packages/session-query/tool-session-query/src/operations.ts:78-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L78-L88)）
- 无条件追加一个 `cwd` 等于调用方工作目录的会话过滤器（[packages/session-query/tool-session-query/src/operations.ts:89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L89)）
- 通过服务边界翻页收集结果，并在收集时剔除调用方自身会话与未通过工作区校验的命中（[packages/session-query/tool-session-query/src/operations.ts:90-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L90-L101)）
- 收集完成后再批量授权命中项的父会话、批量读取标题，然后渲染成模型可见文本（[packages/session-query/tool-session-query/src/operations.ts:103-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L103-L113)）
- 会话内检索先解析目标会话 id（省略即当前会话）并做目标授权（[packages/session-query/tool-session-query/src/operations.ts:116-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L116-L126)）
- 目标是当前会话时把序号上界压到最后一个 `step/start` 事件的前一条，找不到步骤边界则抛 `SESSION_QUERY_TOOL_NO_CURRENT_STEP`（[packages/session-query/tool-session-query/src/operations.ts:127-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L127-L136)）
- 压缩后的序号区间为空时直接返回空结果文本，不再发起检索（[packages/session-query/tool-session-query/src/operations.ts:137-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L137-L139)）
- 每翻一页都用返回页里的会话头重新校验目标仍在调用方工作区内（[packages/session-query/tool-session-query/src/operations.ts:149-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L149-L165)）
- 会话谱系工具在授权后调用 `traceSession`，并用返回的目标会话头再校验一次授权（[packages/session-query/tool-session-query/src/operations.ts:168-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L168-L178)）
- 祖先链在遇到第一个未授权节点处截断并置边界标志；服务侧标明谱系不完整时也置边界标志（[packages/session-query/tool-session-query/src/operations.ts:180-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L180-L189)）
- 后代树按授权投影后收集所有可见 id 并批量取标题，再渲染（[packages/session-query/tool-session-query/src/operations.ts:190-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L190-L197)）
- 事件谱系工具先校验 `seq` 为非负安全整数，授权后调用 `traceEvent` 并复核返回的会话头（[packages/session-query/tool-session-query/src/operations.ts:200-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L200-L214)）
- 事件读取工具校验 `seq`、`before`、`after` 均为非负安全整数，只在模型给了邻域参数时才传给服务，并复核返回的会话头（[packages/session-query/tool-session-query/src/operations.ts:216-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L216-L237)）
- 翻页收集器每轮前后检查中止信号，累计到 `maxResults` 即停并标记为已截断，从而把游标完全挡在模型之外（[packages/session-query/tool-session-query/src/operations.ts:239-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L239-L262)）
- 提供方重复返回同一个续页游标时抛 `SESSION_QUERY_INVALID_CURSOR`，避免无限翻页（[packages/session-query/tool-session-query/src/operations.ts:263-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/operations.ts#L263-L271)）

### packages/session-query/tool-session-query/src/presentation.ts

结果渲染模块，决定五个工具回灌给模型的文本形状以及宿主展示的调用卡片。

- 会话检索文本逐条列出会话 id、标题、创建时间、父会话、可用性、最佳匹配事件与摘要；未授权的父会话渲染成 `[outside workspace]`，无父会话渲染成 `root`（[packages/session-query/tool-session-query/src/presentation.ts:48-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L48-L74)）
- 结果被结果上限截断时追加一句提示，要求模型缩小查询或加过滤条件（[packages/session-query/tool-session-query/src/presentation.ts:75-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L75-L78)）
- 无命中时返回固定文本 `No prior session matches found.`（[packages/session-query/tool-session-query/src/presentation.ts:81-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L81-L83)）
- 会话内检索文本以会话与标题开头，逐条列出序号、类型、面、时间与摘要，并同样带截断提示（[packages/session-query/tool-session-query/src/presentation.ts:85-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L85-L106)）
- 谱系文本给出目标信息、按近及远的祖先列表，无祖先且无边界时写明是根会话，有边界时写 `[outside workspace boundary]` 而不带任何 id（[packages/session-query/tool-session-query/src/presentation.ts:108-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L108-L131)）
- 后代按深度缩进渲染，未授权子树渲染成 `[outside workspace subtree]` 且不含 id（[packages/session-query/tool-session-query/src/presentation.ts:133-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L133-L147)）
- 事件谱系文本固定输出目标事件、被谁替换、替换链、被目标替换的事件、被直接引用的来源事件与直接派生事件六行（[packages/session-query/tool-session-query/src/presentation.ts:149-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L149-L163)）
- 事件读取文本把目标事件以 json 代码块整体序列化输出，并按序号把邻域事件分成 Before 与 After 两段（[packages/session-query/tool-session-query/src/presentation.ts:165-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L165-L188)）
- 邻域事件只给序号、类型、时间与抽取出的语义文本，无文本时写 `(no semantic text)`，多行文本按两空格缩进（[packages/session-query/tool-session-query/src/presentation.ts:190-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L190-L194)）
- 可用性文本由 live/persisted 两个标志拼成，都为假时写 `unavailable`；空序号列表写 `none`；时间一律渲染为 ISO 串（[packages/session-query/tool-session-query/src/presentation.ts:196-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L196-L209)）
- 两个检索工具的调用卡片是 search 类，原始输入只放查询串（[packages/session-query/tool-session-query/src/presentation.ts:211-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L211-L217)）
- 谱系与事件卡片是 read 类，标题随是否给了 `session_id` 变化，原始输入只带模型显式给出的字段（[packages/session-query/tool-session-query/src/presentation.ts:219-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/presentation.ts#L219-L241)）

### packages/session-query/tool-session-query/src/service-boundary.ts

会话查询服务调用的包装层，负责保留取消语义并把服务错误翻译成模型可见的安全错误。

- 用一张固定表把每个服务错误码映射到模型可见的码与措辞，其中 `SESSION_QUERY_INVALID_CONFIG` 与 `SESSION_QUERY_SOURCE_CONFLICT` 被折叠为通用的 `SESSION_QUERY_TOOL_FAILED`（[packages/session-query/tool-session-query/src/service-boundary.ts:19-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/service-boundary.ts#L19-L90)）
- 越权目标固定生成带 `SESSION_QUERY_TOOL_UNAUTHORIZED` 码的错误，消息不含目标信息（[packages/session-query/tool-session-query/src/service-boundary.ts:92-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/service-boundary.ts#L92-L97)）
- 每次服务调用前后各检查一次中止信号：调用方取消原样抛出，其余失败进入净化（[packages/session-query/tool-session-query/src/service-boundary.ts:99-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/service-boundary.ts#L99-L114)）
- 净化时把完整错误链写进内部日志，再按映射表返回安全错误；越权错误原样保留；净化过程本身出错则退回通用失败（[packages/session-query/tool-session-query/src/service-boundary.ts:116-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/service-boundary.ts#L116-L148)）
- 诊断文本沿 `Error.cause` 链逐层拼接堆栈并用已见集合防环，渲染失败时退回固定占位串（[packages/session-query/tool-session-query/src/service-boundary.ts:150-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/service-boundary.ts#L150-L172)）

### packages/session-query/tool-session-query/src/workspace-access.ts

调用方身份识别、工作区授权、标题读取与可见谱系投影模块，被五个操作与渲染模块共用。

- 调用方身份取自 `exec.agent` 的会话 id、会话头与事件列表；没有绑定 Agent 时抛 `SESSION_QUERY_TOOL_MISSING_AGENT`（[packages/session-query/tool-session-query/src/workspace-access.ts:54-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L54-L67)）
- 模型省略 `session_id` 时目标默认取调用方会话（[packages/session-query/tool-session-query/src/workspace-access.ts:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L69-L71)）
- 目标授权：自身直接放行；调用方无 `cwd` 一律拒绝；否则用 id 加 cwd 两个过滤器查服务，返回行数不等于 1 即拒绝（[packages/session-query/tool-session-query/src/workspace-access.ts:73-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L73-L88)）
- 授权判据是会话头 `cwd` 的精确字符串相等，调用方无 `cwd` 时只能访问自身（[packages/session-query/tool-session-query/src/workspace-access.ts:90-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L90-L97)）
- 拿到结果后再用观测到的会话头复核 id 与工作区，不符即抛越权（[packages/session-query/tool-session-query/src/workspace-access.ts:99-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L99-L107)）
- 批量授权先去重、单独放行调用方自身，其余 id 一次查服务，只保留既被请求又通过工作区校验的（[packages/session-query/tool-session-query/src/workspace-access.ts:109-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L109-L133)）
- 批量读标题：被拒的项转成不可用标题，成功的项先复核观测到的会话头授权，缺标题时回落为 `untitled`（[packages/session-query/tool-session-query/src/workspace-access.ts:135-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L135-L153)）
- 单条标题读取复用批量路径（[packages/session-query/tool-session-query/src/workspace-access.ts:155-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L155-L162)）
- 标题读取失败先经服务边界净化：净化结果是越权则直接抛出，否则只记下错误码（[packages/session-query/tool-session-query/src/workspace-access.ts:164-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L164-L171)）
- 后代树用显式栈迭代投影，未授权节点整棵子树替换为 `null`，不保留其 id 与子节点（[packages/session-query/tool-session-query/src/workspace-access.ts:173-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L173-L203)）
- 遍历生成器按前序产出节点与深度，遇到 `null` 不再下探（[packages/session-query/tool-session-query/src/workspace-access.ts:205-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L205-L225)）
- 可见后代 id 从遍历结果中收集，跳过被遮蔽的子树（[packages/session-query/tool-session-query/src/workspace-access.ts:227-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L227-L233)）
- 标题不可用时在文本后追加 `(title unavailable: <码>)`（[packages/session-query/tool-session-query/src/workspace-access.ts:235-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/tool-session-query/src/workspace-access.ts#L235-L239)）

### packages/session-query/tool-session-query/tsconfig.json

包的 TypeScript 编译配置，声明源目录、输出目录与工作区项目引用。

- 无运行期机制
