# A walk through Sinai

At the console, type **make**. Try **make map**, then **cd /bin** and type
**make** again. In Bash, **make <Tab>** lists the targets on the local
Makefile's map. Each description is written beside the recipe it describes.

- `make -C / small` counts the base. Toybox provides most commands, BusyBox
  provides `sh`, `vi` and the boot plumbing, and musl loads the programs.
  Bash and GNU Make are there to make the recipes easy to discover and edit.
- `make -C /etc network` shows how the console reaches the outside.
- `make -C /root journal` opens a notebook. `make -C /lib loader` shows the
  ELF interpreter. `make -C /lib ports` reads the shared port rules.
- `make -C /src catalog` shows four workshops. Open one and type **make**.

## Software 1.0

You can do all of this at an ordinary shell with `vi`, `git`, and `make`.

    cd /src/pacman
    make install
    make add PACKAGES=tree
    make run RUN='pacman -Q tree'
    make publish NAME=arch-tree FILE=/usr/bin/tree
    arch-tree /usr

`/src/Makefile` offers an open door for other OCI images or trusted root
archives. Supply a pinned image digest in `IMAGE=` to reproduce a particular
bootstrap, or supply `ARCHIVE=/path/to/root.tar`. Install a matching
architecture. The Arch and Gentoo recipes ship x86-64 image defaults.

    make -C /src seed WORLD=other IMAGE=alpine:3.23
    make -C /dst list
    make -C /dst visit WORLD=other

A port plants a stock root in `/dst`. Its manager sees the ordinary paths
inside that root. Pacman owns Arch's `/var/lib/pacman`, emerge owns Gentoo's
`/var/db/pkg`, and Nix sees its store at `/nix/store`. Each runtime resolves
libraries inside its own root. **publish** writes a command under
`/usr/bin` that enters the right root and runs its native binary. **link**
creates a literal symlink under `/usr` for data or a compatible static
binary. Both require a free destination and can be repeated. For example,
borrow the Arch release file with
`make link FILE=/etc/os-release TO=share/arch-release`.

    make -C /src/nix add PACKAGES='nixpkgs#hello'
    make -C /src/nix publish NAME=nix-hello FILE=/nix/var/nix/profiles/ix/bin/hello
    make -C /src/emerge add PACKAGES=app-misc/hello

These development chroots share the IX kernel and run the selected package
manager as root.

## Software 2.0

    make -C / english
    make -C / shell

The first command installs the CLI, `@`, `nsh`, `LD`, and their manuals.
You can use `GEN_AGENT=/path/to/program` or `GEN_URL` and `GEN_MODEL` with
your own backend. Use `yhwh --help` to see the commands provided by the
installed revision. `man @` starts at the beginning.

A distro port's **fetch** checks out its manager under `./source`.
**edit**, **diff**, and **build** work with that tree, including local edits.
**install-source** installs your build into its own prefix inside the
distro. The stock manager can still provide a working toolchain.

    cd /src/pacman
    make fetch
    make ask FILE=source/meson_options.txt REQUEST='Explain how to change the default package directory for this build. Show the smallest patch.' > /tmp/reply
    more /tmp/reply
    # Save the reviewed unified diff to /tmp/change.patch, then:
    make patch PATCH=/tmp/change.patch
    make install-source

**ask** sends the recipe and the named file to the configured backend.
**patch** checks and applies a diff to the checkout. To change the recipe
itself, use **make edit**. The ordinary shell stays available throughout.

## The desktop

    cd /src/yhwh
    make install
    make check
    make run

This uses Arch for the glibc desktop stack, Node, npm and the C++ build tools.
See **make deps** for the exact packages and the upstream lockfile in
`source/yhwh/package-lock.json` for the npm dependencies. The installed
command is `yhwh-el`, and it runs as `ix-desktop` inside Arch. From an X11
or XWayland host session, enter with `X11=1 make chroot` to pass the display
and its cookie. Inside IX,
`make -C /src/yhwh run` uses that display. For a separate X server, set
`DISPLAY` and put its cookie in `/dst/arch/home/ix-desktop/.Xauthority`.
**make check** uses Xvfb. Booted initramfs changes live in memory, so use the
disk-backed chroot for large installs or to keep your work.
