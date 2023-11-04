---
title: Oozy Intelligence in Slow Time
date: 2023-11-04 20:10:22.000000000 Z
layout: post-external
original_link: https://studio.ribbonfarm.com/p/oozy-intelligence-in-slow-time
author: 100041
---

_This essay is part of the [Mediocre Computing](https://studio.ribbonfarm.com/p/mediocre-computing) series_

I just connected some very interesting dots between my [Fear of Oozification thesis](https://studio.ribbonfarm.com/p/fear-of-oozification) (Sept 29), Matt Webb’s excellent reframing of AI as [intelligence too cheap to meter](https://interconnected.org/home/2023/10/06/ubigpt) (Oct 6) published a week later, and my old [Superhistory, not Superintelligence](https://studio.ribbonfarm.com/p/superhistory-not-superintelligence) essay (May 2021). The connection is simply this: _oozification in AI is the effect of intelligence being too cheap to meter, and existing in high-detail slow time as a result._ I’m very pleased with how this set of ideas is starting to come together.

Matt’s headline is self-explanatory, but you should click-through and read anyway and return here, since he makes some subtle points.

In my post, I defined oozification as follows:

> _ **Oozification** is the process of recursively replacing systems based on numerous larger building blocks, governed by many rules, with ones based on fewer, smaller building blocks, governed by fewer rules, thereby increasing the number of evolutionary possibilities and lowering the number of evolutionary certainties._

and applied it to AI like so:

> Out of all the possibilities in the vast universe of Lovecraftian horror, why _shoggoths_ in particular?…The answer is: They are the ooziest beings in the Lovecraftian universe…Shoggoths are large masses of barely living protoplasm, … [that] gained a glimmer of “general” intelligence and sentience, enough to threaten their creators.
> 
> …
> 
> Now there’s an obvious cosmetic mapping to the basic nature of modern machine learning. At the hardware level, GPUs and similar types of accelerator hardware comprise large grids of very primitive computing elements that are rather like a mass of protoplasm. The matrix multiplications that flow through them are a very primitive kind of _elan vital._ Together, they constitute the primordial ooze that is modern machine learning. There are almost no higher-level conceptual abstractions in the picture. _Everything_ emerges from this ooze, including any necessary (but not necessarily familiar) structure.

Let me connect the dots here with a particularly clear example. A use case I discovered for GPT4 that has immediately shot to the top of my list of ways to use my $20/mo Jarvis: inventory management for cheap crap.

In playing with electronics, one of the dull, grinder-y things you have to do is look up part numbers and pin-out diagrams for chips, and data sheets for components. Cheap stuff you buy from China, in oozy assortment boxes, is often minimally documented, with just a list of part numbers and counts. A few boxes of ooze like this have been sitting around in my workshop for a couple of years without me doing anything with them, because I’ve been too lazy to do the boring work of looking up part numbers and pin-out diagrams that is necessary and unavoidable for getting to the fun part of playing with them.

I bought one such box a year ago because the assortment included _one_ part I recognized and wanted to learn to use (the classic 555 timer chip), but it came with a bunch of other stuff I’ve been meaning to get around to.

Here is what ChatGPT can do with this problem:

[![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F7281cbfd-553d-42ae-93c8-97094c4a626c_1948x1450.png)](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F7281cbfd-553d-42ae-93c8-97094c4a626c_1948x1450.png)

The thing about this problem is that it doesn’t require _high_ intelligence. This is not like beating Magnus Carlsen at chess. It requires _cheap_ intelligence on a lot of raw information. But without intelligence too cheap to meter, I probably wouldn’t systematically solve this problem at all. I wouldn’t generate and save this kind of neat documentation at all and get to the fun part.

Now to be sure, it’s fairly obvious if you do the math on GPUs that ChatGPT is priced outrageously low, and it probably costs an order of magnitude more to provision than OpenAI charges (which is a good reason to pay and essentially get free subsidy money btw). Quite possibly, this query cost more in compute time than the box of cheap parts itself.

But even taking that into account, this is _still_ too cheap to meter. Paying a human to do this would be prohibitive at hobby scale at least.

ChatGPT can do more than just interpret and document photos of packing lists. The browse-with-Bing feature can go schlep around and find and link the data sheets. It’s not yet _great_ at this (the oozy swamp of electronics parts documentation is a bit too high-entropy for it), but it’s already good enough that it triaged away almost all the grinding. I just have to do a few of the messier ones. I just cut and paste the responses into my Roam notebook.

It can even give you basic circuits to try, to familiarize yourself with a chip or part.

The effect of having this too-cheap-to-meter intelligence on tap has been immediate: I’ve actually started playing with these parts I’ve had lying around.

Here’s the connection to oozification: When intelligence becomes too cheap to meter, it becomes cheap enough to inject into tiniest bits of oozified techology. The vast universe of cheap electronics parts (my varied assortments of ICs are on average under $1) don’t justify spending a lot on unlocking their utility. If you spend $30 in intelligence to learn the basics of how to use a $0.50 part, it’s not sustainable. But if you can spend $0.25 for the task, it is. The task is not just below the minimum-wage threshold for human intelligence. It’s below a patience threshold for human attention.

Matt’s reframe of AI aligns neatly with my own reframe in [Superhistory, not Superintelligence](https://studio.ribbonfarm.com/p/superhistory-not-superintelligence), and extends it nicely. In that post, I argued that AI should be considered intelligence that’s simply learned for a very long time in human years, due to the way training works. So in terms of training time, something like GPT is thousands of years old, and anyone using an AI in an integrated way, like Magnus Carlsen learning his chess skills in a feedback loop with chess AIs, is effectively hundreds of years old.

“Too cheap to meter” extends that frame to inference. The reason tasks like looking up part numbers and data sheets is hard is that _time_ is expensive for us humans. But AI in inference mode has all the time in the world compared to you and me. It can do an hour’s worth of browsing around and collecting links in minutes, and what’s more, tirelessly browse and collect for hours. This has big implications.

[Read more](https://studio.ribbonfarm.com/p/oozy-intelligence-in-slow-time)

