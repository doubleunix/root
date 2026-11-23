include src/Makefile

SRC := $(CURDIR)/dst/root/src
DOC_DEST = $(DESTDIR)$(PREFIX)/share/doc/root
ifeq ($(PORT_INSTALL),1)
.PHONY: install
install:
	install -d "$(DOC_DEST)/src/doc" "$(DOC_DEST)/dst/src" "$(DESTDIR)$(PREFIX)/lib/ix"
	install -m 644 README.md dst/etc/genesis "$(DOC_DEST)/"
	install -m 644 src/doc/minimalism.md src/doc/context.md "$(DOC_DEST)/src/doc/"
	install -m 644 dst/src/guide.md "$(DOC_DEST)/dst/src/"
	install -m 644 dst/lib/ix/ports.mk "$(DESTDIR)$(PREFIX)/lib/ix/"
else
include dst/lib/ix/ports.mk
endif
