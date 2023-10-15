---
title: 'TryHackMe: Complete Beginner'
date: 2021-09-28 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-28-tryhackme-complete-beginner.html
author: 100007
---

# NMAP

Interesting (but makes sense)… Each connection a web browser makes corresponds to a different local port (so, $RANDOM\_PORT -\> 443).

Something I know but am always forgetting: There are 65,535 (2¹⁶ - 1) available ports (port 0 is a special system port). The first 1023 of these (1024 counting port 0) are reserved as “well known” ports, but the remainder are accessible without special privileges.

## Nmap Switches

Typically nmap will need to be run with the -vv flag in order to produce suitably verbose output for pen testing.

The -oA BASENAME flag will automatically save nmap’s output in “normal”, XML, and “grepable” formats.

Higher timing templates are faster, but also more error-prone and more likely to get you noticed.

The -p- switch will scan all ports. This is because the beginning/end of our port range can be left unspecified, so -p-80 will scan ports 1 - 80, while -p80- will scan ports 80 - 65535.

## TCP Connect Scans

During a TCP connect scan (-sT), nmap attempts to make a full TCP connection (three way handshake) with each port on the target machine.

RFC 793 establishes that a closed port should respond to any packet except a RST with a RST. Firewalls, however, typically _drop_ incoming packets to protected ports (NMAP marks these as “filtered”).

NOTE: Configuring a firewall to respond with TCP RST packets rather than just dropping incoming connections makes getting an accurate read on the target _very_ hard!

- [RFC 793: Transmission Control Protocol](https://tools.ietf.org/html/rfc793)

## SYN Scans

A SYN scan (-sS) works similar to a TCP connect scan, except rather than completing the three-way handshake, nmap instead sends a RST after the target’s SYN/ACK.

- Older IDS solutions tended to look for fully complete connections, and thus miss these scans (not really true anymore).
- Most applications won’t log these scans (standard practice is to only log connections, and a SYN scan never completes a connection).
- They’re _a lot_ faster than full TCP connect scans.

Unfortunately, some applications become unstable when presented with SYN scans. This can be problematic when you want to remain undetected and/or not fuck up your client’s network.

Overall, the benefits of SYN scans outweigh the risks, so nmap defaults to using them when run as root (necessary because ordinary users can’t craft raw packets).

It’s also possible to use SELinux to give nmap sufficient permission without being root to run SYN scans, but this often doesn’t play nice with nmap’s script interface.

## UDP Scans

UDP scans (-sU) are _extremely_ slow, as sending a UDP packet to a port generally doesn’t trigger _anything_. Thus, most ports will be marked as `open|filtered`. On the off-chance that a response _does_ come back, NMAP will mark the port as `open`. Closed UDP ports are _supposed_ to send an ICMP ping “port unreachable” back; if nmap detects such a response, it will mark the port as `closed`.

In general though, you’ll spend _a lot_ of time doing a UDP scan without getting a lot of great information. Scanning only the 20 most common UDP ports (-sU –top-ports 20) can help with the time, but obviously isn’t as complete a scan.

Mostly nmap just sends empty UDP packets, but when it reaches a port that hosts a common service, it does put _some_ work into trying to craft a packet that’s more likely to elicit a response.

## NULL, FIN, and Xmas

These are “stealthier than stealth” scans.

NULL scans (-sN) send TCP packets with no flags. Since there’s no SYN, nmap can’t tell when a port is open or filtered (so, lots of `open|filtered`), but these packets (should) still generate RST packets for closed ports.

FIN scans (-sF) work the same as NULL scans, but send packets with the FIN flag set.

Xmas scans (-sX) set the PSH, URG, and FIN flags, again looking for closed ports. This particular combination results in a multi-colored blinking line in Wireshark, hence the name.

NOTE: Windows machines and Cisco appliances generally respond with a RST to all malformed packets. This is a violation of spec, and also makes these scans not particularly useful when on a network with many such devices.

Modern firewalls and IDS solutions have gotten wise to these scans too, so maybe they’re not all that useful anymore?

## ICMP Network Scanning

Ping sweeps (-sn) let us enumerate hosts by pinging an entire network range (nmap apparently uses ARP packets if run as root and scanning a private network). This obviously has its edge cases, but is still a good first pass.

Nmap’s ping sweep also will send TCP SYN packets to port 443 and TCP ACK packets to port 80 (SYN if non-root) for whatever reason.

NOTE: Nmap targets can be specified as individual (comma-separated) hosts, ranges, and with CIDR notation.

## NSE Scripts Overview

NSE is the “Nmap Scripting Engine”; scripts are written in Lua. NSE scripts exist in one or more categories:

- `safe` scripts shouldn’t affect the target.
- `intrusive` scripts are, well, not safe.
- `vuln` scripts look for vulnerabilities.
- `exploit` scripts attempt to _exploit_ vulnerabilities.
- `auth` scripts try common authentication bypass techniques (anonymous logins, etc.).
- `brute` scripts just try to log in using brute-force methods.
- `discovery` scripts attempt to query additional information from discovered services.

## Working with the NSE

When calling nmap with –script=CATEGORY, nmap will try to run any _applicable_ scripts in that category against the target.

The –script flag can also be given one or more (comma separated) script names to run. The –script-args flag can be used to pass arguments to scripts (again, comma separated). Arguments passed in this way are specified using a SCRIPT.ARGUMENT format (e.g., http-put.url).

Most scripts have (brief!) help messages accessible via –script-help. Nmap’s online documentation is generally _much_ more complete, however.

- [Nmap Scripting Engine Documentation](https://nmap.org/nsedoc/)

## Searching for Scripts

OPTIONS: Search the online Nmap documentation, take a look through /usr/share/nmap/scripts, search through /usr/share/nmap/scripts/script.db (which is really just a structured text file).

If a script is added to /usr/share/nmap/scripts manually, then `nmap --script-updatedb` needs to be run to update the script.db file.

- [Nmap Scripting Engine Documentation](https://nmap.org/nsedoc/)

## Firewall Evasion

The Windows firewall blocks ICMP packets by default, which causes nmap to think that no host exists. The -Pn flag works around this by having nmap scan an IP even if no ping response is recorded (this makes scans hang for a _long_ time when there really isn’t a host at the other end though!).

On a local network, another work-around is to use ARP packets. Seems better to do this.

Some useful flags for firewall avoidance:

- -f and –mtu work together to fragment packets to attempt to reduce the chance of detection (–mtu must be a multiple of 8).
- –scan-delay adds a delay (in milliseconds); longer scans often mean less chance of detection!
- –badsum produces packets with invalid checksums. These should be dropped by normal hosts, but often firewalls will respond immediately. This makes this flag useful for probing for the presence of a firewall or IDS.

## Practical

For whatever reason, Wireshark only works for me when run using `sudo -E wireshark` from the terminal (something seems to be broken with the GUI process elevation prompt, and Wireshark can’t see any interfaces).

Nmap sends a RST after the three-way handshake in a TCP connect scan in order to quickly tear down the connection.

