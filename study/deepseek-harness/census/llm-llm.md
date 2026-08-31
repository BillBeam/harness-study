---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/llm/llm
---

# packages/llm/llm

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 17 个文件、139 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/llm/llm/README.md

该包的说明文档，介绍模型调用服务的使用方式、内部实现与已知限制，供使用者和维护者阅读。

- 无运行期机制

### packages/llm/llm/package.json

该包的清单，声明模块类型、入口、导出子路径与依赖。

- `"type": "module"` 与 `main`/`types` 指向 `lib/index.js` 及其声明文件，决定运行期加载哪个产物（[packages/llm/llm/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./types`、`./brand`、`./message`、`./typert`、`./remote`、`./src/*`、`./package.json` 映射到具体文件，限定外部可导入的入口集合（[packages/llm/llm/package.json:16-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/package.json#L16-L47)）
- `files` 列出随包发布的产物文件，未列入的文件不进入安装后的目录（[packages/llm/llm/package.json:48-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/package.json#L48-L57)）
- `dependencies` 声明运行期实际安装的 `dsh-util-crypto`、`schemastery` 与 `zod`，其余能力以 `peerDependencies` 形式要求宿主提供（[packages/llm/llm/package.json:59-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/package.json#L59-L71)）

### packages/llm/llm/src/adapter-failure.ts

把适配器边界上抛出的任意值归一成可序列化的失败事实，供终止 finish 分块携带。

- 非 `Error` 的抛出值被包成 `HarnessError`，code 取 `UNKNOWN`，原值挂在 `cause` 上（[packages/llm/llm/src/adapter-failure.ts:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/adapter-failure.ts#L17-L19)）
- 只有当错误自带的 `failure` 快照通过校验且其 `code` 与错误自身的 `code` 自有属性相等时，才原样采用该快照（[packages/llm/llm/src/adapter-failure.ts:22-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/adapter-failure.ts#L22-L23)）
- 否则返回冻结的 `{ message, code }` 两字段对象（[packages/llm/llm/src/adapter-failure.ts:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/adapter-failure.ts#L24-L27)）
- `String(value)` 被 try/catch 包住，抛出或空串时落到固定文案 `LLM adapter failed`（[packages/llm/llm/src/adapter-failure.ts:31-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/adapter-failure.ts#L31-L38)）
- `code` 与 `failure` 都通过 `Object.getOwnPropertyDescriptor` 读自有数据属性，不触发访问器，读取抛出时返回 `undefined`（[packages/llm/llm/src/adapter-failure.ts:41-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/adapter-failure.ts#L41-L60)）
- 快照校验要求 message/code 为非空字符串、status 为 100–599 的整数、providerRetryAfterMs 为正有限数、requestId 为非空字符串，任一不符即整体作废（[packages/llm/llm/src/adapter-failure.ts:63-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/adapter-failure.ts#L63-L77)）
- 通过校验的快照按可选字段展开后冻结返回（[packages/llm/llm/src/adapter-failure.ts:78-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/adapter-failure.ts#L78-L84)）
- 读 `error.message` 抛出或为空串时回落到 `LLM adapter failed`（[packages/llm/llm/src/adapter-failure.ts:91-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/adapter-failure.ts#L91-L99)）
- 只有 `HarnessError` 实例的 `code` 被采用，其余一律记为 `UNKNOWN`（[packages/llm/llm/src/adapter-failure.ts:102-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/adapter-failure.ts#L102-L104)）

### packages/llm/llm/src/api-key.ts

判定一个供给的 API key 是否可用的共享谓词，被各适配器在把 key 放进 HTTP 头前调用。

- 合法字符集固定为 `\x21-\x7E`（可打印 ASCII，排除空格）（[packages/llm/llm/src/api-key.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/api-key.ts#L15)）
- `normalizeApiKey` 先 `trim`，trim 后为空返回 `empty`，含非法字符返回 `illegalCharacters`，否则返回 trim 后的值（[packages/llm/llm/src/api-key.ts:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/api-key.ts#L36-L41)）

### packages/llm/llm/src/assembler.ts

`BlockAssembler`：把适配器发出的原始流分块增量拼成内容块与一条助手消息，被 agent 循环在记录原始分块的同时喂入。

- `block-start` 为该 index 建立局部块并记入顺序表，同一 index 重复出现时忽略（[packages/llm/llm/src/assembler.ts:50-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L50-L60)）
- `text-delta`/`reasoning-delta` 追加文本，若该 index 已被 `block-end` 关闭则丢弃（[packages/llm/llm/src/assembler.ts:61-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L61-L67)）
- `tool-call-delta` 记录调用 id、在 name 非空时记录名称、并把 `argumentsDelta` 拼接成原始 JSON 字符串（[packages/llm/llm/src/assembler.ts:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L68-L75)）
- `block-end` 写入权威块，首次关闭生效，后续重复关闭被忽略（[packages/llm/llm/src/assembler.ts:76-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L76-L83)）
- `usage` 分块的用量与 `finish` 分块的结束原因、replayState 分别被留存（[packages/llm/llm/src/assembler.ts:84-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L84-L92)）
- 未知分块类型走 `assertNever` 抛出（[packages/llm/llm/src/assembler.ts:93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L93)）
- `ensure` 在没有 `block-start` 的情况下按 delta 类型即时建块，使纯 delta 协议也能拼装（[packages/llm/llm/src/assembler.ts:97-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L97-L105)）
- 未关闭的 tool-call 块在缺 id 时用 `call-${index}` 顶替、缺 name 时用空串，未知块类型直接抛错（[packages/llm/llm/src/assembler.ts:107-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L107-L120)）
- 结束原因为 `max-tokens` 时丢弃全部 tool-call 块（[packages/llm/llm/src/assembler.ts:134-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L134-L139)）
- replay 信封的 `blocks` 条数与全部块数不符时整个信封被丢弃，符合时按同一保留决定裁剪逐块条目（[packages/llm/llm/src/assembler.ts:140-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L140-L148)）
- `interruptedBlocks()` 只保留 text/reasoning 且 trim 后非空的块，其余（含 tool-call 与未知开放块）全部剔除（[packages/llm/llm/src/assembler.ts:168-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L168-L178)）
- 未收到 `finish` 时 `finish` 读作 `{ kind: 'stop' }`（[packages/llm/llm/src/assembler.ts:186-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L186-L188)）
- `message()` 用 `createMessage` 产出 assistant 角色消息，来源默认标为 `{ kind: 'plugin', plugin: 'dsh-llm/assembler' }`（[packages/llm/llm/src/assembler.ts:204-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/assembler.ts#L204-L206)）

### packages/llm/llm/src/attribution.ts

集中定义每次向提供方发请求时携带的 `User-Agent` 身份，被各适配器复用。

- 版本号在模块加载时由 `createRequire` 读取本包 `package.json`（[packages/llm/llm/src/attribution.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/attribution.ts#L16)）
- `APP_IDENTITY` 固定产品名 `deepseek-harness`、上述版本与仓库 URL（[packages/llm/llm/src/attribution.ts:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/attribution.ts#L40-L44)）
- `userAgent()` 按 `product/version (+url)` 拼出头值（[packages/llm/llm/src/attribution.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/attribution.ts#L53-L55)）
- `attributionHeaders()` 返回小写键的 `user-agent` 头，参数缺省时回落到 `APP_IDENTITY`（[packages/llm/llm/src/attribution.ts:64-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/attribution.ts#L64-L68)）

### packages/llm/llm/src/brand.ts

本包持有的若干跨边界 id 的品牌类型与同名断言函数。

- 无运行期机制

### packages/llm/llm/src/call-config.ts

一次会话调用的路由与采样标量的比较、循环归属标记与深冻结工具，被服务与循环共用。

- 进程内 `WeakSet` 记录由 agent 循环组装的请求对象身份（[packages/llm/llm/src/call-config.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/call-config.ts#L13)）
- `callConfigEquals` 逐字段比较 provider/model/reasoningEffort/temperature/maxTokens，并对 `stop` 做逐元素比较（[packages/llm/llm/src/call-config.ts:49-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/call-config.ts#L49-L59)）
- `markAgentLoopRequest`/`isAgentLoopRequest` 写入与查询该标记，使监听者能区分循环请求与手搭请求（[packages/llm/llm/src/call-config.ts:66-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/call-config.ts#L66-L78)）
- `deepFreeze` 用显式待办栈迭代遍历并就地冻结，`WeakSet` 去环，遍历不吃 JS 调用栈深度（[packages/llm/llm/src/call-config.ts:88-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/call-config.ts#L88-L116)）
- 遍历遇到 `AbortSignal` 直接跳过，不冻结取消通道（[packages/llm/llm/src/call-config.ts:104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/call-config.ts#L104)）

### packages/llm/llm/src/content.ts

内容块层面的图片处理：执行世界路径解析、模型可见的图片占位文案，以及按路由预算做的请求图片卸载投影。

- `resolveImageAttachmentAccess` 先取附件宿主路径，再经调用方给的映射转成执行世界路径，任一环节缺失即返回 `undefined`（[packages/llm/llm/src/content.ts:31-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L31-L40)）
- 图片身份文案在有 name 时渲染为带引号的名称加附件 id，无 name 时只渲染 id（[packages/llm/llm/src/content.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L46-L50)）
- 媒体类型到扩展名的固定映射，未知类型走 `assertNever` 抛出（[packages/llm/llm/src/content.ts:52-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L52-L60)）
- 归一化副本文案带上只读路径、宽高、媒体类型，并要求先复制到可写路径再编辑（[packages/llm/llm/src/content.ts:62-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L62-L66)）
- 纯文本模型的图片占位文案取 attachmentId 中 `sha256:` 之后的 8 位摘要（[packages/llm/llm/src/content.ts:73-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L73-L76)）
- `requestImageHandleText` 输出图片身份加请求预览尺寸，按是否解析出访问路径给出两种不同尾文（[packages/llm/llm/src/content.ts:88-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L88-L97)）
- `offloadedImageText` 在无可用本地路径时提示请用户重新附加，有路径时附上归一化副本文案（[packages/llm/llm/src/content.ts:105-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L105-L114)）
- `contentHasImage` 递归下探 tool-result 内容判断是否含图片（[packages/llm/llm/src/content.ts:124-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L124-L127)）
- 字节计量按策略选原始字节或 base64 长度（`ceil(bytes/3)*4`），字节来源可由策略的 `byteLength` 覆盖，否则取附件字节数（[packages/llm/llm/src/content.ts:130-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L130-L168)）
- `replaceOldestImages` 按请求顺序把前若干个图片出现替换成占位文本块，递归进入 tool-result，且只在发生替换时才复制数组（[packages/llm/llm/src/content.ts:171-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L171-L195)）
- `replaceImagesForTextModel` 把全部图片出现（含嵌套 tool-result）换成纯文本占位（[packages/llm/llm/src/content.ts:198-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L198-L217)）
- `projectImagesForTextModel` 在历史中没有图片时原样返回，否则只对含图片的消息做浅拷贝替换（[packages/llm/llm/src/content.ts:224-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L224-L230)）
- `offloadedImagePrefixCount` 由超出的张数与字节数分别按 `countQuantum`/`byteQuantum` 向上取整成移除目标，再沿请求顺序累加直到两项目标都满足（[packages/llm/llm/src/content.ts:241-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L241-L263)）
- `offloadRequestImagesWithPolicy` 先收集全部图片长度算出前缀数，为 0 时原样返回消息，否则产出替换后的浅拷贝（[packages/llm/llm/src/content.ts:276-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/content.ts#L276-L289)）

### packages/llm/llm/src/error.ts

错误基类与提供方无关的失败判据、错误链渲染，被服务、适配器与消费方共用。

- `HarnessError` 携带稳定的 `code`，并把 `name` 设为子类构造器名（[packages/llm/llm/src/error.ts:13-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/error.ts#L13-L22)）
- 四个规范码常量 `CONTEXT_WINDOW_EXCEEDED`、`QUOTA`、`EMPTY_RESPONSE`、`INVALID_CREDENTIAL` 在此定义（[packages/llm/llm/src/error.ts:25-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/error.ts#L25-L48)）
- `isContextWindowExceededError` 用五组正则识别上下文溢出措辞，命中即判定为超出上下文窗口（[packages/llm/llm/src/error.ts:51-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/error.ts#L51-L86)）
- `isQuotaExceededError` 用五条正则把额度/余额/信用耗尽与瞬时限速区分开（[packages/llm/llm/src/error.ts:94-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/error.ts#L94-L100)）
- `errorChain` 递归展开 `cause` 链与 `AggregateError` 成员，用活动路径集合识别真环并渲染成 `<circular cause>`（[packages/llm/llm/src/error.ts:114-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/error.ts#L114-L141)）
- 与包裹层文案完全相同的 cause 不再重复渲染；非 Error 对象读其自有 `message` 数据属性，否则 `String()`（[packages/llm/llm/src/error.ts:122-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/error.ts#L122-L140)）
- 渲染中任一节点抛出被就地捕获成 `<unrenderable value>`，不影响链上其余节点（[packages/llm/llm/src/error.ts:142-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/error.ts#L142-L151)）
- `isHarnessError` 只对真实实例收窄，鸭子类型或跨 realm 错误不通过（[packages/llm/llm/src/error.ts:161-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/error.ts#L161-L163)）

### packages/llm/llm/src/index.ts

`LlmRuntime` 服务本体：适配器注册表、可配置提供方目录、模型发现与解析、调用准备，以及经 `llm/stream` 瀑布的流式派发边界。

- 声明合并把 `ctx.llm` 挂到 Cordis 上下文，并声明 `llm/stream` 瀑布事件（[packages/llm/llm/src/index.ts:49-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L49-L70)）
- `LlmError` 构造时校验 message/code 非空、status 为 100–599 整数、providerRetryAfterMs 为正有限数、requestId 非空，任一不符直接抛普通 `Error`（[packages/llm/llm/src/index.ts:96-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L96-L109)）
- `LlmError` 把可序列化的 `failure` 冻结挂在实例上，供跨包传递（[packages/llm/llm/src/index.ts:110-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L110-L119)）
- `assertUsableApiKey` 在 key 为空或含非法字符时抛 `INVALID_CREDENTIAL`，诊断文案只提凭据引用位置，不回显 key 本身（[packages/llm/llm/src/index.ts:140-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L140-L155)）
- `LlmAdapter` 的 `providerInfo` 默认把路由名同时当 id 与显示名（[packages/llm/llm/src/index.ts:199-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L199-L201)）
- `providerRetryPolicy` 与 `imageRequestPricing` 默认返回 `undefined`，`listModels` 默认返回空表（[packages/llm/llm/src/index.ts:208-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L208-L234)）
- `resolveModel` 默认把 provider/model 原样回填成模型元数据（[packages/llm/llm/src/index.ts:245-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L245-L251)）
- `prepareCall` 默认实现把 `resolveModel` 结果与 `stream` 绑成一个代次（[packages/llm/llm/src/index.ts:262-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L262-L267)）
- `emitAdaptersUpdated` 逐个调用监听器并各自捕获异常，异步返回值的拒绝也被吞成告警（[packages/llm/llm/src/index.ts:339-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L339-L362)）
- 只有 code 为 `INVARIANT` 的监听器异常会在全部监听器跑完后被重新抛出（[packages/llm/llm/src/index.ts:356-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L356-L363)）
- 被吞掉的监听器失败经 `ctx.logger.warn` 输出两行告警（[packages/llm/llm/src/index.ts:367-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L367-L370)）
- `registerAdapter` 通过 `ctx.effect` 注册，空路由列表抛 `INVALID_ADAPTER`，其 disposer 删除所持路由并发出更新通知（[packages/llm/llm/src/index.ts:387-396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L387-L396)）
- 已释放的注册再调用 `replace` 抛 `REGISTRATION_DISPOSED`，否则整体重新提交路由（[packages/llm/llm/src/index.ts:400-407](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L400-L407)）
- `prepareRoutes` 先整体校验候选路由：空名抛 `INVALID_ADAPTER`，与他人重名或集合内重复抛 `DUPLICATE_ADAPTER`，`providerInfo` 未保持 id 或名称为空抛 `INVALID_ADAPTER`，全程不改注册表（[packages/llm/llm/src/index.ts:416-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L416-L438)）
- 每条路由在注册时捕获适配器给出的重试策略，缺省时用 `resolveRetryPolicy(undefined, …)` 解析出的默认策略（[packages/llm/llm/src/index.ts:429-435](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L429-L435)）
- `commitRoutes` 在一个同步段内先删旧路由再写新路由，最后发出 `llm/adapters-updated`（[packages/llm/llm/src/index.ts:447-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L447-L455)）
- `listProviders` 标注 `@Remote`，按注册顺序返回分离出的副本（[packages/llm/llm/src/index.ts:461-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L461-L464)）
- 可配置提供方提交先整体校验：字段为空抛 `INVALID_DIRECTORY`，`settingsPath` 含空段抛 `INVALID_DIRECTORY`，与他人或集合内重复抛 `DUPLICATE_DIRECTORY`（[packages/llm/llm/src/index.ts:484-497](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L484-L497)）
- 校验通过后条目被拷贝（含 `settingsPath` 数组）写入目录并发出更新通知（[packages/llm/llm/src/index.ts:498-504](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L498-L504)）
- 首次注册若条目为空抛 `INVALID_DIRECTORY`；disposer 摘除全部条目并发出通知；释放后再 `replace` 抛 `REGISTRATION_DISPOSED`（[packages/llm/llm/src/index.ts:506-525](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L506-L525)）
- `listConfigurableProviders` 标注 `@Remote`，按声明顺序返回深拷贝了 `settingsPath` 的条目（[packages/llm/llm/src/index.ts:533-536](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L533-L536)）
- `registerModelDiscovery` 以设置命名空间为键登记发现函数，空命名空间抛 `INVALID_DISCOVERY`，重复登记抛 `DUPLICATE_DISCOVERY`，disposer 删除该键（[packages/llm/llm/src/index.ts:555-566](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L555-L566)）
- `discoverModels` 未登记命名空间抛 `NO_DISCOVERY`，请求既无 provider 又无 baseURL 抛 `INVALID_DISCOVERY`（[packages/llm/llm/src/index.ts:585-593](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L585-L593)）
- 发现结果按 id 去重、丢弃非字符串或空 id，并只保留 id/name/contextWindow/maxTokens 四个字段（[packages/llm/llm/src/index.ts:597-609](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L597-L609)）
- `@Remote('discoverModels')` 包装把任何失败转成带 `model-discovery-failed` 码与 settingsNs/baseURL 明细的 `TypertRemoteFailure`（[packages/llm/llm/src/index.ts:620-638](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L620-L638)）
- `providerRetryPolicy(provider)` 读取注册时捕获的策略，未注册路由经 `registration()` 抛 `NO_ADAPTER`（[packages/llm/llm/src/index.ts:645-647](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L645-L647)）
- `imageRequestPricing` 对未注册提供方返回 `undefined` 而不抛错（[packages/llm/llm/src/index.ts:658-660](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L658-L660)）
- `listModels` 校验适配器返回的每条目录项（provider 必须自洽、id/name 非空、description 类型正确、id 不重复），不合规抛 `INVALID_CATALOG`，并逐条重建分离副本（[packages/llm/llm/src/index.ts:673-700](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L673-L700)）
- `normalizeModelInfo` 校验精确模型的 provider/id/name/description，不符抛 `INVALID_MODEL_INFO`（[packages/llm/llm/src/index.ts:735-748](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L735-L748)）
- `contextWindow` 必须为正整数，否则抛 `INVALID_MODEL_CONTEXT`（[packages/llm/llm/src/index.ts:749-755](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L749-L755)）
- `defaultMaxTokens` 必须为正的安全整数，否则抛 `INVALID_MODEL_MAX_TOKENS`；输入模态被分离后原样带出（[packages/llm/llm/src/index.ts:756-775](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L756-L775)）
- 推理档位为空表、条目无效或 id 重复抛 `INVALID_MODEL_REASONING`，`defaultEffort` 不在档位集合内同样抛该码（[packages/llm/llm/src/index.ts:776-818](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L776-L818)）
- `resolveCallWithInfo` 在请求未给 `maxTokens` 且模型有 `defaultMaxTokens` 时把它填入配置（[packages/llm/llm/src/index.ts:849-851](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L849-L851)）
- 模型不暴露推理能力却显式指定档位时抛 `UNSUPPORTED_REASONING_EFFORT`（[packages/llm/llm/src/index.ts:855-861](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L855-L861)）
- 有效档位取请求值否则取适配器默认值，不在支持集合内抛 `UNSUPPORTED_REASONING_EFFORT`，与请求值不同则写回配置（[packages/llm/llm/src/index.ts:862-873](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L862-L873)）
- `prepareCall` 把注册项、适配器代次、模型元数据与解析后的配置绑在一起，配置与上下文经 `structuredClone` + `deepFreeze` 分离（[packages/llm/llm/src/index.ts:889-897](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L889-L897)）
- `adapterDefaults` 标出 reasoningEffort/maxTokens 哪些是适配器补上的而非调用方提出的（[packages/llm/llm/src/index.ts:898-905](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L898-L905)）
- 已准备的调用只能派发一次，重复派发或派发时配置与准备时不一致抛 `INVALID_PREPARED_CALL`（[packages/llm/llm/src/index.ts:915-925](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L915-L925)）
- `registration()` 对未注册的 provider 抛 `NO_ADAPTER`（[packages/llm/llm/src/index.ts:936-940](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L936-L940)）
- `forAdapter` 在历史 assistant 消息的来源 provider 当前不由同一适配器实例持有时，剥掉其 `replayState` 再发给适配器；全部消息未变时原样返回（[packages/llm/llm/src/index.ts:943-956](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L943-L956)）
- `adapterStream` 在未预备时现场解析适配器代次与模型元数据并解析调用配置（[packages/llm/llm/src/index.ts:969-983](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L969-L983)）
- 预备派发时若请求配置与预备配置不符抛 `INVALID_PREPARED_CALL`（[packages/llm/llm/src/index.ts:984-989](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L984-L989)）
- 解析后的配置字段覆盖回请求对象，原请求被冻结时覆盖结果同样深冻结（[packages/llm/llm/src/index.ts:990-994](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L990-L994)）
- 模型显式声明输入模态且不含 `image`、而历史含图片时，消息在派发前被投影成纯文本占位（[packages/llm/llm/src/index.ts:995-1001](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L995-L1001)）
- 适配器选择、准备、派发与迭代器构造阶段的抛出被转成一个终止 finish 分块后结束流（[packages/llm/llm/src/index.ts:1002-1007](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L1002-L1007)）
- 迭代过程中的抛出同样被转成终止 finish 分块，而 yield 之后由消费方或中间件恢复进来的异常保持抛出（[packages/llm/llm/src/index.ts:1010-1030](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L1010-L1030)）
- 流未正常结束时在 `finally` 里调用底层迭代器的 `return()` 收尾（[packages/llm/llm/src/index.ts:1031-1036](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L1031-L1036)）
- 每次流式调用都经 `ctx.waterfall(this, 'llm/stream', options, …)` 走一遍监听链，`next()` 才到达适配器流（[packages/llm/llm/src/index.ts:1054-1064](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L1054-L1064)）
- 终止分块在 `signal.aborted` 或失败码为 `ABORTED` 时记 `aborted`，否则记 `error`（[packages/llm/llm/src/index.ts:1068-1076](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L1068-L1076)）
- 模块默认导出 `LlmRuntime`，即 Loader 挂载的服务类（[packages/llm/llm/src/index.ts:1091](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/index.ts#L1091)）

### packages/llm/llm/src/invariant.ts

本包的不变量伴随插件，在 `invariants` 服务上登记，对每条提供方流做语法校验。

- 插件名 `llm-invariant`，注入 `invariants` 服务（[packages/llm/llm/src/invariant.ts:10-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L10-L12)）
- 块下标必须是非负安全整数，否则报违规（[packages/llm/llm/src/invariant.ts:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L15-L19)）
- 各类 delta 必须落在同类型且仍开放的块上，否则报违规（[packages/llm/llm/src/invariant.ts:22-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L22-L33)）
- 终止 `finish` 之后再出现任何分块即报违规（[packages/llm/llm/src/invariant.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L44)）
- 同一下标重复 `block-start`、`block-end` 指向无开放块的下标、或 `block-end` 关闭的类型与开放类型不符，均报违规（[packages/llm/llm/src/invariant.ts:46-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L46-L69)）
- `usage` 出现一次以上报违规（[packages/llm/llm/src/invariant.ts:70-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L70-L73)）
- 在非 error/aborted 的结束原因下仍有开放块时报违规；流结束却没有终止 `finish` 也报违规（[packages/llm/llm/src/invariant.ts:74-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L74-L83)）
- 以 `global` + `prepend` 的方式挂上 `llm/stream`，把每条流包成校验生成器后再往下传（[packages/llm/llm/src/invariant.ts:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L88)）
- 监听 `llm/adapters-updated`，服务仍在时逐个提供方读取重试策略，读取抛出即报违规（[packages/llm/llm/src/invariant.ts:89-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L89-L103)）
- `apply` 以包名向 `ctx.invariants` 登记安装器并返回其 disposer（[packages/llm/llm/src/invariant.ts:111-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/invariant.ts#L111-L112)）

### packages/llm/llm/src/message.ts

消息的值类型与不可变构造函数，被投递、持久历史与模型请求共用。

- `CONTEXT_SUMMARY_MAX_CHARS` 定为 120，`boundContextSummary` 超长时截断并补省略号（[packages/llm/llm/src/message.ts:113-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/message.ts#L113-L124)）
- `freezeMessage` 先 `structuredClone` 再 `deepFreeze`，把消息从调用方对象上脱开（[packages/llm/llm/src/message.ts:170-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/message.ts#L170-L172)）
- `createMessage` 用 `randomUUID()` 生成 `MessageId` 并在发布前冻结（[packages/llm/llm/src/message.ts:179-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/message.ts#L179-L186)）
- `createUserMessage` 固定 `role: 'user'`（[packages/llm/llm/src/message.ts:193-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/message.ts#L193-L200)）
- `createAssistantMessage` 固定 `role: 'assistant'` 并把来源打上 `kind: 'model'`（[packages/llm/llm/src/message.ts:207-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/message.ts#L207-L218)）
- `createToolResultMessage` 产出一条 user 角色消息，内容恰为一个带 `toolCallId` 与 `isError` 的 tool-result 块，来源记为 `{ kind: 'tool', callId }`（[packages/llm/llm/src/message.ts:232-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/message.ts#L232-L242)）

### packages/llm/llm/src/never.ts

封闭联合的穷尽性辅助函数，被本包各 switch 的 default 分支调用。

- `assertNever` 在运行期总是抛错，消息里带上 `JSON.stringify` 或 `String()` 渲染出的越界值与可选上下文标签（[packages/llm/llm/src/never.ts:16-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/never.ts#L16-L21)）

### packages/llm/llm/src/retry-policy.ts

提供方自有的重试策略配置、校验与解析，注册路由时被捕获，由可选的重试插件执行。

- 默认值固定为 5 次重试、初始 500ms、上限 10000ms、抖动比 0.1（[packages/llm/llm/src/retry-policy.ts:14-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/retry-policy.ts#L14-L17)）
- 默认可重试码集合为 `EMPTY_RESPONSE`、`RATE_LIMIT`、`SERVER`、`TIMEOUT`、`TRANSPORT`，且被冻结（[packages/llm/llm/src/retry-policy.ts:18-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/retry-policy.ts#L18-L24)）
- 导出的 schemastery 模式给各字段设默认值并把延迟上限卡在 `MAX_TIMER_DELAY_MS`、抖动比卡在 0–1，供具体提供方配置内嵌（[packages/llm/llm/src/retry-policy.ts:81-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/retry-policy.ts#L81-L103)）
- 键白名单加 `validateKeys` 使任何未知键抛错（[packages/llm/llm/src/retry-policy.ts:105-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/retry-policy.ts#L105-L119)）
- `resolveBackoff` 校验初始与上限延迟为正有限且不超过定时器上限、初始不大于上限、抖动比在 0–1，通过后冻结返回（[packages/llm/llm/src/retry-policy.ts:121-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/retry-policy.ts#L121-L141)）
- 未提供配置时直接给出 normal 模式的默认策略（[packages/llm/llm/src/retry-policy.ts:153-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/retry-policy.ts#L153-L160)）
- normal 模式校验 `maxRetries` 为非负安全整数、`retryableCodes` 非空、元素为非空字符串且无重复，结果冻结（[packages/llm/llm/src/retry-policy.ts:163-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/retry-policy.ts#L163-L185)）
- always 模式只解析退避参数并冻结，容忍残留的 normal 专属键（[packages/llm/llm/src/retry-policy.ts:186-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/retry-policy.ts#L186-L191)）
- mode 既非 `normal` 也非 `always` 时抛错（[packages/llm/llm/src/retry-policy.ts:192-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm/src/retry-policy.ts#L192-L193)）

### packages/llm/llm/src/types.ts

与提供方无关的消息、内容块、流分块与请求类型词汇表，只含类型声明。

- 无运行期机制

### packages/llm/llm/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、声明产物目录与工程引用。

- 无运行期机制
