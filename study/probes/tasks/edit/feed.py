"""两个取条目的函数：一个取最近的，一个取归档的。"""


def parse_recent(entries):
    """返回最近的一批条目。"""
    limit = 10
    return list(entries)[:limit]


def parse_archive(entries):
    """返回归档里的一批条目。"""
    limit = 10
    return list(entries)[-limit:]
