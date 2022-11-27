---
title: 'TryHackMe: Web Fundamentals'
date: 2022-01-25 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-25-tryhackme-web-fundamentals.html
author: 100007
---

# TryHackMe: Web Fundamentals

**author:** Nathan Acks  
**date:** 2022-01-25

# ZTH: Obscure Web Vulnerabilities (Part 2)

## IDOR Introduction

IDOR = Insecure Direct Object Reference

Basically, this is when a user’s access isn’t properly checked before displaying a resource. Think of all of those examples where (once authenticated) simply changing a URL parameter is enough to expose sensitive data

## Forced Browsing Introduction

Forced browsing is basically a species of IDOR (except that often you don’t even need to be authenticated). But in this case we’re just guessing (or brute forcing) URL paths to access server resources.

(The reason I’m maintaining that forced browsing and IDOR are basically equivalent is that URL paths are kinda arbitrary, and are often actually parameterized commands rather than literal paths these days. The difference between a URL parameter and the URL path is mostly just semantics in practice.)

## Forced Browsing Automatic Exploitation

wfuzz is a URL fuzzer – basically the command-line version of the Burp Suite Intruder (but it’s _much_ faster, which is what one would generally expect from a command-line tool).

- `-c` - Use color
- `-z` - Specify the wordlist that will replace FUZZ in the request

Basically, the word “FUZZ” in the URL will be replaced by elements of the wordlist specified by `-z`. Multiple slots can be specified using “FUZ2Z”, “FUZ3Z”, etc.

```
wfuzz -z file,rockyou.txt https://example.com/FUZZ/img/secret.jpg
```

Use `wfuzz --help` for a full list of options. The `--hc 404` option is particularly useful for hiding pages that return a 404.

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## API Bypass Exploitation

Basically, the idea here is that sometimes APIs (especially non-public ones!) are sloppy about checking user authentication or permissions. This is generally harder to work with than fuzzing a website directly (since you’re often “flying blind” when experimenting with the API), but can be even more powerful.

