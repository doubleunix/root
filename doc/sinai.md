# A walk through Sinai

Type **make** at `/`. Try **make map**, then **cd /bin** and **make** again.
In sh, **make <Tab><Tab>** lists targets in the current Makefile.
**make -C /src/pacman pub<Tab>** fills in a single target.

- `make -C / small` counts the base. Toybox supplies most commands and
  BusyBox supplies the shell, editor, and mount tools.
- `make -C /etc genesis` reads the lines this world starts from.
- `make -C /root journal` opens your notebook in vi.
- `make -C /src catalog` opens the workshops. In any workshop, type **make**.

A prefix has `bin` for commands, `lib` for what programs load, and `etc` for
editable settings. The base owns `/bin`, `/lib`, and `/etc`. The package links
go in `/usr`. When you install by hand use `/usr/local` as root or `~/.local`
as a regular user. Both are on the appropriate shell's path.

## Plant a distro

    make -C /src/pacman add PACKAGES=sl
    make -C /src/nix add PACKAGES='nixpkgs#sl'
    make -C /src/emerge add PACKAGES=app-misc/sl
    make -C /pkg list

The first request plants each distro. Its package database and dependencies
live under its own root in `/pkg`. The Alpine workshop appears when you
first need Git, an OCI image, or a compiler. Each distro command runs in a
chroot with its own mounts and process namespace. They share the host
kernel, network, and root authority. Use sources and packages you trust.

A host can also plant any combination with `make distro-arch`,
`make distro-gentoo`, and `make distro-nixos`. Use the workshop's
`IMAGE=repo@sha256:...` to pin a root or `ARCHIVE=/path/to/root.tar` to use
an existing archive. The default Arch and Gentoo bootstraps target x86-64.

## Put something on the path

    ix-world publish arch /usr/bin/sl sl
    sl
    ix-world publish nix /nix/var/nix/profiles/ix/bin/sl sl /usr replace
    ix-world run arch /usr/bin/sl

**publish** links a name in the chosen prefix to a private launcher. The
launcher starts the native executable inside its distro, where its loader
and libraries have their usual paths. Launch it from the root console or
through sudo. Switching a name leaves both distros' versions available.

**link** makes a literal link to a file. Use it for data and commands that
can run with the receiving prefix's available loader and libraries. Hard
links share an inode and need one filesystem. Soft links follow the named
file, including when the package manager replaces that file.

    ix-world link gentoo /etc/gentoo-release /usr/etc/gentoo-release hard
    ix-world link arch /etc/os-release /usr/etc/release soft
    ix-world link gentoo /etc/os-release /usr/etc/release hard replace
    ix-world link gentoo /etc/os-release /tmp/another/etc/release soft

The port Makefiles offer **publish**, **link**, and **export** as recipes.
For a full staged prefix, **export** links its files and reproduces its
symlinks. It checks occupied destinations before writing any links.
Use `PREFIX=/`, `PREFIX=/usr`, or an absolute path of your choosing.

## Take it apart

    make -C /src tools
    cd /src/toybox
    make read
    vi source/toys/posix/ls.c
    make install

The build recipe adds the Alpine compiler and toolchain on first use.
It compiles the working tree, tries the new Toybox, and renames it into
`/bin/toybox`. You can choose more applets with **make config**.
The console shell is BusyBox ash.

The distro workshops have **fetch**, **edit**, **diff**, **build**, and
**install-source** for their own manager sources. This is how you can show
a recipe to the agent and apply a patch you have reviewed.

    cd /src/pacman
    make fetch
    make ask FILE=source/meson_options.txt REQUEST='Show a patch for this option.'
    make patch PATCH=/tmp/change.patch
    make install-source

For a local Gentoo package, use **make -C /src/emerge overlay** to open the
ebuild tree at `/pkg/gentoo/var/db/repos/ix`. Put your ebuild there and keep
the editable upstream checkout in `/src`. **stage** resolves build
dependencies in Gentoo and installs the single package into its own image.
With `CHECKOUT=/src/project`, the ebuild can read that checkout at `/ix-src`.

    make -C /src/emerge stage PACKAGES=app-misc/hello NAME=hello
    make -C /src/emerge export FILE=/opt/ix-packages/hello/usr KIND=hard
    ix-world publish gentoo /opt/ix-packages/hello/usr/bin/hello hello /usr replace

Use the last line when the exported executable needs Gentoo's loader.
Package configuration from a staged `etc` can be exported separately to
the receiving prefix's `etc`.

## Ask in words

    yhwh install sl from gentoo
    @ switch sl to nix and keep the gentoo version
    lord -i add a Toybox applet and rebuild it here
    nsh

The short **install ... from ...** form works on its own. For an open-ended
request, **lord** asks a model for shell steps, runs the steps as the
calling UID, and shows the commands and their output. `-i` asks before
each step. `-n` and **yhwh turn** answer in text. If the model needs an
answer, reply at the prompt or enter `:cancel`.

On a running world, export `GEN_URL` for a chat-completions endpoint and
`GEN_MODEL` for the model. Set `GEN_KEY` if the endpoint needs a bearer
token. The default effort is `xhigh`. Use `GEN_REASONING=0` for endpoints
without a reasoning-effort parameter. Alternatively, set `GEN_AGENT` to
a guest executable that takes the prompt on stdin and prints the reply.

From a host chroot, `GEN_HOST=/path/to/filter make chroot` provides the
same filter interface over a private Unix socket. The filter runs as the
host caller and can use that account's model login. The guest executes its
own shell steps. For example, the enterprise gen source has a filter for
an existing Codex login on the host.

    make fetch PORT=thedynamiclinker/gen
    GEN_HOST="$PWD/src/thedynamiclinker/gen/bin/gen-codex" make chroot

Use `#!/bin/LD` on a file of sudocode to run it as a command. The model
protocol fits on one screen in `/lib/ix/agent`. Use **make -C / shell** for
nsh, where plain shell commands and `@` are both available.

## Take the long way

The optional desktop lives in `/src/yhwh`. **make install** there builds
it in Arch and publishes `yhwh-el`. From an X11 or XWayland host, enter
with `X11=1 make chroot`. **make check** in the desktop workshop uses
Xvfb. The serial boot runs in RAM. Use the disk-backed chroot when you
want to keep packages and changes.
