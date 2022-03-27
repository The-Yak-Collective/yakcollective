---
title: Yak Collective Members
---
# Members

Yak Collective members have contributed to one or more projects.

_Members: Update your profile anytime in the [Yak Member Portal](https://yak.knack.com/yaks#yak-profile/)._

{% assign members = site.data.knack_yaks.records | where: "field_102_raw", true %}

{% assign members_randomized = members | sample: members.size %}

<div class="flex flex-wrap items-stretch justify-between">
	{% for member in members_randomized %}
		{% assign member_id = member.field_101_raw %}
		{% assign member_url = "/members/" | append: member_id | append: ".html" %}
		{% assign avatar_url = member.field_44_raw.url | strip %}
		{% assign professional_name = member.field_97_raw | strip %}

		{% comment %}
			Output member card HTML.
		{% endcomment %}
		<a href="{{ member_url }}" class="dib tc lh-copy w4 ma3 pa3 ba member-box" id="{{ member_id }}">
			<img class="w3 h3 br-100 ba image-border" src="/members/{{ member_id }}.jpg" alt="{{ professional_name }}" />

			{% comment %}
				Member "professional" name. The `pseudo-link` class is
				used to make the card act a bit more like an actual
				link when in "link mode".
			{% endcomment %}
			<small class="db b pt2 pseudo-link">{{ professional_name }}</small>
		</a>
	{% endfor %}
</div>
