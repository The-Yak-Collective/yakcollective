---
layout: none
---

{% comment %}
	Google Analytics config. Broken off as its own file to allow for
	caching and the use of the `defer` attribute.
{% endcomment %}

window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', 'UA-164565897-1');
