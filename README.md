# @

0. at, like, where you're at
1. AT, beginning & end in ot
2. AO, beginning & end in nt
3. A0, the first link/loader

Or in summary, it's just LD.

Praise the L||D.

Sincerely,

LꞀ

---

Prof. Julian Assange  |If you want to build a ship, don't drum up people
                      |together to collect wood and don't assign them tasks
proff@iq.org          |and work, but rather teach them to long for the endless
proff@gnu.ai.mit.edu  |immensity of the sea. -- Antoine de Saint Exupery


## The New World

```sh
make install PREFIX="$HOME/.local"
make develop PREFIX="$HOME/.local"
make uninstall PREFIX="$HOME/.local"
make clean
```

Install and develop bring in the shell package and its LD and lord
dependencies. The enterprise checkouts under `dst/root/src` are used
when present. Set `PORTS_SOURCE`, `PORTS_CACHE`, or `GIT_ROOT` to use
another checkout tree, cache, or Git server.

```sh
make chroot
make check
make tools
make chroot COMMAND='make -C /src ls'
```

The default root lives at `/mnt/new-world`. It contains Toybox, BusyBox
ash and boot applets, Make, and the New World commands. It opens `nsh`
on a terminal. Use `ROOT=/path` for a separate root, `make update` to
refresh a built root, and `make check` to test a disposable root.

The initial `/src` Makefile lists and installs Git ports. `make tools`
adds Git and HTTPS support and the optional Alpine, Arch, Gentoo, Nix,
and YHWH Electron recipes. For native Python, run
`make -C /src/alpine python` after adding those tools. The
core is usable before installing these packages.

```sh
GEN_HOST=/path/to/text-backend make chroot
make chroot COMMAND='make -C /src install PORT=dictionary'
```

`GEN_HOST` connects a host text filter over a private Unix socket. It
receives the request on stdin and `GEN_EFFORT` in its environment. Start
the chroot with the host user whose provider configuration should be
used. Inside the root, `LORD_BACKEND` also accepts an executable using
the lord argv and stdin interface.
