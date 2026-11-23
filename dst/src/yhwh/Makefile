# port: YHWH's Electron desktop
include /lib/ix/help.mk
WORLD := arch
UPSTREAM ?= https://github.com/hello-corporation/YHWH.git
include /lib/ix/port.mk

export WORLD DISPLAY
.PHONY: english deps build install runtime run check
english: ## Meet the English commands that already live in /bin
	@yhwh --help

deps: ## Put Node, build tools, Electron libraries and Xvfb in Arch
	+@$(MAKE) --no-print-directory -C /src/pacman add \
	    PACKAGES='nodejs npm base-devel python patchelf gtk3 nss alsa-lib libxss libxtst mesa libglvnd xorg-server-xvfb xorg-xauth ttf-dejavu dbus'

build: deps fetch ## Build the Electron app using its upstream lockfile
	@ix-world source "$$WORLD" "$(SOURCE)" env npm_config_allow_remote=root make -C /ix-src build

install: build ## Install YHWH El for use from Sinai
	@ix-world source "$$WORLD" "$(SOURCE)" bash -s -- --install < desktop

runtime: ## Adapt an existing El installation without rebuilding it
	+@$(MAKE) --no-print-directory -C /src/pacman add PACKAGES=patchelf
	@ix-world run "$$WORLD" bash -s -- --runtime < desktop

run: ## Open El here on the X11 display in DISPLAY
	@exec yhwh el

check: ## Open El on a private Xvfb display
	@sh check
