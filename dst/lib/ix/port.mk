.PHONY: fetch diff vi ask patch
export UPSTREAM FILE REQUEST PATCH
SOURCE := $(CURDIR)/source

fetch: ## Clone upstream into ./source
	@/lib/ix/ix-port fetch "$$UPSTREAM"
diff: ## Show the working-tree diff in ./source
	@/lib/ix/ix-kit git -C source diff
vi: ## Edit Makefile or FILE=source/path with $EDITOR or vi
	@/lib/ix/ix-port edit "$${FILE:-Makefile}"
ask: ## Ask yhwh for a patch. Use FILE=source/path REQUEST='your question'
	@/lib/ix/ix-port ask "$${FILE:-Makefile}" "$$REQUEST"
patch: ## Apply a reviewed diff to ./source. Use PATCH=/path/to/changes.diff
	@/lib/ix/ix-port patch "$$PATCH"
