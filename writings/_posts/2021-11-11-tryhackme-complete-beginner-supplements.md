---
title: 'TryHackMe: Complete Beginner (Supplements)'
date: 2021-11-11 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-11-tryhackme-complete-beginner-supplements.html
author: 100007
---

# TryHackMe: Complete Beginner (Supplements)

**author:** Nathan Acks  
**date:** 2021-11-11

# Splunk

## Ransomware

There are three different event source fields in Splunk:

- `src_ip` contains source IP addresses _only_ (if known).
- `src_host` contains (generally fully qualified) source hostnames _only_ (if known).
- `src` contains a mix of both hostnames and IP addresses, but only _one_ of these at a time.

However, events _can_ contain both a `src_ip` and a `src_host`, correlating these two fields is a good way to determine hostnames from IP addresses or IP addresses from hostnames.

For network connections, `dest_ip`, `dest_host`, and `dest` follow similar logic.

Most Windows logs use hostnames rather than IP addresses.

Apparently, USB storage and filesystem names are stored in the Windows registry, so registry event logs will contain this information. The “name” that is shown in the File Explorer is known as the `friendlyname` in the registry.

- [USB Device Registry Entries](https://msdn.microsoft.com/en-us/library/windows/hardware/jj649944%28v=vs.85%29.aspx)

Network share information is stored/logged by the registry similarly. Network share registry keys are the share path, with `\` characters replaced by `#`.

Be aware that the _user_ recorded in the registry logs can be an application rather than a human!

Unfortunately, it looks like Sysmon _doesn’t_ record `friendlyname` values, but only drive paths. However, Sysmon does record both the `CommandLine` and `ParentCommandLine` attributes for all executed applications; this is much finer-grained data than most anti-virus solutions. I can see why Kevin Beaumont likes it so much!

Remember that `*` in Splunk matches _one_ or more characters, so `field=*` is an effective way of removing unset fields from a search. The `*` wildcard can even be used to specify `sourcetype` values.

Also recall that `EventCode=1` corresponds to process execution.

- [Kevin Beaumont (Twitter)](https://twitter.com/GossiTheDog)

# Volatility

## Obtaining Memory Samples

Tools for obtaining memory dumps from running systems:

- FTK Imager
- Redline
- DumpIt.exe
- win32dd.exe / win64dd.exe

These generate uncompressed .raw dumps of system memory. Basically everything can work with these.

For powered off or hibernating Windows systems, grab %SystemDrive%/hiberfil.sys, which is a compressed copy of the system’s memory. Linux systems that are hibernating also contain hibernation files or write memory contents to their swap partitions (though it’s not clear how to deal with those).

For virtual machines:

- VMware - .vmem
- Hyper-V - .bin
- Parallels - .mem
- VirtualBox - .sav

In all cases _except_ VirtualBox, these files are maintained during run-time, and thus can provide a memory image without shutting the VM off (though I presume that it’s desirable to suspend it temporarily when copying). VirtualBox .sav files are kind of useless though, as they’re only partial; treat these VMs as if they were running on bare metal (for the purpose of memory dumps).

