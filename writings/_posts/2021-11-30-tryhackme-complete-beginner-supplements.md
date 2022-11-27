---
title: 'TryHackMe: Complete Beginner (Supplements)'
date: 2021-11-30 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-30-tryhackme-complete-beginner-supplements.html
author: 100007
---

# TryHackMe: Complete Beginner (Supplements)

**author:** Nathan Acks  
**date:** 2021-11-30

# CC: Pen Testing

## Metasploit Modules

Search for modules using `search`.

Module options can be displayed with the `options` command (once a module is loaded). Use `advanced` for “advanced” options.

Most modules support the ARCH and PAYLOAD options (for specifying target architecture and the payload to deliver). These options can also be set by directly calling a fully-specified payload.

- [Using Metasploit](https://cardboard-iguana.com/notes/metasploit.html)

## Meterpreter

Sometimes the `migrate` process will allow you to move laterally or even escalate privileges within a system.

Some more commands:

- The `execute` command allows host commands to be executed from within Meterpreter.
- The `search` command acts similarly to the NIX “find” command.
- Use `cat` to dump a file’s contents.

## Hashcat

Hashcat mode 100 corresponds to SHA1; 900 is MD4.

## SQLMap

`-u URL`/`--url=URL` - process URL (this _must_ include the query parameters _with values_ to test _or_ you must specify POST parameters _with values_ using `--data`)

`-p` - which URL parameter(s) (variables) to test

`--dbms=DB_TYPE` - only use injections for a given type of backend database (MySQL, PostgreSQL, etc.)

`-D`/`-T`/`-C` - select a specific database/table/column to dump

`--dump` - dump data

`--os-shell` - attempt to spawn an interactive shell

`--os-pwn` - attempt to spawn a Meterpreter shell or VNC session

- [Using Metasploit](https://cardboard-iguana.com/notes/metasploit.html)

## A Note on Manual SQL Injection

[OWASP actually has a good tutorial for SQL injection attacks.](https://owasp.org/www-community/attacks/SQL_Injection)

## Web Application SQL Injection Vulnerabilities

- `--forms` - parse target URL for forms, and use these
- `--dbs` - enumerate DBs
