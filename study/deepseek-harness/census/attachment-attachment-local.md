---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/attachment/attachment-local
---

# packages/attachment/attachment-local

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、93 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/attachment/attachment-local/README.md

包 README，说明本地存储位置、默认限额表、归一化与请求投影行为以及已知限制。

- 无运行期机制

### packages/attachment/attachment-local/package.json

包清单，声明模块类型、入口、发布内容与运行期依赖。

- `"type": "module"` 使该包以 ESM 方式被加载（[packages/attachment/attachment-local/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/package.json#L13)）
- `main`/`types`/`exports` 把 `.`、`./invariant`、`./src/*`、`./package.json` 映射到具体产物路径（[packages/attachment/attachment-local/package.json:14-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/package.json#L14-L21)）
- `files` 限定发布物只含 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/attachment/attachment-local/package.json:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/package.json#L22)）
- `dependencies` 把 `sharp` 与 schemastery 列为运行期依赖，实际编解码由该原生库承担（[packages/attachment/attachment-local/package.json:30-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/package.json#L30-L33)）

### packages/attachment/attachment-local/src/compression-limiter.ts

实例级的 FIFO 并发限流器，被本地存储用于包裹每一次原生图像变换。

- 构造参数 `concurrency` 作为同时活跃任务上限保留在实例上（[packages/attachment/attachment-local/src/compression-limiter.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/compression-limiter.ts#L11)）
- `start` 占用一个槽位，并定义结算时释放槽位并弹出等待队首执行的 `release`（[packages/attachment/attachment-local/src/compression-limiter.ts:20-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/compression-limiter.ts#L20-L25)）
- 任务经 `Promise.resolve().then(task)` 执行，成功与失败都先释放槽位再传递结果，非 Error 的拒绝值被包成带 `cause` 的 Error（[packages/attachment/attachment-local/src/compression-limiter.ts:26-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/compression-limiter.ts#L26-L37)）
- 活跃数未达上限直接启动，否则把启动函数压入等待队列（[packages/attachment/attachment-local/src/compression-limiter.ts:39-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/compression-limiter.ts#L39-L40)）

### packages/attachment/attachment-local/src/encoding.ts

归一化与请求投影共用的质量阶梯与惰性候选执行。

- 质量阶梯固定为 `[85, 75, 60]`（[packages/attachment/attachment-local/src/encoding.ts:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/encoding.ts#L6)）
- 有损 WebP 的 `effort` 固定为 0（[packages/attachment/attachment-local/src/encoding.ts:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/encoding.ts#L8)）
- `encode` 按媒体类型走 webp 或 jpeg 编码，并从 `toBuffer` 结果取回实际宽高（[packages/attachment/attachment-local/src/encoding.ts:18-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/encoding.ts#L18-L24)）
- `encodingLadder` 按有无 alpha 选定 webp 或 jpeg，并为每档质量生成一个克隆 pipeline 的惰性编码器（[packages/attachment/attachment-local/src/encoding.ts:33-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/encoding.ts#L33-L38)）
- `encodeFirstWithinLimit` 空候选列表时抛错（[packages/attachment/attachment-local/src/encoding.ts:60-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/encoding.ts#L60-L61)）
- 按顺序执行候选，命中 `maxBytes` 立即返回，否则一路记录字节最小的候选并作为 `{ smallest }` 返回（[packages/attachment/attachment-local/src/encoding.ts:62-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/encoding.ts#L62-L71)）
- `isExhaustedEncoding` 以是否含 `smallest` 字段区分两种结果（[packages/attachment/attachment-local/src/encoding.ts:79-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/encoding.ts#L79-L83)）

### packages/attachment/attachment-local/src/image.ts

栅格检查：准入时全量解码，校验读取时只探测文件头。

- `encodedAlphaIsCompatible` 允许源 alpha 未知、输出与源一致、或 WebP 输出丢掉全不透明 alpha 三种情况（[packages/attachment/attachment-local/src/image.ts:35-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/image.ts#L35-L42)）
- `MEDIA_TYPES` 把 sharp 报告的 png/jpeg/webp/gif 四种格式映射为媒体类型（[packages/attachment/attachment-local/src/image.ts:44-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/image.ts#L44-L49)）
- `carriesRetainedMetadata` 按 exif/xmp/iptc/icc/hasProfile/tifftagPhotoshop/comments/orientation 任一存在判定携带元数据（[packages/attachment/attachment-local/src/image.ts:51-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/image.ts#L51-L60)）
- 格式不在映射表内时抛 `INVALID_IMAGE`（[packages/attachment/attachment-local/src/image.ts:64-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/image.ts#L64-L67)）
- EXIF orientation 大于等于 5 时对调上报的宽高，并按 `pages > 1` 判定多帧（[packages/attachment/attachment-local/src/image.ts:70-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/image.ts#L70-L80)）
- `probeImage` 以 `failOn: 'error'`、不限输入像素读取头部，非 AttachmentError 一律包成 `INVALID_IMAGE`（[packages/attachment/attachment-local/src/image.ts:91-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/image.ts#L91-L98)）
- `detectImage` 在总像素超限时抛 `IMAGE_TOO_MANY_PIXELS`（[packages/attachment/attachment-local/src/image.ts:118-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/image.ts#L118-L120)）
- 单边超过 `maxDimension` 时抛 `IMAGE_DIMENSION_TOO_LARGE`（[packages/attachment/attachment-local/src/image.ts:121-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/image.ts#L121-L123)）
- 限额通过后调用 `raw().toBuffer()` 完整解码栅格，解码失败包成 `INVALID_IMAGE`（[packages/attachment/attachment-local/src/image.ts:124-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/image.ts#L124-L129)）

### packages/attachment/attachment-local/src/index.ts

插件入口：`LocalAttachmentStore` 服务实现、`Config` 模式与全部默认值，并对请求变体做进程内去重。

- 一组导出常量给出源限额、归一化预算与压缩并发的默认值和并发上限（[packages/attachment/attachment-local/src/index.ts:28-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L28-L52)）
- `abortReason` 把非 Error 的取消原因包成带 `cause` 的 Error（[packages/attachment/attachment-local/src/index.ts:81-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L81-L86)）
- `SharedRequest` 用自有 `AbortController` 启动一次共享工作，并在结算时置位 `settled`（[packages/attachment/attachment-local/src/index.ts:88-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L88-L98)）
- `wait` 先响应已取消信号再计入等待者；无信号时结算即释放（[packages/attachment/attachment-local/src/index.ts:100-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L100-L107)）
- 带信号时监听 abort：取消只让本等待者以取消原因失败，成功或失败路径都摘除监听并释放（[packages/attachment/attachment-local/src/index.ts:114-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L114-L131)）
- `release` 只在最后一个等待者取消且共享工作尚未结算时才中止共享控制器（[packages/attachment/attachment-local/src/index.ts:134-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L134-L139)）
- `Config` 模式为每个限额字段声明整数下限并绑定默认值，并把压缩并发限制在 1 到 8（[packages/attachment/attachment-local/src/index.ts:144-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L144-L156)）
- 构造时把存储根解析为 `<DSH_HOME>/attachments/v1`（[packages/attachment/attachment-local/src/index.ts:170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L170)）
- `imageLimits` 冻结为配置值或默认值，接受的媒体类型固定为 png/jpeg/webp/gif 四种（[packages/attachment/attachment-local/src/index.ts:171-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L171-L178)）
- `normalizationPolicy` 冻结总像素预算、长边上限与编码字节目标（[packages/attachment/attachment-local/src/index.ts:179-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L179-L183)）
- 压缩并发非 1..8 的安全整数时构造直接抛错，否则据此建立实例级限流器（[packages/attachment/attachment-local/src/index.ts:184-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L184-L193)）
- `validateImage` 在限流器内跑完整的 `validateImageFile`（[packages/attachment/attachment-local/src/index.ts:196-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L196-L198)）
- `saveImages` 覆盖基类：先整批校验，再并发（受限流）准备全部成员，最后按序逐个提交（[packages/attachment/attachment-local/src/index.ts:200-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L200-L208)）
- `saveImage` 单条走同样的准备加提交两步（[packages/attachment/attachment-local/src/index.ts:210-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L210-L215)）
- `readImage` 转发给带校验的 `readImageFile` 并透传取消信号（[packages/attachment/attachment-local/src/index.ts:217-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L217-L219)）
- `imageHostPath` 覆盖基类默认，返回归一化对象在宿主文件系统中的绝对路径（[packages/attachment/attachment-local/src/index.ts:221-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L221-L223)）
- `requestVersion` 以 `variantId` 为键做在途去重：已被中止的条目先从表里剔除，再新建共享请求（[packages/attachment/attachment-local/src/index.ts:239-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L239-L247)）
- 共享请求在限流器内读取归一化字节并生成请求版本，结算后把自己从在途表中移除（[packages/attachment/attachment-local/src/index.ts:248-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L248-L263)）
- 服务类作为默认导出，成为可被 Loader 挂载的插件形态（[packages/attachment/attachment-local/src/index.ts:268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/index.ts#L268)）

### packages/attachment/attachment-local/src/invariant.ts

包自带的不变量伴生插件，向 `invariants` 服务登记本包名。

- 插件名与 `inject = ['invariants', 'attachments']` 决定它在两个服务都就绪后才激活（[packages/attachment/attachment-local/src/invariant.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/invariant.ts#L9-L11)）
- installer 为空函数，登记后不安装任何运行期检查（[packages/attachment/attachment-local/src/invariant.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/invariant.ts#L13)）
- `apply` 调用 `ctx.invariants.register` 占用包名并返回注销函数（[packages/attachment/attachment-local/src/invariant.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/invariant.ts#L19)）

### packages/attachment/attachment-local/src/normalization.ts

把准入的源图确定性地转成持久化的归一化版本，被写入路径调用。

- `canPassThroughNormalization` 要求非 GIF、单帧、无元数据、8 位、sRGB，且字节、总像素、长边都在策略内才允许原样直通（[packages/attachment/attachment-local/src/normalization.ts:35-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/normalization.ts#L35-L48)）
- `verifyNormalizedImage` 对产物重新全量解码，媒体类型、宽高、帧数、元数据、深度、色彩空间或 alpha 任一不符即抛 `ATTACHMENT_WRITE_FAILED`（[packages/attachment/attachment-local/src/normalization.ts:51-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/normalization.ts#L51-L70)）
- `preparedPipeline` 依次施加 `rotate()`、转 sRGB、以 `fit: inside` 且不放大的方式缩放（[packages/attachment/attachment-local/src/normalization.ts:73-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/normalization.ts#L73-L78)）
- `initialDimensions` 先套总像素预算，再在长边超限时按比例二次缩小，保持宽高比（[packages/attachment/attachment-local/src/normalization.ts:81-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/normalization.ts#L81-L90)）
- 满足直通条件时原字节连同解码得到的媒体类型与宽高原样返回，不再编码（[packages/attachment/attachment-local/src/normalization.ts:108-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/normalization.ts#L108-L110)）
- 否则按目标尺寸跑质量阶梯，全部超标时取最小输出，并按 GIF 与否决定是否传入期望 alpha 后做产物校验（[packages/attachment/attachment-local/src/normalization.ts:111-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/normalization.ts#L111-L118)）
- 非 AttachmentError 的失败被包成 `ATTACHMENT_WRITE_FAILED`，消息里按位深与媒体类型拼出源描述（[packages/attachment/attachment-local/src/normalization.ts:119-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/normalization.ts#L119-L129)）

### packages/attachment/attachment-local/src/request-image.ts

按路由策略派生并缓存模型请求用的图片版本，被存储服务的请求投影路径调用。

- 变换版本常量 `request-image-v5` 参与每个缓存与上传标识（[packages/attachment/attachment-local/src/request-image.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L25)）
- `checkedInteger` 与 `validatePolicy` 要求 `maxPixels`、`maxBytes` 均为正安全整数，否则抛 `INVALID_ATTACHMENT_REF`（[packages/attachment/attachment-local/src/request-image.ts:42-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L42-L52)）
- `descriptor` 把变换版本、附件 id、像素与字节预算、质量阶梯、WebP effort、编码顺序与色彩空间序列化成一个 JSON（[packages/attachment/attachment-local/src/request-image.ts:54-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L54-L68)）
- `requestImageVariantId` 对该描述取 sha256 得到 `sha256:` 前缀的变体标识（[packages/attachment/attachment-local/src/request-image.ts:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L76-L81)）
- 请求管线固定转 sRGB 并以 `fit: inside` 不放大缩放（[packages/attachment/attachment-local/src/request-image.ts:83-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L83-L90)）
- `createRequestImage` 在投影尺寸与原尺寸相同且字节已达标时直接复用存储字节，否则跑质量阶梯并在全部超标时取最小输出（[packages/attachment/attachment-local/src/request-image.ts:92-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L92-L113)）
- 缓存文件按变体哈希前两位分桶存放在 `request-images/` 下（[packages/attachment/attachment-local/src/request-image.ts:115-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L115-L117)）
- `readCached` 对缓存字节做头部探测，位深、色彩空间、尺寸上界或 alpha 不符即当作未命中；ENOENT 直接未命中，其余错误先响应取消再当未命中（[packages/attachment/attachment-local/src/request-image.ts:119-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L119-L139)）
- `verifyRequestImage` 对新编码结果全量解码比对，任一项不符抛 `ATTACHMENT_WRITE_FAILED`（[packages/attachment/attachment-local/src/request-image.ts:141-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L141-L155)）
- `writeCached` 以 0700 建目录、用随机后缀临时文件 `wx` 0600 写入后 rename，并在 finally 里强制删除临时文件（[packages/attachment/attachment-local/src/request-image.ts:157-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L157-L166)）
- `readRequestImageFile` 先响应取消并校验策略，再探测源字节以取得 alpha 事实（[packages/attachment/attachment-local/src/request-image.ts:182-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L182-L184)）
- 命中缓存则直接采用，未命中则生成；与源字节同一引用的直通结果跳过再次校验（[packages/attachment/attachment-local/src/request-image.ts:185-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L185-L192)）
- 写盘前再次响应取消，且只有在未命中缓存且结果不是源字节直通时才写缓存（[packages/attachment/attachment-local/src/request-image.ts:193-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L193-L194)）
- 返回的请求描述携带变体 id、来源引用、字节、实际宽高，并把 `depth` 与 `space` 固定标为 `uchar`/`srgb`（[packages/attachment/attachment-local/src/request-image.ts:195-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/request-image.ts#L195-L206)）

### packages/attachment/attachment-local/src/store.ts

内容寻址的本地写入与带校验读取，被本地存储服务的保存、读取与宿主路径推导调用。

- 附件 id 必须匹配 `sha256:` 加 64 位十六进制的形态（[packages/attachment/attachment-local/src/store.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L22)）
- 模块级 `durableHomes` 集合记录本进程已完成持久化证明的 home（[packages/attachment/attachment-local/src/store.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L23)）
- `displayName` 同时按 `/` 与 `\` 取叶名、删除控制字符、截断到 255，空串归为 undefined（[packages/attachment/attachment-local/src/store.ts:29-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L29-L37)）
- `ensureReference` 对不匹配的引用抛 `INVALID_ATTACHMENT_REF`（[packages/attachment/attachment-local/src/store.ts:39-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L39-L43)）
- `normalizedImagePath` 把对象定位到 `objects/<前两位>/<sha256>`（[packages/attachment/attachment-local/src/store.ts:51-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L51-L54)）
- `inspectMetadata` 空字节抛 `INVALID_IMAGE`，带限额全量解码，声明媒体类型与解码结果不符抛 `IMAGE_TYPE_MISMATCH`（[packages/attachment/attachment-local/src/store.ts:56-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L56-L65)）
- `validateImageFile` 直接跑一遍完整准备流程但不落盘（[packages/attachment/attachment-local/src/store.ts:76-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L76-L82)）
- `prepareImageFile` 首先按 `maxImageBytes` 拒绝超大源并抛 `IMAGE_TOO_LARGE`（[packages/attachment/attachment-local/src/store.ts:104-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L104-L106)）
- 归一化后以其字节 sha256 作为 `attachmentId`，写入媒体类型、宽高、字节数与清洗过的显示名（[packages/attachment/attachment-local/src/store.ts:107-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L107-L120)）
- 解码尺寸与归一化尺寸不同时额外在引用里记录 `originalDimensions`（[packages/attachment/attachment-local/src/store.ts:121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L121)）
- `syncDirectory` 在 win32 上直接返回，其余平台打开只读目录句柄做 fsync 后关闭（[packages/attachment/attachment-local/src/store.ts:132-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L132-L143)）
- `ensureDurableDirectory` 以 0700 递归建目录并 chmod，然后逐级向上 fsync 直到调用方声明的边界（[packages/attachment/attachment-local/src/store.ts:156-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L156-L169)）
- `ensureDurableHome` 每进程只对同一 home 做一次到文件系统根的持久化证明并记入集合（[packages/attachment/attachment-local/src/store.ts:176-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L176-L183)）
- `commitPreparedImageFile` 提交前重算摘要与字节数，与引用不符抛 `ATTACHMENT_CORRUPT`（[packages/attachment/attachment-local/src/store.ts:195-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L195-L199)）
- 先对 home 建立边界，再让对象桶目录与 `tmp` 暂存目录都达到该边界的持久状态（[packages/attachment/attachment-local/src/store.ts:200-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L200-L207)）
- 以 `O_CREAT|O_EXCL|O_WRONLY` 0600 写入暂存文件、fsync 后关闭（[packages/attachment/attachment-local/src/store.ts:212-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L212-L216)）
- 用硬链接原子发布到目标路径；EEXIST 时读回已存在对象比对摘要，不符抛 `ATTACHMENT_CORRUPT`（[packages/attachment/attachment-local/src/store.ts:217-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L217-L224)）
- 先删暂存名再把目标 chmod 成 0400，随后 fsync 桶目录与 `objects` 目录（[packages/attachment/attachment-local/src/store.ts:227-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L227-L236)）
- 失败路径关闭残留句柄、尽力删除暂存文件，并把非 AttachmentError 包成 `ATTACHMENT_WRITE_FAILED`（[packages/attachment/attachment-local/src/store.ts:237-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L237-L252)）
- `saveImageFile` 把准备与提交串成一次保存（[packages/attachment/attachment-local/src/store.ts:264-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L264-L271)）
- `readImageFile` 在读盘前、读盘后、摘要比对后与探测后多次响应取消信号（[packages/attachment/attachment-local/src/store.ts:286-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L286-L302)）
- 读取缺失对象抛 `ATTACHMENT_NOT_FOUND`，其他读失败抛 `ATTACHMENT_READ_FAILED`（[packages/attachment/attachment-local/src/store.ts:289-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L289-L295)）
- 摘要与 id 不符抛 `ATTACHMENT_CORRUPT`，随后只做头部探测而不重新全量解码（[packages/attachment/attachment-local/src/store.ts:297-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L297-L301)）
- 探测出的媒体类型、字节数、宽高与引用不符抛 `ATTACHMENT_CORRUPT`，全部相符才返回字节（[packages/attachment/attachment-local/src/store.ts:303-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment-local/src/store.ts#L303-L307)）

### packages/attachment/attachment-local/tsconfig.json

包级 TypeScript 编译配置，设定 rootDir/outDir 与工程引用。

- 无运行期机制
