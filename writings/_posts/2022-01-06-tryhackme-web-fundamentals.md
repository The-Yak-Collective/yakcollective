---
title: 'TryHackMe: Web Fundamentals'
date: 2022-01-06 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-06-tryhackme-web-fundamentals.html
author: 100007
---

# Burp Suite: The Basics

## Navigation

Useful Burp Suite shortcuts:

- `Ctrl + Shift + D` - Switch to Dashboard
- `Ctrl + Shift + T` - Switch to Target
- `Ctrl + Shift + P` - Switch to Proxy
- `Ctrl + Shift + I` - Switch to Intruder
- `Ctrl + Shift + R` - Switch to Repeater
- `Ctrl + F` - Forward intercepted request
- `Ctrl + U` - URL encode selected text in Proxy \> Intercept

## Options

Burp Suite settings:

- The “User options” tab contains _global_ settings.
- The “Project options” tab contains project-specific settings.

## Introduction to the Burp Proxy

Even when the proxy is not set to intercept traffic, it _will_ log traffic; check the “HTTP history” and “WebSockets history” Proxy sub-tabs. Any of these logged requests can be modified or replayed.

Server responses can be intercepted per request (though this obviously needs to be set when forwarding a request through the Proxy). Automatic rules can also be set in Proxy \> Options \> Intercept Server Responses.

## The Burp Suite Browser

The Burp Suite embedded browser is a fully up-to-date version of Chromium with a custom user agent string that matches the current version of Google Chrome. The Burp Suite proxy is already set up and active, and a Burp Suite TLS certificate is installed.

So, basically no need for FoxyProxy or any Firefox modifications!

## Scoping and Targeting

Sites can be added to the project scope under Target \> Scope.

You can also add them by right-clicking on a site in Target \> Site map. When you do this, you’ll be prompted to turn off logging outside of the scope. If you want to change this (or forget to set it), then you can still do so in Logger by clicking on the “Capture filter” bar and then checking the “Capture only in-scope items (Suite scope)”

You can further restrict the Proxy to only intercept in-scope requests under Proxy \> Options \> Intercept Client Requests by turning on “And URL Is in target scope”.

All of these settings are project-specific.

## Site Map and Issue Definitions

Target \> Issue definitions provides a list of the issues used by the vulnerability scanner built into the paid version of Burp Suite. For the Community Edition (i.e., what comes with Kali Linux), it’s basically just a massive reference.

