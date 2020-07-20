---
layout: minimal
title: The Yak Collective
---

# The Yak Collective

The Yak Collective is a network of over 300 independent consultants, coaches, and freelancers with varied technical and creative skills. You can learn more about us on the [About page](/about). We are available both for individual projects on specific topics that match our skills, and for larger collaborative projects we can take on as a group, bringing together the mix of skills necessary. Check out our [Members page](/members), read some of our latest thoughts on the [Writings page](/writings), and get in touch with any of us if you'd like to learn more.

Our second report, [_The New Old Home_](/projects/the-new-old-home), is now available. Check it out! We will be releasing more research on the [Projects page](/projects) in the coming months.

Follow us on [Twitter](https://twitter.com/yak_collective), [Facebook](https://www.facebook.com/theyakcollective/), or [LinkedIn](https://www.linkedin.com/company/yak-collective/) to stay in the loop.

	{% assign num_slogans = site.data.slogans.slogans | size %}
	{% assign which_one = "now" | date: "%N" | modulo: num_slogans %}
	{% assign the_one = site.data.slogans.slogans[which_one].slogan %}
<small class="f6 db tc mt3 w-75 w-100-l center"><a href="/tips" class="dib tl" id="featured_yak">{{ site.collections[0] }} _and_ {{ site.collections[0] |size }} __and__ {{ site.collections[0][3] }} </a></small>
<script>
	var footer_slogans = {{ site.data.slogans | jsonify }};
	var footer_slogans_total = (footer_slogans.slogans).length;
	var footer_slogan_to_show = Math.floor(Math.random() * footer_slogans_total);
	//document.getElementById("featured_yak").innerHTML = footer_slogans.slogans[footer_slogan_to_show].slogan;
</script>
Featured Yak: 
