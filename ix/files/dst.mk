include /lib/ix/help.mk
.PHONY: list visit

list: ## List the separate roots under /dst
	@for world in */.ix-seed; do \
	    if [ -r "$$world" ]; then printf '%s  %s\n' "$${world%/*}" "$$(cat "$$world")"; fi; \
	done
export WORLD
visit: ## Enter a world. Use WORLD=name
	@/lib/ix/ix-world run "$$WORLD" /bin/sh -l
