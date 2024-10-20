---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-12 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-12-tryhackme-complete-beginner.html
author: 100007
---

# John the Ripper

## Cracking Basic Hashes

John will attempt to identify the hashes that it’s been given if the hash type is not explicitly provided. This can be kind of unreliable though.

A better option is to use the hash-identifier script on Kali Linux; this script doesn’t try to _exactly_ guess the hash, but will return a list of _possible_ hashes. This + context about the providence of the hashes will generally be enough to let you make an informed guess.

Use the –format option to specify a particular hash type (–list=formats will provide you with a complete list; note that the –format option is _not_ case-sensitive). Be aware that john can only work on a single format at a time, so a file of mixed hashes is not allowed.

John requires a wordlist to use; it’s basically just hashing elements of the wordlist and then comparing them with the target hash (so, a way to do fast dictionary attacks).

## Cracking Windows Authentication Hashes

NThash password hashes live in the NTDS.dit database on Active Directory servers. For many (most?) Windows operations, the password hash is as good as the password itself (“pass the hash” attacks), so there’s often no need to actually crack these.

Use the `nt` format to crack NThashes in john.

## Cracking /etc/shadow Hashes

John is very particular about cracking Linux shadow passwords; you can’t just feed it /etc /shadow directly, but rather need to use the `unshadow` command to (re)combine the /etc/passwd and /etc/shadow (or the relevant lines from each), and then have john chew on the resulting output.

In general it’s not necessary to specify the hash format in this case, though if for some reason you need to it’s sha512crypt for modern Linux systems.

## Single Crack Mode

John’s “single crack mode” (–single) is just about exploiting bad password practice - basing passwords off of the username, or details of the operating system. It can be used over “unshadowed” UNIX-style passwords (in which case it will exploit not only the username, but data from other GECOS fields), or on single hashes (in which case the hash must be written as USERNAME:HASH so that john has something to go off of).

Obviously, a wordlist is not required in single crack mode.

(And I’m honestly not sure how useful this is going to be in the present day and age.)

## Custom Rules

People typically add “complexity” to a password by appending or prepending the required numbers and symbols (capital letters generally live on either the beginning or end of the password).

John’s rules can be used to construct additional permutations of a wordlist to cover these cases. The rule syntax isn’t really covered in the TryHackMe room, but seems to be just close enough to regexes to be annoying. Examples can be found in /etc/john/john.conf; the comments make for interesting reading.

## Cracking Password Protected Zip Files

Cracking zip file passwords is similar to cracking UNIX passwords - pass to the zip2john pre-processor first, and then feed john the resulting output (_without_ the –format specifier).

## Cracking Password Protected RAR Archives

Same deal as with zip files for rar files, except use rar2john as the pre-processor.

## Cracking SSH Keys with John

Same deal again for cracking ssh key passwords… Except that the tool’s in /usr/share/john/ssh2john.py this time (this script probably isn’t installed in the PATH because it needs to be run using python2).

NOTE: John is susceptible to false positives when cracking ssh keys, and will thus try the entire provided wordlist (just in case!).

