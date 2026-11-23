include /lib/ix/help.mk
.PHONY: loader ports guide

loader: ## Find the ELF interpreter that starts IX programs
	@ls -l *musl*
ports: ## Read the shared rules behind a distro port
	@cat ix/borrow.mk
guide: ## Read the local IX guide
	@more ix/guide
