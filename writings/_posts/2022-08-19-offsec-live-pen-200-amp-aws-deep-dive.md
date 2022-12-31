---
title: 'OffSec Live: PEN-200 &amp; AWS Deep Dive'
date: 2022-08-19 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-19-offsec-live-pen-200-and-aws-deep-dive.html
author: 100007
---

Two things today: OffSec Live in the morning and finishing up the “AWS Cloud Practitioner Essentials” course in the evening.

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [Join OffSec Live](https://learn.offensive-security.com/offsec-live-webinars)
- [AWS Cloud Practitioner Essentials](https://www.aws.training/learningobject/curriculum?id=27076)

# OffSec Live: PEN-200

## Linux Privilege Escalation

Recommended privilege escalation resource (again): g0tm1lk’s Blog.

To have `top` display only those processes owned by `root` with their full path, use `top -c -u root`.

You can filter `top` using `o`. Filters specify the column, so for example `COMMAND=/bin/bash` will only show those processes that contain `/bin/bash` in their command line.

When a Python module is imported, the contained ` __init__.py` and any ` __init__.py` files in parent directories are automatically executed.

The default Python import path always looks in the current directory _first_. Note that the full path to imported modules can be specified on the command line, but _not_ with the commonly-used `-m` flag!

Reminder on how to find SUID binaries: `find / -perm -u=s -type f 2> /dev/null`

Linux will still bypass `/etc/shadow` if there’s a password hash in the second field of `/etc/passwd` (instead of an `x`)! Generate an appropriate password hash using `openssl passwd $PASSWORD`.

Also remember that multiple users with the same UID can be specified in `/etc/passwd`!

- [g0tm1lk’s Blog](https://blog.g0tmi1k.com/)

# AWS Cloud Practitioner Essentials

## The AWS Well-Architected Framework

- OPERATIONAL EXCELLENCE - Actual, well, operations work, with a focus on those aspects that most directly impact the organizational mission.
- SECURITY - mostly focused on encryption.
- RELIABILITY - backups, redundancy, and scaling.
- PERFORMANCE EFFICIENCY - architectural cost/performance optimization.
- COST OPTIMIZATION - similar to the above, but focused on cost optimization w.r.t. scaling.

This isn’t just a written framework, but is now also embodied by a tool accessible through the AWS console (though this tool is still just a simple questionnaire, rather than an actual automated analysis of the current AWS account).

## Benefits of the AWS Cloud

Trade fixed expenses for variable expenses.

Benefit from massive economies of scale.

Stop guessing capacity.

Increase speed and agility.

Stop spending money running and maintaining data centers.

Go global in minutes.

## Course Final Assessment

For S3 storage tiers, the “-IA” suffix stands for “Infrequent Access”.

Elastic Beanstalk is a tool for automating and scaling (pre-packaged) applications.

AWS Outposts is a tool for managing hybrid cloud environments.

EC2 “savings plans” are discounts that apply when a customer commits to a certain amount of computer time, while “reserved instances” are basically pre-paid on-demand (normal) EC2 instances.

EC2 “dedicated hosts” represent actual dedicated hardware (as opposed to VMs that may shift to different hardware when restarted).

