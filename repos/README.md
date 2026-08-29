# repos/

Pinned target repositories. Only `pins.tsv` and this file are tracked; every
`repos/<name>/` checkout is gitignored and rebuilt on demand:

```sh
scripts/pin.sh sync
```

## Why a full clone

`sync` clones with no `--depth` and no `--filter`, then detaches `HEAD` at the
pinned commit. That costs disk (mini-swe-agent: 21 MB for 1489 commits across
all refs, 1020 of them reachable from the pin) and
buys the one thing a study repository actually needs — the ability to ask, six
months later, *which commit introduced this logic*, without network access:

```console
$ cd repos/mini-swe-agent
$ git log --oneline -S 'MSWEA_GLOBAL_COST_LIMIT' --reverse --format='%h %ad %s' --date=short | head -1
af906e86 2025-07-09 Feat: add global cost tracking (#88)

$ git blame -L 96,96 --date=short -- src/minisweagent/agents/default.py
d5dadf058 src/microsweagent/agents/default.py (Kilian Lieret 2025-07-10 96)         while True:
```

Note the second command: `blame` reports the file's *old* path, so rename
tracking survives too. A `--depth 1` clone answers neither question, and a
`--filter=blob:none` clone answers them only by going back to the network for
every blob it needs — which is exactly what a pinned snapshot is supposed to
make unnecessary.

## Why this and not a submodule

A git submodule also pins a commit, and would work. Two reasons it is not used
here:

- A submodule records the pin in the git index, where it is invisible in a diff
  (`Subproject commit 25941c8...` and nothing else). `pins.tsv` puts the URL,
  the commit and a one-line note in a file that reviews readably.
- Submodule commands assume the superproject controls the checkout state.
  `scripts/pin.sh` keeps the target repositories strictly read-only and
  disposable — deleting `repos/<name>/` and re-running `sync` is always safe.

## Network policy

Cloning happens over HTTPS through this environment's egress proxy, which is
already configured for git; `https://github.com/...` URLs work as-is with no
credentials, because every target is a public repository read anonymously.
Use `https://` URLs in `pins.tsv` for that reason — `git@github.com:` SSH remotes
need a key this environment has no reason to hold.

If `sync` fails, it is one of two things:

- **The host is not allowed by the egress policy.** Report the blocked host
  rather than routing around it.
- **The pinned commit is gone** (branch deleted, history rewritten). `sync`
  fetches once and then says so. Pick a new commit with
  `scripts/pin.sh update <name> <ref>`, then re-run `make check` — every note
  written against the old commit will fail until it is re-read, which is the
  intended behaviour.
