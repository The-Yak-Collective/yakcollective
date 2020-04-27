---
layout: members
title: Yak Collective Members
partners:
 - name: Venkatesh Rao
   image: venkatesh-rao.jpeg
   title: Yak Shaver
   indie_status: 9+ years
   previously: Optional
   twitter: vgr
   links:
     - title: Ribbonfarm
       url: https://ribbonfarm.com
     - title: Art of Gig
       url: https://artofgig.substack.com
contributors:
 - name: Amanda Reeves
   status: Yak Shaver
 - name: Paul Millard
   status: Yak Shavers   
---

<div class="container mw7 cf pv5 f4-l center w-90 lh-copy">

<h1>Partners</h1>

{% for member in page.partners %}

<div class="fl w-50-l pa2">

  <div class="flex items-center lh-copy pa3 ba b--black-10">
      <img class="w2 h2 w3-ns h3-ns br-100" src="/images/members/{{member.image}}" />
      <div class="pl3 flex-auto">
        <span class="f6 db black-70">{{member.name}}</span>
        <span class="f6 db black-70">{{member.title}}</span>
        <span class="f6 db black-70">{% for link in member.links %}<a href="{{link.url}}">{{link.title}}</a>{% if forloop.first == true %}{% else %} / {% endif %}{% endfor %}</span>
      </div>
  </div>

</div>
{% endfor %}

<h2 class="cf">Collaborators</h2>



  </div>