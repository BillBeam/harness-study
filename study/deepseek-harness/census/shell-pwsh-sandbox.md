---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/pwsh-sandbox
---

# packages/shell/pwsh-sandbox

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、32 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/pwsh-sandbox/README.md

这个包的说明文档，描述受限 PowerShell 执行器的模式表、配置样例、拒绝与失败语义。

- 无运行期机制

### packages/shell/pwsh-sandbox/package.json

这个包的清单，声明入口映射与发布内容，被 Node 解析和打包时读取。

- `exports` 把包名映射到 `lib/index.js`，另外开放 `./invariant`、`./src/*` 和 `./package.json` 三个子路径（[packages/shell/pwsh-sandbox/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/package.json#L16-L27)）
- `files` 限定发布物只包含 `lib/index.js`、`lib/invariant.js` 和 `lib/types` 下的声明文件（[packages/shell/pwsh-sandbox/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/package.json#L28-L32)）

### packages/shell/pwsh-sandbox/src/helpers.ts

沙箱结果分类的内部工具模块，被同包执行器在前台结果和后台进程结算时调用。

- 只有 `EACCES` 和 `ENOENT` 两个 spawn 错误码被视为可执行文件解析或权限失败的证据（[packages/shell/pwsh-sandbox/src/helpers.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L15)）
- `isUsableWorkdir` 用 `statSync` 判目录、`accessSync` 查 `X_OK`，任何异常都返回 false（[packages/shell/pwsh-sandbox/src/helpers.ts:18-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L18-L26)）
- `isRunnerSpawnFailure` 在 runner 程序未知或 workdir 不可用时直接返回 false（[packages/shell/pwsh-sandbox/src/helpers.ts:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L47)）
- 错误对象必须是对象、`code` 属于允许集合、`syscall` 是字符串，否则不归因于 runner（[packages/shell/pwsh-sandbox/src/helpers.ts:48-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L48-L51)）
- 无 `path` 时要求 `syscall` 精确等于 `spawn <runner>`；有 `path` 时要求它逐字等于 runner 程序，且 `syscall` 为 `spawn` 或精确形式（[packages/shell/pwsh-sandbox/src/helpers.ts:52-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L52-L55)）
- `classifyDenial` 把前台结果的退出码与 stderr 文本交给签名匹配，得出是否被拒（[packages/shell/pwsh-sandbox/src/helpers.ts:70-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L70-L72)）
- `classifyRunnerFailure` 先排除退出码为 null 或 0 的情形（[packages/shell/pwsh-sandbox/src/helpers.ts:89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L89)）
- 每条规则先按 `allowedExitCodes` 过滤退出码，再把 `informationalLines` 转成小写集合逐行排除（[packages/shell/pwsh-sandbox/src/helpers.ts:91-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L91-L101)）
- 空白的致命签名被丢弃，其余签名小写后逐行子串匹配，返回第一条命中的原始行（[packages/shell/pwsh-sandbox/src/helpers.ts:96-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L96-L102)）
- `matchesSignature` 只在非零退出时做大小写不敏感的 stderr 子串匹配（[packages/shell/pwsh-sandbox/src/helpers.ts:115-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/helpers.ts#L115-L119)）

### packages/shell/pwsh-sandbox/src/index.ts

包入口，定义受沙箱约束的 PowerShell 执行器类，作为 `ctx.shell` 的实现被组合装载。

- `inject` 声明 `subprocess`、`sandbox`、`sandboxPolicy` 三个服务，缺一则插件不加载（[packages/shell/pwsh-sandbox/src/index.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L53)）
- 每个后台进程句柄对应一份保留到结算的沙箱事实（模式、强制程度、拒绝签名、runner 失败规则、runner 程序、工作目录）（[packages/shell/pwsh-sandbox/src/index.ts:66-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L66-L73)）
- 构造时从 `ctx.sandboxPolicy.defaultMode` 取默认模式（[packages/shell/pwsh-sandbox/src/index.ts:79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L79)）
- `sandboxMode` getter 覆写基类返回该默认模式，工具层据此决定是否公开升级字段（[packages/shell/pwsh-sandbox/src/index.ts:83-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L83-L85)）
- `resolve` 在父类结果上补一条 `sandboxPolicy`：优先用请求带来的，否则调用 `ctx.sandboxPolicy.resolve()`（[packages/shell/pwsh-sandbox/src/index.ts:92-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L92-L94)）
- `run` 在 `danger-full-access` 模式下不经过沙箱提供者，直接跑父类并打上 `denied: false`（[packages/shell/pwsh-sandbox/src/index.ts:99-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L99-L102)）
- 受限模式下把 spec 交给 `confine` 包装，再用返回的 argv 走父类的 `runArgv`（[packages/shell/pwsh-sandbox/src/index.ts:103-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L103-L106)）
- spawn 抛错时：先检查调用方 signal 已中止则抛中止错误；再判定为 runner 启动失败则抛 `SandboxUnavailableError`；否则原样上抛（[packages/shell/pwsh-sandbox/src/index.ts:107-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L107-L114)）
- 结算后先判 runner 失败，命中就抛出携带那条致命 stderr 行的 `SandboxUnavailableError`（[packages/shell/pwsh-sandbox/src/index.ts:117-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L117-L120)）
- 正常返回的结果附带 `sandbox`：模式、由签名分类得出的 `denied`、以及提供者报告的 `enforcement`（[packages/shell/pwsh-sandbox/src/index.ts:121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L121)）
- `start` 在 `danger-full-access` 下直接返回父类句柄，不记录任何沙箱事实（[packages/shell/pwsh-sandbox/src/index.ts:125-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L125-L127)）
- 后台启动同步抛错且归因于 runner 时抛 `SandboxUnavailableError`，其余错误原样上抛（[packages/shell/pwsh-sandbox/src/index.ts:131-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L131-L139)）
- 启动成功后立即把该句柄的沙箱事实存进 map（[packages/shell/pwsh-sandbox/src/index.ts:140-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L140-L148)）
- `onProcessDone` 取出并删除该句柄事实：spawn 被拒时按 runner 归因判定，否则按 runner 失败规则判定（[packages/shell/pwsh-sandbox/src/index.ts:156-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L156-L164)）
- 在句柄上写入 `sandbox` 字段：runner 失败时不判拒绝，`runnerFailed` 仅在为真时出现，然后再调用父类钩子（[packages/shell/pwsh-sandbox/src/index.ts:165-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L165-L172)）
- `confine` 把父类算出的完整 pwsh argv 交给 `ctx.sandbox.confine` 换取受限 argv（[packages/shell/pwsh-sandbox/src/index.ts:183-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/index.ts#L183-L185)）

### packages/shell/pwsh-sandbox/src/invariant.ts

这个包的不变量伴随插件，由不变量服务在装载时调用。

- `inject` 要求 `invariants` 服务先就位，插件才会应用（[packages/shell/pwsh-sandbox/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/invariant.ts#L15)）
- `apply` 以包名向 `ctx.invariants` 注册一个空安装器，并返回其卸载器（[packages/shell/pwsh-sandbox/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/pwsh-sandbox/src/invariant.ts#L28-L29)）

### packages/shell/pwsh-sandbox/tsconfig.json

这个包的 TypeScript 编译配置，声明源码根、输出目录与工程引用。

- 无运行期机制
