# harness-study
#
# `make check` is the one command: it verifies every anchor in the study
# artifacts against the commit its target repository is pinned to.

PYTHON ?= python3
VARIANT ?= default

.PHONY: help check check-v coverage coverage-v selftest sync status run run-dsh run-opencode

help:  ## show this help
	@grep -hE '^[a-z-]+:.*?##' $(MAKEFILE_LIST) | sort | \
	  awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

check:  ## verify every anchor in study/ and points/ against the pins
	@$(PYTHON) scripts/check_anchors.py

check-v:  ## same, listing every anchor found
	@$(PYTHON) scripts/check_anchors.py -v

coverage:  ## prove each census covers every file it should, exactly once
	@$(PYTHON) scripts/census_coverage.py

coverage-v:  ## same, breaking the scope down by kind and by why files were dropped
	@$(PYTHON) scripts/census_coverage.py -v

selftest:  ## prove the checker itself still detects each failure mode
	@scripts/selftest.sh

run:  ## run mini-swe-agent on the fixed task, writing study/mini-swe-agent/trace/
	@scripts/run_mini.sh

run-dsh:  ## run DeepSeek Harness on the same task (VARIANT=default|minimal)
	@scripts/run_dsh.sh $(VARIANT)

run-opencode:  ## run OpenCode on the same task, writing study/opencode/trace/
	@scripts/run_opencode.sh

sync:  ## materialise every pinned repository at its pinned commit
	@scripts/pin.sh sync

status:  ## show pinned vs. on-disk state of each target repository
	@scripts/pin.sh status
