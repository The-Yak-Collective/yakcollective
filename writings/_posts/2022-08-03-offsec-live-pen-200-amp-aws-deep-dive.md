---
title: 'OffSec Live: PEN-200 &amp; AWS Deep Dive'
date: 2022-08-03 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-03-offsec-live-pen-200-and-aws-deep-dive.html
author: 100007
---

# OffSec Live: PEN-200 & AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-08-03

The semi-regular Wednesday twofer: OffSec Live in the morning and the “Monitoring and Analytics” portion of the “AWS Cloud Practitioner Essentials” course in the evening.

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [Join OffSec Live](https://learn.offensive-security.com/offsec-live-webinars)
- [AWS Cloud Practitioner Essentials](https://www.aws.training/learningobject/curriculum?id=27076)

# OffSec Live: SQL Injection

Remember that when trying to bypass logins with SQL injection, it’s a good idea to use `limit 1` to ensure that the code gets back the expected number of results!

In MySQL, you can use `concat()` to return values from multiple columns in a single output field. Since `concat()` accepts hexadecimal values for ASCII characters, we can use `0x3a` (`:`) to make field separation obvious.

Sometimes you can chain queries as part of SQL injection. This isn’t useful for _retrieving_ input, but if the database is badly secured you can use this to _modify_ the backend database (obviously requires the application to be using the same user/permissions for both reads and writes). Use the `sleep()` function to test if this vulnerability impacts the system you’re attacking.

- [SQL Injection](https://cardboard-iguana.com/notes/sql-injection.html)

## MySQL Reverse Shells

It’s really hard to get a reverse shell in PostgrSQL. But MySQL and MariaDB are more exploitable.

You can “upload” reverse shells using MySQL using `INTO OUTFILE`: `'<?php system($_GET["cmd"]); ?>' INTO OUTFILE '/var/www/html/cmd.php'` (the path may require some brute-forcing or additional reconnaissance; sometimes you can force an error to return a potentially writeable path). This can then be leveraged into a reverse shell.

- [Exploiting MySQL](https://cardboard-iguana.com/notes/exploiting-mysql.html)

# Monitoring and Analytics

## CloudWatch

CloudWatch is primarily about log _monitoring_ - _metrics_ are extracted from logs, which can be watched by _alarms_ that trigger certain actions (like sending messages to SNS) when triggered.

CloudWatch can ingest data from on-prem systems, in addition to services/system in AWS.

## CloudTrail

CloudTrail is AWS’s (API) logging engine.

Logs are stored in S3.

Events are logged with 15 minutes.

CloudTrail has its _own_ alarm/automation system, called “CloudTrail Insights”.

You might thing of CloudTrail as being more concerned about account _activity_, and CloudWatch as being more focused on service/resource _performance_.

## Trusted Advisor

This seems to be a more general version of AWS Inspector - Trusted Advisor is more about your _entire_ AWS account, while AWS Inspector is geared more towards individual systems.

Trusted Advisor can detect S3 buckets with open access permissions. (It’s starting to sound a bit like Scout Suite.)

- [nccgroup / ScoutSuite](https://github.com/nccgroup/ScoutSuite)
