---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-03-14 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-14-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

## Access Control Schemes

Access control is about how authorization is actually _enforced_.

Common access control models:

- MANDATORY ACCESS CONTROL (MAC): Subjects (users) are labeled with “access levels”, and objects are labeled with “sensitivity levels”. Subjects can then interact with objects _up to_ the sensitivity level that matches their access level.
- DISCRETIONARY ACCESS CONTROL (DAC): Subjects are provided with access to an object by that object’s “owner” via an ACL (technically a “DACL”). The ACL also defines what actions the subject can take with that object. (Note that most discretionary access control systems operate using an “implicit deny” approach - subjects that are not listed in an ACL are denied by default.) Computer permissions are a simple type of discretionary access control.
- ROLE-BASED ACCESS CONTROL: Subjects are grouped into “roles” that define object access.
- RULE-BASED ACCESS CONTROL: Subjects access to an object is defined by a set of pre-defined criteria. Most commonly seen in network-related settings where access may be controlled based upon subnets, protocols, etc.
- ATTRIBUTE-BASED ACCESS CONTROL (ABAC): Like rule-based access control, except that access is based on attributes (inherent properties) of the subject or object.

Confusingly, both rule-based access controls and role-based access controls us the acronym “RBAC”.

The difference between rule-based access controls and attribute-based access controls is that the former generally refers to access that’s granted depending on the subject’s current state, rather than by properties _inherent_ to the subject itself (it’s “attributes”). For example, allowing or denying access to a system based upon the user’s geographic location is an example of rule-based access control, while basing access on the user’s organizational unit is an example of rule-based access control.

As if the difference between rule-based and attribute-based access control wasn’t muddy enough, people will also refer to “conditional access”. Conditional access controls (CACs) generally look at the state of the _client_ the user is attempting to use to access the object in question, rather than attributes of the user themself (think: Google Workspace’s Context-Aware Access system). Conditional access controls generally define this state in both rule-like and attribute-like ways.

Finally, there’s “Privilege Access Management” (PAM). PAM systems are concerned with managing and monitoring user access (particularly administrator access). Up until now we’ve been talking about _approaches_ to managing access; PAM systems represent the class of software that actually _instantiates_ these approaches.

Examples: Thycotic, CyberArk, Arcon, One Identity Safeguard.

- [Context Aware Access (Google Workspace admin documentation)](https://support.google.com/a/answer/9275380)
- [Thycotic](https://thycotic.com/)
- [CyberArk](https://www.cyberark.com/)
- [Arcon](https://arconnet.com/)
- [One Identity Safeguard](https://www.oneidentity.com/one-identity-safeguard/)

## Account Management - Account Types

- “Administrators” have full system access.
- “Standard users” are your everyday users. This user class is distinguished by its inability to make system-wide changes (for example, software installation).
- “Guest accounts” have access to the computer, but _not_ to any resources on that computer (unless such access is _explicitly_ permitted). Generally used in kiosks or shared machines. Generally considered dangerous.
- “Service accounts” are non-human users. Generally highly restricted. “Managed” service accounts are managed by the system itself and thus don’t require explicit passwords or other user setup.
- “Shared accounts” are shared between users. Breaks non-repudiation, and generally is a bad idea. Should be avoided whenever possible.

## Account Management - Password Policies

- Complexity & length (everything from simple character set & length rules to more complicated measures of entropy)
- History (a.k.a., reuse)
- Maximum password age (a.k.a., expiration)
- Minimum password age (how long a user must wait before they can change their password again; used in conjunction with password history to force users to _actually_ use different passwords)

## Account Management - Account Policies

This is more Windows-specific. In particular, account policies in Active Directory apply to all objects in the directory (users, computers, etc.)

An account policy is generally a set of pre-applied configuration parameters that the user (or computer, or whatever) _cannot change_. However, in Active Directory you can also set some _access policies_, which determines under what conditions we have access to a particular system or object (RBACs/ABACs/CACs as we discussed above), through the same “User Properties” interface.

