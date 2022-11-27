---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-04-25 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-25-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

**author:** Nathan Acks  
**date:** 2022-04-25

# CompTIA Security+ Exam Cram

Today we’re going to read through three chapters of the Security+ Exam Cram:

- Chapter 9, “Enterprise Security Concepts”
- Chapter 31, “Control Types”
- Chapter 32, “Regulations, Standards, and Frameworks”

## Configuration Management

Configuration Management: The process of identifying, controlling, and auditing the creation and modification of an IT baseline.

Important pieces:

- The actual “baseline configuration” as either an automated process or a defined “recipe”
- Diagrams of networks, system relationships, etc.
- A standardized naming conventions
- IP space location standardization

Security baselines can either be layered onto system baselines, or may be present from the beginning as part of the baseline for different system roles.

The Exam Cram emphasizes the importance of guarding against both intentional and unintentional “attacks” as part of the hardening process.

## Data Loss Prevention

The Exam Cram emphasizes the role of not only the software controls that I’m more familiar with in service of DLP, but also hardware restrictions (for example, forbidding USB drive access).

## Cloud Access Security Brokers

I’m mostly familiar with CASBs as a way of _discovering_ and managing cloud usage. But Exam Cram explicitly situates them as primarily a DLP solution. More generally, they’re conceptualized as “extending on-prem security solutions to cloud systems”.

## Encryption and Data Obfuscation

Apparently the term “data in processing” has come to supplant the notion of “data in use”, at least w.r.t. homomorphic encryption. This terminology difference appears to be an attempt to emphasize that humans can’t actually work directly with (“use”) encrypted data.

Other approaches to data minimization during processing:

- Tokenization (using random strings with equivalent properties)
- Masking (using substituted, false data)
- Redaction (\*\*\*\*\*\*\*\*)

I’m mostly familiar with tokenization as “using references rather than data”, but this doesn’t seem to fit into any of the definitions Exam Cram provides. If anything, in the Exam Cram universe, the difference between tokenization and masking seems to boil down to whether the substitute data is “human meaningful”.

Exam Cram situates masking as primarily a development strategy - no data reversing should be possible.

Interesting: The first 4 - 6 digits of a credit card number identify the issuing bank, and are thus not particularly sensitive.

- [Bank Identification Number (BIN)](https://www.investopedia.com/terms/b/bank-identification-number.asp)

## Rights Management

DRM and IRM (“digital” vs. “information” rights management); the former is generally consumer facing, while the latter is used within organization. While DRM is based around tightly controlled encryption keys, IRM functions a lot more like device management. To a certain extent, the sharing capabilities within Google Drive (being able to control who can access the document in a fine-grained fashion, being able to revoke this access, being able to restrict printing, etc.) can be thought of as a form of IRM.

## Encrypted Traffic Management

Basically, SSL intercept/MitM solutions.

## Data Integrity

Hashing, signing, etc.

Oddly, the Exam Cram states that “[r]enaming the file … will produce different [hash] output”, which is not actually true (only the file contents, not its name on disk, will influence its hash).

## Data Availability

Backups, disaster response/preparedness, etc.

## Site Resiliency

Warm (backup) sites are generally shared by multiple organizations.

Cold (backup) sites are often just _contracts_ for facilities.

## Deception and Disruption

- Decoys (entirely fictitious networks)
- Lures (honeypots configured to look like laptops, workstations, servers, etc.)
- Honeytokens (the generic version of Canary Tokens)

Exam Cram emphasizes that traditional honeypots are generally not used anymore, but all of their examples seem like they’re basically automated honeypot creation/maintenance.

- [Canary Tokens](https://www.canarytokens.org/)

## Nature of Controls

This is about “controls” in the risk mitigation sense of the word.

Types:

- Technical (IT defenses)
- Managerial (a.k.a. “administrative controls”)
- Operational (physical controls and general organizational culture)

## Functional Use of Controls

Controls can be _further_ divided into:

- Deterrence (system banners, etc.)
- Prevention (firewalls, trainings, etc.)
- Detection (logs, anti-malware, regular audits, etc.)
- Corrective (mitigation/recovery)

## Compensating Controls

Basically, if you can’t (or won’t) implement a given control, what control(s) do you layer in instead to provide equivalent security guarantees?

## Industry-Standard Frameworks and Reference Architectures

- Standards: Descriptions of mandatory behavior/configurations/implementation
- Guides: Best practices for implementing standards
- Frameworks: Basically hyper-detailed guides

## Regulatory and Non-Regulatory Requirements

The difference here boils down to: Which have teeth, and which are just fancy specifications?

## Industry-Specific Frameworks

- ISO 27002 (information security best practices; most commonly used by cloud providers)
- ISO 27001 (information security certification)
- ISO 27701 (ISO 27001 + privacy)
- ISO 31000 (risk management)
- SOC 2 (standardized requirements around the CIA triad + privacy)
- Various NIST standards
- COBIT (Control Objectives for Information Technology; IT management best practices, most commonly used as part of Sarbanes-Oxley compliance)
- COSO (Committee of Sponsoring Organizations; for governance and risk management)
- HITRUST CSF (Health Information Trust Common Security Framework; healthcare information handling)
- CSA CCM (Cloud Security Alliance Cloud Controls Matrix; cloud-specific security best practices)
- OCTAVE (Operationally Critical Threat, Asset and Vulnerability Evaluation; most commonly used in the education sector)

SOC = Service Organizational Control

## Benchmarks and Secure Configuration Guides

CIS Critical Security Controls + related benchmarks and guides.

