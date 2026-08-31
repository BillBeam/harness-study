---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/terminal/tool-terminal
---

# packages/terminal/tool-terminal

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、52 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/terminal/tool-terminal/README.md

六个持久终端工具包的说明文档，罗列工具清单、组合方式、配置字段与模型可见效果。

- 无运行期机制

### packages/terminal/tool-terminal/package.json

该包的 npm 清单，声明入口、导出映射、发布文件与依赖。

- `main` / `types` 把包入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/terminal/tool-terminal/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/terminal/tool-terminal/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/terminal/tool-terminal/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/package.json#L28-L32)）
- `type: module` 使产物按 ESM 解析（[packages/terminal/tool-terminal/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/package.json#L13)）
- `dependencies` 只把 schemastery 列为运行期真实依赖，其余能力包均为 peer（[packages/terminal/tool-terminal/package.json:34-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/package.json#L34-L47)）

### packages/terminal/tool-terminal/src/index.ts

插件入口：注册六个模型可见的终端工具、一段系统提示词、以及后台发送到 jobs 服务的桥接，`apply` 由 Cordis 加载器调用。

- 插件声明依赖 `terminals`、`tools`、`systemPrompt` 三个服务（[packages/terminal/tool-terminal/src/index.ts:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L25-L28)）
- 定义结果字节上限的默认值 256KiB 与最小值 64（[packages/terminal/tool-terminal/src/index.ts:30-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L30-L33)）
- Schemastery 配置默认开启 `enableRunInBackground`，并把 `maxResultBytes` 约束为不小于 64 的整数（[packages/terminal/tool-terminal/src/index.ts:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L43-L47)）
- `requireAgent` 在执行上下文缺少发起 Agent 时抛错（[packages/terminal/tool-terminal/src/index.ts:118-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L118-L121)）
- `sessionId` 拒绝空串并把模型传入的字符串打上会话 id 品牌（[packages/terminal/tool-terminal/src/index.ts:123-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L123-L128)）
- `rawContentText` 只在结果恰为单个文本块时取出其文本（[packages/terminal/tool-terminal/src/index.ts:134-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L134-L138)）
- `sendDetail` 按会话状态生成 `wait: <原因>` 或 `session exited: <码/信号/unknown>` 文本（[packages/terminal/tool-terminal/src/index.ts:140-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L140-L144)）
- `apply` 取配置默认值后再次校验 `maxResultBytes` 为不小于 64 的安全整数，否则抛错（[packages/terminal/tool-terminal/src/index.ts:147-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L147-L152)）
- `finalizeContent` 对每个单文本结果统一施加 `maxResultBytes` 上限（[packages/terminal/tool-terminal/src/index.ts:153-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L153-L156)）
- 向系统提示词注册名为 `tool:pty` 的固定指导段落，含使用时机与"inferred_idle/timeout 不证明前台命令已退出"的说明（[packages/terminal/tool-terminal/src/index.ts:157-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L157-L161)）
- 注册 `terminal_open`，参数为 `type`（必填）、`name`、`cwd`（[packages/terminal/tool-terminal/src/index.ts:163-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L163-L170)）
- `terminal_open` 输出模式包含会话快照字段加必填 `motd`，并用 `renderSpawn` 渲染成模型文本（[packages/terminal/tool-terminal/src/index.ts:172-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L172-L182)）
- `terminal_open` 执行时拒绝空 `type`，并以执行 Agent 为 owner、带 `exec.signal` 调用 `ctx.terminals.spawn`（[packages/terminal/tool-terminal/src/index.ts:183-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L183-L191)）
- `terminal_send` 的描述文本在后台模式关闭时不含后台说明（[packages/terminal/tool-terminal/src/index.ts:199-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L199-L201)）
- `run_in_background` 只在配置启用时才出现在参数模式里（[packages/terminal/tool-terminal/src/index.ts:206-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L206-L208)）
- `terminal_send` 输出模式为后台 jobId 与前台结果的 `oneOf`，前台结果的 `waitReason` 限定为四个枚举值（[packages/terminal/tool-terminal/src/index.ts:211-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L211-L231)）
- 后台结果渲染为 `started background job <id>`，前台结果交给 `renderSend`（[packages/terminal/tool-terminal/src/index.ts:232-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L232-L237)）
- `presentationMeta` 只对前台结果暴露 viewport、等待原因、会话状态与截断标记（[packages/terminal/tool-terminal/src/index.ts:238-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L238-L245)）
- 发送请求的 `submit` 缺省为 `true`（[packages/terminal/tool-terminal/src/index.ts:250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L250)）
- 后台分支在配置禁用时抛错，在 `ctx.get('jobs')` 缺失时抛错，且都发生在写入输入之前（[packages/terminal/tool-terminal/src/index.ts:251-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L251-L254)）
- 后台分支用 `jobs.start` 建作业，带 `pty-send` 种类、由会话 id 与输入拼成的 label、owner 与 `outputLimitBytes`（[packages/terminal/tool-terminal/src/index.ts:255-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L255-L261)）
- 作业的 `cancel` 记录取消意图并取消底层发送，`done` 把结算映射为 killed/completed/failed 与详情文本，`readOutput` 增量读取（[packages/terminal/tool-terminal/src/index.ts:262-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L262-L276)）
- 前台分支带 `exec.signal` 启动发送、等待结算，并在信号已中止时抛错而非返回结果（[packages/terminal/tool-terminal/src/index.ts:278-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L278-L281)）
- 发送调用卡片按后台/前台分别选用 generic 与 terminal 卡片（[packages/terminal/tool-terminal/src/index.ts:283-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L283-L291)）
- 发送结果卡片在后台模式或出错时不呈现，否则以单文本内容填入 terminal 卡片（[packages/terminal/tool-terminal/src/index.ts:292-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L292-L296)）
- 注册 `terminal_read`，参数为会话 id 与可选 `offset`/`count`，输出含分页与截断字段并由 `renderRead` 渲染（[packages/terminal/tool-terminal/src/index.ts:299-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L299-L321)）
- `terminal_read` 执行时以执行 Agent 为 owner 调用 `ctx.terminals.read`，未给出的参数不下传（[packages/terminal/tool-terminal/src/index.ts:322-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L322-L328)）
- 注册 `terminal_signal`，把可投递信号限定为 SIGINT/SIGTERM/SIGKILL/SIGTSTP/SIGHUP 五个枚举值（[packages/terminal/tool-terminal/src/index.ts:332-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L332-L338)）
- `terminal_signal` 结果渲染为投递信号与目标进程组的一行文本，执行走 `ctx.terminals.signal`（[packages/terminal/tool-terminal/src/index.ts:339-355](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L339-L355)）
- 注册 `terminal_close`，执行调用 `ctx.terminals.kill` 并把布尔结果映射为 `closed`/`already-closing` 两种渲染文本（[packages/terminal/tool-terminal/src/index.ts:357-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L357-L386)）
- 注册无参的 `terminal_list`，执行返回当前 Agent 名下的会话快照数组并由 `renderList` 渲染（[packages/terminal/tool-terminal/src/index.ts:388-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/index.ts#L388-L401)）

### packages/terminal/tool-terminal/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包所有权。

- installer 为空函数，不安装任何运行期检查（[packages/terminal/tool-terminal/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/invariant.ts#L17-L21)）
- `apply` 以包名向 `ctx.invariants` 注册并返回注册的 disposer（[packages/terminal/tool-terminal/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/invariant.ts#L28-L29)）

### packages/terminal/tool-terminal/src/render.ts

把终端工具结果渲染成模型可见文本并施加完整结果字节上限的函数集合，被 `src/index.ts` 的各工具 `render` 与 `finalizeContent` 使用。

- 定义截断标记文本 `\n[output truncated]`（[packages/terminal/tool-terminal/src/render.ts:49-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L49-L50)）
- `byteLength` 以 UTF-8 编码后的字节数作为一切上限判定的度量（[packages/terminal/tool-terminal/src/render.ts:52-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L52-L54)）
- `retain` 用 `TextRetainer` 按 head 或 tail 方向在字节上限内保留文本（[packages/terminal/tool-terminal/src/render.ts:56-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L56-L60)）
- `fitWithSuffix` 为固定后缀预留字节；后缀本身已超限时只保留后缀的尾部（[packages/terminal/tool-terminal/src/render.ts:62-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L62-L66)）
- `fitWithPrefix` 为固定前缀与截断标记预留字节；两者已超限时只保留其头部（[packages/terminal/tool-terminal/src/render.ts:68-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L68-L73)）
- `boundBodyWithSuffix` 先按完整文本判断是否超限，超限时保留正文尾部并强制附加元数据与截断标记（[packages/terminal/tool-terminal/src/render.ts:75-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L75-L85)）
- `boundTerminalText` 对完整确认文本施加上限，保留头部并加截断标记；标记本身超限时只留标记尾部（[packages/terminal/tool-terminal/src/render.ts:93-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L93-L98)）
- `renderSpawn` 输出 `started terminal session <id>[ (name)] [type: ...]` 前缀加启动输出，空输出替换为 `(no startup output)`，超限时保留前缀而截正文（[packages/terminal/tool-terminal/src/render.ts:106-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L106-L112)）
- `renderSend` 在输出后附加 `[wait: <原因>]` 与 `[session: running|exited code=… signal=…]` 两行标记，空输出替换为 `(no new output)`（[packages/terminal/tool-terminal/src/render.ts:120-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L120-L131)）
- `renderSendRead` 直接返回增量，并在上游截断时按需补换行后附加截断标记（[packages/terminal/tool-terminal/src/render.ts:139-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L139-L142)）
- `renderRead` 在页文本后附加 `[lines: <起>-<止> of <总数>]`，空文本替换为 `(no retained output)`（[packages/terminal/tool-terminal/src/render.ts:150-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L150-L158)）
- `renderList` 空列表返回 `(no terminal sessions)`，否则每会话一行含 id、可选名、类型、状态与可选 pid，并整体受上限约束（[packages/terminal/tool-terminal/src/render.ts:166-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/terminal/tool-terminal/src/render.ts#L166-L177)）

### packages/terminal/tool-terminal/tsconfig.json

该包的 TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
