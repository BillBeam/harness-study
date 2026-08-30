---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/fs/tool-fs-search
---

# packages/fs/tool-fs-search

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、99 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/fs/tool-fs-search/README.md

该包的说明文档，描述 glob/grep 两个工具的组合方式、配置项、失败码与模型可见文本，供使用者与维护者阅读。

- 无运行期机制

### packages/fs/tool-fs-search/package.json

该包的 npm 清单，声明入口、导出映射、发布文件集与依赖。

- `main`/`types` 与 `exports` 决定运行期可被解析的入口：根导出指向 `lib/index.js`，`./invariant` 指向 `lib/invariant.js`，另开放 `./src/*` 与 `./package.json`（[packages/fs/tool-fs-search/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/package.json#L14-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/fs/tool-fs-search/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/package.json#L28-L32)）
- 运行期依赖 `@vscode/ripgrep`，搜索所用的 ripgrep 可执行文件随该依赖一起安装（[packages/fs/tool-fs-search/package.json:34-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/package.json#L34-L37)）

### packages/fs/tool-fs-search/src/direct-call.ts

一个共享判定函数，供 glob 与 grep 的 `tools/post-execute` 钩子判断是否可以对本次调用结果做溢出落盘改写。

- 仅当下游决策是未改写内容与值的 `accept`、执行无父级、工具名与本定义一致、结果非错误、且注册表当前解析到的仍是同一个工具定义时，才返回规范结果值，否则返回 `undefined`（[packages/fs/tool-fs-search/src/direct-call.ts:23-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/direct-call.ts#L23-L26)）

### packages/fs/tool-fs-search/src/glob.ts

`glob` 工具的实现文件：模型可见 schema、参数校验、ripgrep argv 构造、结果解析、超额采样与文本渲染，由包入口 `applyGlobTool` 装配。

- 内联路径条数默认上限常量 `GLOB_MAX_RESULTS = 100`（[packages/fs/tool-fs-search/src/glob.ts:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L26)）
- 固定的版本控制元数据目录名列表，决定哪些目录永远不出现在结果中（[packages/fs/tool-fs-search/src/glob.ts:38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L38)）
- `parseGlobArgs` 拒绝空白 `pattern` 与给定但空白的 `path`，抛普通 `Error` 作为参数错误（[packages/fs/tool-fs-search/src/glob.ts:72-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L72-L76)）
- argv 固定为 `--files --glob=<pattern> --sort=modified --no-ignore --hidden`，使结果按修改时间排序并包含隐藏与被忽略文件（[packages/fs/tool-fs-search/src/glob.ts:91-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L91-L96)）
- 每个版本控制目录名追加两条取反 `--glob`：裸形式在遍历时剪枝，`/**` 形式在搜索根位于该目录内时排除内容（[packages/fs/tool-fs-search/src/glob.ts:101-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L101-L104)）
- 搜索根放在 `--` 之后，使以短横线开头的路径不会被解析成标志（[packages/fs/tool-fs-search/src/glob.ts:106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L106)）
- `relativeToSearchRoot` 去掉展示用搜索根前缀后再选分组键（[packages/fs/tool-fs-search/src/glob.ts:124-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L124-L135)）
- `topLevelSegment` 先剥掉前导分隔符再取首段，使工作目录之外的绝对路径按首个真实名称分组而非并入同一空组（[packages/fs/tool-fs-search/src/glob.ts:152-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L152-L156)）
- `sampleAcrossTopLevel` 按顶层条目分组后轮转取样，每组先各取一条再取第二条，取满 `maxItems` 为止，并返回覆盖到的顶层条目数与总数（[packages/fs/tool-fs-search/src/glob.ts:171-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L171-L203)）
- `formatGlobOutput` 在采样确实跨多个顶层条目时把采样依据与"缩小 path"提示写进页脚，否则用普通页脚（[packages/fs/tool-fs-search/src/glob.ts:214-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L214-L220)）
- `formatGlobPage` 在页脚给出"已展示 N/总数"与落盘定位符加取回提示，落盘缺失时改写为"完整结果未能保存"（[packages/fs/tool-fs-search/src/glob.ts:223-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L223-L229)）
- `renderGlobPaths` 空结果返回 `No files found`，未超额时原样全量返回，超额时按 `sampleOverCapGlobResults` 选择"修改时间序头部"或"顶层采样页"（[packages/fs/tool-fs-search/src/glob.ts:232-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L232-L241)）
- `globCardPage` 用与文本渲染相同的规则算出卡片内联页与截断标志（[packages/fs/tool-fs-search/src/glob.ts:255-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L255-L259)）
- `presentGlobCall` 以 pattern 与可选 path 组成调用中卡片标题，`kind: 'search'`（[packages/fs/tool-fs-search/src/glob.ts:267-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L267-L270)）
- `presentGlobResult` 对错误结果与非 `paths` 形状的元数据返回 `undefined`，回落到通用卡片（[packages/fs/tool-fs-search/src/glob.ts:283-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L283-L288)）
- 注册系统提示段落 `tool:glob`，其超额部分文案随 `sampleOverCapGlobResults` 二选一（[packages/fs/tool-fs-search/src/glob.ts:298-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L298-L306)）
- 工具描述把配置的上限数值与超额行为写进模型可见文本（[packages/fs/tool-fs-search/src/glob.ts:308-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L308-L316)）
- 参数表声明必填 `pattern` 与可选 `path` 及其模型可见说明（[packages/fs/tool-fs-search/src/glob.ts:317-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L317-L325)）
- 工具定义带上 `timeoutMs`，交由工具调用超时策略通过 `exec.signal` 执行（[packages/fs/tool-fs-search/src/glob.ts:326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L326)）
- 输出声明规范值 schema 为 `{ root, paths }`，`render` 由 `renderGlobPaths` 产出模型可见文本（[packages/fs/tool-fs-search/src/glob.ts:327-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L327-L336)）
- `presentationMeta` 把内联页与总数投影成搜索卡元数据，并受 `maxMetaBytes` 约束（[packages/fs/tool-fs-search/src/glob.ts:337-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L337-L340)）
- `execute` 校验参数、跑 ripgrep、把 `path` 与每行输出转成工作目录相对展示路径，退出码 1（无匹配）返回空列表（[packages/fs/tool-fs-search/src/glob.ts:342-355](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L342-L355)）
- 把工具注册进 `ctx.tools`（[packages/fs/tool-fs-search/src/glob.ts:359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L359)）
- `tools/post-execute` 监听器先 `await next()`，仅在结果超过内联上限时把完整排序列表落盘，并用带定位符的文本替换决策内容，同时保留下游的 `additionalContexts`（[packages/fs/tool-fs-search/src/glob.ts:361-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/glob.ts#L361-L373)）

### packages/fs/tool-fs-search/src/grep.ts

`grep` 工具的实现文件：模型可见 schema、参数校验、`rg --json` argv 构造与记录解析、逐行预览与匹配保留、分组渲染，由包入口 `applyGrepTool` 装配。

- 内联匹配条数默认上限常量 `GREP_MAX_MATCHES = 250`（[packages/fs/tool-fs-search/src/grep.ts:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L30)）
- 单行预览默认字节上限常量 `GREP_MAX_LINE_BYTES = 2000`（[packages/fs/tool-fs-search/src/grep.ts:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L36)）
- `validateInclude` 拒绝空白、以 `!` 开头的取反、以及花括号深度为 0 处含逗号的列表写法（[packages/fs/tool-fs-search/src/grep.ts:68-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L68-L79)）
- `parseGrepArgs` 只拒绝长度为 0 的 `pattern`（空白字符视为合法正则）、拒绝空白 `path`，并对 `include` 做上述校验（[packages/fs/tool-fs-search/src/grep.ts:90-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L90-L99)）
- argv 固定为 `--json --regexp=<pattern>`，`include` 走 `--glob=`，目标路径放在 `--` 之后（[packages/fs/tool-fs-search/src/grep.ts:112-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L112-L117)）
- `parseRecord` 跳过非 `match` 记录类型，对非 JSON 行、缺 data/路径/行号/行内容的记录抛 `SEARCH_FAILED`（[packages/fs/tool-fs-search/src/grep.ts:135-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L135-L153)）
- 有 `text` 时剥掉行尾换行；只有 base64 `bytes` 时用占位文本 `(line is not valid UTF-8)` 代替，而不使整次搜索失败（[packages/fs/tool-fs-search/src/grep.ts:154-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L154-L160)）
- `parseGrepMatches` 按行切分完整 stdout，只收集 `match` 记录，保持输出顺序（[packages/fs/tool-fs-search/src/grep.ts:170-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L170-L178)）
- `formatGrepMatches` 按首次出现顺序把匹配按文件分组，每条渲染为 `Line N: <文本>`（[packages/fs/tool-fs-search/src/grep.ts:192-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L192-L204)）
- `formatGrepOutput` 未截断时输出 `Found N matches` 头，截断时输出 `Found kept of seen matches` 头并附落盘定位符或"未能保存"说明（[packages/fs/tool-fs-search/src/grep.ts:216-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L216-L226)）
- 零匹配时返回固定文本 `No matches found`（[packages/fs/tool-fs-search/src/grep.ts:229-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L229-L232)）
- `presentGrepCall` 以 pattern、path 与 include 组成调用中卡片标题（[packages/fs/tool-fs-search/src/grep.ts:241-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L241-L245)）
- `presentGrepResult` 对错误结果与非 `matches` 形状的元数据返回 `undefined`（[packages/fs/tool-fs-search/src/grep.ts:258-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L258-L266)）
- 注册系统提示段落 `tool:grep`，固定文本要求用该工具而非 shell 的 grep/rg，并提示用 read 取上下文（[packages/fs/tool-fs-search/src/grep.ts:276-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L276-L280)）
- 工具描述把配置的内联匹配上限写进模型可见文本（[packages/fs/tool-fs-search/src/grep.ts:283-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L283-L286)）
- 参数表声明必填 `pattern` 与可选 `path`、`include`，并写明 include 不支持列表与取反（[packages/fs/tool-fs-search/src/grep.ts:287-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L287-L291)）
- 工具定义带上 `timeoutMs`（[packages/fs/tool-fs-search/src/grep.ts:292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L292)）
- 输出声明规范值 schema 为 `{ matches: [{ path, lineNumber, line }] }`（[packages/fs/tool-fs-search/src/grep.ts:293-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L293-L312)）
- `render` 与 `presentationMeta` 都消费同一次 `retainGrepMatches` 的保留结果，使文本与卡片对"哪些匹配存活"一致（[packages/fs/tool-fs-search/src/grep.ts:313-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L313-L318)）
- `execute` 校验参数、跑 ripgrep、无匹配返回空数组，否则把每条匹配的路径转成工作目录相对路径（[packages/fs/tool-fs-search/src/grep.ts:320-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L320-L335)）
- 把工具注册进 `ctx.tools`（[packages/fs/tool-fs-search/src/grep.ts:339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L339)）
- `tools/post-execute` 监听器在超过内联上限时，把逐行预览过但不截条数的完整匹配列表落盘，并用带定位符的文本替换决策内容，保留 `additionalContexts`（[packages/fs/tool-fs-search/src/grep.ts:341-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/grep.ts#L341-L364)）

### packages/fs/tool-fs-search/src/index.ts

包入口：定义插件名、注入声明、配置 schema 与上限校验，并装配 glob 与 grep 两个工具。

- 插件名 `tool-fs-search`，供加载器诊断使用（[packages/fs/tool-fs-search/src/index.ts:67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/index.ts#L67)）
- `inject` 声明依赖 `tools`、`systemPrompt`、`subprocess`，落盘存储不在静态注入内（[packages/fs/tool-fs-search/src/index.ts:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/index.ts#L70)）
- 配置 schema 把 `sampleOverCapGlobResults` 设为必填无默认，其余上限项各有默认值（[packages/fs/tool-fs-search/src/index.ts:97-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/index.ts#L97-L107)）
- `assertPositiveInteger` 对非正整数抛出带字段名的加载期错误（[packages/fs/tool-fs-search/src/index.ts:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/index.ts#L113-L117)）
- `apply` 声明为 `async`，使配置拒绝表现为 promise rejection 而非同步抛出（[packages/fs/tool-fs-search/src/index.ts:127-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/index.ts#L127-L128)）
- 装配前逐项校验七个数值上限均为正整数（[packages/fs/tool-fs-search/src/index.ts:131-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/index.ts#L131-L141)）
- `graceMs` 额外受最大定时器延迟上界约束，超出即拒绝加载（[packages/fs/tool-fs-search/src/index.ts:137-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/index.ts#L137-L139)）
- 把解析后的配置拆成 glob 与 grep 各自的上限对象并调用两个装配函数（[packages/fs/tool-fs-search/src/index.ts:142-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/index.ts#L142-L159)）

### packages/fs/tool-fs-search/src/invariant.ts

该包的不变量伴随插件，向不变量服务登记包名并安装一个空检查器。

- 声明伴随插件名与对 `invariants` 服务的注入（[packages/fs/tool-fs-search/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/invariant.ts#L13-L15)）
- 以包名注册一个空安装器，并返回注册的释放函数（[packages/fs/tool-fs-search/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/invariant.ts#L21-L29)）

### packages/fs/tool-fs-search/src/presentation.ts

搜索卡元数据的投影与回读文件：把保留后的匹配/路径投成 `presentationMeta`，并在展示时把不透明元数据窄化回视图。

- `groupMatchesByFile` 按首次出现顺序把扁平匹配分组为按文件的结构（[packages/fs/tool-fs-search/src/presentation.ts:80-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/presentation.ts#L80-L89)）
- `metaBytes` 以 JSON 序列化后的 UTF-8 字节数衡量元数据体积（[packages/fs/tool-fs-search/src/presentation.ts:92-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/presentation.ts#L92-L94)）
- `capMetaBytes` 从尾部丢弃文件组或路径直到序列化后不超预算，至少保留一项，并把结果标为 `truncated`，同时保留 `total`（[packages/fs/tool-fs-search/src/presentation.ts:107-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/presentation.ts#L107-L117)）
- `grepSearchMeta` 生成 `matches` 形状元数据，带 `truncated` 与解析到的匹配总数，再过字节裁剪（[packages/fs/tool-fs-search/src/presentation.ts:130-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/presentation.ts#L130-L138)）
- `globSearchMeta` 生成 `paths` 形状元数据，带 `truncated` 与发现到的路径总数，再过字节裁剪（[packages/fs/tool-fs-search/src/presentation.ts:150-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/presentation.ts#L150-L158)）
- 两个类型守卫逐项校验行匹配与文件分组的字段类型（[packages/fs/tool-fs-search/src/presentation.ts:161-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/presentation.ts#L161-L172)）
- `searchViewFromMeta` 校验 `truncated`/`total` 与 `shape` 后分别产出 matches 或 paths 视图，任何不合格的（含重放旧日志的）元数据返回 `undefined`（[packages/fs/tool-fs-search/src/presentation.ts:189-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/presentation.ts#L189-L205)）

### packages/fs/tool-fs-search/src/ripgrep.d.ts

为 ripgrep 二进制包补的模块类型声明文件。

- 无运行期机制

### packages/fs/tool-fs-search/src/search-core.ts

glob 与 grep 共用的执行层：错误码与错误类、二进制路径解析、进程执行与退出码判定、输出保留与落盘、路径相对化。

- 默认原始 stdout 解析上限 20,000,000 字节（[packages/fs/tool-fs-search/src/search-core.ts:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L36)）
- 默认协作式工具调用超时预算 30,000 毫秒（[packages/fs/tool-fs-search/src/search-core.ts:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L43)）
- 默认 stderr 诊断尾部保留 64 KiB（[packages/fs/tool-fs-search/src/search-core.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L50)）
- 默认终止升级宽限期 3,000 毫秒（[packages/fs/tool-fs-search/src/search-core.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L53)）
- 默认单次搜索序列化元数据上限 65,536 字节，因为元数据随会话日志持久化并每轮重发（[packages/fs/tool-fs-search/src/search-core.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L65)）
- 定义四个稳定失败码：非法模式、执行失败、原始输出溢出、被中止（[packages/fs/tool-fs-search/src/search-core.ts:78-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L78-L82)）
- `SearchError` 携带上述码并链接 `cause`，使工具注册表能在错误结果上暴露 `{ name, code }`（[packages/fs/tool-fs-search/src/search-core.ts:90-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L90-L97)）
- `stderrExcerpt` 修剪 stderr 并在被截断时追加 `[stderr truncated]` 标记（[packages/fs/tool-fs-search/src/search-core.ts:113-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L113-L117)）
- `classifyRunFailure` 用 stderr 中的正则/glob 解析错误文本判定为非法模式，其余归为执行失败并带退出码（[packages/fs/tool-fs-search/src/search-core.ts:124-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L124-L130)）
- `completeStdout` 在 stdout 未被截断但字节数超上限、或已被截断两种情况下都抛原始输出溢出，并附"缩小 pattern/path/include 重试"的提示（[packages/fs/tool-fs-search/src/search-core.ts:139-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L139-L155)）
- `resolveRgPath` 进程内只解析一次：单文件运行时优先用可执行文件旁的 `-rg` 附属文件（Windows 为 `-rg.exe`），否则动态导入平台包取路径（[packages/fs/tool-fs-search/src/search-core.ts:171-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L171-L181)）
- `runRipgrep` 启动前先检查中止信号，已中止则直接抛 `SEARCH_ABORTED`（[packages/fs/tool-fs-search/src/search-core.ts:227-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L227-L229)）
- 工作目录取调用方会话头部的 cwd，缺失时退回进程 cwd，该值同时是展示相对化的基准（[packages/fs/tool-fs-search/src/search-core.ts:230-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L230-L231)）
- spawn 时在 argv 最前插入 `--no-config`，使宿主的 ripgrep 配置无法注入 `--pre` 预处理器（[packages/fs/tool-fs-search/src/search-core.ts:234-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L234-L235)）
- spawn 规格关闭 stdin，为 stdout/stderr 各设字节预算，并把宽限期与 `exec.signal` 传给子进程接缝（[packages/fs/tool-fs-search/src/search-core.ts:236-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L236-L244)）
- 创建期同步抛出时：若信号已中止归为 `SEARCH_ABORTED`，否则归为 `SEARCH_FAILED` 并把原错误挂在 `cause`（[packages/fs/tool-fs-search/src/search-core.ts:245-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L245-L256)）
- `handle.done` 被拒绝时归为 `SEARCH_FAILED` 并链接原因（[packages/fs/tool-fs-search/src/search-core.ts:257-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L257-L262)）
- 缺少已采集的 stdout 或 stderr 流时抛 `SEARCH_FAILED`（[packages/fs/tool-fs-search/src/search-core.ts:263-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L263-L267)）
- 等待结束后再查一次中止信号，已中止则抛 `SEARCH_ABORTED`（[packages/fs/tool-fs-search/src/search-core.ts:268-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L268-L273)）
- 被信号杀死或无退出码时抛 `SEARCH_FAILED`（[packages/fs/tool-fs-search/src/search-core.ts:274-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L274-L276)）
- 退出码 0 视为有结果、1 视为零结果，其余交给失败分类；随后校验完整 stdout 并返回 `{ stdout, noMatches, workdir }`（[packages/fs/tool-fs-search/src/search-core.ts:277-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L277-L281)）
- `toWorkdirRelative` 把工作目录内的绝对路径转成相对路径，等于工作目录本身时返回 `.`，越出工作目录的绝对路径原样保留（[packages/fs/tool-fs-search/src/search-core.ts:296-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L296-L302)）
- `previewLine` 按字节预算取头部（保持 UTF-8 边界），被截断时追加 ` (line truncated)`（[packages/fs/tool-fs-search/src/search-core.ts:320-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L320-L325)）
- `retainGrepMatches` 在一次遍历中同时做逐行预览与前 N 条保留，供文本与卡片共用（[packages/fs/tool-fs-search/src/search-core.ts:340-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L340-L344)）
- `retainGlobPaths` 保留前 N 条路径并给出保留结果（[packages/fs/tool-fs-search/src/search-core.ts:355-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L355-L359)）
- `trySaveFormattedResult` 无会话归属时记录告警并返回 `undefined`（[packages/fs/tool-fs-search/src/search-core.ts:384-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L384-L388)）
- 落盘后端以 `ctx.get('spillStore')` 机会性读取，未挂载时告警并返回 `undefined`（[packages/fs/tool-fs-search/src/search-core.ts:389-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L389-L393)）
- 保存请求以会话 id 为归属、以工具名与调用 id 为来源，并带上文件名建议（[packages/fs/tool-fs-search/src/search-core.ts:394-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L394-L401)）
- 保存失败被吞掉并降级为告警加 `undefined`，搜索成功不会因此变成错误结果（[packages/fs/tool-fs-search/src/search-core.ts:402-407](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs-search/src/search-core.ts#L402-L407)）

### packages/fs/tool-fs-search/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工作区引用。

- 无运行期机制
