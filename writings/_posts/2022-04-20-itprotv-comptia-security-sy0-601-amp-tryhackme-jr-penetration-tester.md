---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-04-20 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-20-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

## Incident Response Process

Event = Something that raises a potential security flag.

Incident = A violation of some security process or policy.

Phases:

- Preparation (logging and monitoring)
- Identification (detection, analysis, and alerting of _events_)
- Containment (network isolation, system shutdowns, etc.)
- Eradication (malware removal, wipe-and-reload, etc. _and_ verify that no additional systems are impacted)
- Recovery (return to normal… _after_ verification of eradication)
- Lessons Learned

Part of recovery is ascertaining _how_ the incident occurred and remediating the associated vulnerability/vulnerabilities.

A good distinction: A “runbook” is an _automated_ playbook.

Things to have in your after action report:

- What went right?
- What went… well?
- What went wrong?
- What was impacted?
- How was the attack accomplished?
- How can existing systems be improved?

## Incident Response Plans

- Who are you reporting to? Who approves your actions? Who initiates the incidence response process?
- Who’s on your team? (IT, experts, consultants, LEOs, etc.)
- Who are your stakeholders? What are your responsibilities to them? How will they be communicated with?
- How are internal comms handled? External comms? (And when?)
- How is evidence handled, documented, and retained?

BCDRP = Business Continuity and Disaster Recovery Plan

Exercises, in order of how closely they mimic/interrogate the IRP:

- Tabletop exercises
- Walkthroughs
- Simulations

There’s actually a tabletop game created by Black Hills Information Security that’s designed to help with tabletop exercises.

- [Backdoors & Breaches](https://www.blackhillsinfosec.com/projects/backdoorsandbreaches/)

## Attack Frameworks

An “attack framework” is just a way to describe an attack in a standardized fashion.

- MITRE ATT&CK (Adversarial Tactics, Techniques & Common Knowledge)
- Diamond Model (from top clockwise: adversary, capabilities, victim, infrastructure)
- Cyber Kill Chain (recon, weaponization, delivery, exploitation, installation, command and control, actions on objective)

The diamond model can be summarized as, “for every intrusion, there exists an _adversary_ who is using their _capabilities_ over/with some kind of infrastructure _infrastructure_ to attack a _victim_.”

MITRE ATT&CK is really the gold standard though.

- [MITRE ATT&CK](https://attack.mitre.org/)

# TryHackMe: Jr. Penetration Tester

## Enumeration

Useful Linux post-exploit enumeration commands

- `hostname`
- `uname -a`
- `cat /proc/version`
- `cat /etc/issue`
- `ps auxww` (lots and lots of process info)
- `ps auxfww` (process tree)
- `env`
- `sudo -l` (create log enteries!)
- `ls` (of course)
- `id`
- `cat /etc/passwd`
- `history`
- `ifconfig`
- `ip route`
- `netstat -a` (all listening parts and established connections)
- `netstat -l` (only listening ports)
- `netstat -s` (protocol statistics)
- `netstat -p` (protocol and service information, requires root to see everything)
- `netstat -i` (per interface statistics)
- `netstat -ano`
- `find` (various permutations)
- `locate`

Instead of `u`, `j` can be used with `ps` to get a slightly different column output format. This is mostly useful for finding out numeric user IDs and _parent_ process IDs.

The `netstat` command supports the `-t` and `-u` flags to limit returned ports to TCP and UDP, respectively. Note that by default `netstat` will try to resolve hostnames, which can cause hangs; use `-n` to skip this (and only display IP addresses).

## Automated Enumeration Tools

- [LinPeas](https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite/tree/master/linPEAS)
- [LinEnum](https://github.com/rebootuser/LinEnum)
- [LES (Linux Exploit Suggester)](https://github.com/mzet-/linux-exploit-suggester)
- [Linux Smart Enumeration](https://github.com/diego-treitos/linux-smart-enumeration)
- [Linux Priv Checker](https://github.com/linted/linuxprivchecker)

Of these, only LES is available in the Kali Linux repos (`sudo apt install linux-exploit-suggester`).

## Privilege Escalation: Sudo

Basically: GTFOBins!

Sometimes, you can also get applications to leak information about sensitive files (such as `/etc/shadow` by passing these as if they were configuration files. Apache is one app that does this.

Also, exploiting `LD_PRELOAD`.

Exploiting `sudo nano`:

- `CTRL+R` (read file)
- `CTRL+X` (execute file)
- `reset; sh 1>&0 2>&0`

Exploiting `sudo less` is as simple as `!/bin/sh`.

If `find` can be run with `sudo`, then try `sudo find . -exec /bin/sh \; -quit`.

- [GTFOBins](https://gtfobins.github.io)
- [Exploiting LD\_PRELOAD](https://cardboard-iguana.com/notes/exploiting-ld-preload.html)

## Privilege Escalation: SUID

Find (not always so quickly) SUID and SGID files:

```
find / -type f -perm -04000 -ls 2>/dev/null
```

Note that Linux systems still fall back to password hashes in `/etc/passwd` if an entry in `/etc/shadow` isn’t present. This means that we can just directly add root-equivalent users directly here (remember that the UID and primary GID can be duplicated!).

To generate a password acceptable for inclusion in `/etc/passwd`:

```
openssl passwd -1 -salt $SALT $PASSWORD
```

## Privilege Escalation: Capabilities

“Capabilities” are finer-grained permissions that can be assigned to a binary. Think of them as a kind of granular SUID/SGID.

The `getcap` command displays a binary’s capabilities (if there are any), and can even be used to perform a search for such binaries using `getcap -r $PATH 2> /dev/null`.

## Privilege Escalation: Cron Jobs

Basically, check to see if any scripts run by a privileged user can be written to by an unprivileged user.

Also look for “zombie” cron jobs that are still running but refer to a non-existent file in a writable location.

Bash as a reverse proxy makes an appearance again here.

## Privilege Escalation: NFS

NFS exports are listed in `/etc/exports`; if an export is configured with `no_root_squash`, then root permissions won’t be stripped from created files and it’s possible to create root-owned SUID/SGID binaries on the mount. (Remember that files on NFS mounts are created using the UID/GID values of the _local_ user!)

