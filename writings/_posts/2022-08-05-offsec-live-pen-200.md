---
title: 'OffSec Live: PEN-200'
date: 2022-08-05 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-05-offsec-live-pen-200.html
author: 100007
---

Today on OffSec Live we’ll be covering Linux privilege escalation.

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [Join OffSec Live](https://learn.offensive-security.com/offsec-live-webinars)

# File Permissions

Oh, I hadn’t noticed this before, but the \*NIX read/write/execute bits are represented in that order in the permission bitmask, which is why `r` is `4`, `w` is `2`, and `x` is `1`. (Or, an easier mnemonic might be “they’re read in _descending_ order”.)

When using symbolic permissions with `chmod`, leaving off the `ugo` bit will result in the permission being applied to all three categories. For more complex expressions, different permission changes can be separated with a comma (`,`) - for example, `chmod ug+x,o-w file.txt`.

# The SUID & SGID Bits

Find SUID files: `find / -type f -perm -u=s -ls 2>/dev/null`

Not sure if a binary is normally SUID? Compare the results of the above command with the same output on your local (Linux) box.

The presence of the SUID/SGID bit only _allows_ a program to elevate its privileges to match its user/group - a call to `setresuid()` and/or `setregid()` (or work-alikes) is still required to actually perform the (presumably legitimate) privilege escalation!

- [How to Use “find” With File Metadata](https://cardboard-iguana.com/notes/how-to-use-find-with-file-metadata.html)
- [GTFOBins](https://gtfobins.github.io/)

# Exploiting the SUID Bit

In the output of the `id` command, the `euid` and `egid` are the _effective_ user and group IDs.

When exploiting binaries that call other binaries, look for places where the absolute path has not been used and then see if you can manipulate the PATH so that a binary _you_ control is called instead!

