---
title: 'OffSec Live: PEN-200 &amp; AWS Deep Dive'
date: 2022-06-29 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-06-29-offsec-live-pen-200-and-aws-deep-dive.html
author: 100007
---

# OffSec Live: PEN-200 & AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-06-29

This entry was actually written over the course of most of the day, as the next session of Offensive Security’s free streaming “OffSec Live” class was in the morning and I worked on the “AWS Deep Drive” learning path in the evening.

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [OffSecOfficial Twitch Channel](https://www.twitch.tv/offsecofficial)

# OffSec Live: Basic Tools, Part 1

(Missed the first few minutes again…)

```
# Use netcat to connect to any port (like Telnet).
#
# -n Prevent DNS lookups (good to use with IP addresses, as
# otherwise netcat will try to look these up!)
# -v Increase verbosity (connection status, etc.)
#
nc -nv $IP $PORT
# Use netcat to scan for open ports (slow, TCP-only).
#
# -z Try to connect to all TCP ports, and report which are open
#
nc -nzv $IP
```

The difference between a “reverse” and “bind” shell depends on where you’re working/observing from. A “reverse” shell is when you’re _receiving_ the connection, while a “bind” shell is when you’re _initiating_ a connection.

- [Using “netcat”](https://cardboard-iguana.com/notes/netcat.html)

# AWS CloudFormation Tutorial

As the first part of today’s “AWS Deep Dive” I’ll be watching and taking notes on a video detailing how to set up a CloudFormation stack in AWS. I’ll follow this up by any additional notes about my experiences setting up my own version of the two demos.

## Video Notes

[AWS CloudFormation Tutorial (YouTube)](https://youtu.be/LDSMIvUuFOE)

The idea behind CloudFormation is to manage the multiple services that are required to run an application in AWS. It’s the same idea as AMIs in EC2, except that CloudFormation templates snapshotting AWS _infrastructure_ rather than just VMs. Once you have a CloudFormation template, you can use it to spin up identical copies of your infrastructure in multiple regions.

CloudFormation templates are defined as JSON or YAML blobs (normally configured using the AWS CloudFormation Designer).

Demos:

- Create an S3 bucket
- Create an EC2 instance with a LAMP stack (use the sample template)

Note that when you give a resource a name in CloudFormation, that resource _won’t_ be created with that literal name (which would obviously be problematic for things like S3). Instead, resources will be spun up using the format `${STACK_NAME}-${RESOURCE_NAME}-${RANDOM_STRING}`.

Information that needs to be filled in during stack creation is specified by the `Parameters`.

The default EC2 SSH login is `ec2-user`; only private key logins are allowed.

## Demo Stack Setup Notes

Note that the CloudFormation Designer does _not_ work well in iOS browsers! (In particular, drag-and-drop is next-to-broken…)

You _really_ want to let CloudFormation control your bucket name, since names must be globally unique!

If you want to edit the template name in the CloudFormation Designer, you need to be on the “Template” tab, _not_ the “Components” tab (whose name refers to the currently selected resource).

As far as I can tell, the random string appended to default CloudFormation names is always 12 lowercase alphanumeric characters.

EC2 instances created by CloudFormation have names like `i-${RANDOM_HEX_NUMBER}`, where `$RANDOM_HEX_NUMBER` is always 17 (👀) digits.

# Capacity Management Made Easy with Amazon EC2 Auto Scaling

[AWS re:Invent 2018: Capacity Management Made Easy with Amazon EC2 Auto Scaling (YouTube)](https://youtu.be/PideBMIcwBQ)

There are three different methods of autoscaling in AWS: EC2 autoscaling, application autoscaling (EC2 Containers, Aurora, DynamoDB, and AppStream), and AWS autoscaling (which scales bundles of resources in AWS, rather than just single services).

EC2 autoscaling works over a logical group of instances with a defined minimum and maximum number of instances. A variety of mechanisms can be used by the group to determine the “desired” number of instances (which is bound by the min and max) at a given time.

The instances launched by EC2 autoscaling are determined by the associated launch template, which defines instance type, AMI, security groups, SSH keys, etc.

While a launch template _can_ auto-configure the launched EC2 instances, it’s more common for organizations to create a “golden image” that already has all of the required applications and as much configuration data as possible embedded within it. (Netflix uses this approach.)

Puppet, Chef, and Ansible are also popular alternatives to the built-in launch template configuration capabilities.

Launch templates can also be used to manage various lifecycle tasks, such as provisioning external IP addresses or archiving log files. This is generally done using Lambda functions that are fired at particular points in the instance lifecycle. (Alternately - or additionally! - launch templates can generate SNS notifications or CloudWatch events when certain lifecycle stages occur.) (Netflix uses lifecycle hooks to make sure that instances are quiescent before termination.)

EC2 autoscaling integrates with both EC2 and Elastic Load Balancer health checks. Misbehaving instances will be automatically killed, and new instances started, as needed.

EC2 autoscaling also understands availability zones, and can divide instances between zones automatically. If there are repeated failures in one zone, autoscaling can even automatically shift instances to alternate zones, and then rebalance instances once zone health has been restored. (Netflix uses this; every autoscaling group maintains instances across three availability zones.)

EC2 autoscaling understands spot instances, and can be provided with target prices and group percentages for spot instances.

How is the minimum, maximum, and desired number of instances for a group determined? There are four methods: Manual scaling (“by hand”), scheduled scaling, dynamic scaling (which uses target metrics to determine when to scale up or down), and finally predictive scaling (this is similar to dynamic scaling, but it looks at historic data and tries to _anticipate_ when to scale up or down, rather than waiting for an “alarm” to be tripped).

_Do not set your scale-up and scale-down thresholds to the same value!_ Netflix has a story of a team doing this, and it caused the EC2 autoscaling service to continually churn instances.

The general take-away from Netflix’s part of the presentation seems to be “just use dynamic scaling with a single target”. That target should be indicative of instance _capacity_, not overall service _usage_; in practice, this _generally_ means scaling on CPU usage.

