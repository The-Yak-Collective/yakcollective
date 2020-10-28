---
title: Yak Collective Projects
---

# Projects

Yak Collective projects are collaborations and explorations from the community.

{% comment %}
    Build array of projects. Note that Jekyll is wonky about dates and
    times, so we just convert eveything into seconds since epoch and do
    our comparison that way.
{% endcomment %}
{% assign projects = "" | split: "" %}
{% assign site_epoch = site.time | date: "%s" | plus: 0 %}
{% for the_page in site.pages %}
    {% if the_page.layout == "page-project" %}
        {% assign path_array = the_page.url | replace: "/", " " | strip | split: " " %}
        {% if path_array[0] == "projects" and path_array.size == 2 %}
            {% assign project_epoch = project.date | date: "%s" | plus: 0 %}
            {% if project_epoch <= site_epoch or site.future == true %}
                {% assign projects = projects | push: the_page %}
            {% endif %}
        {% endif %}
    {% endif %}
{% endfor %}
{% assign projects = projects | sort: "date" | reverse %}

{% comment %}
    Generate a list of all published projects and output corresponding project boxes.
{% endcomment %}
{% for project in projects %}
    {% include widget-project-box.html project=project %}
{% endfor %}
