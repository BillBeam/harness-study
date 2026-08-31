---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/util/home-paths
---

# packages/util/home-paths

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、22 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/util/home-paths/README.md

该包的英文 README，说明 home 解析优先级、波浪号展开范围与 watch 路径规范化的用法，供阅读者与文档站使用。

- 无运行期机制

### packages/util/home-paths/package.json

该包的 npm 清单，决定这个工具库以什么入口、什么子路径被其他包导入。

- `type: module` 与 `main`/`types` 把包按 ESM 从 `lib/index.js` 加载（[packages/util/home-paths/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/package.json#L13-L15)）
- `exports` 把根入口映射到 `lib/index.js`、`./invariant` 映射到 `lib/invariant.js`，并额外开放 `./src/*` 与 `./package.json` 两个子路径（[packages/util/home-paths/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/util/home-paths/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/package.json#L28-L32)）

### packages/util/home-paths/src/index.ts

该包唯一的实现文件，导出 home 目录解析、子路径拼接、显示形式、波浪号展开与 watch 路径规范化，被需要统一用户数据根目录的产品包直接导入。

- 常量 `.dsh` 决定默认 home 在操作系统 home 下的目录名（[packages/util/home-paths/src/index.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L12)）
- 常量把默认 home 的用户可见形式固定为 `~/.dsh`（[packages/util/home-paths/src/index.ts:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L15)）
- 常量把覆盖 home 的环境变量名固定为 `DSH_HOME`（[packages/util/home-paths/src/index.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L18)）
- `canonicalizeWatchPath` 先把入参 `resolve` 到绝对路径，再循环对当前路径调用 `realpath`（[packages/util/home-paths/src/index.ts:33-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L33-L38)）
- 存在缺失后缀时，对解析出的祖先执行一次 `opendir` 再关闭，以此要求该祖先是可枚举目录（[packages/util/home-paths/src/index.ts:39-44](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L39-L44)）
- 把倒序收集的缺失路径段重新拼回规范化后的祖先并返回（[packages/util/home-paths/src/index.ts:45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L45)）
- 非 `ENOENT` 的错误直接向上抛出，不进入向上回溯（[packages/util/home-paths/src/index.ts:47](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L47)）
- `ENOENT` 时把当前 basename 压入缺失列表并把游标上移到父目录继续循环，父目录等于自身时抛出（[packages/util/home-paths/src/index.ts:48-52](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L48-L52)）
- `defaultDshHome` 把操作系统 home 与 `.dsh` 拼接为默认根（[packages/util/home-paths/src/index.ts:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L61-L63)）
- `expandHomePath` 把单独的 `~` 换成操作系统 home，把 `~/` 与 `~\` 前缀去掉两字符后与 home 拼接，其余路径原样返回（[packages/util/home-paths/src/index.ts:70-74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L70-L74)）
- `resolveDshHome` 按显式入参、非空白 `DSH_HOME`、默认根的顺序选值，空串或全空白的环境变量按未设置处理（[packages/util/home-paths/src/index.ts:87-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L87-L89)）
- 选中的值先经波浪号展开再 `resolve` 成绝对路径返回（[packages/util/home-paths/src/index.ts:90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L90)）
- `dshHomePath` 把任意多个片段按平台规则拼到已解析的 home 之后（[packages/util/home-paths/src/index.ts:98-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L98-L100)）
- `dshHomeDisplay` 在等于默认根时返回 `~/.dsh`，否则返回 `$DSH_HOME`，不输出绝对机器路径（[packages/util/home-paths/src/index.ts:110-112](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/index.ts#L110-L112)）

### packages/util/home-paths/src/invariant.ts

该包的 invariant 伴生插件，被 invariants 服务加载以登记包所有权。

- 导出 `name` 与 `inject`，把伴生插件命名为 `home-paths-invariant` 并声明依赖 `invariants` 服务（[packages/util/home-paths/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/invariant.ts#L13-L15)）
- 安装函数为空体，不注册任何运行期检查（[packages/util/home-paths/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/invariant.ts#L21)）
- `apply` 用包名向 `ctx.invariants` 注册该安装函数并返回其 disposer（[packages/util/home-paths/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/util/home-paths/src/invariant.ts#L28-L29)）

### packages/util/home-paths/tsconfig.json

该包的 TypeScript 编译配置，规定源目录、声明输出目录与工程引用。

- 无运行期机制
