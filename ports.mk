GIT_ROOT ?= https://github.com
SRC ?= $(HOME)/src
PREFIX ?= $(if $(filter 0,$(shell id -u)),/,$(HOME))

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
		mkdir -p "$(SRC)/$(dir $@)"; git clone --depth 1 -- "$(GIT_ROOT)/$@" "$$dst"

VALID_PORT := $(and $(filter 1,$(words $(PORT))),$(filter $(PORTS),$(PORT)))
ifneq ($(VALID_PORT),)
install: $(PORT)
	+$(MAKE) -C "$(SRC)/$(PORT)" install PORT_INSTALL=1 PREFIX="$(PREFIX)" DESTDIR="$(DESTDIR)"
else
install:
	@printf 'usage: make install PORT=organization/repository (see make list)\n' >&2; exit 2
endif
