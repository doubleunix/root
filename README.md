# @

Sinai starts with Toybox, BusyBox sh, musl, Make, and YHWH. In the console,
type `make` for one-line help, `make ls` to see what lives under `/`, and
`make -C /src ls` to see the ports. Tab completes targets in each directory.

~~~sh
make world                  # build /mnt/sinai
make chroot                 # enter the chroot
make check                  # test a fresh root
make boot                   # boot a serial console in QEMU
make iso                    # build a BIOS live CD in src/build/
make import                 # import the root as ix:local
~~~

Run these as yourself on Linux. The Make targets use sudo when they need it.
The build uses Docker, Buildx, and rsync. The x86-64 boot targets also use
cpio, gzip, and QEMU.

`src/` is the host build prefix. Its `bin/`, `lib/`, and `etc/` build
Sinai, and its `build/` holds generated artifacts. `dst/` is the static
filesystem tree. A file at `dst/PATH` lands at `/PATH` in the world.
In the checkout, `make ls` lists the Git ports and `make fetch-all` clones
them into `dst/root/src/`. A fresh image includes that tree at `/root/src/`.

`/usr` starts empty. The ports in `/src` are recipes for fetching source,
Git, compilers, the desktop, and any combination of Arch, Gentoo, and Nix.
The managers keep their own roots under `/pkg`. You choose which files and
commands appear in `/usr`. Manual installs go in `/usr/local` or `~/.local`.

~~~sh
make chroot
make ls
make genesis
make -C /src ls
make -C /src/toybox fetch
yhwh install sl from arch
~~~

`lord`, `nsh`, `@`, and `LD` are built in. Run `yhwh auth login` inside
Sinai to install Codex and sign in once. Send a test prompt with
`yhwh turn 'Say hello'`. The guide also covers custom model endpoints,
switching links, editing Toybox, making an ebuild, and opening YHWH El.
Install El with `make -C /src/yhwh install` inside Sinai. Run `yhwh el` or
`yhwh open` in the directory you want to work in.
[A walk through Sinai](dst/src/guide.md)

`make boot`, `make iso`, and `make import` start from a fresh base. Pass
`ROOT=/absolute/path` to export a world you've customized or to build and
enter another chroot. `make update` reapplies the static files to a current
world and adds missing built-in accounts. Use a fresh directory to build
the new base if your existing root is from an earlier generation.

Use Unix names in Makefiles. Write `ls`, `sh`, and `ln` for those operations.
Put a one-line description after `##` on a target so it appears in `make`
help and guest shell completion. In Sinai, `make man` opens the guide and
`make genesis` reads the project's standing instructions.
[Genesis](dst/etc/genesis) · [Minimalism](src/doc/minimalism.md) · [Original prompts](src/doc/context.md)
