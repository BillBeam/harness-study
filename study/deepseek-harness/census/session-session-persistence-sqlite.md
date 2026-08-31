---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/session/session-persistence-sqlite
---

# packages/session/session-persistence-sqlite

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 46 个文件、146 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/session/session-persistence-sqlite/README.md

SQLite 会话持久化包的英文说明文档，面向部署与维护者介绍配置字段、启动校验、物理行打包与读写路径。

- 无运行期机制

### packages/session/session-persistence-sqlite/package.json

该包的 npm 清单，声明模块类型、入口映射与发布文件白名单。

- `"type": "module"` 使包内 `.js` 以 ESM 解析（[packages/session/session-persistence-sqlite/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/package.json#L13)）
- `main` 指向 `lib/index.js`、`types` 指向 `lib/types/index.d.ts`（[packages/session/session-persistence-sqlite/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/package.json#L14-L15)）
- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，另外放通 `./src/*` 与 `./package.json` 两个子路径（[packages/session/session-persistence-sqlite/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/package.json#L16-L27)）
- `files` 把发布产物限定为两个 `lib` 入口、`resources/zstd-dictionary.bin`、`resources/sql/**/*.sql` 与类型声明，运行期按名读取的 SQL 资源和压缩字典由此随包分发（[packages/session/session-persistence-sqlite/package.json:28-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/package.json#L28-L34)）

### packages/session/session-persistence-sqlite/resources/sql/begin-immediate.sql

包内 SQL 资源，由 `sql('begin-immediate')` 按闭合名读入，用于追加、修复与初始化路径开启写事务。

- 发出 `BEGIN IMMEDIATE`，在语句执行时即取得写锁开启事务（[packages/session/session-persistence-sqlite/resources/sql/begin-immediate.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/begin-immediate.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/begin.sql

包内 SQL 资源，由 `sql('begin')` 读入，用于开启普通事务。

- 发出 `BEGIN`，开启延迟取锁的事务（[packages/session/session-persistence-sqlite/resources/sql/begin.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/begin.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/commit.sql

包内 SQL 资源，由 `sql('commit')` 读入，用于结束事务。

- 发出 `COMMIT`，提交当前事务并使其中的写入落盘可见（[packages/session/session-persistence-sqlite/resources/sql/commit.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/commit.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/delete-events-from.sql

包内 SQL 资源，由 `sql('delete-events-from')` 读入，用于在写锁下截断事件日志尾部。

- 按绑定的 `session_id` 删除 `events` 中 `seq` 大于等于绑定值的全部物理行，两个值均为参数而非拼接文本（[packages/session/session-persistence-sqlite/resources/sql/delete-events-from.sql:1-2](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/delete-events-from.sql#L1-L2)）

### packages/session/session-persistence-sqlite/resources/sql/foreign-keys-on.sql

包内 SQL 资源，由 `sql('foreign-keys-on')` 读入，在连接建立与参考库建库时执行。

- 发出 `PRAGMA foreign_keys = ON`，为该连接打开外键约束，使 `events` 到 `sessions` 的级联删除生效（[packages/session/session-persistence-sqlite/resources/sql/foreign-keys-on.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/foreign-keys-on.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/insert-event.sql

包内 SQL 资源，由 `sql('insert-event')` 读入，是写入一条物理事件行的唯一语句。

- 向 `events` 插入一行，`session_id`、`seq`、`type`、`time`、`data`、`source_event_seqs`、`surface_op`、`is_packed` 八列全部由绑定参数提供（[packages/session/session-persistence-sqlite/resources/sql/insert-event.sql:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/insert-event.sql#L1-L3)）

### packages/session/session-persistence-sqlite/resources/sql/insert-persistence-state.sql

包内 SQL 资源，由 `sql('insert-persistence-state')` 读入，在新建数据库时写入库标识。

- 向 `persistence_state` 插入 `singleton = 1` 的那一行，`store_id` 由绑定参数提供（[packages/session/session-persistence-sqlite/resources/sql/insert-persistence-state.sql:1-2](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/insert-persistence-state.sql#L1-L2)）

### packages/session/session-persistence-sqlite/resources/sql/journal-mode-delete.sql

包内 SQL 资源，`journalMode` 配置为 `delete` 时由连接建立路径执行。

- 发出 `PRAGMA journal_mode = DELETE`，把该库的日志模式设为提交后删除回滚日志，并返回生效后的模式供回读校验（[packages/session/session-persistence-sqlite/resources/sql/journal-mode-delete.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/journal-mode-delete.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/journal-mode-persist.sql

包内 SQL 资源，`journalMode` 配置为 `persist` 时由连接建立路径执行。

- 发出 `PRAGMA journal_mode = PERSIST`，把日志模式设为保留回滚日志文件并清零其头部，并返回生效后的模式（[packages/session/session-persistence-sqlite/resources/sql/journal-mode-persist.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/journal-mode-persist.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/journal-mode-truncate.sql

包内 SQL 资源，`journalMode` 配置为 `truncate` 时由连接建立路径执行。

- 发出 `PRAGMA journal_mode = TRUNCATE`，把日志模式设为提交后把回滚日志截断到零长度，并返回生效后的模式（[packages/session/session-persistence-sqlite/resources/sql/journal-mode-truncate.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/journal-mode-truncate.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/journal-mode-wal.sql

包内 SQL 资源，`journalMode` 取默认值 `wal` 时由连接建立路径执行。

- 发出 `PRAGMA journal_mode = WAL`，把日志模式设为预写日志，并返回生效后的模式供回读校验（[packages/session/session-persistence-sqlite/resources/sql/journal-mode-wal.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/journal-mode-wal.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/mmap-off.sql

包内 SQL 资源，由 `sql('mmap-off')` 读入，在每个连接的加固步骤中执行。

- 发出 `PRAGMA mmap_size = 0`，关闭该连接的内存映射读取（[packages/session/session-persistence-sqlite/resources/sql/mmap-off.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/mmap-off.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/page-size.sql

包内 SQL 资源，由 `sql('page-size')` 读入，在建库前执行以固定物理页大小。

- 发出 `PRAGMA page_size = 65536`，把数据库页大小定为 64 KiB（[packages/session/session-persistence-sqlite/resources/sql/page-size.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/page-size.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/rollback.sql

包内 SQL 资源，由 `sql('rollback')` 读入，用于版本校验失败与写入出错后的事务撤销。

- 发出 `ROLLBACK`，撤销当前事务内的全部改动（[packages/session/session-persistence-sqlite/resources/sql/rollback.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/rollback.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/schema.sql

包内 SQL 资源，由 `sql('schema')` 读入，既用于新建数据库建表，也用于在内存参考库中重建同一份定义以比对既有库的模式对象。

- 定义 `persistence_state` 表：`singleton` 为整型主键并带 `CHECK (singleton = 1)`，`store_id` 为非空文本，使全库标识只能有一行（[packages/session/session-persistence-sqlite/resources/sql/schema.sql:1-4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/schema.sql#L1-L4)）
- 定义 `sessions` 表，`id` 为内部整型主键、`session_key` 为非空且唯一的公开会话标识（[packages/session/session-persistence-sqlite/resources/sql/schema.sql:6-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/schema.sql#L6-L8)）
- `sessions` 的 `version`、`created_at`、`incarnation`、`revision` 为非空列，而 `cwd`、`parent_session`、`seed_length`、`origin`、`delegation_depth`、`agent_preset` 允许为空（[packages/session/session-persistence-sqlite/resources/sql/schema.sql:9-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/schema.sql#L9-L18)）
- `events.session_id` 以 `REFERENCES sessions(id) ON DELETE CASCADE` 关联会话行，删除会话行时连带删除其事件行（[packages/session/session-persistence-sqlite/resources/sql/schema.sql:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/schema.sql#L21-L22)）
- `events.data` 声明为 `ANY NOT NULL`，`source_event_seqs` 声明为可空的 `ANY`，使同一列既能存文本又能存二进制块（[packages/session/session-persistence-sqlite/resources/sql/schema.sql:26-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/schema.sql#L26-L27)）
- `events.is_packed` 带 `CHECK (is_packed IN (0, 1))`，把打包标志限制为两个取值（[packages/session/session-persistence-sqlite/resources/sql/schema.sql:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/schema.sql#L29)）
- `events` 以 `(session_id, seq)` 为复合主键，使同一会话内物理行按 `seq` 唯一且有序（[packages/session/session-persistence-sqlite/resources/sql/schema.sql:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/schema.sql#L30)）
- 三张表都以 `STRICT` 建表，列类型在写入时被强制检查（[packages/session/session-persistence-sqlite/resources/sql/schema.sql:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/schema.sql#L4)）

### packages/session/session-persistence-sqlite/resources/sql/select-application-id.sql

包内 SQL 资源，由 `sql('select-application-id')` 读入，用于启动与追加前的库归属校验。

- 发出 `PRAGMA application_id`，读回数据库头部的应用标识（[packages/session/session-persistence-sqlite/resources/sql/select-application-id.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-application-id.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/select-events-from.sql

包内 SQL 资源，由 `sql('select-events-from')` 读入，服务于按序号起点的后缀读取。

- 按绑定的 `session_id` 取 `seq >= ?` 的物理行，只回 `seq`、`type`、`time`、`data`、`source_event_seqs`、`surface_op`、`is_packed` 七列并按 `seq` 升序返回（[packages/session/session-persistence-sqlite/resources/sql/select-events-from.sql:1-4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-events-from.sql#L1-L4)）

### packages/session/session-persistence-sqlite/resources/sql/select-events.sql

包内 SQL 资源，由 `sql('select-events')` 读入，服务于整段会话读取与修复前的当前行快照。

- 按绑定的 `session_id` 取该会话全部物理行的七列，并按 `seq` 升序返回（[packages/session/session-persistence-sqlite/resources/sql/select-events.sql:1-4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-events.sql#L1-L4)）

### packages/session/session-persistence-sqlite/resources/sql/select-mmap-size.sql

包内 SQL 资源，由 `sql('select-mmap-size')` 读入，用于回读内存映射设置。

- 发出 `PRAGMA mmap_size`，读回该连接当前的内存映射字节数（[packages/session/session-persistence-sqlite/resources/sql/select-mmap-size.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-mmap-size.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/select-packed-predecessors.sql

包内 SQL 资源，由 `sql('select-packed-predecessors')` 读入，用于后缀读取时定位可能覆盖起点序号的打包行。

- 在绑定的 `seq >= ?` 与 `seq < ?` 半开区间内取行，把扫描范围限制在起点之前的一段物理跨度（[packages/session/session-persistence-sqlite/resources/sql/select-packed-predecessors.sql:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-packed-predecessors.sql#L3)）
- 只取 `type` 属于 `'text-chunks'`、`'reasoning-chunks'`、`'tool-call-chunks'` 三个物理标签且 `is_packed = 1` 的行，并按 `seq` 升序返回七列（[packages/session/session-persistence-sqlite/resources/sql/select-packed-predecessors.sql:1-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-packed-predecessors.sql#L1-L6)）

### packages/session/session-persistence-sqlite/resources/sql/select-schema-objects.sql

包内 SQL 资源，由 `sql('select-schema-objects')` 读入，用于把既有库的模式对象与参考库逐条比对。

- 从 `sqlite_schema` 取名字不匹配 `sqlite_*` 的对象的 `type`、`name`、`tbl_name`、`sql` 四列，并按 `type`、`name` 排序以得到稳定序列（[packages/session/session-persistence-sqlite/resources/sql/select-schema-objects.sql:1-4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-schema-objects.sql#L1-L4)）

### packages/session/session-persistence-sqlite/resources/sql/select-session-key.sql

包内 SQL 资源，由 `sql('select-session-key')` 读入，把公开会话标识翻译为内部行键。

- 按绑定的 `session_key` 查出 `sessions.id` 这个内部整型键；查不到则无行返回（[packages/session/session-persistence-sqlite/resources/sql/select-session-key.sql:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-session-key.sql#L1-L3)）

### packages/session/session-persistence-sqlite/resources/sql/select-session.sql

包内 SQL 资源，由 `sql('select-session')` 读入，用于按标识取单个会话的头部字段。

- 按绑定的 `session_key` 取一行会话头，并把 `session_key` 列以 `AS id` 改名返回，连同 `version`、`created_at`、`cwd`、`parent_session`、`seed_length`、`origin`、`delegation_depth`、`agent_preset`、`incarnation`、`revision`（[packages/session/session-persistence-sqlite/resources/sql/select-session.sql:1-4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-session.sql#L1-L4)）

### packages/session/session-persistence-sqlite/resources/sql/select-sessions.sql

包内 SQL 资源，由 `sql('select-sessions')` 读入，服务于会话枚举。

- 取 `sessions` 全部行的头部字段，同样把 `session_key` 以 `AS id` 改名后返回，不加过滤也不加排序（[packages/session/session-persistence-sqlite/resources/sql/select-sessions.sql:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-sessions.sql#L1-L3)）

### packages/session/session-persistence-sqlite/resources/sql/select-store-id.sql

包内 SQL 资源，由 `sql('select-store-id')` 读入，用于读取库的唯一标识。

- 取 `persistence_state` 中 `singleton = 1` 那一行的 `store_id`（[packages/session/session-persistence-sqlite/resources/sql/select-store-id.sql:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-store-id.sql#L1-L3)）

### packages/session/session-persistence-sqlite/resources/sql/select-synchronous.sql

包内 SQL 资源，由 `sql('select-synchronous')` 读入，用于回读同步级别。

- 发出 `PRAGMA synchronous`，读回该连接当前的同步落盘级别（[packages/session/session-persistence-sqlite/resources/sql/select-synchronous.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-synchronous.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/select-tail-events.sql

包内 SQL 资源，由 `sql('select-tail-events')` 读入，用于在追加前读取日志尾部若干行。

- 按绑定的 `session_id` 取物理行，按 `seq` 降序排列并以绑定参数作 `LIMIT`，从而只读尾部固定条数而不扫描全表（[packages/session/session-persistence-sqlite/resources/sql/select-tail-events.sql:1-5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-tail-events.sql#L1-L5)）

### packages/session/session-persistence-sqlite/resources/sql/select-trusted-schema.sql

包内 SQL 资源，由 `sql('select-trusted-schema')` 读入，用于回读可信模式开关。

- 发出 `PRAGMA trusted_schema`，读回该连接当前的 trusted schema 取值（[packages/session/session-persistence-sqlite/resources/sql/select-trusted-schema.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-trusted-schema.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/select-user-object-count.sql

包内 SQL 资源，由 `sql('select-user-object-count')` 读入，用于判断一个未版本化的库是否为空白库。

- 统计 `sqlite_schema` 中名字不匹配 `sqlite_*` 的对象数量，以 `count` 列返回（[packages/session/session-persistence-sqlite/resources/sql/select-user-object-count.sql:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-user-object-count.sql#L1-L3)）

### packages/session/session-persistence-sqlite/resources/sql/select-user-version.sql

包内 SQL 资源，由 `sql('select-user-version')` 读入，用于启动与追加前的模式版本闸门。

- 发出 `PRAGMA user_version`，读回数据库头部记录的模式版本号（[packages/session/session-persistence-sqlite/resources/sql/select-user-version.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/select-user-version.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/set-application-id.sql

包内 SQL 资源，由 `sql('set-application-id')` 读入，在新建数据库时写入归属标记。

- 发出 `PRAGMA application_id = 1146308688`，把固定的应用标识写进数据库头部，后续打开时据此判定库归属（[packages/session/session-persistence-sqlite/resources/sql/set-application-id.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/set-application-id.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/set-user-version-19.sql

包内 SQL 资源，由 `sql('set-user-version-19')` 读入，在新建数据库建表后写入模式版本。

- 发出 `PRAGMA user_version = 19`，把新库的模式版本固定为 19（[packages/session/session-persistence-sqlite/resources/sql/set-user-version-19.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/set-user-version-19.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/synchronous-full.sql

包内 SQL 资源文件，由 `sql('synchronous-full')` 读取后在 `configureDurability` 中执行。

- 把连接的 `synchronous` 设为 `FULL`，随后代码读回该值并要求等于 2（[packages/session/session-persistence-sqlite/resources/sql/synchronous-full.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/synchronous-full.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/trusted-schema-off.sql

包内 SQL 资源文件，由 `sql('trusted-schema-off')` 读取后在 `configureConnectionSecurity` 中最先执行。

- 关闭连接的 `trusted_schema`，随后代码读回该值并要求等于 0（[packages/session/session-persistence-sqlite/resources/sql/trusted-schema-off.sql:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/trusted-schema-off.sql#L1)）

### packages/session/session-persistence-sqlite/resources/sql/update-session-revision.sql

包内 SQL 资源文件，由 `store.ts` 的 `incrementRevision` 在追加、修复事务内执行。

- 按 `session_key` 把 `sessions.revision` 自增 1，调用方要求受影响行数恰为 1（[packages/session/session-persistence-sqlite/resources/sql/update-session-revision.sql:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/update-session-revision.sql#L1-L3)）

### packages/session/session-persistence-sqlite/resources/sql/upsert-session.sql

包内 SQL 资源文件，由 `store.ts` 的 `writeRow` 在写入会话元数据时执行。

- 插入会话元数据行，`revision` 初值写 0（[packages/session/session-persistence-sqlite/resources/sql/upsert-session.sql:1-4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/upsert-session.sql#L1-L4)）
- `session_key` 冲突时改为更新 version/created_at/cwd/parent_session/seed_length/origin/delegation_depth/agent_preset，不覆盖 `incarnation` 与 `revision`（[packages/session/session-persistence-sqlite/resources/sql/upsert-session.sql:5-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/upsert-session.sql#L5-L13)）
- `RETURNING id` 把内部行号回给调用方作为后续事件插入的外键（[packages/session/session-persistence-sqlite/resources/sql/upsert-session.sql:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/resources/sql/upsert-session.sql#L14)）

### packages/session/session-persistence-sqlite/src/codec.ts

物理行编解码模块，被 `compression.ts` 与 `store.ts` 用来把逻辑事件打包成 schema-19 行、以及把行还原成事件。

- 定义打包行的成员下限 3、上限 1024、data 列 UTF-8 字节上限 1048576（[packages/session/session-persistence-sqlite/src/codec.ts:41-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L41-L46)）
- `classify` 按事件类型、字段集合、seq/time 安全整数、chunk 字段逐项检查，决定一个事件是否可参与打包（[packages/session/session-persistence-sqlite/src/codec.ts:56-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L56-L82)）
- `continues` 要求 seq 连续、time 差为安全整数、turn/step/index 相同，且 tool-call 的 id 与 name 存在性一致，才把下一事件并入同一游程（[packages/session/session-persistence-sqlite/src/codec.ts:92-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L92-L102)）
- `buildRow` 把游程压成一行：首事件的 seq/time 作信封，其余时间存为相邻差值数组 `dt`，文本或 argumentsDelta 存为字符串数组（[packages/session/session-persistence-sqlite/src/codec.ts:104-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L104-L133)）
- `emitBoundedRun` 先试最大切片，超字节上限时二分搜索最大可接受成员数，找不到可接受切片则退化为写单条标量事件（[packages/session/session-persistence-sqlite/src/codec.ts:139-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L139-L174)）
- `packChunkRuns` 顺序扫描事件，遇到不可打包事件或游程中断即 flush，输出标量与打包记录的等序混合列表（[packages/session/session-persistence-sqlite/src/codec.ts:181-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L181-L210)）
- `validateRunData` 对读回的打包数据校验 turn/step/index 类型、成员数范围、成员均为字符串、`dt` 全为安全整数且长度等于成员数减一、序列化字节不超上限，任一不满足即抛错（[packages/session/session-persistence-sqlite/src/codec.ts:216-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L216-L241)）
- `validateRow` 校验信封字段集合、seq0 非负、time0 安全整数、tool-call 的 id/name 字段形态，并逐段累加 `dt` 检查还原出的 seq 与 time 不越出安全整数（[packages/session/session-persistence-sqlite/src/codec.ts:243-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L243-L274)）
- `expandRow` 按行类型重建 text-delta / reasoning-delta / tool-call-delta，seq 从 seq0 递增、time 由 `dt` 累加，产出逻辑事件序列（[packages/session/session-persistence-sqlite/src/codec.ts:276-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L276-L308)）
- `decodeStorageRecord` 按 `type` 判定是否为三种打包标签，非打包值原样当作单条事件返回（[packages/session/session-persistence-sqlite/src/codec.ts:315-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L315-L322)）
- `decodeSerializedChunkRow` 在 `JSON.parse` 之前先按字节数拒绝超限输入，再走 `validateRow`/`expandRow`（[packages/session/session-persistence-sqlite/src/codec.ts:333-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/codec.ts#L333-L342)）

### packages/session/session-persistence-sqlite/src/compression.ts

物理行压缩与扫描模块，被 `store.ts` 用于绑定插入参数、解码读回行、以及判定可保留的逻辑前缀。

- 模块加载时同步读入 zstd 字典文件，其字节参与物理格式（[packages/session/session-persistence-sqlite/src/compression.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L37-L42)）
- 固定 data 列压缩选项为该字典加压缩级别 3（[packages/session/session-persistence-sqlite/src/compression.ts:44-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L44-L48)）
- `decodeRow` 按 `is_packed` 分支；打包行必须是三种 chunk 标签之一，且 `source_event_seqs` 与 `surface_op` 必须为 null，否则抛错（[packages/session/session-persistence-sqlite/src/compression.ts:61-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L61-L68)）
- `decodeRow` 解压 data 时传入最大输出长度上限（[packages/session/session-persistence-sqlite/src/compression.ts:69-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L69-L74)）
- `bindRecord` 把打包行的 `seq0`/`time0` 映射到 seq/time 列并置 `isPacked=1`、两个 surface 列置 null（[packages/session/session-persistence-sqlite/src/compression.ts:82-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L82-L93)）
- `bindRecord` 对标量事件把 `sourceEventSeqs` 编码为 blob、`surfaceOp` 序列化为 JSON 文本，未定义者写 null（[packages/session/session-persistence-sqlite/src/compression.ts:94-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L94-L107)）
- `encodeData` 压缩后只有更短时才写压缩字节，否则写原文本（[packages/session/session-persistence-sqlite/src/compression.ts:109-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L109-L113)）
- `decodeData` 对 blob 用同一字典解压并以 fatal UTF-8 解码，非法字节序列直接抛错（[packages/session/session-persistence-sqlite/src/compression.ts:115-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L115-L121)）
- `encodeSourceEventSeqs` 拒绝非负安全整数以外的值，并生成 zigzag 差值编码（标签 0）（[packages/session/session-persistence-sqlite/src/compression.ts:123-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L123-L141)）
- 序列严格递增时另外生成游程编码（标签 1），并只写出两者中更短的字节串（[packages/session/session-persistence-sqlite/src/compression.ts:143-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L143-L159)）
- `appendVarint` 以 7 位分组小端写出 varint 字节（[packages/session/session-persistence-sqlite/src/compression.ts:166-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L166-L173)）
- `decodeSourceEventSeqs` 空字节返回空数组，单字节视为截断，首字节非 0/1 视为未知编码标签（[packages/session/session-persistence-sqlite/src/compression.ts:175-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L175-L185)）
- `decodeDeltaVarints` 逐个还原 zigzag 差值并要求结果落在 0 到最大安全整数之间（[packages/session/session-persistence-sqlite/src/compression.ts:187-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L187-L207)）
- `decodeRunVarints` 要求每段长度为正、段起点严格递增、段末在安全整数内，且累计条目数不超过传入的上限（[packages/session/session-persistence-sqlite/src/compression.ts:209-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L209-L231)）
- `readVarint` 拒绝非规范编码、超限值以及移位超过 56 位或字节截断的输入（[packages/session/session-persistence-sqlite/src/compression.ts:233-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L233-L259)）
- `decodeScalarRow` 解码 data 后 JSON 解析，并按需还原 `sourceEventSeqs`（以本行 seq 作为条目数上限）与 `surfaceOp`（[packages/session/session-persistence-sqlite/src/compression.ts:265-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L265-L281)）
- `scanRows` 先自后向前找出最后一个含 `turn/end` 的物理行（[packages/session/session-persistence-sqlite/src/compression.ts:295-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L295-L305)）
- `scanRows` 顺序展开各行并要求 seq 从 `base` 起连续；解码失败或不连续时，若该行位于最后 `turn/end` 之前则抛出损坏错误，否则返回已保留前缀与可删除的物理尾起点 `tornFrom`（[packages/session/session-persistence-sqlite/src/compression.ts:307-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/compression.ts#L307-L340)）

### packages/session/session-persistence-sqlite/src/index.ts

包入口，导出并默认导出 SQLite 持久化服务类，由组合装配挂载为 `SessionPersistence` 提供方。

- 类字段声明该提供方不支持原始工件、并固定服务名（[packages/session/session-persistence-sqlite/src/index.ts:55-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/index.ts#L55-L56)）
- 声明注入 `sessions`（[packages/session/session-persistence-sqlite/src/index.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/index.ts#L58)）
- 配置模式限定 `journalMode` 取值集合、busyTimeoutMs 上限、缓存条数与批写延迟范围，并给出各自默认值（[packages/session/session-persistence-sqlite/src/index.ts:60-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/index.ts#L60-L67)）
- 构造时以解析后的配置创建 `SqliteStore` 与 `PersistenceCoordinator`（[packages/session/session-persistence-sqlite/src/index.ts:72-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/index.ts#L72-L87)）
- `Service.init` 阶段先做路径校验，不加载 Node SQLite（[packages/session/session-persistence-sqlite/src/index.ts:89-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/index.ts#L89-L92)）
- `locate` 恒返回 undefined，即不对外暴露每会话独立工件位置（[packages/session/session-persistence-sqlite/src/index.ts:94-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/index.ts#L94-L97)）
- 创建、物化、追加、准备、加载、检视、借用、增量读取一律转交协调器（[packages/session/session-persistence-sqlite/src/index.ts:99-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/index.ts#L99-L133)）
- `list` 与 `listSnapshots` 绕过协调器直接读取存储层（[packages/session/session-persistence-sqlite/src/index.ts:135-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/index.ts#L135-L141)）
- 默认导出服务类，供 Loader 作为服务插件装载（[packages/session/session-persistence-sqlite/src/index.ts:144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/index.ts#L144)）

### packages/session/session-persistence-sqlite/src/invariant.ts

本包的不变量伴生插件模块，由不变量注册表在装载时调用。

- 以空安装器登记包名，占位说明本包无连续的进程内不变量关系（[packages/session/session-persistence-sqlite/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/invariant.ts#L17-L21)）
- `apply` 向 `ctx.invariants` 注册该包并返回其 disposer（[packages/session/session-persistence-sqlite/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/invariant.ts#L28-L29)）

### packages/session/session-persistence-sqlite/src/schema.ts

数据库打开、模式归属校验与落盘行解码模块，被 `store.ts` 在开库与每次写事务中调用。

- 固定 schema 版本号 19 与保留的 application id（[packages/session/session-persistence-sqlite/src/schema.ts:17-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L17-L20)）
- `openDatabase` 以 busyTimeout 计算截止时刻并建立连接，依次做连接安全、库配置、日志模式、耐久度配置，任一步失败即关闭连接并抛出（[packages/session/session-persistence-sqlite/src/schema.ts:71-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L71-L89)）
- `configureConnectionSecurity` 关闭 trusted_schema 与 mmap 并读回校验，文件库还要求 mmap_size 为 0（[packages/session/session-persistence-sqlite/src/schema.ts:91-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L91-L105)）
- `configureDatabase` 设 page_size、开启外键，并在 immediate 事务内检查 user_version、application_id 与用户对象计数：未版本化却已有身份或对象、版本不等于 19、版本非零但 application id 不符，都拒绝打开（[packages/session/session-persistence-sqlite/src/schema.ts:107-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L107-L133)）
- 空库时初始化模式，随后校验模式对象并提交；异常路径回滚且保留原始错误（[packages/session/session-persistence-sqlite/src/schema.ts:134-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L134-L149)）
- `selectJournalMode` 在遇到 SQLite busy 时按 10ms 间隔重试直到截止时刻，并要求返回的模式与请求一致（内存库要求 `memory`）（[packages/session/session-persistence-sqlite/src/schema.ts:152-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L152-L176)）
- `configureDurability` 执行 synchronous=FULL 并读回要求等于 2（[packages/session/session-persistence-sqlite/src/schema.ts:178-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L178-L185)）
- `isSqliteBusy` 以 `errcode === 5` 判定忙错误（[packages/session/session-persistence-sqlite/src/schema.ts:187-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L187-L191)）
- `journalResource` 把四种日志模式映射到固定资源名（[packages/session/session-persistence-sqlite/src/schema.ts:193-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L193-L204)）
- `initializeDatabase` 建表、写入随机 UUID 的持久化状态行、写 application id 与 user_version=19（[packages/session/session-persistence-sqlite/src/schema.ts:206-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L206-L211)）
- `expectedSchema` 在内存库里执行同一份建表脚本得到基准模式对象，并进程内缓存一次（[packages/session/session-persistence-sqlite/src/schema.ts:213-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L213-L226)）
- `schemaObjects` 读出模式对象并把 SQL 文本按空白归一化（[packages/session/session-persistence-sqlite/src/schema.ts:228-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L228-L242)）
- `validateRequiredSchema` 用 JSON 串比较实际与基准模式对象，不等即拒绝该数据库（[packages/session/session-persistence-sqlite/src/schema.ts:244-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L244-L252)）
- `validateSchemaForMutation` 在调用方的写事务内重查 application id、模式对象与版本号，任一变化即中止本次变更（[packages/session/session-persistence-sqlite/src/schema.ts:261-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L261-L277)）
- `decodeSessionRow` 校验 id/version/created_at/revision，要求 cwd 为绝对路径、origin 只能是 `subagent` 或 null、incarnation 必须是 UUID（[packages/session/session-persistence-sqlite/src/schema.ts:284-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L284-L308)）
- `decodeEventRow` 要求 `is_packed` 只能是 0 或 1，并逐列校验 seq/type/time/data/surface 列的类型（[packages/session/session-persistence-sqlite/src/schema.ts:315-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L315-L330)）
- `decodeStoreIdentity` 要求存储身份是 UUID（[packages/session/session-persistence-sqlite/src/schema.ts:337-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L337-L341)）
- `rowToMeta` 把行还原为会话头，null 列一律省略而非写入 undefined 字段（[packages/session/session-persistence-sqlite/src/schema.ts:348-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L348-L360)）
- 一组字段取值器对每列施加对象、字符串、非空、blob、安全整数、非负、可空等约束，违反即抛错（[packages/session/session-persistence-sqlite/src/schema.ts:362-425](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/schema.ts#L362-L425)）

### packages/session/session-persistence-sqlite/src/sql.ts

SQL 资源加载模块，被 `schema.ts` 与 `store.ts` 用来按名取语句文本。

- 以字面量元组固定可加载的资源名集合，类型层面排除任意名字（[packages/session/session-persistence-sqlite/src/sql.ts:9-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/sql.ts#L9-L49)）
- `sql` 首次按名同步读盘取语句文本并进程内缓存，后续命中缓存（[packages/session/session-persistence-sqlite/src/sql.ts:51-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/sql.ts#L51-L67)）

### packages/session/session-persistence-sqlite/src/store.ts

SQLite 存储实现，作为持久化协调器的后端被 `index.ts` 创建并调用。

- `validatePath` 与 `open` 各自把一次性操作缓存成 Promise，重复调用共享同一次结果（[packages/session/session-persistence-sqlite/src/store.ts:68-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L68-L84)）
- `preparePath` 解析绝对路径、以 0700 递归建父目录、校验父目录与已存在的库文件（[packages/session/session-persistence-sqlite/src/store.ts:86-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L86-L94)）
- `openDb` 先建库文件并复校，再惰性加载 Node SQLite 并开库（[packages/session/session-persistence-sqlite/src/store.ts:96-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L96-L109)）
- `openDb` 读取并校验 store_id，把内存库与文件库分别组合成 `memory:store:…` 与含 dev/ino/birthtime 的 `file:…` 身份串；失败即关库（[packages/session/session-persistence-sqlite/src/store.ts:110-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L110-L132)）
- `loadStored` 在读事务里取元数据行与全部事件行，经 `scanRows` 得到保留前缀，并附带 revision 与可选 `tornMarker`（[packages/session/session-persistence-sqlite/src/store.ts:134-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L134-L151)）
- `readStoredRevision` 只读元数据行换算 revision（[packages/session/session-persistence-sqlite/src/store.ts:153-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L153-L158)）
- `loadStoredFrom` 取覆盖 `fromSeq` 的物理跨度、扫描后再按 seq 过滤出后缀（[packages/session/session-persistence-sqlite/src/store.ts:160-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L160-L171)）
- `appendBatch` 空批直接返回，并在 immediate 事务内重校模式归属（[packages/session/session-persistence-sqlite/src/store.ts:173-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L173-L183)）
- `appendBatch` 由尾部物理行算出已存下一个 seq，与本批首事件 seq 不符即抛错（[packages/session/session-persistence-sqlite/src/store.ts:184-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L184-L190)）
- `appendBatch` 把本批事件打包后逐条插入、自增 revision 并提交，异常走统一回滚（[packages/session/session-persistence-sqlite/src/store.ts:192-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L192-L198)）
- `materializeHeader` 在事务内只写元数据行（[packages/session/session-persistence-sqlite/src/store.ts:201-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L201-L212)）
- `commitRepair` 无撕裂且无补写事件时直接返回（[packages/session/session-persistence-sqlite/src/store.ts:214-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L214-L220)）
- `commitRepair` 重算当前撕裂点，与传入的 `tornMarker` 不一致即判定修复过期；传入为空但当前有撕裂尾也报错（[packages/session/session-persistence-sqlite/src/store.ts:227-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L227-L237)）
- `commitRepair` 删除撕裂点起的物理行、校验补写事件起始 seq、逐条插入并自增 revision（[packages/session/session-persistence-sqlite/src/store.ts:232-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L232-L249)）
- `list` 与 `listSnapshots` 读全部元数据行并分别产出会话头、以及会话头加 revision（[packages/session/session-persistence-sqlite/src/store.ts:255-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L255-L275)）
- `close` 等待路径校验与开库 Promise 落定后才关闭连接，且只在真正打开过时关一次（[packages/session/session-persistence-sqlite/src/store.ts:277-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L277-L286)）
- `sessionKey` 找不到元数据行即抛错（[packages/session/session-persistence-sqlite/src/store.ts:293-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L293-L297)）
- `observe` 在开库前后各检查一次取消信号（[packages/session/session-persistence-sqlite/src/store.ts:299-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L299-L303)）
- `readTransaction` 把读操作包进 begin/commit，失败走回滚（[packages/session/session-persistence-sqlite/src/store.ts:305-314](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L305-L314)）
- `rollback` 回滚成功则重抛原错误，回滚也失败则抛出聚合错误（[packages/session/session-persistence-sqlite/src/store.ts:320-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L320-L328)）
- `incrementRevision` 要求更新恰好影响一行，否则抛出元数据行缺失（[packages/session/session-persistence-sqlite/src/store.ts:330-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L330-L335)）
- `tailRows` 取末尾两行反转后，以其首行 seq 为起点重新取一段物理跨度（[packages/session/session-persistence-sqlite/src/store.ts:337-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L337-L341)）
- `physicalSpanFrom` 以 `fromSeq - 最大打包成员数 + 1` 为下界查找可能覆盖该 seq 的打包前驱行，前驱解码失败时也把它纳入以便扫描器失败关闭（[packages/session/session-persistence-sqlite/src/store.ts:343-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L343-L364)）
- `logicalLastEvent` 在物理尾撕裂时抛错而不是静默截断（[packages/session/session-persistence-sqlite/src/store.ts:366-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L366-L371)）
- `insertRecord` 按固定顺序绑定 session_key/seq/type/time/data/source_event_seqs/surface_op/is_packed 八个参数（[packages/session/session-persistence-sqlite/src/store.ts:377-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L377-L388)）
- `writeRow` 每次 upsert 都生成新的随机 UUID 作 incarnation 参数（[packages/session/session-persistence-sqlite/src/store.ts:390-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L390-L404)）
- `sqliteRevision` 把存储身份、incarnation 与 revision 拼成对外的持久化修订标识（[packages/session/session-persistence-sqlite/src/store.ts:407-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L407-L411)）
- `createDatabaseFile` 以 `wx` 加 0600 创建库文件，已存在则忽略（[packages/session/session-persistence-sqlite/src/store.ts:413-420](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L413-L420)）
- `validateParentDirectory` 拒绝符号链接与非目录，并在 POSIX 上要求属主为当前用户且非组/他人可写（[packages/session/session-persistence-sqlite/src/store.ts:422-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L422-L434)）
- `validateDatabaseFile` 拒绝符号链接与非常规文件，并在 POSIX 上要求属主为当前用户且权限位仅属主可访问（[packages/session/session-persistence-sqlite/src/store.ts:436-448](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L436-L448)）
- `validateDatabaseFileIfPresent` 只吞掉 ENOENT，其余校验失败照常抛出（[packages/session/session-persistence-sqlite/src/store.ts:450-456](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L450-L456)）
- `loadNodeSqlite` 把 `node:sqlite` 的动态导入缓存成单个进程级 Promise（[packages/session/session-persistence-sqlite/src/store.ts:458-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L458-L464)）
- `importNodeSqlite` 在导入期间临时替换 `process.emitWarning`，只丢弃 SQLite 实验特性警告，随后无条件恢复原函数（[packages/session/session-persistence-sqlite/src/store.ts:466-491](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-persistence-sqlite/src/store.ts#L466-L491)）

### packages/session/session-persistence-sqlite/tsconfig.json

本包的 TypeScript 编译配置，声明源目录、输出目录与工作区项目引用。

- 无运行期机制
