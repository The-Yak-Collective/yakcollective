---
title: 'TryHackMe: Pre Security'
date: 2021-09-18 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-18-tryhackme-pre-security.html
author: 100007
---

# System Configuration

The Tools tab of msconfig.exe can be quite useful, as it provides full pats to various Windows system utilities (in the “Selected command” line).

# Computer Management

Want access to (almost) all of the Windows “snap-ins” in one hierarchical tree view? Then run compmgmt.msc!

Some UNIX \<-\> Windows equivalents:

- cron \<-\> Task Scheduler
- journalctl \<-\> Event Viewer
- htop \<-\> Resource Monitor
- bash \<-\> Command Prompt

Event types:

- Error - An event that indicates a significant problem such as loss of data or loss of functionality. For example, if a service fails to load during startup, an Error event is logged.
- Warning - An event that is not necessarily significant, but may indicate a possible future problem. For example, when disk space is low, a Warning event is logged. If an application can recover from an event without loss of functionality or data, it can generally classify the event as a Warning event.
- Information - An event that describes the successful operation of an application, driver, or service. For example, when a network driver loads successfully, it may be appropriate to log an Information event. Note that it is generally inappropriate for a desktop application to log an event each time it starts.
- Success Audit - An event that records an audited security access attempt that is successful. For example, a user’s successful attempt to log on to the system is logged as a Success Audit event.
- Failure Audit - An event that records an audited security access attempt that fails. For example, if a user tries to access a network drive and fails, the attempt is logged as a Failure Audit event.

Common logs:

- Application - Contains events logged by applications. For example, a database application might record a file error. The application developer decides which events to record.
- Security - Contains events such as valid and invalid logon attempts, as well as events related to resource use such as creating, opening, or deleting files or other objects. An administrator can start auditing to record events in the security log.
- System - Contains events logged by system components, such as the failure of a driver or other system component to load during startup.
- [CustomLog] - Contains events logged by applications that create a custom log. Using a custom log enables an application to control the size of the log or attach ACLs for security purposes without affecting other applications.

Other interesting parts of compmgmt.msc:

- Shared Folders: All current folder shares
- Sessions: Current logged in users
- Local Users and Groups: lusrmgr.msc
- Performance: perfmon.msc (a.k.a. Performance Monitor)
- Device Manager
- Storage: Backup and disk management snap-ins
- Services and Applications: Service manager and “Windows Management Instrumentation” (WMI)

WMI is an interface for allowing the scripting of computer management, now superseded by PowerShell.

- [lusrmgr.msc](https://cardboard-iguana.com/log/2021-09-17-tryhackme-pre-security.html)

# System Information

Lots of great stuff in msinfo32.exe (System Information).

All current user and system environment variables are listed here (though to acrually set them you’ll need to use Settings \> System \> About \> System info \> Advanced system settings \> Environment Variables).

There’s a hand search bar at the bottom of this utility.

# Command Prompt

More UNIX \<-\> Windows equivalents (command line edition):

- hostname \<-\> hostname
- whoami \<-\> whoami
- ifconfig \<-\> ipconfig
- clear \<-\> cls
- netstat \<-\> netstat

Where UNIX applications generally use -h or –help to display help information, Windows typically uses /?. (The “/” switches was pretty standard in early DOS and Windows applications, but in the Windows 10 era UNIX-style “-“ and “–” are used instead.)

The “net” command is a Windows-specific command line tool that is a kind of Swiss Army knife for controlling various Windows network-related settings (everything from network shares to NTP to - wait for it - user accounts). Like, it’s kinda nuts.

- [An A-Z Index of Windows CMD commands](https://ss64.com/nt/)

# Registry Editor

Apparently the Registry Editor goes by regedt32.exe in addition to the more familiar regedit.exe.

