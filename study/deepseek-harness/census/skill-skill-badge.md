---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/skill/skill-badge
---

# packages/skill/skill-badge

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、17 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/skill/skill-badge/README.md

内置徽章技能提供方的英文说明文档，描述启用方式与该技能提供的内容。

- 无运行期机制

### packages/skill/skill-badge/assets/dsh-badge.md

被 `src/index.ts` 在每次加载时整体读入、并作为 `<skill_instructions>` 正文进入模型上下文的技能体。

- 列出可用资源：本地 PNG 文件名与源尺寸、Shields.io 图片 URL、项目 URL（[packages/skill/skill-badge/assets/dsh-badge.md:5-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/assets/dsh-badge.md#L5-L9)）
- 给出模型应直接复制的两段 Markdown 片段：带链接版本与不带链接版本（[packages/skill/skill-badge/assets/dsh-badge.md:11-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/assets/dsh-badge.md#L11-L23)）
- 规定按目标系统选择远程 URL 还是上传本地 PNG、保持 121×20 尺寸、放在文末，并禁止替换颜色、logo、文案或项目 URL（[packages/skill/skill-badge/assets/dsh-badge.md:25-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/assets/dsh-badge.md#L25-L31)）

### packages/skill/skill-badge/package.json

该包的 npm 清单，声明入口、导出子路径与发布文件集。

- `main`/`types` 与 `exports` 把包名解析到 `lib/index.js`，`./invariant` 解析到 `lib/invariant.js`（[packages/skill/skill-badge/package.json:14-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/package.json#L14-L26)）
- `files` 把 `assets` 目录一并纳入发布产物，使技能体与 PNG 随包分发、可被运行期读取（[packages/skill/skill-badge/package.json:27-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/package.json#L27-L32)）

### packages/skill/skill-badge/src/index.ts

内置徽章技能提供方的插件入口，向 `ctx.skills` 注册一个固定候选并在加载时读取包内技能体。

- 技能体路径与资源基目录都相对 `import.meta.url` 解析，指向包内 `assets/`（[packages/skill/skill-badge/src/index.ts:18-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/index.ts#L18-L22)）
- 调用策略固定为模型面与用户面同时开放（[packages/skill/skill-badge/src/index.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/index.ts#L23)）
- 描述文本进入模型可见的技能目录，并指示在创建 pull request 或 merge request 时以及用户索要徽章时调用（[packages/skill/skill-badge/src/index.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/index.ts#L24)）
- 固定候选以 `dsh-badge` 为名、来源标为 `bundled`、rank 取共享的 `BUNDLED_SKILL_RANK`，locator 为技能体 URL（[packages/skill/skill-badge/src/index.ts:25-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/index.ts#L25-L34)）
- `list()` 恒返回这一个候选的数组简写，即每次发现都完整且只有一项（[packages/skill/skill-badge/src/index.ts:38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/index.ts#L38)）
- `get()` 忽略传入候选，每次都重新读取 `assets/dsh-badge.md` 的当前内容并附带 directory 型资源基目录返回（[packages/skill/skill-badge/src/index.ts:39-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/index.ts#L39-L49)）
- 导出 `name` 与 `inject`，使插件以 `skill-badge` 名加载并要求 `skills` 服务先就绪（[packages/skill/skill-badge/src/index.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/index.ts#L53-L55)）
- `apply` 把该不可变提供方注册到 `ctx.skills`（[packages/skill/skill-badge/src/index.ts:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/index.ts#L58-L60)）

### packages/skill/skill-badge/src/invariant.ts

该包的不变量伴生插件，由不变量服务在启动检查时加载。

- 导出 `name` 与 `inject`，使 Cordis 以 `skill-badge-invariant` 名加载并要求 `invariants` 服务先就绪（[packages/skill/skill-badge/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/invariant.ts#L13-L15)）
- `apply` 以包名注册一个空安装器并返回其 disposer（[packages/skill/skill-badge/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/invariant.ts#L21)、[packages/skill/skill-badge/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-badge/src/invariant.ts#L28-L29)）

### packages/skill/skill-badge/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
