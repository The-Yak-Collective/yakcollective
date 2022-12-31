---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-02-28 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-02-28-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# CompTIA Security+ Exam Cram

## Weak Configurations

My favorite quip is here! “Unnecessary complexity” as a security vulnerability!

Elements of weak configurations:

- Errors
- Open permissions
- Unsecured root/system accounts
- Weak encryption
- Insecure protocols
- Default settings (IMHO, depends on the defaults)
- (Improperly) Open (or unneeded) ports/services

Another gem that parallels something I like to repeat:

> “An organization should never try to create its own cryptographic algorithms within systems.”
> 
> - CompTIA Security+ SY0-601 Exam Cram, 6/e

The Exam Cram implies that leaving all services enabled will seldom be the correct answer when presented with a device configuration scenario on the Security+ exam.

## Improper of Weak Patch Management

Types of updates:

- Hotfix: A targeted update that alters the target application or operating system in a limited way. Generally small and out-of-band.
- Service Pack: A bundle all hotfixes and updates (security or not) up to a certain point. Mostly a Windows thing.
- Update: A non-critical, non-security bugfix.

Microsoft divides updates into “security updates” (which address security issues), “critical updates” (non-security updates that fix high-impact bugs), and just plain “updates” (everything else).

## Third-Party Risks

Exam Cram indicates that the Security+ exam will likely ask about the dangers of end-of-life systems.

## Impacts

Type of potential incident impacts:

- Data loss (deletion, in this case)
- Data breach
- Identity theft
- Financial losses
- Reputational losses
- Downtime
- Physical danger and loss of life

# ITPro.TV: CompTIA Security+ (SY0-601)

## Vulnerabilities

Vulnerability: Any weakness that creates an avenue for attack.

Some specifics that the Security+ exam targets:

- Weak configurations (default, weak or non-exsistent encryption, insecure protocols, wide permissions)
- Cloud vs. on-prem
- Third-party risks

There are lots of third-party risks. Everything that might go wrong in-house can also go wrong with a vendor.

Many times the reason organizations will attempt to refactor third-party applications or drivers (see yesterday’s notes) is because of lack of current vendor support (and occasionally lack of vendor entirely).

- [2022-02-27 - ITPro.TV: CompTIA Security+ (SY0-601)](https://cardboard-iguana.com/log/2022-02-27-itprotv-comptia-security-plus.html)

# TryHackMe: Jr. Penetration Tester

## Viewing the Page Source

Who tries to hide secret links on their web page? But apparently, this is something more than one org does, and is a good reason to view source and/or inspect the DOM.

Also, another good reminder to look for indexable directories.

## Developer Tools: Debugger

Good to know - JavaScript breakpoints persist across page loads. (This makes sense, as many times JavaScript will only be run once, immediately after page load.)

In Firefox, breakpoints can be set by clicking on the line number in a JavaScript file viewed in the Debugger (Sources in Chrome) pane.

## Manual Discovery: Favicon

Quickly match a favicon to its framework!

Start by getting the favicon MD5 hash:

```
curl $URL_OF_FAVICON | md5sum
```

The look it up:

- [OWASP favicon database](https://wiki.owasp.org/index.php/OWASP_favicon_database)

## OSINT: Google Hacking / Dorking

Useful Google search modifiers:

- site: - Search only within the specified domain
- inurl: - Require term to be present in the URL
- filetype: - Only return results with the specified extension
- intitle: - Require term to be present in the page title

## OSINT: Wappalyzer

- [Wappalyzer](https://www.wappalyzer.com/)

## OSINT: S3 Buckets

It can often be fruitful to just attempt to _guess_ an organization’s S3 buckets. Common variants:

- `https://${NAME}.s3.amazonaws.com`
- `https://${NAME}-assets.s3.amazonaws.com`
- `https://${NAME}-www.s3.amazonaws.com`
- `https://${NAME}-public.s3.amazonaws.com`
- `https://${NAME}-private.s3.amazonaws.com`

I’ll bet dollars to donuts that “dev” and “prod” are also common suffixes.

## Automated Discovery

- [ffuf](https://cardboard-iguana.com/notes/ffuf.html)
- [gobuster](https://cardboard-iguana.com/notes/gobuster.html)

There’s also dirbuster, but I kinda prefer gobuster.

Note that the SecLists web discovery `common.txt` wordlist lives in /usr/share/wordlists/dirb/common.txt on Kali Linux.

## OSINT: SSL/TLS Certificates

Certificate transparency logs can be used to find subdomains with specially provisioned SSL certificates. The main option (given that the Google search tool is being taken down in a few months:

- [crt.sh](https://crt.sh/)

## OSINT: Search Enginers

A google search for subdomain enumeration:

```
site:*.example.com -site:www.example.com
```

Note that `*.example.com` searches subdomains of `example.com`!

## DNS Brute Forcing

The dnsrecon tool actually allows us to (attempt) to brute force subdomains from a wordlist:

```
dnsrecon --type brt \
         --domain $DOMAIN \
         --dictionary /usr/share/wordlists/metasploit/namelist.txt
```

## OSINT: Sublist3r

Alternative to dnsrecon (above), though not installed on Kali by default.

```
# Install Sublist3r
#
sudo apt install sublist3r
```

## Virtual Hosts

It turns out that ffuf can fuzz HTTP headers, which can be used to try to brute force virtual host entries.

```
ffuf -w /usr/share/wordlists/metasploit/namelist.txt \
     -H "Host: FUZZ.$DOMAIN" \
     -u https://$IP
```

Use `-fs $SIZE` to remove results of a particular size from the list (which you’ll probably need to do in most cases).

- [ffuf](https://cardboard-iguana.com/notes/ffuf.html)
