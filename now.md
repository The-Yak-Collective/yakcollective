---
title: What is the Yak Collective working on now?
---
# Now

Interested in what we're working on [now](https://nownownow.com/about)? Well, you've come to the right place!

## Upcoming Projects

Yak Collective projects are collaborations and explorations from the community.

{% assign projects = site.pages | where: "layout", "page-project"
                                | where_exp: "project", "project.date > site.time"
                                | sort: "date" %}

{% for project in projects %}
    {% include widget-project-box.html project=project %}
{% endfor %}

## Get Involved

Interested in getting involved? [Join us!](/join/)
