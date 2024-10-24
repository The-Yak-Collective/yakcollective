---
title: AWS Deep Dive
date: 2022-08-20 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-20-aws-deep-dive.html
author: 100007
---

# Amazon VPC: Security at the Speed of Light

[AWS re:Invent 2018: Amazon VPC - Security at the Speed of Light (YouTube)](https://youtu.be/uhXalpNzPU4)

VPC = Virtual Private Cloud

Think of a VPC as a “virtual data center”.

Default VPC MTU is 9001 bytes.

Some customers treat VPC as immutable bundles of infrastructure; instead of iterating individual systems, they version the entire “data center”!

Amazon Config takes point-in-time snapshots of the current AWS account configuration, allowing this to be versioned, rolled back, etc.

There are actually two different externally-facing VPC gateways: Internet gateways (that allow internal servers to have public IPs) and NAT gateways (which, well, do NAT’ing).

VPCs are defined with their own IP range. Presumably subnets within the VPC divide up _this_ network range.

VPCs networking is handled using hardware-based routers that are embedded in the actual AWS servers. These use custom, Amazon-designed silicon.

Packets within an AWS VPC are encapsulated within a custom AWS protocol before being routed within the AWS data centers’ physical networks. Because this is done by an independent (albeit embedded) hardware device that sits between the physical server and physical network, all of the VPC segmentation is _invisible_ to the actual AWS servers!

A similar, stand-alone device (called “Blackfoot”) provides edge routing between internal AWS networks and the internet at large (so, this is where VPC internet gateways live).

VPC routing is enabled by an internal AWS service called “mapping” that maintains a giant lookup table of actual EC2 instances and other virtualized systems matched against the corresponding physical hardware. VPC hardware routers communicate with the mapping service in order to add the correct routing information to packets coming from internal physical and virtualized systems. To maintain performance, the mapping service proactively pushes out portions of the routing table to the embedded routers.

The use of encapsulation using the mapping service makes it impossible for VPCs to attack each other.

AWS also runs firewalls and netflow _in addition_ to encapsulation on the embedded hardware routers.

All non-Blackfoot external routing is handled by a “shadow” cloud infrastructure called “HyperPlane”. This is where VPN, DirectConnect, NAT gateways, etc. live.

Interestingly, HyperPlane is _not_ VPC-aware (though it must understand the packet structure so that it can add/remove the appropriate encapsulation).

While HyperPlane nodes are shared, every customer gets a _unique_ set of nodes. No customer shares more than 2 nodes with another customer.

HyperPlane nodes are actually based on the S3 load balancer.

# Deep Dive on New Amazon EC2 Instances and Virtualization Technologies

[Deep Dive on New Amazon EC2 Instances and Virtualization Technologies (YouTube)](https://youtu.be/AAq-DDbFiIE)

The basic problem of virtualization: There are certain machine instructions that are “privileged” for the operating system (because of the processor-level security mode that OS code runs at). A processor can be virtualized when the errors caused when these instructions are run with a lower privilege level can be trapped and dealt with by more privileged code (which is why hardware virtualization requires OS support of some kind as well).

When an instruction run by the virtualized OS errors out, control is passed to a “virtual machine monitor” (VMM) that then emulates the effect of the instruction (this can require state tracking) and then hands control back to the original code.

The difference between “virtualization” and “emulation” is that in the former, the (statistical) majority of instructions are executed natively, while in the latter case the majority (or perhaps even all) instructions are handled by the VMM. (In modern virtualization systems, only one out of every million or even billion instructions are handled by the VMM.)

The VMM does not handle instructions that talk directly to hardware; in these cases, the VMM hands the instruction off to the “device model”.

It’s the device model that really slows things down - 100% of this is software.

A hypervisor consists of a VMM + the associated device models (of which there may be 100s) + things like memory management and scheduling that hold them all together.

Virtualization has actually existed (at least in theory) since 1974!

Paravirtualization involves modifying the guest OS to hook all calls that need to be trapped so that they point to the VMM (thus not requiring trapping to be done _in silico_, which wasn’t something that early Intel processors could do). Hooked calls are called “hypercalls”; the Xen Project pioneered this approach.

The original implementation of EC2 ran on the Xen hypervisor.

Modern Intel and AMD processors not only support trapping in hardware, but are actually architected so that fewer calls need to be trapped (basically, more can be run at lower processor security levels). This is hardware (assisted) virtualization.

In Xen, the device models run in dom0. In AWS, dom0 actually runs Amazon Linux.

Amazon has progressively moved more and more of the device models into dedicated hardware, starting with networking and followed by storage. This has evolved into the “Nitro” VM infrastructure, the core idea of which is that rather than devices being emulated solely in software, the device mappers are thin wrappers around specialized hardware (a “view” of which is essentially just “passed in” to the VM).

EBS devices are actually _network_ storage device (at the hardware level).

The full “Nitro” infrastructure moves the VMM and the “pass through” device models into a custom hypervisor based on KVM. There is now no dom0.

But now all the hypervisor does is run the VMM. So the latest generation of EC2 has moved to using a special hardware chip to enforcing cross-processor security boundaries, and then just runs the “virtual machines” directly on the host CPUs. Which means tat such “bare metal” instances aren’t even really “virtualized” anymore - its more like “partitioned hardware”.

This “bare metal” implementation is what enables VMWare to run in AWS. So we’ve now come full-circle - AWS started as a virtualization solution and moved through the “Nitro” system to something that looks, if you squint at it, philosophically similar to an FPGA (except using traditional CPUs, etc.). And because there’s no virtualization actually happening anymore, this means that this kind of “programable hardware” can itself run virtual machines!

