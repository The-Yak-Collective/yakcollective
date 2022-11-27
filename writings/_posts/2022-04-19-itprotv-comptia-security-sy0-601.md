---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-04-19 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-19-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

**author:** Nathan Acks  
**date:** 2022-04-19

# CompTIA Security+ Exam Cram

Today’s reading is Chapters 27 and 29, “Incident Response” and “Incident Mitigation”, from the Security+ Exam Cram.

## Cyber Kill Chain

As originally developed by Lockheed Martin. There are seven stages, and the goal is to disrupt the attacker as early in the kill chain as possible.

- Reconnaissance
- Weaponization (i.e., preparation)
- Delivery
- Exploitation
- Installation (persistence; may not always happen)
- Command & Control (establishing remote control; may not always happen)
- Actions on Objectives

There are other “intrusion kill chains” out there.

## MITRE ATT&CK

Divides an attack up into stages (which makes it similar to a kill chain), but then focuses on providing a library of potential attacker tactics at each stage.

- Initial Access
- Execution (i.e., exploitation)
- Persistence
- Privilege Escalation
- Defense Evasion
- Credential Access
- Discovery (i.e., looking for loot)
- Lateral Movement
- Collection (i.e., getting loot)
- Command & Control
- Exfiltration
- Impact (i.e., goals)

## Diamond Model of Intrusion Analysis

This is an adversary-focused functional model. Four components are arrayed on a diamond:

- Adversary
- Infrastructure (of the adversary!)
- Capability
- Victim

There’s apparently math involved here, not that the Exam Cram is going to explain it.

## Incident Response Plan

- Preparation
- Roles
- Rules
- Procedures

“Procedures” in particular should include business continuity planning _under the assumption of continued attack_.

Incident response plans will often cover _preventative_ measures as part of preparing an organization for attack. Useful parts:

- Mission, Strategies, Goals (of the incident response team)
- Management Approval Chain
- Incident Response Approach/Philosophy
- Incident Response Team Comms
- Incident Response Metrics
- Metrics w.r.t. Response Capabilities
- Management & Inter-Departmental Relationships

See NIST Special Publication 800-61r2. Revise annually.

## Documented Incident Type/Category Definitions

- Web/Cloud
- Email
- Improper Usage
- Equipment Damage/Loss/Theft

## Roles and Responsibilities

- Who can confiscate equipment, terminate accounts, etc.?
- Who can disconnect networks?
- Who monitors systems and analyzes their activity?
- Who handles external comms?

Also: Stakeholder management!

## Reporting Requirements and Escalation

The current standard for investigating a potential data breach is to have a report ready within 24 hours of becoming aware of the potential incident.

## Cyber-Incident Response Teams

A.k.a., the CIRT or CSIRT (Computer Security Incident Response Team). Which would be the “incident response team” above.

Three models:

- Centralized (single team)
- Distributed (multiple teams responsible for different types of incidents or distinct geographic areas)
- Coordinating (same as the “distributed” model, but coordinated by a central team)

## Training, Tests, and Exercises

The difference between a “test” and an “exercise” is that the former uses real systems (for example, the backup restoration procedure) while the later is a simulation (tabletop exercises, etc.). Tests tend to be _functional_, while exercises can be either functional or scenario-based (the latter are “tabletop” exercises).

## Incident Response Process

- Preparation
- Identification & Analysis
- Containment, Eradication, Recovery
- Post-Incident

## Preparation

Resources needed to respond to an incident:

- Secure comms, contact information, etc.
- Forensics tools
- Documentation and baselines for existing systems

These are typically consolidated into a “jump kit”.

## Incident Identification and Analysis

Impact classification axis:

- Functional (i.e., severity)
- Information (e.g., data breach)
- Difficulty (of recovery)

## Containment, Eradication, and Recovery

The emphasis here is on treating work areas experiencing an incident as crime scenes, though this seems potentially less applicable as more systems/services are mored to the cloud.

## Continuity and Recovery Plans

BCP = Business Continuity Planning

COOP = Continuity of Operations Planning

DRP = Disaster Recovery Planning

## Disaster Recovery

- Disaster Recovery Plan (how to recover)
- Disaster Recovery Policies (who does what during recovery)
- Service Level Agreements

(One of these things is not like the others…)

One thing to keep in mind here is how to handle _active_ sabotage or additional losses during the recovery efforts…

## Continuity of Operations Planning

A.k.a. business continuity planning (but for government).

Active succession planning is highlighted here, though in my experience it’s often neglected in the corporate world (but maybe I’ve just never interacted with the right corps).

Tabletop exercises are used here too.

## Containment and Eradication

Generally containment is accomplished via network isolation or endpoint configuration changes, rather than by shutting things down.

## Quarantining

Three types of systems:

- Infected
- Patched
- Unpatched

## Configuration Changes

- Content/Email/URL filtering
- Certificate revocation
- DLP rule changes

When responding to an incident, in general you want to implement the control that prevents the widest range of attacks _without_ compromising needed functionality.

## Application Control

Microsoft’s application black/whitelist solution is AppLocker. AppLocker can function based on digital signatures, application path, and hash.

Allowed lists are more useful for _preventing_ incidents; blocked lists are more useful as part of (short-term) incident response.

## Secure Orchestration, Automation, and Response (SOAR)

Orchestration/Automation + threat intelligence + incident response. Basically, data goes in while policies and automated actions come out. The advantage here is that incident response can be more formalized and faster than is otherwise generally possible.

“Incident response plans” provide general guidance, while “playbooks” outline formalized response steps for specific types of incidents.

Things a SOAR system can automate:

- Update/revoke certificates
- Changing network configurations based upon detected anomalies or ingested IOCs
- Implementing more aggressive DLP policies, such as host isolation
