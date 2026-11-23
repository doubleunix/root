include /lib/ix/help.mk
.PHONY: loader ports guide

loader: ## Find the first thing every native binary sees
	@ls -l *musl*
ports: ## Read the common recipes
	@cat ix/borrow.mk
guide: ## Read a walk through Sinai
	@more /src/guide
