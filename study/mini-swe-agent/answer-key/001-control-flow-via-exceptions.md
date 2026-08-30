---
title: how a harness decides a run is over
status: seeded
---

执行位示范，先写自己的走查再打开对照，不作论断依据

> 中文：[001-control-flow-via-exceptions.zh-CN.md](001-control-flow-via-exceptions.zh-CN.md)

# Control flow: how a run ends

Every agent harness needs an answer to "the run is finished now." The answer is
load-bearing, because it decides where the *reason* for stopping is allowed to
come from, and how much of the harness has to agree on it.

Three shapes show up:

1. **Return a value.** The step function returns a done-flag or a result object;
   the loop tests it. Simple, but only the code that owns the loop can end a run,
   so anything deeper in the stack has to thread a signal back up.
2. **Raise an exception.** Any depth can stop the run. The cost is that the
   *reason* lives in the exception type, so the loop needs a handler per reason.
3. **Append a message.** The loop's stop condition reads the transcript. The
   reason ends up in the same place as everything else the agent said, which
   means it survives serialisation for free.

## mini-swe-agent

Pinned at `mini-swe-agent@25941c89`. It uses (2) as the transport and (3) as the
condition, and the split between those two is the whole design.

The exception base class carries messages rather than a status:
`mini-swe-agent@25941c89:src/minisweagent/exceptions.py:4`. Every control-flow
exception inherits that constructor. Note what a raise site therefore chooses:
**only what the transcript records** — not whether the run ends. Termination is
decided afterwards, by the loop, from the role of the last message:
`mini-swe-agent@25941c89:src/minisweagent/agents/default.py:122`.

That distinction is not academic. At the pin there are 15 control-flow raise
sites; 9 carry `role: "exit"` and end the run, and 6 carry `role: "user"` and do
not. Every `FormatError` is in the second group
(`mini-swe-agent@25941c89:src/minisweagent/models/utils/actions_text.py:27`), and
so is `UserInterruption`
(`mini-swe-agent@25941c89:src/minisweagent/agents/interactive.py:41`). Raising
one of those is how the harness says "that output was malformed, try again" —
an exception used purely as a message-injection channel, with no control-flow
meaning at all.

The consequence is that "why did this run end" is answerable from the saved
trajectory alone, with no separate exit-code field to keep in sync. It also
means an environment can end a run without the agent knowing that is possible:
`mini-swe-agent@25941c89:src/minisweagent/environments/local.py:48` raises on a
sentinel it finds in command output.

One place still breaks the rule, and it is worth knowing why. The loop has a
dedicated `except FormatError` arm that counts consecutive failures and, at the
cap, synthesizes the `role: "exit"` message *itself*:
`mini-swe-agent@25941c89:src/minisweagent/agents/default.py:100-112`. There the
loop ends the run, and it can only do so by branching on the exception type.

The layering is visible in the history. `mini-swe-agent@10dfc4ea` removed
type-based termination — before it, the loop read `isinstance(e,
TerminatingException): return`, so the exception type really did decide.
Five months later `mini-swe-agent@6e0413ca` added the consecutive-format-error
cap and put exactly one type branch back. A pure design lasted five months and
then bought an exception for a real operational need: a model looping on
malformed output would otherwise never stop.

## Open questions for the next harness

- Does the stop condition read a value, an exception, or the transcript?
- Can a component other than the agent end a run? An environment? A model?
- Is the exit reason recoverable from a saved trajectory, or only from logs?
