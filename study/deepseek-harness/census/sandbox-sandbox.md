---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/sandbox/sandbox
---

# packages/sandbox/sandbox

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、26 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/sandbox/sandbox/README.md

包参考文档，说明进程沙箱服务的模式词汇、逐次调用策略、失败关闭行为与升级流程。

- 无运行期机制

### packages/sandbox/sandbox/package.json

包清单，声明沙箱服务定义包的入口、导出与发布内容。

- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，并暴露 `./src/*` 与 `./package.json`（[packages/sandbox/sandbox/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/package.json#L16-L27)）
- `files` 把发布内容限制为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的声明文件（[packages/sandbox/sandbox/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/package.json#L28-L32)）

### packages/sandbox/sandbox/src/escalation.ts

沙箱升级的共享词汇与流程：更宽模式表、参数配对校验、面向模型的拒绝与提示标记，以及执行前解析升级请求的审批函数。

- `WIDER_MODES` 固定 `read-only` 可升到 `workspace-write` 与 `danger-full-access`、`workspace-write` 只可升到 `danger-full-access`（[packages/sandbox/sandbox/src/escalation.ts:28-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L28-L31)）
- `ESCALATION_TARGETS` 把工具 schema 里可请求的目标模式封闭为 `workspace-write` 与 `danger-full-access`（[packages/sandbox/sandbox/src/escalation.ts:41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L41)）
- `validateEscalationArgs` 在只给 `sandbox_permissions` 不给理由、只给理由不给模式、或理由为空白时分别抛出不同错误（[packages/sandbox/sandbox/src/escalation.ts:51-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L51-L61)）
- `sandboxDenialMarker` 生成模型可见的拒绝行 `[sandbox: file access denied under <mode> mode]`（[packages/sandbox/sandbox/src/escalation.ts:71-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L71-L73)）
- `escalationHintMarker` 生成模型可见的升级提示行，含"用 sandbox_permissions 加 justification 原样重试一次"的措辞（[packages/sandbox/sandbox/src/escalation.ts:84-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L84-L86)）
- `approveEscalation` 先按本次调用的生效模式查更宽表，非严格更宽时直接抛错且不弹审批（[packages/sandbox/sandbox/src/escalation.ts:162-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L162-L164)）
- 未组合审批服务时抛出"requires approval, but no approval service is composed"（[packages/sandbox/sandbox/src/escalation.ts:165-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L165-L167)）
- 调用没有可路由的 agent 时抛出"no agent to route it through"（[packages/sandbox/sandbox/src/escalation.ts:168-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L168-L170)）
- 审批请求带上 agent、工具名、调用 id、`escalate sandbox to <mode>: <justification>` 的理由，以及存在时的中止信号（[packages/sandbox/sandbox/src/escalation.ts:173-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L173-L179)）
- 审批结果分派：`allowed-once` 返回被授予的模式，`rejected`/`cancelled`/`unavailable` 各抛一条固定文本的错误，其余走 `assertNever`（[packages/sandbox/sandbox/src/escalation.ts:180-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L180-L188)）

### packages/sandbox/sandbox/src/index.ts

服务定义入口，声明 `ctx.sandbox` 抽象服务、模式与执行策略类型、以及失败关闭的错误。

- 从 `./escalation.ts` 与 `./roots.ts` 再导出升级词汇与可写根推导，使消费者只依赖包根（[packages/sandbox/sandbox/src/index.ts:12-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/index.ts#L12-L21)）
- `SANDBOX_UNAVAILABLE` 定义结构化错误码常量，供 `tool/result` 传递（[packages/sandbox/sandbox/src/index.ts:124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/index.ts#L124)）
- `SandboxUnavailableError` 用固定文本说明拒绝以非受限方式运行命令并列出各平台的补救途径，带上错误码，且在给出 detail 时追加 ` Runner failure: <detail>`（[packages/sandbox/sandbox/src/index.ts:131-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/index.ts#L131-L144)）
- `SandboxProvider` 构造时以 `'sandbox'` 名注册服务，使实现挂载后即成为 `ctx.sandbox`（[packages/sandbox/sandbox/src/index.ts:158-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/index.ts#L158-L162)）
- 抽象方法 `confine(argv, policy)` 规定实现必须返回可替换原 argv 的受限调用，而不是原样放行（[packages/sandbox/sandbox/src/index.ts:175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/index.ts#L175)）
- 服务类作为默认导出（[packages/sandbox/sandbox/src/index.ts:178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/index.ts#L178)）

### packages/sandbox/sandbox/src/invariant.ts

该包的不变量伴生插件，向不变量注册表登记包名。

- `inject = ['invariants']` 使伴生插件在不变量注册表可用之后才执行（[packages/sandbox/sandbox/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/invariant.ts#L15)）
- 安装器为空函数，登记后不注册任何监听或检查（[packages/sandbox/sandbox/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 占用该包名并返回注销函数（[packages/sandbox/sandbox/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/invariant.ts#L28-L29)）

### packages/sandbox/sandbox/src/roots.ts

可写根推导，供 Seatbelt 配置与进程内文件系统栅栏共用同一份允许列表。

- `canonicalPath` 用 `realpathSync.native` 解析符号链接，失败时原样返回传入路径（[packages/sandbox/sandbox/src/roots.ts:30-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/roots.ts#L30-L41)）
- `writableRoots` 在非 `workspace-write` 模式下返回空列表（[packages/sandbox/sandbox/src/roots.ts:52-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/roots.ts#L52-L53)）
- `workspace-write` 下把工作区根、`/tmp` 与 `os.tmpdir()` 一并规范化并去重后返回（[packages/sandbox/sandbox/src/roots.ts:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/roots.ts#L54)）

### packages/sandbox/sandbox/tsconfig.json

该包的 TypeScript 编译配置与工程引用。

- 无运行期机制
