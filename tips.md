---
title: Yak Collective Consulting Tip
---

{% comment %}
    "Tips" easter egg page. Pull a random tip, look up its author, and
    display both.

    Like the footer slogans, we generate tips twice -- once at build
    time, and again on page load using JavaScript. This lets the "tip"
    experience gracefully degrade for users and devices without
    JavaScript enabled.

    Note that we can't use `sample` here, because we need to know the
    array index we're pulling to generate the tip number (`the_one`).
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

{% comment %}
    Figure out the tip we want. Note that we can't use `sample` here,
    since we need an actual tip number, and Liquid doesn't give us an
    easy way to determine what index we extracted from our array with
    that method.
{% endcomment %}
{% assign the_one = site.time | date: "%s" | modulo: site.data.tips.size %}
{% assign the_tip = site.data.tips[the_one] %}
{% assign the_author_file = the_tip.author | append: ".md" %}
{% assign the_author = members | where: "name", the_author_file | first %}
{% assign the_words = the_tip.tip %}

# Yak Collective Consulting Tip #{{ the_one | plus: 1 }}
{: #yak-collective-consulting-tip-number}

<span id="yak-collective-consulting-tip">{{ the_words }}</span> &mdash; [{{ the_author.title }}](/members/{{ the_tip.author }}){: #yak-collective-consulting-tip-author}

<script defer src="/assets/static/tips.js"></script>
