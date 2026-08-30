---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-agent-preset
---

# packages/client/ui-agent-preset

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 21 个文件、142 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-agent-preset/README.md

包的英文说明页，讲这四个 preset 界面（默认设置行、新会话 chip、会话头标签、名册管理区）各自做什么，供使用者与维护者阅读。

- 无运行期机制

### packages/client/ui-agent-preset/package.json

包清单，声明入口、浏览器半边的注入清单和发布内容。

- `exports` 把 `.`、`./invariant`、`./client`、`./src/*` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与源码目录（[packages/client/ui-agent-preset/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/package.json#L16-L31)）
- `dsh.client` 列出浏览器半边加载前必须先注入的包，并把平台标为 `web`（[packages/client/ui-agent-preset/package.json:32-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/package.json#L32-L46)）
- `files` 把发布内容限定为三个 bundle 与类型声明（[packages/client/ui-agent-preset/package.json:88-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/package.json#L88-L93)）

### packages/client/ui-agent-preset/src/client/AgentPresetLabel.module.css

会话头标签的样式表。

- 无运行期机制

### packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx

会话头里显示本会话所用 preset 的只读标签组件，注册到 `conversation.session.header.actions` 槽位。

- 从会话快照的 `projectionValues.agentPreset` 取值，只接受字符串（[packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx#L46-L49)）
- 订阅名册快照的 `options`（[packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx#L50)）
- 只有当会话确实记录了 preset 时才触发 `load()` 去读名册（[packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx:52-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx#L52-L56)）
- 会话没有记录 preset 时返回 null，不渲染任何东西（[packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx#L58)）
- 在名册里按 id 找到对应项后用 `presetDisplayText` 解析显示文案（[packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx:60-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx#L60-L61)）
- 名字缺失时回落到原始 id，`title` 缺描述时回落到 `headerHint` 文案（[packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx:63-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetLabel.tsx#L63-L66)）

### packages/client/ui-agent-preset/src/client/AgentPresetRow.module.css

通用设置里那一行 preset 选择器的样式表。

- 无运行期机制

### packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx

通用设置面板里的「Agent 预设」行组件，注册到 `settings.general.item` 槽位，写的是后续新建会话的默认 preset。

- 首次渲染即调用 `load()` 读名册（[packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx:42-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx#L42-L44)）
- 状态变为不可写或 `unavailable` 时强制关闭已展开的菜单（[packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx#L46-L49)）
- `status === 'unavailable'` 时整行返回 null（[packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx#L53)）
- `loading` 与 `saving` 都算作 busy（[packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx#L54)）
- 按钮文案取当前值的显示名，名册未到时用 `loading` 文案，无显示名时回落到 id（[packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx:57-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx#L57-L59)）
- 有错误时用错误文本替换描述文案（[packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx#L60)）
- 描述节点只在有错误时带 `role="alert"`（[packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx#L66)）
- busy、不可写或选项为空时禁用选择器（[packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx:75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx#L75)）
- 菜单选中即调用 `select(id)` 写入默认 preset（[packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetRow.tsx#L78)）

### packages/client/ui-agent-preset/src/client/AgentPresetSeat.module.css

新会话屏 preset chip 的样式表，含入场动画关键帧。

- `.introChar` 初始 `opacity: 0` 且动画 `forwards`，每个字符在其（由组件内联设置的）延迟到达前不可见（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.module.css:67-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.module.css#L67-L84)）
- `prefers-reduced-motion: reduce` 下取消动画并把不透明度直接置为 1（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.module.css:86-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.module.css#L86-L92)）

### packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx

新会话屏上的 preset chip 组件，注册到 `conversation.hero.agentPreset` 槽位，负责暂存下一个会话要用的 preset 并展示被拒绝的切换。

- 定义入场时序常量：图标时长、每字符间隔、总揭示窗口、字符淡入时长（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L47-L50)）
- 定义被拒绝提示条的停留时长为 8000ms（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L62)）
- 每字符起始偏移取 `INTRO_CHAR_STAGGER_MS` 与总窗口除以字符数的较小者，单字符为 0（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:69-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L69-L72)）
- 首次渲染即调用 `load()`（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:93-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L93-L95)）
- `ready` 要求选项非空且当前值非空字符串（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:97-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L97-L100)）
- 入场提示副作用：字符数为 0 或系统要求减少动效时直接调用 `introduced()`，否则起定时器在总时长后收尾并调用 `introduced()`（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:107-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L107-L120)）
- 未就绪时整个 chip 返回 null（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L124)）
- 入场期间把名字拆成逐字符 span，并把 `animationDelay` 内联算到每个字符上（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:128-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L128-L144)）
- 菜单项由 `state.options` 生成，每项渲染名称加描述，无描述时用 `noDescription` 文案（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:151-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L151-L164)）
- 选中后关闭菜单并调用 `select(id)`（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:166-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L166-L169)）
- `select` 返回拒绝原因时自增序号并置提示条文本，返回 undefined 则不提示（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:173-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L173-L180)）
- 触发按钮的 `title` 优先用 `state.error`，`busy` 时禁用，点击切换菜单开合（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:184-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L184-L198)）
- 提示条以序号为 key，按 `REFUSAL_HOLD_MS` 停留，锚定到页面上 `[data-composer-card]` 元素，结束后清空（[packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx:200-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSeat.tsx#L200-L213)）

### packages/client/ui-agent-preset/src/client/AgentPresetSection.module.css

设置页 preset 管理区的样式表，含卡片、坏卡提示、图标按钮提示与对话框布局。

- `.brokenTip` 默认 `opacity: 0`，仅在徽标 hover 或卡片主体 `:focus-visible` 时显示（[packages/client/ui-agent-preset/src/client/AgentPresetSection.module.css:102-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.module.css#L102-L130)）
- `.cardBrokenReason` 用 1px 尺寸加 `clip` 把损坏原因移出视觉呈现，只留给读屏（[packages/client/ui-agent-preset/src/client/AgentPresetSection.module.css:146-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.module.css#L146-L153)）
- `.cardDesc` 以 `-webkit-line-clamp: 4` 加固定 `min-height` 截断描述，这一截断正是组件测量 `scrollHeight > clientHeight` 的依据（[packages/client/ui-agent-preset/src/client/AgentPresetSection.module.css:226-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.module.css#L226-L237)）
- `.iconButton::after` 用 `content: attr(data-tip)` 把按钮的 `data-tip` 属性渲染成气泡文字，hover 或 `:focus-visible` 时显现（[packages/client/ui-agent-preset/src/client/AgentPresetSection.module.css:284-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.module.css#L284-L305)）

### packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx

设置页里的 preset 管理区组件，注册到 `settings.section` 槽位，含名册卡片、复制对话框、只读查看器与删除确认框。

- 复制对话框根据 `draftBlocker` 结果与草稿自身错误决定提示文本（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:78-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L78-L79)）
- 对话框标题里的来源名优先取名册行的显示名，取不到才用草稿里记的 `fromTitle`（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:80-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L80-L81)）
- 保存中禁用取消按钮（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:93-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L93-L97)）
- 草稿为空、保存中或存在阻塞原因时禁用创建按钮，保存中改显示 `creating` 文案（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:99-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L99-L105)）
- 两个输入框把每次输入直接写回控制器的 `setCopyId` / `setCopyName`（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:114-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L114-L132)）
- 对话框提示文本以 `role="alert"` 渲染（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L133)）
- 卡片描述在布局副作用里比较 `scrollHeight` 与 `clientHeight` 判断是否被截断，并用 `ResizeObserver` 在尺寸变化时重测（无该 API 时跳过订阅）（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:150-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L150-L161)）
- 仅在描述确实被截断时才挂 Tooltip，并把描述节点的 `title` 置空串以压掉原生提示（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:165-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L165-L168)）
- 首次渲染即调用 `load()`（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:187-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L187-L189)）
- `status === 'unavailable'` 时整区返回 null（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L193)）
- `status === 'error'` 时只渲染带 `role="alert"` 的错误行与一个重新调用 `load()` 的重试按钮（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:194-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L194-L205)）
- 只有当注入面提供 `startCreatorDraft` 且名册里存在 id 为 `cordis` 的行时才渲染创作入口；不可写时禁用并把原因挂在 `title` 上；点击先调 `startCreatorDraft()` 再调 `props.close()` 关掉设置面板（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:212-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L212-L228)）
- 按 `trust` 分成内置与自定义两组渲染，某组为空且无尾部入口时整组不渲染（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:235-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L235-L242)）
- 卡片类名按 `broken` 优先、其次 `isDefault` 选择（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:251-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L251-L253)）
- 卡片主体是按钮：`aria-pressed` 跟随默认态，已是默认时 `disabled`，损坏时用 `aria-disabled` 保留在 tab 序里，`aria-label` 与 `title` 三态取文案，点击时对损坏行直接返回、否则调用 `makeDefault(row.id)`（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:263-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L263-L283)）
- 损坏行渲染徽标，徽标内的原因气泡标 `aria-hidden="true"`（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:287-298](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L287-L298)）
- 卡片描述取 preset 自己的描述，缺失时用 `noDescription` 文案（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:304](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L304)）
- 损坏原因另有一份视觉隐藏的 `role="alert"` 节点（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:309-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L309-L311)）
- 卡片底部固定显示 preset 的 id（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L312)）
- 内置且未损坏的行才给查看按钮，点击调用 `view(row.id)`；内置且损坏的行不给任何第一个动作（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:322-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L322-L335)）
- 自定义行给定位按钮，文案按 `state.hasDocument` 在「打开目录」与「查看路径」之间切换，点击调用 `openLocation(row.id)`（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:336-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L336-L346)）
- 复制按钮在不可写或行损坏时禁用，提示文案按这两种原因分别取，点击调用 `beginCopy(row.id)`（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:347-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L347-L358)）
- 只有自定义行渲染删除按钮，点击调用 `confirmDelete(row.id)`（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:359-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L359-L371)）
- 该行在 `revealedPaths` 里有记录时，在卡片下方渲染目录路径（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:373-380](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L373-L380)）
- 复制对话框只接收 `cancelCopy`/`confirmCopy`/`setCopyId`/`setCopyName` 四个动作（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:389-398](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L389-L398)）
- 查看器弹窗在 `state.view` 非空时打开，把组装文本原样放进 `<pre>`，关闭调用 `closeView()`（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:399-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L399-L415)）
- 删除确认框在 `pendingDelete` 非空时打开，取消调用 `confirmDelete(null)`，确认调用 `remove()`，删除进行中禁用两个按钮并改文案（[packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx:416-443](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/AgentPresetSection.tsx#L416-L443)）

### packages/client/ui-agent-preset/src/client/PresetMenu.tsx

设置行与 chip 共用的 preset 下拉选择器组件。

- 菜单项文案由 `presetDisplayText` 解析，自定义 preset 额外拼上 `userTrust` 标记（[packages/client/ui-agent-preset/src/client/PresetMenu.tsx:53-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/PresetMenu.tsx#L53-L61)）
- 选中时先报告菜单关闭再回调 `onSelect(id)`（[packages/client/ui-agent-preset/src/client/PresetMenu.tsx:63-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/PresetMenu.tsx#L63-L66)）
- 触发按钮带 `aria-haspopup`/`aria-expanded`，由调用方传入的 `disabled` 决定是否可交互，点击反转开合状态（[packages/client/ui-agent-preset/src/client/PresetMenu.tsx:69-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/PresetMenu.tsx#L69-L81)）

### packages/client/ui-agent-preset/src/client/index.ts

浏览器半边的插件入口：构造三个控制器、注册四个界面槽位与语言包，并接线各处的刷新时机。

- 声明必须注入的服务：`slots`、`locale`、`remote`、`remote.agentPresets`、`remote.settings`、`settingsScope`（[packages/client/ui-agent-preset/src/client/index.ts:52-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L52-L54)）
- 用设置线路、Remote 与 `settingsScope.describe()` 构造默认值控制器（[packages/client/ui-agent-preset/src/client/index.ts:61-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L61-L62)）
- 维护一组名册读取回调，并把「管理区改动了名册目录」的回调接成：重新 `load()` 默认值控制器并逐个触发这些回调（[packages/client/ui-agent-preset/src/client/index.ts:64-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L64-L69)）
- 以 effect 注册 `settings.agentPreset` 命名空间的中英词典（[packages/client/ui-agent-preset/src/client/index.ts:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L71)）
- 设置行的注入面把控制器的快照、`load`、`select` 交给组件（[packages/client/ui-agent-preset/src/client/index.ts:73-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L73-L77)）
- 订阅 `settings/document-updated`（按命名空间过滤）与 `connection/reset`，两者都重新读默认值；管理区只在其状态不是 `idle` 时才跟着重读；返回的 disposer 统一解绑（[packages/client/ui-agent-preset/src/client/index.ts:79-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L79-L96)）
- 用一个外层可变绑定持有创作入口，管理区注入面每次渲染读当前绑定（[packages/client/ui-agent-preset/src/client/index.ts:103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L103)）
- chip 与头部标签在另一个要求 `slots`/`conversation`/`sessions`/`uiWorkspace` 的作用域里注册（[packages/client/ui-agent-preset/src/client/index.ts:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L107)）
- chip 控制器读当前会话的方式是从会话列表快照里按 `current` 取条目，没有当前会话时给 undefined（[packages/client/ui-agent-preset/src/client/index.ts:108-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L108-L112)）
- chip 注入面提供 `load`、`select`、`introduced`；标签注入面复用默认值控制器的快照与 `load`（[packages/client/ui-agent-preset/src/client/index.ts:113-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L113-L123)）
- 订阅会话列表变化，每次变化都调用 chip 控制器的 `apply()`，把暂存的选择交给刚出现的会话（[packages/client/ui-agent-preset/src/client/index.ts:129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L129)）
- 设置命名空间被更新时也让 chip 重新 `load()`（[packages/client/ui-agent-preset/src/client/index.ts:135-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L135-L138)）
- 把 chip 的重读函数加入名册读取回调集合，使管理区的复制/删除也能刷新 chip（[packages/client/ui-agent-preset/src/client/index.ts:143-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L143-L144)）
- 创作入口的实现是：只 `stage('cordis', true)` 不立即 apply，然后调用 `uiWorkspace.startSession()` 开新会话（[packages/client/ui-agent-preset/src/client/index.ts:149-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L149-L154)）
- 把 chip 注册到 `conversation.hero.agentPreset` 槽位（[packages/client/ui-agent-preset/src/client/index.ts:155-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L155-L159)）
- 把标签注册到 `conversation.session.header.actions` 槽位，id 为 `agent-preset`，order 为 -10（[packages/client/ui-agent-preset/src/client/index.ts:160-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L160-L167)）
- 作用域销毁时取消列表订阅、取消设置订阅、移出名册回调、清空创作入口绑定并注销两个槽位（[packages/client/ui-agent-preset/src/client/index.ts:168-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L168-L175)）
- 管理区注入面把控制器的全部动作转出去，且仅在创作入口已绑定时才带上 `startCreatorDraft` 键（[packages/client/ui-agent-preset/src/client/index.ts:179-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L179-L194)）
- 在 `settings.general.item` 槽位存在时注册设置行，id 为 `agent-preset`，order 为 -25（[packages/client/ui-agent-preset/src/client/index.ts:196-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L196-L202)）
- 在 `settings.section` 槽位存在时注册管理区，id 为 `agent-presets`，order 为 20，导航标题从语言包按 `nav` 键取（[packages/client/ui-agent-preset/src/client/index.ts:205-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/index.ts#L205-L212)）

### packages/client/ui-agent-preset/src/client/locales.ts

这四个界面共用的中英词典，以及把名册行解析成显示文案的函数。

- 内置 preset id 到本地化键的映射表，覆盖 `standard`、`ptc`、`minimal`、`cordis`（[packages/client/ui-agent-preset/src/client/locales.ts:171-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/locales.ts#L171-L176)）
- `presetDisplayText` 对 `trust === 'system'` 且命中映射表的行返回本地化文案，其余返回文件里的元数据，名字缺失时回落到 id、描述缺失时该键整个不出现（[packages/client/ui-agent-preset/src/client/locales.ts:184-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/locales.ts#L184-L194)）

### packages/client/ui-agent-preset/src/client/seat-store.ts

新会话 chip 的控制器：暂存下一个会话要用的 preset，并在会话出现时把它交出去。

- 初始快照：选项为空、当前值为空串、无错误、非忙、无入场提示（[packages/client/ui-agent-preset/src/client/seat-store.ts:37-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L37-L39)）
- `load()` 读名册失败时只写错误、不动其他字段（[packages/client/ui-agent-preset/src/client/seat-store.ts:72-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L72-L77)）
- 兜底值取名册里标了 `isDefault` 的项，没有就取第一项，再没有就空串（[packages/client/ui-agent-preset/src/client/seat-store.ts:79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L79)）
- 当前值的优先级是：已暂存的选择 > 当前会话已带的 preset > 部署兜底值（[packages/client/ui-agent-preset/src/client/seat-store.ts:81-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L81-L91)）
- `select()` 在忙时直接返回 undefined，否则先暂存再 apply，并把快照里的错误作为拒绝原因回给调用方（[packages/client/ui-agent-preset/src/client/seat-store.ts:106-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L106-L111)）
- `stage()` 只记暂存值、更新当前显示、清错误并置入场提示标志，不发起任何调用（[packages/client/ui-agent-preset/src/client/seat-store.ts:124-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L124-L127)）
- `introduced()` 只在提示标志为真时才写快照，避免多余更新（[packages/client/ui-agent-preset/src/client/seat-store.ts:129-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L129-L133)）
- `apply()` 在没有暂存值时只把当前显示同步为会话的 preset 或兜底值（[packages/client/ui-agent-preset/src/client/seat-store.ts:142-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L142-L149)）
- 没有当前会话时保留暂存值原地等待；会话已非空白或已是同一 preset 时丢弃暂存值（[packages/client/ui-agent-preset/src/client/seat-store.ts:150-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L150-L156)）
- 调用 `remote.agentPresets.select(sessionId, staged)` 前置忙态清错误，调用后无论成败都清掉暂存值（[packages/client/ui-agent-preset/src/client/seat-store.ts:157-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L157-L160)）
- 被拒绝时优先取 `error.details.reason` 字符串作错误文本，否则取 `error.message`，并把当前显示回退到会话自己的 preset（[packages/client/ui-agent-preset/src/client/seat-store.ts:161-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L161-L176)）
- 成功时把当前显示置为主机返回的值（[packages/client/ui-agent-preset/src/client/seat-store.ts:177-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L177-L178)）
- 调用抛出时同样丢弃暂存值、写入错误文本并回退当前显示（[packages/client/ui-agent-preset/src/client/seat-store.ts:179-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L179-L186)）
- 从会话摘要读 preset 的辅助函数只接受字符串型的 `projectionValues.agentPreset`（[packages/client/ui-agent-preset/src/client/seat-store.ts:190-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/seat-store.ts#L190-L195)）

### packages/client/ui-agent-preset/src/client/section-store.ts

管理区的控制器：读名册、驱动复制对话框、只读查看器、目录定位、删除与设为默认。

- 用正则 `^[a-z0-9][a-z0-9-]*$` 约束新 preset 的目录名（[packages/client/ui-agent-preset/src/client/section-store.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L22)）
- 初始快照：`idle` 状态、不可创作、无桌面打开能力、行与已揭示路径均为空（[packages/client/ui-agent-preset/src/client/section-store.ts:97-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L97-L108)）
- `draftBlocker` 按空、正则不匹配、与现有行 id 冲突三种情况返回对应的本地化键，都不满足才返回 undefined（[packages/client/ui-agent-preset/src/client/section-store.ts:118-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L118-L128)）
- 构造时接受一个「名册目录已变」的回调，默认是空函数（[packages/client/ui-agent-preset/src/client/section-store.ts:135-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L135-L146)）
- `load()` 并发发起 `settings.canOpenAgentPresetDirectory()` 与名册读取，前者失败时被 catch 成 undefined 不影响整体（[packages/client/ui-agent-preset/src/client/section-store.ts:164-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L164-L176)）
- 名册为空时写 `unavailable` 并顺带关闭复制对话框与查看器（[packages/client/ui-agent-preset/src/client/section-store.ts:177-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L177-L181)）
- 重载时把已揭示的路径按名册现存 id 过滤，丢掉已不存在的行的路径（[packages/client/ui-agent-preset/src/client/section-store.ts:182-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L182-L194)）
- `view()` 调用 `remote.agentPresets.read(id)`，成功时把组装文本连同标题放进快照，失败与抛出都写 `error`（[packages/client/ui-agent-preset/src/client/section-store.ts:202-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L202-L215)）
- `closeView()` 把查看器状态置空（[packages/client/ui-agent-preset/src/client/section-store.ts:218-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L218-L220)）
- `beginCopy()` 以源行的显示名（取不到则用 id）建一份空草稿并清掉页面错误（[packages/client/ui-agent-preset/src/client/section-store.ts:226-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L226-L232)）
- `cancelCopy()` 直接丢弃草稿（[packages/client/ui-agent-preset/src/client/section-store.ts:235-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L235-L237)）
- 每次改 id 或名字都同时清掉草稿上的上一次错误（[packages/client/ui-agent-preset/src/client/section-store.ts:243-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L243-L253)）
- `confirmCopy()` 在无草稿、保存中或仍有阻塞原因时直接返回（[packages/client/ui-agent-preset/src/client/section-store.ts:261-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L261-L265)）
- 复制调用固定传满三个参数，显示名 trim 后为空则传 `undefined` 而非空串（[packages/client/ui-agent-preset/src/client/section-store.ts:266-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L266-L273)）
- 复制被拒绝时保留对话框只写草稿错误，抛出时同样落在草稿上（[packages/client/ui-agent-preset/src/client/section-store.ts:274-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L274-L277)）
- 复制成功后依次关对话框、重读名册、触发名册变更回调、再对新 id 调 `openLocation`（[packages/client/ui-agent-preset/src/client/section-store.ts:278-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L278-L286)）
- `openLocation()` 调用 `remote.settings.openAgentPresetDirectory(id)`：主机已打开则什么都不做，未打开则把返回的路径记进 `revealedPaths`，失败与抛出写 `error`（[packages/client/ui-agent-preset/src/client/section-store.ts:295-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L295-L308)）
- `confirmDelete()` 在删除进行中时拒绝改变待删项（[packages/client/ui-agent-preset/src/client/section-store.ts:314-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L314-L317)）
- `remove()` 无待删项或已在删除时直接返回，调用 `remote.agentPresets.deletePreset`，成功后重读名册并触发名册变更回调，失败与抛出都清掉待删项并写错误（[packages/client/ui-agent-preset/src/client/section-store.ts:326-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L326-L342)）
- `makeDefault()` 复用共享的默认值写入函数，失败只写页面错误，成功后重读名册（[packages/client/ui-agent-preset/src/client/section-store.ts:350-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/section-store.ts#L350-L357)）

### packages/client/ui-agent-preset/src/client/settings-store.ts

默认 preset 的设置控制器，同时提供三个界面共用的名册读取、失败折叠与选项过滤函数。

- 固定设置命名空间名为 `agent-presets`（[packages/client/ui-agent-preset/src/client/settings-store.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L16)）
- `messageOf` 把 Error 之外的任意抛出值转成字符串（[packages/client/ui-agent-preset/src/client/settings-store.ts:25-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L25-L27)）
- `writeDefaultPreset` 把选择写到该命名空间的 `default` 字段；传输抛出与 `ok: false` 两条失败路径都折成一句消息返回（[packages/client/ui-agent-preset/src/client/settings-store.ts:39-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L39-L56)）
- `readRoster` 调用 `remote.agentPresets.list()`，把 `invocation-unavailable` 错误码折成一个空名册当作成功返回，其余失败与抛出折成消息（[packages/client/ui-agent-preset/src/client/settings-store.ts:88-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L88-L100)）
- `beginRosterRead` 在已有读取进行中时返回 undefined 让调用方直接退出，否则先置 `loading` 清错误再读，失败时写 `error` 状态（[packages/client/ui-agent-preset/src/client/settings-store.ts:113-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L113-L124)）
- `presetOptions` 过滤掉带 `broken` 的行，且只在字段确有值时才放进结果对象（[packages/client/ui-agent-preset/src/client/settings-store.ts:141-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L141-L150)）
- 初始快照状态为 `idle` 且 `writable` 先假定为真（[packages/client/ui-agent-preset/src/client/settings-store.ts:167-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L167-L175)）
- `load()` 在名册为空时写 `unavailable` 并清空选项与当前值（[packages/client/ui-agent-preset/src/client/settings-store.ts:203-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L203-L211)）
- `load()` 等 `describeFace.ensure()` 后取其 `view.writable`，取不到就按不可写处理（[packages/client/ui-agent-preset/src/client/settings-store.ts:216-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L216-L220)）
- 当前值取名册里标了 `isDefault` 的项，名册没标时回落到第一项（[packages/client/ui-agent-preset/src/client/settings-store.ts:221-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L221-L225)）
- `select()` 在保存中或选中值未变时直接返回；先乐观写入当前值，失败则回滚到旧值并记录错误，成功则重新 `load()` 而不是相信补丁（[packages/client/ui-agent-preset/src/client/settings-store.ts:235-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/client/settings-store.ts#L235-L247)）

### packages/client/ui-agent-preset/src/css-modules.d.ts

给 `*.module.css` 导入声明类型的环境声明文件。

- 无运行期机制

### packages/client/ui-agent-preset/src/index.ts

包的主机半边入口，只为让该插件能出现在主机 cordis.yml / Loader 里。

- 无运行期机制

### packages/client/ui-agent-preset/src/invariant.ts

本包的 invariant 伴生插件。

- 向 `invariants` 服务注册包名与一个空安装器，并返回该注册的 disposer（[packages/client/ui-agent-preset/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/src/invariant.ts#L21-L29)）

### packages/client/ui-agent-preset/tsconfig.json

本包的 TypeScript 编译配置。

- 无运行期机制

### packages/client/ui-agent-preset/tsdown.config.ts

本包的打包配置。

- 指定该客户端包的打包入口为 `lib/types/index.js` 与 `lib/types/invariant.js`（[packages/client/ui-agent-preset/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-agent-preset/tsdown.config.ts#L3)）
