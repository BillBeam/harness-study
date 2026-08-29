# repos/

> English: [README.md](README.md)

钉住的目标仓库。只有 `pins.tsv` 和本文件入库，每个 `repos/<name>/` checkout 都被 gitignore，需要时按需重建：

```sh
scripts/pin.sh sync
```

## 为什么要全量克隆

`sync` 克隆时既不加 `--depth` 也不加 `--filter`，然后把 `HEAD` detach 在钉住提交上。这要花磁盘（mini-swe-agent：所有 ref 共 1489 个提交、21 MB，其中 1020 个从 pin 可达），换来的是一个研读仓库真正需要的能力——半年后无需联网就能追问**这段逻辑是哪次提交引入的**：

```console
$ cd repos/mini-swe-agent
$ git log --oneline -S 'MSWEA_GLOBAL_COST_LIMIT' --reverse --format='%h %ad %s' --date=short | head -1
af906e86 2025-07-09 Feat: add global cost tracking (#88)

$ git blame -L 96,96 --date=short -- src/minisweagent/agents/default.py
d5dadf058 src/microsweagent/agents/default.py (Kilian Lieret 2025-07-10 96)         while True:
```

注意第二条命令：`blame` 报的是该文件当时的**旧路径**，所以改名追溯也活着。`--depth 1` 的克隆两个问题都答不了；`--filter=blob:none` 的克隆只能靠为每个需要的 blob 回一次网络才能答——而那恰恰是"钉住快照"本该消除的依赖。

## 为什么不用 submodule

git submodule 同样能钉住一个提交，也能工作。这里不用它，有两个理由：

- submodule 把 pin 记在 git index 里，在 diff 中几乎不可见（只有一行 `Subproject commit 25941c8...`，别无其他）。`pins.tsv` 把 URL、提交和一行备注放在一个**能读着 review** 的文件里。
- submodule 的命令假定父项目掌管 checkout 状态。`scripts/pin.sh` 则让目标仓库严格保持只读且可丢弃——删掉 `repos/<name>/` 再 `sync` 一次永远是安全的。

## 网络策略

克隆通过本环境的 HTTPS 出口代理进行，git 已经配置好；`https://github.com/...` 这类 URL 开箱可用、无需凭据，因为所有目标都是匿名读取的公开仓库。`pins.tsv` 里请用 `https://` 形式——`git@github.com:` 这种 SSH remote 需要一把这个环境没有理由持有的密钥。

`sync` 失败只会是两件事之一：

- **该主机不被出口策略允许。** 报出被拦截的主机，不要绕过去。
- **钉住的提交没了**（分支被删、历史被重写）。`sync` 会 fetch 一次然后如实告知。用 `scripts/pin.sh update <name> <ref>` 选一个新提交，再重跑 `make check`——所有写在旧提交上的笔记都会失败，直到被重读为止，这是**预期行为**。

## pin 记录的完整性

`sync` 除了 fetch 与 checkout，还会做两件容易被忽略的校验：

- 若克隆的 `origin` 与 pin 里的 URL 不一致（上游搬家了），它会重新指向而不是永远对着旧地址 fetch。
- 若 pin 记录的对象不是一个 commit——最常见的来源是 annotated tag，`pin.sh add <name> <url> <tag>` 早期版本会把 **tag 对象**而不是它指向的 commit 记进去——`sync` 会明确报错并给出应当记录的 id，而不是留下一个 `status` 永远显示 `drifted` 的幽灵状态。
