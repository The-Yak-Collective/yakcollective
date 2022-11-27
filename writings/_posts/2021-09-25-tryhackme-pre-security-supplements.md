---
title: 'TryHackMe: Pre Security (Supplements)'
date: 2021-09-25 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-25-tryhackme-pre-security-supplements.html
author: 100007
---

# TryHackMe: Pre Security (Supplements)

**author:** Nathan Acks  
**date:** 2021-09-25

# Windows Event Logs

## Event Viewer

Windows Event logs are stored in a proprietary binary format with extension .evt or .evtx. Most reside in C:/Windows/System32/Winevt/Logs.

Three tools for viewing event logs:

- Event Viewer (eventvwr.msc)
- wevtutil.exe (command line)
- Get-WinEvent (PowerShell)

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

Windows log entry event IDs are not unique, but rather correspond to a “Task Category”. These values are set by the logging application, and are used to help filter log events. By default, the Event Viewer lists log entries in reverse chronological order (most recent first).

You can control log rotation for each log file through its “Properties”.

The Event Viewer can view logs on other computers (I assume this only applies to domain-joined machines that the current user has access to).

Filtering for events can be achieved using the “Create Custom View” (across all logs) or “Filter Current Log” (for the current log) options on the right.

NOTE: PowerShell produces a couple of different logs which, by default, log almost everything it does.

## Get-WinEvent

```
# Get help on Get-WinEvent (calls out to Microsoft).
#
Get-Help Get-WinEvent
# Filter event log output using the Where-Object command. This
# apparently pipes the entire output to the Where-Object command, which
# then scans for the appropriate field. So a bit inefficient for large
# logs.
#
Get-WinEvent -LogName Application | Where-Object {
$_.ProviderName -Match 'WLMS'
}
# To match event IDs with Where-Object, use the slightly different form
# `Where-Object Id -eq 100`, etc.
# Use the -FilterHashtable flag. This causes the filtering to be done
# during the call made by Get-WinEvent, and has a more straight-forward
# syntax too. However, it only works when called against the system
# event log; Where-Object needs to be used when specifying an archived
# log via -Path.
#
# Note that hashes can be specified with newlines instead of semicolons
# as well, which can make scripts A LOT more readable!
#
Get-WinEvent -FilterHashtable @{
LogName = 'Application'; ProviderName = 'WLMS'
}
# To display all information about an event, pipe the output of
# Get-WinEvent to `Format-List -Property *`
```

Keys for -FilterHashtable:

- LogName (String)
- ProviderName (String)
- Path (String)
- Keywords (Long)
- ID (Int32)
- Level (Int32)
- StartTime (DateTime)
- EndTime (DateTime)
- UserID (SID)
- Data (String)
- [NamedData] (String)

Wildcards can be used with LogName and ProviderName, but not with other keys.

## XPath Queries

XPath is a W3C spec for identifying elements in an XML document. Microsoft supports a subset of this spec for querying event logs. Consider:

```
<Event xmls="http://schemas.microsoft.com/win/2004/08/events/event">
<System>
<Provider Name="WLMS" />
<EventID Qualifiers="0">100</EventID>
<Level>4</Level>
<Task>0</Task>
<Keywords>0x80000000000000</Keywords>
<TimeCreated SystemTime="2020-12-15T01:09:08.940277500Z" />
<EventRecordID>238</EventRecordID>
<Channel>Application</Channel>
<Computer>WIN-1O0UJBNP9G7</Computer>
<Security />
</System>
<EventData />
</Event>
```

To find events with an Event ID of 100, we could use `Event/System/EventID=100`. To find events from the WLMS provide, we could use `Event/System/Provider[@Name="WLMS"]`. We could combine these to over-specify the first path as `Event/System/EventID[@Qualifiers="0"]=100`. Path elements can be replaced with wildcards (`*`), and pathspecs can be joined using `and` and `or`. Quoting is (obviously) required for strings containing spaces, but is otherwise optional.

## Putting Theory Into Practice

Event IDs refer to specific _types_ of events, while Event Record IDs provide a unique ID for a particular event. Neither is unique _between_ logs, however: Different applications may use the same Event ID to indicate different events, while Event Record IDs are only unique _within_ a particular log.

