include /lib/ix/help.mk
WORLD := arch
IMAGE ?= docker.io/library/archlinux:base
UPSTREAM ?= https://gitlab.archlinux.org/pacman/pacman.git
include /lib/ix/borrow.mk

.PHONY: install add build install-source
install: ## Plant the Arch bootstrap in /dst/arch
	@$(IX)/ix-world seed "$$WORLD" "$$IMAGE" "$$ARCHIVE"

add: install ## Let pacman install packages here. Use PACKAGES='tree file'
	@test -n "$$PACKAGES" || { echo 'Use PACKAGES=package'; exit 2; }
	@set -f; $(WORLD_RUN) pacman -Syu --noconfirm --needed -- $$PACKAGES

build: install fetch ## Compile your ./source checkout on Arch
	@$(WORLD_RUN) pacman -Syu --noconfirm --needed base-devel meson cmake libarchive curl openssl gpgme libseccomp
	@$(WORLD_SOURCE) /bin/sh -ec 'meson setup --reconfigure /opt/ix-pacman-build /ix-src --prefix=/opt/ix-pacman --sysconfdir=/opt/ix-pacman/etc --localstatedir=/opt/ix-pacman/var --libdir=lib -Dc_link_args=-Wl,-rpath,/opt/ix-pacman/lib -Ddoc=disabled && meson compile -C /opt/ix-pacman-build'

install-source: build ## Install your pacman under /dst/arch/opt/ix-pacman
	@$(WORLD_SOURCE) meson install -C /opt/ix-pacman-build
	@$(WORLD_RUN) /opt/ix-pacman/bin/pacman --version
	@echo 'Try make run RUN="/opt/ix-pacman/bin/pacman --config /etc/pacman.conf --dbpath /var/lib/pacman -Q"'
