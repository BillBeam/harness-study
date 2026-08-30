---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
title: mini-swe-agent 两圈七步定位
---

# mini-swe-agent 两圈七步定位

本文件只回答“在哪”，逐条给出 `路径:行号`，不做解读。

- 两圈取自 `study/mini-swe-agent/trace/mini.traj.json`
- 第二圈：assistant 发出三个 tool_calls 那圈，messages 第 4 条，观察落在第 5、6、7 条
- 最后一圈：发出提交口令那圈，messages 第 14 条，观察落在第 15 条，第 16 条 role 为 exit
- 本次运行的 agent 类：`minisweagent.agents.interactive.InteractiveAgent`，其基类为 `minisweagent.agents.default.DefaultAgent`；模型类 `minisweagent.models.litellm_model.LitellmModel`；环境类 `minisweagent.environments.local.LocalEnvironment`
- 七步依次为：上下文组装、模型调用、输出解析、判决、执行、记录、是否继续
- 路径相对目标仓库根目录，行号对应 front matter 里的钉住提交
- 锚点写法：`说明 · 路径:行号 — 该行原文`；区间写作 `路径:起-止`，原文取起始行
- 该行原文只是附注，不参与校验；`make check` 校验的是锚点本身
- `make sync` 把钉住的仓库拉到 `repos/mini-swe-agent/`，`make check` 逐条校验锚点

## 第二圈：assistant 发出三个 tool_calls

### 一、上下文组装

- 单步组成 · `src/minisweagent/agents/default.py:128` — `return self.execute_actions(self.query())`
- 覆写取指令 · `src/minisweagent/agents/interactive.py:58-94` — `def query(self) -> dict:`
- 转交基类取指令 · `src/minisweagent/agents/interactive.py:74` — `return super().query()`
- 基类取指令 · `src/minisweagent/agents/default.py:130-152` — `def query(self) -> dict:`
- 整段 messages 作为入参 · `src/minisweagent/agents/default.py:149` — `message = self.model.query(self.messages)`
- 请求前处理消息 · `src/minisweagent/models/litellm_model.py:76-79` — `def _prepare_messages_for_api(self, messages: list[dict]) -> list[dict]:`
- 剥掉 extra 字段 · `src/minisweagent/models/litellm_model.py:77` — `prepared = [{k: v for k, v in msg.items() if k != "extra"} for msg in messages]`
- 重排 thinking 块 · `src/minisweagent/models/litellm_model.py:78` — `prepared = _reorder_anthropic_thinking_blocks(prepared)`
- 缓存标记 · `src/minisweagent/models/litellm_model.py:79` — `return set_cache_control(prepared, mode=self.config.set_cache_control)`
- messages 进请求体 · `src/minisweagent/models/litellm_model.py:68` — `messages=messages,`
- 工具声明进请求体 · `src/minisweagent/models/litellm_model.py:69` — `tools=[BASH_TOOL],`
- 工具声明本体 · `src/minisweagent/models/utils/actions_toolcall.py:11-27` — `BASH_TOOL = {`

### 二、模型调用

- 计一次调用 · `src/minisweagent/agents/default.py:148` — `self.n_calls += 1`
- 等待期间的终端提示 · `src/minisweagent/agents/interactive.py:73` — `with console.status("Waiting for the LM to respond..."):`
- 模型层入口 · `src/minisweagent/models/litellm_model.py:81-106` — `def query(self, messages: list[dict[str, str]], **kwargs) -> dict:`
- 重试外壳 · `src/minisweagent/models/litellm_model.py:82` — `for attempt in retry(logger=logger, abort_exceptions=self.abort_exceptions):`
- 发出请求 · `src/minisweagent/models/litellm_model.py:84` — `response = self._query(self._prepare_messages_for_api(messages), **kwargs)`
- 接口调用 · `src/minisweagent/models/litellm_model.py:64-71` — `def _query(self, messages: list[dict[str, str]], **kwargs):`
- 落到 litellm · `src/minisweagent/models/litellm_model.py:66` — `return litellm.completion(`
- 算这次花费 · `src/minisweagent/models/litellm_model.py:85` — `cost_output = self._calculate_cost(response)`

### 三、输出解析

- 解析入口 · `src/minisweagent/models/litellm_model.py:89` — `actions = self._parse_actions(response)`
- 解析实现 · `src/minisweagent/models/litellm_model.py:128-135` — `def _parse_actions(self, response) -> list[dict]:`
- 取出 tool_calls · `src/minisweagent/models/litellm_model.py:130` — `tool_calls = response.choices[0].message.tool_calls or []`
- 解析与校验 · `src/minisweagent/models/utils/actions_toolcall.py:30-76` — `def parse_toolcall_actions(`
- 逐条工具调用 · `src/minisweagent/models/utils/actions_toolcall.py:54` — `for tool_call in tool_calls:`
- 解参数 JSON · `src/minisweagent/models/utils/actions_toolcall.py:58` — `args = json.loads(tool_call.function.arguments)`
- 三条动作成型 · `src/minisweagent/models/utils/actions_toolcall.py:75` — `actions.append({"command": args["command"], "tool_call_id": tool_call.id})`
- 响应转消息 · `src/minisweagent/models/litellm_model.py:99` — `message = response.choices[0].message.model_dump()`
- 挂上 extra · `src/minisweagent/models/litellm_model.py:100-105` — `message["extra"] = {`

### 四、判决

- 校验：无工具调用 · `src/minisweagent/models/utils/actions_toolcall.py:40` — `if not tool_calls:`
- 校验：工具名 · `src/minisweagent/models/utils/actions_toolcall.py:61` — `if tool_call.function.name != "bash":`
- 校验：参数 · `src/minisweagent/models/utils/actions_toolcall.py:63` — `if not isinstance(args, dict) or "command" not in args:`
- 校验：汇总 · `src/minisweagent/models/utils/actions_toolcall.py:65` — `if error_msg:`
- 校验不过则抛出 · `src/minisweagent/models/utils/actions_toolcall.py:66` — `raise FormatError(`
- 执行前的确认关卡 · `src/minisweagent/agents/interactive.py:130` — `self._ask_confirmation_or_interrupt(commands)`
- 关卡实现 · `src/minisweagent/agents/interactive.py:165-182` — `def _ask_confirmation_or_interrupt(self, commands: list[str]) -> None:`
- 无需确认则直接返回 · `src/minisweagent/agents/interactive.py:166` — `if not any(self._should_ask_confirmation(c) for c in commands):`
- 是否需要确认 · `src/minisweagent/agents/interactive.py:162-163` — `def _should_ask_confirmation(self, action: str) -> bool:`
- 确认模式与白名单 · `src/minisweagent/agents/interactive.py:163` — `return self.config.mode == "confirm" and not any(re.match(r, action) for r in self.config.whitelist_actions)`

### 五、执行

- 覆写分发 · `src/minisweagent/agents/interactive.py:124-139` — `def execute_actions(self, message: dict) -> list[dict]:`
- 取出动作 · `src/minisweagent/agents/interactive.py:126` — `actions = message.get("extra", {}).get("actions", [])`
- 取出命令 · `src/minisweagent/agents/interactive.py:127` — `commands = [action["command"] for action in actions]`
- 输出列表 · `src/minisweagent/agents/interactive.py:128` — `outputs = []`
- 逐条 · `src/minisweagent/agents/interactive.py:131` — `for action in actions:`
- 交给环境 · `src/minisweagent/agents/interactive.py:132` — `outputs.append(self.env.execute(action))`
- 环境侧执行 · `src/minisweagent/environments/local.py:24-43` — `def execute(self, action: dict, cwd: str = "", *, timeout: int | None = None) -> dict[str, Any]:`
- 取命令 · `src/minisweagent/environments/local.py:26` — `command = action.get("command", "")`
- 起子进程 · `src/minisweagent/environments/local.py:29` — `result = _run(command, cwd, os.environ | self.config.env, timeout or self.config.timeout)`
- 组装输出 · `src/minisweagent/environments/local.py:30` — `output = {"output": result.stdout, "returncode": result.returncode, "exception_info": ""}`
- 子进程实现 · `src/minisweagent/environments/local.py:72-91` — `def _run(command: str, cwd: str, env: dict[str, str], timeout: int) -> subprocess.CompletedProcess[str]:`
- 落到 Popen · `src/minisweagent/environments/local.py:74` — `process = subprocess.Popen(`
- 每条输出过一次口令检查 · `src/minisweagent/environments/local.py:42` — `self._check_finished(output)`
- 返回输出 · `src/minisweagent/environments/local.py:43` — `return output`

### 六、记录

- 模型消息进 messages · `src/minisweagent/agents/default.py:151` — `self.add_messages(message)`
- 观察消息在 finally 里生成 · `src/minisweagent/agents/interactive.py:135` — `finally:`
- 生成并追加 · `src/minisweagent/agents/interactive.py:136-138` — `result = self.add_messages(`
- 模型层渲染观察 · `src/minisweagent/models/litellm_model.py:140-151` — `def format_observation_messages(`
- 取动作列表 · `src/minisweagent/models/litellm_model.py:144` — `actions = message.get("extra", {}).get("actions", [])`
- 转交工具调用版 · `src/minisweagent/models/litellm_model.py:145` — `return format_toolcall_observation_messages(`
- 渲染实现 · `src/minisweagent/models/utils/actions_toolcall.py:79-113` — `def format_toolcall_observation_messages(`
- 动作与输出配对 · `src/minisweagent/models/utils/actions_toolcall.py:91` — `for action, output in zip(actions, padded_outputs):`
- 用模板渲染正文 · `src/minisweagent/models/utils/actions_toolcall.py:92-94` — `content = Template(observation_template, undefined=StrictUndefined).render(`
- 消息本体 · `src/minisweagent/models/utils/actions_toolcall.py:95-104` — `msg = {`
- extra 字段 · `src/minisweagent/models/utils/actions_toolcall.py:97-103` — `"extra": {`
- 有 tool_call_id 的分支 · `src/minisweagent/models/utils/actions_toolcall.py:105` — `if "tool_call_id" in action:`
- 写入 tool_call_id · `src/minisweagent/models/utils/actions_toolcall.py:106` — `msg["tool_call_id"] = action["tool_call_id"]`
- 写入 tool 角色 · `src/minisweagent/models/utils/actions_toolcall.py:107` — `msg["role"] = "tool"`
- 覆写消息记录 · `src/minisweagent/agents/interactive.py:43-56` — `def add_messages(self, *messages: dict) -> list[dict]:`
- 转交基类记录 · `src/minisweagent/agents/interactive.py:56` — `return super().add_messages(*messages)`
- 基类记录 · `src/minisweagent/agents/default.py:69-72` — `def add_messages(self, *messages: dict) -> list[dict]:`
- 追加进 messages · `src/minisweagent/agents/default.py:71` — `self.messages.extend(messages)`
- 每圈落盘时机 · `src/minisweagent/agents/default.py:120` — `finally:`
- 落盘调用点 · `src/minisweagent/agents/default.py:121` — `self.save(self.config.output_path)`
- 落盘方法 · `src/minisweagent/agents/default.py:182-190` — `def save(self, path: Path | None, *extra_dicts) -> dict:`
- 写文件 · `src/minisweagent/agents/default.py:189` — `path.write_text(json.dumps(data, indent=2))`
- 组装内容 · `src/minisweagent/agents/default.py:159-180` — `def serialize(self, *extra_dicts) -> dict:`
- 消息全文进入内容 · `src/minisweagent/agents/default.py:177` — `"messages": self.messages,`

### 七、是否继续

- 干净一步后清零连续格式错误计数 · `src/minisweagent/agents/default.py:99` — `self.n_consecutive_format_errors = 0  # reset on any clean step`
- 停止判定 · `src/minisweagent/agents/default.py:122` — `if self.messages[-1].get("role") == "exit":`
- 跳出主循环 · `src/minisweagent/agents/default.py:123` — `break`
- 回到主循环 · `src/minisweagent/agents/default.py:96` — `while True:`
- 调模型前的步数与花费上限 · `src/minisweagent/agents/default.py:132-139` — `if 0 < self.config.step_limit <= self.n_calls or 0 < self.config.cost_limit <= self.cost:`
- 调模型前的墙钟上限 · `src/minisweagent/agents/default.py:140-147` — `if 0 < self.config.wall_time_limit_seconds <= int(time.time() - self._start_time):`

## 最后一圈：发出提交口令

### 一、上下文组装

- 单步组成 · `src/minisweagent/agents/default.py:128` — `return self.execute_actions(self.query())`
- 覆写取指令 · `src/minisweagent/agents/interactive.py:58-94` — `def query(self) -> dict:`
- 转交基类取指令 · `src/minisweagent/agents/interactive.py:74` — `return super().query()`
- 基类取指令 · `src/minisweagent/agents/default.py:130-152` — `def query(self) -> dict:`
- 整段 messages 作为入参 · `src/minisweagent/agents/default.py:149` — `message = self.model.query(self.messages)`
- 请求前处理消息 · `src/minisweagent/models/litellm_model.py:76-79` — `def _prepare_messages_for_api(self, messages: list[dict]) -> list[dict]:`
- 剥掉 extra 字段 · `src/minisweagent/models/litellm_model.py:77` — `prepared = [{k: v for k, v in msg.items() if k != "extra"} for msg in messages]`
- 缓存标记 · `src/minisweagent/models/litellm_model.py:79` — `return set_cache_control(prepared, mode=self.config.set_cache_control)`
- messages 进请求体 · `src/minisweagent/models/litellm_model.py:68` — `messages=messages,`
- 工具声明进请求体 · `src/minisweagent/models/litellm_model.py:69` — `tools=[BASH_TOOL],`
- 工具声明本体 · `src/minisweagent/models/utils/actions_toolcall.py:11-27` — `BASH_TOOL = {`

### 二、模型调用

- 计一次调用 · `src/minisweagent/agents/default.py:148` — `self.n_calls += 1`
- 等待期间的终端提示 · `src/minisweagent/agents/interactive.py:73` — `with console.status("Waiting for the LM to respond..."):`
- 模型层入口 · `src/minisweagent/models/litellm_model.py:81-106` — `def query(self, messages: list[dict[str, str]], **kwargs) -> dict:`
- 重试外壳 · `src/minisweagent/models/litellm_model.py:82` — `for attempt in retry(logger=logger, abort_exceptions=self.abort_exceptions):`
- 发出请求 · `src/minisweagent/models/litellm_model.py:84` — `response = self._query(self._prepare_messages_for_api(messages), **kwargs)`
- 接口调用 · `src/minisweagent/models/litellm_model.py:64-71` — `def _query(self, messages: list[dict[str, str]], **kwargs):`
- 落到 litellm · `src/minisweagent/models/litellm_model.py:66` — `return litellm.completion(`
- 算这次花费 · `src/minisweagent/models/litellm_model.py:85` — `cost_output = self._calculate_cost(response)`

### 三、输出解析

- 解析入口 · `src/minisweagent/models/litellm_model.py:89` — `actions = self._parse_actions(response)`
- 解析实现 · `src/minisweagent/models/litellm_model.py:128-135` — `def _parse_actions(self, response) -> list[dict]:`
- 取出 tool_calls · `src/minisweagent/models/litellm_model.py:130` — `tool_calls = response.choices[0].message.tool_calls or []`
- 解析与校验 · `src/minisweagent/models/utils/actions_toolcall.py:30-76` — `def parse_toolcall_actions(`
- 逐条工具调用 · `src/minisweagent/models/utils/actions_toolcall.py:54` — `for tool_call in tool_calls:`
- 解参数 JSON · `src/minisweagent/models/utils/actions_toolcall.py:58` — `args = json.loads(tool_call.function.arguments)`
- 一条动作成型 · `src/minisweagent/models/utils/actions_toolcall.py:75` — `actions.append({"command": args["command"], "tool_call_id": tool_call.id})`
- 响应转消息 · `src/minisweagent/models/litellm_model.py:99` — `message = response.choices[0].message.model_dump()`
- 挂上 extra · `src/minisweagent/models/litellm_model.py:100-105` — `message["extra"] = {`

### 四、判决

- 校验：无工具调用 · `src/minisweagent/models/utils/actions_toolcall.py:40` — `if not tool_calls:`
- 校验：工具名 · `src/minisweagent/models/utils/actions_toolcall.py:61` — `if tool_call.function.name != "bash":`
- 校验：参数 · `src/minisweagent/models/utils/actions_toolcall.py:63` — `if not isinstance(args, dict) or "command" not in args:`
- 校验：汇总 · `src/minisweagent/models/utils/actions_toolcall.py:65` — `if error_msg:`
- 校验不过则抛出 · `src/minisweagent/models/utils/actions_toolcall.py:66` — `raise FormatError(`
- 执行前的确认关卡 · `src/minisweagent/agents/interactive.py:130` — `self._ask_confirmation_or_interrupt(commands)`
- 关卡实现 · `src/minisweagent/agents/interactive.py:165-182` — `def _ask_confirmation_or_interrupt(self, commands: list[str]) -> None:`
- 无需确认则直接返回 · `src/minisweagent/agents/interactive.py:166` — `if not any(self._should_ask_confirmation(c) for c in commands):`
- 是否需要确认 · `src/minisweagent/agents/interactive.py:162-163` — `def _should_ask_confirmation(self, action: str) -> bool:`
- 确认模式与白名单 · `src/minisweagent/agents/interactive.py:163` — `return self.config.mode == "confirm" and not any(re.match(r, action) for r in self.config.whitelist_actions)`

### 五、执行

- 覆写分发 · `src/minisweagent/agents/interactive.py:124-139` — `def execute_actions(self, message: dict) -> list[dict]:`
- 取出动作 · `src/minisweagent/agents/interactive.py:126` — `actions = message.get("extra", {}).get("actions", [])`
- 输出列表 · `src/minisweagent/agents/interactive.py:128` — `outputs = []`
- 逐条 · `src/minisweagent/agents/interactive.py:131` — `for action in actions:`
- 交给环境 · `src/minisweagent/agents/interactive.py:132` — `outputs.append(self.env.execute(action))`
- 环境侧执行 · `src/minisweagent/environments/local.py:24-43` — `def execute(self, action: dict, cwd: str = "", *, timeout: int | None = None) -> dict[str, Any]:`
- 取命令 · `src/minisweagent/environments/local.py:26` — `command = action.get("command", "")`
- 起子进程 · `src/minisweagent/environments/local.py:29` — `result = _run(command, cwd, os.environ | self.config.env, timeout or self.config.timeout)`
- 组装输出 · `src/minisweagent/environments/local.py:30` — `output = {"output": result.stdout, "returncode": result.returncode, "exception_info": ""}`
- 口令检查调用点 · `src/minisweagent/environments/local.py:42` — `self._check_finished(output)`
- 口令检查实现 · `src/minisweagent/environments/local.py:45-56` — `def _check_finished(self, output: dict):`
- 取输出各行 · `src/minisweagent/environments/local.py:47` — `lines = output.get("output", "").lstrip().splitlines(keepends=True)`
- 首行等于口令且返回码为 0 · `src/minisweagent/environments/local.py:48` — `if lines and lines[0].strip() == "COMPLETE_TASK_AND_SUBMIT_FINAL_OUTPUT" and output["returncode"] == 0:`
- 口令之后为提交内容 · `src/minisweagent/environments/local.py:49` — `submission = "".join(lines[1:])`
- 抛出 Submitted · `src/minisweagent/environments/local.py:50` — `raise Submitted(`
- 接住 Submitted · `src/minisweagent/agents/interactive.py:133` — `except Submitted as e:`
- 转交提交确认 · `src/minisweagent/agents/interactive.py:134` — `self._check_for_new_task_or_submit(e)`
- 提交确认实现 · `src/minisweagent/agents/interactive.py:144-160` — `def _check_for_new_task_or_submit(self, e: Submitted) -> NoReturn:`
- 是否需要确认 · `src/minisweagent/agents/interactive.py:146` — `if self.config.confirm_exit:`
- 放行原异常 · `src/minisweagent/agents/interactive.py:160` — `raise e`

### 六、记录

- 模型消息进 messages · `src/minisweagent/agents/default.py:151` — `self.add_messages(message)`
- 观察消息在 finally 里生成 · `src/minisweagent/agents/interactive.py:135` — `finally:`
- 生成并追加 · `src/minisweagent/agents/interactive.py:136-138` — `result = self.add_messages(`
- 模型层渲染观察 · `src/minisweagent/models/litellm_model.py:140-151` — `def format_observation_messages(`
- 渲染实现 · `src/minisweagent/models/utils/actions_toolcall.py:79-113` — `def format_toolcall_observation_messages(`
- 占位对象 · `src/minisweagent/models/utils/actions_toolcall.py:88` — `not_executed = {"output": "", "returncode": -1, "exception_info": "action was not executed"}`
- 用占位补齐 · `src/minisweagent/models/utils/actions_toolcall.py:89` — `padded_outputs = outputs + [not_executed] * (len(actions) - len(outputs))`
- 接住异常并追加自带消息 · `src/minisweagent/agents/default.py:115` — `except InterruptAgentFlow as e:`
- 追加调用点 · `src/minisweagent/agents/default.py:116` — `self.add_messages(*e.messages)`
- 基类记录 · `src/minisweagent/agents/default.py:69-72` — `def add_messages(self, *messages: dict) -> list[dict]:`
- 追加进 messages · `src/minisweagent/agents/default.py:71` — `self.messages.extend(messages)`
- 本圈落盘时机 · `src/minisweagent/agents/default.py:120` — `finally:`
- 落盘调用点 · `src/minisweagent/agents/default.py:121` — `self.save(self.config.output_path)`
- 组装内容 · `src/minisweagent/agents/default.py:159-180` — `def serialize(self, *extra_dicts) -> dict:`
- 退出状态进 info · `src/minisweagent/agents/default.py:174` — `"exit_status": last_extra.get("exit_status", ""),`
- 提交内容进 info · `src/minisweagent/agents/default.py:175` — `"submission": last_extra.get("submission", ""),`

### 七、是否继续

- 停止判定 · `src/minisweagent/agents/default.py:122` — `if self.messages[-1].get("role") == "exit":`
- 跳出主循环 · `src/minisweagent/agents/default.py:123` — `break`
- 循环外返回 · `src/minisweagent/agents/default.py:124` — `return self.messages[-1].get("extra", {})`

### 另标一：`returncode` 为 -1、内容为 `action was not executed` 的占位 tool 消息由哪段代码生成

- 输出列表在异常抛出前只收到 0 条 · `src/minisweagent/agents/interactive.py:128` — `outputs = []`
- 异常经过 finally · `src/minisweagent/agents/interactive.py:135` — `finally:`
- finally 里生成观察消息 · `src/minisweagent/agents/interactive.py:136-138` — `result = self.add_messages(`
- 模型层入口 · `src/minisweagent/models/litellm_model.py:140-151` — `def format_observation_messages(`
- 取动作列表 · `src/minisweagent/models/litellm_model.py:144` — `actions = message.get("extra", {}).get("actions", [])`
- 转交工具调用版 · `src/minisweagent/models/litellm_model.py:145` — `return format_toolcall_observation_messages(`
- 生成函数 · `src/minisweagent/models/utils/actions_toolcall.py:79-113` — `def format_toolcall_observation_messages(`
- 占位对象本体 · `src/minisweagent/models/utils/actions_toolcall.py:88` — `not_executed = {"output": "", "returncode": -1, "exception_info": "action was not executed"}`
- 动作数多于输出数时补齐 · `src/minisweagent/models/utils/actions_toolcall.py:89` — `padded_outputs = outputs + [not_executed] * (len(actions) - len(outputs))`
- 配对 · `src/minisweagent/models/utils/actions_toolcall.py:91` — `for action, output in zip(actions, padded_outputs):`
- 渲染正文 · `src/minisweagent/models/utils/actions_toolcall.py:92-94` — `content = Template(observation_template, undefined=StrictUndefined).render(`
- 消息本体 · `src/minisweagent/models/utils/actions_toolcall.py:95-104` — `msg = {`
- extra 字段 · `src/minisweagent/models/utils/actions_toolcall.py:97-103` — `"extra": {`
- 写入 tool_call_id · `src/minisweagent/models/utils/actions_toolcall.py:106` — `msg["tool_call_id"] = action["tool_call_id"]`
- 写入 tool 角色 · `src/minisweagent/models/utils/actions_toolcall.py:107` — `msg["role"] = "tool"`

### 另标二：role 为 `exit` 的消息由哪段代码构造、哪段代码追加进 `messages`

构造：

- 构造点 · `src/minisweagent/environments/local.py:50-56` — `raise Submitted(`
- role 字段 · `src/minisweagent/environments/local.py:52` — `"role": "exit",`
- content 字段 · `src/minisweagent/environments/local.py:53` — `"content": submission,`
- extra 字段 · `src/minisweagent/environments/local.py:54` — `"extra": {"exit_status": "Submitted", "submission": submission},`
- 异常类 · `src/minisweagent/exceptions.py:9` — `class Submitted(InterruptAgentFlow):`
- 基类 · `src/minisweagent/exceptions.py:1-6` — `class InterruptAgentFlow(Exception):`
- 消息挂在异常上 · `src/minisweagent/exceptions.py:5` — `self.messages = messages`
- 原异常经确认后放行 · `src/minisweagent/agents/interactive.py:160` — `raise e`

追加：

- 循环接住 · `src/minisweagent/agents/default.py:115` — `except InterruptAgentFlow as e:`
- 追加调用点 · `src/minisweagent/agents/default.py:116` — `self.add_messages(*e.messages)`
- 覆写消息记录 · `src/minisweagent/agents/interactive.py:43-56` — `def add_messages(self, *messages: dict) -> list[dict]:`
- 转交基类记录 · `src/minisweagent/agents/interactive.py:56` — `return super().add_messages(*messages)`
- 基类记录 · `src/minisweagent/agents/default.py:69-72` — `def add_messages(self, *messages: dict) -> list[dict]:`
- 追加进 messages · `src/minisweagent/agents/default.py:71` — `self.messages.extend(messages)`
