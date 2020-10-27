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
{% endcomment %}

{% comment %}
    Build array of current members. Note that Jekyll is wonky about
    dates and times, so we just convert eveything into seconds since
    epoch and do our comparison that way.
{% endcomment %}
{% assign members = "" | split: "" %}
{% assign site_epoch = site.time | date: "%s" | plus: 0 %}
{% for the_page in site.pages %}
    {% if the_page.layout == "member" %}
        {% assign path_array = the_page.url | replace: "/", " " | strip | split: " " %}
        {% if path_array[0] == "members" and path_array.size == 2 %}
            {% assign member_epoch = member.date | date: "%s" | plus: 0 %}
            {% if member_epoch <= site_epoch or site.future == true %}
                {% assign members = members | push: the_page %}
            {% endif %}
        {% endif %}
    {% endif %}
{% endfor %}

{% comment %}
    Randomize member array, per issue #69 (closed by @tilnow).
{% endcomment %}
{% assign members_randomized = members | sample: members.size %}

{% comment %}
    Output members.
{% endcomment %}
{% for member in members_randomized %}
    {% include widget-member-card.html member=member %}
{% endfor %}
