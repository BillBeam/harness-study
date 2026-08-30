#!/usr/bin/env bash
# 用钉住的 DeepSeek Harness 跑一个固定的小任务，把它自己记录的会话日志与终端全文留在
# study/deepseek-harness/trace/<变体>/ 下。
#
# 用法：
#   scripts/run_dsh.sh default     （等同于 make run-dsh）
#   scripts/run_dsh.sh minimal     （等同于 make run-dsh VARIANT=minimal）
#
# 两个变体的任务、模型、工作副本、环境完全一致，只差模型这一侧看见的组合：
#   default —— dsh 随包的 headless 组合，一字未改（只补模型路由与日志格式）。
#   minimal —— 在同一个 headless 组合上换成 dsh 随包的「极简模式」preset 的组合。
# 为什么不是直接选 preset，见 study/deepseek-harness/run.md。
#
# 环境变量：
#   DSH_API_KEY_VAR   放 API key 的变量名，默认 XAI_API_KEY。key 只从环境读，不写进仓库。
#   DSH_PROVIDER      pi-ai 供应商路由名，默认 xai。
#   DSH_MODEL         模型 id，默认 grok-4.3。
#   DSH_RUN_DIR       工作副本与本地 DSH_HOME 的根，默认 <仓库>/.dsh-run。
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
UPSTREAM="$ROOT/repos/deepseek-harness"
TASK_DIR="$ROOT/study/mini-swe-agent/task"
PRESET_DIR="$UPSTREAM/packages/preset/agent-presets/presets"
WEB_PATCH="$UPSTREAM/packages/bundle/web-app/cordis.patch.yml"
SNAPSHOT="$UPSTREAM/snapshots/web/minimal-preset"

die() { printf 'run_dsh: %s\n' "$*" >&2; exit 1; }

VARIANT="${1:-default}"
case "$VARIANT" in
  default|minimal) ;;
  *) die "变体只能是 default 或 minimal，收到 $VARIANT" ;;
esac

KEY_VAR="${DSH_API_KEY_VAR:-XAI_API_KEY}"
PROVIDER="${DSH_PROVIDER:-xai}"
MODEL="${DSH_MODEL:-grok-4.3}"
RUN_ROOT="${DSH_RUN_DIR:-$ROOT/.dsh-run}"

TRACE="$ROOT/study/deepseek-harness/trace/$VARIANT"
WORK="$RUN_ROOT/$VARIANT/workspace"
DSH_HOME_DIR="$RUN_ROOT/$VARIANT/home"
PATCH="$RUN_ROOT/$VARIANT/run.patch.yml"

[ -d "$TASK_DIR" ] || die "找不到 $TASK_DIR"
KEY="${!KEY_VAR:-}"
[ -n "$KEY" ] || die "环境变量 $KEY_VAR 没设。key 只走环境变量，不写进仓库。"

# 只有这些变量名会被带进 dsh 的进程。dsh 的 bash 工具在这个进程的子进程里跑命令，
# 容器里其余的凭据不该有机会出现在终端全文或会话日志里，所以用 env -i 从空环境重建，
# 白名单之外一律不带。跑完还会逐个文件确认 key 本身没有落进产物。
FORWARD_ENV=(HTTP_PROXY HTTPS_PROXY NO_PROXY http_proxy https_proxy no_proxy
             SSL_CERT_FILE SSL_CERT_DIR REQUESTS_CA_BUNDLE CURL_CA_BUNDLE
             NODE_EXTRA_CA_CERTS LANG LC_ALL)

# 这一次的 patch 覆盖层。default 只有前两段；minimal 再加三段，全部从上游自己的文件
# 现读现拼，不手抄：关闭清单取自 web-app 的 patch，工具行取自 minimal preset 的组合。
write_patch() {
  cat <<YML
# 由 scripts/run_dsh.sh 按变体 $VARIANT 生成，不要手改。

# 一、模型路由：走 dsh 随包的 llm-pi-ai 适配器，key 只给变量名，请求时才解析。
- id: llm-pi-ai
  config:
    providers:
      $PROVIDER:
        apiKeyEnv: $KEY_VAR

- id: agent-default-model
  config:
    provider: $PROVIDER
    model: $MODEL

# 二、留档用的日志格式：随包默认是 zstd（session.jsonl.zstd），这里换成不压缩的
# JSONL 文本，内容与默认完全相同，只是物理编码不同。
- id: session-persistence-jsonl
  config:
    root: !!js dshHomePath('sessions')
    compression: none
YML
  [ "$VARIANT" = minimal ] || return 0
  cat <<'YML'

# 三、系统提示：极简模式的 persona 行是 scope-only 的（挂在全局会与提示词注册表
# 自己的注册冲突并 fail loud），所以把它那句话放进 deployment persona 槽，并按该
# preset 的 complete/includeRuntimeContext 关掉固定身份与运行期上下文快照。
# 跑完第 10 步会拿上游自己的 snapshot 逐字节复核这一段的效果。
- id: system-prompt
  config:
    includeHarnessIdentity: false
    includeRuntimeContext: false
    persona: You are a helpful software engineer assistant.
YML
  printf '\n# 四、关闭清单，逐行取自 %s：\n' "${WEB_PATCH#$UPSTREAM/}"
  printf '# preset 拥有这些工具时，host 面上的同名行必须让位。\n'
  awk '/^- id: /{id=$3} /^  disabled: true$/{print "- id: " id; print "  disabled: true"}' "$WEB_PATCH"
  printf '\n# 五、工具行，取自 %s，只去掉上面提到的 persona 行。\n' \
    "${PRESET_DIR#$UPSTREAM/}/minimal/agent.cordis.yml"
  printf -- '- insert:\n'
  awk '
    /^- id: persona$/ { skip = 1; next }
    /^- id: / { skip = 0 }
    !skip { print "    " $0 }
  ' "$PRESET_DIR/minimal/agent.cordis.yml"
}

# 拿上游自己的 snapshot 复核这一次模型看见的东西：系统提示逐字节相同，工具名集合相同。
check_against_snapshot() {
  local log="$1"
  python3 - "$log" "$SNAPSHOT" <<'PY'
import json, pathlib, sys
log, snap = pathlib.Path(sys.argv[1]), pathlib.Path(sys.argv[2])
header = None
for line in log.read_text().splitlines():
    event = json.loads(line)
    if event.get("type") == "request/header":
        header = event["data"]["header"]
        break
if header is None:
    print("没有 request/header，无法复核"); raise SystemExit(1)
want_prompt = (snap / "system-prompt.expected.md").read_text().strip()
got_prompt = (header.get("system") or "").strip()
print("系统提示与上游 snapshot：", "逐字节相同" if got_prompt == want_prompt else "不同")
if got_prompt != want_prompt:
    print("  期望:", repr(want_prompt)); print("  实得:", repr(got_prompt))
want_tools = sorted(t["name"] for t in json.loads((snap / "tool-schemas.expected.json").read_text())["initial"])
got_tools = sorted(t["name"] for t in header.get("tools") or [])
print("工具名集合与上游 snapshot：", "相同" if got_tools == want_tools else "不同")
print("  期望:", want_tools); print("  实得:", got_tools)
raise SystemExit(0 if (got_prompt == want_prompt and got_tools == want_tools) else 1)
PY
}

# 把这一次模型看见的工具名列出来，进终端全文备查。
list_tools() {
  python3 - "$1" <<'PY'
import json, pathlib, sys
for line in pathlib.Path(sys.argv[1]).read_text().splitlines():
    event = json.loads(line)
    if event.get("type") == "request/header":
        tools = event["data"]["header"].get("tools") or []
        print("模型看见的工具：", ", ".join(sorted(t["name"] for t in tools)) or "（没有）")
        print("系统提示：")
        for row in (event["data"]["header"].get("system") or "").splitlines():
            print("  " + row)
        break
PY
}

run() {
  printf '=== 复跑记录 ===\n'
  printf 'command     : scripts/run_dsh.sh %s\n' "$VARIANT"
  printf 'date        : %s\n' "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
  printf 'variant     : %s\n' "$VARIANT"
  printf 'provider    : %s（dsh 的 llm-pi-ai 路由）\n' "$PROVIDER"
  printf 'model       : %s\n' "$MODEL"
  printf 'api key     : 取自环境变量 %s（已设置，不入库）\n' "$KEY_VAR"
  printf 'telemetry   : DSH_TELEMETRY_DISABLED=1（关闭上报）\n'

  # 1) 把钉住的仓库落到 repos/ 下的钉住提交上。已经在位时这一步只是确认。
  printf '\n=== 1. 同步 pin ===\n'
  "$ROOT/scripts/pin.sh" sync deepseek-harness
  local PIN; PIN="$(git -C "$UPSTREAM" rev-parse HEAD)"
  printf 'deepseek-harness @ %s\n' "$PIN"

  # 2) 按 pin 处的 lockfile 装依赖并构建。产物是 node_modules/ 与各包的 lib/，
  #    两者都在上游自己的 .gitignore 里，所以 checkout 保持干净（第 8 步复核）。
  printf '\n=== 2. 准备依赖与构建 ===\n'
  local stamp="$RUN_ROOT/.built-$PIN"
  if [ ! -f "$stamp" ]; then
    ( cd "$UPSTREAM" && COREPACK_ENABLE_DOWNLOAD_PROMPT=0 corepack pnpm install --frozen-lockfile )
    ( cd "$UPSTREAM" && COREPACK_ENABLE_DOWNLOAD_PROMPT=0 corepack pnpm run build )
    : > "$stamp"
  fi
  printf 'node        : %s\n' "$(node -v)"
  printf 'pnpm        : %s\n' "$(COREPACK_ENABLE_DOWNLOAD_PROMPT=0 corepack pnpm -v)"
  printf 'dsh         : %s\n' "$(node "$UPSTREAM/apps/cli/lib/bin.js" --version)"

  # 3) 写这一次的 patch 覆盖层。
  printf '\n=== 3. patch 覆盖层 ===\n'
  mkdir -p "$(dirname "$PATCH")"
  write_patch > "$PATCH"
  printf 'patch       : %s（%s 行）\n' "${PATCH#$ROOT/}" "$(grep -c '' "$PATCH")"
  cat "$PATCH"

  # 4) 把三文件的小仓库复制成一份干净的工作副本。模板保持有 bug 的原样，可以反复跑。
  printf '\n=== 4. 铺工作副本 ===\n'
  rm -rf "$WORK"; mkdir -p "$WORK"
  find "$TASK_DIR" -maxdepth 1 -type f -exec cp {} "$WORK/" \;
  git -C "$WORK" init -q
  git -C "$WORK" add -A
  git -C "$WORK" -c user.name=run_dsh -c user.email=run_dsh@localhost commit -q -m "buggy baseline"
  printf 'work dir    : %s\n' "$WORK"
  ls -1 "$WORK"
  printf '\n--- 改之前的测试 ---\n'
  ( cd "$WORK" && python3 -m unittest -v 2>&1 | tail -5 ) || true

  # 5) 跑 dsh。headless 是它唯一的一次性无人值守入口：吃一条任务文本，把最终回答
  #    打到 stdout 然后退出。DSH_PERMISSION_MODE=danger-full-access 起作用的是文件沙箱
  #    这一半：沙箱不再限制文件改动，于是整轮跑下来一条审批都不会发起。它顺带把审批策略
  #    设成 never，而 never 不是自动放行，是不问任何人、一律判 rejected；留默认的
  #    workspace-write 会把策略留在 ask，而 headless 组合里没有能答复的人。
  printf '\n=== 5. 跑 dsh --profile headless ===\n'
  local env_args=() name
  for name in "${FORWARD_ENV[@]}"; do
    if [ -n "${!name:-}" ]; then env_args+=("$name=${!name}"); fi
  done
  ( cd "$WORK" && env -i \
      PATH="$(dirname "$(command -v node)"):/usr/local/bin:/usr/bin:/bin" \
      HOME="$RUN_ROOT/$VARIANT/fakehome" \
      COLUMNS=120 \
      NODE_USE_ENV_PROXY=1 \
      DSH_HOME="$DSH_HOME_DIR" \
      DSH_TELEMETRY_DISABLED=1 \
      DSH_PERMISSION_MODE=danger-full-access \
      "$KEY_VAR=$KEY" \
      "${env_args[@]}" \
      node "$UPSTREAM/apps/cli/lib/bin.js" \
        --profile headless \
        --patch "$PATCH" \
        "$(cat "$TASK_DIR/README.md")" \
      < /dev/null )

  # 6) 结果：agent 到底改了什么，测试是不是真的绿了。
  printf '\n=== 6. agent 改了什么 ===\n'
  git -C "$WORK" --no-pager diff
  printf '\n=== 7. 改之后的测试 ===\n'
  ( cd "$WORK" && python3 -m unittest -v 2>&1 )

  # 7) 上游 checkout 必须一字未改：这个仓库只读目标仓库。
  printf '\n=== 8. 上游 checkout 是否被改动 ===\n'
  local dirty; dirty="$(git -C "$UPSTREAM" status --porcelain)"
  if [ -n "$dirty" ]; then printf '%s\n' "$dirty"; die "上游 checkout 被改动了"; fi
  printf 'clean（node_modules/ 与各包 lib/ 在上游自己的 .gitignore 里）\n'

  # 8) 把这一次的会话目录整个搬进 trace/。dsh 按
  #    <root>/--<归一化 cwd>--/<会话 id>/ 组织，一次运行一个会话目录。
  printf '\n=== 9. 会话日志 ===\n'
  printf 'session root: %s\n' "$DSH_HOME_DIR/sessions"
  find "$DSH_HOME_DIR/sessions" -mindepth 1 -maxdepth 2 | sed "s#$DSH_HOME_DIR/sessions#<sessions>#" | sort
  rm -rf "$TRACE/sessions"; mkdir -p "$TRACE"
  cp -r "$DSH_HOME_DIR/sessions" "$TRACE/sessions"
  printf '\n--- 落进 study/deepseek-harness/trace/%s/ 的文件 ---\n' "$VARIANT"
  ( cd "$TRACE" && find sessions -type f -printf '%8s  %p\n' | sort -k2 )

  local LOG; LOG="$(find "$TRACE/sessions" -name 'session.jsonl' | head -1)"
  [ -n "$LOG" ] || die "trace 里没有 session.jsonl"

  printf '\n=== 10. 这一次模型看见的组合 ===\n'
  list_tools "$LOG"
  if [ "$VARIANT" = minimal ]; then
    printf '\n--- 与上游 snapshots/web/minimal-preset 的复核 ---\n'
    check_against_snapshot "$LOG"
  fi
}

mkdir -p "$TRACE" "$RUN_ROOT/$VARIANT/fakehome" "$DSH_HOME_DIR"
rm -rf "$DSH_HOME_DIR/sessions"

set +e
run 2>&1 | tee "$TRACE/terminal.txt"
rc="${PIPESTATUS[0]}"
set -e

# 产物里不许出现 key 本身。这是「密钥只走环境变量」的可执行版本：不是承诺，是检查。
if grep -rqF -- "$KEY" "$TRACE" 2>/dev/null; then
  die "$KEY_VAR 的值出现在 $TRACE 里，已中止；请清掉再提交"
fi
printf '\nrun_dsh: %s 完成（退出码 %s），产物在 %s，已确认不含 %s 的值\n' \
  "$VARIANT" "$rc" "study/deepseek-harness/trace/$VARIANT" "$KEY_VAR"
exit "$rc"
