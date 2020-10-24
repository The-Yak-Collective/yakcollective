---
title: Yak Collective Projects
---

# Projects

Yak Collective projects are collaborations and explorations from the community.

{% comment %}
    Build array of projects.
{% endcomment %}
{% assign projects = "" | split: "" %}
{% for the_page in site.pages %}
    {% assign path_array = the_page.url | replace: "/", " " | strip | split: " " %}
    {% assign path_size = path_array | size %}
    {% if path_array[0] == "projects" and path_size == 2 %}
        {% assign projects = projects | push: the_page %}
    {% endif %}
{% endfor %}
{% assign projects = projects | sort: "date" | reverse %}

{% comment %}
    Generate a list of all published projects and output corresponding project boxes.
{% endcomment %}
{% assign site_epoch = site.time | date: "%s" %}
{% for project in projects %}
    {% assign project_epoch = project.date | date: "%s" %}
    {% if project_epoch <= site_epoch or site.future == true %}
        {% include widget-project-box.html project=project %}
    {% endif %}
{% endfor %}
