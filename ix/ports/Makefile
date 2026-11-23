include /lib/ix/help.mk
.PHONY: catalog tools english manuals list fetch install enterprise seed visit
IX := /lib/ix

catalog: ## See the ports with their own workshops
	@printf '%s\n' 'cd pacman    Arch' 'cd nix       Nix store' \
	    'cd emerge    Gentoo' 'cd yhwh      YHWH and the Electron desktop' \
	    'In any workshop, type make or make <Tab>.'
tools: ## Add Git, SSH, curl, jq and mandoc to IX
	@$(IX)/ix-apk git openssh-client curl jq mandoc
english: ## Build the English command line from the enterprise ports
	+@$(MAKE) --no-print-directory -C yhwh english
manuals: tools ## Install the enterprise manual pages. Then try man @
	+@$(MAKE) --no-print-directory -f $(IX)/ports.mk install PORT=doubleunix/man

list: ## List the enterprise source ports
	+@$(MAKE) --no-print-directory -f $(IX)/ports.mk list
fetch: tools ## Fetch one enterprise source. Use PORT=organization/repository
	+@$(MAKE) --no-print-directory -f $(IX)/ports.mk fetch PORT="$(PORT)"
install: tools ## Install one enterprise port. Use PORT=organization/repository
	+@$(MAKE) --no-print-directory -f $(IX)/ports.mk install PORT="$(PORT)"
enterprise: tools ## Fetch every enterprise source below /src
	+@$(MAKE) --no-print-directory -f $(IX)/ports.mk enterprise

export WORLD IMAGE ARCHIVE
seed: ## Plant another OCI root. Use WORLD=name IMAGE=registry/repo:tag or ARCHIVE=/file.tar
	@$(IX)/ix-world seed "$$WORLD" "$$IMAGE" "$$ARCHIVE"
visit: ## Enter a world you planted. Use WORLD=name
	@$(IX)/ix-world run "$$WORLD" /bin/sh -l
