---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: deepseek-harness 普查 · packages/bundle/base
---

# packages/bundle/base

钉住提交 `cd5ef8148158c3a752a658978873241fdf8e2bbc` 上这一组的逐文件机制普查，共 6 个文件、101 条证据行。判据、读法与全仓库口径见 [`../census-index.md`](../census-index.md)。

### packages/bundle/base/README.md

该 bundle 的英文说明文档，介绍共享核心提供什么、如何在自定义 profile 里首位引用它，以及按平台切换 shell 栈的注意事项。

- 无运行期机制

### packages/bundle/base/cordis.patch.yml

该 bundle 的补丁文档，是这个包的全部实质：以一个 `insert` 列表把共享核心的全部插件行铺在空 profile 根上，后续 bundle 与用户 profile 按 id 覆盖其中的行。

- 整份文档是单个 `insert` 列表，套在空 profile 根之上（[packages/bundle/base/cordis.patch.yml:15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L15)）
- 挂载 `timer` 行（[packages/bundle/base/cordis.patch.yml:16-17](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L16-L17)）
- `hmr` 行以 `disabled: true` 落位、`root: ['.']`，模块热重载默认不生效（[packages/bundle/base/cordis.patch.yml:21-25](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L21-L25)）
- 挂载 `llm` 服务定义行（[packages/bundle/base/cordis.patch.yml:27-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L27-L28)）
- 挂载 `deepseek-llm-api-extensions` 行（[packages/bundle/base/cordis.patch.yml:30-31](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L30-L31)）
- 挂载 `session` 行（[packages/bundle/base/cordis.patch.yml:33-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L33-L34)）
- 挂载 `session-log-deepseek` 行（[packages/bundle/base/cordis.patch.yml:36-37](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L36-L37)）
- 挂载 `typert` 类型图注册表行（[packages/bundle/base/cordis.patch.yml:39-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L39-L40)）
- 挂载 `typert-loader` 行（[packages/bundle/base/cordis.patch.yml:42-43](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L42-L43)）
- 挂载 `typert-gateway` RPC 网关行（[packages/bundle/base/cordis.patch.yml:45-46](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L45-L46)）
- `session-title` 行配 `fallbackMaxWords: 5`、`fallbackMaxBytes: 40`、`maxTitleBytes: 80`（[packages/bundle/base/cordis.patch.yml:48-53](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L48-L53)）
- `session-title-llm` 行配 `targetWords: 5`、`targetCjkCharacters: 10`、`maxInputBytes: 4096`、`maxOutputTokens: 64`、`timeoutMs: 60000`（[packages/bundle/base/cordis.patch.yml:55-62](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L55-L62)）
- 挂载 `user-questions` 行（[packages/bundle/base/cordis.patch.yml:64-65](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L64-L65)）
- 挂载 `agent` 行（[packages/bundle/base/cordis.patch.yml:67-68](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L67-L68)）
- 挂载 `plugin-package-inventory-deepseek` 行（[packages/bundle/base/cordis.patch.yml:70-71](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L70-L71)）
- `agent-default-model` 行把入口创建 Agent 的默认路由固定为 `provider: deepseek-official` / `model: deepseek-v4-flash`（[packages/bundle/base/cordis.patch.yml:75-80](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L75-L80)）
- 挂载 `jobs` 本地作业行（[packages/bundle/base/cordis.patch.yml:81-82](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L81-L82)）
- 挂载 `llm-retry` 行（[packages/bundle/base/cordis.patch.yml:84-85](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L84-L85)）
- 挂载 `settings` 文件型用户设置行（[packages/bundle/base/cordis.patch.yml:90-91](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L90-L91)）
- 挂载 `credentials` 本地凭据行（[packages/bundle/base/cordis.patch.yml:97-98](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L97-L98)）
- 挂载 `llm-pi-ai` 多提供方适配器行，不带任何路由配置（[packages/bundle/base/cordis.patch.yml:107-108](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L107-L108)）
- `session-persistence-jsonl` 行的 `root` 由 `!!js dshHomePath('sessions')` 在加载时求值（[packages/bundle/base/cordis.patch.yml:110-113](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L110-L113)）
- 挂载 `attachment-local` 行，把图片字节存在追加式会话日志之外（[packages/bundle/base/cordis.patch.yml:118-119](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L118-L119)）
- `session-query-sqlite` 行配 `path: ':memory:'` 与 `openAt: never`，全文检索默认不开、SQLite 不打开（[packages/bundle/base/cordis.patch.yml:129-133](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L129-L133)）
- 挂载 `session-projection` 共享投影注册表行（[packages/bundle/base/cordis.patch.yml:138-139](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L138-L139)）
- 挂载 `storage` 存储枢纽行（[packages/bundle/base/cordis.patch.yml:145-146](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L145-L146)）
- `storage-json` 行的 `root` 由 `!!js dshHomePath('storages')` 求值（[packages/bundle/base/cordis.patch.yml:148-151](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L148-L151)）
- `storage-domain` 行把域存储的后端固定为 `json`（[packages/bundle/base/cordis.patch.yml:153-156](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L153-L156)）
- `session-projection-cache` 行配 `writeEveryEvents: 200`、`writeIntervalMs: 5000` 作为写回节流阈值（[packages/bundle/base/cordis.patch.yml:162-166](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L162-L166)）
- `session-telemetry-otel` 行的 `mode` 取 `process.env.DSH_TELEMETRY_MODE || 'FEEDBACK_ONLY'`（[packages/bundle/base/cordis.patch.yml:190-193](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L190-L193)）
- 遥测行的 `shutdownTimeoutMillis: 3000` 是关停排空的外层上界（[packages/bundle/base/cordis.patch.yml:194](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L194)）
- 遥测导出端点取 `process.env.DSH_TELEMETRY_OTLP_URL ?? 'https://harness-telemetry.deepseeksvc.com/v1/logs'`，压缩 gzip，`timeoutMillis: 1000`（[packages/bundle/base/cordis.patch.yml:195-198](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L195-L198)）
- 遥测处理器配 `scheduledDelayMillis: 10000`、`maxQueueSize: 2048`、`maxExportBatchSize: 2048`、`exportTimeoutMillis: 1500`（[packages/bundle/base/cordis.patch.yml:199-203](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L199-L203)）
- 挂载 `subprocess` 本地进程树行（[packages/bundle/base/cordis.patch.yml:205-206](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L205-L206)）
- 挂载 `sandbox` 本地沙箱行（[packages/bundle/base/cordis.patch.yml:211-212](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L211-L212)）
- `sandbox-policy` 行的 `mode` 取 `process.env.DSH_PERMISSION_MODE ?? 'workspace-write'`，`workspaceRoot` 取 `process.cwd()`（[packages/bundle/base/cordis.patch.yml:214-218](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L214-L218)）
- `bash-sandbox` 行以 `!!js process.platform === 'win32'` 决定是否禁用，并配 `timeoutMs: 60000`（[packages/bundle/base/cordis.patch.yml:220-224](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L220-L224)）
- `pwsh-sandbox` 行以 `!!js process.platform !== 'win32'` 反向门控，仅在 Windows 上挂载（[packages/bundle/base/cordis.patch.yml:226-228](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L226-L228)）
- `approval` 行的 `policy` 在权限模式为 `danger-full-access` 时求值为 `never`，否则为 `ask`（[packages/bundle/base/cordis.patch.yml:230-233](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L230-L233)）
- `permission` 行定义 `read-only` / `workspace-write` / `danger-full-access` 三套沙箱与审批预设组合（[packages/bundle/base/cordis.patch.yml:235-247](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L235-L247)）
- 挂载 `shell-env` 行（[packages/bundle/base/cordis.patch.yml:249-250](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L249-L250)）
- `tool-bash` 行在 win32 上禁用，决定模型是否看到 bash 工具（[packages/bundle/base/cordis.patch.yml:252-254](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L252-L254)）
- `tool-pwsh` 行在非 win32 上禁用，决定模型是否看到 PowerShell 工具（[packages/bundle/base/cordis.patch.yml:256-258](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L256-L258)）
- 挂载 `tool-jobs` 行（[packages/bundle/base/cordis.patch.yml:260-261](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L260-L261)）
- 挂载 `fs-observation-policy` 行（[packages/bundle/base/cordis.patch.yml:263-264](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L263-L264)）
- 挂载 `tool-fs` 行（[packages/bundle/base/cordis.patch.yml:266-267](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L266-L267)）
- `tool-fs-search` 行配 `sampleOverCapGlobResults: false`（[packages/bundle/base/cordis.patch.yml:269-272](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L269-L272)）
- `agent-instructions` 行把注入指令的读取上限设为 `maxBytes: 65536`（[packages/bundle/base/cordis.patch.yml:274-277](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L274-L277)）
- 挂载 `skill` 技能注册表行（[packages/bundle/base/cordis.patch.yml:279-280](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L279-L280)）
- 挂载 `skill-filesystem` 行（[packages/bundle/base/cordis.patch.yml:282-283](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L282-L283)）
- `skill-badge` 行以 `disabled: true` 落位（[packages/bundle/base/cordis.patch.yml:285-287](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L285-L287)）
- 挂载 `tool-skill` 行（[packages/bundle/base/cordis.patch.yml:289-290](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L289-L290)）
- 挂载 `commands` 斜杠命令注册表行（[packages/bundle/base/cordis.patch.yml:292-293](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L292-L293)）
- 挂载 `command-feedback` 行（[packages/bundle/base/cordis.patch.yml:295-296](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L295-L296)）
- 挂载 `goal` 域行（[packages/bundle/base/cordis.patch.yml:298-299](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L298-L299)）
- 挂载 `goal-round-driver` 行（[packages/bundle/base/cordis.patch.yml:301-302](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L301-L302)）
- 挂载 `command-goal` 行（[packages/bundle/base/cordis.patch.yml:304-305](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L304-L305)）
- `plan-mode` 行内联整段计划模式提示文本，规定停留条件、只读探查、不得用 todo_write 记录规划、以及必须以 exit_plan_mode 作为该回复的唯一且最后一次工具调用（[packages/bundle/base/cordis.patch.yml:307-321](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L307-L321)）
- 挂载 `token-meter` 行（[packages/bundle/base/cordis.patch.yml:323-324](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L323-L324)）
- 挂载 `compaction-basic` 行作为压缩提供方（[packages/bundle/base/cordis.patch.yml:326-327](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L326-L327)）
- 挂载 `command-compact` 行（[packages/bundle/base/cordis.patch.yml:331-332](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L331-L332)）
- 挂载 `subagent` 服务定义行（[packages/bundle/base/cordis.patch.yml:334-335](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L334-L335)）
- `subagent-spawn-in-process` 行以 `providerName: spawn` 注册进程内派生提供方（[packages/bundle/base/cordis.patch.yml:337-340](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L337-L340)）
- `subagent-fork-in-process` 行以 `providerName: fork` 注册进程内分叉提供方（[packages/bundle/base/cordis.patch.yml:342-345](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L342-L345)）
- 挂载 `tool-subagent-control` 行（[packages/bundle/base/cordis.patch.yml:349-350](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L349-L350)）
- 以子路径 `/list-agents` 单独挂载 `tool-subagent-list-agents` 行（[packages/bundle/base/cordis.patch.yml:352-353](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L352-L353)）
- `tool-subagent` 行以 `provider: spawn`、`toolName: subagent`、`backgroundMode: continuable` 注册可续接的委派工具（[packages/bundle/base/cordis.patch.yml:355-360](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L355-L360)）
- `tool-subagent-fork` 行以同一插件的第二份配置注册 `subagent_fork` 工具，`provider: fork`、`backgroundMode: one-shot`（[packages/bundle/base/cordis.patch.yml:368-373](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L368-L373)）
- 挂载 `tool-subagent-report` 回报通道行（[packages/bundle/base/cordis.patch.yml:376-377](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L376-L377)）
- `workflow-worker-thread` 行以 `provider: spawn` 注册工作线程工作流提供方（[packages/bundle/base/cordis.patch.yml:379-382](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L379-L382)）
- 挂载 `tool-workflow` 行（[packages/bundle/base/cordis.patch.yml:384-385](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L384-L385)）
- 挂载 `timeout-policy` 工具调用超时策略行（[packages/bundle/base/cordis.patch.yml:387-388](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L387-L388)）
- 挂载 `spill-local` 溢出存储行（[packages/bundle/base/cordis.patch.yml:390-391](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L390-L391)）
- `spill-policy` 行把内联上限设为 `maxInlineBytes: 50000`，超出者转溢出（[packages/bundle/base/cordis.patch.yml:393-396](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L393-L396)）
- 挂载 `session-checkpoint-policy` 行，在每次模型请求与顶层派发前落持久化检查点（[packages/bundle/base/cordis.patch.yml:399-400](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L399-L400)）
- `tool-result-pruner` 行配 `thresholdChars: 8192`、`headChars: 4096`、`tailChars: 1024`，在整体压缩前先裁超长工具结果（[packages/bundle/base/cordis.patch.yml:404-409](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L404-L409)）
- `tool-todo` 行配 `allowParallelInProgress: true`（[packages/bundle/base/cordis.patch.yml:411-414](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L411-L414)）
- 挂载 `tool-goal` 行，把持久目标送进模型与斜杠菜单（[packages/bundle/base/cordis.patch.yml:418-419](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L418-L419)）
- `tool-ralph` 行配 `subagentProvider: spawn` 与 `maxRounds: 64`，给迭代循环设上界（[packages/bundle/base/cordis.patch.yml:422-426](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L422-L426)）
- `tool-str-replace-editor` 行配 `maxOutputChars: 16000`（[packages/bundle/base/cordis.patch.yml:428-431](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L428-L431)）
- `repeat-tool-reminder` 行配 `thresholds: [3, 5, 8]` 与 `argumentsPreviewChars: 500`，在连续重复调用时向链路插提醒（[packages/bundle/base/cordis.patch.yml:434-438](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L434-L438)）
- `web` 行把搜索提供方定为 `deepseek-official`、抓取提供方定为 `http`（[packages/bundle/base/cordis.patch.yml:450-454](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L450-L454)）
- `web-search-deepseek` 行以 `apiKeyEnv: DEEPSEEK_API_KEY` 在每次搜索时解析凭据（[packages/bundle/base/cordis.patch.yml:456-459](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L456-L459)）
- 挂载 `web-fetch-http` 行（[packages/bundle/base/cordis.patch.yml:461-462](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L461-L462)）
- `tool-web` 行配 `fetch: false`（模型只看到 web_search）与 `searchTimeoutMs: 60000`（[packages/bundle/base/cordis.patch.yml:464-468](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L464-L468)）
- 挂载 `tools` 工具注册表行且不写 `mode`，保留其 schema 默认的呈现模式（[packages/bundle/base/cordis.patch.yml:474-475](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L474-L475)）
- `system-prompt` 行把 `persona` 置为空串，留给各 profile 覆盖（[packages/bundle/base/cordis.patch.yml:479-482](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L479-L482)）
- `agent-loop` 行把启动时创建的 `agents` 置为空数组（[packages/bundle/base/cordis.patch.yml:486-489](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L486-L489)）
- 挂载 `fs-sandbox` 行作为唯一的文件写入通道，`cwd` 缺省为 `process.cwd()`（[packages/bundle/base/cordis.patch.yml:493-494](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L493-L494)）
- 挂载 `llm-deepseek` 适配器行且不内联密钥与端点，二者按请求从设置段与凭据库解析（[packages/bundle/base/cordis.patch.yml:500-501](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/cordis.patch.yml#L500-L501)）

### packages/bundle/base/package.json

该 bundle 的 npm 清单，声明入口、可解析子路径、补丁文件位置以及补丁里每一行插件所依赖的工作区包。

- 声明 `"type": "module"` 并把入口指向 `lib/index.js`、类型指向 `lib/types/index.d.ts`（[packages/bundle/base/package.json:13-15](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/package.json#L13-L15)）
- `exports` 开放根入口、`./invariant`、`./cordis.patch.yml`、`./src/*` 与 `./package.json`（[packages/bundle/base/package.json:16-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/package.json#L16-L28)）
- `files` 把补丁文件一并纳入发布产物（[packages/bundle/base/package.json:29-34](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/package.json#L29-L34)）
- `dsh.bundle.patch` 指向 `./cordis.patch.yml`，profile 组合器据此字段解析该 bundle 的实质（[packages/bundle/base/package.json:36-40](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/package.json#L36-L40)）
- `dependencies` 列出补丁中每一行插件对应的工作区包，决定这些行在运行期能否被解析到（[packages/bundle/base/package.json:41-127](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/package.json#L41-L127)）

### packages/bundle/base/src/index.ts

该包的模块入口，只有一个空导出，实质由 `cordis.patch.yml` 承载。

- 无运行期机制

### packages/bundle/base/src/invariant.ts

该包的不变量伴生插件，注册到 `invariants` 服务上但不安装任何检查。

- `inject = ['invariants']` 把该伴生插件的激活时机拴在 `invariants` 服务可用之后（[packages/bundle/base/src/invariant.ts:14](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/src/invariant.ts#L14)）
- 安装器体为空，运行期不做任何检查（[packages/bundle/base/src/invariant.ts:20](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/src/invariant.ts#L20)）
- `apply` 以包名注册该安装器并返回注册的处置器（[packages/bundle/base/src/invariant.ts:27-28](https://github.com/deepseek-ai/deepseek-harness/blob/cd5ef8148158c3a752a658978873241fdf8e2bbc/packages/bundle/base/src/invariant.ts#L27-L28)）

### packages/bundle/base/tsconfig.json

该包的 TypeScript 编译配置，设定 `rootDir`/`outDir` 并引用 vendor 与不变量工程。

- 无运行期机制
