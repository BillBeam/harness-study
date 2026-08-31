---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/shell/shell
---

# packages/shell/shell

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、14 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/shell/shell/README.md

这个包的说明文档，介绍执行器契约、请求／规格拆分与组合方式。

- 无运行期机制

### packages/shell/shell/package.json

这个包的清单，声明入口映射与发布内容，被 Node 解析和打包时读取。

- `exports` 把包名映射到 `lib/index.js`，另外开放 `./invariant`、`./src/*` 和 `./package.json` 三个子路径（[packages/shell/shell/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/package.json#L16-L27)）
- `files` 限定发布物只包含 `lib/index.js`、`lib/invariant.js` 和 `lib/types` 下的声明文件（[packages/shell/shell/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/package.json#L28-L32)）

### packages/shell/shell/src/index.ts

包入口，定义 `ctx.shell` 抽象执行器服务与该能力共享的设置命名空间，被所有 shell 执行器实现继承。

- 导出以 `shell` 命名的设置命名空间常量，供各执行器实现共用一份用户配置分区（[packages/shell/shell/src/index.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/src/index.ts#L22)）
- 抽象类构造时以 `shell` 名注册服务，同一上下文里装第二个实现会抛出重复注册错误（[packages/shell/shell/src/index.ts:66-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/src/index.ts#L66-L68)）
- `sandboxMode` 基类实现返回 `undefined`，表示该实现不对命令做沙箱约束，工具层据此不公开升级字段（[packages/shell/shell/src/index.ts:75-77](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/src/index.ts#L75-L77)）
- 三个抽象方法把「先 `resolve` 出完整规格，再交给 `run` 或 `start`」定为所有实现必须走的调用次序（[packages/shell/shell/src/index.ts:85-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/src/index.ts#L85-L100)）

### packages/shell/shell/src/invariant.ts

这个包的不变量伴随插件，由不变量服务在装载时调用。

- `inject` 要求 `invariants` 服务先就位，插件才会应用（[packages/shell/shell/src/invariant.ts:11](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/src/invariant.ts#L11)）
- `apply` 以包名向 `ctx.invariants` 注册一个空安装器，并返回其卸载器（[packages/shell/shell/src/invariant.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/src/invariant.ts#L21-L22)）

### packages/shell/shell/src/render.ts

退出状态标记的解析模块，被 Host 结果呈现和 Web 终端卡片用来从已渲染文本里还原退出状态。

- 先匹配以换行开头、位于字符串末尾的 `[killed by signal: X]`，命中则切掉标记并返回信号（[packages/shell/shell/src/render.ts:38-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/src/render.ts#L38-L39)）
- 其次匹配同样位置的 `[exit code: N]`，命中则切掉标记并把数字转成退出码（[packages/shell/shell/src/render.ts:40-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/src/render.ts#L40-L41)）
- 两个标记都不存在时原文照返并记作退出码 0（[packages/shell/shell/src/render.ts:42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/shell/shell/src/render.ts#L42)）

### packages/shell/shell/src/types.ts

执行器接缝的类型声明文件，定义请求、规格、运行结果与后台进程句柄的字段，并转出子进程接缝的词汇。

- 无运行期机制

### packages/shell/shell/tsconfig.json

这个包的 TypeScript 编译配置，声明源码根、输出目录与工程引用。

- 无运行期机制
