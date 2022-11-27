---
title: 'TryHackMe: Complete Beginner (Supplements)'
date: 2021-12-05 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-12-05-tryhackme-complete-beginner-supplements.html
author: 100007
---

# TryHackMe: Complete Beginner (Supplements)

**author:** Nathan Acks  
**date:** 2021-12-05

# Attacking Kerberos

## Introduction

Kerberos: The default authentication method for Windows domains. Intended to be the successor to NTLM.

- TICKET GRANTING TICKET (TGT): An authentication ticket that can be used to request service tickets for specific domain services from the ticket granting service.
- KEY DISTRIBUTION CENTER (KDC): A domain service that issues tickets; typically composed of the ticket granting service and the authentication service.
- AUTHENTICATION SERVICE (AS): Issues ticket granting tickets. (Presumably in charge of _authenticating_ users and automations.)
- TICKET GRANTING SERVICE (TGS): Issues tickets for domain services (and machines?) when presented with a ticket granting ticket. (Presumably in charge of _authorizing_ users and automations.)
- SERVICE PRINCIPAL NAME (SPN): A service identifier. On Windows, SPNs associates a particular service instance with a domain account. All services must have a domain service account. (But it sounds like services might be associated with _multiple_ accounts via multiple principal names assigned to multiple running instances?)
- KDC LONG TERM SECRET KEY (KDC LT KEY): A secret key used to encrypt ticket granting tickets and sign privilege attribute certificates. This is the NT hash of the KRBTGT service account.
- SERVICE LONG TERM SECRET KEY (SERVICE LT KEY): A secret key associated with a particular service. Used to encrypt the service portion of a service ticket and sign privilege attribute certificates. Held by individual domain service accounts.
- SESSION KEY: Issued with a ticket to identify a particular user session. Services expects _both_ a ticket and a session key to be present before acting on a user’s behalf.
- PRIVILEGE ATTRIBUTE CERTIFICATE (PAC): A bundle of the user’s identifying information, which is provided along with the tickets. Importantly, this contains the user’s username and (on Windows) SID.

Much acronym. Very Microsoft.

I found TryHackMe’s discussion of Kerberos authentication pretty confusing, but Wikipedia’s walk-through of the authentication process is much clearer. The below steps are cut-and-pasted from Wikipedia’s walk-through, but with language adapted to match the Windows-specific environment TryHackMe is concerned with…

[α] Client Authentication to the KDC (a.k.a. “Pre-Authentication”):

(1) AS-REQ: The client sends the client/user ID + the current timestamp (the timestamp is used to prevent replay attacks) encrypted with the NT hash of the user’s password a cleartext message of the user ID to the authentication server to request services on behalf of the user.

(2) AS-REP: The authentication server checks to see if the client/user ID is in its database and if it can decrypt the timestamp using the NT hash of the password stored there. If it can, then the authentication server sends back the following two messages to the client:

- Message A: _Client/TGS Session Key_ encrypted using the NT hash of the client/user.
- Message B: _Ticket Granting Ticket_ (including the privilege attribute certificate, client network address, ticket validity period, and the _Client/TGS Session Key_) encrypted using the KDC long term secret key.

(3) Once the client receives messages A and B, it attempts to decrypt message A with the NT hash generated from the password entered by the user. If the user entered password does not match the password in the authentication service database then decryption of message A will fail. Once message A is decrypted, the client obtains the _Client/TGS Session Key_. This session key is used for further communications with the ticket granting service. (Note: The client cannot decrypt Message B, as it is encrypted using the KDC long term secret key.)

[β] Client Service Authorization:

(1) TGS-REQ: When requesting services, the client sends the following messages to the ticket granting service:

- Message C: Composed of the ticket granting ticket and the service principal name of the requested service.
- Message D: Authenticator (which is composed of the client ID and the timestamp), encrypted using the _Client/TGS Session Key_.

(2) TGS-REP: Upon receiving messages C and D, the ticket granting service retrieves the ticket granting ticket out of message C and decrypts it using the KDC long term secret key. This gives it the _Client/TGS Session Key_ and the client ID (the client ID is part of the privilege attribute certificate). Using the _Client/TGS Session Key_, the ticket granting service decrypts message D (Authenticator) and compares the client IDs from the ticket granting ticket and message D; if they match, the server sends the following two messages to the client:

- Message E: _Service ticket_ (which includes the privilege attribute certificate, client network address, validity period, and _Client/Server Session Key_) encrypted using the service’s long term secret key.
- Message F: _Client/Server Session Key_ encrypted with the _Client/TGS Session Key_.

[γ] Client Service Access:

(1) AP-REQ: Upon receiving messages E and F from ticket granting service, the client has enough information to authenticate itself to the service server. The client connects to the service server and sends the following two messages:

- Message E: The _service ticket_ (as provided by the ticket granting service; see above).
- Message G: A new Authenticator, which includes the client ID, timestamp and is encrypted using _Client/Server Session Key_.

(2) AP-REP: The service server decrypts the service ticket (message E) using its long term secret key to retrieve the _Client/Server Session Key_. Using the sessions key, it then decrypts the Authenticator and compares client ID from the service ticket and message G. If they match the server sends the following message to the client to confirm its true identity and willingness to serve the client:

- Message H: The timestamp found in client’s Authenticator (sometimes modified, depending upon the version of Kerberos being used), encrypted using the _Client/Server Session Key_.

(3) The client decrypts the confirmation (message H) using the _Client/Server Session Key_ and checks whether the timestamp is correct. If so, then the client can trust the server and can start issuing service requests to the server.

(4) The server provides the requested services to the client.

Tickets are typically base64-encoded.

The above process explains why it’s sometimes said that “a hash is as good as a password” for a Window’s domain.

- [Windows Password Hashes](https://cardboard-iguana.com/notes/windows-password-hashes.html)
- [Golden ticket attacks: How they work - and how to defend against them](https://blog.quest.com/golden-ticket-attacks-how-they-work-and-how-to-defend-against-them/)
- [TryHackMe: Attacking Kerberos](https://tryhackme.com/room/attackingkerberos)
- [Kerberos (protocol) (Wikipedia)](https://en.wikipedia.org/wiki/Kerberos_%28protocol%29#Description)

## Enumerating with Kerbrute

Kerbrute works by sending a single UDP packet to the authentication service to begin the authentication process, but then doesn’t complete the transaction as to avoid an actual login failure (and the associated logging). While this doesn’t grant access to anything, it does allow domain users to be enumerated using a wordlist.

NOTE: To use kerbrute you need to already be on the domain you are attacking, or alternately need to have mapped the domain controller (which normally hosts the KDC) IP address properly in your /etc/hosts file.

## Harvesting & Brute-Forcing Tickets with Rubeus

Rubeus is a Windows-only post-exploitation tool for attacking Kerberos. No compiled binaries are available (either through the GitHub repo or Kali Linux’s `windows-binaries` package).

NOTE: To use Rebueus you need to already be on the domain you are attacking, or alternately need to have mapped the domain controller (which normally hosts the KDC) IP address properly in C:/Windows/System32/drivers/etc/hosts.

```
# Harvest ticket granting tickets observed by the current machine.
# Probably works best when run on a domain controller.
#
Rubeus.exe harvest /interval:30
# Spray the specified password across all known users and generate a
# ticket giving ticket for successful authentications. (Can trigger
# account lockouts!)
#
Rubeus.exe brute /password:ThePasswordToSpray /noticket
```

- [Rubeus](https://github.com/GhostPack/Rubeus)

## Kerberoasting

Kerberoasting is where a service ticket is used to brute force a service password. This password can then be used to either move laterally or (if the service runs with elevated privileges) to elevate your privileges.

Note that not every account is kerberoastable, though it’s not 100% obvious from this walk-through why that is. The Kali Linux tool `bloodhound` can be used to identify potentially kerberoastable accounts.

The main defenses against kerberoasting are (1) strong passwords and (2) making sure you’re not running any services as domain admin (which you shouldn’t need to do in this day and age anyway).

## Rubeus

```
# Extract password hashes for all known kerberoastable accounts using
# Rubeus.
#
Rubeus.exe kerberoast
```

The password hashes output here can then be cracked with Hashcat (use the 13100 hash mode).

- [Using Hashcat](https://cardboard-iguana.com/notes/hashcat.html)

## Impacket

Impacket can identify kerberoastable accounts and dump packets remotely. It comes standard with Kali Linux.

```
sudo python3 \
/usr/share/doc/python3-impacket/examples/GetUserSPNs.py \
${DOMAIN}/${USER}:${PASSWORD} \
-dc-ip $DOMAIN_CONTROLLER_IP -request
```

The password hashes output here can then be cracked with Hashcat (use the 13100 hash mode).

- [Using Hashcat](https://cardboard-iguana.com/notes/hashcat.html)

## AS-REP Roasting with Rubeus

AS-REP roasting is basically kerberoasting for regular user accounts. The only requirement to roast a user account is that Kerberos pre-authentication is disable.

(When pre-authentication is disabled, the authentication server will supply a ticket granting ticket and a session key automatically when requested, _without first verifying the user_. This data is then stored offline by the Windows machine for later decryption when the user with pre-authentication disabled logs in. But this means that all we need to do is to break the user’s NT hash!)

Both Rubeus and Impacket (via GetNPUsers.py) support AS-REP roasting; however, Rubeus can auto-discover roastable users, while GetNPUsers.py requires that user accounts already be enumerated and roastable accounts identified.

```
# AS-REP roasting with Rubeus.
#
Rubeus.exe asreproast
```

To use Hashcat to crack the hashes obtained in this fashin, first insert `23$` after the leading `$kerb5asrep$` (so `$kerb5asrep$` -\> `$kerb5asrep$23$`) and then use mode 18200.

Basically the only mitigation for this attack is to keep pre-authentication enabled, though strong password policies can help.

- [Windows Password Hashes](https://cardboard-iguana.com/notes/windows-password-hashes.html)
- [Using Hashcat](https://cardboard-iguana.com/notes/hashcat.html)

## Pass the Ticket with Mimikatz

Mimikatz can dump ticket granting tickets (and session keys?) from the memory of Windows’ Local Security Authority Subsystem Service (LSASS); these can then be used to for privilege elevation or lateral movement (depending on which users are active on that machine).

NOTE: There’s a bit of terminology creep in these discussions. Mimikatz and Rubeus are actually dumping Kerberos data structures (as .kirbi files), which contain _both_ a ticket _and_ the corresponding session key. People tend to call these .kirbi files “tickets”, but it’s worth keeping in mind that they contain _both_ pieces of data (as a “ticket” in the Kerberos sense, not the hacker’s sense, isn’t useful without the corresponding session key). See “Rubeus - Now With More Kekeo” for a good discussion of this.

Mimikatz needs to be run with administrative privileges (on the local machine), and provides its own command prompt.

- `privilege::debug` - See if you’re running with the right privileges.
- `sekurlsa::tickets /export` - Dump any Kerberos “tickets” (really ticket + session key data structures) from LSASS’s memory as .kirbi files. Tickets are named like ID-USER-SERVICE-DOMAIN.kirbi; ticket granting tickets have a `krbtgt` SERVICE name. If you can find a `krbtgt` ticket belonging to an administrator account, then you’ve struck gold (literally - see the next section).
- `kerberos::ptt TICKET_FILE` - Load the data structure in the specified .kirbi file into memory (allowing the account you’re logged in as to “pass the ticket” and impersonate the user whose ticket you’ve harvested).

The built-in Windows command `klist` will show you the current Kerberos tickets in memory.

The only real way to defend against this attack is to _only_ allow domain admins to log into domain controllers, _not_ lower privileged machines!

- [Rubeus - Now With More Kekeo](http://www.harmj0y.net/blog/redteaming/rubeus-now-with-more-kekeo/)

## Golden/Silver Ticket Attacks with Mimikatz

The idea with gold and silver tickets is that, since the KDC and service long term secret keys are just the NT hashes of the corresponding service account’s passwords, then if you can dump the password (or even its hash), you can _forge_ a kerberos ticket without ever needing to contact the KDC. (See “Silver & Golden Tickets”.)

Silver tickets are forged using a service account’s NT hash, and can be used to grant any user access to that service. This works because Kerberos implicitly assumes that _only_ the KDC and the service account know the service account’s long term secret key.

Golden tickets take things a step further - if you can get the `krbtgt` _user_’s NT hash, then you can forge a ticket granting ticket for any user, and then use that to get the KDC to provide a valid service ticket for any service that user has access to. This works because Kerberos trusts the encrypted ticket granting ticket blob and _doesn’t reauthenticate the user before granting further access_.

Golden tickets are powerful (since you can be anyone, it’s trivial to gain control of the domain), but also noisier - because you’re running through the KDC infrastructure, golden ticket still generate (almost) all of the normal logging, while silver tickets allow you to bypass the KDC completely and only generate logs on the service server (if that).

To generate a gold or silver ticket using Mimikatz, begin by running the `lsadump::lsa /inject /name:SERVICE` command to retrieve the service SID and NTLM password hash for that service. If SERVICE is `krbtgt` then this will allow the creation of a golden ticket, otherwise you’ll be creating a silver ticket.

(You can also use a user name instead of SERVICE, in which case it appears that Mimikatz will just request a ticket granting ticket from the KDC as that user in the next step; this is theoretically just as noisy as a golden ticket, but looks more “normal”.)

To actually create and cache the ticket, use `Kerberos::golden /user:USER /domain:DOMAIN /sid:SID /krbtgt:HASH /id:TYPE`, where:

- `USER` is the user to create the ticket for (probably the one you’ve compromised).
- `DOMAIN` is the domain to create the ticket for.
- `SID` is the SID of the service from the previous step.
- `HASH` is the NT hash of the service password from the previous step.
- `TYPE` is the type of Kerberos ticket to create; use 500 for a golden (ticket granting) ticket, and 1103 for a service ticket.

Once the ticket has been created, use `misc::cmd` to open a command prompt using the newly forged ticket.

- [Windows Password Hashes](https://cardboard-iguana.com/notes/windows-password-hashes.html)
- [Silver & Golden Tickets](https://en.hackndo.com/kerberos-silver-golden-tickets/)

## Kerberos Backdoors with Mimikatz

If Mimikatz is run on a domain controller, it can modify the authentication service’s memory using the `misc::skeleton` command to cause it to attempt to decrypt the AS-REQ using _both_ the user’s NT hash _and_ an NT hash of your choosing (by default `60BA4FCADC466C7A033C178194C03DF6`, which is just `mimikatz`). This means that you can send an AS-REQ as any user using the “skeleton key” hash to gain access as that user, similar to a golden ticket attack.

Obviously this isn’t very persistent itself, as the skeleton key will be lost if the server is rebooted or the authentication service restarted.

- [Windows Password Hashes](https://cardboard-iguana.com/notes/windows-password-hashes.html)
