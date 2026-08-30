---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/skill/tool-skill
---

# packages/skill/tool-skill

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、43 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/skill/tool-skill/README.md

模型面技能目录与加载工具的英文说明文档，包含配置项说明与模型可见文本的模板抄录。

- 无运行期机制

### packages/skill/tool-skill/package.json

该包的 npm 清单，声明入口、导出子路径与发布文件集。

- `main`/`types` 与 `exports` 把包名解析到 `lib/index.js`，`./invariant` 解析到 `lib/invariant.js`，并暴露 `./src/*`（[packages/skill/tool-skill/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/package.json#L14-L27)）
- `files` 限定发布产物为两个 lib 入口与类型声明（[packages/skill/tool-skill/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/package.json#L28-L32)）
- `dependencies` 声明运行期需要 schemastery（[packages/skill/tool-skill/package.json:42-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/package.json#L42-L44)）

### packages/skill/tool-skill/src/index.ts

模型面消费方的实现文件：注册 `skill` 工具、在每步前维护会话技能目录消息，并处理用户 `/name` 手势的技能注入。

- 导出 `name` 与 `inject`，使插件以 `tool-skill` 名加载并要求 `agents`、`tools`、`skills` 三个服务先就绪（[packages/skill/tool-skill/src/index.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L24-L25)）
- 目录描述长度默认 500（[packages/skill/tool-skill/src/index.ts:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L27)）
- 声明合并把 `skill-catalog` 注册为消息来源类型，使目录消息在会话日志中带有其发布过的条目清单（[packages/skill/tool-skill/src/index.ts:34-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L34-L47)）
- `catalogSourceEntries` 把摘要投影成只含名与截断后描述的持久条目（[packages/skill/tool-skill/src/index.ts:50-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L50-L58)）
- `Config` schema 给 `catalogDescriptionMaxLength` 设默认值，`apply` 再断言其为不小于 3 的整数（[packages/skill/tool-skill/src/index.ts:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L67-L69)、[packages/skill/tool-skill/src/index.ts:78-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L78-L79)）
- `skill` 工具的名称与描述文本进入模型可见的工具清单，并指示按会话目录中的确切名调用（[packages/skill/tool-skill/src/index.ts:82-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L82-L83)）
- 工具参数只有一个必填 `name` 字符串（[packages/skill/tool-skill/src/index.ts:84-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L84-L86)）
- 输出 schema 固定结果字段为 name、provider、三选一的 resourceBase 与 content（[packages/skill/tool-skill/src/index.ts:87-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L87-L124)）
- `render` 把结果交给共享的 `renderSkillContent`，使工具结果与用户手势注入产出同一种 `<skill_content>` 文本（[packages/skill/tool-skill/src/index.ts:125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L125)）
- `execute` 对非法名直接抛出 `invalid skill name` 错误（[packages/skill/tool-skill/src/index.ts:128-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L128-L130)）
- 查询以调用方 agent 自身为作用域键、以其会话 cwd 与执行 signal 组成 lookup（[packages/skill/tool-skill/src/index.ts:133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L133)）
- 先在目录中查摘要，缺失抛"未知或不再可用"，非模型可调用抛"不可用于模型调用"（[packages/skill/tool-skill/src/index.ts:134-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L134-L140)）
- 加载定义后再次做同样两项检查，未通过同样抛出对应错误（[packages/skill/tool-skill/src/index.ts:141-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L141-L147)）
- 返回值只带出 name、provider、resourceBase 副本与 content，路径、来源与 rank 不进入结果（[packages/skill/tool-skill/src/index.ts:148-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L148-L155)）
- `presentCall` 决定该调用在外部界面上呈现为 read 类的通用卡片与标题（[packages/skill/tool-skill/src/index.ts:157-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L157-L159)）
- `ctx.tools.register` 把该工具定义注册进调用上下文所属作用域（[packages/skill/tool-skill/src/index.ts:161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L161)）
- 手势监听器注册在目录监听器之前，先 `await next()` 并在决策为 reject 时原样透传（[packages/skill/tool-skill/src/index.ts:177-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L177-L183)）
- 对扫出的每个名做一次加载，未知或非用户可调用的技能被跳过、保持为普通文本（[packages/skill/tool-skill/src/index.ts:186-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L186-L195)）
- 命中的技能被渲染成 `<skill_content>` 文本、包成带 `skill-invocation` 来源的用户消息，并追加到该步消息批的末尾（[packages/skill/tool-skill/src/index.ts:196-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L196-L203)）
- 目录监听器把可见性判定为 `ctx.tools.get(name, agent)` 恰好等于本插件注册的那个定义对象；不可见时按空目录处理（[packages/skill/tool-skill/src/index.ts:220-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L220-L223)）
- 快照不完整时本步不改动任何消息，保留上一份目录（[packages/skill/tool-skill/src/index.ts:225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L225)）
- 只有模型可调用的技能进入目录条目，并逐条按上限截断描述后算出摘要指纹（[packages/skill/tool-skill/src/index.ts:226-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L226-L229)）
- 指纹与会话中最新可见目录一致时不发新目录，并移除本步已存在的同类消息（[packages/skill/tool-skill/src/index.ts:231-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L231-L235)）
- 本步已带同指纹目录消息时直接沿用（[packages/skill/tool-skill/src/index.ts:236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L236)）
- 从未发布过且当前为空时完全不发目录（[packages/skill/tool-skill/src/index.ts:237-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L237-L241)）
- 已发布过则渲染替换版目录、否则渲染首发版目录，并按本步是否已有目录消息决定追加还是原地替换（[packages/skill/tool-skill/src/index.ts:242-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L242-L250)）
- 首发目录文本用 `<system-reminder>` 与 `<available_skills>` 包裹条目，并指示：先调 `skill` 工具再行动、只有摘要不得据以推断指令、用户直接调用出现的 `<skill_content>` 应直接遵循且不再重复加载（[packages/skill/tool-skill/src/index.ts:254-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L254-L277)）
- 替换目录文本声明本清单取代此前所有清单，并在空/非空两种情形下分别给出"不得再用旧名"与"只用本清单中的名"的指示（[packages/skill/tool-skill/src/index.ts:279-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L279-L311)）
- 目录行渲染时对描述做 `escapeText` 转义，转义只作用于呈现文本、不写入持久条目（[packages/skill/tool-skill/src/index.ts:319-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L319-L321)）
- 指纹对每条目做 JSON 序列化后换行拼接再取 sha256，使描述中的分隔符不会造成边界歧义（[packages/skill/tool-skill/src/index.ts:328-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L328-L335)）
- `readCatalogEntries` 对来源记录做宽容读取，条目非数组、非对象、名为空或描述非串时整体判为不可读而非抛错（[packages/skill/tool-skill/src/index.ts:348-359](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L348-L359)）
- `catalogHistory` 从会话事件尾部倒扫 `user/message` 中的 `skill-catalog` 记录，得出"是否发布过"以及最近一条仍在可见面上的目录指纹（[packages/skill/tool-skill/src/index.ts:361-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L361-L377)）
- `catalogMessage` 在本步消息批中找出第一条可读的目录消息及其条目（[packages/skill/tool-skill/src/index.ts:379-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L379-L388)）
- `catalogDescription` 把连续空白压成单空格并 trim，超长时截到上限减 3 并接 `...`（[packages/skill/tool-skill/src/index.ts:390-393](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L390-L393)）
- `SKILL_GESTURE` 正则规定手势为前后有空白边界的单个 `/name` 记号，从而排除路径与分数写法（[packages/skill/tool-skill/src/index.ts:408](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L408)）
- `invokedSkillNames` 只扫描来源为 `user` 的消息的文本块，并按首次出现顺序去重（[packages/skill/tool-skill/src/index.ts:417-430](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/index.ts#L417-L430)）

### packages/skill/tool-skill/src/invariant.ts

该包的不变量伴生插件，由不变量服务在启动检查时加载。

- 导出 `name` 与 `inject`，使 Cordis 以 `tool-skill-invariant` 名加载并要求 `invariants` 服务先就绪（[packages/skill/tool-skill/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/invariant.ts#L13-L15)）
- `apply` 以包名注册一个空安装器并返回其 disposer（[packages/skill/tool-skill/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/invariant.ts#L21)、[packages/skill/tool-skill/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/tool-skill/src/invariant.ts#L28-L29)）

### packages/skill/tool-skill/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
