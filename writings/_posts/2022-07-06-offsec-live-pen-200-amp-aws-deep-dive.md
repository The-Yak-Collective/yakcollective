---
title: 'OffSec Live: PEN-200 &amp; AWS Deep Dive'
date: 2022-07-06 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-07-06-offsec-live-pen-200-and-aws-deep-dive.html
author: 100007
---

Another entry written in two parts. As before, the OffSec Live class notes were in the morning and the “AWS Cloud Practitioner Essentials” notes are from the evening.

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [OffSecOfficial Twitch Channel](https://www.twitch.tv/offsecofficial)
- [AWS Cloud Practitioner Essentials](https://www.aws.training/learningobject/curriculum?id=27076)

# OffSec Live: Basic Tools, Part 2

(As is becoming normal, I missed some of the beginning of this. Though this time I was late because of technical difficulties, rather than poor planning.)

## NMAP & Wireshark

Nmap host discovery scans use the following tests (in order) for host discovery: ICMP ping, port 443, port 80, ICMP timestamp. Note that ICMP packets can only be sent when nmap is run with root privileges.

Even nmap’s host discovery scan (when run as root) can miss windows hosts. OffSec recommends supplementing this with a full scan of the top 10 most common ports with host discovery disabled (`--top-ports 10 -Pn`), as well as perhaps using a tool like `arping` (if you’re on the same network, of course).

Windows will respond to connections to closed ports with a RST packet _if_ the firewall is down. (If the firewall is up, it will simply _not_ respond.)

- [Using “nmap”](https://cardboard-iguana.com/notes/nmap.html)

# Global Infrastructure and Reliability

AWS controls (owns?) the fiber connections between data centers and regions.

Features are sometimes deployed on a region-by-region basis (generally if they’re hardware-dependent).

“Availability zones” are comprised on one or more data centers that act together as a unit. Regions contain multiple availability zones (_at least_ two), which are distributed geographically to make local disasters unlikely (but still close enough so that latency is negligable).

AWS recommends running across at least two availability zones in a region.

## Edge Locations

“Edge locations” are data centers that run services _apart_ from regions - CloudFront, Route 53, and Outposts (on-prem AWS data centers). These are more distributed than actual availability zones, as the point is to get these services as close to the actual customers/users as possible.

## Provisioning AWS Resources

“Elastic Beanstalk” and “CloudFormation” are similar in purpose. The difference is that Beanstalk functions as an EC2-centric abstraction layer (think: Heroku), while CloudFormation supports more services and is a full “infrastructure as code” offering. (In fact, formally Beanstalk is an application that runs _on top of_ CloudFormation!)

- [What is the difference between Elastic Beanstalk and CloudFormation for a .NET project?](https://stackoverflow.com/a/14429767)
- [AWS CloudFormation FAQs](https://aws.amazon.com/cloudformation/faqs/)

# Networking

While “Internet Gateways” route public traffic into a VPC, “Virtual Private Gateways” take care of routing traffic from _private_ networks (via a VPN).

A third option for connecting a VPC is “Direct Connect”, which is a dedicated fiber line from an on-prem data center to AWS (and from there the appropriate VPC).

VPCs can contain multiple Internet Gateways, Virtual Private Gateways, and Direct Connect lines, though each must be attached to its own distinct subnet (note, however, that a subnet does _not_ need to have _any_ of these features).

## Subnets and NACLs

All packets in AWS transiting between VPC subnets are checked using NACLs. Security groups provide EC2 instance level packet filtering. NACLs are stateless, while security groups are stateful (and always allow packets for established connections).

## Global Networking

Route 53 can provide geographically-dependent and load balanced DNS responses.

