---
title: 'TryHackMe: Complete Beginner'
date: 2021-11-02 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-02-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-11-02

# Linux PrivEsc

## Cron Jobs

Remember the `locate` tool! It’s faster than `find` (assuming that it’s installed, and the database is up-to-date, and the file you’re looking for is accessible to `nobody`…).

Also, the Bash reverse shell makes an appearance here!

Remember that SUID Bash will drop privileges by default; execute with the `-p` option to avoid this.

Okay, this is wild… It looks like the wildcard expansion (`*`) in Bash scripts doesn’t get pushed to the command, but is instead expanded in place. This means that files named like command-line switches _will be interpreted as command line switches_. This can be used, for example, to exploit sloppy tar-based backup scripts.

- [Exploiting Bash](https://cardboard-iguana.com/notes/exploiting-bash.html)
- [tar (GTFOBins)](https://gtfobins.github.io/gtfobins/tar/)

## SUID / SGID Executables

Quick-n-dirty command to find all SUID/SGID executables.

```
find / -type f \
-a \( -perm -u+s -o -perm -g+s \) \
-exec ls -l {} \; 2> /dev/null
```

Quickly see what shared libraries an executable is trying to load:

```
strace $EXECUTABLE 2>&1 | grep open
```

If there are missing libraries in paths that we’re able to access, then code similar to the LD\_PRELOAD trick can be used to inject malicious code

Running `strings` on a binary can also give us a sense of what helper applications might be getting executed.

[There are lots of wacky things you can do with Bash.](https://cardboard-iguana.com/notes/exploiting-bash.html)

- [Exploiting LD\_PRELOAD](https://cardboard-iguana.com/notes/exploiting-ld-preload.html)

## NFS

Files created on NFS shares inherit the _remote_ UID. By default, NFS enables “root squashing”, which maps UID 0 to the `nobody` user.

Root squashing can be _disabled_ in /etc/exports with the `no_root_squash` flag.

Unrelatedly, msfvenom can be used to generate executables that immediately shell out, similar to the LD\_PRELOAD trick.

- [Using Metasploit](https://cardboard-iguana.com/notes/metasploit.html)
- [Exploiting LD\_PRELOAD](https://cardboard-iguana.com/notes/exploiting-ld-preload.html)

## Kernel Exploits

- [Linux Exploit Suggester 2](https://github.com/jondonas/linux-exploit-suggester-2)

## Privilege Escalation Scripts

- [LinEnum](https://github.com/diego-treitos/linux-smart-enumeration)
- [Linux Smart Enumeration (LSE)](https://github.com/diego-treitos/linux-smart-enumeration)
- [LinPEAS](https://github.com/carlospolop/PEASS-ng/tree/master/linPEAS)

LinEnum is very fast, but LSE and LinPEAS produce more intelligible output.

