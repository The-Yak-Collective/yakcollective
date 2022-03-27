---
---
# The Yak Collective

The Yak Collective is an online space for collaborative tinkering toward life in a post-[Weirding](https://www.theatlantic.com/technology/archive/2016/09/harambe-the-perfect-meme/498743/) world — a world where anomalous and outlier events are an every day occurance.

Here you can find an eclectic group of people working together on technology, research, writing, and art projects, and occasionally trying to make money together as well. Current experiments include: **building** open-source rovers, **crafting** experimental web infrastructures, **publishing** speculative fiction, and **studying** emerging decentralization. Learn more about us on the [About page](/about.html).

Check out our [members](/members.html) and [projects](/projects.html), read some of [our latest thoughts](/writings.html), and get in touch with any of us if you’d like to learn more.

## Featured Yak

{% assign member_id = site.data.featured_yak.field_101_raw %}
{% include widget-member-bio.html member=member_id %}

## Most Recent Project

{% assign project = site.pages | where: "layout", "page-project"
                               | where_exp: "project", "project.date <= site.time or site.future == true"
                               | sort: "date"
                               | reverse
                               | first %}
{% assign project_id = project.name | replace: ".md", "" | replace: ".html", "" %}
{% include widget-project-box.html project=project_id %}
