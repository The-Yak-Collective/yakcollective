---
title: 'TryHackMe: Pre Security'
date: 2021-09-14 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-14-tryhackme-pre-security.html
author: 100007
---

# Extending Your Network

## Introduction to Port Forwarding

Technically, it’s routers that are in charge of port forwarding, not firewalls (the prevelance of devices that are _both_ routers _and_ firewalls does a lot to muddy this situation).

## Firewalls 101

Firewalls operate on layers 3 and 4 of the OSI Model.

The difference between stateless firewalls (rule-based packet filtering) and stateful firewalls (connection tracking) is not 100% clear from this TryHackMe module, and most sources on the internet don’t help much. But two examples might make it clearer.

- A _stateful_ firewall can be configured to block incoming _connections_ but allow outgoing ones. The reason this works is because incoming connections are always denied by the block rule, but once an outgoing connection is made the firewall tracks it and allows data associated with that connection in _both_ directions.
- A _stateless_ firewall simply blocks all _packets_ that match a given set of criteria, such as destination port, source or destination IP address, etc.

What muddies the water here is that modern firewalls generally support _both_ stateful and stateless rules. For example, you might block incoming connections but allow outgoing connections (stateful) for normal operations, but then block all outbound packets targeting ports associated with SMB (stateless).

- [OSI Model](https://cardboard-iguana.com/notes/osi-model.html)

## LAN Networking Devices

“Dumb” switches are purely layer 2 devices, but VLAN-aware switches support limited layer 3 awareness (since virtual logic about the network lives on this layer).

# DNS in Detail

## Domain Hierarchy

When you’re “registering” a domain, what you’re actually doing is registering a “second-level domain” (as distinct from TLDs like .net, .co.uk, etc.).

Second-level domains are limited to 63 characters composed of a-z, 0-9, and “-“. Hyphens cannot start or end a domain (the TryHackMe module states that consecutive hyphens are not allowed, but this doesn’t seem to be true anymore given how internationalized domains are represented with Punycode).

Subdomains follow the same rules as second-level domains. While in theory an unlimited number of subdomains are allowed, the entire domain string must be 253 characters or less, which would seem to impose a hard cap of 124 subdomains (assuming that the shortest TLD is two characters; if there’s a one-character TLD out there, then the hard cap is at 125 subdomains).

Technically TLDs are _not_ actually the top of the domain hierarchy - that would be the root domain, which is simply “.”. FQDNs should contain this trailing dot, which is why you need to include it when setting up CNAME entries and the like in DNS. (The purpose of the final “.” Is similar to that of the leading “/” in paths - /foo/bar/baz is an absolute path starting at the file system root, but foo/bar/baz is a path relative to the current directory. The domain baz.bar.foo. is the DNS equivalent of /foo/bar/baz.)

- [Domain name (Wikipedia)](https://en.wikipedia.org/wiki/Domain_name)
- [Internationalized domain name (Wikipedia)](https://en.wikipedia.org/wiki/Internationalized_domain_name)

## Making a Request

```
Client
  -> Recursive DNS server (local, LAN, ISP)
    -> (possibly other DNS servers)
      -> Root DNS server
        -> TLD server (.com, etc.)
          -> Authoritative DNS server (NS record)
```

What’s actually going on here is made a little bit clearer by Wikipedia’s DNS address resolution discussion. Basically, DNS records are resolve from right-to-left, with each level responsible for knowing the location of the next level’s authoritative server. So, the root DNS servers (“.”) know where to find the TLD servers, the TLD servers know where to find the (second-level) domain servers, and the (second-level) domain server knows all the DNS entries for a domain (including for its subdomains). In theory this means that all you actually need is:

```
Client
  -> Root DNS server
    -> TLD server
      -> Authoritative DNS server
```

Everything that happens first between the client and the root DNS server is just caching to make things happen faster (if the answer to a query hasn’t expired from the cache of a recursive server, it will be provided by that server directly without making subsequent queries further up the chain).

- [Domain Name System (Wikipedia)](https://en.wikipedia.org/wiki/Domain_Name_System)

# HTTP in Detail

## Requests and Responses

scheme://user:password@domain:port/some/path?a=query#fragment

… or, in the “real world” …

http://foo:bar@example.tld:8080/this/is/a/path?id=1&task=2#in\_page\_reference

Obviously, not all parts are required.

Example request:

```
GET / HTTP/1.1
Host: tryhackme.com
User-Agent: Mozilla/5.0 Firefox/87.0
Referer: https://tryhackme.com/
```

Example response:

```
HTTP/1.1 200 OK
Server: nginx/1.15.8
Date: Fri, 09 Apr 2021 13:34:03 GMT
Content-Type: text/html
Content-Length: 98

<html>
<head>
    <title>TryHackMe</title>
</head>
<body>
    Welcome To TryHackMe.com
</body>
</html>
```

Note that both requests and responses _end_ with blank lines. If the web server returns any data, this data follows this blank line. This is why Content-Length is important - it’s how we know when to stop reading the data! (Note that Content-Length is in bytes.)

Note that HTTP is a stateless protocol.

- [Content-Length (MDN Web Docs)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Length)

## HTTP Methods

In general, POST should be for record creation, PUT for record updates.

## HTTP Status Codes

HTTP status code blocks:

- 100 - 199 - Informational response (uncommon)
- 200 - 299 - Success
- 300 - 399 - Redirects
- 400 - 499 - Client errors (problems with the request content)
- 500 - 599 - Server errors (problems with processing the request)

While some HTTP status codes are pre-defined, applications are free to make up their own as well (!).

## Cookies

Cookies are key-value pairs (key=value) sent by the server using the Set-Cookie header (additional semi-colon separated parameters can determine when the cookie expires, whether it’s restricted to HTTPS connections, etc.). Once set, the client is expected to return the cookie with the Cookie header in subsequent requests (at least until the cookie expires).

To set multiple cookies, the server just uses multiple Set-Cookie headers. However, clients only reply with a _single_ Cookie header, with individual cookies returned in a semicolon-separated string of key=value pairs.

- [Response header (MDN Web Docs)](https://developer.mozilla.org/en-US/docs/Glossary/Response_header)
- [Set-Cookie (MDN Web Docs)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie)
- [Cookie (MDN Web Docs)](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Cookie)
