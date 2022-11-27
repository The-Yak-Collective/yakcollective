---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-03-16 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-16-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

**author:** Nathan Acks  
**date:** 2022-03-16

# CompTIA Security+ Exam Cram

Today it’s chapter 15 of the Security+ Exam Cram, “Physical Security Controls”.

A recurring theme here is to consider security measures based on whether you’re trying to monitor _access_ or prevent _theft_ (or both).

## Signs, Fencing, and Gates

6’ - 7’ in most situations, 8’ topped with barbed wire or razor wire for particularly high security areas.

“Hybrid gates” include both a card reader or keypad _and_ staff who can further verify visitor identity before opening the gate.

## Lighting

Use lighting with a high “color rendering index” - a measure of how faithfully lighting mimics the colors perceived in daylight (clear sunlight is defined as having a color rendering index of 100, the highest value). Light sources with more continuous spectra and that more accurately mimic blackbody radiation have higher color rendering indexes.

Twice-yearly inspection of exterior lighting.

- [Color rendering index (Wikipedia)](https://en.wikipedia.org/wiki/Color_rendering_index)

## Barricades and Bollards

A “bollard” is one of those short posts designed to prevent vehicle access while allowing pedestrian access.

## Internal Security

Role-based access control is commonly used for granting internal access.

## Motion and Infrared Detection

Infrared detection systems come in two varieties: Active (“trip” beams) and passive (heat source detection).

## Access Control Vestibules

Mantraps!

## Locks and Lock Types

Types of locks:

- Key locks
- “Cipher” locks (punch codes)
- Wireless locks (RFIDs)
- Swipe card locks

This section gets very “Sneakers”.

- [Sneakers (1992 film) (Wikipedia)](https://en.wikipedia.org/wiki/Sneakers_%281992_film%29)

## Equipment Security

Interesting stat: Laptop theft is about as common as car theft.

## Cable Locks

The most annoying anti-theft mechanism…

## Locking Cabinets and Enclosures

Apparently those built-in desk cabinets where computers are sometimes stored are called… “security computer cabinets”.

“Locking cabinets” refers specifically to filing cabinets and the like.

## Protected Cabling, Protected Distribution, and Faraday Cages

- Coaxial cable: Easy to tap! Does anyone actually use coax anymore?
- Twisted pair cabling can be divided into unshielded (UTP) and shielded (STP) categories. STP can incorporate a single shield for the entire cable, or can shield each wire separately (which reduces cross-talk and makes tapping harder).
- The “plenum” is the space between floors. Cabling run in the plenum is generally required to be more fire-resistant than regular cabling.
- Two governmental network systems are SIPRNET (the “Secure Internet Protocol Router Network”, for classified information up to “Secret”) and NIPRNET (the “Non-Classified but Sensitive Internet Protocol Router Network”). These use special tamper-resistant cables called “protected distribution systems” (PDS).

## HVAC

- HVAC: “Heating, Ventilation, Air Conditioning”
- Over-cooling risks condensation.
- Over-drying risks static discharges.

## Fire Suppression

Sprinkler systems come in two varieties: “Wet pipe” (which contain pressurized water from the get go) and “dry pipe” (which are connected to a pressurized water source, but stopped with pressurized gas in the actual sprinkler area). The reason to use a “dry pipe” system is to guard against possible pipe freezes and create a delay between when a fire is detected and when the actual water starts flowing (such a delay might allow for a chemical system to take care of the fire first, so that the sprinklers can be shut off _before_ the water reaches them, thus preventing equipment damage).

Fire classes:

- A: Wood, paper, etc. Extinguished with water.
- B: Liquids, gasses, grease. Extinguish with a foam fire extinguisher.
- C: Electrical fires. Extinguish with a carbon dioxide fire extinguisher.
- D: Metals. Extinguish with sodium chloride or copper powder.

## Hot and Cold Aisles

The idea here is to arrange server racks front-to-front and back-to-back, so that cold air can be delivered to one aisle (and pulled into the servers) and hot air is exhausted to the other (and immediately pulled into exhaust ducts).

Humidity should be kept in the 40% - 50% range.

Remember the importance of running sensors on a separate network than the rest of the building and/or to use cellular connectivity. Sensors are no use if they are subject to the same forces that can degrade “normal” equipment!

## Secure Data Destruction

Media sanitization methods:

- Declassification (YOLO)
- Degaussing (old-school media)
- Wiping
- Encryption (and throw away the key)
- Physical destruction

Exam Cram notes that data classification, security, and disposal guidelines are formally defined in a “sensitive information policy”.

Paper document disposal methods:

- Burning
- Shredding
- Pulping (reduction of paper back to cellulose fibers)
- Pulverizing (turn it into dust!)

# ITPro.TV: CompTIA Security+ (SY0-601)

## Physical Security

> Guards, gates, and guns.
> 
> - Wes Brian

From the outside-in:

- Fencing
- Bollards and barricades
- Security guards and robot sentries
- Cameras/CCTV
- Mantraps
- Reception (visitor logs, etc.)
- Alarms and signs
- Sensors (motion, noise, pressure, humidity, temperature)
- Locks (keyed, biometric, smart cards, PIN entry, key fobs)
- Faraday cages
- Cable locks
- USB data blockers (epoxy the ports!)

Camera systems can be “normal” continuous feeds, motion recognition camera (which are triggered by motion), and object detection cameras (which may automatically move or focus on objects of interest).

It’s a good idea to make sure that wall jacks are locked down, especially in common areas!

Sensors are useful not just for monitoring people, but monitoring environmental conditions.

Two-person control is useful for any highly sensitive or irreversible high-impact operations.

Key areas:

- Air gapped networks/systems
- Vaults and safes (often for backups)
