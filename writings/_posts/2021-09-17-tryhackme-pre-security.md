---
title: 'TryHackMe: Pre Security'
date: 2021-09-17 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2021-09-17-tryhackme-pre-security.html
author: 100007
---

# The File System

NTFS stands for the “New Technology File System”. _Very_ old versions of Windows NT (_before_ FAT32) used HPFS (the “High Performance File System”).

NTFS actually natively supports file-level encryption via EFS (“Encryption File System”).

NTFS is actually a forking file system like HFS. Microsoft calls these forks “alternate data streams” (ADS), and there is always at least one stream (called $DATA) that holds the actual file contents. (ADS is, for example, used to store the “mark of the web”.) While the File Explorer doesn’t display ADS stream information, it can be accessed from Powershell.

Windows permissions for folders:

- Read - Permits viewing and listing of files and subfolders
- Write - Permits adding of files and subfolders
- Read & Execute - Permits viewing and listing of files and subfolders as well as executing of files; inherited by files and folders
- List Folder Contents - Permits viewing and listing of files and subfolders as well as executing of files; inherited by folders only
- Modify - Permits reading and writing of files and subfolders; allows deletion of the folder
- Full Control - Permits reading, writing, changing, and deleting of files and subfolders

Windows permissions for files:

- Read - Permits viewing or accessing of the file’s contents
- Write - Permits writing to a file
- Read & Execute - Permits viewing and accessing of the file’s contents as well as executing of the file
- List Folder Contents - N/A
- Modify - Permits reading and writing of the file; allows deletion of the file
- Full Control - Permits reading, writing, changing and deleting of the file

Windows access is default-deny.

# The Windows/System32 Folder

Variable that stores the path to the (“central”) Windows installation directory: %WINDIR%.

# User Accounts, Profiles, and Permissions

“Profiles” are the Windows equivalent of UNIX home directories. Profile directories aren’t created on Windows until a user’s first login.

Windows users and groups can be more directly manipulated through the “Local User and Group Management” snap-in, lusrmgr.msc.

# User Account Control

a.k.a “UAC”

# Task Manager

Task Manager shortcut: Ctrl+Shift+Esc

