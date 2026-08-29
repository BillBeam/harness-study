# harness-study

A learning repository for reading other people's agent harnesses closely.

The problem it solves: notes about code rot silently. You write "the retry loop
is in `models/litellm_model.py:82`", the upstream repo moves on, and a year
later the line number points at an import. This repo makes that failure
*loud* — every code reference is checked against a pinned commit of the
repository it points into, and the check runs in one command.

```
make check
```

That is the one command. It exits 0 when every anchor in `study/` and `points/`
resolves, and non-zero with a `file:line` report when one does not. (On a fresh
clone, run `make sync` once first — it materialises the pinned repositories the
check reads. `make check` tells you so if you forget.)

**What it does not check.** An anchor proves a *location* still exists; it says
nothing about whether the prose around it is true. This is not hypothetical: a
review of the first note in this repository found its central claim about
mini-swe-agent was wrong while all fifteen of its anchors resolved. Anchors keep
notes honest about where they point, and nothing else. Claims still need a
reader.

## Layout

| Path | Holds |
| --- | --- |
| `repos/` | pinned target repositories. `repos/pins.tsv` is tracked; the clones under it are not. |
| `study/<repo>/` | artifacts for one target repository — notes, traces, reading order. |
| `points/` | technical points: one file per idea, cutting across repositories. |
| `scripts/` | `pin.sh` (pin and materialise targets), `check_anchors.py` (the check), `selftest.sh`. |
| `matrix.md` | which repository × which technical point, and where the note is. |
| `LOG.md` | dated log of what was read and what came of it. |
| `tests/` | fixtures for the checker itself. Never scanned by `make check`. |

## Anchors

An **anchor** is a reference into a target repository that the checker can
prove still resolves. Write anchors inside backticks in ordinary prose.

Give a note front matter naming the repository and the commit it was written
against, and then use the short form:

```markdown
---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
---

The agent's control loop is `src/minisweagent/agents/default.py:96`, and the
budget guard that ends a run sits at `src/minisweagent/agents/default.py:132-147`.
```

Three shapes are recognised:

| Shape | Example | Checked |
| --- | --- | --- |
| code anchor, short | `path/to/file.py:97` or `path/to/file.py:97-120` | blob exists at the pinned commit; line(s) in range |
| code anchor, explicit | `repo@25941c89:path/to/file.py:97` | same, at the named commit |
| commit reference | `af906e86` (8+ hex) or `repo@af906e86` (7+ hex) | commit is in the clone and is an ancestor of the pin |

Rules worth knowing:

- **Front matter `commit:` must equal the current pin.** It is an assertion that
  the note was written against today's snapshot, not an alternate target. When a
  pin moves, every note pinned to the old commit fails, which is the prompt to
  re-read them.
- **Short-form anchors always resolve at the pin.** To point at history on
  purpose, use the explicit form; the commit must be an ancestor of the pin, so
  a note can never quietly reference code outside the pinned history.
- **Fenced code blocks are not scanned**, including a fence indented under a
  list item, one inside a blockquote, and a longer fence quoting a shorter one —
  so a note *about* fence syntax is safe. A fence that is never closed is
  reported (`unclosed-fence`) rather than silently swallowing the rest of the
  file, because a silent skip is the one way this checker could claim success
  while blind.
- **A short-form path needs a `/` or a `.ext`.** That keeps `localhost:8080` out
  of the checker's way. If a real path fits neither shape, use the explicit form.
- **A token that looks like an anchor but does not resolve is an error, not a
  skip.** If prose in backticks is mistaken for an anchor, drop the backticks.
  `example.com:443` is the shape most likely to trip this.
- **A bare commit reference needs 8+ lowercase hex**, which keeps English words
  out. One exception is unavoidable: an all-digit token is genuinely ambiguous
  (about 2% of abbreviated SHAs are all decimal), so it is resolved against the
  clone — a real SHA is checked like any other, a plain number is ignored. The
  cost is that a *mistyped* all-digit SHA is ignored too. Write an all-digit
  hash as `repo@12345678` to have it checked unconditionally.

Run `python3 scripts/check_anchors.py -v` to see every anchor the checker found,
or `--json` for a machine-readable report.

## Pinning a target repository

A pin is one tab-separated record in `repos/pins.tsv`:

```
name<TAB>url<TAB>40-hex-commit<TAB>note
```

```sh
scripts/pin.sh add <name> <url> [ref]   # resolve ref to a SHA, record it, clone
scripts/pin.sh sync                     # materialise every pin at its commit
scripts/pin.sh status                   # pinned vs. on-disk
scripts/pin.sh update <name> <ref>      # move a pin (then re-run make check)
```

`sync` makes a **full clone** with `HEAD` detached at the pinned commit. Full
history is the point, not an accident: a study note needs to answer "which
commit introduced this logic?" months later, and that means `git log -S`,
`git log -L` and `git blame` have to work offline against the clone. A shallow
(`--depth`) or blobless (`--filter=blob:none`) clone cannot answer those without
going back to the network. See `repos/README.md` for the network-policy
reasoning and the worked archaeology example.

The clones are gitignored. Nothing from a target repository is vendored here and
no target repository is ever modified — `repos/pins.tsv` plus `scripts/pin.sh`
is enough to reconstruct every checkout exactly.

## Adding a study

0. `make sync` — once per clone, materialise the pinned repositories.
1. `scripts/pin.sh add <name> <url>` — pin the repository (this syncs it too).
2. Create `study/<name>/NN-topic.md` with front matter naming the pin and its commit.
3. Read, and write anchors as you go.
4. `make check` — until it exits 0.
5. Add a row to `matrix.md` and an entry to `LOG.md`.

## Checking the checker

```
make selftest
```

Runs the checker against `tests/` — an empty artifact set, a known-good note, a
deliberately wrong anchor, and one case per failure mode — and asserts the exact
exit code, error codes and, where it matters, *how much was actually looked at*.
That last part is the difference between "checked it and it was fine" and "never
looked": without a count, a regression to silence passes as a success.

`tests/` lives outside the `make check` scan, so its deliberately broken files
never affect the real run. Every assertion fails rather than skips — a check
that quietly declines to run is the same defect the checker exists to prevent.
