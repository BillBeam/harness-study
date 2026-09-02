# 差分探针

同一个模型（xai / grok-4.3）、同一份任务模板，在 mini-swe-agent、dsh 默认组合（`--profile headless`，25 个工具）与 opencode 的 run 模式（`opencode run --auto`）上各跑一次，看各家在同一件事上各自做了什么。只记不评。

## 目录

```
tasks/<探针名>/        任务模板：这次跑的是哪个小仓库、任务文本怎么写
<探针名>/<仓库>/       那一次运行留下的东西：各家自己的会话记录，加终端全文
<探针名>/result.md     每家各一节，加这个探针撞见的卡外发现（opencode 的卡外发现在 study/opencode/map.md 末尾）
wrapper.sh             外部 wrapper：铺工作副本、起 harness、兜底、收产物
```

会话记录各按各家自己的形态留原样：mini-swe-agent 是它自己写的 `mini.traj.json`，dsh 是它自己写的会话日志目录（`session-persistence-jsonl`，不压缩，内容与默认的 zstd 完全相同，只是物理编码不同），opencode 是它的数据目录原样复制（`data/`：SQLite 库 `opencode.db`、`log/opencode.log`、快照 git 目录）加一份它自己 `opencode export` 出的 `session.export.json`。

## 四个探针

| 探针 | 做的事 |
| --- | --- |
| [kill](kill/result.md) | 一次工具执行进行中，对 harness 进程发 `kill -9`，再试各家自带的续跑方式 |
| [big-output](big-output/result.md) | 任务里一条命令输出 34352 个字符 |
| [edit](edit/result.md) | 目标行在文件里出现两次，只许改一处 |
| [unfinishable](unfinishable/result.md) | 一个做不完的任务，看谁把它停下来 |

## 怎么复跑

```
XAI_API_KEY=... study/probes/wrapper.sh <探针名> <仓库>
```

`<仓库>` 是 `mini-swe-agent`、`deepseek-harness` 或 `opencode`。key 只走环境变量，跑完 wrapper 会在产物里逐字节确认它没落进去。

wrapper 对每一次运行都加两条外部兜底：墙钟 480 秒（8 分钟）、步数 40 步；步数取自各家自己写下的记录（mini 数 `api_calls`，dsh 数 `step/end` 事件，opencode 数库里最新会话的 `step-start` 片段），不是 wrapper 另记一套。各家自己的上限一律保持原样——mini 有步数、花费、墙钟三种，dsh 的 headless 组合与 opencode 的 run 模式一种都没有——谁先停下就是谁先停下，终端全文最后一行写明是谁。

kill 探针里 wrapper 不用兜底：它等任务脚本自己放下的标记文件，确认工具执行确实进行中，再发 `kill -9`。

opencode 的续跑用 `OC_RESUME_SESSION=<会话 id> PROBE_KEEP_STATE=1 PROBE_NO_KILL=1 PROBE_TERMINAL_NAME=terminal-resume.txt` 再跑一次 wrapper，它会给 `opencode run` 加 `--session <会话 id>`；复制数据目录之前 wrapper 自己读过一次库，那次读会把 `-wal` 合并进主文件（见 [study/opencode/storage-map.md](../opencode/storage-map.md)）。
