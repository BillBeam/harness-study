---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/web/web-search-perplexity
---

# packages/web/web-search-perplexity

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、29 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/web/web-search-perplexity/README.md

该包的参考文档，说明这个搜索 provider 如何挂载、配置字段、返回内容与失败码。

- 无运行期机制

### packages/web/web-search-perplexity/package.json

该包的 npm 清单，决定包名、入口解析与发布内容。

- `type: module` 与 `main`/`types` 指定 ESM 加载与默认入口 `lib/index.js`（[packages/web/web-search-perplexity/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/package.json#L13-L15)）
- `exports` 暴露主入口、`./invariant` 子路径、原始 `./src/*` 与 `./package.json`（[packages/web/web-search-perplexity/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/web/web-search-perplexity/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/package.json#L28-L32)）

### packages/web/web-search-perplexity/src/index.ts

插件入口，声明配置模式并把 Perplexity 搜索 provider 注册进 `ctx.web`。

- `inject = ['web']` 声明该插件在 web 服务就绪后才装载（[packages/web/web-search-perplexity/src/index.ts:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/index.ts#L27)）
- Config schema 要求 `maxTokens` 为不小于 1 的整数，并把 `searchRecency` 限定在 `day`/`week`/`month`/`year`（[packages/web/web-search-perplexity/src/index.ts:43-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/index.ts#L43-L49)）
- `apply` 构造 `PerplexitySearchProvider` 并调用 `ctx.web.registerSearchProvider` 注册（[packages/web/web-search-perplexity/src/index.ts:52-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/index.ts#L52-L53)）
- `apply` 在配置未给密钥时回落到启动环境的 `PERPLEXITY_API_KEY`，再回落到空串（[packages/web/web-search-perplexity/src/index.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/index.ts#L56)）
- `apply` 为端点、模型名、`maxTokens` 补齐常量默认值，并只在配置给了 `searchRecency` 时才带上该字段（[packages/web/web-search-perplexity/src/index.ts:57-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/index.ts#L57-L60)）

### packages/web/web-search-perplexity/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名。

- `inject = ['invariants']` 要求 invariants 服务先就绪（[packages/web/web-search-perplexity/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/invariant.ts#L15)）
- `install` 为空实现，不安装任何运行期检查（[packages/web/web-search-perplexity/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register` 以包名注册并返回 disposer（[packages/web/web-search-perplexity/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/invariant.ts#L28-L29)）

### packages/web/web-search-perplexity/src/provider.ts

`PerplexitySearchProvider` 的实现：向 chat-completions 端点发查询，把生成的回答与引用映射成统一的搜索结果。

- `PERPLEXITY_PROVIDER_ID` 固定为 `'perplexity'`，即注册用的 provider id（[packages/web/web-search-perplexity/src/provider.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L19)）
- 默认端点、默认模型 `sonar`、默认 `maxTokens` 1024 在此定义为常量（[packages/web/web-search-perplexity/src/provider.ts:22-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L22-L28)）
- `USER_AGENT` 定义每次请求发出的 `user-agent` 值（[packages/web/web-search-perplexity/src/provider.ts:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L34)）
- `mapPerplexityResult` 只在非空时写入 `title`、`snippet` 与由 `date` 映射的 `publishedAt`（[packages/web/web-search-perplexity/src/provider.ts:56-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L56-L63)）
- `mapPerplexityResponse` 取首个 choice 的消息文本作生成回答（[packages/web/web-search-perplexity/src/provider.ts:74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L74)）
- 有 `search_results[]` 时按结构化字段映射，缺席时才退回把 `citations[]` 逐条变成只有 URL 的来源（[packages/web/web-search-perplexity/src/provider.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L75-L77)）
- 回答为空时整个 `content` 字段被省略（[packages/web/web-search-perplexity/src/provider.ts:79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L79)）
- 返回值恒置 `truncated: false`，把结果条数上限留给服务层（[packages/web/web-search-perplexity/src/provider.ts:81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L81)）
- `available()` 要求密钥非空、`baseURL` 可解析、`maxTokens` 为正整数（[packages/web/web-search-perplexity/src/provider.ts:94-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L94-L98)）
- 以 `redirect: 'error'` 向 `{baseURL}/chat/completions` 发 POST，带 Bearer 凭据头，体内把查询原样作为单条 user 消息，并按需带上 `search_recency_filter`（[packages/web/web-search-perplexity/src/provider.ts:104-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L104-L120)）
- 传输异常按是否为 `AbortError` 分成 `WEB_ABORTED` 与 `WEB_PROVIDER_ERROR`（[packages/web/web-search-perplexity/src/provider.ts:121-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L121-L124)）
- 非 2xx 时先用 HTTP 状态拼消息，再尝试从错误体取更具体文案；解析途中的中止改抛 `WEB_ABORTED`（[packages/web/web-search-perplexity/src/provider.ts:126-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L126-L143)）
- 成功响应解析为 JSON 后交给 `mapPerplexityResponse`，解析失败按中止与否分成 `WEB_ABORTED` 与 `WEB_PROVIDER_ERROR`（[packages/web/web-search-perplexity/src/provider.ts:145-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L145-L151)）
- `isAbortError` 只把名为 `AbortError` 的 `DOMException` 认作中止（[packages/web/web-search-perplexity/src/provider.ts:159-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L159-L161)）
- `isPositiveInteger` 判定可发往 Perplexity 的正整数限额（[packages/web/web-search-perplexity/src/provider.ts:164-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-perplexity/src/provider.ts#L164-L166)）

### packages/web/web-search-perplexity/src/types.ts

Perplexity chat-completions 响应的私有线格式类型声明，供 provider 解析用。

- 无运行期机制

### packages/web/web-search-perplexity/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工程引用。

- 无运行期机制
