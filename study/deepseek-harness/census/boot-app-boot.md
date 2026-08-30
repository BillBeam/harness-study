---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/boot/app-boot
---

# packages/boot/app-boot

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、100 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/boot/app-boot/README.md

包 README，说明该启动库能做什么、profile 与 patch 层的行为、失败时的输出形态与已知限制。

- 无运行期机制

### packages/boot/app-boot/package.json

包清单，声明模块类型、入口、发布内容与依赖关系。

- `"type": "module"` 使该包以 ESM 方式被加载（[packages/boot/app-boot/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/package.json#L13)）
- `main`/`types`/`exports` 把 `.`、`./invariant`、`./src/*`、`./package.json` 映射到具体产物路径（[packages/boot/app-boot/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/package.json#L14-L27)）
- `files` 限定发布物只含 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/boot/app-boot/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/package.json#L28-L32)）
- `dependencies` 把 js-yaml、resolve.exports 与原子写工具列为运行期依赖（[packages/boot/app-boot/package.json:34-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/package.json#L34-L38)）
- `peerDependenciesMeta` 把 HMR 插件标为可选，使缺少它时安装仍成立（[packages/boot/app-boot/package.json:50-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/package.json#L50-L54)）

### packages/boot/app-boot/src/index.ts

启动辅助函数集合：配置路径解析、环境层加载、fail-loud 守卫、根 include 挂载、激活审计、patch 解析、配置转储与启动后追加提示段。

- `resolveConfigPath` 把相对路径解析为绝对路径，且仅当快照模式为 `replay` 时把 `cordis.yml`/`cordis.yaml` 基名换成 `cordis.snapshot.yml`（[packages/boot/app-boot/src/index.ts:64-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L64-L72)）
- `loadEnv` 调用 `process.loadEnvFile` 应用一个目录的 `.env`，缺文件静默，其他读失败输出一行带前缀的警告（[packages/boot/app-boot/src/index.ts:81-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L81-L93)）
- `BOOTSTRAP_NAMES` 列出被发现文件一律不得设置的变量名，覆盖进程启动、解释器钩子、版本控制钩子与网络信任等类别（[packages/boot/app-boot/src/index.ts:96-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L96-L117)）
- `BOOTSTRAP_PREFIXES` 再按 `DSH_`、`XDG_`、`DYLD_`、`BASH_FUNC_` 前缀扩大该拒绝集（[packages/boot/app-boot/src/index.ts:120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L120)）
- `isBootstrapOnly` 统一转大写后按名字集合与前缀两条规则判定（[packages/boot/app-boot/src/index.ts:128-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L128-L131)）
- `readEnvLayer` 读不到文件时 ENOENT 返回 undefined、其他失败走警告，解析一次后逐名检查并对被拒绝的名字抛出说明性错误（[packages/boot/app-boot/src/index.ts:142-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L142-L167)）
- `loadLayeredEnv` 先解析调用目录与 Harness home 两层再应用，home 与调用目录相同则跳过第二层（[packages/boot/app-boot/src/index.ts:184-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L184-L189)）
- 应用时只填补 `process.env` 中尚未定义的名字，继承环境永远优先（[packages/boot/app-boot/src/index.ts:190-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L190-L195)）
- 返回的环境快照保留每个值来自 process、project-env 还是 user-env 及其文件路径（[packages/boot/app-boot/src/index.ts:196-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L196-L200)）
- 模块级 WeakMap 记住每个上下文挂载的根 include 条目，供后续热更新定位（[packages/boot/app-boot/src/index.ts:203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L203)）
- 用户 patch 文件复用 include 自带的 YAML 方言，`!!js` 标量成为可插值的表达式节点（[packages/boot/app-boot/src/index.ts:210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L210)）
- `watchUserPatches` 在缺少 HMR 服务或根 include 条目时抛出带前缀的错误（[packages/boot/app-boot/src/index.ts:239-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L239-L243)）
- 注册的刷新回调每次重读 include 的非 patch 选项、重新加载用户 patch、经 compose 合成后调用 `entry.update`（[packages/boot/app-boot/src/index.ts:244-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L244-L256)）
- 注册期间若整棵树已被释放（`INACTIVE_EFFECT`），返回空 disposer 而不是失败（[packages/boot/app-boot/src/index.ts:257-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L257-L266)）
- `loadOptionalPatches` 文件不存在时返回 undefined，其他读失败抛出（[packages/boot/app-boot/src/index.ts:280-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L280-L289)）
- `loadOverlayPatches` 对被点名的覆盖文件，缺失同样抛出（[packages/boot/app-boot/src/index.ts:300-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L300-L308)）
- `anchorInsertedPluginNames` 把 `insert` 行里以 `./`、`../` 开头的插件名按 patch 文件所在目录改写成 file URL，并递归进入 group 的子配置（[packages/boot/app-boot/src/index.ts:311-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L311-L321)）
- `parsePatchList` 用该方言解析，解析失败、顶层非数组、任一项非映射都抛出带文件名和序号的错误（[packages/boot/app-boot/src/index.ts:335-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L335-L353)）
- `renderConfigDump` 读取并解析基础配置文件，读失败、解析失败、顶层非数组各自抛出（[packages/boot/app-boot/src/index.ts:400-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L400-L414)）
- 每个前缀快照都把前 k 层 patch 拍平后 `structuredClone` 再交给 `applyEntryPatches`，避免跨快照共享 insert 行（[packages/boot/app-boot/src/index.ts:426-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L426-L434)）
- 逐层比较相邻快照：新增的告警按该层标签输出，位置比较结果记入每行的来源与被哪些层改写（[packages/boot/app-boot/src/index.ts:439-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L439-L455)）
- `groupedDump` 把连续同标签的行归为一段，段前输出 `# ==` 注释再用同一方言 dump（[packages/boot/app-boot/src/index.ts:460-488](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L460-L488)）
- `mountRootInclude` 在给定 `bareModuleBaseUrl` 时用子类替换 `cordis:include` 内建，把裸包名交给 Loader 内部解析器按该基址导入，相对与 `cordis:` 名仍走原路径（[packages/boot/app-boot/src/index.ts:507-519](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L507-L519)）
- 同时把 `cordis:group` 注册为内建，使 group 行不依赖被包含树自身的说明符解析（[packages/boot/app-boot/src/index.ts:525](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L525)）
- 根 include 条目的 id 固定为 `'include'`，配置指向 config 的 file URL 并仅在有 patch 时带上 patches（[packages/boot/app-boot/src/index.ts:529-537](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L529-L537)）
- 创建后若 Loader 服务已随树释放则返回 undefined，否则解析出条目并记入 WeakMap（[packages/boot/app-boot/src/index.ts:538-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L538-L543)）
- 模块级计数表登记已被启动诊断吸收的拒绝原因，并在一个 `setImmediate` 检查点后释放（[packages/boot/app-boot/src/index.ts:565-587](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L565-L587)）
- `FAIL_LOUD_RELEASE_TIMEOUT_MS` 把终端交还的等待上限固定为 2000 毫秒（[packages/boot/app-boot/src/index.ts:593](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L593)）
- `installFailLoud` 注册的 `unhandledRejection` 处理器跳过已被审计吸收的原因，并用闩锁保证只报告第一次拒绝（[packages/boot/app-boot/src/index.ts:629-636](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L629-L636)）
- 先向 stderr 写一行带前缀的致命诊断（含 Error 栈），无 release 时直接 `exit(1)`（[packages/boot/app-boot/src/index.ts:637-641](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L637-L641)）
- 有 release 时与超时计时器竞速，release 抛错被吞掉，无论如何清掉计时器后 `exit(1)`（[packages/boot/app-boot/src/index.ts:642-659](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L642-L659)）
- 返回的卸载函数摘除该处理器（[packages/boot/app-boot/src/index.ts:661-663](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L661-L663)）
- `assertEntriesLoaded` 把既无 fiber 又未被禁用的条目视为失败，抛出并列出这些插件名（[packages/boot/app-boot/src/index.ts:673-679](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L673-L679)）
- 用字面量镜像 PENDING/ACTIVE/FAILED 三个 fiber 状态值（[packages/boot/app-boot/src/index.ts:686-688](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L686-L688)）
- `formatActivationError` 优先保留 Error 原始栈，否则退回消息或字符串化（[packages/boot/app-boot/src/index.ts:691-693](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L691-L693)）
- `assertEntriesActivated` 跳过已激活与被禁用条目，对 FAILED 条目 await 其 fiber 以取回私有拒绝原因并计入失败列表（[packages/boot/app-boot/src/index.ts:711-724](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L711-L724)）
- PENDING 条目改为列出其仍未就绪的注入服务名，其他状态直接记状态值（[packages/boot/app-boot/src/index.ts:725-731](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L725-L731)）
- 存在失败时先经过一个进程拒绝检查点，再抛出汇总了条目数与每条原因的错误（[packages/boot/app-boot/src/index.ts:733-739](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L733-L739)）
- `boot` 新建 Context，把失败标签初始化为 `host preparation failed`，挂载 Loader 之后才切换为 `plugin tree failed to load`（[packages/boot/app-boot/src/index.ts:779-788](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L779-L788)）
- 把 `baseUrl` 设为配置目录的 file URL，并向上下文提供 `dshHomePath` 供配置表达式调用（[packages/boot/app-boot/src/index.ts:784-785](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L784-L785)）
- 挂载根 include 后等待 Loader 结算；若期间整棵树被释放则直接返回上下文而不做审计（[packages/boot/app-boot/src/index.ts:789-800](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L789-L800)）
- 失败时先释放根 fiber，再沿 `cause` 链找到最深错误，把它（AggregateError 则连同各子错误）的栈追加到带阶段标签的启动诊断里抛出（[packages/boot/app-boot/src/index.ts:801-818](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L801-L818)）
- `HARNESS_SOURCE_SECTION` 固定该提示段名（[packages/boot/app-boot/src/index.ts:822](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L822)）
- `addHarnessSourceSection` 在没有 `systemPrompt` 服务时返回 undefined，不改动任何提示（[packages/boot/app-boot/src/index.ts:838-840](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L838-L840)）
- 有该服务时按固定顺序位注册一段模型可见文本，说明实现检出目录路径、不得据此推断工作目录、应使用 pwd（[packages/boot/app-boot/src/index.ts:841-845](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/index.ts#L841-L845)）

### packages/boot/app-boot/src/invariant.ts

包自带的不变量伴生插件，向 `invariants` 服务登记本包名。

- 插件名与 `inject = ['invariants']` 决定它在该服务就绪后才激活（[packages/boot/app-boot/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/invariant.ts#L13-L15)）
- installer 为空函数，登记后不安装任何运行期检查（[packages/boot/app-boot/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register` 占用包名并返回注销函数（[packages/boot/app-boot/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/invariant.ts#L28-L29)）

### packages/boot/app-boot/src/profile.ts

profile 的发现、初始化、bundle 解析与模块回退维护，被 `--profile` 启动路径使用。

- `PROFILES_DIR`、`PROFILE_PATCH_FILENAME`、`PROFILE_MODULE_FALLBACK_DIR` 固定 profile 目录、用户 patch 文件名与私有回退目录名（[packages/boot/app-boot/src/profile.ts:41-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L41-L47)）
- `resolveProfileDir` 拒绝空名、含路径分隔符、`.`、`..` 以及 `node_modules`，其余拼到 home 下的 profiles 目录（[packages/boot/app-boot/src/profile.ts:127-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L127-L134)）
- `PROFILE_TEMPLATES` 为 acp/web/headless/sdk/sdk-minimal 五个 profile 各定死 bundle 列表与 patch 重载策略，只有 web 是 live（[packages/boot/app-boot/src/profile.ts:137-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L137-L158)）
- `INSTALLATION_OWNED_PROFILE_TUPLES` 列出会被归一化回模板的历史 bundle 组合（[packages/boot/app-boot/src/profile.ts:161-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L161-L163)）
- 自定义 profile 的默认 bundle 列表与默认 `live` 重载策略（[packages/boot/app-boot/src/profile.ts:166-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L166-L169)）
- 初始化写入的 patch 模板文件内容为注释加一个空数组（[packages/boot/app-boot/src/profile.ts:171-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L171-L175)）
- 写入的 pnpm 设置固定 `nodeLinker: hoisted` 与 `autoInstallPeers: false`，使缺失的 peer 落到共享回退目录（[packages/boot/app-boot/src/profile.ts:182-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L182-L187)）
- `initProfile` 建目录后只在文件缺失时写入 package.json、patch 文件与 pnpm-workspace.yaml，已存在的一律不动（[packages/boot/app-boot/src/profile.ts:197-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L197-L217)）
- `ensureSymlink` 遇到既非符号链接又非 dsh 托管代理的路径直接抛错要求人工清理，是托管代理则删除重建（[packages/boot/app-boot/src/profile.ts:238-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L238-L246)）
- 已有链接指向正确目标则直接返回，否则 unlink 后以 junction 方式重建（[packages/boot/app-boot/src/profile.ts:247-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L247-L255)）
- 创建链接遇 EEXIST 时，只有确认对方写的是同一目标才当作成功，否则重新抛出（[packages/boot/app-boot/src/profile.ts:256-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L256-L266)）
- `canonicalLinkPath` 只对父目录求真实路径以避免跟随最后一段，父目录缺失返回 undefined（[packages/boot/app-boot/src/profile.ts:270-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L270-L280)）
- `symlinkPointsTo` 按规范化后的路径比较链接实际指向与目标（[packages/boot/app-boot/src/profile.ts:283-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L283-L288)）
- `ensureProfileSymlink` 只在目标位置完全不存在时才建链接，从不覆盖 pnpm 管理的条目（[packages/boot/app-boot/src/profile.ts:291-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L291-L300)）
- `ownedPackageNames` 扫描回退目录，把作用域目录展开为 `@scope/name` 并只收符号链接（[packages/boot/app-boot/src/profile.ts:303-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L303-L312)）
- `removeProfileSymlink` 先删仍指向自有链接的 profile 投影，再删自有链接，两处 ENOENT 都容忍（[packages/boot/app-boot/src/profile.ts:315-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L315-L330)）
- `isPackagedExecutable` 以 `process.pkg` 是否存在决定走符号链接还是 ESM 代理（[packages/boot/app-boot/src/profile.ts:347-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L347-L349)）
- `packageEntryFromPackage` 用 ESM import 条件解析导出；无匹配条件返回 undefined，解析失败抛出带说明符的错误（[packages/boot/app-boot/src/profile.ts:352-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L352-L365)）
- 解析目标越出包目录时抛错，只有真实存在的文件才被转成 file URL 返回（[packages/boot/app-boot/src/profile.ts:366-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L366-L375)）
- `packageProxySource` 要求被代理包声明非空 version，否则抛错（[packages/boot/app-boot/src/profile.ts:383-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L383-L392)）
- 无 `exports` 的包退回 `main` 或 `index` 走 require 解析；仅有 bin/types 而无 main 时返回空 targets，其余情况抛缺失入口错误（[packages/boot/app-boot/src/profile.ts:394-408](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L394-L408)）
- 有 `exports` 时只取以 `.` 开头、不含通配、不以 `/` 结尾且非 `./package.json` 的子路径逐个解析（[packages/boot/app-boot/src/profile.ts:409-425](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L409-L425)）
- `ensureModuleProxy` 生成 `package.json` 与逐个 `entry-N.js`，用 `export *` 加默认再导出把虚拟文件系统里的模块 URL 暴露给外部插件（[packages/boot/app-boot/src/profile.ts:440-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L440-L479)）
- 已存在同版本同 targets 且入口文件齐全的代理直接跳过；非 dsh 托管的目录抛错要求清理（[packages/boot/app-boot/src/profile.ts:461-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L461-L470)）
- `profileDependencyNames` 把 `dependencies` 与 `peerDependencies` 一并纳入可被插件导入的名字（[packages/boot/app-boot/src/profile.ts:492-494](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L492-L494)）
- `resolveModuleFallbackEntries` 从安装锚点做广度优先遍历，首次解析获胜，解析不到的依赖跳过而不使整次启动失败（[packages/boot/app-boot/src/profile.ts:500-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L500-L522)）
- 普通 Node 下把闭包转成 symlink 条目，打包可执行下转成 proxy 条目并丢弃没有任何 target 的包（[packages/boot/app-boot/src/profile.ts:523-531](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L523-L531)）
- `moduleFallbackEntryCurrent` 分别按链接指向、或代理的版本/targets/入口文件齐全判断条目是否已是最新（[packages/boot/app-boot/src/profile.ts:535-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L535-L550)）
- `healProfilesModuleFallback` 先建共享回退目录，未就绪时在跨进程文件锁内二次检查再修复（[packages/boot/app-boot/src/profile.ts:580-590](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L580-L590)）
- 传入 profile 时再修复该 profile 的局部链接（[packages/boot/app-boot/src/profile.ts:591](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L591)）
- `healProfilesModuleFallbackLocked` 按条目类型分别写代理目录或符号链接（[packages/boot/app-boot/src/profile.ts:595-605](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L595-L605)）
- `dependencyClosure` 以 reserved 名集合为初始 visited、并允许调用方按 exclude 排除候选目录地收集依赖闭包（[packages/boot/app-boot/src/profile.ts:608-640](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L608-L640)）
- `healProfileModuleFallback` 只对不属于安装闭包的 bundle 求闭包，并把 dsh 自有投影排除在发现之外（[packages/boot/app-boot/src/profile.ts:643-665](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L643-L665)）
- 删除不再需要的自有链接，再为需要的包建立自有链接与 profile 内投影（[packages/boot/app-boot/src/profile.ts:666-676](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L666-L676)）
- `readProfileManifest` 读失败抛出，解析出的顶层不是 JSON 对象也抛出（[packages/boot/app-boot/src/profile.ts:685-699](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L685-L699)）
- `writeProfileManifest` 以两空格缩进加尾换行写回清单（[packages/boot/app-boot/src/profile.ts:706-708](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L706-L708)）
- `normalizeShippedProfile` 只在 bundle 列表恰好等于退役组合、或恰好等于当前模板且缺 `patchReload` 时改写清单并落盘，其余保持用户所写（[packages/boot/app-boot/src/profile.ts:721-743](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L721-L743)）
- `packageDirFromAnchor` 沿 `require.resolve.paths` 逐个探测含 package.json 的目录，与 Loader 从同一锚点的解析顺序一致（[packages/boot/app-boot/src/profile.ts:753-764](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L753-L764)）
- `resolveBundleDir` 先从安装锚点解析、再从 profile 目录解析，都失败时抛出含安装命令提示的错误（[packages/boot/app-boot/src/profile.ts:778-789](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L778-L789)）
- `loadProfile` 在 profile 目录缺 package.json 时按模板初始化，无模板的名字直接抛出创建指引（[packages/boot/app-boot/src/profile.ts:809-818](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L809-L818)）
- 清单里 `patchReload` 不是 `live` 或 `startup` 时抛错，缺省则取默认值（[packages/boot/app-boot/src/profile.ts:821-828](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L821-L828)）
- 逐个 bundle 解析包目录并读取 `dsh.bundle.patch`，未声明即抛错，声明则按该路径加载 patch 列表（[packages/boot/app-boot/src/profile.ts:829-838](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L829-L838)）
- 用户 patch 层仅在未被 `userLayer: false` 关闭且文件存在时读取，否则为空列表（[packages/boot/app-boot/src/profile.ts:839-843](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L839-L843)）
- `composeEntries` 把各层 patch 拍平并 `structuredClone` 后，用一次 `applyEntryPatches` 作用在空条目表上得到最终条目列表（[packages/boot/app-boot/src/profile.ts:854-861](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/src/profile.ts#L854-L861)）

### packages/boot/app-boot/tsconfig.json

包级 TypeScript 编译配置，设定 rootDir/outDir 与工程引用。

- 无运行期机制

### packages/boot/app-boot/tsdown.config.ts

该包的产物打包配置。

- 以 `lib/types/index.js` 与 `lib/types/invariant.js` 为入口输出 ESM 到 `lib`，并把 include 插件内联打包而 Loader 保持外部依赖（[packages/boot/app-boot/tsdown.config.ts:7-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/boot/app-boot/tsdown.config.ts#L7-L19)）
