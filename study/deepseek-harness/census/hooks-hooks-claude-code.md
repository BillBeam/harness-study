---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/hooks/hooks-claude-code
---

# packages/hooks/hooks-claude-code

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、57 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/hooks/hooks-claude-code/README.md

包的说明文档，介绍该桥接支持哪些 hook 事件、配置字段、模型可见文本以及与参考实现的差异。

- 无运行期机制

### packages/hooks/hooks-claude-code/package.json

包清单，声明该桥接插件的入口、发布内容与依赖关系。

- `main` / `types` 把默认入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/hooks/hooks-claude-code/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 和 `./package.json` 四个可解析入口（[packages/hooks/hooks-claude-code/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 和类型声明（[packages/hooks/hooks-claude-code/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/package.json#L28-L32)）
- `dependencies` 把 schema 库列为运行期真实依赖（其余能力包为 peer）（[packages/hooks/hooks-claude-code/package.json:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/package.json#L34-L36)）

### packages/hooks/hooks-claude-code/src/config.ts

把 Claude Code 方言的 hook 配置解析成共享的匹配组结构，供桥接入口在装载时调用。

- 常量 `CLAUDE_EVENTS` 列出被解析的七个事件，未列出的事件在解析前即被忽略（[packages/hooks/hooks-claude-code/src/config.ts:11-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L11-L19)）
- `substituteCommand` 在解析期把命令串里的 `${CLAUDE_PLUGIN_ROOT}` 与 `${CLAUDE_PROJECT_DIR}` 全部替换，未设置的变量保持原样（[packages/hooks/hooks-claude-code/src/config.ts:57-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L57-L62)）
- 同时接受带 `hooks` 键的设置文件与裸事件映射两种形状（[packages/hooks/hooks-claude-code/src/config.ts:82-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L82-L84)）
- 只遍历受支持事件，值不是数组则跳过（[packages/hooks/hooks-claude-code/src/config.ts:86-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L86-L88)）
- 缺 `hooks` 数组的组、非对象的 hook 条目被直接忽略（[packages/hooks/hooks-claude-code/src/config.ts:90-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L90-L96)）
- `type` 缺省视为 `command`，非 command 的 hook 进入 skipped 列表而不运行（[packages/hooks/hooks-claude-code/src/config.ts:97-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L97-L101)）
- `command` 非字符串的条目被丢弃，数值 `timeout` 被记为 `timeoutSec`（[packages/hooks/hooks-claude-code/src/config.ts:102-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L102-L106)）
- 没有可运行命令的组被丢弃（[packages/hooks/hooks-claude-code/src/config.ts:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L108)）
- UserPromptSubmit 与 Stop 上的 matcher 字段被丢弃，其余事件取字符串 matcher（[packages/hooks/hooks-claude-code/src/config.ts:109-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L109-L111)）
- 可运行组带非法 matcher 时抛出 `SyntaxError`，使整份配置在注册监听器之前被拒（[packages/hooks/hooks-claude-code/src/config.ts:112-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L112-L113)）
- 只有含至少一个组的事件才写入解析结果（[packages/hooks/hooks-claude-code/src/config.ts:119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/config.ts#L119)）

### packages/hooks/hooks-claude-code/src/index.ts

桥接插件入口，把解析出的 Claude Code hook 挂到会话启动、prompt、工具前后、停止与子代理生命周期扩展点上。

- 声明 `inject = ['shell']`，其余服务用 `ctx.get` 机会性读取（[packages/hooks/hooks-claude-code/src/index.ts:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L39-L42)）
- `Config` schema 规定 `configPath` 必填，并给出超时与 stderr 摘要上限的默认值（[packages/hooks/hooks-claude-code/src/index.ts:72-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L72-L78)）
- 进程级自增计数器生成 `claude-code:<point>:<n>` 形式的 handlerId，使日志中的 invoked/result 成对（[packages/hooks/hooks-claude-code/src/index.ts:81-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L81-L84)）
- 常量 `PLUGIN_SOURCE` 给该桥接注入的每条消息打上插件来源标记（[packages/hooks/hooks-claude-code/src/index.ts:87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L87)）
- `assertPositiveInteger` 在摘要上限非正整数时抛错，且在解析配置之前先做校验（[packages/hooks/hooks-claude-code/src/index.ts:90-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L90-L99)）
- 装载时同步读取并解析一次配置文件，跳过的 hook 逐条 warn（[packages/hooks/hooks-claude-code/src/index.ts:102-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L102-L112)）
- 读取或解析失败时只打一条 warn 并直接返回，一个监听器都不注册（[packages/hooks/hooks-claude-code/src/index.ts:113-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L113-L116)）
- 建立分离运行登记表，并以 `ctx.effect` 把排空注册为插件的释放动作（[packages/hooks/hooks-claude-code/src/index.ts:120-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L120-L126)）
- 用一张 runId → 子 Agent 的表，在子代理开始时保留其句柄直到配对的结束边（[packages/hooks/hooks-claude-code/src/index.ts:125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L125)）
- `runPoint` 取该 hook 点的匹配组，并按 `claude-code` 模式用匹配对象过滤（[packages/hooks/hooks-claude-code/src/index.ts:143-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L143-L153)）
- hook 进程的工作目录取自该 Agent 会话头上的 cwd，而不是进程启动目录（[packages/hooks/hooks-claude-code/src/index.ts:147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L147)）
- `CLAUDE_PROJECT_DIR` 环境变量优先取配置值，否则回落到该会话工作目录（[packages/hooks/hooks-claude-code/src/index.ts:150-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L150-L151)）
- 有会话且给出 turn 时，运行前追加 `hook/invoked`，并带上命中的 matcher（[packages/hooks/hooks-claude-code/src/index.ts:157-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L157-L162)）
- 逐个串行运行命中的 hook，stdin 带尾随换行，并把当前 hook 点作为期望事件名传下去（[packages/hooks/hooks-claude-code/src/index.ts:163-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L163-L174)）
- hook 返回 `updatedInput` 时只打 warn，不改写工具输入（[packages/hooks/hooks-claude-code/src/index.ts:175-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L175-L177)）
- hook 返回 `systemMessage` 时只打 warn，不呈现给任何人（[packages/hooks/hooks-claude-code/src/index.ts:178-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L178-L180)）
- 运行结束后按配置的摘要上限追加 `hook/result`，与前面的 invoked 配对（[packages/hooks/hooks-claude-code/src/index.ts:181-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L181-L183)）
- 该点所有 hook 的结果折叠成一个最严格结果返回（[packages/hooks/hooks-claude-code/src/index.ts:186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L186)）
- `contextFrom` 把累积的 additionalContext 逐条变成文本块，组装成带插件来源的用户消息；无内容则返回 undefined（[packages/hooks/hooks-claude-code/src/index.ts:192-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L192-L196)）
- `agent/session-start` 上以分离方式运行 SessionStart hook，结果就绪后把上下文注入该 Agent，失败只 warn（[packages/hooks/hooks-claude-code/src/index.ts:206-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L206-L215)）
- `agent/pre-step` 上无消息则直接 `next()`，否则把 prompt 文本作为载荷运行 UserPromptSubmit（[packages/hooks/hooks-claude-code/src/index.ts:219-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L219-L222)）
- 折叠结果为 `deny` 时直接返回 `reject`，该 prompt 不进入模型请求（[packages/hooks/hooks-claude-code/src/index.ts:223-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L223-L225)）
- 非阻塞时先 `next()` 委派下游，再仅在下游为 `enter` 时把本插件的上下文消息追加到其消息列表尾部（[packages/hooks/hooks-claude-code/src/index.ts:228-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L228-L234)）
- `tools/pre-execute` 上以工具名为匹配对象运行 PreToolUse，`deny` 映射为拒绝（缺 reason 时用 `blocked by PreToolUse hook`），`ask` 映射为征询，否则 `next()`（[packages/hooks/hooks-claude-code/src/index.ts:238-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L238-L244)）
- `tools/post-execute` 上 `deny` 映射为带反馈文本的 block，缺 reason 时用 `blocked by PostToolUse hook`，并附上上下文（[packages/hooks/hooks-claude-code/src/index.ts:247-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L247-L253)）
- 未阻塞时先 `next()`，再把本插件上下文前置到下游决定的 `additionalContexts`（下游 block 也照样带上）（[packages/hooks/hooks-claude-code/src/index.ts:256-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L256-L264)）
- `agent/turn-stopping` 上运行 Stop hook，`deny` 时用 `agent.steer` 送入一条继续指令（缺 reason 时文本为 `continue: blocked by Stop hook`），从而让循环再转一步（[packages/hooks/hooks-claude-code/src/index.ts:270-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L270-L277)）
- `subagent/start` 上从 `agents` 服务取回子 Agent 存入表中，并以分离方式运行 SubagentStart，就绪后把上下文注入活着的子 Agent（[packages/hooks/hooks-claude-code/src/index.ts:281-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L281-L290)）
- `subagent/end` 上先从表中取回并删除子 Agent，再以分离方式运行 SubagentStop（不注入任何结果）（[packages/hooks/hooks-claude-code/src/index.ts:291-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L291-L295)）
- 常量 `SUBAGENT_TYPE = 'general-purpose'` 是子代理事件唯一上报的 `agent_type`，决定哪些 matcher 会命中（[packages/hooks/hooks-claude-code/src/index.ts:304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L304)）
- `lastTurn` 反向扫描会话事件取最后一个 `turn/start` 的 turn 号，无 Agent 时取 0（[packages/hooks/hooks-claude-code/src/index.ts:310-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L310-L315)）
- `blocksToText` 只保留文本块并拼接，非文本内容不进入 hook 载荷（[packages/hooks/hooks-claude-code/src/index.ts:318-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L318-L320)）
- `base` 组装每个事件共有的 stdin 字段：会话 id、经持久化服务定位的 transcript 路径（取不到为空串）、cwd 与事件名（[packages/hooks/hooks-claude-code/src/index.ts:322-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L322-L331)）
- 各事件的专属载荷字段：SessionStart 带 source，UserPromptSubmit 带 prompt 文本（[packages/hooks/hooks-claude-code/src/index.ts:333-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L333-L338)）
- 工具事件载荷带 `tool_name`、原始 `tool_input`、`tool_use_id`，PostToolUse 另把结果内容压平成文本 `tool_response`（[packages/hooks/hooks-claude-code/src/index.ts:339-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L339-L344)）
- Stop 载荷里的 `stop_hook_active` 恒为 false（[packages/hooks/hooks-claude-code/src/index.ts:345-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L345-L347)）
- 子代理载荷带 `agent_id` 与恒定 `agent_type`，`stop_hook_active` 仅在 SubagentStop 上出现且恒为 false（[packages/hooks/hooks-claude-code/src/index.ts:354-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/index.ts#L354-L361)）

### packages/hooks/hooks-claude-code/src/invariant.ts

包自带的不变量伴生插件，向 `invariants` 服务登记本包的所有权。

- 声明 `inject = ['invariants']`（[packages/hooks/hooks-claude-code/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/invariant.ts#L15)）
- 安装器为空实现，运行期不注册任何检查（[packages/hooks/hooks-claude-code/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该安装器并返回其 disposer（[packages/hooks/hooks-claude-code/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hooks-claude-code/src/invariant.ts#L28-L29)）

### packages/hooks/hooks-claude-code/tsconfig.json

包的 TypeScript 编译配置，声明源码根、输出目录与工作区引用。

- 无运行期机制
