---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/test-support/llm-mock-server
---

# packages/test-support/llm-mock-server

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、94 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/test-support/llm-mock-server/README.md

包说明文档，讲这台可脚本化的兼容式 HTTP/SSE 假服务器怎么起、有哪些行为名、随机模式与各类参数怎么用。

- 无运行期机制

### packages/test-support/llm-mock-server/package.json

包清单，声明该包的入口、导出映射与发布文件白名单。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/test-support/llm-mock-server/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/package.json#L14-L15)）
- `exports` 只开放根入口、`./invariant`、`./src/*` 原文路径与 `./package.json` 四条解析路径，未声明任何可安装的 `bin`（[packages/test-support/llm-mock-server/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/test-support/llm-mock-server/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/package.json#L28-L32)）

### packages/test-support/llm-mock-server/src/bin.ts

独立进程入口，把命令行参数交给解析器再启动服务器，并把遥测写到 stdout。

- 解析 `process.argv.slice(2)`，解析结果为 help 时把用法文本写到 stdout（[packages/test-support/llm-mock-server/src/bin.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/bin.ts#L13-L15)）
- host 缺省 `127.0.0.1`、port 缺省 8000（[packages/test-support/llm-mock-server/src/bin.ts:18-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/bin.ts#L18-L19)）
- 需要预先不可达时先写一条 `unavailable` JSONL 记录，再按 `listenDelayMs` 延迟后才开始监听（[packages/test-support/llm-mock-server/src/bin.ts:20-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/bin.ts#L20-L27)）
- 启动服务器时挂上 `onEvent`，把每条遥测事件按 JSON 一行写到 stdout（[packages/test-support/llm-mock-server/src/bin.ts:28-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/bin.ts#L28-L31)）
- 监听成功后写一条 `ready` 记录，内含 `<baseURL>/v1` 与实际随机种子（[packages/test-support/llm-mock-server/src/bin.ts:32-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/bin.ts#L32-L36)）
- SIGINT/SIGTERM 触发一次性关闭，关完分别以 130/143 退出（[packages/test-support/llm-mock-server/src/bin.ts:37-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/bin.ts#L37-L44)）
- 启动期抛错时把错误消息与用法文本写到 stderr 并把退出码置为 1（[packages/test-support/llm-mock-server/src/bin.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/bin.ts#L46-L49)）

### packages/test-support/llm-mock-server/src/cli.ts

命令行参数解析模块，把 argv 转成服务器选项加监听延迟配置，被 `bin.ts` 调用。

- 定义 CLI 独有的 `connection_refused` 行为名（[packages/test-support/llm-mock-server/src/cli.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L16)）
- 以服务器导出的行为清单建立可接受行为集合，并把默认监听延迟定为 750 毫秒（[packages/test-support/llm-mock-server/src/cli.ts:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L33-L34)）
- `MOCK_LLM_CLI_USAGE` 是 `--help` 与参数出错时写出的用法文本（[packages/test-support/llm-mock-server/src/cli.ts:37-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L37-L65)）
- `numberValue` 拒绝非有限数值，`boundedIntegerValue` 再要求整数且落在给定上下界内（[packages/test-support/llm-mock-server/src/cli.ts:67-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L67-L79)）
- `parseSequence` 拒绝空条目，只允许 `connection_refused` 出现在首位，去掉它后要求剩余序列非空且每项都是已知行为（[packages/test-support/llm-mock-server/src/cli.ts:81-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L81-L98)）
- `parseRandomWeights` 逐条解析 `behavior=weight`，拒绝格式错误、非具体行为（含 `random`）与重复项（[packages/test-support/llm-mock-server/src/cli.ts:100-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L100-L116)）
- `CLI_OPTIONS` 固定可识别的旗标集合，只有 `--repeat-last` 与 `--help` 是布尔（[packages/test-support/llm-mock-server/src/cli.ts:119-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L119-L138)）
- argv 里出现 `--help` 时立刻返回 help 结果，不做后续解析（[packages/test-support/llm-mock-server/src/cli.ts:148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L148)）
- 以 `node:util` 的 `parseArgs` 严格模式切词，不接受位置参数（[packages/test-support/llm-mock-server/src/cli.ts:150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L150)）
- `--port` 缺省 8000，`--listen-delay-ms` 限定为 0 到 Node 定时器上限之间的整数，`--repeat-last` 缺省 false（[packages/test-support/llm-mock-server/src/cli.ts:153-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L153-L158)）
- 各内容与时延旗标经 `numberValue` 或原样收集成候选选项（[packages/test-support/llm-mock-server/src/cli.ts:159-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L159-L172)）
- 缺 `--sequence` 直接抛错（[packages/test-support/llm-mock-server/src/cli.ts:174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L174)）
- 用了 `connection_refused` 却给了 0 端口时抛错（[packages/test-support/llm-mock-server/src/cli.ts:177-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L177-L179)）
- 未以 `connection_refused` 开头却给了 `--listen-delay-ms` 时抛错（[packages/test-support/llm-mock-server/src/cli.ts:180-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L180-L182)）
- 序列里没有 `random` 却给了 `--seed` 或 `--random-weights` 时抛错（[packages/test-support/llm-mock-server/src/cli.ts:183-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L183-L185)）
- 组装服务器选项时对每个未给的旗标做条件展开，不写入该键（[packages/test-support/llm-mock-server/src/cli.ts:190-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L190-L208)）
- 只有以 `connection_refused` 开头时 `listenDelayMs` 才取显式值或 750，否则固定为 0（[packages/test-support/llm-mock-server/src/cli.ts:209-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/cli.ts#L209-L210)）

### packages/test-support/llm-mock-server/src/index.ts

包的根入口：`startMockLlmServer` 起一个本地 chat-completions 服务器，按脚本逐请求执行一种线路行为，并把每次请求与结局记录下来。

- `MOCK_LLM_BEHAVIORS` 固定全部可脚本化的行为名，`random` 是其中之一（[packages/test-support/llm-mock-server/src/index.ts:16-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L16-L41)）
- `DEFAULT_MOCK_LLM_RANDOM_WEIGHTS` 给出冻结的默认随机权重表（成功占多数，其余为各类故障）（[packages/test-support/llm-mock-server/src/index.ts:56-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L56-L70)）
- `MAX_MOCK_LLM_TIMER_DELAY_MS` 固定为 Node 定时器可接受的最大毫秒数（[packages/test-support/llm-mock-server/src/index.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L73)）
- 默认成功文本、部分文本、推理文本三个常量，以及排除 `random` 后的具体行为集合（[packages/test-support/llm-mock-server/src/index.ts:192-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L192-L195)）
- `boundedInteger` 对越界或非整数值抛出点名错误（[packages/test-support/llm-mock-server/src/index.ts:197-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L197-L202)）
- `resolveOptions` 填入各项缺省并逐一做上下界校验：host `127.0.0.1`、port 0、chunkSize 8、chunkDelayMs 25、disconnectDelayMs 10、retryAfterMs 1000、未给种子时用 4 字节随机数生成（[packages/test-support/llm-mock-server/src/index.ts:205-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L205-L236)）
- `resolveOptions` 拒绝空 host、空序列、空 apiKey、空文本与空 requestId，并把序列最后一项记为 `lastBehavior`（[packages/test-support/llm-mock-server/src/index.ts:238-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L238-L246)）
- `resolveOptions` 对 `toolArguments` 做一次 JSON 解析，不通过就抛错（[packages/test-support/llm-mock-server/src/index.ts:247-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L247-L251)）
- `resolveOptions` 校验随机权重：未知行为名与负数/非有限值抛错，只保留正权重项，一项不剩时抛错（[packages/test-support/llm-mock-server/src/index.ts:253-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L253-L266)）
- `resolveOptions` 返回的已解析选项对未给的 apiKey/requestId/onEvent 做条件展开，序列被复制一份（[packages/test-support/llm-mock-server/src/index.ts:268-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L268-L288)）
- `emit` 冻结事件后交给观察者，并吞掉观察者抛出的错误，不影响线路行为（[packages/test-support/llm-mock-server/src/index.ts:291-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L291-L297)）
- `readJsonBody` 读完请求体后按 UTF-8 解析 JSON，空体返回 undefined（[packages/test-support/llm-mock-server/src/index.ts:299-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L299-L304)）
- `splitText` 按 Unicode 码点而非 UTF-16 单元切分文本（[packages/test-support/llm-mock-server/src/index.ts:306-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L306-L311)）
- `openSse` 写 200 与 `text/event-stream`（可被调用方改成别的 content-type）、`no-cache`、`keep-alive` 三个头并立刻 flush（[packages/test-support/llm-mock-server/src/index.ts:313-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L313-L320)）
- `writeSse` 写一帧 `data: …\n\n`（字符串原样、其余 JSON 序列化）并把记录的 `chunksSent` 加一（[packages/test-support/llm-mock-server/src/index.ts:322-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L322-L325)）
- `writeDone` 写出 `[DONE]` 结束帧（[packages/test-support/llm-mock-server/src/index.ts:327-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L327-L329)）
- `finishRecord` 只在记录尚无结局时写入结局并发一条 `result` 遥测（含 attempt、脚本行为、具体行为、结局、已发帧数）（[packages/test-support/llm-mock-server/src/index.ts:331-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L331-L346)）
- `httpError` 在 `rate_limit` 行为下附带向上取整到秒的 `retry-after` 头（[packages/test-support/llm-mock-server/src/index.ts:357-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L357-L359)）
- `httpError` 在配置了 requestId 时附带 `x-request-id` 头，然后写出状态码与 `{error:{message,type,code}}` 的 JSON 体并把结局记为 completed（[packages/test-support/llm-mock-server/src/index.ts:361-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L361-L364)）
- `terminalChunk` 构造带 `finish_reason` 与 usage 计数的终止分片（[packages/test-support/llm-mock-server/src/index.ts:367-372](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L367-L372)）
- `pause` 以 response 的 `close` 事件驱动的 AbortController 取消等待，被取消时返回 false；零延迟时直接按 response 是否已销毁返回（[packages/test-support/llm-mock-server/src/index.ts:374-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L374-L388)）
- `streamText` 按 chunkSize 逐块写内容增量，任一块之后的等待被打断就中止（[packages/test-support/llm-mock-server/src/index.ts:390-402](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L390-L402)）
- `completeText` 流完成功文本后写终止分片与 `[DONE]` 并结束响应；中途被客户端关闭则把结局记为 `client_closed`（[packages/test-support/llm-mock-server/src/index.ts:404-419](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L404-L419)）
- `disconnect` 等 `disconnectDelayMs` 后把结局记为 `reset` 并销毁响应；等待期间客户端先关就记 `client_closed`（[packages/test-support/llm-mock-server/src/index.ts:421-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L421-L432)）
- `toolCallChunks` 把工具参数从中点切成两个增量帧，第一帧带调用 id、类型与工具名（[packages/test-support/llm-mock-server/src/index.ts:434-459](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L434-L459)）
- `runBehavior` 的 `script_exhausted` 分支回一个 500 与 `MOCK_SCRIPT_EXHAUSTED` 码（[packages/test-support/llm-mock-server/src/index.ts:468-469](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L468-L469)）
- `connection_reset` 在写任何头之前直接销毁底层套接字并记 `reset`（[packages/test-support/llm-mock-server/src/index.ts:471-473](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L471-L473)）
- `stream_disconnect` 先开 SSE 头再走断连（[packages/test-support/llm-mock-server/src/index.ts:475-477](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L475-L477)）
- `empty` 发一条零输出的 stop 终止分片加 `[DONE]` 后正常结束（[packages/test-support/llm-mock-server/src/index.ts:479-484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L479-L484)）
- `empty_body` 开头后立刻结束，一帧不发（[packages/test-support/llm-mock-server/src/index.ts:486-489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L486-L489)）
- `stream_eof` 只发一条 role 增量就结束，不发 `[DONE]`（[packages/test-support/llm-mock-server/src/index.ts:491-495](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L491-L495)）
- `partial_eof` 无延迟流完 partialText 后干净结束，不发 `[DONE]`（[packages/test-support/llm-mock-server/src/index.ts:497-501](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L497-L501)）
- `partial_disconnect` 按 chunkDelayMs 流 partialText，流完再断连（[packages/test-support/llm-mock-server/src/index.ts:503-506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L503-L506)）
- `stall` 只发 SSE 头就把结局记为 `stalled` 并让连接一直开着（[packages/test-support/llm-mock-server/src/index.ts:508-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L508-L510)）
- `malformed_json` 发一帧不合法 JSON 文本再发 `[DONE]`（[packages/test-support/llm-mock-server/src/index.ts:512-517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L512-L517)）
- `malformed_event` 发一帧 `choices: [null]` 的合法 JSON 再发 `[DONE]`（[packages/test-support/llm-mock-server/src/index.ts:519-524](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L519-L524)）
- `wrong_content_type` 用 `application/json` 头发出完整的 SSE 成功流（[packages/test-support/llm-mock-server/src/index.ts:526-528](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L526-L528)）
- `rate_limit`/`server_error`/`service_unavailable` 分别回 429/500/503 与对应错误码（[packages/test-support/llm-mock-server/src/index.ts:530-537](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L530-L537)）
- `auth_error` 回 401 `invalid_api_key`，`invalid_request` 回 400 `invalid_request`（[packages/test-support/llm-mock-server/src/index.ts:539-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L539-L543)）
- `context_overflow` 回 400、`context_length_exceeded` 码与 `invalid_request_error` 类型（[packages/test-support/llm-mock-server/src/index.ts:545-554](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L545-L554)）
- `quota_exceeded` 回 429 与 `insufficient_quota` 码（[packages/test-support/llm-mock-server/src/index.ts:556-557](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L556-L557)）
- `success` 无延迟流出完整成功文本并以 stop 收尾（[packages/test-support/llm-mock-server/src/index.ts:559-561](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L559-L561)）
- `reasoning_success` 先按 chunkSize 逐块发 `reasoning_content` 增量，再走成功文本收尾（[packages/test-support/llm-mock-server/src/index.ts:563-570](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L563-L570)）
- `tool_call_success` 发两帧工具调用增量、再发 `tool_calls` 终止分片与 `[DONE]`（[packages/test-support/llm-mock-server/src/index.ts:572-578](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L572-L578)）
- `max_tokens` 与 `slow_success` 走同一条成功路径，前者把 `finish_reason` 换成 `length`，后者按 chunkDelayMs 逐块拖慢（[packages/test-support/llm-mock-server/src/index.ts:580-586](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L580-L586)）
- `seededRandom` 用固定常数的整数混合算法从种子生成大于等于 0、小于 1 的数值序列（[packages/test-support/llm-mock-server/src/index.ts:591-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L591-L600)）
- `chooseRandomBehavior` 按权重总和抽签并线性扣减选出一个具体行为，末尾兜底取最后一项（[packages/test-support/llm-mock-server/src/index.ts:602-615](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L602-L615)）
- `startMockLlmServer` 先解析选项、建请求记录数组、按种子建随机源并把脚本游标置零（[packages/test-support/llm-mock-server/src/index.ts:627-630](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L627-L630)）
- `selectBehavior` 每次取游标当前项并前进；越界后按 `repeatLast` 复用最后一项或落到 `script_exhausted`，脚本项为 `random` 时再抽一个具体行为（[packages/test-support/llm-mock-server/src/index.ts:632-646](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L632-L646)）
- 处理器先把请求 URL 解析成 pathname（[packages/test-support/llm-mock-server/src/index.ts:650](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L650)）
- 非 POST 直接回 405 与 `allow: POST`，不消耗脚本（[packages/test-support/llm-mock-server/src/index.ts:651-654](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L651-L654)）
- 路径不以 `/chat/completions` 结尾直接回 404，不消耗脚本（[packages/test-support/llm-mock-server/src/index.ts:655-658](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L655-L658)）
- 配置了 apiKey 且 `Authorization` 不等于 `Bearer <token>` 时回 401 JSON 错误，不消耗脚本（[packages/test-support/llm-mock-server/src/index.ts:659-663](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L659-L663)）
- 请求体 JSON 解析失败时回 400 与 `invalid_json`，不消耗脚本（[packages/test-support/llm-mock-server/src/index.ts:665-672](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L665-L672)）
- 通过全部校验后才取下一个行为，并把 attempt、脚本行为、具体行为、路径、请求头副本与已解析请求体记成一条记录压入 `requests`（[packages/test-support/llm-mock-server/src/index.ts:674-684](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L674-L684)）
- 监听 response 的 `close`：响应未写完且记录尚无结局时把结局记为 `client_closed`（[packages/test-support/llm-mock-server/src/index.ts:685-689](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L685-L689)）
- 执行行为之前先发一条 `request` 遥测事件（[packages/test-support/llm-mock-server/src/index.ts:690-696](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L690-L696)）
- 处理器抛错时把最后一条记录记为 `server_error`；已发过头就销毁响应，否则回 500 与 `MOCK_HANDLER_FAILED`（[packages/test-support/llm-mock-server/src/index.ts:700-713](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L700-L713)）
- `close` 用缓存的 Promise 做幂等，关服务器的同时强制关掉全部现存连接（[packages/test-support/llm-mock-server/src/index.ts:715-719](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L715-L719)）
- 返回句柄前先等端口绑定完成，绑定期出错则整个启动 Promise 被拒绝（[packages/test-support/llm-mock-server/src/index.ts:721-727](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L721-L727)）
- 返回的句柄给出 baseURL（IPv6 host 加方括号）、实际端口、实际随机种子、按到达顺序的实时请求记录数组与 `close`（[packages/test-support/llm-mock-server/src/index.ts:729-737](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/index.ts#L729-L737)）

### packages/test-support/llm-mock-server/src/invariant.ts

该包的 invariant 伴生插件，向 `invariants` 服务登记包名。

- 导出插件名与 `inject: ['invariants']`，决定该伴生插件在何服务就绪后才加载（[packages/test-support/llm-mock-server/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/invariant.ts#L13-L15)）
- 安装器为空实现，登记后不注册任何检查（[packages/test-support/llm-mock-server/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并把其 disposer 作为结果返回（[packages/test-support/llm-mock-server/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/src/invariant.ts#L28-L29)）

### packages/test-support/llm-mock-server/tsconfig.json

该包的 TypeScript 编译配置，声明基配置、源码/输出目录与一项工作区项目引用。

- 无运行期机制

### packages/test-support/llm-mock-server/tsdown.config.ts

该包的打包配置，决定发布产物里存在哪些运行文件。

- 把 `lib/types/index.js` 与 `lib/types/invariant.js` 各自打成一个不做代码分割的 ESM 文件，输出到 `lib`，目标 es2024、平台 node，不生成声明也不清目录（[packages/test-support/llm-mock-server/tsdown.config.ts:4-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-mock-server/tsdown.config.ts#L4-L13)）
