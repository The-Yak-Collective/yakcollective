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
    Figure out the tip we want. Note that we can't use `sample` here,
    since we need an actual tip number, and Liquid doesn't give us an
    easy way to determine what index we extracted from our array with
    that method.
{% endcomment %}
{% assign the_one = site.time | date: "%s" | plus: 0 | modulo: site.data.tips.size %}
{% assign the_tip = site.data.tips[the_one] %}
{% assign the_author_url = "/members/" | append: the_tip.author | append: "/" %}
{% assign the_author = site.pages | find: "url", the_author_url %}
{% assign the_words = the_tip.tip %}

# Yak Collective Consulting Tip #{{ the_one | plus: 1 }}
{: #yak-collective-consulting-tip-number}

<span id="yak-collective-consulting-tip">{{ the_words }}</span> &mdash; [{{ the_author.title }}]({{ the_author.url }}){: #yak-collective-consulting-tip-author}

<script defer src="/assets/static/tips.js"></script>
