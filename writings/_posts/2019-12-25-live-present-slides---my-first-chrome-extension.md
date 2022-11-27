---
layout: post-external
title: Live Present Slides - my first Chrome Extension
date: 2019-12-25 00:00:00.000000000 Z
author: 100074
original_link: https://blog.randylubin.com/post/189866209658/live-present-slides-my-first-chrome-extension
---

I just published my first Chrome extension: [Live Present Slides](https://chrome.google.com/webstore/detail/live-present-slides/fgnaekpcnnenhhdnkidokjmogogjbkkm)

_Update: now [available for Firefox](https://addons.mozilla.org/en-US/firefox/addon/live-present-slides/)_

It solves a specific facilitation problem – how can you update Google Slides live without dropping out of Present mode?

I've run a handful of games where information is presented to the players via a Google Slide but player actions directly affect the data presented. For example: in a voting game, a slide might show live polling info that changes as the players take actions to influence voters.

The old solution was to have one tab open in Present mode and another in normal Edit mode. The tab in Present mode is on the big screen projector / TV and the Edit mode is used to update slides as data comes in (manually or through an embedded graph). However, Present mode uses snapshots of the slides and you need to exit and reenter Present to update. This is inelegant and if you forget to refresh, you’re showing old / bad data.

[Raph D’Amico](http://www.raphdamico.com/) came up with a brilliant work around for our run of Dungeon Court at the Roguelike Celebration. My laptop was driving the projector and showing the current court case and participants. He was busy onboarding the next case, generating their characters, and creating the next slide with their info. From an experience design perspective, we _really_ didn’t want to keep closing and reopening present mode.

His solution was to open Chrome’s inspector and manually delete the unneeded HTML elements (sidebar, menubar, rulers, etc). With those elements gone, the slide took up the entire screen; it looked like Present mode but live updated because it was still in Edit mode. Brilliant!

I’ve used that approach since but it’s a bit tedious to carry out. If for any reason you need to reopen the tab mid presentation, you definitely don’t want to re-delete those elements live on stage.

Hence the Chrome Extension – one click and it automatically removes the unwanted HTML elements. Then, just enter full screen and you’re good to go!
