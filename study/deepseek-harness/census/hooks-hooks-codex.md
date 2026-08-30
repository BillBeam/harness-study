---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/hooks/hooks-codex
---

# packages/hooks/hooks-codex

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、52 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/hooks/hooks-codex/README.md

包的说明文档，介绍该桥接支持的五个 hook 事件、配置字段、模型可见文本以及与参考实现的差异。

- 无运行期机制

### packages/hooks/hooks-codex/package.json

包清单，声明该桥接插件的入口、发布内容与依赖关系。

- `main` / `types` 把默认入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/hooks/hooks-codex/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 和 `./package.json` 四个可解析入口（[packages/hooks/hooks-codex/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 和类型声明（[packages/hooks/hooks-codex/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/package.json#L28-L32)）
- `dependencies` 把 schema 库列为运行期真实依赖（其余能力包为 peer）（[packages/hooks/hooks-codex/package.json:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/package.json#L34-L36)）

### packages/hooks/hooks-codex/src/config.ts

把 Codex 方言的 hook 配置解析成共享的匹配组结构，供桥接入口在装载时调用。

- 导出常量 `CODEX_EVENTS`，只解析这五个事件，其余事件配置被静默丢弃（[packages/hooks/hooks-codex/src/config.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L11)）
- 同时接受带 `hooks` 键的包裹形状与裸事件映射（[packages/hooks/hooks-codex/src/config.ts:46-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L46-L48)）
- 事件值不是数组、组缺 `hooks` 数组、hook 条目非对象时逐层跳过而不报错（[packages/hooks/hooks-codex/src/config.ts:55-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L55-L63)）
- `type` 缺省视为 `command`，非 command 的 hook 记入 skipped 并附带原因（[packages/hooks/hooks-codex/src/config.ts:64-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L64-L65)）
- `async: true` 的 hook 被跳过，只有同步命令 hook 会运行（[packages/hooks/hooks-codex/src/config.ts:67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L67)）
- `command` 非字符串的条目被丢弃（[packages/hooks/hooks-codex/src/config.ts:68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L68)）
- 超时同时接受 `timeout` 与 `timeoutSec` 两种写法，命令串不做任何变量替换（[packages/hooks/hooks-codex/src/config.ts:70-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L70-L72)）
- 没有可运行命令的组被丢弃（[packages/hooks/hooks-codex/src/config.ts:74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L74)）
- UserPromptSubmit 与 Stop 上的 matcher 字段被丢弃，其余事件取字符串 matcher（[packages/hooks/hooks-codex/src/config.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L75-L77)）
- 可运行组带非法正则 matcher 时抛出 `SyntaxError`，使整份配置在注册监听器之前被拒（[packages/hooks/hooks-codex/src/config.ts:78-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L78-L79)）
- 只有含至少一个组的事件才写入解析结果（[packages/hooks/hooks-codex/src/config.ts:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/config.ts#L82)）

### packages/hooks/hooks-codex/src/index.ts

桥接插件入口，把解析出的 Codex hook 挂到会话启动、prompt、工具前后与停止五个扩展点上。

- 声明 `inject = ['shell']`（[packages/hooks/hooks-codex/src/index.ts:40-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L40-L41)）
- `Config` schema 规定 `configPath` 必填，`model` 默认空串，并给出超时与 stderr 摘要上限的默认值（[packages/hooks/hooks-codex/src/index.ts:60-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L60-L65)）
- 进程级自增计数器生成 `codex:<point>:<n>` 形式的 handlerId，使日志中的 invoked/result 成对（[packages/hooks/hooks-codex/src/index.ts:67-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L67-L70)）
- 常量 `PLUGIN_SOURCE` 给该桥接注入的每条消息打上插件来源标记（[packages/hooks/hooks-codex/src/index.ts:72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L72)）
- `assertPositiveInteger` 在摘要上限非正整数时抛错，且在解析配置之前先做校验（[packages/hooks/hooks-codex/src/index.ts:75-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L75-L84)）
- 装载时同步读取并解析一次配置文件，跳过的 hook 逐条 warn（[packages/hooks/hooks-codex/src/index.ts:86-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L86-L93)）
- 读取或解析失败时只打一条 warn 并直接返回，一个监听器都不注册（[packages/hooks/hooks-codex/src/index.ts:94-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L94-L97)）
- 建立分离运行登记表，并以 `ctx.effect` 把排空注册为插件的释放动作（[packages/hooks/hooks-codex/src/index.ts:104-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L104-L105)）
- `runPoint` 取该 hook 点的匹配组，并一律按 `codex` 正则模式过滤（[packages/hooks/hooks-codex/src/index.ts:124-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L124-L131)）
- hook 进程的工作目录取自该 Agent 会话头上的 cwd（[packages/hooks/hooks-codex/src/index.ts:128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L128)）
- 有会话且给出 turn 时，运行前追加 `hook/invoked`，并带上命中的 matcher（[packages/hooks/hooks-codex/src/index.ts:135-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L135-L140)）
- 逐个串行运行命中的 hook，stdin 不带尾随换行，并把当前 hook 点作为期望事件名传下去（[packages/hooks/hooks-codex/src/index.ts:141-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L141-L149)）
- 在开启该选项的 hook 点上，退出码为 0、没有结构化上下文、且 stdout 非空又不以 `{` 开头时，把纯文本 stdout 提升为 `additionalContext`（[packages/hooks/hooks-codex/src/index.ts:152-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L152-L156)）
- hook 返回 `systemMessage` 时只打 warn，不呈现给任何人（[packages/hooks/hooks-codex/src/index.ts:161-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L161-L163)）
- 运行结束后按配置的摘要上限追加 `hook/result`，与前面的 invoked 配对（[packages/hooks/hooks-codex/src/index.ts:164-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L164-L166)）
- 该点所有 hook 的结果折叠成一个最严格结果返回（[packages/hooks/hooks-codex/src/index.ts:169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L169)）
- `contextFrom` 把累积的 additionalContext 逐条变成文本块，组装成带插件来源的用户消息；无内容则返回 undefined（[packages/hooks/hooks-codex/src/index.ts:174-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L174-L178)）
- `agent/session-start` 上以分离方式运行 SessionStart hook（开启纯 stdout 提升），结果就绪后把上下文注入该 Agent，失败只 warn（[packages/hooks/hooks-codex/src/index.ts:188-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L188-L196)）
- `agent/pre-step` 上无消息则直接 `next()`，否则以带 `turn_id` 与 prompt 文本的载荷运行 UserPromptSubmit（同样开启纯 stdout 提升）（[packages/hooks/hooks-codex/src/index.ts:199-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L199-L208)）
- 折叠结果为 `deny` 时直接返回 `reject`，该 prompt 不进入模型请求（[packages/hooks/hooks-codex/src/index.ts:210-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L210-L212)）
- 非阻塞时先 `next()` 委派下游，再仅在下游为 `enter` 时把本插件的上下文消息追加到其消息列表尾部（[packages/hooks/hooks-codex/src/index.ts:215-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L215-L221)）
- `tools/pre-execute` 上以工具名为匹配对象运行 PreToolUse，只认 `deny`（缺 reason 时用 `blocked by PreToolUse hook`），其余一律 `next()`（[packages/hooks/hooks-codex/src/index.ts:225-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L225-L231)）
- `tools/post-execute` 上 `deny` 映射为带反馈文本的 block，缺 reason 时用 `blocked by PostToolUse hook`，并附上上下文（[packages/hooks/hooks-codex/src/index.ts:234-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L234-L241)）
- 未阻塞时先 `next()`，再把本插件上下文前置到下游决定的 `additionalContexts`（下游 block 也照样带上）（[packages/hooks/hooks-codex/src/index.ts:244-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L244-L252)）
- `agent/turn-stopping` 上以带 `stop_hook_active: false` 与 `last_assistant_message: null` 的载荷运行 Stop hook（[packages/hooks/hooks-codex/src/index.ts:260-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L260-L261)）
- Stop 折叠结果为 `deny` 时用 `agent.steer` 送入一条继续指令（缺 reason 时文本为 `continue: blocked by Stop hook`），从而让循环再转一步（[packages/hooks/hooks-codex/src/index.ts:263-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L263-L269)）
- `lastTurn` 反向扫描会话事件取最后一个 `turn/start` 的 turn 号，无 Agent 时取 0（[packages/hooks/hooks-codex/src/index.ts:279-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L279-L284)）
- `blocksToText` 只保留文本块并拼接，非文本内容不进入 hook 载荷（[packages/hooks/hooks-codex/src/index.ts:286-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L286-L288)）
- `base` 组装每个事件共有的 stdin 字段：会话 id、经持久化服务定位的 transcript 路径（取不到为 null）、cwd、事件名、配置里的 model 以及恒定的 `permission_mode: 'default'`（[packages/hooks/hooks-codex/src/index.ts:292-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L292-L303)）
- `turnBase` 在基础字段上追加字符串化的 `turn_id`，供 turn 范围内的事件使用（[packages/hooks/hooks-codex/src/index.ts:306-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L306-L308)）
- `commandOf` 从工具调用参数里取字符串 `command`，取不到时用空串（[packages/hooks/hooks-codex/src/index.ts:311-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L311-L317)）
- 工具事件载荷带真实 `tool_name`、被压成 `{ command }` 的 `tool_input` 与 `tool_use_id`，PostToolUse 另把结果内容压平成文本 `tool_response`（[packages/hooks/hooks-codex/src/index.ts:319-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/index.ts#L319-L329)）

### packages/hooks/hooks-codex/src/invariant.ts

包自带的不变量伴生插件，向 `invariants` 服务登记本包的所有权。

- 声明 `inject = ['invariants']`（[packages/hooks/hooks-codex/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/invariant.ts#L15)）
- 安装器为空实现，运行期不注册任何检查（[packages/hooks/hooks-codex/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该安装器并返回其 disposer（[packages/hooks/hooks-codex/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-codex/src/invariant.ts#L28-L29)）

### packages/hooks/hooks-codex/tsconfig.json

包的 TypeScript 编译配置，声明源码根、输出目录与工作区引用。

- 无运行期机制
