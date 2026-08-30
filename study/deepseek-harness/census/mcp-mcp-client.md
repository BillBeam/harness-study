---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/mcp/mcp-client
---

# packages/mcp/mcp-client

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、75 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/mcp/mcp-client/README.md

MCP 客户端桥接包的英文说明文档，面向配置和调试外部 MCP 服务器连接的人，描述配置字段、工具命名、重连与结果投影行为。

- 无运行期机制

### packages/mcp/mcp-client/package.json

该包的 npm 清单，声明入口、导出与随包发布的文件集合。

- `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/mcp/mcp-client/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/package.json#L14-L15)）
- `exports` 只开放根入口、`./invariant`、`./src/*` 与 `./package.json` 四个解析点（[packages/mcp/mcp-client/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 和类型声明（[packages/mcp/mcp-client/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/package.json#L28-L32)）

### packages/mcp/mcp-client/src/connection.ts

连接监管器：为一个插件实例持有 MCP 客户端/传输的"代"，维持工具注册与实时连接一致，并在断连后按退避策略重启。被 `src/index.ts` 的 `apply` 调用。

- `RECONNECT_DEFAULTS` 冻结重连默认值：启用、首延迟 500ms、上限 30000ms、最多 10 次（[packages/mcp/mcp-client/src/connection.ts:40-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L40-L45)）
- `GENERATION_CLOSE_TIMEOUT_MS` 把等待一代关闭的时间定为 5000ms（[packages/mcp/mcp-client/src/connection.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L50)）
- `resolveReconnectPolicy` 对 `reconnect` 中的未知键抛错（[packages/mcp/mcp-client/src/connection.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L66-L70)）
- 缺省字段以默认值补齐后返回冻结策略（[packages/mcp/mcp-client/src/connection.ts:71-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L71-L74)）
- 延迟必须是不超过定时器上限的正有限数、首延迟不得大于上限、最大次数必须是正整数，否则抛错（[packages/mcp/mcp-client/src/connection.ts:76-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L76-L89)）
- `startConnection` 组装桥接选项：默认把注册冲突就地吞掉，配置 `failOnStartupError` 时首次同步改为抛出（[packages/mcp/mcp-client/src/connection.ts:125-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L125-L135)）
- `isCurrent` 让任何动作只在"未销毁且是当前代"时生效（[packages/mcp/mcp-client/src/connection.ts:153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L153)）
- `enqueueSync` 把所有 `syncTools` 串行进一条链，非当前代直接跳过，失败不断链（[packages/mcp/mcp-client/src/connection.ts:161-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L161-L170)）
- `generationDown` 清空当前客户端引用并触发重连调度，重复的 close/error 信号幂等（[packages/mcp/mcp-client/src/connection.ts:173-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L173-L178)）
- `waitForClose` 在 5 秒内没等到关闭信号就返回 false，定时器 unref（[packages/mcp/mcp-client/src/connection.ts:181-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L181-L190)）
- 重连被禁用时只按"已建立过连接"与否打印不同错误并返回，不再重试（[packages/mcp/mcp-client/src/connection.ts:193-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L193-L200)）
- 上一次连接存活超过 `maxDelayMs` 就把失败计数清零（[packages/mcp/mcp-client/src/connection.ts:203-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L203-L205)）
- 连续失败超过 `maxAttempts` 时把"注销全部工具"排进同步链并停止重连（[packages/mcp/mcp-client/src/connection.ts:206-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L206-L215)）
- 重连延迟按 `min(maxDelayMs, initialDelayMs * 2^(n-1))` 递增（[packages/mcp/mcp-client/src/connection.ts:216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L216)）
- 重连定时器到点后发起新一次连接尝试，并 unref 以免独自撑住进程（[packages/mcp/mcp-client/src/connection.ts:219-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L219-L224)）
- 每次尝试新建一个 `Client`，向服务器报出客户端名与版本、空能力集（[packages/mcp/mcp-client/src/connection.ts:238-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L238-L241)）
- `onclose` 记录已关闭并在尝试已结算时把该代转入 down（[packages/mcp/mcp-client/src/connection.ts:248-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L248-L254)）
- 在 connect 之前注册 `tools/list_changed` 处理器，收到通知即排队重新同步；抓取阶段失败只打日志、保留上一代工具（[packages/mcp/mcp-client/src/connection.ts:257-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L257-L270)）
- connect 成功后若连接已关闭则直接转 down，否则排队首次工具同步（首次用严格选项）（[packages/mcp/mcp-client/src/connection.ts:271-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L271-L278)）
- 尝试失败时记下首次错误、关闭该代并等待关闭确认（[packages/mcp/mcp-client/src/connection.ts:279-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L279-L287)）
- 失败的一代未在超时内关闭时停止重连，避免子进程重叠（[packages/mcp/mcp-client/src/connection.ts:288-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L288-L295)）
- 连接与首次同步成功后记录连接时刻，若之前有失败则打印重连成功日志（[packages/mcp/mcp-client/src/connection.ts:297-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L297-L305)）
- 模块返回前立即发起首次连接（[packages/mcp/mcp-client/src/connection.ts:308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L308)）
- `ready` 在首次尝试结算后给出结果：客户端存在即成功，否则带上首次错误（[packages/mcp/mcp-client/src/connection.ts:313-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L313-L323)）
- `dispose` 置销毁标志、清重连定时器、关闭当前客户端并等待其关闭（超时打错误）（[packages/mcp/mcp-client/src/connection.ts:327-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L327-L342)）
- `dispose` 等待在途尝试与同步链静默后注销该服务器的全部工具注册（[packages/mcp/mcp-client/src/connection.ts:343-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/connection.ts#L343-L348)）

### packages/mcp/mcp-client/src/index.ts

插件入口：定义配置模式、预约服务器命名空间、启动连接监管器，并在激活前等待首次连接与工具发现完成。

- 导出插件名与所需服务 `tools`（[packages/mcp/mcp-client/src/index.ts:29-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L29-L32)）
- 单次工具调用默认超时 60000ms（[packages/mcp/mcp-client/src/index.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L35)）
- `serverName` 必须匹配 `[A-Za-z0-9_-]{1,32}`（[packages/mcp/mcp-client/src/index.ts:38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L38)）
- 以注册作用域为键的 WeakMap 保存活跃的 `serverName` 预约（[packages/mcp/mcp-client/src/index.ts:45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L45)）
- `Reconnect` 模式给四个重连字段设定取值范围与默认值（[packages/mcp/mcp-client/src/index.ts:106-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L106-L111)）
- `Config` 是 stdio 与 streamable-http 两支的联合，各自定义必填项与默认值（args/env/cwd/headers/超时/启动失败开关）（[packages/mcp/mcp-client/src/index.ts:113-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L113-L134)）
- `apply` 先解析重连策略，配置非法时在任何 effect 注册前失败（[packages/mcp/mcp-client/src/index.ts:150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L150)）
- 以 effect 在当前作用域预约 `serverName`，重名即抛错，销毁时释放（[packages/mcp/mcp-client/src/index.ts:154-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L154-L168)）
- 启动连接监管器并把它的 `dispose` 挂到一个 effect 上（[packages/mcp/mcp-client/src/index.ts:173-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L173-L177)）
- 激活阻塞在首次连接与工具发现上；`failOnStartupError` 为真时首次失败抛错让 fiber 回滚（[packages/mcp/mcp-client/src/index.ts:184-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/index.ts#L184-L187)）

### packages/mcp/mcp-client/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属。

- 以空安装器向不变量服务注册该包名，不安装任何运行期检查，并返回注册的 disposer（[packages/mcp/mcp-client/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/invariant.ts#L21-L29)）

### packages/mcp/mcp-client/src/tools.ts

工具桥：发现 MCP 工具、按确定性公共名注册到工具运行时、执行调用并把 MCP 结果投影成模型可见内容。被 `connection.ts` 的同步链调用。

- 公共工具名长度上限 64（[packages/mcp/mcp-client/src/tools.ts:49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L49)）
- 公共名只允许 `[A-Za-z0-9_-]`，其余字符被替换（[packages/mcp/mcp-client/src/tools.ts:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L52)）
- 有损归一化时追加 12 位十六进制哈希（[packages/mcp/mcp-client/src/tools.ts:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L55)）
- 调用结果按任意键值记录解析，验证交给本包（[packages/mcp/mcp-client/src/tools.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L58)）
- 可持久化图片媒体类型限定为 PNG/JPEG/WebP/GIF（[packages/mcp/mcp-client/src/tools.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L61-L66)）
- 只接受规范 base64，不接受空白与 URL-safe 变体（[packages/mcp/mcp-client/src/tools.ts:69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L69)）
- `tools/list` 走裸 request，绕开 SDK 的分页输出校验缓存，并透传 cursor（[packages/mcp/mcp-client/src/tools.ts:72-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L72-L77)）
- `tools/call` 走裸 request，携带原始工具名、参数、取消信号与配置超时（[packages/mcp/mcp-client/src/tools.ts:80-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L80-L95)）
- `publicToolName` 由 `mcp__<serverName>__<rawName>` 归一化得到，被改动或超长时截断并拼接身份哈希（[packages/mcp/mcp-client/src/tools.ts:111-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L111-L117)）
- `syncTools` 第一阶段循环拉完分页工具列表并构建下一代定义（[packages/mcp/mcp-client/src/tools.ts:149-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L149-L174)）
- 同一公共名重复出现时抛错，整个列表作废（[packages/mcp/mcp-client/src/tools.ts:156-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L156-L160)）
- 第二阶段先注销上一代全部注册，再逐个注册新一代（[packages/mcp/mcp-client/src/tools.ts:176-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L176-L182)）
- 注册冲突时回滚已注册的部分并打错误，按选项抛出或返回空注册表（[packages/mcp/mcp-client/src/tools.ts:183-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L183-L192)）
- 服务器声明的 `outputSchema` 若不在受支持词汇内则丢弃，退回无约束 JSON（[packages/mcp/mcp-client/src/tools.ts:221-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L221-L229)）
- `finalizeContent` 只在结果非错误、且 value 与已渲染内容都与执行期准备的一致时才装入图片投影（[packages/mcp/mcp-client/src/tools.ts:262-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L262-L270)）
- `output.schema` 规定 `content` 必填、有结构化模式时 `structuredContent` 亦必填且禁止额外属性（[packages/mcp/mcp-client/src/tools.ts:276-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L276-L285)）
- `output.render` 把规范结果投影为一段文本块（[packages/mcp/mcp-client/src/tools.ts:286-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L286-L289)）
- 声明需要任务式执行的工具在调用时直接抛错（[packages/mcp/mcp-client/src/tools.ts:312-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L312-L314)）
- 模型给出的非对象参数回退成 `{}`，让服务器产出具体的缺参错误（[packages/mcp/mcp-client/src/tools.ts:319-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L319-L320)）
- `content` 非数组时归一化旧式 `toolResult`（或 `(no output)`），且 `isError` 为真则抛错（[packages/mcp/mcp-client/src/tools.ts:322-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L322-L335)）
- MCP 返回 `isError: true` 时以提取出的文本抛错，使工具运行时产出失败结果（[packages/mcp/mcp-client/src/tools.ts:343-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L343-L346)）
- 返回的规范值保留完整 MCP 块与可选结构化内容；含图片时先准备一份投影并按执行体登记（[packages/mcp/mcp-client/src/tools.ts:348-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L348-L359)）
- `decodeImage` 拒绝非受支持媒体类型，并要求数据是可往返的规范 base64（[packages/mcp/mcp-client/src/tools.ts:379-391](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L379-L391)）
- `resolveImageAdmission` 要求附件存储在场、能解析出当前模型路由、且该模型声明支持图片输入，否则抛错（[packages/mcp/mcp-client/src/tools.ts:399-419](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L399-L419)）
- 任一图片解码失败时，整批图片都降级为带原因的诊断文本（[packages/mcp/mcp-client/src/tools.ts:442-460](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L442-L460)）
- 准入解析失败时整批图片降级为诊断文本（[packages/mcp/mcp-client/src/tools.ts:462-469](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L462-L469)）
- 批量落盘成功后按原索引把图片块投影为附件引用，失败则整批降级为诊断文本（[packages/mcp/mcp-client/src/tools.ts:471-486](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L471-L486)）
- `extractText` 把投影后的块拼成单一字符串（[packages/mcp/mcp-client/src/tools.ts:497-502](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L497-L502)）
- `projectContent` 按原顺序投影：文本块合并、图片块打断文本串、资源链接保留名与 URI、音频/内嵌资源/未知类型各自成占位文本（[packages/mcp/mcp-client/src/tools.ts:509-554](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L509-L554)）
- 无任何可见内容时产出一条"该工具没有返回模型可见内容"的文本（[packages/mcp/mcp-client/src/tools.ts:555-558](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/tools.ts#L555-L558)）

### packages/mcp/mcp-client/src/transport.ts

传输工厂：按解析后的配置创建 stdio 或 Streamable HTTP 传输，被 `connection.ts` 的每次连接尝试调用。

- 子进程环境由清洗过的父进程环境加上配置 `env` 合并而成，配置项覆盖清洗结果（[packages/mcp/mcp-client/src/transport.ts:21-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/transport.ts#L21-L23)）
- stdio 分支用配置的命令、参数、环境与工作目录构造子进程传输（[packages/mcp/mcp-client/src/transport.ts:33-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/transport.ts#L33-L39)）
- streamable-http 分支用配置 URL 与附加请求头构造 HTTP 传输（[packages/mcp/mcp-client/src/transport.ts:40-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/mcp/mcp-client/src/transport.ts#L40-L48)）

### packages/mcp/mcp-client/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、输出目录与工作区项目引用。

- 无运行期机制
