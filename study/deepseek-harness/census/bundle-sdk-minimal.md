---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/bundle/sdk-minimal
---

# packages/bundle/sdk-minimal

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、34 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/bundle/sdk-minimal/README.md

该包的说明文档，描述 `sdk-minimal` profile 的启动方式、环境变量、平台选择的持久 shell 与组合内容。

- 无运行期机制

### packages/bundle/sdk-minimal/cordis.patch.yml

该包的全部实质内容：一份完整的独立 Cordis 组合树，由清单的 `dsh.bundle.patch` 字段声明、被 profile 组合器读取，不叠加在其他 bundle 之上。

- 顶层用单个 `insert` 列出整棵树，不继承其他 bundle，用户的 profile/home/`--patch` 覆盖层仍叠加在其之上（[packages/bundle/sdk-minimal/cordis.patch.yml:1-5](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L1-L5)）
- 挂载 SDK 应用启动行并把 `profile` 值固定为 `sdk-minimal`（[packages/bundle/sdk-minimal/cordis.patch.yml:6-9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L6-L9)）
- 挂载 JSON-RPC 服务端行，注入 `sdkAppStartup` 与 `loader`，并把 `maxTokensAsSuccess` 关闭（[packages/bundle/sdk-minimal/cordis.patch.yml:11-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L11-L15)）
- 挂载模型 API 扩展、会话日志与插件包清单三行（[packages/bundle/sdk-minimal/cordis.patch.yml:17-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L17-L24)）
- 模型适配器行从 `DEEPSEEK_API_KEY` 读凭据（[packages/bundle/sdk-minimal/cordis.patch.yml:26-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L26-L29)）
- 默认上下文窗口取 `DSH_CONTEXT_WINDOW`，缺省 1000000（[packages/bundle/sdk-minimal/cordis.patch.yml:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L30)）
- 流式空闲超时设为 172800000 毫秒（[packages/bundle/sdk-minimal/cordis.patch.yml:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L31)）
- 挂载本地沙箱提供者（[packages/bundle/sdk-minimal/cordis.patch.yml:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L33-L34)）
- 沙箱策略行把模式设为 `danger-full-access`，工作区根取 `process.cwd()`（[packages/bundle/sdk-minimal/cordis.patch.yml:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L36-L40)）
- 挂载本地子进程提供者与 PTY 终端行（[packages/bundle/sdk-minimal/cordis.patch.yml:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L42-L46)）
- bash 终端栈在 `process.platform === 'win32'` 时禁用，超时 300000 毫秒（[packages/bundle/sdk-minimal/cordis.patch.yml:48-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L48-L52)）
- pwsh 终端栈复用同一包，在非 win32 时禁用，并以 `shellDialect: pwsh` 与 300000 毫秒超时挂载（[packages/bundle/sdk-minimal/cordis.patch.yml:54-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L54-L59)）
- 挂载不受策略约束的本地文件系统行，`cwd` 取 `process.cwd()`（[packages/bundle/sdk-minimal/cordis.patch.yml:61-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L61-L66)）
- agent 主干行关闭 harness 身份与运行期上下文两段提示（[packages/bundle/sdk-minimal/cordis.patch.yml:68-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L68-L72)）
- 人格取 `DSH_SYSTEM_PROMPT`，缺省为 `You are a helpful software engineer assistant.`（[packages/bundle/sdk-minimal/cordis.patch.yml:73](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L73)）
- 关闭工作区上下文、技能、内置 bash 工具与 jobs 工具（[packages/bundle/sdk-minimal/cordis.patch.yml:74-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L74-L78)）
- 持久 bash 工具行在 win32 上禁用，超时 300000 毫秒（[packages/bundle/sdk-minimal/cordis.patch.yml:80-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L80-L84)）
- 覆写 bash 工具的模型可见描述（无网络、状态跨调用持久、用 `sed -n` 看行区间、避免大输出、长任务放后台）（[packages/bundle/sdk-minimal/cordis.patch.yml:85-93](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L85-L93)）
- 持久 pwsh 工具行在非 win32 上禁用，超时 300000 毫秒（[packages/bundle/sdk-minimal/cordis.patch.yml:95-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L95-L99)）
- 覆写 pwsh 工具的模型可见描述（用 Windows 原生路径与 `$env:NAME`、避免大输出、`Start-Job`/`Start-Process` 放后台）（[packages/bundle/sdk-minimal/cordis.patch.yml:100-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L100-L107)）
- 挂载字符串替换编辑器工具，单次输出上限 16000 字符（[packages/bundle/sdk-minimal/cordis.patch.yml:109-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L109-L112)）
- 会话持久化写入 `dshHomePath('sessions')`，压缩关闭（[packages/bundle/sdk-minimal/cordis.patch.yml:114-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/cordis.patch.yml#L114-L118)）

### packages/bundle/sdk-minimal/package.json

该 bundle 包的 npm 清单，声明包名、入口、导出面与 patch 文件位置。

- `type: module`、`main`、`types` 决定该包在运行期以 ESM 从 `lib/index.js` 加载（[packages/bundle/sdk-minimal/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/package.json#L13-L15)）
- `exports` 开放根入口、`./invariant` companion、`./cordis.patch.yml` 与 `./src/*` 源码路径（[packages/bundle/sdk-minimal/package.json:16-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/package.json#L16-L28)）
- `files` 限定发布产物为两个 js 入口、patch 文件与类型声明（[packages/bundle/sdk-minimal/package.json:29-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/package.json#L29-L34)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，profile 组合器据此解析该 bundle 贡献的组合树（[packages/bundle/sdk-minimal/package.json:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/package.json#L36-L40)）
- `dependencies` 列出 patch 中每一行插件的工作区包，决定这些行在运行期可被解析（[packages/bundle/sdk-minimal/package.json:41-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/package.json#L41-L59)）

### packages/bundle/sdk-minimal/src/index.ts

该包的 TypeScript 入口模块，只有模块级 JSDoc 与一个空导出。

- 无运行期机制

### packages/bundle/sdk-minimal/src/invariant.ts

该包的 invariant companion 插件，向 `invariants` 服务登记本包名。

- 声明 companion 插件名 `sdk-minimal-bundle-invariant`（[packages/bundle/sdk-minimal/src/invariant.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/src/invariant.ts#L12)）
- 声明注入 `invariants`，该服务缺席时 companion 不挂载（[packages/bundle/sdk-minimal/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/src/invariant.ts#L14)）
- installer 为空实现，注册后不安装任何检查（[packages/bundle/sdk-minimal/src/invariant.ts:16-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/src/invariant.ts#L16-L18)）
- `apply` 以包名调用 `ctx.invariants.register` 并返回其 disposer（[packages/bundle/sdk-minimal/src/invariant.ts:25-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/sdk-minimal/src/invariant.ts#L25-L26)）

### packages/bundle/sdk-minimal/tsconfig.json

该包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 与工程引用。

- 无运行期机制
