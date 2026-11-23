.DEFAULT_GOAL := help
TARGETS_AWK := $(dir $(lastword $(MAKEFILE_LIST)))targets.awk
.PHONY: help
help:
	@awk -f "$(TARGETS_AWK)" $(MAKEFILE_LIST)
