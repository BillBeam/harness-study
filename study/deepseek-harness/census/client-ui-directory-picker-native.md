---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-directory-picker-native
---

# packages/client/ui-directory-picker-native

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、21 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-directory-picker-native/README.md

包说明文档，描述驱动宿主系统原生文件夹选择器的无渲染占位及其适用场景。

- 无运行期机制

### packages/client/ui-directory-picker-native/package.json

包清单，声明入口导出、客户端半边发现信息与发布文件列表。

- `exports` 暴露 `.`、`./invariant`、`./client`、`./src/*` 四个入口，`./client` 指向 `lib/client.js`（[packages/client/ui-directory-picker-native/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/package.json#L16-L31)）
- `dsh.client` 声明浏览器半边需注入的两个包与 `platform: "web"`，供加载器发现客户端半边（[packages/client/ui-directory-picker-native/package.json:32-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/package.json#L32-L40)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与类型声明（[packages/client/ui-directory-picker-native/package.json:62-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/package.json#L62-L67)）

### packages/client/ui-directory-picker-native/src/client/flow.ts

无渲染的目录流占位组件，把 owner 的每次打开请求转成一次宿主原生选择器调用。

- 用 `outcome` ref 每次渲染保存最新 props，使结算走 owner 的最新回调而非打开时捕获的那份（[packages/client/ui-directory-picker-native/src/client/flow.ts:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/flow.ts#L30-L31)）
- 用 `alive` ref 在挂载时置真、卸载时置假，并在 setup 阶段重新置真以配合开发期的重放（[packages/client/ui-directory-picker-native/src/client/flow.ts:39-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/flow.ts#L39-L45)）
- `open` 为假时复位 `armed`，使 owner 撤回请求后下一次上升沿可再次触发（[packages/client/ui-directory-picker-native/src/client/flow.ts:46-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/flow.ts#L46-L50)）
- 已 armed 时直接返回，使重渲染不会重复拉起第二个选择器（[packages/client/ui-directory-picker-native/src/client/flow.ts:51-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/flow.ts#L51-L52)）
- 调用注入的 `pick()` 拉起宿主原生选择器（[packages/client/ui-directory-picker-native/src/client/flow.ts:53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/flow.ts#L53)）
- 已卸载时丢弃结算，不调用 owner 的任何回调（[packages/client/ui-directory-picker-native/src/client/flow.ts:55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/flow.ts#L55)）
- 返回 `null` 视为取消调用 `onCancel`，否则以路径调用 `onPicked`（[packages/client/ui-directory-picker-native/src/client/flow.ts:56](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/flow.ts#L56)）
- 调用被拒绝时把 `Error.message` 或其字符串化结果交给 owner 的 `onError`，同样先校验存活（[packages/client/ui-directory-picker-native/src/client/flow.ts:58-61](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/flow.ts#L58-L61)）
- 组件本身返回 `null`，不在浏览器中渲染任何界面（[packages/client/ui-directory-picker-native/src/client/flow.ts:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/flow.ts#L64)）

### packages/client/ui-directory-picker-native/src/client/index.ts

浏览器半边插件入口，把无渲染的原生选择占位填入两个目录流槽位。

- `inject` 声明依赖 `slots` 与 `uiWorkspace` 两个服务（[packages/client/ui-directory-picker-native/src/client/index.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/index.ts#L20)）
- `injected` 把 `ctx.uiWorkspace.pickDirectory()` 作为占位组件的 `pick` 调用（[packages/client/ui-directory-picker-native/src/client/index.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/index.ts#L29)）
- 以嵌套的 `slots.inject` 把 `conversation.hero.workspace.directoryFlow` 与 `sidebar.workspaces.directoryFlow` 两个洞的注册合成一次事务性生效（[packages/client/ui-directory-picker-native/src/client/index.ts:33-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/client/index.ts#L33-L41)）

### packages/client/ui-directory-picker-native/src/index.ts

宿主半边插件入口。

- 导出空的 `apply`，插件在宿主侧被装载后不注册任何宿主行为（[packages/client/ui-directory-picker-native/src/index.ts:10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/index.ts#L10)）

### packages/client/ui-directory-picker-native/src/invariant.ts

包级不变量伴生插件，向不变量服务登记包名。

- `apply` 调用 `ctx.invariants.register` 登记包名与安装器并返回其 disposer（[packages/client/ui-directory-picker-native/src/invariant.ts:29-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/invariant.ts#L29-L30)）
- 安装器为空函数，不注册任何运行期检查（[packages/client/ui-directory-picker-native/src/invariant.ts:22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/src/invariant.ts#L22)）

### packages/client/ui-directory-picker-native/tsconfig.json

包的 TypeScript 编译配置与工程引用。

- 无运行期机制

### packages/client/ui-directory-picker-native/tsdown.config.ts

打包配置，被 `pnpm bundle` 使用。

- 声明该包的打包入口为 `lib/types/index.js` 与 `lib/types/invariant.js`（[packages/client/ui-directory-picker-native/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-directory-picker-native/tsdown.config.ts#L3)）
