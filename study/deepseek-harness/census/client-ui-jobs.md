---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-jobs
---

# packages/client/ui-jobs

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、39 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-jobs/README.md

该包的说明文档，描述会话头部后台任务列表的用法、实现要点与已知限制，供包的使用者与维护者阅读。

- 无运行期机制

### packages/client/ui-jobs/package.json

该包的 npm 清单，声明入口映射、客户端插件元数据与发布文件集。

- `exports` 把 `.`、`./invariant`、`./client` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，并放开 `./src/*` 与 `./package.json`（[packages/client/ui-jobs/package.json:8-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/package.json#L8-L23)）
- `dsh.client` 声明浏览器半边的注入依赖（locale、ui-conversation、ui-primitives）与 `platform: "web"`，决定客户端插件行被装载时先注入哪些包（[packages/client/ui-jobs/package.json:24-33](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/package.json#L24-L33)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与类型声明（[packages/client/ui-jobs/package.json:70-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/package.json#L70-L75)）

### packages/client/ui-jobs/src/client/JobListAction.module.css

任务列表触发器与弹出列表的 CSS Module 样式表，被 `JobListAction.tsx` 以 `css.*` 引用。

- 无运行期机制

### packages/client/ui-jobs/src/client/JobListAction.tsx

会话头部的后台任务动作组件：读取 `jobsBySession` 镜像，渲染触发器与任务弹出列表。

- 用模块级常量 `NO_TASKS` 作为空任务时的稳定数组身份（[packages/client/ui-jobs/src/client/JobListAction.tsx:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L14)）
- `isLive` 把 `running` 与 `stopping` 判为存活状态（[packages/client/ui-jobs/src/client/JobListAction.tsx:17-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L17-L19)）
- `assertNever` 在遇到未列举的状态值时抛出错误（[packages/client/ui-jobs/src/client/JobListAction.tsx:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L23-L25)）
- `dotState` 把五种状态映射为状态点颜色，`stopping` 与 `killed` 同映射为 `warning`、`failed` 映射为 `error`（[packages/client/ui-jobs/src/client/JobListAction.tsx:31-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L31-L41)）
- `statusLabel` 把状态映射为 `status.*` 词条键并经 `t` 取词（[packages/client/ui-jobs/src/client/JobListAction.tsx:44-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L44-L54)）
- `formatDuration` 把毫秒下限截到 0 后按秒/分秒/时分三档取词，超过一小时仍以小时为最大单位（[packages/client/ui-jobs/src/client/JobListAction.tsx:62-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L62-L70)）
- `ordered` 先排存活行、存活行按 `startedAt` 升序，已结束行按 `finishedAt` 降序（缺失时回落到 `startedAt`），同毫秒时再按 `startedAt` 定序（[packages/client/ui-jobs/src/client/JobListAction.tsx:77-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L77-L85)）
- 组件从 `useSessions` 选取 `state.jobsBySession[sessionId]`，缺失时取 `NO_TASKS`，不发任何 RPC（[packages/client/ui-jobs/src/client/JobListAction.tsx:95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L95)）
- `rows` 与 `liveCount` 以 `useMemo` 依赖 `jobs` 派生（[packages/client/ui-jobs/src/client/JobListAction.tsx:101-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L101-L102)）
- `useDismissOnOutsidePointer` 让根元素外的指针按下关闭弹出列表（[packages/client/ui-jobs/src/client/JobListAction.tsx:104](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L104)）
- 仅当列表打开且存在存活任务时启动 1000ms 定时器刷新 `now`，条件不成立时清除定时器（[packages/client/ui-jobs/src/client/JobListAction.tsx:107-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L107-L112)）
- 任务数归零且列表处于打开状态时先置为关闭（[packages/client/ui-jobs/src/client/JobListAction.tsx:116-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L116-L118)）
- 任务数为 0 时整个组件返回 `null`，会话头部不出现该控件（[packages/client/ui-jobs/src/client/JobListAction.tsx:120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L120)）
- 计数词条键按「有存活任务取 live 且计数用 `liveCount`，否则取 idle 且计数用总数」并区分单复数选取（[packages/client/ui-jobs/src/client/JobListAction.tsx:122-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L122-L125)）
- Escape 键在列表打开时阻止默认行为、关闭列表并把焦点还给触发按钮（[packages/client/ui-jobs/src/client/JobListAction.tsx:127-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L127-L132)）
- 触发按钮暴露 `aria-expanded` 与以计数词条为内容的 `aria-label`（[packages/client/ui-jobs/src/client/JobListAction.tsx:140-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L140-L141)）
- 点击触发按钮在同一次提交里先采样 `Date.now()` 再翻转打开状态（[packages/client/ui-jobs/src/client/JobListAction.tsx:142-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L142-L149)）
- 仅在存在存活任务时渲染触发器上的状态点，并按打开状态给箭头图标加旋转类（[packages/client/ui-jobs/src/client/JobListAction.tsx:151-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L151-L153)）
- 列表仅在打开时渲染，`ul` 带 `list.aria` 无障碍名（[packages/client/ui-jobs/src/client/JobListAction.tsx:155-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L155-L157)）
- 每行时长：存活行取 `now - startedAt`，已结束行取 `finishedAt`（缺失时用 `startedAt`）减 `startedAt`（[packages/client/ui-jobs/src/client/JobListAction.tsx:160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L160)）
- 行以 `job.id` 为 key，已结束行追加淡化类（[packages/client/ui-jobs/src/client/JobListAction.tsx:164](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L164)）
- 行内渲染 `job.kind`、`job.label`（带 title），状态列优先显示 `job.detail`，缺失时才显示状态词（[packages/client/ui-jobs/src/client/JobListAction.tsx:165-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L165-L168)）
- 时长列的 title 按行是否存活取 `duration.title.live` 或 `duration.title.done`（[packages/client/ui-jobs/src/client/JobListAction.tsx:169-174](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/JobListAction.tsx#L169-L174)）

### packages/client/ui-jobs/src/client/index.ts

浏览器半边的插件入口，注册词条字典并把任务动作挂到会话头部槽位。

- 声明所需服务注入 `sessions`、`slots`、`locale`（[packages/client/ui-jobs/src/client/index.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/index.ts#L24)）
- 以 `ctx.effect` 注册 `job` 命名空间的 zh/en 字典，并把注销挂在 effect 上（[packages/client/ui-jobs/src/client/index.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/index.ts#L31)）
- 通过 `ctx.slots.inject` 把 `JobListAction` 以 id `job-list`、`order: 20`、locale 为 `job` 注册进 `conversation.session.header.actions` 槽位（[packages/client/ui-jobs/src/client/index.ts:32-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/index.ts#L32-L41)）

### packages/client/ui-jobs/src/client/locales.ts

`job` 命名空间的词条字典模块，被客户端入口注册、被组件通过 `t` 查表。

- 导出命名空间常量 `NS = 'job'`，作为字典注册键与槽位注册的 locale 值（[packages/client/ui-jobs/src/client/locales.ts:4](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/locales.ts#L4)）
- zh 与 en 两份字典给出组件用到的全部键及 `{count}`/`{seconds}`/`{minutes}`/`{hours}`/`{duration}` 插值占位符（[packages/client/ui-jobs/src/client/locales.ts:7-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/client/locales.ts#L7-L42)）

### packages/client/ui-jobs/src/css-modules.d.ts

CSS Module 的 TypeScript 环境声明文件。

- 无运行期机制

### packages/client/ui-jobs/src/index.ts

宿主半边的插件入口，供宿主 cordis.yml / Loader 装载。

- 导出空的 `apply`，插件被 Loader 装载但不注册任何宿主侧行为（[packages/client/ui-jobs/src/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/index.ts#L9)）

### packages/client/ui-jobs/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属。

- 声明伴生插件名与所需的 `invariants` 服务注入（[packages/client/ui-jobs/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/invariant.ts#L13-L15)）
- 安装器为空函数，`apply` 以包名注册该空安装器并返回注册的注销函数（[packages/client/ui-jobs/src/invariant.ts:23-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/src/invariant.ts#L23-L31)）

### packages/client/ui-jobs/tsconfig.json

该包的 TypeScript 编译配置与工程引用。

- 无运行期机制

### packages/client/ui-jobs/tsdown.config.ts

打包配置，决定该包产出哪些运行时 bundle。

- 以包名与入口列表 `lib/types/index.js`、`lib/types/invariant.js` 调用共享的 `clientBundle`，确定打包入口（[packages/client/ui-jobs/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-jobs/tsdown.config.ts#L3)）
