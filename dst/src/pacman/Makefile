# port: Arch and pacman
include /lib/ix/help.mk
WORLD := arch
IMAGE ?= docker.io/library/archlinux:base
UPSTREAM ?= https://gitlab.archlinux.org/pacman/pacman.git
include /lib/ix/borrow.mk

.PHONY: bootstrap add build install
bootstrap: ## Unpack the Arch image into /pkg/arch
	@ix-world seed "$$WORLD" "$$IMAGE" "$$ARCHIVE"

add: bootstrap ## Install packages with pacman. Use PACKAGES='tree file'
	@test -n "$$PACKAGES" || { echo 'Use PACKAGES=package'; exit 2; }
	@set -f; $(WORLD_RUN) pacman -Syu --noconfirm --needed -- $$PACKAGES

build: bootstrap fetch ## Build ./source in /pkg/arch
	@$(WORLD_RUN) pacman -Syu --noconfirm --needed base-devel meson cmake libarchive curl openssl gpgme libseccomp
	@$(WORLD_SOURCE) /bin/sh -ec 'meson setup --reconfigure /opt/ix-pacman-build /ix-src --prefix=/opt/ix-pacman --sysconfdir=/opt/ix-pacman/etc --localstatedir=/opt/ix-pacman/var --libdir=lib -Dc_link_args=-Wl,-rpath,/opt/ix-pacman/lib -Ddoc=disabled && meson compile -C /opt/ix-pacman-build'

install: build ## Install the local build under /pkg/arch/opt/ix-pacman
	@$(WORLD_SOURCE) meson install -C /opt/ix-pacman-build
	@$(WORLD_RUN) /opt/ix-pacman/bin/pacman --version
	@echo 'Try make run RUN="/opt/ix-pacman/bin/pacman --config /etc/pacman.conf --dbpath /var/lib/pacman -Q"'
