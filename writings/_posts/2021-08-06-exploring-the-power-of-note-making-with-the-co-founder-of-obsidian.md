---
layout: post-external
title: |
  Exploring the power of note-making with the co-founder of Obsidian
date: 2021-08-06 04:02:00 +0000
author: 100071
original_link: https://nesslabs.com/obsidian-featured-tool?utm_source=rss&utm_medium=rss&utm_campaign=obsidian-featured-tool
---

Welcome a new edition of our interviews with founders of tools for thought. Erica Xu co-founded [Obsidian](https://obsidian.md/) with Shida Li to help anyone build their personal knowledge base. Obsidian is local-first and plain text, and treats links as first-class citizens. Moreover, it’s incredibly extensible, with many plugins to make your personal knowledge base _truly_ personal.

In this interview, we talked about the power of customizing your note-taking environment, note-taking versus note-making, digital gardening as a way to produce content during the learning journey, building a community of note-takers, Obsidian’s upcoming mobile app, and much more. Enjoy the read!

![Obsidian - Mobile App Screenshots of Pages and Graph View](https://nesslabs.com/wp-content/uploads/2021/08/obsidian-screenshots-1-1024x576.png)

**Hi Erica, thanks so much for agreeing to this chat. First, how was the idea for Obsidian born?**

I have had the basic idea Obsidian for about 2 years before we started working on it. I thought I was just weird to long for a personal knowledge base app like this, but you won’t believe how many people told us they have tried or thought of doing the same thing for years or even decades (I couldn’t believe it either!).

During quarantine in 2020, we got really bored and finally started working on it. I made a list of boxes that must be checked by my holy grail note-taking app. That list gradually became Obsidian as it is today.

It was very much an experiment when we started. Like I said before, I still can’t believe there are people out there as crazy as me who have been thinking about the same thing for a decade. But I did get a little bit of confidence by seeing many personal note-taking and knowledge management posts regularly pop up on Hacker News, a social news site for programmers and entrepreneurs.

Mostly I was just trying to scratch a personal itch. I’m the kind of person who sets up a private MediaWiki instance just for myself. Also tried TiddlyWiki, but it didn’t really work out for me either. In a way, this verifies that no matter how weird you are, there might be millions out there who are just like you!

**I absolutely agree! Millions of potential users, but you are a small team of two (as well as two cats). How does that affect the way you work on Obsidian?**

It’s easier in some ways. We have worked together on various projects for almost 10 years. The biggest project is Dynalist, if you’ve heard of it. Having collaborated for so long, we know each other’s pace and work style. There are no long meetings or back-and-forth code reviews; we are just coding all day long.

The size of the team has been challenging at times as well. Since private beta, workload has been steadily increasing. I also had my first baby in June 2020, less than a month after Obsidian’s public launch.

Thankfully, since the early private beta we have formed a nice community, and through that Obsidian users have been helping each other out. Otherwise we’d need to spend all day just answering questions alone!

**Strength in community! Another key strength of Obsidian is its extensibility. Can you tell us why that was important to you?**

From a decade of trying various note-taking apps, I saw that I’m always dissatisfied with each of them. It’s usually in the details, the kind of thing that you _think_ wouldn’t be a deal-breaker, but you keep thinking to yourself “aww, I wish this feature worked like that instead.”

So when envisioning Obsidian, I inevitably thought about this problem. The extensibility of code editors inspired us — if I don’t like how Visual Studio Code looks or works, I can customize almost every aspect of it. Why can’t we do this to notes?

The idea of a plugin system was born. Not a hacky afterthought, but one that’s built into Obsidian from day one. In fact, most of the native features exist as plugins as well. We were testing our plugin system with the core features, and it gives the nice bonus to be able to turn them off if you don’t need them.

![Obsidian - Calendar Community Plugin](https://nesslabs.com/wp-content/uploads/2021/08/obsidian-screenshots-2-1024x576.png)

**What are some of the most popular plugins at the moment?**

I’m happy that we added sorting by download count so I can answer this quite easily! A quick check confirms my guess: [Calendar](https://github.com/liamcain/obsidian-calendar-plugin), [Advanced Tables](https://github.com/tgrosinger/advanced-tables-obsidian), [Sliding Panes](https://github.com/deathau/sliding-panes-obsidian), [Mind Map](https://github.com/lynchjames/obsidian-mind-map), and [Day Planner](https://github.com/lynchjames/obsidian-day-planner) are the top five plugins and are all very popular. They all have more than 10,000 downloads. They can all be downloaded via the community plugin store within Obsidian.

[Dataview](https://github.com/blacksmithgu/obsidian-dataview) is another plugin that I think has a lot of potential. It basically runs a query and displays Notion-like tables. Our users even started a [showcase thread](https://forum.obsidian.md/t/dataview-plugin-snippet-showcase/13673) for all the cool use cases of Dataview.

**A thriving community of users and contributors building plugins… How did you go about starting the community, and how do you keep community members engaged today?**

We have an active Discord chat server and also a forum. Starting in Discord is pretty much an accident —my partner has experience in gaming community moderation in the past with Discord, and it has nice features for moderation and permission management. So we decided to do the private beta through Discord, both to distribute the early alpha versions and to gather direct feedback from users. From there, the Discord community organically grew until today. As it got larger, we had to recruit a few helpful community members to be moderators.

The forum was built to solve a different problem. At first we used a Discord bot called “Carl the Turtle” to gather bug reports and feature suggestions. The user can just type a command, and Carl will post that suggestion to a special channel for users to vote for. Near the end of private beta, there were more than 1,000 suggestions. It became hard to search or discuss things, so we opened a forum based on Discourse.

The forum has gotten more and more active since. Although Discord is great, it’s not suitable for properly keeping track of things. Topics get lost and it’s nearly impossible to discuss things by replying to an old message. The forum shines in these areas though. I think they are a great match. Robert Haisfield recently did [an interview](https://robhaisfield.com/notes/building-community-in-obsidian-with-licat) with us about building a community, if you’d like to read more on that.

**Since you seem to interact a lot with your users, do you know what kind of work people do with Obsidian?**

We see so many use cases, it’s hard to generalize. We see lots of note-taking, but not the kind of note-taking that you do as you attend a meeting or read an article. I think “note-making” is probably a better name. Of course, there are also people who use Obsidian for specialized tasks, such as writing novels, world-building, doing Dungeon Mastering, or even producing music.

**Music production is an interesting use case. Were there any other surprising use cases you didn’t expect people to use Obsidian for?**

One user made [a storybook](https://github.com/StefanoCecere/BuboLibro_RegaloSpeciale/) with his child for a sibling, which was the cutest use case we’ve ever seen. Obsidian is surprisingly good for mastering Dungeons & Dragons games to keep track all the characters, locations, monsters, NPCs, etc. It’s also quite common for folks to use Obsidian for genealogy since people in the family are densely connected by nature.

**And how do you personally use Obsidian?**

I use Obsidian as my personal knowledge base, which includes my journal. I also keep two separate vaults: one for recipes and meal planning, another for genealogy.

**Obsidian is at the forefront of the digital gardening trend thanks to its Publish plugin, which lets users publish notes from their vault onto their website. What do you think of the concept of digital gardening?**

I think digital gardening is a great way to produce content on your way to learn. In contrast with traditional blogging, it’s less scary and has less friction. it doesn’t get outdated easily like a blog does, and you can make incremental changes instead of churning out blog posts every week.

One of the strengths of Obsidian Publish is being a natural extension of Obsidian. You’re already building a private digital garden in Obsidian, and Publish lets you easily open up part of that garden to the world.

Many of our users have commented on how seamless the process is — there’s no exporting and uploading needed at all. You can also publish only part of your vault. Publishing doesn’t happen automatically either, so your work-in-progress drafts won’t be seen by anyone.

**You mention Andy Matuschak’s work on your website. Has he inspired any of the design choices you made when building Obsidian?**

Andy’s notes definitely inspired our core plugin Page Preview, although I think Wikipedia also popularized that, which is super helpful. [Death\_au](https://github.com/deathau), one of our moderators, created the Sliding Pane plugin which mimics the way Andy’s notes work. It’s been very popular in our community. Other than that, Andy’s work is highly regarded in our community. It really shows how succinct and effective a digital garden can be.

**I’m a big fan of his work as well. Now, let’s project ourselves a little bit… How do you envision the future of Obsidian?**

We have been pretty clear on what we want Obsidian to become in the future, and it hasn’t changed one bit: Obsidian is the IDE for thought. It’s a functional, extensible front-end for notes that you have total control over.

An IDE, or integrated development environment, is what programmers use to write code. It provides many advanced functionalities like code auto-completion, syntax highlighting, and refactoring. Although being super powerful, the great thing I love about it is that it works by opening a local folder of code files (basically plain text). 

There’s no need to upload my code anywhere: I don’t need the internet in order to work and I don’t need to worry about my code being seen by others. If I get tired of one IDE, I can just swap it for another one to open the same folder. It’s that simple.

IDEs are also extensible by design, probably because programmers always want to customize things for themselves and they have the technical know-how to do it too. Coincidentally this is also what we aim for with Obsidian.

One thing that makes Obsidian quite different from code IDEs is that people don’t usually write code on the go, whereas people do take and check notes on their phones and tablets. This is why we’re extremely excited to have released our mobile app!

**Amazing, can you tell us more about the mobile app?**

First of all, it’s available for everyone for free! It’s 100% free for personal use, but if you use it for commercial use, make sure to grab a commercial license. One commercial license will cover your usage on all devices.

We also had a fun little journey on our mobile app. Originally, we wanted to make a lightweight mobile app that acts as a companion of the desktop app. It lets you view your notes and do some quick capturing on the go, and that’s about it. However, our users have made sure to let us know that they don’t want a half-assed mobile app. If it can only view and capture notes, how is it any better than the existing Markdown editor apps?

Luckily, we were eventually convinced. And this begins our constant iterations to bring almost all desktop features to much smaller screens. Just counted—we did 15 mobile private beta releases over the 4 months, and that’s not including the countless internal iterations we did with our moderator team. This is in addition to the regular updates and fixes to the desktop app, thus the delay.

But the wait is over! The mobile app now supports:

- Customizable toolbar
- Pull down Quick Action
- Graph view
- Community plugins
- Themes
- Sidebar pinning for tablet
- iCloud vaults (on iOS)
- Share to Obsidian (on Android, coming to iOS soon)
- Pick any folder as vault (on Android)

We want to take the chance to thank our Catalyst members to test the app during the private beta and to provide financial support that helps make Obsidian sustainable. Special thanks to Nezlok from Ubisoft for supporting our mobile app project!

[![Menu, Quick Actions and Preview](https://nesslabs.com/wp-content/uploads/2021/08/obsidian-screenshots-3-1024x576.png)](https://nesslabs.com/wp-content/uploads/2021/08/obsidian-screenshots-3.png)

**Thank you so much! Where can people learn more?**

First of all, you can grab our shiny new mobile apps [here](https://obsidian.md/mobiley). We always welcome people who are interested in Obsidian to join [our community](https://obsidian.md/community). If you prefer chatting, we have a lively Discord community. Our forum is also quite active. And if you’d like to keep up with what’s new in Obsidian, follow our Twitter [@obsdmd](https://twitter.com/obsdmd). Lastly I want to give a shout-out to [all the people behind the Obsidian community](https://help.obsidian.md/Obsidian/Credits). You guys are the best!

The post [Exploring the power of note-making with the co-founder of Obsidian](https://nesslabs.com/obsidian-featured-tool) appeared first on [Ness Labs](https://nesslabs.com).
