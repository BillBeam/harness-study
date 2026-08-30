---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/fs/fs-local
---

# packages/fs/fs-local

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、80 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/fs/fs-local/README.md

包说明文档，介绍宿主文件系统后端的配置、能力与失败码。

- 无运行期机制

### packages/fs/fs-local/package.json

包清单，声明后端插件的入口、导出子路径与依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/fs/fs-local/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./src/*` 与 `./package.json`（[packages/fs/fs-local/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/package.json#L16-L27)）
- `files` 仅发布 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/fs/fs-local/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/package.json#L28-L32)）
- `dependencies` 打入 `koffi`，Windows 原生调用在运行期依赖它（[packages/fs/fs-local/package.json:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/package.json#L39-L42)）

### packages/fs/fs-local/src/fsio.ts

不依赖 Cordis 的本地 I/O 实现：路径解析、探测、读取、原子写入与字面量编辑。

- `BINARY_SAMPLE_BYTES` 把二进制判定的取样窗口固定为前 8192 字节（[packages/fs/fs-local/src/fsio.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L17)）
- `DIFF_BASIS_READ_CHUNK_BYTES` 把差异基线的单次读取限制为 64 KiB，使取消能在块间被观察到（[packages/fs/fs-local/src/fsio.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L19)）
- `isENOENT`/`isEEXIST`/`isENOTDIR`/`isAbortError`/`isPermissionError` 按 errno 与错误名分类底层失败（[packages/fs/fs-local/src/fsio.ts:21-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L21-L51)）
- `throwIfAborted` 在信号已中止时抛出带动词的 `FS_ABORTED`（[packages/fs/fs-local/src/fsio.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L53-L55)）
- `readFileAbortable` 把 Node 读取过程中的裸 `AbortError` 翻译成 `FS_ABORTED`（[packages/fs/fs-local/src/fsio.ts:63-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L63-L71)）
- `versionOf` 把版本令牌拼成 `dev:ino:size:mtimeNs:ctimeNs`（[packages/fs/fs-local/src/fsio.ts:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L74-L76)）
- `FsIoInternals` 定义可替换的平台判定、临时目录名、临时文件名、Win32 DACL/替换、硬链接发布、发布后目标探查、暂存目录删除等边界及两个观察钩子（[packages/fs/fs-local/src/fsio.ts:82-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L82-L103)）
- `resolveLocalTarget` 对空白路径抛 `FS_NOT_FOUND`，并把相对路径按传入 cwd 解析为绝对显示路径（[packages/fs/fs-local/src/fsio.ts:146-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L146-L151)）
- 目标存在时以其 `realpath` 作为稳定 targetKey，父段不是目录（ENOTDIR）则报 `FS_NOT_FOUND`（[packages/fs/fs-local/src/fsio.ts:149-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L149-L159)）
- 目标缺失时向上逐级 realpath 最近存在的祖先并回拼缺失后缀，使 key 在创建前后保持一致；Windows 上额外 stat 祖先以还原“父段是文件”的判定（[packages/fs/fs-local/src/fsio.ts:161-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L161-L193)）
- `pathType`/`pathLinkType` 把 stat 结果映射为 file/directory/other，后者优先判定 symlink（[packages/fs/fs-local/src/fsio.ts:196-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L196-L207)）
- `probeStats` 把 ENOENT 与 ENOTDIR 一律折成“缺失”返回 null，其余元数据失败原样抛出（[packages/fs/fs-local/src/fsio.ts:209-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L209-L223)）
- `probe` 用 bigint stat 返回版本、`0o777` 掩码后的 mode、类型与大小（[packages/fs/fs-local/src/fsio.ts:230-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L230-L239)）
- `probeNoFollow` 用 lstat 做同样探测，可报 symlink 类型（[packages/fs/fs-local/src/fsio.ts:246-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L246-L255)）
- `listingIoError` 把列目录失败映射为 `FS_NOT_FOUND`、`FS_PERMISSION_DENIED` 或 `FS_IO_ERROR` 并挂 cause（[packages/fs/fs-local/src/fsio.ts:259-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L259-L267)）
- `resolveListedChildTarget` 以父目录的 realpath 为基解析子项身份，显示路径仍拼在父显示路径下（[packages/fs/fs-local/src/fsio.ts:269-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L269-L272)）
- `listDirectory` 先探测：缺失报 `FS_NOT_FOUND`、非目录报 `FS_NOT_DIRECTORY`（[packages/fs/fs-local/src/fsio.ts:283-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L283-L291)）
- 列目录按 `localeCompare` 排序，逐子项解析目标并探测，只有文件才带 size，元数据不可得时类型退回 `other`，且在开始、readdir 后与每个子项前后检查中止（[packages/fs/fs-local/src/fsio.ts:293-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L293-L321)）
- `decodeUtf8`/`decodeUtf8Stream` 用 fatal 解码器，非法字节转成 `FS_NOT_TEXT`（[packages/fs/fs-local/src/fsio.ts:325-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L325-L352)）
- `statRegularFile` 把缺失转 `FS_NOT_FOUND`、非普通文件转 `FS_NOT_REGULAR_FILE`（[packages/fs/fs-local/src/fsio.ts:354-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L354-L366)）
- `readWholeText` 读全文后只在前 8192 字节里查 NUL，命中即 `FS_NOT_TEXT`，否则整体解码返回（[packages/fs/fs-local/src/fsio.ts:375-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L375-L383)）
- `readWholeBytes` 先用 stat 大小短路超限文件为 `FS_TOO_LARGE`，再以 `end: maxBytes` 建流并累计字节数，越界即 `FS_TOO_LARGE`，中止转 `FS_ABORTED`（[packages/fs/fs-local/src/fsio.ts:396-427](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L396-L427)）
- `streamWholeText` 逐块流式解码，二进制取样只累计到前 8192 字节，结尾再冲刷一次解码器（[packages/fs/fs-local/src/fsio.ts:437-463](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L437-L463)）
- `removeStagingDirOrThrow` 在写失败后删除暂存目录；删除也失败时抛出复合消息的错误（[packages/fs/fs-local/src/fsio.ts:467-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L467-L479)）
- `throwGuardedCreateFailure` 在硬链接发布失败后回探目标：非普通文件报 `FS_NOT_REGULAR_FILE`，已存在（或 EEXIST）报 `FS_NOT_OBSERVED`，其余报 `FS_IO_ERROR`（[packages/fs/fs-local/src/fsio.ts:481-516](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L481-L516)）
- `writeFileAtomic` 先递归创建父目录，再用 `.<basename>.<pid>.<uuid>.tmpdir` 生成同目录私有暂存目录（[packages/fs/fs-local/src/fsio.ts:541-549](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L541-L549)）
- 各原生边界（平台、DACL 复制、ReplaceFile、link、发布后探查、暂存删除）默认取真实实现，可被 internals 覆盖（[packages/fs/fs-local/src/fsio.ts:550-557](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L550-L557)）
- 暂存目录以 `0o700` 创建并再 chmod，临时文件以 `wx` 独占打开并 chmod 到 `0o600`；Windows 覆写场景先把目标 DACL 复制到空临时文件（[packages/fs/fs-local/src/fsio.ts:560-569](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L560-L569)）
- 内容写入后 `sync` 落盘，调用观察钩子，再按已存在文件的 mode 恢复权限并关闭句柄（[packages/fs/fs-local/src/fsio.ts:570-575](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L570-L575)）
- 发布分三路：`createIfAbsent` 用硬链接不覆盖发布并在失败时走守卫失败分支；Windows 覆写用 `ReplaceFileW`，目标中途消失（ENOENT）时回退 rename；其余情况直接 rename（[packages/fs/fs-local/src/fsio.ts:577-595](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L577-L595)）
- 发布成功后删除暂存目录的失败被吞掉，不把已提交的写入变成失败（[packages/fs/fs-local/src/fsio.ts:596-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L596-L600)）
- 失败路径把 `AbortError` 转 `FS_ABORTED`、尽力关闭句柄，并在暂存目录已建时经清理后重抛（[packages/fs/fs-local/src/fsio.ts:601-614](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L601-L614)）
- `normalizeLineEndings` 只把 `\r\n` 折成 `\n`，孤立 `\r` 保留（[packages/fs/fs-local/src/fsio.ts:628-630](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L628-L630)）
- `detectLineEndings` 只看前 4096 个字符，按 CRLF 与 LF 计数取多数（[packages/fs/fs-local/src/fsio.ts:632-637](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L632-L637)）
- `restoreLineEndings` 在 CRLF 分支先重新归一再展开，避免出现 `\r\r\n`（[packages/fs/fs-local/src/fsio.ts:647-649](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L647-L649)）
- `countOccurrences` 以不重叠方式统计字面量出现次数（[packages/fs/fs-local/src/fsio.ts:651-660](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L651-L660)）
- `readForEdit` 在整个缓冲区里查 NUL（命中报 `FS_NOT_TEXT`），解码后返回 LF 归一内容与检测到的原始换行风格（[packages/fs/fs-local/src/fsio.ts:670-681](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L670-L681)）
- `readTextForDiff` 在已打开的描述符上判断：非普通文件或 `size >= maxBytes` 直接返回 null，并按 `size + 1` 分配缓冲以探测读取期间的增长（[packages/fs/fs-local/src/fsio.ts:701-714](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L701-L714)）
- 差异基线按 64 KiB 分块读取并在每块前检查中止，最后无论如何关闭句柄（[packages/fs/fs-local/src/fsio.ts:715-724](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L715-L724)）
- 读到的字节数与打开时大小不符、含 NUL 或解码失败一律返回 null；`FsError`（含取消）继续抛出，其余带 errno 的描述符期失败降级为 null（[packages/fs/fs-local/src/fsio.ts:725-745](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L725-L745)）
- `applyLiteralEdit` 先归一搜索与替换文本：空搜索串报 `FS_EDIT_NOT_FOUND`，零匹配报 `FS_EDIT_NOT_FOUND`，未开 `replaceAll` 的多匹配报 `FS_AMBIGUOUS_EDIT` 并给出匹配次数，否则整体替换并返回替换计数（[packages/fs/fs-local/src/fsio.ts:759-779](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L759-L779)）

### packages/fs/fs-local/src/index.ts

服务装配：`LocalFileSystem` 类、配置校验与按目标串行的变更临界区。

- `DEFAULT_DIFF_BASIS_MAX_BYTES` 定为 10 MiB，`MAX_DIFF_BASIS_BYTES` 取 Buffer 最大长度与最大字符串长度的较小者（[packages/fs/fs-local/src/index.ts:52-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L52-L56)）
- `static Config` 用 schemastery 给 `cwd` 默认 `process.cwd()`、给 `diffBasisMaxBytes` 默认 10 MiB（[packages/fs/fs-local/src/index.ts:65-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L65-L68)）
- `internals` 字段把 fsio 的原生边界与测试钩子暴露到实例上（[packages/fs/fs-local/src/index.ts:72-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L72-L73)）
- `locks` 以 targetKey 为键保存尾链 Promise，用于串行化变更（[packages/fs/fs-local/src/index.ts:74-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L74-L77)）
- 构造函数校验 `diffBasisMaxBytes` 必须是不超过上限的正安全整数，否则抛错阻止挂载（[packages/fs/fs-local/src/index.ts:79-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L79-L88)）
- `withLock` 把操作接到该 key 的尾链后（前序成败都继续），并在自己仍是尾链时清理表项（[packages/fs/fs-local/src/index.ts:91-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L91-L104)）
- `resolve` 在解析前后各查一次中止信号，并以 `opts.cwd ?? config.cwd` 为相对路径基准（[packages/fs/fs-local/src/index.ts:106-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L106-L111)）
- `processPath` 直接返回 targetKey 字符串（[packages/fs/fs-local/src/index.ts:113-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L113-L115)）
- `processPathFromHostPath` 覆盖基类：绝对宿主路径归一后返回，相对路径返回 undefined（[packages/fs/fs-local/src/index.ts:117-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L117-L119)）
- `fileUrl` 用 `pathToFileURL` 生成 `file:` URI（[packages/fs/fs-local/src/index.ts:121-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L121-L123)）
- `contains` 用相对路径判定包含关系：空串、非 `..` 开头且非绝对时为真（[packages/fs/fs-local/src/index.ts:125-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L125-L128)）
- `stat` 在探测前后查中止，缺失返回 undefined，并只向上层暴露 version/type/size（[packages/fs/fs-local/src/index.ts:130-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L130-L136)）
- `lstat` 对空白路径抛 `FS_NOT_FOUND`，按 cwd 解析后做不跟随符号链接的探测（[packages/fs/fs-local/src/index.ts:138-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L138-L145)）
- `readText`/`streamText` 把目标转成本地目标后交给 fsio 的全文读取与流式读取（[packages/fs/fs-local/src/index.ts:147-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L147-L153)）
- `readBytes` 把 `maxBytes` 与 internals 一并传入原始字节读取（[packages/fs/fs-local/src/index.ts:155-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L155-L157)）
- `listDir` 把 fsio 条目映射为 `FsDirEntry`，version 与 size 缺失时整字段省略（[packages/fs/fs-local/src/index.ts:159-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L159-L168)）
- `writeText` 整个读-守卫-写窗口跑在按目标的锁内，先探测目标，非普通文件报 `FS_NOT_REGULAR_FILE`（[packages/fs/fs-local/src/index.ts:170-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L170-L180)）
- `replaceIfVersion` 守卫要求文件仍存在且版本一致，否则两种情形都报 `FS_STALE_VERSION`；`createIfAbsent` 撞上已有文件报 `FS_NOT_OBSERVED`；无守卫即无条件但仍原子的写入（[packages/fs/fs-local/src/index.ts:182-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L182-L191)）
- 只有目标已存在且新内容字节数小于 `diffBasisMaxBytes` 时才读取差异基线，否则 `before` 为 null（[packages/fs/fs-local/src/index.ts:199-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L199-L203)）
- 写入沿用已存在文件的 mode，并在 `createIfAbsent` 时启用硬链接不覆盖发布（[packages/fs/fs-local/src/index.ts:204-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L204-L211)）
- 写入结果按写前是否存在给出 `create`/`update`，版本取写后探测值，`after` 以 LF 归一后返回以与 `before` 共用差异基线（[packages/fs/fs-local/src/index.ts:212-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L212-L222)）
- `editText` 同样在锁内先探测：目标缺失统一报 `FS_STALE_VERSION`，非普通文件报 `FS_NOT_REGULAR_FILE`，带守卫时版本不符也报 `FS_STALE_VERSION`——都发生在字面量匹配之前（[packages/fs/fs-local/src/index.ts:231-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L231-L243)）
- 编辑读入并归一内容、应用字面量替换、按原换行风格还原后以原 mode 原子写回，返回写后版本与 LF 形式的 before/after（[packages/fs/fs-local/src/index.ts:245-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L245-L257)）
- `versionAfterWrite` 在写后探测不到文件时回退到 `missing:<targetKey>` 哨兵版本（[packages/fs/fs-local/src/index.ts:263-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L263-L266)）
- 默认导出 `LocalFileSystem`，供 Loader 以服务插件挂载并填充 `ctx.fs`（[packages/fs/fs-local/src/index.ts:269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/index.ts#L269)）

### packages/fs/fs-local/src/invariant.ts

包自带的不变量伴生插件，向 invariants 服务登记本包的所有权。

- 以 `inject = ['invariants']` 等待服务，`apply` 用包名注册空安装器并返回 disposer（[packages/fs/fs-local/src/invariant.ts:15-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/invariant.ts#L15-L29)）

### packages/fs/fs-local/src/win32.ts

Windows 安全描述符与原子替换的原生封装，被 fsio 的写入路径调用。

- DACL 信息位、受保护 DACL 位与三个 Win32 错误码为固定常量（[packages/fs/fs-local/src/win32.ts:38-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/win32.ts#L38-L42)）
- `win32()` 惰性 `import('koffi')` 并缓存绑定，只在首次调用时加载 advapi32/kernel32 并声明四个原生函数签名（[packages/fs/fs-local/src/win32.ts:44-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/win32.ts#L44-L58)）
- `errnoCode` 把 Win32 错误码映射为 `ENOENT`/`EACCES`/`EIO`（[packages/fs/fs-local/src/win32.ts:60-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/win32.ts#L60-L70)）
- `win32Error` 构造带 `code`/`errno`/`syscall`/`path`/`win32Code` 的错误对象，使上层能按 errno 分支（[packages/fs/fs-local/src/win32.ts:72-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/win32.ts#L72-L81)）
- `readFileDaclWin32` 用两趟 `GetFileSecurityW`（先问长度再读入）取出自相对 DACL 描述符，任一趟失败即抛（[packages/fs/fs-local/src/win32.ts:88-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/win32.ts#L88-L100)）
- `copyFileDaclWin32` 把源文件 DACL 以 `DACL | PROTECTED_DACL` 写到目标，切断暂存父目录的继承（[packages/fs/fs-local/src/win32.ts:108-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/win32.ts#L108-L115)）
- `replaceFileWin32` 调 `ReplaceFileW` 完成保留被替换文件 ACL 的替换，返回 0 即抛出映射后的错误（[packages/fs/fs-local/src/win32.ts:122-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/win32.ts#L122-L134)）

### packages/fs/fs-local/tsconfig.json

TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
