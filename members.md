---
title: Yak Collective Members
---
# Members

Yak Collective members have contributed to one or more projects.

Members: Update your profile anytime in the [Yak Member Portal](https://yak.knack.com/yaks#yak-profile/).

{% assign members = site.pages | where: "layout", "page-member"
                               | where_exp: "member", "member.date <= site.time or site.future == true" %}

{% assign members_randomized = members | sample: members.size %}

{% for member in members_randomized %}
{% assign member_id = member.name | replace: ".md", "" | replace: ".html", "" %}
<div class="mv4">{% include widget-member-card.html member=member_id %}</div>
{% endfor %}
