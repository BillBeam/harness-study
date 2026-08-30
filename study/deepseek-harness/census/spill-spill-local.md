---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/spill/spill-local
---

# packages/spill/spill-local

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、54 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/spill/spill-local/README.md

这个包的英文说明页，描述本地文件系统溢出后端的配置项、文件落盘位置、启动清扫规则与失败行为。

- 无运行期机制

### packages/spill/spill-local/package.json

包清单，声明该本地后端如何被解析加载、发布哪些文件，以及运行期依赖。

- `type: module` 与 `main`/`types` 让该包按 ESM 加载，主入口解析到 `lib/index.js`（[packages/spill/spill-local/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant` 子路径、`./src/*` 源码直通与 `./package.json`（[packages/spill/spill-local/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/spill/spill-local/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/package.json#L28-L32)）
- `dependencies` 只列 schemastery，作为运行期校验配置的依赖被一同安装（[packages/spill/spill-local/package.json:39-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/package.json#L39-L41)）

### packages/spill/spill-local/src/cleanup.ts

一次性启动清扫的实现：解析可信根、按年龄删除过期文件、裁剪空目录，被 `src/index.ts` 在激活后调用。

- `DEFAULT_ROOT_RE` 只匹配 `dsh-spill-` 加 6 个字母数字的精确形状，形状不符的同前缀目录不会被当作历史默认根（[packages/spill/spill-local/src/cleanup.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L15)）
- `SESSION_DIR_RE` 只匹配 `session-` 加 12 位小写十六进制，清扫只下潜到这种形状的目录（[packages/spill/spill-local/src/cleanup.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L23)）
- `warnSafely` 用 try/catch 包住警告回调，回调抛出被吞掉（[packages/spill/spill-local/src/cleanup.ts:37-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L37-L44)）
- `isTrustedDirectory` 对非目录返回 false；Windows 或无 `geteuid` 时直接放行；POSIX 上要求属主等于当前 euid 且 group/other 无写位（[packages/spill/spill-local/src/cleanup.ts:47-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L47-L55)）
- `rootIdentity` 在 Windows 用小写路径、在 POSIX 用 `dev:ino` 作为根的去重身份（[packages/spill/spill-local/src/cleanup.ts:58-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L58-L65)）
- `hasProtectedAncestors` 逐级上溯父目录：遇到 group/other 可写且非 sticky 的祖先返回 false，遇到可写 sticky 但子项属主不是当前用户也返回 false（[packages/spill/spill-local/src/cleanup.ts:72-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L72-L96)）
- `resolveRoot` 首次 `lstat` 失败时 ENOENT 静默返回 undefined，其他错误发警告后同样放弃（[packages/spill/spill-local/src/cleanup.ts:109-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L109-L118)）
- 候选本身是符号链接时，只有 `allowSymlink` 为真才继续；否则非可信目录发警告并跳过（[packages/spill/spill-local/src/cleanup.ts:119-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L119-L124)）
- 用 `realpath` 取规范路径再 `lstat`，失败时同样按 ENOENT 静默、其他告警的方式放弃（[packages/spill/spill-local/src/cleanup.ts:126-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L126-L137)）
- 规范路径不是可信目录或祖先检查不通过时发警告并返回 undefined，通过则返回规范路径加身份（[packages/spill/spill-local/src/cleanup.ts:138-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L138-L155)）
- `SweepRoot.pruneWhenEmpty` 决定该根清空后是否连根删除：发现的历史默认根为真，进程正在写入的活动根为假（[packages/spill/spill-local/src/cleanup.ts:159-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L159-L170)）
- `SweepOptions.cutoffMs` 定义为严格早于才过期，正好落在边界上的文件保留（[packages/spill/spill-local/src/cleanup.ts:173-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L173-L184)）
- `unlinkIdempotent` 把 ENOENT 当作删除已达成，其余错误发警告后吞掉，不向上抛（[packages/spill/spill-local/src/cleanup.ts:196-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L196-L208)）
- `sweepSessionDir` 的 `readdir` 失败时发警告并返回 false，使该目录不进入裁剪步骤（[packages/spill/spill-local/src/cleanup.ts:225-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L225-L237)）
- 目录内逐项用 `lstat`（不跟随链接）取状态，单项失败被就地容纳而不中断整个目录（[packages/spill/spill-local/src/cleanup.ts:239-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L239-L252)）
- 只有普通文件参与过期判定；符号链接与其他特殊条目跳过，`mtimeMs` 不早于 cutoff 的文件保留（[packages/spill/spill-local/src/cleanup.ts:253-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L253-L256)）
- 每删一个文件剩余计数减一，计数归零时返回 true 表示该目录可裁剪（[packages/spill/spill-local/src/cleanup.ts:257-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L257-L260)）
- `sweepSpillRoots` 先把所有候选根解析成可信根并按文件系统身份去重，同身份的 `pruneWhenEmpty` 取逻辑与（[packages/spill/spill-local/src/cleanup.ts:274-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L274-L285)）
- 读根目录失败时 ENOENT 静默跳过（尚无溢出写入的常态），其他错误发警告（[packages/spill/spill-local/src/cleanup.ts:286-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L286-L298)）
- 名字不匹配 `session-<12 hex>` 的条目原样保留，并把该根标记为不可整根裁剪（[packages/spill/spill-local/src/cleanup.ts:302-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L302-L306)）
- 对每个会话条目先 `lstat` 自身，符号链接或非可信目录发警告跳过并阻止整根裁剪（[packages/spill/spill-local/src/cleanup.ts:307-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L307-L326)）
- 清扫后为空的会话目录用 `rmdir` 裁剪，失败时不再整根裁剪且 ENOENT/ENOTEMPTY 不告警（[packages/spill/spill-local/src/cleanup.ts:327-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L327-L341)）
- 只有标记为可裁剪且全部子项被回收的根本身被 `rmdir` 删除，活动根永不删除（[packages/spill/spill-local/src/cleanup.ts:343-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L343-L360)）
- `discoverDefaultRootRecords` 读扫描基目录失败时发警告并返回空数组（[packages/spill/spill-local/src/cleanup.ts:379-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L379-L386)）
- 基目录中只有名字符合精确默认根形状的条目才走 `resolveRoot`，且不允许其为符号链接（[packages/spill/spill-local/src/cleanup.ts:387-394](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L387-L394)）
- `discoverDefaultRoots` 默认以 OS 临时目录为扫描基目录，返回可信根的规范路径（[packages/spill/spill-local/src/cleanup.ts:404-406](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L404-L406)）
- `gatherSweepRoots` 并发做历史默认根发现与活动根解析（活动根允许是符号链接），并让活动根身份覆盖同身份的发现项、标记为不可裁剪（[packages/spill/spill-local/src/cleanup.ts:418-431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/cleanup.ts#L418-L431)）

### packages/spill/spill-local/src/index.ts

插件入口，定义配置、`LocalSpillStore` 服务类、启动清扫的生命周期，以及定位符与检索提示的组装。

- 用 `MS_PER_DAY` 把配置的天数换算成清扫截止时刻（[packages/spill/spill-local/src/index.ts:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L28)）
- `static Config` 用 schemastery 校验：`root` 为字符串，`cleanupPeriodDays` 为步长 1、最小 0、默认 30 的数字（[packages/spill/spill-local/src/index.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L66-L69)）
- 构造时确定根目录：给了 `root` 就 `resolve` 成绝对路径，否则用懒创建的私有默认根（[packages/spill/spill-local/src/index.ts:83-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L83-L88)）
- 用 `ctx.effect` 注册生成器：激活时在 `cleanupPeriodDays > 0` 的前提下启动但不等待一次清扫，yield 出的异步 disposer 等待同一个 promise，使卸载前清扫静默完成（[packages/spill/spill-local/src/index.ts:95-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L95-L101)）
- 清扫的警告出口接到 `ctx.logger.warn`（[packages/spill/spill-local/src/index.ts:97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L97)）
- `runCleanup` 以 `Date.now() - 天数 * MS_PER_DAY` 为截止时刻，收集根后调用 `sweepSpillRoots`（[packages/spill/spill-local/src/index.ts:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L113-L117)）
- `gatherRoots` 把活动根与默认根基目录交给 `gatherSweepRoots`，是子类可覆盖的注入点（[packages/spill/spill-local/src/index.ts:133-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L133-L135)）
- `defaultRootsBase` 返回 OS 临时目录作为历史默认根的扫描基目录（[packages/spill/spill-local/src/index.ts:145-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L145-L147)）
- `saveText` 把 owner 的 sessionId、建议名与全文交给 `saveTextFile`，返回品牌化的路径定位符、字节数，以及固定的检索提示文案 `Use read with offset/limit, or grep this path to search within it.`（[packages/spill/spill-local/src/index.ts:149-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L149-L161)）
- 默认导出 `LocalSpillStore`，使该类成为包被当作插件加载时注册的服务（[packages/spill/spill-local/src/index.ts:164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/index.ts#L164)）

### packages/spill/spill-local/src/invariant.ts

该包的不变量伴生插件，向不变量服务登记包名。

- 导出 `name` 与 `inject = ['invariants']`，使其成为需要 `invariants` 服务的 cordis 插件（[packages/spill/spill-local/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/invariant.ts#L13-L15)）
- `install` 是空安装器，不注册任何检查（[packages/spill/spill-local/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其注销函数（[packages/spill/spill-local/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/invariant.ts#L28-L29)）

### packages/spill/spill-local/src/store.ts

不依赖 cordis 的存储机制模块：私有根创建、安全段编码、会话目录派生与独占写入，被插件入口与清扫模块共用。

- `DEFAULT_ROOT_PREFIX` 是默认根创建与启动发现共享的前缀常量（[packages/spill/spill-local/src/store.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/store.ts#L16)）
- `isErrno` 判断捕获值是否为带指定系统错误码的 Error，供各处的错误分流使用（[packages/spill/spill-local/src/store.ts:25-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/store.ts#L25-L27)）
- `privateRoot` 用模块级变量缓存，首次调用时以 `mkdtempSync` 在 OS 临时目录下建一个私有默认根并复用（[packages/spill/spill-local/src/store.ts:29-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/store.ts#L29-L39)）
- `encodeSegment` 把任意字符串编码成单个路径段：空串编成 `~`，整段的 `.` 与 `..` 被转义，其余逐个 code unit 保留 `[A-Za-z0-9._-]`（`~` 除外）否则转成 `~XXXX`（[packages/spill/spill-local/src/store.ts:55-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/store.ts#L55-L68)）
- `sessionDir` 取 `sha256(sessionId)` 十六进制前 12 位拼成 `session-<hash>` 子目录，使同一会话的文件聚在一起（[packages/spill/spill-local/src/store.ts:78-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/store.ts#L78-L81)）
- `saveTextFile` 的文件名由 6 字节随机十六进制前缀加连字符加编码后的建议名组成（[packages/spill/spill-local/src/store.ts:109-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/store.ts#L109-L110)）
- 写入循环：先 `mkdir` 递归建目录且模式 0700，再以 `wx`、0600 打开；ENOENT 时重试整轮，其他错误向上抛出（[packages/spill/spill-local/src/store.ts:111-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/store.ts#L111-L124)）
- 写入内容后在 `finally` 中关闭句柄，并返回路径与按 UTF-8 计算的字节长度（[packages/spill/spill-local/src/store.ts:125-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-local/src/store.ts#L125-L130)）

### packages/spill/spill-local/tsconfig.json

该包的 TypeScript 编译配置，设定源码根、输出目录与工程引用。

- 无运行期机制
