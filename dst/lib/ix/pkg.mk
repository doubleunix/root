include /lib/ix/help.mk
.PHONY: ls sh

ls: ## List the chroots in /pkg and where they came from
	@for world in */.ix-seed; do \
	    if [ -r "$$world" ]; then printf '%s  %s\n' "$${world%/*}" "$$(cat "$$world")"; fi; \
	done
export WORLD
sh: ## Start a login sh in /pkg/WORLD. Use WORLD=name
	@ix-world run "$$WORLD" /bin/sh -l
