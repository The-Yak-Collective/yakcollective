---
layout: post-external
title: |
  Redefining knowledge management with Kevin Lin, founder of Dendron
date: 2021-12-09 07:56:00 +0000
author: 100071
original_link: https://nesslabs.com/dendron-featured-tool?utm_source=rss&utm_medium=rss&utm_campaign=dendron-featured-tool
---

Welcome to this edition of our Tools for Thought series, where we interview founders on a mission to help us think better and become more creative and productive. Kevin Lin is the founder of [Dendron](https://dendron.so/), a lightning fast, open source personal knowledge management tool that lives in your integrated development environment.

Dendron uses schemas and templates to help you quickly capture and connect your ideas, so you can progressively build your personal knowledge base. Kevin and his team do absolutely everything in Dendron, including managing all their websites and documentation!

In this interview, we talked about how to balance structure with flexibility in note-taking, the challenge of information overload, the power of daily journals for self-reflection, the importance of integrations in the personal knowledge management ecosystem, and much more. Enjoy the read!

[![Dendron Screen 1](https://nesslabs.com/wp-content/uploads/2021/12/1-dendron-screen-1024x576.png)](https://nesslabs.com/wp-content/uploads/2021/12/1-dendron-screen.png)

**Hi Kevin, thank you so much for agreeing to this interview. The term “personal knowledge management” was coined in the late 1990’s, and yet, it’s far from being a solved problem. How is Dendron approaching personal knowledge management?**

Most personal knowledge management (PKM) tools will readily help you create notes. They eventually hit a wall trying to retrieve them past a certain threshold. That threshold varies with the tool — 10, 1000, 10 000, virtually everything stops working past 10k notes unless the user was super diligent about organizing their knowledge. Past this threshold, entropy wins and every query becomes a keyword search and scrolling through pages of results.

We focus on helping humans organize, find, and work with any amount of knowledge. Dendron not only helps you create notes, but we also help you retrieve them, and we work as well with ten notes as we do with ten thousand. Dendron does this by extending basic markdown with custom structural elements to make it easier to organize at scale and provides powerful tooling on top to work with this structure.

A parallel to this approach is found in software: programmers write code using programming languages that have structural elements built-in, such as inheritance and types. They use integrated development environments (IDEs) that provide tools to work with that structure, for instance symbol lookup or refactoring. Adopting this paradigm, programmers can effectively work with large codebases like the Android Operating system which spans over 15 million lines of code.

Dendron builds on top of the past five decades of language design and developer tooling. We apply the key lessons from software to the management of general knowledge. We make managing general knowledge more like managing code, and your PKM more like an IDE for general knowledge.

In 1945, Vannevar Bush was an early pioneer in information science and the inspiration for our overall mission as a company: “We are overwhelmed with information and we don’t have the tools to properly index and filter through it. [The development of these tools, which] will give society access to and command over the inherited knowledge of the ages [should] be the first objective of our scientists.”

Our mission is to help humans take command over the inherited knowledge of the ages. Right now, we are presenting this in the form of an open-source, local-first, Markdown-based note-taking tool that helps humans organize, reference, and work with any amount of knowledge.

**Let’s dig a little bit deeper… Can you tell us more about schemas in Dendron?**

Schemas are one of the central elements in Dendron that help structure knowledge. Many programming languages let you define inheritance chains that describe the hierarchical relationship between programs. Schemas are like that: they define the hierarchical structure of your notes.

[![Dendron Screen 2](https://nesslabs.com/wp-content/uploads/2021/12/2-dendron-screen-1024x562.png)](https://nesslabs.com/wp-content/uploads/2021/12/2-dendron-screen.png)

Schemas are taxonomies that work over hierarchies. You can write a schema to describe a given hierarchy — projects, meetings, research topics — and attach templates to any node in the hierarchy.

In practice, this means that when you create a note, you can use schemas to provide a guide as to where the note should go and how the note itself should be structured. And when you’re looking for a note, you can find it quickly because everything is already organized according to the schemas you’ve defined. The schema is a single source of truth for the entire knowledge base, ensuring everything is consistently structured.

An analogy of why this is desirable is to think of the spreadsheet. The structure of tabular grids makes it easy to find and work with information within the cells. Similarly, the structure of having consistent hierarchies means that it is easy to look up and work with anything within the hierarchies.

**A big challenge for note takers is actually to balance structure with flexibility. How does Dendron address this challenge?**

On the surface, the two might seem at odds but dig deeper and you’ll find that they’re actually complementary. Dendron is both: it is well structured in form but highly flexible in definition.

[![](https://nesslabs.com/wp-content/uploads/2021/12/3-dendron-screen-1024x576.gif)](https://nesslabs.com/wp-content/uploads/2021/12/3-dendron-screen.gif)

We describe Dendron as taking a hierarchy-first approach to knowledge management. While we support other means of indexing such as tags, backlinks, block references, and search, the primary entry point for most queries ends up being hierarchy-driven.

Users of other note-taking tools often balk at this concept, the common counterpoint being that the real world is not constrained by hierarchy and that this approach isn’t flexible enough for what they want to do. These users argue for graphs and backlinks as a better primary model for managing knowledge.

A graph is indeed more flexible. If we were building a digital brain for computers to perfectly model the world, we would probably go with this approach. But we’re not building a tool for computers to capture every facet of the world, we’re building a tool to help humans make sense of it. The challenge we face as humans is information overload. There is too much of it and we need ways of constraining that complexity. Filtering large amounts of information into exponentially smaller subsets is what hierarchies are built for, and why they are the data structure for every database ever created.

With a hierarchy, you have one place where a note can be filed and a filtering process to help you find the right place to file. Compare this approach to tags where you’re never quite sure if you’ve applied the necessary tags and indeed which tag to even pick when you have a large number of them.

The traditional failings of past hierarchies are that they were too rigid. Most people’s experience with hierarchies are folder hierarchies that ossify from the moment that they are created. These hierarchies are hard to change and so people don’t change them, even as their underlying understanding of the domain has changed. It is because of this friction that most new tools focus on note creation without any predefined structure. This approach makes creating notes easy but finding notes hard.

Dendron has flexible hierarchies. They provide a structure for your notes but these structures can be easily changed. In programming, developers can refactor code and change its structure — the IDE will make sure that all references pointing to the original code are updated. In Dendron, you can refactor notes and hierarchies and Dendron will make sure that your PKM is consistent throughout. This means that you have the best of both worlds: a basic structure for the organization but the flexibility to change it.

**That sounds amazing. What advice would you give someone using Dendron for the very first time?**

[Loom Video for Daily Journal Workflow](https://www.loom.com/share/a5613de3e24640a6a07006ac82d82e74)

Our advice for new users is to start off with Dendron’s daily journal. This is very similar to the daily journal found in tools like Roam — we present it as a chronological hierarchy — and we provide built-in support for this use case. New users can use the daily journal as the initial structure for their thoughts. Depending on the day, some notes might start getting very long. When that happens, you can split up those notes by creating scratch notes.

Scratch notes are like Zettel’s from [Zettelkasten](https://nesslabs.com/how-to-take-smart-notes) — they allow you to capture an independent thread of thought and link to other related thoughts at a later point in time. You can refactor different sections of your daily journal notes into Zettel’s which in time, you might later refactor again into standalone hierarchies.

This workflow of splitting notes as they get big is what folks in Dendron call the amoeba pattern and it is our recommended way of getting started. With the amoeba pattern, you don’t have to force everything into a hierarchy and are free to discover them as they occur. What works well with this approach is that you get to have it all: frictionless creation of new knowledge through daily journals and zettels as well as being able to retrieve notes again later through well-defined hierarchies.

**Here at Ness Labs we are big fans of self-reflection. Can you tell us more about the daily journals?**

As mentioned earlier, daily journals are how most users get started. It becomes a natural place to add observations throughout the day — observations that can be refactored into Zettel’s which can then be linked together and then refactored into standalone hierarchies.

Every note in Dendron supports adding metadata in the note frontmatter, this is a part of the note separate from the markdown where users can add custom data. You can use this space to track your weight, habits, and anything else that might be of interest. This can be combined with another Dendron feature, pods, which let you transfer notes to and from Dendron. You can use pods to export just your daily journal notes to airtable and create a graph of your weight over time.

[![Dendron Git integration](https://nesslabs.com/wp-content/uploads/2021/12/4-dendron-screen-1024x561.png)](https://nesslabs.com/wp-content/uploads/2021/12/4-dendron-screen.png)

On the topic of reflection, Dendron’s Git integration makes it easy to see changes to notes over time. Git is used by programmers to track changes in code and has a rich set of tooling built for this use case. Everything in Dendron can be managed with git and we provide specific integrations to aid in this workflow.

**You also promise to make notes retrieval lightning fast. Can you tell us more?**

Fast retrieval means that even when you have over ten thousand notes, finding any particular note should take on the order of seconds. Normally, unless you know exactly where a note is, you’ll need to search for it and scan through multiple pages of results. In Dendron, because your notes are well structured, you can almost always look up the note you need by its hierarchy.

Finding notes by hierarchy is not the answer to all queries but it can be for most of them. For queries where it’s not, you can still use tags, backlinks, or raw text search to find what you’re looking for. These secondary mechanisms are even more useful with hierarchies, as you can scope your search to a particular part of your PKM.

[![Dendron 4](https://nesslabs.com/wp-content/uploads/2021/12/4-dendron-screen.gif)](https://nesslabs.com/wp-content/uploads/2021/12/4-dendron-screen.gif)

Something else that makes Dendron fast is developer-specific and I’ll add it here for completeness. Usually, when you’re working with a PKM, it means context switching to another application and waiting for a loading screen. Dendron stores all files locally and is integrated inside your IDE (currently VSCode). This means you never have to make a switch – in fact, you can even make links from the code to Dendron and vice versa and get Dendron’s structural functionalities like backlinks to augment your code.

**What are some other features you are particularly proud of?**

The first feature is the entire family of commands that Dendron uses to work with hierarchy. These are known as “lookup commands” and they provide a common interface for performing a common set of operations across notes in a hierarchy — find, create, refactor, etc.

Each of these commands can be further augmented with modifiers to do useful things such as extract selection to a new note, copy links from each note, or turn the selected line into a zettel link for a newly created note. The advantage of this design is that any lookup modifier we introduce can immediately be applied across a whole set of different commands.

Another feature I like to highlight is pods. Pods make Dendron interoperable with other tools. As ness lab readers, my guess is that you’re not just using a single PKM tool but rather, different ones for different use cases.

PKM isn’t one thing and I don’t think there will be one tool that does everything, or at least not well. Today, when I want to collaborate with someone, I will use google docs. When I work with tabular data, I like to use spreadsheets. Dendron is your single source of truth to organize and reference knowledge, pods help you make use of it even if the tool you’re using isn’t Dendron. Pods today support transferring data across many popular tools, and we’ll be introducing the capability for folks to write their own early 2022.

Finally, there’s publishing. Every Dendron workspace can also be published as a static website, hostable anywhere. Github pages and Netlify are common destinations. For notes that are hosted on Github, we generate an “Edit on Github” link so that others can suggest edits and contribute fixes. For instance, the Dendron site has had hundreds of corrections from our users based on this feature.

The Dendron client can be configured with the URL of your published site and has a command to create URLs to anything published. This means you don’t just get lightning-fast retrieval for anything inside Dendron locally but that you also get to share and collaborate on that knowledge with others.

Before moving on, I’m going to break the rules and add one more feature. This is not really a feature at all but more an ethos around “hackability”. By this, I mean the ability to customize and extend Dendron for whatever you need it to do. First, the code is open-source which means you are free to create your own functionality and modifications to the code.

We provide integration points across all of Dendron’s features: you can write custom JavaScript hooks to change how notes are created, and soon add custom traits to notes to change how the metadata is used and write your own pods to work with your notes across other tools.

[![](https://nesslabs.com/wp-content/uploads/2021/12/5-dendron-screen.gif)](https://nesslabs.com/wp-content/uploads/2021/12/5-dendron-screen.gif)

We even provide a command-line interface that lets you access most of Dendron’s functionality from the command line and are also planning on releasing a stable API in 2022 so that you can integrate Dendron in other applications and editors.

**This sounds like an incredibly powerful approach. What kind of people use Dendron?**

Dendron runs inside the IDE and most of our users are developers. Our developers have varying backgrounds. Some are solo founders, others are seasoned vets inside of FANG companies. A common usage pattern among developers is that they begin by using Dendron for personal notes, graduate to using it for work, and then share notes with other team members and get their whole team involved. Dendron lets you split notes across “vaults” — think of them as git-backed folders — which means your personal notes can be stored in the cloud, your work notes locally on your work computer, and your team notes in a private git repository.

While engineers make up our largest demographic, other sizable demographics include students, managers, and researchers. Students use Dendron for the ability to write with Markdown and Latex, managers like to use Dendron to manage todos and meetings, and researchers use Dendron to publish and collaborate on research with other faculty. We even have professional gamers that use Dendron to keep track of different character move sets across street fighter games.

**And how do you personally use Dendron?**

I live inside Dendron and use it extensively across my personal and professional life. If you are more video inclined, you can find the talk of me showcasing how I use Dendron [here](https://wiki.dendron.so/notes/fzHazEFWTpUVexmv.html#summary).

For personal use, my entire life and essentially everything I know is stored in Dendron, currently at over 30,000 notes. I keep a bullet journal to track tasks and priorities in my daily journal. I have a separate hierarchy for every software project and service I have ever used and use it as a local version of stack overflow to solve issues I’ve already encountered I have a separate hierarchy for each hobby that I’m actively engaged in — such as cooking and salsa dancing — and keep a separate journal on my progress within each hierarchy.

I use Dendron to track every person I know, every book I’ve read, and every interaction I’ve had. For some of the interaction notes, I use pods to sync the notes with Airtable so I see all the people I haven’t talked to in the past weeks and schedule a catch-up. My [personal blog](https://www.kevinslin.com/) is published using Dendron which contains a subset of my public notes.

For professional use, as the founder of Dendron, I — and the entire company — also use Dendron for everything. Our team is 9 people, globally distributed, spanning -8 UTC to +9 UTC. We have one 1-hour meeting every week where we do weekly planning but everything else happens async. The only reason this is possible is because of Dendron.

We use Dendron for task management, tracking issues from our roadmap, and on Github. Every issue on GitHub is synced with our Dendron workspace and updated from there. When discussing features, we often use scratch notes in Dendron which we can then link back to the original tasks so that the full history, including discussion points, is preserved.

Many times for these discussions, we will export it to Github so we can get community feedback as well. You can see an example [here](https://github.com/dendronhq/dendron/discussions/1665). Dendron has [user documentation](https://wiki.dendron.so/), [developer documentation](https://docs.dendron.so/), a [public handbook](http://handbook.dendron.so/) and a [blog](https://blog.dendron.so/). All of this is managed and published using Dendron. What’s nice is that all these different sites are all contained in a single workspace that the entire team has access to, which means that they remain easy to update and reference even as we add more content and sites.

**The fact that you and the team do absolutely everything in Dendron is a testament to its versatility. What’s next for Dendron?**

There are so many things that we want to build and that our community wants us to build that the hardest part about my job is to prioritize what we actually work on. Currently, we are focused on three things.

- **Simplifying the initial user experience.** Dendron has lots of features and it can be intimidating to new users, we’re working on making that initial onramp smoother and the UX around our core workflows.
- **Building out publishing.** The process still has too many steps, especially on the editing front. We’re working on improving this experience and building out a lightweight web client that non-developers can use as well.
- **Teams.** Our [beachhead](https://blog.dendron.so/notes/N9VxT7G5SovmncezBAGO2/) as a business is to be the knowledge base for technical teams. To that end, we are building out a managed backend that makes it easier to sync notes, manage permissions, and deliver on other enterprise features that our current team users are asking for.

**Thank you so much for your time, Kevin! Where can people learn more about Dendron and give it a try?**

[Here](https://link.dendron.so/6YDn) is the install link. People can learn more about Dendron via our [home page](https://dendron.so/) and our [newsletter](https://link.dendron.so/6YDc), or join our community on [Discord](https://link.dendron.so/6YDd), [Twitter](https://link.dendron.so/6YDe), or [Github](https://link.dendron.so/6YDf).

The post [Redefining knowledge management with Kevin Lin, founder of Dendron](https://nesslabs.com/dendron-featured-tool) appeared first on [Ness Labs](https://nesslabs.com).
