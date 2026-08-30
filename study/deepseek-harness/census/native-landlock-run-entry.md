---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · native/landlock-run/packages/entry
---

# native/landlock-run/packages/entry

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、38 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### native/landlock-run/packages/entry/README.md

入口包的面向使用者说明：三个公开函数的用法、失败退出码含义与平台包的选择方式。

- 无运行期机制

### native/landlock-run/packages/entry/package.json

入口包的 npm 清单，声明模块入口、随包发布的内容、打包闸门与可选平台依赖。

- `main`/`types`/`exports` 把可解析入口固定为构建产物 `lib/index.js` 与其声明文件，另开放 `./package.json`（[native/landlock-run/packages/entry/package.json:11-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/package.json#L11-L19)）
- `files` 让 tarball 带上 `lib/`（排除 tsbuildinfo）与供审计的 `src/main.c`（[native/landlock-run/packages/entry/package.json:20-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/package.json#L20-L25)）
- `prepack` 钩子在打包前跑入口产物校验脚本（[native/landlock-run/packages/entry/package.json:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/package.json#L26-L29)）
- `engines` 要求 Node ≥20（[native/landlock-run/packages/entry/package.json:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/package.json#L30-L32)）
- 两个平台包列为 `optionalDependencies`，安装时由 npm 的 `os`/`cpu` 过滤只装匹配的一个（[native/landlock-run/packages/entry/package.json:37-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/package.json#L37-L40)）

### native/landlock-run/packages/entry/src/index.ts

入口包的 JavaScript API：解析本机启动器二进制路径、拼出授权参数、跑功能性探测，供调用方直接 spawn。

- 导出启动器二进制文件名常量（[native/landlock-run/packages/entry/src/index.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/index.ts#L22)）
- 导出启动器级失败的退出码 125（[native/landlock-run/packages/entry/src/index.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/index.ts#L31)）
- `launcherPath` 按 `<platform>-<arch>` 拼出平台包名，解析其 `package.json` 后拼到 `bin/<二进制名>`（[native/landlock-run/packages/entry/src/index.ts:69-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/index.ts#L69-L74)）
- 平台包不可解析时回退到本包边界内的绝对路径（不用 cwd 相对路径），该路径在包缺失时恰好不存在，且不检查存在性（[native/landlock-run/packages/entry/src/index.ts:75-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/index.ts#L75-L83)）
- `grantArgs` 把只读根展开成 `--ro <path>`、读写根展开成 `--rw <path>`，只读在前、组内保持调用方顺序（[native/landlock-run/packages/entry/src/index.ts:94-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/index.ts#L94-L99)）
- `probe` 同步 spawn `--probe` 子进程，默认 2000ms 超时，只收 stdout（[native/landlock-run/packages/entry/src/index.ts:116-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/index.ts#L116-L124)）
- 非零退出一律判为不可用，零退出时按报告行里是否含 `partially enforced` 区分部分与完全（[native/landlock-run/packages/entry/src/index.ts:125-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/index.ts#L125-L126)）

### native/landlock-run/packages/entry/src/main.c

启动器本体的 C11 源码：解析 argv、对自身安装 Landlock 规则集，再 exec 被包裹的命令；也随入口包 tarball 发布供审计，并由构建脚本编成各平台二进制。

- 在源内自定义 Landlock UAPI 结构体，其中 path-beneath 结构按内核头一样声明为 packed（[native/landlock-run/packages/entry/src/main.c:58-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L58-L65)）
- 按引入的 ABI 版本分组定义各文件系统访问位，并算出 ABI 1 的位掩码（[native/landlock-run/packages/entry/src/main.c:67-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L67-L88)）
- 本次构建认知的最高 ABI 固定为 5（[native/landlock-run/packages/entry/src/main.c:94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L94)）
- 三个 Landlock 系统调用号在 libc 未定义时回退到 444/445/446（[native/landlock-run/packages/entry/src/main.c:101-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L101-L105)）
- 所有启动器级致命错误的退出码固定为 125（[native/landlock-run/packages/entry/src/main.c:112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L112)）
- `fail` 与 `fail_usage` 把 `landlock-run: ...` 一行写到 stderr 并返回该退出码（[native/landlock-run/packages/entry/src/main.c:114-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L114-L130)）
- 授权列表按 argc 一次性分配，分配失败即以致命码返回（[native/landlock-run/packages/entry/src/main.c:146-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L146-L150)）
- `--probe` 必须单独出现，否则报用法错误（[native/landlock-run/packages/entry/src/main.c:155-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L155-L160)）
- `--ro`/`--rw` 各消费一个路径参数并分别入列，缺参数即报用法错误（[native/landlock-run/packages/entry/src/main.c:161-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L161-L170)）
- `--` 之后的 argv 尾部作为待执行命令，未知参数报用法错误（[native/landlock-run/packages/entry/src/main.c:171-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L171-L177)）
- 非探测模式下缺少 `-- <argv>` 即报用法错误（[native/landlock-run/packages/entry/src/main.c:178-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L178-L180)）
- `fs_mask_for_abi` 按运行内核的 ABI 逐级叠加 refer、truncate、ioctl-dev 位（[native/landlock-run/packages/entry/src/main.c:185-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L185-L191)）
- 授权根用 `O_PATH|O_CLOEXEC` 打开，打不开即失败退出而不缩小授权集（[native/landlock-run/packages/entry/src/main.c:194-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L194-L202)）
- 授权根若不是目录，访问位裁剪为文件可用的执行/读/写/截断/ioctl（[native/landlock-run/packages/entry/src/main.c:203-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L203-L209)）
- 添加 path-beneath 规则失败即关闭 fd 并以致命码返回（[native/landlock-run/packages/entry/src/main.c:210-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L210-L217)）
- 先查询内核 ABI 版本，查询失败即判定不可强制执行并失败退出，绝不放行未受限的 exec（[native/landlock-run/packages/entry/src/main.c:231-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L231-L236)）
- 内核 ABI 低于本构建认知时置 partial 标记，并把处理的访问集降到该 ABI（[native/landlock-run/packages/entry/src/main.c:237-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L237-L238)）
- 创建规则集失败即以致命码返回（[native/landlock-run/packages/entry/src/main.c:240-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L240-L242)）
- 只读根授予执行、读文件、读目录三位与已处理集的交集；读写根授予全部已处理访问（[native/landlock-run/packages/entry/src/main.c:244-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L244-L252)）
- 在自限制前置上 `no_new_privs`，失败即以致命码返回（[native/landlock-run/packages/entry/src/main.c:254-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L254-L256)）
- 对当前线程执行 `landlock_restrict_self`，失败即以致命码返回（[native/landlock-run/packages/entry/src/main.c:257-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L257-L261)）
- 探测模式在本进程内对根 `/` 真正安装规则集，成功后打印 `landlock: fully enforced` 或 `partially enforced (older ABI)` 并返回 0（[native/landlock-run/packages/entry/src/main.c:269-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L269-L283)）
- 正常模式先自限制，部分强制时向 stderr 打一行提示但继续执行（[native/landlock-run/packages/entry/src/main.c:285-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L285-L293)）
- 最后 `execvp` 被包裹的命令，规则集经 execve 继承；exec 失败即以致命码返回（[native/landlock-run/packages/entry/src/main.c:295-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L295-L297)）

### native/landlock-run/packages/entry/tsconfig.json

入口包的 TypeScript 编译配置，声明可组合构建、输出目录与源码根。

- 无运行期机制
