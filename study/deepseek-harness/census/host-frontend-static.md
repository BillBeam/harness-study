---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/host/frontend-static
---

# packages/host/frontend-static

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、26 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/host/frontend-static/README.md

该包的说明文档，描述这个插件如何占据 webserver 的兜底位并提供构建产物目录。

- 无运行期机制

### packages/host/frontend-static/package.json

该包的 npm 清单，声明入口、导出与发布内容。

- `type: module` 与 `main`/`types` 指定包按 ESM 加载、运行时入口为 `lib/index.js`（[packages/host/frontend-static/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/package.json#L13-L15)）
- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，并放开 `./src/*` 与 `./package.json` 的直接引用（[packages/host/frontend-static/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/package.json#L16-L27)）
- `files` 限定发布物只包含 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/host/frontend-static/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/package.json#L28-L32)）

### packages/host/frontend-static/src/index.ts

函数插件本体，实现 `serveStatic` 与 `apply`，被组合进面向浏览器的宿主以占用 webserver 兜底位。

- 导出插件名 `frontend-static` 作为 Cordis 注册名（[packages/host/frontend-static/src/index.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L24)）
- `inject` 声明 `webServer` 与 `connection`，两个服务就绪前插件不会激活（[packages/host/frontend-static/src/index.ts:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L27)）
- `Config` 模式把 `distIndex` 声明为必填字符串，缺失时配置校验失败（[packages/host/frontend-static/src/index.ts:35-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L35-L37)）
- MIME 表把 `.html`/`.js`/`.css`/`.svg`/`.json`/`.map`/`.webmanifest`/`.gz` 映射到响应的 content-type，其中 `.gz` 以 `application/gzip` 原字节返回而非传输层编码（[packages/host/frontend-static/src/index.ts:41-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L41-L53)）
- `STATIC_MISS_CODES` 把 `ENOENT`/`EISDIR`/`ENOTDIR` 圈定为「未命中」错误码集合（[packages/host/frontend-static/src/index.ts:55-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L55-L59)）
- `serveStatic` 把请求路径 join 到 dist 根后 normalize+resolve，得到实际目标路径（[packages/host/frontend-static/src/index.ts:76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L76)）
- 目标既不是 dist 根本身、也不以 dist 根加平台分隔符开头时直接写 403 空响应并返回（[packages/host/frontend-static/src/index.ts:80-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L80-L84)）
- 目标等于 dist 根或配置的 index 路径时先调 `authorizeIndex()`，返回 false 就不写任何响应体直接返回（响应由授权方接管）（[packages/host/frontend-static/src/index.ts:88-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L88-L89)）
- 授权通过后用 `renderIndex()` 产出正文并固定 HTML content-type（[packages/host/frontend-static/src/index.ts:90-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L90-L91)）
- 非 index 目标直接读文件字节，扩展名不在 MIME 表时按 `application/octet-stream` 返回（[packages/host/frontend-static/src/index.ts:92-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L92-L95)）
- 捕获到的错误码不在未命中集合内时原样抛出，否则写 404 空响应（[packages/host/frontend-static/src/index.ts:96-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L96-L103)）
- 成功路径写 200 与 content-type 头并结束响应（[packages/host/frontend-static/src/index.ts:104-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L104-L105)）
- `apply` 由 `distIndex` 的目录推出 dist 根，决定后续所有静态路径的可达范围（[packages/host/frontend-static/src/index.ts:114-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L114-L115)）
- `renderIndex` 闭包读取原始 index.html、交给 `ctx.webServer.renderIndex` 渲染，再在首个 `<head>` 开标签后插入 `<base href="/">`（[packages/host/frontend-static/src/index.ts:120-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L120-L123)）
- 以 `ctx.effect` 包裹 `registerFallback` 注册兜底处理器，fiber 释放时归还兜底位（[packages/host/frontend-static/src/index.ts:124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L124)、[packages/host/frontend-static/src/index.ts:142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L142)）
- 兜底处理器对非 GET/HEAD 请求写 405 并结束（[packages/host/frontend-static/src/index.ts:127-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L127-L131)）
- 从 `req.url` 解析 pathname 并 `decodeURIComponent` 后交给 `serveStatic`（[packages/host/frontend-static/src/index.ts:133-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L133-L134)）
- 把 `ctx.connection.authorizeIndex(req, res)` 作为授权闭包传入，index 响应的认证与 401/303 写出交给 connection（[packages/host/frontend-static/src/index.ts:139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/index.ts#L139)）

### packages/host/frontend-static/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包名。

- `inject` 声明 `invariants`，服务缺席时伴生插件不激活（[packages/host/frontend-static/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/invariant.ts#L14)）
- 安装器为空函数，不注册任何运行期检查（[packages/host/frontend-static/src/invariant.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/invariant.ts#L26)）
- `apply` 以包名把该安装器登记进 `ctx.invariants` 并返回其 disposer（[packages/host/frontend-static/src/invariant.ts:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/frontend-static/src/invariant.ts#L33-L34)）

### packages/host/frontend-static/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制
