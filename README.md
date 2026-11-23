# @

<img src=".face" alt="The face of the Root Enterprise" width="240">

Sinai is a small, bootable IX root. Musl, Toybox, BusyBox, Bash, and GNU Make
give you a console and a ports tree. Start at `/`, type **make**, and follow
the recipes into `/bin`, `/etc`, `/lib`, and `/src`. Try **make <Tab>** as
you walk.

~~~sh
make world                  # create /mnt/sinai
make chroot                 # enter it
make check                  # exercise a new root in a temporary directory
make boot                   # start QEMU on a serial console
make iso                    # build a BIOS live CD in build/
make container              # import the root as ix:local
~~~

Build on Linux with Docker and Buildx. IX uses sudo to assemble and enter its
root. QEMU, cpio, and gzip are used for the x86-64 boot image.

`ROOT=` selects a root directory. **make update** refreshes the maps and
recipes of an existing IX root. It keeps a numbered backup of changed recipes and leaves installed software
and home data in place. To start from the current minimal base, build into a fresh
directory with `make world ROOT=/absolute/path`.

~~~sh
cd /
make map
cd /src
make catalog
cd pacman
make
~~~

The ports install on request. `make -C / english` adds `yhwh`, `@`, `nsh`,
`LD`, and their manuals. `make -C /src/yhwh install` adds the Electron
desktop and its dependencies inside Arch. Pacman, Nix, and emerge each work
inside their own `/dst` root and have editable source recipes under `/src`.

See [A walk through Sinai](doc/sinai.md) for the port commands, borrowing a
program, and editing recipes with YHWH.

See [the Root Enterprise](doc/enterprise.md) for how this happened.
