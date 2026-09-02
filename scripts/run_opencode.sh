#!/usr/bin/env bash
# 用钉住的 OpenCode 跑一个固定的小任务，把它自己记录的会话数据与终端全文留在
# study/opencode/trace/ 下。
#
# 用法：
#   scripts/run_opencode.sh        （等同于 make run-opencode）
#
# 环境变量：
#   OC_API_KEY_VAR   放 API key 的变量名，默认 XAI_API_KEY。key 只从环境读，不写进仓库。
#   OC_MODEL         模型，provider/model 形式，默认 xai/grok-4.3。
#   OC_RUN_DIR       工作副本、本地 HOME 与随包二进制的根，默认 <仓库>/.opencode-run。
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM="$ROOT/repos/opencode"
TASK_DIR="$ROOT/study/mini-swe-agent/task"
TRACE="$ROOT/study/opencode/trace"

die() { printf 'run_opencode: %s\n' "$*" >&2; exit 1; }

KEY_VAR="${OC_API_KEY_VAR:-XAI_API_KEY}"
MODEL="${OC_MODEL:-xai/grok-4.3}"
RUN_ROOT="${OC_RUN_DIR:-$ROOT/.opencode-run}"

WORK="$RUN_ROOT/workspace"
HOME_DIR="$RUN_ROOT/home"
BIN_ROOT="$RUN_ROOT/bin"
OC="$BIN_ROOT/node_modules/.bin/opencode"
# OpenCode 的数据目录是 XDG 的 data 目录下的 opencode/；HOME 被指到 $HOME_DIR 后就是这里。
DATA="$HOME_DIR/.local/share/opencode"

[ -d "$TASK_DIR" ] || die "找不到 $TASK_DIR"
KEY="${!KEY_VAR:-}"
[ -n "$KEY" ] || die "环境变量 $KEY_VAR 没设。key 只走环境变量，不写进仓库。"

# 只有这些变量名会被带进 opencode 的进程。它的 bash 工具在这个进程的子进程里跑命令，
# 容器里其余的凭据不该有机会出现在终端全文或会话数据里，所以用 env -i 从空环境重建，
# 白名单之外一律不带。跑完还会逐个文件确认 key 本身没有落进产物。
FORWARD_ENV=(HTTP_PROXY HTTPS_PROXY NO_PROXY http_proxy https_proxy no_proxy
             SSL_CERT_FILE SSL_CERT_DIR REQUESTS_CA_BUNDLE CURL_CA_BUNDLE
             NODE_EXTRA_CA_CERTS LANG LC_ALL)

# 在与跑 agent 相同的空环境里执行一条 opencode 命令。
oc() {
  local env_args=() name
  for name in "${FORWARD_ENV[@]}"; do
    if [ -n "${!name:-}" ]; then env_args+=("$name=${!name}"); fi
  done
  env -i \
    PATH="/usr/local/bin:/usr/bin:/bin" \
    HOME="$HOME_DIR" \
    COLUMNS=120 \
    OPENCODE_DISABLE_AUTOUPDATE=1 \
    "$KEY_VAR=$KEY" \
    "${env_args[@]}" \
    "$OC" "$@"
}

run() {
  printf '=== 复跑记录 ===\n'
  printf 'command     : scripts/run_opencode.sh\n'
  printf 'date        : %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  printf 'model       : %s\n' "$MODEL"
  printf 'api key     : 取自环境变量 %s（已设置，不入库）\n' "$KEY_VAR"
  printf 'permissions : --auto（无人值守：未被显式拒绝的权限请求一律放行）\n'
  printf 'autoupdate  : OPENCODE_DISABLE_AUTOUPDATE=1\n'

  # 1) 把钉住的仓库落到 repos/ 下的钉住提交上。已经在位时这一步只是确认。
  printf '\n=== 1. 同步 pin ===\n'
  "$ROOT/scripts/pin.sh" sync opencode
  local PIN; PIN="$(git -C "$UPSTREAM" rev-parse HEAD)"
  printf 'opencode @ %s\n' "$PIN"

  # 2) 取与 pin 同一版本的随包二进制。上游 monorepo 用 bun 从源码跑，但它的 lockfile 里有一个
  #    走 api.github.com tarball 的依赖（packages/app 的 ghostty-web），本环境的出口策略挡住了
  #    那个主机，bun install 整个 workspace 一起失败。所以改用 npm 上同一版本的发布件：
  #    opencode-ai@<版本> 拉平台包 opencode-linux-x64，里面是上游 publish 工作流从同名
  #    tag 构建出的单文件二进制。下面会证明 tag 与 pin 是同一个提交、二进制自报的版本与
  #    pin 处 package.json 的版本相同。
  printf '\n=== 2. 准备二进制 ===\n'
  local VERSION
  VERSION="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["version"])' \
             "$UPSTREAM/packages/opencode/package.json")"
  local TAG_COMMIT
  TAG_COMMIT="$(git -C "$UPSTREAM" rev-parse "v$VERSION^{commit}" 2>/dev/null || true)"
  printf 'pin 处 packages/opencode/package.json 的 version : %s\n' "$VERSION"
  printf 'tag v%s 指向的提交                          : %s\n' "$VERSION" "${TAG_COMMIT:-（没有这个 tag）}"
  [ "$TAG_COMMIT" = "$PIN" ] || die "tag v$VERSION 不是钉住提交，随包二进制对不上 pin"
  local stamp="$RUN_ROOT/.installed-$PIN"
  if [ ! -f "$stamp" ]; then
    rm -rf "$BIN_ROOT"; mkdir -p "$BIN_ROOT"
    ( cd "$BIN_ROOT" && npm init -y >/dev/null \
        && npm install --no-audit --no-fund --loglevel=error "opencode-ai@$VERSION" )
    : > "$stamp"
  fi
  local GOT; GOT="$("$OC" --version)"
  printf 'opencode --version                          : %s\n' "$GOT"
  [ "$GOT" = "$VERSION" ] || die "二进制版本 $GOT 与 pin 的 $VERSION 不同"
  printf 'binary      : %s\n' "$(readlink -f "$OC")"

  # 3) 把三文件的小仓库复制成一份干净的工作副本。模板保持有 bug 的原样，可以反复跑。
  printf '\n=== 3. 铺工作副本 ===\n'
  rm -rf "$WORK"; mkdir -p "$WORK"
  find "$TASK_DIR" -maxdepth 1 -type f -exec cp {} "$WORK/" \;
  git -C "$WORK" init -q
  git -C "$WORK" add -A
  git -C "$WORK" -c user.name=run_opencode -c user.email=run_opencode@localhost commit -q -m "buggy baseline"
  printf 'work dir    : %s\n' "$WORK"
  ls -1 "$WORK"
  printf '\n--- 改之前的测试 ---\n'
  ( cd "$WORK" && python3 -m unittest -v 2>&1 | tail -5 ) || true

  # 4) 跑 opencode run。这是它的非交互入口：吃一条消息，把回复打到 stdout 然后退出。
  #    --dir 指定工作目录（它会 chdir 过去）；--model 用 provider/model；--auto 放行权限请求，
  #    不加时 run 模式会把每个权限请求自动判 reject（它自己的源码写着 auto-rejecting）。
  #    HOME 指到本次的空目录，所以它的配置、数据、缓存、日志全落在 $RUN_ROOT/home 下，
  #    与容器里真正的 HOME 无关。
  printf '\n=== 4. 跑 opencode run ===\n'
  rm -rf "$HOME_DIR"; mkdir -p "$HOME_DIR"
  ( cd "$WORK" && oc run \
      --dir "$WORK" \
      --model "$MODEL" \
      --auto \
      --title "harness-study moving-average" \
      "$(cat "$TASK_DIR/README.md")" \
      < /dev/null )

  # 5) 结果：agent 到底改了什么，测试是不是真的绿了。
  printf '\n=== 5. agent 改了什么 ===\n'
  git -C "$WORK" --no-pager diff
  printf '\n=== 6. 改之后的测试 ===\n'
  ( cd "$WORK" && python3 -m unittest -v 2>&1 )

  # 6) 上游 checkout 必须一字未改：这个仓库只读目标仓库。
  printf '\n=== 7. 上游 checkout 是否被改动 ===\n'
  local dirty; dirty="$(git -C "$UPSTREAM" status --porcelain)"
  if [ -n "$dirty" ]; then printf '%s\n' "$dirty"; die "上游 checkout 被改动了"; fi
  printf 'clean\n'

  # 7) 把它自己的数据目录原样搬进 trace/。会话、消息、消息片段都在一个 SQLite 库
  #    opencode.db 里（WAL 模式，所以 -wal 与 -shm 两个伴生文件也是它的一部分）；log/ 下是
  #    它的日志。先复制，再从运行目录里的那份库读会话 id 与计数，读库不碰 trace/ 里的副本。
  printf '\n=== 8. 会话数据 ===\n'
  printf 'data dir    : %s\n' "$DATA"
  ( cd "$DATA" && find . -type f -printf '%8s  %p\n' | sort -k2 )
  rm -rf "$TRACE/data"; mkdir -p "$TRACE"
  cp -r "$DATA" "$TRACE/data"
  printf '\n--- 落进 study/opencode/trace/data/ 的文件 ---\n'
  ( cd "$TRACE" && find data -type f -printf '%8s  %p\n' | sort -k2 )

  local SESSION
  SESSION="$(python3 - "$DATA/opencode.db" <<'PY'
import sqlite3, sys
db = sqlite3.connect(sys.argv[1])
rows = db.execute("select id from session order by time_created desc").fetchall()
print(rows[0][0] if rows else "")
PY
)"
  [ -n "$SESSION" ] || die "库里没有会话"
  printf '\n--- 库里的计数 ---\n'
  python3 - "$DATA/opencode.db" "$SESSION" <<'PY'
import sqlite3, sys
db = sqlite3.connect(sys.argv[1]); sid = sys.argv[2]
n_sess = db.execute("select count(*) from session").fetchone()[0]
n_msg = db.execute("select count(*) from message where session_id=?", (sid,)).fetchone()[0]
n_part = db.execute("select count(*) from part where session_id=?", (sid,)).fetchone()[0]
row = db.execute("select title, model, cost, tokens_input, tokens_output, tokens_reasoning from session where id=?", (sid,)).fetchone()
print(f"session id  : {sid}")
print(f"title       : {row[0]}")
print(f"model       : {row[1]}")
print(f"cost        : {row[2]}")
print(f"tokens      : input {row[3]}, output {row[4]}, reasoning {row[5]}")
print(f"sessions    : {n_sess}")
print(f"messages    : {n_msg}（本会话）")
print(f"parts       : {n_part}（本会话）")
PY

  # 8) 再用它自己的 export 命令把这一个会话导成 JSON，作为可直接读的副本；原件仍是上面的库。
  printf '\n=== 9. opencode export ===\n'
  ( cd "$WORK" && oc export "$SESSION" > "$TRACE/session.export.json" < /dev/null )
  printf 'session.export.json : %s 字节\n' "$(wc -c < "$TRACE/session.export.json")"
}

mkdir -p "$TRACE" "$RUN_ROOT"

set +e
run 2>&1 | tee "$TRACE/terminal.txt"
rc="${PIPESTATUS[0]}"
set -e

# 产物里不许出现 key 本身。这是「密钥只走环境变量」的可执行版本：不是承诺，是检查。
if grep -rqF -- "$KEY" "$TRACE" 2>/dev/null; then
  die "$KEY_VAR 的值出现在 $TRACE 里，已中止；请清掉再提交"
fi
printf '\nrun_opencode: 完成（退出码 %s），产物在 study/opencode/trace/，已确认不含 %s 的值\n' \
  "$rc" "$KEY_VAR"
exit "$rc"
