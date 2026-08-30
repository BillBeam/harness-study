---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subprocess/win32-process
---

# packages/subprocess/win32-process

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 10 个文件、69 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subprocess/win32-process/README.md

底层 Win32 进程原语库的包说明页，描述 ABI 所有权、受限令牌进程创建、管道与 Job 原语以及句柄生命周期限制。

- 无运行期机制

### packages/subprocess/win32-process/package.json

包清单，声明入口、导出映射、发布文件集合与运行时依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/subprocess/win32-process/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/package.json#L14-L15)）
- `exports` 只暴露根入口、`./invariant`、`./src/*` 与 `./package.json`（[packages/subprocess/win32-process/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/package.json#L16-L27)）
- `files` 限定发布产物为两个 lib 入口与类型声明（[packages/subprocess/win32-process/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/package.json#L28-L32)）
- 运行时依赖固定为 `koffi ^3.1.0`（[packages/subprocess/win32-process/package.json:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/package.json#L38-L40)）

### packages/subprocess/win32-process/src/abi.ts

Win32 进程、stdio 与 Job Object 常量表，被 `ffi.ts` 与 `process.ts` 直接传入原生调用，数值由 `verify/abi-probe.cpp` 对照头文件核验。

- `STARTF_USESTDHANDLES = 0x100` 决定 `STARTUPINFOW` 是否启用显式标准句柄（[packages/subprocess/win32-process/src/abi.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L4)）
- `HANDLE_FLAG_INHERIT = 0x1` 决定句柄是否可被子进程继承（[packages/subprocess/win32-process/src/abi.ts:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L6)）
- `INFINITE = 0xFFFFFFFF` 是等待进程退出所用的无限超时值（[packages/subprocess/win32-process/src/abi.ts:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L8)）
- `CREATE_SUSPENDED = 0x4` 使目标进程在 resume 之前不执行任何用户代码（[packages/subprocess/win32-process/src/abi.ts:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L10)）
- `STD_INPUT_HANDLE`/`STD_OUTPUT_HANDLE`/`STD_ERROR_HANDLE` 固定为 -10/-11/-12，作为 `GetStdHandle` 的选择子（[packages/subprocess/win32-process/src/abi.ts:12-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L12-L16)）
- `FORMAT_MESSAGE_FROM_SYSTEM` 与 `FORMAT_MESSAGE_IGNORE_INSERTS` 决定错误文本从系统消息表取且不解释占位符（[packages/subprocess/win32-process/src/abi.ts:18-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L18-L20)）
- `ERROR_BROKEN_PIPE = 109` 与 `ERROR_NO_DATA = 232` 是管道排空循环的正常终止码（[packages/subprocess/win32-process/src/abi.ts:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L24-L26)）
- `JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE = 0x2000` 与 `JobObjectExtendedLimitInformation = 9` 决定 Job 句柄关闭时终止全体成员（[packages/subprocess/win32-process/src/abi.ts:28-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L28-L30)）
- `JOBOBJECT_EXTENDED_LIMIT_SIZE = 144` 与 `JOBOBJECT_EXTENDED_LIMIT_FLAGS_OFFSET = 16` 决定写入 Job 限制记录的缓冲区大小与写入偏移（[packages/subprocess/win32-process/src/abi.ts:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L32-L34)）
- `STARTUPINFOW_SIZE = 104` 与 `PROCESS_INFORMATION_SIZE = 24` 既作为 `cb` 字段值，也作为模块加载期布局断言的基准（[packages/subprocess/win32-process/src/abi.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/abi.ts#L36-L38)）

### packages/subprocess/win32-process/src/errors.ts

Win32 调用失败的错误类型，被 `ffi.ts` 的两个抛出函数构造。

- `Win32Error` 把消息固定拼为 `<api> failed (Win32 <code>)` 并在有 detail 时追加冒号后缀，同时以 `api` 与 `win32Code` 两个只读字段暴露失败点（[packages/subprocess/win32-process/src/errors.ts:2-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/errors.ts#L2-L14)）

### packages/subprocess/win32-process/src/ffi.ts

Koffi 绑定层：注册两个 Win32 结构体布局、惰性加载 kernel32 与 advapi32、提供出参分配与解码工具，以及 Win32 错误格式化与抛出。

- `PVOID` 与 `PPVOID` 建立 koffi 的 `void*` 与 `void**` 指针类型，供全部绑定签名使用（[packages/subprocess/win32-process/src/ffi.ts:12-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L12-L13)）
- `isNullPtr()` 把 null、undefined 与地址 `0n` 一并判为空指针（[packages/subprocess/win32-process/src/ffi.ts:35-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L35-L37)）
- 以 `DSH_STARTUPINFOW` 名注册 `STARTUPINFOW` 的完整字段布局（[packages/subprocess/win32-process/src/ffi.ts:104-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L104-L123)）
- 以 `DSH_PROCESS_INFORMATION` 名注册 `PROCESS_INFORMATION` 布局（[packages/subprocess/win32-process/src/ffi.ts:126-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L126-L131)）
- 模块加载时比对两个结构体的 koffi 计算尺寸与 `abi.ts` 的期望值，不一致直接抛错（[packages/subprocess/win32-process/src/ffi.ts:133-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L133-L140)）
- `allocPtrSlot()` 与 `allocUint32()` 分配指针大小与 uint32 的出参槽（[packages/subprocess/win32-process/src/ffi.ts:146-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L146-L156)）
- `decodePtr()` 解码指针出参并把地址零归一为 `null`（[packages/subprocess/win32-process/src/ffi.ts:163-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L163-L166)）
- `decodeUint32()` 解码无符号 32 位出参（[packages/subprocess/win32-process/src/ffi.ts:173-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L173-L175)）
- `allocStartupInfo()` 与 `encodeStartupInfo()` 分配零初始化结构并写入 stdio 相关字段（[packages/subprocess/win32-process/src/ffi.ts:181-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L181-L192)）
- `allocProcessInfo()` 与 `decodeProcessInfo()` 分配并解出进程/线程句柄与两个 id（[packages/subprocess/win32-process/src/ffi.ts:198-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L198-L209)）
- `bindingContext()` 惰性 `koffi.load` 加载 `kernel32.dll` 与 `advapi32.dll`，连同 `__stdcall` 绑定器一起缓存（[packages/subprocess/win32-process/src/ffi.ts:215-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L215-L227)）
- `bindings()` 一次性绑定 15 个 Win32 函数（含 `CreateProcessAsUserW` 走 advapi32）并缓存整张表（[packages/subprocess/win32-process/src/ffi.ts:229-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L229-L258)）
- `extendWin32ProcessBindings()` 把调用方自绑的 API 家族并入通用表，共用同一批已加载的库（[packages/subprocess/win32-process/src/ffi.ts:265-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L265-L269)）
- `errorText()` 用 1024 字节缓冲调 `FormatMessageW`，按返回字符数截取并以 utf16le 解码后 trim，取不到时返回空串（[packages/subprocess/win32-process/src/ffi.ts:278-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L278-L290)）
- `throwLastError()` 现场读 `GetLastError` 并抛出带系统消息的 `Win32Error`（[packages/subprocess/win32-process/src/ffi.ts:299-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L299-L302)）
- `throwWin32()` 用调用方在清理前捕获的错误码抛出 `Win32Error`（[packages/subprocess/win32-process/src/ffi.ts:312-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/ffi.ts#L312-L319)）

### packages/subprocess/win32-process/src/index.ts

包入口，只把 `abi.ts`、`errors.ts`、`ffi.ts`、`process.ts` 的选定符号重新导出。

- 无运行期机制

### packages/subprocess/win32-process/src/invariant.ts

包自有的 invariant 伴生插件，向 `invariants` 服务登记包名并安装一个空的检查器。

- 声明插件名 `win32-process-invariant` 与注入 `invariants`（[packages/subprocess/win32-process/src/invariant.ts:9-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/invariant.ts#L9-L10)）
- `install` 为空实现，不注册任何运行期检查（[packages/subprocess/win32-process/src/invariant.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/invariant.ts#L13)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其 disposer（[packages/subprocess/win32-process/src/invariant.ts:15-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/invariant.ts#L15-L16)）

### packages/subprocess/win32-process/src/process.ts

在共享绑定表之上的 Win32 进程操作：命令行引用、管道式进程创建、管道排空、进程等待，以及先挂起再入 Job 后恢复的进程创建。

- `quoteArg()` 按 `CommandLineToArgvW` 的解析规则处理空串、无空白无引号的裸参，以及反斜杠在引号前需加倍、串尾需加倍的转义（[packages/subprocess/win32-process/src/process.ts:25-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L25-L44)）
- `buildCommandLine()` 把程序与参数逐个引用后以空格拼成一条命令行（[packages/subprocess/win32-process/src/process.ts:52-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L52-L54)）
- `freeNative()` 与 `closeBestEffort()` 分别释放 koffi 分配与在非空时关闭句柄（[packages/subprocess/win32-process/src/process.ts:95-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L95-L101)）
- `createPipe()` 建匿名管道，解出的两端登记进 `owned` 集合，解码为 null 时先关已得句柄再抛错，且在 finally 释放两个出参槽（[packages/subprocess/win32-process/src/process.ts:103-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L103-L123)）
- `closeOwned()` 与 `closeAllOwned()` 从所有权集合中移除并关闭单个或全部句柄（[packages/subprocess/win32-process/src/process.ts:125-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L125-L134)）
- `createRestrictedProcess()` 以受限主令牌调 `CreateProcessAsUserW`，`applicationName` 传 null、`inheritHandles` 传 1、`lpEnvironment` 固定传 null（继承父进程环境块）、cwd 来自 options（[packages/subprocess/win32-process/src/process.ts:136-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L136-L160)）
- `spawnPipedProcess()` 建 stdin/stdout/stderr 三对匿名管道（[packages/subprocess/win32-process/src/process.ts:176-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L176-L178)）
- 只把 stdin 读端与 stdout/stderr 写端标为可继承，失败即带标签抛出（[packages/subprocess/win32-process/src/process.ts:179-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L179-L187)）
- 用 `STARTF_USESTDHANDLES` 与三个管道端编码 `STARTUPINFOW`，并以 creationFlags 0 创建进程（[packages/subprocess/win32-process/src/process.ts:188-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L188-L204)）
- 创建失败时立刻取错误码并抛出带 command 与 cwd 的 `Win32Error`（[packages/subprocess/win32-process/src/process.ts:205-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L205-L208)）
- 创建"成功"却返回空进程/线程句柄时，终止已存在的进程、关掉两个句柄再抛错（[packages/subprocess/win32-process/src/process.ts:209-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L209-L215)）
- 成功后立即关闭 stdin 两端与 stdout/stderr 写端（使子进程 stdin 立刻 EOF）以及线程句柄，并把两个读端移出所有权集合交给调用方（[packages/subprocess/win32-process/src/process.ts:216-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L216-L228)）
- 任何抛出路径都在 catch 中关闭本次操作已拥有的全部句柄，并在 finally 释放两个结构体分配（[packages/subprocess/win32-process/src/process.ts:229-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L229-L235)）
- `drainPipe()` 循环 `PeekNamedPipe`，遇 `ERROR_BROKEN_PIPE` 或 `ERROR_NO_DATA` 视为写端关闭而正常结束，其他失败带已读块数抛错（[packages/subprocess/win32-process/src/process.ts:253-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L253-L259)）
- 有可读字节时按可用量分配缓冲 `ReadFile`，并按实际读到的字节数截取入块列表（[packages/subprocess/win32-process/src/process.ts:261-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L261-L267)）
- 每轮之间让出一个 1ms 定时器，并在 finally 释放计数槽、关闭管道读端（[packages/subprocess/win32-process/src/process.ts:268-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L268-L274)）
- `waitForProcessExit()` 无限等待进程对象，取 `GetExitCodeProcess` 的退出码，并在 finally 无条件关闭进程句柄（[packages/subprocess/win32-process/src/process.ts:283-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L283-L296)）
- `createKillOnCloseJob()` 建 Job 并在扩展限制记录的固定偏移写入 kill-on-close 标志，设置失败时先取错误码、关掉 Job 再抛出（[packages/subprocess/win32-process/src/process.ts:298-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L298-L317)）
- `spawnInheritedJobProcess()` 先建 Job，再取三个标准句柄，取句柄失败时关掉 Job 后抛出（[packages/subprocess/win32-process/src/process.ts:333-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L333-L343)）
- 临时把当前进程的三个标准句柄置为可继承并记录已改动的句柄（[packages/subprocess/win32-process/src/process.ts:350-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L350-L359)）
- 以 `CREATE_SUSPENDED` 创建受限子进程，失败码先存在 `createFailureCode` 而不立即抛（[packages/subprocess/win32-process/src/process.ts:360-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L360-L377)）
- 无论成败都在 finally 释放 `STARTUPINFOW` 并把三个标准句柄的继承位改回 0，且该回滚为尽力而为、不覆盖子进程结果（[packages/subprocess/win32-process/src/process.ts:382-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L382-L388)）
- 创建失败时释放结构体、关闭 Job，再用先前捕获的错误码抛出带 command 与 cwd 的错误（[packages/subprocess/win32-process/src/process.ts:389-398](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L389-L398)）
- 解码 `PROCESS_INFORMATION` 后立即在 finally 释放该分配（[packages/subprocess/win32-process/src/process.ts:399-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L399-L404)）
- 句柄为空时终止进程、关掉 Job 与两个句柄再抛错（[packages/subprocess/win32-process/src/process.ts:405-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L405-L411)）
- 入 Job 失败时终止挂起中的子进程并关闭全部句柄与 Job 后抛出（[packages/subprocess/win32-process/src/process.ts:412-419](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L412-L419)）
- `ResumeThread` 返回 `0xFFFFFFFF` 时关闭全部句柄与已分配的 Job 后抛出（[packages/subprocess/win32-process/src/process.ts:420-426](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L420-L426)）
- 成功路径关闭线程句柄，把 pid、进程句柄与 Job 句柄交给调用方持有（[packages/subprocess/win32-process/src/process.ts:427-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/src/process.ts#L427-L428)）

### packages/subprocess/win32-process/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与两个项目引用。

- 无运行期机制

### packages/subprocess/win32-process/verify/abi-probe.cpp

对照 Windows 头文件核验 `abi.ts` 中常量与结构体尺寸／偏移的原生探针程序，由 README 记录的 g++ 命令手工编译运行。

- `P` 宏把每个表达式连同其求值结果按固定列宽打印到 stdout（[packages/subprocess/win32-process/verify/abi-probe.cpp:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/verify/abi-probe.cpp#L5)）
- 逐项打印指针与句柄尺寸、`STARTUPINFOW` 与 `PROCESS_INFORMATION` 的尺寸和字段偏移、进程与 stdio 常量、以及 Job 扩展限制记录的尺寸、`LimitFlags` 偏移和两个 Job 常量（[packages/subprocess/win32-process/verify/abi-probe.cpp:9-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/verify/abi-probe.cpp#L9-L35)）
- 九条 `static_assert` 把两个结构体尺寸、四个进程/stdio 标志值、Job 记录尺寸与偏移、kill-on-close 标志与限制类别号钉死，任一不符即编译失败（[packages/subprocess/win32-process/verify/abi-probe.cpp:37-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/verify/abi-probe.cpp#L37-L45)）
- 全部断言通过时打印 `static_asserts passed` 并以 0 退出（[packages/subprocess/win32-process/verify/abi-probe.cpp:46-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/win32-process/verify/abi-probe.cpp#L46-L47)）
