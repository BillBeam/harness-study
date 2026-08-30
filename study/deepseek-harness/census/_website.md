---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · website（文档站）
---

# website（文档站）

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、58 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### website/.vitepress/config.ts

VitePress 站点配置，把 `docs.ts` 的发布清单转成侧边栏、导航栏与站点选项，并挂上开发期中间件与 Markdown 渲染改写。

- 模块加载时立即调用 `projectDocs()`，把各处 canonical Markdown 投影进生成目录（[website/.vitepress/config.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L11)）
- `sidebar()` 依 `orderedPages` 的顺序把页面按 section 聚成 Map，插入序即分组顺序（[website/.vitepress/config.ts:13-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L13-L21)）
- 只有 `collapsed` 有定义时才写入该键，未定义时整键省略（[website/.vitepress/config.ts:22-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L22-L31)）
- `guideModules` 把每个 locale 的 guide/develop/reference 三个集合与其标签固定下来，供导航栏与指南侧边栏共读（[website/.vitepress/config.ts:59-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L59-L70)）
- `guideSidebar()` 在指南分组之后追加指向另外两个模块首页的顶层链接（[website/.vitepress/config.ts:78-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L78-L87)）
- `moduleNav()` 为每个模块生成导航项，并按 locale 拼出 `^/develop/`、`^/en/reference/` 之类的 activeMatch 正则（[website/.vitepress/config.ts:96-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L96-L103)）
- `watchCanonicalDocs()` 把 canonical 源文件加进 dev server 的 watcher，命中变更时重跑 `projectDocs()`（[website/.vitepress/config.ts:105-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L105-L112)）
- `serveRawMarkdown()` 只处理 GET/HEAD 请求，其余直接 `next()`（[website/.vitepress/config.ts:119-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L119-L124)）
- 依 `sec-fetch-dest` 请求头分流：存在且不为 `document` 的请求交回 Vite，无该头的客户端得到原始 Markdown（[website/.vitepress/config.ts:132-136](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L132-L136)）
- 从 URL 去掉查询与哈希、剥掉 base 前缀后得到站内路径（[website/.vitepress/config.ts:137-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L137-L138)）
- 命中 `llms.txt` 时以 `text/plain; charset=utf-8` 返回按 base 与站点标识生成的索引（[website/.vitepress/config.ts:139-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L139-L143)）
- 以 `.md` 结尾的路径经 `rawMarkdownRoute()` 解析；解析不出内容时放行给下一个中间件，否则以 `text/markdown; charset=utf-8` 直接返回（[website/.vitepress/config.ts:144-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L144-L151)）
- `escapeVueInterpolation()` 把 `{{`/`}}` 转成 HTML 实体，阻止 Vue 把文档正文当插值求值（[website/.vitepress/config.ts:154-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L154-L156)）
- 本地搜索 provider 与中文界面译文一并配置（[website/.vitepress/config.ts:158-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L158-L188)）
- 编辑链接从页面 frontmatter 的 `editSource` 取值，缺失或非字符串时直接抛错（[website/.vitepress/config.ts:192-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L192-L200)）
- 站点 base 取自环境变量 `DOCS_BASE`，缺省为 `/`（[website/.vitepress/config.ts:204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L204)）
- 构建时读取 `public/wordmark.svg` 并给根元素加上 `dsh-wordmark` 类，把字标内联进配置（[website/.vitepress/config.ts:216-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L216-L218)）
- `scrollbarScript` 以捕获阶段监听 scroll，给 `.VPSidebar` 打上 `data-scrolling` 并在 800ms 后清除（[website/.vitepress/config.ts:271-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L271-L282)）
- `siteTitle()` 生成导航栏 HTML 字符串，把字标与阶段标签拼成一个 lockup（[website/.vitepress/config.ts:291-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L291-L293)）
- `buildEnd` 在构建末尾把每条路由的原始 Markdown 孪生文件与 `llms.txt` 写进输出目录（[website/.vitepress/config.ts:299-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L299-L303)）
- `head` 注入带 base 前缀的 favicon 链接、内联样式与内联脚本（[website/.vitepress/config.ts:304-309](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L304-L309)）
- `cleanUrls: true` 与 `srcDir`/`cacheDir`/`outDir` 指定源为生成目录、缓存与产物落到 `.cache`/`.dist`（[website/.vitepress/config.ts:310-313](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L310-L313)）
- root locale 绑定 `zh-CN`，导航首项链接由 `landingLink` 推导，三条侧边栏按路径前缀挂载（[website/.vitepress/config.ts:315-338](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L315-L338)）
- en locale 绑定 `en-US` 并以 `/en/` 作为路由前缀，侧边栏挂在 `/en/...` 前缀下，另覆写英文编辑链接文案（[website/.vitepress/config.ts:340-367](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L340-L367)）
- Vite 的 `publicDir` 指向 `website/public`，绕开位于生成目录内的默认 public 路径（[website/.vitepress/config.ts:369-372](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L369-L372)）
- 自定义 Vite 插件在 `configureServer` 中同时装上文档监听与原始 Markdown 中间件（[website/.vitepress/config.ts:373-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L373-L381)）
- Markdown 配置在三条渲染规则缺失时抛错，然后包裹 text 与 code_inline 规则做插值转义（[website/.vitepress/config.ts:384-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L384-L392)）
- fence 规则对 mermaid/mmd 与带 `src` 的代码块直接透传不缓存（[website/.vitepress/config.ts:394-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L394-L400)）
- 非 production 环境跳过缓存；production 下以内容、info、markup 与 attrs 的 JSON 为键缓存已渲染的代码块（[website/.vitepress/config.ts:402-408](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/.vitepress/config.ts#L402-L408)）

### website/AGENTS.md

站点子树的说明文档，约定内容不落在 `website/`、生成目录不提交，以及构建期的输出清理与原始 Markdown 产出。

- 无运行期机制

### website/build.ts

站点的生产构建入口脚本，在 VitePress 解析完配置后先清理输出目录再打包，并作为 `pnpm build` 的执行体。

- `escapesRoot()` 用相对路径判断候选路径是否逃出根目录（含 `..` 前缀与绝对路径两种情形）（[website/build.ts:11-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/build.ts#L11-L14)）
- `nearestExistingAncestor()` 逐级上溯找到第一个真实存在的祖先，到达根仍未找到则抛错（[website/build.ts:16-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/build.ts#L16-L26)）
- `cleanDocSiteOutput()` 在输出目录等于站点根或逃出站点根时抛错，拒绝删除（[website/build.ts:34-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/build.ts#L34-L40)）
- 再以 `realpathSync` 解析站点根与输出目录最近存在的父目录，父目录解析后仍在站点根外时抛错（[website/build.ts:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/build.ts#L42-L46)）
- 输出目录本身是符号链接时只 `unlinkSync` 该链接而不递归删除其目标，否则递归强制删除（[website/build.ts:48-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/build.ts#L48-L53)）
- `docSiteBuildOptions()` 在 `mpa` 为真时加入 `mpa: 'true'` 选项，并挂 `onAfterConfigResolve` 在配置解析后、写文件前清理输出（[website/build.ts:62-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/build.ts#L62-L70)）
- `parseMpa()` 只接受空参数或单个 `--mpa`，其余组合抛错（[website/build.ts:77-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/build.ts#L77-L81)）
- 仅当本模块 URL 等于 `process.argv[1]` 解析出的文件 URL 时才执行构建，被 import 时不触发（[website/build.ts:83-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/build.ts#L83-L86)）

### website/docs.ts

文档站的发布清单模块，声明哪些仓库内 Markdown 被投影成哪些路由、归入哪个 locale 与侧边栏分组，并导出侧边栏排序与链接推导函数。

- `localized()` 对既可为单值也可为按 locale 分键的字段做取值，数组按单值处理（[website/docs.ts:65-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L65-L69)）
- `mirroredPages()` 把每条声明展开成 root 与 en 两条页面，en 的路由统一加 `en/` 前缀（[website/docs.ts:71-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L71-L89)）
- `pairedPages()` 由英文源名派生 `.zh.md` 中文源名，把 root 绑到中文源、en 绑到英文源，并互相把对方源路径登记为 sourceAliases（[website/docs.ts:91-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L91-L105)）
- 首页与指南组把 `docs/user/*` 下的源映射到 `index.md`、`guide/*` 路由，并给索引页登记目录别名（[website/docs.ts:107-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L107-L165)）
- 开发组把 `docs/user/develop/**` 映射到 `develop/**` 路由并分入基础、框架能力、实战三节（[website/docs.ts:167-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L167-L251)）
- Cordis 教程由文件名数组批量生成页面，数组下标直接作为 `order`，仅 `index.md` 追加目录别名（[website/docs.ts:253-270](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L253-L270)）
- 子系统页按主题分组批量生成，`README.md` 改投到 `reference/subsystems/index.md` 路由，并统一把 outline 设为 `[2, 3]`（[website/docs.ts:351-363](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L351-L363)）
- `docs/architecture.md` 被投影为 `reference/index.md`，即参考模块的落地页（[website/docs.ts:368-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L368-L377)）
- 生成参考三页各自可覆写 outline，持久化事件页设为 `deep`（[website/docs.ts:391-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L391-L403)）
- `docs/cordis-api/inherited.md` 走 `mirroredPages` 而非 `pairedPages`，两个 locale 共用同一份英文源，并把 order 整体后移 5（[website/docs.ts:418-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L418-L428)）
- `localeCollections` 固定每个 locale 三个侧边栏集合的顺序，导航栏与 llms.txt 索引共读该顺序（[website/docs.ts:450-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L450-L453)）
- `sections` 逐 locale 列出全部分组及其顺序，六个子系统分组带 `collapsed: true`（[website/docs.ts:469-494](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L469-L494)）
- `sectionSpec()` 按 label 查分组，未声明的 label 直接抛错，并返回其零基下标（[website/docs.ts:506-511](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L506-L511)）
- `docsPages` 汇总六组页面，构成站点发布的全部路由（[website/docs.ts:514-521](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L514-L521)）
- `orderedPages()` 按 locale 与集合过滤，再先按分组下标、后按 `order` 排序（[website/docs.ts:530-537](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L530-L537)）
- `routeLink()` 去掉路由末尾的 `index.md` 或 `.md` 得到站内链接（[website/docs.ts:545-547](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L545-L547)）
- `landingLink()` 取集合排序后的首页作为导航落点，集合为空时抛错（[website/docs.ts:561-565](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/docs.ts#L561-L565)）

### website/package.json

站点子包的清单，声明其为私有 ESM 包并给出开发、构建、预览三条脚本。

- `"type": "module"` 决定该目录下的 `.ts`/`.js` 以 ESM 解析（[website/package.json:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/package.json#L5)）
- `dev` 与 `preview` 脚本把 VitePress 绑定到 127.0.0.1 的 5173 与 4173 端口（[website/package.json:7-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/package.json#L7-L9)）
- `build` 脚本以 tsx 执行 `build.ts`，而非直接调用 vitepress build（[website/package.json:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/website/package.json#L8)）
