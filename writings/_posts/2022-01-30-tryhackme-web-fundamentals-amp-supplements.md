---
title: 'TryHackMe: Web Fundamentals &amp; Supplements'
date: 2022-01-30 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-30-tryhackme-web-fundamentals-and-supplements.html
author: 100007
---

# Tools’R’us

[See my Tools’R’us CTF write-up.](https://cardboard-iguana.com/notes/tryhackme-tools-r-us.html)

# Python Basics

## Mathematical Operators

I always forget that `**` is exponentiation in Python (so weird!).

## Loops

Remember that in Python, `for` loops are used to iterate over arrays. Use `range()` to create an array of sequential integers (note, however, that Python is zero-indexed, so `range(10)` wil produce the array `[0, 1, ..., 8, 9]`).

## Introduction to Functions

Use the `str()` function to coerce variables to strings (Python doesn’t do this for you automatically).

## Files

Note that `read()`, `write()`, and `close()` are methods of the file object class, and _not_ globally accessible functions! (So, `file_handle.read()`, _not_ `read(file_handle)`!)

The `readlines()` _method_ takes a previously opened file handle and converts it to an array (where each element is a newline-separated string from the file).

# SQL Injection

## How to Detect SQLi?

SQLi is most common in PHP-based apps.

If inputting a single quote (though remember that there are _three_ kinds you need to test!) into an input causes an error, then you _probably_ have SQLi (though be aware that in some cases you will need to inject into multiple fields).

- [TryHackMe: Web Fundamentals](https://cardboard-iguana.com/notes/tryhackme-web-fundamentals.html)

## Error Based SQLi

Error-based SQLi retrieves data from the backend by abusing error messages. This obviously requires that error messages are shown to the end user, and is limited to information gathering.

Note that when inputting SQL statements as GET variables, it will often be necessary to end them with “` --+`” rather than “` -- `”, as browsers tend to eat the trailing space rather than encoding it as `%20`.

## Boolean Based SQLi

Boolean-based SQLi involves monitoring changes in responses to see if a query has executed or failed. The only reason you’d generally do this is if you’re doing SQLi blind (where you don’t get any output, or the output you do get isn’t strongly coupled with the input query).

Obviously, this requires that either the HTTP response code or payload changes depending on the results of the injection… (Some frameworks try to make blind SQLi difficult by using redirects, but it’s possible – though a pain – to get around this with Burp Suite).

One way this can be useful more generally is by using something like `AND (SELECT COUNT(*) FROM table_name) > 0` to probe for the existence/use of `table_name` (see this tutorial for a non-malicious use case of this construction).

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)
- [MySQL Subquery](https://www.mysqltutorial.org/mysql-subquery/)

## Union Based SQLi

Union-based SQLi is basically just abusing the SQL UNION keyword. This is made slightly easier by the fact that (at least in MySQL) you can SELECT based on a column’s name _or_ position.

Note, however, that referencing columns by positions is deprecated now in the SQL standard, and is gradually being removed from various server implementations.

This means that to determine the number of columns in a table, you’ll need to use a sequence of UNION clauses until you run into and error.

- `' UNION SELECT NULL -- `
- `' UNION SELECT NULL, NULL -- `
- `' UNION SELECT NULL, NULL, NULL -- `
- …and so on until there’s an error…

A similar approach can be used to detect column types.

- `' UNION SELECT 'a', NULL, NULL -- `
- `' UNION SELECT NULL, 'a', NULL -- `
- `' UNION SELECT NULL, NULL, 'a' -- `
- …and so on…

The generalization to other data types is straight-forward.

Note that sometimes a developer might get “clever” and try to error out on trailing comments. If you suspect that’s happening, just add something after the trailing ` – ` – it’s all a comment, after all!

Useful MySQL keywords:

- `database()`
- `user()`
- `@@version`
- `username` (if that column exists in some table)
- `password` (if that column exists in some table)
- Various table name…
- Various column names…

There’s really just _a lot_ of educated guessing that goes on in SQLi…

## Automating Exploitation

Apparently sqlmap isn’t allowed on the OSCP…

Useful commands:

- `--url`: Set the target URL
- `--dbs`: List all databases
- `--dump`/`--dump-all`/`--all`: Dump database
- `--os-shell`: Attempt to obtain working shell on the target
- `--batch`: Do not prompt for input
- `--dbms`: Choose the back-end DBMS (MySQL, PostgreSQL, etc.), if known
- `--passwords`: Attempt to obtain user password hashes
- `--os-pwn`: Attempt to pop a meterpreter shell
- `--risk`: Set maximum risk level of tests (1 - 3)

One handy way to seed a URL is using requests harvested with Burp Suite.

- [Using “sqlmap”](https://cardboard-iguana.com/notes/sqlmap.html)
- [Using Metasploit](https://cardboard-iguana.com/notes/metasploit.html)
- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)
