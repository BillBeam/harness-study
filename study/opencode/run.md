---
repo: opencode
commit: 774cc7c1914e4329eefde5a669f938b0cf566661
title: 跑起 OpenCode：一次固定任务运行怎么复跑
---

# 跑起 OpenCode

这份文件只写**怎么跑**：一条命令、它做了什么、它写出什么。不写走查、不写盘点、不写技术点、不作解读。

## 钉住的是什么

| 名称 | 上游 | 钉住提交 |
| --- | --- | --- |
| opencode | https://github.com/anomalyco/opencode | `opencode@774cc7c1914e4329eefde5a669f938b0cf566661` |

上游以 `https://opencode.ai` 指向的官方仓库为准。本环境的出口策略挡掉了 `opencode.ai`，那一页没能直接打开；改用三处指向同一个仓库的证据落定：钉住提交里 README 的标题链接指向 `opencode.ai`（`README.md:2`），同一份 README 的构建徽章与发布页链接都指向 `github.com/anomalyco/opencode`（`README.md:14`、`README.md:69`）；旧地址 `github.com/sst/opencode` 对 `git ls-remote` 报出的 HEAD 与 `anomalyco/opencode` 完全相同，是同一个仓库的转向。钉住提交是 tag `v1.18.26` 指向的提交，与 `packages/opencode/package.json:3` 的 `version` 一致。pin 以 `repos/pins.tsv` 为准。

## 前置条件

- Node 与 npm（本次 v22.22.2）：只用来从 npm 取随包二进制，OpenCode 自己不跑在 Node 上。
- Python 3（跑任务副本自己的 unittest，以及从它的 SQLite 库里读会话 id）。
- 一个模型 key，只从环境变量读：默认 `XAI_API_KEY`。
- 出口能到 `registry.npmjs.org`（取二进制、以及它启动时自装 provider 依赖）与 `api.x.ai`。

## 一条命令

```sh
scripts/run_opencode.sh        # 等同于 make run-opencode
```

第一次跑会先从 npm 装 `opencode-ai@1.18.26`（几秒），按钉住提交打一个戳，重跑跳过。可以任意次数重跑：每次都把工作副本与本地 HOME 删掉重铺，把 `trace/` 下的会话数据清掉重写。

改模型或 key 变量名用环境变量，不改脚本：

```sh
OC_API_KEY_VAR=XAI_API_KEY OC_MODEL=xai/grok-4.3 scripts/run_opencode.sh
```

| 变量 | 默认 | 作用 |
| --- | --- | --- |
| OC_API_KEY_VAR | XAI_API_KEY | 从哪个变量取 API key |
| OC_MODEL | xai/grok-4.3 | 模型，`provider/model` 形式 |
| OC_RUN_DIR | `<仓库>/.opencode-run` | 工作副本、本地 HOME、随包二进制放哪（不入库） |

## 为什么是随包二进制，不是从源码跑

上游 monorepo 用 bun 从源码跑（`packages/opencode/package.json` 的 `dev` 脚本）。它的 lockfile 里有一个走 GitHub tarball 的依赖——`packages/app/package.json:86` 的 `ghostty-web`——bun 要从 `api.github.com` 取它，而本环境的出口策略挡住了这个主机；`bun install --frozen-lockfile` 整个 workspace 一起失败，加 `--filter opencode` 也一样，因为 lockfile 是整份解析的。上游源码一字未改，所以改用 npm 上同一版本的发布件：`opencode-ai@1.18.26` 拉平台包 `opencode-linux-x64`，里面是上游发布脚本打出的单文件二进制（`packages/opencode/script/publish.ts:91`）。脚本第 2 步用两条检查把它钉回 pin：tag `v1.18.26` 在本地克隆里解析出的提交必须等于钉住提交，`opencode --version` 报的版本必须等于 pin 处 `package.json` 的 `version`；任一不等即退出。

## 脚本每次做的九件事

终端全文里的小节号与这里一一对应。

1. `scripts/pin.sh sync opencode` —— 把 `repos/opencode/` 落到钉住提交上。
2. 取随包二进制（有戳则跳过），做上面那两条 tag = pin、version = pin 的检查，打印二进制路径。
3. 把 `study/mini-swe-agent/task/` 那个三文件滑动平均仓库复制成一份干净的临时工作副本（`.opencode-run/workspace/`，不入库），`git init` 并提交一个有 bug 的基线，跑一遍改之前的测试。
4. 用 `env -i` 从空环境重建，只带白名单里的变量，HOME 指到本次的空目录 `.opencode-run/home/`，在工作副本目录里跑 `opencode run --dir <工作副本> --model xai/grok-4.3 --auto --title "harness-study moving-average" "<任务正文>"`。任务正文就是 `task/README.md` 的全文。
5. 打印 agent 改出的 `git diff`。
6. 跑改之后的测试。
7. 复核上游 checkout 一字未改（`git status --porcelain` 为空）。
8. 把它的数据目录整个复制进 `trace/data/`，列出文件与字节数；再从运行目录里那份库读出会话 id、模型、花费、token 与计数（读库不碰 `trace/` 里的副本）。
9. 用它自己的 `opencode export <会话 id>` 把这一个会话导成 JSON，写到 `trace/session.export.json`。

跑完在 tee 之外还有一道检查：`grep -rF` 整个 `trace/`，key 的值出现在任何产物里就报错退出。

## 模型与配置（不含密钥）

| 项 | 值 | 从哪来 |
| --- | --- | --- |
| 模型 | `xai/grok-4.3` | 命令行 `--model`，`provider/model` 形式 |
| key | 只给变量名 `XAI_API_KEY` | 它的 xai provider 从这个环境变量读；仓库里只出现变量名 |
| 权限 | `--auto` | 无人值守：未被显式拒绝的权限请求一律放行（`packages/opencode/src/cli/cmd/run.ts:242-245`）；不加时 run 模式把每个权限请求自动判 reject（`packages/opencode/src/cli/cmd/run.ts:805-819`） |
| 自动更新 | 关 | `OPENCODE_DISABLE_AUTOUPDATE=1`（`packages/core/src/flag/flag.ts:23`） |
| 配置文件 | 没有给 | HOME 指到空目录，它自己建了一个只含 `$schema` 的 `~/.config/opencode/opencode.jsonc` |
| 模型目录 | 二进制内置快照 | 目录源是 `https://models.opencode.ai`（`packages/core/src/models-dev.ts:160-163`），被出口策略挡住；取不到时用编进二进制的快照（`packages/core/src/models-dev.ts:216-222`），日志里有一条 `Failed to fetch models.dev` |
| 分享 | 未开 | run 模式只在配置 `share: auto` 或传 `--share` 时分享，本次都没有 |

grok-4.3 的工具调用与它兼容：这一次 6 轮 assistant 消息里的 glob、read、bash、edit 调用全部正常返回，没有换模型。

## 它的会话数据是什么、放在哪、一次跑几个

**放在哪**：XDG data 目录下的 `opencode/`，Linux 上默认 `~/.local/share/opencode/`（`packages/core/src/global.ts:10-14`）。脚本把 HOME 指到 `.opencode-run/home/`，所以就是 `.opencode-run/home/.local/share/opencode/`；日志在其下 `log/`。

**格式**：一个 SQLite 库 `opencode.db`，会话、消息、消息片段是三张表 `session`、`message`、`part`（`packages/opencode/src/storage/schema.ts:1-5`，表定义在 `packages/core/src/session/sql.ts:22`、`:68`、`:82`）。`message` 与 `part` 的正文是一列 JSON 文本 `data`。库开着 WAL（`packages/core/src/database/database.ts:27`），所以 `opencode.db-wal` 与 `opencode.db-shm` 两个伴生文件也是它的一部分；本次退出后主文件仍是 4096 字节，全部内容都在 `-wal` 里，三个文件要一起看。日志 `log/opencode.log` 是逐行 `key=value` 文本。另有一个 `snapshot/<项目 id>/<目录 id>/` 目录，是它给工作副本做文件快照用的一个 git 目录，`objects/info/alternates` 指向工作副本自己的 `.git/objects`。

**一次跑产生几个文件**：会话本身**不增加文件**——所有会话都进同一个库，一次运行是库里的一行 `session` 加它的 `message`、`part` 行。数据目录里这一次共有 33 个文件：库的 3 个、日志 1 个、快照目录 29 个。`opencode export` 打出的 JSON（`packages/opencode/src/cli/cmd/export.ts:289-290`）是脚本另加的可读副本，顶层两个键：`info`（会话行）、`messages`（每条消息带 `info` 与 `parts`）。

## 这次运行留下了什么

```
study/opencode/trace/
  terminal.txt                    14 KB   这条命令的终端全文（含它输出的 ANSI 颜色码）
  session.export.json             36 KB   opencode export 的输出，7 条消息、28 个片段
  data/                           它的数据目录原样复制
    opencode.db                    4 KB
    opencode.db-wal             3.1 MB
    opencode.db-shm               32 KB
    log/opencode.log              12 KB
    snapshot/69eab76f…/b2bc6dba…/  29 个文件（git 目录：HEAD、config、index、hooks/*.sample、objects/…）
```

| 项 | 值 |
| --- | --- |
| 会话 id | `ses_f9ff86c46ffeSDyJ6l5c87GNsA` |
| 模型 | `xai/grok-4.3`（库里记为 `{"id":"grok-4.3","providerID":"xai","variant":"default"}`） |
| 消息 / 片段 | 7 / 28（1 条 user、6 条 assistant） |
| token | input 8608，output 154，reasoning 153 |
| 花费（它自己算的） | 约 0.0195 美元 |
| 改出的补丁 | `range(len(values) - window)` → `range(len(values) - window + 1)`，只动 `stats.py` 一行 |
| 结果 | 退 0，改后的 4 条 unittest 全过，上游 checkout clean |

三个产物都会被下一次 `make run-opencode` 覆盖。

## 卡外发现

这一卡没要求找的，都在钉住提交或本环境上复核过。

- **本环境的出口策略挡住了 `opencode.ai`、`models.dev`、`models.opencode.ai` 与 `api.github.com`**，放行 `github.com`、`raw.githubusercontent.com`、`registry.npmjs.org`、`api.x.ai`。上游身份、模型目录、源码依赖三件事各绕了一次，绕法写在上面对应小节。
- **从源码跑被一个依赖挡住，与 OpenCode 自己的代码无关。** 挡住的是 `packages/app/package.json:86` 的 `ghostty-web`（桌面/网页端用的终端组件），走 `github:` 协议；bun 只认 `api.github.com` 的 tarball 接口。`packages/opencode` 自己不依赖它，但 bun 的 `--filter` 不缩小 lockfile 解析范围。
- **模型目录取不到时它不报错、不停。** `Failed to fetch models.dev` 只进日志（level=ERROR），随后用二进制里编进去的快照继续；`~/.cache/opencode/models.json` 不会被写出。本次它对 `xai` 列出的 12 个模型 id 与 `api.x.ai/v1/models` 当天返回的 12 个完全相同。
- **它启动时会往配置目录里装依赖。** 运行后 `~/.config/opencode/` 下多了 `node_modules/`（`@ai-sdk/provider`、`effect`、`zod` 等二十多个包）、`package.json`、`package-lock.json`、`bun.lock` 与一个写着 `node_modules` 的 `.gitignore`；这一步要能到 npm registry。它们在配置目录不在数据目录，脚本没有复制。
- **`opencode run` 里没有「问人」这一档。** 权限请求要么 `--auto` 放行，要么自动 reject（`packages/opencode/src/cli/cmd/run.ts:805-819`）；没有步数、花费或时间上限选项。这一次 6 轮就停了，是模型自己不再调工具。
- **只复制 `opencode.db` 会得到一个空库。** 退出前它发了一次 `wal_checkpoint(PASSIVE)`（`packages/core/src/database/database.ts:32`），但本次退出后主文件仍是初始的 4096 字节，3.1 MB 内容全在 `-wal`。用 sqlite 打开时三个文件放一起即可正常读。
- **快照目录不是自包含的。** `snapshot/…/objects/info/alternates` 里写的是工作副本 `.git/objects` 的绝对路径，工作副本一删，那个 git 目录里引用的对象就解析不到；`config` 里的 `worktree` 也是绝对路径。`trace/data/` 里的那份只能看它自己 `objects/` 下的 9 个对象。
- **`sst/opencode` 已是转向。** `git ls-remote` 对两个地址报同一个 HEAD；README 里所有 GitHub 链接都写 `anomalyco/opencode`。`pins.tsv` 记的是转向后的地址。
- **`make selftest` 要求每个 pin 在 `scripts/census_coverage.py` 的 `REPO_SCOPE` 里有一条声明**（用例「every pin has a declared census scope」，它自己的注释写着「新 pin 应当在这里被注意到」）。加了 opencode 这一行 pin 之后这条用例即红，与本卡「不改覆盖脚本」的边界相撞；两者只能留一个，选择了让验收里的 `make selftest` 绿：往 `REPO_SCOPE` 加了一条只含数据的 opencode 条目（`roots: ["packages", ""]`，注明是初步声明、没有做普查），脚本的规则与逻辑一行未动。opencode 没有 census，默认的 `make coverage` 按脚本原有逻辑跳过它。这是本卡唯一碰到覆盖脚本的地方，写在这里供复核。
- **`matrix.md` 底部「钉住的仓库」小表加了 opencode 一行**，让那份 pin 的可读副本保持为真；没有加技术点列，卡面没要求。按 `README.md` 的「新增一份研读」第 5 步，这里本该同时往 `LOG.md` 加一条，卡面没要求，没有加，与上一卡处理一致。
- **CI 的 `make sync` 从此多克隆一个 635 MB、15633 个提交的仓库。** 全量克隆是 `repos/README.md` 定下的规矩，没有改。
