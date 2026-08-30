---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/llm/deepseek-llm-api-extensions
---

# packages/llm/deepseek-llm-api-extensions

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、23 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/llm/deepseek-llm-api-extensions/README.md

该请求扩展登记表包的说明文档，介绍 `register`／`prepare`／`accept` 三个方法及其生命周期约定。

- 无运行期机制

### packages/llm/deepseek-llm-api-extensions/package.json

该包的 npm 清单，声明 ESM 类型、入口与发布文件集。

- 声明 `"type": "module"` 并把默认入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/llm/deepseek-llm-api-extensions/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/package.json#L13-L15)）
- `exports` 放行 `.`、`./invariant`、`./types`、`./src/*` 与 `./package.json`，其中 `./types` 另指向 `lib/types/types.js`（[packages/llm/deepseek-llm-api-extensions/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/package.json#L16-L31)）
- `files` 限定发布内容为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.js`／`.d.ts`（[packages/llm/deepseek-llm-api-extensions/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/package.json#L32-L37)）
- 把 invariants 与 cordis 列为 peerDependencies，由宿主组合提供（[packages/llm/deepseek-llm-api-extensions/package.json:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/package.json#L39-L42)）

### packages/llm/deepseek-llm-api-extensions/src/index.ts

请求扩展登记表的服务实现，默认导出 `DeepSeekLlmApiExtensionRegistry`，由官方适配器在序列化基础请求体后调用以合入各插件贡献的顶层字段。

- 通过声明合并把 `deepseekLlmApiExtensions` 挂到 Context 上，服务构造时以该名注册（[packages/llm/deepseek-llm-api-extensions/src/index.ts:18-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L18-L22)）
- `freezeJson()` 递归冻结 JSON 值，提供方拿不到可变别名（[packages/llm/deepseek-llm-api-extensions/src/index.ts:32-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L32-L38)）
- `acceptAll()` 用 `allSettled` 让每个接受回调都跑完再报错：一个失败原样抛出，多个失败合成一个 `AggregateError`（[packages/llm/deepseek-llm-api-extensions/src/index.ts:41-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L41-L48)）
- `abortable()` 先查已中止、再把提供方工作与中止承诺竞速，中止即以 `signal.reason` 拒绝，退出时摘除监听器（[packages/llm/deepseek-llm-api-extensions/src/index.ts:51-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L51-L63)）
- 构造函数以服务名 `deepseekLlmApiExtensions` 注册到上下文（[packages/llm/deepseek-llm-api-extensions/src/index.ts:69-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L69-L71)）
- `register()` 拒绝空字符串或首尾带空白的字段名（[packages/llm/deepseek-llm-api-extensions/src/index.ts:84-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L84-L86)）
- 注册走 `ctx.effect`：同名字段已被占用时抛错，成功则写入映射并返回删除该字段的 disposer，释放后可被后续提供方重新占用（[packages/llm/deepseek-llm-api-extensions/src/index.ts:89-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L89-L99)）
- `prepare()` 入口先检查请求是否已中止（[packages/llm/deepseek-llm-api-extensions/src/index.ts:109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L109)）
- 先对当前注册项取快照，再并发调用各提供方的 `prepare`，整体包在 `abortable` 里，请求取消时不再等待忽略 signal 的提供方（[packages/llm/deepseek-llm-api-extensions/src/index.ts:110-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L110-L114)）
- 字段容器用 `Object.create(null)` 建，跳过返回 `undefined` 的提供方，其余值经 `structuredClone` 后递归冻结再写入（[packages/llm/deepseek-llm-api-extensions/src/index.ts:115-120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L115-L120)）
- 收集各提供方的 `accept` 回调并绑定到其结果对象上，即使注册随后被卸载也仍保留（[packages/llm/deepseek-llm-api-extensions/src/index.ts:120-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L120-L122)）
- 冻结字段容器后返回，并让 `accept()` 以记忆化承诺实现——重复调用汇入同一次结算（[packages/llm/deepseek-llm-api-extensions/src/index.ts:123-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L123-L128)）
- 默认导出 `DeepSeekLlmApiExtensionRegistry`，使其可作为服务插件被 Loader 装载（[packages/llm/deepseek-llm-api-extensions/src/index.ts:132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/index.ts#L132)）

### packages/llm/deepseek-llm-api-extensions/src/invariant.ts

该包的不变量伴生插件入口，被不变量服务加载以登记包归属。

- 声明 `inject = ['invariants']`，插件只在不变量服务就绪后应用（[packages/llm/deepseek-llm-api-extensions/src/invariant.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/invariant.ts#L12)）
- 安装器为空函数，本包不注册任何运行期检查（[packages/llm/deepseek-llm-api-extensions/src/invariant.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/invariant.ts#L18)）
- `apply` 把包名与空安装器注册进 `ctx.invariants` 并返回其 disposer（[packages/llm/deepseek-llm-api-extensions/src/invariant.ts:25-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/deepseek-llm-api-extensions/src/invariant.ts#L25-L26)）

### packages/llm/deepseek-llm-api-extensions/src/types.ts

只放类型声明的模块，定义 JSON 值类型、可合并扩展字段表、提供方与准备结果的接口。

- 无运行期机制

### packages/llm/deepseek-llm-api-extensions/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、类型产物目录与工作区项目引用。

- 无运行期机制
