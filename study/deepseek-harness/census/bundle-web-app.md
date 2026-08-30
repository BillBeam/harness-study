---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/bundle/web-app
---

# packages/bundle/web-app

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、90 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/bundle/web-app/README.md

该包的说明文档，描述浏览器界面的启动方式、命令行标志、可信主机、SSH 行为与实现分工。

- 无运行期机制

### packages/bundle/web-app/cordis.patch.yml

该 bundle 的 patch 层，叠加在基础 bundle 之上：重述基础层省略的面向本 surface 的配置、插入 Web 专属的宿主行与浏览器插件名册，再把 agent 平面移到 preset 之后。

- 重述系统提示行的人格文本，其中带 `{{model}}` 与 `{{cwd}}` 占位（[packages/bundle/web-app/cordis.patch.yml:16-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L16-L20)）
- 会话查询行使用 `:memory:` 且 `openAt: never`，把全文检索留作后续层显式开启（[packages/bundle/web-app/cordis.patch.yml:22-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L22-L29)）
- 工具行的呈现模式取 `DSH_TOOLS_MODE` 环境变量，未设时落回 schema 默认（[packages/bundle/web-app/cordis.patch.yml:31-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L31-L37)）
- 插入子 agent 模型选择的设置命名空间行（[packages/bundle/web-app/cordis.patch.yml:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L43-L47)）
- 插入 worker 线程代码运行时行（[packages/bundle/web-app/cordis.patch.yml:49-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L49-L50)）
- 插入消息反馈行，备注字节上限 8192（[packages/bundle/web-app/cordis.patch.yml:52-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L52-L55)）
- 插入会话日志导出行，提供 `/export` 命令与下载对话框（[packages/bundle/web-app/cordis.patch.yml:57-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L57-L59)）
- 插入工作区、会话引用与本地文件引用三行（[packages/bundle/web-app/cordis.patch.yml:61-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L61-L68)）
- 插入会话统计行，为聊天统计条提供整段日志的轮次/步数投影（[packages/bundle/web-app/cordis.patch.yml:70-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L70-L73)）
- 插入自动目录选择器行，在启动时一次性判定绑定主机、SSH 启动与显示条件（[packages/bundle/web-app/cordis.patch.yml:75-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L75-L79)）
- 插入插件清单只读投影行，供受信任的客户端 RPC 读取当前 Loader 条目（[packages/bundle/web-app/cordis.patch.yml:81-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L81-L83)）
- 插入会话、设置、工作区三个 Remote 控制器行（[packages/bundle/web-app/cordis.patch.yml:85-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L85-L96)）
- 插入宿主侧 cordis 运行器行（[packages/bundle/web-app/cordis.patch.yml:98-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L98-L99)）
- 插入 `web-startup` 行，它注入 `cmdlineArgs` 并把解析后的 Web 标志作为普通服务提供出去（[packages/bundle/web-app/cordis.patch.yml:101-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L101-L104)）
- Web 服务器行注入 `webStartup`，主机取 `ctx.webStartup.host` 否则 `127.0.0.1`，端口取 `ctx.webStartup.port` 否则 3080（[packages/bundle/web-app/cordis.patch.yml:110-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L110-L117)）
- Web 服务器行开启 gzip，压缩级别 1，阈值 1024 字节（[packages/bundle/web-app/cordis.patch.yml:118-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L118-L119)）
- `web-runtime` 行注入 `webStartup`，把 `openBrowser` 与 `trustedHosts` 从该服务取值，`printUrl` 与 `surfaceContext` 固定为 true（[packages/bundle/web-app/cordis.patch.yml:130-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L130-L137)）
- 插入客户端插件热重载链，作为独立行常驻（[packages/bundle/web-app/cordis.patch.yml:139-144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L139-L144)）
- 插入 `modules` 双面行：node 半扫描本树组成 `window.__DSH_BOOT__` 并按 `/plugins/<id>/client.js` 提供模块（[packages/bundle/web-app/cordis.patch.yml:146-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L146-L153)）
- `connection` 行注入 `webRuntime`，其 `trustedHosts` 直接取 `ctx.webRuntime.trustedHosts`，即 `/api` 信任栅栏的权威列表（[packages/bundle/web-app/cordis.patch.yml:155-164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L155-L164)）
- 插入 API remotes 与客户端侧 cordis 运行器（[packages/bundle/web-app/cordis.patch.yml:166-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L166-L170)）
- 插入主题、语言、布局、渲染器、会话、侧栏与设置页等基础浏览器 UI 行（[packages/bundle/web-app/cordis.patch.yml:172-200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L172-L200)）
- 插入会话、审批、聊天、品牌位、附件与工具调用树等对话面 UI 行（[packages/bundle/web-app/cordis.patch.yml:202-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L202-L224)）
- 插入工作流运行行与轮次尾部的产出文件行，移除后者尾槽渲染为空（[packages/bundle/web-app/cordis.patch.yml:226-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L226-L233)）
- 插入工作区面板与 `/`、`@` 输入触发管线及其命令、技能、子 agent、引用来源行（[packages/bundle/web-app/cordis.patch.yml:236-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L236-L254)）
- 插入后台任务列表、目标栏、消息反馈条与模型选择器（`/model` 与输入区座位）行（[packages/bundle/web-app/cordis.patch.yml:256-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L256-L271)）
- 插入权限预设、agent preset 设置项、插件配置卡片、计划座位、用户提问与轨迹面板行（[packages/bundle/web-app/cordis.patch.yml:273-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L273-L294)）
- 禁用基础层的 `tool-bash` 与 `tool-pwsh` 两行，改由每会话的 preset 提供（[packages/bundle/web-app/cordis.patch.yml:313-317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L313-L317)）
- 禁用 `tool-jobs`，后台任务注册表本身仍留在宿主平面（[packages/bundle/web-app/cordis.patch.yml:319-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L319-L330)）
- 禁用文件系统、文件搜索与字符串替换编辑器三个工具行（[packages/bundle/web-app/cordis.patch.yml:332-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L332-L339)）
- 禁用宿主的 `skill-filesystem` 与 `tool-skill`，技能发现与目录/加载器交给 preset 层（[packages/bundle/web-app/cordis.patch.yml:341-354](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L341-L354)）
- 禁用 `command-goal`、`tool-goal` 与 `plan-mode`（[packages/bundle/web-app/cordis.patch.yml:356-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L356-L366)）
- 禁用压缩后端、`/compact` 命令与工具结果裁剪器，token 计量表仍留在宿主平面（[packages/bundle/web-app/cordis.patch.yml:368-382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L368-L382)）
- 禁用四个子 agent 委派工具行，注册表与其后端仍留在宿主平面（[packages/bundle/web-app/cordis.patch.yml:384-402](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L384-L402)）
- 禁用工作流 worker、`tool-workflow`、`tool-ralph`、`agent-instructions`、`tool-todo` 与 `tool-web`（[packages/bundle/web-app/cordis.patch.yml:409-425](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L409-L425)）
- 插入 agent preset 名册行并把默认 preset 设为 `standard`（[packages/bundle/web-app/cordis.patch.yml:427-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/cordis.patch.yml#L427-L438)）

### packages/bundle/web-app/package.json

该 bundle 包的 npm 清单，声明入口、导出面、patch 位置与全部被 patch 引用的工作区依赖。

- `type: module`、`main`、`types` 决定该包在运行期以 ESM 从 `lib/index.js` 加载（[packages/bundle/web-app/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/package.json#L13-L15)）
- `exports` 开放根入口、`./startup` 子入口（patch 中 `web-startup` 行按此名解析）、`./invariant`、`./cordis.patch.yml` 与 `./src/*`（[packages/bundle/web-app/package.json:16-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/package.json#L16-L32)）
- `files` 限定发布产物为三个 js 入口、patch 文件与类型声明（[packages/bundle/web-app/package.json:33-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/package.json#L33-L39)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，profile 组合器据此解析该 bundle 贡献的 patch 层（[packages/bundle/web-app/package.json:41-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/package.json#L41-L45)）
- `dependencies` 列出 patch 内每一行插件与前端 dist、`open` 启动器、`commander` 等运行期依赖，决定这些行与子进程可被解析（[packages/bundle/web-app/package.json:46-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/package.json#L46-L117)）

### packages/bundle/web-app/src/index.ts

该 bundle 的运行期粘合插件：解析前端 dist、采样局域网信任、注册面向模型的提示段与 shell 变量、打印启动 URL 并把默认浏览器指向该 URL。

- 声明插件名 `web-app`（[packages/bundle/web-app/src/index.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L32)）
- 由 `import.meta.url` 上溯四级得到本安装的源码根，用作 harness 源码提示段的路径（[packages/bundle/web-app/src/index.ts:34-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L34-L35)）
- 用 `WeakSet` 按 root context 记录已播报，避免重复打印与重复开浏览器（[packages/bundle/web-app/src/index.ts:36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L36)）
- 声明注入 `webServer`，本行在 Web 服务器服务就绪前不挂载（[packages/bundle/web-app/src/index.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L42)）
- Config schema 给 `openBrowser`、`printUrl`、`surfaceContext` 默认 true，`trustedHosts` 默认空数组（[packages/bundle/web-app/src/index.ts:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L61-L66)）
- 定义 `DSH_WEB_URL` 变量名与展示用的回环地址、全接口绑定字面量（[packages/bundle/web-app/src/index.ts:76-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L76-L83)）
- `launchedThroughSsh` 只从 `process` 来源读取 `SSH_CONNECTION`/`SSH_TTY`，任一非空即判定为 SSH 启动（[packages/bundle/web-app/src/index.ts:85-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L85-L92)）
- 内联的浏览器启动子程序动态导入 `open` 并把 `process.argv[1]` 交给系统（[packages/bundle/web-app/src/index.ts:94-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L94-L99)）
- 该子程序在 win32 上保持 launcher 引用并等待其 `close`，非零退出码抛错（[packages/bundle/web-app/src/index.ts:100-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L100-L116)）
- 该子程序捕获异常写 stderr 并把 `process.exitCode` 置 1，由父进程转成手动 URL 警告（[packages/bundle/web-app/src/index.ts:117-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L117-L123)）
- `resolveLanTrust` 仅在绑定为 `0.0.0.0` 时枚举网络接口，取非内部 IPv4 字面量，否则给出空列表（[packages/bundle/web-app/src/index.ts:135-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L135-L140)）
- `resolveLanTrust` 返回的 `trustedHosts` 为局域网字面量后接调用方显式传入的权威（[packages/bundle/web-app/src/index.ts:141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L141)）
- `webSurfacePrompt` 组装模型可见的界面定位文本：GUI 地址、"这个页面"的指代、无 DOM/路由/截图上下文（[packages/bundle/web-app/src/index.ts:144-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L144-L151)）
- 该文本还写入更新契约与"不要另起替代服务器、必要时用受管后台任务并核对 URL"的指示（[packages/bundle/web-app/src/index.ts:146-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L146-L156)）
- `localWebUrl` 从 `webServer` 服务读端口拼回环 URL，服务缺失时抛错（[packages/bundle/web-app/src/index.ts:158-163](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L158-L163)）
- `resolveDistIndex` 以前端包清单为锚点解析 `dist/index.html`，解析不到时抛出组合错误（[packages/bundle/web-app/src/index.ts:172-180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L172-L180)）
- `spawnBrowserLauncher` 以 `--input-type=module --eval` 起新 Node 进程，环境用 `scrubbedParentEnv()`，stdout 继承、stderr 管道（[packages/bundle/web-app/src/index.ts:182-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L182-L192)）
- `openBrowser` 收集子进程 stderr，非零退出时取首行并剥掉 `XxxError:` 前缀作为拒绝原因（[packages/bundle/web-app/src/index.ts:195-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L195-L214)）
- 退出码为 0 但有 stderr 时，把这些内容原样转写到本进程 stderr（[packages/bundle/web-app/src/index.ts:215-216](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L215-L216)）
- 导出 `internals` 把 dist 解析与浏览器移交做成可替换钩子（[packages/bundle/web-app/src/index.ts:223-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L223-L227)）
- `apply` 在挂载时按当前绑定主机采样一次局域网信任（[packages/bundle/web-app/src/index.ts:235-236](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L235-L236)）
- 浏览器移交条件为 `config.openBrowser` 且非 SSH 启动（[packages/bundle/web-app/src/index.ts:237-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L237-L239)）
- 以 `ctx.provide` 提供 `webRuntime` 服务，依赖它的行在这次采样之后才被释放（[packages/bundle/web-app/src/index.ts:240-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L240-L241)）
- 以解析出的 dist 索引挂载前端静态兜底子插件（[packages/bundle/web-app/src/index.ts:242](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L242)）
- `surfaceContext` 为真时注册 harness 源码提示段，并按第一方顺序常量注册 `app:web-surface` 提示段，其文本每次取值时重算 URL（[packages/bundle/web-app/src/index.ts:243-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L243-L251)）
- `surfaceContext` 为真时还向 `shellEnv` 注册 `DSH_WEB_URL` 变量与描述，其值按调用逐次从活动服务解析（[packages/bundle/web-app/src/index.ts:252-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L252-L260)）
- 仅在需要打印 URL 或需要开浏览器时才注入 `connection`（[packages/bundle/web-app/src/index.ts:262-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L262-L263)）
- `announceReady` 先查 root 是否已播报，再用 `connection.authenticatedUrl` 生成带进程令牌的根 URL（[packages/bundle/web-app/src/index.ts:269-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L269-L273)）
- 局域网 URL 复用同一次采样的首个地址与当前端口，同样带令牌（[packages/bundle/web-app/src/index.ts:274-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L274-L279)）
- 打印 `dsh web: <URL>` 行，存在局域网地址时附加 `(LAN: ...)`（[packages/bundle/web-app/src/index.ts:280-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L280-L282)）
- 移交浏览器前打印提示行，失败时把原因写成 stderr 警告并保持服务器继续运行（[packages/bundle/web-app/src/index.ts:283-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L283-L289)）
- 无 Loader 时立即播报，有 Loader 时等其 `await()` 结算后再播报（[packages/bundle/web-app/src/index.ts:294-297](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L294-L297)）
- 结算后重新确认 `webServer` 与 `connection` 仍在，否则不播报；Loader 报告启动失败时静默（[packages/bundle/web-app/src/index.ts:298-306](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/index.ts#L298-L306)）

### packages/bundle/web-app/src/invariant.ts

该包的 invariant companion 插件，向 `invariants` 服务登记本包名。

- 声明 companion 插件名 `web-app-invariant`（[packages/bundle/web-app/src/invariant.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/invariant.ts#L12)）
- 声明注入 `invariants`，该服务缺席时 companion 不挂载（[packages/bundle/web-app/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/invariant.ts#L14)）
- installer 为空实现，注册后不安装任何检查（[packages/bundle/web-app/src/invariant.ts:16-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/invariant.ts#L16-L22)）
- `apply` 以包名调用 `ctx.invariants.register` 并返回其 disposer（[packages/bundle/web-app/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/invariant.ts#L29-L30)）

### packages/bundle/web-app/src/startup.ts

该包的命令行提供者插件：解析 Web profile 的标志族并把结果作为 `webStartup` 服务提供给 patch 中依赖它的行。

- 声明插件名 `web-startup`（[packages/bundle/web-app/src/startup.ts:13-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L13-L14)）
- 声明注入 `cmdlineArgs`，命令行服务就绪前不解析（[packages/bundle/web-app/src/startup.ts:16-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L16-L17)）
- 把提供的服务名固定为 `webStartup`（[packages/bundle/web-app/src/startup.ts:19-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L19-L20)）
- 定义 `--host`、`--no-open`、`--port`（可传 0 让系统挑端口）、可重复的 `--trusted-host` 四个标志与 `-h, --help`（[packages/bundle/web-app/src/startup.ts:46-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L46-L54)）
- 追加用户可见的示例帮助文本（[packages/bundle/web-app/src/startup.ts:55-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L55-L60)）
- 每次调用返回全新的 program 实例，使同一进程内可多次解析（[packages/bundle/web-app/src/startup.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L44-L47)）
- `--host 0.0.0.0` 被当作用法错误直接报错终止（[packages/bundle/web-app/src/startup.ts:74-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L74-L76)）
- 非纯数字的 `--port` 被当作用法错误直接报错终止（[packages/bundle/web-app/src/startup.ts:77-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L77-L79)）
- 校验通过后提供 `webStartup`：`openBrowser` 取 `--no-open` 的反面，`host`/`port` 只在被指定时出现，`port` 转数字，`trustedHosts` 缺省为空数组（[packages/bundle/web-app/src/startup.ts:80-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L80-L85)）
- 用 `parseCmdline` 驱动解析；`--help` 或解析失败时该服务不被提供（[packages/bundle/web-app/src/startup.ts:87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/web-app/src/startup.ts#L87)）

### packages/bundle/web-app/tsconfig.json

该包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 与工程引用。

- 无运行期机制
