---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/sandbox/sandbox-local
---

# packages/sandbox/sandbox-local

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、45 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/sandbox/sandbox-local/README.md

包参考文档，说明各平台运行器的选择顺序、配置字段、执行完整度上报与失败关闭行为。

- 无运行期机制

### packages/sandbox/sandbox-local/package.json

包清单，声明本地沙箱后端的入口、导出、发布内容与运行期依赖。

- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，并暴露 `./src/*` 与 `./package.json`（[packages/sandbox/sandbox-local/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/package.json#L16-L27)）
- `files` 把发布内容限制为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的声明文件（[packages/sandbox/sandbox-local/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/package.json#L28-L32)）
- `dependencies` 把 Windows ACL 运行器包与 landlock-run 原生插件列为直接依赖，使 `import.meta.resolve` 与探测在运行期能定位它们（[packages/sandbox/sandbox-local/package.json:41-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/package.json#L41-L45)）

### packages/sandbox/sandbox-local/src/index.ts

插件入口，实现 `ctx.sandbox` 的本地后端：按平台选运行器、功能性探测、逐次调用包裹 argv，并管理 Windows ACL 写授权的生命周期。

- `defaultProbeBwrap` 以 `read-only` 配置加 `true` 命令实际运行一次 `bwrap`，超时受限，退出码 0 才算可用（[packages/sandbox/sandbox-local/src/index.ts:68-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L68-L74)）
- `defaultProbeSeatbelt` 以真实 `read-only` SBPL 配置通过 `sandbox-exec -p` 运行 `true` 做探测（[packages/sandbox/sandbox-local/src/index.ts:85-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L85-L91)）
- `defaultProbeWindowsAcl` 以零授权的 read-only 模式围绕 `cmd /c exit 0` 运行受限令牌运行器做探测（[packages/sandbox/sandbox-local/src/index.ts:100-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L100-L112)）
- `SandboxInternals` 定义可替换平台、整条链、四个探测、Landlock 启动器路径、`sandbox-exec` 路径、windows-acl 运行器 argv/入口以及临时目录删除的注入钩子（[packages/sandbox/sandbox-local/src/index.ts:115-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L115-L138)）
- `PLATFORM_CHAINS` 把 linux 定为 `bwrap` 优先再 `landlock`、darwin 只有 `seatbelt`、win32 只有 `windows-acl`，其余平台没有链（[packages/sandbox/sandbox-local/src/index.ts:159-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L159-L166)）
- `STATIC_ENFORCEMENT` 规定无探测直选时各运行器上报的执行完整度，其中 `windows-acl` 固定为 `partial`（[packages/sandbox/sandbox-local/src/index.ts:177-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L177-L187)）
- `assertPositiveFinite` 拒绝非有限或非正的探测超时，避免 `spawnSync({ timeout: 0 })` 变成无超时（[packages/sandbox/sandbox-local/src/index.ts:194-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L194-L198)）
- `DENIAL_SIGNATURES` 为每个运行器与自定义运行器分别固定其拒绝时的 stderr 子串方言（[packages/sandbox/sandbox-local/src/index.ts:205-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L205-L213)）
- `RUNNER_FAILURE_RULES` 为各运行器给出致命签名，Landlock 以启动器包导出的 `LAUNCHER_FAILURE_EXIT` 为退出码门槛并排除"部分执行"信息行，windows-acl 带退出码 127 与 `windows-acl-run: ` 签名（[packages/sandbox/sandbox-local/src/index.ts:216-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L216-L240)）
- 运行期 schema 给 `runnerCommand`、`runnerFailureSignatures` 默认空数组，`probeTimeoutMs` 默认 5000（[packages/sandbox/sandbox-local/src/index.ts:252-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L252-L256)）
- 构造时拒绝只给失败签名不给自定义运行器、只给自定义运行器不给失败签名，以及空白或跨行的签名条目（[packages/sandbox/sandbox-local/src/index.ts:283-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L283-L291)）
- 构造时校验探测超时为正有限数（[packages/sandbox/sandbox-local/src/index.ts:294-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L294-L295)）
- 构造时注册一个 `ctx.effect` 拆卸回调，在提供者销毁时撤销 ACL 授权（[packages/sandbox/sandbox-local/src/index.ts:300-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L300-L302)）
- 配置了 `runnerCommand` 时，`confine` 用它加 bwrap 风格配置参数与 `--` 包裹原 argv，直接断言 `full` 执行完整度，并用配置的失败签名（[packages/sandbox/sandbox-local/src/index.ts:317-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L317-L324)）
- 否则 `confine` 先解析出运行器，再返回被包裹的 argv 以及该运行器的执行完整度、拒绝签名与运行器失败规则（[packages/sandbox/sandbox-local/src/index.ts:325-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L325-L332)）
- `runnerArgv` 按选定运行器分派到 bwrap、Landlock 启动器、`sandbox-exec` 或 windows-acl 运行器，未知值走 `assertNever`（[packages/sandbox/sandbox-local/src/index.ts:336-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L336-L344)）
- 无会话 id 或 read-only 模式时，windows-acl 调用只传工作区、环境临时目录与模式，不下发任何 SID 标志（[packages/sandbox/sandbox-local/src/index.ts:359-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L359-L367)）
- 有会话的 workspace-write 调用先物化授权，再把私有临时目录、`--write-sid` 与 `--temp-write-sid` 传给运行器（[packages/sandbox/sandbox-local/src/index.ts:368-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L368-L377)）
- `materializeAclGrant` 先断言临时根位于工作区之外（[packages/sandbox/sandbox-local/src/index.ts:392-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L392-L393)）
- 每个工作区只创建一次工作区级写授权并递归加到根上；失败时释放 SID，清理再失败则抛 `AggregateError`（[packages/sandbox/sandbox-local/src/index.ts:394-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L394-L411)）
- 以 `[会话 id, 工作区根]` 序列化为键缓存临时能力，命中即复用（[packages/sandbox/sandbox-local/src/index.ts:412-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L412-L414)）
- 未命中时用 `mkdtempSync` 建随机私有临时目录、派生独立 SID 并加授权；失败时销毁授权、删除目录，清理再失败则抛 `AggregateError`（[packages/sandbox/sandbox-local/src/index.ts:415-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L415-L442)）
- `revokeAclGrants` 在两张表都为空时直接返回（[packages/sandbox/sandbox-local/src/index.ts:454-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L454-L455)）
- 拆卸时销毁工作区与临时两类授权、删除本提供者建的临时目录，并清空两张表（[packages/sandbox/sandbox-local/src/index.ts:456-472](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L456-L472)）
- 清理失败只经 `ctx.logger.warn` 汇总输出而不抛出，使拆卸不中断（[packages/sandbox/sandbox-local/src/index.ts:473-476](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L473-L476)）
- `removeTempDir` 默认用 `rmSync(path, { recursive: true, force: true })`，可被注入钩子替换（[packages/sandbox/sandbox-local/src/index.ts:480-483](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L480-L483)）
- `selectRunner` 把链判定缓存到提供者生命周期，判定为不可用时抛 `SandboxUnavailableError`，命令不执行（[packages/sandbox/sandbox-local/src/index.ts:492-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L492-L496)）
- `chainVerdict` 取注入的链或按当前平台查表（无链则空），空链判为不可用，单候选不探测直选并用静态完整度，多候选按链序探测取首个可用，全不可用则判为不可用（[packages/sandbox/sandbox-local/src/index.ts:499-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L499-L510)）
- `probeRunner` 对 bwrap 与 seatbelt 把通过映射为 `full`、失败为 `unusable`，Landlock 直接采用启动器探测返回的完整度，windows-acl 通过则为 `partial`，未知值走 `assertNever`（[packages/sandbox/sandbox-local/src/index.ts:513-539](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L513-L539)）
- `landlockLauncher` 与 `seatbeltExec` 分别在注入钩子与已解析启动器路径 / `sandbox-exec` 之间取值（[packages/sandbox/sandbox-local/src/index.ts:542-549](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L542-L549)）
- `windowsAclRunnerInvocation` 优先用注入 argv，其次在构建产物 `runner` 入口存在时用 `[process.execPath, 入口]`，否则回退到经 `--import tsx/esm` 加载的源码入口（[packages/sandbox/sandbox-local/src/index.ts:557-564](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L557-L564)）
- 提供者类作为默认导出，使其可直接作为 Cordis 服务插件挂载（[packages/sandbox/sandbox-local/src/index.ts:567](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/index.ts#L567)）

### packages/sandbox/sandbox-local/src/profiles.ts

各平台配置参数构造器，把文件效果策略翻译成 bwrap 挂载、Landlock 授权与 Seatbelt SBPL。

- `bwrapProfileArgs` 固定给出只读根绑定、独立 `/dev`、私有 PID 命名空间下的 `/proc` 与 `--die-with-parent`（[packages/sandbox/sandbox-local/src/profiles.ts:16-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/profiles.ts#L16-L17)）
- `workspace-write` 时再加临时文件系统 `/tmp` 与工作区根的可写绑定（[packages/sandbox/sandbox-local/src/profiles.ts:18-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/profiles.ts#L18-L21)）
- `landlockProfileArgs` 只读授予 `/`，读写默认只有 `/dev/null`，`workspace-write` 时追加 `/tmp` 与工作区根（[packages/sandbox/sandbox-local/src/profiles.ts:30-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/profiles.ts#L30-L36)）
- `sbplString` 对路径中的反斜杠与双引号转义后包成 SBPL 字符串字面量（[packages/sandbox/sandbox-local/src/profiles.ts:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/profiles.ts#L39-L41)）
- `seatbeltProfileArgs` 生成 allow-default 加 `(deny file-write*)` 再单独放行 `/dev/null` 的 SBPL，并把共享推导出的可写根逐个作为 `subpath` 放行，最终以 `-p` 传给 `sandbox-exec`（[packages/sandbox/sandbox-local/src/profiles.ts:51-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/profiles.ts#L51-L58)）

### packages/sandbox/sandbox-local/src/invariant.ts

该包的不变量伴生插件，向不变量注册表登记包名。

- `inject = ['invariants']` 使伴生插件在不变量注册表可用之后才执行（[packages/sandbox/sandbox-local/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/invariant.ts#L15)）
- 安装器为空函数，登记后不注册任何监听或检查（[packages/sandbox/sandbox-local/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 占用该包名并返回注销函数（[packages/sandbox/sandbox-local/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-local/src/invariant.ts#L28-L29)）

### packages/sandbox/sandbox-local/tsconfig.json

该包的 TypeScript 编译配置与工程引用。

- 无运行期机制
