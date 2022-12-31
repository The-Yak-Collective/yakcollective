---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-03 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-03-tryhackme-complete-beginner.html
author: 100007
---

# Network Services

## Understanding NFS

NFS is part of the large family of local and network protocols that can be classified as “remote procedure calls” (RPCs).

NFS file calls always include:

- The file handle (unique ID, also applies to directories)
- The file name
- The connecting user ID
- The connecting group ID

Access checks are made on both the initial mount (does this user have permission to mount this share?) and on file access (does this user have permission to access this file?).

Windows actually does support NFS.

- [Remote procedure call (Wikipedia)](https://en.wikipedia.org/wiki/Remote_procedure_call)

## Enumerating NFS

```
# List NFS shares.
#
showmount -e $SERVER_IP

# Mount an NFS share.
#
mount -t nfs ${SERVER_IP}:${SHARE_PATH} \
	$LOCAL_MOUNT_DIR -nolock
```

All versions of NFS use port 2049 to transfer data; NFSv1 - NFSv3 also depended on the “portmapper” service running on port 111, but this requirement was removed in NFSv4.

- [What is NFS port number in Linux?](https://racinpaper.com/auto-racing/what-is-nfs-port-number-in-linux.html)

## Exploiting NFS

By default NFS shares have “root squashing” turned on - attempts to connect as root are assigned to the least-privileged user nfsnobody. But if this is turned off, then it’s possible to set the SUID bit on a file.

NOTE: I don’t see any way to identify that root squashing is disabled from the NMAP scan, so I think we’re just having to take it on faith that it is here. Either that, or this is just one of those “throw spaghetti against the wall and see what happens” times that I’ve run into before in online training CTFs (_cough_ Bandit _cough_).

So the idea here is:

- Gain access to the user’s home directory via NFS.
- Get their SSH key.
- Log in as the user over SSH.
- Copy the system bash executable to their home directory (`cp $(which bash) ~/.bash`).
- Use your _system_ tools to change the owner of the copied executable to root and set the SUID bit (`sudo chown root.root $LOCAL_MOUNT_DIR/cappucino/.bash && sudo chmow +s $LOCAL_MOUNT_DIR/cappucino/.bash`). The magic of NFS will translate the operation as root on our local machine to an operation as root on the remote machine (assuming that root squashing is disabled, which it is in the TryHackMe demo).
- Run the SUID bash executable (in the SSH session) using to become root (`~/.bash -p`).
- Profit!

The -p flag tells bash to not drop privileges (otherwise we won’t _actually_ get a root shell).

Note that this is a little bit different than the procedure outlined in the actual TryHackMe “room”, in that I’m copying the system executable rather than downloading a compatible executable from some random GitHub repo. Seems better to live off the land, no?

Sometimes you need to unmount an unresponsive NFS share (for example, if you let a TryHackMe box expire while you still have an active mount). Use umount’s -f flag to force the unmount in this situation.

- [OverTheWire: Bandit](https://cardboard-iguana.com/notes/overthewire-bandit.html)

## Enumerating SMTP

SMTP user enumeration uses a combination of the VRFY (verify user/list), EXPN (expand user/list aliases), and RCPT TO (receipt destination).

Instead of (just) using nmap this time, we’re going to layer in the Metasploit smtp\_version and smtp\_enum modules!

Basic Metasploit flow:

- `use $MODULE_NAME`
- `set $OPTIONS`
- `run`

## Exploiting SMTP

Now we’re going to use Hydra to try to brute-force an SSH password. This looks a lot like using Hydra to brute-force an FTP password.

```
hydra -t 4 -l $USER_NAME -P $WORDLIST \
	-vV $TARGET_IP_ADDRESS ssh
```

The -t flag specifies the number of threads (parallel connection attempts) that Hydra should make at any one time.

- [2021-10-02 - TryHackMe: Complete Beginner](https://cardboard-iguana.com/log/2021-10-02-tryhackme-complete-beginner.html)

## Understanding MySQL

Interesting. According to TryHackMe (and a quick search seems to confirm), Facebook uses MySQL as its backend.

## Enumerating MySQL

The Metasploit package for “enumerating” MySQL data is mysql\_sql, but this looks like it’s just a thin wrapper around the mysql client.

## Exploiting MySQL

In PL/SQL, “schema” represents only those parts of a database that are owned (writable?) by a particular user.

The output of the mysql\_hashdump Metasploit module is username:password tuples that are suitable for pushing straight into John the Ripper (simply save one or more hashes to a file and then run `john $FILE`).

That said, basically this was all the same as running:

```
SELECT Host,
       User,
       authentication_string, 
       password_expired,
       account_locked
FROM mysql.user\G
```

NOTE: John the Ripper records cracked hash:password tuples in ~/.john/john.pot, and then references this file to avoid cracking known hashes. It _doesn’t_ output these passwords again (instead simply declaring “[n]o password hashes left to crack”), so if you get no output then you’ll want to just grep for your hash in john.pot.

# Web Fundamentals

## How Do We Load Websites?

Different request types in HTTP are called “verbs”.

## More HTTP: Verbs and Request Formats

HTTP “verbs” are also called “methods”, which is a term I’m more familiar with. There are 9 total methods, but the most common are GET (retrieve data) and POST (send data).

All HTTP requests begin with a line of the form `$METHOD $SERVER_PATH $OPTIONAL_PROTOCOL VERSION` (for example, `GET /index.html HTTP/1.1`). Request bodies are permitted for all methods, but are normally ignored for GET (really only the headers matter for GET).

HTTP responses start out with the line `$PROTOCOL_VERSION $RESPONSE_CODE $OPTIONAL_SERVER_DEFINED_MESSAGE` (for example, `HTTP/1.1 200 OK`).

HTTP response codes:

- 100 - 199 - Informational response (uncommon)
- 200 - 299 - Success
- 300 - 399 - Redirects
- 400 - 499 - Client errors (problems with the request content)
- 500 - 599 - Server errors (problems with processing the request)

Note that the server-defined message cannot include any line breaks.

- [HTTP response status codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)

## Mini CTF

Useful cURL flags:

- `-v` - show full transaction, including headers (not just response bodies).
- `--data "$DATA"` - send $DATA as the request body.
- `--cookie "${COOKIE_NAME}=${COOKIE_VALUE}"` - send a cookie.
