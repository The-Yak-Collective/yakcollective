---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-04-27 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-27-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

**author:** Nathan Acks  
**date:** 2022-04-27

# CompTIA Security+ Exam Cram

Today I’ll be reading Chapter 33 of the Security+ Exam Cram, “Organizational Security Policies”.

## Policy Framework

Parts of a framework:

- Policy (management statements)
- Standards (specific controls that implement the policy)
- Guidelines (recommended methods of realizing the standards)
- Procedures (specific, step-by-step instructions for implementing guidelines)

The policy -\> procedure flow above transforms _descriptive_ statements into _prescriptive_ ones.

## Human Resource Management Policies

Policies should be reviewed by _both_ legal and HR.

## Background Checks

The Exam Cram lumps everything from reference checks to more traditional background checks and drug testing here.

## Onboarding and Offboarding

The Exam Cram recommends that employees sign formal ethics statements.

## Mandatory Vacations

The Exam Cram recommends mandatory vacations (to check for operational gaps) and regular rotation of duties (for cross-training purposes).

## Separation of Duties

The Exam Cram emphasizes making sure that no one individual controls a process or transaction. Not sure how to reconcile this with the concept of a “single wringable neck” (perhaps by not allowing someone _responsible_ for a process actually _perform_ the process?).

## Job Rotation

The Exam Cram also positions job rotation and mandatory vacations as a way of having admins check each other’s work.

## Clean Desk Policies

Basically, keeping work areas free of _any_ information is a simple way to make sure that they do not contain unattended _sensitive_ information.

## Role-Based Awareness and Training

User types:

- General users (the unwashed masses)
- Privileged users (access to restricted data)
- System administrators (responsible for data integrity and/or entire systems)
- Executives (privileged access to data but unprivileged access to systems)
- Data owners (bottom-line responsible for a given data set)
- Systems owners (bottom-line responsible for a given system)

Typically System administrators work under data and system owners (who may be the same person, or may head up parallel teams).

Executives and data/system owners are the people who should be designing and pushing policies, standards, and procedures (I’d expect the latter to be delegated to system admins sometimes).

## Acceptable Use Policy / Rules of Behavior

Ah, codes of conduct.

Exam Cram suggests that all users get notifications about network/computer use being monitored on logon.

## Disciplinary and Adverse Actions

Exam Cram notes that all policy documents should include jurisdictional information in case they become subject to a legal dispute or part of a criminal action.

## Interoperability Agreements

Types of third-party IT/security agreements:

- Service Level Agreement (SLA; specifies a provided service and associated performance parameters)
- Business Partner Agreement (BPA; covers profit sharing, responsibilities, etc.)
- Memorandum of Understanding (MOU; outlines an agreement)
- Interconnection Security Agreement (ISA; supports an MOU by detailing associated technical and security measures and requirements)

Exam Cram notes that only an ISA actually spells out security requirements.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Organizational Security Policies - Personnel

Policies that help detect/prevent malicious behavior:

- Job rotation
- Mandatory vacations
- Separation of duties
- Least privilege
- Acceptable use policies

Adam Gordon makes an interesting point: Separation of duties implies that roles like “backup administrator” should actually be split into “backup administrator” _and_ “restore administrator”. It does seem like perhaps these duties should be rotated, though?

Permission = The _ability_ to do something

Right = The _authorization_ to do something

Privilege = Permissions + Rights

Policies related to employee/vendor lifecycle:

- Background checks
- NDAs
- Social media policies/analysis
- Onboarding
- Offboarding

Policies related to security awareness and training:

- User training
- Clean desk policies
- Gamification
- CTFs
- Phishing trainings
- Computer-based trainings
- Role-based trainings

## Organizational Security Policies - 3rd Party Risk

Elements the go into understanding the _structure_ of third-party risk:

- Vendors/Business partners
- Supply chains
- NDAs

Contractual vehicles that bind supply chains together:

- SLAs
- MOUs
- BPAs (Business Partnership Agreements)

Adam Gordon notes that BPAs basically formalize MOUs into full business relationships.

A new term: Measurement Systems Analysis (MSA). This is the process of determining how much variation occurs in the _act of measuring_ a thing, and how this contributes to our understanding of process variability. Components:

- Bias
- Linearity
- Stability
- Repeatability
- Reproducibility

(It’s not clear here what the difference between “repeatability” and “reproducibility” is here…)

Software/Hardware lifecycle components:

- End of Life
- End of Service

Note that EOS (when security patches are no longer available) comes _after_ EOL (when the system is no longer sold or actively supported). Note that increasingly EOL = EOS (for example, with Chrome OS devices), but this is not _always_ true (Windows…).

PPRR risk management model for third-party & supply chain risk:

- Prevention
- Preparedness
- Response
- Recovery
