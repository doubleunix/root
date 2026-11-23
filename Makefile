.DEFAULT_GOAL := help
IX := src
SRC := $(CURDIR)/dst/root/src
DOC_DEST = $(DESTDIR)$(PREFIX)/share/doc/root
ifeq ($(PORT_INSTALL),1)
install: install-home
else
include dst/lib/ix/ports.mk
endif

IX_TARGETS := world update chroot boot iso container distro-nixos distro-arch distro-gentoo check

.PHONY: help install-home $(IX_TARGETS)
help:
	@printf '%s\n' 'make world | chroot | boot | iso | container' \
		'make update        refresh the shell and recipes in the existing world' \
		'make enterprise    fetch the four organizations into dst/root/src/' \
		'make list          list ports' 'make install PORT=organization/repository' \
		'make distro-nixos | distro-arch | distro-gentoo' 'make check'

$(IX_TARGETS):
	+$(MAKE) -C "$(IX)" $@

install-home:
	install -d "$(DOC_DEST)/src/doc" "$(DOC_DEST)/dst/src" "$(DESTDIR)$(PREFIX)/lib/ix"
	install -m 644 README.md dst/etc/genesis "$(DOC_DEST)/"
	install -m 644 src/doc/minimalism.md src/doc/context.md "$(DOC_DEST)/src/doc/"
	install -m 644 dst/src/guide.md "$(DOC_DEST)/dst/src/"
	install -m 644 dst/lib/ix/ports.mk "$(DESTDIR)$(PREFIX)/lib/ix/"
