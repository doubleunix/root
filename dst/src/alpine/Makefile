# port: Alpine, Git, and the build toolchain
include /lib/ix/help.mk
WORLD := alpine
RELEASE := 3.23.8
ARCH := $(shell uname -m)
URL := https://dl-cdn.alpinelinux.org/alpine/v$(basename $(RELEASE))/releases/$(ARCH)/alpine-minirootfs-$(RELEASE)-$(ARCH).tar.gz
export WORLD ARCHIVE PACKAGES

.PHONY: bootstrap add sh
bootstrap: ## Unpack the Alpine minirootfs into /pkg/alpine
	@ix-world seed "$$WORLD" "$(URL)" "$$ARCHIVE"

add: ## Install packages with apk add. Use PACKAGES='git make'
	@test -n "$$PACKAGES" || { echo 'Use PACKAGES=package'; exit 2; }
	@set -f; /lib/ix/ix-kit install $$PACKAGES

sh: ## Start a login sh in /pkg/alpine
	@ix-world run "$$WORLD" /bin/sh -l
