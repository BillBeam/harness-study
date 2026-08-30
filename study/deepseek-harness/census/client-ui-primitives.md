---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-primitives
---

# packages/client/ui-primitives

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 78 个文件、527 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-primitives/README.md

包说明文档，介绍这套 React 原子组件的用法、实现要点与已知限制，供阅读者与文档校验使用。

- 无运行期机制

### packages/client/ui-primitives/package.json

包清单，声明模块类型、入口映射、发布内容与依赖。

- `"type": "module"` 使包内 `.js` 按 ESM 解析（[packages/client/ui-primitives/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/package.json#L13)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-primitives/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/package.json#L14-L15)）
- `exports` 只开放包根、`./invariant`、`./src/*` 与 `./package.json` 四个入口，其余路径不可被导入（[packages/client/ui-primitives/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js`、所有 `lib/**/*.css` 与 `lib/types/**/*.d.ts`（[packages/client/ui-primitives/package.json:57-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/package.json#L57-L62)）
- `peerDependencies` 要求宿主提供 invariants 与 cordis 两个包（[packages/client/ui-primitives/package.json:63-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/package.json#L63-L66)）

### packages/client/ui-primitives/src/BrandWordmark.tsx

绘制完整品牌字标的 SVG 组件，供需要品牌标识位的界面使用。

- `includeMark` 决定基准宽度取 182 还是 156，并切换 viewBox 的起点，从而决定是否画出前导标记（[packages/client/ui-primitives/src/BrandWordmark.tsx:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/BrandWordmark.tsx#L16-L23)）
- 宽度按 `size * width / 24` 缩放、高度直接取 `size`（[packages/client/ui-primitives/src/BrandWordmark.tsx:20-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/BrandWordmark.tsx#L20-L21)）
- svg 标注 `aria-hidden="true"`，不进入无障碍树（[packages/client/ui-primitives/src/BrandWordmark.tsx:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/BrandWordmark.tsx#L25)）
- 图形填充用 `currentColor`，徽标区文字改用 `--dsw-alias-label-primary-inverted` 变量（[packages/client/ui-primitives/src/BrandWordmark.tsx:39-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/BrandWordmark.tsx#L39-L47)）
- 两个 clipPath 使用文档级固定 id `dsh-wordmark-whale-clip` 与 `dsh-wordmark-badge-clip`（[packages/client/ui-primitives/src/BrandWordmark.tsx:49-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/BrandWordmark.tsx#L49-L56)）

### packages/client/ui-primitives/src/Button.module.css

Button 原子的 CSS Module，定义胶囊几何、四种填充变体与两种尺寸。

- 无运行期机制

### packages/client/ui-primitives/src/Button.tsx

按钮原子组件，被各功能界面用作标准点击控件。

- 未传时 `variant` 取 `ghost`、`size` 取 `md`（[packages/client/ui-primitives/src/Button.tsx:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Button.tsx#L18)）
- 固定输出 `type="button"`，元素置于表单内也不触发默认提交（[packages/client/ui-primitives/src/Button.tsx:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Button.tsx#L26)）
- 其余原生 button 属性（含 `disabled`、`onClick`）整体透传到元素上（[packages/client/ui-primitives/src/Button.tsx:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Button.tsx#L26)）
- `icon` 非 null 时在文本前额外渲染一个 16px 图标容器（[packages/client/ui-primitives/src/Button.tsx:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Button.tsx#L27)）

### packages/client/ui-primitives/src/ConnectionBanner.module.css

ConnectionBanner 的 CSS Module，定义顶部横幅的定位与配色。

- 无运行期机制

### packages/client/ui-primitives/src/ConnectionBanner.tsx

连接重试提示横幅，由持有连接状态的界面渲染。

- `reconnecting` 为假时返回 null，不产生任何 DOM（[packages/client/ui-primitives/src/ConnectionBanner.tsx:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ConnectionBanner.tsx#L14)）
- 横幅文本直接取调用方传入的 `label`（[packages/client/ui-primitives/src/ConnectionBanner.tsx:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ConnectionBanner.tsx#L15)）

### packages/client/ui-primitives/src/DiffBlock.module.css

DiffBlock 卡片的 CSS Module，定义正文排布、增删配色与复制按钮位置。

- 复制按钮绝对定位在卡片右上角并置于 `z-index: 1`，浮在正文首行之上（[packages/client/ui-primitives/src/DiffBlock.module.css:16-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.module.css#L16-L28)）
- 正文 `white-space: pre` 且 `overflow-x: auto`，长行不折行而横向滚动（[packages/client/ui-primitives/src/DiffBlock.module.css:30-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.module.css#L30-L41)）
- 路径行右侧留 56px 内边距，使路径尾部不落在复制按钮的命中区下（[packages/client/ui-primitives/src/DiffBlock.module.css:47-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.module.css#L47-L51)）
- `::before` 伪元素向删除行与新增行前插入 `- ` / `+ ` 字符（[packages/client/ui-primitives/src/DiffBlock.module.css:61-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.module.css#L61-L77)）

### packages/client/ui-primitives/src/DiffBlock.tsx

把一组文件改动渲染成内联差异卡片的组件，由工具结果展示层调用。

- 默认高度上限常量为 16 行（[packages/client/ui-primitives/src/DiffBlock.tsx:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L8)）
- 行类型到样式类的映射表决定每行走哪一套配色（[packages/client/ui-primitives/src/DiffBlock.tsx:58-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L58-L63)）
- 展平时路径变化才输出路径头行，同一路径的后续 hunk 输出 `⋯` 分隔行（[packages/client/ui-primitives/src/DiffBlock.tsx:81-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L81-L85)）
- 旧侧每行计入 `removed`、新侧每行计入 `added`，文件数取去重路径集合的大小（[packages/client/ui-primitives/src/DiffBlock.tsx:86-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L86-L97)）
- 切分行时空文本产出零行、结尾单个换行被当作终止符去掉、内部空行保留（[packages/client/ui-primitives/src/DiffBlock.tsx:109-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L109-L113)）
- 复制文本按行类型加 `- ` / `+ ` 前缀，路径行与分隔行原样输出，最后以换行拼接（[packages/client/ui-primitives/src/DiffBlock.tsx:122-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L122-L133)）
- 未知行类型进入 `assertNever` 抛出异常（[packages/client/ui-primitives/src/DiffBlock.tsx:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L53-L55)）
- 复制成功后置 `copied` 并在 1000ms 后复位，`copied` 期间的再次点击直接返回（[packages/client/ui-primitives/src/DiffBlock.tsx:145-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L145-L152)）
- 展平后无任何行时整个组件返回 null（[packages/client/ui-primitives/src/DiffBlock.tsx:156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L156)）
- 超出上限且未展开时只渲染头部 `ceil(maxLines/2)` 行与尾部剩余行数（[packages/client/ui-primitives/src/DiffBlock.tsx:158-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L158-L165)）
- 根元素带 `data-diff` 属性（[packages/client/ui-primitives/src/DiffBlock.tsx:168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L168)）
- 隐藏行数大于 0 时在头尾切片之间插入折叠开关（[packages/client/ui-primitives/src/DiffBlock.tsx:176-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L176-L184)）
- 页脚固定输出 `└ +新增 -删除 · 文件数` 的汇总行（[packages/client/ui-primitives/src/DiffBlock.tsx:189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DiffBlock.tsx#L189)）

### packages/client/ui-primitives/src/DisclosureRow.module.css

DisclosureRow 的 CSS Module，定义折叠行的几何、字号联动与图标悬停切换。

- 行高、前导框尺寸与标题行高全部随 `--dsh-content-font-delta` 变量偏移（[packages/client/ui-primitives/src/DisclosureRow.module.css:16-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.module.css#L16-L42)）
- 前导槽内不带 `data-state` 的 svg 被 CSS 覆盖掉自身的 width/height 属性，改用统一尺寸（[packages/client/ui-primitives/src/DisclosureRow.module.css:48-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.module.css#L48-L51)）
- 行悬停时闲置图标透明度归零、悬停箭头透明度归一，实现两者对调（[packages/client/ui-primitives/src/DisclosureRow.module.css:71-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.module.css#L71-L77)）

### packages/client/ui-primitives/src/DisclosureRow.tsx

紧凑折叠行组件，提供统一的展开头部与受控内容区。

- `rowExpands` 由 `expandable && expandOnRowClick` 决定整行是否成为触发区（[packages/client/ui-primitives/src/DisclosureRow.tsx:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L50)）
- 前导按钮点击时先 `stopPropagation` 再调 `onToggle`（[packages/client/ui-primitives/src/DisclosureRow.tsx:51-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L51-L54)）
- 整行模式下 Enter 与空格键被 `preventDefault` 并触发 `onToggle`，其他键忽略（[packages/client/ui-primitives/src/DisclosureRow.tsx:55-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L55-L59)）
- `previewChevron` 默认取 `expandable`，为真时折叠态同时渲染图标与叠放的悬停箭头（[packages/client/ui-primitives/src/DisclosureRow.tsx:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L40)、[packages/client/ui-primitives/src/DisclosureRow.tsx:60-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L60-L67)）
- 展开态把前导槽内容整体换成向下箭头（[packages/client/ui-primitives/src/DisclosureRow.tsx:68-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L68-L70)）
- 根节点写出 `data-open`，行节点仅在整行可展开时写出 `data-expandable`、`role="button"`、`tabIndex` 与 `aria-expanded` 及两个事件处理器（[packages/client/ui-primitives/src/DisclosureRow.tsx:73-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L73-L82)）
- 可展开且非整行模式时前导槽渲染为带 `aria-expanded` 的 button，否则渲染为 span（[packages/client/ui-primitives/src/DisclosureRow.tsx:84-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L84-L97)）
- 折叠附加内容只在 `keepContentWhenOpen` 或未展开时渲染（[packages/client/ui-primitives/src/DisclosureRow.tsx:99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L99)）
- 子内容仅在展开时挂载（[packages/client/ui-primitives/src/DisclosureRow.tsx:101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/DisclosureRow.tsx#L101)）

### packages/client/ui-primitives/src/FishLogo.tsx

单独的鱼形标志 SVG 组件。

- 宽度取 `size`，高度按 17.04:23.16 的比例换算（[packages/client/ui-primitives/src/FishLogo.tsx:12-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/FishLogo.tsx#L12-L13)）
- svg 标注 `aria-hidden="true"`，不进入无障碍树（[packages/client/ui-primitives/src/FishLogo.tsx:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/FishLogo.tsx#L17)）
- 路径填充使用 `currentColor`，颜色随上下文文本色（[packages/client/ui-primitives/src/FishLogo.tsx:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/FishLogo.tsx#L19)）

### packages/client/ui-primitives/src/FoldToggle.tsx

头尾折叠卡片共用的展开/收起按钮，被差异卡与读取卡复用。

- `aria-expanded` 直接反映当前折叠状态（[packages/client/ui-primitives/src/FoldToggle.tsx:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/FoldToggle.tsx#L26)）
- 无障碍名在展开时取 `collapseAria`、折叠时取 `expandAria(hidden)`（[packages/client/ui-primitives/src/FoldToggle.tsx:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/FoldToggle.tsx#L27)）
- 点击回调直接调用调用方的 `onToggle`（[packages/client/ui-primitives/src/FoldToggle.tsx:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/FoldToggle.tsx#L28)）
- 可见文案在展开时取 `collapse`、折叠时取 `expand(hidden)`，隐藏行数进入文案（[packages/client/ui-primitives/src/FoldToggle.tsx:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/FoldToggle.tsx#L30)）

### packages/client/ui-primitives/src/HoverCard.module.css

HoverCard 的 CSS Module，定义包裹层、悬浮预览卡与无障碍状态区。

- 包裹层用 `display: block` 而非 inline-flex，卡片按这个矩形测量锚点（[packages/client/ui-primitives/src/HoverCard.module.css:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.module.css#L3-L6)）
- 卡片固定定位、`z-index: 100` 且不设 `pointer-events: none`，指针停在卡片上仍可命中（[packages/client/ui-primitives/src/HoverCard.module.css:13-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.module.css#L13-L23)）
- 状态区被裁剪成 1×1 并 `overflow: hidden`，在视觉上不可见但保留在无障碍树中（[packages/client/ui-primitives/src/HoverCard.module.css:47-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.module.css#L47-L54)）

### packages/client/ui-primitives/src/HoverCard.tsx

悬停预览卡组件：包住锚点元素，在停留一段时间后于 body 上弹出可复制的预览卡片。

- 悬停停留时长默认 500ms，`disabled` 默认为假（[packages/client/ui-primitives/src/HoverCard.tsx:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L22)）
- 清除复制反馈时同时取消 1000ms 定时器、丢弃锁定高度并复位状态（[packages/client/ui-primitives/src/HoverCard.tsx:45-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L45-L52)）
- 关闭时递增复制轮次计数，使在途的复制结果被作废（[packages/client/ui-primitives/src/HoverCard.tsx:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L54-L58)）
- 关闭动作接入指针宽限机制，拿到 arm/cancel 两个入口（[packages/client/ui-primitives/src/HoverCard.tsx:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L60)）
- 外部把 `disabled` 置真时立即清停留定时器、取消待关闭并关闭卡片（[packages/client/ui-primitives/src/HoverCard.tsx:70-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L70-L75)）
- 卸载时标记未挂载、作废复制轮次并清掉两个定时器（[packages/client/ui-primitives/src/HoverCard.tsx:77-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L77-L88)）
- 打开时在绘制前按锚点矩形定位到其右侧 8px，底边越界则上移到距视口底 8px（[packages/client/ui-primitives/src/HoverCard.tsx:92-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L92-L102)）
- 打开期间以捕获阶段监听 scroll 并监听 resize 重新定位，关闭时移除监听（[packages/client/ui-primitives/src/HoverCard.tsx:104-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L104-L109)）
- 卡片挂载后用真实高度再夹一次底边位置（[packages/client/ui-primitives/src/HoverCard.tsx:115-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L115-L122)）
- 复制在已复制或正在复制时直接返回，写入成功且组件仍挂载、轮次未变时锁定卡片高度、显示成功文案并在 1000ms 后复位（[packages/client/ui-primitives/src/HoverCard.tsx:124-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L124-L136)）
- 提供 `copyText` 时卡片才带 `role="button"`、`tabIndex=0` 与含被复制值的无障碍名（[packages/client/ui-primitives/src/HoverCard.tsx:138-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L138-L146)）
- 点击时若存在与卡片相交的非折叠文本选区则不执行复制（[packages/client/ui-primitives/src/HoverCard.tsx:147-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L147-L157)）
- Enter 与空格键被 `preventDefault` 后触发复制，其他键忽略（[packages/client/ui-primitives/src/HoverCard.tsx:158-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L158-L164)）
- 复制成功期间卡片内容被成功文案整体替换（[packages/client/ui-primitives/src/HoverCard.tsx:166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L166)）
- 指针进入：`disabled` 直接返回，否则取消待关闭；已打开则不重启停留计时，未打开则起停留定时器（[packages/client/ui-primitives/src/HoverCard.tsx:174-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L174-L182)）
- 指针离开：清停留定时器，仅在已打开时武装宽限关闭（[packages/client/ui-primitives/src/HoverCard.tsx:183-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L183-L188)）
- 捕获阶段的 pointerdown 只要目标不在卡片内就立刻关闭卡片（[packages/client/ui-primitives/src/HoverCard.tsx:194-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L194-L199)）
- 可复制且打开时额外渲染 `role="status"` 的隐藏区，复制成功时播报成功文案（[packages/client/ui-primitives/src/HoverCard.tsx:202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L202)）
- 卡片通过 `createPortal` 挂到 `document.body`（[packages/client/ui-primitives/src/HoverCard.tsx:203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/HoverCard.tsx#L203)）

### packages/client/ui-primitives/src/Input.module.css

Input 原子的 CSS Module，定义外框、聚焦边框与占位符配色。

- 无运行期机制

### packages/client/ui-primitives/src/Input.tsx

单行文本输入原子组件，用于搜索框与内联表单。

- `icon` 非 null 时在输入框前渲染 16px 前导图标（[packages/client/ui-primitives/src/Input.tsx:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Input.tsx#L19)）
- 其余原生 input 属性整体透传到内部 input 元素（[packages/client/ui-primitives/src/Input.tsx:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Input.tsx#L20)）

### packages/client/ui-primitives/src/JsonTree.module.css

JsonTree 的 CSS Module，定义配色变量、行高亮层、展开三角与复制按钮。

- 一整套语法配色以自定义属性形式声明在根节点上（[packages/client/ui-primitives/src/JsonTree.module.css:1-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.module.css#L1-L18)）
- `body[data-ds-dark-theme]` 存在时整套配色变量被改写（[packages/client/ui-primitives/src/JsonTree.module.css:20-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.module.css#L20-L28)）
- 顶层容器的高亮由是否命中带 `data-json-root-row` 的行的悬停或 `data-json-copy-active` 属性决定（[packages/client/ui-primitives/src/JsonTree.module.css:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.module.css#L46-L49)）
- 行高亮层由悬停、JS 写入的 `data-json-copy-active` 或展开器获得焦点三者之一触发，且设 `pointer-events: none` 不吃指针事件（[packages/client/ui-primitives/src/JsonTree.module.css:76-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.module.css#L76-L88)）
- 复制按钮的失败态由 `data-state='failed'` 属性切换成错误色（[packages/client/ui-primitives/src/JsonTree.module.css:170-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.module.css#L170-L172)）
- 展开器三角形完全由 `::before` 的边框绘制，折叠态类给它加 90 度旋转（[packages/client/ui-primitives/src/JsonTree.module.css:191-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.module.css#L191-L204)）
- 折叠内容的省略号由 `::after` 的 `content` 插入（[packages/client/ui-primitives/src/JsonTree.module.css:220-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.module.css#L220-L222)）

### packages/client/ui-primitives/src/JsonTree.tsx

只读 JSON 检查器：把已解析的对象或数组渲染成可键盘操作、逐行可复制的折叠树。

- 对象预览最多 4 项、数组预览最多 5 项、预览递归深度上限 2（[packages/client/ui-primitives/src/JsonTree.tsx:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L14-L16)）
- 基础值行与对象行分别给出两套右键菜单条目及其 id（[packages/client/ui-primitives/src/JsonTree.tsx:45-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L45-L59)）
- 可展开判定为 typeof object 且非 null 且非 Date 实例（[packages/client/ui-primitives/src/JsonTree.tsx:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L74-L76)）
- 数组按下标生成键名、对象按 `Object.keys` 顺序取自有可枚举键（[packages/client/ui-primitives/src/JsonTree.tsx:78-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L78-L86)）
- 预览基础值按 typeof 分派：字符串走 `JSON.stringify`，symbol 取 description，function 取 name（[packages/client/ui-primitives/src/JsonTree.tsx:92-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L92-L116)）
- 预览到达深度上限只画一个省略号，条目数超出限额时在末尾追加 `, …`（[packages/client/ui-primitives/src/JsonTree.tsx:118-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L118-L150)）
- 展开行的基础值渲染另有一套规则：bigint 带 `n` 后缀、Date 转 ISO 串、function 画成 `function() { }`（[packages/client/ui-primitives/src/JsonTree.tsx:152-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L152-L176)）
- 空字符串键显示为 `""`（[packages/client/ui-primitives/src/JsonTree.tsx:178-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L178-L180)）
- 节点 id 用 `n<下标>` 与 `s<键长>:<键>` 编码后以斜杠连接，避免不同路径撞号（[packages/client/ui-primitives/src/JsonTree.tsx:182-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L182-L186)）
- 焦点在所属 `role="tree"` 内的全部 `[data-json-expander]` 之间按方向环形移动（[packages/client/ui-primitives/src/JsonTree.tsx:192-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L192-L204)）
- 键名在可展开时才挂点击切换处理器（[packages/client/ui-primitives/src/JsonTree.tsx:206-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L206-L224)）
- 节点展开状态本地持有，切换后把焦点抢回展开器（[packages/client/ui-primitives/src/JsonTree.tsx:251-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L251-L260)）
- 右方向键强制展开、左方向键强制折叠、上下方向键移动焦点，四者均 `preventDefault`（[packages/client/ui-primitives/src/JsonTree.tsx:262-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L262-L272)）
- 每行的 mouseOver 先 `stopPropagation` 再把行元素与 `{path, value}` 上报给树（[packages/client/ui-primitives/src/JsonTree.tsx:274-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L274-L286)）
- 非容器值渲染成单行，非末位元素补一个逗号（[packages/client/ui-primitives/src/JsonTree.tsx:288-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L288-L296)）
- 空容器只画一对括号且不给展开器（[packages/client/ui-primitives/src/JsonTree.tsx:298-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L298-L308)）
- 可展开节点渲染 `role="button"` 展开器，其 `aria-controls` 与 `tabIndex` 分别由展开状态与当前 tab 停靠 id 决定，展开时递归渲染 `role="group"` 子列表（[packages/client/ui-primitives/src/JsonTree.tsx:310-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L310-L347)）
- 复制路径格式化：根为 `$`，数字下标写成 `[i]`，合法标识符写成 `.key`，其余写成 `["key"]`（[packages/client/ui-primitives/src/JsonTree.tsx:350-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L350-L357)）
- 四种复制模式分别产出路径、缩进 JSON、紧凑 JSON 与原始值文本（[packages/client/ui-primitives/src/JsonTree.tsx:359-369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L359-L369)）
- 复制功能与顶层展开默认均为开启（[packages/client/ui-primitives/src/JsonTree.tsx:392-399](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L392-L399)）
- 初始 tab 停靠点在顶层展开时取第一个非空可展开子项，否则取根节点，都没有则为 null（[packages/client/ui-primitives/src/JsonTree.tsx:400-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L400-L409)）
- 切换活动行时直接在旧行摘除、在新行写上 `data-json-copy-active` 属性（[packages/client/ui-primitives/src/JsonTree.tsx:420-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L420-L424)）
- 复制按钮的横坐标固定在根容器右内边缘往左 26px，弹出方向按该行是否落在根容器下半区决定，纵坐标取行矩形顶（[packages/client/ui-primitives/src/JsonTree.tsx:434-445](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L434-L445)）
- 卸载时清掉复位定时器并摘除残留的活动行属性（[packages/client/ui-primitives/src/JsonTree.tsx:461-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L461-L464)）
- 数据或顶层展开设置变化时清空活动行、复制目标、复制状态、菜单开关并把 tab 停靠点重置为初值（[packages/client/ui-primitives/src/JsonTree.tsx:466-474](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L466-L474)）
- 挂载期间以捕获阶段监听 scroll 并监听 resize 重新定位复制按钮（[packages/client/ui-primitives/src/JsonTree.tsx:476-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L476-L487)）
- 行悬停在关闭复制或菜单已打开时不接管，同一行重复触发直接返回，换行时复位复制状态并重新定位按钮（[packages/client/ui-primitives/src/JsonTree.tsx:489-497](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L489-L497)）
- 指针移到非复制按钮区域时清除复制目标（[packages/client/ui-primitives/src/JsonTree.tsx:499-504](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L499-L504)）
- 容器自身滚动时按活动行重新定位复制按钮（[packages/client/ui-primitives/src/JsonTree.tsx:506-509](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L506-L509)）
- 复制走 `navigator.clipboard.writeText`，成功置 copied、抛错置 failed，并在 1500ms 后回到 idle（[packages/client/ui-primitives/src/JsonTree.tsx:511-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L511-L522)）
- 目标为对象时默认复制模式为缩进 JSON，否则为原始值；按钮标题随复制状态在成功、失败与默认动作文案间切换（[packages/client/ui-primitives/src/JsonTree.tsx:524-531](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L524-L531)）
- 指针离开根容器时，只要菜单未打开就清除复制目标（[packages/client/ui-primitives/src/JsonTree.tsx:538-540](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L538-L540)）
- 顶层展开模式把开闭括号单独成行渲染，中间是带 `role="tree"` 的子项列表（[packages/client/ui-primitives/src/JsonTree.tsx:543-579](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L543-L579)）
- 非顶层展开模式把整份数据作为单个初始展开节点渲染（[packages/client/ui-primitives/src/JsonTree.tsx:581-594](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L581-L594)）
- 复制锚点按 `copyTarget` 的坐标定位，右键在按钮上被 `preventDefault` 并打开菜单，菜单选中项触发对应模式复制后关闭菜单（[packages/client/ui-primitives/src/JsonTree.tsx:595-640](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/JsonTree.tsx#L595-L640)）

### packages/client/ui-primitives/src/Menu.module.css

Menu 的 CSS Module，定义下拉卡片、就地与传送两种定位、行样式与子菜单卡片。

- 菜单卡片重新绑定滚动条颜色变量，供实际滚动的后代继承（[packages/client/ui-primitives/src/Menu.module.css:20-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.module.css#L20-L26)）
- 传送模式改为 `position: fixed` 并取消就地偏移，`z-index: 1100` 使其压在模态遮罩层之上（[packages/client/ui-primitives/src/Menu.module.css:39-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.module.css#L39-L48)）
- 可滚动类给卡片设 `max-height: calc(100vh - 24px)`，超出部分在视口区内滚动，页脚保持可见（[packages/client/ui-primitives/src/Menu.module.css:66-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.module.css#L66-L78)）
- 子菜单绝对定位在父行右侧 10px 处，`::before` 铺满这 10px 间隙使指针横穿时不触发 mouseleave（[packages/client/ui-primitives/src/Menu.module.css:226-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.module.css#L226-L242)）

### packages/client/ui-primitives/src/Menu.tsx

锚定下拉菜单组件，支持就地与 body 传送两种渲染、子菜单、分隔行、标题行与固定页脚。

- 传送列表在未定位前用隐藏但布局在原点的样式渲染，使首次测量拿到真实宽高（[packages/client/ui-primitives/src/Menu.tsx:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L47)）
- 默认对齐为 `start`、方向为 `bottom`、不传送、不因指针离开而关闭、非紧凑（[packages/client/ui-primitives/src/Menu.tsx:80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L80)）
- 传送定位优先调用 `getAnchorRect`，否则测量包裹 span；回调返回 null 时跳过本帧定位（[packages/client/ui-primitives/src/Menu.tsx:109-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L109-L119)）
- 坐标按方向解算：`right` 落在锚点右侧 4px，`start` 左对齐、`end` 右对齐，`bottom` 在下方 4px、`top` 在上方减去列表高度再 4px（[packages/client/ui-primitives/src/Menu.tsx:127-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L127-L138)）
- 量到尺寸后用 12px 边距把坐标夹进视口（[packages/client/ui-primitives/src/Menu.tsx:120-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L120-L141)）
- 打开时先定位一次再以捕获阶段监听 scroll 并监听 resize，关闭时移除监听（[packages/client/ui-primitives/src/Menu.tsx:148-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L148-L155)）
- 关闭时清空已展开的子菜单 id（[packages/client/ui-primitives/src/Menu.tsx:157-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L157-L161)）
- 打开期间在 document 上监听 pointerdown，落点既不在包裹层也不在列表内时调 `onClose`（[packages/client/ui-primitives/src/Menu.tsx:162-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L162-L168)）
- 打开期间在 document 上监听 keydown，Escape 调 `onClose`（[packages/client/ui-primitives/src/Menu.tsx:169-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L169-L177)）
- `open` 转为假时取消待执行的宽限关闭（[packages/client/ui-primitives/src/Menu.tsx:184-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L184-L186)）
- 只要有一项带非空子菜单，整张卡片就不加高度上限类（[packages/client/ui-primitives/src/Menu.tsx:190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L190)）
- 分隔项渲染成 `role="separator"`、标题项渲染成 `role="presentation"`，两者都不可点击（[packages/client/ui-primitives/src/Menu.tsx:192-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L192-L198)）
- 选中态由 `selectedId` 相等或 `selectedIds` 包含决定，并以尾部勾号标记（[packages/client/ui-primitives/src/Menu.tsx:201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L201)、[packages/client/ui-primitives/src/Menu.tsx:228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L228)）
- 行的 mouseEnter/mouseLeave 与按钮 focus 共同控制当前展开的子菜单 id（[packages/client/ui-primitives/src/Menu.tsx:206-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L206-L216)）
- 点击带子菜单的行只展开子菜单而不回调 `onSelect`，其余行回调 `onSelect(entry.id)`（[packages/client/ui-primitives/src/Menu.tsx:217-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L217-L223)）
- 子菜单项点击直接回调 `onSelect(sub.id)`（[packages/client/ui-primitives/src/Menu.tsx:230-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L230-L246)）
- 列表根节点的 onClick 做 `stopPropagation`，阻止传送后的合成事件沿 React 树冒回锚点（[packages/client/ui-primitives/src/Menu.tsx:255-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L255-L265)）
- 页脚非空时渲染在滚动视口之下，与滚动区分离（[packages/client/ui-primitives/src/Menu.tsx:269-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L269-L273)）
- 开启指针离开关闭时，包裹层的 pointerEnter 取消待关闭、pointerLeave 在打开状态下武装宽限关闭（[packages/client/ui-primitives/src/Menu.tsx:285-286](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L285-L286)）
- 传送模式经 `createPortal` 挂到 `document.body`，否则就地渲染在包裹层内（[packages/client/ui-primitives/src/Menu.tsx:289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Menu.tsx#L289)）

### packages/client/ui-primitives/src/Modal.module.css

Modal 的 CSS Module，定义全视口层、遮罩与对话框卡片。

- 根层 `position: fixed; inset: 0` 且 `z-index: 1000`，覆盖并拦截整个视口（[packages/client/ui-primitives/src/Modal.module.css:2-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.module.css#L2-L10)）
- 遮罩 `position: absolute; inset: 0`，使承载关闭点击的元素铺满整层（[packages/client/ui-primitives/src/Modal.module.css:14-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.module.css#L14-L19)）
- 对话框卡片 `z-index: 1` 叠在遮罩之上，并 `overflow: hidden` 裁掉溢出内容（[packages/client/ui-primitives/src/Modal.module.css:22-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.module.css#L22-L35)）

### packages/client/ui-primitives/src/Modal.tsx

居中模态对话框组件，通过 body 传送渲染在模糊遮罩之上。

- 打开期间在 document 上监听 keydown，Escape 调 `onClose`；关闭或卸载时移除监听（[packages/client/ui-primitives/src/Modal.tsx:41-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L41-L48)）
- `open` 为假时返回 null，不产生任何 DOM（[packages/client/ui-primitives/src/Modal.tsx:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L50)）
- 整棵覆盖层通过 `createPortal` 挂到 `document.body`（[packages/client/ui-primitives/src/Modal.tsx:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L52)、[packages/client/ui-primitives/src/Modal.tsx:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L82)）
- 遮罩标注 `aria-hidden` 并把点击直接接到 `onClose`（[packages/client/ui-primitives/src/Modal.tsx:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L54)）
- 卡片带 `role="dialog"`、`aria-modal="true"` 与取自 `title` 的无障碍名（[packages/client/ui-primitives/src/Modal.tsx:55-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L55-L60)）
- `headless` 为真时直接渲染子内容，否则渲染标题行、关闭按钮、描述段与正文区（[packages/client/ui-primitives/src/Modal.tsx:61-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L61-L79)）
- 描述缺失或为空串时不渲染描述段；子内容缺失时不渲染正文区（[packages/client/ui-primitives/src/Modal.tsx:72-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L72-L75)）
- 关闭按钮以 `closeLabel` 作为无障碍名并调 `onClose`（[packages/client/ui-primitives/src/Modal.tsx:68-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L68-L70)）
- 提供 `footer` 时在卡片底部渲染动作行（[packages/client/ui-primitives/src/Modal.tsx:77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Modal.tsx#L77)）

### packages/client/ui-primitives/src/OnboardingSurface.module.css

OnboardingSurface 的 CSS Module，定义首次引导的全屏覆盖层、遮罩与舞台。

- 覆盖层 `position: fixed; inset: 0` 且 `z-index: 1100`，盖住并拦截整个视口（[packages/client/ui-primitives/src/OnboardingSurface.module.css:3-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/OnboardingSurface.module.css#L3-L7)）
- 遮罩从 `top: 80px` 起算，视觉上让出顶部条区域（[packages/client/ui-primitives/src/OnboardingSurface.module.css:10-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/OnboardingSurface.module.css#L10-L19)）
- 舞台层 `inset: 0`、`z-index: 1` 且 `overflow: hidden`，铺满覆盖层并裁掉溢出（[packages/client/ui-primitives/src/OnboardingSurface.module.css:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/OnboardingSurface.module.css#L21-L29)）

### packages/client/ui-primitives/src/OnboardingSurface.tsx

首次引导的全屏接管层，挂载期间让应用根节点失效。

- 挂载时把 id 为 `root` 的元素置 `inert`，卸载时恢复；找不到该元素则不做任何处理（[packages/client/ui-primitives/src/OnboardingSurface.tsx:13-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/OnboardingSurface.tsx#L13-L18)）
- 整棵覆盖层通过 `createPortal` 挂到 `document.body`（[packages/client/ui-primitives/src/OnboardingSurface.tsx:20-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/OnboardingSurface.tsx#L20-L25)）
- 遮罩标注 `aria-hidden`，覆盖层根标注 `role="presentation"`（[packages/client/ui-primitives/src/OnboardingSurface.tsx:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/OnboardingSurface.tsx#L21-L22)）

### packages/client/ui-primitives/src/Pill.module.css

Pill 的 CSS Module，定义小圆角标签的尺寸、悬停与激活态配色。

- 无运行期机制

### packages/client/ui-primitives/src/Pill.tsx

小圆角标签片组件，用作视图切换标签、过滤器与徽标。

- 未传 `onClick` 时渲染成 span，元素不可聚焦、不可点击（[packages/client/ui-primitives/src/Pill.tsx:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Pill.tsx#L20-L22)）
- 传了 `onClick` 时渲染成 `type="button"` 的按钮并透传其余原生属性（[packages/client/ui-primitives/src/Pill.tsx:23-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Pill.tsx#L23-L32)）

### packages/client/ui-primitives/src/ReadBlock.module.css

ReadBlock 卡片的 CSS Module，定义横幅、行号槽与正文排布。

- 正文 `white-space: pre` 且 `overflow-x: auto`，源码行的前导空白保留、超宽横向滚动（[packages/client/ui-primitives/src/ReadBlock.module.css:66-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.module.css#L66-L80)）
- 行号槽设 `user-select: none`，使文本选择与复制不带上行号（[packages/client/ui-primitives/src/ReadBlock.module.css:82-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.module.css#L82-L91)）
- 行号槽宽度由 `--dsl-read-gutter` 固定，展开按钮用同一变量做左内边距对齐（[packages/client/ui-primitives/src/ReadBlock.module.css:1-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.module.css#L1-L13)、[packages/client/ui-primitives/src/ReadBlock.module.css:97-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.module.css#L97-L107)）

### packages/client/ui-primitives/src/ReadBlock.tsx

把读取工具结果渲染成带行号、可高亮的文件视图卡片。

- 默认高度上限常量为 16 行（[packages/client/ui-primitives/src/ReadBlock.tsx:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L18)）
- 原始文本由各行文本以换行连接而成，同时作为高亮输入与复制内容（[packages/client/ui-primitives/src/ReadBlock.tsx:77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L77)）
- 通过 `useSyncExternalStore` 订阅语法加载计数，语法异步到位后触发重新高亮（[packages/client/ui-primitives/src/ReadBlock.tsx:81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L81)）
- 高亮以整窗文本为单位计算，保留跨行语法上下文（[packages/client/ui-primitives/src/ReadBlock.tsx:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L82)）
- 复制写入的是不含行号与横幅的原始文本，成功后 `copied` 保持 1000ms（[packages/client/ui-primitives/src/ReadBlock.tsx:86-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L86-L93)）
- 隐藏行数与头尾切片长度按 `ceil(maxLines/2)` 计算（[packages/client/ui-primitives/src/ReadBlock.tsx:97-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L97-L100)）
- 返回行数小于文件总行数时判定为窗口读取，并在横幅显示 `window(shown, total)` 文案（[packages/client/ui-primitives/src/ReadBlock.tsx:103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L103)、[packages/client/ui-primitives/src/ReadBlock.tsx:121-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L121-L123)）
- 每行左侧渲染标 `aria-hidden` 的行号，右侧按有无高亮片段选择渲染 span 序列或纯文本（[packages/client/ui-primitives/src/ReadBlock.tsx:105-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L105-L111)）
- 根元素带 `data-read` 属性（[packages/client/ui-primitives/src/ReadBlock.tsx:117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L117)）
- 行数为 0 时不渲染复制按钮（[packages/client/ui-primitives/src/ReadBlock.tsx:126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L126)）
- 超出上限时正文只渲染头部切片、折叠开关与尾部切片（[packages/client/ui-primitives/src/ReadBlock.tsx:133-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReadBlock.tsx#L133-L145)）

### packages/client/ui-primitives/src/ReferenceIcon.tsx

按引用类别分派内联引用图标的组件。

- 默认尺寸为 16px（[packages/client/ui-primitives/src/ReferenceIcon.tsx:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReferenceIcon.tsx#L21)）
- 按 `kind` 三分支分派：会话画内联 svg 路径，文件与目录分别复用两个既有图标组件（[packages/client/ui-primitives/src/ReferenceIcon.tsx:22-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReferenceIcon.tsx#L22-L34)）
- 内联 svg 标注 `aria-hidden` 并以 `currentColor` 填充（[packages/client/ui-primitives/src/ReferenceIcon.tsx:25-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ReferenceIcon.tsx#L25-L29)）

### packages/client/ui-primitives/src/RiskConfirmation.module.css

RiskConfirmation 的 CSS Module，定义确认对话框的高度上限、内容滚动区与勾选行。

- 对话框设视口高度上限并 `overflow: hidden`，内容区自行纵向滚动且 `overscroll-behavior: contain` 阻断滚动链（[packages/client/ui-primitives/src/RiskConfirmation.module.css:1-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/RiskConfirmation.module.css#L1-L11)）
- 支持 `100dvh` 的环境下高度上限改用动态视口高度（[packages/client/ui-primitives/src/RiskConfirmation.module.css:13-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/RiskConfirmation.module.css#L13-L17)）
- 勾选框禁用时光标改为默认，取消其可点击提示（[packages/client/ui-primitives/src/RiskConfirmation.module.css:63-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/RiskConfirmation.module.css#L63-L65)）

### packages/client/ui-primitives/src/RiskConfirmation.tsx

受控的风险确认对话框，把敏感动作挡在一个显式勾选之后。

- 复用 Modal 渲染，并把对话框的关闭动作接到 `onCancel`（[packages/client/ui-primitives/src/RiskConfirmation.tsx:44-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/RiskConfirmation.tsx#L44-L50)）
- 确认按钮在 `disabled` 为真或未勾选时被禁用（[packages/client/ui-primitives/src/RiskConfirmation.tsx:56-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/RiskConfirmation.tsx#L56-L63)）
- 取消按钮点击调 `onCancel`（[packages/client/ui-primitives/src/RiskConfirmation.tsx:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/RiskConfirmation.tsx#L53-L55)）
- 勾选框自动获得焦点，状态受 `acknowledged` 控制，变更时把新的勾选值回调出去（[packages/client/ui-primitives/src/RiskConfirmation.tsx:72-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/RiskConfirmation.tsx#L72-L78)）

### packages/client/ui-primitives/src/SearchBlock.module.css

SearchBlock 卡片的 CSS Module，定义横幅、结果行、文件分组头与空结果区。

- 正文 `white-space: pre` 且 `overflow-x: auto`，匹配行与路径不折行而横向滚动（[packages/client/ui-primitives/src/SearchBlock.module.css:43-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.module.css#L43-L56)）
- 文件分组头是宽度铺满、去掉边框与背景的按钮，整行都是折叠命中区（[packages/client/ui-primitives/src/SearchBlock.module.css:66-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.module.css#L66-L78)）
- 展开按钮同样宽度铺满、左对齐，整行都是命中区（[packages/client/ui-primitives/src/SearchBlock.module.css:92-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.module.css#L92-L102)）

### packages/client/ui-primitives/src/SearchBlock.tsx

把搜索结果渲染成按文件分组或平铺路径两种形态的卡片。

- 默认高度上限常量为 16 行（[packages/client/ui-primitives/src/SearchBlock.tsx:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L12)）
- 复制文本取整份结果而非当前可见部分：路径形态直接换行拼接，分组形态每个文件输出路径行加 `行号: 文本`，文件之间空行分隔（[packages/client/ui-primitives/src/SearchBlock.tsx:98-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L98-L103)）
- 保留结果计数：路径形态取路径数，分组形态把各文件匹配数相加（[packages/client/ui-primitives/src/SearchBlock.tsx:112-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L112-L116)）
- 横幅摘要按形态选用不同的标签函数，并把保留数、截断前总数与截断标志传进去（[packages/client/ui-primitives/src/SearchBlock.tsx:130-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L130-L134)）
- 展平时被折叠的文件分组只产出其头行，匹配行整体略过（[packages/client/ui-primitives/src/SearchBlock.tsx:143-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L143-L155)）
- 行 key 按类型加前缀生成，使三类行之间不会撞号（[packages/client/ui-primitives/src/SearchBlock.tsx:164-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L164-L170)）
- 展平每次渲染都重算，只以折叠集合为输入（[packages/client/ui-primitives/src/SearchBlock.tsx:184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L184)）
- 复制反馈状态交由共用的复制反馈钩子持有（[packages/client/ui-primitives/src/SearchBlock.tsx:187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L187)）
- 点击文件头在折叠索引集合中增删该索引（[packages/client/ui-primitives/src/SearchBlock.tsx:191-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L191-L198)）
- 头尾切分由共用的上限函数给出隐藏数与头尾长度（[packages/client/ui-primitives/src/SearchBlock.tsx:200-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L200-L202)）
- 尾部切片首行是匹配行且其文件头不在头部切片中时补回该文件头（[packages/client/ui-primitives/src/SearchBlock.tsx:207-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L207-L212)）
- 补回的文件头占用一个尾部名额：丢掉尾部首行，使可见行数仍等于上限、隐藏数仍准确（[packages/client/ui-primitives/src/SearchBlock.tsx:213-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L213-L218)）
- 三类行分别渲染成路径行、带行号前缀的匹配行，以及带 `aria-expanded` 且点击切换折叠的文件头按钮（[packages/client/ui-primitives/src/SearchBlock.tsx:220-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L220-L241)）
- 根元素带取值为形态名的 `data-search` 属性（[packages/client/ui-primitives/src/SearchBlock.tsx:244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L244)）
- 结果为空时不渲染复制按钮，正文改渲染无结果文案（[packages/client/ui-primitives/src/SearchBlock.tsx:247-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L247-L254)）
- 隐藏行数大于 0 时在头尾之间渲染展开按钮，其 `aria-expanded` 与无障碍名随折叠状态切换（[packages/client/ui-primitives/src/SearchBlock.tsx:260-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/SearchBlock.tsx#L260-L270)）

### packages/client/ui-primitives/src/StateDot.module.css

StateDot 的 CSS Module，定义四态圆点与"追逐"像素矩阵的外观与动画，被同目录 StateDot.tsx 引入。

- `.dot`/`.matrix` 把 `--dsh-state-ongoing` 绑到静态色阶变量上，供 `.matrix` 取用（[packages/client/ui-primitives/src/StateDot.module.css:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.module.css#L3-L6)）
- `.dot::before` 用 0.1 不透明度的 currentColor 铺满外圈，`.dot::after` 用 inset 20% 画实心内核（[packages/client/ui-primitives/src/StateDot.module.css:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.module.css#L16-L31)）
- `data-state` 属性选择器把 done/warning/error 三态分别映射到成功、警告、错误三个颜色变量（[packages/client/ui-primitives/src/StateDot.module.css:33-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.module.css#L33-L43)）
- `.cell` 以 0.15 基础不透明度无限循环播放 1s 的 `dsh-state-dot-chase` 动画（[packages/client/ui-primitives/src/StateDot.module.css:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.module.css#L54-L58)）
- keyframes 用四段平坦区间（1 / 0.6 / 0.35 / 0.15）而非补间过渡（[packages/client/ui-primitives/src/StateDot.module.css:60-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.module.css#L60-L65)）

### packages/client/ui-primitives/src/StateDot.tsx

四态状态点组件，被 TerminalBlock 等卡片用作运行状态指示。

- `MATRIX_CELLS` 固定八个 2x2 单元格在 10x10 网格上的顺时针坐标（[packages/client/ui-primitives/src/StateDot.tsx:8-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.tsx#L8-L10)）
- `size` 默认 10，直接写进 svg 的 width/height 或 span 的行内宽高（[packages/client/ui-primitives/src/StateDot.tsx:19-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.tsx#L19-L23)）
- `state === 'ongoing'` 走 svg 分支，渲染八个 `.cell` rect 并加 `shapeRendering="crispEdges"`（[packages/client/ui-primitives/src/StateDot.tsx:24-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.tsx#L24-L47)）
- 每个 rect 行内设置 `animationDelay = (index - 8) * 125ms` 的负延迟，使所有格子从挂载起就处于动画相位上（[packages/client/ui-primitives/src/StateDot.tsx:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.tsx#L44)）
- 其余三态渲染 span 并把 `state` 写到 `data-state` 属性上，供样式表选择颜色（[packages/client/ui-primitives/src/StateDot.tsx:50-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.tsx#L50-L57)）
- 两个分支都标 `aria-hidden="true"`，不向辅助技术暴露（[packages/client/ui-primitives/src/StateDot.tsx:33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/StateDot.tsx#L33)）

### packages/client/ui-primitives/src/TerminalBlock.module.css

TerminalBlock 的 CSS Module，定义命令横幅、状态槽、输出区的几何与滚动行为。

- 在 `.block` 上暴露 `--dsl-terminal-font`、`--dsl-terminal-line-height`、`--dsl-terminal-gutter` 三个可被消费者改绑的自定义属性（[packages/client/ui-primitives/src/TerminalBlock.module.css:1-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L1-L11)）
- 卡片自身用 `padding-left` 预留状态点列，并 `overflow: hidden` 裁到自己的圆角（[packages/client/ui-primitives/src/TerminalBlock.module.css:12-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L12-L27)）
- `.header` 以 150px 上限 + `overflow-y: auto` 让多行命令在横幅内滚动（[packages/client/ui-primitives/src/TerminalBlock.module.css:32-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L32-L48)）
- 只有不带 `data-running` 属性时才画横幅下方的分隔线（[packages/client/ui-primitives/src/TerminalBlock.module.css:64-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L64-L66)）
- `.runState` 绝对定位到 gutter 内的负偏移处，脱离命令行文本流（[packages/client/ui-primitives/src/TerminalBlock.module.css:91-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L91-L96)）
- `.runStateLabel` 用 1px 尺寸加 `clip-path: inset(50%)` 做视觉隐藏、保留可读屏文本（[packages/client/ui-primitives/src/TerminalBlock.module.css:99-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L99-L106)）
- `.command` 用 `white-space: pre` 保留原始空白，同时以 `overflow: hidden` + `text-overflow: ellipsis` 截断单行（[packages/client/ui-primitives/src/TerminalBlock.module.css:116-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L116-L122)）
- 状态药丸与复制按钮 `position: sticky; top: 0`，复制按钮铺卡面底色（[packages/client/ui-primitives/src/TerminalBlock.module.css:128-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L128-L150)）
- `.output` 的高度上限取 `--dsl-terminal-output-max-height`，未设置时为 `none`，两个方向都 `auto` 滚动（[packages/client/ui-primitives/src/TerminalBlock.module.css:156-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L156-L162)）
- `.line` 用 `white-space: pre` 且不折行、不断词（[packages/client/ui-primitives/src/TerminalBlock.module.css:180-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.module.css#L180-L183)）

### packages/client/ui-primitives/src/TerminalBlock.tsx

把一条 shell 命令及其输出渲染成终端卡片的组件，从 index.ts 导出给聊天侧的工具行使用。

- 导出 `DEFAULT_TERMINAL_MAX_LINES = 16` 作为输出折叠前的行数上限（[packages/client/ui-primitives/src/TerminalBlock.tsx:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L11)）
- 所有显示文案由 `labels` 以函数/字符串形式从调用方传入，组件本身不含文案（[packages/client/ui-primitives/src/TerminalBlock.tsx:17-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L17-L42)）
- `promptLabel` 去掉尾部分隔符后，cwd 等于 home 时显示 `~`，否则取末段路径，无末段时回落到原串（[packages/client/ui-primitives/src/TerminalBlock.tsx:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L76-L81)）
- `statusText` 让 signal 优先于 exitCode，退出码为 0 或缺失时返回 undefined 从而不画状态药丸（[packages/client/ui-primitives/src/TerminalBlock.tsx:92-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L92-L100)）
- `runState` 把 running/有状态文本/其余分别映射到 ongoing、error、done 三个点态并配一段文本标签（[packages/client/ui-primitives/src/TerminalBlock.tsx:118-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L118-L127)）
- `renderLine` 对 `style === undefined` 的 run 直接输出裸文本，不套 span（[packages/client/ui-primitives/src/TerminalBlock.tsx:135-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L135-L139)）
- 输出经 `parseAnsiLines` 解析后，若行数大于 1 且末行所有 run 文本为空，则丢弃这一末行（[packages/client/ui-primitives/src/TerminalBlock.tsx:167-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L167-L173)）
- 复制反馈钩子绑定的是原始 `text`，不是渲染后的树（[packages/client/ui-primitives/src/TerminalBlock.tsx:177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L177)）
- 命令文本去掉末尾换行后按 `\n` 拆成多行，每行渲染一个 prompt 行（[packages/client/ui-primitives/src/TerminalBlock.tsx:186-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L186-L189)）
- `empty` 判定基于解析后的行而非原始文本：全部 run 的文本 trim 后为空即视为无输出（[packages/client/ui-primitives/src/TerminalBlock.tsx:195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L195)）
- 用 `headTailCap(lines.length, maxLines, expanded)` 算出隐藏行数与头尾切片长度（[packages/client/ui-primitives/src/TerminalBlock.tsx:196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L196)）
- 根节点写出 `data-terminal` 与仅在 running 时存在的 `data-running` 属性（[packages/client/ui-primitives/src/TerminalBlock.tsx:199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L199)）
- 状态点只画在第 0 行，cwd 标签也只在第 0 行显示，其余行显示裸 `$`（[packages/client/ui-primitives/src/TerminalBlock.tsx:203-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L203-L221)）
- 复制按钮仅在非 running 且非 empty 时渲染，点击后按钩子返回的 `copied` 切换文案（[packages/client/ui-primitives/src/TerminalBlock.tsx:224-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L224-L228)）
- running 时整个输出区不渲染；非 running 且 empty 时渲染 `noOutput` 占位（[packages/client/ui-primitives/src/TerminalBlock.tsx:230-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L230-L232)）
- capped 时只渲染前 `headLines` 行，中间插展开按钮，再渲染末 `tailLines` 行（[packages/client/ui-primitives/src/TerminalBlock.tsx:234-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L234-L250)）
- 展开按钮只在 `hidden > 0` 时出现，并把 `expanded` 写进 `aria-expanded` 与 aria-label（[packages/client/ui-primitives/src/TerminalBlock.tsx:237-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/TerminalBlock.tsx#L237-L247)）

### packages/client/ui-primitives/src/Toast.module.css

Toast 的 CSS Module，定义悬浮提示条的定位、层级与进出场动画。

- 固定定位在视口顶部中央，`z-index: 1100`，且 `pointer-events: none` 从不拦截点击（[packages/client/ui-primitives/src/Toast.module.css:6-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Toast.module.css#L6-L15)）
- 动画由 160ms 进场与 1000ms 淡出组成，淡出的延迟读取组件写入的 `--dsh-toast-hold`，缺省 3000ms，并以 `forwards` 保持终态（[packages/client/ui-primitives/src/Toast.module.css:27-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Toast.module.css#L27-L30)）
- `prefers-reduced-motion: reduce` 下去掉进场位移、保留同样延迟的淡出（[packages/client/ui-primitives/src/Toast.module.css:63-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Toast.module.css#L63-L67)）

### packages/client/ui-primitives/src/Toast.tsx

短暂顶部提示条组件，从 index.ts 导出，由拥有方控制挂载与卸载。

- `HOLD_MS = 3000`、`FADE_MS = 1000` 两个常量，后者需与样式表的淡出时长一致（[packages/client/ui-primitives/src/Toast.tsx:6-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Toast.tsx#L6-L9)）
- `setTimeout(onDone, holdMs + FADE_MS)` 在淡出结束后回调拥有方，卸载时清除定时器（[packages/client/ui-primitives/src/Toast.tsx:41-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Toast.tsx#L41-L44)）
- 给了 `anchor` 时在布局阶段测其 `getBoundingClientRect` 中心并监听 window resize 重测（[packages/client/ui-primitives/src/Toast.tsx:49-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Toast.tsx#L49-L58)）
- 通过 `createPortal` 挂到 `document.body`，带 `role="alert"`，并把 `left` 与 `--dsh-toast-hold` 写进行内样式（[packages/client/ui-primitives/src/Toast.tsx:59-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Toast.tsx#L59-L72)）
- 图标节点仅在传入时渲染并标 `aria-hidden`（[packages/client/ui-primitives/src/Toast.tsx:68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Toast.tsx#L68)）

### packages/client/ui-primitives/src/Tooltip.module.css

Tooltip 气泡的 CSS Module，定义固定定位、宽度上限与按侧位切换的位移。

- 固定定位、`width: max-content`、`max-width: 50vw`、`pointer-events: none`，并对不可断词内容启用 `overflow-wrap: break-word`（[packages/client/ui-primitives/src/Tooltip.module.css:1-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.module.css#L1-L20)）
- `data-side` 的三种取值分别对应右/下/上三套 `transform` 位移（[packages/client/ui-primitives/src/Tooltip.module.css:22-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.module.css#L22-L32)）
- 减少动效偏好下彻底关闭入场动画（[packages/client/ui-primitives/src/Tooltip.module.css:38-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.module.css#L38-L42)）

### packages/client/ui-primitives/src/Tooltip.tsx

给单个锚点元素挂 hover/focus 提示气泡的组件，从 index.ts 导出。

- 合并 ref：把锚点元素同时写进内部 ref 和子元素自带的 callback / object ref（[packages/client/ui-primitives/src/Tooltip.tsx:38-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L38-L43)）
- 状态保存锚点的 x/top/bottom 边界而非最终坐标，另用 `placement` 保存实际落位（[packages/client/ui-primitives/src/Tooltip.tsx:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L46-L49)）
- `label` 为函数时只在气泡可见（`pos !== null`）时求值（[packages/client/ui-primitives/src/Tooltip.tsx:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L51-L53)）
- 纵坐标按 placement 推导：right 取锚点垂直中点，top 取顶边减 8，bottom 取底边加 8（[packages/client/ui-primitives/src/Tooltip.tsx:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L54-L58)）
- 布局副作用每次先把 `left` 复位到基准值再测量，按 12px 边距把气泡水平推回视口内（[packages/client/ui-primitives/src/Tooltip.tsx:67-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L67-L78)）
- `side === 'right'` 直接返回，不做纵向翻转；否则只在对侧确实放得下时才翻转 placement（[packages/client/ui-primitives/src/Tooltip.tsx:79-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L79-L85)）
- 该副作用同时监听 window resize 重新执行 fit，并在清理时移除监听（[packages/client/ui-primitives/src/Tooltip.tsx:87-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L87-L90)）
- hover 与 focus 记在同一个 `triggers` ref 上，作为两个独立触发源（[packages/client/ui-primitives/src/Tooltip.tsx:91-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L91-L94)）
- `disabled` 变 true 时取消待显示定时器、清空两个触发标记并把 `pos` 置空，卸载时也取消定时器（[packages/client/ui-primitives/src/Tooltip.tsx:98-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L98-L110)）
- `show` 读取锚点当前 rect，每次都先把 placement 复位回请求的 side（[packages/client/ui-primitives/src/Tooltip.tsx:112-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L112-L122)）
- `delayMs > 0` 时经 setTimeout 延迟显示，否则立即显示（[packages/client/ui-primitives/src/Tooltip.tsx:123-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L123-L133)）
- `hide` 只在 hover 与 focus 都为 false 时才隐藏气泡（[packages/client/ui-primitives/src/Tooltip.tsx:134-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L134-L137)）
- `cloneElement` 注入四个事件处理器，且每个都先调用子元素原有的同名处理器；mouseleave 立即清空 pos，focus 走无延迟路径（[packages/client/ui-primitives/src/Tooltip.tsx:141-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L141-L147)）
- 气泡仅在 `pos !== null` 时渲染，带 `role="tooltip"`、`data-side` 与可选的 `maxWidth` 行内样式（[packages/client/ui-primitives/src/Tooltip.tsx:148-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/Tooltip.tsx#L148-L158)）

### packages/client/ui-primitives/src/WebBlock.module.css

WebBlock 的 CSS Module，定义搜索卡与抓取卡的容器、引用列表滚动与链接样式。

- `.answer` 把内部 MarkdownText 首尾子元素的外边距归零（[packages/client/ui-primitives/src/WebBlock.module.css:13-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.module.css#L13-L23)）
- `.sources` 以 320px 上限 + `overflow-y: auto` 成为滚动容器，并用 `padding-left: 2.5em` 容纳三位数序号标记（[packages/client/ui-primitives/src/WebBlock.module.css:40-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.module.css#L40-L48)）
- 链接与摘要用 `word-break: break-word` / `break-all` 强制断行（[packages/client/ui-primitives/src/WebBlock.module.css:54-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.module.css#L54-L71)）
- 抓取卡内的 `.truncated` 覆盖搜索卡的上边距，改为与状态同行（[packages/client/ui-primitives/src/WebBlock.module.css:122-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.module.css#L122-L124)）

### packages/client/ui-primitives/src/WebBlock.tsx

把已完成的网页检索结果渲染成卡片的组件，按 `kind` 分派搜索卡与抓取卡，从 index.ts 导出。

- `safeHref` 只放行 `http:`/`https:` 协议，解析失败或其他协议返回 undefined（[packages/client/ui-primitives/src/WebBlock.tsx:73-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.tsx#L73-L80)）
- `linkLabel` 优先用 title，否则取 hostname，hostname 为空或解析失败时回落到原始 URL（[packages/client/ui-primitives/src/WebBlock.tsx:91-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.tsx#L91-L99)）
- `SafeLink` 在 href 为 undefined 时渲染 span 而非 a，放行时加 `target="_blank"` 与 `rel="noopener noreferrer"`（[packages/client/ui-primitives/src/WebBlock.tsx:109-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.tsx#L109-L117)）
- 每个来源项用 `<li value={ordinal}>` 显式钉住 1 起始的引用序号，snippet 与 publishedAt 为空串时不渲染（[packages/client/ui-primitives/src/WebBlock.tsx:128-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.tsx#L128-L140)）
- 无 answer 且来源数为 0 时判定为空卡，改渲染 `noResults` 文案（[packages/client/ui-primitives/src/WebBlock.tsx:152-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.tsx#L152-L164)）
- answer 非空时经 `MarkdownText` 渲染（[packages/client/ui-primitives/src/WebBlock.tsx:155-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.tsx#L155-L157)）
- `truncated` 为真时在列表下方追加截断提示（[packages/client/ui-primitives/src/WebBlock.tsx:165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.tsx#L165)）
- 抓取卡渲染安全链接、`http` 文案加状态码，并在 truncated 时同行追加内容截断提示（[packages/client/ui-primitives/src/WebBlock.tsx:175-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.tsx#L175-L185)）
- 顶层按 `props.kind === 'search'` 分派两个卡片实现，并分别写出 `data-web="search"` / `"fetch"` 属性（[packages/client/ui-primitives/src/WebBlock.tsx:192-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/WebBlock.tsx#L192-L194)）

### packages/client/ui-primitives/src/ansi.ts

把命令输出的 ANSI 转义序列解析成按行分组的带样式 run，供 TerminalBlock 渲染。

- `TOKEN_BY_BASIC_RGB` 把 anser 输出的 8/16 色 rgb 三元组映射到主题变量，黑与白都映到主标签色，洋红与青色不映射（[packages/client/ui-primitives/src/ansi.ts:43-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L43-L55)）
- `STYLE_BY_DECORATION` 给 bold/dim/italic/underline/strikethrough/hidden 各配一份 CSS，不含 blink（[packages/client/ui-primitives/src/ansi.ts:64-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L64-L71)）
- 四条正则分别匹配 OSC 序列、非 CSI 转义、无显示意义的 C0 控制符（保留 tab/换行/退格/ESC）（[packages/client/ui-primitives/src/ansi.ts:74-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L74-L84)）
- `NEEDS_REPLAY` 用与 `replayLine` 相同的 CSI 形状判断一行是否含回车、退格或行内擦除（[packages/client/ui-primitives/src/ansi.ts:92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L92)）
- `TAB_WIDTH = 8` 决定制表符推进到的下一个列停（[packages/client/ui-primitives/src/ansi.ts:98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L98)）
- `ZERO_WIDTH` 与 `WIDE_CHAR` 分别界定零宽字符与占两列的字符集合，U+2600–U+27BF 文本符号被排除在宽字符之外（[packages/client/ui-primitives/src/ansi.ts:105-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L105-L122)）
- `isWide` 对码点小于 0x1100 的字符直接返回 false（[packages/client/ui-primitives/src/ansi.ts:131-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L131-L135)）
- SGR 状态以 fg/bg/attrs 三个字段保存当前值，而非累积序列历史（[packages/client/ui-primitives/src/ansi.ts:146-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L146-L154)）
- `ATTR_CLOSERS` 把 22/23/24/25/27/28/29 映射到它们各自关闭的开启参数（[packages/client/ui-primitives/src/ansi.ts:157-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L157-L159)）
- `foldSgr` 把空参数或 `0` 折回默认态，`38`/`48` 按 `5`/`2` 子类型整段吞掉参数，`39`/`49` 清前景/背景，30–37、90–97 及 40–47、100–107 分别设色，其余作为属性去重追加（[packages/client/ui-primitives/src/ansi.ts:167-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L167-L196)）
- `openSgr` 把状态渲染成从默认态出发的唯一一条规范序列（[packages/client/ui-primitives/src/ansi.ts:205-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L205-L210)）
- `sameSgr` 逐字段比较，使得只有状态变化时才发出边界（[packages/client/ui-primitives/src/ansi.ts:213-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L213-L216)）
- `replayLine` 用列缓冲重放一行的光标移动，进入时携带上一行末尾的 SGR 状态（[packages/client/ui-primitives/src/ansi.ts:238-249](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L238-L249)）
- `clear` 清一个格子时连带清掉宽字符配对的另一半（[packages/client/ui-primitives/src/ansi.ts:252-259](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L252-L259)）
- `consume` 让 `\r` 归零光标、退格左移一格且都不擦除内容，制表符推进到下一个 8 列停并只填未写过的格（[packages/client/ui-primitives/src/ansi.ts:261-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L261-L272)）
- 零宽字符不占列，附加到前一个格子的字符串上；行首无可附着格时丢弃（[packages/client/ui-primitives/src/ansi.ts:273-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L273-L281)）
- 每个写入的格子都盖上写入当刻的 SGR 状态；宽字符额外占一个标记为 spacer 的尾格（[packages/client/ui-primitives/src/ansi.ts:282-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L282-L291)）
- 扫描 CSI：终止字节为 `K` 时按第一个参数取模式，`1` 从行首清到光标（含），`2` 清空整行，其余截断到光标列（[packages/client/ui-primitives/src/ansi.ts:294-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L294-L313)）
- 只有终止字节为 `m` 的序列才折进 SGR 状态，其余光标/擦除动作不影响样式（[packages/client/ui-primitives/src/ansi.ts:314-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L314-L318)）
- 回写列缓冲时仅在状态变化处发出一次规范序列，未写过的列补空格（[packages/client/ui-primitives/src/ansi.ts:325-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L325-L334)）
- spacer 格在前导宽字符仍在时不输出任何字符，前导被覆盖后输出一个空格以保持列位（[packages/client/ui-primitives/src/ansi.ts:335-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L335-L340)）
- 行尾把输出收敛到"扫描结束时"的状态而非最后写入格的状态，并把该状态返回给下一行（[packages/client/ui-primitives/src/ansi.ts:345-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L345-L349)）
- `applyCursorMovements` 先剥掉 CRLF 的尾部 `\r`，只对需要重放的行建列缓冲，其余行仅折叠 SGR 以维持跨行状态（[packages/client/ui-primitives/src/ansi.ts:368-387](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L368-L387)）
- `sanitize` 先删 OSC 与非 CSI 转义，再重放光标移动，最后才删无显示意义的控制字符（[packages/client/ui-primitives/src/ansi.ts:397-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L397-L400)）
- `resolveStyle` 仅在 run 没有自绘背景时把前景映到主题变量，有背景时保留 anser 的字面 rgb 对（[packages/client/ui-primitives/src/ansi.ts:407-419](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L407-L419)）
- 样式对象为空时返回 undefined，使无 SGR 的文本不带包裹（[packages/client/ui-primitives/src/ansi.ts:420-422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L420-L422)）
- `parseAnsiLines` 以 `remove_empty` 调 anser，再按 `\n` 切分 chunk 内容分派到各行，至少返回一行（[packages/client/ui-primitives/src/ansi.ts:429-443](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/ansi.ts#L429-L443)）

### packages/client/ui-primitives/src/clipboard.ts

宿主剪贴板写入的共享辅助函数，被各个复制控件调用，从 index.ts 导出。

- 优先走 `navigator.clipboard.writeText`，抛错时返回 false 而不声称成功（[packages/client/ui-primitives/src/clipboard.ts:15-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/clipboard.ts#L15-L23)）
- 无异步 API 时探测 `document.execCommand`，不存在则直接返回 false（[packages/client/ui-primitives/src/clipboard.ts:28-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/clipboard.ts#L28-L31)）
- 回退路径创建一个移出视口的只读 textarea、选中并执行复制，无论成败都在 finally 中移除该元素（[packages/client/ui-primitives/src/clipboard.ts:32-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/clipboard.ts#L32-L45)）

### packages/client/ui-primitives/src/css-modules.d.ts

给 `*.module.css` 与 `*.css` 导入声明类型的环境声明文件。

- 无运行期机制

### packages/client/ui-primitives/src/head-tail-cap.ts

计算列表头尾折叠切片指标的纯函数，被 TerminalBlock、ReadBlock、DiffBlock、SearchBlock 共用。

- `hidden = total - maxLines`，`headLines = ceil(maxLines / 2)`，`tailLines` 取剩余；`capped` 仅在超出且未展开时为真（[packages/client/ui-primitives/src/head-tail-cap.ts:23-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/head-tail-cap.ts#L23-L27)）

### packages/client/ui-primitives/src/icons/index.tsx

整套 `ic_ds_*` 图标组件的集合文件，全部经 index.ts 的 `export *` 对外暴露。

- 每个图标接受 `{ size, className }`，把 size 同时写进 svg 的 width 与 height，viewBox 固定为绘制尺寸（[packages/client/ui-primitives/src/icons/index.tsx:11-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/icons/index.tsx#L11-L18)）
- 所有路径以 `fill="currentColor"` 绘制，颜色由外层 CSS 的 color 决定（[packages/client/ui-primitives/src/icons/index.tsx:13-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/icons/index.tsx#L13-L16)）
- 设置图标用固定的 `clipPath` id 包裹全部路径，14 与 16 两个尺寸各用一个独立 id（[packages/client/ui-primitives/src/icons/index.tsx:47-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/icons/index.tsx#L47-L64)）
- `IconRightUpOutline14` 的默认 size 是 8，与其名字中的 14 不一致（[packages/client/ui-primitives/src/icons/index.tsx:450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/icons/index.tsx#L450)）
- `IconWarningOutline16` 的默认 size 是 14（[packages/client/ui-primitives/src/icons/index.tsx:490](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/icons/index.tsx#L490)）
- `IconFolderOpen16` 在同一轮廓之上叠一层 `opacity="0.2"` 的内填充路径，`IconFolderOpenOutline16` 则只保留轮廓层（[packages/client/ui-primitives/src/icons/index.tsx:667-679](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/icons/index.tsx#L667-L679)）
- `IconFolderClose16` 对唯一路径施加 `transform="translate(1.5 2.429)"`（[packages/client/ui-primitives/src/icons/index.tsx:684](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/icons/index.tsx#L684)）
- `IconTreeCorner8x10` 不是正方形：宽度按 `(size * 8) / 10` 计算，viewBox 起点为负值（[packages/client/ui-primitives/src/icons/index.tsx:689-693](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/icons/index.tsx#L689-L693)）

### packages/client/ui-primitives/src/icons/props.ts

图标组件共享的 props 接口声明。

- 无运行期机制

### packages/client/ui-primitives/src/index.ts

本包的公共入口，集中重导出所有组件、hook、工具函数与类型。

- 无运行期机制

### packages/client/ui-primitives/src/invariant.ts

本包的 Cordis 不变量伴生插件，向 invariants 服务登记包归属。

- 导出插件名 `client-ui-primitives-invariant` 并声明 `inject = ['invariants']`（[packages/client/ui-primitives/src/invariant.ts:12-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/invariant.ts#L12-L15)）
- 安装器为空实现，并在注释中给出本包不注册运行期不变量的理由（[packages/client/ui-primitives/src/invariant.ts:18-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/invariant.ts#L18-L22)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并把返回的 disposer 包成 Promise 交回（[packages/client/ui-primitives/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/invariant.ts#L29-L30)）

### packages/client/ui-primitives/src/markdown/CodeBlock.module.css

CodeBlock 的 CSS Module，定义代码卡的粘性横幅与 `pre` 的排版、滚动。

- `.bannerWrap` 用 `position: sticky; top: 0; z-index: 6` 让语言横幅与复制按钮在代码滚动时留在视野内（[packages/client/ui-primitives/src/markdown/CodeBlock.module.css:23-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.module.css#L23-L30)）
- `pre` 用 `white-space: pre-wrap` + `word-break: break-all` 折行，`overflow-x: auto` 滚动，并以 `!important` 抹掉 margin（[packages/client/ui-primitives/src/markdown/CodeBlock.module.css:71-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.module.css#L71-L83)）
- 用 `!important` 覆盖 shiki 内联的主题背景变量，改用仓库自己的颜色变量（[packages/client/ui-primitives/src/markdown/CodeBlock.module.css:86-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.module.css#L86-L88)）
- `.infostring` 单行省略号截断语言名（[packages/client/ui-primitives/src/markdown/CodeBlock.module.css:44-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.module.css#L44-L53)）

### packages/client/ui-primitives/src/markdown/CodeBlock.tsx

代码块组件，同时提供已完成态的 shiki HTML 渲染与流式态的增量高亮渲染，从 index.ts 导出。

- `SHIKI_PRE_PROPS` 固定流式分支 `pre` 的 class、行内背景/前景变量与 `tabIndex`，与 shiki HTML 分支保持同形（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:38-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L38-L42)）
- 显示前去掉源文本末尾的一个换行（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L45)）
- 用 `useSyncExternalStore` 订阅懒加载语法完成事件，把计数值接进两个 memo 的依赖，从而在语法就绪后重渲染（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:49-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L49-L53)）
- 非流式时调用 `highlightToHtml` 得到 HTML；流式时该值为 undefined（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:50-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L50-L53)）
- 流式关闭时把 session 与行元素缓存两个 ref 都置空（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:59-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L59-L64)）
- 流式时惰性创建 `StreamingHighlightSession` 并逐次 `update`，返回 undefined 时清空行缓存（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:65-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L65-L70)）
- 逐行比较 span 数组的引用，identity 未变的行直接复用上次的 React 元素，使该行 DOM 不被触碰（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:73-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L73-L84)）
- 复制读取的是渲染出的 `pre` 的 `textContent`（回落到 trimmed），写入成功后置 `copied` 并在 1000ms 后复位（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:90-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L90-L100)）
- 复制处理器在 `copied` 期间直接返回，抑制重复触发（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L91)）
- 主体三分支：流式元素树、`dangerouslySetInnerHTML` 注入 shiki HTML、纯文本 `pre` 回退（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:105-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L105-L113)）
- 根节点固定带上全局类名 `md-code-block`，横幅中显示 `lang ?? ''`（[packages/client/ui-primitives/src/markdown/CodeBlock.tsx:115-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/CodeBlock.tsx#L115-L119)）

### packages/client/ui-primitives/src/markdown/JsonBlock.module.css

JsonBlock 的 CSS Module，定义折叠开关与 JSON 主体的容器。

- `.body` 用 200px 高度上限加 `overflow: auto` 把长 JSON 限制在可滚动区域内（[packages/client/ui-primitives/src/markdown/JsonBlock.module.css:20-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/JsonBlock.module.css#L20-L32)）

### packages/client/ui-primitives/src/markdown/JsonBlock.tsx

可折叠的 JSON 展示块，从 index.ts 导出，用于会话侧展示结构化载荷。

- `MAX_CHARS = 20_000` 为序列化后正文的字符上限（[packages/client/ui-primitives/src/markdown/JsonBlock.tsx:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/JsonBlock.tsx#L6)）
- 折叠状态由 `defaultOpen` 初始化，未展开时 memo 直接返回空串、根本不做序列化（[packages/client/ui-primitives/src/markdown/JsonBlock.tsx:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/JsonBlock.tsx#L15-L17)）
- `JSON.stringify(payload, null, 2)` 返回 undefined 或抛错时都回落到 `String(payload)`（[packages/client/ui-primitives/src/markdown/JsonBlock.tsx:18-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/JsonBlock.tsx#L18-L25)）
- 超过上限时截到 `MAX_CHARS` 并追加一行由 `truncatedLabel(总长度)` 生成的文案（[packages/client/ui-primitives/src/markdown/JsonBlock.tsx:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/JsonBlock.tsx#L26)）
- 按钮切换 open 并以 `▾`/`▸` 标示状态，正文仅在 open 时挂载（[packages/client/ui-primitives/src/markdown/JsonBlock.tsx:30-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/JsonBlock.tsx#L30-L33)）

### packages/client/ui-primitives/src/markdown/MarkdownText.module.css

MarkdownText 渲染结果的 CSS Module，覆盖标题、列表、链接、表格、图片、行内代码等元素。

- `.markdown` 用 `overflow-wrap: anywhere` 保证长串不撑破容器（[packages/client/ui-primitives/src/markdown/MarkdownText.module.css:5-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.module.css#L5-L10)）
- 嵌套在 ul/ol 下的 ol 改为 `list-style-position: inside` 且 padding 归零，其中的 `li p` 变为 inline（[packages/client/ui-primitives/src/markdown/MarkdownText.module.css:104-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.module.css#L104-L111)）
- KaTeX 展示公式容器横向可滚动、纵向裁切（[packages/client/ui-primitives/src/markdown/MarkdownText.module.css:163-167](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.module.css#L163-L167)）
- `.tableScroll` 建立横向滚动容器并禁止滚动链（[packages/client/ui-primitives/src/markdown/MarkdownText.module.css:174-178](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.module.css#L174-L178)）
- 带渲染器写出的 `md-table-wide` 类时，静止态 `overflow-x: hidden` 并以等高 padding 占位，hover/focus-visible 时切回 `auto` 并去掉 padding（[packages/client/ui-primitives/src/markdown/MarkdownText.module.css:189-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.module.css#L189-L198)）
- `.tableScroll table` 用 `width: max-content` 保持自然宽度并在包装器内滚动，`.tableFill table` 则改为撑满 100%（[packages/client/ui-primitives/src/markdown/MarkdownText.module.css:210-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.module.css#L210-L223)）
- 单元格宽度被 `min(30vw, 320px)` 上限与 100px 下限夹住（[packages/client/ui-primitives/src/markdown/MarkdownText.module.css:225-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.module.css#L225-L243)）
- 用 `!important` 抹掉首尾子元素的外边距（[packages/client/ui-primitives/src/markdown/MarkdownText.module.css:258-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.module.css#L258-L266)）
- `.image` 以 `max-width: 100%` + `height: auto` + `object-fit: contain` 约束图片尺寸（[packages/client/ui-primitives/src/markdown/MarkdownText.module.css:273-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.module.css#L273-L282)）

### packages/client/ui-primitives/src/markdown/MarkdownText.tsx

渲染不受信任 Markdown 的组件，提供已完成态整体渲染与流式态增量渲染两条路径，从 index.ts 导出。

- 已完成路径用 `parseGfmWithMath` 解析，收集引用目标后整体渲染块并在末尾追加脚注区（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:29-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L29-L51)）
- 已完成路径的渲染上下文 `streaming: false`，并携带 `fileMentions`（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:37-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L37-L44)）
- `StreamingRenderer` 持有增量解析器、已冻结块的缓存元素、冻结的引用目标与脚注编号（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:59-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L59-L71)）
- `render` 对相同文本直接返回上次结果，使 React 可以自由重跑渲染（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:79-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L79-L80)）
- 解析器返回的 generation 变化时清空全部冻结状态并从头重来（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:81-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L81-L89)）
- 每帧的引用目标 = 已冻结目标的副本再叠加当前 tail 解析出的目标（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:90-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L90-L99)）
- 新冻结的块只渲染一次并连同分隔换行一起写入缓存，冻结计数随之推进（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:100-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L100-L118)）
- tail 上下文用冻结脚注顺序与计数的副本，使得每帧重渲不污染已定稿的编号（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:119-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L119-L126)）
- 最终 children = 冻结元素 + 重渲的 tail，脚注区非空时再追加（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:127-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L127-L136)）
- 流式上下文一律传 `fileMentions: undefined`，即文件提及链接只对已完成渲染生效（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:104-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L104-L105)）
- 组件外层用 `memo` 包裹；非流式时销毁 streaming renderer，`labels` 引用变化时重建 renderer（丢弃流式缓存）（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:157-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L157-L175)）
- 顶层导入 `katex/dist/katex.min.css`（[packages/client/ui-primitives/src/markdown/MarkdownText.tsx:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MarkdownText.tsx#L23)）

### packages/client/ui-primitives/src/markdown/MessageText.module.css

MessageText 的 CSS Module，只定义字面文本容器的换行与字体继承。

- `white-space: pre-wrap` + `word-break: break-word` 保留原文的空白与换行并允许长串断行（[packages/client/ui-primitives/src/markdown/MessageText.module.css:1-4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MessageText.module.css#L1-L4)）
- 字号与行高显式声明为 `inherit`，交由消费者容器决定（[packages/client/ui-primitives/src/markdown/MessageText.module.css:7-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MessageText.module.css#L7-L8)）

### packages/client/ui-primitives/src/markdown/MessageText.tsx

用户与引导内容的字面文本渲染原语，从 index.ts 导出。

- 把 `text` 原样放进一个 div，不做任何 Markdown 解析（[packages/client/ui-primitives/src/markdown/MessageText.tsx:5-7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/MessageText.tsx#L5-L7)）

### packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts

一个 micromark 语法扩展，改写星号强调的闭合判定，供 Markdown 解析管线使用。

- 用 `Script_Extensions` 正则界定汉、平假名、片假名、谚文、注音五类 CJK 字符（[packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts:9-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts#L9-L19)）
- tokenizer 启动时读取解析器已配置的 attention 标记，缺失即抛错（[packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts:22-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts#L22-L26)）
- 非星号字符直接走 `nok`，星号则进入 `attentionSequence` 并连续吞掉同一标记（[packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts:33-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts#L33-L46)）
- 保留 CommonMark 原有的 open / close 判定作为基线（[packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts:48-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts#L48-L53)）
- 追加一条闭合条件：标记数 ≥ 2、前一个字符是 Unicode 标点、后一个字符是 CJK 时判定为可闭合（[packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts:54-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts#L54-L58)）
- 判定结果写回 token 的 `_open` / `_close` 后交给 `ok`（[packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts:60-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts#L60-L62)）
- construct 复用上游 `attention.resolveAll`，并只挂在 text 上下文的星号码点上（[packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts:66-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/cjkFriendlyStrong.ts#L66-L74)）

### packages/client/ui-primitives/src/markdown/highlight.ts

客户端唯一的语法高亮模块：同步 shiki 核心、语法允许清单、懒加载语法与流式增量高亮会话，被 CodeBlock 与行号文件视图使用。

- 启动时只把 TypeScript、shellscript、JSON 三套语法装进单例（[packages/client/ui-primitives/src/markdown/highlight.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L42)）
- `LAZY_GRAMMARS` 把另外 23 种语法各自包在动态 import 后面，按语法 id 索引（[packages/client/ui-primitives/src/markdown/highlight.ts:53-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L53-L77)）
- `LANG_ALIASES` 用 Map 而非对象承载别名表，使 `constructor`、`__proto__` 之类的模型自造标签落空而不是命中原型属性（[packages/client/ui-primitives/src/markdown/highlight.ts:90-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L90-L133)）
- js/jsx/ts/tsx 四个别名统一解析到 TypeScript 语法（[packages/client/ui-primitives/src/markdown/highlight.ts:91-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L91-L96)）
- 主题以 `--shiki-` 前缀的 CSS 自定义属性输出所有 token 颜色，并开启 fontStyle（[packages/client/ui-primitives/src/markdown/highlight.ts:136-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L136-L140)）
- 正则引擎设 `forgiving: true` 且把 `lazyCompileLength` 设为无穷大，令所有 TextMate 模式在扫描器创建时就编译（[packages/client/ui-primitives/src/markdown/highlight.ts:149-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L149-L154)）
- 创建单例后立刻用三段样本代码以 `tokenizeTimeLimit: 0` 预热三套启动语法（[packages/client/ui-primitives/src/markdown/highlight.ts:159-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L159-L180)）
- 模块加载时用 `setTimeout(…, 0)` 在延迟任务中预热单例，并对定时器调用 `unref` 以免在 Node 中钉住事件循环（[packages/client/ui-primitives/src/markdown/highlight.ts:250-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L250-L251)）
- 用 `requested` 集合、`listeners` 集合与 `loadCount` 计数器构成一个外部 store（[packages/client/ui-primitives/src/markdown/highlight.ts:188-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L188-L193)）
- `subscribeGrammarLoaded` 注册监听并返回取消函数，`grammarLoadCount` 提供快照值（[packages/client/ui-primitives/src/markdown/highlight.ts:204-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L204-L217)）
- `ensureGrammar` 对启动语法与已加载语法同步返回就绪，对未加载的懒语法只发起一次 import，装载完成后自增计数并逐个通知监听者，本次返回未就绪（[packages/client/ui-primitives/src/markdown/highlight.ts:228-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L228-L242)）
- `highlightToHtml` 对未知别名或未就绪语法返回 undefined，由调用方渲染纯文本（[packages/client/ui-primitives/src/markdown/highlight.ts:263-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L263-L268)）
- 语言名先 `toLowerCase()` 再查别名表（[packages/client/ui-primitives/src/markdown/highlight.ts:264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L264)）
- `spanStyle` 把 vscode-textmate 的 fontStyle 位（1 斜体、2 粗体、4 下划线、8 删除线）折成 React 行内样式（[packages/client/ui-primitives/src/markdown/highlight.ts:282-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L282-L302)）
- `lineSpans` 把纯空白 run 无条件合并进后一个 token，行尾无后继的空白 run 保留自身（[packages/client/ui-primitives/src/markdown/highlight.ts:317-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L317-L329)）
- `StreamingHighlightSession` 缓存已完成行的 span、其后的语法状态与上一次的 (code, lang, result) 三元组（[packages/client/ui-primitives/src/markdown/highlight.ts:343-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L343-L361)）
- `tokenize` 在有缓存状态时以 `grammarState` 续跑，否则从语法初始态开始（[packages/client/ui-primitives/src/markdown/highlight.ts:364-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L364-L370)）
- `update` 对同一 (code, lang) 直接返回同一个结果数组（[packages/client/ui-primitives/src/markdown/highlight.ts:385-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L385-L389)）
- 语法未知或未就绪时重置缓存并返回 undefined；语法变化或新文本不以旧前缀开头时也整体重置重新分词（[packages/client/ui-primitives/src/markdown/highlight.ts:390-396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L390-L396)）
- 只对最后一个换行之前的新完成行做一次分词并保留其 span，换行之后的增长行每次重新分词且不保留（[packages/client/ui-primitives/src/markdown/highlight.ts:397-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L397-L416)）
- 切分点遇到 CRLF 时把 `\r` 排除在完成行之外（[packages/client/ui-primitives/src/markdown/highlight.ts:407](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L407)）
- 新行逐条 push 而非一次性展开成参数，避免一次投递整段内容时超出引擎的参数上限（[packages/client/ui-primitives/src/markdown/highlight.ts:409-412](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L409-L412)）
- 完成行分词后用 `getLastGrammarState` 记下语法状态并推进已覆盖前缀（[packages/client/ui-primitives/src/markdown/highlight.ts:413-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L413-L414)）
- `highlightLines` 返回 shiki 的二维行/token 结构，只保留颜色、丢弃字体样式位（[packages/client/ui-primitives/src/markdown/highlight.ts:437-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L437-L451)）
- 行数大于 1 且末行为空时丢掉 shiki 因末尾换行多出的那一行，使行数与调用方的行数组对齐（[packages/client/ui-primitives/src/markdown/highlight.ts:447-450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/highlight.ts#L447-L450)）

### packages/client/ui-primitives/src/markdown/incremental.ts

流式 Markdown 的增量块级解析器，把已经稳定的前缀块冻结、只重解析尾部源码，供 Markdown 渲染组件按块缓存 React 元素。

- `UNSTABLE_TAIL_BLOCKS` 固定为 2，决定末尾保留多少块不冻结（[packages/client/ui-primitives/src/markdown/incremental.ts:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L34)）
- `blockKey` 用节点在全文中的绝对起始偏移作为渲染 key，节点无 position 时退化为负的列表下标（[packages/client/ui-primitives/src/markdown/incremental.ts:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L66-L69)）
- `update` 在文本与上次完全相同时直接返回上次结果，不再解析（[packages/client/ui-primitives/src/markdown/incremental.ts:93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L93)）
- 新文本不以旧文本为前缀时，清空 `prevText`／`tailStart`／`frozen` 并把 `generation` 加一（[packages/client/ui-primitives/src/markdown/incremental.ts:100-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L100-L105)）
- 每次只把 `text.slice(tailStart)` 交给构造函数传入的语法解析（[packages/client/ui-primitives/src/markdown/incremental.ts:107-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L107-L108)）
- 冻结切点取自本次解析块数减去尾部保留数（[packages/client/ui-primitives/src/markdown/incremental.ts:109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L109)）
- 切点块缺少 `position.end.offset` 时把 `firstUnstable` 归零，本轮不冻结任何块（[packages/client/ui-primitives/src/markdown/incremental.ts:111-115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L111-L115)）
- 否则把切点前的块推入 `frozen`，并把 `tailStart` 推进到 `base + cutEnd`（[packages/client/ui-primitives/src/markdown/incremental.ts:117-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L117-L121)）
- 尾部块带上同一套偏移 key 返回，并把 `frozen` 的拷贝与当前 `generation` 一起缓存（[packages/client/ui-primitives/src/markdown/incremental.ts:123-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/incremental.ts#L123-L128)）

### packages/client/ui-primitives/src/markdown/katex.tsx

把 TeX 源码经 KaTeX 渲染成 React 元素树的模块，被 Markdown 渲染器的 math／inlineMath／```math 分支调用。

- `styleObject` 把行内 `style` 字符串按 `;` 与 `:` 切分，短横线属性名转驼峰后写入 React 样式对象（[packages/client/ui-primitives/src/markdown/katex.tsx:27-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/katex.tsx#L27-L37)）
- `domToReact` 文本节点原样返回，非元素节点返回 null（[packages/client/ui-primitives/src/markdown/katex.tsx:40-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/katex.tsx#L40-L44)）
- 元素属性逐个映射：`class` 转 `className`、`style` 转样式对象、其余原名透传，再按 `localName` 递归建元素（[packages/client/ui-primitives/src/markdown/katex.tsx:46-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/katex.tsx#L46-L55)）
- `renderTexToReact` 先以 `throwOnError: true` 严格渲染（[packages/client/ui-primitives/src/markdown/katex.tsx:68-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/katex.tsx#L68-L69)）
- 严格渲染抛错后以 `strict: 'ignore'`、`throwOnError: false` 重试（[packages/client/ui-primitives/src/markdown/katex.tsx:71-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/katex.tsx#L71-L72)）
- 重试仍抛错时返回带 `katex-error` 类、`#cc0000` 颜色与错误串 title 的 span，内容为原始 TeX（[packages/client/ui-primitives/src/markdown/katex.tsx:76-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/katex.tsx#L76-L86)）
- 用 `DOMParser` 以 `text/html` 解析 KaTeX 输出串，再把 body 的子节点逐个映射为 React 节点（[packages/client/ui-primitives/src/markdown/katex.tsx:88-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/katex.tsx#L88-L89)）

### packages/client/ui-primitives/src/markdown/mathCompatibility.ts

一个 micromark 语法扩展，在美元符号数学语法之外识别 TeX 反斜杠定界符与同行 `$$` 块，被 `parse.ts` 的设定态语法装载。

- `previousBackslash` 只在前一个反斜杠本身是字符转义时允许该文本构造启动（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:11-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L11-L17)）
- 行内构造以 `\` 开启 `mathText`／`mathTextSequence`，随后必须是 `(` 才继续，否则 `nok`（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:19-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L19-L36)）
- 内容态遇 EOF 直接失败、遇 `\` 尝试闭合、遇换行消费为 `lineEnding` 后继续（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:38-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L38-L50)）
- 闭合尝试失败后再检查是否是新的 `\(` 开启序列，是则整体失败（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:52-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L52-L54)）
- `mathTextData` 消费到 EOF／反斜杠／换行为止，连续两个反斜杠被整体吞掉（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:56-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L56-L77)）
- `tokenizeClose` 匹配 `\)` 并发出 `mathTextSequence`（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:84-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L84-L101)）
- `tokenizeOpen` 以 `chunkString` 探测 `\(`，供上面的开启检查使用（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:103-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L103-L120)）
- `createMathFlow` 从上一个 `linePrefix` 事件量出初始缩进宽度，用于续行的空格工厂（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:124-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L124-L131)）
- flow 构造以 marker + openMarker 开启 `mathFlow`／`mathFlowFence`／`mathFlowFenceSequence` 三层 token（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:134-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L134-L150)）
- 美元分支在 `$$` 后紧跟第三个 `$` 时失败（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:152-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L152-L154)）
- 内容态遇 EOF 失败；遇 marker 且不处于奇数反斜杠串时尝试闭合围栏；遇换行按 `multiline` 决定走非惰性续行还是失败（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:156-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L156-L171)）
- 反斜杠 marker 在闭合失败后额外检查是否为新的开启围栏，是则整体失败（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:173-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L173-L177)）
- 续行后先尝试闭合围栏，失败则按初始缩进 +1 消费行首空格再回到内容态（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:179-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L179-L187)）
- `mathFlowValue` 逐字符维护 `oddBackslashRun` 奇偶状态，遇 EOF／marker／换行退出回内容态（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:189-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L189-L219)）
- `tokenizeClosingFence` 先按 tabSize 吃行首空格，匹配 marker + closeMarker，其后只允许空白直到行尾或 EOF（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:226-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L226-L253)）
- `tokenizeOpeningFence` 以 `chunkString` 探测 marker + openMarker（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:255-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L255-L276)）
- 返回的构造标记 `concrete: true`，并按 marker 命名为 `sameLineDollarMathFlow` 或 `backslashMathFlow`（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:279-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L279-L283)）
- 非惰性续行构造在下一行被解析器标记为 lazy 时失败（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:286-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L286-L310)）
- 反斜杠块构造实例化为多行的 `\[` … `\]`（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:318-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L318-L323)）
- 美元块构造实例化为单行的 `$$` … `$$`（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:325-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L325-L330)）
- 扩展把两个 flow 构造挂到反斜杠与美元符号码点、把行内构造挂到反斜杠码点（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:332-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L332-L338)）
- `mathCompatibility()` 导出该扩展对象（[packages/client/ui-primitives/src/markdown/mathCompatibility.ts:347-349](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/mathCompatibility.ts#L347-L349)）

### packages/client/ui-primitives/src/markdown/parse.ts

Markdown 渲染器的两套 mdast 语法入口，分别供流式分支与设定态分支使用。

- `parseGfm` 用 gfm 与 cjkFriendlyStrong 扩展解析，不含任何数学扩展（[packages/client/ui-primitives/src/markdown/parse.ts:26-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/parse.ts#L26-L31)）
- `parseGfmWithMath` 在同一组扩展上追加 `mathCompatibility()` 与 `math()`，并挂上 `mathFromMarkdown()`（[packages/client/ui-primitives/src/markdown/parse.ts:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/parse.ts#L39-L44)）

### packages/client/ui-primitives/src/markdown/plain-text.ts

把 Markdown 源码投影成纯文本的提取器，用于摘要与标签一类紧凑展示。

- `inlineText` 对 text／inlineCode／code 取 `value`，image／imageReference 取 `alt`，`break` 产出换行，`html` 取原文，其余递归子节点（[packages/client/ui-primitives/src/markdown/plain-text.ts:27-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/plain-text.ts#L27-L43)）
- `compactInline` 把连续空白折成单个空格并去首尾（[packages/client/ui-primitives/src/markdown/plain-text.ts:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/plain-text.ts#L45-L47)）
- `blockText` 按节点类型决定连接符：根与引用块用空行、列表用换行、列表项用空格、表格行用制表符，`thematicBreak` 与 `definition` 产出空串（[packages/client/ui-primitives/src/markdown/plain-text.ts:49-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/plain-text.ts#L49-L77)）
- `findFirstParagraph` 深度优先找第一个非空段落（[packages/client/ui-primitives/src/markdown/plain-text.ts:79-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/plain-text.ts#L79-L89)）
- `fullText` 逐行 trim、把三个及以上连续换行压成两个（[packages/client/ui-primitives/src/markdown/plain-text.ts:91-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/plain-text.ts#L91-L98)）
- `extractMarkdownPlainText` 用 `parseGfm` 解析，按 `all`／`first-line`／`first-paragraph` 三种模式返回，后者找不到段落时回落到首个非空行（[packages/client/ui-primitives/src/markdown/plain-text.ts:106-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/plain-text.ts#L106-L121)）

### packages/client/ui-primitives/src/markdown/render.tsx

mdast 到 React 的直接渲染器，一个 switch 覆盖所有节点类型，是 Markdown 文本组件展示模型回复的落地实现。

- `sanitizeUrl` 只放行 `http:`／`https:`／`mailto:`，其余协议与不可解析串返回空串（[packages/client/ui-primitives/src/markdown/render.tsx:44-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L44-L59)）
- `remoteImageUrl` 额外要求图片是绝对 HTTP(S) 地址（[packages/client/ui-primitives/src/markdown/render.tsx:61-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L61-L69)）
- `collectReferenceTargets` 深度优先收集 definition 与 footnoteDefinition，按大写标识符首次出现者胜（[packages/client/ui-primitives/src/markdown/render.tsx:93-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L93-L107)）
- `renderBlocks` 用块自带的流式稳定 key 渲染，并丢弃渲染为 null 的块（[packages/client/ui-primitives/src/markdown/render.tsx:155-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L155-L162)）
- `wrapBlockChildren` 在块级子节点之间插入换行文本节点，`edges` 为真时首尾也各加一个（[packages/client/ui-primitives/src/markdown/render.tsx:173-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L173-L181)）
- `renderBlockEntries` 把段落与其它块区分为两种条目，段落只渲染其行内子节点（[packages/client/ui-primitives/src/markdown/render.tsx:191-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L191-L205)）
- 标题按 `depth` 动态生成 `h1`…`h6` 元素（[packages/client/ui-primitives/src/markdown/render.tsx:220-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L220-L221)）
- 引用块给子渲染上下文置 `inBlockquote: true`，并按边界包裹换行（[packages/client/ui-primitives/src/markdown/render.tsx:222-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L222-L230)）
- `break` 渲染为 `<br>` 后跟一个换行文本节点（[packages/client/ui-primitives/src/markdown/render.tsx:233-235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L233-L235)）
- 行内代码先把换行替换成空格（[packages/client/ui-primitives/src/markdown/render.tsx:242-244](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L242-L244)）
- 整段行内代码恰为绝对 HTTP(S) URL 时，在 `<code>` 内包一个安全外链（[packages/client/ui-primitives/src/markdown/render.tsx:250-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L250-L251)）
- 行内代码被外部 `fileMentions.resolve` 认出时渲染成带 `onClick` 打开动作的按钮，处于链接内部则跳过解析（[packages/client/ui-primitives/src/markdown/render.tsx:255-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L255-L270)）
- `html` 节点原样作为文本返回，不进入 DOM 解析（[packages/client/ui-primitives/src/markdown/render.tsx:273-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L273-L275)）
- `math` 与 `inlineMath` 分别以显示模式与行内模式交给 `renderTexToReact`（[packages/client/ui-primitives/src/markdown/render.tsx:278-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L278-L281)）
- `link` 渲染子节点时置 `inLink: true`（[packages/client/ui-primitives/src/markdown/render.tsx:289-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L289-L290)）
- `definition`／`footnoteDefinition` 返回 null，未映射的节点类型也走返回 null 的默认分支（[packages/client/ui-primitives/src/markdown/render.tsx:299-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L299-L308)）
- 空围栏渲染为不带内容的 `<pre><code class="language-…">`（[packages/client/ui-primitives/src/markdown/render.tsx:313-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L313-L321)）
- 语言标识用 `/^[\w-]+/` 截断到第一个非词字符（[packages/client/ui-primitives/src/markdown/render.tsx:324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L324)）
- 非流式且语言为 `math` 的围栏改渲染成显示模式 TeX，内容尾部补一个换行（[packages/client/ui-primitives/src/markdown/render.tsx:325-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L325-L329)）
- 其余围栏交给 `CodeBlock`，代码尾部补一个换行，并透传流式标志与复制按钮文案（[packages/client/ui-primitives/src/markdown/render.tsx:330-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L330-L347)）
- 列表松紧由自身 `spread` 或任一列表项的 `spread`／子节点数决定（[packages/client/ui-primitives/src/markdown/render.tsx:351-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L351-L357)）
- 列表按 `ordered` 选 `ol`／`ul`，`start` 不为 1 时输出该属性，含勾选项时加 `contains-task-list` 类（[packages/client/ui-primitives/src/markdown/render.tsx:359-371](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L359-L371)）
- 任务项在首段前插入禁用复选框，首个条目不是段落时另起一个段落条目承载它（[packages/client/ui-primitives/src/markdown/render.tsx:379-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L379-L389)）
- 列表项按松紧决定是否包 `<p>`、以及换行插在哪些子节点前后（[packages/client/ui-primitives/src/markdown/render.tsx:394-408](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L394-L408)）
- 表格列数达到 4 且不在引用块内时标为宽表，挂 `md-table-wide` 类并给容器 `tabIndex={0}`，否则用填充类（[packages/client/ui-primitives/src/markdown/render.tsx:411-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L411-L441)）
- 存在列对齐时每行按对齐数组长度补齐或截断单元格，并把对齐写成行内 `textAlign` 样式（[packages/client/ui-primitives/src/markdown/render.tsx:443-466](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L443-L466)）
- `renderSafeLink` 在协议不过白名单时脱去锚点只留子节点，过白名单的 HTTP(S) 链接补 `target="_blank"` 与 `rel="noopener noreferrer"`（[packages/client/ui-primitives/src/markdown/render.tsx:469-482](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L469-L482)）
- `renderAnchor` 先对解析出的目标做 `normalizeUri` 再交给白名单（[packages/client/ui-primitives/src/markdown/render.tsx:485-487](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L485-L487)）
- `inlineCodeHttpUrl` 要求前后无空白且整串是绝对 HTTP(S) URL（[packages/client/ui-primitives/src/markdown/render.tsx:493-502](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L493-L502)）
- 图片地址不合规时退化为只显示 alt 文本的 span，合规时输出带 `loading="lazy"`、`decoding="async"`、`referrerPolicy="no-referrer"` 的 `img`（[packages/client/ui-primitives/src/markdown/render.tsx:504-520](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L504-L520)）
- `referenceSuffix` 按 collapsed／full／shortcut 决定回退时补出的方括号源文本（[packages/client/ui-primitives/src/markdown/render.tsx:523-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L523-L527)）
- 链接引用查不到定义时还原为方括号源文本，查到则按定义 URL 出锚点（[packages/client/ui-primitives/src/markdown/render.tsx:529-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L529-L543)）
- 图片引用查不到定义时还原为 `![alt…]` 源文本（[packages/client/ui-primitives/src/markdown/render.tsx:545-553](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L545-L553)）
- 脚注引用把标识符按首次出现顺序追加到 `footnoteOrder`、累加 `footnoteCounts`，渲染成序号上标（[packages/client/ui-primitives/src/markdown/render.tsx:555-567](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L555-L567)）
- 脚注区按首引顺序遍历，按引用次数生成回引标记，尾段落内联回引、无尾段落时直接追加到块列表（[packages/client/ui-primitives/src/markdown/render.tsx:576-608](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L576-L608)）
- 无可渲染条目时脚注区返回 null，否则输出带 `data-footnotes` 与本地化标题的 section（[packages/client/ui-primitives/src/markdown/render.tsx:609-615](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/markdown/render.tsx#L609-L615)）

### packages/client/ui-primitives/src/pointer-grace.ts

指针离开后延迟关闭浮层的 React hook，被悬浮卡片与菜单一类指针驱动的弹出层使用。

- `POINTER_GRACE_MS` 固定为 200 毫秒（[packages/client/ui-primitives/src/pointer-grace.ts:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/pointer-grace.ts#L8)）
- 每次渲染都把最新的 `close` 写入 ref，定时器触发时读取的是最新闭包（[packages/client/ui-primitives/src/pointer-grace.ts:27-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/pointer-grace.ts#L27-L28)）
- `cancel` 清掉待触发的定时器并置空句柄（[packages/client/ui-primitives/src/pointer-grace.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/pointer-grace.ts#L30-L34)）
- `arm` 先取消已有定时器再重新排一个延时关闭（[packages/client/ui-primitives/src/pointer-grace.ts:36-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/pointer-grace.ts#L36-L42)）
- 卸载时执行 `cancel`，丢弃未触发的关闭（[packages/client/ui-primitives/src/pointer-grace.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/pointer-grace.ts#L44)）

### packages/client/ui-primitives/src/relative-time.ts

把时间差折算成紧凑相对时间桶的纯函数，供多个列出会话的界面共用同一套分桶。

- `relativeTime` 先把差值截断到非负，再按 1 分钟、1 小时、1 天、30 天、365 天的阈值依次落到 now／minutes／hours／days／months／years 桶并取整（[packages/client/ui-primitives/src/relative-time.ts:25-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/relative-time.ts#L25-L35)）

### packages/client/ui-primitives/src/use-copy-feedback.ts

复制到剪贴板并给一秒成功反馈的 React hook，被代码块等带复制按钮的组件使用。

- `COPIED_FEEDBACK_MS` 固定为 1000 毫秒（[packages/client/ui-primitives/src/use-copy-feedback.ts:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/use-copy-feedback.ts#L5)）
- `onCopy` 在 `copied` 仍为真时直接返回，不重复写剪贴板（[packages/client/ui-primitives/src/use-copy-feedback.ts:22-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/use-copy-feedback.ts#L22-L23)）
- 写入失败时静默返回，成功后置 `copied` 为真并在超时后复位（[packages/client/ui-primitives/src/use-copy-feedback.ts:24-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/use-copy-feedback.ts#L24-L28)）

### packages/client/ui-primitives/src/useAnchoredMaxHeight.ts

给底部锚定浮层按视口空间夹取最大高度的 React hook，被斜杠菜单与弹出选择器使用。

- `MARGIN` 固定为 12 像素，是浮层与视口顶边保留的距离（[packages/client/ui-primitives/src/useAnchoredMaxHeight.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredMaxHeight.ts#L11)）
- 布局副作用在 `ref.current` 为 null 时直接跳过测量（[packages/client/ui-primitives/src/useAnchoredMaxHeight.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredMaxHeight.ts#L24-L25)）
- 测量把元素底边减去边距，与设计上限取小、与 0 取大后写入状态（[packages/client/ui-primitives/src/useAnchoredMaxHeight.ts:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredMaxHeight.ts#L26-L29)）
- 挂载期间监听 window 的 resize 与捕获阶段 scroll 重新测量，卸载时移除（[packages/client/ui-primitives/src/useAnchoredMaxHeight.ts:30-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredMaxHeight.ts#L30-L36)）
- 依赖数组含外部传入的 `signal`，其变化触发重新测量（[packages/client/ui-primitives/src/useAnchoredMaxHeight.ts:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredMaxHeight.ts#L36)）

### packages/client/ui-primitives/src/useAnchoredPosition.ts

让固定定位的浮层跟随触发元素的 React hook，被传送到 body 的面板类组件使用。

- `open` 为假时把位置状态置 null 并不再注册任何监听（[packages/client/ui-primitives/src/useAnchoredPosition.ts:38-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredPosition.ts#L38-L41)）
- `place` 读锚点视口矩形，锚点缺失时直接返回（[packages/client/ui-primitives/src/useAnchoredPosition.ts:46-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredPosition.ts#L46-L47)）
- 面板左上角取锚点左边与锚点底边加 `gap`，再按面板实际宽高在 `margin` 内夹进视口，最后写入状态（[packages/client/ui-primitives/src/useAnchoredPosition.ts:48-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredPosition.ts#L48-L56)）
- 打开的同一次提交内先测一次，再注册捕获阶段 scroll 与 resize 监听（[packages/client/ui-primitives/src/useAnchoredPosition.ts:60-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredPosition.ts#L60-L62)）
- 环境提供 `ResizeObserver` 且面板存在时观察面板自身尺寸变化重新定位（[packages/client/ui-primitives/src/useAnchoredPosition.ts:68-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredPosition.ts#L68-L73)）
- 清理函数断开观察者并移除两个 window 监听（[packages/client/ui-primitives/src/useAnchoredPosition.ts:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useAnchoredPosition.ts#L74-L78)）

### packages/client/ui-primitives/src/useDismissOnOutsidePointer.ts

在浮层外按下指针时关闭浮层的 React hook，被触发器自持的弹出面板使用。

- `open` 为假时不注册监听（[packages/client/ui-primitives/src/useDismissOnOutsidePointer.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useDismissOnOutsidePointer.ts#L20)）
- 指针按下的目标是 Node 且不在根元素内时调用 `setOpen(false)`（[packages/client/ui-primitives/src/useDismissOnOutsidePointer.ts:21-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useDismissOnOutsidePointer.ts#L21-L25)）
- 在 document 上注册 `pointerdown` 监听，清理时移除（[packages/client/ui-primitives/src/useDismissOnOutsidePointer.ts:26-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/useDismissOnOutsidePointer.ts#L26-L27)）

### packages/client/ui-primitives/src/user-text.module.css

`user-text.tsx` 的 CSS Module，定义纯文本段与引用芯片的行内排版类。

- 无运行期机制

### packages/client/ui-primitives/src/user-text.tsx

把已发送的用户文本投影成纯文本段与引用芯片的函数，用于消息气泡与排队行的展示。

- `SESSION_WIRE_RE` 匹配 `@[label](dsh-session:…)` 线格式（[packages/client/ui-primitives/src/user-text.tsx:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L16)）
- 每次调用先把正则的 `lastIndex` 归零，再逐个收集线格式区间，显示文本取自第一个捕获组（[packages/client/ui-primitives/src/user-text.tsx:36-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L36-L46)）
- 传入的会话标签先去重并按长度从长到短排序，再在文本中逐个查找所有 `@label` 出现位置（[packages/client/ui-primitives/src/user-text.tsx:47-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L47-L54)）
- 词边界正则识别 `/name`、`@"带空格的路径"` 与裸 `@token` 三种形态（[packages/client/ui-primitives/src/user-text.tsx:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L55)）
- 非引号形态剥掉尾部中英文标点，长度不超过 1 的 token 被丢弃（[packages/client/ui-primitives/src/user-text.tsx:60-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L60-L64)）
- 区间按起点升序、会话优先于普通、同起点取更长者排序（[packages/client/ui-primitives/src/user-text.tsx:66-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L66-L67)）
- 与已消费游标重叠的区间被跳过，区间之前的文本作为纯文本段推入（[packages/client/ui-primitives/src/user-text.tsx:73-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L73-L76)）
- 引用种类由区间 kind 与 token 形态推出：会话、以 `/` 结尾的文件夹、其余文件，`/name` 形态无种类（[packages/client/ui-primitives/src/user-text.tsx:77-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L77-L81)）
- 显示文本优先用预解析结果，否则会话去掉前缀 `@`、文件去引号后取最后一段路径（[packages/client/ui-primitives/src/user-text.tsx:82-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L82-L87)）
- 芯片 span 带 `data-ref-chip` 属性（无种类时为 `skill`）、原文 title，并在有种类时前置图标（[packages/client/ui-primitives/src/user-text.tsx:88-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L88-L100)）
- 没有任何区间时整段作为单个纯文本 span 返回，否则把游标之后的剩余文本补成尾段（[packages/client/ui-primitives/src/user-text.tsx:103-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/src/user-text.tsx#L103-L105)）

### packages/client/ui-primitives/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与工程引用。

- 无运行期机制

### packages/client/ui-primitives/tsdown.config.ts

该包的打包配置，声明产物入口。

- 以静态链接方式声明 `lib/types/index.js` 与 `lib/types/invariant.js` 两个打包入口，决定该包在运行期可加载的两个产物（[packages/client/ui-primitives/tsdown.config.ts:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-primitives/tsdown.config.ts#L3-L6)）
