---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-skill
---

# packages/client/ui-skill

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、58 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-skill/README.md

技能引用包的说明文档，带 description/kind 前置元数据，描述 `/` 触发的候选来源、字面文本落盘与技能工具行的呈现。

- 无运行期机制

### packages/client/ui-skill/package.json

包清单，声明入口产物、浏览器半侧注入声明与发布文件白名单。

- `exports` 把 `.`、`./invariant`、`./client` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 及各自的类型文件，并开放 `./src/*` 原样路径（[packages/client/ui-skill/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/package.json#L16-L31)）
- `dsh.client.inject` 列出浏览器半侧加载前必须就位的六个包，`platform` 固定为 `web`（[packages/client/ui-skill/package.json:32-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/package.json#L32-L44)）
- `peerDependencies` 构成打包预设判定"保持为 import"的生产依赖集合（[packages/client/ui-skill/package.json:50-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/package.json#L50-L61)）
- `files` 把发布内容限定为三个 js 产物加 `lib/types` 下的声明文件（[packages/client/ui-skill/package.json:81-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/package.json#L81-L86)）

### packages/client/ui-skill/src/client/SkillRow.module.css

技能工具行的 CSS Module，由 SkillRow.tsx 通过 `data-state`、`data-expandable`、`data-error` 等属性驱动。

- `.row[data-expandable]` 才给出指针光标（[packages/client/ui-skill/src/client/SkillRow.module.css:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.module.css#L17-L19)）
- `data-state='running'` 时用伪元素铺一条 2.6s 无限循环的横扫渐变，并关闭其指针事件（[packages/client/ui-skill/src/client/SkillRow.module.css:21-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.module.css#L21-L39)）
- 行悬停时把静态图标透明度置 0、把叠放的展开箭头透明度置 1（[packages/client/ui-skill/src/client/SkillRow.module.css:71-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.module.css#L71-L77)）
- `.errorSummary` 把摘要文字改为错误色（[packages/client/ui-skill/src/client/SkillRow.module.css:106-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.module.css#L106-L108)）
- 展开的说明卡片被 `max-height: 260px` 加 `overflow: hidden` 限高，内部 `pre` 自行滚动（[packages/client/ui-skill/src/client/SkillRow.module.css:115-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.module.css#L115-L148)）
- `.instructions[data-error]` 把正文改为错误色（[packages/client/ui-skill/src/client/SkillRow.module.css:150-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.module.css#L150-L152)）
- 查看按钮默认透明度 0，仅在卡片悬停或按钮获得可见焦点时显现（[packages/client/ui-skill/src/client/SkillRow.module.css:177-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.module.css#L177-L185)）
- `.visuallyHidden` 把状态文案裁剪到 1px 并裁切，使其只对辅助技术可读（[packages/client/ui-skill/src/client/SkillRow.module.css:192-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.module.css#L192-L199)）
- `prefers-reduced-motion: reduce` 时把运行态横扫伪元素整个 `display: none`，并关闭三处过渡（[packages/client/ui-skill/src/client/SkillRow.module.css:201-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.module.css#L201-L212)）

### packages/client/ui-skill/src/client/SkillRow.tsx

`skill` 工具调用的专用呈现组件，注册在 ui-tool 的 `tool.call.toolview` 键控槽上，只从冻结的调用/结果切片派生视图。

- `firstLine` 取首个换行符之前的文本，找不到换行则原样返回（[packages/client/ui-skill/src/client/SkillRow.tsx:23-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L23-L26)）
- `skillName` 解析 `argsRaw` 的 JSON 取 `name` 字段首行；解析抛错被吞掉，最终回落为空串时的 `callId` 或 `argsRaw` 首行（[packages/client/ui-skill/src/client/SkillRow.tsx:28-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L28-L41)）
- `resultText` 把结果块的 content 展平成文本：`text` 项直取，其余项按缩进 2 的 JSON 序列化；无内容但有 error 时用 `name: code` 顶替；空结果归为 null（[packages/client/ui-skill/src/client/SkillRow.tsx:43-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L43-L55)）
- `skillRowModel` 以 `'kind' in block` 判定是否已落定，据此选取 `argsRaw` 来源，并把状态推为 running / stopped（error.code 为 `interrupted`）/ error / ok，错误态才计算摘要首行（[packages/client/ui-skill/src/client/SkillRow.tsx:57-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L57-L73)）
- `leadingFor` 按状态换前导元素：error 用错误状态点、stopped 用警告状态点、其余用技能图标（[packages/client/ui-skill/src/client/SkillRow.tsx:75-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L75-L82)）
- `disclosureLeading` 在展开时只渲染箭头，不可展开时只渲染状态图标，可展开且未展开时把图标与悬停箭头一起渲染以供 CSS 互换（[packages/client/ui-skill/src/client/SkillRow.tsx:84-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L84-L95)）
- `stateStatus` 为 running/error/stopped 三态取对应词条，正常态返回 null（[packages/client/ui-skill/src/client/SkillRow.tsx:97-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L97-L105)）
- 组件持有本地 `expanded` 状态，`expandable` 由 `output !== null` 决定，`open` 需两者同时成立（[packages/client/ui-skill/src/client/SkillRow.tsx:113-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L113-L118)）
- 键盘处理只在可展开且按键为 Enter 或空格时 `preventDefault` 并翻转展开态（[packages/client/ui-skill/src/client/SkillRow.tsx:122-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L122-L126)）
- 仅在可展开时才把 `role="button"`、`tabIndex=0`、`aria-expanded` 与点击/键盘处理挂到行上（[packages/client/ui-skill/src/client/SkillRow.tsx:127-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L127-L133)）
- 根节点写出 `data-tool="skill"` 与 `data-state=<状态>`，行上写出 `data-expandable`（[packages/client/ui-skill/src/client/SkillRow.tsx:136-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L136-L141)）
- 折叠行渲染前导槽、仅在有状态文案时插入的视觉隐藏文本、标题词条、分隔点与摘要（错误态取错误首行，否则取技能名）（[packages/client/ui-skill/src/client/SkillRow.tsx:142-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L142-L148)）
- 展开时渲染带 `aria-label` 的说明区，`pre` 内直出 `model.output` 并按错误态打 `data-error`（[packages/client/ui-skill/src/client/SkillRow.tsx:150-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L150-L155)）
- 仅当上游传入 `inspect` 时才渲染查看按钮，点击直接调用它（[packages/client/ui-skill/src/client/SkillRow.tsx:156-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/SkillRow.tsx#L156-L161)）

### packages/client/ui-skill/src/client/index.ts

技能插件的浏览器半侧插件体，注册 `/` 触发的候选来源、字典与键控工具行，并维护按会话缓存的技能目录。

- `inject` 声明所需服务，包括 `inputTriggers`、`connection`、`sessions`、`slots`、`locale`、`remote` 与 `remote.skills`（[packages/client/ui-skill/src/client/index.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L61)）
- 以 effect 形式把 `skill` 命名空间的中英字典注册进 locale 服务（[packages/client/ui-skill/src/client/index.ts:68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L68)）
- 用 `ctx.slots.inject` 把 `SkillRow` 注册到 `tool.call.toolview` 槽的 `skill` 键上，并声明 locale 命名空间（[packages/client/ui-skill/src/client/index.ts:69-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L69-L72)）
- 插件闭包持有按 sessionId 键的目录取回表与词表监听器表（[packages/client/ui-skill/src/client/index.ts:78-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L78-L80)）
- `notifyLexicon` 遍历监听器副本逐个调用，并用 try/catch 把单个监听器的抛错收敛为一条 console.error（[packages/client/ui-skill/src/client/index.ts:82-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L82-L93)）
- `fetchCatalog` 对有子代理地址的会话直接返回空数组，不发 RPC（[packages/client/ui-skill/src/client/index.ts:96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L96)）
- 同一 sessionId 已有在飞取回时复用其 promise，实现单飞（[packages/client/ui-skill/src/client/index.ts:97-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L97-L98)）
- 每次取回自带 `AbortController`，调用 `skills.list({ sessionId }, signal)`，结果非 ok 时抛出带错误码与错误信息的 Error（[packages/client/ui-skill/src/client/index.ts:99-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L99-L105)）
- 取回成功把结果写入 `settled` 并通知词表监听器；取回失败在该条目仍是当前条目时把键删掉，使下一个消费者重新发起（[packages/client/ui-skill/src/client/index.ts:107-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L107-L117)）
- `invalidate` 删除该会话的缓存条目、中止其在飞请求并通知词表监听器（[packages/client/ui-skill/src/client/index.ts:121-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L121-L127)）
- `clearAll` 对当前所有键逐一执行 `invalidate`（[packages/client/ui-skill/src/client/index.ts:129-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L129-L131)）
- 取一个绑定到本命名空间的 `t`，供候选文本使用（[packages/client/ui-skill/src/client/index.ts:135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L135)）
- 来源对象把触发字符定为 `/`、名字定为 `skill`、排序权重定为 2（[packages/client/ui-skill/src/client/index.ts:137-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L137-L140)）
- `candidates` 等目录返回后先查 `signal.aborted` 决定是否让位，再按 `name.startsWith(query)` 过滤，并给 `modelInvocable` 为假的条目在描述前拼上"仅用户"标记（[packages/client/ui-skill/src/client/index.ts:141-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L141-L153)）
- `warm` 在作用域诞生时发起一次不等待的预取，异常被吞掉（[packages/client/ui-skill/src/client/index.ts:154-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L154-L158)）
- `lexicon` 同步返回该会话已落定目录的技能名数组，未落定时返回 undefined（[packages/client/ui-skill/src/client/index.ts:159-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L159-L161)）
- `subscribeLexicon` 按会话维护监听器集合，返回的注销函数在集合清空后连键一起删除（[packages/client/ui-skill/src/client/index.ts:162-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L162-L171)）
- `onPick` 只把 `/<技能名> ` 这段字面文本落进草稿，不产生任何结构化引用（[packages/client/ui-skill/src/client/index.ts:172-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L172-L181)）
- 监听转发来的 `agent-preset/selected` 事件，按其携带的会话键失效对应缓存（[packages/client/ui-skill/src/client/index.ts:186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L186)）
- 监听 `connection/reset` 并清空全部缓存（[packages/client/ui-skill/src/client/index.ts:187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L187)）
- 以 effect 形式向 `inputTriggers` 注册来源，拆卸时先注销来源再清空全部缓存（[packages/client/ui-skill/src/client/index.ts:188-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/index.ts#L188-L194)）

### packages/client/ui-skill/src/client/locales.ts

`skill` 命名空间的中英词条表与命名空间常量，被同目录的 index.ts 用于注册与绑定。

- 导出命名空间常量 `NS = 'skill'`，字典注册、槽注册的 `locale` 字段与 `t` 绑定都以它为键（[packages/client/ui-skill/src/client/locales.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/client/locales.ts#L4)）

### packages/client/ui-skill/src/css-modules.d.ts

CSS Module 的环境声明文件，只为 TypeScript 提供 `*.module.css` 的默认导出类型。

- 无运行期机制

### packages/client/ui-skill/src/index.ts

宿主侧加载入口，`apply` 为空函数，浏览器半侧另经 `exports["./client"]` 发现。

- 无运行期机制

### packages/client/ui-skill/src/invariant.ts

本包的 invariant companion 插件，向 invariants 服务登记包归属。

- `inject` 声明必须先有 `invariants` 服务，companion 才能加载（[packages/client/ui-skill/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/invariant.ts#L15)）
- installer 为空实现，附带说明该包不注册任何运行期不变量（[packages/client/ui-skill/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/invariant.ts#L23)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并以 Promise 返回其 disposer（[packages/client/ui-skill/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/src/invariant.ts#L30-L31)）

### packages/client/ui-skill/tsconfig.json

本包的编译配置，继承客户端基线配置。

- `rootDir` 设为 `src`、`outDir` 设为 `lib/types`，决定了 package.json 与打包配置引用的产物路径（[packages/client/ui-skill/tsconfig.json:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/tsconfig.json#L3-L6)）
- `references` 列出十一个工作区项目，决定本包编译前必须先产出的依赖项目（[packages/client/ui-skill/tsconfig.json:10-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/tsconfig.json#L10-L44)）

### packages/client/ui-skill/tsdown.config.ts

本包的打包配置，直接套用客户端插件的共享预设。

- 调用 `clientBundle` 并把 node 半侧入口点名为 `lib/types/index.js` 与 `lib/types/invariant.js`，由预设在此之外追加浏览器侧 `client` 包（[packages/client/ui-skill/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-skill/tsdown.config.ts#L3)）
