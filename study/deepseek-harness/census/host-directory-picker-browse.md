---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/host/directory-picker-browse
---

# packages/host/directory-picker-browse

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、40 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/host/directory-picker-browse/README.md

该浏览后端包的说明文档，描述列目录与建目录两个原语、失败词汇与配置项。

- 无运行期机制

### packages/host/directory-picker-browse/package.json

该包的 npm 清单，声明入口、导出子路径、发布文件集与依赖。

- `main`/`types` 指定包的默认运行时入口为 `lib/index.js`、类型入口为 `lib/types/index.d.ts`（[packages/host/directory-picker-browse/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/package.json#L14-L15)）
- `exports` 把 `.` 与 `./invariant` 映射到 `lib/index.js` 与 `lib/invariant.js`，并开放 `./src/*` 与 `./package.json`（[packages/host/directory-picker-browse/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/package.json#L16-L27)）
- `files` 限定发布进包的文件为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 d.ts（[packages/host/directory-picker-browse/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/package.json#L28-L32)）
- `dependencies` 把接缝包与配置校验库列为随包安装的运行期依赖（[packages/host/directory-picker-browse/package.json:34-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/package.json#L34-L37)）

### packages/host/directory-picker-browse/src/index.ts

该文件实现浏览后端服务：以 Node 标准库提供单层目录列举与单级子目录创建，并把失败映射成接缝定义的错误码。

- `ancestryCrumbs` 从目标目录沿 `dirname` 上溯到不动点，逐级 `unshift` 生成祖先链，根节点用完整路径作名字且所有面包屑的 `hidden` 恒为 false（[packages/host/directory-picker-browse/src/index.ts:28-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L28-L38)）
- `fullyQualified` 在 win32 上要求同时通过 `win32.isAbsolute` 与「盘符开头或完整 UNC」的正则，其他平台用 `posix.isAbsolute`（[packages/host/directory-picker-browse/src/index.ts:50-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L50-L54)）
- `boundedInsert` 在窗口已满且候选名不小于窗口末位时一次比较即拒绝并报告发生过淘汰（[packages/host/directory-picker-browse/src/index.ts:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L82)）
- `boundedInsert` 用二分定位插入点把候选放进按名升序的窗口（[packages/host/directory-picker-browse/src/index.ts:83-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L83-L92)）
- 插入后长度超过上限时弹出末位并返回 true，使窗口内存恒为 O(keep)（[packages/host/directory-picker-browse/src/index.ts:93-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L93-L95)）
- `raceAbort` 在无信号时直接返回原 promise（[packages/host/directory-picker-browse/src/index.ts:109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L109)）
- 中止发生时以信号的 reason 拒绝，并对被放弃的操作挂上 catch 吞掉其迟到的落定（[packages/host/directory-picker-browse/src/index.ts:111-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L111-L117)）
- 传入时已中止的信号立即走中止路径，不等待操作（[packages/host/directory-picker-browse/src/index.ts:118-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L118-L121)）
- 操作先落定时移除中止监听再向外传递值或错误（[packages/host/directory-picker-browse/src/index.ts:122-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L122-L132)）
- `asError` 把非 Error 的抛出值包装成 Error（[packages/host/directory-picker-browse/src/index.ts:137-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L137-L139)）
- `messageOf` 从未知抛出值提取用于错误文案的消息（[packages/host/directory-picker-browse/src/index.ts:147-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L147-L150)）
- `directoryRow` 对 dirent 未直接标记为目录的符号链接发起受信号约束的 `stat` 探测判断可进入性（[packages/host/directory-picker-browse/src/index.ts:161-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L161-L167)）
- 探测失败时若信号已中止则抛出中止原因，否则把该行判为不可进入并返回 null（[packages/host/directory-picker-browse/src/index.ts:168-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L168-L174)）
- 返回的行以名字是否以点开头作为 `hidden` 标记，路径为父目录与名字的拼接（[packages/host/directory-picker-browse/src/index.ts:177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L177)）
- 配置 schema 把 `maxEntries` 定为最小 1、默认 1000 的自然数，供 cordis.yml 覆写（[packages/host/directory-picker-browse/src/index.ts:195-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L195-L197)）
- 服务持有一个固定的 `browse` 能力对象，其 `list`/`createDirectory` 转发到私有方法，`capability()` 每次返回同一对象（[packages/host/directory-picker-browse/src/index.ts:199-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L199-L215)）
- `list` 对给定路径先过完全限定检查，不通过即抛 `directory-unreadable`（[packages/host/directory-picker-browse/src/index.ts:222-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L222-L224)）
- 未给路径时以 `homedir()` 作为列举目标（[packages/host/directory-picker-browse/src/index.ts:218-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L218-L225)）
- 窗口容量取 `maxEntries + 1`，多出的一格用于证明该层被截断（[packages/host/directory-picker-browse/src/index.ts:233-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L233-L235)）
- `opendir` 与调用方信号竞速，中止胜出时对迟到拿到的句柄补发 `close` 并吞掉关闭失败（[packages/host/directory-picker-browse/src/index.ts:241-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L241-L252)）
- 逐条 `read()` 同样与信号竞速，只有目录或符号链接的 dirent 进入窗口，发生淘汰即置 `evicted`（[packages/host/directory-picker-browse/src/index.ts:254-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L254-L262)）
- 退出扫描时一律关闭目录句柄，已中止的路径只挂 catch 不等待关闭完成（[packages/host/directory-picker-browse/src/index.ts:263-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L263-L276)）
- 扫描抛错时先按信号抛出中止，否则统一包装为带目标路径的 `directory-unreadable`（[packages/host/directory-picker-browse/src/index.ts:277-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L277-L281)）
- 逐个窗口候选生成行之前检查信号，已中止即抛出（[packages/host/directory-picker-browse/src/index.ts:284-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L284-L288)）
- 不可进入的候选被跳过，已产出行数达到 `maxEntries` 时置 `truncated` 并停止（[packages/host/directory-picker-browse/src/index.ts:289-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L289-L294)）
- 返回值由目标路径、home、祖先链、行数组与截断标记组成（[packages/host/directory-picker-browse/src/index.ts:296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L296)）
- `createDirectory` 对父路径过同一道完全限定检查，不通过即抛 `directory-create-failed`（[packages/host/directory-picker-browse/src/index.ts:302-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L302-L305)）
- 名字为空白、`.`、`..` 或含分隔符时抛 `directory-create-failed`（[packages/host/directory-picker-browse/src/index.ts:308-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L308-L310)）
- 以非递归 `mkdir` 建立目标目录并返回其绝对路径（[packages/host/directory-picker-browse/src/index.ts:311-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L311-L316)）
- `EEXIST` 映射为 `directory-exists`，其余失败映射为 `directory-create-failed` 并附原始消息（[packages/host/directory-picker-browse/src/index.ts:317-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/index.ts#L317-L322)）

### packages/host/directory-picker-browse/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名归属。

- `inject` 声明该伴生插件依赖 `invariants` 服务，未就绪则不执行 `apply`（[packages/host/directory-picker-browse/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/invariant.ts#L14)）
- installer 为空函数，注册后不安装任何运行期检查（[packages/host/directory-picker-browse/src/invariant.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/invariant.ts#L17)）
- `apply` 调用 `ctx.invariants.register` 以包名注册该 installer 并返回其 disposer（[packages/host/directory-picker-browse/src/invariant.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/src/invariant.ts#L24-L25)）

### packages/host/directory-picker-browse/tsconfig.json

该包的 TypeScript 编译配置，设定源目录、产物目录、类型集与项目引用。

- 无运行期机制

### packages/host/directory-picker-browse/tsdown.config.ts

该包的打包配置，决定发布产物中被实际加载的运行期文件。

- 以 `lib/types/index.js` 与 `lib/types/invariant.js` 为入口，按 node 平台、es2024 目标打成 esm 输出到 `lib`，不清理既有产物、不再生成 d.ts（[packages/host/directory-picker-browse/tsdown.config.ts:4-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-browse/tsdown.config.ts#L4-L15)）
