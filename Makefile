.DEFAULT_GOAL := help
IX_PORT := doubleunix/ix
IX := $(CURDIR)/src/$(IX_PORT)
SRC := $(CURDIR)/src
include ports.mk

IX_TARGETS := world chroot boot iso container distro-nixos distro-arch distro-gentoo check

.PHONY: help $(IX_TARGETS)
help:
	@printf '%s\n' 'make world | chroot | boot | iso | container' \
		'make enterprise    clone the four organizations into src/' \
		'make list          list ports' 'make install PORT=organization/repository' \
		'make distro-nixos | distro-arch | distro-gentoo' 'make check'

$(IX_TARGETS): $(IX_PORT)
	+$(MAKE) -C "$(IX)" HOME_TREE="$(CURDIR)" $@
