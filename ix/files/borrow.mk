include /lib/ix/port.mk
.PHONY: visit run publish link export

export WORLD FILE NAME TO ARCHIVE IMAGE PACKAGES RUN PREFIX KIND REPLACE
WORLD_RUN = ix-world run "$$WORLD"
WORLD_SOURCE = ix-world source "$$WORLD" "$(SOURCE)"

visit: ## Walk into this distro’s shell
	@$(WORLD_RUN) /bin/sh -l
run: ## Run a command here. Use RUN='command and arguments'
	@test -n "$$RUN" || { echo "Use RUN='command and arguments'"; exit 2; }
	@$(WORLD_RUN) /bin/sh -c "$$RUN"
publish: ## Give an executable a name. Use FILE=/usr/bin/x NAME=x [PREFIX=/usr]
	@ix-world publish "$$WORLD" "$$FILE" "$$NAME" "$${PREFIX:-/usr}" "$$REPLACE"
link: ## Make a literal link. Use FILE=/path TO=/usr/bin/x KIND=hard
	@ix-world link "$$WORLD" "$$FILE" "$$TO" "$${KIND:-soft}" "$$REPLACE"
export: ## Link a staged prefix. Use FILE=/opt/image/usr PREFIX=/usr KIND=hard
	@ix-world export "$$WORLD" "$$FILE" "$${PREFIX:-/usr}" "$${KIND:-hard}" "$$REPLACE"
