include /lib/ix/help.mk
.PHONY: list toys pocket shell

list: ## List the programs in /bin
	@ls
toys: ## Ask Toybox which commands it can be
	@./toybox
pocket: ## Ask BusyBox which commands it can be
	@./busybox --list
shell: ## Step into a plain shell
	@exec ./sh
