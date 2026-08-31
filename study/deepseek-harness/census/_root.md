---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · 仓库根目录与未归入工作区包的文件
---

# 仓库根目录与未归入工作区包的文件

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 88 个文件、325 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### AGENTS.md

仓库根部的智能体指令文件，被在本仓库工作的编码智能体读入上下文，同时是 `packages/context/agent-instructions` 那类工作区指令加载器识别的文件名之一。

- 声明后端拒绝旧的磁盘格式，SQLite 用单调递增的 `SCHEMA_VERSION`，会话格式版本固定在 `0` 且不承诺兼容（[AGENTS.md:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L7)）
- 规定只有 `dsh` profile 可以启动受支持的 Node 应用，包 bin、demo 与公共 SDK 的 argv 逃逸被禁止（[AGENTS.md:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L9)）
- 给出智能体可执行的命令清单：安装、清理、单测、覆盖率门、真实 API 测试、期望输出、无密钥录制会话回放及其重录、类型检查、lint、克隆检测、构建、hygiene、doc-sync、站点构建、从源码跑一次任务（[AGENTS.md:64-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L64-L84)）
- 规定命令因沙箱阻断而失败时以最窄的宿主提权原样重试，要求沙箱证据，不得绕过测试失败或产品沙箱（[AGENTS.md:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L88)）
- 规定推送前只跑覆盖改动面的检查、只报告实际跑过的命令，不默认跑全量，并指定 `test:coverage` 而非 `test` 为覆盖率门（[AGENTS.md:92-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L92-L96)）
- 声明真实 API 测试与 demo 读取 `DEEPSEEK_API_KEY`、可选 `DEEPSEEK_BASE_URL` 与根 `.env`，并限定 `cordis.yml` 只在插件 `config` 与条目 `disabled` 下允许 `!!js`（[AGENTS.md:100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L100)）
- 规定全仓 ESM、跨包用包名、本地相对导入带 `.ts`，`dsh` 源码启动经 tsx 的 ESM-only hook，所经模块不得是 CJS-only（[AGENTS.md:105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L105)）
- 规定每项贡献都经 `ctx.effect()` / `ctx.on()` 注册，注册表的 `register()` 返回 disposer（[AGENTS.md:106](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L106)）
- 规定会话事件表的每个成员在读取时必需，不认识其类型的构建拒绝该日志，只有结构性格式变更才升会话格式版本（[AGENTS.md:108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L108)）
- 规定 waterfall 监听器必须调用 `next()` 才会向下委派，直接返回会短路整条链（[AGENTS.md:110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L110)）
- 规定模型可见与已记录互为充要：任何进入模型请求的内容都要能从会话日志重建，新增模型可见输入必须伴随一个会话事件（[AGENTS.md:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L111)）
- 规定新行为挂在扩展点上，改动 `agent-loop` 必须同时更新架构文档（[AGENTS.md:112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L112)）
- 禁止插件里硬编码可调参数：随部署变化的选择必须是可从 `cordis.yml` 改的受校验 `Config` 字段，协议常量、外部规范与安全不变量保持固定（[AGENTS.md:116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L116)）
- 规定配置错误在自洽时于加载期大声失败，否则在最早可解析处失败，绝不静默跳过缺失的被引用者（[AGENTS.md:117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L117)）
- 划定运行期校验只加在解析器/配置、排队、模型与工具 JSON、持久化文件、worker、进程、线路这些边界上（[AGENTS.md:119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L119)）
- 规定每个非平凡的模型可见或用户可见变更都要更新一份无密钥录制会话快照，且 fixture 在 macOS/Linux 上重放（[AGENTS.md:128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L128)）
- 规定循环、会话生命周期与会话事件表的改动要在同一 PR 内更新 TypeScript 与 Python 两个 SDK 的期望输出（[AGENTS.md:131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L131)）
- 规定历史改写用 `--force-with-lease`、远端移动即中止、禁止裸 `--force`（[AGENTS.md:132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L132)）
- 规定文件以且仅以一个换行结尾，由 pre-commit 的 `git diff --cached --check` 把关（[AGENTS.md:135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L135)）
- 规定全量 `strict` 与 `noImplicitAny` 编译，导出 JSDoc 由 `verify-export-jsdoc` 强制，并规定只有用户显式调用才允许跑翻译流程（[AGENTS.md:143-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L143-L147)）
- 声明根与 `packages/` 下的 `CLAUDE.md` 是 `AGENTS.md` 的符号链接，只能编辑真文件（[AGENTS.md:151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L151)）

### CLAUDE.md

仓库根部指向 `AGENTS.md` 的符号链接，内容与之逐字相同。

- 以符号链接把同一份指令文本挂在第二个文件名下，使按 `CLAUDE.md` 名字查找工作区指令的加载器读到与 `AGENTS.md` 相同的全部条款（[CLAUDE.md:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/CLAUDE.md#L1)）

### README.md

面向人的仓库首页说明：项目定位、开发者预览声明、两种运行方式、社区入口与许可。

- 无运行期机制

### native/README.md

`native/` 目录的说明文档，交代原生启动器工作区归属与其发布流程边界。

- 无运行期机制

### package.json

仓库根清单：私有的工作区根包，定义 pnpm 工作区范围、所有可执行脚本入口与开发期工具版本。

- 声明包私有、模块类型为 ESM、锁定包管理器版本并限定 Node 引擎范围（[package.json:5-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L5-L10)）
- 用 glob 圈定工作区成员：vendor、`packages/*/*`、原生启动器及其子包、`apps/*` 与站点（[package.json:11-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L11-L18)）
- 把库构建拆成 host 与 client 两次，各自先跑对应 tsconfig 的 `tsc -b` 再以 `--env.DSH_BUILD_FACE` 传入构建面给 tsdown，host 那次还抬高了 old-space 上限（[package.json:22-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L22-L24)）
- 为单测、覆盖率、分片覆盖率、e2e、期望输出、快照、Web、Web 性能、Web 压测、GUI 各绑定一份独立的 vitest 配置（[package.json:35-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L35-L53)）
- 用 `DSH_SNAPSHOT` 环境变量切换快照套件的模式：`refresh` 刷新期望值、`record` 配合 `--update` 重录、`replay` 只重放（[package.json:40-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L40-L51)）
- 把各 CI 门与本地聚合门统一委派给 `scripts/run-gates.ts` 的具名分组（check-all、ci-primary、ci-static、ci-coverage、ci-snapshot、ci-artifacts、ci-consumers、windows 三档、node-compat）（[package.json:54-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L54-L67)）
- 把生成器同时挂成生成与 `--check` 两个入口，使目录、图、catalog 类产物既可重生成又可作为新鲜度校验（[package.json:115-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L115-L139)）
- 把文档聚合门与卫生聚合门也委派给 `scripts/run-gates.ts` 的 `doc-sync` 与 `hygiene` 分组（[package.json:141-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L141-L142)）
- `dsh` 脚本以 `node --import tsx/esm` 直接从源码启动 CLI bin（[package.json:150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L150)）
- 提供三个旁路运行入口：PTC 模式 demo、带 `--patch` 覆盖层的 inspector web 启动、以及本地 LLM mock 服务器 bin（[package.json:151-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L151-L153)）
- `postinstall` 在每次安装后运行脚本安装 git hook 工具（[package.json:155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L155)）
- 在 devDependencies 里精确钉住 lint、类型、打包、测试与文档工具链的版本（[package.json:157-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/package.json#L157-L194)）

### packages/AGENTS.md

`packages/` 目录下的智能体指令文件，在仓库根规则之外追加包级规则。

- 规定服务包默认导出服务类、函数插件只具名导出 `name`/`inject`/`Config`/`apply` 且不得有默认导出，混用会让加载器丢弃函数插件的命名空间（[packages/AGENTS.md:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L5)）
- 规定可选服务用 `ctx.get(name)` 读全局服务存储，`ctx.<name>` 属性代理只留给已声明的注入（[packages/AGENTS.md:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L6)）
- 规定产品可见插件必须有真实组合测试：经加载器与应用/进程引导测试专用的 `cordis.yml`，只 mock 外部服务或非确定输入，并断言模型可见、持久或用户可见的输出（[packages/AGENTS.md:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L7)）
- 规定在发起者作用域下每个编排入口重新取回 Agent 并派生 session，且在生命周期、会话日志、服务、授权、worker/进程、持久化与线路接口处保持 Agent 与 Session 显式（[packages/AGENTS.md:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L8)）
- 规定一个异步操作只用一个生命周期控制器或事务表示，就绪、取消、释放、预留、哨兵状态各需独立所有者或结算点（[packages/AGENTS.md:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L9)）
- 规定工具 schema、加载器、UI、传输与 provider 专有行为留在消费者或 provider 一侧，不由单个消费者决定服务契约（[packages/AGENTS.md:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L10)）
- 规定面向模型的提示、工具 schema、结果与诊断只含任务相关概念，不含 UI、传输或实现词汇，稳定的模型可见文本要逐字钉住（[packages/AGENTS.md:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L13)）
- 规定决策必须在作出它的那个操作里执行：schema 省略、提示过滤、门面、包装与监听顺序在有直连或替代调用方时不算强制，拒绝要在执行器上测（[packages/AGENTS.md:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L14)）
- 规定状态只在提交点发布：通知与派生状态在操作成功后才更新，缓存、提示、UI 回显、重放与查询视图都从同一权威源派生（[packages/AGENTS.md:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L15)）
- 规定字节、token、条目与时间上限施加在含包装与元数据的完整结果上，并要测极小值、恰好边界、超大单块与多字节字节上限（[packages/AGENTS.md:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L16)）
- 规定注册表贡献要用 HMR 安全测试证明可释放：销毁 fiber 并观察移除（[packages/AGENTS.md:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L17)）
- 规定每个包都拥有 `./invariant` 导出并注册清单名，要么检查事件/数据关系、要么给出包特定的空实现理由，生成的伴生物、无解释的空实现与被忽略的报告器都会被门卡住（[packages/AGENTS.md:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L18)）
- 规定包 tsconfig 的继承基线、`rootDir`/`outDir`、workspace 引用与聚合注册，以及 Host/Client 双面包的叶子配置与仅解决方案根（[packages/AGENTS.md:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L22)）
- 规定 `src/types.ts` 只放类型不放运行期代码，测试放在包级 `tests/` 而非 `src/__tests__/`（[packages/AGENTS.md:23-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/AGENTS.md#L23-L24)）

### packages/CLAUDE.md

`packages/` 下指向同目录 `AGENTS.md` 的符号链接，内容与之逐字相同。

- 以符号链接把同一份包级指令文本挂在第二个文件名下，使按 `CLAUDE.md` 名字查找目录级指令的加载器读到与 `packages/AGENTS.md` 相同的全部条款（[packages/CLAUDE.md:1](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/CLAUDE.md#L1)）

### packages/README.md

`packages/` 的顶层导航页：列出全部包分组及其角色、发布期望、依赖图入口与包 README 契约要求。

- 无运行期机制

### packages/acp/README.md

acp 分组的导航页：说明该分组只有一个包，以及它在自动化场景中提供的会话管理能力。

- 无运行期机制

### packages/api/README.md

api 分组的导航页：列出远程调用层的各控制器包及其 ctx 键。

- 无运行期机制

### packages/attachment/README.md

attachment 分组的导航页：说明附件能力由定义包与本地存储包两部分组成。

- 无运行期机制

### packages/boot/README.md

boot 分组的导航页：说明应用 bin 启动所需的两个库包及其角色。

- 无运行期机制

### packages/bundle/README.md

bundle 分组的导航页：列出各 profile 补丁层包及其叠放关系。

- 无运行期机制

### packages/client/AGENTS.md

浏览器端插件栈的智能体指令文件，为 `packages/client/*` 与其构建入口追加规则。

- 规定插件只能通过 `ctx.slots.register({ name, children?, store?, inject? }, Component)` 组合 UI，只有 shell 渲染 `'root'`，且没有单独的 slot 定义调用（[packages/client/AGENTS.md:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L11)）
- 规定组件能渲染的 slot 恰为其注册调用 `children` 的键，渲染未声明或重复声明他人已声明的 slot 在加载期失败（[packages/client/AGENTS.md:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L12)）
- 规定组件 props 由四份 share 交叉派生，且框架 hook 只有五个固定席位加上渲染器从 provide 贡献与 inject `hooks` 隔间绑出的 `use<Name>`（[packages/client/AGENTS.md:13-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L13-L14)）
- 规定实时数据只有三条通道（父级 props、组件局部状态、注册时声明的 store），派生数据只能是框架 hook 数据上的纯函数（[packages/client/AGENTS.md:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L15)）
- 规定 store 读 `props.useStore`、写 `props.actions.*`，工厂式导出、禁止模块级句柄，生产代码只在 `apply` 内调用工厂（[packages/client/AGENTS.md:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L16)）
- 规定 `inject` 只返回纯数据与回调、私有响应式事实走保留的 `hooks` 隔间，插件只能使用其 `inject` 声明的依赖（[packages/client/AGENTS.md:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L17)）
- 规定 UI 域之间只传 JSON 兼容数据与回调，ReactNode 内容必须走 slot 而非 props 或注入成员（[packages/client/AGENTS.md:26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L26)）
- 规定可观察源保持源对象与快照两个引用身份稳定，重建发布值时在同一步内经同一源重新发布，并在注册时通知已存在的消费者（[packages/client/AGENTS.md:27-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L27-L28)）
- 规定 UI 插件的 `/client` 入口只导出加载所需的 `apply`/`inject`/`Config` 与类型消费的 store 工厂，且功能插件之间不得运行期导入或再导出彼此的值、也不得用 `dsh.client.external` 取（[packages/client/AGENTS.md:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L34-L36)）
- 规定组件永远拿不到 `ctx`：`ctx` 只属于 apply 世界与其闭包，组件所需一切经四份 share 传入（[packages/client/AGENTS.md:40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L40)）
- 规定 rpcId 严格双向：发起方铸造、响应方回显，铸造留在连接层（[packages/client/AGENTS.md:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L53)）
- 规定通知发布纪律：`notifyNow` 只作用户手势的直接回声，结构性更新走微任务批处理的 `markDirty`，可见流式块走累积的 `markFrameDirty`（[packages/client/AGENTS.md:54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L54)）
- 规定 web 层纯呈现：只关乎画法的东西不进会话日志，工具卡片由原始调用/结果事件与持久化结果元数据在客户端派生，未知或畸形工具数据回退到通用形式（[packages/client/AGENTS.md:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L55)）
- 规定客户端包的 peer/dev/依赖分区规则，并说明 `verify-client-packages` 检查这些规则且能用 `--fix` 修正无歧义的清单漂移（[packages/client/AGENTS.md:59-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L59-L67)）
- 规定客户端业务代码只可静态读 `process.env.DSH_CLIENT_*`，构建记录公开值与全部客户端产物摘要，发布与产物消费者拒绝缺失或过期的记录（[packages/client/AGENTS.md:71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L71)）
- 规定共享模块基线集中在 `web/src/platform.ts` 的 `PLATFORM_MODULES` 与 `PRELOADED_CLIENT_EXTERNALS`，基线对每个动态包隐式外部化，`dsh.client.external` 只能由基础设施、传输或生成装配追加精确的导入说明符（[packages/client/AGENTS.md:75-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L75-L81)）
- 对比服务 `inject` 与模块图 `external` 的时机与失败方式：前者运行期等待、无超时地停在 PENDING，后者在物化时同步且不满足就当场抛出，且模块行按拓扑序发出、递归先注册提供方工厂（[packages/client/AGENTS.md:88-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L88-L95)）
- 规定会话节点定义的 `match(event)` 只读当前事件，`update` 按逻辑日志 `seq` 确定性可重放，打包行只更新，且追加热路径与渲染器不扫描完整事件窗口（[packages/client/AGENTS.md:102-103](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L102-L103)）
- 规定注册走 `apply` 里的 `slots.register` 而非模块级副作用，多域包的域间层级由 `scripts/verify-client-domain-graph.ts` 强制（[packages/client/AGENTS.md:107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L107)）
- 规定所有产品可见字符串走类型化 locale 字典并经 `t` 席位或已本地化的 prop 到达组件，内部匹配用判别式或稳定 id 而非本地化文本，由 `verify-client-ui-i18n` 强制（[packages/client/AGENTS.md:113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L113)）
- 规定客户端源码包在每文件 100% 覆盖率门内，不可达防御分支要带理由的 `v8 ignore` 注释，jsdom 环境靠 spec 首行的 per-file pragma 打开（[packages/client/AGENTS.md:119-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L119-L121)）
- 规定改动可能改变装配后的浏览器输出或可见会话输出时，额外跑 `DSH_SNAPSHOT=replay` 的 Web 套件，确认是有意变更后才用 `refresh`、带密钥时才用 `record`（[packages/client/AGENTS.md:129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L129)）
- 规定新客户端插件包必须同时登记三处注册面（客户端 tsconfig 聚合引用、web-app 的 `dsh.client` 行、web-app 清单依赖），否则会在不同的更晚时点失败；profile 引导经修复过的 `$DSH_HOME/profiles/node_modules` 回退解析裸行名（[packages/client/AGENTS.md:139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L139)）
- 规定 `dsh.client` 清单语义：必须有 `./client` 导出否则扫描抛错，`immediately: true` 只给第一阶段预取行，`inject` 仅供预检显示与 HMR 差分、不排序激活（[packages/client/AGENTS.md:140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L140)）
- 规定向他人 slot 注册用 `ctx.slots.inject(name, () => ctx.slots.register(...))`：它等待真实声明、声明坍塌时移除贡献、重新声明后重跑，并随调用方插件 fiber 一起退出（[packages/client/AGENTS.md:141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L141)）
- 规定探活实时服务前先重建 bundle，因为注册表服务的是 `lib/client.js` 而不是源码（[packages/client/AGENTS.md:142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/AGENTS.md#L142)）

### packages/client/README.md

client 分组的导航页：列出浏览器端内核包与各 UI 功能插件包及其 ctx 键。

- 无运行期机制

### packages/client/tsdown.client.ts

客户端插件包共享的 tsdown 构建预设，被每个客户端包的 `tsdown.config.ts` 调用，产出 node 半边库与浏览器闭包工厂产物。

- `styleInjectionModule` 生成的模块在工厂执行时创建 `<style>` 标签、打上插件与样式表标识并追加到 `document.head`，同名标签已存在时跳过，附带或不附带 CSS Modules 类名映射的默认导出（[packages/client/tsdown.client.ts:34-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L34-L53)）
- `INLINE_SAFE` 正则列举允许内联进客户端 bundle 的契约层与纯折叠包（[packages/client/tsdown.client.ts:61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L61)）
- `VENDORED_LIBRARY` 与 `GENERATED_REMOTE` 两条正则把重定作用域的框架库与生成的 `/remote` 贡献也放行为可内联（[packages/client/tsdown.client.ts:69-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L69-L72)）
- `SKIP_WORKSPACE_BUILD` 用空 `entry` 的配置把当前包从这一遍工作区构建里摘掉（[packages/client/tsdown.client.ts:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L78)）
- `browserSourcePath` 把 sourcemap 里的相对源路径重挂到镜像仓库目录的浏览器 URL 上（[packages/client/tsdown.client.ts:83-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L83-L88)）
- `clientBundle` 按构建面选择客户端入口：无构建面时用 `src/client/index.ts`，否则用 `lib/types/client/index.js`（[packages/client/tsdown.client.ts:113-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L113-L116)）
- `clientBundle` 按构建面与 `hostPhase` 决定这一遍产出哪些配置：host 面只在 `hostPhase` 时产 node 配置否则跳过，client 面在 `hostPhase` 时只产浏览器配置否则两者都产（[packages/client/tsdown.client.ts:118-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L118-L123)）
- `staticLinked` 在多个入口的输出基名冲突时直接抛错（[packages/client/tsdown.client.ts:157-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L157-L160)）
- `isStaticLinkedConfig` 通过配置里是否含具名插件判断该包是否属于静态链接通道，供门检查读取（[packages/client/tsdown.client.ts:171-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L171-L174)）
- `clientOnly` 在 host 面返回跳过配置，使这些配置只在 client 遍产出（[packages/client/tsdown.client.ts:192-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L192-L196)）
- `buildFace` 只接受 `host`、`client` 或未定义，其余取值抛错终止构建（[packages/client/tsdown.client.ts:211-214](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L211-L214)）
- `clientLibraryConfig` 让 node 半边同时声明两侧规则：生产依赖保持为 import，其余非内置全部内联，输出 esm、node 平台、不清目录、不出 dts（[packages/client/tsdown.client.ts:221-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L221-L243)）
- `staticLinkedConfig` 输出 browser 平台的 esm 单入口产物并开启 sourcemap 且不排除源内容（[packages/client/tsdown.client.ts:258-271](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L258-L271)）
- 静态链接插件以 `pre` 顺序把所有带 importer 的裸说明符标为 external，入口本身保持内部（[packages/client/tsdown.client.ts:277-285](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L277-L285)）
- `dsh-css-asset` 把 `.css` 导入解析成实体资产：按 `src` 相对名发到 `lib/` 下、去重、把物理文件挂进 watch 图，并把导入改写为相对 external（[packages/client/tsdown.client.ts:288-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L288-L302)）
- `stylesheetAsset` 在样式表位于包 `src/` 之外时抛错（[packages/client/tsdown.client.ts:318-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L318-L323)）
- `workspaceManifest` 以包名而非 cwd 定位清单：遍历 `packages/*/*/package.json` 并缓存，找不到该名字时抛错（[packages/client/tsdown.client.ts:349-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L349-L361)）
- `productionExternals` 把 `dependencies`/`peerDependencies`/`optionalDependencies` 的名字编成 `^name(/|$)` 模式并缓存（[packages/client/tsdown.client.ts:369-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L369-L381)）
- `requestedExternals` 校验并读取清单里的 `dsh.client.external`，非字符串数组时报错（[packages/client/tsdown.client.ts:392-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L392-L397)）
- `clientExternals` 把平台基线模块、预加载外部与该包自己的请求合成一个精确匹配集合并缓存（[packages/client/tsdown.client.ts:406-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L406-L416)）
- `clientConfig` 产出 `cjs`/browser 的浏览器半边，入口固定命名为 `client`、与 node 半边同放 `lib/`、开 sourcemap、关 dts 与 clean（[packages/client/tsdown.client.ts:430-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L430-L444)）
- 浏览器半边的打包规则以该包的请求列表为准：被请求的说明符保持 import，其余一律内联（[packages/client/tsdown.client.ts:445-453](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L445-L453)）
- 解析条件按构建时 `NODE_ENV` 在 `development` 与 `production` 之间取一个，再依次 `browser`/`import`/`module`/`default`（[packages/client/tsdown.client.ts:458-465](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L458-L465)）
- `define` 把公开的客户端构建环境值、`process.env.NODE_ENV`、`import.meta.env.MODE` 与整个 `import.meta.env` 对象在产物里替换为字面量，默认取 production（[packages/client/tsdown.client.ts:476-481](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L476-L481)）
- 纯度门在解析阶段拦截该作用域下的导入：已请求的模块表行、白名单里的重定作用域库、内联安全线路层与生成的 `/remote` 贡献放行，其余一律抛出构建错误（[packages/client/tsdown.client.ts:489-500](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L489-L500)）
- `dsh-css-modules-inline` 把 `.module.css` 转成虚拟模块：登记 watch 依赖、用 lightningcss 以 `[hash]_[local]` 生成类名并压缩，按名排序导出类名映射并附带样式注入代码（[packages/client/tsdown.client.ts:502-525](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L502-L525)）
- `dsh-css-text-inline` 把带 `?inline` 查询的样式表编译压缩后作为默认导出的文本返回，并登记 watch 依赖（[packages/client/tsdown.client.ts:526-541](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L526-L541)）
- `dsh-css-global-inline` 把非 module 的 `.css` 编译压缩后转成样式注入模块，并登记 watch 依赖（[packages/client/tsdown.client.ts:542-556](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L542-L556)）
- 输出选项把产物钉成 `client.js`、保留源内容、经 `browserSourcePath` 改写 sourcemap 路径，并用 banner/footer/intro 把整个 bundle 包成向全局模块加载器登记的闭包工厂，外部依赖经注入的 `require` 解析（[packages/client/tsdown.client.ts:558-569](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L558-L569)）
- `tscSourceMapPlugin` 在加载 `lib/types` 下的 `.js` 时接上 tsc 产出的 map：校验 `sources` 合法否则抛错，`sourcesContent` 缺失或长度不符时逐个读回源文件补齐，并删掉尾部的 sourceMappingURL 注释（[packages/client/tsdown.client.ts:574-603](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L574-L603)）
- `sourceAssetPath` 把针对 `lib/types` 产物解析出的资产路径折回同包 `src/` 下的对应位置（[packages/client/tsdown.client.ts:618-624](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/tsdown.client.ts#L618-L624)）

### packages/code-runtime/README.md

code-runtime 分组的导航页：列出程序执行能力的定义包、worker 线程执行包与 Python 后端协议包。

- 无运行期机制

### packages/compaction/README.md

compaction 分组的导航页：列出历史压缩的契约包、自动压缩包、工具输出裁剪包与按需命令包。

- 无运行期机制

### packages/context/README.md

context 分组的导航页：列出各类为每次请求增加模型可见上下文的插件包。

- 无运行期机制

### packages/core/README.md

core 分组的导航页：列出会话日志、系统提示装配、工具注册表、Agent 句柄与默认循环等主干包。

- 无运行期机制

### packages/credentials/README.md

credentials 分组的导航页：列出凭据引用服务、本地凭据存储与授权流程注册表三个包。

- 无运行期机制

### packages/e2b/README.md

e2b 分组的导航页：列出远程沙箱及其文件与子进程适配包。

- 无运行期机制

### packages/examples/README.md

examples 分组的导航页：说明该分组只含一个可复用的组合包，且不含应用入口。

- 无运行期机制

### packages/experimental/AGENTS.md

实验性子树的智能体指令文件，在包级规则之外追加放置、命名与依赖隔离规则。

- 规定只有完整公共契约都是实验性或内部专用的包才放在此目录，发布包内的实验性选项留在其产品角色处（[packages/experimental/AGENTS.md:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/AGENTS.md#L5)）
- 规定此处每个包用实验性 npm 名前缀、置 `private: true` 且不写 `publishConfig`，由工作区约束门强制，并被发布家族排除在外（[packages/experimental/AGENTS.md:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/AGENTS.md#L6)）
- 规定发布包与应用不得在 `dependencies`/`optionalDependencies`/`peerDependencies` 中指名此处的包，测试只能经 `devDependencies` 使用（[packages/experimental/AGENTS.md:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/AGENTS.md#L7)）
- 规定实验性身份不放宽工程、安全、文档、生命周期、测试、不变量与快照要求（[packages/experimental/AGENTS.md:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/AGENTS.md#L8)）
- 规定转正时把包移入其产品角色分组、去掉名字里的实验性前缀，并原子地更新每处导入与配置行（[packages/experimental/AGENTS.md:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/experimental/AGENTS.md#L9)）

### packages/experimental/README.md

experimental 分组的导航页：列出不属于任何正式发布的原型包及其 ctx 键。

- 无运行期机制

### packages/extensions/README.md

extensions 分组的导航页：列出运行期自修改子系统的模型工具包、宿主运行器、浏览器运行器与浏览器 UI 包。

- 无运行期机制

### packages/feedback/README.md

feedback 分组的导航页：列出会话备注命令包与逐条消息评价包。

- 无运行期机制

### packages/fs/README.md

fs 分组的导航页：列出文件系统契约包、各后端、读后改策略包与模型可见的文件与检索工具包。

- 无运行期机制

### packages/goal/README.md

goal 分组的导航页：列出目标服务、模型工具、人类命令与自动续跑驱动四个包。

- 无运行期机制

### packages/guard/README.md

guard 分组的导航页：列出重复工具调用提醒与工具调用超时策略两个插件包。

- 无运行期机制

### packages/hooks/README.md

hooks 分组的导航页：列出共享 hook 引擎库与两个外部 hook 配置桥接插件。

- 无运行期机制

### packages/host/README.md

host 分组的导航页：列出 HTTP 服务器、SPA 静态服务、目录选择接缝与其后端、插件清单投影包。

- 无运行期机制

### packages/identity/README.md

identity 分组的导航页：说明该分组只有一个匿名标识包及其被哪些功能引用。

- 无运行期机制

### packages/interaction/README.md

interaction 分组的导航页：列出斜杠命令、一次性审批、权限预设、用户提问与提问工具五个包。

- 无运行期机制

### packages/jobs/README.md

jobs 分组的包索引页，列出后台作业注册表契约、进程内存储与面向模型的作业工具三个包及其 ctx 键。

- 无运行期机制

### packages/llm/README.md

llm 分组的包索引页，列出模型调用服务、各 provider 适配器、请求扩展、重试与用量计量包及其 ctx 键。

- 无运行期机制

### packages/lsp/README.md

lsp 分组的包索引页，列出语言服务导航的服务定义、stdio provider 与面向模型的 lsp 工具三个包。

- 无运行期机制

### packages/mcp/README.md

mcp 分组的包索引页，说明该组只有一个把外部 MCP 服务器的工具桥接为原生工具的包。

- 无运行期机制

### packages/plan/README.md

plan 分组的包索引页，说明该组只有 plan-mode 一个包，并列出其 ctx 键与相关文档。

- 无运行期机制

### packages/preset/README.md

preset 分组的包索引页，列出预设名册包与 persona 行两个包及其 ctx 键。

- 无运行期机制

### packages/runtime-diagnostics/README.md

runtime-diagnostics 分组的包索引页，说明该组只有一个运行期不变量检查包并列出其注册位置。

- 无运行期机制

### packages/sandbox/README.md

sandbox 分组的包索引页，列出限制服务、各平台后端、共享策略解析与 Windows 写限制四个包及其 ctx 键。

- 无运行期机制

### packages/schedule/AGENTS.md

`packages/schedule/*` 目录下的智能体指令文件，被按目录就近查找 `AGENTS.md` 的工作区指令加载器读入模型上下文，规定该组包的持久状态、折叠、屏障与到期派发规则。

- 规定持久的 Schedule 状态只有归属 Session 上带版本的 `schedule/change` 流，折叠时校验每个持久 JSON 边界并派生活动记录，定时器、空闲等待者与工具取值都是可丢弃的投影（[packages/schedule/AGENTS.md:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/AGENTS.md#L5)）
- 规定普通 Session 折叠完整日志，而 fork 只从 `SessionHeader.seedLength` 及其之后的事件派生活动状态，绝不继承父会话的活动提醒（[packages/schedule/AGENTS.md:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/AGENTS.md#L6)）
- 规定每个从折叠读取或决策的管理操作先 await `ctx.sessions.flush(session)`，创建与实际删除在追加后再过一道屏障，屏障失败返回稳定的不确定结果而不从活日志推断持久性（[packages/schedule/AGENTS.md:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/AGENTS.md#L7)）
- 规定运行期 owner 只在插件加载期间挂到将来出现的活根 Agent 上，不扫描已持久化的 Session、不接管已发布的根、不唤醒冷 Session、不注册全局工具、拆卸时不删持久记录（[packages/schedule/AGENTS.md:8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/AGENTS.md#L8)）
- 规定到期处理重查墙钟与确切的活 owner、经公共 Agent 接缝占用空闲维护阶段、在 `followup()` 前构造好完整的转义框架、只在同步入队返回后才追加派发记录、随后释放维护并等待持久化，同步失败不追加派发、之后的模型失败也不回滚（[packages/schedule/AGENTS.md:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/AGENTS.md#L9)）
- 规定规则计算与持久状态转移逻辑保持纯函数且确定，生产使用平台墙钟与分段定时器，测试给显式样本或假定时器而不引入生产时钟服务（[packages/schedule/AGENTS.md:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/schedule/AGENTS.md#L10)）

### packages/schedule/README.md

schedule 分组的包索引页，说明该组只有一个提供创建、列出、取消三个提醒工具的包。

- 无运行期机制

### packages/sdk/README.md

sdk 分组的包索引页，列出线路协议、TypeScript 客户端与 jsonrpc 服务端三个包。

- 无运行期机制

### packages/session-query/README.md

session-query 分组的包索引页，列出统一查询服务、SQLite 全文检索后端、Web 导出与面向模型的查询工具四个包及其 ctx 键。

- 无运行期机制

### packages/session/README.md

session 分组的包索引页，按持久化、投影、标题、遥测四类列出该组各包的角色与 ctx 键。

- 无运行期机制

### packages/settings/README.md

settings 分组的包索引页，列出设置服务与文件 provider 两个包及其 ctx 键。

- 无运行期机制

### packages/shell/README.md

shell 分组的包索引页，列出执行器契约、各平台与沙箱执行器、环境变量供给包与面向模型的 shell 工具及其 ctx 键。

- 无运行期机制

### packages/skill/README.md

skill 分组的包索引页，列出技能注册表、文件系统 provider、内置徽章技能与面向模型的加载工具四个包及其 ctx 键。

- 无运行期机制

### packages/spill/README.md

spill 分组的包索引页，列出溢出存储服务、本地后端与结果替换策略三个包及其 ctx 键。

- 无运行期机制

### packages/storage/README.md

storage 分组的包索引页，列出存储服务、JSON 与 SQLite 后端、域数据形态四个包及其 ctx 键。

- 无运行期机制

### packages/subagent/README.md

subagent 分组的包索引页，列出委派服务定义、各进程内与进程外后端、以及面向模型的委派与控制工具及其 ctx 键。

- 无运行期机制

### packages/subprocess/README.md

subprocess 分组的包索引页，列出子进程服务定义、本地 provider 与 Win32 绑定库三个包及其 ctx 键。

- 无运行期机制

### packages/terminal/README.md

terminal 分组的包索引页，列出会话服务、shell 后端与六个面向模型的终端工具三个包及其 ctx 键。

- 无运行期机制

### packages/test-support/README.md

test-support 分组的包索引页，列出快照适配、循环测试套件、浏览器测试台、Loader 冒烟、mock 服务器与回放六个测试基础设施包。

- 无运行期机制

### packages/todo/README.md

todo 分组的包索引页，说明该组只有一个提供 `todo_write` 工具的包。

- 无运行期机制

### packages/typert/README.md

typert 分组的包索引页，列出类型图生成器、Loader 集成、协议声明与运行期注册表四个包及其 ctx 键。

- 无运行期机制

### packages/util/README.md

util 分组的包索引页，列出品牌类型、UUID、家目录路径、启动环境、原子写、原生命令、路径助手、输出截断与超时九个零依赖库包。

- 无运行期机制

### packages/web/AGENTS.md

`packages/web/*` 目录下的智能体指令文件，被按目录就近查找 `AGENTS.md` 的工作区指令加载器读入模型上下文，规定该组带凭据的外发请求如何处理重定向。

- 规定带凭据的 provider 请求必须把 HTTP 客户端配置为在跟随任何重定向响应之前失败，并要求回归测试证明重定向目标未被访问、每个带凭据的 provider 都启用了该策略（[packages/web/AGENTS.md:5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/web/AGENTS.md#L5)）

### packages/web/README.md

web 分组的包索引页，列出搜索/抓取服务、三个搜索后端、一个抓取后端与面向模型的工具包及其 ctx 键。

- 无运行期机制

### packages/webhook/README.md

webhook 分组的包索引页，列出规则注册表与 GitHub 签名适配器两个包及其 ctx 键。

- 无运行期机制

### packages/workflow/README.md

workflow 分组的包索引页，列出工作流运行服务、worker 线程执行器与两个面向模型的编排工具及其 ctx 键。

- 无运行期机制

### packages/workspace/README.md

workspace 分组的包索引页，说明该组只有一个提供项目名册的包并列出其 ctx 键。

- 无运行期机制

### pnpm-workspace.yaml

pnpm 工作区清单：圈定工作区成员目录、指定依赖解析覆盖、声明哪些依赖允许执行安装脚本，以及要打的补丁。

- 用 glob 圈定工作区成员，决定哪些目录的包名能被解析为本地源码：vendor、`packages/*/*`、原生启动器及其子包、`apps/*`、站点，以及作为单文件构建部署根的 `python/sdk-runtime`（[pnpm-workspace.yaml:1-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L1-L13)）
- 打开 `linkWorkspacePackages`，使同名依赖解析到工作区内的源码而不是注册表版本（[pnpm-workspace.yaml:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L17)）
- 用 `overrides` 把两个框架包强制链接到 `vendor/` 下的固定源码副本（[pnpm-workspace.yaml:19-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L19-L21)）
- 放宽 peer 依赖校验，接受 `>=5 <7` 范围内的 typescript（[pnpm-workspace.yaml:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L23-L25)）
- 以 `allowBuilds` 白名单允许 esbuild、lefthook 与 node-pty 在安装期执行各自的构建/生命周期脚本（[pnpm-workspace.yaml:32-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L32-L36)）
- 在同一白名单里把三个包置为 `false`，禁止它们在安装期执行生命周期脚本（[pnpm-workspace.yaml:40-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L40-L42)）
- 允许 koffi 执行构建脚本，其绑定被 Windows 上的写透发布调用使用（[pnpm-workspace.yaml:43-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L43-L44)）
- 允许工作区内 `subprocess-local` 包以 `file:` 形式参与的 postinstall 执行，用于恢复某个 spawn 助手的可执行位（[pnpm-workspace.yaml:45-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L45-L47)）
- 用 `minimumReleaseAgeExclude` 列出一批精确版本，使它们绕过发布时长门槛而可被安装，包括 pi-ai、若干原生 loader 包、外部 agent SDK 的各平台包与以版本并集写成的 codex 平台别名条目（[pnpm-workspace.yaml:49-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L49-L75)）
- 用 `patchedDependencies` 在安装时对 node-pty 的指定版本应用 `patches/` 下的补丁文件（[pnpm-workspace.yaml:77-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/pnpm-workspace.yaml#L77-L78)）

### python/README.md

`python/` 目录的说明文档，列出客户端 SDK 与运行时 wheel 两个分发包并概述启动行为。

- 无运行期机制

### python/sdk/README.md

Python 客户端 SDK 的用户参考文档，说明如何启动运行时、选择 profile 与 patch、以及返回结果的字段含义。

- 无运行期机制

### python/sdk/examples/README.md

Python SDK 可运行示例的说明文档，给出命令行调用方式、示例所用 profile 的工具清单与插件扩展方法。

- 无运行期机制

### python/sdk/examples/minimal.py

Python SDK 自带的命令行示例，跑一轮最小 agent 回合并打印最终回复，由使用者直接执行。

- 从环境变量 `DSH_HOME` 取 `--dsh-home` 的默认值，空白字符串按未设置处理（[python/sdk/examples/minimal.py:16-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/examples/minimal.py#L16-L23)）
- `--provider` 默认 `deepseek-official`，`--model` 默认取环境变量 `DSH_MODEL`、缺省为 `deepseek-v4-flash`（[python/sdk/examples/minimal.py:26-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/examples/minimal.py#L26-L27)）
- 解析后仍无 dsh_home 时用 `parser.error` 终止进程（[python/sdk/examples/minimal.py:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/examples/minimal.py#L30-L31)）
- 把 workspace 与 dsh_home 解析成绝对路径后以上下文管理器构造 `DeepSeekHarness`，退出块时关闭运行时（[python/sdk/examples/minimal.py:33-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/examples/minimal.py#L33-L42)）
- 用 `harness.run(prompt, session_id=...)` 跑一轮，并把 `result.final_response` 打到 stdout（[python/sdk/examples/minimal.py:43-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/examples/minimal.py#L43-L44)）

### python/sdk/pyproject.toml

Python SDK 包的构建与依赖清单，由 hatchling 打包、uv/pip 安装时读取。

- 运行期依赖固定 `pydantic>=2.12,<3` 与 `deepseek-harness-runtime-bin==0.0.0.dev0`，后者是客户端解析捆绑 dsh 可执行文件的来源（[python/sdk/pyproject.toml:13-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/pyproject.toml#L13-L16)）
- `requires-python = ">=3.10"` 限定可安装的解释器版本（[python/sdk/pyproject.toml:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/pyproject.toml#L10)）
- pytest 默认参数为 `-q`，测试路径限定 `tests`（[python/sdk/pyproject.toml:27-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/pyproject.toml#L27-L29)）
- wheel 只打包 `src/deepseek_harness` 一个目录（[python/sdk/pyproject.toml:31-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/pyproject.toml#L31-L32)）
- `tool.uv.sources` 把 runtime-bin 指向 `../sdk-runtime` 的可编辑安装（[python/sdk/pyproject.toml:36-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/pyproject.toml#L36-L37)）

### python/sdk/src/deepseek_harness/__init__.py

包入口，把 api / client / errors / models 四个模块的公开名字集中导出。

- 无运行期机制

### python/sdk/src/deepseek_harness/api.py

Python SDK 的高层同步接口：`DeepSeekHarness` 拥有运行时子进程，`Session.run` 跑一轮并把通知流折算成结果，被示例与使用者直接调用。

- `DeepSeekHarnessConfig` 固定了送进运行时的默认值：provider `deepseek-official`、model `deepseek-v4-flash`、profile `sdk`、initialize 超时 30 秒、shutdown 超时 1 秒（[python/sdk/src/deepseek_harness/api.py:22-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L22-L37)）
- 同时传 `config` 与关键字参数时抛 `TypeError`（[python/sdk/src/deepseek_harness/api.py:64-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L64-L66)）
- cwd 解析为绝对路径，`runtime_cwd` 未给时等于 cwd（[python/sdk/src/deepseek_harness/api.py:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L67-L69)）
- `base_url` / `api_key` 被写成子进程环境变量 `DEEPSEEK_BASE_URL` / `DEEPSEEK_API_KEY`，叠加在 `config.env` 之上（[python/sdk/src/deepseek_harness/api.py:70-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L70-L74)）
- 把配置折成 `HarnessConfig` 构造 `HarnessClient`，并可用 `_launch_args` 覆盖启动 argv（[python/sdk/src/deepseek_harness/api.py:76-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L76-L89)）
- `__enter__` / `__exit__` 绑定 `start()` / `close()`（[python/sdk/src/deepseek_harness/api.py:92-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L92-L97)）
- `start()` 幂等：启动子进程后发一次 `initialize`，带 cwd、provider、model、reasoning_effort、max_tokens（[python/sdk/src/deepseek_harness/api.py:103-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L103-L114)）
- `close()` 关闭客户端并把 initialized 标志复位，使后续 `start()` 重新初始化（[python/sdk/src/deepseek_harness/api.py:116-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L116-L118)）
- `start_session` 在未给 session_id 时生成 `session-<uuid4hex>`（[python/sdk/src/deepseek_harness/api.py:120-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L120-L122)）
- `Session.run` 先规范化输入，再在会话通知订阅内发 `session/prompt` 并拿到 messageId（[python/sdk/src/deepseek_harness/api.py:145-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L145-L166)）
- 在收到本次 messageId 的 inbox 回执之前，通知一律丢弃不计入结果（[python/sdk/src/deepseek_harness/api.py:168-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L168-L175)）
- `collect` 记录全部通知、转发给 `on_notification` 回调，并只把 `session.event` 且 sessionId 匹配的 event 收进 events（[python/sdk/src/deepseek_harness/api.py:149-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L149-L160)）
- 收到本会话的 `session.status` 且 status 为 `idle` 时跳出等待循环（[python/sdk/src/deepseek_harness/api.py:176-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L176-L181)）
- 返回 `RunResult`，含 session_id、final_response、finish_reason、events、notifications（[python/sdk/src/deepseek_harness/api.py:183-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L183-L189)）
- `_is_inbox_receipt` 认定回执的条件是 `agent/inbox/spliced` 事件的 `data.inserted` 列表里存在 id 等于本次 messageId 的消息（[python/sdk/src/deepseek_harness/api.py:192-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L192-L202)）
- `normalize_input` 把字符串包成 `[{"type": "text", "text": ...}]`，列表原样透传（[python/sdk/src/deepseek_harness/api.py:205-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L205-L208)）
- `final_response` 倒序找最后一条 `assistant/message`，从 `data.message` 或 `data` 取 content，把其中 text 块拼接成字符串，找不到返回空串（[python/sdk/src/deepseek_harness/api.py:211-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L211-L228)）
- `finish_reason` 倒序找最后一条 `turn/end`，`data.reason.kind` 不是字符串时抛 `SdkProtocolError`，无该事件返回 None（[python/sdk/src/deepseek_harness/api.py:231-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/api.py#L231-L248)）

### python/sdk/src/deepseek_harness/client.py

Python SDK 的底层同步 JSON-RPC over stdio 客户端：负责拉起 dsh 运行时子进程、收发消息、分发通知、维护会话树，被 `api.py` 使用。

- `HarnessConfig` 固定默认 profile `sdk`、initialize 超时 30 秒、shutdown 超时 1 秒（[python/sdk/src/deepseek_harness/client.py:28-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L28-L36)）
- 构造时建立响应等待表、默认通知队列、订阅表、会话父子表、入站请求队列，以及 maxlen 400 的 stderr 环形缓冲（[python/sdk/src/deepseek_harness/client.py:50-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L50-L62)）
- `start()` 已有进程时直接返回，并在启动前清空会话父子表（[python/sdk/src/deepseek_harness/client.py:71-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L71-L75)）
- 子进程环境是 `os.environ` 的副本再叠加 `config.env`（[python/sdk/src/deepseek_harness/client.py:76-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L76-L78)）
- 以 `_launch_args` 或 `_default_launch_args(env)` 为 argv，用行缓冲、utf-8 文本模式、三通道管道、解析后的 cwd 起子进程（[python/sdk/src/deepseek_harness/client.py:79-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L79-L90)）
- 启动后拉起 stdout 读线程与 stderr 读线程，均为 daemon（[python/sdk/src/deepseek_harness/client.py:344-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L344-L350)）
- `close()` 先发 `shutdown` 请求（受 shutdown 超时约束），失败信息进 stderr 缓冲（[python/sdk/src/deepseek_harness/client.py:94-104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L94-L104)）
- 随后关闭 stdin，关闭失败同样记入 stderr 缓冲（[python/sdk/src/deepseek_harness/client.py:105-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L105-L109)）
- shutdown 成功则限时等待退出；仍存活则 terminate；再等仍不退则 kill 并阻塞回收（[python/sdk/src/deepseek_harness/client.py:110-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L110-L125)）
- 进程置空后把 `TransportClosedError` 灌给所有等待者，并各 join 两个读线程 0.5 秒（[python/sdk/src/deepseek_harness/client.py:126-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L126-L131)）
- `initialize()` 把 cwd 解析成绝对路径，并只在非 None 时附带 `reasoningEffort` / `maxTokens`（[python/sdk/src/deepseek_harness/client.py:142-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L142-L150)）
- initialize 超时则关闭运行时，并在 TimeoutError 文本里附上所选 profile 名（[python/sdk/src/deepseek_harness/client.py:158-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L158-L160)）
- initialize 其他异常也先关闭运行时，若是 JsonRpcError 且有诊断则把退出码与 stderr 尾部拼进消息重抛（[python/sdk/src/deepseek_harness/client.py:161-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L161-L170)）
- `session_prompt()` 发 `session/prompt`，带上会话树通知过滤器，返回响应里的 `messageId`（[python/sdk/src/deepseek_harness/client.py:172-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L172-L189)）
- `request()` 要求 result 是 JSON 对象否则抛 TypeError，再用给定 pydantic 模型做 `model_validate`（[python/sdk/src/deepseek_harness/client.py:210-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L210-L212)）
- `notify()` 发不带 id 的 JSON-RPC 通知（[python/sdk/src/deepseek_harness/client.py:214-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L214-L218)）
- `subscribe_notifications` 用 uuid 建独立队列与过滤器并注册进订阅表（[python/sdk/src/deepseek_harness/client.py:226-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L226-L234)）
- `subscribe_session_notifications` 用会话树过滤器订阅一个会话及其子代（[python/sdk/src/deepseek_harness/client.py:236-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L236-L238)）
- `respond` / `respond_error` 把结果或 code/message/data 错误写回运行时（[python/sdk/src/deepseek_harness/client.py:246-260](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L246-L260)）
- `_request_raw` 生成 uuid 请求 id、注册容量 1 的 waiter，写消息失败时移除 waiter 并关掉临时订阅后重抛（[python/sdk/src/deepseek_harness/client.py:272-291](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L272-L291)）
- 传了 `on_notification` 而未传订阅时临时建一个订阅，等待结束在 finally 里关闭（[python/sdk/src/deepseek_harness/client.py:278-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L278-L280)）
- 等待响应期间用单调时钟算截止时间，带回调时以 50 毫秒为上限轮询并排空订阅队列（[python/sdk/src/deepseek_harness/client.py:292-318](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L292-L318)）
- 超时时移除 waiter 并把子进程诊断拼进 TimeoutError 文本（[python/sdk/src/deepseek_harness/client.py:301-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L301-L310)）
- 等到的项若是异常则抛出，否则作为 result 返回（[python/sdk/src/deepseek_harness/client.py:328-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L328-L330)）
- `_write_message` 在无进程或无 stdin 时抛 `TransportClosedError`，否则以紧凑 JSON 加换行、持写锁写入并 flush，写失败转成 TransportClosedError（[python/sdk/src/deepseek_harness/client.py:332-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L332-L342)）
- `_reader_loop` 按行读 stdout，跳过空行与 JSON 解析失败的行，异常与循环结束都会让所有等待者失败（[python/sdk/src/deepseek_harness/client.py:352-368](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L352-L368)）
- `_stderr_loop` 把 stderr 每行去尾空白后推入环形缓冲（[python/sdk/src/deepseek_harness/client.py:370-375](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L370-L375)）
- `_handle_message` 把同时带 id 和 method 的消息作为入站请求投进请求队列（[python/sdk/src/deepseek_harness/client.py:377-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L377-L385)）
- 只带 id 的消息取出对应 waiter，`error` 字段转 `JsonRpcError` 投入，否则投入 `result`（[python/sdk/src/deepseek_harness/client.py:386-396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L386-L396)）
- 只带 method 的消息构成通知：先在锁内记录会话父子关系并取订阅快照，再逐个按过滤器分发（[python/sdk/src/deepseek_harness/client.py:397-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L397-L416)）
- 过滤器抛异常时注销该订阅并把异常投给它，其余订阅继续分发（[python/sdk/src/deepseek_harness/client.py:406-413](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L406-L413)）
- 没有任何订阅收下的通知落入默认通知队列（[python/sdk/src/deepseek_harness/client.py:417-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L417-L418)）
- `_fail_waiters` 清空响应表与订阅表，把异常投给每个 waiter、每个订阅、默认通知队列和请求队列（[python/sdk/src/deepseek_harness/client.py:420-431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L420-L431)）
- `_runtime_diagnostics` 在进程已退出且不是自身线程时先 join stderr 线程 0.1 秒，再拼出退出码与 stderr 尾部（[python/sdk/src/deepseek_harness/client.py:437-456](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L437-L456)）
- 未指定 `dsh_bin` 时从 `deepseek_harness_runtime` 取捆绑启动参数，导入失败转成 `FileNotFoundError`（[python/sdk/src/deepseek_harness/client.py:458-467](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L458-L467)）
- 指定 `dsh_bin` 时展开用户目录并解析成绝对路径作为唯一 argv 前缀（[python/sdk/src/deepseek_harness/client.py:468-469](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L468-L469)）
- `dsh_home` 为空白抛 ValueError；给了就写进子进程 `DSH_HOME`；未给且环境里的 `DSH_HOME` 为空也抛 ValueError（[python/sdk/src/deepseek_harness/client.py:471-479](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L471-L479)）
- 每个 patch 展开成 `--patch <绝对路径>` 一对参数，最终 argv 为基底加 `--profile <profile>` 再加全部 patch（[python/sdk/src/deepseek_harness/client.py:481-486](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L481-L486)）
- `_record_session_relationship_locked` 只处理 `subagent.started`，在父子 id 都是非空字符串且不相等时记下 child→parent（[python/sdk/src/deepseek_harness/client.py:492-504](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L492-L504)）
- 会话树过滤器对 `subagent.started` / `subagent.finished` 按 parentSessionId 是否为该会话后代或 childSessionId 是否等于该会话判定，其余通知按 payload 的 sessionId 判定（[python/sdk/src/deepseek_harness/client.py:506-523](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L506-L523)）
- `_session_is_descendant_of` 沿父链上溯，用 visited 集合防止成环时死循环（[python/sdk/src/deepseek_harness/client.py:525-536](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L525-L536)）
- `NotificationSubscription.close` 幂等，仅第一次真正注销订阅（[python/sdk/src/deepseek_harness/client.py:557-561](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L557-L561)）
- `next()` 阻塞取一条通知，取到异常则抛出（[python/sdk/src/deepseek_harness/client.py:563-567](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L563-L567)）
- `drain()` 非阻塞排空队列并逐条回调，遇异常项抛出（[python/sdk/src/deepseek_harness/client.py:569-577](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L569-L577)）
- `_int_or_none` 把非整型的 JSON-RPC error code 归一成 None（[python/sdk/src/deepseek_harness/client.py:588-589](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/client.py#L588-L589)）

### python/sdk/src/deepseek_harness/errors.py

Python SDK 的异常层级，被 client 与 api 抛出、被使用者捕获。

- `JsonRpcError.__init__` 把 code、message、data 三个字段挂到异常实例上供调用方读取（[python/sdk/src/deepseek_harness/errors.py:19-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/errors.py#L19-L23)）

### python/sdk/src/deepseek_harness/models.py

Python SDK 的数据载体：JSON 类型别名、通知与入站请求数据类、initialize 响应的 pydantic 模型。

- `InitializeResponse` 与 `ServerInfo` 是 `client.request` 对 initialize 响应做 `model_validate` 的目标，字段全为可空（[python/sdk/src/deepseek_harness/models.py:26-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/python/sdk/src/deepseek_harness/models.py#L26-L32)）

### tsconfig.json

仓库根的 TypeScript solution 文件，供 `tsc -b`、tsserver 以及没有更近 tsconfig 的 tsx 脚本使用。

- `extends` 指向 `tsconfig.base.json`，把 paths 映射带给 get-tsconfig 消费者，使 tsx 跑 `scripts/` 时按该映射解析 workspace 导入（[tsconfig.json:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/tsconfig.json#L9)）
- `files: []` 让该文件不生成 program，只通过 references 指向 host 与 client 两个工程（[tsconfig.json:10-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/tsconfig.json#L10-L14)）

### tsdown.config.ts

仓库根的 tsdown 打包配置，`pnpm run build` 在 tsc 之后用它产出运行时 bundle。

- `isBuildFaceClient` 校验 `--env.DSH_BUILD_FACE`：未给或 `host` 为 host 面，`client` 为 client 面，其他值直接抛错（[tsdown.config.ts:4-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/tsdown.config.ts#L4-L8)）
- workspace 覆盖 `vendor/*`、`packages/*/*`、`apps/cli`（[tsdown.config.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/tsdown.config.ts#L19)）
- host 面入口取 `lib/types/{index,invariant,startup}.js`，client 面入口置空、由各包自己的配置决定产物（[tsdown.config.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/tsdown.config.ts#L20)）
- 输出目录 `lib`、格式 esm、平台 node、目标 es2024，且 `fixedExtension`、`dts`、`clean` 全部关闭（[tsdown.config.ts:21-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/tsdown.config.ts#L21-L27)）
- 只有 host 面挂载 `typertPlugin({ mode: 'workspace', faces: ['host'] })`（[tsdown.config.ts:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/tsdown.config.ts#L28)）

### vendor/AGENTS.md

`vendor/` 目录的说明文档，交代这里是上游框架的源码内联副本以及编辑禁忌。

- 无运行期机制

### vendor/CLAUDE.md

指向同目录 `AGENTS.md` 的符号链接，内容与之完全一致。

- 无运行期机制

### vendor/README.md

`vendor/` 的清单文档：记录每个内联包的上游名称与提交、第三方依赖去留、本地修改日志和同步步骤。

- 无运行期机制

### vitest.config.ts

单元测试的根 Vitest 配置，`pnpm run test` 与覆盖率闸门都从这里读取包含范围、平台裁剪、项目划分与覆盖率阈值。

- 把 `scripts/coverage-uncovered-locations.cjs` 解析成绝对路径作为 istanbul 自定义 reporter（[vitest.config.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L14)）
- `pathsPlugin` 用 `tsconfig.base.json` 的 paths 解析所有测试文件的 workspace 导入，优先级高于 package exports（[vitest.config.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L20)）
- win32 上列出不支持的包（bash 相关、hooks、terminal-bash、sandbox-local），pwsh 相关包仍保留（[vitest.config.ts:22-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L22-L36)）
- win32 上把这些包的 spec 连同若干 subprocess 与 webworker-runtime 用例一并排除（[vitest.config.ts:38-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L38-L58)）
- 非 linux 平台排除两个依赖 Worker 固定 Linux 平台的用例（[vitest.config.ts:62-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L62-L67)）
- win32 上把 `packages/subprocess/*` 追加进覆盖率排除包列表（[vitest.config.ts:71-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L71-L73)）
- 非 win32 平台排除仅在 Windows 执行的源文件（sandbox-windows-acl、windows-inspector.ts）的覆盖率（[vitest.config.ts:79-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L79-L87)）
- win32 上排除只作为子进程执行的 `sandbox-windows-acl/src/runner.ts` 的覆盖率（[vitest.config.ts:94-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L94-L96)）
- 用 `spawnSync` 实际探测 pwsh 是否可用来决定是否排除 pwsh-local / pwsh-sandbox 的覆盖率（[vitest.config.ts:105-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L105-L110)）
- 测试包含范围是 `packages/*/*/tests`、`apps/*/tests` 与 `scripts` 下的 spec（[vitest.config.ts:112-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L112-L116)）
- 覆盖率豁免环境变量取值既非空也非 `'1'` 时直接抛错终止配置加载（[vitest.config.ts:121-124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L121-L124)）
- 该变量为 `'1'` 时把重型套件从两个 project 的 include 中排除（[vitest.config.ts:125-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L125-L127)）
- 覆盖率分片模式环境变量同样只接受空或 `'1'`，否则抛错（[vitest.config.ts:129-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L129-L133)）
- 列出走进程隔离的 process-bound 套件清单（[vitest.config.ts:138-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L138-L147)）
- 顶层与两个 project 都以 `./scripts/test-invariants.ts` 作为 setupFile（[vitest.config.ts:152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L152)）
- `thread-safe` project 用 forks pool，include 全量、exclude 平台不支持项加 process-bound 加覆盖豁免项（[vitest.config.ts:159-176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L159-L176)）
- `process-bound` project 用 forks pool，只 include 上述清单（[vitest.config.ts:177-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L177-L190)）
- 覆盖率 provider 为 v8，统计范围限定 `packages/*/*/src/**/*.{ts,tsx}`（[vitest.config.ts:192-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L192-L197)）
- 覆盖率排除清单逐条列出 types/bin/worker 入口、self-modification、客户端 UI、webworker-runtime、inspector、typert 生成器等路径，并在末尾并入平台条件排除（[vitest.config.ts:200-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L200-L343)）
- 非分片模式下阈值为 per-file 的 statements/branches/functions/lines 全 100，分片模式下不设阈值（[vitest.config.ts:348-356](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L348-L356)）
- reporter 在分片模式下为空，CI 下为 text 加自定义 reporter，本地额外加 html（[vitest.config.ts:357-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.config.ts#L357-L361)）

### vitest.e2e.config.ts

真实 API 的 e2e 测试配置，`pnpm run test:e2e` 使用。

- 启动时尝试 `process.loadEnvFile('.env')`，文件不存在则静默忽略（[vitest.e2e.config.ts:9-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.e2e.config.ts#L9-L14)）
- `DSH_E2E_MAX_WORKERS` 必须是正整数，否则抛错；未设置时取默认值 4（[vitest.e2e.config.ts:16-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.e2e.config.ts#L16-L29)）
- 用 `tsconfig.base.json` 的 paths 插件与标准装饰器插件解析源码（[vitest.e2e.config.ts:39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.e2e.config.ts#L39)）
- setupFiles 加载 `./scripts/test-invariants.ts`（[vitest.e2e.config.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.e2e.config.ts#L42)）
- include 限定 `packages/*/*/tests` 与 `apps/cli/tests` 下的 `.e2e.ts`，exclude 掉 `.expected.e2e.ts` 与 inspector 浏览器用例（[vitest.e2e.config.ts:45-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.e2e.config.ts#L45-L49)）
- 测试超时 120 秒、钩子超时 30 秒、失败重试 2 次（[vitest.e2e.config.ts:53-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.e2e.config.ts#L53-L55)）
- 文件级并行开关与 maxWorkers 都由 `DSH_E2E_MAX_WORKERS` 决定，取 1 时退回串行（[vitest.e2e.config.ts:59-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.e2e.config.ts#L59-L60)）

### vitest.expected.config.ts

owner-local 的预期输出测试配置，`pnpm run test:expected` 使用。

- 用 paths 插件与标准装饰器插件解析源码，并加载 `./scripts/test-invariants.ts`（[vitest.expected.config.ts:8-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.expected.config.ts#L8-L11)）
- include 仅 `apps/cli/tests/**/*.expected.e2e.ts`（[vitest.expected.config.ts:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.expected.config.ts#L12-L14)）
- 测试超时 120 秒、钩子超时 30 秒，maxWorkers 取 5 与可用并行度的较小值（[vitest.expected.config.ts:15-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.expected.config.ts#L15-L17)）

### vitest.shared.ts

被各个 Vitest 配置共享的运行参数与转换插件。

- `vitestExecArgv` 在 Node 允许该标志时给测试 worker 传 `--no-webstorage`，否则为空数组（[vitest.shared.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.shared.ts#L9)）
- `standardDecoratorPlugin` 以 `enforce: 'pre'` 在 Vite 默认解析之前介入，只处理扩展名匹配且正则命中装饰器语法的文件（[vitest.shared.ts:15-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.shared.ts#L15-L21)）
- 命中的文件用 `ts.transpileModule` 转译，target ES2024、module ESNext、按文件名决定是否开 ReactJSX、开启 sourceMap（[vitest.shared.ts:22-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.shared.ts#L22-L30)）
- 转译结果里给 `__esDecorate(` 行插入 v8 ignore 注释、删掉 sourceMappingURL 注释，并连同 map 一起返回（[vitest.shared.ts:31-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.shared.ts#L31-L40)）

### vitest.snapshot.config.ts

录制会话回放快照测试的配置，`pnpm run test:snapshot` 与 record/refresh 流程使用。

- `DSH_SNAPSHOT_MAX_CONCURRENCY` 必须是正整数否则抛错，默认取 5 与可用并行度的较小值（[vitest.snapshot.config.ts:6-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.snapshot.config.ts#L6-L22)）
- 只有 `DSH_SNAPSHOT === 'record'` 时才加载 `.env`，且除 ENOENT 外的读取失败一律上抛（[vitest.snapshot.config.ts:29-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.snapshot.config.ts#L29-L37)）
- 用 paths 插件与标准装饰器插件解析源码，并加载 `./scripts/test-invariants.ts`（[vitest.snapshot.config.ts:43-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.snapshot.config.ts#L43-L46)）
- include 含语料脚本与 `snapshots/**/*.snapshot.ts`，`apps/web` 的快照仅在 `DSH_EXAMPLE_MODE === 'lib'` 时纳入（[vitest.snapshot.config.ts:47-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.snapshot.config.ts#L47-L52)）
- 测试超时 120 秒、钩子超时 30 秒（[vitest.snapshot.config.ts:62-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.snapshot.config.ts#L62-L63)）
- 仅在 `DSH_SNAPSHOT` 缺省或为 replay 且并发上限大于 1 时开启文件级并行，record 与 refresh 保持串行；in-file 并发由该上限控制（[vitest.snapshot.config.ts:64-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.snapshot.config.ts#L64-L65)）

### vitest.web-stress.config.ts

浏览器压力测试的独立配置，默认测试清单不包含 `*.stress.ts`，需显式指定该配置运行。

- 用 `tsconfig.base.json` 的 paths 插件解析导入（[vitest.web-stress.config.ts:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web-stress.config.ts#L7)）
- 测试 worker 使用共享的 `vitestExecArgv`（[vitest.web-stress.config.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web-stress.config.ts#L9)）
- include 仅 `apps/web/stress-tests/**/*.stress.ts`（[vitest.web-stress.config.ts:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web-stress.config.ts#L10)）
- 测试超时 600 秒、钩子超时 120 秒，且关闭文件级并行（[vitest.web-stress.config.ts:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web-stress.config.ts#L11-L13)）

### vitest.web.config.ts

浏览器通道的测试配置，覆盖 `apps/web` 的 e2e 与快照以及 inspector 的浏览器用例。

- 无条件尝试 `process.loadEnvFile('.env')`，不存在则忽略（[vitest.web.config.ts:9-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web.config.ts#L9-L14)）
- 用 paths 插件与标准装饰器插件解析导入（[vitest.web.config.ts:20-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web.config.ts#L20-L23)）
- 测试 worker 使用共享的 `vitestExecArgv`（[vitest.web.config.ts:25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web.config.ts#L25)）
- include 为 `apps/web/tests` 下的 `.e2e.ts` 与 `.snapshot.ts`，外加 inspector 的浏览器 e2e（[vitest.web.config.ts:26-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web.config.ts#L26-L30)）
- 测试超时 180 秒、钩子超时 120 秒，且关闭文件级并行（[vitest.web.config.ts:33-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web.config.ts#L33-L35)）

### vitest.web.perf.config.ts

手动运行的浏览器性能诊断配置，在 web 配置基础上改写执行参数与包含范围。

- 展开 `vitest.web.config.ts` 的顶层字段与 test 字段作为基底（[vitest.web.perf.config.ts:8-11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web.perf.config.ts#L8-L11)）
- 在共享 execArgv 后追加 `--expose-gc`（[vitest.web.perf.config.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web.perf.config.ts#L12)）
- include 改为 `apps/web/tests/**/*.perf.ts` 与 `ui-conversation` 的 `*.perf.client.ts`（[vitest.web.perf.config.ts:13-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web.perf.config.ts#L13-L16)）
- 关闭 console 拦截，钩子超时改为 180 秒、测试超时改为 600 秒（[vitest.web.perf.config.ts:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vitest.web.perf.config.ts#L17-L19)）
