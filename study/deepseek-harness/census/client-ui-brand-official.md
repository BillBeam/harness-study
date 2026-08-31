---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-brand-official
---

# packages/client/ui-brand-official

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、15 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-brand-official/README.md

该包的说明文档，介绍它占据哪三个品牌槽位、构建档位如何决定是否注册，供使用者与维护者阅读。

- 无运行期机制

### packages/client/ui-brand-official/package.json

该包的 npm 清单，声明入口映射、浏览器插件行的注入依赖与发布文件集。

- `exports` 把 `.`、`./invariant`、`./client` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 及各自的类型文件，并放开 `./src/*` 与 `./package.json`（[packages/client/ui-brand-official/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/package.json#L16-L31)）
- `dsh.client.inject` 列出三个需先就位的客户端包，并把 `platform` 定为 `web`（[packages/client/ui-brand-official/package.json:32-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/package.json#L32-L41)）
- `files` 只把三个 `lib` 运行期文件与 `lib/types/**/*.d.ts` 纳入发布（[packages/client/ui-brand-official/package.json:66-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/package.json#L66-L71)）

### packages/client/ui-brand-official/src/client/Brand.tsx

两个品牌槽位占位组件的实现，被同目录的 `index.ts` 注册进侧栏与会话首屏槽位。

- `OfficialBrandMark` 把宿主槽位传来的 `size` 与 `className` 透传给 `FishLogo` 渲染（[packages/client/ui-brand-official/src/client/Brand.tsx:12-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/src/client/Brand.tsx#L12-L14)）
- `OfficialBrandName` 渲染 `BrandWordmark` 并以 `includeMark={false}` 去掉其自带的标记（[packages/client/ui-brand-official/src/client/Brand.tsx:20-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/src/client/Brand.tsx#L20-L22)）

### packages/client/ui-brand-official/src/client/index.ts

浏览器端插件入口，按构建档位把两个组件登记进三个品牌槽位。

- 导出 `inject = ['slots']`，声明该插件需要槽位注册服务（[packages/client/ui-brand-official/src/client/index.ts:9](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/src/client/index.ts#L9)）
- `apply` 在 `process.env.DSH_CLIENT_BUILD_PROFILE` 不等于 `'official'` 时直接返回，什么也不注册（[packages/client/ui-brand-official/src/client/index.ts:16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/src/client/index.ts#L16)）
- 三层嵌套的 `ctx.slots.inject` 等 `sidebar.brand.mark`、`sidebar.brand.name`、`conversation.hero.brand.mark` 三个声明都在之后，才在一个生成器里依次 `yield` 三次注册，任一声明消失时三个占位一起撤下（[packages/client/ui-brand-official/src/client/index.ts:17-23](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/src/client/index.ts#L17-L23)）

### packages/client/ui-brand-official/src/index.ts

该包的宿主端入口，与浏览器端一半配对。

- 导出一个空的 `apply`，作为宿主端插件体供加载器装载（[packages/client/ui-brand-official/src/index.ts:7](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/src/index.ts#L7)）

### packages/client/ui-brand-official/src/invariant.ts

该包的不变量伴生插件，向不变量服务登记包名。

- 导出插件名 `client-ui-brand-official-invariant` 与 `inject = ['invariants']`（[packages/client/ui-brand-official/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/src/invariant.ts#L13-L15)）
- 安装器体为空，不注册任何检查（[packages/client/ui-brand-official/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/src/invariant.ts#L21)）
- `apply` 用 `ctx.invariants.register(PACKAGE_NAME, install)` 占位并把其 disposer 以 Promise 返回（[packages/client/ui-brand-official/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/src/invariant.ts#L28-L29)）

### packages/client/ui-brand-official/tsconfig.json

该包的 TypeScript 编译配置，继承客户端基配置并列出工程引用。

- 无运行期机制

### packages/client/ui-brand-official/tsdown.config.ts

该包的打包配置，声明要打出的产物入口。

- 用 `clientBundle` 以包名和 `lib/types/index.js`、`lib/types/invariant.js` 两个入口生成打包配置（[packages/client/ui-brand-official/tsdown.config.ts:3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-brand-official/tsdown.config.ts#L3)）
