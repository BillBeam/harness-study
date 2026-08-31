---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/fs/tool-fs
---

# packages/fs/tool-fs

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、125 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/fs/tool-fs/README.md

该包的说明文档，描述四个面向模型的文件工具、配置项、结果格式与失败文案。

- 无运行期机制

### packages/fs/tool-fs/package.json

该包的 npm 清单，声明入口、发布内容与运行期依赖。

- `exports` 把 `.` 映射到 `./lib/index.js`、`./invariant` 映射到 `./lib/invariant.js`，并开放 `./src/*` 与 `./package.json` 子路径（[packages/fs/tool-fs/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/fs/tool-fs/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/package.json#L28-L32)）
- `dependencies` 声明运行期真实依赖 `diff` 与 `@deepseek-ai/schemastery`（[packages/fs/tool-fs/package.json:34-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/package.json#L34-L37)）
- `main`/`types` 为不识别 `exports` 的解析器指定 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/fs/tool-fs/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/package.json#L14-L15)）

### packages/fs/tool-fs/src/diff.ts

写入与编辑工具的结果期差异卡片计算与元数据窄化模块，被 `write.ts`、`edit.ts` 使用。

- `DIFF_CONTEXT = 3` 固定每个改动块两侧携带的上下文行数（[packages/fs/tool-fs/src/diff.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/diff.ts#L11)）
- `computeHunkDiffs` 用 `structuredPatch` 按该上下文数切分 before/after，为每个 hunk 产出一条差异（[packages/fs/tool-fs/src/diff.ts:33-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/diff.ts#L33-L36)）
- 以 `\` 开头的补丁行（缺尾换行标注）被跳过，不进入差异内容（[packages/fs/tool-fs/src/diff.ts:41-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/diff.ts#L41-L42)）
- 行首 `-`/`+` 分别归入旧侧与新侧，其余上下文行同时进入两侧（[packages/fs/tool-fs/src/diff.ts:43-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/diff.ts#L43-L52)）
- 纯插入的 hunk 以 `oldText: null` 表示（[packages/fs/tool-fs/src/diff.ts:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/diff.ts#L54)）
- `isFileDiff` 校验单条差异的字段类型，`path`/`newText` 为字符串且 `oldText` 为字符串或 null（[packages/fs/tool-fs/src/diff.ts:60-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/diff.ts#L60-L66)）
- `diffsFromMeta` 对不透明的实时或重放元数据做窄化，非对象、非数组、空数组或含非法元素一律返回 `undefined` 以便展示层回落而不抛错（[packages/fs/tool-fs/src/diff.ts:74-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/diff.ts#L74-L79)）

### packages/fs/tool-fs/src/edit.ts

`edit` 工具的注册与执行体，被包入口 `index.ts` 调用。

- `parseEditArgs` 对空白 `file_path`、空 `old_string`、以及 `old_string === new_string` 三种情况分别抛出固定文案（[packages/fs/tool-fs/src/edit.ts:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L47-L50)）
- `replace_all` 缺省为 `false`（[packages/fs/tool-fs/src/edit.ts:51-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L51-L56)）
- `formatEditOutput` 按是否 `replace_all` 产出两种成功确认句（[packages/fs/tool-fs/src/edit.ts:65-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L65-L69)）
- 向系统提示注册名为 `tool:edit`、带固定 order 的段落文本（[packages/fs/tool-fs/src/edit.ts:77-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L77-L81)）
- 注册 `edit` 工具，声明 `file_path`/`old_string`/`new_string` 必填与可选 `replace_all` 的模型可见 schema（[packages/fs/tool-fs/src/edit.ts:83-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L83-L90)）
- 仅当存在可升级的沙箱目标时才把升级参数展开进 schema，否则模型看不到这两个字段（[packages/fs/tool-fs/src/edit.ts:91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L91)）
- 输出 schema 固定为 `path`/`before`/`after` 三个必填字段且不允许额外属性（[packages/fs/tool-fs/src/edit.ts:93-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L93-L102)）
- `render` 把结构化输出渲染成一条文本块，即模型实际看到的确认句（[packages/fs/tool-fs/src/edit.ts:103-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L103-L106)）
- `presentationMeta` 由 before/after 计算 hunk 差异并随会话日志持久化，供重放时复现差异卡片（[packages/fs/tool-fs/src/edit.ts:107-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L107-L110)）
- 执行体先解析按调用生效的沙箱策略，早于任何文件操作（[packages/fs/tool-fs/src/edit.ts:113-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L113-L116)）
- 用会话 cwd 与策略工作区根解析目标路径（[packages/fs/tool-fs/src/edit.ts:117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L117)）
- 通过 `ctx.waterfall('fs/edit-intent', …)` 取守卫，缺省实现返回 `undefined`（无条件编辑），且该调用与编辑同处一个 try 内（[packages/fs/tool-fs/src/edit.ts:124-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L124-L133)）
- 捕获到的错误先经沙箱拒绝映射，再经补救文案包装后重新抛出（[packages/fs/tool-fs/src/edit.ts:134-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L134-L139)）
- 编辑成功后才发出 `fs/observed` 记录新版本（[packages/fs/tool-fs/src/edit.ts:140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L140)）
- 返回值只含 `path`/`before`/`after`（[packages/fs/tool-fs/src/edit.ts:141-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L141-L145)）
- `presentCall` 由调用参数直接生成待执行的差异卡片，空 `old_string` 映射为 `null`（[packages/fs/tool-fs/src/edit.ts:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L150-L157)）
- `presentResult` 在结果为错误或元数据不合法时返回 `undefined` 回落到通用渲染（[packages/fs/tool-fs/src/edit.ts:160-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/edit.ts#L160-L165)）

### packages/fs/tool-fs/src/error.ts

守卫型变更失败的模型可见补救文案包装模块，被 `write.ts` 与 `edit.ts` 调用。

- `REMEDIES` 把 `FS_STALE_VERSION` 映射为 `re-read the file, then retry`、`FS_NOT_OBSERVED` 映射为 `read the file, then retry`（[packages/fs/tool-fs/src/error.ts:14-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/error.ts#L14-L17)）
- 非 `FsError` 与无对应补救项的错误原样透传（[packages/fs/tool-fs/src/error.ts:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/error.ts#L30-L32)）
- 命中的错误被重建为新 `FsError`，消息后接 `— <remedy>`，保留原错误码并把原错误挂在 `cause` 上（[packages/fs/tool-fs/src/error.ts:33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/error.ts#L33)）

### packages/fs/tool-fs/src/index.ts

包主入口，声明插件名、注入需求与配置，并组装四个工具。

- 导出 `name = 'tool-fs'` 作为加载器诊断使用的插件名（[packages/fs/tool-fs/src/index.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/index.ts#L19)）
- `inject = ['tools', 'fs', 'systemPrompt']` 规定这三个服务就位后插件才生效（[packages/fs/tool-fs/src/index.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/index.ts#L22)）
- `Config` schema 为四个读取上限提供默认值（行数、单行字符数、字节数、流式阈值）（[packages/fs/tool-fs/src/index.ts:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/index.ts#L36-L41)）
- `assertPositiveInteger` 对非正整数配置在加载时抛出 `tool-fs: <name> must be a positive integer`（[packages/fs/tool-fs/src/index.ts:47-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/index.ts#L47-L51)）
- `apply` 逐个校验四项配置后再注册任何工具（[packages/fs/tool-fs/src/index.ts:56-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/index.ts#L56-L60)）
- 把解析后的配置转成读取上限传给 `read` 工具注册（[packages/fs/tool-fs/src/index.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/index.ts#L61-L66)）
- `read_image` 放在 `ctx.inject(['attachments'], …)` 内注册，只有挂载了附件服务时该工具才出现在模型可见的工具表里（[packages/fs/tool-fs/src/index.ts:70-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/index.ts#L70-L72)）
- 构造一个供 `write` 与 `edit` 共享的沙箱升级控制器，再依次注册这两个工具（[packages/fs/tool-fs/src/index.ts:76-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/index.ts#L76-L78)）

### packages/fs/tool-fs/src/invariant.ts

该包的不变量伴生插件，向 `ctx.invariants` 登记包名。

- 声明 `inject = ['invariants']`，在注册前要求该服务就位（[packages/fs/tool-fs/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/invariant.ts#L15)）
- 安装器为空函数，即不注册任何运行期检查（[packages/fs/tool-fs/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其 disposer（[packages/fs/tool-fs/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/invariant.ts#L28-L29)）

### packages/fs/tool-fs/src/read-image.ts

`read_image` 工具的注册与执行体，读取图片文件、存入附件服务并把图片块交给模型。

- `IMAGE_EXTENSIONS` 把 `.png`/`.jpg`/`.jpeg`/`.webp`/`.gif` 映射为声明媒体类型，其它扩展名一律不接受（[packages/fs/tool-fs/src/read-image.ts:22-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L22-L28)）
- `IMAGE_VALUE_SCHEMA` 固定结构化图片结果的字段集合与媒体类型枚举（[packages/fs/tool-fs/src/read-image.ts:30-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L30-L50)）
- `imageMediaTypeForPath` 按小写扩展名查表，未命中返回 `undefined`（[packages/fs/tool-fs/src/read-image.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L75-L77)）
- `assertImageCapableRoute` 先取会话请求头 config 的 provider/model，再回落到 agent 选项（[packages/fs/tool-fs/src/read-image.ts:88-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L88-L90)）
- provider、model 或 `llm` 服务任一缺失时抛出"当前模型路由无法解析"的拒绝（[packages/fs/tool-fs/src/read-image.ts:91-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L91-L94)）
- 解析出的模型未显式声明 `image` 输入模态时抛出固定拒绝文案，图片因此不会进入该路由的持久历史（[packages/fs/tool-fs/src/read-image.ts:95-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L95-L98)）
- `imageRefFromValue` 把结构化结果重新打成带品牌 id 的附件引用，`name` 与 `originalDimensions` 缺省时不出现（[packages/fs/tool-fs/src/read-image.ts:107-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L107-L119)）
- `formatImageReadOutput` 在发生降采样时附加原始尺寸与坐标换算倍数，两轴倍数相同时只给一个乘数（[packages/fs/tool-fs/src/read-image.ts:129-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L129-L140)）
- 输出信封固定为 `<path>`、`<type>image</type>` 与含媒体类型、尺寸、字节数的 `<content>`（[packages/fs/tool-fs/src/read-image.ts:141-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L141-L145)）
- `imageReadContent` 把一次读取投射成"文本信封 + 原生图片块"两个内容块（[packages/fs/tool-fs/src/read-image.ts:153-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L153-L158)）
- 工具描述文本告诉模型直接用该工具而不必自行安装图像库或先生成缩略图（[packages/fs/tool-fs/src/read-image.ts:172-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L172-L174)）
- `isConcurrencySafe` 返回真，使该工具可与其它调用并发调度（[packages/fs/tool-fs/src/read-image.ts:191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L191)）
- 执行体在任何文件 I/O 之前依次做四道门：空白路径、扩展名不受支持、附件服务未挂载、部署不接受该媒体类型（[packages/fs/tool-fs/src/read-image.ts:193-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L193-L207)）
- 随后执行路由能力门，通过后才解析目标并 stat（[packages/fs/tool-fs/src/read-image.ts:208-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L208-L210)）
- 读取字节数上限取单图上限与单条消息图片总量上限的较小者，并作为 `readBytes` 的硬上限传入（[packages/fs/tool-fs/src/read-image.ts:214-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L214-L215)）
- 在返回结果之前先把图片持久化到附件服务，保证图片块引用的是已提交对象（[packages/fs/tool-fs/src/read-image.ts:218-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L218-L220)）
- 尺寸超限、像素超限、字节超限、16 位 PNG 转换失败、以及扩展名与实际格式不符五类附件错误分别被改写成带修复建议的可恢复工具错误（[packages/fs/tool-fs/src/read-image.ts:221-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L221-L256)）
- 持久化成功后才发出 `fs/observed` 记录存在与版本（[packages/fs/tool-fs/src/read-image.ts:257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L257)）
- 返回值携带附件 id、媒体类型、字节数、归一化后尺寸，并按需带上 `name` 与原始尺寸（[packages/fs/tool-fs/src/read-image.ts:258-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L258-L272)）
- `presentCall` 生成 `read` 类别的通用卡片与指向该图片文件的位置（[packages/fs/tool-fs/src/read-image.ts:276-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-image.ts#L276-L283)）

### packages/fs/tool-fs/src/read-render.ts

无 Cordis 依赖的纯读取渲染模块，负责窗口构建、上限执行、信封格式化与重放元数据窄化。

- `READ_MAX_LINE_LENGTH = 2000` 与 `READ_MAX_BYTES = 50 * 1024` 定义单行字符与单次读取字节的默认上限（[packages/fs/tool-fs/src/read-render.ts:11-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L11-L14)）
- `truncateLine` 对超长行截断并追加 `... (line truncated to <max> chars)`（[packages/fs/tool-fs/src/read-render.ts:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L69-L71)）
- `lineByteSize` 按 UTF-8 计字节，并为第一行之后的每行计入一个换行字节（[packages/fs/tool-fs/src/read-render.ts:73-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L73-L75)）
- `consumeLine` 对每一行都递增总行数，但跳过 offset 之前、已达 limit、或已触发字节截断的行（[packages/fs/tool-fs/src/read-render.ts:77-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L77-L79)）
- 累计字节超过 `maxBytes` 时置位 `truncatedByBytes` 并停止收集，不产出该行（[packages/fs/tool-fs/src/read-render.ts:81-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L81-L88)）
- `stripCarriageReturn` 去掉行尾的 `\r`（[packages/fs/tool-fs/src/read-render.ts:91-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L91-L93)）
- `finish` 在未发生字节截断且请求 offset 超出总行数时抛出 `FS_NOT_FOUND`，空文件请求第 1 行例外放行（[packages/fs/tool-fs/src/read-render.ts:95-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L95-L100)）
- `buildWindow` 把行缓冲封顶在 `maxLineLength + 1`，使无换行的超长行也不会无界增长内存（[packages/fs/tool-fs/src/read-render.ts:117-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L117-L125)）
- 逐块扫描换行切分并在末尾冲刷残留行，从而在流式与整读两种输入下得到同一窗口（[packages/fs/tool-fs/src/read-render.ts:132-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L132-L143)）
- `formatReadOutput` 按字节截断、未读完、读完三种情形分别产出"Output capped"、"Showing lines … of …"、"End of file" 三种页脚（[packages/fs/tool-fs/src/read-render.ts:152-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L152-L161)）
- 正文按 `<行号>: <文本>` 编号并与页脚间空一行，整体包在 `<path>`/`<type>file</type>`/`<content>` 信封里（[packages/fs/tool-fs/src/read-render.ts:162-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L162-L169)）
- `LANG_BY_EXTENSION` 固定一张扩展名到语法高亮语言的映射表（[packages/fs/tool-fs/src/read-render.ts:178-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L178-L190)）
- `langFromPath` 对无扩展名的点文件返回 `undefined`，并只按自有属性查表，避免原型链上的键映射出函数值（[packages/fs/tool-fs/src/read-render.ts:199-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L199-L210)）
- `isFileTextLine` 要求行号为 ≥1 的整数、文本为字符串（[packages/fs/tool-fs/src/read-render.ts:239-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L239-L243)）
- `readMetaFromMeta` 先做类型窄化，`offset` 须为 ≥1 整数、`totalLines` 须为非负整数、`lines` 全部合法、`lang` 若存在须为字符串（[packages/fs/tool-fs/src/read-render.ts:259-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L259-L265)）
- 再做语义校验：行号须严格递增、不小于 offset、不超过 `totalLines`，任一违反即返回 `undefined` 让展示回落而不抛错（[packages/fs/tool-fs/src/read-render.ts:266-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-render.ts#L266-L271)）

### packages/fs/tool-fs/src/read-target.ts

`read` 与 `read_image` 共用的路径解析与常规文件校验模块。

- 用会话解析选项解析模型给出的路径，再对目标做一次 stat（[packages/fs/tool-fs/src/read-target.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-target.ts#L24-L25)）
- 目标不存在时先发出 `fs/observed` 的 `absent` 观察，再抛出 `FS_NOT_FOUND`（[packages/fs/tool-fs/src/read-target.ts:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-target.ts#L26-L29)）
- 目标不是常规文件时抛出 `FS_NOT_REGULAR_FILE`（[packages/fs/tool-fs/src/read-target.ts:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read-target.ts#L30-L32)）

### packages/fs/tool-fs/src/read.ts

`read` 工具的注册与执行体，被包入口 `index.ts` 调用。

- `READ_LIMIT = 2000` 与 `STREAM_MIN_SIZE = 10 * 1024 * 1024` 定义默认行数上限与流式阈值（[packages/fs/tool-fs/src/read.ts:16-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L16-L22)）
- `parsePositiveInteger` 对非正整数的 `offset`/`limit` 抛出固定文案（[packages/fs/tool-fs/src/read.ts:43-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L43-L48)）
- `parseReadArgs` 拒绝空白 `file_path`，把 `offset` 缺省为 1、`limit` 缺省为部署上限，并对超过上限的 `limit` 抛出 `limit must be less than or equal to <max>`（[packages/fs/tool-fs/src/read.ts:56-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L56-L62)）
- 向系统提示注册名为 `tool:read`、带固定 order 的段落文本（[packages/fs/tool-fs/src/read.ts:70-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L70-L74)）
- 注册 `read` 工具，`limit` 的参数描述里嵌入部署配置的默认值（[packages/fs/tool-fs/src/read.ts:76-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L76-L83)）
- 输出 schema 固定为 `path`/`offset`/`lines`/`totalLines`，其中每行只含 `number` 与 `text`（[packages/fs/tool-fs/src/read.ts:84-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L84-L105)）
- `render` 由返回行数少于请求 limit 且末行小于总行数推断出字节截断，再渲染成模型可见的信封文本（[packages/fs/tool-fs/src/read.ts:106-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L106-L119)）
- `presentationMeta` 把结构化窗口连同语言提示写进持久化元数据，使重放时读取卡片仍可复现（[packages/fs/tool-fs/src/read.ts:123-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L123-L132)）
- `isConcurrencySafe` 返回真，使读取可与其它调用并发调度（[packages/fs/tool-fs/src/read.ts:135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L135)）
- 执行体只做一次 stat，同时用于缺失观察、类型校验、大小路由与存在版本（[packages/fs/tool-fs/src/read.ts:136-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L136-L140)）
- 文件大小未知或不小于流式阈值时走 `streamText`，否则整读 `readText`（[packages/fs/tool-fs/src/read.ts:144-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L144-L146)）
- 用配置的行数、单行字符、字节三重上限构建窗口（[packages/fs/tool-fs/src/read.ts:147-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L147-L151)）
- 读取成功后发出 `fs/observed` 的 `present` 观察并附带 stat 得到的版本（[packages/fs/tool-fs/src/read.ts:162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L162)）
- `presentResult` 用正则剥掉结果文本的读取信封取出正文，元数据不合法或文本不匹配信封时返回 `undefined` 回落到通用渲染（[packages/fs/tool-fs/src/read.ts:172-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L172-L190)）
- `presentCall` 按原始参数拼出标题中的窗口区间，并把跟随位置的行号设为 offset（缺省 1）（[packages/fs/tool-fs/src/read.ts:196-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/read.ts#L196-L206)）

### packages/fs/tool-fs/src/sandbox.ts

`write` 与 `edit` 共享的沙箱升级控制器，负责升级参数公布、按调用策略解析与拒绝文案映射。

- 构造时读 `ctx.fs.sandboxMode`：未定义则升级目标为空数组，否则取固定的升级目标集合（[packages/fs/tool-fs/src/sandbox.ts:44-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/sandbox.ts#L44-L45)）
- 后端会围栏但 `ctx.sandboxPolicy` 缺失时在加载期抛错（[packages/fs/tool-fs/src/sandbox.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/sandbox.ts#L46-L49)）
- `schemaFields` 产出 `sandbox_permissions`（枚举锁定升级目标）与 `justification` 两个模型可见参数及其描述（[packages/fs/tool-fs/src/sandbox.ts:59-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/sandbox.ts#L59-L73)）
- `resolvePolicy` 先校验升级参数的配对合法性（[packages/fs/tool-fs/src/sandbox.ts:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/sandbox.ts#L88)）
- 以调用会话解析出常驻策略，未带升级参数时直接返回它（[packages/fs/tool-fs/src/sandbox.ts:89-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/sandbox.ts#L89-L92)）
- 组合中没有可升级后端却收到升级参数时抛出专门文案（[packages/fs/tool-fs/src/sandbox.ts:93-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/sandbox.ts#L93-L95)）
- 走 `approveEscalation` 经审批服务拿到批准模式后，把它盖在常驻策略上返回（[packages/fs/tool-fs/src/sandbox.ts:96-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/sandbox.ts#L96-L107)）
- `mapError` 只改写 `FS_SANDBOX_DENIED`，其余错误原样透传（[packages/fs/tool-fs/src/sandbox.ts:125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/sandbox.ts#L125)）
- 拒绝被重建为一个仍带 `FS_SANDBOX_DENIED` 码的 `FsError`，文本为共享的 `[sandbox: …]` 标记加同轮升级提示（[packages/fs/tool-fs/src/sandbox.ts:126-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/sandbox.ts#L126-L129)）

### packages/fs/tool-fs/src/session-cwd.ts

推导文件工具解析相对路径所用工作目录的模块，被四个工具的目标解析共用。

- `PARENT_PATH_SEGMENT` 正则识别路径中的 `..` 段（[packages/fs/tool-fs/src/session-cwd.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/session-cwd.ts#L13)）
- `sessionCwd` 取调用 agent 的 `session.header.cwd`，非 agent 调用返回 `undefined`，把默认值留给后端而不在工具层读 `process.cwd()`（[packages/fs/tool-fs/src/session-cwd.ts:22-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/session-cwd.ts#L22-L24)）
- 当 cwd 或请求路径含父级跳转段时，先把 cwd 规范化再返回（[packages/fs/tool-fs/src/session-cwd.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/session-cwd.ts#L24-L25)）
- `sessionResolveOptions` 让按调用策略的工作区根优先于会话 cwd，并把 `exec.signal` 一并交给解析（[packages/fs/tool-fs/src/session-cwd.ts:35-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/session-cwd.ts#L35-L45)）

### packages/fs/tool-fs/src/write.ts

`write` 工具的注册与执行体，被包入口 `index.ts` 调用。

- `parseWriteArgs` 只拒绝空白 `file_path`，空 `content` 被视为合法（写出空文件）（[packages/fs/tool-fs/src/write.ts:25-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L25-L28)）
- `formatWriteOutput` 按 `operation` 在 `Created file` 与 `Updated file` 之间选择，且不回显文件内容（[packages/fs/tool-fs/src/write.ts:36-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L36-L43)）
- 向系统提示注册名为 `tool:write`、带固定 order 的段落文本（[packages/fs/tool-fs/src/write.ts:63-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L63-L67)）
- 注册 `write` 工具并声明 `file_path`/`content` 两个必填参数（[packages/fs/tool-fs/src/write.ts:69-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L69-L74)）
- 仅当存在可升级的沙箱目标时才把升级参数展开进 schema（[packages/fs/tool-fs/src/write.ts:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L75)）
- 输出 schema 固定为 `path`/`operation`（枚举 create|update）/`before`（可为 null）/`after`（[packages/fs/tool-fs/src/write.ts:77-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L77-L93)）
- `presentationMeta` 在新建（`before === null`）时给出空差异数组，否则按 before/after 计算 hunk 差异（[packages/fs/tool-fs/src/write.ts:95-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L95-L100)）
- 执行体先解析按调用生效的沙箱策略，早于任何文件操作（[packages/fs/tool-fs/src/write.ts:103-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L103-L107)）
- 用会话 cwd 与策略工作区根解析目标路径（[packages/fs/tool-fs/src/write.ts:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L108)）
- 通过 `ctx.waterfall('fs/write-intent', …)` 取写入意图，缺省实现返回 `undefined`（无条件写入），且不额外 stat（[packages/fs/tool-fs/src/write.ts:109-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L109-L111)）
- 写入失败时错误先经沙箱拒绝映射再经补救文案包装后抛出（[packages/fs/tool-fs/src/write.ts:113-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L113-L120)）
- 写入成功后才发出 `fs/observed` 记录新版本（[packages/fs/tool-fs/src/write.ts:121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L121)）
- `presentCall` 由调用参数生成差异卡片，调用期一律以 `oldText: null` 表示（[packages/fs/tool-fs/src/write.ts:131-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L131-L138)）
- `presentResult` 在元数据不可用时回落到由参数重建的差异，仅结果为错误时返回 `undefined`（[packages/fs/tool-fs/src/write.ts:142-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-fs/src/write.ts#L142-L147)）

### packages/fs/tool-fs/tsconfig.json

该包的 TypeScript 编译配置，指定 rootDir/outDir 与工程引用。

- 无运行期机制
