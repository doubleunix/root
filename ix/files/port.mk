.PHONY: fetch diff edit ask patch
export UPSTREAM FILE REQUEST PATCH
SOURCE := $(CURDIR)/source

fetch: ## Get the upstream source in ./source
	@ix-port fetch "$$UPSTREAM"
diff: ## See what you have changed
	@ix-kit git -C source diff
edit: ## Open a recipe or source file. Use FILE=source/path
	@ix-port edit "$${FILE:-Makefile}"
ask: ## Ask yhwh for a patch. Use FILE=source/path REQUEST='your question'
	@ix-port ask "$${FILE:-Makefile}" "$$REQUEST"
patch: ## Apply a reviewed diff to ./source. Use PATCH=/path/to/changes.diff
	@ix-port patch "$$PATCH"
