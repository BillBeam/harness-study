---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/web/web
---

# packages/web/web

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、22 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/web/web/README.md

该包的参考文档，说明 `ctx.web` 服务的挂载、提供方选择规则表、请求结果词汇与错误码。

- 无运行期机制

### packages/web/web/package.json

该包的清单，声明入口、导出映射、随包文件与对等/运行期依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/web/web/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/package.json#L14-L15)）
- `exports` 除主入口外单独开放 `./invariant` 子入口（[packages/web/web/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/package.json#L16-L27)）
- `files` 限定发布内容为主入口、invariant 入口与类型声明（[packages/web/web/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/package.json#L28-L32)）
- 运行期依赖只有工作区的 schema 库，框架与错误基类为对等依赖（[packages/web/web/package.json:34-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/package.json#L34-L41)）

### packages/web/web/src/index.ts

web 能力接缝的服务实现：两个提供方注册表、执行期提供方选择与搜索结果条数封顶。

- 服务类以 `web` 名注册到上下文（[packages/web/web/src/index.ts:74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L74)）、构造时调用父类完成注册（[packages/web/web/src/index.ts:90-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L90-L91)）
- 静态配置 schema 声明可选的 `searchProvider`/`fetchProvider` 两个提供方 id（[packages/web/web/src/index.ts:80-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L80-L83)）
- 未配置 id 时回落到环境变量 `DSH_WEB_SEARCH_PROVIDER` / `DSH_WEB_FETCH_PROVIDER`（[packages/web/web/src/index.ts:92-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L92-L93)）
- 搜索与取回各自维护一张私有的 id→提供方映射（[packages/web/web/src/index.ts:85-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L85-L86)）
- 两个注册方法把提供方写入各自的注册表（[packages/web/web/src/index.ts:103-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L103-L116)）
- `registerProvider` 对同一能力内重复 id 抛出 `WEB_DUPLICATE_PROVIDER`（[packages/web/web/src/index.ts:119-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L119-L121)）
- 注册走 `ctx.effect`，随调用 fiber 释放时从表中删除，并把异步 disposer 包成同步返回（[packages/web/web/src/index.ts:122-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L122-L128)）
- `search` 在调用时解析提供方、转发信号，并把结果交给条数封顶（[packages/web/web/src/index.ts:140-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L140-L147)）
- `fetch` 在调用时解析提供方并直接透传结果，不做二次加工（[packages/web/web/src/index.ts:157-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L157-L163)）
- `resolveProvider` 对已配置 id：未注册抛 `WEB_PROVIDER_CONFIGURED_MISSING`、`available()` 为假抛 `WEB_PROVIDER_CONFIGURED_UNAVAILABLE`（[packages/web/web/src/index.ts:174-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L174-L182)）
- 未配置 id 时按 `available()` 过滤：零个抛 `WEB_PROVIDER_UNAVAILABLE`、多个抛带候选 id 列表的 `WEB_PROVIDER_AMBIGUOUS`、恰好一个才返回（[packages/web/web/src/index.ts:184-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L184-L193)）
- `capSources` 在提供方超额返回时截断 `sources` 并置 `truncated`（[packages/web/web/src/index.ts:197-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L197-L200)）
- 模块默认导出 `WebRuntime` 作为服务插件（[packages/web/web/src/index.ts:202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/index.ts#L202)）

### packages/web/web/src/invariant.ts

该包的不变量伴生插件，在不变量服务里登记包名并显式声明本包无运行期不变量。

- `apply` 向 `ctx.invariants` 注册包名与一个空安装器，并返回其 disposer（[packages/web/web/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/invariant.ts#L21-L29)）
- 伴生插件名为 `web-invariant`，声明注入 `invariants`（[packages/web/web/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/invariant.ts#L13-L15)）

### packages/web/web/src/types.ts

web 接缝的词汇模块：搜索/取回的请求与结果类型、提供方接口、封闭的响应体联合，以及错误类。

- 定义并导出跨接缝抛出的 `WebError` 类，其 `code` 被工具执行暴露为结构化错误元数据（[packages/web/web/src/types.ts:130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web/src/types.ts#L130)）

### packages/web/web/tsconfig.json

该包的 TypeScript 编译配置，指定源码与声明输出目录并引用各工作区依赖。

- 无运行期机制
