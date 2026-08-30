---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/host/directory-picker-native
---

# packages/host/directory-picker-native

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、73 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/host/directory-picker-native/README.md

该原生对话框后端包的说明文档，描述各平台的选择器工具、失败表现与已知限制。

- 无运行期机制

### packages/host/directory-picker-native/package.json

该包的 npm 清单，声明入口、导出子路径（含被驱动方按路径启动的 worker 产物）、发布文件集与依赖。

- `main`/`types` 指定包的默认运行时入口为 `lib/index.js`、类型入口为 `lib/types/index.d.ts`（[packages/host/directory-picker-native/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant` 与 `./worker` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/worker.cjs`，并开放 `./src/*` 与 `./package.json`（[packages/host/directory-picker-native/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/package.json#L16-L31)）
- `files` 把 `lib/worker.cjs` 一并纳入发布文件集，使子进程入口在安装后存在（[packages/host/directory-picker-native/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/package.json#L32-L37)）
- `dependencies` 把接缝包、无 shell 子进程运行器与 koffi 列为随包安装的运行期依赖（[packages/host/directory-picker-native/package.json:39-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/package.json#L39-L43)）

### packages/host/directory-picker-native/src/index.ts

该文件是原生后端的插件入口，把接缝的 `native` 能力对象注册到服务上。

- 服务持有一个固定的 `native` 能力对象，其 `pick` 转发到跨平台选择器函数（[packages/host/directory-picker-native/src/index.ts:21-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/index.ts#L21-L25)）
- `capability()` 每次返回同一个能力对象，使消费方可跨调用持有它（[packages/host/directory-picker-native/src/index.ts:31-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/index.ts#L31-L33)）

### packages/host/directory-picker-native/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名归属。

- `inject` 声明该伴生插件依赖 `invariants` 服务，未就绪则不执行 `apply`（[packages/host/directory-picker-native/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/invariant.ts#L14)）
- installer 为空函数，注册后不安装任何运行期检查（[packages/host/directory-picker-native/src/invariant.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/invariant.ts#L17)）
- `apply` 调用 `ctx.invariants.register` 以包名注册该 installer 并返回其 disposer（[packages/host/directory-picker-native/src/invariant.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/invariant.ts#L24-L25)）

### packages/host/directory-picker-native/src/native-picker.ts

该文件按平台分派原生目录选择器，被 `native` 能力的 `pick` 直接调用。

- `outputPath` 去掉标准输出尾部换行，空串转为 null（[packages/host/directory-picker-native/src/native-picker.ts:17-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L17-L20)）
- `errorCode` 与 `errorStderr` 从未知抛出值中取出退出码与 stderr 文本（[packages/host/directory-picker-native/src/native-picker.ts:22-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L22-L32)）
- `isMissingCommand` 以 `ENOENT` 判定命令不存在，`rethrowIfAborted` 在信号已中止时原样抛出（[packages/host/directory-picker-native/src/native-picker.ts:34-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L34-L40)）
- 平台与命令运行器可由 `internals` 注入，缺省取 `process.platform` 与无 shell 的原生命令运行器（[packages/host/directory-picker-native/src/native-picker.ts:52-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L52-L53)）
- darwin 分支运行 `osascript` 的两段脚本选择文件夹并取其 POSIX 路径（[packages/host/directory-picker-native/src/native-picker.ts:55-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L55-L61)）
- darwin 分支在未中止、退出码为 1 且 stderr 匹配取消标记时返回 null，其余抛出（[packages/host/directory-picker-native/src/native-picker.ts:62-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L62-L66)）
- win32 分支交给可注入的 Win32 对话框驱动，无备选层级（[packages/host/directory-picker-native/src/native-picker.ts:69-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L69-L77)）
- linux 分支先运行 `zenity --file-selection --directory` 取结果（[packages/host/directory-picker-native/src/native-picker.ts:79-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L79-L84)）
- zenity 失败时先按中止原样抛出，退出码 1 视为取消返回 null，非 ENOENT 抛出，ENOENT 则落到下一段（[packages/host/directory-picker-native/src/native-picker.ts:85-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L85-L89)）
- 回退运行 `kdialog --getexistingdirectory` 取结果（[packages/host/directory-picker-native/src/native-picker.ts:91-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L91-L95)）
- kdialog 也不存在时抛出带安装提示的错误，退出码 1 返回 null，其余原样抛出（[packages/host/directory-picker-native/src/native-picker.ts:96-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L96-L103)）
- 其他平台直接抛出「不支持」的错误（[packages/host/directory-picker-native/src/native-picker.ts:106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/native-picker.ts#L106)）

### packages/host/directory-picker-native/src/win32-dialog-bindings.ts

该文件用 koffi 绑定 Win32 的 COM 文件夹对话框调用与跨线程关窗函数，被子进程入口与驱动方分别使用。

- `readUtf16` 直接映射 32768 字节内存，按 UTF-16LE 双零字节定位终止符后解码，避免把出参地址当指针解引用（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:37-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L37-L44)）
- 常量固定了 COM 公寓模型、进程内服务器、显示名形式与 `WM_CLOSE` 消息号（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:46-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L46-L57)）
- DPI 感知上下文按「每显示器 v2、每显示器、系统级」的顺序排列，供逐级降级（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L56)）
- 常量给出对话框与 shell 项各方法在虚表中的槽位序号（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:59-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L59-L66)）
- `guidBytes` 把 GUID 文本编码成 CoCreateInstance 需要的 16 字节小端布局，并据此固定两个 CLSID/IID（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:73-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L73-L84)）
- `loadWin32DialogBindings` 动态 import koffi 并加载 ole32、user32、kernel32 三个动态库，使非 Windows 进程不会加载 koffi（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:90-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L90-L94)）
- 指针宽度取自运行进程，虚表槽位与出参偏移据此计算（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L98)）
- 逐个绑定 CoInitializeEx、CoUninitialize、CoCreateInstance、CoTaskMemFree、GetCurrentThreadId 与六个 `__stdcall` 原型（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:99-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L99-L110)）
- `method` 从对象首指针解出虚表、按槽位偏移取出函数指针并包成可调用（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L113-L117)）
- `setThreadDpiAwareness` 在符号缺失时直接返回，否则按顺序尝试各上下文直到某次返回非空（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:120-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L120-L137)）
- 暴露线程级的 STA 初始化、反初始化与当前线程 id 读取（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:138-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L138-L142)）
- `createFolderDialog` 调 CoCreateInstance 创建对话框，HRESULT 为负时抛出带十六进制码的错误（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L143-L147)）
- 返回的对话框对象把设选项、设标题、显示三项转成对应虚表调用（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:148-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L148-L151)）
- `resultPath` 取结果项、按文件系统路径形式取显示名、读出字符串后释放 COM 内存，并在 finally 中释放该 shell 项（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:152-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L152-L167)）
- `release` 走虚表释放对话框自身的 COM 引用（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:168-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L168-L170)）
- `closeThreadWindows` 注册枚举回调、对指定线程的每个窗口投递 `WM_CLOSE`，并在 finally 中注销回调（[packages/host/directory-picker-native/src/win32-dialog-bindings.ts:182-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-bindings.ts#L182-L197)）

### packages/host/directory-picker-native/src/win32-dialog-host.ts

该文件是 Win32 对话框驱动的真实进程侧，负责派生对话框子进程并转出关窗函数。

- 子进程环境在继承 `process.env` 基础上追加对话框标题变量（[packages/host/directory-picker-native/src/win32-dialog-host.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-host.ts#L24)）
- 子进程 stdio 配置为忽略 stdin、继承两路输出并开一条 IPC 通道（[packages/host/directory-picker-native/src/win32-dialog-host.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-host.ts#L25)）
- 已构建场景下以当前 Node 可执行文件启动同目录的 `worker.cjs`，并隐藏窗口（[packages/host/directory-picker-native/src/win32-dialog-host.ts:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-host.ts#L26-L29)）
- 源码场景下先 `--import` tsx 的 ESM 钩子再启动 `.ts` 子进程入口（[packages/host/directory-picker-native/src/win32-dialog-host.ts:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-host.ts#L30)）

### packages/host/directory-picker-native/src/win32-dialog-logic.ts

该文件是 Win32 文件夹对话框 COM 会话的纯时序编排，运行在子进程里、绑定层可替换。

- 常量固定了「用户取消」的 HRESULT 与三个对话框选项位（[packages/host/directory-picker-native/src/win32-dialog-logic.ts:10-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-logic.ts#L10-L17)）
- `check` 在 HRESULT 为负时抛出带调用名与十六进制码的错误，否则原样返回（[packages/host/directory-picker-native/src/win32-dialog-logic.ts:90-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-logic.ts#L90-L93)）
- 会话先做 DPI 感知设置，再做 STA 初始化并检查其 HRESULT（[packages/host/directory-picker-native/src/win32-dialog-logic.ts:110-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-logic.ts#L110-L111)）
- 创建对话框后设置「选目录 + 只要文件系统项 + 不改变工作目录」的选项位与标题，均检查 HRESULT（[packages/host/directory-picker-native/src/win32-dialog-logic.ts:115-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-logic.ts#L115-L118)）
- 在阻塞式 `Show` 之前回调出当前线程 id，使外部具备关窗抓手（[packages/host/directory-picker-native/src/win32-dialog-logic.ts:119-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-logic.ts#L119-L120)）
- `Show` 返回取消码时结果为 null，其余负值抛错，成功则取结果路径并检查其 HRESULT（[packages/host/directory-picker-native/src/win32-dialog-logic.ts:121-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-logic.ts#L121-L125)）
- 无论哪条路径都在 finally 中释放对话框并反初始化 COM 公寓（[packages/host/directory-picker-native/src/win32-dialog-logic.ts:126-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-logic.ts#L126-L131)）

### packages/host/directory-picker-native/src/win32-dialog-worker.ts

该文件是对话框子进程的入口，在自身主线程阻塞于模态调用并通过 IPC 回报进度与结果。

- 标题从环境变量读取，为空即抛错终止（[packages/host/directory-picker-native/src/win32-dialog-worker.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-worker.ts#L24-L25)）
- 没有 IPC 通道时抛错，要求必须以带 IPC 的子进程方式运行（[packages/host/directory-picker-native/src/win32-dialog-worker.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-worker.ts#L26)）
- `post` 发送消息并在刷出后主动断开 IPC 通道（[packages/host/directory-picker-native/src/win32-dialog-worker.ts:28-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-worker.ts#L28-L34)）
- 监听 `disconnect` 并以 0 码退出，使父进程消失后不留下挂在屏幕上的对话框（[packages/host/directory-picker-native/src/win32-dialog-worker.ts:38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-worker.ts#L38)）
- 异步自执行函数加载绑定、运行会话，先回报 `showing` 与线程 id，再回报 `done` 与路径（[packages/host/directory-picker-native/src/win32-dialog-worker.ts:41-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-worker.ts#L41-L47)）
- 任何抛出被捕获后以 `error` 消息回报堆栈或消息文本（[packages/host/directory-picker-native/src/win32-dialog-worker.ts:48-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog-worker.ts#L48-L51)）

### packages/host/directory-picker-native/src/win32-dialog.ts

该文件是主线程侧的对话框驱动，把子进程的消息协议映射成一个 promise 并负责中止处理。

- 常量固定了对话框标题、关窗重投间隔与放弃前的尝试次数（[packages/host/directory-picker-native/src/win32-dialog.ts:46-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L46-L51)）
- `assertNever` 在出现未处理的消息种类时抛出类型错误（[packages/host/directory-picker-native/src/win32-dialog.ts:55-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L55-L57)）
- 进入时信号已中止则直接抛错，不派生子进程（[packages/host/directory-picker-native/src/win32-dialog.ts:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L70)）
- 派生函数、关窗函数与重投间隔均可由 `internals` 注入，缺省取真实实现（[packages/host/directory-picker-native/src/win32-dialog.ts:71-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L71-L73)）
- 以固定标题派生对话框子进程（[packages/host/directory-picker-native/src/win32-dialog.ts:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L75)）
- `settle` 保证只落定一次，落定时清掉重投定时器、摘掉中止监听并对子进程 `unref`（[packages/host/directory-picker-native/src/win32-dialog.ts:81-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L81-L88)）
- `postClose` 仅在已知对话框线程 id 时投递关窗，且丢弃关窗调用自身的拒绝（[packages/host/directory-picker-native/src/win32-dialog.ts:90-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L90-L96)）
- 中止服务立即投递一次关窗并起一个定时器按间隔重投（[packages/host/directory-picker-native/src/win32-dialog.ts:106-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L106-L117)）
- 重投次数超出预算时强杀子进程并以「对话框无响应」拒绝（[packages/host/directory-picker-native/src/win32-dialog.ts:108-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L108-L114)）
- 中止监听以 `once` 注册，仅触发一次中止服务（[packages/host/directory-picker-native/src/win32-dialog.ts:120-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L120-L123)）
- 收到 `showing` 时记录线程 id，若中止已抢先发生则立刻补投一次关窗（[packages/host/directory-picker-native/src/win32-dialog.ts:127-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L127-L131)）
- 收到 `done` 时若已中止则以中止错误拒绝，否则以子进程回报的路径兑现（[packages/host/directory-picker-native/src/win32-dialog.ts:132-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L132-L137)）
- 收到 `error` 时以带子进程消息的错误拒绝（[packages/host/directory-picker-native/src/win32-dialog.ts:138-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L138-L142)）
- 子进程 `error` 事件直接以该错误拒绝（[packages/host/directory-picker-native/src/win32-dialog.ts:148-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L148-L152)）
- 子进程在未回报结果前退出时以「未回报结果即退出」拒绝（[packages/host/directory-picker-native/src/win32-dialog.ts:153-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/src/win32-dialog.ts#L153-L157)）

### packages/host/directory-picker-native/tsconfig.json

该包的 TypeScript 编译配置，设定源目录、产物目录、类型集与项目引用。

- 无运行期机制

### packages/host/directory-picker-native/tsdown.config.ts

该包的打包配置，决定发布产物中被实际加载的运行期文件，包括被按路径启动的子进程入口。

- 第一份配置以 `lib/types/index.js` 与 `lib/types/invariant.js` 为入口，按 node 平台、es2024 目标打成 esm 输出到 `lib`（[packages/host/directory-picker-native/tsdown.config.ts:9-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/tsdown.config.ts#L9-L18)）
- 第二份配置把子进程入口单独打成 CJS 的 `lib/worker.cjs`，即驱动方按路径启动的那个文件（[packages/host/directory-picker-native/tsdown.config.ts:19-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-native/tsdown.config.ts#L19-L30)）
