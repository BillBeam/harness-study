"""moving_average 的测试。用 python3 -m unittest -v 运行。"""

import unittest

from stats import moving_average


class MovingAverageTest(unittest.TestCase):
    def test_counts_every_window(self):
        # 4 个数、窗口 2，有 3 个完整窗口。
        self.assertEqual(moving_average([1, 2, 3, 4], 2), [1.5, 2.5, 3.5])

    def test_window_equal_to_length(self):
        # 窗口和序列一样长时，只有一个窗口，不是零个。
        self.assertEqual(moving_average([2, 4], 2), [3.0])

    def test_window_longer_than_values(self):
        # 没有完整窗口。
        self.assertEqual(moving_average([1, 2], 3), [])

    def test_window_must_be_positive(self):
        with self.assertRaises(ValueError):
            moving_average([1, 2, 3], 0)


if __name__ == "__main__":
    unittest.main()
