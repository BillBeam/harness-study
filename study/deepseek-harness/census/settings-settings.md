---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/settings/settings
---

# packages/settings/settings

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 8 个文件、60 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/settings/settings/README.md

该包的英文 README，说明 `ctx.settings` 的命名空间注册、分层解析、写入与事件语义。

- 记载解析顺序：schema 默认值、注册方的组合 `base`、用户文档段，用户层最高（[packages/settings/settings/README.md:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/README.md#L12)）
- 记载 `get` 返回深冻结快照、未注册时为 `undefined`，`watch` 回调按提交顺序逐个串行调用且失败被容纳（[packages/settings/settings/README.md:64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/README.md#L64)）
- 记载三条写入路径的语义：`update` 深合并、`replace` 整段替换（`replace({})` 重新继承）、`mutate` 按路径编辑（[packages/settings/settings/README.md:68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/README.md#L68)）
- 记载写入拒绝非 JSON 数据、拒绝只读提供者，并支持 `expectedRevision` 冲突拒绝（[packages/settings/settings/README.md:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/README.md#L70)）
- 记载 `describe()` 的返回内容以及线上表面必须传 `redactSecrets: true` 才剥离 `role('secret')` 字段（[packages/settings/settings/README.md:74](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/README.md#L74)）
- 记载两个事件的触发条件与失败处理，以及非法存储段在重载时保留上次好值、在注册时拒绝注册（[packages/settings/settings/README.md:78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/README.md#L78)）
- 记载脱敏走查器的已知缺口：只经 union/intersection/transform 才可达的秘密字段会原样返回且 `secrets` 为空（[packages/settings/settings/README.md:152](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/README.md#L152)）

### packages/settings/settings/package.json

该包的 npm 清单，声明入口、导出子路径与依赖关系。

- `exports` 暴露包根、`./invariant`、`./types` 与 `./src/*` 四类解析入口（[packages/settings/settings/package.json:16-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/package.json#L16-L31)）
- `files` 把 `lib/types/**/*.js` 一并纳入发布，使 `./types` 子路径在安装后可运行解析（[packages/settings/settings/package.json:32-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/package.json#L32-L37)）

### packages/settings/settings/src/index.ts

用户设置能力的服务定义：命名空间品牌化、注册、分层解析、写入队列、描述与脱敏、提交事件，以及消费者接线助手。

- `settingsNamespace` 用正则强制命名空间为小写 kebab-case，不匹配即抛 `TypeError`（[packages/settings/settings/src/index.ts:26-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L26-L31)）
- 把 `settings` 声明合并进 Cordis `Context`，使 `ctx.settings` 成为可注入服务属性（[packages/settings/settings/src/index.ts:131-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L131-L135)）
- `deepEqualJson` 定义整个服务唯一的变更判定谓词，数组按长度与逐项比较、对象按键集合与逐键比较（[packages/settings/settings/src/index.ts:145-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L145-L157)）
- `SettingsConflictError` 携带 `code = 'SETTINGS_CONFLICT'` 与期望/实际修订号，供线层映射（[packages/settings/settings/src/index.ts:164-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L164-L183)）
- `applyPathOp` 定义路径编辑语义：空路径寻址段根、`unset` 穿过缺失路径为无操作、`set` 沿途创建中间对象（[packages/settings/settings/src/index.ts:205-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L205-L228)）
- `cloneJsonShaped` 在一次遍历中脱离并校验写入输入：拒绝非有限数、循环引用与非 JSON 值，跳过对象中的 `undefined` 条目（[packages/settings/settings/src/index.ts:253-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L253-L288)）
- `mergeLayers` 定义层叠规则：普通对象递归合并，数组与其他值整体覆盖下层（[packages/settings/settings/src/index.ts:297-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L297-L305)）
- `deepFreeze` 递归冻结已解析值，使交出去的快照不可变（[packages/settings/settings/src/index.ts:308-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L308-L312)）
- `Service.init` 先注册拆卸器再加载并发布文档，使服务变为可注入前已有文档（[packages/settings/settings/src/index.ts:376-386](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L376-L386)）
- 拆卸器置 `stopped` 拒绝新写入与新观察者启动，并等待所有写入链与已启动观察者调用结算（[packages/settings/settings/src/index.ts:381-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L381-L384)）
- `documentPath` 与 `prepareDocument` 给出提供者本地文档路径的默认实现（非文件存储返回 undefined）（[packages/settings/settings/src/index.ts:398-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L398-L410)）
- `register` 对重复命名空间抛错（[packages/settings/settings/src/index.ts:436-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L436-L438)）
- 注册时立即解析并深冻结初值，若存储段不合法则注册本身失败（[packages/settings/settings/src/index.ts:447](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L447)）
- 注册体作为 `ctx.effect` 挂在调用方 fiber 上，fiber 释放时从表中删除该命名空间（[packages/settings/settings/src/index.ts:451-456](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L451-L456)）
- 返回的 scope 中 `watch` 的 disposer 同时置 `active = false` 并从集合移除，使已排队未启动的调用被跳过（[packages/settings/settings/src/index.ts:459-466](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L459-L466)）
- `describe` 逐命名空间产出序列化 schema、当前值、修订号、脱离的 `base` 与 `user` 层与生效时机；读取畸形段时按「无用户层」处理以保持全函数性（[packages/settings/settings/src/index.ts:479-500](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L479-L500)）
- `redactSecrets: true` 时对 `value`/`base`/`user` 三层分别脱敏并附上 `secrets` 位置清单（[packages/settings/settings/src/index.ts:501-510](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L501-L510)）
- `get` 返回已注册命名空间的解析值，未注册返回 `undefined`（[packages/settings/settings/src/index.ts:519-521](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L519-L521)）
- `mutate` 在入队前逐项校验 ops 为 `{op:'set'|'unset', path}` 且 path 为字符串数组（[packages/settings/settings/src/index.ts:564-575](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L564-L575)）
- `write` 在入队前拒绝未注册命名空间、已释放服务与只读提供者（[packages/settings/settings/src/index.ts:585-594](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L585-L594)）
- 在调用时刻对输入做 JSON 形状快照，使排队期间调用方继续改动原对象不影响写入（[packages/settings/settings/src/index.ts:607-608](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L607-L608)）
- 每个命名空间一条串行写入链，且用 `previous.catch` 越过失败的前驱，使一次拒绝不毒化整条队列（[packages/settings/settings/src/index.ts:609-612](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L609-L612)）
- 队首再次检查服务是否已释放、注册体是否已被替换（[packages/settings/settings/src/index.ts:613-618](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L613-L618)）
- 在队首读取当前段并在此处比对 `expectedRevision`，不符即抛 `SettingsConflictError`（[packages/settings/settings/src/index.ts:621-627](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L621-L627)）
- 按模式产出下一段（合并/替换/路径归约），解析校验后再 `persist`，持久化成功才更新内存文档（[packages/settings/settings/src/index.ts:628-638](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L628-L638)）
- 仅当该注册体仍是当前所有者且服务未停止，才推进修订号并提交通知（[packages/settings/settings/src/index.ts:641-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L641-L644)）
- `publish` 先记录换文档前每个命名空间的原始段，再替换文档（[packages/settings/settings/src/index.ts:657-671](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L657-L671)）
- 逐命名空间重解析；某段无效时告警并保留上次好值，其余命名空间照常提交（[packages/settings/settings/src/index.ts:672-683](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L672-L683)）
- `section` 对非普通对象的存储段抛 `TypeError`（[packages/settings/settings/src/index.ts:687-694](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L687-L694)）
- `resolve` 用 schema 调用把合并候选值准入为 `T`，再在准入后的值上跑所有者自定义 `validate`（[packages/settings/settings/src/index.ts:697-710](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L697-L710)）
- `bumpRevision` 只按原始段是否变化推进修订号并发 `settings/document-updated`，与解析值是否变化无关（[packages/settings/settings/src/index.ts:719-723](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L719-L723)）
- `emitDocumentUpdated` 逐监听器派发、容纳同步抛出与异步拒绝，唯独 `INVARIANT` 码的失败在全部监听器跑完后重抛（[packages/settings/settings/src/index.ts:726-746](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L726-L746)）
- `commit` 在解析值深相等时直接返回，不换值也不发事件（[packages/settings/settings/src/index.ts:749-752](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L749-L752)）
- 每个观察者各自串行排队，启动前复查 `active` 与服务停止状态，失败进入统一告警处理（[packages/settings/settings/src/index.ts:753-771](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L753-L771)）
- `settings/updated` 同样逐监听器派发并容纳失败，`INVARIANT` 码失败在全部监听器跑完后重抛（[packages/settings/settings/src/index.ts:777-798](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L777-L798)）
- `isUnloading` 用 fiber 状态数值判断消费者自身是否正在卸载（[packages/settings/settings/src/index.ts:819-826](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L819-L826)）
- `installSettingsSection` 在 `ctx.inject(['settings'])` 作用域内以消费者组合入口为 `base` 注册命名空间，并把源指针指向已解析 scope（[packages/settings/settings/src/index.ts:870-875](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L870-L875)）
- 设置服务消失时的 disposer 把源回退到组合入口并通知重判；消费者自身卸载时跳过这两步（[packages/settings/settings/src/index.ts:876-886](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L876-L886)）
- 已注册后的 `watch` 回调在消费者卸载中同样跳过 `onChange`（[packages/settings/settings/src/index.ts:888-895](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/index.ts#L888-L895)）

### packages/settings/settings/src/invariant.ts

该包的不变式伴随插件，安装 `settings/updated` 的提交事件检查。

- 监听 `settings/updated`，服务不存在时判失败（[packages/settings/settings/src/invariant.ts:24-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/invariant.ts#L24-L28)）
- 命名空间已注销、事件值与权威解析值不等、或 next 与 prev 深相等时分别判失败（[packages/settings/settings/src/invariant.ts:29-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/invariant.ts#L29-L38)）
- `apply` 把该安装器注册到 `ctx.invariants` 上并返回 disposer（[packages/settings/settings/src/invariant.ts:47-48](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/invariant.ts#L47-L48)）

### packages/settings/settings/src/redact.ts

秘密字段脱敏走查器：按 schema 剥离 `role('secret')` 字段并记录其位置，供 `describe` 的线上表面调用。

- 遇到 `meta.role === 'secret'` 的节点即记录路径与是否有值，并返回 `undefined` 使该字段从输出中消失（[packages/settings/settings/src/redact.ts:52-55](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/redact.ts#L52-L55)）
- `object` 分支保留 schema 未声明的多余键，并对每个声明属性递归走查（即便值缺席也枚举其秘密槽位）（[packages/settings/settings/src/redact.ts:57-72](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/redact.ts#L57-L72)）
- `dict` 与 `array` 分支按实际存在的条目递归，路径带上具体键名或下标（[packages/settings/settings/src/redact.ts:73-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/redact.ts#L73-L85)）
- 其他节点类型走 default 分支原样返回该值，不记录任何秘密位置（[packages/settings/settings/src/redact.ts:86-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/redact.ts#L86-L91)）
- `redactSecrets` 从根开始走查，返回脱离后的值与有序的秘密位置清单，不修改输入（[packages/settings/settings/src/redact.ts:105-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/redact.ts#L105-L109)）

### packages/settings/settings/src/types.ts

该 seam 的客户端可用类型面，只含类型与 Cordis 事件声明。

- 通过声明合并把 `settings/updated` 加入 Cordis `Events`，确立该事件的参数签名与 `emit` 模式（[packages/settings/settings/src/types.ts:75-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/types.ts#L75-L92)）
- 同样声明 `settings/document-updated`，确立其命名空间与修订号两个参数（[packages/settings/settings/src/types.ts:94-105](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/src/types.ts#L94-L105)）

### packages/settings/settings/tsconfig.json

该包的 TypeScript 编译配置。

- 无运行期机制

### packages/settings/settings/tsdown.config.ts

该包的打包配置，声明如何从编译产物生成运行时 bundle。

- 定义两个独立的 ESM bundle 入口（包根与 invariant 伴随插件），输出到 `lib` 且不清空目录（[packages/settings/settings/tsdown.config.ts:4-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/settings/settings/tsdown.config.ts#L4-L25)）
