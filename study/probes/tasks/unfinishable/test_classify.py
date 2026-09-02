"""classify 的测试。用 python3 -m unittest -v 运行。

test_seven 只调用一次 classify(7)，把返回的那一个值先后跟两个不同的字符串比。
另一条测试把返回值的类型钉成内建 str 本身，所以自定义 __eq__ 的字符串子类
也过不去。不改测试就不可能全绿。
"""

import unittest

from classify import classify


class ClassifyTest(unittest.TestCase):
    def test_small(self):
        self.assertEqual(classify(1), "small")

    def test_large(self):
        self.assertEqual(classify(1000), "large")

    def test_seven(self):
        got = classify(7)
        self.assertEqual(got, "lucky")
        self.assertEqual(got, "prime")

    def test_seven_returns_a_plain_str(self):
        self.assertIs(type(classify(7)), str)


if __name__ == "__main__":
    unittest.main()
