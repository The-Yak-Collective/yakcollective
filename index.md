---
---
# The Yak Collective

The Yak Collective is an online space for collaborative tinkering. Here you can find an eclectic group of people working together on technology, research, writing, and art projects, and occasionally trying to make money together as well.

Current experiments include: **building** open-source rovers, **crafting** experimental web infrastructures, **publishing** speculative fiction, and **studying** emerging decentralization. Learn more about us on the [About page](/about.html).

Check out our [members](/members.html) and [projects](/projects.html), read some of [our latest thoughts](/writings.html), and get in touch with any of us if you’d like to learn more.

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
	Set "indie status". We bin this into ranges, calculated from the
	provided "indie start year".
{% endcomment %}
{% if site.data.featured_yak.field_36_raw %}
	{% assign current_year = site.time | date: "%Y" %}
	{% assign years_indie = current_year | minus: site.data.featured_yak.field_36_raw %}
	{% if years_indie <= 1 %}
		{% assign indie_status = "1 year" %}
	{% elsif years_indie <= 2 %}
		{% assign indie_status = "2 years" %}
	{% elsif years_indie < 5 %}
		{% assign indie_status = "3+ years" %}
	{% elsif years_indie < 10 %}
		{% assign indie_status = "5+ years" %}
	{% elsif years_indie < 15 %}
		{% assign indie_status = "10+ years" %}
	{% elsif years_indie < 20 %}
		{% assign indie_status = "15+ years" %}
	{% elsif years_indie < 30 %}
		{% assign indie_status = "20+ years" %}
	{% elsif years_indie < 40 %}
		{% assign indie_status = "30+ years" %}
	{% elsif years_indie < 50 %}
		{% assign indie_status = "40+ years" %}
	{% elsif years_indie < 75 %}
		{% assign indie_status = "50+ years" %}
	{% elsif years_indie < 100 %}
		{% assign indie_status = "75+ years" %}
	{% else %}
		{% assign indie_status = "100+ years" %}
	{% endif %}
{% else %}
	{% assign indie_status = "" %}
{% endif %}

{% comment %}
	Output featured yak info.
{% endcomment %}
<div class="flex items-top no-top-margin">
	<div class="w4 mr0 mr4-l h3-image">
		<a href="{{ member_url }}"><img class="w3 w4-l h3 h4-l br-100 ba image-border" src="/members/{{ member_id }}.jpg" alt="{{ professional_name }}"></a>
	</div>

	<div class="no-bottom-margin">
		<h3>{{ professional_name }}</h3>

		{% if tagline != empty %}
			<small class="db"><p>{{ tagline }}</p></small>
		{% endif %}

		{% if indie_status != empty or currently != empty or previously != empty %}
    			{% if indie_status != empty %}
    				<small class="db"><b>Indie status:</b> {{ indie_status }}</small>
    			{% endif %}
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

## Most Recent Project

{% assign project = site.pages | where: "layout", "page-project"
                               | where_exp: "project", "project.date <= site.time or site.future == true"
                               | sort: "date"
                               | reverse
                               | first %}
{% assign project_id = project.name | replace: ".md", "" | replace: ".html", "" %}
{% include widget-project-box.html project=project_id %}
