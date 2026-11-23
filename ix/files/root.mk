include /lib/ix/help.mk
.PHONY: map small doors ports workshop english shell manual build-sheet list install enterprise

map: ## Take a walk. Each directory below has its own Makefile
	@printf '%s\n' '/bin   the tools at hand' '/etc   the rules of the house' \
	    '/lib   the loader and the small print' '/src   the ports, from vi to Electron' \
	    '/root  the console user’s home'

small: ## See exactly what ships in this world
	@ls -A /
	@du -sh /bin /etc /lib /src

doors: ## Find installed commands and other worlds
	@printf '%s\n' 'Bash, sh, Toybox, BusyBox, make and vi are here.'
	@if command -v yhwh >/dev/null; then printf '%s\n' 'yhwh, @ and nsh are open. Try make shell.'; \
	    else printf '%s\n' 'The English shell is a port. Try make english.'; fi
	@if [ -f /dst/Makefile ]; then $(MAKE) --no-print-directory -C /dst list; fi

ports: ## Visit the ports tree at /src
	+@$(MAKE) --no-print-directory -C /src
workshop: ## Add Git, HTTPS tools, and the manual reader
	+@$(MAKE) --no-print-directory -C /src tools
english: ## Install yhwh, @, nsh, LD, and their manuals
	+@$(MAKE) --no-print-directory -C /src english
shell: ## Enter the English shell after make english
	@command -v yhwh >/dev/null || { echo 'First: make -C / english'; exit 1; }
	@exec yhwh shell
manual: ## Read the local IX guide
	@more /lib/ix/guide
build-sheet: ## Read the actual rules for this directory
	@cat Makefile

list: ## List the enterprise source ports
	+@$(MAKE) --no-print-directory -C /src list
install: ## Install one source port. Use PORT=organization/repository
	+@$(MAKE) --no-print-directory -C /src install
enterprise: ## Fetch all enterprise sources
	+@$(MAKE) --no-print-directory -C /src enterprise
