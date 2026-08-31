---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session-query/session-log-export
---

# packages/session-query/session-log-export

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 14 个文件、74 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session-query/session-log-export/README.md

该包的英文 README，说明会话日志 ZIP 导出的组合方式、命令契约、对话框阶段与失败表现。

- 无运行期机制

### packages/session-query/session-log-export/package.json

该包的 npm 清单，声明入口、导出子路径、发布文件、依赖与浏览器侧插件元数据。

- `type: module`、`main: lib/index.js`、`types: lib/types/index.d.ts` 决定运行期从该包解析到的宿主入口（[packages/session-query/session-log-export/package.json:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/package.json#L11-L13)）
- `exports` 把 `./client` 单独指向 `lib/client.js`，与宿主入口分成两个可加载产物，并开放 `./invariant` 与通配 `./src/*`（[packages/session-query/session-log-export/package.json:14-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/package.json#L14-L20)）
- `files` 把随包发布内容限定为三个 js 产物与 `lib/types/**/*.d.ts`（[packages/session-query/session-log-export/package.json:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/package.json#L21)）
- `dependencies` 把 `fflate` 与 schemastery 列为运行期真依赖（ZIP 压缩与配置校验）（[packages/session-query/session-log-export/package.json:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/package.json#L24-L27)）
- `dsh.client` 声明浏览器侧注入的五个客户端包与 `platform: web`，决定该客户端插件被哪个平台的加载器装配（[packages/session-query/session-log-export/package.json:65-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/package.json#L65-L76)）

### packages/session-query/session-log-export/src/archive.ts

宿主侧归档模块，把一棵会话树的原始日志与被引用媒体流式压缩成一个 ZIP，被本包的下载路由调用。

- `DEFAULT_SESSION_LOG_COMPRESSION_LEVEL` 定为 6，作为配置省略时每个 ZIP 条目的 DEFLATE 级别（[packages/session-query/session-log-export/src/archive.ts:29-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L29-L33)）
- `sessionLogExportDeps` 以 `ctx.get` 逐个可选读取 `sessionQuery`、`sessionPersistence`、`attachments`、`sessions` 四个服务（[packages/session-query/session-log-export/src/archive.ts:56-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L56-L63)）
- `flushLiveSessionLog` 在读取前后各检查一次取消信号，会话存储缺席或该 id 不在内存中时直接返回，否则调 `sessions.flush(session)` 把内存日志落盘（[packages/session-query/session-log-export/src/archive.ts:73-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L73-L85)）
- `MEDIA_TYPE_EXTENSIONS` 把四种光栅媒体类型映射为 png／jpg／webp／gif 扩展名（[packages/session-query/session-log-export/src/archive.ts:93-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L93-L98)）
- `mediaEntryPath` 把媒体条目落在 `media/<attachmentId>.<ext>`，同一附件 id 只对应一个归档路径（[packages/session-query/session-log-export/src/archive.ts:107-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L107-L109)）
- `collectImageRefs` 用显式栈迭代下潜嵌套的 `content` 数组，把 `type === 'image'` 且带 attachment 对象的块按 attachmentId 去重收集（[packages/session-query/session-log-export/src/archive.ts:117-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L117-L133)）
- `collectEventImageRefs` 从事件 `data` 的 `content`、`message.content`、`inserted[].content` 以及 `chunk.type === 'block-end'` 的 block 四个载体上扫描图像引用（[packages/session-query/session-log-export/src/archive.ts:142-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L142-L157)）
- `imageRefsInArtifact` 按行解析原始日志文本，解析失败的行跳过而不影响原文导出（[packages/session-query/session-log-export/src/archive.ts:166-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L166-L179)）
- `safeSessionIdSegment` 把会话 id 中所有非 `A-Za-z0-9_-` 字符替换为 `_`，使 `../`、点段与分隔符无法塑造归档路径（[packages/session-query/session-log-export/src/archive.ts:190-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L190-L192)）
- `sessionLogZipFilename` 把下载文件名定为 `dsh-session-<清洗后 id>.zip`（[packages/session-query/session-log-export/src/archive.ts:199-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L199-L201)）
- `sessionLogZipEntries` 先登记根日志引用的媒体，再把根 artifact 以其原始文件名作为第一个 ZIP 条目产出（[packages/session-query/session-log-export/src/archive.ts:219-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L219-L231)）
- 需要包含后代时按 `traceSession` 的谱系递归下潜，用 `seen` 去重、逐个先 flush 再 `readRaw`，缺少存储 artifact 直接抛错，路径为 `subagents/<清洗后 id>/<文件名>`（[packages/session-query/session-log-export/src/archive.ts:232-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L232-L259)）
- 全部日志产出后，逐个从附件存储 `readImage` 并作为二进制条目产出，同一 attachmentId 只出现一次（[packages/session-query/session-log-export/src/archive.ts:260-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L260-L265)）
- 文本推送块、二进制推送块与响应队列高水位三个常量均定为 64 KiB（[packages/session-query/session-log-export/src/archive.ts:268-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L268-L275)）
- `ResponseCapacityGate.wait` 在 `desiredSize` 非正时挂起生产者，直到消费者 pull 或取消信号触发才放行，并在放行后再查一次取消（[packages/session-query/session-log-export/src/archive.ts:278-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L278-L308)）
- `pushBinaryChunks` 按 64 KiB 切分媒体字节推入 deflate，每块之间等待响应容量并检查取消（[packages/session-query/session-log-export/src/archive.ts:319-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L319-L335)）
- `pushArtifactChunks` 按 64 K 码元切分文本，当边界落在代理对高位时回退一个码元，使代理对整体进入下一块（[packages/session-query/session-log-export/src/archive.ts:347-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L347-L371)）
- `streamSessionLogZip` 用 `AbortSignal.any` 把请求取消与响应消费者取消合成一个生产者信号，并提供幂等的 `terminateZip`（[packages/session-query/session-log-export/src/archive.ts:396-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L396-L405)）
- fflate 的 `Zip` 回调把压缩块直接 enqueue 到响应流，`final` 时关闭流，报错时 `controller.error`，空块被跳过（[packages/session-query/session-log-export/src/archive.ts:406-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L406-L421)）
- 每个条目新建一个带配置级别的 `ZipDeflate` 加入归档，文本走文本推送、二进制走字节推送，全部产出后 `archive.end()`（[packages/session-query/session-log-export/src/archive.ts:423-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L423-L434)）
- 流中途任何失败都先 terminate 压缩器再 `controller.error`，使下载失败而不是交出截断的归档（[packages/session-query/session-log-export/src/archive.ts:435-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L435-L441)）
- `pull` 释放容量门，`cancel` 以取消原因中止生产者信号并 terminate 压缩器（[packages/session-query/session-log-export/src/archive.ts:444-452](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L444-L452)）
- 响应流以 64 KiB 高水位与按 `byteLength` 计量的排队策略构造（[packages/session-query/session-log-export/src/archive.ts:453-456](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/archive.ts#L453-L456)）

### packages/session-query/session-log-export/src/client/Dialog.tsx

浏览器侧的导出结果模态框组件，被会话头部动作与 `/export` 命令共用。

- 从下载控制器的快照 store 中按 sessionId 取本会话条目（[packages/session-query/session-log-export/src/client/Dialog.tsx:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/Dialog.tsx#L28)）
- 依 `status` 在 downloading／success／其他三态间选取标题与描述，error 态优先用条目上的错误文本，缺失时退回通用失败文案（[packages/session-query/session-log-export/src/client/Dialog.tsx:30-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/Dialog.tsx#L30-L38)）
- 模态框仅在条目 `open === true` 时展开，关闭图标与底部按钮都调用 `dismiss(sessionId)`（[packages/session-query/session-log-export/src/client/Dialog.tsx:41-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/Dialog.tsx#L41-L48)）

### packages/session-query/session-log-export/src/client/HeaderAction.module.css

会话头部导出按钮的 CSS Module 样式表。

- 无运行期机制

### packages/session-query/session-log-export/src/client/HeaderAction.tsx

会话头部的导出按钮组件，注册到会话头部 utilities 插槽。

- 从快照 store 读取本会话条目，`status === 'downloading'` 时判定为忙（[packages/session-query/session-log-export/src/client/HeaderAction.tsx:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/HeaderAction.tsx#L12-L14)）
- 忙时按钮 `disabled` 且 `aria-busy` 为真，点击时调用注入的 `request(sessionId)` 发起下载（[packages/session-query/session-log-export/src/client/HeaderAction.tsx:18-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/HeaderAction.tsx#L18-L27)）
- 该贡献同时渲染共享模态框，使按钮与命令走同一个对话框（[packages/session-query/session-log-export/src/client/HeaderAction.tsx:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/HeaderAction.tsx#L28)）

### packages/session-query/session-log-export/src/client/controller.ts

浏览器侧下载控制器，持有每会话一份的在途下载与对话框状态，被头部按钮与 `/export` 共用。

- `sessionLogZipFilename` 在浏览器侧同样把非 `A-Za-z0-9_-` 字符替换为 `_`，得到 `dsh-session-<id>.zip`（[packages/session-query/session-log-export/src/client/controller.ts:31-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L31-L33)）
- `downloadUrl` 创建带 `download` 属性的锚元素并 `click()`，把 URL 交给浏览器下载管理器（[packages/session-query/session-log-export/src/client/controller.ts:40-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L40-L45)）
- `hostBase` 在 `location.origin` 缺失或为字符串 `'null'` 时退回 `http://dsh.internal`（[packages/session-query/session-log-export/src/client/controller.ts:48-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L48-L51)）
- 控制器以 `{ bySession: {} }` 初始化快照 store，作为每会话对话框状态的唯一来源（[packages/session-query/session-log-export/src/client/controller.ts:59-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L59-L60)）
- 构造参数把 HTTP 载体与保存操作默认接到全局 `fetch` 与 `downloadUrl`（[packages/session-query/session-log-export/src/client/controller.ts:69-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L69-L72)）
- `download` 对同一会话的并发请求复用同一个在途 Promise，已 dispose 后的请求直接静默兑现，操作结算后从在途表移除（[packages/session-query/session-log-export/src/client/controller.ts:79-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L79-L89)）
- `dismiss` 只把条目的 `open` 置 false，不中止在途下载（[packages/session-query/session-log-export/src/client/controller.ts:95-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L95-L99)）
- `dispose` 置位后中止全部在途操作并等待它们结算（[packages/session-query/session-log-export/src/client/controller.ts:105-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L105-L110)）
- `run` 先发布 `downloading` 状态，再向 `/api/session.export` 拼上 `sessionId` 与固定的 `includeDescendants=true` 发一个 `HEAD` 预检（[packages/session-query/session-log-export/src/client/controller.ts:112-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L112-L118)）
- 预检非 2xx 时读取响应体文本拼成 `Export failed: HTTP <status> <detail>` 抛出（[packages/session-query/session-log-export/src/client/controller.ts:119-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L119-L122)）
- 预检通过后把同一个 GET URL 交给保存操作，并保留当前 `open` 值发布 `success`（[packages/session-query/session-log-export/src/client/controller.ts:123-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L123-L125)）
- 捕获分支在信号已中止时静默返回，否则保留当前 `open` 值发布带错误文本的 `error` 状态（[packages/session-query/session-log-export/src/client/controller.ts:126-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L126-L130)）
- `publish` 以整体替换 `bySession` 映射的方式写入该会话条目，触发订阅者重渲染（[packages/session-query/session-log-export/src/client/controller.ts:133-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/controller.ts#L133-L137)）

### packages/session-query/session-log-export/src/client/index.ts

浏览器侧插件入口，提供下载控制器服务、注册词典、监听命令执行并把头部动作挂入插槽。

- 声明注入 `slots` 与 `locale` 两个客户端服务（[packages/session-query/session-log-export/src/client/index.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/index.ts#L29)）
- 构造控制器并以 `sessionLogDownload` 名字 `provide` 到上下文（[packages/session-query/session-log-export/src/client/index.ts:36-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/index.ts#L36-L37)）
- 用 `ctx.effect` 把插件卸载绑定到 `controller.dispose()`，卸载时中止在途下载（[packages/session-query/session-log-export/src/client/index.ts:38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/index.ts#L38)）
- 注册 `session-log-download` 命名空间的中英词典，卸载时撤销（[packages/session-query/session-log-export/src/client/index.ts:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/index.ts#L39)）
- 监听 `command/executed`，仅当命令名为 `export` 且结果 kind 为 `success` 时在本浏览器发起下载（[packages/session-query/session-log-export/src/client/index.ts:40-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/index.ts#L40-L42)）
- 向 `conversation.session.header.utilities` 插槽注册 id 为 `session-log-download` 的贡献，并把控制器的 store、`download` 与 `dismiss` 注入给组件（[packages/session-query/session-log-export/src/client/index.ts:43-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/client/index.ts#L43-L52)）

### packages/session-query/session-log-export/src/client/locales.ts

浏览器侧导出反馈的中英文案字典与命名空间常量。

- 无运行期机制

### packages/session-query/session-log-export/src/css-modules.d.ts

`*.module.css` 与 `*.css` 导入的 TypeScript 环境声明。

- 无运行期机制

### packages/session-query/session-log-export/src/index.ts

宿主侧插件入口，注册 `/export` 人类命令与 `/api/session.export` 下载路由，并把请求接到归档流。

- 声明插件名 `session-log-download` 并注入 `commands` 与 `connection` 服务（[packages/session-query/session-log-export/src/index.ts:34-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L34-L35)）
- 下载路径固定为 `/api/session.export`（[packages/session-query/session-log-export/src/index.ts:37-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L37-L38)）
- `Config` 把 `compressionLevel` 校验为 0 到 9 的整数，默认 6（[packages/session-query/session-log-export/src/index.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L46-L50)）
- 注册 `export` 命令：无参数时返回固定成功文案 `Session log download requested.`，带任何参数时返回错误结果（[packages/session-query/session-log-export/src/index.ts:62-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L62-L79)）
- 向 connection 注册精确路径的 `GET`／`HEAD` fetch 路由；`HEAD` 请求先取消响应体再回一个同 status、同 headers 的空响应（[packages/session-query/session-log-export/src/index.ts:80-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L80-L93)）
- `connectionOf` 用 `Reflect.get(ctx, 'connection')` 取出注册载体（[packages/session-query/session-log-export/src/index.ts:96-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L96-L98)）
- 查询参数校验：`sessionId` 缺失或为空，或 `includeDescendants` 不是 `true`／`false`，返回 400（[packages/session-query/session-log-export/src/index.ts:105-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L105-L112)）
- `sessionQuery`、`sessionPersistence`、`attachments` 任一缺席时返回 500 并说明缺少哪类服务（[packages/session-query/session-log-export/src/index.ts:114-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L114-L122)）
- 持久化后端不支持 per-session 原始 artifact 时返回 501（[packages/session-query/session-log-export/src/index.ts:123-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L123-L128)）
- 开流前先 flush 活跃会话再 `readRaw` 根 artifact，读取失败时若请求已取消则抛出，否则返回 500（[packages/session-query/session-log-export/src/index.ts:135-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L135-L143)）
- 根 artifact 不存在时返回 404（[packages/session-query/session-log-export/src/index.ts:144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L144)）
- 成功路径把 `streamSessionLogZip` 的字节流作为响应体，带 `content-type: application/zip` 与 `attachment; filename="dsh-session-<id>.zip"` 的 `content-disposition`，并把请求信号传给归档流（[packages/session-query/session-log-export/src/index.ts:145-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/index.ts#L145-L161)）

### packages/session-query/session-log-export/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包名。

- 声明插件名 `session-export-invariant` 并要求注入 `invariants` 服务（[packages/session-query/session-log-export/src/invariant.ts:9-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/invariant.ts#L9-L10)）
- 安装函数为空体，登记后不注册任何运行期检查（[packages/session-query/session-log-export/src/invariant.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/invariant.ts#L16)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并把 disposer 作为插件卸载句柄（[packages/session-query/session-log-export/src/invariant.ts:23-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/src/invariant.ts#L23-L24)）

### packages/session-query/session-log-export/tsconfig.json

该包的 TypeScript 方案根配置，只引用宿主面与客户端面两个叶子配置。

- 无运行期机制

### packages/session-query/session-log-export/tsdown.config.ts

该包的打包配置，决定构建出的宿主与客户端运行期产物。

- 以包名与 `lib/types/index.js`、`lib/types/invariant.js` 两个入口调用共享的客户端打包器，并开启 `hostPhase`，从而产出 `lib/index.js`、`lib/invariant.js` 与 `lib/client.js`（[packages/session-query/session-log-export/tsdown.config.ts:1-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session-query/session-log-export/tsdown.config.ts#L1-L7)）
