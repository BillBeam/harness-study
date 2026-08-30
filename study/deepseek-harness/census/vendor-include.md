---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · vendor/include
---

# vendor/include

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 4 个文件、44 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### vendor/include/README.md

文件支撑的条目树插件的包说明，给出挂载用法、示例 YAML 与配置字段表。

- 无运行期机制

### vendor/include/package.json

该包的 npm 清单，声明入口、导出映射、发布文件集合与依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定按包名导入时加载的运行期文件（[vendor/include/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/package.json#L14-L15)）
- `exports` 把 `.` 解析到 `lib/index.js`，并开放 `./src/*` 与 `./package.json`（[vendor/include/package.json:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/package.json#L16-L23)）
- `files` 限定发布产物为 `lib/index.js`、类型声明与 `src`（[vendor/include/package.json:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/package.json#L24-L29)）

### vendor/include/src/index.ts

把一个 YAML/JSON 文件读成条目树并在文件可写时写回的插件实现，同时对外导出该 YAML 方言与补丁函数供配置工具复用。

- 定义 `tag:yaml.org,2002:js` 标量类型：读时构造成 `{ __jsExpr }` 节点，写回时还原为原始字符串（[vendor/include/src/index.ts:9-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L9-L15)）
- 导出以 `JSON_SCHEMA` 扩展该标量得到的条目表方言，解析与序列化都走它（[vendor/include/src/index.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L23-L25)）
- 以扩展名到 MIME 的映射确定可写格式，未列入的扩展名不被支持（[vendor/include/src/index.ts:27-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L27-L33)）
- 写回重试上限 10 次、基础间隔 50 毫秒，且只对 `EACCES`/`EBUSY`/`EPERM` 判定为可重试（[vendor/include/src/index.ts:35-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L35-L41)）
- `applyEntryPatches` 先 `structuredClone` 输入，使返回结果与缓存的解析结果完全脱离（[vendor/include/src/index.ts:58-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L58-L64)）
- 递归索引所有带 `id` 的条目，包括 `group` 条目 `config` 数组里的子行（[vendor/include/src/index.ts:66-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L66-L75)）
- 带 `id` 的 insert 补丁在目标不存在或目标不是组时 warn 并跳过，否则把新行追加进该组的 `config`（[vendor/include/src/index.ts:80-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L80-L92)）
- 不带 `id` 的 insert 补丁把新行追加到顶层条目表（[vendor/include/src/index.ts:93-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L93-L95)）
- 插入后立刻把新行也索引进 id 映射，使同一补丁表中靠后的补丁能命中前面插入的行（[vendor/include/src/index.ts:96-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L96-L102)）
- 非 insert 补丁缺 `id` 时 warn 并跳过（[vendor/include/src/index.ts:105-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L105-L108)）
- `id` 在条目表中不存在时 warn 并跳过（[vendor/include/src/index.ts:110-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L110-L114)）
- 补丁声明的 `name` 与目标条目的 `name` 不一致时 warn 并跳过（[vendor/include/src/index.ts:116-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L116-L119)）
- 其余键逐个覆盖到目标条目上，`id` 键被排除（[vendor/include/src/index.ts:121-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L121-L124)）
- `ConfigFileError` 携带 `read`/`parse`/`validate` 阶段标记与原因，供上层区分处理（[vendor/include/src/index.ts:137-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L137-L142)）
- 该条目树声明依赖 `loader` 服务（[vendor/include/src/index.ts:174-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L174-L175)）
- 以组标记符号标注自身，使 loader 的 `internal/config` 插值对本插件的 config 保持字面、不提前求值嵌套行里的 `!!js`（[vendor/include/src/index.ts:177-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L177-L182)）
- 构造时 `enableLogs` 依次取自身配置、父树设置、否则 false（[vendor/include/src/index.ts:196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L196)）
- 文件路径由 `config.path` 相对 `ctx.baseUrl` 解析，扩展名不在支持集合中即抛错（[vendor/include/src/index.ts:197-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L197-L201)）
- 依扩展名确定序列化类型，无类型即视为只读（[vendor/include/src/index.ts:202-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L202-L203)）
- 把子树的 `ctx.baseUrl` 改写为配置文件所在目录，使其中的相对插件名相对该文件解析（[vendor/include/src/index.ts:204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L204)）
- 监听 `internal/update`：`path` 未变时入队用新补丁表对已缓存数据重放并更新子树，随后替换生效配置（[vendor/include/src/index.ts:206-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L206-L213)）
- `enqueue` 把每次子树变更串到上一次之后，前驱失败不阻断后继（[vendor/include/src/index.ts:225-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L225-L229)）
- `checkAccess` 以 `W_OK` 探测文件，失败即把该树切成只读（[vendor/include/src/index.ts:231-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L231-L238)）
- `read` 读文件失败时抛 `read` 阶段错误（[vendor/include/src/index.ts:240-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L240-L246)）
- 非强制读取时内容与上次一致就直接返回空，跳过后续解析与应用（[vendor/include/src/index.ts:247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L247)）
- 按类型分别走带方言的 `yaml.load`、`JSON.parse` 或动态 `import`，解析异常抛 `parse` 阶段错误（[vendor/include/src/index.ts:248-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L248-L260)）
- 顶层不是数组时抛 `validate` 阶段错误（[vendor/include/src/index.ts:261-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L261-L263)）
- 补丁跳过告警统一打到根上下文的 loader 日志器（[vendor/include/src/index.ts:267-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L267-L271)）
- 初始化强制读一次；只有 `read` 阶段的 `ENOENT` 且配置了 `initial` 才写出初始条目表再重读，否则原样抛出或报文件不存在（[vendor/include/src/index.ts:273-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L273-L285)）
- 初始化 yield 卸载函数后才应用首次读到的条目表（[vendor/include/src/index.ts:287-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L287-L288)）
- `stop` 先停掉整棵子树再把挂起的写回刷完（[vendor/include/src/index.ts:291-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L291-L294)）
- `refresh` 把重读放进队列内执行，使内容比较对齐前驱已提交的状态，内容未变则不动子树（[vendor/include/src/index.ts:301-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L301-L309)）
- `_apply` 先打补丁再事务式更新子树，成功后才记下新内容与新数据并复查写权限（[vendor/include/src/index.ts:311-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L311-L321)）
- 只读状态下写回直接抛错（[vendor/include/src/index.ts:323-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L323-L326)）
- 按类型把条目表序列化成 YAML（带方言）或两空格缩进 JSON（[vendor/include/src/index.ts:327-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L327-L331)）
- 写回先落到 `.tmp` 再 rename，遇可重试错误按 `(retry+1)*50ms` 递增退避，超过上限抛出（[vendor/include/src/index.ts:332-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L332-L341)）
- `writeFile` 取消上一次挂起的定时器并只保留最新一份待写数据，在下一个 tick 触发刷写（[vendor/include/src/index.ts:344-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L344-L350)）
- `flushWrite` 把实际写入串到写队列上（前驱成功失败都续跑），无待写数据时返回当前队列，失败时 warn 文件名与错误（[vendor/include/src/index.ts:352-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L352-L368)）
- `write()` 发出 `loader/config-update` 事件并调度把当前根条目数据写回文件（[vendor/include/src/index.ts:370-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/include/src/index.ts#L370-L374)）

### vendor/include/tsconfig.json

该包的 TypeScript 编译配置，供仓库构建与类型检查使用。

- 无运行期机制
