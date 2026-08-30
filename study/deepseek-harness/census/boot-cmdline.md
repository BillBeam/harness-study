---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/boot/cmdline
---

# packages/boot/cmdline

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、22 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/boot/cmdline/README.md

该包的英文说明文档，介绍启动器如何把自身标志之后的参数原样交给应用，以及 `provideCmdline` / `parseCmdline` / `exitOnStdinEnd` 的用法。

- 无运行期机制

### packages/boot/cmdline/package.json

该包的 npm 清单，声明模块类型、入口与可被外部解析的子路径。

- 声明 `"type": "module"` 并把默认入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/boot/cmdline/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant` 伴生入口、`./src/*` 源码路径与 `./package.json`，其余路径不可解析（[packages/boot/cmdline/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/boot/cmdline/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/package.json#L28-L32)）

### packages/boot/cmdline/src/index.ts

该包的主模块，供启动器在挂树前提供命令行、退出与就绪三个宿主值，并供任意应用插件用自带的 commander 程序解析这些参数。

- `provideCmdline` 先把宿主参数复制并 `Object.freeze`，再以返回同一快照的 `get()` 提供 `cmdlineArgs` 服务（[packages/boot/cmdline/src/index.ts:85-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L85-L86)）
- `provideCmdline` 提供 `appExit`，并仅在宿主给出 `ready` 时才提供 `appReady`（[packages/boot/cmdline/src/index.ts:87-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L87-L88)）
- `internals` 把 stdin/stdout/stderr 收成一个可替换的对象，默认指向 `process` 的三个流（[packages/boot/cmdline/src/index.ts:102-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L102-L110)）
- `exitOnStdinEnd` 在 `appExit` 或 `appReady` 缺失时抛错（[packages/boot/cmdline/src/index.ts:124-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L124-L128)）
- stdin EOF 只登记一次，并把 `exit(0)` 推迟到 `ready.onReady` 回调里执行（[packages/boot/cmdline/src/index.ts:133-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L133-L137)）
- 以 `ctx.effect` 注册的处置器把 `active` 置假、取消挂起的就绪监听并摘掉 stdin 的 `end` 监听（[packages/boot/cmdline/src/index.ts:138-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L138-L142)）
- 用 `stdin.once('end', onEnd)` 订阅 EOF，并在 `readableEnded` 已为真时用 `queueMicrotask` 补触发一次（[packages/boot/cmdline/src/index.ts:143-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L143-L144)）
- `parseCmdline` 走 `ctx.get` 读全局服务存储取 `cmdlineArgs` 与 `appExit`，缺一即抛出带程序名的错误（[packages/boot/cmdline/src/index.ts:168-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L168-L172)）
- 程序树中没有任何命令声明 action 时直接抛错，不进入解析（[packages/boot/cmdline/src/index.ts:173-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L173-L175)）
- 解析前先对整棵命令树改写退出与输出通道，再以 `{ from: 'user' }` 解析冻结的参数快照（[packages/boot/cmdline/src/index.ts:176-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L176-L178)）
- 捕获到的非 commander 错误原样重抛，commander 错误则以其 `exitCode` 调用 `exit`（[packages/boot/cmdline/src/index.ts:179-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L179-L185)）
- `hasAction` 结构化读取 `_actionHandler` 并递归所有子命令判断是否存在 action（[packages/boot/cmdline/src/index.ts:199-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L199-L202)）
- `configureExitAndOutput` 对根命令及每个子命令递归设置 `exitOverride()` 并把 `writeOut`/`writeErr` 接到 `internals` 的两个流上（[packages/boot/cmdline/src/index.ts:213-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L213-L221)）
- `isCommanderError` 用 `code` 以 `commander.` 开头且 `exitCode` 为数字来判定，不用 `instanceof`（[packages/boot/cmdline/src/index.ts:234-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/index.ts#L234-L239)）

### packages/boot/cmdline/src/invariant.ts

该包的不变量伴生插件，注册到 `invariants` 服务上但不安装任何检查。

- `inject = ['invariants']` 把该伴生插件的激活时机拴在 `invariants` 服务可用之后（[packages/boot/cmdline/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/invariant.ts#L14)）
- 安装器体为空，运行期不做任何检查（[packages/boot/cmdline/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/invariant.ts#L22)）
- `apply` 以包名注册该安装器并把注册返回的处置器包进 Promise 返回（[packages/boot/cmdline/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/cmdline/src/invariant.ts#L29-L30)）

### packages/boot/cmdline/tsconfig.json

该包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 并引用 vendor 与不变量工程。

- 无运行期机制
