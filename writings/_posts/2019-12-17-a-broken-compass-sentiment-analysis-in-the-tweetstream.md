---
layout: post-external
title: 'A Broken Compass: Sentiment Analysis in the Tweetstream'
date: 2019-12-17 03:57:28.000000000 Z
author: 100080
original_link: https://hiredthought.com/2019/12/17/a-broken-compass-sentiment-analysis-in-the-tweetstream/
---

About a year ago, I became acutely aware that my consumption of Twitter was becoming increasingly entangled with elevated levels of anxiety. Twitter has long been a wonderful way to connect with cool people I can’t always see in person, so I didn’t appreciate how my experience with it was souring.

I began searching for ways to understand what was happening, so I could think about how to make it better. I could very reasonably blame my physiological reactions on my own bad habits, thought loops, and behavior patterns. However, I didn’t feel that I could confidently address that problem in the short-term (therapy can only do so much so fast), so I looked for another place to intervene.

The answer, I realized, was in the people I follow. Who I follow dictates what tweets and retweets end up in my feed. It even strongly influences the less obvious content of my feed — what “the algorithm” _thinks_ I want to see.

**It seemed reasonable to hypothesize that** **the quality of my feed depends greatly on the quality of the content authored (tweeted) and curated (retweeted) by those I follow**. So I decided I might begin to _actively_ shape my feed by following, unfollowing, and muting different accounts.

I realized, however, that I couldn’t perform these actions in a consistent way. My feed-shaping was ad-hoc and based on luck — whatever content showed up when I was looking would be evaluated — so I decided to find a more systematic approach.

How could I decide more quickly and deliberately who to follow, who to unfollow, and who to mute? First, I would need to understand what I wanted more of and less of.

I started playing with the Twitter API to pull down a list of people I followed, so I could at least open up all their profiles quickly and look through what they’d been tweeting. I was following hundreds of accounts, so it turned into quite the mess. I started playing with some other uses for the Twitter API, when I had a bit of a eureka moment…

**What if I could automatically analyze the tweets and retweets of all the people I follow in order to create a short-list of accounts to examine?**

IBM Watson had made a sentiment analysis API available, and that just might do the trick. I signed up for an account with free credits and began to try a few things out. With a few hours’ work, I had a giant pile of sentiment-analyzed tweets and retweets for all the accounts I followed. I aggregated the data, and visualized it as distributions according to percentiles of various sentiment dimensions, such as “Cheerfulness.”

- 
![](https://i2.wp.com/hiredthought.com/wp-content/uploads/2019/12/image.png?fit=205#2C1024&ssl=1)
- 
![](https://i0.wp.com/hiredthought.com/wp-content/uploads/2019/12/Screen-Shot-2017-12-28-at-8.47.41-PM.png?fit=204#2C1024&ssl=1)

As you can see, I was following accounts that skewed towards Depression, Sympathy, Artistic Interests, Liberalism, Self-Consciousness, and Imagination. And they were very much NOT Cheerful.

It became clear how I could use this information as a sort of _broken compass_. If I wanted more Cheerfulness and less Depression, for example, I could unfollow or mute accounts that ranked disproportionately low along those two dimensions. The distributions ought to change accordingly.

But I wouldn’t just perform those actions on those accounts automatically… that would be to accept a tyranny of algorithms. **I needed to have choice.**

I decided to start with Cheerfulness and shared the idea with [Venkatesh Rao](https://twitter.com/vgr). He was very supportive.

> Lol, you’re using sentiment metrics to figure it out?   
>   
> I’m beginning to see where your problems might lie ![🙂](https://s.w.org/images/core/emoji/12.0.0-1/72x72/1f642.png)
> 
> — Venkatesh Rao (@vgr) [January 17, 2018](https://twitter.com/vgr/status/953491629280604160?ref_src=twsrc#5Etfw)

Jokes aside, he did take interest, even introducing me to [Renee DiResta](https://twitter.com/noUpside), who has done [awesome, thought-provoking work about social media](https://www.ribbonfarm.com/2018/11/28/the-digital-maginot-line/) and its impact on our lives.

I began my first self-intervention, generating a list of accounts at the top and bottom percentiles as shown below. Could I really increase the Cheerfulness in my Twitter feed by adjusting who I followed?

![](https://i1.wp.com/hiredthought.com/wp-content/uploads/2019/12/Screen-Shot-2017-12-29-at-1.55.02-AM.png?fit=1024#2C887&ssl=1)

The answer, in short, was “yes.” (Blue is _before_. Orange is _after_.)

![](https://i0.wp.com/hiredthought.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-16-at-10.38.27-PM.png?fit=1024#2C630&ssl=1)

This result might seem unremarkable, yet it was incredibly encouraging as an example of having successfully “reshaped” (though perhaps in a very small way) the distribution of Cheerfulness in my feed!

This change also resulted in a few correlating changes to Anxiety, Anger, and Depression dimensions (less of each). There were unexpected effects, however, such as less Imagination:

![](https://i1.wp.com/hiredthought.com/wp-content/uploads/2019/12/Screen-Shot-2019-12-16-at-10.43.55-PM.png?fit=1024#2C632&ssl=1)

Though unexpected, it was not unwelcome — as long as I remained informed about how adjustments in following or unfollowing different accounts resulted in the tradeoffs along these dimensions, I could use this “broken compass” to take a more active role in shaping my feed.

As I shared the idea more widely, I ran similar exercises with willing participants, even going as far as to create a set of Frequently Asked Questions, such as:

- _What are you trying to accomplish here?_
  - The intention is to give you more control over the content of your Twitter feed through a fundamental mechanism: Who you follow.
- _Are these personality models accurate?_
  - Sort of — in a “[good enough](https://console.bluemix.net/docs/services/personality-insights/science.html#researchPrecise)” kind of way.
- _So what’s the point if the models aren’t exactly accurate?_
  - Well, accuracy that’s better than “good enough” isn’t necessary, because the models only tell you where to focus your attention and a “good enough” reason for doing so. If IBM Watson Personality Insights ranks an account a certain way along a certain dimension, it’s still up to you to decide what to do.
- _What mindset should I take with this method?_
  - There are no silver bullets.
  - This is an ongoing, iterative process.
  - Think, “IBM Watson ranked _this_ account _this_ way on _this_ dimension. Do I agree with that? Is it a reasonable hypothesis that unfollowing/following this account will bring about the desired change?” 

I considered building out a full service, but I realized the economics of the API calls just weren’t going to work out in my favor. Maybe some ideas are best left alone, for now. I hope one day to see a greater balance of power between social media giants like Twitter and its user base, and this project seemed like an interesting step in that direction. It felt good to explore an interesting edge of this problem space.

Two final points to significantly increase the quality of your feed…

First, an important lesson I learned about the “retweet” function is that it is not designed to engender a sufficiently careful curatorial approach to boosting content. In other words, it’s very easy to RT something, so we do it all the time, with little thought applied, amplifying the noise in our feeds. **As a general policy, I recommend disabling retweets for all accounts you follow on Twitter (make exceptions as appropriate**). Your feed quality will thank you!

Second, there is exactly one account I will endorse as overwhelmingly positive, and that is [Visakan Veerasamy](https://twitter.com/visakanv). He is a cheerful tweet genius who never ceases to brighten my day.

> Who is the #1 train nerd around here? The position is up for grabs in my head. I know [@vgr](https://twitter.com/vgr?ref_src=twsrc#5Etfw) is a sort of general-purpose “logistics of the world” nerd in a broad sense. But surely there is a weirdo who is \*super\* into trains around here [https://t.co/0aNjA8TLBx](https://t.co/0aNjA8TLBx)
> 
> — Visakan Veerasamy (@visakanv) [July 27, 2019](https://twitter.com/visakanv/status/1155038567015440386?ref_src=twsrc#5Etfw)

Thanks for reading!
