---
title: Yak Collective Projects
---

# Projects

Yak Collective projects are collaborations and explorations from the community.

{% comment %}
    Build array of projects.
{% endcomment %}
{% assign projects = "" | split: "" %}
{% assign site_epoch = site.time | date: "%s" %}
{% for the_page in site.projects %}
    {% assign project_epoch = the_page.date | date: "%s" %}
    {% if project_epoch <= site_epoch or site.future == true %}
        {% assign projects = projects | push: the_page %}
    {% endif %}
{% endfor %}
{% assign projects = projects | sort: "date" | reverse %}

{% comment %}
    Generate a list of all published projects and output corresponding project boxes.
{% endcomment %}
{% for project in projects %}
    {% include widget-project-box.html project=project %}
{% endfor %}
