---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/test-support/llm-replay
---

# packages/test-support/llm-replay

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 5 个文件、63 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/test-support/llm-replay/README.md

回放插件的包级说明文档，描述挂载方式、fixture 推导规则、override 侧车与失败模式，供测试作者阅读。

- 无运行期机制

### packages/test-support/llm-replay/package.json

该包的 npm 清单，声明包名、模块类型、入口与发布文件集。

- 声明 `"type": "module"` 与 `main`/`types` 入口，运行期从 `lib/index.js` 加载（[packages/test-support/llm-replay/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/package.json#L13-L15)）
- `exports` 暴露根入口、`./invariant` 子路径、`./src/*` 源码直读与 `./package.json`，决定 bare 导入能解析到哪些文件（[packages/test-support/llm-replay/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/package.json#L16-L27)）
- `files` 只打包 `lib/index.js`、`lib/invariant.js` 与类型声明（[packages/test-support/llm-replay/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/package.json#L28-L32)）
- `peerDependenciesMeta` 把 `dsh-deepseek-llm-api-extensions` 标为可选，允许在缺该包的组合下安装（[packages/test-support/llm-replay/package.json:42-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/package.json#L42-L46)）

### packages/test-support/llm-replay/src/index.ts

回放插件的全部实现：解析录制的 session JSONL、推导每次 `stream()` 调用的脚本、校验 override 侧车、把活跃 session 绑定到脚本，并注册回放适配器或 `llm/stream` 瀑布监听。

- `PACKED_CHUNK_ROW_TYPES` 列出打包 chunk 行类型，后续据此在 `seq`/`seq0`、`time`/`time0` 之间选键（[packages/test-support/llm-replay/src/index.ts:31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L31)）
- `parseSessionLog` 跳过第 0 行会话头，只把其后非空行当作事件解析（[packages/test-support/llm-replay/src/index.ts:187-192](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L187-L192)）
- 行内 JSON 解析失败或不是对象时抛出带行号的错误（[packages/test-support/llm-replay/src/index.ts:193-201](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L193-L201)）
- 缺失的 `seq`/`time`（打包行为 `seq0`/`time0`）用递增的合成值补齐（[packages/test-support/llm-replay/src/index.ts:202-207](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L202-L207)）
- `sourceEventSeqs` 的存储态区间被 `decodeSeqRanges` 展开，再交 `decodeStorageRecord` 还原成事件列表，并按展开条数推进 `nextSeq`（[packages/test-support/llm-replay/src/index.ts:208-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L208-L221)）
- `parseSessionHeader` 只读首个非空行，取出 `id`、`createdAt`、`seedLength`，类型不符时回落到空串与 0（[packages/test-support/llm-replay/src/index.ts:231-239](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L231-L239)）
- `deriveReplayScript` 的 `close` 在收尾分组的最后一个 chunk 不是 `finish` 时抛错，提示该场景需要 override 侧车（[packages/test-support/llm-replay/src/index.ts:258-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L258-L267)）
- 遇到 `compaction/summary` 先关闭当前分组并清空游标（[packages/test-support/llm-replay/src/index.ts:269-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L269-L273)）
- 标记了 `llmStreamCall: true` 的摘要事件缺少 `rawOutput` 时抛错（[packages/test-support/llm-replay/src/index.ts:280-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L280-L283)）
- 该摘要按 `rawOutput` 每个块合成 `block-start`/`block-end`，可选补 `usage`，末尾补 `finish {kind:'stop'}`，作为一次成功流入脚本（[packages/test-support/llm-replay/src/index.ts:284-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L284-L292)）
- `assistant/chunk` 按 `turn/step` 键分组，键变化时先关闭上一组（[packages/test-support/llm-replay/src/index.ts:295-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L295-L302)）
- 遇到 `finish` chunk 立即关闭当前调用分组，遍历结束后再关闭残留分组（[packages/test-support/llm-replay/src/index.ts:303-310](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L303-L310)）
- `REPLAY_CHUNK_TYPES` 固定侧车中允许出现的 chunk 类型集合（[packages/test-support/llm-replay/src/index.ts:334-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L334-L342)）
- `collectStrings` 递归收集请求值的全部字符串叶子，作为占位符匹配语料（[packages/test-support/llm-replay/src/index.ts:348-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L348-L360)）
- `resolveFromRequest` 用全局正则在语料上取最后一次匹配，取第一个捕获组或整段匹配；正则非法或无匹配都抛错（[packages/test-support/llm-replay/src/index.ts:363-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L363-L377)）
- `substituteString` 逐个替换 `{{fromRequest:...}}`，未闭合时抛错，并让连续 `}` 串的最后两个作为终止符以容纳花括号量词（[packages/test-support/llm-replay/src/index.ts:380-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L380-L397)）
- `substituteValue` 对数组与对象递归深拷贝并替换字符串叶子（[packages/test-support/llm-replay/src/index.ts:400-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L400-L409)）
- `resolveScriptedEntry` 在条目序列化后不含占位符时原样返回，否则以换行连接的请求字符串叶子为语料返回替换后的副本（[packages/test-support/llm-replay/src/index.ts:427-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L427-L432)）
- `materializeSessionTokens` 把 `{{session:N}}` 替换为第 N 个已绑定的活跃 session id，未绑定时抛错（[packages/test-support/llm-replay/src/index.ts:435-454](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L435-L454)）
- `inferStartedSubagents` 从请求文本里匹配 `started subagent <id>`，把新 id 填进第一个空闲的非首位槽位（[packages/test-support/llm-replay/src/index.ts:459-473](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L459-L473)）
- `readChunks` 要求 chunks 是数组且每项都带 `REPLAY_CHUNK_TYPES` 中的已知 `type`，否则抛错（[packages/test-support/llm-replay/src/index.ts:487-497](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L487-L497)）
- `readReplayEntry` 对 `chunks`/`throw`/`hang` 三种 kind 各做精确键集校验，`throw` 要求非空 `message`/`code`、可选布尔 `accepted`，`hang` 要求 `readyFile` 为非空字符串，未知 kind 抛错（[packages/test-support/llm-replay/src/index.ts:499-543](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L499-L543)）
- `readOverrideDoc` 接受裸 `ReplayEntry[]` 或恰有 `patches` 键的对象，并要求每个 patch 恰含 `at`/`entry` 且 `at` 是非负安全整数（[packages/test-support/llm-replay/src/index.ts:545-563](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L545-L563)）
- `loadReplayScript` 在侧车存在时读取它：数组形式整体替换脚本，patch 形式在推导脚本上按下标覆写（[packages/test-support/llm-replay/src/index.ts:573-596](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L573-L596)）
- patch 下标超过推导长度或重复出现时抛错，等于长度则追加（[packages/test-support/llm-replay/src/index.ts:580-592](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L580-L592)）
- `deriveScriptFromFile` 在 fixture 文件不存在时抛错并指向重录命令（[packages/test-support/llm-replay/src/index.ts:599-604](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L599-L604)）
- `loadSessionScripts` 在主 fixture 文件缺失时用 `{id:'', createdAt:0}` 作为头信息，使纯 override 场景仍排在首位（[packages/test-support/llm-replay/src/index.ts:614-623](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L614-L623)）
- 子 fixture 缺失时抛错（[packages/test-support/llm-replay/src/index.ts:625-628](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L625-L628)）
- 子会话脚本只从 `seedLength` 之后的事件推导，继承自父的事件不被当作子调用（[packages/test-support/llm-replay/src/index.ts:629-639](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L629-L639)）
- 子脚本按 `createdAt` 升序、同值时按录制 id 字典序排序，主脚本置于最前（[packages/test-support/llm-replay/src/index.ts:641-644](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L641-L644)）
- `ReplayAdapter.providerInfo` 用配置里的 `name` 或 id 回答 provider 元信息（[packages/test-support/llm-replay/src/index.ts:659-664](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L659-L664)）
- `providerRetryPolicy` 把配置的重试策略经 `resolveRetryPolicy` 解析后交给运行时（[packages/test-support/llm-replay/src/index.ts:666-673](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L666-L673)）
- `imageRequestPricing` 在模型声明了 `imageRequestTokens` 时，为每张请求图片返回该视觉 token 数与 `requestImageHandleText` 生成的句柄文本（[packages/test-support/llm-replay/src/index.ts:675-685](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L675-L685)）
- `listModels` 返回配置的模型目录（含名称、描述、输入模态）（[packages/test-support/llm-replay/src/index.ts:687-698](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L687-L698)）
- `resolveModel` 把配置的 `contextWindow`、`defaultMaxTokens`、推理档位与默认档位组装进解析结果（[packages/test-support/llm-replay/src/index.ts:700-730](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L700-L730)）
- `stream` 把每次请求转给回放闭包（[packages/test-support/llm-replay/src/index.ts:732-734](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L732-L734)）
- `paceDelay` 在每个 chunk 之间等待，abort 触发时清除定时器并以 `aborted` 拒绝（[packages/test-support/llm-replay/src/index.ts:742-754](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L742-L754)）
- `chunks` 条目逐个产出录制 chunk，产出前检查 abort 并按 `paceMs` 等待（[packages/test-support/llm-replay/src/index.ts:759-765](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L759-L765)）
- `throw` 条目先产出前缀 chunk，再以录制的 message/code 抛出 `LlmError`（[packages/test-support/llm-replay/src/index.ts:766-776](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L766-L776)）
- `hang` 条目产出一个文本块后写入 `readyFile`，然后一直等到 abort 才以 `aborted` 拒绝（[packages/test-support/llm-replay/src/index.ts:777-788](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L777-L788)）
- `providerAccepted` 判定条目是否到达 2xx 之后的提交点：`chunks`/`hang` 为真，`throw` 取 `accepted`，缺省时按是否有前缀 chunk 决定（[packages/test-support/llm-replay/src/index.ts:796-807](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L796-L807)）
- `installLlmReplay` 校验 `paceMs` 为非负整数，否则抛错（[packages/test-support/llm-replay/src/index.ts:821-824](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L821-L824)）
- 以 `options.sessionId` 为键维护绑定表，无 sessionId 的调用共用匿名键 `ANON`（[packages/test-support/llm-replay/src/index.ts:826-835](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L826-L835)）
- 首次出现的活跃 session 认领下一个未认领脚本并记录其 id，脚本用尽时标记为未录制会话（[packages/test-support/llm-replay/src/index.ts:836-852](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L836-L852)）
- 调用发生时同步推进该 session 的游标并取出对应条目（[packages/test-support/llm-replay/src/index.ts:853-857](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L853-L857)）
- 未录制会话发起调用时在返回的生成器内抛错并报告已见会话数与录制会话数（[packages/test-support/llm-replay/src/index.ts:858-864](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L858-L864)）
- 脚本条目耗尽时抛出带调用序号与脚本长度的错误（[packages/test-support/llm-replay/src/index.ts:865-870](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L865-L870)）
- 每次流开始前先从请求文本推断已启动的子代理 id，再依次做 session token 与 `fromRequest` 占位符替换（[packages/test-support/llm-replay/src/index.ts:871-872](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L871-L872)）
- provider 为 `deepseek-official` 且条目判定为已受理时，在产出首个 chunk 之前调用扩展的 `prepare()` 并 `accept()`，请求体用合成的 `{ messages: [] }`（[packages/test-support/llm-replay/src/index.ts:873-887](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L873-L887)）
- 配置了 provider 目录时注册路由式回放适配器，否则注册 `llm/stream` 全捕获瀑布监听（不调用 `next`）（[packages/test-support/llm-replay/src/index.ts:890-893](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L890-L893)）
- `assertConsumed` 在存在未绑定脚本或未耗尽游标时抛出汇总错误（[packages/test-support/llm-replay/src/index.ts:896-910](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L896-L910)）
- 导出插件名 `llm-replay` 与 `inject: ['llm']`，决定 Loader 的挂载名与依赖注入（[packages/test-support/llm-replay/src/index.ts:914-915](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L914-L915)）
- `validateConfiguredModels` 在加载时拒绝非法 `inputModalities`、非正整数 `imageRequestTokens`，以及未声明 `image` 模态却声明图片计价的模型（[packages/test-support/llm-replay/src/index.ts:935-965](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L935-L965)）
- `apply` 从 `Config.file` 或 `$DSH_SNAPSHOT_FILE` 取 fixture 路径，两者皆空则抛错（[packages/test-support/llm-replay/src/index.ts:967-971](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L967-L971)）
- `apply` 从 `$DSH_SNAPSHOT_OVERRIDE` 与 `$DSH_SNAPSHOT_CHILD_FILES`（按路径分隔符切分）补齐侧车与子日志，再安装回放（[packages/test-support/llm-replay/src/index.ts:972-983](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/index.ts#L972-L983)）

### packages/test-support/llm-replay/src/invariant.ts

该包的不变量伴生插件，向 `invariants` 服务登记包归属，安装器为空。

- 导出插件名 `llm-replay-invariant` 与 `inject: ['invariants']`（[packages/test-support/llm-replay/src/invariant.ts:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/invariant.ts#L13-L15)）
- `apply` 以包名注册空安装器并返回其 disposer（[packages/test-support/llm-replay/src/invariant.ts:21-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/test-support/llm-replay/src/invariant.ts#L21-L29)）

### packages/test-support/llm-replay/tsconfig.json

该包的 TypeScript 编译配置，声明源码目录、类型输出目录与工作区引用。

- 无运行期机制
