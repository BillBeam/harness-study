---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/context/time-context
---

# packages/context/time-context

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、51 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/context/time-context/README.md

时间上下文插件的说明文档，描述注入内容、配置字段与时区选择规则。

- 无运行期机制

### packages/context/time-context/package.json

该包的 npm 清单，声明入口、子路径导出与发布文件集。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`，决定默认加载的运行期模块（[packages/context/time-context/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*`、`./package.json` 四个子路径（[packages/context/time-context/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/package.json#L16-L27)）
- `files` 白名单限定发布产物为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/context/time-context/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/package.json#L28-L32)）

### packages/context/time-context/src/index.ts

插件主入口：注册 pre-step 监听，按调度向请求历史追加一条带来源标注的时钟读数。

- 导出插件名 `time-context`，同时作为消息来源的 plugin 标识与 section 名（[packages/context/time-context/src/index.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L21)）
- `inject = ['agents']` 要求 agents 注册表就绪后才装载（[packages/context/time-context/src/index.ts:24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L24)）
- `Config` schema 声明 `timeZone` 为字符串、`refreshIntervalMs` 为数字，装载时校验（[packages/context/time-context/src/index.ts:35-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L35-L38)）
- `formatDuration` 把毫秒下取整成整秒，并按天/时/分/秒拼成紧凑单位串，负值先夹到 0（[packages/context/time-context/src/index.ts:41-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L41-L55)）
- `precedingMessageTime` 倒序扫描会话事件，取最近一条 `user/message`、`assistant/message` 或 `tool/result` 的时间（[packages/context/time-context/src/index.ts:58-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L58-L71)）
- `precedingStepContextTime` 倒序扫描并在遇到本轮 `turn/start` 时返回 undefined，从而把基线限制在同一轮内的上一条本插件消息（[packages/context/time-context/src/index.ts:74-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L74-L84)）
- `latestInjectionTime` 跨轮倒序扫描原始持久事件，找到本插件最近一次注入的时间（[packages/context/time-context/src/index.ts:87-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L87-L96)）
- `requestMessages` 取本轮 `turn/start` 之后已入册的用户消息，并接上本次待提议的消息（[packages/context/time-context/src/index.ts:99-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L99-L108)）
- `renderText` 生成三行读数：时间戳行、浏览器时区策略行、已过时长行；无基线时写 `unavailable`，第 1 步用「model-visible message」基线、其余用「step context」（[packages/context/time-context/src/index.ts:110-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L110-L125)）
- `validateRefreshInterval` 对非非负安全整数的间隔抛 TypeError（[packages/context/time-context/src/index.ts:128-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L128-L137)）
- `apply` 装载时构造回退格式化器，构造失败按「配置时区非法」或「系统时区解析失败」抛错中止装载（[packages/context/time-context/src/index.ts:149-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L149-L157)）
- 回退时区由格式化器的 `resolvedOptions()` 一次性定下，并作为格式化器缓存的首个键（[packages/context/time-context/src/index.ts:158-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L158-L159)）
- `formatterFor` 按时区名缓存并复用 `Intl.DateTimeFormat` 实例（[packages/context/time-context/src/index.ts:162-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L162-L168)）
- 以 `prepend: true` 注册 `agent/pre-step`，先 `next()` 委托下游，决策为 `reject` 或信号已中止时原样返回、不注入（[packages/context/time-context/src/index.ts:170-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L170-L175)）
- 采样一次 `Date.now()` 作为本次读数时间（[packages/context/time-context/src/index.ts:176](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L176)）
- 正的 `refreshIntervalMs` 下，距上次注入不足该毫秒数时直接返回原决策，跳过本次注入（[packages/context/time-context/src/index.ts:177-182](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L177-L182)）
- 按 step 是否为 1 选择两种基线来源（[packages/context/time-context/src/index.ts:183-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L183-L185)）
- 从本轮全部用户消息推导浏览器时区，唯一解析成功时用请求本地时区，否则用回退时区格式化（[packages/context/time-context/src/index.ts:186-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L186-L188)）
- 把读数作为一条 user 角色消息追加到 `decision.messages` 末尾，来源为 `{ kind: 'plugin', plugin: name, form: 'snapshot', sections: [{ name, text }] }`（[packages/context/time-context/src/index.ts:198-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/index.ts#L198-L207)）

### packages/context/time-context/src/invariant.ts

该包的不变式伴生插件，对会话中已有与新追加的时钟读数逐条做格式与位置校验。

- `READING` 正则钉死读数的三行格式：turn/step 数字、ISO 形时间戳带偏移与方括号时区、浏览器时区行、基线词与时长或 `unavailable`（[packages/context/time-context/src/invariant.ts:14-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L14-L20)）
- 导出伴生插件名与 `inject = ['invariants']`（[packages/context/time-context/src/invariant.ts:23-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L23-L25)）
- `preparationPosition` 重放 `turn/start`、`step/start`、`request/header`、`step/end`、`turn/end` 推出当前开放的轮次与步号（[packages/context/time-context/src/invariant.ts:28-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L28-L63)）
- 读数不在开放轮内、不在 `step/start` 之后、或已在 `request/header` 之后时分别报失败（[packages/context/time-context/src/invariant.ts:64-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L64-L66)）
- `requestMessages` 从历史里取该轮 `turn/start` 之后的用户消息，用于重推浏览器时区（[packages/context/time-context/src/invariant.ts:71-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L71-L75)）
- 校验消息内容必须恰好是一个只含 `type`/`text` 两个键的文本块（[packages/context/time-context/src/invariant.ts:83-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L83-L94)）
- 文本不匹配读数正则即报失败（[packages/context/time-context/src/invariant.ts:95-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L95-L96)）
- 校验 turn 与 step 为不小于 1 的安全整数，且与重放推出的开放位置一致（[packages/context/time-context/src/invariant.ts:97-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L97-L105)）
- 校验来源仍是本包的 plugin 来源（[packages/context/time-context/src/invariant.ts:106-110](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L106-L110)）
- 校验来源对象恰有 4 个键、`form` 为 `snapshot`、只有一个 section 且其 `name` 与 `text` 与消息文本逐字一致，即来源不得夹带请求权限（[packages/context/time-context/src/invariant.ts:111-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L111-L125)）
- 用当前轮的用户消息重推浏览器时区文本，与读数中的那一行比对（[packages/context/time-context/src/invariant.ts:126-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L126-L131)）
- 校验 step 为 1 与基线词「model-visible message」互为充要（[packages/context/time-context/src/invariant.ts:132-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L132-L135)）
- 校验渲染时间戳可被解析，且不晚于其持久事件的时间（[packages/context/time-context/src/invariant.ts:136-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L136-L143)）
- 浏览器时区唯一时，用该时区重新格式化并要求与读数中的时间戳逐字相等，格式化抛错也报失败（[packages/context/time-context/src/invariant.ts:144-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L144-L158)）
- `validateSession` 遍历会话事件，对每条本包来源的用户消息用其之前的历史切片做校验（[packages/context/time-context/src/invariant.ts:163-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L163-L170)）
- 安装器先扫描已存在的所有会话，再挂 `session/created` 与 `internal/dispatch` 上的 `session/event` 两个全局监听，对新追加的读数即时校验（[packages/context/time-context/src/invariant.ts:173-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L173-L184)）
- `apply` 以包名向 `ctx.invariants` 注册该安装器并返回其 disposer（[packages/context/time-context/src/invariant.ts:192-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/invariant.ts#L192-L193)）

### packages/context/time-context/src/request-zone.ts

从开放轮的 user-rpc 消息推导浏览器时区并渲染模型可见策略行的模块，被 `index.ts` 与 `invariant.ts` 共用。

- `IANA_TIME_ZONE` 正则限定可接受的 Area/Location 形时区写法（[packages/context/time-context/src/request-zone.ts:6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/request-zone.ts#L6)）
- `browserTimeZone` 只从同时带 `rpcId` 与字符串 `clientTimeZone` 的 user 来源里取时区，其余返回 undefined（[packages/context/time-context/src/request-zone.ts:15-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/request-zone.ts#L15-L24)）
- 值既不是 `UTC` 又不匹配 IANA 正则时抛 TypeError（[packages/context/time-context/src/request-zone.ts:25-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/request-zone.ts#L25-L29)）
- 用 `Intl.DateTimeFormat` 解析该时区，解析抛错则报「不受支持」，规范化结果与原值不等则报「非规范」（[packages/context/time-context/src/request-zone.ts:30-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/request-zone.ts#L30-L38)）
- `deriveBrowserTimeZoneContext` 对全轮时区去重并排序，零个记 `missing`、一个记 `resolved`、多个记 `mixed`（[packages/context/time-context/src/request-zone.ts:48-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/request-zone.ts#L48-L59)）
- `renderBrowserTimeZoneContext` 为三种情况分别输出固定策略文本：唯一时区要求按该时区解读未限定时间，mixed 与 unavailable 都要求向用户澄清（[packages/context/time-context/src/request-zone.ts:66-81](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/request-zone.ts#L66-L81)）

### packages/context/time-context/src/timestamp.ts

生产与重放校验共用的时间戳格式化模块。

- `createTimestampFormatter` 固定 en-US 语言、四位年与两位月日时分秒、`h23` 小时制与 `longOffset` 时区名，时区缺省时交给进程默认（[packages/context/time-context/src/timestamp.ts:10-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/timestamp.ts#L10-L22)）
- `formatTimestamp` 把格式化片段重排成 ISO 形文本，把裸 `GMT` 补成 `GMT+00:00` 后切掉前三字符取偏移，并在末尾用方括号附上时区名（[packages/context/time-context/src/timestamp.ts:31-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/src/timestamp.ts#L31-L37)）

### packages/context/time-context/tsconfig.json

该包的 TypeScript 编译配置，声明 rootDir/outDir 与工作区项目引用。

- 无运行期机制

### packages/context/time-context/tsdown.config.ts

该包的打包配置，把编译产物打成发布用的两个运行期入口。

- 分别以 `lib/types/index.js` 与 `lib/types/invariant.js` 为入口打出 `lib/index.js` 与 `lib/invariant.js`，即 package.json 两个导出各自对应的运行期文件（[packages/context/time-context/tsdown.config.ts:4-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/tsdown.config.ts#L4-L25)）
- 两个入口都以 esm 格式、node 平台、es2024 目标输出，且不清理输出目录、不生成声明（[packages/context/time-context/tsdown.config.ts:7-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/time-context/tsdown.config.ts#L7-L13)）
