---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/web/web-fetch-http
---

# packages/web/web-fetch-http

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、67 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/web/web-fetch-http/README.md

该包的参考文档，说明这个 HTTP(S) 抓取 provider 如何挂载、配置项与失败码，供阅读者使用。

- 无运行期机制

### packages/web/web-fetch-http/package.json

该包的 npm 清单，决定包名、入口解析与发布内容。

- `type: module` 与 `main`/`types` 指定 ESM 加载与默认入口 `lib/index.js`（[packages/web/web-fetch-http/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/package.json#L13-L15)）
- `exports` 暴露主入口、`./invariant` 子路径、原始 `./src/*` 与 `./package.json`（[packages/web/web-fetch-http/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/web/web-fetch-http/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/package.json#L28-L32)）
- `dependencies` 声明运行期依赖 `ipaddr.js` 与 `undici`（[packages/web/web-fetch-http/package.json:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/package.json#L40-L44)）

### packages/web/web-fetch-http/src/index.ts

插件入口，声明配置模式、校验限额并把 HTTP 抓取 provider 注册进 `ctx.web`。

- `DEFAULT_USER_AGENT` 定义每次请求发出的产品 `User-Agent` 字符串（[packages/web/web-fetch-http/src/index.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/index.ts#L23)）
- `inject = ['web']` 声明该插件在 web 服务就绪后才装载（[packages/web/web-fetch-http/src/index.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/index.ts#L29)）
- Config schema 为响应字节上限、正文字符上限、超时、重定向跳数与 UA 填入默认值 5,000,000 / 100,000 / 30,000 / 5（[packages/web/web-fetch-http/src/index.ts:45-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/index.ts#L45-L51)）
- `assertPositiveFinite` 在非有限或非正数时抛错（[packages/web/web-fetch-http/src/index.ts:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/index.ts#L57-L61)）
- `assertTimeoutMs` 额外拒绝超过 `2_147_483_647` 的超时值（[packages/web/web-fetch-http/src/index.ts:63-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/index.ts#L63-L69)）
- `assertNonNegativeInteger` 要求重定向跳数为非负整数（[packages/web/web-fetch-http/src/index.ts:71-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/index.ts#L71-L76)）
- `apply` 在构造 provider 前逐项校验四个限额，任一不合法即抛出并中止装载（[packages/web/web-fetch-http/src/index.ts:79-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/index.ts#L79-L85)）
- `apply` 用解析后的限额构造 `HttpFetchProvider` 并调用 `ctx.web.registerFetchProvider` 注册（[packages/web/web-fetch-http/src/index.ts:86-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/index.ts#L86-L93)）

### packages/web/web-fetch-http/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名。

- `inject = ['invariants']` 要求 invariants 服务先就绪（[packages/web/web-fetch-http/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/invariant.ts#L15)）
- `install` 为空实现，不安装任何运行期检查（[packages/web/web-fetch-http/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register` 以包名注册并返回 disposer（[packages/web/web-fetch-http/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/invariant.ts#L28-L29)）

### packages/web/web-fetch-http/src/network.ts

公网地址解析与地址钉住的 HTTP 传输实现，被 provider 在每次请求与每跳重定向前调用。

- `isPublicIpAddress` 解析失败返回 false，IPv4 只接受 `unicast`，IPv4-mapped IPv6 按内嵌 IPv4 判定，其余按 IPv6 range 判定（[packages/web/web-fetch-http/src/network.ts:53-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L53-L63)）
- `resolvePublicAddresses` 对 IP 字面量跳过 DNS，否则调用 resolver 并与中止信号竞速（[packages/web/web-fetch-http/src/network.ts:79-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L79-L83)）
- 解析出空结果时抛 `WEB_PROVIDER_ERROR`（[packages/web/web-fetch-http/src/network.ts:85-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L85-L87)）
- 仅当答案集中含 IPv6 时才去发现 NAT64 前缀（[packages/web/web-fetch-http/src/network.ts:89-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L89-L92)）
- 地址族非 4/6 或与文本不符时抛 `WEB_PROVIDER_ERROR`（[packages/web/web-fetch-http/src/network.ts:96-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L96-L98)）
- 任一地址非公网时以 `WEB_BLOCKED_URL` 拒绝整个答案集（[packages/web/web-fetch-http/src/network.ts:99-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L99-L101)）
- 经 NAT64 前缀还原出的 IPv4 非公网时同样以 `WEB_BLOCKED_URL` 拒绝（[packages/web/web-fetch-http/src/network.ts:102-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L102-L105)）
- `discoverNat64Prefixes` 解析 `ipv4only.arpa`，对 `192.0.0.170`/`192.0.0.171` 哨兵匹配的前缀长度收集去重后的前缀集（[packages/web/web-fetch-http/src/network.ts:112-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L112-L133)）
- `translatedIpv4Address` 按前缀字节逐一比对，命中则取出内嵌 IPv4（[packages/web/web-fetch-http/src/network.ts:136-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L136-L145)）
- `embeddedIpv4Address` 按 RFC 6052 布局跨过第 9 字节保留位取四字节 IPv4（[packages/web/web-fetch-http/src/network.ts:148-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L148-L158)）
- `requestPinned` 动态 `import('undici')`，把 Undici 传输的加载推迟到真正发请求时（[packages/web/web-fetch-http/src/network.ts:179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L179)）
- 为每次请求新建 `Agent`，其 `connect.lookup` 只返回已校验地址集，并以 `redirect: 'manual'` 发 GET（[packages/web/web-fetch-http/src/network.ts:180-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L180-L186)）
- 请求抛错时先关闭 dispatcher 再向上抛（[packages/web/web-fetch-http/src/network.ts:187-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L187-L190)）
- `publicHttpNetwork` 把解析与请求两个操作聚成可替换的对象（[packages/web/web-fetch-http/src/network.ts:194-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L194-L197)）
- `createPinnedLookup` 按请求的地址族过滤已校验地址，无可用地址时以 `ENOTFOUND` 回调，`options.all` 决定回调数组还是单地址（[packages/web/web-fetch-http/src/network.ts:216-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L216-L235)）
- `raceWithSignal` 让不可取消的系统解析在信号中止时立刻以错误返回，并在结束后摘除监听（[packages/web/web-fetch-http/src/network.ts:239-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L239-L247)）
- `stripIpv6Brackets` 去掉 IPv6 主机名两端的方括号后再交给解析器（[packages/web/web-fetch-http/src/network.ts:250-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/network.ts#L250-L252)）

### packages/web/web-fetch-http/src/policy.ts

不触网的 URL 校验与内容类型分类函数，被 provider 在请求前后调用。

- `WEB_FETCH_MAX_URL_LENGTH` 固定为 2048（[packages/web/web-fetch-http/src/policy.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/policy.ts#L12)）
- `parseFetchUrl` 解析失败时抛 `WEB_INVALID_URL`（[packages/web/web-fetch-http/src/policy.ts:26-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/policy.ts#L26-L31)）
- 只放行 `http:` 与 `https:`，其他协议抛 `WEB_INVALID_URL`（[packages/web/web-fetch-http/src/policy.ts:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/policy.ts#L32-L34)）
- URL 内嵌用户名或密码时抛 `WEB_BLOCKED_URL`（[packages/web/web-fetch-http/src/policy.ts:35-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/policy.ts#L35-L37)）
- `validateFetchUrl` 先按 2048 长度上限拒绝，再走 `parseFetchUrl`（[packages/web/web-fetch-http/src/policy.ts:49-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/policy.ts#L49-L54)）
- `isSameOrigin` 以协议、主机名、端口三者相等判定同源（[packages/web/web-fetch-http/src/policy.ts:65-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/policy.ts#L65-L67)）
- `classifyContentType` 把 `text/html` 与 `application/xhtml+xml` 归为 `html`，其余 `text/*` 及 JSON/XML 家族归为 `text`，其他返回 `undefined`（[packages/web/web-fetch-http/src/policy.ts:78-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/policy.ts#L78-L84)）
- `parseCharset` 用正则从 `Content-Type` 抽出并小写化 charset 参数（[packages/web/web-fetch-http/src/policy.ts:96-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/policy.ts#L96-L99)）
- `decoderForCharset` 缺省用 UTF-8，声明了但 `TextDecoder` 不认的标签抛 `WEB_UNSUPPORTED_CONTENT_TYPE`（[packages/web/web-fetch-http/src/policy.ts:111-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/policy.ts#L111-L118)）

### packages/web/web-fetch-http/src/provider.ts

`HttpFetchProvider` 的实现，注册到 `ctx.web` 后承担 URL 校验、重定向跟随、限额读取与解码。

- `LOCAL_FETCH_PROVIDER_ID` 固定为 `'http'`，即注册用的 provider id（[packages/web/web-fetch-http/src/provider.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L35)）
- 构造函数把地址解析器默认设为 `publicHttpNetwork.resolve`（[packages/web/web-fetch-http/src/provider.ts:45-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L45-L48)）
- `available()` 恒为 true（[packages/web/web-fetch-http/src/provider.ts:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L51-L53)）
- `fetch()` 在信号已中止时立即抛 `WEB_ABORTED`（[packages/web/web-fetch-http/src/provider.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L56)）
- `fetch()` 用 `deadline(signal, timeoutMs, 'WEB_FETCH_TIMEOUT')` 派生一个同时管住请求与读体的信号（[packages/web/web-fetch-http/src/provider.ts:60-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L60-L61)）
- `followAndRead` 先校验初始 URL，再进入逐跳循环（[packages/web/web-fetch-http/src/provider.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L66-L70)）
- 达到跳数上限时取消响应体并抛 `WEB_REDIRECT_BLOCKED`（[packages/web/web-fetch-http/src/provider.ts:75-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L75-L78)）
- 重定向响应缺 `Location` 时取消响应体并抛 `WEB_PROVIDER_ERROR`（[packages/web/web-fetch-http/src/provider.ts:79-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L79-L85)）
- 重定向目标要重新过一遍 `validateFetchUrl`，非同源则抛 `WEB_REDIRECT_BLOCKED`（[packages/web/web-fetch-http/src/provider.ts:86-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L86-L102)）
- 每跳都先取消当前响应体、把当前 URL 换成目标并累加跳数后继续循环（[packages/web/web-fetch-http/src/provider.ts:103-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L103-L106)）
- 每次请求无论成功失败都在 `finally` 里调用 `request.close()` 释放该请求的 dispatcher（[packages/web/web-fetch-http/src/provider.ts:110-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L110-L112)）
- `requestOnce` 每跳都重新解析主机名并把地址集交给钉住传输，发送固定的 `user-agent` 与 `accept` 头（[packages/web/web-fetch-http/src/provider.ts:117-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L117-L122)）
- `requestOnce` 把非 `WebError` 的异常交给 `translateAbortOrNetwork` 归类（[packages/web/web-fetch-http/src/provider.ts:123-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L123-L126)）
- `readBody` 对无法分类的 `Content-Type` 取消响应体并抛 `WEB_UNSUPPORTED_CONTENT_TYPE`（[packages/web/web-fetch-http/src/provider.ts:131-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L131-L136)）
- 解码器在读体之前构造，构造失败时取消响应体再抛（[packages/web/web-fetch-http/src/provider.ts:141-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L141-L147)）
- 解码后按 `maxBodyChars` 截断字符并据此置位 `truncatedByChars`（[packages/web/web-fetch-http/src/provider.ts:148-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L148-L152)）
- 返回值携带最终 URL、HTTP 状态码、`html`/`text` 正文与字节或字符任一被截断的 `truncated` 标志（[packages/web/web-fetch-http/src/provider.ts:154-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L154-L159)）
- `readCapped` 在 `Content-Length` 超过字节上限时直接取消响应体并抛 `WEB_FETCH_TOO_LARGE`（[packages/web/web-fetch-http/src/provider.ts:169-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L169-L176)）
- 流式读取在超过剩余容量时截断该块、置 `truncatedByBytes` 并跳出循环，恰好填满时不算截断（[packages/web/web-fetch-http/src/provider.ts:187-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L187-L202)）
- 读流异常同样经 `translateAbortOrNetwork` 归类，并在 `finally` 中尽力 `reader.cancel()`（[packages/web/web-fetch-http/src/provider.ts:203-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L203-L212)）
- 收集到的分块被拼成一个定长 `Uint8Array` 返回（[packages/web/web-fetch-http/src/provider.ts:214-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L214-L220)）
- `isRedirectStatus` 把 301/302/303/307/308 认作重定向（[packages/web/web-fetch-http/src/provider.ts:225-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L225-L227)）
- `resolveRedirect` 以当前 URL 为基址解析相对 `Location`，失败抛 `WEB_PROVIDER_ERROR`（[packages/web/web-fetch-http/src/provider.ts:230-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L230-L237)）
- `translateAbortOrNetwork` 按信号来源把异常分成 `WEB_FETCH_TIMEOUT`、`WEB_ABORTED` 与 `WEB_PROVIDER_ERROR` 三类（[packages/web/web-fetch-http/src/provider.ts:249-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/web-fetch-http/src/provider.ts#L249-L254)）

### packages/web/web-fetch-http/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工程引用。

- 无运行期机制
