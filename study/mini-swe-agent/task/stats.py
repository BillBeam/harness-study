"""滑动窗口统计。"""


def moving_average(values, window):
    """返回 values 上每个长度为 window 的连续窗口的平均值。

    长度为 n 的序列，在 n >= window 时有 n - window + 1 个这样的窗口，
    所以返回的列表长度是 n - window + 1；n < window 时没有完整窗口，返回空列表。
    """
    if window <= 0:
        raise ValueError("window 必须是正整数")
    if len(values) < window:
        return []
    averages = []
    for start in range(len(values) - window):
        chunk = values[start:start + window]
        averages.append(sum(chunk) / window)
    return averages
