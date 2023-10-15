---
---
# The Yak Collective

The Yak Collective is an online space for collaborative tinkering. Here you can find an eclectic group of people working together on technology, research, writing, and art projects, and occasionally trying to make money together as well.

Current experiments include: **building** open-source rovers, **crafting** experimental web infrastructures, **publishing** speculative fiction, and **studying** emerging decentralization. Learn more about us on the [About page](/about.html).

Check out our [members](/members.html) and [projects](/projects.html), read some of [our latest thoughts](/writings.html), and get in touch with any of us if you’d like to learn more.

## Active Study Groups

{% assign study_groups = site.pages | where: "layout", "page-study-group"
                                    | where: "ended", false
                                    | where_exp: "study_group", "study_group.date <= site.time or site.future == true"
                                    | sort: "date"
                                    | reverse %}

{% for study_group in study_groups %}
    {% assign study_group_id = study_group.name | replace: ".md", "" | replace: ".html", "" %}
    {% include widget-study-group-box.html study_group=study_group_id %}
{% endfor %}

## Most Recent Project

{% assign project = site.pages | where: "layout", "page-project"
                               | where_exp: "project", "project.date <= site.time or site.future == true"
                               | sort: "date"
                               | reverse
                               | first %}
{% assign project_id = project.name | replace: ".md", "" | replace: ".html", "" %}
{% include widget-project-box.html project=project_id %}
