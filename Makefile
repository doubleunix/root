include src/Makefile

PORTS_SOURCE ?= $(CURDIR)/dst/root/src
PORTS_CACHE ?= $(abspath src/build/ports)
PREFIX ?= /usr/local
export PORTS_SOURCE PORTS_CACHE PREFIX DESTDIR GIT_ROOT

.PHONY: install develop uninstall clean
install develop uninstall clean:
	+@$(IX_SRC)bin/core "$@"
