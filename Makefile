.DEFAULT_GOAL := help
IX := dst/ix
SRC := $(CURDIR)/dst/root/src
DOC_DEST = $(DESTDIR)$(PREFIX)/share/doc/root
ifeq ($(PORT_INSTALL),1)
install: install-home
else
include $(IX)/files/ports.mk
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
	install -d "$(DOC_DEST)/dst/doc" "$(DESTDIR)$(PREFIX)/lib/ix"
	install -m 644 README.md "$(IX)/files/genesis" "$(DOC_DEST)/"
	install -m 644 dst/doc/sinai.md dst/doc/minimalism.md dst/doc/context.md "$(DOC_DEST)/dst/doc/"
	install -m 644 "$(IX)/files/ports.mk" "$(DESTDIR)$(PREFIX)/lib/ix/"
