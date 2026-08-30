# 日志

最新在前。一次会话一条：钉了什么、读了什么、读出了什么。

2026-08-30 —— 四问地图：读四个位置之后

按 map.md 的四个位置各读了前后 50 行，写下理解，参谋位逐条纠正。

1. 循环

我说：run 就是 agent loop，里面有退出情况——loop 执行完成，以及各种错误处理情况。

纠正：方向对，但"各种退出情况"这个说法会把最要紧的设计盖住。这个循环只认一件事：最后一条消息的 role 是不是 exit（mini-swe-agent@25941c89:src/minisweagent/agents/default.py:122）。所有你以为的"退出情况"——预算到了、口令出现了、连续三次格式错误——没有一个是直接跳出循环的，它们做的都是同一件事：往 messages 末尾追加一条 role 为 exit 的消息，然后由 122 行那一个判断收口。三条异常分支各自只负责"追加什么"：FormatError 分支（mini-swe-agent@25941c89:src/minisweagent/agents/default.py:100-114）先把这次调用记账（格式错了也要付钱），再数连续次数，没到上限就把模型的坏输出和一条解释错误的 user 消息一起追加、继续转，到了上限才追加 exit；InterruptAgentFlow 分支（mini-swe-agent@25941c89:src/minisweagent/agents/default.py:115-116）把异常自带的消息原样追加，带不带 exit 由抛出者决定；其余异常（mini-swe-agent@25941c89:src/minisweagent/agents/default.py:117-119）追加一条带 traceback 的 exit 消息后重新抛出——这是唯一不经过 122 行、被异常直接打断的出口。还有一句被忽略的：finally 里每圈都落盘一次（mini-swe-agent@25941c89:src/minisweagent/agents/default.py:120-121），不管这圈是正常、格式错还是被中断。另外"loop 执行完成"这个概念在循环里不存在——循环自己不知道什么叫完成，完成是环境认口令之后用一条 exit 消息告诉它的。

2. 校验与执行

我说：parse_toolcall_actions 校验模型输出的工具调用——是否存在工具、是否存在参数，有问题就重新包装成一条 user 消息返回给模型让它解决。execute 是执行工具，里面判断模型是否已确定执行完成，决定退出 loop。

纠正：前半句对，补一个位置和一个后果。校验发生在模型层，不在 agent 里：litellm_model 拿到接口响应后立刻解析（mini-swe-agent@25941c89:src/minisweagent/models/litellm_model.py:89），四道关——一个工具调用都没有（mini-swe-agent@25941c89:src/minisweagent/models/utils/actions_toolcall.py:40）、工具名不是 bash（mini-swe-agent@25941c89:src/minisweagent/models/utils/actions_toolcall.py:61）、参数不是 dict 或没有 command（mini-swe-agent@25941c89:src/minisweagent/models/utils/actions_toolcall.py:63）、任一不过就抛 FormatError（mini-swe-agent@25941c89:src/minisweagent/models/utils/actions_toolcall.py:66）。agent 的 query() 拿到的消息已经带着校验过的 extra.actions。把校验放在模型层的后果：换一种模型接法（文本模式用正则抠命令）校验方式跟着换，而 agent 循环一行不动——校验是模型适配器的责任，不是循环的责任。

后半句要改两处。一，execute 不判断"模型是否确定完成"，它判断的是"命令输出的第一行是不是口令、返回码是不是 0"（mini-swe-agent@25941c89:src/minisweagent/environments/local.py:48）——看的是输出，不是模型的意图。模型没有任何字段能表达"我完成了"，它只能让一条命令打印出那个字符串。二，execute 不决定退出，它只抛 Submitted（mini-swe-agent@25941c89:src/minisweagent/environments/local.py:50），Submitted 自带一条 exit 消息，退出仍然是第 1 条里那一行判断做的。环境能触发结束，但不拥有结束。

3. 落盘

我问：不太懂这里的落盘，是把整个 trace 整体存储吗？

解释：是，而且比"整体存储"更极端——每一圈之后把整个东西从头重写一遍。save（mini-swe-agent@25941c89:src/minisweagent/agents/default.py:182-190）调 serialize（mini-swe-agent@25941c89:src/minisweagent/agents/default.py:159-180），后者把配置、模型统计、退出状态、提交内容和完整的 messages 列表拼成一个 dict，整个 json.dumps 后覆盖写到 output_path。它在第 1 条说的 finally 里被调，所以每圈都写一次，写的是当前全量。三个后果：文件在任何时刻都等于"上一圈结束时的完整状态"，中途被 kill 也只丢最后一圈；写的量随圈数线性涨、总写入量平方涨，这里六圈无所谓，几百圈就不无所谓；它是快照不是日志——只有"现在是什么样"，没有"发生了什么"，看不出哪一圈改了什么。DeepSeek Harness 那种追加式事件日志是反过来的：每个事件写一次、从不重写。这会是矩阵里"持久独占：落盘方式"那一行的第一处差别。

4. 异常文件

我问：没太看懂作用，是什么时候会触发 agent 终止吗？

解释：这个文件定义的是"带着消息的异常"，它们是这个 harness 的控制流工具，不都是终止。基类 InterruptAgentFlow 的约定是：构造时塞进一条或多条消息，被循环接住后消息原样追加。它的三个子类各对应一个抛出者：Submitted（mini-swe-agent@25941c89:src/minisweagent/exceptions.py:9）由环境在认出口令时抛，消息以 exit 结尾；LimitsExceeded（mini-swe-agent@25941c89:src/minisweagent/exceptions.py:13）由 query() 在调模型之前抛，步数或花费到了（mini-swe-agent@25941c89:src/minisweagent/agents/default.py:132-139）；TimeExceeded（mini-swe-agent@25941c89:src/minisweagent/exceptions.py:17）是它的子类，墙钟到了（mini-swe-agent@25941c89:src/minisweagent/agents/default.py:140-147）。FormatError 单独一支，因为它要记账、要计数。所以"什么时候终止"的完整答案是：当且仅当一条 role 为 exit 的消息成为最后一条——它可以来自环境的口令、来自调模型前的预算检查、来自循环自己数到第三次格式错误、来自任何未捕获的异常；四个来源，一个出口。

这个层次结构的作用在 InteractiveAgent 里才看得出来：它在异常到达循环之前按子类拦截——TimeExceeded 在 mini-swe-agent@25941c89:src/minisweagent/agents/interactive.py:75 接住，LimitsExceeded 在 mini-swe-agent@25941c89:src/minisweagent/agents/interactive.py:80 接住并当场让用户抬高上限，Submitted 在 mini-swe-agent@25941c89:src/minisweagent/agents/interactive.py:133 接住先问用户要不要提交——拦下来就不终止，放行就终止。基类用一个 except 统一处理，子类给中间层留拦截点，这就是为什么要分成一棵树而不是一个异常。Go 里对应的是错误类型链加 errors.As：顶层统一处理，中间层按类型拦。

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

## 2026-08-29 —— 卡 00，脚手架

搭起仓库骨架，以及其余部分所依赖的那套机制。

- **目录约定**：`repos/` 放钉住的目标仓库，`study/<repo>/` 放单仓库产物，`points/` 放技术点，`scripts/` 放工具，外加 `matrix.md` 与本日志。
- **锚点校验**：`scripts/check_anchors.py` 从产物里读出 `路径:行号` 引用与提交哈希，逐条证明它们在目标仓库的钉住提交上仍能解析。`make check` 是那一条命令。
- **钉住机制**：`repos/pins.tsv` 加 `scripts/pin.sh`。全量克隆，`HEAD` detach 在钉住提交上，刻意保留历史——理由见 `repos/README.zh-CN.md`。
- 用 mini-swe-agent 做了演示，钉在 `mini-swe-agent@25941c89cfbc91eb40b3f8756348c91d9977d57e`——从 pin 可达 1020 个提交，克隆里所有 ref 共 1489 个。确认 `git log -S`、`git log -L` 和 `git blame` 都能离线对着克隆作答，包括跨 `microsweagent` → `minisweagent` 的改名。
- 播下 `study/mini-swe-agent/00-pin-demo.md`（15 条已校验锚点）与 `points/001-control-flow-via-exceptions.md`，让约定有一个实做的样例，而不只是一份规格。

随后对脚手架跑了一轮**对抗式审查**——六个维度，每条发现都由一个被要求证伪它的怀疑者独立复现。18 条成立。真正要紧的两条：

- **校验器会 fail-open。** 围栏跟踪把每个开围栏归一化成三个字符，于是"长围栏包短围栏"——写围栏语法时的常规做法，而当研读对象的动作协议本身**就是**一个围栏块时更是躲不开——会让扫描器失步并吞掉文件剩余部分。位于其后的故意写错的锚点退出码为 0。修法是原样保留开围栏标记，外加一道兜底：未闭合的围栏现在会被报出来，而不是静默跳到文件末尾。
- **锚点全部通过，而论断是错的。** `points/001` 声称抛出点决定一次运行是否停止。并非如此：它只决定对话记录里写什么，而 15 个控制流抛出点里有 6 个带 `role: "user"`，什么也不停。更糟的是，这篇笔记断言的正是 `mini-swe-agent@10dfc4ea`——它自己引用为"那次反转"的提交——所**移除**掉的语义。已重写，并把这条局限写进了 README：锚点证明位置，从不证明论断。

同时修掉的：`pin.sh` 会把 annotated tag 的 tag 对象而不是 commit 记进 pin（导致永久性的假 `drifted`），以及 ref 解析失败时静默回退到远端 HEAD——对一个唯一职责就是"钉住"的工具来说，这是两个静默钉错的缺陷。自测从 15 条断言长到 31 条，现在还断言**实际扫了多少**而不只是错误码；对校验器做的 10 次故意变异全部被抓到，而缺少计数断言的版本会漏掉其中一次。

- 补齐全部阅读文档的中文版（`*.zh-CN.md`）。`study/` 与 `points/` 下的中文笔记与英文笔记走同一套锚点校验，`matrix.zh-CN.md` 和 `LOG.zh-CN.md` 也已加入默认扫描目标。

后续待办：`matrix.md` 里的技术点 002–005 尚未阅读。
