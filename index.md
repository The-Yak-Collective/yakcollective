---
layout: minimal
title: The Yak Collective
---

# The Yak Collective

The Yak Collective is a network of over 300 independent consultants, coaches, and freelancers with varied technical and creative skills. You can learn more about us on the [About page](/about). We are available both for individual projects on specific topics that match our skills, and for larger collaborative projects we can take on as a group, bringing together the mix of skills necessary. Check out our [Members page](/members), read some of our latest thoughts on the [Writings page](/writings), and get in touch with any of us if you'd like to learn more.

Our second report, [_The New Old Home_](/projects/the-new-old-home), is now available. Check it out! We will be releasing more research on the [Projects page](/projects) in the coming months.

Follow us on [Twitter](https://twitter.com/yak_collective), [Facebook](https://www.facebook.com/theyakcollective/), or [LinkedIn](https://www.linkedin.com/company/yak-collective/) to stay in the loop.

<a href="{{the_one.url}}" class="dib tl" id="featured_yak"><small class="f6 db tc mt3 w-75 w-100-l center">Featured Yak:</small></a>
{% assign num_members = site.members | size %}
{% assign random_member = site.time | date: "%Y%m%d" | modulo: num_members %}
{% assign member = site.members[random_member] %}
{% include member-card.html %}
