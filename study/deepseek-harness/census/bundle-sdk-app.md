---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/bundle/sdk-app
---

# packages/bundle/sdk-app

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、21 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/bundle/sdk-app/README.md

该 bundle 的英文说明文档，介绍 SDK profile 如何叠在 dsh-base 之上、stdout 专属于 JSON-RPC 帧，以及 `profile` 配置项与 `DSH_MAX_TOKENS_AS_SUCCESS` 的含义。

- 无运行期机制

### packages/bundle/sdk-app/cordis.patch.yml

该 bundle 的补丁文档，由 profile 组合器叠在 dsh-base 之上，改写两行既有行并插入两行新行。

- 把 `system-prompt` 行的 persona 改写为带 `{{model}}` 与 `{{cwd}}` 占位的编码代理人设（[packages/bundle/sdk-app/cordis.patch.yml:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/cordis.patch.yml#L3-L6)）
- 把 `session-title-llm` 行置为 `disabled: true`，该 profile 不再发起生成标题的辅助模型请求（[packages/bundle/sdk-app/cordis.patch.yml:8-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/cordis.patch.yml#L8-L9)）
- 插入 `sdk-app-startup` 行并配 `profile: sdk`，决定命令帮助里渲染的 profile 名（[packages/bundle/sdk-app/cordis.patch.yml:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/cordis.patch.yml#L12-L15)）
- 插入 `sdk-jsonrpc-server` 行并声明 `inject: [sdkAppStartup, loader]`，使服务端只在启动提供者接受调用且 Loader 可用后才激活（[packages/bundle/sdk-app/cordis.patch.yml:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/cordis.patch.yml#L17-L19)）
- `maxTokensAsSuccess` 由 `DSH_MAX_TOKENS_AS_SUCCESS` 求值：未设置时为 true，否则按 JSON 解析该环境变量（[packages/bundle/sdk-app/cordis.patch.yml:20-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/cordis.patch.yml#L20-L21)）

### packages/bundle/sdk-app/package.json

该 bundle 的 npm 清单，声明入口、可解析子路径与补丁文件位置。

- 声明 `"type": "module"` 并把入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/bundle/sdk-app/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/package.json#L13-L15)）
- `exports` 开放根入口、`./invariant`、`./cordis.patch.yml`、`./src/*` 与 `./package.json`（[packages/bundle/sdk-app/package.json:16-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/package.json#L16-L28)）
- `files` 把发布产物限定为两个 js、补丁文件与类型声明（[packages/bundle/sdk-app/package.json:29-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/package.json#L29-L34)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，profile 组合器据此字段找到该 bundle 的补丁层（[packages/bundle/sdk-app/package.json:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/package.json#L36-L40)）

### packages/bundle/sdk-app/src/index.ts

SDK profile 的命令行与 stdin 生命期提供者插件，解析成功后发布 `sdkAppStartup` 服务供 JSON-RPC 服务端行等待；`sdk-minimal` bundle 复用同一提供者并传入自己的 profile 名。

- `inject = ['cmdlineArgs']` 使该插件必须等到启动器提供命令行后才激活（[packages/bundle/sdk-app/src/index.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/index.ts#L17)）
- 导出服务名常量 `sdkAppStartup`，作为服务端行等待的那个服务标识（[packages/bundle/sdk-app/src/index.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/index.ts#L20)）
- `Config` schema 校验 `profile` 字段并给出默认值 `'sdk'`（[packages/bundle/sdk-app/src/index.ts:29-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/index.ts#L29-L31)）
- `sdkCommand` 把 profile 名渲染进命令名与尾部示例，构造零选项 commander 程序（[packages/bundle/sdk-app/src/index.ts:38-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/index.ts#L38-L47)）
- `apply` 在 config 缺省时再兜一次 `'sdk'`（[packages/bundle/sdk-app/src/index.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/index.ts#L56)）
- action 先调 `exitOnStdinEnd(ctx, 'sdk-app.stdin')` 绑定 EOF 到启动器的有界退出，再发布 `{ accepted: true }`（[packages/bundle/sdk-app/src/index.ts:57-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/index.ts#L57-L60)）
- `parseCmdline(ctx, program)` 在插件挂载时立即对启动器参数解析，`--help` 或拒绝路径不会走到 action，也就不发布服务（[packages/bundle/sdk-app/src/index.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/index.ts#L61)）

### packages/bundle/sdk-app/src/invariant.ts

该包的不变量伴生插件，注册到 `invariants` 服务上但不安装任何检查。

- `inject = ['invariants']` 把该伴生插件的激活时机拴在 `invariants` 服务可用之后（[packages/bundle/sdk-app/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/invariant.ts#L14)）
- 安装器体为空，运行期不做任何检查（[packages/bundle/sdk-app/src/invariant.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/invariant.ts#L20)）
- `apply` 以包名注册该安装器并返回注册的处置器（[packages/bundle/sdk-app/src/invariant.ts:27-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-app/src/invariant.ts#L27-L28)）

### packages/bundle/sdk-app/tsconfig.json

该包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 并引用 vendor、schemastery、不变量与 cmdline 工程。

- 无运行期机制
