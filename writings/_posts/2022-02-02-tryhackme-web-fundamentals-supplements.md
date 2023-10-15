---
title: 'TryHackMe: Web Fundamentals (Supplements)'
date: 2022-02-02 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-02-02-tryhackme-web-fundamentals-supplements.html
author: 100007
---

# Game Zone

## Obtain Access via SQLi

Another way to prevent the trailing space (after the comment marker “`--`”) from being eaten when trying to inject SQL is to add an additional character (i.e., “`-- -`”).

- [SQL Injection](https://cardboard-iguana.com/notes/sql-injection.html)

## Using SQLMap

SQLMap supports a handy `-r` flag that loads the request from a file. When using a request file there’s no need to specify a URL or post data, as this information is (obviously) included in the request. This is particularly handy if you’re trying to inject SQL on a page behind a login form, and thus need to present a session cookie.

The easiest way to generate a request file is to simply capture the request you want to use as the template for your attack with Burp Suite and then save it off to a file (you can use “Copy to file” from the right-click menu to do this).

- [Using “sqlmap”](https://cardboard-iguana.com/notes/sqlmap.html)
- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## Exposing Services with Reverse SSH Tunnels

`ss` is a `netstat`-like tool with slightly nicer formatting; `ss -tulpn` will produce a nice list of open ports.

- `-t` - Display TCP sockets
- `-u` - Display UDP sockets
- `-l` - Display listening sockets (not just established connections)
- `-p` - Show the process using the socket (broken?)
- `-n` - Show raw port numbers (not named services)

## Privilege Escalation with Metasploit

Oof. The key to successfully running the Metasploit module here is to remember that even if you’re exploiting a hidden service on the target over an SSH tunnel, the _exploit_ doesn’t know about that tunnel and will be connecting back to you over the regular network!

- [Using Metasploit](https://cardboard-iguana.com/notes/metasploit.html)

# Jurassic Park

[See my Jurassic Park CTF write-up.](https://cardboard-iguana.com/notes/tryhackme-jurassic-park.html)

