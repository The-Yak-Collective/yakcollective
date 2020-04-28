---
layout: members
title: Yak Collective Members
partners:
 - name: Venkatesh Rao
   image: venkatesh-rao.PNG
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
 - name: David McDougall
   image: david-mcdougall.jpg
   indie_status: 3+ years
   previously: Product Management in SMEs across US & UK
   twitter: dmcdougall
   links:
     - title: Innovation at Scale
       url: https://innovationatscale.substack.com/
 - name: Darren Kong
   image: darren-kong.jpg
   indie_status: 3+ years
   previously: Other Internet
   twitter: platformpapi
   links:
     - title: Varietal Internet
       url: https://varietal.xyz/home/
 - name: Vaughn TAN
   image: vaughn-tan.png
   indie_status: 5+ years
   previously: Google, and currently University College London School of Management
   twitter: vaughn_tan
   links:
     - title: bio
       url: https://vaughntan.org/bio
     - title: book
       url: https://vaughntan.org/uncertainty
     - title: newsletter
       url: https://uncertaintymindset.substack.com/
 - name: Randy Lubin
   image: randy-lubin.png
   indie_status: 10+ years
   twitter: randylubin
   links:
     - title: Consulting Entrepreneur
       url: https://randylubin.com/ 
 - name: Vlad Mehakovic
   image: vlad-mehacovic.jpg
   indie_status: Aug 2019
   twitter: vladiim
   links:
     - title: mehakovic.com
       url: http://mehakovic.com/            
       
---

<div class="container mw7 cf pv5 f4-l center w-90 lh-copy">

<h1>Partners</h1>

Yak Collective partners have played key roles in projects, helped steer the collective and tweeted excessively.

<div class="pv3">
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
</div>

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