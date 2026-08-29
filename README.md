# harness-study

对开源 agent 仓库做定位地图：只回答“在哪”，每条结论都落到 `路径:行号`，并与钉住提交逐行校验。

## 目录

- `study/mini-swe-agent/map.md` — 定位地图（四问：主循环入口、工具调用的校验与分发、会话与轨迹落盘、循环停止判定）
- `study/mini-swe-agent/pin.json` — 钉住的目标仓库与提交号
- `tools/check_map.py` — 锚点校验：文件、行号、该行原文三者都要对得上
- `tools/test_check_map.py` — 校验脚本自检，不联网

## 命令

- `make sync` — 按 `pin.json` 拉取目标仓库的只读副本到 `.upstream/`
- `make check` — 把地图里每条锚点与副本逐行比对
- `make selftest` — 自检校验脚本能否发现锚点漂移

目标仓库只读：这里只克隆和切提交，不改动其内容。
