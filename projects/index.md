---
layout: page
title: Projects
---

Yak Collective projects are collaborations across the community.

Latest projects & reports:

{% assign projects = site.static_files | where_exp: "item" , "item.path contains projects" %}

<ul>
{% for project in projects %}
<li><a href="{{project.url}}">{{project.title}}</a></li>
{% endfor %}
</ui>

