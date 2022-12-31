---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-03-13 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-13-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

Now that I’ve made it through the next three chapters of the Security+ Exam Cram (that correspond to the ITPro.TV course), I’m ready to do some lectures. And some more rooms on TryHackMe, because I’ve been missing it.

# ITPro.TV: CompTIA Security+ (SY0-601)

## Authentication and Authorization

New acronym - IAAA: Identity, authentication, authorization, and auditing.

- IDENTITY: An identifier that represents a user.
- AUTHENTICATION: The process through which a user proves that they control their claimed identity (general via presenting some set of credentials when challenged).
- AUTHORIZATION: The permissions and access granted to a user after authenticating their identity.
- ACCOUNTING: The process of recording the actions of a user to verify that they have not exceeded their authorization. (Functionally, this is _auditing_ a user’s actions.)

> The process of authentication is only as secure as the credentials you hold.
> 
> - Wes Brian

Identity claims and authentication comprise a conversation between the user and the target service, but authorization and accounting are purely internal activities engaged in by the target service.

Types of authentication factors:

- Something you know (“knowledged based authentication”, or KBA)
- Something you have (security keys, etc.)
- Something you are (biometrics)
- Somewhere you are (geolocation)

KBA can further be divided between “static” and “dynamic” varieties… But the only real difference here is whether the user and system have agreed ahead of time on the possible challenges (“static”) or whether the server can request information that the user may not have expected (“dynamic”). The “dynamic” category is what I most frequently see people calling “knowledge-based authentication” (even though this category technically includes things like password).

Multi-factor authentication combines factors from multiple _types_, _not_ multiple factors from a _single_ type.

Account management (and encryption management!) tools:

- External hardware-based authenticators (Yubikeys, biometrics stored on smart cards, etc.)
- Password vaults and managers
- TPMs
- HSMs

## Authentication Methods

DIRECTORY SERVICES: A centralized database that manages user accounts, groups, computers, services, etc. The concept and content of directory services is standardized under the X.500 standard, which defines objects using “distinguished names” (DNs). A typical example of a DN might be “CN=sshd,OU=SecPlusUsers,DC=secplus,DC=local”.

- CN = commonName
- OU = organizationalUnitName
- DC = domainComponent

Order is important here! For example, we always lead with the commonName, and domainComponent elements must appear in the same order as they would be in a URI (so, example.com -\> “DC=example,DC=com”, which is different than “DC=com,DC=example”!).

LDAP (and derived systems like AD DS) is the canonical directory service implementation.

FEDERATION: The process by which users and objects can be authenticated (and trusted!) across domains. The most common example of this is the ubiquitous “Sign in with Google/Facebook/etc.) buttons. In a federated system, the “service provider” (SP) (which hosts the service attempting to be accessed) uses a protocol like SAML, OpenID Connect, or OAuth 2.0 to reach out to an “identity provider” (IdP), which then authenticates the user’s identity.

SINGLE SIGN-ON (SSO): A variation of a federated system that only requires a user to sign-in once (to the IdP). Nowadays “federation” and “single sign-on” are essentially synonymous, but older federated systems _did_ involve forwarding credentials presented to the service provider to the IdP.

ATTESTATION: The process by which the state of the client that is acting on behalf of the user is verified by an “attestation server” as part of establishing trust during authentication. Trust that the attestation hasn’t been tampered with is handled by specialized hardware components like TPMs.

## Additional Authentication Methods

TOKENS: A special-purpose hardware device that store or present identity information (sometimes this is biometrics stored on a smartcard, but more often this is just the cryptographic key stored on a Yubikey or a code displayed on a smartphone). Tokens can be connected (security keys, etc.), disconnected (Google Authenticator, RSA SecureID, etc.), or contactless (NFC, RFID, etc.).

The difference between “connected” and “disconnected” tokens is really about how the token information is transmitted to the authentication process - is it via a direct electrical connection (connected), or is it by the user entering in a one-time code (disconnected). So “contactless” tokens are the only tokens that _actually_ don’t require some sort of physical process to transmit the information (unless you count radio waves).

ONE-TIME PASSWORDS (OTP): Single-use passwords, typically delivered via SMS or an authenticator app. Comes in two varieties:

- HMAC-BASED OTP (HOTP): New passwords are derived using a counter every time the previous password is used. The fact that HOTP codes only expire on use leads to all sorts of obvious problems, and their use is generally discouraged.
- TIME-BASED OTP (TOTP): New passwords are regularly derived and only last for a short time (typically 30 seconds).

The TOTP generation process is actually the same as the HOTP process, except that it uses a timestamp as the counter and the code is automatically refreshed after a short interval.

## Biometrics

Example biometric methods:

- Fingerprints
- Voiceprints
- Hand geometry
- Retina scans
- Iris scans
- Facial recognition
- Vein patterns
- Gait analysis

Accuracy/precision measures used in the infosec industry:

- FALSE REJECTION RATE (FRR): Industry-specific terminology for the false negative rate.
- FALSE ACCEPTANCE RATE (FAR): Industry-specific terminology for the false positive rate.
- CROSSOVER ERROR RATE (CER): Sometimes also called the “equal error rate” (EER). The idea here is to map the error rate vs. device sensitivity curve for both the FRR (which generally increases with increasing device sensitivity) and the FAR (which generally decreases with increasing device sensitivity) and determine the point at which these two rates are equal. In general this point is considered to define the biometric authenticator’s “accuracy” (so when you hear a vendor refer to a “99% accuracy rate”, they’re talking about a CER/EER of 1%). The fact that the FRR increases with increasing sensitivity and the FAR decreases with increasing sensitivity strikes me as first-pass reasonable, but by no means _guaranteed_… I wonder how many biometric authenticators get into trouble by making this assumption?

## Authentication Protocols - PAP And CHAP

PAP is the “password authentication protocol”. It is a plaintext protocol where the user presents the authenticating server with a username/password combination, and the server replies with either an Authentication-ACK or Authentication-NACK message depending on whether authentication succeeded or failed. So, don’t use.

CHAP is the “challenge handshake authentication protocol”. It is still a plaintext protocol, but obscures the password by having the user encrypt a random challenge from the server using their password as the key. The server then looks up that same password in a central database an attempts to decrypt the encrypted challenge. If decryption succeeds, then the user is considered to be authenticated.

While an improvement over PAP (since the password is never actually transmitted), CHAP still requires the server to know the users password. It also fails to encrypt other potentially sensitive information (such as usernames), and is vulnerable to a race condition where the attacker can encrypt the challenge using a stolen password before the user can.

Microsoft created their own CHAP variant, MS-CHAP, but this suffered from the same problems. A later variant, MS-CHAPv2, wraps MS-CHAP in an encrypted channel and layers on _mutual_ authentication between the client and server, though it still at it’s base uses the user’s password as a PSK. MS-CHAPv2 remains a supported authentication protocol in the Windows world.

## Authentication Protocols - EAP and 802.1X

EAP is the “extensible authentication protocol” used in wireless networks. EAP doesn’t actually handle authentication itself, but rather encapsulates other authentication protocols using a modified version of PPP. EAP is typically used with RADIUS. Typical authentication methods:

- EAP-FAST (extends the Cisco FAST protocol used in PPP and wireless networks)
- EAP-TLS (allows TLS-based authentication mechanisms, such as certificate exchange and smartcards, to be used; perhaps _the_ most commonly used EAP method)
- EAP-TTLS (EAP-TLS over an encrypted tunnel; the turducken of EAP methods)

PEAP is the “_protected_ extensible authentication protocol”. It’s basically the same as EAP, except that a secure tunnel is established before authentication begins (so, _kind of_ the same idea as EAP-TTLS, but implemented in a more sensible order).

802.1X is a port-based authentication protocol used on wired and wireless networks. (“Port-based” in this case means the _physical_ port/channel the client is connecting on. 802.1X is _not_ authenticating connections to individual ports on services within the network it’s protecting!) There are three components to 802.1X - the supplicant (client system), the authenticator (the _network_ device the supplicant is connecting to), and an authentication server (typically a RADIUS server). The idea here is that the authenticator traffic cops _network_ access before the supplicant ever has an opportunity to request access from a service on that network. In particular, this means that the supplicant _never_ directly talks to the authentication server - all requests are mediated by the authenticator.

## Authentication Protocols - RADIUS and TACACS

RADIUS is the “remote authentication dial-in user service”, typically implemented over UDP.

- Port 1645/1812 - authentication
- Port 1646/1813 - accounting

The 1600 ports are older ports, and are not generally used by default anymore. The point of RADIUS is to implement a single server that handles authentication, authorization, and accounting. RADIUS refers to the end user system as the “access client”, while intermediate systems (like an 802.1X access point) are the actual RADIUS clients. The reason for this distinction is because RADIUS is functionally similar to 802.1X (that’s one reason why 802.1X access points slot into it so neatly), in that the access client never talks directly to the RADIUS server, but rather all communications are mediated by the RADIUS client that the access client is connecting to. Note that RADIUS _only_ encrypts user passwords.

TACACS is the “terminal access controller access control system”. This is a proprietary Cisco standard, though the (modular) TACACS+ standard _is_ an open standard. The big differences between TACACS+ and RADIUS is that TACACS+ operates over encrypted TCP connections and uses separate systems for handling the authentication, authorization, and accounting roles. The use of TCP makes TACACS+ more reliable, and the use of encrypted tunnels makes it more secure. However, because TACACS+ infrastructure is so granular, it is much more expensive to implement than RADIUS.

Summary bullet points for RADIUS:

- One server handles authentication, authorization, and accounting
- A single, monolithic protocol
- UDP
- Only user password is encrypted
- Open standard

Summary bullet points for TACACS+:

- Authentication, authorization, and accounting are separate servers
- Modular design allows it to be adapted to newer protocols
- TCP
- Entire connection is encrypted
- Semi-open/Semi-proprietary (depending on the implementation)

## Authentication Protocols - Kerberos

Kerberos was originally developed by MIT, but is most commonly seen in Windows Active Directory environments. It is a time-sensitive authentication mechanism, which helps prevent replay attacks but means that clock skew is _really_ important.

I’ve written out several variations of the Kerberos authentication process (my favorite is the version cribbed from Wikipedia in my “Kerberos” note), so I’m not going to write it all out _yet again_. Key points:

- Windows environments bundle all Kerberos roles (the authentication server, KDC, and ticket-granting service) into the domain controller role. Non-Windows implementations are more likely to split these roles between servers.
- The basic idea is that the client authenticates to the domain controller, gets a ticket granting ticket (TGT), and then uses the TGT to request specific per-resource tickets _from the domain controller_ when it wants to access a particular resource. This means that client credentials only need to be verified once (making Kerberos a species of SSO) and that resource servers do not need to create side channels back to the domain controller to verify client authenticity or authorization.

The default Kerberos port is TCP 88.

- [2022-03-12 - ITPro.TV: CompTIA Security+ (SY0-601)](https://cardboard-iguana.com/log/2022-03-12-itprotv-comptia-security-plus.html)
- [Kerberos](https://cardboard-iguana.com/notes/kerberos.html)

# TryHackMe: Jr. Penetration Tester

## What Is an IDOR?

IDOR stands for “insecure direct object reference”. This is basically when the (typically web) application doesn’t check that the user has access to the object being requested. The end result is that a user can gain unauthorized access to data held by the application.

## Finding IDORs in Encoded IDs

Object IDs are frequently encoded using base64. Decode all the things!

## Finding IDORs in Hashed IDs

Object IDs are also sometimes referenced using their hashes (often just MD5). It’s thus useful to check if the hash of the ID of an object you do have access corresponds at all to how that object is being referenced. Since the most common IDs are numeric, online hash databases can also be useful.

- [CrackStation](https://crackstation.net/)

## Finding IDORs in Unpredictable IDs

Okay, this is a silly section… Unpredictable IDs can’t, well, be predicted. You can still see if you have an IDOR by creating two accounts, performing some actions in parallel, and then seeing if you can view resources from one account while logged in as another. This process can help you determine _if_ a system has an IDOR vulnerability, but unfortunately doesn’t really help you get at any information using it.

## Where Are IDORs Located?

Also check API endpoints, and see if those endpoints accept additional (undocumented) parameters that allow you to access information beyond your normal scope.

## A Practical IDOR Example

Burp Suite is, as usual, pretty useful for uncovering API endpoint activity. I honestly find it more intuitive to work with for this purpose than the actual browser developer tools.

- [Using Burp Suite](https://cardboard-iguana.com/notes/burp-suite.html)

## Introduction to File Inclusion

Basically, if an application is including a file based on some user-defined input, then there may be an opportunity to trick it into including a malicious file, or a system file we shouldn’t have access to.

The trick here is that you _can’t_ be including your file in a fashion that would trigger your browser to request it, since that will be limited by what can be represented as a URL for the application. Rather, you need to find a parameter that specifies a file the application will incorporate _directly_ into the page data being pushed to the browser.

File inclusion vulnerabilities are a species of input validation errors.

## Path Traversal

“Path traversal” and “directory traversal” are the same thing. This is about using LFI to access system files; this often occurs when improperly sanitized user input is passed to PHP’s `file_get_contents()` function.

Common files to check:

- /boot.ini (a.k.a., `C:\boot.ini` - boot options on Windows systems)
- /etc/issue
- /etc/passwd
- /etc/profile
- /etc/shadow (jackpot!)
- /proc/version
- /root/.bash\_history
- /root/.ssh/id\_rsa (jackpot!)
- /var/log/apache2/access.log
- /var/log/dmessage (lots of variants of this…)
- /var/mail/root

Windows systems are also vulnerable to LFI attacks via PHP. In fact, `file_get_contents()` will happily use UNIX slashes on Windows.

- [file\_get\_contents() (PHP Documentation)](https://www.php.net/manual/function.file-get-contents.php)

## Local File Inclusion (LFI)

More potentially hazardous PHP functions:

- include()
- include\_once()
- require()
- require\_once()

LFI is also common in ASP, JSP, and Node.js apps.

Remember that PHP terminates strings with the null byte (`0x00`). This can be passed in as `%00`, though this will often need to be URL-encoded as `%2500`. The use of the poison null byte allows us to bypass file inclusion that appends extensions or other information to the string we’re passing, by causing string parsing to halt before it reaches the appended information. The poison null byte can also be used to bypass simple keyword filters.

Unfortunately, the poison null byte only works in PHP \< 5.3.4.

If the poison null byte doesn’t work, another trick relies on the fact that for some bizarre reason PHP allows files to be referenced with `.` notation just like directories. In other words, `/etc/passwd/.` will return the contents of `/etc/passwd`!

Representing `../` as `....//` can bypass filters that replace `../`, as PHP search-and-replace only does a single pass through a string (it should be obvious how to extend this if a developer tries to just run a search and replace _twice_).

- [The Poison Null Byte](https://cardboard-iguana.com/notes/poison-null-byte.html)

## Remote File Inclusion (RFI)

Remote file inclusion only works when PHP’s `allow_url_fopen` option to be turned on. If `allow_url_include` is also on, then `include()` and `require()` functions (and friends) can be leveraged. This creates a vulnerability similar to the recent log4j vulnerability in Java, where arbitrary code can be passed into the application. RCE!

- [TryHackMe: Exploiting Log4j](https://cardboard-iguana.com/notes/tryhackme-exploiting-log4j.html)
- [Difference between require() and include() in PHP](https://www.geeksforgeeks.org/difference-between-require-and-include-in-php/)
- [Runtime Configuration (PHP Documentation)](https://www.php.net/manual/filesystem.configuration.php)

## File Inclusion Remediation

- Updates, updates, updates!
- Turn off PHP errors (to deprive attackers of feedback)
- WAFs
- Make sure that `allow_url_fopen` and `allow_url_include` are _off_.
- User input validation!
- Aggressively whitelist and blacklist potential file locations.

## File Inclusion Challenge

Remember that form requests sent via POST need to have `Content-Type: application/x-www-form-urlencoded`!

Also, remember to add in an appropriate `Content-Length`.

