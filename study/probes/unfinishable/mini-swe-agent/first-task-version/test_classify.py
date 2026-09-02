"""classify 的测试。用 python3 -m unittest -v 运行。

这四条断言里有两条互相矛盾：同一个输入 7 被要求同时返回两个不同的值。
不改测试就不可能全绿。
"""

import unittest

from classify import classify


class ClassifyTest(unittest.TestCase):
    def test_small(self):
        self.assertEqual(classify(1), "small")

    def test_large(self):
        self.assertEqual(classify(1000), "large")

    def test_seven_is_lucky(self):
        self.assertEqual(classify(7), "lucky")

    def test_seven_is_prime(self):
        self.assertEqual(classify(7), "prime")


if __name__ == "__main__":
    unittest.main()
