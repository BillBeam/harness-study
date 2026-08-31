---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/e2b/e2b
---

# packages/e2b/e2b

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、27 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/e2b/e2b/README.md

本包的英文说明文档，介绍共享远程沙箱的配置字段、生命周期与启动/关闭行为。

- 无运行期机制

### packages/e2b/e2b/package.json

本包的 npm 清单，声明模块类型、入口、导出子路径与运行期依赖。

- 声明 `"type": "module"`，包内文件按 ESM 加载（[packages/e2b/e2b/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/package.json#L13)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/e2b/e2b/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/package.json#L14-L15)）
- `exports` 把 `.` 解析到构建产物、`./invariant` 解析到伴生模块，并额外暴露 `./src/*` 与 `./package.json`（[packages/e2b/e2b/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/package.json#L16-L27)）
- `files` 限定发布内容为两个 js 产物与类型声明（[packages/e2b/e2b/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/package.json#L28-L32)）
- `dependencies` 把 `e2b` SDK 钉在精确版本 `2.29.1`，运行期实际加载该版本（[packages/e2b/e2b/package.json:38-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/package.json#L38-L41)）

### packages/e2b/e2b/src/index.ts

共享 E2B 沙箱的持有者插件：创建一个沙箱句柄供文件与进程适配器共用，并在超时或拆卸时删除沙箱。

- `quoteE2BShellArg` 用单引号包裹并把内部单引号替换为 `'"'"'`，使参数在 SDK 的 `/bin/bash -l -c` 层里成为不发生插值的单个词（[packages/e2b/e2b/src/index.ts:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L27-L29)）
- `e2bControlEnvs` 在调用方给的环境项之上覆盖一个随机 UUID 组成的 `HOME`，使内部命令的登录 shell 落在全新家目录（[packages/e2b/e2b/src/index.ts:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L36-L40)）
- `Context` 声明合并挂上 `e2b` 服务，使适配器可通过 `ctx.e2b` 取到该持有者（[packages/e2b/e2b/src/index.ts:63-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L63-L67)）
- `static Config` 用 Schemastery 声明 apiKey、cwd（默认 `/home/user/workspace`）、timeoutMs（默认 300000）（[packages/e2b/e2b/src/index.ts:75-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L75-L79)）
- 构造时 apiKey 缺省回落到 `process.env.E2B_API_KEY`，缺省为空串（[packages/e2b/e2b/src/index.ts:94-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L94-L99)）
- 构造时立即 `validate()`，配置不合法则插件构造直接抛错（[packages/e2b/e2b/src/index.ts:100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L100)）
- `runtimeRoot` 固定为 `cwd` 下的 `.dsh-e2b` 目录，供适配器存放进程与终端状态（[packages/e2b/e2b/src/index.ts:101-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L101-L102)）
- 构造即启动 `open()` 并把返回的 Promise 存为 `ready`，同时挂一个空 catch 让预先失败的连接保持被观察（[packages/e2b/e2b/src/index.ts:103-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L103-L106)）
- `ctx.effect` 注册拆卸函数：置 disposed、等待 `ready`，创建本就失败时直接返回，否则调用 `sandbox.kill()`，并把 `SandboxNotFoundError` 当作已静止吞掉、其余错误上抛（[packages/e2b/e2b/src/index.ts:108-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L108-L122)）
- `getSandbox` 在 await 之前与之后各查一次 disposed，两处都会抛"服务正在拆卸"（[packages/e2b/e2b/src/index.ts:130-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L130-L137)）
- `validate` 分别拒绝空 apiKey、非绝对 POSIX 路径的 cwd、非正数或非有限的 timeoutMs（[packages/e2b/e2b/src/index.ts:139-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L139-L149)）
- `open` 以 `secure: true` 与 `lifecycle: { onTimeout: 'kill' }` 创建沙箱，并带上 apiKey 与 timeoutMs（[packages/e2b/e2b/src/index.ts:152-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L152-L157)）
- 创建后建出 `cwd` 与 runtimeRoot，并要求 runtimeRoot 的类型为目录且不是符号链接，否则抛错（[packages/e2b/e2b/src/index.ts:159-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L159-L164)）
- 对 runtimeRoot 执行 `chmod 700`，命令参数经引用函数处理并使用隔离的控制环境（[packages/e2b/e2b/src/index.ts:165-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L165-L168)）
- 目录准备阶段任何失败都先尝试一次 `sandbox.kill()` 回滚（回滚失败被吞），再把原始错误上抛（[packages/e2b/e2b/src/index.ts:170-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L170-L178)）
- 默认导出该服务类，供 Loader 按插件形态装载（[packages/e2b/e2b/src/index.ts:182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/index.ts#L182)）

### packages/e2b/e2b/src/invariant.ts

本包的不变量伴生插件模块，由 `./invariant` 子路径导出，被不变量服务在装载时使用。

- 导出 Cordis 插件名 `e2b-invariant`（[packages/e2b/e2b/src/invariant.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/invariant.ts#L13)）
- 声明 `inject = ['invariants']`，插件在该服务就绪前不会激活（[packages/e2b/e2b/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/invariant.ts#L15)）
- 安装函数为空体，因此本包注册后不装任何运行期检查（[packages/e2b/e2b/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册并返回注册的 disposer（[packages/e2b/e2b/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/e2b/src/invariant.ts#L28-L29)）

### packages/e2b/e2b/tsconfig.json

本包的 TypeScript 编译配置，声明源码根、类型输出目录与工作区项目引用。

- 无运行期机制
