---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/lsp/tool-lsp
---

# packages/lsp/tool-lsp

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、44 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/lsp/tool-lsp/README.md

`dsh-tool-lsp` 包的英文说明文档，介绍工具参数、结果上限、配置项与模型可见文本。

- 无运行期机制

### packages/lsp/tool-lsp/package.json

`@deepseek-ai/dsh-tool-lsp` 的 npm 清单，声明模块入口、导出映射与依赖。

- `type: module` 与 `main`/`types` 指定运行期加载的入口文件为 `lib/index.js`（[packages/lsp/tool-lsp/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/package.json#L13-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个子路径（[packages/lsp/tool-lsp/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/package.json#L16-L27)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/lsp/tool-lsp/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/package.json#L28-L32)）
- `dependencies` 只有 schemastery 一项，配置校验依赖随包安装（[packages/lsp/tool-lsp/package.json:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/package.json#L43-L45)）

### packages/lsp/tool-lsp/src/index.ts

该包的插件入口：校验配置、注册系统提示段落、注册模型可见的 `lsp` 工具及其执行体。

- 插件名与注入的三个服务 `tools`/`lsp`/`systemPrompt`（[packages/lsp/tool-lsp/src/index.ts:44-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L44-L48)）
- 默认工具调用超时预算为 60000 毫秒（[packages/lsp/tool-lsp/src/index.ts:50-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L50-L51)）
- 固定的系统提示文本逐字定义在此，交代何时使用该工具、坐标为一基 UTF-16、以及 `findReferences` 总含声明（[packages/lsp/tool-lsp/src/index.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L53-L55)）
- 配置模式给三个字段填默认值，超时字段上限为 `MAX_TIMER_DELAY_MS`（[packages/lsp/tool-lsp/src/index.ts:67-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L67-L71)）
- 位置与范围的输出模式关闭额外属性并要求 line/character、start/end 必填（[packages/lsp/tool-lsp/src/index.ts:75-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L75-L91)）
- 加载时校验两个上限是正整数、超时是不超过定时器上限的正整数（[packages/lsp/tool-lsp/src/index.ts:99-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L99-L102)）
- 以 `tool:lsp` 为名、按第一方段落序号注册系统提示段落（[packages/lsp/tool-lsp/src/index.ts:104-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L104-L108)）
- 注册名为 `lsp` 的工具，描述里写明四个操作与一基 UTF-16 坐标约定（[packages/lsp/tool-lsp/src/index.ts:110-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L110-L113)）
- 模型可见参数只有 `operation`（枚举四值）、`file_path`、`line`、`character` 四个必填项，提供者、语言标识、工作区与超时都不在其中（[packages/lsp/tool-lsp/src/index.ts:114-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L114-L124)）
- 输出模式是 locations 与 hover 两支的 `oneOf`，locations 支带 `uri`/`range` 数组与 `resolvedWorkspaceUri`，hover 支允许 null（[packages/lsp/tool-lsp/src/index.ts:125-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L125-L170)）
- 渲染函数按结果标签分派到位置格式化或悬浮格式化，并把两个上限传进去，即模型读到的是被上限约束后的文本（[packages/lsp/tool-lsp/src/index.ts:171-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L171-L181)）
- 把解析后的超时预算挂到工具定义上，交由超时策略执行（[packages/lsp/tool-lsp/src/index.ts:183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L183)）
- 执行体先解析并转换参数，再从会话取工作区根；取不到就抛 `LSP_WORKSPACE_REQUIRED`，不做任何回退（[packages/lsp/tool-lsp/src/index.ts:184-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L184-L189)）
- 向 `ctx.lsp.query` 发出请求，只透传 `exec.signal` 作为取消信号（[packages/lsp/tool-lsp/src/index.ts:190-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L190-L195)）
- 返回值逐字段复制服务定义的闭合联合，位置与范围保持零基原值，供原生渲染方直接读取（[packages/lsp/tool-lsp/src/index.ts:196-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L196-L229)）
- 挂上调用展示函数，决定客户端看到的卡片（[packages/lsp/tool-lsp/src/index.ts:231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L231)）
- 两个校验函数在配置非法时于加载期抛错（[packages/lsp/tool-lsp/src/index.ts:235-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/index.ts#L235-L247)）

### packages/lsp/tool-lsp/src/invariant.ts

该包的不变量伴随插件，向 `invariants` 服务登记包名。

- `inject = ['invariants']` 使伴随插件在该服务就绪前不运行（[packages/lsp/tool-lsp/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/invariant.ts#L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/lsp/tool-lsp/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/invariant.ts#L21)）
- `apply` 向 `ctx.invariants` 以包名登记该空安装器并返回其注销函数（[packages/lsp/tool-lsp/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/invariant.ts#L28-L29)）

### packages/lsp/tool-lsp/src/render.ts

该工具的纯格式化层：参数校验与坐标换算、位置渲染与 URI 解析、结果截断、调用卡片。

- 四个操作以运行期元组形式给出，同时供参数模式的枚举与执行期校验使用（[packages/lsp/tool-lsp/src/render.ts:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L14-L15)）
- 默认位置条数上限 100、默认结果字符上限 16000（[packages/lsp/tool-lsp/src/render.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L17-L21)）
- 参数解析拒绝不在四值之内的 `operation` 与空白的 `file_path`（[packages/lsp/tool-lsp/src/render.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L46-L50)）
- 行列必须是正整数，随后各减 1 转成服务定义与协议的零基位置（[packages/lsp/tool-lsp/src/render.ts:51-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L51-L58)）
- `oneBased()` 对非正整数抛出点名字段的错误（[packages/lsp/tool-lsp/src/render.ts:66-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L66-L72)）
- 位置为空时渲染成独立的 `No results.` 行并同样过字符上限（[packages/lsp/tool-lsp/src/render.ts:91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L91)）
- 先按 `maxLocations` 截取并记下被省略条数（[packages/lsp/tool-lsp/src/render.ts:92-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L92-L93)）
- 每条位置的 URI 经解析后按文件分组，行列各加 1 渲染成 `path:line:character`（[packages/lsp/tool-lsp/src/render.ts:94-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L94-L104)）
- 有省略时追加带条数与上限的省略标记，然后整段再过字符上限（[packages/lsp/tool-lsp/src/render.ts:105-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L105-L108)）
- 无悬浮渲染成 `No hover information.`，有则取归一化文本，二者都过字符上限（[packages/lsp/tool-lsp/src/render.ts:117-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L117-L120)）
- 截断把提示语本身算进上限内：正文被切到「上限减提示长度」，提示比上限还长时只保留被切短的提示（[packages/lsp/tool-lsp/src/render.ts:122-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L122-L128)）
- 非 `file:` 前缀的 URI 与解析失败的 URI 原样保留（[packages/lsp/tool-lsp/src/render.ts:138-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L138-L148)）
- 用主机名非空或 `/X:` 盘符样式判断执行世界是否为 Windows，据此选择解码方式与路径语义（[packages/lsp/tool-lsp/src/render.ts:149-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L149-L156)）
- 解码失败保留原 URI，两侧世界判定不一致时输出目标绝对路径（[packages/lsp/tool-lsp/src/render.ts:157-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L157-L158)）
- 工作区内的目标渲染成相对路径，等于工作区渲染成 `.`，落在工作区外渲染成绝对路径，Windows 世界的反斜杠统一换成正斜杠（[packages/lsp/tool-lsp/src/render.ts:159-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L159-L163)）
- URL 解码按目标世界的平台规则进行，含 NUL 字符或解码抛错都返回未定义（[packages/lsp/tool-lsp/src/render.ts:166-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L166-L175)）
- 调用展示只依赖工具参数，产出 `generic`/`search` 卡片：标题带操作与一基行列，`locations` 只带路径与行（[packages/lsp/tool-lsp/src/render.ts:184-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/render.ts#L184-L191)）

### packages/lsp/tool-lsp/src/session-cwd.ts

从工具执行上下文取出工作区根的单函数模块，被 index.ts 的执行体调用。

- 工作区根只取调用方 Agent 会话头部的 `cwd`，非 Agent 调用得到未定义（[packages/lsp/tool-lsp/src/session-cwd.ts:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/lsp/tool-lsp/src/session-cwd.ts#L15-L17)）

### packages/lsp/tool-lsp/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
