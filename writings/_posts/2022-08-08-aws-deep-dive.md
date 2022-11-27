---
title: AWS Deep Dive
date: 2022-08-08 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-08-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-08-08

Today I’ll be covering the “Migration and Innovation” module from the “AWS Cloud Practitioner Essentials” course.

- [AWS Cloud Practitioner Essentials](https://www.aws.training/learningobject/curriculum?id=27076)

# Cloud Adoption Framework

This is actually a compilation of frameworks around AWS migration, each one geared towards a different class of stakeholders (called “perspectives”): Business, People, Governance, Platform, Security, and Operations.

The BUSINESS perspective relates to company-wide strategies and goals, and is geared towards managers, financial, etc.

The PEOPLE perspective focuses on organizational structure, and is geared towards managers, HR, etc.

The GOVERNANCE perspective is about business processes. It’s geared towards managers, the C-suite, etc.

The PLATFORM perspective relates to IT architecture and infrastructure writ large, and is intended for IT staff, the C-suite, etc.

The SECURITY perspective focuses on IT security issues and systems (including user permissions), and is thus geared towards cybersecurity teams, the C-suite, etc.

The OPERATIONS perspective is about day-to-day IT operations. It’s focused on IT staff (specifically support and operations).

# Migration Strategies

Amazon categorizes cloud migration strategies into six broad buckets (called the “6 Rs”): Rehosting, Replatforming, Refactoring, Repurchasing, Retaining, and Retiring.

The “6 Rs” aren’t about company-wide strategies - rather, they’re strategies that would be applied to specific applications or services. Thus, most businesses will use a mix of strategies for their _overall_ migration.

- REHOSTING is just the “lift and shift” migration strategy.
- REPLATFORMING is an extension to “lift and shift” - think of it as “lift, tinker, and shift”. This is about using different platforms so long as _no_ code changes are made.
- RETIRING is just what it sounds like - do you _really_ still need this application?
- RETAINING just means that you decide _not_ to migrate a particular application to AWS (or the cloud in general) after all. Sometimes this is permanent, but sometimes this is because an application is already being spun down, so why spend the effort migrating it when it’s already (almost) end-of-life?
- REPURCHASING means purchasing an entirely new, cloud-native solution for an application or capability. This can be expensive up-front.
- REFACTORING (also called “re-architecting”) is about actually writing new software, or new software components to migrate an application. This is the highest risk/reward option.

# The AWS Snow Family

The “snow family” is a set of special-purpose devices used to aid in the migration of large amounts of data to AWS.

SNOWCONE holds up to 8 TB of data. Information loaded onto a snowcone device is normally transferred to S3 once the device has been returned to AWS.

SNOWBALL EDGE are rack-mounted devices that can perform data pre-processing before storage. There are two varieties: A storage-optimized version with an 80 TB capacity and a compute-optimized version with a 42 TB capacity but the ability to perform much more intense pre-processing. They support local Lambda functions for data processing, and are intended to be used in remote locations that don’t have the necessary hardware to handle a data migration already on-prem.

SNOWMOBILE is a mini data center (up to 100 PB of storage) that’s housed in a shipping container. A dedicated security detail protects snowmobile in transit.

All snow family devices use encryption at rest, with keys that can be managed by AWS KMS.

# Innovate with AWS

AWS supports VMWare (though it’s a special service).

SageMaker is an in-house machine learning solution (though it supports open source frameworks as well). “Amazon Augmented AI” is a similar solution.

The core Alexa AI is offered as a service under “Amazon Lex”.

Textract handles text extraction/OCR.

Amazon actually maintains its own _satellites_, which are sold in a service model via AWS Ground Station.

