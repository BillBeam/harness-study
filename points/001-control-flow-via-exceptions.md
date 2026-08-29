---
title: how a harness decides a run is over
status: seeded
---

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
condition, which is a more interesting combination than either alone.

The exception base class carries messages rather than a status:
`mini-swe-agent@25941c89:src/minisweagent/exceptions.py:4`. Every control-flow
exception inherits that constructor, so a raise site chooses both that the run
stops and what the transcript records. The loop then does not branch on the
exception type to decide termination — it appends whatever messages came with
the exception and tests the *last message's role*:
`mini-swe-agent@25941c89:src/minisweagent/agents/default.py:96`.

The consequence is that "why did this run end" is answerable from the saved
trajectory alone, with no separate exit-code field to keep in sync. It also
means an environment can end a run without the agent knowing that is possible:
`mini-swe-agent@25941c89:src/minisweagent/environments/local.py:48` raises on a
sentinel it finds in command output.

This was not the original design. The reversal is `mini-swe-agent@10dfc4ea`,
labelled a breaking change at the time.

## Open questions for the next harness

- Does the stop condition read a value, an exception, or the transcript?
- Can a component other than the agent end a run? An environment? A model?
- Is the exit reason recoverable from a saved trajectory, or only from logs?
