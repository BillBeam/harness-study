---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/web
---

# packages/client/web

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 14 个文件、43 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/web/README.md

浏览器启动内核包的说明文档，描述两段式启动、启动页与共享模块表。

- 无运行期机制

### packages/client/web/package.json

该包的 npm 清单，声明入口、导出映射与发布文件白名单。

- `main` 与 `types` 指向构建产物 `lib/index.js` 与类型声明（[packages/client/web/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/package.json#L14-L15)）
- `exports` 暴露包根、`./invariant` 伴生入口、`./src/*` 源码直取与 `./package.json` 四条解析路径（[packages/client/web/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/package.json#L16-L27)）
- `files` 白名单限定发布内容为两个 js 产物、全部 css 与类型声明（[packages/client/web/package.json:48-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/package.json#L48-L53)）

### packages/client/web/src/base.css

外壳挂载点的基础样式表，定义高度、字体族、配色与自动排版规则。

- 无运行期机制

### packages/client/web/src/boot-page.module.css

启动页的局部 CSS Module，定义卡片、字标、旋转指示器与失败列表的样式与动画。

- 无运行期机制

### packages/client/web/src/boot-page.ts

不依赖框架的启动页实现，用原生 DOM 展示插件激活进度与失败原因，由启动内核驱动。

- `div` 助手创建带类名的 div，并在传入文本时写入 `textContent`（[packages/client/web/src/boot-page.ts:10-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot-page.ts#L10-L15)）
- 构造时组装根节点、卡片、字标、指示器与提示行，打上 `data-dsh-boot` 与 `data-dsh-boot-spinner` 数据属性，追加到挂载容器并初始化进度（[packages/client/web/src/boot-page.ts:33-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot-page.ts#L33-L45)）
- `setTotal` 写入进度分母并立即刷新弧长（[packages/client/web/src/boot-page.ts:51-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot-page.ts#L51-L54)）
- `setState` 记录单条目状态，状态为 `active` 时计入已激活集合，然后刷新进度并重绘（[packages/client/web/src/boot-page.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot-page.ts#L61-L66)）
- `fail` 记录失败文本并触发重绘（[packages/client/web/src/boot-page.ts:72-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot-page.ts#L72-L75)）
- `dispose` 把根节点从文档中移除（[packages/client/web/src/boot-page.ts:78-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot-page.ts#L78-L80)）
- `render` 收集状态为 `failed` 的条目名；无失败时恢复「字标＋指示器＋提示」三节点，有失败时把卡片内容替换为标题加逐条失败项，并在末尾附上失败文本（[packages/client/web/src/boot-page.ts:83-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot-page.ts#L83-L96)）
- `updateProgress` 按已激活数与总数之比（上限 1）把 CSS 变量 `--dsh-boot-arc` 从 72 度线性增至 288 度（[packages/client/web/src/boot-page.ts:99-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot-page.ts#L99-L102)）

### packages/client/web/src/boot.ts

浏览器启动内核，负责模块系统构建、Cordis Loader 挂载、全插件激活审计与向 UI 渲染器移交挂载点。

- 构造时保存挂载容器与可选传输接缝，并立刻构造并挂上启动页（[packages/client/web/src/boot.ts:35-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L35-L39)）
- `run` 首先等待全局 `__DSH_BOOT_READY__` 的 promise，该全局缺失时不等待（[packages/client/web/src/boot.ts:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L54)）
- 缺少 `window.__ModuleLoader__` 门面时抛出具名错误（[packages/client/web/src/boot.ts:55-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L55-L59)）
- 读取全局 `__DSH_TRANSPORT__.loadBundle`，存在时作为默认包体传输注入模块系统创建参数，显式接缝仍覆盖它（[packages/client/web/src/boot.ts:65-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L65-L73)）
- 用宿主提供的启动图与静态模块表创建模块系统，并取出解析后的清单（[packages/client/web/src/boot.ts:68-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L68-L74)）
- 先发起首批预取（不等待），再新建 Context，依次跑插件启动与应用挂载（[packages/client/web/src/boot.ts:76-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L76-L80)）
- 任何启动异常被捕获后写入 `console.error`，并把消息渲染到启动页而非抛给调用方（[packages/client/web/src/boot.ts:81-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L81-L84)）
- `dispose` 先清空自身 ctx 引用并 dispose 其 fiber，再移除启动页（[packages/client/web/src/boot.ts:88-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L88-L93)）
- `mountApp` 通过 `ctx.inject(['uiRenderer'])` 建立依赖 fiber，并在其 effect 中把容器交给渲染器挂载，使替换渲染器时重新挂载（[packages/client/web/src/boot.ts:96-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L96-L101)）
- `prefetchImmediateTier` 只对清单中标了 `immediately` 的行发起预取，且并发吞掉每个预取错误（[packages/client/web/src/boot.ts:104-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L104-L110)）
- `runPluginBoot` 挂载 Loader 插件并把模块系统赋给 `loader.internal`（[packages/client/web/src/boot.ts:114-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L114-L116)）
- 订阅 `internal/status` 事件，把有 entry 与 fiber 的状态变化投影为启动页上对应条目的状态标签（[packages/client/web/src/boot.ts:118-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L118-L122)）
- 把清单插件数设为启动页进度分母，等待预取完成后并发创建每个 Loader 条目，创建后 fiber 仍缺失则标记为 failed（[packages/client/web/src/boot.ts:124-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L124-L131)）
- 等待 `loader.await()` 静默后再执行激活审计（[packages/client/web/src/boot.ts:133-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L133-L134)）
- `assertEntriesActive` 遍历全部 Loader 条目：fiber 缺失记为导入失败；状态为 pending 时列出 `ctx.get` 取不到的注入服务名；其他非 active 状态记录状态标签（[packages/client/web/src/boot.ts:138-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L138-L154)）
- 存在任一未激活条目时抛出一条聚合错误，逐行列出每个失败条目（[packages/client/web/src/boot.ts:155-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/boot.ts#L155-L157)）

### packages/client/web/src/css-modules.d.ts

CSS Modules 与普通 CSS 导入的 TypeScript 环境声明文件。

- 无运行期机制

### packages/client/web/src/index.ts

该包的库入口，重导出启动类、静态模块表与平台模块常量。

- 无运行期机制

### packages/client/web/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属。

- 导出插件名与 `inject = ['invariants']`，声明该伴生插件在 invariants 服务就绪后才激活（[packages/client/web/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/invariant.ts#L13-L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/client/web/src/invariant.ts:23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/invariant.ts#L23)）
- `apply` 以包名调用 `ctx.invariants.register` 并返回其 disposer（[packages/client/web/src/invariant.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/invariant.ts#L30-L31)）

### packages/client/web/src/loader-status.ts

Loader fiber 状态到启动页文字标签的投影表，供启动内核与启动页共用。

- 以数值常量对象镜像 cordis 的 `FiberState` const enum，使运行期存在可读取的状态值（[packages/client/web/src/loader-status.ts:15-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/loader-status.ts#L15-L22)）
- `STATE_LABELS` 以状态成员为键给出六个小写标签，启动页显示与激活审计的分支都读它（[packages/client/web/src/loader-status.ts:28-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/loader-status.ts#L28-L35)）

### packages/client/web/src/platform.ts

共享浏览器平台模块的常量清单，被静态模块表种子、打包外部化与构建别名共同消费。

- `PLATFORM_MODULES` 列出外壳共享进冻结模块表的八个模块标识（React 系、cordis 与三个客户端包），动态包体的外部依赖按这一集合解析（[packages/client/web/src/platform.ts:8-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/platform.ts#L8-L13)）
- `PRELOADED_CLIENT_EXTERNALS` 目前为空数组，即解析器预载工厂这一行没有条目（[packages/client/web/src/platform.ts:16-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/platform.ts#L16-L17)）

### packages/client/web/src/seed.ts

交给模块加载器的静态模块表构造函数，保证所有动态包体拿到同一份模块实例。

- 以外壳静态 import 引入 React 系、cordis 与三个客户端包，使它们成为进程内单例（[packages/client/web/src/seed.ts:9-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/seed.ts#L9-L16)）
- `getStaticModules` 返回「模块标识 → 模块命名空间」的表，并用 `satisfies Record<PlatformModule, unknown>` 把键集合钉到平台常量上（[packages/client/web/src/seed.ts:23-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/src/seed.ts#L23-L37)）

### packages/client/web/tsconfig.json

该包客户端面的 TypeScript 编译配置，声明源码根、类型输出目录、工程引用与排除项。

- 无运行期机制

### packages/client/web/tsdown.config.ts

该包的打包配置，复用客户端「静态链接」打包工厂。

- 以包名与两个入口（index 与 invariant）调用静态链接打包工厂，决定该包在运行期可被加载的产物文件（[packages/client/web/tsdown.config.ts:3-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/web/tsdown.config.ts#L3-L6)）
