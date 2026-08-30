---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/feedback/message-feedback
---

# packages/feedback/message-feedback

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 7 个文件、43 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/feedback/message-feedback/README.md

包说明文档，介绍逐条消息评分与备注服务的配置、三个操作和失败码。

- 无运行期机制

### packages/feedback/message-feedback/package.json

包清单，声明服务包的入口、Typert 宿主/远端子路径导出与依赖。

- `main`/`types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/feedback/message-feedback/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/package.json#L14-L15)）
- `exports` 开放 `.`、`./invariant`、`./types`、`./typert`（宿主侧生成物）、`./remote`（远端客户端生成物）、`./src/*` 与 `./package.json`（[packages/feedback/message-feedback/package.json:16-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/package.json#L16-L39)）
- `files` 把运行期入口、invariant、types 下的 `.js`/`.d.ts` 及 typert 宿主与远端客户端产物纳入发布（[packages/feedback/message-feedback/package.json:40-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/package.json#L40-L49)）
- `dependencies` 打入 schemastery 与 `zod@^4.4.3`，运行期行为校验依赖它们（[packages/feedback/message-feedback/package.json:61-64](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/package.json#L61-L64)）

### packages/feedback/message-feedback/src/index.ts

服务类实现：配置校验、按会话串行的读-比-写、耐久性屏障与三个 `@Remote` 方法。

- `resolveMaxNoteBytes` 对非正安全整数的配置抛 `TypeError`，在构造期拒绝错误配置（[packages/feedback/message-feedback/src/index.ts:64-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L64-L71)）
- `snapshotItem` 复制并冻结返回项，`note` 为 undefined 时整个字段被省略（[packages/feedback/message-feedback/src/index.ts:74-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L74-L83)）
- `success`/`rejected` 把结果包成冻结的 `{ok:true,value}` 与 `{ok:false,error}` 两支（[packages/feedback/message-feedback/src/index.ts:91-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L91-L98)）
- `identityOf` 只取会话头的 `createdAt` 与 `cwd` 作为行身份，`sameIdentity` 用它判定存储行是否属于当前会话生命周期（[packages/feedback/message-feedback/src/index.ts:101-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L101-L111)）
- `sameHeaderIdentity` 以 `id`+`createdAt`+`cwd` 三者比较两次观察是否指向同一份持久化会话（[packages/feedback/message-feedback/src/index.ts:114-116](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L114-L116)）
- `rowSnapshot` 在写入存储前深复制并冻结整行（[packages/feedback/message-feedback/src/index.ts:119-129](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L119-L129)）
- `nextVersion` 用 `randomUUID()` 生成不透明版本令牌（[packages/feedback/message-feedback/src/index.ts:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L132-L134)）
- 服务类以 `static inject` 声明依赖 storageDomain、sessionPersistence、sessions（[packages/feedback/message-feedback/src/index.ts:151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L151)）
- `static Config` 用 schemastery 要求 `maxNoteBytes` 为步长 1、最小 1 的必填数字，Loader 期即校验（[packages/feedback/message-feedback/src/index.ts:154-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L154-L156)）
- 构造函数以 `messageFeedback` 名注册服务并固化已校验的 `maxNoteBytes`（[packages/feedback/message-feedback/src/index.ts:167-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L167-L170)）
- `Service.init` 打开 `message_feedback` 域，注册的销毁 effect 先关闭写入准入、等待所有在途操作尾链、再关闭域，最后取出 `sessions` 表（[packages/feedback/message-feedback/src/index.ts:173-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L173-L181)）
- `list` 先确认会话存在，再读取行；行身份与当前会话头不符时返回空列表而非旧数据（[packages/feedback/message-feedback/src/index.ts:189-196](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L189-L196)）
- `put` 在入队之前先校验备注，备注失败直接返回，不占用会话队列（[packages/feedback/message-feedback/src/index.ts:206-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L206-L209)）
- `put` 在写入前检查目标消息存在，否则返回 `target-not-found`（[packages/feedback/message-feedback/src/index.ts:212-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L212-L218)）
- `put` 先把目标日志推过耐久性屏障，再重新比对会话头身份与目标存在性，不一致则 `target-not-found`（[packages/feedback/message-feedback/src/index.ts:220-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L220-L228)）
- `put` 以 `ifVersion` 与现存项版本（不存在时为 `null`）严格比较，不符即返回携带当前项的 `version-conflict`（[packages/feedback/message-feedback/src/index.ts:236-238](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L236-L238)）
- 评分与备注均未变时 `put` 原样返回已存项，不换版本、不写盘（[packages/feedback/message-feedback/src/index.ts:239-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L239-L243)）
- 实质变更时铸新版本、保留原 `createdAt`、`updatedAt` 取 `max(now, 旧值)`，按下标替换或追加后整行写回（[packages/feedback/message-feedback/src/index.ts:245-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L245-L261)）
- `delete` 在项已不存在时直接返回 `{absent:true}` 成功，忽略传入版本（[packages/feedback/message-feedback/src/index.ts:281-284](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L281-L284)）
- `delete` 对存在项要求版本精确匹配，否则返回 `version-conflict`；匹配则过滤该项后整行写回（[packages/feedback/message-feedback/src/index.ts:285-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L285-L293)）
- `inspectSession` 先看活动会话，未命中则以持久化快照目录为存在权威并复查一次活动会话，均无则 `session-not-found`，否则走 `inspect`（[packages/feedback/message-feedback/src/index.ts:303-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L303-L312)）
- `hasFeedbackTarget` 只接受 `assistant/message` 且属于追加型 surface 事件、派生出的消息角色为 assistant 且 id 匹配的目标（[packages/feedback/message-feedback/src/index.ts:315-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L315-L321)）
- `ensureTargetDurable` 对活动且身份一致的会话调用 `sessions.flush`，无监听参与则抛错，随后一律从偏移 0 重读物理耐久前缀（[packages/feedback/message-feedback/src/index.ts:328-339](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L328-L339)）
- `resolveNote` 放行 undefined，纯空白返回 `note-blank`，UTF-8 字节数超限返回带上限与实际值的 `note-too-large`（[packages/feedback/message-feedback/src/index.ts:342-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L342-L350)）
- `versionConflict` 在冲突结果里回带当前项快照（或 `null`），使调用方无需再读一次（[packages/feedback/message-feedback/src/index.ts:353-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L353-L358)）
- `enqueue` 在准入关闭后直接拒绝提交，否则把操作接到该会话尾链上串行执行，并在尾链未被后来者替换时清理表项（[packages/feedback/message-feedback/src/index.ts:361-372](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L361-L372)）
- `requireTable` 在域尚未初始化时抛错而非返回空表（[packages/feedback/message-feedback/src/index.ts:375-380](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L375-L380)）
- 默认导出服务类，供 Loader 以服务插件形式挂载（[packages/feedback/message-feedback/src/index.ts:383](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/index.ts#L383)）

### packages/feedback/message-feedback/src/invariant.ts

包自带的不变量伴生插件，注册一个带 `messageFeedback` 依赖的空安装器。

- 以 `inject = ['invariants']` 等待服务，`apply` 用包名注册安装器（其自身 `inject: ['messageFeedback']`）并返回 disposer（[packages/feedback/message-feedback/src/invariant.ts:12-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/invariant.ts#L12-L26)）

### packages/feedback/message-feedback/src/spec.ts

存储域声明：域名、表与落盘行的 zod 校验规则。

- `nonNegativeSafeInteger` 把时间戳类字段限定为非负且不超过 `MAX_SAFE_INTEGER` 的整数（[packages/feedback/message-feedback/src/spec.ts:12](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/spec.ts#L12)）
- 评分只接受 `positive`/`negative` 两个字面量（[packages/feedback/message-feedback/src/spec.ts:15-18](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/spec.ts#L15-L18)）
- 版本字段必须是 UUID，并在解析时打上品牌（[packages/feedback/message-feedback/src/spec.ts:21-22](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/spec.ts#L21-L22)）
- 条目 schema 要求 `messageId` 非空、备注含非空白字符、`updatedAt` 不早于 `createdAt`（[packages/feedback/message-feedback/src/spec.ts:27-39](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/spec.ts#L27-L39)）
- 行身份 schema 固定为 `{createdAt, cwd?}`（[packages/feedback/message-feedback/src/spec.ts:42-45](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/spec.ts#L42-L45)）
- 行 schema 的 `superRefine` 逐项检出重复 `messageId` 与重复 `version` 并各自报错（[packages/feedback/message-feedback/src/spec.ts:54-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/spec.ts#L54-L78)）
- `defineDomain` 声明域名 `message_feedback`、版本 0，以及以行 schema 校验的 `sessions` 键值表（[packages/feedback/message-feedback/src/spec.ts:84-90](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/feedback/message-feedback/src/spec.ts#L84-L90)）

### packages/feedback/message-feedback/src/types.ts

只含类型的公共请求、取值与失败码词汇表，供生成的 Remote 客户端引用。

- 无运行期机制

### packages/feedback/message-feedback/tsconfig.json

TypeScript 编译配置，声明 rootDir/outDir 与工程引用。

- 无运行期机制
