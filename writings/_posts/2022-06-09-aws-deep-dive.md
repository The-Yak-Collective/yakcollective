---
title: AWS Deep Dive
date: 2022-06-09 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-06-09-aws-deep-dive.html
author: 100007
---

# AWS Essentials

Today I’ll be finishing up the “AWS Essentials” YouTube playlist put together by the Linux Academy.

- [AWS Essentials (YouTube)](https://youtube.com/playlist?list=PLv2a_5pNAko0Mijc6mnv04xeOut443Wnk)

## Elastic Block Store (EBS)

[AWS Essentials: Elastic Block Store (EBS) (YouTube)](https://youtu.be/S0gzrxsVQHo)

IOPS is basically a measure of reads/writes (i.e., I/O) per unit time.

EBS volumes _can_ be used as the root volume of EC2 images, but other options are available.

By default, root EBS volumes are set to be deleted on EC2 instance termination. However, other options are available, which can be useful in a variety of ways.

EC2 instances can’t be booted from EBS snapshots directly. However, a snapshot can be used to populate the contents of a _new_ EBS volume, which can then be used as the root drive of an EC2 instance, so this isn’t really a limitation in practice.

Data stored as a snapshot is _a lot_ less expensive than the same data stored on an EBS volume.

## Security Groups

[AWS Essentials: Security Groups (YouTube)](https://youtu.be/-9j7BvAyb2w)

Security Groups are instance-level firewalls. In some ways they’re similar to NACLs, but allow/deny rules work a little differently: whereas traffic is processed by the first matching rule in a NACL (just as in a traditional stateless firewall), _all_ rules in a Security Group are considered when evaluating traffic.

By default, all inbound traffic is denied and all outbound traffic is allowed in new Security Groups. Somewhat confusingly, AWS also creates a “default” Security Group” for you as part of the provisioning process that allows _all_ traffic, both inbound and outbound.

There are no DENY rules for security groups, only ALLOW rules. Any traffic not matched by a rule will be dropped.

## IP Addressing

[AWS Essentials: IP Addressing (YouTube)](https://youtu.be/U32bPhQyQ6I)

EC2 instances can be launched with public IP addresses so long as the subnet its own is attached to a route that has an associated Internet Gateway.

EC2 instances in the default VPC will launch with public IP addresses out-of-the-box.

## Launching and Using an EC2 Instance

[AWS Essentials: Launching and Using an EC2 Instance (YouTube)](https://youtu.be/BCM9aaaWvR0)

When setting up an EC2 instance, you have the ability to specify a script that will be run on first boot. This is generally used to install and configure software.

## RDS and DynamoDB Basics

[AWS Essentials: RDS and DynamoDB Basics (YouTube)](https://youtu.be/KcJ8-I7kD_w)

RDS provides relational database services and supports a variety of database engines under the hood: MySQL/MariaDB, PostgreSQL, Oracle, SQL Server, and Amazon’s own fork of MySQL, Aurora. Note that Aurora is _not_ available in the AWS free tier.

DynamoDB is Amazon’s NoSQL option; there’s no choice of backends here, though DynamoDB itself is similar to MongoDB.

Pricing for RDS parallels that for EC2 (which makes sense), while DynamoDB pricing is looks more like S3 (if you squint).

## Provisioning and RDS MySQL Database

[AWS Essentials: Provisioning and RDS MySQL Database (YouTube)](https://youtu.be/OE25Sni15vo)

Not only can’t RDS use Aurora on the free tier, but it’s limited to running MySQL in “developer” mode (though it’s unclear what that means).

RDS instances aren’t provisioned directly into subnets like EC2 instances. Instead, you define a “subnet group” (which might contain only a single subnet). This determines which EC2 instances the RDS instance can communicate with. Note that the RDS instance will be automatically deployed to an availability zone matching one of the subnets in its subnet group, though you can override this (though you are similarly restricted) if you wish.

## SNS Basics

[AWS Essentials: SNS Basics (YouTube)](https://youtu.be/M4gQ8MLlgiY)

SNS = Simple Notification Service

SNS allows notifications from AWS to be pushed out to “subscribed” clients. These can be internal to AWS (SQS, Lambda) or external (HTTP push, SMS, email). Queues in SNS are called “topics”; sending a message to a topic will cause it to be pushed out to any “subscribed” endpoints (what this means in practice will vary depending on _how_ the endpoints are subscribed).

SNS and CloudWatch are often used together as a server event/alarm notification system.

