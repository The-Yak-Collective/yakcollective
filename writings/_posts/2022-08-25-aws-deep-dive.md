---
title: AWS Deep Dive
date: 2022-08-25 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-25-aws-deep-dive.html
author: 100007
---

# A Serverless Journey: AWS Lambda Under the Hood

[AWS re:Invent 2018: A Serverless Journey - AWS Lambda Under the Hood (YouTube)](https://youtu.be/3qln2u1Vr2E)

Lambda is a containerized service on the backend - function code is run by workers, each of which manages multiple “sandboxes”. Workers are managed by a “worker manager”, and are recycled every 8 - 10 hours. Sandboxes are destroyed if they become idle for some period of time in order to free up resources.

A worker is an entire physical server.

In the original Lambda model, each worker ran multiple VMs, each of which contained multiple sandboxes.

New Lambda systems use “bare metal” EC2 virtualization, and spin up many more, smaller, VMs each of which contain a _single_ sandbox (this newer architecture is reminiscent of how the Linux environment is implemented on Chromebooks).

Every sandbox runs only a single function over its lifetime, though multiple calls to that function may happen consecutively. On both old and new Lambda systems, VMs correspond to individual customers.

Control groups (cgroups) are used to enforce function memory and CPU limits (presumably some level of enforcement also happens at the VM level for newer “bare metal” Lambda systems).

VM devices in the newer “bare metal” VMs are all virtio based. The host-side device emulation models are themselves sandboxed, and the code itself is written in Rust.

Lambda concentrates load on the smallest possible number of sandboxes, rather than trying to distribute the load over many sandboxes. This makes scaling easier, and hence faster.

One the other hand, load (for a given type of function call) is distributed _evenly_ amongst workers to prevent correlated load spikes. This is _not_ to say that workers are run with partial load - rather, they have a variety of _kinds_ of lambda functions (both in terms of language, complexity, and origin account) sandboxed on them. (In fact, Amazon applies some additional statistical tracking of Lambda function performance and tries to pack together functions that are _anti-correlated_.)

All Lambda functions exist within the current VPC. The associated network cards are actually provisioned _separately_ from the Lambda functions, however, with multiple sandboxes attached to a single card using secure tunnels. This somewhat unusual setup is done to reduce startup latency, as it turns out that provisioning a new network card within a VPC is relatively expensive.

The AWS API gateway can call into Lambda functions for actual execution.

In order to optimize Lambda worker placement, one subnet should be dedicated to Lambda _per availability zone_.

# Introduction to the AWS CLI

[AWS re:Invent 2017: Introduction to the AWS CLI (YouTube)](https://youtu.be/QdzV04T_kec)

Order of preference for account configuration in the AWS CLI: Command line options \> Environment variables \> `~/.aws/credentials` and `~/.aws/config` files \> AWS container-level credentials \> AWS EC2-level credentials.

For the `~/.aws/*` files, the `default` profile will be run if no explicit profile is specified.

The `--endpoint-url` is used with Snowball hardware.

There’s an AWS “shell” available that wraps the CLI and provides tab-completion and live menus for EC2 instances, etc. Pretty cool.

The AWS CLI supports asking for MFA codes, and will cache the resulting authentication for the appropriate timespan. If MFA presence is required to assume a role, then the CLI will automatically prompt on `AssumeRole`.

The AWS CLI `--filter` option is server-side but only supported for a few commands, while the `--query` option is client-side but is supported for all commands. Both commands define searches using JMESPath.

- [awslabs / aws-shell](https://github.com/awslabs/aws-shell)
- [JMESPath](https://jmespath.org/)
