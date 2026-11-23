include /lib/ix/port.mk
.PHONY: visit run publish link

export WORLD FILE NAME TO ARCHIVE IMAGE PACKAGES RUN
WORLD_RUN = $(IX)/ix-world run "$$WORLD"
WORLD_SOURCE = $(IX)/ix-world source "$$WORLD" "$(SOURCE)"

visit: ## Walk into this distro’s shell
	@$(WORLD_RUN) /bin/sh -l
run: ## Run a command here. Use RUN='command and arguments'
	@test -n "$$RUN" || { echo "Use RUN='command and arguments'"; exit 2; }
	@$(WORLD_RUN) /bin/sh -c "$$RUN"
publish: ## Make a chroot launcher in IX. Use NAME=command FILE=/usr/bin/command
	@$(IX)/ix-world publish "$$WORLD" "$$FILE" "$$NAME"
link: ## Link a data file or portable static executable. Use FILE=/path TO=share/name
	@$(IX)/ix-world link "$$WORLD" "$$FILE" "$$TO"
