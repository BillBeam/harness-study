---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/sandbox/sandbox-windows-acl
---

# packages/sandbox/sandbox-windows-acl

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 16 个文件、101 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/sandbox/sandbox-windows-acl/README.md

包的说明文档，介绍受限令牌机制、两种模式的 restricting SID 列表、runner 的 argv 契约与已验证的边界。

- 无运行期机制

### packages/sandbox/sandbox-windows-acl/package.json

包清单，声明入口、导出映射、发布内容与原生依赖。

- `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/sandbox/sandbox-windows-acl/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/package.json#L14-L15)）
- `exports` 把根入口、`./runner`（被外部按路径加载的运行器入口）、`./invariant`、`./src/*` 与 `./package.json` 暴露为可导入子路径（[packages/sandbox/sandbox-windows-acl/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/package.json#L16-L31)）
- `files` 限定发布包内含三个运行期 bundle、拆分的 `lib/types-*.js` chunk 与类型声明（[packages/sandbox/sandbox-windows-acl/package.json:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/package.json#L32-L38)）
- 运行期依赖声明共享的 Win32 进程库与原生 FFI 绑定库 `koffi`（[packages/sandbox/sandbox-windows-acl/package.json:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/package.json#L44-L47)）

### packages/sandbox/sandbox-windows-acl/src/acl.ts

目录 DACL 的读改写原语：构造 ACE 条目、按路径加互斥文件锁、读取当前 DACL、合并应用，以及对外的授权与撤销函数；被 `index.ts`、`grant.ts`、`token.ts` 使用。

- `buildExplicitAccess` 按 48 字节布局打包 `EXPLICIT_ACCESS_W`：写入访问掩码、访问模式、`OI|CI` 继承标志、`TRUSTEE_IS_SID` 形式与 SID 指针地址（[packages/sandbox/sandbox-windows-acl/src/acl.ts:34-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L34-L44)）
- `lockFilePath` 以 `GetTempPathW` 的结果为根、路径小写化后 sha256 前 16 位十六进制为名，得到每个受保护目录唯一的锁文件路径（[packages/sandbox/sandbox-windows-acl/src/acl.ts:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L55-L58)）
- `withPathLock` 用 `CreateFileW`（`OPEN_ALWAYS`、共享读写但不共享删除）打开锁文件，失败即抛（[packages/sandbox/sandbox-windows-acl/src/acl.ts:76-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L76-L84)）
- 用零填充的 OVERLAPPED 对偏移 0 的一个字节做 `LOCKFILE_EXCLUSIVE_LOCK` 加锁，加锁失败先尽力关闭句柄再抛出该 Win32 码（[packages/sandbox/sandbox-windows-acl/src/acl.ts:85-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L85-L90)）
- 被保护动作抛错时先尽力解锁关句柄再重抛原错误，清理失败不掩盖原错误（[packages/sandbox/sandbox-windows-acl/src/acl.ts:92-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L92-L101)）
- 解锁与关闭句柄失败同样抛出带 API 名与 Win32 码的错误（[packages/sandbox/sandbox-windows-acl/src/acl.ts:102-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L102-L107)）
- `readCurrentDacl` 调 `GetNamedSecurityInfoW` 取目录当前显式 DACL 与其所属安全描述符，非成功码直接抛出（[packages/sandbox/sandbox-windows-acl/src/acl.ts:122-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L122-L134)）
- `mergeAndApply` 用 `SetEntriesInAclW` 把条目并入旧 DACL，合并失败或返回空 ACL 时释放描述符并抛出（[packages/sandbox/sandbox-windows-acl/src/acl.ts:156-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L156-L166)）
- 合并后先释放旧描述符，再用 `SetNamedSecurityInfoW` 落盘新 DACL，然后释放新 ACL，并按顺序检查应用结果与两次释放的结果（[packages/sandbox/sandbox-windows-acl/src/acl.ts:170-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L170-L178)）
- `hasExactGrant` 逐条走 ACE：先对 ACL 大小与每条 ACE 大小做上下界与越界检查，异常布局一律按"无精确授权"返回（[packages/sandbox/sandbox-windows-acl/src/acl.ts:196-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L196-L205)）
- 精确匹配要求 ACE 类型为允许、标志为 `OI|CI`、掩码等于 `GRANT_MASK`，且内联 SID 与目标 SID 逐字段相同（[packages/sandbox/sandbox-windows-acl/src/acl.ts:206-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L206-L212)）
- `grantWrite` 在路径锁内执行；若目录已带完全相同的 ACE 就只释放描述符并直接返回，跳过整棵树的继承传播（[packages/sandbox/sandbox-windows-acl/src/acl.ts:231-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L231-L241)）
- 否则以 `GRANT_ACCESS` + `GRANT_MASK` 合并进当前 DACL，保留既有显式 ACE（[packages/sandbox/sandbox-windows-acl/src/acl.ts:242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L242)）
- `revokeWrite` 在路径锁内执行；目录完全没有显式 DACL 时释放描述符并返回 false，否则以 `REVOKE_ACCESS` 合并移除该 SID 的全部 ACE 并返回 true（[packages/sandbox/sandbox-windows-acl/src/acl.ts:258-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/acl.ts#L258-L270)）

### packages/sandbox/sandbox-windows-acl/src/ffi.ts

在共享 Win32 进程绑定表之上扩展出 ACL/令牌相关的原生函数绑定，并提供指针分配与结构体解码工具；被本包其余源码使用。

- `isInvalidHandle` 把空指针、0 与全 1 哨兵一并判为 `CreateFileW` 的无效句柄（[packages/sandbox/sandbox-windows-acl/src/ffi.ts:107-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/ffi.ts#L107-L110)）
- 提供 uint32 编码、指针取地址、原始字节块分配等原生内存操作（[packages/sandbox/sandbox-windows-acl/src/ffi.ts:117-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/ffi.ts#L117-L137)）
- `allocOverlapped` 分配 32 字节零值块代替 NULL 传给加解锁 API（[packages/sandbox/sandbox-windows-acl/src/ffi.ts:145-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/ffi.ts#L145-L147)）
- `decodePtrAt` 从 Buffer 偏移解出指针，地址为零时归一化为 `null`（[packages/sandbox/sandbox-windows-acl/src/ffi.ts:155-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/ffi.ts#L155-L158)）
- 提供在原生指针偏移处按 uint8/uint16/uint32 解码字段的三个读取器（[packages/sandbox/sandbox-windows-acl/src/ffi.ts:166-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/ffi.ts#L166-L188)）
- `sameSidAt` 不分配字符串地比较两处内存中的 SID：先比 revision，再比子权威数量（并拒绝超过上限的数量），再比 6 字节权威与逐个子权威（[packages/sandbox/sandbox-windows-acl/src/ffi.ts:198-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/ffi.ts#L198-L218)）
- `bindings()` 惰性绑定并进程内缓存一整张 ACL/令牌 API 表：进程与令牌打开、局部内存分配释放、SID 转换与创建、令牌信息读写、受限令牌创建、ACL 读写、临时目录查询、环境变量写入、控制台 Ctrl 处理器、文件创建与字节范围加解锁（[packages/sandbox/sandbox-windows-acl/src/ffi.ts:220-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/ffi.ts#L220-L264)）
- `win32()` 与 `win32Sync()` 分别以异步和同步形式返回同一张缓存绑定表（[packages/sandbox/sandbox-windows-acl/src/ffi.ts:270-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/ffi.ts#L270-L280)）
- `getTempPath` 用 `MAX_PATH+1` 宽字符缓冲区调 `GetTempPathW`，返回 0 或所需长度超过缓冲区时抛出（后者带 `ERROR_INSUFFICIENT_BUFFER` 与"未写入任何内容"说明），成功时按 UTF-16LE 解码（[packages/sandbox/sandbox-windows-acl/src/ffi.ts:287-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/ffi.ts#L287-L299)）

### packages/sandbox/sandbox-windows-acl/src/grant.ts

服务端一侧的写授权物化对象 `AclWriteGrant`：把一个写 SID 的 ACE 加到若干目录上，并区分常驻与可撤销两类路径；由沙箱 seam 使用。

- `create` 把 SDDL 字符串解析成 SID 指针（必要时惰性打开绑定表），解析失败或得到空指针即抛，此时尚未授权任何目录（[packages/sandbox/sandbox-windows-acl/src/grant.ts:49-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/grant.ts#L49-L58)）
- `add` 先按 `standing` 把路径记入常驻表或可撤销表，再执行授权，使授权后抛错的路径仍会被撤销（[packages/sandbox/sandbox-windows-acl/src/grant.ts:74-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/grant.ts#L74-L77)）
- `paths` 以常驻在前、可撤销在后的顺序返回当前携带该授权的全部目录（[packages/sandbox/sandbox-windows-acl/src/grant.ts:80-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/grant.ts#L80-L82)）
- `dispose` 只撤销可撤销路径（常驻 ACE 保留），逐个收集撤销失败，再释放 SID 内存，最后把全部失败汇成 `AggregateError` 抛出（[packages/sandbox/sandbox-windows-acl/src/grant.ts:85-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/grant.ts#L85-L103)）

### packages/sandbox/sandbox-windows-acl/src/index.ts

包主入口，定义 `AclSandbox`：校验选项、建立受限令牌与 DACL 授权、以受限令牌派生子进程、并在释放时撤销可撤销授权。

- `freeSidBestEffort` 释放一个可选 SID，把失败收集进调用方的失败列表而不中断兄弟清理（[packages/sandbox/sandbox-windows-acl/src/index.ts:133-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L133-L146)）
- 构造时把每个可写目录 resolve 成绝对路径，并要求其存在且为目录，否则抛错（[packages/sandbox/sandbox-windows-acl/src/index.ts:180-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L180-L186)）
- `workspace-write` 缺少写 SID、或缺少显式临时目录（含显式 `null`）时构造即抛（[packages/sandbox/sandbox-windows-acl/src/index.ts:190-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L190-L195)）
- `read-only` 传入了临时目录或任一写 SID 时构造即抛（[packages/sandbox/sandbox-windows-acl/src/index.ts:196-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L196-L201)）
- 带临时目录的 `workspace-write` 必须给出临时写 SID；`tempDir: null` 时不允许给临时写 SID；工作区与临时写 SID 必须互不相同（[packages/sandbox/sandbox-windows-acl/src/index.ts:202-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L202-L210)）
- `init` 拒绝重复初始化，并打开当前进程令牌作为受限令牌的来源（[packages/sandbox/sandbox-windows-acl/src/index.ts:219-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L219-L224)）
- 把工作区与临时写 SID 字符串解析成指针，转换失败或结果为空即抛（[packages/sandbox/sandbox-windows-acl/src/index.ts:226-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L226-L236)）
- `read-only` 或显式 `null` 时把临时目录归一化为 `null`；否则要求它存在、是目录，并与所有可写目录互不包含（[packages/sandbox/sandbox-windows-acl/src/index.ts:238-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L238-L248)）
- `manageDacls` 为真时给每个可写目录授工作区 SID 的写 ACE；临时目录的授权先记入待撤销表再执行；为假时完全跳过授权与撤销（[packages/sandbox/sandbox-windows-acl/src/index.ts:257-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L257-L270)）
- 取出令牌的登录会话 SID 与 Everyone well-known SID 并记录以便释放（[packages/sandbox/sandbox-windows-acl/src/index.ts:271-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L271-L274)）
- 以登录 SID、Everyone 与实际存在的写 SID 列表按模式创建受限令牌（[packages/sandbox/sandbox-windows-acl/src/index.ts:275-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L275-L281)）
- 把受限令牌的默认 DACL 追加一条 full-access ACE，受益 SID 依次取临时写 SID、工作区写 SID、Everyone（[packages/sandbox/sandbox-windows-acl/src/index.ts:294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L294)）
- 成功路径关闭当前进程令牌句柄并记录绑定表，标志实例已初始化（[packages/sandbox/sandbox-windows-acl/src/index.ts:295-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L295-L297)）
- `init` 失败时关闭尚开着的进程令牌与受限令牌、撤销已记录的可撤销授权、释放全部 SID、清空实例状态（[packages/sandbox/sandbox-windows-acl/src/index.ts:298-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L298-L327)）
- 清理过程中若还有失败，抛出把原错误排在首位的 `AggregateError`，否则重抛原错误（[packages/sandbox/sandbox-windows-acl/src/index.ts:328-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L328-L334)）
- `spawn` 在未初始化时抛错，并把 args 默认为空数组、cwd 默认为调用方 cwd（[packages/sandbox/sandbox-windows-acl/src/index.ts:348-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L348-L353)）
- `stdio: 'inherit'` 时子进程直接继承调用方 stdio 并置于 kill-on-close 作业中，`wait()` 取回退出码后关闭作业句柄，返回的 stdout/stderr 为空缓冲（[packages/sandbox/sandbox-windows-acl/src/index.ts:355-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L355-L367)）
- 管道模式先启动 stdout/stderr 的抽取，等两个抽取都完成后才发起阻塞式等待并取退出码（[packages/sandbox/sandbox-windows-acl/src/index.ts:369-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L369-L385)）
- `dispose` 在未初始化时直接返回；`manageDacls` 为真时撤销已记录的可撤销授权（常驻 ACE 保留）（[packages/sandbox/sandbox-windows-acl/src/index.ts:393-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L393-L405)）
- `dispose` 释放两个写 SID、关闭受限令牌、释放 init 期分配的 SID、清空实例状态，并把全部清理失败汇成 `AggregateError` 抛出（[packages/sandbox/sandbox-windows-acl/src/index.ts:406-429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/index.ts#L406-L429)）

### packages/sandbox/sandbox-windows-acl/src/invariant.ts

包自带的不变量 companion 插件，向 `invariants` 服务登记本包的所有权。

- 声明插件名与 `inject: ['invariants']`（[packages/sandbox/sandbox-windows-acl/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/invariant.ts#L12-L15)）
- 安装器为空函数，附带说明本包不提供独立的事件序列或可变数据关系（[packages/sandbox/sandbox-windows-acl/src/invariant.ts:17-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/invariant.ts#L17-L22)）
- `apply` 以包名注册该空安装器并返回其 disposer（[packages/sandbox/sandbox-windows-acl/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/invariant.ts#L29-L30)）

### packages/sandbox/sandbox-windows-acl/src/path-boundary.ts

工作区与私有临时目录之间的目录包含关系检查，被主入口与 runner 调用。

- `containsDirectory` 对两侧路径都先做 `realpathSync.native` 再算相对路径，据此判定同一目录或包含关系（[packages/sandbox/sandbox-windows-acl/src/path-boundary.ts:11-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/path-boundary.ts#L11-L14)）
- `assertTempRootOutsideWorkspace` 在临时根位于工作区之内时抛出带两个路径的错误（[packages/sandbox/sandbox-windows-acl/src/path-boundary.ts:22-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/path-boundary.ts#L22-L26)）
- `assertPrivateTempDisjoint` 对每个可写目录检查两个包含方向，任一方向成立即抛（[packages/sandbox/sandbox-windows-acl/src/path-boundary.ts:34-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/path-boundary.ts#L34-L40)）

### packages/sandbox/sandbox-windows-acl/src/runner.ts

以 argv 前缀包装器形式运行的受限进程入口：解析参数、建立受限令牌、以继承 stdio 派生被包装的命令、镜像退出码并在退出时清理。

- `fail` 向 stderr 打印 `windows-acl-run: <detail>` 行并抛出内部错误类型（[packages/sandbox/sandbox-windows-acl/src/runner.ts:54-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L54-L63)）
- `parseArgs` 按 `--` 切分选项与被包装 argv，缺少取值或出现未知选项即失败（[packages/sandbox/sandbox-windows-acl/src/runner.ts:81-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L81-L99)）
- 缺少 `--workspace`、`--temp`、模式不在两值之内、或 `--` 之后没有命令时失败退出（[packages/sandbox/sandbox-windows-acl/src/runner.ts:100-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L100-L106)）
- `requireDirectory` 对两种模式都校验工作区与临时路径确为已存在的目录（[packages/sandbox/sandbox-windows-acl/src/runner.ts:109-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L109-L120)）
- `read-only` 不接受任何写 SID 选项；`workspace-write` 要求两个写 SID 选项要么同时给出要么同时缺省（[packages/sandbox/sandbox-windows-acl/src/runner.ts:122-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L122-L128)）
- `workspace-write` 下先断言临时根位于工作区之外（[packages/sandbox/sandbox-windows-acl/src/runner.ts:129-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L129-L131)）
- 调 `SetConsoleCtrlHandler(null, 1)` 让本进程忽略自身的 CTRL+C，失败即按 runner 失败退出（[packages/sandbox/sandbox-windows-acl/src/runner.ts:133-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L133-L139)）
- 由外部管理授权时，把 `--write-sid` 与 `--temp-write-sid` 分别与工作区路径、临时路径推导出的 SID 逐一比对，不符即失败（[packages/sandbox/sandbox-windows-acl/src/runner.ts:148-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L148-L154)）
- 未给出写 SID 对时，把 `--temp` 当作根并在其下 `mkdtemp` 出随机私有子目录，自行推导其临时 SID（[packages/sandbox/sandbox-windows-acl/src/runner.ts:155-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L155-L159)）
- 按模式构造沙箱实例：`workspace-write` 才把工作区列入可写目录，并按是否由外部管理授权设置 `manageDacls`（[packages/sandbox/sandbox-windows-acl/src/runner.ts:161-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L161-L170)）
- 有私有临时目录时把本进程环境里的 `TMP` 与 `TEMP` 改写为该目录（子进程继承该环境块），任一写入失败即按 runner 失败退出（[packages/sandbox/sandbox-windows-acl/src/runner.ts:172-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L172-L179)）
- 以继承 stdio 的方式派生被包装的命令并等待其结束，取其退出码作为返回值（[packages/sandbox/sandbox-windows-acl/src/runner.ts:181-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L181-L187)）
- `finally` 中释放沙箱并删除自建的临时目录，清理失败只以 `windows-acl-run: cleanup:` 行打印到 stderr，不覆盖子进程退出码（[packages/sandbox/sandbox-windows-acl/src/runner.ts:188-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L188-L204)）
- 模块被加载即执行 `main()`，成功时把进程退出码原样设为子进程退出码（[packages/sandbox/sandbox-windows-acl/src/runner.ts:207-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L207-L219)）
- 失败时，非内部失败类型的错误补打一行签名，并把退出码置为 127（[packages/sandbox/sandbox-windows-acl/src/runner.ts:220-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/runner.ts#L220-L225)）

### packages/sandbox/sandbox-windows-acl/src/spawn.ts

把共享 Win32 进程库的派生与等待原语适配成携带受限令牌的调用，被主入口使用。

- `spawnSandboxed` 把受限令牌并入选项，派生带管道 stdout/stderr 的子进程（[packages/sandbox/sandbox-windows-acl/src/spawn.ts:29-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/spawn.ts#L29-L35)）
- `spawnSandboxedInherited` 把受限令牌并入选项，派生继承 stdio 并归入 kill-on-close 作业的子进程（[packages/sandbox/sandbox-windows-acl/src/spawn.ts:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/spawn.ts#L44-L50)）
- `waitForExit` 等待受限子进程结束并关闭其进程句柄，返回退出码（[packages/sandbox/sandbox-windows-acl/src/spawn.ts:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/spawn.ts#L58-L60)）

### packages/sandbox/sandbox-windows-acl/src/token.ts

受限令牌的构造链：打开当前进程令牌、取登录 SID、造 well-known SID、改令牌默认 DACL、按模式调用受限令牌创建；被主入口使用。

- `openCurrentProcessToken` 先以查询权限打开本进程，再用 QUERY/DUPLICATE/ADJUST_DEFAULT/ASSIGN_PRIMARY 四项权限打开其令牌，任一步失败即抛并在错误路径尽力关闭进程句柄（[packages/sandbox/sandbox-windows-acl/src/token.ts:23-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/token.ts#L23-L41)）
- `findLogonSid` 先做一次零长度的 TokenGroups 尺寸查询，对返回 0 或小于结构头偏移的可疑尺寸直接抛出（[packages/sandbox/sandbox-windows-acl/src/token.ts:52-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/token.ts#L52-L57)）
- 按 16 字节步长遍历令牌组，用无符号右移比较 `SE_GROUP_LOGON_ID` 属性位，命中后按长度复制该 SID 返回；遍历完仍未命中则抛错（[packages/sandbox/sandbox-windows-acl/src/token.ts:59-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/token.ts#L59-L76)）
- `makeWellKnownSid` 在 68 字节缓冲上创建 well-known SID 并再用 `IsValidSid` 校验（[packages/sandbox/sandbox-windows-acl/src/token.ts:85-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/token.ts#L85-L94)）
- `setTokenDefaultDaclGrant` 读出令牌当前默认 DACL，令牌没有默认 DACL 时抛错（[packages/sandbox/sandbox-windows-acl/src/token.ts:112-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/token.ts#L112-L124)）
- 把一条针对给定 SID 的 `FILE_ALL_ACCESS` 允许 ACE 合并进默认 DACL，再用 `SetTokenInformation` 写回，写回失败时释放新 ACL 并抛出，成功后也释放（[packages/sandbox/sandbox-windows-acl/src/token.ts:125-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/token.ts#L125-L145)）
- `buildRestrictingSids` 按 16 字节步长打包 SID 指针数组，属性字段保持为 0（[packages/sandbox/sandbox-windows-acl/src/token.ts:148-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/token.ts#L148-L154)）
- `createRestrictedToken` 按模式选择 restricting SID 列表：`read-only` 为登录 SID + Everyone，`workspace-write` 在其后追加写 SID 列表，且写 SID 列表为空时抛错（[packages/sandbox/sandbox-windows-acl/src/token.ts:204-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/token.ts#L204-L208)）
- 以 `DISABLE_MAX_PRIVILEGE | LUA_TOKEN | WRITE_RESTRICTED` 标志创建受限令牌，不禁用任何 SID、不删除任何特权，失败或返回空句柄即抛（[packages/sandbox/sandbox-windows-acl/src/token.ts:209-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/token.ts#L209-L222)）

### packages/sandbox/sandbox-windows-acl/src/win32-abi.ts

本包用到的 Win32 常量与 x64 结构体尺寸/偏移，被 ACL、令牌、FFI 三处直接消费。

- 令牌权限位常量决定打开进程令牌时请求的四项权限（[packages/sandbox/sandbox-windows-acl/src/win32-abi.ts:5-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/win32-abi.ts#L5-L12)）
- `GRANT_MASK` 由文件通用写、DELETE、FILE_DELETE_CHILD 三者取并后再剔除 `STANDARD_RIGHTS_WRITE`，即授出的写能力不含改写 DACL 与夺取所有权（[packages/sandbox/sandbox-windows-acl/src/win32-abi.ts:15-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/win32-abi.ts#L15-L28)）
- `FILE_ALL_ACCESS` 是写入受限令牌默认 DACL 的那条 ACE 所用掩码（[packages/sandbox/sandbox-windows-acl/src/win32-abi.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/win32-abi.ts#L29-L30)）
- 三个受限令牌创建标志位定义了"禁用最大特权 + 受限用户 + 仅限制写访问"的组合（[packages/sandbox/sandbox-windows-acl/src/win32-abi.ts:31-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/win32-abi.ts#L31-L36)）
- 授权与撤销所用的 EXPLICIT_ACCESS 模式值以及 `OI|CI` 继承标志（[packages/sandbox/sandbox-windows-acl/src/win32-abi.ts:53-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/win32-abi.ts#L53-L58)）
- 锁文件所用的访问位、共享位、`OPEN_ALWAYS` 与独占加锁标志（[packages/sandbox/sandbox-windows-acl/src/win32-abi.ts:65-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/win32-abi.ts#L65-L80)）
- SID 子权威上限、最大 SID 尺寸与 x64 下 `SID_AND_ATTRIBUTES`、`TOKEN_GROUPS`、`EXPLICIT_ACCESS_W` 的尺寸与偏移，决定所有内存打包与解码的字节位置（[packages/sandbox/sandbox-windows-acl/src/win32-abi.ts:83-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/win32-abi.ts#L83-L98)）

### packages/sandbox/sandbox-windows-acl/src/workspace-sid.ts

两个能力 SID 的推导函数：工作区写 SID 与私有临时目录写 SID，被主入口、runner 与 seam 使用。

- `workspaceWriteSid` 对规范化工作区路径取 sha256，用摘要前两个 32 位小端字段各自对 `2^30-1` 取模加一，拼成两段子权威的 `S-1-4-x-y`，同一路径每次得到相同 SID（[packages/sandbox/sandbox-windows-acl/src/workspace-sid.ts:35-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/workspace-sid.ts#L35-L40)）
- `tempWriteSid` 先以 `temp\0` 前缀做域分离再对临时目录路径取摘要，并固定追加第三段子权威 `-1`，使其永不与两段的工作区 SID 相同（[packages/sandbox/sandbox-windows-acl/src/workspace-sid.ts:49-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/src/workspace-sid.ts#L49-L54)）

### packages/sandbox/sandbox-windows-acl/tsconfig.json

包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区项目引用。

- 无运行期机制

### packages/sandbox/sandbox-windows-acl/tsdown.config.ts

打包配置，决定该包发布的运行期产物。

- 把主入口、invariant companion 与 runner 打成三个具名 entry，输出到 `lib`，与 `package.json` 的三个导出路径对应（[packages/sandbox/sandbox-windows-acl/tsdown.config.ts:7-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/tsdown.config.ts#L7-L9)）
- 以 ESM、Node 平台、es2024 目标产出，且不清理输出目录、不生成声明文件（[packages/sandbox/sandbox-windows-acl/tsdown.config.ts:10-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/tsdown.config.ts#L10-L15)）

### packages/sandbox/sandbox-windows-acl/verify/abi-probe.cpp

一个独立的 C++ 探针程序，把本包硬编码的 Win32 结构尺寸、偏移与常量对照系统头文件核验。

- `P` 宏把每个被检查的表达式连同其求值结果按定宽格式打印到标准输出（[packages/sandbox/sandbox-windows-acl/verify/abi-probe.cpp:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/verify/abi-probe.cpp#L7)）
- 逐项打印信任结构的尺寸与偏移、SID 与令牌相关常量、写掩码组合、共享与加锁标志等本包依赖的全部数值（[packages/sandbox/sandbox-windows-acl/verify/abi-probe.cpp:11-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/verify/abi-probe.cpp#L11-L54)）
- 一组 `static_assert` 在编译期锁定结构尺寸、令牌权限位、写掩码求值结果 `0x110156`、共享模式、加锁标志与继承标志，任一不符则编译失败（[packages/sandbox/sandbox-windows-acl/verify/abi-probe.cpp:56-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/verify/abi-probe.cpp#L56-L71)）
- 全部断言通过时打印 `static_asserts passed` 并以 0 退出（[packages/sandbox/sandbox-windows-acl/verify/abi-probe.cpp:72-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-windows-acl/verify/abi-probe.cpp#L72-L73)）
