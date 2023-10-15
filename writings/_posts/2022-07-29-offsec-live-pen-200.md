---
title: 'OffSec Live: PEN-200'
date: 2022-07-29 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-07-29-offsec-live-pen-200.html
author: 100007
---

Joining late, because of OS updates. It looks like we’re talking about SQL Injection today.

# SQL Injection (SQLi)

Remember that `#` can be used for comments in SQL, in addition to `--`.

It’s common to also test that login queries only return a single result. So sometimes you need to tack on `LIMIT 1` to achieve a login bypass. It’s worth always doing this, since adding a `LIMIT` won’t harm login bypass attempts that don’t have this check.

If you find one SQLi error in a website/application, there will probably be others!

Remember that `information_schema.tables` and `information_schema.columns` tables can be used to extract database structural information in MySQL. Of these, `information_schema.columns` is perhaps the more useful, as it contains both `table_name` and `column_name` columns (`table_schema` is the database name).

# Other Notes

In PHP, `==` checks for value equality (which may result in one of the values being tested being implicitly cast to a different data type), while `===` checks for _both_ value equality _and_ type equality (no implicit casting).

- [OffSec Live](https://www.offensive-security.com/offsec/offsec-live/)
- [Join OffSec Live](https://learn.offensive-security.com/offsec-live-webinars)
