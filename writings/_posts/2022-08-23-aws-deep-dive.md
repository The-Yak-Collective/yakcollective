---
title: AWS Deep Dive
date: 2022-08-23 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-23-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-08-23

# DNS Demystified: Amazon Route 53

[AWS re:Invent 2016: DNS Demystified - Amazon Route 53 (YouTube)](https://youtu.be/UP7wDBjZ37o)

Route 53 has a 100% SLA (!!!).

Route 53 can resolve to geographically close hosts, handle failover, etc. All the things you would expect a DNS system hosted by Amazon to be able to do with Amazon Web Services.

Route 53 supports ALIAS/ANAME for A records.

Route 53 breaks up nameservers between clients in a similar fashion to AWS’s back-end networking HyperPlane nodes (see my notes about AWS VPCs from 2022-08-20) - nameservers _are_ shared between customers, but no two customers have the same _set_ of nameservers.

Route 53 can also be used to set up internal DNS for VPCs. Internal DNS has all of the features of Route 53’s external DNS, and as a bonus can use arbitrary TLDs.

Route 53 features a graphical interface for designing DNS routing rules (should a user get routed based on geographic proximity, fastest connection, and so on? how should server failover be handled? etc.), called “Traffic Flow”.

- [2022-08-20 - AWS Deep Dive](https://cardboard-iguana.com/log/2022-08-20-aws-deep-dive.html)
