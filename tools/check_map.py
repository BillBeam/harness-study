#!/usr/bin/env python3
"""校验 study/ 下的定位地图：每条锚点必须指向钉住提交里真实存在的那一行。

锚点写法（map.md 中的列表项）：

    - 主循环 · `src/minisweagent/agents/default.py:96` — `while True:`
    - `src/minisweagent/agents/default.py:88-124` — `def run(self, task: str = "", **kwargs) -> dict:`

校验内容：
1. 钉住提交与 checkout 的 HEAD 一致，且 map.md 里写的提交号与 pin.json 一致；
2. 每条锚点的文件存在、行号在范围内、反引号里的原文与该行去空白后完全相同；
3. 四问都在，每问都有 DefaultAgent 与 InteractiveAgent 两个小节；
4. 每问至少一条锚点；每个小节要么有锚点，要么写明“没有”。
"""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from dataclasses import dataclass, field
from pathlib import Path

# 锚点：- 说明 · `路径:行号` — `原文`  （说明可省；行号可写成 12-34 的区间）
ANCHOR_RE = re.compile(
    r"^\s*[-*]\s+(?P<label>[^`]*)"
    r"`(?P<path>[^`]+?):(?P<start>\d+)(?:-(?P<end>\d+))?`"
    r"\s*[—–-]\s*`(?P<snippet>.+)`\s*$"
)
QUESTION_RE = re.compile(r"^##\s*问([1-4])[：:]\s*(?P<title>.+?)\s*$")
SUBSECTION_RE = re.compile(r"^###\s*(?P<title>.+?)\s*$")
NO_MECHANISM = "没有"


@dataclass
class Anchor:
    path: str
    start: int
    end: int
    snippet: str
    lineno: int  # 锚点自身在 map.md 中的行号


@dataclass
class Subsection:
    title: str
    lineno: int
    anchors: list[Anchor] = field(default_factory=list)
    says_none: bool = False


@dataclass
class Question:
    number: str
    title: str
    lineno: int
    subsections: list[Subsection] = field(default_factory=list)

    @property
    def anchors(self) -> list[Anchor]:
        return [a for s in self.subsections for a in s.anchors]


def parse_map(text: str) -> tuple[list[Question], list[Anchor]]:
    """把 map.md 解析成四问 / 小节 / 锚点。返回 (问题列表, 全部锚点)。"""
    questions: list[Question] = []
    orphans: list[Anchor] = []  # 不在任何小节里的锚点，仍然要逐条校验
    question: Question | None = None
    subsection: Subsection | None = None
    for i, line in enumerate(text.splitlines(), start=1):
        if m := QUESTION_RE.match(line):
            question = Question(number=m.group(1), title=m.group("title"), lineno=i)
            questions.append(question)
            subsection = None
            continue
        if line.startswith("## "):  # 别的二级标题结束当前问题
            question = None
            subsection = None
            continue
        if m := SUBSECTION_RE.match(line):
            subsection = Subsection(title=m.group("title"), lineno=i)
            if question is not None:
                question.subsections.append(subsection)
            continue
        if m := ANCHOR_RE.match(line):
            anchor = Anchor(
                path=m.group("path"),
                start=int(m.group("start")),
                end=int(m.group("end") or m.group("start")),
                snippet=m.group("snippet"),
                lineno=i,
            )
            if subsection is not None:
                subsection.anchors.append(anchor)
            else:
                orphans.append(anchor)
            continue
        if subsection is not None and NO_MECHANISM in line:
            subsection.says_none = True
    all_anchors = [a for q in questions for a in q.anchors] + orphans
    return questions, all_anchors


def check_anchor(anchor: Anchor, checkout: Path) -> list[str]:
    """逐条校验锚点，返回问题描述列表（空表示通过）。"""
    where = f"map.md:{anchor.lineno}"
    target = checkout / anchor.path
    if not target.is_file():
        return [f"{where}: 文件不存在：{anchor.path}"]
    lines = target.read_text(encoding="utf-8").splitlines()
    if anchor.end < anchor.start:
        return [f"{where}: 行号区间反了：{anchor.start}-{anchor.end}"]
    if anchor.end > len(lines):
        return [f"{where}: 行号 {anchor.end} 超出 {anchor.path} 的 {len(lines)} 行"]
    actual = lines[anchor.start - 1].strip()
    if actual != anchor.snippet.strip():
        return [
            f"{where}: {anchor.path}:{anchor.start} 原文对不上\n"
            f"    地图里写的：{anchor.snippet.strip()}\n"
            f"    实际那一行：{actual}"
        ]
    return []


def check_structure(questions: list[Question]) -> list[str]:
    """校验四问是否齐全、每问的两个小节是否都有着落。"""
    problems: list[str] = []
    seen = [q.number for q in questions]
    for n in "1234":
        if seen.count(n) == 0:
            problems.append(f"map.md: 缺少“## 问{n}：”小节")
        elif seen.count(n) > 1:
            problems.append(f"map.md: “## 问{n}：”出现了 {seen.count(n)} 次")
    for q in questions:
        head = f"map.md:{q.lineno} 问{q.number}"
        if not q.anchors:
            problems.append(f"{head}: 一条锚点都没有")
        for needle in ("DefaultAgent", "InteractiveAgent"):
            if not any(needle in s.title for s in q.subsections):
                problems.append(f"{head}: 缺少标题含“{needle}”的小节")
        for s in q.subsections:
            if not s.anchors and not s.says_none:
                problems.append(f"map.md:{s.lineno} 小节“{s.title}”: 既没有锚点，也没有写明“{NO_MECHANISM}”")
    return problems


def check_pin(pin: dict, map_text: str, checkout: Path) -> list[str]:
    """校验 checkout 的 HEAD 和 map.md 里写的提交号都等于 pin.json 的钉住提交。"""
    problems: list[str] = []
    commit = pin["commit"]
    if commit not in map_text:
        problems.append(f"map.md: 没有写明钉住提交 {commit}")
    try:
        head = subprocess.run(
            ["git", "-C", str(checkout), "rev-parse", "HEAD"],
            capture_output=True, text=True, check=True,
        ).stdout.strip()
    except (subprocess.CalledProcessError, FileNotFoundError) as e:
        return problems + [f"{checkout}: 读不到 HEAD（先跑 make sync）：{e}"]
    if head != commit:
        problems.append(f"{checkout}: HEAD 是 {head}，钉住的是 {commit}（先跑 make sync）")
    return problems


def run_checks(map_path: Path, pin_path: Path, checkout: Path) -> list[str]:
    if not map_path.is_file():
        return [f"找不到地图文件：{map_path}"]
    if not pin_path.is_file():
        return [f"找不到钉住文件：{pin_path}"]
    if not checkout.is_dir():
        return [f"找不到目标仓库副本：{checkout}（先跑 make sync）"]
    pin = json.loads(pin_path.read_text(encoding="utf-8"))
    map_text = map_path.read_text(encoding="utf-8")
    questions, anchors = parse_map(map_text)
    problems = check_pin(pin, map_text, checkout)
    problems += check_structure(questions)
    for anchor in anchors:
        problems += check_anchor(anchor, checkout)
    if not anchors:
        problems.append(f"{map_path}: 没有解析到任何锚点，检查锚点写法")
    return problems


def main(argv: list[str] | None = None) -> int:
    repo_root = Path(__file__).resolve().parent.parent
    parser = argparse.ArgumentParser(description="校验定位地图的锚点")
    parser.add_argument("--map", type=Path, default=repo_root / "study/mini-swe-agent/map.md")
    parser.add_argument("--pin", type=Path, default=repo_root / "study/mini-swe-agent/pin.json")
    parser.add_argument("--checkout", type=Path, default=None)
    args = parser.parse_args(argv)

    checkout = args.checkout
    if checkout is None:
        pin = json.loads(args.pin.read_text(encoding="utf-8")) if args.pin.is_file() else {}
        checkout = repo_root / pin.get("checkout_dir", ".upstream/mini-swe-agent")

    problems = run_checks(args.map, args.pin, checkout)
    if problems:
        print(f"锚点校验失败，共 {len(problems)} 处：", file=sys.stderr)
        for p in problems:
            print(f"  - {p}", file=sys.stderr)
        return 1
    questions, anchors = parse_map(args.map.read_text(encoding="utf-8"))
    print(f"锚点校验通过：{len(questions)} 问，{len(anchors)} 条锚点，全部对上 {args.map}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
