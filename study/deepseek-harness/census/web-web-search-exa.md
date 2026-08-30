---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/web/web-search-exa
---

# packages/web/web-search-exa

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、29 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/web/web-search-exa/README.md

该包的参考文档，说明这个搜索 provider 如何挂载、配置字段、返回内容与失败码。

- 无运行期机制

### packages/web/web-search-exa/package.json

该包的 npm 清单，决定包名、入口解析与发布内容。

- `type: module` 与 `main`/`types` 指定 ESM 加载与默认入口 `lib/index.js`（[packages/web/web-search-exa/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/package.json#L13-L15)）
- `exports` 暴露主入口、`./invariant` 子路径、原始 `./src/*` 与 `./package.json`（[packages/web/web-search-exa/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/web/web-search-exa/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/package.json#L28-L32)）

### packages/web/web-search-exa/src/index.ts

插件入口，声明配置模式并把 Exa 搜索 provider 注册进 `ctx.web`。

- `inject = ['web']` 声明该插件在 web 服务就绪后才装载（[packages/web/web-search-exa/src/index.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/index.ts#L32)）
- Config schema 把 `searchType` 限定在 `auto`/`keyword`/`neural`，并要求 `numResults` 与 `highlightsPerResult` 为不小于 1 的整数（[packages/web/web-search-exa/src/index.ts:48-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/index.ts#L48-L54)）
- `apply` 构造 `ExaSearchProvider` 并调用 `ctx.web.registerSearchProvider` 注册（[packages/web/web-search-exa/src/index.ts:57-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/index.ts#L57-L58)）
- `apply` 在配置未给密钥时回落到启动环境的 `EXA_API_KEY`，再回落到空串（[packages/web/web-search-exa/src/index.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/index.ts#L61)）
- `apply` 为端点、检索模式、每条高亮数补齐常量默认值，并只在配置给了 `numResults` 时才带上该字段（[packages/web/web-search-exa/src/index.ts:62-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/index.ts#L62-L65)）

### packages/web/web-search-exa/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名。

- `inject = ['invariants']` 要求 invariants 服务先就绪（[packages/web/web-search-exa/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/invariant.ts#L15)）
- `install` 为空实现，不安装任何运行期检查（[packages/web/web-search-exa/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register` 以包名注册并返回 disposer（[packages/web/web-search-exa/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/invariant.ts#L28-L29)）

### packages/web/web-search-exa/src/provider.ts

`ExaSearchProvider` 的实现：向 Exa 的 `POST /search` 发查询并把结果映射成统一的搜索结果。

- `EXA_PROVIDER_ID` 固定为 `'exa'`，即注册用的 provider id（[packages/web/web-search-exa/src/provider.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L19)）
- 默认端点、默认检索模式 `auto`、默认每条高亮数 1 在此定义为常量（[packages/web/web-search-exa/src/provider.ts:22-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L22-L28)）
- `USER_AGENT` 定义每次请求发出的 `user-agent` 值（[packages/web/web-search-exa/src/provider.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L31)）
- `mapExaResult` 取首个非空白高亮作 `snippet`，没有高亮则返回 `undefined` 使该条被丢弃（[packages/web/web-search-exa/src/provider.ts:56-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L56-L58)）
- 标题与 `publishedDate` 只在非空时写入 `title` 与 `publishedAt`（[packages/web/web-search-exa/src/provider.ts:59-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L59-L64)）
- `mapExaResponse` 过滤掉无摘录的条目，省略 `content`，并恒置 `truncated: false`（[packages/web/web-search-exa/src/provider.ts:74-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L74-L81)）
- `available()` 要求密钥非空、`baseURL` 可解析、每条高亮数为正整数、`numResults` 若给出也须为正整数（[packages/web/web-search-exa/src/provider.ts:89-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L89-L94)）
- 请求级 `maxResults` 优先于配置里的 `numResults`（[packages/web/web-search-exa/src/provider.ts:98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L98)）
- 以 `redirect: 'error'` 向 `{baseURL}/search` 发 POST，带 Bearer 凭据头，体内含查询、检索模式、高亮请求与可选结果数（[packages/web/web-search-exa/src/provider.ts:101-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L101-L117)）
- 传输异常按是否为 `AbortError` 分成 `WEB_ABORTED` 与 `WEB_PROVIDER_ERROR`（[packages/web/web-search-exa/src/provider.ts:118-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L118-L121)）
- 非 2xx 时先用 HTTP 状态拼消息，再尝试从错误体取更具体文案；解析途中的中止改抛 `WEB_ABORTED`（[packages/web/web-search-exa/src/provider.ts:123-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L123-L140)）
- 成功响应解析为 JSON 后交给 `mapExaResponse`，解析失败按中止与否分成 `WEB_ABORTED` 与 `WEB_PROVIDER_ERROR`（[packages/web/web-search-exa/src/provider.ts:142-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L142-L148)）
- `isValidBaseUrl` 用 `URL.canParse` 做本地配置检查（[packages/web/web-search-exa/src/provider.ts:153-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L153-L155)）
- `isPositiveInteger` 判定可发往 Exa 的正整数限额（[packages/web/web-search-exa/src/provider.ts:158-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L158-L160)）
- `isAbortError` 只把名为 `AbortError` 的 `DOMException` 认作中止（[packages/web/web-search-exa/src/provider.ts:163-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-search-exa/src/provider.ts#L163-L165)）

### packages/web/web-search-exa/src/types.ts

Exa 搜索 API 的私有线格式类型声明，供 provider 解析用。

- 无运行期机制

### packages/web/web-search-exa/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工程引用。

- 无运行期机制
