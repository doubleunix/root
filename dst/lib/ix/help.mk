.DEFAULT_GOAL := help
.PHONY: help
help:
	@awk -f /lib/ix/targets.awk $(firstword $(MAKEFILE_LIST))
