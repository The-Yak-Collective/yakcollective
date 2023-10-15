---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-05-07 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-05-07-itprotv-comptia-security-plus.html
author: 100007
---

# CompTIA Security+ Exam Cram

Today I’ll be working through my _last_ reading from the Security+ Exam Cram (chapter 35), “Sensitive Data and Privacy”.

## Data Sensitivity Labeling and Handling

Common data classification labels:

- Public
- Proprietary (normally protected by an NDA)
- Private (non-sensitive but confidential information; typically things like employee pay)
- Confidential (typically internal-only and need-to-know)
- Sensitive (highly damaging if disclosed; a step up in restrictions from confidential)

Data often changes its sensitivity level depending on its stage of use (for example, quarterly financials move from sensitive -\> public).

## Privacy Laws and Regulatory Compliance

Keep in mind that PII, like any kind of data classification, is contextual. A set of data points which is not PII by itself can become PII when combined with other data (deanonymization, etc.).

PHI needs to be protected for 50 years after the individuals death (!!!).

## Data Roles and Responsibilities

Key roles:

- Owner (determines the data classification level and is bottom-line responsible)
- Custodian (implements appropriate controls based upon the data classification determined by the owner)
- Privacy Officer (responsible for legal compliance and other risk management)
- Controller (GDPR; determines the use of the data)
- Processor (GDPR; an entity that processes or otherwise manipulates data).

Note that it’s not uncommon for a single person to have multiple roles w.r.t. a given piece/type of data.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Privacy and Data Sensitivity - Breaches & Data Types

Initial steps when containing a data breach:

- (Re)Secure your operations
- Fix exploited vulnerabilities
- Internal/Government notifications (legal, law enforcement, regulators)
- B2B notifications (vendors, business customers)
- Customer/Individual notifications

PHI breaches require that the USDHHS be notified, and may trigger mandatory _media_ notifications.

Broad data categories:

- PII
- PHI
- Financial
- Government/Regulatory
- Customer data (non-PII/PHI)

Governmental data classifications:

- (Higher levels, double-secret probation levels)
- Top secret
- Secret
- Confidential
- Unclassified

Equivalent common business data classifications:

- Confidential
- Private
- Sensitive
- Public

The idea here is to combine _both_ categories and classifications to determine who should have access to a given piece of data.

## Privacy and Data Sensitivity - Privacy Enhancing Tech

- Data minimization (in both collection _and_ processing)
- Masking (use “fake” data, normally for testing)
- Tokenization (replace sensitive data with a non-meaningful, _possibly_ reversible, representation)

Data masking can either be “static” (a completely altered data set) or “deterministic” (mapping “fake” data to the actual data in a one-to-one fashion). Masking sometimes is done one-the-fly when it is transferred between systems (“on-the-fly” masking is called “dynamic” masking when there is no “testing” datastore on the other side, just a process/application of some kind).

Data masking techniques:

- Encryption
- Scrambling
- Nulling
- Value variance (data is replaced by some mapping)
- Substitution (like value variance, but care is taken to make the “fake” data realistic)
- Shuffling (randomize values _within_ a dataset)
- Pseudonymization (any of the above, but with the goal that the link between the data set and the “real world” is broken while _maintaining_ patterns _within_ the data set)

The key difference between pseudonymization and anonymization is that the former is theoretically reversible (and may be _functionally_ reversible with access to the original mapping / lookup table), while the latter is not. Anonymization is actually quite difficult for real-world data without purposefully destroying the patterns/relationships within the data set.

## Privacy and Data Sensitivity - Roles & Responsibilities

“Roles” correspond to a particular _job_, while “responsibilities” correspond to that job’s _functions_.

- Subject (who’s the data about, anyway?)
- Data Protection Offices (GDPR role; responsible for training, auditing internal processes, and acting as the governmental point-of-contact)
- Owner (holds legal rights/controls over the data and is responsible for data categorization and classification)
- Custodian (responsible for dats custody, transport, storage, etc.)
- Steward (responsible for ensuring that data is fit for purpose & is handled in a manner compliant with corporate policies, government regulations, etc.)
- Controller (determines the why and how data will be processed, subject to the owner’s classification/direction)
- Processor (whoever’s actually processing the data)

## Privacy and Data Sensitivity - Other Areas

Information lifecycle:

- Create
- Store
- Use (by the creator/owner)
- Share (with others)
- Archive
- Destroy

Note that “use” and “share” are optional steps, and one or both may actually not happen.

A “privacy impact assessment” is just an assessment covering how PII is collected, used, shared, and maintained… And what the _impact_ to the business would be should any of these processes have a CIA breakdown. The goal is to make sure that privacy protections are integrated into the entire SDLC.

A “privacy notice” is the externally-facing version/description of a “privacy policy”.

