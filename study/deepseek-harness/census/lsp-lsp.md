---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/lsp/lsp
---

# packages/lsp/lsp

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、25 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/lsp/lsp/README.md

`dsh-lsp` 包的英文说明文档，介绍该服务的四个只读操作、提供者注册方式、错误码与组合示例。

- 无运行期机制

### packages/lsp/lsp/package.json

`@deepseek-ai/dsh-lsp` 的 npm 清单，声明模块入口、导出映射与依赖。

- `type: module` 与 `main`/`types` 指定运行期加载的入口文件为 `lib/index.js`（[packages/lsp/lsp/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/package.json#L13-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个子路径，其余路径不可被导入（[packages/lsp/lsp/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/package.json#L16-L27)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/lsp/lsp/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/package.json#L28-L32)）

### packages/lsp/lsp/src/brand.ts

定义提供者标识的品牌类型与其工厂函数，被 `index.ts` 再导出并由提供者包使用。

- 品牌工厂不做任何校验，原样返回入参字符串，空标识等非法值一路进入注册函数才被拒绝（[packages/lsp/lsp/src/brand.ts:19-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/brand.ts#L19-L21)）

### packages/lsp/lsp/src/index.ts

该包的插件入口：定义 `ctx.lsp` 服务类、提供者注册与按扩展名选路的查询、扩展名归一化函数与错误类型。

- `LspError` 继承 `HarnessError`，把失败表达为带稳定 `code` 的结构化错误供调用方分支（[packages/lsp/lsp/src/index.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L50)）
- `finalExtension()` 同时按 `/` 和 `\` 切出文件名，取最后一个点之后的部分并小写，`dot <= 0` 时返回空串，使无扩展名与前导点文件永远匹配不到任何路由（[packages/lsp/lsp/src/index.ts:60-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L60-L67)）
- `EXTENSION_PATTERN` 要求扩展名是一个点加一个以上非点非分隔符字符（[packages/lsp/lsp/src/index.ts:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L70)）
- 服务类以 `'lsp'` 为名构造，从而把注册表挂到 `ctx.lsp` 上（[packages/lsp/lsp/src/index.ts:82-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L82-L88)）
- 注册时空白标识抛 `LSP_INVALID_PROVIDER`（[packages/lsp/lsp/src/index.ts:94-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L94-L96)）
- 标识重复抛 `LSP_CONFLICT`（[packages/lsp/lsp/src/index.ts:97-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L97-L99)）
- 一个扩展名都不映射的提供者被拒绝（[packages/lsp/lsp/src/index.ts:101-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L101-L104)）
- 逐条归一化扩展名，非法扩展名、空语言标识、同一提供者内归一化后重复的扩展名分别抛 `LSP_INVALID_PROVIDER`（[packages/lsp/lsp/src/index.ts:108-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L108-L121)）
- 全部待注册扩展名与已有路由表比对，任一冲突抛 `LSP_CONFLICT`，且所有检查都在改动状态之前完成（[packages/lsp/lsp/src/index.ts:122-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L122-L126)）
- 通过 `ctx.effect()` 一次性写入标识与全部扩展名路由，其清理函数同时删除标识与全部路由（[packages/lsp/lsp/src/index.ts:130-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L130-L137)）
- 返回的注销函数是同步的，丢弃 `ctx.effect` 清理返回的 Promise（[packages/lsp/lsp/src/index.ts:138-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L138-L140)）
- `query()` 用请求文件的最终扩展名查路由表，查不到抛 `LSP_UNAVAILABLE`（[packages/lsp/lsp/src/index.ts:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L143-L147)）
- 转发给选中的提供者时把路由上的 `languageId` 并进请求，并透传取消信号（[packages/lsp/lsp/src/index.ts:148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L148)）
- `normalizeExtension()` 小写化并补上前导点（[packages/lsp/lsp/src/index.ts:153-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L153-L156)）
- 默认导出服务类，使该模块以服务插件形式被加载（[packages/lsp/lsp/src/index.ts:158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/index.ts#L158)）

### packages/lsp/lsp/src/invariant.ts

该包的不变量伴随插件，向 `invariants` 服务登记包名。

- `inject = ['invariants']` 使伴随插件在该服务就绪前不运行（[packages/lsp/lsp/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/invariant.ts#L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/lsp/lsp/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/invariant.ts#L21)）
- `apply` 向 `ctx.invariants` 以包名登记该空安装器并返回其注销函数（[packages/lsp/lsp/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/lsp/src/invariant.ts#L28-L29)）

### packages/lsp/lsp/src/types.ts

该服务的类型词汇表：操作枚举、位置与范围、请求、结果联合、提供者与服务接口。

- 无运行期机制

### packages/lsp/lsp/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
