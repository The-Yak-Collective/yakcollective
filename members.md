---
layout: members
title: Yak Collective Members
partners:
 - name: Venkatesh Rao
   image: venkatesh-rao.jpeg
   indie_status: 9+ years
   twitter: vgr
   links:
     - title: Ribbonfarm
       url: https://ribbonfarm.com
     - title: Art of Gig
       url: https://artofgig.substack.com
 - name: Paul Millerd
   image: paul-millerd.jpg
   previous: McKinsey, BCG, GE, Russell Reynolds 
   indie_status: 3+ years
   twitter: p_millerd
   links:
     - title: Boundless
       url: https://think-boundless.com/
     - title: Strategy U
       url: https://strategyu.co/
 - name: Pamela Hobart
   image: pamela-hobart.jpeg
   indie_status: 3+ years
   twitter: amelapay
   links:
     - title: pamelajhobart.com
       url: https://www.pamelajhobart.com/
     - title: Substack
       url: https://pamelajhobart.substack.com/
 - name: Tom Critchlow
   image: tom-critchlow.jpeg
   previous: Google
   indie_status: 5+ years
   twitter: tomcritchlow
   links:
     - title: tomcritchlow.com
       url: https://tomcritchlow.com/
     - title: Little Futures
       url: https://littlefutures.club
collaborators:
 - name: Amanda Reeves
   image: Amanda-Reeves.jpg
   indie_status: 1+ years
   twitter: WabiSabiFutures
   links:
     - title: Wabi Sabi Futures
       url: https://www.wabisabifutures.com/
     - title: Ahoyhoy
       url: https://www.ahoyhoy.com.au/
---

<div class="container mw7 cf pv5 f4-l center w-90 lh-copy">

<h1>Partners</h1>

Yak Collective partners have played key roles in projects, helped steer the collective and tweeted excessively.

{% for member in page.partners %}

<div class="fl w-100 pa2">

  <div class="flex items-center lh-copy pa3 ba b--black-10">
      <img class="w2 h2 w3-ns h3-ns br-100" src="/images/members/{{member.image}}" />
      <div class="pl3 flex-auto">
        <span class="f6 db black-70">{{member.name}}</span>
        <span class="f6 db black-70">{{member.title}}</span>
        <span class="f6 db black-70">Indie status: {{member.indie_status}}</span>
        <span class="f6 db black-70">{% if member.previous %}Previously: {{member.previous}}{% endif %}</span>
        <span class="f6 db black-70">{% for link in member.links %}{% if forloop.first == true %}{% else %} / {% endif %}<a href="{{link.url}}">{{link.title}}</a>{% endfor %}</span>
      </div>
            <div>
        <a href="https://twitter.com/{{member.twitter}}" class="f6 link blue hover-dark-gray">@{{member.twitter}}</a>
      </div>
  </div>

</div>
{% endfor %}

<h2 class="cf pt3">Collaborators</h2>

Yak Collective collaborators have contributed to one or more projects.

{% for member in page.collaborators %}

<div class="fl w-100 pa2">

  <div class="flex items-center lh-copy pa3 ba b--black-10">
      <img class="w2 h2 w3-ns h3-ns br-100" src="/images/members/{{member.image}}" />
      <div class="pl3 flex-auto">
        <span class="f6 db black-70">{{member.name}}</span>
        <span class="f6 db black-70">{{member.title}}</span>
        <span class="f6 db black-70">Indie status: {{member.indie_status}}</span>
        <span class="f6 db black-70">{% if member.previous %}Previously: {{member.previous}}{% endif %}</span>
        <span class="f6 db black-70">{% for link in member.links %}{% if forloop.first == true %}{% else %} / {% endif %}<a href="{{link.url}}">{{link.title}}</a>{% endfor %}</span>
      </div>
            <div>
        <a href="https://twitter.com/{{member.twitter}}" class="f6 link blue hover-dark-gray">@{{member.twitter}}</a>
      </div>
  </div>

</div>
{% endfor %}


  </div>