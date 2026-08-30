---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/context/agent-instructions
---

# packages/context/agent-instructions

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 10 个文件、110 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/context/agent-instructions/README.md

这是工作区指令加载插件的英文说明文档，介绍配置字段、预算行为与模型可见的三种指令模板。

- 无运行期机制

### packages/context/agent-instructions/package.json

这是该插件包的 npm 清单，声明入口、子路径导出、发布产物与依赖。

- `main`/`types` 把裸包名导入解析到 `lib/index.js` 与 `lib/types/index.d.ts`（[packages/context/agent-instructions/package.json:14-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/package.json#L14-L15)）
- `exports` 只开放 `.`、`./invariant`、`./src/*`、`./package.json` 四个子路径，其余内部模块不可被导入（[packages/context/agent-instructions/package.json:16-27](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/package.json#L16-L27)）
- `files` 把发布内容限定为 `lib/index.js`、`lib/invariant.js` 与 `lib/types` 下的 `.d.ts`（[packages/context/agent-instructions/package.json:28-32](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/package.json#L28-L32)）
- `dependencies` 引入 schema 库，运行期用于插件配置校验与默认值填充（[packages/context/agent-instructions/package.json:44-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/package.json#L44-L46)）

### packages/context/agent-instructions/src/config.ts

这是插件配置的归一化模块，被 `index.ts`、`files.ts`、`state.ts` 用来解析发现范围、字节预算与基线身份。

- 配置 schema 要求 `maxBytes` 必填，并为根标记（`.git`）、单文件上限（1048576 字节）、基础候选名（`AGENTS.md`/`CLAUDE.md`）与本地覆盖候选名（`AGENTS.local.md`/`CLAUDE.local.md`）提供默认值（[packages/context/agent-instructions/src/config.ts:11-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/config.ts#L11-L46)）
- `workspaceBaselineIdentity` 把「项目根相对 cwd 的位置、根标记、两个字节上限、两组候选名」序列化成一个字符串，用于判断恢复出来的基线是否仍然兼容（[packages/context/agent-instructions/src/config.ts:69-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/config.ts#L69-L82)）
- `resolveConfig` 把 `maxSourceBytes` 缺省补成 1048576 并原样带上 `maxBytes`（[packages/context/agent-instructions/src/config.ts:89-95](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/config.ts#L89-L95)）
- `resolveDiscoveryConfig` 用 `resolveDshHome` 解析用户级目录，并补齐根标记与两组候选名（[packages/context/agent-instructions/src/config.ts:102-117](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/config.ts#L102-L117)）
- 候选名过滤掉空串、`.`、`..` 以及含 `/` 或 `\` 的名字，使候选只能是同目录文件名（[packages/context/agent-instructions/src/config.ts:119-123](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/config.ts#L119-L123)）

### packages/context/agent-instructions/src/digest.ts

这是内容标识模块，被 `files.ts` 与 `state.ts` 用来做变更比较与同目录去重。

- `instructionContentSha1` 对原始 UTF-8 文本取 SHA-1 十六进制摘要，作为内容变更判据（[packages/context/agent-instructions/src/digest.ts:14-16](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/digest.ts#L14-L16)）
- `trimmedInstructionDigest` 先去掉首尾空白再取 SHA-1，作为同目录重复文件的折叠判据（[packages/context/agent-instructions/src/digest.ts:26-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/digest.ts#L26-L28)）

### packages/context/agent-instructions/src/files.ts

这是指令文件的发现与有界读取模块，被 `index.ts` 用于装载基线、被 `state.ts` 用于逐 scope 探测与读取。

- `nodeStatFile` 用 `stat`（跟随末段符号链接）探测宿主文件：非普通文件与 ENOENT/ENOTDIR 记为「确定不存在」，其他异常记为「暂时不可用」（[packages/context/agent-instructions/src/files.ts:98-111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L98-L111)）
- `fsStatFile` 走 `ctx.fs` 提供者的 `resolve`+`stat`，记录 target、version、size；类型非 `file` 记为不存在，抛错记为不可用（[packages/context/agent-instructions/src/files.ts:113-135](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L113-L135)）
- `statFile` 依据是否传入文件系统提供者在提供者探测与宿主探测之间二选一（[packages/context/agent-instructions/src/files.ts:137-143](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L137-L143)）
- `existsAsMarker` 探测项目根标记，提供者异常一律当作不存在从而继续向上走（[packages/context/agent-instructions/src/files.ts:145-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L145-L166)）
- `findProjectRoot` 从 cwd 逐级向上找第一个含配置标记的目录，走到文件系统顶端仍未找到就退回 cwd（[packages/context/agent-instructions/src/files.ts:176-191](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L176-L191)）
- `ancestorChain` 生成从项目根到 cwd（含两端）的目录链，顺序由宽到窄，决定指令的呈现次序（[packages/context/agent-instructions/src/files.ts:199-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L199-L212)）
- `descendantDirsBetween` 求出 cwd 与被触碰文件之间跨过的后代目录；目标在 cwd 之外或就在 cwd 时返回空（[packages/context/agent-instructions/src/files.ts:220-227](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L220-L227)）
- `relativeDisplay` 把绝对路径转成相对项目根的展示路径，即模型看到的路径写法（[packages/context/agent-instructions/src/files.ts:235-237](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L235-L237)）
- `allExistingInstructionFiles` 逐个探测某目录下的全部候选名，不存在与探测失败都只跳过该候选，其余候选照常收集（[packages/context/agent-instructions/src/files.ts:239-265](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L239-L265)）
- 发现结果按绝对路径去重，同一路径只进入一次（[packages/context/agent-instructions/src/files.ts:274-278](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L274-L278)）
- 发现流程先探 `<dshHome>/AGENTS.md` 这一份用户级文件，并给它单独的展示路径（[packages/context/agent-instructions/src/files.ts:280-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L280-L296)）
- 随后沿项目根到 cwd 的目录链，在每个目录里先收基础候选、再收本地覆盖候选（[packages/context/agent-instructions/src/files.ts:298-308](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L298-L308)）
- `discoverBaselineInstructionFiles` 对外只暴露绝对路径与展示路径两项（[packages/context/agent-instructions/src/files.ts:318-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L318-L320)）
- `nodeTextChunks` 以 UTF-8 流式读取宿主文件并把中断信号交给读流（[packages/context/agent-instructions/src/files.ts:322-325](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L322-L325)）
- `readBounded` 先按探测到的 size 预筛超限文件，再边流边累计字节，一旦超过 `maxSourceBytes` 立即放弃该文件；读取途中的任何异常也返回 undefined（[packages/context/agent-instructions/src/files.ts:327-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L327-L357)）
- `dedupInstructionFilesByDirectory` 按展示路径的目录分组，去掉去空白后摘要与同目录较早文件相同的候选，保留最早那份的原始字节（[packages/context/agent-instructions/src/files.ts:368-384](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L368-L384)）
- `loadBaselineInstructions` 对外只返回渲染后的基线文本与预算记录（[packages/context/agent-instructions/src/files.ts:392-397](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L392-L397)）
- `maxBytes` 或 `maxSourceBytes` 非正数或非有限值时直接返回 undefined，整条加载链被关闭（[packages/context/agent-instructions/src/files.ts:409-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L409-L411)）
- 逐个读取发现到的候选，读取失败者被丢弃，成功者带上提供者版本令牌进入已读集合（[packages/context/agent-instructions/src/files.ts:412-424](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L412-L424)）
- 去重后为空时：普通情形返回 undefined（不产生任何消息），要求替换旧基线时改为渲染一条空替换基线（[packages/context/agent-instructions/src/files.ts:425-437](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L425-L437)）
- 非空时按 `maxBytes` 渲染，并同时返回渲染前的全部已读文件与预算保留下来的文件（[packages/context/agent-instructions/src/files.ts:438-448](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L438-L448)）
- `probeScopeInstruction` 把 scope key 解回目录与候选名（`user-global` 映射到用户目录、`.` 映射到项目根），resolve+stat 后：非普通文件为确定不存在，提供者异常为暂时不可用（[packages/context/agent-instructions/src/files.ts:460-493](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L460-L493)）
- `readScopeInstruction` 在 `maxSourceBytes` 下读取一个已探测候选，并把探测时的版本令牌一并带回（[packages/context/agent-instructions/src/files.ts:503-517](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L503-L517)）
- 用户级文件的展示路径固定拼成 `<home 展示形式>/AGENTS.md`（[packages/context/agent-instructions/src/files.ts:519-521](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/files.ts#L519-L521)）

### packages/context/agent-instructions/src/index.ts

这是插件入口，注册 `agent/pre-step`、`session/event`、`tools/result` 三个监听器，负责合成基线与增量指令消息并把它们放进 agent 收件箱。

- `visibleBaselineSource` 先倒序扫本次已认领消息、再倒序扫会话可见 surface 上的 `user/message` 事件，取出最近一条基线来源（[packages/context/agent-instructions/src/index.ts:43-59](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L43-L59)）
- 只有 `read`、`write`、`edit` 三个工具名会被视为文件触碰来源（[packages/context/agent-instructions/src/index.ts:70](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L70)）
- `filePathFromExecution` 从工具调用参数里取 `file_path` 字符串并去空白，空串视为没有触碰路径（[packages/context/agent-instructions/src/index.ts:72-78](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L72-L78)）
- 版本缓存与基线准备结果按 Session 存在 WeakMap 里，随会话对象一同释放（[packages/context/agent-instructions/src/index.ts:82-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L82-L86)）
- 插件卸载时中止投影生命周期控制器并清空待归属的执行触碰记录（[packages/context/agent-instructions/src/index.ts:87-96](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L87-L96)）
- 合成入口的三道短路：预算非正或非有限、`ctx.fs` 未挂载、以及「没有触碰路径且收件箱已有待发上下文」时直接复用已有那条（[packages/context/agent-instructions/src/index.ts:113-118](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L113-L118)）
- 每次合成都重算项目根与基线身份，并用身份是否相等决定沿用可见基线还是重建（[packages/context/agent-instructions/src/index.ts:124-131](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L124-L131)）
- 基线缺失、身份不兼容或准备结果缺失时重新装载基线，并把「读到但被预算挤掉」的 scope 集合算成排除集（[packages/context/agent-instructions/src/index.ts:135-154](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L135-L154)）
- 基线里带提供者版本的文件被写进该会话的版本缓存，供后续跳过重复读取（[packages/context/agent-instructions/src/index.ts:155-160](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L155-L160)）
- 需要重建基线时把渲染文本加入消息内容，为旧基线中已不在新基线的 scope 补 `remove` 变更，并把这条基线追加进本次的权威消息列表（[packages/context/agent-instructions/src/index.ts:161-185](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L161-L185)）
- 调用协调器求增量，把增量文本与变更并入同一条消息，并落库版本缓存更新（[packages/context/agent-instructions/src/index.ts:187-209](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L187-L209)）
- 内容为空则不产生消息；否则产出一条带 `agent-instructions` 来源、变更列表与（重建时的）基线身份的 user 消息（[packages/context/agent-instructions/src/index.ts:210-221](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L210-L221)）
- `syncInbox` 按内容与来源深比较维护收件箱：目标为空或已在已认领批次/可见历史里出现过就清掉全部待发；有等价待发就只留一条；否则替换首条或前插，并删掉多余的（[packages/context/agent-instructions/src/index.ts:224-248](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L224-L248)）
- `queueProjection` 用 per-agent 的 promise 尾巴把多次投影串行化，失败在未中止时降级为一条 warn 日志（[packages/context/agent-instructions/src/index.ts:262-275](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L262-L275)）
- `waitForProjections` 在 pre-step 里循环等到该 agent 再无在途投影（[packages/context/agent-instructions/src/index.ts:277-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L277-L280)）
- `stepIsOpen` 在首次询问时重放整条会话事件流，按 `step/start`／`step/end`／`turn/end` 判断当前是否处于未闭合的步骤内，并缓存结果（[packages/context/agent-instructions/src/index.ts:282-292](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L282-L292)）
- `projectTouch` 在步骤已闭合时立刻排投影，否则把触碰缓存到该会话的待处理队列（[packages/context/agent-instructions/src/index.ts:294-303](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L294-L303)）
- `session/event` 监听器维护步骤开闭状态，并在 `step/end` 时把该步骤内缓存的触碰全部转成投影（[packages/context/agent-instructions/src/index.ts:305-320](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L305-L320)）
- `agent/pre-step` 先 `next()` 拿到下游决策，再等投影收敛后合成本次上下文（[packages/context/agent-instructions/src/index.ts:322-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L322-L332)）
- 决策为 reject、或第 1 步且没有任何消息时，上下文不进入本次请求而是继续挂在收件箱（[packages/context/agent-instructions/src/index.ts:333-336](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L333-L336)）
- 步骤将要推进时清空待发上下文；若本批消息里已含等价内容则不再插入（[packages/context/agent-instructions/src/index.ts:339-342](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L339-L342)）
- 否则把上下文插在最后一条已认领消息之后，使直接提示在前、驱动追加的运行时上下文在后（[packages/context/agent-instructions/src/index.ts:343-347](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L343-L347)）
- `tools/result` 只在结果非错误、有归属 agent 且未被中止时，把该次调用的 `file_path` 记为一次触碰（[packages/context/agent-instructions/src/index.ts:350-357](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L350-L357)）
- 有父执行令牌时把触碰上浮给父级；到达最外层执行时才真正投影（[packages/context/agent-instructions/src/index.ts:358-366](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/index.ts#L358-L366)）

### packages/context/agent-instructions/src/invariant.ts

这是本包的不变式伴生插件，注入 `invariants` 服务后以包名占位。

- `apply` 以包名向不变式注册表登记一个空安装器并返回其 disposer（[packages/context/agent-instructions/src/invariant.ts:28-29](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/invariant.ts#L28-L29)）

### packages/context/agent-instructions/src/render.ts

这是模型可见文本的渲染与字节预算模块，被 `files.ts` 渲染基线、被 `state.ts` 渲染增量批次。

- 固定了 `<system-reminder>` 框、基线导语、替换基线导语、空替换导语与压缩导语这几段模型可见文本（[packages/context/agent-instructions/src/render.ts:10-19](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L10-L19)）
- `truncateUtf8` 按字节截断并在切点落在 UTF-8 续字节上时回退到该码点起始，避免产出半个字符（[packages/context/agent-instructions/src/render.ts:69-79](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L69-L79)）
- `escapeInstructionFrameBody` 把正文里出现的 `</system-reminder>` 转义，使仓库内容无法提前闭合插件自有的框（[packages/context/agent-instructions/src/render.ts:81-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L81-L83)）
- 基线小节文本固定为 `Instructions from: <展示路径>` 加空行再接原文（[packages/context/agent-instructions/src/render.ts:85-87](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L85-L87)）
- 用户级 scope 的目录名固定为 `user-global`、文件名固定为 `AGENTS.md`，发现与协调共用这一组常量（[packages/context/agent-instructions/src/render.ts:90-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L90-L98)）
- `scopeForDisplayPath` 把 `~/.dsh/AGENTS.md` 与 `$DSH_HOME/AGENTS.md` 两种展示路径映射到用户级 scope，其余取所在目录（[packages/context/agent-instructions/src/render.ts:105-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L105-L108)）
- `candidateScopeKey` 用 NUL 分隔目录与候选名，使同目录不同候选（基础文件与本地覆盖）在 scope 表里互不碰撞（[packages/context/agent-instructions/src/render.ts:110-125](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L110-L125)）
- `instructionScopeKey` 由展示路径直接推出 scope key（[packages/context/agent-instructions/src/render.ts:132-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L132-L134)）
- `decodeScopeKey` 以首个 NUL 为界还原目录与候选名（[packages/context/agent-instructions/src/render.ts:141-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L141-L146)）
- 新增指令小节固定为 `Additional instructions from: <路径>` 加一句适用范围说明再接原文（[packages/context/agent-instructions/src/render.ts:148-157](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L148-L157)）
- 基线渲染样式在「替换旧基线」时改用替换导语，且集合为空时改用空替换导语（[packages/context/agent-instructions/src/render.ts:161-169](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L161-L169)）
- 变更小节按动作分三种文本：`set` 走新增模板、`remove` 输出 `Instructions removed:` 及失效说明、`replace` 输出 `Updated instructions from:` 及替换后的全文（[packages/context/agent-instructions/src/render.ts:171-184](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L171-L184)）
- `renderInstructionChanges` 渲染一批变更并只回传真正被渲染文本表示出来的那些变更记录（[packages/context/agent-instructions/src/render.ts:192-213](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L192-L213)）
- `markerText` 生成 `Workspace instruction budget <N> bytes:` 通告，逐一点名被省略的路径与被截断路径的原始/保留字节数（[packages/context/agent-instructions/src/render.ts:215-225](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L215-L225)）
- `buildInstructionText` 依次拼接预算通告、导语与各小节，过滤空块，转义后整体包进 `<system-reminder>` 框——框由本插件而非会话表面提供（[packages/context/agent-instructions/src/render.ts:227-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L227-L243)）
- `truncateToFit` 对最具体那份文件做二分，找出整条消息仍不超预算的最大保留字节数（[packages/context/agent-instructions/src/render.ts:249-273](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L249-L273)）
- 预算非正或非有限时输出空文本并把全部文件记为省略（[packages/context/agent-instructions/src/render.ts:280-282](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L280-L282)）
- 全文能装下时直接返回，无省略无截断（[packages/context/agent-instructions/src/render.ts:284-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L284-L287)）
- 装不下时从最宽的文件开始整份丢弃，逐次尝试后缀直到能装下（[packages/context/agent-instructions/src/render.ts:289-294](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L289-L294)）
- 只剩最具体一份仍装不下时先按原导语截断、再退一步换用压缩导语重试，并据保留字节判断这份是否算被表示（[packages/context/agent-instructions/src/render.ts:296-315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L296-L315)）
- 再装不下就退到「预算通告加空标题」，仍不行就只留通告、必要时把通告本身截断（[packages/context/agent-instructions/src/render.ts:317-331](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L317-L331)）
- `renderWorkspaceInstructionSet` 选定样式后同时返回公开渲染结果与「内容真正存活下来的文件」列表（[packages/context/agent-instructions/src/render.ts:341-348](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L341-L348)）
- `renderWorkspaceContext` 对外只给出渲染文本与预算诊断（[packages/context/agent-instructions/src/render.ts:356-361](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/render.ts#L356-L361)）

### packages/context/agent-instructions/src/state.ts

这是会话可见状态与增量协调模块，被 `index.ts` 调用来比对已可见指令与当前文件系统并产出替换/新增/移除消息。

- 增量消息以 `agent-instructions` 来源构造，把变更列表随消息一起持久化（[packages/context/agent-instructions/src/state.ts:81-86](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L81-L86)）
- `workspaceContextMessage` 把基线渲染文本包成一条 user 角色消息（[packages/context/agent-instructions/src/state.ts:93-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L93-L98)）
- `workspaceInstructionChanges` 在重放日志时逐条校验变更记录，动作不在三值内、scope/path 非字符串、digest 类型不对的记录被跳过（[packages/context/agent-instructions/src/state.ts:112-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L112-L127)）
- `sameInstructionChange` 以动作、scope、路径、摘要四项逐字段相等定义两条变更是否同一条（[packages/context/agent-instructions/src/state.ts:129-134](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L129-L134)）
- `visibleInstructionChanges` 只采纳位于会话可见 surface 上的事件，再叠加本次权威消息，每个 scope 取最后一条变更（[packages/context/agent-instructions/src/state.ts:136-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L136-L156)）
- `baselineInstructionState` 把基线保留文件转成每 scope 一条 `set` 变更与一条含原文摘要、去空白摘要、提供者版本的缓存状态（[packages/context/agent-instructions/src/state.ts:163-188](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L163-L188)）
- `retainedInstructionVersionUpdates` 只提交那些与真正渲染出来的变更逐字段相同的缓存更新（[packages/context/agent-instructions/src/state.ts:205-210](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L205-L210)）
- `applyInstructionVersionUpdates` 按 scope 写入或删除缓存条目，缓存清空后连该会话的整张表一并移除（[packages/context/agent-instructions/src/state.ts:218-230](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L218-L230)）
- 协调开始时取会话 cwd，并在未传入时重新查找项目根（[packages/context/agent-instructions/src/state.ts:262-268](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L262-L268)）
- 基线 scope 集合 = 用户级那一个 + 项目根到 cwd 每个目录 × 全部基础候选与本地候选（[packages/context/agent-instructions/src/state.ts:271-279](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L271-L279)）
- `includeBaselineScopes` 为真时基线 scope 全部纳入本次探测，为假时后续来源里属于基线的 scope 一律被排除（[packages/context/agent-instructions/src/state.ts:280-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L280-L296)）
- 每条被触碰路径带来的后代目录也整目录展开成候选 scope（[packages/context/agent-instructions/src/state.ts:297-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L297-L299)）
- 本轮维护一张「每目录已保留的去空白摘要」表，用于识别同目录内的重复候选（[packages/context/agent-instructions/src/state.ts:301-316](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L301-L316)）
- 移除变更以空内容的伪文件入队，同时排一条删除该 scope 缓存的更新（[packages/context/agent-instructions/src/state.ts:319-323](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L319-L323)）
- 待探测 scope 先按目录分组，使同目录候选在一次循环里按候选顺序处理（[packages/context/agent-instructions/src/state.ts:324-330](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L324-L330)）
- 被基线预算排除掉的 scope 不再探测：之前没渲染过就只清缓存，渲染过则补一条移除（[packages/context/agent-instructions/src/state.ts:331-343](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L331-L343)）
- 探测结果为「暂时不可用」且该 scope 之前是活跃的，则回滚本目录已产生的全部条目、版本、已见路径与去重记录并跳过整个目录（[packages/context/agent-instructions/src/state.ts:350-365](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L350-L365)）
- 探测结果为「确定不存在」时，未渲染过的清缓存、渲染过的产出移除通知（[packages/context/agent-instructions/src/state.ts:366-370](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L366-L370)）
- 同一绝对路径在本轮只处理一次（[packages/context/agent-instructions/src/state.ts:372-374](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L372-L374)）
- 缓存路径与版本、可见变更的路径与摘要全部吻合时跳过读取；但若同目录更早的兄弟已占用同一去空白摘要，则改为产出移除（[packages/context/agent-instructions/src/state.ts:375-389](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L375-L389)）
- 读取失败的候选被静默跳过，不产生任何消息（[packages/context/agent-instructions/src/state.ts:391-392](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L391-L392)）
- 读到的内容若与本目录更早候选去空白后相同则被丢弃，之前渲染过的还要补一条移除（[packages/context/agent-instructions/src/state.ts:393-401](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L393-L401)）
- 路径与内容摘要都没变时只刷新版本缓存，不产生模型可见消息（[packages/context/agent-instructions/src/state.ts:402-411](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L402-L411)）
- 之前不可见或已移除的记为 `set`，之前可见的记为 `replace`，连同新版本一起入队（[packages/context/agent-instructions/src/state.ts:412-421](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L412-L421)）
- 无任何转换时返回 undefined；渲染后文本为空或没有变更存活时同样返回 undefined 且不提交版本，使下一轮重试而不是发出只有通告的上下文（[packages/context/agent-instructions/src/state.ts:423-432](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/context/agent-instructions/src/state.ts#L423-L432)）

### packages/context/agent-instructions/tsconfig.json

这是本包的 TypeScript 编译配置，声明 rootDir、outDir 与工作区项目引用。

- 无运行期机制
