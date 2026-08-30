---
repo: deepseek-harness
commit: cd5ef8148158c3a752a658978873241fdf8e2bbc
title: 跑起 DeepSeek Harness：两次固定任务运行怎么复跑
---

# 跑起 DeepSeek Harness

这份文件只写**怎么跑**：一条命令、它做了什么、它写出什么。不写走查、不写盘点、不写技术点、不作解读。

## 钉住的是什么

| 名称 | 上游 | 钉住提交 |
| --- | --- | --- |
| deepseek-harness | https://github.com/deepseek-ai/deepseek-harness | `deepseek-harness@cd5ef8148158c3a752a658978873241fdf8e2bbc` |

上游以 `https://deepseek.com/harness/en/` 指向的官方仓库为准。本环境的出口策略挡掉了 `deepseek.com`，所以那一页没能直接打开；改用三处指向同一个仓库的证据落定：钉住提交里文档站的 GitHub 社交链接（`website/.vitepress/config.ts:190`）、随包 CLI 的 `repository` 字段（`apps/cli/package.json:8-11`），以及 npm 上 `@deepseek-ai/dsh` 的 `repository.url` 与 `homepage`。pin 以 `repos/pins.tsv` 为准。

## 前置条件

- Node `^22.19.0 || >=24.0.0`（`package.json` 的 `engines`），本次是 v22.22.2；pnpm 由 corepack 按仓库的 `packageManager` 取到 11.7.0。
- Python 3（跑任务副本自己的 unittest）。
- 一个模型 key，只从环境变量读：默认 `XAI_API_KEY`。
- 出口能到 `api.x.ai`。

## 一条命令

```sh
scripts/run_dsh.sh default     # 等同于 make run-dsh
scripts/run_dsh.sh minimal     # 等同于 make run-dsh VARIANT=minimal
```

第一次跑会先 `pnpm install --frozen-lockfile` 再 `pnpm run build`（几分钟），之后按钉住提交打一个戳，重跑跳过。两条命令可以任意顺序、任意次数重跑：每次都把工作副本删掉重铺，把这一变体的会话目录清掉重写。

改模型或供应商用环境变量，不改脚本：

```sh
DSH_API_KEY_VAR=XAI_API_KEY DSH_PROVIDER=xai DSH_MODEL=grok-4.3 scripts/run_dsh.sh minimal
```

## 脚本每次做的十件事

终端全文里的小节号与这里一一对应。

1. `scripts/pin.sh sync deepseek-harness` —— 把 `repos/deepseek-harness/` 落到钉住提交上。
2. 装依赖并构建（有戳则跳过），打印 node、pnpm、`dsh --version`。
3. 生成这一次的 `--patch` 覆盖层，并把全文打进终端记录。
4. 把 `study/mini-swe-agent/task/` 那个三文件滑动平均仓库复制成一份干净的临时工作副本（`.dsh-run/<变体>/workspace/`，不入库），`git init` 并提交一个有 bug 的基线，跑一遍改之前的测试。
5. 用 `env -i` 从空环境重建，只带白名单里的变量，在工作副本目录里跑 `dsh --profile headless --patch <覆盖层> "<任务正文>"`。任务正文就是 `task/README.md` 的全文。
6. 打印 agent 改出的 `git diff`。
7. 跑改之后的测试。
8. 复核上游 checkout 一字未改（`git status --porcelain` 为空）。
9. 把这一次的会话目录整个复制进 `trace/<变体>/sessions/`，并列出文件与字节数。
10. 从会话日志里读出这一次模型看见的工具名与系统提示；`minimal` 那次再拿上游自己的 snapshot 逐字节复核。

跑完在 tee 之外还有一道检查：`grep -rF` 整个 `trace/<变体>/`，key 的值出现在任何产物里就报错退出。

## 模型与配置（不含密钥）

| 项 | 值 | 从哪来 |
| --- | --- | --- |
| 供应商路由 | `xai` | `--patch` 里 `llm-pi-ai.config.providers.xai`，走 dsh 随包的 pi-ai 适配器 |
| 模型 | `grok-4.3` | `--patch` 里 `agent-default-model.config.model` |
| key | 只给变量名 `XAI_API_KEY` | `apiKeyEnv` 是一个凭据引用，请求时才解析；仓库里只出现变量名 |
| 遥测 | 关 | `DSH_TELEMETRY_DISABLED=1` |
| 权限模式 | `danger-full-access` | `DSH_PERMISSION_MODE`；headless 组合里没有能回答审批的人，留默认的 `ask` 会让需要审批的调用直接失败 |
| 会话日志编码 | `none`（不压缩） | `--patch` 里 `session-persistence-jsonl.config.compression`；随包默认是 `zstd` |

`dsh` 自己的默认路由是 `deepseek-official` / `deepseek-v4-flash`，本次没有用；换回去只要不传上面那两段 patch。

## 两个变体差在哪

`default` —— dsh 随包的 headless 组合，模型这一侧一字未改，只补了上表里的模型路由与日志编码。本次模型看见 25 个工具。

`minimal` —— 换成 dsh 随包「极简模式」preset 的组合（`packages/preset/agent-presets/presets/minimal/preset.yml:1-3`）。本次模型看见 2 个工具：`bash` 与 `str_replace_editor`。

为什么要一层 `--patch` 而不是一个选项：dsh 的一次性无人值守入口只有 `dsh --profile headless "<任务>"`（`apps/cli/src/args.ts:67`），而这个 bundle **不组合 preset 名册**，它自己的注释就写着这一点，并写明「要挂 preset 的部署得在这里先 join」（`packages/bundle/headless/src/index.ts:173-176`）——那是代码里的调用点，不是配置项。随包会挂名册的只有 Web 组合（`packages/bundle/web-app/cordis.patch.yml:436-438`）和 webhook 运行时。所以 `minimal` 这一次是把那个 preset 的组合搬到 headless 上：

- 关闭清单由脚本从 `packages/bundle/web-app/cordis.patch.yml` 现读现取（24 行，preset 拥有这些工具时 host 面的同名行必须让位）。
- 工具行由脚本从该 preset 自己的 `agent.cordis.yml` 现读现取，不手抄。
- 唯一改写的是它的 `persona` 行：那一行是 scope-only 的，挂在全局会与提示词注册表自己的注册冲突并 fail loud（`packages/preset/persona/src/index.ts:5-8`）。脚本把它那句话放进 deployment persona 槽，并关掉固定身份与运行期上下文快照。

改写得对不对不靠自述：第 10 步拿上游自己的 snapshot 复核，`minimal` 这次的系统提示与 `snapshots/web/minimal-preset/system-prompt.expected.md:1` 逐字节相同，工具名集合与 `snapshots/web/minimal-preset/tool-schemas.expected.json:1` 相同。这两行写在终端全文里。

## 它的日志文件是什么、放在哪、一次跑几个

**格式**：JSONL，一行一条记录，UTF-8 纯文本。第一行是不可变的 `SessionHeader`，带 `version`（本次为 `0`）、会话 id、`createdAt`、`cwd`；其后每个逻辑事件一行，连续的 assistant chunk 可能被打包成一行（`packages/session/session-persistence-jsonl/README.md:57-64`）。事件按 `type` 分：`turn/start`、`step/start`、`request/header`、`assistant/chunk`、`tool/call`、`tool/result`、`step/end`、`turn/end` 等。随包默认的物理编码是 zstd 校验帧，文件名 `session.jsonl.zstd`；只有 `compression: 'none'` 才是逐行文本的 `session.jsonl`（`packages/session/session-persistence-jsonl/README.md:49`）。本仓库的两次运行都设了 `none`，留下的就是可直接读的 JSONL。

**放在哪**：根目录默认是 `$DSH_HOME/sessions`（`packages/bundle/base/cordis.patch.yml:110-113`），`$DSH_HOME` 默认 `~/.dsh`。脚本把它指到 `.dsh-run/<变体>/home`，所以每个变体的会话是干净的一份。根目录之下的布局是 `<root>/--<归一化 cwd>--/<会话 id>/session.jsonl`。

**一次跑产生几个文件**：会话日志**一个**——一次运行一个会话，一个会话一个文件。同一次运行在 `$DSH_HOME` 下另外还会写一个投影缓存文件 `storages/session_projcache/sessions/<会话 id>.json`；`$DSH_HOME/profiles/headless/` 下那四个文件（`cordis.yml`、`cordis.patch.yml`、`package.json`、`pnpm-workspace.yaml`）是 profile 的骨架，第一次启动时建好，之后每次运行只重写 `cordis.yml`，不随运行增加。留进本仓库的是会话日志本身加脚本自己 tee 的终端全文。

## 两次运行留下了什么

```
study/deepseek-harness/trace/
  minimal/
    terminal.txt                                              13 KB
    sessions/--home-user-harness-study-.dsh-run-minimal-workspace--/
      session-24f3516e-3cfd-4db8-b159-8439ec5d80e6/
        session.jsonl                                        207 KB   561 行
  default/
    terminal.txt                                             8.4 KB
    sessions/--home-user-harness-study-.dsh-run-default-workspace--/
      session-450c241d-48a0-4182-8440-7f966bf0eb0b/
        session.jsonl                                         62 KB    88 行
```

两次都退 0，改后的 4 条 unittest 全过，上游 checkout 都是 clean。会话目录名里的那一段是工作副本路径的归一化形式，工作副本路径是固定的，所以重跑会落到同名目录。

## 卡外发现

这一卡没要求找的，都在钉住提交或本仓库当前内容上复核过。

- **dsh 的 agent preset 在命令行上没有开关。** 一次性入口 `--profile headless` 自己的源码写明它不组合 preset 名册，要挂得在 agent 工厂的 `setup` 里 join（`packages/bundle/headless/src/index.ts:173-176`）；随包非测试代码里真正调 `agentPresets.mount()` 的只有 webhook 那一处，而 webhook 还需要一段自带的可信规则代码与 Web 侧的 workspace 机制。所以「选一个预设跑一次」这件事，随包只有浏览器界面上做得到。本卡的做法与它的可复核性写在上面「两个变体差在哪」。
- **preset 的组合不能整份搬到 host 面。** 第一次尝试把 `minimal/agent.cordis.yml` 原样插进 headless 的树，启动即 fail loud：`prompt section "deployment:persona" is already registered`。原因写在 `packages/preset/persona/src/index.ts:5-8`。这也是那份组合里唯一一行不能照搬的。
- **随包默认会把会话事件上报到 `harness-telemetry.deepseeksvc.com`。** `session-telemetry-otel` 在 base 组合里，默认 `mode: FEEDBACK_ONLY`，exporter 的 URL 写死在配置里、可用 `DSH_TELEMETRY_OTLP_URL` 覆盖。脚本一律设 `DSH_TELEMETRY_DISABLED=1`（任何非空值都关）。
- **headless 组合里没有步数、花费或时间上限。** 循环转到模型不再调工具为止。这不是推测：`packages/core/agent/src` 里 grep 不到步数或花费上限，两次运行的会话日志里也只有 `turn/end` 一条终止记录。`minimal` 那次转了 39 步、写了 561 行日志，`default` 那次 5 步、88 行；两次改出的补丁是同一行（`range(len(values) - window)` → `range(len(values) - window + 1)`）。
- **`dsh` 的一次性入口不写工作目录选项。** 工作目录就是进程的 cwd（base 组合里的 `workspaceRoot` 与 fs 提供方都取 `process.cwd()`），所以脚本必须 `cd` 到工作副本里再起进程。
- **上游 checkout 会被装依赖和构建写进东西，但仍然 git-clean。** `node_modules/`、各包的 `lib/`、`*.tsbuildinfo` 都在上游自己的 `.gitignore` 里；构建戳放在 `.dsh-run/` 而不是 checkout 里，就是为了让第 8 步那条「一字未改」的检查有意义。
- **`census-findings.md` 第八节里有三条已经被这一卡收尾**（标题仍写「第二版」、出处标记里两条 `[mini]`、`matrix.md` 与 `matrix.zh-CN.md` 并存），但按边界没有回去改那一节——它是上一卡的记录，不是对当前仓库的断言。同一节里「第一、二节引用的清单行号整体失效」那条，现在只对第二节还成立：第一节的末列这一卡已经换成技术点编号。
- **`LOG.md` 第 91 行仍写着「补齐全部阅读文档的中文版（`*.zh-CN.md`）」并说 `matrix.zh-CN.md` 与 `LOG.zh-CN.md` 已加入默认扫描目标。** 那是当时那次会话的记录，按日志的性质没有改；只把第 80 行指向已删文件的路径改成了 `repos/README.md`，让那句「理由见 …」仍然指得到。
- **`points/README.md` 里「`matrix.md` 里的空格子就是这个仓库的骨架」这句仍不成立**（上一卡已记）。本卡只往 `matrix.md` 底部的「钉住的仓库」小表加了 deepseek-harness 一行，让那份 pin 的可读副本保持为真；没有加技术点列，卡面没要求。按 `README.md` 的「新增一份研读」第 5 步，这里本该同时往 `LOG.md` 加一条，卡面也没要求，没有加。
- **锚点总数从 2337 降到 2212**：删掉的七份 `.zh-CN.md` 与它们各自的锚点，加上 `matrix.zh-CN.md` 的 104 条。本文件自己再加一批。
