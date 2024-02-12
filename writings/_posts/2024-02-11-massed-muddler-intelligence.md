---
title: Massed Muddler Intelligence
date: 2024-02-11 23:53:52.000000000 Z
layout: post-external
original_link: https://studio.ribbonfarm.com/p/massed-muddler-intelligence
author: 100041
---

_This essay is part of the [Mediocre Computing](https://studio.ribbonfarm.com/p/mediocre-computing) series._

Over the last year or two, having written perhaps a dozen essays on modern AI and having talked to dozens of people both deep within the industry and watching thoughtfully from outside, I’ve realized that my views are cohering into a set of heterodoxies that I’m increasingly comfortable with. I’ve grown increasingly confident that several things that most people think are important (loosely tied to the incumbent vision of “AGI”) are either ill-posed, irrelevant, or both. And several things that most people think are irrelevant, I think of as central. These heterodoxies won’t be surprising if you’ve been reading me for a while. They revolve around specific understandings of [embodiment](https://studio.ribbonfarm.com/p/can-robots-yearn-for-phantom-limbs), [boundary intelligence](https://studio.ribbonfarm.com/p/boundary-intelligence), [temporality](https://studio.ribbonfarm.com/p/superhistory-not-superintelligence), and [personhood](https://studio.ribbonfarm.com/p/text-is-all-you-need), and their engineering implications. Taken together, they point to an agent-based vision of how to scale AI that I’ve started calling _Massed Muddler Intelligence_ or MMI, that doesn’t look much like anything I’ve heard discussed.

MMI is my attempt to tease out the implications of my heterodox commitments and capture my views in the form of a positive vision that leads to a loose engineering prescription for scaling AI as far as it can go. In this essay, I want to begin sketching out this vision, within the limits of my technical depth (I have no illusions about being much more than an armchair philosopher, with adjacent-to-AI engineering credentials, who sometimes tinkers with the easier-to-use retail tools).

**Aside:** Speaking of talking to deep industry people, if you are a practitioner, and especially if you work in low-level ML, close to the hardware, a heads-up that might interest you: An AI hardware company that’s been my client for 3 years, TensTorrent, recently [released its first dev kits](https://tenstorrent.com/cards/), and low-level open-source software to go with them. Here’s an [Ian Cutress unboxing video](https://www.youtube.com/watch?v=WJpJkvNw9Ts) if you want to learn more. Consider snagging one of the kits if you want to get in early on what I think will be a very important line of hardware/software evolution in AI. I’ve worked with the CEO, Jim Keller, for over a decade, and this latest adventure with him has been one of the most exciting in my consulting career. **Disclaimer** : Obviously, views in this essay (and other AI-themed essays I’ve written, or might write) are my own, not those of my client etc.

Back to MMIs. While the heterodoxies that motivate MMIs aren’t burn-him-at-the-stake firebrand heresies, I certainly used to think I was rather alone in harboring them, fighting some sort of lonely battle against prevailing orthodoxies. But one of the surprising things I’ve discovered is that they’re actually quite widespread. They’re just not commonly acknowledged. For example, in a DM chat with Emmett Shear (who was briefly CEO of OpenAI for a hot minute a few months ago), whom I had previously put firmly in the “orthodoxy” box, I was genuinely surprised to discover that he agreed with a lot of my fundamental premises, like the importance of boundary intelligence, embodiment, and “artificial caring” (which I haven’t yet written about). I think he’s still basically orthodox (for me the “tell” of that is orbiting the “AGI+alignment” frame), but the spectrum between us is fuzzier and fuller of philosophically tenable positions than I expected. Another data point: At a AI talk I did at a Salesforce corporate event last month, I was again surprised to find that a lot of talking points I had prepared, which I thought would be a bit controversial, turned out not to be. People in the fairly technical audience seemed comfortable entertaining them. They were merely somewhat unfamiliar thoughts, not threatening ones.

I think the reason it’s been difficult for these apparently commonly held (or at least, easily entertained) heterodoxies to find traction is that people usually air them in the form of philosophical criticisms of orthodoxy. At best, you get competing frames for understanding what’s going on (perception refactorings) which don’t lead to ideas for _doing_ anything differently at an engineering level.

I’m as guilty as any other armchair AI philosopher (and we’re all AI philosophers now). Is AI “superhistory” rather than “superintelligence”? Is it a “camera” rather than an “engine”? Is it a “discovery” rather than an “invention”?[1](#footnote-1)

_Who cares?_

Clever reframes have been a dime a dozen in the last year. But if it doesn’t lead to doing anything different at any engineering level, it doesn’t matter. It’s all just grist for the AI culture war mills. Inconsequential ideas for alignment cultists, accelerationists, and the hundred other smaller sects to argue about.

None of it matters if the technology options remain the same. And right now there’s only one option: _monolithic scaling._ Larger and larger models trained on larger and larger piles of compute and data. Everything _else_ happening in AI is at the level of cute art projects at best, on the periphery of this basic drive to brute scaling.

The soup of heterodoxies hasn’t yet cohered into a common knowledge discourse yet not because there is an evil conspiracy to suppress it, but because there is no alternative technological vision for it to cohere _around_. All the narrative warfare orbits the _same_ monolithic scaling technological vision. And that vision is controlled by so few people, larger patterns of narrative sentiment don’t matter. The varying flavors of doom and exhilaration, optimism and pessimism, all revolve around a single vision of the technological future that is proceeding essentially on autopilot, with a handful of supervising humans who subscribe to specific engineering ideas about how to scale AI. A future that in my opinion cannot continue unfolding as it has for _engineering_ reasons, whether you want to realize it or stop it. In other words, monolithic scaling is doomed. It is headed towards _technical_ failure at a certain scale we are fast approaching. So the political-cultural discourse and narrative competition around it is largely moot.

To keep AI evolving, we need the various heterodoxies to cohere into one or more _alternative_ positive visions of how to build the technology itself, not just creative reframes that make for stimulating cocktail party conversations. Into one or more new idea of what _sort_ of AI we _should_ attempt to built, in an engineering rather than ethical sense[2](#footnote-2) of _should._ As in well-posed, architecturally sound, and conceptually elegant enough to handle whatever we choose to throw at it.

I’m asking the question in the same sense as one might ask, how _should_ we attempt to build 2,500 foot skyscrapers? With brick and mortar or reinforced concrete? The answer is clearly reinforced concrete. Brick and mortar construction simply does not scale to those heights. Culture wars in architecture and urbanism around whether or not skyscrapers are a good idea for society are moot unless you have good options for actually building them.

We can have different debates about whether we should or should not build it (I of course think we should), but at least the debates will be around more technologically plausible visions than the monolithic scaling one we have today.

## Non-Monolithic AI Scaling

The construction metaphor actually applies rather precisely to AI. One of the (technical) orthodoxies I do agree with is that _scaling_ AI as much as we can is currently the most interesting and fruitful engineering challenge to pursue right now. I just don’t think _monolithic_ scaling is the way to get there.

I didn’t believe scaling was particularly important a couple of years ago. I was more interested in small-scale “edge” intelligence. But I’ve been persuaded by both developments on the ground, and the arguments of the technical people I talk to that scaling is and should be the primary engineering concern. In fact, other challenges — like small-scale edge intelligences and my personal favorite, embodiment as in robotics — get _more_ interesting and fruitful in the context of rapid, effective scaling.

But I also think current monolithic approaches to scaling AI are the equivalent of brick-and-mortar construction and fundamentally doomed.

The current idea seems to be: If we build AI datacenters that are 10x or 100x the scale of todays (as Sam Altman appears to want to), and train GPT-style models on them that are also correspondingly scaled up, we’ll get to the most interesting sorts of AI. This is like trying to build the Burj Khalifa out of brick-and-mortar. It’s a fundamentally unsound idea. Problems of data movement and memory management at scale that are _already_ cripplingly hard will become insurmountable. Just as the very idea of a 2,500 foot high brick structure is unsound because bricks don’t have the right structural properties, the current “bricks” of modern AI (to a first approximation, the “naked” Large X Models thinly wrapped in application logic) are the wrong ones.

To be fair, from what I see in the news, it does seem like “monolithic” is perhaps a caricature of current scaling strategies. There is definitely some sophisticated thinking going on to divide-and-conquer in various ways. But it’s still in the brick-and-mortars idiom.

We need new building blocks; new “bricks.” We need the equivalent of a reinforced concrete beam for AI.

Enter _another_ element of orthodoxy that I agree with: _agents_ matter.

Most people I talk to agree that working towards more “agentic” AIs is also an interesting and fruitful engineering challenge to pursue now.

My reasons for agreeing are not the normal ones. Yes, agents are interesting for closing the loop with real time actions in the real world, autonomous behavior, sociality, and so on. But those sound like “extra features” we would like to have tacked on today’s naked LxMs. While I for one would like those extra features, the main reason to pursue a distributed _agent_-based vision of modern AI is that this is the scaling solution we need. Agents are the reinforced concrete of AI. We’ve gone as far as monolithic scaling can take us. Agents are how we scale in non-monolithic ways.

Specifically, a particular sort of agent I’ll describe called _muddler_ agents. To be contrasted with what I’ll call _godding agents._ The name is inspired by one of my favorite papers, _[The Science of Muddling Through](https://www.jstor.org/stable/973677)_ by Charles E. Lindblom. I’ll explain both terms in a bit, but first a slight detour on scaling principles in biology.

## Scaling Precedents from Biology

There’s a precedent here in biology. Biological intelligence scales better with more agent-like organisms. For example: humans build organizations that are smarter than any individual, if you measure by complexity of outcomes, and also smarter than the scaling achieved by less agentic eusocial organisms.

[Sheep intelligence](https://www.epsilontheory.com/sheep-logic/) for example, is quite high, but is strongly mimetic and not very agentic (which is why we use “sheeple” as a slur when humans act in more mimetic than agentic ways).

Insect swarm intelligence is impressive not because of what it achieves in an absolute sense, but because the building blocks are pre-programmed automatons with little more than simple firmware agency for behaviors like pheromone trail-following. We are less impressed by what ants and bees _do_ than by the mechanical intricacy with which anthills and beehives are put together out of such simple parts. We’re less impressed with the fact that bees can communicate directions to food sources with dance (because we have bigger brains, we can just point with fingers) than the fact that they can “point” at all with their limited firmware (pointing is one of the most cognitively sophisticated behaviors the way _we_ do it).

But ants, bees, and sheep cannot build complex planet-scale civilizations. It takes much more sophisticated agent-like units to do that.

Loosely speaking, agents (I’m not going to qualify with the usual long list of qualifiers usually applied — _social_, _autonomous_, _distributed_ and so on — take them as implied) are AIs that can make up independent intentions and pursue them in the real world, in real time, in a society of similarly capable agents (ie in a condition of _[mutualism](https://studio.ribbonfarm.com/p/mutualism)_), without being prompted. They don’t sit around outside of time, reacting to “prompts” with oracular authority.

This doesn’t mean they are necessarily ungovernable or immune to influence. In fact, their ability to scale better than simple insect-like automatons or sheep-like mimetic agents _depends_ on their amenability to governance and mutual influence. You can’t go from individual agents to massed systems of agents without such amenability. They merely have to be governed and influenced from the “outside” as it were, through social and informational mechanisms, the way we humans (and other eusocial mammals) influence each other. A corollary here is that agents that are more ungovernable or immune to influence will be _scale-limited_, which is a helpful safety-engineering affordance (mnemonic mental model: think _ostracizing a bad actor_ rather than _lobotomizing an unruly model_ as the primary safety-engineering move).

And as in sociobiology, sustainably scalable AI agents will necessarily have the ability to govern and influence other agents (human or AI) in turn, through the same symmetric mechanisms that are used to govern and influence them.

_If you want to scale AI sustainably, governance and influence cannot be one way street from some privileged agents (humans) to other less privileged agents (AIs)._

If you want complexity and scaling, you cannot govern and influence a sophisticated agent without opening yourself up to being governed and influenced back. The reasoning here is similar to why liberal democracies generally scale human intelligence far better than autocracies. The MMI vision I’m going to outline could be considered “liberal democracy for mixed human-AI agent systems.” Rather than the autocratic idea of “alignment” associated with “AGI,” MMIs will call for something like the emergent mutualist harmony that characterizes functional liberal democracies. You don’t need an “alignment” theory. You need social contract theory.

With that political science/biology preamble out of the way, we can discuss the specifics of the specific sort of agent I’m proposing as a building block: muddler agents.

## The Road to Muddledom

Agents, and the distributed multiagent systems (MAS) that represent the corresponding scaling model, obviously aren’t a new idea in AI. To understand muddler agents and MMIs, it’s useful to quickly review this history and ask how it can be brought into the modern era of LxMs.

As far back as the origins of AI, Marvin Minsky offered his “Society of Mind” model of AI (comprising small, simple agents that were really just single behavior loops). When I was in grad school, the one graduate course in AI I took (taught by Ed Durfee at the University of Michigan) was on distributed multiagent systems approaches. There was even a nice (now rather obsolete but still useful) text for the approach, [Multiagent Systems: A Modern Approach to Distributed Artificial Intelligence](https://www.amazon.com/Multiagent-Systems-Distributed-Artificial-Intelligence/dp/0262731312) (edited by Gerhard Weiss, appropriately featuring multiple authors) that I personally found far more useful for my research than the better-known Russell-Norvig monolithic AI text. There were also various strands of popular research about swarm intelligence and so on. All my own academic research (~2000-2006) was about distributed multiagent systems (approached from a mixed control-theoretic/GOFAI/OR angle).

A good, if rather fraught way to appreciate the distinction between monolithic and distributed AI (whether we’re talking GOFAI or Modern AI eras) is by analogy to the difference between procedural and object-oriented programming. Yes, with _all_ the baggage that analogy suggests. All the wisdom and criticism around the weaknesses of OO methodologies that has emerged in the last few decades will apply.

In fact, it’s more than an analogy, since early MAS were often built as light architectural extensions of early object-oriented non-AI systems. A bit of revealing lore: MAS researchers in the 90s used to say, “objects do it for free, agents do it for money.”

Back then, the most common approach to integrating individual GOFAI agents into a MAS was a mix of virtual economics and structured communication/contracting semantics that were a natural extension to the interface models of object-oriented architectures (a “planning and reasoning” agent might talk to a “scheduling” agent in a structured way for example). This element, of course, naturally lends itself to modernization using things like blockchains, tokenomics, and smart contracts (an idea some friends and I are exploring in a robotics context), but we need more than that to accommodate the deep learning models of modern AI.

My idea of muddler agents fits loosely within the MAS tradition, but attempts to make the leap from the GOFAI age to the modern AI age by dropping some old principles and adding some new ones. Muddler agents, built around LxMs, compose into larger distributed collectives in a very different way than GOFAI agents do, so architectural doctrines have to respect that.

To give you a slight taste of the differences, back in the 1990s, Michael Bratman’s Belief-Desire-Intention (BDI) model was very influential in GOFAI, and both the monolithic AI and distributed AI people took cues from it. There were interesting papers on “Joint Intentions,” and we had interesting debates about how to bootstrap from mutual belief to common knowledge without dealing with infinite recursions (“common knowledge” can be understood as _I know you know I know you know…_ belief state that continues _ad infinitum_). BDI (along with several related ideas from the philosophy of language) was a big idea for constructing the structured coordination scaffolding for GOFAI MAS.

The problem is, I don’t think _any_ of this machinery works or is even particularly relevant for the problem of scaling _modern_ AI, where the core source of computational intelligence is a large-X-model with fundamentally inscrutable input-output behavior. This is a new, oozy kind of intelligence we are building with for the first time. In my opinion, you can’t agentify and scale it with BDI type architectures. We’re in new regimes, dealing with fundamentally new building materials and aiming for new scales (orders of magnitude larger than anything imagined in the 1990s).

Modern AI agents that work won’t traffic in clean-edged abstractions inherited from philosophers. They can’t have exoskeletons built out of elegant formalisms like BDI. That would yoke the power of things like LLMs to much less powerful things. If there are skeletal structures at all (and I think there have to be; ooze doesn’t scale), they’re going to be on the inside; endoskeletons.

The innards of modern AI agents (behind soft, penetrable skins rather than exoskeletons) are obviously going to be large (but not _largest_) trained models of some sort that produce behaviors that we might _interpret_ in terms of BDI or other useful frames, but aren’t architected to _express_ those frames or _conform_ to them. Just as economists might _interpret_ human behaviors through the lens of market incentives, but human biology isn’t an expression of textbook economics.

While AI agents might inhabit hard-edged low-level coordination protocols (with or without cryptography, blockchains and tokens) to achieve the “agents do it for money” property (the way humans use money), they won’t get to things like high-level coordination patterns through formal structures. Instead, they’ll rely on analogues to the “soft” meta layers of human coordination, like natural language discourses, narrative, culture and so on. We don’t yet know what “natural” language will look like for modern AI agents chattering away on their future protocol pipes, let alone mixed human-AI agent systems, but I am pretty confident it won’t look high-modernist and formalist the way non-AI computer chatter does. But it won’t look like human natural language either.

The associated core architectural principles won’t look like the “axioms” of a formal BDI-type model with verifiable properties. They’ll look more like opinionated cultural commitments, or _doctrines._

These doctrines will address the obvious questions about modern AI agents. With particular reference to my idea of muddling agents, these are:

1. Why do we want to build muddling agents and what advantages do they have over godding agents? 

2. How do they compose with each other and how do they scale? 

3. How do they act like “reinforced concrete” and how do they scale differently from monolithic models?

4. How do you regulate MMIs?

## Muddling Doctrines

How do you build muddler agents? I don’t have a blueprint obviously, but here are four loose architectural doctrines, based on the four heterodoxies I opened with: [embodiment](https://studio.ribbonfarm.com/p/can-robots-yearn-for-phantom-limbs), [boundary intelligence](https://studio.ribbonfarm.com/p/boundary-intelligence), [temporality](https://studio.ribbonfarm.com/p/superhistory-not-superintelligence), and [personhood](https://studio.ribbonfarm.com/p/text-is-all-you-need).

1. _ **Embodiment matters** :_ The physical form factor AI takes is highly relevant to to its nature, behavior, and scaling potential. 

2. _ **Boundary intelligence matters**._ Past a threshold, intelligence is a function of the management of boundaries across which data flows, not the sophistication of the interiors where it is processed.

3. _ **Temporality matters** :_ The kind of time experienced by an AI matters for how it can scale sustainably.

4. _ **Personhood matters** :_ The attributes of an AI that enable humans and AIs to relate to each other as _persons_ (I-you), rather than _things_ (I-it)_,_ are necessary elements to being able to construct coherent scalably composable agents at all.

I made a Venn diagram of these 4 doctrines and attempted to plot how current themes and concerns fit on it, as well as identify _new_ concerns and themes that aren’t getting enough engineering attention. Since you can’t represent all possible intersections of 4 circles in 2d, I’ve had to add a couple of side diagrams to represent the two pairwise intersections that can’t be represented on the main diagram.

[![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5fefa430-55bf-46a5-8429-02cdc7d4166b_1928x1444.png)](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F5fefa430-55bf-46a5-8429-02cdc7d4166b_1928x1444.png)

I’ll leave a detailed walkthrough of the Venn diagram to a future essay, but for now I want to indicate the motivating logic.

The first three principles can be considered a loose, AI-specific restatement of [Landeur’s Principle](https://en.wikipedia.org/wiki/Landauer%27s_principle). The physicality of computation in general, and AI computation in particular, is consequential and must be both respected and leveraged to build powerful AIs that scale well. AIs must inhabit real atoms, live in real time, and deal with the second law of thermodynamics. And these facts have to matter architecturally.

A primary engineering implication is that _these three axioms are about designing the informational surface area of agents in space-time in a way that the scaling behavior when we compose them is stable and sustainable to the same degree the underlying hardware is_.

The surface area is the real-time data-exchange boundary with the environment. This necessarily evolves differently from the interior as we scale, so the volume/area ratio (interior intelligence/boundary intelligence ratio) must be managed so it doesn’t get too high. The intuition here is similar to the one complex systems people think about in biology. There is a reason elephants are almost spherical while gazelles are rather svelte: the interaction of gravity and geometry/topology. I don’t know what the corresponding scaling principles of AI are, but I do think the equivalent of “gravity” is the “weight of noisily evolving unmodeled reality” and that the surface exposed to _real-time_ data exchange must increase.

The fourth heterodoxy turns personhood, generally considered something of a cosmetic element (part of the “UX” of modern AIs), into a load-bearing architectural element in getting to scaled AI via muddler agents. You cannot have scaled AI without agency, and you cannot have a scalable sort of agency without personhood.

Personhood is _not_ about cosmetic matters like whether an AI uses a male or female synthesized human voice, or whether or not it swears or says racist things. It’s about how communication scales across building blocks as they increase in number and the spatio-temporal scale of the aggregate.

Here too, biological scaling tells us why this is important. Ants communicate in biochemical ways similar to how our primate bodies communicate internally. So as Douglas Hofstadter pointed out long ago, this makes ant swarms almost a single organism as far as intelligence is concerned. Individual ants are barely individuals. But this doesn’t scale. By the time we get to mammals, the communication between building blocks has become much more abstract. We use language. Other higher animals also use fairly abstract schemes of signaling. There is a two-fold advantage here: We use signaling pathways that are generally higher bandwidth (in terms of bits transmitted per units of energy/matter used) and also more _programmable._ An ant depositing a pheromone trail is communicating something very hardcoded. It is almost laying down transient firmware, in the form of PCB traces that form a temporary simple circuit board around a food source. A human talking is doing something very different.

As we go up the scale of biological complexity, we get much programmable and flexible forms of communication and coordination. One result is that the mass gets less monolithic, and starts acquiring a looser, more flexible structure within which we can start to distinguish individuals by their stable “personalities” (informationally, the identifiable signature of personhood). We go from army ants marching in death spirals to murmurations of starlings to formations of geese to wolf packs maneuvering tactically in pincer movements… to humans whose most sophisticated coordination patterns are so complex merely _deciphering_ them stresses our intelligence to the limit (of course, we march in death spirals too; a high ceiling does not imply a high floor).

What’s going on here is a behavioral analogue to structural scaling.

Biology doesn’t scale to larger animals by making very large unicellular creatures. Instead it shifts to a multi-cellular strategy. Then it goes further: from simple reproduction of “mass produced” cells to specialized cells forming differentiated structures (tissues) via ontogeny (and later, in some mammals, through neoteny). Agents that scale well have to be _complex and variegated_ agents _internally_, to achieve highly _expressive and varied_ behaviors _externally._ But they must _also_ present simplified facades — personas — to each other to enable the scaling and coordination.

Setting aside questions of philosophy (identity, consciousness), _personhood is a scaling strategy._ Personhood is the behavioral equivalent of a cell. “Persons” are stable behavioral units that can compose in “multicellular” ways because they communicate differently than simpler agents with weak or non-existent personal boundaries, and low-agency organisms like plants and insects.

A subtler way of putting it using concepts I’ve introduced recently from a protocols perspective — _personhood is a source of [hardness](https://studio.ribbonfarm.com/p/in-search-of-hardness) in intelligence scaling._

When we form and perform “personas,” we offer a harder interface around our squishy interior psyches that composes well with the interfaces of other persons for scaling purposes. _A personhood performance is something like a composability API for intelligence scaling._

## Beyond Training Determinism

_Time_ is perhaps the most important unifying element in this overall scheme, and I’ll have a lot more to say about it this year. Right now AIs experience most of their “time” during training, and then effectively enter a kind of stasis. They experience a thousand years in a few months, and then live at a much slower rate than reality evolves in deployment, falling increasingly further behind. They requiring versioned “updates” to get caught up again.

GPT4 can’t simply grow or evolve its way to GPT5 by living life and learning from it. It needs to go through the human-assisted birth/death (or regeneration perhaps) singularity of a whole new training effort. And it’s not obvious how to automate this bottleneck in either a Darwinian or Lamarckian way.

This is not discussed enough: For all their power, _modern AIs are still not able to live in real time and keep up with reality without human assistance outside of extremely controlled and stable environments._

Refinement training has limited effects, and additional data ingested during inference (RAG, or Retrieval Augmented Generation is a new buzzword you may have heard about a lot) cannot easily be integrated into the base model. A biological analogy — this is like organisms that have an almost entirely genetics-determined nature, with near zero programming-by-nurture, either in the form of varied kinds of gene expression during ontogenic development, or learning in an independent _post-partum_ existence with a high individual information surface area (note: a fetus in a womb has no independent informational boundary distinct from its mother, even though it fights the mother for resources like an independent agent).

As far as temporality is concerned, we are in a “training determinism” regime that is very un-agentic and corresponds to genetic determinism in biology.

What makes agents _agents_ is that they live in _real time,_ in a feedback loop with external reality unfolding at its actual pace of evolution. Things like goals and autonomy come much later, if at all (and as I’ll argue, they aren’t actually central to agency; they are almost cosmetic conveniences).

## Muddling Through vs. Godding Through

We’re finally ready to talk about muddling.

_Muddler agent_ points to a specific understanding of how agency works, in an engineering sense, and trying to realize that in a design.

[Lindblom’s paper](https://www.jstor.org/stable/973677) identifies two patterns of agentic behavior, “root” (or _rational-comprehensive_) and “branch” (or _successive limited comparisons_)_,_ and argues that in complicated messy circumstances requiring coordinated action at scale, the way actually effective humans operate is the branch method, which looks like “muddling through” but gradually gets there, where the root method fails entirely. _Complex_ here is things humans typically do in larger groups, like designing and implementing complex governance policies or undertaking complex engineering projects. The threshold for “complex” is roughly where explicit coordination protocols become necessary scaffolding. This often coincides with the threshold where reality gets too big to hold in one human head.

As the word _limited_ suggests, the branch method respects limits, including the rationality limits of humans, but more importantly, _limits imposed by imperfect knowledge and the temporality of data availability,_ which apply to AIs as well. Muddling through is local trial-and-error that does a gradient search in a solution space of a complex problem by successive comparisons. Like any local, bounded rational, and bounded _information_ approach, it can obviously get trapped in local extrema, and requires injection of noise and perturbations to break out. The “muddling” is a result of these limits and the inevitable clumsiness needed to break past them.

Here’s an easy way to remember this point: _You can’t train your way out of experimentation needs no matter how smart you are._

The knowledge input to the training required to live in real time and keep up with reality _must_ be produced by experimentation. By definition, it is not present in the fossil fuel that is historical data. Twist: where strong theories are available, sometimes you can _partially_ simulate your way out of experimentation needs. Grand Theft Auto and video footage from live driving can _partially_ address the training needs of a self-driving car. But your autopilot must still be capable of muddling behaviors.

The root method attempts to fight limitations with brute, monolithic force. It aims to absorb _all_ the relevant information regarding the circumstances _a priori_ (analogous to training determinism), and discover the globally optimal solution through “rational” and “comprehensive” thinking. If the branch method is “muddling through,” we might say that the root, or rational-comprehensive approach, is an attempt to “god through.”

Lindblom’s thesis is basically that muddling through eats godding through for lunch.

To put it much more bluntly: _Godding through doesn’t work at all beyond small scales and it’s not because the brains are too small_. Reasoning backwards from complex goals in the context of an existing complex system evolving in real time doesn’t work. You have to _discover_ _forwards_ (not _reason_ forwards) by muddling. Any visible elements of working backwards from goals are some mix of cosmetic ritual motivational elements and speculative coarse waypoint plans (in classical AI planning, usually a mix of forward state-space and regression planning is used, but I’m talking about much messier open-world domains than the blocksworld++ domains classical AI planning usually deals with; domains where “planning” as such has a much smaller role to play than fuck-around-and-find-out experimentation).

Now, in thinking about _humans,_ it is obvious that Lindblom was right. We keep rediscovering this lesson in new historical contexts… and also keep getting seduced by root/godding approaches in new guises. For example, waterfall versus agile in software development is basically branch-vs-root, godding-vs-muddling. James Scott’s critique of authoritarian high modernist planning versus illegible realities is basically branch-vs-root, godding-vs-muddling. I suspect this was around in paleolithic times too.

Even where godding through apparently prevails through brute force up to some scale, the costs are very high, and often those who pay the costs don’t survive to complain… and the system doesn’t last long enough for the victors to reap the benefits either. Nobody wins, and losses happen on time scales that matter.

Fear of Big Blundering Gods is the essential worry of traditional AI safety theology, but as I’ve been arguing since 2012 (see [Hacking the Non-Disposable Planet](https://www.ribbonfarm.com/2012/04/18/hacking-the-non-disposable-planet/)), this is not an issue because these BBGs will collapse under their own weight long before they get big enough for such collapses to be exceptionally, existentially dangerous. This worry is similar to the worry that a 2,500 foot brick-and-mortar building might collapse and kill everybody in the city.

It’s not a problem because you can’t build a brick-and-mortar building to that height. You need reinforced concrete. And that gets you into entirely different sorts of safety concerns.

## Protocols for Massed Muddling

How do you go from individual agents (AI or human) muddling through to masses of them muddling through together? What are the protocols of massed muddling? These are also the protocols of AI scaling towards MMIs (and yes, I’m using the word deliberately because protocols are what I think we need here; that they are also my favorite hammers looking for nails right now is a bonus).

Muddler agents that reflect the priorities of the Venn diagram, and operate by “muddling through,” are fundamentally more capable than automatons or other form factors. But they’re also fundamentally harder to compose. The induce richer grammars.

When you put a lot of them together using a mix of hard coordination protocols (including virtual-economic ones) and softer cultural protocols, you get a massed muddler intelligence, or MMI. Market economies and liberal democracies are loose, low-bandwidth examples of MMIs that use humans and mostly non-AI computers to scale muddler intelligence. The challenge now is to build far denser, higher bandwidth ones using modern AI agents.

Why _massed?_ Why not an adjective that indicates more deliberation?

Because I suspect at the scales we are talking about, we will have something that looks more like a market economy than like the internal command-economy structure of the human body. Both feature a lot of hierarchical structure and differentiation, but the former is much less planned, and more a result of emergent patterns of agglomeration around environmental circumstances (think how the large metros that anchor the global economy form around the natural geography of the planet, rather than how major organ systems of the human body are put together).

While I suspect MMIs will _partly_ emerge via choreographed ontogenic roadmaps from a clump of “stem cells” (is that perhaps what LxMs are??), the way market economies emerge from nationalist industrial policies, overall the emergent intelligences will be masses of muddling rather than coherent artificial leviathans. Scaling “plans” will help launch, but not determine the nature of MMIs or their internal operating protocols at scale. Just like tax breaks and tariffs might help launch a market economy but not determine the sophistication of the economy that emerges or the transactional patterns that coordinate it. This also answers the regulation question: Regulating modern AI MMIs will look like economic regulation, not technology regulation.

How the agentic nature of the individual muddler agent building block is preserved and protected is the critical piece of the puzzle, just as individual economic rights (such as property rights, contracting regimes) are the critical piece in the design of “free” markets. There are two elements.

The first element is the uncertainties induced by muddling as a fundamental behavioral disposition. Muddling produces a shell of behavioral uncertainty around what a muddler agent will _do_, and how it will react to new information, that creates an outward pressure on the compressive forces created by the dense aggregation required for scaling. This is something like the electron degeneracy pressure that resists the collapse of stars under their own gravity. Or how the individualist streak in even the most dedicated communist human resists the collapse of even the most powerful cults into pure hive minds. Or how exit/voice dynamics resist the compression forces of unaccountable organizational management.

The second element is the fundamental intentional tendency of individual agents, on which all other tendencies, autonomous or not, socially influencable or not, rest. This is the center of the Venn diagram, which I have labeled _body envelope integrity._

This is a familiar concern for biological organisms. Defending against your body being violently penetrated is probably the foundation of our entire personality. It’s the foundation of our personal safety priorities — don’t get stabbed, shot, bitten, clawed or raped. All politics and economics is an extension of envelope integrity preservation instincts. For example, strictures against _theft_ (especially _identity_ theft) are about protecting the body envelope integrity of your economic body. _Habeas corpus_ is the bedrock of modern political systems for a reason. Your physical body is your political body.

Why is this such a central concern? _Because if you don’t have body envelope integrity you have nothing._

This is easiest to appreciate in one very visceral and vivid form of MMIs: distributed robot systems. Robots, like biological organisms, have an actual physical body envelope (though unlike biological organisms they can have high-bandwidth near-field telepathy). They must preserve the integrity of that envelope as a first order of business (though doing so is the imperative captured by Asimov’s _second_ law, which is interesting). But robot MMIs are not the only possible form factor. We can think of purely software agents that live in an AI datacenter, and maintain boundaries and personhood envelopes that are primarily informational rather than physical. The same fundamental drive applies. The integrity of the (virtual) body envelope is the first concern.

This is why embodiment is an axiomatic concern. The nature of the integrity problem depends on the nature of the embodiment. A robot can run away from danger. A software muddler agent in a shared memory space within a large datacenter must rely on memory protection, encryption, and other non-spatial affordances of computing environments.

Personhood is the emergent result of successfully solving the body-envelope-integrity problem over time, allowing an agent to present a coherent and _hard_ mask model to other agents even in unpredictable environments. This is not about putting a smiley-faced RLHF mask on a shoggoth interior to superficially “align” it. This is about offering a predictable API for other agents to reliably interface with, so scaled structures in time and social space don’t collapse. That’s why _[hardness](https://studio.ribbonfarm.com/p/in-search-of-hardness) management_ is on the Venn diagram — hardness is the property or quality that allows agents with soft and squishy interiors to offer hard and unyielding interfaces to other agents, allowing for coordination at scale.

These are just light indications of where I’m going with the MMI vision. I’m going to write a detailed follow up unpacking the Venn diagram, but for now, let me leave you with a pair of gestalt mental models, one for engineers, one for everybody.

For engineers. Extending the objects: agents analogy, MMIs are to AI what Service-Oriented Architecture is to traditional computing. There are analogues to concepts like microservices, polyglot persistence, containers, orchestration, APIs, and so on. And there are strengths and weaknesses corresponding to those that have become familiar in SOA over the last decade.

For everybody. We can go back to the analogy to reinforced concrete. MMIs are fundamentally built out of _composite_ materials that combine the constituent simple materials in very deliberate ways to achieve particular properties. Reinforced concrete achieves this by combining rebar and cement in particular geometries. The result is a flexible language of differentiated forms (not just cuboidal beams) with a defined grammar.

MMIs will achieve this by combining embodiment, boundary management, temporality, and personhood elements in very deliberate ways, to create a similar language of differentiated forms that interact with a defined grammar.

And then we can have a whole new culture war about whether that’s a good thing.

[1](#footnote-anchor-1)

I’m pretty sure I was the first to come up with this particular framing, but Jeff Bezos referenced it in a podcast a week later, and I’ve been wondering ever since if he got it from me 🤔

[2](#footnote-anchor-2)

AI ethics as currently construed is one of the things I’m now confident is almost entirely ill-posed and irrelevant.

