---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-03-29 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-29-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

## Network Security - Segmentation

A hub is a Layer 1 device - it’s just a multi-port repeater.

VLAN logic is applied to Layer 2 - they’re basically a way of dividing up the ports on a switch (this makes me feel better about how I’ve been using them at work…). Data is routed between VLANs by the router (i.e., at Layer 3).

While the canonical DMZ has a firewall on both the north and south side, in practice only a single firewall is generally used. Other terms for a DMZ:

- Perimeter network
- Screened subnet
- “Neutral Zone” (per Dan Lowerie 😜)

Think of an extranet as a _purposeful_ network of intranets. Normally this is achieved via VPN connections.

North/South traffic can be thought of as traffic that crosses a security boundary (and thus should be touched by a router/firewall), while east/west traffic is traffic _within_ the security perimeter.

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

## Network Security - VPNs

Broad types of VPNs:

- Remote Access VPN: Secures communications between individual clients and the home network.
- Site-to-Site VPN: Connects two routers, typically from remote networks (branch offices) to the home network (main office).

VPN tunneling protocols:

- PPTP (TCP 1723) - Widely supported, but has weak encryption (Microsoft Point-to-Point Encryption).
- L2TP (TCP 1701 + UDP 500/4500) - Widely supported with strong security (IPSec + AES with certificates), but has bad performance and problems traversing firewalls
- SSTP (TCP 443) - Can traverse firewalls, but is Windows-only (and SSL 3.0 only!)
- IKEv2 (UDP 500/4500) - Good mobile/roaming support with strong security (IPSec + AES with certificates), but support is generally limited to mobile devices and it problems traversing firewalls

VPN concentrators are falling by the wayside, as this functionality is typically built into next-generation firewalls.

- [Point-to-Point Tunneling Protocol (Wikipedia)](https://en.wikipedia.org/wiki/Point-to-Point_Tunneling_Protocol)
- [What Is SSTP?](https://www.proofpoint.com/us/threat-reference/sstp)

## Network Security - Proxies And Load Balancing

These days, proxies are mostly about controlling _access_ to resources. They are particularly important for logging purposes.

Forward proxies handle outbound traffic _to_ external networks.

Reverse proxies handle inbound traffic _from_ external networks.

Load balancers help distribute load, and in doing so help ensure availability. Types of load balancers:

- Active/Active: All interfaces are up. Mostly about performance.
- Active/Passive: Some interfaces are held in reserve and become active if an active interface fails. Mostly about ensuring availability.

Servers behind a load balancer can also be set up in active/active or active/passive fashion. Additionally, active servers are typically accessed (“scheduled”) in one of two ways:

- Round Robin: Backend servers are accessed in sequence.
- Least Connection: Backend servers are accessed depending on current usage, so that as a server becomes less busy it becomes _more_ likely to serve a request. Helps spread load out when dealing with a large number of heterogenous requests.

Both of these access methods can be weighted in various ways.

## Network Security - Port Security

This is about the security of _physical_ switch ports.

Spanning Tree Protocol (STP) is used to protect against looping and packet storms. Basically, in STP switches will communicate to elect a “root node”, and then build a tree of reachable switches from that node. Ports are dynamically disabled as necessary when loops are detected.

STP operates using BPDU (Bridge Protocol Data Unit) frames. To stop malicious BPDU frames, BPDU guard marks certain ports as privileged (those connected to other, legitimate, switches), and rejects BPDU frames on all other ports.

Another security measure implemented on switches (though it’s not really a Layer 2 security protocol) is DHCP snooping. This is similar to BPDU guard, in that a privilege port is identified where the legitimate DHCP server is connected, and makes sure that server packets to and from unauthorized ports are blocked.

Switches can also do MAC address filtering (like wireless networks), and even restrict particular MAC addresses to particular ports.

Some switches can also mirror ports (sometimes also called “port spanning”) for monitoring purposes.

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

## Network Security - Firewalls

Stateless firewall = Packet filtering firewall (source, destination, port)

Stateful firewall = Dynamic packet filtering firewall (monitors connection requests)

Stateful firewalls keep track of connection state, and can block SYN flood attacks, etc.

Next-gen firewalls can deal with more OSI layers than just 3 - all the way up to the application layer.

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

## Network Security - NIDS And NIPS

NIDS (Network Intrusion Detection Systems) and NIPS (Network Intrusion Prevention Systems) are generally built into next-gen firewalls.

Detection methods:

- Signatures - Database of known hashes, IoCs, etc.
- Heuristics - Pattern matching
- Behavioral - Looks for known malicious behaviors (basically plussed-up heuristics)
- Anomalies - Detects changes relative to an observed baseline

# TryHackMe: Jr. Penetration Tester

## Passive vs. Active Recon

Passive recon concerns information we can gather _without_ interacting with our target. This is generally publicly available information, such as DNS records, social media posts, etc.

Active recon involved interacting with the target in some way. Connecting to systems, browsing their website, physical penetration of their facilities, etc.

## Whois

WHOIS responses include name server information (in the aptly-named “Name Server” field(s)).

## nslookup and dig

`nslookup` = Name Server Look Up

```
# nslookup command syntax; only $DOMAIN is required
#
nslookup -type=$QUERY_TYPE $DOMAIN $NAME_SERVER

# Examples
#
nslookup -type=A microsoft.com 8.8.8.8
nslookup tryhackme.com 1.1.1.1
nslookup -type=MX google.com
```

`dig` = Domain Information Groper

```
# dig command syntax; only $DOMAIN is required
#
dig @$NAME_SERVER $DOMAIN $QUERY_TYPE

# Examples
#
dig @8.8.8.8 microsoft.com A
dig @1.1.1.1 tryhackme.com
dig google.com MX
```

## DNSdumpster

DNSdumpster is basically a search engine for domain data - type in a root domain, and get back (many of) its subdomains and other information. (In my testing DNSdumpster doesn’t always enumerate _every_ subdomain, though it certainly does a better job than guessing.)

- [DNSdumpster](https://dnsdumpster.com/)
