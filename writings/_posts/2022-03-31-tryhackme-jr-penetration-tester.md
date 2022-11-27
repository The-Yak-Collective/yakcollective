---
title: 'TryHackMe: Jr. Penetration Tester'
date: 2022-03-31 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-31-tryhackme-jr-penetration-tester.html
author: 100007
---

# TryHackMe: Jr. Penetration Tester

**author:** Nathan Acks  
**date:** 2022-03-31

# Nmap Live Host Discovery

## Subnetworks

NETWORK SEGMENT: A group of devices connected using a shared medium, such as a switch or wireless access port. A router controls one or more network segments.

ARP packets are bound to a subnet.

## Enumerating Targets

Handy nmap flags:

- `-iL` - Use a file for nmap’s scan targets.
- `-sL` - Show the hosts that would be scanned, but don’t actually do anything (except perhaps DNS resolution).
- `-n` - Don’t resolve host names using DNS (or do reverse DNS resolution).

Note that you can put ranges in any octet of an IP address; for example, 10.10.0-255.1-255 will scan 10.10.0.1 - 10.10.255.255.

## Nmap Host Discovery Using ARP

When called as the superuser, Nmap uses ARP for local host discovery and a combination of ICMP Echo, TCP SYN to 443, TCP ACK to 80, and ICMP Timestamp requests for remote host discovery.

When called as a normal user, Nmap has more limited options and uses TCP SYN packets sent for ports 80 and 443 for both local and remote host discovery.

Note that even though this Nmap calls host discovery a “ping scan”, ping requests (ICMP echo) are only used in one particular case. Nmap does not perform host discovery when provided with a list of targets (`-iL`).

- `-sn` - Host discovery only.
- `-PR` - Use ARP packets only for host discovery.

A specialized tool for doing ARP scans is (appropriately enough) `arp-scan`. Use `arp-scan -l` to scan the entire local network, and `arp-scan -I $IFACE -l` to scan only the network available on interface `$IFACE`.

- [Host Discovery (Official Nmap Project Guide)](https://nmap.org/book/man-host-discovery.html)

## Nmap Host Discovery Using ICMP

- `-PE` - Use ICMP Echo for host discovery. (Note that Nmap will still not send the echo request if host existence can be verified using the initial ARP request.)
- `-PP` - Use ICMP Timestamp for host discovery. (Less likely to be blocked by firewalls than `-PE`, but also a more unusual request that may stand out. Like `-PE`, Nmap will still not send the timestamp request if host existence can be verified using the initial ARP request.)
- `-PM` - Use ICMP Address Mask for host discovery. (More-or-less the same as `-PP`, just a different ICMP request type.)

## Nmap Host Discovery Using TCP and UDP

- `-PS` - Use TCP SYN packets for host discovery. Uses port 80 by default, or you can specify a port list (e.g., `-PS80,8080,8888`) or range (e.g. `-PS20-30`). (Note that unprivileged users _must_ complete a full TCP handshake.)
- `-PA` - Use TCP ACK packets for host discovery; otherwise the same as `-PS`.
- `-PU` - Use UDP packets for host discovery. Unlike other types of host discovery scans, UDP scans only generate a reply (ICMP Port Unreachable) if the target port is _closed_.

The `masscan` utility is basically a _very_ aggressive TCP/UDP scanner. Probably too noisy to use in practice.

## Using Reverse-DNS Lookup

- `-R` – Perform reverse DNS resolution even for offline hosts.
- `--dns-servers` - Specify DNS server(s) to use for hostname resolution and reverse lookups.
