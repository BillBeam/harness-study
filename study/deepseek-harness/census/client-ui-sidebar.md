---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-sidebar
---

# packages/client/ui-sidebar

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 12 个文件、49 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-sidebar/README.md

侧栏外壳包的说明文档，带 description/kind 前置元数据，描述品牌行、新建会话、折叠轨、滚动条与底部座位的行为。

- 无运行期机制

### packages/client/ui-sidebar/package.json

包清单，声明该插件的入口产物、浏览器半侧注入声明与发布文件白名单。

- `exports` 把 `.`、`./invariant`、`./client` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 及各自的类型文件，并开放 `./src/*` 原样路径（[packages/client/ui-sidebar/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/package.json#L16-L31)）
- `dsh.client.inject` 列出浏览器半侧加载前必须就位的六个包，`platform` 固定为 `web`（[packages/client/ui-sidebar/package.json:32-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/package.json#L32-L44)）
- `dependencies` 只有 `clsx`，与 `peerDependencies` 一起构成打包预设判定"保持为 import"的生产依赖集合（[packages/client/ui-sidebar/package.json:50-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/package.json#L50-L62)）
- `files` 把发布内容限定为三个 js 产物加 `lib/types` 下的声明文件（[packages/client/ui-sidebar/package.json:78-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/package.json#L78-L83)）

### packages/client/ui-sidebar/src/client/SidebarRoot.module.css

侧栏根组件的 CSS Module，被 SidebarRoot.tsx 以类名开关的形式驱动。

- `.root` 把 `--dsh-scrollbar-thumb` 与 `--dsh-scrollbar-thumb-hover` 绑定到 l2 滚动条令牌（[packages/client/ui-sidebar/src/client/SidebarRoot.module.css:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.module.css#L21-L22)）
- `.root.quietBars` 把上述两个变量改写为 `transparent`，从而使嵌套在该列内的所有滚动区域不绘制滑块，且不改变已保留的滚动条槽位（[packages/client/ui-sidebar/src/client/SidebarRoot.module.css:40-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.module.css#L40-L43)）
- `.fading > *` 让直接子节点在 150ms 内透明度归零（[packages/client/ui-sidebar/src/client/SidebarRoot.module.css:47-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.module.css#L47-L50)）
- `.wide` 挂 200ms 的 `wide-in` 淡入关键帧（[packages/client/ui-sidebar/src/client/SidebarRoot.module.css:53-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.module.css#L53-L59)）
- `.railIn` 下的图标按钮、新建会话按钮与区域座位跑 150ms 的 `rail-in`（透明度 0 加 49px 水平位移），底部区域只跑 `rail-fade-in`（[packages/client/ui-sidebar/src/client/SidebarRoot.module.css:66-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.module.css#L66-L85)）
- 折叠态下切换按钮内的面板图标默认 `display: none`，悬停时显示面板图标并隐藏品牌标记（[packages/client/ui-sidebar/src/client/SidebarRoot.module.css:206-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.module.css#L206-L216)）
- `.collapsed .newSessionLabel` 把标签最大宽度压到 0（[packages/client/ui-sidebar/src/client/SidebarRoot.module.css:294-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.module.css#L294-L296)）
- `prefers-reduced-motion: reduce` 时把上述淡入、淡出与入轨动画全部置为 `none`（[packages/client/ui-sidebar/src/client/SidebarRoot.module.css:348-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.module.css#L348-L358)）

### packages/client/ui-sidebar/src/client/SidebarRoot.tsx

侧栏列的根组件，由本包的槽注册装入布局所有的 `sidebar` 槽，负责折叠状态机、品牌行、新建会话按钮、指针驱动的滚动条开关以及三个子槽的渲染。

- 常量 `COLLAPSE_SETTLE_MS` 定为 150，决定宽内容卸载的延时（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L27)）
- 常量 `SCROLLBAR_LINGER_MS` 定为 2000，决定指针离开后滚动条继续绘制的时长（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L35)）
- `localBuildVersion` 读 `DSH_CLIENT_VERSION`，缺失时返回 undefined，否则拼上 `DSH_CLIENT_COMMIT_HASH` 与 `DSH_CLIENT_GIT_DIRTY === 'true'` 时的 `-dirty` 后缀（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:38-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L38-L45)）
- `collapsed` 转真时起 150ms 定时器置 `settled`，转假时立即复位并清除定时器（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:62-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L62-L67)）
- `wide` 由 `!collapsed || !settled` 推导，是所有子槽与内部分支共用的宽窄开关（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L68)）
- `lastWideWidth` ref 在未折叠时持续记录传入宽度，供折叠动画期间冻结宽度使用（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:73-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L73-L74)）
- `everWide` ref 记录本次挂载是否曾展开过，冷启动即折叠时不加入轨动画（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:78-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L78-L79)）
- `armLinger` 在无未决定时器时起 2s 定时把 `pointerInside` 置假，`cancelLinger` 清除并复位该定时器（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:85-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L85-L98)）
- 仅当 `pointerInside` 为真时在 document 上挂 `pointermove`，用列元素的 `getBoundingClientRect` 逐次判定指针在框内还是框外并相应取消或启动 linger，卸载时移除监听并取消定时器（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:106-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L106-L122)）
- 根节点类名按 `wide`、`everWide`、`collapsed && wide`、`!pointerInside` 分别挂 `collapsed`/`railIn`/`fading`/`quietBars`（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:129-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L129-L132)）
- 内联 `width` 只在 `wide` 时设置，折叠动画期间取冻结的展开宽度，否则取传入宽度（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L133)）
- 根节点 `onPointerEnter` 取消 linger 并置 `pointerInside` 为真，`onPointerLeave` 启动 linger（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:134-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L134-L138)）
- 展开态渲染品牌按钮，点击调用 `startSession()`（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:143-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L143-L149)）
- 渲染 `sidebar.brand.mark` 子槽并传 `size: 24`，无占位者时回落到 `FishLogo`（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L152)）
- 渲染 `sidebar.brand.name` 子槽，回落内容按 `buildVersion` 是否存在在纯文案与"文案 + 版本徽标"两种结构间二选一（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:155-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L155-L164)）
- 切换按钮的提示文案与 `aria-label` 随 `collapsed` 在打开/收起之间切换，点击调用 `toggleSidebar()`，提示延时 500ms（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:171-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L171-L177)）
- 非宽态时在切换按钮内额外渲染一次 `sidebar.brand.mark` 子槽作为轨内标记（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:178-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L178-L182)）
- 面板图标尺寸按 `wide` 在 16 与 18 之间切换（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L184)）
- 新建会话按钮点击调用 `startSession()`，图标尺寸随 `wide` 取 14 或 18，且提示仅在非宽态启用，宽态额外渲染文字标签（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:190-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L190-L200)）
- 中部区域渲染 `sidebar.workspaces` 子槽，传入 `wide` 与只有在折叠时才调用 `toggleSidebar()` 的 `expandSidebar` 回调（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:204-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L204-L209)）
- 底部区域先渲染 `sidebar.footer.action` 再渲染 `sidebar.settings`，两者都只收到 `wide`（[packages/client/ui-sidebar/src/client/SidebarRoot.tsx:212-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/SidebarRoot.tsx#L212-L219)）

### packages/client/ui-sidebar/src/client/contract/slots.ts

侧栏槽契约文件，通过声明合并把五个子槽写入 SlotMap 并导出各座位的 props 类型，供 SidebarRoot 与注册处引用。

- 无运行期机制

### packages/client/ui-sidebar/src/client/index.ts

侧栏插件的浏览器半侧插件体，注册字典与槽。

- `inject` 声明该插件需要 `slots`、`layout`、`uiWorkspace`、`locale` 四个服务（[packages/client/ui-sidebar/src/client/index.ts:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/index.ts#L34)）
- `apply` 用 `ctx.get('uiWorkspace')` 取出工作区导航面并断言为本地的 `WorkspaceNavigation` 形状（[packages/client/ui-sidebar/src/client/index.ts:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/index.ts#L40)）
- 以 effect 形式把 `sidebar` 命名空间的中英字典注册进 locale 服务（[packages/client/ui-sidebar/src/client/index.ts:41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/index.ts#L41)）
- `injectProps` 工厂把 `startSession` 转发给工作区导航面、把 `toggleSidebar` 转发给 `ctx.layout.toggleSidebar()`（[packages/client/ui-sidebar/src/client/index.ts:43-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/index.ts#L43-L48)）
- 以 effect 形式把 `SidebarRoot` 注册进 `sidebar` 槽，同时声明 locale 命名空间、四个 single 子槽与一个 list 子槽 `sidebar.footer.action`，并挂上注入工厂（[packages/client/ui-sidebar/src/client/index.ts:49-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/client/index.ts#L49-L66)）

### packages/client/ui-sidebar/src/client/locales.ts

`sidebar` 命名空间的中英词条表，被同目录的 index.ts 注册进 locale 服务。

- 无运行期机制

### packages/client/ui-sidebar/src/css-modules.d.ts

CSS Module 的环境声明文件，只为 TypeScript 提供 `*.module.css` 的默认导出类型。

- 无运行期机制

### packages/client/ui-sidebar/src/index.ts

宿主侧加载入口，`apply` 为空函数，不做任何宿主端注册。

- 无运行期机制

### packages/client/ui-sidebar/src/invariant.ts

本包的 invariant companion 插件，向 invariants 服务登记包归属。

- `inject` 声明必须先有 `invariants` 服务，companion 才能加载（[packages/client/ui-sidebar/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/invariant.ts#L15)）
- installer 为空实现，附带说明该包不注册任何运行期不变量（[packages/client/ui-sidebar/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/invariant.ts#L23)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并以 Promise 返回其 disposer（[packages/client/ui-sidebar/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/src/invariant.ts#L30-L31)）

### packages/client/ui-sidebar/tsconfig.json

本包的编译配置，继承客户端基线配置。

- `rootDir` 设为 `src`、`outDir` 设为 `lib/types`，决定了 package.json 与打包配置引用的产物路径（[packages/client/ui-sidebar/tsconfig.json:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/tsconfig.json#L3-L6)）
- `references` 列出九个工作区项目，决定本包编译前必须先产出的依赖项目（[packages/client/ui-sidebar/tsconfig.json:10-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/tsconfig.json#L10-L38)）

### packages/client/ui-sidebar/tsdown.config.ts

本包的打包配置，直接套用客户端插件的共享预设。

- 调用 `clientBundle` 并把 node 半侧入口点名为 `lib/types/index.js` 与 `lib/types/invariant.js`，由预设在此之外追加浏览器侧 `client` 包（[packages/client/ui-sidebar/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-sidebar/tsdown.config.ts#L3)）
