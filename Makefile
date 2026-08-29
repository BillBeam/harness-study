# 定位地图的同步与校验。所有目标都不写目标仓库，只读。

PIN := study/mini-swe-agent/pin.json
MAP := study/mini-swe-agent/map.md
PIN_GET = python3 -c "import json,sys;print(json.load(open('$(PIN)'))[sys.argv[1]])"

REPO := $(shell $(PIN_GET) repo)
COMMIT := $(shell $(PIN_GET) commit)
CHECKOUT := $(shell $(PIN_GET) checkout_dir)

.PHONY: all sync check selftest clean help

all: check selftest

help:
	@echo "make sync      拉取钉住提交的目标仓库副本到 $(CHECKOUT)（只读使用）"
	@echo "make check     校验 $(MAP) 里每条锚点是否对得上钉住提交"
	@echo "make selftest  自检校验脚本本身能否发现锚点漂移"
	@echo "make clean     删除本地副本"

# 拉到钉住提交；已存在则就地切过去，可重复执行。
sync:
	@if [ ! -d "$(CHECKOUT)/.git" ]; then \
		echo "克隆 $(REPO) -> $(CHECKOUT)"; \
		mkdir -p "$(dir $(CHECKOUT))"; \
		git clone --filter=blob:none --no-checkout --quiet "$(REPO)" "$(CHECKOUT)"; \
	fi
	@git -C "$(CHECKOUT)" cat-file -e "$(COMMIT)^{commit}" 2>/dev/null || git -C "$(CHECKOUT)" fetch --quiet origin
	@git -C "$(CHECKOUT)" checkout --quiet --detach "$(COMMIT)"
	@echo "已同步到钉住提交 $$(git -C "$(CHECKOUT)" rev-parse HEAD)"

check:
	@python3 tools/check_map.py

selftest:
	@python3 tools/test_check_map.py

clean:
	@rm -rf "$(CHECKOUT)"
	@echo "已删除 $(CHECKOUT)"
