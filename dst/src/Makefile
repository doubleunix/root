include /lib/ix/help.mk
.PHONY: ls git install-man ls-ports fetch install fetch-all bootstrap
IX := /lib/ix
GIT ?= $(IX)/ix-kit git
PORTS = $(MAKE) --no-print-directory -f $(IX)/ports.mk GIT='$(GIT)'

ls: ## List the port directories and what you can build in them
	@awk '/^# port: / {sub(/^# port: /, ""); split(FILENAME, path, "/"); printf "cd %-8s %s\n", path[1], $$0}' */Makefile
git: ## Install Git in Alpine and put it on PATH
	@$(IX)/ix-kit tools
install-man: ## Install the doubleunix man pages in PREFIX
	+@$(PORTS) install PORT=doubleunix/man
ls-ports: ## List the Git ports by repository name
	+@$(PORTS) ls
fetch: ## Clone one Git port. Use PORT=organization/repository
	+@$(PORTS) fetch PORT="$(PORT)"
install: ## Install one Git port in PREFIX. Use PORT=organization/repository
	+@$(PORTS) install PORT="$(PORT)"
fetch-all: ## Clone all Git ports
	+@$(PORTS) fetch-all

export WORLD IMAGE ARCHIVE
bootstrap: ## Create /pkg/WORLD from IMAGE=repo:tag or ARCHIVE=/file.tar
	@ix-world seed "$$WORLD" "$$IMAGE" "$$ARCHIVE"
