---
title: Yak Collective Projects
---

# Projects

Yak Collective projects are collaborations and explorations from the community.

{% comment %}
    Generate a list of all published projects and output corresponding project boxes.
{% endcomment %}
{% assign projects = site.projects | where_exp: "project", "project.date <= site.time or site.future == true" | reverse %}
{% for project in projects %}
    {% include widget-project-box.html project=project %}
{% endfor %}
