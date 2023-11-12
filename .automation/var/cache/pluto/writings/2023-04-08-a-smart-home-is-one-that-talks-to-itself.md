---
title: A smart home is one that talks to itself
date: 2023-04-08 04:27:38.000000000 Z
layout: post-external
original_link: https://uxdesign.cc/a-smart-home-is-one-that-talks-to-itself-58bb9222d893?source=rss-ba6349c9c628------2
author: 100006
---

#### How might we employ animistic design and LLMs to make a more helpful smart home?

![Image created by the generative AI DALL-E with the prompt “smart home device digital art robot vacuum that looks like a dog cleaning up a living room with a toddler walking around.”](https://cdn-images-1.medium.com/max/1024/0*M_bY5TESIEJOjb8h)
_Source: DALL-E_

Large language models (LLMs) are now able to simulate human writing and conversation. They can generate text, images, and many other modalities with increasing capability.

Could this technology be paired with the smart home to finally build context-aware [communal computing devices](https://www.oreilly.com/radar/communal-computing/)? We could potentially fix many of the problems with special cases that exist within our lives and just start communicating our intent rather than messing with a million apps.

[Josh.ai](https://www.josh.ai/) is looking to integrate such context-aware conversational agents (specifically ChatGPT) with the smart home as a single entity, operated by a centralized service:

[https://medium.com/media/b0243d9aa857813890759a704b51a937/href](https://medium.com/media/b0243d9aa857813890759a704b51a937/href)

But we need to go further.

These are still single points of control and mostly focused on quick answers. I’d like us to push to think about how LLMs’ capabilities could be used to translate from any context to any context, including ecosystems of devices.

### Animism and AI

At its most simplistic, [animism](https://en.wikipedia.org/wiki/Animism) is the idea that there are spirits inside everything: rocks, animals, and smart home devices. And these spirits act the way you’d expect them to. It provides an easier way for us humans to relate to something because we are constantly trying to find signs of other humans (which is why [we see faces everywhere](https://en.wikipedia.org/wiki/Pareidolia)).

If you want to get a full understanding of animisms, how it could be applied to technology, and a workshop that I did to test this out at [SXSW](https://schedule.sxsw.com/2022/events/PP119472) then go to my previous article on this topic:

[How does the Roomba really feel about dog poop?!](https://uxdesign.cc/how-does-the-roomba-really-feel-about-dog-poop-c590bcfb8834)

(This part-workshop, part-performance art also was [shortlisted for the Interaction 2023 awards](https://awards.ixda.org/blog/2023/discover-our-2023-interaction-awards-shortlist/)!)

### Not everything should talk

![Scene from the movie Beauty and the Beast from “Be our guest” musical number where the clock, plates, napkins, and tea pot are all singing while champaigne sprayed everywhere.](https://cdn-images-1.medium.com/max/720/0*SNweibX2_yjTpoxp)
_Source: Angela Lansbury in Beauty and the Beast (1991)_

In many idealized smart home visions, everything could talk to you. That sounds horrible.

Imagine you lived in a real world home that was modeled after [Beauty and the Beast](https://www.youtube.com/watch?v=0gzKRGcmnFs&ab_channel=Disney%C2%A1Fan%21). Your door welcomes you home, then your home assistant does, your [laundry tells you it is almost done](https://www.samsung.com/us/support/answer/ANS00082522/), your [microwave tells you it is 30 seconds away](https://www.reddit.com/r/SmartThings/comments/vqm87k/getting_4_notifications_for_every_event_on_oven/), your [trash can needs a new credit card to keep operating](https://twitter.com/internetofshit/status/1616506150471741440), your [BBQ says it needs an update](https://twitter.com/HardPass4/status/1463886150171566084), your fridge says that it [has been opened too many times](https://screenrant.com/lgs-smart-fridge-guilt-trip-email-feedback-twitter/), and so on. All with different voices, accents, and some even sing to complete the “immersion” with the appliances.

All of these devices are made by different groups that all want to vie for your attention. Notifications are perceived as the lifeblood for device attention by product and marketing teams. That, they believe, should lead to more engagement and eventual top-of-mind-ness to buy another one with the same brand. If we can “make the number go up” we are successful as a business, no matter whether that number makes the whole house less livable.

With animistic design, it may not make sense for every device to talk. A lamp should probably be able to _receive_ instructions from you (or a light switch), but it wouldn’t necessarily be appropriate for a lamp to _talk back_ since it doesn’t have a mouth. It would probably be more appropriate for it to turn itself on or off, adjust the brightness, flicker, or change colors though to communicate.

Multiply this by every device (or every possible device-to-device communication), and things get complicated fast.

### Poking your head into the smart home chat

What is most interesting to me is the mechanism by which all of these devices would communicate. This could be a shared channel for all of them to talk, tag each other, share information, and generally create better rules to service the humans in the house. A recent paper, [Socratic Models: Composing Zero-Shot Multimodal Reasoning with Language](https://socraticmodels.github.io/), considers how different types of models could transfer information via regular human text. Text becomes the protocol between models (and with humans).

If I said that whenever a member of the household walks into a room the lights should turn on, that would make a lot of sense. But what if it is really late at night? Or what if there is a baby napping in that room? These are special cases that won’t fit nicely within most apps’ routines today.

If you wanted to understand what rules and exceptions were currently at play, you would have to parse an interface that is focused on regular rules rather than everything that could possibly happen in the home. Consider:

![Screen for the VeSync app for setting schedules, timers, and away behavior for smart home devices.](https://cdn-images-1.medium.com/max/392/0*LwmFBdk-KagV0B0t)
_Source: VeSync app_

Not to pick on [VeSync](https://www.vesync.com/) in particular (I have a lot of their devices!) but you wouldn’t be able to get these exceptions handled in this type of interface. Even if you could start to put them there it would quickly get unwieldy to manage the list.

For this interface how might we add exceptions for “when I’m home” or “when it is already bright out” or “when someone is already sleeping in the room?”

> Building [communal computing devices requires you to understand more context](https://www.oreilly.com/radar/a-way-forward-with-communal-computing/) than is possible to collect in a rigid interface.

Giving text (or verbal) commands and requests for explanation make much more sense. Especially when they are related to harder to define concepts like “when someone is already sleeping.” LLMs are starting to be able to pull in the potential context as it is linked to symbolic understanding of what it is like to describe someone else already sleeping in a room.

When something goes wrong you shouldn’t have to launch a specialty app to figure out what is going on. You should instead be able to jump into the household chat channel and ask what happened. If the wrong context was considered, give the right feedback so that the entire ecosystem of devices could adjust their behaviors. Then we can also have them coordinate with each other. But you shouldn’t have to listen to all of the chatter going on between devices all the time.

![Hypothetical chat app where different devices are chatting with each other about what they are doing to help the household. They are talking about how turning on the light automatically wasn’t great for the baby napping. And they talk about how a package was just delivered and notifying the person in the house. The message about the be sent is related to the family going on a vacation.](https://cdn-images-1.medium.com/max/814/1*DBiSiI9JtTnNMCGeH_PQHg.png)
_Prototype by the author_

Animistic design allows for devices to act the way we would expect them to (e.g., a video doorbell is welcoming to the people that live there) and even disagree about what is best in certain circumstances (e.g., letting in a familiar face during a dinner party automatically).

Where could this go wrong? Many, many ways. Could a brand take an adversarial approach to make other brand devices look bad in the eyes of the household? Could edge services conspire against a household if they aren’t doing what is collectively beneficial to a particular brand? Or what about runaway effects when [multiple agents start some type of out of control cycle](https://www.wired.com/2011/04/amazon-flies-24-million/) akin to an [ant mill](https://en.wikipedia.org/wiki/Ant_mill) or [flash crash](https://en.wikipedia.org/wiki/2010_flash_crash)?

This may point to a need for households to have better control of the devices themselves. There will probably be limits in the autonomy that is akin to social media tools that fight disinformation.

### The future of smart homes is animistic

I’m excited by these new modalities for devices that can help figure things out agent-to-agent. Longer term we will consider how animistic design may help with these very specific and contextual needs.

What is still left to explore is the “identity” of those inside the home (who is recognized), how that works with federated learning (private and local data), and what is the “identity” of each of the devices.

Special thanks to [Q McCallum](https://qethanm.cc/) for providing early feedback on this post and the suggestions of ways I should trust my devices even less in these scenarios.

### Appendix: Animistic smart home prototype on Replit

During a recent [Replit x LangChain x Hugging Face AI Hack Night](https://lu.ma/AIhacknight) I pulled together a conceptual project using LLMs to give more intuitive and helpful personalities to smart home devices. If you aren’t familiar with [LangChain](https://python.langchain.com/en/latest/index.html) it is a really compelling project that allows different LLM agents to interact with each other.

For the hackathon I started with a [single Langchain agent template](https://replit.com/@IroncladDev/LangChainjs-LLM-Template) that could be asked questions or given commands. Here is a snippet of the prompt injection to get the system started:

> Pretend you are a smart home that contains many smart devices. Your goal is to provide a comfortable, safe, and efficient place for a family to live.

> There are multiple rooms in the home that have many smart home devices. They each have a name.

> You will talk on behalf of the different smart devices in the home. If possible you will use the device names.

> When responding to a smart device please include the emotions that they are feeling while they perform different actions and respond to different actions by the humans in the house.

However, we would need to create a separate agent (with prompt injection) for each agent and create their own [LangChain agent](https://python.langchain.com/en/latest/modules/agents.html). Then we would have to decide how we route messages through these LangChain agents. Right now, only linear, one way, chains are allowed which we may want to construct based on the agent receiving the event then ranked based on proximity (e.g. the video doorbell would send the message to the door lock and then the hallway).

In the future, there would be a need for a graph of devices that could talk to each other which could either be everyone (hub and spoke) or proximity (those that can shout to each other).

In addition, we might want to consider whether a loop like [AutoGPT](https://github.com/Torantulino/Auto-GPT) (or the even more recent [babyagi](https://github.com/yoheinakajima/babyagi)) would be the right way to create a “clock” for interactions between devices going forward.

Either way there is still a lot of work to do.

Check out the Replit and [feel free to fork it](https://replit.com/@ChrisButler7/Hackathon-Replit-x-LangChain-x-Hugging-Face) if you want to try it out yourself.

Happy smart home hacking.

 ![](https://medium.com/_/stat?event=post.clientViewed&referrerSource=full_rss&postId=58bb9222d893)
* * *

[A smart home is one that talks to itself](https://uxdesign.cc/a-smart-home-is-one-that-talks-to-itself-58bb9222d893) was originally published in [UX Collective](https://uxdesign.cc) on Medium, where people are continuing the conversation by highlighting and responding to this story.

