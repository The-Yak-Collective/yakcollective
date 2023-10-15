---
title: 'TryHackMe: Complete Beginner (Supplements)'
date: 2021-11-09 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-09-tryhackme-complete-beginner-supplements.html
author: 100007
---

# Splunk

## Can You Dig It?

Mostly this section is just looking things up in the Splunk Quick Reference Guide.

Splunk stores imported data in “indexes”; log timestamps are stored in the `_time` field.

The `bucket` command can be used to group results by time or other metrics _during processing_. However, chart processing uses the `span` directive instead.

Some acronyms:

- SOC: Security Operations Center
- SIEM: Security Information and Event Management
- BOTS: Boss of the SOC (some kind of Splunk competition)
- CIM: Common Information Model

Various Splunk apps (extensions, really) can be found at https://splunkbase.splunk.com. Forums and the like can be found at https://community.splunk.com.

- [Splunk Quick Reference Guide](https://www.splunk.com/pdfs/solution-guides/splunk-quick-reference-guide.pdf)

## Halp, I’m Drowning in Logs!

The cyber killchain:

- Reconnaissance
- Weaponization
- Delivery
- Exploitation
- Installation
- Command & Control
- Actions on Objectives

## Advanced Persistent Threat

In Splunk, searching for `*` matches any _non-null_ string. This is particularly useful when combining data sources, doing lookups, etc., as adding a subsearch like `| search field_name=*` will ensure that only rows that actually matched are returned.

Because Splunk aggregates logs from multiple sources, field names might not always be named consistently Because of this, a common pattern is to include searches like `(field_1="term" or field_2="term")`. Note that it’s also possible to leave the field specification off entirely, in which case the provided “term” will be searched for in all fields.

Sysmon records a program starting up using the EventDescription of “Process Create” and an EventCode of 1.

In Splunk, “source” and “destination” refer to the initiator and receiver of a network connection, _not_ individual packets of data. So normally a web server would only be a “destination”, even though it can respond to the “source” with quite a lot of data.

Possibly useful sites for getting OSINT domain information:

- http://robtex.com
- https://threatcrowd.org
- https://threatminer.org
- https://hybrid-analysis.com
- https://virustotal.com
