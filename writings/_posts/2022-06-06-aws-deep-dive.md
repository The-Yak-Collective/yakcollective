---
title: AWS Deep Dive
date: 2022-06-06 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-06-06-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-06-06

# AWS Essentials

More notes today from Linux Academy’s “AWS Essentials” YouTube playlist.

- [AWS Essentials (YouTube)](https://youtube.com/playlist?list=PLv2a_5pNAko0Mijc6mnv04xeOut443Wnk)

## Object Lifecycles

[AWS Essentials: Object Lifecycles (YouTube)](https://youtu.be/B-z9hNj3Fw4)

An “object lifecycle” is a set of rules in S3 that migrate objects between storage classes (or even delete them!) based on the age of an object.

## Permissions

[AWS Essentials: Permissions (YouTube)](https://youtu.be/X7vfDa1ygeo)

Permissions granted to (non-admin) users (at the individual/group level) or resources (at the individual/role level) only apply to _using_ a service in AWS. Permissioning for object create in a given service is still handled at the object level.

For example, giving a group full access to S3 _doesn’t_ give the members of that group access to any of the buckets created in S3 by other users in the account - _that_ access must be applied at the bucket level.

Note that making a bucket public is _not_ enough to make its contents viewable outside of the AWS account - there still needs to be a permission grant to “everyone” that makes the object/folder/etc. downloadable. (My take-away from this is that making an S3 bucket public is essentially changing the definition of “everyone” from “everyone in the current AWS account” to “_everyone_ everyone”.)

## Object Versioning

[AWS Essentials: Object Versioning (YouTube)](https://youtu.be/I-OW9Kr2NGs)

Note that suspending versioning _doesn’t_ delete old versions - it simply stops the creation of new object versions in that bucket. (And yes - once you’ve _enabled_ versioning for a bucket, you cannot disable it. Versioning can only be “suspended”.)

Be aware that new object versions do _not_ inherit the original version’s storage class - that’s set per object (even per versioned object).

## EC2 Basics

[AWS Essentials: EC2 Basics (YouTube)](https://youtu.be/dO1X7QG_4xw)

EC2 = Elastic Compute Cloud

In addition to “on-demand” and “reserved” instances, Amazon also has “spot” instances that are sold using an auction-like mechanism. The “spot” price fluctuates based on how much capacity is currently unused in EC2. When the spot price is at or below your “bid”, you _automatically_ get a spot instance configured and provisioned (at the cost is your bid). When the spot price _exceeds_ your bid, your instance is _automatically_ terminated and re-allocated to users with a higher bid. So spot instances _can_ be cheap, but access is unreliable (and becomes more so during peak usage periods).

## Amazon Machine Images (AMIs)

[AWS Essentials: Amazon Machine Images (AMIs) (YouTube)](https://youtu.be/B7M31vywgs4)

An AMI is basically just a templated VM with some configuration knobs. (Mostly these knobs are about “pre-installing” applications and setting up desired configurations. In practice, this translates to kicking off scripts during the AMI’s first run that _actually_ install and configure things for you.)

