---
title: 'TryHackMe: Complete Beginner (Supplements)'
date: 2021-11-27 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-27-tryhackme-complete-beginner-supplements.html
author: 100007
---

# Wireshark 101

## ICMP Traffic

ICMP traffic “types” correspond to the kind of packet being sent (though different ICMP services can have multiple types):

- 0 - Ping reply
- 8 - Ping request

See RFC 792 for the gory details.

Ping packets typically just include either random data or all zeros.

- [RFC 792: Internet Control Message Protocol](https://datatracker.ietf.org/doc/html/rfc792)

## TCP Traffic

The TCP “acknowledgment number” contains the _next_ sequence number that the sender is expecting to receive (so basically senders determine the next sequence number). This is 0 in the case of RST packets (and other errors?).

See RFC 793 for more.

- [RFC 793: Transmission Control Protocol](https://datatracker.ietf.org/doc/html/rfc793)

## DNS Traffic

Apparently DNS over TCP is sufficiently rare in the wild as to always warrant further investigation.

## HTTP Traffic

HTTP does not use handshakes (beyond the standard initial TCP handshake); it’s all request/response (a bit like ICMP that way).

Wireshark can actually save off webpages and other files transmitted over HTTP using File \> Export Objects \> HTTP. Neat!

Also worth checking out some of the tools in the Statistics menu; TryHackMe specifically calls out Protocol Hierarchy and Endpoints, but I think I need to see some practical examples of these in action to really grasp their utility.

## HTTPS Traffic

HTTPS traffic starts out with an SSL handshake. All application data after the handshake is completed will be encrypted, but if you _happen_ to have the server’s private key then Wireshark can display the decrypted contents.

- Import the key under Edit \> Preferences \> Protocols \> TLS \> RSA keys list.
- Make sure to fill in the (server) IP address, port, and protocol (there’s also a “password” field, if the key’s encrypted). Note that port and protocol a bit reversed from what you’d expect - for HTTPS, these values are `start_tls` and `http`, respectively.

Note that HTTPS is much more likely to break up data between packets than HTTP, so the ability to export files from the packet stream is much more useful here!

## Analyzing Exploit PCAPs

DCERPC is Windows Server’s RPC connection protocol.

DRSUAPI is Windows’ implementation of the “Directory Replication Service” protocol, which is used to keep domain controllers in sync.

- [DCE/RPC (Wikipedia)](https://en.wikipedia.org/wiki/DCE/RPC)
- [DRSUAPI](https://wiki.samba.org/index.php/DRSUAPI)

# Wifi Hacking 101

## The Basics: An Intro to WPA

Because I always get these confused:

SSID - The wireless network “display” name. BSSID - The MAC address of the access point currently being used. ESSID - A collection of BSSIDs representing a single network. More-or-less analogous to SSID (when used in the context of networks consisting of multiple access points).

From what I can tell, SSID and BSSID apply to single access points, while ESSID applies to an entire network of access points.

## Aircrack-NG: Let’s Get Cracking

```
aircrack-ng -b $BSSID -w $WORLDLIST_FILE $CAP_FILE
```

