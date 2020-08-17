---
layout: null-layout
---

{% comment %}
	Insert a random slogan AGAIN. This time, we do it in JavaScript on
	page load. This ensures that every page reload gets a new slogan in
	the footer.

	We break this off as its own file to allow browsers to just pull it
	from cache, rather than appending the entire `slogans` data
	structure to every page.
{% endcomment %}

<script>
	var footer_slogans = {{ site.data.slogans | jsonify }};
	var footer_slogans_total = (footer_slogans.slogans).length;
	var footer_slogan_to_show = Math.floor(Math.random() * footer_slogans_total);
	document.getElementById("footer-slogan").innerHTML = footer_slogans.slogans[footer_slogan_to_show].slogan;
</script>
