---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-02-24 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-02-24-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# CompTIA Security+ Exam Cram

## Password Attacks

Common password attacks:

- Dictionary attacks
- Brute-force attacks
- Hybrid attacks (dictionary attacks with aspects of brute forcing, such as character substitution)
- Password spraying
- Rainbow tables

Online Attacks: When the attacker is directly connected to the target system.

Offline Attacks: When the attacker has access to information of interest independently of the target system.

Brute force attacks can be faster than dictionary attacks for short passwords, though this advantage quickly fades as password length increases.

Hybrid attacks seem to be the most common these days; for example, John the Ripper has a whole suite of utilities designed to craft hybrid attacks, and even Burp Suite and OWASP Zap have simple hybrid attack capabilities.

- [John the Ripper](https://cardboard-iguana.com/notes/john-the-ripper.html)
- [Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)
- [OWASP Zap](https://cardboard-iguana.com/notes/owasp-zap.html)

## Birthday Attacks

Birthday Attacks: Exploiting hash collisions to crack passwords.

Note that this doesn’t really work when trying to crack a single password, as the probability of any particular hash collision is low. But when the password set it large, the probability that such a collision occurs for _some_ password can grow much larger.

- [Birthday problem (Wikipedia)](https://en.wikipedia.org/wiki/Birthday_problem)

## Downgrade Attacks

A species of man-in-the-middle attack. Keep yo’ shit up-to-date!

# ITPro.TV: CompTIA Security+ (SY0-601)

## Password Attacks - Types

Password attacks are a type of automated attack against authentication systems.

Types:

- Brute force attacks (just try every possible combination of characters; generally time consuming)
- Dictionary attacks (uses guesses drawn from a password list)
- Rainbow tables (files of precomputed hashes; trades speed for memory/storage)
- Password spraying (trying a single password on multiple accounts simultaneously; slow but stealthy)

If you _can_ use rainbow tables, they are the fastest method… But they’re also easily defeated (by salting).

## Password Attacks - Tools

Online Attacks: Require interacting directly with the target system (generally a remote login of some kind). Concerns:

- How many attempts are available before a lockout?
- What’s you’re available (attack) bandwidth?
- How to avoid detection?

Offline Attacks: Attacks data (typically password hashes) independently of the target system. Typically a step during post-exploitation. Concerns:

- How powerful is your cracking rig?
- How to exfiltrate the data from the target?

Tools (not all of these are password crackers per se):

- [John the Ripper](https://cardboard-iguana.com/notes/john-the-ripper.html)
- [Hashcat](https://cardboard-iguana.com/notes/hashcat.html)
- [Hydra](https://cardboard-iguana.com/notes/hydra.html)
- [PACK](https://www.kali.org/tools/pack/)
- [CeWL](https://github.com/digininja/CeWL)
- [Statprocessor](https://hashcat.net/wiki/doku.php?id=statsprocessor)
- [Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

PACK and CeWL, for example, are tools for generating and ordering password lists.

# TryHackMe: Jr. Penetration Tester

## The CIA Triad

- Confidentiality (only authorized parties have access)
- Integrity (only authorized changes are made - and changes are correct)
- Availability (authorized users _have_ access!)

The point of the CIA triad is for a security policy to address _all three_ aspects simultaneously. However, the _extent_ to which a given system leans on one or more parts of the triad will be determined by its role and the data it holds.

## Principles of Privileges

Privileged Identity Management (PIM): The translation of a user’s role in an organization to an access role on a system.

Privileged Access Management (PAM): The management of privileges on a system (including how they are tied to access roles, and how access is authenticated).

So, PIM is a species of _identity_ management, while PAM is about _access_ management.

## Security Models

The Bell-La Padula Model is used to manage confidentiality. It depends on an organization having well defined job rules and a hierarchical structure, and can be summarized as “no write down, no read up” (i.e., information from higher confidentiality layers cannot be written to lower layers, and users in lower layers cannot read information from higher layers). Note, however, that the _existence_ of higher level data is not necessarily concealed.

The Biba Model is more concerned with integrity, and is basically the reverse of the Bell-La Padula Model - “no write up, no read down” (information can be read from higher levels, but only written to lower levels).

The Bell-La Padula Model is more common in the government, military, and other high-trust, high structure organizations, while the Biba Model is more common in corporate and medical settings.

## Threat Modeling & Incident Response

Principles:

- Identification (of threats and assets)
- Preparation
- Mitigation
- Review

One relevant framework is STRIDE, which buckets risks into six categories:

- Spoofing
- Tampering
- Repudiation (keep logs)
- Information Disclosure
- Denial of Service
- Elevation of Privilege

Incident: A security breach. Incidents are typically binned by a combination of urgency + impact.

Phases of incident response:

- Preparation (_before_ the incident, please!)
- Identification (both that an incident has occurred, but also what data & systems are involved in the incident, etc.)
- Containment
- Eradication
- Recovery
- Lessons Learned
