---
title: 'TryHackMe: Complete Beginner (Supplements)'
date: 2021-11-16 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-16-tryhackme-complete-beginner-supplements.html
author: 100007
---

# TryHackMe: Complete Beginner (Supplements)

**author:** Nathan Acks  
**date:** 2021-11-16

# Volatility

## Examining Our Patient

Volatility has been removed from Kali, but Volatility 3 is installable via pip. Unfortunately, the commands seem a bit different than what’s used in the TryHackMe: Volatility room.

Also, the provided memory dump is a vmem file, rather than the raw files mentioned in the room.

It looks like Volatility 3 no longer require “profiles”; instead, there are separate plugins for Windows, macOS, and Linux.

Of the three `*.pslist.PsList` plugins, only windows.pslist.PsList doesn’t error out, and the resulting output looks sane.

Unfortunately, this command doesn’t help us identify which Volatility 2 profile would have been used, which we need to know in order to answer the second question in this section. However, the `windows.info.Info` plugin lets us know that:

- The image is _not_ running a 64-bit OS.
- The MajorOperatingSystemVersion is 5.
- The MinorOperatingSystemVersion is 1.
- The NTBuildLab(el) is 2600.xpsp.080413-2111

Wikipedia’s Comparison of Microsoft Windows versions tells us that Windows 5.1.2600 is some version of XP, and googling the NTBuildLab pulls up a number of results that strongly suggest that this is Service Pack 3. However, The WinXPSP3x86 profile is _not_ the right answer - this section seems to want WinXPSP2x86 instead.

Another problem! Volatility 3 doesn’t include a psxview equivalent. I’m not sure how to replicate what the section wants me to do… I tried using the `windows.malfind.Malfind` plugin, and guessed that the process we want to look at is csrss.exe because its line is pretty different than the others (Tag, CommitCharge, and PrivateMemory all stand out). This turns out to be correct, but I’m unfortunately less sure about whether I’m picking up on real flag, or just made a lucky guess…

We also seem to be missing the ldrmodules and apihooks plugins, and googling around doesn’t turn up any obvious alternatives.

- [TryHackMe: Volatility](https://tryhackme.com/room/bpvolatility)
- [Malware Analysis: Memory Forensics with Volatility 3](https://newtonpaul.com/malware-analysis-memory-forensics-with-volatility-3/)
- [volatility / README.txt](https://github.com/volatilityfoundation/volatility/blob/master/README.txt)
- [Comparison of Microsoft Windows versions (Wikipedia)](https://en.wikipedia.org/wiki/Comparison_of_Microsoft_Windows_versions)
- [Volatility 3 Cheatsheet](https://blog.onfvp.com/post/volatility-cheatsheet/)

## Post Actions

Striking out again.

The right answer is “Cridex”, but neither the DLLs nor the process image of csrss.exe I extracted with Volatility 3 were flagged with this in VirusTotal or Hybrid Analysis (the best I got were Win32Evo-Gen and a whole bunch of heuristic matches). Digging in a bit deeper, it looks like none of these files match the extracted images pulled out by Volatility 2.

This is probably the worst I’ve done on one of these rooms - I’ve failed to meet many of the objectives, and I’m failing to understand _why_ I failed.

Maybe something’s up with my install of Volatility 3?

- [VirusTotal](https://www.virustotal.com)
- [Hybrid Analysis](https://www.hybrid-analysis.com)
