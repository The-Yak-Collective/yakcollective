---
title: 'TryHackMe: Complete Beginner (Supplements)'
date: 2021-12-02 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-12-02-tryhackme-complete-beginner-supplements.html
author: 100007
---

# TryHackMe: Complete Beginner (Supplements)

**author:** Nathan Acks  
**date:** 2021-12-02

# CC: Pen Testing

## smbmap

`-h` - IP address or host to enumerate

`-u` - username to use during enumeration (attempts to use the NULL session if not supplied)

`-p` - password or NTLM hash to use during enumeration

`-d` - domain (or workgroup) to use during enumeration

`-s` - share to enumerate (defaults to `C$` if not supplied)

`-x` - attempt to execute the supplied command (!!!) on the server (if the user you’re connecting as has permission to do so)

`--download`/`--upload` - download or upload a file to specified share

- [Windows Password Hashes](https://cardboard-iguana.com/notes/windows-password-hashes.html)

## smbclient

`-I` - IP address to connect to

`-U` - username to use for the connection

`-P` - password to use for the connection

`-N` - attempt to connect without a password

`-W` - domain (or workgroup) to use for the connection

`-c` - attempt to execute the supplied command (!!!) on the server (if the user you’re connecting as has permission to do so)

Once connected, `smbclient` provides an `ftp`-like interface.

## Final Exam

Not much context. The machine for this test is at 10.10.87.144 and we know that there are two flags in the files `user.txt` and `root.txt`.

We begin by running a full nmap scan:

```
sudo nmap -vv -oA cc-pentesting -A -sS --script vuln \
-p- 10.10.87.144
```

Output:

```
# Nmap 7.92 scan initiated Thu Dec 2 20:11:50 2021 as: nmap -vv -oA cc-pentesting -A -sS -script vuln -p- 10.10.87.144
Pre-scan script results:
| broadcast-avahi-dos:
| Discovered hosts:
| 224.0.0.251
| After NULL UDP avahi packet DoS (CVE-2011-1002).
|_ Hosts are all up (not vulnerable).
Nmap scan report for 10.10.87.144
Host is up, received reset ttl 61 (0.16s latency).
Scanned at 2021-12-02 20:12:26 MST for 1247s
Not shown: 65533 closed tcp ports (reset)
PORT STATE SERVICE REASON VERSION
22/tcp open ssh syn-ack ttl 61 OpenSSH 7.2p2 Ubuntu 4ubuntu2.8 (Ubuntu Linux; protocol 2.0)
| vulners:
| cpe:/a:openbsd:openssh:7.2p2:
| PACKETSTORM:140070 7.8 https://vulners.com/packetstorm/PACKETSTORM:140070 *EXPLOIT*
| EXPLOITPACK:5BCA798C6BA71FAE29334297EC0B6A09 7.8 https://vulners.com/exploitpack/EXPLOITPACK:5BCA798C6BA71FAE29334297EC0B6A09 *EXPLOIT*
| EDB-ID:40888 7.8 https://vulners.com/exploitdb/EDB-ID:40888 *EXPLOIT*
| CVE-2016-8858 7.8 https://vulners.com/cve/CVE-2016-8858
| CVE-2016-6515 7.8 https://vulners.com/cve/CVE-2016-6515
| 1337DAY-ID-26494 7.8 https://vulners.com/zdt/1337DAY-ID-26494 *EXPLOIT*
| SSV:92579 7.5 https://vulners.com/seebug/SSV:92579 *EXPLOIT*
| CVE-2016-10009 7.5 https://vulners.com/cve/CVE-2016-10009
| 1337DAY-ID-26576 7.5 https://vulners.com/zdt/1337DAY-ID-26576 *EXPLOIT*
| SSV:92582 7.2 https://vulners.com/seebug/SSV:92582 *EXPLOIT*
| CVE-2016-10012 7.2 https://vulners.com/cve/CVE-2016-10012
| CVE-2015-8325 7.2 https://vulners.com/cve/CVE-2015-8325
| SSV:92580 6.9 https://vulners.com/seebug/SSV:92580 *EXPLOIT*
| CVE-2016-10010 6.9 https://vulners.com/cve/CVE-2016-10010
| 1337DAY-ID-26577 6.9 https://vulners.com/zdt/1337DAY-ID-26577 *EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/SUSE-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/SUSE-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/SUSE-CVE-2019-25017/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/SUSE-CVE-2019-25017/ *EXPLOIT*
| MSF:ILITIES/REDHAT_LINUX-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/REDHAT-OPENSHIFT-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/REDHAT-OPENSHIFT-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/OPENBSD-OPENSSH-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/OPENBSD-OPENSSH-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/IBM-AIX-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/IBM-AIX-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/GENTOO-LINUX-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/GENTOO-LINUX-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/F5-BIG-IP-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/F5-BIG-IP-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/DEBIAN-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/DEBIAN-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/CENTOS_LINUX-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/CENTOS_LINUX-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/AMAZON_LINUX-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/AMAZON_LINUX-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/AMAZON-LINUX-AMI-2-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/AMAZON-LINUX-AMI-2-CVE-2019-6111/ *EXPLOIT*
| MSF:ILITIES/ALPINE-LINUX-CVE-2019-6111/ 5.8 https://vulners.com/metasploit/MSF:ILITIES/ALPINE-LINUX-CVE-2019-6111/ *EXPLOIT*
| EXPLOITPACK:98FE96309F9524B8C84C508837551A19 5.8 https://vulners.com/exploitpack/EXPLOITPACK:98FE96309F9524B8C84C508837551A19 *EXPLOIT*
| EXPLOITPACK:5330EA02EBDE345BFC9D6DDDD97F9E97 5.8 https://vulners.com/exploitpack/EXPLOITPACK:5330EA02EBDE345BFC9D6DDDD97F9E97 *EXPLOIT*
| EDB-ID:46516 5.8 https://vulners.com/exploitdb/EDB-ID:46516 *EXPLOIT*
| CVE-2019-6111 5.8 https://vulners.com/cve/CVE-2019-6111
| 1337DAY-ID-32328 5.8 https://vulners.com/zdt/1337DAY-ID-32328 *EXPLOIT*
| 1337DAY-ID-32009 5.8 https://vulners.com/zdt/1337DAY-ID-32009 *EXPLOIT*
| SSV:91041 5.5 https://vulners.com/seebug/SSV:91041 *EXPLOIT*
| PACKETSTORM:140019 5.5 https://vulners.com/packetstorm/PACKETSTORM:140019 *EXPLOIT*
| PACKETSTORM:136234 5.5 https://vulners.com/packetstorm/PACKETSTORM:136234 *EXPLOIT*
| EXPLOITPACK:F92411A645D85F05BDBD274FD222226F 5.5 https://vulners.com/exploitpack/EXPLOITPACK:F92411A645D85F05BDBD274FD222226F *EXPLOIT*
| EXPLOITPACK:9F2E746846C3C623A27A441281EAD138 5.5 https://vulners.com/exploitpack/EXPLOITPACK:9F2E746846C3C623A27A441281EAD138 *EXPLOIT*
| EXPLOITPACK:1902C998CBF9154396911926B4C3B330 5.5 https://vulners.com/exploitpack/EXPLOITPACK:1902C998CBF9154396911926B4C3B330 *EXPLOIT*
| EDB-ID:40858 5.5 https://vulners.com/exploitdb/EDB-ID:40858 *EXPLOIT*
| CVE-2016-3115 5.5 https://vulners.com/cve/CVE-2016-3115
| SSH_ENUM 5.0 https://vulners.com/canvas/SSH_ENUM *EXPLOIT*
| PACKETSTORM:150621 5.0 https://vulners.com/packetstorm/PACKETSTORM:150621 *EXPLOIT*
| MSF:AUXILIARY/SCANNER/SSH/SSH_ENUMUSERS 5.0 https://vulners.com/metasploit/MSF:AUXILIARY/SCANNER/SSH/SSH_ENUMUSERS *EXPLOIT*
| EXPLOITPACK:F957D7E8A0CC1E23C3C649B764E13FB0 5.0 https://vulners.com/exploitpack/EXPLOITPACK:F957D7E8A0CC1E23C3C649B764E13FB0 *EXPLOIT*
| EXPLOITPACK:EBDBC5685E3276D648B4D14B75563283 5.0 https://vulners.com/exploitpack/EXPLOITPACK:EBDBC5685E3276D648B4D14B75563283 *EXPLOIT*
| EDB-ID:45939 5.0 https://vulners.com/exploitdb/EDB-ID:45939 *EXPLOIT*
| CVE-2018-15919 5.0 https://vulners.com/cve/CVE-2018-15919
| CVE-2018-15473 5.0 https://vulners.com/cve/CVE-2018-15473
| CVE-2017-15906 5.0 https://vulners.com/cve/CVE-2017-15906
| CVE-2016-10708 5.0 https://vulners.com/cve/CVE-2016-10708
| 1337DAY-ID-31730 5.0 https://vulners.com/zdt/1337DAY-ID-31730 *EXPLOIT*
| EDB-ID:45233 4.6 https://vulners.com/exploitdb/EDB-ID:45233 *EXPLOIT*
| EDB-ID:40963 4.6 https://vulners.com/exploitdb/EDB-ID:40963 *EXPLOIT*
| EDB-ID:40962 4.6 https://vulners.com/exploitdb/EDB-ID:40962 *EXPLOIT*
| CVE-2021-41617 4.4 https://vulners.com/cve/CVE-2021-41617
| MSF:ILITIES/OPENBSD-OPENSSH-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/OPENBSD-OPENSSH-CVE-2020-14145/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP9-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP9-CVE-2020-14145/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2020-14145/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2020-14145/ *EXPLOIT*
| MSF:ILITIES/F5-BIG-IP-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/F5-BIG-IP-CVE-2020-14145/ *EXPLOIT*
| EXPLOITPACK:802AF3229492E147A5F09C7F2B27C6DF 4.3 https://vulners.com/exploitpack/EXPLOITPACK:802AF3229492E147A5F09C7F2B27C6DF *EXPLOIT*
| EXPLOITPACK:5652DDAA7FE452E19AC0DC1CD97BA3EF 4.3 https://vulners.com/exploitpack/EXPLOITPACK:5652DDAA7FE452E19AC0DC1CD97BA3EF *EXPLOIT*
| CVE-2020-14145 4.3 https://vulners.com/cve/CVE-2020-14145
| CVE-2016-6210 4.3 https://vulners.com/cve/CVE-2016-6210
| 1337DAY-ID-25440 4.3 https://vulners.com/zdt/1337DAY-ID-25440 *EXPLOIT*
| 1337DAY-ID-25438 4.3 https://vulners.com/zdt/1337DAY-ID-25438 *EXPLOIT*
| CVE-2019-6110 4.0 https://vulners.com/cve/CVE-2019-6110
| CVE-2019-6109 4.0 https://vulners.com/cve/CVE-2019-6109
| CVE-2018-20685 2.6 https://vulners.com/cve/CVE-2018-20685
| SSV:92581 2.1 https://vulners.com/seebug/SSV:92581 *EXPLOIT*
| CVE-2016-10011 2.1 https://vulners.com/cve/CVE-2016-10011
| PACKETSTORM:151227 0.0 https://vulners.com/packetstorm/PACKETSTORM:151227 *EXPLOIT*
| PACKETSTORM:140261 0.0 https://vulners.com/packetstorm/PACKETSTORM:140261 *EXPLOIT*
| PACKETSTORM:138006 0.0 https://vulners.com/packetstorm/PACKETSTORM:138006 *EXPLOIT*
| PACKETSTORM:137942 0.0 https://vulners.com/packetstorm/PACKETSTORM:137942 *EXPLOIT*
| EDB-ID:46193 0.0 https://vulners.com/exploitdb/EDB-ID:46193 *EXPLOIT*
| EDB-ID:40136 0.0 https://vulners.com/exploitdb/EDB-ID:40136 *EXPLOIT*
| EDB-ID:40113 0.0 https://vulners.com/exploitdb/EDB-ID:40113 *EXPLOIT*
| EDB-ID:39569 0.0 https://vulners.com/exploitdb/EDB-ID:39569 *EXPLOIT*
| 1337DAY-ID-30937 0.0 https://vulners.com/zdt/1337DAY-ID-30937 *EXPLOIT*
|_ 1337DAY-ID-10010 0.0 https://vulners.com/zdt/1337DAY-ID-10010 *EXPLOIT*
80/tcp open http syn-ack ttl 61 Apache httpd 2.4.18 ((Ubuntu))
| http-slowloris-check:
| VULNERABLE:
| Slowloris DOS attack
| State: LIKELY VULNERABLE
| IDs: CVE:CVE-2007-6750
| Slowloris tries to keep many connections to the target web server open and hold
| them open as long as possible. It accomplishes this by opening connections to
| the target web server and sending a partial request. By doing so, it starves
| the http server's resources causing Denial Of Service.
|
| Disclosure date: 2009-09-17
| References:
| https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6750
|_ http://ha.ckers.org/slowloris/
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
|_http-dombased-xss: Couldn't find any DOM based XSS.
| http-enum:
|_ /secret/: Potentially interesting folder
|_http-jsonp-detection: Couldn't find any JSONP endpoints.
| vulners:
| cpe:/a:apache:http_server:2.4.18:
| CVE-2021-39275 7.5 https://vulners.com/cve/CVE-2021-39275
| CVE-2021-26691 7.5 https://vulners.com/cve/CVE-2021-26691
| CVE-2017-7679 7.5 https://vulners.com/cve/CVE-2017-7679
| CVE-2017-7668 7.5 https://vulners.com/cve/CVE-2017-7668
| CVE-2017-3169 7.5 https://vulners.com/cve/CVE-2017-3169
| CVE-2017-3167 7.5 https://vulners.com/cve/CVE-2017-3167
| MSF:ILITIES/REDHAT_LINUX-CVE-2019-0211/ 7.2 https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2019-0211/ *EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2019-0211/ 7.2 https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2019-0211/ *EXPLOIT*
| EXPLOITPACK:44C5118F831D55FAF4259C41D8BDA0AB 7.2 https://vulners.com/exploitpack/EXPLOITPACK:44C5118F831D55FAF4259C41D8BDA0AB *EXPLOIT*
| CVE-2019-0211 7.2 https://vulners.com/cve/CVE-2019-0211
| 1337DAY-ID-32502 7.2 https://vulners.com/zdt/1337DAY-ID-32502 *EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1312/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1312/ *EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/SUSE-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/SUSE-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/REDHAT_LINUX-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/ORACLE_LINUX-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/ORACLE_LINUX-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2018-1312/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2018-1312/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2018-1312/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2018-1312/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP1-CVE-2018-1312/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP1-CVE-2018-1312/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP1-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP1-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/FREEBSD-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/FREEBSD-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/DEBIAN-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/DEBIAN-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/CENTOS_LINUX-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/CENTOS_LINUX-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/APACHE-HTTPD-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/APACHE-HTTPD-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/AMAZON_LINUX-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/AMAZON_LINUX-CVE-2017-15715/ *EXPLOIT*
| MSF:ILITIES/ALPINE-LINUX-CVE-2018-1312/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/ALPINE-LINUX-CVE-2018-1312/ *EXPLOIT*
| MSF:ILITIES/ALPINE-LINUX-CVE-2017-15715/ 6.8 https://vulners.com/metasploit/MSF:ILITIES/ALPINE-LINUX-CVE-2017-15715/ *EXPLOIT*
| FDF3DFA1-ED74-5EE2-BF5C-BA752CA34AE8 6.8 https://vulners.com/githubexploit/FDF3DFA1-ED74-5EE2-BF5C-BA752CA34AE8 *EXPLOIT*
| CVE-2021-40438 6.8 https://vulners.com/cve/CVE-2021-40438
| CVE-2020-35452 6.8 https://vulners.com/cve/CVE-2020-35452
| CVE-2018-1312 6.8 https://vulners.com/cve/CVE-2018-1312
| CVE-2017-15715 6.8 https://vulners.com/cve/CVE-2017-15715
| 4810E2D9-AC5F-5B08-BFB3-DDAFA2F63332 6.8 https://vulners.com/githubexploit/4810E2D9-AC5F-5B08-BFB3-DDAFA2F63332 *EXPLOIT*
| CVE-2019-10082 6.4 https://vulners.com/cve/CVE-2019-10082
| CVE-2017-9788 6.4 https://vulners.com/cve/CVE-2017-9788
| MSF:ILITIES/REDHAT_LINUX-CVE-2019-0217/ 6.0 https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2019-0217/ *EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2019-0217/ 6.0 https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2019-0217/ *EXPLOIT*
| CVE-2019-0217 6.0 https://vulners.com/cve/CVE-2019-0217
| EDB-ID:47689 5.8 https://vulners.com/exploitdb/EDB-ID:47689 *EXPLOIT*
| CVE-2020-1927 5.8 https://vulners.com/cve/CVE-2020-1927
| CVE-2019-10098 5.8 https://vulners.com/cve/CVE-2019-10098
| 1337DAY-ID-33577 5.8 https://vulners.com/zdt/1337DAY-ID-33577 *EXPLOIT*
| CVE-2016-5387 5.1 https://vulners.com/cve/CVE-2016-5387
| SSV:96537 5.0 https://vulners.com/seebug/SSV:96537 *EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1333/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1333/ *EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1303/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1303/ *EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2017-15710/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2017-15710/ *EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2020-1934/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2020-1934/ *EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2017-15710/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2017-15710/ *EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2017-15710/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2017-15710/ *EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2016-8743/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2016-8743/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2017-15710/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2017-15710/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2017-15710/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2017-15710/ *EXPLOIT*
| MSF:ILITIES/CENTOS_LINUX-CVE-2017-15710/ 5.0 https://vulners.com/metasploit/MSF:ILITIES/CENTOS_LINUX-CVE-2017-15710/ *EXPLOIT*
| MSF:AUXILIARY/SCANNER/HTTP/APACHE_OPTIONSBLEED 5.0 https://vulners.com/metasploit/MSF:AUXILIARY/SCANNER/HTTP/APACHE_OPTIONSBLEED *EXPLOIT*
| EXPLOITPACK:C8C256BE0BFF5FE1C0405CB0AA9C075D 5.0 https://vulners.com/exploitpack/EXPLOITPACK:C8C256BE0BFF5FE1C0405CB0AA9C075D *EXPLOIT*
| EXPLOITPACK:2666FB0676B4B582D689921651A30355 5.0 https://vulners.com/exploitpack/EXPLOITPACK:2666FB0676B4B582D689921651A30355 *EXPLOIT*
| EDB-ID:40909 5.0 https://vulners.com/exploitdb/EDB-ID:40909 *EXPLOIT*
| CVE-2021-34798 5.0 https://vulners.com/cve/CVE-2021-34798
| CVE-2021-33193 5.0 https://vulners.com/cve/CVE-2021-33193
| CVE-2021-26690 5.0 https://vulners.com/cve/CVE-2021-26690
| CVE-2020-1934 5.0 https://vulners.com/cve/CVE-2020-1934
| CVE-2019-17567 5.0 https://vulners.com/cve/CVE-2019-17567
| CVE-2019-0220 5.0 https://vulners.com/cve/CVE-2019-0220
| CVE-2019-0196 5.0 https://vulners.com/cve/CVE-2019-0196
| CVE-2018-17199 5.0 https://vulners.com/cve/CVE-2018-17199
| CVE-2018-17189 5.0 https://vulners.com/cve/CVE-2018-17189
| CVE-2018-1333 5.0 https://vulners.com/cve/CVE-2018-1333
| CVE-2018-1303 5.0 https://vulners.com/cve/CVE-2018-1303
| CVE-2017-9798 5.0 https://vulners.com/cve/CVE-2017-9798
| CVE-2017-15710 5.0 https://vulners.com/cve/CVE-2017-15710
| CVE-2016-8743 5.0 https://vulners.com/cve/CVE-2016-8743
| CVE-2016-8740 5.0 https://vulners.com/cve/CVE-2016-8740
| CVE-2016-4979 5.0 https://vulners.com/cve/CVE-2016-4979
| 1337DAY-ID-28573 5.0 https://vulners.com/zdt/1337DAY-ID-28573 *EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2019-0197/ 4.9 https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2019-0197/ *EXPLOIT*
| CVE-2019-0197 4.9 https://vulners.com/cve/CVE-2019-0197
| MSF:ILITIES/UBUNTU-CVE-2018-1302/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1302/ *EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1301/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1301/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2016-4975/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2016-4975/ *EXPLOIT*
| MSF:ILITIES/DEBIAN-CVE-2019-10092/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/DEBIAN-CVE-2019-10092/ *EXPLOIT*
| MSF:ILITIES/APACHE-HTTPD-CVE-2020-11985/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/APACHE-HTTPD-CVE-2020-11985/ *EXPLOIT*
| MSF:ILITIES/APACHE-HTTPD-CVE-2019-10092/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/APACHE-HTTPD-CVE-2019-10092/ *EXPLOIT*
| EDB-ID:47688 4.3 https://vulners.com/exploitdb/EDB-ID:47688 *EXPLOIT*
| CVE-2020-11985 4.3 https://vulners.com/cve/CVE-2020-11985
| CVE-2019-10092 4.3 https://vulners.com/cve/CVE-2019-10092
| CVE-2018-1302 4.3 https://vulners.com/cve/CVE-2018-1302
| CVE-2018-1301 4.3 https://vulners.com/cve/CVE-2018-1301
| CVE-2018-11763 4.3 https://vulners.com/cve/CVE-2018-11763
| CVE-2016-4975 4.3 https://vulners.com/cve/CVE-2016-4975
| CVE-2016-1546 4.3 https://vulners.com/cve/CVE-2016-1546
| 4013EC74-B3C1-5D95-938A-54197A58586D 4.3 https://vulners.com/githubexploit/4013EC74-B3C1-5D95-938A-54197A58586D *EXPLOIT*
| 1337DAY-ID-33575 4.3 https://vulners.com/zdt/1337DAY-ID-33575 *EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1283/ 3.5 https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1283/ *EXPLOIT*
| MSF:ILITIES/REDHAT_LINUX-CVE-2018-1283/ 3.5 https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2018-1283/ *EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2018-1283/ 3.5 https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2018-1283/ *EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2018-1283/ 3.5 https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2018-1283/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2018-1283/ 3.5 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2018-1283/ *EXPLOIT*
| MSF:ILITIES/CENTOS_LINUX-CVE-2018-1283/ 3.5 https://vulners.com/metasploit/MSF:ILITIES/CENTOS_LINUX-CVE-2018-1283/ *EXPLOIT*
| CVE-2018-1283 3.5 https://vulners.com/cve/CVE-2018-1283
| CVE-2016-8612 3.3 https://vulners.com/cve/CVE-2016-8612
| PACKETSTORM:152441 0.0 https://vulners.com/packetstorm/PACKETSTORM:152441 *EXPLOIT*
| EDB-ID:46676 0.0 https://vulners.com/exploitdb/EDB-ID:46676 *EXPLOIT*
| EDB-ID:42745 0.0 https://vulners.com/exploitdb/EDB-ID:42745 *EXPLOIT*
| 1337DAY-ID-663 0.0 https://vulners.com/zdt/1337DAY-ID-663 *EXPLOIT*
| 1337DAY-ID-601 0.0 https://vulners.com/zdt/1337DAY-ID-601 *EXPLOIT*
| 1337DAY-ID-4533 0.0 https://vulners.com/zdt/1337DAY-ID-4533 *EXPLOIT*
| 1337DAY-ID-3109 0.0 https://vulners.com/zdt/1337DAY-ID-3109 *EXPLOIT*
|_ 1337DAY-ID-2237 0.0 https://vulners.com/zdt/1337DAY-ID-2237 *EXPLOIT*
|_http-server-header: Apache/2.4.18 (Ubuntu)
|_http-csrf: Couldn't find any CSRF vulnerabilities.
|_http-litespeed-sourcecode-download: Request with null byte did not work. This web server might not be vulnerable
|_http-wordpress-users: [Error] Wordpress installation was not found. We couldn't find wp-login.php
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.92%E=4%D=12/2%OT=22%CT=1%CU=35070%PV=Y%DS=4%DC=T%G=Y%TM=61A98FF
OS:9%P=x86_64-pc-linux-gnu)SEQ(SP=100%GCD=1%ISR=106%TI=Z%CI=I%II=I%TS=8)OPS
OS:(O1=M506ST11NW7%O2=M506ST11NW7%O3=M506NNT11NW7%O4=M506ST11NW7%O5=M506ST1
OS:1NW7%O6=M506ST11)WIN(W1=68DF%W2=68DF%W3=68DF%W4=68DF%W5=68DF%W6=68DF)ECN
OS:(R=Y%DF=Y%T=40%W=6903%O=M506NNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=A
OS:S%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R
OS:=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F
OS:=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%
OS:T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD
OS:=S)
Uptime guess: 0.014 days (since Thu Dec 2 20:12:51 2021)
Network Distance: 4 hops
TCP Sequence Prediction: Difficulty=255 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
TRACEROUTE (using port 80/tcp)
HOP RTT ADDRESS
1 28.51 ms 10.13.0.1
2 ... 3
4 169.21 ms 10.10.87.144
Read data files from: /usr/bin/../share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Thu Dec 2 20:33:13 2021 -- 1 IP address (1 host up) scanned in 1283.72 seconds
```

So, only two services available: HTTP (port 80) and SSH (port 22).

The web server is just running the Ubuntu Apache2 default page, but nmap has already identified the potentially interesting directory `/secret/`. Navigating to that directory reveals that it contains an empty `index.html` file, however.

Let’s see what gobuster can find.

```
gobuster -t 50 dir \
-w /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt \
-u http://10.10.87.144/secret/ \
-x bak,htm,html,php,phtml,ppk,txt
```

So, we’ve got the file `http://10.10.87.144/secret/secret.txt` containing `nyan:046385855FC9580393853D8E81F240B66FE9A7B8`. That could be a password, but it also looks like a hash of some kind (and who outside of me uses passwords that look like that?). It’s the right length for a SHA1 hash, so let’s see what hashcat can make of it.

```
hashcat -m 100 \
-O 046385855FC9580393853D8E81F240B66FE9A7B8 \
~/.local/share/red-team/wordlists/rockyou.txt
```

And the hash is… `nyan`?

Let’s see if we can log in via SSH to nyan@10.10.87.144 using the password “nyan”.

We can! And there in the user directory is the magical `user.txt` containing our first flag.

```
cat ~/user.txt
```

Okay, we’re in and we have the first flag. Now to elevate privileges.

Can nyan do anything interesting?

```
grep nyan /etc/group
```

Oooh… We have some level of sudo access. Let’s see how much

```
sudo -l
```

NOPASSWD on /bin/su, so that’s our ticket.

```
sudo su
ls /root
cat /root/root.txt
```

And that’s flag 2.

- [Using “nmap”](https://cardboard-iguana.com/notes/nmap.html)
- [Using “gobuster”](https://cardboard-iguana.com/notes/gobuster.html)
- [Using Hashcat](https://cardboard-iguana.com/notes/hashcat.html)
