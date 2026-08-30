---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-layout
---

# packages/client/ui-layout

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、66 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-layout/README.md

该包的说明文档，描述三列外壳布局、让位链、面板几何服务与主题呈现，供使用者与维护者阅读。

- 无运行期机制

### packages/client/ui-layout/package.json

该包的 npm 清单，声明入口映射、客户端插件元数据与发布文件集。

- `exports` 把 `.`、`./invariant`、`./client` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，并放开 `./src/*` 与 `./package.json`（[packages/client/ui-layout/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/package.json#L16-L31)）
- `dsh.client` 声明浏览器半边的注入依赖（locale、ui-renderer、ui-session、ui-theme）与 `platform: "web"`（[packages/client/ui-layout/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/package.json#L32-L42)）
- `files` 限定发布产物为三个 bundle 与类型声明（[packages/client/ui-layout/package.json:68-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/package.json#L68-L73)）

### packages/client/ui-layout/src/client/AppFrame.module.css

三列外壳的 CSS Module 样式表，被 `AppFrame.tsx` 以 `css.*` 引用。

- 浮层容器自身 `pointer-events: none`、其直接子元素恢复 `auto`，决定该层是否拦截指针事件（[packages/client/ui-layout/src/client/AppFrame.module.css:110-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.module.css#L110-L119)）

### packages/client/ui-layout/src/client/AppFrame.tsx

注册进内建 `root` 槽位的三列框架组件：解算列宽、承载拖拽手柄，并在固定位置渲染四个子槽位。

- `DetailsColumn` 把详情列包成始终存在的网格单元，配合零宽度让其子树保持挂载（[packages/client/ui-layout/src/client/AppFrame.tsx:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L36-L38)）
- 拖拽手柄每次渲染把最新回调写入 ref，供指针事件处理器读取（[packages/client/ui-layout/src/client/AppFrame.tsx:49-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L49-L50)）
- 指针按下时阻止默认行为、捕获指针、记录起点并回调 `onStart` 且置为拖拽中（[packages/client/ui-layout/src/client/AppFrame.tsx:52-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L52-L59)）
- 指针移动仅在持有捕获时记录坐标，并用 requestAnimationFrame 节流上报相对起点的位移（[packages/client/ui-layout/src/client/AppFrame.tsx:60-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L60-L67)）
- 指针抬起释放捕获、取消挂起的动画帧、补报最后一次位移并回调 `onEnd`（[packages/client/ui-layout/src/client/AppFrame.tsx:68-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L68-L75)）
- 手柄以内联 `left` 定位并输出 `data-side` 与 `data-dragging` 属性（[packages/client/ui-layout/src/client/AppFrame.tsx:77-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L77-L87)）
- 从会话状态选出「当前且非空白」的会话 id 作为详情列依据，以及当前会话标题（[packages/client/ui-layout/src/client/AppFrame.tsx:100-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L100-L107)）
- 视口宽度初值取 `window.innerWidth`（[packages/client/ui-layout/src/client/AppFrame.tsx:109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L109)）
- 布局副作用中检测会话 id 变化并调用 `actions.closeDetails()` 关闭详情列（[packages/client/ui-layout/src/client/AppFrame.tsx:111-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L111-L118)）
- 用 ResizeObserver 观测框架自身盒宽、以 rAF 节流写入，且忽略宽度为 0 的读数；卸载时断开观测并取消动画帧（[packages/client/ui-layout/src/client/AppFrame.tsx:121-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L121-L138)）
- 以 `SIDEBAR_AUTO_COLLAPSE` 判定窄视口，并把该判定写回 store 的 `setNarrow`（[packages/client/ui-layout/src/client/AppFrame.tsx:146-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L146-L147)）
- 侧栏折叠状态在窄视口取 `!narrowExpanded`、否则取「偏好宽度为 0」，并据此算出送入解算器的侧栏偏好（折叠为 0，宽视口偏好为 0 时用默认宽）（[packages/client/ui-layout/src/client/AppFrame.tsx:148-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L148-L151)）
- 调用 `computeColumns` 解算三列宽度，无可用会话时详情偏好按 0 传入（[packages/client/ui-layout/src/client/AppFrame.tsx:152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L152)）
- 解算结果镜像进 ref，供拖拽起始时读取（[packages/client/ui-layout/src/client/AppFrame.tsx:153-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L153-L155)）
- 拖拽开始时把当前渲染宽度冻结为基准并置整帧为拖拽中（[packages/client/ui-layout/src/client/AppFrame.tsx:164-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L164-L166)）
- 侧栏拖拽以 `基准 + dx` 写 `setSidebar`，详情拖拽以 `基准 - dx` 写 `setDetails`（[packages/client/ui-layout/src/client/AppFrame.tsx:167-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L167-L172)）
- 产品标题取构建期环境变量 `DSH_CLIENT_TITLE`，缺省时回落到 `brand.localBuild` 词条（[packages/client/ui-layout/src/client/AppFrame.tsx:173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L173)）
- 框架以内联 `grid-template-columns` 写入解算出的三列宽度，并输出 `data-sidebar-collapsed`、`data-details-collapsed`、`data-dragging` 属性（[packages/client/ui-layout/src/client/AppFrame.tsx:176-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L176-L183)）
- 渲染 `DocumentTitle`，仅在存在会话标题时传入 title（[packages/client/ui-layout/src/client/AppFrame.tsx:184-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L184-L187)）
- 在侧栏列渲染 `sidebar` 槽位并把解算出的 `collapsed` 与 `width` 作为 owner 参数下发（[packages/client/ui-layout/src/client/AppFrame.tsx:188-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L188-L198)）
- 中间列固定渲染 `conversation` 槽位，详情列把 `details` 槽位包在 `SessionProvider` 内（[packages/client/ui-layout/src/client/AppFrame.tsx:205-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L205-L208)）
- 在带 `data-shell-overlay` 的浮层容器内渲染 `shell.overlay` 列表槽位（[packages/client/ui-layout/src/client/AppFrame.tsx:210-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L210-L212)）
- 侧栏手柄仅在未折叠时渲染，详情手柄仅在详情宽度大于 0 时渲染并定位在 `viewport - details`（[packages/client/ui-layout/src/client/AppFrame.tsx:213-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/AppFrame.tsx#L213-L215)）

### packages/client/ui-layout/src/client/DocumentTitle.tsx

把当前会话标题投射到浏览器标题的无渲染组件，由 `AppFrame` 挂载。

- 副作用中按有无会话标题写 `document.title`（有标题时拼成 `标题 — 产品名`）（[packages/client/ui-layout/src/client/DocumentTitle.tsx:18-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/DocumentTitle.tsx#L18-L19)）
- 清理函数把 `document.title` 还原为产品标题（[packages/client/ui-layout/src/client/DocumentTitle.tsx:20-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/DocumentTitle.tsx#L20-L21)）
- 组件本身不渲染任何内容，返回 `null`（[packages/client/ui-layout/src/client/DocumentTitle.tsx:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/DocumentTitle.tsx#L22)）

### packages/client/ui-layout/src/client/columns.ts

三列宽度的纯函数解算模块，导出几何常量、夹取函数与让位链求解，被 `AppFrame` 与 store 使用。

- 导出固定几何常量：中列下限 640、侧栏 264/420/280、折叠轨 56、自动折叠断点 1024、详情 300/520/360（[packages/client/ui-layout/src/client/columns.ts:19-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/columns.ts#L19-L39)）
- `clampWidth` 四舍五入后夹取到给定上下界（[packages/client/ui-layout/src/client/columns.ts:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/columns.ts#L48-L50)）
- 侧栏偏好为 0 时解为固定折叠轨宽，否则夹取到侧栏区间；详情偏好为 0 时解为 0，否则夹取到详情区间（[packages/client/ui-layout/src/client/columns.ts:64-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/columns.ts#L64-L65)）
- 第一步：三者按偏好宽度放得下时直接返回，中列取剩余宽度（[packages/client/ui-layout/src/client/columns.ts:67-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/columns.ts#L67-L68)）
- 第二步：把详情列压向其最小值，若此时能满足中列下限则中列锁定在下限（[packages/client/ui-layout/src/client/columns.ts:70-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/columns.ts#L70-L72)）
- 第三步：详情列派生为 0（不改写偏好），中列吸收剩余亏空并以 0 兜底（[packages/client/ui-layout/src/client/columns.ts:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/columns.ts#L74-L76)）

### packages/client/ui-layout/src/client/index.ts

浏览器半边的插件入口：提供 `ctx.layout` 服务、把 `AppFrame` 注册进 `root` 槽位并声明四个子槽位，另外挂载主题呈现器。

- 声明所需服务注入 `slots`、`theme`、`locale`（[packages/client/ui-layout/src/client/index.ts:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/index.ts#L111)）
- 构造 `LayoutController` 并在 effect 中以 `ctx.reflect.provide('layout', layout)` 提供服务（[packages/client/ui-layout/src/client/index.ts:120-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/index.ts#L120-L122)）
- 单次 `ctx.slots.register` 把 `AppFrame` 注册进 `root`，并同时声明 `sidebar`/`conversation`/`details`/`shell.overlay` 四个子槽位及其 kind 与 scope（[packages/client/ui-layout/src/client/index.ts:123-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/index.ts#L123-L132)）
- 同一注册传入 `createLayoutStore` 工厂，由框架按条目实例化并把 `useStore`/`actions` 作为标准 props 交给 `AppFrame`（[packages/client/ui-layout/src/client/index.ts:133-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/index.ts#L133-L135)）
- 注册的 `inject` 钩子把 store 的绑定动作交给 `LayoutController`，使 `ctx.layout` 自条目首次渲染起可用（[packages/client/ui-layout/src/client/index.ts:136-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/index.ts#L136-L140)）
- effect 的清理先注销槽位注册，再以 fire-and-forget 方式注销服务（[packages/client/ui-layout/src/client/index.ts:142-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/index.ts#L142-L147)）
- 第二个 effect 创建主题呈现器，先用 `ctx.theme.getTheme()` 施加一次初始快照（[packages/client/ui-layout/src/client/index.ts:151-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/index.ts#L151-L153)）
- 订阅 `theme/change` 事件并在每次快照到达时重新施加，清理时退订并调用呈现器的 `dispose`（[packages/client/ui-layout/src/client/index.ts:154-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/index.ts#L154-L159)）

### packages/client/ui-layout/src/client/service.ts

`ctx.layout` 背后的面板动作控制器，被其他插件的 apply 世界调用以触发面板开合。

- `attachPanels` 接过根条目 store 的绑定动作集，重复调用时以新动作覆盖旧的（[packages/client/ui-layout/src/client/service.ts:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/service.ts#L43-L45)）
- `toggleSidebar`/`openDetails`/`closeDetails` 分别转发到 store 的同名绑定动作（[packages/client/ui-layout/src/client/service.ts:47-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/service.ts#L47-L60)）
- 未接入动作集时调用任一方法直接抛错，而不是静默忽略（[packages/client/ui-layout/src/client/service.ts:62-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/service.ts#L62-L68)）

### packages/client/ui-layout/src/client/stores.ts

根条目的瞬态布局 store 工厂，保存面板宽度偏好与窄视口状态，由槽位注册实例化。

- 初始状态：侧栏取默认宽、详情为 0（关闭）、`narrow` 与 `narrowExpanded` 均为 false（[packages/client/ui-layout/src/client/stores.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/stores.ts#L50)）
- `setSidebar` 与 `setDetails` 把写入宽度夹取到各自的契约区间，不跨越开/关分界（[packages/client/ui-layout/src/client/stores.ts:52-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/stores.ts#L52-L53)）
- `toggleSidebar` 在窄视口翻转 `narrowExpanded` 覆盖位，宽视口则在 0 与默认宽之间切换偏好（[packages/client/ui-layout/src/client/stores.ts:56-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/stores.ts#L56-L59)）
- `setNarrow` 在断点状态实际变化时更新 `narrow` 并清空 `narrowExpanded` 覆盖位（[packages/client/ui-layout/src/client/stores.ts:62-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/stores.ts#L62-L66)）
- `openDetails` 仅在详情为 0 时写入默认宽，`closeDetails` 直接写 0（关闭即遗忘拖拽宽度）（[packages/client/ui-layout/src/client/stores.ts:67-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/stores.ts#L67-L68)）

### packages/client/ui-layout/src/client/theme-presenter.ts

把解析后的主题快照写入文档的纯 DOM 施加器，由客户端入口的第二个 effect 持有。

- 构造时创建 `name="theme-color"` 的元信息节点，作为该实例独占的插入/移除对象（[packages/client/ui-layout/src/client/theme-presenter.ts:27-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/theme-presenter.ts#L27-L30)）
- `apply` 把快照的 `active.colorScheme` 写到根元素的 `color-scheme`（[packages/client/ui-layout/src/client/theme-presenter.ts:42-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/theme-presenter.ts#L42-L43)）
- 按色彩方案在 body 上增删暗色调色板属性（[packages/client/ui-layout/src/client/theme-presenter.ts:45-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/theme-presenter.ts#L45-L46)）
- 把快照的字号写成 body 上的 `--dsh-content-font-size` 变量（[packages/client/ui-layout/src/client/theme-presenter.ts:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/theme-presenter.ts#L47)）
- 先移除上一次记录的全部 token 变量并清空记录集，再写入本次快照的 token 并逐个记名（[packages/client/ui-layout/src/client/theme-presenter.ts:48-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/theme-presenter.ts#L48-L53)）
- 在上述写入之后读取 body 的计算背景色作为 `theme-color` 内容，并在节点尚未接入时插入 head（[packages/client/ui-layout/src/client/theme-presenter.ts:54-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/theme-presenter.ts#L54-L55)）
- `dispose` 撤回根元素 `color-scheme`、暗色属性、字号变量、全部已写 token 并移除自有元信息节点（[packages/client/ui-layout/src/client/theme-presenter.ts:59-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/client/theme-presenter.ts#L59-L67)）

### packages/client/ui-layout/src/css-modules.d.ts

CSS Module 的 TypeScript 环境声明文件。

- 无运行期机制

### packages/client/ui-layout/src/index.ts

宿主半边的插件入口，供宿主 Loader 装载这个仅浏览器生效的插件。

- 导出空的 `apply`，插件被装载但不注册任何宿主侧行为（[packages/client/ui-layout/src/index.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/index.ts#L4)）

### packages/client/ui-layout/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属。

- 声明伴生插件名与所需的 `invariants` 服务注入（[packages/client/ui-layout/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/invariant.ts#L13-L15)）
- 安装器为空函数，`apply` 以包名注册该空安装器并返回注册的注销函数（[packages/client/ui-layout/src/invariant.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/src/invariant.ts#L22-L30)）

### packages/client/ui-layout/tsconfig.json

该包的 TypeScript 编译配置与工程引用。

- 无运行期机制

### packages/client/ui-layout/tsdown.config.ts

打包配置，决定该包产出哪些运行时 bundle。

- 以包名与入口列表 `lib/types/index.js`、`lib/types/invariant.js` 调用共享的 `clientBundle`，确定打包入口（[packages/client/ui-layout/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-layout/tsdown.config.ts#L3)）
