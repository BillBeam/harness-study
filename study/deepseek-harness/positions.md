---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 十二处位置
---

# deepseek-harness 十二处位置

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc`。本文件**只给位置**：每处一行，一条链接加该行的原文，不解读、不判定、不归技术点。要知道这段代码在做什么，打开链接读上下文。

1. **edit 工具的唯一匹配判定** —— [packages/fs/fs-local/src/fsio.ts:775](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-local/src/fsio.ts#L775) —— `if (!replaceAll && replacements > 1) {`

2. **fs-observation-policy 先读后写的拦截点** —— [packages/fs/fs-observation-policy/src/index.ts:82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/fs-observation-policy/src/index.ts#L82) —— `` throw new FsError(`edit requires reading "${target.displayPath}" first`, 'FS_NOT_OBSERVED') ``

3. **str_replace_editor 的替换实现** —— [packages/fs/tool-str-replace-editor/src/index.ts:315](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/fs/tool-str-replace-editor/src/index.ts#L315) —— `before.slice(0, offset) + newValue + before.slice(offset + oldValue.length),`

4. **default 组合里 compaction-basic 的触发条件** —— [packages/compaction/compaction-basic/src/index.ts:153](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-basic/src/index.ts#L153) —— `const result = await this.compactIfNeeded(agent, 'pressure', signal)`

5. **tool-result-pruner 的触发条件** —— [packages/compaction/compaction-tool-result-pruner/src/index.ts:85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/compaction/compaction-tool-result-pruner/src/index.ts#L85) —— `if (totalChars <= this.config.thresholdChars) return null`

6. **agent-loop 里一步内多工具调用的分组调度入口** —— [packages/core/agent-loop/src/tool-calls.ts:88](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/tool-calls.ts#L88) —— `const mode = ctx.tools.executionMode(first.exec).kind`

7. **turn/end 的 reason 由谁决定** —— [packages/core/agent-loop/src/agent.ts:326](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L326) —— `this.session.append('turn/end', { turn, reason: turnEnds! })`

8. **request/header 事件的写入点** —— [packages/core/agent-loop/src/agent.ts:506](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/agent.ts#L506) —— `this.session.append('request/header', { header, reason: baseline === undefined ? 'initial' : 'resume' })`

9. **surfaceOp 为 replace 时的应用点** —— [packages/core/session/src/surface.ts:369](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/session/src/surface.ts#L369) —— `state.nodes.splice(plan.startIdx, plan.endIdx - plan.startIdx + 1, plan.seq)`

10. **审批策略 never 的判定点** —— [packages/interaction/user-approval/src/index.ts:277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/interaction/user-approval/src/index.ts#L277) —— `if (this.effectivePolicy(session) === 'never') return 'rejected'`

11. **沙箱三档的判定点** —— [packages/sandbox/sandbox-policy/src/index.ts:138](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/sandbox/sandbox-policy/src/index.ts#L138) —— `mode: request.mode ?? (session === undefined ? undefined : this.overrideOf(session)) ?? this.defaultMode,`

12. **headless 组合里没有步数、花费、时间上限的证明位置** —— [packages/core/agent-loop/src/index.ts:254-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/core/agent-loop/src/index.ts#L254-L272) —— `maxParallelToolCalls?: number`
