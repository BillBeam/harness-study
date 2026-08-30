---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/web/web-search-deepseek
---

# packages/web/web-search-deepseek

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、47 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/web/web-search-deepseek/README.md

该包的参考文档，说明这个搜索 provider 如何挂载、配置字段、返回内容与失败码。

- 无运行期机制

### packages/web/web-search-deepseek/package.json

该包的 npm 清单，决定包名、入口解析与发布内容。

- `type: module` 与 `main`/`types` 指定 ESM 加载与默认入口 `lib/index.js`（[packages/web/web-search-deepseek/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/package.json#L13-L15)）
- `exports` 暴露主入口、`./invariant` 子路径、原始 `./src/*` 与 `./package.json`（[packages/web/web-search-deepseek/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/web/web-search-deepseek/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/package.json#L28-L32)）

### packages/web/web-search-deepseek/src/index.ts

插件入口，声明配置模式、安装设置分区，并把按次投影配置的搜索 provider 注册进 `ctx.web`。

- `inject = ['web']` 声明该插件在 web 服务就绪后才装载（[packages/web/web-search-deepseek/src/index.ts:41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L41)）
- Config schema 把 `apiKey` 标为 secret、`apiKeyEnv` 标为 credential-ref 并默认 `DEEPSEEK_API_KEY`，并给模型名、API 版本、`maxTokens`、`maxUses` 填默认值与正整数约束（[packages/web/web-search-deepseek/src/index.ts:63-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L63-L74)）
- `SEARCH_BASE_URL_ENV` 把端点环境变量固定为 `DEEPSEEK_SEARCH_BASE_URL`（[packages/web/web-search-deepseek/src/index.ts:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L82)）
- `WEB_SEARCH_DEEPSEEK_SETTINGS_NAMESPACE` 定义该 provider 的设置命名空间（[packages/web/web-search-deepseek/src/index.ts:85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L85)）
- `resolveOptions` 只在字面 `apiKey` 非空时把它放进选项，否则交给 `resolveApiKey`（[packages/web/web-search-deepseek/src/index.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L96-L101)）
- `resolveApiKey` 优先通过 `ctx.get('credentials')` 解析凭据引用，服务缺席时回落到启动环境变量（[packages/web/web-search-deepseek/src/index.ts:102-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L102-L108)）
- `baseURL` 依次取配置、`$DEEPSEEK_SEARCH_BASE_URL`、内置默认端点（[packages/web/web-search-deepseek/src/index.ts:110-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L110-L112)）
- 模型名、API 版本、`maxTokens`、`maxUses` 在此补齐常量默认值（[packages/web/web-search-deepseek/src/index.ts:113-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L113-L116)）
- `recordRequest` 把请求记录追加为当前发起方会话的 `web/deepseek-search-llm-request` 事件；无发起方时不写（[packages/web/web-search-deepseek/src/index.ts:117-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L117-L122)）
- `apply` 安装设置分区并用 `setSource` 换掉读取当前配置的闭包，`onChange` 为空所以变更不触发重注册（[packages/web/web-search-deepseek/src/index.ts:128-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L128-L136)）
- `apply` 以「每次调用重新投影配置」的 thunk 构造 provider 并注册进 `ctx.web`（[packages/web/web-search-deepseek/src/index.ts:137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/index.ts#L137)）

### packages/web/web-search-deepseek/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名。

- `inject = ['invariants']` 要求 invariants 服务先就绪（[packages/web/web-search-deepseek/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/invariant.ts#L15)）
- `install` 为空实现，不安装任何运行期检查（[packages/web/web-search-deepseek/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/invariant.ts#L22)）
- `apply` 调用 `ctx.invariants.register` 以包名注册并返回 disposer（[packages/web/web-search-deepseek/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/invariant.ts#L29-L30)）

### packages/web/web-search-deepseek/src/provider.ts

`DeepSeekSearchProvider` 的实现：发一次 Anthropic 兼容 Messages 请求并把结构化搜索块映射成统一的搜索结果。

- `DEEPSEEK_PROVIDER_ID` 固定为 `'deepseek-official'`，即注册用的 provider id（[packages/web/web-search-deepseek/src/provider.ts:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L27)）
- 默认端点、模型名、API 版本、`maxTokens`、`maxUses` 在此定义为常量（[packages/web/web-search-deepseek/src/provider.ts:35-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L35-L47)）
- `USER_AGENT` 定义每次请求发出的 `user-agent` 值（[packages/web/web-search-deepseek/src/provider.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L50)）
- 通过声明合并把 `web/deepseek-search-llm-request` 加入 `SessionEventMap` 的会话事件词表（[packages/web/web-search-deepseek/src/provider.ts:80-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L80-L85)）
- `citationSnippets` 遍历 `text` 块的 `citations[]`，按 URL 建立首次出现优先的摘录映射（[packages/web/web-search-deepseek/src/provider.ts:121-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L121-L132)）
- `mapAnthropicResponse` 只保留 `web_search_tool_result` 块（[packages/web/web-search-deepseek/src/provider.ts:146-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L146-L149)）
- 一个这样的块都没有时抛 `WEB_PROVIDER_ERROR` 而不退化为从文本里刮取（[packages/web/web-search-deepseek/src/provider.ts:150-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L150-L155)）
- 结果项按 URL 去重，跳过非 `web_search_result` 与空 URL，并把标题、摘录、`page_age` 分别映射为可选的 `title`/`snippet`/`publishedAt`（[packages/web/web-search-deepseek/src/provider.ts:157-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L157-L172)）
- 返回值恒置 `truncated: false`，把结果条数上限留给服务层（[packages/web/web-search-deepseek/src/provider.ts:173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L173)）
- `available()` 要求存在密钥或解析器、`baseURL` 可解析、`maxTokens` 与 `maxUses` 为正整数（[packages/web/web-search-deepseek/src/provider.ts:189-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L189-L195)）
- `search()` 在入口一次性快照选项，整个操作只用这一份（[packages/web/web-search-deepseek/src/provider.ts:201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L201)）
- 端点由 `baseURL` 拼接 `/messages` 得到（[packages/web/web-search-deepseek/src/provider.ts:204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L204)）
- 请求体把用户文本固定成 `Perform a web search for the query: <query>`，并带一个 `web_search_20250305` 服务端工具与 `max_uses`（[packages/web/web-search-deepseek/src/provider.ts:205-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L205-L213)）
- 派发前调用 `recordRequest` 记录端点、API 版本与完整无密钥请求体（[packages/web/web-search-deepseek/src/provider.ts:214-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L214-L218)）
- 凭据解析返回后先做一次中止检查再拼请求（[packages/web/web-search-deepseek/src/provider.ts:203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L203)）
- 记录请求之后、发出网络请求之前再做一次中止检查（[packages/web/web-search-deepseek/src/provider.ts:219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L219)）
- 以 `redirect: 'error'` 发 POST，并同时带上 `x-api-key` 与 `Authorization: Bearer` 两种凭据头及 `anthropic-version`（[packages/web/web-search-deepseek/src/provider.ts:222-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L222-L237)）
- 传输异常按中止与否分成 `WEB_ABORTED` 与 `WEB_PROVIDER_ERROR`（[packages/web/web-search-deepseek/src/provider.ts:238-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L238-L241)）
- 非 2xx 时先用 HTTP 状态拼消息，再尝试从错误体里取更具体的文案；解析途中若已中止则改抛 `WEB_ABORTED`（[packages/web/web-search-deepseek/src/provider.ts:243-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L243-L260)）
- 成功响应解析为 JSON 后交给 `mapAnthropicResponse`，解析失败按中止、`WebError`、其他三类分流（[packages/web/web-search-deepseek/src/provider.ts:262-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L262-L269)）
- `apiKey()` 中字面密钥优先于解析器（[packages/web/web-search-deepseek/src/provider.ts:279-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L279-L280)）
- 凭据解析与调用方取消竞速，解析抛错时归为 `WEB_PROVIDER_ERROR`（[packages/web/web-search-deepseek/src/provider.ts:281-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L281-L291)）
- 解析不出密钥时抛 `WEB_PROVIDER_CREDENTIAL_MISSING`，消息里点名凭据引用与三条可行来源（[packages/web/web-search-deepseek/src/provider.ts:292-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L292-L300)）
- `abortable` 在信号中止时立刻拒绝，同时继续挂着结算回调以免后到的拒绝变成未处理（[packages/web/web-search-deepseek/src/provider.ts:308-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L308-L325)）
- `throwIfSearchAborted` 与 `searchAborted` 统一生成携带调用方 reason 的 `WEB_ABORTED` 错误（[packages/web/web-search-deepseek/src/provider.ts:328-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L328-L337)）
- `isAbortError` 只把名为 `AbortError` 的 `DOMException` 认作中止（[packages/web/web-search-deepseek/src/provider.ts:340-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L340-L342)）
- `isPositiveInteger` 判定可发往 Messages API 的正整数限额（[packages/web/web-search-deepseek/src/provider.ts:345-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-deepseek/src/provider.ts#L345-L347)）

### packages/web/web-search-deepseek/src/types.ts

Anthropic 兼容响应的私有线格式类型声明，供 provider 解析用。

- 无运行期机制

### packages/web/web-search-deepseek/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工程引用。

- 无运行期机制
