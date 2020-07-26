---
name: alex-dobrenko
title: Alex Dobrenko
date: 2020-04-30
indie_status: 5+ years
tagline: Improviser / Writer / Filmmaker
twitter: Dobrenkz
previously: Distance / UCB / Funny or Die
avatar: /assets/img/alex-dobrenko.jpg
links:
  - title: alexdobrenko.com
    url: https://alexdobrenko.com/
---
#below the line
{% assign nummembers = site.members | size %}
{% assign featuredone= site.data.featured | modulo: nummembers %} 
{{featuredone}}  and {{site.members[featuredone].name}}
