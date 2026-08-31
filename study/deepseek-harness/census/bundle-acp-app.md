---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/bundle/acp-app
---

# packages/bundle/acp-app

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、19 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/bundle/acp-app/README.md

该 bundle 的英文说明文档，介绍 ACP profile 如何叠在 dsh-base 之上、stdout 归协议帧所有，以及 `--help` 不占用 stdio 的行为。

- 无运行期机制

### packages/bundle/acp-app/cordis.patch.yml

该 bundle 的补丁文档，由 profile 组合器叠在 dsh-base 之上，改写两行既有行并插入两行新行。

- 把 `system-prompt` 行的 persona 改写为带 `{{model}}` 与 `{{cwd}}` 占位的编码代理人设（[packages/bundle/acp-app/cordis.patch.yml:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/cordis.patch.yml#L3-L6)）
- 把 `session-title-llm` 行置为 `disabled: true`，该 profile 不再发起生成标题的辅助模型请求（[packages/bundle/acp-app/cordis.patch.yml:8-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/cordis.patch.yml#L8-L9)）
- 插入 `acp-app-startup` 行，挂载本包的命令行提供者（[packages/bundle/acp-app/cordis.patch.yml:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/cordis.patch.yml#L11-L13)）
- 插入 `acp` 行并声明 `inject: [acpAppStartup]`，使 ACP 桥接只在启动提供者接受调用后才激活（[packages/bundle/acp-app/cordis.patch.yml:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/cordis.patch.yml#L15-L17)）
- 给 `acp` 行配置 `provider: deepseek-official` 与 `model: deepseek-v4-flash` 作为建会话的路由（[packages/bundle/acp-app/cordis.patch.yml:18-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/cordis.patch.yml#L18-L20)）

### packages/bundle/acp-app/package.json

该 bundle 的 npm 清单，声明入口、可解析子路径与补丁文件位置。

- 声明 `"type": "module"` 并把入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/bundle/acp-app/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/package.json#L13-L15)）
- `exports` 开放根入口、`./invariant`、`./cordis.patch.yml`、`./src/*` 与 `./package.json`（[packages/bundle/acp-app/package.json:16-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/package.json#L16-L28)）
- `files` 把发布产物限定为两个 js、补丁文件与类型声明（[packages/bundle/acp-app/package.json:29-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/package.json#L29-L34)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，profile 组合器据此字段找到该 bundle 的补丁层（[packages/bundle/acp-app/package.json:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/package.json#L36-L40)）

### packages/bundle/acp-app/src/index.ts

ACP profile 的命令行与 stdin 生命期提供者插件，解析成功后发布 `acpAppStartup` 服务供 ACP 桥接行等待。

- `inject = ['cmdlineArgs']` 使该插件必须等到启动器提供命令行后才激活（[packages/bundle/acp-app/src/index.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/src/index.ts#L16)）
- 导出服务名常量 `acpAppStartup`，作为桥接行等待的那个服务标识（[packages/bundle/acp-app/src/index.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/src/index.ts#L19)）
- `acpCommand` 构造零选项 commander 程序，设定命令名 `dsh --profile acp`、描述、`-h, --help` 与尾部示例文本（[packages/bundle/acp-app/src/index.ts:25-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/src/index.ts#L25-L34)）
- action 先调 `exitOnStdinEnd(ctx, 'acp-app.stdin')` 绑定 EOF 到启动器的有界退出，再发布 `{ accepted: true }`（[packages/bundle/acp-app/src/index.ts:43-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/src/index.ts#L43-L46)）
- `parseCmdline(ctx, program)` 在插件挂载时立即对启动器参数解析，`--help` 或拒绝路径不会走到 action，也就不发布服务（[packages/bundle/acp-app/src/index.ts:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/src/index.ts#L47)）

### packages/bundle/acp-app/src/invariant.ts

该包的不变量伴生插件，注册到 `invariants` 服务上但不安装任何检查。

- `inject = ['invariants']` 把该伴生插件的激活时机拴在 `invariants` 服务可用之后（[packages/bundle/acp-app/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/src/invariant.ts#L14)）
- 安装器体为空，运行期不做任何检查（[packages/bundle/acp-app/src/invariant.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/src/invariant.ts#L20)）
- `apply` 以包名注册该安装器并返回注册的处置器（[packages/bundle/acp-app/src/invariant.ts:27-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/acp-app/src/invariant.ts#L27-L28)）

### packages/bundle/acp-app/tsconfig.json

该包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 并引用 vendor、不变量与 cmdline 工程。

- 无运行期机制
