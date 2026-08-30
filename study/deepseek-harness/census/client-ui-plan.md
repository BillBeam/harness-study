---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-plan
---

# packages/client/ui-plan

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 11 个文件、27 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-plan/README.md

本包的说明文档，介绍输入区里的计划模式状态标签、它读的投影与它发出的命令行，供阅读者使用。

- 无运行期机制

### packages/client/ui-plan/package.json

本包的 npm 清单，声明入口、客户端半边的加载声明与发布产物。

- `main`/`types`/`exports` 把 `.`、`./invariant`、`./client` 分别指向 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，并放开 `./src/*` 与 `./package.json` 的直取（[packages/client/ui-plan/package.json:14-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/package.json#L14-L31)）
- `dsh.client` 声明浏览器半边需要注入的三个包并把 `platform` 限定为 `web`，决定这个半边在哪种客户端被发现与加载（[packages/client/ui-plan/package.json:32-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/package.json#L32-L41)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与 `lib/types/**/*.d.ts`（[packages/client/ui-plan/package.json:74-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/package.json#L74-L79)）

### packages/client/ui-plan/src/client/PlanModeControl.module.css

状态标签的 CSS Module 样式表，被 `PlanModeControl.tsx` 引入。

- 无运行期机制

### packages/client/ui-plan/src/client/PlanModeControl.tsx

输入区计划座位的组件：按 `plan` 投影决定是否渲染状态标签，点击执行退出。

- 通过 `useProjection('plan')` 订阅该会话的计划投影（[packages/client/ui-plan/src/client/PlanModeControl.tsx:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/PlanModeControl.tsx#L20)）
- 用 `aliveRef` 在挂载时置真、卸载时置假，异步回调据此跳过卸载后的状态写入（[packages/client/ui-plan/src/client/PlanModeControl.tsx:25-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/PlanModeControl.tsx#L25-L30)）
- 投影为 `undefined` 时返回 null，座位保持为空（[packages/client/ui-plan/src/client/PlanModeControl.tsx:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/PlanModeControl.tsx#L32)）
- 生效目标按 `pending ? !active : active` 折算，为假时返回 null（[packages/client/ui-plan/src/client/PlanModeControl.tsx:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/PlanModeControl.tsx#L33-L34)）
- 点击时置 `leaving`、清错并调用注入的 `exitPlanMode()`；兑现值非空即当作失败行落到错误位，拒绝时把 `Error` 的 message 或值的字符串形式落进错误位，两条路径都先复位 `leaving`（[packages/client/ui-plan/src/client/PlanModeControl.tsx:36-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/PlanModeControl.tsx#L36-L49)）
- 按钮在座位被 `locked` 或正在退出时禁用（[packages/client/ui-plan/src/client/PlanModeControl.tsx:58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/PlanModeControl.tsx#L58)）
- 无障碍名、悬浮提示与标签文本全部取自绑定的文案表（[packages/client/ui-plan/src/client/PlanModeControl.tsx:56-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/PlanModeControl.tsx#L56-L61)）
- 错误位非空时追加一个 `role="status"` 的行，`title` 为原始错误文本（[packages/client/ui-plan/src/client/PlanModeControl.tsx:66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/PlanModeControl.tsx#L66)）

### packages/client/ui-plan/src/client/index.ts

浏览器半边的插件体：注册 `plan` 文案命名空间，并把状态标签装进输入区的计划座位。

- 固定命名空间常量 `plan`，字典注册与座位绑定都用它（[packages/client/ui-plan/src/client/index.ts:34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/index.ts#L34)）
- `inject` 声明这个 fiber 依赖槽位注册表、命令 Remote 与文案注册表，缺一则插件不生效（[packages/client/ui-plan/src/client/index.ts:46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/index.ts#L46)）
- 以 effect 注册中英字典并返回注销函数（[packages/client/ui-plan/src/client/index.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/index.ts#L53)）
- 向 `conversation.input.plan` 座位注册该组件并绑定 `plan` 文案命名空间（[packages/client/ui-plan/src/client/index.ts:55-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/index.ts#L55-L67)）
- 注入面的 `exitPlanMode` 按会话 id 通过 `remote.commands.execute` 发出 `/plan off`（[packages/client/ui-plan/src/client/index.ts:60-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/index.ts#L60-L61)）
- 结果 `!ok` 时返回 `消息 (错误码)` 形式的失败行，返回值为 `undefined` 时返回固定的未知命令行，其余返回 null 表示已被受理（[packages/client/ui-plan/src/client/index.ts:62-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/client/index.ts#L62-L64)）

### packages/client/ui-plan/src/client/locales.ts

`plan` 命名空间的中英文案表，由客户端插件体注册。

- 无运行期机制

### packages/client/ui-plan/src/css-modules.d.ts

给 `*.module.css` 导入声明类型的环境声明文件。

- 无运行期机制

### packages/client/ui-plan/src/index.ts

本包的宿主半边入口。

- 导出空的 `apply`，使该插件能出现在宿主的插件表里被挂载，浏览器半边则由清单的客户端声明另行发现（[packages/client/ui-plan/src/index.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/index.ts#L11)）

### packages/client/ui-plan/src/invariant.ts

本包的不变量伴随插件，向不变量服务登记包归属。

- 导出插件名与 `inject: ['invariants']`，登记前先等到不变量服务（[packages/client/ui-plan/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/invariant.ts#L13-L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/client/ui-plan/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/invariant.ts#L22)）
- `apply` 以包名调用 `ctx.invariants.register` 并把注销函数作为 Promise 结果返回（[packages/client/ui-plan/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/src/invariant.ts#L29-L30)）

### packages/client/ui-plan/tsconfig.json

本包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制

### packages/client/ui-plan/tsdown.config.ts

本包的打包配置，调用共享的客户端打包预设。

- 以包名与 `['lib/types/index.js', 'lib/types/invariant.js']` 两个 node 半边入口调用共享预设，据此产出宿主半边与浏览器半边两类产物（[packages/client/ui-plan/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-plan/tsdown.config.ts#L3)）
