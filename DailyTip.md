---
layout: minimal
title: Daily Tip from 100 Consulting Tips of [Art of Gig](https://artofgig.substack.com/)
---

    {% assign num_tips = site.data.artofgig100tips | size %}
    {% assign which_one = "now" | date: "%N" | divided_by: 100 | modulo: num_tips %}
    {% assign theone = site.data.artofgig100tips[which_one].tip %}
    {% assign thewords = site.data.artofgig100tips[which_one].thewords %}


# {{ theone }} #{{ which_one | plus: 1}} 

{{ thewords }}