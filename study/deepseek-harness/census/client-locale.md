---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/locale
---

# packages/client/locale

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 16 个文件、65 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/locale/README.md

本包的说明文档，讲述语言偏好、浏览器回退、字典注册与实现结构。

- 无运行期机制

### packages/client/locale/package.json

本包的清单，声明入口映射、客户端装载元数据、发布文件与打包脚本。

- `exports` 暴露 `.`、`./invariant`、`./client`、`./src/*` 与 `./package.json` 五个入口（[packages/client/locale/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/package.json#L16-L31)）
- `dsh.client` 声明该行在 web 平台上依赖 connection、ui-renderer、ui-settings、api-remotes 四个客户端插件且 `immediately: true`，决定它在客户端启动图里的挂载次序（[packages/client/locale/package.json:32-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/package.json#L32-L43)）
- `files` 限定发布产物为三个 `lib` 入口与类型声明（[packages/client/locale/package.json:72-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/package.json#L72-L77)）
- `scripts` 定义 `bundle` 与 `watch` 两条 tsdown 命令（[packages/client/locale/package.json:78-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/package.json#L78-L81)）

### packages/client/locale/src/client/LanguageRow.module.css

Language 设置行的样式模块，由该行组件通过 CSS Modules 引入。

- 无运行期机制

### packages/client/locale/src/client/LanguageRow.tsx

注册进设置页 General 分区的语言偏好行组件，由本包的客户端插件挂载。

- 从 store 读取 `active` 与 `options` 两个切片驱动渲染（[packages/client/locale/src/client/LanguageRow.tsx:31-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/LanguageRow.tsx#L31-L32)）
- 显示标签取 `options` 中与 `active` 匹配的 label，找不到时退回展示 id 本身（[packages/client/locale/src/client/LanguageRow.tsx:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/LanguageRow.tsx#L34)）
- 行标题经 `t('language.title')` 翻译后渲染（[packages/client/locale/src/client/LanguageRow.tsx:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/LanguageRow.tsx#L39)）
- 菜单项由 `options` 映射而来，`selectedId` 指向当前语言，选中后调用注入的 `setLocale(id)` 并关闭菜单（[packages/client/locale/src/client/LanguageRow.tsx:41-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/LanguageRow.tsx#L41-L50)）
- 触发按钮带 `aria-haspopup`/`aria-expanded`，点击翻转菜单开合状态（[packages/client/locale/src/client/LanguageRow.tsx:52-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/LanguageRow.tsx#L52-L63)）

### packages/client/locale/src/client/index.ts

浏览器侧的 `LocaleRuntime` 与客户端插件体：语言目录、字典注册表、偏好解析，并注册 Language 设置行。

- `FALLBACK_LOCALE` 固定为 `en`，同时充当无匹配时的初始语言与逐键回退的终点（[packages/client/locale/src/client/index.ts:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L107)）
- `COMMON_NS` 与 `SETTINGS_NS` 固定共享命名空间与本功能设置命名空间的名字（[packages/client/locale/src/client/index.ts:110-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L110-L113)）
- 内置语言表给出 `zh`（label 中文、回退 en）与 `en`（无回退）两条冻结定义（[packages/client/locale/src/client/index.ts:116-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L116-L122)）
- `localeKey` 统一以小写作为语言 id 的比较键（[packages/client/locale/src/client/index.ts:125-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L125-L127)）
- `normalizeLanguage` 校验 id 与 fallback 匹配 BCP 47 式模式、label 非空白，并冻结输入副本（[packages/client/locale/src/client/index.ts:130-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L130-L139)）
- `syncDocumentLanguage` 把 `document.documentElement.lang` 设为激活语言，`zh` 写成 `zh-CN`，无 document 时跳过（[packages/client/locale/src/client/index.ts:146-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L146-L150)）
- 构造函数把内置语言写入目录、用浏览器推断出临时语言、初始化 revision 为 0 的冻结快照（[packages/client/locale/src/client/index.ts:182-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L182-L188)）
- 存在持久化 scope 时用 `ctx.effect` 订阅它并立即执行一次 `adopt`（[packages/client/locale/src/client/index.ts:189-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L189-L192)）
- `getLocale` / `getSnapshot` 返回当前不可变快照（[packages/client/locale/src/client/index.ts:199-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L199-L210)）
- `subscribe` 登记变更回调并返回退订函数（[packages/client/locale/src/client/index.ts:219-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L219-L222)）
- `setLocale` 对未注册 id 抛错，记下偏好，仅在激活语言真的改变时发布，但无条件把选择写入 Host 设置（[packages/client/locale/src/client/index.ts:236-242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L236-L242)）
- `addLanguage` 拒绝重复 id 与未注册的回退目标，写入后校验回退链并在失败时回滚删除，成功则发布新目录（[packages/client/locale/src/client/index.ts:256-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L256-L272)）
- `addLanguage` 返回的 disposer 只在目录里仍是本次那条定义时删除并重新发布（[packages/client/locale/src/client/index.ts:273-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L273-L277)）
- `adopt` 读取 scope 快照，值缺失时不动，否则更新偏好并在解析结果与当前激活语言不同时发布（[packages/client/locale/src/client/index.ts:285-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L285-L292)）
- `publishCatalog` 清空回退链缓存、重算浏览器推断值，并按激活语言是否变化决定是否算作语言切换（[packages/client/locale/src/client/index.ts:295-301](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L295-L301)）
- `resolveActive` 只在偏好对应的定义仍在目录中时采用它，否则回到浏览器推断值（[packages/client/locale/src/client/index.ts:304-307](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L304-L307)）
- `localeList` 按注册顺序冻结快照目录（[packages/client/locale/src/client/index.ts:310-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L310-L312)）
- `assertFallbackChain` 沿回退链前进，遇到重复 id 报环、遇到未注册目标报缺失、到达英语才算合法（[packages/client/locale/src/client/index.ts:315-334](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L315-L334)）
- `fallbackChain` 缓存查表链，链中未出现英语时补上英语作为末位（[packages/client/locale/src/client/index.ts:337-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L337-L356)）
- `register` 先逐个校验语言 id 模式，再拒绝同一 (命名空间, 语言) 的重复占位（[packages/client/locale/src/client/index.ts:381-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L381-L400)）
- 字典写入后以「非语言切换」方式发布，只推进 revision（[packages/client/locale/src/client/index.ts:401-402](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L401-L402)）
- `register` 返回的 disposer 只删除仍与本次注册同一引用的字典，有删除才重新发布（[packages/client/locale/src/client/index.ts:403-417](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L403-L417)）
- `bind` 对同一命名空间返回同一个翻译函数引用（[packages/client/locale/src/client/index.ts:437-445](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L437-L445)）
- `translate` 先在本命名空间沿回退链查，再在 common 命名空间重复一遍，仍缺则显示键名本身（[packages/client/locale/src/client/index.ts:447-451](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L447-L451)）
- 有参数时按 `{name}` 替换模板占位，参数缺失的占位原样保留（[packages/client/locale/src/client/index.ts:452-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L452-L455)）
- `lookup` 按链顺序返回第一个命中的字典值（[packages/client/locale/src/client/index.ts:457-464](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L457-L464)）
- `publish` 生成 revision 加一的冻结快照，只有语言切换才 `ctx.emit('locale/change')`（[packages/client/locale/src/client/index.ts:473-483](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L473-L483)）
- 逐个通知订阅者，单个订阅者抛错被 `console.error` 吞下，不阻断其余订阅者（[packages/client/locale/src/client/index.ts:484-492](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L484-L492)）
- `resolveInitialLocale` 在浏览器推断失败时回到 `FALLBACK_LOCALE`（[packages/client/locale/src/client/index.ts:500-502](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L500-L502)）
- `detectBrowserLocale` 以 `window` 是否存在作为浏览器判据，非浏览器直接返回 undefined（[packages/client/locale/src/client/index.ts:515-516](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L515-L516)）
- 依次遍历 `navigator.languages` 与 `navigator.language`，每个标签先整串精确匹配再按首个子标签匹配（[packages/client/locale/src/client/index.ts:518-527](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L518-L527)）
- 插件声明 `inject = ['slots', 'connection', 'remote', 'settingsScope']`（[packages/client/locale/src/client/index.ts:531](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L531)）
- `apply` 绑定 `locale` 设置命名空间的 scope 并据此构造 `LocaleRuntime`（[packages/client/locale/src/client/index.ts:540-541](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L540-L541)）
- 注册 common 与 settings.locale 两个命名空间的中英字典（[packages/client/locale/src/client/index.ts:542-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L542-L543)）
- `ctx.provide('locale', locale)` 把运行时发布为服务，并 `ctx.slots.installLocale(locale)` 让渲染层合成 `t` 座位（[packages/client/locale/src/client/index.ts:544-547](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L544-L547)）
- `sync` 每次把当前快照同步到 `<html lang>` 与 Language 行的 store（[packages/client/locale/src/client/index.ts:549-559](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L549-L559)）
- 用 `ctx.effect` 订阅运行时变更驱动 `sync`，并在激活时立即先跑一次（[packages/client/locale/src/client/index.ts:560-564](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L560-L564)）
- 注入函数捕获 store 的绑定动作、补一次 `sync` 防止注册到首渲染之间丢事件，并向行组件暴露 `setLocale`（[packages/client/locale/src/client/index.ts:565-573](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L565-L573)）
- 把 `LanguageRow` 以 id `language`、order 0 注册进 `settings.general.item` 槽位（[packages/client/locale/src/client/index.ts:574-581](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/index.ts#L574-L581)）

### packages/client/locale/src/client/settings-store.ts

Language 行的槽位 store 定义，由插件体写入、由行组件读取。

- `init` 给出 `active` 空串、`options` 空数组、`revision` 为 -1 的初始状态，使服务的 revision 0 也算一次变化（[packages/client/locale/src/client/settings-store.ts:37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/settings-store.ts#L37)）
- `sync` 动作在传入 revision 不大于已存 revision 时直接返回，否则整体覆写激活语言、选项与 revision（[packages/client/locale/src/client/settings-store.ts:38-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/client/settings-store.ts#L38-L45)）

### packages/client/locale/src/css-modules.d.ts

CSS Modules 的环境类型声明。

- 无运行期机制

### packages/client/locale/src/index.ts

Host 一侧的入口，把持久化的 locale 设置节注册到设置服务。

- `ctx.inject(['settings'], …)` 在设置服务存在时用 `LocaleSettingsSchema` 注册 `locale` 命名空间（[packages/client/locale/src/index.ts:16-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/index.ts#L16-L22)）

### packages/client/locale/src/invariant.ts

本包的 invariant 伴随插件，被 invariants 服务在组合期装载。

- 以空安装器向 invariants 服务登记包名占位并返回其 disposer（[packages/client/locale/src/invariant.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/invariant.ts#L22-L30)）

### packages/client/locale/src/locale-settings.ts

locale 持久化设置的命名空间、字段名、id 模式与模式定义，Host 与浏览器两侧共用。

- `LOCALE_SETTINGS_NAMESPACE` 固定为 `locale`，`LOCALE_PREFERENCE_FIELD` 固定为 `preference`（[packages/client/locale/src/locale-settings.ts:6-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/locale-settings.ts#L6-L9)）
- `LOCALE_ID_PATTERN` 规定可接受的 BCP 47 式语言标签形态（[packages/client/locale/src/locale-settings.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/locale-settings.ts#L12)）
- `LOCALE_IDS` 固定内置语言为 `zh` 与 `en`（[packages/client/locale/src/locale-settings.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/locale-settings.ts#L15)）
- `LocaleSettingsSchema` 把 `preference` 定义为可选、且需匹配语言标签模式的字符串（[packages/client/locale/src/locale-settings.ts:30-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/src/locale-settings.ts#L30-L32)）

### packages/client/locale/src/locales/en.ts

common 命名空间的英文字典。

- 无运行期机制

### packages/client/locale/src/locales/index.ts

common 字典对的再导出入口。

- 无运行期机制

### packages/client/locale/src/locales/settings.ts

`settings.locale` 命名空间的中英字典与键联合类型。

- 无运行期机制

### packages/client/locale/src/locales/zh.ts

common 命名空间的中文字典，同时是键集合的类型来源。

- 无运行期机制

### packages/client/locale/tsconfig.json

本包的编译配置，声明根/输出目录与工作区引用。

- 无运行期机制

### packages/client/locale/tsdown.config.ts

本包的打包配置，交给共享的 `clientBundle` 工厂。

- 指定该包以 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口产出打包产物（[packages/client/locale/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/locale/tsdown.config.ts#L3)）
