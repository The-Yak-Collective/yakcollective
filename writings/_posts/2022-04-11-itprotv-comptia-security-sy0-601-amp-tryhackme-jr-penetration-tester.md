---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-04-11 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-11-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601) & TryHackMe: Jr. Penetration Tester

**author:** Nathan Acks  
**date:** 2022-04-11

# ITPro.TV: CompTIA Security+ (SY0-601)

## Vulnerability Scans

Nothing new here if you’ve ever been in charge of Nessus/Tenable.io

## SIEM And SOAR Systems

SIEM: Security Information and Event Management

SIEMs aggregate, normalize, store, and provide tools to aid in analysis of logs. Sensor data can also be included in the mix. Many SIEMs also pull in external threat intelligence feeds these days; these can then be correlated and searched along with internal logs/data. Sentiment analysis can be included in modern systems.

SOAR: Security Orchestration Automation Response

Basically, a SOAR is a SIEM with automation (or sometimes a plugin or adjunct application to an existing SIEM).

ITPro.TV ends out this episode by demoing Security Onion, which appears to be an open-source SIEM.

- [Security Onion Solutions](https://securityonionsolutions.com/)

## Pentesting Techniques

The difference between a vulnerability assessment and a penetration test ultimately lies in whether you attempt to _exploit_ the discovered vulnerabilities.

Another way to think about the blackbox/whitebox distinction: Are you acting as an external attacker (blackbox) or an insider threat (whitebox)?

Phases:

- Recon
- Initial Access
- PrivEsc
- Lateral Movement
- Persistence
- Reporting (this is what people are _actually_ paying for)
- Cleanup

## Pentesting Exercise Types

Red teams _within_ organizations typically are less restricted than external pentesters. They have specific _goals_ (not just “identify exploitable vulnerabilities”, but something more like “obtain access to X”) and _a lot_ more latitude.

Purple teams are most common in smaller organizations with constrained resources.

# TryHackMe: Jr. Penetration Tester

## Introduction to Vulnerabilties

- OS/Software
- Misconfigurations
- Weak/Default Credentials
- Application/Business Logic
- Humans

OS/Software vulnerabilities are the most likely to result in privesc.

## Scoring Vulnerabilities (CVSS & VPR)

That said, only ~20% of vulnerabilities have an actual exploit, and only ~2% are actually exploited in the wild.

## Vulnerability Databases

- [National Vulnerability Database (NVD)](https://nvd.nist.gov/vuln/full-listing)
- [Exploit Database](http://exploit-db.com/)

## Finding Manual Exploits

- [Rapid7 Vulnerability & Exploit Database](https://www.rapid7.com/db/)
