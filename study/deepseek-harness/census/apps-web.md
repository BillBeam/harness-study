---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · apps/web
---

# apps/web

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、52 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### apps/web/package.json

浏览器前端应用的清单，声明产物导出、发布内容与构建脚本；产物由 CLI 的 web 运行器静态托管。

- `type: module` 让包内文件以 ESM 解析（[apps/web/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/package.json#L13)）
- `exports` 只暴露 `./dist/*` 与自身清单，其他路径不可从包名解析（[apps/web/package.json:14-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/package.json#L14-L17)）
- `files` 发布 `dist` 但排除 sourcemap、`preview.html` 与 `preview` 目录（[apps/web/package.json:18-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/package.json#L18-L23)）
- `scripts` 定义构建、开发、增量监视三条 vite 命令，其中 `watch` 带 `--no-emptyOutDir`（[apps/web/package.json:24-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/package.json#L24-L27)）
- `build:preview` 依次构建 worker 运行时与打包器、执行 vite 构建，再生成 `dist/preview/vfs-image.tar.gz` 镜像（[apps/web/package.json:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/package.json#L28)）
- `serve:preview` 以关闭缓存的静态服务器在 4173 端口对外提供 `dist`（[apps/web/package.json:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/package.json#L29)）

### apps/web/src/main.ts

浏览器端的常规入口模块，被 `index.html` 的模块脚本加载。

- 找不到 `#root` 元素时抛出错误，页面不再继续启动（[apps/web/src/main.ts:4-5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/src/main.ts#L4-L5)）
- 以该元素构造客户端应用入口并运行（[apps/web/src/main.ts:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/src/main.ts#L6)）

### apps/web/src/node-module-stub.ts

浏览器构建中替换 `node:module` 的桩模块，由 vite 的别名规则指向。

- `createRequire` 被调用时直接抛错，而不是返回一个不可用的实现（[apps/web/src/node-module-stub.ts:6-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/src/node-module-stub.ts#L6-L9)）

### apps/web/src/preview.ts

worker 预览页面的引导模块，作为独立打包入口产出，被 `preview.html` 插在常规入口脚本之前。

- 把镜像文件路径固定为 `preview/` 目录下的约定文件名（[apps/web/src/preview.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/src/preview.ts#L12)）
- 在 Cordis 启动之前先跑一次来源选择，得到镜像与叠加层（[apps/web/src/preview.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/src/preview.ts#L13)）
- 新建名为 `dsh-host` 的 Worker 并完成连接握手，把镜像与叠加层交给它（[apps/web/src/preview.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/src/preview.ts#L14)）

### apps/web/src/vite-env.d.ts

一行三斜线指令文件，为客户端源码引入构建工具的环境类型。

- 无运行期机制

### apps/web/stress-tests/reasoning-chunks.stress.ts

一个可选的浏览器压力用例，用真实浏览器驱动前端渲染十万条推理片段并测量主线程延迟。

- 用常量固定片段总数十万、每批 128 条、批间隔 16 毫秒与 250 毫秒的主线程延迟上限（[apps/web/stress-tests/reasoning-chunks.stress.ts:13-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L13-L16)）
- 启动服务脚手架，并按环境变量 `DSH_WEB_STRESS_HEADFUL` 决定浏览器是否无头（[apps/web/stress-tests/reasoning-chunks.stress.ts:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L51-L53)）
- 页面加载前注入脚本，把当前会话写进 `localStorage`（[apps/web/stress-tests/reasoning-chunks.stress.ts:55-57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L55-L57)）
- 挂上控制台监视器，并在用例失败时保存截图（[apps/web/stress-tests/reasoning-chunks.stress.ts:58-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L58-L59)）
- 带 `?fixture` 打开页面并等待外框与样例元素出现（[apps/web/stress-tests/reasoning-chunks.stress.ts:60-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L60-L66)）
- 注入一段样式隐藏引导浮层，被测的对话树本身仍保持挂载（[apps/web/stress-tests/reasoning-chunks.stress.ts:65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L65)）
- 在页面里装一个 50 毫秒定时器探针记录最大心跳偏差，并挂一个一秒后派发的自定义事件用来测交互处理延迟（[apps/web/stress-tests/reasoning-chunks.stress.ts:68-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L68-L93)）
- 通过页面暴露的钩子启动片段风暴，钩子缺失时抛错（[apps/web/stress-tests/reasoning-chunks.stress.ts:95-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L95-L103)）
- 等待处于运行态的推理行出现，轮询已发出片段数达到总数，再轮询该行文本包含返回的标记（[apps/web/stress-tests/reasoning-chunks.stress.ts:105-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L105-L111)）
- 回收探针数据、清掉定时器，并把心跳与交互延迟折算成一份报告；探针或状态缺失时抛错（[apps/web/stress-tests/reasoning-chunks.stress.ts:113-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L113-L133)）
- 把报告以一行 JSON 写到标准输出（[apps/web/stress-tests/reasoning-chunks.stress.ts:134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L134)）
- 断言报告中的片段配置与实际发出数一致、心跳采样数大于零（[apps/web/stress-tests/reasoning-chunks.stress.ts:136-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L136-L142)）
- 交互未被处理时抛错，并断言最大主线程延迟与交互延迟都低于预算（[apps/web/stress-tests/reasoning-chunks.stress.ts:143-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L143-L146)）
- 断言运行过程中没有页面错误与控制台警告（[apps/web/stress-tests/reasoning-chunks.stress.ts:147-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L147-L148)）
- `finally` 中无论成败都关闭浏览器与脚手架，整个用例超时设为 600000 毫秒（[apps/web/stress-tests/reasoning-chunks.stress.ts:149-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/stress-tests/reasoning-chunks.stress.ts#L149-L153)）

### apps/web/tsconfig.json

前端包的 TypeScript 项目配置，声明源码根、JSX 模式、类型库、排除清单与对客户端工作区项目的引用。

- 无运行期机制

### apps/web/vite.config.ts

前端构建配置，除切分产物外还改写页面、拦截独立启动方式、生成预览页并替换若干全局取值。

- `src` 帮助函数把相对路径解析成基于本文件 URL 的绝对文件路径（[apps/web/vite.config.ts:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L8)）
- `escapeHtmlText` 在把文本放进标题元素前转义 `&`、`<`、`>`（[apps/web/vite.config.ts:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L15-L17)）
- 标题插件从环境变量 `DSH_CLIENT_TITLE` 取值（缺省用固定串），在 `transformIndexHtml` 阶段替换初始 HTML 里的标题（[apps/web/vite.config.ts:20-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L20-L28)）
- 当命令是 `serve` 时在配置阶段直接抛错，阻止起一个缺少启动清单注入的服务（[apps/web/vite.config.ts:31-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L31-L38)）
- 预览页插件在 `generateBundle` 阶段找出名为 `bootstrap` 的入口块文件名，找不到即抛错（[apps/web/vite.config.ts:47-56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L47-L56)）
- `closeBundle` 阶段读回已构建的 `dist/index.html`，把引导脚本标签插在第一个模块脚本标签之前写成 `dist/preview.html`；找不到锚点则抛错（[apps/web/vite.config.ts:57-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L57-L65)）
- 用一份精确的 npm 包名集合圈定进入 vendor 块的依赖（数学、语法高亮、markdown 解析家族）（[apps/web/vite.config.ts:89-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L89-L109)）
- 单列三个启动期静态引入的语法文件，使它们进 vendor 而按需语法保持各自独立块（[apps/web/vite.config.ts:118-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L118-L122)）
- `npmPackageOf` 取模块 id 里最后一个 `node_modules/` 之后的包名，跳过以点开头的存储层级并处理 scope 包（[apps/web/vite.config.ts:131-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L131-L138)）
- `base` 设为 `./`，产物用相对 URL 引用资源（[apps/web/vite.config.ts:140-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L140-L142)）
- 插件顺序为：拒绝独立服务、改标题、React、产出预览页（[apps/web/vite.config.ts:144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L144)）
- 构建目标提到 es2022 以容纳顶层 await，并开启 sourcemap（[apps/web/vite.config.ts:145-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L145-L149)）
- 声明 `index` 与 `bootstrap` 两个独立入口，使预览引导不混进页面共享块（[apps/web/vite.config.ts:150-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L150-L157)）
- 入口文件名按名称分流：`bootstrap` 落到 `preview/`，其余落到 `assets/`（[apps/web/vite.config.ts:162-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L162-L164)）
- 非入口块按成员模块判定是否为语法块并归到 `assets/langs/`，`index` 与 `vendor` 按名排除（[apps/web/vite.config.ts:170-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L170-L179)）
- 资源文件名按扩展名把字体归到 `assets/fonts/`，其余归到 `assets/`（[apps/web/vite.config.ts:180-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L180-L184)）
- `manualChunks` 让工作区代码留在默认块，语法包只把三个启动语法文件放进 vendor，其余按集合命中归 vendor（[apps/web/vite.config.ts:185-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L185-L192)）
- worker 产物的入口文件名同样落到 `preview/`（[apps/web/vite.config.ts:196-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L196-L199)）
- `dedupe` 强制 react 与 react-dom 只保留一份实例（[apps/web/vite.config.ts:208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L208)）
- 别名把 `node:module` 指向本包的浏览器桩模块（[apps/web/vite.config.ts:215-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L215-L217)）
- `define` 注入客户端构建环境常量（[apps/web/vite.config.ts:219-220](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L219-L220)）
- 把 `process.versions.node` 定义为 `"0.0.0"`、`process.execArgv` 定义为空数组，使被引入的加载器代码走不进任何 Node 分支（[apps/web/vite.config.ts:221-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L221-L225)）
- 把 `process.env.CORDIS_SHARED` 定义为 `undefined`，使加载器落到默认分支（[apps/web/vite.config.ts:226-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/apps/web/vite.config.ts#L226-L227)）
