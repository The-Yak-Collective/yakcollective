---
title: Yak Collective Members
---

# Members

Yak Collective members have contributed to one or more projects.

{% comment %}
    Display member cards for all members whose "join date" (`date`)
    is on or before now. This lets us add new member cards (for,
    say, upcoming projects) without displaying those cards until
    after the "qualifying event" has occurred.

    Member cards are randomized, per issu e #69 (closed by @tilnow).
{% endcomment %}

{% comment %}
    Build array of members.
{% endcomment %}
{% assign members = "" | split: "" %}
{% for the_page in site.pages %}
    {% assign path_array = the_page.url | replace: "/", " " | strip | split: " " %}
    {% assign path_init = path_array | first %}
    {% assign path_size = path_array | size %}
    {% if path_init == "members" and path_size == 2 %}
        {% assign members = members | push: the_page %}
    {% endif %}
{% endfor %}

{% comment %}
    Randomize member array.
{% endcomment %}
{% assign members_randomized = members | sample: members.size %}

{% comment %}
    Output members. Note that Jekyll is wonky about dates and times,
    so we just convert eveything into seconds since epoch and do our
    comparison that way.
{% endcomment %}
{% for member in members_randomized %}
    {% assign member_epoch = member.date | date: "%s" %}
    {% assign site_epoch = site.time | date: "%s" %}
    {% if member_epoch <= site_epoch or site.future == true %}
        {% include widget-member-card.html member=member %}
    {% endif %}
{% endfor %}
