---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/host/webserver
---

# packages/host/webserver

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、48 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/host/webserver/README.md

该包的说明文档，描述路由表、索引注入与兜底位的语义。

- 无运行期机制

### packages/host/webserver/package.json

该包的 npm 清单，声明入口、导出、发布内容与运行期依赖。

- `type: module` 与 `main`/`types` 指定包按 ESM 加载、运行时入口为 `lib/index.js`（[packages/host/webserver/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/package.json#L13-L15)）
- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，并放开 `./src/*` 与 `./package.json`（[packages/host/webserver/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/package.json#L16-L27)）
- `files` 限定发布物只含实现、伴生与类型声明（[packages/host/webserver/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/package.json#L28-L32)）
- `dependencies` 引入 `compression` 与 `negotiator`，压缩中间件与编码协商在运行时依赖它们（[packages/host/webserver/package.json:38-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/package.json#L38-L42)）

### packages/host/webserver/src/index.ts

`WebServer` 服务实现：node:http 监听、命名路由与升级路由表、兜底位、索引渲染与生命周期，被面向浏览器的宿主组合使用。

- 压缩默认值常量把默认压缩定为 `none`、级别 1、阈值 1024 字节（[packages/host/webserver/src/index.ts:72-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L72-L74)）
- gzip 中间件的 filter 对带 `content-range` 的响应与 `text/event-stream` 响应一律不压缩，其余交给 `compression` 自带 filter（[packages/host/webserver/src/index.ts:91-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L91-L100)）
- 包装后的中间件在响应没有 socket 时直接放行不压缩（[packages/host/webserver/src/index.ts:102-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L102-L107)）
- 用 Negotiator 在 `gzip`/`identity` 之间协商，并以改写过 `accept-encoding` 头的请求代理对象调用压缩中间件（[packages/host/webserver/src/index.ts:108-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L108-L114)）
- `Config` 模式把 `host` 限死为 `127.0.0.1` 或 `0.0.0.0`、`port` 限为 ≤65535 的自然数，并给三个压缩字段填默认值（[packages/host/webserver/src/index.ts:125-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L125-L131)）
- 服务持有 exact/prefix/upgrade 三张路由表、已升级 socket 集合、索引 tap 列表与单个兜底槽（[packages/host/webserver/src/index.ts:133-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L133-L141)）
- 构造函数只在 `compression === 'gzip'` 时创建压缩中间件，否则整条压缩路径不存在（[packages/host/webserver/src/index.ts:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L143-L147)）
- `port` getter 暴露实际监听端口（`port: 0` 时为系统分配值），`host` getter 暴露配置的绑定地址（[packages/host/webserver/src/index.ts:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L150-L157)）
- `register` 按 kind 选表，路径重复时抛错，否则写入并返回删除该路由的 disposer（[packages/host/webserver/src/index.ts:165-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L165-L172)）
- `registerUpgrade` 对重复升级路径抛错，否则写入并返回删除 disposer（[packages/host/webserver/src/index.ts:180-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L180-L186)）
- `registerFallback` 是单占位：已有兜底时抛错，否则占位并返回释放该位的 disposer（[packages/host/webserver/src/index.ts:196-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L196-L202)）
- `tapIndex` 把原始 HTML 变换按注册顺序追加进列表，disposer 从列表中摘除它（[packages/host/webserver/src/index.ts:211-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L211-L217)）
- 请求分发先解析 pathname 并 `match`，命中就交给路由处理器；未命中且无兜底则写 404，有兜底则交给兜底处理器（[packages/host/webserver/src/index.ts:221-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L221-L237)）
- 每个请求的最终 catch 记 warn 日志，并在头已发出时销毁响应、否则写 400，进程不因单个请求失败退出（[packages/host/webserver/src/index.ts:242-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L242-L253)）
- 存在 gzip 中间件时请求先过它再进入分发，否则直接分发（[packages/host/webserver/src/index.ts:254-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L254-L256)）
- 升级事件上挂 socket 错误处理（记 warn 并销毁）与 close 处理（摘除监听并从跟踪集合移除）（[packages/host/webserver/src/index.ts:257-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L257-L266)）
- 升级请求 URL 解析失败时记 warn 并销毁 socket；升级路径未匹配到路由时直接销毁 socket（[packages/host/webserver/src/index.ts:267-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L267-L279)）
- 匹配成功的 socket 被加入跟踪集合，升级处理器的同步抛出与异步拒绝都记 warn 并销毁 socket（[packages/host/webserver/src/index.ts:280-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L280-L289)）
- 初始化 await 监听：绑定失败以 error 拒绝（fiber 进入 FAILED），成功后改挂 error 日志监听并记录实际监听端口（[packages/host/webserver/src/index.ts:292-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L292-L300)）
- 释放副作用关闭服务器、调用 `closeAllConnections()`、逐个销毁已跟踪的升级 socket，并等到服务器与这些 socket 全部关闭后才返回（[packages/host/webserver/src/index.ts:304-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L304-L314)）
- `match` 先查 exact 表，未命中再遍历 prefix 表取最长前缀（要求路径等于前缀或以「前缀/」开头）（[packages/host/webserver/src/index.ts:318-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L318-L327)）
- `applyIndexTaps` 按注册顺序把 HTML 依次穿过每个 tap（[packages/host/webserver/src/index.ts:335-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L335-L339)）
- `collectIndexInjections` 每次调用新建空表并 emit 一次 `webserver/index-inject`，由订阅方按激活顺序追加当前行（[packages/host/webserver/src/index.ts:347-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L347-L351)）
- `renderIndex` 先渲染结构化注入行、再把结果交给原始 taps（[packages/host/webserver/src/index.ts:359-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L359-L361)）
- 默认导出该服务类，供加载器按服务插件形式挂载（[packages/host/webserver/src/index.ts:364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/index.ts#L364)）

### packages/host/webserver/src/injections.ts

结构化索引注入行的渲染实现，被 `WebServer.renderIndex` 调用，同一批行也用于静态部署的启动载荷。

- `escapeHtmlAttribute` 对 `&`、`"`、`<`、`>` 做实体转义后才放进带引号的属性（[packages/host/webserver/src/injections.ts:34-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L34-L40)）
- 未知行类型走 `assertNever` 抛错，携带该行的 JSON（[packages/host/webserver/src/injections.ts:42-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L42-L44)）
- `global` 行渲染成 head 内的内联脚本，对属性名与值做 JSON 序列化并把其中的 `<` 替换成 JSON 转义序列（`<`），`undefined` 值渲染为字面 `undefined`（[packages/host/webserver/src/injections.ts:49-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L49-L57)）
- `script` 行按声明的 placement 渲染成内联 `<script>`，文本原样嵌入（[packages/host/webserver/src/injections.ts:58-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L58-L59)）
- `script-src` 行渲染成带转义 src 的外链脚本标签（服务形态下是阻塞解析的经典脚本）（[packages/host/webserver/src/injections.ts:60-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L60-L61)）
- `script-preload` 行固定渲染到 head 的 `<link rel="preload" as="script">`（[packages/host/webserver/src/injections.ts:62-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L62-L63)）
- `style` 行固定渲染到 head 的 `<style>`，`html` 行按 placement 原样插入片段（[packages/host/webserver/src/injections.ts:64-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L64-L67)）
- `splice` 在给定下标处把渲染出的 markup 插入原 HTML（[packages/host/webserver/src/injections.ts:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L74-L76)）
- 尾部脚本以 `??=` 创建或复用 `globalThis.__DSH_BOOT_READY__` 这个 deferred 并 resolve 它，客户端入口在读取注入状态前 await 它（[packages/host/webserver/src/injections.ts:86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L86)）
- `renderIndexInjections` 按表顺序把行分拣进 head 串与 body 串，并把启动就绪脚本接在 body 串末尾（[packages/host/webserver/src/injections.ts:97-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L97-L104)）
- head 串插在首个 `<head>` 开标签之后；页面没有 head 时整段前置到文档最前（[packages/host/webserver/src/injections.ts:106-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L106-L111)）
- body 串插在首个 `<body>` 开标签之后；没有 body 时追加到文档末尾（[packages/host/webserver/src/injections.ts:112-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/injections.ts#L112-L117)）

### packages/host/webserver/src/invariant.ts

该包的不变量伴生插件，检查路由注册与 disposer 的对称性。

- `inject` 声明 `invariants`，服务缺席时伴生插件不激活（[packages/host/webserver/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/invariant.ts#L15)）
- 安装器在全局监听 `internal/plugin`，每次 fiber 拆卸都触发一次检查（[packages/host/webserver/src/invariant.ts:26-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/invariant.ts#L26-L27)、[packages/host/webserver/src/invariant.ts:49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/invariant.ts#L49)）
- 通过 `ctx.get('webServer')` 取服务，组合中没有该服务时直接返回不检查（[packages/host/webserver/src/invariant.ts:28-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/invariant.ts#L28-L34)）
- 用两个保留路径各做两轮「注册后立即释放」，任一轮抛重复注册错就调用 `fail` 报告路由表与 fiber 生命周期不同步（[packages/host/webserver/src/invariant.ts:39-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/invariant.ts#L39-L48)）
- `apply` 以包名把该安装器登记进 `ctx.invariants` 并返回其 disposer（[packages/host/webserver/src/invariant.ts:57-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/webserver/src/invariant.ts#L57-L58)）

### packages/host/webserver/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制
