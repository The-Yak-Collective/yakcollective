---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-04 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-04-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-10-04

# Burp Suite

## Installation

Burp Suite doesn’t seem to be installed by default on Kali Linux ARM. However, it _can_ be installed using `sudo apt install burpsuite`.

## Gettin’ (CA) Certified

NOTE; By default the Burp Suite proxy is in “intercept” mode, which means that requests won’t go through unless we approve them. This makes it impossible to easily visit web pages through when the proxy is turned on, since each request needs to be manually approved. So continuing to work on the TryHackMe room requires either (temporarily) disabling this (Proxy \> Intercept \> Intercept is on \> [click to toggle off]) or just turning off the Burp Suite proxy in FoxyProxy.

Once the Burp Suite CA certificate is installed in Firefox, it will be listed under PortSwigger \> PortSwigger CA.

## Proxy

The PROXY tab controls how we funnel traffic through Burp Suite for analysis/manipulation. Requests can be routed from here to other tabs (in particular, Repeater and Intruder).

A log of all requests that pass through the Burp Suite proxy is accessible from “HTTP history”, and can be modified and replayed from here at will. (Data transmitted over websockets is similarly saved to “WebSockets history”.)

Setting “And URL Is in target scope” under Options \> Intercept Client Requests restricts proxy interception to just those sites (or parts of a site) defined in the Target tab. This allows the browser to be used normally for all sites not under analysis.

## Target Definition

The TARGET tab defines what we’re analyzing, and can generate a website map if desired.

By default, all hosts that the browser queries through the Burp Suite proxy are listed here. Paths are also recorded here, which allows for the building of basic site maps.

Typically, the first step in a web application test is to browse all accessible areas of the site, allowing Burp Suite to build out a full site map. Once site structure (and endpoints like password reset buttons!) have been enumerated, elements that are either explicitly out-of-scope or which could cause problems if accessed in an automated fashion (like password reset endpoints!) can be removed.

Hosts and paths can be added to scope using the right-click menu.

There’s also an “Issue definitions” list in the Target tab which defines issues that can be detected by the Burp Suite Scanner. Which isn’t _immediately_ useful in the community edition (since we don’t get the Scanner component), but each issues _does_ come with a pretty complete definition, so this is useful for developing shared terminology for reporting, etc.

## Puttin’ It on Repeat(er)

The REPEATER tab allows requests to be replayed (and modified).

The general difference between Repeater and Intruder is that the latter is fully automated, while the former allows for more fine-tuned analysis.

The typical workflow here is that you’ll do something, find the request in the proxy HTTP history, send that request to the repeater, and then replay/modify it there.

## Help! There’s an Intruder!

The INTRUDER tab is designed to help us _attack_ the web application (fuzzing, credential stuffing, scraping pages, etc.).

Generally the intruder is used after a proof-of-concept has been established using repeater. There are four different attack types:

- SNIPER repeats requests, cycling through items in a supplied wordlist across a selected set of positions. Only one position changes per attempt, and an item in the wordlist is only substituted into one position (the remaining positions in an attempt are held at the specified default).
- BATTERING RAM is similar to sniper, but tests all positions simultaneously. Each item from a wordlist is placed into _every_ available position (such that all defined positions have an identical value for a given run).
- PITCHFORK takes one wordlist per position and then just cycles each list in lock-step until it reaches the end of the shortest list.
- CLUSTER BOMB is the test that perhaps makes the most intuitive sense – it takes one wordlist per position and then tests every _possible_ combination.

## As It Turns Out the Machines Are Better at Math Than Us

The SEQUENCER tab contains a set of tools designed to test how “random” things like session tokens and the like _really_ are.

Sequencer works by repeatedly making a cookie-generating request (selected from the HTTP history) and then comparing the different cookie values received. More runs provide better entropy estimates. (The TryHackMe room uses 10,000 runs in its example, but it’s not 100% clear if this number is picked because it’s a good number, or because it doesn’t take an interminably long time to run. I’m inclined to believe the latter, as judging from the “live capture” bar Burp Suite presents, it probably wants something like twice this number of tokens.)

## Decoder and Comparer

The DECODER and COMPARER tabs are designed to make it easier to transform and compare data sent to, and responses from, the website being analyzed.

## Installing Some Modes (Extender)

The EXTENDER tab is where Burp Suite extensions are managed.

Many Burp Suite extensions require the standalone version of Jython, which unfortunately doesn’t seem to be available through Kali’s repos. The path to the downloaded Jython JAR file can be set in Extender \> Options \> Python Environment \> Location of Jython standalone JAR file.

- [Jython](https://www.jython.org)

## But Wait, There’s More!

The SCANNER tab is a web vulnerability scanner and spider (this is a paid feature, however, and isn’t present in the “community” edition of Burp Suite that is in Kali’s repos). Both the scanner and spider functionality can be run in the background while other tasks are being worked on.

Another paid tool is COLLABORATOR, which sounds like it allows tasks to be offloaded to PortSwigger’s infrastructure for longer scans/testing than may be feasible in a single setting.

