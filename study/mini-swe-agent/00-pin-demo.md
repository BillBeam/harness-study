---
repo: mini-swe-agent
commit: 25941c89cfbc91eb40b3f8756348c91d9977d57e
title: pinning demo — the shape of the harness
---

# mini-swe-agent, pinned

This note exists to prove the scaffold works end to end: a pinned target
repository, anchors that `make check` verifies against the pinned commit, and
history deep enough to ask when each piece arrived. The reading proper starts at
`01-*`; what follows is a first pass over the seams, chosen because each one is
a place other harnesses make a visibly different choice.

Pinned at `25941c89cfbc91eb40b3f8756348c91d9977d57e` — 1020 commits reachable
from the pin, so every `git log -S` below runs offline.

## Four seams

**The run loop.** `src/minisweagent/agents/default.py:96-124` is the whole
control loop: an unbounded `while True` that calls `step()`, turns
`FormatError` and `InterruptAgentFlow` into appended messages, saves the
trajectory in a `finally`, and stops on a condition worth noticing — not a
return value, but the *role* of the last message being `exit`. The loop then
returns that message's `extra` dict as the run result. Termination is a fact
about the conversation, not about the call stack.

**Termination is raised, not returned.** The exception hierarchy in
`src/minisweagent/exceptions.py:4-6` gives every control-flow exception a
constructor that stores conversation messages. So a raise site anywhere in the
stack decides both *that* the run should stop and *what the transcript says
about why*. The budget guard at
`src/minisweagent/agents/default.py:132-147` uses it: step, cost and wall-clock
limits are checked before any model call, and each raises an exception carrying
a ready-made `exit` message. The `0 < limit <= current` idiom there is how
"0 means unlimited" is encoded for all three budgets.

**The environment decides when the task is done.** Not the agent:
`src/minisweagent/environments/local.py:48-56` inspects the executed command's
own stdout for a sentinel first line and raises `Submitted` with the remaining
output as the submission. The agent loop never tests for completion; it just
catches what the environment threw. Execution itself is
`src/minisweagent/environments/local.py:74-85` — one `subprocess.Popen` with
`shell=True`, stderr folded into stdout, child in its own process group so a
timeout can kill the whole group rather than orphaning children.

**Config is merged, then wired.** `src/minisweagent/run/mini.py:92` collapses
every `-c` spec plus the CLI flags into one nested dict by recursive merge, and
`src/minisweagent/run/mini.py:99-102` splits that dict into `model` /
`environment` / `agent` sub-dicts and hands each to a factory that resolves a
class name. Swapping a backend is a config edit, not a code path. The per-spec
half of that lives in `src/minisweagent/config/__init__.py:56-61`.

## What the history is for

The pin keeps the anchors above stable. The *history* behind the pin answers the
question a stale note cannot: when did this become true?

```console
$ git log --oneline -S 'MSWEA_GLOBAL_COST_LIMIT' --reverse --format='%h %ad %s' --date=short | head -1
af906e86 2025-07-09 Feat: add global cost tracking (#88)

$ git log -L 88,124:src/minisweagent/agents/default.py --format='%h %ad %s' --date=short -s 25941c89 | head -3
40fa3652 2026-07-22 fix(agents): count billed calls that fail to parse against cost_limit (#915)
6e0413ca 2026-06-10 Enh: Cap consecutive format errors (#863)
d17fd292 2026-01-09 Agent must pass all messages through Model.format_message
```

Three answers fall out of that, each a commit this repository can still reach:

- Process-wide cost tracking (`src/minisweagent/models/__init__.py:30-31`,
  which raises rather than returning when a global budget is exhausted) arrived
  in `af906e86`.
- The exit-sentinel protocol the local environment keys on came in `22d33edf`.
- The run loop stopped being organised around exceptions and started being
  organised around messages in `10dfc4ea` — a breaking change, and the reason
  the loop's stop condition reads the way it does today.

That last one is the payoff. Reading `src/minisweagent/agents/default.py:96-124`
cold, the message-role termination check looks arbitrary. Reading it next to
`10dfc4ea` it is a deliberate reversal, and the question to carry into the next
harness becomes: *does this one terminate on a value, an exception, or a
message?*

## Anchors, deliberately

Every backticked reference above is checked. Break one — change a line number,
move the pin — and `make check` fails with the note's own `file:line`. That is
the entire point of the scaffold: a note that has gone stale says so.
