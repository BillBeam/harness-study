---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/bash-sandbox
---

# packages/shell/bash-sandbox

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、32 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/bash-sandbox/README.md

这个包的说明文档，描述受限 bash 执行器的模式表、配置样例、拒绝与失败语义，供选型和排障的人阅读。

- 无运行期机制

### packages/shell/bash-sandbox/package.json

这个包的清单，声明入口映射与发布内容，被 Node 解析和打包时读取。

- `exports` 把包名映射到 `lib/index.js`，另外开放 `./invariant`、`./src/*` 和 `./package.json` 三个子路径（[packages/shell/bash-sandbox/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/package.json#L16-L27)）
- `files` 限定发布物只包含 `lib/index.js`、`lib/invariant.js` 和 `lib/types` 下的声明文件（[packages/shell/bash-sandbox/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/package.json#L28-L32)）

### packages/shell/bash-sandbox/src/helpers.ts

沙箱结果分类的内部工具模块，被同包的执行器在前台结果和后台进程结算时调用。

- 只有 `EACCES` 和 `ENOENT` 两个 spawn 错误码被视为可执行文件解析或权限失败的证据（[packages/shell/bash-sandbox/src/helpers.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L12)）
- `isUsableWorkdir` 用 `statSync` 判目录、`accessSync` 查 `X_OK`，任何异常都返回 false（[packages/shell/bash-sandbox/src/helpers.ts:15-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L15-L23)）
- `isRunnerSpawnFailure` 在 runner 程序未知或 workdir 不可用时直接返回 false（[packages/shell/bash-sandbox/src/helpers.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L44)）
- 错误对象必须是对象、`code` 属于允许集合、`syscall` 是字符串，否则不归因于 runner（[packages/shell/bash-sandbox/src/helpers.ts:45-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L45-L48)）
- 无 `path` 时要求 `syscall` 精确等于 `spawn <runner>`；有 `path` 时要求它逐字等于 runner 程序，且 `syscall` 为 `spawn` 或精确形式（[packages/shell/bash-sandbox/src/helpers.ts:49-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L49-L52)）
- `classifyDenial` 把前台结果的退出码与 stderr 文本交给签名匹配，得出是否被拒（[packages/shell/bash-sandbox/src/helpers.ts:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L67-L69)）
- `classifyRunnerFailure` 先排除退出码为 null 或 0 的情形（[packages/shell/bash-sandbox/src/helpers.ts:86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L86)）
- 每条规则先按 `allowedExitCodes` 过滤退出码，再把 `informationalLines` 转成小写集合逐行排除（[packages/shell/bash-sandbox/src/helpers.ts:88-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L88-L98)）
- 空白的致命签名被丢弃，其余签名小写后逐行子串匹配，返回第一条命中的原始行（[packages/shell/bash-sandbox/src/helpers.ts:93-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L93-L99)）
- `matchesSignature` 只在非零退出时做大小写不敏感的 stderr 子串匹配（[packages/shell/bash-sandbox/src/helpers.ts:112-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/helpers.ts#L112-L116)）

### packages/shell/bash-sandbox/src/index.ts

包入口，定义受沙箱约束的 bash 执行器类，作为 `ctx.shell` 的实现被组合装载。

- `inject` 声明 `subprocess`、`sandbox`、`sandboxPolicy` 三个服务，缺一则插件不加载（[packages/shell/bash-sandbox/src/index.ts:45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L45)）
- 每个后台进程句柄对应一份保留到结算的沙箱事实（模式、强制程度、拒绝签名、runner 失败规则、runner 程序、工作目录）（[packages/shell/bash-sandbox/src/index.ts:58-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L58-L65)）
- 构造时从 `ctx.sandboxPolicy.defaultMode` 取默认模式（[packages/shell/bash-sandbox/src/index.ts:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L71)）
- `sandboxMode` getter 覆写基类返回该默认模式，工具层据此决定是否公开升级字段（[packages/shell/bash-sandbox/src/index.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L75-L77)）
- `resolve` 在父类结果上补一条 `sandboxPolicy`：优先用请求带来的，否则调用 `ctx.sandboxPolicy.resolve()`（[packages/shell/bash-sandbox/src/index.ts:84-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L84-L86)）
- `run` 在 `danger-full-access` 模式下不经过沙箱提供者，直接跑父类并打上 `denied: false`（[packages/shell/bash-sandbox/src/index.ts:91-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L91-L94)）
- 受限模式下把命令交给 `confine` 包装，再用返回的 argv 走父类的 `runArgv`（[packages/shell/bash-sandbox/src/index.ts:95-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L95-L98)）
- spawn 抛错时：先检查调用方 signal 已中止则抛中止错误；再判定为 runner 启动失败则抛 `SandboxUnavailableError`；否则原样上抛（[packages/shell/bash-sandbox/src/index.ts:99-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L99-L106)）
- 结算后先判 runner 失败，命中就抛出携带那条致命 stderr 行的 `SandboxUnavailableError`（[packages/shell/bash-sandbox/src/index.ts:109-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L109-L112)）
- 正常返回的结果附带 `sandbox`：模式、由签名分类得出的 `denied`、以及提供者报告的 `enforcement`（[packages/shell/bash-sandbox/src/index.ts:113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L113)）
- `start` 在 `danger-full-access` 下直接返回父类句柄，不记录任何沙箱事实（[packages/shell/bash-sandbox/src/index.ts:117-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L117-L119)）
- 后台启动同步抛错且归因于 runner 时抛 `SandboxUnavailableError`，其余错误原样上抛（[packages/shell/bash-sandbox/src/index.ts:126-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L126-L133)）
- 启动成功后立即把该句柄的沙箱事实存进 map（[packages/shell/bash-sandbox/src/index.ts:134-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L134-L143)）
- `onProcessDone` 取出并删除该句柄事实：spawn 被拒时按 runner 归因判定，否则按 runner 失败规则判定（[packages/shell/bash-sandbox/src/index.ts:150-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L150-L158)）
- 在句柄上写入 `sandbox` 字段：runner 失败时不判拒绝，`runnerFailed` 仅在为真时出现，然后再调用父类钩子（[packages/shell/bash-sandbox/src/index.ts:159-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L159-L166)）
- `confine` 把 `['bash', '-c', command]` 这个精确 argv 交给 `ctx.sandbox.confine` 换取受限 argv（[packages/shell/bash-sandbox/src/index.ts:177-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/index.ts#L177-L179)）

### packages/shell/bash-sandbox/src/invariant.ts

这个包的不变量伴随插件，由不变量服务在装载时调用。

- `inject` 要求 `invariants` 服务先就位，插件才会应用（[packages/shell/bash-sandbox/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/invariant.ts#L15)）
- `apply` 以包名向 `ctx.invariants` 注册一个空安装器，并返回其卸载器（[packages/shell/bash-sandbox/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/bash-sandbox/src/invariant.ts#L28-L29)）

### packages/shell/bash-sandbox/tsconfig.json

这个包的 TypeScript 编译配置，声明源码根、输出目录与工程引用。

- 无运行期机制
