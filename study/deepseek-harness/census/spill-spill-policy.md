---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/spill/spill-policy
---

# packages/spill/spill-policy

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、32 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/spill/spill-policy/README.md

这个包的英文说明页，描述溢出策略的配置项、模型看到的替换文本、适用范围与尽力而为的失败行为。

- 无运行期机制

### packages/spill/spill-policy/package.json

包清单，声明该策略插件如何被解析加载、发布哪些文件，以及运行期依赖。

- `type: module` 与 `main`/`types` 让该包按 ESM 加载，主入口解析到 `lib/index.js`（[packages/spill/spill-policy/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/package.json#L13-L15)）
- `exports` 只开放根入口、`./invariant` 子路径、`./src/*` 源码直通与 `./package.json`（[packages/spill/spill-policy/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/spill/spill-policy/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/package.json#L28-L32)）
- `dependencies` 只列 schemastery，作为运行期校验配置的依赖被一同安装（[packages/spill/spill-policy/package.json:43-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/package.json#L43-L45)）

### packages/spill/spill-policy/src/index.ts

插件入口，注册两个瀑布监听器：一个改写模型可见的工具结果，一个改写 `run_code` 子调用在会话日志中的副本。

- 导出插件名 `spill-policy` 供加载器诊断使用（[packages/spill/spill-policy/src/index.ts:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L70)）
- `inject = ['tools']` 让插件在工具注册表就绪后才激活（[packages/spill/spill-policy/src/index.ts:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L73)）
- `Config` 声明唯一字段 `maxInlineBytes` 为数字（[packages/spill/spill-policy/src/index.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L75-L77)）
- `flattenPlainText` 遇到任何非 text 块就返回 undefined，否则把所有文本块拼成一个字符串（[packages/spill/spill-policy/src/index.ts:80-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L80-L87)）
- `ownerSessionId` 从执行对象上按结构读 `agent?.session.header.id`，无 agent 时得到 undefined（[packages/spill/spill-policy/src/index.ts:89-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L89-L92)）
- `preview` 把预算按 ceil/floor 均分为头尾两段，用 `TextRetainer` 的 headTail 模式生成保留文本与省略量（[packages/spill/spill-policy/src/index.ts:94-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L94-L102)）
- `spillNotice` 拼出 `(<省略描述> Full formatted result stored at: <定位符>. <检索提示>)` 这一行通知（[packages/spill/spill-policy/src/index.ts:104-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L104-L108)）
- `maxInlineBytes` 未配置时 `apply` 直接返回，两个监听器一个都不注册（[packages/spill/spill-policy/src/index.ts:110-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L110-L113)）
- 非整数或负数的 `maxInlineBytes` 在加载时抛错，使配置错误停在部署而不是每次调用（[packages/spill/spill-policy/src/index.ts:114-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L114-L119)）
- `spillReplacement` 在拿不到会话 id 时发警告并返回 undefined，保留原文（[packages/spill/spill-policy/src/index.ts:138-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L138-L141)）
- 用 `ctx.get('spillStore')` 取后端，未挂载时发警告并返回 undefined（[packages/spill/spill-policy/src/index.ts:142-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L142-L146)）
- 组装保存请求：owner 为会话 id，source 记工具名、调用 id 与标签，建议名为 `<工具名>.txt`，内容为全文（[packages/spill/spill-policy/src/index.ts:147-152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L147-L152)）
- `saveText` 抛错时发警告并返回 undefined，使存储失败不改变工具调用结果（[packages/spill/spill-policy/src/index.ts:153-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L153-L161)）
- 先按最坏情况（省略量等于总字节数）计价通知并加 2 字节连接符，从预算里预留出来（[packages/spill/spill-policy/src/index.ts:163-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L163-L171)）
- 预览预算取 `max(0, cap - reserve)`，预览非空时拼成「预览 + 空行 + 通知」，为空时只留通知（[packages/spill/spill-policy/src/index.ts:172-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L172-L175)）
- 替换文本的 UTF-8 字节数仍超过上限时发警告并返回 undefined，保留原始内联内容（[packages/spill/spill-policy/src/index.ts:176-187](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L176-L187)）
- 以 `prepend` 注册 `tools/post-execute` 监听，先 `await next()` 让下游先定夺，再对其接受的结果做处理（[packages/spill/spill-policy/src/index.ts:190-194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L190-L194)）
- 非 accept 决定、带 `value` 的替换、嵌套子调用（`exec.parent` 存在）以及工具名为 `read` 的调用一律原样返回（[packages/spill/spill-policy/src/index.ts:195-197](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L195-L197)）
- 取 `decision.content ?? result.content` 作为待判定内容，含非文本块或字节数不超过上限时原样返回（[packages/spill/spill-policy/src/index.ts:199-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L199-L203)）
- 替换成功时返回只含一个 text 块的 accept 决定，并在原决定带有 `additionalContexts` 时原样带上（[packages/spill/spill-policy/src/index.ts:205-208](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L205-L208)）
- 以 `prepend` 注册 `tools/ptc-dispatch-log` 监听，`await next()` 取到日志副本内容后同样按上限判定（[packages/spill/spill-policy/src/index.ts:217-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L217-L225)）
- 日志这一路不跳过 `read`，超限时用子调用的工具名、子调用 id 与 `dispatch` 标签生成替换并返回单个 text 块（[packages/spill/spill-policy/src/index.ts:226-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/index.ts#L226-L231)）

### packages/spill/spill-policy/src/invariant.ts

该包的不变量伴生插件，向不变量服务登记包名。

- 导出 `name` 与 `inject = ['invariants']`，使其成为需要 `invariants` 服务的 cordis 插件（[packages/spill/spill-policy/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/invariant.ts#L13-L15)）
- `install` 是空安装器，不注册任何检查（[packages/spill/spill-policy/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/invariant.ts#L21)）
- `apply` 调用 `ctx.invariants.register(PACKAGE_NAME, install)` 并返回其注销函数（[packages/spill/spill-policy/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/spill/spill-policy/src/invariant.ts#L28-L29)）

### packages/spill/spill-policy/src/types.ts

只含一个接口的类型文件，声明策略读取归属会话 id 时所需的工具执行对象结构。

- 无运行期机制

### packages/spill/spill-policy/tsconfig.json

该包的 TypeScript 编译配置，设定源码根、输出目录与工程引用。

- 无运行期机制
