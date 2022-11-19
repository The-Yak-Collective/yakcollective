---
title: Yak Collective Study Groups
---
# Study Groups

Yak Collective study groups are workshop tracks for learning varied topics of interest to Yak Collective members. Some study groups have regular (generally weekly) meetings, while others run asynchronously in the associated Discord channel.

{% assign study_groups = site.pages | where: "layout", "page-study-group"
                                    | where_exp: "study_group", "study_group.date <= site.time or site.future == true"
                                    | sort: "date"
                                    | reverse %}

{% for study_group in study_groups %}
    {% assign study_group_id = study_group.name | replace: ".md", "" | replace: ".html", "" %}
    {% include widget-study-group-box.html study_group=study_group_id %}
{% endfor %}
