.DEFAULT_GOAL := help
ROOT ?=
OUT ?= $(abspath ../build)
ENGINE ?= docker
IMAGE ?= ix:local
ARCH ?= $(shell uname -m)
KERNEL ?= $(OUT)/vmlinuz-virt
QEMU ?= qemu-system-$(ARCH)
QEMU_FLAGS ?= -m 1024 -nographic -no-reboot
BOOT_MODULES ?= virtio_pci virtio_net e1000 af_packet
export ROOT OUT ENGINE IMAGE ARCH KERNEL BOOT_MODULES

.PHONY: help world update chroot boot iso container check distro-nixos distro-arch distro-gentoo
help:
	@printf '%s\n' 'make world       build the bare root' 'make chroot      walk in' \
	    'make boot        boot a serial console' 'make iso         make a BIOS live CD' \
	    'make container   import the root into Docker' 'make check       test a fresh world' \
	    'make update      refresh the shell and recipes in an existing world' \
	    'make distro-arch | distro-nixos | distro-gentoo    seed a world under /pkg'

world update iso container check:
	@bin/ix $@

chroot:
	@bin/ix chroot $(COMMAND)

boot:
	@bin/ix boot
	$(QEMU) $(QEMU_FLAGS) -kernel "$(KERNEL)" -initrd "$(OUT)/ix.cpio.gz" \
	    -append 'console=ttyS0,115200' -nic user,model=virtio-net-pci

distro-arch:
	@bin/ix chroot make -C /src/pacman install

distro-nixos:
	@bin/ix chroot make -C /src/nix install

distro-gentoo:
	@bin/ix chroot make -C /src/emerge install
