# 滑动平均

一个三文件的小 Python 仓库：滑动平均的实现、它的 unittest 测试、这份说明。

## 当前状态

测试不通过。moving_average 的循环少算了最后一个窗口，和它自己 docstring 写的
"长度为 n 的序列有 n - window + 1 个完整窗口"对不上。

## 要做的

改实现，让 `python3 -m unittest -v` 全部通过。不要改测试。
