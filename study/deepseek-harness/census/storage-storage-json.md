---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/storage/storage-json
---

# packages/storage/storage-json

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、70 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/storage/storage-json/README.md

包的说明文档，描述 JSON 后端的两种介质布局、配置字段、可观察行为与文件格式。

- 无运行期机制

### packages/storage/storage-json/package.json

包清单，声明入口、导出映射与发布文件集。

- `exports` 暴露根入口 `lib/index.js`、`./invariant` 入口 `lib/invariant.js`，以及 `./src/*` 与 `./package.json`（[packages/storage/storage-json/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/package.json#L16-L27)）
- `files` 限定发布内容为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/storage/storage-json/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/package.json#L28-L32)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/storage/storage-json/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/package.json#L14-L15)）

### packages/storage/storage-json/src/atomic.ts

原子整文件替换的公用函数，被两种布局的写路径调用。

- 临时文件建在目标同目录下，名字用 `randomUUID` 生成并以点开头、`.tmp` 结尾（[packages/storage/storage-json/src/atomic.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/atomic.ts#L25)）
- 以 `wx` 模式、`0o600` 权限新建临时文件，写入后调 `handle.sync()` 落盘，再在 finally 里关闭句柄（[packages/storage/storage-json/src/atomic.ts:27-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/atomic.ts#L27-L33)）
- 用 `rename` 把临时文件覆盖到目标路径，再对父目录做 fsync（[packages/storage/storage-json/src/atomic.ts:34-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/atomic.ts#L34-L35)）
- 任一步失败都以 `force` 删掉临时文件后重抛原错误（[packages/storage/storage-json/src/atomic.ts:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/atomic.ts#L36-L39)）
- `fsyncDirectory` 在 win32 上直接返回，其余平台以只读打开目录并 sync（[packages/storage/storage-json/src/atomic.ts:44-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/atomic.ts#L44-L52)）

### packages/storage/storage-json/src/format.ts

两种布局的文档序列化与解析，含版本校验；被 `single-unit.ts` 与 `per-record-unit.ts` 调用。

- `serialize` 把内存态摊成 `{ unit: { name, version }, global, tables }` 文档，两空格缩进并补一个结尾换行（[packages/storage/storage-json/src/format.ts:28-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L28-L39)）
- `parse` 遇到非法 JSON 抛 `malformed-medium` 并带 `cause`（[packages/storage/storage-json/src/format.ts:48-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L48-L53)）
- 顶层不是对象时抛 `malformed-medium`（[packages/storage/storage-json/src/format.ts:54-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L54-L56)）
- unit 头缺失、名字与描述符不符或版本不是数字时抛 `malformed-medium`（[packages/storage/storage-json/src/format.ts:57-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L57-L64)）
- 存储版本与描述符版本不等时抛 `version-mismatch`（[packages/storage/storage-json/src/format.ts:65-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L65-L71)）
- `tables` 不是对象时抛 `malformed-medium`（[packages/storage/storage-json/src/format.ts:72-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L72-L74)）
- 缺失的 global 归一成 `null`（[packages/storage/storage-json/src/format.ts:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L75)）
- 只按描述符声明的表读取：文件里缺的表建成空映射，非对象或数组的表抛 `malformed-medium`，文件里多余的表被忽略（[packages/storage/storage-json/src/format.ts:76-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L76-L86)）
- `serializeRecord` 把单条记录写成 `{ version, record }` 文档，同样两空格缩进加结尾换行（[packages/storage/storage-json/src/format.ts:97-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L97-L99)）
- `parseRecord` 对非法 JSON、非对象文档、版本戳不符三种情况一律返回 `undefined`（读作记录不存在），否则返回 `record` 字段（[packages/storage/storage-json/src/format.ts:112-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/format.ts#L112-L123)）

### packages/storage/storage-json/src/index.ts

插件入口：JSON 后端类、`root` 配置与在存储枢纽上的 `json` 注册。

- `inject = ['storage']` 让后端只在枢纽就绪后装载（[packages/storage/storage-json/src/index.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L20)）
- `Config` 只有一个必填字符串字段 `root`，没有默认值（[packages/storage/storage-json/src/index.ts:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L34-L36)）
- `kv.open` 在后端已关闭时抛 `StorageError('closed')`（[packages/storage/storage-json/src/index.ts:51-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L51-L52)）
- 打开前先校验描述符名字（[packages/storage/storage-json/src/index.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L53)）
- 已打开或正在打开的同名 unit 直接抛错，一个 unit 只有一个活句柄（[packages/storage/storage-json/src/index.ts:54-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L54-L57)）
- 在第一个 await 之前把 opening 槽位同步占住，完成后在 finally 里释放（[packages/storage/storage-json/src/index.ts:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L58-L60)）
- 打开 unit 前按需以 `0o700` 递归创建 root 目录（[packages/storage/storage-json/src/index.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L65)）
- 按描述符的 `layout` 分派到 per-record 或 single 打开函数，并传入释放开槽的 `onClose`（[packages/storage/storage-json/src/index.ts:68-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L68-L71)）
- 若打开期间后端被关闭，则关掉刚建好的 unit 并抛 `closed`，不把活句柄交出去（[packages/storage/storage-json/src/index.ts:72-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L72-L77)）
- 成功后把 unit 记入 open 表（[packages/storage/storage-json/src/index.ts:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L78)）
- `close` 先置 closed，再等所有在飞的 open 结算，再逐个关闭已打开的 unit（[packages/storage/storage-json/src/index.ts:82-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L82-L90)）
- `validateDescriptor` 对不匹配 `UNIT_NAME_RE` 的 unit 名和表名抛 `malformed-medium`（[packages/storage/storage-json/src/index.ts:93-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L93-L102)）
- `apply` 用 `ctx.effect` 把后端以名字 `json` 注册到枢纽，卸载时先注销名字再关闭后端（[packages/storage/storage-json/src/index.ts:110-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L110-L117)）
- 另以 `json` 的后端服务键把实例 provide 到上下文（[packages/storage/storage-json/src/index.ts:118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/index.ts#L118)）

### packages/storage/storage-json/src/invariant.ts

包自带的不变量伴生插件，声明本包没有可持续观察的进程内关系。

- `inject = ['invariants']` 让伴生插件等不变量服务就绪后才装载（[packages/storage/storage-json/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/invariant.ts#L15)）
- 安装器是空函数，不注册任何监听或检查（[packages/storage/storage-json/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/invariant.ts#L23)）
- `apply` 仍用包名向不变量服务注册这个空安装器并返回 disposer（[packages/storage/storage-json/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/invariant.ts#L30-L31)）

### packages/storage/storage-json/src/per-record-unit.ts

`per-record` 布局的一个已打开 unit：目录即状态，每条记录一份文档，另含旧整文件的一次性引导。

- 记录键必须匹配 `SAFE_KEY_RE`（`[a-zA-Z0-9_-]+`），因为键要作为路径片段（[packages/storage/storage-json/src/per-record-unit.ts:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L36)）
- `openPerRecordUnit` 只构造对象、不碰介质，unit 目录取 `<root>/<name>`（[packages/storage/storage-json/src/per-record-unit.ts:48-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L48-L54)）
- `loadPerRecordState` 先按描述符声明的表铺出空映射、global 置 `null`（[packages/storage/storage-json/src/per-record-unit.ts:66-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L66-L71)）
- 读目录时 ENOENT 视为空 unit 继续往下走，其它错误抛出（[packages/storage/storage-json/src/per-record-unit.ts:72-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L72-L79)）
- 并发遍历目录项：是声明表的子目录就读其记录，是 `global.json` 且描述符声明了 global 就读进 state，任一项命中就置 `hasNewDocuments`（[packages/storage/storage-json/src/per-record-unit.ts:80-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L80-L95)）
- 新树上一份文档都没有时才触发旧整文件引导（[packages/storage/storage-json/src/per-record-unit.ts:96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L96)）
- 引导读 `<root>/<name>.json`，ENOENT 直接返回，其它读错误抛出（[packages/storage/storage-json/src/per-record-unit.ts:110-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L110-L118)）
- 旧文件 JSON 解析失败时静默返回，不改也不删该文件（[packages/storage/storage-json/src/per-record-unit.ts:122-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L122-L127)）
- 旧文件 `unit.name` 与本 unit 不符、或 `tables` 不是对象时同样放弃引导（[packages/storage/storage-json/src/per-record-unit.ts:128-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L128-L130)）
- 引导把旧文件里属于声明表的每条记录以当前版本戳写成独立文档（先建父目录 `0o700` 再原子写），并同步进内存态；未声明的表跳过（[packages/storage/storage-json/src/per-record-unit.ts:132-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L132-L141)）
- `loadTableRecords` 以"目录里是否存在任意 `.json` 路径"作为返回值，与键是否安全、能否读出无关（[packages/storage/storage-json/src/per-record-unit.ts:149-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L149-L151)）
- 只把后缀为 `.json` 且去掉后缀后匹配 `SAFE_KEY_RE` 的文件当记录读入，解析为 undefined 的丢弃（[packages/storage/storage-json/src/per-record-unit.ts:152-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L152-L162)）
- `readRecord` 把任何读或解析失败都归成 `undefined`，单份坏文档不影响整个 unit（[packages/storage/storage-json/src/per-record-unit.ts:166-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L166-L172)）
- `loadAll` 每次都重读目录树并投影成普通对象，先做打开断言（[packages/storage/storage-json/src/per-record-unit.ts:192-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L192-L200)）
- `putRecord` 断言打开、断言键路径安全，再把该记录原子写成 `<table>/<key>.json` 并纳入在飞集合（[packages/storage/storage-json/src/per-record-unit.ts:203-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L203-L207)）
- `deleteRecord` 以 `rm(..., { force: true })` 删除对应文档，缺失即空操作（[packages/storage/storage-json/src/per-record-unit.ts:210-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L210-L214)）
- `setGlobal` 在描述符未声明 global 时抛错，否则原子写 `global.json`（[packages/storage/storage-json/src/per-record-unit.ts:217-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L217-L223)）
- `close` 幂等：重复调用也等在飞写结算，首次调用置 closed、排空后回调 `onClose`（[packages/storage/storage-json/src/per-record-unit.ts:227-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L227-L235)）
- `assertOpen` 在关闭后让所有操作抛 `StorageError('closed')`（[packages/storage/storage-json/src/per-record-unit.ts:237-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L237-L241)）
- `tableDir` 对描述符未声明的表名抛错（[packages/storage/storage-json/src/per-record-unit.ts:245-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L245-L250)）
- `writeDocument` 先以 `0o700` 递归建父目录，再原子写入带版本戳的记录文档（[packages/storage/storage-json/src/per-record-unit.ts:253-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L253-L258)）
- `tracked` 把写入登记进在飞集合，只在跟踪分支吞掉拒绝并在结算后移除，原 Promise 仍交给调用方（[packages/storage/storage-json/src/per-record-unit.ts:261-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L261-L267)）
- `assertSafeKey` 在写之前就拒绝不安全的键（[packages/storage/storage-json/src/per-record-unit.ts:271-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/per-record-unit.ts#L271-L275)）

### packages/storage/storage-json/src/single-unit.ts

`single` 布局的一个已打开 unit：内存态权威，每次写重排整份 `<root>/<name>.json`。

- 打开时读 `<root>/<name>.json`，ENOENT 视为空 unit（materialize 推迟到首次写），其它读错误抛出（[packages/storage/storage-json/src/single-unit.ts:33-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L33-L40)）
- 无文件时按描述符声明的表铺空映射，有文件时交给 `parse` 做格式与版本校验（[packages/storage/storage-json/src/single-unit.ts:41-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L41-L49)）
- `loadAll` 断言打开后，把内存态投影成普通对象返回（[packages/storage/storage-json/src/single-unit.ts:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L65-L72)）
- `putRecord` 先记下旧值与是否存在，改内存后发布整文件；发布失败时把内存回滚到写前状态再重抛（[packages/storage/storage-json/src/single-unit.ts:74-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L74-L87)）
- `deleteRecord` 对不存在的键直接返回、不发布；否则删内存后发布，失败时把旧值放回（[packages/storage/storage-json/src/single-unit.ts:89-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L89-L99)）
- `setGlobal` 在未声明 global 时抛错，否则改内存后发布，失败回滚旧值（[packages/storage/storage-json/src/single-unit.ts:101-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L101-L112)）
- `close` 幂等：重复调用也等在飞发布结算，首次调用置 closed、排空后回调 `onClose`（[packages/storage/storage-json/src/single-unit.ts:115-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L115-L123)）
- `assertOpen` 在关闭后让所有操作抛 `StorageError('closed')`（[packages/storage/storage-json/src/single-unit.ts:125-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L125-L129)）
- `records` 对描述符未声明的表名抛错（[packages/storage/storage-json/src/single-unit.ts:132-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L132-L138)）
- `publish` 每次把完整内存态序列化后原子替换整个文件，并把这次写登记进在飞集合、只在跟踪分支吞掉拒绝（[packages/storage/storage-json/src/single-unit.ts:140-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/storage/storage-json/src/single-unit.ts#L140-L147)）

### packages/storage/storage-json/tsconfig.json

包的 TypeScript 编译配置，声明源码根、输出目录与工程引用。

- 无运行期机制
