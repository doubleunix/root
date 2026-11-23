include /lib/ix/help.mk
.PHONY: read config build install

read: ## Start with Landley’s README
	@more source/README
config: ## See which toys to build
	@exec "$${EDITOR:-vi}" config
build: ## Build the source at this bench with an optional Alpine toolchain
	@ix-kit install bash build-base linux-headers
	@ix-world source alpine "$(CURDIR)" /bin/sh -ec 'cp /ix-src/config /ix-src/source/.config; make -C /ix-src/source -j"$$(nproc)" CFLAGS=-U_FORTIFY_SOURCE'
install: build ## Try the new Toybox, then put it in /bin
	@ix-kit toybox "$(CURDIR)/source/toybox"
