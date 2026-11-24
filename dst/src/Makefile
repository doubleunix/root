.DEFAULT_GOAL := help
PREFIX ?= $(if $(filter 0,$(shell id -u)),/usr/local,$(HOME)/.local)
PORTS_SOURCE ?= /src/work
PORTS_CACHE ?= $(PORTS_SOURCE)
export PREFIX PORTS_SOURCE PORTS_CACHE GIT_ROOT PORT
PORT ?=

.PHONY: help ls list ls-ports fetch install develop uninstall clean
help:
	@printf '%s\n' 'make ls' 'make fetch | install | develop | uninstall | clean PORT=name' \
	    'Use PORT=organization/repository[=URL] for an unlisted Git port.' \
	    'On a fresh root, run make tools from the AT checkout to add Git and optional recipes.'
ls list ls-ports:
	@awk 'NF == 2 && $$1 !~ /^#/ {printf "%-12s %s\n", $$1, $$2}' ports.list
	@for dir in */Makefile; do test ! -f "$$dir" || printf '%s\n' "$${dir%/Makefile}"; done

fetch install develop uninstall clean:
	+@package=$$(awk -v port="$$PORT" '$$1 == port && $$1 !~ /^#/ {print $$2; exit}' ports.list); \
	    exec port "$@" "$${package:-$$PORT}"
