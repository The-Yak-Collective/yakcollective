---
title: 'OffSec Live: PEN-200'
date: 2022-08-17 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-17-offsec-live-pen-200.html
author: 100007
---

OffSec Live returns today after taking a week off for DEF CON.

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [Join OffSec Live](https://learn.offensive-security.com/offsec-live-webinars)
- [DEF CON 30](https://defcon.org/html/defcon-30/dc-30-index.html)

# Windows Privilege Escalation

Recommended privilege escalation resource: g0tm1lk’s Blog.

The Windows Sysinternal’s Process Explorer is an important tool for Windows enumeration.

Use `net user $USERNAME` to get a lot of information about a given Windows user.

The `lsass.exe` process is responsible for all authentication on Windows - if you can gain access to this process, you basically own the box.

Processes running with a more highly permissioned user than your current user in Windows will not show CPU usage, path information, and other metadata. This is a quick-and-dirty way to locate potentially targets for exploitation.

Quick system information on Windows: `systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"`

Exploiting an unquoted service path on Windows is really only useful for services, since these are normally run as SYSTEM (and that’s what we want to escalate to).

To cross-compile binaries for Windows using Linux, use the `mingw-w64` tool.

Windows also has a `shutdown` command with _almost_ the same semantics as the equivalent \*NIX command.

- [g0tm1lk’s Blog](https://blog.g0tmi1k.com/)
- [Docs / Sysinternals / Downloads / Process Explorer](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer)
