---
title: 'TryHackMe: Pre Security (Supplements)'
date: 2021-09-26 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-26-tryhackme-pre-security-supplements.html
author: 100007
---

# Windows Event Logs

## Putting Theory Into Practice

Use XPaths with Get-WinEvent via the -FilterXPath switch. Unlike -FilterHashtable, -FilterXPath can be applied to files specified on the command line using -Path.

From Windows Net command executed to enumerate administrators:

> GOAL  
> Detect when a user runs the net command to enumerate the Administrators group, which could be indicative of adversarial reconnaissance activity.
> 
> STRATEGY  
> Monitoring of Windows event logs where @evt.id is 4799, @Event.EventData.Data.CallerProcessName is \*net1.exe and @Event.EventData.Data.TargetUserName is Administrators.

- [Windows Net command executed to enumerate administrators](https://docs.datadoghq.com/security_platform/default_rules/windows-event-net-cmd-local-admin-enumeration/)

# MITRE

## Basic Terminology

TTP stands for “Tactics, Techniques, and Procedures”, where:

- “Tactics” are goals.
- “Techniques” are the methods used by the adversary to achieve its goals.
- “Procedure” is the actual nitty-gritty of how a technique is executed.

So, something like “obtain access to a domain controller, using exploit X, delivered via a malicious attachment.”

(I mostly say all of this to remind myself that these terms are being used in a slightly different fashion than my current workplace, which would probably use “goals, tactics, techniques” to represent the same steps.)

## ATT&CK Framework

“ATT&CK” stands for “Adversarial Tactics, Techniques, and Common Knowledge”.

- [MITRE ATT&CK](https://attack.mitre.org)

## CAR Knowledge Base

“CAR” stands for “Cyber Analytics Repository”.

The ATT&CK Navigator tool highlights analytics currently available in CAR using blue.

- [MITRE Cyber Analytics Repository](https://car.mitre.org/)

## ATT&CK Emulation Plans

Also known as “AEP”.

The MITRE AEPs are kinda hard to find:

- [APT3](https://attack.mitre.org/resources/adversary-emulation-plans/)
- [APT29](https://github.com/center-for-threat-informed-defense/adversary_emulation_library/tree/master/apt29)
- [FIN6](https://github.com/center-for-threat-informed-defense/adversary_emulation_library/tree/master/fin6)
