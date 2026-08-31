---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/util/native-command
---

# packages/util/native-command

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、31 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/util/native-command/README.md

该包的英文 README，说明无 shell 命令执行与路径打开的用法、平台差异与输出不设上限的限制，供阅读者与文档站使用。

- 无运行期机制

### packages/util/native-command/package.json

该包的 npm 清单，决定这个工具库以什么入口、什么子路径被其他包导入。

- `type: module` 与 `main`/`types` 把包按 ESM 从 `lib/index.js` 加载（[packages/util/native-command/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/package.json#L13-L15)）
- `exports` 把根入口映射到 `lib/index.js`、`./invariant` 映射到 `lib/invariant.js`，并额外开放 `./src/*` 与 `./package.json` 两个子路径（[packages/util/native-command/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/util/native-command/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/package.json#L28-L32)）

### packages/util/native-command/src/index.ts

该包的入口文件，把命令执行器与路径打开器的函数和类型重新导出。

- 无运行期机制

### packages/util/native-command/src/invariant.ts

该包的 invariant 伴生插件，被 invariants 服务加载以登记包所有权。

- 导出 `name` 与 `inject`，把伴生插件命名为 `native-command-invariant` 并声明依赖 `invariants` 服务（[packages/util/native-command/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/invariant.ts#L13-L15)）
- 安装函数为空体，不注册任何运行期检查（[packages/util/native-command/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/invariant.ts#L22)）
- `apply` 用包名向 `ctx.invariants` 注册该安装函数并返回其 disposer（[packages/util/native-command/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/invariant.ts#L29-L30)）

### packages/util/native-command/src/path-opener.ts

跨平台的原生路径与文本文档打开实现，按平台与环境事实选出一条不经 shell 的命令，被宿主侧 UI 集成调用。

- `BROWSER_DOCUMENTS` 集合把 `.html`、`.htm`、`.xhtml`、`.svg` 定为交给浏览器渲染的扩展名（[packages/util/native-command/src/path-opener.ts:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L30)）
- `macBundleForHttps` 先用正则剥掉 `LSHandlerPreferredVersions` 嵌套块，再匹配含 `LSHandlerURLScheme = https` 的块并从中取出 `LSHandlerRoleAll` 的 bundle 标识（[packages/util/native-command/src/path-opener.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L37-L42)）
- macOS 分支执行 `defaults read com.apple.LaunchServices/com.apple.launchservices.secure` 读取默认浏览器记录，读取失败时吞掉错误并返回 false（[packages/util/native-command/src/path-opener.ts:53-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L53-L63)）
- 解析不出 bundle 时返回 false，解析出则执行 `open -b <bundle> <path>` 并返回 true（[packages/util/native-command/src/path-opener.ts:64-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L64-L67)）
- Linux 分支读取 `$BROWSER`，为空则返回 false，否则以其为可执行文件带路径参数执行并返回 true（[packages/util/native-command/src/path-opener.ts:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L68-L75)）
- 其余平台一律返回 false，交回默认应用路径（[packages/util/native-command/src/path-opener.ts:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L78)）
- `powershellLiteral` 把路径包成 PowerShell 单引号字面量并把内部单引号翻倍（[packages/util/native-command/src/path-opener.ts:85-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L85-L87)）
- `isWsl` 先看 `WSL_DISTRO_NAME` 或 `WSL_INTEROP` 是否非空，再看内核 release 字符串是否含 `microsoft`（[packages/util/native-command/src/path-opener.ts:95-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L95-L99)）
- `openWindowsPath` 以 `powershell.exe -NoProfile -Command Invoke-Item -LiteralPath <字面量>` 打开路径（[packages/util/native-command/src/path-opener.ts:102-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L102-L108)）
- `openWslPath` 先跑 `wslpath -w` 转换路径，再检查 abort、剥掉尾部换行、转换结果为空时抛错，最后交给 Windows 打开路径（[packages/util/native-command/src/path-opener.ts:111-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L111-L117)）
- 调度函数从注入项或 `process` 取平台、运行器与环境，并判定当前是否 WSL（[packages/util/native-command/src/path-opener.ts:126-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L126-L129)）
- 非 WSL、意图为 `default` 且扩展名在浏览器集合内时先尝试浏览器打开，成功即返回，不再走默认应用（[packages/util/native-command/src/path-opener.ts:131-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L131-L132)）
- macOS 按意图执行 `open -t <path>` 或 `open <path>`（[packages/util/native-command/src/path-opener.ts:134-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L134-L137)）
- `win32` 直接走 PowerShell 打开路径（[packages/util/native-command/src/path-opener.ts:139-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L139-L142)）
- Linux 在 WSL 下走路径翻译分支，否则执行 `xdg-open <path>`（[packages/util/native-command/src/path-opener.ts:144-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L144-L151)）
- 其余平台抛出带平台名的不支持错误（[packages/util/native-command/src/path-opener.ts:153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L153)）
- `canOpenNativePath` 对 macOS 与 Windows 恒返回 true，非 Linux 的其它平台返回 false，Linux 则按 WSL、`DISPLAY`、`WAYLAND_DISPLAY` 判定（[packages/util/native-command/src/path-opener.ts:167-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L167-L173)）
- `openNativePath` 以 `default` 意图调度（[packages/util/native-command/src/path-opener.ts:182-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L182-L188)）
- `openNativeTextFile` 以 `text-editor` 意图调度，从而绕开文件类型关联（[packages/util/native-command/src/path-opener.ts:197-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/path-opener.ts#L197-L203)）

### packages/util/native-command/src/runner.ts

宿主原生命令的执行适配器，被路径打开器和其它宿主侧集成用作可替换的命令边界。

- `runNativeCommand` 用 `execFile` 以 argv 数组直接拉起可执行文件，设置 utf8 编码、传入 abort 信号、开启 `windowsHide`（[packages/util/native-command/src/runner.ts:22-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/runner.ts#L22-L27)）
- 回调收到错误时构造一个带 `code`、`stdout`、`stderr` 且以原错误为 `cause` 的新 Error 并 reject（[packages/util/native-command/src/runner.ts:29-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/runner.ts#L29-L37)）
- 无错误时以捕获的 stdout 与 stderr 兑现 Promise（[packages/util/native-command/src/runner.ts:38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/native-command/src/runner.ts#L38)）

### packages/util/native-command/tsconfig.json

该包的 TypeScript 编译配置，规定源目录、声明输出目录与工程引用。

- 无运行期机制
