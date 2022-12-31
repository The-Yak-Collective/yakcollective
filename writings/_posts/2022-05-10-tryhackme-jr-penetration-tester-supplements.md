---
title: 'TryHackMe: Jr. Penetration Tester (Supplements)'
date: 2022-05-10 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-05-10-tryhackme-jr-penetration-tester-supplements.html
author: 100007
---

Today’s TryHackMe Jr. Penetration Tester “supplements”:

- [TryHackMe: AD Certificate Templates](https://tryhackme.com/room/adcertificatetemplates)

## Introduction: AD Certificate Templates

This room is based on SpectreOps’ “Certified Pre-Owned” research, and will deal with misconfigured templated in the Active Directory Certificate Service (AD CS).

- [SpectreOps: Certified Pre-Owned](https://posts.specterops.io/certified-pre-owned-d95910965cd2)

## A Brief Look at Certificate Templates

AD CS is AD’s PKI, and is used on the back end for everything from provisioning disk encryption keys to user authentication. Certificate templates are a way to automate the certificate request process: Rather than an admin approving all CSRs manually, AD CS checks to see if a relevant “template” (which is really a template + associated settings + an access policy) exists that matches the supplied CSR and is configured to allow the requesting user to generate a certificate.

## Certificate Template Enumeration

Enumerate all certificate templates from a domain-joined computer and domain-authenticated user:

```
certutil -v -template
```

This will probably generate _a lot_ of output. Template blocks begin with `Template[n]:` (where `n` is an integer). We need a template to have three properties in order to use it for privesc or persistence:

- We need to be able to actually request a certificate. This is indicated by an `Allow Enroll` or `Allow Full Control` permission that has been assigned to a group or user you have access to.
- The certificate needs to be usable for Kerberos authentication. This is true when the “Enhanced Key Usage” extension allows for “Client Authentication”.
- We need to be able to set the certificate’s “Subject Alternative Name”. This is indicated by `TemplatePropSubjectNameFlags` (a.k.a. `CT_FLAG_ENROLLEE_SUPPLIES_SUBJECT`) being set to `1`.

There are actually some other requirements (like fully automated certificate provisioning), but _by default_ these are all satisfied.

It’s often helpful in this process to display information about the current user:

```
net user $USERNAME /domain
```

Note that the special group “Domain Users” represents all users in the domain, and “Domain Computers” represents all domain-joined computers (we can request a certificate as a computer if we have admin rights on that machine).

- [Kerberos](https://cardboard-iguana.com/notes/kerberos.html)

## Generating a Malicious Certificate

- Open up the Microsoft Management Console (`mmc`).
- Add the “Certificates” snap-in. (If you have local admin, you’ll be able to add the snap-in for local service accounts or the machine account itself.)
- Expand the “Certificates” tree, right click on “Personal”, and then use All Tasks \> Request New Certificate.
- Click through until you get to the “Request Certificates” dialog. Then select the vulnerable template and click on “More information is required to enroll this certificate.”
- Change the “Subject name” type to “Common name” and give the certificate any name you want. Then change “Alternative name” to “User principal name” and add in the UPN of the account (human, service, or computer) you want to impersonate. (Note that you’ll need to figure out this UPN some other way. UPNs take the form of `user@domain`.) Finally, explicitly add both to the certificate.
- Enroll!

The vulnerable cert will be added under the “Personal” folder that was initially clicked on. Once the certificate has been generated, export it (be sure to include the associated private key!) for use in other exploitation tools.

## User Impersonation Through a Certificate

Rubeus can be used to request a Kerberos ticket granting ticket using the certificate:

```
Rubeus.exe asktgt /user:$USER `
                  /enctype:aes256 `
                  /certificate:$CERTIFICATE_FILE `
                  /password:$CERTIFICATE_FILE_PASSWORD `
                  /outfile:$TICKET_FILE `
                  /domain:$DOMAIN `
                  /dc:$DC_IP_ADDRESS
```

Here we explode the UPN of the user we’re going to impersonate between the `/user` and `/domain` flags; using `/enctype:aes256` will prevent some alerts from being generated. TryHackMe recommends using the same domain controller that the CA service is running on. Once we have the ticket (in `$TICKET_FILE`), we can feed it into our favorite tool for actual exploitation.

Change a user’s password with Rubeus:

```
Rubeus.exe changepw /ticket:$TICKET_FILE `
                    /new:$NEW_PASSWORD `
                    /dc:$DC_IP_ADDRESS `
                    /targetuser:$DOMAIN\$USER
```

Use `runas` to open a command prompt as another user:

```
runas /user:$DOMAIN\$USER cmd.exe
```

- [Rubeus](https://cardboard-iguana.com/notes/rubeus.html)
- [Kerberos](https://cardboard-iguana.com/notes/kerberos.html)
