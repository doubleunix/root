include /lib/ix/help.mk
.PHONY: map small ports workshop english shell manual genesis list install enterprise

map: ## Walk around
	@printf '%s\n' '/bin   what you can say' '/etc   the few things written down' '/lib   what the programs load' '/src   the workshops' '/usr   names you have chosen' '/root  your notebook'
small: ## Count the beginning
	@du -sh /bin /etc /lib /src /usr
ports: ## Open the workshops
	+@$(MAKE) --no-print-directory -C /src catalog
workshop: ## Add Git in the private Alpine workshop
	+@$(MAKE) --no-print-directory -C /src tools
english: ## Meet the words that came with the world
	@yhwh --help
shell: ## Talk to the shell
	@exec nsh
manual: ## Read the way around
	@more /lib/ix/guide
genesis: ## Read what the world was made for
	@cat /etc/genesis
list: ## List the enterprise source ports
	+@$(MAKE) --no-print-directory -C /src list
install: ## Install source in your prefix. Use PORT=organization/repository
	+@$(MAKE) --no-print-directory -C /src install
enterprise: ## Fetch the enterprise source ports
	+@$(MAKE) --no-print-directory -C /src enterprise
