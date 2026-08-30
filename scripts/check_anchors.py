#!/usr/bin/env python3
"""Verify every code anchor in the study artifacts against its pinned target repo.

An artifact (a Markdown file under study/ or points/) may reference code in a
target repository. Those references are *anchors*, and this script proves each
one still resolves at the commit the repository is pinned to.

Three things are checked:

  1. front matter          `repo:` names a pin, `commit:` equals that pin's commit
  2. code anchors          `path:line` / `path:line-line` / `repo@commit:path:line`
                           -> the blob exists at that commit and the line is in range
  3. link anchors          https://github.com/<owner>/<repo>/blob/<sha>/<path>#L12
                           https://github.com/<owner>/<repo>/blob/<sha>/<path>#L12-L20
                           -> <owner>/<repo> is matched to a pin through that pin's
                              upstream url in repos/pins.tsv, <sha> must be the pin
                              or an ancestor of it, and path and lines are checked
                              exactly as in form 2
  4. commit references     `abcdef12` / `repo@abcdef12`
                           -> the commit exists in the pinned clone and is an
                              ancestor of the pin

Inline code spans (backticks) outside fenced code blocks are scanned for forms 2
and 4, so syntax examples inside ``` fences are never mistaken for real anchors.
Form 3 is scanned on the whole line -- a link's destination lives in `(...)`, not
in backticks -- but still only outside fenced code blocks, for the same reason.

Exit status: 0 if every anchor resolved (including the case of no anchors at
all), 1 if any anchor failed, 2 on a usage or configuration error.

Stdlib only. No network access: everything is answered from the local clone.
"""

from __future__ import annotations

import argparse
import json
import os
import re
import subprocess
import sys
from dataclasses import dataclass, field
from pathlib import Path

# study/ and points/ are scanned recursively, so anything added under them is
# picked up automatically. Root-level files are named one by one, so a new one
# has to be added here -- otherwise its anchors go unchecked.
DEFAULT_TARGETS = [
    "study", "points",
    "matrix.md",
    "LOG.md",
]


class ConfigError(Exception):
    """A usage or configuration problem. Exits 2, distinct from a failed check."""


# --------------------------------------------------------------------------
# Anchor grammar
# --------------------------------------------------------------------------
#
#   short form     path/to/file.py:97          repo+commit come from front matter
#                  path/to/file.py:97-120
#   explicit form  name@25941c89:path/file.py:97
#
# The short form requires the path to contain a "/" or end in a ".ext", so that
# ordinary prose in backticks is not swept up. A path that fits neither shape
# (a top-level extensionless file, say) must use the explicit form, which is
# unambiguous by construction. A token that looks like an anchor but does not
# resolve is reported as an error rather than silently skipped: a false positive
# is meant to be loud, and the escape hatch is to drop the backticks.
_PATH = r"[A-Za-z0-9._][A-Za-z0-9._\-/]*"
# A short-form path must contain a directory separator, or end in a ".ext"
# immediately before the ":line". Anchoring the extension on that colon (and
# not on end-of-token) is what lets `pyproject.toml:1` and `README.md:12`
# resolve while leaving `localhost:8080` alone.
_SHORT_PATH = r"(?=[A-Za-z0-9._\-/]*/|[A-Za-z0-9._\-]*\.[A-Za-z0-9]{1,8}:)" + _PATH

ANCHOR_RE = re.compile(
    rf"""^(?:
            (?P<xrepo>[A-Za-z0-9._-]+)@(?P<xcommit>[0-9a-fA-F]{{7,40}}):(?P<xpath>{_PATH})
          |
            (?P<path>{_SHORT_PATH})
        )
        :(?P<line>\d+)(?:-(?P<end>\d+))?$""",
    re.VERBOSE,
)

# Bare commit references need 8+ lowercase hex to keep English words out; the
# explicit `repo@sha` form is unambiguous and accepts git's 7-char minimum.
#
# An all-digit token is genuinely ambiguous: about 2% of abbreviated SHAs are
# all-decimal (~1.9% of this pin's own history at 8 characters), so excluding
# them by shape would stop verifying real commit references and turn a mistyped
# one into a silent pass. Such a token is marked TENTATIVE instead and dropped
# only when the clone says it is not a commit -- see verify().
COMMIT_RE = re.compile(
    r"^(?:(?P<repo>[A-Za-z0-9._-]+)@(?P<xsha>[0-9a-fA-F]{7,40})|(?P<sha>[0-9a-f]{8,40}))$"
)

# Link form: a GitHub "blob" permalink with a line fragment.
#
#   https://github.com/<owner>/<repo>/blob/<sha>/<path>#L97
#   https://github.com/<owner>/<repo>/blob/<sha>/<path>#L97-L120
#
# This is the shape a reader can click, so notes written for a human use it
# instead of `repo@sha:path:line`. It carries no pin *name*, so the repository is
# identified the only way it can be: <owner>/<repo> is matched against the
# upstream url of each pin in repos/pins.tsv (see upstream_slug).
#
# Unlike forms 2 and 4 this is matched anywhere on the line rather than inside a
# code span, because a link's destination sits in `[text](here)` -- never in
# backticks. The `#L<n>` fragment is required: a blob link without one is a file
# link, not a line anchor, and is left alone.
#
# <ref> is deliberately permissive rather than "7-40 hex". A link on a branch or
# tag (`/blob/main/...#L97`) looks exactly like an anchor and drifts the moment
# the branch moves -- the one failure this whole script exists to catch -- so it
# is matched here and reported as `unpinned-ref`, not silently skipped.
GITHUB_LINK_RE = re.compile(
    r"https://github\.com/"
    r"(?P<owner>[A-Za-z0-9][A-Za-z0-9._-]*)/(?P<repo>[A-Za-z0-9][A-Za-z0-9._-]*)"
    r"/blob/(?P<ref>[^/\s#?)\]\"'`<>]+)/(?P<path>[^\s#?)\]\"'`<>]+)"
    r"#L(?P<line>\d+)(?:-L(?P<end>\d+))?"
)

# The upstream url of a pin, reduced to the `owner/repo` a link would carry.
# https / ssh / git forms are all accepted, with or without `.git` and a trailing
# slash, because pins.tsv is hand-editable and the exact spelling is not the
# point -- what the link has to agree with is which repository it is.
GITHUB_UPSTREAM_RE = re.compile(
    r"^(?:https://|http://|git://|ssh://git@|git\+https://|git@)github\.com[:/]"
    r"(?P<owner>[A-Za-z0-9][A-Za-z0-9._-]*)/(?P<repo>[A-Za-z0-9][A-Za-z0-9._-]*?)"
    r"(?:\.git)?/?$"
)

# Inline code spans: a run of backticks, content, the same run again.
CODE_SPAN_RE = re.compile(r"(?P<ticks>`+)(?P<body>[^\n]+?)(?P=ticks)")

# Fenced code blocks. The opener's marker and indent are both kept, because
# CommonMark requires a closer to be at least as long as its opener and no more
# than three columns further indented, and a closer carries no info string.
# Normalising the marker to three characters (the obvious shortcut) desyncs the
# state machine on a longer fence quoting a shorter one -- the ordinary way to
# show fence syntax in Markdown -- which used to swallow the rest of the file.
FENCE_RE = re.compile(r"^(?P<indent>[ \t]*)(?P<fence>`{3,}|~{3,})(?P<info>.*)$")
# A leading blockquote prefix is stripped before fence and code-span matching so
# that quoted material is read the same way as unquoted material.
QUOTE_RE = re.compile(r"^(?:[ \t]{0,3}>[ \t]?)+")
FRONT_KV_RE = re.compile(r"^([A-Za-z][A-Za-z0-9_-]*)\s*:\s*(.*?)\s*$")


# --------------------------------------------------------------------------
# Pins
# --------------------------------------------------------------------------
@dataclass(frozen=True)
class Pin:
    name: str
    url: str
    commit: str
    note: str


def load_pins(pins_file: Path) -> dict[str, Pin]:
    if not pins_file.is_file():
        raise ConfigError(f"check_anchors: missing pins file {pins_file}")
    pins: dict[str, Pin] = {}
    for lineno, raw in enumerate(pins_file.read_text(encoding="utf-8").splitlines(), 1):
        if not raw.strip() or raw.lstrip().startswith("#"):
            continue
        parts = raw.split("\t")
        if len(parts) < 3:
            raise ConfigError(
                f"{pins_file}:{lineno}: malformed pin (need name<TAB>url<TAB>commit[<TAB>note])"
            )
        name, url, commit = (p.strip() for p in parts[:3])
        note = parts[3].strip() if len(parts) > 3 else ""
        if not re.fullmatch(r"[0-9a-f]{40}", commit):
            raise ConfigError(f"{pins_file}:{lineno}: commit {commit!r} is not a full 40-hex SHA")
        if name in pins:
            raise ConfigError(f"{pins_file}:{lineno}: duplicate pin {name!r}")
        pins[name] = Pin(name, url, commit, note)
    return pins


def upstream_slug(url: str) -> str | None:
    """`owner/repo`, lowercased, for a GitHub upstream url -- or None if not one."""
    m = GITHUB_UPSTREAM_RE.match(url.strip())
    if not m:
        return None
    return f"{m.group('owner')}/{m.group('repo')}".lower()


def index_by_upstream(pins: dict[str, Pin]) -> dict[str, list[str]]:
    """Map `owner/repo` -> the pin names whose upstream is that repository.

    A list, not a single name: two pins may legitimately track the same upstream
    at different commits, and in that case a link naming only `owner/repo` cannot
    say which one it means. That is reported per reference (`ambiguous-repo`)
    rather than raised here, so one ambiguous link does not stop the whole run.
    """
    index: dict[str, list[str]] = {}
    for pin in pins.values():
        slug = upstream_slug(pin.url)
        if slug is not None:
            index.setdefault(slug, []).append(pin.name)
    return index


# --------------------------------------------------------------------------
# Git access, memoised
# --------------------------------------------------------------------------
class Clone:
    """Read-only queries against one materialised pin."""

    def __init__(self, root: Path, pin: Pin):
        self.pin = pin
        self.dir = root / "repos" / pin.name
        self._lines: dict[tuple[str, str], int | None] = {}
        self._commits: dict[str, bool] = {}
        self._ancestor: dict[str, bool] = {}

    @property
    def present(self) -> bool:
        return (self.dir / ".git").exists()

    def _git(self, *args: str) -> subprocess.CompletedProcess:
        return subprocess.run(
            ["git", "-C", str(self.dir), *args],
            capture_output=True,
            check=False,
        )

    def has_commit(self, sha: str) -> bool:
        if sha not in self._commits:
            self._commits[sha] = self._git("cat-file", "-e", f"{sha}^{{commit}}").returncode == 0
        return self._commits[sha]

    def is_ancestor(self, sha: str) -> bool:
        """True if sha is reachable from the pinned commit (the pin included)."""
        if sha not in self._ancestor:
            self._ancestor[sha] = (
                self._git("merge-base", "--is-ancestor", sha, self.pin.commit).returncode == 0
            )
        return self._ancestor[sha]

    def blob_lines(self, sha: str, path: str) -> int | None:
        """Line count of the blob at <sha>:<path>, or None if it is not a blob."""
        key = (sha, path)
        if key in self._lines:
            return self._lines[key]
        spec = f"{sha}:{path}"
        kind = self._git("cat-file", "-t", spec)
        if kind.returncode != 0 or kind.stdout.strip() != b"blob":
            self._lines[key] = None
            return None
        blob = self._git("cat-file", "blob", spec)
        if blob.returncode != 0:
            self._lines[key] = None
            return None
        data = blob.stdout
        if not data:
            count = 0
        else:
            count = data.count(b"\n") + (0 if data.endswith(b"\n") else 1)
        self._lines[key] = count
        return count


# --------------------------------------------------------------------------
# Artifact scanning
# --------------------------------------------------------------------------
@dataclass
class Ref:
    """One thing to verify, located at file:lineno in the artifact."""

    kind: str  # "anchor" | "commit"
    file: Path
    lineno: int
    token: str
    repo: str | None = None
    commit: str | None = None
    path: str | None = None
    line: int | None = None
    end: int | None = None
    tentative: bool = False
    # Link form only. `slug` is the `owner/repo` the link named, resolved to a
    # pin name in verify() where the pins are in hand; `raw_ref` is set instead
    # of `commit` when the link points at something that is not a commit SHA.
    slug: str | None = None
    raw_ref: str | None = None


@dataclass
class Artifact:
    file: Path
    repo: str | None = None
    commit: str | None = None
    front_lineno: dict[str, int] = field(default_factory=dict)
    refs: list[Ref] = field(default_factory=list)
    unclosed_fence: int | None = None


def parse_front_matter(lines: list[str]) -> tuple[dict[str, str], dict[str, int], int]:
    """Return (values, lineno-of-each-key, index of first body line)."""
    if not lines or lines[0].strip() != "---":
        return {}, {}, 0
    values: dict[str, str] = {}
    where: dict[str, int] = {}
    for i in range(1, len(lines)):
        if lines[i].strip() == "---":
            return values, where, i + 1
        m = FRONT_KV_RE.match(lines[i])
        if m:
            key, value = m.group(1).lower(), m.group(2)
            values[key] = value.strip().strip("'\"")
            where[key] = i + 1
    # Unterminated front matter: treat the whole file as body.
    return {}, {}, 0


def scan(file: Path) -> Artifact:
    # utf-8-sig drops a leading BOM, which would otherwise make line 1 read as
    # "\ufeff---" and silently cost the file its front matter.
    text = file.read_text(encoding="utf-8-sig", errors="replace")
    lines = text.splitlines()
    front, where, body_start = parse_front_matter(lines)
    art = Artifact(file=file, repo=front.get("repo") or None, commit=front.get("commit") or None,
                   front_lineno=where)

    # Open fence, as (marker, indent width, line number it opened on).
    fence: tuple[str, int, int] | None = None
    for idx in range(body_start, len(lines)):
        raw = QUOTE_RE.sub("", lines[idx])
        m = FENCE_RE.match(raw)
        if m:
            marker = m.group("fence")
            indent = len(m.group("indent").expandtabs(4))
            if fence is None:
                fence = (marker, indent, idx + 1)
                continue
            open_marker, open_indent, _ = fence
            # CommonMark: same character, at least as long, no more than three
            # columns further indented, and no info string.
            if (
                marker[0] == open_marker[0]
                and len(marker) >= len(open_marker)
                and indent <= open_indent + 3
                and not m.group("info").strip()
            ):
                fence = None
                continue
        if fence is not None:
            continue
        # (column, Ref) so the two scanners below can be merged back into the
        # order a reader sees on the line, whichever one matched first.
        found: list[tuple[int, Ref]] = []
        for link in GITHUB_LINK_RE.finditer(raw):
            ref_text = link.group("ref")
            is_sha = re.fullmatch(r"[0-9a-fA-F]{7,40}", ref_text) is not None
            found.append((
                link.start(),
                Ref(
                    kind="anchor",
                    file=file,
                    lineno=idx + 1,
                    token=link.group(0),
                    repo=None,  # resolved from slug in verify()
                    commit=ref_text.lower() if is_sha else None,
                    path=link.group("path"),
                    line=int(link.group("line")),
                    end=int(link.group("end")) if link.group("end") else None,
                    slug=f"{link.group('owner')}/{link.group('repo')}".lower(),
                    raw_ref=None if is_sha else ref_text,
                ),
            ))
        for span in CODE_SPAN_RE.finditer(raw):
            token = span.group("body").strip()
            if not token:
                continue
            a = ANCHOR_RE.match(token)
            if a:
                found.append((
                    span.start(),
                    Ref(
                        kind="anchor",
                        file=file,
                        lineno=idx + 1,
                        token=token,
                        repo=a.group("xrepo") or art.repo,
                        commit=(a.group("xcommit") or "").lower() or None,
                        path=a.group("xpath") or a.group("path"),
                        line=int(a.group("line")),
                        end=int(a.group("end")) if a.group("end") else None,
                    ),
                ))
                continue
            c = COMMIT_RE.match(token)
            if c:
                sha = (c.group("xsha") or c.group("sha")).lower()
                found.append((
                    span.start(),
                    Ref(
                        kind="commit",
                        file=file,
                        lineno=idx + 1,
                        token=token,
                        repo=c.group("repo") or art.repo,
                        commit=sha,
                        # A bare all-digit token might be a decimal literal rather
                        # than a SHA; only the clone can tell. See COMMIT_RE.
                        tentative=bool(c.group("sha")) and sha.isdigit(),
                    ),
                ))
        art.refs.extend(ref for _, ref in sorted(found, key=lambda pair: pair[0]))
    if fence is not None:
        # Everything from here to EOF was skipped as if it were code. Say so
        # rather than reporting success: an unclosed fence is the one way the
        # scanner can stop seeing anchors, and it must never be silent.
        art.unclosed_fence = fence[2]
    return art


def collect_files(root: Path, targets: list[str]) -> list[Path]:
    found: list[Path] = []
    for target in targets:
        p = (root / target) if not os.path.isabs(target) else Path(target)
        if p.is_dir():
            found.extend(sorted(q for q in p.rglob("*.md") if q.is_file()))
        elif p.is_file():
            found.append(p)
        elif not (root / target).exists() and target in DEFAULT_TARGETS:
            continue  # a default target that does not exist yet is not an error
        else:
            raise ConfigError(f"check_anchors: no such path: {target}")
    # Deduplicate while keeping order.
    seen: set[Path] = set()
    return [p for p in found if not (p in seen or seen.add(p))]


# --------------------------------------------------------------------------
# Verification
# --------------------------------------------------------------------------
@dataclass
class Problem:
    file: Path
    lineno: int
    code: str
    message: str

    def render(self, root: Path) -> str:
        try:
            where = self.file.relative_to(root)
        except ValueError:
            where = self.file
        return f"{where}:{self.lineno}: [{self.code}] {self.message}"


def verify(root: Path, arts: list[Artifact], pins: dict[str, Pin]) -> tuple[list[Problem], int]:
    problems: list[Problem] = []
    clones: dict[str, Clone] = {}
    absent_reported: set[str] = set()
    by_upstream = index_by_upstream(pins)
    checked = 0

    def clone_for(name: str) -> Clone:
        if name not in clones:
            clones[name] = Clone(root, pins[name])
        return clones[name]

    for art in arts:
        if art.unclosed_fence is not None:
            problems.append(Problem(art.file, art.unclosed_fence, "unclosed-fence",
                                    "code fence opened here is never closed, so the rest of the "
                                    "file was skipped and any anchor in it went unchecked"))

        # Front matter is only required once the file actually carries a short-form ref.
        if art.repo is not None:
            line = art.front_lineno.get("repo", 1)
            if art.repo not in pins:
                problems.append(Problem(art.file, line, "unknown-repo",
                                        f"front matter repo {art.repo!r} is not pinned in repos/pins.tsv"))
            elif art.commit is None:
                problems.append(Problem(art.file, line, "missing-commit",
                                        f"front matter declares repo {art.repo!r} but no commit:"))
            elif art.commit.lower() != pins[art.repo].commit:
                problems.append(Problem(art.file, art.front_lineno.get("commit", line), "stale-commit",
                                        f"front matter commit {art.commit} != pinned commit "
                                        f"{pins[art.repo].commit} for {art.repo!r}"))

        for ref in art.refs:
            checked += 1
            # A link names a repository by its upstream url, not by pin name, so
            # the pin has to be looked up before anything else can be said.
            if ref.slug is not None and ref.repo is None:
                candidates = by_upstream.get(ref.slug, [])
                if not candidates:
                    problems.append(Problem(art.file, ref.lineno, "unknown-repo",
                                            f"`{ref.token}` links into github.com/{ref.slug}, which no "
                                            f"pin in repos/pins.tsv points at"))
                    continue
                if len(candidates) > 1:
                    problems.append(Problem(art.file, ref.lineno, "ambiguous-repo",
                                            f"`{ref.token}` links into github.com/{ref.slug}, but "
                                            f"{len(candidates)} pins point there "
                                            f"({', '.join(sorted(candidates))}) — write it as "
                                            f"`<repo>@<commit>:{ref.path}:{ref.line}` to say which"))
                    continue
                ref.repo = candidates[0]
                if ref.raw_ref is not None:
                    problems.append(Problem(art.file, ref.lineno, "unpinned-ref",
                                            f"`{ref.token}` is on {ref.raw_ref!r}, which is not a commit "
                                            f"SHA — a link on a branch or tag moves when it moves, so it "
                                            f"proves nothing; use the pinned commit "
                                            f"{pins[ref.repo].commit[:12]}"))
                    continue
            if ref.repo is None:
                problems.append(Problem(art.file, ref.lineno, "no-repo",
                                        f"`{ref.token}` has no repo: add front matter `repo:`/`commit:` "
                                        f"or write it as `<repo>@<commit>:{ref.path or ref.commit}`"))
                continue
            if ref.repo not in pins:
                problems.append(Problem(art.file, ref.lineno, "unknown-repo",
                                        f"`{ref.token}` names repo {ref.repo!r}, which is not pinned "
                                        f"in repos/pins.tsv"))
                continue
            pin = pins[ref.repo]
            clone = clone_for(ref.repo)
            if not clone.present:
                # One line per absent repository, not per anchor: on a fresh
                # clone every anchor hits this, and 30 copies of one remedy
                # buries any other problem in the run.
                if ref.repo not in absent_reported:
                    absent_reported.add(ref.repo)
                    problems.append(Problem(art.file, ref.lineno, "repo-absent",
                                            f"repos/{ref.repo}/ is not materialised, so no anchor "
                                            f"into it can be checked (first: `{ref.token}`) — run "
                                            f"`make sync`"))
                continue

            # Short-form refs always resolve at the pin. Front matter `commit:` is
            # an assertion that the note was written against the current pin (it is
            # checked above), not an alternate resolution target -- so a stale note
            # reports one clear problem instead of a cascade. To point at a
            # historical commit on purpose, use the explicit `repo@sha:path:line`
            # form, which is checked to be an ancestor of the pin.
            sha = (ref.commit or pin.commit).lower()
            if ref.tentative and not clone.has_commit(sha):
                # An ordinary decimal number, not an abbreviated SHA after all.
                checked -= 1
                continue
            if not clone.has_commit(sha):
                problems.append(Problem(art.file, ref.lineno, "unknown-commit",
                                        f"`{ref.token}`: commit {sha} is not in repos/{ref.repo}/ — "
                                        f"run `scripts/pin.sh sync {ref.repo}` to fetch, or fix the hash"))
                continue
            if not clone.is_ancestor(sha):
                problems.append(Problem(art.file, ref.lineno, "not-ancestor",
                                        f"`{ref.token}`: commit {sha} is not an ancestor of the pinned "
                                        f"commit {pin.commit[:12]} — it is outside the pinned history"))
                continue

            if ref.kind == "commit":
                continue

            total = clone.blob_lines(sha, ref.path or "")
            if total is None:
                problems.append(Problem(art.file, ref.lineno, "no-such-file",
                                        f"`{ref.token}`: {ref.path} is not a file in {ref.repo} "
                                        f"at {sha[:12]}"))
                continue
            start, end = ref.line or 0, ref.end if ref.end is not None else (ref.line or 0)
            if ref.end is not None and ref.end < start:
                problems.append(Problem(art.file, ref.lineno, "bad-range",
                                        f"`{ref.token}`: end line {ref.end} precedes start line {start}"))
                continue
            if start < 1 or end > total:
                problems.append(Problem(art.file, ref.lineno, "line-out-of-range",
                                        f"`{ref.token}`: {ref.path} has {total} line(s) at "
                                        f"{sha[:12]}, so line {end} does not exist"))
                continue

    return problems, checked


# --------------------------------------------------------------------------
def main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(
        prog="check_anchors.py",
        description="Verify code anchors in study artifacts against their pinned target repos.",
    )
    ap.add_argument("targets", nargs="*", default=None,
                    help=f"files or directories to scan (default: {' '.join(DEFAULT_TARGETS)})")
    ap.add_argument("--root", default=None, help="repository root (default: this script's parent)")
    ap.add_argument("--pins", default=None, help="path to pins.tsv (default: <root>/repos/pins.tsv)")
    ap.add_argument("-v", "--verbose", action="store_true", help="list every anchor that was checked")
    ap.add_argument("--json", action="store_true", help="emit a JSON report on stdout")
    args = ap.parse_args(argv)

    root = Path(args.root).resolve() if args.root else Path(__file__).resolve().parent.parent
    pins_file = Path(args.pins).resolve() if args.pins else root / "repos" / "pins.tsv"
    targets = args.targets or DEFAULT_TARGETS

    pins = load_pins(pins_file)
    files = collect_files(root, targets)
    arts = [scan(f) for f in files]
    problems, checked = verify(root, arts, pins)

    if args.json:
        print(json.dumps({
            "root": str(root),
            "files": len(files),
            "anchors": checked,
            "problems": [{"file": str(p.file), "line": p.lineno, "code": p.code,
                          "message": p.message} for p in problems],
            "ok": not problems,
        }, indent=2))
        return 1 if problems else 0

    if args.verbose:
        for art in arts:
            rel = art.file.relative_to(root) if art.file.is_relative_to(root) else art.file
            marks = [f"{r.kind}:{r.token}" for r in art.refs]
            print(f"  scanned {rel} ({len(art.refs)} ref(s))" + (f": {', '.join(marks)}" if marks else ""))

    for p in problems:
        print(p.render(root), file=sys.stderr)

    scope = " ".join(targets)
    if problems:
        print(f"\ncheck_anchors: FAIL — {len(problems)} problem(s) in {checked} anchor(s) "
              f"across {len(files)} file(s) [{scope}]", file=sys.stderr)
        return 1
    print(f"check_anchors: OK — {checked} anchor(s) in {len(files)} file(s) verified "
          f"against {len(pins)} pin(s) [{scope}]")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main(sys.argv[1:]))
    except ConfigError as exc:
        print(exc, file=sys.stderr)
        sys.exit(2)
    except SystemExit:
        raise
    except KeyboardInterrupt:
        sys.exit(130)
