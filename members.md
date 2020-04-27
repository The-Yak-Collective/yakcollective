---
title: Yak Collective Members
members:
 - name: Venkatesh Rao
   status: Yak Shaver
 - name: Paul Millard
   status: Yak Shavers
---

Here are our members:

<main class="mw6 center">
{% for member in page.members %}

    <article class="dt w-100 bb b--black-05 pb2 mt2" href="#0">
      <div class="dtc w2 w3-ns v-mid">
        <img src="http://mrmrs.github.io/photos/p/2.jpg" class="ba b--black-10 db br-100 w2 w3-ns h2 h3-ns"/>
      </div>
      <div class="dtc v-mid pl3">
        <h1 class="f6 f5-ns fw6 lh-title black mv0">{{member.name}}</h1>
        <h2 class="f6 fw4 mt0 mb0 black-60">@yg</h2>
      </div>
      <div class="dtc v-mid">
        <form class="w-100 tr">
          <button class="f6 button-reset bg-white ba b--black-10 dim pointer pv1 black-60" type="submit">+ Follow</button>
        </form>
      </div>
    </article>
    
    {% endfor %}
  </main>