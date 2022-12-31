---
title: 'TryHackMe: Pre Security (Supplements)'
date: 2021-09-23 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-23-tryhackme-pre-security-supplements.html
author: 100007
---

# Core Windows Processes

## Task Manager

Windows categorizes all running programs into three broad buckets: Apps, Background processes, and Windows processes.

In the “Processes” tab, the “Process name” column will give you the file name for the running process; “Image path name” provides similar information in the “Details” tab. In both tabs, the “Command line” column provides the full command used to launch the process.

Task Manager doesn’t show parent process information; to get this (and more) requires third-party tools. This TryHackMe tutorial will be using “Process Hacker” and “Process Explorer” for this.

In the Command Prompt, `tasklist.exe` is roughly equivalent to the Task Manager. In PowerShell, the `Get-Process` command (aliased to `ps`) will display a similar list of processes.

## System

The “System” process _always_ has a PID of 4, and is where system (kernel) threads live (in effect, it _is_ the kernel). Kernel-mode processes in Windows share a common address space and are not isolated from each other; if a thread in System crashes, it takes _everything_ down with it. It used to be that all drivers lived in kernel-mode, though that’s (rightly!) been moved away from in recent years.

Depending on how the Windows process hierarchy is defined, System either has no parent, or has the parent of the “System Idle Process” (which always has PID 0).

- [User mode and kernel mode](https://docs.microsoft.com/en-us/windows-hardware/drivers/gettingstarted/user-mode-and-kernel-mode)

## System \> smss.exe

This is the “Session Manager Subsystem”; it’s the first user-mode process created during startup. It manages the Win32 environment (which is most of what people interact with these days), starting both kernel-mode (win32k.sys) and user-mode (winsrv.dll) components. It also starts csrss.exe and wininit.exe in session 0.

Only system processes live in session 0. New sessions (including user sessions) are created by smss.exe basically forking off to create a new session, starting csrss.exe and winlogon.exe for that session (wininit.exe _only_ lives in session 0).

The session manager also starts any required subsystems defined in the Required value of HKLM/System/CurrentControlSet/Control/Session Manager/Subsystems and sets all environment variables.

The session manager is _always_ a child process of System. Forks of smss.exe that start new sessions terminate almost immediately, though their children remain. Note that csrss.exe and wininit.exe are _also_ started by a forked child of smss.exe that then terminates, rather than by the master smss.exe process itself.

## csrss.exe

This is the “Client Server Runtime Process”. It manages the user-mode side of the Win32 subsystem, brokering API calls, mapping drives, and handling the session shutdown process. It is _only_ ever a child of smss.exe.

