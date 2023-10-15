---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-13 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-13-tryhackme-complete-beginner.html
author: 100007
---

# Encryption

## Key Terms

This room draws the distinction between a _password_ (which is used as part of an authentication process) and a _passphrase_ (which is used to encrypt key material).

## Crucial Crypto Maths

Interesting side note: Spotlight (at least on iOS/iPadOS) understands `%` as the modulo operator.

## RSA (Rivest Shamir Adleman)

- [RsaCtfTool](https://github.com/Ganapati/RsaCtfTool)
- [rsatool](https://github.com/ius/rsatool)
- [RSA (cryptosystem)](https://en.wikipedia.org/wiki/RSA_%28cryptosystem%29)

## Explaining Diffie Hellman Key Exchange

Simpler Diffie-Hellman key exchange:

- Assume two secrets, A and B.
- Exchange some public material C.
- Exchange A ⊗ C and B ⊗ C
- Construct A ⊗ B ⊗ C and use that as your symmetric encryption key.

The magic here is in the operator ⊗ - it must be both commutative and very _very_ hard to reverse even with knowledge of C. So “normal” multiplication _doesn’t_ work here (since if ⊗ were multiplication, then it would be easy to extract A from A ⊗ C by observing C).

# Introduction to Windows

## Windows File System and Permissions Explained

C:/PerfLogs = performance and troubleshooting logs.

The biggest differences between Windows and UNIX permissions:

- Windows doesn’t have as fine-grained of control _for a given user or group_.
- Windows has _much more_ fine-grained control across users and groups (there’s no limit of three permission sets).
- The ability to delete a folder or file, and to change its permissions, are essentially considered to be distinct “sub-permissions”.

The `icacls` tool can be used to check (and change!) permissions at the command line, but its output is somewhat different than that of the “Security” tab in the file or folder properties.

- `(I)` - permission inherited from the parent container
- `(F)` - full access (full control)
- `(M)` - modify right/access
- `(OI)` - object inherit
- `(IO)` - inherit only
- `(CI)` - container inherit
- `(RX)` - read and execute
- `(AD)` - append data (add subdirectories)
- `(WD)` - write data and add files
