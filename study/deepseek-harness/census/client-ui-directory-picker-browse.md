---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-directory-picker-browse
---

# packages/client/ui-directory-picker-browse

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、98 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-directory-picker-browse/README.md

包说明文档，描述应用内目录浏览对话框及其填充的两个目录流槽位。

- 无运行期机制

### packages/client/ui-directory-picker-browse/package.json

包清单，声明入口导出、客户端半边发现信息、运行期依赖与发布文件列表。

- `exports` 暴露 `.`、`./invariant`、`./client`、`./src/*` 四个入口，`./client` 指向 `lib/client.js`（[packages/client/ui-directory-picker-browse/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/package.json#L16-L31)）
- `dsh.client` 声明浏览器半边需注入的四个包与 `platform: "web"`，供加载器发现客户端半边（[packages/client/ui-directory-picker-browse/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/package.json#L32-L42)）
- `dependencies` 声明运行期依赖 `clsx`（[packages/client/ui-directory-picker-browse/package.json:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/package.json#L48-L50)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与类型声明（[packages/client/ui-directory-picker-browse/package.json:74-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/package.json#L74-L79)）

### packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css

目录浏览对话框的 CSS Module，被 `DirectoryBrowser.tsx` 以 `css` 引入。

- `.dialog` 以 `min(680px, 100%)` 与 `min(500px, calc(100dvh - 32px))` 约束卡片尺寸，短视口下压缩高度（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css:5-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css#L5-L16)）
- `.editorScope` 用 `display: contents`，使承载键盘与失焦监听的包裹层不改变卡片的 flex 子元素结构（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css:21-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css#L21-L23)）
- `.crumbBar` 在编辑区悬停、聚焦或存在路径输入框时点亮边框（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css:65-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css#L65-L69)）
- `.millerRow` 设 `overflow-x: auto`，窄视口下横向滚动而非压缩面板（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css:78-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css#L78-L89)）
- `.crumbTrail` 设 `overflow-x: auto`，深层面包屑在其内部滚动（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css:91-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css#L91-L99)）
- `.column` 设 `min-width: 256px` 与 `overflow-y: auto`，两列均分且各自纵向滚动（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css:203-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css#L203-L214)）
- `.status` 与 `.error` 预留 120px 右内边距，使文本不会绕到加载浮层下方（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css:279-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css#L279-L288)）
- `.loadingFloat` 绝对定位在内容区右下角，加载提示不占据行高（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css:307-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css#L307-L313)）
- `.footerBar` 允许换行，窄视口下确认与取消按钮另起一行而非被裁切（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css:317-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.module.css#L317-L327)）

### packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx

Miller 列式目录选择对话框组件，由 `flow.ts` 适配后填入两个目录流槽位。

- `failureText` 优先取错误对象上的 `rpcError.message`，否则取 `Error.message` 或字符串化结果（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:75-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L75-L82)）
- `SLOW_SCAN_DELAY_MS` 定为 300，扫描超过该时长才显示加载提示（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L91)）
- `PARENT_LEG_WAIT_MS` 定为 200，提交式导航等待父层列取的上限（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L100)）
- `DRAFT_PREVIEW_DEBOUNCE_MS` 定为 250，草稿跟随扫描的防抖窗口（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L109)）
- `displayCrumbs` 在链中找到 home 时以本地化 Home 结点替换并截去其祖先，否则保留完整链（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:116-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L116-L121)）
- `separatorOf` 依据宿主给出的 home 路径是否含反斜杠推断平台分隔符（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L132-L134)）
- `levelDirectory` 把当前层路径补成以分隔符结尾的目录部分（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:137-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L137-L140)）
- `draftDirectory` 取草稿最后一个分隔符之前的目录部分，Windows 下同时接受正反斜杠、POSIX 下只认正斜杠，未键入分隔符时返回 `null`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:157-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L157-L162)）
- `readDraft` 判定该层是否回答草稿的目录部分（自身路径相等，或与上次扫描记录的请求文本及落点一致），据此给出用于前缀过滤的尾串（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:178-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L178-L188)）
- `visibleEntries` 让选中项无条件可见、点号前缀时揭示隐藏项、仅当存在匹配行时才按前缀收窄，否则按显示隐藏开关过滤（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:201-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L201-L218)）
- `LevelColumn` 的行在路径编辑态下于 `mousedown` 阻止默认行为以避免抢走输入框焦点（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L248)）
- 行以 `aria-current` 标记选中态并在点击时调用 `onPick(entry)`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:238-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L238-L260)）
- 组件卸载时递增请求序号与打开代际并 abort 在飞扫描（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:313-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L313-L317)）
- `compositionGuard` 记录输入法组合状态，供两个输入框的回车判定使用（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:318-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L318-L321)）
- `supersede` 同时 abort 在飞请求并递增序号，使旧结算失效（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:324-328](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L324-L328)）
- `restartSlowScanWindow` 清除加载提示并递增扫描窗口计数，为每次列取重新计时（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:331-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L331-L334)）
- `launchListing` 先取代旧请求，再以新的 `AbortController` 发起 `listDirectory` 并重启静默窗口（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:337-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L337-L343)）
- `continueScan` 在不递增序号的前提下发起后续列取，使其随同一次导航一起被取代（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:349-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L349-L354)）
- `viewRef` 每次渲染同步当前两个面板，供防抖回调在触发时读取（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:367-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L367-L368)）
- `land` 发起目标层扫描、置 loading，`announce` 时先清空错误（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:412-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L412-L416)）
- `settle` 结束 loading 后按 `closeEditor` 关闭路径草稿，否则清错误并标记重新聚焦输入框（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:418-426](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L418-L426)）
- 结算前先比对请求序号，序号不符则整个丢弃（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L428)）
- 非关闭编辑器的落地记录本次请求文本与宿主实际返回的层路径到 `scanned`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:433](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L433)）
- `landSingle` 以 `landed` 标志保证单面板落地只提交一次，并清空选中与子层（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:435-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L435-L444)）
- 折叠后的面包屑链不足两级时直接单面板落地（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:446](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L446)）
- 否则取倒数第二个面包屑作为父层并用 `continueScan` 列取（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:447-450](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L447-L450)）
- 在父层条目中以平台相关的大小写折叠比较定位目标条目，找不到则回落单面板（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:453-457](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L453-L457)）
- 定位成功则一次性提交两面板：父层为左列、匹配条目为选中、目标层为右列（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:458-465](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L458-L465)）
- 父层列取失败（含被 abort）时不上报错误，直接单面板落地（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:466-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L466-L470)）
- 仅提交式导航挂一个 `PARENT_LEG_WAIT_MS` 定时器，到点即先行单面板落地（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:474](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L474)）
- 目标层列取失败时结束 loading，`announce` 时把失败文本置为对话框错误（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:475-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L475-L479)）
- `navigate` 以关闭编辑器且上报失败的方式调用 `land`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:483-485](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L483-L485)）
- `select` 立即置选中、清子层并发起该行的子层列取，若路径编辑器开着则关闭草稿并标记把焦点停到选中行（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:506-516](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L506-L516)）
- 子层列取成功后按序号校验再写入右列（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:517-520](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L517-L520)）
- 子层列取失败则显示错误、清空选中回落单面板，并标记把焦点停到编辑区（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:521-532](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L521-L532)）
- `previewDraftLevel` 以不关编辑器、不上报失败的方式调用 `land`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:542-544](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L542-L544)）
- `cancelPathEdit` 取代在飞请求、退出 loading、清空草稿与错误；无子层时清空选中；从未列出过层时重新发起 home 列取（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:547-563](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L547-L563)）
- `advance` 把右列提升为当前层后再对被点条目执行 `select`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:566-571](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L566-L571)）
- 打开对话框时递增打开代际，清空面板、选中、创建态与显示隐藏开关，并发起 home 列取（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:575-585](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L575-L585)）
- 关闭时取代在飞请求，并清空 loading、错误、路径草稿、文件夹草稿、创建错误与两个重聚焦标志（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:586-600](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L586-L600)）
- 提交目标取选中项路径，无选中时回落当前层路径；显示名同理回落到折叠面包屑末端（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:603-605](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L603-L605)）
- `confirmCreate` 在无目标、无草稿或创建中时直接返回，且拒绝全空白名称（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:608-614](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L608-L614)）
- 创建时把原始未裁剪的名称交给宿主，并记录当前打开代际（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:613-617](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L613-L617)）
- 创建成功后按代际校验，重新列取目标层并把新建目录设为选中（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:618-643](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L618-L643)）
- 创建失败按代际校验后把失败文本置为嵌套对话框的错误（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:644-648](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L644-L648)）
- 加载提示副作用在 loading 期间挂 `SLOW_SCAN_DELAY_MS` 定时器，并以扫描窗口计数为依赖使每次列取重新计时（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:655-662](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L655-L662)）
- 草稿防抖副作用以草稿文本为依赖重排定时器，触发时读取 ref 中的当前层，仅当草稿目录部分存在且该层不回答它时发起跟随扫描；`previewSuspended` 为真时跳过（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:673-686](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L673-L686)）
- 前缀过滤串由最后一个面板对草稿的读数决定（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:695-697](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L695-L697)）
- 面包屑尾端变化时把面包屑容器滚到最右（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:700-703](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L700-L703)）
- 子层路径变化时把 Miller 行滚到最右，使新面板在窄视口下可见（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:709-712](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L709-L712)）
- 重聚焦副作用：焦点掉到 `body` 时把焦点还给路径输入框（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:719-725](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L719-L725)）
- 编辑器已关闭时，按标志把焦点停到带 `aria-current` 的选中行，或在焦点确实掉到 `body` 时停到面包屑编辑区（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:726-748](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L726-L748)）
- 关闭状态下组件在所有 hook 之后返回 `null`，不渲染任何内容（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:751](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L751)）
- `parentInert` 在 owner 忙或嵌套创建对话框开启时置真，`draftPending` 在存在路径草稿时置真，二者共同禁用父层控件（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:752-760](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L752-L760)）
- 外层 Modal 的 `onClose` 仅在无创建草稿且不忙时才调用 owner 的取消（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:770](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L770)）
- 卡片级 `onKeyDown` 在编辑态拦下 Escape、阻止其冒泡到 Modal 的文档监听，并按当前焦点决定是否回停编辑区后取消编辑（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:783-794](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L783-L794)）
- 卡片级 `onBlur` 在焦点离开本卡片时取消编辑，但排除窗口整体失焦与焦点仍在卡片内的情形（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:804-816](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L804-L816)）
- 面包屑按钮点击调用 `navigate(crumb.path)` 跳到该层（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:828-835](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L828-L835)）
- 编辑区按钮点击取代在飞列取、退出 loading、复位提交挂起标志，并用选中项或当前层路径加尾分隔符播种草稿；尚无层时播种为空串（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:855-873](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L855-L873)）
- 路径输入 `onChange` 取代在飞导航、退出 loading、释放提交挂起标志并写入新草稿（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:887-897](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L887-L897)）
- 路径输入的回车在非输入法组合态且草稿非空白时，标记重聚焦、置提交挂起标志并以原始草稿文本调用 `navigate`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:902-921](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L902-L921)）
- 左列渲染当前层条目，选中路径来自 `selected`，前缀过滤仅在没有子层时生效（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:928-938](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L928-L938)）
- 有选中且已有子层时渲染分隔线与右列，右列点击走 `advance` 并应用前缀过滤（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:939-950](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L939-L950)）
- 同时处于 loading 与慢扫描态时渲染 `role="status"` 的加载提示（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:952-953](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L952-L953)）
- 任一面板被宿主截断时渲染截断提示（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:960-961](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L960-L961)）
- 存在错误文本时渲染 `role="alert"` 的错误行（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:962](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L962)）
- 新建文件夹按钮在无当前层、加载中、父层惰性或有路径草稿时禁用，点击则开启空的文件夹草稿并清创建错误（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:965-975](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L965-L975)）
- 显示隐藏开关带 `aria-pressed`，在路径编辑态下于 `mousedown` 阻止抢焦点，点击取反本地过滤状态（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:976-992](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L976-L992)）
- 取消按钮直接调用 owner 的 `onClose`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:994](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L994)）
- 打开按钮在无目标、加载中、父层惰性或有未提交草稿时禁用，点击以目标路径调用 `onOpen`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:995-1003](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L995-L1003)）
- 嵌套创建 Modal 以文件夹草稿是否存在决定开合，其 `onClose` 在创建进行中不关闭（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:1007-1013](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L1007-L1013)）
- 文件夹名输入的回车在非组合态时提交创建，Escape 阻止冒泡并在非创建中时关闭嵌套对话框（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:1026-1035](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L1026-L1035)）
- 创建按钮在创建中或名称为空白时禁用，点击调用 `confirmCreate`（[packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx:1040-1046](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/DirectoryBrowser.tsx#L1040-L1046)）

### packages/client/ui-directory-picker-browse/src/client/flow.ts

槽位占位组件，把目录流洞的 owner 约定适配到 `DirectoryBrowser` 上。

- 把 owner 的 `onPicked` 接到对话框的 `onOpen`、`onCancel` 接到 `onClose`，并透传 `open`、`busy`、两个宿主调用与 `t`（[packages/client/ui-directory-picker-browse/src/client/flow.ts:33-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/flow.ts#L33-L43)）

### packages/client/ui-directory-picker-browse/src/client/index.ts

浏览器半边插件入口，注册对话框字典并把浏览占位填入两个目录流槽位。

- `inject` 声明依赖 `slots`、`uiWorkspace` 与 `locale` 三个服务（[packages/client/ui-directory-picker-browse/src/client/index.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/index.ts#L23)）
- 在一个 `ctx.effect` 内注册中英两份 `directory-browser` 字典，任一注册抛错则逆序回滚已注册的部分再抛出（[packages/client/ui-directory-picker-browse/src/client/index.ts:32-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/index.ts#L32-L76)）
- `injected` 把 `ctx.uiWorkspace.listDirectory` 与 `createDirectory` 以及绑定到本命名空间的 `t` 交给占位组件（[packages/client/ui-directory-picker-browse/src/client/index.ts:78-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/index.ts#L78-L82)）
- 以嵌套的 `slots.inject` 把 `conversation.hero.workspace.directoryFlow` 与 `sidebar.workspaces.directoryFlow` 两个洞的注册合成一次事务性生效（[packages/client/ui-directory-picker-browse/src/client/index.ts:86-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/client/index.ts#L86-L94)）

### packages/client/ui-directory-picker-browse/src/css-modules.d.ts

CSS Module 的 TypeScript 环境声明。

- 无运行期机制

### packages/client/ui-directory-picker-browse/src/index.ts

宿主半边插件入口。

- 导出空的 `apply`，插件在宿主侧被装载后不注册任何宿主行为（[packages/client/ui-directory-picker-browse/src/index.ts:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/index.ts#L10)）

### packages/client/ui-directory-picker-browse/src/invariant.ts

包级不变量伴生插件，向不变量服务登记包名。

- `apply` 调用 `ctx.invariants.register` 登记包名与安装器并返回其 disposer（[packages/client/ui-directory-picker-browse/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/invariant.ts#L29-L30)）
- 安装器为空函数，不注册任何运行期检查（[packages/client/ui-directory-picker-browse/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/src/invariant.ts#L22)）

### packages/client/ui-directory-picker-browse/tsconfig.json

包的 TypeScript 编译配置与工程引用。

- 无运行期机制

### packages/client/ui-directory-picker-browse/tsdown.config.ts

打包配置，被 `pnpm bundle` 使用。

- 声明该包的打包入口为 `lib/types/index.js` 与 `lib/types/invariant.js`（[packages/client/ui-directory-picker-browse/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-browse/tsdown.config.ts#L3)）
