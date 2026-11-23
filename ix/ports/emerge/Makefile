# port: Gentoo and Portage
include /lib/ix/help.mk
WORLD := gentoo
IMAGE ?= docker.io/gentoo/stage3:amd64-openrc
UPSTREAM ?= https://github.com/gentoo/portage.git
include /lib/ix/borrow.mk

PORTAGE := /opt/ix-portage

.PHONY: install sync add build install-source
install: ## Plant a Gentoo stage3 in /pkg/gentoo
	@ix-world seed "$$WORLD" "$$IMAGE" "$$ARCHIVE"

sync: install ## Fetch the Gentoo ebuild tree when it is missing
	@$(WORLD_RUN) /bin/sh -ec 'test -d /var/db/repos/gentoo/profiles || emerge-webrsync'

add: sync ## Ask emerge for a package. Use PACKAGES=app-misc/hello
	@test -n "$$PACKAGES" || { echo 'Use PACKAGES=category/package'; exit 2; }
	@set -f; $(WORLD_RUN) emerge --oneshot --getbinpkg $$PACKAGES

build: sync fetch ## Compile your ./source Portage in its Gentoo world
	@$(WORLD_RUN) emerge --oneshot --getbinpkg dev-build/meson dev-build/ninja
	@$(WORLD_SOURCE) /bin/sh -ec 'meson setup --reconfigure /opt/ix-portage-build /ix-src --prefix=$(PORTAGE) -Dpython.purelibdir=$(PORTAGE)/python -Dpython.platlibdir=$(PORTAGE)/python && meson compile -C /opt/ix-portage-build'

install-source: build ## Install your Portage under /pkg/gentoo/opt/ix-portage
	@$(WORLD_SOURCE) meson install -C /opt/ix-portage-build
	@printf '%s\n' '#!/bin/sh' 'export PYTHONPATH=$(PORTAGE)/python' 'exec $(PORTAGE)/bin/emerge "$$@"' | \
	    $(WORLD_RUN) /bin/sh -ec 'umask 022; cat > $(PORTAGE)/ix-emerge; chmod 755 $(PORTAGE)/ix-emerge'
	@$(WORLD_RUN) $(PORTAGE)/ix-emerge --version

.PHONY: overlay stage
overlay: sync ## Open a local ebuild tree at /pkg/gentoo/var/db/repos/ix
	@$(WORLD_RUN) /bin/sh -ec 'mkdir -p /var/db/repos/ix/profiles /var/db/repos/ix/metadata /etc/portage/repos.conf; printf "%s\n" ix > /var/db/repos/ix/profiles/repo_name; printf "%s\n" "masters = gentoo" > /var/db/repos/ix/metadata/layout.conf; printf "%s\n" "[ix]" "location = /var/db/repos/ix" "masters = gentoo" "auto-sync = no" > /etc/portage/repos.conf/ix.conf'
export CHECKOUT
stage: sync ## Build one package image. Use PACKAGES=cat/pkg NAME=pkg [CHECKOUT=/src/project]
	@case "$$NAME" in ''|.*|*[!a-zA-Z0-9._+-]*) echo 'Use NAME=image'; exit 2;; esac; test -n "$$PACKAGES" || { echo 'Use PACKAGES=category/package'; exit 2; }; \
	    if [ -n "$$CHECKOUT" ]; then set -- source "$$WORLD" "$$CHECKOUT"; else set -- run "$$WORLD"; fi; \
	    set -f; ix-world "$$@" /bin/sh -ec 'image=$$1; shift; emerge --onlydeps --oneshot --getbinpkg "$$@"; exec emerge --root="$$image" --oneshot --nodeps --usepkg=n --getbinpkg=n "$$@"' ix "/opt/ix-packages/$$NAME" $$PACKAGES
