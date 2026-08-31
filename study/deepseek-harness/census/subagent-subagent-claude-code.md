---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/subagent-claude-code
---

# packages/subagent/subagent-claude-code

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、62 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/subagent-claude-code/README.md

该包的说明文档，面向选择产品后端、安装 Profile 包或配置无人值守委派的读者。

- 无运行期机制

### packages/subagent/subagent-claude-code/cordis.patch.yml

随包发布的 Profile 补丁层，安装后由加载器合入目标 Profile 的插件表。

- 向 Profile 插入一条 id 为 `subagent-claude-code` 的插件行，从而在该 Profile 启动时加载本包（[packages/subagent/subagent-claude-code/cordis.patch.yml:4-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/cordis.patch.yml#L4-L6)）

### packages/subagent/subagent-claude-code/package.json

该包的 npm 清单，决定它被解析、发布、作为 Profile 包安装以及依赖钉版的方式。

- 声明 ESM 包并把默认入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/subagent/subagent-claude-code/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/subagent/subagent-claude-code/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/package.json#L16-L27)）
- `files` 把发布内容限定为两个运行时产物、补丁层文件与类型声明（[packages/subagent/subagent-claude-code/package.json:28-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/package.json#L28-L33)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，安装该包时由它提供 Profile 补丁层（[packages/subagent/subagent-claude-code/package.json:35-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/package.json#L35-L39)）
- 运行时依赖把 Agent SDK 钉在 `0.3.241`、Anthropic SDK 钉在 `0.93.0`（[packages/subagent/subagent-claude-code/package.json:49-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/package.json#L49-L55)）

### packages/subagent/subagent-claude-code/src/index.ts

插件入口：声明配置模式，在加载期校验并把一个按 Profile 命名的提供者注册到子代理注册表上。

- 插件以具名导出发布 `name` 与 `inject`，注入 `subagents` 与 `subprocess` 两个服务（[packages/subagent/subagent-claude-code/src/index.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/index.ts#L30-L31)）
- 配置模式给出默认值：注册名默认 `claude-code` 且非空、`model` 可省且非空、`env` 默认空字典、`permissionMode` 取自固定枚举且默认 `dontAsk`、`disposeGraceMs` 默认 3000（[packages/subagent/subagent-claude-code/src/index.ts:59-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/index.ts#L59-L66)）
- 提供者复用共享的「无启动能力」广告，并把 `inheritsParentContext` 固定为 `false`（[packages/subagent/subagent-claude-code/src/index.ts:74-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/index.ts#L74-L75)）
- `start` 先读父会话 header 的 cwd，缺失时直接抛出（[packages/subagent/subagent-claude-code/src/index.ts:84-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/index.ts#L84-L89)）
- 子进程工作目录以「无配置覆盖」的方式解析，实际只接受父会话 cwd（[packages/subagent/subagent-claude-code/src/index.ts:90-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/index.ts#L90-L96)）
- 解析失败时：信号已中止则抛固定的中止文案，否则抛掩盖原因的启动失败并把它写进 Host 日志（[packages/subagent/subagent-claude-code/src/index.ts:97-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/index.ts#L97-L109)）
- 运行规格只在配置了 `model` 时写入该字段，spawn 绑定到 `ctx.subprocess.spawn`，失败回调接到 Host 日志的 warn（[packages/subagent/subagent-claude-code/src/index.ts:110-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/index.ts#L110-L123)）
- 加载期把配置折算成解析后的形状，校验 `disposeGraceMs` 为正有限数且不超过定时器最大延迟，然后注册提供者（[packages/subagent/subagent-claude-code/src/index.ts:133-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/index.ts#L133-L155)）

### packages/subagent/subagent-claude-code/src/invariant.ts

该包的不变量伴生插件，向不变量注册表登记包名。

- 声明伴生插件名并注入 `invariants` 服务（[packages/subagent/subagent-claude-code/src/invariant.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/invariant.ts#L14-L16)）
- 用一个空安装器把包名注册进不变量注册表并返回其 disposer（[packages/subagent/subagent-claude-code/src/invariant.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/invariant.ts#L22-L30)）

### packages/subagent/subagent-claude-code/src/process.ts

把共享子进程句柄投影成官方 Agent SDK 自定义 spawn 所需的进程接口，供 `run.ts` 的查询选项使用。

- SDK 组好的子进程环境被转成覆盖层：SDK 保留的名字原样写入，SDK 移除但仍在清洗后父环境里的名字写成 `undefined` 墓碑（[packages/subagent/subagent-claude-code/src/process.ts:30-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/process.ts#L30-L38)）
- SDK 的 spawn 请求缺少工作目录时直接抛出（[packages/subagent/subagent-claude-code/src/process.ts:50-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/process.ts#L50-L52)）
- 转换出的 spawn 规格固定为命令加参数、SDK 的 cwd、stdin/stdout 管道且 stderr 继承、终止宽限、SDK 转发的信号与环境覆盖层（[packages/subagent/subagent-claude-code/src/process.ts:53-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/process.ts#L53-L60)）
- 构造时接管句柄的 stdin/stdout，预挂一个空的 `error` 监听避免无监听抛出，并把 `child.done` 的两个分支转成 `exit` 与 `error` 事件（[packages/subagent/subagent-claude-code/src/process.ts:78-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/process.ts#L78-L94)）
- `exitCode` 与 `signalCode` 在进程未退出时读出 `null`，`outcome` 暴露退出后的完整事实（[packages/subagent/subagent-claude-code/src/process.ts:96-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/process.ts#L96-L114)）
- `kill()` 忽略 SDK 选择的信号：已请求过或已退出时返回 `false`，否则置标志并调用共享句柄的 `terminate()`（[packages/subagent/subagent-claude-code/src/process.ts:121-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/process.ts#L121-L131)）
- `on`/`once`/`off` 把 SDK 的生命周期监听转发到内部事件发射器（[packages/subagent/subagent-claude-code/src/process.ts:134-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/process.ts#L134-L158)）

### packages/subagent/subagent-claude-code/src/run.ts

单次一次性运行的完整生命周期：构造官方 SDK 查询选项、消费消息流、判定成功、生成安全诊断并拆除进程树。

- 终止宽限默认 3000 毫秒（[packages/subagent/subagent-claude-code/src/run.ts:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L40)）
- 可选权限模式被限定为五个固定值（[packages/subagent/subagent-claude-code/src/run.ts:43-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L43-L49)）
- 默认权限模式为 `dontAsk`（[packages/subagent/subagent-claude-code/src/run.ts:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L55)）
- 向 SDK 声明支持的对话种类只有 `refusal_fallback_prompt` 一项（[packages/subagent/subagent-claude-code/src/run.ts:57-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L57-L59)）
- 失败诊断只由固定字段拼装：product、stage、category，以及仅在存在时追加的 exit code 与 signal（[packages/subagent/subagent-claude-code/src/run.ts:80-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L80-L95)）
- 失败错误的 message 只含固定诊断行，事实对象与可选原因分别保留在实例字段与 `cause` 链上（[packages/subagent/subagent-claude-code/src/run.ts:97-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L97-L108)）
- SDK 结果子类型按三种限额子类型归为 `limit`、执行错误归为 `product-error`、其余归为 `unknown`（[packages/subagent/subagent-claude-code/src/run.ts:110-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L110-L123)）
- 未发布阶段的启动失败对外统一呈现为 `query-start` / `unknown` 两项事实（[packages/subagent/subagent-claude-code/src/run.ts:130-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L130-L135)）
- 无人值守决定行只写权限模式、请求种类、决定与固定理由（[packages/subagent/subagent-claude-code/src/run.ts:137-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L137-L144)）
- 任务内容必须非空、必须全部是 `text` 块、且不能全为空白，通过后原样拼接成一条 SDK 提示（[packages/subagent/subagent-claude-code/src/run.ts:183-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L183-L198)）
- 只有 `subtype: 'success'`、`is_error` 为假且 `result` 去空白后非空的结果消息才算完成；非成功子类型带分类抛出且详情取自 SDK 的 `errors`，其余情况抛 `invalid-result`（[packages/subagent/subagent-claude-code/src/run.ts:205-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L205-L225)）
- 消息流被完整消费：`permission_denied` 系统消息触发回调后跳过，非 `result` 消息一律跳过，`result` 消息触发回调并参与判定（[packages/subagent/subagent-claude-code/src/run.ts:241-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L241-L249)）
- 迭代正常结束却没有可用答案时抛 `invalid-result`；有答案时返回单个文本块与 `completed`（[packages/subagent/subagent-claude-code/src/run.ts:250-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L250-L259)）
- 拆除依次关闭 SDK 查询、调用 `terminate()`、等待整棵树退出并读取 `done`，途中的失败被收集，单个直接作 cause、多个聚合后抛出 `teardown` 失败（[packages/subagent/subagent-claude-code/src/run.ts:269-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L269-L300)）
- 查询选项传入每次运行私有的 AbortController 与父会话 cwd，`model` 仅在配置时写入（[packages/subagent/subagent-claude-code/src/run.ts:319-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L319-L322)）
- 子进程环境为清洗后的父环境叠加显式配置项（[packages/subagent/subagent-claude-code/src/run.ts:323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L323)）
- 关闭 SDK 侧会话持久化（[packages/subagent/subagent-claude-code/src/run.ts:324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L324)）
- 始终禁用 `AskUserQuestion`，`plan` 模式下再禁用 `ExitPlanMode`（[packages/subagent/subagent-claude-code/src/run.ts:325-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L325-L327)）
- 权限模式直接透传给 SDK（[packages/subagent/subagent-claude-code/src/run.ts:328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L328)）
- `bypassPermissions` 模式显式打开 SDK 的危险跳过开关；其余模式装一个一律返回 `deny` 的工具许可回调并记下一条无人值守决定（[packages/subagent/subagent-claude-code/src/run.ts:329-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L329-L344)）
- MCP 征询一律 `decline`，阻塞式用户对话一律 `cancelled`，两者各记一条无人值守决定（[packages/subagent/subagent-claude-code/src/run.ts:345-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L345-L362)）
- 自定义 spawn 钩子把 SDK 的进程请求转到共享子进程服务，并把句柄与投影对象同步回调给启动流程（[packages/subagent/subagent-claude-code/src/run.ts:364-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L364-L369)）
- 启动先校验并拼接任务文本，再检查请求信号是否已中止（[packages/subagent/subagent-claude-code/src/run.ts:383-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L383-L386)）
- 每次运行自建一个 AbortController，本地取消通过它 abort，并由请求信号上的一次性监听触发（[packages/subagent/subagent-claude-code/src/run.ts:388-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L388-L395)）
- 向 Host 上报失败时包裹 try，回调自身抛出被吞掉（[packages/subagent/subagent-claude-code/src/run.ts:396-402](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L396-L402)）
- 诊断累积器把权限决定行保存下来，失败事实行在生成时前置到它之前（[packages/subagent/subagent-claude-code/src/run.ts:407-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L407-L416)）
- 调用官方 `query()` 后要求自定义 spawn 已同步交出一个 `pid > 0` 的句柄，且控制器未被中止，否则进入启动失败路径（[packages/subagent/subagent-claude-code/src/run.ts:424-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L424-L441)）
- 启动失败路径先摘监听、让出一次微任务以便进程退出事实先落地，再据此构造 `query-start` 事实并触发本地取消（[packages/subagent/subagent-claude-code/src/run.ts:442-457](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L442-L457)）
- spawn 未成的分支只关闭查询并读取 `child.done` 的拒绝作为真实原因：关闭也失败则抛聚合错误，已取消则抛固定中止文案，否则抛启动失败（[packages/subagent/subagent-claude-code/src/run.ts:458-492](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L458-L492)）
- 已有活进程的分支执行完整拆除，拆除失败则抛启动失败与清理失败的聚合错误（[packages/subagent/subagent-claude-code/src/run.ts:493-505](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L493-L505)）
- 只有查询没有进程的分支只关闭查询，关闭失败同样抛聚合错误（[packages/subagent/subagent-claude-code/src/run.ts:506-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L506-L522)）
- 清理成功后，取消场景抛固定中止文案，其他场景上报并抛启动失败（[packages/subagent/subagent-claude-code/src/run.ts:523-528](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L523-L528)）
- 发布后消费消息流；SDK 报告的原生拒绝写成一条无人值守决定行（[packages/subagent/subagent-claude-code/src/run.ts:534-546](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L534-L546)）
- 运行期失败按三条规则分类：已带事实的产品失败沿用其分类并补进程事实；未收到结果消息且进程已退出记 `process`/`process`；其余记 `query-run`/`unknown`（[packages/subagent/subagent-claude-code/src/run.ts:547-570](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L547-L570)）
- 结算时输出收集恒为空数组，失败结果不携带部分产品文本（[packages/subagent/subagent-claude-code/src/run.ts:572](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L572)）
- 取消判定读的是本次运行私有控制器的信号（[packages/subagent/subagent-claude-code/src/run.ts:573-578](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L573-L578)）
- 发布的句柄用随机铸造的会话 id，`teardown` 走同一拆除流程并在失败时上报后抛出（[packages/subagent/subagent-claude-code/src/run.ts:580-595](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-claude-code/src/run.ts#L580-L595)）

### packages/subagent/subagent-claude-code/tsconfig.json

该包的 TypeScript 编译配置与工作区项目引用清单。

- 无运行期机制
