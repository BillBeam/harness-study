---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/client/ui-session
---

# packages/client/ui-session

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、38 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/client/ui-session/README.md

会话 UI 适配包的英文说明文档，概述它贡献的根源、每会话源与已知限制，供阅读者查阅。

- 无运行期机制

### packages/client/ui-session/package.json

该包的 npm 清单，决定它以什么入口被加载、以及客户端加载时先等谁。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/client/ui-session/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/package.json#L14-L15)）
- `exports` 把 `.`、`./invariant`、`./client` 分别映射到 `lib/index.js`、`lib/invariant.js`、`lib/client.js`，另放开 `./src/*` 与 `./package.json`（[packages/client/ui-session/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/package.json#L16-L31)）
- `dsh.client` 声明客户端注入 `@deepseek-ai/dsh-api-session-controller` 与 `@deepseek-ai/dsh-client-ui-renderer`，平台限定为 `web`（[packages/client/ui-session/package.json:32-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/package.json#L32-L40)）
- `files` 只发布 `lib/index.js`、`lib/invariant.js`、`lib/client.js` 与 `lib/types/**/*.d.ts`（[packages/client/ui-session/package.json:64-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/package.json#L64-L69)）

### packages/client/ui-session/src/client/index.ts

该包的浏览器插件本体：把会话控制器状态适配成根标准源与 `session` 作用域适配器，并托管待处理交互。

- `PendingInteractionDomain.publish` 在同域内重复 `key` 时抛错，写入后通知变更，返回的 disposer 幂等且只在真正删掉时再通知（[packages/client/ui-session/src/client/index.ts:81-94](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L81-L94)）
- `PendingInteractionDomain.release` 一次清空全部待处理值并把各自的 delegate 交出去（[packages/client/ui-session/src/client/index.ts:97-101](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L97-L101)）
- `BUILTIN_SOURCE` 是内置的每会话贡献：`session` 观察源、按键的 `projection` 解析器（转发到 `binding.session.projections.faceOf`）、`sessionId` prop（[packages/client/ui-session/src/client/index.ts:197-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L197-L210)）
- `pendingInteractions` 暴露成一个独立于控制器快照的根观察源（[packages/client/ui-session/src/client/index.ts:225-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L225-L231)）
- 构造函数以服务名 `uiSession` 注册，先算出缺席绑定再算当前绑定（[packages/client/ui-session/src/client/index.ts:243-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L243-L245)）
- 构造函数装配 `adapter`：`current` 是当前绑定的观察源、`resolve` 按会话 id 解析、`renderArea` 交给 session-provider（[packages/client/ui-session/src/client/index.ts:246-256](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L246-L256)）
- 构造函数用 `ctx.effect` 订阅 `sessions.list` 并在变化时 `publishCurrent`；拆卸时退订并释放所有已物化绑定（[packages/client/ui-session/src/client/index.ts:258-266](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L258-L266)）
- `provide` 把描述符压入名册并重建全部绑定，重建抛错时回滚该描述符；disposer 摘除后再次重建（[packages/client/ui-session/src/client/index.ts:274-295](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L274-L295)）
- `registerPendingInteraction` 建一个带优先级函数的域并注册进名册，返回发布函数（[packages/client/ui-session/src/client/index.ts:304-322](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L304-L322)）
- 该域的拆卸是异步的：先清空可见值并摘除域、重新发布快照，再 `Promise.allSettled` 等每个 delegate 结算（[packages/client/ui-session/src/client/index.ts:314-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L314-L320)）
- `rebuildBindings` 先在新表里把所有已缓存会话重新物化，中途抛错就释放新建的部分并原样抛出，成功后才整体换表并释放旧记录（[packages/client/ui-session/src/client/index.ts:325-341](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L325-L341)）
- `resolve` 在控制器无此会话时返回 undefined；owner 未变则复用缓存，变了则重新物化并释放旧记录（[packages/client/ui-session/src/client/index.ts:343-352](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L343-L352)）
- `resolveCurrent` 取控制器列表快照的 `current`，无当前会话或解析失败时落到缺席绑定（[packages/client/ui-session/src/client/index.ts:354-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L354-L357)）
- `publishCurrent` 只在绑定对象引用真正改变时才替换并通知订阅者（[packages/client/ui-session/src/client/index.ts:359-364](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L359-L364)）
- `publishPendingInteractions` 跨域按会话取优先级最大者（同分时后来的域覆盖），投影成"每会话一条"的映射（[packages/client/ui-session/src/client/index.ts:366-382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L366-L382)）
- `publishPendingInteractions` 与旧快照逐项按引用比对，相同则不发通知（[packages/client/ui-session/src/client/index.ts:383-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L383-L385)）
- `createMaterializedBinding` 把该会话绑定的清理挂在会话自己的 `owner.ctx` 上；会话上下文销毁时删除该绑定，若它正是当前绑定则把当前绑定退回缺席并通知（[packages/client/ui-session/src/client/index.ts:388-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L388-L403)）
- `materialize` 逐个跑描述符的 `resolve`，校验后按声明名册收集 hooks/keyedHooks/props，产出带 `key`（会话 id）与 `ctx` 的作用域绑定（[packages/client/ui-session/src/client/index.ts:405-423](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L405-L423)）
- `materialize` 末尾调用 `ctx.slots.bindStoreScope(value)`，把该会话的 Store 清理挂到会话上下文（[packages/client/ui-session/src/client/index.ts:424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L424)）
- `materializeAbsent` 按同一批名册造出全部成员为 `undefined`、`key` 为 `undefined` 的缺席绑定（[packages/client/ui-session/src/client/index.ts:428-439](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L428-L439)）
- `rejectUndeclared` 对 `resolve` 返回了未声明成员的描述符抛错（[packages/client/ui-session/src/client/index.ts:451-461](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L451-L461)）
- `copyDeclared` 对声明了却没给值的成员抛错（[packages/client/ui-session/src/client/index.ts:463-476](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L463-L476)）
- `claimStandardProp` 把 hook 名转成 `use<Name>` prop 名后占位，两个成员落到同一 prop 名即抛错（[packages/client/ui-session/src/client/index.ts:490-496](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L490-L496)）
- 插件声明注入 `sessions` 与 `slots`（[packages/client/ui-session/src/client/index.ts:499](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L499)）
- `apply` 建服务后向根贡献两个观察源：`sessions`（控制器列表）与 `sessionPendingInteraction`（待处理交互）（[packages/client/ui-session/src/client/index.ts:506-512](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L506-L512)）
- `apply` 用 `ctx.slots.installScope('session', service.adapter)` 装上 session 作用域适配器（[packages/client/ui-session/src/client/index.ts:513](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/index.ts#L513)）

### packages/client/ui-session/src/client/session-provider.tsx

标准 `SessionProvider` 座位的渲染语义，被同包 index.ts 装进作用域适配器的 `renderArea`。

- 无当前会话时渲染 `empty?.()`（没有 `empty` 则渲染 null），有会话时用会话 id 作 key 包一层 `Fragment`，换会话即整段重挂（[packages/client/ui-session/src/client/session-provider.tsx:13-20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/client/session-provider.tsx#L13-L20)）

### packages/client/ui-session/src/index.ts

该包的 Host 侧加载入口。

- 无运行期机制

### packages/client/ui-session/src/invariant.ts

该包自带的运行期不变式伴生插件。

- 声明插件名 `client-ui-session-invariant` 并注入 `invariants` 服务（[packages/client/ui-session/src/invariant.ts:8-10](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/invariant.ts#L8-L10)）
- 安装器为空并写明理由：绑定一致性由适配器物化路径自身保证（[packages/client/ui-session/src/invariant.ts:12-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/invariant.ts#L12-L13)）
- `apply` 以包名 `@deepseek-ai/dsh-client-ui-session` 向 `ctx.invariants` 注册并返回 disposer（[packages/client/ui-session/src/invariant.ts:20-21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/src/invariant.ts#L20-L21)）

### packages/client/ui-session/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制

### packages/client/ui-session/tsdown.config.ts

该包的打包配置，决定发布到 `lib/` 的运行期产物。

- 以插件 id `@deepseek-ai/dsh-client-ui-session` 调用 `clientBundle`，Node 半边打出 `lib/index.js` 与 `lib/invariant.js`，浏览器半边另打出 `lib/client.js`（[packages/client/ui-session/tsdown.config.ts:1-3](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/client/ui-session/tsdown.config.ts#L1-L3)）
