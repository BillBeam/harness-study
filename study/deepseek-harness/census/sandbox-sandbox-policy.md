---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/sandbox/sandbox-policy
---

# packages/sandbox/sandbox-policy

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、30 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/sandbox/sandbox-policy/README.md

包的说明文档，介绍策略解析顺序、按会话覆盖的存储方式，以及注入模型上下文的三段文本；供使用者和维护者阅读。

- 无运行期机制

### packages/sandbox/sandbox-policy/package.json

包清单，声明入口、导出映射与发布内容。

- `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/sandbox/sandbox-policy/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/package.json#L14-L15)）
- `exports` 把根入口、`./invariant` companion、`./src/*` 源码路径和 `./package.json` 暴露为可导入子路径，其余路径不可导入（[packages/sandbox/sandbox-policy/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/package.json#L16-L27)）
- `files` 限定发布包内只含两个运行期 bundle 与类型声明（[packages/sandbox/sandbox-policy/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/package.json#L28-L32)）

### packages/sandbox/sandbox-policy/src/index.ts

包主入口，定义 `ctx.sandboxPolicy` 服务：保存部署级默认模式与回退工作区根，按调用解析策略，并向每次请求前的运行期上下文快照贡献一段文本。

- `resolveWorkspaceRoot` 先做文件系统规范化再做路径 resolve，得到绝对工作区根（[packages/sandbox/sandbox-policy/src/index.ts:32-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L32-L35)）
- `renderPolicyContext` 按 `read-only` / `workspace-write` / `danger-full-access` 三种模式返回三段固定的模型可见文本，`workspace-write` 分支把工作区根以 JSON 字符串形式嵌入（[packages/sandbox/sandbox-policy/src/index.ts:38-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L38-L45)）
- 模式落在闭合枚举之外时抛出 `unreachable sandbox mode` 错误（[packages/sandbox/sandbox-policy/src/index.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L46-L50)）
- 在 Cordis `Context` 上声明 `sandboxPolicy` 服务属性（[packages/sandbox/sandbox-policy/src/index.ts:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L54-L58)）
- `static Config` 把 `mode` 限制为三值联合并默认 `read-only`，`workspaceRoot` 为无默认值的字符串（[packages/sandbox/sandbox-policy/src/index.ts:93-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L93-L98)）
- 构造函数以 `sandboxPolicy` 名注册服务，并把配置的 `mode` 存为部署默认（[packages/sandbox/sandbox-policy/src/index.ts:105-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L105-L109)）
- 未配置 `workspaceRoot` 时回退到 `process.cwd()`，两种来源都规范化为绝对路径（[packages/sandbox/sandbox-policy/src/index.ts:110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L110)）
- 在 `systemPrompt` 可用时注册名为 `sandbox:policy`、`order: 110` 的上下文段，文本由当前会话解析出的策略渲染；无会话时贡献空串（[packages/sandbox/sandbox-policy/src/index.ts:112-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L112-L123)）
- `resolve` 的模式优先级为：显式传入模式 → 会话最后一次 `sandbox/mode` 覆盖 → 部署默认（[packages/sandbox/sandbox-policy/src/index.ts:138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L138)）
- `resolve` 用会话头部的 `cwd` 作为工作区根，缺失时用配置的回退根，并规范化（[packages/sandbox/sandbox-policy/src/index.ts:139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L139)）
- 有会话时在返回的策略里附带 `sessionId` 字段，无会话时不附带（[packages/sandbox/sandbox-policy/src/index.ts:140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L140)）
- `overrideOf` 对会话事件流做折叠，返回覆盖模式或 `undefined`，不套用部署默认（[packages/sandbox/sandbox-policy/src/index.ts:149-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L149-L151)）
- 服务类作为默认导出，使其可被 Loader 作为插件挂载（[packages/sandbox/sandbox-policy/src/index.ts:154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L154)）

### packages/sandbox/sandbox-policy/src/invariant.ts

包自带的不变量 companion 插件，注册到 `invariants` 服务，校验本包拥有的会话事件字段。

- 声明插件名与 `inject: ['invariants']`，决定该 companion 在 `invariants` 服务就绪后才装载（[packages/sandbox/sandbox-policy/src/invariant.ts:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/invariant.ts#L11-L13)）
- `validateEvent` 对 `sandbox/mode` 事件校验其 `mode` 是否在闭合词表内，越界时报告失败并回显该值（[packages/sandbox/sandbox-policy/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/invariant.ts#L17-L21)）
- 安装时遍历已加载的全部会话及其事件做一次全量校验（[packages/sandbox/sandbox-policy/src/invariant.ts:25-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/invariant.ts#L25-L27)）
- 以 `global: true` 监听 `internal/dispatch`，对每个新派发的 `session/event` 取出事件继续校验（[packages/sandbox/sandbox-policy/src/invariant.ts:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/invariant.ts#L28-L32)）
- `install` 自身带 `inject: ['sessions']`，安装前先等待会话服务（[packages/sandbox/sandbox-policy/src/invariant.ts:33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/invariant.ts#L33)）
- `apply` 以包名向 `invariants` 注册安装器并返回其 disposer（[packages/sandbox/sandbox-policy/src/invariant.ts:41-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/invariant.ts#L41-L42)）

### packages/sandbox/sandbox-policy/src/session-mode.ts

按会话的沙箱模式覆盖：声明 `sandbox/mode` 会话事件、对事件流的折叠函数和唯一写入路径，被主入口的解析与不变量 companion 使用。

- 通过声明合并向会话事件表加入 `sandbox/mode` 事件，载荷含 `mode` 与可选的 `source: 'delegation'`（[packages/sandbox/sandbox-policy/src/session-mode.ts:24-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/session-mode.ts#L24-L39)）
- `SANDBOX_MODES` 列出三个模式值，供选项展示与不可信字符串的运行期校验（[packages/sandbox/sandbox-policy/src/session-mode.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/session-mode.ts#L42)）
- `effectiveSandboxMode` 从后向前扫描事件，返回最后一条 `sandbox/mode` 的模式，没有则返回 `undefined`（[packages/sandbox/sandbox-policy/src/session-mode.ts:52-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/session-mode.ts#L52-L58)）
- `setSandboxMode` 只向会话追加一条 `sandbox/mode` 事件，不改动任何其他状态（[packages/sandbox/sandbox-policy/src/session-mode.ts:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/session-mode.ts#L69-L71)）

### packages/sandbox/sandbox-policy/tsconfig.json

包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区项目引用。

- 无运行期机制

### packages/sandbox/sandbox-policy/tsdown.config.ts

打包配置，决定该包发布的运行期产物。

- 把包根入口与 invariant companion 分别打成两个独立 bundle，输出到 `lib`，与 `package.json` 的两个导出路径对应（[packages/sandbox/sandbox-policy/tsdown.config.ts:4-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/tsdown.config.ts#L4-L24)）
- 两个 bundle 均以 ESM、Node 平台、es2024 目标产出，且不清理输出目录、不生成声明文件（[packages/sandbox/sandbox-policy/tsdown.config.ts:6-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/tsdown.config.ts#L6-L13)）
