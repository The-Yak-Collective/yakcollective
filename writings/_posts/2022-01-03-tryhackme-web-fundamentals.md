---
title: 'TryHackMe: Web Fundamentals'
date: 2022-01-03 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-03-tryhackme-web-fundamentals.html
author: 100007
---

# Introduction to Django

## Introduction

> “Additionally, Django is arguably one of the most secure developing frameworks, which in the right configuration, can strongly resist against SQL injections and XSS.”
> 
> – Swafox in the “Introduction to Django” room

That’s a hell of a statement. We shall see.

- [Swafox (TryHackMe user profile)](https://tryhackme.com/p/Swafox)
- [TryHackMe: Introduction to Django](https://tryhackme.com/room/django)

## Getting Started

Kali Linux comes with Django 3.2.10 pre-installed. I’m going to use that and hope it’s not _too_ different from 2.2.12.

## Creating a Website

Okay, one difference between Django 2.2 and 3.2 is that the import of `django.urls` in `urls.py` does _not_ pull in `include()` in 3.2. So this needs to be added manually before inserting additional `urlpattern` elements.

The app created with `python3 manage.py startapp articles` also doesn’t include a `urls.py` file (though this seems to be by design; I checked a few other tutorials, and it isn’t listed there either). This meant that I had to construct _both_ a basic `urls.py` and `views.py` file in `articles/` before `python3 manage.py migrate` could successfully set up the new app.

## CTF

This CTF involves a Django site. The target is at 10.10.219.71.

Going to http://10.10.219.71:8000/ reveals an error page stating that the target IP needs to be added to the `ALLOWED_HOSTS` array.

The provided username and password gets us into the target via SSH; we can see a Django project called `messagebox` here. Adding `10.10.219.71` to the `ALLOWED_HOSTS` array in `~/messagebox/messagebox/settings.py` resolves the initial error, though it takes a few minutes to reload.

The app now directs us to http://10.10.219.71:8000/messages/, where there’s a kind of weird stream-of-consciousness wall of text. At the bottom of this is a “Decode this message?” prompt, but clicking “Yes” results in an error dialog.

The Django admin interface at http://10.10.219.71:8000/admin/ doesn’t accept the SSH credentials.

Poking around more on the server, it turns out that the error produced by the “Decode this message?” prompt is hard-coded. Which I could probably have figured out if I looked at the page source.

- Running `strings db.sqlite3 | grep THM` reveals the first flag.

Running `sudo -l` reveals that the `django-admin` user has full superuser access. Using this, we can conduct a search of the entire filesystem for “THM” style flags.

- The second flag is in `/home/StrangerFox/user.txt`.
- The third flag is embedded as an HTML comment near the bottom of `~/meddagebox/messagebox/home.html`.
