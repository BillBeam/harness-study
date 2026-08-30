---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查索引
---

# deepseek-harness 普查索引

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上的逐文件机制普查。范围由 [`scripts/census_coverage.py`](../../scripts/census_coverage.py) 的 `REPO_SCOPE` 声明并逐次校验（`make coverage`）：源码、组合配置、提示词文本、snapshot、随包文档与各包 README，排除依赖树与构建产物、测试文件、锁文件、二进制，以及本仓库另外声明的译文、译文一致性记录与第三方补丁。

**机制判据。** 一段代码若改变了下列五者之一，即为一个机制——模型看见什么；模型的输出造成什么；什么活过上下文窗口；循环是否、何时、从哪里再转；外部能观察到什么。

**读法。** 各文件只列机制、不做解读：陈述代码做了什么，不评价、不比较、不推测意图，也不按任何预设类别分组，按代码在文件里出现的先后顺序列。一个文件确实没有运行期机制时明确写「无运行期机制」。每条机制带一个可点击链接，`make check` 会逐条校验：文件必须存在、行号必须在范围内、提交必须等于 pin。**链接证明位置，从不证明论断。**

**证据行数**的口径是该文件中以 `- ` 开头的行数（含写「无运行期机制」的那一行）。

共 268 个普查文件、3812 个文件、**28241 条证据行**。

## 一、工作区包

`pnpm-workspace.yaml` 声明的工作区包，一个包一个文件。

| 包 | 目录 | 文件数 | 证据行数 | 普查 |
| --- | --- | ---: | ---: | --- |
| acp-acp | `packages/acp/acp` | 11 | 175 | [`census/acp-acp.md`](acp-acp.md) |
| api-gateway | `packages/api/gateway` | 15 | 187 | [`census/api-gateway.md`](api-gateway.md) |
| api-remotes | `packages/api/remotes` | 9 | 34 | [`census/api-remotes.md`](api-remotes.md) |
| api-session-controller | `packages/api/session-controller` | 36 | 409 | [`census/api-session-controller.md`](api-session-controller.md) |
| api-settings-controller | `packages/api/settings-controller` | 7 | 52 | [`census/api-settings-controller.md`](api-settings-controller.md) |
| api-workspace-controller | `packages/api/workspace-controller` | 13 | 92 | [`census/api-workspace-controller.md`](api-workspace-controller.md) |
| apps-cli | `apps/cli` | 19 | 112 | [`census/apps-cli.md`](apps-cli.md) |
| apps-web | `apps/web` | 8 | 52 | [`census/apps-web.md`](apps-web.md) |
| attachment-attachment | `packages/attachment/attachment` | 10 | 28 | [`census/attachment-attachment.md`](attachment-attachment.md) |
| attachment-attachment-local | `packages/attachment/attachment-local` | 11 | 93 | [`census/attachment-attachment-local.md`](attachment-attachment-local.md) |
| boot-app-boot | `packages/boot/app-boot` | 7 | 100 | [`census/boot-app-boot.md`](boot-app-boot.md) |
| boot-cmdline | `packages/boot/cmdline` | 5 | 22 | [`census/boot-cmdline.md`](boot-cmdline.md) |
| bundle-acp-app | `packages/bundle/acp-app` | 6 | 19 | [`census/bundle-acp-app.md`](bundle-acp-app.md) |
| bundle-base | `packages/bundle/base` | 6 | 101 | [`census/bundle-base.md`](bundle-base.md) |
| bundle-headless | `packages/bundle/headless` | 7 | 42 | [`census/bundle-headless.md`](bundle-headless.md) |
| bundle-sdk-app | `packages/bundle/sdk-app` | 6 | 21 | [`census/bundle-sdk-app.md`](bundle-sdk-app.md) |
| bundle-sdk-minimal | `packages/bundle/sdk-minimal` | 6 | 34 | [`census/bundle-sdk-minimal.md`](bundle-sdk-minimal.md) |
| bundle-web-app | `packages/bundle/web-app` | 7 | 90 | [`census/bundle-web-app.md`](bundle-web-app.md) |
| client-connection | `packages/client/connection` | 20 | 283 | [`census/client-connection.md`](client-connection.md) |
| client-hmr | `packages/client/hmr` | 8 | 42 | [`census/client-hmr.md`](client-hmr.md) |
| client-locale | `packages/client/locale` | 16 | 65 | [`census/client-locale.md`](client-locale.md) |
| client-modules | `packages/client/modules` | 9 | 92 | [`census/client-modules.md`](client-modules.md) |
| client-store | `packages/client/store` | 7 | 24 | [`census/client-store.md`](client-store.md) |
| client-ui-agent-preset | `packages/client/ui-agent-preset` | 21 | 142 | [`census/client-ui-agent-preset.md`](client-ui-agent-preset.md) |
| client-ui-approval | `packages/client/ui-approval` | 12 | 37 | [`census/client-ui-approval.md`](client-ui-approval.md) |
| client-ui-attachment | `packages/client/ui-attachment` | 20 | 95 | [`census/client-ui-attachment.md`](client-ui-attachment.md) |
| client-ui-brand-official | `packages/client/ui-brand-official` | 8 | 15 | [`census/client-ui-brand-official.md`](client-ui-brand-official.md) |
| client-ui-chat | `packages/client/ui-chat` | 89 | 520 | [`census/client-ui-chat.md`](client-ui-chat.md) |
| client-ui-commands | `packages/client/ui-commands` | 15 | 92 | [`census/client-ui-commands.md`](client-ui-commands.md) |
| client-ui-conversation | `packages/client/ui-conversation` | 69 | 573 | [`census/client-ui-conversation.md`](client-ui-conversation.md) |
| client-ui-deliverables | `packages/client/ui-deliverables` | 12 | 66 | [`census/client-ui-deliverables.md`](client-ui-deliverables.md) |
| client-ui-directory-picker-browse | `packages/client/ui-directory-picker-browse` | 11 | 98 | [`census/client-ui-directory-picker-browse.md`](client-ui-directory-picker-browse.md) |
| client-ui-directory-picker-native | `packages/client/ui-directory-picker-native` | 8 | 21 | [`census/client-ui-directory-picker-native.md`](client-ui-directory-picker-native.md) |
| client-ui-goal | `packages/client/ui-goal` | 15 | 43 | [`census/client-ui-goal.md`](client-ui-goal.md) |
| client-ui-input-trigger | `packages/client/ui-input-trigger` | 19 | 111 | [`census/client-ui-input-trigger.md`](client-ui-input-trigger.md) |
| client-ui-jobs | `packages/client/ui-jobs` | 11 | 39 | [`census/client-ui-jobs.md`](client-ui-jobs.md) |
| client-ui-layout | `packages/client/ui-layout` | 15 | 66 | [`census/client-ui-layout.md`](client-ui-layout.md) |
| client-ui-message-feedback | `packages/client/ui-message-feedback` | 13 | 59 | [`census/client-ui-message-feedback.md`](client-ui-message-feedback.md) |
| client-ui-model-selection | `packages/client/ui-model-selection` | 15 | 78 | [`census/client-ui-model-selection.md`](client-ui-model-selection.md) |
| client-ui-permission-presets | `packages/client/ui-permission-presets` | 13 | 57 | [`census/client-ui-permission-presets.md`](client-ui-permission-presets.md) |
| client-ui-plan | `packages/client/ui-plan` | 11 | 27 | [`census/client-ui-plan.md`](client-ui-plan.md) |
| client-ui-primitives | `packages/client/ui-primitives` | 78 | 527 | [`census/client-ui-primitives.md`](client-ui-primitives.md) |
| client-ui-reference | `packages/client/ui-reference` | 8 | 42 | [`census/client-ui-reference.md`](client-ui-reference.md) |
| client-ui-renderer | `packages/client/ui-renderer` | 13 | 107 | [`census/client-ui-renderer.md`](client-ui-renderer.md) |
| client-ui-session | `packages/client/ui-session` | 8 | 38 | [`census/client-ui-session.md`](client-ui-session.md) |
| client-ui-settings | `packages/client/ui-settings` | 13 | 65 | [`census/client-ui-settings.md`](client-ui-settings.md) |
| client-ui-settings-general | `packages/client/ui-settings-general` | 19 | 75 | [`census/client-ui-settings-general.md`](client-ui-settings-general.md) |
| client-ui-settings-models | `packages/client/ui-settings-models` | 28 | 223 | [`census/client-ui-settings-models.md`](client-ui-settings-models.md) |
| client-ui-settings-plugin-inventory | `packages/client/ui-settings-plugin-inventory` | 11 | 37 | [`census/client-ui-settings-plugin-inventory.md`](client-ui-settings-plugin-inventory.md) |
| client-ui-settings-plugins | `packages/client/ui-settings-plugins` | 28 | 153 | [`census/client-ui-settings-plugins.md`](client-ui-settings-plugins.md) |
| client-ui-sidebar | `packages/client/ui-sidebar` | 12 | 49 | [`census/client-ui-sidebar.md`](client-ui-sidebar.md) |
| client-ui-skill | `packages/client/ui-skill` | 11 | 58 | [`census/client-ui-skill.md`](client-ui-skill.md) |
| client-ui-slots | `packages/client/ui-slots` | 8 | 48 | [`census/client-ui-slots.md`](client-ui-slots.md) |
| client-ui-subagent | `packages/client/ui-subagent` | 14 | 76 | [`census/client-ui-subagent.md`](client-ui-subagent.md) |
| client-ui-theme | `packages/client/ui-theme` | 22 | 101 | [`census/client-ui-theme.md`](client-ui-theme.md) |
| client-ui-tool | `packages/client/ui-tool` | 38 | 152 | [`census/client-ui-tool.md`](client-ui-tool.md) |
| client-ui-trajectory | `packages/client/ui-trajectory` | 42 | 440 | [`census/client-ui-trajectory.md`](client-ui-trajectory.md) |
| client-ui-user-questions | `packages/client/ui-user-questions` | 15 | 70 | [`census/client-ui-user-questions.md`](client-ui-user-questions.md) |
| client-ui-workflow-run | `packages/client/ui-workflow-run` | 12 | 74 | [`census/client-ui-workflow-run.md`](client-ui-workflow-run.md) |
| client-ui-workspace | `packages/client/ui-workspace` | 20 | 182 | [`census/client-ui-workspace.md`](client-ui-workspace.md) |
| client-web | `packages/client/web` | 14 | 43 | [`census/client-web.md`](client-web.md) |
| code-runtime-code-runtime | `packages/code-runtime/code-runtime` | 6 | 17 | [`census/code-runtime-code-runtime.md`](code-runtime-code-runtime.md) |
| code-runtime-code-runtime-python | `packages/code-runtime/code-runtime-python` | 8 | 41 | [`census/code-runtime-code-runtime-python.md`](code-runtime-code-runtime-python.md) |
| code-runtime-code-runtime-worker-thread | `packages/code-runtime/code-runtime-worker-thread` | 11 | 103 | [`census/code-runtime-code-runtime-worker-thread.md`](code-runtime-code-runtime-worker-thread.md) |
| compaction-command-compact | `packages/compaction/command-compact` | 5 | 18 | [`census/compaction-command-compact.md`](compaction-command-compact.md) |
| compaction-compaction | `packages/compaction/compaction` | 10 | 39 | [`census/compaction-compaction.md`](compaction-compaction.md) |
| compaction-compaction-basic | `packages/compaction/compaction-basic` | 9 | 114 | [`census/compaction-compaction-basic.md`](compaction-compaction-basic.md) |
| compaction-compaction-tool-result-pruner | `packages/compaction/compaction-tool-result-pruner` | 7 | 33 | [`census/compaction-compaction-tool-result-pruner.md`](compaction-compaction-tool-result-pruner.md) |
| context-agent-instructions | `packages/context/agent-instructions` | 10 | 110 | [`census/context-agent-instructions.md`](context-agent-instructions.md) |
| context-file-reference | `packages/context/file-reference` | 7 | 12 | [`census/context-file-reference.md`](context-file-reference.md) |
| context-file-reference-local | `packages/context/file-reference-local` | 6 | 37 | [`census/context-file-reference-local.md`](context-file-reference-local.md) |
| context-session-reference | `packages/context/session-reference` | 10 | 81 | [`census/context-session-reference.md`](context-session-reference.md) |
| context-time-context | `packages/context/time-context` | 8 | 51 | [`census/context-time-context.md`](context-time-context.md) |
| context-tmux-context | `packages/context/tmux-context` | 5 | 30 | [`census/context-tmux-context.md`](context-tmux-context.md) |
| core-agent | `packages/core/agent` | 12 | 101 | [`census/core-agent.md`](core-agent.md) |
| core-agent-default-model | `packages/core/agent-default-model` | 6 | 23 | [`census/core-agent-default-model.md`](core-agent-default-model.md) |
| core-agent-loop | `packages/core/agent-loop` | 10 | 127 | [`census/core-agent-loop.md`](core-agent-loop.md) |
| core-agent-tool-presentation | `packages/core/agent-tool-presentation` | 5 | 10 | [`census/core-agent-tool-presentation.md`](core-agent-tool-presentation.md) |
| core-scope | `packages/core/scope` | 8 | 41 | [`census/core-scope.md`](core-scope.md) |
| core-session | `packages/core/session` | 15 | 138 | [`census/core-session.md`](core-session.md) |
| core-system-prompt | `packages/core/system-prompt` | 5 | 60 | [`census/core-system-prompt.md`](core-system-prompt.md) |
| core-tools | `packages/core/tools` | 13 | 250 | [`census/core-tools.md`](core-tools.md) |
| credentials-authorization | `packages/credentials/authorization` | 6 | 40 | [`census/credentials-authorization.md`](credentials-authorization.md) |
| credentials-credentials | `packages/credentials/credentials` | 6 | 24 | [`census/credentials-credentials.md`](credentials-credentials.md) |
| credentials-credentials-local | `packages/credentials/credentials-local` | 5 | 82 | [`census/credentials-credentials-local.md`](credentials-credentials-local.md) |
| e2b-e2b | `packages/e2b/e2b` | 5 | 27 | [`census/e2b-e2b.md`](e2b-e2b.md) |
| e2b-fs-e2b | `packages/e2b/fs-e2b` | 5 | 63 | [`census/e2b-fs-e2b.md`](e2b-fs-e2b.md) |
| e2b-subprocess-e2b | `packages/e2b/subprocess-e2b` | 10 | 153 | [`census/e2b-subprocess-e2b.md`](e2b-subprocess-e2b.md) |
| examples-agent-spine-demo | `packages/examples/agent-spine-demo` | 5 | 30 | [`census/examples-agent-spine-demo.md`](examples-agent-spine-demo.md) |
| experimental-agent-team | `packages/experimental/agent-team` | 19 | 166 | [`census/experimental-agent-team.md`](experimental-agent-team.md) |
| experimental-agent-team-profile | `packages/experimental/agent-team-profile` | 6 | 16 | [`census/experimental-agent-team-profile.md`](experimental-agent-team-profile.md) |
| experimental-agent-team-web-profile | `packages/experimental/agent-team-web-profile` | 6 | 12 | [`census/experimental-agent-team-web-profile.md`](experimental-agent-team-web-profile.md) |
| experimental-client-ui-agent-team | `packages/experimental/client-ui-agent-team` | 12 | 76 | [`census/experimental-client-ui-agent-team.md`](experimental-client-ui-agent-team.md) |
| experimental-inspector | `packages/experimental/inspector` | 155 | 1069 | [`census/experimental-inspector.md`](experimental-inspector.md) |
| experimental-tool-agent-team | `packages/experimental/tool-agent-team` | 5 | 45 | [`census/experimental-tool-agent-team.md`](experimental-tool-agent-team.md) |
| experimental-webworker-packer | `packages/experimental/webworker-packer` | 12 | 81 | [`census/experimental-webworker-packer.md`](experimental-webworker-packer.md) |
| experimental-webworker-runtime | `packages/experimental/webworker-runtime` | 83 | 774 | [`census/experimental-webworker-runtime.md`](experimental-webworker-runtime.md) |
| extensions-cordis-client-runner | `packages/extensions/cordis-client-runner` | 16 | 194 | [`census/extensions-cordis-client-runner.md`](extensions-cordis-client-runner.md) |
| extensions-cordis-host-runner | `packages/extensions/cordis-host-runner` | 11 | 191 | [`census/extensions-cordis-host-runner.md`](extensions-cordis-host-runner.md) |
| extensions-tool-cordis | `packages/extensions/tool-cordis` | 11 | 137 | [`census/extensions-tool-cordis.md`](extensions-tool-cordis.md) |
| extensions-ui-cordis | `packages/extensions/ui-cordis` | 23 | 128 | [`census/extensions-ui-cordis.md`](extensions-ui-cordis.md) |
| feedback-command-feedback | `packages/feedback/command-feedback` | 5 | 18 | [`census/feedback-command-feedback.md`](feedback-command-feedback.md) |
| feedback-message-feedback | `packages/feedback/message-feedback` | 7 | 43 | [`census/feedback-message-feedback.md`](feedback-message-feedback.md) |
| fs-fs | `packages/fs/fs` | 6 | 18 | [`census/fs-fs.md`](fs-fs.md) |
| fs-fs-local | `packages/fs/fs-local` | 7 | 80 | [`census/fs-fs-local.md`](fs-fs-local.md) |
| fs-fs-observation-policy | `packages/fs/fs-observation-policy` | 6 | 22 | [`census/fs-fs-observation-policy.md`](fs-fs-observation-policy.md) |
| fs-fs-sandbox | `packages/fs/fs-sandbox` | 6 | 28 | [`census/fs-fs-sandbox.md`](fs-fs-sandbox.md) |
| fs-tool-fs | `packages/fs/tool-fs` | 15 | 125 | [`census/fs-tool-fs.md`](fs-tool-fs.md) |
| fs-tool-fs-search | `packages/fs/tool-fs-search` | 11 | 99 | [`census/fs-tool-fs-search.md`](fs-tool-fs-search.md) |
| fs-tool-str-replace-editor | `packages/fs/tool-str-replace-editor` | 5 | 50 | [`census/fs-tool-str-replace-editor.md`](fs-tool-str-replace-editor.md) |
| goal-command-goal | `packages/goal/command-goal` | 5 | 27 | [`census/goal-command-goal.md`](goal-command-goal.md) |
| goal-goal | `packages/goal/goal` | 11 | 69 | [`census/goal-goal.md`](goal-goal.md) |
| goal-goal-round-driver | `packages/goal/goal-round-driver` | 7 | 49 | [`census/goal-goal-round-driver.md`](goal-goal-round-driver.md) |
| goal-tool-goal | `packages/goal/tool-goal` | 7 | 41 | [`census/goal-tool-goal.md`](goal-tool-goal.md) |
| guard-repeat-tool-reminder | `packages/guard/repeat-tool-reminder` | 5 | 26 | [`census/guard-repeat-tool-reminder.md`](guard-repeat-tool-reminder.md) |
| guard-timeout-policy | `packages/guard/timeout-policy` | 5 | 18 | [`census/guard-timeout-policy.md`](guard-timeout-policy.md) |
| hooks-hook-protocol | `packages/hooks/hook-protocol` | 12 | 62 | [`census/hooks-hook-protocol.md`](hooks-hook-protocol.md) |
| hooks-hooks-claude-code | `packages/hooks/hooks-claude-code` | 6 | 57 | [`census/hooks-hooks-claude-code.md`](hooks-hooks-claude-code.md) |
| hooks-hooks-codex | `packages/hooks/hooks-codex` | 6 | 52 | [`census/hooks-hooks-codex.md`](hooks-hooks-codex.md) |
| host-directory-picker | `packages/host/directory-picker` | 6 | 12 | [`census/host-directory-picker.md`](host-directory-picker.md) |
| host-directory-picker-auto | `packages/host/directory-picker-auto` | 7 | 27 | [`census/host-directory-picker-auto.md`](host-directory-picker-auto.md) |
| host-directory-picker-browse | `packages/host/directory-picker-browse` | 6 | 40 | [`census/host-directory-picker-browse.md`](host-directory-picker-browse.md) |
| host-directory-picker-native | `packages/host/directory-picker-native` | 12 | 73 | [`census/host-directory-picker-native.md`](host-directory-picker-native.md) |
| host-frontend-static | `packages/host/frontend-static` | 5 | 26 | [`census/host-frontend-static.md`](host-frontend-static.md) |
| host-plugin-inventory | `packages/host/plugin-inventory` | 6 | 20 | [`census/host-plugin-inventory.md`](host-plugin-inventory.md) |
| host-webserver | `packages/host/webserver` | 6 | 48 | [`census/host-webserver.md`](host-webserver.md) |
| identity-anonymous-user-id | `packages/identity/anonymous-user-id` | 5 | 19 | [`census/identity-anonymous-user-id.md`](identity-anonymous-user-id.md) |
| interaction-commands | `packages/interaction/commands` | 7 | 49 | [`census/interaction-commands.md`](interaction-commands.md) |
| interaction-permission-presets | `packages/interaction/permission-presets` | 7 | 43 | [`census/interaction-permission-presets.md`](interaction-permission-presets.md) |
| interaction-tool-ask-user | `packages/interaction/tool-ask-user` | 5 | 16 | [`census/interaction-tool-ask-user.md`](interaction-tool-ask-user.md) |
| interaction-user-approval | `packages/interaction/user-approval` | 7 | 38 | [`census/interaction-user-approval.md`](interaction-user-approval.md) |
| interaction-user-questions | `packages/interaction/user-questions` | 6 | 21 | [`census/interaction-user-questions.md`](interaction-user-questions.md) |
| jobs-jobs | `packages/jobs/jobs` | 7 | 17 | [`census/jobs-jobs.md`](jobs-jobs.md) |
| jobs-jobs-local | `packages/jobs/jobs-local` | 5 | 66 | [`census/jobs-jobs-local.md`](jobs-jobs-local.md) |
| jobs-tool-jobs | `packages/jobs/tool-jobs` | 5 | 47 | [`census/jobs-tool-jobs.md`](jobs-tool-jobs.md) |
| llm-deepseek-llm-api-extensions | `packages/llm/deepseek-llm-api-extensions` | 6 | 23 | [`census/llm-deepseek-llm-api-extensions.md`](llm-deepseek-llm-api-extensions.md) |
| llm-llm | `packages/llm/llm` | 17 | 139 | [`census/llm-llm.md`](llm-llm.md) |
| llm-llm-deepseek | `packages/llm/llm-deepseek` | 16 | 142 | [`census/llm-llm-deepseek.md`](llm-llm-deepseek.md) |
| llm-llm-pi-ai | `packages/llm/llm-pi-ai` | 15 | 208 | [`census/llm-llm-pi-ai.md`](llm-llm-pi-ai.md) |
| llm-llm-retry | `packages/llm/llm-retry` | 9 | 52 | [`census/llm-llm-retry.md`](llm-llm-retry.md) |
| llm-plugin-package-inventory-deepseek | `packages/llm/plugin-package-inventory-deepseek` | 6 | 28 | [`census/llm-plugin-package-inventory-deepseek.md`](llm-plugin-package-inventory-deepseek.md) |
| llm-token-meter | `packages/llm/token-meter` | 15 | 104 | [`census/llm-token-meter.md`](llm-token-meter.md) |
| lsp-lsp | `packages/lsp/lsp` | 7 | 25 | [`census/lsp-lsp.md`](lsp-lsp.md) |
| lsp-lsp-stdio | `packages/lsp/lsp-stdio` | 12 | 119 | [`census/lsp-lsp-stdio.md`](lsp-lsp-stdio.md) |
| lsp-tool-lsp | `packages/lsp/tool-lsp` | 7 | 44 | [`census/lsp-tool-lsp.md`](lsp-tool-lsp.md) |
| mcp-mcp-client | `packages/mcp/mcp-client` | 8 | 75 | [`census/mcp-mcp-client.md`](mcp-mcp-client.md) |
| native-landlock-run | `native/landlock-run` | 16 | 80 | [`census/native-landlock-run.md`](native-landlock-run.md) |
| native-landlock-run-entry | `native/landlock-run/packages/entry` | 5 | 38 | [`census/native-landlock-run-entry.md`](native-landlock-run-entry.md) |
| native-landlock-run-linux-arm64 | `native/landlock-run/packages/linux-arm64` | 2 | 5 | [`census/native-landlock-run-linux-arm64.md`](native-landlock-run-linux-arm64.md) |
| native-landlock-run-linux-x64 | `native/landlock-run/packages/linux-x64` | 2 | 5 | [`census/native-landlock-run-linux-x64.md`](native-landlock-run-linux-x64.md) |
| plan-plan-mode | `packages/plan/plan-mode` | 7 | 72 | [`census/plan-plan-mode.md`](plan-plan-mode.md) |
| preset-agent-presets | `packages/preset/agent-presets` | 23 | 222 | [`census/preset-agent-presets.md`](preset-agent-presets.md) |
| preset-persona | `packages/preset/persona` | 5 | 14 | [`census/preset-persona.md`](preset-persona.md) |
| python-sdk-runtime | `python/sdk-runtime` | 5 | 30 | [`census/python-sdk-runtime.md`](python-sdk-runtime.md) |
| runtime-diagnostics-invariants | `packages/runtime-diagnostics/invariants` | 5 | 25 | [`census/runtime-diagnostics-invariants.md`](runtime-diagnostics-invariants.md) |
| sandbox-sandbox | `packages/sandbox/sandbox` | 7 | 26 | [`census/sandbox-sandbox.md`](sandbox-sandbox.md) |
| sandbox-sandbox-local | `packages/sandbox/sandbox-local` | 6 | 45 | [`census/sandbox-sandbox-local.md`](sandbox-sandbox-local.md) |
| sandbox-sandbox-policy | `packages/sandbox/sandbox-policy` | 7 | 30 | [`census/sandbox-sandbox-policy.md`](sandbox-sandbox-policy.md) |
| sandbox-sandbox-windows-acl | `packages/sandbox/sandbox-windows-acl` | 16 | 101 | [`census/sandbox-sandbox-windows-acl.md`](sandbox-sandbox-windows-acl.md) |
| schedule-schedule | `packages/schedule/schedule` | 12 | 103 | [`census/schedule-schedule.md`](schedule-schedule.md) |
| sdk-client | `packages/sdk/client` | 10 | 78 | [`census/sdk-client.md`](sdk-client.md) |
| sdk-protocol | `packages/sdk/protocol` | 7 | 33 | [`census/sdk-protocol.md`](sdk-protocol.md) |
| sdk-server | `packages/sdk/server` | 6 | 47 | [`census/sdk-server.md`](sdk-server.md) |
| session-query-session-log-export | `packages/session-query/session-log-export` | 14 | 74 | [`census/session-query-session-log-export.md`](session-query-session-log-export.md) |
| session-query-session-query | `packages/session-query/session-query` | 15 | 111 | [`census/session-query-session-query.md`](session-query-session-query.md) |
| session-query-session-query-sqlite | `packages/session-query/session-query-sqlite` | 7 | 101 | [`census/session-query-session-query-sqlite.md`](session-query-session-query-sqlite.md) |
| session-query-tool-session-query | `packages/session-query/tool-session-query` | 10 | 85 | [`census/session-query-tool-session-query.md`](session-query-tool-session-query.md) |
| session-session-checkpoint-policy | `packages/session/session-checkpoint-policy` | 5 | 18 | [`census/session-session-checkpoint-policy.md`](session-session-checkpoint-policy.md) |
| session-session-log-deepseek | `packages/session/session-log-deepseek` | 6 | 32 | [`census/session-session-log-deepseek.md`](session-session-log-deepseek.md) |
| session-session-persistence | `packages/session/session-persistence` | 10 | 136 | [`census/session-session-persistence.md`](session-session-persistence.md) |
| session-session-persistence-jsonl | `packages/session/session-persistence-jsonl` | 10 | 140 | [`census/session-session-persistence-jsonl.md`](session-session-persistence-jsonl.md) |
| session-session-persistence-sqlite | `packages/session/session-persistence-sqlite` | 46 | 146 | [`census/session-session-persistence-sqlite.md`](session-session-persistence-sqlite.md) |
| session-session-projection | `packages/session/session-projection` | 6 | 34 | [`census/session-session-projection.md`](session-session-projection.md) |
| session-session-projection-cache | `packages/session/session-projection-cache` | 6 | 34 | [`census/session-session-projection-cache.md`](session-session-projection-cache.md) |
| session-session-stats | `packages/session/session-stats` | 8 | 26 | [`census/session-session-stats.md`](session-session-stats.md) |
| session-session-telemetry | `packages/session/session-telemetry` | 6 | 33 | [`census/session-session-telemetry.md`](session-session-telemetry.md) |
| session-session-telemetry-otel | `packages/session/session-telemetry-otel` | 5 | 30 | [`census/session-session-telemetry-otel.md`](session-session-telemetry-otel.md) |
| session-session-title | `packages/session/session-title` | 8 | 61 | [`census/session-session-title.md`](session-session-title.md) |
| session-session-title-all-prompts-llm | `packages/session/session-title-all-prompts-llm` | 5 | 10 | [`census/session-session-title-all-prompts-llm.md`](session-session-title-all-prompts-llm.md) |
| session-session-title-first-prompt-llm | `packages/session/session-title-first-prompt-llm` | 5 | 12 | [`census/session-session-title-first-prompt-llm.md`](session-session-title-first-prompt-llm.md) |
| session-session-title-llm | `packages/session/session-title-llm` | 5 | 29 | [`census/session-session-title-llm.md`](session-session-title-llm.md) |
| settings-settings | `packages/settings/settings` | 8 | 60 | [`census/settings-settings.md`](settings-settings.md) |
| settings-settings-file | `packages/settings/settings-file` | 5 | 35 | [`census/settings-settings-file.md`](settings-settings-file.md) |
| shell-bash-local | `packages/shell/bash-local` | 5 | 37 | [`census/shell-bash-local.md`](shell-bash-local.md) |
| shell-bash-sandbox | `packages/shell/bash-sandbox` | 6 | 32 | [`census/shell-bash-sandbox.md`](shell-bash-sandbox.md) |
| shell-pwsh-local | `packages/shell/pwsh-local` | 6 | 43 | [`census/shell-pwsh-local.md`](shell-pwsh-local.md) |
| shell-pwsh-sandbox | `packages/shell/pwsh-sandbox` | 6 | 32 | [`census/shell-pwsh-sandbox.md`](shell-pwsh-sandbox.md) |
| shell-shell | `packages/shell/shell` | 7 | 14 | [`census/shell-shell.md`](shell-shell.md) |
| shell-shell-env | `packages/shell/shell-env` | 5 | 22 | [`census/shell-shell-env.md`](shell-shell-env.md) |
| shell-tool-bash | `packages/shell/tool-bash` | 7 | 45 | [`census/shell-tool-bash.md`](shell-tool-bash.md) |
| shell-tool-bash-persistent | `packages/shell/tool-bash-persistent` | 5 | 45 | [`census/shell-tool-bash-persistent.md`](shell-tool-bash-persistent.md) |
| shell-tool-pwsh | `packages/shell/tool-pwsh` | 7 | 44 | [`census/shell-tool-pwsh.md`](shell-tool-pwsh.md) |
| shell-tool-pwsh-persistent | `packages/shell/tool-pwsh-persistent` | 5 | 49 | [`census/shell-tool-pwsh-persistent.md`](shell-tool-pwsh-persistent.md) |
| skill-skill | `packages/skill/skill` | 5 | 51 | [`census/skill-skill.md`](skill-skill.md) |
| skill-skill-badge | `packages/skill/skill-badge` | 6 | 17 | [`census/skill-skill-badge.md`](skill-skill-badge.md) |
| skill-skill-filesystem | `packages/skill/skill-filesystem` | 5 | 65 | [`census/skill-skill-filesystem.md`](skill-skill-filesystem.md) |
| skill-tool-skill | `packages/skill/tool-skill` | 5 | 43 | [`census/skill-tool-skill.md`](skill-tool-skill.md) |
| spill-spill | `packages/spill/spill` | 6 | 12 | [`census/spill-spill.md`](spill-spill.md) |
| spill-spill-local | `packages/spill/spill-local` | 7 | 54 | [`census/spill-spill-local.md`](spill-spill-local.md) |
| spill-spill-policy | `packages/spill/spill-policy` | 6 | 32 | [`census/spill-spill-policy.md`](spill-spill-policy.md) |
| storage-storage | `packages/storage/storage` | 8 | 22 | [`census/storage-storage.md`](storage-storage.md) |
| storage-storage-domain | `packages/storage/storage-domain` | 9 | 58 | [`census/storage-storage-domain.md`](storage-storage-domain.md) |
| storage-storage-json | `packages/storage/storage-json` | 9 | 70 | [`census/storage-storage-json.md`](storage-storage-json.md) |
| storage-storage-sqlite | `packages/storage/storage-sqlite` | 7 | 48 | [`census/storage-storage-sqlite.md`](storage-storage-sqlite.md) |
| subagent-subagent | `packages/subagent/subagent` | 23 | 221 | [`census/subagent-subagent.md`](subagent-subagent.md) |
| subagent-subagent-acp | `packages/subagent/subagent-acp` | 6 | 59 | [`census/subagent-subagent-acp.md`](subagent-subagent-acp.md) |
| subagent-subagent-claude-code | `packages/subagent/subagent-claude-code` | 8 | 62 | [`census/subagent-subagent-claude-code.md`](subagent-subagent-claude-code.md) |
| subagent-subagent-codex | `packages/subagent/subagent-codex` | 8 | 79 | [`census/subagent-subagent-codex.md`](subagent-subagent-codex.md) |
| subagent-subagent-dsh-sdk | `packages/subagent/subagent-dsh-sdk` | 6 | 40 | [`census/subagent-subagent-dsh-sdk.md`](subagent-subagent-dsh-sdk.md) |
| subagent-subagent-fork-in-process | `packages/subagent/subagent-fork-in-process` | 5 | 14 | [`census/subagent-subagent-fork-in-process.md`](subagent-subagent-fork-in-process.md) |
| subagent-subagent-in-process-driver | `packages/subagent/subagent-in-process-driver` | 6 | 32 | [`census/subagent-subagent-in-process-driver.md`](subagent-subagent-in-process-driver.md) |
| subagent-subagent-spawn-in-process | `packages/subagent/subagent-spawn-in-process` | 5 | 13 | [`census/subagent-subagent-spawn-in-process.md`](subagent-subagent-spawn-in-process.md) |
| subagent-tool-subagent | `packages/subagent/tool-subagent` | 10 | 82 | [`census/subagent-tool-subagent.md`](subagent-tool-subagent.md) |
| subagent-tool-subagent-control | `packages/subagent/tool-subagent-control` | 6 | 28 | [`census/subagent-tool-subagent-control.md`](subagent-tool-subagent-control.md) |
| subagent-tool-subagent-report | `packages/subagent/tool-subagent-report` | 5 | 17 | [`census/subagent-tool-subagent-report.md`](subagent-tool-subagent-report.md) |
| subprocess-subprocess | `packages/subprocess/subprocess` | 6 | 12 | [`census/subprocess-subprocess.md`](subprocess-subprocess.md) |
| subprocess-subprocess-local | `packages/subprocess/subprocess-local` | 10 | 142 | [`census/subprocess-subprocess-local.md`](subprocess-subprocess-local.md) |
| subprocess-win32-process | `packages/subprocess/win32-process` | 10 | 69 | [`census/subprocess-win32-process.md`](subprocess-win32-process.md) |
| terminal-terminal | `packages/terminal/terminal` | 6 | 50 | [`census/terminal-terminal.md`](terminal-terminal.md) |
| terminal-terminal-bash | `packages/terminal/terminal-bash` | 8 | 116 | [`census/terminal-terminal-bash.md`](terminal-terminal-bash.md) |
| terminal-tool-terminal | `packages/terminal/tool-terminal` | 6 | 52 | [`census/terminal-tool-terminal.md`](terminal-tool-terminal.md) |
| test-support-agent-loop-testkit | `packages/test-support/agent-loop-testkit` | 5 | 12 | [`census/test-support-agent-loop-testkit.md`](test-support-agent-loop-testkit.md) |
| test-support-client-runtime | `packages/test-support/client-runtime` | 15 | 122 | [`census/test-support-client-runtime.md`](test-support-client-runtime.md) |
| test-support-llm-mock-server | `packages/test-support/llm-mock-server` | 8 | 94 | [`census/test-support-llm-mock-server.md`](test-support-llm-mock-server.md) |
| test-support-llm-replay | `packages/test-support/llm-replay` | 5 | 63 | [`census/test-support-llm-replay.md`](test-support-llm-replay.md) |
| test-support-loader-smoke | `packages/test-support/loader-smoke` | 6 | 35 | [`census/test-support-loader-smoke.md`](test-support-loader-smoke.md) |
| test-support-session-snapshot | `packages/test-support/session-snapshot` | 12 | 243 | [`census/test-support-session-snapshot.md`](test-support-session-snapshot.md) |
| todo-tool-todo | `packages/todo/tool-todo` | 7 | 34 | [`census/todo-tool-todo.md`](todo-tool-todo.md) |
| typert-generator | `packages/typert/generator` | 12 | 268 | [`census/typert-generator.md`](typert-generator.md) |
| typert-loader | `packages/typert/loader` | 5 | 43 | [`census/typert-loader.md`](typert-loader.md) |
| typert-protocol | `packages/typert/protocol` | 6 | 26 | [`census/typert-protocol.md`](typert-protocol.md) |
| typert-registry | `packages/typert/registry` | 9 | 67 | [`census/typert-registry.md`](typert-registry.md) |
| util-atomic-write | `packages/util/atomic-write` | 5 | 20 | [`census/util-atomic-write.md`](util-atomic-write.md) |
| util-brand | `packages/util/brand` | 5 | 9 | [`census/util-brand.md`](util-brand.md) |
| util-crypto | `packages/util/crypto` | 5 | 12 | [`census/util-crypto.md`](util-crypto.md) |
| util-home-paths | `packages/util/home-paths` | 5 | 22 | [`census/util-home-paths.md`](util-home-paths.md) |
| util-launch-environment | `packages/util/launch-environment` | 5 | 15 | [`census/util-launch-environment.md`](util-launch-environment.md) |
| util-native-command | `packages/util/native-command` | 7 | 31 | [`census/util-native-command.md`](util-native-command.md) |
| util-output-retention | `packages/util/output-retention` | 5 | 29 | [`census/util-output-retention.md`](util-output-retention.md) |
| util-timeout | `packages/util/timeout` | 5 | 24 | [`census/util-timeout.md`](util-timeout.md) |
| util-workspace-path | `packages/util/workspace-path` | 5 | 17 | [`census/util-workspace-path.md`](util-workspace-path.md) |
| vendor-cordis | `vendor/cordis` | 13 | 167 | [`census/vendor-cordis.md`](vendor-cordis.md) |
| vendor-cosmokit | `vendor/cosmokit` | 9 | 52 | [`census/vendor-cosmokit.md`](vendor-cosmokit.md) |
| vendor-group | `vendor/group` | 4 | 5 | [`census/vendor-group.md`](vendor-group.md) |
| vendor-hmr | `vendor/hmr` | 5 | 58 | [`census/vendor-hmr.md`](vendor-hmr.md) |
| vendor-include | `vendor/include` | 4 | 43 | [`census/vendor-include.md`](vendor-include.md) |
| vendor-loader | `vendor/loader` | 11 | 88 | [`census/vendor-loader.md`](vendor-loader.md) |
| vendor-logger-console | `vendor/logger-console` | 7 | 17 | [`census/vendor-logger-console.md`](vendor-logger-console.md) |
| vendor-schemastery | `vendor/schemastery` | 5 | 59 | [`census/vendor-schemastery.md`](vendor-schemastery.md) |
| vendor-timer | `vendor/timer` | 4 | 17 | [`census/vendor-timer.md`](vendor-timer.md) |
| web-tool-web | `packages/web/tool-web` | 9 | 66 | [`census/web-tool-web.md`](web-tool-web.md) |
| web-web | `packages/web/web` | 6 | 22 | [`census/web-web.md`](web-web.md) |
| web-web-fetch-http | `packages/web/web-fetch-http` | 8 | 67 | [`census/web-web-fetch-http.md`](web-web-fetch-http.md) |
| web-web-search-deepseek | `packages/web/web-search-deepseek` | 7 | 47 | [`census/web-web-search-deepseek.md`](web-web-search-deepseek.md) |
| web-web-search-exa | `packages/web/web-search-exa` | 7 | 29 | [`census/web-web-search-exa.md`](web-web-search-exa.md) |
| web-web-search-perplexity | `packages/web/web-search-perplexity` | 7 | 29 | [`census/web-web-search-perplexity.md`](web-web-search-perplexity.md) |
| webhook-webhook | `packages/webhook/webhook` | 8 | 36 | [`census/webhook-webhook.md`](webhook-webhook.md) |
| webhook-webhook-github | `packages/webhook/webhook-github` | 8 | 30 | [`census/webhook-webhook-github.md`](webhook-webhook-github.md) |
| workflow-tool-ralph | `packages/workflow/tool-ralph` | 5 | 39 | [`census/workflow-tool-ralph.md`](workflow-tool-ralph.md) |
| workflow-tool-workflow | `packages/workflow/tool-workflow` | 6 | 39 | [`census/workflow-tool-workflow.md`](workflow-tool-workflow.md) |
| workflow-workflow | `packages/workflow/workflow` | 7 | 31 | [`census/workflow-workflow.md`](workflow-workflow.md) |
| workflow-workflow-worker-thread | `packages/workflow/workflow-worker-thread` | 14 | 152 | [`census/workflow-workflow-worker-thread.md`](workflow-workflow-worker-thread.md) |
| workspace-workspace | `packages/workspace/workspace` | 9 | 84 | [`census/workspace-workspace.md`](workspace-workspace.md) |

## 二、不属于任何工作区包的文件

卡面点名了 `_root.md` 与 `_website.md`；`docs/`、`scripts/`、`snapshots/` 三棵树同样不在任何工作区包里，按同一个下划线前缀的命名各自成篮，否则只能全部塞进 `_root.md`。

| 篮 | 范围 | 文件数 | 证据行数 | 普查 |
| --- | --- | ---: | ---: | --- |
| _docs | docs/（随包文档） | 121 | 1935 | [`census/_docs.md`](_docs.md) |
| _root | 仓库根目录与未归入工作区包的文件 | 88 | 325 | [`census/_root.md`](_root.md) |
| _scripts | scripts/（仓库脚本） | 117 | 1754 | [`census/_scripts.md`](_scripts.md) |
| _snapshots | snapshots/（快照夹具） | 615 | 3705 | [`census/_snapshots.md`](_snapshots.md) |
| _website | website（文档站） | 5 | 58 | [`census/_website.md`](_website.md) |

两节合计 **3812** 个文件、**28241** 条证据行。

