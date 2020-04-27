---
layout: members
title: Yak Collective Members
partners:
 - name: Venkatesh Rao
   title: Yak Shaver
   indie_status: 9+ years
   previously: Optional
   twitter: @vgr
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

{{member.name}}

{% for link in member.links %}
<a href="{{link.url}}">{{link.title}}</a>
{% endfor %}

{% endfor %}

<h2>Collaborators</h2>



  </div>