---
layout: post-external
title: |
  The REALIST Stack
date: 2021-07-01 15:39:00 +0000
author: 100041
original_link: https://studio.ribbonfarm.com/p/the-realist-stack
---

I want to introduce a lighthouse concept that I’ve been noodling on for several years now, which I finally turned into an acronym that I can easily reference: the **REALIST** stack. A lot of my writing in recent years has been subconsciously shaped by the idea of this stack in the back of my head. A lot of my consulting work since 2016 or so has also been with companies that work on this stack, one way or another.

[![](https://cdn.substack.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2Fe60ea4ee-febb-4c65-971d-51c149c1e6c8_1272x814.png)](https://cdn.substack.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2Fe60ea4ee-febb-4c65-971d-51c149c1e6c8_1272x814.png)
_The Realist Stack_

It’s a stack that’s been maturing all around us for a few years, driven by the twin forces of software eating the world, and the global energy transition.

The idea of thinking of engineering as happening on multi-layered technology “stacks” came from software, but the REALIST stack applies to all engineering. And increasingly, all engineering _should_ happen on the REALIST stack to the extent possible. If you can build something on the REALIST stack, you probably shouldn’t build it any other way.

Rather serendipitously for a backronym, the letter order roughly follows the actual order of abstraction. Even better, the bottom four layers, which deal with moving atoms around, spell **REAL**. Here is the breakdown:

1. **R:** At the lower, most embodied end, **renewable energy** is the foundational design driver in engineering today, whether you’re building rockets or data centers. As an engineer, if you aren’t thinking about how your thing can be carbon-neutral or even carbon-negative over its operational lifecycle from the first paper-napkin concept sketch, you aren’t doing your job right.

2. **E:** The more you **electrify everything** , whether it is drivetrains, door locks, or heating/cooling, the easier it becomes to manage, optimize, and improve with software. While electricity is not always the most efficient energy currency in a device (for example, direct solar desalination with a heat exchanger can be more efficient than electricity-based methods), it’s the best default choice today. Electrify everything unless you have a _really_ good reason not to.

3. **A: Additive-** _ **first** _ means you try and design physical things strategically around 3d printing capabilities, which has interesting benefits in terms of decentralization, repairability, modularity, user-empowerment, waste reduction, and so on. 3d printing has improved a lot since the early days, and it’s increasingly possible to go beyond plastics to metals and other materials. But the goal is not 100% 3d printability as portrayed in _Diamond Age,_ with pipes delivering printing feedstock. That would be highly inefficient, since so many process and manufacturing industries enjoy economies of scale not just in dollar terms, but energy and material usage terms. The goal is leveraged use of additive manufacturing in the right places to reshape the dollar and carbon economics of things. 

4. **L: Lithium-based** battery chemistries aren’t the only ones out there of course, and other exotics, as well as non-battery modes of energy storage, are constantly being explored. But to a first-order approximation, both the software eating the world and energy transition revolutions are being powered by lithium batteries. Lithium is to 2021 what silicon was to 1961.

5. **I:** The lowest software layer is the **internet of things (IoT)**. It’s been the butt of jokes for a decade now, being alternately dismissed as either vaporware or the “internet of shit,” but it’s very real now. There’s an order of magnitude more embedded computers in the world than any other kind, and networking them all is turning into a very powerful thing to pursue. Though there’s all sorts of risks and problems, ranging from vulnerability to ransomware to potential for weird kinds of cascade failures, when it works, the IoT really radically alters our environment. 

6. **S:** Probably the most exciting layer today is the **software-defined middleware** layer, which is the backend, industrial counterpart of the phone-applifcation of everything for consumer economy. I think of it as the lowest level at which software can eat a human or hardware function. Below that, physics forces you to be primarily atom-based. Software-defined networking, software-defined radio, synthetic-aperture telescopy, are all examples. So is every sort of enterprise middleware. This is where the software and energy revolutions meet. When software eats something in this layer, you get dematerialization benefits on the energy/carbon front, and programmability and flexibility on the software end. 

7. And at the most abstract, disembodied end, we have the latest **tensor-based computing** driving machine learning. Yes, it’s AI, but increasingly I find “intelligence” to be a highly restrictive and anthropocentric mental model of what it is. Tensor-based could alternately be called _time-_based, if you think of AI as AT (Artificial Time; see my May 11 post, [Superhistory, Not Superintelligence](https://studio.ribbonfarm.com/p/superhistory-not-superintelligence)). 

The REALIST stack, I believe, is taking over all technology. The rates depends on the churn rate of the underlying materialities. So the automotive sector is going REALIST over about 20 years, while housing will probably take like 50 or 60.

The REALIST stack is how software is eating the hardware-based world of things, and preparing it for existence on a terra being terraformed by energy and material transitions.

How should you think about this stack? For starters, how tall is it, and how does it compare to other similarly expressive stacks? Like say the fossil-fuel-based stack or pre-modern stack?

Since the number of layers in a stack is a function of how finely you draw distinctions, it’s hard to compare stacks. Two crude measures, however, help get a sense of any stack.

The first measure is the absolute _span_ of a stack. In this case, the REALIST stack touches 90% of the range of abstractions and phenomenology you might have to consider in engineering a typical modern system. So for example, even though the [OSI stack](https://en.wikipedia.org/wiki/OSI_model) of computer networking also has 7 layers, it fits entirely within 2 of the layers of the REALIST stack, so it has a much smaller span. The pre-modern stack of carpentry and steel-smithy would also have a much smaller span.

The other measure is the relation of the stack height to the capability range of a single engineer. A friend of mine, Keith Adams, has a helpful rule of thumb: the typical range of a good engineer is 3 layers of a stack: a home layer, plus pinch-hitting ability one layer above and one layer below. So a systems programmer who primarily works with C and low-level representations might also have some comfort with processor architecture “below,” and with compiler design “above.” So a good “full-stack” professional is a human stack-height measuring stick of length 3.

This means, whether your logical stack diagram has 3, 4, 7, or 70 layers, a normalized measure (kinda like 20-foot equivalents, or TEUs in container shipping) is how many specialized engineers stacked on each other in a sort of totem pole can “cover” it with at least industry-standard competence.

In my experience, the REALIST stack is approximately 3-4 engineers high, assuming you buy rather than build as much as possible. A single very talented engineer can sort of build very limited and janky prototype systems that are full-stack, but unlike in software, there is no such thing as a true full-stack REALIST engineer even at startup-scale. The span is too big. Some talented people might be able to cover it in a shallow, architectural way, in broad strokes, but actually building production systems takes a 4-high engineer totem pole.

A robot is a good example of a full-stack product on the REALIST stack. A nominal robotics team (for a real, production robot, not a hobbyist one) might include:

1. A mechanical engineer whose home level is in the physical design, dynamics, and control/stability (this is my nominal home zone according to my resume).

2. An electrical engineer whose home level is around circuit boards, wire harnesses, power management, and networking hardware design.

3. A systems software engineer working everything from the IoT level to the software-defined middleware level of low-level libraries.

4. An application engineer working roughly between the operating system and AI levels.

I’m going to both write more about the REALIST stack in the future, and reference it in other things I write on other topics, but here I just wanted to introduce the concept and workshop it a bit with you guys, since I know many of you are either engineers or otherwise in the tech or tech-curious world.

So what do you think?

And both to show off a bit, and to claim skin in the full-stack REALIST game, here’s a picture of the snazzy full-stack REALIST workshop I’ve been slowly building over the last year, mainly around the needs of a rover I’m designing (the little red 3d-printed bits on the table, and the drawing taped to the wall). Five of the seven layers are represented here, see if you can spot them.

[![](https://cdn.substack.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2F2aef430a-8242-4a91-b2be-68b9bc5f510f_4013x2068.jpeg)](https://cdn.substack.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com%2Fpublic%2Fimages%2F2aef430a-8242-4a91-b2be-68b9bc5f510f_4013x2068.jpeg)

The only things it doesn’t have yet are the tensor-based computing layer, and something to do with renewable energy, but I’m working on both. This time next year, there will hopefully be an AI-capable computer, and a solar-panel based project featured in this scene. It’s cost me a few thousand dollars so far to assemble this lab_,_ but more importantly, it’s taken about a year of time and a LOT of learning about all sorts of things.

Just the shopping alone has been a huge education in how the REALIST stack and its supply chains work, without even getting to the projects I’m trying to do. To keep myself from simply turning this into a sort of techno-shopaholism hoarding habit, I’ve also been making myself acquire at least rudimentary hello-world skills with each bit of technology before adding the next cool gadget or consumable to the workshop. So it’s been slow, but rewarding going.

You’ll notice, by the way, that the scene also features a telescope, a microscope and a pendulum clock (the wooden one on the wall, which I made from a kit). Those were the three devices that kicked off the scientific revolution in the 17th century. It was the MTC stack. The microscope, telescope, clock stack. What every cultured full-stack gentle-scientist had to master in 1687. Perhaps with the help of a butler named Alfred or Jarvis. Once I acquire a mansion where this mad-scientist lab/workshop can grow, getting such a butler is next on my list.

It’s partly a bit of a LARP, but also a sorta-serious attempt to put myself in that early-scientific-revolution headspace. In a way, that was the last time true full-stack engineer-scientists, covering the full technological range of civilization, existed.

Early scientists tended to transcend modern distinctions like theorist versus experimentalist, academic versus practitioner, and instrument-maker vs. instrument user.

I think it’s time for everybody with the means, motive, and opportunity to attempt that sort of thing again. Every engineer at least, should have an appreciative acquaintance and amateur competence across the whole REALIST stack.
