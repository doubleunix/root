.DEFAULT_GOAL := help
-include /lib/ix/help.mk
UPSTREAM := https://landley.net/toybox/downloads/toybox-0.8.15.tar.gz
SHA256 := 44e2bab43dfe2c171743297631ce558c6d9ed38b87a66fd751cef617574b375e
.PHONY: fetch read config build install compile

fetch: ## Get the source used to build /bin/toybox
	@set -eu; if [ -f source/Makefile ]; then exit 0; fi; \
	    test ! -e source && test ! -L source || { echo 'Move the existing source aside first' >&2; exit 1; }; \
	    stage=$$(mktemp -d .toybox.XXXXXXXX); trap 'rm -rf "$$stage"' EXIT; \
	    curl -fLSs --retry 3 "$(UPSTREAM)" -o "$$stage/source.tar.gz"; \
	    printf '%s  %s\n' "$(SHA256)" "$$stage/source.tar.gz" | sha256sum -c; \
	    mkdir "$$stage/source"; tar -xzf "$$stage/source.tar.gz" -C "$$stage/source" --strip-components=1; \
	    mv -T "$$stage/source" source || test -f source/Makefile

read: fetch ## Start with Landley’s README
	@more source/README
config: ## See which toys to build
	@exec "$${EDITOR:-vi}" config
build: fetch ## Build the source at this bench with an optional Alpine toolchain
	@ix-kit install bash build-base linux-headers
	@ix-world source alpine "$(CURDIR)" make -C /ix-src -j"$$(nproc)" compile
install: build ## Try the new Toybox, then put it in /bin
	@ix-kit toybox "$(CURDIR)/source/toybox"

# The base build and the on-demand workshop use the same source and config.
compile: fetch
	cd source && KCONFIG_ALLCONFIG="$(CURDIR)/config" scripts/genconfig.sh -d
	+$(MAKE) -C source CFLAGS=-U_FORTIFY_SOURCE
