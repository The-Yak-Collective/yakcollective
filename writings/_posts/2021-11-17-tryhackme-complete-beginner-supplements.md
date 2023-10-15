---
title: 'TryHackMe: Complete Beginner (Supplements)'
date: 2021-11-17 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-17-tryhackme-complete-beginner-supplements.html
author: 100007
---

# MAL: Malware Introductory

## What Is the Purpose of Malware Analysis?

Three objectives of malware analysis:

- How is it spread?
- What are its IOCs?
- What does it do?

## Identifying if a Malware Attack Has Happened

Malware lifecycle:

- Delivery
- Execution
- Persistence (sometimes)
- Propagation (sometimes)

The last two of these stages are generally the noisiest. _Persistence_ produces primarily (only?) _host-based_ signatures, while _propagation_ leads to more _network-based_ signatures.

Malware is generally classed by how it _executes_ (i.e., what it does).

## Static vs. Dynamic Analysis

The difference here basically boils down to: Did you run it?

Seems like it’s probably best to do dynamic analysis in a cloud VM or something. Though a lot of malware tries to detect if it’s running in a VM these days, so…

## Discussion of Provided Tools & Their Uses

Some malware can actually spread over RDP. Ack!

## Now Let’s See if the MD5 Checksums Have Been Analyzed Before

I hadn’t noticed this before, but you can submit a file hash to VirusTotal instead uploading a file or submitting a URL. Handy!

- [VirusTotal](https://www.virustotal.com)

## Identifying if the Executables are Obfuscated / Packed

It seems like Windows executables have a magic number of `4D 5A`.

- [Magic Numbers](https://cardboard-iguana.com/notes/magic-numbers.html)

## Introduction to Strings

Microsoft Sysinternals has a `strings` command. Neat!

- [Sysinternals](https://docs.microsoft.com/en-us/sysinternals/)
