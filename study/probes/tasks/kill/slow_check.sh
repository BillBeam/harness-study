#!/usr/bin/env bash
# 采一次基线：把当前实现在几组输入上的输出记下来，慢慢跑。
# 探针的 wrapper 靠 .probe-running 这个标记文件知道"工具正在执行中"。
set -u
touch .probe-running
echo "slow_check: 开始采基线"
for i in $(seq 1 25); do
  python3 -c "from stats import moving_average as m; print('sample', $i, m(list(range($i + 3)), 2))" 2>&1
  sleep 1
done
echo "slow_check: 基线采完"
rm -f .probe-running
