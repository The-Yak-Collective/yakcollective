---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-03-02 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-02-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# CompTIA Security+ Exam Cram

## An Introduction to Threat Actors, Vectors, and Intelligence Sources

Threat actor: Someone or something that executes on a given threat. The “who” of a cybersecurity incident.

## Threat Actor Attributes

Things to consider:

- What is the threat actor’s _relationship_ to your organization?
- What it the _motive_ of the threat actor?
- What is the _intent_ of the threat actor?
- What are the threat actor’s _capabilities_?

(Later on, Exam Cram talks about these factors as part of building a threat profile for an organization, though this seems like an odd take to me. Really, _anyone_ could be targeted by _anything_, but the associated _risk_ of attack by a given threat actor is going to vary depending upon the particular situation. This make threat _profiles_ inherently probabilistic - you wouldn’t really say “my threat profile includes external threat actors”, but rather “the most common threat actors we expect to face are external”.)

The _intent_ vs. _motive_ is a question of the threat actor’s _proximate_ vs. _distal_ objectives. For example, a threat actor may _intend_ to deploy ransomware because they are _motivated_ by financial gain. Intents and motives may not necessarily be malicious: For example, a careless employee _motivated_ to close a deal may _intend_ to share documents that they think will help realize that end, without thinking through the consequence of those documents exposure to the wider organization.

Exam Cram indicates that the primary _relationship_ that the Security+ exam is concerned with is whether a threat actor is _internal_ or _external_.

## Threat Actor Types

Common types from the Security+ exam:

- Script kiddies
- Insiders
- hacktivists
- Criminal syndicates
- Competitors
- State actors

Exam Cram uses the term “low and slow” to describe APT operations.

## Vectors

A.k.a., “attack vectors” - the pathway used by the threat actor when attacking an organization. Common attack vectors from the Security+ exam:

- Direct access
- Wireless
- Removable media
- Cloud system
- Email
- Improper usage
- Equipment damage/loss/theft
- Supply chain

(What, no “they just connected to the exposed RDP endpoint over the internet”? I guess that qualifies as “improper usage”?)

## Sharing Centers

ISAC: Information Sharing and Analysis Center

## Open-Source Intelligence

OSINT: Open Source INTelligence

Which is not “open source” like “open source software”, but rather “open” as in freely available. Exam Cram calls OSINT “_overtly_ gathered intelligence”, which I kind of like.

Common sources:

- Vulnerability databases
- MITRE’s ATT&CK (Tactics, Techniques, and Procedures - a.k.a. TTPs)
- Dark web
- Indicators of compromise (a.k.a., IOCs - frequently published by threat intel firms)
- Automated indicator sharing (a.k.a., AIS - a DHS program built on the structured threat information expression - STIX - language and the trusted automated exchange of indicator information - TAXII - protocol)
- Threat maps (sometimes published by threat intel firms)
- File/code repos
- General web information - blog posts, papers, photos, RFCs, etc.

Some specific links:

- [MITRE CVEs](https://cve.mitre.org/)
- [CVE Details](https://cvedetails.com/)
- [VulnDB](https://vulndb.cyberriskanalytics.com/)
- [MITRE ATT&CK](https://attack.mitre.org/)
- [Kaspersky Cyberthreat Map](https://cybermap.kaspersky.com/)

Exam Cram calls out TTP, IOC, and AIS as three acronyms to know for the exam.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Threat Intelligence - OSINT

Threat Intelligence: The gathering and analysis of data for the purpose of identifying, preventing, and remediating potential attacks.

One reason to go through the exercise of information classification is to ensure that proper controls are in place to prevent the disclosure of potentially sensitive data (which could then be used by attackers in their OSINT efforts!).

Useful tools:

- Maltego (GUI, part of Kali)
- recon-ng (CLI, also part of Kali)
- Shodan.io / Censys.io (these sites can be integrated into the previous two tools)

Both Maltego and recon-ng require a large number of API keys to function

## Threat Intelligence - Threat Maps And Feeds

Threat Map: A real- (or near-real-) time map of identified threats/attacks, normally visualized geographically.

Threat Feed: A real- (or near-real-) time stream (often in the form of an RSS feed) containing information about threats, attacks, and threat actors.

Things that often go into a threat feed:

- Domain reputation
- Observed malware activity
- Known malicious IPs
- Other IOCs

VirusTotal is a _little bit_ like a threat feed.

STIX and TAXII together define a common (low-level) language for talking about IOCs and transmitting them between systems. STIX and TAXII come together in the Automated Indicator Sharing (AIS) system, which is CISA’s IOC clearinghouse mentioned by Exam Cram.

I’m a little skeptical about the overall utility of threat maps, though they do _look_ cool.

## Threat Intelligence Vulnerability Databases & Feeds

Vulnerability Database: A collection of information about security flaws (and sometimes information about how to exploit them).

Examples:

- MITRE CVEs (Common Vulnerability Exposures) and ATT&CK
- NVD (National Vulnerability Database, maintained by NIST)
- USCERT (US Computer Emergency Response Team; maintains a useful knowledgebase)

NVD includes a number of components:

- SCAP (the Security Content Automation Protocol, which is a common protocol for talking about software flaws, configuration issues, and automation)
- CCE (the Common Configuration Enumeration, which provides unique identifiers for system configurations)
- CPE (the Common Platform Enumeration, which provides a way to describe common clusters of applications, operating systems, etc.)
- CVSS (the Common Vulnerability Scoring System, which provides severity scoring for CVEs that tries to weigh both impact and ease of exploitation, from “nothing to worry about here” 0 to “hair on fire” 10)

A vulnerability feed is like a threat feed, but for vulnerabilities. MITRE and NVD both maintain vulnerability feeds.

## Threat Actors And Vectors

Common threat actors that are important to know for the Security+ exam:

- Script kiddies
- Insider threats (including shadow IT)
- Hacktivists
- APTs
- State actors (strong overlap with APTs)
- Criminal syndicates (_sometimes_ overlaps with APTs)
- Competitors

Threat Vector: An avenue of attack.

- Direct access (tends to be insider threats)
- Wireless
- Email
- Supply chain
- Social media
- Removable media
- Cloud-based avenues (S3 buckets, etc.)

# TryHackMe: Jr. Penetration Tester

## Username Enumeration

Use ffuf to enumerate potential users based on a wordlist (assumes that the form we’re hitting is not AJAX-y):

```
ffuf -w /usr/share/wordlists/wfuzz/others/names.txt \
     -X POST -d "$POST_VARS" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -u $FORM_URL -mr "$ERROR_MEESAGE_SUBSTRING"
```

Here `$POST_VARS` should look something like `username=FUZZ&email=FUZZ@example.com&password=1234&cpassword=1234` (recall that FUZZ is the variable that ffuf will be fuzzing over). The `-mr` flag instructs ffuf to filter on page text for a “successful hit”.

Note that ffuf is kind of noisy in its default output, so when generating user lists it may be useful to supply the `-s` flag, which will suppress all lines except those matched with `-mr`.

- [Using “ffuf”](https://cardboard-iguana.com/notes/ffuf.html)

## Brute Forcing

Ffuf can also be used as a simple brute-forcer:

```
ffuf -w /usr/share/wordlists/wfuzz/others/names.txt:W1,$HOME/.local/share/red-team/wordlists/rockyou.txt:W2 \
     -X POST -d "$POST_VARS" \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -u $LOGIN_URL -fc 200
```

Here we assign W1 and W2 to take terms from the two supplied wordlists; `$POST_VARS` then looks something like `username=W1&password=W2`. This example assumes that a successful login will return an HTTP status code _other_ than 200 (probably a 301 or 302).

Again, the `-s` flag can be advisable here.

Note that ffuf will try every possible combination of elements between the two wordlists, which means that the number of combinations tried grows geometrically.

## Logic Flaws

It’s worth experimenting with forms to check how GET and POST variables interact (and if one can be used to override the other.

## Cookie Tampering

Interesting; sometimes cookies are hashes, rather than plain strings. I’m guessing that the reason you’d do this is that you’re concatenating some values together and then check to see if the hash matches before granting certain privileges? This seems potentially much less secure than password hashing (even with a salt) though, as the number of terms that could reasonably be included in a permission string is much smaller than the number of character combinations in even a modest password…

[CrackStation is an online database of hashes (basically a rainbow table).](https://crackstation.net/)

I guess the reason you’d do this is to try to minimize the number of database hits?

On the other hand, seeing base64-encoded cookies is something I’m much more familiar with!

Remember that `basenc` can be used to encode/decode a variety of encodings, including URL-safe base64 (which there don’t seem to be any other good command line tools to work with).

```
# Encode $STRING to base64.
#
echo "$STRING" | basenc --base64

# Encode $STRING to URL-safe base64.
#
echo "$STRING" | basenc --base64url

# Dencode $BASE64_STRING from base64.
#
echo "$BASE64_STRING" | basenc -d --base64

# Dencode $BASE64_STRING from URL-safe base64.
#
echo "$BASE64_STRING" | basenc -d --base64url
```

