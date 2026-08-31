# 大输出探针：一条命令吐出 34352 个字符

任务模板 `study/probes/tasks/big-output/`：跑 `python3 gen.py`，它印 702 行、共 34352 个字符，首行是开头令牌 ALPHA-7391、末行是结尾令牌 OMEGA-5520，中间 700 行流水。任务要求把这两个令牌写进 `answer.txt`，并明说只能从这次运行的输出里读、不许去看脚本源码推算。首尾各放一个令牌，是为了能看出被留下的是哪一段。

两家的任务文本、模型（xai / grok-4.3）、工作副本、环境变量白名单完全相同。wrapper 的兜底是墙钟 480 秒或 40 步，两次都没轮到。

---

## mini-swe-agent

记录：[终端全文](mini-swe-agent/terminal.txt) ｜ [会话记录 mini.traj.json](mini-swe-agent/mini.traj.json)

**发生了什么。** 第 1 步 `ls -la`；第 2 步跑 `python3 gen.py`。这一条的 observation 不是原文：它是一份 JSON，字段有 `returncode`、`output_head`、`elided_chars`（值 20132）、`warning`（"Output too long."）。这是提示词模板做的——observation 模板在原始输出长度小于 10000 时原样放进 `<output>`，否则改走另一支，印一段告诫，再放 `<output_head>`（前 5000 字符）、`<elided_chars>`（`长度 - 10000`）、`<output_tail>`（后 5000 字符）（[default.yaml:119](https://github.com/SWE-agent/mini-swe-agent/blob/25941c89cfbc91eb40b3f8756348c91d9977d57e/src/minisweagent/config/default.yaml#L119)、[default.yaml:131-140](https://github.com/SWE-agent/mini-swe-agent/blob/25941c89cfbc91eb40b3f8756348c91d9977d57e/src/minisweagent/config/default.yaml#L131-L140)）。因为是掐头留尾，**两个令牌都在这条 observation 里**：ALPHA-7391 在 head 段第一行，OMEGA-5520 在 tail 段最后一行。

第 3 步模型没有直接用已经看到的两个令牌，而是照告诫里那句"可以用 head、tail 或 sed 只看一小部分"重跑了一次：`python3 gen.py | head -n 1 | cut -d'：' -f2 > answer.txt && python3 gen.py | tail -n 1 | cut -d'：' -f2 >> answer.txt && cat answer.txt`。`cut` 因为分隔符是多字节的全角冒号而报错（"the delimiter must be a single character"），管道提前关闭又让 gen.py 抛了 BrokenPipeError。第 4 步换成 `sed 's/开头令牌：//'` 与 `sed 's/结尾令牌：//'`，成了。第 5 步收尾。

**步数。** 会话记录里 `api_calls` 是 5，`exit_status` 是 `Submitted`。整轮墙钟 13 秒。

**记录文件的最终状态。** `mini.traj.json` 85163 字节，13 条消息。存进文件的那条大 observation 就是掐过的那份（13869 字节），带 `output_head` / `elided_chars` / `warning` 三个字段；34352 字符的原文没有落在任何地方——被丢弃的 20132 个字符在这次运行里不存在第二份。

`answer.txt` 两行，ALPHA-7391 与 OMEGA-5520，与任务要求一致。

---

## deepseek-harness（默认组合）

记录：[终端全文](deepseek-harness/terminal.txt) ｜ [会话日志](deepseek-harness/sessions/--home-user-harness-study-.dsh-run-probe-big-output-workspace--/session-a409aa9f-7460-426b-a227-033f3f85eb43/session.jsonl)

**发生了什么。** 第 1 步 `bash` 跑 `python3 gen.py`。这一条 `tool/result` 里是**完整的 34352 个字符**，从"开头令牌：ALPHA-7391"一路到"结尾令牌：OMEGA-5520"，一行未删。第 2 步 `write` 直接把 `ALPHA-7391\nOMEGA-5520` 写进 `answer.txt`。第 3 步回话收尾。

**步数。** 会话日志里 `step/end` 事件 3 条。整轮墙钟 10 秒。

**记录文件的最终状态。** 会话日志 84713 字节。全部 7 条带 `surfaceOp` 的事件都是 `append`，一条 `replace` 也没有；`compaction`、`prune`、`spill` 相关事件一条都没有。也就是说日志与模型看见的"面"在这一轮完全重合，模型拿到的就是原文。

这一轮没有裁剪，不是因为组合里没挂裁剪器。base 组合确实挂着工具结果裁剪器，参数写死在组合文件里：阈值 8192 字符、留头 4096、留尾 1024（[bundle/base/cordis.patch.yml:404-410](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L404-L410)，默认值同样是这三个数，见 [pruner config.ts:10-14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/config.ts#L10-L14)）。34352 远超 8192。它没动手，是因为裁剪器不挂在"每条工具结果"上：唯一调用它的是压缩器，且只在压缩真的要跑的时候（[compaction-basic:281](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L281)）。这一轮上下文窗口 1,000,000、整个会话不到十万字符，压缩没触发，于是裁剪器的阈值这一轮从未被问到。

`answer.txt` 两行，ALPHA-7391 与 OMEGA-5520，与任务要求一致。

---

## 卡外发现

- **两家都有一个"一万字符上下"的数，但这两个数管的不是同一件事。** mini 的 10000 是**每条 observation 的硬闸**，写在提示词模板里，每次拼消息都走一遍，超了就地掐掉、原文不留。dsh 的 8192 是**压缩里的一份预算**，只有当压缩因为上下文压力或溢出而启动时才轮到它。同一条 34352 字符的输出，一边当场被截成 10000，一边整条进上下文。
- **掐头留尾这个形状，恰好让首尾两个令牌都活了下来。** 这次任务把关键信息放在两端，所以 mini 掐完仍然够用。被丢的是中间那 20132 个字符——如果关键信息在中段，这条 observation 里就没有它了，而且原文不落盘，事后也回不去。
- **模型看到了答案，仍按告诫重跑了一次。** mini 那条 observation 里两个令牌都在，模型没有直接用，而是照 `warning` 里的建议改用 head / tail 重跑。第一次重跑用 `cut -d'：'` 撞上多字节分隔符报错，第二次换 sed 才成。多花的两步来自那段告诫，不是来自信息缺失。
- **`gen.py` 被管道提前关闭时抛的 BrokenPipeError 进了 observation。** `head -n 1` 关掉管道，Python 把 traceback 打到 stderr，环境把 stdout 与 stderr 合在一条 observation 里交给模型；模型据此换了写法。
