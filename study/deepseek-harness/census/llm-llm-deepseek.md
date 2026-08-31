---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/llm/llm-deepseek
---

# packages/llm/llm-deepseek

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 16 个文件、142 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/llm/llm-deepseek/README.md

这个包的说明文档，描述该适配器的配置字段、图片与思考模式行为、失败码与模型可见内容，供使用者和维护者阅读。

- 无运行期机制

### packages/llm/llm-deepseek/package.json

这个包的 npm 清单，声明模块入口、导出子路径、发布文件与依赖。

- `main` / `types` / `exports` 决定导入该包时解析到的运行文件，并额外暴露 `./invariant`、`./src/*`、`./package.json` 三个子路径（[packages/llm/llm-deepseek/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/package.json#L14-L27)）
- `files` 限定发布内容为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/llm/llm-deepseek/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/package.json#L28-L32)）
- `dependencies` 使运行期携带 `eventsource-parser` 与 schemastery（[packages/llm/llm-deepseek/package.json:50-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/package.json#L50-L53)）

### packages/llm/llm-deepseek/src/adapter.ts

适配器实现：用 fetch + SSE 直连 chat-completions 端点，把连接快照、凭据、图片表示与错误映射串成一次模型请求，由 `src/index.ts` 注册进 `ctx.llm`。

- `collectImageRefs` 递归遍历内容块（含 `tool-result` 内嵌内容），按附件 id 去重收集图片引用（[packages/llm/llm-deepseek/src/adapter.ts:203-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L203-L211)）
- `prepareRequestImages` 按模型策略并发调用 `attachments.readImageRequest`，把每个引用投影成确定性的请求版本映射（[packages/llm/llm-deepseek/src/adapter.ts:213-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L213-L229)）
- `providerRejectedNormalizedImage` 用两组正则判定错误详情是否属于图片被拒（[packages/llm/llm-deepseek/src/adapter.ts:231-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L231-L235)）
- `providerRejectedFileId` 用正则判定错误详情是否属于 file id 失效、不存在或非法（[packages/llm/llm-deepseek/src/adapter.ts:243-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L243-L248)）
- `detailNamesFileId` 以词边界判定错误详情是否逐字指名某个 file id（[packages/llm/llm-deepseek/src/adapter.ts:250-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L250-L260)）
- `staleMappings` 先按 variant+fileId 去重，命中指名者只取指名项，否则取全部本次用到的映射（[packages/llm/llm-deepseek/src/adapter.ts:262-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L262-L269)）
- `normalizedImageFacts` 与 `normalizedImageDiagnostic` 把被拒图片的名称、消息序号、图片序号、媒体类型与尺寸拼成对外抛出的错误文本，指名失败时列出全部候选（[packages/llm/llm-deepseek/src/adapter.ts:271-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L271-L299)）
- `modelInfo` 把目录条目转成对外模型信息，`name` 缺省取 id，`inputModalities` 缺省为 `['text']`（[packages/llm/llm-deepseek/src/adapter.ts:301-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L301-L309)）
- `providerRetryAfterMs` 把 `retry-after` 响应头按纯数字秒或 HTTP 日期解析成毫秒延迟（[packages/llm/llm-deepseek/src/adapter.ts:311-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L311-L319)）
- `requestId` 从 `x-request-id` 或 `x-deepseek-request-id` 提取供应商请求 id（[packages/llm/llm-deepseek/src/adapter.ts:321-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L321-L324)）
- `httpErrorCode` 把 HTTP 状态与错误体字段映射为 `AUTH`、`INVALID_REQUEST`、配额、`RATE_LIMIT`、上下文超限、`SERVER` 或 `HTTP_<status>`（[packages/llm/llm-deepseek/src/adapter.ts:332-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L332-L344)）
- 构造函数取外部提供的上传复用存储，缺失时新建一个 `DeepSeekFileStore`（[packages/llm/llm-deepseek/src/adapter.ts:356-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L356-L359)）
- `providerRetryPolicy` 每次调用重新读取当前连接快照里的重试策略（[packages/llm/llm-deepseek/src/adapter.ts:365-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L365-L367)）
- `imageRequestPricing` 用与序列化相同的附件访问解析构造该路由的图片计价函数（[packages/llm/llm-deepseek/src/adapter.ts:369-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L369-L379)）
- `listModels` 把当前快照的目录条目作为可发现模型返回（[packages/llm/llm-deepseek/src/adapter.ts:381-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L381-L383)）
- `modelInfoFor` 对未登记模型只声明 `text` 模态，上下文窗口取目录值否则取默认值，`defaultMaxTokens` 取模型上限否则取配置上限（[packages/llm/llm-deepseek/src/adapter.ts:393-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L393-L409)）
- `modelInfoFor` 在部署 `thinking: disabled` 时只暴露 `off` 一档努力度，否则暴露四档并按配置默认值选中（[packages/llm/llm-deepseek/src/adapter.ts:410-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L410-L429)）
- `prepareCall` 解析一次连接快照并把它闭包进返回的 `stream`，使后续流复用同一代配置（[packages/llm/llm-deepseek/src/adapter.ts:432-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L432-L438)）
- `streamWithConnection` 在含图请求上校验模型声明了 `image` 模态、且附件服务存在，否则抛 `UNSUPPORTED_CONTENT`（[packages/llm/llm-deepseek/src/adapter.ts:453-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L453-L470)）
- 每次流调用从同一连接快照解析 API key 与匿名用户 id（[packages/llm/llm-deepseek/src/adapter.ts:471-472](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L471-L472)）
- 把调用方信号与本地消费者信号合并，再套上按配置时长的空闲看门狗信号（[packages/llm/llm-deepseek/src/adapter.ts:473-477](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L473-L477)）
- 逐个 `watchdog.next` 拉取底层迭代器并转发 chunk，直到耗尽（[packages/llm/llm-deepseek/src/adapter.ts:487-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L487-L496)）
- 异常按空闲超时 `TIMEOUT`、调用方中止 `ABORTED`、已是 `LlmError` 原样、其余 `TRANSPORT` 分类抛出（[packages/llm/llm-deepseek/src/adapter.ts:497-509](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L497-L509)）
- `finally` 中止消费者控制器，并对未耗尽的迭代器调用 `return()` 收尾，吞掉收尾期的中止错误（[packages/llm/llm-deepseek/src/adapter.ts:510-519](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L510-L519)）
- 请求头带上 Bearer 授权、SSE accept、共享归因头、匿名用户 id，并按需带上会话 id 与压缩用途标记（[packages/llm/llm-deepseek/src/adapter.ts:531-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L531-L543)）
- 第一阶段按原始字节与张数上限、配额步长做最旧优先卸载，被卸载图片替换为占位文本（[packages/llm/llm-deepseek/src/adapter.ts:552-561](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L552-L561)）
- 在卸载后的消息上准备请求图片版本，未接入附件或未登记模型时为空映射（[packages/llm/llm-deepseek/src/adapter.ts:562-564](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L562-L564)）
- 无附件服务时走纯文本序列化，`base64` 表示走内联序列化并使用独立的内联字节上限与步长（[packages/llm/llm-deepseek/src/adapter.ts:567-581](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L567-L581)）
- `file` 表示下每张图在独立 deadline 内调用 `files.ensureUploaded` 换取 file id，成功后触发活动脉冲并记入 `usedFiles`（[packages/llm/llm-deepseek/src/adapter.ts:584-612](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L584-L612)）
- file id 解析失败（非调用方中止）包成 `FileResolutionFailure`，捕获后整体切换为 base64 表示重建请求（[packages/llm/llm-deepseek/src/adapter.ts:597-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L597-L600)）
- 捕获 `FileResolutionFailure` 后把表示切到 `base64` 并 `continue` 重走循环（[packages/llm/llm-deepseek/src/adapter.ts:613-617](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L613-L617)）
- 用序列化好的基础请求体调用扩展准备钩子，失败抛 `REQUEST_EXTENSION`（[packages/llm/llm-deepseek/src/adapter.ts:619-629](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L619-L629)）
- 扩展字段与基础请求体字段同名时在发起 HTTP 前抛 `REQUEST_EXTENSION`（[packages/llm/llm-deepseek/src/adapter.ts:630-634](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L630-L634)）
- 把基础请求体与扩展字段合并后序列化成最终 payload（[packages/llm/llm-deepseek/src/adapter.ts:637](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L637)）
- 向 `${baseURL}/chat/completions` 发起带信号的 POST，非中止的失败抛 `TRANSPORT`（[packages/llm/llm-deepseek/src/adapter.ts:641-656](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L641-L656)）
- 非 2xx 时读取响应文本并尝试解析供应商错误体，解析失败保留 HTTP 状态文案（[packages/llm/llm-deepseek/src/adapter.ts:658-671](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L658-L671)）
- 判定为 file id 失效时并发作废相关本地映射，并只允许一次整轮重发（[packages/llm/llm-deepseek/src/adapter.ts:672-681](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L672-L681)）
- 400 且判定为归一化图片被拒时，把错误消息替换成指名图片位置的诊断文本（[packages/llm/llm-deepseek/src/adapter.ts:682-684](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L682-L684)）
- 抛出的 `LlmError` 携带原始响应体、HTTP 状态、解析出的重试延迟与供应商请求 id（[packages/llm/llm-deepseek/src/adapter.ts:685-692](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L685-L692)）
- 仅在 2xx 之后调用 `extensions.accept()` 提交扩展贡献，失败抛 `REQUEST_EXTENSION`（[packages/llm/llm-deepseek/src/adapter.ts:694-698](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L694-L698)）
- 2xx 但无响应体时抛 `EMPTY_RESPONSE`（[packages/llm/llm-deepseek/src/adapter.ts:699-701](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L699-L701)）
- 把响应体交给 SSE 解析并翻译成 harness chunk 逐个产出，随后结束循环（[packages/llm/llm-deepseek/src/adapter.ts:703-704](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/adapter.ts#L703-L704)）

### packages/llm/llm-deepseek/src/file-id.ts

Files API 标识符的品牌类型与两个同名品牌函数，被 files-api、file-store 和 upload-index 用来给字符串附加类型身份。

- 无运行期机制

### packages/llm/llm-deepseek/src/file-store.ts

上传复用存储：把确定性请求图片版本换成可复用的 file id，并负责单飞、过期刷新、失效作废与配额回收，由 adapter 在 `file` 表示下调用。

- `MAX_CHAT_IMAGE_BYTES` 与 `OWNED_FILE_PREFIX` 固定单图 32 MiB 上限和本地所有权文件名前缀（[packages/llm/llm-deepseek/src/file-store.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L10-L12)）
- `waitForUpload` 维护等待者计数，最后一个等待者取消时中止共享上传，其余情况只解除本次等待（[packages/llm/llm-deepseek/src/file-store.ts:59-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L59-L93)）
- `filename` 用所有权前缀加附件与变体摘要片段和媒体类型后缀拼出上传文件名（[packages/llm/llm-deepseek/src/file-store.ts:95-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L95-L108)）
- 构造函数允许注入索引、时钟与 fetch 实现，缺省用默认索引和 `Date.now`（[packages/llm/llm-deepseek/src/file-store.ts:120-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L120-L124)）
- `ensureUploaded` 以「作用域+变体 id」为键做单飞，已中止的在飞条目被丢弃后重新发起（[packages/llm/llm-deepseek/src/file-store.ts:142-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L142-L176)）
- 单张图片超过 32 MiB 直接抛 `INVALID_REQUEST`（[packages/llm/llm-deepseek/src/file-store.ts:184-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L184-L186)）
- 命中索引且剩余寿命超过刷新余量时直接复用已有 file id，不再上传（[packages/llm/llm-deepseek/src/file-store.ts:187-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L187-L191)）
- 上传按策略携带显式过期时间，返回字节数与提交字节不符时抛 `INVALID_RESPONSE`（[packages/llm/llm-deepseek/src/file-store.ts:194-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L194-L214)）
- 上传遇配额错误时先回收一批最旧的本地所有权文件，回收数为 0 则原样抛出，否则重试一次上传（[packages/llm/llm-deepseek/src/file-store.ts:216-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L216-L224)）
- 提交索引失败（他方已发布可复用映射）时删除本次多余的远端文件并返回胜出记录（[packages/llm/llm-deepseek/src/file-store.ts:225-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L225-L233)）
- `invalidate` 按作用域、变体与确切 file id 移除一条本地映射（[packages/llm/llm-deepseek/src/file-store.ts:242-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L242-L252)）
- `release` 查到可复用映射后删除远端文件并移除本地映射，返回是否发生删除（[packages/llm/llm-deepseek/src/file-store.ts:262-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L262-L279)）
- `reclaimOldestOwned` 按升序分页列举文件、只挑文件名带所有权前缀者，逐个删除并返回删除数（[packages/llm/llm-deepseek/src/file-store.ts:288-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L288-L313)）
- `releaseAll` 循环回收直到一轮不足 1000 条，再清空该作用域的全部本地映射（[packages/llm/llm-deepseek/src/file-store.ts:321-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/file-store.ts#L321-L330)）

### packages/llm/llm-deepseek/src/files-api.ts

Files API 的直连传输客户端：上传、列举、检索、删除，并校验响应，被 `file-store.ts` 使用。

- 常量固定过期区间、上传字节上限与每 key 的文件数与存储配额（[packages/llm/llm-deepseek/src/files-api.ts:8-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L8-L17)）
- `DeepSeekFilesError` 按 HTTP 状态映射为 `AUTH`、`RATE_LIMIT`、`SERVER` 或 `FILES_API`，并保留供分类用的详情串（[packages/llm/llm-deepseek/src/files-api.ts:38-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L38-L58)）
- `isFilesQuotaError` 用正则从详情串判定失败是否属于配额类，从而决定是否触发一次清理重试（[packages/llm/llm-deepseek/src/files-api.ts:65-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L65-L68)）
- `parseFileObject` 逐字段校验 id、object、bytes、created_at、filename、purpose 与 expires_at，不合法抛 `INVALID_RESPONSE`（[packages/llm/llm-deepseek/src/files-api.ts:90-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L90-L111)）
- `providerErrorDetail` 从错误体抽出可展示消息，并把 code/type/message 连成分类用详情（[packages/llm/llm-deepseek/src/files-api.ts:113-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L113-L125)）
- 构造函数剥掉 baseURL 末尾斜杠，并允许注入 fetch 实现（[packages/llm/llm-deepseek/src/files-api.ts:136-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L136-L140)）
- `request` 给每次调用加共享归因头与 Bearer 授权，非中止的传输失败抛 `TRANSPORT`，非 2xx 抛 `DeepSeekFilesError`（[packages/llm/llm-deepseek/src/files-api.ts:142-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L142-L169)）
- `upload` 先校验 128 MiB 上限与 3600–2592000 秒过期区间，再用 multipart 提交 `purpose`、`expires_after` 与文件体，并要求响应带 `expires_at`（[packages/llm/llm-deepseek/src/files-api.ts:176-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L176-L200)）
- `list` 固定按 `purpose=user_data` 查询并透传 after/limit/order，逐字段校验分页响应（[packages/llm/llm-deepseek/src/files-api.ts:207-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L207-L232)）
- `retrieve` 对 file id 做 URL 编码后取回并校验单个文件对象（[packages/llm/llm-deepseek/src/files-api.ts:240-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L240-L243)）
- `delete` 要求响应回显同一 id、`object: 'file'` 与 `deleted: true`，否则抛 `INVALID_RESPONSE`（[packages/llm/llm-deepseek/src/files-api.ts:250-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/files-api.ts#L250-L256)）

### packages/llm/llm-deepseek/src/image-tokens.ts

视觉 token 计算：把请求图片尺寸投影到 14 像素补丁网格并算出 token 数，供 `request-pricing.ts` 给每张保留图片计价。

- 常量固定补丁边长 14、每轴 3:1 下采样、单图 384 token 上限、对齐量 4、8:1 宽高比钳制与 384×384 像素下限（[packages/llm/llm-deepseek/src/image-tokens.ts:12-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/image-tokens.ts#L12-L23)）
- `gridTokens` 按网格行列数加行分隔与框架 token，并对奇数行与半行奇偶做补正（[packages/llm/llm-deepseek/src/image-tokens.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/image-tokens.ts#L37-L42)）
- `solveResizeRatio` 用闭式解求在给定预算内保持长宽比的最大网格，并按分支回算像素尺寸（[packages/llm/llm-deepseek/src/image-tokens.ts:45-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/image-tokens.ts#L45-L85)）
- `safeResize` 把预算取为 384 减去最坏对齐补位，超预算时反复降预算求解，最后把补位加回 token 数（[packages/llm/llm-deepseek/src/image-tokens.ts:88-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/image-tokens.ts#L88-L109)）
- `resizeOnce` 先按 8:1 钳制宽度、再把不足 384×384 的总像素放大，然后向上补齐到补丁倍数并投影（[packages/llm/llm-deepseek/src/image-tokens.ts:112-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/image-tokens.ts#L112-L127)）
- `deepSeekImageTokens` 迭代 `resizeOnce` 至不动点后返回 token 数，10 轮未收敛则抛错（[packages/llm/llm-deepseek/src/image-tokens.ts:144-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/image-tokens.ts#L144-L154)）

### packages/llm/llm-deepseek/src/index.ts

插件入口：定义配置 schema、把原始配置解析成连接快照、解析 API key，并把适配器注册到 `ctx.llm` 的 `deepseek-official` 路由上。

- 导出 `name` 与 `inject`，声明插件名并要求先有 `llm` 服务才应用（[packages/llm/llm-deepseek/src/index.ts:83-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L83-L84)）
- 固定设置命名空间、默认凭据环境变量名与本插件独占的路由名（[packages/llm/llm-deepseek/src/index.ts:86-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L86-L89)）
- `DEFAULT_MODELS` 给出默认可见目录：两个文本模型与一个声明 `image` 模态并带像素、字节预算的视觉模型（[packages/llm/llm-deepseek/src/index.ts:91-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L91-L112)）
- `catalogModel` 与 `Config` schema 校验并填默认值，决定 cordis.yml 与设置文档能写什么（[packages/llm/llm-deepseek/src/index.ts:165-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L165-L196)）
- `resolveModels` 拒绝已废弃的 `imageDetail`、空 id、空名、非正整数窗口与上限、空或重复或越界的模态，以及文本模型声明图片预算，并给图片模型填默认像素与字节预算（[packages/llm/llm-deepseek/src/index.ts:213-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L213-L279)）
- `resolveAdapterOptions` 在 `thinking: disabled` 下拒绝任何非 `off` 的努力度（[packages/llm/llm-deepseek/src/index.ts:294-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L294-L298)）
- 逐项复核上下文窗口、输出上限、空闲超时、文件与内联字节上限、张数上限及各步长，并要求步长不超过对应上限（[packages/llm/llm-deepseek/src/index.ts:299-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L299-L356)）
- 复核文件过期秒数区间、刷新余量必须小于过期秒数、配额清理批量 1–1000（[packages/llm/llm-deepseek/src/index.ts:357-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L357-L374)）
- 端点按「配置值 → 启动环境的 `DEEPSEEK_BASE_URL` → 公共 API」依次回退，凭据以引用名而非字面值进入快照（[packages/llm/llm-deepseek/src/index.ts:375-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L375-L401)）
- `apply` 里的 `options()` 按原始配置对象缓存解析结果，解析失败时保留上一份可用快照并各记一次错误日志（[packages/llm/llm-deepseek/src/index.ts:405-427](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L405-L427)）
- `resolveApiKey` 先走凭据服务解析引用，无该服务时退回启动环境，两者皆无抛 `MISSING_CREDENTIAL` 并在消息中指明要设置的引用名（[packages/llm/llm-deepseek/src/index.ts:429-450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L429-L450)）
- 匿名用户 id 首次使用时创建并在插件内缓存复用（[packages/llm/llm-deepseek/src/index.ts:452-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L452-L453)）
- 构造适配器时把附件服务、执行世界路径映射与请求扩展准备都做成请求时解析，扩展服务缺席时退化为空字段与空接受（[packages/llm/llm-deepseek/src/index.ts:454-469](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L454-L469)）
- 把该路由登记为可配置提供方，指向本插件的设置命名空间（[packages/llm/llm-deepseek/src/index.ts:470-472](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L470-L472)）
- 注册适配器占据 `deepseek-official` 路由，并记下注册时捕获的重试策略（[packages/llm/llm-deepseek/src/index.ts:475-476](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L475-L476)）
- 重试策略变化时用 `registration.replace` 在一个同步段内就地重注册，不产生空路由窗口（[packages/llm/llm-deepseek/src/index.ts:477-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L477-L487)）
- 安装设置分区，把配置来源切换到设置快照，并在变更时触发注册事实复核（[packages/llm/llm-deepseek/src/index.ts:489-494](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/index.ts#L489-L494)）

### packages/llm/llm-deepseek/src/invariant.ts

本包的不变量伴生插件，向 `invariants` 服务登记包名。

- 用空安装器登记本包不变量所有权并返回注册的 disposer（[packages/llm/llm-deepseek/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/invariant.ts#L21-L29)）

### packages/llm/llm-deepseek/src/request-pricing.ts

请求图片计价：复现适配器的图片投影与最旧优先卸载，并按视觉 token 公式给每次出现定价，被 `adapter.imageRequestPricing` 同步调用。

- 常量固定文件字节上限 128 MiB、单请求 600 张、常规 640000 像素预算、低细节 512×512 预算与 1 MiB 编码字节目标（[packages/llm/llm-deepseek/src/request-pricing.ts:19-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/request-pricing.ts#L19-L28)）
- `resolveRequestImagePolicy` 把模型的 `imagePixelBudget`（含 `low`）与 `imageMaxBytes` 解析成完整的像素与字节预算（[packages/llm/llm-deepseek/src/request-pricing.ts:36-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/request-pricing.ts#L36-L46)）
- 未登记或未声明 `image` 模态的模型，把每次图片出现都定价为零视觉 token 加纯文本替代（[packages/llm/llm-deepseek/src/request-pricing.ts:53-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/request-pricing.ts#L53-L81)）
- 图片模型先按字节与张数上限、步长算出被卸载的最旧前缀长度（[packages/llm/llm-deepseek/src/request-pricing.ts:84-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/request-pricing.ts#L84-L93)）
- 前缀内的出现定价为占位文本，其余按投影尺寸算视觉 token 并生成句柄文本（[packages/llm/llm-deepseek/src/request-pricing.ts:94-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/request-pricing.ts#L94-L103)）

### packages/llm/llm-deepseek/src/serialize.ts

序列化：把 harness 消息与调用配置转成 DeepSeek chat-completions 请求体，含纯文本与含图两条路径，被 `adapter.ts` 调用。

- `TOOL_RESULT_IMAGE_TEXT` 固定工具结果图片所在用户消息的引导文本（[packages/llm/llm-deepseek/src/serialize.ts:69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L69)）
- `reasoningEffort` 只接受 off/low/high/max，其余抛 `UNSUPPORTED_REASONING_EFFORT`（[packages/llm/llm-deepseek/src/serialize.ts:72-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L72-L80)）
- `resolveThinking` 对 `purpose: 'session-title'` 强制关闭思考；部署禁用思考时拒绝非 `off` 努力度；`off` 映射为 `thinking: disabled` 而不是 wire 上的 effort（[packages/llm/llm-deepseek/src/serialize.ts:83-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L83-L99)）
- `assertTextOnly` 让纯文本路径在遇到图片内容时抛 `UNSUPPORTED_CONTENT` 而不是静默丢弃（[packages/llm/llm-deepseek/src/serialize.ts:110-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L110-L114)）
- `assertSupportedImageRoles` 拒绝非 user 角色携带图片内容（[packages/llm/llm-deepseek/src/serialize.ts:117-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L117-L126)）
- `imageHandle` 在每张图片前插入描述其附件与请求尺寸的文本，若前面已有内容则先加换行（[packages/llm/llm-deepseek/src/serialize.ts:129-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L129-L139)）
- `imageParts` 对未准备的图片抛 `INVALID_REQUEST`，并按表示产出 `file_id` 块或 base64 data URL 块（[packages/llm/llm-deepseek/src/serialize.ts:142-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L142-L162)）
- `contentParts` 丢弃空文本块、给图片按消息内序号编号、递归展开 tool-result，并跳过其他块类型（[packages/llm/llm-deepseek/src/serialize.ts:165-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L165-L190)）
- `userContent` 在全为文本时把各段拼成单个字符串，保持紧凑的 wire 形态（[packages/llm/llm-deepseek/src/serialize.ts:193-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L193-L200)）
- `serializeAssistant` 把助手轮的 content 始终写成字符串（无文本时为空串），并在有推理时回传 `reasoning_content`、有工具调用时写 `tool_calls`（[packages/llm/llm-deepseek/src/serialize.ts:203-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L203-L236)）
- `serializeMessages` 把 user 消息里的 tool-result 拆成独立的 `role: 'tool'` 消息，空工具输出写成 `(no output)`，且仅在有文本或没有工具结果时才发出 user 消息（[packages/llm/llm-deepseek/src/serialize.ts:246-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L246-L275)）
- `serializeMessagesWithImages` 把工具结果里的图片攒起来，在遇到下一条 system/assistant/user 或结束时冲刷成一条带引导文本的 user 消息（[packages/llm/llm-deepseek/src/serialize.ts:285-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L285-L338)）
- `requestWithMessages` 把工具定义映射成 function 形态，固定 `stream: true` 与 `include_usage`，并按需写入 thinking、reasoning_effort、tools、temperature、max_tokens、stop（[packages/llm/llm-deepseek/src/serialize.ts:343-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L343-L371)）
- `serializeRequest` 把系统提示作为首条 system 消息置于历史之前（[packages/llm/llm-deepseek/src/serialize.ts:381-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L381-L392)）
- `serializeRequestWithImages` 在序列化前用已准备版本的确切字节长度再做一次最旧优先卸载，未准备的引用抛 `INVALID_REQUEST`（[packages/llm/llm-deepseek/src/serialize.ts:403-430](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/serialize.ts#L403-L430)）

### packages/llm/llm-deepseek/src/sse.ts

SSE 解码：把响应字节流解成事件 data 载荷序列，被 `adapter.ts` 接到 `translate` 之前。

- 固定终止载荷字面量 `[DONE]`（[packages/llm/llm-deepseek/src/sse.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/sse.ts#L18)）
- `parseSse` 经 `TextDecoderStream` 与 `EventSourceParserStream` 逐个产出 data，注释只经回调上报活动，见到 `[DONE]` 即产出并结束，未见 `[DONE]` 就 EOF 则抛 `STREAM_CLOSED`（[packages/llm/llm-deepseek/src/sse.ts:28-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/sse.ts#L28-L40)）

### packages/llm/llm-deepseek/src/translate.ts

翻译层：把 SSE data 载荷转成 harness 的 `StreamChunk` 序列，含块开合、用量与结束原因，由 `adapter.ts` 直接产出给上层循环。

- `mapFinishReason` 把 stop/tool_calls/length 映射为对应结束语义，其余值映射为带大写 code 的错误结束（[packages/llm/llm-deepseek/src/translate.ts:31-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L31-L43)）
- `mapUsage` 从 `prompt_tokens` 里扣掉缓存命中得到不相交的输入计数，并只在聚合计数自洽且与 wire 总数一致时给出 `totalTokens`，另按需带出缓存读与推理 token（[packages/llm/llm-deepseek/src/translate.ts:54-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L54-L71)）
- `closeBlock` 把累积的块装配成 text、reasoning 或 tool-call 内容块（[packages/llm/llm-deepseek/src/translate.ts:74-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L74-L85)）
- 见到 `[DONE]` 时按开块顺序补齐全部 `block-end`，再产出 usage 与 finish，然后结束（[packages/llm/llm-deepseek/src/translate.ts:110-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L110-L126)）
- 结束原因为 `stop` 且一个块都没开过时，改成带 `EMPTY_RESPONSE` code 的错误结束（[packages/llm/llm-deepseek/src/translate.ts:116-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L116-L125)）
- 载荷 JSON 解析失败时截断前 120 字符抛 `MALFORMED_RESPONSE` 终止流（[packages/llm/llm-deepseek/src/translate.ts:129-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L129-L134)）
- 非空 `reasoning_content` 才开推理块，随后累积并产出 `reasoning-delta`（[packages/llm/llm-deepseek/src/translate.ts:139-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L139-L149)）
- 非空 `content` 才开文本块，随后累积并产出 `text-delta`（[packages/llm/llm-deepseek/src/translate.ts:151-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L151-L159)）
- 工具调用按 wire `index` 分块，首次出现开块，逐片补齐 id 与 name 并累积参数片段产出 `tool-call-delta`（[packages/llm/llm-deepseek/src/translate.ts:161-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L161-L179)）
- 结束原因与用量都暂存不立即产出，用量以最后一次出现为准（[packages/llm/llm-deepseek/src/translate.ts:181-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L181-L188)）
- 载荷流未以 `[DONE]` 结束就耗尽时抛 `STREAM_CLOSED`（[packages/llm/llm-deepseek/src/translate.ts:191-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/translate.ts#L191-L193)）

### packages/llm/llm-deepseek/src/types.ts

chat-completions 的 wire 请求、消息、流式 chunk 与用量的类型声明，被 serialize、translate、adapter 引用。

- 无运行期机制

### packages/llm/llm-deepseek/src/upload-index.ts

本地上传索引：在 DSH home 下用带锁的原子 JSON 文件记录「作用域+变体 → file id」映射，被 `file-store.ts` 读写。

- `deepSeekFileScope` 用端点（去尾斜杠）与 API key 的 SHA-256 摘要作为不落盘密钥的命名空间（[packages/llm/llm-deepseek/src/upload-index.ts:45-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L45-L52)）
- `parseRecord` 逐字段校验作用域、附件 id、变体 id 的摘要格式与非负整数字节和时间戳（[packages/llm/llm-deepseek/src/upload-index.ts:58-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L58-L81)）
- `parseIndex` 只接受 `formatVersion: 3`，并拒绝同一作用域下重复的变体映射（[packages/llm/llm-deepseek/src/upload-index.ts:83-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L83-L105)）
- `reusable` 以「剩余寿命大于刷新余量」判定一条映射是否还可复用（[packages/llm/llm-deepseek/src/upload-index.ts:107-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L107-L109)）
- 索引默认落在 `DSH_HOME/llm-deepseek/files-v3.json`（[packages/llm/llm-deepseek/src/upload-index.ts:119-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L119-L121)）
- `load` 在文件不存在或内容非法时返回空索引，其他 I/O 错误照抛（[packages/llm/llm-deepseek/src/upload-index.ts:123-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L123-L132)）
- `save` 以 0600 文件权限、0700 目录权限原子写入（[packages/llm/llm-deepseek/src/upload-index.ts:134-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L134-L139)）
- `get` 只在命中记录仍满足复用判定时返回，否则视为未命中（[packages/llm/llm-deepseek/src/upload-index.ts:149-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L149-L159)）
- `commit` 在文件锁内复查：已有可复用映射则拒绝候选并返回既有记录，否则剔除过期与同键旧记录后写入候选（[packages/llm/llm-deepseek/src/upload-index.ts:168-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L168-L190)）
- `remove` 在锁内只删除三元组完全匹配的那条，避免误删并发装入的后继映射，且无变化时不落盘（[packages/llm/llm-deepseek/src/upload-index.ts:198-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L198-L211)）
- `clear` 在锁内删除某个作用域下的全部映射，无变化时不落盘（[packages/llm/llm-deepseek/src/upload-index.ts:217-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-deepseek/src/upload-index.ts#L217-L224)）

### packages/llm/llm-deepseek/tsconfig.json

本包的 TypeScript 编译配置，设定源目录、声明输出目录与工作区引用。

- 无运行期机制
