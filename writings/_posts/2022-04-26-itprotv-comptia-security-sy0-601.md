---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-04-26 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-26-itprotv-comptia-security-plus.html
author: 100007
---

# Security Controls

“Countermeasures” are another commonly used term for “controls”.

In either case, these are just whatever measures we’re taking to “avoid, detect, counteract, or minimize security risks”, in particular w.r.t. the CIA triad.

Systems of controls become frameworks/standards.

Security controls are classified into three categories:

- Administrative
- Logical
- Physical

Categories are themselves divided functionally into “types”:

- Preventative
- Detective
- Corrective
- Deterrent
- Recovery
- Directive
- Compensating

The key difference between “preventative” and “deterrent” control types is that “deterrents” make someone _not_ want to do something, while “preventative” control types actually _stop_ them from doing that thing.

Recovery controls are basically extensions of corrective controls: Corrective controls simply return a system to normal functioning, while recovery controls work to re-harden the system.

Preventative, detective, corrective, and recovery controls are _reactive_, while deterrence and directive controls are _proactive_; compensating controls can be either, depending on what missing (primary) control they’re acting instead of.

Most administrative controls are directives.

# Regulations, Standards And Frameworks

“Frameworks” are sets of guidelines and best practices covering a constellation of security controls.

Regulations and standards are basically prescriptive frameworks, the difference being that the first has the force of law, while the second is generally accepted within an industry (either by consensus or coercion).

PCI-DSS:

- Protect the cardholder data environment with a firewall.
- Change default passwords, etc.
- Protect cardholder data.
- Encrypt cardholder data in motion (across open networks).
- Use anti-malware.
- Keep your systems and applications secure/up-to-date.
- No shared accounts
- Restrict logical access to cardholder data.
- Restrict physical access to cardholder data.
- Monitor all access to networks and systems that contain/process/transmit cardholder data.
- Regularly test your security measures.
- Document all of this, and maintain applicable employee policies.

CIS Top 20 Controls:

- Basic controls (1 - 6)
- Foundational controls (7 - 16; build on the basic controls)
- Organizational controls (17 - 20)

NIST CSF (Cyber Security Framework):

- Describe the current posture.
- Describe the target posture.
- Identify areas for improvement and repeatable processes that ratchet the organization in that direction.
- Determine how to assess progress.
- Establish channels to communicate with stakeholders.

The NIST CSF is divided into a “core framework” (cybersecurity controls), “profiles” (specifies how to apply core controls for a specific risk appetite), and “implementation tiers” (qualitative guides for assessing maturity).

NIST RMF (Risk Management Framework):

- Prepare to use the RMF.
- Categorize the system, information, and associated assets based on an impact analysis.
- Select and tailor a set of baseline controls.
- Implement and document the selected baseline.
- Assess the state and effectiveness of the selected controls.
- Authorize the system for normal operations.
- Monitor the state of the system on an ongoing basis (may lead to starting over with “categorization” depending on this ongoing knowledge).

The NIST RMF is about tying risk management into the SDLC, extending the CSF “profiles”.

ISO standards:

- ISO 27001 - Requirements for information security management
- ISO 27002 - Controls necessary to enforce ISO 27001
- ISO 27701 - Extends ISO 27001 & 27002 to include privacy management
- ISO 31000 - Risk management

Adam Gordon recommends combining the NIST RMF (which is focused on IT risk management) and ISO 31000 (which is focused on organizational risk management) in order to obtain the most holistic possible risk management framework.

SOC reports can be divided into two “types”:

- Type I reports involves review and documentation, but _not_ testing, of controls.
- Type II reports cover a minimum period of 6 months and requires that controls be tested.

There are three kinds of SOC reports:

- SOC 1 reports are financial controls.
- SOC 2 reports cover non-financial controls.
- SOC 3 reports are stripped-down SOC 1/2 reports.

The CSA CCM (Cloud Security Alliance Cloud Controls Matrix) provides a list of almost 200 controls (!!!) focusing on the cloud supply chain risks.

There’s also lots of vendor guides.

# Spotlight On General Data Protection Regulation

Location data becomes “personal data” under the GDPR if it can be linked to a session, and thus a user.

The GDPR requires that the data controller and data processor be separate roles. In generally, data processors are external to an organization.

The fines for breaches and other security violations under the GDPR are the _greater_ of €10 million or 2% global revenue. But the fines for _misrepresenting_ how data will be used or handles are double this.

The GDPR data protection officer may be an individual in either the data controller, the data processor, or a third-party.

The data controller must notify the applicable governmental regulatory body within 72 hours of becoming aware of a breach. However, extensions can be requested.

