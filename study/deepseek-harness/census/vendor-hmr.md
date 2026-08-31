---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/hmr
---

# vendor/hmr

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、58 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/hmr/README.md

该包的说明文档，描述监视、模块图追踪、缓存清除与整体重启的回退路径，并列出配置字段与两个事件。

- 无运行期机制

### vendor/hmr/package.json

该包的发布清单，供包管理器与运行期模块解析读取。

- `exports` 把包名解析到 `lib/index.js`，`main`/`types` 给出同一入口（[vendor/hmr/package.json:14-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/package.json#L14-L23)）
- `files` 限定发布进包的内容为 `lib/index.js`、类型声明与 `src`（[vendor/hmr/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/package.json#L24-L29)）
- 清单内的框架元数据声明该插件必需 `timer` 服务（[vendor/hmr/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/package.json#L32-L42)）

### vendor/hmr/src/error.ts

热替换重新导入失败时的日志渲染入口，被 `src/index.ts` 的部分重载路径调用。

- 依据 `errors` 数组及其每项是否有 `text` 判定是否为构建失败对象（[vendor/hmr/src/error.ts:6-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L6-L8)）
- 非构建失败对象直接以 warn 级别输出原始异常并返回（[vendor/hmr/src/error.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L12-L15)）
- 没有源码位置的错误只输出其文本（[vendor/hmr/src/error.ts:17-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L17-L20)）
- 有位置的错误读取源文件并输出带高亮代码框与 `文件:行:列` 前缀的日志（[vendor/hmr/src/error.ts:22-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L22-L31)）
- 读文件或生成代码框本身失败时改为输出该异常（[vendor/hmr/src/error.ts:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/error.ts#L32-L34)）

### vendor/hmr/src/index.ts

热替换服务的实现：监视文件、划分可重载与不可重载的模块、清缓存重新导入并替换插件，或触发整进程退出。

- `loadDependencies` 递归遍历模块 job 的 `linked`，跳过已访问、被忽略、`node:` 前缀与 `/node_modules/` 路径（[vendor/hmr/src/index.ts:37-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L37-L48)）
- `findWatchRoot` 沿父目录上溯到最近存在的目录，取其真实路径，再拼回缺失的相对后缀并记录上溯深度（[vendor/hmr/src/index.ts:64-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L64-L84)）
- 服务声明注入 `loader` 与 `timer`，两者就绪前不启动（[vendor/hmr/src/index.ts:87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L87)）
- 构造时加载器缺少内部模块加载器则抛错，服务不成立（[vendor/hmr/src/index.ts:120-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L120-L123)）
- 基准目录由 `config.base` 相对 `ctx.baseUrl` 解析（[vendor/hmr/src/index.ts:124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L124)）
- `registerConfig` 在主监视器未建立时抛错（[vendor/hmr/src/index.ts:135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L135)）
- 同一规范化路径重复注册时抛错（[vendor/hmr/src/index.ts:136-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L136-L139)）
- 对该祖先目录开监视器，深度限制为上溯层数，清空 `cwd` 与 `ignored`，并且不跳过初始扫描（[vendor/hmr/src/index.ts:142-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L142-L148)）
- 只有路径等于请求名或规范化名的 add/change/unlink 才触发刷新（[vendor/hmr/src/index.ts:151-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L151-L158)）
- 就绪前的第一个错误使注册失败，就绪后的错误只记 warn（[vendor/hmr/src/index.ts:160-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L160-L173)）
- 注册成功返回的 disposer 摘除注册项、关闭监视器并等待进行中的刷新完成（[vendor/hmr/src/index.ts:177-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L177-L181)）
- 注册失败时删除登记并关闭监视器后再抛出（[vendor/hmr/src/index.ts:182-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L182-L186)）
- `_resolve` 按内部加载器版本分派到 v1 的异步 `resolve` 或 v2 的 `resolveSync`（[vendor/hmr/src/index.ts:192-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L192-L197)）
- 服务初始化先让出 disposer：关闭主监视器与全部配置监视器、清空登记、等待所有刷新任务结束（[vendor/hmr/src/index.ts:199-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L199-L205)）
- 启动时按是否配置了 base 打印不同的监视日志（[vendor/hmr/src/index.ts:208-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L208-L213)）
- 打开监视器之前先从 `process.argv[1]` 对应的模块 job 收集 externals 依赖集合，取不到时为空集（[vendor/hmr/src/index.ts:218-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L218-L226)）
- 主监视器以真实基准目录为 `cwd`，用 picomatch 对相对路径做忽略匹配，并跳过初始扫描（[vendor/hmr/src/index.ts:228-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L228-L240)）
- 部分重载被按配置毫秒数去抖（[vendor/hmr/src/index.ts:242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L242)）
- 变更路径若匹配某个加载器条目的子树配置文件，转为该子树刷新并结束本次处理（[vendor/hmr/src/index.ts:248-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L248-L254)）
- 非 change 事件在配置文件分支之后被丢弃（[vendor/hmr/src/index.ts:256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L256)）
- 变更文件属于 externals 时调用 `loader.exit()`（[vendor/hmr/src/index.ts:259-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L259-L260)）
- 变更文件在模块加载缓存中时入栈并触发去抖的部分重载（[vendor/hmr/src/index.ts:265-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L265-L268)）
- 其余变更以 `hmr/change` 事件对外发出（[vendor/hmr/src/index.ts:270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L270)）
- 监视根为空时直接视作就绪，否则等 ready；就绪前的错误使初始化失败，之后只记 warn（[vendor/hmr/src/index.ts:276-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L276-L294)）
- `refreshConfig` 按 key 维护 dirty 标志，已有任务在跑时只置脏而不并发（[vendor/hmr/src/index.ts:297-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L297-L301)）
- 刷新任务在循环中反复执行直到 dirty 不再被置起（[vendor/hmr/src/index.ts:302-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L302-L317)）
- 刷新失败时把非 Error 包成 Error、打两条 warn，并以 parallel 发出 `hmr/config-update-failed`；监听器抛出也只记 warn（[vendor/hmr/src/index.ts:307-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L307-L316)）
- 刷新任务登记到集合并在结束时摘除，供停机等待（[vendor/hmr/src/index.ts:318-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L318-L323)）
- `getOuterStack` 返回空数组，重载注册的插件不带热替换自身的栈帧（[vendor/hmr/src/index.ts:326-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L326-L329)）
- `getLinked` 从加载缓存取 job 并返回其直接依赖的 url 列表，缓存缺失时返回空（[vendor/hmr/src/index.ts:331-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L331-L336)）
- 分类以已入栈文件为初始 accepted、以 externals 为初始 declined（[vendor/hmr/src/index.ts:348-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L348-L349)）
- `node:` 与 `/node_modules/` 的 url 在分类中被整体排除（[vendor/hmr/src/index.ts:351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L351)）
- 从入栈文件的直接依赖出发建立待定队列（[vendor/hmr/src/index.ts:353-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L353-L359)）
- 迭代传播：任一依赖已 accepted 则该文件 accepted，全部依赖 declined 则该文件 declined，未定的依赖继续入队，无进展即停（[vendor/hmr/src/index.ts:361-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L361-L393)）
- 循环结束后仍未定的文件一律归入 declined（[vendor/hmr/src/index.ts:395-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L395-L397)）
- 部分重载先按各子树 baseUrl 汇总其条目声明的插件名集合（[vendor/hmr/src/index.ts:408-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L408-L411)）
- 逐个插件名解析成 url，跳过 declined，取出模块 job 与解包后的插件对象，登记为候选并标记为 declined；解析失败只记 warn（[vendor/hmr/src/index.ts:414-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L414-L428)）
- 候选插件的依赖树中若无 accepted 文件则跳过，否则把整棵依赖并入 accepted，并连同当前运行时一起记入重载表（[vendor/hmr/src/index.ts:431-443](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L431-L443)）
- 对每个 accepted 文件备份并删除 ESM 加载缓存条目，用 `Map.prototype` 方法绕过版本差异（[vendor/hmr/src/index.ts:461-469](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L461-L469)）
- 同时备份并删除对应的 CJS require 缓存条目，非文件 url 的转换失败被吞掉（[vendor/hmr/src/index.ts:470-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L470-L479)）
- `rollback` 把两套缓存条目按备份写回（[vendor/hmr/src/index.ts:482-489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L482-L489)）
- 逐个重新导入待重载入口；任一失败即打印代码框并回滚缓存后直接返回，不动运行中的插件（[vendor/hmr/src/index.ts:492-500](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L492-L500)）
- `reload` 对旧运行时的每个 fiber 用原配置重新注册插件，并把 entry 关联转移到新 fiber（[vendor/hmr/src/index.ts:502-509](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L502-L509)）
- 替换阶段先从注册表删除旧插件（失败只记 warn），再注册新导入的插件并打 reload 日志（[vendor/hmr/src/index.ts:511-531](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L511-L531)）
- 替换阶段抛出时回滚缓存，并逐个删除新插件、重新注册旧插件后返回（[vendor/hmr/src/index.ts:532-545](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L532-L545)）
- 全部替换成功后发出 `hmr/reload` 事件并清空入栈集合（[vendor/hmr/src/index.ts:547-548](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L547-L548)）
- 配置 schema 给出监视根默认 `['.']`、忽略模式默认列表与去抖默认 100 毫秒（[vendor/hmr/src/index.ts:560-570](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L560-L570)）
- 本地改动去掉了 schema 上的国际化调用与对应的 YAML 语言文件导入（[vendor/hmr/src/index.ts:571-573](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/hmr/src/index.ts#L571-L573)）

### vendor/hmr/tsconfig.json

该包的 TypeScript 编译配置，只在构建与类型检查时使用。

- 无运行期机制
