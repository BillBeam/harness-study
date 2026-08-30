---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/fs/fs-sandbox
---

# packages/fs/fs-sandbox

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、28 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/fs/fs-sandbox/README.md

该包的说明文档，描述沙箱后端的组合方式、按调用模式的围栏行为与拒绝码。

- 无运行期机制

### packages/fs/fs-sandbox/package.json

该包的 npm 清单，声明入口与发布内容。

- `exports` 把 `.` 映射到 `./lib/index.js`、`./invariant` 映射到 `./lib/invariant.js`，并开放 `./src/*` 与 `./package.json` 子路径（[packages/fs/fs-sandbox/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/fs/fs-sandbox/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/package.json#L28-L32)）
- `main`/`types` 为不识别 `exports` 的解析器指定 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/fs/fs-sandbox/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/package.json#L14-L15)）

### packages/fs/fs-sandbox/src/containment.ts

路径包含判定模块，被沙箱后端的写入围栏用来判断目标是否落在可写根之下。

- `MISSING_CODES` 把 `ENOENT` 与 `ENOTDIR` 认定为"缺失"，其余 stat 失败向外抛出（[packages/fs/fs-sandbox/src/containment.ts:12-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/containment.ts#L12-L17)）
- `comparablePath` 在非大小写敏感模式下把路径整体转小写再比较（[packages/fs/fs-sandbox/src/containment.ts:19-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/containment.ts#L19-L21)）
- `isLexicallyUnder` 判定相等或以"根 + 分隔符"为前缀，作为词法快路径（[packages/fs/fs-sandbox/src/containment.ts:23-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/containment.ts#L23-L29)）
- `statIfPresent` 用 `bigint` stat，缺失返回 `undefined`，其它错误重新抛出（[packages/fs/fs-sandbox/src/containment.ts:31-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/containment.ts#L31-L40)）
- `sameIdentity` 以 `dev` 与 `ino` 相等判定同一文件系统对象（[packages/fs/fs-sandbox/src/containment.ts:42-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/containment.ts#L42-L44)）
- `caseSensitive` 默认取 `process.platform !== 'win32'`（[packages/fs/fs-sandbox/src/containment.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/containment.ts#L61)）
- `isPathUnder` 先走词法判定，命中即返回真（[packages/fs/fs-sandbox/src/containment.ts:63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/containment.ts#L63)）
- 根本身 stat 不到时直接返回假（[packages/fs/fs-sandbox/src/containment.ts:65-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/containment.ts#L65-L66)）
- 词法不匹配时逐级向上遍历目标的现存祖先并按文件系统身份比对，走到不再变化的父目录时返回假（[packages/fs/fs-sandbox/src/containment.ts:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/containment.ts#L68-L75)）

### packages/fs/fs-sandbox/src/index.ts

包主入口，导出继承本地后端的 `SandboxedFileSystem`，在写入与编辑两个变更操作上加按调用模式的路径围栏。

- `static inject = ['sandboxPolicy']` 要求该服务在构造前就位（[packages/fs/fs-sandbox/src/index.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L56)）
- 构造时从 `ctx.sandboxPolicy.defaultMode` 取出并保存部署默认模式（[packages/fs/fs-sandbox/src/index.ts:58-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L58-L62)）
- 覆写 `sandboxMode` 取值器返回该默认模式，工具层据此决定是否公布升级参数（[packages/fs/fs-sandbox/src/index.ts:65-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L65-L67)）
- 覆写 `writeText`：先过围栏取得目标，再以该目标调用父类写入，且不把 `sandboxPolicy` 继续下传（[packages/fs/fs-sandbox/src/index.ts:80-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L80-L88)）
- 覆写 `editText`：同样先过围栏再委托父类编辑（[packages/fs/fs-sandbox/src/index.ts:101-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L101-L109)）
- `checkedTarget` 在未传入策略时回落到 `ctx.sandboxPolicy.resolve()`（[packages/fs/fs-sandbox/src/index.ts:122-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L122-L124)）
- `danger-full-access` 直接返回调用方目标，不做任何围栏（[packages/fs/fs-sandbox/src/index.ts:125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L125)）
- `read-only` 抛出 `FS_SANDBOX_DENIED`，文案为 `cannot write "<path>": file access denied under read-only mode`（[packages/fs/fs-sandbox/src/index.ts:126-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L126-L128)）
- `workspace-write` 在变更前重新 `resolve` 一次目标，并把这个新解析结果作为实际被变更的目标返回（[packages/fs/fs-sandbox/src/index.ts:132-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L132-L143)）
- 逐个遍历 `writableRoots(policy)` 给出的可写根做包含判定，全部不命中则抛出 `FS_SANDBOX_DENIED`，文案标注 `workspace-write mode`（[packages/fs/fs-sandbox/src/index.ts:134-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L134-L142)）
- 默认导出该类，使其可被加载器作为服务插件挂载为 `ctx.fs`（[packages/fs/fs-sandbox/src/index.ts:147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/index.ts#L147)）

### packages/fs/fs-sandbox/src/invariant.ts

该包的不变量伴生插件，向 `ctx.invariants` 登记包名。

- 声明 `inject = ['invariants']`，在注册前要求该服务就位（[packages/fs/fs-sandbox/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/invariant.ts#L15)）
- 安装器为空函数，即不注册任何运行期检查（[packages/fs/fs-sandbox/src/invariant.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/invariant.ts#L18)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其 disposer（[packages/fs/fs-sandbox/src/invariant.ts:25-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-sandbox/src/invariant.ts#L25-L26)）

### packages/fs/fs-sandbox/tsconfig.json

该包的 TypeScript 编译配置，指定 rootDir/outDir 与工程引用。

- 无运行期机制
