---
layout: post-external
title: |
  Overview of Story Synth, my web platform for storytelling games
date: 2021-01-22 08:31:00 +0000
author: 100074
original_link: https://blog.randylubin.com/story-synth-overview
---

A few months back I launched Story Synth, a web platform for designing, playing, and sharing prompt-driven storytelling games. I’m loving how it’s shaping up and hope to continue expanding it for years to come. This post covers the past, present, and future of the platform.

![](/images/screen-shot-2021-01-22-at-8-58-21-am.png)

Quick links:

- [Story Synth](https://storysynth.org "Story Synth") - the platform
- [Story Synth Documentation](https://storysynth.org "https://storysynth.org") - the guides and documentation
- [Dawn of the Monster Invasion](https://storysynth.org) - my first game on the platform, a silly monster movie spoof
- [Around the Realm](https://storysynth.org/#/Games/Around-The-Realm/) - my second game on the platform, a fast paced fantasy travelogue

## The Goal

The goal for Story Synth is to make it as easy as possible for game designers to go from idea to playable game. Making a game is as simple as adding content to a Google Sheet and then sharing the link.

The platform already supports six different game formats, a variety of visual customizations, and a handful of functional extensions. I plan to keep enhancing the platform in many directions to enable more diverse forms of play.

## The Backstory

One side effect of pandemic social distancing is that it’s become difficult to quickly design and playtest games with friends. Pre-pandemic, I’d grab a stack of index cards, design a game the hour before a playtest, and adapt it on the fly as the game progressed. None of that was feasible with all the players being remote.

I’d looked into online tabletop tools like Roll20, Tabletopia, and Virtual Tabletop Simulator, but they all suffered from steep learning curves, tedious asset pipelines (getting content into the platform), and they optimized for much more complex games than I was envisioning (e.g. board games, games with miniatures on a map). With no good tool at hand, I decided to create my own platform, specifically geared toward lightweight prompt driven games.

![](/images/screen-shot-2021-01-22-at-8-56-54-am.png)

I built the Story Synth platform to initially support [Dawn of the Monster Invasion](https://storysynth.org), which became my [Golden Cobra](http://goldencobra.org/) submission. Soon after finishing the game, I launched the Story Synth platform to the public so that other designers could create games through it. The game + platform ended up winning the Golden Cobra prize for Best New Tool which was a nice honor!

![Image](https://pbs.twimg.com/media/Epn0UQ4VgAAcdSZ?format=jpg&name=medium)

Last month I launched a new game format and designed a game to accompany it. The format, Phases, enables games where you rotate through a series of decks, each with their own prompts. I made the game [Around the Realm](https://storysynth.org/#/Games/Around-The-Realm/) to show off its capabilities and am very happy with how it turned out.

## The Forever Project

Since launching the platform, I’ve been busy adding new formats and features. Developing Story Synth has a wonderful feedback loop where I’m inspired to make a game based on the platforms capabilities and then I add new capabilities because of features I want for my game.

My roadmap for the platform keeps growing and my guess is that I’ll be happy working on Story Synth and designing games with it for a very long time to come.

## How to Create a Game

Designers create new games by adding their content to a Google Sheet. There are [templates](https://docs.storysynth.org/guide/formats.html) available for a variety of game formats, most of which involve different ways of presenting prompts to the players (Ex: For the Queen, A Quiet Year).

![](/images/screen-shot-2021-01-22-at-9-09-09-am.png)

After crafting their game in the sheet, Designers can paste a link to that sheet into the Story Synth homepage. The app then uses the sheet data to automatically assemble the game.

![](/images/screen-shot-2021-01-22-at-9-10-41-am.png)

The designer then has access to a page for their game that lets them generate new sessions. The game page isn’t automatically shared anywhere but the designer can distribute the link as broadly as they like. When in a game session, everyone at the same URL sees the same content in realtime, which makes it easy to play online.

![](/images/screen-shot-2021-01-22-at-9-11-33-am.png)

From there, designers can iterate on their game as easily as updating their sheet and refreshing their webpage.

## Customizing a Game

There’s also plenty of room for game customization in both style and meta-data. By adding ‘option’ rows in the Google Sheet, designers can tweak the visual style of their game (with CSS). They can also add a cover image, game title, byline, blurb and other information about the game.

Further - the prompts themselves can contain HTML elements, which enable advanced game customization such as embedding images in the prompts or having different styles on different cards.

None of this advanced customization is necessary though - you can design games on Story Synth with zero coding at all.

## Formats

Story Synth currently has six game formats:

- Shuffled – a series of ordered prompts followed by shuffled prompts, can optionally use multiple sequential decks
- Timed – each player receives unique prompts at different times based on a shared stopwatch
- Secrets – each player receives a secret prompt each round
- Monster – a series of ordered prompts spread over rounds; some rounds have multiple prompts
- Slot Machine – a series of cards with randomized content, drawn from each of several lists
- Phases – the game rotates through a series of a phases, with each phase drawing from a corresponding deck

You can read more about them and grab their templates on the [Formats and Templates](https://docs.storysynth.org/guide/#available-formats-and-templates) page of the documentation.

## What’s Next

I’m going to keep adding new features, formats, extensions and more, likely prioritized based on the games that I want to make or that I hear other designers want to make.

I’m excited to get more designers designing and sharing games on Story Synth and I’d love to help out if you have any interest. Don’t hesitate to reach out if you have any questions, suggestions or feature requests!
