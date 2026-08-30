---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/identity/anonymous-user-id
---

# packages/identity/anonymous-user-id

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、19 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/identity/anonymous-user-id/README.md

该包的说明文档，描述匿名 id 的生成、存储位置与使用方。

- 无运行期机制

### packages/identity/anonymous-user-id/package.json

该包的 npm 清单，声明入口、导出与发布内容。

- `type: module` 与 `main`/`types` 指定包按 ESM 加载、运行时入口为 `lib/index.js`（[packages/identity/anonymous-user-id/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/package.json#L13-L15)）
- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，并放开 `./src/*` 与 `./package.json`（[packages/identity/anonymous-user-id/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/package.json#L16-L27)）
- `files` 限定发布物只含实现、伴生与类型声明（[packages/identity/anonymous-user-id/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/package.json#L28-L32)）

### packages/identity/anonymous-user-id/src/index.ts

库入口，导出 `getOrCreateAnonymousUserId`，被遥测、反馈与 provider 请求头共同调用。

- 导出文件名常量 `.anonymous-user-id`，确定该 id 在 harness home 下的存储文件（[packages/identity/anonymous-user-id/src/index.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L29)）
- UUID 正则决定读到的文件内容是否被接受为有效 id（[packages/identity/anonymous-user-id/src/index.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L31)）
- 进程级 memo 以解析后的文件路径为键，同一路径整个进程只落一次盘（[packages/identity/anonymous-user-id/src/index.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L42)）
- `readPersistedId` 同步读文件，读失败吞掉异常返回 `undefined`；读到的内容 trim 后不匹配 UUID 正则也返回 `undefined`（[packages/identity/anonymous-user-id/src/index.ts:45-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L45-L55)）
- 文件路径由 `resolveDshHome` 结合传入或 `process.env` 的环境解析而来，不同 home 得到不同路径（[packages/identity/anonymous-user-id/src/index.ts:69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L69)）
- memo 命中时直接返回缓存值，运行中删除文件也不改变本进程的 id（[packages/identity/anonymous-user-id/src/index.ts:70-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L70-L71)）
- 无有效持久值时用 `options.randomUUID` 或 `crypto.randomUUID` 新铸一个随机 UUID（[packages/identity/anonymous-user-id/src/index.ts:73-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L73-L76)）
- 递归创建目录后以 `wx` 独占标志写入，让并发首启只有一个写者成功（[packages/identity/anonymous-user-id/src/index.ts:78-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L78-L80)）
- 独占写失败时重读文件，读到有效值就采纳该值（并发竞争的败者跟随胜者）（[packages/identity/anonymous-user-id/src/index.ts:81-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L81-L87)）
- 重读仍无有效值时以普通写覆盖文件；覆盖也失败则吞掉异常，本次运行仍使用内存中新铸的 id（[packages/identity/anonymous-user-id/src/index.ts:87-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L87-L95)）
- 最终结果写入 memo 后返回，本进程后续调用恒定复用它（[packages/identity/anonymous-user-id/src/index.ts:98-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/index.ts#L98-L99)）

### packages/identity/anonymous-user-id/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包名。

- `inject` 声明 `invariants`，服务缺席时伴生插件不激活（[packages/identity/anonymous-user-id/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/invariant.ts#L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/identity/anonymous-user-id/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/invariant.ts#L22)）
- `apply` 以包名把该安装器登记进 `ctx.invariants` 并返回其 disposer（[packages/identity/anonymous-user-id/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/identity/anonymous-user-id/src/invariant.ts#L29-L30)）

### packages/identity/anonymous-user-id/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制
