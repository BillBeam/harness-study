---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/storage/storage-sqlite
---

# packages/storage/storage-sqlite

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、48 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/storage/storage-sqlite/README.md

包的说明文档，描述 SQLite 后端的行列布局、配置字段、打开序列与可观察行为。

- 无运行期机制

### packages/storage/storage-sqlite/package.json

包清单，声明入口、导出映射与发布文件集。

- `exports` 暴露根入口 `lib/index.js`、`./invariant` 入口 `lib/invariant.js`，以及 `./src/*` 与 `./package.json`（[packages/storage/storage-sqlite/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/package.json#L16-L27)）
- `files` 限定发布内容为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/storage/storage-sqlite/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/package.json#L28-L32)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/storage/storage-sqlite/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/package.json#L14-L15)）

### packages/storage/storage-sqlite/src/index.ts

插件入口：SQLite 后端类、`path`/`journalMode` 配置、unit 开表与在枢纽上的 `sqlite` 注册。

- `inject = ['storage']` 让后端只在枢纽就绪后装载（[packages/storage/storage-sqlite/src/index.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L21)）
- `Config` 要求 `path` 必填，`journalMode` 限定在四个取值内并默认 `wal`（[packages/storage/storage-sqlite/src/index.ts:45-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L45-L48)）
- 后端只提供 `kv` 一个面，`open` 转发到内部 `openUnit`（[packages/storage/storage-sqlite/src/index.ts:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L57)）
- 构造函数立即发起 `openDatabase` 并对其 rejection 挂一个空 catch，避免首次使用前的失败变成未处理拒绝（[packages/storage/storage-sqlite/src/index.ts:67-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L67-L73)）
- 关闭中或已关闭时 `openUnit` 以 `StorageError('closed')` 拒绝（[packages/storage/storage-sqlite/src/index.ts:76-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L76-L78)）
- unit 名不匹配 `UNIT_NAME_RE` 时拒绝（[packages/storage/storage-sqlite/src/index.ts:79-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L79-L81)）
- 任一表名不匹配 `UNIT_NAME_RE` 时拒绝，保证后面拼进 DDL 的标识符已受控（[packages/storage/storage-sqlite/src/index.ts:82-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L82-L86)）
- 同名 unit 已在表里时拒绝重复打开（[packages/storage/storage-sqlite/src/index.ts:87-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L87-L89)）
- 把 pending Promise 同步塞进 units 表占名，失败时再删掉（[packages/storage/storage-sqlite/src/index.ts:92-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L92-L95)）
- `materializeUnit` 等数据库就绪后从 `units` 表读该 unit 的版本戳（[packages/storage/storage-sqlite/src/index.ts:99-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L99-L102)）
- 无版本戳时插入描述符版本；已有且不等时抛 `version-mismatch`（[packages/storage/storage-sqlite/src/index.ts:103-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L103-L110)）
- 为每个声明表按需建 `key TEXT PRIMARY KEY, value TEXT NOT NULL` 的 STRICT 物理表（[packages/storage/storage-sqlite/src/index.ts:111-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L111-L119)）
- 构造 `SqliteKvUnit` 并传入从 units 表删名的 `onClose`（[packages/storage/storage-sqlite/src/index.ts:120-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L120-L122)）
- `close` 把关闭过程记在 `closing` 上，并发与重复调用共用同一次拆卸（[packages/storage/storage-sqlite/src/index.ts:130-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L130-L133)）
- `doClose` 在数据库从未打开成功时直接返回；否则逐个等待并关闭 unit，最后关掉连接（[packages/storage/storage-sqlite/src/index.ts:135-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L135-L149)）
- `apply` 用具名 `ctx.effect` 把后端以 `sqlite` 注册到枢纽，卸载时先注销名字再关闭后端（[packages/storage/storage-sqlite/src/index.ts:159-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L159-L166)）
- 另以 `sqlite` 的后端服务键把实例 provide 到上下文（[packages/storage/storage-sqlite/src/index.ts:167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/index.ts#L167)）

### packages/storage/storage-sqlite/src/invariant.ts

包自带的不变量伴生插件，声明本包没有可持续观察的进程内关系。

- `inject = ['invariants']` 让伴生插件等不变量服务就绪后才装载（[packages/storage/storage-sqlite/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/invariant.ts#L15)）
- 安装器是空函数，不注册任何监听或检查（[packages/storage/storage-sqlite/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/invariant.ts#L23)）
- `apply` 仍用包名向不变量服务注册这个空安装器并返回 disposer（[packages/storage/storage-sqlite/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/invariant.ts#L30-L31)）

### packages/storage/storage-sqlite/src/schema.ts

数据库打开序列、物理布局版本、元数据表与物理表名拼装，被 `src/index.ts` 与 `src/unit.ts` 使用。

- 物理布局版本常量固定为 1，存进 `PRAGMA user_version`（[packages/storage/storage-sqlite/src/schema.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L20)）
- `createDatabaseFile` 用 `wx`、`0o600` 独占创建缺失的库文件，`EEXIST` 吞掉、其它错误抛出（[packages/storage/storage-sqlite/src/schema.ts:43-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L43-L50)）
- `openDatabase` 对 `:memory:` 跳过文件系统准备，其余路径先 resolve、再以 `0o700` 递归建父目录、再创建库文件（[packages/storage/storage-sqlite/src/schema.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L61-L66)）
- 打开连接后配置失败会先关闭连接再重抛（[packages/storage/storage-sqlite/src/schema.ts:67-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L67-L74)）
- 配置阶段打开外键约束（[packages/storage/storage-sqlite/src/schema.ts:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L78)）
- 把已校验的日志模式大写后拼进 `PRAGMA journal_mode`（[packages/storage/storage-sqlite/src/schema.ts:80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L80)）
- 读 `user_version`，非 0 且不等于当前布局版本时抛 `version-mismatch`，不做迁移（[packages/storage/storage-sqlite/src/schema.ts:81-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L81-L88)）
- 按需建 `units` 元数据表（名字主键 + 版本）（[packages/storage/storage-sqlite/src/schema.ts:90-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L90-L95)）
- 按需建 `unit_globals` 表，`unit` 列外键引用 `units(name)`（[packages/storage/storage-sqlite/src/schema.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L96-L101)）
- 全新库的版本戳放到最后一步写，中途失败则介质保持未打戳（[packages/storage/storage-sqlite/src/schema.ts:102-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L102-L107)）
- `recordTableName` 把 unit 名与表名拼成 `u_<unit>_<table>` 物理表名（[packages/storage/storage-sqlite/src/schema.ts:118-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/schema.ts#L118-L120)）

### packages/storage/storage-sqlite/src/unit.ts

一个已打开的 SQLite KV unit：每张声明表一组预编译语句，值以 JSON 文本存在 `value` 列。

- 构造时为每个声明表预编译 upsert、delete、selectAll 三条语句，表名用 `recordTableName` 拼出的物理名（[packages/storage/storage-sqlite/src/unit.ts:43-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L43-L54)）
- 只有描述符声明了 global 时才预编译 `unit_globals` 的 upsert 与 select，否则留 undefined（[packages/storage/storage-sqlite/src/unit.ts:55-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L55-L62)）
- `loadAll` 逐表全量取行，装进以 `Object.create(null)` 建的空原型对象，使 `__proto__` 之类键落成自有属性（[packages/storage/storage-sqlite/src/unit.ts:65-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L65-L76)）
- global 默认读作 `null`，有行时才按本 unit 名取出并解析（[packages/storage/storage-sqlite/src/unit.ts:77-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L77-L81)）
- `parseValue` 把不可解析的 JSON 映射成 `malformed-medium` 并带上出错位置与 `cause`（[packages/storage/storage-sqlite/src/unit.ts:87-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L87-L97)）
- `putRecord` 用单条 upsert 语句写入 `JSON.stringify` 后的值（[packages/storage/storage-sqlite/src/unit.ts:99-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L99-L103)）
- `deleteRecord` 用单条 DELETE 语句按键删除（[packages/storage/storage-sqlite/src/unit.ts:105-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L105-L109)）
- `setGlobal` 在未声明 global 时抛错，否则以 unit 名为主键 upsert 到 `unit_globals`（[packages/storage/storage-sqlite/src/unit.ts:111-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L111-L118)）
- `close` 幂等：首次调用置 closed 并回调 `onClose` 释放开名槽位，不关闭共享的数据库连接（[packages/storage/storage-sqlite/src/unit.ts:120-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L120-L126)）
- `settle` 把同步原语包成 Promise：先做打开断言，抛出一律转成拒绝，非 Error 值包装成 Error（[packages/storage/storage-sqlite/src/unit.ts:132-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L132-L141)）
- `ensureOpen` 在关闭后抛 `StorageError('closed')`（[packages/storage/storage-sqlite/src/unit.ts:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L143-L147)）
- `statementsFor` 对描述符未声明的表名抛错（[packages/storage/storage-sqlite/src/unit.ts:149-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-sqlite/src/unit.ts#L149-L155)）

### packages/storage/storage-sqlite/tsconfig.json

包的 TypeScript 编译配置，声明源码根、输出目录与工程引用。

- 无运行期机制
