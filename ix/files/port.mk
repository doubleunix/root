.PHONY: fetch diff edit ask patch
export UPSTREAM FILE REQUEST PATCH
SOURCE := $(CURDIR)/source

fetch: ## Get the upstream source in ./source
	@/lib/ix/ix-port fetch "$$UPSTREAM"
diff: ## See what you have changed
	@/lib/ix/ix-kit git -C source diff
edit: ## Open a recipe or source file. Use FILE=source/path
	@/lib/ix/ix-port edit "$${FILE:-Makefile}"
ask: ## Ask yhwh for a patch. Use FILE=source/path REQUEST='your question'
	@/lib/ix/ix-port ask "$${FILE:-Makefile}" "$$REQUEST"
patch: ## Apply a reviewed diff to ./source. Use PATCH=/path/to/changes.diff
	@/lib/ix/ix-port patch "$$PATCH"
