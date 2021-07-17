---
title: What is the Yak Collective working on now?
draft: true
---
# Now

Interested in what we're working on [now](https://nownownow.com/about)? Well, you've come to the right place!

{% assign projects = site.pages | where: "layout", "page-project"
                                | where_exp: "project", "project.date > site.time"
                                | sort: "date" %}
{% if projects.size > 0 %}
## Upcoming Projects

Yak Collective projects are collaborations and explorations from the community.

    {% for project in projects %}
        {% assign project_id = project.name | replace: ".md", "" | replace: ".html", "" %}
        {% include widget-project-box.html project=project_id hide_published=true %}
    {% endfor %}
{% endif %}

## Get Involved

Interested in getting involved? [Join us!](/join/)
