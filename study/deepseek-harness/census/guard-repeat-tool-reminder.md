---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/guard/repeat-tool-reminder
---

# packages/guard/repeat-tool-reminder

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、26 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/guard/repeat-tool-reminder/README.md

包 README，说明重复调用提醒的阈值配置、检测口径与提醒投递方式。

- 无运行期机制

### packages/guard/repeat-tool-reminder/package.json

npm 清单，声明该守卫包的入口与发布内容。

- `type: module` 与 `main`/`types` 指向 `lib/index.js`，决定运行期加载的模块（[packages/guard/repeat-tool-reminder/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/package.json#L13-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*` 与 `./package.json` 四个入口（[packages/guard/repeat-tool-reminder/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/package.json#L16-L27)）
- `files` 白名单限定发布制品的文件集合（[packages/guard/repeat-tool-reminder/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/package.json#L28-L32)）

### packages/guard/repeat-tool-reminder/src/index.ts

插件入口：在工具执行后的瀑布上按代理维护连续重复链，命中阈值时把提醒文本作为附加上下文挂到下游决定上。

- 导出插件名，作为函数插件被 Loader 挂载（[packages/guard/repeat-tool-reminder/src/index.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L17)）
- `Config` 模式声明 `thresholds` 默认 `[3,5,8]`、`include`/`exclude` 默认空、`argumentsPreviewChars` 默认 500（[packages/guard/repeat-tool-reminder/src/index.ts:45-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L45-L50)）
- `PLUGIN_SOURCE` 把注入的提醒标为 `{kind:'plugin', plugin:'repeat-tool-reminder'}`，使其在派生历史里不呈现为用户提示（[packages/guard/repeat-tool-reminder/src/index.ts:57](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L57)）
- `GENTLE_REMINDER` 是首个阈值处模型看到的固定提醒文本（[packages/guard/repeat-tool-reminder/src/index.ts:63-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L63-L67)）
- `detailedReminder` 生成后续阈值的详细文本，列出工具名、连续次数与规范化参数，并要求换一种做法（[packages/guard/repeat-tool-reminder/src/index.ts:70-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L70-L79)）
- `sortJsonValue` 递归按键排序，使仅属性顺序不同的参数规范化为同一形态（[packages/guard/repeat-tool-reminder/src/index.ts:89-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L89-L100)）
- `canonicalize` 把排序后的参数 `JSON.stringify` 成链的比较字符串（[packages/guard/repeat-tool-reminder/src/index.ts:103-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L103-L105)）
- `wildcardToRegExp` 转义其余正则元字符，只把 `*` 编成 `.*` 并整体锚定（[packages/guard/repeat-tool-reminder/src/index.ts:108-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L108-L111)）
- `previewArguments` 对超过上限的规范化参数做头部截断，并追加 `… (+N more chars)` 标注省略量，只约束模型可见文本（[packages/guard/repeat-tool-reminder/src/index.ts:118-121](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L118-L121)）
- `validateThresholds` 对空列表、非整数、小于 2、重复值分别抛出加载期错误，并把阈值升序归一（[packages/guard/repeat-tool-reminder/src/index.ts:128-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L128-L141)）
- `prependContext` 把本插件提醒放在下游附加上下文数组之首，其余条目各自的来源与元数据原样保留（[packages/guard/repeat-tool-reminder/src/index.ts:147-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L147-L149)）
- apply 在加载时校验阈值、编译 include/exclude 模式，并对非正整数的 `argumentsPreviewChars` 抛错（[packages/guard/repeat-tool-reminder/src/index.ts:162-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L162-L171)）
- 重复链存放在 `WeakMap<Agent, Chain>` 里，按代理隔离且随代理对象回收（[packages/guard/repeat-tool-reminder/src/index.ts:173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L173)）
- `tracked` 在 include 非空时要求命中其一，且不得命中任一 exclude；未跟踪的调用既不计数也不重置（[packages/guard/repeat-tool-reminder/src/index.ts:176-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L176-L179)）
- `observe` 对无代理的直接调用与未跟踪工具直接返回，不参与链（[packages/guard/repeat-tool-reminder/src/index.ts:189-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L189-L193)）
- 链键取 `[工具名, 规范化参数]` 的 JSON 串，与上次相同则计数加一，否则重置为 1 并写回（[packages/guard/repeat-tool-reminder/src/index.ts:194-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L194-L198)）
- 只有当前计数正好等于某个配置阈值时才产生提醒，等于首个阈值用温和文本、其余用详细文本，消息来源附 `form:'notice'` 与 `<工具名> × <次数>` 摘要（[packages/guard/repeat-tool-reminder/src/index.ts:199-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L199-L206)）
- `tools/post-execute` 监听器先计数再 `await next()` 委托下游，然后把提醒前插到返回决定的 `additionalContexts`，block 与非 block 两种决定都会带上（[packages/guard/repeat-tool-reminder/src/index.ts:213-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L213-L224)）
- `agent/pre-step` 监听器在本步骤含 `source.kind === 'user'` 的消息时删除该代理的链，然后无条件委托下游（[packages/guard/repeat-tool-reminder/src/index.ts:229-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/index.ts#L229-L232)）

### packages/guard/repeat-tool-reminder/src/invariant.ts

包自有的不变量伴生插件，安装器为空并写明原因。

- 安装器为空函数，不注册任何运行期检查（[packages/guard/repeat-tool-reminder/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/invariant.ts#L17-L21)）
- `apply` 仍以包名向 `invariants` 注册该空安装器，占住包的不变量所有权并返回 disposer（[packages/guard/repeat-tool-reminder/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/guard/repeat-tool-reminder/src/invariant.ts#L28-L29)）

### packages/guard/repeat-tool-reminder/tsconfig.json

包级 TypeScript 编译配置，声明 rootDir/outDir 与工作区引用。

- 无运行期机制
