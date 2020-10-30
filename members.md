---
title: Yak Collective Members
---
# Members

Yak Collective members have contributed to one or more projects.

{% assign members = site.pages | where: "layout", "page-member"
                               | where_exp: "member", "member.date <= site.time or site.future == true" %}

{% assign members_randomized = members | sample: members.size %}

{% for member in members_randomized %}
    {% include widget-member-card.html member=member %}
{% endfor %}
