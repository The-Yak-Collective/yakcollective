---
title: 'TryHackMe: Web Fundamentals'
date: 2022-01-09 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-01-09-tryhackme-web-fundamentals.html
author: 100007
---

# Burp Suite: Repeater

## Basic Usage

More handy keyboard shortcuts:

- `Ctrl + R` – Send request to Repeater (from Proxy)

## Views

The ` ` button in the Repeater Request and Response views toggles non-printable characters (not just line endings).

## SQLi with Repeater

A handy MySQL function is `group_concat()`, which concatenates all values of a particular column in a `GROUP BY` statement (or all values period if there’s no `GROUP BY`). When applied to `information_schema.columns WHERE table_name="target_table"`, this lets us quickly pull all of the column names for the target table.

# Burp Suite: Intruder

## What is Intruder?

More handy keyboard shortcuts:

- `Ctrl + I` – Send request to Repeater (from Proxy)

Note that Intruder is configured tab-by-tab, rather than Repeater which is pane-based.

## Sniper

Sniper takes a _single_ word list and inserts each element into each defined position, one element and one position at a time.

For example, assume a three-element word list containing `one`, `two`, and `three`, and the body date `foo=position1&bar=position2`. Then if `position1` and `position2` are both defined as positions, Sniper will produce the following sequence of attempts:

- `foo=one&bar=position2`
- `foo=two&bar=position2`
- `foo=three&bar=position2`
- `foo=position1&bar=one`
- `foo=position1&bar=two`
- `foo=position1&bar=three`

Sniper is most useful when attacking a _single_ position, however.

## Battering Ram

Battering Ram again takes a _single_ word list, but then inserts the _same_ payload into _every_ position on each run.

For example, assume a three-element word list containing `one`, `two`, and `three`, and the body date `foo=position1&bar=position2`. Then if `position1` and `position2` are both defined as positions, Battering Ram will produce the following sequence of attempts:

- `foo=one&bar=one`
- `foo=two&bar=two`
- `foo=three&bar=three`

It’s a little mysterious to me why this attack is useful.

## Pitchfork

Pitchfork takes _one word list per position_, and then iterates through them in sequence (thus all word lists need to be the same length; if the lists are of different lengths, then Pitchfork will stop upon reaching the end of the _shortest_ list).

For example, assume one three-element word list containing `one`, `two`, and `three`, a second three-element word list containing `alpha`, `beta`, and `gamma`, and the body date `foo=position1&bar=position2`. Then if `position1` and `position2` are both defined as positions, Pitchfork will produce the following sequence of attempts:

- `foo=one&bar=alpha`
- `foo=two&bar=beta`
- `foo=three&bar=gamma`

This is generally the approach that would be used in order to test against a potential list of username/password tuples.

## Cluster Bomb

Cluster Bomb takes _one word list per position_, and then tests every possible combination in sequence.

For example, assume one three-element word list containing `one`, `two`, and `three`, a second three-element word list containing `alpha`, `beta`, and `gamma`, and the body date `foo=position1&bar=position2`. Then if `position1` and `position2` are both defined as positions, Cluster Bomb will produce the following sequence of attempts:

- `foo=one&bar=alpha`
- `foo=one&bar=beta`
- `foo=one&bar=gamma`
- `foo=two&bar=alpha`
- `foo=two&bar=beta`
- `foo=two&bar=gamma`
- `foo=three&bar=alpha`
- `foo=three&bar=beta`
- `foo=three&bar=gamma`

This is a good approach for attacking login forms if you _don’t_ already know the actual credentials, but want to fuzz using some set of likely values (like `rockyou.txt`).

Obviously this is the most expensive attack in terms of connections/time, and thus also the one most likely to get you noticed!

## Challenge

IDOR (Insecure Direct Object Reference) happens when user permissions aren’t checked when accessing data. This means that if you can guess how a particular piece of data is referenced, you can access it even if you don’t have “permission” to view it.

## CSRF Token Bypass

When dealing with forms that include session cookies or anti-CSRF tokens, we can either grab these tokens directly in Intruder using the Recursive Grep function (_not_ covered in this section), or construct a macro in Project options \> Sessions \> Macros (necessary if there’s, for example, a random redirect to make our life harder).

Basically, macros just define repeated requests that we can make. Once a request is defined here, we can add an entry in Session Handling Rules and define the Scope of the macro (the tools it’s active in and the URL it applies to). Then in details we can trigger the macro. Generally you’ll want to restrict the URLs the macro applies to and what parameters/cookies get updated by the macro as much as possible.

