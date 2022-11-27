---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-08 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-08-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-10-08

# Upload Vulnerabilities

## Overwriting Existing Files

One reason to randomize upload names is to prevent file overwrites. If a webapp isn’t doing this (or using some other form of isolating upload files), then it’s possible to inject arbitrary files into it via its upload mechanism (of course, whether or not those do anything is a separate question…).

## Remote Code Execution

The gobuster tool is fuzzing/enumeration tool that can be used to find upload directories. Example invocation:

```
gobuseter dir -u $TARGET_URL -w $DIR_WORDLIST
```

The /usr/share/wordlists/dirbuster directory holds lists of various common directory names.

The simplest PHP web shell:

```
<?php
echo system($_GET["cmd"]);
?>
```

This takes a GET variable `cmd` and executes it (semicolons, output redirection, and the like are allowed).

[PHP system() command documentation.(https://www.php.net/manual/en/function.system.php)]

Where web shells get the web server to execute commands for us, reverse shells actually fire up a true shell and connect back to the client machine; this is the trick we’ve used a couple of times now with `nc -lvnp $PORT`.

The Kali Linux webshells package provides a variety of webshells, some of which are reverse shells. A common option is /usr/share/webshells/php/php-reverse-shell.php.

## Filtering

Client-side filtering – obviously easy to bypass!

Server-side filtering – take your best guess at a conforming upload.

Common types of filtering:

- File extensions
- MIME types (pulled from HTTP headers)
- Magic number validation (checks the first 16 bytes of a file; much harder to bypass)
- File size
- File name (but typically files are renamed now, which can make finding an uploaded shell tricky)
- File content (the deep packet inspection of files!)

Apparently PHPv5 and higher has a poison null byte resistant extension filter.

- [The Poison Null Byte](https://cardboard-iguana.com/notes/poison-null-byte.html)
