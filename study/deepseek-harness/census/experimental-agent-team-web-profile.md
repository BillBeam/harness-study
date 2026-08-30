---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/experimental/agent-team-web-profile
---

# packages/experimental/agent-team-web-profile

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、12 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/experimental/agent-team-web-profile/README.md

包 README，说明这个私有 Web 层的安装顺序以及它给浏览器界面带来什么。

- 无运行期机制

### packages/experimental/agent-team-web-profile/cordis.patch.yml

该包在 `dsh.bundle.patch` 中声明的补丁文档，是这个包唯一的运行期内容，叠加在 `dsh-web-app` 与宿主侧 Team 层之后。

- 插入 `ui-agent-team` 行装载 `@deepseek-ai/dsh-experimental-client-ui-agent-team`，把 Team 的浏览器界面加入组合（[packages/experimental/agent-team-web-profile/cordis.patch.yml:4-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-web-profile/cordis.patch.yml#L4-L6)）

### packages/experimental/agent-team-web-profile/package.json

包清单，声明这个 Web bundle 的入口、发布内容与它所声明的补丁文档位置。

- `private: true` 把该包排除在发布产物之外（[packages/experimental/agent-team-web-profile/package.json:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-web-profile/package.json#L5)）
- `exports` 把 `.`、`./invariant`、`./cordis.patch.yml`、`./src/*` 与 `./package.json` 映射到具体路径，使补丁文档可被直接按子路径读取（[packages/experimental/agent-team-web-profile/package.json:14-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-web-profile/package.json#L14-L26)）
- `files` 把补丁文档与两个入口产物纳入分发内容（[packages/experimental/agent-team-web-profile/package.json:27-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-web-profile/package.json#L27-L32)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，把该文件登记为这个 bundle 被应用的补丁（[packages/experimental/agent-team-web-profile/package.json:34-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-web-profile/package.json#L34-L38)）
- `dependencies` 直接依赖被补丁插入的浏览器 UI 包，使插入行可被解析（[packages/experimental/agent-team-web-profile/package.json:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-web-profile/package.json#L39-L41)）

### packages/experimental/agent-team-web-profile/src/index.ts

包的主入口模块，不导出任何运行期 API。

- 无运行期机制

### packages/experimental/agent-team-web-profile/src/invariant.ts

包自带的不变量 companion，对应 `./invariant` 导出条目。

- 声明 companion 插件名与所需的 invariants 服务（[packages/experimental/agent-team-web-profile/src/invariant.ts:8-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-web-profile/src/invariant.ts#L8-L11)）
- 安装器为空实现，并以注释说明该包只带静态补丁、其激活条件由 Remote 装配与 Team UI 自己拥有（[packages/experimental/agent-team-web-profile/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-web-profile/src/invariant.ts#L13-L15)）
- `apply` 用包名把空安装器注册进 invariants 注册表并返回其 disposer（[packages/experimental/agent-team-web-profile/src/invariant.ts:22-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/agent-team-web-profile/src/invariant.ts#L22-L23)）

### packages/experimental/agent-team-web-profile/tsconfig.json

包的 TypeScript 编译配置，设定 rootDir/outDir 并引用 cordis 与 invariants。

- 无运行期机制
