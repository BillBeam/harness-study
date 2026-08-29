---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
title: 怎么跑 mini-swe-agent
---

# 复跑

一条命令：

```
make run
```

等价于直接跑 `scripts/run_mini.sh`。

## 前提

- 环境变量 XAI_API_KEY 已设置。key 只从环境读，仓库里不存。
- 能联网。第一次跑要 clone 钉住的仓库、建 venv、装依赖、调模型 API；之后这几步是空转。

## 可调的环境变量

| 变量 | 默认 | 作用 |
| --- | --- | --- |
| MINI_API_KEY_VAR | XAI_API_KEY | 从哪个变量取 API key |
| MSWEA_MODEL_NAME | xai/grok-4.3 | 模型名 |
| MINI_COST_LIMIT | 1.0 | 花费上限，美元 |
| MINI_STEP_LIMIT | 40 | 步数上限 |
| MINI_WORK_DIR | mktemp 出来的临时目录 | 工作副本放哪 |

## 这条命令依次做什么

1. 把 mini-swe-agent 同步到 `repos/pins.tsv` 里钉住的提交。
2. 建 `.venv`，装钉住那份 pyproject 声明的依赖。不装 mini-swe-agent 本身，用 PYTHONPATH 从源码跑，
   所以 `repos/` 下的检出不会被构建产物弄脏。
3. 把 `study/mini-swe-agent/task/` 这三个文件复制成一份工作副本，`git init` 并提交一次基线。
   模板保持有 bug 的原样，所以可以反复跑。
4. 跑 agent：`-y` 免逐条确认，`--exit-immediately` 免退出确认，全程无人值守。
5. 打印 agent 改出来的 diff，再跑一遍测试。测试不过则命令以非零码退出。

跑 agent 那一步用 `env -i` 从空环境重建，只放行网络代理、CA、语言环境这几个变量名，再加上 API key
本身；agent 自己 shell 里的那个 key 也被置空。所以容器里其它凭据不会进到下面两个产物里。

## 产物

| 文件 | 是什么 |
| --- | --- |
| `study/mini-swe-agent/trace/mini.traj.json` | mini-swe-agent 自己写的会话文件 |
| `study/mini-swe-agent/trace/terminal.txt` | 这条命令的终端全文 |

会话文件是 mini-swe-agent 的 `-o` 输出，JSON，顶层三个键：`info`（模型统计、完整配置、版本、
退出状态、提交内容）、`messages`（整段对话，system / user / assistant / tool / exit 逐条）、
`trajectory_format`（本次是 mini-swe-agent-1.1）。它在每一步之后重写一次，所以中途断了也是全的。

两个文件都会被下一次 `make run` 覆盖。

## 这次跑到的

| 项 | 值 |
| --- | --- |
| 模型 | xai/grok-4.3 |
| pin | `25941c89cfbc91eb40b3f8756348c91d9977d57e` |
| mini-swe-agent | 2.4.6 |
| litellm / Python | 1.98.0 / 3.11.15 |
| 退出状态 | Submitted |
| 模型调用 | 6 次，约 0.0071 美元 |
| 结果 | 4 个测试全过 |
