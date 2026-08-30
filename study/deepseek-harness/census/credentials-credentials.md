---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/credentials/credentials
---

# packages/credentials/credentials

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、24 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/credentials/credentials/README.md

该包的说明文档，介绍引用与记录两个键空间的用法与边界。

- 无运行期机制

### packages/credentials/credentials/package.json

该包的 npm 清单，声明入口、子路径导出与依赖。

- `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/credentials/credentials/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/package.json#L14-L15)）
- `exports` 开放根、`./invariant`、`./types`、`./src/*` 与 `./package.json` 五个入口，决定外部能解析到哪些模块（[packages/credentials/credentials/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/package.json#L16-L31)）
- `files` 限定发布进包的文件集合（[packages/credentials/credentials/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/package.json#L32-L37)）

### packages/credentials/credentials/src/index.ts

凭据接缝的服务定义，提供两套键的构造与解析函数，以及抽象的 `ctx.credentials` 提供者基类。

- `REF_PATTERN` 把引用名限制为 POSIX 风格的环境变量标识符（[packages/credentials/credentials/src/index.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L18)）
- `KEY_SEGMENT_PATTERN` 把记录键的两段限制为小写连字符标识符，使其与引用语法互不相交（[packages/credentials/credentials/src/index.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L21)）
- `credentialRef` 校验后打上品牌，不合法则抛 `TypeError`（[packages/credentials/credentials/src/index.ts:28-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L28-L33)）
- `isCredentialRefName` 提供不抛错的判定，让语法外的名字读成"未设置"（[packages/credentials/credentials/src/index.ts:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L44-L46)）
- `isCredentialKeySegment` 提供不抛错的键段判定（[packages/credentials/credentials/src/index.ts:57-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L57-L59)）
- `credentialKey` 校验两段后拼成 `<scope>/<id>` 并打品牌（[packages/credentials/credentials/src/index.ts:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L68-L75)）
- `parseCredentialKey` 要求恰好两段，否则抛 `TypeError`（[packages/credentials/credentials/src/index.ts:84-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L84-L91)）
- `credentialKeyScope` 与 `credentialKeyId` 按第一个 `/` 切出归属段与 id 段（[packages/credentials/credentials/src/index.ts:100-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L100-L114)）
- 抽象基类构造函数把提供者注册到 `ctx` 的 `credentials` 名下（[packages/credentials/credentials/src/index.ts:169-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L169-L172)）
- `notifyUpdated` 把引用变更走受控分发发成 `credentials/reference-updated`（[packages/credentials/credentials/src/index.ts:268-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L268-L270)）
- `notifyRecordUpdated` 把记录变更走同一受控分发发成 `credentials/record-updated`（[packages/credentials/credentials/src/index.ts:277-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L277-L279)）
- `fanOut` 逐个调用监听器，同步抛出与异步拒绝都只记日志、不改变已提交操作的结果（[packages/credentials/credentials/src/index.ts:285-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L285-L303)）
- `INVARIANT` 码的监听器失败被留存，待所有监听器跑完后重抛（[packages/credentials/credentials/src/index.ts:296-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L296-L304)）
- `warnListenerFailure` 把事件名、主体与错误对象写进警告日志（[packages/credentials/credentials/src/index.ts:309-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L309-L312)）
- 抽象提供者类作为默认导出，供加载器按服务包约定装载（[packages/credentials/credentials/src/index.ts:315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/index.ts#L315)）

### packages/credentials/credentials/src/invariant.ts

该包的运行期检查伴生插件，注册在 `invariants` 服务上。

- 导出插件名与 `inject = ['invariants']`，决定该伴生何时可装载（[packages/credentials/credentials/src/invariant.ts:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/invariant.ts#L12-L14)）
- 安装器监听 `credentials/reference-updated`，事件在服务不存在时触发即报失败（[packages/credentials/credentials/src/invariant.ts:24-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/invariant.ts#L24-L30)）
- `apply` 用包名向 `ctx.invariants` 注册安装器并返回其处置器（[packages/credentials/credentials/src/invariant.ts:37-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials/src/invariant.ts#L37-L38)）

### packages/credentials/credentials/src/types.ts

只含类型的模块，定义两个键品牌、记录联合、引用视图与两个事件的声明合并。

- 无运行期机制

### packages/credentials/credentials/tsconfig.json

该包的 TypeScript 编译配置，声明 `rootDir`/`outDir` 与工作区项目引用。

- 无运行期机制
