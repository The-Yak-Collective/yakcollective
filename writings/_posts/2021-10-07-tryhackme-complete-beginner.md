---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-07 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-07-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-10-07

# OWASP Top 10

## (Severity 09) Components With Known Vulnerabilities

The trickiest part of this is that the project is called “CSE Bookstore”, but the exploit code in ExploitDB is listed under “Online Book Store”.

The actual vulnerability is two-fold:

(1) Admin image uploads bypass authentication.

(2) There’s no check on _what_ actually gets uploaded, so we can push up a PHP script instead of an actual image.

- [Online Book Store 1.0 - Unauthenticated Remote Code Execution](https://www.exploit-db.com/exploits/47887)

# OWASP Juice Shop

## AH! Don’t Look!

Finally, a useful piece of general knowledge.

Some languages use null bytes to know when a string terminates, rather than tracking the actual string length (it looks like PHP is one of these). If a null byte (generally? always? encoded as `%00`) is included in a string, then everything after that byte is dropped by the interpreter.

Because % characters are themselves special, null bytes need to be encoded in URLs as `%2500`.

Typically a null byte will either be inserted at the end of a string (to prevent a common suffix from being appended, which can sometimes allow us to exfiltrate files we wouldn’t otherwise have access to) or before a “fake” file extensions (which can cause some file-type checks to pass, again allowing us to download files we’d otherwise be denied access to).

The best way to defend against these attacks is to simply sanitize strings by explicitly removing any null bytes they contain.

```
$sanitized_string =
str_replace(chr(0), '', $original_string);
```

[Defend the Web has a much better description of what’s going on here than the one offered by TryHackMe.](https://defendtheweb.net/article/common-php-attacks-poison-null-byte)

## Who’s Flying This Thing?

Broken access control vulnerabilities can be classified into one of two types:

- HORIZONTAL privilege escalation allows the attacker to perform actions as a different user with the _same_ permissions they currently have.
- VERTICAL privilege escalation allows the attacker to perform actions as a different user with _higher_ permissions then they currently have.

Mostly this section seems to be driving home that one should look everywhere for clues (in the present case, there’s clues about hidden parts of the site structure in some of the JavaScript files loaded with the page), and also that accessing sensitive information (for example, through URL enumeration) doesn’t necessarily _look_ like accessing “new” information (in the OWASP Juice Shop, accessing another user’s shopping car can be done without actually changing the header that says it’s “your” shopping cart).

## Where Did That Come From?

In addition to the `<script/>` tag, it’s also possible to inject JavaScript using the `<iframe/>` tag by setting the `src` attribute to the `javacript:` pseudo-protocol. For example:

```
<iframe src="javascript:alert('XSS');"/>
```

It’s worth noting that JavaScript also accepts back-ticks as a type of quotation mark, so we actually have three different marks to work with (single quote, double quote, and back-tick).

A useful HTTP header to know about: `True-Client-IP` supplies an override for the client IP address to the server (similar to `X-Forwarded-For` with proxies).

The lesson of this section: Don’t trust any user input, even HTTP headers!

As a side-note, these examples really aren’t showing me much of the value of XSS attacks. I can see where they would be useful for targeting _users_ (malicious links, etc.), and from that I can see where they would be useful when targeting, say, admins… But there really isn’t a way they can _directly_ compromise the server or webapp (which makes sense, as JavaScript runs on the client, not the server).

