# A walk through Sinai

Type **make** at `/`. Try **make map**, then **cd /bin** and **make** again.
In sh, **make <Tab><Tab>** lists targets in the current Makefile.
**make -C /src/pacman pub<Tab>** fills in a single target.

- `make -C / small` counts the base. Toybox supplies most commands and
  BusyBox supplies the shell, editor, and mount tools.
- `make -C /etc genesis` reads the lines this world starts from.
- `make -C /root journal` opens your notebook in vi.
- `make ports` lists the recipes under `/src`. In any port, type **make**.
- `make list` lists the enterprise source ports by repository name.

A prefix has `bin` for commands, `lib` for what programs load, and `etc` for
editable settings. The base owns `/bin`, `/lib`, and `/etc`. The package links
go in `/usr`. When you install by hand use `/usr/local` as root or `~/.local`
as a regular user. Both are on the appropriate shell's path.

The console opens as root. Use `busybox su - user` for UID 1 or
`busybox su - yhwh` for UID 2. All three accounts use the aliases and
prompt settings in `/etc/bashrc`.

## Plant a distro

    make -C /src/pacman add PACKAGES=sl
    make -C /src/nix add PACKAGES='nixpkgs#sl'
    make -C /src/emerge add PACKAGES=app-misc/sl
    make -C /pkg list

The first request plants each distro. Its package database and dependencies
live under its own root in `/pkg`. Alpine's minirootfs and package manager
arrive the first time you request Git, an OCI image, or a compiler. Browse
its recipes with **make -C /src/alpine**. Each distro command runs in a
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

    cd /src/toybox
    make fetch
    vi source/toys/posix/ls.c
    make install

**fetch** downloads and verifies the same release used for the base.
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

    yhwh auth login
    yhwh auth status
    yhwh turn Say hello

The first login installs Codex in `~/.local/bin` on x86-64 or ARM64 if
Codex is absent. Enable device code login in your ChatGPT security settings,
then open the URL shown in the terminal and enter the code. For API key
authentication, pipe the key to `yhwh auth login --with-api-key`. The login
is saved in `~/.codex` for that Sinai user and excluded from image exports.
Use `yhwh auth logout` to clear it. [Codex authentication](https://learn.chatgpt.com/docs/auth?surface=cli)

To select another backend, set `GEN_AGENT` to a guest executable that
takes the prompt on stdin and prints the reply. For a chat-completions
endpoint, set `GEN_URL` and `GEN_MODEL`, with `GEN_KEY` if it needs a bearer
token. The default effort is `xhigh`. Set `GEN_REASONING=0` for endpoints
without a reasoning-effort parameter.

From a host chroot, `GEN_HOST=/path/to/filter make chroot` provides the
same filter interface over a private Unix socket. The filter runs as the
host caller and can use that account's model login. The guest executes its
own shell steps. For example, the enterprise gen source has a filter for
an existing Codex login on the host.

    make fetch PORT=thedynamiclinker/gen
    GEN_HOST="$PWD/dst/root/src/thedynamiclinker/gen/bin/gen-codex" make chroot

Use `#!/bin/LD` on a file of sudocode to run it as a command. The model
protocol fits on one screen in `/lib/ix/agent`. Use **make -C / shell** for
nsh, where plain shell commands and `@` are both available.

## Take the long way

Open Sinai with `make chroot` from a terminal on your X11 or XWayland
desktop. Sinai picks up the host's `DISPLAY` and X11 authorization.
Use `X11=0 make chroot` for a console-only session.

Inside Sinai, sign in for the command-line agent and install and open the
optional desktop.

    yhwh auth login
    make -C /src/yhwh install
    cd /path/you/want/to/open
    yhwh el

The port builds El in Arch. The app runs in Sinai as the caller and opens
its terminal and file manager in the calling directory. `yhwh open` opens
El by default. Put a command such as `nsh` on the first line of
`/etc/yhwh-open` to change that alias. From the old El installation,
`make -C /src/yhwh runtime` adapts the installed app without rebuilding it.
Use `make -C /src/yhwh check` to open El under Xvfb without a host display.

Serial boot runs in RAM. Use the disk-backed chroot to keep packages and
changes. The host's `make boot`, `make iso`, and `make container` build a
fresh world by default. Pass `ROOT=/absolute/path` to export a world with
your changes.
