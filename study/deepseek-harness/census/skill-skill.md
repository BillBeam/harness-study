---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/skill/skill
---

# packages/skill/skill

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、51 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/skill/skill/README.md

技能注册表包的英文说明文档，面向配置与调试该包的读者，描述合并、优先级、缓存与失效行为。

- 无运行期机制

### packages/skill/skill/package.json

该包的 npm 清单，声明入口、导出子路径与发布文件集。

- `main`/`types` 与 `exports` 把包名解析到 `lib/index.js`，`./invariant` 解析到 `lib/invariant.js`，并额外暴露 `./src/*` 与 `./package.json`（[packages/skill/skill/package.json:14-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/package.json#L14-L27)）
- `files` 限定发布产物为 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/skill/skill/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/package.json#L28-L32)）
- `dependencies` 把 schemastery 列为运行期依赖，其余能力包为 peerDependencies（[packages/skill/skill/package.json:34-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/package.json#L34-L42)）

### packages/skill/skill/src/index.ts

技能注册表服务的实现文件，被各技能提供方（如 skill-filesystem、skill-badge）注册所用，也被 tool-skill 等消费方读取目录与加载技能体。

- `SKILL_NAME` 正则定义技能名的 kebab-case 文法，`isSkillName` 对外暴露该判定（[packages/skill/skill/src/index.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L20)、[packages/skill/skill/src/index.ts:34-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L34-L36)）
- 常量固定默认缓存条数 128、单次收集最多重试 2 次、保留提供方名 `runtime` 及其 rank 250（[packages/skill/skill/src/index.ts:21-24](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L21-L24)）
- 导出 `BUNDLED_SKILL_RANK = 600` 供打包型提供方作为统一排序位（[packages/skill/skill/src/index.ts:27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L27)）
- `isModelInvocable` / `isUserInvocable` 从调用策略读出模型面与用户面的准入布尔值（[packages/skill/skill/src/index.ts:127-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L127-L138)）
- `renderSkillContent` 把技能名放进转义后的属性、把资源提示与技能正文包进 `<skill_content>`/`<skill_resources>`/`<skill_instructions>` 三层标签，产出模型看到的完整文本（[packages/skill/skill/src/index.ts:171-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L171-L184)）
- `renderResourceHint` 按 `resourceBase` 的 directory / url / opaque 三种取值分别输出基目录、基 URL 或描述，并各自附带"按需加载引用资源"的指示；缺省时输出由提供方托管的说法（[packages/skill/skill/src/index.ts:186-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L186-L215)）
- `escapeAttr` 与导出的 `escapeText` 对 `&`、`"`、`<`、`>` 做实体替换，使提供方文本无法打开或闭合外层标签（[packages/skill/skill/src/index.ts:217-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L217-L229)）
- 声明合并向 Cordis 注册 `skills` 服务属性与 `skills/change` 事件键（[packages/skill/skill/src/index.ts:284-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L284-L299)）
- `SkillLayer` 为每个作用域持有一份提供方表与运行期技能表，重名提供方在插入时抛出（[packages/skill/skill/src/index.ts:328-344](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L328-L344)）
- `Config` schema 把 `collectCacheMaxEntries` 默认为 128，构造时再断言其为不小于 1 的整数，否则抛错阻止挂载（[packages/skill/skill/src/index.ts:358-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L358-L360)、[packages/skill/skill/src/index.ts:374-378](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L374-L378)）
- `ScopedLayers` 的层变化回调直接触发 `invalidateCache`（[packages/skill/skill/src/index.ts:363-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L363-L366)）
- `registerProvider` 给每次注册配一个 AbortController，`control.invalidate` 只在该次注册仍是当前层同名条目时才清缓存（[packages/skill/skill/src/index.ts:391-403](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L391-L403)）
- 提供方名为 `runtime` 时抛错拒绝注册（[packages/skill/skill/src/index.ts:407-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L407-L409)）
- 注册按调用上下文的作用域落层，返回的 disposer 在解除注册后 abort 该次注册的生命周期信号；`create` 抛错时同样 abort（[packages/skill/skill/src/index.ts:410-428](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L410-L428)）
- `register` 在同层已有同名运行期技能时打警告并返回空 disposer，使先注册者保持胜出（[packages/skill/skill/src/index.ts:440-447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L440-L447)）
- 运行期技能缺省的 `invocation` 补成模型面与用户面全开，缺省 `provider` 补成 `runtime`（[packages/skill/skill/src/index.ts:448-452](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L448-L452)）
- `snapshot` 把收集结果映射为摘要、按名排序，并把可缓存性作为 `complete` 返回（[packages/skill/skill/src/index.ts:482-490](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L482-L490)）
- `get` 对非法名直接返回 undefined，不进入提供方（[packages/skill/skill/src/index.ts:502](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L502)）
- `get` 在选中候选后重查取消状态，并把 `provider.get()` 与 abort 信号竞速（[packages/skill/skill/src/index.ts:503-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L503-L510)）
- 加载回来的定义先过 `validateDefinition`；名字与候选不一致则作废缓存并返回 undefined（[packages/skill/skill/src/index.ts:511-517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L511-L517)）
- `collect` 以 cwd、作用域链 id 与 revision 组成缓存键，命中即直接返回已缓存的合并表（[packages/skill/skill/src/index.ts:526-530](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L526-L530)）
- 收集期间 revision 变动则重跑一次；第二次仍变动就返回不可缓存的结果（[packages/skill/skill/src/index.ts:532-540](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L532-L540)）
- 可缓存结果写入缓存，超过上限时删除最早插入的键（[packages/skill/skill/src/index.ts:541-547](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L541-L547)）
- `collectFresh` 先取全局层再按作用域链自远及近覆盖，靠 Map 覆写实现近层同名条目整条替换远层（[packages/skill/skill/src/index.ts:552-565](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L552-L565)）
- `collectLayer` 在层内按比较器排序后首次出现者胜出，被压掉的同名条目打出携带来源的警告（[packages/skill/skill/src/index.ts:568-583](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L568-L583)）
- `listLayerCandidates` 先把该层运行期技能按名排序入列并赋 providerOrder -1，再顺序 await 各提供方的 `list()`（[packages/skill/skill/src/index.ts:585-604](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L585-L604)）
- 提供方 `list()` 抛错时：若调用方已取消则原样抛出，否则把本次收集标记为不可缓存、打警告并跳过该提供方（[packages/skill/skill/src/index.ts:605-610](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L605-L610)）
- 显式 `complete: false` 的观察结果仍贡献候选，但把整次收集标记为不可缓存；每个候选逐一过 `validateCandidate`（[packages/skill/skill/src/index.ts:611-617](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L611-L617)）
- `invalidateCache` 递增 revision、清空缓存并广播变更（[packages/skill/skill/src/index.ts:622-626](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L622-L626)）
- `invalidateEntry` 仅在产生该条目的那次注册仍在层内时才清缓存（[packages/skill/skill/src/index.ts:629-632](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L629-L632)）
- `scopeId` 用 WeakMap 给作用域键分配稳定数字 id，供缓存键序列化（[packages/skill/skill/src/index.ts:634-646](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L634-L646)）
- `notifyChange` 以 emit 模式派发 `skills/change`，监听器同步抛出与异步拒绝都只记警告，不影响注册表变更（[packages/skill/skill/src/index.ts:649-660](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L649-L660)）
- `normalizeProviderObservation` 接受数组简写并视为完整，接受 `{candidates, complete}` 观察，其余形状抛 TypeError（[packages/skill/skill/src/index.ts:663-679](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L663-L679)）
- 内置 `runtime` 提供方的 `get()` 直接把候选的 locator 当作定义返回，`list()` 恒返回空数组（[packages/skill/skill/src/index.ts:681-690](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L681-L690)）
- `runtimeCandidate` 把运行期技能包成 rank 250、locator 指向定义本身的候选（[packages/skill/skill/src/index.ts:692-706](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L692-L706)）
- `validateCandidate` 逐项拒绝非串名、非法名、非串或空描述、非法 invocation、非串 source、非有限 rank、非串 provider 以及冒名他方的 provider、非串 path（[packages/skill/skill/src/index.ts:708-740](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L708-L740)）
- `validateRuntimeSkill` 在注册时拒绝非法名与空描述（[packages/skill/skill/src/index.ts:742-746](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L742-L746)）
- `validateDefinition` 对加载回来的定义逐项校验名、描述、invocation、whenToUse、source、provider、content 与 path 的类型（[packages/skill/skill/src/index.ts:749-768](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L749-L768)）
- `toSummary` 只投影出名、描述、whenToUse、invocation、source、provider 与 resourceBase，丢弃 rank、locator、path 与 metadata（[packages/skill/skill/src/index.ts:770-781](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L770-L781)）
- `validateInvocation` 放行 undefined，但拒绝非对象、数组以及两个非布尔字段（[packages/skill/skill/src/index.ts:783-795](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L783-L795)）
- 摘要按码位比较排序，层内候选按 rank、提供方注册序、提供方内序三级比较（[packages/skill/skill/src/index.ts:797-811](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L797-L811)）
- `waitWithAbort` 在有信号时把 promise 与 abort 竞速，并在任一路径解除监听（[packages/skill/skill/src/index.ts:819-842](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L819-L842)）
- `toError` / `errorMessage` 把任意抛出值收敛成 Error 与字符串，`instanceof` 与 `String()` 自身抛出时回退到固定文案（[packages/skill/skill/src/index.ts:850-866](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L850-L866)）
- 默认导出 `SkillRegistry`，挂载该插件即安装 `ctx.skills` 服务（[packages/skill/skill/src/index.ts:868](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/index.ts#L868)）

### packages/skill/skill/src/invariant.ts

该包的不变量伴生插件，由不变量服务在启动检查时加载。

- 导出 `name` 与 `inject`，使 Cordis 以 `skill-invariant` 名加载该伴生插件并要求 `invariants` 服务先就绪（[packages/skill/skill/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/invariant.ts#L13-L15)）
- `apply` 以包名注册一个空安装器并返回其 disposer，占位该包的不变量归属（[packages/skill/skill/src/invariant.ts:21](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/invariant.ts#L21)、[packages/skill/skill/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/skill/skill/src/invariant.ts#L28-L29)）

### packages/skill/skill/tsconfig.json

该包的 TypeScript 编译配置，声明源目录、输出目录与工程引用。

- 无运行期机制
