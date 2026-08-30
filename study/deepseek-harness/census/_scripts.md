---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · scripts/（仓库脚本）
---

# scripts/（仓库脚本）

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 117 个文件、973 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### scripts/AGENTS.md

仓库 scripts 目录的说明文档，三行叙述性文字，供阅读者了解该目录下门禁脚本的书写约定。

- 无运行期机制

### scripts/agent-note-tree.ts

遍历 `.agents/notes` 目录树的共享模块，被归档与结构校验类脚本导入以取得笔记清单和结构违规列表。

- `agentNoteRoot` 以模块自身目录为基准解析出 `../.agents/notes` 作为遍历根（[scripts/agent-note-tree.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L9)）
- 生命周期目录名被固定为 `proposed`/`implemented`/`rejected` 三项（[scripts/agent-note-tree.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L12)）
- 类别目录名被固定为六项，其他名字一律拒绝（[scripts/agent-note-tree.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L19)）
- `ROOT_ALLOWLIST` 只放行生命周期根目录下的 `AGENTS.md` 与 `CLAUDE.md`（[scripts/agent-note-tree.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L25)）
- 根目录下出现 `INDEX.md` 直接产生一条错误并跳过该条目（[scripts/agent-note-tree.ts:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L47-L50)）
- 根目录下既非 `archived` 也不在生命周期集合内的目录产生一条未知生命周期错误（[scripts/agent-note-tree.ts:51-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L51-L55)）
- 按生命周期用 `globSync` 匹配 `**/*.md`，路径分隔符统一成 `/` 后排序遍历（[scripts/agent-note-tree.ts:57-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L57-L58)）
- 生命周期根下的白名单文件与所有 `.zh.md` 文件被跳过而不计入笔记（[scripts/agent-note-tree.ts:61-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L61-L64)）
- 路径段数不等于三产生深度错误（[scripts/agent-note-tree.ts:67-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L67-L70)）
- 类别目录不在固定集合内产生未知类别错误（[scripts/agent-note-tree.ts:71-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L71-L74)）
- 文件名必须匹配 `yyyy-mm-dd-topic.md`，否则产生命名错误（[scripts/agent-note-tree.ts:75-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L75-L78)）
- 通过校验的文件以生命周期、相对路径和文件名前十位日期入列返回（[scripts/agent-note-tree.ts:79-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/agent-note-tree.ts#L79-L82)）

### scripts/archived-agent-notes.ts

归档笔记的清单、三元组与冻结校验函数集合，导入 `agent-note-tree.ts` 的类别集合，供归档门禁脚本调用。

- `archiveContentHash` 以 `sha256:<hex>` 形式给归档内容计算摘要（[scripts/archived-agent-notes.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L14-L16)）
- `gitBlobHash` 用 `blob <len>\0` 前缀加 SHA-1 复算 Git blob 标识（[scripts/archived-agent-notes.ts:19-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L19-L24)）
- `parseArchiveManifest` 要求顶层恰好是 `files` 与 `version` 两个字段、版本为 1、`files` 为对象（[scripts/archived-agent-notes.ts:31-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L31-L37)）
- 每个条目的哈希必须匹配 `sha256:` 加 64 位十六进制，否则抛错（[scripts/archived-agent-notes.ts:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L39-L44)）
- `renderArchiveManifest` 按路径排序后以两空格缩进并追加换行输出（[scripts/archived-agent-notes.ts:49-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L49-L54)）
- `validateArchiveManifestExtension` 对基线清单中缺失或哈希改变的条目各产生一条错误（[scripts/archived-agent-notes.ts:57-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L57-L68)）
- `validDate` 用 UTC 回读校验年月日三项是否与输入一致（[scripts/archived-agent-notes.ts:70-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L70-L78)）
- `pairMeta` 逐行解析 `<file>.md: <40位十六进制>`，跳过空行与 `#` 行，任一行不匹配即返回 undefined（[scripts/archived-agent-notes.ts:86-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L86-L95)）
- `validateHeader` 逐行断言第 1 行标题格式、第 2 行空、第 3 行 `Status: implemented`（[scripts/archived-agent-notes.ts:100-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L100-L102)）
- 第 4 行必须是合法 `Archived: YYYY-MM-DD` 且不早于文件名日期（[scripts/archived-agent-notes.ts:103-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L103-L108)）
- 第 5 行必须为空、第 6 行必须是按语言方向拼出的语言切换行（[scripts/archived-agent-notes.ts:109-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L109-L113)）
- `validateArchiveArtifacts` 用正则要求路径形如 `{kind}/yyyy-mm-dd-topic.{md,zh.md,i18n.yaml}`（[scripts/archived-agent-notes.ts:122-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L122-L125)）
- 首段目录必须落在 `AGENT_NOTE_CLASSES` 内，否则报未知类别（[scripts/archived-agent-notes.ts:127-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L127-L130)）
- 同名文件按后缀归入 source/zh/meta 三元组（[scripts/archived-agent-notes.ts:131-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L131-L137)）
- 三元组缺任一成员即报错并跳过后续校验（[scripts/archived-agent-notes.ts:144-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L144-L152)）
- 中英两侧分别过头部校验，且两侧 `Archived:` 日期必须相同（[scripts/archived-agent-notes.ts:154-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L154-L160)）
- 一致性 sidecar 必须恰好含两条记录且等于两侧当前 Git blob 哈希（[scripts/archived-agent-notes.ts:161-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L161-L166)）
- `extendArchiveManifest` 对已封存条目缺失或内容哈希改变各产生一条错误（[scripts/archived-agent-notes.ts:178-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L178-L182)）
- 未在清单中的产物按路径排序追加其内容哈希并记入 added（[scripts/archived-agent-notes.ts:183-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/archived-agent-notes.ts#L183-L189)）

### scripts/attribute-chunk-bytes.mjs

零依赖命令行工具，读取一个构建产物 chunk 及其 sourcemap，把压缩后的字节归因到来源包并打印分布。

- 从 argv 取 chunk 路径与 `--top N`，同时读取 chunk 与同名 `.map` 文件（[scripts/attribute-chunk-bytes.mjs:8-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/attribute-chunk-bytes.mjs#L8-L11)）
- 自建 base64 字符表逐行解码 VLQ 段，维护 srcIdx/srcLine/srcCol/nameIdx 增量状态（[scripts/attribute-chunk-bytes.mjs:13-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/attribute-chunk-bytes.mjs#L13-L48)）
- 空映射行整行长度计入 unmapped（[scripts/attribute-chunk-bytes.mjs:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/attribute-chunk-bytes.mjs#L26)）
- 相邻段之间的跨度按来源索引累加到 `bySource`，无来源的段计入 unmapped（[scripts/attribute-chunk-bytes.mjs:49-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/attribute-chunk-bytes.mjs#L49-L56)）
- `bucketOf` 按 vite 虚拟前缀、最后一个 `node_modules/<pkg>/`、`packages/<组>/<包>/`、`vendor/<名>/`、`apps/web/` 的顺序归桶（[scripts/attribute-chunk-bytes.mjs:59-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/attribute-chunk-bytes.mjs#L59-L70)）
- 按桶汇总并把 unmapped 作为独立一桶写入结果表（[scripts/attribute-chunk-bytes.mjs:72-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/attribute-chunk-bytes.mjs#L72-L78)）
- 按字节降序打印前 topN 行、超出部分只打印剩余桶数，并输出已归因合计（[scripts/attribute-chunk-bytes.mjs:80-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/attribute-chunk-bytes.mjs#L80-L92)）
- 末尾按 `ws:` 前缀、`(` 前缀与其余三类打印 npm-vendor/workspace/glue 汇总（[scripts/attribute-chunk-bytes.mjs:95-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/attribute-chunk-bytes.mjs#L95-L101)）

### scripts/build-exe-for-python-sdk-native-pty.ts

解析 node-pty 原生插件路径的小模块，被 `build-exe-for-python-sdk.ts` 在打包前调用。

- Linux 侧优先取 `build/Release/pty.node`，其次取 `prebuilds/linux-<arch>/pty.node`，两者都不存在则抛错（[scripts/build-exe-for-python-sdk-native-pty.ts:12-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk-native-pty.ts#L12-L23)）
- Windows 侧要求 `conpty.node` 与 `conpty_console_list.node` 同时存在并按加载顺序返回，缺失时抛错列出缺哪些（[scripts/build-exe-for-python-sdk-native-pty.ts:31-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk-native-pty.ts#L31-L45)）

### scripts/build-exe-for-python-sdk.ts

把仓库构建产物部署成无符号链接的闭包并用 pkg 打成单文件可执行程序，同时把 node 载体和产物同步进 Python 运行时包目录。

- 一组常量固定了闭包清单包名、入口 bin 路径、产物基名、默认 node 大版本、被钉住的 pkg 版本、输出目录与 Python 运行时目录（[scripts/build-exe-for-python-sdk.ts:18-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L18-L36)）
- `ASSET_GLOBS` 把 node_modules 下的多种扩展名、前端 dist 与 skill-badge 资源整树声明为 pkg 资产（[scripts/build-exe-for-python-sdk.ts:43-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L43-L64)）
- `Target.parse` 要求三段式 spec、node 范围形如 `node24`、平台与架构在闭集合内，且 Windows 只允许 x64（[scripts/build-exe-for-python-sdk.ts:102-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L102-L121)）
- `Target.host` 把 `process.platform`/`process.arch` 映射为 pkg 标签，不支持的宿主直接抛错（[scripts/build-exe-for-python-sdk.ts:127-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L127-L146)）
- CLI 解析失败打印用法后退出码 1，`--help` 打印用法后退出码 0（[scripts/build-exe-for-python-sdk.ts:169-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L169-L180)）
- 未给 `--targets` 时默认只构建宿主目标；给了则逗号切分逐个解析，空列表与重复 platform-arch 抛错（[scripts/build-exe-for-python-sdk.ts:181-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L181-L193)）
- `pnpmInvocation` 依 `npm_execpath` 后缀选择用当前 node 执行 JS 入口或直接执行该文件，`.cmd` 被跳过（[scripts/build-exe-for-python-sdk.ts:225-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L225-L232)）
- 无可用入口时从 `PNPM_HOME` 旁探测 `pnpm.mjs`/`pnpm.cjs`，Windows 上找不到则抛错，其他平台回退到裸 `pnpm`（[scripts/build-exe-for-python-sdk.ts:233-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L233-L244)）
- 打包前先跑 `verify-runtime-closure`（[scripts/build-exe-for-python-sdk.ts:271-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L271-L273)）
- `--skip-build` 时跳过 `pnpm run build`，否则执行完整构建（[scripts/build-exe-for-python-sdk.ts:276-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L276-L282)）
- staging 目录等于仓库根或包含仓库根时拒绝清理并抛错（[scripts/build-exe-for-python-sdk.ts:286-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L286-L288)）
- 部署用 `pnpm deploy --legacy --prod` 并强制 hoisted linker、关闭自动装 peer、开启 workspace 链接（[scripts/build-exe-for-python-sdk.ts:291-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L291-L301)）
- 部署后从 staging 删除 README 等仅部署期文档（[scripts/build-exe-for-python-sdk.ts:304-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L304-L308)）
- `restoreLegacyHoists` 把清单里缺失的直接依赖从 `python/sdk-runtime/node_modules` 复制进来，过滤掉嵌套 node_modules，源也缺失则抛错（[scripts/build-exe-for-python-sdk.ts:322-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L322-L345)）
- 补齐后仍缺依赖则抛错列出名单（[scripts/build-exe-for-python-sdk.ts:346-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L346-L350)）
- `materializeStagedLinks` 循环查找符号链接：`.bin` 目录整体删除，其余链接解引用复制成实体后重查，直到不存在链接（[scripts/build-exe-for-python-sdk.ts:362-383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L362-L383)）
- `findSymlink` 递归目录返回首个符号链接路径（[scripts/build-exe-for-python-sdk.ts:386-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L386-L397)）
- `injectPkgConfig` 把 `bin` 与 `pkg.assets` 合并写回 staging 的 package.json，清单或入口 bin 缺失时抛错（[scripts/build-exe-for-python-sdk.ts:400-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L400-L415)）
- `pack` 按平台决定产物是否带 `.exe`，再以 `pnpm dlx <钉住的 pkg> --sea --targets --output` 打一个目标（[scripts/build-exe-for-python-sdk.ts:424-437](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L424-L437)）
- pkg 跑完后产物不存在则抛错（[scripts/build-exe-for-python-sdk.ts:438-440](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L438-L440)）
- macOS 目标额外把 node-pty 的 `spawn-helper` 复制到产物旁并置为 0o755（[scripts/build-exe-for-python-sdk.ts:442-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L442-L451)）
- `copyRipgrepSidecar` 把目标平台的 rg 二进制复制到产物旁并置可执行位，源缺失时抛错（[scripts/build-exe-for-python-sdk.ts:455-478](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L455-L478)）
- `prepareNativePty` 先清空 staging 内 node-pty 的 build 目录（[scripts/build-exe-for-python-sdk.ts:487-489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L487-L489)）
- Windows 目标要求宿主平台与架构与目标一致并校验两个 ConPTY 插件存在（[scripts/build-exe-for-python-sdk.ts:498-511](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L498-L511)）
- Linux 目标同样要求宿主匹配，然后把解析出的 addon 复制到 `build/Release/pty.node`；非 linux/win 目标直接返回（[scripts/build-exe-for-python-sdk.ts:512-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L512-L527)）
- `printProducts` 在非 dry-run 时打印每个产物的字节大小（[scripts/build-exe-for-python-sdk.ts:534-544](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L534-L544)）
- `syncToPythonRuntime` 把每个产物复制进 Python 运行时目录并沿用源文件的权限位（[scripts/build-exe-for-python-sdk.ts:551-565](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L551-L565)）
- 所有子进程以继承 stdio 启动且环境里强制 `CI=true`（[scripts/build-exe-for-python-sdk.ts:582-588](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L582-L588)）
- 子进程 spawn 失败或非零退出都转成带命令行的错误 reject（[scripts/build-exe-for-python-sdk.ts:589-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L589-L600)）
- `main` 按 验证闭包→构建→部署→注入 pkg 配置→逐目标打包→打印→同步 的固定顺序执行（[scripts/build-exe-for-python-sdk.ts:610-625](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-exe-for-python-sdk.ts#L610-L625)）

### scripts/build-python-release.py

按仓库版本暂存并构建一个 Python wheel 的命令行脚本，同时被 `check-macos-deployment-target.py` 以 `runpy` 载入取平台表。

- 平台清单从 `python/sdk-runtime/platforms.json` 读入，非字典、空表或条目字段不是恰好 `tag`+`executable` 字符串即抛错（[scripts/build-python-release.py:25-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L25-L44)）
- 模块导入时即执行 `load_platforms()` 并把结果放入模块级 `PLATFORMS`（[scripts/build-python-release.py:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L47)）
- `runtime_filenames` 由可执行文件名派生出 `-rg`（或 `-rg.exe`）伴随文件，macOS 名再补 `-spawn-helper`（[scripts/build-python-release.py:50-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L50-L55)）
- runtime 构建必须同时给 `--platform` 与 `--runtime-exe`，sdk 构建则不允许给这两个参数（[scripts/build-python-release.py:73-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L73-L76)）
- 在临时目录里暂存包后调用 `uv build --wheel`，runtime 构建额外注入 `DSH_RUNTIME_PLATFORM_TAG` 环境变量（[scripts/build-python-release.py:80-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L80-L92)）
- 构建后若预期文件名的 wheel 不存在则抛错，存在则做完整校验并打印路径（[scripts/build-python-release.py:93-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L93-L96)）
- `repository_version` 从根 package.json 取版本并要求 `X.Y.Z` 加可选预发布段（[scripts/build-python-release.py:99-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L99-L110)）
- `pep440_version` 把 `-rc.1` 一类预发布段翻成 PEP 440 拼法，无法翻译时抛错（[scripts/build-python-release.py:113-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L113-L132)）
- `validate_release_tag` 要求传入的 tag 恰为 `python-v<仓库版本>`（[scripts/build-python-release.py:135-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L135-L142)）
- `copy_package` 复制时忽略 `.venv`、缓存、`dist`、`node_modules` 与已有运行时可执行文件（[scripts/build-python-release.py:145-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L145-L158)）
- `rewrite_version` 在 pyproject 中只替换首个 `version = "..."`，替换次数不为 1 则抛错（[scripts/build-python-release.py:161-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L161-L171)）
- `stage_license_files` 复制 LICENSE（runtime 另加 THIRD_PARTY_NOTICES.md）并在 pyproject 里插入 `license-files` 声明（[scripts/build-python-release.py:174-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L174-L191)）
- `stage_sdk` 把 SDK 对 runtime 包的依赖钉写成同版本，且要求恰好一处匹配（[scripts/build-python-release.py:199-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L199-L207)）
- `stage_runtime` 校验传入可执行文件名与平台表一致，再把整组运行时载荷复制进包内 runtime 目录（[scripts/build-python-release.py:210-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L210-L222)）
- `verify_wheel` 从 wheel 内读取 WHEEL 与 METADATA，断言平台 tag、版本与分发名（[scripts/build-python-release.py:231-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L231-L245)）
- 断言许可证表达式为 MIT，且 License-File 列表按包类型精确匹配（[scripts/build-python-release.py:246-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L246-L255)）
- runtime wheel 内运行时文件名必须与 `runtime_filenames` 完全一致，且非 Windows 平台必须保留用户可执行位（[scripts/build-python-release.py:256-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L256-L268)）
- sdk wheel 内不得出现运行时可执行文件，且必须包含对 runtime 包的同版本 `Requires-Dist` 钉（[scripts/build-python-release.py:269-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build-python-release.py#L269-L275)）

### scripts/build.ts

仓库完整构建的入口脚本，串起 `build:lib` 与 `build:web` 并写下客户端构建记录。

- `runScript` 通过 `pnpmInvocation` 以指定环境在仓库根运行一个包脚本，spawn 出错或退出码非零即抛错（[scripts/build.ts:18-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build.ts#L18-L29)）
- 解析 `--profile`，缺省时回落到 `DSH_BUILD_CLIENT_PROFILE` 环境变量（[scripts/build.ts:33-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build.ts#L33-L39)）
- 由仓库环境与 profile 解析出客户端环境，再构造只含选定公开值的子进程环境（[scripts/build.ts:38-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build.ts#L38-L41)）
- 构建前先删除旧的客户端构建记录文件（[scripts/build.ts:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build.ts#L43)）
- 依次运行 `build:lib` 与 `build:web`，成功后写入构建记录并打印产物数与公开值数（[scripts/build.ts:44-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build.ts#L44-L49)）
- 仅在作为主模块运行时执行 `main`（[scripts/build.ts:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/build.ts#L52)）

### scripts/change-scope.ts

输出一次改动的已提交与工作区路径清单的脚本，既导出 `renderChangeScope` 供调用，也可作为 CLI 直接运行。

- 报告带 `formatVersion` 常量，Git 输出上限固定为 64 MiB，UTF-8 解码器为 fatal 模式（[scripts/change-scope.ts:8-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L8-L10)）
- 所有 Git 调用统一带 `-C <cwd>`、关闭 fsmonitor，并注入 `GIT_OPTIONAL_LOCKS=0` 与 C 语言环境（[scripts/change-scope.ts:61-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L61-L72)）
- Git 输出不是合法 UTF-8 时抛出带流名的错误（[scripts/change-scope.ts:74-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L74-L80)）
- `requireGit`/`requireGitBytes` 在非零退出时抛错，错误详情取自 spawn 错误、stderr 或退出码（[scripts/change-scope.ts:82-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L82-L100)）
- 参数解析禁止位置参数，`--base` 必填、`--head` 默认 `HEAD`（[scripts/change-scope.ts:102-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L102-L114)）
- 解析 ref 用 `rev-parse --verify --end-of-options <ref>^{commit}` 并开启 `core.warnAmbiguousRefs`，检出歧义、失败或非唯一结果三种错误（[scripts/change-scope.ts:116-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L116-L137)）
- 合并基用 `merge-base --all` 求取，不存在或不唯一都抛错（[scripts/change-scope.ts:139-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L139-L153)）
- 路径集按 NUL 分隔逐条解码，单条非 UTF-8 报出第几条，最终去重并排序（[scripts/change-scope.ts:155-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L155-L172)）
- diff 统一加 `--no-ext-diff --no-textconv --no-renames --ignore-submodules=none --name-only -z` 并以 `--` 收尾（[scripts/change-scope.ts:174-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L174-L186)）
- 仓库根由 `rev-parse --show-toplevel` 取得并剥掉行尾终止符（[scripts/change-scope.ts:188-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L188-L198)）
- 报告的四类路径分别取自 mergeBase..head、`--cached`、无参 diff 与 `ls-files --others --exclude-standard`（[scripts/change-scope.ts:214-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L214-L223)）
- `renderChangeScope` 以两空格缩进的 JSON 加一个换行返回（[scripts/change-scope.ts:233-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L233-L237)）
- 作为主模块运行时把报告写 stdout，出错写 stderr 并置 `exitCode = 1`（[scripts/change-scope.ts:239-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/change-scope.ts#L239-L248)）

### scripts/check-expected-filenames.sh

一个 bash 门禁脚本，检查被跟踪的非 vendor 文件名里是否出现 `golden`。

- `set -euo pipefail` 让任一命令失败即终止（[scripts/check-expected-filenames.sh:2](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-expected-filenames.sh#L2)）
- 用临时文件承接结果并在退出时 trap 删除（[scripts/check-expected-filenames.sh:6-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-expected-filenames.sh#L6-L7)）
- 以 `git ls-files -z` 配合大小写不敏感 glob 匹配含 `golden` 的路径，并排除 `vendor/**`（[scripts/check-expected-filenames.sh:8-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-expected-filenames.sh#L8-L11)）
- 按 NUL 分隔读入违规数组（[scripts/check-expected-filenames.sh:13-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-expected-filenames.sh#L13-L16)）
- 无违规时打印通过信息并退出 0（[scripts/check-expected-filenames.sh:18-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-expected-filenames.sh#L18-L21)）
- 有违规时把清单与改名提示打到 stderr 并退出 1（[scripts/check-expected-filenames.sh:23-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-expected-filenames.sh#L23-L26)）

### scripts/check-macos-deployment-target.py

校验 macOS 运行时可执行文件的部署目标不高于 wheel 平台标签所声明版本的命令行脚本。

- 用 `runpy.run_path` 执行 `build-python-release.py` 并从其 `PLATFORMS` 取出 `macos-arm64` 的平台标签（[scripts/check-macos-deployment-target.py:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-macos-deployment-target.py#L13-L15)）
- `parse_version` 只接受点分数字串，否则抛错（[scripts/check-macos-deployment-target.py:18-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-macos-deployment-target.py#L18-L22)）
- `claimed_version` 从 `macosx_X_Y_arm64` 标签解析出声明的最低版本，其他形式抛错（[scripts/check-macos-deployment-target.py:25-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-macos-deployment-target.py#L25-L30)）
- 从 otool 输出里抓取全部 `minos` 行并取最大值，一条都没有时抛错（[scripts/check-macos-deployment-target.py:33-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-macos-deployment-target.py#L33-L41)）
- 文件不存在直接抛 FileNotFoundError，存在则以 `check=True` 运行 `otool -l` 读取（[scripts/check-macos-deployment-target.py:44-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-macos-deployment-target.py#L44-L57)）
- 比较前把实测与声明版本补零对齐到同长度，实测更高即抛 RuntimeError（[scripts/check-macos-deployment-target.py:60-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-macos-deployment-target.py#L60-L72)）
- CLI 接受一个或多个可执行文件路径，逐个校验并打印实测版本与声明标签（[scripts/check-macos-deployment-target.py:85-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-macos-deployment-target.py#L85-L92)）

### scripts/check-vendor-manifest.sh

一个 bash 门禁脚本，检查暂存区里 vendor 源码改动是否与 `vendor/README.md` 同步。

- `set -euo pipefail` 让任一命令失败即终止（[scripts/check-vendor-manifest.sh:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-vendor-manifest.sh#L5)）
- 从 `git diff --cached --name-only` 取暂存文件名清单（[scripts/check-vendor-manifest.sh:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-vendor-manifest.sh#L7)）
- 分别匹配 `vendor/<包>/src/` 或 `vendor/<包>/bin.js` 的改动与 `vendor/README.md` 的改动（[scripts/check-vendor-manifest.sh:9-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-vendor-manifest.sh#L9-L10)）
- 前者非空而后者为空时打印改动清单与提示并退出 1（[scripts/check-vendor-manifest.sh:12-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-vendor-manifest.sh#L12-L17)）

### scripts/check-workspace-constraints.ts

遍历全部工作区 package.json 并逐条断言发布与依赖策略的门禁脚本，导出若干检查函数并可直接作为 CLI 运行。

- `workspaceGlobs` 规定 vendor/native/apps 扫一层、packages 扫两层（[scripts/check-workspace-constraints.ts:17-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L17-L23)）
- 被 vendored 的包名集合会让后续 dsh 策略在该包上短路（[scripts/check-workspace-constraints.ts:24-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L24-L34)）
- 公开 Landlock 包名集合与其源码发布白名单被固定枚举（[scripts/check-workspace-constraints.ts:35-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L35-L43)）
- Landlock 包与其他发布成员使用两个不同的 repository URL 常量（[scripts/check-workspace-constraints.ts:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L44-L50)）
- 实验包目录与包名前缀、以及发布成员目录用正则界定（[scripts/check-workspace-constraints.ts:52-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L52-L56)）
- `appPackageFiles` 为 apps 下的包写死允许的 files 列表（[scripts/check-workspace-constraints.ts:58-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L58-L64)）
- `packageDirs` 按深度递归收集含 package.json 的目录并跳过 `node_modules`（[scripts/check-workspace-constraints.ts:115-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L115-L127)）
- `workspaceManifests` 把根清单与各工作区清单一并读入（[scripts/check-workspace-constraints.ts:129-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L129-L141)）
- `packageFileExtras` 为具名包追加额外允许发布的样式表、py 源码、预设、资源与 bin 等条目（[scripts/check-workspace-constraints.ts:143-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L143-L175)）
- `expectedDshPackageFiles` 依 `dsh.bundle.patch`、`bin` 以及各 export 子路径的运行时目标推导出期望的 files 数组（[scripts/check-workspace-constraints.ts:181-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L181-L228)）
- `hasExportPair` 要求条件导出的 types 与 default 精确等于生成的声明与运行时路径（[scripts/check-workspace-constraints.ts:231-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L231-L242)）
- `exportDefault` 同时接受字符串简写与条件对象的 `default` 作为运行时目标（[scripts/check-workspace-constraints.ts:245-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L245-L250)）
- 任一导出的运行时目标落在 `./lib/types/` 下时额外要求发布 `lib/types/**/*.js`（[scripts/check-workspace-constraints.ts:253-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L253-L256)）
- 实验包必须用指定名字前缀、设 `private: true` 且不带 publishConfig（[scripts/check-workspace-constraints.ts:259-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L259-L269)）
- 公开 Landlock 包必须非 private、access 为 public，且 repository 指向 `repositoryUrl` 与自身目录（[scripts/check-workspace-constraints.ts:284-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L284-L296)）
- 发布成员目录下的包必须非 private、access 为 public，且 repository 指向 `publishedRepositoryUrl` 与自身目录（[scripts/check-workspace-constraints.ts:297-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L297-L318)）
- 既非发布成员也非实验包的目录必须设 `private: true`（[scripts/check-workspace-constraints.ts:319-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L319-L321)）
- 命中 vendored 包名时提前返回，跳过其余全部检查（[scripts/check-workspace-constraints.ts:323-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L323-L325)）
- `@deepseek-ai/` 包的 files 条目逐个过 `isForbiddenPublicationFile`，白名单外的命中报错（[scripts/check-workspace-constraints.ts:327-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L327-L334)）
- apps 下的包必须在 `appPackageFiles` 里有条目且 files 与其逐项相等（[scripts/check-workspace-constraints.ts:336-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L336-L343)）
- Landlock 目录下出现名单外的包会报错，且版本必须与 Landlock 工作区版本一致（[scripts/check-workspace-constraints.ts:345-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L345-L352)）
- dsh 包必须同时声明 `@deepseek-ai/cordis` 的 peer 与 dev 依赖且两者范围一致（[scripts/check-workspace-constraints.ts:354-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L354-L362)）
- dsh 包版本必须等于根版本，且 `type`、`main`、`types` 三字段取固定值（[scripts/check-workspace-constraints.ts:363-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L363-L374)）
- 根导出的 types 与 default 必须分别是 `./lib/types/index.d.ts` 与 `./lib/index.js`（[scripts/check-workspace-constraints.ts:375-382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L375-L382)）
- `./invariant` 导出若存在则两个目标路径固定，且 types 与 default 必须成对出现（[scripts/check-workspace-constraints.ts:383-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L383-L393)）
- dsh 包的 files 必须与 `expectedDshPackageFiles` 推导结果逐项相等（[scripts/check-workspace-constraints.ts:394-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L394-L397)）
- 所有错误被统一加上该包 package.json 的仓库相对路径前缀（[scripts/check-workspace-constraints.ts:400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L400)）
- `checkHierarchyShape` 要求 packages 下的组目录不含 package.json、且组内每个子目录都含 package.json（[scripts/check-workspace-constraints.ts:407-427](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L407-L427)）
- `checkRepositoryVersion` 要求根版本形如 `X.Y.Z` 加可选预发布段（[scripts/check-workspace-constraints.ts:429-434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L429-L434)）
- `checkExperimentalDependencyIsolation` 禁止发布成员与 `python/sdk-runtime` 在运行期依赖段引用实验包（[scripts/check-workspace-constraints.ts:446-462](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L446-L462)）
- `checkWorkspaceProtocol` 要求任何指向工作区成员的依赖范围都以 `workspace:` 开头（[scripts/check-workspace-constraints.ts:474-486](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L474-L486)）
- `main` 汇总六组检查（含 `collectProjectReferenceFaceViolations`），有错误时打印并置 `exitCode = 1`（[scripts/check-workspace-constraints.ts:489-507](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L489-L507)）
- 仅在被当作入口执行时调用 `main`（[scripts/check-workspace-constraints.ts:509](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/check-workspace-constraints.ts#L509)）

### scripts/clean.ts

删除仓库构建产物与残留目录的脚本，导出 `RepositoryCleaner` 并可作为 `pnpm run clean` 的入口运行。

- `knownOrphanEntries` 把 `node_modules`、`lib`、`.typecheck` 列为可接受的残留条目（[scripts/clean.ts:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L7)）
- `parseConfig` 在 tsconfig 无法解析或带诊断错误时抛出（[scripts/clean.ts:37-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L37-L44)）
- `clean` 先完整规划再逐个 `rm -rf`，返回被删路径的仓库相对形式（[scripts/clean.ts:58-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L58-L63)）
- 规划阶段收集 `.dsh-build`、根 `.typecheck`、根下 `*.tsbuildinfo` 与 landlock 的 tsbuildinfo（[scripts/clean.ts:70-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L70-L81)）
- 再把项目引用图推导出的每个构建输出根加入删除目标（[scripts/clean.ts:86-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L86-L88)）
- 含 package.json 的包目录被跳过；不含时只有当剩余条目全是已知残留才加入删除目标（[scripts/clean.ts:90-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L90-L108)）
- 出现未知残留条目时整次清理抛错并列出这些路径，不删除任何东西（[scripts/clean.ts:110-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L110-L115)）
- `buildOutputDirectories` 从根 tsconfig 出发按 projectReferences 广度遍历并去重（[scripts/clean.ts:120-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L120-L151)）
- `outDir` 必须以 `/types` 结尾（或恰为 native entry 的 lib），否则抛错（[scripts/clean.ts:134-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L134-L143)）
- `assertDescendant` 对越出仓库根的路径拒绝删除并抛错（[scripts/clean.ts:160-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L160-L165)）
- `addIfPresent` 只收录已存在的路径，并对父目录取 realpath 后再做仓库边界断言（[scripts/clean.ts:167-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L167-L175)）
- 作为主模块运行时打印删除数量或 already clean，出错写 stderr 并置 `exitCode = 1`（[scripts/clean.ts:178-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/clean.ts#L178-L191)）

### scripts/client-build-environment.ts

定义会被内联进浏览器产物的公开构建环境及其记录格式的模块，被 `build.ts`、`dev-web.ts` 等导入。

- 只有 `DSH_CLIENT_` 前缀的变量算作可内联的公开值（[scripts/client-build-environment.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L14)）
- `DSH_BUILD_CLIENT_PROFILE` 作为非公开的 profile 选择器（[scripts/client-build-environment.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L17)）
- official profile 的公开值被写死为构建 profile 名与标题两项（[scripts/client-build-environment.ts:20-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L20-L23)）
- 构建记录路径、格式版本与被摘要的产物 glob 集合被固定（[scripts/client-build-environment.ts:32-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L32-L39)）
- `repositoryCommitHash` 优先取环境变量、否则跑 `git rev-parse HEAD`，校验十六进制后截前 7 位小写（[scripts/client-build-environment.ts:50-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L50-L61)）
- `repositoryVersion` 读根 package.json 并要求版本匹配 semver 正则（[scripts/client-build-environment.ts:68-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L68-L82)）
- `repositoryGitDirty` 先探测是否在工作树内，再用 `git status --porcelain=v1` 判断是否有改动，非 Git 环境返回 undefined（[scripts/client-build-environment.ts:89-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L89-L107)）
- `repositoryClientBuildEnvironment` 丢弃继承来的 commit/dirty/version 三项并以仓库实测值覆盖（[scripts/client-build-environment.ts:116-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L116-L131)）
- `officialClientBuildEnvironment` 组合仓库 commit、版本与 official 固定值（[scripts/client-build-environment.ts:139-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L139-L148)）
- `clientBuildEnvironment` 只保留前缀匹配且已定义的变量并按名排序（[scripts/client-build-environment.ts:173-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L173-L177)）
- 未选 profile 时直接沿用继承的公开值；选 official 时要求 commit 与 version 均已给出；其他名字抛错（[scripts/client-build-environment.ts:185-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L185-L206)）
- `clientBuildProcessEnvironment` 从父环境剔除选择器与全部前缀变量后再并入选定的公开值（[scripts/client-build-environment.ts:214-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L214-L224)）
- `assertClientBuildEnvironment` 要求实际公开值集合与目标 profile 完全相等，差异项名字进入错误消息（[scripts/client-build-environment.ts:236-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L236-L250)）
- `clientBuildEnvironmentDefines` 把 `process.env` 定义为 `{}`，再为每个公开变量生成精确替换项（[scripts/client-build-environment.ts:263-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L263-L271)）
- `writeClientBuildRecord` 把格式版本、公开环境与产物摘要写成带尾换行的 JSON（[scripts/client-build-environment.ts:279-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L279-L292)）
- `readClientBuildRecord` 在记录缺失或 JSON 非法时抛错，可选地断言公开环境，并重算摘要与记录比对（[scripts/client-build-environment.ts:300-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L300-L326)）
- `clientArtifactDigest` 对匹配的文件排序后以长度前缀方式喂入 SHA-256，产物为空时抛错（[scripts/client-build-environment.ts:329-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L329-L345)）
- `parseClientBuildRecord` 逐项校验顶层键集合、格式版本、环境键前缀与类型、文件数与 64 位十六进制摘要（[scripts/client-build-environment.ts:348-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/client-build-environment.ts#L348-L384)）

### scripts/cordis-config-files.ts

发现仓库内 Cordis Loader YAML 配置文件的小模块，被配置校验类脚本导入。

- 用 `globSync` 匹配 `**/*cordis*.yml` 与 `**/*cordis*.yaml`，排除 `.claude/`、`node_modules/`、`vendor/` 与 `*.i18n.yaml` 后排序返回（[scripts/cordis-config-files.ts:13-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-config-files.ts#L13-L18)）

### scripts/cordis-core-api.ts

从钉住的 vendor 声明生成 Cordis 核心 API 文档页的渲染模块，被 `gen-cordis-catalog` 生成器调用。

- `CORDIS_CORE_API_PAGES` 写死五个页面的输出路径、标题、导语与各自的 section 组成（[scripts/cordis-core-api.ts:27-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L27-L79)）
- `load` 用缓存把每个源文件解析成一次 SourceFile（[scripts/cordis-core-api.ts:98-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L98-L105)）
- `sourceJsDoc` 按声明所在行的缩进逐行反缩进 JSDoc 原文（[scripts/cordis-core-api.ts:107-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L107-L118)）
- `signatureOf` 切掉函数体或初始化器并把空白折叠成单空格得到签名文本（[scripts/cordis-core-api.ts:120-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L120-L128)）
- `headingParams` 渲染参数名时丢掉 `this`、给 rest 加 `...`、给可选或带默认值的加 `?`（[scripts/cordis-core-api.ts:130-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L130-L139)）
- 成员筛选排除 private/protected、计算属性名、私有标识符与下划线开头的名字，静态成员单列（[scripts/cordis-core-api.ts:141-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L141-L154)）
- 同名成员组里取第一条带正文的 JSDoc，全无正文则记一条违规（[scripts/cordis-core-api.ts:166-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L166-L170)）
- 对承载文档的函数成员跑 `checkParams`/`checkReturns`，无返回类型注解的方法额外记一条违规（[scripts/cordis-core-api.ts:176-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L176-L183)）
- 重载方法只渲染无函数体的那些签名，其余情况渲染整组（[scripts/cordis-core-api.ts:191-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L191-L193)）
- `heritageMembers` 解析 `Pick<Class, 'a' | 'b'>` 继承子句，把被选中的类方法并入成员组（[scripts/cordis-core-api.ts:206-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L206-L237)）
- `contextMergeMembers` 在文件缺少 Context 模块合并时抛错（[scripts/cordis-core-api.ts:239-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L239-L242)）
- `classMembers` 在类不存在时抛错、类无 JSDoc 时记违规，并把同名接口声明的属性并入实例成员（[scripts/cordis-core-api.ts:266-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L266-L299)）
- `stripBodies` 从后往前剪掉函数体文本，只保留签名部分（[scripts/cordis-core-api.ts:310-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L310-L335)）
- `declarationPaste` 在符号找不到时抛错，找到多处时把各段 JSDoc 与去 export 前缀的声明拼接（[scripts/cordis-core-api.ts:337-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L337-L356)）
- `sourceLink` 把 `file:line` 指针渲染成带 `#L` 锚点的相对链接（[scripts/cordis-core-api.ts:358-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L358-L361)）
- `unlink` 把 `{@link target|label}` 替换成 label 或反引号包裹的 target（[scripts/cordis-core-api.ts:363-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L363-L368)）
- `renderMember` 依次输出三级标题、带 `ts cordis-catalog` 标记的代码块、正文、参数列表、Returns 与源码链接（[scripts/cordis-core-api.ts:378-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L378-L388)）
- 页面开头固定写入"由生成器生成、勿手改"的注释块（[scripts/cordis-core-api.ts:396-404](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L396-L404)）
- 三种 section 类型分别按 context-merge、class（含静态成员小节）与 decl 渲染（[scripts/cordis-core-api.ts:405-425](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L405-L425)）
- 渲染结束调用 `reportViolations` 上报累积违规，并把三个以上连续换行压成两个后补尾换行（[scripts/cordis-core-api.ts:426-427](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L426-L427)）
- `renderCordisCoreApiPages` 把全部页面渲染成 输出路径 → 内容 的 Map（[scripts/cordis-core-api.ts:431-433](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-core-api.ts#L431-L433)）

### scripts/cordis-walk.ts

供 Cordis 生成器共用的 AST 遍历模块，负责定位模块合并块并枚举其中的 Context 键与事件名。

- `MERGE_HEAD` 正则作为文本预筛，兼容单双引号两种写法（[scripts/cordis-walk.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-walk.ts#L14)）
- `contextMergeFiles` 对 glob 结果去重、统一分隔符并排序后逐个读文件（[scripts/cordis-walk.ts:31-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-walk.ts#L31-L34)）
- 文本不含合并头的文件被跳过，不进入 AST 解析（[scripts/cordis-walk.ts:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-walk.ts#L35)）
- 一个文件里的每个合并块各产生一条结果条目（[scripts/cordis-walk.ts:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-walk.ts#L36-L39)）
- `cordisModuleBodies` 只认模块名为 `@deepseek-ai/cordis` 或 `./context.ts` 的声明块，按源码顺序收集（[scripts/cordis-walk.ts:45-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-walk.ts#L45-L53)）
- `cordisModuleBody` 只返回第一个合并块，没有则返回 null（[scripts/cordis-walk.ts:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-walk.ts#L58-L60)）
- `contextKeyMap` 只收 `interface Context` 里带类型注解的属性签名，映射为 键 → 类型文本（[scripts/cordis-walk.ts:69-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-walk.ts#L69-L79)）
- `eventNameList` 从 `interface Events` 的方法与属性成员一并取名，字面量与标识符取 text、其他取原文（[scripts/cordis-walk.ts:90-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-walk.ts#L90-L102)）

### scripts/cordis-yaml.ts

解析 Cordis 配置 YAML 并判定 Loader 条目类型的共享模块，被仓库各配置检查导入。

- 自定义 `tag:yaml.org,2002:js` 标量类型把 `!!js` 表达式构造成 `{ __jsExpr }` 数据而不执行（[scripts/cordis-yaml.ts:13-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-yaml.ts#L13-L20)）
- 解析 schema 由 `JSON_SCHEMA` 扩展而来，其他 YAML 标签不被支持（[scripts/cordis-yaml.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-yaml.ts#L21)）
- `loadCordisYaml` 用该 schema 载入源文本（[scripts/cordis-yaml.ts:28-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-yaml.ts#L28-L30)）
- `isJsExpr` 以 `__jsExpr` 为字符串判定保留下来的表达式（[scripts/cordis-yaml.ts:37-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-yaml.ts#L37-L41)）
- `isCordisGroupEntry` 要求 `config` 是数组且 `group === true` 或 name 为 group 插件包名（[scripts/cordis-yaml.ts:48-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/cordis-yaml.ts#L48-L54)）

### scripts/coverage-exempt.ts

声明哪些重量级测试套件在覆盖率聚合里改走非插桩通道的常量模块，被 vitest 配置与覆盖率脚本导入。

- `COVERAGE_EXEMPT_ENV` 命名了让 vitest 配置从每个 project 里剔除这些套件的环境变量（[scripts/coverage-exempt.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-exempt.ts#L26)）
- `coverageExemptHeavySuites` 逐条给出被豁免套件的 CLI 过滤串与对应 exclude glob（[scripts/coverage-exempt.ts:29-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-exempt.ts#L29-L59)）

### scripts/coverage-partitions.ts

把 Vitest 覆盖率跑成多个单 worker 分片并最终合并成一份报告的协调器模块。

- 三个环境变量分别选择分片数、标记分片进程模式、覆盖测试超时（[scripts/coverage-partitions.ts:8-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L8-L14)）
- `parseCoveragePartitionCount` 要求分片数是大于 1 的整数且字符串形式无冗余，否则抛错（[scripts/coverage-partitions.ts:62-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L62-L69)）
- `coverageTestTimeoutArgs` 把超时值同时展开成 `--testTimeout` 与 `--expect.poll.timeout` 两个参数（[scripts/coverage-partitions.ts:72-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L72-L79)）
- `forwardedCoverageArgs` 剥掉 pnpm 的 `--` 分隔符再转发（[scripts/coverage-partitions.ts:82-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L82-L84)）
- 构造器拒绝小于 2 的分片数，并把临时目录固定在 `coverage/.partitioned`（[scripts/coverage-partitions.ts:97-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L97-L108)）
- `run` 先清空 coverage 目录再建 blobs 目录（[scripts/coverage-partitions.ts:115-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L115-L116)）
- 全部分片以 `Promise.all` 并发执行，失败者打印原因与截断的输出尾（[scripts/coverage-partitions.ts:119-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L119-L133)）
- 分片跑完先断言 blob 集合完整，再执行一次合并命令，任一环节失败则返回 1（[scripts/coverage-partitions.ts:134-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L134-L139)）
- `finally` 里无条件清掉临时目录（[scripts/coverage-partitions.ts:140-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L140-L142)）
- 每个分片命令固定带 `--coverage --maxWorkers=1 --shard=i/n` 与 blob reporter 及独立报告目录（[scripts/coverage-partitions.ts:146-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L146-L161)）
- 分片子进程中分片数变量被删除、分片模式变量被置 1（[scripts/coverage-partitions.ts:162-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L162-L171)）
- 合并命令用 `--merge-reports=<blobs> --coverage` 且把两个环境变量都清掉（[scripts/coverage-partitions.ts:174-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L174-L189)）
- `assertCompleteBlobSet` 比对目录实际产物与期望 blob 路径列表，不一致即抛错（[scripts/coverage-partitions.ts:196-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L196-L207)）
- `runCoverageCommand` 以 undefined 表示删除环境变量地拼出子进程环境（[scripts/coverage-partitions.ts:214-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L214-L218)）
- 子进程 stdout/stderr 边转写到父进程边累积成输出尾（[scripts/coverage-partitions.ts:219-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L219-L233)）
- spawn 错误与 close 各自 resolve 出一个结果对象而非抛出（[scripts/coverage-partitions.ts:234-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L234-L240)）
- 输出尾被截断保留最后 65536 个字符（[scripts/coverage-partitions.ts:243-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L243-L246)）
- 退出码非 0、收到信号或存在 spawn 错误三者任一即判为失败（[scripts/coverage-partitions.ts:248-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L248-L250)）
- `removeOwnedTree` 对不存在的路径静默返回，对符号链接或非目录用 unlink，目录才递归删除（[scripts/coverage-partitions.ts:261-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-partitions.ts#L261-L272)）

### scripts/coverage-uncovered-locations.cjs

一个 CommonJS 形式的 istanbul 报告器，按绝对路径接进 vitest 配置，打印每处未覆盖位置。

- 列号从 istanbul 的 0 基转成编辑器惯用的 1 基（[scripts/coverage-uncovered-locations.cjs:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L24-L26)）
- `usable` 要求位置带有限且不小于 1 的起始行，否则该条被丢弃（[scripts/coverage-uncovered-locations.cjs:28-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L28-L31)）
- `endSuffix` 在终点列为 Infinity 时降级成只带行号的后缀，起止相同则不加后缀（[scripts/coverage-uncovered-locations.cjs:38-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L38-L46)）
- 构造器从 reporter 选项取 `projectRoot`，缺省用 `process.cwd()`（[scripts/coverage-uncovered-locations.cjs:49-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L49-L54)）
- `onStart` 清空记录数组（[scripts/coverage-uncovered-locations.cjs:56-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L56-L58)）
- 文件路径被转成相对 projectRoot 并统一为 `/` 分隔（[scripts/coverage-uncovered-locations.cjs:61-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L61-L62)）
- 计数为 0 的语句逐条生成一行 `path:line:col uncovered statement` 记录（[scripts/coverage-uncovered-locations.cjs:66-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L66-L71)）
- 未覆盖函数优先取声明位置、否则取函数体位置，并在记录里带上函数名（[scripts/coverage-uncovered-locations.cjs:73-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L73-L80)）
- 未覆盖分支按每条路径单独成行，位置缺失时回落到分支自身跨度（[scripts/coverage-uncovered-locations.cjs:82-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L82-L93)）
- 同一文件的记录按行列排序后才追加到总表（[scripts/coverage-uncovered-locations.cjs:95-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L95-L98)）
- `onEnd` 在无记录时完全不输出，有记录时先打印条数再逐行打印（[scripts/coverage-uncovered-locations.cjs:100-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L100-L105)）
- 以 `module.exports` 导出类，供 istanbul-reports 的裸 require 加载（[scripts/coverage-uncovered-locations.cjs:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/coverage-uncovered-locations.cjs#L108)）

### scripts/demo-ptc.mjs

以 headless profile 跑一次任务的演示脚本，对应 `pnpm run demo:ptc`。

- 任务文本取 argv 拼接，为空时用固定的默认任务串（[scripts/demo-ptc.mjs:4-5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/demo-ptc.mjs#L4-L5)）
- 用当前 node 以 `--import tsx/esm` 启动 `apps/cli/src/bin.ts` 并传入 `--profile headless` 与任务（[scripts/demo-ptc.mjs:7-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/demo-ptc.mjs#L7-L14)）
- 子进程继承 stdio，并在环境中注入 `DSH_TOOLS_MODE=ptc`（[scripts/demo-ptc.mjs:14-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/demo-ptc.mjs#L14-L17)）
- 子进程退出时以其退出码结束，被信号终止则退出码取 1（[scripts/demo-ptc.mjs:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/demo-ptc.mjs#L18)）

### scripts/dev-web.ts

Web 开发循环的监视构建脚本，串起 tsc 类型发射、tsdown 打包与前端 dist 构建三级 watch，对应 `pnpm run dev:web`。

- `devWebBuildEnvironment` 用仓库实测的公开客户端环境构造出各监视阶段共享的进程环境（[scripts/dev-web.ts:63-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L63-L68)）
- `discoverPluginDirs` 按 package.json 里 `dsh.client.platform === 'web'` 声明筛出被监视的插件包（[scripts/dev-web.ts:78-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L78-L87)）
- `discoverLibraryDirs` 按 tsdown 配置是否引用 `tsdown.client.ts` 且清单不带 `dsh.client` 筛出静态链接库包，并跳过测试基础设施前缀（[scripts/dev-web.ts:101-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L101-L113)）
- `watchClientPlugins` 以 workspace 模式开 tsdown watch，并通过 `build:done` 钩子对每个 options 只记一次初次完成（[scripts/dev-web.ts:131-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L131-L149)）
- 给出 `pollInterval` 时把 tsdown 的源码监视切换成轮询（[scripts/dev-web.ts:146-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L146-L148)）
- 待全部 bundle 完成首轮构建后该函数才 resolve（[scripts/dev-web.ts:150-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L150-L153)）
- `spawnStage` 以继承 stdio 启动阶段进程并登记到 `stages` 供统一终止（[scripts/dev-web.ts:174-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L174-L181)）
- 任一阶段进程退出即打印诊断并让主进程 `process.exit(1)`（[scripts/dev-web.ts:182-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L182-L186)）
- 主流程先从 `process.env` 删掉 profile 选择器与全部 `DSH_CLIENT_*`，再写回解析出的公开值（[scripts/dev-web.ts:196-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L196-L204)）
- 插件集合或库集合为空时打印诊断并退出 1（[scripts/dev-web.ts:206-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L206-L215)）
- 除 `--poll[=ms]` 外的任何参数触发用法错误退出 1，非正整数间隔同样退出 1（[scripts/dev-web.ts:217-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L217-L227)）
- SIGINT 与 SIGTERM 各注册一次性处理器，遍历 `stages` 逐个 kill（[scripts/dev-web.ts:231-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L231-L233)）
- 第一阶段启动 `tsc -b <client 配置> --watch`，`--poll` 时改用 `fixedPollingInterval` 的文件与目录监视（[scripts/dev-web.ts:240-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L240-L245)）
- 第二阶段等 tsdown 全部首轮构建完成后，第三阶段才通过 `pnpm --filter <前端包> run watch` 启动 dist 构建（[scripts/dev-web.ts:251-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L251-L257)）
- 最后打印被监视的包数量、轮询间隔与完整目录清单（[scripts/dev-web.ts:259-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/dev-web.ts#L259-L265)）

### scripts/doc-typecheck-paths.ts

一个纯路径映射模块，把 tsconfig 里的工作区源码别名目标改写成对应的构建声明目标，被 `scripts/doc-typecheck.ts` 在构建协同模式下调用。

- `builtDeclarationPath` 把以 `/src` 结尾的整包别名目标改写为同包下的 `/lib/types`（[scripts/doc-typecheck-paths.ts:5-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck-paths.ts#L5-L7)）
- 把以 `/src/*` 结尾的通配目标改写为 `/lib/types/*`（[scripts/doc-typecheck-paths.ts:8-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck-paths.ts#L8-L10)）
- 把 `<pkg>/src/<name>.ts` 形式的单文件目标改写为 `<pkg>/lib/types/<name>.d.ts`（[scripts/doc-typecheck-paths.ts:11-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck-paths.ts#L11-L14)）
- 把 `<pkg>/src/<dir>` 形式的目录子路径目标改写为 `<pkg>/lib/types/<dir>`（[scripts/doc-typecheck-paths.ts:17-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck-paths.ts#L17-L20)）
- 四种形式都不匹配时抛出错误，终止调用方（[scripts/doc-typecheck-paths.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck-paths.ts#L21)）

### scripts/doc-typecheck.ts

一个可执行的仓库门禁脚本，抽取 Markdown 文档中的 TypeScript 代码围栏并编译它们，同时统计并限制 opt-out 比率。

- `KIND_BY_INFO` 把七种围栏 info 串映射到六种块类别，未列入的 info 串在抽取阶段被整体丢弃（[scripts/doc-typecheck.ts:36-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L36-L44)）
- `extractBlocks` 读取文件、按围栏切分，并把每块连同其所在文件与开栏行号记录下来（[scripts/doc-typecheck.ts:47-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L47-L53)）
- 解析配置宿主在遇到不可恢复的配置诊断时抛错（[scripts/doc-typecheck.ts:55-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L55-L61)）
- `builtTypeCompilerOptions` 解析 `tsconfig.host.json`，解析失败、有错误或缺少工作区 `paths` 时抛错（[scripts/doc-typecheck.ts:69-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L69-L76)）
- 把每个工作区 `paths` 候选逐个经 `builtDeclarationPath` 重定向到构建声明（[scripts/doc-typecheck.ts:77-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L77-L80)）
- 覆盖编译选项：关闭 emit、composite、incremental、声明与 sourcemap，关闭未使用局部/参数检查，并删除 `tsBuildInfoFile`（[scripts/doc-typecheck.ts:81-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L81-L94)）
- 把每个块写成内存中的 `.doc-typecheck/block-N.ts` 虚拟文件，并在缺尾换行时补一个（[scripts/doc-typecheck.ts:100-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L100-L104)）
- 自定义 CompilerHost 在 `fileExists`/`readFile`/`getSourceFile` 上优先返回内存源（[scripts/doc-typecheck.ts:106-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L106-L119)）
- `writeFile` 被调用即抛错（[scripts/doc-typecheck.ts:120-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L120-L122)）
- 用这些虚拟文件建程序并返回 pre-emit 诊断（[scripts/doc-typecheck.ts:124-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L124-L125)）
- `formatDiagnostics` 渲染诊断后再做块路径回映射（[scripts/doc-typecheck.ts:129-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L129-L136)）
- `workspaceReferences` 用 TypeScript 自带的 JSONC 读取器读 `tsconfig.host.json` 的 references，读失败抛错，并把每个路径前缀改写为上一级（[scripts/doc-typecheck.ts:143-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L143-L156)）
- `tempTsconfig` 生成临时工程配置：继承宿主配置、关闭未使用检查、指定 tsbuildinfo、只 include `block-*.ts`、注入改写后的 references（[scripts/doc-typecheck.ts:159-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L159-L170)）
- `compileBlocksStandalone` 在仓库根下建临时目录、写入 tsconfig 与块文件，`finally` 中递归删除该目录（[scripts/doc-typecheck.ts:174-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L174-L194)）
- 以 `process.execPath` 直接执行 `node_modules/typescript/bin/tsc -b`，失败时把子进程 stdout/stderr 拼接后回映射返回（[scripts/doc-typecheck.ts:181-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L181-L190)）
- `remapBlockPaths` 把诊断中的 `block-N.ts(行,列)` 换成源 Markdown 文件加围栏行与块内偏移（[scripts/doc-typecheck.ts:197-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L197-L203)）
- 固定的 glob 列表决定被扫描的 Markdown 集合，并逐个排除归档 agent 笔记路径，结果排序（[scripts/doc-typecheck.ts:205-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L205-L213)）
- 按「文件 + 类别与代码文本」把成对 Markdown 的派生块分离出去，只保留主块参与后续（[scripts/doc-typecheck.ts:215-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L215-L220)）
- 只有 `check` 块进入编译，`check` 与 `ignore` 之和作为 opt-out 比率分母，其余类别被排除（[scripts/doc-typecheck.ts:221-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L221-L225)）
- 无可编译块时打印一行并以 0 退出（[scripts/doc-typecheck.ts:227-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L227-L230)）
- 环境变量 `DSH_DOC_TYPECHECK_USE_BUILD_OUTPUT` 等于 `1` 时走构建声明编译路径，否则走临时工程 `tsc -b` 路径（[scripts/doc-typecheck.ts:232-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L232-L238)）
- 编译有错时把诊断打到 stderr 并以 1 退出（[scripts/doc-typecheck.ts:239-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L239-L243)）
- 打印编译数、忽略数、opt-out 百分比、他处校验数与派生块数（[scripts/doc-typecheck.ts:245-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L245-L247)）
- 分母不小于 4 且 opt-out 比率大于 0.5 时打印错误并以 1 退出（[scripts/doc-typecheck.ts:249-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/doc-typecheck.ts#L249-L252)）

### scripts/gen-client-catalog.ts

一个生成器兼门禁脚本，词法扫描工作区源码里的 slot 声明与注册，生成 `cordis_inspect what:"client"` 服务给模型的 slot 目录数据模块。

- `OUT` 常量把产物固定写到 `packages/extensions/cordis-client-runner/src/client/slot-catalog.ts`（[scripts/gen-client-catalog.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L29)）
- `SOURCE_GLOBS` 决定扫描哪些源文件，含 `.tsx`（[scripts/gen-client-catalog.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L32)）
- `KINDS` 与 `SCOPES` 限定合法的 slot 基数与作用域取值（[scripts/gen-client-catalog.ts:35-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L35-L37)）
- `MAX_DECL_CHARS` 决定声明文本超过 1200 字符即被截断（[scripts/gen-client-catalog.ts:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L39)）
- `MAX_ENTRY_LINES` 给单个 slot 的展开报告设 120 行上限（[scripts/gen-client-catalog.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L50)）
- `REGISTER_OPTIONS` 按基数决定目录里教给模型的每个 register 选项名、必选性、类型与说明文本（[scripts/gen-client-catalog.ts:69-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L69-L82)）
- `PRIORITY_NOTE` 与 `CLIENT_NOTES` 常量成为产物中模型读到的跨切面规则正文（[scripts/gen-client-catalog.ts:85-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L85-L95)）
- `SCOPE_KIT` 决定每个作用域在全局标准 props 之外额外并入哪个接口（[scripts/gen-client-catalog.ts:98-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L98-L102)）
- `collectSlotEntries` 扫描文件、汇总声明与注册、建立导出类型索引，并在有契约违规时抛错（[scripts/gen-client-catalog.ts:133-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L133-L140)）
- 解析出的条目若有任何超行数预算者则抛错（[scripts/gen-client-catalog.ts:141-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L141-L147)）
- `oversizedSlotReports` 筛出超预算条目并给出整改文案（[scripts/gen-client-catalog.ts:156-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L156-L162)）
- `entryLines` 用文档、示例、owner props、选项说明的行数加上若干列表长度算出报告规模（[scripts/gen-client-catalog.ts:165-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L165-L169)）
- `validateSlotContracts` 把重复声明的 key 判为违规并跳过后续检查（[scripts/gen-client-catalog.ts:187-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L187-L194)）
- kind 或 scope 不是字面量合法值时判为违规（[scripts/gen-client-catalog.ts:195-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L195-L200)）
- 声明没有 JSDoc 正文时判为违规（[scripts/gen-client-catalog.ts:201-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L201-L203)）
- owner props 类型名未被任何导出声明提供时判为违规（[scripts/gen-client-catalog.ts:204-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L204-L208)）
- 注册到未声明的 key、或声明了未被任何 SlotMap 定义的子 slot，都判为违规（[scripts/gen-client-catalog.ts:210-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L210-L219)）
- `resolveSlotEntries` 用注册点声明的 children 建立「哪个注册使该 slot 存在」的映射，并按 key 排序输出（[scripts/gen-client-catalog.ts:240-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L240-L249)）
- `standardKits` 把全局标准 props 与作用域专属接口成员合并成每个作用域的框架 props 列表（[scripts/gen-client-catalog.ts:252-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L252-L260)）
- `entryOf` 由同 key 注册点算出占位者列表与「格位已被占」判定（[scripts/gen-client-catalog.ts:270-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L270-L272)）
- 条目的 summary 取文档首句、registerOptions 按 kind 取表、standardProps 按 scope 取 kit（[scripts/gen-client-catalog.ts:276-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L276-L284)）
- `declaredBy` 依有无宿主注册渲染成「运行时自带」或「某注册挂载时才存在」两种文案（[scripts/gen-client-catalog.ts:288-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L288-L290)）
- 占位者行拼接包名、组件名、id 与 key（[scripts/gen-client-catalog.ts:291-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L291-L296)）
- `replaceRisk` 在 single/keyed 且格位已被占时标为 `shadows-shipped-ui`，否则为 `none`（[scripts/gen-client-catalog.ts:297-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L297-L299)）
- `ownerShapes` 只展开一层引用类型，把再下一层仅记为名字（[scripts/gen-client-catalog.ts:312-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L312-L322)）
- `keyDomainOf` 对 keyed slot 生成键域说明，区分「开放键集」与「宿主键表固定」并列出已占用键（[scripts/gen-client-catalog.ts:325-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L325-L332)）
- `exampleOf` 为每个 slot 生成一段可运行的最小注册示例代码（[scripts/gen-client-catalog.ts:335-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L335-L348)）
- `KIND_EXAMPLE` 决定每种基数在示例里附带哪些额外选项（[scripts/gen-client-catalog.ts:351-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L351-L356)）
- `shortPackage` 去掉包名前缀（[scripts/gen-client-catalog.ts:359-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L359-L361)）
- `truncate` 对超长声明截断并追加「已截断」标记（[scripts/gen-client-catalog.ts:364-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L364-L368)）
- `docProse` 剥掉注释标记、在首个块标签行处截断、展开 `{@link}` 并压缩空行（[scripts/gen-client-catalog.ts:371-380](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L371-L380)）
- `firstSentence` 压平空白后取首个句末标点前的内容（[scripts/gen-client-catalog.ts:383-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L383-L387)）
- `quote` 转义反斜杠、单引号与换行后输出单引号字面量（[scripts/gen-client-catalog.ts:390-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L390-L392)）
- `renderClientCatalog` 输出带生成横幅、两个导出接口、`CLIENT_NOTES` 与 `CLIENT_SLOT_API` 的数据模块（[scripts/gen-client-catalog.ts:405-488](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L405-L488)）
- 产物用 `jscpd:ignore-start` / `jscpd:ignore-end` 把条目数据排除在克隆检测之外（[scripts/gen-client-catalog.ts:422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L422)）
- 逐条目渲染全部字段，空选项列表渲染为 `[]`（[scripts/gen-client-catalog.ts:489-523](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L489-L523)）
- `main` 在 `--check` 下比对已提交产物，一致则打印并以 0 退出，不一致或读不到则打印整改命令并以 1 退出（[scripts/gen-client-catalog.ts:534-549](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L534-L549)）
- 非 `--check` 时建目录并写出产物（[scripts/gen-client-catalog.ts:550-552](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L550-L552)）
- 只有当本文件是进程入口时才调用 `main`（[scripts/gen-client-catalog.ts:555-557](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-client-catalog.ts#L555-L557)）

### scripts/gen-config-catalog.ts

一个生成器兼门禁脚本，从每个包的入口文件、config 类型、JSDoc 与静态 Schemastery schema 生成 `docs/config-catalog.md`。

- `OUT` 常量把产物固定写到 `docs/config-catalog.md`（[scripts/gen-config-catalog.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L18)）
- `FENCE` 决定生成文档中声明块使用的围栏 info 串（[scripts/gen-config-catalog.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L23)）
- `GLOBAL_TYPES` 白名单决定哪些类型名不被当作未解析引用而直接跳过（[scripts/gen-config-catalog.ts:29-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L29-L33)）
- `report` 把收集到的全部违规聚合成一个错误抛出（[scripts/gen-config-catalog.ts:94-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L94-L100)）
- `loadFile` 解析源文件并把默认导入、具名导入（含别名）、命名空间导入索引成本地名到来源的映射，结果按绝对路径缓存（[scripts/gen-config-catalog.ts:103-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L103-L127)）
- `resolveTypeName` 对包内相对导入缺 `.ts` 后缀判违规（[scripts/gen-config-catalog.ts:156-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L156-L159)）
- 包内相对导入使用别名时判违规（[scripts/gen-config-catalog.ts:160-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L160-L163)）
- 包内相对导入被递归跟随到声明处，跨包导入则记为待链接的外部引用（[scripts/gen-config-catalog.ts:164-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L164-L170)）
- `collectTypeNames` 递归收集类型引用位置的名字与 heritage 子句的名字（[scripts/gen-config-catalog.ts:174-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L174-L186)）
- `pasteText` 取从前导 JSDoc 起到声明结束的原文，作为文档里的逐字粘贴（[scripts/gen-config-catalog.ts:189-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L189-L193)）
- `checkMemberDocs` 递归进入嵌套类型字面量，对每个属性签名要求非空 JSDoc 正文（[scripts/gen-config-catalog.ts:197-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L197-L213)）
- `parsePath` 把 `agents[].id` 形式的 schema 键路径拆成成员步与数组步（[scripts/gen-config-catalog.ts:232-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L232-L245)）
- `findExportedTypeDecl` 跟随 `export … from './x.ts'` 与 `export * from './x.ts'` 链查找声明，并用 seen 集防环（[scripts/gen-config-catalog.ts:256-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L256-L278)）
- `declForTypeName` 依次尝试本地声明、包内相对导入、工作区包入口的再导出链，都不成则返回 `'unknown'`（[scripts/gen-config-catalog.ts:283-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L283-L304)）
- `lookupPath` 对具名声明用「文件+位置+剩余步数」作 key 防止递归类型死循环，命中即返回 `'unknown'`（[scripts/gen-config-catalog.ts:322-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L322-L326)）
- 分支结果合并规则为「有 found 即 found，否则有 unknown 即 unknown，否则 missing」（[scripts/gen-config-catalog.ts:330-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L330-L334)）
- 接口按自身成员查找，未命中则合并各 heritage 基类的查找结果（[scripts/gen-config-catalog.ts:344-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L344-L360)）
- 类型别名、括号类型、类型操作符透传下钻，交叉类型按合并规则处理（[scripts/gen-config-catalog.ts:361-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L361-L369)）
- 联合类型只有全分支一致才给出确定结论，否则为 `'unknown'`（[scripts/gen-config-catalog.ts:370-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L370-L376)）
- 数组类型只在当前步是数组步时消耗一步下钻（[scripts/gen-config-catalog.ts:377-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L377-L379)）
- 字符串字面量索引访问被改写成一次成员步再继续（[scripts/gen-config-catalog.ts:381-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L381-L387)）
- `PASSTHROUGH_WRAPPERS` 列出把成员查找原样透传给类型参数的工具类型（[scripts/gen-config-catalog.ts:307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L307)）
- 类型引用先按透传工具类型下钻、按 `Array`/`ReadonlyArray` 消耗数组步，命名空间限定名与解析不到的名字返回 `'unknown'`，其余情况也一律兜底为 `'unknown'`（[scripts/gen-config-catalog.ts:388-402](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L388-L402)）
- `unwrapExpr` 剥掉 `as`、`satisfies` 与括号包装（[scripts/gen-config-catalog.ts:406-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L406-L410)）
- `walkSchemaExpr` 的 `collectValuePaths` 对属性值递归下钻 `object`、给 `array` 追加 `[]`、并沿链式调用向基调用回溯（[scripts/gen-config-catalog.ts:432-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L432-L451)）
- 顶层表达式若不是可静态走查的 schemastery 调用则判违规（[scripts/gen-config-catalog.ts:452-457](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L452-L457)）
- `object` 收集顶层键并递归取嵌套路径，非普通键的属性判违规（[scripts/gen-config-catalog.ts:459-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L459-L470)）
- `intersect` 把 `X.Config` 元素记为被组合的工作区包名、内联调用继续走查，其余判违规（[scripts/gen-config-catalog.ts:471-482](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L471-L482)）
- `union` 逐个分支按同样方式走查（[scripts/gen-config-catalog.ts:485-491](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L485-L491)）
- 链式细化调用向基调用解包，解不到可走查基调用时判违规（[scripts/gen-config-catalog.ts:494-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L494-L496)）
- `findSchemaExpr` 先找入口文件导出的 `const Config`，否则找插件类上的 `static Config`（[scripts/gen-config-catalog.ts:504-518](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L504-L518)）
- `findInject` 先找入口的 `inject` 变量、否则类上的 `inject` 属性，非纯字符串数组字面量判违规（[scripts/gen-config-catalog.ts:522-544](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L522-L544)）
- `defaultExport` 把 `export default <标识符>` 与直接带 default 修饰的类/函数解析成声明（[scripts/gen-config-catalog.ts:548-561](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L548-L561)）
- `applyExport` 找入口导出的 `apply` 函数声明（[scripts/gen-config-catalog.ts:564-570](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L564-L570)）
- 预扫描全部 `packages/*/*/package.json` 建包名到目录的映射；缺 `name` 判违规；同时声明 `os` 与 `cpu` 的平台原生包整包跳过（[scripts/gen-config-catalog.ts:584-601](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L584-L601)）
- 入口 `src/index.ts` 读不到时判违规并跳过该包（[scripts/gen-config-catalog.ts:605-614](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L605-L614)）
- 分类规则：抽象默认类为 seam，具体类看构造第二参、函数默认导出看第二参、导出 `apply` 看第二参决定 config 或 no-config，都没有则为 library（[scripts/gen-config-catalog.ts:619-643](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L619-L643)）
- 只有非 library、非 seam 的包才读取 `inject` 列表（[scripts/gen-config-catalog.ts:645-654](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L645-L654)）
- config 参数类型不是普通类型名引用时判违规并跳过（[scripts/gen-config-catalog.ts:657-660](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L657-L660)）
- 用队列做广度优先遍历，把 config 类型的包内传递闭包逐个粘贴，并对未解析名字判违规（[scripts/gen-config-catalog.ts:663-676](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L663-L676)）
- config 类型本身来自跨包导入时判违规（[scripts/gen-config-catalog.ts:678-682](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L678-L682)）
- 同名既是包内声明又是导入、或来自两个不同来源、或解析到两处不同声明，都判违规（[scripts/gen-config-catalog.ts:683-705](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L683-L705)）
- 每粘贴一个声明就检查其成员 JSDoc，并把它引用的非全局类型名压入队列（[scripts/gen-config-catalog.ts:706-717](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L706-L717)）
- 有运行期 schema 时记录其键路径与被组合的包名，没有则记 `null`（[scripts/gen-config-catalog.ts:720-727](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L720-L727)）
- 递归折叠被 `intersect` 组合的包的键路径，组合目标不在工作区内时判违规（[scripts/gen-config-catalog.ts:732-750](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L732-L750)）
- 定位不到主 config 声明时判违规并跳过该包的路径检查（[scripts/gen-config-catalog.ts:751-758](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L751-L758)）
- 逐条 schema 键路径在声明类型上做存在性检查，只有确定 `missing` 才判违规（[scripts/gen-config-catalog.ts:759-763](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L759-L763)）
- 走查结束统一抛出违规，通过则按包名排序返回条目（[scripts/gen-config-catalog.ts:766-767](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L766-L767)）
- `requiresLine` 在有 inject 时渲染服务键行（[scripts/gen-config-catalog.ts:771-773](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L771-L773)）
- `refLink` 按「另一个插件的 config 类型 → 本页锚点、`LINK_MAP` 命中 → subsystems 页、其他工作区类型 → 源文件、外部类型 → 不加链接」四档渲染引用（[scripts/gen-config-catalog.ts:778-787](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L778-L787)）
- `renderConfigEntry` 输出锚点、标题、Requires 行、逐字声明围栏、Depends on 行与 Source 行（[scripts/gen-config-catalog.ts:790-801](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L790-L801)）
- `renderTerse` 输出一行式条目并附带 inject 说明与入口链接（[scripts/gen-config-catalog.ts:804-807](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L804-L807)）
- `render` 拼出完整 Markdown：生成横幅、说明性前言、config 条目区，以及 no-config、seam、library 三个清单区（[scripts/gen-config-catalog.ts:810-848](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L810-L848)）
- `main` 在 `--check` 下比对已提交文件，一致以 0 退出，不一致或读不到则打印整改命令并以 1 退出（[scripts/gen-config-catalog.ts:854-872](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L854-L872)）
- 非 `--check` 时写出产物（[scripts/gen-config-catalog.ts:873-874](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L873-L874)）
- 只有当本文件是进程入口时才调用 `main`（[scripts/gen-config-catalog.ts:877-879](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-config-catalog.ts#L877-L879)）

### scripts/gen-cordis-api.ts

一个兼容入口脚本，被保留在生成产物的横幅命令里，实际转调统一的目录生成实现。

- 导入并立即调用 `gen-cordis-catalog.ts` 的 `main`，使运行本文件等同于运行该生成器（[scripts/gen-cordis-api.ts:7-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-api.ts#L7-L9)）

### scripts/gen-cordis-catalog.ts

一个生成器兼门禁脚本，把 Typert 目录投影渲染成各 subsystems 页的服务/事件参考区块、继承层页面与模型可见的运行期 API 模块，并持有一整套人工维护的归属与豁免表。

- `SUBSYSTEMS_DIR`、`OUT_INHERITED`、`OUT_RUNTIME_API` 决定三类产物的写入位置（[scripts/gen-cordis-catalog.ts:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L44-L46)）
- `SERVICE_PAGE` 把每个 `ctx.<key>` 服务映射到唯一一个 subsystems 页，决定该服务渲染到哪张页上（[scripts/gen-cordis-catalog.ts:56-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L56-L126)）
- `SERVICE_WALK_EXEMPTIONS` 逐条命名投影看不见但确有 Context 合并声明的键及其文档归属（[scripts/gen-cordis-catalog.ts:146-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L146-L176)）
- `EVENT_SCOPE_PAGE` 把每个事件 scope 映射到唯一一个 subsystems 页（[scripts/gen-cordis-catalog.ts:185-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L185-L209)）
- `EVENT_WALK_EXEMPTIONS` 按完整事件名逐条命名投影看不见的事件及其文档归属（[scripts/gen-cordis-catalog.ts:221-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L221-L231)）
- `LINK_MAP` 决定生成签名中每个类型名链接到哪张 subsystems 页（[scripts/gen-cordis-catalog.ts:239-626](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L239-L626)）
- `FOUNDATION_TYPE_NAMES` 把语言内置与固定框架类型排除在链接覆盖要求之外（[scripts/gen-cordis-catalog.ts:629-646](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L629-L646)）
- `TYPE_LINK_EXEMPTIONS` 逐条给出在目录外单独归档的类型名与其归属（[scripts/gen-cordis-catalog.ts:649-725](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L649-L725)）
- `runtimeServiceExclusions` 把两个服务键排除出模型可见的运行期 API（[scripts/gen-cordis-catalog.ts:732](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L732)）
- `runtimeServices` 手写注入 `timer` 服务及其六个方法签名与 JSDoc（[scripts/gen-cordis-catalog.ts:733-765](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L733-L765)）
- `inheritedEvents` 手写继承层事件清单及其源码位置（[scripts/gen-cordis-catalog.ts:766-782](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L766-L782)）
- `inheritedServices` 手写继承层上下文 API 清单及其源码位置（[scripts/gen-cordis-catalog.ts:783-794](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L783-L794)）
- `spliceRegion` 要求页面恰好有一对 BEGIN/END 标记，数量不符即抛错（[scripts/gen-cordis-catalog.ts:811-816](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L811-L816)）
- END 标记在 BEGIN 之前时抛错，否则用新区块整体替换标记之间的内容（[scripts/gen-cordis-catalog.ts:817-820](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L817-L820)）
- `localizePageRegion` 对 `.zh.md` 页读取配对清单，把区块内指向成对文档的链接改写到对应语言（[scripts/gen-cordis-catalog.ts:846-856](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L846-L856)）
- `walkPartitionProblems` 对已渲染但未映射到页的服务键与事件 scope 判违规（[scripts/gen-cordis-catalog.ts:873-878](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L873-L878)）
- 对已在映射表中但投影不再发现的服务键与 scope 判违规（[scripts/gen-cordis-catalog.ts:879-884](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L879-L884)）
- 对独立扫描到但既不渲染也无豁免的 Context 键判违规，已渲染却仍列豁免同样判违规（[scripts/gen-cordis-catalog.ts:889-899](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L889-L899)）
- 对事件做同一组三方向检查：无豁免的不可见事件、已渲染却仍豁免、无声明的陈旧豁免（[scripts/gen-cordis-catalog.ts:903-913](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L903-L913)）
- 反向自检：渲染出来但独立扫描找不到声明的键或事件被判为扫描本身有盲点（[scripts/gen-cordis-catalog.ts:919-924](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L919-L924)）
- `computeOutputs` 跑目录投影，并对全部包源码独立扫描 Context 合并键与 Events 合并名，各记首个声明文件（[scripts/gen-cordis-catalog.ts:939-952](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L939-L952)）
- 分区检查有违规即聚合抛错，阻止任何产物计算（[scripts/gen-cordis-catalog.ts:953-965](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L953-L965)）
- 产物集合为继承层页加运行期 API 模块，再按页把服务与事件过滤后渲染成区块（[scripts/gen-cordis-catalog.ts:967-978](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L967-L978)）
- 每张页按英文与 `.zh.md` 两侧分别本地化并注入，页面不存在或标记异常都记违规并在最后聚合抛错（[scripts/gen-cordis-catalog.ts:979-999](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L979-L999)）
- `maybeRecordPair` 在没有既有 `.i18n.yaml` 记录时不做任何重记录（[scripts/gen-cordis-catalog.ts:1017-1025](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L1017-L1025)）
- 记录条目数或键名不是该对的两侧时不重记录（[scripts/gen-cordis-catalog.ts:1029-1031](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L1029-L1031)）
- 只有两侧写前哈希与记录一致、且剥掉生成区块后的内容逐字节不变时，才重写 `.i18n.yaml` 的哈希（[scripts/gen-cordis-catalog.ts:1032-1044](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L1032-L1044)）
- `main` 把核心 API 页的产物并入总产物集合（[scripts/gen-cordis-catalog.ts:1052-1056](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L1052-L1056)）
- `--check` 下逐个产物比对已提交内容，全新鲜则打印并以 0 退出，否则列出陈旧文件并以 1 退出（[scripts/gen-cordis-catalog.ts:1057-1077](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L1057-L1077)）
- 写盘前先读取全部产物旧字节，内容未变的产物跳过写入（[scripts/gen-cordis-catalog.ts:1079-1095](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L1079-L1095)）
- 对每张映射页，只有两侧中确有一侧被改写时才尝试重记录配对（[scripts/gen-cordis-catalog.ts:1096-1104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L1096-L1104)）
- 打印计算数、写入数与重记录数（[scripts/gen-cordis-catalog.ts:1105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L1105)）
- 只有当本文件是进程入口时才调用 `main`（[scripts/gen-cordis-catalog.ts:1108-1110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-catalog.ts#L1108-L1110)）

### scripts/gen-cordis-inspect-catalog.ts

一个生成器兼门禁脚本，以 client 面跑同一份目录投影，生成模型可见的浏览器侧 Service/Event inspect 目录模块。

- `CLIENT_OUT` 决定产物写到 `packages/extensions/cordis-client-runner/src/client/api-catalog.ts`（[scripts/gen-cordis-inspect-catalog.ts:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L10)）
- `CLIENT_SERVICES` 白名单逐服务列出模型可见的方法名，未列入的方法不进入产物（[scripts/gen-cordis-inspect-catalog.ts:12-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L12-L23)）
- `CLIENT_EVENTS` 白名单决定模型可见的四个 client 事件（[scripts/gen-cordis-inspect-catalog.ts:25-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L25-L30)）
- `methodName` 从签名文本里剥掉 `declare`/`readonly`/`async` 前缀取出方法名（[scripts/gen-cordis-inspect-catalog.ts:32-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L32-L34)）
- 白名单里的服务键在投影中命中数不等于一时抛错（[scripts/gen-cordis-inspect-catalog.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L37-L42)）
- 按名单过滤方法，任一白名单方法在投影里缺失即抛错（[scripts/gen-cordis-inspect-catalog.ts:43-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L43-L54)）
- 白名单里的事件名在投影中命中数不等于一时抛错（[scripts/gen-cordis-inspect-catalog.ts:55-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L55-L61)）
- `main` 以 `'client'` 面跑目录投影并渲染运行期 API 源码（[scripts/gen-cordis-inspect-catalog.ts:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L69-L71)）
- 把渲染结果里的生成器名、两个 pnpm 命令名与模块路径逐字替换成 client 侧的对应值（[scripts/gen-cordis-inspect-catalog.ts:72-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L72-L75)）
- `--check` 下产物不存在或与渲染结果不一致即抛错，一致则打印并返回（[scripts/gen-cordis-inspect-catalog.ts:76-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L76-L82)）
- 非 `--check` 时建目录并写出产物（[scripts/gen-cordis-inspect-catalog.ts:83-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L83-L85)）
- 模块顶层无条件调用 `main`，导入即执行（[scripts/gen-cordis-inspect-catalog.ts:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-cordis-inspect-catalog.ts#L88)）

### scripts/gen-doc-graphs.ts

`pnpm run gen-doc-graphs` / `verify-doc-graphs` 的实现：从包清单、TypeScript Program 和内置数据表渲染 `docs/graph-atlas.md`、`docs/capability-seams.md`、`docs/event-producer-consumer.md`、`docs/agent-lifecycle.md`、`docs/tool-execution-pipeline.md` 和 `apps/cli/composition.md`，`--check` 时只比对不写盘。

- `GROUP_ORDER` 常量固定包分组在生成图里的排列顺序（[scripts/gen-doc-graphs.ts:63-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L63-L98)）
- `SERVICE_ROLES` 表逐条声明每个 ctx 服务键的归属包、模式、实现包、消费包、伴生包与说明文字，是能力接缝页的全部内容来源（[scripts/gen-doc-graphs.ts:100-667](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L100-L667)）
- `generatedHeader` 在每份产物开头写入“由脚本生成、勿手改”的注释与标题（[scripts/gen-doc-graphs.ts:669-677](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L669-L677)）
- `maintenanceFooter` 在每份产物末尾写入该页的维护模式声明（[scripts/gen-doc-graphs.ts:679-681](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L679-L681)）
- `graphIndexLink` 与 `linkFromDoc` 按产物所在目录计算相对链接并把路径分隔符统一为 `/`（[scripts/gen-doc-graphs.ts:683-689](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L683-L689)）
- `mermaidCode` 把嵌入 Mermaid 文本的事件名转义 `&`、`<`、`>` 后包进 `<code>`（[scripts/gen-doc-graphs.ts:691-693](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L691-L693)）
- `pkgLink`／`pkgList` 把包短名解析成指向包目录的链接，未知短名退化为行内代码（[scripts/gen-doc-graphs.ts:703-710](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L703-L710)）
- `tableCell` 转义单元格内的 `|` 并把换行替换成 `<br>`（[scripts/gen-doc-graphs.ts:712-714](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L712-L714)）
- `assertServiceRolesComplete` 比对源码发现的服务键与 `SERVICE_ROLES` 分类，缺失或残留任一方即抛错终止生成（[scripts/gen-doc-graphs.ts:716-727](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L716-L727)）
- `renderCapabilitySeams` 按角色表建节点去重集、`owner --> svc`、`impl --> svc`、`svc --> consumer` 边集与伴生包虚线边，并把边排序后与表格一起输出（[scripts/gen-doc-graphs.ts:729-773](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L729-L773)）
- `parseExampleCordis` 逐行正则扫描 cordis 配置，把 `- id:` 行与其后的 `name:` 行配成插件条目（[scripts/gen-doc-graphs.ts:775-795](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L775-L795)）
- `stripYamlScalar` 去掉解析出的标量两端引号（[scripts/gen-doc-graphs.ts:797-799](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L797-L799)）
- `APP_EXAMPLES` 指定被解析的组合配置文件路径与产物落点（[scripts/gen-doc-graphs.ts:801-810](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L801-L810)）
- `renderAppComposition` 把解析出的插件行渲染成 `cfg --> plugin` 流程图和 id/模块表，并附源配置链接（[scripts/gen-doc-graphs.ts:814-841](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L814-L841)）
- `EVENT_API_METHODS` 限定只对 `on`/`once`/`emit`/`parallel`/`serial`/`waterfall`/`dispatch` 这些方法名做接收者类型判定（[scripts/gen-doc-graphs.ts:851](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L851)）
- `EventRelationCollector` 构造时解析 `Context`、`AgentEventDispatch`、`EventsService` 三个类型并记录待扫描的包源文件集（[scripts/gen-doc-graphs.ts:873-881](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L873-L881)）
- `declaredType` 解析不到指定类型时抛错（[scripts/gen-doc-graphs.ts:890-898](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L890-L898)）
- `buildCallSiteIndex` 按已解析签名声明为键索引调用点（[scripts/gen-doc-graphs.ts:901-916](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L901-L916)）
- `callSitesFor` 对可证明的文件内局部函数只索引其所在文件，否则一次性建全包索引并此后一直用它（[scripts/gen-doc-graphs.ts:926-938](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L926-L938)）
- `provenLocalCallee` 对导出函数或非模块文件直接判否，并在同文件内发现任一非调用位置的同名引用时判否，结果带缓存（[scripts/gen-doc-graphs.ts:949-982](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L949-L982)）
- `visitSource` 把 `emitAgentEvent(..., ..., event)` 的第三参记为派发者，把 `EventsService.dispatch` 的第二参数组解出的事件名记为 `events.dispatch` 派发，把 Context/agent-dispatch 接收者上的 `on`/`once` 记为监听、`emit`/`parallel`/`serial`/`waterfall` 记为派发（[scripts/gen-doc-graphs.ts:985-1018](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L985-L1018)）
- `isAgentEventEmitter` 通过符号别名解析加声明文件路径识别 `emitAgentEvent`（[scripts/gen-doc-graphs.ts:1021-1034](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1021-L1034)）
- `receiverKind` 用类型可赋值性把接收者分为 events-service / context / agent-dispatch，`any`、`unknown`、`never` 一律不归类（[scripts/gen-doc-graphs.ts:1037-1044](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1037-L1044)）
- `eventNamesFromCall` 对 Context 接收者取前两个实参、对 agent-dispatch 取第一个实参作为事件名候选（[scripts/gen-doc-graphs.ts:1047-1054](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1047-L1054)）
- `eventNamesFromArgumentList` 递归穿过数组字面量前两元素、三元表达式两分支、const 变量初始化和形参，并用 seen 集合防环（[scripts/gen-doc-graphs.ts:1057-1089](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1057-L1089)）
- `eventNamesFromParameter` 只对非导出的函数声明形参回溯到全部调用点的对应实参（[scripts/gen-doc-graphs.ts:1092-1103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1092-L1103)）
- `finiteStringValues` 只接受字符串字面量或封闭字面量联合类型，宽化字符串返回 undefined（[scripts/gen-doc-graphs.ts:1106-1111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1106-L1111)）
- `isForwardedAgentEventParameter` 排除 `AgentEventDispatch` 转发对象方法里那个上下文形参（[scripts/gen-doc-graphs.ts:1114-1125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1114-L1125)）
- `ensure` 与 `addDispatcher` 按事件名累积包到方法名集合的映射与监听包集合（[scripts/gen-doc-graphs.ts:1128-1142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1128-L1142)）
- `isDirectCallee` 与 `unwrapExpression` 穿过括号、`as`、类型断言、非空断言、`satisfies` 这些不改变运行值的包裹（[scripts/gen-doc-graphs.ts:1146-1173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1146-L1173)）
- `finiteStringTypeValues` 递归展开联合类型，遇到任一非字面量成员即整体放弃（[scripts/gen-doc-graphs.ts:1176-1189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1176-L1189)）
- `hasExportModifier` 以 `export`/`default` 修饰符判定声明是否跨模块可见（[scripts/gen-doc-graphs.ts:1197-1201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1197-L1201)）
- `collectPackageSources` 只挑 `packages/<group>/<pkg>/src/**.ts` 文件并按相对路径排序（[scripts/gen-doc-graphs.ts:1220-1226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1220-L1226)）
- `collectEventRelations` 新建一个仓库 TypeScript Program 并跑完整轮关系收集（[scripts/gen-doc-graphs.ts:1228-1231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1228-L1231)）
- `renderEventRelations` 按事件名排序输出事件、模式、声明处、派发者（含方法名）、监听者五列表格（[scripts/gen-doc-graphs.ts:1246-1260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1246-L1260)）
- 任一非 `packages/client/` 声明的事件没有任何派发者时抛错终止生成（[scripts/gen-doc-graphs.ts:1267-1278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1267-L1278)）
- 扫到的、未在 Cordis 目录中声明的事件字符串另起一节单独列表（[scripts/gen-doc-graphs.ts:1279-1288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1279-L1288)）
- `renderLifecycle` 固定输出一份从 `followup` 到 `turn/end` 的时序图，含 pre-step 拒绝分支、请求失败分支、工具批次循环和 `agent/status` 收尾（[scripts/gen-doc-graphs.ts:1293-1375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1293-L1375)）
- `renderToolPipeline` 固定输出工具执行流程图，含 pre-execute 瀑布、单调守卫、approval 分支、execute 环绕、fs 意图门、post-execute、归一化、`finalizeContent` 与 `tools/result` 的连边（[scripts/gen-doc-graphs.ts:1377-1439](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1377-L1439)）
- `renderDocs` 收齐五份产物后把索引页插到最前，索引因此包含全部条目（[scripts/gen-doc-graphs.ts:1441-1453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1441-L1453)）
- `renderIndex` 按标签与模式映射渲染图谱索引表，并额外列出模块图与工具目录两份外部产物（[scripts/gen-doc-graphs.ts:1455-1493](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1455-L1493)）
- `main` 在 `--check` 下逐份比对committed内容、有陈旧项就打印清单并 `process.exit(1)`，否则 mkdir 后逐份写盘（[scripts/gen-doc-graphs.ts:1495-1517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1495-L1517)）
- 入口守卫只在本文件被当作进程入口时才执行 `main`（[scripts/gen-doc-graphs.ts:1519-1521](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-doc-graphs.ts#L1519-L1521)）

### scripts/gen-module-graph.ts

`pnpm run gen-module-graph` / `verify-module-graph` 的实现：从各工作区包的 `peerDependencies` 生成 `docs/module-graph.md` 的 Mermaid 图与依赖表。

- `OUT` 常量固定产物落点为 `docs/module-graph.md`（[scripts/gen-module-graph.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L17)）
- `GROUP_ORDER` 常量固定分组子图的排列顺序（[scripts/gen-module-graph.ts:20-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L20-L43)）
- `render` 把每个包的依赖展开成 `a --> b` 边（[scripts/gen-module-graph.ts:51-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L51-L54)）
- 分组排序先按 `GROUP_ORDER` 下标、未列入的排到最后并按字典序兜底（[scripts/gen-module-graph.ts:56-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L56-L62)）
- 每个分组渲染成 `subgraph`，组内包按短名字典序排列（[scripts/gen-module-graph.ts:63-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L63-L70)）
- 依赖表把已知短名渲染成指向包目录的链接、未知的渲染成行内代码、无依赖渲染为破折号（[scripts/gen-module-graph.ts:71-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L71-L77)）
- 产物开头写入“由脚本生成、勿手改”注释，正文由 Mermaid 块与依赖表拼成（[scripts/gen-module-graph.ts:78-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L78-L96)）
- 模块顶层直接调用 `collectPackageGraph` 并渲染内容，导入即执行（[scripts/gen-module-graph.ts:99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L99)）
- `--check` 下读不到或内容不一致即打印陈旧提示并 `process.exit(1)`，一致则 `process.exit(0)`（[scripts/gen-module-graph.ts:101-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L101-L116)）
- 非 `--check` 时把渲染结果写入 `docs/module-graph.md`（[scripts/gen-module-graph.ts:118-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-module-graph.ts#L118-L119)）

### scripts/gen-persistence-catalog.ts

`pnpm run gen-persistence-catalog` / `verify-persistence-catalog` 的实现：扫描全部 `SessionEventMap` 声明合并与事件信封类型，生成 `docs/persistence-catalog.md` 和运行期使用的 `packages/core/session/src/known-event-types.ts`。

- 两个 `OUT` 常量固定文档产物与运行期已知事件类型模块的落点（[scripts/gen-persistence-catalog.ts:16-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L16-L17)）
- `FENCE` 给生成的声明块打上专用 info string，使其被 doc-typecheck 跳过（[scripts/gen-persistence-catalog.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L21)）
- `SESSION_PACKAGE` 与 `SESSION_TYPES_MODULE` 固定顶层声明的归属包与声明合并所用的模块名（[scripts/gen-persistence-catalog.ts:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L24-L27)）
- `EVENT_ENVELOPE_TYPE_NAMES` 固定必须被收集并原样粘入产物的四个信封类型名（[scripts/gen-persistence-catalog.ts:30-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L30-L35)）
- `LINK_MAP` 把 payload 里出现的类型名映射到文档页，决定条目下的 “Types:” 交叉链接（[scripts/gen-persistence-catalog.ts:40-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L40-L60)）
- `payloadText` 用 TypeScript printer 去注释打印类型、压平空白并去掉闭合括号前的分号（[scripts/gen-persistence-catalog.ts:101-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L101-L106)）
- `declarationText` 从 JSDoc 起始位置截到声明结束，并只剥掉容器施加的缩进（[scripts/gen-persistence-catalog.ts:112-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L112-L124)）
- `sessionEventMapDecls` 同时收集顶层 `interface SessionEventMap` 与 `declare module '@deepseek-ai/dsh-session/types'` 内的声明合并，并标记哪种形式（[scripts/gen-persistence-catalog.ts:135-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L135-L147)）
- `packageNameFor` 从路径前三段的 `package.json` 读取包名，读不到或解析失败返回 null（[scripts/gen-persistence-catalog.ts:154-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L154-L165)）
- `collectLogEvents` 先 glob `packages/*/*/src/**/*.ts` 并跳过文本不含 `SessionEventMap` 的文件（[scripts/gen-persistence-catalog.ts:176-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L176-L180)）
- 顶层声明必须位于归属包、必须 `export`、且全仓只能有一处，违反者记违规并跳过（[scripts/gen-persistence-catalog.ts:186-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L186-L201)）
- 带 `extends` 的声明记违规（[scripts/gen-persistence-catalog.ts:203-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L203-L205)）
- 非属性签名或无显式类型的成员记违规并跳过（[scripts/gen-persistence-catalog.ts:206-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L206-L215)）
- 非字符串字面量事件名记违规并跳过（[scripts/gen-persistence-catalog.ts:216-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L216-L219)）
- 同名事件重复声明记违规并跳过，首次出现的位置被记入 `seen`（[scripts/gen-persistence-catalog.ts:220-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L220-L227)）
- 事件 JSDoc 带 `@mode` 或缺描述散文都记违规（[scripts/gen-persistence-catalog.ts:228-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L228-L235)）
- 事件名第一个 `/` 之前的部分被取作 scope，决定产物里的分节（[scripts/gen-persistence-catalog.ts:236-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L236-L237)）
- 收集结束统一 `reportViolations`，有违规即中止（[scripts/gen-persistence-catalog.ts:241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L241)）
- `collectEventEnvelopeTypes` 只在归属包内找四个信封类型别名，重复声明、未导出、带 `@mode`、缺描述、缺失任一个都记违规，最后按固定顺序返回（[scripts/gen-persistence-catalog.ts:249-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L249-L288)）
- `collectSurfaceEventTypes` 解析 `SurfaceEventType` 联合，遇到非字符串字面量成员、找不到、或声明多于一处都直接抛错（[scripts/gen-persistence-catalog.ts:297-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L297-L320)）
- `annotateSurface` 给每个事件打 surface/log-only 标记，联合里有指向不存在事件的成员则抛错（[scripts/gen-persistence-catalog.ts:327-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L327-L335)）
- `typeLinks` 按词边界正则在 payload 文本里匹配 `LINK_MAP` 键并排序输出链接行（[scripts/gen-persistence-catalog.ts:338-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L338-L346)）
- `renderEvent` 为每个事件写出 GitHub slug 锚点、带标记的标题、声明代码块、类型链接与源位置链接（[scripts/gen-persistence-catalog.ts:349-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L349-L357)）
- `render` 先输出信封声明段与其来源链接，再按 scope 字典序、组内按事件名字典序渲染全部事件（[scripts/gen-persistence-catalog.ts:360-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L360-L392)）
- `renderKnownEventTypes` 把去重排序后的事件名渲染成运行期读路径校验用的 `KNOWN_SESSION_EVENT_TYPES` 只读集合（[scripts/gen-persistence-catalog.ts:399-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L399-L424)）
- `main` 把文档与运行期模块作为两份产物一起处理，`--check` 下任一陈旧就列出并 `process.exit(1)`，否则两份都写盘（[scripts/gen-persistence-catalog.ts:435-466](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L435-L466)）
- 入口守卫使得被测试导入时既不重写产物也不调用 `process.exit`（[scripts/gen-persistence-catalog.ts:468-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-persistence-catalog.ts#L468-L470)）

### scripts/gen-scoped-events.ts

`pnpm run gen-scoped-events` / `verify-scoped-events` 的实现：从仓库 TypeScript Program 推导每个作用域事件的路由键取值路径，生成运行期使用的 `packages/core/scope/src/scoped-events.generated.ts`。

- `OUT` 与 `SCOPE_DOC_MARKER` 固定生成文件落点和 JSDoc 里必须出现的说明串（[scripts/gen-scoped-events.ts:23-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L23-L24)）
- 构造函数把扫描面限定为 `packages/*/*/src/**.ts`，并解析 `scopeTarget` 函数声明与 `Scoped` 类型别名符号（[scripts/gen-scoped-events.ts:57-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L57-L70)）
- `render` 在有任何违规时抛出汇总错误，不生成任何内容（[scripts/gen-scoped-events.ts:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L76-L81)）
- 每个事件被渲染成 `args[i]` 或 `(args[i] as Record<string, unknown>)['prop']` 的取值函数，无候选者渲染为 `null`，整体冻结在一个 record 里（[scripts/gen-scoped-events.ts:92-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L92-L100)）
- 生成的 `scopedSubjectResolverFor` 用返回 resolver／null／undefined 三态区分“可取键”“只查载体存在”“非作用域事件”（[scripts/gen-scoped-events.ts:102-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L102-L112)）
- `functionDeclaration` 与 `typeAliasSymbol` 解析不到目标声明时抛错（[scripts/gen-scoped-events.ts:118-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L118-L136)）
- `collectScopeTargetContracts` 按已解析签名的声明身份找出所有 `scopeTarget` 调用，取实参处的 base/key 类型；缺参数记违规（[scripts/gen-scoped-events.ts:139-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L139-L161)）
- 只处理 `declare module '@deepseek-ai/cordis'` 里名为 `Events` 的接口的字符串字面量方法签名成员（[scripts/gen-scoped-events.ts:169-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L169-L172)）
- 无 `this: Scoped<...>` 接收者却在文档里写了作用域派发说明、或带了 `@dshScopeScan` 元数据，均记违规（[scripts/gen-scoped-events.ts:177-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L177-L188)）
- 有 `this: Scoped<...>` 接收者但 JSDoc 未说明作用域派发的记违规（[scripts/gen-scoped-events.ts:189-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L189-L193)）
- 路由键候选多于一个时记违规并跳过该事件（[scripts/gen-scoped-events.ts:196-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L196-L204)）
- 零候选时只有标注了 `@dshScopeScan unsupported` 才放行，并落成 `null` resolver（[scripts/gen-scoped-events.ts:205-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L205-L215)）
- 有候选却仍标 `unsupported` 的记违规并跳过（[scripts/gen-scoped-events.ts:216-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L216-L221)）
- 结果按事件名字典序排序，决定生成文件里的条目顺序（[scripts/gen-scoped-events.ts:229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L229)）
- `scopedBaseType` 只接受别名符号恰为 `Scoped` 的接收者类型并取其首个类型实参（[scripts/gen-scoped-events.ts:233-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L233-L237)）
- `routingKeyType` 用类型可赋值性匹配 base，无匹配或匹配到不一致的键类型都记违规并放弃该事件（[scripts/gen-scoped-events.ts:240-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L240-L266)）
- `subjectCandidates` 跳过 `this` 参数、按运行期下标枚举每个 payload 参数及其一层公开属性，并去重（[scripts/gen-scoped-events.ts:269-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L269-L290)）
- `typesEquivalent` 去掉 null/undefined 后要求类型对象同一，且 `any`/`unknown` 一律不匹配（[scripts/gen-scoped-events.ts:293-304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L293-L304)）
- `isCordisModuleInterface` 通过父级模块块与模块名字符串判定接口是否位于 cordis 模块声明内（[scripts/gen-scoped-events.ts:313-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L313-L320)）
- `parseScopeTag` 逐行剥 JSDoc 星号后抽 `@dshScopeScan` 标签，多个标签或非 `unsupported` 值都记违规（[scripts/gen-scoped-events.ts:328-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L328-L344)）
- `hasNonPublicDeclaration` 把带 `private`/`protected` 修饰的属性排除出候选（[scripts/gen-scoped-events.ts:347-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L347-L354)）
- `dedupeCandidates` 按候选路径去重，消除交叉类型合并带来的重复（[scripts/gen-scoped-events.ts:357-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L357-L364)）
- `quote` 对生成的属性键做反斜杠与单引号转义（[scripts/gen-scoped-events.ts:367-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L367-L369)）
- `renderScopedEvents` 对给定仓库根新建 Program 并返回完整生成源（[scripts/gen-scoped-events.ts:376-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L376-L378)）
- `main` 在 `--check` 下比对已提交文件、不一致即 `process.exit(1)`，否则写入生成文件（[scripts/gen-scoped-events.ts:381-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L381-L395)）
- 入口守卫只在本文件为进程入口时执行 `main`（[scripts/gen-scoped-events.ts:397-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-scoped-events.ts#L397-L399)）

### scripts/gen-third-party-notices.ts

`pnpm run gen-third-party-notices` / `verify-third-party-notices` 的实现：读工作区各 `package.json`、`vendor/README.md` 清单表、`python/*/pyproject.toml` 与 pnpm 补丁列表，结合已安装的 pnpm 存储元数据生成根目录 `THIRD_PARTY_NOTICES.md`。

- `RUNTIME_KINDS` 与 `ALL_KINDS` 划定哪些清单段算运行期依赖、哪些段算需要披露（[scripts/gen-third-party-notices.ts:20-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L20-L23)）
- `DEV_ONLY_AREAS` 列出哪些工作区路径的运行期声明降级为开发期（[scripts/gen-third-party-notices.ts:33-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L33-L39)）
- `FIRST_PARTY` 把三个原生包排除出第三方清单（[scripts/gen-third-party-notices.ts:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L42-L46)）
- `isOwnerAuthorizedRuntime` 以精确包名判定唯一一个被授权的非宽松运行期依赖（[scripts/gen-third-party-notices.ts:59-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L59-L61)）
- `OVERRIDES` 为若干包硬编码许可证与仓库地址，覆盖已安装清单的读值（[scripts/gen-third-party-notices.ts:67-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L67-L77)）
- `PYTHON_METADATA` 是 Python 依赖披露信息的唯一来源，缺条目会导致生成失败（[scripts/gen-third-party-notices.ts:84-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L84-L88)）
- `BUILD_TIME_TOOLS` 记录构建期抓取的工具及其钉住位置，供后续校验与渲染（[scripts/gen-third-party-notices.ts:93-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L93-L101)）
- `manifestPatterns` 从工作区成员声明推导清单 glob，而不是写死目录列表（[scripts/gen-third-party-notices.ts:134-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L134-L139)）
- `workspaceMembers` 在 `pnpm-workspace.yaml` 没有声明成员时抛错（[scripts/gen-third-party-notices.ts:142-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L142-L148)）
- `loadWorkspaceManifests` 把 glob 结果里的反斜杠统一成 `/`，并在清单数少于 100 时抛错（[scripts/gen-third-party-notices.ts:157-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L157-L171)）
- `claudeDistributionFromManifest` 校验包名、必填 `version`/`claudeCodeVersion`、非空 `optionalDependencies`，并拒绝任何越出其命名空间前缀的可选负载（[scripts/gen-third-party-notices.ts:209-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L209-L240)）
- `virtualManifest` 先按 `name@` 目录前缀在 `.pnpm` 里找清单，找不到再对整个存储做一遍内容扫描（[scripts/gen-third-party-notices.ts:255-274](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L255-L274)）
- `workspaceLinkedManifest` 优先解析声明方工作区自己的 `node_modules` 链接并缓存结果（[scripts/gen-third-party-notices.ts:284-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L284-L296)）
- `installedManifest` 依次尝试工作区链接、根 `node_modules`、原生构建工作区 `node_modules` 及各自的 `.pnpm` 虚拟存储（[scripts/gen-third-party-notices.ts:299-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L299-L320)）
- `installedMetadata` 解析不出许可证或仓库地址时抛错并提示安装或加 `OVERRIDES`（[scripts/gen-third-party-notices.ts:323-333](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L323-L333)）
- `collectClaudeDistribution` 逐个核对已安装平台负载的名称、版本与声明许可证字段，全部未安装时抛错（[scripts/gen-third-party-notices.ts:335-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L335-L364)）
- `normalizeRepo` 把 `git+ssh`、`git+`、`git://`、`github:` 等写法与 `.git` 后缀归一成可浏览的 https 链接（[scripts/gen-third-party-notices.ts:367-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L367-L377)）
- `collectNpmDeps` 过滤掉第一方包、按名排序并逐个补齐已安装元数据（[scripts/gen-third-party-notices.ts:386-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L386-L392)）
- `tierExternalDeps` 把 `tsx` 直接标为运行期，跳过工作区内部包与 `workspace:` 范围，并按声明区域与段类型做 or 累积分层（[scripts/gen-third-party-notices.ts:400-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L400-L415)）
- `parseVendoredRows` 用一条正则从 `vendor/README.md` 表格行抽出 npm 名、上游名与上游地址（[scripts/gen-third-party-notices.ts:430-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L430-L441)）
- `collectVendored` 要求 `vendor/` 下每个目录都有表格行、每个表格行都有目录、且每个包声明 MIT，任一不满足即抛错（[scripts/gen-third-party-notices.ts:449-472](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L449-L472)）
- `parsePythonRequirement` 用 PEP 508 正则取分发名，取不到即抛错（[scripts/gen-third-party-notices.ts:480-486](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L480-L486)）
- `collectPythonRequirementArray` 只放行字符串项与单键 `include-group` 表项，其余形式抛错（[scripts/gen-third-party-notices.ts:489-509](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L489-L509)）
- `parsePyproject` 收集 `[build-system].requires`、`[project].dependencies`、`[project.optional-dependencies]` 与 `[dependency-groups]` 下的全部需求（[scripts/gen-third-party-notices.ts:527-551](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L527-L551)）
- `normalizePythonDistributionName` 按打包规范做小写与分隔符归一（[scripts/gen-third-party-notices.ts:563-565](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L563-L565)）
- `collectPythonDependencies` 剔除本地项目名后排序，遇到 `PYTHON_METADATA` 里没有的依赖即抛错（[scripts/gen-third-party-notices.ts:573-589](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L573-L589)）
- `collectPython` 在 `python/*/pyproject.toml` 一个都没匹配到时抛错（[scripts/gen-third-party-notices.ts:592-596](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L592-L596)）
- `collectPatched` 从 `pnpm-workspace.yaml` 的 `patchedDependencies` 读出被打补丁的包与补丁文件（[scripts/gen-third-party-notices.ts:599-602](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L599-L602)）
- `verifyBuildTimePins` 在拥有该钉住的脚本文本里找不到工具名时抛错（[scripts/gen-third-party-notices.ts:605-612](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L605-L612)）
- `PERMISSIVE_LICENSES` 与 `isPermissiveSpdx` 定义许可证判定：`and` 要求两侧都宽松、`or` 只需一侧，`+` 与例外条款一律判否（[scripts/gen-third-party-notices.ts:615-627](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L615-L627)）
- `isPermissive` 先把斜杠写法换成 `OR` 再解析，解析失败按不宽松处理（[scripts/gen-third-party-notices.ts:639-647](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L639-L647)）
- `renderNonPermissiveNote` 在存在非宽松开发依赖时追加一段点名说明，否则输出空串（[scripts/gen-third-party-notices.ts:655-660](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L655-L660)）
- `renderClaudeDistribution` 仅在该 SDK 属于运行期依赖时渲染其平台负载表，否则整节缺省（[scripts/gen-third-party-notices.ts:669-687](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L669-L687)）
- `render` 先跑构建期钉住校验，再收集 npm/vendor/python/patch 四路输入并按运行期与开发期分表（[scripts/gen-third-party-notices.ts:693-706](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L693-L706)）
- 出现非宽松且未被点名授权的运行期依赖时直接抛错，不生成文件（[scripts/gen-third-party-notices.ts:709-715](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L709-L715)）
- 产物按 vendored、运行期 npm、补丁列表、平台负载、开发期 npm、Python、构建期抓取、第一方原生包的固定顺序拼成（[scripts/gen-third-party-notices.ts:718-773](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L718-L773)）
- `main` 在 `--check` 下比对已提交内容并以 0 或 1 退出，否则写入 `THIRD_PARTY_NOTICES.md`（[scripts/gen-third-party-notices.ts:778-799](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L778-L799)）
- 入口守卫使得被测试导入时既不重写产物也不调用 `process.exit`（[scripts/gen-third-party-notices.ts:801-803](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-third-party-notices.ts#L801-L803)）

### scripts/gen-tool-catalog.ts

`pnpm run gen-tool-catalog` / `verify-tool-catalog` 的实现：逐个把工具插件包挂到真实 Cordis Context 上启动，读 `ctx.tools.schemas()` 收割模型可见的工具名、描述与 JSON Schema，生成 `docs/tool-catalog.md`。

- `CatalogAttachmentStore` 作为附件接缝替身让附件条件性的 `read_image` 模式可被收割，其校验、写入、读取三个方法一律 reject（[scripts/gen-tool-catalog.ts:74-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L74-L95)）
- `registerCatalogSubagentProvider` 注册一个声明完整能力集但 `start`/`prepareContinuable` 都 reject 的子代理提供者，使消费者能按出厂默认挂载（[scripts/gen-tool-catalog.ts:106-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L106-L116)）
- `mountCatalogChildScope` 用 `createScope` 造一个 agent 样式子作用域来安装作用域内的工具包，并把该键记进 `catalogChildScopes`（[scripts/gen-tool-catalog.ts:119-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L119-L139)）
- `TOOL_PACKAGES` 逐包给出 `mount` 启动配方、`requires`、`writes`、可选 `scope`、`toolsConfig` 与部署说明，决定被收割的工具集合与表格内容（[scripts/gen-tool-catalog.ts:190-616](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L190-L616)）
- 工具注册表自身那条目用 `mode: 'ptc'` 启动注册表，才会暴露 `run_code`（[scripts/gen-tool-catalog.ts:205-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L205-L217)）
- 调度工具条目先建一个真实 Session 再在其 agent 子作用域内注册调度工具，并把该作用域作为收割视角（[scripts/gen-tool-catalog.ts:378-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L378-L397)）
- 子代理汇报工具条目从 `Config({})` 取默认投递方式并只在子作用域内安装该工具（[scripts/gen-tool-catalog.ts:500-519](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L500-L519)）
- 团队工具条目自行 `provide('agentTeams', ...)` 一个成员关系桩并注册一个假 Agent，以便收割仅对团队成员可见的工具（[scripts/gen-tool-catalog.ts:534-570](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L534-L570)）
- `assertManifestComplete` glob `packages/*/tool-*`，任一目录不在启动清单里即抛错（[scripts/gen-tool-catalog.ts:643-653](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L643-L653)）
- `assertToolsHarvested` 在某个包启动后一个工具都没注册时抛错（[scripts/gen-tool-catalog.ts:669-676](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L669-L676)）
- `collectToolCatalog` 为每个包新建独立 `Context`、挂 `SystemPrompt` 与 `ToolRuntime`、跑该包的 `mount`（[scripts/gen-tool-catalog.ts:684-695](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L684-L695)）
- 按条目声明的作用域读取 `ctx.tools.schemas()` 并按工具名排序，随后校验非空（[scripts/gen-tool-catalog.ts:696-697](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L696-L697)）
- 每个包收割完在 `finally` 里 `ctx.fiber.dispose()`，抛错路径也不遗留已挂载的执行器或提供者（[scripts/gen-tool-catalog.ts:710-712](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L710-L712)）
- `toolSource` 把收割到的工具名映射回注册它的源文件，映射缺失即抛错（[scripts/gen-tool-catalog.ts:718-727](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L718-L727)）
- `renderTool` 输出工具名标题、描述、缩进两格的 JSON Schema 代码块与源文件链接（[scripts/gen-tool-catalog.ts:730-736](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L730-L736)）
- `tableCell` 转义单元格里的 `|` 并把换行换成 `<br>`，空值渲染为破折号（[scripts/gen-tool-catalog.ts:738-744](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L738-L744)）
- `render` 先输出包→模型可见名→依赖→写入→别名→部署说明的总表，再按清单顺序逐包输出锚点、各工具节与部署说明（[scripts/gen-tool-catalog.ts:747-779](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L747-L779)）
- `main` 在 `--check` 下比对已提交内容，陈旧时打印首个差异行的已提交值与生成值再 `process.exit(1)`（[scripts/gen-tool-catalog.ts:786-812](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L786-L812)）
- 非 `--check` 时把渲染结果写入 `docs/tool-catalog.md`（[scripts/gen-tool-catalog.ts:814-815](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L814-L815)）
- 入口守卫使得被测试导入时既不重写产物也不调用 `process.exit`（[scripts/gen-tool-catalog.ts:818-820](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tool-catalog.ts#L818-L820)）

### scripts/gen-translation-brief.ts

`pnpm run gen-translation-brief` 的入口脚本，为失同步的双语文档对生成最小更新简报，并在 `--apply` 下写回可机械计算的对应文件。

- 模块加载时读取 `scripts/translation-pairing.manifest.json` 与 `docs/i18n/terminology.md`，构造配对来源判定与术语表文本（[scripts/gen-translation-brief.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L44-L47)）
- `parseMeta` 逐行解析一致性记录，只接受 `<name>.md: <40 位十六进制>` 形式，遇到不匹配行整体返回 undefined（[scripts/gen-translation-brief.ts:54-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L54-L63)）
- `git` 以 `spawnSync` 在仓库根执行 git，缓冲上限 64 MiB，退出码不在白名单时抛错（[scripts/gen-translation-brief.ts:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L65-L72)）
- `blobText` 用 `git cat-file -p` 把记录里的哈希还原成文本（[scripts/gen-translation-brief.ts:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L74-L76)）
- `diffTexts` 在临时目录写入两份文本，跑 `git diff --no-index --unified=2`，剥掉 diff/index/---/+++ 头行，最后删除临时目录（[scripts/gen-translation-brief.ts:79-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L79-L92)）
- `loadPair` 对越界或被排除的锚点、缺失三件套的残缺对、无法解析的一致性记录分别返回说明字符串（[scripts/gen-translation-brief.ts:105-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L105-L120)）
- `loadPair` 用当前文件内容与记录哈希还原文本逐字比较，得出两侧各自的漂移标志（[scripts/gen-translation-brief.ts:121-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L121-L133)）
- `bundlesFor` 合并变更下标与首次出现下标并排序，任一侧缺失该下标即抛错（[scripts/gen-translation-brief.ts:144-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L144-L151)）
- `bundlesFor` 对文本未变的额外下标标记 `first-occurrence` 理由，并带出对应侧的起始行号（[scripts/gen-translation-brief.ts:152-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L152-L161)）
- `planScope` 在两侧都漂移时直接给出 document 粒度并附理由（[scripts/gen-translation-brief.ts:181-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L181-L186)）
- `planScope` 优先尝试 `computeMechanicalUpdate`，成功则给出 mechanical 粒度并携带算出的对应文本（[scripts/gen-translation-brief.ts:187-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L187-L190)）
- `planScope` 依次尝试 units、sections 两种切分，要求三份文本跨度一一对齐且存在变更，否则继续下一种（[scripts/gen-translation-brief.ts:191-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L191-L198)）
- 只有 en-to-zh 方向计算首次出现上下文，zh-to-en 方向使用空的注记与额外下标（[scripts/gen-translation-brief.ts:199-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L199-L202)）
- 两种切分都不对齐时回落到 document 粒度并写明理由（[scripts/gen-translation-brief.ts:212-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L212-L215)）
- `applyMechanical` 用 `translationStructureSignature`/`translationStructureDiff` 比对源与算出结果的结构，有差异即抛错拒绝写入（[scripts/gen-translation-brief.ts:227-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L227-L241)）
- 校验通过后覆写对应文件并向 stderr 打印已应用提示（[scripts/gen-translation-brief.ts:242-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L242-L243)）
- `briefDirection` 按方向选定源/对应路径与上次确认文本，计算 diff、规划粒度，`--apply` 时应用机械结果，最后渲染简报（[scripts/gen-translation-brief.ts:247-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L247-L267)）
- 命令行只接受 `--apply`，出现其它 `--` 开头参数时打印并以 2 退出（[scripts/gen-translation-brief.ts:269-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L269-L276)）
- 无位置参数时用 `**/*.i18n.yaml` 全仓扫描（带排除表）推出锚点集合，有参数时把参数映射成锚点并去重排序（[scripts/gen-translation-brief.ts:277-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L277-L289)）
- 主循环跳过不可简报与未漂移的对；显式请求时把这两类分别记入 problems / skipped（[scripts/gen-translation-brief.ts:294-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L294-L303)）
- 两侧漂移时分别生成 en-to-zh 与 zh-to-en 两份简报（[scripts/gen-translation-brief.ts:304-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L304-L305)）
- 存在 problems 或 skipped 时逐条打到 stderr 并以 2 退出；无简报时打印一行并以 0 退出；否则把简报用 `---` 分隔打到 stdout（[scripts/gen-translation-brief.ts:308-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-translation-brief.ts#L308-L316)）

### scripts/gen-tsconfig-paths.ts

生成并校验 `tsconfig.base.json` 中受标记包围区域内的逐包路径别名，`--check` 模式只报漂移。

- 顶部常量固定被改写的配置文件路径、生成区域的起止标记行和包名前缀（[scripts/gen-tsconfig-paths.ts:26-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L26-L32)）
- `packageName` 用 try/catch 吞掉读取或解析失败并返回 undefined，只接受字符串 name（[scripts/gen-tsconfig-paths.ts:49-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L49-L59)）
- `workspacePackages` 按排序遍历 `packages/<group>/<dir>`，只收前缀匹配且存在 `src` 目录的包（[scripts/gen-tsconfig-paths.ts:73-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L73-L87)）
- `collectPackageAliases` 只映射包名恰为前缀加目录名的包，两个目录声明同一名字时抛错（[scripts/gen-tsconfig-paths.ts:101-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L101-L118)）
- 每个包记录 `src/invariant.ts` 是否存在，用于额外生成 `/invariant` 子路径别名（[scripts/gen-tsconfig-paths.ts:112-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L112-L117)）
- `collectPackageNames` 返回所有带 `src` 的前缀包名，包含名字与目录不一致的包（[scripts/gen-tsconfig-paths.ts:134-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L134-L138)）
- `mappedSpecifiers` 用行首正则扫出配置里所有无子路径的裸包键（[scripts/gen-tsconfig-paths.ts:145-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L145-L152)）
- `uncoveredPackages` 过滤出没有任何别名映射的包名（[scripts/gen-tsconfig-paths.ts:166-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L166-L171)）
- `renderAliases` 跳过区域外已手写的同名键，逐行输出 JSON 成员，末行不带逗号（[scripts/gen-tsconfig-paths.ts:179-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L179-L192)）
- `writeRegion` 按起止标记切片替换区域内容，标记缺失或次序颠倒时抛错（[scripts/gen-tsconfig-paths.ts:201-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L201-L208)）
- `handWrittenSpecifiers` 先剔除生成区域再扫键，得到手写别名集合（[scripts/gen-tsconfig-paths.ts:215-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L215-L225)）
- 直接执行时：存在未覆盖的包则打 stderr 并置 exitCode 1；内容一致则打印现状；`--check` 且有漂移则打 stderr 并置 exitCode 1；否则写回文件（[scripts/gen-tsconfig-paths.ts:227-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/gen-tsconfig-paths.ts#L227-L248)）

### scripts/install-lefthook.mjs

`pnpm install` 生命周期里运行的 lefthook 安装器，把 git 钩子目录与配对合并驱动装到 worktree 局部配置里。

- 常量固定最低 git 版本、钩子目录名、归属标记名与版本、安装锁名与超时、允许覆盖 hooksPath 的环境变量名（[scripts/install-lefthook.mjs:19-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L19-L29)）
- 常量写死要写入的 `merge.dsh-translation-pairing.name`/`.driver` 键值与驱动探针命令行（[scripts/install-lefthook.mjs:30-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L30-L42)）
- `capture` 以 `spawnSync` 执行外部命令，状态非 0 且不在允许列表时抛出带 stderr 的错误（[scripts/install-lefthook.mjs:56-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L56-L66)）
- `nulValues` 把 `--null` 输出按 NUL 切分，状态非 0 时返回空列表（[scripts/install-lefthook.mjs:72-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L72-L77)）
- `stripGitLineTerminator` 在 win32 上额外去掉尾随 CR（[scripts/install-lefthook.mjs:79-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L79-L84)）
- `directFileConfigValues` 以 `--no-includes` 读取某配置文件里直接写入的值，允许退出码 1（[scripts/install-lefthook.mjs:86-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L86-L92)）
- `includedFileConfigEntries` 以 `--includes --show-origin` 读取含 include 展开的条目并成对解析，字段数为奇数时抛错（[scripts/install-lefthook.mjs:94-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L94-L112)）
- `directFileConfigMatchingEntries` 用 `--get-regexp` 取匹配条目并按换行切出名与值（[scripts/install-lefthook.mjs:114-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L114-L134)）
- `effectiveConfigEntry` 读取某键的生效值及其 scope 与 origin，字段数不等于 3 时抛错（[scripts/install-lefthook.mjs:136-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L136-L148)）
- `parseGitBoolean` 按 git 的布尔词表解析，非法值抛错（[scripts/install-lefthook.mjs:150-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L150-L155)）
- `assertSingle` 在同键出现多值时抛错（[scripts/install-lefthook.mjs:157-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L157-L160)）
- `registeredWorktreeConfigPaths` 枚举主 worktree 与 `worktrees/<name>` 下的 `config.worktree`，目录缺失时按 ENOENT 忽略（[scripts/install-lefthook.mjs:176-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L176-L189)）
- `assertCommonConfigFile` 拒绝不存在、非普通文件或符号链接的公共配置（[scripts/install-lefthook.mjs:200-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L200-L207)）
- `assertWorktreeConfigFiles` 拒绝非普通文件的 worktree 配置，并在扩展未启用而休眠配置已含条目时拒绝启用（[scripts/install-lefthook.mjs:209-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L209-L231)）
- `assertSupportedGit` 解析 `git --version` 并按 2.26.0 逐段比较，低版本抛错（[scripts/install-lefthook.mjs:233-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L233-L244)）
- `planWorktreeConfigMigration` 校验 `core.repositoryFormatVersion` 为非负整数，版本 0 且已有 `extensions.*` 时拒绝升级（[scripts/install-lefthook.mjs:246-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L246-L267)）
- 公共配置里存在 `core.worktree` 或 `core.bare=true` 时拒绝启用 worktree 配置扩展（[scripts/install-lefthook.mjs:269-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L269-L291)）
- `applyWorktreeConfigMigration` 写入 `core.repositoryFormatVersion=1`、`extensions.worktreeConfig=true`，并在 `core.bare=false` 时删除该键（[scripts/install-lefthook.mjs:294-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L294-L305)）
- `parseInstallLock` 只接受 `<pid> <uuid>\n` 形式并要求 pid 为安全整数（[scripts/install-lefthook.mjs:325-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L325-L330)）
- `lockOwnerIsAlive` 用 `process.kill(pid, 0)` 探活，ESRCH 视为已死、EPERM 视为存活（[scripts/install-lefthook.mjs:337-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L337-L346)）
- `releaseInstallLock` 先按 dev/ino 与记录内容确认仍是自己持有的锁再 unlink，否则抛归属变更错（[scripts/install-lefthook.mjs:359-379](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L359-L379)）
- `acquireInstallLock` 用 `open(..., 'wx', 0o600)` 独占创建锁文件、写入 pid+UUID，并按 dev/ino 复核发布结果（[scripts/install-lefthook.mjs:381-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L381-L410)）
- 环境变量 `DSH_TEST_LEFTHOOK_LOCK_WRITE_DELAY_MS` 在创建 inode 与写入记录之间插入延迟（[scripts/install-lefthook.mjs:392-395](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L392-L395)）
- EEXIST 分支区分非法锁、正在初始化的锁（有 5 秒初始化超时）与活跃持有者，并按 50 毫秒轮询直至 30 秒总超时（[scripts/install-lefthook.mjs:411-456](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L411-L456)）
- 持有者进程已死时不自动清理，抛出要求人工确认并删除的错误（[scripts/install-lefthook.mjs:450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L450)）
- `ownershipMarkerContent`/`parseOwnershipMarker` 把归属标记序列化为带版本、owner、绝对 hooksPath 的 JSON，并在任一字段不符时视为无效（[scripts/install-lefthook.mjs:459-485](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L459-L485)）
- `inspectOwnedHooksDirectory` 拒绝非目录/符号链接的 hooks 路径、缺少或无效标记的目录，以及非普通文件或多硬链接的钩子条目（[scripts/install-lefthook.mjs:487-515](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L487-L515)）
- `isRegisteredOwnedHooksPath` 只承认落在已注册 worktree 目录下、且标记自指的 hooks 路径（[scripts/install-lefthook.mjs:517-524](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L517-L524)）
- `ensureOwnedHooksDirectory` 以 0700 创建目录并以 `wx`/0600 写入归属标记（[scripts/install-lefthook.mjs:526-533](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L526-L533)）
- `environmentWithoutCommandGitConfig` 在调用 lefthook 前删除 `GIT_CONFIG_PARAMETERS`/`GIT_CONFIG_COUNT`/`GIT_CONFIG_KEY_n`/`GIT_CONFIG_VALUE_n`（[scripts/install-lefthook.mjs:539-552](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L539-L552)）
- `runLefthook` 以 `install --force` 调用 lefthook，win32 走 shell 并加引号，stdio 继承，非 0 退出抛错（[scripts/install-lefthook.mjs:554-563](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L554-L563)）
- `normalizedPath` 在 win32 上做小写归一，用于路径同一性比较（[scripts/install-lefthook.mjs:569-572](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L569-L572)）
- `refuseInheritedHooksPath` 与 `refuseScopedHooksPath` 按 scope 分别抛出拒绝替换的错误，command/worktree 作用域不接受环境变量覆盖（[scripts/install-lefthook.mjs:585-609](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L585-L609)）
- `installPairingMergeDriver` 拒绝来自 include 文件的配对配置、command 作用域值、以及与期望值不同的继承值或已有 worktree 值（[scripts/install-lefthook.mjs:611-641](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L611-L641)）
- 缺失的键用 `git config --worktree` 写入，随后复核它成为唯一的直接值与生效值，否则抛错（[scripts/install-lefthook.mjs:642-663](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L642-L663)）
- 出错时按逆序 unset 已写入的键，回滚也失败则抛 `AggregateError`；成功时返回可调用的回滚闭包（[scripts/install-lefthook.mjs:664-685](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L664-L685)）
- `probePairingMergeDriver` 以 `node --import tsx/esm ... --probe` 试运行合并驱动（[scripts/install-lefthook.mjs:687-689](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L687-L689)）
- `main` 在 `CI=true` 或 `GITHUB_ACTIONS=true`、lefthook 无 bin 字段、非 git 仓库、bin 文件不存在时直接返回不安装（[scripts/install-lefthook.mjs:691-699](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L691-L699)）
- 解析 `--absolute-git-dir` 与 `--git-common-dir` 得出 worktree 配置路径与钩子目录，并先取安装锁（[scripts/install-lefthook.mjs:701-708](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L701-L708)）
- 已有 worktree 级 `core.hooksPath` 指向别处时，只有它是本安装器归属的（重定位或另一 worktree 的拷贝）才继续，否则拒绝（[scripts/install-lefthook.mjs:719-746](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L719-L746)）
- 生效的 `core.hooksPath` 不属本安装器时：command/worktree/未知作用域直接拒绝，system/global/local 作用域需 `DSH_LEFTHOOK_ALLOW_HOOKS_PATH_OVERRIDE=1` 才放行（[scripts/install-lefthook.mjs:747-764](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L747-L764)）
- 建好归属目录后复核重定位归属未变，再应用 worktree 配置迁移（[scripts/install-lefthook.mjs:765-775](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L765-L775)）
- 依次探针合并驱动、写入合并驱动配置、写入 `core.hooksPath`、复核生效值、运行 lefthook、更新归属标记（[scripts/install-lefthook.mjs:779-794](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L779-L794)）
- 任一步失败则恢复原 `core.hooksPath`（原本没有就 unset）并回滚合并驱动配置，回滚再失败则抛 `AggregateError`（[scripts/install-lefthook.mjs:795-821](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L795-L821)）
- `finally` 中释放安装锁，释放失败且安装也失败时合并成 `AggregateError` 抛出（[scripts/install-lefthook.mjs:825-837](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L825-L837)）
- 顶层捕获所有错误，打印带 `[install-lefthook]` 前缀的消息到 stderr 并置 `exitCode = 1`（[scripts/install-lefthook.mjs:840-845](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/install-lefthook.mjs#L840-L845)）

### scripts/jsdoc.ts

被 Cordis/持久化/配置目录生成器与导出 API 门禁共用的 JSDoc 解析与完整性检查库。

- `pointer` 由节点起始位置算出 `file:line` 形式的源码指针（[scripts/jsdoc.ts:9-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/jsdoc.ts#L9-L12)）
- `rawJsDoc` 取节点前导注释中最后一个以 `/**` 开头的块，没有则返回空串（[scripts/jsdoc.ts:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/jsdoc.ts#L15-L19)）
- `parseJsDoc` 剥掉分隔符与行首星号，把段落折叠成一行、列表项各占一行，遇到第一个块标签后不再收正文（[scripts/jsdoc.ts:32-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/jsdoc.ts#L32-L79)）
- `@mode` 只接受 emit/waterfall/parallel/serial/bail 五个取值，其他 `@mode` 写法只置 hasMode 而不产出模式（[scripts/jsdoc.ts:62-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/jsdoc.ts#L62-L64)）
- 输出前把 `{@link X}` 展开为 `X`，段落间以空行连接（[scripts/jsdoc.ts:80-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/jsdoc.ts#L80-L81)）
- `parseTags` 解析 `@param`（允许可选分隔符、`[name]` 去括号）与 `@returns`，并把后续非标签行并入当前描述（[scripts/jsdoc.ts:91-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/jsdoc.ts#L91-L119)）
- `checkParams` 对绑定模式参数、缺失的 `@param`、空描述以及不对应任何参数的陈旧标签分别追加违规（[scripts/jsdoc.ts:134-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/jsdoc.ts#L134-L158)）
- `checkReturns` 要求显式返回类型标注，`void`/`Promise<void>` 之外的返回必须有非空 `@returns`（[scripts/jsdoc.ts:171-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/jsdoc.ts#L171-L186)）
- `reportViolations` 把收集到的违规聚合成一条错误抛出，空列表时不做任何事（[scripts/jsdoc.ts:195-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/jsdoc.ts#L195-L201)）

### scripts/markdown.ts

文档门禁共用的 Markdown 解析、遍历与源码定位库。

- `parseMarkdown` 固定用 GFM 扩展解析（[scripts/markdown.ts:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L43-L45)）
- `visitMarkdown` 深度优先遍历，访问器返回 false 时剪掉该节点的子树（[scripts/markdown.ts:52-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L52-L57)）
- `isExternalOrAbsoluteMarkdownUrl` 把 `#`、`//`、`/` 开头和带协议前缀的 URL 判为外部或绝对（[scripts/markdown.ts:70-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L70-L75)）
- `splitMarkdownUrlTarget` 在首个 `?` 或 `#` 处把 URL 切成路径与后缀（[scripts/markdown.ts:78-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L78-L82)）
- `labelEnd` 按方括号配对并处理反斜杠转义定位标签结束位置（[scripts/markdown.ts:90-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L90-L104)）
- `destinationRange` 分别处理定义式（冒号后）与行内式（括号后）目标，支持尖括号包裹与括号嵌套，定位失败即抛错（[scripts/markdown.ts:106-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L106-L140)）
- `markdownDestination` 用节点源偏移加区间定位出目标 URL 的绝对起止，无偏移时抛错（[scripts/markdown.ts:143-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L143-L152)）
- `markdownFences` 收集每个代码块的起始行、语言、完整 info 串、正文，并按结尾行是否为围栏判定 closed（[scripts/markdown.ts:159-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L159-L172)）
- `renderedText` 把文本/行内代码取值、图片取 alt、换行折成空格，raw HTML 不贡献文本（[scripts/markdown.ts:175-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L175-L181)）
- `markdownHeadingLines` 返回每个标题的层级、源行号、原始行文本与渲染文本（[scripts/markdown.ts:184-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L184-L197)）
- `htmlCommentRanges` 在 html 节点内逐个定位 `<!--`/`-->`（未闭合按节点末尾算），再折算成按行的列区间（[scripts/markdown.ts:203-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L203-L235)）
- `hasRenderedTextOutsideComments` 按列区间挖掉注释后判断该行是否仍有非空白文本（[scripts/markdown.ts:238-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L238-L248)）
- `markdownProseLines` 排除代码块覆盖的行与整行被注释掉的行，保留其余行及其 1 基行号（[scripts/markdown.ts:255-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/markdown.ts#L255-L271)）

### scripts/merge-translation-pairing-driver.sh

git 自定义合并驱动的 shell 入口，由安装器写入的 `merge.dsh-translation-pairing.driver` 调用。

- 参数不足 4 个时打印用法并以 129 退出（[scripts/merge-translation-pairing-driver.sh:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing-driver.sh#L3-L6)）
- 由脚本自身位置解析出同目录的 TypeScript 驱动路径，解析失败以 129 退出（[scripts/merge-translation-pairing-driver.sh:12-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing-driver.sh#L12-L13)）
- 探针成功时以 `exec node --import tsx/esm` 接管进程执行 TypeScript 驱动（[scripts/merge-translation-pairing-driver.sh:15-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing-driver.sh#L15-L19)）
- 运行时不可用时退回 `git merge-file`，用带来源标签的三方合并把结果写进当前版本文件（[scripts/merge-translation-pairing-driver.sh:21-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing-driver.sh#L21-L27)）
- 回退路径向 stderr 打印后续恢复指引（[scripts/merge-translation-pairing-driver.sh:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing-driver.sh#L28)）
- 回退路径即便文本合并干净也以 1 退出（大于 127 的状态原样透传），使 git 索引保持未解决（[scripts/merge-translation-pairing-driver.sh:32-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing-driver.sh#L32-L35)）

### scripts/merge-translation-pairing.ts

配对记录的 git 合并驱动与显式冲突解决器的 TypeScript 入口，被上面的 shell 驱动与 `pnpm run resolve-translation-pairing-conflicts` 调用。

- `--probe` 模式除自身外不接受任何参数，用于探测运行时是否可用（[scripts/merge-translation-pairing.ts:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing.ts#L14-L15)）
- 非探针模式先用 `git rev-parse --show-toplevel` 求仓库根（[scripts/merge-translation-pairing.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing.ts#L17)）
- `--resolve` 模式扫描未合并索引并逐条解决，无待解决记录时打印一行说明（[scripts/merge-translation-pairing.ts:18-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing.ts#L18-L25)）
- 合并驱动模式要求恰好 4 个路径参数，读取祖先/当前/对侧三份内容做记录合并（[scripts/merge-translation-pairing.ts:26-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing.ts#L26-L41)）
- 合并结果写回 git 传入的“当前版本”临时文件（[scripts/merge-translation-pairing.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing.ts#L42)）
- 任何异常都打印错误与后续操作指引到 stderr 并置 `exitCode = 1`（[scripts/merge-translation-pairing.ts:45-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/merge-translation-pairing.ts#L45-L53)）

### scripts/migrate-packed-session-fixtures.ts

把会话快照 fixture 重写为规范布局的一次性迁移命令。

- 带任何命令行参数即抛错（[scripts/migrate-packed-session-fixtures.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/migrate-packed-session-fixtures.ts#L12)）
- 检查全部 fixture 布局，只对源文本与规范文本不同者覆写文件并打印其路径（[scripts/migrate-packed-session-fixtures.ts:15-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/migrate-packed-session-fixtures.ts#L15-L20)）
- 最后打印重写数量与检查总数的汇总行（[scripts/migrate-packed-session-fixtures.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/migrate-packed-session-fixtures.ts#L21)）

### scripts/package-graph.ts

工作区包依赖图的发现与排序，以及 Mermaid 标识符辅助函数，被模块图与关系图生成器共用。

- `collectPackageGraph` 用 `packages/*/*/package.json` 扫描并排序清单，跳过非本 scope 的包，路径拆分异常时抛错（[scripts/package-graph.ts:36-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-graph.ts#L36-L44)）
- 依赖边只取 peerDependencies 中同 scope 的条目，去前缀并排序（[scripts/package-graph.ts:45-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-graph.ts#L45-L48)）
- `topoSort` 先校验每条依赖边都指向存在的包，否则抛错（[scripts/package-graph.ts:61-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-graph.ts#L61-L68)）
- 逐层取出依赖已就绪的包并按分组顺序排序输出；无就绪项时取一个汇聚环整体放行，仍取不到则抛错（[scripts/package-graph.ts:69-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-graph.ts#L69-L89)）
- `sinkCycles` 用 Tarjan 求强连通分量，只保留真环且其全部外部依赖都已排定的分量（[scripts/package-graph.ts:94-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-graph.ts#L94-L144)）
- `requiredValue` 在索引缺失时抛错而不是返回 undefined（[scripts/package-graph.ts:146-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-graph.ts#L146-L150)）
- `comparePackages` 按调用方给定的分组顺序排序，未列出的分组排到最后，再按分组名与短名排（[scripts/package-graph.ts:152-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-graph.ts#L152-L158)）
- `graphNodeId` 把非字母数字下划线字符替换成下划线生成 Mermaid 节点 id（[scripts/package-graph.ts:161-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-graph.ts#L161-L163)）
- `escapeMermaidLabel` 转义 Mermaid 引号标签中的双引号（[scripts/package-graph.ts:166-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-graph.ts#L166-L168)）

### scripts/package-invariants.ts

发现每个包的不变量伴随文件并做清单、构建配置与源码结构检查的门禁库。

- `packageInvariantOwners` 扫描全部包清单并排序，清单未声明 name 时抛错，推出 `src/invariant.ts` 的约定路径（[scripts/package-invariants.ts:37-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L37-L54)）
- `collectPackageInvariantViolations` 对每个包依次跑清单、构建、源码三组检查并汇总违规（[scripts/package-invariants.ts:57-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L57-L66)）
- `checkManifest` 要求 `exports["./invariant"]` 精确指向 `./lib/types/invariant.d.ts` 与 `./lib/invariant.js`，且 `files` 含 `lib/invariant.js`（[scripts/package-invariants.ts:85-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L85-L97)）
- 除 invariants 包自身外，要求 `@deepseek-ai/dsh-invariants` 同时是 `workspace:^` 的 peer 与 dev 依赖（[scripts/package-invariants.ts:98-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L98-L112)）
- `checkBuild` 要求 TypeScript 项目引用能到达 invariants 项目，且存在的 `tsdown.config.ts` 必须打包 `lib/types/invariant.js`（[scripts/package-invariants.ts:115-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L115-L136)）
- `projectReferencesInvariants` 从入口 tsconfig 出发广搜引用，只沿包目录内部的子配置继续，命中目标目录即成立（[scripts/package-invariants.ts:138-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L138-L161)）
- `checkSource` 在伴随文件缺失时记违规并返回，含 `@generated` 标记时记违规（[scripts/package-invariants.ts:163-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L163-L180)）
- 用 TypeScript AST 遍历找出所有 `*.invariants.register(...)` 调用，记录其包名参数与第二参数是否为标识符 `install`（[scripts/package-invariants.ts:182-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L182-L207)）
- 包名参数无法解析为本地字符串常量、或安装器不是本地 `install` 时，按行号记违规（[scripts/package-invariants.ts:209-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L209-L222)）
- 要求恰好注册一次且注册的就是本包名（[scripts/package-invariants.ts:223-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L223-L229)）
- 要求具名导出 `name`/`inject`/`apply`，且不得有默认导出（[scripts/package-invariants.ts:230-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L230-L237)）
- `checkInstaller` 取最后一个名为 `install` 的顶层变量声明，取不到函数体时记违规（[scripts/package-invariants.ts:247-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L247-L264)）
- 空函数体必须在其声明文本中带 `No runtime invariant:` 注释说明，否则记违规（[scripts/package-invariants.ts:265-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L265-L277)）
- 非空安装器必须以标识符形式接收第二个参数（失败上报器）并在函数体中实际使用它（[scripts/package-invariants.ts:278-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L278-L291)）
- `installerFunction` 接受箭头函数、函数表达式，以及 `Object.assign(fn, ...)` 的第一个参数（[scripts/package-invariants.ts:293-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L293-L306)）
- `topLevelStringConstants` 顺序收集顶层字符串常量，供包名参数解析（[scripts/package-invariants.ts:308-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L308-L325)）
- `isInvariantRegistration` 只认 `<x>.invariants.register` 形式的调用目标（[scripts/package-invariants.ts:327-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L327-L332)）
- `hasDefaultExport` 覆盖 `export =`、`export default` 修饰符、`export { default }` 与 `export * as default`（[scripts/package-invariants.ts:342-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L342-L353)）
- `formatPackageInvariantViolation` 把违规渲染成仓库相对路径加消息的一行（[scripts/package-invariants.ts:356-362](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/package-invariants.ts#L356-L362)）

### scripts/paired-markdown-derivatives.ts

把与英文兄弟文件逐字节相同的中文 Markdown 代码块从主检查集合中分出来的共享工具。

- `unsuffixedSibling` 把 `.zh.md` 路径映射到同名 `.md` 路径，非中文文件返回 null（[scripts/paired-markdown-derivatives.ts:16-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/paired-markdown-derivatives.ts#L16-L18)）
- 先按所属文档把块分组，保持扫描顺序（[scripts/paired-markdown-derivatives.ts:35-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/paired-markdown-derivatives.ts#L35-L41)）
- 只有块数相等且逐位指纹全等的 `.zh.md` 文档才整体标记为派生，部分匹配或乱序则整体留在主集合（[scripts/paired-markdown-derivatives.ts:43-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/paired-markdown-derivatives.ts#L43-L55)）
- 最终按原顺序把块分入 primary 与 derivatives 两个数组（[scripts/paired-markdown-derivatives.ts:57-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/paired-markdown-derivatives.ts#L57-L62)）

### scripts/pnpm-invocation.ts

由 pnpm 生命周期环境推导出无 shell 子进程调用方式的工具函数。

- `npm_execpath` 缺失或为空时抛错，要求脚本经 `pnpm run` 启动（[scripts/pnpm-invocation.ts:13-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/pnpm-invocation.ts#L13-L16)）
- 入口以 `.js`/`.cjs`/`.mjs` 结尾时改用当前 Node 可执行文件并把入口作为首个参数，否则直接把入口当命令（[scripts/pnpm-invocation.ts:17-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/pnpm-invocation.ts#L17-L20)）

### scripts/prepare-ci-bubblewrap.sh

CI 上准备 bubblewrap 可执行文件的脚本，把签名归档解到运行器临时目录并加入 PATH。

- `set -euo pipefail` 使任一步失败即终止（[scripts/prepare-ci-bubblewrap.sh:2](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/prepare-ci-bubblewrap.sh#L2)）
- 固定 bubblewrap 版本、SHA256 与下载 URL（[scripts/prepare-ci-bubblewrap.sh:7-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/prepare-ci-bubblewrap.sh#L7-L9)）
- `RUNNER_TEMP` 与 `GITHUB_PATH` 未设置时立刻失败（[scripts/prepare-ci-bubblewrap.sh:11-12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/prepare-ci-bubblewrap.sh#L11-L12)）
- 非 Linux x86_64 时打印说明并以 1 退出（[scripts/prepare-ci-bubblewrap.sh:14-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/prepare-ci-bubblewrap.sh#L14-L17)）
- 用 curl 带 3 次全错重试下载归档，再用 sha256sum 校验（[scripts/prepare-ci-bubblewrap.sh:22-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/prepare-ci-bubblewrap.sh#L22-L23)）
- 用 `dpkg-deb --extract` 解包到临时目录，并把 `usr/bin` 追加进 `GITHUB_PATH`（[scripts/prepare-ci-bubblewrap.sh:24-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/prepare-ci-bubblewrap.sh#L24-L26)）
- 尝试用 sysctl 关闭 apparmor 的非特权用户命名空间限制，失败只打印提示不中断（[scripts/prepare-ci-bubblewrap.sh:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/prepare-ci-bubblewrap.sh#L28-L29)）
- 跑 `--version` 与一次真实的 `--ro-bind / / --unshare-pid` 沙箱探针，失败即让脚本失败（[scripts/prepare-ci-bubblewrap.sh:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/prepare-ci-bubblewrap.sh#L30-L32)）

### scripts/project-doc-site.ts

把仓库内 Markdown 投影为 VitePress 站点源树、并额外产出每条路由的原始 Markdown 孪生文件与 llms.txt 的构建期适配层。

- `resolveRepositoryRef` 从 `DOCS_REPOSITORY_REF` 取公开 ref，缺省为 `master`（[scripts/project-doc-site.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L36-L38)）
- `decodePath` 对畸形百分号转义抛错而不是静默通过（[scripts/project-doc-site.ts:77-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L77-L83)）
- `sourceMap` 把源路径与别名映射到各 locale 页面，同一 locale 出现重复源或别名时抛错（[scripts/project-doc-site.ts:90-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L90-L103)）
- `resolveRepositoryTarget` 依次尝试原路径、去掉 `:行号` 后缀、补 `.md`、补 `/index.md`，全部落空即抛链接失效错误（[scripts/project-doc-site.ts:111-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L111-L132)）
- `githubTarget` 对图片生成 raw 域名 URL，对其它目标按是否目录选 `tree`/`blob`，有行号时改用 `#L<行>` 后缀（[scripts/project-doc-site.ts:134-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L134-L147)）
- `rewriteMarkdown` 跳过外部与绝对 URL，其余按仓库路径解析目标（[scripts/project-doc-site.ts:156-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L156-L167)）
- 指向本页语言对侧文件的链接被识别为语言切换器，改为解析到另一 locale 的页面（[scripts/project-doc-site.ts:168-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L168-L172)）
- 已发布目标改写为站内相对路由；图片在提供 `placeImage` 时改写为随行拷贝地址；其余回落到 GitHub 地址（[scripts/project-doc-site.ts:173-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L173-L179)）
- 改写按偏移倒序应用到原文，不重新序列化 Markdown（[scripts/project-doc-site.ts:181-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L181-L201)）
- `addProjectionFrontmatter` 写入 `editSource` 与可选 `outline` 字段，已有 frontmatter 时插入其中，否则新建（[scripts/project-doc-site.ts:211-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L211-L218)）
- `withoutRepositoryChrome` 删除位于前 8 行内的语言切换行及其后空行，并删除最后一处仓库徽章行（[scripts/project-doc-site.ts:221-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L221-L249)）
- `projectedPageContent` 对 `sidebar === null` 的 locale 首页只保留 frontmatter，缺失或未闭合 frontmatter 时抛错（[scripts/project-doc-site.ts:258-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L258-L269)）
- `publishableImage` 用 realpath 确认目标仍在仓库内且是普通文件，否则返回 undefined（[scripts/project-doc-site.ts:284-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L284-L288)）
- `referencedImages` 以只收集不落盘的 `placeImage` 跑一遍改写，得到全部被引用的图片文件（[scripts/project-doc-site.ts:291-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L291-L311)）
- `docsSourceFiles` 返回全部页面源文件加被引用图片，作为开发服务器的监视集合（[scripts/project-doc-site.ts:319-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L319-L321)）
- `projectPagesInto` 对重复路由、不存在或非普通文件的源分别抛错（[scripts/project-doc-site.ts:375-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L375-L381)）
- `claim` 拒绝两个不同源投影到同一路径，也拒绝覆盖本次投影未认领的既有构建文件（[scripts/project-doc-site.ts:354-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L354-L373)）
- 页面输出路径先认领再放图片，图片按 basename 拷到页面同目录并返回 `encodeURI` 后的相对地址；非仓库内普通文件的图片引用抛错（[scripts/project-doc-site.ts:382-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L382-L415)）
- `projectDocs` 先递归删除 `website/.generated` 再整树重建（[scripts/project-doc-site.ts:420-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L420-L424)）
- `withoutFrontmatter` 剥掉开头的 YAML 块并吃掉其后空行，未闭合时抛错（[scripts/project-doc-site.ts:433-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L433-L441)）
- `indexAliasRoute` 把 `<dir>/index.md` 映射成父级别名 `<dir>.md`，根 index 无别名（[scripts/project-doc-site.ts:465-468](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L465-L468)）
- `rawMarkdownFiles` 列出所有路由加每个 index 路由的父级别名（[scripts/project-doc-site.ts:477-480](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L477-L480)）
- `emitRawMarkdownPages` 把每条路由与其别名以无 frontmatter、无仓库装饰的纯 Markdown 写进构建输出目录（[scripts/project-doc-site.ts:494-505](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L494-L505)）
- `rawMarkdownRoute` 为开发服务器按路由现算原始 Markdown，图片只改写地址不拷贝，路由不存在时返回 undefined（[scripts/project-doc-site.ts:517-530](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L517-L530)）
- `llmsTxt` 按固定 locale 顺序输出站点标题、描述、取用说明与逐页站点绝对链接（[scripts/project-doc-site.ts:543-575](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-doc-site.ts#L543-L575)）

### scripts/project-reference-faces.ts

校验 TypeScript Project Reference 图不会跨越 Host/Client 编译面进入错误叶子配置的门禁库。

- `WORKSPACE_MANIFESTS` 限定扫描 `packages/*/*`、`apps/*`、`vendor/*` 三类工作区清单（[scripts/project-reference-faces.ts:14-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L14-L18)）
- 遍历从根 `tsconfig.host.json` 与 `tsconfig.client.json` 两个入口出发，用 visited 集合避免重复访问（[scripts/project-reference-faces.ts:30-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L30-L39)）
- 引用进入已拆分项目而来源配置没有面归属时记一条违规并停止下潜（[scripts/project-reference-faces.ts:44-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L44-L49)）
- 引用目标不是与来源面同名的叶子配置时记一条违规并给出应改用的路径（[scripts/project-reference-faces.ts:50-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L50-L57)）
- 违规列表最终排序返回（[scripts/project-reference-faces.ts:62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L62)）
- `splitProjectRoots` 只收同时具备两个面配置的目录，并按路径长度降序排以便匹配最深者（[scripts/project-reference-faces.ts:65-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L65-L71)）
- `projectConfig` 用 `ts.readConfigFile` 读取，解析出错时抛出带仓库相对路径的错误（[scripts/project-reference-faces.ts:73-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L73-L80)）
- `projectFace` 先按文件名判面，再按根部两个 base 配置判面，否则沿本地 `extends` 链递归，带 seen 集合防环（[scripts/project-reference-faces.ts:88-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L88-L103)）
- `localExtendsConfig` 只跟随以 `.` 开头的相对 extends，并在缺后缀时补 `.json`（[scripts/project-reference-faces.ts:105-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L105-L109)）
- `referenceConfigPath` 把目录形式的引用补成其 `tsconfig.json`（[scripts/project-reference-faces.ts:111-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L111-L114)）
- `containingSplitRoot` 用相对路径判断目标配置是否落在某个拆分项目目录内（[scripts/project-reference-faces.ts:116-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/project-reference-faces.ts#L116-L121)）

### scripts/publication-payload.ts

发布产物路径策略的共享判定函数，被静态清单检查与打包 tarball 检查共用。

- `hasTypertRemoteNavigation` 逐层做类型与数组判定，只有 `exports["./remote"]` 精确指向那对 `lib/typert.remote-client.*` 文件时才为真（[scripts/publication-payload.ts:8-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publication-payload.ts#L8-L17)）
- `payloadPath` 把反斜杠、`./` 前缀、尾部斜杠与 npm tarball 的 `package/` 前缀统一归一（[scripts/publication-payload.ts:20-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publication-payload.ts#L20-L23)）
- `isForbiddenPublicationFile` 把 `src`、`src/` 下路径以及 `.d.ts.map`/`.js.map` 判为禁止发布（[scripts/publication-payload.ts:33-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publication-payload.ts#L33-L39)）
- `validateTarballPayload` 遇到禁止路径即抛错，并按源文件与 source map 区分错误措辞（[scripts/publication-payload.ts:46-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publication-payload.ts#L46-L55)）

### scripts/publint-all.ts

对每个工作区包按其清单声明的发布视图并发运行 publint，并额外检查发布视图内的相对导入闭包。

- `--packages-root` 参数决定扫描根，缺省为仓库根（[scripts/publint-all.ts:18-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L18-L22)）
- `workspacePackages` 按排序枚举 `packages/*/*/package.json` 并解析清单（[scripts/publint-all.ts:52-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L52-L60)）
- `publintConcurrency` 读取 `DSH_PUBLINT_CONCURRENCY`，非正整数字符串时抛错，未设置时用 `availableParallelism()`，并以包数封顶（[scripts/publint-all.ts:62-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L62-L75)）
- `publicationFiles` 由 `package.json` 加清单 `files` 与 README/LICENSE/CHANGELOG 等隐式模式构造发布视图，并读入字节（[scripts/publint-all.ts:77-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L77-L104)）
- `addPath` 对目录用 `readdirSync(recursive)` 展开而非 glob，以便包含点开头的文件（[scripts/publint-all.ts:106-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L106-L118)）
- `publicationClosureViolations` 只扫描发布视图内的 `.js`/`.mjs`/`.cjs`，把相对导入解析后与发布集合比对，缺失即记违规（[scripts/publint-all.ts:126-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L126-L144)）
- `resolutionCandidates` 枚举原路径以及补 `.js`/`.mjs`/`.cjs` 与 `/index.*` 的候选（[scripts/publint-all.ts:147-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L147-L153)）
- `relativeImports` 用 TypeScript AST 收集静态 import、re-export、动态 import 与 `require` 中以 `.` 开头的字面量及其行号（[scripts/publint-all.ts:156-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L156-L178)）
- `isBrowserBundleFormatFalsePositive` 只对 `lib/client.js`/`lib/worker.js` 或 `./client`/`./worker` 导出上的 `FILE_INVALID_FORMAT` 做抑制（[scripts/publint-all.ts:188-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L188-L194)）
- `runPublint` 以 `pkgDir: 'package'` 加内存文件列表调用 publint，过滤抑制项后按是否有 error 或闭包违规定状态；抛出的异常被收进 failed 结果（[scripts/publint-all.ts:196-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L196-L219)）
- `runAll` 用共享游标开 concurrency 个 worker 拉取任务，最后按输入顺序取回结果，缺结果时抛错（[scripts/publint-all.ts:221-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L221-L239)）
- `printResult` 把 failure 与闭包违规打到 stderr、publint 消息打到 stdout，全清时打印 `All good!`（[scripts/publint-all.ts:241-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L241-L251)）
- 顶层先打印包数与并发数，跑完逐条输出，任一包 failed 即 `process.exit(1)`（[scripts/publint-all.ts:253-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publint-all.ts#L253-L260)）

### scripts/publish-npm-baseline.ts

一个命令行脚本，把某个提交的整个 npm 工作区打包、发布到注册表并校验；由 `pnpm exec tsx scripts/publish-npm-baseline.ts <pack|release|publish|verify>` 调用。

- 常量固定默认注册表、默认产物目录、参与打包的清单 glob（`vendor/*`、`packages/!(experimental)/*`、`apps/*`）、被改写的依赖节、清单文件名、取 `latest` 标签的入口包（[scripts/publish-npm-baseline.ts:23-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L23-L38)）
- 内嵌 Python 探针在 pty 中 fork 出 `node <bin> web --no-open --host 127.0.0.1 --port 0`，读输出直到出现 `dsh web: http://127.0.0.1:` 后发 SIGTERM，超时则 SIGKILL，未就绪退出 124、子进程非零退出 125（[scripts/publish-npm-baseline.ts:39-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L39-L86)）
- 打包计划把提交、时间戳、版本、dist-tag、注册表、输出目录打印到标准输出，非 `--yes` 时等待回车，输入任何内容即取消（[scripts/publish-npm-baseline.ts:138-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L138-L152)）
- `CommandRunner.run` 以继承 stdio 直接 spawn 且非零状态抛错，`capture`/`result` 以 utf8 捕获且 maxBuffer 为 16MB（[scripts/publish-npm-baseline.ts:156-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L156-L200)）
- `DetachedWorktree.create` 在临时目录里 `git worktree add --detach <commit>`，创建失败时删除临时根（[scripts/publish-npm-baseline.ts:211-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L211-L221)）
- `dispose` 执行 `git worktree remove --force` 并删除临时根，移除失败只打印到 stderr 而不抛错（[scripts/publish-npm-baseline.ts:223-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L223-L234)）
- `WorkspacePackageSet.discover` 按 glob 收集清单，要求根 `package.json` 版本为 X.Y.Z，要求每个包名以 `@deepseek-ai/` 开头、拒绝工作区根包与重名，非 vendor 包版本必须等于根版本（[scripts/publish-npm-baseline.ts:244-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L244-L282)）
- `stage` 把每个清单的 `version` 改写为发布版本、删除 `private` 字段、把指向内部包的依赖范围钉成该版本并回写文件（[scripts/publish-npm-baseline.ts:284-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L284-L294)）
- `ReleaseBundle.create` 遍历目录里的 `.tgz`：拒绝多余或重复的包、对 harness 来源校验 tarball 内容清单、比对版本、拒绝仍为 private 的包、拒绝残留 `workspace:` 依赖、校验内部依赖钉版，并要求所有期望包都有 tarball（[scripts/publish-npm-baseline.ts:304-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L304-L342)）
- 校验通过后写出 `manifest.json`（schemaVersion 1、提交、版本、dist-tag、注册表、包列表）与 `SHA256SUMS` 两个文件（[scripts/publish-npm-baseline.ts:343-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L343-L356)）
- `ReleaseBundle.load` 要求 schemaVersion 为 1、包列表非空且不重名，注册表经归一化后构造清单并立即做本地校验（[scripts/publish-npm-baseline.ts:359-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L359-L387)）
- `verifyLocal` 拒绝绝对路径或带目录成分的 tarball 路径，重算 sha256/integrity 与清单比对，并重新检查身份、private、`workspace:` 与内部依赖钉版（[scripts/publish-npm-baseline.ts:389-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L389-L418)）
- `InstalledBundleSmoke.run` 在临时消费者目录写出以 `file:` URL 指向各 tarball 的 `package.json`，执行 `npm install --no-audit --no-fund --package-lock=false --registry=…`，断言 bin 路径落在该目录内，运行 `--version` 并与清单版本比对，最后删除该目录（[scripts/publish-npm-baseline.ts:432-477](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L432-L477)）
- `probeWeb` 在 win32 上直接抛错，否则用 `python3 -c` 运行内嵌探针并把非零状态转成错误（[scripts/publish-npm-baseline.ts:479-492](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L479-L492)）
- `plan` 用 `git rev-parse` 解析提交与短哈希、用 `git show <commit>:package.json` 读基线版本，合成 `<base>-<UTC 时间戳>-<短哈希>` 版本与 `dev-<base>` dist-tag，并在产物目录已存在时抛错（[scripts/publish-npm-baseline.ts:503-539](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L503-L539)）
- `pack` 在分离工作树中依次执行 `pnpm install --frozen-lockfile`、`pnpm run constraints`、改写清单、`pnpm run build`、`publint`、`verify-built-package-invariants`、`pnpm --filter … --recursive pack --pack-destination`（[scripts/publish-npm-baseline.ts:541-577](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L541-L577)）
- 打包收尾组装并冒烟验证 bundle，打印版本、dist-tag、清单路径与可复制的 publish 命令；`finally` 里销毁工作树，失败时删除已创建的产物目录（[scripts/publish-npm-baseline.ts:579-612](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L579-L612)）
- `RegistryPublication` 的 npm 调用统一在 `tmpdir()` 下、使用剥掉 npm user-agent 的环境（[scripts/publish-npm-baseline.ts:617-618](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L617-L618)）
- `publish` 先 ping 注册表并要求身份，再逐包判断：远端缺失则 `npm publish --tag=<dist-tag>`，已存在且 integrity 不同则抛错，相同则跳过，随后确保 dist-tag、给入口包打 `latest`、做远端校验（[scripts/publish-npm-baseline.ts:625-654](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L625-L654)）
- `verify` 只做 ping、远端逐包校验与入口包 `latest` 校验，不写注册表（[scripts/publish-npm-baseline.ts:656-660](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L656-L660)）
- `verifyRemote` 要求每个包在注册表存在、integrity 一致且 dist-tag 指向本次版本，并逐包打印验证行（[scripts/publish-npm-baseline.ts:662-684](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L662-L684)）
- `verifyReleaseEntryDistTag` 要求入口包的 `latest` 指向本次版本（[scripts/publish-npm-baseline.ts:686-698](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L686-L698)）
- `pingRegistry` 执行 `npm ping`，`requireIdentity` 执行 `npm whoami` 并打印身份（[scripts/publish-npm-baseline.ts:700-713](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L700-L713)）
- 发布前的确认同样要求交互式终端，回车继续、其他输入取消（[scripts/publish-npm-baseline.ts:715-723](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L715-L723)）
- `remoteIntegrity` 用 `npm view … dist.integrity --json`，把 E404/NOT_FOUND 归为「不存在」，其他失败抛错，返回值必须以 `sha512-` 开头（[scripts/publish-npm-baseline.ts:725-742](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L725-L742)）
- `remoteDistTag` 读 `npm dist-tag ls`，`ensureDistTag` 在指向不符时执行 `npm dist-tag add`（[scripts/publish-npm-baseline.ts:744-764](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L744-L764)）
- `inspectTarball` 用 `tar -xOf … package/package.json` 读清单、用 `tar -tf` 列出全部条目（[scripts/publish-npm-baseline.ts:775-787](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L775-L787)）
- `packedPackage` 读取 tarball 字节，算出十六进制 sha256 与 `sha512-<base64>` 形式的 integrity（[scripts/publish-npm-baseline.ts:789-798](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L789-L798)）
- `parsePackedPackage` 把缺省 origin 视作 `harness`、拒绝未知 origin，并对 harness 项校验包名前缀与非工作区根（[scripts/publish-npm-baseline.ts:800-818](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L800-L818)）
- `containsWorkspaceProtocol` 在字符串、数组、对象上递归查找 `workspace:` 前缀（[scripts/publish-npm-baseline.ts:820-824](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L820-L824)）
- `stageInternalDependencies` 与 `validateInternalDependencyPins` 分别改写与断言内部依赖范围，`internalDependencyEntries` 遍历四个依赖节并要求它们是对象（[scripts/publish-npm-baseline.ts:826-872](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L826-L872)）
- `normalizeRegistry` 只接受 http/https 并去掉尾部斜杠（[scripts/publish-npm-baseline.ts:896-902](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L896-L902)）
- `npmClientEnvironment` 从子进程环境中删除 `npm_config_user_agent` 与 `NPM_CONFIG_USER_AGENT`（[scripts/publish-npm-baseline.ts:904-909](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L904-L909)）
- `installedArtifactEnvironment` 删除 `NODE_OPTIONS`/`NODE_PATH`/`COLORTERM`，并设定 `DSH_HOME`、`DSH_AGENTS_HOME`、遥测关闭、占位 API key、语言与 `TERM`/`COLUMNS`/`LINES`（[scripts/publish-npm-baseline.ts:911-927](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L911-L927)）
- `assertPathWithin` 用 `realpathSync.native` 比较相对路径，逃出根目录即抛错（[scripts/publish-npm-baseline.ts:929-936](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L929-L936)）
- `validateDistTag` 拒绝空串与含空白的标签，`validateBaseVersion` 要求 X.Y.Z（[scripts/publish-npm-baseline.ts:938-946](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L938-L946)）
- `parseDistTagListing` 按 `<tag>: <version>` 逐行解析，格式非法或标签重复即抛错（[scripts/publish-npm-baseline.ts:948-961](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L948-L961)）
- `confirmEnter` 在 stdin 或 stdout 非 TTY 时抛出非交互错误，否则读一行并在非空时抛出取消错误（[scripts/publish-npm-baseline.ts:963-976](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L963-L976)）
- `formatUtcTimestamp` 把 ISO 时间戳去掉分隔符后截前 14 位（[scripts/publish-npm-baseline.ts:978-981](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L978-L981)）
- `commandFailure` 把子进程 stdout/stderr 拼进错误消息，`formatCopyableCommand`/`quoteShellArgument` 生成可复制的 shell 命令行（[scripts/publish-npm-baseline.ts:983-1003](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L983-L1003)）
- `printUsage` 输出四个子命令与选项默认值（[scripts/publish-npm-baseline.ts:1005-1017](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L1005-L1017)）
- `main` 在无子命令或带 `--help`/`-h` 时只打用法，其余用 `git rev-parse --show-toplevel` 定位仓库根（[scripts/publish-npm-baseline.ts:1019-1030](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L1019-L1030)）
- `pack`/`release` 以 strict `parseArgs` 解析 `--ref`/`--registry`/`--output-dir`/`--yes`，先确认再打包，`release` 额外接着发布（[scripts/publish-npm-baseline.ts:1032-1055](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L1032-L1055)）
- `publish`/`verify` 要求 `--manifest`、拒绝 `verify --yes`，加载 bundle 后分别发布或只校验；未知子命令抛错（[scripts/publish-npm-baseline.ts:1057-1075](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L1057-L1075)）
- 顶层 `try/catch` 把任何错误打到 stderr 并把进程退出码设为 1（[scripts/publish-npm-baseline.ts:1078-1083](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/publish-npm-baseline.ts#L1078-L1083)）

### scripts/release/bump.ts

发布流程的版本提升脚本，改写清单版本、更新锁文件并提交；由 `release:dsh` / `release:vendor` 包脚本以 `--family` 调用。

- `releaseNumbers` 用正则拆出主次修订号并丢弃预发布段，不匹配即抛错（[scripts/release/bump.ts:66-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L66-L70)）
- `compareReleaseNumbers` 只按三段数字排序，`prereleaseOf` 取首个 `-` 之后的内容（[scripts/release/bump.ts:78-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L78-L92)）
- `compareVersions` 按 semver 优先级排序：有预发布段者低于同号正式版，标识符逐字段比较，纯数字段按数值比、数字段低于字母数字段、字段更少者更低（[scripts/release/bump.ts:105-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L105-L131)）
- `nextSharedVersion` 接受 `major`/`minor`/`patch` 或显式 `x.y.z`（含预发布），其余输入抛出用法错误（[scripts/release/bump.ts:139-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L139-L150)）
- `nextVendorVersion` 取清单版本与最新 tag 版本中较高者作基线，tag 为预发布且领先或同号时复用数字，否则修订号加一，并可追加预发布标识（[scripts/release/bump.ts:168-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L168-L186)）
- `reachesPayload` 用 `files` 选择、npm 必发文件集，以及在 `files` 含 `lib` 时追加的构建输入 glob，判断一个仓库路径是否影响已发布载荷（[scripts/release/bump.ts:194-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L194-L202)）
- `lastTaggedVersion` 用 `git tag --list <prefix>*` 列出 tag、截掉前缀后按 semver 取最大（[scripts/release/bump.ts:210-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L210-L216)）
- `writeVersion` 以文本替换改写 `"version": "<from>"`，找不到该行即抛错（[scripts/release/bump.ts:225-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L225-L231)）
- `rootVersion` 读工作区根清单版本并要求是字符串（[scripts/release/bump.ts:238-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L238-L243)）
- `privateDshVersions` 遍历 `packages/*/*/package.json`，只保留 `private: true` 的清单，非 JSON 对象或无字符串版本即抛错（[scripts/release/bump.ts:251-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L251-L271)）
- `planShared` 为 dsh 家族生成一份共享版本计划：根清单、每个可发布成员（带 tag）、以及不在发布集合中的私有包清单（[scripts/release/bump.ts:282-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L282-L317)）
- `planPerPackage` 为 vendor 家族逐包计算下一个版本与各自的 tag（[scripts/release/bump.ts:327-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L327-L345)）
- `main` 解析 `--family`/`--prerelease`/`--dry-run` 与位置参数，缺 `--family` 抛用法错，先取家族成员并校验版本基线（[scripts/release/bump.ts:352-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L352-L366)）
- dsh 家族要求一个位置版本参数且拒绝 `--prerelease`，vendor 家族拒绝位置参数并要求 `--prerelease` 是合法 semver 预发布标识（[scripts/release/bump.ts:368-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L368-L385)）
- 非 dry-run 时逐个改写清单并执行 `pnpm install --lockfile-only`，随后打印家族摘要与逐项版本迁移（[scripts/release/bump.ts:387-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L387-L401)）
- 非 dry-run 收尾执行 `git add` 锁文件与全部清单、`git commit -m "release(<family>): <summary>"`，并打印去重后的建议打 tag 命令（[scripts/release/bump.ts:403-412](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L403-L412)）
- 只有当本模块是进程入口时才运行 `main`（[scripts/release/bump.ts:415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/bump.ts#L415)）

### scripts/release/families.ts

定义发布家族（`dsh` 与 `vendor`）的成员发现、发布顺序、版本基线、tag 命名与载荷校验；被 bump/pack/publish/verify/verify-packed-install 共同引用。

- 常量固定参与排序的安装依赖节、peer 依赖节，以及永不作为发布成员的工作区根包名（[scripts/release/families.ts:25-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L25-L37)）
- `readManifest` 要求解析结果是 JSON 对象，`requireString` 要求字段为非空字符串（[scripts/release/families.ts:72-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L72-L91)）
- 基类 `verifyBuildArtifacts` 默认接受任何构建树（[scripts/release/families.ts:115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L115)）
- `members` 按家族 glob 收集清单并排序，零匹配抛错，逐个校验名字非工作区根、以 `@deepseek-ai/` 开头且不重复（[scripts/release/families.ts:122-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L122-L145)）
- `publishOrder` 先在仅含安装依赖的图上做 DFS 环检测，发现环即抛出带路径的错误（[scripts/release/families.ts:169-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L169-L184)）
- 随后在安装边加 peer 边上做 DFS 产出顺序：当 peer 的安装闭包反过来包含本成员、或 peer 已在栈上时丢弃该 peer 边并记录（[scripts/release/families.ts:191-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L191-L228)）
- 输出顺序还要通过后置检查：任一安装依赖未排在消费者之前即抛错（[scripts/release/families.ts:236-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L236-L247)）
- `orderEdges` 从指定依赖节里挑出属于本家族的成员、排除自指并按名排序（[scripts/release/families.ts:257-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L257-L272)）
- `tagFor` 把成员的 tag 前缀与版本拼成完整 tag 名（[scripts/release/families.ts:293-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L293-L295)）
- `DshFamily` 固定 id、清单 glob（`packages/!(experimental)/*` 与 `apps/*`）与 tag 前缀 `dsh-v`（[scripts/release/families.ts:313-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L313-L315)）
- `DshFamily.verifyBuildArtifacts` 以官方客户端构建环境读取构建记录（[scripts/release/families.ts:318-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L318-L320)）
- `DshFamily.verifyVersions` 要求全家族同一版本，否则列出每个目录的版本抛错（[scripts/release/families.ts:326-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L326-L332)）
- `DshFamily` 所有成员共用一个 tag 前缀，载荷交给 `validateTarballPayload` 校验，安装入口固定为 `@deepseek-ai/dsh` 的 `lib/bin.js`（[scripts/release/families.ts:338-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L338-L351)）
- `VendorFamily` 固定 id、`vendor/*/package.json` glob 与 `vendor-` tag 前缀（[scripts/release/families.ts:356-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L356-L358)）
- `VendorFamily.verifyVersions` 允许各自版本，只拒绝不符合 semver 形状的版本（[scripts/release/families.ts:364-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L364-L370)）
- `VendorFamily` 按去掉 scope 的包名生成逐包 tag 前缀，载荷只要求 tarball 非空，且没有安装入口探针（[scripts/release/families.ts:377-398](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L377-L398)）
- `releaseFamilies` 固定家族清单与顺序，`releaseFamily` 按 id 查找并在未知时列出可选值抛错（[scripts/release/families.ts:402-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L402-L418)）
- `tarballName` 按 `pnpm pack` 的命名规则由包名与版本合成 `.tgz` 文件名（[scripts/release/families.ts:425-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/families.ts#L425-L428)）

### scripts/release/pack.ts

发布流程的打包步骤，把一个家族的全部成员按发布顺序打进一个目录并记录该顺序；由发布工作流以 `--family` 调用。

- `DEFAULT_OUTPUT` 决定省略 `--out` 时的输出目录（[scripts/release/pack.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/pack.ts#L18)）
- `packMember` 执行 `pnpm --dir <目录> pack --pack-destination <目标>`，产物缺失即抛错，并用家族规则校验 tarball 内容清单（[scripts/release/pack.ts:27-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/pack.ts#L27-L35)）
- `parseConcurrency` 缺省为 1，并拒绝非正整数或非规范写法的 `--concurrency`（[scripts/release/pack.ts:41-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/pack.ts#L41-L48)）
- `main` 要求 `--family`，解析出目标目录，先算发布顺序再校验构建产物与版本基线（[scripts/release/pack.ts:51-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/pack.ts#L51-L64)）
- 打包前递归删除并重建目标目录（[scripts/release/pack.ts:66-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/pack.ts#L66-L67)）
- 成员在有界并发池中打包，每个 worker 把结果写回成员自身下标，因此记录的顺序与完成顺序无关（[scripts/release/pack.ts:72-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/pack.ts#L72-L82)）
- 把 tarball 文件名按顺序写入 `publish-order.txt` 并打印数量与目录（[scripts/release/pack.ts:83-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/pack.ts#L83-L85)）
- 只有当本模块是进程入口时才运行 `main`（[scripts/release/pack.ts:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/pack.ts#L88)）

### scripts/release/process.ts

发布脚本共用的子进程封装，提供三种失败处理方式与入口判定；被 bump/pack/publish/verify/tarball 等模块引用。

- `attempt` 同步 spawn 并捕获输出，不判定退出状态，spawn 自身出错则抛出（[scripts/release/process.ts:31-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/process.ts#L31-L35)）
- `attemptEchoed` 继承 stdin、缓冲捕获 stdout/stderr，退出后先回显 stdout 再回显 stderr 并返回两者（[scripts/release/process.ts:45-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/process.ts#L45-L56)）
- `capture` 在非零退出时把命令、状态与两路输出拼成错误抛出，否则返回去空白的 stdout（[scripts/release/process.ts:65-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/process.ts#L65-L71)）
- `runConcurrent` 以继承 stdio 异步 spawn，`close` 状态非 0 时按状态或信号 reject（[scripts/release/process.ts:82-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/process.ts#L82-L91)）
- `isEntry` 用 realpath 比较 `process.argv[1]` 与调用模块 URL，决定脚本是否作为入口执行（[scripts/release/process.ts:98-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/process.ts#L98-L102)）

### scripts/release/publish.ts

发布流程的上传步骤，从打包目录按记录的顺序把 tarball 逐个发到注册表；由发布工作流以 `--family` 与 `--from` 调用。

- 常量固定被视为「未落定的写入」的注册表错误码集合、单个 tarball 的最大尝试次数 4、以及两次发布之间与首次退避的 2000ms 间隔（[scripts/release/publish.ts:31-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L31-L42)）
- `isTransientFailure` 在 npm 合并输出里查找 `code <CODE>` 判定是否可重试（[scripts/release/publish.ts:54-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L54-L56)）
- `integrityOf` 读取 tarball 字节算出 `sha512-<base64>`（[scripts/release/publish.ts:63-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L63-L65)）
- `registryState` 用 `npm view … dist.integrity --json` 查询，E404/404 归为不存在，其他失败抛错，空或非字符串结果抛错（[scripts/release/publish.ts:73-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L73-L85)）
- `publishTarball` 对含 `-` 的版本追加 `--tag next`，不传 `--access`，由打包后的清单自身决定（[scripts/release/publish.ts:97-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L97-L105)）
- 每次失败后重查注册表，若该版本已以相同 integrity 存在则视为成功返回；否则在达最大次数或非可重试错误时抛错，其余按 2 的幂退避后重试（[scripts/release/publish.ts:106-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L106-L123)）
- `main` 要求 `--family` 与 `--from`，从打包目录读出发布顺序并维护已发布/已跳过计数（[scripts/release/publish.ts:127-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L127-L145)）
- 逐项按 tarball 自身声明的名字与版本查询注册表：已存在且 integrity 不同则抛错终止，相同则跳过并计数（[scripts/release/publish.ts:146-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L146-L163)）
- 只有在已经发生过发布之后才在下一次发布前等待间隔，随后发布并打印带序号的进度（[scripts/release/publish.ts:164-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L164-L175)）
- 只有当本模块是进程入口时才运行 `main`（[scripts/release/publish.ts:178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/publish.ts#L178)）

### scripts/release/tarball.ts

读取打包产物与其顺序文件的共用函数；被 pack、publish 与 verify-packed-install 引用。

- `PUBLISH_ORDER_FILE` 固定顺序文件名为 `publish-order.txt`（[scripts/release/tarball.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/tarball.ts#L14)）
- `tarballFiles` 用 `tar -tzf` 列出归档内全部路径并去掉空行（[scripts/release/tarball.ts:29-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/tarball.ts#L29-L31)）
- `packedIdentity` 用 `tar -xOzf … package/package.json` 读出打包后的清单，非对象或缺 name/version 即抛错（[scripts/release/tarball.ts:38-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/tarball.ts#L38-L44)）
- `readPublishOrder` 读顺序文件并按行返回 tarball 文件名（[scripts/release/tarball.ts:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/tarball.ts#L51-L53)）

### scripts/release/verify-packed-install.ts

把打包产物安装进仓库之外的临时消费者并驱动安装后的可执行入口；由发布工作流以 `--family` 与一个或多个 `--from` 调用。

- `consumerEnvironment` 删除 npm user-agent、`NODE_OPTIONS`、`NODE_PATH`，并把 `DSH_HOME`、`DSH_AGENTS_HOME` 指向临时目录、关闭遥测（[scripts/release/verify-packed-install.ts:34-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify-packed-install.ts#L34-L44)）
- `packedDependencies` 按目录内容而非顺序文件收集全部 `.tgz`，空目录抛错，读出每个包的名字与版本并映射到 `file:` URL（[scripts/release/verify-packed-install.ts:55-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify-packed-install.ts#L55-L67)）
- `main` 要求 `--family` 与至少一个 `--from`，家族无安装入口时打印一行后直接返回（[scripts/release/verify-packed-install.ts:70-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify-packed-install.ts#L70-L84)）
- 入口包不在打包产物中即抛错（[scripts/release/verify-packed-install.ts:86-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify-packed-install.ts#L86-L89)）
- 在临时目录写出以全部 tarball 为依赖的私有 `package.json`，执行 `npm install --no-audit --no-fund --package-lock=false --omit=optional`（[scripts/release/verify-packed-install.ts:91-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify-packed-install.ts#L91-L108)）
- 用当前 Node 执行安装后的 bin `--version` 并与打包版本比对，不符即抛错；`finally` 递归删除临时消费者目录（[scripts/release/verify-packed-install.ts:110-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify-packed-install.ts#L110-L118)）
- 只有当本模块是进程入口时才运行 `main`（[scripts/release/verify-packed-install.ts:121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify-packed-install.ts#L121)）

### scripts/release/verify.ts

发布流程的前置校验步骤，检查版本基线、解析并打印发布顺序，并在发布模式下检查可发布性与 tag；由发布工作流以 `--family` 调用。

- `reportPublishOrder` 把发布顺序逐行编号打印，并在有被丢弃的 peer 边时打印其数量与每条 `consumer -> peer`（[scripts/release/verify.ts:25-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify.ts#L25-L38)）
- `verifyPublishable` 列出仍带 `private: true` 的成员目录并抛错（[scripts/release/verify.ts:44-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify.ts#L44-L49)）
- `verifyTag` 要求 ref 以 `refs/tags/` 开头、tag 带本家族前缀，且与某个成员按当前版本推导出的 tag 完全一致（[scripts/release/verify.ts:58-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify.ts#L58-L71)）
- `main` 要求 `--family`，取成员并校验版本基线（[scripts/release/verify.ts:74-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify.ts#L74-L83)）
- 在构建之前解析发布顺序，覆盖成员数不足即抛错，然后打印顺序（[scripts/release/verify.ts:84-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify.ts#L84-L93)）
- 环境变量 `RELEASE_PUBLISH === 'true'` 时额外执行可发布性与 tag 门禁，tag 取自 `GITHUB_REF`（[scripts/release/verify.ts:95-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify.ts#L95-L99)）
- 收尾打印家族名、成员数、版本摘要、未排序 peer 声明数，并在发布模式下追加门禁通过字样（[scripts/release/verify.ts:101-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify.ts#L101-L107)）
- 只有当本模块是进程入口时才运行 `main`（[scripts/release/verify.ts:110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/release/verify.ts#L110)）

### scripts/repo-files.ts

仓库文件发现与逐行引用扫描的共用函数；被各类文档与引用检查脚本引用。

- `isArchivedAgentNotePath` 把路径分隔符归一后判断是否位于 `.agents/notes/archived/` 之下（[scripts/repo-files.ts:25-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/repo-files.ts#L25-L27)）
- `uniqueRepoFiles` 按给定顺序展开 glob、应用排除谓词，并用 realpath 去重符号链接，返回首次出现顺序的稳定列表（[scripts/repo-files.ts:36-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/repo-files.ts#L36-L55)）
- `findReferenceViolations` 逐行独立匹配全局正则、把原始文本交给归一函数、由谓词判定是否违规，并记录仓库相对路径与 1 基行号（[scripts/repo-files.ts:67-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/repo-files.ts#L67-L86)）

### scripts/rescope-vendor.ts

一个 codemod 脚本，把 vendor 目录里的上游包名改写进 `@deepseek-ai` scope（`--reverse` 可反向），并提供 `--check` 断言改写后的状态；由 `pnpm run rescope-vendor` 调用。

- `root` 由脚本自身目录上溯一级得到，决定后续所有相对路径的解析基准（[scripts/rescope-vendor.ts:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L36)）
- `RENAMES` 固定九个 vendor 目录的上游名到 scope 名映射，是整个改写的唯一数据源（[scripts/rescope-vendor.ts:46-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L46-L56)）
- `EXTENSIONS` 限定通用改写只覆盖的文件后缀（[scripts/rescope-vendor.ts:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L58)）
- `GENERIC_SKIPS` 逐文件列出要对特定上游名关闭通用改写的位置，覆盖 preset id、事件域名、目录名与上游运行期标识等（[scripts/rescope-vendor.ts:79-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L79-L135)）
- `POSTCONDITIONS` 列出改写后必须在指定文件里出现精确次数的字符串，含要求出现 0 次的两项（[scripts/rescope-vendor.ts:144-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L144-L163)）
- `EXACT_EDITS` 列出通用规则无法表达的精确替换及其要求命中次数，按应用顺序排列，`find` 均写成改写前形态（[scripts/rescope-vendor.ts:170-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L170-L444)）
- 清单表格的每一行由 `RENAMES` 展开成一条精确编辑，插入新的上游名列（[scripts/rescope-vendor.ts:445-452](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L445-L452)）
- `excluded` 排除脚本自身、`.agents/notes/`、`scripts/snapshots/`、映射文档、`.i18n.yaml`、锁文件、vendor 的上游 README/LICENSE，以及所有非白名单后缀的文件（[scripts/rescope-vendor.ts:456-468](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L456-L468)）
- `patterns` 按名字长度从长到短排序，为每个改写编译带引号（可带 `/subpath`）的 token 正则与 YAML `name:` 标量正则（[scripts/rescope-vendor.ts:483-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L483-L496)）
- `skipped` 按文件与上游名查 `GENERIC_SKIPS`，`rewriteLine` 依次对未跳过的模式做 token 与 YAML 两种替换（[scripts/rescope-vendor.ts:498-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L498-L510)）
- `rewrite` 对 Markdown 用 ``` 行切换围栏状态：围栏内始终改写，围栏外只在 `docs/` 下的散文里改写，并统计被改动的行数（[scripts/rescope-vendor.ts:523-541](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L523-L541)）
- `classify` 按路径把改动归入 vendor 清单名、依赖、代码说明符、YAML 插件名、JSON 配置或 Markdown 六类，决定汇总输出的分行（[scripts/rescope-vendor.ts:543-550](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L543-L550)）
- `exactEditState` 按 `replace` 含 `find`（插入）、`find` 含 `replace`（删除）和两者互不含三种情况分别计数，判定 pending / applied / invalid（[scripts/rescope-vendor.ts:572-585](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L572-L585)）
- `main` 从 argv 取模式（`--apply` / `--check` / 默认 dry）与 `--reverse`，用 `git ls-files -z` 取跟踪文件并按 `excluded` 过滤（[scripts/rescope-vendor.ts:588-594](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L588-L594)）
- 写任何文件之前先分类全部精确编辑：invalid 记为失败，check 模式下非 applied 也记为失败，只有 pending 才进入待写列表（[scripts/rescope-vendor.ts:600-619](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L600-L619)）
- 只要存在失败就打印全部问题、把退出码设为 1 并直接返回，不写任何文件（[scripts/rescope-vendor.ts:620-625](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L620-L625)）
- apply 模式逐条精确编辑时重新读取文件再写回，使同一文件的多条编辑互不覆盖（[scripts/rescope-vendor.ts:626-632](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L626-L632)）
- 通用改写遍历每个文件，内容有变化时记入残留列表与分类计数，apply 模式下写回磁盘（[scripts/rescope-vendor.ts:634-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L634-L644)）
- 打印模式、是否 reverse、扫描文件总数，以及每个分类的文件数与行数（[scripts/rescope-vendor.ts:646-650](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L646-L650)）
- 非 dry 模式检查后置条件（reverse 时跳过），文件缺失记作 -1 次；check 模式再把每个仍会变化的文件记为残留失败（[scripts/rescope-vendor.ts:652-666](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L652-L666)）
- 收尾：有失败则逐条打印并置退出码 1，check 通过打印已验证，apply 完成打印后续需要执行的三条命令（[scripts/rescope-vendor.ts:668-676](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L668-L676)）
- 用 realpath 比较 `process.argv[1]` 与本模块路径，仅作为入口时才运行 codemod，被导入时不执行（[scripts/rescope-vendor.ts:680-682](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/rescope-vendor.ts#L680-L682)）

### scripts/run-coverage-partitions.ts

分区覆盖率测试的命令行入口，读环境变量后驱动分区协调器；由 pnpm 包脚本调用。

- 从环境变量解析分区数，缺失即抛错（[scripts/run-coverage-partitions.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/run-coverage-partitions.ts#L12-L15)）
- 要求 `npm_execpath` 存在且非空，否则拒绝运行，从而只允许经 pnpm 包脚本调用（[scripts/run-coverage-partitions.ts:16-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/run-coverage-partitions.ts#L16-L19)）
- 用仓库根、分区数、pnpm 入口以及由超时环境变量与转发的命令行参数拼出的 vitest 参数构造协调器（[scripts/run-coverage-partitions.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/run-coverage-partitions.ts#L21-L29)）
- 顶层 await 协调器运行结果并把它设为进程退出码（[scripts/run-coverage-partitions.ts:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/scripts/run-coverage-partitions.ts#L30)）
