---
title: 'OffSec Live: PEN-200'
date: 2022-07-15 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-07-15-offsec-live-pen-200.html
author: 100007
---

Today we’ll be focusing on _passive_ information gathering (which should really be the _first_ thing you do).

The big conceptual difference between “active” and “passive” information gathering is whether your activity “looks normal” to the defenders. So, browsing a website is passive (though it’s not _strictly_ so), as is using third-party tools that would _not_ alert the defenders (so Shodan, Google, and Netcraft are passive, but online port scanners are not).

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [OffSecOfficial Twitch Channel](https://www.twitch.tv/offsecofficial)

# Whois

The `whois` tool can also be used on IP addresses (in which case it will do a reverse lookup):

```
whois $IP_ADDRESS
```

# Google Hacking

Google search operators/hacks:

- `site:` - restrict search to the specified domain
- `filetype:` - only return results for a given file type (php, html, pdf, etc.)

# Netcraft

You can get a lot of additional server and DNS information using https://searchdns.netcraft.com/. This can also turn up subdomains.

# Harvesting Email

“The Harvester” is a tool for harvesting email addresses and subdomains from public websites.

```
theHarvester -d $EMAIL_DOMAIN -b $SERVICE_TO_SEARCH
```

# Shodan

Give it an IP, get back open ports, service versions, etc. There’s a lot of overlap with Netcraft, though not enough to make either tool redundant.

Shodan supports a lot of different filters for different services, IoT devices, vulnerabilities, etc.

# Stack Overflow

See if you can find accounts that are linked to your target, and then look for the questions they’ve asked. Sometimes the “answers” are not actually secure, and can be exploited!

