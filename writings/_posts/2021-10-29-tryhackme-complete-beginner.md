---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-29 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-29-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-10-29

# Common Linux Privsec

## Direction of Privilege Escalation

Definitions:

- HORIZONTAL PRIVILEGE ESCALATION is obtaining access to another user account with the same(ish) privileges as the compromised account.
- VERTICAL PRIVILEGE ESCALATION is obtaining access to another user account with _higher_ privileges than the compromised account.

In general, vertical escalation involves obtaining root/SYSTEM access.

## Enumeration

TryHackMe is going to focus on the use of the LinEnum script. Direct download via:

```
curl -O https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh
```

- [LinEnum.sh](https://github.com/rebootuser/LinEnum/blob/master/LinEnum.sh)

## Abusing SUID/GUID Files

```
# Find SUID/SGID binaries
#
find / -type f -perm -u=s
#
# ...or...
#
find / -type f -perm -4000
```

Recall that leading a permission specified with `-` in `find` requires that _all_ of the specified permission bits be set (but is agnostic as to the presence/absence of additional permissions); for numeric permissions 0 effectively acts as a wildcard.

## Exploiting Writeable /etc/passwd

Strangely, it turns out that the `x` in the password field for /etc/password isn’t just anachronistic - it still _literally_ means “look in /etc/shadow”. If a password is present in that field instead… Well, the login process (at least on most Linux systems) will still use that!

Compliant password hashes can be created with the `openssl passwd` command. For example, to create an MD5 hashed password:

```
openssl passwd -1 -salt $SALT $PASSWORD
```

It’s also possible to have _multiple_ users with the same UID and GID in /etc/passwd (wut?). So this is a way of “cloning” the root account.

## Escaping the Vi Editor

The `sudo -l` command will helpfully tell us what we can run as the superuser without a password.

[A compendium of binary escapes: GTFOBins.](https://gtfobins.github.io/)

## Expanding Your Knowledge

Linux privilege escalation checklists:

- [Linux Privilege Escalation](https://github.com/netbiosX/Checklists/blob/master/Linux-Privilege-Escalation.md)
- [PayloadsAllTheThings: Linux - Privilege Escalation](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Linux%20-%20Privilege%20Escalation.md)
- [Total OSCP Guide: Privilege Escalation](https://sushant747.gitbooks.io/total-oscp-guide/content/privilege_escalation_-_linux.html)
- [A Guide to Linux Privilege Escalation](https://payatu.com/guide-linux-privilege-escalation)
