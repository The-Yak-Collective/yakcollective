---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-02-23 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-02-23-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601) & TryHackMe: Jr. Penetration Tester

**author:** Nathan Acks  
**date:** 2022-02-23

Moving forward, I’m planning to read the appropriate chapter of “CompTIA Security+ Exam Cram” before watching the corresponding ITPro.TV lecture. But since I didn’t do that yesterday, I have two chapters to read today!

# CompTIA Security+ Exam Cram

## Social Engineering Techniques

Social engineering attacks and associated countermeasures:

- Impersonation/Pretexting -\> User education
- Tailgating -\> Mantraps
- Dumpster diving -\> Shredding, disk wiping, etc.
- Shoulder surfing -\> User education, screen guards
- Phishing, etc. -\> User education, subject prepending, attachment blocking
- Watering hole attacks -\> EDR/Antivirus
- Typo squatting -\> Password managers (with autofill), MFA
- Hoaxes/Influence campaigns -\> Snopes.com, communication response planning

Note that CompTIA appears to lump general direct observational reconnaissance (watching a building) and video surveillance (hidden cameras) under “shoulder surfing”.

Like so many other things on the criminal side, there is increasing market specialization in social engineering. Information gained via social engineering may often be exploited by a different actor!

Phishing: “The attempt to acquire sensitive information via electronic communications.” Broad!

- Spear phishing: Targeted phishing
- Whaling: Spear phishing for the big phish
- Vishing: Voice phishing
- Smishing: SMS phishing
- Pharming: Website redirection, usually via DNS cache poisoning

Goals:

- Credential harvesting
- Simple fraud
- Invoice scams (same as the above, but targeting accounts payable; often requires a lot more research)

I continue to find the inclusion of influence campaigns and hoaxes under social engineering odd, if just because they’re so divorced from the more targeted attacks we’ve been discussing and are significantly less controllable by the attacker. It makes sense to include them under a generalized “harm” framework, but the fit is still not perfect in my mind.

“Principles of influence”:

- Authority
- Intimidation
- Consensus/Conformity (“social proof”)
- Scarcity/Urgency
- Familiarity/Likability/Helpfulness

These principles are all about subverting our mechanisms for building trust.

## Malware

Malware: Software designed to cause harm.

Blended Threats: Attacks involving multiple types of malware (rootkits that provide persistence to a botnet that deploys spyware, etc.).

“Endpoint protection” is the general class of technologies used to guard against and remediate malware.

Places to look for forensic clues:

- System memory (running processes, etc.)
- Windows registry (or config files in general)
- Microsoft Office documents (and other files that support scripting)

Virus: Self-replicating malware (requiring some sort of initial user action to launch).

Types of viruses:

- Resident virus (remains active in memory)
- Nonresident virus (exits after execution)
- Boot sector virus (subverts the system boot loader; relatively uncommon today)
- Macro virus (spread via Microsoft Office macros)
- Program/File infecting virus (embeds itself in executables or other files)
- Polymorphic virus (capable of rewriting/obfuscating its binary code to avoid detection)
- Armored virus (incorporates anti-analysis techniques)
- Stealth virus (works extra hard to avoid detection, such as moving its code around on disk or being judicious about when/how it executes)
- Multipartite virus (infects executables _and_ the boot sector; one reservoir can re-infect the other)

Note that types are not exclusive.

The rise of polymorphic viruses are the reason that signature-based detection has been gradually superseded by heuristic (behavioral) detection techniques.

Note that fileless malware is distinct from memory-resident viruses in that it is _never_ written to disk. Fileless malware typically embodies a strong “living off the land” ethic.

Worm: Similar to a virus, but is self replicating, does not require a host file, and can infect a machine without user intevention.

(The Exam Cram book is very specific that worms don’t need to be attached to a file, but I’m pretty sure I’ve read about worms that persist across machine reboots and aren’t doing anything as sophisticated as attacking the boot loader…)

Trojan: Malware hidden inside of an otherwise non-malicious application.

Trojans are often the first stage of an attack, downloading information stealers, keyloggers, and the like (which may themselves be trojans).

“Remote access trojans” and “backdoor trojans” are just two different words for the same thing. Exam Cram emphasizes that (at least on Windows) these are often associated with security warnings (at least during the initial infection).

Rootkit: Malware that integrates itself into core system files and gains administrative rights.

Rootkits are often incorporate key loggers, information stealers, and similar “applets” that used to be more commonly associated with trojans. Kernel rootkits attack the OS kernel directly, which make them _very_ hard to detect!

Many rootkits use the Windows “global hooks” functionality, so endpoint defense systems that monitor or prevent the installation of global hooks can help prevent initial rootkit infection. Avoiding running applications from administrative accounts can also thwart many rootkit installation attempts.

Logic Bomb: A virus or trojan that is designed to execute malicious actions when certain conditions are met (often, but not always, a date).

Logic bombs also go by the name “slag code” (I’ve never heard that term before), and are a favorite of disgruntled employees.

Bots: Automated programs that do not require user interaction and are generally controlled/directed by outsiders.

Typically “bot” is used to refer to the system itself once it is under attacker control, as long as it is being used in an automated fashion. a network of bots is, well, a botnet. Bot code is generally designed to be stealthy and not interfere with the normal functioning of the system (since detection would deprive the bot master of a device).

Crypto-Malware: Ransomware that encrypts files.

Potentially Unwanted Program (PUP): Software that the user almost certainly doesn’t want, but technically consented to install (typically adware).

Spyware: A PUP that (continually) exfiltrates user information and activity.

Adware: PUPs that display or inject ads. Often contains “light” spyware (browser activity exfiltration).

Cyptomining: Surreptitiously installed cryptocurrency miners; often part of a botnet. Sometimes called a “cryptojacking” attack.

## Physical Attacks

This basically covers attacks using malicious USB drives, cables, etc. Includes credit card skimming and RFID cloning.

## Adversarial Artificial Intelligence

Basically, tainting training data. This could happen during the initial training, or by forging/presenting tainted data to systems designed for continuous learning (such as most recommendation algorithms).

# ITPro.TV: CompTIA Security+ (SY0-601)

## Malware

Malware: Any application that performs an unauthorized, unwanted action on a machine.

Types:

- Virus: Malware that enters a computer via some host file, requires user interaction to execute, but runs surreptitiously. Sub-types include macro, boot sector, (email) attachment, (program) file infector, polymorphic, and (propagation via) network viruses.
- Worms: Malware that is self replicating, requires no user interaction to run (or host file to enter the system), and automatically infects other machines.
- Fileless Malware: Malware that runs only in memory and is never written to disk/storage.
- Rootkits: Malware that obtains privileged access for persistence and execution. Typically hooked into the kernel, which makes detection borderline impossible (from within the infected system). Typically can only be cleaned with a wipe-and-restore.

What malware does:

- Keyloggers (could also be a physical device)
- Backdoors
- Logic bombs (execution triggered by some set of conditions)
- Ransomware
- Botnets
- Trojan (looks like a benign application, but isn’t; typically installs other malware)
- PUPs (potentially unwanted programs - adware, bundleware, etc.)

# TryHackMe: Jr. Penetration Tester

## Penetration Testing Ethics

A penetration test will typically be built around a “rules of engagement” (ROE) document containing the following sections:

- Permission: Provides explicit permission for the pentest, contact information for the authorizing party, etc.
- Test Scope: Authorized targets (machines, individuals, facilities).
- Rules: Authorized techniques (and sometimes tools)

## Penetration Testing Methodologies

Generic pentest framework:

- Gather Information: Gathering public information (OSINT).
- Enumeration: Scanning target machines, discovering configurations, etc.
- Exploitation: Leverage vulnerabilities to obtain initial system access (foothold).
- Privilege Escalation: Expand access laterally and vertically.
- Post-Exploitation: Gather additional information, pivot to other hosts, cover your tracks, write up a report.

Specific pentest frameworks:

- [Open Source Security Testing Methodology Manual (OSSTMM)](https://www.isecom.org/OSSTMM.3.pdf)
- [Open Web Application Security Project (OWASP)](https://owasp.org/)
- [NIST Cybersecurity Framework](https://www.nist.gov/cyberframework)
- [Cyber Assessment Framework (CAF)](https://www.ncsc.gov.uk/collection/caf/caf-principles-and-guidance)

The OSSTMM focuses primarily on telecommunications and networking, but is sometimes overly detailed.

The NIST and CAF frameworks are US/UK government frameworks, and thus more likely to be used in their respective countries of origin.

## Black Box, White Box, and Grey Box Penetration Testing

Grey boxing is the most common form of penetration testing. White boxing is generally reserved for software QA.

