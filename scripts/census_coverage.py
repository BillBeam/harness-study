#!/usr/bin/env python3
"""Prove a per-file census actually covers every file it claims to cover.

`check_anchors.py` proves each reference in a note still *resolves*. It says
nothing about what was never written down. A census -- a note that walks a
target repository file by file -- has the opposite failure mode: the anchors
are all green and half the tree was simply never opened.

This script closes that hole. For a pinned repository it

  1. enumerates the files that *should* be censused at the pinned commit,
  2. collects the files the census *claims*, one per section heading, and
  3. reports every file in (1) with no claim, and every file claimed twice.

Either list being non-empty is a failure (exit 1). A usage or configuration
problem exits 2, distinct from a failed check, exactly as in check_anchors.py.

WHAT COUNTS AS "SHOULD BE CENSUSED"
-----------------------------------
The scope is source, composition config (`cordis*.yml` and friends), prompt
text, snapshots, shipped documentation, and per-package READMEs -- the material
a reader has to have opened to claim they read the harness. It is computed from
`git ls-tree` at the pin, never from the working tree, so an untracked or
stale file on disk can neither pad nor dent the scope.

Excluded everywhere: dependency trees, build output, lockfiles, binaries and
tests. Those rules live in EXCLUDE_* below, at the top of this file, and a
repository that needs a different scope overrides them in REPO_SCOPE rather
than by editing the rules.

WHERE THE CENSUS LIVES
----------------------
Both shapes are accepted, because a small target does not need a directory:

    study/<repo>/census/*.md      one file per grouping (a workspace package)
    study/<repo>/census.md        a single file

A claim is a Markdown heading whose text is a repository-relative path --
`### src/minisweagent/agents/default.py`. Backticks around it are fine. Nothing
else counts: a path mentioned in prose or in a link is a *reference*, and this
script is asking a different question -- which file did someone sit down and
walk. That is also why "claimed twice" is an error: two sections for one file
means the walk was duplicated, and one of them is stale.

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

# ==========================================================================
# Scope rules
# ==========================================================================
#
# Read top to bottom: a file is in scope when it sits under one of the
# repository's roots, is not excluded, and matches an include rule.

# --------------------------------------------------------------------------
# 1. Excluded directories -- dependency trees and build output.
#
# Enumeration is from git, so a tracked file is the only thing that can reach
# these rules at all. They are kept anyway: a repository that commits its
# `dist/` would otherwise silently enlarge every census that touches it.
# --------------------------------------------------------------------------
EXCLUDE_DIRS = {
    "node_modules", ".git", ".hg", ".svn",
    "dist", "build", "out", "lib-cov", "coverage", ".nyc_output",
    "__pycache__", ".venv", "venv", ".tox", ".mypy_cache", ".pytest_cache",
    ".next", ".nuxt", ".svelte-kit", ".turbo", ".cache",
    "target",          # cargo
    "site-packages",
}

# --------------------------------------------------------------------------
# 2. Excluded test material.
#
# The card's rule, literally: `*.test.*`, `__tests__/`, `test/`, `tests/`.
# `__mocks__/`, `__snapshots__/` and `*.spec.*` are the same category under
# other spellings -- material that exists to exercise the harness rather than
# to be the harness. `e2e/` is NOT in this set: it is a directory name a
# product feature can legitimately carry, and the repositories studied here
# spell their end-to-end tests `*.e2e.spec.ts`, which the file rule already
# catches.
# --------------------------------------------------------------------------
EXCLUDE_TEST_DIRS = {"__tests__", "test", "tests", "__mocks__", "__snapshots__"}
EXCLUDE_TEST_FILE_RE = re.compile(r"\.(?:test|spec)\.[A-Za-z0-9]+$")

# --------------------------------------------------------------------------
# 3. Excluded lockfiles.
#
# A lockfile is a resolver's output. Reading one tells you which versions were
# pinned, never what the harness does with them.
# --------------------------------------------------------------------------
EXCLUDE_LOCKFILES = {
    "pnpm-lock.yaml", "package-lock.json", "npm-shrinkwrap.json", "yarn.lock",
    "bun.lockb", "bun.lock", "deno.lock",
    "Cargo.lock", "poetry.lock", "uv.lock", "Pipfile.lock", "Gemfile.lock",
    "composer.lock", "go.sum", "flake.lock",
}

# --------------------------------------------------------------------------
# 4. Excluded binaries.
#
# Extension first, then a NUL sniff of the blob for anything whose extension
# this list has never heard of. The sniff is what keeps the rule honest: a new
# binary format under an unknown extension is excluded because it *is* binary,
# not because someone remembered to add it here.
# --------------------------------------------------------------------------
EXCLUDE_BINARY_EXT = {
    ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".ico", ".webp", ".avif", ".tiff",
    ".woff", ".woff2", ".ttf", ".otf", ".eot",
    ".zip", ".gz", ".tgz", ".bz2", ".xz", ".zst", ".7z", ".rar", ".tar",
    ".bin", ".dat", ".exe", ".dll", ".so", ".dylib", ".node", ".wasm", ".a", ".o",
    ".pdf", ".mp3", ".mp4", ".mov", ".webm", ".wav", ".ogg",
    ".pyc", ".pyo", ".class", ".jar", ".pdb", ".db", ".sqlite", ".sqlite3",
}

# --------------------------------------------------------------------------
# 5. Include rules -- the six kinds named on the card.
#
# `kind_of` returns the first kind that matches, and the kind is carried into
# the report so a scope argument is settled by looking at the label rather than
# by re-deriving why a path is there.
# --------------------------------------------------------------------------
INCLUDE_SOURCE_EXT = {
    ".ts", ".tsx", ".js", ".jsx", ".mjs", ".cjs", ".mts", ".cts",
    ".py", ".rs", ".go", ".rb", ".java", ".kt", ".swift",
    ".c", ".cc", ".cpp", ".cxx", ".h", ".hh", ".hpp",
    ".sh", ".bash", ".zsh", ".fish", ".ps1", ".bat",
    ".css", ".scss", ".sass", ".less", ".tcss", ".vue", ".svelte",
    ".sql", ".graphql", ".proto",
}
# Composition config: the `cordis*.yml` family the card names, plus the
# `*.patch.yml` overlays that compose against them.
INCLUDE_COMPOSITION_RE = re.compile(
    r"(?:^|[.\-])cordis(?:[.\-][^/]*)?\.ya?ml$|\.patch\.ya?ml$", re.IGNORECASE
)
# The other spelling of the same thing: YAML that a harness loads *as* its
# composition, recognised by the directory it is filed under rather than by its
# name. mini-swe-agent's agent definitions live in `config/`, not in anything
# called cordis; naming only the cordis family would leave them uncounted.
INCLUDE_COMPOSITION_DIRS = {"config", "configs", "presets", "profiles", "compositions"}
# Package/build manifests. A manifest is composition too: `bin`, `exports` and
# `files` decide what a consumer can even reach.
# `py.typed` carries no content at all -- its presence is the whole signal, and
# a census that skipped it would be skipping a packaging decision.
INCLUDE_MANIFEST_NAMES = {
    "package.json", "pyproject.toml", "Cargo.toml", "go.mod", "setup.py",
    "pnpm-workspace.yaml", "tsconfig.json", "py.typed",
}
# Prompt text carried as a file rather than inline in source.
INCLUDE_PROMPT_RE = re.compile(
    r"(?:^|/)(?:prompts?|personas?|instructions?|skills?|presets?)/.*\.(?:md|txt|hbs|jinja|j2|mustache)$"
    r"|(?:^|/)SKILL\.md$",
    re.IGNORECASE,
)
INCLUDE_README_RE = re.compile(r"(?:^|/)(?:README|AGENTS|CLAUDE)\.md$")
# Text kinds that are in scope only inside a root declared as documentation or
# snapshot material (see REPO_SCOPE), never repository-wide.
INCLUDE_TEXT_EXT = {".md", ".txt", ".yml", ".yaml", ".json", ".jsonl", ".toml", ".ini", ".cfg", ".xml", ".html"}

# --------------------------------------------------------------------------
# 6. Per-repository scope.
#
# `roots`      subtrees that hold the harness. "" means the repository root's
#              own files, at depth 0 only.
# `doc_roots`  subtrees whose text files are shipped documentation or snapshot
#              material, so plain `.md`/`.json`/`.yml` under them is in scope
#              even though the same extension is not in scope elsewhere.
# `exclude`    extra path rules, each with the reason it is there. A repository
#              that needs a *narrower* scope says so here rather than by
#              weakening a rule above for everyone.
#
# A repository with no entry falls back to DEFAULT_SCOPE: the whole tree, with
# only the universal rules applied. That default is deliberately loud rather
# than convenient -- a new pin reports its entire tree as uncovered until
# somebody states what its harness actually is.
# --------------------------------------------------------------------------
DEFAULT_SCOPE = {"roots": [""], "doc_roots": [], "exclude": []}

REPO_SCOPE: dict[str, dict] = {
    # The whole harness is `src/`; `pyproject.toml` declares the entry points
    # and ships `config/**` from inside `src/`. `docs/` is the published manual
    # (a rewrite of the code in prose) and `tests/` is excluded by rule.
    "mini-swe-agent": {
        "roots": ["src", "pyproject.toml"],
        "doc_roots": [],
        "exclude": [],
    },
    # Nine roots hold the shipped harness. `.agents/` is deliberately out:
    # by its own README it is a tree of Agent Notes -- decision records about
    # the code -- which is none of the six kinds the census is defined over.
    "deepseek-harness": {
        "roots": [
            "packages", "apps", "vendor", "native", "python",
            "scripts", "website", "docs", "snapshots", "",
        ],
        "doc_roots": ["docs", "snapshots"],
        "exclude": [
            # Translations and their pairing records. `X.zh.md` is a translation
            # of `X.md`, which is itself in scope; `X.i18n.yaml` is not prose at
            # all but a generated record of the two blob hashes last confirmed
            # consistent (see the header of any such file). Censusing either
            # would count one file's mechanisms twice.
            (r"\.zh\.md$", "译文，其原文已在范围内"),
            (r"\.i18n\.yaml$", "译文一致性记录，由 verify-translation-pairing 生成"),
            # `patches/` holds upstream diffs applied at install time; the
            # patched dependency is not this harness's source.
            (r"^patches/", "对第三方依赖打的补丁，不是本仓库源码"),
        ],
    },
    # The harness is the CLI product and what it links against: `opencode`
    # (CLI, session loop, tools, server routes), `core` (v2 core: database,
    # tool set, runner), `tui`, `server`, `plugin`, `schema`, `protocol`,
    # `llm`, `sdk` / `sdk-next` / `client` (the wire contract and its
    # generated clients), `codemode`, `httpapi-codegen`, the two sqlite
    # layers, and the root's own files. `packages/web/src/content/docs` is the
    # shipped manual (opencode.ai/docs). Out by name: the web / desktop / app
    # / console / storybook / session-ui / ui / stats / enterprise front ends,
    # the `slack` bot, cloud glue (`function`, `script`, `containers`,
    # `identity`, `cli` = the `lildax` console CLI, `infra`, `nix`, `sdks`),
    # `artifacts/` (a marketing video), `specs/`, `github/`, and `patches/`.
    "opencode": {
        "roots": [
            "packages/opencode", "packages/core", "packages/tui",
            "packages/server", "packages/plugin", "packages/schema",
            "packages/protocol", "packages/llm", "packages/sdk",
            "packages/sdk-next", "packages/client", "packages/codemode",
            "packages/httpapi-codegen", "packages/effect-drizzle-sqlite",
            "packages/effect-sqlite-node", "packages/web/src/content/docs", "",
        ],
        "doc_roots": ["packages/web/src/content/docs"],
        "exclude": [
            # Translations of the root README and of the docs; the originals
            # are in scope.
            (r"^README\.[a-z]{2,3}\.md$", "译文，其原文 README.md 已在范围内"),
            (r"^packages/web/src/content/docs/[a-z]{2}(-[a-z]{2})?/", "文档译文，其原文已在范围内"),
            # Generated code: the SDK's `gen/`, the client's `generated*/`,
            # and drizzle's `*.gen.ts` are outputs of files already in scope.
            (r"^packages/sdk/js/src/gen/", "由 httpapi 定义生成，其来源已在范围内"),
            (r"^packages/client/src/generated(-effect)?/", "由 httpapi 定义生成，其来源已在范围内"),
            (r"\.gen\.ts$", "生成文件，其来源已在范围内"),
        ],
    },
}


class ConfigError(Exception):
    """A usage or configuration problem. Exits 2, distinct from a failed check."""


# ==========================================================================
# Pins
# ==========================================================================
@dataclass(frozen=True)
class Pin:
    name: str
    url: str
    commit: str


def load_pins(pins_file: Path) -> dict[str, Pin]:
    """Same format and same strictness as check_anchors.py, read independently.

    Sharing a loader would couple this script's exit codes to that one's; the
    format is three tab-separated fields and re-reading it is cheaper than the
    coupling.
    """
    if not pins_file.is_file():
        raise ConfigError(f"census_coverage: missing pins file {pins_file}")
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
        if not re.fullmatch(r"[0-9a-f]{40}", commit):
            raise ConfigError(f"{pins_file}:{lineno}: commit {commit!r} is not a full 40-hex SHA")
        if name in pins:
            raise ConfigError(f"{pins_file}:{lineno}: duplicate pin {name!r}")
        pins[name] = Pin(name, url, commit)
    return pins


# ==========================================================================
# Scope
# ==========================================================================
def _git(repo_dir: Path, *args: str) -> str:
    proc = subprocess.run(
        ["git", "-C", str(repo_dir), *args],
        capture_output=True, text=True, errors="replace",
    )
    if proc.returncode != 0:
        raise ConfigError(f"census_coverage: git {' '.join(args)} failed in {repo_dir}: "
                          f"{proc.stderr.strip()}")
    return proc.stdout


def list_tree(repo_dir: Path, commit: str) -> list[str]:
    """Every path in the tree at `commit`. Not the working tree: the pin."""
    out = _git(repo_dir, "ls-tree", "-r", "--name-only", "-z", commit)
    return [p for p in out.split("\0") if p]


def _under_root(path: str, root: str) -> bool:
    if root == "":
        return "/" not in path          # depth-0 files only
    return path == root or path.startswith(root + "/")


def _ext(path: str) -> str:
    base = os.path.basename(path)
    dot = base.rfind(".")
    return base[dot:].lower() if dot > 0 else ""


def excluded_reason(path: str, extra: list[tuple[str, str]]) -> str | None:
    """Why this path is out of scope, or None if no exclusion applies."""
    parts = path.split("/")
    base = parts[-1]
    for seg in parts[:-1]:
        if seg in EXCLUDE_DIRS:
            return f"依赖树或构建产物目录 {seg}/"
        if seg in EXCLUDE_TEST_DIRS:
            return f"测试目录 {seg}/"
    if EXCLUDE_TEST_FILE_RE.search(base):
        return "测试文件"
    if base in EXCLUDE_LOCKFILES:
        return "锁文件"
    if _ext(path) in EXCLUDE_BINARY_EXT:
        return "二进制"
    for pattern, reason in extra:
        if re.search(pattern, path):
            return reason
    return None


def kind_of(path: str, doc_roots: list[str]) -> str | None:
    """Which of the six census kinds this path is, or None if it is none of them."""
    base = os.path.basename(path)
    ext = _ext(path)
    if ext in INCLUDE_SOURCE_EXT:
        return "源码"
    if INCLUDE_COMPOSITION_RE.search(base):
        return "组合配置"
    if ext in (".yml", ".yaml") and any(
        seg in INCLUDE_COMPOSITION_DIRS for seg in path.split("/")[:-1]
    ):
        return "组合配置"
    if INCLUDE_PROMPT_RE.search(path):
        return "提示词文本"
    if INCLUDE_README_RE.search(path):
        return "包 README"
    if base in INCLUDE_MANIFEST_NAMES:
        return "清单"
    if any(_under_root(path, r) for r in doc_roots) and ext in INCLUDE_TEXT_EXT:
        return "文档或 snapshot"
    return None


def _is_binary_blob(repo_dir: Path, commit: str, path: str) -> bool:
    """NUL sniff on the first 8 KiB, for extensions the lists above do not name."""
    proc = subprocess.run(
        ["git", "-C", str(repo_dir), "show", f"{commit}:{path}"],
        capture_output=True,
    )
    return proc.returncode == 0 and b"\0" in proc.stdout[:8192]


@dataclass
class ScopeEntry:
    path: str
    kind: str


def compute_scope(repo_dir: Path, repo: str, commit: str) -> tuple[list[ScopeEntry], dict[str, int]]:
    """The files that should be censused, and a tally of why the rest were dropped."""
    cfg = REPO_SCOPE.get(repo, DEFAULT_SCOPE)
    roots: list[str] = cfg["roots"]
    doc_roots: list[str] = cfg.get("doc_roots", [])
    extra = [(p, r) for p, r in cfg.get("exclude", [])]

    scope: list[ScopeEntry] = []
    dropped: dict[str, int] = {}
    known_ext = INCLUDE_SOURCE_EXT | INCLUDE_TEXT_EXT | EXCLUDE_BINARY_EXT
    for path in list_tree(repo_dir, commit):
        if not any(_under_root(path, r) for r in roots):
            dropped["不在本仓库声明的 roots 下"] = dropped.get("不在本仓库声明的 roots 下", 0) + 1
            continue
        why = excluded_reason(path, extra)
        if why:
            dropped[why] = dropped.get(why, 0) + 1
            continue
        kind = kind_of(path, doc_roots)
        if kind is None:
            dropped["不属于普查的六类"] = dropped.get("不属于普查的六类", 0) + 1
            continue
        # Unknown extension: settle it by looking at the bytes, not the name.
        if _ext(path) not in known_ext and _is_binary_blob(repo_dir, commit, path):
            dropped["二进制"] = dropped.get("二进制", 0) + 1
            continue
        scope.append(ScopeEntry(path, kind))
    scope.sort(key=lambda e: e.path)
    return scope, dropped


# ==========================================================================
# Claims
# ==========================================================================
# A heading is a claim when its text is a path. Backticks and a trailing
# permalink are both tolerated, because a census written for a human reader
# tends to carry one or the other.
HEADING_RE = re.compile(r"^(?P<hashes>#{2,6})\s+(?P<text>.+?)\s*$")
FENCE_RE = re.compile(r"^\s*(?P<fence>`{3,}|~{3,})")


@dataclass
class Claim:
    path: str
    source: str          # census file, repo-relative
    line: int


def census_files(root: Path, repo: str) -> list[Path]:
    """`study/<repo>/census/**/*.md` plus `study/<repo>/census.md`, whichever exist."""
    base = root / "study" / repo
    found: list[Path] = []
    single = base / "census.md"
    if single.is_file():
        found.append(single)
    directory = base / "census"
    if directory.is_dir():
        found.extend(sorted(p for p in directory.rglob("*.md") if p.is_file()))
    return found


def collect_claims(root: Path, repo: str, scope_paths: set[str]) -> tuple[list[Claim], list[Claim]]:
    """Every heading that names a path. Returns (claims in scope, claims outside it).

    Fenced blocks are skipped for the same reason check_anchors.py skips them:
    a census that *documents* this heading convention must not be read as making
    the claims it is describing.
    """
    claims: list[Claim] = []
    outside: list[Claim] = []
    for f in census_files(root, repo):
        rel = f.relative_to(root).as_posix()
        fence: str | None = None
        for lineno, raw in enumerate(f.read_text(encoding="utf-8").splitlines(), 1):
            m = FENCE_RE.match(raw)
            if m:
                marker = m.group("fence")
                if fence is None:
                    fence = marker
                elif marker[0] == fence[0] and len(marker) >= len(fence):
                    fence = None
                continue
            if fence is not None:
                continue
            h = HEADING_RE.match(raw)
            if not h:
                continue
            text = h.group("text").strip().strip("`").strip()
            # A heading may end in a parenthesised note; the path is the head.
            candidate = text.split()[0].strip("`") if text else ""
            if not candidate or candidate != text:
                # Only an exact, bare path counts. A prose heading that merely
                # begins with a word is not a claim, and treating it as one
                # would let "## 二、按包看" collide with a file called 二、按包看.
                continue
            if candidate in scope_paths:
                claims.append(Claim(candidate, rel, lineno))
            elif "/" in candidate or re.search(r"\.[A-Za-z0-9]{1,8}$", candidate):
                outside.append(Claim(candidate, rel, lineno))
    return claims, outside


# ==========================================================================
# Report
# ==========================================================================
@dataclass
class Result:
    repo: str
    commit: str
    scope: list[ScopeEntry] = field(default_factory=list)
    dropped: dict[str, int] = field(default_factory=dict)
    uncovered: list[ScopeEntry] = field(default_factory=list)
    duplicated: list[tuple[str, list[Claim]]] = field(default_factory=list)
    stray: list[Claim] = field(default_factory=list)
    census_files: list[str] = field(default_factory=list)
    claims: int = 0


def check_repo(root: Path, pin: Pin, verbose: bool) -> Result:
    repo_dir = root / "repos" / pin.name
    if not (repo_dir / ".git").is_dir():
        raise ConfigError(
            f"census_coverage: repos/{pin.name} is not materialised. Run `make sync` first."
        )
    have = subprocess.run(
        ["git", "-C", str(repo_dir), "cat-file", "-e", f"{pin.commit}^{{commit}}"],
        capture_output=True,
    )
    if have.returncode != 0:
        raise ConfigError(
            f"census_coverage: repos/{pin.name} does not contain its pinned commit "
            f"{pin.commit[:12]}. Run `make sync` first."
        )

    scope, dropped = compute_scope(repo_dir, pin.name, pin.commit)
    scope_paths = {e.path for e in scope}
    files = census_files(root, pin.name)
    claims, outside = collect_claims(root, pin.name, scope_paths)

    by_path: dict[str, list[Claim]] = {}
    for c in claims:
        by_path.setdefault(c.path, []).append(c)

    res = Result(repo=pin.name, commit=pin.commit, scope=scope, dropped=dropped)
    res.census_files = [f.relative_to(root).as_posix() for f in files]
    res.claims = len(claims)
    res.uncovered = [e for e in scope if e.path not in by_path]
    res.duplicated = [(p, cs) for p, cs in sorted(by_path.items()) if len(cs) > 1]
    # A heading naming a path that is not in scope is reported only when the
    # path does not exist at the pin at all -- that is drift or a typo. A
    # heading for a real file the scope rules left out is extra work, not a
    # defect, so it is counted and otherwise left alone.
    real = set(list_tree(repo_dir, pin.commit)) if outside else set()
    res.stray = [c for c in outside if c.path not in real]
    if verbose:
        res.dropped = dropped
    return res


def human_report(results: list[Result], verbose: bool) -> tuple[str, int]:
    lines: list[str] = []
    failures = 0
    for r in results:
        lines.append(f"== {r.repo} @ {r.commit[:12]} ==")
        if not r.census_files:
            lines.append(f"  no census found at study/{r.repo}/census/ or study/{r.repo}/census.md")
        else:
            lines.append(f"  census: {len(r.census_files)} file(s), {r.claims} claim(s)")
        lines.append(f"  scope:  {len(r.scope)} file(s) should be censused")
        if verbose:
            kinds: dict[str, int] = {}
            for e in r.scope:
                kinds[e.kind] = kinds.get(e.kind, 0) + 1
            for k, n in sorted(kinds.items(), key=lambda kv: -kv[1]):
                lines.append(f"            {n:6d}  {k}")
            lines.append("  out of scope:")
            for why, n in sorted(r.dropped.items(), key=lambda kv: -kv[1]):
                lines.append(f"            {n:6d}  {why}")
        if r.uncovered:
            failures += 1
            lines.append(f"  UNCOVERED ({len(r.uncovered)}):")
            for e in r.uncovered:
                lines.append(f"    {e.path}  [{e.kind}]")
        else:
            lines.append("  uncovered: none")
        if r.duplicated:
            failures += 1
            lines.append(f"  DUPLICATED ({len(r.duplicated)}):")
            for path, cs in r.duplicated:
                where = ", ".join(f"{c.source}:{c.line}" for c in cs)
                lines.append(f"    {path}  claimed at {where}")
        else:
            lines.append("  duplicated: none")
        if r.stray:
            failures += 1
            lines.append(f"  STRAY ({len(r.stray)}) -- heading names a path absent at the pin:")
            for c in r.stray:
                lines.append(f"    {c.path}  at {c.source}:{c.line}")
        lines.append("")
    return "\n".join(lines), failures


def main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(
        prog="census_coverage.py",
        description="Prove a per-file census covers every file it should, exactly once.",
    )
    ap.add_argument("repos", nargs="*", default=None,
                    help="pin names to check (default: every pin that has a census)")
    ap.add_argument("--root", default=None, help="repository root (default: this script's parent)")
    ap.add_argument("--pins", default=None, help="path to pins.tsv (default: <root>/repos/pins.tsv)")
    ap.add_argument("--study", default=None,
                    help=argparse.SUPPRESS)  # reserved; census location is derived from --root
    ap.add_argument("-v", "--verbose", action="store_true",
                    help="also break the scope down by kind and show why files were dropped")
    ap.add_argument("--json", action="store_true", help="emit a JSON report on stdout")
    args = ap.parse_args(argv)

    root = Path(args.root).resolve() if args.root else Path(__file__).resolve().parent.parent
    pins_file = Path(args.pins) if args.pins else root / "repos" / "pins.tsv"

    try:
        pins = load_pins(pins_file)
        if args.repos:
            unknown = [n for n in args.repos if n not in pins]
            if unknown:
                raise ConfigError(f"census_coverage: no such pin: {', '.join(unknown)}")
            wanted = [pins[n] for n in args.repos]
        else:
            # Default to every pin that actually has a census. A pin with none
            # is not a failure -- it has not been studied yet -- but naming one
            # explicitly is, so `make coverage` stays quiet while the study
            # grows and `census_coverage.py <pin>` stays a real assertion.
            wanted = [p for p in pins.values() if census_files(root, p.name)]
            if not wanted:
                raise ConfigError(
                    "census_coverage: no pin has a census "
                    "(expected study/<repo>/census/ or study/<repo>/census.md)"
                )
        results = [check_repo(root, p, args.verbose) for p in wanted]
    except ConfigError as e:
        print(str(e), file=sys.stderr)
        return 2

    text, failures = human_report(results, args.verbose)
    if args.json:
        print(json.dumps({
            "repos": [
                {
                    "repo": r.repo,
                    "commit": r.commit,
                    "scope": len(r.scope),
                    "claims": r.claims,
                    "census_files": r.census_files,
                    "uncovered": [{"path": e.path, "kind": e.kind} for e in r.uncovered],
                    "duplicated": [
                        {"path": p, "at": [f"{c.source}:{c.line}" for c in cs]}
                        for p, cs in r.duplicated
                    ],
                    "stray": [{"path": c.path, "at": f"{c.source}:{c.line}"} for c in r.stray],
                    "dropped": r.dropped,
                }
                for r in results
            ],
            "uncovered": sum(len(r.uncovered) for r in results),
            "duplicated": sum(len(r.duplicated) for r in results),
            "stray": sum(len(r.stray) for r in results),
            "ok": failures == 0,
        }, ensure_ascii=False))
    else:
        print(text, end="")
        if failures == 0:
            n = sum(len(r.scope) for r in results)
            print(f"census_coverage: {n} file(s) across {len(results)} repo(s), "
                  f"each covered exactly once.")
    return 0 if failures == 0 else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
