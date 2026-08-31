---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/tool-subagent
---

# packages/subagent/tool-subagent

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 10 个文件、82 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/tool-subagent/README.md

该包的说明文档，描述委派工具的配置字段、前后台模式、子模型选择与模型可见的结果形状。

- 无运行期机制

### packages/subagent/tool-subagent/package.json

该包的 npm 清单，声明入口、可加载子路径与发布文件集。

- `main`/`types` 把默认加载入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/subagent/tool-subagent/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/package.json#L14-L15)）
- `exports` 额外暴露 `./model-selection-settings` 与 `./invariant` 两个可独立加载的插件子路径（[packages/subagent/tool-subagent/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/package.json#L16-L31)）
- `files` 把发布产物限定为三个 `lib/*.js` 入口与 `lib/types` 下的声明文件（[packages/subagent/tool-subagent/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/package.json#L32-L37)）

### packages/subagent/tool-subagent/src/index.ts

面向模型的委派工具插件：把一个已注册的 `ctx.subagents` provider 变成模型可调用的工具，并负责镜像 provider 生命周期、解析前后台路由、结算运行结果。

- 声明 `inject = ['tools', 'subagents', 'systemPrompt']`，使 `apply` 只在三个服务齐备后运行（[packages/subagent/tool-subagent/src/index.ts:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L43)）
- 取 `FIRST_PARTY_SECTION_ORDER.TOOL_SUBAGENT` 作为本插件系统提示段落的排序位置（[packages/subagent/tool-subagent/src/index.ts:46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L46)）
- `Config` 模式给出 `toolName` 默认 `subagent`、`modelSelectionSettings` 默认 false、`enableRunInBackground` 默认 true、`backgroundMode` 默认 `one-shot`、`maxDepth` 默认 3（[packages/subagent/tool-subagent/src/index.ts:106-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L106-L131)）
- `agentOptions` 与 `toolFilter` 的默认值写成 `undefined`，避免 Schemastery 把省略实体化为 `{}` 或 `{ allow: [] }` 而拒绝全部工具（[packages/subagent/tool-subagent/src/index.ts:112-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L112-L129)）
- `outputValueText` 只从规范 JSON 块数组中挑出 `type: 'text'` 的块拼接，作为前台结果的渲染文本（[packages/subagent/tool-subagent/src/index.ts:134-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L134-L141)）
- `settleStart` 把启动异常在已中止且非 `AggregateError` 时映射为 `killed`，否则映射为带 detail 的 `failed`（[packages/subagent/tool-subagent/src/index.ts:144-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L144-L154)）
- `stopReasonError` 把 `aborted`/`error`/`max-tokens`/`refusal` 分别映射为固定错误文案，未知终止原因一律按失败处理（[packages/subagent/tool-subagent/src/index.ts:157-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L157-L174)）
- `withDiagnosticAndPartialText` 在错误标题后追加 provider 诊断行和子代理已产出的部分文本（[packages/subagent/tool-subagent/src/index.ts:184-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L184-L196)）
- `settleForegroundRun` 对非 `completed` 结果抛错、把 `output` 原样作为工具结果，并在结果与释放都失败时抛出合并两者的 `AggregateError`（[packages/subagent/tool-subagent/src/index.ts:208-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L208-L238)）
- `settleForegroundRun` 无论结果成败都调用一次 `run.dispose()` 后才返回（[packages/subagent/tool-subagent/src/index.ts:226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L226)）
- `providerWording` 依据 provider 是否继承父对话，给出两套工具描述与 `prompt` 参数描述（[packages/subagent/tool-subagent/src/index.ts:252-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L252-L277)）
- `resolveDelegationRun` 在后台被禁用时拒绝 `run_in_background: true`，启用时以 continuable 与否决定默认前后台（[packages/subagent/tool-subagent/src/index.ts:288-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L288-L306)）
- `apply` 在非 `provider-managed` 时对 `maxDepth` 执行 `assertSubagentMaxDepth`（[packages/subagent/tool-subagent/src/index.ts:311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L311)）
- 配置了 `toolFilter` 却既无 `allow` 也无 `deny` 时在加载期抛错（[packages/subagent/tool-subagent/src/index.ts:313-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L313-L315)）
- `assertSubagentProviderConfiguration` 分别在数字 `maxDepth` 无 `depthLimit`、配置了 `agentOptions` 或模型选择而 provider 不支持、continuable 而 provider 无 `prepareContinuable` 时抛错（[packages/subagent/tool-subagent/src/index.ts:322-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L322-L344)）
- 在可选 LLM 绑定之外先挂 `subagent/provider-added` 校验监听，并对已存在的同名 provider 立即校验（[packages/subagent/tool-subagent/src/index.ts:348-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L348-L352)）
- 有模型选择策略时注册 `list_subagent_models` 发现工具（[packages/subagent/tool-subagent/src/index.ts:356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L356)）
- `mount` 依据 provider 是否提供 `agentRouteDefaults` 选择两段不同的选择说明，并在继承父对话时追加前缀复用提示（[packages/subagent/tool-subagent/src/index.ts:362-372](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L362-L372)）
- 工具描述按后台策略拼接：continuable 说明默认后台并返回持久子代理 id，one-shot 说明默认等待并可返回 job id，禁用后台则说明总是等待（[packages/subagent/tool-subagent/src/index.ts:375-382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L375-L382)）
- 工具参数固定含必填 `description` 与 `prompt`，模型选择开启时增加 `provider`/`model`/`reasoning_effort` 三项（[packages/subagent/tool-subagent/src/index.ts:383-413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L383-L413)）
- 后台启用时按模式给出不同措辞的 `run_in_background` 参数（[packages/subagent/tool-subagent/src/index.ts:414-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L414-L421)）
- 输出模式声明 `background`/`continuable`/`foreground` 三选一，并把三者分别渲染成 job 提示、子代理 id 提示或子代理文本（[packages/subagent/tool-subagent/src/index.ts:423-461](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L423-L461)）
- `isConcurrencySafe` 恒为 true，允许该工具与其他调用并发执行（[packages/subagent/tool-subagent/src/index.ts:464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L464)）
- 执行时缺少调用方 Agent 直接抛错（[packages/subagent/tool-subagent/src/index.ts:466-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L466-L470)）
- 需要路由预检时把 provider 的 `agentRouteDefaults` 作底、配置的 `agentOptions` 覆盖其上，再与模型请求合并出子代理选项（[packages/subagent/tool-subagent/src/index.ts:472-484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L472-L484)）
- 在创建子代理的操作里执行 `assertAllowedModelSelection` 强制会话级路由白名单（[packages/subagent/tool-subagent/src/index.ts:485-490](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L485-L490)）
- 预检要求 `llm` 服务存在，调用 `preflightChildLlmRoute` 解析路由，并在解析期间 provider 被换掉时抛错要求重试（[packages/subagent/tool-subagent/src/index.ts:491-506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L491-L506)）
- 组装启动请求：把 `description` 作 label、`prompt` 包成文本块，并按存在与否附上 `agentOptions`、`persona`、`toolFilter`、`maxDepth`（[packages/subagent/tool-subagent/src/index.ts:507-517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L507-L517)）
- continuable 后台路径调用 `startContinuable`，在收件箱接受时即返回 `subagentId`，不等待也不收集结果（[packages/subagent/tool-subagent/src/index.ts:521-531](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L521-L531)）
- one-shot 后台路径要求 `jobs` 服务存在，用自建 `AbortController` 起 job 并暴露 `cancel`/`done`，不提供 `readOutput`（[packages/subagent/tool-subagent/src/index.ts:532-554](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L532-L554)）
- 前台路径把工具调用的 `exec.signal` 传给 `subagents.start` 并交给 `settleForegroundRun` 结算（[packages/subagent/tool-subagent/src/index.ts:557-561](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L557-L561)）
- 监听 `subagent/provider-added` 在同名 provider 出现时挂载工具，监听 `subagent/provider-removed` 在其消失时注销工具（[packages/subagent/tool-subagent/src/index.ts:573-580](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L573-L580)）
- provider 尚未注册时不挂工具，只写一条 info 日志说明工具将在其出现时注册（[packages/subagent/tool-subagent/src/index.ts:581-587](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L581-L587)）
- 后台且 continuable 时注册 `tool:<toolName>` 提示段落，其文本在工具未挂载或当前作用域取不到该工具时为空串（[packages/subagent/tool-subagent/src/index.ts:588-599](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L588-L599)）
- 未开启 `modelSelectionSettings` 时直接以空策略安装并返回（[packages/subagent/tool-subagent/src/index.ts:602-605](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L602-L605)）
- 开启模型选择却缺少 `subagentModelSelection` 服务或缺少 Agent/preset 作用域时在加载期抛错（[packages/subagent/tool-subagent/src/index.ts:607-617](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L607-L617)）
- `selectForAgent` 依次读会话已记录策略、父会话策略，或在 `firstLiveSeq === 0` 的新会话上采样一次用户设置，并把结果写回会话（[packages/subagent/tool-subagent/src/index.ts:619-635](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L619-L635)）
- 当前上下文已带 Agent 时按该 Agent 采样策略后直接安装（[packages/subagent/tool-subagent/src/index.ts:637-641](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L637-L641)）
- `installScoped` 为每个属于本组合作用域的 Agent 在其自身作用域内注入并安装工具定义，用 WeakMap/WeakSet 抵挡重入与重复安装（[packages/subagent/tool-subagent/src/index.ts:645-664](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L645-L664)）
- `removeScoped` 释放该 Agent 的 fiber，失败只落一条 warn 日志（[packages/subagent/tool-subagent/src/index.ts:665-673](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L665-L673)）
- `reconcileComposedAgents` 遍历 Agent 注册表，按作用域链归属决定安装或移除（[packages/subagent/tool-subagent/src/index.ts:674-681](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L674-L681)）
- 监听 `agent/created` 与 `agent/disposed` 安装或移除 Agent 私有定义，监听 `tools/change` 触发全量对账（[packages/subagent/tool-subagent/src/index.ts:685-692](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/index.ts#L685-L692)）

### packages/subagent/tool-subagent/src/invariant.ts

该包的不变量伴生插件，检查可选模型路由的定义与其持久记录是否配套。

- 注册一个全局 `agent/pre-step` 瀑布监听：当工具模式里出现 `provider`/`model`/`reasoning_effort` 三参数或出现 `list_subagent_models` 时，若会话缺少持久策略、或两者不成对，就报失败（[packages/subagent/tool-subagent/src/invariant.ts:19-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/invariant.ts#L19-L37)）
- 监听在检查后调用 `next()` 继续瀑布链（[packages/subagent/tool-subagent/src/invariant.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/invariant.ts#L35)）
- 以该安装器向 `ctx.invariants` 注册包名并返回其 disposer（[packages/subagent/tool-subagent/src/invariant.ts:44-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/invariant.ts#L44-L45)）

### packages/subagent/tool-subagent/src/list-models.ts

`list_subagent_models` 发现工具的实现，由委派工具在启用模型选择时注册。

- `registeredProvider` 在 provider 未注册时抛错，并在错误文本里只列出策略允许且已注册的 provider id（[packages/subagent/tool-subagent/src/list-models.ts:15-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/list-models.ts#L15-L28)）
- `modelLine` 把一条模型渲染成 `provider/id — name[: description]`（[packages/subagent/tool-subagent/src/list-models.ts:31-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/list-models.ts#L31-L33)）
- `llm` 服务不可用时抛错，只给 `model` 不给 `provider` 时抛错（[packages/subagent/tool-subagent/src/list-models.ts:42-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/list-models.ts#L42-L48)）
- 不带参数时只列出策略路由覆盖到的 provider，全空则返回 `(no LLM providers)`（[packages/subagent/tool-subagent/src/list-models.ts:49-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/list-models.ts#L49-L55)）
- 空 `provider` 抛错，且在调用适配器目录之前先拒绝不在策略内的 provider（[packages/subagent/tool-subagent/src/list-models.ts:56-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/list-models.ts#L56-L60)）
- 只给 `provider` 时列出该 provider 的广告模型并按策略路由过滤，无结果返回固定占位文本（[packages/subagent/tool-subagent/src/list-models.ts:62-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/list-models.ts#L62-L68)）
- 精确查询前拒绝空 `model` 与不在策略内的路由，通过后才调用 `resolveModelInfo`（[packages/subagent/tool-subagent/src/list-models.ts:69-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/list-models.ts#L69-L73)）
- 精确结果附带该模型的推理档位列表并标注默认档位，无档位时返回固定占位文本（[packages/subagent/tool-subagent/src/list-models.ts:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/list-models.ts#L74-L78)）
- `registerListSubagentModels` 注册固定名 `list_subagent_models` 的工具，含描述、`provider`/`model` 两个可选参数、字符串输出与渲染，并把执行透传的信号交给发现逻辑（[packages/subagent/tool-subagent/src/list-models.ts:86-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/list-models.ts#L86-L112)）

### packages/subagent/tool-subagent/src/model-selection-settings.ts

Host 侧的用户设置服务，保存"是否允许模型自选子代理路由"及其允许路由列表，供委派工具在 Agent 发布时采样。

- 用 `settingsNamespace('subagent-model-selection')` 固定设置命名空间（[packages/subagent/tool-subagent/src/model-selection-settings.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-settings.ts#L20)）
- 面向设置客户端的模式把 `enabled` 默认成 false、`allowedModels` 默认成空数组（[packages/subagent/tool-subagent/src/model-selection-settings.ts:31-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-settings.ts#L31-L34)）
- 服务以 `subagentModelSelection` 名注册，并把部署配置作为初始条目先行校验（[packages/subagent/tool-subagent/src/model-selection-settings.ts:53-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-settings.ts#L53-L62)）
- `installSettingsSection` 装上设置段：换源、校验，`onChange` 刻意留空，使设置变更不重建已运行 Agent 的工具定义（[packages/subagent/tool-subagent/src/model-selection-settings.ts:63-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-settings.ts#L63-L75)）
- `current()` 返回逐条复制的脱离态快照（[packages/subagent/tool-subagent/src/model-selection-settings.ts:82-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-settings.ts#L82-L88)）
- `validate` 校验路由数组，并拒绝"已启用但允许列表为空"的取值（[packages/subagent/tool-subagent/src/model-selection-settings.ts:90-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-settings.ts#L90-L95)）
- 以默认导出服务类的形式暴露插件，插件名为 `subagent-model-selection-settings`（[packages/subagent/tool-subagent/src/model-selection-settings.ts:98-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-settings.ts#L98-L99)）

### packages/subagent/tool-subagent/src/model-selection-state.ts

把采样到的路由策略记进会话日志并读回的两个函数，被委派工具与其不变量伴生使用。

- 向 `SessionEventMap` 合并声明 `subagent/model-selection-policy` 事件：仅记录日志、不带 `surfaceOp`、不进入模型历史（[packages/subagent/tool-subagent/src/model-selection-state.ts:6-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-state.ts#L6-L19)）
- `subagentModelSelectionPolicy` 取会话中首条该事件，校验路由后返回逐条复制的列表，空列表直接抛错（[packages/subagent/tool-subagent/src/model-selection-state.ts:26-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-state.ts#L26-L34)）
- `recordSubagentModelSelection` 在尚无记录时才追加事件，因而每个会话至多写入一次（[packages/subagent/tool-subagent/src/model-selection-state.ts:41-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection-state.ts#L41-L46)）

### packages/subagent/tool-subagent/src/model-selection.ts

子代理 LLM 路由的合并、校验与上线前解析逻辑，被委派工具与发现工具共用。

- `AllowedModelRouteSchema` 要求 provider 与 model 均为非空必填串（[packages/subagent/tool-subagent/src/model-selection.ts:17-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L17-L20)）
- `modelRouteKey` 用 `\0` 拼出路由等值比较键（[packages/subagent/tool-subagent/src/model-selection.ts:33-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L33-L35)）
- `assertAllowedModelRoutes` 在持久/配置边界上拒绝非数组、非对象条目、空串 id 与重复路由（[packages/subagent/tool-subagent/src/model-selection.ts:42-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L42-L62)）
- `hasDelegationModelRequest` 判定调用是否显式给了任一路由或档位字段，决定后续是否走选择与预检（[packages/subagent/tool-subagent/src/model-selection.ts:76-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L76-L80)）
- `requestedAgentOptions` 在工具实例未开启选择时对任何显式字段抛错（[packages/subagent/tool-subagent/src/model-selection.ts:105-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L105-L108)）
- 在工具 JSON 边界拒绝空串的 `provider`/`model`/`reasoning_effort`，并要求 `provider` 与 `model` 同时给出（[packages/subagent/tool-subagent/src/model-selection.ts:109-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L109-L114)）
- 换路由且未显式给档位时，丢弃配置中随旧路由带来的 `reasoningEffort`，使新模型用自身默认档位（[packages/subagent/tool-subagent/src/model-selection.ts:116-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L116-L127)）
- `assertAllowedModelSelection` 对纯继承放行，对任何显式选择要求解析出的 provider/model 命中策略白名单，否则抛错（[packages/subagent/tool-subagent/src/model-selection.ts:139-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L139-L153)）
- `hasConfiguredLlmSelection` 判定配置层是否含 provider/model/档位，从而决定是否必须预检（[packages/subagent/tool-subagent/src/model-selection.ts:160-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L160-L164)）
- `preflightChildLlmRoute` 在缺少有效 provider/model 时抛错，并在路由未变且允许继承时才沿用父档位（[packages/subagent/tool-subagent/src/model-selection.ts:183-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L183-L190)）
- 预检把最终路由交给 `llm.resolveCallConfig` 并透传取消信号，在创建子代理之前完成解析（[packages/subagent/tool-subagent/src/model-selection.ts:191-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/src/model-selection.ts#L191-L195)）

### packages/subagent/tool-subagent/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制

### packages/subagent/tool-subagent/tsdown.config.ts

该包的打包配置，决定发布产物中三个可加载入口的生成方式。

- 每个入口以 ESM、node 平台、es2024 目标单独打包到 `lib/`，不生成 dts、不清理输出（[packages/subagent/tool-subagent/tsdown.config.ts:3-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/tsdown.config.ts#L3-L12)）
- 为根入口、`model-selection-settings`、`invariant` 三者各产出自包含产物，使加载器不依赖私有 chunk（[packages/subagent/tool-subagent/tsdown.config.ts:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/tool-subagent/tsdown.config.ts#L15-L19)）
