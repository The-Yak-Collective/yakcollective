---
title: Bridging chaos and coordination with Cara Borenstein, co-founder of Stashpad
date: 2022-10-13 09:10:00.000000000 Z
layout: post-external
original_link: https://nesslabs.com/stashpad-featured-tool?utm_source=rss&utm_medium=rss&utm_campaign=stashpad-featured-tool
author: 100071
---

Welcome to this edition of our Tools for Thought series, where we interview founders on a mission to help us think faster and work better together. Cara Borenstein is the co-founder of [Stashpad](https://www.stashpad.com/?ref=ness_labs), a fast and easy-to-use notepad designed to help developers stay organized as they work without breaking their flow.

In this interview, we talked about the power of embracing messiness, how to use a daily brain-dump to set your intentions, how to practice graceful context switching, how to cultivate calm in an increasingly noisy and complex world, and much more. Enjoy the read!

[![Stashpad - Overview Screenshot](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-1-1024x603.png)](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-1.png)

**Hi Cara, thank you so much for agreeing to this interview. Before we start talking about Stashpad, let’s get a little philosophical. Lots of software is about structure and organization. Why do you think we’d do well to instead embrace messiness?**

It’s a great question! At Stashpad, we’re focused on how individual developers go about their day. The reality is that our daily experience can often be a bit messy. You plan projects, research solutions, debug issues, and brainstorm workarounds.

You need somewhere to stash things as you’re working so that you can make sense of it all and stay on top of things. Problem-solving is messy and involves various moving parts, and to navigate this effectively, you need a way to manage your working memory.

Cal Newport, the author of Deep Work, has talked about the value of having a messy space for your thoughts as part of your tooling. In fact, the scratchpad is his favorite productivity tool: “It’s a way to offload things out of your brain where you can still see them, look at them, organize and make sense of them, without having to keep all of these things in your mind at the same time.”

Our personal scratch notes should not be a place where we feel pressure to make them look beautiful and polished — that would only be an impediment to getting things down. It would create a high bar for what is acceptable, and would discourage us from capturing our thoughts in a raw form. The point of our scratch notes is to serve us as we’re going about our day — to help us keep track of things and make sense of things.

We like to parallel the scratchpad to RAM (Random Access Memory) on a computer. RAM is your working memory. It’s a cache of all the things that you need while you’re executing on a task. This is different from things that are on your hard drive (“disk”). Disk is your long-term storage. It’s where things go when you’re done working on them. We’ve found that too often, writing notes is assumed to mean writing a finished product to disk.

**But messiness can also mean interruptions, which makes it harder to get in the flow. How does Stashpad address this challenge?**

Step one is acknowledging that our day involves juggling different threads, and sometimes context-switching is inevitable. Our goal is to make capture as frictionless as possible, so that you’re not trying to keep too much in your head.

Whenever an idea comes up that you want to put away for later — whether someone mentioned something to you, you came across some new information, or it just popped into your head — it should be super easy to jot it down, and in such a way that you’ll be able to find it later. With Stashpad, you can jump to the right context in two keystrokes.

[![Stashpad Demo](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-2.gif)](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-2.gif)

Something comes up, and it’s not urgent enough to pre-empt what you’re doing, but it still may be worth revisiting later? Stash it. We’re not completely eliminating the context-switch — we’re trying to make it as quick and seamless as possible. The outcome is that you can get back to focusing on your Main Thing right away, and you’re also not dropping the ball later.

Stashing quick ideas as you’re going about your day is key to maintaining flow and momentum. If you don’t have a good way of doing this, you either get sidetracked wondering what to do with this idea that came up, or you try to stow it away in your mind — but it may very well continue to vaguely take up some of your attention and prevent you from fully focusing on what’s in front of you.

As Sophie Leroy, Associate Professor at the University of Washington Bothell School of Business, puts it: attention residue is “when our attention is focused on another task instead of being fully devoted to the current task at hand.” By getting things out of your head and into written form, you can reduce the chances that attention residue from one task will pollute your focus in your next task.

Another key to effective stashing is being able to easily retrieve what you stashed. Or, put another way, how can you quickly stash things without your stash devolving into complete chaos? If you think about the classic pen and paper approach to note-taking, this is where it can start to break down.

It can be convenient and enjoyable to jot things down on a piece of paper, but finding something you wrote down two weeks ago — or yesterday — or something you don’t remember when you thought of can get difficult. When it comes to retrieval and keeping things in order, it’s important to be able to flexibly compartmentalize your notes, jump between these compartments, and send things to the right place.

More generally, we’ve found that existing solutions tend to be either convenient for capture, but unable to handle complexity over time; _or_ they’re great at organizing, but too heavy and unapproachable to be your tool of choice for capture. We’re putting a lot of work into making Stashpad the best option for capturing thoughts and finding them later — so that you don’t get bogged down on either side of this process.

As humans, we’re “single core machines” — meaning we can focus on one thing at a time. But our day-to-day involves juggling multiple threads going on at the same time. Stashpad is designed to ease the tension between these two realities.

**When did you start tackling this challenge?**

We actually first started out on a somewhat different problem. Theo and I noticed at our respective engineering jobs that knowledge sharing between engineers often did not happen as smoothly as one would hope. And specifically, the team wiki, which was supposed to be where a lot of this knowledge sharing happened, often fell short when it came to supplying complete and up-to-date information. So in 2019, we set out to improve knowledge sharing in engineering organizations by building a more approachable wiki.

After working on this for a few months, we found that not very many people were interested in our new wiki. We ultimately realized that in people’s day-to-day workflows, their team’s wiki tool was not a major pain point. In fact, it wasn’t really a big part of their workflows at all.

We went back to the drawing board and asked around a hundred developers more detailed questions about how their knowledge management practices at work. And we found that 90% of them frequently used what we like to call a “barebones” notepad — something like Apple Notes, Notepad++, untitled text files, etc. And that occasionally, certain things would get transferred over from their notepad into collaborative tools like Slack, Jira, or Google Docs when they were worth sharing.

[![Notepad Windows](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-3-1024x640.png)](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-3.png)

That’s when we realized that, subtly, this barebones notepad plays a major role in how we do our work. And we noticed that many developers weren’t very pleased with their setup. The truth is that the notepad hasn’t seen much innovation in the last few decades. So we decided to build a better developer notepad. This was the summer of 2020.

**So, how does Stashpad work exactly?**

At the core of Stashpad is bytes and stacks. A byte is a short note. A stack is a kind of byte that can contain other bytes. Stacks let you structure your notes and add hierarchy in whatever way is useful to you.

[![Bytes and Stacks](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-4.gif)](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-4.gif)

Navigating around your notes quickly is key. To that end, you can open a stack in a tab, or expand a stack inline. You can pin a stack, and jump to a recent stack. You can search for a stack or for any note, with filters to help narrow your query. You can also capture notes to the right stack without needing to navigate to it. There’s a shortcut to pull up Stashpad from anywhere.

Home is your top-level stack. It is where you can create your first stacks. It’s also a good default “dumping ground” for notes when you’re not sure where they should go.

You can act on your notes. An advantage of jotting down short notes is your notes are more modular, making it easy to perform commands on specific bytes. Moving, deleting, re-arranging, formatting, copying to clipboard — these are all actions you can perform via the keyboard. You can access all of the available actions by hitting cmd/ctrl + K at any time in the app. In general, you can do anything in Stashpad from the keyboard. And of course, there’s markdown support and code syntax highlighting.

[![Stashpad - Syntax Highlighting](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-5.gif)](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-5.gif)

Soon, you’ll be able to customize the keyboard shortcuts to your liking. You’ll also be able to define flexible queries that will dynamically generate stacks with the relevant content. We will offer image support and other file attachments. There will be a mobile app with hosted sync. There will be a public API and hooks for getting content in and out of your Stashpad, as well as integrations with other popular tools.

**What kind of people use Stashpad?**

Software engineers at companies like AWS, Coinbase, and Twitter use Stashpad everyday to manage their notes and thoughts as they do their work. In particular, people who work on complex projects and who often have multiple threads of work going on at the same time benefit especially from a better working memory solution.

Before finding Stashpad, our users would often rely on a combination of untitled text files, Slack messages to themselves, and even pen and paper as a quick way to capture information as they were working. Some then paste some of this information into a more robust long-term knowledge store like Evernote and Notion.

Stashpad is at least as fast at capture as these simple options and it works better at handling complex workloads. Notes that are a starting point for more formal documents can then be transferred to a private or collaborative long-term knowledge store.

**And how do you personally use Stashpad?**

I like to start my day with a brain-dump where I can set my intentions for what’s most important to focus on that day. I’ll use cmd+N to jump into a new brain-dump and flood it with my ideas — similar to messaging myself. At the end, I have 2-3 todos that I’d like to get to and I move those into my todos stack. I keep todos pretty short and put any overflow into a stack called Other that’s nested within it. I review these todos with my co-founder to make sure we’re on the same page.

I do my brain-dump and re-organization without leaving my keyboard. One of my favorite commands is “local move.” To do a local move, I multi-select some bytes with my keyboard arrows (using shift+UpArrow) and then hit o to initiate a local move. Then I select my destination stack and hit enter.

[![Local Move](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-6.gif)](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-6.gif)

Next I have standup with my team. If anything comes up that I find interesting and would like to follow-up on or look into, I’ll jot them down as separate notes within the default location — Home. Each of my notes will be timestamped and I keep Home scoped to this week. If there’s anything extra important, I’ll highlight it by making it a certain color.

As I go about my day, I’ll jot down notes from any other meetings. I like to stay on the same screen when possible so that I can see recent context in-line. To stay on the same screen while taking quick notes on different domains, I use expanded stacks. I select a stack and hit enter, then I type a bunch of related notes under each other.

If someone shares a bullet list with me in Slack, I’ll paste it in and select “split to bytes” so that I can have it formatted and ready to take action on.

When I’m starting on a project, that’s when I’ll open a stack in a new focused tab. Some example stacks are:

- “User feedback 10/3” (This is where I group all the notable user feedback for this week and synthesize what we want to prioritize)
- Custom keybindings
- Undo project

[![Todos](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-7-1024x696.png)](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-7.png)

Some of my projects last a few days or a week. Some last a few weeks. For each of these projects I’ll create a new stack and open it in a tab by hitting cmd+N. Then I do a brain-dump of everything that might be related. I love Adam Savage’s[checklist approach](https://www.wired.com/story/adam-savage-lists-more-lists-power-checkboxes/) to projects and follow a pretty similar method. I pin my project stack so I can refer back to any notes, links, or questions easily. I’ll highlight any key points using colors.

**How do you recommend someone get started?**

If you go to[stashpad.com](http://stashpad.com/?ref=ness_labs), you’ll be able to download the app right away. It’s available on MacOS, Windows, and Linux.

Once you’re in, the best thing to start with is what’s top of mind for you that day. Jot down the couple of items as individual bytes within Home. Then, as you go about the day, keep adding in items that you’d like to get out of your head and be able to refer back to later.

**Are there any key principles developers should keep in mind to make the most of Stashpad?**  

Don’t think too hard when capturing notes — just get them down. Your personal notes are just that — they’re just for you. Don’t try to make them overly polished, or perfectly organized from the get-go. This will only disrupt your flow. When in doubt, just put them in Home. You can always come back and send them to the right place later if you’d like. Aim for iterative steps, not perfection.

We often hear about the[costs of context switching](https://www.loom.com/blog/cost-of-context-switching) — and no doubt, it’s worth our while to protect blocks of focus time when we can. However, there is some amount of context-switching that is unavoidable — and that is a good thing, because it means things like collaborating with teammates, responding to customer feedback, and generally working in a dynamic environment. 

So in addition to those blocks of focus time, we also want to think about how to navigate these necessary context switches gracefully. To this end, we have found practices like[status dumps](https://www.stashpad.com/blog/status-dumps-software-engineers) helpful for quickly clearing your mind and then being able to jump right back into the swing of things efficiently when the time comes.

[![Status Dumps](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-8-1024x696.png)](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-8.png)

At the risk of getting a little abstract, part of what drew us to the stingray as our logo is how it moves through the ocean. The ocean is a chaotic place, with lots going on in all directions. And the stingray moves nimbly and gracefully through it. This feels like an apt metaphor for the chaotic nature of our workday, and the ease with which we aspire to navigate it — and that is Stashpad’s mission to facilitate.

Learning a few keyboard shortcuts can have you flying around your notepad. But no need to learn everything right away — just a select few for the actions you do frequently go a long way. A couple to get started: cmd+E toggles whether you’re creating a byte or a stack. cmd+O is to jump to a stack. cmd+N jumps you into a new, unnamed stack that lives in Home. And of course, cmd+K is to pull up the list of all available actions. ? gives you the list of all the shortcuts.

[![Stashpad Commands](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-9-1024x685.png)](https://nesslabs.com/wp-content/uploads/2022/10/stashpad-image-9.png)

**And finally… What’s next for Stashpad?**

We’re just getting started! Soon, we’ll be introducing a mobile app and hosted sync. We’ll also be providing more and more ways to customize Stashpad and make it your own. We’re excited to make Stashpad extensible. Developers will be able to build their own automations on top of Stashpad and share them with others.

Ultimately, we see Stashpad becoming a control center for your work. It will enable you to pull in the information that you care about from all the different tools your team uses, and let you act on that information or send things out directly from your notepad. You’ll be able to kick off multi-step actions with a single keystroke.

As things get increasingly noisy and complex around us, we as individual developers need a calm space of our own to keep track of the things that matter to us. A tool that gives us the flexibility and power to tame the complexity we deal with on a daily basis and simplify our lives. That’s what we’re working towards at Stashpad!

**Thank you so much for your time, both of you! Where can people learn more about Stashpad?**

You can check us out at[stashpad.com](http://stashpad.com/?ref=ness_labs) and share any feedback and ideas on[twitter](https://twitter.com/stashpadapp) or in our[discord](https://discord.com/invite/ScxPxcN9fK).

The post [Bridging chaos and coordination with Cara Borenstein, co-founder of Stashpad](https://nesslabs.com/stashpad-featured-tool) appeared first on [Ness Labs](https://nesslabs.com).

