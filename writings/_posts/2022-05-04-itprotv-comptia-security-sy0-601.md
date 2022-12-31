---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-05-04 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-05-04-itprotv-comptia-security-plus.html
author: 100007
---

# CompTIA Security+ Exam Cram

Today I’ll be reading chapter 34 from the Security+ Exam Cram, “Risk Management”.

## Risk Analysis

Good definition!

> _Risk_ is the possibility of exposure to loss or danger.

Normally we talk about “risk” as if it were synonymous with “the probability that bad thing X happens”, but the Exam Cram breaks it down more formally as “Threat × Vulnerability × Impact”. (Here “Threat × Vulnerability” is more-or-less the colloquial meaning of “risk”, which means that we can also think of this as impact weighted by probability of occurrence.)

## Risk Register

A “risk register” is a document/database documenting various risks. Typical elements:

- Categorizations/Groupings
- Name/Description
- Some kind of risk score
- Potential impact
- Likelihood of realization
- Mitigations
- Residual (the risk induced by the mitigations)
- Contingency plans

## Risk Response Techniques

- Avoid (eliminate the risk entirely)
- Transfer (dump the risk on someone else; includes insurance)
- Accept (YOLO)
- Mitigate (reduce impact, likelihood, or both)

Most risk management is really about mitigation.

The Exam Cram has a good example for residual risk, likening it to how barred windows mitigates break-in risk but increases the risk of being trapped by a fire.

## Threat Assessment

Threat: The potential that a vulnerability will be exploited.

Threat Vector: _How_ a threat is realized.

Threat source types:

- Adversaries
- Accidents
- Acts of God

The Exam Cram breaks the last of these down into “structural” (i.e., infrastructure failures) and “environmental”.

## Risk Assessment

“Risk assessment” formalizes the “Risk = Threat × Vulnerability × Impact” relationship defined above.

- Identify threats
- Identify vulnerabilities
- Determine the likelihood the the threat will be realized (“threat × vulnerability”)
- Determine the impact of the threat being realized
- Determine the risk

Most risk assessments bound risk by fiscal year.

There are, frankly, a lot of arbitrary numbers being thrown around in this section. I suppose that the important thing here is that risks are ultimately _ranked_ by an organization in the correct order, and that risk _tiers_ are clearly defined. But this is all very hand-wavy.

## Single Loss Expectancy

“Single loss expectancy” (SLE) is the expected _monetary_ loss should a given risk be realized.

## Annual Rate of Occurrence

The “annual rate of occurrence” (ARO) is just the probability that the risk is realized within the given timeframe (typically a fiscal year, as mentioned above).

## Annual Loss Expectancy

The “annual loss expectancy” (ALE) is the actual _expected monetary impact_ of the risk (Annual Loss Expectancy = Single Loss Expectancy × Annual Rate of Occurrence).

This is used in exactly the way you’d normally use expected values.

## Business Impact Analysis

What “risk assessment” is to risk, “business impact analysis” is to impacts.

## Recovery Objectives

Recovery Point Objective: References data storage/processing/generation capabilities; the time that can elapse before the quantity of data lost due to a risk being realized exceeds the maximum allowable threshold as established in a business continuity plan. (Basically, acceptable data loss.)

Recovery Time Objective: The time within which a process must be restored as established in a business continuity plan. (Basically, how long a given application can be down.)

## MTTF, MTBF, and MTTR

MTTF: Mean time to failure. (Used for monolithic, non-repairable systems.)

MTBF: Mean time between failures. (Used for _components_ in modular, repairable systems.)

MTTR: Mean time to recovery.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Risk Management Concepts - Vocabulary

Via NIST Special Publication 800-31r1:

- Vulnerability: A weakness of some kind.
- Threat: An event or situation that, via a vulnerability, would prevent normal organizational operations in some way.
- Risk: The probability that a given threat will realize (via a vulnerability) an impact on the organization.
- Likelihood: The probability that something may happen.
- Impact: What a threat would cost/cause should it be realized. (Often expressed qualitatively rather than quantitatively.)
- Control: A mechanism to minimize risk. (Also called a “countermeasure”.)
- Residual: The risk that remains after all controls are applied. (Based on the Exam Cram’s discussion, I _think_ this should _also_ include any risks _introduced_ by the controls themselves.)

Note that these definitions are much closer to the colloquial definition of “risk” than what is presented in the Exam Cram.

## Risk Management Concepts - Types & Strategies

Steps in the risk assessment process:

- Prepare
- Conduct
- Communicate
- Maintain (keep it updated)

Conducting the assessment (step 2) can itself be broken down into five stages:

- Identify threats
- Identify vulnerabilities
- Determine likelihoods
- Determine impacts
- Determine the actual risk (expected losses)

Interestingly, Adam Gordon’s using “risk” within these substeps in a way that’s much closer to the Exam Cram than to the previous episode’s definitions.

Key risk types:

- External
- Internal
- Legacy systems
- Multiparty (federation, supply chain)
- IP theft
- Software licensing compliance (particularly important w.r.t. shadow IT)

Note that there’s a lot of overlap here between categories.

Risk management strategies:

- Accept
- Avoid
- Transfer
- Mitigate

Adam Gordon breaks cyberinsurance out as its own category, though it’s typically considered a type of risk transference. Cloud migration is also a type of (partial) risk transference.

## Risk Management Concepts - Risk Analysis

- Risk Register: The formal tracking system for all risks within an organization.
- Risk Matrix: A plot of risk in terms of probability of occurrence vs. impact.
- Risk Heat Map: A color-coded version of a risk matrix.
- Risk Control Assessment: A third party risk assessment.
- Self Assessment of Risk: An internal risk assessment.
- Risk Awareness: The subset of security awareness programs that focus on inoculating an understanding of risk.
- Risk Appetite: The amount of risk an organization is willing to tolerate.
- Inherent Risk: The native amount of risk that comes along with an activity, process, or system.
- Residual Risk: The amount of risk left over once appropriate controls have been applied to a given activity, process, or system.

Adam Gordon defines “risk analysis” as the _examination_ of risk, while “risk assessment” is the process of _defining_ risks in a given context. _Definitions_ occur before _examinations_, and thus risk assessments occur before a risk analysis.

Formally, the “single loss expectancy” (SLE) is defined as the asset value (which may be the income generated by the asset) multiplied by the “exposure factor” (which is the expected percentage of value of the asset in the event of an attack). This formula honestly only makes sense to me in the “asset as income” case; in other situations, wouldn’t the SLE be the repair/recovery costs?

In general, risk controls are implemented even when they cost as much as the ALE of the risk, since such controls still guard against less tangible qualitative losses. It’s only when the cost of the control begins to _exceed_ the risk’s ALE that an organization will accept the risk.

## Risk Management Concepts - Business Impact Analysis

“Business Continuity and Disaster Recovery” (BCDR) is the combination of two different types of plans:

- “Business Continuity” plans attempt to continue normal (or diminished) business operations in the event of an emergency/disaster.
- “Disaster Recovery” plans involve the prevention or minimization of data loss and operational disruption due to catastrophic events.

The the “BC” part is about _alternate_ operations during an emergency, while the “DR” part is about _recovering_ operations during a completely disruptive event.

The plans for each of these are known as BCPs, DRPs, or BCDRPs for the combined plans.

The reason business continuity and disaster recovery are increasingly lumped together is because events that take an organization _immediately_ to disaster are actually somewhat rare. It’s more common for an organization to instead suffer progressive (abd potentially rapid) deterioration from “normal operations” to complete disruption. This means that the business continuity plan is generally engaged _before_ the disaster recovery plan, and thus functions as something of a “final off ramp” before a formal disaster is declared and the DRP goes into effect.

“Business impact analysis” is basically about (1) identifying mission-critical functions/assets and (2) characterizing the consequence of a disruption to these functions/assets. Goals:

- Determine critical systems
- Determine maximum acceptable downtime for those systems
- Evaluate internal and external requirements to determine restoration ordering

Note that it’s sometimes desirable to bring up _less_ critical systems before _more_ critical ones as “guinea pigs” to help probe the post-disaster operational environment.

Steps:

- Gather requirements and information
- Assess vulnerabilities
- Risk analysis
- Result communication

Acronyms:

- MAD: Maximum Allowable Downtime
- MTD: Maximum Tolerable Downtime (synonym for MAD)
- RPO: Recovery Point Objective (the maximum amount of data that can be acceptably lost in the event of a disaster)
- RTO: Recovery Time Objective (the amount of time required to restore a non-functional system)
- WRT: Work Recovery Time (the amount of time required to finish restoring a _functional_ system, including data)

Basically, the RPO determines our _maximum_ backup interval.

RTO is concerned _only_ with infrastructure recovery, while WRT is the length of time that it takes to restore _working_ infrastructure to full operational capacity. This MAD = RTO + WRT.

