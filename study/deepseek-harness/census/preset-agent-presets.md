---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/preset/agent-presets
---

# packages/preset/agent-presets

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 23 个文件、222 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/preset/agent-presets/README.md

包级说明文档，描述 preset 名册、标准挂载、授权拷贝与会话记录的对外行为，供使用者与维护者阅读。

- 无运行期机制

### packages/preset/agent-presets/package.json

包清单，声明这个包的模块类型、入口、子路径导出与随包发布的文件集。

- 声明 ESM 模块类型并把默认入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/preset/agent-presets/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/package.json#L13-L15)）
- `exports` 只放行五个子路径：根、`./invariant`、`./types`、`./typert`、`./remote`，另加 `./src/*` 与 `./package.json`（[packages/preset/agent-presets/package.json:16-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/package.json#L16-L39)）
- `files` 把 `presets` 目录整体纳入发布物，使内置 preset 与挂载它的代码一同安装（[packages/preset/agent-presets/package.json:40-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/package.json#L40-L50)）
- 运行期依赖只声明 `js-yaml`、schemastery 与 `zod`，其余能力走 peerDependencies（[packages/preset/agent-presets/package.json:52-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/package.json#L52-L72)）

### packages/preset/agent-presets/presets/cordis/agent.cordis.yml

`cordis` preset 的组合文件，被名册按 id 发现并挂载成一份常驻组合，决定加入该 preset 的 agent 看到哪些工具、提示段与技能。

- `persona` 行写入一整段 persona 文本：说明可读改自身运行时、划分 host 与 preset 两个平面、指定本地 preset 目录、禁止改动随发行的 preset、并要求写组合前先加载 `editing-cordis-compositions` 技能（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:17-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L17-L29)）
- `agent-instructions` 行以 `maxBytes: 65536` 上限注入指令文件（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:31-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L31-L34)）
- `tool-bash` 行在 `process.platform === 'win32'` 时用 `!!js` 表达式禁用（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L45-L47)）
- `tool-pwsh` 行在非 win32 时禁用，与 bash 行互补（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L49-L51)）
- `tool-fs` 行把文件工具注册进 host 的 tools 注册表（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:57-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L57-L58)）
- `tool-fs-search` 行以 `sampleOverCapGlobResults: false` 配置检索工具（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:60-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L60-L63)）
- `tool-jobs` 行给出后台任务的收集与终止工具（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:74-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L74-L75)）
- `command-goal` 与 `tool-goal` 两行分别注册人用命令与模型可见的目标工具（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:82-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L82-L86)）
- `planning` 组带 `isolate: planMode` realm，内含 `plan-mode` 行，其 `section` 是一整段计划模式提示：禁止改动文件、要求 `exit_plan_mode` 为该轮唯一且最后的工具调用、并声明工具目录跨模式不变（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:92-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L92-L112)）
- `compaction` 组带 `isolate: compaction`/`toolResultPruner`，装入 `compaction-basic`、`command-compact` 与阈值 8192／头 4096／尾 1024 的工具结果裁剪行（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:125-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L125-L143)）
- `delegation` 组带 `isolate: workflowEngine`，内含子代理控制、`list-agents`、spawn 版 `subagent`（开启模型选择、continuable 后台）、fork 版 `subagent_fork`、两条默认 `disabled: true` 的 codex／claude-code 行、worker-thread 工作流后端、`tool-workflow` 以及 `maxRounds: 64` 的 `tool-ralph`（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:162-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L162-L227)）
- `tool-ask-user` 行注册向用户提问的工具（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:231-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L231-L232)）
- `tool-todo` 行以 `allowParallelInProgress: true` 注册待办工具（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:234-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L234-L237)）
- `tool-web` 行开启 `fetch` 并把搜索超时设为 60000 毫秒（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:241-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L241-L245)）
- `tool-cordis` 行给出读取运行时、临时挂载与卸载插件的自修改工具集（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:251-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L251-L252)）
- `skill-filesystem` 行用 `!!js` 表达式把 `skills/` 相对 `baseUrl` 解析成技能根，使随 preset 目录走的技能进入该 agent 的技能目录（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:261-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L261-L265)）
- `tool-skill` 行提供技能目录与加载工具（[packages/preset/agent-presets/presets/cordis/agent.cordis.yml:267-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/agent.cordis.yml#L267-L268)）

### packages/preset/agent-presets/presets/cordis/preset.yml

`cordis` preset 的展示元数据文件，被 `readPresetMetadata` 读取后写入名册行。

- 提供 `name`、`description` 与 `order: 4`，决定名册行的显示文字和排序位置（[packages/preset/agent-presets/presets/cordis/preset.yml:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/preset.yml#L1-L3)）

### packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md

随 `cordis` preset 目录发行的技能文件，由该 preset 的 `skill-filesystem` 行发现，模型加载后进入上下文，指导动态 Cordis 插件的定义、运行与修复。

- front matter 的 `name` 与 `description` 决定这条技能在目录里的条目与触发场景（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:1-4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L1-L4)）
- 要求先判定能力属 Host 还是 Client，并禁止从名称或示例推断完整接口（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L8)）
- 给出七步流程：`cordis_inspect_list` → `cordis_inspect_query` → `cordis_inspect_self` → 写 `code.host`/`code.client` → `cordis_define` → `cordis_run` → `cordis_stop`/`cordis_undefine`（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:10-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L10-L18)）
- 规定 `cordis_run` 返回 `awaiting-approval` 或 `starting` 后必须结束当前工具流、不得在同一轮里等待审批或浏览器结果（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L20)）
- 逐工具列出使用与禁止条件的对照表（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:22-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L22-L32)）
- 按需求类型给出平台选择表与先查哪个 Provider（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:34-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L34-L46)）
- 列出 `Service.listService`、`Event.listEvents`、`Builtin.listBuiltins`、`Slots.listSubTree`、`Theme.listTokens`、`Tool.listTools` 各自返回什么，并要求名称与入参取自当前 list 结果（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:48-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L48-L59)）
- 声明代码是纯 JavaScript 函数体，禁用 `import`/`require`/类型/装饰器/JSX 与未确认的全局量，Client React 只能用 `React.createElement`（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:61-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L61-L98)）
- 规定默认用 `ctx.get(name)` 并处理缺失，只有硬依赖才声明 `inject`，未声明就访问 `ctx.<name>` 会被 Guard 拒绝（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:100-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L100-L125)）
- 要求一切贡献走 `ctx.on()`／`ctx.effect()` 并保留 disposer，禁止模块级或 `apply()` 之外的全局副作用（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:127-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L127-L150)）
- 说明定时器是名为 `timer` 的 Service 而非 Builtin，使用前须 `inject: ['timer']`，禁止裸 `setTimeout`（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:152-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L152-L199)）
- 规定 Waterfall 事件监听器最后一个参数是 `next`，除非有意截断否则必须调用并返回它（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:201-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L201-L228)）
- 规定 Slot 注册必须先查子树再以 `slots.inject` 包裹 `slots.register`，禁止猜 `id`/`key`/选择器与占用根级 Slot（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:230-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L230-L265)）
- 分别给出设置页、会话数据、`tool.view.cordis` 面板（`key: 'self'`）、普通工具卡与覆盖层的目标 Slot 与取舍（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:267-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L267-L309)）
- 按改动范围区分全局主题、包内 `styles.insert(css)` 与新增内容三条路径，禁止操作 `document.body`/`window`/写死选择器（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:311-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L311-L319)）
- 规定 Client→Host 走 `harness.handle` 与 `host.call`，参数与返回必须是无损 JSON，无数据时返回 `null`（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:321-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L321-L348)）
- 规定用 `harness` 注册的动态工具在下一步模型调用中可见，注册须归属当前插件 Fiber 以便停止或更新时移除（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:350-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L350-L354)）
- 禁止对内部活对象做 `JSON.stringify`／`structuredClone`／整体枚举展示，只读取当前功能需要的叶子字段（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:356-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L356-L366)）
- 定义 `pluginId`/`packageId`/`pluginRunId`/`currentPackageId`/`nextPackageId` 语义，并用状态表决定 `cordis_run` 取 `run` 还是 `update`，规定审批被拒后不得自动重试（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:368-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L368-L395)）
- 规定用户以 `@pluginId` 指定目标时不得另建插件，须读基础包后以 `plugin.kind: 'existing'` 追加新版本（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:397-408](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L397-L408)）
- 给出常见失败信息与对应首查项的对照表（[packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md:410-420](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/cordis-plugin-development/SKILL.md#L410-L420)）

### packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md

随 `cordis` preset 目录发行的技能文件，模型在编写或修改组合文件前加载，指导 preset 的平面划分、拷贝授权、realm 规则与挂载校验。

- front matter 的 `name` 与 `description` 决定条目与触发场景（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:1-4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L1-L4)）
- 禁止编辑、删除或覆盖随发行安装的 preset，也禁止为此提升沙箱，改动只能走拷贝（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:10-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L10-L14)）
- 按"是否必须共享"划分 host 组合与 agent preset 的归属，并以 `subagents` 为例说明跨会话消费者不能下沉进 preset（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:16-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L16-L24)）
- 说明 preset 是一个目录、含 `agent.cordis.yml` 与可选 `preset.yml`，路径须取自 `list()`/`resolve()` 而非硬编（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L26-L28)）
- 说明 `ctx.agentPresets` 要靠临时插件注入并注册自用工具才能取到答案，并列出依赖的 `list()`/`read()`/`copy()`/`standingKeyFor()` 四个方法与示例代码，用完以 `cordis_unmount` 卸载（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:30-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L30-L64)）
- 给出五步创作流程：先 `copy` 再改，写 `description`／`name`，逐行编辑组合，最后挂载校验并交由用户开真会话（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:66-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L66-L74)）
- 提示用户 preset 根在工作区之外，拷贝后的首次写入会被文件沙箱拒绝，须带简短理由重试一次 `sandbox_permissions` 提权并合并写入（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L69)）
- 规定发布服务的行必须连同其消费者一起包进带 `isolate` realm 的组，并说明字符串 label 不会池化实例（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:76-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L76-L103)）
- 指定 `standingKeyFor(id)` 为校验手段并列出四种失败信息形态，要求只在改完后跑一次（成功会留下一代常驻挂载）（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:105-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L105-L114)）
- 声明名册的 `broken` 字段只是形状检查、不能当作校验，`cordis_inspect` 报的是当前会话的组合（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:116-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L116-L120)）
- 给出可选子代理产品的安装命令、禁用模板行与解禁条件，并规定每个额外实例需一条独立 host 行加一条 `provider`/`toolName` 唯一的 preset 工具行（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:124-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L124-L161)）
- 列出不得移入 preset 的部分：`agent-loop`、各注册表、会话持久化、沙箱与审批权限行（[packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md:163-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/cordis/skills/editing-cordis-compositions/SKILL.md#L163-L165)）

### packages/preset/agent-presets/presets/minimal/agent.cordis.yml

`minimal` preset 的组合文件，装出一个固定提示词、只有持久 shell 与 `str_replace_editor` 两件工具的 agent。

- `persona` 行以 `complete: true` 把这段文本定为完整系统提示，并以 `includeRuntimeContext: false` 关掉运行时上下文快照，使后续装配监听器无法再追加提示文本（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:9-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L9-L14)）
- `persistent-shell` 组带 `isolate: terminals` realm，使 PTY 注册表成为本挂载私有实例（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:21-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L21-L26)）
- `pty` 行在该 realm 内提供终端服务（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:27-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L27-L28)）
- `terminal-bash` 行在 win32 上禁用，超时 300000 毫秒（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L30-L34)）
- `persistent-bash` 行在 win32 上禁用，并写死一段模型可见的工具描述：状态跨调用持久、无网络、避免超大输出、长任务放后台（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:36-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L36-L49)）
- `terminal-pwsh` 行在非 win32 上禁用，以 `shellDialect: pwsh` 复用同一终端后端（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:51-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L51-L56)）
- `persistent-pwsh` 行在非 win32 上禁用，工具描述改写为 Windows 路径与 `$env:NAME` 变量的说法（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:58-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L58-L70)）
- `filesystem` 组带 `isolate: fs` realm，使裸本地文件系统只在本 preset 内遮蔽 host 的受沙箱提供者（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:74-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L74-L79)）
- `fs-local` 行以 `!!js process.env.DSH_CWD ?? process.cwd()` 取工作目录（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:80-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L80-L83)）
- `str-replace-editor` 行把单次输出上限设为 16000 字符（[packages/preset/agent-presets/presets/minimal/agent.cordis.yml:85-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/agent.cordis.yml#L85-L88)）

### packages/preset/agent-presets/presets/minimal/preset.yml

`minimal` preset 的展示元数据文件。

- 提供 `name`、`description` 与 `order: 3`，决定名册行的显示文字和排序位置（[packages/preset/agent-presets/presets/minimal/preset.yml:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/minimal/preset.yml#L1-L3)）

### packages/preset/agent-presets/presets/ptc/agent.cordis.yml

`ptc` preset 的组合文件，行集与 `standard` 相同并追加工具呈现行，把工具目录改为由模型写 TypeScript 程序调用。

- `persona` 行给出带 `{{model}}` 与 `{{cwd}}` 占位的 persona 文本（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:31-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L31-L35)）
- `agent-instructions` 行以 `maxBytes: 65536` 上限注入指令文件（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:37-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L37-L40)）
- `tool-bash` 行在 win32 上禁用（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L51-L53)）
- `tool-pwsh` 行在非 win32 上禁用（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:55-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L55-L57)）
- `tool-fs` 行注册文件工具（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:63-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L63-L64)）
- `tool-fs-search` 行以 `sampleOverCapGlobResults: false` 配置检索工具（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L66-L69)）
- `tool-jobs` 行给出后台任务控制工具（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:80-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L80-L81)）
- `skill-filesystem` 与 `tool-skill` 两行把本地技能发现与技能目录／加载工具注册进本 preset 的技能层（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:90-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L90-L94)）
- `command-goal` 与 `tool-goal` 两行注册人用命令与模型可见的目标工具（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:101-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L101-L105)）
- `planning` 组带 `isolate: planMode` realm 并写入整段计划模式提示文本（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:111-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L111-L131)）
- `compaction` 组带 `isolate: compaction`/`toolResultPruner`，装入压缩、压缩命令与阈值 8192／头 4096／尾 1024 的裁剪行（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:144-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L144-L162)）
- `delegation` 组带 `isolate: workflowEngine`，装入子代理控制、spawn／fork 两条 continuable 子代理工具、两条默认禁用的产品子代理行、工作流后端与 `maxRounds: 64` 的 `tool-ralph`（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:175-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L175-L240)）
- `tool-ask-user` 行注册向用户提问的工具（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:244-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L244-L245)）
- `tool-todo` 行以 `allowParallelInProgress: true` 注册待办工具（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:247-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L247-L250)）
- `tool-web` 行开启 `fetch` 并把搜索超时设为 60000 毫秒（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:254-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L254-L258)）
- `tool-presentation` 行以 `mode: ptc` 改变本 agent 的工具呈现方式，并在部署未组合 TypeScript 运行时时于挂载阶段失败并点名该行 id（[packages/preset/agent-presets/presets/ptc/agent.cordis.yml:265-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/agent.cordis.yml#L265-L268)）

### packages/preset/agent-presets/presets/ptc/preset.yml

`ptc` preset 的展示元数据文件。

- 提供 `name`、`description` 与 `order: 2`，决定名册行的显示文字和排序位置（[packages/preset/agent-presets/presets/ptc/preset.yml:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/ptc/preset.yml#L1-L3)）

### packages/preset/agent-presets/presets/standard/agent.cordis.yml

`standard` preset 的组合文件，是完整编码 agent 的行集，也是默认配置里最常被命名的那一份。

- `persona` 行给出带 `{{model}}` 与 `{{cwd}}` 占位的 persona 文本，遮蔽部署默认 persona（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:24-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L24-L28)）
- `agent-instructions` 行以 `maxBytes: 65536` 上限注入指令文件（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:30-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L30-L33)）
- `tool-bash` 行在 win32 上禁用（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L44-L46)）
- `tool-pwsh` 行在非 win32 上禁用（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L48-L50)）
- `tool-fs` 行注册文件工具（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:56-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L56-L57)）
- `tool-fs-search` 行以 `sampleOverCapGlobResults: false` 配置检索工具（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:59-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L59-L62)）
- `tool-jobs` 行给出后台任务的收集与终止工具（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:73-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L73-L74)）
- `skill-filesystem` 与 `tool-skill` 两行把本地技能发现与技能目录／加载工具注册进本 preset 的技能层（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:83-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L83-L87)）
- `command-goal` 与 `tool-goal` 两行注册人用命令与模型可见的目标工具（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:94-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L94-L98)）
- `planning` 组带 `isolate: planMode` realm，其 `plan-mode` 行写入整段计划模式提示：禁止改动、`exit_plan_mode` 必须是该轮唯一且最后的工具调用、工具目录跨模式不变（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:104-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L104-L124)）
- `compaction` 组带 `isolate: compaction`/`toolResultPruner`，装入 `compaction-basic`、`command-compact` 与阈值 8192／头 4096／尾 1024 的工具结果裁剪行（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:137-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L137-L155)）
- `delegation` 组带 `isolate: workflowEngine`，装入子代理控制、`list-agents`、spawn 版 `subagent`、fork 版 `subagent_fork`、两条默认 `disabled: true` 的产品子代理行、worker-thread 工作流后端、`tool-workflow` 与 `maxRounds: 64` 的 `tool-ralph`（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:174-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L174-L239)）
- `tool-ask-user` 行注册向用户提问的工具（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:243-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L243-L244)）
- `tool-todo` 行以 `allowParallelInProgress: true` 注册待办工具（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:246-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L246-L249)）
- `tool-web` 行开启 `fetch` 并把搜索超时设为 60000 毫秒（[packages/preset/agent-presets/presets/standard/agent.cordis.yml:253-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/agent.cordis.yml#L253-L257)）

### packages/preset/agent-presets/presets/standard/preset.yml

`standard` preset 的展示元数据文件。

- 提供 `name`、`description` 与 `order: 1`，决定名册行的显示文字和排序位置（[packages/preset/agent-presets/presets/standard/preset.yml:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/presets/standard/preset.yml#L1-L3)）

### packages/preset/agent-presets/src/authoring.ts

本地 preset 的拷贝、读取与删除实现，被 `AgentPresets` 的 `copy`/`read`/`remove` 调用。

- 三个错误类分别给出 id 不合法、目标 id 已被占用、以及部署无可写根／目标不可写时的拒绝文本（[packages/preset/agent-presets/src/authoring.ts:23-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L23-L57)）
- `writableRoot` 取第一个 `trust === 'user'` 的根并展开 `~`，找不到就抛 `PresetNotWritableError`（[packages/preset/agent-presets/src/authoring.ts:65-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L65-L71)）
- `readComposition` 以 utf8 读出组合文件原文（[packages/preset/agent-presets/src/authoring.ts:78-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L78-L80)）
- `occupied` 用 stat 判定目标路径是否已被任何条目占用，任何 stat 失败都视为未占用（[packages/preset/agent-presets/src/authoring.ts:83-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L83-L93)）
- `tightenModes` 递归把目录改成 `0o700`、文件按是否带 owner-execute 位改成 `0o700` 或 `0o600`（[packages/preset/agent-presets/src/authoring.ts:101-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L101-L112)）
- `copyComposition` 先用 `PRESET_ID` 校验新 id，不匹配即抛 `InvalidPresetIdError`（[packages/preset/agent-presets/src/authoring.ts:142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L142)）
- 目标目录固定拼在可写根之下，磁盘上已被占用则抛 `PresetExistsError`（[packages/preset/agent-presets/src/authoring.ts:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L143-L147)）
- 以 `recursive`、`dereference`、`force: false`、`errorOnExist: true` 整目录复制源 preset，随后收紧权限（[packages/preset/agent-presets/src/authoring.ts:149-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L149-L152)）
- 重写副本的元数据：保留源的 `description`，丢弃源的 `name` 与 `order`，只在调用方传了 `name` 时写入（[packages/preset/agent-presets/src/authoring.ts:153-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L153-L156)）
- 渲染结果为空时删掉复制来的元数据文件，否则以 `mode: 0o600`／`dirMode: 0o700` 原子写入（[packages/preset/agent-presets/src/authoring.ts:157-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L157-L162)）
- 拷贝过程任一步失败即递归删除目标目录后重抛，不留半份目录（[packages/preset/agent-presets/src/authoring.ts:163-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L163-L168)）
- `deleteComposition` 拒绝 `trust !== 'user'` 的 preset（[packages/preset/agent-presets/src/authoring.ts:186-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L186-L188)）
- 再校验解析出的路径必须是绝对路径且落在可写根目录之下，否则拒绝（[packages/preset/agent-presets/src/authoring.ts:192-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L192-L194)）
- 通过校验后递归强制删除整个 preset 目录（[packages/preset/agent-presets/src/authoring.ts:195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/authoring.ts#L195)）

### packages/preset/agent-presets/src/discovery.ts

preset 的文件系统发现与健康判定，被 `AgentPresets.list()` 每次调用时重新执行。

- `COMPOSITION_FILE` 常量把 `agent.cordis.yml` 定为让一个目录成为 preset 的文件名（[packages/preset/agent-presets/src/discovery.ts:37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L37)）
- `USER_PRESET_DIR` 常量把 harness home 下的 `.agent-presets` 定为本地创作根（[packages/preset/agent-presets/src/discovery.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L51)）
- `SHIPPED_PRESET_ROOT` 以 `import.meta.url` 上一级解析随包发行的 `presets/` 目录，使 `src/` 与打包后的 `lib/` 两种布局都能定位（[packages/preset/agent-presets/src/discovery.ts:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L60)）
- `entryListProblem` 校验顶层必须是列表、每行必须是带非空 `name` 字符串的映射，并对 `group === true` 的行递归进其 `config`，返回一句人读的原因（[packages/preset/agent-presets/src/discovery.ts:74-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L74-L95)）
- `packageInstalled` 把带子路径的说明符截到包名（作用域名占两段），再从 base 逐级向上用 `existsSync` 查 `node_modules/<pkg>/package.json`（[packages/preset/agent-presets/src/discovery.ts:113-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L113-L124)）
- `rowResolves` 按分类作答：builtin 直接为真，package 走内置模块判定或磁盘查找，file／preset 两类拼出 URL 后 stat，全程不 import 任何模块（[packages/preset/agent-presets/src/discovery.ts:155-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L155-L160)）
- `unresolvableRows` 跳过 `Boolean(row.disabled)` 为真的行（`!!js` 表达式求值为对象因而恒真，也被跳过）（[packages/preset/agent-presets/src/discovery.ts:198-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L198-L201)）
- 对 `group === true` 的行递归进其 `config`，并带上位置前缀（[packages/preset/agent-presets/src/discovery.ts:202-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L202-L205)）
- 无法解析的行以 `row "<id>"` 或位置编号标注后按组合顺序收集（[packages/preset/agent-presets/src/discovery.ts:206-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L206-L209)）
- `compositionProblem` 读文件失败时直接给出"组合文件无法读取"的原因（[packages/preset/agent-presets/src/discovery.ts:223-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L223-L230)）
- 用 loader 自带的 `entryListSchema` 方言解析 YAML，解析失败时只取错误信息首行作为原因（[packages/preset/agent-presets/src/discovery.ts:231-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L231-L240)）
- 形状检查通过后，以组合文件所在目录为 preset base 再做行解析检查（[packages/preset/agent-presets/src/discovery.ts:241-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L241-L246)）
- 单条无法解析的行给出单行原因，多条则给出条数加逐行清单（[packages/preset/agent-presets/src/discovery.ts:247-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L247-L254)）
- `isFile` 把任何 stat 失败都当作"该目录未提供组合文件"而非错误（[packages/preset/agent-presets/src/discovery.ts:261-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L261-L270)）
- `scanRoot` 对 ENOENT 的根返回空数组，其他读目录失败则带 cause 抛出（[packages/preset/agent-presets/src/discovery.ts:290-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L290-L297)）
- 只把名字匹配 `PRESET_ID` 的子目录当作名册行，其余目录直接跳过（[packages/preset/agent-presets/src/discovery.ts:300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L300)）
- 组合文件缺失的目录仍进名册，`broken` 写成"文件缺失，目录仍占着这个 id"（[packages/preset/agent-presets/src/discovery.ts:301-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L301-L305)）
- 每行合并读到的展示元数据，`broken` 仅在有原因时写入（[packages/preset/agent-presets/src/discovery.ts:306-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L306-L312)）
- 结果先按 `order`（缺失者视为正无穷）排序，再按 id 本地化比较（[packages/preset/agent-presets/src/discovery.ts:316-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L316-L319)）
- `discoverPresets` 按根的先后顺序合并，同 id 由靠前的根胜出（[packages/preset/agent-presets/src/discovery.ts:328-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/discovery.ts#L328-L340)）

### packages/preset/agent-presets/src/index.ts

`AgentPresets` 服务本体：名册配置、默认 preset、常驻挂载协调、Remote 接口与会话记录，是本包的默认导出插件。

- `SETTINGS_NAMESPACE` 常量把 `agent-presets` 定为承载用户默认 preset 的设置命名空间（[packages/preset/agent-presets/src/index.ts:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L52)）
- `presetFailure` 把 `UnknownPresetError`、`PresetMountError`、`InvalidPresetIdError`／`PresetExistsError`、`PresetNotWritableError`、`PresetLockedError` 分别映射成 `agent-preset-not-found`/`-invalid`/`-read-only`/`-locked` 五种带 details 的 Remote 失败（[packages/preset/agent-presets/src/index.ts:64-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L64-L101)）
- `validatePresetId` 在进入领域操作前拒绝空字符串 id，抛 `bad-request`（[packages/preset/agent-presets/src/index.ts:104-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L104-L108)）
- `rejectPreset` 在没有稳定映射时统一抛 `internal` 并带上调用方的兜底消息（[packages/preset/agent-presets/src/index.ts:111-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L111-L113)）
- `AgentPresetSettingsSchema` 定义用户可写的 `default` 字段（[packages/preset/agent-presets/src/index.ts:122-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L122-L124)）
- `static Config` 声明 `default` 必填、`roots` 每项带 `path` 与默认 `user` 的 `trust`、`includeShippedRoot` 与 `includeUserRoot` 默认为 true（[packages/preset/agent-presets/src/index.ts:159-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L159-L167)）
- 构造时 `ctx.baseUrl` 缺失即抛错，使配置错误在装载阶段就失败（[packages/preset/agent-presets/src/index.ts:221-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L221-L231)）
- `resolvedRoots` 固定为"随包 shipped 根 → 配置根 → harness home 用户根"的顺序，两个开关各自决定是否包含派生根（[packages/preset/agent-presets/src/index.ts:233-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L233-L237)）
- 注入 `settings` 后以 `config.default` 为 base 注册设置命名空间，并在 detach 时把持有的 settings 引用清空（[packages/preset/agent-presets/src/index.ts:243-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L243-L254)）
- 注入 `sessionProjections` 后注册 `agentPreset` 投影定义（[packages/preset/agent-presets/src/index.ts:256-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L256-L258)）
- 监听 `agent/created`，在配置了根却发现该 agent 未加入任何 preset 时打出一条 warn，且不抛错以免否决 agent 发布（[packages/preset/agent-presets/src/index.ts:272-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L272-L280)）
- 监听 `session/event`，把 `agent-preset/selected` 会话事件转发成只带 sessionId 与 preset id 的进程级事件（[packages/preset/agent-presets/src/index.ts:284-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L284-L287)）
- `defaultId` 每次读取都先看设置层再回落到 `config.default`，不缓存（[packages/preset/agent-presets/src/index.ts:297-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L297-L299)）
- `list()` 每次调用都重跑一次磁盘发现，不做记忆化（[packages/preset/agent-presets/src/index.ts:305-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L305-L307)）
- `@Remote('list')` 把名册投影成不含路径的行，标出默认项并附上本部署的可创作能力（[packages/preset/agent-presets/src/index.ts:317-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L317-L331)）
- `resolve()` 按 id（缺省用 `defaultId`）在名册里查找，找不到就抛出带可用 id 列表的 `UnknownPresetError`（[packages/preset/agent-presets/src/index.ts:343-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L343-L351)）
- `resolveMountable()` 在解析之后再拦下 `broken` 的 preset，用发现阶段的原因抛 `PresetMountError`（[packages/preset/agent-presets/src/index.ts:363-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L363-L369)）
- `standing` 以 preset id 为键存放挂载 Promise，实现单飞（[packages/preset/agent-presets/src/index.ts:382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L382)）
- `bindings` 用 WeakMap 按 agent 的 scope key 保存父级绑定句柄，使重新连线的权限只留在本服务内（[packages/preset/agent-presets/src/index.ts:390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L390)）
- `mount()` 拒绝无 scope 的上下文，解析出可挂载 preset 后确保常驻挂载，再把 agent 的 scope key 挂到挂载的 key 之下并留存绑定（[packages/preset/agent-presets/src/index.ts:405-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L405-L418)）
- `composeFrom()` 同步地把子 agent 绑到父 agent 所在的那一代常驻挂载上，不读名册、不挂载、不碰文件；父未加入任何 preset 时返回 undefined（[packages/preset/agent-presets/src/index.ts:446-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L446-L455)）
- `composedPreset()` 从活的 scope 链而非会话记录读出该 agent 运行在哪个 preset（[packages/preset/agent-presets/src/index.ts:466-468](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L466-L468)）
- `roots` getter 暴露实际扫描的根集合而非 `config.roots`（[packages/preset/agent-presets/src/index.ts:477-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L477-L479)）
- `authorable` 以"是否存在 `user` 根"决定本部署能否创作（[packages/preset/agent-presets/src/index.ts:482-484](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L482-L484)）
- `read()` 按 id 解析后读出组合原文（[packages/preset/agent-presets/src/index.ts:492-494](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L492-L494)）
- `@Remote('read')` 返回组合原文加 trust 与展示字段，并把失败转成稳定的 Remote 错误码（[packages/preset/agent-presets/src/index.ts:503-518](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L503-L518)）
- `copy()` 先解析源 preset，再用整份名册（含 shipped）判重后调 `copyComposition`（[packages/preset/agent-presets/src/index.ts:535-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L535-L543)）
- 拷贝完成后删掉同 id 的常驻挂载记录，使新 preset 不继承过期的那一代（[packages/preset/agent-presets/src/index.ts:544-547](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L544-L547)）
- `@Remote('copy')` 校验两个 id 非空后转发，并把失败转成稳定错误码（[packages/preset/agent-presets/src/index.ts:559-568](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L559-L568)）
- `remove()` 删除目录后清掉该 id 的常驻挂载记录，已加入的会话仍留在自己那一代上（[packages/preset/agent-presets/src/index.ts:576-580](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L576-L580)）
- 若被删的正是用户设置里的默认 preset，则以 `unset` 变更清掉该字段，让部署默认重新显露（[packages/preset/agent-presets/src/index.ts:587-591](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L587-L591)）
- `@Remote('deletePreset')` 校验 id 非空后转发删除并映射失败（[packages/preset/agent-presets/src/index.ts:601-609](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L601-L609)）
- `serviceFor()` 让持有 agent 的调用方读到该 agent 所在 preset 在 `isolate` realm 里发布的服务实例（[packages/preset/agent-presets/src/index.ts:626-628](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L626-L628)）
- `recompose()` 先确保新 preset 的常驻挂载再移动父链接，已有绑定走 `rebind`、没有则视作首次 bind（[packages/preset/agent-presets/src/index.ts:653-665](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L653-L665)）
- 重连成功后发 `tools/change` 让工具视图重算，监听器抛错只记 warn（[packages/preset/agent-presets/src/index.ts:669-673](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L669-L673)）
- `switches` 按 agent id 串行化切换，链上存的是吞掉失败的 guard 而非 turn 本身（[packages/preset/agent-presets/src/index.ts:687](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L687)）
- `@Remote('select')` 排队执行切换、把失败映射成稳定错误码，并在自己仍是队尾时清理队列项（[packages/preset/agent-presets/src/index.ts:697-711](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L697-L711)）
- `swap()` 进队后重查会话事件，只要出现过 `turn/start` 就抛 `PresetLockedError`（[packages/preset/agent-presets/src/index.ts:714-721](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L714-L721)）
- 切换提交成功后才向会话日志追加 `agent-preset/selected` 事件（[packages/preset/agent-presets/src/index.ts:722-726](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L722-L726)）
- `standingKeyFor()` 让没有 agent 的读取方（冷读转录）拿到某 preset 的常驻 scope key，且只组合插件、不起 agent／会话／轮次（[packages/preset/agent-presets/src/index.ts:740-743](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L740-L743)）
- `ensureStanding()` 命中已有挂载时先比对组合文件的 mtime／size 印记：印记读不到就沿用当前代，印记变了就（在指针未被他人换过的前提下）删除并递归开出下一代（[packages/preset/agent-presets/src/index.ts:746-767](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L746-L767)）
- 新建一代时先造 scope、先取印记再读文件，印记取不到即抛 `PresetMountError`，随后 `mountPreset`，失败则删表项并 dispose 掉整个 scope（[packages/preset/agent-presets/src/index.ts:768-789](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L768-L789)）
- `compositionStamp()` 取 `mtimeMs` 与 `size`，stat 失败返回 undefined（[packages/preset/agent-presets/src/index.ts:801-810](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L801-L810)）
- `sameStamp()` 以两个字段同时相等判定文件未变（[packages/preset/agent-presets/src/index.ts:813-815](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L813-L815)）
- 默认导出 `AgentPresets`，使该文件成为可在 cordis.yml 里直接命名的服务插件（[packages/preset/agent-presets/src/index.ts:827](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/index.ts#L827)）

### packages/preset/agent-presets/src/invariant.ts

本包的运行期不变量伴生插件，从 `./invariant` 子路径导出，只在装载了 `dsh-invariants` 的组合里生效。

- 以 `name` 与 `inject: ['invariants']` 声明为函数插件，等待不变量服务出现（[packages/preset/agent-presets/src/invariant.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/invariant.ts#L20-L22)）
- 全局监听 `internal/service`，每次服务注册变化都重扫所有活挂载，一旦发现 preset 把服务发布进根 realm 就判失败并点名服务与 preset（[packages/preset/agent-presets/src/invariant.ts:34-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/invariant.ts#L34-L44)）
- 在 `system-prompt/assemble` 瀑布上判定：配置了名册、装配确实带 agent、且该 agent 未加入任何 preset 时判失败，随后仍调用 `next()` 继续装配（[packages/preset/agent-presets/src/invariant.ts:60-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/invariant.ts#L60-L71)）
- `apply` 把安装器以包名注册进不变量服务并返回其 disposer（[packages/preset/agent-presets/src/invariant.ts:79-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/invariant.ts#L79-L80)）

### packages/preset/agent-presets/src/metadata.ts

preset 展示元数据的读写实现，被发现流程与拷贝流程各调用一次。

- `METADATA_FILE` 常量把 `preset.yml` 定为展示元数据文件名（[packages/preset/agent-presets/src/metadata.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/metadata.ts#L25)）
- `text()` 把非字符串与去空白后为空的值统一归为 undefined（[packages/preset/agent-presets/src/metadata.ts:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/metadata.ts#L42-L46)）
- `readPresetMetadata` 在文件读取失败时返回空元数据而非报错（[packages/preset/agent-presets/src/metadata.ts:56-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/metadata.ts#L56-L64)）
- YAML 解析失败同样返回空元数据，使展示文字损坏不会让发现或挂载失败（[packages/preset/agent-presets/src/metadata.ts:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/metadata.ts#L65-L72)）
- 解析结果不是普通对象时返回空元数据，是则只取 `name`、`description` 与有限数值的 `order` 三项，其余键一律丢弃（[packages/preset/agent-presets/src/metadata.ts:73-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/metadata.ts#L73-L84)）
- `renderPresetMetadata` 在三个字段都为空时返回 undefined，否则只写非空字段并以 `lineWidth: -1` 关闭折行（[packages/preset/agent-presets/src/metadata.ts:95-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/metadata.ts#L95-L105)）

### packages/preset/agent-presets/src/mount.ts

把一份 preset 组合挂进 scope 上下文并在返回前做可用性审计的实现，由 `ensureStanding` 调用。

- `mounted` 以 config 对象为键记录每次挂载产出的 entry tree 与 fiber（[packages/preset/agent-presets/src/mount.ts:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L43)）
- `harnessBase` 以同一 config 为键记录挂载前的 base URL，因为 `Include` 会把自身上下文的 `baseUrl` 改写成组合所在目录（[packages/preset/agent-presets/src/mount.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L51)）
- `PresetTree` 构造时把自身与所在 fiber 登记进 `mounted`，供后续审计读取（[packages/preset/agent-presets/src/mount.ts:57-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L57-L61)）
- 覆写 `import()`：builtin 与 preset 相对路径仍走父类，包名与 file URL 改用 loader 内部解析器从记录的 harness base 解析（[packages/preset/agent-presets/src/mount.ts:84-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L84-L95)）
- 覆写 `write()` 为空实现，使 loader 的回写（以及随之而来的 `loader/config-update`）不会改写 preset 文件（[packages/preset/agent-presets/src/mount.ts:113-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L113-L114)）
- `mounts` 集合保存所有已装好的 preset 挂载记录（[packages/preset/agent-presets/src/mount.ts:129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L129)）
- `pruneDisposedMounts` 以 `fiber.uid === null` 为判据清掉已销毁的记录（[packages/preset/agent-presets/src/mount.ts:147-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L147-L151)）
- `livePresetMounts` 先清理再返回当前所有活挂载（[packages/preset/agent-presets/src/mount.ts:158-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L158-L161)）
- `withinFiber` 沿 fiber 的 parent 链以对象同一性判断归属，到达自环即停（[packages/preset/agent-presets/src/mount.ts:173-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L173-L181)）
- `leakedServices` 遍历服务库的自有 symbol，挑出属于该子树、且 symbol 正是根 realm 为该名字所用的那些实现，按名字排序返回（[packages/preset/agent-presets/src/mount.ts:194-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L194-L208)）
- `standingMountFor` 取 agent 的 scope key 的父键，再在活挂载里按 key 相等找到对应的常驻组合（[packages/preset/agent-presets/src/mount.ts:227-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L227-L235)）
- `serviceForAgent` 在服务库里按名字加 fiber 归属找出该 agent 所在挂载发布的那一个实例，包括藏在 `isolate` realm 后的（[packages/preset/agent-presets/src/mount.ts:261-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L261-L277)）
- `inactiveRows` 跳过 disabled 行，为无 fiber 的行与仍在等待某些注入服务的行各生成一条诊断（[packages/preset/agent-presets/src/mount.ts:288-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L288-L306)）
- `detailBranches` 从 `AggregateError` 本身或其作为 cause 的聚合错误里取出分支（[packages/preset/agent-presets/src/mount.ts:322-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L322-L325)）
- `mountDetail` 把聚合失败展开成逐行文本，嵌套组的行按层缩进（[packages/preset/agent-presets/src/mount.ts:339-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L339-L350)）
- `mountPreset` 拒绝无 scope 的目标上下文，理由是其注册会落到进程内每个 agent 上（[packages/preset/agent-presets/src/mount.ts:362-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L362-L369)）
- 以组合文件的 file URL 构造 `Include.Config`，并在插入子树前记下该上下文的 `baseUrl` 作为包名解析基准（[packages/preset/agent-presets/src/mount.ts:370-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L370-L375)）
- 在添加本次记录前先清一遍已销毁记录（[packages/preset/agent-presets/src/mount.ts:379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L379)）
- 插入 `PresetTree` 并等待其结算，再从 `mounted` 取回 tree 与 fiber（[packages/preset/agent-presets/src/mount.ts:380-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L380-L386)）
- 有未激活的行则抛出带条数与逐行说明的错误（[packages/preset/agent-presets/src/mount.ts:387-390](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L387-L390)）
- 有服务泄漏进根 realm 则抛错并点名服务，提示改用 `isolate` realm 或移入 host 组合（[packages/preset/agent-presets/src/mount.ts:391-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L391-L397)）
- 全部通过后把 presetId、fiber、tree 与当前 scope key 记入 `mounts`（[packages/preset/agent-presets/src/mount.ts:398](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L398)）
- 任一步失败即先 dispose 子树（吞掉拆除自身的失败），再抛出带展开明细与组合路径的 `PresetMountError`（[packages/preset/agent-presets/src/mount.ts:399-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/mount.ts#L399-L410)）

### packages/preset/agent-presets/src/preset.ts

preset 词汇表：id 规则、`AgentPreset`/`PresetRoot`/`Config` 三个接口与三个错误类，被发现、挂载与消费方共用。

- `PRESET_ID` 正则把 preset 目录名限定为小写字母数字起头、其后只含小写字母数字与连字符，从而挡住 `..` 与路径分隔符（[packages/preset/agent-presets/src/preset.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/preset.ts#L20)）
- `UnknownPresetError` 携带被请求的 id 与当前可用 id 列表，消息里把可用列表拼进去、为空时写 `none`（[packages/preset/agent-presets/src/preset.ts:81-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/preset.ts#L81-L90)）
- `PresetLockedError` 携带 sessionId 与被拒 preset，消息说明会话已开始因而组合固定（[packages/preset/agent-presets/src/preset.ts:97-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/preset.ts#L97-L106)）
- `PresetMountError` 携带 presetId 与不带本包前缀的原因，并支持透传 `cause`（[packages/preset/agent-presets/src/preset.ts:109-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/preset.ts#L109-L119)）

### packages/preset/agent-presets/src/session.ts

会话侧记录：`agent-preset/selected` 事件声明与 `agentPreset` 会话投影定义，由 `AgentPresets` 在注入 `sessionProjections` 后注册。

- 通过声明合并把 `agent-preset/selected`（负载 `{ agentPreset: string }`）加入 `SessionEventMap`，使这条事件成为会话日志词汇的一员（[packages/preset/agent-presets/src/session.ts:20-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/session.ts#L20-L30)）
- 投影状态与 wire 视图共用 `string | null` 的 zod 模式（[packages/preset/agent-presets/src/session.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/session.ts#L32)）
- `agentPreset` 投影以会话头里的 `agentPreset`（缺失则 null）初始化，遇到 `agent-preset/selected` 事件就换成事件里的值、其余事件保持原状，并以 `stateVersion: 1` 定版（[packages/preset/agent-presets/src/session.ts:35-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/session.ts#L35-L44)）

### packages/preset/agent-presets/src/specifier.ts

组合行 `name` 的分类函数，供挂载时的 import 覆写与发现时的健康检查共用同一套判定。

- `classifyRowSpecifier` 依次判定：`cordis:` 前缀为 builtin、`.` 开头为 preset 相对路径、`file:` 前缀为 file、绝对路径转成 file URL 后归为 file、其余归为 package（[packages/preset/agent-presets/src/specifier.ts:43-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/preset/agent-presets/src/specifier.ts#L43-L49)）

### packages/preset/agent-presets/src/types.ts

客户端可见的负载类型与两处声明合并，只含类型、无运行期代码。

- 无运行期机制

### packages/preset/agent-presets/tsconfig.json

包的 TypeScript 编译配置，声明 rootDir／outDir 与工作区依赖的项目引用。

- 无运行期机制
