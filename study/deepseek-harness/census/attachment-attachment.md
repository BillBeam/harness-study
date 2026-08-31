---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/attachment/attachment
---

# packages/attachment/attachment

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 10 个文件、28 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/attachment/attachment/README.md

包 README，说明图片附件的接入方式、存储承诺、失败码与已知限制，面向使用者和维护者阅读。

- 无运行期机制

### packages/attachment/attachment/package.json

包清单，声明该包的模块类型、入口与发布内容。

- `"type": "module"` 使该包以 ESM 方式被加载（[packages/attachment/attachment/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/package.json#L13)）
- `main`/`types`/`exports` 把 `.`、`./invariant`、`./types`、`./src/*`、`./package.json` 映射到具体产物路径，决定导入这些子路径时实际加载哪个文件（[packages/attachment/attachment/package.json:14-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/package.json#L14-L22)）
- `files` 限定发布物只含 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 js/d.ts（[packages/attachment/attachment/package.json:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/package.json#L23)）

### packages/attachment/attachment/src/admission.ts

wire 形式 base64 图片上传的准入入口，被接受浏览器上传的 RPC 端点共用。

- `decodeBase64` 用 Buffer 解码后回编码比对，空串或非规范 base64 抛 `INVALID_IMAGE_BASE64`（[packages/attachment/attachment/src/admission.ts:9-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/admission.ts#L9-L15)）
- `saveInput` 把一条上传转成存储输入，`name` 为 undefined 时不写入该字段（[packages/attachment/attachment/src/admission.ts:18-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/admission.ts#L18-L24)）
- `admitEncodedImages` 按调用方顺序逐条解码后整批交给 `saveImages`，返回同序引用（[packages/attachment/attachment/src/admission.ts:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/admission.ts#L36-L41)）

### packages/attachment/attachment/src/brand.ts

附件标识与请求变体标识的品牌类型文件，两个同名函数只做类型转换、不改变值。

- 无运行期机制

### packages/attachment/attachment/src/error.ts

附件失败类与失败码定义，供协议适配层按码路由。

- `IMAGE_ADMISSION_ERROR_CODES` 固定列出九个调用方可纠正的准入失败码（[packages/attachment/attachment/src/error.ts:3-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/error.ts#L3-L13)）
- 模块加载时把这些码构成 `Set`，供跨包边界的结构性判定使用（[packages/attachment/attachment/src/error.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/error.ts#L29)）
- `AttachmentError` 继承 `Error`，把 `name` 固定为 `'AttachmentError'` 并挂上只读 `code`（[packages/attachment/attachment/src/error.ts:40-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/error.ts#L40-L54)）
- `isImageAdmissionError` 只按 `instanceof Error` 加字符串 `code` 是否在集合内判定，不依赖原型链（[packages/attachment/attachment/src/error.ts:61-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/error.ts#L61-L68)）

### packages/attachment/attachment/src/index.ts

包入口，定义抽象服务类 `AttachmentStore` 并把品牌、错误、准入、投影几何一并再导出。

- `AttachmentStore` 继承 `Service` 并以 `'attachments'` 名注册，使 `ctx.attachments` 可用（[packages/attachment/attachment/src/index.ts:38-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/index.ts#L38-L41)）
- `validateImageBatch` 在批量条数超过 `maxImagesPerMessage` 时抛 `TOO_MANY_IMAGES`（[packages/attachment/attachment/src/index.ts:64-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/index.ts#L64-L66)）
- 同一批的字节总和超过 `maxMessageImageBytes` 时抛 `IMAGES_TOO_LARGE`（[packages/attachment/attachment/src/index.ts:67-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/index.ts#L67-L70)）
- 逐条比对 `mediaTypes` 白名单，不在其中抛 `UNSUPPORTED_IMAGE_TYPE` 并把类型写进消息（[packages/attachment/attachment/src/index.ts:71-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/index.ts#L71-L75)）
- `saveImages` 先整批校验、再逐条 `validateImage`，全部通过后才顺序 `saveImage` 并按输入序返回引用（[packages/attachment/attachment/src/index.ts:83-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/index.ts#L83-L90)）
- `imageHostPath` 的默认实现忽略引用并返回 `undefined`（[packages/attachment/attachment/src/index.ts:117-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/index.ts#L117-L120)）
- `readImageRequest` 的默认实现先响应已取消信号，再以 `ATTACHMENT_PROJECTION_UNSUPPORTED` 拒绝（[packages/attachment/attachment/src/index.ts:129-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/index.ts#L129-L141)）
- 服务类作为默认导出，成为可被 Loader 挂载的插件形态（[packages/attachment/attachment/src/index.ts:145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/index.ts#L145)）

### packages/attachment/attachment/src/invariant.ts

包自带的不变量伴生插件，向 `invariants` 服务登记本包名。

- 插件名与 `inject = ['invariants']` 决定它在该服务就绪后才激活（[packages/attachment/attachment/src/invariant.ts:9-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/invariant.ts#L9-L11)）
- installer 为空函数，登记后不安装任何运行期检查（[packages/attachment/attachment/src/invariant.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/invariant.ts#L13)）
- `apply` 调用 `ctx.invariants.register` 占用包名并返回注销函数（[packages/attachment/attachment/src/invariant.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/invariant.ts#L19)）

### packages/attachment/attachment/src/request-projection.ts

纯几何计算，被附件实现与请求侧计价共用，决定投影后的像素尺寸。

- 缩放比取 `min(1, sqrt(maxPixels/(w*h)))`，比值为 1 时原样返回，不放大小图（[packages/attachment/attachment/src/request-projection.ts:18-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/request-projection.ts#L18-L19)）
- 宽不小于高时以宽为主向下取整，再逐像素递减宽度直到总像素落入预算（[packages/attachment/attachment/src/request-projection.ts:20-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/request-projection.ts#L20-L28)）
- 高大于宽时对称地以高为主取整并递减，两侧下限都是 1 像素（[packages/attachment/attachment/src/request-projection.ts:29-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/attachment/attachment/src/request-projection.ts#L29-L35)）

### packages/attachment/attachment/src/types.ts

附件的持久化词汇表，只含接口与联合类型声明。

- 无运行期机制

### packages/attachment/attachment/tsconfig.json

包级 TypeScript 编译配置，设定 rootDir/outDir 与工程引用。

- 无运行期机制
