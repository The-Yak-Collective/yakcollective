---
layout: post-external
title: |
  JavaScript plugins for Roam Research [[roam/js]]
date: 2020-12-02 01:37:00 +0000
author: 100071
original_link: https://nesslabs.com/roam-research-javascript-plugins?utm_source=rss&utm_medium=rss&utm_campaign=roam-research-javascript-plugins
---

One of the reasons why advanced users enjoy [Roam Research](https://nesslabs.com/roam-research) so much is metaprogramming—the ability to modify Roam’s behaviour inside Roam itself, without ever touching its source code. By using JavaScript blocks via the roam/js feature, you can add new customise your experience.

The good news is: you don’t need to be a programmer yourself to enjoy some of the added benefits these little bits of extra code have to offer. Fellow Roam users have generously made many such improvements public. Akin to plugins, you can install these JavaScript “mods” in a few clicks.

To use any of these, create a page called `roam/js`. Every time you want to install a new JavaScript plugin, create a parent block with the following: <!-- {% raw %} -->`{{[[roam/js]]}}`<!-- {% endraw %} --> – this will add an important warning so you are reminded to be careful with any code (especially third-party code) you add to your Roam database.

![Roam Research: roam/js JavaScript plugins warning](https://nesslabs.com/wp-content/uploads/2020/12/roamjs-javascript-warning-roam-research.png)

Nested under the warning, add the JavaScript code for the plugin you wish to add. After reading the warning, click on “Yes, I know what I am doing”. Whenever you want to stop using a JavaScript plugin, click on “Stop this” in the corresponding parent block.

![Roam Research roam/js warning activated - Stop this button](https://nesslabs.com/wp-content/uploads/2020/12/roam-research-roamjs-javascript-warning-activated-stop-this.png)

Okay, now, let’s have a look at some of the most interesting plugins out there.

## Roam42

Live preview, jump to date, quick reference, and many useful shortcut keys such as opening the sidebar or moving to the top or bottom of a page—[Roam42](https://github.com/roamhacker/roam42) adds many quality of life improvements to Roam.

[INSTALL ROAM42](https://roamresearch.com/#/app/roamhacker/page/UeoxCm8rm)

## RoamJS

Ready for some more advanced features? [RoamJS](https://roamjs.com/) got it all: import the list of events on a given day from Google Calendar into your daily notes page; extract the text from an image and output it into Roam; define page synonyms for easier referencing; easily insert emojis; render charts; automatically import tweets related to a specific Roam page… And the list goes on.

![RoamJS JavaScript plugins installation via widget](https://nesslabs.com/wp-content/uploads/2020/12/roamjs-widget-roam-research-javascript-plugins.png)

RoamJS is a treasure trove of JavaScript plugins to install in Roam. It’s easy to get lost, but fear not: you can use the handy widget to generate the code for all the plugins you want to install in a couple of clicks.

[INSTALL ROAMJS](https://roamjs.com/docs)

## Other plugins

There are so many plugins out there, you are sure to find what you need. Here are a few more to try out.

- [roamjs-finance](https://github.com/andreynocap/roamjs-finance) displays the latest price for different cryptocurrencies
- [roam-dark-tweets.js](https://gist.github.com/brittlewis12/1b67a7557d1abe6e560948538b0f9bc6) renders embedded tweets using a dark theme.
- [roam\_breadcrumbs.js](https://www.reddit.com/r/RoamResearch/comments/hbxooe/playing_with_the_new_roamjs_made_a_feature_to/) displays breadcrumbs for recently visited pages along the top bar.
- [roam-live-preview.user.js](https://github.com/palashkaria/roam-modifiers/blob/master/roam-live-preview.user.js) shows a live preview of page references on hover.
- [filter-focus.js](https://gist.github.com/GitMurf/96d5904e171cacae4f4fd0e0d903fd02) lets you focus on the search box when opening a filter, so you don’t have to use your mouse.
- [roam-sidebar-toggle.js](https://gist.github.com/shodty/e4f718108b401a830b272da62ba6cfc3) creates a toggle button for the right sidebar in Roam.
- [copyPageName](https://roamresearch.com/#/app/CatoMinor-public/page/FhtBdGjOL) lets you press CTRL + Q when using the search bar. When you can select a page, the title will be copied into the search field.
- [sort-references](https://roam.davidvargas.me/extensions/sort-references/) adds an icon button to the user’s page that could be used to sort linked references
- [roam-random-page.js](https://forum.roamresearch.com/t/open-random-page-from-anywhere-in-roam-shift-click/1415) opens a random page from anywhere in Roam.

There are more JavaScript plugins for Roam being created every week. If you’re looking up more of them, be aware that they are sometimes called “extensions” or “addons”—I personally prefer to keep these terms for [browser extensions](https://nesslabs.com/browser-extensions-roam-research), but there’s no official name (yet?) for the `roam/js` snippets users add to customise their experience.

As with everything, don’t overdo it: only install what’s useful to improve your personal workflow, and make sure you trust the developer. The `roam/js` feature is powerful, and you know what they say about great power. It can sometimes be prudent to try a plugin on a test database before installing it on your main database. Have fun!

P.S. Interested in creating your own JavaScript plugins for Roam? [This](https://davidvargas.me/blog/how-to-create-your-own-roam-extensions/) is a great tutorial.  
P.P.S. Want more tips to make the most of Roam? [Explore the archive](https://nesslabs.com/tag/roam).

The post [JavaScript plugins for Roam Research [[roam/js]]](https://nesslabs.com/roam-research-javascript-plugins) appeared first on [Ness Labs](https://nesslabs.com).
