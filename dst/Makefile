.DEFAULT_GOAL := help
.PHONY: help sh ports
help:
	@printf '%s\n' 'make sh     enter sh' 'make ports  list optional packages'
sh:
	@exec /bin/sh
ports:
	+@$(MAKE) -C /src ls
