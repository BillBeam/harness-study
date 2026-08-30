---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/code-runtime/code-runtime
---

# packages/code-runtime/code-runtime

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、17 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/code-runtime/code-runtime/README.md

代码执行能力接缝包的说明文档，描述服务契约、后端描述符、绑定命名规则与失败分类。

- 无运行期机制

### packages/code-runtime/code-runtime/package.json

该包的 npm 清单，声明入口、导出映射与发布文件白名单。

- `main` 与 `types` 指向构建产物 `lib/index.js` 与类型声明（[packages/code-runtime/code-runtime/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/package.json#L14-L15)）
- `exports` 暴露包根、`./invariant` 伴生入口、`./src/*` 源码直取与 `./package.json` 四条解析路径（[packages/code-runtime/code-runtime/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/package.json#L16-L27)）
- `files` 白名单限定发布内容为两个 js 产物与类型声明（[packages/code-runtime/code-runtime/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/package.json#L28-L32)）

### packages/code-runtime/code-runtime/src/index.ts

代码执行接缝的服务定义入口：抽象的 `CodeRuntime` 服务类，以及所有后端共同强制的可移植标识符排除集合。

- `RESERVED_BINDING_GLOBALS` 固定拒绝五个绑定全局名（`console` 与四个 Python 侧占位名），所有后端共用同一集合（[packages/code-runtime/code-runtime/src/index.ts:40-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/index.ts#L40-L43)）
- `RESERVED_ERROR_MEMBERS` 固定拒绝六个错误成员名（JS Error 三项与 Python 异常协议三项）（[packages/code-runtime/code-runtime/src/index.ts:55-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/index.ts#L55-L58)）
- `DUNDER_MEMBER` 正则整体拒绝双下划线包裹形式的错误成员名（[packages/code-runtime/code-runtime/src/index.ts:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/index.ts#L64)）
- `PORTABLE_RESERVED_WORDS` 是 ECMAScript 与 Python 保留字的并集，用于拒绝绑定全局名与错误类名（[packages/code-runtime/code-runtime/src/index.ts:76-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/index.ts#L76-L87)）
- 抽象类 `CodeRuntime` 的构造函数以 `'codeRuntime'` 之名调用父类 Service 构造，把实现注册为 `ctx.codeRuntime`（[packages/code-runtime/code-runtime/src/index.ts:121-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/index.ts#L121-L123)）
- 抽象只读成员 `language` 与 `isolation` 要求每个后端声明源语言与执行基座标识（[packages/code-runtime/code-runtime/src/index.ts:111-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/index.ts#L111-L119)）
- 抽象方法 `run` 规定一次请求执行一个程序并以 resolve 的结果字段报告失败，仅接缝误用才 reject（[packages/code-runtime/code-runtime/src/index.ts:125-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/index.ts#L125-L134)）
- 默认导出 `CodeRuntime` 类，使该包作为服务插件被 Loader 载入（[packages/code-runtime/code-runtime/src/index.ts:137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/index.ts#L137)）

### packages/code-runtime/code-runtime/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属。

- 导出插件名与 `inject = ['invariants']`，声明该伴生插件在 invariants 服务就绪后才激活（[packages/code-runtime/code-runtime/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/invariant.ts#L13-L15)）
- 安装器为空函数，不注册任何运行期检查（[packages/code-runtime/code-runtime/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/invariant.ts#L21)）
- `apply` 以包名调用 `ctx.invariants.register` 并返回其 disposer（[packages/code-runtime/code-runtime/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/code-runtime/code-runtime/src/invariant.ts#L28-L29)）

### packages/code-runtime/code-runtime/src/types.ts

代码执行接缝的词汇类型文件：请求、绑定命名空间、无损 JSON 值、运行结果与失败分类，文件头声明其中不含运行期代码。

- 无运行期机制

### packages/code-runtime/code-runtime/tsconfig.json

该包的 TypeScript 编译配置，声明源码根、类型输出目录与工程引用。

- 无运行期机制
