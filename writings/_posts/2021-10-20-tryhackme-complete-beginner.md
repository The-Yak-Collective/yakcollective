---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-20 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-20-tryhackme-complete-beginner.html
author: 100007
---

# Metasploit

## Move That Shell!

Use `db_nmap $FLAGS $IP` to run nmap directly from Metasploit and dump the results into the Metasploit DB. All nmap $FLAGS are supported. If you choose a scan type where root access is required, Metasploit will automatically prompt you to elevate privileges. Dumping nmap output directly into the database removes (?) the need to save output files using -oA.

Some useful Metasploit console commands:

- `hosts` - known hosts
- `services` - known services
- `vulns` - known vulnerabilities

The output of these three commands is updated as Metasploit gains more information through scans, etc.

- `use` - select a Metasploit module/exploit
- `show options` - show module/exploit options
- `exploit`/`run` - run the selected exploit
- `run -j` - run the selected exploit as a background job
- `jobs` - check the status of background jobs
- `sessions` - list open sessions (shells) on a box
- `sessions -i $SESSION_NUMER` - connect to session $SESSION\_NUMBER

Note that you can also call regular shell commands (`ip`, `ls`, etc.) from msfconsole.

REMEMBER: Open up the port Metasploit’s going to use in your firewall _before_ running the exploit. Generally this is port 4444 by default (set with LPORT).

- [Using “nmap”](https://cardboard-iguana.com/notes/nmap.html)

## We’re In, Now What?

Meterpreter (Metasploit remote shell) commands:

- `help` - help menu
- `help $COMMAND` - help specifically for $COMMAND
- `ps` - process list
- `migrate` - migrate Meterpreter into a different process
- `sysinfo` - display system information
- `ipconfig`/`ifconfig` - display network information
- `getuid` - display current user ID
- `getprivs` - display current user privileges
- `upload` - transfer file from the host to the target
- `download` - transfer file from the target to the host
- `run` - run a Metsploit module (see below)
- `load kiwi` - load (newer) mimikatz module
- `shell` - drop to system shell as the current user
- `background` - background the current Meterpreter session and return to the Metasploit console

I _think_ that Meterpreter is being run directly from memory, and what `migrate` is doing is basically creating a new process using the memory of a different application, hopping to that process, and then shutting down the old process.

- [How does process migration work in Meterpreter](https://security.stackexchange.com/a/92893)

The main reason to migrate the Meterpreter process is to hide it in a service or application that is likely to be long-lived. (Also, the initial Meterpreter process often isn’t all that stable, and migration generally ensures that it won’t just die on us.)

Potentially useful Metsploit modules to run from Meterpreter:

- `post/windows/gather/checkvm` - try to determine if we’re in a VM
- `post/multi/recon/local_exploit_suggester` - find possible privilege escalation exploits
- `post/windows/manage/enable_rdp` - enable RDP access (requires admin privileges)
- `post/multi/manage/autoroute` - manipulate target routing for pivoting
- `auxiliary/server/socks_proxy` - start a SOCKS proxy

## Makin’ Cisco Proud

There seem to be a lot of options for the `post/multi/manage/autoroute` and `auxiliary/server/socks_proxy` modules, but I don’t see a way to access them from Meterpreter (it looks like to get help you need to background Meterpreter and use the console).

The advantage of setting up a SOCKS proxy on the target is that you can then use proxychains to route through the target; this can allow you to pivot more deeply into the network that you’re attacking. (You probably want to create a custom proxychains.conf file to do this. Fortunately, /etc/proxychains.conf is well documented.)

