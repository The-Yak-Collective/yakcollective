---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-04-10 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-10-itprotv-comptia-security-plus.html
author: 100007
---

# CompTIA Security+ Exam Cram

Today I’ll be covering Chapters 7 and 8 of the Security+ Exam Cram, “Security Assessment Techniques” and “Penetration Testing Techniques”.

## Vulnerability Scans

Types of scanners:

- Network Scanners: Nessus, Nmap, etc.
- Application Scanners: Static source code and/or binary analysis. Also called “static application security testing” (SAST).
- Web Application Scanners: Automatic identification of XSS, SQLi, path traversal, etc. Also known as “dynamic application security testing” (DAST). Seems like something you could do with local binaries too, though the Exam Cram emphasizes web applications.

Dealing with discovered vulnerabilities:

- Remediation
- Mitigation
- Acceptance

Vocabulary:

- CVE: Common Vulnerabilities and Exposures
- CVSS: Common Vulnerability Scoring System

Note that the US government uses OVAL - the “Open Vulnerability Assessment Language”, an XML-based vulnerability description language - instead of the CVE numbers used in private industry. That said, OVAL vulnerability representations are often based off of CVE data.

## Intrusive vs. Non-Intrusive Scans

“Intrusive” scans actually try to exploit potentially vulnerable systems.

## Credentialed vs. Non-Credentialed Scans

Credentialed scans: More invasive, but also more accurate.

## Security Information and Event Management (SIEM)

Strategies for identifying “events of interest”:

- Pattern matching
- Anomaly detection
- Contextual data

WORM drives are commonly used as part of SIEMs in a regulatory context, or when conducting investigations into IT and security staff.

Exam Cram notes that SIEMs only become cost-effective when ingesting a million+ events/day.

Some SIEMs are now beginning to include sentiment analysis functionality, often leveraging external data sources.

## Security Orchestration, Automation, and Response (SOAR)

SOAR is to SIEM as broader threat intelligence it to log aggregation. It also layers on incident response automation. Seems to be a bit of a marketing term.

## Testing Methodology

Phases:

- Planning: Define the rules of engagement.
- Discovery: Reconnaissance and vulnerability analysis.
- Attack: Exploitation, privesc, lateral movement, persistence, cleanup (only if you’re a good guy or APT).
- Reporting

Exam Cram refers to passive recon as “footprinting”.

## Team Exercises

Exam Cram specifically defines red teaming as more focused than a regular penetration test, with specific operational objectives. These days, I’d imagine that most red teams focus on APT emulation.

I have not heard of “white teams” - which apparently set the rules of engagement for red/blue teams and are the keepers of business GRC policies - before. Exam Cram refers to them as the “referees”.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Network Reconnaissance And Discovery

Interesting tools:

- `pathping` - Combines `ping` + `traceroute`.
- `route` - Display (local) routing table.
- `arp` - Display (local) arp cache.
- `netstat` - Current (local) network connections.
- `hping` - Packet construction tool.
- `scanless` - Port scanning via third-party services.
- `dnsenum` - DNS enumeration tool; uses third-party services.

## Packet Capture And Replay

```
# Start dumping packets observed on interface $IFACE.
#
tcpdump -i $IFACE

# Dump packets observed on interface $IFACE to pcap file $PCAP_FILE.
#
tcpdump -i $IFACE -w ${PCAP_FILE}.pcap

# Replay packets from $PCAP_FILE.
#
tcpreplay -i $IFACE ${PCAP_FILE}.pcap
```

