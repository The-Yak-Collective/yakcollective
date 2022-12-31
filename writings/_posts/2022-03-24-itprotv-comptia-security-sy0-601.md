---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-03-24 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-24-itprotv-comptia-security-plus.html
author: 100007
---

# CompTIA Security+ Exam Cram

Today I’ll be reading chapter 18 of the Security+ Exam Cram, “Host and Application Security Solutions”.

## Firewalls and HIPS/HIDS Solutions

Exam Cram recommends outbound connection filtering even for host-based firewalls.

Vocab:

- HIDS = Host-based intrusion detection system
- HIPS = Host-based intrusion prevention system
- NIDS = Network-based intrusion detection system
- NIPS = Network-based intrusion prevention system

The difference here is between detection/logging (HIDS/NIDS) and actively attempting to block attacks (HIPS/NIPS). Technically things like anti-virus and EDR are HIDS, though I feel like in practice detection/protection is often bundled. It is implied in the text that Windows’ UAC is also a species of HIDS

AIDE = Advanced Intrusion Detection Environment

AIDE is a Linux-based file integrity checker.

## Anti-Malware and Other Host Protections

Exam Cram defines heuristic-based scanning narrowly, as something that’s just looking for atypical instruction sets, and implies that it is inferior to signature-based methods. If I take this definition at face value, then the difference between heuristic-based and behavioral detection is quite stark.

Exam Cram further defines anti-malware as a broader category than antivirus that incorporates behavior-based and context-based detection.

## Endpoint Detection and Response (EDR)

Boy, I wish I’d read this section last night!

Exam Cram defines EDR solutions as a package that “rolls up” multiple types of system protections (anti-virus, anti-malware, anti-spyware, etc.), but with more of an emphasis on detection and response than prevention, and typically using behavioral analytics or machine learning for detection. Additionally, EDR solutions often come with application whitelists/blacklist functionality, DLP, host-based-firewalls, and various logging and analytic capabilities.

## Data Execution Prevention (DEP)

DEP is a hardening method that prevents non-OS code from executing in a protected memory space reserved for system processes. modern CPUs have DEP features built in, and kernel-level DEP is available as well.

## Web Application Firewall

Exam Cram points out that a WAF is actually a type of special-purpose deep packet inspection firewall - which isn’t something I’d thought about before, but totally makes sense.

## Application Security

Basically, a cookie with the “secure cookie flag” is allowed to be transmitted over HTTPS only (which implies that it must be set over HTTPS).

## Code Analyzers

Just because I keep forgetting this acronym: SDLC = Software Development Life Cycle.

## Static Code Analyzers

Static code analyzers are often integrated into compilers.

## Dynamic Analysis

Fuzzing!

- Application
- Protocol
- File (Format)

## Application Sandboxing

The Exam Cram focuses on the sandboxing of development environments.

## FDE and SED

FDE = Full Disk Encryption

Windows supports Bitlocker (FDE) and the “encrypted file system” (EFS), which can be used to encrypt particular files or directories trees on a per-file basis. Bitlocker uses AES under the hood.

SED = Self-Encrypting Drive

## TPM and HSM

TPM = Trusted Platform Module

TPM components:

- The “endorsement key” is a 2048-bit asymmetric key pair that is burned in at manufacture time.
- The “attestation identity key” is a private key pair held entirely within the TPM that is used for attestation.
- The “storage root key” os a 2048-bit asymmetric key pair generated and stored by the TPM for use with encrypted storage.
- “Platform configuration registers” store data in the TPM.
- “Sealed storage” is information that the TPM encrypts and only discloses when the system is in a defined known state. Storage encryption keys are typically “sealed”.
- “Attestation” is the validation of the system by the TPM using information from sealed storage.

HSM = Hardware Security Module

## Boot Integrity

Windows’ “measured boot” stores information about each step of the boot process in the system TPM and provides an interface for this information to be read out as a log to a remote endpoint. So, basically taking advantage of the TPM’s sealed storage and attestation functions.

## Hardware Root of Trust

Technically, a self-encrypting drive is a root of trust.

## Disabling Unnecessary Ports and Services

- Well-known (reserved) ports: 0 - 1023
- Registered ports: 1024 - 49151
- Dynamic (private) ports: 49152 - 65535

Common ports:

- Netstat - 15
- Chargen - 19
- FTP (data/control) - 20, 21
- SSH - 22
- Telnet - 23
- SMTP - 25
- DNS - 53
- DHCP - 67, 68
- TFTP - 69
- Finger - 79
- HTTP - 80
- POP3 - 110
- NTP - 123
- NetBIOS - 137, 138, 139
- IMAP - 143
- SNMP - 161, 162
- LDAP - 389
- HTTPS - 443
- SMB - 445
- LDAPS - 636
- FTPS (data/control) - 989, 990
- RADIUS - 1812
- RDP - 3389

Chargen = Character Generator. Does exactly what you think it does, for totally unclear reasons.

## Least Functionality

“Least function” is the server version of “least privilege”, and is a fancy way of saying “use single purpose servers”. The term originates from NIST 800-53.

## Secure Configurations

Interesting: FAT doesn’t allow for file-level access controls. Which is weird, because even though FAT isn’t a forking filesystem, it _does_ support limited extended attributes.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Host Security - Endpoint Protection

“Antivirus” and “antimalware” are generally used interchangeably these days. Definition-based protection is still used, but behavioral monitoring is becoming more common.

ITPro.TV uses “heuristics” to represent a _more_ advanced form of behavioral monitoring, in contrast to the Exam Cram.

ITPro.TV sees EDR solutions as basically just “enterprise antimalware” - antimalware/antivirus solutions that are designed to be centrally managed and scaled, and often includes more intense analysis and reporting options.

Another way to think of the host-based intrusion detection/prevention distinction: Detection is _passive_, while prevention is _active_. Generally these systems are bundled together these days.

NextGen Firewalls = UTM (Unified Threat Management)

The key with NextGen firewalls is that they’re application-aware, basically operating over almost the entire OSI stack (network-to-application layers). They can also sometimes include DLP features and DNS/URL blocking.

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

## Host Security - Hardening

File-level encryption methods:

- EFS (Windows)
- APFS encryption (macOS)
- fscrypt/GPG (Linux)

Full disk encryption methods:

- BitLocker (Windows)
- FileVault (macOS)
- dmcrypt/LUKS (Linux)

Check out the Microsoft Security Compliance Toolkit to generate automated suggestions for Windows hardening.

