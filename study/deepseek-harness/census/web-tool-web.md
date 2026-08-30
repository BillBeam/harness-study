---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/web/tool-web
---

# packages/web/tool-web

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、66 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/web/tool-web/README.md

该包的参考文档，说明两个面向模型的 web 工具的启用方式、配置字段、失败路径与模型可见文本。

- 无运行期机制

### packages/web/tool-web/package.json

该包的清单，声明入口、导出映射、随包文件与对等/运行期依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/web/tool-web/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/package.json#L14-L15)）
- `exports` 除主入口外单独开放 `./invariant` 子入口（[packages/web/tool-web/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/package.json#L16-L27)）
- `files` 限定发布内容为主入口、invariant 入口与类型声明（[packages/web/tool-web/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/package.json#L28-L32)）
- 运行期依赖 `@joplin/turndown-plugin-gfm`、`turndown` 与工作区 schema 库（[packages/web/tool-web/package.json:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/package.json#L42-L46)）

### packages/web/tool-web/src/fetch.ts

`web_fetch` 工具的全部实现：HTML 过滤与转 markdown、深度与字符上限、输出格式化、结果元数据与工具注册。

- 构造共享的 turndown 实例，固定标题/代码块/列表标记风格并装载 GFM 插件（[packages/web/tool-web/src/fetch.ts:26-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L26-L31)）
- 新增规则整块丢弃脚本/样式/内联框架等元素、带 `hidden` 或 `aria-hidden` 的节点、隐藏 input，以及内联样式为 `display:none`/`visibility:hidden|collapse` 的节点（[packages/web/tool-web/src/fetch.ts:32-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L32-L50)）
- 表格单元格渲染把换行换成 `<br>`、转义竖线并补齐到三字符宽（[packages/web/tool-web/src/fetch.ts:53-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L53-L57)）
- 判定表头行的条件是位于 `THEAD` 或为首行且全部单元格为 `TH`（[packages/web/tool-web/src/fetch.ts:60-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L60-L66)）
- 单元格对齐属性映射为 GFM 分隔行的 `:---`/`---:`/`:---:`/`---`（[packages/web/tool-web/src/fetch.ts:69-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L69-L75)）
- 单元格规则按节点在父行中的下标输出而忽略 `colspan`，行规则在表头行后追加分隔行（[packages/web/tool-web/src/fetch.ts:77-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L77-L96)）
- `parseFetchArgs` 拒绝空白 `url` 并抛出 `url must be a non-empty string`（[packages/web/tool-web/src/fetch.ts:107-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L107-L110)）
- 转换深度上限固定为 512（[packages/web/tool-web/src/fetch.ts:121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L121)）
- 空元素集合与原始文本元素集合决定词法栈如何增长与跳过（[packages/web/tool-web/src/fetch.ts:124-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L124-L130)）
- `findRawTextEnd` 只在标签名后跟合法边界字符时才认作结束标签（[packages/web/tool-web/src/fetch.ts:133-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L133-L145)）
- `exceedsConversionDepth` 单趟扫描维护开标签栈：跳过注释与原始文本体、识别引号内的 `>`、只在栈顶匹配时出栈，越界立即返回 true（[packages/web/tool-web/src/fetch.ts:157-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L157-L224)）
- `renderBody` 先按 `maxInputChars` 截断源文本并记录是否被截；HTML 超深或 turndown 抛错时输出固定的省略标记而非原始标记，text 原样透传，未知 kind 走 `assertNever`（[packages/web/tool-web/src/fetch.ts:243-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L243-L263)）
- 截断时追加的固定脚注文本（[packages/web/tool-web/src/fetch.ts:266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L266)）
- `renderFetchOutput` 按 `(result, maxOutputChars)` 查缓存，未命中才做一次转换并写回（[packages/web/tool-web/src/fetch.ts:303-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L303-L311)）
- 缓存是以结果对象为键的 `WeakMap`，内层再按输出上限分档（[packages/web/tool-web/src/fetch.ts:319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L319)）
- `computeFetchOutput` 拼出 `Fetched <url> (HTTP <status>)` 抬头加外部内容提示，把提供方截断、源截断与超长三者合成为有效截断标志，并在整体超限时保留脚注地切掉正文（[packages/web/tool-web/src/fetch.ts:329-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L329-L338)）
- `formatFetchOutput` 作为工具 render 的文本来源（[packages/web/tool-web/src/fetch.ts:347-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L347-L349)）
- `presentFetchCall` 用 URL 作标题产出待执行状态的通用卡片（[packages/web/tool-web/src/fetch.ts:357-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L357-L359)）
- `fetchMetaFromValue` 把最终 URL、状态码与有效截断标志投影成随结果持久化的展示元数据（[packages/web/tool-web/src/fetch.ts:393-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L393-L395)）
- `fetchMetaFromResult` 对回放来的不透明元数据逐字段做类型校验，不合法返回 `undefined`（[packages/web/tool-web/src/fetch.ts:405-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L405-L410)）
- `presentFetchResult` 在错误结果或元数据不合法时返回 `undefined` 退回通用卡片，否则产出 `web` 取回卡片（[packages/web/tool-web/src/fetch.ts:424-436](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L424-L436)）
- `applyWebFetchTool` 以固定次序注册一段 `tool:web_fetch` 系统提示，文本声明返回内容是外部不可信数据并要求引用链接（[packages/web/tool-web/src/fetch.ts:449-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L449-L453)）
- 工具以 `web_fetch` 名注册，模型可见参数只有必填 `url`（[packages/web/tool-web/src/fetch.ts:455-460](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L455-L460)）
- 输出 schema 固定 `url`/`statusCode`/`body`(html|text 二选一)/`truncated` 且禁止额外属性（[packages/web/tool-web/src/fetch.ts:461-491](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L461-L491)）
- `render` 与 `presentationMeta` 都传入部署配置的输出上限（[packages/web/tool-web/src/fetch.ts:492-493](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L492-L493)）
- 工具定义带上 `timeoutMs` 供超时策略执行，并声明并发安全（[packages/web/tool-web/src/fetch.ts:495-497](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L495-L497)）
- `execute` 校验参数后调用 `ctx.web.fetch` 并转发 `exec.signal`，把结果重新拼成规范输出值（[packages/web/tool-web/src/fetch.ts:498-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L498-L510)）
- 注册呼叫态与结果态的展示函数（[packages/web/tool-web/src/fetch.ts:511-512](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/fetch.ts#L511-L512)）

### packages/web/tool-web/src/index.ts

包的插件入口：声明依赖服务、配置 schema 与默认值，并按启用开关注册两个工具。

- 重新导出搜索与取回两侧的格式化、展示与元数据函数（[packages/web/tool-web/src/index.ts:15-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/index.ts#L15-L18)）
- 插件名固定为 `tool-web`，并声明注入 `tools`、`web`、`systemPrompt` 三个服务（[packages/web/tool-web/src/index.ts:21-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/index.ts#L21-L24)）
- 默认工具超时预算 30000 毫秒（[packages/web/tool-web/src/index.ts:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/index.ts#L27)）
- 默认取回输出与同步转换字符上限 200000（[packages/web/tool-web/src/index.ts:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/index.ts#L34)）
- 配置 schema 给七个字段各自填默认值：两个启用开关默认 true，两个上限取常量，两个超时取 30000，输出上限取 200000（[packages/web/tool-web/src/index.ts:54-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/index.ts#L54-L62)）
- `assertPositiveInteger` 对非正整数配置在加载时抛错（[packages/web/tool-web/src/index.ts:68-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/index.ts#L68-L72)）
- `apply` 先校验五个数值配置，再按 `search`/`fetch` 开关分别注册工具，并把 `fetch` 的启用状态作为搜索提示分支的输入传下去（[packages/web/tool-web/src/index.ts:83-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/index.ts#L83-L95)）

### packages/web/tool-web/src/invariant.ts

该包的不变量伴生插件，在不变量服务里登记包名并显式声明本包无运行期不变量。

- `apply` 向 `ctx.invariants` 注册包名与一个空安装器，并返回其 disposer（[packages/web/tool-web/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/invariant.ts#L21-L29)）
- 伴生插件名为 `tool-web-invariant`，声明注入 `invariants`（[packages/web/tool-web/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/invariant.ts#L13-L15)）

### packages/web/tool-web/src/search.ts

`web_search` 工具的全部实现：参数校验、多查询并发与合并、结果文本格式化、展示元数据与工具注册。

- 默认结果条数上限 8（[packages/web/tool-web/src/search.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L19)）
- 默认单次调用查询条数上限 4（[packages/web/tool-web/src/search.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L22)）
- `parseSearchArgs` 依次拒绝空数组、超过上限（错误文案按上限单复数切换）与空白查询，再按首次出现顺序去重（[packages/web/tool-web/src/search.ts:39-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L39-L51)）
- 来源标签优先取标题，否则取 URL 主机名，URL 非法时退回原字符串（[packages/web/tool-web/src/search.ts:54-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L54-L63)）
- `formatSearchOutput` 以外部不可信内容提示开头，接提供方答案、`Sources:` 列表（含摘要与日期后缀），无结果时输出 `No results found.`，截断时加提示，末尾固定加引用要求（[packages/web/tool-web/src/search.ts:73-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L73-L94)）
- `presentSearchCall` 用逗号连接的查询串作标题产出待执行卡片（[packages/web/tool-web/src/search.ts:102-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L102-L105)）
- `projectSource` 只保留存在的可选字段，使执行输出与展示元数据的来源结构逐字节一致（[packages/web/tool-web/src/search.ts:132-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L132-L144)）
- `searchMetaFromValue` 把结构化来源、截断标志与可选答案投影成随结果持久化的元数据（[packages/web/tool-web/src/search.ts:153-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L153-L159)）
- `isWebSource` 与 `searchMetaFromResult` 对回放元数据逐项校验，不合法返回 `undefined`（[packages/web/tool-web/src/search.ts:162-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L162-L190)）
- `presentSearchResult` 在错误结果或元数据不合法时返回 `undefined`，否则产出带结构化来源的 `web` 搜索卡片（[packages/web/tool-web/src/search.ts:204-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L204-L216)）
- 单条查询直接透传 `ctx.web.search` 的原结果，不走合并（[packages/web/tool-web/src/search.ts:237-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L237-L239)）
- 多条查询用 `AbortSignal.any` 把外部信号与内部控制器融合，任一失败即中止兄弟查询、记录首个失败（[packages/web/tool-web/src/search.ts:240-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L240-L252)）
- 等到全部查询 settle 后才抛出首个失败，否则进入合并（[packages/web/tool-web/src/search.ts:253-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L253-L255)）
- `mergeSearchResults` 按名次轮转取各查询的来源、以 URL 去重、到达上限即停止并置 `droppedSource`（[packages/web/tool-web/src/search.ts:259-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L259-L283)）
- 各查询的答案文本以 `### <查询>` 标题拼接，合并结果的 `truncated` 取各分支或本次丢弃的并（[packages/web/tool-web/src/search.ts:284-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L284-L292)）
- `applyWebSearchTool` 注册 `tool:web_search` 系统提示，并按同一组合是否启用 fetch 在两段文本间二选一，文本内嵌入生效的查询上限（[packages/web/tool-web/src/search.ts:315-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L315-L321)）
- 工具以 `web_search` 名注册，描述与参数描述里都嵌入查询上限，必填参数是字符串数组 `queries`（[packages/web/tool-web/src/search.ts:323-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L323-L333)）
- 输出 schema 固定可选 `content`、必填 `sources` 数组与 `truncated` 且禁止额外属性（[packages/web/tool-web/src/search.ts:334-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L334-L356)）
- `render`/`presentationMeta` 分别产出模型可见文本与展示元数据，工具带 `timeoutMs` 并声明并发安全（[packages/web/tool-web/src/search.ts:357-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L357-L362)）
- `execute` 先校验查询再执行扇出，把结果规范化为 `content`/`sources`/`truncated`（[packages/web/tool-web/src/search.ts:363-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L363-L371)）
- 注册呼叫态与结果态的展示函数（[packages/web/tool-web/src/search.ts:372-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/search.ts#L372-L373)）

### packages/web/tool-web/src/trust.ts

一行常量模块，存放两个 web 工具共用的外部内容标注文本。

- 导出被搜索与取回结果都前置到模型可见文本里的不可信内容提示（[packages/web/tool-web/src/trust.ts:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/tool-web/src/trust.ts#L7)）

### packages/web/tool-web/src/turndown-plugin-gfm.d.ts

为无类型的 GFM 转换插件补充的环境模块声明。

- 无运行期机制

### packages/web/tool-web/tsconfig.json

该包的 TypeScript 编译配置，指定源码与声明输出目录并引用各工作区依赖。

- 无运行期机制
