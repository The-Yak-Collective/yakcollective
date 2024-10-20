---
layout: post-external
title: |
  Creative challenges with Alyssa X
date: 2020-06-29 02:42:00 +0000
author: 100071
original_link: https://nesslabs.com/alyssa-x-interview?utm_source=rss&utm_medium=rss&utm_campaign=alyssa-x-interview
---

Welcome to a new edition of our [interview series](https://nesslabs.com/tag/interviews), where we meet with prolific creators and go behind the scenes to understand their creative process. [Alyssa X](https://twitter.com/alyssaxuu) is an incredibly talented designer, full-stack developer, and entrepreneur. Beside her full-time job at Metal, she launched many creative experiments. Her [portfolio of projects](https://alyssax.com/) includes a design tool to create animated mockups directly in the browser, a JavaScript library to build flowcharts, a game engine in Figma to get non-coders into game development, and a CMS for Google Sheets.

Alyssa’s Flowy is a top flowcharting library on GitHub, with 6.7K stars and multiple companies implementing it in their products. Her Figma to Slides plugin is used by startups all around the world to build pitch decks, and by public speakers to create beautiful presentations. What makes her portfolio even more impressive is her age: Alyssa is only 19 years old.

Many people aspire to launch successful side projects while doing great at their full-time job. This is exactly what Alyssa has achieved. In this interview, we discussed coming up with original ideas by combining different themes, staying motivated when working on challenging projects, using social media in a thoughtful manner, the benefits of remote work, how you can use no-code tools for side projects, and much more. Have a great read!

**Hi Alyssa, thanks so much for joining us! You are a prolific creator—and that’s an understatement. How do you generate ideas to work on?**

Thanks for having me! I could say I am a very creative person who comes up with ideas all the time, but that wouldn’t really be truthful. I have my own techniques to come up with ideas for projects to build, but they can still lead to months of tedious exploratory work without a single solid idea for me to work on. 

One of the ways I like to go about it is trying to combine two different themes together. For example, game development and design led me to work on a no-code Figma platforming engine.

Another way is to just think of a tedious task I regularly do that I could simplify, such as creating videos for Twitter and Dribbble, which led me to create [Animockup](https://animockup.com/). It’s a web-based design tool to create animated mockups within different devices, which can be customized by adding text and images through a fully interactive canvas, and then exported as a video or GIF to post on social media or other platforms. 

Sometimes I come up with good ideas, but I decide not to pursue them. There’s a variety of factors that go into deciding what I want to work on. For instance, how long it’s going to take, what new things will I learn by working on it, and whether it’s something that could be considered complex. An ideal project for me would be intellectually and creatively challenging, something to solve an issue and make an impact.

**I’m also a huge fan of** [**combinational creativity**](https://nesslabs.com/combinational-creativity) **. You have quite a few impressive projects under your belt. What was the most challenging project you built so far?**

Animockup was probably one of the most challenging projects I built to date. The project was really ambitious from the start, with a high degree of complexity, but it wasn’t something I hadn’t done before. In fact, I had originally created a fully fledged motion graphics editor a few months earlier, with a lot of similarities (an interactive canvas, video and GIF export…), which due to its scale and versatility, required a long timeline. Because I didn’t want to wait that long to release a product, I created Animockup, using parts of the engine for the motion graphics editor, and as a proof of concept.

**Animockup is such a great product—it’s beautifully designed and incredibly easy to use. What did you find particularly challenging when building it?**

Two main aspects of the product were challenging: The canvas, and the video renderer. For the first one, I had to learn a new Javascript library called Fabric.js, which basically turns a HTML5 Canvas into an interactive one, where objects can be moved, resized, rotated, and more. While that made a lot of what I wanted to do easy, I still had to figure out how to get videos to be displayed within the canvas, and even more, to be shown inside a device mockup, cropped and sized accordingly. Aside from that, I also had to create some editing controls for the objects in the canvas, for example, a small pop up for text to edit its properties which had to programmatically follow said element and attach a new font, color, or style to it.

The rendering aspect was also incredibly difficult, but to a whole other level. I had researched ways to record the canvas without much luck, with libraries that did very specific things or only exported in WEBM format, which was limited to the browser only. I didn’t want to release a tool that could only export in a rather obscure video format, so I did some more digging. Eventually I found a very powerful framework called FFMPEG which could do just about anything in terms of video, but it required a server to run, which I wasn’t interested in as I was going to release the product for free and it would be unsustainable. Thankfully I managed to find a port of the framework for Javascript, which could be used client-side. My idea was to use this library to get the WEBM file and convert it to MP4 and GIF, which I thought would be simple enough, but it definitely took a long time to figure out, and almost became too much of a blocker for me to continue pursuing the project.

**That sounds like a lot of work. How did you manage to keep yourself motivated?**

It was hard, but I had planned it well beforehand. I usually don’t work on a project unless I’m sure I’m going to be able to finish it, not just in terms of workload, but also in terms of personal goals. More often than not it’s the latter rather than the former which makes me drop a project entirely, I just need to make sure it’s something that is worthwhile for me to keep pursuing, and that will make me satisfied when it’s completed, so I spent a great deal of time writing it down in a Notion file.

Despite the good planning though, the project took me around four months, most of which I spent on the video rendering aspect, which was definitely very complicated. I was sometimes taking long breaks spanning multiple days or even weeks just to clear my head. I also had other things going on, like my full-time job, a surgery, and other small experiments of mine.

Whenever I was able to work on the project though, I dedicated the whole day to it. I find it very hard to work on something for an hour or two, so my sessions are often long, and I usually get a lot done during these—in fact the initial prototype was built in just one week.

**I’d love to hear more about your planning process… One of your projects includes Flowy, a library to create beautiful flowcharts—which I think lots of people who are into planning, productivity, and project management software would find interesting. How do you go about managing your projects?**

I think being organized is an important thing. I’m not a particularly orderly person, but I value my time, and I know that without good planning I will end up wasting a lot of time going back and forth. Usually for my projects, when I get an idea, I grab a notebook and start writing things down and sketching to fuel my creativity. It can be messy, but it really helps me solidify the project concept and not have features scattered all over the place. It’s important to understand what the core of the product is in order to build a MVP. 

When I’ve defined the concept for the product, I make a Notion file with a simple tagline for the project to help me stay focused, and a list of tasks to be done for an initial prototype, just to ensure the project is doable on a bigger scale. At the same time I list my motivations for the project, which will help me stay on track and decide whether it’s really something to invest a certain amount of time towards. Through this I can usually put something together in a week or two, which I then usually share with my friends via Telegram, or through communities I am a part of, like [Women Make](https://womenmake.com/). This step helps me validate the idea, decide on a better direction, or just gather their thoughts. 

**Using online communities to get feedback is a great way to validate an idea indeed. Talking about online communities, you currently work remotely. What do you think about remote work?**

I’m a fan. Working remotely definitely gives me a lot of flexibility, and allows me to organize the time in my own way, as well as creating the right environment for me to be more productive and focused. I think in that way it makes me more efficient, and it certainly helps for my mental health, although to be honest I have never worked in-person, so I wouldn’t know if that would be better. I would assume collaboration, despite the great number of tools out there to foment it—such as Figma, InVision, and Notion—is better done in person just because it’s easier to communicate in person than through a screen.

I’m definitely interested in working in person at least once in my life, since I believe I need that experience to see what I would like the most. But so far I have only seen benefits to remote work and it makes my life so much easier, even though it can feel a bit isolating at times. I have seen some companies take a more mixed approach, or do yearly retreats to get everyone together in the same place, which might be helpful.

**I agree working remotely is amazing, but can feel lonely at times. What about social media, does it help? You seem to be very thoughtful with the way you use Twitter.**

I barely use social media, as I don’t think it’s really beneficial for me and would make me less productive. I prefer sharing my personal life directly with my friends rather than post about it in the open, so I mostly just use it in a professional manner to showcase my work and connect with others. Twitter in particular I treat it almost as a portfolio, where every tweet is a different product, since that way it’s easier to promote them and for people to discover them, so I barely follow any people, just friends to see what they’re up to, and other people I look up to for inspiration. 

Using it in that way exclusively definitely has its benefits—I have made a lot of connections with people in the design, development, and entrepreneurship circles, and some of them have even become great friends of mine. It’s also led to a lot of opportunities from all sorts of startups and big companies who wanted to hire me or even acquire some of my projects.

One remarkable opportunity I got through Twitter was flying to the US for the first time in my life and meeting Evan Spiegel, the CEO and founder of Snap. I also got my current job at Metal through a single tweet I posted which went viral.

**Those are amazing opportunities! Before we leave you, what would be one piece of advice you would give to someone who wants to start working on side projects but doesn’t know where to start?**

The reason a lot of people don’t start side projects is they don’t know how to use a programming language, they’re scared to commit, or they think it will be too hard. To people who don’t know how to use a programming language, you can still work on a side project! Nowadays there’s lots of no-code tools like Airtable, GlideApps, Webflow, and more which you can use to create websites and apps of all kinds. There’s also great resources to learn how to code, for example Codecademy, which has very interactive and easy to follow courses.

Being scared to start a project is normal, especially if you’ve never done anything like it before and you worry it might be too difficult. My advice for your first project would be to start small, and if you’re worried you might get stuck, you can try working on a project like a todo app, since there’s lots of tutorials you can look for to help you finish it. Challenging yourself and stepping out of your comfort zone is a great way to get better at making things, so if you have an original idea you’d love to make, I’d say go for it. I’ve personally gotten better at coding and making projects by doing exactly that, so you definitely don’t need to know everything before getting started.

**Thank you! If you want to learn more about Alyssa’s creative journey, follow her on** [**Twitter**](https://twitter.com/alyssaxuu) **or** [**Medium**](https://medium.com/@alyssax) **.**

The post [Creative challenges with Alyssa X](https://nesslabs.com/alyssa-x-interview) appeared first on [Ness Labs](https://nesslabs.com).
