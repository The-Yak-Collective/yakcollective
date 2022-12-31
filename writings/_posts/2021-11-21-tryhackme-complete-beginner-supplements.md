---
title: 'TryHackMe: Complete Beginner (Supplements)'
date: 2021-11-21 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-21-tryhackme-complete-beginner-supplements.html
author: 100007
---

# MAL: Researching

## Online Sandboxing

Online automated malware analysis sandboxes:

- [any.run](https://any.run/)
- [hybrid-analysis](https://hybrid-analysis.com/)

## Practical: Calculating & Reporting Checksums

Calculating file hashes with PowerShell!

```
# Using CertUtil
#
CertUtil -hashfile $FILE_PATH $ALGORITHM

# Using Get-FileHash
#
Get-FileHash -Algorithm $ALGORITHM $FILE_PATH
```

In both cases, the algorithm can be excluded (in which case SHA1 is used for CertUtil and SHA-256 is used for Get-FileHash). _Lots_ of different hashing algorithms are supported - run `help Get-FileHash`, etc. to see a list.

# MAL: Strings

## Practical: Finding Bitcoin Addresses in Ransomware

Blockchain exploration tool (search for hashes):

- [BlockCypher](https://live.blockcypher.com/)

(Not a lot of supported blockchains though…)

Fun side-note: PowerShell can use Linux-style redirects (`>`)!

# Google Dorking

## Enter: Search Engine Optimization

It looks like all of Google’s optimization tests live at web.dev now.

- [web.dev: Measure page quality](https://web.dev/measure/)

## BeepBoop - Robots.txt

I always forget that the `Sitemap` directive lives in `robots.txt`.

It turns out that most web crawlers support regexes in the `Allow`/`Disallow` statements. Also, directives for different crawlers can be given by using multiple `User-agent` directives (apparently a crawler will only use the first block that it matches up until a new `User-agent` directive).

## What is Google Dorking?

Useful Google search modifiers:

- `site:` - Limit results to the provided domain
- `filetype:` - Limit results to the provided file type (PDF, etc.)
- `intitle:` - Require that the page title contain particular keywords
- `cache:` - View the most recent cached version of a particular URL

# Wireshark 101

## Collection Methods

Ways to gather packets:

(1) Just listen to the packets that you can see normally (really only works on very simple/insecure networks).

(2) Physical taps (Packet Squirrel, LAN Turtle, etc.)

(3) MAC flooding (fill up a switch’s CAM table with bogus requests until it is forced to fall back to acting like a dum hub; somewhat dangerous).

(4) ARP poisoning (falsely advertise yourself as the router or another machine; less dangerous than MAC flooding but harder to successfully pull off).

- [Packet Squirrel](https://hak5.org/products/packet-squirrel)
- [LAN Turtle](https://hak5.org/products/lan-turtle)
