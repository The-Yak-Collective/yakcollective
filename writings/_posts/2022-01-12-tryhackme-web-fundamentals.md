---
title: 'TryHackMe: Web Fundamentals'
date: 2022-01-12 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-12-tryhackme-web-fundamentals.html
author: 100007
---

# TryHackMe: Web Fundamentals

**author:** Nathan Acks  
**date:** 2022-01-12

# Introduction to OWASP ZAP

## Introduction to ZAP

ZAP (the “Zed Attack Proxy”) is basically an open-source version of Burp Suite. Paid features of Burp Suite that ZAP has:

- Automatically build a sitemap
- Automatically scan for vulnerabilities
- Full speed Intruder-like functionality

Burp Suite \<-\> ZAP equivalencies:

- Site Map \<-\> Site Tree
- HTTP History \<-\> History
- Scope \<-\> Context
- Interceptor (Proxy) \<-\> Break
- Repeater \<-\> Request Editor
- Intruder \<-\> Fuzzer
- Spider \<-\> Spider
- Scanner \<-\> Active Scan
- BApp Store \<-\> Add On Marketplace

ZAP uses web automation to control an external browser, rather than a built-in version of Chrome.

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## How to Perform an Automated Scan

Automated scans can be fired off using the “Automated Scan” button on the ZAP Quick Start tab.

The “traditional spider” option spiders the website as you would expect, while the “AJAX spider” uses a headless browser to spider AJAX content.

## Manual Scanning

At least on Kali Linux, ZAP can launch a pre-configured Firefox session using web automation; thus, like Burp Suite, there’s really no need to configure a local proxy (and probably every reason not to – keep your profiles separate!).

One reason _not_ to use ZAP’s browser, however, is that the user-agent is less generic than Burp Suite’s.

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## Scanning an Authenticated Web Application

If you’re using the pre-configured ZAP browser, session cookies are automatically passed along to ZAP. That means that you can spider pages requiring authentication from ZAP by simply logging in using the ZAP-configured browser.

## Brute Force Directories

ZAP has gobuster-like functionality called “Forced Browse”. The wordlist can be configured in Tools \> Options \> Forced Browse; enumeration can be started by right-clicking on the target site and choosing Site \> Force Browse Site.

- [Using “gobuster”](https://cardboard-iguana.com/notes/gobuster.html)

## Brute Force Web Logins

Requests can be sent to Fuzzer by right-clicking and choosing Attack \> Fuzzer. The interface is similar to Burp Suite’s Intruder, except that to add a region to fuzz only requires that you highlight the word and hit “Add” under “Fuzz Locations” (this will then open up another dialog where you can choose what payloads, such as wordlists, that you want to use).

ZAP’s Fuzzer tries to list successful results as “reflected”, but this seems prone to false-positives. However, changes in response size remain a good indicator of a successful attack (just like in Burp Suite).

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## ZAP Extensions

It’s probably a good idea to set Tools \> Options \> Passive Scanner \> Only scan messages in scope to “true”.

