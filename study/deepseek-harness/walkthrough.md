# deepseek-harness 走查：同一任务的三次运行

钉住提交 [cd5ef814](https://github.com/deepseek-ai/deepseek-harness/tree/cd5ef8148158c3a752a658978873241fdf8e2bbc)（0.1.2-alpha.1）。轨迹来自 `study/deepseek-harness/trace/default/` 与 `trace/minimal/`，任务与 mini-swe-agent 那次完全相同：三文件滑动平均小仓库，少算最后一个窗口，4 个测试挂 2 个。模型都是 xai/grok-4.3。

三种标记：**事实**——代码和日志里能直接看到的；**设计选择**——作者可以不这么做但这么做了的；**推断**——我对意图的猜测，没有原文佐证。

---

## 一、dsh 是什么形状

一句话：一个微内核（vendor 进来的 Cordis）加几百个插件，agent 循环本身也是插件；一份追加式事件日志是唯一事实源，模型看见的"面"是它的投影；权限是三档沙箱加一个只会说"不"的审批策略；headless 组合没有任何步数、花费或时间上限。作者自己的定位写在 [README.md:13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/README.md#L13)：developer preview，"一定会有破坏兼容的改动"；[SAFETY.md:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/SAFETY.md#L13-L15)：沙箱和审批只能降低风险，不保证隔离。

这次跑的是 `dsh --profile headless`。默认组合挂 25 个工具（读、写、编辑、glob、grep、bash、后台作业、web 搜索、目标、工作流、ralph、子代理、待办、技能、计划模式、图片、str_replace_editor……），极简组合只挂两个：常驻 bash 和 str_replace_editor。`DSH_PERMISSION_MODE=danger-full-access` 把沙箱设成全权、把审批策略设成 never。

和 mini-swe-agent 最大的形状差别：那边一切都在一百行里，这边一切都不在核心里——压缩、裁剪、先读后写、重复调用提醒、超时策略，每一样都是一个可以从组合文件里去掉的包。这决定了下面第三节会发生什么。

---

## 二、默认组合：五步修好

**屏幕上**：五步——glob 找文件、并行读两个文件、一次 edit、bash 跑测试、回复"修好了"。

**内部**（以第三步 edit 那一圈为例）

**1. 上下文里有什么。** 第一步之前，harness 先把这一轮要发给模型的**完整系统提示和全部 25 个工具声明**写成一条 `request/header` 事件（[agent.ts:506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L506)），再写一条 `request/context` 记模型的上下文窗口是 1,000,000。然后把沙箱模式和审批策略以一条 `user/message` 的形式插进对话，`source.kind` 是 plugin、`form` 是 snapshot——它放在任务之后而不是系统提示里，所以前缀不动、缓存不断（**设计选择**：日志里那条消息自己写着"This snapshot supersedes earlier runtime-context snapshots"）。模型看到的历史不是日志本身，是日志的投影：每条消息带 `surfaceOp`，替换时按 `sourceEventSeqs` 点名遮蔽哪几个 seq（[surface.ts:369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L369)）。AGENTS.md 把这写成硬规矩：凡进入模型请求的都必须能从日志重建（[AGENTS.md:111](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/AGENTS.md#L111)），而且 agent-loop 里有一条运行期不变量在每次调用前真的做这个比对（[invariant.ts:39-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/invariant.ts#L39-L42)）。

缓存：五步的 cacheReadTokens 是 192、7488、7552、192、8192——第四步几乎全未命中。**推断**：edit 之后的那条 tool/result 带着 diff 元数据，但前缀本不该变；更可能是供应商侧缓存的时效或分块。这是差分探针值得追的一条。

机制：**感知独占——日志是真相，上下文是投影，动态信息放在尾部**。mini-swe-agent 记的是对话，这里记的是能重建每一次请求的全部材料。

**2. 模型决定了什么。** 流式回来：`assistant/chunk` 一块块，其中 reasoning 块带每个 token 的时间差；收齐后拼一条 `assistant/message`，带 `sourceEventSeqs` 指回它由哪几条 chunk 拼成，带 `replayState` 记供应商的响应 id 和块结构——这是续跑和分叉时把对话原样交还给供应商的凭据（**事实**）。第三步模型只发一个调用：`edit`，old_string 是那行 `range(len(values) - window)`，new_string 加了 `+ 1`。

**3. harness 判决了什么。** 判决是一条链，每一环都是独立插件。先过 `tools/pre-execute` 瀑布——瀑布的语义是监听器可以不调 next 从而整体取代内建行为（[events.ts:234-243](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/vendor/cordis/src/events.ts#L234-L243)）。再过 guard：`ToolGuard` 的返回值类型里只有"拒绝理由"或 undefined，**没有 allow**，注释明写监听器顺序无法把拒绝翻回许可（[tools/src/index.ts:704-712](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/tools/src/index.ts#L704-L712)）。再过先读后写：edit 一个没读过的文件会被 `FS_NOT_OBSERVED` 拦下（[fs-observation-policy:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L82)）——这次第二步已经读过，放行。再过沙箱：模式由请求、会话覆盖、默认值三级择出（[sandbox-policy:138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L138)），这次是 danger-full-access，写工作区不需要审批。审批策略 never 的含义不是"放行"而是"一律判拒绝"（[user-approval:277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L277)）；两份日志里 approval/asked 都是 0 条，说明整轮没有任何调用走到审批那一环。

机制：**效果独占——判决链由组合决定**。哪几环存在，取决于组合文件挂了哪几个包；guard 只能否决，是这条链上唯一被类型固定住的语义。

**4. 执行了什么。** 一步里若有多个调用，先按第一个待办的执行模式分组（[tool-calls.ts:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L88)）：可并行的一组用有界滚动池跑，独占的单独跑，结果只沿模型给出的顺序提交——第二步的两个 read 就是这样并行的。第三步只有一个 edit：fs-local 做替换前先数匹配次数，多于一处且没要求 replaceAll 就拒绝（[fsio.ts:775](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L775)）。

**5. 记录了什么。** `tool/result` 除了给模型看的文本，还带一份结构化 `meta`（diff 的 old/new、路径、行号），供界面和投影用，模型看不到。`step/end` 记这一步的 usage。压缩这一轮没触发：compaction-basic 只在压力到阈值时动手（[compaction-basic:153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L153)），工具结果裁剪只在总字符数超阈值时动手（[pruner:85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L85)）；真触发时也不删日志——先追加一条 compaction/prune 记下遮了哪几个 seq，再追加一条带 surfaceOp: replace 的新结果把旧节点从"面"上遮掉，原文永远在（[pruner:159-173](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L159-L173)）。

机制：**持久独占——追加日志加投影缓存**。这就是你问过的"快照还是日志"的另一头：mini-swe-agent 每圈整份重写，dsh 每个事件写一次、从不改。

**6. 为什么继续、为什么停。** 没有步数、花费、时间上限——agent-loop 的配置里只有 maxParallelToolCalls 这一项（[agent-loop/src/index.ts:254-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L254-L272)）。循环继续的唯一理由是模型还在发工具调用；模型不再发了，`turn/end` 写 reason: completed（[agent.ts:326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L326)）。这里没有口令：模型停止调用工具就是完成协议。

机制：**续行独占——模型拥有停止权，harness 只记录**。和 mini-swe-agent 正好相反：那边模型不能停、环境认口令才停；这边模型说停就停、harness 不设上限。两种赌注，矩阵第 50、52 行并排就是它。

---

## 三、极简组合：同一任务三十九步

**屏幕上**：模型用 str_replace_editor 做了一次替换，把缩进弄坏；之后三十多步反复读文件、再替换、再读，越修越乱；最后放弃修补，整个文件重写，测试通过。

**内部，只讲和默认组合不同的四处。**

工具变了。默认组合的 `edit` 要求 old_string 唯一匹配，极简组合的 `str_replace_editor` 是按偏移量做的一次替换（[tool-str-replace-editor:315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L315)），一次错位就把缩进带坏。

守卫没了。先读后写是一个独立插件挂在瀑布上，不被组合进来，同一个编辑动作就是无条件写（[fs-observation-policy:78-83](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L78-L83)）。极简那份系统提示里没有先读后写这条规矩（**事实**：见 `trace/minimal/terminal.txt` 里的系统提示）。

shell 是常驻的。极简用的是 tool-bash-persistent，走 PTY，工具描述明写"State is persistent across command calls"——mini-swe-agent 的 FAQ 用三条理由拒绝的东西，dsh 的极简组合恰恰选了它。矩阵第 29 行两格相反。

没有压缩、没有上限。极简组合的说明自己写着 context compaction is absent；headless 又没有步数上限。三十九步能停下来，是模型自己收住了，不是 harness 拦的。换一个更固执的模型，这一轮可以一直跑到上下文窗口装不下为止。

**结论**：差别不在工具多少。25 个工具和 2 个工具的差距，落在两条具体机制上——编辑原语的匹配语义、先读后写的守卫——而这两条在 dsh 里都是可拆的插件。作者的架构主张（[docs/architecture.md:11-13](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/docs/architecture.md#L11-L13)）在这里付了代价：一切皆插件，意味着组合错了就什么都没有。

---

## 四、三次并排

| | mini-swe-agent | dsh 默认组合 | dsh 极简组合 |
|---|---|---|---|
| 模型调用 / 步数 | 6 次 | 5 步 | 39 步 |
| 工具 | bash 一个 | 25 个 | 常驻 bash + str_replace_editor |
| 编辑原语 | sed 与 heredoc，提示词里教 | edit，唯一匹配 | str_replace_editor，偏移替换 |
| 先读后写 | 没有 | 有，独立插件 | 没有 |
| 常驻 shell | 没有，每命令新子进程 | bash 工具非常驻 | 有，PTY |
| 上限 | 步数、花费、墙钟三种 | 没有 | 没有 |
| 完成协议 | 命令输出首行口令，环境认 | 模型不再调工具 | 同左 |
| 日志形态 | 每圈整份重写的快照 | 追加式事件日志，投影缓存另存 | 同左 |
| 记不记 harness 自己的决定 | 不记 | 记：权限、沙箱、审批策略、请求头都是事件 | 同左 |
| 判决 | 四道格式校验，在模型层 | 瀑布 → guard → 先读后写 → 沙箱 → 审批 | 瀑布 → guard → 沙箱 → 审批 |
| 缓存 | 前缀天然稳定 | 动态信息放尾部保前缀 | 同左 |

---

## 五、有什么、没什么

78 行技术点对 dsh 的判定是有 39、部分有 31、没有 8，全文在 `study/deepseek-harness/checklist-judgments.md`。8 条"没有"值得记的是它们各自被什么替代了：

- 记忆（第 13、49 行）：没有第一方记忆层，外包给 MCP 记忆服务器，默认全关。
- 破坏性动作识别（第 37 行）：不判断命令语义，改用三档沙箱加审批。
- 确定性校验器接入（第 39 行）：不替 agent 跑测试或 lint，留给模型用 bash 跑，或部署方配 hook。
- git 版本化状态（第 51 行）：版本化由日志 seq 和各投影的 revision 承担，git 只是路径标记。
- 元模型组合器、按模型名推断（第 28、30 行）：适配器手册明令禁止凭模型名猜配置。
- 批量运行（第 78 行）：没有实例运行器，批量交给使用者。

合起来一句话：dsh 只给通道、权限档和日志，跑什么、记什么、验什么全部留给插件和部署方。

---

## 六、这个仓库的脾气（观点）

1. **请求信封本身是事件**。系统提示和工具表进日志，请求可从日志逐字重建，并有运行期不变量反向核对。
2. **压缩只遮蔽、不删除**。面与日志是两层，压缩是一次可回放的定位操作。
3. **guard 只能否决**。放行这个返回值从类型里被删掉，拒绝在整条链上单调不可逆。
4. **提权是一个工具参数**。被拒后原样重发同一条命令，带 sandbox_permissions 和一句理由，执行期判是否严格更宽（[escalation.ts:143-189](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox/src/escalation.ts#L143-L189)）。
5. **沙箱的最后一级是 298 行 C**。直接打 Landlock 内核接口，内核不支持就 fail closed（[main.c:1-36](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/native/landlock-run/packages/entry/src/main.c#L1-L36)）。
6. **会话日志可以增量上传给模型提供方**，带水位线和至少一次投递，对模型零 token、完全不可见（[session-log-deepseek:69-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/session/session-log-deepseek/src/index.ts#L69-L99)）。
7. **每个包的 README 必须写"模型看到了什么"**——token 影响、KV cache 影响，门禁卡着。
8. **它能跑别家 harness 的东西**（我抽查加的一条）。hook 有 claude-code 与 codex 两种方言，退出码 2 即阻塞、决定取最严、hook/invoked 与 hook/result 成对进日志（[merge.ts:35-42](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/merge.ts#L35-L42)，[events.ts:92-99](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/hooks/hook-protocol/src/events.ts#L92-L99)）；子代理驱动有 claude-code、codex、acp 三种。这是"harness 之上的 harness"的实物。

---

## 七、不变核与补偿层（我的标注，等你判）

不变核：agent-loop 的循环；会话日志与投影；工具注册表与 guard；沙箱策略与审批服务；模型适配层。

补偿层（补的弱点写在括号里）：compaction-basic（窗口有限）；tool-result-pruner 与 spill（大输出挤窗口）；fs-observation-policy（模型不看就改）；repeat-tool-reminder（模型重复调用）；timeout-policy（命令挂死）；运行期上下文快照以 user 消息重注入（指令衰减，且要保前缀）；goal / ralph / workflow（长任务漂移与多步编排）；子代理隔离（单窗口装不下）；session-title 侧调用（给人看，与模型无关）。

争议点留给你：先读后写守卫是补偿层还是不变核？它补的是模型的坏习惯，但去掉它第三节就会发生——这是"补偿层可删"最锋利的反例。

---

## 八、读完请你答的题

每题一两句，在对话里答。括号里是答案所在的节。

1. （二.1）dsh 的 request/header 事件记了什么？为什么说"模型看见的都能从日志重建"在 mini-swe-agent 里不成立？
2. （二.3）guard 的返回值类型里少了什么？这个缺失保证了什么？
3. （二.5 与三）压缩触发时日志会不会变短？被裁掉的工具输出去了哪里？
4. （二.6 与四）dsh 和 mini-swe-agent 各自由谁决定运行结束？哪一边在模型固执时更危险，为什么？
5. （三）极简组合多花的三十四步，落在哪两条机制的缺席上？这两条在 dsh 里是什么形态？
6. （三，常驻 shell 那段）mini-swe-agent 拒绝常驻 shell、dsh 极简组合选用它——矩阵第 29 行这两格相反，你倾向哪一边？说一个理由。
7. （五）dsh 的 8 条"没有"里，哪一条是被另一种机制替代的，哪一条是被外包的？各举一例。
8. （七）先读后写守卫，你判它是不变核还是补偿层？用第三节的事实支持你的判断。
