---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subagent/subagent-spawn-in-process
---

# packages/subagent/subagent-spawn-in-process

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、13 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subagent/subagent-spawn-in-process/README.md

该包的说明文档，描述 spawn 后端的配置字段、启动流程与子代理可见内容，供使用者与维护者阅读。

- 无运行期机制

### packages/subagent/subagent-spawn-in-process/package.json

该包的 npm 清单，声明入口、导出子路径与发布文件集。

- `main`/`types` 把包的默认加载入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/subagent/subagent-spawn-in-process/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/package.json#L14-L15)）
- `exports` 只暴露根入口、`./invariant`、`./src/*` 与 `./package.json` 四个可解析子路径（[packages/subagent/subagent-spawn-in-process/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的声明文件（[packages/subagent/subagent-spawn-in-process/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/package.json#L28-L32)）

### packages/subagent/subagent-spawn-in-process/src/index.ts

进程内 spawn 后端插件入口，向 `ctx.subagents` 注册一个把每次委派跑成全新子代理的 provider。

- 声明 `inject = ['subagents']`，使 `apply` 只在 subagents 服务就绪后运行，并刻意不注入 `tools`（[packages/subagent/subagent-spawn-in-process/src/index.ts:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/src/index.ts#L20-L22)）
- `Config` 模式把注册名 `providerName` 默认成 `spawn`，决定委派工具按哪个名字找到该后端（[packages/subagent/subagent-spawn-in-process/src/index.ts:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/src/index.ts#L30-L32)）
- provider 把 `agentOptions`、`outputSchema`、`depthLimit`、`toolFilter`、`persona` 五项启动能力全部声明为 true，上游据此接受或拒绝对应配置（[packages/subagent/subagent-spawn-in-process/src/index.ts:42-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/src/index.ts#L42-L48)）
- `inheritsParentContext = false` 声明子代理不携带父会话，委派工具据此选择工具描述措辞（[packages/subagent/subagent-spawn-in-process/src/index.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/src/index.ts#L50)）
- `start()` 以空的 seed 对象调用 `startInProcessRun`，由共享驱动铸 id、盖 cwd/lineage/depth 并驱动一次性任务（[packages/subagent/subagent-spawn-in-process/src/index.ts:54-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/src/index.ts#L54-L59)）
- `prepareContinuable()` 返回空对象，可续子代理同样不带任何父会话种子（[packages/subagent/subagent-spawn-in-process/src/index.ts:61-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/src/index.ts#L61-L65)）
- `apply` 用配置的名字实例化并调用 `ctx.subagents.registerProvider` 完成注册（[packages/subagent/subagent-spawn-in-process/src/index.ts:68-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/src/index.ts#L68-L70)）

### packages/subagent/subagent-spawn-in-process/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包归属。

- 以空安装器向 `ctx.invariants` 注册包名并返回其 disposer，即运行期不安装任何检查（[packages/subagent/subagent-spawn-in-process/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subagent/subagent-spawn-in-process/src/invariant.ts#L21-L29)）

### packages/subagent/subagent-spawn-in-process/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
