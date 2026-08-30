---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/interaction/commands
---

# packages/interaction/commands

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、49 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/interaction/commands/README.md

该包的说明文档，描述斜杠命令的注册、作用域、分发与生命周期事件。

- 无运行期机制

### packages/interaction/commands/package.json

该包的 npm 清单，声明入口、多个子导出与发布内容。

- `type: module` 与 `main`/`types` 指定包按 ESM 加载、运行时入口为 `lib/index.js`（[packages/interaction/commands/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/package.json#L13-L15)）
- `exports` 把 `.`、`./invariant`、`./types`、`./brand` 解析到各自模块，并把 `./typert` 与 `./remote` 指向生成的宿主端与客户端 Remote 产物（[packages/interaction/commands/package.json:16-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/package.json#L16-L43)）
- `files` 限定发布物包含实现、伴生、类型目录与两份 Typert 产物（[packages/interaction/commands/package.json:44-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/package.json#L44-L53)）
- `dependencies` 携带 `@deepseek-ai/dsh-util-crypto` 与 `zod`，分别用于铸 id 的随机源与生成产物的运行时校验（[packages/interaction/commands/package.json:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/package.json#L66-L69)）

### packages/interaction/commands/src/brand.ts

命令生命周期配对 id 的品牌出口，供宿主、wire 与客户端程序共同引用。

- `CommandId()` 把传入字符串原样返回并打上品牌，不做任何校验（[packages/interaction/commands/src/brand.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/brand.ts#L27-L29)）

### packages/interaction/commands/src/index.ts

`CommandRuntime` 服务实现：命令注册、按 agent 的作用域合并、解析与分发、图片准入、生命周期事件落日志。

- 命令名正则限定小写字母开头、后接字母数字下划线连字符（[packages/interaction/commands/src/index.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L29)）
- 无图片调用统一复用一个冻结的空附件数组（[packages/interaction/commands/src/index.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L32)）
- `CommandLayer` 用 `NamedEntries` 承载一层注册，并按是否为作用域层给出不同的重名报错文案（[packages/interaction/commands/src/index.ts:86-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L86-L103)）
- `parseCommand` 要求首字节为 `/`、名字后必须是行尾或空白，命令名之后的全部文本（含分隔空白）成为 `rawInput`，结果被冻结（[packages/interaction/commands/src/index.ts:117-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L117-L124)）
- `abortError` 把任意 abort reason 归一成一个 Error（非 Error 的字符串原因转成消息，其余用固定文案）（[packages/interaction/commands/src/index.ts:127-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L127-L135)）
- `renderThrown` 对无法字符串化的抛出值回落为固定占位文本（[packages/interaction/commands/src/index.ts:138-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L138-L144)）
- `withAbort` 在信号已中止时立即拒绝，否则让 abort 与 handler 结果竞速，并把非 Error 的拒绝值包成带 cause 的 Error（[packages/interaction/commands/src/index.ts:147-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L147-L168)）
- `normalizeDefinition` 校验命令名、描述为非空字符串、handler 为函数，任一不满足即在注册时抛出（[packages/interaction/commands/src/index.ts:171-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L171-L183)）
- input 描述必须带非空字符串 `hint`，`images` 若存在必须是布尔，且只有为 true 时才写进冻结后的描述（[packages/interaction/commands/src/index.ts:184-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L184-L201)）
- 归一化后冻结定义，并派生出不含 handler 的对外描述符（[packages/interaction/commands/src/index.ts:202-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L202-L214)）
- `normalizeResult` 在注册表边界校验 handler 返回值：非对象或缺 kind 抛错，success 的 text 必须是字符串、`sourceEventSeq` 必须是非负安全整数，error 的 text 必须非空，未知 kind 抛错（[packages/interaction/commands/src/index.ts:218-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L218-L244)）
- 服务持有 `ScopedLayers`，层发生变化时回调 `notifyChange()`（[packages/interaction/commands/src/index.ts:252-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L252-L255)）
- 单调计数器与随机实例令牌共同构成配对 id 的来源，使续接同一日志的新进程不会重复旧 id（[packages/interaction/commands/src/index.ts:257-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L257-L260)）
- 构造函数以 `commands` 名字挂载为 Typert Remote 服务（[packages/interaction/commands/src/index.ts:262-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L262-L264)）
- `register` 归一化后经 `layers.effect` 插入调用方所属层（全局或 agent 作用域），返回撤销该注册的 disposer（[packages/interaction/commands/src/index.ts:271-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L271-L278)）
- `@Remote list(agent)` 返回按名字排序、冻结的描述符数组，内容取自作用域遮蔽后的有效视图（[packages/interaction/commands/src/index.ts:285-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L285-L291)）
- `find(agent, name)` 从有效视图取单条定义（作用域遮蔽优先于全局）（[packages/interaction/commands/src/index.ts:299-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L299-L301)）
- `@Remote execute` 对语法不成立或名字未注册的行返回 `undefined`，不写任何日志（[packages/interaction/commands/src/index.ts:329-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L329-L339)）
- 进入执行前信号已中止就直接抛出归一化的 abort 错误（[packages/interaction/commands/src/index.ts:340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L340)）
- 铸出 `commandId` 后在 handler 之前追加 `command/run` 事件，携带命令名与 `source: {kind:'user'}`；`recordInput: false` 的命令不写 `args`（[packages/interaction/commands/src/index.ts:341-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L341-L347)）
- `settle` 在结算时追加 `command/done`，带 kind、可选 text 与仅 success 时的 `sourceEventSeq`，并返回冻结的执行结果（[packages/interaction/commands/src/index.ts:348-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L348-L357)）
- 带图片但命令未声明 `input.images` 时，在 handler 之前结算成 error 结果（[packages/interaction/commands/src/index.ts:359-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L359-L362)）
- 组合中没有 `attachments` 存储时结算成 error 结果，不进入 handler（[packages/interaction/commands/src/index.ts:363-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L363-L366)）
- 图片经 `admitEncodedImages` 提交为持久对象后，冻结成按提交顺序排列的 `ImageBlock` 数组交给 handler（[packages/interaction/commands/src/index.ts:367-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L367-L369)）
- 准入抛出 `AttachmentError` 时结算成 error 结果；其他错误先补记 `command/done` 失败事件再原样抛出（[packages/interaction/commands/src/index.ts:370-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L370-L376)）
- 准入过程中发生的取消在 handler 运行前被兑现：补记失败事件并抛出，handler 不会进入（[packages/interaction/commands/src/index.ts:381-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L381-L385)）
- 冻结的 invocation 携带 commandId、agent、rawInput、附件与信号交给 handler，结果经 `withAbort` 与 `normalizeResult` 处理；抛出时补记失败事件并原样抛出（[packages/interaction/commands/src/index.ts:387-396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L387-L396)）
- `settleThrown` 以 error 形态追加 `command/done`，追加本身失败时只记 warn 日志，不覆盖原始错误（[packages/interaction/commands/src/index.ts:400-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L400-L409)）
- `mintCommandId` 生成 `cmd-<实例令牌>-<自增序号>` 形式的配对 id（[packages/interaction/commands/src/index.ts:412-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L412-L415)）
- `appendLifecycle` 用两参形式直接 append 事件，不开 turn 也不强制 flush，由持久化在常规检查点排空（[packages/interaction/commands/src/index.ts:423-433](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L423-L433)）
- `view` 用 `layers.merge(agent, ...)` 先全局后作用域地合并出该 agent 的有效命令表（[packages/interaction/commands/src/index.ts:436-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L436-L438)）
- `notifyChange` 逐个调用 `commands/change` 监听器：同步抛出与异步拒绝各自记 warn 并被隔离，既不否决注册表变更也不阻断后续监听器（[packages/interaction/commands/src/index.ts:441-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L441-L455)）
- 默认导出该服务类，供加载器按服务插件形式挂载（[packages/interaction/commands/src/index.ts:458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/index.ts#L458)）

### packages/interaction/commands/src/invariant.ts

该包的不变量伴生插件，校验同一会话日志内 `command/run` 与 `command/done` 的配对关系。

- `inject` 声明 `invariants`，安装器另行声明 `sessions` 注入（[packages/interaction/commands/src/invariant.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/invariant.ts#L16)、[packages/interaction/commands/src/invariant.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/invariant.ts#L56)）
- 以安装作用域的 `WeakMap` 按会话记录已见的 run id，重装一次即从空白重扫（[packages/interaction/commands/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/invariant.ts#L22)）
- 同一 `commandId` 出现第二个 `command/run` 时调用 `fail` 报告重复（[packages/interaction/commands/src/invariant.ts:24-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/invariant.ts#L24-L31)）
- `command/done` 在本日志中找不到先行 `command/run` 时调用 `fail`（[packages/interaction/commands/src/invariant.ts:33-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/invariant.ts#L33-L36)）
- `sourceEventSeq` 只允许出现在 success 结果上，且必须是指向本事件之前、序号自洽、且本身不是命令生命周期事件的那条记录，否则 `fail`（[packages/interaction/commands/src/invariant.ts:37-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/invariant.ts#L37-L46)）
- 安装时先扫一遍已加载会话的全部历史事件（[packages/interaction/commands/src/invariant.ts:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/invariant.ts#L48-L50)）
- 之后全局监听 `internal/dispatch`，对每条新派发的 `session/event` 做同一套校验（[packages/interaction/commands/src/invariant.ts:51-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/invariant.ts#L51-L55)）
- `apply` 以包名把该安装器登记进 `ctx.invariants` 并返回其 disposer（[packages/interaction/commands/src/invariant.ts:64-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/commands/src/invariant.ts#L64-L65)）

### packages/interaction/commands/src/types.ts

命令载荷类型与 Cordis／会话事件词表的声明合并文件，被实现与客户端共同引用。

- 无运行期机制

### packages/interaction/commands/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制
