---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/context/tmux-context
---

# packages/context/tmux-context

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、30 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/context/tmux-context/README.md

tmux 位置上下文插件的说明文档，描述注入时机、检测方式与配置字段。

- 无运行期机制

### packages/context/tmux-context/package.json

该包的 npm 清单，声明入口、子路径导出与发布文件集。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定默认加载的运行期模块（[packages/context/tmux-context/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*`、`./package.json` 四个子路径（[packages/context/tmux-context/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/package.json#L16-L27)）
- `files` 白名单限定发布产物为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/context/tmux-context/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/package.json#L28-L32)）

### packages/context/tmux-context/src/index.ts

插件主入口：在每轮首步通过 shell 执行器读取本进程所在的 tmux 位置，并在状态变化时追加一条带来源标注的上下文消息。

- 导出插件名 `tmux-context`，同时作为消息来源的 plugin 标识与 section 名（[packages/context/tmux-context/src/index.ts:28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L28)）
- `inject = ['agents']` 要求 agents 注册表就绪后才装载（[packages/context/tmux-context/src/index.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L31)）
- `Config` schema 声明 `refreshIntervalMs` 为数字，装载时校验（[packages/context/tmux-context/src/index.ts:40-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L40-L42)）
- `TMUX_FIELDS` 钉死查询字段与顺序：会话名、窗口序号与名字、面板序号与 id、窗口/面板活动标志、窗口布局；像素尺寸不在其中（[packages/context/tmux-context/src/index.ts:49-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L49-L58)）
- `READING_PREFIX` 固定读数首行的前缀文本（[packages/context/tmux-context/src/index.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L73)）
- `FIELD_SEP` 用字面两字符序列作字段分隔，避免命令里嵌入裸空白（[packages/context/tmux-context/src/index.ts:80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L80)）
- `queryTmuxLocation` 组装的命令依次要求 `$TMUX_PANE` 非空、`ps -o tty=` 取到本进程控制终端、`tmux display-message` 取到面板 tty，且面板 tty 等于 `/dev/<self_tty>`，任一不满足即 `exit 1`（[packages/context/tmux-context/src/index.ts:114-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L114-L121)）
- 命令经 `bash.resolve(...)` 再 `bash.run(...)` 执行，因而受部署的沙箱与策略约束（[packages/context/tmux-context/src/index.ts:124](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L124)）
- 执行器抛出时不让本轮失败：捕获后记一条 warn 日志并返回 undefined（[packages/context/tmux-context/src/index.ts:125-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L125-L129)）
- 退出码非 0 时判为无位置（[packages/context/tmux-context/src/index.ts:130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L130)）
- 只取 stdout 首行并按分隔符切分，字段数与 `TMUX_FIELDS` 不等时判为无位置（[packages/context/tmux-context/src/index.ts:131-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L131-L133)）
- 面板 id 为空串时判为无位置（[packages/context/tmux-context/src/index.ts:144](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L144)）
- `renderState` 渲染不含轮次前缀的两行稳定状态块，窗口名以 JSON 形式引号包裹（[packages/context/tmux-context/src/index.ts:162-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L162-L168)）
- `renderReading` 在状态块前加上带轮次号的首行，构成完整读数（[packages/context/tmux-context/src/index.ts:171-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L171-L173)）
- `latestInjectedState` 倒序扫描原始持久事件找本插件最近一次注入，取首个换行之后的部分作为状态块并带回事件时间；首块不是文本时返回 undefined（[packages/context/tmux-context/src/index.ts:181-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L181-L194)）
- `validateRefreshInterval` 对非非负安全整数的间隔抛 TypeError（[packages/context/tmux-context/src/index.ts:197-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L197-L206)）
- 以 `prepend: true` 注册 `agent/pre-step`，先 `next()` 委托下游，决策为 `reject`、信号已中止或 `step !== 1` 时原样返回（[packages/context/tmux-context/src/index.ts:218-223](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L218-L223)）
- 用 `ctx.get('shell')` 取可选服务，缺席时不注入也不报错（[packages/context/tmux-context/src/index.ts:224-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L224-L225)）
- 正的 `refreshIntervalMs` 下，距上次注入不足该毫秒数时直接返回原决策，连查询都不发（[packages/context/tmux-context/src/index.ts:227-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L227-L230)）
- 查询返回 undefined 时不注入（[packages/context/tmux-context/src/index.ts:231-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L231-L232)）
- 渲染出的状态块与上次注入相同时不注入，只有变化才追加（[packages/context/tmux-context/src/index.ts:233-234](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L233-L234)）
- 把读数作为一条 user 角色消息插到 `decision.messages` 之前，来源为 `{ kind: 'plugin', plugin: name, form: 'snapshot', sections: [{ name, text }] }`（[packages/context/tmux-context/src/index.ts:235-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/index.ts#L235-L245)）

### packages/context/tmux-context/src/invariant.ts

该包的不变式伴生插件，被 `./invariant` 子路径导出并由 invariants 服务加载。

- 导出插件名 `tmux-context-invariant` 与 `inject = ['invariants']`，决定装载顺序（[packages/context/tmux-context/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/invariant.ts#L13-L15)）
- 安装器为空函数，运行期不注册任何检查（[packages/context/tmux-context/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/invariant.ts#L21)）
- `apply` 以包名向 `ctx.invariants` 注册该安装器并返回其 disposer（[packages/context/tmux-context/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/tmux-context/src/invariant.ts#L28-L29)）

### packages/context/tmux-context/tsconfig.json

该包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区项目引用。

- 无运行期机制
