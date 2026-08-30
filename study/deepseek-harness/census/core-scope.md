---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/core/scope
---

# packages/core/scope

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、41 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/core/scope/README.md

包的英文说明文档，描述如何铸造作用域、路由作用域事件、构建分层注册表，以及父子链的两个方向。

- 无运行期机制

### packages/core/scope/package.json

包清单，声明模块类型、入口、子路径导出与随包发布的文件。

- `"type": "module"` 与 `main`/`types` 指向 `lib/index.js` 及其类型声明（[packages/core/scope/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/package.json#L13-L15)）
- `exports` 开放根入口、`./invariant`、`./src/*` 源码直读与 `./package.json` 四类解析入口（[packages/core/scope/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 和 `lib/types/**/*.d.ts`（[packages/core/scope/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/package.json#L28-L32)）

### packages/core/scope/src/index.ts

作用域原语的主入口：铸造带标签的 Cordis 上下文、维护作用域键的父链、构造事件路由载体，被 agent-loop 等包用来做按 agent 隔离的注册与派发。

- 用一个模块私有 Symbol 作为上下文上的作用域标签（[packages/core/scope/src/index.ts:18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L18)）
- 用一个 WeakMap 记录每个载体对应的键，键的"存在"本身用来区分无键载体与非载体（[packages/core/scope/src/index.ts:30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L30)）
- 用一个 WeakMap 记录每个作用域键的父键，注册视图沿链向下继承、事件准入沿链向上扩展（[packages/core/scope/src/index.ts:32-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L32-L39)）
- `linkScopeParent` 在写入前沿父链上溯，发现会成环就抛错（[packages/core/scope/src/index.ts:54-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L54-L59)）
- `bindScopeParent` 对已有父的键直接抛错，只把重新连接的能力交给返回的 binding（[packages/core/scope/src/index.ts:72-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L72-L82)）
- `scopeParentOf` 读一个键的父键，根作用域返回 `undefined`（[packages/core/scope/src/index.ts:89-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L89-L91)）
- `scopeChainOf` 返回从自身到根、由近及远的键数组（[packages/core/scope/src/index.ts:98-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L98-L102)）
- `quiesceFiber` 先 dispose 再反复等 `fiber.inertia`，直到异步拆解彻底静默（[packages/core/scope/src/index.ts:115-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L115-L118)）
- `createScope` 可先绑父，再用一个空插件开 fiber，把作用域键 extend 到它的上下文上（[packages/core/scope/src/index.ts:137-140](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L137-L140)）
- 返回的 `rawDispose` 是 Cordis 原始 disposer，`dispose` 是记忆化的静默等待，并发调用共享同一个完成点（[packages/core/scope/src/index.ts:141-147](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L141-L147)）
- `scopeOf` 读取上下文继承到的最近一层作用域标签（[packages/core/scope/src/index.ts:154-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L154-L156)）
- `scopeTarget` 造出的载体先跑基础对象原有的 Cordis filter，不通过就直接拒（[packages/core/scope/src/index.ts:170-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L170-L175)）
- 无标签的监听者一律准入；带标签的监听者只有在标签等于派发键或是其祖先时才准入，链下的标签被排除（[packages/core/scope/src/index.ts:176-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L176-L181)）
- 载体建好后把它的路由键登记进 WeakMap（[packages/core/scope/src/index.ts:183-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L183-L184)）
- `isScopeCarrier` 与 `carrierKeyOf` 判定一个派发接收者是否为载体并取出其路由键（[packages/core/scope/src/index.ts:192-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/index.ts#L192-L204)）

### packages/core/scope/src/invariant.ts

包自带的不变量伴随插件：对每次 Cordis 事件派发检查作用域事件是否带了正确的载体。

- 全局挂在 `internal/dispatch` 上，先用生成的解析表判断该事件名是否是作用域过滤事件，不是就直接返回（[packages/core/scope/src/invariant.ts:16-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/invariant.ts#L16-L19)）
- 作用域事件的 `thisArg` 不是载体时判失败，提示改用 `scopeTarget`/`agentEvents`（[packages/core/scope/src/invariant.ts:20-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/invariant.ts#L20-L25)）
- 解析器非 null 时还比对载体键与事件参数里指名的主体是否同一个对象，不同即判失败（[packages/core/scope/src/invariant.ts:26-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/invariant.ts#L26-L31)）
- `apply` 以包名向 `ctx.invariants` 注册该安装器并返回其 disposer（[packages/core/scope/src/invariant.ts:40-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/invariant.ts#L40-L41)）

### packages/core/scope/src/scoped-events.generated.ts

由 `pnpm run gen-scoped-events` 生成的映射表，供同包的不变量伴随判断某个事件是否是作用域过滤事件、以及它的路由主体在哪个参数上。

- 一张被冻结的表把 27 个事件名映射到取路由主体的函数，agent/tools/approval 等事件从第一个参数取 `agent`，`system-prompt/assemble` 从第二个参数取 `scope`（[packages/core/scope/src/scoped-events.generated.ts:10-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/scoped-events.generated.ts#L10-L38)）
- `session/*` 与 `subagent/*` 六个事件映射为 `null`，表示只检查载体存在、不比对主体（[packages/core/scope/src/scoped-events.generated.ts:25-30](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/scoped-events.generated.ts#L25-L30)）
- `scopedSubjectResolverFor` 用事件名查表，未登记的事件返回 `undefined`（[packages/core/scope/src/scoped-events.generated.ts:48-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/scoped-events.generated.ts#L48-L50)）

### packages/core/scope/src/store.ts

供作用域感知注册表复用的存储层：两种插入序条目表加一个持有全局层与按作用域惰性建层的 `ScopedLayers`。

- `NamedEntries.insert` 遇到重名调用方提供的错误构造器抛错，成功后返回只撤销这一次插入的幂等 undo（[packages/core/scope/src/store.ts:43-54](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L43-L54)）
- 表被清空时换一个新的 Map，让此前取出的迭代器与后续插入脱钩（[packages/core/scope/src/store.ts:51-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L51-L53)）
- `get`/`has`/`keys`/`entries`/`values` 直接返回底层 Map 的实时读取与插入序迭代器（[packages/core/scope/src/store.ts:61-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L61-L96)）
- `AnonymousEntries.append` 用新建 Symbol 作键，使相等的值仍是彼此独立的两次注册，并返回该次追加的幂等 undo（[packages/core/scope/src/store.ts:122-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L122-L133)）
- `ScopedLayers` 构造时立刻建出上下文全局层，作用域层留给注册时惰性创建（[packages/core/scope/src/store.ts:160-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L160-L169)）
- `peek` 只查精确作用域的覆盖层且不建层，刻意不看父链（[packages/core/scope/src/store.ts:180-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L180-L183)）
- `chainLayers` 沿父链把已存在的层按最远祖先在前、精确作用域在后排列，缺席的层跳过（[packages/core/scope/src/store.ts:192-199](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L192-L199)）
- `merge` 先铺全局命名条目，再按链序覆盖，同名时最近的作用域胜出（[packages/core/scope/src/store.ts:208-217](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L208-L217)）
- `effect` 从注册上下文同时取出可见作用域与效果归属，`undefined` 落到全局层，否则按需新建该作用域层（[packages/core/scope/src/store.ts:230-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L230-L247)）
- 变更动作抛错时，若这一层是本次新建且仍为空就把它删掉再上抛（[packages/core/scope/src/store.ts:249-255](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L249-L255)）
- 撤销时执行 undo、把变空的作用域层回收，并按 `notify` 决定是否触发 `onChange`；注册成功后同样按 `notify` 通知一次（[packages/core/scope/src/store.ts:257-262](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L257-L262)）
- 返回 `ctx.effect()` 给出的那个精确同步 disposer，保持 Cordis 的效果同一性（[packages/core/scope/src/store.ts:263-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/src/store.ts#L263-L265)）

### packages/core/scope/tsconfig.json

包的 TypeScript 编译配置，声明源目录、类型输出目录与项目引用。

- 无运行期机制

### packages/core/scope/tsdown.config.ts

tsdown 打包配置，决定该包发布产物里有哪些可加载的 JS 文件以及它们之间的引用方式。

- 把根入口与 invariant 伴随分别打成 `lib/index.js` 和 `lib/invariant.js` 两个独立 ESM 包，目标 es2024、平台 node（[packages/core/scope/tsdown.config.ts:4-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/tsdown.config.ts#L4-L26)）
- invariant 包对 `@deepseek-ai/dsh-scope` 声明 `neverBundle`，让两个产物共用同一份载体 WeakMap（[packages/core/scope/tsdown.config.ts:24-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/scope/tsdown.config.ts#L24-L25)）
