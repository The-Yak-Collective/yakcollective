---
layout: members
title: Yak Collective Members
partners:
 - name: Venkatesh Rao
   image: vgr.png
   title: Yak Shaver
   indie_status: 9+ years
   previously: Optional
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

<div class="container mw7 cf pv5 f4-l center w-90 lh-copy">

<h1>Partners</h1>

{% for member in page.partners %}

<div class="w-25-l ba b--black-10 pa2">


{{member.name}}

{% for link in member.links %}
<a href="{{link.url}}">{{link.title}}</a>
{% endfor %}

</div>
{% endfor %}

<h2>Collaborators</h2>



  </div>