#!/usr/bin/env bash
# 用钉住的 mini-swe-agent 跑一个固定的小任务，把它自己记录的会话文件和终端全文留在
# study/mini-swe-agent/trace/ 下。
#
# 用法：
#   scripts/run_mini.sh          （等同于 make run）
#
# 环境变量：
#   MINI_API_KEY_VAR   放 API key 的变量名，默认 XAI_API_KEY。key 只从环境读，不写进仓库。
#   MSWEA_MODEL_NAME   模型名，默认 xai/grok-4.3（mini-swe-agent 自己就认这个变量）。
#   MINI_COST_LIMIT    花费上限（美元），默认 1.0。
#   MINI_STEP_LIMIT    步数上限，默认 40。
#   MINI_WORK_DIR      工作副本的位置，默认 mktemp -d 出来的临时目录。
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM="$ROOT/repos/mini-swe-agent"
TASK_DIR="$ROOT/study/mini-swe-agent/task"
TRACE="$ROOT/study/mini-swe-agent/trace"
VENV="$ROOT/.venv"

KEY_VAR="${MINI_API_KEY_VAR:-XAI_API_KEY}"
MODEL="${MSWEA_MODEL_NAME:-xai/grok-4.3}"
COST_LIMIT="${MINI_COST_LIMIT:-1.0}"
STEP_LIMIT="${MINI_STEP_LIMIT:-40}"

# 只有这些变量名会被带进 agent 的进程。agent 在自己的 shell 里执行命令，容器里其余的
# 凭据不该有机会出现在终端全文或会话文件里，所以用 env -i 从空环境重建，白名单之外一律不带。
FORWARD_ENV=(HTTP_PROXY HTTPS_PROXY NO_PROXY http_proxy https_proxy no_proxy
             SSL_CERT_FILE SSL_CERT_DIR REQUESTS_CA_BUNDLE CURL_CA_BUNDLE
             LANG LC_ALL)

die() { printf 'run_mini: %s\n' "$*" >&2; exit 1; }

run() {
  printf '=== 复跑记录 ===\n'
  printf 'date        : %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  printf 'model       : %s\n' "$MODEL"
  printf 'api key     : 取自环境变量 %s（已设置，不入库）\n' "$KEY_VAR"
  printf 'cost limit  : $%s\n' "$COST_LIMIT"
  printf 'step limit  : %s\n' "$STEP_LIMIT"

  # 1) 把钉住的仓库落到 repos/ 下的钉住提交上。已经在位时这一步只是确认。
  printf '\n=== 1. 同步 pin ===\n'
  "$ROOT/scripts/pin.sh" sync mini-swe-agent
  local PIN; PIN="$(git -C "$UPSTREAM" rev-parse HEAD)"
  printf 'mini-swe-agent @ %s\n' "$PIN"

  # 2) 装 pin 处 pyproject 声明的依赖。不装 mini-swe-agent 本身：用 PYTHONPATH 直接从
  #    源码跑，这样 repos/ 下的检出不会被 .egg-info、__pycache__ 之类的产物弄脏
  #    （下面 PYTHONDONTWRITEBYTECODE=1 管住 .pyc）。
  printf '\n=== 2. 准备 venv ===\n'
  local stamp="$VENV/.deps-$PIN"
  if [ ! -f "$stamp" ]; then
    [ -d "$VENV" ] || python3 -m venv "$VENV"
    "$VENV/bin/python" -m pip install -q --upgrade pip
    "$VENV/bin/python" - "$UPSTREAM/pyproject.toml" <<'PY' > "$VENV/.deps.txt"
import sys, tomllib, pathlib
print("\n".join(tomllib.loads(pathlib.Path(sys.argv[1]).read_text())["project"]["dependencies"]))
PY
    "$VENV/bin/python" -m pip install -q -r "$VENV/.deps.txt"
    : > "$stamp"
  fi
  printf 'python      : %s\n' "$("$VENV/bin/python" -V)"
  "$VENV/bin/python" - <<'PY'
from importlib.metadata import version
print("litellm     : " + version("litellm"))
PY

  # 3) 把三文件的小仓库复制成一份干净的工作副本。模板保持有 bug 的原样，可以反复跑。
  printf '\n=== 3. 铺工作副本 ===\n'
  mkdir -p "$WORK"
  find "$TASK_DIR" -maxdepth 1 -type f -exec cp {} "$WORK/" \;
  git -C "$WORK" init -q
  git -C "$WORK" add -A
  git -C "$WORK" -c user.name=run_mini -c user.email=run_mini@localhost commit -q -m "buggy baseline"
  printf 'work dir    : %s\n' "$WORK"
  ls -1 "$WORK"
  printf '\n--- 改之前的测试 ---\n'
  (cd "$WORK" && "$VENV/bin/python" -m unittest -v 2>&1 | tail -5) || true

  # 4) 跑 agent。-y 免确认、--exit-immediately 免退出确认，全程无人值守。
  #    environment.env.<KEY> 置空：agent 的 shell 里连这一个 key 也读不到。
  printf '\n=== 4. 跑 mini-swe-agent ===\n'
  local env_args=() name
  for name in "${FORWARD_ENV[@]}"; do
    if [ -n "${!name:-}" ]; then env_args+=("$name=${!name}"); fi
  done
  env -i \
    PATH="$VENV/bin:/usr/local/bin:/usr/bin:/bin" \
    HOME="$SANDBOX/home" \
    COLUMNS=120 \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH="$UPSTREAM/src" \
    MSWEA_CONFIGURED=true \
    MSWEA_GLOBAL_CONFIG_DIR="$SANDBOX/mswea" \
    "$KEY_VAR=$KEY" \
    "${env_args[@]}" \
    "$VENV/bin/python" -m minisweagent.run.mini \
      -c mini.yaml \
      -c "agent.step_limit=$STEP_LIMIT" \
      -c "environment.cwd=$WORK" \
      -c "environment.timeout=60" \
      -c "environment.env.$KEY_VAR=" \
      -m "$MODEL" \
      -l "$COST_LIMIT" \
      -y --exit-immediately \
      -o "$TRACE/mini.traj.json" \
      -t "$(cat "$TASK_DIR/README.md")" \
      < /dev/null

  # 5) 结果：agent 到底改了什么，测试是不是真的绿了。
  printf '\n=== 5. agent 改了什么 ===\n'
  git -C "$WORK" --no-pager diff
  printf '\n=== 6. 改之后的测试 ===\n'
  (cd "$WORK" && "$VENV/bin/python" -m unittest -v 2>&1)
}

[ -d "$TASK_DIR" ] || die "找不到 $TASK_DIR"
KEY="${!KEY_VAR:-}"
[ -n "$KEY" ] || die "环境变量 $KEY_VAR 没设。key 只走环境变量，不写进仓库。"

SANDBOX="$(mktemp -d)"
trap 'rm -rf "$SANDBOX"' EXIT
mkdir -p "$SANDBOX/home" "$SANDBOX/mswea"
WORK="${MINI_WORK_DIR:-$SANDBOX/moving-average}"
mkdir -p "$TRACE"

run 2>&1 | tee "$TRACE/terminal.txt"
exit "${PIPESTATUS[0]}"
