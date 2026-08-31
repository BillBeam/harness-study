---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-attachment
---

# packages/client/ui-attachment

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 20 个文件、95 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-attachment/README.md

该包的说明文档，介绍附件呈现插件填充哪些槽位、草稿图轨道与灯箱的行为，供该包的使用者与维护者阅读。

- 无运行期机制

### packages/client/ui-attachment/package.json

该包的 npm 清单，声明入口映射、浏览器插件行的注入依赖与发布文件集。

- `exports` 把 `.`、`./invariant`、`./client` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 及各自的类型文件，并放开 `./src/*` 与 `./package.json`（[packages/client/ui-attachment/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/package.json#L16-L31)）
- `dsh.client.inject` 列出四个需先就位的客户端包，并把 `platform` 定为 `web`（[packages/client/ui-attachment/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/package.json#L32-L42)）
- `files` 只把三个 `lib` 运行期文件与 `lib/types/**/*.d.ts` 纳入发布（[packages/client/ui-attachment/package.json:66-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/package.json#L66-L71)）

### packages/client/ui-attachment/src/AttachmentRail.module.css

草稿图轨道组件的 CSS Module，被 `AttachmentRail.tsx` 以 `css.*` 引用。

- `.rail` 用 `overflow-x: auto` 建立横向滚动容器，并以 `scrollbar-width: none` 与 `::-webkit-scrollbar { display: none }` 隐藏滚动条（[packages/client/ui-attachment/src/AttachmentRail.module.css:6-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.module.css#L6-L22)）
- `.item` 以 `flex: 0 0 64px` 固定每个卡片的 64×64 尺寸（[packages/client/ui-attachment/src/AttachmentRail.module.css:24-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.module.css#L24-L29)）
- `.thumbnail img` 用 `object-fit: cover` 铺满 64×64 方框（[packages/client/ui-attachment/src/AttachmentRail.module.css:42-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.module.css#L42-L47)）
- `.remove` 默认 `opacity: 0`，仅在 `.item:hover` 或 `.remove:focus-visible` 时显现（[packages/client/ui-attachment/src/AttachmentRail.module.css:49-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.module.css#L49-L71)）
- `@media (pointer: coarse)` 让移除控件恒为 `opacity: 1`（[packages/client/ui-attachment/src/AttachmentRail.module.css:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.module.css#L74-L78)）
- `@media (prefers-reduced-motion: reduce)` 取消移除控件的透明度过渡（[packages/client/ui-attachment/src/AttachmentRail.module.css:80-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.module.css#L80-L84)）
- `.arrow` 绝对定位在轨道上层（`z-index: 2`），并由 `.arrowLeft` / `.arrowRight` 分别贴左右边（[packages/client/ui-attachment/src/AttachmentRail.module.css:86-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.module.css#L86-L114)）

### packages/client/ui-attachment/src/AttachmentRail.tsx

草稿附件的横向缩略图轨道组件，被 `client/ComposerAttachments.tsx` 装配进输入区槽位。

- `WHEEL_LINE_PX` 固定为 16，用作 `deltaMode` 为行单位时的像素换算系数（[packages/client/ui-attachment/src/AttachmentRail.tsx:35-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L35-L37)）
- `pageBehavior` 读取 `matchMedia('(prefers-reduced-motion: reduce)')`，命中时返回 `auto`，否则返回 `smooth`，且 `matchMedia` 缺失时走可选调用（[packages/client/ui-attachment/src/AttachmentRail.tsx:39-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L39-L45)）
- `updateEdges` 依 `scrollLeft > 1` 与 `scrollLeft < scrollWidth - clientWidth - 1` 算出左右箭头是否显示，两值都未变时返回原 state 对象（[packages/client/ui-attachment/src/AttachmentRail.tsx:79-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L79-L87)）
- `useLayoutEffect` 以 `countRef` 为 `null` 区分首次布局与项数增长，仅在增长时把 `scrollLeft` 设到末端，然后调用 `updateEdges`（[packages/client/ui-attachment/src/AttachmentRail.tsx:88-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L88-L97)）
- 挂载时在 `ResizeObserver` 存在的环境里观察轨道元素本身并回调 `updateEdges`，卸载时 `disconnect`（[packages/client/ui-attachment/src/AttachmentRail.tsx:98-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L98-L111)）
- `onWheel` 在 `deltaY === 0` 时直接返回，否则按 `deltaMode` 取 `WHEEL_LINE_PX`、`clientWidth` 或 `1` 作为换算系数，调用 `preventDefault`，并以 `deltaX * scale`（`deltaX` 非零时）或 `sign(deltaY) * min(|deltaY| * scale, 60)` 横向 `scrollBy`（[packages/client/ui-attachment/src/AttachmentRail.tsx:121-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L121-L133)）
- 以 `{ passive: false }` 手动挂载 `wheel` 监听，清理函数中断开观察并移除监听（[packages/client/ui-attachment/src/AttachmentRail.tsx:134-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L134-L139)）
- `page` 按 `direction * Math.max(clientWidth - 64, 200)` 的距离 `scrollBy`，滚动行为取自 `pageBehavior()`（[packages/client/ui-attachment/src/AttachmentRail.tsx:140-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L140-L147)）
- 左箭头按钮仅在 `edges.left` 为真时渲染，点击调用 `page(-1)`，`aria-label` 取 `labels.scrollLeft`（[packages/client/ui-attachment/src/AttachmentRail.tsx:150-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L150-L159)）
- 轨道容器带 `role="group"` 与 `aria-label={labels.group}`，并把 `onScroll` 接到 `updateEdges`（[packages/client/ui-attachment/src/AttachmentRail.tsx:160-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L160-L166)）
- 每项以 `item.id` 为 key 渲染缩略图按钮，`title` 取 `labels.open`，点击调用 `onOpen(item)`，图片 `src` 为 `item.previewUrl`、`alt` 为 `item.alt`（[packages/client/ui-attachment/src/AttachmentRail.tsx:167-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L167-L176)）
- 每项另渲染移除按钮，`aria-label` 取 `item.removeLabel`，点击调用 `onRemove(item)`（[packages/client/ui-attachment/src/AttachmentRail.tsx:177-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L177-L184)）
- 右箭头按钮仅在 `edges.right` 为真时渲染，点击调用 `page(1)`（[packages/client/ui-attachment/src/AttachmentRail.tsx:188-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/AttachmentRail.tsx#L188-L197)）

### packages/client/ui-attachment/src/DropOverlay.module.css

拖放提示层的 CSS Module，被 `DropOverlay.tsx` 引用。

- `.mask` 用 `position: fixed; inset: 0; z-index: 1000` 铺满视口，并以 `pointer-events: none` 让拖拽事件继续落到下方页面（[packages/client/ui-attachment/src/DropOverlay.module.css:3-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.module.css#L3-L14)）
- `.mask` 播放 160ms 的 `fade-in` 动画，`@media (prefers-reduced-motion: reduce)` 下取消该动画（[packages/client/ui-attachment/src/DropOverlay.module.css:16-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.module.css#L16-L25)）
- `.illustration` 固定 115×84 的插图尺寸（[packages/client/ui-attachment/src/DropOverlay.module.css:37-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.module.css#L37-L40)）
- `.desc` 用 `white-space: pre-wrap` 保留限制文案里的换行（[packages/client/ui-attachment/src/DropOverlay.module.css:47-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.module.css#L47-L52)）

### packages/client/ui-attachment/src/DropOverlay.tsx

拖拽文件经过页面时显示的全视口提示层组件，被 `client/ComposerAttachments.tsx` 在 `dragActive` 时渲染。

- 整层通过 `createPortal` 挂到 `document.body`（[packages/client/ui-attachment/src/DropOverlay.tsx:28-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.tsx#L28-L39)）
- 最外层带 `role="status"`（[packages/client/ui-attachment/src/DropOverlay.tsx:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.tsx#L29)）
- `disabled` 决定渲染 `UploadDisabledIllustration` 还是 `UploadIllustration`，插图容器标 `aria-hidden`（[packages/client/ui-attachment/src/DropOverlay.tsx:31-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.tsx#L31-L33)）
- 标题始终渲染 `labels.title`，限制说明行仅在未禁用且 `labels.desc` 存在时渲染（[packages/client/ui-attachment/src/DropOverlay.tsx:34-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.tsx#L34-L35)）
- `UploadIllustration` 内联一段 115×84 的 SVG，并以固定 id `dshDropOverlayClip` 定义裁剪路径（[packages/client/ui-attachment/src/DropOverlay.tsx:43-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.tsx#L43-L62)）
- `UploadDisabledIllustration` 内联另一段 115×84 的 SVG（[packages/client/ui-attachment/src/DropOverlay.tsx:65-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/DropOverlay.tsx#L65-L77)）

### packages/client/ui-attachment/src/ImageLightbox.module.css

原图灯箱的 CSS Module，被 `ImageLightbox.tsx` 引用。

- `.backdrop` 用 `position: fixed; inset: 0; z-index: 1000` 覆盖视口并居中内容（[packages/client/ui-attachment/src/ImageLightbox.module.css:1-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.module.css#L1-L8)）
- `.mask` 作为独立的绝对定位层铺满 backdrop，承接关闭用的鼠标按下事件并施加模糊（[packages/client/ui-attachment/src/ImageLightbox.module.css:13-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.module.css#L13-L18)）
- `.image` 以 `max-width: min(100%, 1600px)`、`max-height: calc(100vh - 80px)` 和 `object-fit: contain` 限定原图显示尺寸，并用 `position: relative` 叠在遮罩之上（[packages/client/ui-attachment/src/ImageLightbox.module.css:20-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.module.css#L20-L28)）
- `.close` 用 `position: fixed` 固定在视口右上角并置于 `z-index: 1`（[packages/client/ui-attachment/src/ImageLightbox.module.css:30-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.module.css#L30-L44)）

### packages/client/ui-attachment/src/ImageLightbox.tsx

原图预览弹层组件，被 `client/ComposerAttachments.tsx` 与 `MessageImage.tsx` 在点击缩略图后渲染。

- 挂载时把当前 `document.activeElement` 记入 `restoreRef`，并把焦点移到关闭按钮（[packages/client/ui-attachment/src/ImageLightbox.tsx:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.tsx#L36-L38)）
- 在 `window` 上监听 `keydown`，按下 `Escape` 时调用 `onClose`（[packages/client/ui-attachment/src/ImageLightbox.tsx:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.tsx#L39-L42)）
- 清理函数移除 `keydown` 监听并把焦点还给 `restoreRef` 记录的元素（[packages/client/ui-attachment/src/ImageLightbox.tsx:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.tsx#L43-L47)）
- 弹层通过 `createPortal` 挂到 `document.body`（[packages/client/ui-attachment/src/ImageLightbox.tsx:49-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.tsx#L49-L63)）
- 容器带 `role="dialog"`、`aria-modal="true"` 与 `aria-label={labels.dialog}`（[packages/client/ui-attachment/src/ImageLightbox.tsx:50-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.tsx#L50-L55)）
- 遮罩层标 `aria-hidden` 并把 `onMouseDown` 接到 `onClose`（[packages/client/ui-attachment/src/ImageLightbox.tsx:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.tsx#L56)）
- 图片直接以传入的 `src` / `alt` 渲染（[packages/client/ui-attachment/src/ImageLightbox.tsx:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.tsx#L57)）
- 关闭按钮绑定 `closeRef`、`aria-label={labels.close}`，点击调用 `onClose`（[packages/client/ui-attachment/src/ImageLightbox.tsx:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/ImageLightbox.tsx#L58-L60)）

### packages/client/ui-attachment/src/MessageImage.module.css

历史消息图片与图组的 CSS Module，被 `MessageImage.tsx` 引用。

- `.gallery` 用 `flex-wrap: wrap` 与 `max-width: 100%` 排布图组，`data-align` 取 `end` / `start` 时分别右对齐或左对齐（[packages/client/ui-attachment/src/MessageImage.module.css:1-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.module.css#L1-L16)）
- `.frame` 给出 44px 的最小可点击尺寸并裁掉溢出（[packages/client/ui-attachment/src/MessageImage.module.css:18-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.module.css#L18-L30)）
- `.frame[data-variant='tile']` 把方块图钉死在 64×64（[packages/client/ui-attachment/src/MessageImage.module.css:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.module.css#L32-L37)）
- `.frame img` 用 `object-fit: cover` 填满外框（[packages/client/ui-attachment/src/MessageImage.module.css:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.module.css#L39-L44)）
- `.error[data-variant='tile']` 让加载失败的方块图仍保持 64×64 并裁掉溢出文案（[packages/client/ui-attachment/src/MessageImage.module.css:62-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.module.css#L62-L69)）

### packages/client/ui-attachment/src/MessageImage.tsx

历史消息图片的渲染组件与图组容器，被 `client/MessageImages.tsx` 用于消息与轨迹两个槽位。

- `singleFit` 把自然宽高比夹到 `[0.25, 4]`，按长边 240 算出显示框，再用 `Math.min(1, width/box.width, height/box.height)` 的缩放系数避免放大，宽高取整并保底为 1（[packages/client/ui-attachment/src/MessageImage.tsx:45-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L45-L54)）
- `singleFit` 依原始比例返回 `objectPosition`：小于 0.25 用 `center top`，大于 4 用 `left center`，否则 `center`（[packages/client/ui-attachment/src/MessageImage.tsx:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L55)）
- `dimensionsOf` 对持久引用直接返回其宽高，对本地预览只在 `width` 与 `height` 都存在时返回，否则返回 `undefined`（[packages/client/ui-attachment/src/MessageImage.tsx:60-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L60-L65)）
- `loaded` 的初值来自 `load.peek?.(attachment)`，无缓存时为 `null`（[packages/client/ui-attachment/src/MessageImage.tsx:87-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L87-L88)）
- `attempt` 计数与 `request` 回调把重试转成同一个加载副作用的重新触发（[packages/client/ui-attachment/src/MessageImage.tsx:93-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L93-L94)）
- `fit` 在 `variant` 非 `single` 时为 `undefined`，尺寸未知时退回 240×240 与 `center`，否则取 `singleFit(dimensions)`（[packages/client/ui-attachment/src/MessageImage.tsx:97-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L97-L107)）
- 加载副作用在无持久引用时直接返回，否则清 `error`、重设 peek 值、调用 `load(attachment)`，并用 `live` 标志在卸载或依赖变化后丢弃迟到的成功与失败回调，依赖数组含 `attempt`（[packages/client/ui-attachment/src/MessageImage.tsx:109-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L109-L116)）
- 实际 `src` 取 `preview?.url ?? loaded`，显示名按 `preview?.name`、`attachment?.name`、`labels.image` 依次回退（[packages/client/ui-attachment/src/MessageImage.tsx:118-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L118-L119)）
- `error` 为真时改渲染一个按钮，文案为 `labels.loadFailed`，点击调用 `request` 重试（[packages/client/ui-attachment/src/MessageImage.tsx:120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L120)）
- 主按钮带 `data-variant`、由 `fit` 决定的行内宽高、`title` 与 `aria-label`，点击仅在 `src` 非 `null` 时把 `open` 置真（[packages/client/ui-attachment/src/MessageImage.tsx:123-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L123-L131)）
- `src` 为 `null` 时渲染 `labels.loading` 占位，否则渲染带 `objectPosition` 行内样式的图片（[packages/client/ui-attachment/src/MessageImage.tsx:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L132-L134)）
- `open` 为真且 `src` 非 `null` 时挂出 `ImageLightbox`，关闭回调把 `open` 置假（[packages/client/ui-attachment/src/MessageImage.tsx:136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L136)）
- `ImageGallery` 在 `images` 为空时返回 `null`（[packages/client/ui-attachment/src/MessageImage.tsx:149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L149)）
- `variant` 由 `images.length === 1` 决定为 `single` 或 `tile`，并传给每个条目（[packages/client/ui-attachment/src/MessageImage.tsx:150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L150)）
- 图组容器带 `data-align={align}`，每个条目的 key 由 `attachmentId` 或预览 URL 加下标拼成（[packages/client/ui-attachment/src/MessageImage.tsx:152-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/MessageImage.tsx#L152-L155)）

### packages/client/ui-attachment/src/client/ComposerAttachments.module.css

输入区附件装配体的 CSS Module，只给轨道容器一层内边距。

- 无运行期机制

### packages/client/ui-attachment/src/client/ComposerAttachments.tsx

输入区附件槽位的入口组件，装配草稿图轨道、文档级拖放目标与原图预览。

- 每当 `attachments` 变化，若当前预览对应的 id 已不在其中则清空预览（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L26-L28)）
- `fileTransfer` 在 `dataTransfer` 为 `null` 或其 `types` 不含 `'Files'` 时返回 `null`，据此忽略非文件拖拽（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:31-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L31-L35)）
- `reset` 把 `dragDepth` 归零并关闭 `dragActive`（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:36-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L36-L39)）
- `dragenter` 调用 `preventDefault`，把嵌套深度加一并把 `dragActive` 置真（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:40-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L40-L45)）
- `dragover` 调用 `preventDefault` 并按 `canAcceptDrop` 把 `dropEffect` 设为 `copy` 或 `none`（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:46-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L46-L51)）
- `dragleave` 把深度减一并夹到不小于 0，归零时关闭 `dragActive`；若事件目标是 `documentElement` 或 `body` 且坐标已越出视口边界则直接 `reset`（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:52-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L52-L59)）
- `drop` 调用 `preventDefault` 与 `reset`，并仅在 `canAcceptDrop` 为真时把 `dataTransfer.files` 展开交给 `onAddImages`（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:60-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L60-L66)）
- 在 `document` 上注册 `dragenter`/`dragover`/`dragleave`/`drop`、在 `window` 上注册 `dragend` 到 `reset`，清理时逐个移除（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:67-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L67-L79)）
- `railItems` 把每个草稿附件映射成轨道条目，`alt` 在文件名为空时回退到 `t('image.pending')`，`removeLabel` 由 `t('image.remove', { name })` 生成，并留存原附件对象供回调使用（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:81-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L81-L87)）
- `dragActive` 为真时渲染 `DropOverlay`，`disabled` 取 `!canAcceptDrop`，文案由 `dropOverlayLabels(t, canAcceptDrop, dropLimits)` 解析（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:91-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L91-L96)）
- 仅在轨道条目非空时渲染 `AttachmentRail`，其 `onOpen` 把该附件设为预览、`onRemove` 调用 `onRemoveImage(id)`（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:97-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L97-L106)）
- 预览非空时渲染 `ImageLightbox`，`src` 取该附件的 `previewUrl`，`alt` 在文件名为空时回退到 `t('image.original')`（[packages/client/ui-attachment/src/client/ComposerAttachments.tsx:107-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/ComposerAttachments.tsx#L107-L114)）

### packages/client/ui-attachment/src/client/MessageImages.tsx

历史消息图片槽位的入口组件，同时被消息与轨迹两个槽位注册使用。

- 把槽位传入的 `images`、`loadImage`、`align` 转交 `ImageGallery`，并用 `messageImageLabels(t)` 解析文案（[packages/client/ui-attachment/src/client/MessageImages.tsx:6-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/MessageImages.tsx#L6-L8)）

### packages/client/ui-attachment/src/client/index.ts

浏览器端插件入口，把两个组件登记进三个会话槽位。

- 导出 `inject = ['slots']`，声明该插件需要槽位注册服务（[packages/client/ui-attachment/src/client/index.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/index.ts#L11)）
- 等待 `conversation.input.attachments` 声明后，以 `locale: 'conversation'` 注册 `ComposerAttachments`（[packages/client/ui-attachment/src/client/index.ts:15-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/index.ts#L15-L18)）
- 等待 `conversation.message.images` 声明后注册 `MessageImages`（[packages/client/ui-attachment/src/client/index.ts:19-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/index.ts#L19-L22)）
- 等待 `conversation.trajectory.images` 声明后注册同一个 `MessageImages`（[packages/client/ui-attachment/src/client/index.ts:23-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/index.ts#L23-L26)）

### packages/client/ui-attachment/src/client/labels.ts

把会话语言包中的键解析成各展示组件所需文案对象的函数集合，被三个槽位入口组件调用。

- `lightboxLabels` 解析 `image.preview` 与 `image.closePreview`（[packages/client/ui-attachment/src/client/labels.ts:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/labels.ts#L12-L14)）
- `messageImageLabels` 解析 `image.label`、`image.openOriginal`、`image.loading`、`image.loadFailed`，把 `openNamed` 做成对 `image.openOriginalLabel` 的带参调用，并嵌入灯箱文案（[packages/client/ui-attachment/src/client/labels.ts:21-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/labels.ts#L21-L30)）
- `dropOverlayLabels` 在不接受拖放时只返回 `image.dropBlocked` 标题，接受时返回 `image.dropTitle`，并仅在 `limits` 存在时用它插值出 `image.dropDesc` 说明行（[packages/client/ui-attachment/src/client/labels.ts:39-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/labels.ts#L39-L49)）
- `attachmentRailLabels` 解析 `image.pending`、`image.openOriginal`、`image.scrollLeft`、`image.scrollRight`（[packages/client/ui-attachment/src/client/labels.ts:56-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/client/labels.ts#L56-L63)）

### packages/client/ui-attachment/src/css-modules.d.ts

给 `*.module.css` 与 `*.css` 导入提供 TypeScript 声明的文件。

- 无运行期机制

### packages/client/ui-attachment/src/index.ts

该包的宿主端入口，与浏览器端一半配对。

- 导出一个空的 `apply`，作为宿主端插件体供加载器装载（[packages/client/ui-attachment/src/index.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/index.ts#L4)）

### packages/client/ui-attachment/src/invariant.ts

该包的不变量伴生插件，向不变量服务登记包名。

- 导出插件名 `client-ui-attachment-invariant` 与 `inject = ['invariants']`（[packages/client/ui-attachment/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/invariant.ts#L13-L15)）
- 安装器体为空，不注册任何检查（[packages/client/ui-attachment/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/invariant.ts#L21)）
- `apply` 用 `ctx.invariants.register(PACKAGE_NAME, install)` 占位并把其 disposer 以 Promise 返回（[packages/client/ui-attachment/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/src/invariant.ts#L28-L29)）

### packages/client/ui-attachment/tsconfig.json

该包的 TypeScript 编译配置，继承客户端基配置并列出工程引用。

- 无运行期机制

### packages/client/ui-attachment/tsdown.config.ts

该包的打包配置，声明要打出的产物入口。

- 用 `clientBundle` 以包名和 `lib/types/index.js`、`lib/types/invariant.js` 两个入口生成打包配置（[packages/client/ui-attachment/tsdown.config.ts:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-attachment/tsdown.config.ts#L3-L6)）
