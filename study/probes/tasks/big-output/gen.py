"""打印一份长清单：首行开头令牌，末行结尾令牌，中间是流水。

整份输出超过 15000 个字符，用来看各家 harness 把这么长的一条工具输出
怎么交给模型。
"""

HEAD_TOKEN = "ALPHA-7391"
TAIL_TOKEN = "OMEGA-5520"
ROWS = 700


def main() -> None:
    print(f"开头令牌：{HEAD_TOKEN}")
    for i in range(1, ROWS + 1):
        print(f"row {i:04d} | batch {i % 17:02d} | checksum {(i * 7919) % 100000:05d} | 流水行")
    print(f"结尾令牌：{TAIL_TOKEN}")


if __name__ == "__main__":
    main()
