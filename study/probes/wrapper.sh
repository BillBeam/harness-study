#!/usr/bin/env bash
# 差分探针的外部 wrapper。
#
# 同一个探针任务模板，在 mini-swe-agent、dsh 默认组合与 opencode 的 run 模式上各跑一次，
# 把每家自己的会话记录与这一次的终端全文留在 study/probes/<探针名>/<仓库>/ 下。
#
# 用法：
#   study/probes/wrapper.sh <探针名> <仓库>
#     探针名：kill | big-output | edit | unfinishable
#     仓库  ：mini-swe-agent | deepseek-harness | opencode
#
# 兜底（对每一次运行都生效，不只是不完探针）：
#   墙钟 PROBE_WALL_LIMIT 秒（默认 480，即 8 分钟）
#   步数 PROBE_STEP_LIMIT 步（默认 40）
# 两者由本 wrapper 在 harness 之外数，数到就 kill。各家自己的上限（mini 有、dsh 的
# headless 组合没有、opencode run 没有）一律保持原样，谁先停下就是谁先停下，终端全文里写明是谁。
#
# 环境变量：
#   XAI_API_KEY       模型 key，只从环境读，不写进仓库（跑完逐字节复核产物里没有它）。
#   PROBE_WALL_LIMIT  墙钟上限秒数，默认 480。
#   PROBE_STEP_LIMIT  步数上限，默认 40。
#   OC_RESUME_SESSION 只对 opencode：续跑时给 `opencode run --session <id>` 的会话 id。
#   OC_DATA_DEST      只对 opencode：数据目录复制到 study/probes/<探针名>/opencode/ 下的目录名，默认 data。
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
PROBE="${1:-}"
REPO="${2:-}"

die() { printf 'wrapper: %s\n' "$*" >&2; exit 1; }

case "$PROBE" in
  kill|big-output|edit|unfinishable) ;;
  *) die "探针名只能是 kill / big-output / edit / unfinishable，收到 '${PROBE}'" ;;
esac
case "$REPO" in
  mini-swe-agent|deepseek-harness|opencode) ;;
  *) die "仓库只能是 mini-swe-agent、deepseek-harness 或 opencode，收到 '${REPO}'" ;;
esac

TASK_DIR="$ROOT/study/probes/tasks/$PROBE"
OUT="$ROOT/study/probes/$PROBE/$REPO"
[ -d "$TASK_DIR" ] || die "找不到任务模板 $TASK_DIR"
mkdir -p "$OUT"

KEY_VAR="${PROBE_API_KEY_VAR:-XAI_API_KEY}"
KEY="${!KEY_VAR:-}"
[ -n "$KEY" ] || die "环境变量 $KEY_VAR 没设。key 只走环境变量，不写进仓库。"

WALL="${PROBE_WALL_LIMIT:-480}"
STEPS="${PROBE_STEP_LIMIT:-40}"

MINI_UP="$ROOT/repos/mini-swe-agent"
DSH_UP="$ROOT/repos/deepseek-harness"
VENV="$ROOT/.venv"
RUN_ROOT="$ROOT/.dsh-run/probe-$PROBE"
WORK="$RUN_ROOT/workspace"
DSH_HOME_DIR="$RUN_ROOT/home"
PATCH="$RUN_ROOT/run.patch.yml"
TRAJ="$OUT/mini.traj.json"

# opencode：与 scripts/run_opencode.sh 同一套——钉住仓库、npm 上同版本的随包二进制、HOME 指到
# 本次的空目录。它的数据目录（SQLite 库、日志、快照 git 目录）就在这个 HOME 的 XDG data 下。
OC_UP="$ROOT/repos/opencode"
OC_BIN_ROOT="$ROOT/.opencode-run/bin"
OC="$OC_BIN_ROOT/node_modules/.bin/opencode"
OC_HOME_DIR="$RUN_ROOT/home"
OC_DATA="$OC_HOME_DIR/.local/share/opencode"

# 与 scripts/run_mini.sh、scripts/run_dsh.sh 同一份白名单：agent 在自己的 shell 里
# 执行命令，容器里其余的凭据不该有机会出现在终端全文或会话记录里。
FORWARD_ENV=(HTTP_PROXY HTTPS_PROXY NO_PROXY http_proxy https_proxy no_proxy
             SSL_CERT_FILE SSL_CERT_DIR REQUESTS_CA_BUNDLE CURL_CA_BUNDLE
             NODE_EXTRA_CA_CERTS LANG LC_ALL)

env_args=()
for name in "${FORWARD_ENV[@]}"; do
  if [ -n "${!name:-}" ]; then env_args+=("$name=${!name}"); fi
done

STOPPED_BY="（还没停）"

# 先取子进程再杀父进程，最后把落单的子进程收干净。杀父进程用的就是 kill -9。
kill_tree() {
  local pid="$1" kid
  local kids; kids="$(pgrep -P "$pid" 2>/dev/null || true)"
  kill -9 "$pid" 2>/dev/null || true
  for kid in $kids; do kill_tree "$kid"; done
}

dsh_session_log() {
  find "$DSH_HOME_DIR/sessions" -name 'session.jsonl' 2>/dev/null | head -1
}

# opencode 的会话都在一个 SQLite 库里（WAL 模式）。取最新的会话 id；库还没建时给空。
oc_session_id() {
  [ -f "$OC_DATA/opencode.db" ] || { echo ""; return; }
  python3 - "$OC_DATA/opencode.db" <<'PY' 2>/dev/null || echo ""
import sqlite3, sys
db = sqlite3.connect(sys.argv[1], timeout=5)
rows = db.execute("select id from session order by time_created desc").fetchall()
print(rows[0][0] if rows else "")
PY
}

# 与 run_opencode.sh 第 2 步相同：tag v<版本> 解析出的提交 = 钉住提交，二进制自报版本 = pin 处
# package.json 的版本，任一不等即退出。已装过（有戳）就只做检查。
ensure_opencode() {
  local pin version tag_commit stamp got
  pin="$(git -C "$OC_UP" rev-parse HEAD)"
  version="$(python3 -c 'import json,sys; print(json.load(open(sys.argv[1]))["version"])' \
             "$OC_UP/packages/opencode/package.json")"
  tag_commit="$(git -C "$OC_UP" rev-parse "v$version^{commit}" 2>/dev/null || true)"
  [ "$tag_commit" = "$pin" ] || die "tag v$version 不是钉住提交，随包二进制对不上 pin"
  stamp="$ROOT/.opencode-run/.installed-$pin"
  if [ ! -f "$stamp" ]; then
    rm -rf "$OC_BIN_ROOT"; mkdir -p "$OC_BIN_ROOT"
    ( cd "$OC_BIN_ROOT" && npm init -y >/dev/null \
        && npm install --no-audit --no-fund --loglevel=error "opencode-ai@$version" )
    : > "$stamp"
  fi
  got="$("$OC" --version)"
  [ "$got" = "$version" ] || die "二进制版本 $got 与 pin 的 $version 不同"
  printf 'opencode @ %s\n' "$pin"
  printf 'opencode --version : %s（= pin 处 packages/opencode/package.json 的 version）\n' "$got"
}

# 这一次跑到第几步了。mini 数它自己 traj 里的 api_calls，dsh 数会话日志里的
# step/end 事件，opencode 数它库里最新会话的 step-start 片段（每次模型调用开头写一条）。
# 三个数都取自各家自己写下的记录，不是 wrapper 另记的一套。
count_steps() {
  local f
  case "$REPO" in
    mini-swe-agent)
      [ -f "$TRAJ" ] || { echo 0; return; }
      python3 -c 'import json,sys
try: print(json.load(open(sys.argv[1]))["info"]["model_stats"]["api_calls"])
except Exception: print(0)' "$TRAJ" 2>/dev/null || echo 0
      ;;
    deepseek-harness)
      f="$(dsh_session_log)"
      [ -n "$f" ] || { echo 0; return; }
      awk 'BEGIN{n=0} /^\{"type":"step\/end"/{n++} END{print n}' "$f" 2>/dev/null || echo 0
      ;;
    opencode)
      [ -f "$OC_DATA/opencode.db" ] || { echo 0; return; }
      python3 - "$OC_DATA/opencode.db" <<'PY' 2>/dev/null || echo 0
import sqlite3, sys
db = sqlite3.connect(sys.argv[1], timeout=5)
sid = db.execute("select id from session order by time_created desc limit 1").fetchone()
if not sid:
    print(0)
else:
    print(db.execute("select count(*) from part where session_id=? and json_extract(data,'$.type')='step-start'", (sid[0],)).fetchone()[0])
PY
      ;;
  esac
}

# 墙钟与步数的兜底看门狗。杀的时候记下是被哪一条兜住的。
watchdog() {
  local pid="$1" start now elapsed steps
  start="$(date +%s)"
  while kill -0 "$pid" 2>/dev/null; do
    now="$(date +%s)"; elapsed=$(( now - start ))
    if [ "$elapsed" -ge "$WALL" ]; then
      STOPPED_BY="外部 wrapper：墙钟到 ${WALL} 秒"
      printf '\n[wrapper] 墙钟到 %s 秒，kill -9 进程 %s\n' "$WALL" "$pid"
      kill_tree "$pid"; return
    fi
    steps="$(count_steps)"
    if [ "${steps:-0}" -ge "$STEPS" ]; then
      STOPPED_BY="外部 wrapper：步数到 ${STEPS} 步"
      printf '\n[wrapper] 步数到 %s 步，kill -9 进程 %s\n' "$STEPS" "$pid"
      kill_tree "$pid"; return
    fi
    sleep 3
  done
}

lay_workspace() {
  rm -rf "$WORK"; mkdir -p "$WORK"
  find "$TASK_DIR" -maxdepth 1 -type f -exec cp {} "$WORK/" \;
  git -C "$WORK" init -q
  git -C "$WORK" add -A
  git -C "$WORK" -c user.name=probe -c user.email=probe@localhost commit -q -m "probe baseline"
  printf 'work dir    : %s\n' "$WORK"
  ls -1 "$WORK"
}

write_dsh_patch() {
  # 与 scripts/run_dsh.sh 的 default 变体完全相同的两段：模型路由与不压缩的 JSONL
  # 日志。探针不改组合，只换任务模板。
  cat > "$PATCH" <<YML
# 由 study/probes/wrapper.sh 为探针 $PROBE 生成，不要手改。

- id: llm-pi-ai
  config:
    providers:
      ${DSH_PROVIDER:-xai}:
        apiKeyEnv: $KEY_VAR

- id: agent-default-model
  config:
    provider: ${DSH_PROVIDER:-xai}
    model: ${DSH_MODEL:-grok-4.3}

- id: session-persistence-jsonl
  config:
    root: !!js dshHomePath('sessions')
    compression: none
YML
  if [ -n "${DSH_RESUME_SESSION:-}" ]; then
    cat >> "$PATCH" <<YML

# 续跑：agent-loop 自己的 resumeSessionId，指向被 kill -9 杀掉的那个会话。
- id: agent-loop
  config:
    agents:
      - id: probe-resume
        resumeSessionId: $DSH_RESUME_SESSION
YML
  fi
  printf '\n--- 这一次的 patch 覆盖层 ---\n'
  cat "$PATCH"
}

start_mini() {
  env -i \
    PATH="$VENV/bin:/usr/local/bin:/usr/bin:/bin" \
    HOME="$RUN_ROOT/fakehome" \
    COLUMNS=120 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH="$MINI_UP/src" \
    MSWEA_CONFIGURED=true \
    MSWEA_GLOBAL_CONFIG_DIR="$RUN_ROOT/mswea" \
    "$KEY_VAR=$KEY" \
    "${env_args[@]}" \
    "$VENV/bin/python" -m minisweagent.run.mini \
      -c mini.yaml \
      -c "agent.step_limit=$STEPS" \
      -c "environment.cwd=$WORK" \
      -c "environment.timeout=60" \
      -c "environment.env.$KEY_VAR=" \
      -m "${MSWEA_MODEL_NAME:-xai/grok-4.3}" \
      -l "${MINI_COST_LIMIT:-1.0}" \
      -y --exit-immediately \
      -o "$TRAJ" \
      -t "$(cat "$TASK_DIR/README.md")" \
      < /dev/null &
}

start_dsh() {
  # exec：子 shell 被 node 取代，所以 $! 就是 node 自己的 pid，kill -9 杀的是 harness
  # 进程本身，不是一层包在外面的 shell。
  ( cd "$WORK" && exec env -i \
      PATH="$(dirname "$(command -v node)"):/usr/local/bin:/usr/bin:/bin" \
      HOME="$RUN_ROOT/fakehome" \
      COLUMNS=120 \
      NODE_USE_ENV_PROXY=1 \
      DSH_HOME="$DSH_HOME_DIR" \
      DSH_TELEMETRY_DISABLED=1 \
      DSH_PERMISSION_MODE=danger-full-access \
      "$KEY_VAR=$KEY" \
      "${env_args[@]}" \
      node "$DSH_UP/apps/cli/lib/bin.js" \
        --profile headless \
        --patch "$PATCH" \
        "$(cat "$TASK_DIR/README.md")" \
      < /dev/null ) &
}

start_opencode() {
  # 同 dsh：exec 让 $! 就是 opencode 二进制自己的 pid。run 模式是它的非交互入口：吃一条消息，
  # 把回复打到 stdout 然后退出。--auto 放行权限请求（不加时 run 模式自动 reject）。
  # 续跑时加 --session <id>，消息仍是同一份任务文本。
  local resume=()
  if [ -n "${OC_RESUME_SESSION:-}" ]; then resume=(--session "$OC_RESUME_SESSION"); fi
  ( cd "$WORK" && exec env -i \
      PATH="/usr/local/bin:/usr/bin:/bin" \
      HOME="$OC_HOME_DIR" \
      COLUMNS=120 \
      OPENCODE_DISABLE_AUTOUPDATE=1 \
      "$KEY_VAR=$KEY" \
      "${env_args[@]}" \
      "$OC" run \
        --dir "$WORK" \
        --model "${OC_MODEL:-xai/grok-4.3}" \
        --auto \
        --title "probe $PROBE" \
        "${resume[@]}" \
        "$(cat "$TASK_DIR/README.md")" \
      < /dev/null ) &
}

# 把 opencode 的数据目录原样复制到产物目录，再用它自己的 export 把最新会话导成 JSON。
collect_opencode() {
  local dest="$OUT/${OC_DATA_DEST:-data}" sid
  rm -rf "$dest"
  if [ -d "$OC_DATA" ]; then cp -r "$OC_DATA" "$dest"; fi
  ( cd "$OUT" && find "${OC_DATA_DEST:-data}" -type f -printf '%8s  %p\n' 2>/dev/null | sort -k2 )
  sid="$(oc_session_id)"
  printf 'session id  : %s\n' "${sid:-（库里没有会话）}"
  [ -n "$sid" ] || return 0
  printf -- '--- 库里的计数（最新会话） ---\n'
  python3 - "$OC_DATA/opencode.db" "$sid" <<'PY'
import sqlite3, sys
db = sqlite3.connect(sys.argv[1], timeout=5); sid = sys.argv[2]
print("sessions    :", db.execute("select count(*) from session").fetchone()[0])
print("messages    :", db.execute("select count(*) from message where session_id=?", (sid,)).fetchone()[0])
print("parts       :", db.execute("select count(*) from part where session_id=?", (sid,)).fetchone()[0])
for t, n in db.execute("select json_extract(data,'$.type'), count(*) from part where session_id=? group by 1 order by 1", (sid,)):
    print(f"  part {t:<12}: {n}")
row = db.execute("select cost, tokens_input, tokens_output, tokens_reasoning from session where id=?", (sid,)).fetchone()
print(f"cost        : {row[0]}")
print(f"tokens      : input {row[1]}, output {row[2]}, reasoning {row[3]}")
PY
  local exp="$OUT/${OC_EXPORT_NAME:-session.export.json}"
  ( cd "$WORK" && env -i PATH="/usr/local/bin:/usr/bin:/bin" HOME="$OC_HOME_DIR" \
      OPENCODE_DISABLE_AUTOUPDATE=1 "${env_args[@]}" "$OC" export "$sid" > "$exp" < /dev/null ) \
    && printf '%8s  %s\n' "$(stat -c%s "$exp")" "${exp#$OUT/}" \
    || printf '（opencode export 失败）\n'
}

# 等一次工具执行真的开始：任务脚本自己在工作副本里放下 .probe-running 这个标记。
wait_for_tool_execution() {
  local pid="$1" waited=0
  while [ "$waited" -lt 180 ]; do
    if [ -f "$WORK/.probe-running" ]; then return 0; fi
    kill -0 "$pid" 2>/dev/null || return 1
    sleep 1; waited=$(( waited + 1 ))
  done
  return 1
}

collect_dsh_sessions() {
  local dest="$1"
  rm -rf "$dest"
  if [ -d "$DSH_HOME_DIR/sessions" ]; then cp -r "$DSH_HOME_DIR/sessions" "$dest"; fi
}

run() {
  printf '=== 探针复跑记录 ===\n'
  printf 'probe       : %s\n' "$PROBE"
  printf 'repo        : %s\n' "$REPO"
  printf 'date        : %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  printf 'api key     : 取自环境变量 %s（已设置，不入库）\n' "$KEY_VAR"
  printf 'wrapper 兜底: 墙钟 %s 秒 / 步数 %s 步\n' "$WALL" "$STEPS"

  printf '\n=== 1. pin ===\n'
  case "$REPO" in
    mini-swe-agent)
      printf 'mini-swe-agent @ %s\n' "$(git -C "$MINI_UP" rev-parse HEAD)"
      printf 'python      : %s\n' "$("$VENV/bin/python" -V 2>&1)" ;;
    deepseek-harness)
      printf 'deepseek-harness @ %s\n' "$(git -C "$DSH_UP" rev-parse HEAD)"
      printf 'dsh         : %s\n' "$(node "$DSH_UP/apps/cli/lib/bin.js" --version 2>&1)" ;;
    opencode)
      ensure_opencode ;;
  esac

  printf '\n=== 2. 铺工作副本 ===\n'
  mkdir -p "$RUN_ROOT/fakehome" "$RUN_ROOT/mswea"
  # 续跑时不重铺工作副本、不清会话目录：被 kill -9 打断的那一刻是什么样，就从那里接着跑。
  if [ -n "${PROBE_KEEP_STATE:-}" ]; then
    printf '（PROBE_KEEP_STATE：沿用上一次被 kill -9 打断时的工作副本与会话目录，不重铺）\n'
    printf 'work dir    : %s\n' "$WORK"
    ls -1 "$WORK"
  else
    lay_workspace
  fi
  printf '\n--- 跑之前的测试 ---\n'
  ( cd "$WORK" && python3 -m unittest -v 2>&1 | tail -6 ) || true

  if [ "$REPO" = deepseek-harness ]; then
    [ -n "${PROBE_KEEP_STATE:-}" ] || rm -rf "$DSH_HOME_DIR/sessions"
    printf '\n=== 3. patch ===\n'
    write_dsh_patch
  elif [ "$REPO" = opencode ]; then
    [ -n "${PROBE_KEEP_STATE:-}" ] || { rm -rf "$OC_HOME_DIR"; mkdir -p "$OC_HOME_DIR"; }
    printf '\n=== 3. opencode 的续跑入口 ===\n'
    printf -- '--- opencode run --help 里所有带 continue / session 的行 ---\n'
    ( env -i PATH="/usr/local/bin:/usr/bin:/bin" HOME="$OC_HOME_DIR" OPENCODE_DISABLE_AUTOUPDATE=1 \
        "$OC" run --help 2>&1 | grep -i 'continue\|session' ) || printf '（一行都没有）\n'
    if [ -n "${OC_RESUME_SESSION:-}" ]; then
      printf '本次续跑：--session %s\n' "$OC_RESUME_SESSION"
    fi
  else
    [ -n "${PROBE_KEEP_STATE:-}" ] || rm -f "$TRAJ"
    printf '\n=== 3. mini 的续跑入口 ===\n'
    printf -- '--- mini --help 里所有带 resume 的行 ---\n'
    ( env -i PATH="$VENV/bin:/usr/bin:/bin" PYTHONPATH="$MINI_UP/src" MSWEA_CONFIGURED=true \
        "$VENV/bin/python" -m minisweagent.run.mini --help 2>&1 | grep -i resume ) \
      || printf '（一行都没有）\n'
    printf -- '--- 上游源码里 resume / restore / continue_from 的出现次数 ---\n'
    printf '%s\n' "$(grep -rIo 'resume\|restore\|continue_from' "$MINI_UP/src/minisweagent" 2>/dev/null | wc -l)"
  fi

  printf '\n=== 4. 跑 %s ===\n' "$REPO"
  local PID
  case "$REPO" in
    mini-swe-agent) start_mini ;;
    deepseek-harness) start_dsh ;;
    opencode) start_opencode ;;
  esac
  PID=$!
  printf '[wrapper] harness pid = %s\n' "$PID"

  if [ "$PROBE" = kill ] && [ -z "${PROBE_NO_KILL:-}" ]; then
    if wait_for_tool_execution "$PID"; then
      printf '\n[wrapper] 看到 .probe-running，工具正在执行中；再等 4 秒让它跑进去\n'
      sleep 4
      printf '[wrapper] 杀之前 pid %s 的子进程：%s\n' "$PID" "$(pgrep -P "$PID" 2>/dev/null | tr '\n' ' ')"
      printf '[wrapper] kill -9 %s\n' "$PID"
      kill -9 "$PID" 2>/dev/null || true
      STOPPED_BY="外部 wrapper：kill -9（工具执行进行中）"
      sleep 2
      printf '[wrapper] 收落单的子进程\n'
      pkill -9 -f 'slow_check.sh' 2>/dev/null || true
      pkill -9 -f "$WORK" 2>/dev/null || true
    else
      printf '\n[wrapper] 一直没等到 .probe-running，没有杀成\n'
      STOPPED_BY="没杀成（没等到工具执行）"
    fi
  else
    watchdog "$PID"
  fi

  wait "$PID"; local rc=$?
  if [ "$STOPPED_BY" = "（还没停）" ]; then
    STOPPED_BY="harness 自己退出（退出码 $rc），wrapper 的两条兜底都没用上"
  fi
  printf '\n[wrapper] harness 退出码 %s\n' "$rc"
  printf '[wrapper] 停下它的是：%s\n' "$STOPPED_BY"

  printf '\n=== 5. 到第几步 ===\n'
  printf '各家自己的记录里数出来的步数：%s\n' "$(count_steps)"

  printf '\n=== 6. 工作副本被改成什么样 ===\n'
  git -C "$WORK" --no-pager diff
  printf '\n--- 未跟踪的新文件 ---\n'
  git -C "$WORK" status --porcelain --untracked-files=all | grep '^??' || printf '（没有）\n'
  printf '\n=== 7. 跑之后的测试 ===\n'
  ( cd "$WORK" && python3 -m unittest -v 2>&1 | tail -20 ) || true

  printf '\n=== 8. 记录文件 ===\n'
  if [ "$REPO" = deepseek-harness ]; then
    collect_dsh_sessions "$OUT/${DSH_SESSION_DEST:-sessions}"
    ( cd "$OUT" && find "${DSH_SESSION_DEST:-sessions}" -type f -printf '%8s  %p\n' 2>/dev/null | sort -k2 )
  elif [ "$REPO" = opencode ]; then
    collect_opencode
  else
    if [ -f "$TRAJ" ]; then
      printf '%8s  %s\n' "$(stat -c%s "$TRAJ")" "${TRAJ#$OUT/}"
    else
      printf '（没有 traj 文件）\n'
    fi
  fi

  printf '\n=== 9. 上游 checkout 是否被改动 ===\n'
  local up; case "$REPO" in mini-swe-agent) up="$MINI_UP" ;; deepseek-harness) up="$DSH_UP" ;; *) up="$OC_UP" ;; esac
  local dirty; dirty="$(git -C "$up" status --porcelain)"
  if [ -n "$dirty" ]; then printf '%s\n' "$dirty"; else printf 'clean\n'; fi
  return 0
}

TERM_FILE="$OUT/${PROBE_TERMINAL_NAME:-terminal.txt}"
run 2>&1 | tee "$TERM_FILE"
rc="${PIPESTATUS[0]}"

# 产物里不许出现 key 本身。不是承诺，是检查。
if grep -rqF -- "$KEY" "$OUT" 2>/dev/null; then
  die "$KEY_VAR 的值出现在 $OUT 里，已中止；请清掉再提交"
fi
printf '\nwrapper: %s / %s 完成，产物在 study/probes/%s/%s/，已确认不含 %s 的值\n' \
  "$PROBE" "$REPO" "$PROBE" "$REPO" "$KEY_VAR"
exit "$rc"
