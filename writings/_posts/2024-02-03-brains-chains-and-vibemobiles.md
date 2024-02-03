---
title: Brains, Chains, and Vibemobiles
date: 2024-02-03 04:23:38.000000000 Z
layout: post-external
original_link: https://studio.ribbonfarm.com/p/brains-chains-and-vibemobiles
author: 100041
---

_This essay is part of the [Mediocre Computing](https://studio.ribbonfarm.com/p/mediocre-computing) series._

In the last year or so, I’ve noticed a steady uptick of interest in protocols that adopt one or more ideas popularized by the blockchain stack, such as Merkle trees, zero-knowledge proofs, content-centric networking, decentralized identifiers, and of course public-key cryptography, without buying fully, or at all, into the overall architectural premises of blockchains, especially token-based economics. Two good examples are [AT Protocol](https://atproto.com/) (the protocol powering Bluesky) and the promising [Noosphere](https://subconscious.substack.com/p/noosphere-a-protocol-for-thought). There is also the Bitcoin-flavored [Nostr](https://nostr.com/), which I haven’t looked into as much. I’ve started thinking of these things as “Non-Blockchain Decentralization and Cryptography” or NBDC protocols. Which rhymes nicely with CBDCs (Central Bank Digital Currencies), which are a sort of imperial blockchain-killing Deathstar technology taking shape in dark corners of various deep states. If CBDCs are an expression of state power, NBDCs are an expression of non-tokenized people power.

If you put blockchains, NBDCs, and Deep Learning AIs together, while keeping a wary eye on CBDCs, you can start to see the emerging contours of a very interesting technological landscape I’ve started thinking of as _brains, chains, and vibemobiles,_ via a rather precise analogy to the evocative title of the 1980s John Hughes comedy, _[Planes, Trains, and Automobiles](https://en.wikipedia.org/wiki/Planes,_Trains_and_Automobiles)._

I recently got into playing with Legos, so here’s a Lego sculpture tableau of the idea. The train of grey cars represents chains (obviously, blockchains by analogy to trains), the blue, yellow, and green cars represent vibemobiles (which are what NBDCs enable; I’ll get to what they are in a bit — but think the next evolutionary stage of filter bubbles), and the two random neuron-like thingies are supposed to represent AIs (brains). Specifically, the large, cloud-scale foundation models of today.

[![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F3dc8a821-96b8-4cc2-842c-bee017fe6a4a_4032x3024.jpeg)](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F3dc8a821-96b8-4cc2-842c-bee017fe6a4a_4032x3024.jpeg)

Relations between blockchain and NBDC protocols could be described as somewhat tense, but workably cordial, a bit like the relationship between railroads and trucking industries. Intermodal transporation works, and train and truck people grudgingly and warily work with each other. The users are another matter.[1](#footnote-1) People building, or building on, NBDC protocols are usually highly blockchain-savvy, and often have a history of flirtation with blockchain protocols. Their reasons from breaking away from the legacy of blockchains vary. Some find the technical constraints of blockchains limiting. Others have values-level disagreements with tokenomics-based extrastatecraft.

Most, I think, simply want to build products and services that have the simplest, lowest-friction path to broad adoption, without taking on any more technological friction than they have to. Especially friction that arises from the strong political commitments of blockchains to features like apocalypse-certified censorship resistance.

## A Brave New Balance of Power

Both blockchain and NBDC protocols belong to the same post-Web 2.0 technological epoch, and make use of a variety of computer science ideas developed in the last 30 years or so. Both kinds of protocols sharply distinguish and distance themselves from the previous generation technically and politically, including from things like the ActivityPub protocol that powers Mastodon, which despite its cosmetic resemblance to the new generation, is part of the previous generation in some fundamental ways (I’d classify the Fediverse as _late_ Web 2.0 rather than _post_ Web 2.0). The idea of governing a federated scheme of governance with instance-level codes-of-conduct, for example, is very much a 2.0 pattern that is mostly not-even-wrong for post-Web 2.0 architectures.

The post Web 2.0 generation does not have a consensus name (“Web3” tends to refer to the extended Ethereum universe, and other names haven’t caught on). It is perhaps simplest to refer to the two families of protocols as blockchain and NBDC protocols, and along with AIs, think of a three-element load-bearing balance-of-power scaffolding for the third generation of internet technology, without getting into arguments about what to call it.

I haven’t worked out the argument completely (my starting point is what I called the [mediocre computing trilemma](http://I like setting up gestalt mental models of all technologies, and this is the first satisfying one I’ve come up with (my previous attempt, the REALIST stack, covered the ground, but was conceptually clumsy and had no motivating conceptual metaphor or implied larger design scheme). Let’s go through the brains-chains-vibemobiles model in order, and set up the analogy to planes, trains, and automobiles.)), but I think each of the 3 elements is necessary, and no subset is sufficient for a stable stack. Here’s a sketch of the sufficiency argument:

- AI by itself melts everything into a temperamental, individual-identity-melting goo. Thar be Borgs _at best._

- Blockchains by themselves turn the world into a sclerotic, entropic, irreversible doomsday-device-soup of Hobbesian-Bureaucratic distrust. A Kafka-nightmare world of trials as a self-fulfilling prophecy.

- Vibemobiles (which I haven’t defined yet, I know) by themselves turn the world into a terminal scream of collective solipsistic noise shaped entirely by mutually assured destruction by intersubjectivity. Ie a culture-war-to-end-all-culture-wars endgame.

The three pairs fail in more complex ways:

- AI+vibemobiles cannot resist capture by traditional nation-states building absolute financial control Deathstars and surveillance panopticons.

- AI+blockchains point to a dystopia of impersonal and faceless interchangeable-parts humanity that’s more industrial than the industrial age.

- Blockchains+vibemobiles will not have enough intelligence in the commons to run things, and will be vulnerable to capture by corrupt cultural elites who supply executive-extractive intelligence. 

All three together _may_ allow for a quasi-stable homeostasis to emerge.

But I won’t attempt that necessity argument in this essay. So if you like, think of this essay as being about how the three _could_ work together, not necessarily how they _must_ work together. Brains-chains-vibemobiles is at least a possible world, if not a necessary one.

## Gestalt Models of Technology

The brains, chains, vibemobiles triad is an attempt at a gestalt model of history-shaping emerging technologies. Why bother with such models? What use are they? Why not just pick your favorite thread of technology and work on it, or pick your most hated thread of technology and fight it?

I personally just enjoy setting up gestalt mental models of all technologies, and this is the first satisfying one I’ve come up with for the contemporary state of technology. My previous attempt, [the REALIST stack](https://studio.ribbonfarm.com/p/the-realist-stack), covered more ground (including robotics, metaverse/VR/AR, IoT, climate and such), but was conceptually clumsy and had no motivating conceptual metaphor or implied larger design scheme. Maybe I’ll cover that larger scope with a future model.

But there is a better reason to think with gestalt models than just personal taste.

The thing is, if you’re merely a user of technology, it is both convenient and tempting to simply respond to the latest hot technology, and _only_ the latest hot technology, with either monomaniacal enthusiasm or all-consuming trepidation and resistance. If you get lucky by being in the right place at the right time, you might be on some winning side despite contributing nothing, and you don’t need to care about other technologies. You just need _one_ lottery ticket to make it. If you’re _not_ lucky in a given lottery draw, there’s no downside to attacking the latest hot thing like it is going to end your world. You have no stake. Either way, winner or loser, as a pure user you can afford to think about technology as a single thread of hottest things. You can relate to technology via a series of monomanias depending on whether you’re on the winning or losing side with each hot thing.

The techlash discourse, such as it is, tends to think about one thing at a time. So you get formulas like “all the crypto bros are now AI bros,” as critical sights shift from one target-rich tech scene to the next. This attitude towards technology is ideal for both lazy criticism and theatrical political regulation. The newest part of the evolving technology stack is usually both the most politically vulnerable part, and the one most obviously producing obscene inequities (unearned by most winners) and social costs. It is the part of the stack that is the weakest politically, features the most obnoxious new money, and has done the least to internalize externalities.

Even worse, its champions tend to be in the thrall of one variety of totalizing religious conviction or another — the lottery-winning variety of single-threaded monomania. In the last crypto boom, the phrase _bitcoin fixes this_ evolved rapidly from clownish tech-supremacist posturing, to obviously flawed technical reasoning, to punchline. In the current AI boom, the e/acc crowd is tracing out a similar trajectory from annoying to wrong to punchline.

Technologists actually working on building (not Building! or worse Buidling!) things, for better or worse, cannot afford to think in such single-threaded way. The history of technology demonstrates clearly that big revolutions tend to happen when multiple strands of loosely contemporaneous technological evolution come together in powerful ways. To take a simple example, “urbanization” was a lot of discrete emerging technologies coming together — reinforced concrete, electricity-powered elevators, and HVAC systems being the Big Three.

The phrase _planes, trains, and automobiles_ points to a similar phenomenon as urbanization, though it lacks a single name. The three technologies constitute the modern fabric of terrestrial transportation _together,_ and constitute a balance of power equilibrium_._ Add ocean shipping and fluid transport pipelines, and the five elements together constitute the material transport layer of all of technological modernity. It is difficult to think about all five things together, but at some point you have to try or you end up with a mess of totalizing capture forces. This phenomenon is hilariously illustrated in an episode of _Yes, Minister, where_ Jim Hacker is saddled with the job of “transport muggins” and tasked with formulating an integrated transport policy. His first meeting gets mired in a hopeless discourse where partisans of air, train, and road each try hard to capture the integrated policy agenda (spoiler: he gets out of the job without accomplishing any kind of integration).

That sort of satire aside, somehow, many nations muddled through in the last century and ended up with a tolerably functional assemblages of air, road, and train travel infrastructures. The point of gestalt models of technology and technology planning is not to succeed wildly and create a utopia. It is to avoid failing utterly and mediate a balance of power that doesn’t crash into dystopia. The point is a mediocre, minimum-viable equilibrium, not heaven on earth.

Integration and interaction do not mean convergence though. In fact, they form the basis for more powerful and generative _divergence,_ but I’ll leave that conceptual point for a future essay.

For now, let’s work through the brains-chains-vibemobiles gestalt technological model, and set up the analogy to planes, trains, and automobiles.

[Read more](https://studio.ribbonfarm.com/p/brains-chains-and-vibemobiles)

