---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-04-07 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-07-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

**author:** Nathan Acks  
**date:** 2022-04-07

# CompTIA Security+ Exam Cram

Today I’ll be reading Chapter 13 of the Security+ Exam Cram, “Cybersecurity Resilience”.

## Redundancy

Power redundancy options:

- Dual power supplies (within a PC/server)
- UPSes
- Generators
- Managed power distribution units (PDUs) - basically fancy power strips

## Load Balancers

Common algorithms:

- Round-robin
- Random
- Least (open) connections

All of these can also be weighted by various factors.

“Session affinity”, which ties a particular session to a particular server in the cluster, is important here for performance and complexity reasons.

## NIC Teaming

The idea here is to “bond” multiple NICs into a single logical unit. This logical unit can then be used for redundancy and load balancing in the same way that a server cluster might be.

## RAID

- RAID 0: Drives are logically joined in serial to create a single large drive.
- RAID 1: Drives are logically joined in parallel to create a single _redundant_ drive.
- RAID 5: At least three drives are joined in parallel, with space allocated so that the data on any one drive can be reconstructed should it fail. This creates a logical drive larger than any single drive (though not as large as all three drives), but with similar redundancy characteristics as RAID 1.
- RAID 1+0 / 0+1: Both of these approaches require at least four disks, and are sometimes collectively knowns as “RAID 10”. This is either a RAID 1 array where the component disks are actually RAID 0 arrays (0+1), or a RAID 0 array where the component disks are RAID 1 arrays (1+0)

## Backups

- Full
- Differential (difference since the last full backup)
- Incremental (difference since the last full or incremental backup)

At least some operating systems seem to have the concept of an “archive” bit which added whenever a file is changed. Full backups ignore but reset this bit. Differential backups use the archival bit but don’t reset it. Incremental backups use _and_ reset the archival bit.

## Defense in Depth

> Defense in depth stems from the philosophy that complete security against threats can never be achieved; the components that comprise a layered security strategy only impede threat progress until either the attacker gives up or the organization can respond to the threat.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Hardware Redundancy

“High availability” is considered 99.999% uptime.

RAID 0 is capped at 32 disks.

Note that all all RAID systems - even RAID 0 - write information sequentially across drives in order to maximize performance (block 1 to drive 1, block 2 to drive 2, and so on). In RAID 5 there is also a parity block that isn’t used for reads but is used to reconstruct data in the event of a disk failure. RAID 5 writes the parity block in a rotating fashion between drives (so that no two parity blocks follow each other and parity blocks are evenly distributed between drives).

## Site Redundancy

(General) redundancy types:

- Hot (everything is ready to go, just on standby)
- Warm (key systems are ready to go, but some reconfiguration required)
- Cold (equipment _might_ exist, but no configuration/readiness)
