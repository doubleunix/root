GIT_ROOT ?= https://github.com
SRC ?= $(if $(and $(filter 0,$(shell id -u)),$(wildcard /etc/ix)),/src,$(HOME)/src)
PREFIX ?= $(if $(filter 0,$(shell id -u)),/usr/local,$(HOME)/.local)
GIT ?= git

PORTS := doubleunix/root doubleunix/ix doubleunix/man doubleunix/yhwh \
         thedynamiclinker/gen thedynamiclinker/gen2 thedynamiclinker/LD \
         thedynamiclinker/lord thedynamiclinker/nsh hello-corporation/YHWH \
         we-the-nameless/sudocode we-the-nameless/we-the-nameless

.PHONY: enterprise list install $(PORTS)
enterprise: $(PORTS)

list:
	@printf '%s\n' $(PORTS)

$(PORTS):
	@set -e; dst="$(SRC)/$@"; \
		if [ -d "$$dst/.git" ] || [ -f "$$dst/.git" ]; then exit 0; fi; \
		if [ -e "$$dst" ] || [ -L "$$dst" ]; then printf 'source path exists: %s\n' "$$dst" >&2; exit 1; fi; \
		mkdir -p "$(SRC)/$(dir $@)"; $(GIT) clone --depth 1 -- "$(GIT_ROOT)/$@" "$$dst"

.PHONY: fetch
VALID_PORT := $(and $(filter 1,$(words $(PORT))),$(filter $(PORTS),$(PORT)))
ifneq ($(VALID_PORT),)
fetch: $(PORT)

install: fetch
	+$(MAKE) -C "$(SRC)/$(PORT)" install PORT_INSTALL=1 PREFIX="$(PREFIX)" DESTDIR="$(DESTDIR)"
else
fetch install:
	@printf 'usage: make $@ PORT=organization/repository (see make list)\n' >&2; exit 2
endif
