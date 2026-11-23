# @

<img src=".face" alt="The face of the Root Enterprise" width="240">

Sinai starts with Toybox, BusyBox sh, musl, Make, and the English command
line. Open a console at `/`, type **make**, and walk the recipes. Try
**make <Tab><Tab>**. The source for `/bin/toybox` is in `/src/toybox/source`.

~~~sh
make world                  # build /mnt/sinai
make chroot                 # step inside
make check                  # test a fresh world
make boot                   # boot a serial console in QEMU
make iso                    # build a BIOS live CD in build/
make container              # import the root as ix:local
~~~

Run these as yourself on Linux. The Make targets use sudo when they need it.
The build uses Docker and Buildx. The x86-64 boot targets also use cpio, gzip,
and QEMU.

`/usr` starts empty. Arch, Gentoo, and Nix are optional workshops with their
own roots under `/pkg`. You can keep all three and choose which files and
commands appear in `/usr`. Manual installs go in `/usr/local` or `~/.local`.

~~~sh
make chroot
make map
make genesis
make -C /src catalog
yhwh install sl from arch
~~~

`lord`, `nsh`, `@`, and `LD` are built in. Set `GEN_URL` and `GEN_MODEL` for
a model endpoint, or enter with `GEN_HOST=/path/to/model-filter make chroot`
to use a model available to your host account. [A walk through Sinai](doc/sinai.md)
covers both routes, switching links, editing Toybox, and making an ebuild.

Use `ROOT=/absolute/path` to make another world. `make update` refreshes the
recipes in a current world and saves numbered copies of edited files. Build
an earlier root generation into a fresh directory to get the new base.
