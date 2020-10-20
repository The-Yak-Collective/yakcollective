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
{% assign members_randomized = site.members | sample: site.members.size %}
{% for member in members_randomized %}
    {% if member.date <= site.time or site.future == true %}
        {% include widget-member-card.html member=member %}
    {% endif %}
{% endfor %}
