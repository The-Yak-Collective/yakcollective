---
title: 'TryHackMe: Web Fundamentals'
date: 2022-01-24 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-24-tryhackme-web-fundamentals.html
author: 100007
---

# TryHackMe: Web Fundamentals

**author:** Nathan Acks  
**date:** 2022-01-24

# SSRF

## What is SSRF?

SSRF = Server-side request forgery

Basically, this is a vulnerability in an externally-facing server (typically a web server) that allows the attacker (that’s me!) to query additional servers “behind” the vulnerable server that they wouldn’t normally be able to see.

## Cause of the Vulnerability

SSRF can also involve using the a vulnerable server as a relay to attack other servers on the internet.

Typically an SSRF attack requires that the application be passed a URL by the attacker and then acts on that URL without sufficient validation.

## SSRF Payload

Example SSRF test: Will the application allow you to open a connection to an arbitrary port, such as a local MySQL server? For example, does https://127.0.0.1:3306 return a response?

Other options:

- localhost
- [::] or :: (IPv6 localhost)
- 2130706433 (localhost in decimal)
- 0x7f000001 (localhost in hexadecimal)
- file:// (sometimes works for local file inclusion)

Note that different frameworks will, of course, munge inputs differently, and various filters may be in place. There’s no guaranteed path!

Decimal/Hexadecimal conversion for IPv4 addresses is relatively simple if you remember that we break IPv4 addresses up into 4 _octets_, where each octet is 8 binary digits. Thus

```
127.0.0.1 = (127 × 2²⁴) + (0 × 2¹⁶) + (0 × 2⁸) + (1 × 2⁰)
= 2130706432 + 0 + 0 + 1
= 2130706433
```

Converting to hexadecimal is trivial using the excellent Qalculate tool.

```
2130706433 to hex = 0x7F000001
```

As usual, PayloadsAllTheThings is a great resource.

- [Qalculate!](https://qalculate.github.io/)
- [PayloadsAllTheThings: Server-Side Request Forgery](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Server%20Side%20Request%20Forgery)

## Exercise

The target accepts `0x7f000001` as a valid (and unfiltered) representation for localhost, so we’re going to use this and the ZAP Fuzzer (which is annoyingly slow, but the free version of the Intruder is even slower…) to enumerate all of the ports from 1 - 65535. Successful vs. unsuccessful requests are pretty obvious in from their differing response body sizes (successful requests have a body size of 1041 bytes, or in one case 1035 bytes, while unsuccessful requests have a body size of 1045 bytes).

The target is also vulnerable to local file inclusion, so `file:///etc/passwd` will get us a full user list.

- [Using OWASP ZAP](https://cardboard-iguana.com/notes/owasp-zap.html)
- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## Solution

TryHackMe uses a small shell script with a tight cURL loop instead of ZAP. Which would probably have been faster, but I didn’t feel like hunting through the cURL man page to figure out what flags I needed.

```
for PORT in {1..65535}; do
BODY_LENGTH="$(curl -so /dev/null http://10.10.229.43:8000/attack?url=http://0x7f000001:$PORT -w '%{size_download}')"
if [[$BODY_LENGTH != 1045]]; then
echo "Open port: $PORT"
fi
done
```

- [Using OWASP ZAP](https://cardboard-iguana.com/notes/owasp-zap.html)
