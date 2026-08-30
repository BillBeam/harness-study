---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-reference
---

# packages/client/ui-reference

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、42 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-reference/README.md

该包的说明文档，描述统一 `@` 引用源的候选来源、排序、插入形态与失败行为。

- 无运行期机制

### packages/client/ui-reference/package.json

该包的 npm 清单，声明模块导出、浏览器半侧的装载声明与发布文件集。

- `main` 与 `types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-reference/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/package.json#L14-L15)）
- `exports` 暴露根入口、`./invariant`、`./client` 三个运行期子路径，外加 `./src/*` 与 `./package.json`（[packages/client/ui-reference/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/package.json#L16-L31)）
- `dsh.client` 声明浏览器半侧需要注入的五个服务包并把平台标为 `web`，装载器据此发现并挂载客户端插件（[packages/client/ui-reference/package.json:32-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/package.json#L32-L43)）
- `files` 限定发布内容为三个产物入口与类型声明（[packages/client/ui-reference/package.json:77-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/package.json#L77-L82)）

### packages/client/ui-reference/src/client/index.ts

浏览器半侧插件体，向输入触发器注册合并了文件与会话候选的 `@` 补全源。

- `inject` 列出该插件依赖的触发器注册表、语言包、连接、会话列表与两个 Remote 命名空间（[packages/client/ui-reference/src/client/index.ts:32-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L32-L35)）
- `apply` 用 `ctx.effect` 注册 zh／en 字典并绑定翻译函数（[packages/client/ui-reference/src/client/index.ts:42-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L42-L43)）
- 通过 `ctx.get` 取出连接句柄与会话服务，而不是走注入属性代理（[packages/client/ui-reference/src/client/index.ts:44-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L44-L45)）
- 源对象把触发字符定为 `@`、名字定为 `reference`，并关闭分组标题显示（[packages/client/ui-reference/src/client/index.ts:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L46-L49)）
- 文件候选走 `remote.fileReferences.list`，失败或非 ok 结果都折成空数组（[packages/client/ui-reference/src/client/index.ts:51-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L51-L54)）
- 处于引号形态时跳过会话查询，否则走 `remote.sessionReferenceResolver.candidates` 并同样把失败折成空数组（[packages/client/ui-reference/src/client/index.ts:55-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L55-L60)）
- 两路查询并行等待，signal 已中止时返回空列表（[packages/client/ui-reference/src/client/index.ts:61-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L61-L62)）
- 行是否附带位置信息由「本次列表是否有面包屑」反推（[packages/client/ui-reference/src/client/index.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L65)）
- 会话行的时间取自宿主会话列表快照里的 `updatedAt`，缺失时回落到候选自带的 `createdAt`（[packages/client/ui-reference/src/client/index.ts:66-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L66-L73)）
- 返回列表固定把文件候选排在会话候选之前（[packages/client/ui-reference/src/client/index.ts:69-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L69-L78)）
- `header` 把当前查询、引号状态与是否为下钻交给 `crumbsFor` 产出面包屑（[packages/client/ui-reference/src/client/index.ts:80-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L80-L82)）
- 目录行遇 `drill` 动作时只回填提及文本并让菜单继续打开（[packages/client/ui-reference/src/client/index.ts:84-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L84-L92)）
- 文件与文件夹的落定选择插入原子引用，目录的标签补尾部斜杠、外观分别为 `folder` 与 `file`，剪贴板文本用提及原文（[packages/client/ui-reference/src/client/index.ts:93-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L93-L102)）
- 会话选择插入外观为 `session` 的原子引用，`ref` 与剪贴板文本都用宿主返回的规范提及（[packages/client/ui-reference/src/client/index.ts:103-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L103-L113)）
- 无法识别的候选值返回 undefined，不产生任何插入（[packages/client/ui-reference/src/client/index.ts:114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L114)）
- `codec` 的剪贴板与序列化都恒等返回 `ref`，序列化不重建身份（[packages/client/ui-reference/src/client/index.ts:116-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L116-L119)）
- 通过 `ctx.effect` 把源注册进 `inputTriggers`，注册返回的处置器交给 effect 管理（[packages/client/ui-reference/src/client/index.ts:121-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L121-L122)）
- `crumbsFor` 仅在下钻且查询含 `/` 时产出面包屑，否则返回 undefined（[packages/client/ui-reference/src/client/index.ts:150-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L150-L153)）
- 面包屑首项是工作区根，其值携带按引号状态选出的 `@` 或 `@"` 前缀（[packages/client/ui-reference/src/client/index.ts:154-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L154-L157)）
- 逐段生成提及文本，任一段无法格式化就整体不出面包屑；最后一段标记 `current`（[packages/client/ui-reference/src/client/index.ts:158-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L158-L169)）
- `directoryValue` 把目录目的地序列化成与候选行同构的 JSON 负载（[packages/client/ui-reference/src/client/index.ts:174-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L174-L177)）
- 文件候选无法格式化成提及时被整行丢弃（[packages/client/ui-reference/src/client/index.ts:185-186](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L185-L186)）
- 行名取路径最后一段、目录补尾部斜杠；描述只在需要位置且父目录非空时给出父路径（[packages/client/ui-reference/src/client/index.ts:187-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L187-L201)）
- 行按类型选 `folder`／`file` 图标、归入文件分区，目录行额外带 `drill: true`（[packages/client/ui-reference/src/client/index.ts:202-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L202-L206)）
- 会话行的年龄由 `relativeTime` 分桶后交给字典渲染（[packages/client/ui-reference/src/client/index.ts:216-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L216-L217)）
- 同工作区的会话不显示位置，异工作区显示缩写后的 cwd，无 cwd 时显示专门文案（[packages/client/ui-reference/src/client/index.ts:220-222](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L220-L222)）
- 会话行描述在有位置时拼成「位置 · 年龄」，否则只有年龄，图标固定 `session` 并归入会话分区（[packages/client/ui-reference/src/client/index.ts:228-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L228-L234)）
- `parseCandidate` 把候选行携带的字符串按 JSON 还原成负载，值缺失时返回 undefined（[packages/client/ui-reference/src/client/index.ts:237-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/index.ts#L237-L240)）

### packages/client/ui-reference/src/client/locales.ts

`reference` 命名空间的中英文字典，由客户端插件体在启动时注册。

- `NS` 常量把该字典的命名空间固定为 `reference`，是 `ctx.locale.register` 与 `bind` 的查找键（[packages/client/ui-reference/src/client/locales.ts:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/locales.ts#L6)）
- zh 字典给出分区名、无 cwd 文案、根面包屑与六个时间桶的键集（[packages/client/ui-reference/src/client/locales.ts:15-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/locales.ts#L15-L26)）
- en 字典按 zh 的键集逐键给出对应取值（[packages/client/ui-reference/src/client/locales.ts:39-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/client/locales.ts#L39-L50)）

### packages/client/ui-reference/src/index.ts

该包的宿主半侧插件体。

- 导出空的 `apply`，使该包能作为宿主插件被装载器挂载，同时宿主侧不产生任何行为（[packages/client/ui-reference/src/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/index.ts#L9)）

### packages/client/ui-reference/src/invariant.ts

该包的运行期不变量伴生插件，向不变量服务登记包归属。

- 声明伴生插件名与其所需注入的 `invariants` 服务（[packages/client/ui-reference/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/invariant.ts#L13-L15)）
- 安装器为空函数，带上「无运行期不变量」的具体理由（[packages/client/ui-reference/src/invariant.ts:18-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/invariant.ts#L18-L22)）
- `apply` 以包名向 `ctx.invariants` 注册该安装器并返回其处置器（[packages/client/ui-reference/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/src/invariant.ts#L29-L30)）

### packages/client/ui-reference/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、输出目录与十三个工程引用。

- 无运行期机制

### packages/client/ui-reference/tsdown.config.ts

该包的打包配置，声明产物入口。

- 以客户端打包方式声明 `lib/types/index.js` 与 `lib/types/invariant.js` 两个入口，决定该包在运行期可加载的产物（[packages/client/ui-reference/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-reference/tsdown.config.ts#L3)）
