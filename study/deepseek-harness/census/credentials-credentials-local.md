---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/credentials/credentials-local
---

# packages/credentials/credentials-local

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、82 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/credentials/credentials-local/README.md

本包的英文说明文档，介绍文件型凭据存储的配置字段、层级优先级、文件格式与权限要求。

- 无运行期机制

### packages/credentials/credentials-local/package.json

本包的 npm 清单，声明模块类型、入口、导出子路径与运行期依赖。

- 声明 `"type": "module"`，包内文件按 ESM 加载（[packages/credentials/credentials-local/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/package.json#L13)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/credentials/credentials-local/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/package.json#L14-L15)）
- `exports` 把 `.` 解析到构建产物、`./invariant` 解析到伴生模块，并额外暴露 `./src/*` 与 `./package.json`（[packages/credentials/credentials-local/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/package.json#L16-L27)）
- `files` 限定发布内容为两个 js 产物与类型声明（[packages/credentials/credentials-local/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/package.json#L28-L32)）
- `dependencies` 引入 chokidar、schemastery 与 yaml，作为运行期实际加载的第三方实现（[packages/credentials/credentials-local/package.json:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/package.json#L42-L46)）

### packages/credentials/credentials-local/src/index.ts

凭据能力的文件型 Provider 实现：解析 `.credentials.yaml` 文档、按层级解析引用值、在跨进程写锁下写入并发布更新事件，由凭据 seam 的消费者通过 `ctx.credentials` 使用。

- 导出凭据文档的固定文件名常量 `.credentials.yaml`（[packages/credentials/credentials-local/src/index.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L61)）
- `resolveSpec` 把配置解析成绝对文件路径（缺省取 harness home 下的文件名）、watch 默认 true、debounceMs 默认 100（[packages/credentials/credentials-local/src/index.ts:88-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L88-L94)）
- 定义组/其他权限位掩码 `0o077`，作为权限检查的判定位（[packages/credentials/credentials-local/src/index.ts:97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L97)）
- 定义文档写锁等待上限 30000 毫秒，所有写入者共享这一等待时长（[packages/credentials/credentials-local/src/index.ts:112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L112)）
- `assertOwnerOnly` 先 `stat` 文件；ENOENT 时改为规范化监视路径后返回，Windows 平台直接跳过检查，其余情况一旦存在组/其他权限位就抛错并给出 `chmod 600` 提示（[packages/credentials/credentials-local/src/index.ts:127-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L127-L146)）
- `isENOENT` 把"文件不存在"与其他文件系统错误分开，非 ENOENT 一律上抛（[packages/credentials/credentials-local/src/index.ts:149-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L149-L151)）
- `describeYamlError` 只输出错误码与行列号，不带解析器原始消息里的源码行（[packages/credentials/credentials-local/src/index.ts:159-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L159-L164)）
- 导出文档版本号常量 `1`，读写两侧都以它为准（[packages/credentials/credentials-local/src/index.ts:167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L167)）
- `parseCredentialsDocument` 以 `prettyErrors` 与 `uniqueKeys` 解析，解析器报错即抛出（重复键因此成为错误）（[packages/credentials/credentials-local/src/index.ts:194-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L194-L198)）
- 根节点不是映射时抛 TypeError（[packages/credentials/credentials-local/src/index.ts:199-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L199-L202)）
- 空文档（含仅注释）直接返回空的 refs/records，两张空表（[packages/credentials/credentials-local/src/index.ts:207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L207)）
- 非空但缺 `version` 时抛错，并给出把现有条目挪到 `refs:` 下的具体条数提示（[packages/credentials/credentials-local/src/index.ts:208-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L208-L214)）
- `version` 与本构建支持的版本不等时抛错（[packages/credentials/credentials-local/src/index.ts:215-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L215-L220)）
- 顶层出现 `version`/`refs`/`records` 之外的键时抛错（[packages/credentials/credentials-local/src/index.ts:221-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L221-L225)）
- `renderFlatLayoutMigration` 只在文档能解析、根是非空映射、无 `%`/`---`/`...` 指令行、每个键都是合法凭据引用名且值为非空字符串标量时才认定为旧平铺布局，否则返回 undefined（[packages/credentials/credentials-local/src/index.ts:243-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L243-L263)）
- 识别成功时按行加两格缩进整体嵌进 `refs:` 下并加上版本行，末尾补换行（[packages/credentials/credentials-local/src/index.ts:264-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L264-L265)）
- `parseRefs` 对每个键调用 `credentialRef` 校验命名，值非字符串抛 TypeError，值为空串抛错要求删除该键，错误消息只带键名（[packages/credentials/credentials-local/src/index.ts:269-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L269-L287)）
- `parseRecords` 对每个键调用 `parseCredentialKey` 校验 `<scope>/<id>` 形态，再逐条解析记录（[packages/credentials/credentials-local/src/index.ts:290-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L290-L297)）
- `assertStorableApiKey` 在写入前拒绝空 key、拒绝不合法的 env 名与空 env 值（[packages/credentials/credentials-local/src/index.ts:307-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L307-L317)）
- `asSection` 把缺省与 null 都当空段，非映射（含数组）抛 TypeError（[packages/credentials/credentials-local/src/index.ts:320-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L320-L326)）
- `parseRecord` 按 `kind` 分派：`api-key` 只允许 `kind`/`key`/`env` 字段并校验 key 与 env，`grant` 只允许 `kind`/`payload` 且 payload 必须存在并通过 JSON 可表示性校验，缺 kind 或未知 kind 抛错（[packages/credentials/credentials-local/src/index.ts:329-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L329-L358)）
- `assertFields` 对不在允许集合中的字段抛错，而不是丢弃（[packages/credentials/credentials-local/src/index.ts:361-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L361-L367)）
- `parseRecordEnv` 要求 env 是映射，逐项校验名称合法且值为非空字符串（[packages/credentials/credentials-local/src/index.ts:370-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L370-L386)）
- `assertJsonValue` 递归判定值能否 JSON 往返：拒绝非有限数、拒绝环、只接受纯对象与数组，其余一律抛 TypeError，且诊断不含任何值（[packages/credentials/credentials-local/src/index.ts:400-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L400-L416)）
- `mutableDocument` 在已有文本上重新解析出可编辑树（缺失时新建空文档），并在每次编辑时写入 `version` 字段（[packages/credentials/credentials-local/src/index.ts:425-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L425-L434)）
- `renderRef` 按值是否为 undefined 决定删除条目还是 `setIn(['refs', ref])` 后序列化（[packages/credentials/credentials-local/src/index.ts:443-448](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L443-L448)）
- `renderRecord` 同样按记录是否为 undefined 删除或整体替换记录节点后序列化（[packages/credentials/credentials-local/src/index.ts:459-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L459-L464)）
- `deleteSectionEntry` 删除段内首条时先把段映射的 `commentBefore` 置空，再执行 `deleteIn`（[packages/credentials/credentials-local/src/index.ts:476-490](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L476-L490)）
- `sameJsonValue` 做忽略键序的结构比较，作为记录变更判定（[packages/credentials/credentials-local/src/index.ts:501-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L501-L510)）
- `LocalCredentialProvider.Config` 用 Schemastery 声明 path/dshHome/watch/debounceMs 并给出默认值与 `min(0)` 约束（[packages/credentials/credentials-local/src/index.ts:517-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L517-L522)）
- 以 `text` 缓存上次读到/写出的原文，等值的 watcher 事件被当作空操作，也即自写抑制（[packages/credentials/credentials-local/src/index.ts:530](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L530)）
- `values` 与 `records` 两张快照在每次重载时整体替换（[packages/credentials/credentials-local/src/index.ts:531-534](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L531-L534)）
- 单条 `operations` Promise 链把 watcher 重载与写入串行化（[packages/credentials/credentials-local/src/index.ts:540](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L540)）
- `closed` 标志在 dispose 时置位，用于拒绝新写入并让在途工作退化为空操作（[packages/credentials/credentials-local/src/index.ts:542-547](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L542-L547)）
- 构造函数在类内再跑一次 `resolveSpec`，使绕过 Schemastery 的程序化构造也拿到同一套默认值（[packages/credentials/credentials-local/src/index.ts:550-555](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L550-L555)）
- `inherited` 只从启动环境快照的 `process` 层取值，空串视作未设置（[packages/credentials/credentials-local/src/index.ts:558-561](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L558-L561)）
- `dotenvFallback` 依次从 `project-env`、`user-env` 层取值，空串视作未设置（[packages/credentials/credentials-local/src/index.ts:568-571](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L568-L571)）
- `Service.init` 首先 yield 一个置 closed 并等待 operations 排空的清理函数，然后执行首次加载（[packages/credentials/credentials-local/src/index.ts:573-580](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L573-L580)）
- `watch` 关闭时直接返回，不建立文件监视（[packages/credentials/credentials-local/src/index.ts:581](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L581)）
- chokidar 监视规范化后的路径，忽略初始事件，并以 `debounceMs` 作为写入稳定阈值、轮询间隔取 `min(debounceMs,10)` 且不小于 1（[packages/credentials/credentials-local/src/index.ts:585-591](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L585-L591)）
- 任意 watcher 事件在未关闭时排入一次刷新（[packages/credentials/credentials-local/src/index.ts:592-595](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L592-L595)）
- watcher `ready` 时再排一次刷新，弥补首次读取与监视生效之间的窗口（[packages/credentials/credentials-local/src/index.ts:596-602](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L596-L602)）
- watcher 错误只按 warn 记录，不终止进程（[packages/credentials/credentials-local/src/index.ts:603-606](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L603-L606)）
- 第二个清理函数置 closed、关闭 watcher，再等待队列排空，使拆卸后不再发布（[packages/credentials/credentials-local/src/index.ts:607-613](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L607-L613)）
- `resolve` 按 继承环境（source `env`）→ 文档快照（source `file`）→ `.env` 回退 的固定次序返回首个命中值（[packages/credentials/credentials-local/src/index.ts:617-625](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L617-L625)）
- `describe` 只回报 configured/source/writable，且把继承环境标为 `writable: false`，其余层标为可写（[packages/credentials/credentials-local/src/index.ts:627-639](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L627-L639)）
- `set` 拒绝空值并提示改用 unset，其余走统一写入路径（[packages/credentials/credentials-local/src/index.ts:641-646](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L641-L646)）
- `unset` 以 undefined 值走同一写入路径（[packages/credentials/credentials-local/src/index.ts:648-650](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L648-L650)）
- `readRecord` 直接从内存快照返回记录（[packages/credentials/credentials-local/src/index.ts:652-654](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L652-L654)）
- `describeRecord` 只以存在与否与 kind 作答，不返回记录内容（[packages/credentials/credentials-local/src/index.ts:656-664](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L656-L664)）
- `listRecords` 返回全部记录的键与 kind 列表（[packages/credentials/credentials-local/src/index.ts:666-672](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L666-L672)）
- `modifyRecord` 在入队前与队内各判一次 disposed，两处均抛错（[packages/credentials/credentials-local/src/index.ts:678-682](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L678-L682)）
- `modifyRecord` 以 0700 建父目录，再在 30 秒等待上限的跨进程写锁内先 `reconcileFromDisk` 再把当前记录交给回调（[packages/credentials/credentials-local/src/index.ts:683-690](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L683-L690)）
- 回调返回 undefined 时不写盘，直接返回原记录（[packages/credentials/credentials-local/src/index.ts:691-692](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L691-L692)）
- 回调结果在渲染前按 kind 分别做 JSON 可表示性或 api-key 可存储性校验，校验失败即不落盘（[packages/credentials/credentials-local/src/index.ts:695-696](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L695-L696)）
- 记录写入以 `writeFileAtomic` 落盘、文件 0600 目录 0700，随后同步文本缓存与内存快照，最后发布记录更新通知（[packages/credentials/credentials-local/src/index.ts:697-704](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L697-L704)）
- `deleteRecord` 走同一队列与锁，记录不存在时直接返回不写盘，存在时渲染删除、原子写、更新快照并发布通知（[packages/credentials/credentials-local/src/index.ts:709-726](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L709-L726)）
- `enqueue` 把每个操作挂到上一操作之后，并让尾部吞掉成败以保持链条继续（[packages/credentials/credentials-local/src/index.ts:734-738](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L734-L738)）
- `queueRefresh` 排入刷新并捕获拒绝，按 error 记录后保留队列继续可用（[packages/credentials/credentials-local/src/index.ts:741-749](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L741-L749)）
- `write` 在入队前与队内各判一次 disposed 与"是否被继承环境遮蔽"，两次判定都会抛错（[packages/credentials/credentials-local/src/index.ts:753-765](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L753-L765)）
- `write` 以 0700 建父目录后在写锁内先 `reconcileFromDisk`，删除一个本就不存在的键时直接返回不写盘（[packages/credentials/credentials-local/src/index.ts:767-775](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L767-L775)）
- 引用写入渲染后以 0600/0700 原子落盘，再更新文本缓存与 `values`，最后发布引用更新通知（[packages/credentials/credentials-local/src/index.ts:776-784](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L776-L784)）
- `assertUnshadowed` 在该引用由继承环境提供时拒绝 set/unset 并给出在启动 shell 中清除变量的提示（[packages/credentials/credentials-local/src/index.ts:794-801](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L794-L801)）
- `loadInitial` 先做权限检查，文件缺失即空存储返回，读取到的旧平铺布局先就地迁移，再严格解析并装入两张快照与文本缓存（[packages/credentials/credentials-local/src/index.ts:811-825](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L811-L825)）
- `migrateFlatDocument` 在写锁内重读文件，若重读结果已不是平铺布局则原样返回，否则以 0600 原子写出迁移结果并按 info 记录一条迁移日志（[packages/credentials/credentials-local/src/index.ts:837-856](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L837-L856)）
- `refresh` 在已关闭时直接返回；重载失败时，`code === 'INVARIANT'` 的错误上抛，其余按 warn 记录并保留上一份可用快照（[packages/credentials/credentials-local/src/index.ts:868-877](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L868-L877)）
- `reconcileFromDisk` 每次都重做权限检查，文件缺失按空存储处理，文本与缓存相同或已关闭时不做任何发布（[packages/credentials/credentials-local/src/index.ts:886-897](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L886-L897)）
- 文本不同时整体替换两张快照，并对每个变化的引用与记录各发布一次更新通知（[packages/credentials/credentials-local/src/index.ts:898-908](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L898-L908)）
- `changedRefs` 取新旧键并集逐个比较字符串值，得出需要通知的引用列表（[packages/credentials/credentials-local/src/index.ts:912-919](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L912-L919)）
- `changedRecords` 取新旧键并集并用结构比较得出需要通知的记录列表（[packages/credentials/credentials-local/src/index.ts:922-932](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L922-L932)）
- 默认导出该 Provider 类，供 Loader 按插件形态装载（[packages/credentials/credentials-local/src/index.ts:935](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/index.ts#L935)）

### packages/credentials/credentials-local/src/invariant.ts

本包的不变量伴生插件模块，由 `./invariant` 子路径导出，被不变量服务在装载时使用。

- 导出 Cordis 插件名 `credentials-local-invariant`（[packages/credentials/credentials-local/src/invariant.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/invariant.ts#L13)）
- 声明 `inject = ['invariants']`，插件在该服务就绪前不会激活（[packages/credentials/credentials-local/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/invariant.ts#L15)）
- 安装函数为空体，因此本包注册后不装任何运行期检查（[packages/credentials/credentials-local/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/invariant.ts#L22)）
- `apply` 用包名向 `ctx.invariants` 注册并返回注册的 disposer（[packages/credentials/credentials-local/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/credentials/credentials-local/src/invariant.ts#L29-L30)）

### packages/credentials/credentials-local/tsconfig.json

本包的 TypeScript 编译配置，声明源码根、类型输出目录与工作区项目引用。

- 无运行期机制
