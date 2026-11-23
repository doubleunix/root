include /lib/ix/help.mk
.PHONY: list toys pocket shell talk

list: ## See what you can run
	@ls
toys: ## Empty the toybox onto the floor
	@./toybox
pocket: ## See what is in BusyBox
	@./busybox --list
shell: ## Start a new sh
	@exec ./sh
talk: ## See what the words do
	@./yhwh --help
