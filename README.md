# @

Sinai starts with Toybox, a small BusyBox sh, musl, Make, and the English
command line. Open a console at `/`, type **make**, and try **make
<Tab><Tab>**. **make ports** shows what you can fetch and build.

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

`/usr` starts empty. The ports in `/src` are recipes for fetching source,
Git, compilers, the desktop, and any combination of Arch, Gentoo, and Nix.
The managers keep their own roots under `/pkg`. You choose which files and
commands appear in `/usr`. Manual installs go in `/usr/local` or `~/.local`.

~~~sh
make chroot
make map
make genesis
make ports
make -C /src/toybox fetch
yhwh install sl from arch
~~~

`lord`, `nsh`, `@`, and `LD` are built in. Run `yhwh auth login` inside
Sinai to install Codex and sign in once. Send a test prompt with
`yhwh turn 'Say hello'`. The guide also covers custom model endpoints,
switching links, editing Toybox, and making an ebuild. [A walk through Sinai](doc/sinai.md)

`make boot`, `make iso`, and `make container` start from a fresh base. Pass
`ROOT=/absolute/path` to export a world you've customized or to build and
enter another chroot. `make update` refreshes the recipes in a current world
and saves numbered copies of edited files. Use a fresh directory to build
the new base if your existing root is from an earlier generation.

`make genesis` in Sinai reads `/etc/genesis`, the project's standing
instructions. In the checkout they live in `ix/files/genesis`.
