#!/usr/bin/env python3
"""check_map.py 的自检：造一份假的钉住副本和假地图，逐个确认该报的错都报得出来。

只用标准库，不联网。跑法：python3 tools/test_check_map.py
"""

from __future__ import annotations

import json
import subprocess
import sys
import tempfile
import traceback
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import check_map  # noqa: E402

SOURCE = """def run(self):
    while True:
        self.step()
        if self.done:
            break
"""

MAP_HEAD = """# 假地图

钉住提交：{commit}
"""

GOOD_BODY = """
## 问1：主循环入口在哪

### 基类 DefaultAgent
- 主循环 · `agent.py:2` — `while True:`

### InteractiveAgent 不同处
- 不覆写：没有

## 问2：工具调用在哪里被校验和分发

### 基类 DefaultAgent
- `agent.py:1-5` — `def run(self):`

### InteractiveAgent 不同处
- 没有

## 问3：会话或轨迹被写到哪

### 基类 DefaultAgent
- `agent.py:3` — `self.step()`

### InteractiveAgent 不同处
- 没有

## 问4：循环在哪里判定停止

### 基类 DefaultAgent
- `agent.py:5` — `break`

### InteractiveAgent 不同处
- 没有
"""


def make_fixture(tmp: Path, body: str = GOOD_BODY, *, commit: str | None = None, head_text: str | None = None):
    """造一个真 git 仓库当钉住副本，再配一份 pin.json 和 map.md。"""
    checkout = tmp / "checkout"
    checkout.mkdir(parents=True, exist_ok=True)
    (checkout / "agent.py").write_text(SOURCE, encoding="utf-8")
    git = ["git", "-c", "user.email=t@example.com", "-c", "user.name=t", "-C", str(checkout)]
    subprocess.run(git + ["init", "-q"], check=True)
    subprocess.run(git + ["add", "-A"], check=True)
    subprocess.run(git + ["commit", "-q", "-m", "fixture"], check=True)
    head = subprocess.run(
        ["git", "-C", str(checkout), "rev-parse", "HEAD"], capture_output=True, text=True, check=True
    ).stdout.strip()

    pin_commit = commit or head
    pin_path = tmp / "pin.json"
    pin_path.write_text(json.dumps({"repo": "fake", "commit": pin_commit}), encoding="utf-8")
    map_path = tmp / "map.md"
    map_path.write_text((head_text if head_text is not None else MAP_HEAD.format(commit=pin_commit)) + body, encoding="utf-8")
    return map_path, pin_path, checkout


def run_on(body: str = GOOD_BODY, **kwargs) -> list[str]:
    with tempfile.TemporaryDirectory() as d:
        map_path, pin_path, checkout = make_fixture(Path(d), body, **kwargs)
        return check_map.run_checks(map_path, pin_path, checkout)


def test_labelled_anchor_is_parsed():
    """带说明前缀的锚点也要能解析出来并逐行比对。"""
    body = GOOD_BODY.replace("- `agent.py:5` — `break`", "- 跳出 · `agent.py:5` — `continue`")
    problems = run_on(body)
    assert any("原文对不上" in p for p in problems), problems


def test_good_map_passes():
    assert run_on() == [], "正确的地图不该报错"


def test_snippet_mismatch_is_caught():
    body = GOOD_BODY.replace("- 主循环 · `agent.py:2` — `while True:`", "- 主循环 · `agent.py:2` — `while False:`")
    problems = run_on(body)
    assert any("原文对不上" in p for p in problems), problems


def test_missing_file_is_caught():
    body = GOOD_BODY.replace("- 主循环 · `agent.py:2` — `while True:`", "- 主循环 · `nope.py:2` — `while True:`")
    problems = run_on(body)
    assert any("文件不存在" in p for p in problems), problems


def test_line_out_of_range_is_caught():
    body = GOOD_BODY.replace("- 主循环 · `agent.py:2` — `while True:`", "- 主循环 · `agent.py:999` — `while True:`")
    problems = run_on(body)
    assert any("超出" in p for p in problems), problems


def test_reversed_range_is_caught():
    body = GOOD_BODY.replace("- `agent.py:1-5` — `def run(self):`", "- `agent.py:5-1` — `break`")
    problems = run_on(body)
    assert any("区间反了" in p for p in problems), problems


def test_range_anchor_checks_first_line():
    body = GOOD_BODY.replace("- `agent.py:1-5` — `def run(self):`", "- `agent.py:1-5` — `while True:`")
    problems = run_on(body)
    assert any("原文对不上" in p for p in problems), problems


def test_question_without_anchor_is_caught():
    body = GOOD_BODY.replace("- `agent.py:5` — `break`", "- 没有")
    problems = run_on(body)
    assert any("一条锚点都没有" in p for p in problems), problems


def test_missing_question_is_caught():
    body = GOOD_BODY.split("## 问4：")[0]
    problems = run_on(body)
    assert any("缺少“## 问4：”小节" in p for p in problems), problems


def test_missing_subsection_is_caught():
    body = GOOD_BODY.replace("### InteractiveAgent 不同处\n- 不覆写：没有\n", "", 1)
    problems = run_on(body)
    assert any("InteractiveAgent" in p and "缺少标题含" in p for p in problems), problems


def test_silent_subsection_is_caught():
    body = GOOD_BODY.replace("### InteractiveAgent 不同处\n- 不覆写：没有", "### InteractiveAgent 不同处\n先放着。")
    problems = run_on(body)
    assert any("既没有锚点" in p for p in problems), problems


def test_head_mismatch_is_caught():
    problems = run_on(commit="0" * 40)
    assert any("钉住的是" in p for p in problems), problems


def test_map_without_commit_is_caught():
    problems = run_on(head_text="# 假地图\n\n没写提交号\n")
    assert any("没有写明钉住提交" in p for p in problems), problems


def test_empty_map_is_caught():
    problems = run_on(body="\n")
    assert any("没有解析到任何锚点" in p for p in problems), problems


def main() -> int:
    tests = [(n, f) for n, f in sorted(globals().items()) if n.startswith("test_") and callable(f)]
    failed = 0
    for name, fn in tests:
        try:
            fn()
            print(f"  通过  {name}")
        except Exception:
            failed += 1
            print(f"  失败  {name}")
            traceback.print_exc()
    print(f"\n自检：{len(tests) - failed}/{len(tests)} 通过")
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())
