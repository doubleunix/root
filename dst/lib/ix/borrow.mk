include /lib/ix/port.mk
.PHONY: sh run ln-bin ln ln-tree

export WORLD FILE NAME TO ARCHIVE IMAGE PACKAGES RUN PREFIX KIND REPLACE
WORLD_RUN = ix-world run "$$WORLD"
WORLD_SOURCE = ix-world source "$$WORLD" "$(SOURCE)"

sh: ## Start a login sh in this distro’s chroot
	@$(WORLD_RUN) /bin/sh -l
run: ## Run a command in this chroot. Use RUN='cmd args'
	@test -n "$$RUN" || { echo "Use RUN='command and arguments'"; exit 2; }
	@$(WORLD_RUN) /bin/sh -c "$$RUN"
ln-bin: ## Link a launcher into PREFIX/bin. Use FILE=/usr/bin/x NAME=x [PREFIX=/usr]
	@ix-world publish "$$WORLD" "$$FILE" "$$NAME" "$${PREFIX:-/usr}" "$$REPLACE"
ln: ## Link a file from this chroot. Use FILE=/path TO=/usr/bin/x [KIND=hard]
	@ix-world link "$$WORLD" "$$FILE" "$$TO" "$${KIND:-soft}" "$$REPLACE"
ln-tree: ## Link the files in a prefix. Use FILE=/opt/image/usr [PREFIX=/usr KIND=hard]
	@ix-world export "$$WORLD" "$$FILE" "$${PREFIX:-/usr}" "$${KIND:-hard}" "$$REPLACE"
