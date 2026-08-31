---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/modules
---

# packages/client/modules

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 9 个文件、92 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/modules/README.md

包 README，用散文描述这个双面包的两半（node 半扫描 `dsh.client` 并组装 boot 图、浏览器半懒加载 CJS 模块表），并给出源码文件的角色表。

- 无运行期机制

### packages/client/modules/package.json

包清单，声明这个包自身既是 node 半服务、又是被 boot 图收录的浏览器插件行。

- `exports` 暴露三个入口：`.` 指向 node 半 `lib/index.js`，`./client` 指向浏览器 bundle `lib/client.js`，`./invariant` 指向不变量伴生插件，另有 `./src/*` 直通源码（[packages/client/modules/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/package.json#L16-L31)）
- `dsh` 段声明 `client.platform = "web"`、`inject: []`、`immediately: true`，使本包被 node 半扫描成一条 boot 图行并进入第一阶段预取（[packages/client/modules/package.json:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/package.json#L32-L38)）
- `files` 白名单只发布 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与类型声明（[packages/client/modules/package.json:50-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/package.json#L50-L55)）
- `type: module` 与 `main`/`types` 指向构建产物 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/modules/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/package.json#L13-L15)）

### packages/client/modules/src/client/index.ts

浏览器半的 `./client` 入口：被 HTML 里的加载器 facade 物化后调用其 bootstrap 导出构造模块系统，随后作为普通 cordis 插件把该实例登记为 `ctx.modules`。

- 模块级变量保存唯一的模块系统实例，跨 bootstrap 与插件 apply 两次调用共享（[packages/client/modules/src/client/index.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/index.ts#L29)）
- `createClientModuleSystem` 把原始 boot 图交给 `parseBootManifest` 解析，连同静态模块种子表、注册 facade、已物化的 bootstrap 模块一起构造 `ClientModuleSystem`，并在 `loadBundle` 未给出时省略该键以走默认传输（[packages/client/modules/src/client/index.ts:38-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/index.ts#L38-L51)）
- `apply` 在模块系统尚未构造时抛错，阻止插件面在 bootstrap 之前启动（[packages/client/modules/src/client/index.ts:58-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/index.ts#L58-L60)）
- `apply` 通过 `ctx.reflect.provide('modules', …)` 把已存在的实例提供为服务（[packages/client/modules/src/client/index.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/index.ts#L61)）

### packages/client/modules/src/client/manifest.ts

浏览器安全的线协议面：`window.__DSH_BOOT__` 的类型、字段校验函数和 boot 清单解析器，被浏览器半与 node 半共同引用。

- `optionalStringArray` 校验可选字符串数组字段，缺失返回 undefined，非字符串数组抛错（[packages/client/modules/src/client/manifest.ts:139-145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/manifest.ts#L139-L145)）
- `stripClientSuffix` 去掉说明符尾部的 `/client`，使 `<id>/client` 与裸包名解析到同一行（[packages/client/modules/src/client/manifest.ts:156-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/manifest.ts#L156-L158)）
- `parseBootManifest` 对非对象的 wire、非字符串 `rev`、非数组 `entries`/`batches` 分别抛错（[packages/client/modules/src/client/manifest.ts:167-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/manifest.ts#L167-L180)）
- 逐条校验 entry 必须是对象且带字符串 `id`/`url`/`rev`，重复 id 抛错（[packages/client/modules/src/client/manifest.ts:184-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/manifest.ts#L184-L194)）
- 校验 entry 的 `inject`/`external` 为字符串数组、`immediately` 为布尔（[packages/client/modules/src/client/manifest.ts:195-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/manifest.ts#L195-L200)）
- 同一条 wire entry 投影成两个视图：模块表行（`inject`/`external` 缺省为 `[]`）与插件行（`immediately` 缺省为 false）（[packages/client/modules/src/client/manifest.ts:201-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/manifest.ts#L201-L212)）
- 校验 batch 的 `phase` 只能是 `bootstrap` 或 `application`，`url`/`rev` 必须为字符串，并拒绝重复的 batch URL（[packages/client/modules/src/client/manifest.ts:218-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/manifest.ts#L218-L233)）
- 要求 batch 的 `entries` 非空，拒绝未知 entry id，拒绝一条 entry 同时属于两个 batch，并把 batch URL 记为该 entry 的 `initialUrl`（[packages/client/modules/src/client/manifest.ts:234-246](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/manifest.ts#L234-L246)）
- 任何未被任何初始批次收录的 entry 抛错，最终返回带 `initialUrl` 的模块行集合与插件行集合（[packages/client/modules/src/client/manifest.ts:248-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/manifest.ts#L248-L256)）

### packages/client/modules/src/client/system.ts

`ClientModuleSystem` 实现：浏览器侧的模块表状态与到达／物化机器，被 `./client` 的 bootstrap 导出构造并被 vendored Loader 通过 `import` 消费。

- 默认 bundle 传输创建 `async` 的 `<script src>` 插入 `document.head`，load 后移除元素并 resolve，error 后移除并以带 URL 的错误 reject（[packages/client/modules/src/client/system.ts:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L14-L27)）
- `atRevision` 在 URL 缺少 `rev=` 查询时抛错，否则用编码后的新 rev 替换该查询值（[packages/client/modules/src/client/system.ts:30-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L30-L35)）
- `claimStyles` 把所有未打标的 `<style>` 标记为当前物化中的插件所有，再收集该插件名下的 `data-plugin-css` 标签 id（[packages/client/modules/src/client/system.ts:42-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L42-L52)）
- 构造时把解析后的模块行按 id 索引，重复 id 抛错（[packages/client/modules/src/client/system.ts:87-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L87-L90)）
- 构造时把已物化的 bootstrap 模块直接写入 `loadCache` 并登记进 bootstrapIds（[packages/client/modules/src/client/system.ts:92-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L92-L99)）
- 构造时要求注册 facade 仍处于 `queue` 模式，否则抛错（[packages/client/modules/src/client/system.ts:101-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L101-L104)）
- 构造时先取出待处理队列、把 facade 切到 `live` 并替换其 `load` 为直接注册，再回放队列中的注册（[packages/client/modules/src/client/system.ts:105-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L105-L110)）
- `register` 归一化 id 后，对 bootstrap id 或已注册 id 抛出重复注册错误，否则存入 factory 表（[packages/client/modules/src/client/system.ts:114-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L114-L119)）
- `arrive` 对已物化或已注册的行直接返回，否则优先使用 HMR 失效后设置的 reload URL，其次用初始批次 URL（[packages/client/modules/src/client/system.ts:123-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L123-L127)）
- 同一 URL 的并发到达共享一个在途传输 Promise，settle 后从在途表中删除（[packages/client/modules/src/client/system.ts:128-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L128-L132)）
- 脚本加载完成后若目标 id 仍未注册 factory 则抛错，并清掉本次消费掉的 reload URL（[packages/client/modules/src/client/system.ts:133-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L133-L140)）
- `arriveGraphRow` 在打开路径上发现同一 id 时抛出到达环错误并列出环上的包（[packages/client/modules/src/client/system.ts:149-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L149-L155)）
- `arriveGraphRow` 先递归到达每个未被种子表或缓存满足的 `external` 请求行，再递归到达每个 `inject` 包（后者以空路径重开环检测），最后加载自身（[packages/client/modules/src/client/system.ts:156-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L156-L169)）
- `materialize` 命中缓存直接返回，未注册 factory 抛错，重入时抛出 require 环错误（[packages/client/modules/src/client/system.ts:173-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L173-L181)）
- `materialize` 执行 factory 得到 exports，连同认领的样式标签与观察到的 require 边一起写入 `loadCache`，并在 finally 中解除重入标记（[packages/client/modules/src/client/system.ts:182-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L182-L191)）
- 交给 factory 的同步 `require` 记录边后依次尝试种子表、已物化记录、已注册 factory（递归物化），全部落空则抛出带诊断的错误（[packages/client/modules/src/client/system.ts:200-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L200-L213)）
- `import` 按种子词 → 已物化记录 → boot 图行（触发异步到达）→ 已注册 factory 的顺序解析，都不命中则抛错，最后返回物化后的 exports（[packages/client/modules/src/client/system.ts:215-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L215-L230)）
- `prefetch` 对已物化 id 直接返回，对非图内 id 抛错，否则只做到达（注册 factory）而不物化（[packages/client/modules/src/client/system.ts:232-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L232-L238)）
- `invalidate` 对 bootstrap id 无操作；对图内行按新 rev 或图 rev 记下单资源 reload URL，对图外 id 清除 reload URL，并删除其 factory 与物化记录（[packages/client/modules/src/client/system.ts:240-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/client/system.ts#L240-L248)）

### packages/client/modules/src/index.ts

node 半：扫描 Loader 条目里声明 `dsh.client` 的包，组装 `window.__DSH_BOOT__` 图，生成并托管 combo 脚本与源映射路由，并向 webserver 的首页注入表贡献引导脚本；默认导出 `ClientModuleRegistry` 服务。

- `MissingClientBundleError` 把缺失的构建产物包装成带包名、路径与构建指令的结构化错误（[packages/client/modules/src/index.ts:109-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L109-L124)）
- `ClientPackageCompositionError` 把激活期的多个失败拆成"缺 bundle"与"其他失败"两组，合成一条聚合错误消息（[packages/client/modules/src/index.ts:127-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L127-L144)）
- 常量固定了不可变缓存头、3 KiB 的 combo URL 上限与 12 位 rev 长度（[packages/client/modules/src/index.ts:180-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L180-L184)）
- 两条正则用于剥离 bundle 末尾的 `sourceMappingURL` 与 `sourceURL` 注释（[packages/client/modules/src/index.ts:186-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L186-L189)）
- `exactPackageSpecifier` 只接受裸包根说明符，排除子路径与路径式条目（[packages/client/modules/src/index.ts:192-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L192-L198)）
- `parseDshClient` 校验 `dsh.client` 为对象、`platform` 为字符串、`inject`/`external` 为字符串数组、`immediately` 为布尔，逐项抛错（[packages/client/modules/src/index.ts:201-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L201-L221)）
- `clientExportOf` 从 `exports["./client"]` 取字符串或一层条件对象的 `default`，其他形式抛错（[packages/client/modules/src/index.ts:224-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L224-L234)）
- `shortHash`/`framedHash`/`artifactRevision` 用 sha1 前 12 位生成 rev，其中分帧哈希在每段前写入字节长度以防跨字段挪移（[packages/client/modules/src/index.ts:237-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L237-L251)）
- `comboUrl` 把一组 id 拼成 `/plugins/??<id>/client.js,…&rev=<rev>` 的合并请求地址，映射形式再加 `.map` 后缀（[packages/client/modules/src/index.ts:254-257](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L254-L257)）
- `partitionComboRecords` 按图序切分，使每个生成 URL 不超过字节上限；单条记录即超限时抛错（[packages/client/modules/src/index.ts:260-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L260-L293)）
- `comboSource` 剥掉 bundle 自带的调试指令、补足结尾换行，并推导出该段的生成文件名（[packages/client/modules/src/index.ts:302-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L302-L311)）
- `comboScript` 在合并脚本末尾写入指向索引映射的绝对 `sourceMappingURL`（[packages/client/modules/src/index.ts:314-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L314-L316)）
- `sourceMapSnapshot` 读取 `<bundle>.map`，ENOENT 返回 undefined，其他读错误上抛，并校验其为规范 Source Map v3 否则抛错（[packages/client/modules/src/index.ts:319-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L319-L341)）
- `comboSectionMap` 把原映射的 `sources` 按 `/plugins/<id>/client.js.map` 基址重定位并删除 `sourceRoot`（[packages/client/modules/src/index.ts:351-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L351-L368)）
- `identitySectionMap` 为没有作者映射的 bundle 逐行生成恒等映射并把源码放进 `sourcesContent`（[packages/client/modules/src/index.ts:371-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L371-L381)）
- `buildCombo` 把若干 bundle 以 `;\n` 串接、按累计行号写出 Indexed Source Map 的 sections，计算 rev 并产出脚本与映射两个响应地址（[packages/client/modules/src/index.ts:384-405](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L384-L405)）
- `buildBatch` 给 combo 产物附上 `phase`/`url`/`rev`/`entries` 的线上批次描述符（[packages/client/modules/src/index.ts:408-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L408-L414)）
- `graphRow` 生成单条 wire entry：单资源 combo URL 作为 `url`，并按需带上 `inject`、`immediately`、非空 `external`（[packages/client/modules/src/index.ts:417-426](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L417-L426)）
- `orderByModuleGraph` 沿 `external` 边做深度优先排序，使被请求的包行排在消费者之前；遇到环或自请求分别抛错，扫描顺序作为并列时的次序（[packages/client/modules/src/index.ts:438-470](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L438-L470)）
- `PARSER_PRELOAD_IDS` 把本包固定为 bootstrap 批次的唯一成员（[packages/client/modules/src/index.ts:473-476](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L473-L476)）
- `bootInjections` 生成内联脚本，在页面上安装 `window.__ModuleLoader__`：queue 模式下 `load` 只入队，`create` 找出模块系统包的注册项、以一个只会抛错的 require 执行其 factory、校验导出面后委托给 `createClientModuleSystem`（[packages/client/modules/src/index.ts:490-512](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L490-L512)）
- `bootInjections` 按执行顺序返回注入行：内联队列脚本、每个 application 批次的预加载、每个 bootstrap 批次的阻塞式 `script-src`、最后是 `__DSH_BOOT__` 全局量（[packages/client/modules/src/index.ts:513-523](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L513-L523)）
- `ClientModuleRegistry` 声明注入 `webServer` 与 `loader`（[packages/client/modules/src/index.ts:533-534](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L533-L534)）
- 每次进程启动生成一个随机 nonce，配合自增计数器作为各行的初始 rev，从而不必在启动时哈希每个 bundle（[packages/client/modules/src/index.ts:544-545](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L544-L545)）
- 构造函数订阅 `internal/plugin`，把 fiber 的 entry 名标脏，无 entry 的 fiber 直接丢弃，并用一次微任务合并触发 flush（[packages/client/modules/src/index.ts:562-572](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L562-L572)）
- 构造函数把当前所有 Loader 条目名塞进同一脏集合、同步 compose 并 flush，收集到的失败合并抛出组合错误（[packages/client/modules/src/index.ts:577-584](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L577-L584)）
- 构造函数以 `ctx.effect` 注册 `/plugins` 前缀路由，并订阅 `webserver/index-inject` 把 boot 注入行推入首页注入表（[packages/client/modules/src/index.ts:585-591](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L585-L591)）
- `graph()` 返回当前组合出的 boot 图，`clientPath(id)` 返回某行的 bundle 绝对路径（[packages/client/modules/src/index.ts:598-609](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L598-L609)）
- `artifactBaseline(id)` 返回读取 bundle 之前捕获的文件基线副本，供 HMR 装监听时比对（[packages/client/modules/src/index.ts:619-622](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L619-L622)）
- `rebuilt(id)` 重新捕获基线、重读 bundle 与映射并重算 rev；rev 未变则直接返回，变了才更新行、重组图、逐个通知重建订阅者（异常被 try/catch 记日志），最后广播图变更（[packages/client/modules/src/index.ts:630-655](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L630-L655)）
- `onRebuilt`/`onGraphChanged` 登记订阅者并返回各自的退订函数（[packages/client/modules/src/index.ts:662-676](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L662-L676)）
- `compose()` 先按模块图排序，再把 bootstrap 行与其余 application 行分别切分成批次并构建 combo 产物（[packages/client/modules/src/index.ts:678-694](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L678-L694)）
- `compose()` 为每个批次和每条单资源 combo 写入脚本与映射响应表，把上一代批次响应保留一代，并用图内容哈希作为图 rev（[packages/client/modules/src/index.ts:696-724](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L696-L724)）
- `notifyGraphChanged` 逐个调用图变更订阅者并吞掉各自异常记日志，防止一个订阅者阻断其余（[packages/client/modules/src/index.ts:726-736](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L726-L736)）
- `resolveMeta` 以「基址 + Loader 名」为键缓存解析结果，包括"不是 client 包"的否定结论（[packages/client/modules/src/index.ts:738-748](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L738-L748)）
- `resolveMeta` 读取 package.json 解析 `dsh.client`，`platform` 非 `web` 记为否定；声明了 `dsh.client` 却没有 `./client` 导出时抛错；否则拼出 clientPath 与归一化后的行字段（[packages/client/modules/src/index.ts:749-773](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L749-L773)）
- `locatePkgJson` 排除 `cordis:` 内建名，区分路径式与裸包名说明符，两者都不成立时判定为非 client 行（[packages/client/modules/src/index.ts:786-790](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L786-L790)）
- 没有 Loader 内部解析器时改走 `createRequire(baseUrl).resolve` 或按基址拼 URL 上溯，解析失败即判定为非 client 行（[packages/client/modules/src/index.ts:791-809](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L791-L809)）
- 有内部解析器时按 `v2`/其他两种签名调用 `resolveSync` 得到模块 URL，抛错即判定该名永久不是 client 行（[packages/client/modules/src/index.ts:810-820](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L810-L820)）
- `nearestPackage` 只接受 `file:` URL，从模块所在目录逐级上溯找声明了目标名字的 package.json，读不动或坏掉的中间清单被跳过（[packages/client/modules/src/index.ts:823-847](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L823-L847)）
- `captureArtifactBaseline` 在读字节前用 `statSync` 记下路径、mtime 与大小（[packages/client/modules/src/index.ts:854-861](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L854-L861)）
- `initialBundleSnapshot` 读取激活时的 bundle 与可选映射快照，ENOENT 转成 `MissingClientBundleError`，其他文件系统错误原样上抛（[packages/client/modules/src/index.ts:875-889](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L875-L889)）
- `readSourceMapSnapshot` 把损坏或格式非法的映射降级为"无映射"并记一条警告（[packages/client/modules/src/index.ts:892-899](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L892-L899)）
- `processOne` 只收集同名、已有 fiber 且未禁用的 Loader 条目作为活跃源，删除已消失的旧源，再逐个受影响的包名做协调，单包异常交给 onError（[packages/client/modules/src/index.ts:902-929](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L902-L929)）
- `resolveSource` 在条目所属配置树没有解析基址时抛错（[packages/client/modules/src/index.ts:931-940](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L931-L940)）
- `reconcilePackage` 在同一包名有多个活跃 Loader 源时抛错并列出来源；无源时删除表行；源键未变时不动；否则读快照、分配初始 rev 并写入新表行（[packages/client/modules/src/index.ts:942-972](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L942-L972)）
- `flush` 逐个消费脏名，单名异常交给 onError；表无变化则不重组；重组抛错时保留上一份可排序的图并把错误上报（[packages/client/modules/src/index.ts:974-1000](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L974-L1000)）
- `serveBundle` 对非 GET/HEAD 返回 405；命中当前或上一代批次响应时以不可变缓存头返回 200（HEAD 不带体）；其余 `/plugins` 请求返回 404（[packages/client/modules/src/index.ts:1002-1024](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L1002-L1024)）
- 默认导出 `ClientModuleRegistry`，使其成为可被 Loader 直接挂载的服务插件（[packages/client/modules/src/index.ts:1027](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/index.ts#L1027)）

### packages/client/modules/src/invariant.ts

本包的不变量伴生插件，注入 `invariants` 服务并在其上登记一条运行期检查。

- 导出插件名与 `inject = ['invariants']`，决定该伴生插件何时可以启动（[packages/client/modules/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/invariant.ts#L13-L15)）
- 安装器以 `global: true` 订阅 `internal/plugin`，在 `clientModules` 服务缺席时跳过审计（[packages/client/modules/src/invariant.ts:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/invariant.ts#L26-L29)）
- 遍历当前图的每一行，任何一行解析不出 client bundle 路径即报告失败（[packages/client/modules/src/invariant.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/invariant.ts#L30-L34)）
- `apply` 用包名向 `ctx.invariants` 注册安装器并返回其 disposer（[packages/client/modules/src/invariant.ts:43-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/src/invariant.ts#L43-L44)）

### packages/client/modules/tsconfig.json

包级 TypeScript 编译配置，声明源／输出目录、可用标准库与工程引用。

- 无运行期机制

### packages/client/modules/tsdown.config.ts

包级 tsdown 配置，选用共享的 client 双面构建预设。

- 以包名与 node 半入口 `lib/types/index.js`、`lib/types/invariant.js` 调用 `clientBundle`，产出 node 半 `lib/index.js`／`lib/invariant.js` 与浏览器 `lib/client.js`（后者由预设包上 `window.__ModuleLoader__.load` 的 banner／footer）（[packages/client/modules/tsdown.config.ts:1-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/modules/tsdown.config.ts#L1-L6)）
