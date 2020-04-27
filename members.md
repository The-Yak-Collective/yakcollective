---
layout: members
title: Yak Collective Members
partners:
 - name: Venkatesh Rao
   title: Yak Shaver
   links:
     - title: Ribbonfarm
       url: https://ribbonfarm.com
     - title: Art of Gig
       url: https://artofgig.substack.com
 - name: Paul Millard
   status: Yak Shavers
contributors:
 - name: Amanda Reeves
   status: Yak Shaver
 - name: Paul Millard
   status: Yak Shavers   
---

Here are our members:

<main class="mw6 center">
{% for member in page.partners %}


{{member.name}}

{% for link in member.links %}
<a href="{{link.url}}">{{link.title}}</a>
{% endfor %}
    {% endfor %}
  </main>