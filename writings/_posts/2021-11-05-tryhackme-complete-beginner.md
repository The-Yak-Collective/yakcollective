---
title: 'TryHackMe: Complete Beginner'
date: 2021-11-05 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-05-tryhackme-complete-beginner.html
author: 100007
---

# Kenobi

## Deploy the Vulnerable Machine

The machine’s IP address is 10.10.179.107. Let’s run an initial scan.

```
sudo nmap -v -oA kenobi -A -sS --script vuln \
          -p- 10.10.179.107
```

Results:

```
# Nmap 7.92 scan initiated Fri Nov 5 21:49:50 2021 as: nmap -v -oA kenobi -A -sS --script vuln -p- 10.10.179.107
Increasing send delay for 10.10.179.107 from 5 to 10 due to 11 out of 12 dropped probes since last increase.
Nmap scan report for 10.10.179.107
Host is up (0.17s latency).
Not shown: 65524 closed tcp ports (reset)
PORT STATE SERVICE VERSION
21/tcp open ftp ProFTPD 1.3.5
| vulners: 
| cpe:/a:proftpd:proftpd:1.3.5: 
| SAINT:950EB68D408A40399926A4CCAD3CC62E	10.0	https://vulners.com/saint/SAINT:950EB68D408A40399926A4CCAD3CC62E	*EXPLOIT*
| SAINT:63FB77B9136D48259E4F0D4CDA35E957	10.0	https://vulners.com/saint/SAINT:63FB77B9136D48259E4F0D4CDA35E957	*EXPLOIT*
| SAINT:1B08F4664C428B180EEC9617B41D9A2C	10.0	https://vulners.com/saint/SAINT:1B08F4664C428B180EEC9617B41D9A2C	*EXPLOIT*
| PROFTPD_MOD_COPY	10.0	https://vulners.com/canvas/PROFTPD_MOD_COPY	*EXPLOIT*
| PACKETSTORM:162777	10.0	https://vulners.com/packetstorm/PACKETSTORM:162777	*EXPLOIT*
| PACKETSTORM:132218	10.0	https://vulners.com/packetstorm/PACKETSTORM:132218	*EXPLOIT*
| PACKETSTORM:131567	10.0	https://vulners.com/packetstorm/PACKETSTORM:131567	*EXPLOIT*
| PACKETSTORM:131555	10.0	https://vulners.com/packetstorm/PACKETSTORM:131555	*EXPLOIT*
| PACKETSTORM:131505	10.0	https://vulners.com/packetstorm/PACKETSTORM:131505	*EXPLOIT*
| MSF:EXPLOIT/UNIX/FTP/PROFTPD_MODCOPY_EXEC	10.0	https://vulners.com/metasploit/MSF:EXPLOIT/UNIX/FTP/PROFTPD_MODCOPY_EXEC	*EXPLOIT*
| EDB-ID:49908	10.0	https://vulners.com/exploitdb/EDB-ID:49908	*EXPLOIT*
| EDB-ID:37262	10.0	https://vulners.com/exploitdb/EDB-ID:37262	*EXPLOIT*
| EDB-ID:36803	10.0	https://vulners.com/exploitdb/EDB-ID:36803	*EXPLOIT*
| EDB-ID:36742	10.0	https://vulners.com/exploitdb/EDB-ID:36742	*EXPLOIT*
| CVE-2015-3306	10.0	https://vulners.com/cve/CVE-2015-3306
| 1337DAY-ID-36298	10.0	https://vulners.com/zdt/1337DAY-ID-36298	*EXPLOIT*
| 1337DAY-ID-23720	10.0	https://vulners.com/zdt/1337DAY-ID-23720	*EXPLOIT*
| 1337DAY-ID-23544	10.0	https://vulners.com/zdt/1337DAY-ID-23544	*EXPLOIT*
| SSV:61050	5.0	https://vulners.com/seebug/SSV:61050	*EXPLOIT*
| MSF:ILITIES/SUSE-CVE-2019-18217/	5.0	https://vulners.com/metasploit/MSF:ILITIES/SUSE-CVE-2019-18217/	*EXPLOIT*
| CVE-2019-19272	5.0	https://vulners.com/cve/CVE-2019-19272
| CVE-2019-19271	5.0	https://vulners.com/cve/CVE-2019-19271
| CVE-2019-19270	5.0	https://vulners.com/cve/CVE-2019-19270
| CVE-2019-18217	5.0	https://vulners.com/cve/CVE-2019-18217
| CVE-2016-3125	5.0	https://vulners.com/cve/CVE-2016-3125
| CVE-2013-4359	5.0	https://vulners.com/cve/CVE-2013-4359
|_ CVE-2017-7418	2.1	https://vulners.com/cve/CVE-2017-7418
22/tcp open ssh OpenSSH 7.2p2 Ubuntu 4ubuntu2.7 (Ubuntu Linux; protocol 2.0)
| vulners: 
| cpe:/a:openbsd:openssh:7.2p2: 
| PACKETSTORM:140070	7.8	https://vulners.com/packetstorm/PACKETSTORM:140070	*EXPLOIT*
| EXPLOITPACK:5BCA798C6BA71FAE29334297EC0B6A09	7.8	https://vulners.com/exploitpack/EXPLOITPACK:5BCA798C6BA71FAE29334297EC0B6A09	*EXPLOIT*
| EDB-ID:40888	7.8	https://vulners.com/exploitdb/EDB-ID:40888	*EXPLOIT*
| CVE-2016-8858	7.8	https://vulners.com/cve/CVE-2016-8858
| CVE-2016-6515	7.8	https://vulners.com/cve/CVE-2016-6515
| 1337DAY-ID-26494	7.8	https://vulners.com/zdt/1337DAY-ID-26494	*EXPLOIT*
| SSV:92579	7.5	https://vulners.com/seebug/SSV:92579	*EXPLOIT*
| CVE-2016-10009	7.5	https://vulners.com/cve/CVE-2016-10009
| 1337DAY-ID-26576	7.5	https://vulners.com/zdt/1337DAY-ID-26576	*EXPLOIT*
| SSV:92582	7.2	https://vulners.com/seebug/SSV:92582	*EXPLOIT*
| CVE-2016-10012	7.2	https://vulners.com/cve/CVE-2016-10012
| CVE-2015-8325	7.2	https://vulners.com/cve/CVE-2015-8325
| SSV:92580	6.9	https://vulners.com/seebug/SSV:92580	*EXPLOIT*
| CVE-2016-10010	6.9	https://vulners.com/cve/CVE-2016-10010
| 1337DAY-ID-26577	6.9	https://vulners.com/zdt/1337DAY-ID-26577	*EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/SUSE-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/SUSE-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/SUSE-CVE-2019-25017/	5.8	https://vulners.com/metasploit/MSF:ILITIES/SUSE-CVE-2019-25017/	*EXPLOIT*
| MSF:ILITIES/REDHAT_LINUX-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/REDHAT-OPENSHIFT-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/REDHAT-OPENSHIFT-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/OPENBSD-OPENSSH-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/OPENBSD-OPENSSH-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/IBM-AIX-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/IBM-AIX-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/GENTOO-LINUX-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/GENTOO-LINUX-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/F5-BIG-IP-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/F5-BIG-IP-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/DEBIAN-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/DEBIAN-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/CENTOS_LINUX-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/CENTOS_LINUX-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/AMAZON_LINUX-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/AMAZON_LINUX-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/AMAZON-LINUX-AMI-2-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/AMAZON-LINUX-AMI-2-CVE-2019-6111/	*EXPLOIT*
| MSF:ILITIES/ALPINE-LINUX-CVE-2019-6111/	5.8	https://vulners.com/metasploit/MSF:ILITIES/ALPINE-LINUX-CVE-2019-6111/	*EXPLOIT*
| EXPLOITPACK:98FE96309F9524B8C84C508837551A19	5.8	https://vulners.com/exploitpack/EXPLOITPACK:98FE96309F9524B8C84C508837551A19	*EXPLOIT*
| EXPLOITPACK:5330EA02EBDE345BFC9D6DDDD97F9E97	5.8	https://vulners.com/exploitpack/EXPLOITPACK:5330EA02EBDE345BFC9D6DDDD97F9E97	*EXPLOIT*
| EDB-ID:46516	5.8	https://vulners.com/exploitdb/EDB-ID:46516	*EXPLOIT*
| CVE-2019-6111	5.8	https://vulners.com/cve/CVE-2019-6111
| 1337DAY-ID-32328	5.8	https://vulners.com/zdt/1337DAY-ID-32328	*EXPLOIT*
| 1337DAY-ID-32009	5.8	https://vulners.com/zdt/1337DAY-ID-32009	*EXPLOIT*
| SSV:91041	5.5	https://vulners.com/seebug/SSV:91041	*EXPLOIT*
| PACKETSTORM:140019	5.5	https://vulners.com/packetstorm/PACKETSTORM:140019	*EXPLOIT*
| PACKETSTORM:136234	5.5	https://vulners.com/packetstorm/PACKETSTORM:136234	*EXPLOIT*
| EXPLOITPACK:F92411A645D85F05BDBD274FD222226F	5.5	https://vulners.com/exploitpack/EXPLOITPACK:F92411A645D85F05BDBD274FD222226F	*EXPLOIT*
| EXPLOITPACK:9F2E746846C3C623A27A441281EAD138	5.5	https://vulners.com/exploitpack/EXPLOITPACK:9F2E746846C3C623A27A441281EAD138	*EXPLOIT*
| EXPLOITPACK:1902C998CBF9154396911926B4C3B330	5.5	https://vulners.com/exploitpack/EXPLOITPACK:1902C998CBF9154396911926B4C3B330	*EXPLOIT*
| EDB-ID:40858	5.5	https://vulners.com/exploitdb/EDB-ID:40858	*EXPLOIT*
| CVE-2016-3115	5.5	https://vulners.com/cve/CVE-2016-3115
| SSH_ENUM	5.0	https://vulners.com/canvas/SSH_ENUM	*EXPLOIT*
| PACKETSTORM:150621	5.0	https://vulners.com/packetstorm/PACKETSTORM:150621	*EXPLOIT*
| MSF:AUXILIARY/SCANNER/SSH/SSH_ENUMUSERS	5.0	https://vulners.com/metasploit/MSF:AUXILIARY/SCANNER/SSH/SSH_ENUMUSERS	*EXPLOIT*
| EXPLOITPACK:F957D7E8A0CC1E23C3C649B764E13FB0	5.0	https://vulners.com/exploitpack/EXPLOITPACK:F957D7E8A0CC1E23C3C649B764E13FB0	*EXPLOIT*
| EXPLOITPACK:EBDBC5685E3276D648B4D14B75563283	5.0	https://vulners.com/exploitpack/EXPLOITPACK:EBDBC5685E3276D648B4D14B75563283	*EXPLOIT*
| EDB-ID:45939	5.0	https://vulners.com/exploitdb/EDB-ID:45939	*EXPLOIT*
| CVE-2018-15919	5.0	https://vulners.com/cve/CVE-2018-15919
| CVE-2018-15473	5.0	https://vulners.com/cve/CVE-2018-15473
| CVE-2017-15906	5.0	https://vulners.com/cve/CVE-2017-15906
| CVE-2016-10708	5.0	https://vulners.com/cve/CVE-2016-10708
| 1337DAY-ID-31730	5.0	https://vulners.com/zdt/1337DAY-ID-31730	*EXPLOIT*
| EDB-ID:45233	4.6	https://vulners.com/exploitdb/EDB-ID:45233	*EXPLOIT*
| EDB-ID:40963	4.6	https://vulners.com/exploitdb/EDB-ID:40963	*EXPLOIT*
| EDB-ID:40962	4.6	https://vulners.com/exploitdb/EDB-ID:40962	*EXPLOIT*
| CVE-2021-41617	4.4	https://vulners.com/cve/CVE-2021-41617
| MSF:ILITIES/OPENBSD-OPENSSH-CVE-2020-14145/	4.3	https://vulners.com/metasploit/MSF:ILITIES/OPENBSD-OPENSSH-CVE-2020-14145/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP9-CVE-2020-14145/	4.3	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP9-CVE-2020-14145/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2020-14145/	4.3	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2020-14145/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2020-14145/	4.3	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2020-14145/	*EXPLOIT*
| MSF:ILITIES/F5-BIG-IP-CVE-2020-14145/	4.3	https://vulners.com/metasploit/MSF:ILITIES/F5-BIG-IP-CVE-2020-14145/	*EXPLOIT*
| EXPLOITPACK:802AF3229492E147A5F09C7F2B27C6DF	4.3	https://vulners.com/exploitpack/EXPLOITPACK:802AF3229492E147A5F09C7F2B27C6DF	*EXPLOIT*
| EXPLOITPACK:5652DDAA7FE452E19AC0DC1CD97BA3EF	4.3	https://vulners.com/exploitpack/EXPLOITPACK:5652DDAA7FE452E19AC0DC1CD97BA3EF	*EXPLOIT*
| CVE-2020-14145	4.3	https://vulners.com/cve/CVE-2020-14145
| CVE-2016-6210	4.3	https://vulners.com/cve/CVE-2016-6210
| 1337DAY-ID-25440	4.3	https://vulners.com/zdt/1337DAY-ID-25440	*EXPLOIT*
| 1337DAY-ID-25438	4.3	https://vulners.com/zdt/1337DAY-ID-25438	*EXPLOIT*
| CVE-2019-6110	4.0	https://vulners.com/cve/CVE-2019-6110
| CVE-2019-6109	4.0	https://vulners.com/cve/CVE-2019-6109
| CVE-2018-20685	2.6	https://vulners.com/cve/CVE-2018-20685
| SSV:92581	2.1	https://vulners.com/seebug/SSV:92581	*EXPLOIT*
| CVE-2016-10011	2.1	https://vulners.com/cve/CVE-2016-10011
| PACKETSTORM:151227	0.0	https://vulners.com/packetstorm/PACKETSTORM:151227	*EXPLOIT*
| PACKETSTORM:140261	0.0	https://vulners.com/packetstorm/PACKETSTORM:140261	*EXPLOIT*
| PACKETSTORM:138006	0.0	https://vulners.com/packetstorm/PACKETSTORM:138006	*EXPLOIT*
| PACKETSTORM:137942	0.0	https://vulners.com/packetstorm/PACKETSTORM:137942	*EXPLOIT*
| EDB-ID:46193	0.0	https://vulners.com/exploitdb/EDB-ID:46193	*EXPLOIT*
| EDB-ID:40136	0.0	https://vulners.com/exploitdb/EDB-ID:40136	*EXPLOIT*
| EDB-ID:40113	0.0	https://vulners.com/exploitdb/EDB-ID:40113	*EXPLOIT*
| EDB-ID:39569	0.0	https://vulners.com/exploitdb/EDB-ID:39569	*EXPLOIT*
| 1337DAY-ID-30937	0.0	https://vulners.com/zdt/1337DAY-ID-30937	*EXPLOIT*
|_ 1337DAY-ID-10010	0.0	https://vulners.com/zdt/1337DAY-ID-10010	*EXPLOIT*
80/tcp open http Apache httpd 2.4.18 ((Ubuntu))
| http-enum: 
| /admin.html: Possible admin folder
|_ /robots.txt: Robots file
|_http-csrf: Couldn't find any CSRF vulnerabilities.
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
|_http-dombased-xss: Couldn't find any DOM based XSS.
| vulners: 
| cpe:/a:apache:http_server:2.4.18: 
| CVE-2021-39275	7.5	https://vulners.com/cve/CVE-2021-39275
| CVE-2021-26691	7.5	https://vulners.com/cve/CVE-2021-26691
| CVE-2017-7679	7.5	https://vulners.com/cve/CVE-2017-7679
| CVE-2017-7668	7.5	https://vulners.com/cve/CVE-2017-7668
| CVE-2017-3169	7.5	https://vulners.com/cve/CVE-2017-3169
| CVE-2017-3167	7.5	https://vulners.com/cve/CVE-2017-3167
| MSF:ILITIES/REDHAT_LINUX-CVE-2019-0211/	7.2	https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2019-0211/	*EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2019-0211/	7.2	https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2019-0211/	*EXPLOIT*
| EXPLOITPACK:44C5118F831D55FAF4259C41D8BDA0AB	7.2	https://vulners.com/exploitpack/EXPLOITPACK:44C5118F831D55FAF4259C41D8BDA0AB	*EXPLOIT*
| CVE-2019-0211	7.2	https://vulners.com/cve/CVE-2019-0211
| 1337DAY-ID-32502	7.2	https://vulners.com/zdt/1337DAY-ID-32502	*EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1312/	6.8	https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1312/	*EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/SUSE-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/SUSE-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/REDHAT_LINUX-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/ORACLE_LINUX-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/ORACLE_LINUX-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2018-1312/	6.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2018-1312/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2018-1312/	6.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2018-1312/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP1-CVE-2018-1312/	6.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP1-CVE-2018-1312/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP1-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP1-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/FREEBSD-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/FREEBSD-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/DEBIAN-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/DEBIAN-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/CENTOS_LINUX-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/CENTOS_LINUX-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/APACHE-HTTPD-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/APACHE-HTTPD-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/AMAZON_LINUX-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/AMAZON_LINUX-CVE-2017-15715/	*EXPLOIT*
| MSF:ILITIES/ALPINE-LINUX-CVE-2018-1312/	6.8	https://vulners.com/metasploit/MSF:ILITIES/ALPINE-LINUX-CVE-2018-1312/	*EXPLOIT*
| MSF:ILITIES/ALPINE-LINUX-CVE-2017-15715/	6.8	https://vulners.com/metasploit/MSF:ILITIES/ALPINE-LINUX-CVE-2017-15715/	*EXPLOIT*
| FDF3DFA1-ED74-5EE2-BF5C-BA752CA34AE8	6.8	https://vulners.com/githubexploit/FDF3DFA1-ED74-5EE2-BF5C-BA752CA34AE8	*EXPLOIT*
| CVE-2021-40438	6.8	https://vulners.com/cve/CVE-2021-40438
| CVE-2020-35452	6.8	https://vulners.com/cve/CVE-2020-35452
| CVE-2018-1312	6.8	https://vulners.com/cve/CVE-2018-1312
| CVE-2017-15715	6.8	https://vulners.com/cve/CVE-2017-15715
| 4810E2D9-AC5F-5B08-BFB3-DDAFA2F63332	6.8	https://vulners.com/githubexploit/4810E2D9-AC5F-5B08-BFB3-DDAFA2F63332	*EXPLOIT*
| CVE-2019-10082	6.4	https://vulners.com/cve/CVE-2019-10082
| CVE-2017-9788	6.4	https://vulners.com/cve/CVE-2017-9788
| MSF:ILITIES/REDHAT_LINUX-CVE-2019-0217/	6.0	https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2019-0217/	*EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2019-0217/	6.0	https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2019-0217/	*EXPLOIT*
| CVE-2019-0217	6.0	https://vulners.com/cve/CVE-2019-0217
| EDB-ID:47689	5.8	https://vulners.com/exploitdb/EDB-ID:47689	*EXPLOIT*
| CVE-2020-1927	5.8	https://vulners.com/cve/CVE-2020-1927
| CVE-2019-10098	5.8	https://vulners.com/cve/CVE-2019-10098
| 1337DAY-ID-33577	5.8	https://vulners.com/zdt/1337DAY-ID-33577	*EXPLOIT*
| CVE-2016-5387	5.1	https://vulners.com/cve/CVE-2016-5387
| SSV:96537	5.0	https://vulners.com/seebug/SSV:96537	*EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1333/	5.0	https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1333/	*EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1303/	5.0	https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1303/	*EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2017-15710/	5.0	https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2017-15710/	*EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2020-1934/	5.0	https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2020-1934/	*EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2017-15710/	5.0	https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2017-15710/	*EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2017-15710/	5.0	https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2017-15710/	*EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2016-8743/	5.0	https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2016-8743/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2017-15710/	5.0	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP3-CVE-2017-15710/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2017-15710/	5.0	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2017-15710/	*EXPLOIT*
| MSF:ILITIES/CENTOS_LINUX-CVE-2017-15710/	5.0	https://vulners.com/metasploit/MSF:ILITIES/CENTOS_LINUX-CVE-2017-15710/	*EXPLOIT*
| MSF:AUXILIARY/SCANNER/HTTP/APACHE_OPTIONSBLEED	5.0	https://vulners.com/metasploit/MSF:AUXILIARY/SCANNER/HTTP/APACHE_OPTIONSBLEED	*EXPLOIT*
| EXPLOITPACK:C8C256BE0BFF5FE1C0405CB0AA9C075D	5.0	https://vulners.com/exploitpack/EXPLOITPACK:C8C256BE0BFF5FE1C0405CB0AA9C075D	*EXPLOIT*
| EXPLOITPACK:2666FB0676B4B582D689921651A30355	5.0	https://vulners.com/exploitpack/EXPLOITPACK:2666FB0676B4B582D689921651A30355	*EXPLOIT*
| EDB-ID:40909	5.0	https://vulners.com/exploitdb/EDB-ID:40909	*EXPLOIT*
| CVE-2021-34798	5.0	https://vulners.com/cve/CVE-2021-34798
| CVE-2021-33193	5.0	https://vulners.com/cve/CVE-2021-33193
| CVE-2021-26690	5.0	https://vulners.com/cve/CVE-2021-26690
| CVE-2020-1934	5.0	https://vulners.com/cve/CVE-2020-1934
| CVE-2019-17567	5.0	https://vulners.com/cve/CVE-2019-17567
| CVE-2019-0220	5.0	https://vulners.com/cve/CVE-2019-0220
| CVE-2019-0196	5.0	https://vulners.com/cve/CVE-2019-0196
| CVE-2018-17199	5.0	https://vulners.com/cve/CVE-2018-17199
| CVE-2018-17189	5.0	https://vulners.com/cve/CVE-2018-17189
| CVE-2018-1333	5.0	https://vulners.com/cve/CVE-2018-1333
| CVE-2018-1303	5.0	https://vulners.com/cve/CVE-2018-1303
| CVE-2017-9798	5.0	https://vulners.com/cve/CVE-2017-9798
| CVE-2017-15710	5.0	https://vulners.com/cve/CVE-2017-15710
| CVE-2016-8743	5.0	https://vulners.com/cve/CVE-2016-8743
| CVE-2016-8740	5.0	https://vulners.com/cve/CVE-2016-8740
| CVE-2016-4979	5.0	https://vulners.com/cve/CVE-2016-4979
| 1337DAY-ID-28573	5.0	https://vulners.com/zdt/1337DAY-ID-28573	*EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2019-0197/	4.9	https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2019-0197/	*EXPLOIT*
| CVE-2019-0197	4.9	https://vulners.com/cve/CVE-2019-0197
| MSF:ILITIES/UBUNTU-CVE-2018-1302/	4.3	https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1302/	*EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1301/	4.3	https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1301/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2016-4975/	4.3	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2016-4975/	*EXPLOIT*
| MSF:ILITIES/DEBIAN-CVE-2019-10092/	4.3	https://vulners.com/metasploit/MSF:ILITIES/DEBIAN-CVE-2019-10092/	*EXPLOIT*
| MSF:ILITIES/APACHE-HTTPD-CVE-2020-11985/	4.3	https://vulners.com/metasploit/MSF:ILITIES/APACHE-HTTPD-CVE-2020-11985/	*EXPLOIT*
| MSF:ILITIES/APACHE-HTTPD-CVE-2019-10092/	4.3	https://vulners.com/metasploit/MSF:ILITIES/APACHE-HTTPD-CVE-2019-10092/	*EXPLOIT*
| EDB-ID:47688	4.3	https://vulners.com/exploitdb/EDB-ID:47688	*EXPLOIT*
| CVE-2020-11985	4.3	https://vulners.com/cve/CVE-2020-11985
| CVE-2019-10092	4.3	https://vulners.com/cve/CVE-2019-10092
| CVE-2018-1302	4.3	https://vulners.com/cve/CVE-2018-1302
| CVE-2018-1301	4.3	https://vulners.com/cve/CVE-2018-1301
| CVE-2018-11763	4.3	https://vulners.com/cve/CVE-2018-11763
| CVE-2016-4975	4.3	https://vulners.com/cve/CVE-2016-4975
| CVE-2016-1546	4.3	https://vulners.com/cve/CVE-2016-1546
| 4013EC74-B3C1-5D95-938A-54197A58586D	4.3	https://vulners.com/githubexploit/4013EC74-B3C1-5D95-938A-54197A58586D	*EXPLOIT*
| 1337DAY-ID-33575	4.3	https://vulners.com/zdt/1337DAY-ID-33575	*EXPLOIT*
| MSF:ILITIES/UBUNTU-CVE-2018-1283/	3.5	https://vulners.com/metasploit/MSF:ILITIES/UBUNTU-CVE-2018-1283/	*EXPLOIT*
| MSF:ILITIES/REDHAT_LINUX-CVE-2018-1283/	3.5	https://vulners.com/metasploit/MSF:ILITIES/REDHAT_LINUX-CVE-2018-1283/	*EXPLOIT*
| MSF:ILITIES/ORACLE-SOLARIS-CVE-2018-1283/	3.5	https://vulners.com/metasploit/MSF:ILITIES/ORACLE-SOLARIS-CVE-2018-1283/	*EXPLOIT*
| MSF:ILITIES/IBM-HTTP_SERVER-CVE-2018-1283/	3.5	https://vulners.com/metasploit/MSF:ILITIES/IBM-HTTP_SERVER-CVE-2018-1283/	*EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2018-1283/	3.5	https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP2-CVE-2018-1283/	*EXPLOIT*
| MSF:ILITIES/CENTOS_LINUX-CVE-2018-1283/	3.5	https://vulners.com/metasploit/MSF:ILITIES/CENTOS_LINUX-CVE-2018-1283/	*EXPLOIT*
| CVE-2018-1283	3.5	https://vulners.com/cve/CVE-2018-1283
| CVE-2016-8612	3.3	https://vulners.com/cve/CVE-2016-8612
| PACKETSTORM:152441	0.0	https://vulners.com/packetstorm/PACKETSTORM:152441	*EXPLOIT*
| EDB-ID:46676	0.0	https://vulners.com/exploitdb/EDB-ID:46676	*EXPLOIT*
| EDB-ID:42745	0.0	https://vulners.com/exploitdb/EDB-ID:42745	*EXPLOIT*
| 1337DAY-ID-663	0.0	https://vulners.com/zdt/1337DAY-ID-663	*EXPLOIT*
| 1337DAY-ID-601	0.0	https://vulners.com/zdt/1337DAY-ID-601	*EXPLOIT*
| 1337DAY-ID-4533	0.0	https://vulners.com/zdt/1337DAY-ID-4533	*EXPLOIT*
| 1337DAY-ID-3109	0.0	https://vulners.com/zdt/1337DAY-ID-3109	*EXPLOIT*
|_ 1337DAY-ID-2237	0.0	https://vulners.com/zdt/1337DAY-ID-2237	*EXPLOIT*
|_http-server-header: Apache/2.4.18 (Ubuntu)
111/tcp open rpcbind 2-4 (RPC #100000)
| rpcinfo: 
| program version port/proto service
| 100000 2,3,4 111/tcp rpcbind
| 100000 2,3,4 111/udp rpcbind
| 100000 3,4 111/tcp6 rpcbind
| 100000 3,4 111/udp6 rpcbind
| 100003 2,3,4 2049/tcp nfs
| 100003 2,3,4 2049/tcp6 nfs
| 100003 2,3,4 2049/udp nfs
| 100003 2,3,4 2049/udp6 nfs
| 100005 1,2,3 38809/tcp6 mountd
| 100005 1,2,3 57008/udp6 mountd
| 100005 1,2,3 58077/udp mountd
| 100005 1,2,3 58125/tcp mountd
| 100021 1,3,4 34207/tcp6 nlockmgr
| 100021 1,3,4 37691/tcp nlockmgr
| 100021 1,3,4 40557/udp6 nlockmgr
| 100021 1,3,4 43528/udp nlockmgr
| 100227 2,3 2049/tcp nfs_acl
| 100227 2,3 2049/tcp6 nfs_acl
| 100227 2,3 2049/udp nfs_acl
|_ 100227 2,3 2049/udp6 nfs_acl
139/tcp open netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
445/tcp open netbios-ssn Samba smbd 3.X - 4.X (workgroup: WORKGROUP)
2049/tcp open nfs_acl 2-3 (RPC #100227)
37691/tcp open nlockmgr 1-4 (RPC #100021)
37735/tcp open mountd 1-3 (RPC #100005)
46487/tcp open mountd 1-3 (RPC #100005)
58125/tcp open mountd 1-3 (RPC #100005)
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.92%E=4%D=11/5%OT=21%CT=1%CU=44559%PV=Y%DS=4%DC=T%G=Y%TM=6185FF7
OS:F%P=aarch64-unknown-linux-gnu)SEQ(SP=10A%GCD=1%ISR=10B%TI=Z%CI=I%II=I%TS
OS:=8)OPS(O1=M506ST11NW7%O2=M506ST11NW7%O3=M506NNT11NW7%O4=M506ST11NW7%O5=M
OS:506ST11NW7%O6=M506ST11)WIN(W1=68DF%W2=68DF%W3=68DF%W4=68DF%W5=68DF%W6=68
OS:DF)ECN(R=Y%DF=Y%T=40%W=6903%O=M506NNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=
OS:S+%F=AS%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q
OS:=)T5(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A
OS:%A=Z%F=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y
OS:%DF=N%T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T
OS:=40%CD=S)

Uptime guess: 0.010 days (since Fri Nov 5 21:53:12 2021)
Network Distance: 4 hops
TCP Sequence Prediction: Difficulty=266 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: Host: KENOBI; OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel

Host script results:
|_smb-vuln-ms10-061: false
| smb-vuln-regsvc-dos: 
| VULNERABLE:
| Service regsvc in Microsoft Windows systems vulnerable to denial of service
| State: VULNERABLE
| The service regsvc in Microsoft Windows 2000 systems is vulnerable to denial of service caused by a null deference
| pointer. This script will crash the service if it is vulnerable. This vulnerability was discovered by Ron Bowes
| while working on smb-enum-sessions.
|_          
|_smb-vuln-ms10-054: false

TRACEROUTE (using port 443/tcp)
HOP RTT ADDRESS
1 31.41 ms 10.13.0.1
2 ... 3
4 179.19 ms 10.10.179.107

Read data files from: /usr/bin/../share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Fri Nov 5 22:07:27 2021 -- 1 IP address (1 host up) scanned in 1058.49 seconds
```

## Enumerating Samba for Shares

Apparently port 139 is left over from Window’s NetBIOS days.

Also, apparently the smb-enum-shares.nse and smb-enum-users.nse scripts work on this machine. I wonder why they produced null results in the Basic Pentesting CTF?

```
nmap -v -oA kenobi-smb-enumeration -sT \
     --script smb-enum-shares.nse,smb-enum-users.nse \
     -p445 10.10.179.107
```

Results:

```
# Nmap 7.92 scan initiated Fri Nov 5 22:13:03 2021 as: nmap -v -oA kenobi-smb-enumeration -sT --script smb-enum-shares.nse,smb-enum-users.nse -p445 10.10.179.107
Nmap scan report for 10.10.179.107
Host is up (0.19s latency).

PORT STATE SERVICE
445/tcp open microsoft-ds

Host script results:
| smb-enum-shares: 
| account_used: guest
| \10.10.179.107\IPC$: 
| Type: STYPE_IPC_HIDDEN
| Comment: IPC Service (kenobi server (Samba, Ubuntu))
| Users: 1
| Max Users: <unlimited>
| Path: C:	mp
| Anonymous access: READ/WRITE
| Current user access: READ/WRITE
| \10.10.179.107\Anonymous: 
| Type: STYPE_DISKTREE
| Comment: 
| Users: 0
| Max Users: <unlimited>
| Path: C:\home\kenobi\share
| Anonymous access: READ/WRITE
| Current user access: READ/WRITE
| \10.10.179.107\print$: 
| Type: STYPE_DISKTREE
| Comment: Printer Drivers
| Users: 0
| Max Users: <unlimited>
| Path: C:\var\lib\samba\printers
| Anonymous access: <none>
|_ Current user access: <none>

Read data files from: /usr/bin/../share/nmap
# Nmap done at Fri Nov 5 22:13:32 2021 -- 1 IP address (1 host up) scanned in 28.92 seconds
```

I still don’t think that smb-enum-users.nse is working for me…

NFS enumeration:

```
nmap -v -oA kenobi-nfs-enumeration -sT \
     --script nfs-ls,nfs-statfs,nfs-showmount \
     -p111 10.10.179.107
```

Results:

```
# Nmap 7.92 scan initiated Fri Nov 5 22:25:45 2021 as: nmap -v -oA kenobi-nfs-enumeration -sT --script nfs-ls,nfs-statfs,nfs-showmount -p111 10.10.179.107
Nmap scan report for 10.10.179.107
Host is up (0.19s latency).

PORT STATE SERVICE
111/tcp open rpcbind
| nfs-showmount: 
|_ /var *

Read data files from: /usr/bin/../share/nmap
# Nmap done at Fri Nov 5 22:25:47 2021 -- 1 IP address (1 host up) scanned in 2.49 seconds
```

- [Basic Pentesting](https://cardboard-iguana.com/notes/tryhackme-basic-pentesting.html)
