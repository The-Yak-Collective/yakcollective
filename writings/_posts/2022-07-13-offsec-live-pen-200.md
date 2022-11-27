---
title: 'OffSec Live: PEN-200'
date: 2022-07-13 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-07-13-offsec-live-pen-200.html
author: 100007
---

# OffSec Live: PEN-200

**author:** Nathan Acks  
**date:** 2022-07-13

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [OffSecOfficial Twitch Channel](https://www.twitch.tv/offsecofficial)

# Netcat Port Scanning

Quick-n-dirty netcat port scan:

```
nc -nvv -w 1 -z $IP_ADDRESS $PORT
```

`$PORT` can be a port range; `-w 1` sets netcat’s timeout to 1 second. By default netcat performs a TCP scan in this mode; use `-u` to make UDP connections instead.

- [Using “netcat”](https://cardboard-iguana.com/notes/netcat.html)

# SNMP

_Always pay attention to SNMP._ (Which is an unfortunate directive, as I haven’t been paying attention…)

If SNMP v1 or v2 are being used, then the protocol is unencrypted; even if a custom community name has been set, it can be easily sniffed. Once the community name is known, devices can be queried with “MIB” strings.

Apparently Windows will report things like local users and installed antivirus information over SNMP!

The `onesixtyone` and `snmpwalk` tools can be used to probe SNMP. NMAP also has a set of useful SNMP-related scripts.

