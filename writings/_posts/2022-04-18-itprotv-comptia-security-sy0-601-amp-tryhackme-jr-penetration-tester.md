---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-04-18 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-18-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# CompTIA Security+ Exam Cram

Today’s reading is Chapter 28 from the Security+ Exam Cram, “Incident Investigation”.

## SIEM Dashboards

The key to SIEM alerting is the correlation engine - looking for user connections _after_ that user has left the office, etc.

## Logging

Log files = documentation (of system/application/user activity)

> Web server logs are usually access logs, common error logs, custom logs, and W3C logs. W3C logs are used mainly by web servers to log web-related events, including web logs.

Huh?

(It looks like W3C logs are just a particular standardized log format. Despite coming out of the W3C, only IIS and Amazon Cloudfront seem to use this.)

Windows Event Log fields:

- Type - Warning, error, information, etc.
- Time - Date/time for the computer _sending_ the log
- Computer - Computer name
- Provider Type - The facility that generated the event (generally the Windows Event Log)
- Provider Name - The name of the log (Application, Security, etc.)
- Source - Application
- Event ID - Standardized (_not_ unique!) identifier
- Description - Self-explanatory

Event IDs from the Windows Event Log can generally be looked up in the Microsoft Knowledge base.

One way to think about SNMP is as a data source for multi-system logs.

A Windows-centric list of log types:

- System
- Audit (events important for auditing and forensics needs; user logins go here)
- Security
- Access (system-to-system - not user! - access events)

Anomaly detection generally works better on network logs than device logs.

Heh… `journald` _still_ doesn’t have remote logging, instead relying on forwarding to a syslog-compatible daemon.

- [An SEOs Guide To W3C Log Files](https://www.screamingfrog.co.uk/an-seos-guide-to-w3c-log-files/)

## Network Activity

Most network activity monitoring tools don’t store actual packets, but rather just log metadata about those packets (minimally: source, destination, protocol).

## Protocol Analyzers

Protocol Analyzer = Packet Sniffer

Now we’re talking about actual packet capture!

## Network Flow

A.k.a. “NetFlow” (originally a Cisco thing, but since genericized). Basically, this is packet capture and analysis on router interfaces. NetFlow (and related tools like sFlow) are oriented towards understanding network usage rather than the behavior of individual machines/connections.

NetFlow data is exported using the IPFIX (Internet Protocol Flow Information Export) format.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Investigational Data Sources

SIEM = You 10,000 ft view

The SIEM correlation engine is just a (user defined?) list of event sequences of interest.

IPFIX is an IETF standard.

Wireshark has some statistical packet-analysis capabilities.

General log analysis flow: Filtered down to warnings/errors, locate an event of interest, and then expand your search around that timeframe to include lower-level/priority events.

Call out to WinDbg Preview, which is a free Windows dump file analyzer in the Microsoft Store. Windows typically stores dump files in `C:\Windows`, so you’ll need to copy it out to view it.

# TryHackMe: Jr. Penetration Tester

## Introduction to Meterpreter

Meterpreter is fileless, and attempts to mask itself using other process names. It only communicates back to Metasploit on an encrypted channel.

However, most modern antivirus _will_ still recognize it.

## Meterpreter Flavors

Meterpreter supports a wide range of operating systems; there are even variants designed to live inside of common server-side interpreters (Java, Python, and PHP). Most payload versions are singletons, though there are a few staged variants.

Most variants support communication over HTTP (unencrypted), HTTPS, or raw TCP (encrypted). IPv6 (which is often poorly monitored if allowed) is also an option.

As always, be aware that some exploits may limit the available Meterpreter payloads.

## Meterpreter Commands

Meterpreter’s commands vary depending on host OS. Some notable commands:

- `background` - Background the current session
- `clearenv` - Clears the (Windows) event logs (kinda obvious)
- `download` - Transfer a file from the target to the attacker
- `edit` - Edit a file
- `execute` - Execute a command on the host
- `getpid` - Get current process ID
- `getsystem` - Attempt to elevate to SYSTEM/root
- `getuid` - Get current process user
- `guid` - Get session ID
- `hashdump` - Dump NTLM hashes (on Windows)
- `ifconfig` - Display host network interface information
- `info` - Get information about a Meterpreter extension
- `load` - Load Meterpreter extension
- `migrate` - Migrate Meterpreter to another process
- `netstat` - Display host network connections
- `portfwd` - Forward a port on the host
- `route` - Mess with the host routing tables
- `run` - Run a meterpreter extension
- `search` - Search for files
- `sessions` - Switch to another (Metasploit) session
- `shell` - Drop to system shell
- `sysinfo` - Pull remote system information
- `upload` - Transfer a file from the attacker to the target

## Post-Exploitation with Meterpreter

Migrating Meterpreter to another process sometimes makes new commands become available; for example, migrating to a text editor will allow you to capture keystrokes.

Note that Meterpreter will happily let you migrate from a privileged to an unprivileged process - which may cause you to loose control of the target system!

You can background system shells launched from Meterpreter with `Ctrl + Z` to return to the parent (Meterpreter) process.

## Post-Exploitation Challenge

It’s always good to look at `help` in Meterpreter after loading a new module.

Remember that `load kiwi` will pull in a Meterpreter-specific version of Mimikatz!

Use `net share` on Windows to list _all_ current shares. The Metasploit `post/windows/gather/enum_shares` module provides cleaner output (requires backgrounding Meterpreter).

To execute `hashdump` you will need to be connected to the `lsass.exe` process.

Note that migrating Meterpreter will change its current working directory to that of the process it’s attaching to.

- [Using Mimikatz](https://cardboard-iguana.com/notes/mimikatz.html)
- [How to view all network shares in Windows](https://www.computerhope.com/issues/ch000534.htm)
