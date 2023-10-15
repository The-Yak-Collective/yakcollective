---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-04-12 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-12-itprotv-comptia-security-plus.html
author: 100007
---

# CompTIA Security+ Exam Cram

Today’s reading is Chapter 30 from the Security+ Exam Cram, “Digital Forensics”.

## Order of Volatility

The idea here is to gather evidence from the most volatile storage (generally RAM) to the least volatile (generally backups or off-system logs). Prioritize imaging/copying/investigating storage so that you run the minimum risk of loosing information!

First-line information:

- System date, time, etc.
- Currently established network connections
- Currently open ports and associated applications/services
- Other running applications/services

Typical order of volatility:

- CPU registers/caches
- Peripheral & expansion card memory (particularly networking cards)
- Kernel memory
- Non-kernel memory
- tmpfs & friends
- Onboard storage
- Removable rewritable storage
- Removable write-once storage

I’m guessing that external logs probably sit between removable rewritable storage and removable write-once storage.

## Chain of Custody

Basically, log all the things. Time, date, action, people involved. Include thought processes and inferences. Properties:

- Admissible (following legal or organizational standards)
- Authentic (shown to be related to the investigation at hand)
- Complete (covers all angles - for example, _all_ users logged into a system, not just accounts of interest)
- Reliable (shown to be unmodified)
- Believable (basically, written in a way that non-technical audiences can follow)

Investigative steps:

- Identify potential evidence
- Determine preservation techniques
- Extract, process, log, interpret, etc.
- Clean up for presentation (corporate or legal)

## Data Acquisition

- System Images (be careful to ensure that these cannot be inadvertently written to during analysis!)
- Network Traffic & Logs (traffic is generally only captured in the event that the incident is ongoing when the investigation begins)
- Video & Photographs (the point here is to try to demonstrate that evidence was not planted)
- System Time & Time Zone (important to record early because computers use all sorts of different time zones)
- Hashes (to verify that forensic images are the same as the original data, and that data has not been changed during analysis)
- Screenshots
- Witnesses
