---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/extensions/tool-cordis
---

# packages/extensions/tool-cordis

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、137 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/extensions/tool-cordis/README.md

该包的说明文档，面向挂载与使用这套运行期动态插件工具集的读者，记录工具集的组合方式、七个工具的行为、系统提示词分节与运行期生效范围。

- 记录该工具集需要与宿主 runner 一同组合，否则工具不激活，且没有任何已发布 bundle 挂载它，需显式加入（[packages/extensions/tool-cordis/README.md:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L28)）
- 给出最小组合配置：宿主 runner 带 `vmTimeoutMs: 5000`，其后是本工具集条目（[packages/extensions/tool-cordis/README.md:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L32-L37)）
- 记录三个查询工具只读、四个生命周期工具负责定义与管理，所有结果以 JSON 文本返回给模型（[packages/extensions/tool-cordis/README.md:43-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L43-L47)）
- 记录 define 只做参数与语法校验，不运行任何东西也不请求批准，可新建插件或为既有插件追加新版本（[packages/extensions/tool-cordis/README.md:48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L48)）
- 记录 run 以 run/update 两种模式激活一个包，带浏览器半边时可返回 `awaiting-approval`，且工具本身不等待最终结果（[packages/extensions/tool-cordis/README.md:49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L49)）
- 记录 stop 停止当前运行并取消待批准，保留插件与全部版本；undefine 停止并永久移除插件及其所有包（[packages/extensions/tool-cordis/README.md:50-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L50-L51)）
- 记录用户输入 `@pluginId` 时该包注入一条上下文消息，钉住被引用插件、其基础包与更新路径（[packages/extensions/tool-cordis/README.md:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L55)）
- 记录定义只存在于进程内存并按会话作用域可见，跨轮次保持激活、可影响同进程其他会话，停止/移除/卸载工具集/重启进程都会清除（[packages/extensions/tool-cordis/README.md:59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L59)）
- 记录调用流向：查询走 `ctx.cordisInspect`，宿主 provider 本地执行、客户端 provider 等待首个有效页面响应；define 用沙箱同款包装体编译预检；run 委托 runner 并返回其回执（[packages/extensions/tool-cordis/README.md:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L88)）
- 记录插件可见时模型固定看到七个工具的生成 schema（[packages/extensions/tool-cordis/README.md:115-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L115-L119)）
- 记录该包注册一个系统提示词分节 `tool:cordis`、order 115，其文本在插件可见时随每次请求重复发送（[packages/extensions/tool-cordis/README.md:129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L129)）
- 钉住该分节的开头文本，说明动态插件用 `apply(ctx)` 消费服务、监听事件、提供服务、注册模型工具或在 Slot 中注册浏览器 UI（[packages/extensions/tool-cordis/README.md:133-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L133-L137)）
- 记录各工具回传模型的内容形状：查询输出为 JSON 文本，define 回答已定义未运行并给出运行所需 id，run 回报 `awaiting-approval`/`starting`/`running` 与 run id 及版本指针，拒绝一律为携带 runner 教学文本的工具错误，且提交的程序留在助手工具调用历史中（[packages/extensions/tool-cordis/README.md:151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L151)）
- 记录运行中的包可注册工具、提示词贡献与监听器，改变其目标作用域的后续请求，stop 与 undefine 在静默后移除这些贡献（[packages/extensions/tool-cordis/README.md:165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L165)）
- 记录动态包代码不做任何转换：不支持 TypeScript、JSX 与 import，沙箱不提供 `require`、`setTimeout`、`fetch`，文件系统、网络与进程操作被导向 Cordis 服务（[packages/extensions/tool-cordis/README.md:183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L183)）
- 记录宿主实境的辅助对象在沙箱全局上可达，包代码可触及 Node，沙箱不构成安全边界；异步宿主半边会逃出 `vmTimeoutMs`（[packages/extensions/tool-cordis/README.md:182-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/README.md#L182-L184)）

### packages/extensions/tool-cordis/package.json

该包的 npm 清单，声明模块类型、入口、导出映射、发布文件白名单与运行期同伴依赖。

- 声明 `"type": "module"`，包内文件按 ESM 解析（[packages/extensions/tool-cordis/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/package.json#L13)）
- 把主入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/extensions/tool-cordis/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/package.json#L14-L15)）
- 导出映射开放四条子路径：根入口、`./invariant`、透传源码的 `./src/*` 与 `./package.json`，其余路径不可被外部引入（[packages/extensions/tool-cordis/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/package.json#L16-L27)）
- 发布文件白名单只含 `lib/index.js`、`lib/invariant.js` 与 `lib/types/**/*.d.ts`（[packages/extensions/tool-cordis/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/package.json#L28-L32)）
- 把 agent、cordis 宿主 runner、invariants、llm、scope、session、system-prompt、tools 与 cordis 本体列为 peerDependencies，由宿主安装提供（[packages/extensions/tool-cordis/package.json:34-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/package.json#L34-L44)）

### packages/extensions/tool-cordis/src/api-catalog.ts

由生成脚本产出的 Cordis API 目录数据模块，导出服务表、事件表、类型表、继承 `ctx` 成员表四个常量与两个投影函数，被同包的 `inspect.ts`（渲染 `cordis_inspect` 文本）和 `providers.ts`（服务/事件两个查询 provider）读取。

- `SERVICE_API` 导出 68 条按 key 排序的 `ctx.<key>` 服务条目，是服务查询能列举与检索的全部内容（[packages/extensions/tool-cordis/src/api-catalog.ts:83-2857](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L83-L2857)）
- 每条服务条目给出 key、summary、description 与按源码顺序排列的方法表，方法行由 signature、description、parameters 组成，returns 与 throws 按有无出现（[packages/extensions/tool-cordis/src/api-catalog.ts:84-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L84-L102)）
- 只读属性成员同样以一条 signature 行进入方法表，parameters 为空数组（[packages/extensions/tool-cordis/src/api-catalog.ts:109-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L109-L112)）
- 方法 signature 字符串逐字保留 `@Remote('...')` 装饰器文本（[packages/extensions/tool-cordis/src/api-catalog.ts:145](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L145)）
- 流式方法的 `@Remote({ mode: 'stream' })` 前缀也原样留在 signature 中（[packages/extensions/tool-cordis/src/api-catalog.ts:1429](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L1429)）
- `abstract` 成员以带 `abstract` 前缀的 signature 进入方法表（[packages/extensions/tool-cordis/src/api-catalog.ts:463](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L463)）
- description 字段内嵌 `\n\n` 分段的长文本，整段随查询结果带出（[packages/extensions/tool-cordis/src/api-catalog.ts:166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L166)）
- throws 以字符串数组记录失败条件，包含带稳定错误码的远程失败列举（[packages/extensions/tool-cordis/src/api-catalog.ts:189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L189)）
- `timer` 条目把同名重载展开成多条独立 signature 行，parameters 均为空（[packages/extensions/tool-cordis/src/api-catalog.ts:2416-2443](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L2416-L2443)）
- `EVENT_API` 导出 65 条按名字排序的事件条目（[packages/extensions/tool-cordis/src/api-catalog.ts:2860-3381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L2860-L3381)）
- 每条事件条目给出 name、mode、signature、summary、description、parameters（[packages/extensions/tool-cordis/src/api-catalog.ts:2862-2867](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L2862-L2867)）
- mode 字段取自声明的 `@mode` 标签，实际出现 `emit`（[packages/extensions/tool-cordis/src/api-catalog.ts:2863](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L2863)）
- mode 取 `waterfall` 的事件其 signature 末位是 `next` 回调（[packages/extensions/tool-cordis/src/api-catalog.ts:2927](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L2927)）
- mode 还出现 `serial`（[packages/extensions/tool-cordis/src/api-catalog.ts:2967](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L2967)）
- mode 还出现 `parallel`（[packages/extensions/tool-cordis/src/api-catalog.ts:3191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L3191)）
- 事件 signature 是空白归一化后的完整监听器声明，含 `this: Scoped<...>` 接收者与 waterfall 的 `next` 形参（[packages/extensions/tool-cordis/src/api-catalog.ts:2928](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L2928)）
- 事件 parameters 用 `.字段 - 说明` 的写法描述 payload 成员并附带分发过滤说明（[packages/extensions/tool-cordis/src/api-catalog.ts:2883](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L2883)）
- `TYPE_API` 导出 682 条按名字排序的类型条目，每条是 name 加带 `\n` 转义的完整声明文本（[packages/extensions/tool-cordis/src/api-catalog.ts:3384-6113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L3384-L6113)）
- 声明文本形态包含 interface、type 别名，以及展开成员列表的 class（[packages/extensions/tool-cordis/src/api-catalog.ts:4239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L4239)）
- 一条超长声明在末尾以字面标记 `/* …truncated — full shape in source */` 截断（[packages/extensions/tool-cordis/src/api-catalog.ts:4795](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L4795)）
- 另一条超长 class 声明用同一标记截断（[packages/extensions/tool-cordis/src/api-catalog.ts:5427](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L5427)）
- `INHERITED_CTX_API` 导出 10 行 name 加 summary 的继承 `ctx` 成员表，按人工顺序排列（[packages/extensions/tool-cordis/src/api-catalog.ts:6116-6127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6116-L6127)）
- `referencedTypeClosure` 从若干种子文本出发在 `TYPE_API` 上逐层扩展，直到没有新条目命中（[packages/extensions/tool-cordis/src/api-catalog.ts:6129-6144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6129-L6144)）
- 扩展时跳过已收录条目，并用 `\b<name>\b` 词边界正则去测试当前一轮的文本（[packages/extensions/tool-cordis/src/api-catalog.ts:6135-6137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6135-L6137)）
- 命中的条目记入集合，其声明文本成为下一轮的匹配输入，从而把嵌套引用的类型一并拉入（[packages/extensions/tool-cordis/src/api-catalog.ts:6138-6141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6138-L6141)）
- 返回值按 `TYPE_API` 原有顺序过滤输出，而非按命中顺序（[packages/extensions/tool-cordis/src/api-catalog.ts:6143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6143)）
- `contextProperty` 用标识符正则决定注入表达式写成 `ctx.<key>` 还是 `ctx["<key>"]`（[packages/extensions/tool-cordis/src/api-catalog.ts:6146-6148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6146-L6148)）
- `queryServiceApi` 的 services 形参默认取 `SERVICE_API`，调用方可传入按平台裁剪后的条目集（[packages/extensions/tool-cordis/src/api-catalog.ts:6156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6156)）
- 省略 key 时返回 `mode: 'catalog'`：每个服务只给 key、用 summary 充当 description、以及仅剩 signature 的方法列表（[packages/extensions/tool-cordis/src/api-catalog.ts:6157-6166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6157-L6166)）
- key 在给定集合中找不到时抛出带该 key 的 `no catalogued Service named` 错误（[packages/extensions/tool-cordis/src/api-catalog.ts:6167-6168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6167-L6168)）
- 命中 key 时返回 `mode: 'service'`，带完整 description 与 access.optional 的 `ctx.get("<key>")` 表达式及 requiresUndefinedCheck 标记（[packages/extensions/tool-cordis/src/api-catalog.ts:6169-6175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6169-L6175)）
- access.hardDependency 给出 inject 数组与 `contextProperty` 生成的属性访问表达式（[packages/extensions/tool-cordis/src/api-catalog.ts:6176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6176)）
- 详情分支原样带出全部方法，并附上以所有方法 signature 为种子算得的 referencedTypes（[packages/extensions/tool-cordis/src/api-catalog.ts:6178-6180](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6178-L6180)）
- `queryEventApi` 的 events 形参默认取 `EVENT_API`，同样允许传入裁剪后的集合（[packages/extensions/tool-cordis/src/api-catalog.ts:6190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6190)）
- 省略 name 时返回 `mode: 'catalog'` 的事件目录：name、用 summary 充当 description、mode 与 signature（[packages/extensions/tool-cordis/src/api-catalog.ts:6191-6200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6191-L6200)）
- name 找不到时抛出带该名字的 `no catalogued Event named` 错误（[packages/extensions/tool-cordis/src/api-catalog.ts:6202-6203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6202-L6203)）
- 命中 name 时返回 `mode: 'event'` 的完整监听契约（description、mode、signature、parameters），并附上以该 signature 为唯一种子算得的 referencedTypes（[packages/extensions/tool-cordis/src/api-catalog.ts:6204-6213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/api-catalog.ts#L6204-L6213)）

### packages/extensions/tool-cordis/src/fiber-state.ts

镜像 cordis `FiberState` const enum 的运行期取值与文字标签，被同包的 inspect 渲染与状态比较使用。

- `FiberState` 以对象形式给出六个生命周期取值，供运行期比较使用（[packages/extensions/tool-cordis/src/fiber-state.ts:11-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/fiber-state.ts#L11-L18)）
- `STATE_LABELS` 把每个取值映射成报告里打印的文本（[packages/extensions/tool-cordis/src/fiber-state.ts:24-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/fiber-state.ts#L24-L31)）

### packages/extensions/tool-cordis/src/index.ts

本包插件入口：注册面向模型的七个 Cordis 工具、系统提示分节与 Host inspect 提供方，并在每一步前注入 `@pluginId` 引用上下文。

- `requireAgent` 在 `exec.agent` 缺失时抛错，使这些工具只能在 Agent 支撑的会话里执行（[packages/extensions/tool-cordis/src/index.ts:29-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L29-L32)）
- 向 `systemPrompt` 注册名为 `tool:cordis` 的分节，排序取 `FIRST_PARTY_SECTION_ORDER.TOOL_CORDIS`，正文为 `CORDIS_SYSTEM_PROMPT`（[packages/extensions/tool-cordis/src/index.ts:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L36-L40)）
- 把 `hostInspectProviders(ctx)` 返回的每个提供方通过 `ctx.effect` 注册进 `cordisInspect`（[packages/extensions/tool-cordis/src/index.ts:41-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L41-L43)）
- 注册 `cordis_inspect_list`：无参数，execute 返回 `ctx.cordisInspect.list()`，render 把结果按缩进 JSON 转成文本（[packages/extensions/tool-cordis/src/index.ts:45-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L45-L62)）
- 注册 `cordis_inspect_query`：platform 限定 host/client 枚举，provider/method 必填，input 可选（[packages/extensions/tool-cordis/src/index.ts:76-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L76-L81)）
- `cordis_inspect_query` 的 execute 携带调用方 agent 与 `exec.signal` 调用 `ctx.cordisInspect.query`，并把 platform/provider/method 回填进结果（[packages/extensions/tool-cordis/src/index.ts:86-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L86-L96)）
- `cordis_inspect_self` 在只给 `packageId` 而无 `pluginId` 时抛错（[packages/extensions/tool-cordis/src/index.ts:119-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L119-L121)）
- `cordis_inspect_self` 分三级返回：无 ID 时列 Plugin 摘要，仅 pluginId 时附版本指针与 Package 列表并标出 isCurrent/isNext，两者齐全时转入单包检查（[packages/extensions/tool-cordis/src/index.ts:122-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L122-L147)）
- `cordis_define` 的 plugin 参数以 oneOf 区分 new（只收 3–6 位小写前缀）与 existing（收确切 pluginId）（[packages/extensions/tool-cordis/src/index.ts:164-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L164-L188)）
- `cordis_define` 的输出 render 声明该定义尚未运行并指向 `cordis_run`，presentationMeta 记录 pluginId 与 packageId（[packages/extensions/tool-cordis/src/index.ts:214-219](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L214-L219)）
- `cordis_define` 的 execute 以调用方 agent.id 作 sessionId 调用 `dynamicCordisRunner.define`，并只透传实际给出的 host/client 源码（[packages/extensions/tool-cordis/src/index.ts:221-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L221-L240)）
- `cordis_run` 的 render 依据 status 分别输出 awaiting-approval、starting、running 三种文本（[packages/extensions/tool-cordis/src/index.ts:268-281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L268-L281)）
- `cordis_run` 的 presentationMeta 记录 pluginId、packageId、pluginRunId（[packages/extensions/tool-cordis/src/index.ts:282-289](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L282-L289)）
- `cordis_run` 的 execute 在 `!receipt.ok` 时抛错，status 非 running 时返回状态与版本指针，running 时从 snapshot 取活动 fiber 并算出 host/client 的 status、provides、waitingFor（[packages/extensions/tool-cordis/src/index.ts:291-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L291-L329)）
- `cordis_stop` 的 execute 只在失败且 reason 不是 `not-running` 时抛错，其余情况按成功返回（[packages/extensions/tool-cordis/src/index.ts:347-351](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L347-L351)）
- `cordis_undefine` 的 execute 失败抛错，成功返回 pluginId 与 wasRunning（[packages/extensions/tool-cordis/src/index.ts:377-381](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L377-L381)）
- 在 `agent/pre-step` 上挂 waterfall 监听：先调 `next()`，decision 为 reject 时原样返回，否则把引用上下文消息追加到 `decision.messages` 末尾（[packages/extensions/tool-cordis/src/index.ts:385-402](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L385-L402)）
- 注入的消息以 `createUserMessage` 构造，source 标为本插件的 instructions 形态，并在注入前检查取消信号（[packages/extensions/tool-cordis/src/index.ts:389-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L389-L400)）
- `requireJsonObject` 与 `requireJsonString` 在渲染前对 JSON 结果做形状断言并抛错（[packages/extensions/tool-cordis/src/index.ts:405-416](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L405-L416)）
- `selfSummary` 把引用折算成 pluginId、名称、包数、状态、版本指针、活动运行与待审批信息（[packages/extensions/tool-cordis/src/index.ts:420-444](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L420-L444)）
- `selfState` 按 latestRun 状态与版本指针把引用归为七个状态之一（[packages/extensions/tool-cordis/src/index.ts:446-455](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L446-L455)）
- `inspectSelfPackage` 合成单个 Package 的源码、host/client 状态、provides、waitingFor、handlers、错误与客户端渲染失败（[packages/extensions/tool-cordis/src/index.ts:457-499](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L457-L499)）
- `referencedPluginIds` 只扫描 source.kind 为 user 的消息文本，用 `@([a-z]{3,6}-\d+)` 正则去重提取（[packages/extensions/tool-cordis/src/index.ts:501-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L501-L510)）
- `renderReference` 生成 `<cordis_dynamic_plugin_context>` 包裹的文本：引用的 JSON、指定基线 Package、要求先 inspect_self 再以 existing 追加，并按 currentPackageId 是否存在指定 run 或 update（[packages/extensions/tool-cordis/src/index.ts:512-524](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L512-L524)）
- `renderUnavailableReference` 在引用不可用时生成告知文本，并禁止声称已更新或另建替代 Plugin（[packages/extensions/tool-cordis/src/index.ts:526-534](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/index.ts#L526-L534)）

### packages/extensions/tool-cordis/src/inspect.ts

把生成的 API 目录与活运行时联接后渲染成文本段落的函数集合，供本包的运行时检查输出与 `index.ts` 的状态计算调用。

- `liveImpls` 从 `ctx.reflect.store` 的 symbol 键读出全部活服务注册（[packages/extensions/tool-cordis/src/inspect.ts:36-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L36-L41)）
- `plainSummary` 把摘要里的 `{@link X}` 还原成裸符号（[packages/extensions/tool-cordis/src/inspect.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L49-L51)）
- `liveServices` 用目录联接活服务，未被目录覆盖的活服务保留在列表中但无签名，并按名排序（[packages/extensions/tool-cordis/src/inspect.ts:59-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L59-L74)）
- `absentServices` 列出目录里有、当前无活提供者的服务名（[packages/extensions/tool-cordis/src/inspect.ts:77-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L77-L80)）
- `withinFiber` 沿 parent 链上溯判断某 fiber 是否位于给定子树内（[packages/extensions/tool-cordis/src/inspect.ts:88-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L88-L96)）
- `providedServices` 返回某 fiber 子树提供的服务名并按字典序排列（[packages/extensions/tool-cordis/src/inspect.ts:104-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L104-L109)）
- `missingServices` 返回 fiber `inject` 中 `ctx.get` 当前取不到的服务名（[packages/extensions/tool-cordis/src/inspect.ts:119-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L119-L121)）
- `describeServices` 每个活服务输出一行，非 active 时附状态、有目录条目时附摘要，无服务时输出占位行（[packages/extensions/tool-cordis/src/inspect.ts:131-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L131-L139)）
- `describePlugins` 遍历 registry 的全部 fiber，按名排序后逐行输出名字与状态（[packages/extensions/tool-cordis/src/inspect.ts:149-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L149-L157)）
- `describeTools` 输出 `ctx.tools.schemas(scope)` 中的工具名，scope 缺省即全局视角（[packages/extensions/tool-cordis/src/inspect.ts:167-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L167-L169)）
- `describeDynamic` 无 agent 或无行时输出"定义只存在于本进程、重启即清空"的占位行（[packages/extensions/tool-cordis/src/inspect.ts:180-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L180-L184)）
- `describeDynamic` 每个 Plugin 输出版本指针与活动运行的头行，每个 Package 输出 halves、状态、purpose，活动包再附 provides、waiting、host methods 与客户端渲染失败（[packages/extensions/tool-cordis/src/inspect.ts:185-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L185-L208)）
- `typeClosure` 以词边界正则从种子文本出发，迭代求出被引用类型声明的传递闭包并按名排序（[packages/extensions/tool-cordis/src/inspect.ts:216-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L216-L232)）
- `serviceLines` 逐条渲染签名，命中结构化契约时补 description、`@param`、`@returns`、`@throws`（[packages/extensions/tool-cordis/src/inspect.ts:235-251](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L235-L251)）
- `describeApi` 在给定 name 时，目录中不存在或当前未运行分别抛错，并把渲染范围收窄为该服务且带上结构化契约（[packages/extensions/tool-cordis/src/inspect.ts:276-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L276-L283)）
- `describeApi` 未给 name 时补出未编目活服务行（提示 inject 仍可达）与 not running 行（[packages/extensions/tool-cordis/src/inspect.ts:285-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L285-L292)）
- `describeApi` 追加被选中签名引用到的类型声明段，未给 name 时再追加 inherited ctx API 段（[packages/extensions/tool-cordis/src/inspect.ts:293-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L293-L303)）
- `describeEvents` 在给定 name 且找不到时抛错，命中时只渲染该事件并展开 description 与 `@param`（[packages/extensions/tool-cordis/src/inspect.ts:315-329](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L315-L329)）
- `describeEvents` 末尾恒定追加 waterfall 监听必须调用 `next()` 的提示行（[packages/extensions/tool-cordis/src/inspect.ts:330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/inspect.ts#L330)）

### packages/extensions/tool-cordis/src/invariant.ts

本包的不变量伴生插件，向 `invariants` 服务登记包名。

- 声明伴生插件名与 `inject = ['invariants']`，使其在该服务就绪后才激活（[packages/extensions/tool-cordis/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/invariant.ts#L13-L15)）
- `apply` 以空 installer 向 `invariants` 注册包名并返回其 disposer（[packages/extensions/tool-cordis/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/invariant.ts#L21-L29)）

### packages/extensions/tool-cordis/src/present.ts

为各 Cordis 工具调用生成可重放的展示意图，被 `index.ts` 的 `presentCall` 引用。

- `presentRuntimeInspectCall` 按 what/name 拼出标题，输出 kind 为 read 的 generic 卡（[packages/extensions/tool-cordis/src/present.ts:10-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/present.ts#L10-L13)）
- `presentInspectListCall` 输出固定标题的 read 卡（[packages/extensions/tool-cordis/src/present.ts:19-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/present.ts#L19-L21)）
- `presentInspectQueryCall` 把 platform、provider、method 拼进标题（[packages/extensions/tool-cordis/src/present.ts:28-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/present.ts#L28-L30)）
- `presentInspectSelfCall` 按是否给出 pluginId/packageId 选择三种标题写法（[packages/extensions/tool-cordis/src/present.ts:37-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/present.ts#L37-L42)）
- `presentPackageInspectCall` 用 pluginId/packageId 拼出 read 卡标题（[packages/extensions/tool-cordis/src/present.ts:49-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/present.ts#L49-L51)）
- `presentDefineCall` 输出 kind 为 execute 的卡，标题含名称、目标与 purpose，并把源码放进 `rawInput`（[packages/extensions/tool-cordis/src/present.ts:58-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/present.ts#L58-L71)）
- `presentUndefineCall` 输出 kind 为 delete 的卡（[packages/extensions/tool-cordis/src/present.ts:78-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/present.ts#L78-L80)）
- `presentRunCall` 按 mode 在 Update 与 Run 之间切换标题，输出 execute 卡（[packages/extensions/tool-cordis/src/present.ts:87-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/present.ts#L87-L93)）
- `presentStopCall` 输出带 pluginId 的 execute 卡（[packages/extensions/tool-cordis/src/present.ts:100-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/present.ts#L100-L102)）

### packages/extensions/tool-cordis/src/prompt.ts

导出被注册为系统提示分节的整段文本常量，由 `index.ts` 装入模型上下文。

- 定义 `CORDIS_SYSTEM_PROMPT`，整段文本作为系统提示分节正文进入模型可见上下文（[packages/extensions/tool-cordis/src/prompt.ts:3-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L3-L107)）
- 文本声明定义只存在于当前进程、不改动仓库与磁盘、重启不留存，且受限执行环境不是安全边界（[packages/extensions/tool-cordis/src/prompt.ts:7-8](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L7-L8)）
- 文本规定何时才考虑动态插件、最多问一个澄清问题、Host/Client 由模型自行选择（[packages/extensions/tool-cordis/src/prompt.ts:12-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L12-L16)）
- 文本规定 awaiting-approval 不得等待或重试、starting 不等于成功、被拒后不得再次申请审批（[packages/extensions/tool-cordis/src/prompt.ts:18-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L18-L20)）
- 文本给出先加载技能、再按七步调用七个工具的推荐顺序（[packages/extensions/tool-cordis/src/prompt.ts:24-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L24-L32)）
- 文本规定 pluginId/packageId/pluginRunId/current/next 的含义与单双勾授权范围（[packages/extensions/tool-cordis/src/prompt.ts:40-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L40-L46)）
- 文本规定 `@pluginId` 到来时的三步处理，并禁止另建 Plugin（[packages/extensions/tool-cordis/src/prompt.ts:48-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L48-L54)）
- 文本规定 `ctx.get` 与 `inject` 的取用规则并给出示例代码（[packages/extensions/tool-cordis/src/prompt.ts:60-73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L60-L73)）
- 文本规定动态代码只能是纯 JavaScript、Client 必须用 `React.createElement`、不得假定任何全局对象存在（[packages/extensions/tool-cordis/src/prompt.ts:77-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L77-L80)）
- 文本禁止对活数据做 `JSON.stringify`、`structuredClone`、递归枚举或整体展示（[packages/extensions/tool-cordis/src/prompt.ts:84-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L84-L86)）
- 文本要求一切副作用挂在当前 Fiber，并经 `ctx.effect()`／`ctx.on()` 或返回 disposer 的 API 注册（[packages/extensions/tool-cordis/src/prompt.ts:90-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L90-L92)）
- 文本规定 Host 与 Client 的分工、经 `harness.handle`／`host.call` 的 Client→Host 单向 JSON 通道，以及 Client UI 必须注册进已查询的 Slot（[packages/extensions/tool-cordis/src/prompt.ts:96-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L96-L99)）
- 文本规定不得在工具内等待异步结果，失败后经 `cordis_inspect_self` 读诊断并在同一 Plugin 下自主重试（[packages/extensions/tool-cordis/src/prompt.ts:104-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/prompt.ts#L104-L107)）

### packages/extensions/tool-cordis/src/providers.ts

构造本包注册进 `cordisInspect` 的四个 Host 提供方，被 `index.ts` 的 apply 调用。

- `HOST_EVENTS` 从事件目录中滤掉 `cordis/` 前缀的事件（[packages/extensions/tool-cordis/src/providers.ts:19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/providers.ts#L19)）
- Service 提供方以 `listService` 方法把输入里的 `service` 字段转交 `queryServiceApi`（[packages/extensions/tool-cordis/src/providers.ts:28-35](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/providers.ts#L28-L35)）
- Event 提供方以 `listEvents` 方法把 `event` 字段与 `HOST_EVENTS` 一起转交 `queryEventApi`（[packages/extensions/tool-cordis/src/providers.ts:36-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/providers.ts#L36-L43)）
- Builtin 提供方以 `listBuiltins` 返回 `HOST_BUILTIN_INSPECTION` 与空的 referencedTypes（[packages/extensions/tool-cordis/src/providers.ts:44-47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/providers.ts#L44-L47)）
- Tool 提供方以 `listTools` 返回 `ctx.tools.schemas(context.agent)`，方法名不符时抛错（[packages/extensions/tool-cordis/src/providers.ts:48-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/providers.ts#L48-L63)）
- `registration` 生成单方法 manifest，并在被请求的方法名不匹配时抛错（[packages/extensions/tool-cordis/src/providers.ts:67-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/providers.ts#L67-L91)）
- `exactInput` 生成只含一个可选字符串字段、禁止额外属性的输入 schema（[packages/extensions/tool-cordis/src/providers.ts:93-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/providers.ts#L93-L95)）
- `readExact` 只在输入为普通对象且目标字段为字符串时返回该值，否则返回 undefined（[packages/extensions/tool-cordis/src/providers.ts:97-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/extensions/tool-cordis/src/providers.ts#L97-L101)）

### packages/extensions/tool-cordis/tsconfig.json

本包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制
