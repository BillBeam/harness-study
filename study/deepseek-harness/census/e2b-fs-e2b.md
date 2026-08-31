---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/e2b/fs-e2b
---

# packages/e2b/fs-e2b

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、63 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/e2b/fs-e2b/README.md

本包的英文说明文档，介绍在共享远程沙箱内执行文件操作的适用场景、读写编辑行为与已知限制。

- 无运行期机制

### packages/e2b/fs-e2b/package.json

本包的 npm 清单，声明模块类型、入口、导出子路径与对等依赖。

- 声明 `"type": "module"`，包内文件按 ESM 加载（[packages/e2b/fs-e2b/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/package.json#L13)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/e2b/fs-e2b/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/package.json#L14-L15)）
- `exports` 把 `.` 解析到构建产物、`./invariant` 解析到伴生模块，并额外暴露 `./src/*` 与 `./package.json`（[packages/e2b/fs-e2b/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/package.json#L16-L27)）
- `files` 限定发布内容为两个 js 产物与类型声明（[packages/e2b/fs-e2b/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/package.json#L28-L32)）
- `peerDependencies` 要求宿主组合中同时存在沙箱持有者、文件系统 seam 与不变量服务（[packages/e2b/fs-e2b/package.json:34-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/package.json#L34-L39)）

### packages/e2b/fs-e2b/src/index.ts

文件系统能力 seam 的 E2B Provider 实现：把解析、读取、列目录、写入与编辑全部落到共享远程沙箱内，并把 SDK 错误映射成 seam 的错误码。

- 定义版本元数据键 `dsh-version`、二进制探测采样字节数 8192，以及 base64 校验正则（[packages/e2b/fs-e2b/src/index.ts:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L30-L32)）
- `assertNotAborted` 在信号已中止时抛出带 `FS_ABORTED` 码的错误（[packages/e2b/fs-e2b/src/index.ts:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L34-L36)）
- `normalizeLineEndings` 把 CRLF 统一成 LF，用于匹配与对外呈现（[packages/e2b/fs-e2b/src/index.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L38-L40)）
- `detectsCrlf` 只看前 4096 字符，按 CRLF 与纯 LF 的计数判定主导换行风格（[packages/e2b/fs-e2b/src/index.ts:42-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L42-L47)）
- `restoreLineEndings` 在判定为 CRLF 主导时把内容改回 CRLF 再落盘（[packages/e2b/fs-e2b/src/index.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L49-L51)）
- `decodeText` 在采样区间内发现 NUL 字节即以 `FS_NOT_TEXT` 拒绝，随后用 fatal 模式 UTF-8 解码，解码失败同样以 `FS_NOT_TEXT` 拒绝（[packages/e2b/fs-e2b/src/index.ts:53-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L53-L62)）
- `decodeCanonicalPath` 依次校验 base64 形态、往返一致、NUL 结尾成帧、内部无 NUL、UTF-8 可解码、结果为绝对路径，任一不满足即抛错（[packages/e2b/fs-e2b/src/index.ts:64-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L64-L83)）
- `commandOpts` 让每条内部命令都带上随机 HOME 的控制环境，并按需附带中止信号（[packages/e2b/fs-e2b/src/index.ts:85-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L85-L91)）
- `openReadStream` 兼容 SDK 对空文件返回空串而非流的行为，改造成一个立即关闭的空流；其他失败经错误映射抛出（[packages/e2b/fs-e2b/src/index.ts:93-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L93-L109)）
- `entryType` 把 SDK 的 FILE/DIR 映射为 seam 的 `file`/`directory`，其余归为 `other`（[packages/e2b/fs-e2b/src/index.ts:111-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L111-L120)）
- `entryVersion` 用元数据版本号、路径、类型、大小、模式、修改时间与符号链接目标的 JSON 串取 sha256，生成 `e2b:` 前缀的版本标识（[packages/e2b/fs-e2b/src/index.ts:122-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L122-L133)）
- `mapError` 按次序把已是 seam 错误的原样返回、中止映射为 `FS_ABORTED`、未找到映射为 `FS_NOT_FOUND`、命中权限文案正则映射为 `FS_PERMISSION_DENIED`、其余映射为 `FS_IO_ERROR`（[packages/e2b/fs-e2b/src/index.ts:135-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L135-L147)）
- `literalEdit` 先对新旧串做 LF 归一，空 old_string 以 `FS_EDIT_NOT_FOUND` 拒绝（[packages/e2b/fs-e2b/src/index.ts:149-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L149-L154)）
- 统计不重叠匹配次数：零次以 `FS_EDIT_NOT_FOUND` 拒绝，非 replaceAll 且不为一次以 `FS_AMBIGUOUS_EDIT` 拒绝并报出次数，replaceAll 时全量替换（[packages/e2b/fs-e2b/src/index.ts:155-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L155-L167)）
- `static inject = ['e2b']` 使该 Provider 只在沙箱持有者就绪后激活（[packages/e2b/fs-e2b/src/index.ts:172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L172)）
- 以 `locks` 表按规范目标键保存串行化尾部（[packages/e2b/fs-e2b/src/index.ts:174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L174)）
- `resolve` 拒绝空白路径，把相对路径按调用方 cwd 或 `ctx.e2b.cwd` 解析成 POSIX 绝对路径，再取沙箱内规范路径作为目标键，中止在前后各查一次（[packages/e2b/fs-e2b/src/index.ts:176-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L176-L188)）
- `processPath` 直接以目标键作为进程可见路径（[packages/e2b/fs-e2b/src/index.ts:190-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L190-L192)）
- `fileUrl` 要求路径绝对，并对每个路径段做百分号编码生成 `file:` URI（[packages/e2b/fs-e2b/src/index.ts:194-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L194-L198)）
- `contains` 用 POSIX 相对路径判定包含关系，`..` 开头或绝对结果视为不包含（[packages/e2b/fs-e2b/src/index.ts:200-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L200-L203)）
- `stat` 返回版本、类型，并只对普通文件附带 size（[packages/e2b/fs-e2b/src/index.ts:205-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L205-L214)）
- `lstat` 不跟随符号链接：直接探测解析后的显示路径，有 symlinkTarget 即报 `symlink`，否则按 file/directory/other 归类（[packages/e2b/fs-e2b/src/index.ts:216-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L216-L234)）
- `readText` 先要求目标是普通文件，再整体按字节读取并以 8192 字节采样解码为文本（[packages/e2b/fs-e2b/src/index.ts:236-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L236-L246)）
- `readBytes` 先用 stat 的 size 做上限预检，超限即以 `FS_TOO_LARGE` 拒绝（[packages/e2b/fs-e2b/src/index.ts:248-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L248-L253)）
- 流式读取时逐块累加并在越过上限的那一块处即以 `FS_TOO_LARGE` 中断，每块前再查一次中止（[packages/e2b/fs-e2b/src/index.ts:254-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L254-L272)）
- 未正常读完时尝试取消远程流并始终释放读锁，取消失败被吞（[packages/e2b/fs-e2b/src/index.ts:275-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L275-L285)）
- 把收集到的分块拼成一整块 `Uint8Array` 返回（[packages/e2b/fs-e2b/src/index.ts:286-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L286-L292)）
- `streamText` 先要求目标是普通文件再开流，返回一个惰性异步迭代器（[packages/e2b/fs-e2b/src/index.ts:295-300](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L295-L300)）
- 迭代过程中只在累计前 8192 字节内做 NUL 采样，命中即以 `FS_NOT_TEXT` 中断（[packages/e2b/fs-e2b/src/index.ts:307-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L307-L315)）
- 分块以 fatal 流式解码，只在有内容时产出；读完再做一次收尾解码以捕获截断的多字节序列（[packages/e2b/fs-e2b/src/index.ts:316-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L316-L328)）
- 迭代未完成时同样尝试取消流并释放读锁（[packages/e2b/fs-e2b/src/index.ts:332-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L332-L341)）
- `listDir` 先 stat：不存在报 `FS_NOT_FOUND`，非目录报 `FS_NOT_DIRECTORY`（[packages/e2b/fs-e2b/src/index.ts:346-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L346-L349)）
- 目录只列一层，符号链接条目额外取规范路径并再探测一次目标信息，条目按名称本地化排序后返回（[packages/e2b/fs-e2b/src/index.ts:350-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L350-L374)）
- `writeText` 在按目标键串行的锁内执行：先探测现状，已存在但非普通文件即以 `FS_NOT_REGULAR_FILE` 拒绝（[packages/e2b/fs-e2b/src/index.ts:376-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L376-L386)）
- 校验写入意图后取旧内容做 diff 基线，原子写出，并按是否已存在返回 `create`/`update` 及归一化后的新内容（[packages/e2b/fs-e2b/src/index.ts:387-402](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L387-L402)）
- `editText` 在同一把锁内执行：文件不存在或版本不匹配都以 `FS_STALE_VERSION` 拒绝，非普通文件以 `FS_NOT_REGULAR_FILE` 拒绝（[packages/e2b/fs-e2b/src/index.ts:405-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L405-L421)）
- 编辑读入原文后按 LF 归一做字面替换，再按原文主导换行风格还原后原子写出，并返回新版本与前后文本（[packages/e2b/fs-e2b/src/index.ts:422-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L422-L428)）
- `withLock` 把同一目标键上的操作串成链（前一步成败都继续），并在自己是尾部时清理表项（[packages/e2b/fs-e2b/src/index.ts:431-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L431-L441)）
- `canonicalPath` 在沙箱内跑 `set -o pipefail; realpath -mz -- <quoted> | base64 -w0` 取规范路径，命令退出错误改抛带 stderr 的错误（[packages/e2b/fs-e2b/src/index.ts:443-454](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L443-L454)）
- `probe` 把 `FileNotFoundError` 转成 undefined，其余错误经映射抛出，前后各查一次中止（[packages/e2b/fs-e2b/src/index.ts:456-467](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L456-L467)）
- `requireRegular` 把"不存在"与"非普通文件"分别映射为 `FS_NOT_FOUND` 与 `FS_NOT_REGULAR_FILE`（[packages/e2b/fs-e2b/src/index.ts:469-474](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L469-L474)）
- `checkWriteIntent` 对 `createIfAbsent` 且目标已存在报 `FS_NOT_OBSERVED`，对 `replaceIfVersion` 在缺失或版本不符时报 `FS_STALE_VERSION`（[packages/e2b/fs-e2b/src/index.ts:476-485](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L476-L485)）
- `readForDiff` 以整文件长度作采样上限解码，遇到 `FS_NOT_TEXT` 时返回 null 而非失败（[packages/e2b/fs-e2b/src/index.ts:487-497](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L487-L497)）
- `readForEdit` 同样以整文件长度采样解码，失败按 `edit` 操作名映射错误（[packages/e2b/fs-e2b/src/index.ts:499-508](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L499-L508)）
- `writeAtomic` 在目标同目录下建随机命名的暂存目录，已存在即视为失败，并在上传前 `chmod 700`（[packages/e2b/fs-e2b/src/index.ts:510-529](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L510-L529)）
- 内容写入暂存文件时附带随机 UUID 的 `dsh-version` 元数据（[packages/e2b/fs-e2b/src/index.ts:530-533](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L530-L533)）
- 暂存文件的权限位取原文件的低九位，文件不存在时取 0600（[packages/e2b/fs-e2b/src/index.ts:535-539](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L535-L539)）
- `createIfAbsent` 用 `ln -T` 做不可替换的发布，并按命令输出区分 `created`/`exists`：`exists` 报 `FS_NOT_OBSERVED`，其他输出报无效发布结果；该命令不传入中止信号（[packages/e2b/fs-e2b/src/index.ts:542-559](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L542-L559)）
- 非 createIfAbsent 时用同文件系统 `rename` 发布，并以返回的已提交条目作为版本来源（[packages/e2b/fs-e2b/src/index.ts:560-568](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L560-L568)）
- 提交成功后清理暂存目录，清理失败被吞而不把成功的写入变成失败（[packages/e2b/fs-e2b/src/index.ts:563-567](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L563-L567)）
- 任一步失败时若暂存目录已建则尝试删除，随后把原始错误经映射以 `write` 操作名抛出（[packages/e2b/fs-e2b/src/index.ts:569-578](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L569-L578)）
- 默认导出该 Provider 类，供 Loader 按插件形态装载（[packages/e2b/fs-e2b/src/index.ts:582](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/index.ts#L582)）

### packages/e2b/fs-e2b/src/invariant.ts

本包的不变量伴生插件模块，由 `./invariant` 子路径导出，被不变量服务在装载时使用。

- 导出 Cordis 插件名 `fs-e2b-invariant`（[packages/e2b/fs-e2b/src/invariant.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/invariant.ts#L13)）
- 声明 `inject = ['invariants']`，插件在该服务就绪前不会激活（[packages/e2b/fs-e2b/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/invariant.ts#L15)）
- 安装函数为空体，因此本包注册后不装任何运行期检查（[packages/e2b/fs-e2b/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册并返回注册的 disposer（[packages/e2b/fs-e2b/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/e2b/fs-e2b/src/invariant.ts#L28-L29)）

### packages/e2b/fs-e2b/tsconfig.json

本包的 TypeScript 编译配置，声明源码根、类型输出目录与工作区项目引用。

- 无运行期机制
