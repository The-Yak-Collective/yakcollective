---
title: The Puzzle of the Permaweird
date: 2023-04-28 21:37:07.000000000 Z
layout: post-external
original_link: https://studio.ribbonfarm.com/p/the-puzzle-of-the-permaweird
author: 100041
---

My favorite video games have always been puzzles aimed at mediocre people. I mostly play on the iPad; some favorites include Tetris, Two Dots, The Room series, Bejeweled, and most recently a game called Flow, which requires you to connect pairs of colored dots on a grid. It’s basically gamified circuit layout/PCB design. Here is a series of 6 snapshots of a 10x10 example.

[![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F96a863bf-cd85-4658-be41-71e4f5d77f01_1024x768.png)](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F96a863bf-cd85-4658-be41-71e4f5d77f01_1024x768.png)

The nice thing about Flow is that though it’s a closed domain game, the rules are not arbitrary. They are a natural artifact of the topology of a plane and the laws of geometry. As far as I can tell, the only slightly arbitrary thing is that the puzzles are designed to have a unique right solution, and fully occupy the grid (I’ve been unable to reverse engineer the conditions that enable this, I think having _n_+1 pairs on an _n_x_n_ grid has something to do with it). The puzzle is hard but not super-hard. Initially I struggled with the larger grids, but I soon realized that one simple rule solves mostly solves most puzzles: _recursively connect dots along unblocked boundaries._ In the image above, in the second snapshot, the dark red pair is an example. Some puzzles can be solved entirely using just that rule, since each time you connect a pair, you reshape the interior boundary in a way that makes it applicable to more pairs. In snapshot 3, you can see this recursion in progress for the orange dot pair, and once that’s done, the rule will apply to the white pair.

When the rule isn’t enough by itself, other heuristics help. To get to snapshot 3, I had to apply my imperfect heuristic of trying to create relatively disjoint islands before the boundary rule kicks in again. There are a few other heuristics, which progressively mop up all puzzles, and for the tougher puzzles, I’d say about 20% of the connections require an intuitive leap (at least if you want to avoid a brute-force search).

This sort of puzzle is very relaxing and pleasant once you’ve mastered the basic problem-solving principles. It neither degenerates into mechanical and boring perfect solvability like tic-tac-toe, nor is it uniformly frustrating.

This sort of puzzle is a great metaphor for life when the world is a finite-game mode. There is a boundary, and a set of reliable rules and heuristics of decreasing generality and leverage that allow you to “solve” life. The first 20% of “easy” rules often solve 50% of the problem (get an education, eat healthy, save money), which means everyone can get to a relatively high baseline, and the remaining 80% of trickier rules get you to maybe 80%, And then there’s 20% room for intuition and creative seeing/thinking.

And most importantly, you _know_ when you have solved the puzzle. The win conditions are clear, and the win conditions for everyone together make up the logic of how the world works.

These puzzles can also be thought of as “fill in” puzzles, where you have a frame and you fill it in with pieces. As you do so, the frame itself shrinks, generally leaving you with smaller and simpler problems to solve if you make no mistakes, and when you’re done, the picture is complete.

Some of the other games I mentioned stress this logic in various ways. Tetris is never-ending and incompletely solvable. Two Dots adds various other stressful dynamics. Bejeweled has a subtractive logic rather than an additive logic. The Room adds narrative color and artistic variety to the puzzle pieces. But essentially, these are framed, fill-in puzzle games with solutions. They are finite games.

But sometimes, there is no frame and no solution.

Sometimes the world is in an interregnum, or liminal passage, between finite-game epochs, and you have to deal with the raw, unframed, unpaved infinite game, where the goal is to continue the game rather than to win. If humans are fundamentally a gaming species, _Homo ludens_ as Huizenga named us, this condition is the gaming equivalent of a wilderness.

Such interregnums seem to have 3 phases.

- In Phase 1, the old finite game is breaking down; it’s very traumatic and you have to scramble to survive and harvest value from it before it breaks down completely.

- In Phase 2, there is no finite game at all, and it’s all very vibey and atemporal. Everyone gets very angsty, even people not normally given to anomie.

- In Phase 3, a new finite game is booting up, but is not clearly defined. There are dynamics and rules of varying levels of clarity, but no clear boundaries or win conditions defined.

Arguably the last decade maps to this scheme. 2013-15 was Phase 1, 2016-20 (what I call the [Great Weirding](https://studio.ribbonfarm.com/p/the-great-weirding)) was Phase 2, and 2021-23 is Phase 3.

Phase 3 is perhaps best represented by a different kind of puzzle, one you may have seen me [post about elsewhere](https://www.ribbonfarm.com/2023/03/30/tessellations-for-the-end-of-history/): aperiodic tessellations.

Recently, in a major breakthrough, mathematicians discovered the “hat” class of aperiodic monotiles — a single shape that (along with its mirror image), tiles the plane aperiodically (ie there are no repeating patterns, in a precise mathematical sense). The previous best was 2 shapes, and before that it used to be 6.

I printed myself a set (red and green for the mirror images) and have been playing with them recently. Unlike Flow and other puzzles I normally play, this is a game with rules and heuristics (much more difficult) but with no frames or win conditions. All you can do is extend the tiling in all directions — and since it is aperiodic, by definition there will be no true repeating patterns. Only vague fractal resonances. They are unframed, fill-out puzzles.

[![](https://substackcdn.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe60cec01-b2c2-49bd-bad1-00a041f2ada9_4032x3024.jpeg)](https://substackcdn.com/image/fetch/f_auto,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fe60cec01-b2c2-49bd-bad1-00a041f2ada9_4032x3024.jpeg)

It is rather appropriate that this tile was discovered in 2023, because navigating 2023 definitely feels like playing this puzzle (since you can’t “solve” it as such, only continue to play it; but it is still puzzle-like).

The world of 2023 is full of puzzle pieces that seem to fit together in ways that make sense locally, but don’t create pictures where larger patterns are immediately obvious. There is logic to the developing tessellation, and ways you can be “wrong” (you can get the tiles into a dead-end condition with an obviously unpluggable hole), but no clear way to be “right.”

There are only a few _types_ of pieces though. Maybe even just one. There is an argument to be made that AI is the aperiodic monotile of 2023. It is getting into everything. AI is starting to retile the world.

If you buy my evolving thesis that crypto is in some ways the evil twin of AI, you could say it’s the mirror image, and it’s kinda nicely symbolic that it’s in recession right now. That would be a nice and clean metaphor, but I don’t think it’s that clean. AI and crypto are not exact mirror images, and there are a few other types of pieces on the table. Here’s my list of 2023 aperiodic tile types:

1. AI

2. Crypto (almost the anti-AI)

3. Climate

4. Covid

5. Chips

6. Inflation (maybe)

Note that each is a _type._ The actual pieces are the local manifestations of each. The “climate puzzle piece” here in Los Angeles is not the same as the one in say Beijing.

Inflation is a _maybe_ for me as a fundamental puzzle piece because even though the end of the zero-interest era has been a profound thing (I just unpaywalled the [Truth in Inconvenience](https://studio.ribbonfarm.com/p/truth-in-inconvenience) essay where I riffed about it), I’m not sure this new high-interest economy is any different from historical high-interest eras. One reason to think it might be is that this is the first time in 70 years when Moore’s Law seems suddenly unreliable, and the low/zero interest rate recent past was, I believe, driven by it.

Be that as it may, there are between 5 and 6 fundamental types of puzzle pieces that are forming strange new aperiodic tessellations, following a logic that is scrutable at small scale, but inscrutable at larger scales. The pieces come in different quantities. AI seems to be spawning dozens of pieces. Crypto is in a mild winter but is also spawning dozens of pieces.

The other four types occur in fewer but larger pieces — unlike AI and crypto, they are not “retail” parts of the collective puzzle that all can participate in. Watching those pieces fall into place is a spectator sport for most of us. You and I are not going to set up a fab, tweak interest rates, or create a carbon tax.

So we have 8 billion people playing an aperiodic tessellation game with 6 new types of pieces. Well maybe not 8 billion yet, but it’s going to get that massively multi-player within a few years, even though it’s an elite game right now.

This is the Permaweird Puzzle. We don’t know exactly what the game is, but we have the game pieces, some of the rules of how to play, and some sense of right and wrong moves, at least locally. We know how to continue the game even if we don’t know how to win it. And we’re filling-out rather than filling-in the board. The boundary is expanding rather than shrinking.

This thought has me reflecting on my activities so far this year. It feels like what I’ve been doing is playing my corner of the Permaweird Puzzle. I’ve been thinking about and working with all 6 classes of pieces, though I haven’t been writing about all of them.

This isn’t a roundup post, but it does feel like the newsletter this year has been a partial view of my little corner of permaweird puzzle solving. This is the sixteenth post of the year, and over the past 15 posts, it feels like I’ve been switching back and forth with trying to fit some pieces together and trying to pull back and examine the larger emerging logic.

Obviously one effect of this is that my frames of the last few years, partly represented in the serialized projects of this newsletter, have started to break. I’ve already identified a major piece of surgery[1](#footnote-1) I need to do on my [Clockless Clock](https://studio.ribbonfarm.com/p/the-clockless-clock) book project for example, based on my developing thinking around protocols. My [Graph Minds Notebook](https://studio.ribbonfarm.com/p/graph-minds-notebook) series clearly needs serious refactoring in light of what’s going on with the AI thread of [Mediocre Computing](https://studio.ribbonfarm.com/p/mediocre-computing), which might require the two to be merged. The relationship between the [Great Weirding](https://studio.ribbonfarm.com/p/the-great-weirding) series and the [After Westphalia](https://studio.ribbonfarm.com/p/after-westphalia) series. I’m _trying_ to resist the hedgehog impulse to make a grand unified theory of everything since that is not my way. But while the world today is not, and never is, in a One Big Thing mode, it is also not in an an atomized, foxy, Many Things mode. There is an entangled set of Some Medium Things co-evolving here.

So if you’ll indulge me a bit, I’d like to look back a bit and try to make sense of the state of play as it appears on my corner of the game board that’s filling out in this newsletter.

I began this year in zoomed-out mode, with a rather self-absorbed and languorous series of essays reflecting on why the year seemed off to a slow start, which I concluded with my January 27 issue [Contours of Thawing Time](https://studio.ribbonfarm.com/p/contours-of-thawing-time), in which I declared (sort of wishfully, by fiat) that we were starting to shake off the ennui of the last few years, and getting moving again. The end of the liminal passage was in sight:

> I’m pleased with the three essays I’ve written so far — [Logics of Caring](https://studio.ribbonfarm.com/p/logics-of-caring), [The Permaweird](https://studio.ribbonfarm.com/p/the-permaweird), and [Disturbed Realities](https://studio.ribbonfarm.com/p/disturbed-realities). I still don’t know what 2023 is going to be about, but I think these three essays successfully circle whatever it is. I could be entirely wrong, but I have a feeling the year will continue to unfold languorously. I suspect there is not going to be an attention-cornering shock-and-awe event (major war, insurrection, pandemic…) forcing the pace of the year. But the things that _do_ get going will not be shallow dramas that thrash about confusedly for a few years before subsiding. They will be deep, subterranean movements with clear momentum that unfold over a very long time, like decades or centuries, coloring more superficial events in systematic ways. The last time a January felt this way was probably 2002.

After one more post in this vein ([Economic Reveries](https://studio.ribbonfarm.com/p/economic-reveries), Feb 3), I zoomed in for the next 8 issues (Feb 10 to April 8 in the [archives](https://studio.ribbonfarm.com/archive)) onto the most obvious sign of renewed subterranean movement, the AI explosion, which began last year and returned with renewed vigor after a winter hiatus. Some of those posts slotted neatly into my Mediocre Computing series, others spilled messily out.

As of two weeks ago, I feel like I’m back in the somewhat languorous zoomed out mood of January. While history is definitely moving again, it is definitely not doing so with the kind of legibility that allows you to become unconscious of your sense of it at a this-is-water level, and simply live in flow like it is 2012. I wrote about this last week in [History After History](https://studio.ribbonfarm.com/p/history-after-history).

The thing about solving the permaweird puzzle is that you cannot really get into a sort of pleasant, unconscious flow doing it, as rules become evident, linger briefly in awareness, and turn into muscle memory.

This is a puzzle that never lets you forget that you’re solving it, or allow any level of processing, from tactile manipulation of individual pieces, to gestalt sense of game-board, to retreat from awareness. There are no tactical wins punctuating the series of games, or clear level-ups to different levels of the game. There is only one endless zen-mode infinite game, with a smooth, step-less gradation in fractally self-similar levels, and unsatisfying pauses between sequences of moves.

It is a kind of low-grade stressful condition, but not as bad as the liminal stillness of Phase 2, or the traumatic destruction of Phase 1. Things are moving, there is a game afoot. There are new rules to learn. There is a developing sense of right and wrong.

There just isn’t a way to _win_ yet.

[1](#footnote-anchor-1)

For those of you following that, I’ve decided to rename the 4th layer of the temporality stack in [Operating in Time](https://studio.ribbonfarm.com/p/operating-in-time) the Protocol Level. It was previously called the Fork Level. The name change accompanies a substantive change in how I think that level works, which affects the whole throughline argument of the book, which means at least a slight rewrite of all the completed chapters.

