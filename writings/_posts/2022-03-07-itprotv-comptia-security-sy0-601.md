---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-03-07 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-07-itprotv-comptia-security-plus.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601)

**author:** Nathan Acks  
**date:** 2022-03-07

Because the next block of units on ITPro.TV cover three chapters in the Exam Cram (at least as best I can map them without having first read the chapters), I’m going to try something a bit different: For the next three days I’m only going to be doing the readings, and then I’ll set Exam Cram aside to work on the lectures.

I’m going to continue to title these posts after ITPro.TV though, since I’m thinking of the Exam Cram as just an adjunct to that.

# CompTIA Security+ Exam Cram

Today I’ll be covering chapter 12 of the Exam Cram, “Authentication and Authorization Design”.

## Identification and Authentication, Authorization, and Accounting (AAA)

IDENTIFICATION: The presentation of a claim to a unique identity (username, key hash, etc.).

AUTHENTICATION: The process of validating an identity (password, encrypted handshake, etc.).

AUTHORIZATION: The lookup of an authenticated identity to determine what access rights it has. Typically happens whenever a resource is accessed.

ACCOUNTING: Logging, minimally of authentication and authorization actions & results, but often also including additional statistics used for non-security purposes.

Key components of AAA:

- The client (device)
- The policy enforcement point (PEP) handles authentication
- The policy information point (PIP) holds the data necessary for the PEP to determine client validity
- The policy decision point (PDP) is the system that actually determines whether the client should be granted access (working with the PEP and PIP).
- Accounting & associated reporting systems

Note that these are _logical_ divisions, and may be combined within the same device or application.

## Multifactor Authentication

Possible authentication factors:

- Something you know (passwords, but also usernames)
- Something you have (most MFA tokens)
- Something you are (biometrics)
- Something you do (???)
- Somewhere you are (geofencing)
- Someone you know (web of trust)

What makes something _multifactor_ is the use of multiple factors from this list, _not_ multiple instances of the _same_ factor.

## Single Sign-On

Types of shared sign-ons:

- Federation
- Single sign-on
- Transitive trust

SOA: Service-oriented architecture. Basically, the use of proxies to sequester services behind a single sign-on and standardize the user experience. The standardization layer is often called a “wrapper”.

Exam Cram defines SSO as basically password caching + automation, but its typical usage is closer to that of “federation”.

## Federation

Federation is a system that allows multiple devices/service to share a single identity. Typically, systems accept attestations of authentication from the original authenticating entity.

Federation and SSO are typically used together, which probably accounts for the linguistic confusion. The key difference is that federated systems do _not_ exchange passwords, only tokens that attest to successful authentication. (I guess this makes SAML a protocol used for _federation_.)

## Transitive Trust

Transitive trust is more of an Active Directory thing, and is about establishing trust relationships between domains. These relationships can either be one-way (domain A trusts domain B, which means that users on domain B can access resources on domain A) or two-way.

Presumably, transitive trust requires some level of federation, so really this is about the authenticating entities of the domains trusting each other.

Connections between domains are called “trusts”, and trusts _can_ be transitive across domains (essentially, one domain can delegate its trust relationships to another).

## Authentication Technologies

Vocabulary that’s obvious when you think about it for a moment:

- Proximity card (for physical security)
- Security token (for all kinds of security).

## Tokens

Exam Cram defines a “key fob” basically as a physical login device like an RSA token, which is _not_ how I’ve ever head the word used before.

Time-based one-time passwords (TOTP) schemes should now be pretty familiar to everyone. A related scheme is HMAC-based one-time-passwords (HOTP), which replace the use of the current time with the number of times a code has been requested. HOTP is seldom used anymore, as codes are valid for an unknown length of time and are more difficult to recover from if the token’s iteration count gets out-of-sync with the server’s expected iteration count.

Token types likely to show up on the Security+ exam:

- TOTP - Time-based one-time password
- HOTP - HMAC-based one-time password (uses a counter instead of the time)
- SMS - One-time code sent via SMS
- Token key - Physical devices; sometimes called a “security key”
- Static codes - A list of single use codes; often used as a fail-safe backup
- Phone callback - A phone call that provides a OTP or push notification

## Biometrics

An alternative to storing biometric information server-side is to store it in an encrypted fashion on a smart card or other hardware token. This has the advantage of also providing a second factor.

- Fingerprint (easy to forge, can be altered by injury)
- Hand geometry (can be altered by injury)
- Voiceprint (lots of things can change your voice!)
- Facial recognition (relatively high false negative rate)
- Retina scan (high false negative rate)
- Blood vessel geometry (can be altered by illness)
- Signature (easy to forge, not particularly stable)
- Gait (can be altered by injury or drug use)

Vocabulary:

- FAR - False acceptance rate.
- FRR - False rejection rate.
- CER - Crossover error rate (the percentage of times the FAR and FRR are equal)

Yes, CER is a percentage of time that a system is in a particular percentage-based state.

## Card Authentication

Proximity cards for physical access control again! But proximity cards just contain a serial number, unlike smart cards (which are capable of storing additional data and/or performing cryptographic attestation).

## Certificate-Based Authentication

Certificate-based authentication is two-factor so long as the private key is protected with a password.

802.1X uses device-level certificate-based authentication for its highest security level.

The NIST PIV (personal identity verification) card and the DOD CAC (common access card) are both smart cards that contain cryptographically signed information about the user (including biometrics and current access rights), as well as a digital certificate used for computer/network identification. Both of these cards are PIN-protected.

