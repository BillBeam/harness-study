---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-theme
---

# packages/client/ui-theme

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 22 个文件、101 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-theme/README.md

主题包的说明文档，描述外观偏好、内容字号设置、样式表清单与持久化边界。

- 无运行期机制

### packages/client/ui-theme/package.json

包清单，声明入口映射、客户端插件元数据与发布文件集。

- `exports` 把 `.`、`./invariant`、`./client`、`./src/*`、`./package.json` 五个子路径分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与源码目录，决定导入方拿到哪个模块（[packages/client/ui-theme/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/package.json#L16-L31)）
- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-theme/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/package.json#L14-L15)）
- `dsh.client` 声明该客户端插件的注入依赖列表、`platform: web` 与 `immediately: true`，决定它在客户端插件树中何时激活以及依赖哪些服务（[packages/client/ui-theme/package.json:32-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/package.json#L32-L44)）
- `files` 把发布内容限定为三个 js 入口、`lib/styles` 与类型声明（[packages/client/ui-theme/package.json:74-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/package.json#L74-L80)）

### packages/client/ui-theme/src/boot-theme.ts

Host 侧模块，生成插件加载前在浏览器同步执行的内联脚本，被 `src/index.ts` 的 index 注入监听器调用。

- `bootThemeScript` 把当前偏好与字号以 JSON 字面量内联进脚本文本（[packages/client/ui-theme/src/boot-theme.ts:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/boot-theme.ts#L12-L14)）
- 偏好为 `system` 时脚本查询 `prefers-color-scheme: dark` 媒体查询来定夺深浅（[packages/client/ui-theme/src/boot-theme.ts:15-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/boot-theme.ts#L15-L18)）
- 脚本写 `documentElement.style.colorScheme` 为 `dark` 或 `light`（[packages/client/ui-theme/src/boot-theme.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/boot-theme.ts#L19)）
- 脚本按深浅切换 `body` 上的 `data-ds-dark-theme` 属性（[packages/client/ui-theme/src/boot-theme.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/boot-theme.ts#L20)）
- 脚本把 `--dsh-content-font-size` 以 px 值写到 `body` 的内联样式上（[packages/client/ui-theme/src/boot-theme.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/boot-theme.ts#L21)）
- `bootThemeInjection` 把脚本包装成 `kind: 'script'`、`placement: 'body'` 的注入行，并在未传值时回落到默认偏好与默认字号（[packages/client/ui-theme/src/boot-theme.ts:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/boot-theme.ts#L32-L37)）

### packages/client/ui-theme/src/client/AppearanceRow.module.css

外观行组件的 CSS Module，规定行容器、标题与三个方块按钮的排布与配色。

- 无运行期机制

### packages/client/ui-theme/src/client/AppearanceRow.tsx

注册进设置页 General 区段的外观偏好行组件，由 `src/client/index.ts` 挂到槽位上。

- `CUBES` 常量固定三个可选偏好 `light`/`dark`/`system` 及其图标与文案键，决定这一行渲染出哪几个选项（[packages/client/ui-theme/src/client/AppearanceRow.tsx:31-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/AppearanceRow.tsx#L31-L35)）
- 组件从 store 读取 `preference` 作为选中态来源（[packages/client/ui-theme/src/client/AppearanceRow.tsx:43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/AppearanceRow.tsx#L43)）
- 每个按钮按 `preference === id` 决定 `aria-pressed` 与选中样式类（[packages/client/ui-theme/src/client/AppearanceRow.tsx:52-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/AppearanceRow.tsx#L52-L53)）
- 点击按钮调用注入的 `setTheme(id)`（[packages/client/ui-theme/src/client/AppearanceRow.tsx:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/AppearanceRow.tsx#L54)）

### packages/client/ui-theme/src/client/FontSizeRow.module.css

字号行组件的 CSS Module，规定行容器、步进药丸、箭头列与单位标签的几何与配色。

- 无运行期机制

### packages/client/ui-theme/src/client/FontSizeRow.tsx

注册进设置页 General 区段的内容字号行组件，由 `src/client/index.ts` 挂到槽位上。

- 组件从 store 读取 `fontSize` 作为显示值来源（[packages/client/ui-theme/src/client/FontSizeRow.tsx:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/FontSizeRow.tsx#L36)）
- 药丸中央渲染的是该持久值本身，而非点击回声（[packages/client/ui-theme/src/client/FontSizeRow.tsx:45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/FontSizeRow.tsx#L45)）
- 增大按钮在 `fontSize >= FONT_SIZE_MAX` 时置为 disabled，点击调用 `setFontSize(fontSize + 1)`（[packages/client/ui-theme/src/client/FontSizeRow.tsx:47-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/FontSizeRow.tsx#L47-L55)）
- 减小按钮在 `fontSize <= FONT_SIZE_MIN` 时置为 disabled，点击调用 `setFontSize(fontSize - 1)`（[packages/client/ui-theme/src/client/FontSizeRow.tsx:56-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/FontSizeRow.tsx#L56-L64)）

### packages/client/ui-theme/src/client/index.ts

客户端插件主体：定义 `ThemeRuntime` 主题注册表与偏好持有者，并把两个设置行注册进 General 区段的条目槽位。

- `SETTINGS_NS` 固定这两行文案所属的 locale 命名空间为 `settings.theme`（[packages/client/ui-theme/src/client/index.ts:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L39)）
- 声明合并把 `ctx.theme` 服务与 `theme/change` 事件挂进上下文与事件表（[packages/client/ui-theme/src/client/index.ts:111-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L111-L124)）
- `BUILTIN_THEMES` 冻结内置的 `light`/`dark` 两个空 token 定义作为注册表初始内容（[packages/client/ui-theme/src/client/index.ts:126-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L126-L129)）
- `BUILTIN_INSPECT_TOKENS` 固定一份可被外部检视的 token 目录（名称、说明、值类型、是否需要双模式）（[packages/client/ui-theme/src/client/index.ts:131-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L131-L145)）
- 实例的初始字号取自 `bootstrapFontSize()` 而非 schema 默认值（[packages/client/ui-theme/src/client/index.ts:163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L163)）
- 覆盖层以 source 为键存进 Map，并用单调递增的 `overrideSeq` 记录叠放次序（[packages/client/ui-theme/src/client/index.ts:167-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L167-L169)）
- 构造函数在 `matchMedia` 存在时建立 `prefers-color-scheme: dark` 查询，否则置 undefined（[packages/client/ui-theme/src/client/index.ts:181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L181)）
- 构造函数用 `ctx.effect` 挂媒体查询 change 监听：仅当偏好为 `system` 时重新发布快照，并在 dispose 时摘除监听（[packages/client/ui-theme/src/client/index.ts:183-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L183-L193)）
- 构造函数用 `ctx.effect` 订阅设置作用域，每次推送触发 `adopt()`，并立即执行一次 `adopt()`（[packages/client/ui-theme/src/client/index.ts:194-195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L194-L195)）
- `getTheme()` 返回当前不可变快照引用（[packages/client/ui-theme/src/client/index.ts:202-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L202-L204)）
- `exportInspectTokens()` 把内置目录、已注册主题的 token 名与覆盖层的 token 名并成一张表，未知名走 `dynamicToken` 生成条目，最后按名排序输出副本（[packages/client/ui-theme/src/client/index.ts:210-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L210-L223)）
- `setTheme(id)` 对既非 `system` 又未注册的 id 抛错（[packages/client/ui-theme/src/client/index.ts:232-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L232-L234)）
- `setTheme(id)` 在值未变时直接返回，不写盘也不发事件（[packages/client/ui-theme/src/client/index.ts:235](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L235)）
- `setTheme(id)` 仅对内置偏好经设置作用域写入持久值，然后发布快照（[packages/client/ui-theme/src/client/index.ts:236-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L236-L238)）
- `setFontSize(px)` 对非整数或超出 `FONT_SIZE_MIN..FONT_SIZE_MAX` 的值抛错（[packages/client/ui-theme/src/client/index.ts:248-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L248-L250)）
- `setFontSize(px)` 值未变时直接返回，否则写入设置作用域并发布快照（[packages/client/ui-theme/src/client/index.ts:251-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L251-L254)）
- `adopt()` 读设置作用域快照：值为 undefined 或与当前偏好、字号都相同时不动，否则整体采纳并发布，且不回写（[packages/client/ui-theme/src/client/index.ts:258-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L258-L265)）
- `register()` 拒绝 id 为 `system`、拒绝重复 id，追加后发布快照（[packages/client/ui-theme/src/client/index.ts:276-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L276-L281)）
- `register()` 返回的 disposer 移除该主题，并在被移除者正是当前偏好时把偏好复位为默认，然后发布（[packages/client/ui-theme/src/client/index.ts:282-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L282-L289)）
- `overrideTokens(source, tokens)` 校验后按 source 存一层（同 source 再调用替换整层并排到最上），发布快照；disposer 只在该层仍是当前层时才删除（[packages/client/ui-theme/src/client/index.ts:308-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L308-L317)）
- `buildSnapshot()` 把 `system` 经媒体查询 `matches` 解析为 `dark`/`light`，查不到对应主题则抛错（[packages/client/ui-theme/src/client/index.ts:320-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L320-L327)）
- `buildSnapshot()` 冻结输出 preference、fontSize、合成后的 active、themes 列表与 revision 计数（[packages/client/ui-theme/src/client/index.ts:328-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L328-L334)）
- `composeActive()` 无覆盖层时按引用透传，否则按 seq 升序叠加各层、后层逐 token 覆盖，并按 active 的 colorScheme 取对应模式的值（[packages/client/ui-theme/src/client/index.ts:343-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L343-L352)）
- `publish()` 自增 revision、重建快照并在上下文上 emit `theme/change`（[packages/client/ui-theme/src/client/index.ts:354-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L354-L358)）
- `bootstrapFontSize()` 从 `body` 内联样式读回 `--dsh-content-font-size` 并解析，超范围或非整数时回落默认值（[packages/client/ui-theme/src/client/index.ts:368-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L368-L376)）
- `validateOverrides()` 对裸字符串值抛带示例的 TypeError，对缺少 `light`/`dark` 字符串对的值另抛 TypeError，并逐 token 复制出防御副本（[packages/client/ui-theme/src/client/index.ts:383-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L383-L403)）
- `dynamicToken()` 为目录外的 token 名生成检视条目，名字以 `--` 开头时才带上 `cssVariable` 字段（[packages/client/ui-theme/src/client/index.ts:405-413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L405-L413)）
- `inject` 声明该插件激活前必须就位的五个服务（[packages/client/ui-theme/src/client/index.ts:420](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L420)）
- `apply()` 先安装全局样式表，再按主题命名空间绑定设置作用域，构造运行时并以 `theme` 名提供服务（[packages/client/ui-theme/src/client/index.ts:429-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L429-L432)）
- `apply()` 用 `ctx.effect` 注册中英文文案字典到 `settings.theme` 命名空间（[packages/client/ui-theme/src/client/index.ts:434](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L434)）
- `apply()` 建立 `sync` 回调把快照的 preference 与 fontSize 连同 revision 推进两个行 store，并订阅 `theme/change`（[packages/client/ui-theme/src/client/index.ts:436-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L436-L444)）
- 外观行的 inject 回调在拿到绑定动作时立刻用 `theme.getTheme()` 补一次同步以免注册到首渲染之间漏事件，并把 `setTheme` 作为业务面交给组件（[packages/client/ui-theme/src/client/index.ts:445-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L445-L453)）
- 字号行的 inject 回调同样先补一次同步，再把 `setFontSize` 交给组件（[packages/client/ui-theme/src/client/index.ts:463-469](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L463-L469)）
- 外观行以 id `appearance`、order 10 注册进 `settings.general.item` 槽位（[packages/client/ui-theme/src/client/index.ts:454-461](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L454-L461)）
- 字号行以 id `font-size`、order 11 注册进同一槽位（[packages/client/ui-theme/src/client/index.ts:470-477](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/index.ts#L470-L477)）

### packages/client/ui-theme/src/client/locales.ts

`settings.theme` 命名空间的中英文文案字典，由客户端插件注册进 locale 服务。

- 无运行期机制

### packages/client/ui-theme/src/client/settings-store.ts

两个设置行槽位 store 的定义，状态是主题快照的镜像，唯一写入方是插件的变更监听器。

- `createAppearanceRowStore()` 把初始状态定为 `preference: 'system'`、`revision: -1`，使服务的 revision 0 也能被当作一次变更落地（[packages/client/ui-theme/src/client/settings-store.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/settings-store.ts#L26-L28)）
- 外观行的 `sync` 动作在传入 revision 不大于当前值时整体丢弃该次更新，否则同时写 preference 与 revision（[packages/client/ui-theme/src/client/settings-store.ts:29-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/settings-store.ts#L29-L35)）
- `createFontSizeRowStore()` 把初始状态定为默认字号与 `revision: -1`（[packages/client/ui-theme/src/client/settings-store.ts:56-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/settings-store.ts#L56-L58)）
- 字号行的 `sync` 动作同样按 revision 丢弃过期更新，否则写 fontSize 与 revision（[packages/client/ui-theme/src/client/settings-store.ts:59-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/settings-store.ts#L59-L65)）

### packages/client/ui-theme/src/client/styles.ts

把五张全局样式表注入 document 的模块，由客户端插件 `apply()` 首先调用。

- `STYLES` 数组固定五张样式表的内容与注入先后顺序（base、design-platform、scrollbar、gradient-shadow-text、shiki），决定级联中的覆盖关系（[packages/client/ui-theme/src/client/styles.ts:10-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/styles.ts#L10-L16)）
- 无 `document` 的运行环境直接返回，不做任何注入（[packages/client/ui-theme/src/client/styles.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/styles.ts#L23)）
- 每张表各起一个 `ctx.effect`：创建 `style` 标签、打上 `data-plugin` 与 `data-plugin-css` 标记、写入 CSS 文本并挂到 head，返回的清理函数把标签移除（[packages/client/ui-theme/src/client/styles.ts:24-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/client/styles.ts#L24-L33)）

### packages/client/ui-theme/src/css-modules.d.ts

CSS Module 与 `?inline` 导入的模块类型声明。

- 无运行期机制

### packages/client/ui-theme/src/index.ts

Host 侧插件入口：注册持久化主题配置段，并在每次 index 页面注入收集时给出引导脚本行。

- `THEME_NAMESPACE` 由主题命名空间常量构造，作为设置服务的读写键（[packages/client/ui-theme/src/index.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/index.ts#L18)）
- `readSection()` 在设置服务缺席或该命名空间未注册时回落到 schema 默认的偏好与字号（[packages/client/ui-theme/src/index.ts:21-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/index.ts#L21-L28)）
- `apply()` 通过 `ctx.inject(['settings'])` 在设置服务就位后注册该命名空间与其 schema（[packages/client/ui-theme/src/index.ts:37-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/index.ts#L37-L39)）
- `apply()` 监听 `webserver/index-inject`，每次都现读当前配置段并把引导脚本行推入注入表（[packages/client/ui-theme/src/index.ts:40-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/index.ts#L40-L43)）

### packages/client/ui-theme/src/invariant.ts

本包的不变量伴生插件，向不变量服务登记包名。

- 声明伴生插件名与 `inject: ['invariants']`，决定它在不变量服务就位后才激活（[packages/client/ui-theme/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/invariant.ts#L13-L15)）
- 安装器为空实现，即本包不注册任何运行期不变量检查（[packages/client/ui-theme/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/invariant.ts#L23)）
- `apply()` 用包名把该安装器注册进不变量服务并返回其 disposer（[packages/client/ui-theme/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/invariant.ts#L30-L31)）

### packages/client/ui-theme/src/styles/base.css

在 `:root` 上补齐上游字体族与动效曲线变量，供其余 token 表里的复合值解析。

- 无运行期机制

### packages/client/ui-theme/src/styles/design-platform.css

色板 token 表：在 `body` 上声明静态色阶与语义别名，并在深色属性选择器下整体改写。

- `body` 上声明浅色的 `--dsw-static-*` 色阶（[packages/client/ui-theme/src/styles/design-platform.css:4-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/design-platform.css#L4-L78)）
- `body[data-ds-dark-theme]` 重新声明同名静态色阶，属性一挂即整体切换（[packages/client/ui-theme/src/styles/design-platform.css:80-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/design-platform.css#L80-L154)）
- `body` 上把 `--dsw-alias-*` 与 `--dsw-specific-*` 语义别名指向具体静态色阶，其中含被滚动条表消费的四个 `--dsw-alias-scrollbar-*`（[packages/client/ui-theme/src/styles/design-platform.css:156-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/design-platform.css#L156-L246)）
- `body[data-ds-dark-theme]` 把同一批语义别名改指深色色阶，使所有消费方无需自行判深浅（[packages/client/ui-theme/src/styles/design-platform.css:248-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/design-platform.css#L248-L338)）

### packages/client/ui-theme/src/styles/gradient-shadow-text.css

渐变、阴影与字体阶梯表：把会话内容字号变量换算成整套标题与正文字体复合变量。

- `body` 上声明渐变、阴影与模糊变量，`body[data-ds-dark-theme]` 下改写其中两条渐变（[packages/client/ui-theme/src/styles/gradient-shadow-text.css:1-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/gradient-shadow-text.css#L1-L17)）
- `--dsh-content-font-delta` 取 `--dsh-content-font-size` 与 14px 的差值，缺省按 14px 计算（[packages/client/ui-theme/src/styles/gradient-shadow-text.css:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/gradient-shadow-text.css#L32)）
- `--dsh-content-font-size-secondary` 用 `min`/`max` 组合把次级档定为设置值 −1（≤14）或 −2（>14），并据此算出 `--dsh-content-font-delta-secondary`（[packages/client/ui-theme/src/styles/gradient-shadow-text.css:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/gradient-shadow-text.css#L33-L34)）
- h1–h3 的字号与行高各自按同一 delta 平移（[packages/client/ui-theme/src/styles/gradient-shadow-text.css:36-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/gradient-shadow-text.css#L36-L55)）
- h4 与正文及其粗体、斜体、粗斜体变体直接取 `--dsh-content-font-size`，行高按 delta 平移（[packages/client/ui-theme/src/styles/gradient-shadow-text.css:57-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/gradient-shadow-text.css#L57-L90)）
- 表格与表头变体改读次级档字号与次级 delta（[packages/client/ui-theme/src/styles/gradient-shadow-text.css:92-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/gradient-shadow-text.css#L92-L104)）
- small 与 code 系列写死固定字号行高，不随设置变动（[packages/client/ui-theme/src/styles/gradient-shadow-text.css:106-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/gradient-shadow-text.css#L106-L154)）
- 24/20/18/16/14/13/12/11 各档界面字体复合变量为固定值（[packages/client/ui-theme/src/styles/gradient-shadow-text.css:156-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/gradient-shadow-text.css#L156-L245)）

### packages/client/ui-theme/src/styles/scrollbar.css

滚动条皮肤表：在 `body` 上建立可被下游重绑的滚动条颜色间接变量，并按引擎能力分派两条互斥渲染路径。

- `body` 上把 `--dsh-scrollbar-thumb` 与 `--dsh-scrollbar-thumb-hover` 绑到 l1 别名 token，并把 `--dsh-scrollbar-width` 定为 8px 供需要让位的容器读取（[packages/client/ui-theme/src/styles/scrollbar.css:17-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/scrollbar.css#L17-L25)）
- `@supports not selector(::-webkit-scrollbar)` 分支对 `body` 及其所有后代逐元素声明 `scrollbar-width: thin` 与 `scrollbar-color`，使后代重绑间接变量仍生效（[packages/client/ui-theme/src/styles/scrollbar.css:44-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/scrollbar.css#L44-L60)）
- `::-webkit-scrollbar` 把滚动条宽高定为 8px（[packages/client/ui-theme/src/styles/scrollbar.css:66-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/scrollbar.css#L66-L69)）
- 轨道设为透明，只有滑块带 token 颜色（[packages/client/ui-theme/src/styles/scrollbar.css:73-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/scrollbar.css#L73-L75)）
- 两条滚动条交汇的角落同样设为透明，覆盖 UA 默认的不透明填充（[packages/client/ui-theme/src/styles/scrollbar.css:88-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/scrollbar.css#L88-L90)）
- 滑块与其 hover 态分别读两个间接变量，因而一次重绑即可改变该子树的滚动条配色（[packages/client/ui-theme/src/styles/scrollbar.css:77-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/scrollbar.css#L77-L84)）

### packages/client/ui-theme/src/styles/shiki.css

语法高亮 token 色板表，为代码块渲染器发出的 `--shiki-*` 自定义属性提供取值。

- `:root` 上把 `--shiki-foreground` 与 `--shiki-background` 别名到主文本与代码块 token，并固定各类语法 token 的浅色值（[packages/client/ui-theme/src/styles/shiki.css:7-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/shiki.css#L7-L19)）
- `body[data-ds-dark-theme]` 下改写九个语法 token 的取值（[packages/client/ui-theme/src/styles/shiki.css:21-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/styles/shiki.css#L21-L31)）

### packages/client/ui-theme/src/theme-settings.ts

主题配置段的常量、schema 与判定函数，Host 入口与浏览器侧运行时共用。

- `THEME_PREFERENCES` 固定设置与注册表边界上接受的三个内置偏好值（[packages/client/ui-theme/src/theme-settings.ts:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/theme-settings.ts#L6)）
- 命名空间名与两个字段名固定持久化文档中的键（[packages/client/ui-theme/src/theme-settings.ts:9-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/theme-settings.ts#L9-L15)）
- 无持久值时的默认偏好定为 `system`（[packages/client/ui-theme/src/theme-settings.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/theme-settings.ts#L21)）
- 字号下界 12、上界 17、无持久值时默认 14（[packages/client/ui-theme/src/theme-settings.ts:24-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/theme-settings.ts#L24-L30)）
- `ThemeSettingsSchema` 把偏好约束为三值联合、字号约束为步长 1 且落在上下界内，并各带默认值，是持久化与线上信封的共同校验入口（[packages/client/ui-theme/src/theme-settings.ts:41-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/theme-settings.ts#L41-L44)）
- `isThemePreference()` 把跨设置或注册表边界的未知值收窄为内置偏好（[packages/client/ui-theme/src/theme-settings.ts:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/src/theme-settings.ts#L51-L53)）

### packages/client/ui-theme/tsconfig.json

本包的 TypeScript 编译配置，声明基础配置、输入输出目录与工作区引用。

- 无运行期机制

### packages/client/ui-theme/tsdown.config.ts

打包配置，决定该包产出哪些运行期入口文件。

- 以包名与 `lib/types/index.js`、`lib/types/invariant.js` 两个入口调用共用的客户端打包工厂，确定产物入口集合（[packages/client/ui-theme/tsdown.config.ts:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-theme/tsdown.config.ts#L3-L6)）
