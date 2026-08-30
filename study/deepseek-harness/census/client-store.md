---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/store
---

# packages/client/store

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、24 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/store/README.md

包 README，说明这个包提供不依赖 React 的可观察快照存储原语，并记下持久化仅限浏览器本地这一限制。

- 无运行期机制

### packages/client/store/package.json

包清单，声明这个纯浏览器状态库的入口、运行期依赖与发布文件。

- `exports` 暴露 `.` 主入口与 `./invariant` 伴生插件入口，另有 `./src/*` 直通源码（[packages/client/store/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/package.json#L16-L27)）
- `dependencies` 声明 `immer` 与 `zustand` 为运行期依赖，构建时据此决定内联还是保留为 import（[packages/client/store/package.json:29-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/package.json#L29-L32)）
- `files` 白名单只发布 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/client/store/package.json:41-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/package.json#L41-L45)）
- 清单没有 `dsh.client` 段，因此这个包不会被 node 半扫描成 boot 图行（[packages/client/store/package.json:1-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/package.json#L1-L46)）

### packages/client/store/src/contract.ts

快照与存储的类型声明文件：可观察快照源、选择器 hook、动作声明表、存储 spec／句柄／实例等接口与类型别名，被引擎实现与渲染侧共同引用。

- 无运行期机制

### packages/client/store/src/index.ts

引擎实现：基于 zustand vanilla + immer 的快照存储，加上 `defineStore` 声明式外壳，导出给浏览器侧控制器与渲染适配层使用。

- `notifySubscribers` 先复制订阅者列表再逐个回调，并用 try/catch 把单个回调的异常打到 console，使一个订阅者无法饿死其余（[packages/client/store/src/index.ts:46-58](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L46-L58)）
- `shallowEqual` 把 zustand 的浅比较随引擎一起导出，供选择器切片比较（[packages/client/store/src/index.ts:67-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L67-L69)）
- `rafBatch` 在有 `requestAnimationFrame` 时按帧调度、否则退回微任务，并用 scheduled 标志把一轮内的多次变更合并成一次通知（[packages/client/store/src/index.ts:72-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L72-L88)）
- `createSnapshotStore` 用 `subscribeWithSelector` 中间件建 zustand vanilla store，并在声明了 persist 时挂上持久化（[packages/client/store/src/index.ts:107-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L107-L109)）
- 默认 sync 模式下每次状态变更直接回调订阅者；`raf` 模式改为自持一份订阅者集合，由一个订阅到底层 store 的帧批处理器统一刷新（[packages/client/store/src/index.ts:111-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L111-L122)）
- 返回的 store 面：`update` 走 immer `produce` 并以整体替换方式写回，`set` 先按环境深冻结再整体替换（[packages/client/store/src/index.ts:124-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L124-L135)）
- `attachPersistence` 在没有 `localStorage` 的运行时直接静默禁用持久化（[packages/client/store/src/index.ts:146-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L146-L150)）
- `attachPersistence` 构造时从 `localStorage` 读回整值 JSON 并整体覆盖状态，解析失败只打日志不阻断（[packages/client/store/src/index.ts:151-158](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L151-L158)）
- `attachPersistence` 订阅每次状态变更并整值写回 `localStorage`，写失败只打日志（[packages/client/store/src/index.ts:159-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L159-L165)）
- `devFreeze` 在生产环境下原样返回，否则用 immer 深冻结整值（[packages/client/store/src/index.ts:169-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L169-L172)）
- `defineStore` 返回携带原 spec 的句柄，其 `create` 按 scopeKey 给 persist 键加后缀，使同一声明在不同作用域下独立持久化（[packages/client/store/src/index.ts:217-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L217-L227)）
- `create` 每次调用 `spec.init()` 得到全新状态，并把动作表的每个 draft 变换烘焙成一个走 `store.update` 的回调（[packages/client/store/src/index.ts:225-232](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L225-L232)）
- 返回的实例暴露烘焙后的动作集、`getSnapshot`／`subscribe`、底层 store，以及删除对应 `localStorage` 键的 `clearPersisted`（存储异常被吞掉）（[packages/client/store/src/index.ts:233-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/index.ts#L233-L247)）

### packages/client/store/src/invariant.ts

本包的不变量伴生插件，注入 `invariants` 服务、登记包归属，安装器为空并写明理由。

- 导出插件名与 `inject = ['invariants']`，决定该伴生插件何时可以启动（[packages/client/store/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/invariant.ts#L13-L15)）
- 安装器为空函数，注释给出理由：本包只导出库引擎、不产生进程级全局状态（[packages/client/store/src/invariant.ts:17-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/invariant.ts#L17-L21)）
- `apply` 用包名向 `ctx.invariants` 注册安装器并返回其 disposer（[packages/client/store/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/src/invariant.ts#L28-L29)）

### packages/client/store/tsconfig.json

包级 TypeScript 编译配置，继承 Client 基配置并声明源／输出目录与工程引用。

- 无运行期机制

### packages/client/store/tsdown.config.ts

包级 tsdown 配置，选用静态链接预设。

- 以包名与 `lib/types/index.js`、`lib/types/invariant.js` 调用 `staticLinked`，把本包放进静态装配通道——由外壳解析包名并把产物静态打进自身，因此它不作为模块表行被浏览器动态取用（[packages/client/store/tsdown.config.ts:1-6](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/store/tsdown.config.ts#L1-L6)）
