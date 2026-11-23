.DEFAULT_GOAL := help
IX_PORT := doubleunix/ix
IX := $(CURDIR)/src/$(IX_PORT)
SRC := $(CURDIR)/src
ifeq ($(PORT_INSTALL),1)
install: install-home
else
include ports.mk
endif

IX_TARGETS := world chroot boot iso container distro-nixos distro-arch distro-gentoo check

.PHONY: help install-home $(IX_TARGETS)
help:
	@printf '%s\n' 'make world | chroot | boot | iso | container' \
		'make enterprise    clone the four organizations into src/' \
		'make list          list ports' 'make install PORT=organization/repository' \
		'make distro-nixos | distro-arch | distro-gentoo' 'make check'

$(IX_TARGETS): $(IX_PORT)
	+$(MAKE) -C "$(IX)" HOME_TREE="$(CURDIR)" $@

install-home:
	install -d "$(DESTDIR)$(PREFIX)/share/doc/root" "$(DESTDIR)$(PREFIX)/lib/ix"
	install -m 644 README.md .face "$(DESTDIR)$(PREFIX)/share/doc/root/"
	install -m 644 ports.mk "$(DESTDIR)$(PREFIX)/lib/ix/ports.mk"
