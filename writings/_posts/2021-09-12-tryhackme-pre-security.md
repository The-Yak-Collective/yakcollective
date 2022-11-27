---
title: 'TryHackMe: Pre Security'
date: 2021-09-12 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-12-tryhackme-pre-security.html
author: 100007
---

# TryHackMe: Pre Security

**author:** Nathan Acks  
**date:** 2021-09-12

# What is Networking?

## Identifying Devices on a Network

The IPv4 address space has a size of 2³² (~4.29 billion), and addresses are typically represented as four octets (4 × 8 = 32).

IPv6 by contrast has a size of 2¹²⁸ (~340 trillion), with addresses typically represented as eight groups of sixteen (8 × 16 = 128). Of course, nobody wants to write things this long, so zero blocks are typically not written… (One thing I’d like to get out of this super-beginner course is a better sense of how to read IPv6 addresses!)

MAC (“Media Access Control”) are unique 48-bit identifying numbers burned into network cards. They are typically represented as six octets each composed of two hexadecimal numbers (0 - f). The first three octets designate the network interface vendor while the last three constitute device serial number. On most operating systems octets are separated using colons, but Windows uses dashes instead.

- UNIX-style MAC address - a4:c3:f0:85:ac:2d
- Vendor ID - a4:c3:f0
- NIC ID - 85:ac:2d
- Windows version of the same MAC address - A4-C3-F0-85-AC-2D

## Ping (ICMP)

ICMP stands for “Internet Control Message Protocol”.

Ping works by sending an ICMP echo packet to a target and then listening for the corresponding echo reply. The time it takes for ping to receive the echo reply from the target after generating the initial echo is what the `ping` command displays.

