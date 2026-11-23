include /lib/ix/help.mk
.PHONY: ls du sh nsh man genesis install

ls: ## List the main directories and what they hold
	@printf '%s\n' '/bin   commands' '/etc   configuration' '/lib   loaders and libraries' '/src   ports (make -C /src ls)' '/usr   installed software' '/root  root’s home directory'
du: ## Show disk usage of the base directories
	@du -sh /bin /etc /lib /src /usr
sh: ## Start a sh
	@exec /bin/sh
nsh: ## Start nsh
	@exec nsh
man: ## Read the Sinai guide
	@more /src/guide
genesis: ## Read /etc/genesis
	@cat /etc/genesis
install: ## Install a Git port. Use PORT=organization/repository
	+@$(MAKE) --no-print-directory -C /src install
