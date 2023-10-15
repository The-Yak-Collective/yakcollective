---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-03-30 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-30-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# CompTIA Security+ Exam Cram

Today I’ll be covering Chapter 10 of the Security+ Exam Cram, “Virtualization and Cloud Computing”. I won’t be doing any ITPro.TV lectures, however, as this is the first in another long stretch of readings I want to finish before starting the next sequence there.

## Virtualization

Exam Cram refers to virtualization as a solution for rising energy costs and environmental concerns… Neither of which actually seem right? Exam Cram also seems very concerned with VM escapes, which are a real worry, but still… Not exactly easy?

## Type I Hypervisors

Type I hypervisors are bare-metal, e.g., Xen.

- [Xen Project](https://xenproject.org/)

## Type II Hypervisors

Type II hypervisors are applications that run on a host operating system, e.g., VirtualBox.

- [VirtualBox](https://www.virtualbox.org/)

## Type I vs. Type II Hypervisors

Interesting… Hyper-V is actually a Type I hypervisor. I wonder if that means that Windows is actually virtualized in its entirety these days?

## Containers and Microservices

Containers are basically application + dependency bundles that are partitioned from the host system using kernel-level controls (namespaces under Linux); they thus share the same kernel as the host system, even though they have a different userland.

Microservices are a software development strategy in which monolithic applications are broken into smaller, special-purpose parts that communicate via a defined API. This allows for component services to be scaled and upgraded in a more dynamic fashion. Microservices are often (but not always) implemented using containers.

Uh, Exam Cram… I do not think that the JVM is the same idea as a hypervisor…

## Virtual Desktop Infrastructure (VDI)

VDE = Virtual Desktop Environment = The actual virtualized desktop.

VDI = Virtual Desktop Infrastructure = The software that manages VDEs.

## Virtual Machine (VM) Sprawl Avoidance

VM Sprawl = When an organization has multiple under-utilized VMs. Common after mergers, or when VMs don’t have a proper lifecycle management process.

Preventing VM sprawl basically means applying the same standards to your VM fleet as you should apply to your physical fleet.

## VM Escape Protection

> VM escape does not affect bare-metal platforms; it affects only hosted platforms.

Tell that to the Qubes people…

- [Qubes OS](https://www.qubes-os.org/)

## Software-Defined Networking (SDN)

Both Exam Cram and Wikipedia are entirely unclear about what exactly software-defined networking looks like in practice. Judging from the Wikipedia page on OpenFlow, it looks like this is just a method of centralizing both layer 2 and layer 3 decision making into one component (the “controller”), which then manages the routing/flow tables of component devices automatically. Packets that don’t conform to known rules are forwarded (either in full or in part, depending on implementation) to the controller, which then makes a decision about how to update routing/flow tables to handle the new packet. The goal is to keep packets from being forwarded to the controller.

- [Software-defined networking (Wikipedia)](https://en.wikipedia.org/wiki/Software-defined_networking)
- [OpenFlow (Wikipedia)](https://en.wikipedia.org/wiki/OpenFlow)

## On-Premises vs. Off-Premises

Exam Cram defines “managed service provider” quite broadly - I’ve only heard the term in relation to IT operations out-sourcing, but the definition here broadly includes any service offered under a subscription B2B model. This doesn’t include cloud infrastructure services like AWS and Google Cloud Platform, since the pricing for those is dynamic, but per-seat services like Google Workspace and Microsoft 365 do (I think) qualify.

Infrastructure models (feel free to mix-n-match):

- On-prem
- Hosted (third-party data center)
- Cloud

## Service Models

- IaaS (e.g., Amazon EC2)
- PaaS (e.g., Google App Engine)
- FaaS (e.g., Netlify Functions)
- SaaS (e.g., Microsoft OneDrive)

PaaS is distinguished by providing a managed environment on which code can be deployed. This means that many SaaS providers are also PaaS providers: Facebook apps, Google Workspace add-ons, etc.

All of these are collectively known as XaaS - Anything as a Service. Because that’s the first thing you think of when you see that acronym.

Exam Cram uses the term “fog computing” for strategies that distribute computing resources all the way from central cloud data centers to peripheral IoT devices. This is in contrast to “edge computing”, which favors computing on the consumer side only (think of “fog computing” as the “smear” between “edge computing” and “cloud computing”).

## Deployment Models

- PRIVATE: Cloud computing infrastructure restricted to a single organization.
- PUBLIC: Cloud computing hosted by a service provider. Data is generally only logically segmented between organizations. Most of what we commonly think of as “cloud computing” follows this model.
- HYBRID: Combined public/private cloud model
- COMMUNITY: Public or hybrid cloud model tuned to a specific industry (healthcare, defense, etc.).

# TryHackMe: Jr. Penetration Tester

## Web Browser

Wappalyzer is a potentially useful tool to automate the identification of website/server technologies. There’s a website and various browser extensions.

- [Wappalyzer](https://www.wappalyzer.com/)

## Ping

Windows `ping` uses the `-n` flag to specify the number of packets sent (in contrast to \*NIX’s `-c`).

Remember that the Windows firewall blocks ICMP echo/reply requests by default!

ICMP headers are 8 bytes; the first 4 bytes have a fixed meaning, while the meaning of the last 4 bytes varies depending on the type of request specified in the first 4 bytes.

- [Internet Control Message Protocol (Wikipedia)](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol)

## Traceroute

The IP header’s TTL value is actually the number of network _hops_ that it can transit, not a literal time. Every time a router hands off a packet, the TTL value is decremented by 1. Traceroute manipulates the TTL to purposefully cause “TTL exceeded” error, and uses the resulting ICMP response to map the logical network path being traced.

When the expected ICMP error is not received, traceroute indicates this with a `*`. In general multiple packets are sent at a time (by default, 3); if the packets take different routes, then the routes are displayed in sequence.

## Telnet

TELNET = Teletype Network

From 1969! Uses port 23 by default.

## Netcat

Useful flag I didn’t know before: `-k` keeps listening even after the initial client disconnection.

Given the general usefulness of netcat (you can straight up use it as a telnet replacement), it’s hard to see why you’d use telnet these days.

- [Using “netcat”](https://cardboard-iguana.com/notes/netcat.html)
