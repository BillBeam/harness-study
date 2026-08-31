---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/fs/tool-str-replace-editor
---

# packages/fs/tool-str-replace-editor

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、50 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/fs/tool-str-replace-editor/README.md

该包的说明文档，描述 `str_replace_editor` 四个子命令的行为、配置项与失败恢复路径。

- 无运行期机制

### packages/fs/tool-str-replace-editor/package.json

该包的 npm 清单，声明入口、导出映射、发布文件集与依赖。

- `main`/`types` 与 `exports` 决定运行期可被解析的入口：根导出指向 `lib/index.js`，`./invariant` 指向 `lib/invariant.js`，另开放 `./package.json`（[packages/fs/tool-str-replace-editor/package.json:14-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/package.json#L14-L26)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/fs/tool-str-replace-editor/package.json:27-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/package.json#L27-L31)）

### packages/fs/tool-str-replace-editor/src/index.ts

整个工具的实现文件：模型可见 schema 与描述、四个子命令的分发、视图渲染、变更前的策略解析与写入，以及插件注册。

- 视图被裁剪时追加的固定提示文本，要求模型改用带行号的检索后重试（[packages/fs/tool-str-replace-editor/src/index.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L17)）
- 默认模型可见工具描述，写明状态跨调用持久、目录视图两层深、`create` 不能覆盖已有文件、长输出会被裁剪、null 占位等同省略，以及 `old_str` 必须逐字唯一匹配（[packages/fs/tool-str-replace-editor/src/index.ts:19-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L19-L31)）
- `maybeTruncate` 超过字符预算时保留前缀并拼接裁剪提示（[packages/fs/tool-str-replace-editor/src/index.ts:33-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L33-L37)）
- `matchOffsets` 顺序扫描出全部不重叠的字面匹配位置（[packages/fs/tool-str-replace-editor/src/index.ts:43-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L43-L52)）
- `lineNumbersAt` 单趟游标把偏移量换算成 1 基行号，用于歧义匹配的报错文本（[packages/fs/tool-str-replace-editor/src/index.ts:54-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L54-L64)）
- `MutationPolicy` 构造时：挂载的文件系统若声明限制模式而沙箱策略服务缺失，则直接抛错阻止插件装配（[packages/fs/tool-str-replace-editor/src/index.ts:69-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L69-L74)）
- `resolve` 按当前执行所属会话解析出这一次调用的沙箱执行策略（[packages/fs/tool-str-replace-editor/src/index.ts:76-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L76-L80)）
- `mapError` 把沙箱拒绝错误改写成带模式名的拒绝标记文本，其余错误原样传出（[packages/fs/tool-str-replace-editor/src/index.ts:82-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L82-L86)）
- `resolveTarget` 拒绝空白路径与相对路径，相对路径的报错文本给出补 `/` 的建议，然后交给文件系统服务解析（[packages/fs/tool-str-replace-editor/src/index.ts:89-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L89-L99)）
- `statExisting` 在元数据缺失时先发出 `fs/observed` 的"确认不存在"记录，再抛 `FS_NOT_FOUND`（[packages/fs/tool-str-replace-editor/src/index.ts:107-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L107-L114)）
- 目标是目录且命令不是 `view` 时抛 `FS_NOT_REGULAR_FILE`（[packages/fs/tool-str-replace-editor/src/index.ts:115-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L115-L121)）
- `requiredForCommand` 对缺失参数与（可选地）空字符串参数给出带参数名与命令名的错误（[packages/fs/tool-str-replace-editor/src/index.ts:124-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L124-L135)）
- `formatFileView` 在开头输出带总行数的提示行（[packages/fs/tool-str-replace-editor/src/index.ts:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L143-L147)）
- `view_range` 必须是两个整数，起始行须落在 `[1, 总行数]`，终止行不得超过总行数，非 `-1` 时不得小于起始行，逐条给出具体错误文本（[packages/fs/tool-str-replace-editor/src/index.ts:148-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L148-L174)）
- 终止行为 `-1` 时切到文件末尾，否则切到指定行，并把范围写进提示行（[packages/fs/tool-str-replace-editor/src/index.ts:175-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L175-L179)）
- 每行以宽度 6 右对齐行号加两个空格作前缀渲染，整体再过字符裁剪（[packages/fs/tool-str-replace-editor/src/index.ts:180-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L180-L183)）
- `listDirectory` 递归列目录时过滤掉以 `.` 开头的条目、依赖目录与 Python 缓存目录（[packages/fs/tool-str-replace-editor/src/index.ts:193-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L193-L198)）
- 每行以 `d`/`f`/`?` 类型标记加制表符加展示路径输出，并只在深度小于 2 时继续下潜（[packages/fs/tool-str-replace-editor/src/index.ts:199-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L199-L204)）
- 列表按路径码点序排序，整体过字符裁剪，并冠以说明排除项的固定表头（[packages/fs/tool-str-replace-editor/src/index.ts:207-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L207-L214)）
- `viewPath` 对目录拒绝 `view_range` 参数并转走目录列举（[packages/fs/tool-str-replace-editor/src/index.ts:226-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L226-L231)）
- 既非目录也非普通文件时抛 `FS_NOT_REGULAR_FILE`（[packages/fs/tool-str-replace-editor/src/index.ts:232-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L232-L234)）
- 读到文本后发出 `fs/observed` 的"存在且版本为 X"记录，再渲染带行号的视图（[packages/fs/tool-str-replace-editor/src/index.ts:235-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L235-L237)）
- `createFile` 先要求 `file_text`、解析沙箱策略与目标路径，目标已存在则拒绝覆盖（[packages/fs/tool-str-replace-editor/src/index.ts:247-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L247-L252)）
- 走 `fs/write-intent` 瀑布取写入意图，默认回落为"仅当不存在时创建"（[packages/fs/tool-str-replace-editor/src/index.ts:253-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L253-L258)）
- 带意图与沙箱策略调用写入，失败经错误映射后抛出；成功后发出 `fs/observed` 并返回创建成功文本（[packages/fs/tool-str-replace-editor/src/index.ts:259-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L259-L272)）
- `replaceInFile` 显式拒绝 `new_str: null`，要求删除时改为省略该参数（[packages/fs/tool-str-replace-editor/src/index.ts:283-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L283-L285)）
- 走 `fs/edit-intent` 瀑布取编辑意图，默认回落为 `undefined`；`old_str` 必填且不得为空串（[packages/fs/tool-str-replace-editor/src/index.ts:286-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L286-L291)）
- 零匹配抛 `FS_EDIT_NOT_FOUND`，多匹配抛 `FS_AMBIGUOUS_EDIT` 并列出全部行号（[packages/fs/tool-str-replace-editor/src/index.ts:296-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L296-L310)）
- 唯一匹配处做字面替换后写回，比较交换基准取自编辑意图的版本，无意图时取刚读到的版本（[packages/fs/tool-str-replace-editor/src/index.ts:311-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L311-L324)）
- 替换成功后发出 `fs/observed` 并返回编辑成功文本（[packages/fs/tool-str-replace-editor/src/index.ts:325-326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L325-L326)）
- `insertInFile` 要求 `insert_line` 与 `new_str`，并同样走 `fs/edit-intent` 瀑布（[packages/fs/tool-str-replace-editor/src/index.ts:337-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L337-L342)）
- 插入位置必须是 `[0, 行数]` 内的整数，否则给出带实际行数的错误（[packages/fs/tool-str-replace-editor/src/index.ts:348-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L348-L352)）
- 把新文本按行拆开插到该边界后重新拼接，不额外补尾随换行（[packages/fs/tool-str-replace-editor/src/index.ts:353-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L353-L357)）
- 以意图版本或观测版本作为比较交换基准写回，失败经错误映射，成功后发出 `fs/observed`（[packages/fs/tool-str-replace-editor/src/index.ts:358-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L358-L368)）
- `presentEditorCall` 按子命令给出不同调用卡片：`view` 是读卡、`create` 与 `str_replace` 是差异卡、`insert` 是编辑卡并把 0 基插入位换算为不小于 1 的行号（[packages/fs/tool-str-replace-editor/src/index.ts:376-423](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L376-L423)）
- 注册名为 `str_replace_editor` 的工具，描述取自配置（[packages/fs/tool-str-replace-editor/src/index.ts:428-430](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L428-L430)）
- 参数表把 `command` 限定为四个枚举值、`path` 要求绝对路径，二者必填（[packages/fs/tool-str-replace-editor/src/index.ts:431-442](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L431-L442)）
- 其余四个命令相关参数声明为 `string|null` 或 `integer|null` 的联合，允许模型传 null 占位（[packages/fs/tool-str-replace-editor/src/index.ts:443-458](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L443-L458)）
- `view_range` 声明为整数数组或 null，并说明省略或 null 表示看全文、`[start, -1]` 表示看到末尾（[packages/fs/tool-str-replace-editor/src/index.ts:459-465](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L459-L465)）
- 输出声明为字符串，`render` 原样转成一条文本内容（[packages/fs/tool-str-replace-editor/src/index.ts:467-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L467-L470)）
- `execute` 按 `command` 分发到四个实现，并在传参处把 null 折叠成 `undefined`（`str_replace` 的 `new_str` 例外，原样传入以便拒绝 null）（[packages/fs/tool-str-replace-editor/src/index.ts:471-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L471-L496)）
- 插件名与注入声明：依赖 `tools` 与 `fs` 两个服务（[packages/fs/tool-str-replace-editor/src/index.ts:501-502](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L501-L502)）
- 配置 schema 给出 `maxOutputChars` 默认 16000 与默认描述文本（[packages/fs/tool-str-replace-editor/src/index.ts:513-516](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L513-L516)）
- `apply` 在注册前拒绝非正安全整数的 `maxOutputChars` 与空白描述（[packages/fs/tool-str-replace-editor/src/index.ts:519-530](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L519-L530)）

### packages/fs/tool-str-replace-editor/src/invariant.ts

该包的不变量伴随插件，向不变量服务登记包名并安装一个空检查器。

- 声明伴随插件名与对 `invariants` 服务的注入（[packages/fs/tool-str-replace-editor/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/invariant.ts#L13-L15)）
- 以包名注册一个空安装器，并返回注册的释放函数（[packages/fs/tool-str-replace-editor/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/invariant.ts#L21-L29)）

### packages/fs/tool-str-replace-editor/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工作区引用。

- 无运行期机制
