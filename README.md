# @

<img src=".face" alt="The face of the Root Enterprise" width="240">

The root user's home. J is root (0), R is user (1), and YHWH is
the fellow in /home/yhwh (2) who takes credit for the uptime.

~~~
sudo make world             # build ix at /mnt/sinai
sudo make chroot            # open a shell there
sudo make boot              # boot ix in QEMU
sudo make iso               # build the x86-64 BIOS live CD
sudo make container         # load ix:local
~~~

Inside ix, **make -C /** prints the available commands. **make enterprise**
from any of the three homes fetches the source tree into that user's **src**.
**gen list** lists the ports. **gen install thedynamiclinker/gen2** tries one.
Root installs into **/**. Everyone else installs into **$HOME**.

~~~
yhwh shell                  # try a command, then talk it over when it fails
yhwh -- 'what did I mean by sl?'
LD NSH > nsh.new            # generate one implementation on stdout
yhwh save nsh-new nsh.new   # install a reviewed file in your prefix
yhwh remember sl "when I type sl, I usually mean ls"
~~~

A lowercase command is ordinary software, a mixed-case command may call an
agent, and an uppercase command is English with an LD shebang. Scripts and
**yhwh -c** use the ordinary shell's exit status. In a terminal, type
**ld.so COMMAND** to see the same behavior.

Set **GEN_AGENT** to an executable that reads a prompt on stdin and returns
text on stdout. **gen-codex** and **gen-http** are included. See
[gen](https://github.com/thedynamiclinker/gen) for setup and
[ix](https://github.com/doubleunix/ix) for boot and chroot details.
GitHub private repositories use your normal Git credentials.

See [the Root Enterprise](doc/enterprise.md) for how this happened.
