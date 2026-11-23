# port: Alpine, Git, and the build toolchain
include /lib/ix/help.mk
WORLD := alpine
RELEASE := 3.23.8
ARCH := $(shell uname -m)
URL := https://dl-cdn.alpinelinux.org/alpine/v$(basename $(RELEASE))/releases/$(ARCH)/alpine-minirootfs-$(RELEASE)-$(ARCH).tar.gz
export WORLD ARCHIVE PACKAGES

.PHONY: install add visit
install: ## Fetch and plant the Alpine minirootfs in /pkg/alpine
	@ix-world seed "$$WORLD" "$(URL)" "$$ARCHIVE"

add: ## Install Alpine packages in its root. Use PACKAGES='git make'
	@test -n "$$PACKAGES" || { echo 'Use PACKAGES=package'; exit 2; }
	@set -f; /lib/ix/ix-kit install $$PACKAGES

visit: ## Enter the Alpine workshop
	@ix-world run "$$WORLD" /bin/sh -l
