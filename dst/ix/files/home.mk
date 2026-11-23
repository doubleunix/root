include /lib/ix/help.mk
.PHONY: map ports journal enterprise

map: ## See the streets and doors from /
	+@$(MAKE) --no-print-directory -C / map
ports: ## Browse the things you can build
	+@$(MAKE) --no-print-directory -C /src
journal: ## Open your notebook in vi
	@exec "$${EDITOR:-vi}" "$$HOME/journal"
enterprise: ## Fetch the enterprise sources
	+@$(MAKE) --no-print-directory -C /src enterprise
