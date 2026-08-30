---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/compaction/command-compact
---

# packages/compaction/command-compact

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、18 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/compaction/command-compact/README.md

包 README，说明 `/compact` 命令的用法、各类失败对应的固定提示文本以及如何在组合里挂载它。

- 无运行期机制

### packages/compaction/command-compact/package.json

包清单，声明这个命令插件的入口与发布文件白名单。

- `exports` 声明根入口、`./invariant` 与 `./src/*` 三类子路径（[packages/compaction/command-compact/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/package.json#L16-L27)）
- `files` 白名单只发布 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/compaction/command-compact/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/package.json#L28-L32)）

### packages/compaction/command-compact/src/index.ts

插件入口：向命令注册表注册 `/compact`，把压缩服务的失败码翻译成人可读结果，并管理生命周期排空。

- 插件注入 `commands` 与 `compaction` 两个服务（[packages/compaction/command-compact/src/index.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L11)）
- 带参数调用时返回固定的用法文本（[packages/compaction/command-compact/src/index.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L13)）
- 闭合联合出现未处理成员时 `assertNever` 抛出 TypeError（[packages/compaction/command-compact/src/index.ts:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L17-L19)）
- 六个失败码 `busy`/`cancelled`/`changed`/`summary`/`commit`/`persistence` 各自映射为一条固定的 `kind: 'error'` 文本（[packages/compaction/command-compact/src/index.ts:23-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L23-L55)）
- 原始输入去空白后非空即以用法文本失败，不调用压缩（[packages/compaction/command-compact/src/index.ts:62-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L62-L64)）
- 用调用方的 agent、取消信号与命令 id 调用 `ctx.compaction.compactNow`（[packages/compaction/command-compact/src/index.ts:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L66)）
- 结果为 `null` 时返回「无可压缩历史」的成功文本（[packages/compaction/command-compact/src/index.ts:67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L67)）
- 成功时报告被遮蔽的历史条数与估算 token，并把 `summarySeq` 作为 `sourceEventSeq` 回传（[packages/compaction/command-compact/src/index.ts:68-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L68-L72)）
- 捕获异常时先看信号是否已中止（返回取消文本），再看是否为 `ManualCompactionError`（走码表），其余原样抛出（[packages/compaction/command-compact/src/index.ts:73-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L73-L77)）
- 处理器把每次调用的 promise 记入活动集合，并在成功与失败两条路径上都摘除，不重新抛出（[packages/compaction/command-compact/src/index.ts:85-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L85-L94)）
- 生命周期 effect 先 yield 排空回调、再 yield 命令注册，使拆解按后进先出先摘掉注册再等待已开始的处理器结算（[packages/compaction/command-compact/src/index.ts:96-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L96-L105)）
- 注册的命令名为 `compact`，带描述文本与该处理器（[packages/compaction/command-compact/src/index.ts:100-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/index.ts#L100-L104)）

### packages/compaction/command-compact/src/invariant.ts

包自有的 invariant 伴生插件，向 invariants 服务登记本包的所有权。

- 声明伴生插件名并注入 `invariants` 服务（[packages/compaction/command-compact/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/invariant.ts#L13-L15)）
- 以空安装器向 `ctx.invariants` 注册包名并返回 disposer（[packages/compaction/command-compact/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/command-compact/src/invariant.ts#L21-L29)）

### packages/compaction/command-compact/tsconfig.json

包的 TypeScript 编译配置与工作区引用。

- 无运行期机制
