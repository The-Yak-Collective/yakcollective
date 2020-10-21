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

var members = {
	{% assign last_member = members.last %}
	{% for member in members %}
		{% assign member_id = member.name | split: "." | first %}
		"{{ member_id }}": "{{ member.title }}"{% if member.name != last_member.name %},{% endif %}
	{% endfor %} };
var tips = {{ site.data.tips | jsonify }};
var tips_total = tips.length;
var tip_to_show = Math.floor(Math.random() * tips_total);
var tip_num = tip_to_show + 1;

document.getElementById("yak-collective-consulting-tip-number").innerHTML = "Yak Collective Consulting Tip #" + tip_num;
document.getElementById("yak-collective-consulting-tip").innerHTML = tips[tip_to_show].tip;
document.getElementById("yak-collective-consulting-tip-author").href = "/members/" + tips[tip_to_show].author + "/";
document.getElementById("yak-collective-consulting-tip-author").innerHTML = members[tips[tip_to_show].author];
