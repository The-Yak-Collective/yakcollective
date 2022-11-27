---
title: 'TryHackMe: Pre Security'
date: 2021-09-16 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-16-tryhackme-pre-security.html
author: 100007
---

# TryHackMe: Pre Security

**author:** Nathan Acks  
**date:** 2021-09-16

# A Bit of Background on Linux

The first release of Linux was on September 17, 1991.

- [Linux (Wikipedia)](https://en.wikipedia.org/wiki/Linux)

# General/Useful Utilities

Quick-n-dirty Python 3 web server:

```
python3 -m http.server
```

# Processes 101

Selected Linux process signals:

- SIGTERM - Kill the process, but allow it to do some cleanup tasks beforehand
- SIGKILL - Kill the process - doesn’t do any cleanup after the fact
- SIGSTOP - Stop/suspend a process
