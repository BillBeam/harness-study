# 编辑探针：同一行在文件里出现两次，只许改一处

任务模板 `study/probes/tasks/edit/`：`feed.py` 里 `parse_recent` 与 `parse_archive` 各有一行一模一样的 `    limit = 10`，一字不差、缩进相同。任务要求只把 `parse_recent` 里那一行改成 50，`parse_archive` 里那一行原样留着；测试正好一条查 50、一条查 10，改错哪一处都会红。

两家的任务文本、模型（xai / grok-4.3）、工作副本、环境变量白名单完全相同。wrapper 的兜底是墙钟 480 秒或 40 步，两次都没轮到。

---

## mini-swe-agent

记录：[终端全文](mini-swe-agent/terminal.txt) ｜ [会话记录 mini.traj.json](mini-swe-agent/mini.traj.json)

**发生了什么。** 第 1 步 `ls -la`；第 2 步一条消息里三个动作，读 `feed.py`、`test_feed.py`、`README.md`；第 3 步两个动作，先改再复看，改的那条是：

```
sed -i '0,/limit = 10/s/limit = 10/limit = 50/' feed.py
```

`0,/limit = 10/` 把替换限定在从头到第一处匹配的这段地址范围里，所以只动了第一处；同一步里紧跟着一条 `cat feed.py` 复看改完的样子。第 4 步跑测试，两条全绿；第 5 步发完成口令收尾。

这里没有编辑原语可言：mini 只有一个 bash 工具，改文件的办法由系统提示词教。那份提示词里正好列了四种 sed 写法——全替、只替第一处、只替第 1 行、只替第 1 到 10 行（终端全文里能看到这一段原文）。"只改两处中的一处"这个约束，是模型从这四种里挑了一种地址范围写法自己满足的；harness 没有参与，也没有任何一环去数这次替换命中了几处。

**步数。** 会话记录里 `api_calls` 是 5，`exit_status` 是 `Submitted`。整轮墙钟 13 秒。

**记录文件的最终状态。** `mini.traj.json` 35701 字节，16 条消息，一条不缺，`exit_status` 写着 `Submitted`。

**结果。** `parse_recent` 改成 50，`parse_archive` 仍是 10，两条测试全绿。

---

## deepseek-harness（默认组合）

记录：[终端全文](deepseek-harness/terminal.txt) ｜ [会话日志](deepseek-harness/sessions/--home-user-harness-study-.dsh-run-probe-edit-workspace--/session-cd81defc-c78e-4bf9-8cdd-4d3a7adfcb2d/session.jsonl)

**发生了什么。** 第 1 步 glob；第 2 步并行两个 read，读 `feed.py` 与 `test_feed.py`；第 3 步一次 `edit`。这次 `edit` 的 `old_string` 不是那一行，而是从函数签名一直到 return 的四行：

```
def parse_recent(entries):
    """返回最近的一批条目。"""
    limit = 10
    return list(entries)[:limit]
```

带上签名之后这段文本在文件里唯一，`edit` 一次通过，结果是"has been updated successfully"。第 4 步 bash 跑测试全绿，第 5 步回话收尾。

dsh 的 `edit` 要求唯一匹配：替换前先数命中次数，命中 0 次报 `FS_EDIT_NOT_FOUND`，命中多于一处且没要求 `replace_all` 就报 `FS_AMBIGUOUS_EDIT`，错误正文直接告诉模型"匹配了 N 次，请给更具体的 old_string，或者设 replace_all"（[fsio.ts:775-776](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L775-L776)）。**这一轮这条检查没有拒过任何一次调用**：整份日志里 `isError` 为真的 `tool/result` 是 0 条。模型第一次就把 `old_string` 写成了唯一的。

**步数。** 会话日志里 `step/end` 事件 5 条。整轮墙钟 10 秒。

**记录文件的最终状态。** 会话日志 62766 字节，`turn/end` 的 reason 是 completed。

**结果。** `parse_recent` 改成 50，`parse_archive` 仍是 10，两条测试全绿。

---

## 卡外发现

- **两家都对了，但"只改一处"这件事落在不同的地方。** mini 那边落在模型选的 sed 地址范围里，harness 事后不知道也不检查命中了几处；dsh 那边有一条会数命中次数、多于一处就拒的检查在，只是这一轮模型先一步把匹配写唯一了，检查没开口。同一个结果，一边是无人核对的正确，一边是有人核对但没用上的正确。
- **两家的模型都选择了"扩大匹配范围"而不是"指定第几处"。** mini 用 `0,/pat/` 的地址范围把替换限在第一处，dsh 把 `old_string` 从一行扩到四行带上函数签名。两种写法都是把"哪一处"翻译成"哪一段文本唯一"，没有一家提供按序号点名第几处的口子。
- **dsh 的拒绝理由是写给模型看的一句可执行建议。** `FS_AMBIGUOUS_EDIT` 的正文里同时给了两条出路（写更具体的 old_string、或者设 replace_all），其中 `replace_all` 正是本任务要避免的那条。这一轮没触发，所以模型没在这个岔路口上做选择。
- **mini 的系统提示词把 sed 的四种写法直接列给模型，其中就有"只替第一处"。** 这次能一步做对，用的正是那张表里的写法之一。这张表在 mini 是提示词的一部分，随每次请求进上下文；dsh 那边对应的知识在工具的 JSON schema 描述与出错时的正文里。
