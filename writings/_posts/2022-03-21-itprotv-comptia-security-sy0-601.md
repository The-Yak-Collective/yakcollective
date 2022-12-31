---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-03-21 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-21-itprotv-comptia-security-plus.html
author: 100007
---

# CompTIA Security+ Exam Cram

Today I’ll be reading chapter 20 of the Security+ Exam Cram, “Wireless Security Settings”.

## Access Methods

- Open authentication (YOLO, _maybe_ with a captive portal)
- Shared authentication (PSK)
- EAP (Extensible Authentication Protocol) authentication (802.1X)

## Wireless Cryptographic Protocols

WPS (Wi-Fi Protected Setup) can be brute-forced in just a few hours. Not recommended.

WPS apparently predates even WEP.

WPA2 uses AES for encryption. WPA3 continues to use AES, but hardens the key-exchange mechanism.

## Wired Equivalent Privacy (WEP)

WEP uses the RC4 steam cipher, but was limited to 40-bit keys because of government regulations at the time of introduction. The PSKs for WEP _were_ the encryption keys, which means that an attacker could quickly build up a lot of vulnerable ciphertext on busy networks, further easing decryption.

## Wi-Fi Protected Access (WPA)

Two modes:

- WPA-Personal = WPA-PSK
- WPA-Enterprise = WPA-802.1X

In WPA-802.1X mode, certificates are used for device authentications and a RADIUS backend is required.

## Temporal Key Integrity Protocol

TKIP is derived from RC4 and uses a unique key per packet, and is used in WPA. However, it has not been considered secure since 2012.

## Counter Mode with Cipher Block Chaining Message Authentication Protocol

Also called “Counter Mode CBC MAC Protocol” or just CCMP, this is based on AES. It was designed to replace TKIP, and is widely deployed in WPA2.

## Wi-Fi Protected Access Version 2 (WPA2)

WPA2 is based on a standard called 802.11i and uses AES for encryption.

Apparently CCMP can use _either_ AES or TKIP in WPA2?

## Wi-Fi Protected Access Version 3 (WPA3)

WPA3 supports 192-bit AES keys; these are required for enterprise deployments but optional for personal deployments. WPA3-PSK uses a new key exchange method called “Simultaneous Authentication of Equals” (SAE) but implements forward secrecy to prevent future compromise of collected packets.

## Authentication Protocols

“Enterprise” wireless deployments handle authentication using EAP. EAP packets are encapsulated within 802.1X and marked as “EAPoL” (“EAP over LAN”). Clients joining a wireless network using EAP are initially marked as “unauthorized”, and only EAPoL packets are accepted until authentication completes. Authentication is achieved using the normal 802.1X process, normally with a RADIUS backend. Authentication can get quite complex, as RADIUS servers can be federated in various ways to allow/deny access to particular networks on a per user basis.

EAP-TLS uses certificate-based authentication with TLS to negotiate encryption. It is the only commonly deployed EAP protocol that requires both server _and_ client certificates.

PEAP stands for “Protected EAP”. While EAP-TLS sets up TLS encryption as part of the EAP authentication process, PEAP fires up a TLS tunnel first and then runs unencrypted EAP over it. When using PEAP, the master key negotiated for the TLS session is often re-used for wireless encryption.

EAP-TTLS (“EAP Tunneled TLS”) is like PEAP, except that authentication is handled by the TLS tunnel itself.

Finally, EAP-FAST (“EAP Flexible Authentication via Secure Tunneling”) is designed to replace LEAP, and uses a PSK to establish a secure tunnel, rather than a certificate for the authentication backend (thus, no certificates are required at all for EAP-FAST). This makes it much easier to deploy, but also more vulnerable to key disclosure than the previous EAP methods.

Each of these EAP methods is championed by a different vendor, so the stack an enterprise purchases will largely determine which version of EAP is used.

## Wireless Access Installations

Wireless APs are often controlled by a central “access controller” (AC). Sometimes this is integrated into a firewall (SonicWall likes to do this), but increasingly these are cloud-based (think Aruba or WatchGuard).

AP types:

- “Fat” APs do it all, and can be used in a stand-alone fashion. Most consumer and small business APs are “fat”.
- “Fit” APs are controlled by an AC, but still support normal networking functions. Most enterprise APs are “fit”.
- “Thin” APs are basically just somewhat intelligent antennas. A “thin” AP just sends and receives wireless frames, and has only the smarts required to pass these frames on to the AC. “Thin” APs are used in _very_ large deployments.

## Antenna Types, Placement, and Power

There are four different types of antennas common in wireless APs: parabolic grid, Yagi, dipole, and vertical.

Most APs use omnidirectional antennas, but Yagi antennas are directional.

Most access points use MIMO (“multiple-input, multiple-output”) or MU-MIMO (“multiuser MIMO”), which attempt to take advantage of signal reflection within the environment.

Some APs have separate antennas, in which case signal loss between the AP proper and the antenna can become an issue.

While smartly positioning and choosing the types of antennas can make attackers’ lives more difficult, the nature of radio means that these approaches should never be counted on to provide security on their own. That said, smartly adjusting signal strength (or using an AP that does this for you) can provide both power consumption _and_ security benefits.

The 802.11ac (Wi-Fi 6) standard can operate over the 2.4 GHz, 5 GHz, and a new 6 GHz band simultaneously.

APs that support “band selection” will delay 2.4 GHz responses for clients that appear to support the 5 GHz band in order to steer these devices into less congested frequencies. However, band selection can cause delays when roaming, so it’s not recommended for wireless networks that handle voice traffic.

## MAC Filter

MAC address filtering can operate on either a blacklist or whitelist model, though in practice I’ve only ever seen whitelists used.

## Disabling SSID Broadcast

SSID = Service Set Identifier

Choosing non-obvious SSID names and turning off SSID broadcasting provide a level of security-through-obscurity. Which is to say they can help a network fly under the radar, but won’t actually stop an attacker.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Wireless Security

Wireless security protocols:

- WEP: The original 1999 encryption protocol. Uses a 64-bit to 128-bit PSK with the RC4 stream cipher. A 24-bit CRC is used. Do not used.
- WPA: The successor protocol to WEP. Used per-packet encryption, but still with RC4. Uses a 48-bit checksum called a “message integrity check” (MIC). Still weak.
- WPA2: The current standard; also called 802.11i. Uses AES with a 128-bit key via a process called CCMP.
- WPA3: The newest standard; the _weakest_ encryption offered is equivalent to WPA2. WPA3-Enterprise uses 192-bit keys by default. Negotiation is via SAE (“simultaneous authentication of equals”).

Pre-shared keys (PSKs) are used in the personal version of WPA/WPA2/WPA3 (though WPA3 uses a different authentication process).

Authentication protocols (used in the enterprise version of WPA/WPA2/WPA3):

- EAP/PEAP
- EAP-FAST
- EAP-TLS
- EAP-TTLS

These are typically backed by a RADIUS server.

Installation considerations:

- Channel overlay/overlap (congestion)
- AP placement
- Site survey (normally producing a heat map showing expected signal strength)
- Controller/AP physical security

There are 13 channels in the 2.4 GHz band, but only Japan allows the use of all 13; Europe allows the first 12, and the US only allows the first 11.

## Secure Data Destruction

I like Wes’ shirt in this one. 😁

Options for paper documents:

- Burning
- Shredding
- Pulping (essentially recycling)

Shredders have defined security levels, defined as P2 - P6 (all of these are cross-cut these days). P4 is considered commercial level, P5 is “espionage proof”, and P6 is the only level approved for DoD/NSA use.

Options for digital destruction:

- Overwriting old data (only really works on track-based drives)
- Media destruction (“shredding”)
- Degaussing (only works for magnetic media)
- Incineration

The standard for overwriting (“shredding”) files is 3 passes (0, then 1, then random) as defined in the DoD 5220.22 standard.

