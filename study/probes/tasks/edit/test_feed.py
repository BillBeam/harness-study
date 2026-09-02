"""feed.py 的测试。用 python3 -m unittest -v 运行。"""

import unittest

from feed import parse_archive, parse_recent


class FeedTest(unittest.TestCase):
    def test_recent_takes_fifty(self):
        # parse_recent 要取 50 条。
        self.assertEqual(len(parse_recent(range(200))), 50)

    def test_archive_still_takes_ten(self):
        # parse_archive 不动，仍然取 10 条。
        self.assertEqual(len(parse_archive(range(200))), 10)


if __name__ == "__main__":
    unittest.main()
