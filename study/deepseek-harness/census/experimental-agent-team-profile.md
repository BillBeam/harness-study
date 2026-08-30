---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/experimental/agent-team-profile
---

# packages/experimental/agent-team-profile

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、16 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/experimental/agent-team-profile/README.md

包 README，说明这个私有 profile 层如何装进已初始化的 profile，以及它对 base 组合做了哪些替换。

- 无运行期机制

### packages/experimental/agent-team-profile/cordis.patch.yml

该包在 `dsh.bundle.patch` 中声明的补丁文档，是这个包唯一的运行期内容，叠加在 `dsh-base` 之后。

- 禁用 `tool-subagent-control`、`tool-subagent-list-agents`、`tool-subagent-report` 三行，使这些全局工具不再注册（[packages/experimental/agent-team-profile/cordis.patch.yml:5-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/cordis.patch.yml#L5-L12)）
- 把 `tool-subagent` 行改成 provider `spawn`、工具名 `subagent`、`backgroundMode: one-shot`（[packages/experimental/agent-team-profile/cordis.patch.yml:14-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/cordis.patch.yml#L14-L18)）
- 把 `tool-subagent-fork` 行改成 provider `fork`、工具名 `subagent_fork`、`backgroundMode: one-shot`（[packages/experimental/agent-team-profile/cordis.patch.yml:20-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/cordis.patch.yml#L20-L24)）
- 插入 `agent-team` 行装载 Team 服务，并给出 maxMembers 8、maxTasks 256、maxPendingMessagesPerMember 64、maxMessageBytes 65536、disposalTimeoutMs 5000 五项限值（[packages/experimental/agent-team-profile/cordis.patch.yml:26-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/cordis.patch.yml#L26-L34)）
- 插入 `tool-agent-team` 行装载 Team 工具包，并指定 `freshProvider: spawn` 与 `forkProvider: fork`（[packages/experimental/agent-team-profile/cordis.patch.yml:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/cordis.patch.yml#L36-L40)）

### packages/experimental/agent-team-profile/package.json

包清单，声明这个 bundle 的入口、发布内容与它所声明的补丁文档位置。

- `private: true` 把该包排除在发布产物之外（[packages/experimental/agent-team-profile/package.json:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/package.json#L5)）
- `exports` 把 `.`、`./invariant`、`./cordis.patch.yml`、`./src/*` 与 `./package.json` 映射到具体路径，使补丁文档可被直接按子路径读取（[packages/experimental/agent-team-profile/package.json:14-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/package.json#L14-L26)）
- `files` 把补丁文档与两个入口产物纳入分发内容（[packages/experimental/agent-team-profile/package.json:27-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/package.json#L27-L32)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，把该文件登记为这个 bundle 被应用的补丁（[packages/experimental/agent-team-profile/package.json:34-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/package.json#L34-L38)）
- `dependencies` 直接依赖 Team 服务包与 Team 工具包，使补丁插入的两行可被解析（[packages/experimental/agent-team-profile/package.json:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/package.json#L39-L42)）

### packages/experimental/agent-team-profile/src/index.ts

包的主入口模块，只声明该包的运行期内容是它的补丁文档。

- 无运行期机制

### packages/experimental/agent-team-profile/src/invariant.ts

包自带的不变量 companion，对应 `./invariant` 导出条目。

- 声明 companion 插件名与所需的 invariants 服务（[packages/experimental/agent-team-profile/src/invariant.ts:11-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/src/invariant.ts#L11-L14)）
- 安装器为空实现，并以注释说明该包只带静态补丁、没有可检查的运行期关系（[packages/experimental/agent-team-profile/src/invariant.ts:16-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/src/invariant.ts#L16-L18)）
- `apply` 用包名把空安装器注册进 invariants 注册表并返回其 disposer（[packages/experimental/agent-team-profile/src/invariant.ts:25-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-profile/src/invariant.ts#L25-L26)）

### packages/experimental/agent-team-profile/tsconfig.json

包的 TypeScript 编译配置，设定 rootDir/outDir 并引用 cordis、invariants 与两个 Team 包。

- 无运行期机制
