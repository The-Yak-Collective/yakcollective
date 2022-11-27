---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Security Analyst
  Intro'
date: 2022-02-22 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-02-22-itprotv-comptia-security-plus-and-tryhackme-jr-security-analyst-intro.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601) & TryHackMe: Jr. Security Analyst Intro

**author:** Nathan Acks  
**date:** 2022-02-22

(So, I didn’t get to start this yesterday as I’d planned, because I needed to take The Yak Online Governance Primer live instead!)

It’s time to get down to business… Up until now, I’ve been trying to bring myself up to speed on the fundamentals. Now it’s time to actually start earning some certifications! First up: The CompTIA Security+.

I’ll be working on this by alternating episodes of ITPro.TV’s Security+ course and TryHackMe’s Jr. Penetration Tester path.

- [The Yak Online Governance Primer](https://www.yakcollective.org/projects/yak-online-governance-primer/)
- [CompTIA Security+](https://www.comptia.org/certifications/security)
- [ITPro.TV: CompTIA Security+ (SY0-601)](https://www.itpro.tv/courses/security/security-sy0601/)
- [TryHackMe: Jr. Penetration Tester](https://tryhackme.com/path/outline/jrpenetrationtester)

# ITPro.TV: CompTIA Security+ (SY0-601)

## Threats, Attacks, and Vulnerabilities: Overview

Recommended materials:

- [CompTIA Security+ All-in-One Exam Guide](https://www.amazon.com/CompTIA-Security-Certification-Guide-SY0-601/dp/1260464008/)
- [CompTIA Security+ Exam Cram](https://www.amazon.com/gp/product/0136798675/)

Based on the Amazon reviews, I decided to go with the second of these, even though the instructors indicated that they were not going to be following it closely.

The instructors are recommending an A+ or Networking+ certification before this. I don’t have that, so we’ll have to see how well I do.

The test itself is (up to) 90 question that are a mix of multiple-choice, drag-and-drop, and simulation. Passing score is 750/900 (so, ~75 questions correct). It’s currently $381 to take.

- [CompTIA Security+](https://www.comptia.org/certifications/security)

## Social Engineering Techniques

Basic terminology:

- The CIA triad: Confidentiality, integrity, and availability.
- Vulnerabilities: Bugs, insecure defaults, weak passwords, and other weaknesses.
- Threats: Something that violates the CIA triad. Hackers, criminals, insider threats, etc.
- Attacks: The exploitation of a vulnerability (such as by a threat actor).

Social engineering is an attack against people: “Bad people tricking authorized users.” Generally the social engineer (threat) tries to leverage (attack) common psychological traits (vulnerabilities) in order to gain access to a system, obtain sensitive information, or forward some other objective.

Types of phishing:

- Phishing: The original, email-based social engineering attack
- Vishing: Voice phishing
- Smishing: SMS phishing
- Spear phishing: Targeted phishing attacks (maybe to individuals, maybe just to a specific organization)
- Whaling: Spear phishing against big targets (C-Suite, people with high level access to systems, etc.)

There’s also spam and “spim” (instant messaging spam), which _can_ be phishing, but can also just be annoying.

Phishing may not always involve credential harvesting; it can also be about installing malware, or even just getting someone to perform an action on behalf of the attacker (so, I guess gift card scams are actually a form of phishing…).

Techniques:

- Spam
- Pharming (intercepted/poisoned DNS)
- Watering hole (compromise/spoofing of a site popular with the target audience)
- Credential harvesting
- Typo/URL squatting
- Dumpster diving
- Shoulder surfing
- Tailgating/Piggybacking
- Pretexting (playing a particular part/role/story)
- Invoice scams (the instructors are talking about this related to credential harvesting, but I’ve been seeing this mostly in relationship to call center credit card scams of late)
- Hoaxes
- Prepending (modifying the _start_ of a URL to change its behavior)

# TryHackMe: Jr. Security Analyst Intro

## A Career as a Junior (Associate) Security Analyst

Basically, this role is all about monitoring and triage. Maybe some application configuration.

This is what you want a Security+ certification for (oh, hi there).

Security Operations Centers (SOCs) are typically divided into three tiers:

- Tier 1 is about triage, and is generally entry-level.
- Tier 2 is about incident response and remediate, and is generally mid-level.
- Tier 3 is about threat hunting and advanced investigations/research. Generally senior level.

## Security Operations Center (SOC)

Interesting shout-out to Feedly as a threat monitoring tool. I periodically return to Feedly, but can’t help shake the feeling that I’m missing something that would help me use it more effectively…

- [Feedly](https://feedly.com/)
