---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
title: mini-swe-agent 定位地图
---

# mini-swe-agent 定位地图

本文件只回答“在哪”，逐条给出 `路径:行号`，不做解读。

- 目标仓库与钉住提交写在 front matter 里，权威副本是 `repos/pins.tsv`
- 本次运行的 agent 类：`minisweagent.agents.interactive.InteractiveAgent`，其基类为 `minisweagent.agents.default.DefaultAgent`
- 路径相对目标仓库根目录，行号对应 front matter 里的钉住提交
- 锚点写法：`说明 · 路径:行号 — 该行原文`；区间写作 `路径:起-止`，原文取起始行
- 该行原文只是附注，不参与校验；`make check` 校验的是锚点本身
- `make sync` 把钉住的仓库拉到 `repos/mini-swe-agent/`，`make check` 逐条校验锚点
- 某处机制不存在时写“没有”，不做推测

## 问1：主循环入口在哪

### 基类 DefaultAgent

- 循环所在方法 · `src/minisweagent/agents/default.py:88-124` — `def run(self, task: str = "", **kwargs) -> dict:`
- 主循环 · `src/minisweagent/agents/default.py:96` — `while True:`
- 每轮调用单步 · `src/minisweagent/agents/default.py:98` — `self.step()`
- 单步 · `src/minisweagent/agents/default.py:126-128` — `def step(self) -> list[dict]:`
- 单步组成 · `src/minisweagent/agents/default.py:128` — `return self.execute_actions(self.query())`

### InteractiveAgent 不同处

- 覆写 `run` 或另起一套循环：没有
- 覆写单步 · `src/minisweagent/agents/interactive.py:109-122` — `def step(self) -> list[dict]:`
- 转交基类单步 · `src/minisweagent/agents/interactive.py:113` — `return super().step()`
- 覆写取指令 · `src/minisweagent/agents/interactive.py:58-94` — `def query(self) -> dict:`
- human 模式分支 · `src/minisweagent/agents/interactive.py:60` — `if self.config.mode == "human":`
- human 模式读用户输入 · `src/minisweagent/agents/interactive.py:61` — `match command := self._prompt_and_handle_slash_commands("[bold yellow]>[/bold yellow] "):`
- 非 human 模式转交基类 · `src/minisweagent/agents/interactive.py:74` — `return super().query()`

### 进程入口（两者共用）

- 命令行入口点 · `pyproject.toml:90` — `mini = "minisweagent.run.mini:app"`
- python -m 入口 · `src/minisweagent/__main__.py:4` — `from minisweagent.run.mini import app`
- 命令行主函数 · `src/minisweagent/run/mini.py:55-105` — `def main(`
- 选定 agent 类 · `src/minisweagent/run/mini.py:101` — `agent = get_agent(model, env, config.get("agent", {}), default_type="interactive")`
- 进入主循环 · `src/minisweagent/run/mini.py:102` — `agent.run(run_task)`
- interactive 的类映射 · `src/minisweagent/agents/__init__.py:10` — `"interactive": "minisweagent.agents.interactive.InteractiveAgent",`

## 问2：工具调用在哪里被校验和分发

### 基类 DefaultAgent

- 工具声明 · `src/minisweagent/models/utils/actions_toolcall.py:11-27` — `BASH_TOOL = {`
- 工具随请求下发 · `src/minisweagent/models/litellm_model.py:69` — `tools=[BASH_TOOL],`
- 解析入口 · `src/minisweagent/models/litellm_model.py:89` — `actions = self._parse_actions(response)`
- 解析实现 · `src/minisweagent/models/litellm_model.py:128-135` — `def _parse_actions(self, response) -> list[dict]:`
- 校验：工具调用 · `src/minisweagent/models/utils/actions_toolcall.py:30-76` — `def parse_toolcall_actions(`
- 校验：无工具调用 · `src/minisweagent/models/utils/actions_toolcall.py:40` — `if not tool_calls:`
- 校验：工具名 · `src/minisweagent/models/utils/actions_toolcall.py:61` — `if tool_call.function.name != "bash":`
- 校验：参数 · `src/minisweagent/models/utils/actions_toolcall.py:63` — `if not isinstance(args, dict) or "command" not in args:`
- 校验不过则抛出 · `src/minisweagent/models/utils/actions_toolcall.py:66` — `raise FormatError(`
- 校验：文本模式 · `src/minisweagent/models/utils/actions_text.py:15-40` — `def parse_regex_actions(`
- 校验：动作条数 · `src/minisweagent/models/utils/actions_text.py:25` — `if len(actions) != 1:`
- 分发入口 · `src/minisweagent/agents/default.py:154-157` — `def execute_actions(self, message: dict) -> list[dict]:`
- 逐条交给环境执行 · `src/minisweagent/agents/default.py:156` — `outputs = [self.env.execute(action) for action in message.get("extra", {}).get("actions", [])]`
- 环境侧执行 · `src/minisweagent/environments/local.py:24-43` — `def execute(self, action: dict, cwd: str = "", *, timeout: int | None = None) -> dict[str, Any]:`
- 落到子进程 · `src/minisweagent/environments/local.py:72-91` — `def _run(command: str, cwd: str, env: dict[str, str], timeout: int) -> subprocess.CompletedProcess[str]:`
- 选定环境类 · `src/minisweagent/environments/__init__.py:30` — `def get_environment(config: dict, *, default_type: str = "") -> Environment:`
- 基类在分发前对命令内容做准入或白名单判断：没有

### InteractiveAgent 不同处

- 覆写分发 · `src/minisweagent/agents/interactive.py:124-139` — `def execute_actions(self, message: dict) -> list[dict]:`
- 分发前的确认关卡 · `src/minisweagent/agents/interactive.py:130` — `self._ask_confirmation_or_interrupt(commands)`
- 逐条交给环境执行 · `src/minisweagent/agents/interactive.py:132` — `outputs.append(self.env.execute(action))`
- 白名单判断 · `src/minisweagent/agents/interactive.py:162-163` — `def _should_ask_confirmation(self, action: str) -> bool:`
- 白名单正则匹配 · `src/minisweagent/agents/interactive.py:163` — `return self.config.mode == "confirm" and not any(re.match(r, action) for r in self.config.whitelist_actions)`
- 确认提示与拒绝 · `src/minisweagent/agents/interactive.py:165-182` — `def _ask_confirmation_or_interrupt(self, commands: list[str]) -> None:`
- 读用户裁决 · `src/minisweagent/agents/interactive.py:173` — `match user_input := self._prompt_and_handle_slash_commands(prompt).strip():`
- 配置：确认模式 · `src/minisweagent/agents/interactive.py:25` — `mode: Literal["human", "confirm", "yolo"] = "confirm"`
- 配置：白名单 · `src/minisweagent/agents/interactive.py:27` — `whitelist_actions: list[str] = []`
- human 模式的动作直接成型 · `src/minisweagent/agents/interactive.py:68` — `"extra": {"actions": [{"command": command}]},`
- 覆写模型层的工具校验：没有

## 问3：会话或轨迹被写到哪

### 基类 DefaultAgent

- 落盘方法 · `src/minisweagent/agents/default.py:182-190` — `def save(self, path: Path | None, *extra_dicts) -> dict:`
- 有路径才写 · `src/minisweagent/agents/default.py:187` — `if path:`
- 建目录 · `src/minisweagent/agents/default.py:188` — `path.parent.mkdir(parents=True, exist_ok=True)`
- 写文件 · `src/minisweagent/agents/default.py:189` — `path.write_text(json.dumps(data, indent=2))`
- 组装内容 · `src/minisweagent/agents/default.py:159-180` — `def serialize(self, *extra_dicts) -> dict:`
- 消息全文进入内容 · `src/minisweagent/agents/default.py:177` — `"messages": self.messages,`
- 轨迹格式标识 · `src/minisweagent/agents/default.py:178` — `"trajectory_format": "mini-swe-agent-1.1",`
- 写盘时机 · `src/minisweagent/agents/default.py:120-121` — `finally:`
- 写盘调用点 · `src/minisweagent/agents/default.py:121` — `self.save(self.config.output_path)`
- 配置：输出路径 · `src/minisweagent/agents/default.py:34` — `output_path: Path | None = None`

### InteractiveAgent 不同处

- 覆写 `save`、`serialize` 或输出路径：没有
- 覆写消息记录 · `src/minisweagent/agents/interactive.py:43-56` — `def add_messages(self, *messages: dict) -> list[dict]:`
- 终端打印正文 · `src/minisweagent/agents/interactive.py:55` — `console.print(content, highlight=False, markup=False)`

### 落盘路径与日志文件（两者共用）

- 默认轨迹文件 · `src/minisweagent/run/mini.py:23` — `DEFAULT_OUTPUT_FILE = global_config_dir / "last_mini_run.traj.json"`
- 默认目录 · `src/minisweagent/__init__.py:26` — `global_config_dir = Path(os.getenv("MSWEA_GLOBAL_CONFIG_DIR") or user_config_dir("mini-swe-agent"))`
- 命令行覆盖输出路径 · `src/minisweagent/run/mini.py:64` — `output: Path | None = typer.Option(DEFAULT_OUTPUT_FILE, "-o", "--output", help="Output trajectory file"),`
- 传给 agent 配置 · `src/minisweagent/run/mini.py:82` — `"output_path": output or UNSET,`
- 运行结束打印落盘位置 · `src/minisweagent/run/mini.py:104` — `console.print(f"Saved trajectory to [bold green]'{output_path}'[/bold green]")`
- 日志文件处理器 · `src/minisweagent/utils/log.py:21-29` — `def add_file_handler(path: Path | str, level: int = logging.DEBUG, *, print_path: bool = True) -> None:`
- 基准入口挂日志文件 · `src/minisweagent/run/benchmarks/swebench.py:220` — `add_file_handler(output_path / "minisweagent.log")`
- 基准入口挂日志文件 · `src/minisweagent/run/benchmarks/programbench.py:141` — `add_file_handler(output_path / "minisweagent.log")`
- `mini` 入口调用 `add_file_handler`：没有

## 问4：循环在哪里判定停止

### 基类 DefaultAgent

- 停止判定 · `src/minisweagent/agents/default.py:122` — `if self.messages[-1].get("role") == "exit":`
- 跳出主循环 · `src/minisweagent/agents/default.py:123` — `break`
- 循环外返回 · `src/minisweagent/agents/default.py:124` — `return self.messages[-1].get("extra", {})`
- 步数与花费上限 · `src/minisweagent/agents/default.py:132-139` — `if 0 < self.config.step_limit <= self.n_calls or 0 < self.config.cost_limit <= self.cost:`
- 上限抛出 · `src/minisweagent/agents/default.py:133` — `raise LimitsExceeded(`
- 墙钟上限 · `src/minisweagent/agents/default.py:140-147` — `if 0 < self.config.wall_time_limit_seconds <= int(time.time() - self._start_time):`
- 超时抛出 · `src/minisweagent/agents/default.py:141` — `raise TimeExceeded(`
- 连续格式错误上限 · `src/minisweagent/agents/default.py:104-112` — `if 0 < self.config.max_consecutive_format_errors <= self.n_consecutive_format_errors:`
- 格式错误的退出消息 · `src/minisweagent/agents/default.py:109` — `"content": "RepeatedFormatError",`
- 未捕获异常 · `src/minisweagent/agents/default.py:117` — `except Exception as e:`
- 未捕获异常向外抛 · `src/minisweagent/agents/default.py:119` — `raise`
- 未捕获异常写退出消息 · `src/minisweagent/agents/default.py:74-86` — `def handle_uncaught_exception(self, e: Exception) -> list[dict]:`
- 环境侧完成判定 · `src/minisweagent/environments/local.py:45-56` — `def _check_finished(self, output: dict):`
- 完成口令 · `src/minisweagent/environments/local.py:48` — `if lines and lines[0].strip() == "COMPLETE_TASK_AND_SUBMIT_FINAL_OUTPUT" and output["returncode"] == 0:`
- 完成抛出 · `src/minisweagent/environments/local.py:50` — `raise Submitted(`
- 完成异常 · `src/minisweagent/exceptions.py:9` — `class Submitted(InterruptAgentFlow):`
- 完成消息并回主循环 · `src/minisweagent/agents/default.py:115-116` — `except InterruptAgentFlow as e:`
- 上限异常 · `src/minisweagent/exceptions.py:13` — `class LimitsExceeded(InterruptAgentFlow):`
- 超时异常 · `src/minisweagent/exceptions.py:17` — `class TimeExceeded(LimitsExceeded):`

### InteractiveAgent 不同处

- 覆写 `run` 里的停止判定与跳出：没有
- 接住超时 · `src/minisweagent/agents/interactive.py:75-79` — `except TimeExceeded:`
- 接住上限 · `src/minisweagent/agents/interactive.py:80-94` — `except LimitsExceeded:`
- 终端可用性判断 · `src/minisweagent/agents/interactive.py:81` — `if not self._stdin_is_interactive():`
- 无终端时向外抛 · `src/minisweagent/agents/interactive.py:87` — `raise`
- 当场抬高步数上限 · `src/minisweagent/agents/interactive.py:92` — `self.config.step_limit = int(input("New step limit: "))`
- 当场抬高花费上限 · `src/minisweagent/agents/interactive.py:93` — `self.config.cost_limit = float(input("New cost limit: "))`
- 接住完成 · `src/minisweagent/agents/interactive.py:133` — `except Submitted as e:`
- 完成前先问用户 · `src/minisweagent/agents/interactive.py:144-160` — `def _check_for_new_task_or_submit(self, e: Submitted) -> NoReturn:`
- 是否需要确认 · `src/minisweagent/agents/interactive.py:146` — `if self.config.confirm_exit:`
- 新任务分支 · `src/minisweagent/agents/interactive.py:159` — `self._interrupt(f"The user added a new task: {user_input}", itype="UserNewTask")`
- 放行原异常 · `src/minisweagent/agents/interactive.py:160` — `raise e`
- 接住键盘中断 · `src/minisweagent/agents/interactive.py:114` — `except KeyboardInterrupt:`
- 中断转为消息 · `src/minisweagent/agents/interactive.py:122` — `self._interrupt(f"Interrupted by user: {interruption_message}")`
- 中断异常 · `src/minisweagent/agents/interactive.py:40-41` — `def _interrupt(self, content: str, *, itype: str = "UserInterruption") -> NoReturn:`

