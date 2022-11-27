---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-11 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-11-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-10-11

# Hashing

## What is a Hash Function?

Apparently hashes are sometimes represented in base64. I’ve never seen this myself.

The MD5 algorithm outputs a 128 bit (16 byte) hash.

## Uses for Hashing

REMINDER: For salting to be effective, the salt needs to be _different_ for each user!

- [MD5 hash cracker](https://www.cellphonetrackers.org/tool/md5-coder.php)

## Recognizing Password Hashes

Recognizing hash types from first principles is generally unreliable (which makes sense - for a hash to maximally cover the space allocated by its size, it can’t have any “patterns” to it). Some general notes:

UNIX-style passwords are of the form `$format$rounds$salt$hash`. Common `format` parameters:

- 1 - md5crypt (mostly older)
- 2, 2a, 2b, 2x, 2y - bcrypt (generally web apps)
- 6 - sha512crypt (most modern systems)

Both $rounds and $salt are optional (salts are never purely numeric, so it’s easy to tell these apart).

NTLM hashes are an md4 variant. You can’t tell NTLM from md4 from md5 hashes just by looking at them (they’re all the same length). Windows stores passwords in the SAM, split between NT hashes (a.k.a. NTLM, though technically NTLM is the _protocol_) and LM hashes (an older, much weaker, hash type).

LM hashes are constructed in an absolutely batshit crazy fashion, but NT hashes are just the md4 hash of the UTF-16-LE encoding of the user password (UTF-16-LE is the little endian version of UTF-16).

- [LM, NTLM, Net-NTLMv2, oh my!](https://medium.com/@petergombos/lm-ntlm-net-ntlmv2-oh-my-a9b235c58ed4)

NOTE: 1 hex digit = 4 bits

## Password Cracking

Bcrypt is designed to take approximately the same amount of time when hashed on a CPU vs. a GPU, which is one reason it’s considered more resistant to cracking.

Hashcat command line:

```
hashcat -m $TYPE -O $HASHFILE $WORDLIST
```

Here $TYPE is the hash type (check `man hashcat`), and -O requests that hashcat use an optimized kernel (faster, but limited in the password length that can be cracked).

Some values of -m:

- 0 - md5
- 1400 - sha256
- 1800 - UNIX SHA-512 passwords
- 3200 - bcrypt

Passwords are output as HASH:PLAINTEXT tuples.

A “token length exception” means that the provided hash format is of the wrong length (probably because an additional character got accidentally added).

