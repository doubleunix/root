IX_SRC := $(dir $(lastword $(MAKEFILE_LIST)))
include $(IX_SRC)../dst/lib/ix/help.mk

IX_TARGETS := world update chroot boot iso import check arch nix gentoo
.PHONY: $(IX_TARGETS)
$(IX_TARGETS): export ROOT ?=
$(IX_TARGETS): export OUT ?= $(abspath $(IX_SRC)build)
$(IX_TARGETS): export DST ?= $(abspath $(IX_SRC)../dst)
$(IX_TARGETS): export ENGINE ?= docker
$(IX_TARGETS): export IMAGE ?= ix:local
$(IX_TARGETS): export ARCH ?= $(shell uname -m)
$(IX_TARGETS): export KERNEL ?= $(OUT)/vmlinuz-virt
$(IX_TARGETS): export BOOT_MODULES ?= virtio_pci virtio_net e1000 af_packet
QEMU ?= qemu-system-$(ARCH)
QEMU_FLAGS ?= -m 1024 -nographic -no-reboot

world: ## Build /mnt/sinai or the root at ROOT=/path
update: ## Refresh the shell and static files in an existing root
iso: ## Build a BIOS live CD
import: ## Import the root as a Docker image
check: ## Test a fresh root

world update iso import check:
	@$(IX_SRC)bin/ix $@

chroot: ## Enter the chroot. Use COMMAND='cmd args' to run a command
	@$(IX_SRC)bin/ix chroot $(COMMAND)

boot: ## Boot a serial console in QEMU
	@$(IX_SRC)bin/ix boot
	cd "$(IX_SRC)" && $(QEMU) $(QEMU_FLAGS) -kernel "$(KERNEL)" -initrd "$(OUT)/ix.cpio.gz" \
	    -append 'console=ttyS0,115200' -nic user,model=virtio-net-pci

arch: ## Bootstrap /pkg/arch in the chroot
	@$(IX_SRC)bin/ix chroot make -C /src/pacman bootstrap

nix: ## Bootstrap /pkg/nix in the chroot
	@$(IX_SRC)bin/ix chroot make -C /src/nix bootstrap

gentoo: ## Bootstrap /pkg/gentoo in the chroot
	@$(IX_SRC)bin/ix chroot make -C /src/emerge bootstrap
