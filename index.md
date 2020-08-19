---
layout: minimal
title: The Yak Collective
---

# The Yak Collective

The Yak Collective is a network of over 300 independent consultants, coaches, and freelancers with varied technical and creative skills. You can learn more about us on the [About page](/about). We are available both for individual projects on specific topics that match our skills, and for larger collaborative projects we can take on as a group, bringing together the mix of skills necessary. Check out our [Members page](/members), read some of our latest thoughts on the [Writings page](/writings), and get in touch with any of us if you'd like to learn more.

Our second report, [_The New Old Home_](/projects/the-new-old-home), is now available. Check it out! We will be releasing more research on the [Projects page](/projects) in the coming months.

Follow us on [Twitter](https://twitter.com/yak_collective), [Facebook](https://www.facebook.com/theyakcollective/), or [LinkedIn](https://www.linkedin.com/company/yak-collective/) to stay in the loop.

## Featured Yak

{% comment %}
	Pick a single, random-ish "featured" member and include their
	member card in "link mode".

	Rather than *actually* picking a random member from the
	`site.members` array using the `sample` filter, we instead generate
	a random-ish member by taking today's date in YYYYMMDD format modulo
	the number of current members. We then use this number to pick a
	member from an array composed *only* of current members.

	This process ensures that (1) the "random" featured member is
	actually static for all builds of the site on a given day (necessary
	to ensure that we don't get multiple "featured member" posts on the
	Twitter feed) and (2) we don't accidentally pick a member whose page
	isn't yet live on the site.

	The first three Liquid directives that follow are identical to those
	in `featured.xml`, and the fourth directive is a close analog to the
	final one there. Best practice would be to abstract this, but the
	only way to do this would be via a Jekyll plugin, which seems *way*
	too heavy a solution for such a limited use-case.
{% endcomment %}
{% assign current_members = site.members | where_exp: "member", "member.date <= site.time" %}
{% assign num_members = current_members | size %}
{% assign random_member = site.time | date: "%Y%m%d" | modulo: num_members %}
{% assign member = current_members[random_member] %}
{% include member-card.html is_link=true member=member %}
