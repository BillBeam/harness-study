---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/webhook/webhook-github
---

# packages/webhook/webhook-github

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、30 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/webhook/webhook-github/README.md

包 README，说明这个 GitHub 适配器在注入的 WebServer 上注册一条精确路由，验签后把事件投给 webhook 运行时。

- 记载配置四项（source、path、secretEnv、maxBodyBytes）全为必填，且密钥引用按请求解析、轮换在下一次投递生效（[packages/webhook/webhook-github/README.md:28-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/README.md#L28-L35)）
- 记载只接受 `POST application/json`，要求三个头，先验 HMAC 再解析 JSON，且不记录密钥、签名或负载（[packages/webhook/webhook-github/README.md:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/README.md#L38-L40)）
- 记载外部可观察的状态码表 202/400/401/405/413/415/503 及其含义，且 202 不表示任何规则匹配或 Session 已建（[packages/webhook/webhook-github/README.md:42-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/README.md#L42-L52)）

### packages/webhook/webhook-github/package.json

npm 清单，声明入口、导出、发布文件集与对 octokit/webhooks 等的依赖。

- `main`/`types`/`exports` 把 `.`、`./types`、`./invariant`、`./src/*` 映射到具体产物文件（[packages/webhook/webhook-github/package.json:14-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/package.json#L14-L31)）
- `files` 限定发布产物只含 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 js/d.ts（[packages/webhook/webhook-github/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/package.json#L32-L37)）
- `dependencies` 引入 `@octokit/webhooks` 作为签名校验实现（[packages/webhook/webhook-github/package.json:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/package.json#L47-L50)）

### packages/webhook/webhook-github/src/body.ts

有界原始请求体读取与 HTTP 拒绝错误类型，供 handler.ts 在验签前取得精确字节。

- `WebhookHttpError` 把状态码限定为 400/401/405/413/415/503 并携带可安全回传的文本（[packages/webhook/webhook-github/src/body.ts:6-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/body.ts#L6-L15)）
- `contentLength` 对非十进制整数的 Content-Length 回 400，对非安全整数回 413（[packages/webhook/webhook-github/src/body.ts:18-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/body.ts#L18-L27)）
- 声明长度超过上限时直接 `resume()` 丢弃流并回 413（[packages/webhook/webhook-github/src/body.ts:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/body.ts#L40-L44)）
- 边读边累加字节数，实际流超限时同样 `resume()` 并回 413（[packages/webhook/webhook-github/src/body.ts:46-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/body.ts#L46-L57)）
- 读流异常或 `request.complete` 为假时回 400「body was aborted」（[packages/webhook/webhook-github/src/body.ts:58-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/body.ts#L58-L62)）
- 以 `fatal: true` 的 UTF-8 解码，非法编码回 400（[packages/webhook/webhook-github/src/body.ts:63-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/body.ts#L63-L68)）

### packages/webhook/webhook-github/src/handler.ts

构造这条精确路由的 HTTP 处理函数：方法/媒体类型/头校验、验签、解析、投给运行时并回 202。

- `requiredHeader` 要求头恰好出现一次且非空，否则回 400（[packages/webhook/webhook-github/src/handler.ts:25-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L25-L32)）
- `isJsonContentType` 只接受 `application/json`，至多带一个 `charset=utf-8` 参数（[packages/webhook/webhook-github/src/handler.ts:35-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L35-L42)）
- `respond` 决定外部看到的响应：无消息时空响应，有消息时带 `text/plain; charset=utf-8`（[packages/webhook/webhook-github/src/handler.ts:45-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L45-L53)）
- `parsePayload` 对非法 JSON、非对象顶层、非无损 JSON 分别回 400（[packages/webhook/webhook-github/src/handler.ts:56-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L56-L70)）
- 非 POST 时设置 `allow: POST` 头并回 405，非 JSON 媒体类型回 415（[packages/webhook/webhook-github/src/handler.ts:84-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L84-L90)）
- 先读有界体，再取 `x-hub-signature-256`、`x-github-delivery`、`x-github-event` 三个头（[packages/webhook/webhook-github/src/handler.ts:91-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L91-L94)）
- 每次请求都重新解析凭据引用，缺失或空值回 503（[packages/webhook/webhook-github/src/handler.ts:95-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L95-L98)）
- 用 `Webhooks.verify` 在解析 JSON 之前校验签名，验签抛错被吞成未通过，未通过回 401（[packages/webhook/webhook-github/src/handler.ts:99-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L99-L105)）
- 组装 `kind: 'github'` 的投递，事件值为 `{ name, payload }`，`receivedAt` 取 `Date.now()`（[packages/webhook/webhook-github/src/handler.ts:106-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L106-L113)）
- 调用 `ctx.webhookRuntime.dispatch(delivery)` 后立即回 202，不等待规则结算；dispatch 抛错则记 warn 并回 503（[packages/webhook/webhook-github/src/handler.ts:114-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L114-L120)）
- 非 `WebhookHttpError` 的意外错误统一记 warn 并回 503，不外泄细节（[packages/webhook/webhook-github/src/handler.ts:121-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/handler.ts#L121-L128)）

### packages/webhook/webhook-github/src/index.ts

Cordis 函数插件入口：声明配置模式、校验路由与 source，并把处理器注册到 `ctx.webServer`。

- `inject` 要求 webServer、webhookRuntime、credentials 三个服务先就绪（[packages/webhook/webhook-github/src/index.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/index.ts#L14)）
- Schemastery 配置要求四项全必填，`secretEnv` 标记 `credential-ref` 角色，`maxBodyBytes` 为不小于 1 的整数（[packages/webhook/webhook-github/src/index.ts:28-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/index.ts#L28-L33)）
- `assertConfig` 在加载时拒绝未 trim 的 source 与非绝对、根、带尾斜杠或含 `?`/`#` 的 path（[packages/webhook/webhook-github/src/index.ts:36-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/index.ts#L36-L44)）
- `apply` 以 `kind: 'exact'` 路由注册处理器，并通过 `ctx.effect` 绑定其注销（[packages/webhook/webhook-github/src/index.ts:47-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/index.ts#L47-L62)）

### packages/webhook/webhook-github/src/invariant.ts

该包的不变式伴生插件，占位注册包名并说明为何没有运行期不变式。

- `apply` 以包名注册一个空安装器并返回其 disposer（[packages/webhook/webhook-github/src/invariant.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/invariant.ts#L24-L25)）

### packages/webhook/webhook-github/src/types.ts

GitHub 事件的类型词汇，并把 `github` 项合并进 webhook 运行时的事件映射表。

- 向 `@deepseek-ai/dsh-webhook` 的 `WebhookEventMap` 合并 `github` 键，使该 kind 的投递事件被解析为 `{ name, payload }`（[packages/webhook/webhook-github/src/types.ts:16-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/webhook/webhook-github/src/types.ts#L16-L20)）

### packages/webhook/webhook-github/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、输出目录与工作区项目引用。

- 无运行期机制
