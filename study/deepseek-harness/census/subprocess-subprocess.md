---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/subprocess/subprocess
---

# packages/subprocess/subprocess

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、12 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/subprocess/subprocess/README.md

该包的说明文档，描述 `ctx.subprocess` 的挂载方式、spawn 请求形状、输出投递选择与进程树终止语义。

- 无运行期机制

### packages/subprocess/subprocess/package.json

该包的 npm 清单，声明入口、导出子路径与发布文件集。

- `main`/`types` 把默认加载入口指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/subprocess/subprocess/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/package.json#L14-L15)）
- `exports` 只暴露根入口、`./invariant`、`./src/*` 与 `./package.json` 四个可解析子路径（[packages/subprocess/subprocess/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/package.json#L16-L27)）
- `files` 把发布产物限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的声明文件（[packages/subprocess/subprocess/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/package.json#L28-L32)）

### packages/subprocess/subprocess/src/index.ts

子进程能力的服务定义入口：给出抽象服务类、`ctx.subprocess` 的注册，以及全仓共用的父进程环境擦洗函数。

- `SENSITIVE_ENV_PATTERN` 用一条大小写不敏感的正则把含 KEY/PASSWORD/SECRET/TOKEN 的环境变量名判为凭据形（[packages/subprocess/subprocess/src/index.ts:44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/src/index.ts#L44)）
- `scrubbedParentEnv` 逐项复制父进程环境，剔除凭据形名称与全部 `DSH_` 前缀名称（大小写不敏感），产出子进程的规范起始环境（[packages/subprocess/subprocess/src/index.ts:60-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/src/index.ts#L60-L66)）
- 该函数被导出为普通函数，供无法走服务的 spawn 方（node-pty、SDK 传输）共用同一份擦洗定义（[packages/subprocess/subprocess/src/index.ts:55-60](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/src/index.ts#L55-L60)）
- 抽象服务类的构造函数以 `subprocess` 名注册到上下文，因而同一上下文加载第二个实现会抛错（[packages/subprocess/subprocess/src/index.ts:102-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/src/index.ts#L102-L105)）
- 类以默认导出形式暴露，使其子类可直接作为插件加载（[packages/subprocess/subprocess/src/index.ts:142](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/src/index.ts#L142)）

### packages/subprocess/subprocess/src/types.ts

子进程服务定义的词汇表：spawn 请求、stdio 模式、句柄、偏移读取器、结束事实与终端原语的类型，另含一个受管环境命名空间常量。

- `DSH_ENV_PREFIX` 常量把 `DSH_` 定为受管子进程环境事实的命名空间前缀，环境擦洗按它剔除（[packages/subprocess/subprocess/src/types.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/src/types.ts#L13)）

### packages/subprocess/subprocess/src/invariant.ts

该包的不变量伴生插件，向 invariants 服务登记包归属。

- 以空安装器向 `ctx.invariants` 注册包名并返回其 disposer，即运行期不安装任何检查（[packages/subprocess/subprocess/src/invariant.ts:14-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/subprocess/subprocess/src/invariant.ts#L14-L22)）

### packages/subprocess/subprocess/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
