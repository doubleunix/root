include /lib/ix/help.mk
.PHONY: catalog tools english manuals list fetch install enterprise seed visit
IX := /lib/ix
GIT ?= ix-kit git
PORTS = $(MAKE) --no-print-directory -f $(IX)/ports.mk GIT='$(GIT)'

catalog: ## Pick a workbench
	@printf '%s\n' 'cd toybox    build the tools in /bin' 'cd pacman    Arch' 'cd emerge    Gentoo' 'cd nix       Nix' 'cd yhwh      the optional desktop'
tools: ## Add Git to your toolbox
	@ix-kit tools
english: ## See what the English commands can do
	@yhwh --help
manuals: ## Install the enterprise manual pages in your prefix
	+@$(PORTS) install PORT=doubleunix/man
list: ## List the enterprise source ports
	+@$(PORTS) list
fetch: ## Fetch one enterprise source. Use PORT=organization/repository
	+@$(PORTS) fetch PORT="$(PORT)"
install: ## Install one port in your prefix. Use PORT=organization/repository
	+@$(PORTS) install PORT="$(PORT)"
enterprise: ## Fetch every enterprise source below /src
	+@$(PORTS) enterprise

export WORLD IMAGE ARCHIVE
seed: ## Plant another root. Use WORLD=name and IMAGE=repo:tag or ARCHIVE=/file.tar
	@ix-world seed "$$WORLD" "$$IMAGE" "$$ARCHIVE"
visit: ## Enter a world you planted. Use WORLD=name
	@ix-world run "$$WORLD" /bin/sh -l
