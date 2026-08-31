---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/settings/settings-file
---

# packages/settings/settings-file

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、35 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/settings/settings-file/README.md

该包的英文 README，说明文件型设置提供者的配置字段、文档编辑、写入与失败行为。

- 记载配置字段表：`path` 的扩展名决定格式、`dshHome` 回退、`watch` 默认开、`debounceMs` 默认 100（[packages/settings/settings-file/README.md:42-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/README.md#L42-L47)）
- 记载编辑语义：外部改动自动生效、删除文件把所有命名空间重置回默认与 `base`、启动时存在但非法的文档直接让插件加载失败、运行期非法编辑只告警并保留上次好值（[packages/settings/settings-file/README.md:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/README.md#L53)）
- 记载写入前先并入磁盘状态、YAML 按叶级差异保留注释、JSON 重序列化丢注释、磁盘文档已损坏时写入直接失败（[packages/settings/settings-file/README.md:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/README.md#L57)）
- 记载写者锁有 2 秒获取期限与指数退避，超时的竞争者保留既有锁；文档以 0600 建于 0700 目录下并经随机后缀临时文件原子替换（[packages/settings/settings-file/README.md:59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/README.md#L59)）
- 记载不支持的扩展名在加载期失败、缺失文档等价于空存储、`prepareDocument()` 会先物化空文档（[packages/settings/settings-file/README.md:63-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/README.md#L63-L66)）
- 记载在 Chokidar 打开目标前先对最深存在祖先做 realpath 并补回缺失后缀（[packages/settings/settings-file/README.md:101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/README.md#L101)）

### packages/settings/settings-file/package.json

该包的 npm 清单，声明入口、导出子路径与依赖关系。

- `exports` 暴露包根、`./invariant` 与 `./src/*` 三类解析入口，`files` 限定发布产物（[packages/settings/settings-file/package.json:16-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/package.json#L16-L32)）
- `dependencies` 声明运行时需要 `chokidar` 与 `yaml`（[packages/settings/settings-file/package.json:41-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/package.json#L41-L45)）

### packages/settings/settings-file/src/index.ts

文件型设置提供者：用一份 YAML/JSON 文档承载所有命名空间段，负责加载、监视热发布与加锁读改写。

- `resolveSpec` 在一处集中定默认：`path` 缺席时回退到 `<harness home>/settings.yaml`，并把路径 resolve 成绝对路径（[packages/settings/settings-file/src/index.ts:55-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L55-L56)）
- 从扩展名映射文档格式，不在 `.yaml`/`.yml`/`.json` 之列即抛错（[packages/settings/settings-file/src/index.ts:57-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L57-L60)）
- `watch` 默认 true、`debounceMs` 默认 100（[packages/settings/settings-file/src/index.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L61-L66)）
- `patchNode` 递归对 map 做最小 `setIn`/`deleteIn` 编辑：`next` 中缺席的键被删除，值不等的叶子被 set，其余节点原样留在文档树里（[packages/settings/settings-file/src/index.ts:81-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L81-L92)）
- `static Config` 定义 Loader schema 与 `watch`/`debounceMs` 的默认值（[packages/settings/settings-file/src/index.ts:106-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L106-L111)）
- 缓存最后一次成功解析或写出的原文，用内容相等来抑制自身写入触发的监视事件（[packages/settings/settings-file/src/index.ts:114-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L114-L119)）
- 单条排他操作链把监视重载与所有命名空间的写入串行化（[packages/settings/settings-file/src/index.ts:120-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L120-L126)）
- 构造函数在此再跑一遍 `resolveSpec`，使绕过 Schemastery 的程序化构造也拿到同一套默认值（[packages/settings/settings-file/src/index.ts:135-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L135-L140)）
- `writable` 恒为 true，`documentPath` 返回解析后的文档绝对路径（[packages/settings/settings-file/src/index.ts:143-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L143-L149)）
- `prepareDocument` 在锁内用 `wx` 独占创建 0600 空文档（目录 0700），新建成功后发布空文档；已存在则直接返回（[packages/settings/settings-file/src/index.ts:153-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L153-L168)）
- `load` 遇 ENOENT 时清空文本缓存并返回空文档，其他读错误上抛（[packages/settings/settings-file/src/index.ts:170-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L170-L182)）
- `persist` 把每次写入排进同一条操作链，使不同命名空间的写入互不覆盖（[packages/settings/settings-file/src/index.ts:184-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L184-L190)）
- `enqueue` 用已结算的尾链排队，前一操作失败不阻断后续操作（[packages/settings/settings-file/src/index.ts:193-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L193-L197)）
- `queueRefresh` 捕获重载链上的拒绝并记 error 日志，使一次提交失败不会永久终止热重载（[packages/settings/settings-file/src/index.ts:200-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L200-L208)）
- `persistSection` 先按 0700 建父目录，再在跨进程写者锁内执行读改写（[packages/settings/settings-file/src/index.ts:210-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L210-L222)）
- 渲染后以 0600 原子写入并更新文本缓存（[packages/settings/settings-file/src/index.ts:223-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L223-L229)）
- `Service.init` 先委托基类加载并发布文档，再按 `spec.watch` 启动 chokidar，`awaitWriteFinish` 用 `debounceMs` 作稳定阈值（[packages/settings/settings-file/src/index.ts:232-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L232-L245)）
- 监视器所有事件排一次重载，`ready` 时额外重载一次以补上初始读取与监视生效之间的空窗，`error` 只告警（[packages/settings/settings-file/src/index.ts:246-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L246-L262)）
- 拆卸器置 `closed`、关闭监视器并等待操作链排空，使拆卸后不再有发布（[packages/settings/settings-file/src/index.ts:263-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L263-L268)）
- `parse` 对 YAML 只取错误码与行列位置组装消息，不引用解析器原文（[packages/settings/settings-file/src/index.ts:276-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L276-L286)）
- 空 JSON 文本按空文档处理，根不是非数组对象时抛 `TypeError`（[packages/settings/settings-file/src/index.ts:288-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L288-L294)）
- `refresh` 把 `INVARIANT` 码错误上抛给队列错误面，其余失败只告警并保留上次好文档（[packages/settings/settings-file/src/index.ts:304-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L304-L313)）
- `reconcileFromDisk` 在文本与缓存相同或已关闭时直接返回；文件缺失时发布空文档；否则解析后更新缓存并发布（[packages/settings/settings-file/src/index.ts:321-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L321-L338)）
- `renderYaml` 无缓存文本时直接新建单命名空间文档，否则重解析缓存文本成保留注释的可变树后对该命名空间打叶级补丁（[packages/settings/settings-file/src/index.ts:347-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L347-L358)）
- `renderJson` 只替换一个命名空间键后按两空格缩进重序列化并补尾换行（[packages/settings/settings-file/src/index.ts:361-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/index.ts#L361-L367)）

### packages/settings/settings-file/src/invariant.ts

该包的不变式伴随插件，向 `invariants` 服务登记包名。

- `apply` 向 `ctx.invariants` 注册包名与一个空安装器，并返回其 disposer（[packages/settings/settings-file/src/invariant.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings-file/src/invariant.ts#L22-L30)）

### packages/settings/settings-file/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制
