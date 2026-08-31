---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/llm/llm-pi-ai
---

# packages/llm/llm-pi-ai

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 15 个文件、208 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/llm/llm-pi-ai/README.md

该包的英文说明文档，介绍这个基于 pi-ai 的多提供方适配插件如何配置路由、登录、发现模型与失败码；只有散文与 YAML 示例，不参与加载。

- 无运行期机制

### packages/llm/llm-pi-ai/package.json

该包的 npm 清单，决定这个插件包被 Node 与打包器以什么入口、什么模块格式、什么文件集合装载。

- `"type": "module"` 使包内 `.js` 按 ESM 解析（[packages/llm/llm-pi-ai/package.json:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/package.json#L13)）
- `main` / `types` 指向 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/llm/llm-pi-ai/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/package.json#L14-L15)）
- `exports` 只开放根入口、`./invariant`、`./src/*` 与 `./package.json` 四个可导入路径（[packages/llm/llm-pi-ai/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/package.json#L16-L27)）
- `files` 把发布内容限定为两个运行期产物与类型声明（[packages/llm/llm-pi-ai/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/package.json#L28-L32)）
- `dependencies` 把 `@earendil-works/pi-ai` 与 schemastery 声明为运行期必须安装的实现（[packages/llm/llm-pi-ai/package.json:46-49](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/package.json#L46-L49)）

### packages/llm/llm-pi-ai/src/adapter.ts

`PiAiAdapter` 类，实现 harness LLM 适配器接口，把一次请求落到 pi-ai 的 `Models` 集合上；由 `index.ts` 构造并注册到 `ctx.llm`。

- `profileOptions` 把 profile 的思考预算、缓存保留、传输方式、超时等字段翻译成 pi-ai 的公共流选项（[packages/llm/llm-pi-ai/src/adapter.ts:115-132](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L115-L132)）
- `off` 级别被转成不传 `reasoning` 选项（[packages/llm/llm-pi-ai/src/adapter.ts:120](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L120)）
- 每次调用固定把 SDK 的 `maxRetries` 设为 0（[packages/llm/llm-pi-ai/src/adapter.ts:130](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L130)）
- `describableReasoningLevel` 在描述模型时把模型不支持的配置级别降为无，而不抛错（[packages/llm/llm-pi-ai/src/adapter.ts:147-155](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L147-L155)）
- `resolveReasoningLevel` 在请求路径上对模型不支持的级别抛 `UNSUPPORTED_REASONING_EFFORT`（[packages/llm/llm-pi-ai/src/adapter.ts:158-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L158-L169)）
- `reasoningInfo` 对不推理的模型整体省略 `reasoning` 字段，其余模型列出各级别与默认级别（[packages/llm/llm-pi-ai/src/adapter.ts:187-202](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L187-L202)）
- `requestHeaders` 先剔除与归属头同名（忽略大小写）的部署头，再叠加归属头（[packages/llm/llm-pi-ai/src/adapter.ts:205-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L205-L212)）
- `current()` 以 profiles 对象同一性缓存快照，变化时用 `createModels` 重建集合并逐路由 `setProvider`（[packages/llm/llm-pi-ai/src/adapter.ts:232-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L232-L239)）
- `profileOf` 对本适配器不拥有的路由抛 `NO_ADAPTER`（[packages/llm/llm-pi-ai/src/adapter.ts:242-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L242-L248)）
- `modelOf` 对集合中不存在的模型抛 `UNKNOWN_MODEL`（[packages/llm/llm-pi-ai/src/adapter.ts:251-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L251-L258)）
- `providerInfo` 返回配置的 `displayName`，缺省回落到路由键（[packages/llm/llm-pi-ai/src/adapter.ts:260-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L260-L265)）
- `providerRetryPolicy` 从当前快照的 profile 交出该路由的重试策略（[packages/llm/llm-pi-ai/src/adapter.ts:267-269](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L267-L269)）
- `listModels` 从快照集合列出该路由的模型 id、名称与输入模态（[packages/llm/llm-pi-ai/src/adapter.ts:271-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L271-L282)）
- `resolveModel` 在一个微任务后基于当前快照产出模型描述（[packages/llm/llm-pi-ai/src/adapter.ts:284-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L284-L293)）
- `modelInfo` 只把 profile 显式配置过的 `maxTokens` 作为 `defaultMaxTokens` 报出，目录能力值不进入（[packages/llm/llm-pi-ai/src/adapter.ts:295-311](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L295-L311)）
- `prepareCall` 当场取一个快照，并把随后的 `stream` 绑死在这个快照上（[packages/llm/llm-pi-ai/src/adapter.ts:313-319](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L313-L319)）
- 直接 `stream()` 调用取当前快照（[packages/llm/llm-pi-ai/src/adapter.ts:321-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L321-L323)）
- 请求带 `stop` 时抛 `UNSUPPORTED_OPTION`（[packages/llm/llm-pi-ai/src/adapter.ts:329-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L329-L331)）
- 在第一次 await 之前定住 profile、模型描述与推理级别，然后解析凭证（[packages/llm/llm-pi-ai/src/adapter.ts:337-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L337-L343)）
- 自建 `AbortController` 与调用方信号合并，并挂上按 `streamIdleTimeoutMs` 计时的空闲看门狗（[packages/llm/llm-pi-ai/src/adapter.ts:345-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L345-L350)）
- 历史含图但模型不接受 image、或缺少附件服务时，抛 `UNSUPPORTED_CONTENT`（[packages/llm/llm-pi-ai/src/adapter.ts:353-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L353-L360)）
- 按是否有附件服务分别走同步文本转换或带图像预算的异步转换，并把 replay 降级回调透传下去（[packages/llm/llm-pi-ai/src/adapter.ts:361-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L361-L374)）
- 调 `streamSimple`，把 profile 选项、请求级 temperature/maxTokens/sessionId、看门狗信号与合成请求头一起交给 pi-ai（[packages/llm/llm-pi-ai/src/adapter.ts:375-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L375-L384)）
- 逐块拉取转换后的 chunk，每次读取后检查看门狗是否已超时并改抛超时（[packages/llm/llm-pi-ai/src/adapter.ts:385-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L385-L397)）
- 消费者提前停止时中止内部控制器并调用迭代器 `return` 收尾（[packages/llm/llm-pi-ai/src/adapter.ts:398-407](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L398-L407)）
- 出错时按看门狗超时映射 `TIMEOUT`、按调用方取消映射 `ABORTED`，否则原样上抛（[packages/llm/llm-pi-ai/src/adapter.ts:408-415](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L408-L415)）
- 无论何种结局都在 finally 中止内部控制器（[packages/llm/llm-pi-ai/src/adapter.ts:416-418](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/adapter.ts#L416-L418)）

### packages/llm/llm-pi-ai/src/auth.ts

pi-ai 的凭证存储与环境探询接口在 harness 凭证面上的实现，由 `index.ts` 构造一份交给每个 `createModels` 集合与登录流程。

- `RECORD_SCOPE` 固定所有记录写入的作用域名（[packages/llm/llm-pi-ai/src/auth.ts:29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L29)）
- `recordKeyFor` 把 pi-ai provider id 拼成作用域化的凭证键（[packages/llm/llm-pi-ai/src/auth.ts:36-38](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L36-L38)）
- `jsonImage` 递归丢弃显式 `undefined` 成员、把数组中的 `undefined` 转为 null，再交给存储校验（[packages/llm/llm-pi-ai/src/auth.ts:52-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L52-L62)）
- `toPiCredential` 把 api-key 记录逐字段重建、把 grant 记录的 payload 原样当作 pi-ai 凭证（[packages/llm/llm-pi-ai/src/auth.ts:74-84](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L74-L84)）
- `toRecord` 反向把 pi-ai 凭证写成 api-key 或 grant 两类记录（[packages/llm/llm-pi-ai/src/auth.ts:91-100](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L91-L100)）
- `writableStore` 在没有凭证服务时抛 `NO_CREDENTIAL_STORE`（[packages/llm/llm-pi-ai/src/auth.ts:112-122](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L112-L122)）
- 存储的 `read` 在无服务或 id 不合记录语法时答"未存储"（[packages/llm/llm-pi-ai/src/auth.ts:143-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L143-L148)）
- `list` 只报本作用域的记录，并把记录种类映射成 `api_key` / `oauth`（[packages/llm/llm-pi-ai/src/auth.ts:149-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L149-L162)）
- `modify` 对不合记录语法的 id 抛 `UNSTORABLE_PROVIDER_ID`，否则在 `modifyRecord` 的锁内跑 pi-ai 的变更回调（[packages/llm/llm-pi-ai/src/auth.ts:163-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L163-L177)）
- `delete` 对不合语法的 id 静默返回，否则删除对应记录（[packages/llm/llm-pi-ai/src/auth.ts:181-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L181-L184)）
- `env()` 先查凭证服务再回落到启动环境，且只对合法引用名查询凭证面（[packages/llm/llm-pi-ai/src/auth.ts:205-215](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L205-L215)）
- `fileExists()` 展开 `~` 后用宿主进程的 `access` 判断，任何失败都答不存在（[packages/llm/llm-pi-ai/src/auth.ts:216-229](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/auth.ts#L216-L229)）

### packages/llm/llm-pi-ai/src/catalog.ts

把一个路由的模型目录物化成 pi-ai `Model` 列表的模块，被 `config.ts` 的解析、`provider.ts` 的构建与 `discovery.ts` 的目录短路调用。

- `NO_COST` 给目录未描述的模型填零价（[packages/llm/llm-pi-ai/src/catalog.ts:37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L37)）
- 模态闸表导出 `MODALITIES`，界定 profile 可声明的模态取值（[packages/llm/llm-pi-ai/src/catalog.ts:47-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L47-L53)）
- `declaredInput` 把缺省与空列表一律读作"未作答"，交给下一层回落（[packages/llm/llm-pi-ai/src/catalog.ts:64-66](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L64-L66)）
- 思考级别闸表导出 `THINKING_LEVELS`，同时固定级别的升级顺序（[packages/llm/llm-pi-ai/src/catalog.ts:74-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L74-L85)）
- 思考格式闸表导出 `SUPPORTED_THINKING_FORMATS`，界定 `thinkingFormat` 可取值（[packages/llm/llm-pi-ai/src/catalog.ts:99-114](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L99-L114)）
- 输出上限字段闸表导出 `MAX_TOKENS_FIELDS`（[packages/llm/llm-pi-ai/src/catalog.ts:120-126](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L120-L126)）
- 缓存标记约定闸表导出 `CACHE_CONTROL_FORMATS`（[packages/llm/llm-pi-ai/src/catalog.ts:132-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L132-L137)）
- 模板占位符闸表导出 `CHAT_TEMPLATE_VARS`（[packages/llm/llm-pi-ai/src/catalog.ts:143-149](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L143-L149)）
- `catalogProviders` 把已安装目录提供方按 id 建索引并只构造一次（[packages/llm/llm-pi-ai/src/catalog.ts:159-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L159-L162)）
- `catalogProvider` 按路由键交出已安装提供方，未安装则为 undefined（[packages/llm/llm-pi-ai/src/catalog.ts:169-171](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L169-L171)）
- `catalogProviderIds` 列出安装目录里全部提供方路由（[packages/llm/llm-pi-ai/src/catalog.ts:177-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L177-L179)）
- `catalogModels` 对未安装路由返回空表，否则按模型 id 建索引（[packages/llm/llm-pi-ai/src/catalog.ts:186-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L186-L190)）
- 四张 compat 闸表逐字段标记 `offer` / `withhold`，决定哪些开关可被配置（[packages/llm/llm-pi-ai/src/catalog.ts:217-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L217-L272)）
- `COMPAT_GATES` 把三种 Responses 协议共用同一张 Responses 闸表（[packages/llm/llm-pi-ai/src/catalog.ts:292-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L292-L299)）
- `compatGate` 以字符串查表，未列协议得到 undefined 即不接受任何 compat（[packages/llm/llm-pi-ai/src/catalog.ts:308-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L308-L310)）
- `configuredCompatEntries` 把空对象值视作未配置而滤掉（[packages/llm/llm-pi-ai/src/catalog.ts:459-465](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L459-L465)）
- `compatProtocols` 列出提供某个 compat 字段的协议集合（[packages/llm/llm-pi-ai/src/catalog.ts:473-475](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L473-L475)）
- `offeredCompatFields` 列出某协议开放的字段，用于诊断（[packages/llm/llm-pi-ai/src/catalog.ts:483-485](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L483-L485)）
- `allOfferedCompatFields` 跨协议去重汇总全部可配置字段名（[packages/llm/llm-pi-ai/src/catalog.ts:494-500](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L494-L500)）
- `assertOfferedCompatFields` 在协议解析前拒绝被 withhold 或无协议声明的 compat 键，并分两种措辞报错（[packages/llm/llm-pi-ai/src/catalog.ts:512-534](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L512-L534)）
- 同一检查还拒绝写了键却没给值的 compat 项（[packages/llm/llm-pi-ai/src/catalog.ts:541-544](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L541-L544)）
- `invalid` 把所有路由级失败统一成带路由名的 Error 抛出（[packages/llm/llm-pi-ai/src/catalog.ts:619-621](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L619-L621)）
- `sharedCatalogApi` 只在目录模型协议一致时给出路由级协议默认（[packages/llm/llm-pi-ai/src/catalog.ts:631-635](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L631-L635)）
- `resolveModelReasoning` 在未声明 efforts 时沿用目录条目的推理能力（[packages/llm/llm-pi-ai/src/catalog.ts:662-674](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L662-L674)）
- `reasoningEfforts: false` 直接把模型标为不推理（[packages/llm/llm-pi-ai/src/catalog.ts:679](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L679)）
- 空的 efforts（null 或 `{}`）被拒绝而非当作继承或禁用（[packages/llm/llm-pi-ai/src/catalog.ts:684-687](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L684-L687)）
- 除 `off` 外的级别必须给出非空线路值，否则拒绝（[packages/llm/llm-pi-ai/src/catalog.ts:688-701](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L688-L701)）
- 只声明 `off` 而无任何思考级别的配置被拒绝（[packages/llm/llm-pi-ai/src/catalog.ts:702-705](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L702-L705)）
- 生成 `thinkingLevelMap` 时把未声明级别一律钉成 null，声明 `off` 但无值的级别留空（[packages/llm/llm-pi-ai/src/catalog.ts:706-715](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L706-L715)）
- `resolveModelCompat` 让路由级开关先落、模型级开关逐字段覆盖（[packages/llm/llm-pi-ai/src/catalog.ts:746-760](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L746-L760)）
- 模型级开关其协议不接受时直接拒绝，路由级开关则跳过该模型（[packages/llm/llm-pi-ai/src/catalog.ts:752-758](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L752-L758)）
- 只有解析后协议与目录条目自身协议相同时才继承目录 compat（[packages/llm/llm-pi-ai/src/catalog.ts:761-769](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L761-L769)）
- `resolveRouteModels` 取该路由的安装目录与提供方 baseUrl 作为底（[packages/llm/llm-pi-ai/src/catalog.ts:797-805](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L797-L805)）
- `modelOverrides` 的空 id、无目录路由、与 `models` 并存、命中不存在的模型、条目自带 `id` 五种情况都被拒绝（[packages/llm/llm-pi-ai/src/catalog.ts:808-827](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L808-L827)）
- 有 `models` 列表时整体替换目录，否则把每个目录模型套上同 id 的 override（[packages/llm/llm-pi-ai/src/catalog.ts:831-833](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L831-L833)）
- 一个模型都解析不出的路由被拒绝（[packages/llm/llm-pi-ai/src/catalog.ts:834-837](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L834-L837)）
- 在解析协议之前先对路由级与每个模型级 compat 做词表检查（[packages/llm/llm-pi-ai/src/catalog.ts:842-845](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L842-L845)）
- 空模型 id 与重复模型 id 被拒绝（[packages/llm/llm-pi-ai/src/catalog.ts:849-851](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L849-L851)）
- 每个模型的协议按"路由 api → 目录条目 api → 目录共识 api"三级取值，都缺时拒绝（[packages/llm/llm-pi-ai/src/catalog.ts:852-857](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L852-L857)）
- baseUrl 按"路由 → 目录条目 → 目录提供方"三级取值，都缺时拒绝（[packages/llm/llm-pi-ai/src/catalog.ts:858-861](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L858-L861)）
- 上下文窗口与输出上限按"条目 → 目录 → 路由默认"取值并校验为正整数（[packages/llm/llm-pi-ai/src/catalog.ts:866-873](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L866-L873)）
- 只有条目显式写的 `maxTokens` 才进入 `configuredMaxTokens`（[packages/llm/llm-pi-ai/src/catalog.ts:876](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L876)）
- 物化模型采用"展开目录条目再逐字段覆盖"，未建模的目录字段随之保留（[packages/llm/llm-pi-ai/src/catalog.ts:877-895](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L877-L895)）
- 最后逐字段拒绝路由上无任何模型能读到的 compat 默认（[packages/llm/llm-pi-ai/src/catalog.ts:901-906](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/catalog.ts#L901-L906)）

### packages/llm/llm-pi-ai/src/config.ts

插件的配置 schema 与 profile 解析，既是 `cordis.yml` 配置形状，也是用户设置分节的校验器与解析出口。

- 定义空闲超时、图像字节与像素预算、上下文与输出上限、默认模态六个默认常量（[packages/llm/llm-pi-ai/src/config.ts:43-76](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L43-L76)）
- `chatTemplateKwarg` 允许标量、null 与 `$var` 占位对象三类值（[packages/llm/llm-pi-ai/src/config.ts:238-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L238-L247)）
- `compatProfile` 枚举了配置面接受的全部 compat 开关及其取值域（[packages/llm/llm-pi-ai/src/config.ts:249-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L249-L273)）
- `reasoningEfforts` 以思考级别为键、字符串或 null 为值（[packages/llm/llm-pi-ai/src/config.ts:285-288](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L285-L288)）
- `modelFields` 让 `models` 条目与 `modelOverrides` 值共用同一组字段，`reasoningEfforts` 用联合以保留"缺省"含义（[packages/llm/llm-pi-ai/src/config.ts:291-312](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L291-L312)）
- 路由 profile schema 把 `api` 限制在 `supportedProtocols()` 内（[packages/llm/llm-pi-ai/src/config.ts:317](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L317)）
- 路由 profile schema 为容量、模态、超时与三个图像预算字段带上默认值与取值范围（[packages/llm/llm-pi-ai/src/config.ts:322-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L322-L336)）
- `Config` 把 `providers` 定义为字典并默认为空（[packages/llm/llm-pi-ai/src/config.ts:340-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L340-L342)）
- `assertServiceable` 用整套解析当作设置写入时的校验（[packages/llm/llm-pi-ai/src/config.ts:356-358](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L356-L358)）
- `rejectRemovedFields` 对已移除的 `provider`、`maxRetries`、`maxRetryDelayMs` 报错并指出替代（[packages/llm/llm-pi-ai/src/config.ts:361-376](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L361-L376)）
- `resolveProfiles` 拒绝把 `providers` 写成数组的旧形状（[packages/llm/llm-pi-ai/src/config.ts:389-391](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L389-L391)）
- 空路由名、空 `baseURL`、空 `displayName` 逐一被拒绝（[packages/llm/llm-pi-ai/src/config.ts:396-402](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L396-L402)）
- 空闲超时须为正有限且不超过定时器上限（[packages/llm/llm-pi-ai/src/config.ts:403-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L403-L410)）
- 三个图像预算字段各自补默认并校验为正整数（[packages/llm/llm-pi-ai/src/config.ts:411-422](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L411-L422)）
- `defaultInput` 复制成可变数组并拒绝空列表（[packages/llm/llm-pi-ai/src/config.ts:428-431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L428-L431)）
- `displayName` 缺省取路由键而非安装提供方自身名字（[packages/llm/llm-pi-ai/src/config.ts:435](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L435)）
- 调 `resolveRouteModels` 物化该路由的模型与显式输出上限（[packages/llm/llm-pi-ai/src/config.ts:436-446](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L436-L446)）
- 解析结果把 `apiKeyEnv` 转成凭证引用、重试策略解析定型、headers 与思考预算做副本（[packages/llm/llm-pi-ai/src/config.ts:447-460](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L447-L460)）
- 每个路由在解析期就构建出 pi-ai `Provider`，并把"是否声明了凭证"传给构建（[packages/llm/llm-pi-ai/src/config.ts:461-468](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/config.ts#L461-L468)）

### packages/llm/llm-pi-ai/src/context.ts

把 harness 的请求历史翻译成 pi-ai `Context` 的模块，含图像请求版本准备与超限卸载；由 `adapter.ts` 在每次流式请求前调用。

- `flattenText` 把一条消息的文本块拼成单串（[packages/llm/llm-pi-ai/src/context.ts:21-26](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L21-L26)）
- `toolResultText` 递归展平工具结果中的文本（[packages/llm/llm-pi-ai/src/context.ts:30-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L30-L34)）
- `assertSupportedImageRoles` 对非 user 角色中的图像抛 `UNSUPPORTED_CONTENT`（[packages/llm/llm-pi-ai/src/context.ts:37-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L37-L46)）
- `userContent` 丢弃空文本块，图像先插入句柄描述文本再插入 base64 图像块（[packages/llm/llm-pi-ai/src/context.ts:53-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L53-L71)）
- 嵌套工具结果被递归展开进同一内容序列，其它块类型被忽略（[packages/llm/llm-pi-ai/src/context.ts:72-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L72-L86)）
- 全为文本的内容被收敛成一个字符串（[packages/llm/llm-pi-ai/src/context.ts:87-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L87-L88)）
- `collectImageRefs` 按附件 id 去重收集全历史（含工具结果内）的图像引用（[packages/llm/llm-pi-ai/src/context.ts:91-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L91-L99)）
- `prepareRequestImages` 并发按策略读出每个附件的请求版本并按 id 建表（[packages/llm/llm-pi-ai/src/context.ts:101-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L101-L118)）
- `toolsOf` 把 harness 工具名、描述与 JSON Schema 参数直接搬进 pi-ai 工具声明（[packages/llm/llm-pi-ai/src/context.ts:120-128](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L120-L128)）
- `piContext` 把 `options.system` 放进 pi-ai 唯一的 `systemPrompt` 槽，工具为空时整体省略 `tools`（[packages/llm/llm-pi-ai/src/context.ts:131-138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L131-L138)）
- 纯文本路径遇到图像内容时抛 `UNSUPPORTED_CONTENT`（[packages/llm/llm-pi-ai/src/context.ts:143-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L143-L146)）
- 历史中的 system 消息被折成 user 消息以保序（[packages/llm/llm-pi-ai/src/context.ts:147-150](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L147-L150)）
- assistant 消息经 `toPiAssistant` 还原，并顺带记录每个工具调用 id 对应的工具名（[packages/llm/llm-pi-ai/src/context.ts:151-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L151-L157)）
- 每个工具结果单独成一条 `toolResult` 消息，工具名从前面的调用回填、缺失时用 `unknown`，空输出写作 `(no output)`（[packages/llm/llm-pi-ai/src/context.ts:158-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L158-L172)）
- `toPiContext` 按是否传入图像上下文分派同步或异步转换（[packages/llm/llm-pi-ai/src/context.ts:218-226](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L218-L226)）
- 图像路径先用"引用字节与策略上限取小"的估算做一轮超限卸载，被卸载的图像换成占位文本（[packages/llm/llm-pi-ai/src/context.ts:239-245](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L239-L245)）
- 读出实际请求版本后再用真实字节数做第二轮卸载（[packages/llm/llm-pi-ai/src/context.ts:246-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L246-L253)）
- 图像路径的 user 消息把非工具结果块与各工具结果分别转换成消息（[packages/llm/llm-pi-ai/src/context.ts:273-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/context.ts#L273-L294)）

### packages/llm/llm-pi-ai/src/discovery.ts

回答"这个提供方能服务哪些模型"的模块，由 `index.ts` 注册到 `ctx.llm.registerModelDiscovery` 供配置界面调用。

- `LISTABLE_PROTOCOLS` 只允许两种 OpenAI 兼容协议被联网询问（[packages/llm/llm-pi-ai/src/discovery.ts:38-41](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L38-L41)）
- `MAX_RESPONSE_BYTES` 把回复体上限定在 4MiB（[packages/llm/llm-pi-ai/src/discovery.ts:50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L50)）
- `capacity` 只接受正整数候选值（[packages/llm/llm-pi-ai/src/discovery.ts:65-70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L65-L70)）
- `label` 只接受非空字符串候选值（[packages/llm/llm-pi-ai/src/discovery.ts:73-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L73-L78)）
- `listingUrl` 把 baseURL 当前缀拼 `/models`，保留部署路径段（[packages/llm/llm-pi-ai/src/discovery.ts:86-88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L86-L88)）
- `readBounded` 先按声明长度拒绝超限并取消响应体，再按累计读取字节强制上限（[packages/llm/llm-pi-ai/src/discovery.ts:96-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L96-L131)）
- `readListing` 在缺少 `data` 数组时抛 `DISCOVERY_FAILED`，并跳过无可用 id 的条目（[packages/llm/llm-pi-ai/src/discovery.ts:138-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L138-L162)）
- `usableProbeKey` 在拼请求头前拒绝空或含非法字符的探测密钥（[packages/llm/llm-pi-ai/src/discovery.ts:172-181](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L172-L181)）
- 已安装目录的路由直接由目录作答，完全不发网络请求（[packages/llm/llm-pi-ai/src/discovery.ts:201-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L201-L211)）
- 无目录又无 baseURL 时抛 `DISCOVERY_FAILED`（[packages/llm/llm-pi-ai/src/discovery.ts:212-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L212-L218)）
- 草稿未选协议时按 `openai-completions` 询问，不在可列表协议内则抛 `DISCOVERY_UNSUPPORTED`（[packages/llm/llm-pi-ai/src/discovery.ts:225-231](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L225-L231)）
- 表单中现填的密钥优先于已存储密钥，两者都没有就发起未认证探测（[packages/llm/llm-pi-ai/src/discovery.ts:240-241](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L240-L241)）
- 发起带 accept、可选 Bearer 与归属头的 GET，并透传取消信号（[packages/llm/llm-pi-ai/src/discovery.ts:242-252](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L242-L252)）
- 请求异常时按调用方是否已取消分别映射 `ABORTED` 与 `DISCOVERY_FAILED`（[packages/llm/llm-pi-ai/src/discovery.ts:253-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L253-L258)）
- 非 2xx 回复带状态码报错，401/403 额外提示检查密钥（[packages/llm/llm-pi-ai/src/discovery.ts:259-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L259-L264)）
- 读体期间被取消同样映射为 `ABORTED`，JSON 解析失败映射为 `DISCOVERY_FAILED`（[packages/llm/llm-pi-ai/src/discovery.ts:265-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/discovery.ts#L265-L283)）

### packages/llm/llm-pi-ai/src/index.ts

插件入口，导出 `name` / `inject` / `Config` / `apply`，负责 profile 解析、适配器注册、可配置提供方目录、模型发现与设置分节接线。

- 插件名与注入声明决定它以 `llm-pi-ai` 之名挂载并依赖 `llm` 服务（[packages/llm/llm-pi-ai/src/index.ts:88-89](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L88-L89)）
- `NS` 固定该插件读写的设置命名空间（[packages/llm/llm-pi-ai/src/index.ts:91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L91)）
- `registrationFacts` 只取路由名、显示名与重试策略并按路由排序，作为"是否需要重新注册"的判据（[packages/llm/llm-pi-ai/src/index.ts:98-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L98-L109)）
- `directoryEntries` 把全部安装目录路由与当前 profile 路由并成一张目录，并给每项标注 `declared`（[packages/llm/llm-pi-ai/src/index.ts:119-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L119-L139)）
- `profiles()` 以原始配置对象同一性记忆解析结果，并在 apply 中先跑一次（[packages/llm/llm-pi-ai/src/index.ts:157-165](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L157-L165)）
- `resolveApiKey` 对未声明凭证的路由返回 undefined，让 pi-ai 走自身环境发现（[packages/llm/llm-pi-ai/src/index.ts:171-177](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L171-L177)）
- 有凭证服务时走服务解析，无服务时退回启动环境变量（[packages/llm/llm-pi-ai/src/index.ts:178-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L178-L183)）
- 声明了引用却解析不到值时抛 `MISSING_CREDENTIAL`（[packages/llm/llm-pi-ai/src/index.ts:184-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L184-L189)）
- 整个插件实例共用一份凭证存储与环境上下文，跨配置重建保持不变（[packages/llm/llm-pi-ai/src/index.ts:195](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L195)）
- 构造适配器时接上附件服务解析与图像访问路径桥接（`ctx.fs` 的宿主路径映射）（[packages/llm/llm-pi-ai/src/index.ts:196-205](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L196-L205)）
- replay 状态不可用时以 warn 记录路由与模型（[packages/llm/llm-pi-ai/src/index.ts:206-211](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L206-L211)）
- 登录流程通过 `ctx.inject(['authorization'])` 按需注册，与路由集合无关（[packages/llm/llm-pi-ai/src/index.ts:218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L218)）
- `ensureDirectory` 在目录内容变化时首次注册或原子替换，并记住已生效的目录内容（[packages/llm/llm-pi-ai/src/index.ts:225-240](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L225-L240)）
- `storedApiKey` 只为已配置的路由补出凭证，未知路由或无 profile 时返回 undefined（[packages/llm/llm-pi-ai/src/index.ts:248-253](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L248-L253)）
- 按命名空间注册模型发现，把取消信号与已存凭证取值函数一并传入（[packages/llm/llm-pi-ai/src/index.ts:260-263](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L260-L263)）
- 零路由时不注册适配器（休眠态），有路由时首次注册或原子替换路由集合（[packages/llm/llm-pi-ai/src/index.ts:270-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L270-L292)）
- `installSettingsSection` 把 `assertServiceable` 装成命名空间校验器，并接管配置来源（[packages/llm/llm-pi-ai/src/index.ts:295-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L295-L303)）
- 设置变更时先重算注册事实，失败则记录错误并保留原有路由继续服务（[packages/llm/llm-pi-ai/src/index.ts:304-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L304-L315)）
- 随后刷新目录，失败同样被就地捕获并保留上一份目录（[packages/llm/llm-pi-ai/src/index.ts:316-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/index.ts#L316-L327)）

### packages/llm/llm-pi-ai/src/invariant.ts

该包的 invariant 伴生插件，向 `invariants` 服务登记包归属并声明没有可检查的运行期关系。

- 声明伴生插件名并注入 `invariants` 服务（[packages/llm/llm-pi-ai/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/invariant.ts#L13-L15)）
- `apply` 以包名注册一个空安装器并返回其 disposer（[packages/llm/llm-pi-ai/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/invariant.ts#L21-L29)）

### packages/llm/llm-pi-ai/src/login.ts

把 pi-ai 的登录会话翻译成 harness 授权 seam 的模块，由 `index.ts` 在 `authorization` 服务存在时调用。

- `loginMethods` 只列出 pi-ai 能真正跑起来的方法：oauth 总是可用，api-key 需其提供交互式 login（[packages/llm/llm-pi-ai/src/login.ts:29-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/login.ts#L29-L36)）
- `relay` 把 info / auth_url / device_code / progress 事件转成带 url、code 的中性通知（[packages/llm/llm-pi-ai/src/login.ts:47-69](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/login.ts#L47-L69)）
- 未知事件类型仍发一条"正在登录"的通知而不静默（[packages/llm/llm-pi-ai/src/login.ts:70-75](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/login.ts#L70-L75)）
- `restate` 把 pi-ai 的 select / secret / 其它提问转成中性提问并透传其自身取消信号（[packages/llm/llm-pi-ai/src/login.ts:89-109](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/login.ts#L89-L109)）
- 对每个安装目录提供方逐一尝试注册流程，没有可用方法的跳过（[packages/llm/llm-pi-ai/src/login.ts:121-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/login.ts#L121-L127)）
- 提供方 id 不合凭证记录语法时记 warn 并不提供其登录（[packages/llm/llm-pi-ai/src/login.ts:132-137](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/login.ts#L132-L137)）
- 以记录键、提供方名与方法列表注册授权流程（[packages/llm/llm-pi-ai/src/login.ts:138-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/login.ts#L138-L141)）
- 登录时另建一个只含该提供方的集合，凭证仍落进共享存储（[packages/llm/llm-pi-ai/src/login.ts:142-148](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/login.ts#L142-L148)）
- 会话选定的方法被映射成 pi-ai 的 `oauth` / `api_key`，并带会话信号、通知与提问回调发起 `models.login`（[packages/llm/llm-pi-ai/src/login.ts:149-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/login.ts#L149-L157)）

### packages/llm/llm-pi-ai/src/provider.ts

为一个解析后的路由构建 pi-ai `Provider` 的模块，由 `config.ts` 在解析期调用，其协议表也被配置 schema 用作 `api` 的取值域。

- `PROTOCOLS` 把可被手工声明的路由限定在三个协议及其懒加载实现上（[packages/llm/llm-pi-ai/src/provider.ts:47-51](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/provider.ts#L47-L51)）
- `supportedProtocols` 按表顺序交出协议名，第一项即配置界面的默认（[packages/llm/llm-pi-ai/src/provider.ts:61-63](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/provider.ts#L61-L63)）
- `harnessApiKeyAuth` 的 `resolve` 在没有 key 时返回空 auth，把"是否必须有密钥"留给协议实现（[packages/llm/llm-pi-ai/src/provider.ts:77-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/provider.ts#L77-L85)）
- `routeAuth` 对无目录路由用 harness 自己的 api-key 方法；目录路由保留其原有 auth，仅在其没有 api-key 方法且 profile 声明了凭证时补上一个（[packages/llm/llm-pi-ai/src/provider.ts:131-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/provider.ts#L131-L135)）
- `reuseCatalogProvider` 换掉 id、名称、baseUrl、auth 与模型列表，`stream` / `streamSimple` 委派回目录提供方本体（[packages/llm/llm-pi-ai/src/provider.ts:144-159](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/provider.ts#L144-L159)）
- `buildProvider` 在"目录有该路由且未覆盖协议"时复用目录提供方（[packages/llm/llm-pi-ai/src/provider.ts:167-172](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/provider.ts#L167-L172)）
- 其余路由必须命中协议表，否则抛出列明支持协议的错误（[packages/llm/llm-pi-ai/src/provider.ts:177-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/provider.ts#L177-L183)）
- 命中的路由用 `createProvider` 以路由 id、显示名、baseUrl、auth、模型与协议实现构建（[packages/llm/llm-pi-ai/src/provider.ts:184-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/provider.ts#L184-L191)）

### packages/llm/llm-pi-ai/src/replay.ts

pi-ai 原生响应元数据的持久化投影与 assistant 历史重建，由 `stream.ts` 写入、由 `context.ts` 在每次请求转换历史时读回。

- `parseArguments` 把工具参数 JSON 解析成对象，非对象或解析失败一律降为 `{}`（[packages/llm/llm-pi-ai/src/replay.ts:40-50](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L40-L50)）
- `emptyPiUsage` 给历史消息填全零用量与零成本（[packages/llm/llm-pi-ai/src/replay.ts:53-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L53-L62)）
- `toPiReplayState` 把响应级事实（协议、提供方、模型、响应模型/响应 id、停止原因）写成版本 2 的信封（[packages/llm/llm-pi-ai/src/replay.ts:72-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L72-L82)）
- 每个内容块投影出一条与流式块下标对齐的签名条目（[packages/llm/llm-pi-ai/src/replay.ts:83-102](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L83-L102)）
- `readReplayState` 逐项校验信封的 kind、version、字符串字段、停止原因与块数组，失败抛 `INVALID_REPLAY_STATE`（[packages/llm/llm-pi-ai/src/replay.ts:110-141](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L110-L141)）
- `foreignAssistant` 把中性内容转成 pi-ai 消息，reasoning 转 thinking、tool-call 参数被解析（[packages/llm/llm-pi-ai/src/replay.ts:144-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L144-L156)）
- assistant 历史中的图像块在此抛 `UNSUPPORTED_CONTENT`，插件自定义块被忽略（[packages/llm/llm-pi-ai/src/replay.ts:157-162](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L157-L162)）
- 无 replay 的消息一律标成 `dsh-foreign` 协议与来源，停止原因按是否含工具调用推定（[packages/llm/llm-pi-ai/src/replay.ts:164-175](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L164-L175)）
- `replayedAssistant` 校验 replay 的提供方、模型与块数是否与消息一致，不一致即判为无效（[packages/llm/llm-pi-ai/src/replay.ts:179-183](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L179-L183)）
- 逐块要求类型对齐，并把文本签名、思考签名/redacted、工具思考签名还原回去（[packages/llm/llm-pi-ai/src/replay.ts:184-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L184-L209)）
- 还原后的消息带回原生响应 id、响应模型与停止原因（[packages/llm/llm-pi-ai/src/replay.ts:210-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L210-L221)）
- `toPiAssistant` 对非模型来源或无 replay 状态直接走中性转换（[packages/llm/llm-pi-ai/src/replay.ts:237-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L237-L239)）
- 只有 `INVALID_REPLAY_STATE` 会被降级为中性历史并回调告知，其它错误照旧上抛（[packages/llm/llm-pi-ai/src/replay.ts:240-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/replay.ts#L240-L248)）

### packages/llm/llm-pi-ai/src/stream.ts

把 pi-ai 的助手事件流翻译成 harness `StreamChunk` 的模块，由 `adapter.ts` 包在每次 `streamSimple` 之外。

- `mapUsage` 保留 pi-ai 的 `totalTokens` 原值，缓存计数仅在非零时出现（[packages/llm/llm-pi-ai/src/stream.ts:23-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L23-L31)）
- `classifyPiAiError` 用文本匹配把错误分成 AUTH、配额、RATE_LIMIT、INVALID_REQUEST、SERVER、TIMEOUT、TRANSPORT 与兜底码（[packages/llm/llm-pi-ai/src/stream.ts:41-67](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L41-L67)）
- `mapStopReason` 先按 pi-ai 的溢出判定与 harness 的错误文本判定映射上下文超限（[packages/llm/llm-pi-ai/src/stream.ts:79-92](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L79-L92)）
- 无内容块的 `stop` 被映射成 `EMPTY_RESPONSE` 错误，有内容才算正常结束（[packages/llm/llm-pi-ai/src/stream.ts:95-107](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L95-L107)）
- `length` / `toolUse` 映射为 max-tokens 与 tool-calls，`pending` / `deferred` 映射为不可重试的 `PI_AI_ERROR`（[packages/llm/llm-pi-ai/src/stream.ts:108-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L108-L117)）
- `aborted` 映射为 aborted 结局，`error` 走错误文本分类（[packages/llm/llm-pi-ai/src/stream.ts:118-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L118-L125)）
- 文本事件被转成 block-start / text-delta / block-end 三类 chunk（[packages/llm/llm-pi-ai/src/stream.ts:153-161](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L153-L161)）
- 思考事件被转成 reasoning 块的起止与 reasoning-delta（[packages/llm/llm-pi-ai/src/stream.ts:162-170](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L162-L170)）
- 工具调用起始时从局部消息里取出 id 与名字并按下标记住（[packages/llm/llm-pi-ai/src/stream.ts:171-179](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L171-L179)）
- 工具参数增量携带此前记住的 id、非空时携带名字（[packages/llm/llm-pi-ai/src/stream.ts:180-190](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L180-L190)）
- 工具调用结束时把 pi-ai 已解析的参数重新序列化成原始 JSON 字符串（[packages/llm/llm-pi-ai/src/stream.ts:191-204](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L191-L204)）
- `done` 事件先发 usage、再发带 replay 状态的 finish 并终止流（[packages/llm/llm-pi-ai/src/stream.ts:205-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L205-L212)）
- `error` 事件同样先发 usage 再发 finish，且调用方已取消时把停止原因改写为 aborted、不写 replay 状态（[packages/llm/llm-pi-ai/src/stream.ts:213-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L213-L224)）
- 源流在没有终止事件的情况下结束时抛 `STREAM_CLOSED`（[packages/llm/llm-pi-ai/src/stream.ts:230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/llm/llm-pi-ai/src/stream.ts#L230)）

### packages/llm/llm-pi-ai/tsconfig.json

该包的 TypeScript 编译配置，规定源目录、类型输出目录与工作区项目引用。

- 无运行期机制
