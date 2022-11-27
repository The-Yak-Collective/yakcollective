---
title: 'TryHackMe: Web Fundamentals'
date: 2022-01-16 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-16-tryhackme-web-fundamentals.html
author: 100007
---

# TryHackMe: Web Fundamentals

**author:** Nathan Acks  
**date:** 2022-01-16

# LFI

## Deploy

LFI = Local File Inclusion

Basically, this is when user input can cause a server to include the contents of a local (server-side) file that user wouldn’t / shouldn’t normally have access to.

Most common in PHP-based websites.

## Getting User Access via LFI

The effects of this can range from basic information disclosure issues (including the source of PHP files) that are most useful during reconnaissance to things like including the contents of `/etc/passwd`, _et al._ (which can be _really_ bad).

NOTE: Typically web servers are serving content from `/var/www`, `/var/www/srv`, or an immediate subdirectory for virtual hosts. Thus to get to `/` generally requires `../../`, `../../../`, or `../../../../`.

## Escalating Your Privileges to Root

A reminder that GTFOBins is your friend.

- [GTFOBins](https://gtfobins.github.io/)

# Authenticate

## Dictionary Attack

NOTE: It doesn’t look like Burp Suite can effectively run an attack using the entire `rockyou.txt` data set.

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## Re-Registration

The idea here is to register a username with leading or trailing whitespace, since that can be eaten by SQL parsers when querying for permissions. If the username isn’t properly sanitized before registration, this means that we can register accounts like “` admin`” and get the same permissions as the “real” `admin` account.

## JSON Web Token

JSON web token format: `$HEADER.$PAYLOAD.$SIGNATURE`, where each substring is base64 encoded.

`$HEADER` and `$PAYLOAD` are both JSON blobs, but `$SIGNATURE` can be binary data.

- `$HEADER` takes the form `{ "alg": "SHA256", "typ": "JWT" }`, where `alg` is a signing algorithm supported by the server.
- `$PAYLOAD` is a JSON blob containing various pieces of user information, which can include permissioning data.
- `$SIGNATURE` is the signature (using `alg` from the `$HEADER`) of `$HEADER.$PAYLOAD` (both parts base64 encoded) using a server-side secret (often an SSL key… but sometimes just a string!).

See jwt.io for a detailed breakdown. These are typically passed around as a user cookie, HTTP header, or queried from local storage.

Sometimes it’s possible to brute-force a weak secret from the `$SIGNATURE` (which will allow tokens to be forged as desired), but sometimes servers will also support the `NONE` signature type, which indicates that no signing is used (so the JWT is then just `$HEADER.$PAYLOAD.` - note the trailing dot!). If the server allows the `NONE` signing method, then it’s often possible to just arbitrarily edit the `$PAYLOAD` to gain access to other users.

- [JSON Web Tokens](https://jwt.io)

## No Auth

This is basically just an enumeration attack (the application is generating easily-guessed URLs and isn’t checking that the user actually has permission to view a particular URL).

# ZTH: Obscure Web Vulnerabilities

## What is SSTI?

SSTI = Server-side template injection.

This is where the server is building web pages using a template system and, because of inadequate input sanitization, the user can pass a parameter that can control the templating engine (beyond its intended limits).

## Manual Exploitation of SSTI

Typically you’d test for SSTI by passing something simple like “2 + 2” and seeing what the template splits out. _How_ you pass “2 + 2” is going to depend heavily on the template system being used, however.

The “PayloadsAllTheThings: Server Side Template Injection” document is a useful resource.

- [PayloadsAllTheThings: Template Injection](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/Server%20Side%20Template%20Injection)

## What is CSRF?

CSRF = Cross Site Request Forgery

This is when a user interacting with one website causes an action to be performed on another website _as that user_ (in an unintended fashion). Basically, malicious URLs or JavaScript is causing the user’s browser to make requests to another site as the user but performing the actions specified by the attacker.

## What is JWT?

JWT algorithms can sometimes use a server’s _public_ key (for example, `HS256` generates a signature using the public half of a keypair, while `RS256` uses the private half of a keypair). If the public half of the keypair used to sign the JWT is available somehow (for example, if it’s been re-used as the server’s HTTPS certificate), then we can harvest it and use it to forge new JWTs.

## JWT Challenge

The base64-encoded version of `{"typ":"JWT","alg":"HS256"}` is `eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9Cg`.

Use `basenc --base64url` and `basenc -d --base64url` to encode/decode URL-safe base64 (which is what JWT uses), rather than the `base64` binary. Be sure to strip the trailing `=` signs!

Putting this all together, we can encode an `HS256` signature (assuming that there is no secret) using:

```
echo -n "$HEADER.$PAYLOAD" | \
openssl dgst -sha256 -mac HMAC -macopt hexkey:$(cat $PUBLIC_KEY_FILE | xxd -p | tr -d '
') | \
sed -e 's/.*= //' | \
tr -d '
' | \
xxd -p -r | \
basenc --base64url | \
sed -e 's/=*$//'
```

Here `$HEADER` is our base64-encoded header (see above), `$PAYLOAD` is our base64-encoded payload, and `$PUBLIC_KEY_FILE` is the PEM-formatted server public key (that we’ve obviously obtained using another method).

## Automatic Exploitation of the JWT “None Vulnerability”

The base64-encoded version of `{"typ":"JWT","alg":"none"}` is `eyJ0eXAiOiJKV1QiLCJhbGciOiJub25lIn0`.

## Manual Exploitation of XXE

[PayloasAllTheThings on XXE.](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/XXE%20Injection)

_If_ you’re dealing with PHP, and _if_ the PHP expect module is loaded, and _if_ XML inputs aren’t properly sanitized, then defining a SYSTEM entity with the value of `expect://$COMMAND` will get you RCE!

NOTE: From the examples, it appears that while you need to add a DOCTYPE declaration with an ELEMENT to define an ENTITY, this DOCTYPE/ELEMENT can just be garbage.

## XXE Challenge

Confirming that a garbage DOCTYPE/ELEMENT definition are fine, the following appears to get me access to `/etc/passwd` on a vulnerable box:

```
<!DOCTYPE test [
<!ELEMENT test ANY>
<!ENTITY test SYSTEM "file:///etc/passwd">
]>
```

