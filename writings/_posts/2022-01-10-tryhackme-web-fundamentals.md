---
title: 'TryHackMe: Web Fundamentals'
date: 2022-01-10 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-10-tryhackme-web-fundamentals.html
author: 100007
---

# TryHackMe: Web Fundamentals

**author:** Nathan Acks  
**date:** 2022-01-10

# Burp Suite: Other Modules

## Hashing

Burp Suite displays hashes in the “Hex” view by default; to convert them into the (hex) ASCII string you’re used to, encode this output as “ASCII Hex”.

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## Sequence Overview

Sequencer is a tool for analyzing the entropy of a collection of tokens. Tokens can either be loaded in from a manual list, or “live” captured with the help of an example query imported from another module.

## Live Capture

It can take _a lot_ of tokens to run a reasonable entropy analysis; generally you’ll want something north of 10,000 examples (so, probably not something you can generate just by browsing around normally!).

Manual analysis can be conducted after the capture has either been stopped or paused. Alternately, checking the “Auto analyze” box will cause Burp Suite to run an analysis after every 2500 captures.

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

# Burp Suite: Extender

## The Extender Interface

The Extender tab allows Burp Suite modules to be loaded from from disk. Requests are passed through _all_ modules, from top to bottom.

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## The BApp Store

Modules provided by the Burp Suite App Store can be accessed and installed through the “BApp Store” tab. Extensions installed through this route can actually modify parts of the Burp Suite interface (adding new tabs, etc.).

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)
