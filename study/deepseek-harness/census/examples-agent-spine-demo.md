---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/examples/agent-spine-demo
---

# packages/examples/agent-spine-demo

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、30 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/examples/agent-spine-demo/README.md

包 README，说明该 bundle 装载了哪些子插件、留给部署方自选哪些后端、以及各配置字段的含义。

- 无运行期机制

### packages/examples/agent-spine-demo/package.json

包清单，声明该 bundle 作为 ESM 插件包的入口、导出路径与发布内容。

- 声明 `"type": "module"` 与 `main`/`types` 入口指向 `lib/index.js` 与类型声明（[packages/examples/agent-spine-demo/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/package.json#L13-L15)）
- `exports` 只暴露根入口、`./invariant` companion、`./src/*` 源码与 `./package.json` 四个解析路径（[packages/examples/agent-spine-demo/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明文件（[packages/examples/agent-spine-demo/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/package.json#L28-L32)）

### packages/examples/agent-spine-demo/src/index.ts

bundle 插件入口，定义整份配置模式并在 `apply` 中把每个子插件挂到本 fiber 下、把配置字段分发给各自的属主。

- 以具名导出而非默认导出提供插件，避免 Loader 的默认解包丢掉 `Config` 模式（[packages/examples/agent-spine-demo/src/index.ts:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L40)）
- 定义会话标题的示例默认限额：回退标题 5 词、40 字节，接受标题上限 80 字节（[packages/examples/agent-spine-demo/src/index.ts:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L43-L47)）
- `SkillConfigSchema` 让技能栈的 `enabled` 默认为 true，并把注册表、本地提供方、模型面工具三段配置各自转交属主模式（[packages/examples/agent-spine-demo/src/index.ts:133-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L133-L138)）
- `SessionTitleConfigSchema` 用示例限额作为 `sessionTitle` 的默认值（[packages/examples/agent-spine-demo/src/index.ts:141-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L141-L142)）
- `ToolBashConfigSchema` 允许 `false` 以关闭模型面 bash 工具（[packages/examples/agent-spine-demo/src/index.ts:145-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L145-L146)）
- `Config` 由 agent-loop、system-prompt 与本 bundle 自有字段三段模式求交，使校验与默认值与各属主保持一致（[packages/examples/agent-spine-demo/src/index.ts:161-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L161-L176)）
- `workspaceContext` 被声明为 `required`，必须显式给出字节预算或 `false`（[packages/examples/agent-spine-demo/src/index.ts:169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L169)）
- `pickSpineConfig` 只复制 bundle 自有字段并保留可选字段的"缺省"状态，使入口层设置不会渗进 spine（[packages/examples/agent-spine-demo/src/index.ts:183-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L183-L201)）
- `apply` 在顶层 `dshHome` 与 `skills.filesystem.dshHome` 解析结果不一致时直接抛错（[packages/examples/agent-spine-demo/src/index.ts:214-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L214-L218)）
- 解析出一个共享的 harness home，供 shell 环境与本地技能发现共用（[packages/examples/agent-spine-demo/src/index.ts:219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L219)）
- 挂载 timer、LLM 服务与会话存储三个基础服务（[packages/examples/agent-spine-demo/src/index.ts:221-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L221-L223)）
- 挂载会话标题服务，配置缺省时用 bundle 的示例限额（[packages/examples/agent-spine-demo/src/index.ts:224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L224)）
- 挂载 system-prompt 并把 harness 身份、运行期上下文快照默认置 true、persona 默认空串传下去，`toolOrder` 仅在显式给出时转发（[packages/examples/agent-spine-demo/src/index.ts:226-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L226-L231)）
- 挂载工具注册表并把 `tools`（含模型面呈现 mode）转发给它（[packages/examples/agent-spine-demo/src/index.ts:232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L232)）
- 技能默认启用，启用时挂载技能注册表与本地文件系统提供方，并强制用共享 home 覆盖其 `dshHome`（[packages/examples/agent-spine-demo/src/index.ts:233-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L233-L237)）
- 挂载 agent 注册表与请求重试插件（[packages/examples/agent-spine-demo/src/index.ts:238-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L238-L239)）
- 仅当 `goals` 显式给出且不为 `false` 时才挂载目标域服务、模型面目标工具与同会话目标轮驱动（[packages/examples/agent-spine-demo/src/index.ts:240-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L240-L244)）
- 挂载进程内后台作业注册表并转发 `jobs` 准入配置（[packages/examples/agent-spine-demo/src/index.ts:245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L245)）
- 挂载 invariant 注册表及 session/agent/scope/agent-loop 四个 companion（[packages/examples/agent-spine-demo/src/index.ts:246-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L246-L250)）
- `toolBash` 非 `false` 时同时挂载受管 shell 环境与模型面 bash 工具（[packages/examples/agent-spine-demo/src/index.ts:251-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L251-L254)）
- `workspaceContext` 非 `false` 时挂载工作区说明加载器并转发其字节预算（[packages/examples/agent-spine-demo/src/index.ts:255-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L255-L257)）
- 技能工具在工作区说明之后挂载，使两者的会话前缀消息按注册顺序渲染（[packages/examples/agent-spine-demo/src/index.ts:258-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L258-L260)）
- `toolJobs` 非 `false` 时挂载后台作业控制工具（[packages/examples/agent-spine-demo/src/index.ts:261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L261)）
- 最后挂载具体的 agent-loop，`agents` 缺省为空列表，`maxParallelToolCalls` 仅在显式给出时转发（[packages/examples/agent-spine-demo/src/index.ts:262-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/index.ts#L262-L265)）

### packages/examples/agent-spine-demo/src/invariant.ts

本包的 invariant companion 插件，向 invariants 注册表登记包名。

- `apply` 用包名与空安装器调用 `ctx.invariants.register`，并返回该注册的 disposer（[packages/examples/agent-spine-demo/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/examples/agent-spine-demo/src/invariant.ts#L28-L29)）

### packages/examples/agent-spine-demo/tsconfig.json

包级 TypeScript 编译配置，声明源码根、类型输出目录与全部工作区引用。

- 无运行期机制
