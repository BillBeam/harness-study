---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-input-trigger
---

# packages/client/ui-input-trigger

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 19 个文件、111 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-input-trigger/README.md

该包的说明文档，描述 `/` 与 `@` 的检测、候选菜单、选取路由以及源注册方式。

- 无运行期机制

### packages/client/ui-input-trigger/package.json

该包的清单，声明入口映射、浏览器半的加载声明、运行期依赖与发布内容。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-input-trigger/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./client` 三个子路径分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，并额外开放 `./src/*` 与 `./package.json`（[packages/client/ui-input-trigger/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/package.json#L16-L31)）
- `dsh.client` 声明浏览器半所需注入的四个包并把 platform 定为 `web`（[packages/client/ui-input-trigger/package.json:32-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/package.json#L32-L42)）
- `dependencies` 声明运行期依赖 `clsx`（[packages/client/ui-input-trigger/package.json:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/package.json#L48-L50)）
- `files` 把发布内容限定为三个 js 入口与 `lib/types` 下的声明文件（[packages/client/ui-input-trigger/package.json:79-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/package.json#L79-L84)）

### packages/client/ui-input-trigger/src/client/MenuView.module.css

候选菜单的 CSS Module，定义悬浮面板、滚动视口、候选行、骨架行与面包屑的外观。

- 无运行期机制

### packages/client/ui-input-trigger/src/client/MenuView.tsx

候选菜单组件，订阅控制器的菜单与面包屑两个快照存储并把指针操作路由回控制器。

- `optionId` 由源名与下标拼出候选行的 DOM id，供 `aria-activedescendant` 指向（[packages/client/ui-input-trigger/src/client/MenuView.tsx:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L26-L28)）
- 用 `useSyncExternalStore` 分别订阅菜单状态与面包屑两个存储（[packages/client/ui-input-trigger/src/client/MenuView.tsx:36-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L36-L43)）
- `useAnchoredMaxHeight` 把 320 的高度上限夹到编辑器上方的可用空间，并在每次状态更新时重测（[packages/client/ui-input-trigger/src/client/MenuView.tsx:48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L48)）
- 高亮变化时把对应候选行滚进视野（[packages/client/ui-input-trigger/src/client/MenuView.tsx:52-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L52-L56)）
- 菜单打开时在 document 捕获阶段挂 pointerdown 监听，落点既不在菜单内也不在编辑器卡片内时调 `onDismiss`，并在关闭或卸载时摘掉监听（[packages/client/ui-input-trigger/src/client/MenuView.tsx:59-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L59-L70)）
- 菜单未打开时整体返回 null（[packages/client/ui-input-trigger/src/client/MenuView.tsx:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L71)）
- 为发布了面包屑的源渲染 nav，`current` 的 crumb 置为禁用并带 `aria-current`，其余 crumb 以 mousedown 阻止默认后调 `onCrumb`（[packages/client/ui-input-trigger/src/client/MenuView.tsx:76-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L76-L100)）
- `listbox` 角色挂在滚动视口上，`aria-activedescendant` 指向当前高亮行的 id（[packages/client/ui-input-trigger/src/client/MenuView.tsx:101-106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L101-L106)）
- 已 ready 且候选为空的分组整组不渲染（[packages/client/ui-input-trigger/src/client/MenuView.tsx:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L107)）
- 分组标题在 `showGroupTitle` 为 false 或候选自带 section 时不渲染，标题文案按源名查词典（[packages/client/ui-input-trigger/src/client/MenuView.tsx:114-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L114-L116)）
- pending 分组渲染两行骨架并带 `role="status"`（[packages/client/ui-input-trigger/src/client/MenuView.tsx:117-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L117-L123)）
- 相邻候选的 `section` 变化时插入一行 section 标题（[packages/client/ui-input-trigger/src/client/MenuView.tsx:128-130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L128-L130)）
- 候选行以 mousedown 并阻止默认来调 `onPick`，使焦点留在输入区（[packages/client/ui-input-trigger/src/client/MenuView.tsx:140-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L140-L143)）
- 高亮迁移用 mousemove 而非 mouseenter，且已是高亮行时不再挂该监听（[packages/client/ui-input-trigger/src/client/MenuView.tsx:147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L147)）
- `drill` 为 true 的行额外渲染尾部提示与 chevron，chevron 的 mousedown 阻止默认与冒泡后以 `'drill'` 调 `onPick`（[packages/client/ui-input-trigger/src/client/MenuView.tsx:156-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/MenuView.tsx#L156-L177)）

### packages/client/ui-input-trigger/src/client/contract.ts

`ctx.inputTriggers` 服务面的类型声明：源注册与按会话作用域解析控制器两个方法。

- 无运行期机制

### packages/client/ui-input-trigger/src/client/controller.ts

每会话一份的触发管线控制器，持有命中、菜单、面包屑、名册与候选取数生命周期，并把选取结果派发成作用域内的输入变更事件。

- 菜单状态存储以 `MENU_CLOSED` 为初值（[packages/client/ui-input-trigger/src/client/controller.ts:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L47)）
- `launcher` 存储记录由程序化入口打开的源名，非程序化打开时为 null（[packages/client/ui-input-trigger/src/client/controller.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L53)）
- `headers` 存储按源名保存各源为当前菜单发布的面包屑（[packages/client/ui-input-trigger/src/client/controller.ts:60-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L60-L61)）
- `lexicon` 存储按触发字符聚合各源的热名册（[packages/client/ui-input-trigger/src/client/controller.ts:72-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L72-L73)）
- 私有 `hit` 保存权威命中，是 span 比较置换素材的唯一来源，菜单关闭后仍存活（[packages/client/ui-input-trigger/src/client/controller.ts:75-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L75-L76)）
- 构造时对全部已注册源调用 `warm`、接上 lexicon 订阅，并做一次名册聚合（[packages/client/ui-input-trigger/src/client/controller.ts:84-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L84-L94)）
- `track` 在已析构时直接返回，并在每次进入时清掉 launcher 记号（[packages/client/ui-input-trigger/src/client/controller.ts:104-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L104-L107)）
- `track` 在检测不出触发时清空命中、中止取数并关闭菜单（[packages/client/ui-input-trigger/src/client/controller.ts:108-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L108-L114)）
- `track` 把调用方给的草稿修订号打进命中的 span，供选取时比较置换（[packages/client/ui-input-trigger/src/client/controller.ts:115](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L115)）
- `track` 在触发字符、查询、引号态与 span 起止都与上次相同且非程序化打开时，只更新命中并直接返回，不重取候选（[packages/client/ui-input-trigger/src/client/controller.ts:116-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L116-L122)）
- `track` 在该触发字符没有任何注册源时中止取数并关闭菜单（[packages/client/ui-input-trigger/src/client/controller.ts:123-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L123-L128)）
- `track` 在程序化打开、菜单原本关闭或触发字符改变时重新铺一遍分组名册（[packages/client/ui-input-trigger/src/client/controller.ts:129-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L129-L131)）
- `track` 末尾派发 hit、刷新面包屑并发起候选取数（[packages/client/ui-input-trigger/src/client/controller.ts:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L132-L134)）
- `toggleSource` 在同一源已由 launcher 打开且菜单在开时改为关闭，找不到该源也关闭（[packages/client/ui-input-trigger/src/client/controller.ts:145-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L145-L156)）
- `toggleSource` 用合成命中打开只含一个源的菜单，并走与打字相同的 hit、面包屑、取数三步（[packages/client/ui-input-trigger/src/client/controller.ts:157-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L157-L162)）
- `pick` 在已析构、菜单关闭、无命中、分组未 ready、候选或源不存在时都直接返回，否则交给 `settle`（[packages/client/ui-input-trigger/src/client/controller.ts:172-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L172-L182)）
- `pickCrumb` 拒绝 `current` 的 crumb，其余把 crumb 投影成候选并以 `'drill'` 走同一条 `settle`（[packages/client/ui-input-trigger/src/client/controller.ts:191-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L191-L199)）
- `hover` 把指针悬停派发成 hover 事件，与键盘共用同一个高亮（[packages/client/ui-input-trigger/src/client/controller.ts:208-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L208-L211)）
- `arbitrate` 在输入法组字中或已析构时一律放行，菜单未开也放行（[packages/client/ui-input-trigger/src/client/controller.ts:219-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L219-L222)）
- `arbitrate` 对上下键移动高亮并声明消费，对 Escape 中止取数并关闭菜单（[packages/client/ui-input-trigger/src/client/controller.ts:223-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L223-L236)）
- `arbitrate` 对 Enter 在无高亮时放行，否则选取高亮项并回报 `pick-highlighted`（[packages/client/ui-input-trigger/src/client/controller.ts:237-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L237-L241)）
- `arbitrate` 对 Tab 仅在高亮行的 `drill` 为 true 时以 drill 选取并消费，否则放行以保留原生焦点行为（[packages/client/ui-input-trigger/src/client/controller.ts:242-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L242-L253)）
- `onSpace` 仅在命中位于草稿开头时生效，按注册顺序轮询各源的 `matchSpace`，首个非 undefined 的答案胜出，`'handled'` 直接回 true，其余交给 `execute`（[packages/client/ui-input-trigger/src/client/controller.ts:263-276](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L263-L276)）
- `serializeReference` 在找不到源或源没有 codec 时以 rejected Promise 拒绝，不退化成明文（[packages/client/ui-input-trigger/src/client/controller.ts:288-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L288-L294)）
- `adjudicate` 每轮先查中止信号并抛出，只轮询实现了 `matchEnter` 且触发字符是该行前缀的源，首个非 undefined 的结果胜出，全都不认则返回 undefined（[packages/client/ui-input-trigger/src/client/controller.ts:307-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L307-L318)）
- `sourceRemoved` 在菜单正开着该触发字符时派发 source-failed 摘掉该组，并解掉其 lexicon 订阅后重新聚合（[packages/client/ui-input-trigger/src/client/controller.ts:324-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L324-L332)）
- `sourceAdded` 对作用域出生后才注册的源补做 warm、订阅与名册聚合（[packages/client/ui-input-trigger/src/client/controller.ts:341-346](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L341-L346)）
- `dismiss` 中止取数并关闭菜单（[packages/client/ui-input-trigger/src/client/controller.ts:349-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L349-L353)）
- `dispose` 置析构标记、中止取数、关闭菜单、清空命中并解掉所有 lexicon 订阅（[packages/client/ui-input-trigger/src/client/controller.ts:356-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L356-L363)）
- `project` 交给源的会话投影只含 `sessionId`（[packages/client/ui-input-trigger/src/client/controller.ts:366-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L366-L368)）
- `execute` 把 claim、text、insert 三类结果分别经 `actx.bail` 派发成 `slash/input-begin-command`、`slash/input-insert-text`、`slash/input-insert-reference`，并以返回值是否为 true 表示输入端是否真的应用（[packages/client/ui-input-trigger/src/client/controller.ts:371-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L371-L385)）
- `refreshLexicon` 轮询各源的 `lexicon`，抛错的源记录到 console 后跳过，undefined 跳过，同一触发字符下按注册顺序拼接（[packages/client/ui-input-trigger/src/client/controller.ts:388-408](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L388-L408)）
- `watchLexicon` 只为同时实现 `lexicon` 与 `subscribeLexicon` 的源订阅；收到通知时先重聚名册，再在一个微任务后（命中未变且菜单仍开）重取候选（[packages/client/ui-input-trigger/src/client/controller.ts:411-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L411-L424)）
- `fetchCandidates` 先中止上一次取数、新建 AbortController 并锁定当前 generation，再对每个源发起 `candidates` 并带上查询、引号态、位置、drilled 与信号（[packages/client/ui-input-trigger/src/client/controller.ts:427-441](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L427-L441)）
- 候选结果与失败都先检查信号是否已中止再入 reducer，失败额外记录到 console 并派发 source-failed（[packages/client/ui-input-trigger/src/client/controller.ts:442-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L442-L453)）
- `stopFetch` 中止并清掉当前的取数控制器（[packages/client/ui-input-trigger/src/client/controller.ts:456-459](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L456-L459)）
- `settle` 把候选连同会话投影、位置、`via: 'menu'`、动作与 span 交给源的 `onPick`，随后中止取数并关闭菜单，再执行结果（[packages/client/ui-input-trigger/src/client/controller.ts:472-488](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L472-L488)）
- `settle` 在关闭之后才置 `drilled`，且仅当动作是 drill 且改写确实被应用时才置位（[packages/client/ui-input-trigger/src/client/controller.ts:489-494](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L489-L494)）
- `refreshHeaders` 轮询命中名册里实现了 `header` 的源，抛错的源记录到 console 后跳过，undefined 或空数组不入表（[packages/client/ui-input-trigger/src/client/controller.ts:498-517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L498-L517)）
- `setHeaders` 在旧表与新表都为空时不写存储，避免多余通知（[packages/client/ui-input-trigger/src/client/controller.ts:519-522](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L519-L522)）
- `reduce` 只在 reducer 返回新引用时写菜单存储，且在结果为关闭态时一并清掉 launcher、`drilled` 与面包屑（[packages/client/ui-input-trigger/src/client/controller.ts:528-536](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/controller.ts#L528-L536)）

### packages/client/ui-input-trigger/src/client/index.ts

该包浏览器半的插件体，挂载触发服务、注册菜单词典，并把 MenuView 接进会话输入覆盖层槽。

- `inject` 声明插件启动所需的 sessions 与 locale（[packages/client/ui-input-trigger/src/client/index.ts:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/index.ts#L52)）
- `apply` 以 `ctx.plugin` 挂载 `InputTriggerService`（[packages/client/ui-input-trigger/src/client/index.ts:60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/index.ts#L60)）
- 以 effect 注册 `slash.menu` 命名空间的中英词典（[packages/client/ui-input-trigger/src/client/index.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/index.ts#L61)）
- 在 slots、inputTriggers、sessions 三者齐备后才把 `MenuView` 注册进 `conversation.input.overlay` 槽，id 为 `slash-menu`、order 为 0（[packages/client/ui-input-trigger/src/client/index.ts:62-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/index.ts#L62-L69)）
- 槽的注入回调按 sessionId 解析会话作用域，解析不出时抛错，否则取该作用域的控制器并把菜单存储、面包屑存储与选取、面包屑、悬停、关闭四个回调交给视图（[packages/client/ui-input-trigger/src/client/index.ts:70-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/index.ts#L70-L84)）

### packages/client/ui-input-trigger/src/client/locales.ts

`slash.menu` 命名空间的中英词典与由中文键集导出的键联合类型。

- 无运行期机制

### packages/client/ui-input-trigger/src/client/service.ts

`ctx.inputTriggers` 服务本体，持有源注册表与每会话控制器映射，并把名册变动转发给活着的控制器。

- `static inject` 声明服务依赖 sessions（[packages/client/ui-input-trigger/src/client/service.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L31)）
- 全部可变状态收在一个 `live` 持有者里：源数组与按会话 id 的控制器映射（[packages/client/ui-input-trigger/src/client/service.ts:22-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L22-L33)）
- 构造时以 `inputTriggers` 之名把自己注册为服务（[packages/client/ui-input-trigger/src/client/service.ts:38-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L38-L40)）
- `registerSource` 对已存在的（触发字符, 名字）组合抛错（[packages/client/ui-input-trigger/src/client/service.ts:50-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L50-L53)）
- `registerSource` 把新源追加进数组并逐个通知活控制器 `sourceAdded`，回调抛错被 console 记录后吞掉以保证注册仍然成立、其余控制器仍被通知（[packages/client/ui-input-trigger/src/client/service.ts:54-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L54-L64)）
- 返回的 disposer 把源从数组摘掉并通知每个控制器 `sourceRemoved`，重复调用无效（[packages/client/ui-input-trigger/src/client/service.ts:65-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L65-L70)）
- `sessionOf` 由 `scopeOf` 求会话 id，求不到就抛错（[packages/client/ui-input-trigger/src/client/service.ts:81-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L81-L84)）
- `sessionOf` 命中映射时复用既有控制器，否则新建一个并把名册视图交给它：按触发字符过滤后依 `order` 升序排，`all` 返回完整注册顺序（[packages/client/ui-input-trigger/src/client/service.ts:85-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L85-L95)）
- 新控制器存入映射，并用会话作用域的 effect 登记析构：作用域消亡时调 `dispose` 并删掉映射项（[packages/client/ui-input-trigger/src/client/service.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L96-L101)）
- `sessions()` 用 `ctx.get('sessions')` 读全局服务表，缺失时抛错（[packages/client/ui-input-trigger/src/client/service.ts:104-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/client/service.ts#L104-L108)）

### packages/client/ui-input-trigger/src/client/slots.ts

菜单视图注入面的类型声明：两个快照存储与四个指针回调。

- 无运行期机制

### packages/client/ui-input-trigger/src/core/contract.ts

纯核的类型声明：命中、菜单状态、菜单事件、reducer 与精确匹配的签名。

- 无运行期机制

### packages/client/ui-input-trigger/src/core/detect.ts

触发检测纯核，从光标向左扫描判定 `/` 与 `@` 是否构成一个活的触发词。

- 词字符与空白各用一条正则界定（[packages/client/ui-input-trigger/src/core/detect.ts:10-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/detect.ts#L10-L11)）
- `boundaryOk` 允许触发字符出现在草稿开头或空白之后，前一位是词字符则否决（[packages/client/ui-input-trigger/src/core/detect.ts:20-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/detect.ts#L20-L24)）
- `boundaryOk` 对 `/` 再加两条否决：前一位也是 `/`，或前一位是 `:` 且再前一位非空白（[packages/client/ui-input-trigger/src/core/detect.ts:25-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/detect.ts#L25-L29)）
- `detectTrigger` 在 frozen 层级下直接返回 null，两个触发字符都不生效（[packages/client/ui-input-trigger/src/core/detect.ts:49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/detect.ts#L49)）
- 先用共享语法判定 `@` 词，命中则以 `caret - prefix.length` 作起点，并按草稿首个非空白字符是否落在该起点上区分 leading 与 inline（[packages/client/ui-input-trigger/src/core/detect.ts:50-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/detect.ts#L50-L60)）
- `/` 检测从光标前一位反向逐字扫，遇空白立即返回 null，非 `/` 继续，claimed 层级下所有 `/` 都跳过，边界不合法的 `/` 当普通字符继续扫（[packages/client/ui-input-trigger/src/core/detect.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/detect.ts#L61-L66)）
- `/` 命中时查询取该位之后到光标的切片，span 为 `{start: i, end: caret}` 且 `draftRev` 留 0 由调用方改写（[packages/client/ui-input-trigger/src/core/detect.ts:67-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/detect.ts#L67-L73)）

### packages/client/ui-input-trigger/src/core/menu.ts

菜单归约纯核，含关闭常量、分组铺设、reducer 与精确匹配。

- `MENU_CLOSED` 给出 generation 为 0 的关闭静止态（[packages/client/ui-input-trigger/src/core/menu.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L17)）
- `seedGroups` 按传入顺序把每个源铺成 pending 空组并清掉高亮，仅在 `showGroupTitle` 为 false 时把该字段写进组（[packages/client/ui-input-trigger/src/core/menu.ts:27-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L27-L41)）
- `closed` 关闭时保留 generation 以便在途结果仍可被判为过期，已是静止态则返回同一引用（[packages/client/ui-input-trigger/src/core/menu.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L44-L47)）
- `firstHighlight` 取第一个非空 ready 组的首项作为默认高亮（[packages/client/ui-input-trigger/src/core/menu.ts:50-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L50-L55)）
- `validHighlight` 校验高亮仍指向一个 ready 组内的有效下标，否则判为 null（[packages/client/ui-input-trigger/src/core/menu.ts:58-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L58-L62)）
- `positions` 按分组顺序把 ready 项摊平成可循环的位置序列（[packages/client/ui-input-trigger/src/core/menu.ts:65-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L65-L72)）
- `allReadyEmpty` 判定所有组都已 ready 且都没有候选，作为自动关闭条件（[packages/client/ui-input-trigger/src/core/menu.ts:75-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L75-L76)）
- `hit` 事件在命中为 null 时关闭，否则 generation 加一并把现有各组全部重置为 pending、清空高亮（[packages/client/ui-input-trigger/src/core/menu.ts:93-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L93-L102)）
- `source-settled` 在菜单未开、generation 不符或该源不在组名单时原样返回；落位后若所有组都 ready 且为空则关闭；高亮沿用有效值否则落到首项（[packages/client/ui-input-trigger/src/core/menu.ts:103-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L103-L113)）
- `source-failed` 走同样的门后把该组整个过滤掉，组数归零或全空则关闭，并同样重算高亮（[packages/client/ui-input-trigger/src/core/menu.ts:114-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L114-L121)）
- `move` 在摊平位置上按方向环绕移动高亮，无位置或结果未变时返回同一引用（[packages/client/ui-input-trigger/src/core/menu.ts:122-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L122-L134)）
- `hover` 只接受落在 ready 项上的目标，已是该项时返回同一引用（[packages/client/ui-input-trigger/src/core/menu.ts:135-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L135-L142)）
- `close` 事件走 `closed` 丢掉命中、分组与高亮（[packages/client/ui-input-trigger/src/core/menu.ts:143-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L143-L144)）
- `exactMatch` 只在指定源的 ready 组里按名字精确取候选，组缺失或未 ready 时返回 null（[packages/client/ui-input-trigger/src/core/menu.ts:157-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/core/menu.ts#L157-L161)）

### packages/client/ui-input-trigger/src/css-modules.d.ts

CSS Module 的环境类型声明。

- 无运行期机制

### packages/client/ui-input-trigger/src/index.ts

该包 host 半的插件体。

- 导出空的 `apply`，使该插件能出现在 host 侧的装载清单中而不注册任何 host 行为（[packages/client/ui-input-trigger/src/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/index.ts#L9)）

### packages/client/ui-input-trigger/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名。

- 导出 `name` 与 `inject`，声明伴生插件名及其依赖的 invariants 服务（[packages/client/ui-input-trigger/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/invariant.ts#L13-L15)）
- `install` 为空安装器，不挂任何运行期检查（[packages/client/ui-input-trigger/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/invariant.ts#L23)）
- `apply` 向 `ctx.invariants` 注册包名与空安装器，并把注册返回的 disposer 以 Promise 交回（[packages/client/ui-input-trigger/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/src/invariant.ts#L30-L31)）

### packages/client/ui-input-trigger/src/types.ts

触发源契约的类型声明文件，含会话投影、候选、面包屑、各类请求与源接口，模块自述只含类型、无运行期代码。

- 无运行期机制

### packages/client/ui-input-trigger/tsconfig.json

该包的 TypeScript 编译配置与工作区引用清单。

- 无运行期机制

### packages/client/ui-input-trigger/tsdown.config.ts

该包的打包配置。

- 以 `clientBundle` 声明打包入口为 `lib/types/index.js` 与 `lib/types/invariant.js`，决定产出哪些可加载的运行期文件（[packages/client/ui-input-trigger/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-input-trigger/tsdown.config.ts#L3)）
