---
title: Yak Collective Members
---
# Members

Yak Collective members have contributed to one or more projects.

_Members: Update your profile anytime in the [Yak Member Portal](https://yak.knack.com/yaks#yak-profile/)._

{% assign members = site.data.knack_yaks.records | where: "field_102_raw", true %}

{% assign members_randomized = members | sample: members.size %}

{% for member in members_randomized %}
{% assign member_id = member.field_101_raw %}
<div class="mv4">{% include widget-member-card.html member=member_id %}</div>
{% endfor %}
