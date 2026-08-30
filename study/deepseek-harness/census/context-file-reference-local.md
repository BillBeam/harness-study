---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/context/file-reference-local
---

# packages/context/file-reference-local

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、37 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/context/file-reference-local/README.md

这是本地文件引用提供者的英文说明文档，介绍配置字段、索引失效策略与模型可见的一句提示。

- 无运行期机制

### packages/context/file-reference-local/package.json

这是该提供者包的 npm 清单，声明入口、子路径导出、发布产物与依赖。

- `main`/`types` 把裸包名导入解析到 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/context/file-reference-local/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/package.json#L14-L15)）
- `exports` 开放 `.`、`./search`、`./invariant`、`./src/*`、`./package.json`，其中 `./search` 指向 `lib/types` 下的运行时 `.js`（[packages/context/file-reference-local/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/package.json#L16-L31)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 以及 `lib/types` 下的 `.js` 与 `.d.ts`（[packages/context/file-reference-local/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/package.json#L32-L37)）
- `dependencies` 引入 schema 库，运行期用于该服务的配置校验与默认值填充（[packages/context/file-reference-local/package.json:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/package.json#L39-L41)）

### packages/context/file-reference-local/src/index.ts

这是本地文件引用服务的实现入口，负责配置校验、按 agent 维护搜索索引、挂载系统提示段并实现 `list`。

- 声明注入 `agents` 服务，服务在该依赖就绪后才装载（[packages/context/file-reference-local/src/index.ts:46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L46)）
- 配置 schema 给 `maxResults`、`maxEntries`、`excludedDirectories` 三项填默认值，并要求前两项为不小于 1 的整数（[packages/context/file-reference-local/src/index.ts:47-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L47-L51)）
- 构造时合并默认值后立刻做一次校验，非法配置在装载阶段抛错（[packages/context/file-reference-local/src/index.ts:58-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L58-L65)）
- 为每个 agent 装一个提示纤程，向系统提示注册 `context:file-reference` 段，其文本在该 agent 取不到 `read` 工具时为空串、取得到时为固定的引用提示（[packages/context/file-reference-local/src/index.ts:67-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L67-L77)）
- 提示纤程的销毁异步进行，失败降级为一条 warn 日志，并把在途销毁登记到集合里供整体卸载时等待（[packages/context/file-reference-local/src/index.ts:78-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L78-L89)）
- 装载时为已存在的 agent 补装提示段，之后由 `agent/created` 事件补装新 agent（[packages/context/file-reference-local/src/index.ts:90-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L90-L91)）
- `agent/disposed` 时销毁并移除该 agent 的搜索索引与提示纤程（[packages/context/file-reference-local/src/index.ts:92-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L92-L96)）
- 每条 `tool/result` 会话事件都把对应 agent 的索引标记为过期（[packages/context/file-reference-local/src/index.ts:97-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L97-L101)）
- 服务卸载时销毁全部索引、清空索引表，并等待所有提示纤程连同在途销毁完成（[packages/context/file-reference-local/src/index.ts:102-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L102-L111)）
- `list` 按 agent 惰性创建搜索器，根目录取会话 cwd，缺失时退回宿主进程工作目录（[packages/context/file-reference-local/src/index.ts:114-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L114-L125)）
- `validateConfig` 对非正整数上限与含 `/`、`\` 或空串的排除目录名分别抛出带包名前缀的错误（[packages/context/file-reference-local/src/index.ts:128-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L128-L138)）
- 默认导出服务类，决定 Loader 以服务插件形式装载本包（[packages/context/file-reference-local/src/index.ts:140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/index.ts#L140)）

### packages/context/file-reference-local/src/invariant.ts

这是本包的不变式伴生插件，注入 `invariants` 服务后以包名占位。

- `apply` 以包名向不变式注册表登记一个空安装器并返回其 disposer（[packages/context/file-reference-local/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/invariant.ts#L28-L29)）

### packages/context/file-reference-local/src/search.ts

这是工作区路径索引与排序模块，`WorkspaceFileSearch` 为每个 agent 维护一份有界索引并回答补全查询。

- 默认值把单次返回上限定为 20、单工作区索引条目上限定为 50000（[packages/context/file-reference-local/src/search.ts:16-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L16-L18)）
- 默认排除目录名列出 `.git`、`node_modules`、`dist` 等 15 个基名，它们既不被遍历也不作为候选出现（[packages/context/file-reference-local/src/search.ts:31-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L31-L47)）
- 构造函数对非正整数上限与非法排除名抛错，并把排除名建成集合（[packages/context/file-reference-local/src/search.ts:96-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L96-L105)）
- `list` 先响应中止信号、已销毁时返回空数组，把反斜杠统一成 `/`；空查询或含 `/` 的查询走目录直列，其余走共享索引加过滤与打分（[packages/context/file-reference-local/src/search.ts:114-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L114-L130)）
- `invalidate` 只把单调失效计数加一，旧条目继续对外应答（[packages/context/file-reference-local/src/search.ts:139-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L139-L141)）
- `dispose` 中止在途遍历、丢弃已完成索引，之后的查询一律返回空（[packages/context/file-reference-local/src/search.ts:144-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L144-L150)）
- `indexFor` 只让工作区的第一次查询等待遍历；已有索引但落后于失效计数时立即返回旧条目并在后台重建，后台失败被吞掉以便下次重试（[packages/context/file-reference-local/src/search.ts:159-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L159-L170)）
- `ensureIndex` 同时只保留一代在途遍历，记录发起时的失效计数，成功后发布为已完成索引（已销毁则不发布），失败时清掉该代并把错误抛给调用者（[packages/context/file-reference-local/src/search.ts:172-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L172-L199)）
- `scanWorkspace` 以队列做广度遍历，条目数达到 `maxEntries` 即停；排除名目录不入队也不作候选；根目录读失败让整次遍历失败，子目录读失败只损失该子树（[packages/context/file-reference-local/src/search.ts:201-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L201-L232)）
- `listDirectory` 对路径中含排除名的查询直接返回空，解析目录失败也返回空；列目录时在片段不以 `.` 开头时隐藏点开头条目，排除名目录不列出，最后按片段排序截到 `maxResults`（[packages/context/file-reference-local/src/search.ts:234-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L234-L254)）
- `resolveDisplayDirectory` 拒绝走出根目录的相对路径与绝对路径，并逐段 `lstat`，遇到符号链接或非目录即拒绝（[packages/context/file-reference-local/src/search.ts:257-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L257-L282)）
- 根目录读取按名字排序且不吞异常（[packages/context/file-reference-local/src/search.ts:284-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L284-L289)）
- 子目录读取按名字排序，读失败返回空数组使该子树不贡献候选（[packages/context/file-reference-local/src/search.ts:291-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L291-L303)）
- `visibleForGlobalQuery` 在查询不以 `.` 开头且不含 `/.` 时，滤掉任意路径段以 `.` 开头的候选（[packages/context/file-reference-local/src/search.ts:305-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L305-L308)）
- `rankCandidates` 丢掉无分候选，按分数降序、目录优先、路径长度、字典序四级排序后截到上限（[packages/context/file-reference-local/src/search.ts:310-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L310-L326)）
- `scoreCandidate` 大小写不敏感地给出基名全等 1000、基名前缀 900、基名包含 700、路径包含 500、子序列 300 加匹配分，目录再加 25；空查询一律 0 分（[packages/context/file-reference-local/src/search.ts:328-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L328-L340)）
- `subsequenceScore` 按字符顺序匹配，累计跳过的间隔并以 100 减去间隔为分，匹配不上返回 undefined（[packages/context/file-reference-local/src/search.ts:342-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L342-L352)）
- `waitForPromise` 让单个调用方的中止只拒绝它自己的等待，而不影响共享的遍历（[packages/context/file-reference-local/src/search.ts:364-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/file-reference-local/src/search.ts#L364-L381)）

### packages/context/file-reference-local/tsconfig.json

这是本包的 TypeScript 编译配置，声明 rootDir、outDir 与工作区项目引用。

- 无运行期机制
