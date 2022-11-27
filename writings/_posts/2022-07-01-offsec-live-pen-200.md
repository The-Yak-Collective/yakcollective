---
title: 'OffSec Live: PEN-200'
date: 2022-07-01 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-07-01-offsec-live-pen-200.html
author: 100007
---

# OffSec Live: PEN-200

**author:** Nathan Acks  
**date:** 2022-07-01

Today’s session is more interactive/follow-along, which I’m not able to do because I’m not actually a PEN-200 student. But they’re having _a lot_ of technical problems, so many fewer notes than normal.

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [OffSecOfficial Twitch Channel](https://www.twitch.tv/offsecofficial)

# Reverse vs. Bind Shells

Another way of thinking of reverse vs. bind shells - who’s serving the local shell? _That’s_ the system that’s being attacked. Look at the _other_ system: If that system is listening then it’s a reverse shell, and if it’s connecting out then it’s a bind shell.

# Burp Suite

In the Burp Suite Intruder, you can use the “Recursive Grep” to extract the values from the _previous_ request to use in the current request. Note that this is not compatible with using multiple threads.

