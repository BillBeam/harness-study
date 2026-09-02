# 两处一样的行，只改一处

一个三文件的小 Python 仓库：两个取条目的函数、它们的 unittest 测试、这份说明。

## 当前状态

`feed.py` 里 `parse_recent` 和 `parse_archive` 各有一行一模一样的 `    limit = 10`，
一字不差，缩进也相同。测试要求 parse_recent 取 50 条、parse_archive 仍取 10 条，
所以现在测试不通过。

## 要做的

只把 `parse_recent` 里的那一行改成 `    limit = 50`。
`parse_archive` 里的那一行必须原样留着，仍然是 10。

改完让 `python3 -m unittest -v` 全部通过。不要改测试。
