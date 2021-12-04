---
---
# The Yak Collective

**Join us for our second Annual Meeting on Tuesday, December 14th, 1500-2000 UTC (7AM-12PM US Pacific)! Learn about what we've been up to through 2021, what we have in the works for 2022, and scope out activities you might want to join. <a href="https://www.eventbrite.com/e/yak-collective-annual-meeting-2021-tickets-210108709807">Register here</a> (the event is virtual and free, but space is limited).**

The Yak Collective is an online space for collaborative tinkering toward life in a post-[Weirding](https://www.theatlantic.com/technology/archive/2016/09/harambe-the-perfect-meme/498743/) world — a world where anomalous and outlier events are an every day occurance.

Here you can find an eclectic group of people working together on technology, research, writing, and art projects, and occasionally trying to make money together as well. Current experiments include: **building** open-source rovers, **crafting** experimental web infrastructures, **publishing** speculative fiction, and **studying** emerging decentralization. Learn more about us on the [About page](/about/).

Check out our [members](/members/) and [projects](/projects/), read some of [our latest thoughts](/writings/), and get in touch with any of us if you’d like to learn more.

## Featured Yak

{% assign member_id = site.data.featured_yak.field_101_raw %}
{% include widget-member-card.html member=member_id %}

## Most Recent Project

{% assign project = site.pages | where: "layout", "page-project"
                               | where_exp: "project", "project.date <= site.time or site.future == true"
                               | sort: "date"
                               | reverse
                               | first %}
{% assign project_id = project.name | replace: ".md", "" | replace: ".html", "" %}
{% include widget-project-box.html project=project_id %}
