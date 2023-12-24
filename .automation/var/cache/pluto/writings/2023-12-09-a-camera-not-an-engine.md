---
title: A Camera, Not an Engine
date: 2023-12-09 02:46:53.000000000 Z
layout: post-external
original_link: https://studio.ribbonfarm.com/p/a-camera-not-an-engine
author: 100041
---

_This essay is part of the [Mediocre Computing](https://studio.ribbonfarm.com/p/mediocre-computing) series_

Time magazine named Taylor Swift person of the year, and at least [one CNN writer](https://www.cnn.com/2023/12/08/opinions/sam-altman-taylor-swift-time-2023-person-thomas/index.html) thinks (and I suspect many agree) it should have been Sam Altman. I personally think it should have been “AI” itself, the way “PC” was the machine of the year in 1982.

Except “machine” seems like a not-even-wrong way of thinking about what modern AI is. Unlike [GOFAI](https://en.wikipedia.org/wiki/GOFAI) (“Good Old-Fashioned AI”), modern AI doesn’t seem like an invention at all, let alone one embodied by the behavior of a “machine.” The word we’re looking for is _discovery._ To the extent things like racks full of GPUs and PyTorch shuffling data around constitute a “machine” in the picture, they are like the Webb telescope; instruments of discovery rather than engines of production. “Machines” that let us peer incredibly deeply into extraordinarily large piles of data. “Large XYZ Models” are much closer to the image processing pipeline that is attached to the output of the Webb telescope than to models in the sense of CAD files.

Any magic in the output is a strong function of magic in the input, not the processing. The Webb telescope doesn’t manufacture those amazing pictures. It _sees_ them “out there.” In infrared. All the associated image processing adds is a kind of hallucinatory false coloring to bring them into our visual range.

If it sounds like I’m setting up a “data camera” mental model for AI, it’s because I am. But as you’ll see, that makes what’s going on _more_ interesting, not less. _Unlike_ traditional photography, which killed a whole world of tedious photorealistic painting, but _like_ the Webb telescope, “data photography” reveals worlds within worlds we’ve never even suspected existed, let alone been able to see, in piles of data too large for us to ever hold in our heads.

This is what the stochastic-parrot takes (and the older monkeys-at-typewriters take) entirely miss. We’re all stochastic parrots attached to monkeys on typewriters all the way down. That’s only insulting if you don’t like parrots and monkeys and imagine you possess some ineffably higher-order consciousness their kinds of minds cannot embody.

The fascinating thing is, parrots and monkeys are all you need. _That’s all it seems to take to produce anything we consider intelligent behavior, and we’ve barely begun to scratch the surface of that behavior space, which is far vaster than we imagined._

The title of this essay inverts the title of a book about economics by Donald Mackenzie, _[An Engine Not a Camera](https://mitpress.mit.edu/9780262633673/an-engine-not-a-camera/)._ The premise of that book is that economics theories are engines that produce (via policies and institutions) economic behaviors, but trick us into thinking they merely _describe_ them. Modern AI has the reverse problem. It’s a camera that tricks us into thinking it’s an engine that “generates” rather than “sees” things. As an aside, this weird symmetry makes me suspect that economics and modern AI are true duals of some sort — maybe the way to get to AI with agency is to bolt on an economics theory.

So modern AI (I’m personally deprecating the terms deep learning and machine learning[1](#footnote-1)) is a _discovery,_ and in this essay, I want to try and unpack its discovery-like qualities. I also want to try and unpack the camera-like inhuman observational capabilities of the instruments (GPUs and the simple code they run) that helped us make this discovery_._ It seems too big to be called discovery of the _year,_ but enough crazy related stuff is in the pipeline (quantum computing, programmable cryptography) and has happened in the past few decades (blockchains, internet, computability theory, information theory…) that a century seems too long. So I’ll call it discovery of the decade.

## Seeing Computational Reality

If you ignore the anthropocentric narratives and the accidental provenance in GOFAI, modern AI fits very naturally within a connected series of discoveries about _computational reality,_ which I’ll define as existing between objective and subjective realities.

The trajectory of discovery began with Shannon and Turing (or perhaps even earlier with Leibniz) and now, 75 years later, is really gathering steam. If Leibniz’s original “stepped reckoner” was the equivalent of Galileo’s telescope, modern AI is like the James Webb Space Telescope. Each conceptual advance helped us see more deeply into computational reality.

Take these 10 things together:

1. Whatever the hell [Leibniz was thinking about](https://en.wikipedia.org/wiki/Calculus_ratiocinator)

2. Information theory

3. Computability theory (Turing)

4. Cellular automata

5. Computational complexity theory[2](#footnote-2)

6. Fractal geometry

7. Asymmetric cryptography[3](#footnote-3)

8. Modern AI mechanisms[4](#footnote-4)

9. Programmable cryptography[5](#footnote-5)

10. Quantum computing

Do these phenomena, and our inexorable and _natural-_seeming trajectory of discovery through them, _really_ look like they’re uniquely about random lumps of biological matter that happened to evolve on one mostly harmless speck of dust? Do they look like “inventions”? Do they look like they belong in the family tree that starts with steam engines?

You will note that I’ve left GOFAI[6](#footnote-6) and even GPUs off the list, along with much of the history of physical computers from Babbage’s Difference Engine to the the iPhone. Those do seem like a bunch of inventions rather than discoveries. Closer to steam engines, airplanes, lens-grinding, word processors and spreadsheets than to physics.

The history of physical computers is a list of increasingly capable “bicycles for the mind” as Jobs put it. But my list of 10 conceptual advances above, along with their instrumental realizations (involving physical computers as well as other technologies), is more like a list of “telescopes for the soul.” Ways to peer into the computational heart of reality, via the data it presents to our senses, both natural and technologically extended.

It is much easier to see the discovery-like aspect of the other nine items on the list, where the temptation to anthropomorphic projection is much lower, and the phenomenology seems closer to physics and mathematics. By the time you get to quantum computing, you get people arguing that it _is_ in fact an alternative, more-correct way of thinking about physics itself (the digital physics crowd).

I’m listing the low-level mechanisms (asymmetric cryptography over “blockchains” and deep learning mechanisms such as attention and backpropagation over “LLMs” and “LMMs”) because they seem closer to what physicists call _intensive_ properties like density and conductivity, rather than _extensive_ properties like mass or volume. In general, the former tend to be more fundamental in “normal” regimes of physics. When you get to singularities like blackholes, extensive properties start to matter.

This is one reason it is tempting (but in my view misguided) to look for “singularity” phenomena in computation. We might well encounter singularity phenomena as computational power aggregates in specific high-density ways, but to identify such phenomena with the emergence of “superintelligence” (an anthropomorphic extrapolation of the self-important conceits of a particular lump of organic matter) is about as coherent as calling a black hole “God.” That’s incidentally a common trope in science fiction and cosmic horror that is fun for about 10 seconds, but doesn’t really add up or go anywhere interesting (I personally find it vaguely insulting to blackholes to identify them with our primitive notions of divinity).

So we’ve discovered something about computational reality; _seen_ bits of it we were never able to see before. Specifically, parts of it that can be found in human natural language and image/video data that has accumulated online.

What can we say about what we’ve seen so far, and about what we might expect to see as our “telescopes” and “cameras” for peering into large datasets get better?

## What Sort of Discovery Is This?

With AI, we’re not constructing artificial intelligences so much as we’re discovering the nature of natural intelligence; the only variety we can “see” unaided, and learning to see it in other piles of data besides the accumulated output of our own brains.

To begin with, what even _is_ the discovery that is modern AI?

That “attention is all you need”? That everything is matrix multiplication all the way down? Stochastic parrots and monkeys at typewriters all the way down? That token streams from sufficiently compressed and digested training data sets are indistinguishable from personhood signals? That reality has a [“distributed semantics”](https://www.businessinsider.com/ted-underwood-ai-optimist-humanities-language-literature-research-bill-gates-2023-12) to it? Maybe it’s all of the above. A set of discoveries that we have yet to assemble into a meaningful picture of the whole. It will take time. After all, it took a long time to go from apples falling on Newton’s head and overheating canons to classical physics.

What _sort_ of discovery is modern AI?

Is it like a new continent with a geography to be uncovered? A set of laws of physics whose basic equations and associated symmetries need to be formulated and grokked? A theorem whose proof needs to be discovered? A kind of [artificial time](https://studio.ribbonfarm.com/p/superhistory-not-superintelligence) like I argued a few years ago?

If it is a physics-like discovery of a universal phenomena, should we be looking for fundamental laws, symmetries, and conservation principles?

If it is a more mathematical sort of discovery, should we be looking for new mathematical constants and strange new Godelesque theorems buried in the training log files?

If it is something like a new continent, should we be making maps, infecting the natives with smallpox, and building roads?

I think there’s a little bit of all of these reference categories to it.

A comparison to fractals and computability is useful here. In both those cases, once the basic phenomenon was uncovered, we began seeing it everywhere. Fractals went from a few “charismatic” fractals like the Mandelbrot set, discovered by iterating a suspiciously simple equation, to something we saw all over the place, from the coastline of Norway to histories of stock prices. Along the way, we discovered eerie fixed points like [Feigenbaum’s constant](https://en.wikipedia.org/wiki/Feigenbaum_constants) buried in the depths of chaoplexity.

Similarly, computability went from a single thought experiment about a contraption attached to an infinite tape drive (the canonical Universal Turing Machine), to a characterization of certain mathematical structures, to a “Turing completeness” property we learned to spot in everything from cellular automata to trading card games, to something fundamental to the nature of numbers, like primality, complete with mathematical constants ([Chaitin’s omega](https://en.wikipedia.org/wiki/Chaitin%27s_constant)).

Now, it’s hard to look around and spot things that _don’t_ have fractal structure or computability aspects. We don’t have similar theorization of the phenomenon being uncovered by modern AI yet, but when we do, I think we’ll similarly find an unexpectedly sharp-edged property of reality that we will start seeing everywhere. We already _suspect_ it is everywhere, from swarms of insects and birds to ecosystems to weather patterns. We just don’t know how to rigorously think about it yet, or where the secret matrix multiplications are going on.

A more recent member of my list above is in the same boat as modern AI, in being insufficiently theorized and characterized as the discovery it is. Blockchains were probably the discovery of the last decade, but it’s _still_ tempting to think of them as specific sorts of machines invented for and by a particular, somewhat annoying tribe of enthusiasts. They too seemed like inventions at first, but now Merkle trees and asymmetric cryptography seem to be sprouting up all over the place in complicated configurations that somehow seem very natural. We’re only just beginning to understand blockchainy things as [a kind of “hardness” property](https://stark.mirror.xyz/n2UpRqwdf7yjuiPKVICPpGoUNeDhlWxGqjulrlpyYi0) of computational reality.

There is a common human tendency here incidentally. When we discover scary new things, we try to think of them as inventions first because inventions seem to embody a contingent optionality and afford us more agency than discoveries. It _feels_ like we don’t have to use them if we don’t like them, and that we have some sort of god-like creator-agency over their very existence.

This is an illusion of course, but at least we _have_ a reassuring illusion when it comes to inventions.

A discovery, on the other hand, cannot be undiscovered. You cannot unsee an aspect of the universe that you’ve suddenly learned to see (and that has learned to see _you_). There isn’t even the solace of an illusion of agency.

Everything on my list of 10 conceptual advances is a discovery. Each is or will be traumatizing to all humans who think they’re better than parrots.

None of it is going away.

## Tricking Rocks

I’m convinced there’s something scientifically much deeper going on under all ten items on my list.

The line (not sure where it originated; [possibly here](https://twitter.com/daisyowl/status/841802094361235456?lang=en)) that computers are “rocks we tricked into thinking with lightning” gets at the spirit of what’s going on. “Rocks that can think” is not something you’d have expected a few hundred years ago. Folklore features magic stones, but I am not aware of any rocks that can think in any legendarium.

The answer to the koan, “does the rock have Buddha nature?” is apparently just a straightforward _yes,_ not an inscrutable _mu._ You just have to subject the rock to the right conditions and it realizes the four noble truths and discovers the eightfold path and so on.

The trolls in Terry Pratchett’s Discworld novels turn this idea into a clever narrative premise. Under normal conditions, they are dumb as rocks, and literally a kind of minimally sentient rock. But if they are cooled to freezing temperatures, they get smarter and smarter until they turn into transcendent super-intelligences. Discworld trolls have buddha-nature below a certain temperature. This property of trolls plays a part in a few Discworld plots (I suspect Pratchett was thinking of supercomputers of the 80s and 90s, which were mostly associated in people’s minds with bone-chilling air conditioning).

While lithography is a more complex transformation process than simple cooling, there’s a deep thought lurking there. “Tricking” rocks with suspiciously simple physical/chemical processes and structural patterns (compared to CPUs, GPUs and AI accelerator chips have remarkably simple physical layouts; more like crystal structure patterns than complicated machinery) doesn’t seem like it should be enough to spark “thinking” but apparently it is.

So in 2023, we discovered that “intelligence,” far from being the culmination of an evolutionary ascent construed in linear terms, is simply a natural phenomenon that can emerge in more than one way through relatively simple transformations of matter. And is unreasonably more capable than the mechanisms (_in vivo_ or _in silico_ neural networks, backpropagation, matrix multiplication) it takes to trigger it. Just as the generator function of the Mandebrot set (_z²_+_c_) seems far too simple to produce the rich geometries that emerge from it, the engineering nuts and bolts of modern AI seem far too simple for what we get from them. You only have to compare them to the ingenious complexity of GOFAI contraptions (which take vastly more code to build, and deal with vastly less data) to see this.

It is important to note that the “far too simple” does _not_ extend to one key aspect: data. It is becoming increasingly clear that modern AIs are _only_ as smart as their training data. You want more intelligence, you have to put in more data. You want more complicated intelligence, you have to put in more complicated data.

The specific mechanisms of digesting that data into models don’t seem to matter beyond a point (a Twitter thread I saw argued that the differences among bleeding-edge LxMs are differences among the training data sets, not the minor implementation details or training protocol secret sauces). We might even be getting to some sort of dataset-bounded ceiling: perhaps LxMs are _exactly_ as smart as their training data conceivably could be, or a small delta away from that ceiling.

This is depressing (or reassuring) to those inclined to think of modern AI as a _processing_ superpower; a god-like _capability_ to acquire and keeps increasing in power indefinitely, via “inductive generalization,” past the limits of its training data.

But to me, it is actually kinda exciting that “intelligence” appears to be a latent property of data, which can be transformed into an explicit property, rather than an attribute of a processing technology.

If “intelligence” is really a property of _data_ put through particular suspiciously simple grinding and compressing processes, then the nature of “intelligence” tells us things about the nature of the universe itself. Specifically, the parts of the universe the data is from/about. You can think of turning that process towards datasets that are _radically_ different from the corpus of human language and imagery we’ve been focused on so far, and discovering amazing things.

We’re already doing things like decoding whale song with AI, or figuring out molecular structures of all proteins. But why stop with datasets that induce languages with “grammars” that can be rendered legible to us? Could you make a “Large Solar Flares and Sunspots Model” (LSFASM) and learn to talk to the Sun and ask it where it might flare up next? How about a Large Oceanic Model that allows ships to talk to ocean currents? Or a Large History Model that works as a Prime Radiant for Asimovian psychohistory? Maybe a Large Climate Model constructed out of weather data can talk to us and supply strategies for climate change?

Once you see intelligence as something embodied by particular pile of _data_ rather than a particular kind of _processing,_ a very powerful sort of decentering of anthropocentric conceits happens; a Copernican consciousness shift gets triggered. _You are no more than the sum of data you’ve experienced._ A big memory with a small shell script aside. And once you get over the trauma of that realization, you realize something even bigger: _any_ pile of data that has some coherence in its source can be turned into an intelligence that you can relate to, broadening the possibilities of your own existence.

## “Intelligence” as a Measure of Data

We’re at a very early stage here, but basically, _any_ sufficiently large data set can apparently be digested into a characteristically unique lump of “intelligence.”

I might even go out on a limb and suggest that perhaps an “intelligence” is merely an optimal (in some sense) hash of a pile of data that locates it in “dataset-space.” If so, we’ve just come up with a very idiosyncratic notion of intelligence that is a _measure_ of a data set rather than something to _be_ measured. Or even a metric in a metric space of datasets. There are exciting possibilities for topologists here (and for those who like my unpopular philosophy of [divergentism](https://www.ribbonfarm.com/2022/02/23/divergentism/), which fits this view neatly).

Maybe we’ll even come up with “intelligence” based measures of data, similar to mass or entropy, and get away from the tiresome attachment to psychometric understandings of what’s going on, like “IQ.” It seems idiotically not-even-wrong to think in terms of the “IQ of an LSFASM”). But the idea of replacing “bytes” or “compressed bytes” of data or the “Kolmogorov complexity” of an algorithm/input-class with a measure of data based on the kind of AI that can be constructed from it…? _That_ seems very tantalizing.

We’re already starting to think in terms of number of parameters (like “7 billion”) in a model, but let’s do the obvious perception refactoring here.

When you hear a phrase like a “7B parameter model,” 7 billion parameters is _a_ measure of the _dataset,_ not the _model_. You obviously couldn’t train such a model out of, say, a text of 50 words (well you could, but it would be highly informationally degenerate). And if you gave the training protocol 100 internets worth of data, 7B parameters may not be enough to hold a meaningful measure of it. So “7B parameter model” should be interpreted similarly to “6 foot tape measure.” The model can measure datasets in a particular range, with a measure we think of as “intelligence.”

There’s something very interesting lurking down this metrological path that not enough people seem to be thinking about. AI as a measure of data opens up far more fascinating possibilities than AI as a thing to be measured.

One reason it is hard is, once again, our tendency to mistake discoveries for inventions, or equivalently, cameras for engines. Instruments of discovery measure more than they are measured. Yes, there are a number of ways you can measure a telescope (mirror diameter or focal length for example), but the interesting measuring going on is what the telescope is doing to what it’s turned towards (the analogy to AI here is perhaps to things like floating-point precision — that’s closer to mirror diameter).

This can be hard to see, because the way ML researchers talk, it looks like they’re “doing” and “building” like you would with an invention, rather than exploring and mapping like you would with a discovery. But the thousands of refinements and tricks being reported week after week should be treated like reports from expeditions on unknown continents. The phenomenology being uncovered is disproportionate relative to the creativity and imagination the individuals involved are putting into it. There is an “unreasonable effectiveness of matrix multiplication” type effect here.

I’ve been using scare quotes throughout because I’m more convinced than ever that “intelligence” is a not-even-wrong frame for all this rich phenomenology. I’ve [previously written](https://studio.ribbonfarm.com/p/superhistory-not-superintelligence) about thinking of it as artificial time, but that now seems off as well, though it’s at the right abstraction level — much lower than the abstraction level — the anthropocentric level of our own biological consciousness — that we are currently using. Even biomorphic (as a sort of weird animal intelligence) or exobiomorphic (“aliens among us”) seem too limiting.

To conceptualize “intelligence” correctly, we have to get to the bedrock of physics and mathematics.

“Intelligence” I think is a word like “phlogiston”or “ether” that reflects our conceptual inability to climb down the currently illegible abstraction hierarchy ladder that’s clearly buried here. A ladder that can take our ideas down to the level of things like space, time, and matter. A ladder whose first few rungs are just starting to become visible.

Let me take a shot at climbing down it.

## Information and Matter

My current view is that we’ve discovered a kind of natural universal memory phenomenon that’s a property of all matter, living and non-living. A natural tendency of _information_ to get tangled up with space, time, and matter that allows it to become experientially self-reporting. It’s weird to think of memory outside of the context of living beings that access it, but let’s run with the idea here.

Information is a _much_ more satisfying root word here than intelligence (I forgot where I read this very recently, in some newsletter perhaps or maybe someone mentioned it, but Shannon was originally after _intelligence_ in the loose sense when he landed on _information_ and blew this whole thing wide open).

How should we think of this entanglement?

A while back, I came up with an aphorism that I think is a promising starting point: _narratives tell archetypes how to evolve, archetypes tell narratives how to curve._ It is a snowclone of one of my favorite physics quotes, by J. A. Wheeler: _Spacetime tells matter how to move; matter tells spacetime how to curve_ (with additional inspiration from a Terry Pratchett line: _stories make minds and minds make stories_)_._

The entanglement of mass and space-time creates what we think of as _objective reality_. The entanglement of narratives and archetypes (or stories and minds) creates what we think of as _subjective reality_.

Perhaps there is an entanglement that creates a kind of reality that exists between the other two, bridging them? Something we can call _computational reality?_ Perhaps modern AI is allowing us to peer into this entanglement for the first time?

Here’s a formulation that perhaps defines computational reality. _Information tells matter how to connect across spacetime. Matter tells information how to persist through spacetime._

I have no idea if this is even a coherent statement; perhaps it is only a meaningless bit of mediocre poetry. But it feels like it exists at the right level of abstraction.

What we see when we point large arrays of GPUs at huge piles of data is the infinitely deep structure of this connectedness and persistence of information, within the spacetime-matter entanglement. We see the universe remembering its own past, and the potentialities in that past. A little slice of everything everywhere all at once that to the limited lump of matter that is you or me feels like the experience of “intelligence” evolving through “time.”

This thought also extends naturally to the past and future of our trajectory of discoveries. This gives me ideas for how to think about zero-knowledge proofs and quantum computing for example.

It also squares well with very practical lines of thought. An idea I heard somewhere recently,[7](#footnote-7) in the context of AI hardware design, suggests this is at least the right direction: _AI compute is memory plus networking._ It’s not “computing” as such, centered on CPUs the way I was taught in 80s/90s computer-science classes. It’s an arrangement of memory hierarchies for efficient data movement across a spatio-temporal substrate. “Computation” in the sense of processing operations is a relatively trivial element, and not the bottleneck. The bottleneck is memory bandwidth.

It’s a bit like what oncologists say about cancer: the problem isn’t destroying cancer cells, but delivering the chemicals or radiation or whatever to the right location. The problem isn’t multiplying bits of matrices. The problem is getting those bits to the right memory locations at the right time at the right speed.

These aren’t answers to any of the big questions about AI, but they are tantalizing pointers to the right questions. Questions based on the premise that we’re dealing with a discovery about the universe here, not an invention of ersatz brains; that we’re playing with the most powerful camera ever built, not an engine. One that should eventually alter our perception and understanding of both objective and subjective realities.

## Sentimental Self-Interest

I want to close with the seed of a thought, as yet very incomplete, about how humans fit into all this. I’ve repeatedly brought up the importance of embodiment and “depth of field” in perceiving reality (see [Beyond Hyperanthropomorphism](https://studio.ribbonfarm.com/p/beyond-hyperanthropomorphism)). That’s my point of departure for what I’m thinking now.

I’m starting to think that the importance of being human lies in having a particular sort of “caring field” in space/time/matter. We can define what humans care about in almost a mechanical way, as a kind of ball in spacetime that contains a pile of matter embodying local interests, and a network of connectedness to other bits of matter elsewhere in spacetime. Caring patterns define an overlay on computational reality that we experience as a sentimental self-interest. A solipsistic escaped reality, or subjectivity, that exists on top of the lower layers of objective and computational realities.

With apologies to Descartes: We care therefore we are.

The interesting question now is, how can we continue to do that, now that we’ve discovered how to see computational realities that we cannot unsee. Can we still care? Can we still be?

Heading into 2024, that’s one of many questions in my head.

[1](#footnote-anchor-1)

“Deep learning” overemphasizes a particular tributary path to the current state, and a quality of “deepness” that seems more poetic than fundamental. “Machine learning” overemphasizes the machine-like aspect which I think is highly misleading. AI, I think, has been reified into sufficient meaningless that we can just use it without worrying about the inclusion of the word “intelligence” with all its unresolved philosophical baggage.

[2](#footnote-anchor-2)

By which I mean not just the formal study of P/NP questions, but also empirical computational complexity, the study of phase transitions in hard problems, and the parametrization of problems to discover hard and easy regimes. This field, which is curiously obscure even among computer scientists, establishes fascinating parallels between physics phenomena like freezing and melting, and computational phenomena.

[3](#footnote-anchor-3)

In which I include a constellation of mechanisms like public-key encryption, Merkle trees, cryptographic hashes and identifiers, and various other derived constructs.

[4](#footnote-anchor-4)

By which I mean the nuts and bolts, such as backpropagation, attention, self-attention, convolution, and so on, loosely unified by a common foundation of low-precision matrix multiplication

[5](#footnote-anchor-5)

Coming soon to the Computational Extended Universe, a universe of weirdness unlocked by zero-knowledge proof technologies.

[6](#footnote-anchor-6)

While aspects of GOFAI, like theorem proving and automated planing, seem like a kind of applied discrete mathematics and formal logic, fundamentally GOFAI seems like a product-invention activity rather than a research or discovery activity. That it is historically one of the parents of deep learning seems almost like a meaningless accident at this point. Any causal continuity is mostly cosmetic.

[7](#footnote-anchor-7)

Or possibly made up myself. It’s in my Roam notes without attribution. Memories get diffused over spacetime and matter when you’re constantly talking about something to lots of people and reading about it too.

