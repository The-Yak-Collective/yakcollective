---
---
# The Yak Collective

<a href="yakcon2023.html" style="opacity: 1;"><img src="img/yakcon2023.webp" alt="YakCon 2023" style="border-radius: 10pt;"></a>

<a href="https://lu.ma/event/evt-X4vzgzOFPUEUy7u" class="luma-checkout--button" data-luma-action="checkout" data-luma-event-id="evt-X4vzgzOFPUEUy7u" style="text-decoration: none;">Register now!</a>

<script id="luma-checkout" src="https://embed.lu.ma/checkout-button.js"></script>

The Yak Collective is an online space for collaborative tinkering. Here you can find an eclectic group of people working together on technology, research, writing, and art projects, and occasionally trying to make money together as well.

Current experiments include: **building** open-source rovers, **crafting** experimental web infrastructures, **publishing** speculative fiction, and **studying** emerging decentralization. Learn more about us on the [About page](/about.html).

Check out our [members](/members.html) and [projects](/projects.html), read some of [our latest thoughts](/writings.html), and get in touch with any of us if you’d like to learn more.

<!--

## Featured Yak

{% comment %}
	Pull in relevant member information from page properties.
{% endcomment %}
{% assign member_id = site.data.featured_yak.field_101_raw %}
{% assign member_url = "/members/" | append: member_id | append: ".html" %}
{% assign professional_name = site.data.featured_yak.field_97_raw | strip %}
{% assign tagline = site.data.featured_yak.field_41_raw | strip %}
{% assign currently = site.data.featured_yak.field_23_raw | strip %}
{% assign previously = site.data.featured_yak.field_42_raw | strip %}

{% comment %}
	Output featured yak info.
{% endcomment %}
<div class="mt3 mb3 flex items-top no-top-margin">
	<div class="w3 w4-l mr3 mr4-l h3-image">
		<a href="{{ member_url }}"><img class="w3 w4-l h3 h4-l br-100 ba image-border" src="/members/{{ member_id }}.jpg" alt="{{ professional_name }}"></a>
	</div>

	<div class="no-bottom-margin">
		<h3>{{ professional_name }}</h3>

		{% if tagline != empty %}
			<small class="db"><p>{{ tagline }}</p></small>
		{% endif %}

		{% if currently != empty or previously != empty %}
    			{% if currently != empty %}
    				<small class="db"><b>Currently:</b> {{ currently }}</small>
    			{% endif %}
    			{% if previously != empty %}
    				<small class="db"><b>Previously:</b> {{ previously }}</small>
    			{% endif %}
		{% endif %}

        <small class="db"><p><a href="{{ member_url }}">Learn more&hellip;</a></p></small>
	</div>
</div>

-->

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
