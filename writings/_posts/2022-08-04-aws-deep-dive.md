---
title: AWS Deep Dive
date: 2022-08-04 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-04-aws-deep-dive.html
author: 100007
---

Today I’ll be covering the “Pricing and Support” module from the “AWS Cloud Practitioner Essentials” course.

- [AWS Cloud Practitioner Essentials](https://www.aws.training/learningobject/curriculum?id=27076)

# Free Tier

There are ~60 services in AWS with a free tier of some sort.

AWS has three classes of free tier: “Always free” (Lambda up to 1 million calls per month, etc.), 12 months free (EC2, within limits; note that the clock on services in this category starts ticking _as soon as you sign up for an AWS account_), and free trials of various lengths.

# Consolidated Billing

Organizations can include at most 4 accounts by default; adding more requires reaching out to AWS support.

When billing is consolidated within Organizations, _bulk usage_ is also consolidated. This means that discounts can become available for _all_ accounts if the organization’s _total_ usage qualifies. (It’s left unsaid, but the implication here is that free tier quotas will also be consolidated.)

When an organization qualifies for a bulk discount, the benefits of that discount are distributed to the component accounts in proportion to their usage.

# Budgets

AWS budget information updates every 8 hours.

# Cost Explorer

This is basically an application that allows billing data to be aggregated and displayed in various ways, as well as compared across time.

# Support Plans

Support tiers: Basic, Developer, Business, and Enterprise.

Only Enterprise gets an account manager.

Only Business and Enterprise get full access to all Trusted Advisor checks.

