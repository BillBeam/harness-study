# Log

> 中文：[LOG.zh-CN.md](LOG.zh-CN.md)

Newest first. One entry per session: what was pinned or read, and what came out
of it.

2026-08-29 —— 第一条轨迹：八问八答，外加一问
自己读了 study/mini-swe-agent/trace/mini.traj.json 后逐题手答，参谋位逐条纠正。每题先是我的回答，再是纠正与解释。
1. assistant 消息里哪些是模型说的、哪些是 harness 加的
我答：content 是模型加的但不知为何为空；role 不确定谁加；tool_calls 是模型生成的；function_call 不知为何是 null，也不知道它和 tool_calls 的区别；reasoning_content 是模型给的理由；provider_specific_fields 不明；extra、usage、cost 感觉都是模型加的；timestamp 可能是 harness 算的；消息拼接是 harness 做的。
纠正：这条消息是三层东西叠在一起。第一层是模型真正说的：content 里的文本（这次它选择不说，所以为空——Grok 把说明放进了 reasoning_content，提示词要求的"reasoning text"它没写进 content）、reasoning_content（推理模型的推理摘要，是模型输出，按输出 token 计费——第一次调用 120 个 completion token 里 108 个是 reasoning）、tool_calls 里的 function.name 和 function.arguments（"调 bash，命令是 ls -la"）。第二层是接口信封，由 xAI 的接口和 litellm 的归一化加上，不是模型也不是 mini-swe-agent：role 为 assistant 是协议里的固定角色；tool_calls 里那个 call-… 编号是接口生成的；type 为 function 是常量；function_call 是 OpenAI 早期"一次只能调一个函数、没有编号"的老字段，被带编号、可多条的 tool_calls 取代了，litellm 为兼容仍然保留，所以是 null；provider_specific_fields 是 litellm 放它没归一化的厂商私有字段的桶，refusal 是 OpenAI 风格的"模型拒答"字段，这次空。usage 也在这一层，来自接口。第三层才是 harness 加的，全部在 extra 里：extra.actions 是 harness 从 tool_calls 解析并校验后得到的动作列表（`mini-swe-agent@25941c89:src/minisweagent/models/utils/actions_toolcall.py:30-76`——工具名必须是 bash、参数里必须有 command，否则抛 FormatError）；extra.response 是整份原始接口响应的留底；extra.cost 是从接口 usage 里的 cost_in_usd_ticks 换算来的（5198000 ticks 等于 0.0005198 美元，对得上）；extra.timestamp 是 harness 记的时间。"消息拼接是 harness 做的"对，在 `mini-swe-agent@25941c89:src/minisweagent/agents/default.py:69-72` 的 add_messages。还有一个角色没问但最关键：exit。它不是协议角色，模型从不看见它，是 harness 自己发明的第五种 role，只用来让循环停下。
记法：模型说的 = content、reasoning_content、tool_calls 里的 function；接口加的 = role、id、type、function_call、provider_specific_fields、usage、finish_reason；harness 加的 = extra 下面的一切，以及 exit 这个角色。
2. prompt_tokens 与 cached_tokens
我答：prompt_tokens 是本轮发给模型的提示词 token；cached_tokens 是不是有多少 token 的 KV cache 被复用了，不确定。
解释：两个都对，第二个比自己以为的还准。prompt_tokens 是这一次调用发给模型的全部内容：system、user、之前所有的 assistant 和 tool 消息，再加上随请求下发的工具声明（`mini-swe-agent@25941c89:src/minisweagent/models/litellm_model.py:69`）。它是整段对话——mini-swe-agent 没有任何压缩，每次把 self.messages 整个发出去（`mini-swe-agent@25941c89:src/minisweagent/agents/default.py:149`）。证据是六次调用的 prompt_tokens 单调涨：1036、1222、2525、2999、3053、3193；从 1222 跳到 2525 那一下，是三个 cat 的输出进了上下文。cached_tokens 就是 KV cache 复用：厂商认出这次请求的前缀和之前某次一模一样，复用算好的缓存，这部分按低价计费。数字是 1024、192、1216、2496、2944、3008。第一次调用就命中 1024，是因为执行位连跑了三次，前两次已经把同样的 system 加 instance 前缀喂进过缓存，缓存在厂商那边跨运行存活。第二次只命中 192，说明命中不是单调的，跟厂商的分块粒度和时机有关。结构上的教训一条：harness 保持稳定的那段前缀（system、instance 模板、工具声明）就是能被复用的部分，这是"稳定前缀"算感知独占一项补偿手段的原因。
3. 三个 tool_calls 与三条 tool 消息怎么对上
我答：靠 assistant 里 tool_calls 的 id 和 tool 消息里的 tool_call_id 一一对应。
解释：对。补两点。一，三条 tool 消息是 harness 生成的，不是环境直接吐的：环境返回三个输出 dict，模型层再把每个渲染成一条 role 为 tool、带 tool_call_id 的消息。二，接口有一条硬规矩：assistant 发出的每个 tool_call 编号，在下一条 assistant 之前都必须收到一条对应的 tool 消息，否则请求被拒——这条规矩解释了第 5 题里那条奇怪的占位消息。另外，模型一次发三个调用看起来是并行提议，执行却是串行的：`mini-swe-agent@25941c89:src/minisweagent/agents/default.py:156` 是一个列表推导，一个接一个跑。
4. raw_output 与 content
我答：raw_output 是工具原始输出；content 是统一的结构化工具响应，returncode 加 output，output 里就是 raw_output。
解释：方向对，两处要精确。第一，这里只有一个工具 bash，所以不存在"每个工具统一"的问题；形状来自环境层 execute() 返回的 dict（returncode、output、exception_info）。第二，content 不是简单包一层，它是用模板渲染出来的，模板在 info.config.model.observation_template：输出不到一万字符时原样放进 JSON；超过一万字符只留头 5000 尾 5000，加一个 elided_chars 和一句 Output too long 的警告。所以 raw_output 是真实发生的（留底，不发给模型），content 是模型看见的（可能被裁过）。同一件事两个版本，模型看哪个版本由 harness 决定——这就是感知独占。这次没触发裁剪，但机制在配置里躺着。
5. 口令、"action was not executed"、exit、submission
我答：可能定义了一个环境变量叫 COMPLETE_TASK_AND_SUBMIT_FINAL_OUTPUT，echo 它就触发 action was not executed；exit 应该是模型写的，模型觉得该结束了就把 role 定为 exit；submission 不知道为什么是空。
纠正：三处都要改。一，它不是环境变量，是一个字面量口令；echo X 就是把 X 原样打印出来。命令被正常执行了，然后环境层检查这条命令的输出：第一行等于口令且 returncode 为 0，就抛出 Submitted（`mini-swe-agent@25941c89:src/minisweagent/environments/local.py:45-56`；异常类在 `mini-swe-agent@25941c89:src/minisweagent/exceptions.py:9`）。因为异常是从 execute 里抛出来的，这个动作的正常观察结果没来得及生成；为了满足第 3 题那条"每个 tool_call 必须有一条 tool 消息"的规矩，harness 给它补了一条占位消息，内容就是 returncode -1 加 action was not executed。所以"没执行"是占位用语，命令其实跑了，只是它的输出没进对话。这条占位消息具体是哪段代码写的，参谋位没有逐行核，留给我在 S2 走查里亲自找。二，exit 不是模型写的，模型永远没有直接结束循环的能力。它唯一能做的是说出口令；环境认出口令后抛 Submitted，异常自己带着一条 role 为 exit 的消息，循环在 `mini-swe-agent@25941c89:src/minisweagent/agents/default.py:115-116` 接住并追加，然后在 122 行看到最后一条是 exit 就 break。谁能结束运行——环境能、预算能、循环自己（连续格式错误）能、模型不能——这是这个 harness 最值得记住的一个设计。三，submission 为空，是因为口令协议规定"口令之后的输出才是提交内容"。模型只 echo 了口令，后面什么都没有，所以是空串。SWE-bench 模式下模板会要求在口令后面跟上 git diff，这次的任务不需要。
6. 规矩写在哪
我答：规矩写在 system 和第一条 user 的 content 里；"至少一个 bash 调用""每个动作新 subshell"在第一条 user 里。
解释：对。补的是"为什么这样"。system 只有一句话，所有操作规矩都在第一条 user 消息里，也就是 instance_template 渲染出来的那段。这是有意的选择：前两条消息永远不变，放哪里都在稳定前缀里。更值得看的是那几条规矩各自在补什么。"每个动作都是新 subshell，cd 和环境变量不持久"——是在用提示词告诉模型一个环境层的限制（LocalEnvironment 每条命令起一个新子进程，没有常驻 shell），而不是去修环境。"用 sed 改文件"那一大段示例——因为没有编辑工具，只有 bash，编辑被推到 sed 和 heredoc 上，提示词在替缺席的工具补课。以后读别的 harness，可以用同一个问题去看它的提示词：哪些规矩是在用文字补机制的缺。
7. 没记什么、harness 自己的判断
我答：不知道没记什么；不知道"harness 自己做的判断"指什么。
解释：指的是这些：每一轮 harness 都在做决定——解析工具调用是否合法（抛不抛 FormatError）、调模型前查不查上限（步数、花费、墙钟）、要不要确认（mode）、是否停止。这些决定本身一条都没记进轨迹，只能从后果反推：格式错了会出现一条 role 为 user 的错误模板消息；上限到了会出现一条 exit 消息、exit_status 写 LimitsExceeded。此外没记的还有：随请求发出去的工具声明（它在请求参数里，不在 messages 里）、请求本身（只留了响应）、模型调用的耗时（只能用相邻 timestamp 相减）、缓存状态、drop_params 丢掉了什么。所以这份轨迹是一份对话记录，不是一份事件日志——它记模型说了什么和看见了什么，不记 harness 自己做了什么。DeepSeek Harness 走的是另一条路，模型看见的一切和 harness 做的一切进同一条日志。这会是后面最早遇到的一个对照点。
8. info.config 的三段，限制与模板
我答：第 6 题应改成 instance_template 定义了规矩、用户原问题替换掉 {{task}} 占位符；没看出 info.config 为什么是三段；哪些是限制哪些是模板答不了。
解释：占位符那句完全对，渲染用的是 jinja2；{{system}} {{release}} 也一样被环境信息填上了，所以 user 消息里能看到 Linux 6.18 那行；模板里那段"MacOS 要用 sed -i ''"因为 system 不是 Darwin 没渲染出来——这就是 harness 拿环境状态编译上下文的一个具体样子。三段是 agent、model、environment，各配一个类名（agent_type、model_type、environment_type），对应命令行入口把合并后的配置拆成三个子字典、分别交给三个工厂（`mini-swe-agent@25941c89:src/minisweagent/run/mini.py:99-102`）。按四项独占分：agent 段里 step_limit 40、cost_limit 1.0、wall_time_limit_seconds 0（0 表示不限）、max_consecutive_format_errors 3 是续行的限制；system_template、instance_template 是感知的模板；mode 为 yolo、whitelist_actions 空、confirm_exit 为 false 是效果层的确认策略，这次被 -y 和 --exit-immediately 全部关掉；output_path 是持久。model 段里 format_error_template 是模型输出格式不对时喂回去的话，observation_template 是第 4 题那个裁剪模板，都属感知；set_cache_control 为 null 说明没用 Anthropic 式的显式缓存标记。environment 段里 timeout 60 是每条命令的超时，属效果；env 里 XAI_API_KEY 被置空，是执行位做的边界——agent 自己的 shell 里看不到密钥。
9. 补问：工具声明不在 messages 里，模型怎么看见的
我问：工具声明虽然不在 messages 里，模型也看到了吗，具体怎么看到的？
解释：看到了，当成文字看到的。harness 发给接口的请求体里 messages 和 tools 是两个平级字段（`mini-swe-agent@25941c89:src/minisweagent/models/litellm_model.py:69` 把 BASH_TOOL 放进 tools；声明本身在 `mini-swe-agent@25941c89:src/minisweagent/models/utils/actions_toolcall.py:11-27`）。但模型只吃一条 token 序列，服务端用这个模型的对话模板把请求摊平：系统提示、工具声明序列化成文本塞进系统段或专用工具块、每条消息带角色标记、末尾接生成提示。messages 和 tools 的分家只存在于接口层。证据：第一次调用 prompt_tokens 是 1036，比两段文字本身多出的那截就是工具声明。模型会回结构化的 tool_calls，是因为后训练时见过这个工具块的形状，学会了用约定格式输出，服务端再解析回 tool_calls 还给 harness——所以工具调用是三方合约：服务端怎么渲染、模型训练时见过什么、服务端怎么解析回来。开源权重模型的 Jinja 对话模板把这层写得明明白白，托管模型把它藏着。mini-swe-agent 自己还留着另一条路印证这一点：`mini-swe-agent@25941c89:src/minisweagent/models/utils/actions_text.py:15-40` 是给没有工具调用能力的模型用的——提示词里写"用三反引号 bash 块给命令"，再用正则从文字里抠。两条路做的是同一件事，工具接口只是把合约从 harness 搬进了服务端。三个后果：工具描述就是提示词；工具声明在稳定前缀里，工具列表一变缓存就断，这是"按需展开"和缓存互相拉扯的根源；harness 永远看不到模型真正看见的那条序列，只看得到自己发了什么和 usage 里的数。
这条轨迹按四项独占的总结

* 感知：两段模板加工具声明，观察渲染含万字裁剪，每次整段历史重发，没有压缩。
* 效果：解析与校验（工具名、command 参数）后串行子进程执行，每条 60 秒超时；确认与白名单存在但被关掉。
* 持久：每一步之后在 finally 里整份重写 traj.json；只记对话，不记判断。
* 续行：三种上限在调模型之前查；连续格式错误 3 次由循环自己写 exit；停止只看最后一条消息的 role；模型无法直接停。

## 2026-08-29 — card 00, scaffold

Built the repository skeleton and the mechanism the rest of it depends on.

- Directory conventions: `repos/` for pinned targets, `study/<repo>/` for
  per-repository artifacts, `points/` for technical points, `scripts/` for
  tooling, plus `matrix.md` and this log.
- Anchor checking: `scripts/check_anchors.py` reads `path:line` references and
  commit hashes out of the artifacts and proves each one resolves at the commit
  its target repository is pinned to. `make check` is the one command.
- Pinning: `repos/pins.tsv` plus `scripts/pin.sh`. Full clones, `HEAD` detached
  at the pinned commit, history retained on purpose — see `repos/README.md`.
- Demonstrated the pin with mini-swe-agent at
  `mini-swe-agent@25941c89cfbc91eb40b3f8756348c91d9977d57e` — 1020 commits
  reachable from the pin, 1489 across all refs in the clone. Confirmed that
  `git log -S`, `git log -L` and `git blame` all answer offline against the
  clone, including across the `microsweagent` → `minisweagent` rename.
- Seeded `study/mini-swe-agent/00-pin-demo.md` (15 verified anchors) and
  `points/001-control-flow-via-exceptions.md` so the conventions have a worked
  example rather than only a specification.

Then ran an adversarial review over the scaffold — six dimensions, each finding
independently re-derived by a skeptic told to refute it. 18 findings survived.
The two that mattered:

- **The checker could fail open.** Fence tracking normalised every opening fence
  to three characters, so a longer fence quoting a shorter one — the ordinary
  way to write about fence syntax, and unavoidable when the subject is a harness
  whose action protocol *is* a fenced block — desynced the scanner and swallowed
  the rest of the file. A deliberately wrong anchor after that point exited 0.
  Fixed by tracking the opener verbatim, plus a backstop: an unclosed fence is
  now reported rather than silently skipping to EOF.
- **The prose was wrong while every anchor resolved.** `points/001` claimed a
  raise site decides that a run stops. It does not: it decides only what the
  transcript records, and 6 of 15 control-flow raise sites carry `role: "user"`
  and do not stop anything. Worse, the note asserted the semantics that
  `mini-swe-agent@10dfc4ea` — the commit it cites as the reversal — removed.
  Rewritten, and the limitation is now stated in the README: an anchor proves a
  location, never a claim.

Also fixed: `pin.sh` recorded an annotated tag's tag object instead of its
commit (permanent phantom "drifted"), and silently pinned the remote's HEAD when
a ref failed to resolve — both silent wrong-pin bugs in a tool whose only job is
pinning. The selftest grew from 15 assertions to 31 and now asserts *how much*
was scanned, not just the codes; 10 of 10 deliberate mutations of the checker
are caught, where the count-blind version missed one.

Carried forward: points 002–005 in `matrix.md` are unread.
