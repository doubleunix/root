# port: Nix and its store
include /lib/ix/help.mk
WORLD := nix
IMAGE ?= docker.io/nixos/nix:latest
UPSTREAM ?= https://github.com/NixOS/nix.git
include /lib/ix/borrow.mk

NIX = nix --extra-experimental-features 'nix-command flakes'
.PHONY: bootstrap add build install
bootstrap: ## Unpack the Nix image into /pkg/nix
	@ix-world seed "$$WORLD" "$$IMAGE" "$$ARCHIVE"

add: bootstrap ## Install packages in the IX profile. Use PACKAGES='nixpkgs#hello'
	@test -n "$$PACKAGES" || { echo 'Use PACKAGES=nixpkgs#hello'; exit 2; }
	@set -f; $(WORLD_RUN) $(NIX) profile install --profile /nix/var/nix/profiles/ix $$PACKAGES

build: bootstrap fetch ## Build ./source in /pkg/nix
	@$(WORLD_SOURCE) $(NIX) build --no-link path:/ix-src

install: build ## Link the local build at /pkg/nix/opt/ix-nix
	@$(WORLD_RUN) mkdir -p /opt
	@$(WORLD_SOURCE) $(NIX) build --out-link /opt/ix-nix path:/ix-src
	@$(WORLD_RUN) /opt/ix-nix/bin/nix --version
