include /lib/ix/help.mk
WORLD := gentoo
IMAGE ?= docker.io/gentoo/stage3:amd64-openrc
UPSTREAM ?= https://github.com/gentoo/portage.git
include /lib/ix/borrow.mk

PORTAGE := /opt/ix-portage

.PHONY: install sync add build install-source
install: ## Plant a Gentoo stage3 in /dst/gentoo
	@$(IX)/ix-world seed "$$WORLD" "$$IMAGE" "$$ARCHIVE"

sync: install ## Fetch the Gentoo ebuild tree when it is missing
	@$(WORLD_RUN) /bin/sh -ec 'test -d /var/db/repos/gentoo/profiles || emerge-webrsync'

add: sync ## Ask emerge for a package. Use PACKAGES=app-misc/hello
	@test -n "$$PACKAGES" || { echo 'Use PACKAGES=category/package'; exit 2; }
	@set -f; $(WORLD_RUN) emerge --oneshot --getbinpkg $$PACKAGES

build: sync fetch ## Compile your ./source Portage in its Gentoo world
	@$(WORLD_RUN) emerge --oneshot --getbinpkg dev-build/meson dev-build/ninja
	@$(WORLD_SOURCE) /bin/sh -ec 'meson setup --reconfigure /opt/ix-portage-build /ix-src --prefix=$(PORTAGE) -Dpython.purelibdir=$(PORTAGE)/python -Dpython.platlibdir=$(PORTAGE)/python && meson compile -C /opt/ix-portage-build'

install-source: build ## Install your Portage under /dst/gentoo/opt/ix-portage
	@$(WORLD_SOURCE) meson install -C /opt/ix-portage-build
	@printf '%s\n' '#!/bin/sh' 'export PYTHONPATH=$(PORTAGE)/python' 'exec $(PORTAGE)/bin/emerge "$$@"' | \
	    $(WORLD_RUN) /bin/sh -ec 'umask 022; cat > $(PORTAGE)/ix-emerge; chmod 755 $(PORTAGE)/ix-emerge'
	@$(WORLD_RUN) $(PORTAGE)/ix-emerge --version
