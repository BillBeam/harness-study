---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/hmr
---

# vendor/hmr

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、57 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/hmr/README.md

热替换插件的包说明，列出监听规范化行为、依赖要求、YAML 用法与配置字段、事件表。

- 无运行期机制

### vendor/hmr/package.json

该包的 npm 清单，声明入口、导出映射、发布文件集合、框架元数据与依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定按包名导入时加载的运行期文件（[vendor/hmr/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/package.json#L14-L15)）
- `exports` 把 `.` 解析到 `lib/index.js`，并开放 `./src/*` 与 `./package.json`（[vendor/hmr/package.json:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/package.json#L16-L23)）
- `files` 限定发布产物为 `lib/index.js`、类型声明与 `src`（[vendor/hmr/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/package.json#L24-L29)）
- 清单内的框架元数据块声明本插件必需服务为 `timer`，并给出中英文描述（[vendor/hmr/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/package.json#L32-L42)）

### vendor/hmr/src/error.ts

热替换重新导入插件入口失败时的错误输出函数，被 `src/index.ts` 的 `partialReload` 调用。

- `isBuildFailure` 以「有 `errors` 数组且每项都有 `text`」判定是否为构建失败对象（[vendor/hmr/src/error.ts:6-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L6-L8)）
- 非构建失败对象直接以 `logger.warn` 输出原错误后返回（[vendor/hmr/src/error.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L12-L15)）
- 逐条错误处理：缺少 `location` 时只输出错误文本（[vendor/hmr/src/error.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L17-L21)）
- 有 `location` 时同步读取源文件并生成带高亮的代码框，连同 `文件:行:列` 一起 warn（[vendor/hmr/src/error.ts:22-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L22-L31)）
- 读源文件或生成代码框自身抛错时，退回为 warn 该异常（[vendor/hmr/src/error.ts:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L32-L34)）

### vendor/hmr/src/index.ts

热替换服务的实现，监听文件变化、分析模块依赖图、清缓存并重新挂载受影响的条目插件。

- `loadDependencies` 沿 `job.linked` 递归收集依赖 URL，跳过 `node:` 与包含 `/node_modules/` 的模块，并按已忽略集合与已收集集合剪枝（[vendor/hmr/src/index.ts:37-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L37-L48)）
- `findWatchRoot` 从文件所在目录逐级上溯到最深的已存在目录，非目录时抛错，`realpath` 规范化后把缺失后缀拼回，同时返回该层级的 `depth`（[vendor/hmr/src/index.ts:64-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L64-L84)）
- 服务声明依赖 `loader` 与 `timer` 两个服务（[vendor/hmr/src/index.ts:87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L87)）
- 构造时 loader 若没有内部模块加载器则抛错，阻止服务建立（[vendor/hmr/src/index.ts:120-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L120-L123)）
- `baseDir` 由 `config.base` 相对 `ctx.baseUrl` 解析而来（[vendor/hmr/src/index.ts:124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L124)）
- `registerConfig` 在服务未激活时抛错，路径按 `baseDir` 解析并规范化后若已注册则抛错（[vendor/hmr/src/index.ts:135-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L135-L139)）
- `registerConfig` 对该文件的最深存在祖先目录开一个独立 watcher，限定 `depth`、清空 `cwd` 与 `ignored`，且 `ignoreInitial: false` 使注册时已存在的文件也触发一次（[vendor/hmr/src/index.ts:141-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L141-L148)）
- 该 watcher 的 add/change/unlink 回调只在观察到的路径等于请求路径或规范化路径时触发刷新（[vendor/hmr/src/index.ts:151-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L151-L158)）
- watcher 的 `ready` 决议注册结果，`error` 在就绪前拒绝、就绪后仅 warn（[vendor/hmr/src/index.ts:160-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L160-L173)）
- 就绪后通过 `ctx.effect` 注册异步 disposer：摘掉注册项、关闭 watcher、并等待在跑的刷新任务（[vendor/hmr/src/index.ts:175-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L175-L181)）
- 就绪失败时删除注册项、关闭 watcher 并向调用方抛出（[vendor/hmr/src/index.ts:182-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L182-L186)）
- `_resolve` 按内部加载器的 `version` 分派到 v1 的异步 `resolve` 或 v2 的 `resolveSync`（[vendor/hmr/src/index.ts:192-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L192-L197)）
- 服务初始化先 yield 卸载函数：关闭主 watcher、关闭全部 config watcher、清空注册表并等待所有刷新任务结束（[vendor/hmr/src/index.ts:199-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L199-L205)）
- 启动时按是否配置 `base` 打印两种不同的 watching 日志（[vendor/hmr/src/index.ts:209-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L209-L213)）
- 以 `picomatch(ignored)` 建立忽略匹配器，并对 `baseDir` 取 `realpath` 作为监听根（[vendor/hmr/src/index.ts:215-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L215-L216)）
- 在开 watcher 之前先从 `process.argv[1]` 的模块作业收集 externals 依赖集合，取不到时置空集（[vendor/hmr/src/index.ts:218-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L218-L226)）
- 主 watcher 以 `watchBaseDir` 为 cwd、用忽略匹配器过滤相对路径，并设 `ignoreInitial: true` 使初始扫描不产生事件（[vendor/hmr/src/index.ts:228-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L228-L240)）
- 局部重载经 `ctx.debounce` 按 `config.debounce` 去抖成一次（[vendor/hmr/src/index.ts:242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L242)）
- 变更回调先遍历 loader 条目，命中某条目子树的配置文件名时改走该子树的 `refresh()` 并返回（[vendor/hmr/src/index.ts:244-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L244-L254)）
- 非 `change` 类型的事件在配置分支之后被丢弃（[vendor/hmr/src/index.ts:256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L256)）
- 变更文件属于 externals 时调用 `loader.exit()` 走整进程重启路径（[vendor/hmr/src/index.ts:258-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L258-L260)）
- 变更文件在内部加载器的 `loadCache` 中时暂存该 URL 并触发去抖后的局部重载（[vendor/hmr/src/index.ts:262-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L262-L268)）
- 其余变更以 `hmr/change` 事件对外发出（[vendor/hmr/src/index.ts:270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L270)）
- 主 watcher 的 add/change/unlink 三个事件都接到同一回调并带上事件种类（[vendor/hmr/src/index.ts:272-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L272-L274)）
- 初始化在 watcher `ready` 前阻塞；`root` 为空时直接视为就绪，`error` 在就绪前拒绝、之后只 warn（[vendor/hmr/src/index.ts:276-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L276-L294)）
- `refreshConfig` 对同一 key 只跑一条任务，任务在跑时新变更只置 `dirty`（[vendor/hmr/src/index.ts:297-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L297-L301)）
- 刷新任务以 do/while 在 `dirty` 被重新置位时再跑一轮（[vendor/hmr/src/index.ts:302-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L302-L317)）
- 刷新失败时把原因归一为 `Error`、warn 出文件名与错误，并以 parallel 模式发出 `hmr/config-update-failed`；监听器自身拒绝也只 warn（[vendor/hmr/src/index.ts:305-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L305-L316)）
- 任务结束后清掉 `running` 并从待结算任务集合中移除，任务在此期间被登记进该集合（[vendor/hmr/src/index.ts:318-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L318-L323)）
- `getOuterStack` 返回空数组，使重载产生的插件注册不带热替换自身的调用栈（[vendor/hmr/src/index.ts:326-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L326-L329)）
- `getLinked` 从 `loadCache` 取模块作业并返回其直接依赖的 URL 列表，缺失时返回空数组（[vendor/hmr/src/index.ts:331-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L331-L336)）
- `analyzeChanges` 以暂存变更为初始 accepted、以 externals 为初始 declined（[vendor/hmr/src/index.ts:345-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L345-L351)）
- 从暂存文件的直接依赖出发建待定队列，跳过已分类与 `node:`/`node_modules` 模块（[vendor/hmr/src/index.ts:353-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L353-L359)）
- 反复遍历待定队列：命中已接受依赖则归入 accepted，全部依赖均被拒则归入 declined，否则把未知依赖入队；一轮无变化即停（[vendor/hmr/src/index.ts:361-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L361-L393)）
- 收敛后仍未定的文件一律归入 declined（[vendor/hmr/src/index.ts:395-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L395-L397)）
- `partialReload` 先跑一次分类，再按每棵条目树的 baseUrl 汇总其下所有条目的插件名（[vendor/hmr/src/index.ts:400-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L400-L411)）
- 逐个把插件名解析成 URL，跳过 declined，取出模块作业与解包后的插件对象加入待选集，并把入口自身标为 declined；解析异常只 warn（[vendor/hmr/src/index.ts:413-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L413-L428)）
- 对每个待选插件展开其依赖树，只有依赖中含 accepted 文件才登记为重载对象，并把这些依赖并入 accepted、连同当前 runtime 一起记录（[vendor/hmr/src/index.ts:430-443](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L430-L443)）
- 对全部 accepted 文件同时备份并清除 ESM `loadCache`（直接用 `Map.prototype` 方法确保真删）与 CJS `require.cache`，非 file URL 的清除失败被吞掉（[vendor/hmr/src/index.ts:461-480](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L461-L480)）
- `rollback` 把两套缓存的备份写回（[vendor/hmr/src/index.ts:482-489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L482-L489)）
- 逐个重新 import 待重载插件入口；任一失败即输出错误并回滚缓存后直接返回，不动已挂载的插件（[vendor/hmr/src/index.ts:491-500](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L491-L500)）
- `reload` 对旧 runtime 的每个 fiber 用新插件在原父上下文重新注册，并把 entry 与新 fiber 互相接回（[vendor/hmr/src/index.ts:502-509](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L502-L509)）
- 逐个插件先 `registry.delete` 旧实现（失败只 warn）再挂新实现并打 reload 日志，挂载失败则 warn 后抛出（[vendor/hmr/src/index.ts:511-531](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L511-L531)）
- 挂载阶段抛错时回滚缓存，并把已挂上的新插件逐个删除、重新挂回旧插件后返回（[vendor/hmr/src/index.ts:532-545](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L532-L545)）
- 全部成功后发出 `hmr/reload` 事件并清空暂存变更集合（[vendor/hmr/src/index.ts:547-548](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L547-L548)）
- 配置模式给出默认值：`root` 默认 `['.']`，`ignored` 默认排除 `**/node_modules`、`**/.*`、`cache`、`data`，`debounce` 默认 100 毫秒（[vendor/hmr/src/index.ts:560-570](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L560-L570)）

### vendor/hmr/tsconfig.json

该包的 TypeScript 编译配置，供仓库构建与类型检查使用。

- 无运行期机制
