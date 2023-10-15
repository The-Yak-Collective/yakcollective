---
layout: post-external
title: |
  Playing around with the Web Monetization Protocol
date: 2021-01-12 14:29:00 +0000
author: 100074
original_link: https://blog.randylubin.com/playing-around-with-the-web-monetization-protocol
---

_Originally posted_ [_on Twitter_](https://twitter.com/randylubin/status/1335982410345840640)_, lightly edited for this post._

I’ve been playing around with the new Web Monetization Protocol (WMP) and it’s been super fun and interesting. Here’s a quick overview of WMP and my experience adding it to my sites.

[Web Monetization Protocol](https://webmonetization.org/) enables the flow of payments from a user to a website via their web browser. For instance, a user can direct a flow of micropayments (fractions of cents) to sites based on how much time is spent on each page – there’s no friction or fees involved.

On the user / browser side, I’ve been testing it out with [@Coil](https://twitter.com/Coil) right now – I spend $5 per month and 100# of it gets distributed to the websites I visit (if they have WMP enabled).

As site, you can enable WMP just one line of code – super easy. The current user base of folks paying with WMP is tiny but this is an exciting experiment that enables new ways for creators to earn revenue. Websites like Techdirt, Wired, and Imgur are [experimenting with WMP](https://www.techdirt.com/articles/20201002/23043245437/our-new-monetization-experiment-coil-web-monetization-protocol.shtml) and some are removing ads for visitors that use WMP.

I just added WMP to my games design platform, [Story Synth](https://storysynth.org), as well as to my blog and personal website.

[![Image](https://pbs.twimg.com/media/EopYq-KUYAIQ6Iq.jpg)](https://pbs.twimg.com/media/EopYq-KUYAIQ6Iq.jpg "Coil sending money to Story Synth")

Setting up WMP for Story Synth was super easy. I created a free wallet with [@UpholdInc](https://twitter.com/UpholdInc) and then added the wallet address into the header of the website with one short line of code:

I tested it with my Chrome Coil extension and quickly started receiving a trickle of payments. Granted, they were payments from myself, to myself – but still pretty cool!

[![Image](https://pbs.twimg.com/media/EopZdT7VEAAzUHV.png)](https://pbs.twimg.com/media/EopZdT7VEAAzUHV.png)

It reminds me of playing around with bitcoin in 2010 when the buzz was about impact not price speculation.

My real interest isn’t making money for Story Synth – it’s creating new revenue streams for game designers. With just a small tweak, I made it so that designers can share their own WMP wallet with Story Synth and it will auto become the destination when folks play their games

Designers add their wallet w/ an option row in their game’s Google Sheet, along with all their other game data

If they want, they can set a rev share with Story Synth (me). The default is Story Synth gets a 20% cut but they can change it to any % they want (including 0%).

[![Image](https://pbs.twimg.com/media/EopbiWEVoAg0Mwp.png)](https://pbs.twimg.com/media/EopbiWEVoAg0Mwp.png)

Side note - there isn’t a built-in way to do rev share yet so I dropped in the [**Probabilistic Revenue Sharing**](https://webmonetization.org/docs/probabilistic-rev-sharing) code which sets the wallet address randomly based on the defined revShare percent.

I don’t expect anyone to earn substantial revenue anytime soon but WMP a super fun thing to experiment with. It felt good to play with a new web protocol, especially one that avoids banks and fees and sends cash directly to indie creators.
