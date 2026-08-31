---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/typert/loader
---

# packages/typert/loader

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、43 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/typert/loader/README.md

该包的说明文档，介绍挂载后如何自动注册各包生成的 typert 产物、配置字段与失败表现。

- 无运行期机制

### packages/typert/loader/package.json

该包的 npm 清单。

- `type: module` 与 `main`/`types` 决定该包按 ESM 解析、默认入口指向 `lib/index.js`（[packages/typert/loader/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/typert/loader/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/package.json#L16-L27)）
- `files` 限定发布进包的只有 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/typert/loader/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/package.json#L28-L32)）
- `@deepseek-ai/schemastery` 是运行期真实依赖（配置校验用），cordis、loader、registry、invariants 均为 peer（[packages/typert/loader/package.json:34-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/package.json#L34-L42)）

### packages/typert/loader/src/index.ts

Loader 集成插件：跟随 Loader 条目的挂载与卸载，导入各包的 host 面 `./typert` 产物、校验其 `TYPERT` manifest 并注册进 `ctx.typert`。

- `TYPERT_HOST_EXPORT` 固定为 `./typert`，是发现 host 面产物的唯一导出键（[packages/typert/loader/src/index.ts:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L39)）
- `inject = ['typert', 'loader']` 使该插件必须等注册表与 Loader 两个服务就绪才激活（[packages/typert/loader/src/index.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L44)）
- `Config` 校验 `packages` 为非空字符串数组并默认成空数组，即默认只做 Loader 条目发现（[packages/typert/loader/src/index.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L53-L55)）
- `typertExportOf` 接受字符串形式或带字符串 `default` 的一层条件导出，其他形态抛错（[packages/typert/loader/src/index.ts:62-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L62-L72)）
- manifest 校验要求导出对象存在、`package` 字段与导出它的包名一致、`face` 为 `host`（[packages/typert/loader/src/index.ts:84-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L84-L95)）
- `TYPERT.schemas` 必须是数组，每项须有非空 name 且 schema 是带 `_zod` 的 zod v4 实例（[packages/typert/loader/src/index.ts:96-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L96-L108)）
- `TYPERT.model` 的 services/events/objects 三张表逐项校验文档字段、必填字符串、成员表与类型表（[packages/typert/loader/src/index.ts:109-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L109-L137)）
- 通过校验后原样把 manifest 断言为 `TypertContribution` 返回（[packages/typert/loader/src/index.ts:138-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L138-L141)）
- `requireDocumentation` 要求 `tags` 是数组，`description`/`summary`/`jsDoc` 若存在必须是字符串（[packages/typert/loader/src/index.ts:162-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L162-L169)）
- 成员的 `kind` 必须落在 property/method/getter/setter/call/construct/index 这个集合内（[packages/typert/loader/src/index.ts:171-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L171-L180)，集合见 [packages/typert/loader/src/index.ts:59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L59)）
- invocation 必须有非空 id/service/namespace/method，接收方 kind 只能是 `direct` 或 `context`，`context` 还须带 context、wire 与严格 codec（[packages/typert/loader/src/index.ts:190-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L190-L203)）
- 参数逐个校验：wire 字段不得重复，source 只能是 `json` 或 `lookup`，`lookup` 须带非空 lookup 名、`json` 不得声明 lookup，且每个参数都要有严格 codec（[packages/typert/loader/src/index.ts:204-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L204-L228)）
- 声明了 cancellation 时其 parameter 必须是 `signal`（[packages/typert/loader/src/index.ts:229-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L229-L234)）
- scope 只允许出现在 direct 接收方上，且其 wire 必须恰好选中唯一一个 lookup 参数、该参数的 lookup 名与 scope.context 相同（[packages/typert/loader/src/index.ts:235-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L235-L248)）
- context 接收方的 wire 字段不得与任何参数 wire 重名；结果必须有严格 codec（[packages/typert/loader/src/index.ts:249-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L249-L252)）
- `sourceLocation` 若存在，file 必须非空、line 与 column 必须是不小于 1 的整数（[packages/typert/loader/src/index.ts:253-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L253-L261)）
- 严格 codec 要求 `mode === 'strict'`、非空 typeSymbol，且 schema 是带 `_zod` 与可调用 `parse` 的 zod v4 实例（[packages/typert/loader/src/index.ts:264-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L264-L276)）
- `ctx.baseUrl` 未设置时激活直接抛错（[packages/typert/loader/src/index.ts:289-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L289-L291)）
- 解析锚点取 `ctx.baseUrl`（配置树目录）而非本包 URL，`createRequire` 由此建立（[packages/typert/loader/src/index.ts:285-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L285-L292)）
- 插件持有五张进程内表：按条目名的已注册 disposer、在途任务、按包名的产物路径判定、按包名的已导入 manifest，以及待处理的 dirty 名字集（[packages/typert/loader/src/index.ts:295-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L295-L306)）
- 一个 `ctx.effect` 在插件卸载时把 `active` 置假并清空 dirty 集（[packages/typert/loader/src/index.ts:308-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L308-L313)）
- 产物解析先查缓存；`require.resolve` 失败时，若该包在显式 `packages` 里就抛错，否则把该包名永久缓存成 null（[packages/typert/loader/src/index.ts:315-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L315-L332)）
- 读到 package.json 后取 `./typert` 导出；显式配置的包缺该导出时抛错，非配置包缓存成 null，否则缓存拼好的绝对路径（[packages/typert/loader/src/index.ts:333-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L333-L340)）
- `loadManifest` 保证每个包每进程只 `import()` 一次，成功走 manifest 校验，失败包装成点名包与路径的错误（[packages/typert/loader/src/index.ts:343-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L343-L357)）
- `qualifies` 认两类名字：显式配置的包名，或存在同名、已有 fiber 且未被 disabled 的 Loader 条目（[packages/typert/loader/src/index.ts:359-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L359-L365)）
- 一个名字不再合格时，调用并移除它此前的注册 disposer（[packages/typert/loader/src/index.ts:369-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L369-L376)）
- 已注册或已有在途任务的名字直接跳过；产物路径为 null 的名字也跳过（[packages/typert/loader/src/index.ts:377-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L377-L379)）
- 导入完成后再次确认插件仍活、条目仍合格且尚未注册，才调用 `ctx.typert.register(manifest)` 并存下 disposer（[packages/typert/loader/src/index.ts:380-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L380-L384)）
- 在途任务用「成功/失败两臂都清理」的方式收尾，避免多产生一个未处理的 rejection（[packages/typert/loader/src/index.ts:385-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L385-L389)）
- `flush` 逐个抽干 dirty 集，把同步抛出与异步失败都交给传入的 `onError`，并把异步任务收集起来交由调用方决定是否等待（[packages/typert/loader/src/index.ts:392-406](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L392-L406)）
- 监听 cordis `internal/plugin`：无 entry 的 fiber 直接丢弃，有 entry 的把条目名标脏并合并到一次 microtask flush，稳态下的错误只走 `ctx.logger.error`（[packages/typert/loader/src/index.ts:411-422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L411-L422)）
- 订阅先于播种，激活时把全部显式包名与全部当前 Loader 条目名塞进同一个 dirty 集（[packages/typert/loader/src/index.ts:427-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L427-L428)）
- 激活扫描 `await` 全部任务，任一贡献者失败就抛出带条数与逐条消息的 `AggregateError`（[packages/typert/loader/src/index.ts:429-436](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L429-L436)）
- 非 Error 的抛出物统一归一成 Error 后再上报（[packages/typert/loader/src/index.ts:440-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/index.ts#L440-L442)）

### packages/typert/loader/src/invariant.ts

该包自带的 invariant 伴生插件，向 `invariants` 服务登记本包归属。

- `inject = ['invariants']` 使该伴生插件必须等 `invariants` 服务就绪才激活（[packages/typert/loader/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/invariant.ts#L15)）
- `apply` 以空 installer 登记包名并返回登记的 disposer（[packages/typert/loader/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/src/invariant.ts#L21-L29)）

### packages/typert/loader/tsconfig.json

该包的 TypeScript 工程配置。

- `rootDir: src` 与 `outDir: lib/types` 决定类型声明的产出位置，`include` 限定被编译的文件（[packages/typert/loader/tsconfig.json:3-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/tsconfig.json#L3-L9)）
- `references` 声明本工程构建前需先构建的六个工程（[packages/typert/loader/tsconfig.json:10-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/typert/loader/tsconfig.json#L10-L29)）
