---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/runtime-diagnostics/invariants
---

# packages/runtime-diagnostics/invariants

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、25 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/runtime-diagnostics/invariants/README.md

包参考文档，说明不变量注册表的挂载方式、过滤字段、伴生插件契约与失败报错形式。

- 无运行期机制

### packages/runtime-diagnostics/invariants/package.json

包清单，声明注册表服务的入口、导出与发布内容。

- `exports` 把 `.` 解析到 `lib/index.js`、`./invariant` 解析到 `lib/invariant.js`，并暴露 `./src/*` 与 `./package.json`（[packages/runtime-diagnostics/invariants/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/package.json#L16-L27)）
- `files` 把发布内容限制为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的声明文件（[packages/runtime-diagnostics/invariants/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/package.json#L28-L32)）

### packages/runtime-diagnostics/invariants/src/index.ts

插件入口，提供 `ctx.invariants` 注册表服务：编译包名过滤器、在子 fiber 中运行各包的检查安装器、并定义违约错误类型。

- `InvariantError` 以固定 `code = 'INVARIANT'` 与 `packageName` 字段构造，消息前缀为 `invariant violated by "<包名>": `（[packages/runtime-diagnostics/invariants/src/index.ts:50-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L50-L66)）
- `compilePatterns` 拒绝空串与首尾带空白的条目（[packages/runtime-diagnostics/invariants/src/index.ts:78-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L78-L80)）
- `compilePatterns` 拒绝同一列表内的重复正则源（[packages/runtime-diagnostics/invariants/src/index.ts:81-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L81-L84)）
- `compilePatterns` 用 `new RegExp` 编译，编译失败即带 cause 抛错（[packages/runtime-diagnostics/invariants/src/index.ts:85-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L85-L90)）
- 运行期 schema 给 `enabled` 默认 `true`、两个名单默认空数组（[packages/runtime-diagnostics/invariants/src/index.ts:95-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L95-L99)）
- 构造函数以 `'invariants'` 名注册服务、记下拥有者上下文，并在启动时一次性编译两份名单（[packages/runtime-diagnostics/invariants/src/index.ts:112-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L112-L118)）
- `selected` 的判定顺序为：全局开关关闭直接否；允许名单非空且无一命中则否；命中阻止名单则否（[packages/runtime-diagnostics/invariants/src/index.ts:121-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L121-L126)）
- `register` 拒绝空白或含空白字符的包名（[packages/runtime-diagnostics/invariants/src/index.ts:137-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L137-L139)）
- `register` 拒绝重复注册同一包名（[packages/runtime-diagnostics/invariants/src/index.ts:140-142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L140-L142)）
- 注册把包名先放入 `registrations` 集合占位，并显式以服务自身的上下文而非调用方上下文创建 effect（[packages/runtime-diagnostics/invariants/src/index.ts:147-153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L147-L153)）
- 未被过滤器选中的包只保留名字占位，其 disposer 仅从集合中删除该名字，安装器不运行（[packages/runtime-diagnostics/invariants/src/index.ts:154-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L154-L158)）
- 选中的安装器被包成插件在子 fiber 中运行，并拿到一个抛 `InvariantError` 的 `fail` 报告函数；`installer.inject` 存在时作为该插件的注入声明（[packages/runtime-diagnostics/invariants/src/index.ts:160-168](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L160-L168)）
- 注册在子 fiber 启动完成前不返回；启动抛错时先销毁子 fiber 再向外抛（[packages/runtime-diagnostics/invariants/src/index.ts:170-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L170-L175)）
- 成功注册返回的 disposer 先销毁子 fiber，再在 finally 中释放包名占位（[packages/runtime-diagnostics/invariants/src/index.ts:177-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L177-L183)）
- 安装或 effect 创建过程中的任何抛错都会删除包名占位后再向外抛（[packages/runtime-diagnostics/invariants/src/index.ts:184-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L184-L192)）
- effect 标签写成 `invariants.register("<包名>")`，随注册进入运行期诊断（[packages/runtime-diagnostics/invariants/src/index.ts:188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L188)）
- `register` 把这个既可 await 又可调用的注册对象作为普通 disposer 返回（[packages/runtime-diagnostics/invariants/src/index.ts:193-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L193-L196)）
- 服务类作为默认导出，使其可直接作为 Cordis 服务插件挂载（[packages/runtime-diagnostics/invariants/src/index.ts:200](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/index.ts#L200)）

### packages/runtime-diagnostics/invariants/src/invariant.ts

该包自身的不变量伴生插件，向注册表登记自己的包名。

- `inject = ['invariants']` 使伴生插件在注册表可用之后才执行（[packages/runtime-diagnostics/invariants/src/invariant.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/invariant.ts#L15)）
- 安装器为空函数，登记后不注册任何监听或检查（[packages/runtime-diagnostics/invariants/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 占用该包名并返回注销函数（[packages/runtime-diagnostics/invariants/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/runtime-diagnostics/invariants/src/invariant.ts#L28-L29)）

### packages/runtime-diagnostics/invariants/tsconfig.json

该包的 TypeScript 编译配置与工程引用。

- 无运行期机制
