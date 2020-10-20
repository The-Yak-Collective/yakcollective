---
layout: none
---

{% comment %}
	JavaScript for the "tips" easter egg page. Pull a random tip, look
	up its author, and display both.

	We break this off as its own file to allow browsers to just pull it
	from cache (and so that we can `defer` it and improve page load
	performance), rather than appending the entire `tips` data
	structure to the "tips" page.
{% endcomment %}

{% assign last_member = site.members.last %}

var members = { {% for member in site.members %}"{{ member.name }}":"{{ member.title }}"{% if member.name != last_member.name %},{% endif %}{% endfor %} };
var tips = {{ site.data.tips | jsonify }};
var tips_total = tips.length;
var tip_to_show = Math.floor(Math.random() * tips_total);
var tip_num = tip_to_show + 1;

document.getElementById("yak-collective-consulting-tip-number").innerHTML = "Yak Collective Consulting Tip #" + tip_num;
document.getElementById("yak-collective-consulting-tip").innerHTML = tips[tip_to_show].tip;
document.getElementById("yak-collective-consulting-tip-author").href = "/members/" + tips[tip_to_show].author;
document.getElementById("yak-collective-consulting-tip-author").innerHTML = members[tips[tip_to_show].author];
