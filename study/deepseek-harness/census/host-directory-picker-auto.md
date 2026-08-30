---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/host/directory-picker-auto
---

# packages/host/directory-picker-auto

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、27 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/host/directory-picker-auto/README.md

该自适应挑选包的说明文档，描述启动期判定表、挂载方式与已知限制。

- 无运行期机制

### packages/host/directory-picker-auto/package.json

该包的 npm 清单，声明入口、导出子路径、发布文件集与它在运行期按字符串挂载的对等依赖。

- `main`/`types` 指定包的默认运行时入口为 `lib/index.js`、类型入口为 `lib/types/index.d.ts`（[packages/host/directory-picker-auto/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/package.json#L14-L15)）
- `exports` 把 `.` 与 `./invariant` 映射到 `lib/index.js` 与 `lib/invariant.js`，并开放 `./src/*` 与 `./package.json`（[packages/host/directory-picker-auto/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/package.json#L16-L27)）
- `files` 限定发布进包的文件为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 d.ts（[packages/host/directory-picker-auto/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/package.json#L28-L32)）
- `peerDependencies` 列入两个宿主后端包、两个客户端界面包、`webServer`、`loader` 与 invariants，使 `apply` 里按字符串挂载的条目可被解析（[packages/host/directory-picker-auto/package.json:34-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/package.json#L34-L43)）

### packages/host/directory-picker-auto/src/index.ts

该包的插件入口，在启动时采样宿主状况解析出一种后端，并把对应的宿主包与客户端包作为 Loader 条目挂载进内存中的根配置树。

- `name` 把插件名固定为 `directory-picker-auto`（[packages/host/directory-picker-auto/src/index.ts:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/index.ts#L27)）
- `inject` 声明依赖 `webServer` 与 `loader`，两者就绪后 `apply` 才执行（[packages/host/directory-picker-auto/src/index.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/index.ts#L29)）
- `BACKEND_PACKAGES` 把解析出的两种取值映射到具体的宿主后端包名（[packages/host/directory-picker-auto/src/index.ts:37-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/index.ts#L37-L40)）
- `SURFACE_PACKAGES` 把同样两种取值映射到对应的客户端界面包名（[packages/host/directory-picker-auto/src/index.ts:50-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/index.ts#L50-L53)）
- `apply` 采样 `ctx.webServer.host`、`process.platform`、`process.env` 与 PATH 探测结果，调用解析函数得出后端种类（[packages/host/directory-picker-auto/src/index.ts:63-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/index.ts#L63-L68)）
- 挂载动作包在 `ctx.effect` 里并返回 `unmount` 作为 disposer，卸载本插件即触发该回收（[packages/host/directory-picker-auto/src/index.ts:69-97](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/index.ts#L69-L97)）
- 按先后端、后界面的顺序调用 `ctx.loader.create({ name })` 建立条目并记录 id（[packages/host/directory-picker-auto/src/index.ts:86-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/index.ts#L86-L88)）
- `unmount` 逆序遍历已记录 id，跳过已从 store 消失的条目，对其余逐个 `await ctx.loader.remove(id)`（[packages/host/directory-picker-auto/src/index.ts:75-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/index.ts#L75-L84)）
- 建立条目过程中抛错时先执行 `unmount` 回收已建立的条目再向上抛出原因（[packages/host/directory-picker-auto/src/index.ts:89-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/index.ts#L89-L95)）

### packages/host/directory-picker-auto/src/invariant.ts

该包的 invariant 伴生插件，向 invariants 服务登记包名归属。

- `inject` 声明该伴生插件依赖 `invariants` 服务，未就绪则不执行 `apply`（[packages/host/directory-picker-auto/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/invariant.ts#L14)）
- installer 为空函数，注册后不安装任何运行期检查（[packages/host/directory-picker-auto/src/invariant.ts:17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/invariant.ts#L17)）
- `apply` 调用 `ctx.invariants.register` 以包名注册该 installer 并返回其 disposer（[packages/host/directory-picker-auto/src/invariant.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/invariant.ts#L24-L25)）

### packages/host/directory-picker-auto/src/probe.ts

该文件提供启动期的 PATH 探测，判断宿主上是否存在原生后端在 Linux 上能驱动的对话框二进制。

- 常量固定了被探测的两个二进制名 `zenity` 与 `kdialog`（[packages/host/directory-picker-auto/src/probe.ts:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/probe.ts#L13)）
- `canExecute` 用 `accessSync(candidate, X_OK)` 判定可执行性，抛错即返回 false（[packages/host/directory-picker-auto/src/probe.ts:20-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/probe.ts#L20-L28)）
- `hasLinuxChooserBinary` 按平台分隔符切分 PATH、跳过空段、对每个目录拼接两个二进制名逐个判定，命中即返回 true，全部落空返回 false（[packages/host/directory-picker-auto/src/probe.ts:36-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/probe.ts#L36-L44)）

### packages/host/directory-picker-auto/src/resolve.ts

该文件是从采样到的宿主事实到后端种类的纯函数判定，被插件入口在每次启动时调用一次。

- `present` 规定环境变量只有既已设置又非空串才算存在（[packages/host/directory-picker-auto/src/resolve.ts:32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/resolve.ts#L32)）
- 绑定地址不是 `127.0.0.1` 时直接判定为 `browse`（[packages/host/directory-picker-auto/src/resolve.ts:48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/resolve.ts#L48)）
- `SSH_CONNECTION` 或 `SSH_TTY` 存在时判定为 `browse`（[packages/host/directory-picker-auto/src/resolve.ts:49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/resolve.ts#L49)）
- 平台为 darwin 或 win32 时判定为 `native`（[packages/host/directory-picker-auto/src/resolve.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/resolve.ts#L50)）
- 平台不是 linux，或 linux 上没有对话框二进制时判定为 `browse`（[packages/host/directory-picker-auto/src/resolve.ts:51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/resolve.ts#L51)）
- 其余情况按 `DISPLAY` 或 `WAYLAND_DISPLAY` 是否存在返回 `native` 或 `browse`（[packages/host/directory-picker-auto/src/resolve.ts:52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/host/directory-picker-auto/src/resolve.ts#L52)）

### packages/host/directory-picker-auto/tsconfig.json

该包的 TypeScript 编译配置，设定源目录、产物目录与项目引用。

- 无运行期机制
