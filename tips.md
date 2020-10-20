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

{% assign the_one = site.time | date: "%s" | modulo: site.data.tips.size %}
{% assign the_tip = site.data.tips[the_one] %}
{% assign the_author_slug = the_tip.author %}
{% assign the_author = site.members | where: "name", the_author_slug | first %}
{% assign the_words = the_tip.tip %}

# Yak Collective Consulting Tip #{{ the_one | plus: 1 }}
{: #yak-collective-consulting-tip-number}

<span id="yak-collective-consulting-tip">{{ the_words }}</span> &mdash; [{{ the_author.title }}](/members/{{ the_author_slug }}){: #yak-collective-consulting-tip-author}

<script defer src="/assets/static/tips.js"></script>
