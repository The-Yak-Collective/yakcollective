---
title: 'TryHackMe: Jr. Penetration Tester (Supplements)'
date: 2022-05-09 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-05-09-tryhackme-jr-penetration-tester-supplements.html
author: 100007
---

With the course work for the Security+ exam out of the way, it’s time to turn back to all of the “supplements” I picked up along the way while working through the TryHackMe Jr. Penetration Tester sequence. Today:

- [TryHackMe: Red Team Engagements](https://tryhackme.com/room/redteamengagements)
- [TryHackMe: Firewalls](https://tryhackme.com/room/redteamfirewalls)

## Defining Scope and Objectives

New term:

- White Card: A simulated event during a penetration test; these are used when there’s a desire to determine the impact of the exploitation of a system without actually performing the initial exploitation (because the system is fragile, mission critical, etc.).

Reference:

- [Penetration Testing Vocabulary](https://security.stackexchange.com/a/114788)

## Rules of Engagement

The “rules of engagement” are basically the legally formalized (and binding) form of the test’s scope and objectives. _Not_ a formal campaign plan.

## Mission Plan

The difference between an “operation plan” and a “mission plan” is one of audience: The former is externally-facing (clients), while the latter is internally facing (red team members).

## Introduction: Firewalls

- [Service Name and Transport Protocol Port Number Registry](https://www.iana.org/assignments/service-names-port-numbers/service-names-port-numbers.xhtml)

## Types of Firewalls

Types of firewalls:

- Packet-Filtering Firewall (a.k.a., “Stateless inspection Firewall”)
- Circuit-Level Gateway (adds awareness of the TCP handshake)
- Stateful Inpection Firewall (tracks sessions, so we’re getting into layer 5)
- Proxy Firewall (a.k.a., “Web Application Firewall”; inspects packet contents)
- Next-Generation Firewalls
- Cloud Firewall (a.k.a., “Firewall as a Service”; obviously used the protect cloud-based applications/networks)

Traditional firewalls cover OSI layers 2 - 4 (data link, network, and transport), while “next-gen” firewalls _additionally_ cover layers 5 - 7 (session, presentation, and application).

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

## Evasion via Controlling the Source MAC/IP/Port

Nmap firewall evasion techniques:

- Decoy (`-D`) - mix in false source addresses in a round-robin fashion; use `ME` to fix the position of the actual scanner, and `RND` to inset a random IP.
- Proxy (`--proxies`) - use an HTTP or SOCKS4 proxy; specifying multiple proxies will create a chain.
- MAC address spoofing (`--spoof-mac`) - use a false MAC address; only works when on the same network segment as the target (so that Nmap can capture the results).
- IP address spoofing (`-S`) - same as the above, but for IP addresses.
- Fixed source port number (`-g`) - use the specified source port number, rather than a random source port.

Nmap SYN scan packets are by default 44 bytes = 20 bytes IP header + 24 bytes TCP header + 0 bytes data.

An Nmap SYN scan will send ~2x the number of packets as scanned ports, as all unresponsive ports are sent a second packet to verify that they’re actually closed (and, in general, most ports will be closed).

- [Nmap](https://cardboard-iguana.com/notes/nmap.html)

## Evasion via Forcing Fragmentation, MTU, and Data Length

Fragmenting packets in Nmap will generally let them get through a firewall _if_ the firewall is not itself reassembling packets. Note this means that fragmenting packets to 8 bytes results in packets that are 28 bytes long. Use `-f` to fragment packets to 8 bytes, `-ff` to fragment packets to 16 bytes, or `--mtu` to fragment packets into a chosen multiple of 8.

Fragmentation can lead to uneven packet sizes (in particular, the final fragment may be shorter than the others). Nmap will produce packets of a specified length (again, a multiple of 8) when called with `--data-length`; enough random bits will be added to the packet data field to ensure that the final packet is the same length as all the others. (You can also use this option to add random data to normal Nmap TCP packets by specifying a length greater than 24 bytes; note again that the IP header is uneffected.)

## Evasion via Modifying Header Fields

- `--ttl` - set a custom TTL.
- `--ip-options` - specify the IP “Options” field as either a string of hex-encoded bytes (`\x00`, etc.) or _one_ of the shortcut options `R` (record-route), `T` (record-timestamp), `U` (`R` _and_ `T`), `L` (loose source routing), and `S` (strict source routing); both `L` and `S` must be followed by a space-separated list of IP addresses to route the packet through (the entire sting must be quoted), and are used to route around security appliances.
- `--badsum` - send a packet with an intentionally bad checksum; whether or not the packet is dropped will depend on the system being scanned.

## Evasion Using Port Tunneling

Port forwarding with netcat (requires `-c` to be available):

```
nc -lvnp $INCOMING_PORT -c "nc $TARGET_IP $TARGET_PORT"
```

- [Using “netcat”](https://cardboard-iguana.com/notes/netcat.html)

## Evasion Using Non-Standard Ports

Sometimes the netcat binary is named `ncat` instead of `nc`…

- [Using “netcat”](https://cardboard-iguana.com/notes/netcat.html)
