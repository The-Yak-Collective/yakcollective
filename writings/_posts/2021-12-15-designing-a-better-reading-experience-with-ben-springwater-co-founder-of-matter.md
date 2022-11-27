---
layout: post-external
title: |
  Designing a better reading experience with Ben Springwater, co-founder of Matter
date: 2021-12-15 01:35:00 +0000
author: 100071
original_link: https://nesslabs.com/matter-featured-tool?utm_source=rss&utm_medium=rss&utm_campaign=matter-featured-tool
---

Welcome to this new edition of our Tools for Thought series, where we interview founders on a mission to help us think better, be more creative, and more productive without sacrificing our mental health.

Whether it’s on social media, in private group chats, while listening to podcasts, when reading blog posts, or in our inbox, we are bombarded with information. It can be anxiety-inducing to keep track of all the content we want to consume, and to keep up with all our favorite content creators.

Ben Springwater is the co-founder of [Matter](https://hq.getmatter.app/), a better reader built for today’s internet. It’s beautifully designed and includes innovative features such as social curation, distraction-free reading, and turning your newsletters, blogs, and articles into an audio playlist with a human-sounding voice.

In this interview, we talked about the challenges of online reading, the power of curation, the little details that make the difference to create an enjoyable reading experience, how the recency bias hurts our information diet, why the team at Matter cares about interoperability, and much more. Enjoy the read!

[![Matter app queue](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-1-808x1024.png)](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-1.png)

**Hi Ben, thank you so much for agreeing to this interview. We have been reading online for decades, and yet, it’s a terrible experience. Why do you think that’s the case, and what exactly inspired you to build Matter?**

Hi Anne-Laure, I’m a fan of your work so it’s a treat to be with you today.

The term “reading online” really consists of several behaviors: deciding what to read, the act of reading, and what you do with your knowledge after you read.

Let’s start with _deciding_ what to read. I won’t belabor the point that we live in a world of content abundance and information overload. By necessity, we have heuristics for deciding what to read. It could be subscribing to a voice we trust, browsing headlines, following social media feeds, and so on.

Read-it-later is one of the best heuristics, when you think about it. It’s essentially your past self acting as a filter for what your future self will want to read when you can set aside time. 

Of course, read-it-later apps have been around for a while. And let’s give credit where credit is due: Pocket and Instapaper are brilliant. I was a top 1% Pocket user for about a decade before starting Matter with my co-founder Rob Mackenzie, who was also a Pocket user. Read-it-later has been a core practice of mine for a long time.

All this said, the first generation of read-it-later apps don’t have a lot of smarts built into them. For example, they don’t help with prioritization, resurfacing, or decay — and they’re of course limited to what you put into them, which is just an infinitesimal fraction of what you might want.

We think it’s possible to build a better decision engine for reading. (This said, we’ll always let users manually control their queue.) It’s a hard problem, and we’ve by no means solved it yet. It’s also consequential. Consider how much of our worldviews, knowledge, models, and so on are the accumulated product of micro-decisions about what we read.

Bezos talks about the importance of focusing on needs that won’t change. For instance, ten years from now, customers will still want faster delivery. We know the supply of great content will continue to rise, attention will always be scarce, and the returns to making good decisions about what to read will remain high — and indeed, increase — over time. Creating a better decision engine for reading is a long-term, vitally important project.

The next big piece of “reading online” is the reading experience itself. One of our beliefs is that reading should be seamlessly multi-modal. What I mean is, you should be able to listen to written content, you should be able to read audio content (for example, your podcasts), and you should be able to smoothly switch back and forth from any point in the text. You should even be able to read the internet on your Kindle.

A big part of our vision is building a universal “reading” client that will give you this multi-modal magic across all your language-based media. Speech synthesis and audio transcription have only recently gotten to the point where this vision is viable, and the experience will be even better in a few years than it is today.

Finally, what do you do with what you read? Maybe you highlight, annotate or write reflections. Maybe you want to share specific passages. We want to make it easy to share your nuggets of distilled knowledge, both to your own knowledge base (for example, Obsidian, Notion, Roam), where you can connect and synthesize them, and socially.

**Your level of intentionality is amazing. What else makes Matter different from other reading apps?**

Ultimately, we aim to give users clarity of space: Matter is the place you go when it’s time to read. To this end, we bring together the major reading workflows — read-it-later, an inbox for the writers and newsletters you follow, and recommendations — into an integrated experience that’s beautiful on the front end and powerful on the backend.

We’re also a bit different in that Matter is modeled around people. Trust is one of the most important factors when deciding what to read, and people trust _people._

You see this playing out in the world of media, with the rise of individual writers, podcasters, etc., and the corresponding unbundling of traditional media companies. An individual is “higher resolution” than a publisher, in the sense that you can form a clearer model of their taste, quality, values, and so on.

When we started Matter, we made the decision to elevate writers as first-class citizens in our system. I think we’re the only product that lets you follow individual writers and receive their latest writing. (This admittedly takes work to scale up, and our system has gaps, but we’re working hard to get there.)

[![Matter app Discover and Inbox](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-2-739x1024.png)](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-2.png)

Matter is also built around curation. Good curation is incredibly valuable, especially as a way of finding gems (often obscure, often old) that are overlooked by engagement-based algorithms. Some Matter users are consistently excellent curators. One of the questions we ask is, how can we scale curation and build a system where hundreds of thousands of curators surface treasures from the long tail and deep archives of the internet.

I should note that we don’t view recommendation algorithms and human curation as being mutually exclusive or even necessarily in tension. To the contrary, we expect they’ll augment each other and that our system will evolve into a human-machine hybrid. As an example, Robert Cottrell (editor of [The Browser](https://thebrowser.com/)) – perhaps the single greatest curator of writing the internet has known – uses a custom ML-based aggregator, trained on his own history of selections, to winnow his daily search for the best writing on the web. One thing we’re confident about is there will always be human judgment in the loop.

Finally, some of what we do isn’t new per se, but we sweat the details to make it _feel_ great. Highlighting is an example. In most reading apps, highlighting is a two-step action. First, you select text, then you tap a menu option to highlight the selection. It’s easier to build highlighting this way, because you get text selection out of the box. But as a reader, that extra bit of friction can take you out of flow. It’s a better experience if you can draw a highlight with a single press-and-drag. This is of course not that hard to do – other readers _could_ do it – but it takes more effort. We have been very clear internally that we will put in the effort when it comes to the details. The details add up. It’s a central part of our product development ethos.

**Let’s talk about quality over recency. How is Matter helping readers discover the best content, regardless of when it was published?**

In general, our information consumption is heavily biased toward _what’s new_. Social media is dominated by the news, and so on. And we get it. We’re all tuned for novelty on a deep level. On top of that, recency is a useful algorithm insofar as it creates common knowledge that has social benefits — like, we can talk about the news together. There are deep reasons that _what’s_ _new_ is so dominant.

But, but… It’s _also_ the case that 99.99% of the best stuff that’s ever been written or produced was _not_ written in the past week.

In our view, there should be more emphasis on quality over recency. _What’s new_ is important but we think the bias toward it is _too_ strong, and we’re designing Matter to serve as a counterweight.

One way we do this is by favoring older content in our curation. If someone shares an old article, its oldness per se is actually a pretty strong signal that it’s of high quality – otherwise, why would the person have singled it out over everything else they could have shared? It must have left an impression. We do little things too, like applying a golden date badge to old articles to add visual emphasis.

[![Matter app Discover](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-3-545x1024.png)](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-3.png)

I’d say we’ve only scratched the surface in terms of what we might do to promote “old classics” and it’s an area we’re excited to experiment with.

By the way, one of the pitfalls we’re sensitive to is exacerbating content overload, so we’re unlikely to ever give you, say, an infinite feed or catalog of the best essays of all time, even if we felt we could do a pretty good job identifying them. We need to figure out how to deliver them so that they’re relevant and manageable. The design space is large. It’s a fun problem to work on.

**And what kind of content can people read with Matter?**

We designed Matter for today’s media ecosystem, which is different from that of ten years ago. Today, alternative media formats like Twitter threads, newsletters, and podcasts are more important, and we think they should all live happily together in your reader and content library.

Take newsletters as an example. It’s the golden age of newsletters! The problem is, your email inbox isn’t great for reading. Most people want to get through their inbox as quickly as possible, not spend more time there. Plus, you can’t highlight or annotate. So, we make it easy to bring your newsletters into Matter, either by connecting Gmail or using a unique forwarding address.

One of Matter’s most important functions is to “parse” articles in order to present them in reader mode. When you save a web article, we strip out the boilerplate – banner ads, pop ups, menus – and give you a clean, well-formatted version that you can access offline, highlight, listen to, and so on.

Parsing is an interesting topic when you peak behind the curtains. It’s actually one of the biggest technical challenges for us. Getting the first 95% of accuracy is easy, but the last 5% is hard, because you have to handle the entire surface area of the web and there are so many edge cases. On top of that, web standards are constantly evolving (eg., lazy loading) so your parser has to as well. Highly reliable parsing is fundamental to the user experience, and we’re beginning to incorporate more sophisticated techniques, like NLP and computer vision, to push our accuracy even higher.

A web article is different from an email is different from a PDF, and we’re building specialized parsing engines for each. Basically, we view it as our job to do the heavy lifting so that readers get a clean, standardized reading experience across all their media that “just works”.

We don’t yet parse PDFs, and we don’t yet support podcasts or YouTube… but when we do, I think folks will be pretty excited by our implementation.

**Matter also takes audio very seriously. Can you tell us more?**

Ah, audio — a fun topic! Well, in terms of consumer behavior, audio has become an increasingly important mode of consumption. In part, this rise in “ear time” is driven by hardware that makes listening more convenient, such as AirPods and Alexas; in part it’s because audio allows multi-tasking and doesn’t compete with screen time, which is saturated; in part it’s driven by a proliferation of high-quality audio content, which is itself incentivized by growing audio demand, in a positive feedback loop.

You should be able to listen to anything you can read. And look, it has _technically_ been possible to listen to articles for a long time. But the voice has always been pretty robotic, and as a result, it’s not practical — certainly not pleasant — for most people.

Today, speech synthesis is much better. I never listened to articles when I used Pocket (I tried but found the voice too distracting), but I listen regularly on Matter. It’s not quite indistinguishable from human, but I expect it’ll get there within a few more years. Almost certainly within 5-10. One of our priorities is to stay on the cutting edge when it comes to audio.

So far, I’ve been talking about voice quality, but the UX of how audio is incorporated into the product is also important.

As you listen to an article in Matter, you’ll see that the word is highlighted as it’s spoken and the article tracks along to the audio. Why is that important? It lets you sync your place as you switch between listening and reading. If you want to play audio midway through an article, you can long press any word and start audio from that point. Conversely, if you hear something that catches your attention, you can open your phone and highlight it or take a note. It enables audio to fit more comfortably into knowledge workflows.

[![Matter app audio podcast](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-4-506x1024.png)](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-4.png)

We added a feature called “audio highlights” that lets you highlight as you listen without opening your phone! (Triple-tap your Airpods or press both volume buttons at the same time to make an audio highlight.)

**With traditional books, reading happens in a silo. But Matter does things differently.**

Yes, absolutely. Interoperability is crucial. Reading takes place within larger workflows, and we take it as a given that your reader should be open and interoperable with your other tools. We actually launched our Obsidian plugin last week. Notion and Readwise are also live, with more on the way. Data portability is also important. You can export your library today and we plan to make this capability richer in the future.

**What are some other features you are particularly proud of?**

Here’s a little one: minimaps. If you two-finger tap an article, we show you a miniaturized version, so you can scan headers and quickly navigate. We took inspiration from video games and code editors. It’s neat on mobile, and I think it’ll be even neater on desktop web.

**What kind of people use Matter?**

Our core users tend to be what we call “active” readers. Not just in the sense that they read a lot, but in the sense that they’re intentional about what they read and proactively curate their information diets. Often they have favorite writers and subscribe to newsletters. Often they frequent obscure blogs. (You could contrast this persona with someone who just reads the news headlines.) I believe Tyler Cowen coined the term “infovore” to describe people who are hungry for information and actively seek it out. There’s that as well.

Some read to gain practical, job-specific knowledge and stay up on industry news (lots of software engineers, product managers, designers, and folks in finance), some come for sense-making and general enrichment.

**And how do you personally use Matter?**

I scan through my Matter inbox in the morning. I’ll scroll the headlines and read shorter posts. If there are longer pieces that look interesting and I don’t have time, I’ll save them. I save lots of articles during the course of the day — stuff I encounter on the web and Twitter and that people send to me.

I usually listen to articles I’ve saved while I make lunch and fold laundry. I tend to listen to (as opposed to read) articles that are easier to process and don’t contain lots of data or media.

At night, when I have the time, I’ll read from my queue. These days I tend to read practical stuff related to company-building, strategy, and so on.

**What advice would you give someone using Matter for the very first time?**

After you download the app and create an account, install the web extension, then save an article you want to read from the web. 

Open up Matter and go to your queue: you’ll see we’ve cleaned up the article and removed ads to create a clean and focused reading environment for you.

Highlight your favorite line, click the sparkly icon to make it into a quoteshot, and share that quoteshot with a friend. You just produced an artifact of your reading.

[![](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-5-833x1024.png)](https://nesslabs.com/wp-content/uploads/2021/12/matter-app-5.png)

**What’s next for Matter?**

I mentioned a couple of our long term ambitions — building a radically smarter decision engine for reading, and building a universal client that enhances consumption and knowledge capture across all your different media. I may have hinted at some of what users can expect in the year to come. We’ve got a lot to do!

Our goal is to increase the ROI of reading. We want to help people get more from the time they invest in reading — more insight, more knowledge, more… thrill, is that a weird word to use? We want the effect to be so palpable that people find themselves wanting to read more, and do. That’s our standard of success.

**Thank you so much for your time, Ben! Where can people learn more about Matter and give it a try?**

You can download Matter from [our site](https://getmatter.app). Also, visit our [Wall of Love](https://twitter.com/getmatterapp/timelines/1353843820639739906) and follow us on Twitter [@getmatterapp](https://twitter.com/getmatterapp) where we announce new updates, answer questions, and promote our curators’ greatest hits. We’re very friendly; say hi anytime!

The post [Designing a better reading experience with Ben Springwater, co-founder of Matter](https://nesslabs.com/matter-featured-tool) appeared first on [Ness Labs](https://nesslabs.com).
