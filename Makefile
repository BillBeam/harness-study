# harness-study
#
# `make check` is the one command: it verifies every anchor in the study
# artifacts against the commit its target repository is pinned to.

PYTHON ?= python3

.PHONY: help check check-v selftest sync status

help:  ## show this help
	@grep -hE '^[a-z-]+:.*?##' $(MAKEFILE_LIST) | sort | \
	  awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2}'

check:  ## verify every anchor in study/ and points/ against the pins
	@$(PYTHON) scripts/check_anchors.py

check-v:  ## same, listing every anchor found
	@$(PYTHON) scripts/check_anchors.py -v

selftest:  ## prove the checker itself still detects each failure mode
	@scripts/selftest.sh

sync:  ## materialise every pinned repository at its pinned commit
	@scripts/pin.sh sync

status:  ## show pinned vs. on-disk state of each target repository
	@scripts/pin.sh status
