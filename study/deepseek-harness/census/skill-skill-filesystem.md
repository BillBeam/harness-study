---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/skill/skill-filesystem
---

# packages/skill/skill-filesystem

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、65 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/skill/skill-filesystem/README.md

本地文件系统技能提供方的英文说明文档，描述技能格式、根目录优先级、配置项与变更检测行为。

- 无运行期机制

### packages/skill/skill-filesystem/package.json

该包的 npm 清单，声明入口、导出子路径、发布文件集与运行期依赖。

- `main`/`types` 与 `exports` 把包名解析到 `lib/index.js`，`./invariant` 解析到 `lib/invariant.js`，并暴露 `./src/*`（[packages/skill/skill-filesystem/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/package.json#L14-L27)）
- `files` 限定发布产物为两个 lib 入口与类型声明（[packages/skill/skill-filesystem/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/package.json#L28-L32)）
- `dependencies` 声明运行期需要 chokidar 与 yaml 两个第三方库（[packages/skill/skill-filesystem/package.json:41-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/package.json#L41-L45)）

### packages/skill/skill-filesystem/src/index.ts

本地技能提供方的实现文件：向 `ctx.skills` 注册一个按项目/自定义/用户根目录发现磁盘技能的提供方，并自带文件监视与失效逻辑。

- rank 常量把项目 `.dsh`、项目 `.agents`、自定义、用户 `.dsh`、用户 `.agents` 五类根固定为 100/200/300/400/500（[packages/skill/skill-filesystem/src/index.ts:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L36-L40)）
- 监视默认值固定为稳定窗口 200ms、轮询间隔 100ms、最多 128 个项目根（[packages/skill/skill-filesystem/src/index.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L41-L43)）
- 导出 `name` 与 `inject`，使插件以 `skill-filesystem` 名加载并要求 `skills` 服务先就绪（[packages/skill/skill-filesystem/src/index.ts:45-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L45-L46)）
- `Config` schema 给出各字段默认：提供方名 `filesystem`、包含默认根、自定义根为空、开启监视、不用轮询、以及三个时间/数量默认与跟随符号链接（[packages/skill/skill-filesystem/src/index.ts:76-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L76-L89)）
- `apply` 注册提供方、用 `ctx.effect` 把监视器关闭挂到 fiber 拆卸上（[packages/skill/skill-filesystem/src/index.ts:130-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L130-L138)）
- `apply` 监听 `fs/observed`，仅当发起者是 `edit` 或 `write` 工具时才把该路径交给提供方判定是否失效（[packages/skill/skill-filesystem/src/index.ts:139-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L139-L142)）
- 构造函数解析 dshHome、从 `DSH_AGENTS_HOME` 或 `~/.agents` 解析 agentsHome、把自定义根逐个绝对化（[packages/skill/skill-filesystem/src/index.ts:161-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L161-L165)）
- 注册生命周期信号 abort 时触发提供方 dispose（[packages/skill/skill-filesystem/src/index.ts:167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L167)）
- 打包根只有在显式配置、或在包含默认根时才从 `DSH_BUNDLED_SKILL_DIR` 取值（[packages/skill/skill-filesystem/src/index.ts:171-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L171-L173)）
- `list()` 先让监视管理器接管本次根集合；接管失败且尚未 dispose 时把结果降级为 `complete: false` 的观察而不是抛错（[packages/skill/skill-filesystem/src/index.ts:182-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L182-L197)）
- `get()` 按候选 locator 重新解析文件，返回带 directory 资源基目录、绝对路径与可选 metadata 的定义；文件消失则返回 undefined（[packages/skill/skill-filesystem/src/index.ts:206-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L206-L222)）
- `dispose()` 用 `??=` 记忆化，使多次调用共享同一次关闭过程（[packages/skill/skill-filesystem/src/index.ts:236-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L236-L239)）
- `roots()` 按顺序拼出项目两根、自定义根、用户两根与打包根，其中用户 `.dsh` 根带 `skipSystem`、打包根带 `trustedHost` 并取 rank 600（[packages/skill/skill-filesystem/src/index.ts:241-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L241-L261)）
- `observeRoots` 按 owner 归属保留各根的监视，项目根以 `project:` 前缀成组、共享根以 `shared:` 前缀（[packages/skill/skill-filesystem/src/index.ts:297-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L297-L316)）
- 项目数超过上限时逐个淘汰最早的项目并释放其根，发生淘汰后触发一次失效（[packages/skill/skill-filesystem/src/index.ts:317-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L317-L329)）
- `observeHostMutation` 把路径绝对化后，只有落在某个已保留根的可能技能路径上才触发失效（[packages/skill/skill-filesystem/src/index.ts:332-337](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L332-L337)）
- `dispose` 置 closing、abort 生命周期、清空根与项目表，并等待每个正在打开的监视器落定后再关闭（[packages/skill/skill-filesystem/src/index.ts:339-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L339-L351)）
- `retainRoot` 新建状态时初始标记 unhealthy，且只有在监视启用时才真正开监视器（[packages/skill/skill-filesystem/src/index.ts:353-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L353-L361)）
- `releaseRoot` 只有在最后一个 owner 释放后才移除并关闭该根的监视器（[packages/skill/skill-filesystem/src/index.ts:363-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L363-L374)）
- `ensureWatcher` 用 `opening` 字段合并并发打开请求，并在关闭中或监视禁用时直接返回（[packages/skill/skill-filesystem/src/index.ts:376-391](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L376-L391)）
- `ensureCurrentWatcher` 重新探测根的当前监视模式，模式变化或句柄不健康时才替换（[packages/skill/skill-filesystem/src/index.ts:393-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L393-L403)）
- `replaceWatcher` 先关旧句柄；打开成功后若已进入关闭或已无 owner 则立即关掉新句柄；失败则标 unhealthy、打警告并抛出（[packages/skill/skill-filesystem/src/index.ts:405-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L405-L432)）
- `openStableWatcher` 在开监视器前后各探测一次路径模式，两次不一致就关掉重来（[packages/skill/skill-filesystem/src/index.ts:436-450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L436-L450)）
- 根不存在时用 `watchFile` 以配置的轮询间隔盯住最近存在祖先下的下一段路径，且以非 persistent 方式注册（[packages/skill/skill-filesystem/src/index.ts:452-466](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L452-L466)）
- 祖先轮询命中后若模式确已变化，则排队一次失效、标 unhealthy 并安排重新挂监视（[packages/skill/skill-filesystem/src/index.ts:468-485](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L468-L485)）
- 根存在时用 chokidar 以 depth 1、忽略初始事件、原子写合并与稳定窗口/轮询间隔打开监视（[packages/skill/skill-filesystem/src/index.ts:487-502](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L487-L502)）
- 打开过程与生命周期 abort 竞速：ready 前的错误使打开失败，ready 后的错误走错误处理；无论成败都摘除 abort 监听（[packages/skill/skill-filesystem/src/index.ts:507-539](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L507-L539)）
- 五类文件事件统一进入 `handleWatchEvent`，经相关性过滤后排队失效；根目录自身被删除时额外标 unhealthy 并安排重挂（[packages/skill/skill-filesystem/src/index.ts:528-555](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L528-L555)）
- 监视器运行期错误打警告、标 unhealthy、排队失效并安排重挂（[packages/skill/skill-filesystem/src/index.ts:557-563](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L557-L563)）
- `scheduleRewatch` 等待当前打开过程落定后重挂，成功才排队失效，失败则静默留给下次不完整发现重试（[packages/skill/skill-filesystem/src/index.ts:565-577](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L565-L577)）
- `queueInvalidation` 用微任务把一批事件合并成一次 `invalidate()`，关闭中不再发出（[packages/skill/skill-filesystem/src/index.ts:579-588](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L579-L588)）
- `closeWatcher` 把关闭失败降级为警告，不向外抛（[packages/skill/skill-filesystem/src/index.ts:590-596](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L590-L596)）
- `resolveWatchConfig` 断言三个数值配置为正整数，否则抛错阻止挂载（[packages/skill/skill-filesystem/src/index.ts:608-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L608-L623)）
- `resolveRootWatchMode` 从根路径逐级上溯到最近存在的目录：命中根本身返回 root 模式并按需规范化路径，否则返回锚点加下一段缺失路径的 ancestor 模式（[packages/skill/skill-filesystem/src/index.ts:625-650](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L625-L650)）
- `isRelevantWatchEvent` 规定只有根自身的目录增删、根下一层的目录增删与 `.md` 文件、以及第二层的 `SKILL.md` 增删改才算相关事件，其余（含资源子树）被忽略（[packages/skill/skill-filesystem/src/index.ts:658-675](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L658-L675)）
- `isPotentialSkillPath` 用同一层级规则判定一次首方写入是否可能影响技能，并对带 `skipSystem` 的根排除 `.system`（[packages/skill/skill-filesystem/src/index.ts:677-684](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L677-L684)）
- `containedSegments` 用相对路径判定包含关系，越界或绝对路径返回 undefined（[packages/skill/skill-filesystem/src/index.ts:686-691](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L686-L691)）
- `mutationToolName` 只认 `edit` 与 `write` 两个发起者名（[packages/skill/skill-filesystem/src/index.ts:693-697](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L693-L697)）
- 缺失路径的判定统一为 ENOENT/ENOTDIR，并在技能读写路径上额外接受 `FS_NOT_FOUND` 与 `FS_NOT_DIRECTORY`（[packages/skill/skill-filesystem/src/index.ts:705-717](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L705-L717)）
- `discoverRoot` 把根下条目按名排序后逐个处理，`skipSystem` 根跳过 `.system`，目录取 `<name>/SKILL.md`、文件取顶层 `.md`，其余类型跳过（[packages/skill/skill-filesystem/src/index.ts:719-731](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L719-L731)）
- 解析成功的技能被组装成带 provider、根来源标签、根 rank、locator、directory 资源基目录与路径的候选（[packages/skill/skill-filesystem/src/index.ts:732-744](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L732-L744)）
- 目录列举优先走 `ctx.fs`，但 `trustedHost` 根改走 Node 原生读取（[packages/skill/skill-filesystem/src/index.ts:749-753](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L749-L753)）
- 经 `ctx.fs` 列举时把确认缺失的根当作空列表，其他错误抛出（[packages/skill/skill-filesystem/src/index.ts:755-762](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L755-L762)）
- Node 原生列举同样把缺失根当作空列表，并对每个条目再判定类型（[packages/skill/skill-filesystem/src/index.ts:773-791](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L773-L791)）
- `parseSkillFile` 依次以警告丢弃：YAML 解析失败、缺 frontmatter、缺 name 或 description、名不合法、invocation 字段非法（[packages/skill/skill-filesystem/src/index.ts:793-826](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L793-L826)）
- 解析结果的正文对首尾空白做 trim 后作为技能体（[packages/skill/skill-filesystem/src/index.ts:827-834](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L827-L834)）
- `optionalFileSystem` 用 `ctx.get('fs')` 做可选服务查询（[packages/skill/skill-filesystem/src/index.ts:837-839](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L837-L839)）
- `readSkillText` 在有 fs 服务且非 trustedHost 时走服务读取，否则走带 signal 的 Node `readFile`，缺失文件返回 undefined（[packages/skill/skill-filesystem/src/index.ts:841-854](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L841-L854)）
- 经 fs 服务读取时逐步 resolve、stat、readText，非 file 类型直接跳过，`FS_NOT_TEXT` 打警告后跳过，其余错误抛出，且每步都重查取消（[packages/skill/skill-filesystem/src/index.ts:856-885](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L856-L885)）
- `nodeEntryKind` 对符号链接再 stat 一次以判定目标是目录还是文件，跟随失败打警告并跳过该条目（[packages/skill/skill-filesystem/src/index.ts:891-907](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L891-L907)）
- `parseFrontmatter` 要求首行恰为 `---`、找到闭合行，并要求 YAML 解析出非数组对象，否则视为无 frontmatter（[packages/skill/skill-filesystem/src/index.ts:909-921](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L909-L921)）
- `findClosingFrontmatter` 逐行扫描并容忍 CRLF 行尾，返回闭合位置与正文起点（[packages/skill/skill-filesystem/src/index.ts:923-935](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L923-L935)）
- `findProjectRoot` 从 cwd 向上找最近含 `.git` 的目录，找不到就退回 cwd（[packages/skill/skill-filesystem/src/index.ts:937-947](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L937-L947)）
- `pathExists` 有 fs 服务时走服务 resolve+stat，resolve 或 stat 抛错都只让该候选不成立并继续上溯；否则走 Node `access`（[packages/skill/skill-filesystem/src/index.ts:949-980](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L949-L980)）
- `stringField` 与 `optionalString` 只接受非空字符串，空串等同缺省（[packages/skill/skill-filesystem/src/index.ts:982-990](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L982-L990)）
- `parseInvocationPolicy` 先拒绝三个旧拼写键，再由 `disable-model-invocation` 与 `user-invocable` 推出两个布尔位，缺省均为放行（[packages/skill/skill-filesystem/src/index.ts:992-1008](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L992-L1008)）
- `frontmatterBoolean` 接受 YAML 布尔、`1`/`0` 以及大小写不敏感的 true/false、yes/no、on/off，其余值抛 TypeError（[packages/skill/skill-filesystem/src/index.ts:1010-1029](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L1010-L1029)）
- `optionalMetadata` 只接受非数组对象作为 metadata 带出，其余取值丢弃（[packages/skill/skill-filesystem/src/index.ts:1031-1037](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/index.ts#L1031-L1037)）

### packages/skill/skill-filesystem/src/invariant.ts

该包的不变量伴生插件，由不变量服务在启动检查时加载。

- 导出 `name` 与 `inject`，使 Cordis 以 `skill-filesystem-invariant` 名加载并要求 `invariants` 服务先就绪（[packages/skill/skill-filesystem/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/invariant.ts#L13-L15)）
- `apply` 以包名注册一个空安装器并返回其 disposer（[packages/skill/skill-filesystem/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/invariant.ts#L21)、[packages/skill/skill-filesystem/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill-filesystem/src/invariant.ts#L28-L29)）

### packages/skill/skill-filesystem/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
