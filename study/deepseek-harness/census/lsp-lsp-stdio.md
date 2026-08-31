---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/lsp/lsp-stdio
---

# packages/lsp/lsp-stdio

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、119 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/lsp/lsp-stdio/README.md

`dsh-lsp-stdio` 包的英文说明文档，介绍配置字段、查询流程、失败形态与实现分工。

- 无运行期机制

### packages/lsp/lsp-stdio/package.json

`@deepseek-ai/dsh-lsp-stdio` 的 npm 清单，声明模块入口、导出映射与依赖。

- `type: module` 与 `main`/`types` 指定运行期加载的入口文件为 `lib/index.js`（[packages/lsp/lsp-stdio/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/package.json#L13-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/lsp/lsp-stdio/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/package.json#L16-L27)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/lsp/lsp-stdio/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/package.json#L28-L32)）
- `dependencies` 只有 schemastery 一项，配置校验依赖随包安装（[packages/lsp/lsp-stdio/package.json:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/package.json#L44-L46)）

### packages/lsp/lsp-stdio/src/abort.ts

取消信号的共用助手，被 host、instance 与 provider 的每个等待点使用。

- `abortError()` 优先返回信号上的超时对象，其次返回 Error 型 reason，最后兜底为通用中止错误，从而保留超时分类（[packages/lsp/lsp-stdio/src/abort.ts:13-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/abort.ts#L13-L19)）
- `throwIfAborted()` 在信号已触发时立即抛出分类后的中止错误（[packages/lsp/lsp-stdio/src/abort.ts:25-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/abort.ts#L25-L27)）
- `abortable()` 无信号时原样返回工作 Promise，已中止时立刻拒绝（[packages/lsp/lsp-stdio/src/abort.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/abort.ts#L36-L38)）
- `abortable()` 用 `Promise.race` 让调用方放弃等待，底层工作仍继续走完自己的静默边界，并在结束时摘除监听器（[packages/lsp/lsp-stdio/src/abort.ts:39-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/abort.ts#L39-L47)）

### packages/lsp/lsp-stdio/src/connection.ts

一个语言服务器子进程上的 JSON-RPC 端点：负责派生进程、编号相关、出入站消息分发与终止。

- 默认写入器把消息帧化后写进子进程 stdin，并把流的回调结果交回上层（[packages/lsp/lsp-stdio/src/connection.ts:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L61-L63)）
- 构造时按 `maxMessageBytes` 建立解码器（[packages/lsp/lsp-stdio/src/connection.ts:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L88)）
- 以 `[command, ...args]` 派生进程，指定 cwd、stdin/stdout 管道、带字节上限的 stderr 收集、`graceMs` 与显式 env（[packages/lsp/lsp-stdio/src/connection.ts:92-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L92-L104)）
- 缺少任一管道流时直接抛错（[packages/lsp/lsp-stdio/src/connection.ts:106-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L106-L108)）
- `closed` 在进程结束时记录失败原因、拒绝全部在途请求并兑现；派生阶段的拒绝同时充当失败原因与关闭边界（[packages/lsp/lsp-stdio/src/connection.ts:111-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L111-L126)）
- stdin 报错被当作致命连接失败，使在途请求立即拒绝而不等进程关闭事件（[packages/lsp/lsp-stdio/src/connection.ts:127-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L127-L130)）
- stdout 的每个数据块进入解码流水线（[packages/lsp/lsp-stdio/src/connection.ts:131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L131)）
- `stderrTail` 读出被保留的 stderr 尾部文本用于诊断（[packages/lsp/lsp-stdio/src/connection.ts:140-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L140-L143)）
- `failed` 与 `failedWith()` 用保留的致命原因对象做同一性比较，供上层判定是否为本连接的传输故障（[packages/lsp/lsp-stdio/src/connection.ts:145-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L145-L157)）
- `request()` 自增分配数字 id，连接已关闭则立即拒绝，否则登记待决项并写出请求（[packages/lsp/lsp-stdio/src/connection.ts:165-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L165-L176)）
- 给请求 Promise 挂一个空 catch，使调用方放弃等待后的迟到拒绝不成为未处理拒绝（[packages/lsp/lsp-stdio/src/connection.ts:177-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L177-L181)）
- `notify()` 写出无 id 的通知（[packages/lsp/lsp-stdio/src/connection.ts:190-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L190-L192)）
- `cancel()` 尽力发出 `$/cancelRequest` 并吞掉写失败（[packages/lsp/lsp-stdio/src/connection.ts:198-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L198-L202)）
- `peekNextId()` 暴露下一个请求 id，使调用方能在发请求前预备取消（[packages/lsp/lsp-stdio/src/connection.ts:208-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L208-L210)）
- `terminate()` 触发子进程树的终止升级，`waitForProcessTreeExit()` 等待整棵树退出（[packages/lsp/lsp-stdio/src/connection.ts:212-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L212-L224)）
- 解码抛错时把连接标为失败并终止整个进程组，且不再分发本批消息（[packages/lsp/lsp-stdio/src/connection.ts:226-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L226-L239)）
- `dispatch()` 按帧字段分流：有 method 且有 id 走服务器请求处理，只有 method 的通知被忽略，数字 id 走响应处理（[packages/lsp/lsp-stdio/src/connection.ts:241-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L241-L258)）
- 服务器请求由回调应答，回调抛错时回一条 code 为 `-32601` 的错误响应（[packages/lsp/lsp-stdio/src/connection.ts:260-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L260-L267)）
- 响应处理摘掉待决项，错误对象转成 Error 拒绝，否则以 `result` 兑现（[packages/lsp/lsp-stdio/src/connection.ts:269-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L269-L280)）
- `write()` 在连接已失败时直接拒绝，写回调报错或同步抛出都记为连接致命失败（[packages/lsp/lsp-stdio/src/connection.ts:282-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L282-L304)）
- 退出错误消息在服务器写过 stderr 时附上保留的尾部内容（[packages/lsp/lsp-stdio/src/connection.ts:306-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L306-L310)）
- `fail()` 只记录第一个致命原因，并把当时全部在途请求一次性拒绝（[packages/lsp/lsp-stdio/src/connection.ts:312-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/connection.ts#L312-L322)）

### packages/lsp/lsp-stdio/src/framing.ts

LSP 基础协议的 `Content-Length` 帧编码器与有界流式解码器，被 connection 使用。

- `MAX_HEADER_BYTES` 固定为 64 KiB，用作头部区域的硬上限（[packages/lsp/lsp-stdio/src/framing.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/framing.ts#L12)）
- `encodeMessage()` 把消息序列化为 UTF-8 正文并拼上 `Content-Length` 头（[packages/lsp/lsp-stdio/src/framing.ts:19-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/framing.ts#L19-L23)）
- 解码器按构造参数保存单条消息体的字节上限（[packages/lsp/lsp-stdio/src/framing.ts:37-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/framing.ts#L37-L39)）
- `push()` 追加数据块并循环取出所有已完整的消息体（[packages/lsp/lsp-stdio/src/framing.ts:47-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/framing.ts#L47-L56)）
- 未出现分隔符且缓冲超过头部上限时抛错，防止服务器不发分隔符撑爆内存（[packages/lsp/lsp-stdio/src/framing.ts:60-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/framing.ts#L60-L69)）
- 声明长度超过 `maxMessageBytes` 时抛错（[packages/lsp/lsp-stdio/src/framing.ts:71-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/framing.ts#L71-L74)）
- 正文未收齐时返回未就绪，收齐后按 UTF-8 取出、前移缓冲并 `JSON.parse`，解析失败抛错（[packages/lsp/lsp-stdio/src/framing.ts:75-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/framing.ts#L75-L86)）
- 头部解析大小写不敏感地找 `Content-Length`，非整数或负数抛错，整块头部缺该字段也抛错，其余头部字段被忽略（[packages/lsp/lsp-stdio/src/framing.ts:90-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/framing.ts#L90-L102)）

### packages/lsp/lsp-stdio/src/host.ts

通过 `ctx.fs` 完成工作区规范化与查询源文件的读取，被 index.ts 的提供者在派生进程之前调用。

- `canonicalizeWorkspace()` 在解析前、解析后、stat 前后反复检查取消信号（[packages/lsp/lsp-stdio/src/host.ts:37-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/host.ts#L37-L50)）
- 工作区解析失败被包成带 `cause` 的说明性错误（[packages/lsp/lsp-stdio/src/host.ts:38-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/host.ts#L38-L44)）
- 工作区不是目录时直接失败（[packages/lsp/lsp-stdio/src/host.ts:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/host.ts#L51-L53)）
- 规范化结果同时给出稳定标识、可做子进程 cwd 的绝对路径和文件 URI，三者都取自文件系统提供者（[packages/lsp/lsp-stdio/src/host.ts:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/host.ts#L54-L58)）
- 源文件按已规范化的工作区路径作为 cwd 解析，解析失败包成说明性错误（[packages/lsp/lsp-stdio/src/host.ts:80-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/host.ts#L80-L89)）
- 解析结果必须被工作区包含，否则以「解析到工作区之外」失败（[packages/lsp/lsp-stdio/src/host.ts:91-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/host.ts#L91-L93)）
- 文本按流读入并逐块累计字节，超过 `maxDocumentBytes` 立即停止读取（[packages/lsp/lsp-stdio/src/host.ts:94-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/host.ts#L94-L109)）
- 超限后抛出带上限与已读字节数的错误（[packages/lsp/lsp-stdio/src/host.ts:110-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/host.ts#L110-L114)）
- 返回文件系统提供者给出的规范文件 URI 与拼接后的完整文本（[packages/lsp/lsp-stdio/src/host.ts:115-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/host.ts#L115-L119)）

### packages/lsp/lsp-stdio/src/index.ts

该包的插件入口：定义配置模式、在加载期解析可执行文件、注册按工作区池化进程的提供者。

- 插件名与注入的三个服务 `fs`/`lsp`/`subprocess`（[packages/lsp/lsp-stdio/src/index.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L44-L47)）
- 五个默认量：消息 16 MB、stderr 1 MB、文档 4 MB、关机 5 s、终止宽限 2 s（[packages/lsp/lsp-stdio/src/index.ts:49-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L49-L53)）
- schemastery 模式规定 `command`/`extensionToLanguage` 必填、其余字段填默认值，两个计时字段上限为 `MAX_TIMER_DELAY_MS`（[packages/lsp/lsp-stdio/src/index.ts:91-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L91-L107)）
- `throwTeardownFailures()` 等所有并发拆卸结算后才抛：单个失败原样抛出，多个包成 `AggregateError`（[packages/lsp/lsp-stdio/src/index.ts:110-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L110-L117)）
- `servers` 为空表时加载即失败（[packages/lsp/lsp-stdio/src/index.ts:127-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L127-L128)）
- 监听 `internal/plugin`，在自身 fiber 被卸载时中止仍在进行的加载期解析（[packages/lsp/lsp-stdio/src/index.ts:130-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L130-L137)）
- 逐条服务器：空标识拒绝、校验数值配置、通过 `ctx.subprocess.resolveExecutable` 用该条目的 env 解析可执行文件，再构造提供者（[packages/lsp/lsp-stdio/src/index.ts:142-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L142-L158)）
- 任一条目解析失败即中止其余解析并等它们结算后再抛，使坏条目不会让别的提供者先发布（[packages/lsp/lsp-stdio/src/index.ts:160-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L160-L168)）
- 注册阶段任一提供者被 `ctx.lsp` 拒绝时，按逆序回滚已注册者再抛（[packages/lsp/lsp-stdio/src/index.ts:171-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L171-L178)）
- 卸载时先逆序注销全部路由再拆卸进程，使新查询无法进入正在排空的提供者，并汇总拆卸失败（[packages/lsp/lsp-stdio/src/index.ts:179-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L179-L185)）
- 加载期校验两个计时预算必须是正整数且不超过定时器上限，三个字节上限必须是正整数（[packages/lsp/lsp-stdio/src/index.ts:189-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L189-L214)）
- 提供者持有按规范工作区键索引的实例表、每工作区一条串行队列、未入队的规范化在途集合以及一个生命周期控制器（[packages/lsp/lsp-stdio/src/index.ts:217-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L217-L227)）
- 提供者标识与扩展名映射来自配置，直接用于向服务注册（[packages/lsp/lsp-stdio/src/index.ts:236-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L236-L237)）
- `assertActive()` 在已卸载时抛 `LSP_DISPOSED`，信号已中止时抛分类中止错误（[packages/lsp/lsp-stdio/src/index.ts:245-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L245-L251)）
- `querySignal()` 把调用方信号与提供者生命周期信号融合成一个（[packages/lsp/lsp-stdio/src/index.ts:253-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L253-L258)）
- `query()` 先检查活性再做任何 I/O，使已取消的请求不会启动服务器（[packages/lsp/lsp-stdio/src/index.ts:260-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L260-L263)）
- 工作区规范化在进队列前进行，其在途 Promise 登记到集合里以便卸载时等待（[packages/lsp/lsp-stdio/src/index.ts:264-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L264-L273)）
- 查询按规范工作区键排队，队内先读源文件再取或建实例，保证排队者轮到时读到当前字节且非法源不会留下空转进程（[packages/lsp/lsp-stdio/src/index.ts:274-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L274-L285)）
- 判定为本实例传输故障时拆掉该实例、从槽位剔除、重建一个并把只读查询重试一次（[packages/lsp/lsp-stdio/src/index.ts:286-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L286-L294)）
- finally 中若实例已死则先等它拆卸完再剔除槽位（[packages/lsp/lsp-stdio/src/index.ts:295-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L295-L301)）
- `enqueue()` 把新任务挂在前一条尾巴之后，等待过程可被信号放弃；尾巴跟随真实的前序工作且永不拒绝，槽位在自己仍是当前尾巴时才删除（[packages/lsp/lsp-stdio/src/index.ts:306-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L306-L317)）
- `instanceFor()` 同步地取或建一个工作区实例（[packages/lsp/lsp-stdio/src/index.ts:319-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L319-L327)）
- `evictIfCurrent()` 只在槽位仍装着该实例时删除（[packages/lsp/lsp-stdio/src/index.ts:329-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L329-L333)）
- 创建实例时把已解析可执行文件、参数、规范工作区路径与 URI、env、静态配置与各项上限组装成实例规格（[packages/lsp/lsp-stdio/src/index.ts:335-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L335-L350)）
- `disposeAll()` 置卸载标志、以 `LSP_DISPOSED` 中止生命周期信号，然后并行等待实例拆卸、队列排空与在途规范化，最后汇总失败（[packages/lsp/lsp-stdio/src/index.ts:352-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/index.ts#L352-L368)）

### packages/lsp/lsp-stdio/src/instance.ts

一个已初始化的语言服务器进程：负责握手、串行化的瞬态打开查询与有界拆卸，由 index.ts 的提供者池化。

- 构造时建立连接并把服务器请求路由到本实例的应答器，同时启动 initialize 握手（[packages/lsp/lsp-stdio/src/instance.ts:63-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L63-L65)）
- 给握手 Promise 挂空 catch，并在进程关闭时置 `processClosed`（[packages/lsp/lsp-stdio/src/instance.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L66-L69)）
- `dead` 由进程已关闭、已卸载或连接已失败三者取或，供池同步跳过死实例（[packages/lsp/lsp-stdio/src/instance.ts:72-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L72-L75)）
- `isTransportFailure()` 把错误对象交给连接做同一性判定（[packages/lsp/lsp-stdio/src/instance.ts:82-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L82-L84)）
- `query()` 让排队等待本身可被信号放弃，于是前一条查询挂住时后来者的超时仍能生效（[packages/lsp/lsp-stdio/src/instance.ts:93-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L93-L98)）
- 查询因传输故障失败时触发实例拆卸再把错误抛出（[packages/lsp/lsp-stdio/src/instance.ts:99-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L99-L102)）
- 队列尾巴跟随真实前序工作并吞掉其结果，使放弃等待的调用方不会打散串行（[packages/lsp/lsp-stdio/src/instance.ts:103-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L103-L107)）
- 握手发出 `initialize`，其中 `processId` 固定为 null，并带上工作区 URI、工作区文件夹、客户端能力与静态初始化选项（[packages/lsp/lsp-stdio/src/instance.ts:110-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L110-L119)）
- 对返回的 `positionEncoding` 做协商校验后才保存能力，随后发出 `initialized`（[packages/lsp/lsp-stdio/src/instance.ts:120-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L120-L125)）
- 查询执行开头拒绝已卸载实例与已中止信号（[packages/lsp/lsp-stdio/src/instance.ts:127-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L127-L130)）
- 等待握手时若失败或被中止且进程仍活着，就拆掉实例，避免一个永远拒绝的握手让该工作区的后续查询全废（[packages/lsp/lsp-stdio/src/instance.ts:131-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L131-L142)）
- 服务器未声明对应操作能力时抛 `LSP_UNSUPPORTED_OPERATION`（[packages/lsp/lsp-stdio/src/instance.ts:146-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L146-L148)）
- 服务器不支持瞬态 `didOpen`/`didClose` 同步时同样抛 `LSP_UNSUPPORTED_OPERATION`（[packages/lsp/lsp-stdio/src/instance.ts:149-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L149-L151)）
- 以版本号 1 和完整文本发出 `textDocument/didOpen`，语言标识来自路由（[packages/lsp/lsp-stdio/src/instance.ts:158-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L158-L161)）
- 打开写入失败或被取消时立即拆卸实例，使池把它剔除（[packages/lsp/lsp-stdio/src/instance.ts:162-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L162-L167)）
- 只有已打开且实例未死时才补发 `didClose`；关闭写入失败不改变已定的查询结果，但会触发拆卸（[packages/lsp/lsp-stdio/src/instance.ts:171-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L171-L189)）
- 请求参数固定带文档 URI 与位置，`findReferences` 额外附 `context.includeDeclaration: true`（[packages/lsp/lsp-stdio/src/instance.ts:198-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L198-L204)）
- 发请求前先取下一个 id 以便预备取消，有信号时走可取消竞速路径（[packages/lsp/lsp-stdio/src/instance.ts:205-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L205-L208)）
- 中止时发 `$/cancelRequest`，再用 `killGraceMs` 的截止期等服务器确认；超期未结算就拆掉实例，最后仍抛原始错误（[packages/lsp/lsp-stdio/src/instance.ts:216-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L216-L241)）
- 结果归一化：hover 走悬浮归一化，其余走位置归一化并附上实例规格里的工作区 URI 作为 `resolvedWorkspaceUri`（[packages/lsp/lsp-stdio/src/instance.ts:243-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L243-L250)）
- `workspace/configuration` 用同一个静态配置值逐项应答（[packages/lsp/lsp-stdio/src/instance.ts:252-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L252-L259)）
- 生命周期记账类请求以 null 应答，`workspace/applyEdit` 被明确拒绝，其余未知服务器请求也拒绝（[packages/lsp/lsp-stdio/src/instance.ts:260-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L260-L269)）
- `startTeardown()` 置卸载标志并把拆卸记忆成唯一一次事务，所有调用方等同一个静默边界（[packages/lsp/lsp-stdio/src/instance.ts:275-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L275-L284)）
- 拆卸先在 `shutdownTimeoutMs` 截止期内做优雅关机，失败或超时都被吞掉，然后进入强制终止（[packages/lsp/lsp-stdio/src/instance.ts:286-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L286-L296)）
- 优雅关机依次发 `shutdown` 请求、`exit` 通知并等待进程关闭，三步都受截止期约束（[packages/lsp/lsp-stdio/src/instance.ts:298-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L298-L303)）
- 强制终止触发进程树终止后无限期等待连接关闭与整棵树退出（[packages/lsp/lsp-stdio/src/instance.ts:305-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L305-L317)）
- 以空结果应答的三个生命周期方法被固定成一个集合（[packages/lsp/lsp-stdio/src/instance.ts:320-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L320-L325)）
- 客户端能力固定声明 UTF-16 位置、工作区文件夹与配置、markdown/plaintext 悬浮、定义与实现的链接支持，并关闭动态注册（[packages/lsp/lsp-stdio/src/instance.ts:332-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/instance.ts#L332-L347)）

### packages/lsp/lsp-stdio/src/invariant.ts

该包的不变量伴随插件，向 `invariants` 服务登记包名。

- `inject = ['invariants']` 使伴随插件在该服务就绪前不运行（[packages/lsp/lsp-stdio/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/invariant.ts#L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/lsp/lsp-stdio/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/invariant.ts#L21)）
- `apply` 向 `ctx.invariants` 以包名登记该空安装器并返回其注销函数（[packages/lsp/lsp-stdio/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/invariant.ts#L28-L29)）

### packages/lsp/lsp-stdio/src/protocol.ts

该宿主读写的 LSP 线上类型子集：能力、位置、链接、悬浮内容与文档同步形态。

- 无运行期机制

### packages/lsp/lsp-stdio/src/translate.ts

纯协议翻译层：能力判定、位置编码协商与 `Location`/`LocationLink`/`Hover` 载荷的归一化。

- 四个操作固定映射到 `textDocument/definition`、`references`、`implementation`、`hover` 四个请求方法（[packages/lsp/lsp-stdio/src/translate.ts:32-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L32-L41)）
- 每个操作对应到服务器能力中的一个 provider 字段（[packages/lsp/lsp-stdio/src/translate.ts:43-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L43-L53)）
- 能力值为 `true` 或选项对象算支持，缺失或 `false` 算不支持（[packages/lsp/lsp-stdio/src/translate.ts:55-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L55-L70)）
- 瞬态打开判定：枚举形态取 `Full`/`Incremental` 为支持、`None` 与缺失为不支持，选项形态必须显式 `openClose: true`（[packages/lsp/lsp-stdio/src/translate.ts:79-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L79-L88)）
- 位置编码缺省视为 `utf-16`，任何其他取值直接抛错（[packages/lsp/lsp-stdio/src/translate.ts:97-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L97-L100)）
- 线上范围被逐字段复制成服务定义的范围（[packages/lsp/lsp-stdio/src/translate.ts:102-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L102-L108)）
- 结构守卫要求坐标是非负整数、位置有 line/character、范围有 start/end，据此区分 `Location` 与 `LocationLink`（[packages/lsp/lsp-stdio/src/translate.ts:110-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L110-L137)）
- 导航结果归一化：`null` 为空数组，`undefined` 判为畸形，单个对象被包成数组（[packages/lsp/lsp-stdio/src/translate.ts:146-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L146-L150)）
- 逐元素归一化：`LocationLink` 取 `targetUri` 与 `targetSelectionRange`，`Location` 直接取 `uri`/`range`，两者都不是则判为畸形（[packages/lsp/lsp-stdio/src/translate.ts:151-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L151-L167)）
- 带语言标签的 `MarkedString` 被渲染成围栏代码块（[packages/lsp/lsp-stdio/src/translate.ts:169-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L169-L173)）
- 悬浮归一化：`null` 返回无悬浮，`undefined` 与非对象判为畸形，渲染出的空串也折成无悬浮，`range` 存在时必须通过结构校验（[packages/lsp/lsp-stdio/src/translate.ts:183-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L183-L194)）
- 悬浮内容三种编码的渲染：字符串原样、数组逐项渲染后以一个空行连接、`MarkupContent` 取 `value`、`{language, value}` 转围栏块，其余判为畸形（[packages/lsp/lsp-stdio/src/translate.ts:196-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L196-L222)）
- 所有畸形载荷统一抛出 code 为 `LSP_MALFORMED_RESPONSE` 的结构化错误（[packages/lsp/lsp-stdio/src/translate.ts:232-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp-stdio/src/translate.ts#L232-L235)）

### packages/lsp/lsp-stdio/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
