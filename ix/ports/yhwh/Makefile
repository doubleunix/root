include /lib/ix/help.mk
WORLD := arch
UPSTREAM ?= https://github.com/hello-corporation/YHWH.git
include /lib/ix/port.mk

export WORLD DISPLAY
.PHONY: english deps build install run check
english: ## Meet the English commands that already live in /bin
	@yhwh --help

deps: ## Put Node, build tools, Electron libraries and Xvfb in Arch
	+@$(MAKE) --no-print-directory -C /src/pacman add \
	    PACKAGES='nodejs npm base-devel python gtk3 nss alsa-lib libxss libxtst mesa libglvnd xorg-server-xvfb xorg-xauth ttf-dejavu dbus'

build: deps fetch ## Build the Electron app using its upstream lockfile
	@ix-world source "$$WORLD" "$(SOURCE)" env npm_config_allow_remote=root make -C /ix-src build

install: build ## Install the Electron app in Arch and publish yhwh-el in IX
	@ix-world source "$$WORLD" "$(SOURCE)" bash -s -- --install < $(IX)/ix-desktop
	@ix-world run "$$WORLD" /bin/sh -ec 'id ix-desktop >/dev/null 2>&1 || useradd -m ix-desktop; install -d -o ix-desktop /home/ix-desktop/bin; mkdir -p /usr/local/bin'
	@ix-world run "$$WORLD" /bin/sh -c 'umask 022; cat > /usr/local/bin/yhwh-el && chmod 755 /usr/local/bin/yhwh-el' < $(IX)/ix-desktop
	@ix-world publish "$$WORLD" /usr/local/bin/yhwh-el yhwh-el

run: ## Open yhwh-el on the X11 display in DISPLAY
	@command -v yhwh-el >/dev/null || { echo 'First: make install'; exit 1; }
	@exec yhwh-el open

check: ## Check the installed launcher and open a window on a private Xvfb display
	@command -v yhwh-el >/dev/null || { echo 'First: make install'; exit 1; }
	@yhwh-el --help
	@yhwh-el --smoke
