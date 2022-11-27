---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-03-28 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-28-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

**author:** Nathan Acks  
**date:** 2022-03-28

# CompTIA Security+ Exam Cram

Today I’ll be reading chapter 19 of the Security+ Exam Cram, “Secure Network Design”.

# Routers

Layer 3 device. Key protocols for manipulating routing tables:

- RIP (Routing Information Protocol)
- IGRP (Interior Gateway Routing Protocol)
- OSPF (Open Shortest Path First)
- BGP (Border Gateway Protocol)
- EGP (Exterior Gateway Protocol)
- IS/IS (Intermediate System-to-Intermediate System)

For networking purposes an ACL is any traffic control rule.

IP spoofing can be prevented by denying access to private IP addresses _from_ the internet, and mitigated by protocol authentication mechanism.

Something that isn’t done enough (and I’m as guilty as anyone) is default deny for both inbound and _outbound_ traffic.

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

# Network Address Translation (NAT)

I’ve always though of NAT’ing as a router/firewall function, but apparently independent “network address translation gateways” are a thing.

Also, it seems that NAT breaks not only IPSec, but also DNSSEC. No TCP segment reassembly.

# Switches

Layer 2 devices; switching decisions are determined by MAC address rather than IP address (as with routers). That said, some “layer 3 switches” (basically fast, stripped-down routers) exist.

An interesting way to think about VLANs here: As separate broadcast domains.

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

# Port Security

“Port security” isn’t about IP ports, but rather about switch ports. Basically per-port MAC address filtering. There are three modes that a port can enter when port security is violated:

- In “protected mode”, the port still functions but frames from non-allowed MAC addresses are silently dropped.
- “Restricted mode” is identical, except that it generates log events.
- “Shutdown” or “error-disabled” shuts the port down entirely.

Port security mechanisms:

- BPDU (Bridge Protocol Data Unit) Guard: Flags interfaces as not accepting BPDU packets (which should only come from other switches).
- MAC Filtering
- Loop Detection: Interfaces are periodically probed using “loop packets”; if one of these packets makes it way back to the switch on a different port, then a loop exists and one of the ports is disabled.
- DHCP Snooping: Monitors DHCP requests on ports, and blocks offer and acknowledgement packets coming from client (“untrusted”) ports (the idea here is that the DHCP server is part of the network infrastructure).

Exam Cram indicates that port security questions are likely to be on the Security+ exam.

- [What is BPDU Guard and How to Configure BPDU Guard?](https://www.geeksforgeeks.org/what-is-bpdu-guard-and-how-to-configure-bpdu-guard/)
- [DHCP Snooping](https://www.geeksforgeeks.org/dhcp-snooping/)

# Virtual Local Area Network (VLAN)

Inter-VLAN routing is handled by layer 3 devices (both routers and “layer 3 switches”).

Each VLAN should be associated with a separate subnet, and subnets should be contiguous to improve memory efficiency.

There’s actually a “VLAN trunking protocol”, which I’m going to guess is what works over trunk ports.

Remember that VLANs are logical, so an attacker can forge packets for a VLAN they have access to.

# Bridges

Bridges forward packets from one network to another. Types:

- Transparent Basic (basically just a repeater)
- Source Routing (forwards traffic based on frame header information)
- Transparent Learning (routes traffic using a full routing table)
- Transparent Spanning (understands the subnet topology on both sides and actively works to prevent looping)

Spanning Tree Protocol (STP) is the main method for detecting loops and coordinating the activity of layer 2 devices. The key idea here is that switch ports continually transmit BPDUs; by default when a port stops receiving BPDUs, it enters into a forwarding state. However, this can create a loop if BPDUs were disrupted for some reason, so “loop guard” moves ports into a “loop inconsistent” blocked state instead.

Loop guard is the primary method used to protect STP.

# Security Devices and Boundaries

Stateless firewalls permit or deny packets based solely on their ACLs.

Stateful firewalls watch entire connections and make decisions based on the connection state.

For example, a stateless firewall might just forbid all inbound traffic except on certain ports. A stateful firewall, by contrast, might forbid all inbound traffic unless that traffic was initiated by a machine inside of its perimeter.

Most firewalls stop processing packets on the first rule match, which means that more narrowly scoped rules should be placed before more broadly scoped ones.

Most firewalls operate on an implicit deny model, for obvious reasons.

Networks can - and should - be segmented and restricted across multiple OSI layers, and these restrictions (including internal restrictions) should be applies internally in addition to at the perimeter.

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

# Screened Subnet

Apparently “screened subnets” is what we’re calling DMZs these days. Systems in a DMZ are accessible by both internal and external users, but only in a controlled fashion for both.

“East/west” traffic within a DMZ refers to traffic _between_ DMZ systems, while “north/south” traffic refers to traffic between a DMZ system and a system internal or external to the DMZ.

The entire idea behind a “screened subnet” / DMZ is to make sure that access to servers on that subnet is tightly controlled (though the servers should still obviously be hardened, as they _are_ more exposed).

Intranets broadly include internally-hosted websites and services. Extranets are externally-facing but websites and services for which access is limited to external partners. Typically intranets and extranets are protected by VPNs or firewall rules , _not_ simply by web-based login forms.

“Zero Trust” can basically be thought of as reducing the network perimeter to single resources + some level of continuous/dynamic authentication.

Typically there is a firewall on either side of screened subnet, rather than a single firewall handling all connections. Watch out for services that offer connections in _both_ directions across a firewall, and thus can be used to breach its protections (Exam Cram indicates that network storage devices are a common offender here).

Exam Cram recommends the use of _both_ built-in network-level encryption _and_ encrypted tunnels when using wireless networks.

Jump server = Bastion server

# Web Application Firewalls

WAFs can be considered to be a special case of “next generation firewalls”, which are simply application-aware firewalls. Generally next-gen firewalls incorporate some kind of IDS and/or IPS. They generally straddle OSI layers 3 - 7.

Certificates will need to be deployed to client systems if packet inspection of encrypted connections is desired (basically, having the next-gen firewall MitM all network traffic).

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

# Proxies

A proxy server is just a go-between from a network to the internet. Uses:

- Caching
- Content blocking
- Mobile device optimization

Transparent (inline/intercepting/forced) proxies don’t require any client configuration, existing inline between clients and the internet. They generally do not modify client requests.

Application proxies provide connections to specific applications (think POP or IMAP, not “Microsoft Office”). Web proxies are thus the subset of application proxies that deal with HTTP/HTTPS.

“Universal application-level gateways” are application proxies supporting multiple protocols. They often can handle IPv4-toIPv6 conversion as well.

Forward proxies control data originating on internal networks destined for the internet, and are typically used for security, content filtering, or privacy purposes. Reverse proxies control data originating from the internet destined for internal systems, and are typically used for load balancing and to enforce content inspection.

Sometimes proxies are placed in parallel with routers for load balancing purposes (HTTP/FTP through the proxy, all other traffic through the router).

# Unified Threat Management (UTM)

UTMs are basically next-gen firewalls with filters specifically geared towards spam, viruses, and malware. DLP and content filtering may also be provided by a UTM solution.

# VPN Concentrators

Apparently, “VPN concentrator” is just a fancy way of saying “VPN server tuned to handle a large number of simultaneous tunnels”.

Two VPN tunneling modes:

- Full: Everything is routed over the VPN.
- Split: Only some traffic is routed over the VPN.

# NIDS and NIPS

NIDS = Network Intrusion Detection System

In general, IDS operation is either “knowledge based” (pre-programed IoCs) or “behavior based”. Network- and host-based IDSes should be used together.

NIDS “sensors” are generally either network taps or log aggregators. IDS systems are by definition passive devices (a.k.a., “reactive” or “out-of-band”).

NIPS = Network Intrusion Prevention System

NIPS extend NIDS into active devices. As such, they need to be placed inline with the devices or network segments they are protecting. NIPS typically require access to application-layer data, and thus can be confounded by encryption (or require access to deployed certificates so that they can MitM connections effectively).

NIPS are typically deployed at the network perimeter, or at bottlenecks between network segments.

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

# Detection Methods

Signature/Knowledge-based detection look for pre-defined patterns of network behavior.

Behavior-based detections require a profile of “normal” activity to work, and then looks for broad deviations that may indicate compromise. Anomaly-based detections look for “point” anomalies that might indicate an active _current_ attack, but require much more information to do this effectively. (Typically, behavior-based detections are looking at basic protocol usage, data volume, and network usage patterns, while anomaly-based detections are examining actual protocol content). Both methods have the disadvantage of implicitly assuming that there is some period when the network is _not_ compromised.

Heuristic-based detections extend anomaly-based detection methods to all network traffic. Heuristic methods also work to generate their own rule sets, whereas anomaly-based methods are looking for any deviation from baseline.

# Network Access Control (NAC)

The idea behind a NAC is to profile computers joining a network and then provide (or deny) access to resources based on these results. Parts of a NAC:

- Access Requestor: The client requesting access to the network.
- Policy Decision Point: The system that determines what network access should be granted based on the requestor’s disposition.
- Policy Enforcement Point: The system actually in charge of enforcing the decision point’s determination. Typically a piece of network hardware such as a router, firewall, or switch.

Types of NAC:

- Inline: Typically located between a wireless access point and a switch.
- Out of Band
- Switch-Based: Same as inline, except integrated into the switch itself.
- Host/Endpoint-Based: Uses an installed agent on the host to assess and/or enforce policy (obvious disadvantages).

Host-based agents can be run-once affairs, in which case they are called “dissolvable” or “portal-based” agents.

“Agentless” solutions actually still use an “agent” of sorts, just one that’s built into the host operating system or web browser. IPS solutions can be _truly_ agentless, but obviously then have little visibility into the host’s true state.

