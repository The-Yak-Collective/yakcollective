---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-02-27 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-02-27-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

**author:** Nathan Acks  
**date:** 2022-02-27

# CompTIA Security+ Exam Cram

## Introduction to Application Attacks

It looks like this section will cover attacks on both local and web-based applications.

## Race Conditions

Example: Time-of-check to time-of-use (TOCTOU).

Null pointer errors (when an application dereferences a pointer that it later expects to be valid) _can_ be caused by race conditions. Race conditions can also by exploited in some cases for privilege escalation (for example, CVE 2021-3560).

- [Exploiting Polkit](https://cardboard-iguana.com/notes/exploiting-polkit.html)

## Improper Software Handling

This section lumps together oversights in input and error handling. These (sometimes in combination) are a _big_ part of what I’ve studied so far w.r.t. penetration testing (SQL injection comes to mind here as an immediate example that can have aspects of both improper input _and_ error handling).

- [SQL Injection](https://cardboard-iguana.com/notes/sql-injection.html)
- [TryHackMe: Jurassic Park](https://cardboard-iguana.com/notes/tryhackme-jurassic-park.html)

## Resource Exhaustion

Mostly about denial of service.

Example: Memory leaks.

## Overflows

Buffer overflows: When an application attempts to write more data into a space (normally a variable in memory) than has been allocated to it. For example, CVE 2021-4034.

Integer overflow: Writing a larger integer into a variable than there are allocated (binary) digits. The ultimate impact of an integer overflow depends on whether the variable ultimately stores the first/high or last/low set of “good” bits. (I’ve almost always seen overflows result in the variable taking the low set of bits - typified by roll-overs to zero - but apparently in some cases the high bits are stored instead.)

- [Exploiting Polkit](https://cardboard-iguana.com/notes/exploiting-polkit.html)

## Code Injections

RCE via buffer overflow typically results in code that’s executed _outside_ of the context of the target application. Code injection, by contrast, is about running code _within_ the context of the target application.

Examples:

- [XSS Attacks](https://cardboard-iguana.com/notes/xss-attacks.html)
- [SQL Injection](https://cardboard-iguana.com/notes/sql-injection.html)
- [XML External Entity Attacks](https://cardboard-iguana.com/notes/xml-external-entity-attacks.html)
- [Exploiting LD\_PRELOAD](https://cardboard-iguana.com/notes/exploiting-ld-preload.html)
- [Exploiting LD\_LIBRARY\_PATH](https://cardboard-iguana.com/notes/exploiting-ld-library-path.html)

It’s also sometimes possible to conduct SQL injection-like attacks against LDAP servers. And, of course, there’s dynamic library injection in general.

The through-line for these attacks on the web is lack of proper input validation. Locally, it’s about manipulating otherwise legitimate features (dynamic library loading) once a toehold has already been established.

Code signing is a guard against malicious dynamic libraries. As is compiling everything statically (which is not always possible, and has its own drawbacks).

Cram Exam implies that the Security+ exam will generally ask about code injection attacks in the context of a particular system, which should clue you in to which kind of attack is being used.

## Driver Manipulation

Examples:

- Shimming involves inserting an intermediate “driver” between the kernel and the actual driver. The shim can then intercept, manipulate, and redirect information flowing from kernel-to-driver or drive-to-kernel.
- Refactoring is manipulating the internals of the driver itself to change its behavior.

As with dynamic library attacks, code signing is really the only way to guard against these attack. (Well, maybe also monolithic kernels, but then you can’t support devices you didn’t plan for from the get-go!)

## Request Forgeries

Cross-site request forgeries (CSRF/XSRF) is about using a malicious URL to cause an action to be taken on behalf of legitimately signed-in users. This URL might point to the target site directly, or might reflect through another (potentially attacker-controlled) site, exploiting improperly scoped authentication cookies.

Server-side request forgeries (SSRF) are about using malicious URLs to trick a server into disclosing data or executing commands outside of its normal context. For example, this could be about tricking a web server to make a request to another server behind a firewall that the attacker doesn’t have direct access to. Local file inclusion (LFI) attacks are a species of SSRF.

While CSRF is about exploiting the trust between a server and one of its users, SSRF is about exploiting the trust relationship _between_ (or _within_) servers.

- [Local File Inclusion Attacks](https://cardboard-iguana.com/notes/local-file-inclusion-attacks.html)

## Directory Traversal

Local file inclusion (and friends), again.

Note that Exam Cram seems to imply that the Security+ test will make a distinction between the ability to access the server’s filesystem in unexpected ways (directory traversal) and the ability to access restricted portions of an application (privilege escalation).

- [Local File Inclusion Attacks](https://cardboard-iguana.com/notes/local-file-inclusion-attacks.html)

## Replay Attack

This is about _replaying_ previous requests, possibly with altered data. Think Burp Suite’s “repeater” module.

Session replay attacks are a variation of this where a session cookie is intercepted and presented again to a web server in order to gain the access of the authenticated user.

Replay attacks can be guarded against by using nonces, timestamps (though I’d personally be wary of this - seems like asking for a race condition), or rapidly rotating identifiers (such as a session cookie that is replaced with every request).

Apparently, some web apps accept session ID GET parameters _before_ a user is even logged in. This means that if a target is induced to click on a link containing such a parameter, then the attacker will be able to use the same link (with the attacker-supplied session parameter) to log in as if they were the user! ☠️

- [Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## Secure Sockets Layer (SSL) Stripping

A species of man-in-the-middle attack where the attacker terminates the SSL connection on a server they control and then presents an unencrypted connection to the target user. Less common these days, what with HSTS and browsers making initial connections over HTTPS instead of HTTP.

## Application Programming Interface (API) Attacks

- Broken object-level authorization (ACLs are often a mess, part 1)
- Broken user authentication
- Excessive data exposure
- Lack of resource and rate limiting (DoS & brute forcing risk)
- Broken function-level authorization (ACLs are often a mess, part 2)
- Mass assignment (this is about modifying parameters that aren’t directly exposed over the API, but can be set using a properly-formatted request)
- Security misconfiguration
- Injection (SQL, et al.)
- Improper asset management (a.k.a. “lack of documentation leads to exposed debugging endpoints”)
- Insufficient logging and monitoring

There isn’t really anything new here - this is all the same set of vulnerabilities we’ve always been working with, just over a much larger playing field (and with laxer development standards).

- [OWASP API Top 10](https://owasp.org/www-project-api-security/)
- [SQL Injection](https://cardboard-iguana.com/notes/sql-injection.html)

## Pass-the-Hash Attack

Kerberos! (I’m still floored that Active Directory uses hashes for actual authentication, rather than as a check that valid authentication credentials have been supplied.)

Of course, other things can use hashes in this way. TL;DR is to just _not_ compute password hashes client-side - these should always be a check that is performed _server_ side!

- [Kerberos](https://cardboard-iguana.com/notes/kerberos.html)
- [Windows Password Hashes](https://cardboard-iguana.com/notes/windows-password-hashes.html)

## Wireless

Initialization Vector (IV) Attack: Gather encrypted packets, and then use statistical techniques to derive the initial encryption key (thus breaking the security of the connection being analyzed). Only works if the network’s cryptography is vulnerable to it (WEP).

“Bluejacking” involves trying to trick the target into accepting incoming bluetooth messages (does anything actually accept unsolicited bluetooth connections these days?). This can lead to “bluesnarfing”, where the attacker actually tricks the target into _pairing_ with the malicious bluetooth device, allowing for data exfiltration or manipulation.

NFC is a species of RFID, but RFID is not NFC (much older, more broadly used, protocol). (NFC chips combine both the “reader” and “tag” functionality of RFIDs.) RFIDs come in “active” and “passive” varieties, distinguished by whether they contain their own power source (or are powered by the reader).

## On-Path Attack

A.k.a. the good old man-in-the-middle (MITM) attack. Best prevented with encryption, tight session and device management, and strict (physical) access controls.

Proxies are legitimate man-in-the-middle boxes.

A more common variation is “man-in-the-browser” (MITB), which involves compromising the target’s browser to act as the attacker’s proxy. Typically MITB attacks are delivered via trojans.

## Layer 2 Attacks

As in, attacks that operate on the link layer. Examples:

- MAC address spoofing
- ARP poisoning (recall that ARP associates MAC addresses with IPs; the trick here is that ARP replies can be _unsolicited_)
- MAC flooding (a DoS-like attack on switches that fills up their routing table with garbage MACs; this generally won’t crash a switch, but will often force it to act as a dumb hub)
- Port stealing (the attacker floods the switch with ARP requests associating a malicious MAC with a target IP address, in an attempt to re-route traffic from from the target)

Defenses against ARP poisoning include pre-associating known MAC addresses with IPs in client ARP tables, and configuring switches such that MAC addresses are (pre) bound to a single port. Also, IDS.

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)
- [ARP Protocol](https://cardboard-iguana.com/notes/arp.html)

## Domain Name System (DNS) Attacks

A URL Redirection Attack involves an attacker using legitimate (but poorly locked-down) redirect functionality to redirect a user from a (seemingly) legitimate URL to an attacker-controller URL. Basically another species of improper input handling.

I found the explanation of DNS cache poisoning in Exam Cram somewhat confusing. Cloudflare’s is much clearer, and highlights that the underlying vulnerability is the lack of a full handshake with UDP packets. This means that all the attacker needs to do is respond to a DNS lookup from a recursive server using a forged reply _before_ the legitimate authoritative server can respond. So this is both a species of MITM attack, and a race condition of sorts (in the sense that the attacker is racing the actual authoritative server, which I will acknowledge is not normally how “race condition” is used).

The main defenses against DNS cache poisoning are DNSSEC and limiting which domains local DNS servers will resolve.

- [What is DNS cache poisoning?](https://www.cloudflare.com/learning/dns/dns-cache-poisoning/)

## Denial of Service

- Smurf attacks (the attacker forges an ICMP ping to a network broadcast address but with the source address changed to that of the target)
- Fraggle attacks (same as a smurf attack, but uses UDP packets directed at ports 7 and 19)
- Ping flood (just flood the victim with ping packets; see also the “ping of death”)
- SYN flood (start a lot of three-way TCP handshakes with the target, but don’t send the final ACK)
- Land attack (send a TCP SYN packet using the same source and destination address and port number; only works on older operating systems)
- Teardrop attack (send UDP packets with odd offsets that cause overlaps when the final message is reconstructed; only impacts older operating systems)

Be aware that most DoS attacks will use “reflection”, where the attacker substitutes a third-party IP address for the packet source. The idea here is not only for the attacker to mask their own identity, but to trick the system receiving the malicious packets to do the DoS attack for the attacker! This is particularly useful when the spoofed packet is sent to a DNS or NTP server, which may respond with a _much_ larger packet than the attacker’s (forged) request, thus _amplifying_ the attack. Reflection and amplification basically require the use of UDP.

DoS attacks can also be made against the application layer. While such an attack is more expensive for the attacker, it’s also generally (much) more expensive for the victim.

Exam Cram indicates that the Security+ questions may consider the following indicative of a DoS attack (though, IMHO, only the last is clear-cut):

- Slow network/application responsiveness
- Unexpected application/network unavailability
- Spike in network requests in a short time span and from a narrow range of IPs

Filtering and DoS mitigation services are your best defense here.

- [Ping of death (Wikipedia)](https://en.wikipedia.org/wiki/Ping_of_death)
- [LAND (Wikipedia)](https://en.wikipedia.org/wiki/LAND)
- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

## Malicious Code and Script Execution

Macro viruses and file-less malware, again.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Application Attacks - Injections

Injection: Supplying some type of untrusted input.

- SQL injection
- LDAP injection (this is _exactly_ the same idea of SQL injection, but constructing LDAP queries; can sometimes be used against active directory servers)
- XML injection (ITPro.TV has confirmed what I only strongly suspected - this is just another name for an XML External Entity - XEE - Attack)
- DLL injection
- Command injection (this is about _literal_ command injection, so it depends on the application shelling out in some way so that additional commands can be chained to a legitimate command)

> Throw it [the target system] input, and see what happens. See if it breaks. And _how_ does it break? That’s what’s important.
> 
> - Dan Lowrie

- [SQL Injection](https://cardboard-iguana.com/notes/sql-injection.html)
- [XML External Entity Attacks](https://cardboard-iguana.com/notes/xml-external-entity-attacks.html)

## Application Attacks - System Resources

System resources:

- CPU
- Memory
- Network (bandwidth)
- Storage

Terms likely to appear on the Security+ test:

- Memory leak
- Shimming (drivers)
- Refactoring (drivers - a.k.a. binary modification)
- Race conditions
- TOC/TOU (“tock-two” - time-of-access to time-of-use; a species of race condition)
- Pointer/Object dereferencing (a pointer or object is dereferenced without being cleared/garbage-collected; use-after-free is a species of this)
- Buffer overflow
- Integer overflow

## Application Attacks - XSS And XSRF

Types of cross-site scripting (XSS):

- Reflected (uses JavaScript embedded in a malicious URL)
- Stored (uses JavaScript stored on the site by the attacker)
- DOM-based (client-side attack that actually modifies the DOM)

Cross-site request forgery is very similar to reflected XSS (almost a subspecies), in that a target is induced to click on a link on one website (maybe webmail) that causes an action of the attacker’s choice to be taken on another website that the target is currently logged into.

Server-side request forgery induces a server to communicate with another server in an unauthorized fashion. This is mostly about firewall bypass.

Basically, cross-site request forgery abuses the trust relationship between the user and the server, while server-side request forgery abuses the trust relationship between different servers (typically frontend and backend).

- [XSS Attacks](https://cardboard-iguana.com/notes/xss-attacks.html)

## Application Attacks - Replay Attacks

Replay Attack: The retransmission (and potential modification) of a transmission of data.

Pass-the-hash is a specific type of replay attack.

Sequence numbers, nonces, and timestamps can help guard against replay attacks by making replayed packets easy to recognize. (Note that TCP already includes sequence numbers and timestamps, though only IPSEC seems to actually do things with these.)

- [Kerberos](https://cardboard-iguana.com/notes/kerberos.html)

## Network Attacks - DNS Attacks

Keep in mind that DNS cache poisoning can be applied to a machine’s local DNS cache by malware, in addition to intercepting/spoofing the conversation between the recursive and authoritative DNS servers.

DNS Hijacking: An attacker manipulates the target’s preferred (local) DNS servers (perhaps via malware) to point to a malicious DNS server rather than a (legitimate) organizational or ISP server.

Domain hijacking is then about actually compromising the domain record (via the registrar or, more likely, a compromised user account). So, the really bad one.

Display current Windows DNS settings:

```
ipconfig /displaydns | more
```

(SIDE NOTE: So, it turns out that Windows has a `more` command, and you can pipe things to it!)

Flush local DNS cache on Windows:

```
ipconfig /flushdns
```

## Network Attacks - Layer 2 Attacks

- ARP poisoning (very similar to DNS cache poisoning, but at the MAC-to-IP translation layer)
- MAC cloning
- MAC flooding

A reminder of where various bits of network hardware sit in the OSI model:

- Layer 1: Hub
- Layer 2: Switch
- Layer 3: Router
- Layer 4/5: Firewall
- Layer 6/7: Deep packet inspection (?)

You can examine the ARP cache in Windows using `arp -a`.

- [MAC Addresses](https://cardboard-iguana.com/notes/mac-addresses.html)
- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)
- [ARP Protocol](https://cardboard-iguana.com/notes/arp.html)

## Network Attacks - DoS And DDoS

Physical denial of service attack: Block the heat exchangers in a data center.

Types of D/DoS attacks:

- Reflected: The attacker sends a request to a third party server (typically an NTP or DNS server) spoofing the source as the target. This helps hide the attacker IP(s).
- Amplified: A reflected attack that hits a third party that responds using a particularly large payload. This increases the effective bandwidth that the attacker is able to muster. NTP servers are popular third parties.
- Coordinated: A D/DoS attack involving multiple attackers (not a DDoS using a botnet, but rather a DDoS attack involving multiple _individuals_).

Hybrid attacks are also possible (technically an amplified attack is _already_ a hybrid attack).

## Network Attacks - MiTM And MiTB

The key to preventing MITM attacks is really just to use encrypted protocols. (The key to preventing MITB attacks is to… well… avoid getting infected.)

SIDE NOTE: The “Follow” option in Wireshark’s right-click menu displays all of the packets related to a particular connection/session. This is particularly powerful when used against plain text protocols, as it allows the entire conversation to be easily reverse engineered.

## Network Attacks - Wireless

The “initialization vector” (IV) is basically a “salt” (sometimes also called a nonce) that’s added to data on a wireless network to help prevent cryptanalysis. IVs were easy to attack on WEP, but WPA lengthened the IV and added some other controls that make these attacks much less feasible.

The most common attack against RFID is cloning. Typically used to gain access to secure sites (by cloning badges).

One NFC attack that wasn’t mentioned in the Exam Cram (which seemed to treat NFC attacks as mostly theoretical) is a _relay_ attack, in which the victim is tricked into starting an NFC transaction with a malicious device that then relays that transaction to a second device which _then_ interacts with a second target. For example, kicking off a payment transaction between the target device and a terminal in another location. (That said, as far as I’m aware this is _still_ all pretty theoretical, and this attack would seem to require some degree of target interaction given the NFC approval flow on most smartphones…)

ITPro.TV defines “bluejacking” as the interception of bluetooth communications, and “bluesnarfing” as the insertion of additional commands in an existing bluetooth communication stream. This is a significantly different take than the Exam Cram.

