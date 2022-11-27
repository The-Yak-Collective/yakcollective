---
title: 'TryHackMe: Complete Beginner'
date: 2021-09-27 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-27-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-09-27

# Introductory Researching

## Vulnerability Searching

TryHackMe highlights three places to check for vulnerabilities:

- [ExploitDB](https://www.exploit-db.com/) (often contains _actual_ exploit code!)
- [NVD](https://nvd.nist.gov/vuln/search)
- [CVE Mitre](https://cve.mitre.org/)

Kali Linux contains a `searchsploit` tool that works over an offline copy of ExploitDB. So, probably not as up-to-date, but should work anywhere.

## Manual Pages

Apparently `man` will recognize when it’s being piped, so you can do things like this:

```
man ssh | grep -e "version number"
```

# Introductory Networking

## The OSI Model

OSI stands for “Open Systems Interconnection”; it is a seven-layer model that describes all parts of the network stack (though sometimes I’ve heard the user referred to as “layer 8”). The idea is that segmenting responsibilities by layer allows for more uniform network and device behavior.

- Layer 7: Application (highest)
- Layer 6: Presentation
- Layer 5: Session
- Layer 4: Transport
- Layer 3: Network
- Layer 2: Data link
- Layer 1: Physical (lowest)

Higher layers extend (“encapsulate”) lower layers.

A useful mnemonic: Anxious Pale Shakespeare Treated Nervous Drunks Patiently.

In practice, everything _actually_ uses the TCP/IP model (below).

The APPLICATION layer (7) determines how the user interacts with data. This is where, well, user-facing applications live.

More or less anything goes at the application layer.

The PRESENTATION layer (6) is where data standards live. What does an email look like? How is HTTP structured? Etc.

In general, this is the layer where security features like SSL are layered on.

The SESSION layer (5) is responsible for actually connecting two machines and transmitting the data between them. Data is transmitted in a “session” - a successful connection between two systems.

This is the layer where packets live.

The TRANSPORT layer (4) determines _how_ data is sent in a session. This is where TCP and UDP (as protocols) live.

TCP stands for “Transmission Control Protocol”.

UDP stands for “User Datagram Protocol”. One of the key aspects of UDP is that the _application_ layer gets to decide how quickly packets are sent in a given session. ARP and DHCP both operate over UDP.

The TCP transmission unit is the _segment_, while the UDP transmission unit is the _datagram_.

IMPORTANT NOTE: Sessions != connections! One session (a browser tab) may contain multiple connections (pipelined data).

The NETWORK layer (3) is where routers live at, and is where packets of data are assembled and disassembled.

Two key routing protocols:

- OSPF (Open Shortest Path First)
- RIP (Routing Information Protocol)

The network layer is (mostly) the one that uses IP addresses; typically it is in this layer that data is handed off from the computer to the larger network.

Logical addressing = IP addresses.

The DATA LINK layer (2) translates the logical (IP) addresses of the network layer into physical (MAC) addresses. If data needs to be re-arranged to deal with physical limitations of the network, it happens here (so this is where things like MTUs come into play). Layer 2 is also where (theoretically) data integrity checking occurs.

Because switches (generally) only care about MAC addresses, they live in this layer.

Physical addressing = MAC addresses.

The PHYSICAL layer (1) is where actual physical cabling lives - the layer of atoms and electricity.

I suppose that a hub would be a layer 1 device, since it’s just shuffling actual (electrical) packets.

## Encapsulation

```
+-----------+-------------+
Application -> Presentation | L7 Header | (User) Data |
+-----------+-------------+
+-----------+-------------------------+
Presentation -> Session | L6 Header | (Application) Data |
+-----------+-------------------------+
+-----------+-------------------------------------+
Session -> Transport | L5 Header | (Presentation) Data |
+-----------+-------------------------------------+
+-----------+-------------------------------------------------+
Transport -> Network | L4 Header | Segment/Datagram |
+-----------+-------------------------------------------------+
+-----------+-------------------------------------------------------------+
Network -> Data Link | L3 Header | Packet |
+-----------+-------------------------------------------------------------+
+-----------+-------------------------------------------------------------------------+------------+
Data Link -> Physical | L2 Header | Frame | L2 Trailer |
+-----------+-------------------------------------------------------------------------+------------+
+--------------------------------------------------------------------------------------------------+
Physical | Data Stream (Bits) |
+--------------------------------------------------------------------------------------------------+
+-----------+-----------+-----------+-----------+-----------+-----------+-------------+------------+
Layer 1 "X-Ray View" | L2 Header | L3 Header | L4 Header | L5 Header | L6 Header | L7 Header | (User) Data | L2 Trailer |
+-----------+-----------+-----------+-----------+-----------+-----------+-------------+------------+
```

_Packets_ live in layer 3 (network). _Frames_ live in layer 2 (data link).

While most layers simply add a header, be aware that the data link layer _also_ adds a trailer (more integrity checking).

## The TCP/IP Model

A four-layer alternative to OSI!

```
+--------------+-------------------+
| OSI LAYER | TCP/IP LAYER |
+--------------+-------------------+
| Application | |
+--------------+ |
| Presentation | Application |
+--------------+ |
| Session | |
+--------------+-------------------+
| Transport | Transport |
+--------------+-------------------+
| Network | Internet |
+--------------+-------------------+
| Data Link | |
+--------------+ Network Interface |
| Physical | |
+--------------+-------------------+
```

As with OSI, each layer adds its own headers, though obviously there are fewer of these with TCP/IP (i.e., in the real world).

The TCP/IP model (which comes out of the DOD’s work on ARPANET) actually pre-dates the OSI Model (an ISO standard, and it feels that way) by a few years. The TCP/IP application layer subsumes OSI layers 5 - 7, while the network interface layer includes OSI layers 1 and 2 (though some - unofficial! - versions of the TCP/IP model forgo the network interface layer in favor of OSI’s data link and physical layers).

Key TCP headers:

- Time to Live (TTL) - How long a packet should live on the network before being discarded.
- Source port - A random (unused) port chosen by the sender.
- Destination port - The port on the receiving end, which normally is determined by the application being used.
- Source address - “From” IP address.
- Destination address - “To” IP address.
- Sequence number - A random number that identifies a given connection.
- Acknowledgement number - Starts at the sequence number and then increases by one for each packet sent. Used to ensure that no data is lost, and that packets are reassembled in the right order.
- Checksum - Integrity check.
- Data - The, well, data.
- Flag(s) - How the packet should be handled (SYN, ACK, FIN, RST, etc.).

Key TCP flags:

- SYN - Initialize connection.
- SYN/ACK - Acknowledge connection initialization (not an _actual_ flag, but rather a SYN flag + an ACK flag).
- ACK - Acknowledge packet receipt.
- DATA - Actual connection data (not sure if this is _actually_ a flag).
- FIN - End connection.
- RST - Error.

TCP’s “three way handshake” opens a connection by establishing a random sequence number.

- Client sends SYN with an initial sequence number (ISN).
- Server sends a SYN/ACK - its own ISN as well as the client ISN + 1.
- The client sends an ACK of the server ISN + 1.

(Unfortunately, it’s still a little unclear to me how to think about the progression of sequence and acknowledgement numbers over the course of an entire connection. I did a little more searching around, but the other examples I’ve found are even more abbreviated and/or obtuse.)

Closing the connection uses a “four way handshake”: Client FIN \> Server ACK \> Server FIN \> Client ACK

- [Transmission Control Protocol (Wikipedia)](https://en.wikipedia.org/wiki/Transmission_Control_Protocol)

## Ping

ICMP is actually a TCP/IP protocol that works on the internet layer.

## Traceroute

Windows uses `tracert.exe` (over ICMP) instead of `traceroute` (over UDP) on UNIX; the default protocol on both operating systems can be switched on the command line, however.

It’s also possible to have traceroute use TCP SYN flags for probing (-T).

## Dig

13 root domain server (IP addresses) to rule them all.

When you’re “registering” a domain, what you’re actually doing is registering a “second-level domain” (as distinct from TLDs like .net, .co.uk, etc.).

Second-level domains are limited to 63 characters composed of a-z, 0-9, and “-“. Hyphens cannot start or end a domain (the TryHackMe module states that consecutive hyphens are not allowed, but this doesn’t seem to be true anymore given how internationalized domains are represented with Punycode).

Subdomains follow the same rules as second-level domains. While in theory an unlimited number of subdomains are allowed, the entire domain string must be 253 characters or less, which would seem to impose a hard cap of 124 subdomains (assuming that the shortest TLD is two characters; if there’s a one-character TLD out there, then the hard cap is at 125 subdomains).

Technically TLDs are _not_ actually the top of the domain hierarchy - that would be the root domain, which is simply “.”. FQDNs should contain this trailing dot, which is why you need to include it when setting up CNAME entries and the like in DNS. (The purpose of the final “.” Is similar to that of the leading “/” in paths - /foo/bar/baz is an absolute path starting at the file system root, but foo/bar/baz is a path relative to the current directory. The domain baz.bar.foo. is the DNS equivalent of /foo/bar/baz.)

The second column of dig’s ANSWER section (so, right after the domain part, and before the IN) provides the current _remaining_ TTL in seconds (so this counts down from the actual TTL).

- [Domain name (Wikipedia)](https://en.wikipedia.org/wiki/Domain_name)
- [Internationalized domain name (Wikipedia)](https://en.wikipedia.org/wiki/Internationalized_domain_name)
